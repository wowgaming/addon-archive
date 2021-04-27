-------------------------------------------------------------------
--                          Total RP 2
--            A roleplay addon for World of Warcraft
-- Created by Sylvain "Telkostrasz" Cossement (up to version 1.017)
--   Licence : CC BY-NC-SA (http://creativecommons.org/licenses/)
-------------------------------------------------------------------

function TRP2_GetLangageInfo(ID)
	if TRP2_Module_Language[ID] then
		return TRP2_Module_Language[ID];
	elseif TRP2_DB_Languages and TRP2_DB_Languages[ID] then
		return TRP2_DB_Languages[ID];
	end
end

function TRP2_LangScript(id,comp,mode)
	local LanguesTab = TRP2_GetInfo(TRP2_Joueur,"Langues",{});
	comp = tonumber(comp);
	if not comp then comp = 0 end
	if LanguesTab[id] then
		local competence = TRP2_GetWithDefaut(LanguesTab[id],"Competence",0) + comp;
		competence = min(competence,100);
		competence = max(competence,0);
		TRP2_AddLangage(id,competence,true,false);
	else
		if mode == 2 then
			StaticPopupDialogs["TRP2_CONFIRM_ACTION_NS"].text = TRP2_CTS(TRP2_FT(TRP2_ENTETE..TRP2_LOC_ADDLANG,TRP2_GetWithDefaut(TRP2_GetLangageInfo(id),"Entete",id)));
			TRP2_ShowStaticPopup("TRP2_CONFIRM_ACTION_NS",nil,function() 
				TRP2_AddLangage(id,min(max(comp,0),100),true,false);
			end);
		elseif mode == 3 then
			TRP2_AddLangage(id,min(max(comp,0),100),true,false);
		end
	end
end

function TRP2_OpenPanelLangues(onglet, sousonglet, mode, nom, arg1, arg2)
	TRP2MainFrameLangageMain:Hide();
	
	TRP2_InitDialectList();

	if not onglet then
		onglet = "Main";
	end

	TRP2_RefreshLangueListe();
	TRP2_PanelTitle:SetText(TRP2_Joueur.." : "..TRP2_LOC_DIALECTES);
	TRP2MainFrameLangageMain:Show();
	
	TRP2MainFrameLangage:Show();
	return onglet, sousonglet, mode, nom, arg1, arg2;
end

function TRP2_SelectDialecte(ID,message)
	local LangueTab = TRP2_GetLangageInfo(ID);
	TRP2_SetInfo(TRP2_Joueur,"SelectDial",ID);
	if message then
		TRP2_Afficher(TRP2_FT(TRP2_LOC_YOUSPEAKNOW,TRP2_Joueur,TRP2_GetWithDefaut(LangueTab,"Entete",ID)));
	end
	TRP2_RefreshLangueListe();
end

function TRP2_GetDialectComp(ID)
	local LanguesTab = TRP2_GetInfo(TRP2_Joueur,"Langues",{});
	if LanguesTab[ID] then
		return TRP2_GetWithDefaut(LanguesTab[ID],"Competence",0);
	end
	return -1;
end

function TRP2_OubliLangage(ID,message)
	local LanguesTab = TRP2_GetInfo(TRP2_Joueur,"Langues",{});
	local LangueTab = TRP2_GetLangageInfo(ID);
	if LanguesTab[ID] then
		wipe(LanguesTab[ID]);
		LanguesTab[ID] = nil;
		if message then
			TRP2_Afficher(TRP2_FT(TRP2_LOC_FORGETLANG,TRP2_Joueur,TRP2_GetWithDefaut(LangueTab,"Entete",ID)));
		end
		TRP2_SetInfo(TRP2_Joueur,"Langues",LanguesTab);
		if TRP2_GetInfo(TRP2_Joueur,"SelectDial") == ID then
			TRP2_SetInfo(TRP2_Joueur,"SelectDial");
		end
	end
	TRP2_InitDialectList();
	TRP2_RefreshLangueListe();
end

function TRP2_InitDialectList()
	local LanguesTab = TRP2_GetInfo(TRP2_Joueur,"Langues",{});
        
        local NonBlizzLanguages = {};--Added by Lixxel
        for k,v in pairs(LanguesTab) do
            NonBlizzLanguages[k]=v;
        end
        
	local i;
	if(GetNumLanguages()) then
		for i=1,GetNumLanguages() do
			local langue = select(1, GetLanguageByIndex(i));
			if not LanguesTab[langue] then
			    TRP2_AddLangage(langue,100,true,true);--Announces and adds Blizzard Language.
	                else
	                    TRP2_SetLangagebMother(true,langue);--Added by Lixxel. Updates if Blizzard Language.
			end
	                NonBlizzLanguages[langue]=nil;
		end
	        if NonBlizzLanguages then
	            table.foreach(NonBlizzLanguages, function(ID)
	                TRP2_SetLangagebMother(nil,ID);--Added by Lixxel. Updates if no longer Blizzard Language.
	            end);
	        end
		if not LanguesTab[TRP2_GetInfo(TRP2_Joueur, "SelectDial", select(1, GetDefaultLanguage("player")))] then
			TRP2_SetInfo(TRP2_Joueur,"SelectDial");
		end
	end
end

function TRP2_AddLangage(ID,Comp,message,bIsMother)
	local LangueTab = TRP2_GetLangageInfo(ID);
	local LanguesTab = TRP2_GetInfo(TRP2_Joueur,"Langues",{});
	
	if LanguesTab[ID] then
		wipe(LanguesTab[ID]);
	else
		if TRP2_GetIndexedTabSize(LanguesTab) == 10 then
			return;
		end
		LanguesTab[ID] = {};
	end
	if not Comp then
		Comp = TRP2_GetWithDefaut(LangueTab,"CompetenceBase",100);
	end
	LanguesTab[ID]["Competence"] = Comp;
	if bIsMother then
		LanguesTab[ID]["bMother"] = true;
	else
		LanguesTab[ID]["bMother"] = nil;
	end
	
	TRP2_SetInfo(TRP2_Joueur,"Langues",LanguesTab);
	if message then
		TRP2_Afficher(TRP2_FT(TRP2_LOC_LEARNLANG,TRP2_Joueur,TRP2_GetWithDefaut(LangueTab,"Entete",ID),Comp));
	end
	TRP2_RefreshLangueListe();
end

function TRP2_RefreshLangueListe()
	local i;
	local LanguesTab = TRP2_GetInfo(TRP2_Joueur,"Langues",{});
	for i=1,10,1 do
		getglobal("TRP2_FicheLanguagesOngletLangue"..i):Hide();
		getglobal("TRP2_FicheLanguagesOngletLangue"..i.."Icon"):SetVertexColor(1,1,1);
	end
	i = 1;
	table.foreach(LanguesTab, function(ID)
		local langueTab = TRP2_GetLangageInfo(ID);
		getglobal("TRP2_FicheLanguagesOngletLangue"..i):Show();
		local Titre = TRP2_GetWithDefaut(langueTab,"Nom",TRP2_GetWithDefaut(langueTab,"Entete",ID))
		if TRP2_GetInfo(TRP2_Joueur,"SelectDial", select(1, GetDefaultLanguage("player"))) == ID then
			getglobal("TRP2_FicheLanguagesOngletLangue"..i.."Icon"):SetVertexColor(0,1,0);
			Titre = Titre.." {v}("..TRP2_LOC_UI_Selected..")";
		end
		getglobal("TRP2_FicheLanguagesOngletLangue"..i.."Icon"):SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(langueTab,"Icone","Temp.blp"));
		local message="{o}\""..TRP2_GetWithDefaut(langueTab,"Description","").."\"\n\n{v}"..TRP2_LOC_MAITRISE.." : "..TRP2_GetWithDefaut(LanguesTab[ID],"Competence",0).."/100"
						.."\n";
		--if TRP2_GetWithDefaut(langueTab,"Faction","") ~= UnitFactionGroup("player") then
                	--message = message.."\n{j}"..TRP2_LOC_CLICDROIT.." {w}: "..TRP2_LOC_DELLANG;
		--else
			--message = message.."\n{o}< "..TRP2_LOC_CANTFORGET.." >";
                --end
                if TRP2_GetWithDefaut(LanguesTab[ID],"bMother") then
			message = message.."\n{o}< "..TRP2_LOC_CANTFORGET.." >";
		else
			message = message.."\n{j}"..TRP2_LOC_CLICDROIT.." {w}: "..TRP2_LOC_DELLANG;
		end
		if TRP2_GetInfo(TRP2_Joueur,"SelectDial", select(1, GetDefaultLanguage("player"))) ~= ID then
			message = message.."\n{j}"..TRP2_LOC_CLIC.." {w}: "..TRP2_LOC_SELECTLANG;
		end
		if TRP2_GetWithDefaut(langueTab,"bCanComp",ID,true) and not TRP2_GetWithDefaut(LanguesTab[ID],"bMother") then
			message = message.."\n{j}"..TRP2_LOC_CLICDROITMAJ.." {w}: "..TRP2_LOC_CHANGEMASTERY;
		end
		TRP2_SetTooltipForFrame(
			getglobal("TRP2_FicheLanguagesOngletLangue"..i),getglobal("TRP2_FicheLanguagesOngletLangue"..i),"RIGHT",-5,-5,
			Titre,
			message
		);
		if TRP2_GetWithDefaut(LanguesTab[ID],"bMother") then
			getglobal("TRP2_FicheLanguagesOngletLangue"..i.."Time"):SetText("|TInterface\\GROUPFRAME\\UI-Group-LeaderIcon:25:25|t");
		else
			getglobal("TRP2_FicheLanguagesOngletLangue"..i.."Time"):SetText(TRP2_GetWithDefaut(LanguesTab[ID],"Competence",0));
		end
		getglobal("TRP2_FicheLanguagesOngletLangue"..i):SetScript("OnClick",function(self,button)
			if button == "RightButton" then
				if IsShiftKeyDown() and TRP2_GetWithDefaut(langueTab,"bCanComp",ID,true) and not TRP2_GetWithDefaut(LanguesTab[ID],"bMother") then
					StaticPopupDialogs["TRP2_GET_MONTANT_NS"].text = TRP2_CTS(TRP2_FT(TRP2_ENTETE..TRP2_LOC_DialecteCompChoose,TRP2_GetWithDefaut(langueTab,"Entete",ID)));
					TRP2_ShowStaticPopup("TRP2_GET_MONTANT_NS",TRP2MainFrame,TRP2_SetLangageComp,ID,true);
				--elseif TRP2_GetWithDefaut(langueTab,"Faction","") ~= UnitFactionGroup("player") then
                                elseif not TRP2_GetWithDefaut(LanguesTab[ID],"bMother") then
					StaticPopupDialogs["TRP2_CONFIRM_ACTION"].text = TRP2_CTS(TRP2_FT(TRP2_ENTETE..TRP2_LOC_DeleteDialecteConfirm,TRP2_GetWithDefaut(langueTab,"Entete",ID)));
					TRP2_ShowStaticPopup("TRP2_CONFIRM_ACTION",TRP2MainFrame,TRP2_OubliLangage,ID,true);
				end
			else
				if TRP2_GetInfo(TRP2_Joueur,"SelectDial", select(1, GetDefaultLanguage("player"))) ~= ID then
					TRP2_SelectDialecte(ID,true);
				end
			end
		end);
		i = i+1;
	end);
	TRP2_SetInfo(TRP2_Joueur,"Langues",LanguesTab);
