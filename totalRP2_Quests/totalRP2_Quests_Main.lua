-------------------------------------------------------------------
--                          Total RP 2
--            A roleplay addon for World of Warcraft
-- Created by Sylvain "Telkostrasz" Cossement (up to version 1.017)
--   Licence : CC BY-NC-SA (http://creativecommons.org/licenses/)
-------------------------------------------------------------------

TRP2_QUESTFUNC = nil;

function TRP2_Set_Module_Quests()
	-- Les infos de quêtes
	if not TRP2_Module_Quests then
		TRP2_Module_Quests = {};
	end
	-- Le journal de quête
	if not TRP2_Module_QuestsLog then
		TRP2_Module_QuestsLog = {};
	end
	if not TRP2_Module_QuestsLog[TRP2_Royaume] then
		TRP2_Module_QuestsLog[TRP2_Royaume] = {};
	end
	if not TRP2_Module_QuestsLog[TRP2_Royaume][TRP2_Joueur] then
		TRP2_Module_QuestsLog[TRP2_Royaume][TRP2_Joueur] = {};
	end
	
	if TRP2_GetInfo(TRP2_Joueur,"ActualQuest","0") ~= "0" then
		TRP2_ActionBar:Show();
	end
end

function TRP2_CreatSimpleTooltipQuest(tab)
	return "{icone:"..TRP2_GetWithDefaut(tab,"Icone","Temp")..":25} "..TRP2_GetWithDefaut(tab,"Nom",TRP2_LOC_NEWQUEST),"{w}\"{o}"..TRP2_GetWithDefaut(tab,"Description","").."{w}\"";
end

-- Retourne le tableau d'information d'un Aura créé
function TRP2_GetQuestsInfo(ID)
	if ID and string.len(ID) == TRP2_IDSIZE then
		return TRP2_Module_Quests[ID];
	elseif TRP2_DB_Auras then
		return TRP2_DB_Quests[ID];
	end
end

function TRP2_LoadQuestsLog()
	TRP2_PanelTitle:SetText(TRP2_Joueur.." : "..TRP2_LOC_QUESTLOG);
	TRP2_LoadQuestsList();
	TRP2MainFrameQuestsLog:Show();
end

function TRP2_IsQuestActive(questID)
	return TRP2_Module_QuestsLog[TRP2_Royaume][TRP2_Joueur][questID] ~= nil;
end

function TRP2_AddQuest(questID)
	if questID and not TRP2_Module_QuestsLog[TRP2_Royaume][TRP2_Joueur][questID] then
		local questInfo = TRP2_GetQuestsInfo(questID);
		TRP2_Afficher(TRP2_FT(TRP2_LOC_STARTQUEST1,"{o}[{v}"..TRP2_GetWithDefaut(questInfo,"Nom",TRP2_LOC_NEWQUEST).."{o}]"));
		TRP2_SetActiveQuest(questID);
		TRP2_QuestsGoToStep("001",questID);
	end
end

function TRP2_LoadQuestsList()
	local i = 0; -- Nombre total
	local j = 0; -- Nombre pris
	local tri = TRP2MainFrameQuestsLogAffichage.Valeur;
	TRP2MainFrameQuestsLogListeSlider:Hide();
	TRP2MainFrameQuestsLogListeSlider:SetValue(0);
	TRP2MainFrameQuestsLogAffichageValeur:SetText(TRP2_LOC_QUESTSTATE[TRP2MainFrameQuestsLogAffichage.Valeur]);
	wipe(TRP2_QuestsLogList);
	
	for questID,v in pairs(TRP2_Module_QuestsLog[TRP2_Royaume][TRP2_Joueur]) do
		i = i + 1;
		local EtapeInfoTab = TRP2_GetWithDefaut(TRP2_GetQuestsInfo(questID),"Etapes",{})[TRP2_GetWithDefaut(v,"Etape","001")];
		if tri == 4 or tri == TRP2_GetWithDefaut(EtapeInfoTab,"EtapeFlag") then
			j = j + 1;
			TRP2_QuestsLogList[j] = questID;
		end
	end
	
	table.sort(TRP2_QuestsLogList);

	if j > 0 then
		TRP2MainFrameQuestsLogListeEmpty:SetText("");
	elseif i == 0 then
		TRP2MainFrameQuestsLogListeEmpty:SetText(TRP2_LOC_NoQuest);
	else
		TRP2MainFrameQuestsLogListeEmpty:SetText(TRP2_LOC_SelectVide);
	end
	if j > 5 then
		TRP2MainFrameQuestsLogListeSlider:Show();
		local total = floor((j-1)/5);
		TRP2MainFrameQuestsLogListeSlider:SetMinMaxValues(0,total);
	end
	TRP2MainFrameQuestsLogListeSlider:SetScript("OnValueChanged",function(self)
		if self:IsVisible() then
			TRP2_LoadQuestsListPage(self:GetValue());
		end
	end)
	TRP2_LoadQuestsListPage(0);
end

function TRP2_SetActiveQuest(ID)
	local QuestInfoTab = TRP2_GetQuestsInfo(ID);
	TRP2_SetInfo(TRP2_Joueur,"ActualQuest",ID);
	TRP2_Afficher("{j}"..TRP2_LOC_ACTIVE.." : {v}["..TRP2_GetWithDefaut(QuestInfoTab,"Nom",TRP2_LOC_NEWQUEST).."]");
	TRP2_ActionBar:Show();
end

function TRP2_LoadQuestsListPage(num)
	for k=1,5,1 do --Initialisation
		getglobal("TRP2MainFrameQuestsLogListeElem"..k):Hide();
		getglobal("TRP2MainFrameQuestsLogListeElem"..k.."Select"):Hide();
	end
	local i = 1;
	local j = 1;
	table.foreach(TRP2_QuestsLogList,
	function(TabIndex)
		if i > num*5 and i <= (num+1)*5 then
			local ID = TRP2_QuestsLogList[TabIndex];
			local QuestInfoTab = TRP2_GetQuestsInfo(ID);
			local QuestTab = TRP2_Module_QuestsLog[TRP2_Royaume][TRP2_Joueur][ID];
			local EtapeInfoTab = TRP2_GetWithDefaut(QuestInfoTab,"Etapes",{})[TRP2_GetWithDefaut(QuestTab,"Etape","001")];
			getglobal("TRP2MainFrameQuestsLogListeElem"..j):Show();
			getglobal("TRP2MainFrameQuestsLogListeElem"..j.."Texte"):SetText(TRP2_CTS(""..TRP2_GetWithDefaut(QuestInfoTab,"Nom",TRP2_LOC_NEWQUEST)));
			getglobal("TRP2MainFrameQuestsLogListeElem"..j.."OngletIcon"):SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(QuestInfoTab,"Icone","Temp"));
			getglobal("TRP2MainFrameQuestsLogListeElem"..j):SetScript("OnClick", function(self,button)
				if button == "LeftButton" then
					if IsShiftKeyDown() then
						local activeWindow = ChatEdit_GetActiveWindow();
						if ( activeWindow ) then
							activeWindow:Insert("["..TRP2_GetWithDefaut(QuestInfoTab,"Nom",TRP2_LOC_NEWQUEST).."]");
						end
					elseif TRP2_GetInfo(TRP2_Joueur,"ActualQuest","0") ~= ID then
						TRP2_SetActiveQuest(ID);
					else
						TRP2_NoActiveQuest();
					end
					TRP2_LoadQuestsListPage(TRP2MainFrameQuestsLogListeSlider:GetValue());
				else
					if IsShiftKeyDown() then
						if TRP2_GetWithDefaut(QuestInfoTab,"bReinit") then
							StaticPopupDialogs["TRP2_CONFIRM_ACTION_NS"].text = TRP2_CTS(TRP2_FT(TRP2_ENTETE..TRP2_LOC_ReinitQuestAsk,"{o}[{v}"..TRP2_GetWithDefaut(QuestInfoTab,"Nom",TRP2_LOC_NEWQUEST).."{o}]"));
							TRP2_ShowStaticPopup("TRP2_CONFIRM_ACTION_NS",nil,function()
								TRP2_Afficher(TRP2_FT(TRP2_LOC_ReinitQuestAgree,"{o}[{v}"..TRP2_GetWithDefaut(QuestInfoTab,"Nom",TRP2_LOC_NEWQUEST).."{o}]"));
								TRP2_QuestsGoToStep("001",ID);
								TRP2_LoadQuestsListPage(TRP2MainFrameQuestsLogListeSlider:GetValue());
							end);
						end
					else
						StaticPopupDialogs["TRP2_CONFIRM_ACTION_NS"].text = TRP2_CTS(TRP2_FT(TRP2_ENTETE..TRP2_LOC_DeleteQuestAsk,"{o}[{v}"..TRP2_GetWithDefaut(QuestInfoTab,"Nom",TRP2_LOC_NEWQUEST).."{o}]"));
						TRP2_ShowStaticPopup("TRP2_CONFIRM_ACTION_NS",nil,function()
							wipe(TRP2_Module_QuestsLog[TRP2_Royaume][TRP2_Joueur][ID]);
							TRP2_Module_QuestsLog[TRP2_Royaume][TRP2_Joueur][ID] = nil;
							TRP2_Afficher(TRP2_FT(TRP2_LOC_DeleteQuestAgree,"{o}[{v}"..TRP2_GetWithDefaut(QuestInfoTab,"Nom",TRP2_LOC_NEWQUEST).."{o}]"));
							if TRP2_GetInfo(TRP2_Joueur,"ActualQuest","0") == ID then
								TRP2_SetInfo(TRP2_Joueur,"ActualQuest");
							end
							TRP2_LoadQuestsList();
							TRP2_ActionBar:Hide();
						end);
					end
				end
			end);
			if TRP2_GetInfo(TRP2_Joueur,"ActualQuest","0") == ID then
				getglobal("TRP2MainFrameQuestsLogListeElem"..j.."Select"):Show();
			end
			if TRP2_GetWithDefaut(EtapeInfoTab,"EtapeFlag") == 3 then
				getglobal("TRP2MainFrameQuestsLogListeElem"..j.."Back"):SetVertexColor(0.5,1,0.5);
			elseif TRP2_GetWithDefaut(EtapeInfoTab,"EtapeFlag") == 2 then
				getglobal("TRP2MainFrameQuestsLogListeElem"..j.."Back"):SetVertexColor(1,0.5,0.5);
			else
				getglobal("TRP2MainFrameQuestsLogListeElem"..j.."Back"):SetVertexColor(1,1,1);
			end
			
			TRP2_SetTooltipForFrame(
				getglobal("TRP2MainFrameQuestsLogListeElem"..j),
				TRP2MainFrame,"RIGHT",-10,-415,
				TRP2_QuestsToString(ID,QuestInfoTab,QuestTab,EtapeInfoTab)
			);
			j = j + 1;
		end
		i = i + 1;
	end);
