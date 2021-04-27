-------------------------------------------------------------------
--                          Total RP 2
--            A roleplay addon for World of Warcraft
-- Created by Sylvain "Telkostrasz" Cossement (up to version 1.017)
--   Licence : CC BY-NC-SA (http://creativecommons.org/licenses/)
-------------------------------------------------------------------

-- Retourne le tableau d'information d'un Aura créé
function TRP2_GetAuraInfo(AuraID)
	if AuraID and string.len(AuraID) == TRP2_IDSIZE then
		return TRP2_Module_Auras[AuraID] or TRP2_Module_AurasTemp[AuraID];
	elseif TRP2_DB_Auras then
		return TRP2_DB_Auras[AuraID];
	end
end

-- Returne true si l'Aura existe
function TRP2_AuraExist(ID)
	return TRP2_GetAuraInfo(AuraID) ~= nil;
end

-- Met à jour la frame d'aura
function TRP2_UpdateAuraTargetFrame()
	for i=1,15,1 do
		getglobal("TRP2_AuraTargetFrameAura"..i):Hide();
	end
	if TRP2_AuraTargetFrame.target then
		local AurasTab = {};
		if not TRP2_AuraTargetFrame.master then -- Joueur !
			AurasTab = TRP2_GetInfo(TRP2_AuraTargetFrame.target,"AurasTab",{});
		else -- Pet !
			AurasTab = TRP2_GetWithDefaut(TRP2_GetInfo(TRP2_AuraTargetFrame.master,"Pets",{})[TRP2_AuraTargetFrame.target],"AurasTab",{});
		end
		local i=0;
		for k,v in pairs(AurasTab) do -- k = auraID, v = timestamp de fin
			local auraInfo = TRP2_GetAuraInfo(k);
			if not TRP2_Module_Interface["BannedID"][k] and (auraInfo ~= nil or TRP2_AuraTargetFrame.target==TRP2_Joueur or TRP2_AuraTargetFrame.master == TRP2_Joueur) then
				local temps = 0;
				if v ~= 0 and not TRP2_AuraTargetFrame.master then
					temps = v;
				end
				i = i + 1;
				local titre,suite = TRP2_GetTooltipAura(k,temps)
				if TRP2_GetWithDefaut(auraInfo,"bDeletable",true) and (TRP2_AuraTargetFrame.master == TRP2_Joueur or TRP2_AuraTargetFrame.target == TRP2_Joueur) then
					suite = suite.."\n\n{j}"..TRP2_LOC_CLICDROIT.." : {w}"..TRP2_LOC_AuraRemove;
					_G["TRP2_AuraTargetFrameAura"..i]:SetScript("OnClick",function(self,button)
						if button == "RightButton" then
							if not TRP2_AuraTargetFrame.master then
								TRP2_RemoveAura(k,true);
							else
								TRP2_RemoveAuraPet(k,true,TRP2_AuraTargetFrame.target);
							end
						end
					end);
				else
					_G["TRP2_AuraTargetFrameAura"..i]:SetScript("OnClick",function(self,button) end);
				end
				_G["TRP2_AuraTargetFrameAura"..i]:Show();
				_G["TRP2_AuraTargetFrameAura"..i]:SetNormalTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(auraInfo,"Icone","Temp"));
				TRP2_SetTooltipForFrame(
					_G["TRP2_AuraTargetFrameAura"..i],_G["TRP2_AuraTargetFrameAura"..i],"BOTTOMRIGHT",0,0,
					titre,suite
				);
			end
		end
		if i == 0 then
			TRP2_AuraTargetFrame:SetAlpha(0);
		else
			TRP2_AuraTargetFrame:SetAlpha(1);
			if i < 5 then
				TRP2_AuraTargetFrame:SetWidth((i*16) + ((i-1)*5) + 20);
				TRP2_AuraTargetFrame:SetHeight(36);
			else
				TRP2_AuraTargetFrame:SetWidth(120);
				TRP2_AuraTargetFrame:SetHeight((math.ceil(i/5)*16) + ((math.ceil(i/5)-1)*5) + 20);
			end
			TRP2_AuraTargetFrameEmpty:Hide();
		end
	end
end