end

function TRP2_PurgeLanguageList()--Added by Lixxel
	local LanguesTab = TRP2_GetInfo(TRP2_Joueur,"Langues",{});
        
        local NonBlizzLanguages = {};
        for k,v in pairs(LanguesTab) do
            NonBlizzLanguages[k]=v;
        end
        
	local i;
	for i=1,GetNumLanguages() do
		local langue = select(1, GetLanguageByIndex(i));
                NonBlizzLanguages[langue]=nil;
	end
        if NonBlizzLanguages then
            table.foreach(NonBlizzLanguages, function(ID)
                TRP2_OubliLangage(ID,false);
            end);
        end
        TRP2_SetInfo(TRP2_Joueur,"Langues",LanguesTab);
        TRP2_RefreshLangueListe();
	if not LanguesTab[TRP2_GetInfo(TRP2_Joueur, "SelectDial", select(1, GetDefaultLanguage("player")))] then
		TRP2_SetInfo(TRP2_Joueur,"SelectDial");
	end
end

function TRP2_SetLangageComp(Comp,ID,message)
	local LangueTab = TRP2_GetLangageInfo(ID);
	local LanguesTab = TRP2_GetInfo(TRP2_Joueur,"Langues",{});
	if Comp > 100 then Comp = 100 end
	if LanguesTab[ID] then
		LanguesTab[ID]["Competence"] = Comp;
	end
	TRP2_SetInfo(TRP2_Joueur,"Langues",LanguesTab);
	if message then
		TRP2_Afficher(TRP2_FT(TRP2_LOC_CHANGEDMASTERY,TRP2_GetWithDefaut(LangueTab,"Entete",ID),Comp));
	end
	TRP2_RefreshLangueListe();