end

function TRP2_NoActiveQuest()
	TRP2_SetInfo(TRP2_Joueur,"ActualQuest","0");
	TRP2_Afficher("{j}"..TRP2_LOC_NOACTIVE);
	TRP2_ActionBar:Hide();
end

function TRP2_QuestsToString(ID,QuestInfoTab,QuestTab,EtapeInfoTab,bUi)
	local titre="";
	local message="";
	
	if QuestInfoTab then
		titre = "{icone:"..TRP2_GetWithDefaut(QuestInfoTab,"Icone","Temp")..":35} "..TRP2_GetWithDefaut(QuestInfoTab,"Nom",TRP2_LOC_NEWQUEST);
		if TRP2_GetInfo(TRP2_Joueur,"ActualQuest","0") == ID then
			titre = titre.."\n{v}( "..TRP2_LOC_ACTIVE.." )";
		end
		if TRP2_GetWithDefaut(EtapeInfoTab,"EtapeFlag") == 3 then
			message = message.."{v}< "..TRP2_LOC_ACCOMPLISHED.." >\n";
		elseif TRP2_GetWithDefaut(EtapeInfoTab,"EtapeFlag") == 2 then
			message = message.."{r}< "..TRP2_LOC_FAILED.." >\n";
		end
		message = message.."{o}\"{w}"..TRP2_GetWithDefaut(QuestInfoTab,"Description",TRP2_LOC_NODESCR).."{o}\"";
		
		if TRP2_GetConfigValueFor("DebugMode",false) then
			message = message.."\n{c}DEBUG : "..TRP2_LOC_ETAPE.." : "..TRP2_GetWithDefaut(QuestTab,"Etape","nil");
		end
		
		if TRP2_EmptyToNil(TRP2_GetWithDefaut(QuestTab,"LastEtapeDescri")) then
			message = message.."\n\n{o}"..TRP2_LOC_DERNIEREMENT.." :\n\"{w}"..TRP2_GetWithDefaut(QuestTab,"LastEtapeDescri").."{o}\""
		end
		message = message.."\n\n";
		if not bUi then
			if TRP2_GetInfo(TRP2_Joueur,"ActualQuest","0") ~= ID then
				message = message.."{j}"..TRP2_LOC_CLIC.." : {v}"..TRP2_LOC_ACTIVEASSIGN.."\n";
			end
			message = message.."{j}"..TRP2_LOC_CLICDROIT.." : {r}"..TRP2_LOC_QUITQUEST.."\n";
			if TRP2_GetWithDefaut(QuestInfoTab,"bReinit") then
				message = message.."{j}"..TRP2_LOC_CLICDROITMAJ.." : {o}"..TRP2_LOC_REINITQUEST.."\n";
			end
		else
			message = message.."{j}"..TRP2_LOC_CLIC.." : {v}"..TRP2_LOC_OPENQUESTLOG.."\n";
			message = message.."{j}"..TRP2_LOC_CLICDROIT.." : {v}"..TRP2_LOC_CLOSEACTIONFRAME.."\n";
			message = message.."{j}"..TRP2_LOC_CLICGLISSER.." : {v}"..PET_ACTION_MOVE_TO;
		end
	else
		titre = "{r}"..UNKNOWN.." (ID : "..ID..")";
		message = "{o}"..TRP2_LOC_QUESTERROR1;
	end
	
	return titre,message;
end

function TRP2_QuestEtapeScript(id)
	if TRP2_Module_QuestsLog[TRP2_Royaume][TRP2_Joueur][id] then
		return TRP2_Module_QuestsLog[TRP2_Royaume][TRP2_Joueur][id]["Etape"];
	else
		return "0";
	end
end

function TRP2_QuestsGoToStep(etape,ID,mode)
	if not TRP2_EmptyToNil(ID) or ID == "nil" then
		return;
	end

	if not TRP2_Module_QuestsLog[TRP2_Royaume][TRP2_Joueur][ID] and mode == 1 then -- On fait rien
		return;
	else
		local QuestInfoTab = TRP2_GetQuestsInfo(ID);
		local EtapeInfoTab = TRP2_GetWithDefaut(QuestInfoTab,"Etapes",{})[etape];
		-- La function
		local funct = function()
			if not TRP2_Module_QuestsLog[TRP2_Royaume][TRP2_Joueur][ID] then
				TRP2_Module_QuestsLog[TRP2_Royaume][TRP2_Joueur][ID] = {};
			end
			TRP2_Module_QuestsLog[TRP2_Royaume][TRP2_Joueur][ID]["Etape"] = etape;
			if etape == "001" then
				TRP2_Module_QuestsLog[TRP2_Royaume][TRP2_Joueur][ID]["LastEtapeDescri"] = "";
			end
			if EtapeInfoTab then
				if TRP2_CheckConditions(TRP2_GetWithDefaut(EtapeInfoTab,"OnEtapeCondi")) then
					if TRP2_PlayScripts(TRP2_GetWithDefaut(EtapeInfoTab,"OnEtapeScripts"),ID) ~= false then
						TRP2_PlayEffect(TRP2_GetWithDefaut(EtapeInfoTab,"OnEtapeEffet",""),
							TRP2_LOC_CreationTypeQuest.." - {v}"..TRP2_GetWithDefaut(QuestInfoTab,"Nom",TRP2_LOC_NEWQUEST),ID,nil,nil,TRP2_GetWithDefaut(QuestInfoTab,"Createur","")
						);
					end
				end
				if TRP2_EmptyToNil(TRP2_GetWithDefaut(EtapeInfoTab,"Description")) then
					TRP2_Module_QuestsLog[TRP2_Royaume][TRP2_Joueur][ID]["LastEtapeDescri"] = TRP2_GetWithDefaut(EtapeInfoTab,"Description");
				end
				if TRP2_GetWithDefaut(EtapeInfoTab,"EtapeFlag",1) == 2 then
					TRP2_Afficher(TRP2_FT(TRP2_LOC_QUESTFAILED,TRP2_CreatSimpleTooltipQuest(QuestInfoTab)),nil,nil,3);
					TRP2_PlaySound("Sound\\Interface\\igQuestFailed.wav");
				elseif TRP2_GetWithDefaut(EtapeInfoTab,"EtapeFlag",1) == 3 then
					TRP2_Afficher(TRP2_FT(TRP2_LOC_QUESTCOMPLETZED,TRP2_CreatSimpleTooltipQuest(QuestInfoTab)),nil,nil,3);
					TRP2_PlaySound("Sound\\Interface\\iQuestComplete.wav");
				end
			end
			if TRP2_GetInfo(TRP2_Joueur,"ActualQuest") ~= ID then
				TRP2_SetActiveQuest(ID);
			end
			TRP2_LoadQuestsList();
		end
		
		if not TRP2_Module_QuestsLog[TRP2_Royaume][TRP2_Joueur][ID] and mode == 2 then -- On demande
			StaticPopupDialogs["TRP2_CONFIRM_ACTION_NS"].text = TRP2_CTS(TRP2_FT(TRP2_ENTETE..TRP2_LOC_STARTQUEST3,"{o}[{v}"..TRP2_GetWithDefaut(QuestInfoTab,"Nom",TRP2_LOC_NEWQUEST).."{o}]"));
			TRP2_ShowStaticPopup("TRP2_CONFIRM_ACTION_NS",nil,function()
				funct();
			end);
		else
			funct();
		end
	end