function TRP2_SetTargetEtatPosition()
	TRP2_AuraTargetFrame:ClearAllPoints();
	local frame = TargetFrame;
	if getglobal(TRP2_GetConfigValueFor("TargetEtatFrame")) then
		frame = getglobal(TRP2_GetConfigValueFor("TargetEtatFrame"));
	end
	TRP2_AuraTargetFrame:SetParent(frame);
	TRP2_AuraTargetFrame:SetPoint("TOPLEFT",frame,"TOPRIGHT",TRP2_GetConfigValueFor("TargetEtatX",175)-200,TRP2_GetConfigValueFor("TargetEtatY",175)-200);
end

-- Format pour le tooltip
function TRP2_FormatAuraToText(nom)
	local AurasTab = TRP2_GetInfo(nom,"AurasTab",{});
	local texte="   ";
	local i = 1;
	for auraID,_ in pairs(AurasTab) do
		if not TRP2_Module_Interface["BannedID"][auraID] then
			local auraInfo = TRP2_GetAuraInfo(auraID);
			if not auraInfo and nom ~= TRP2_Joueur and string.len(auraID) == TRP2_IDSIZE then
				if not TRP2_Module_AurasTemp[auraID] then
					TRP2_Module_AurasTemp[auraID] = {};
				end
				TRP2_OpenRequestForObject(auraID,nom);
			elseif auraInfo then
				texte = texte.."|TInterface\\ICONS\\"..TRP2_GetWithDefaut(auraInfo,"Icone","Temp")..":18:18|t ";
				if math.floor(i/8) == i/8 then
					texte = texte.."\n   ";
				end
				i = i+1;
			end
		end
	end
	return texte;
end

function TRP2_FormatAuraToTextPet(NomMaitre,Nom)
	local AurasTab = TRP2_GetWithDefaut(TRP2_GetInfo(NomMaitre,"Pets",{})[Nom],"AurasTab",{});
	local texte="   ";
	local i = 1;
	for auraID,_ in pairs(AurasTab) do
		if not TRP2_Module_Interface["BannedID"][auraID] then
			local auraInfo = TRP2_GetAuraInfo(auraID);
			if not auraInfo and NomMaitre ~= TRP2_Joueur then
				if not TRP2_Module_AurasTemp[auraID] then
					TRP2_Module_AurasTemp[auraID] = {};
				end
				TRP2_OpenRequestForObject(auraID,NomMaitre);
			elseif auraInfo then
				texte = texte.."|TInterface\\ICONS\\"..TRP2_GetWithDefaut(auraInfo,"Icone","Temp")..":18:18|t ";
				if math.floor(i/8) == i/8 then
					texte = texte.."\n   ";
				end
				i = i+1;
			end
		end
	end
	return texte;
end

function TRP2_IncreaseVerNumAura()
	local vernum = TRP2_GetInfo(TRP2_Joueur,"AuraVerNum",0) + 1;
	if vernum > 999 then
		vernum = 0;
	end
	TRP2_SetInfo(TRP2_Joueur,"AuraVerNum",vernum);
end

-- Format pour l'envoi dans le message d'échange rapide
function TRP2_FormatAuraToSend(nom)
	local AurasTab = TRP2_GetInfo(nom,"AurasTab",{});
	local tab = {};
	for auraID,_ in pairs(AurasTab) do
		local info = TRP2_GetAuraInfo(auraID);
		if tonumber(TRP2_GetWithDefaut(info,"EtatCat",2)) ~= 2 then
			tab[auraID] = TRP2_GetWithDefaut(info,"VerNum",0);
		end
	end
	tab["VerNum"] = TRP2_GetInfo(nom,"AuraVerNum",0);
	return tab;
end

-- Enregistrement des Auras d'une autre personne
TRP2_EtatGetName = nil;
function TRP2_SaveSendedAurasTab(sender,infoTab)
	local AurasTab = TRP2_GetInfo(sender,"AurasTab",{});
	wipe(AurasTab);
	for k,v in pairs(infoTab) do
		if k ~= "VerNum" and not TRP2_Module_Interface["BannedID"][k] then
			AurasTab[k] = 0;
			-- check vernum (v)
			if string.len(k) == TRP2_IDSIZE and TRP2_GetWithDefaut(TRP2_GetAuraInfo(k),"VerNum",0) < tonumber(v) then
				if TRP2_Module_AurasTemp[k] == nil then
					TRP2_Module_AurasTemp[k] = {};
				end
				TRP2_OpenRequestForObject(k,sender);
			end
		end
	end
	TRP2_SetInfo(sender,"AuraVerNum",TRP2_GetWithDefaut(infoTab,"VerNum",0));
	TRP2_SetInfo(sender,"AurasTab",AurasTab);
	TRP2_EtatGetName = nil;