end

function TRP2_SetLangagebMother(bMother,ID)
	local LanguesTab = TRP2_GetInfo(TRP2_Joueur,"Langues",{});
	if LanguesTab[ID] then
		LanguesTab[ID]["bMother"] = bMother;
	end
	TRP2_SetInfo(TRP2_Joueur,"Langues",LanguesTab);
	TRP2_RefreshLangueListe();
end

function TRP2_GetOriginalLanguageID(languageName)
	local i;
	for i=1,GetNumLanguages(),1 do
		if select(1, GetLanguageByIndex(i)) == languageName then
			return select(2, GetLanguageByIndex(i))
		end
	end
end

function TRP2_HookSendChatMessage()
	function TRP2_SendChatMessage( msg, chatType, languageID, channel )
	
		--TRP2_debug(tostring(msg).." "..tostring(chatType).." "..tostring(languageID).." "..tostring(channel));
		if not msg then return end
		
		if string.find(msg,"%%t") then
			if not UnitName("target") then
				TRP2_Error(ERR_GENERIC_NO_TARGET);
				return;
			else
				local nomPet, maitre = TRP2_RecupTTInfo();
				if nomPet and maitre then
					local petTab = TRP2_GetInfo(maitre,"Pets",{});
					if petTab[nomPet] and petTab[nomPet]["Nom"] then
						msg = string.gsub(msg,"%%t",petTab[nomPet]["Nom"]);
					end
				elseif UnitIsPlayer("target") then
					local prenom = TRP2_DeleteColorCode(TRP2_GetWithDefaut(TRP2_GetInfo(UnitName("target"),"Registre",{}),"Prenom",UnitName("target")));
					msg = string.gsub(msg,"%%t",prenom);
				end
			end
		end
		
		if TRP2_GetConfigValueFor("ConvertSmiley",true) and chatType=="SAY" then
			if msg == ":)" or msg == ":-)" then
				DoEmote("SMILE");
				return;
			elseif msg == ";)" or msg == ";-)" then
				DoEmote("BLINK");
				return;
			elseif msg == ":-]" or msg == ":]" then
				DoEmote("SMIRK");
				return;
			elseif msg == ":o" or msg == ":-o" or msg == ":O" then
				DoEmote("SURPRISED");
				return;
			elseif msg == ":3" then
				DoEmote("PURR");
				return;
			elseif msg == ":p" then
				DoEmote("LICK");
				return;
			end
		end
		
		languageID = select(2, GetDefaultLanguage("player"));
		if (TRP2_GetInfo(TRP2_Joueur,"Langues",{}) and TRP2_GetInfo(TRP2_Joueur,"Langues",{})[TRP2_GetInfo(TRP2_Joueur,"SelectDial", select(1, GetDefaultLanguage("player")))] and TRP2_GetInfo(TRP2_Joueur,"Langues",{})[TRP2_GetInfo(TRP2_Joueur,"SelectDial", select(1, GetDefaultLanguage("player")))]["bMother"]) or string.find(TRP2_DIALBASETAB[TRP2_enRace], TRP2_GetInfo(TRP2_Joueur,"SelectDial", select(1, GetDefaultLanguage("player")))) then
			languageID = TRP2_GetOriginalLanguageID(TRP2_GetInfo(TRP2_Joueur,"SelectDial", select(1, GetDefaultLanguage("player"))));
		end
                
                TRP2_debug("Language ID: " ..languageID);
		-- Trigger and cutting
		if (chatType=="SAY" or chatType=="YELL") then
			if TRP2_GetConfigValueFor("ColorEmoteMode",2) == 3 and (string.find(msg,"%*.-%*") or string.find(msg,"%<.-%>"))then
				local pre,emote,post = string.match(msg,"^(.*)%*(.-)%*(.*)$");
				TRP2_SendChatMessage(pre,chatType);
				if emote then
					emote = emote..".";
					TRP2_SendChatMessage(emote,"EMOTE");
				end
				TRP2_SendChatMessage(string.match(post,"^%s*(.*)"),chatType);
				return;
			end
			if not TRP2_EmptyToNil(msg) then return end -- Si ya plus rien dedans on annule.
			TRP2_QUESTFUNC = function()
				TRP2_PerformAction("Dire",msg,chatType);
			end
		end
		
		if (chatType=="SAY" or chatType=="PARTY" or chatType=="RAID" or (chatType=="GUILD" and not TRP2_GetConfigValueFor("GuildNoIC",false)) or chatType=="YELL" or chatType=="WHISPER") then
			local Id = TRP2_GetInfo(TRP2_Joueur,"SelectDial", select(1, GetDefaultLanguage("player")));
			msg = TRP2_TransformMessage(msg,Id,TRP2_GetWithDefaut(TRP2_GetInfo(TRP2_Joueur,"Langues",{})[Id],"Competence",0));
		end
		
		
		--print("Length : "..string.len(msg));
		--print("Length CTS : "..string.len(TRP2_CTS(msg,true)));
		local texteTab;
		if string.len(TRP2_CTS(msg)) <= 255 then
			TRP2_SavedSendChatMessage(TRP2_CTS(msg), chatType, languageID, channel );
		else
			local prefix = TRP2_FindPrefixIn(TRP2_CTS(msg,true));
			if prefix == "" and chatType=="EMOTE" then
				prefix = "|| ";
			end
			--print("Length prefix : "..string.len(prefix));
			texteTab = TRP2_DecoupageTexte(TRP2_CTS(msg,true), 256 - string.len(prefix));
			local first = true;
			for _,msgText in pairs(texteTab) do
				if first then
					TRP2_SavedSendChatMessage(msgText, chatType, languageID, channel );
				else
					TRP2_SavedSendChatMessage(prefix..msgText, chatType, languageID, channel );
				end
				first = false;
			end
		end
	end
	TRP2_SavedSendChatMessage = SendChatMessage;
	SendChatMessage = TRP2_SendChatMessage;
