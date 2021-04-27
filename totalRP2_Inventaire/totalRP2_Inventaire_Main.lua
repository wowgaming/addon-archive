-------------------------------------------------------------------
--                          Total RP 2
--            A roleplay addon for World of Warcraft
-- Created by Sylvain "Telkostrasz" Cossement (up to version 1.017)
--   Licence : CC BY-NC-SA (http://creativecommons.org/licenses/)
-------------------------------------------------------------------

-- New v1011 item link feature
TRP2_CHATLINK_CACHE = {};

function TRP2_HandleItemLink(owner, itemName, chatFrame)
	if owner == TRP2_Joueur then
		if TRP2_CHATLINK_CACHE[itemName] then
			TRP2_ShowItemLink(TRP2_CHATLINK_CACHE[itemName]);
		end
	else
		-- Ask gently the owner for the item ID !
		TRP2_SecureSendAddonMessage("ILGT",itemName,owner);
	end
end

function TRP2_AddItemToCache(slot,itemName)
	if TRP2_CHATLINK_CACHE[itemName] then
		wipe(TRP2_CHATLINK_CACHE[itemName]);
	else
		TRP2_CHATLINK_CACHE[itemName] = {};
	end
	TRP2_tcopy(TRP2_CHATLINK_CACHE[itemName],slot);
	TRP2_CHATLINK_CACHE[itemName]["VerNum"] = TRP2_GetWithDefaut(TRP2_GetObjectTab(slot["ID"]),"VerNum",1);
end

function TRP2_ItemLinkIDRequested(itemName,sender)
	TRP2_debug(sender.." asking for "..itemName);
	if TRP2_CHATLINK_CACHE[itemName] then
		TRP2_SecureSendAddonMessage("ILSN",TRP2_Libs:Serialize(TRP2_CHATLINK_CACHE[itemName]),sender);
	end
end

function TRP2_ItemLinkIDReceived(slot,sender)
	local success, slotTab = TRP2_Libs:Deserialize(slot);
	if not success then
		TRP2_Error("Deserialization error");
	elseif slotTab["ID"] and slotTab["VerNum"] then
		if TRP2_ObjectExist(slotTab["ID"]) and TRP2_GetWithDefaut(TRP2_GetObjectTab(slotTab["ID"]),"VerNum",1) >= tonumber(slotTab["VerNum"]) then
			TRP2_ShowItemLink(slotTab);
		else
			if string.len(slotTab["ID"]) ~= TRP2_IDSIZE then
				TRP2_ShowItemLink(slotTab,false,true);
			else
				TRP2_OpenRequestForObject(slotTab["ID"],sender);
				TRP2_ShowItemLink(slotTab,true);
			end
		end
	end
end

TRP2_ItemLinkFonts = {
	GameFontNormalLarge,GameFontNormal,GameFontNormalSmall,GameFontNormal,GameFontNormalSmall
}

function TRP2_ShowItemLink(slotTab, loading, updateNeeded)
	local messages;
		
	if updateNeeded then
		messages = {"",TRP2_LOC_Objet_Error_2,"",""};
	elseif loading then
		if TRP2_ItemLinkTooltip.savedTab then
			wipe(TRP2_ItemLinkTooltip.savedTab);
		else
			TRP2_ItemLinkTooltip.savedTab = {};
		end
		TRP2_tcopy(TRP2_ItemLinkTooltip.savedTab,slotTab);
		messages = {"",TRP2_LOC_LoadingItem,"",""};
	else
		messages = {TRP2_GetItemTooltipLines(slotTab,2)};
	end
	
	messages[5] = TRP2_LOC_ITEMLINKDISCLAMER;
	local maxWidth=0;
	local totalHeight=20;
	local i=1;
	local j;
	
	for j=1,5,1 do
		local line = _G["TRP2_ItemLinkTooltipLine"..i];
		line:SetWidth(0);
		line:SetText(" ");
		line:Hide();
		if TRP2_EmptyToNil(TRP2_CTS(messages[j])) then
			line:Show();
			line:SetText(TRP2_CTS(messages[j]));
			line:SetFontObject(TRP2_ItemLinkFonts[j]);
			
			if line:GetStringWidth() > 250 then
				line:SetWidth(250);
				maxWidth = 250;
			elseif maxWidth < line:GetStringWidth() then
				maxWidth = line:GetStringWidth();
			end
			totalHeight = totalHeight + line:GetHeight() + 2;
			i = i + 1;
		end
	end
	for j=i,5,1 do
		_G["TRP2_ItemLinkTooltipLine"..j]:SetWidth(0);
		_G["TRP2_ItemLinkTooltipLine"..j]:SetText(" ");
		_G["TRP2_ItemLinkTooltipLine"..j]:Hide();
	end
	
	TRP2_ItemLinkTooltip:SetWidth(maxWidth + 40);
	TRP2_ItemLinkTooltip:SetHeight(totalHeight);

	TRP2_ItemLinkTooltip:Show();
end

--[[
	Structure d'un slot
	{ INVENTAIRE
		["ID du Slot"] = {
			["ID"] = Id de l'objet, ne peut être null;
			["Qte"] = Quantité (stack), si nul ou 0 => effacement de l'objet
			["Charges"] = Charges de l'objet (si utilisable) => null = infini, 0 = Stack - 1
		}
	}
]]

function TRP2_Set_Module_Inventaire()
	if not TRP2_Module_Inventaire then
		TRP2_Module_Inventaire = {};
	end
	if not TRP2_Module_Inventaire[TRP2_Royaume] then
		TRP2_Module_Inventaire[TRP2_Royaume] = {};
	end
	if not TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur] then
		TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur] = {};
	end
	if not TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"] then
		TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"] = {};
		TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Id"] = "1";
		TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Slot"] = {};
	end
	if not TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Or"] then
		TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Or"] = 0;
	end
	if not TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Durabilite"] then
		TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Durabilite"] = TRP2_SacsADos["1"]["Resistance"];
	end
	if not TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Coffre"] then
		TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Coffre"] = {};
		TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Coffre"]["Id"] = "1";
		TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Coffre"]["Slot"] = {};
	end
	if not TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Coffre"]["Or"] then
		TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Coffre"]["Or"] = 0;
	end
	if not TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Coffre"]["Durabilite"] then
		TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Coffre"]["Durabilite"] = TRP2_CoffreMonture["1"]["Resistance"];
	end
	if not TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Planque"] then
		TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Planque"] = {};
	end
	if not TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Panneau"] then
		TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Panneau"] = {};
	end
	if not TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Cooldown"] then
		TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Cooldown"] = {};
	end
	if not TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["InBox"] then
		TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["InBox"] = {};
	end
	if not TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["OutBox"] then
		TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["OutBox"] = {};
	end
	
	if not TRP2_Module_ObjetsPerso then
		TRP2_Module_ObjetsPerso = {};
	end
end

----------------------------------------
-- CHECKED BIZNESS
----------------------------------------