end

function TRP2_PerformAction(action,parole)
	-- TODO : test si option RP et statut RP
	local ID = TRP2_GetInfo(TRP2_Joueur,"ActualQuest","0"); if ID == "0" then return end -- Si aucune quête en cours
	local QuestInfoTab = TRP2_GetQuestsInfo(ID);
	local QuestTab = TRP2_Module_QuestsLog[TRP2_Royaume][TRP2_Joueur][ID];
	local auMoinsUn;
	local ActualEtape = TRP2_GetWithDefaut(QuestTab,"Etape","0");
	local actionTab = TRP2_GetWithDefaut(QuestInfoTab,action.."Action",{});
	local ok=false;
	
	for actionNum,actionInfo in pairs(actionTab) do
		local okEtape = false;
		if TRP2_EmptyToNil(actionInfo["EtapesNum"]) then
			local EtapeTab = TRP2_FetchToTabWithSeparator(actionInfo["EtapesNum"],",");
			for key,value in pairs(EtapeTab) do
				if value == ActualEtape then
					okEtape = true;
					break;
				end
			end
		else
			okEtape = true;
		end
		
		if okEtape then -- Ok, on peux faire le bazar ici.
			-- On rentre dans le vif du sujet
			if action ~= "Dire" or (TRP2_EmptyToNil(parole) and string.find(string.lower(" "..parole.." "),"%W"..TRP2_GetWithDefaut(actionInfo,"DireTab","").."%W")) then
				if TRP2_CheckConditions(TRP2_GetWithDefaut(actionInfo,"OnActionCondi")) then
					if TRP2_PlayScripts(TRP2_GetWithDefaut(actionInfo,"OnActionScripts"),ID) ~= false then
						TRP2_PlayEffect(TRP2_GetWithDefaut(actionInfo,"OnActionEffet",""),
							TRP2_LOC_CreationTypeQuest.." - {v}"..TRP2_GetWithDefaut(QuestInfoTab,"Nom",TRP2_LOC_NEWQUEST).."{o} - {v}".._G["TRP2_LOC_"..action],ID
							,nil,nil,TRP2_GetWithDefaut(QuestInfoTab,"Createur","")
						);
						auMoinsUn = true;
					end
				end
			end
		end
	end
	
	if not auMoinsUn then
		if UnitName("target") then
			if action == "Observer" then
				TRP2_Afficher("{o}[{v}".._G["TRP2_LOC_"..action].." "..TRP2_GetTargetTRPName().."{o}] :\n{w}"..TRP2_LOC_NOLOOK,TRP2_GetConfigValueFor("InvMessageFrameRP",1),true);
			elseif action == "Ecouter" then
				TRP2_Afficher("{o}[{v}".._G["TRP2_LOC_"..action].." "..TRP2_GetTargetTRPName().."{o}] :\n{w}"..TRP2_LOC_NOEAR,TRP2_GetConfigValueFor("InvMessageFrameRP",1),true);
			elseif action == "Fouiller" then
				TRP2_Afficher("{o}[{v}".._G["TRP2_LOC_"..action].." "..TRP2_GetTargetTRPName().."{o}] :\n{w}"..TRP2_LOC_NODIGG,TRP2_GetConfigValueFor("InvMessageFrameRP",1),true);
			elseif action == "Dire" and parole == "TALK" then
				TRP2_Afficher("{o}[{v}"..TRP2_LOC_SPEAKWITH..TRP2_GetTargetTRPName().."{o}] :\n{w}"..TRP2_LOC_NOTALK,TRP2_GetConfigValueFor("InvMessageFrameRP",1),true);
			end
		else
			if action == "Observer" then
				TRP2_Afficher("{o}[{v}".._G["TRP2_LOC_"..action].." "..TRP2_LOC_AREA.."{o}] :\n{w}"..TRP2_LOC_NOLOOK,TRP2_GetConfigValueFor("InvMessageFrameRP",1),true);
			elseif action == "Ecouter" then
				TRP2_Afficher("{o}[{v}".._G["TRP2_LOC_"..action].." "..TRP2_LOC_AREA.."{o}] :\n{w}"..TRP2_LOC_NOEAR,TRP2_GetConfigValueFor("InvMessageFrameRP",1),true);
			elseif action == "Fouiller" then
				TRP2_Afficher("{o}[{v}".._G["TRP2_LOC_"..action].." "..TRP2_LOC_AREA.."{o}] :\n{w}"..TRP2_LOC_NODIGG,TRP2_GetConfigValueFor("InvMessageFrameRP",1),true);
			end
		end
	end
end

function TRP2_ActionBarTooltip(frame)
	local ID = TRP2_GetInfo(TRP2_Joueur,"ActualQuest","0");
	local QuestInfoTab = TRP2_GetQuestsInfo(ID);
	local EtapeInfoTab = TRP2_GetWithDefaut(QuestInfoTab,"Etapes",{})[TRP2_GetWithDefaut(TRP2_Module_QuestsLog[TRP2_Royaume][TRP2_Joueur][ID],"Etape","001")];
	local titre, message = TRP2_QuestsToString(ID,QuestInfoTab,TRP2_Module_QuestsLog[TRP2_Royaume][TRP2_Joueur][ID],EtapeInfoTab,true);
	TRP2_SetTooltipForFrame(frame,frame,"TOP",0,0,titre,message);
	TRP2_RefreshTooltipForFrame(frame);
end

function TRP2_ActionTooltip(action,button)
	local titre, message;
	titre  = _G["TRP2_LOC_"..action];
	if UnitName("target") then
		message = TRP2_FT(_G["TRP2_LOC_"..action.."_TAR_TT"],TRP2_GetTargetTRPName());
	else
		message = _G["TRP2_LOC_"..action.."_ENV_TT"];
	end
	TRP2_SetTooltipForFrame(button,button,"BOTTOM",0,0,titre,message);
	TRP2_RefreshTooltipForFrame(button);
end

--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- CREATION QUETES
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

function TRP2_CreatQuetActionDD(frame,level,menuList)
	UIDropDownMenu_SetWidth(frame, 50);
	UIDropDownMenu_SetButtonWidth(frame, 15);
	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_LOC_ACTION;
	info.func = function() end;
	info.isTitle = true;
	UIDropDownMenu_AddButton(info);
	
	local statut = TRP2_CreationFrameQuestFrameActionType.Valeur;
	
	local i;
	for i=1,#TRP2_LOC_QUESTACTION,1 do
		info = TRP2_CreateSimpleDDButton();
		if statut == i then
			info.text = TRP2_CTS("{icone:"..TRP2_QuestActionIconeTab[i]..":16} "..TRP2_LOC_QUESTACTION[i]);
			info.checked = true;
			info.disabled = true;
		else
			info.text = TRP2_CTS("{icone:"..TRP2_QuestActionIconeTab[i]..":16} "..TRP2_LOC_QUESTACTION[i]);
		end
		info.func = function()
			TRP2_CreationFrameQuestFrameActionType.Valeur = i;
			TRP2_CreationFrameQuestFrameActionTypeValeur:SetText(TRP2_CTS("{icone:"..TRP2_QuestActionIconeTab[i]..":16} "..TRP2_LOC_QUESTACTION[i]));
		end;
		UIDropDownMenu_AddButton(info,level);
	end
	info = TRP2_CreateSimpleDDButton();
	info.text = CANCEL;
	UIDropDownMenu_AddButton(info,level);
end

function TRP2_CreatQuetEtatDD(frame,level,menuList)
	UIDropDownMenu_SetWidth(frame, 50);
	UIDropDownMenu_SetButtonWidth(frame, 15);
	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_LOC_FLAG;
	info.func = function() end;
	info.isTitle = true;
	UIDropDownMenu_AddButton(info);
	
	local statut = TRP2_CreationFrameQuestFrameEtapeEtat.Valeur;
	
	local i;
	for i=1,#TRP2_LOC_QUESTMARK,1 do
		info = TRP2_CreateSimpleDDButton();
		if statut == i then
			info.text = TRP2_CTS("{icone:"..TRP2_QuestEtapeIconeTab[i]..":16} "..TRP2_LOC_QUESTMARK[i]);
			info.checked = true;
			info.disabled = true;
		else
			info.text = TRP2_CTS("{icone:"..TRP2_QuestEtapeIconeTab[i]..":16} "..TRP2_LOC_QUESTMARK[i]);
		end
		info.func = function()
			TRP2_CreationFrameQuestFrameEtapeEtat.Valeur = i;
			TRP2_CreationFrameQuestFrameEtapeEtatValeur:SetText(TRP2_CTS("{icone:"..TRP2_QuestEtapeIconeTab[i]..":16} "..TRP2_LOC_QUESTMARK[i]));
		end;
		UIDropDownMenu_AddButton(info,level);
	end
	info = TRP2_CreateSimpleDDButton();
	info.text = CANCEL;
	UIDropDownMenu_AddButton(info,level);