end

function TRP2_FindPrefixIn(texte)
	if string.find(texte,"%|%|") then
		if string.find(texte,"%|%| .- "..TRP2_LOC_DIT) then
			local match = string.match(texte,"(%|%| .- "..TRP2_LOC_DIT..")");
			return match;
		elseif string.find(texte,"%|%| .- "..TRP2_LOC_CRIE.." %: ") then
			local match = string.match(texte,"(%|%| .- "..TRP2_LOC_CRIE..")");
			return match;
		elseif string.find(texte,"%|%| .- "..TRP2_LOC_WHISPER.." %: ") then
			local match = string.match(texte,"(%|%| .- "..TRP2_LOC_WHISPER..")");
			return match;
		else
			return "|| ";
		end
	else
		return "";
	end
end

function TRP2_DecoupageTexte(texte, taille)
	local ok = true;
	local morceaux = string.reverse(texte);
	local texteTab = {};
	local i = 1;
	
	while ok do
		local indice = string.find(morceaux," ",-taille);
		if string.len(morceaux) < taille or not indice then
			texteTab[i] = string.reverse(morceaux);
			ok = false;
		else
			texteTab[i] = string.reverse(string.sub(morceaux,indice));
			i = i + 1;
			morceaux = string.sub(morceaux,1,indice-1);
		end
	end
	return texteTab;