end

-- Retourne le nom coloré entouré de crochet orange
function TRP2_GetNameWithMode(objectTab)
	return TRP2_Auras_Color[TRP2_GetInt(TRP2_GetWithDefaut(objectTab,"Type",2))]..TRP2_GetWithDefaut(objectTab,"Nom",TRP2_LOC_NewAura);
end

function TRP2_EffetAuraScript(ID,Temps,Mode,Cible,bRand)
	if bRand then
		Temps = math.random(Temps);
	end
	if Cible == 1 then -- Joueur
		if Mode == 1 then
			TRP2_AddAura(ID,Temps,true);
		else
			TRP2_RemoveAura(ID,true);
		end
	else -- Autres
		local name;
		if Cible == 2 then -- Monture
			name = TRP2_GetActualMountName();
		elseif Cible == 3 then -- Pet
			name = UnitName("pet");
		elseif Cible == 4 then -- Mascotte
			name = TRP2_GetActualMinionName();
		end
		if name then
			if Mode == 1 then
				TRP2_AddAuraPet(ID,Temps,true,name);
			else
				TRP2_RemoveAuraPet(ID,true,name);
			end
		end
	end
end

function TRP2_AuraNumScript(num)
	if num == 1 then -- Joueur
		return TRP2_GetIndexedTabSize(TRP2_GetInfo(TRP2_Joueur,"AurasTab",{}));
	else
		local name;
		if num == 2 then -- Monture
			name = TRP2_GetActualMountName();
		elseif num == 3 then -- Pet
			name = UnitName("pet");
		elseif num == 4 then -- Minion
			name = TRP2_GetActualMinionName();
		end
		if name then
			return TRP2_GetIndexedTabSize(TRP2_GetWithDefaut(TRP2_GetInfo(TRP2_Joueur,"Pets",{})[name],"AurasTab",{}));
		end
	end
	return 0;
end

function TRP2_AuraGetTimeScript(ID,Cible)
	ID = string.upper(ID);
	--TRP2_debug(ID);
	if Cible == 5 then -- Cible du Joueur
		if not UnitIsPlayer("target") then
			return -1;
		end
		local AurasTab = TRP2_GetInfo(UnitName("target"),"AurasTab",{});
		if AurasTab[ID] then
			return 0;
		end
	elseif Cible == 1 then -- Joueur
		local AurasTab = TRP2_GetInfo(TRP2_Joueur,"AurasTab",{});
		--TRP2_debug("ici");
		if AurasTab[ID] then
			if AurasTab[ID] == 0 then return 0 end
			return AurasTab[ID] - time();
		end
	else -- Autres
		local name;
		if Cible == 2 then -- Monture
			name = TRP2_GetActualMountName();
		elseif Cible == 3 then -- Pet
			name = UnitName("pet");
		elseif Cible == 4 then -- Mascotte
			name = TRP2_GetActualMinionName();
		end
		if name then
			local AurasTab = TRP2_GetInfo(TRP2_Joueur,"Pets",{})[name];
			AurasTab = TRP2_GetWithDefaut(AurasTab,"AurasTab",{});
			if AurasTab[ID] then
				return 0;
			end
		end
	end
	return -1;
end

function TRP2_GetTooltipAura(id,timeLeft)
	local auraInfo = TRP2_GetAuraInfo(id);
	local Message = "";
	local Titre = ""
	
	if not auraInfo then
		Titre = TRP2_FT(TRP2_LOC_AuraNum,id);
		if string.len(id) == TRP2_IDSIZE then
			Message = TRP2_LOC_Aura_Error_1;
		elseif not IsAddOnLoaded("totalRP2_DataBase") then
			Message = TRP2_LOC_Aura_Error_2;
		else
			Message = TRP2_LOC_Aura_Error_3;
		end
	else
		Message = Message.."{v}< "..TRP2_Auras_Categorie[TRP2_GetInt(tonumber(TRP2_GetWithDefaut(auraInfo,"EtatCat",2)))].." >\n{w}\"{o}"..TRP2_GetWithDefaut(auraInfo,"Description","").."{w}\"";
		if timeLeft ~= 0 then
			Message = Message.."\n{w}"..TIME_REMAINING.." {o}"..TRP2_TimeToString(timeLeft - time());
		end
		Titre = TRP2_Auras_Color[TRP2_GetInt(TRP2_GetWithDefaut(auraInfo,"Type",2))].."|TInterface\\ICONS\\"..TRP2_GetWithDefaut(auraInfo,"Icone","Temp.blp")..":30:30|t\n"..TRP2_GetWithDefaut(auraInfo,"Nom",TRP2_LOC_NewAura);
	end
	return Titre,Message;