end

function TRP2_ListerEtapeQuest()
	local i = 0; -- Nombre total
	local j = 0; -- Nombre pris
	local search = TRP2_EmptyToNil(TRP2_CreationFrameQuestFrameListeEtapeRecherche:GetText());
	TRP2_CreationFrameQuestFrameListeEtapeSlider:Hide();
	TRP2_CreationFrameQuestFrameListeEtapeSlider:SetValue(0);
	wipe(TRP2_CreaListTabEvent);
	
	table.foreach(TRP2_CreationFrameQuest.EtapeTab,function(Num)
		i = i+1;
		if not search or TRP2_ApplyPattern(Num,search) then
			j = j + 1;
			TRP2_CreaListTabEvent[j] = Num;
		end
	end);
	
	table.sort(TRP2_CreaListTabEvent);

	if j > 0 then
		TRP2_CreationFrameQuestFrameListeEtapeEmpty:SetText("");
	elseif i == 0 then
		TRP2_CreationFrameQuestFrameListeEtapeEmpty:SetText(TRP2_LOC_NOETAPE);
	else
		TRP2_CreationFrameQuestFrameListeEtapeEmpty:SetText(TRP2_LOC_SelectVide);
	end
	if j > 49 then
		TRP2_CreationFrameQuestFrameListeEtapeSlider:Show();
		local total = floor((j-1)/49);
		TRP2_CreationFrameQuestFrameListeEtapeSlider:SetMinMaxValues(0,total);
	end
	TRP2_CreationFrameQuestFrameListeEtapeSlider:SetScript("OnValueChanged",function(self)
		if self:IsVisible() then
			TRP2_ListerEtapeQuestPage(self:GetValue());
		end
	end);
	TRP2_CreationFrameQuestFrameListeEtapeRecherche:SetScript("OnTextChanged",function(self)
		if self:IsVisible() then
			TRP2_ListerEtapeQuest();
		end
	end);
	TRP2_ListerEtapeQuestPage(0);
end

function TRP2_ListerActionQuest()
	local i = 0; -- Nombre total
	local j = 0; -- Nombre pris
	local search = TRP2_EmptyToNil(TRP2_CreationFrameQuestFrameListeActionRecherche:GetText());
	TRP2_CreationFrameQuestFrameListeActionSlider:Hide();
	TRP2_CreationFrameQuestFrameListeActionSlider:SetValue(0);
	wipe(TRP2_CreaListTabDocu);
	
	table.foreach(TRP2_CreationFrameQuest.ActionTab,function(Num)
		i = i+1;
		if not search or TRP2_ApplyPattern(Num,search) then
			j = j + 1;
			TRP2_CreaListTabDocu[j] = Num;
		end
	end);
	
	table.sort(TRP2_CreaListTabDocu);

	if j > 0 then
		TRP2_CreationFrameQuestFrameListeActionEmpty:SetText("");
	elseif i == 0 then
		TRP2_CreationFrameQuestFrameListeActionEmpty:SetText(TRP2_LOC_NOACTION);
	else
		TRP2_CreationFrameQuestFrameListeActionEmpty:SetText(TRP2_LOC_SelectVide);
	end
	if j > 49 then
		TRP2_CreationFrameQuestFrameListeActionSlider:Show();
		local total = floor((j-1)/49);
		TRP2_CreationFrameQuestFrameListeActionSlider:SetMinMaxValues(0,total);
	end
	TRP2_CreationFrameQuestFrameListeActionSlider:SetScript("OnValueChanged",function(self)
		if self:IsVisible() then
			TRP2_ListerActionQuestPage(self:GetValue());
		end
	end)
	TRP2_CreationFrameQuestFrameListeActionRecherche:SetScript("OnTextChanged",function(self)
		if self:IsVisible() then
			TRP2_ListerActionQuest();
		end
	end)
	TRP2_ListerActionQuestPage(0);
end

function TRP2_CreaQuestChargerEtape(ID)
	local info = TRP2_CreationFrameQuest.EtapeTab[ID];
	
	TRP2_CreationFrameQuestFrameEtape.OldID = ID;
	TRP2_CreationFrameQuestFrameEtapeEtapeNum:SetText(ID);
	TRP2_CreationFrameQuestFrameEtapeEtat.Valeur = TRP2_GetWithDefaut(info,"EtapeFlag",1);
	TRP2_CreationFrameQuestFrameEtapeEtatValeur:SetText(TRP2_CTS("{icone:"..TRP2_QuestEtapeIconeTab[TRP2_GetWithDefaut(info,"EtapeFlag",1)]..":16} "..TRP2_LOC_QUESTMARK[TRP2_GetWithDefaut(info,"EtapeFlag",1)]));
	TRP2_CreationFrameQuestFrameEtapeDescriptionScrollEditBox:SetText(TRP2_GetWithDefaut(info,"Description",""));
	TRP2_CreationFrameQuestFrameEtapeOnEtape.Effets = TRP2_GetWithDefaut(info,"OnEtapeEffet","");
	TRP2_CreationFrameQuestFrameEtapeOnEtape.Conditions = TRP2_GetWithDefaut(info,"OnEtapeCondi","");
	TRP2_CreationFrameQuestFrameEtapeOnEtape.Scripts = TRP2_GetWithDefaut(info,"OnEtapeScripts");
	
	TRP2_CreationFrameQuestFrameEtapeSave:SetScript("OnClick",function()
		if TRP2_CreationFrameQuest.EtapeTab[ID] then
			wipe(TRP2_CreationFrameQuest.EtapeTab[ID]);
			TRP2_CreationFrameQuest.EtapeTab[ID] = nil;
		end
		local newID = TRP2_CreationFrameQuestFrameEtapeEtapeNum:GetText();
		if not TRP2_EmptyToNil(newID) then
			newID = ID;
		end
		TRP2_CreationFrameQuest.EtapeTab[newID] = {};
		TRP2_CreationFrameQuest.EtapeTab[newID]["EtapeFlag"] = TRP2_DefautToNil(TRP2_CreationFrameQuestFrameEtapeEtat.Valeur,1);
		TRP2_CreationFrameQuest.EtapeTab[newID]["Description"] = TRP2_EmptyToNil(TRP2_CreationFrameQuestFrameEtapeDescriptionScrollEditBox:GetText());
		TRP2_CreationFrameQuest.EtapeTab[newID]["OnEtapeEffet"] = TRP2_EmptyToNil(TRP2_CreationFrameQuestFrameEtapeOnEtape.Effets);
		TRP2_CreationFrameQuest.EtapeTab[newID]["OnEtapeCondi"] = TRP2_EmptyToNil(TRP2_CreationFrameQuestFrameEtapeOnEtape.Conditions);
		TRP2_CreationFrameQuest.EtapeTab[newID]["OnEtapeScripts"] = TRP2_EmptyToNil(TRP2_CreationFrameQuestFrameEtapeOnEtape.Scripts);
		if TRP2_TriggerEditFrame.from == TRP2_CreationFrameQuestFrameEtapeOnEtape then
			TRP2_TriggerEditFrame:Hide();
		end
		TRP2_CreationFrameQuestFrameListeEtape:Show();
		TRP2_CreationFrameQuestFrameEtape:Hide();
		TRP2_ListerEtapeQuest();
	end);
	
	TRP2_CreationFrameQuestFrameEtapeTitle:SetText(TRP2_LOC_ETAPE.." : "..ID);
	
	TRP2_CreationFrameQuestFrameListeEtape:Hide();
	TRP2_CreationFrameQuestFrameEtape:Show();
end