end

function TRP2_DecoupePhrase(texte)
	local textRestant = texte;
	local stringTab = {};
	local i=1;
	local indice = 1;
	
	if string.find(texte,"|H") then
		stringTab[1] = texte;
		return stringTab;
	end
	
	while string.find(textRestant,"%(.*%)") or string.find(textRestant,"%<.*%>") or string.find(textRestant,"%*.*%*") do
		
		local preTexte;
		local EmoteTexte;
		local postTexte;
		local hrpTexte;
		
		-- Catching de l'emote
		if string.find(textRestant,"%(.*%)") then
			preTexte = string.sub(textRestant,1,string.find(textRestant,"%(")-1); -- Du texte RP
			hrpTexte = string.sub(textRestant,string.find(textRestant,"%("),string.find(textRestant,"%)")); -- Du texte HRP
			postTexte = string.sub(textRestant,string.find(textRestant,"%)")+1); -- Du texte RP ou HRP
		elseif string.find(textRestant,"%<.*%>") then
			preTexte = string.sub(textRestant,1,string.find(textRestant,"%<")-1);
			EmoteTexte = string.sub(textRestant,string.find(textRestant,"%<")+1,string.find(textRestant,"%>")-1); -- Du texte Emote
			postTexte = string.sub(textRestant,string.find(textRestant,"%>")+1);
		elseif string.find(textRestant,"%*.*%*") then
			preTexte = string.sub(textRestant,1,string.find(textRestant,"%*")-1);
			EmoteTexte = string.match(textRestant,"%*.*%*");
			postTexte = string.sub(textRestant,string.len(preTexte)+string.len(EmoteTexte)+1);
			EmoteTexte = string.sub(EmoteTexte,2,string.len(EmoteTexte)-1);
		end
		
		if preTexte ~= "" and preTexte ~= " " then
			stringTab[indice] = preTexte;
			indice = indice + 1;
		end
		if EmoteTexte and EmoteTexte ~= "" and EmoteTexte ~= " " then
			stringTab[indice] = "<"..EmoteTexte..">";
			indice = indice + 1;
		end
		if hrpTexte and hrpTexte ~= "" and hrpTexte ~= " " then
			stringTab[indice] = hrpTexte;
			indice = indice + 1;
		end
		if not string.find(postTexte,"%(.*%)") and not string.find(postTexte,"%<.*%>") and not string.find(postTexte,"%*.*%*") and not string.find(textRestant,"%|H.*%|h") then
			if postTexte ~= "" and postTexte ~= " " then
				stringTab[indice] = postTexte;
				indice = indice + 1;
			end
			textRestant = "";
		else
			textRestant = postTexte;
		end
		i = i+1;
	end
	
	return stringTab;
end

function TRP2_DD_MenuLangages(frame,level,menuList)
	UIDropDownMenu_SetWidth(frame, 50);
	UIDropDownMenu_SetButtonWidth(frame, 15);
	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_LOC_SELECTLANG;
	info.func = function() end;
	info.isTitle = true;
	UIDropDownMenu_AddButton(info);
	
	TRP2_InitDialectList();
	
	local actualID = TRP2_GetInfo(TRP2_Joueur,"SelectDial", select(1, GetDefaultLanguage("player")));
	local LanguesTab = TRP2_GetInfo(TRP2_Joueur,"Langues",{});
	local i;
	
	-- Un bouton par langage perso
	table.foreach(LanguesTab, function(dialecteID)
		local LangueTab = TRP2_GetLangageInfo(dialecteID);
		info = TRP2_CreateSimpleDDButton();
		
		info.text = "|TInterface\\ICONS\\"..TRP2_GetWithDefaut(LangueTab,"Icone","Temp.blp")..":20:20|t "..TRP2_GetWithDefaut(LangueTab,"Nom",TRP2_GetWithDefaut(LangueTab,"Entete",""));
		if TRP2_GetWithDefaut(LanguesTab[dialecteID],"bMother") then
			info.text = info.text.." |TInterface\\GROUPFRAME\\UI-Group-LeaderIcon:20:20|t";
		else
			info.text = info.text.." ("..TRP2_GetWithDefaut(LanguesTab[dialecteID],"Competence",100).."/100)";
		end
		if actualID == dialecteID then
			info.text = info.text.." ("..TRP2_LOC_UI_Selected..")";
			info.checked = true;
			info.disabled = true;
		end
		info.func = function() 
			TRP2_SelectDialecte(dialecteID,true);
		end;
		info.text = TRP2_CTS(info.text);
		UIDropDownMenu_AddButton(info,level);
	end);

	info = TRP2_CreateSimpleDDButton();
	info.text = CANCEL;
	UIDropDownMenu_AddButton(info,level);