end

function TRP2_PlayerHasAura(auraID)
	return TRP2_GetInfo(TRP2_Joueur,"AurasTab",{})[auraID] ~= nil;
end

function TRP2_SetAuraTime(auraID,temps)
	local tab = TRP2_GetInfo(TRP2_Joueur,"AurasTab",{});
	tab[auraID] = time() + temps;
	TRP2_SetInfo(TRP2_Joueur,"AurasTab",tab);
end

-- Affichage dans la Fiche
function TRP2_AfficherAurasPour(nom)
	--Security
	if not nom then return end

	local i;
	for i=1,15,1 do
		getglobal("TRP2_RegistreOngletAura"..i):Hide();
	end
	TRP2_RegistreAurasPanelEmpty:Hide();
	
	local AurasTab = TRP2_GetInfo(nom,"AurasTab",{});
	
	i = 1;
	
	for auraID,timeLeft in pairs(AurasTab) do
		local auraInfo = TRP2_GetAuraInfo(auraID);
		if not TRP2_Module_Interface["BannedID"][auraID] and (auraInfo ~= nil or nom==TRP2_Joueur) then
			getglobal("TRP2_RegistreOngletAura"..i):Show();
			getglobal("TRP2_RegistreOngletAura"..i.."Icon"):SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(auraInfo,"Icone","Temp.blp"));
			if timeLeft ~= 0 then
				getglobal("TRP2_RegistreOngletAura"..i.."Time"):SetText(TRP2_TimeToString(timeLeft - time()));
			else
				getglobal("TRP2_RegistreOngletAura"..i.."Time"):SetText("");
			end
			getglobal("TRP2_RegistreOngletAura"..i.."HighText"):SetVertexColor(TRP2_Auras_Color_RGB[TRP2_GetInt(TRP2_GetWithDefaut(auraInfo,"Type",2))][1],
																TRP2_Auras_Color_RGB[TRP2_GetInt(TRP2_GetWithDefaut(auraInfo,"Type",2))][2],TRP2_Auras_Color_RGB[TRP2_GetInt(TRP2_GetWithDefaut(auraInfo,"Type",2))][3]);
			
			local Titre,Message = TRP2_GetTooltipAura(auraID,timeLeft);
			if TRP2_GetWithDefaut(auraInfo,"bDeletable",true) and nom == TRP2_Joueur then
				Message = Message.."\n\n{j}"..TRP2_LOC_CLICDROIT.." {w}: "..TRP2_LOC_AuraRemove;
				getglobal("TRP2_RegistreOngletAura"..i):SetScript("OnClick",function(self,button)
					if IsShiftKeyDown() then
						local activeWindow = ChatEdit_GetActiveWindow();
						if ( activeWindow ) then
							activeWindow:Insert("["..TRP2_GetWithDefaut(auraInfo,"Nom",TRP2_LOC_NewAura).."]");
						end
					elseif button == "RightButton" then
						StaticPopupDialogs["TRP2_CONFIRM_ACTION_NS"].text = TRP2_CTS(TRP2_FT(TRP2_ENTETE..TRP2_LOC_AuraRemoveSure,TRP2_GetNameWithMode(auraInfo).."{w}","{o}"..TRP2_Joueur.."{w}"));
						TRP2_ShowStaticPopup("TRP2_CONFIRM_ACTION_NS",nil,function()
							TRP2_RemoveAura(auraID,true);
						end);
					end
				end);
			else
				getglobal("TRP2_RegistreOngletAura"..i):SetScript("OnClick",function() 
					if IsShiftKeyDown() then
						local activeWindow = ChatEdit_GetActiveWindow();
						if ( activeWindow ) then
							activeWindow:Insert("["..TRP2_GetWithDefaut(auraInfo,"Nom",TRP2_LOC_NewAura).."]");
						end
					end
				end);
			end
			TRP2_SetTooltipForFrame(
				getglobal("TRP2_RegistreOngletAura"..i),getglobal("TRP2_RegistreOngletAura"..i),"RIGHT",-5,-5,
				Titre,
				Message
			);
			i = i+1;
		end
	end
	if i-1 < 1 then
		TRP2_RegistreAurasPanelEmpty:Show();
	end