-- Script effet de modification de la durabilité
function TRP2_InvDurabilite(value,mode,bagType,bRand)
	if bRand then
		value = math.random(value);
	end
	if mode == 2 then
		value = 0 - value;
	end
	local valeur;
	if bagType == 1 then
		local valueAff = TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Durabilite"];
		valeur = TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Durabilite"] + value;
		if valeur < 0 then valeur = 0 end
		if valeur > TRP2_GetWithDefaut(TRP2_SacsADos[TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Id"]],"Resistance",0) then
			valeur = TRP2_GetWithDefaut(TRP2_SacsADos[TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Id"]],"Resistance",0);
		end
		TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Durabilite"] = valeur;
		if valueAff ~= valeur then
			if mode == 2 then
				TRP2_Afficher(TRP2_FT(TRP2_LOC_REA_BAGDAMAGE,valueAff - valeur));
			else
				TRP2_Afficher(TRP2_FT(TRP2_LOC_REA_BAGREPAIR,valeur - valueAff));
			end
		end
	elseif bagType == 2 then
		local valueAff = TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Coffre"]["Durabilite"];
		valeur = TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Coffre"]["Durabilite"] + value;
		if valeur < 0 then valeur = 0 end
		if valeur > TRP2_GetWithDefaut(TRP2_CoffreMonture[TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Coffre"]["Id"]],"Resistance",0) then
			valeur = TRP2_GetWithDefaut(TRP2_CoffreMonture[TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Coffre"]["Id"]],"Resistance",0);
		end
		TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Coffre"]["Durabilite"] = valeur;
		if valueAff ~= valeur then
			if mode == 2 then
				TRP2_Afficher(TRP2_FT(TRP2_LOC_REA_COFFDAMAGE,valueAff - valeur));
			else
				TRP2_Afficher(TRP2_FT(TRP2_LOC_REA_COFFREPAIR,valeur - valueAff));
			end
		end
	end
end

-- Cherche un objet ID présent dans un minimum d'exemplaire Qte dans un sac donné Sac
-- Retourne le slot, la quantitée réelle et le sac (au cas où)
function TRP2_GetSlotWithIDAndQte(ID,Qte,Sac)
	local slotReturn,QteTrouve;
	table.foreach(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][Sac]["Slot"],
		function(Slot)
			if TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][Sac]["Slot"][Slot]["ID"] == ID and TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][Sac]["Slot"][Slot]["Qte"] >= Qte then
				slotReturn = Slot;
				QteTrouve = TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][Sac]["Slot"][Slot]["Qte"];
			end
	end);
	return slotReturn,QteTrouve,Sac;
end

-- Retourne la quantité d'un objet situé dans un sac
function TRP2_CountIDInBag(ID,Sac)
	local QteTrouve = 0;
	for SlotID,Slot in pairs(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][Sac]["Slot"]) do
		if Slot["ID"] == ID then
			QteTrouve = QteTrouve + Slot["Qte"];
		end
	end
	return QteTrouve;
end

-- Retourne le tableau d'information d'un objet créé
function TRP2_GetItemInfo(ObjetID)
	if ObjetID and string.len(ObjetID) == TRP2_IDSIZE then
		return TRP2_Module_ObjetsPerso[ObjetID];
	elseif TRP2_DB_Objects then
		return TRP2_DB_Objects[ObjetID];
	end
end

-- Retourne le tableau d'information d'un slot
function TRP2_GetSlotTab(SlotID, BagType)
	if TRP2_EmptyToNil(SlotID) then
		return TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][BagType]["Slot"][SlotID];
	end
	return nil;
end

-- Returne true si l'objet existe
function TRP2_ObjectExist(ID)
	return TRP2_GetItemInfo(ID) ~= nil;
end

-- Fonction qui calcule l'intégralité des exemplaires possèdé d'un objet, dans tout les sacs/planques.
function TRP2_GetCountOfAll(ID)
	local total = 0;
	table.foreach(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Slot"],function(slot)
		if TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Slot"][slot]["ID"] == ID then
			total = total + TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Slot"][slot]["Qte"];
		end
	end);
	table.foreach(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Coffre"]["Slot"],function(slot)
		if TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Coffre"]["Slot"][slot]["ID"] == ID then
			total = total + TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Coffre"]["Slot"][slot]["Qte"];
		end
	end);
	return total;
end

-- Consommation des Compos
function TRP2_ConsommeCompo(oTab)
	local CompoTab = TRP2_GetCompoTab(TRP2_GetWithDefaut(oTab,"Composants",""));
	-- Compo
	for i=1,10,1 do
		local Id = CompoTab[(i*2)-1];
		local Qte = tonumber(TRP2_NilToDefaut(TRP2_EmptyToNil(CompoTab[(i*2)]),"1"));
		--TRP2_debug("'"..Id.."'");
		if TRP2_EmptyToNil(Id) then
			-- Le compo doit être dans le sac à dos
			for k,v in pairs(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Slot"]) do
				-- k = SlotID
				-- v = Slot
				if v["ID"] == Id then
					if v["Qte"] <= Qte then
						Qte = Qte - v["Qte"];
						wipe(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Slot"][k])
						TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Slot"][k] = nil;
					else
						TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Slot"][k]["Qte"] = TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Slot"][k]["Qte"] - Qte;
					end
					if Qte <= 0 then
						break;
					end
				end
			end
		end
	end
end

-- Check des compos et des outils (check seulement !)
function TRP2_CheckCompoAndOutils(oTab)
	local CompoTab = TRP2_GetCompoTab(TRP2_GetWithDefaut(oTab,"Composants",""));
	local OutilsTab = TRP2_GetCompoTab(TRP2_GetWithDefaut(oTab,"Outils",""));
	
	-- Outils
	for i=1,5,1 do
		local Id = OutilsTab[(i*2)-1];
		local Qte = tonumber(TRP2_NilToDefaut(TRP2_EmptyToNil(OutilsTab[(i*2)]),"1"));
		if TRP2_EmptyToNil(Id) then
			-- Le compo doit être dans le sac à dos
			for k,v in pairs(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Slot"]) do
				-- k = SlotID
				-- v = Slot
				if v["ID"] == Id then
					Qte = Qte - v["Qte"];
					if Qte <= 0 then
						break;
					end
				end
			end
			if Qte > 0 then
				local ObjetTab = TRP2_GetObjectTab(Id);
				return TRP2_LOC_INV_OUTILMAN.." :\n{icone:"..TRP2_GetWithDefaut(ObjetTab,"Icone","Temp")..":16} "..TRP2_ItemQuality[TRP2_GetInt(TRP2_GetWithDefaut(ObjetTab,"Qualite",1))].."["..TRP2_GetWithDefaut(ObjetTab,"Nom",TRP2_LOC_NEW_Objet).."] {w}x"..Qte;
			end
		end
	end
	-- Compo
	for i=1,10,1 do
		local Id = CompoTab[(i*2)-1];
		local Qte = tonumber(TRP2_NilToDefaut(TRP2_EmptyToNil(CompoTab[(i*2)]),"1"));
		if TRP2_EmptyToNil(Id) then
			-- Le compo doit être dans le sac à dos
			for k,v in pairs(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Slot"]) do
				-- k = SlotID
				-- v = Slot
				if v["ID"] == Id then
					Qte = Qte - v["Qte"];
					if Qte <= 0 then
						break;
					end
				end
			end
			if Qte > 0 then
				local ObjetTab = TRP2_GetObjectTab(Id);
				return TRP2_LOC_INV_COMPOMAN.." :\n{icone:"..TRP2_GetWithDefaut(ObjetTab,"Icone","Temp")..":16} "..TRP2_ItemQuality[TRP2_GetInt(TRP2_GetWithDefaut(ObjetTab,"Qualite",1))].."["..TRP2_GetWithDefaut(ObjetTab,"Nom",TRP2_LOC_NEW_Objet).."] {w}x"..Qte;
			end
		end
	end
	return true;
end

-- Début d'utilisation des objets
function TRP2_UseObjet(SlotID,Slot,ObjetID,BagType)
	local ObjetTab = TRP2_GetObjectTab(ObjetID);
	
	-- Faut que ce soit utilisable évidemment
	if TRP2_GetWithDefaut(ObjetTab,"bUtilisable") then
		--Verification de liberté (le joueur ne peut pas etre en plein cast RP ...etc)
		if (not TRP2_CastingBarFrame:IsVisible() or not TRP2_CastingBarFrame.casting) and not TRP2_ExchangeFrame:IsVisible() then
			-- Vérifier si le gars doit être immobile
			if not TRP2_GetWithDefaut(ObjetTab,"bImmobile",false) or GetUnitSpeed("player") == 0 then
				-- Verification du cooldown si il y en a
				if not TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Cooldown"][ObjetID] then
					-- Verification des composants
					local compoCheck = TRP2_CheckCompoAndOutils(ObjetTab);
					if compoCheck == true then
						-- Verification si ya un starting
						if TRP2_GetWithDefaut(ObjetTab,"DureeAnim") then
							-- Verification des conditions si il y en a
							if TRP2_CheckConditions(TRP2_GetWithDefaut(ObjetTab,"OnUseStartCondi",""),TRP2_GetWithDefaut(ObjetTab,"OnUseStartError")) then
								if TRP2_PlayScripts(TRP2_GetWithDefaut(ObjetTab,"OnUseStartScripts"), ObjetID) ~= false then
									-- On démarre le jouage d'anim ^^
									TRP2_CastingBarFrameStart(TRP2_GetWithDefaut(ObjetTab,"TexteAnim",TRP2_GetWithDefaut(ObjetTab,"Nom",TRP2_LOC_NEW_Objet)),
															TRP2_GetWithDefaut(ObjetTab,"DureeAnim"),
															TRP2_GetWithDefaut(ObjetTab,"Anim"), 
															TRP2_UseObjetEnd, SlotID, Slot, ObjetID, BagType, nil, true , TRP2_GetWithDefaut(ObjetTab,"bImmobile",false));
									-- Et on joue l'effet de départ, évidemment.
									
									TRP2_PlayEffect(TRP2_GetWithDefaut(ObjetTab,"OnUseStartEffet",""),
										TRP2_LOC_CreationTypeObjet.." - "..TRP2_ItemQuality[TRP2_GetInt(TRP2_GetWithDefaut(ObjetTab,"Qualite",1))]..TRP2_GetWithDefaut(ObjetTab,"Nom",TRP2_LOC_NEW_Objet),ObjetID,BagType,SlotID,TRP2_GetWithDefaut(ObjetTab,"Createur","")
									);
								end
							else
								if not TRP2_EmptyToNil(TRP2_GetWithDefaut(ObjetTab,"OnUseStartFailEffet")) then
									TRP2_Error(TRP2_LOC_INV_OBJUSEERROR2);
								elseif TRP2_CheckConditions(TRP2_GetWithDefaut(ObjetTab,"OnUseStartFailCondi")) then
									if TRP2_PlayScripts(TRP2_GetWithDefaut(ObjetTab,"OnUseStartFailScripts"), ObjetID) ~= false then
										TRP2_PlayEffect(TRP2_GetWithDefaut(ObjetTab,"OnUseStartFailEffet",""),
											TRP2_LOC_CreationTypeObjet.." - "..TRP2_ItemQuality[TRP2_GetInt(TRP2_GetWithDefaut(ObjetTab,"Qualite",1))]..TRP2_GetWithDefaut(ObjetTab,"Nom",TRP2_LOC_NEW_Objet),ObjetID,BagType,SlotID,TRP2_GetWithDefaut(ObjetTab,"Createur","")
										);
									end
								else
									TRP2_Error(TRP2_LOC_INV_OBJUSEERROR2);
								end
							end
						else
							TRP2_UseObjetEnd(SlotID,Slot,ObjetID,BagType);
						end
					else
						TRP2_Error(TRP2_CTS(compoCheck));
					end
				else
					TRP2_Error(SPELL_FAILED_ITEM_NOT_READY);
				end
			else
				TRP2_Error(ERR_NOEMOTEWHILERUNNING);
			end
		else
			TRP2_Error(SPELL_FAILED_CANT_DO_THAT_RIGHT_NOW);
		end
	end
end

-- Fin d'utilisation des objets
function TRP2_UseObjetEnd(SlotID,Slot,ObjetID,BagType)
	if not Slot["ID"] or Slot["ID"] ~= ObjetID then return end -- L'objet a été détruit entre temps
	local ObjetTab = TRP2_GetObjectTab(ObjetID);
	-- Verification des conditions si il y en a
	--TRP2_debug("Pre condi");
	if TRP2_CheckConditions(TRP2_GetWithDefaut(ObjetTab,"OnUseEndCondi"),TRP2_GetWithDefaut(ObjetTab,"OnUseEndError")) then
		if TRP2_PlayScripts(TRP2_GetWithDefaut(ObjetTab,"OnUseEndScripts"), ObjetID) ~= false then
			local isUsed = false;
			-- décrémentation du nombre
			if TRP2_GetWithDefaut(ObjetTab,"Charges",0) > 1 then
				TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][BagType]["Slot"][SlotID]["Charges"] = TRP2_GetWithDefaut(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][BagType]["Slot"][SlotID],"Charges",TRP2_GetWithDefaut(ObjetTab,"Charges",0)) - 1;
				if TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][BagType]["Slot"][SlotID]["Charges"] <= 0 then
					TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][BagType]["Slot"][SlotID]["Qte"] = 0;
					isUsed = true;
				end
				--TRP2_debug("On decremente");
			elseif TRP2_GetWithDefaut(ObjetTab,"Charges",0) == 1 then -- 1 charge
				TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][BagType]["Slot"][SlotID]["Qte"] = TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][BagType]["Slot"][SlotID]["Qte"] - 1;
			end
			if TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][BagType]["Slot"][SlotID]["Qte"] <= 0 then
				wipe(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][BagType]["Slot"][SlotID]);
				TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][BagType]["Slot"][SlotID] = nil;
				TRP2_GLOBALSLOTID = SlotID;
			end
			-- Cooldown simple
			if TRP2_GetWithDefaut(ObjetTab,"Cooldown") then
				TRP2_SetCooldown(ObjetID,TRP2_GetWithDefaut(ObjetTab,"Cooldown"));
			end
			-- Effet USE END
			TRP2_PlayEffect(TRP2_GetWithDefaut(ObjetTab,"OnUseEndEffet",""),
				TRP2_LOC_CreationTypeObjet.." - "..TRP2_ItemQuality[TRP2_GetInt(TRP2_GetWithDefaut(ObjetTab,"Qualite",1))]..TRP2_GetWithDefaut(ObjetTab,"Nom",TRP2_LOC_NEW_Objet),ObjetID,BagType,SlotID,TRP2_GetWithDefaut(ObjetTab,"Createur","")
			);
			-- Effet USED
			if isUsed and TRP2_CheckConditions(TRP2_GetWithDefaut(ObjetTab,"OnUsedCondi","")) and TRP2_PlayScripts(TRP2_GetWithDefaut(ObjetTab,"OnUsedScripts"),ObjetID) ~= false then
				TRP2_PlayEffect(TRP2_GetWithDefaut(ObjetTab,"OnUsedEffet",""),
					TRP2_LOC_CreationTypeObjet.." - "..TRP2_ItemQuality[TRP2_GetInt(TRP2_GetWithDefaut(ObjetTab,"Qualite",1))]..TRP2_GetWithDefaut(ObjetTab,"Nom",TRP2_LOC_NEW_Objet),ObjetID,BagType,SlotID,TRP2_GetWithDefaut(ObjetTab,"Createur","")
				);
			end
			TRP2_GLOBALSLOTID = nil;
			-- On bousille les compos
			TRP2_ConsommeCompo(ObjetTab);
		end
	else
		if not TRP2_EmptyToNil(TRP2_GetWithDefaut(ObjetTab,"OnUseEndFailEffet","")) then
			TRP2_Error(TRP2_LOC_INV_OBJUSEERROR2);
		elseif TRP2_CheckConditions(TRP2_GetWithDefaut(ObjetTab,"OnUseEndFailCondi")) and TRP2_PlayScripts(TRP2_GetWithDefaut(ObjetTab,"OnUseEndFailScripts"),ObjetID) ~= false then
			TRP2_PlayEffect(TRP2_GetWithDefaut(ObjetTab,"OnUseEndFailEffet",""),
				TRP2_LOC_CreationTypeObjet.." - "..TRP2_ItemQuality[TRP2_GetInt(TRP2_GetWithDefaut(ObjetTab,"Qualite",1))]..TRP2_GetWithDefaut(ObjetTab,"Nom",TRP2_LOC_NEW_Objet),ObjetID,BagType,SlotID,TRP2_GetWithDefaut(ObjetTab,"Createur","")
			);
		else
			TRP2_Error(TRP2_LOC_INV_OBJUSEERROR2);
		end
	end
	TRP2_RefreshInventaire();