function TRP2_CreaQuestChargerAction(ID)
	local info = TRP2_CreationFrameQuest.ActionTab[ID];

	TRP2_CreationFrameQuestFrameActionType.Valeur = TRP2_GetWithDefaut(info,"Type",1);
	TRP2_CreationFrameQuestFrameActionTypeValeur:SetText(TRP2_CTS("{icone:"..TRP2_QuestActionIconeTab[TRP2_GetWithDefaut(info,"Type",1)]..":16} "..TRP2_LOC_QUESTACTION[TRP2_GetWithDefaut(info,"Type",1)]));
	TRP2_CreationFrameQuestFrameActionOnAction.Effets = TRP2_GetWithDefaut(info,"OnActionEffet","");
	TRP2_CreationFrameQuestFrameActionOnAction.Conditions = TRP2_GetWithDefaut(info,"OnActionCondi","");
	TRP2_CreationFrameQuestFrameActionOnAction.Scripts = TRP2_GetWithDefaut(info,"OnActionScripts");
	TRP2_CreationFrameQuestFrameActionParole:SetText(TRP2_GetWithDefaut(info,"DireTab",""));
	TRP2_CreationFrameQuestFrameActionEtape:SetText(TRP2_GetWithDefaut(info,"EtapesNum",""));
	
	TRP2_CreationFrameQuestFrameActionSave:SetScript("OnClick",function()
		TRP2_CreationFrameQuest.ActionTab[ID] = {};
		TRP2_CreationFrameQuest.ActionTab[ID]["Type"] = TRP2_DefautToNil(TRP2_CreationFrameQuestFrameActionType.Valeur,1);
		TRP2_CreationFrameQuest.ActionTab[ID]["OnActionEffet"] = TRP2_EmptyToNil(TRP2_CreationFrameQuestFrameActionOnAction.Effets);
		TRP2_CreationFrameQuest.ActionTab[ID]["OnActionCondi"] = TRP2_EmptyToNil(TRP2_CreationFrameQuestFrameActionOnAction.Conditions);
		TRP2_CreationFrameQuest.ActionTab[ID]["OnActionScripts"] = TRP2_EmptyToNil(TRP2_CreationFrameQuestFrameActionOnAction.Scripts);
		TRP2_CreationFrameQuest.ActionTab[ID]["DireTab"] = TRP2_EmptyToNil(TRP2_CreationFrameQuestFrameActionParole:GetText());
		TRP2_CreationFrameQuest.ActionTab[ID]["EtapesNum"] = TRP2_EmptyToNil(TRP2_CreationFrameQuestFrameActionEtape:GetText());
		if TRP2_TriggerEditFrame.from == TRP2_CreationFrameQuestFrameActionOnAction then
			TRP2_TriggerEditFrame:Hide();
		end
		TRP2_CreationFrameQuestFrameListeAction:Show();
		TRP2_CreationFrameQuestFrameAction:Hide();
		TRP2_ListerActionQuest();
	end);
	
	TRP2_CreationFrameQuestFrameActionTitle:SetText(TRP2_LOC_ACTION.." : "..ID);
	
	TRP2_CreationFrameQuestFrameListeAction:Hide();
	TRP2_CreationFrameQuestFrameAction:Show();
end

function TRP2_ListerActionQuestPage(num)
	for k=1,49,1 do --Initialisation
		getglobal("TRP2_CreationFrameQuestFrameListeActionSlot"..k):Hide();
	end
	local i = 1;
	local j = 1;
	table.foreach(TRP2_CreaListTabDocu,
	function(TabIndex)
		if i > num*49 and i <= (num+1)*49 then
			local ID = TRP2_CreaListTabDocu[TabIndex];
			getglobal("TRP2_CreationFrameQuestFrameListeActionSlot"..j):Show();
			getglobal("TRP2_CreationFrameQuestFrameListeActionSlot"..j.."Icon"):SetTexture("Interface\\ICONS\\"..TRP2_QuestActionIconeTab[TRP2_GetWithDefaut(TRP2_CreationFrameQuest.ActionTab[ID],"Type",1)]);
			getglobal("TRP2_CreationFrameQuestFrameListeActionSlot"..j):SetScript("OnClick", function(self,button)
				if button == "LeftButton" then
					if IsControlKeyDown() then
						local newID = TRP2_FoundFreePlace(TRP2_CreationFrameQuest.ActionTab,"",3);
						TRP2_CreationFrameQuest.ActionTab[newID] = {};
						TRP2_tcopy(TRP2_CreationFrameQuest.ActionTab[newID],TRP2_CreationFrameQuest.ActionTab[ID]);
						--TRP2_CreaQuestChargerAction(newID);
						TRP2_ListerActionQuest();
					else
						TRP2_CreaQuestChargerAction(ID);
					end
				else
					StaticPopupDialogs["TRP2_CONFIRM_ACTION_NS"].text = TRP2_CTS(TRP2_FT(TRP2_ENTETE..TRP2_LOC_DELETEACTION,ID));
					TRP2_ShowStaticPopup("TRP2_CONFIRM_ACTION_NS",nil,function()
						wipe(TRP2_CreationFrameQuest.ActionTab[ID]);
						TRP2_CreationFrameQuest.ActionTab[ID] = nil;
						TRP2_ListerActionQuest();
					end);
				end
			end);
			
			local message = "{o}"..TYPE.." : {w}"..TRP2_LOC_QUESTACTION[TRP2_GetWithDefaut(TRP2_CreationFrameQuest.ActionTab[ID],"Type",1)];
			message = message.."\n{o}"..TRP2_LOC_ETAPES.." : {w}"..TRP2_GetWithDefaut(TRP2_CreationFrameQuest.ActionTab[ID],"EtapesNum",ALL);
			if TRP2_GetWithDefaut(TRP2_CreationFrameQuest.ActionTab[ID],"Type",1) == 2 and TRP2_GetWithDefaut(TRP2_CreationFrameQuest.ActionTab[ID],"DireTab") then
				message = message.."\n{o}"..TRP2_LOC_PAROLES.." : {w}\""..TRP2_GetWithDefaut(TRP2_CreationFrameQuest.ActionTab[ID],"DireTab").."\"";
			end
			if TRP2_GetWithDefaut(TRP2_CreationFrameQuest.ActionTab[ID],"OnActionCondi") then
				message = message.."\n{o}"..TRP2_LOC_CONDITIONS.." : {v}"..YES;
			else
				message = message.."\n{o}"..TRP2_LOC_CONDITIONS.." : {r}"..NO;
			end
			if TRP2_GetWithDefaut(TRP2_CreationFrameQuest.ActionTab[ID],"OnActionEffet") then
				message = message.."\n{o}"..TRP2_LOC_EFFETS.." : {v}"..YES;
			else
				message = message.."\n{o}"..TRP2_LOC_EFFETS.." : {r}"..NO;
			end
			message = message.."\n\n{j}"..TRP2_LOC_CLIC.." : {w}"..TRP2_LOC_EDITACTION;
			message = message.."\n{j}"..TRP2_LOC_CLICCTRL.." : {w}"..TRP2_LOC_COPYACTION;
			-- Calcul du tooltip
			TRP2_SetTooltipForFrame(
				getglobal("TRP2_CreationFrameQuestFrameListeActionSlot"..j),
				getglobal("TRP2_CreationFrameQuestFrameListeActionSlot"..j),"TOPLEFT",0,0,
				"{w}|TInterface\\ICONS\\"..TRP2_QuestActionIconeTab[TRP2_GetWithDefaut(TRP2_CreationFrameQuest.ActionTab[ID],"Type",1)]..":35:35|t "..TRP2_LOC_ACTION.." "..ID,
				message
			);
			j = j + 1;
		end
		i = i + 1;
	end);
end