end

-- Affichage dans la Fiche : FAMILIER
function TRP2_AfficherAurasPourPet(pet,nom)
	--Security
	if not nom or not pet then return end

	local i;
	for i=1,5,1 do
		getglobal("TRP2_PetOngletAura"..i):Hide();
	end
	TRP2_PetAurasPanelEmpty:Hide();
	
	local AurasTab = TRP2_GetInfo(nom,"Pets",{})[pet];
	AurasTab = TRP2_GetWithDefaut(AurasTab,"AurasTab",{});
	
	i = 1;
	for auraID,auraTab in pairs(AurasTab) do
		local auraInfo = TRP2_GetAuraInfo(auraID);
		if not TRP2_Module_Interface["BannedID"][auraID] and (auraInfo ~= nil or nom==TRP2_Joueur) then
			local auraTab = AurasTab[auraID];
			getglobal("TRP2_PetOngletAura"..i):Show();
			getglobal("TRP2_PetOngletAura"..i.."Icon"):SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(auraInfo,"Icone","Temp"));
			getglobal("TRP2_PetOngletAura"..i.."Time"):SetText("");
			getglobal("TRP2_PetOngletAura"..i.."HighText"):SetVertexColor(TRP2_Auras_Color_RGB[TRP2_GetWithDefaut(auraInfo,"Type",2)][1],
																TRP2_Auras_Color_RGB[TRP2_GetWithDefaut(auraInfo,"Type",2)][2],TRP2_Auras_Color_RGB[TRP2_GetWithDefaut(auraInfo,"Type",2)][3]);
			local Message = "";
			local Titre = ""
			
			if not auraInfo then
				Titre = TRP2_FT(TRP2_LOC_AuraNum,auraID);
				if string.len(auraID) == TRP2_IDSIZE then
					Message = TRP2_LOC_Aura_Error_1;
				elseif not TRP2_DB_Auras then
					Message = TRP2_LOC_Aura_Error_2;
				else
					Message = TRP2_LOC_Aura_Error_3;
				end
			else
				Message = Message.."{w}\"{o}"..TRP2_GetWithDefaut(auraInfo,"Description","").."{w}\"";
				Titre = TRP2_Auras_Color[TRP2_GetWithDefaut(auraInfo,"Type",2)].."|TInterface\\ICONS\\"..TRP2_GetWithDefaut(auraInfo,"Icone","Temp")..":30:30|t "..TRP2_GetWithDefaut(auraInfo,"Nom",TRP2_LOC_NewAura);
			end
			if nom == TRP2_Joueur then
				Message = Message.."\n\n{j}"..TRP2_LOC_CLICDROIT.." {w}: "..TRP2_LOC_AuraRemove;
			end
			getglobal("TRP2_PetOngletAura"..i):SetScript("OnClick",function(button)
				if nom == TRP2_Joueur then
					StaticPopupDialogs["TRP2_CONFIRM_ACTION_NS"].text = TRP2_CTS(TRP2_FT(TRP2_ENTETE..TRP2_LOC_AuraRemoveSure,TRP2_GetNameWithMode(auraInfo).."{w}","{o}"..pet.."{w}"));
					TRP2_ShowStaticPopup("TRP2_CONFIRM_ACTION_NS",nil,function()
						TRP2_RemoveAuraPet(auraID,message,TRP2MainFrame.Mode);
					end);
				end
			end);
			TRP2_SetTooltipForFrame(
				getglobal("TRP2_PetOngletAura"..i),getglobal("TRP2_PetOngletAura"..i),"RIGHT",-5,-5,
				Titre,
				Message
			);
			i = i+1;
		end
	end
	if i-1 < 1 then
		TRP2_PetAurasPanelEmpty:Show();
	end
end