end

-- Ajouter de l'or dans un sac
function TRP2_InvAddGold(bagType,gold,message)
	if bagType ~= "Planque" then
		TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType]["Or"] = TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType]["Or"] + gold;
		if message and gold > 0 then
			TRP2_Afficher(TRP2_FT(TRP2_LOC_AddGoldNote,TRP2_GoldToText(gold)));
		end
		TRP2_PlaySound("Sound\\Interface\\iMoneyDialogOpen.wav");
	else
		local ID = TRP2InventaireFramePlanque.planqueID;
		local Nom = TRP2InventaireFramePlanque.planqueNom;
		if Nom == TRP2_Joueur and TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType][ID] then
			TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType][ID]["Or"] = TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType][ID]["Or"] + gold;
		else
			TRP2_Planques[Nom]["Or"] = TRP2_Planques[Nom]["Or"] + gold;
			TRP2_SendUpdateToPlanque(Nom);
		end
		TRP2_PlaySound("Sound\\Interface\\iMoneyDialogOpen.wav");
	end
	
end

-- Retirer de l'or dans un sac
function TRP2_InvDelGold(bagType,gold,message)
	local save;
	if bagType ~= "Planque" then
		save = TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType]["Or"];
		TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType]["Or"] = TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType]["Or"] - gold;
		if TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType]["Or"] < 0 then
			TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType]["Or"] = 0;
		else
			save = gold;
		end
		if message and save > 0 then
			TRP2_Afficher(TRP2_FT(TRP2_LOC_DelGoldNote,TRP2_GoldToText(save)));
		end
	else
		local ID = TRP2InventaireFramePlanque.planqueID;
		local Nom = TRP2InventaireFramePlanque.planqueNom;
		if Nom == TRP2_Joueur and TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType][ID] then
			save = TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType][ID]["Or"];
			TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType][ID]["Or"] = TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType][ID]["Or"] - gold;
			if TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType][ID]["Or"] < 0 then
				TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType][ID]["Or"] = 0;
			else
				save = gold;
			end
		else
			save = TRP2_Planques[Nom]["Or"];
			TRP2_Planques[Nom]["Or"] = TRP2_Planques[Nom]["Or"] - gold;
			if TRP2_Planques[Nom]["Or"] < 0 then
				TRP2_Planques[Nom]["Or"] = 0;
			else
				save = gold;
			end
			TRP2_SendUpdateToPlanque(Nom);
		end
	end
end

-- Raccourci pour l'effet
function TRP2_InvOr(quantite,mode,bRandom)
	if bRandom then
		quantite = math.random(quantite);
	end
	if mode == 1 then
		TRP2_InvAddGold("Sac",quantite,true);
	else
		TRP2_InvDelGold("Sac",quantite,true);
	end
end

function TRP2_TransfertOr(montant,from,to)
	if montant and montant ~= 0 then
		local test;
		if from == "Planque" then
			local ID = TRP2InventaireFramePlanque.planqueID;
			local Nom = TRP2InventaireFramePlanque.planqueNom;
			if Nom == TRP2_Joueur and TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][from][ID] then
				test = TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][from][ID];
			elseif TRP2_Planques[Nom] then
				test = TRP2_Planques[Nom];
			end
		else
			test = TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][from];
		end
		if test and montant > test["Or"] then
			TRP2_Error(ERR_NOT_ENOUGH_MONEY);
		else
			if (to == "Planque" or from == "Planque") and TRP2InventaireFramePlanque.planqueNom ~= TRP2_Joueur then
				TRP2_PlanqueAskFunc(function()
					TRP2_InvAddGold(to,montant,false);
					TRP2_InvDelGold(from,montant,false);
				end,TRP2InventaireFramePlanque.planqueNom,TRP2_Planques[TRP2InventaireFramePlanque.planqueNom]["ID"]);
			else
				TRP2_InvAddGold(to,montant,false);
				TRP2_InvDelGold(from,montant,false);
			end
		end
	end
end