end

function TRP2_CreatSimpleTooltipDialecte(tab)
	return "{icone:"..TRP2_GetWithDefaut(tab,"Icone","Temp")..":35} "..TRP2_GetWithDefaut(tab,"Entete",TRP2_LOC_NEWDIALECTE);
end

-- Remerciements à Stretcher
TRP2_SpecialCharacters = "\128\129\130\131\132\133\134\135\136\137\138\139\140\141\142\143\144\145\151\146\147\148\149\150\152\153\154\155\156\157\158\159"
						.."\160\161\162\163\164\165\166\167\168\169\170\171\172\173\174\175\177\176\178\179\180\181\182\183\184\185\186\187\188\189\190\191";
TRP2_ACCENTTAB = {
	["\128"] = "A";
	["\129"] = "A";
	["\130"] = "A";
	["\131"] = "A";
	["\132"] = "A";
	["\133"] = "A";
	["\134"] = "A";
	["\135"] = "C";
	["\136"] = "E";
	["\137"] = "E";
	["\138"] = "E";
	["\139"] = "E";
	["\140"] = "I";
	["\141"] = "I";
	["\142"] = "I";
	["\143"] = "I";
	["\144"] = "D";
	["\145"] = "N";
	["\146"] = "O";
	["\147"] = "O";
	["\148"] = "O";
	["\149"] = "O";
	["\150"] = "O";
	["\151"] = "x";
	["\152"] = "O";
	["\153"] = "U";
	["\154"] = "U";
	["\155"] = "U";
	["\156"] = "U";
	["\157"] = "Y";
	["\158"] = "P";
	["\159"] = "S";
	["\160"] = "a";
	["\161"] = "a";
	["\162"] = "a";
	["\163"] = "a";
	["\164"] = "a";
	["\165"] = "a";
	["\166"] = "a";
	["\167"] = "c";
	["\168"] = "e";
	["\169"] = "e";
	["\170"] = "e";
	["\171"] = "e";
	["\172"] = "i";
	["\173"] = "i";
	["\174"] = "i";
	["\175"] = "i";
	["\176"] = "o";
	["\177"] = "n";
	["\178"] = "o";
	["\179"] = "o";
	["\180"] = "o";
	["\181"] = "o";
	["\182"] = "o";
	["\183"] = "o";
	["\184"] = "o";
	["\185"] = "u";
	["\186"] = "u";
	["\187"] = "u";
	["\188"] = "u";
	["\189"] = "y";
	["\190"] = "y";
	["\191"] = "y";
};

function TRP2_ConvertUTF8ToANSI(letter)
	if TRP2_ACCENTTAB[string.sub(letter,2,2)] then
		return TRP2_ACCENTTAB[string.sub(letter,2,2)];
	end
	return "";
end

-- Algo de hash, inspiré de celui de Daniel J. Bernstein
function TRP2_Hash( text )
	local l = strlen( text );
	local h = 5381;
	for i = 1, l, 1 do
		local v = strbyte( text, i );
		h = ( ( h * 33 ) + v );
	end
	return h;
end

-- -- -- -- -- -- -- -- -- --
-- Gestion traductions
-- -- -- -- -- -- -- -- -- --

-- Mapping needed : localized name -> id
-- Maybe for another version ...
TRP2_LangMapping = {
	["Binaire"] = "LAN00006",
	["Binary"] = "LAN00006",
};

-- Création d'une requete de traduction
function TRP2_OpenTranslateRequest(cible,langueEntete,chatFrame,event,color)
	local LanguesTab = TRP2_GetInfo(TRP2_Joueur,"Langues",{});
	table.foreach(LanguesTab, function(ID)
		local langueTab = TRP2_GetLangageInfo(ID);
		if --[[(TRP2_LangMapping[langueEntete] and ID == TRP2_LangMapping[langueEntete]) or]] TRP2_GetWithDefaut(langueTab,"Entete","") == langueEntete then -- On connais cette langue !
			local requete = ID..TRP2_ReservedChar..TRP2_GetWithDefaut(LanguesTab[ID],"Competence","0")..TRP2_ReservedChar..chatFrame..TRP2_ReservedChar..event;
			if not TRP2_COLORREQUESTTAB[cible] then
				TRP2_COLORREQUESTTAB[cible] = color;
			end
			TRP2_SecureSendAddonMessage("LATR",requete,cible);
		end
	end);
end

