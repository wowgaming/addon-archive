-------------------------------------------------------------------
--                          Total RP 2
--            A roleplay addon for World of Warcraft
-- Created by Sylvain "Telkostrasz" Cossement (up to version 1.017)
--   Licence : CC BY-NC-SA (http://creativecommons.org/licenses/)
-------------------------------------------------------------------

function TRP2_MakeItemLink(item, perso)
	if string.len(item) > 0 then
		return "|cff00ff00|Htotalrp2:"..perso.."|h["..item.."]|h|r";
	else
		return "~~";
	end
end

function TRP2_Hooking_FrameEvent()
	function TRP2_ChatFrame_OnEvent( self, event, ... )
		-- arg2 = personnage
		-- arg3 = langue
		local texte, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16 = ...;
		local Affiche=1;
		local coloredName = GetColoredName(event, texte, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
		
		-- Traitement du texte reçu :
		
		if ( event == "CHAT_MSG_WHISPER" or event == "CHAT_MSG_BN_WHISPER" ) then
			--BN_WHISPER FIXME
			ChatEdit_SetLastTellTarget(arg2, "WHISPER");
			if ( self.tellTimer and (GetTime() > self.tellTimer) ) then
				PlaySound("TellMessage");
			end
			self.tellTimer = GetTime() + CHAT_TELL_ALERT_TIME;
			--FCF_FlashTab(self);
		end
		
		if event=="CHAT_MSG_SAY" or event=="CHAT_MSG_PARTY" or event=="CHAT_MSG_RAID" or (event=="CHAT_MSG_GUILD" and not TRP2_GetConfigValueFor("GuildNoIC",false)) or event=="CHAT_MSG_YELL"
		or event=="CHAT_MSG_PARTY_LEADER" or event=="CHAT_MSG_RAID_LEADER" or event=="CHAT_MSG_OFFICER" or event=="CHAT_MSG_EMOTE"
		or event=="CHAT_MSG_TEXT_EMOTE" or event=="CHAT_MSG_WHISPER" or event=="CHAT_MSG_WHISPER_INFORM" then
			
			-- Item link detection
			if string.sub(texte,1,1) ~= "[" then
				texte = string.gsub(texte,"%~(.-)%~",function(item)
					return TRP2_MakeItemLink(item, arg2);
				end);
			end
			
			-- Pas d'emote en crier
			if event=="CHAT_MSG_YELL" and TRP2_GetConfigValueFor("NoEmoteInYell",false) then
				texte = string.gsub(texte,"%*.-%*","");
				texte = string.gsub(texte,"%<.-%>","");
				if string.gsub(texte,"%s","") == "" then
					return;
				end
			end
			-- Détection des icones
			if not TRP2_GetConfigValueFor("ChatIconeBalise",true) then
				texte = string.gsub(texte,"%{icone%:.-%:%d-%}","");
			end
			-- Détection des émotes
			if TRP2_GetConfigValueFor("ColorEmoteMode",2) > 1 then
				local couleur = TRP2_ColorToHexa(ChatTypeInfo["EMOTE"].r,ChatTypeInfo["EMOTE"].g,ChatTypeInfo["EMOTE"].b);
				texte = string.gsub(texte,"%<.-%>",couleur.."%1|r");
				texte = string.gsub(texte,"%*.-%*",couleur.."%1|r");
			end
			-- Détection des HRP
			if TRP2_GetConfigValueFor("ColorHRPMode",2) > 1 then
				local couleur = TRP2_ColorToHexa(math.abs(ChatTypeInfo[strsub(event, 10)].r-0.1),math.abs(ChatTypeInfo[strsub(event, 10)].g-0.1),math.abs(ChatTypeInfo[strsub(event, 10)].b-0.1));
				if TRP2_GetConfigValueFor("ColorHRPMode",2) == 2 then
					texte = string.gsub(texte,"%(.-%)",couleur.."%1|r");
				elseif TRP2_GetConfigValueFor("ColorHRPMode",2) == 3 then
					local tab={};
					texte = string.gsub(texte,"%(+.-%)+",function(hrp)
						tab[#tab+1] = hrp;
						return "";
					end);
					if getglobal("ChatFrame"..TRP2_GetConfigValueFor("HRPFrame",1)) then
						local chan;
						if getglobal(strsub(event, 10)) then
							chan = "("..TRP2_LOC_StatutHRP.." - "..getglobal(strsub(event, 10))..")";
						else
							chan = "("..TRP2_LOC_StatutHRP..")";
						end
						for key,value in pairs(tab) do
							TRP2_Afficher("[|Hplayer:"..arg2.."|h"..coloredName.."|h|r]".." "..couleur..chan.." : "..value,TRP2_GetConfigValueFor("HRPFrame",1),true);
						end
					end
					if not TRP2_EmptyToNil(string.gsub(texte,"%s","")) then
						return;
					end
				end
			end
			-- Détection dialogues PNJ
			if TRP2_GetConfigValueFor("DetectPipe",2) > 1 then
				Affiche = TRP2_AnalyserEmote(texte,arg2,self,event,coloredName);
			end
		end
		
		if Affiche ~= 0 and (event=="CHAT_MSG_SAY" or event=="CHAT_MSG_PARTY" or event=="CHAT_MSG_RAID" or (event=="CHAT_MSG_GUILD" and not TRP2_GetConfigValueFor("GuildNoIC",false)) or event=="CHAT_MSG_YELL"
			or event=="CHAT_MSG_PARTY_LEADER" or event=="CHAT_MSG_RAID_LEADER" or event=="CHAT_MSG_WHISPER" or event=="CHAT_MSG_WHISPER_INFORM")  then
			--TRP2_debug(arg3);
			
			local info = ChatTypeInfo[strsub(event, 10)];
			local color,personnage;
			-- Calcul de la couleur du perso + lien de whisp + nom
			if info.colorNameByClass then
				color = string.sub(coloredName,1,10);
			else
				color = "";
			end
			personnage = "";
			-- on prend le titre si il existe
			if TRP2_GetConfigValueFor("UseTitleInChat",true) then
				if TRP2_EmptyToNil(TRP2_GetWithDefaut(TRP2_GetInfo(arg2,"Registre",{}),"Titre")) then -- On ajoute le nom si il existe
					personnage = TRP2_GetWithDefaut(TRP2_GetInfo(arg2,"Registre",{}),"Titre").." ";
				end
			end
			
			-- on prend le prénom si il existe
			personnage = personnage..TRP2_GetWithDefaut(TRP2_GetInfo(arg2,"Registre",{}),"Prenom",arg2);
			if TRP2_GetConfigValueFor("UseNameInChat",true) then
				if TRP2_EmptyToNil(TRP2_GetWithDefaut(TRP2_GetInfo(arg2,"Registre",{}),"Nom")) then -- On ajoute le nom si il existe
					personnage = personnage.." "..TRP2_GetWithDefaut(TRP2_GetInfo(arg2,"Registre",{}),"Nom");
				end
			end

			if TRP2_GetConfigValueFor("UseColorInChat",true) then
			else
						personnage = TRP2_DeleteColorCode(personnage);
					end
			
			personnage = "[|Hplayer:"..arg2.."|h"..color..personnage.."|h|r]"; -- Lien de chat
			if getglobal("CHAT_"..strsub(event, 10).."_GET") then
				personnage = format(getglobal("CHAT_"..strsub(event, 10).."_GET"),personnage);
			end

			if string.find(texte,"^%[.-%]") then -- Ca cause dans un langage perso, car ya une entête
				local languePerso,post = string.match(texte,"^%[(.-)%](.*)");
				if arg2 == TRP2_Joueur or event=="CHAT_MSG_WHISPER_INFORM" then -- Si c'est toi qui a causé.
					if TRP2_EmptyToNil(TRP2_DernierePhrasePerso) then
						if TRP2_GetConfigValueFor("ColorHRPMode",2) > 1 then -- Détection des HRP
							local couleur = TRP2_ColorToHexa(math.abs(ChatTypeInfo[strsub(event, 10)].r-0.2),math.abs(ChatTypeInfo[strsub(event, 10)].g-0.2),math.abs(ChatTypeInfo[strsub(event, 10)].b-0.2));
							if TRP2_GetConfigValueFor("ColorHRPMode",2) == 2 then
								TRP2_DernierePhrasePerso = string.gsub(TRP2_DernierePhrasePerso,"%(.-%)",couleur.."%1|r");
							elseif TRP2_GetConfigValueFor("ColorHRPMode",2) == 3 then
								local tab={};
								TRP2_DernierePhrasePerso = string.gsub(TRP2_DernierePhrasePerso,"%(.-%)",function(hrp)
									tab[#tab+1] = hrp;
									return "";
								end);
								if getglobal("ChatFrame"..TRP2_GetConfigValueFor("HRPFrame",1)) then
									for key,value in pairs(tab) do
										TRP2_Afficher(arg2.." "..TRP2_LOC_StatutHRP.."{888888} : "..value,TRP2_GetConfigValueFor("HRPFrame",1));
									end
								end
							end
						end
						personnage = personnage..TRP2_DernierePhrasePerso;
					else
						personnage = personnage.."{o}["..languePerso.."]{col}"..post;
					end
				else
					if event~="CHAT_MSG_WHISPER_INFORM" then
						-- Requete de traduction
						TRP2_debug(arg2);
						TRP2_debug(event);
						TRP2_OpenTranslateRequest(arg2,languePerso,self:GetName(),strsub(event, 10),color);
					end
					personnage = personnage.."{o}["..languePerso.."]{col}"..post;
				end
				self:AddMessage(TRP2_CTS(personnage),info.r,info.g,info.b,info.id);
				Affiche = 0;
			else
				if arg3 ~= "" and not TRP2_OriginelLang[arg3] then
					personnage = personnage.."{o}["..arg3.."]{col} "..texte;
				else
					personnage = personnage..texte;
				end
				self:AddMessage(TRP2_CTS(personnage),info.r,info.g,info.b,info.id);
				Affiche = 0;
				if event~="CHAT_MSG_WHISPER_INFORM" and arg2 ~= TRP2_Joueur and not (string.find(TRP2_DIALBASETAB[TRP2_enRace],arg3) or TRP2_GetInfo(TRP2_Joueur,"Langues",{})[arg3]["bMother"]) then
					TRP2_OpenTranslateRequest(arg2,arg3,self:GetName(),strsub(event, 10),color);
				end
			end
		end
		
		if (Affiche == 1) then
			TRP2_Saved_ChatFrameEvent( self, event, TRP2_CTS(texte), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16 );
		end
		
		if (event=="CHAT_MSG_SAY" or event=="CHAT_MSG_TEXT_EMOTE" or event=="CHAT_MSG_EMOTE" or event=="CHAT_MSG_YELL") and TRP2_QUESTFUNC ~= nil then
			TRP2_QUESTFUNC();
			TRP2_QUESTFUNC = nil;
		end
	end
	TRP2_Saved_ChatFrameEvent = ChatFrame_OnEvent;
	ChatFrame_OnEvent = TRP2_ChatFrame_OnEvent;
end

TRP2_Saved_ChatEdit_ParseText = nil;

function TRP2_Hooking_DoEmote()
	function TRP2_DoEmote(emote, target)
		TRP2_debug(emote);
		if emote == "LOOK" then
			TRP2_QUESTFUNC = function()
				TRP2_PerformAction("Observer");
			end
		elseif emote == "SEARCH" then
			TRP2_QUESTFUNC = function()
				TRP2_PerformAction("Fouiller");
			end
		elseif emote == "LISTEN" then
			TRP2_QUESTFUNC = function()
				TRP2_PerformAction("Ecouter");
			end
		else
			TRP2_QUESTFUNC = function()
				TRP2_PerformAction("Dire",emote);
			end
		end
		TRP2_Saved_DoEmote(emote, target);
	end
	TRP2_Saved_DoEmote = DoEmote;
	DoEmote = TRP2_DoEmote;
end

function TRP2_AnalyserEmote(emote,perso,myChatFrame,event,coloredName)
	local color;
	local personnage;
	local info = ChatTypeInfo[strsub(event, 10)];
	
	-- Calcul de la couleur du perso + lien de whisp + nom
	if info.colorNameByClass then
		color = string.sub(coloredName,1,10);
	else
		color = "";
	end
	
	if string.sub(emote,1,3) == "|| " then
		if string.find(emote,TRP2_LOC_DIT) then
			local Nom = string.sub(emote,4,string.find(emote,TRP2_LOC_DIT)-2);
			Nom = "|Hplayer:"..perso.."|h"..Nom.."|h";
			local phrase = string.sub(emote,string.find(emote,TRP2_LOC_DIT)+string.len(TRP2_LOC_DIT));
			myChatFrame:AddMessage(TRP2_CTS("{o}"..Nom.."|r "..TRP2_LOC_DIT..phrase),ChatTypeInfo["MONSTER_SAY"].r,ChatTypeInfo["MONSTER_SAY"].g,ChatTypeInfo["MONSTER_SAY"].b,ChatTypeInfo["MONSTER_SAY"].id);
		elseif string.find(emote,TRP2_LOC_CRIE) then
			local Nom = string.sub(emote,4,string.find(emote,TRP2_LOC_CRIE)-2);
			Nom = "|Hplayer:"..perso.."|h"..Nom.."|h";
			local phrase = string.sub(emote,string.find(emote,TRP2_LOC_CRIE)+string.len(TRP2_LOC_CRIE));
			myChatFrame:AddMessage(TRP2_CTS("{o}"..Nom.."|r "..TRP2_LOC_CRIE..phrase),ChatTypeInfo["MONSTER_YELL"].r,ChatTypeInfo["MONSTER_YELL"].g,ChatTypeInfo["MONSTER_YELL"].b,ChatTypeInfo["MONSTER_YELL"].id);
		elseif string.find(emote,TRP2_LOC_WHISPER) then
			local Nom = string.sub(emote,4,string.find(emote,TRP2_LOC_WHISPER)-2);
			Nom = "|Hplayer:"..perso.."|h"..Nom.."|h";
			local phrase = string.sub(emote,string.find(emote,TRP2_LOC_WHISPER)+string.len(TRP2_LOC_WHISPER));
			myChatFrame:AddMessage(TRP2_CTS("{o}"..Nom.."|r "..TRP2_LOC_WHISPER..phrase),ChatTypeInfo["MONSTER_WHISPER"].r,ChatTypeInfo["MONSTER_WHISPER"].g,ChatTypeInfo["MONSTER_WHISPER"].b,ChatTypeInfo["MONSTER_WHISPER"].id);
		else
			myChatFrame:AddMessage(TRP2_CTS("|Hplayer:"..perso.."|h"..string.sub(emote,4).."|h"),ChatTypeInfo["MONSTER_EMOTE"].r,ChatTypeInfo["MONSTER_EMOTE"].g,ChatTypeInfo["MONSTER_EMOTE"].b,ChatTypeInfo["MONSTER_EMOTE"].id);
		end
		return 0;
	elseif event == "CHAT_MSG_TEXT_EMOTE" then
		personnage="";
		-- on prend le titre si il existe
			if TRP2_GetConfigValueFor("UseTitleInChat",true) then
				if TRP2_EmptyToNil(TRP2_GetWithDefaut(TRP2_GetInfo(perso,"Registre",{}),"Titre")) then -- On ajoute le titre si il existe
					personnage = TRP2_GetWithDefaut(TRP2_GetInfo(perso,"Registre",{}),"Titre").." ";
				end
			end
		-- on prend le prénom si il existe
		personnage = personnage..TRP2_GetWithDefaut(TRP2_GetInfo(perso,"Registre",{}),"Prenom",perso);
		if TRP2_GetConfigValueFor("UseNameInChat",true) then
			if TRP2_EmptyToNil(TRP2_GetWithDefaut(TRP2_GetInfo(perso,"Registre",{}),"Nom")) then -- On ajoute le nom si il existe
				personnage = personnage.." "..TRP2_GetWithDefaut(TRP2_GetInfo(perso,"Registre",{}),"Nom");
			end
		end
		personnage = "|Hplayer:"..perso.."|h"..color..personnage.."|h"; -- Lien de chat
		if perso == TRP2_Joueur then
			myChatFrame:AddMessage(TRP2_CTS(emote),info.r,info.g,info.b,info.id);
		else
			myChatFrame:AddMessage(TRP2_CTS(personnage.."|r "..string.sub(emote,string.len(perso)+2)),info.r,info.g,info.b,info.id);
		end
		return 0;
	elseif event == "CHAT_MSG_EMOTE" then
		personnage="";
		-- on prend le titre si il existe
			if TRP2_GetConfigValueFor("UseTitleInChat",true) then
				if TRP2_EmptyToNil(TRP2_GetWithDefaut(TRP2_GetInfo(perso,"Registre",{}),"Titre")) then -- On ajoute le titre si il existe
					personnage = TRP2_GetWithDefaut(TRP2_GetInfo(perso,"Registre",{}),"Titre").." ";
				end
			end
		-- on prend le prénom si il existe
		personnage = personnage..TRP2_GetWithDefaut(TRP2_GetInfo(perso,"Registre",{}),"Prenom",perso);
		if TRP2_GetConfigValueFor("UseNameInChat",true) then
			if TRP2_EmptyToNil(TRP2_GetWithDefaut(TRP2_GetInfo(perso,"Registre",{}),"Nom")) then -- On ajoute le nom si il existe
				personnage = personnage.." "..TRP2_GetWithDefaut(TRP2_GetInfo(perso,"Registre",{}),"Nom");
			end
		end
		personnage = "|Hplayer:"..perso.."|h"..color..personnage.."|h"; -- Lien de chat
		myChatFrame:AddMessage(TRP2_CTS(personnage.."|r "..emote),info.r,info.g,info.b,info.id);
		return 0;
	end
	return 1;
end

SLASH_TOTALRP21 = '/trp2';
function SlashCmdList.TOTALRP2(msg, editbox)
	local command = string.match(msg,"^%w+");
	local parametre1;
	
	if TRP2_EmptyToNil(command) then
		command = string.lower(command);
		parametre1 = string.sub(msg,strlen(command)+2);
	end
	
	--TRP2_debug("Commande : "..tostring(command)..", Arg : "..tostring(parametre1));
	
	if not command then
		TRP2_Afficher("{v}"..TRP2_LOC_TRPCommands.." :");
		TRP2_Afficher("{o}--------------------------------------------",nil,true);
		TRP2_Afficher(TRP2_LOC_TRPCommands1,nil,true);
		TRP2_Afficher("{o}--------------------------------------------",nil,true);
		TRP2_Afficher("{j}/trp2 {o}"..TRP2_LOC_TRPCommandsShow.." : {c}"..TRP2_LOC_TRPCommandsShowTT,nil,true);
		TRP2_Afficher("{j}/trp2 {o}"..TRP2_LOC_TRPCommandsShowRacc.." : {c}"..TRP2_LOC_TRPCommandsShowRaccTT,nil,true);
		TRP2_Afficher("{j}/trp2 {o}"..TRP2_LOC_TRPCommandsShowCreaList.." : {c}"..TRP2_LOC_TRPCommandsShowCreaListTT,nil,true);
		if TRP2_Guide_OpenPage then
			TRP2_Afficher("{j}/trp2 {o}"..TRP2_LOC_TRPCommandsGuidebook.." : {c}"..TRP2_LOC_TRPCommandsGuide,nil,true);
		end
		TRP2_Afficher("{j}/trp2 {o}"..TRP2_LOC_TRPCommandsRPStat.." : {c}"..TRP2_LOC_TRPCommandsRP,nil,true);
		TRP2_Afficher("{j}/trp2 {o}Rand {j}#Type {o}"..TRP2_LOC_TRPCommandsOR.." {j}? : {c}"..TRP2_LOC_TRPCommandsDice,nil,true);
		TRP2_Afficher("{o}--------------------------------------------",nil,true);
	elseif command == string.lower(TRP2_LOC_TRPCommandsShowCreaList) then -- Open crealist
		if not TRP2_CreationFrame:IsVisible() then
			TRP2_CreationPanel();
		end
	elseif command == string.lower(TRP2_LOC_TRPCommandsShowRacc) then -- Open raccbar
		if TRP2_RaccBar:IsVisible() then
			TRP2_RaccBar:Hide();
		else
			TRP2_RaccBar:Show();
		end
	elseif command == string.lower(TRP2_LOC_TRPCommandsShow) then -- Open frame
		TRP2_OpenMainMenu(not TRP2MainFrame:IsVisible());
	elseif command == string.lower(TRP2_LOC_TRPCommandsRPStat) then -- Switch status RP
		TRP2_SwitchStatutRP();
	elseif command == string.lower(TRP2_LOC_TRPCommandsGuidebook) then -- Open guide book
		if TRP2_Guide_OpenPage then
			if TRP2_GuideFrame:IsVisible() then
				TRP2_GuideFrame:Hide();
			else
				TRP2_Guide_OpenPage("Index",nil,true);
			end
		else
			TRP2_Error(TRP2_LOC_TRPCommandsGuideError1);
		end
	elseif command == "rand" then -- Do a rand
		TRP2_DoARand(parametre1);
	end
	
end