-- Supprime les données du slot
function TRP2_InvDelObjet(bagType,slot,message, noEffect)
	if TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType]["Slot"][slot] then
		local ObjetTab = TRP2_GetObjectTab(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType]["Slot"][slot]["ID"]);
		local Qte = TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType]["Slot"][slot]["Qte"]
		local ID = TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType]["Slot"][slot]["ID"];
		wipe(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType]["Slot"][slot]);
		TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType]["Slot"][slot] = nil;
		if not noEffect and TRP2_CheckConditions(TRP2_GetWithDefaut(ObjetTab,"OnDestroyCondi","")) and TRP2_PlayScripts(TRP2_GetWithDefaut(ObjetTab,"OnDestroyScripts"),ID) ~= false then
			TRP2_PlayEffect(TRP2_GetWithDefaut(ObjetTab,"OnDestroyEffet",""),
				TRP2_LOC_CreationTypeObjet.." - "..TRP2_ItemQuality[TRP2_GetInt(TRP2_GetWithDefaut(ObjetTab,"Qualite",1))]..TRP2_GetWithDefaut(ObjetTab,"Nom",TRP2_LOC_NEW_Objet),
				ID,bagType,slot,TRP2_GetWithDefaut(ObjetTab,"Createur",""));
		end
		TRP2_InterruptObjet(slot,bagType,"FAILED");
		TRP2_RefreshInventaire();
		if message then
			TRP2_Afficher(TRP2_FT(TRP2_LOC_DESTROYOBJ,TRP2_GetNameWithQuality(ObjetTab),Qte));
		end
	end
end

-- Ajoute/Supprime un objet, script Effet
function TRP2_ObjetScript(ID,Qte,Mode,bRandom)
	if bRandom then
		Qte = math.random(Qte);
	end
	if Mode == 1 then
		TRP2_InvAddObjet(ID,nil,nil,Qte,nil,nil,true);
	else
		local ok=true;
		local qteRest = Qte;
		local slot;
		while ok and qteRest > 0 do
			slot = nil;
			local qtefound,sac;
			slot,qtefound,sac = TRP2_GetSlotWithIDAndQte(ID,1,"Sac");
			if not slot then
				slot,qtefound,sac = TRP2_GetSlotWithIDAndQte(ID,1,"Coffre");
			end
			if not slot then
				ok = false;
				break;
			end
			if qtefound > qteRest then
				TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][sac]["Slot"][slot]["Qte"] = qtefound - qteRest;
				qteRest = 0;
				ok=false;
			elseif qtefound == qteRest then
				wipe(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][sac]["Slot"][slot]);
				TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][sac]["Slot"][slot] = nil;
				qteRest = 0;
				ok=false;
			else
				wipe(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][sac]["Slot"][slot]);
				TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][sac]["Slot"][slot] = nil;
				qteRest = qteRest - qtefound;
			end
		end
		local ObjetTab = TRP2_GetObjectTab(ID);
		if qteRest ~= Qte and TRP2_CheckConditions(TRP2_GetWithDefaut(ObjetTab,"OnDestroyCondi","")) then
			if TRP2_PlayScripts(TRP2_GetWithDefaut(ObjetTab,"OnDestroyScripts"),ID) ~= false then
				TRP2_PlayEffect(TRP2_GetWithDefaut(ObjetTab,"OnDestroyEffet",""),
					TRP2_LOC_CreationTypeObjet.." - "..TRP2_ItemQuality[TRP2_GetInt(TRP2_GetWithDefaut(ObjetTab,"Qualite",1))]..TRP2_GetWithDefaut(ObjetTab,"Nom",TRP2_LOC_NEW_Objet),
					ID,"Sac",slot,TRP2_GetWithDefaut(ObjetTab,"Createur",""));
			end
		end
		if Qte-qteRest > 0 then
			TRP2_Afficher(TRP2_FT(TRP2_LOC_DESTROYOBJ,TRP2_GetNameWithQuality(TRP2_GetObjectTab(ID)),Qte-qteRest));
		end
	end
end

TRP2_GLOBALSLOTID = nil;
-- /script wipe(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Slot"])
-- Ajoute un objet dans l'inventaire :
-- Code retour :
-- 1 : objet inexistant
-- 2 : Compte unique atteind
-- 3,# : OLD : si il y a eut empilement
-- 4,# : OK avec nouveau slot, où # est le slot (string)
-- 5 : Erreur fatale, le sac est plein :)
function TRP2_InvAddObjet(ObjetID,bagType,Charges,Qte,Lifetime,Artisant,message,bAnnulEmpil,SlotID)
	local Objet = TRP2_GetObjectTab(ObjetID);
	if not Objet then
		return 1;
	end
	if message == nil then
		message = true; -- Affiché par défaut
	end
	-- Si pas bagType, bagType par défaut
	if not bagType then bagType = "Sac" end
	-- Si pas Qte, qte par défaut
	if not Qte then Qte = 1 end
	-- Adaptation des charges
	if not Charges or not Objet["Charges"] or Objet["Charges"] < Charges then
		Charges = Objet["Charges"];
	end
	-- Si pas lifetime : charges par défaut
	if not Lifetime and Objet["Lifetime"] and Objet["Lifetime"] > 0 then
		Lifetime = time() + Objet["Lifetime"];
	end
	--Check unique
	if Objet["Unique"] and Objet["Unique"] > 0 then
		if TRP2_GetCountOfAll(ObjetID) + Qte > Objet["Unique"] then
			if message then
				TRP2_Error(SPELL_FAILED_LIMIT_CATEGORY_EXCEEDED);
			end
			return 2;
		end
	end
	
	local QteToPlace = Qte;
	local ok = false;
	if (not SlotID and not TRP2_GLOBALSLOTID) or (SlotID and TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType]["Slot"][SlotID]) or
	(TRP2_GLOBALSLOTID and TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType]["Slot"][TRP2_GLOBALSLOTID]) then
		-- Recherche d'empilement
		if TRP2_GetWithDefaut(Objet,"MaxStack",1) > 1 and not bAnnulEmpil then
			for key,value in pairs(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType]["Slot"]) do
				if value["ID"] == ObjetID and value["Qte"] < TRP2_GetWithDefaut(Objet,"MaxStack",1) then -- Si il reste de la place dans le slot
					-- On calcule la place qui reste dans le slot
					local reste = TRP2_GetWithDefaut(Objet,"MaxStack",1) - value["Qte"];
					SlotID = key;
					if QteToPlace <= reste then
						TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType]["Slot"][key]["Qte"] = TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType]["Slot"][key]["Qte"] + QteToPlace;
						ok = true;
						QteToPlace = 0;
						TRP2_RefreshInventaire();
						break;
					else
						TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType]["Slot"][key]["Qte"] = TRP2_GetWithDefaut(Objet,"MaxStack",1);
						QteToPlace = QteToPlace - reste;
					end
				end
			end
		end
		-- Nouvel emplacement
		if not ok then
			local i = 1;
			while i <= 400 and not ok do
				if not TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType]["Slot"][tostring(i)] then
					TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType]["Slot"][tostring(i)] = {};
					TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType]["Slot"][tostring(i)]["ID"] = ObjetID;
					TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType]["Slot"][tostring(i)]["Charges"] = Charges;
					TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType]["Slot"][tostring(i)]["Qte"] = math.min(QteToPlace,TRP2_GetWithDefaut(Objet,"MaxStack",1));
					QteToPlace = QteToPlace-math.min(QteToPlace,TRP2_GetWithDefaut(Objet,"MaxStack",1));
					TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType]["Slot"][tostring(i)]["Artisant"] = Artisant;
					TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType]["Slot"][tostring(i)]["Lifetime"] = Lifetime;
					TRP2_RefreshInventaire(); 
					if QteToPlace <= 0 then
						ok = tostring(i);
					end
					SlotID = tostring(i);
				end
				i = i + 1;
			end
		else
			ok = 3;
		end
	else
		if TRP2_GLOBALSLOTID then 
			SlotID = TRP2_GLOBALSLOTID;
			TRP2_GLOBALSLOTID = nil;
		end
		if not TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType]["Slot"][SlotID] then
			TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType]["Slot"][SlotID] = {};
		else
			wipe(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType]["Slot"][SlotID])
		end
		TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType]["Slot"][SlotID]["ID"] = ObjetID;
		TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType]["Slot"][SlotID]["Charges"] = Charges;
		TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType]["Slot"][SlotID]["Qte"] = math.min(QteToPlace,TRP2_GetWithDefaut(Objet,"MaxStack",1));
		TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType]["Slot"][SlotID]["Artisant"] = Artisant;
		TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][bagType]["Slot"][SlotID]["Lifetime"] = Lifetime;
		QteToPlace = 0;
		ok = true;
		TRP2_RefreshInventaire();
	end
	if message and QteToPlace ~= Qte then
		TRP2_Afficher(TRP2_FT(TRP2_LOC_ObjectAddNote,TRP2_GetNameWithQuality(Objet),(Qte-QteToPlace)));
	end
	if ok then
		if TRP2_CheckConditions(TRP2_GetWithDefaut(Objet,"OnReceiveCondi","")) then
			if TRP2_PlayScripts(TRP2_GetWithDefaut(Objet,"OnReceiveScripts"),ObjetID) ~= false then
				TRP2_PlayEffect(TRP2_GetWithDefaut(Objet,"OnReceiveEffet",""),
					TRP2_LOC_CreationTypeObjet.." - "..TRP2_ItemQuality[TRP2_GetInt(TRP2_GetWithDefaut(Objet,"Qualite",1))]..TRP2_GetWithDefaut(Objet,"Nom",TRP2_LOC_NEW_Objet),ObjetID,bagType,SlotID,TRP2_GetWithDefaut(Objet,"Createur",""));
			end
		end
		return true;
	else
		return 5;
	end
end

-- Retourne le nom coloré entouré de crochet orange
function TRP2_GetNameWithQuality(objectTab)
	return "{o}["..TRP2_ItemQuality[TRP2_GetInt(TRP2_GetWithDefaut(objectTab,"Qualite",1))]..TRP2_GetWithDefaut(objectTab,"Nom",TRP2_LOC_NEW_Objet).."{o}]";