-- Réception d'une requete de traduction
function TRP2_ReceiveTranslateRequest(cible,requestTab)
	-- requestTab[1] = ID
	-- requestTab[2] = Competence
	-- requestTab[3] = ChatFrame
	-- requestTab[4] = Event
	if not TRP2_DernierePhrase or string.gsub(TRP2_DernierePhrase," ","") == "" then return end
	local tailleReponse = string.len(tostring(requestTab[3])) + string.len(tostring(requestTab[4])) + 3 +  string.len(tostring(requestTab[1]));
	local tailleRestante = 240 - tailleReponse;
	local degradation = tonumber(requestTab[2]);
	local LanguesTab = TRP2_GetInfo(TRP2_Joueur,"Langues",{});
	
	degradation = math.min(degradation,TRP2_GetWithDefaut(LanguesTab[requestTab[1]],"Competence",0));
	
	traduction = TRP2_TraductionComprehension(requestTab[1],TRP2_DernierePhrase,100-degradation,true);
	local texteTab = TRP2_DecoupageTexte(traduction, tailleRestante);
	table.foreach(texteTab, function(msgNum)
		local textToSend = tostring(requestTab[1])..TRP2_ReservedChar..tostring(requestTab[3])..TRP2_ReservedChar..tostring(requestTab[4])..TRP2_ReservedChar..texteTab[msgNum];
		TRP2_SecureSendAddonMessage("LASN",textToSend,cible);
	end);
	--TRP2_debug("Traduction à "..degradation.."%");
	--TRP2_debug("Traduction envoyée à "..cible);
end

-- Réception d'une traduction
function TRP2_ReceiveTranslate(sender,reponseTab)
	-- 1 : ID
	-- 2 : ChatFrame
	-- 3 : Event
	-- 4 : Texte
	local info = ChatTypeInfo[tostring(reponseTab[3])];
	local langueTab = TRP2_GetLangageInfo(tostring(reponseTab[1]));
	local personnage = TRP2_GetWithDefaut(TRP2_GetInfo(sender,"Registre",{}),"Prenom",sender);
	if TRP2_GetConfigValueFor("UseNameInChat",true) then
		if TRP2_GetWithDefaut(TRP2_GetInfo(sender,"Registre",{}),"Nom") then -- On ajoute le nom si il existe
			personnage = personnage.." "..TRP2_GetWithDefaut(TRP2_GetInfo(sender,"Registre",{}),"Nom");
		end
	end
	local color = "";
	if TRP2_COLORREQUESTTAB[sender] then
		color = TRP2_COLORREQUESTTAB[sender];
	end
	personnage = "["..color.."|Hplayer:"..sender.."|h"..personnage.."|h|r]"; -- Lien de chat
	if getglobal("CHAT_"..tostring(reponseTab[3]).."_GET") then
		personnage = format(getglobal("CHAT_"..tostring(reponseTab[3]).."_GET"),personnage);
	end
	-- Item link detection
	local texte = string.gsub(tostring(reponseTab[4]),"%~(.-)%~",function(item)
		return TRP2_MakeItemLink(item, sender);
	end);
	personnage = personnage.."{o}[{v}"..TRP2_LOC_Traduction.."{o}]|r "..texte;
	getglobal(tostring(reponseTab[2])):AddMessage(TRP2_CTS(personnage),info.r,info.g,info.b,info.id);
end

-- Utilisé par la balise de langage
function TRP2_CheckForLanguage(texte)
	while string.find(texte,".-{dial%:.-}.-{%/dial}.-") do
		local pre,ID,corps,post = string.match(texte,"(.-){dial%:(.-)}(.-){%/dial}(.*)");
		if not ID then return texte end
		if not pre then pre = "" end
		if not post then post = "" end
		local LangueTab = TRP2_GetLangageInfo(ID);
		if LangueTab then
			local LanguesTab = TRP2_GetInfo(TRP2_Joueur,"Langues",{});
			local Competence = TRP2_GetWithDefaut(LanguesTab[ID],"Competence",0);
			texte = pre..TRP2_TraductionComprehension(ID,corps,100-Competence,true)..post;
		else
			texte = pre.."( "..TRP2_LOC_unknownlang.." )"..post;
		end
	end
	return texte;
end