function TRP2_ListerEtapeQuestPage(num)
	for k=1,49,1 do --Initialisation
		getglobal("TRP2_CreationFrameQuestFrameListeEtapeSlot"..k):Hide();
	end
	local i = 1;
	local j = 1;
	table.foreach(TRP2_CreaListTabEvent,
	function(TabIndex)
		if i > num*49 and i <= (num+1)*49 then
			local ID = TRP2_CreaListTabEvent[TabIndex];
			getglobal("TRP2_CreationFrameQuestFrameListeEtapeSlot"..j):Show();
			getglobal("TRP2_CreationFrameQuestFrameListeEtapeSlot"..j.."Icon"):SetTexture("Interface\\ICONS\\"..TRP2_QuestEtapeIconeTab[TRP2_GetWithDefaut(TRP2_CreationFrameQuest.EtapeTab[ID],"EtapeFlag",1)]);
			getglobal("TRP2_CreationFrameQuestFrameListeEtapeSlot"..j):SetScript("OnClick", function(self,button)
				if button == "LeftButton" then
					if IsControlKeyDown() then
						local newID = TRP2_FoundFreePlace(TRP2_CreationFrameQuest.EtapeTab,"",3);
						TRP2_CreationFrameQuest.EtapeTab[newID] = {};
						TRP2_tcopy(TRP2_CreationFrameQuest.EtapeTab[newID],TRP2_CreationFrameQuest.EtapeTab[ID]);
						--TRP2_CreaQuestChargerEtape(newID);
						TRP2_ListerEtapeQuest();
					else
						TRP2_CreaQuestChargerEtape(ID);
					end
				else
					StaticPopupDialogs["TRP2_CONFIRM_ACTION_NS"].text = TRP2_CTS(TRP2_FT(TRP2_ENTETE..TRP2_LOC_DELETEETAPE,ID));
					TRP2_ShowStaticPopup("TRP2_CONFIRM_ACTION_NS",nil,function()
						wipe(TRP2_CreationFrameQuest.EtapeTab[ID]);
						TRP2_CreationFrameQuest.EtapeTab[ID] = nil;
						TRP2_ListerEtapeQuest();
					end);
				end
			end);
			local message = "{o}"..TRP2_LOC_Description.." :\n\"{w}"..TRP2_GetWithDefaut(TRP2_CreationFrameQuest.EtapeTab[ID],"Description",TRP2_LOC_NODESCR).."{o}\"";
			if TRP2_GetWithDefaut(TRP2_CreationFrameQuest.EtapeTab[ID],"OnEtapeCondi") then
				message = message.."\n{o}"..TRP2_LOC_CONDITIONS.." : {v}"..YES;
			else
				message = message.."\n{o}"..TRP2_LOC_CONDITIONS.." : {r}"..NO;
			end
			if TRP2_GetWithDefaut(TRP2_CreationFrameQuest.EtapeTab[ID],"OnEtapeEffet") then
				message = message.."\n{o}"..TRP2_LOC_EFFETS.." : {v}"..YES;
			else
				message = message.."\n{o}"..TRP2_LOC_EFFETS.." : {r}"..NO;
			end
			message = message.."\n\n{j}"..TRP2_LOC_CLIC.." : {w}"..TRP2_LOC_EDITSTEP;
			message = message.."\n{j}"..TRP2_LOC_CLICCTRL.." : {w}"..TRP2_LOC_COPYSTEP;
			-- Calcul du tooltip
			TRP2_SetTooltipForFrame(
				getglobal("TRP2_CreationFrameQuestFrameListeEtapeSlot"..j),
				getglobal("TRP2_CreationFrameQuestFrameListeEtapeSlot"..j),"TOPLEFT",0,0,
				"{w}|TInterface\\ICONS\\"..TRP2_QuestEtapeIconeTab[TRP2_GetWithDefaut(TRP2_CreationFrameQuest.EtapeTab[ID],"EtapeFlag",1)]..":35:35|t {o}"..TRP2_LOC_ETAPE.." : {w}"..ID,
				message
			);
			j = j + 1;
		end
		i = i + 1;
	end);
end

function TRP2_ChargerCreaQuestPanel(QuestID)
	local QuestTab = TRP2_GetQuestsInfo(QuestID);
	local titre = TRP2_LOC_CREZTEQUEST.." : ".."{o}[{v}"..TRP2_GetWithDefaut(QuestTab,"Nom",TRP2_LOC_NEWQUEST).."{o}]";
	if TRP2_CanWrite(QuestTab,QuestID) then
		titre = titre.." {j}("..TRP2_LOC_Edition..")";
		TRP2_CreationFrameQuestFrameMenuSave:Enable();
		TRP2_CreationFrameQuestFrameFlagsWriteLock:Enable();
		TRP2_CreationFrameQuestFrameFlagsWriteLock.disabled = nil;
	else
		titre = titre.." {v}("..TRP2_LOC_Consulte..")";
		TRP2_CreationFrameQuestFrameMenuSave:Disable();
		TRP2_CreationFrameQuestFrameFlagsWriteLock:Disable();
		TRP2_CreationFrameQuestFrameFlagsWriteLock.disabled = 1;
	end
	TRP2_CreationFrameHeaderTitle:SetText(TRP2_CTS(titre));
	TRP2_CreationFrameQuestFrameGeneralTitre:SetText(TRP2_GetWithDefaut(QuestTab,"Nom",TRP2_LOC_NEWQUEST));
	TRP2_CreationFrameQuestFrameGeneralDescriptionScrollEditBox:SetText(TRP2_GetWithDefaut(QuestTab,"Description",""));
	TRP2_CreationFrameQuestFrameGeneralIconeIcon:SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(QuestTab,"Icone","Temp"));
	TRP2_CreationFrameQuestFrameGeneralIcone.icone = TRP2_GetWithDefaut(QuestTab,"Icone","Temp");
	TRP2_CreationFrameQuestFrameFlagsWriteLock:SetChecked(TRP2_GetWithDefaut(QuestTab,"bWriteLock",1));
	TRP2_CreationFrameQuestFrameFlagsManual:SetChecked(TRP2_GetWithDefaut(QuestTab,"bManual",1));
	TRP2_CreationFrameQuestFrameFlagsReinit:SetChecked(TRP2_GetWithDefaut(QuestTab,"bReinit"));
	TRP2_CreationFrameQuestFrameInfoID:SetText(TRP2_CTS("{o}ID : {w}"..QuestID));
	TRP2_CreationFrameQuestFrameInfoCreateur:SetText(TRP2_CTS("{o}"..TRP2_LOC_CREATOR.." : {w}"..TRP2_GetWithDefaut(QuestTab,"Createur",TRP2_Joueur)));
	TRP2_CreationFrameQuestFrameInfoVernum:SetText(TRP2_CTS("{o}"..GAME_VERSION_LABEL.." : {w}"..TRP2_GetWithDefaut(QuestTab,"VerNum",1)));
	TRP2_CreationFrameQuestFrameInfoDate:SetText(TRP2_CTS("{o}"..TRP2_LOC_LASTDATE.." : {w}"..TRP2_GetWithDefaut(QuestTab,"Date",date("%d/%m/%y, %H:%M:%S"))));
	
	TRP2_CreationFrameQuest.ID = QuestID;
	TRP2_PanelCreationQuestOnUpdate();
	TRP2_CreationFrameQuestFrameListeEtape:Show();
	TRP2_CreationFrameQuestFrameEtape:Hide();
	TRP2_CreationFrameQuestFrameListeAction:Show();
	TRP2_CreationFrameQuestFrameAction:Hide();
	TRP2_CreationFrameQuest:Show();
	
	if TRP2_CreationFrameQuest.EtapeTab then
		wipe(TRP2_CreationFrameQuest.EtapeTab);
	end
	TRP2_CreationFrameQuest.EtapeTab = {};
	TRP2_tcopy(TRP2_CreationFrameQuest.EtapeTab,TRP2_GetWithDefaut(QuestTab,"Etapes",{}));
	
	if TRP2_CreationFrameQuest.ActionTab then
		wipe(TRP2_CreationFrameQuest.ActionTab);
	end
	TRP2_CreationFrameQuest.ActionTab = {};
	table.foreach(TRP2_GetWithDefaut(QuestTab,"ObserverAction",{}),function(action)
		TRP2_CreationFrameQuest.ActionTab[action] = {};
		TRP2_tcopy(TRP2_CreationFrameQuest.ActionTab[action],TRP2_GetWithDefaut(QuestTab,"ObserverAction",{})[action]);
		TRP2_CreationFrameQuest.ActionTab[action]["Type"] = 1;
	end);
	table.foreach(TRP2_GetWithDefaut(QuestTab,"EcouterAction",{}),function(action)
		TRP2_CreationFrameQuest.ActionTab[action] = {};
		TRP2_tcopy(TRP2_CreationFrameQuest.ActionTab[action],TRP2_GetWithDefaut(QuestTab,"EcouterAction",{})[action]);
		TRP2_CreationFrameQuest.ActionTab[action]["Type"] = 3;
	end);
	table.foreach(TRP2_GetWithDefaut(QuestTab,"FouillerAction",{}),function(action)
		TRP2_CreationFrameQuest.ActionTab[action] = {};
		TRP2_tcopy(TRP2_CreationFrameQuest.ActionTab[action],TRP2_GetWithDefaut(QuestTab,"FouillerAction",{})[action]);
		TRP2_CreationFrameQuest.ActionTab[action]["Type"] = 4;
	end);
	table.foreach(TRP2_GetWithDefaut(QuestTab,"DireAction",{}),function(action)
		TRP2_CreationFrameQuest.ActionTab[action] = {};
		TRP2_tcopy(TRP2_CreationFrameQuest.ActionTab[action],TRP2_GetWithDefaut(QuestTab,"DireAction",{})[action]);
		TRP2_CreationFrameQuest.ActionTab[action]["Type"] = 2;
	end);
	
	TRP2_ListerActionQuest();
	TRP2_ListerEtapeQuest();
end