end

-- Place un CD sur un objectID
function TRP2_SetCooldown(ObjectID,Time,bRand)
	if bRand then
		Time = math.random(Time);
	end
	if ObjectID and Time then
		TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Cooldown"][ObjectID] = time() + Time;
	end
end

-- Script pour recuperer la valeur du cooldown
function TRP2_GetCooldownScript(ObjectID)
	if ObjectID and TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Cooldown"][ObjectID] then
		return abs(time() - TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Cooldown"][ObjectID]);
	end
	return 0;
end

-- Place un Lifetime sur un Slot
function TRP2_SetLifetime(Bag,Slot,Time,bRand)
	if bRand then
		Time = math.random(Time);
	end
	if Slot and Bag and Time and TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][Bag]["Slot"][Slot] then
		if Time == 0 then
			TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][Bag]["Slot"][Slot]["Lifetime"] = nil;
		else
			TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur][Bag]["Slot"][Slot]["Lifetime"] = time() + Time;
		end
	end
end

-- Interromp l'utilisation de l'objet si il est utilisé
function TRP2_InterruptObjet(slot,bag,intType)
	if TRP2_CastingBarFrame.arg1 == slot and TRP2_CastingBarFrame.arg4 == bag then
		TRP2_CastingBarFrameInterrupt(intType);
	end
end