-- Transformation du texte : Expression
function TRP2_TransformMessage(msg,ID,Comp,bColor)
	local tosave = "";
	local LangueTab = TRP2_GetLangageInfo(ID);
	TRP2_DernierePhrasePerso = msg;
	
	-- Item link detection
	TRP2_DernierePhrasePerso = string.gsub(msg,"%~(.-)%~",function(item)
		return TRP2_MakeItemLink(item, TRP2_Joueur);
	end);
	
	-- On traduit pas les message avec des links, le temps de regler les problemes.
	-- On traduit pas non plus les messages dans une de nos langues officielles.
	--if (TRP2_GetInfo(TRP2_Joueur,"Langues",{}) and TRP2_GetInfo(TRP2_Joueur,"Langues",{})[ID] and TRP2_GetInfo(TRP2_Joueur,"Langues",{})[ID]["bMother"]) or string.find(msg,"|H") or string.find(TRP2_DIALBASETAB[TRP2_enRace],ID) or string.sub(msg,1,1) == "|" then 
		englishFaction, localizedFaction = UnitFactionGroup("player"); --Added by Ephedrae. ^ That breaks native race languages. Like Night elfs trying to speak darnassian ...
		if (TRP2_GetInfo(TRP2_Joueur,"SelectDial", select(1, GetDefaultLanguage("player"))) == GetDefaultLanguage("player")  and englishFaction == "Alliance") or (TRP2_GetInfo(TRP2_Joueur,"SelectDial", select(1, GetDefaultLanguage("player"))) == GetDefaultLanguage("player")  and englishFaction == "Horde") then --Exclude common/orcish from translation on their respective factions.
		TRP2_DernierePhrase = "";--Added by Lixxel. Clear out translation requests.
                return msg;--and just return the message. No translations!
	end

	local stringTab = TRP2_DecoupePhrase(msg); -- Découpe le texte en un tableau de texte pour séparer le RP, le HRP et les emotes

	if #stringTab == 0 then
		stringTab[1] = msg;
	end
	msg = "";
	
	table.foreach(stringTab, function(texte)
		if not string.find(string.sub(stringTab[texte],1,1),"[%(%<%*]") then -- Si c'est pas un texte HRP ou emote
			tosave = tosave..stringTab[texte]; -- On sauvegarde la traduction française
			stringTab[texte] = TRP2_TraductionComprehension(ID,stringTab[texte],Comp,bColor);
		end
		msg = msg..stringTab[texte];
	end);
	TRP2_DernierePhrase = tosave;
	
	--if not (string.find(TRP2_DIALBASETAB[TRP2_enRace],ID) or TRP2_GetInfo(TRP2_Joueur,"Langues",{})[ID]["bMother"]) then
		msg = "["..TRP2_GetWithDefaut(LangueTab,"Entete",ID).."] "..msg;
		TRP2_DernierePhrasePerso = "{o}["..TRP2_GetWithDefaut(LangueTab,"Entete",ID).."]{col} "..TRP2_DernierePhrasePerso;
	--end
	
	return msg;
	
end


-- Texte à la base en fr, et traduction en Langue ID en fonction de la compétence : traduction à "Competence%"
function TRP2_TraductionComprehension(LangueID,Texte,Competence,bCouleur)

	local LangueTab = TRP2_GetLangageInfo(LangueID);
	
	if not LangueTab then
		return Texte;
	end
	
	Texte = string.gsub( Texte, "([%p%s%d%c]*)([^%p%s%d%c]*)", function(pre,word)
		local taille = string.len(word);
		local tableauRemplacement;
		
		-- Gestion des liens
		if ( string.sub(pre, -1, -1) == "\124" ) then 
			if ( word == "Hitem" ) then
				return pre.."Hitem";
			end
			if ( word == "cffffffff" or word == "cff" ) then
				return pre.."cffffffff";
			end
			word = "thingybob";
			taille = 9;
		end
		-- Gestion des mots ne devant pas être traduit
		if ( (string.sub(pre, -1, -1)) == "$" or (string.sub(pre, -1, -1)) == "=" ) then
			return string.sub(pre, 1, -2)..word
		end
		-- Si ya que dalle ... 
		if taille == 0 then
			return pre..word;
		end
		-- Si le test de compétence passe pas ...
		local hash = TRP2_Hash(string.upper(word));
		
		if (math.fmod(hash,100)+1) > Competence then
			return pre..word;
		end
		
		-- On supprime les speciaux (made by LeChat) + recalcul de la taille
		word = string.gsub( word, "(\195["..TRP2_SpecialCharacters.."])", TRP2_ConvertUTF8ToANSI );
		taille = string.len(word);
		
		-- Remplacement du mot
		if taille > 12 then
			taille = 12;
		elseif taille < 1 then
			taille = 1;
		end
		tableauRemplacement = LangueTab["HashTables"][tostring(taille)];
		tableauRemplacement = TRP2_FetchToTabWithSeparator(tableauRemplacement,";");
		if tableauRemplacement[#tableauRemplacement] == "" then -- si des poutres on mis un ; à la fin ...
			tableauRemplacement[#tableauRemplacement] = nil;
		end
		taille = #tableauRemplacement;
		hashNombre = math.fmod(hash,taille);
		if hashNombre == 0 then
			hashNombre = taille;
		end
		local transWord = tableauRemplacement[hashNombre];
		
		-- Respect des minuscules/majuscules
		local i;
		local temp="";
		for i=1,string.len(word),1 do
			local letter = string.sub(word,i,i);
			local letter2 = string.sub(transWord,i,i);
			if letter2 and letter2 ~= "" then
				if string.find(letter,"%u") then
					temp = temp..string.upper(letter2);
				else
					temp = temp..letter2;
				end
			end
		end
		transWord = temp..string.sub(transWord,string.len(temp)+1);
		
		return pre..transWord;
		
	end); -- On traduit les mots
	
	return Texte;
end