function TRP2_PanelCreationQuestOnUpdate()
	TRP2_CreationFrameQuestFrameEtapeOnEtapeIcon:SetDesaturated(false);
	TRP2_CreationFrameQuestFrameEtapeOnEtape:Enable();
	if TRP2_EmptyToNil(TRP2_CreationFrameQuestFrameEtapeOnEtape.Effets) then
		TRP2_CreationFrameQuestFrameEtapeOnEtapeTexte:SetTextColor(0,1,0);
		TRP2_CreationFrameQuestFrameEtapeOnEtapeIcon:SetTexture("Interface\\ICONS\\INV_Torch_Thrown");
	else
		TRP2_CreationFrameQuestFrameEtapeOnEtapeTexte:SetTextColor(1,0.75,0);
		TRP2_CreationFrameQuestFrameEtapeOnEtapeIcon:SetTexture("Interface\\ICONS\\INV_Torch_Lit");
	end
	TRP2_CreationFrameQuestFrameActionOnActionIcon:SetDesaturated(false);
	TRP2_CreationFrameQuestFrameActionOnAction:Enable();
	if TRP2_EmptyToNil(TRP2_CreationFrameQuestFrameActionOnAction.Effets) then
		TRP2_CreationFrameQuestFrameActionOnActionTexte:SetTextColor(0,1,0);
		TRP2_CreationFrameQuestFrameActionOnActionIcon:SetTexture("Interface\\ICONS\\INV_Torch_Thrown");
	else
		TRP2_CreationFrameQuestFrameActionOnActionTexte:SetTextColor(1,0.75,0);
		TRP2_CreationFrameQuestFrameActionOnActionIcon:SetTexture("Interface\\ICONS\\INV_Torch_Lit");
	end
	if TRP2_CreationFrameQuestFrameActionType.Valeur == 2 then
		TRP2_CreationFrameQuestFrameActionParole.disabled = false;
	else
		TRP2_CreationFrameQuestFrameActionParole.disabled = true;
	end
end

function TRP2_CreateQuestTabCreation()
	local Quest = {};
	-- Enregistrement des flags
	Quest["bWriteLock"] = TRP2_DefautToNil(TRP2_CreationFrameQuestFrameFlagsWriteLock:GetChecked() == 1,true);
	Quest["bManual"] = TRP2_DefautToNil(TRP2_CreationFrameQuestFrameFlagsManual:GetChecked() == 1,true);
	Quest["bReinit"] = TRP2_DefautToNil(TRP2_CreationFrameQuestFrameFlagsReinit:GetChecked() == 1,false);
	Quest["Nom"] = TRP2_EmptyToNil(TRP2_CreationFrameQuestFrameGeneralTitre:GetText());
	Quest["Description"] = TRP2_EmptyToNil(TRP2_CreationFrameQuestFrameGeneralDescriptionScrollEditBox:GetText());
	Quest["Icone"] = TRP2_DefautToNil(TRP2_EmptyToNil(TRP2_CreationFrameQuestFrameGeneralIcone.icone),"Temp");
	Quest["Etapes"] = TRP2_CreationFrameQuest.EtapeTab;
	table.foreach(TRP2_CreationFrameQuest.ActionTab,function(action)
		local mode;
		if TRP2_GetWithDefaut(TRP2_CreationFrameQuest.ActionTab[action],"Type",1) == 1 then
			mode = "ObserverAction";
		elseif TRP2_GetWithDefaut(TRP2_CreationFrameQuest.ActionTab[action],"Type",1) == 2 then
			mode = "DireAction";
		elseif TRP2_GetWithDefaut(TRP2_CreationFrameQuest.ActionTab[action],"Type",1) == 3 then
			mode = "EcouterAction";
		elseif TRP2_GetWithDefaut(TRP2_CreationFrameQuest.ActionTab[action],"Type",1) == 4 then
			mode = "FouillerAction";
		end
		if not Quest[mode] then
			Quest[mode] = {};
		end
		Quest[mode][action] = {};
		Quest[mode][action]["EtapesNum"] = TRP2_EmptyToNil(TRP2_CreationFrameQuest.ActionTab[action]["EtapesNum"]);
		Quest[mode][action]["OnActionCondi"] = TRP2_EmptyToNil(TRP2_CreationFrameQuest.ActionTab[action]["OnActionCondi"]);
		Quest[mode][action]["OnActionEffet"] = TRP2_EmptyToNil(TRP2_CreationFrameQuest.ActionTab[action]["OnActionEffet"]);
		Quest[mode][action]["OnActionScripts"] = TRP2_EmptyToNil(TRP2_CreationFrameQuest.ActionTab[action]["OnActionScripts"]);
		Quest[mode][action]["DireTab"] = TRP2_EmptyToNil(TRP2_CreationFrameQuest.ActionTab[action]["DireTab"]);

	end);
	return Quest;
end

function TRP2_QuestSave(ID)
	local objet = TRP2_CreateQuestTabCreation();
	-- Ici t'aura un check
	objet["Createur"] = TRP2_GetWithDefaut(TRP2_Module_Quests[ID],"Createur",TRP2_Joueur);
	objet["Date"] = date("%d/%m/%y, %H:%M:%S").." "..TRP2_LOC_By.." "..TRP2_Joueur;
	if TRP2_GetWithDefaut(TRP2_Module_Quests[ID],"VerNum",1) < 10000 then
		objet["VerNum"] = TRP2_GetWithDefaut(TRP2_Module_Quests[ID],"VerNum",1) + 1;
	end
	if TRP2_Module_Quests[ID] then
		wipe(TRP2_Module_Quests[ID]);
	else
		TRP2_Module_Quests[ID] = {};
	end
	TRP2_tcopy(TRP2_Module_Quests[ID], objet);
	TRP2_Afficher(TRP2_FT(TRP2_LOC_CREA_AURA_SAVE,TRP2_GetWithDefaut(TRP2_Module_Quests[ID],"Nom",TRP2_LOC_NEWQUEST)));
	TRP2_ChargerCreaQuestPanel(ID);
end

function TRP2_QuestSaveAs()
	local IDnew = TRP2_CreateNewEmpty("Quest");
	TRP2_QuestSave(IDnew);
	TRP2_ChargerCreaQuestPanel(IDnew);
end

function TRP2_DD_QuestList(frame,level,menuList)
	UIDropDownMenu_SetWidth(frame, 50);
	UIDropDownMenu_SetButtonWidth(frame, 15);
	info = TRP2_CreateSimpleDDButton();
	info.text = DISPLAY;
	info.func = function() end;
	info.isTitle = true;
	UIDropDownMenu_AddButton(info);
	
	local i;
	for i=1,4,1 do
		info = TRP2_CreateSimpleDDButton();
		info.text = TRP2_LOC_QUESTSTATE[i];
		if TRP2MainFrameQuestsLogAffichage.Valeur == i then
			info.checked = true;
			info.disabled = true;
		end
		info.func = function() 
			TRP2MainFrameQuestsLogAffichage.Valeur = i;
			TRP2MainFrameQuestsLogAffichageValeur:SetText(TRP2_LOC_QUESTSTATE[TRP2MainFrameQuestsLogAffichage.Valeur]);
			TRP2_LoadQuestsList();
		end;
		UIDropDownMenu_AddButton(info,level);
	end
	info = TRP2_CreateSimpleDDButton();
	info.text = CANCEL;
	UIDropDownMenu_AddButton(info,level);
end

--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- QUEST FRAME WOW
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

function TRP2_ActualGoTo(etape)
	TRP2_QuestsGoToStep(etape,TRP2_GetInfo(TRP2_Joueur,"ActualQuest",0),1);
end

function TRP2_TexteScript(entete,texte,mode)
	if tonumber(mode) ~= 4 then
		TRP2_Afficher("{o}["..entete.."{o}] :\n{w}"..texte,TRP2_GetConfigValueFor("InvMessageFrameRP",1),true,tonumber(mode));
	else
		local bCible,bAnim;
		if string.find(texte,"^pas%scible\n") then
			texte = string.gsub(texte,"^pas%scible\n","");
			bCible = true;
		else
			bCible = false;
		end
		if string.find(texte,"^pas%sanim\n") then
			texte = string.gsub(texte,"^pas%sanim\n","");
			bAnim = false;
		else
			bAnim = true;
		end
		TRP2_QuestEffet("{o}["..entete.."{o}]",texte,bCible,bAnim);
	end
end

function TRP2_QuestEffet(entete,texte,bNoTarget,bAnim)
	TRP2_DialQuestFrame:Show();
	texte = TRP2_FetchToTabWithSeparator(texte,"\n");
	
	TRP2_DialQuestFrameAnimCheck:SetChecked(bAnim);
	TRP2_DialQuestFrameAnimCheck:GetScript("OnClick")(TRP2_DialQuestFrameAnimCheck);
	
	TRP2_DialQuestFrame.actualQuest = TRP2_GetInfo(TRP2_Joueur,"ActualQuest");
	
	if not bNoTarget and UnitExists("target") then
		TRP2_DialQuestFrameModelFrameModel:Show();
		TRP2_DialQuestFrameModelFrameIcon:Hide();
		TRP2_DialQuestFrameModelFrameModel:SetModelScale(1);
		if bAnim then
			TRP2_DialQuestFrameModelFrameModel:SetCamera(1);
			TRP2_DialQuestFrameModelFrameModel:SetFacing(0.75);
			TRP2_DialQuestFrameModelFrameModel:SetUnit("target");
		else
			TRP2_DialQuestFrameModelFrameModel:SetUnit("target");
			TRP2_DialQuestFrameModelFrameModel:SetCamera(0);
		end
		TRP2_DialQuestFrameModelFrameModel.cible = UnitName("target");
		TRP2_DialQuestFrameModelFrameModel.tourner = false;
		
		local nom = TRP2_GetTargetTRPName();
		
		TRP2_ShowNextDiagDetail(texte,1,nom,"TRP2EFFET",entete);
	else
		TRP2_DialQuestFrameModelFrameModel:Hide();
		TRP2_DialQuestFrameModelFrameIcon:Show();
		TRP2_DialQuestFrameModelFrameIcon:SetTexture("Interface\\ICONS\\INV_Misc_Book_16");
		TRP2_ShowNextDiagDetail(texte,1,nil,"TRP2EFFET",entete);
	end