-- Rafraichit l'inventaire (cooldown, lifetime ...etc);
function TRP2_RefreshInventaireTimed()
	
	-- Lifetime dans le Sac
	for slotID,slotTab in pairs(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Slot"]) do
		local ObjetTab = TRP2_GetObjectTab(slotTab["ID"]);
		-- Cooldown avec effets
		if TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Cooldown"][slotTab["ID"]] then
			if TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Cooldown"][slotTab["ID"]] <= time() then
				TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Cooldown"][slotTab["ID"]] = nil;
				if TRP2_CheckConditions(TRP2_GetWithDefaut(ObjetTab,"OnCooldownCondi","")) then
					if TRP2_PlayScripts(TRP2_GetWithDefaut(ObjetTab,"OnCooldownScripts"),slotTab["ID"]) ~= false then
						TRP2_PlayEffect(TRP2_GetWithDefaut(ObjetTab,"OnCooldownEffet",""),
							TRP2_LOC_CreationTypeObjet.." - "..TRP2_ItemQuality[TRP2_GetInt(TRP2_GetWithDefaut(ObjetTab,"Qualite",1))]..TRP2_GetWithDefaut(ObjetTab,"Nom",TRP2_LOC_NEW_Objet),slotTab["ID"],"Sac",slotID,TRP2_GetWithDefaut(ObjetTab,"Createur",""));
					end
				end
			end
		end
		if slotTab["Lifetime"] then
			if slotTab["Lifetime"] <= time() then
				TRP2_InterruptObjet(slotID,"Sac","FAILED");
				wipe(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Slot"][slotID]);
				TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Slot"][slotID] = nil;
				TRP2_GLOBALSLOTID = slotID;
				if TRP2_CheckConditions(TRP2_GetWithDefaut(ObjetTab,"OnTimeoutCondi","")) then
					if TRP2_PlayScripts(TRP2_GetWithDefaut(ObjetTab,"OnTimeoutScripts"),slotTab["ID"]) ~= false then
						TRP2_PlayEffect(TRP2_GetWithDefaut(ObjetTab,"OnTimeoutEffet",""),
							TRP2_LOC_CreationTypeObjet.." - "..TRP2_ItemQuality[TRP2_GetInt(TRP2_GetWithDefaut(ObjetTab,"Qualite",1))]..TRP2_GetWithDefaut(ObjetTab,"Nom",TRP2_LOC_NEW_Objet),slotTab["ID"],"Sac",slotID,TRP2_GetWithDefaut(ObjetTab,"Createur",""));
					end
				end
				TRP2_GLOBALSLOTID = nil;
				TRP2_Afficher(TRP2_FT(TRP2_LOC_DESTROYOBJ,TRP2_GetNameWithQuality(ObjetTab),TRP2_GetWithDefaut(slotTab,"Qte","1")).." ("..TRP2_LOC_TRIGOBJ_TIMEOUT..")");
			end
		end
	end
	-- Lifetime dans le coffre
	for slotID,slotTab in pairs(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Coffre"]["Slot"]) do
		local ObjetTab = TRP2_GetObjectTab(slotTab["ID"]);
		-- Cooldown avec effets
		if TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Cooldown"][slotTab["ID"]] then
			if TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Cooldown"][slotTab["ID"]] <= time() then
				TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Cooldown"][slotTab["ID"]] = nil;
				if TRP2_CheckConditions(TRP2_GetWithDefaut(ObjetTab,"OnCooldownCondi","")) then
					if TRP2_PlayScripts(TRP2_GetWithDefaut(ObjetTab,"OnCooldownScripts"),slotTab["ID"]) ~= false then
						TRP2_PlayEffect(TRP2_GetWithDefaut(ObjetTab,"OnCooldownEffet",""),
							TRP2_LOC_CreationTypeObjet.." - "..TRP2_ItemQuality[TRP2_GetInt(TRP2_GetWithDefaut(ObjetTab,"Qualite",1))]..TRP2_GetWithDefaut(ObjetTab,"Nom",TRP2_LOC_NEW_Objet),slotTab["ID"],"Sac",slotID,TRP2_GetWithDefaut(ObjetTab,"Createur",""));
					end
				end
			end
		end
		if slotTab["Lifetime"] then
			if slotTab["Lifetime"] <= time() then
				TRP2_InterruptObjet(slotID,"Coffre","FAILED");
				wipe(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Coffre"]["Slot"][slotID]);
				TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Coffre"]["Slot"][slotID] = nil;
				if TRP2_CheckConditions(TRP2_GetWithDefaut(ObjetTab,"OnTimeoutCondi","")) then
					if TRP2_PlayScripts(TRP2_GetWithDefaut(ObjetTab,"OnTimeoutScripts"),slotTab["ID"]) ~= false then
						TRP2_PlayEffect(TRP2_GetWithDefaut(ObjetTab,"OnTimeoutEffet",""),
							TRP2_LOC_CreationTypeObjet.." - "..TRP2_ItemQuality[TRP2_GetInt(TRP2_GetWithDefaut(ObjetTab,"Qualite",1))]..TRP2_GetWithDefaut(ObjetTab,"Nom",TRP2_LOC_NEW_Objet),slotTab["ID"],"Coffre",slotID,TRP2_GetWithDefaut(ObjetTab,"Createur",""));
					end
				end
				TRP2_Afficher(TRP2_FT(TRP2_LOC_DESTROYOBJ,TRP2_GetNameWithQuality(ObjetTab),TRP2_GetWithDefaut(slotTab,"Qte","1")).." ("..TRP2_LOC_TRIGOBJ_TIMEOUT..")");
			end
		end
	end
	-- Cooldowns restant : supprimer sans effet
	for k,v in pairs(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Cooldown"]) do
		if v <= time() then
			TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Cooldown"][k] = nil;
		end
	end
	TRP2_RefreshInventaire();
end

-------------------------------------------------------
-- Systeme d'echange
-------------------------------------------------------

TRP2_ExchangeMonTab = nil;
TRP2_ExchangeSonTab = nil;


-- Initialisation du donneur : Cible, le slot par défaut, et l'or par défaut.
function TRP2_StartExchange(Cible,SlotID,Or)
	TRP2_ExchangeMonTab = {};
	TRP2_ExchangeMonTab["Cible"] = Cible;
	TRP2_ExchangeMonTab["Or"] = Or;
	TRP2_ExchangeMonTab["Slot"] = {};
	TRP2_ExchangeMonTab["Slot"]["1"] = SlotID;
	TRP2_ExchangeFrameLeftFrameOr:SetText("");
	TRP2_ExchangeSonTab = {};
	TRP2_ExchangeSonTab["Slot"] = {};
	TRP2_ExchangeFrameSynchro:Show();
	TRP2_ExchangeFrameHelp:Show();
	TRP2_SecureSendAddonMessage("OTST",TRP2_ExchangeConvertToString(),TRP2_ExchangeMonTab["Cible"]);
	TRP2_Afficher("{j}"..TRP2_FT(TRP2_LOC_INV_EXSTART,Cible));
	TRP2_ExchangeFrame:Show();
	SetPortraitTexture(TRP2_ExchangeFramePortrait,"player");
	TRP2_ExchangeFramePseudoLeft:SetText(TRP2_CTS("{v}"..TRP2_Joueur));
	TRP2_debug("Début de l'échange avec "..Cible);
	TRP2_ExchangeFramePseudoRight:SetText(TRP2_CTS("{o}"..Cible));
	local mouseover, realm = UnitName("mouseover");
		if realm then
			mouseover = mouseover.."-"..realm;
		end
		local target, realm = UnitName("target");
		if realm then
			target = target.."-"..realm;
		end
	if Cible == mouseover then
		SetPortraitTexture(TRP2_ExchangeFramePortraitDroite,"mouseover");
	elseif Cible == target then
		SetPortraitTexture(TRP2_ExchangeFramePortraitDroite,"target");
	else
		if TRP2_GetWithDefaut(TRP2_GetInfo(Cible,"Actu"),"PlayerIcon") then
			SetPortraitToTexture(TRP2_ExchangeFramePortraitDroite,"Interface\\ICONS\\"..TRP2_GetWithDefaut(TRP2_GetInfo(Cible,"Actu"),"PlayerIcon"));
		elseif TRP2_GetInfo(Cible,"Sex") and TRP2_GetInfo(Cible,"Race") then
			SetPortraitToTexture(TRP2_ExchangeFramePortraitDroite,"Interface\\ICONS\\"..TRP2_textureRace[TRP2_enRace][TRP2_textureSex[UnitSex("player")]]);
		else
			SetPortraitToTexture(TRP2_ExchangeFramePortraitDroite,"Interface\\ICONS\\Achievement_Boss_Nexus_Prince_Shaffar");
		end
	end
end

-- Initialisation du receveur
function TRP2_StartExchangeAsk(tab,sender)
	if TRP2_ExchangeFrame:IsVisible() then
		TRP2_SecureSendAddonMessage("OTCA","",sender);
		TRP2_SecureSendAddonMessage("MESS","TRP2_LOC_NODISPOTRANS",sender);
		return;
	end
	TRP2_ExchangeMonTab = {};
	TRP2_ExchangeMonTab["Cible"] = sender;
	TRP2_ExchangeMonTab["Ok"] = 0;
	TRP2_ExchangeMonTab["Slot"] = {};
	TRP2_ExchangeSonTab = {};
	TRP2_ExchangeSonTab["Ok"] = 0;
	TRP2_ExchangeSonTab["Slot"] = {};
	TRP2_ExchangeFrameLeftFrameOr:SetText("");
	TRP2_ExchangeFrame:Show();
	TRP2_ExchangeReceiveTab(tab,sender);
	TRP2_ExchangeFramePseudoLeft:SetText(TRP2_CTS("{v}"..TRP2_Joueur));
	TRP2_ExchangeFramePseudoRight:SetText(TRP2_CTS("{o}"..sender));
	TRP2_SecureSendAddonMessage("OTUP",TRP2_ExchangeConvertToString(),TRP2_ExchangeMonTab["Cible"]);
	TRP2_Afficher(string.gsub("{j}"..ERR_TRADE_REQUEST_S,"%%s",sender));
	SetPortraitTexture(TRP2_ExchangeFramePortrait,"player");
	local mouseover, realm = UnitName("mouseover");
		if realm then
			mouseover = mouseover.."-"..realm;
		end
		local target, realm = UnitName("target");
		if realm then
			target = target.."-"..realm;
		end
	if sender == mouseover then
		SetPortraitTexture(TRP2_ExchangeFramePortraitDroite,"mouseover");
	elseif sender == UnitName("target") then
		SetPortraitTexture(TRP2_ExchangeFramePortraitDroite,"target");
	else
		if TRP2_GetWithDefaut(TRP2_GetInfo(sender,"Actu"),"PlayerIcon") then
			SetPortraitToTexture(TRP2_ExchangeFramePortraitDroite,"Interface\\ICONS\\"..TRP2_GetWithDefaut(TRP2_GetInfo(sender,"Actu"),"PlayerIcon"));
		elseif TRP2_GetInfo(sender,"Sex") and TRP2_GetInfo(sender,"Race") then
			SetPortraitToTexture(TRP2_ExchangeFramePortraitDroite,"Interface\\ICONS\\"..TRP2_textureRace[TRP2_enRace][TRP2_textureSex[UnitSex("player")]]);
		else
			SetPortraitToTexture(TRP2_ExchangeFramePortraitDroite,"Interface\\ICONS\\Achievement_Boss_Nexus_Prince_Shaffar");
		end
	end
end

-- Lancé dès qu'on reçoit le tableau d'information de l'autre coté, via INIT ou via un UPDATE
-- Taille : 36 + 172 = 208
-- tab[1] = Nom = 25
-- tab[2] = Or = 11
-- Chaque objet : total : 43*4 = 172
-- tab[3] = ID = 19
-- tab[4] = Vernum = 5
-- tab[5] = Qte = 4
-- tab[6] = Charges = 4
-- tab[7] = Lifetime = 11
function TRP2_ExchangeReceiveTab(tab,sender)
	if TRP2_ExchangeSonTab and TRP2_ExchangeMonTab and TRP2_ExchangeMonTab["Cible"] == sender then
		TRP2_ExchangeFrameSynchro:Hide();
		TRP2_ExchangeFrameHelp:Hide();
		TRP2_ExchangeSonTab["Ok"] = 0;
		TRP2_ExchangeMonTab["Ok"] = 0;
		tab = TRP2_fetchInformations(tab);
		if tostring(tab[1]) ~= TRP2_Joueur and tostring(tab[1]) ~= TRP2_Joueur.."-"..TRP2_Royaume then
				return;
		end
		TRP2_debug(tab);
		TRP2_ExchangeSonTab["Or"] = tostring(tab[2]);
		if TRP2_EmptyToNil(tab[3]) then -- tab[3] = ID | tab[4] = Vernum | tab[5] = Qte | 
			TRP2_ExchangeSonTab["Slot"]["1"] = {};
			TRP2_ExchangeSonTab["Slot"]["1"]["ID"] = tab[3];
			TRP2_ExchangeSonTab["Slot"]["1"]["Qte"] = tonumber(tab[5]);
			TRP2_ExchangeSonTab["Slot"]["1"]["Charges"] = tonumber(tab[6]);
			TRP2_ExchangeSonTab["Slot"]["1"]["Lifetime"] = tonumber(tab[7]);
			if not TRP2_ObjectExist(tab[3]) or TRP2_GetWithDefaut(TRP2_GetObjectTab(tab[3]),"VerNum",1) < tonumber(tab[4]) then
				TRP2_OpenRequestForObject(tab[3],sender);
			end
		else
			TRP2_ExchangeSonTab["Slot"]["1"] = nil;
		end
		if TRP2_EmptyToNil(tab[8]) then
			TRP2_ExchangeSonTab["Slot"]["2"] = {};
			TRP2_ExchangeSonTab["Slot"]["2"]["ID"] = tab[8];
			TRP2_ExchangeSonTab["Slot"]["2"]["Qte"] = tonumber(tab[10]);
			TRP2_ExchangeSonTab["Slot"]["2"]["Charges"] = tonumber(tab[11]);
			TRP2_ExchangeSonTab["Slot"]["2"]["Lifetime"] = tonumber(tab[12]);
			if not TRP2_ObjectExist(tab[8]) or TRP2_GetWithDefaut(TRP2_GetObjectTab(tab[8]),"VerNum",1) ~= tonumber(tab[9]) then
				TRP2_OpenRequestForObject(tab[8],sender);
			end
		else
			TRP2_ExchangeSonTab["Slot"]["2"] = nil;
		end
		if TRP2_EmptyToNil(tab[13]) then
			TRP2_ExchangeSonTab["Slot"]["3"] = {};
			TRP2_ExchangeSonTab["Slot"]["3"]["ID"] = tab[13];
			TRP2_ExchangeSonTab["Slot"]["3"]["Qte"] = tonumber(tab[15]);
			TRP2_ExchangeSonTab["Slot"]["3"]["Charges"] = tonumber(tab[16]);
			TRP2_ExchangeSonTab["Slot"]["3"]["Lifetime"] = tonumber(tab[17]);
			if not TRP2_ObjectExist(tab[13]) or TRP2_GetWithDefaut(TRP2_GetObjectTab(tab[13]),"VerNum",1) ~= tonumber(tab[14]) then
				TRP2_OpenRequestForObject(tab[13],sender);
			end
		else
			TRP2_ExchangeSonTab["Slot"]["3"] = nil;
		end
		if TRP2_EmptyToNil(tab[18]) then
			TRP2_ExchangeSonTab["Slot"]["4"] = {};
			TRP2_ExchangeSonTab["Slot"]["4"]["ID"] = tab[18];
			TRP2_ExchangeSonTab["Slot"]["4"]["Qte"] = tonumber(tab[20]);
			TRP2_ExchangeSonTab["Slot"]["4"]["Charges"] = tonumber(tab[21]);
			TRP2_ExchangeSonTab["Slot"]["4"]["Lifetime"] = tonumber(tab[22]);
			if not TRP2_ObjectExist(tab[18]) or TRP2_GetWithDefaut(TRP2_GetObjectTab(tab[18]),"VerNum",1) ~= tonumber(tab[19]) then
				TRP2_OpenRequestForObject(tab[18],sender);
			end
		else
			TRP2_ExchangeSonTab["Slot"]["4"] = nil;
		end
		
		TRP2_debug("---------------------");
		TRP2_debug("Update de : "..sender);
		TRP2_debug("Cible : "..tostring(tab[1]));
		TRP2_debug("Or : "..tostring(tab[2]));
		TRP2_debug("Slot 1 ID : "..tostring(tab[3]).." Vernum : "..tostring(tab[4]).." Qte : "..tostring(tab[5]).." Charges : "..tostring(tab[6]).." Lifetime : "..tostring(tab[7]));
		TRP2_debug("Slot 2 ID : "..tostring(tab[8]).." Vernum : "..tostring(tab[9]).." Qte : "..tostring(tab[10]).." Charges : "..tostring(tab[11]).." Lifetime : "..tostring(tab[12]));
		TRP2_debug("Slot 3 ID : "..tostring(tab[13]).." Vernum : "..tostring(tab[14]).." Qte : "..tostring(tab[15]).." Charges : "..tostring(tab[16]).." Lifetime : "..tostring(tab[17]));
		TRP2_debug("Slot 4 ID : "..tostring(tab[18]).." Vernum : "..tostring(tab[19]).." Qte : "..tostring(tab[20]).." Charges : "..tostring(tab[21]).." Lifetime : "..tostring(tab[22]));
	else
		TRP2_SecureSendAddonMessage("OTCA","",sender);
	end
end

function TRP2_ExchangeConvertToString()
	local message = "";
	message = message..TRP2_ExchangeMonTab["Cible"]..TRP2_ReservedChar;
	message = message..TRP2_GetWithDefaut(TRP2_ExchangeMonTab,"Or",0)..TRP2_ReservedChar;
	local i;
	for i=1,4,1 do
		local Slot = TRP2_GetSlotTab(TRP2_ExchangeMonTab["Slot"][tostring(i)],"Sac");
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

function TRP2_OKTransaction()
	if not tonumber(TRP2_ExchangeMonTab["Or"]) or tonumber(TRP2_ExchangeMonTab["Or"]) <= TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Sac"]["Or"] then
		TRP2_ExchangeMonTab["Ok"] = 1;
		TRP2_SecureSendAddonMessage("OTOK",TRP2_ExchangeConvertToString(),TRP2_ExchangeMonTab["Cible"]);
	else
		TRP2_Error(ERR_NOT_ENOUGH_MONEY);
	end
end

function TRP2_OKTransactionReceive(sender)
	if TRP2_ExchangeMonTab and TRP2_ExchangeMonTab["Cible"] == sender then
		TRP2_ExchangeSonTab["Ok"] = 1;
	end
end

function TRP2_CancelTransaction()
	local target;
	TRP2_ExchangeFrame:Hide();
	if TRP2_ExchangeMonTab then
		target = TRP2_ExchangeMonTab["Cible"];
		wipe(TRP2_ExchangeMonTab);
	end
	TRP2_ExchangeMonTab = nil;
	if TRP2_ExchangeSonTab then
		wipe(TRP2_ExchangeSonTab);
	end
	TRP2_ExchangeSonTab = nil;
	if target then
		TRP2_SecureSendAddonMessage("OTCA","",target);
	end
	TRP2_Error("{r}"..ERR_TRADE_CANCELLED);
end

function TRP2_CancelTransactionReceive(sender)
	if TRP2_ExchangeMonTab and TRP2_ExchangeMonTab["Cible"] == sender then
		TRP2_ExchangeFrame:Hide();
		if TRP2_ExchangeMonTab then
			wipe(TRP2_ExchangeMonTab);
		end
		TRP2_ExchangeMonTab = nil;
		if TRP2_ExchangeSonTab then
			wipe(TRP2_ExchangeSonTab);
		end
		TRP2_ExchangeSonTab = nil;
		TRP2_Error(ERR_TRADE_CANCELLED);
	end
end


function TRP2_ExchangeSetOr(Or)
	if not TRP2_ExchangeMonTab then
		return;
	end
	if Or then
		TRP2_ExchangeMonTab["Or"] = Or;
	else
		TRP2_ExchangeMonTab["Or"] = "0";
	end
	TRP2_ExchangeSonTab["Ok"] = 0;
	TRP2_ExchangeMonTab["Ok"] = 0;
	TRP2_SecureSendAddonMessage("OTUP",TRP2_ExchangeConvertToString(),TRP2_ExchangeMonTab["Cible"]);
end

function TRP2_ExchangeSetSlot(SlotID, ExchangeSlot)
	if not TRP2_ExchangeMonTab then
		return;
	end
	-- On elimine si il est déjà dedans
	for i=1,4,1 do
		if TRP2_ExchangeMonTab["Slot"][tostring(i)] == SlotID then
			TRP2_ExchangeMonTab["Slot"][tostring(i)] = nil;
		end
	end
	-- On l'ajoute
	if ExchangeSlot == nil then
		for i=1,4,1 do
			if TRP2_ExchangeMonTab["Slot"][tostring(i)] == nil then
				ExchangeSlot = tostring(i);
			end
		end
	end
	if ExchangeSlot then
		TRP2_ExchangeMonTab["Slot"][tostring(ExchangeSlot)] = SlotID;
	end
	TRP2_ExchangeSonTab["Ok"] = 0;
	TRP2_ExchangeMonTab["Ok"] = 0;
	TRP2_SecureSendAddonMessage("OTUP",TRP2_ExchangeConvertToString(),TRP2_ExchangeMonTab["Cible"]);
end

function TRP2_ProceedExchange()
	local i;
	-- On supprime ce qu'il y a dans son tableau
	for i=1,4,1 do
		if TRP2_ExchangeMonTab["Slot"][tostring(i)] then
			TRP2_InvDelObjet("Sac",TRP2_ExchangeMonTab["Slot"][tostring(i)],true);
		end
	end
	-- On ajoute ce qu'il y a dans le tableau de l'autre
	for i=1,4,1 do
		if TRP2_ExchangeSonTab["Slot"][tostring(i)] and TRP2_ExchangeSonTab["Slot"][tostring(i)]["ID"] then
			local ID = TRP2_ExchangeSonTab["Slot"][tostring(i)]["ID"];
			local Qte = TRP2_ExchangeSonTab["Slot"][tostring(i)]["Qte"];
			local Charges = TRP2_ExchangeSonTab["Slot"][tostring(i)]["Charges"];
			local Lifetime = TRP2_ExchangeSonTab["Slot"][tostring(i)]["Lifetime"];
			TRP2_InvAddObjet(ID,"Sac",Charges,Qte,Lifetime,nil,true);
		end
	end
	-- On retire son or
	if TRP2_EmptyToNil(TRP2_ExchangeMonTab["Or"]) and tonumber(TRP2_ExchangeMonTab["Or"]) then
		TRP2_InvDelGold("Sac",tonumber(TRP2_ExchangeMonTab["Or"]),true);
	end
	-- On ajoute son or
	if TRP2_EmptyToNil(TRP2_ExchangeSonTab["Or"]) and tonumber(TRP2_ExchangeSonTab["Or"]) then
		TRP2_InvAddGold("Sac",tonumber(TRP2_ExchangeSonTab["Or"]),true);
	end
	-- On confirme
	TRP2_Afficher("{j}"..ERR_TRADE_COMPLETE);
end

-- ECHANGES refresh
function TRP2_ExchangeFrameRefresh()
	if not TRP2_ExchangeMonTab or not TRP2_ExchangeSonTab then
		TRP2_ExchangeFrame:Hide();
	end
	
	-------------------
	-- PROCEED
	-------------------
	if TRP2_ExchangeMonTab["Ok"] == 1 and TRP2_ExchangeSonTab["Ok"] == 1 then
		TRP2_ExchangeFrame:Hide();
		TRP2_ProceedExchange();
	end
	
	local i;
	-------------------
	-- MOI
	-------------------
	if TRP2_ExchangeMonTab["Ok"] == 1 then
		TRP2_ExchangeFrameOrFrameLeftOK:Show();
	else
		TRP2_ExchangeFrameOrFrameLeftOK:Hide();
	end
	-- SLOTS
	for i=1,4,1 do
		if TRP2_ExchangeMonTab["Slot"][tostring(i)] and TRP2_ExchangeMonTab["Slot"][tostring(i)] then
			if TRP2_GetSlotTab(TRP2_ExchangeMonTab["Slot"][tostring(i)], "Sac") then
				local ID = TRP2_GetSlotTab(TRP2_ExchangeMonTab["Slot"][tostring(i)], "Sac")["ID"];
				local Qte = TRP2_GetSlotTab(TRP2_ExchangeMonTab["Slot"][tostring(i)], "Sac")["Qte"];
				local ObjetTab = TRP2_GetObjectTab(ID);
				getglobal("TRP2_ExchangeFrameLeftFrameObjet"..i.."Nom"):SetText(TRP2_CTS(TRP2_ItemQuality[TRP2_GetInt(TRP2_GetWithDefaut(ObjetTab,"Qualite",1))]..TRP2_GetWithDefaut(ObjetTab,"Nom",TRP2_LOC_NEW_Objet)));
				if Qte > 1 then
					getglobal("TRP2_ExchangeFrameLeftFrameObjet"..i.."Qte"):SetText(Qte);
				else
					getglobal("TRP2_ExchangeFrameLeftFrameObjet"..i.."Qte"):SetText("");
				end
				getglobal("TRP2_ExchangeFrameLeftFrameObjet"..i.."Icon"):SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(ObjetTab,"Icone","Temp.blp"));
				getglobal("TRP2_ExchangeFrameLeftFrameObjet"..i):SetScript("OnEnter", function(self)
					TRP2_SetObjetTooltip(TRP2_GetSlotTab(TRP2_ExchangeMonTab["Slot"][tostring(i)], "Sac"),self,1);
				end);
			else
				TRP2_ExchangeMonTab["Slot"][tostring(i)] = nil;
			end
		else
			getglobal("TRP2_ExchangeFrameLeftFrameObjet"..i.."Icon"):SetTexture("Interface\\PaperDoll\\UI-PaperDoll-Slot-Bag");
			getglobal("TRP2_ExchangeFrameLeftFrameObjet"..i.."Qte"):SetText("");
			getglobal("TRP2_ExchangeFrameLeftFrameObjet"..i.."Nom"):SetText("");
			getglobal("TRP2_ExchangeFrameLeftFrameObjet"..i):SetScript("OnEnter", function() end);
		end
	end
	-- OR
	if not TRP2_EmptyToNil(TRP2_ExchangeMonTab["Or"]) then TRP2_ExchangeMonTab["Or"] = "0" end
	TRP2_ExchangeFrameLeftFrameOr.texte = TRP2_CTS("{w}"..TRP2_GoldToText(TRP2_ExchangeMonTab["Or"]));
	
	
	-------------------
	-- LUI
	-------------------
	if TRP2_ExchangeSonTab["Ok"] == 1 then
		TRP2_ExchangeFrameOrFrameRightOK:Show();
	else
		TRP2_ExchangeFrameOrFrameRightOK:Hide();
	end
	-- SLOTS
	for i=1,4,1 do
		if TRP2_ExchangeSonTab["Slot"][tostring(i)] and TRP2_ExchangeSonTab["Slot"][tostring(i)] and TRP2_ExchangeSonTab["Slot"][tostring(i)]["ID"] then
			local ObjetTab = TRP2_GetObjectTab(TRP2_ExchangeSonTab["Slot"][tostring(i)]["ID"]);
			getglobal("TRP2_ExchangeFrameRightFrameObjet"..i.."Icon"):SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(ObjetTab,"Icone","Temp"));
			getglobal("TRP2_ExchangeFrameRightFrameObjet"..i.."Nom"):SetText(TRP2_CTS(TRP2_ItemQuality[TRP2_GetInt(TRP2_GetWithDefaut(ObjetTab,"Qualite",1))]..TRP2_GetWithDefaut(ObjetTab,"Nom",TRP2_LOC_NEW_Objet)));
			local falseSlotTab = {};
			falseSlotTab["ID"] = TRP2_ExchangeSonTab["Slot"][tostring(i)]["ID"];
			falseSlotTab["Qte"] = TRP2_ExchangeSonTab["Slot"][tostring(i)]["Qte"];
			falseSlotTab["Charges"] = TRP2_ExchangeSonTab["Slot"][tostring(i)]["Charges"];
			falseSlotTab["Lifetime"] = TRP2_ExchangeSonTab["Slot"][tostring(i)]["Lifetime"];
			if falseSlotTab["Qte"] > 1 then
				getglobal("TRP2_ExchangeFrameRightFrameObjet"..i.."Qte"):SetText(falseSlotTab["Qte"]);
			else
				getglobal("TRP2_ExchangeFrameRightFrameObjet"..i.."Qte"):SetText("");
			end
			getglobal("TRP2_ExchangeFrameRightFrameObjet"..i):SetScript("OnEnter", function(self)
				TRP2_SetObjetTooltip(falseSlotTab,self,4);
			end);
		else
			getglobal("TRP2_ExchangeFrameRightFrameObjet"..i.."Icon"):SetTexture("Interface\\PaperDoll\\UI-PaperDoll-Slot-Bag");
			getglobal("TRP2_ExchangeFrameRightFrameObjet"..i.."Qte"):SetText("");
			getglobal("TRP2_ExchangeFrameRightFrameObjet"..i.."Nom"):SetText("");
			getglobal("TRP2_ExchangeFrameRightFrameObjet"..i):SetScript("OnEnter", function() end);
		end
	end
	-- OR
	if not TRP2_EmptyToNil(TRP2_ExchangeSonTab["Or"]) then TRP2_ExchangeSonTab["Or"] = "0" end
	TRP2_ExchangeFrameRightFrameOr:SetText(TRP2_CTS("{w}"..TRP2_GoldToText(TRP2_ExchangeSonTab["Or"])));
end

-- Colis
function TRP2_MakeAColis(button)
	if not button.SlotID or not button.TRPtype or not button.ObjetID then
		return;
	end
	local ObjetTab = TRP2_GetObjectTab(button.ObjetID);
	TRP2_ColisFrameNom:SetText("");
	TRP2_ColisFrameMessage:SetText("");
	TRP2_ColisFrameObjetIcon:SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(ObjetTab,"Icone","Temp"));
	TRP2_ColisFrameObjet:SetScript("OnEnter",function(self)
		TRP2_SetObjetTooltip(button.Slot,TRP2_ColisFrameObjet,5);
	end);
	TRP2_ColisFrameObjetConfirm:SetScript("OnClick",function(self)
		local colis = {};
		TRP2_tcopy(colis,button.Slot);
		colis["Cible"] = TRP2_ColisFrameNom:GetText();
		colis["Message"] = TRP2_EmptyToNil(TRP2_ColisFrameMessage:GetText());
		tinsert(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["OutBox"],1,colis);
		TRP2_InvDelObjet("Sac",button.SlotID,true);
		TRP2_Afficher(TRP2_LOC_INV_COLISMADE);
		TRP2_ColisFrame:Hide();
	end);
	TRP2_ColisFrameNom:SetScript("OnTextChanged",function(self)
		if TRP2_EmptyToNil(self:GetText()) then
			TRP2_ColisFrameObjetConfirm:Enable();
		else
			TRP2_ColisFrameObjetConfirm:Disable();
		end
	end);
	TRP2_ColisFrameObjetConfirm:Disable();
	TRP2_ColisFrame:Show();
end

function TRP2_ColisToString(tab,mode)
	local ObjetTab = TRP2_GetObjectTab(tab["ID"]);
	local titre = "|TInterface\\ICONS\\"..TRP2_GetWithDefaut(ObjetTab,"Icone","Temp")..":35:35|t "..TRP2_GetNameWithQuality(ObjetTab)
		.." x"..TRP2_GetWithDefaut(tab,"Qte",1);
	local mess;
	if mode == "Send" then
		mess = "{o}"..TRP2_LOC_DESTI.." : {w}"..TRP2_GetWithDefaut(tab,"Cible","");
	else
		mess = "{o}"..TRP2_LOC_SENDER.." : {w}"..TRP2_GetWithDefaut(tab,"Cible","");
	end
	if TRP2_EmptyToNil(TRP2_GetWithDefaut(tab,"Message")) then
		mess = mess.."\n{o}"..TRP2_LOC_Message.." :\n\"{w}"..TRP2_GetWithDefaut(tab,"Message").."{o}\"";
	end
	if mode == "Send" then
		mess = mess.."\n\n{j}"..TRP2_LOC_CLIC.." {w}: "..TRP2_LOC_SENDCOLIS;
		mess = mess.."\n{j}"..TRP2_LOC_CLICDROIT.." {w}: "..TRP2_LOC_GETCOLIS;
	else
		mess = mess.."\n\n{j}"..TRP2_LOC_CLIC.." {w}: "..TRP2_LOC_GETCOLIS;
		mess = mess.."\n{j}"..TRP2_LOC_CLICDROIT.." {w}: "..TRP2_LOC_DELETECOLIS;
	end
	return titre,mess;
end

function TRP2_SendColis(colis)
	local tab = TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["OutBox"][colis];
	
	if TRP2_IsMine(tab["Cible"]) then
		local colisTab = {}
		TRP2_tcopy(colisTab,TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["OutBox"][colis]);
		tinsert(TRP2_Module_Inventaire[TRP2_Royaume][tab["Cible"]]["InBox"],1,colisTab);
		wipe(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["OutBox"][colis]);
		TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["OutBox"][colis] = nil;
		TRP2_SetListFor("courrSend",UIParent);
	else
		-- ID - Qte - Charges - Lifetime - Message
		local serial = tab["ID"];
		serial = serial..TRP2_ReservedChar..TRP2_NilToDefaut(tab["Qte"],1)..TRP2_ReservedChar..TRP2_NilToDefaut(tab["Charges"],"")
			..TRP2_ReservedChar..TRP2_NilToDefaut(tab["Lifetime"],"")..TRP2_ReservedChar..TRP2_NilToDefaut(tab["Message"],"")..TRP2_ReservedChar..colis
			..TRP2_ReservedChar..TRP2_GetWithDefaut(TRP2_GetItemInfo(tab["ID"]),"VerNum",1);
		TRP2_SecureSendAddonMessage("COSN",serial,tab["Cible"]);
		TRP2_Afficher(TRP2_FT(TRP2_LOC_SENDCOLISMESS,tab["Cible"]));
	end
end

function TRP2_ReceiveColisOK(num,sender)
	if num and TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["OutBox"][num] then
		wipe(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["OutBox"][num]);
		TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["OutBox"][num] = nil;
		TRP2_Afficher(TRP2_FT(TRP2_LOC_SENDCOLISOK,sender));
		TRP2_SetListFor("courrSend",UIParent);
	end
end

function TRP2_ReceiveColis(tab,sender)
	-- ID = 1
	-- Qte = 2
	-- Charges = 3
	-- Lifetime = 4
	-- Message = 5
	-- Num = 6
	-- Vernum = 7
	local colis = {};
	colis["ID"] = tab[1];
	colis["Qte"] = tonumber(tab[2]);
	colis["Charges"] = tonumber(tab[3]);
	colis["Lifetime"] = tonumber(tab[4]);
	colis["Message"] = TRP2_EmptyToNil(tab[5]);
	colis["Cible"] = sender;
	tinsert(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["InBox"],1,colis);
	TRP2_SecureSendAddonMessage("COOK",tab[6],sender);
	TRP2_Afficher(TRP2_FT(TRP2_LOC_rECEIVECOLIS,sender));
	if TRP2_GetItemInfo(colis["ID"]) == nil or TRP2_GetWithDefaut(TRP2_GetItemInfo(colis["ID"]),"VerNum",1) < tonumber(tab[7]) then
		TRP2_OpenRequestForObject(colis["ID"],sender);
	end
end