function TRP2_RemoveAura(auraID,message)
	local AurasTab = TRP2_GetInfo(TRP2_Joueur,"AurasTab",{});
	if AurasTab[auraID] then
		AurasTab[auraID] = nil;
		TRP2_IncreaseVerNumAura();
		TRP2_SetInfo(TRP2_Joueur,"AurasTab",AurasTab);
		AuraInfo = TRP2_GetAuraInfo(auraID);
		if message then
			TRP2_Afficher(TRP2_FT(TRP2_LOC_AuraDeleteNot,TRP2_GetNameWithMode(AuraInfo),
					"{v}"..TRP2_GetPlayerPrenom().."{j}"))
		end
		if TRP2MainFrame.Panel == "Fiche" and TRP2MainFrame.SousOnglet == "Caracteristiques" and TRP2MainFrame.Nom == TRP2_Joueur then
			TRP2_AfficherAurasPour(TRP2_Joueur);
		end
		if UnitName("target") == TRP2_Joueur then
			TRP2_UpdateAuraTargetFrame();
		end
		if TRP2_CheckConditions(TRP2_GetWithDefaut(AuraInfo,"OnDestroyCondi")) then
			if TRP2_PlayScripts(TRP2_GetWithDefaut(AuraInfo,"OnDestroyScripts"),auraID) ~= false then
				TRP2_PlayEffect(TRP2_GetWithDefaut(AuraInfo,"OnDestroyEffet",""),
					TRP2_LOC_CreationTypeEtat.." - "..TRP2_GetNameWithMode(AuraInfo),auraID,nil,nil,TRP2_GetWithDefaut(AuraInfo,"Createur","")
				);
			end
		end
	end
end

function TRP2_RemoveAuraPet(auraID,message,petName)
	local petTab = TRP2_GetInfo(TRP2_Joueur,"Pets",{});
	local AurasTab = TRP2_GetWithDefaut(petTab[petName],"AurasTab",{});
	
	if AurasTab[auraID] then
		AurasTab[auraID] = nil;
		--TRP2_IncreaseVerNumAura();
		petTab[petName]["AurasVerNum"] = TRP2_GetWithDefaut(petTab[petName],"AurasVerNum",0) + 1;
		if TRP2_GetIndexedTabSize(AurasTab) > 0 then
			petTab[petName]["AurasTab"] = AurasTab;
		else
			petTab[petName]["AurasTab"] = nil;
		end
		TRP2_SetInfo(TRP2_Joueur,"Pets",petTab);
		AuraInfo = TRP2_GetAuraInfo(auraID);
		if UnitName("target") == petName then
			TRP2_UpdateAuraTargetFrame();
		end
		if message then
			TRP2_Afficher(TRP2_FT(TRP2_LOC_AuraDeleteNot,TRP2_GetNameWithMode(AuraInfo),
					"{v}"..TRP2_GetWithDefaut(petTab[petName],"Nom",petName).."{j}"))
		end
		TRP2_AfficherAurasPourPet(petName,TRP2_Joueur);
	end
end

function TRP2_AddAura(auraID,duration,message)
	local AurasTab = TRP2_GetInfo(TRP2_Joueur,"AurasTab",{});
	local num = TRP2_GetIndexedTabSize(AurasTab);
	AuraInfo = TRP2_GetAuraInfo(auraID);
	if not TRP2_Module_Interface["BannedID"][auraID] then
		if (AurasTab[auraID] or num < 15) then
			if AurasTab[auraID] then
				message = false;
			end
			if duration ~= 0 then
				AurasTab[auraID] = time() + duration;
			else
				AurasTab[auraID] = 0;
			end
			TRP2_SetInfo(TRP2_Joueur,"AurasTab",AurasTab);
			TRP2_IncreaseVerNumAura();
			if message then
				TRP2_Afficher(TRP2_FT(TRP2_LOC_AuraAjoutNot,TRP2_GetNameWithMode(AuraInfo),
						"{v}"..TRP2_GetPlayerPrenom().."{j}"))
			end
			if TRP2MainFrame.Panel == "Fiche" and TRP2MainFrame.SousOnglet == "Caracteristiques" and TRP2MainFrame.Nom == TRP2_Joueur then
				TRP2_AfficherAurasPour(TRP2_Joueur);
			end
			if UnitName("target") == TRP2_Joueur then
				TRP2_UpdateAuraTargetFrame();
			end
			if TRP2_CheckConditions(TRP2_GetWithDefaut(AuraInfo,"OnReceiveCondi")) then
				if TRP2_PlayScripts(TRP2_GetWithDefaut(AuraInfo,"OnReceiveScripts"),auraID) ~= false then
					TRP2_PlayEffect(TRP2_GetWithDefaut(AuraInfo,"OnReceiveEffet",""),
						TRP2_LOC_CreationTypeEtat.." - "..TRP2_GetNameWithMode(AuraInfo),auraID,nil,nil,TRP2_GetWithDefaut(AuraInfo,"Createur","")
					);
				end
			end
		elseif message then
			TRP2_Afficher(TRP2_LOC_Aura_Error_4);
		end
	end