end

function TRP2_ShowNextDiagDetail(texteTab,diag,cible,mode,title)
	TRP2_DialQuestFrameNextButton:Hide();
	TRP2_DialQuestFramePreviousButton:Hide();
	TRP2_DialQuestFrameAcceptButton:Hide();
	TRP2_DialQuestFrameDeclineButton:Hide();
	TRP2_DialQuestFrameObjectifTitle:SetText("");
	TRP2_DialQuestFrameObjectifTexte:SetText("");
	TRP2_DialQuestFrameRewardTitle:SetText("");
	TRP2_DialQuestFrameRewardTexte:SetText("");
	TRP2_DialQuestFrameRewardChoix:SetText("");
	TRP2_DialQuestFrameAcceptButton:SetWidth(90);
	TRP2_DialQuestFrameAcceptButton:Enable();
	local j
	for j=1,10,1 do
		if getglobal("TRP2_DialQuestFrameRewardObjet"..j) then
			getglobal("TRP2_DialQuestFrameRewardObjet"..j):Hide();
		end
	end
	for j=1,10,1 do
		if getglobal("TRP2_DialQuestFrameRewardChoix"..j) then
			getglobal("TRP2_DialQuestFrameRewardChoix"..j):Hide();
		end
	end
	for j=1,20,1 do
		if getglobal("TRP2_DialQuestFrameGossip"..j) then
			getglobal("TRP2_DialQuestFrameGossip"..j):Hide();
		end
	end
	for j=1,20,1 do
		if getglobal("TRP2_TitleQuestFrameGossip"..j) then
			getglobal("TRP2_TitleQuestFrameGossip"..j):Hide();
		end
	end
	
	if cible then
		TRP2_DialQuestFrameNameTexte:SetText(TRP2_CTS("{o}"..tostring(cible).." :"));
	else
		TRP2_DialQuestFrameNameTexte:SetText("");
	end
	if diag ~= 1 then
		TRP2_DialQuestFramePreviousButton:Show();
		TRP2_DialQuestFramePreviousButton:SetScript("OnClick",function()
			TRP2_ShowNextDiagDetail(texteTab,diag-1,cible,mode,title);
		end);
	end
	
	--TRP2_debug(mode);
	
	local texte = texteTab[diag];
	
	local animTab = {};
	local sound;
	if not string.find(texte,"^{anim") then
		string.gsub(texte,"[%.%?%!]+",function(finder)
			if string.sub(finder,1,1) == "!" then
				animTab[#animTab+1] = 64;
			elseif string.sub(finder,1,1) == "?" then
				animTab[#animTab+1] = 65;
			else
				animTab[#animTab+1] = 60;
			end
		end);
		animTab[#animTab+1] = 0;
	else
		local anim = string.match(texte,"^{anim(%d%d%d)}");
		texte = string.gsub(texte,"{anim%d%d%d}","");
		animTab[1] = tonumber(anim);
	end
	
	if string.find(texte,"^{son:") then
		sound = string.match(texte,"^{son:(.-)}");
		if sound then
			TRP2_PlaySound(sound);
		end
		texte = string.gsub(texte,"^{son:.-}","");
	end
	if string.find(texte,"^{local:") then
		sound = string.match(texte,"^{local:(.-)}");
		if sound then
			TRP2_PlayLocalSound(sound,16);
		end
		texte = string.gsub(texte,"^{local:.-}","");
	end
	if string.find(texte,"^{raid:") then
		sound = string.match(texte,"^{raid:(.-)}");
		if sound then
			TRP2_SecureSendAddonMessageGroup("PLLS",sound);
			TRP2_PlaySound(sound);
		end
		texte = string.gsub(texte,"^{raid:.-}","");
	end
	if string.find(texte,"^{questicon:") then
		icone = string.match(texte,"^{questicon:(.-)}");
		if icone then
			TRP2_DialQuestFrameModelFrameIcon:SetTexture("Interface\\ICONS\\"..icone);
		end
		texte = string.gsub(texte,"^{questicon:.-}","");
	end
	
	local colorEmote = "{"..TRP2_deciToHexa(ChatTypeInfo["MONSTER_EMOTE"].r)..TRP2_deciToHexa(ChatTypeInfo["MONSTER_EMOTE"].g)..TRP2_deciToHexa(ChatTypeInfo["MONSTER_EMOTE"].b).."}";
	texte = string.gsub(texte,"%<","<"..colorEmote);
	texte = string.gsub(texte,"%>",">|r");
	
	if string.sub(texte,1,1) == "<" then
		texte = string.gsub(texte,"%<","");
		texte = string.gsub(texte,"%>","");
		TRP2_DialQuestFrameMainTexte:SetTextColor(ChatTypeInfo["MONSTER_EMOTE"].r,ChatTypeInfo["MONSTER_EMOTE"].g,ChatTypeInfo["MONSTER_EMOTE"].b);
		TRP2_DialQuestFrameMainTexte:SetText(TRP2_CTS(texte.."\n"));
		TRP2_DialQuestFramePlayButton:SetScript("OnClick",function()
			ChatThrottleLib:SendChatMessage("NORMAL",TRP2_COMM_PREFIX,"|| "..TRP2_CTS(string.gsub(texte,"|r",""),true),"EMOTE");
		end);
		animTab = {0};
	else
		TRP2_DialQuestFrameMainTexte:SetTextColor(ChatTypeInfo["MONSTER_SAY"].r,ChatTypeInfo["MONSTER_SAY"].g,ChatTypeInfo["MONSTER_SAY"].b);
		TRP2_DialQuestFrameMainTexte:SetText(TRP2_CTS("{w}\"|r"..texte.."{w}\"\n"));
		TRP2_DialQuestFramePlayButton:SetScript("OnClick",function()
			if cible then
				ChatThrottleLib:SendChatMessage("NORMAL",TRP2_COMM_PREFIX,"|| "..cible.." "..TRP2_LOC_DIT..TRP2_CTS(string.gsub(texte,"|r",""),true),"EMOTE");
			else
				ChatThrottleLib:SendChatMessage("NORMAL",TRP2_COMM_PREFIX,"|| "..UNKNOWN.." "..TRP2_LOC_DIT..TRP2_CTS(string.gsub(texte,"|r",""),true),"EMOTE");
			end
		end);
	end
	TRP2_DialQuestFrameModelFrameModel.seqtime = 0;
	TRP2_DialQuestFrameModelFrameModel.sequenceTab = animTab;
	TRP2_DialQuestFrameModelFrameModel.sequence = 1;
	
	
	if diag ~= #texteTab then
		TRP2_DialQuestFrameNextButton:SetScript("OnClick",function()
			TRP2_ShowNextDiagDetail(texteTab,diag+1,cible,mode,title);
		end);
		if title then
			TRP2_DialQuestFrameTitleTexte:SetText(TRP2_CTS(tostring(title)));
		else
			TRP2_DialQuestFrameTitleTexte:SetText("");
		end
		TRP2_DialQuestFrameNextButton:Show();
		TRP2_DialQuestFrame:SetHeight(max(TRP2_DialQuestFrameMainTexte:GetHeight() + TRP2_DialQuestFrameNameTexte:GetHeight(),85) + 60);
	else
		local taille = 0;
		TRP2_DialQuestFrameTitleTexte:SetText(TRP2_CTS(tostring(title)));
		TRP2_DialQuestFrameDeclineButton:SetText(CLOSE);
		TRP2_DialQuestFrameDeclineButton:Show();
		TRP2_DialQuestFrameDeclineButton:SetScript("OnClick",function()
			TRP2_DialQuestFrame:Hide();
		end);
		taille = TRP2_DialQuestFrameMainTexte:GetHeight() + 10;
		TRP2_DialQuestFrame:SetHeight(max(taille,85) + 66);
	end
	
	TRP2_DialQuestFrameModelFrameModel.start = 0;
	TRP2_DialQuestFrame:Show();
end

TRP2_ANIMSEQTIME = {
	["64"] = 3000,
	["65"] = 3000,
	["60"] = 3500,
	["0"] = 2000,
}