end

function TRP2_AddAuraPet(auraID,duration,message,petName)
	local petTab = TRP2_GetInfo(TRP2_Joueur,"Pets",{});
	local AurasTab = TRP2_GetWithDefaut(petTab[petName],"AurasTab",{});
	
	local num = TRP2_GetIndexedTabSize(AurasTab);
	AuraInfo = TRP2_GetAuraInfo(auraID);
	if not TRP2_Module_Interface["BannedID"][auraID] then
		if AurasTab[auraID] or num < 5 then
			if AurasTab[auraID] then
				message = false;
			end
			AurasTab[auraID] = TRP2_GetWithDefaut(AuraInfo,"VerNum",0);
			if not petTab[petName] then
				petTab[petName] = {};
			end
			petTab[petName]["AurasVerNum"] = TRP2_GetWithDefaut(petTab[petName],"AurasVerNum",0) + 1;
			petTab[petName]["AurasTab"] = AurasTab;
			if not petTab[petName]["VerNum"] then
				petTab[petName]["VerNum"] = 1;
			end
			TRP2_SetInfo(TRP2_Joueur,"Pets",petTab);
			if UnitName("target") == petName then
				TRP2_UpdateAuraTargetFrame();
			end
			--TRP2_IncreaseVerNumAura();
			if message then
				TRP2_Afficher(TRP2_FT(TRP2_LOC_AuraAjoutNot,TRP2_GetNameWithMode(AuraInfo),
						"{v}"..TRP2_GetWithDefaut(petTab[petName],"Nom",petName).."{j}"))
			end
			TRP2_AfficherAurasPourPet(petName,TRP2_Joueur);
		else
			TRP2_Afficher(TRP2_LOC_Aura_Error_4);
		end
	end
end

function TRP2_RefreshAura()
	local auraTab = TRP2_GetInfo(TRP2_Joueur,"AurasTab",{});
	for aura,temps in pairs(auraTab) do
		local AuraInfo = TRP2_GetAuraInfo(aura);
		if temps ~= 0 and temps <= time() then
			auraTab[aura] = nil;
			TRP2_IncreaseVerNumAura();
			TRP2_Afficher(TRP2_FT(TRP2_LOC_AuraDeleteNot,TRP2_GetNameWithMode(AuraInfo),
					"{v}"..TRP2_GetPlayerPrenom().."{j}"));
			if TRP2_CheckConditions(TRP2_GetWithDefaut(AuraInfo,"OnLifeTimeCondi")) then
				if TRP2_PlayScripts(TRP2_GetWithDefaut(AuraInfo,"OnLifeTimeScripts"),aura) ~= false then
					TRP2_PlayEffect(TRP2_GetWithDefaut(AuraInfo,"OnLifeTimeEffet",""),
						TRP2_LOC_CreationTypeEtat.." - "..TRP2_Auras_Color[TRP2_GetInt(TRP2_GetWithDefaut(AuraInfo,"Type",2))]..TRP2_GetWithDefaut(AuraInfo,"Nom",TRP2_LOC_NewAura),
						aura,nil,nil,TRP2_GetWithDefaut(AuraInfo,"Createur","")
					);
				end
			end
		elseif TRP2_CheckConditions(TRP2_GetWithDefaut(AuraInfo,"OnUpdateCondi")) then
			if TRP2_PlayScripts(TRP2_GetWithDefaut(AuraInfo,"OnUpdateScripts"),aura) ~= false then
				TRP2_PlayEffect(TRP2_GetWithDefaut(AuraInfo,"OnUpdateEffet",""),
					TRP2_LOC_CreationTypeEtat.." - "..TRP2_Auras_Color[TRP2_GetInt(TRP2_GetWithDefaut(AuraInfo,"Type",2))]..TRP2_GetWithDefaut(AuraInfo,"Nom",TRP2_LOC_NewAura),
					aura,nil,nil,TRP2_GetWithDefaut(AuraInfo,"Createur","")
				);
			end
		end
	end
	TRP2_SetInfo(TRP2_Joueur,"AurasTab",auraTab);
end
