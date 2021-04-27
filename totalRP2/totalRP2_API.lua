-------------------------------------------------------------------
--                          Total RP 2
--            A roleplay addon for World of Warcraft
-- Created by Sylvain "Telkostrasz" Cossement (up to version 1.017)
--   Licence : CC BY-NC-SA (http://creativecommons.org/licenses/)
-------------------------------------------------------------------

function TRP2_ReinitAll()
	TRP2_Module_Configuration = nil;
	TRP2_Module_Registre = nil;
	TRP2_Module_PlayerInfo_Relations = nil;
	TRP2_Module_Inventaire = nil;
	TRP2_Module_ObjetsPerso = nil;
	TRP2_Module_PlayerInfo = nil;
	TRP2_Module_Documents = nil;
	TRP2_Module_Npcs = nil;
	TRP2_Module_Auras = nil;
	ReloadUI();
end

----------------------------------------------------------------------------
-- Message et traitement de textes
----------------------------------------------------------------------------

-- Contient tout ce qui doit être vérifié toute les secondes.
function TRP2_RefreshEverySeconds()
	TRP2_RefreshInventaireTimed();
	TRP2_RefreshAura();
	TRP2_RefreshHudButton();
	TRP2_UpdateRealiste();
end


-- Added by Ellypse, thanks to Zax
-- Return the string without color code. (displaying names in emotes)
function TRP2_DeleteColorCode(chaine)
 if (chaine == nil) then
 return "";
 else
 return string.gsub(chaine, "{%w*}", "");
 end;
end


-- Added by Ellypse. Return the int corresponding to value. 
-- Used for the corruption with sliders
function TRP2_GetInt(value)
	return math.floor(tonumber(value));
end

function TRP2_GetWithDefaut(tab,value,defaut)
	if tab and tab[value] ~= nil then
		return tab[value];
	end
	return defaut;
end

function TRP2_EmptyToNil(text)
	if not text or text == "" then
		return nil;
	end
	return text;
end

function TRP2_NilToEmpty(text)
	if not text then
		text = "";
	end
	return text;
end

function TRP2_FT(message,remp1,remp2,remp3,remp4,remp5,remp6,remp7,remp8)
	if not message then return ""; end
	message = string.gsub(message,"%%1",tostring(remp1));
	message = string.gsub(message,"%%2",tostring(remp2));
	message = string.gsub(message,"%%3",tostring(remp3));
	message = string.gsub(message,"%%4",tostring(remp4));
	message = string.gsub(message,"%%5",tostring(remp5));
	message = string.gsub(message,"%%6",tostring(remp6));
	message = string.gsub(message,"%%7",tostring(remp7));
	message = string.gsub(message,"%%8",tostring(remp8));
	return message;
end

function TRP2_SuperFetchInformations(tab)
	if tab then
		local message = "";
		for index,value in pairs(tab) do
			message = message..value;
		end
		return message;
	end
	return nil;
end

function TRP2_fetchInformations(message)
	return TRP2_FetchToTabWithSeparator(message,TRP2_ReservedChar);
end

function TRP2_FetchToTabWithSeparator(message,separator)
	return {strsplit(separator, message)}; -- C'est quand même mieux d'utiliser les fonctions de Blizouille.
end

function TRP2_debug(mes,noTag)
	if TRP2_GetConfigValueFor("DebugMode",false) then
		mes = tostring(mes);
		if noTag then
			mes = "[DEBUG] "..mes;
		else
			mes = TRP2_CTS("{c}[DEBUG] {o}"..mes);
		end
		_G["ChatFrame"..TRP2_GetConfigValueFor("DebugMessageFrame",1)]:AddMessage(mes,1,1,1);
	end
end

function TRP2_Error(message)
	UIErrorsFrame:AddMessage(message, 1.0, 0.0, 0.0, 53, 5);
end

function TRP2_Afficher(mess,frame,backPrefix,iType)
	if not mess then mess = "nil" end
	local prefix = "[{o}TRP2{w}] ";
	if backPrefix then prefix = "" end
	if not iType or tonumber(iType) == 1 then
		if not frame or not string.find(frame,"[1-7]") then
			frame = TRP2_GetConfigValueFor("InvMessageFrame",1);
		end
		_G["ChatFrame"..frame]:AddMessage(TRP2_CTS("{w}"..prefix..mess),1,1,1);
	elseif tonumber(iType) == 2 then
		StaticPopupDialogs["TRP2_JUST_TEXT"].text = TRP2_CTS(TRP2_ENTETE..mess);
		TRP2_ShowStaticPopup("TRP2_JUST_TEXT");
	elseif tonumber(iType) == 3 then
		RaidNotice_AddMessage(RaidWarningFrame, TRP2_CTS("{w}"..mess), ChatTypeInfo["RAID_WARNING"]);
	end
end

function TRP2_OctetstoString(octets)
	if octets < 1024 then
		return octets.." octets";
	elseif octets < 1048576 then
		return string.sub(octets/1024,1,5).." ko";
	else
		return string.sub(octets/1048576,1,5).." mo";
	end
end

function TRP2_ConvertToHTML(texte)
	local tab = {};
	local i=1;
	
	texte = string.gsub(texte,"&","&amp;");
	texte = string.gsub(texte,"<","&lt;");
	texte = string.gsub(texte,">","&gt;");
	texte = string.gsub(texte,"\"","&quot;");
	
	texte = string.gsub(texte,"{titre1}","<h1>");
	texte = string.gsub(texte,"{titre1:centre}","<h1 align=\"center\">");
	texte = string.gsub(texte,"{titre1:droite}","<h1 align=\"right\">");
	texte = string.gsub(texte,"{/titre1}","</h1>");
	texte = string.gsub(texte,"{titre2}","<h2>");
	texte = string.gsub(texte,"{titre2:centre}","<h2 align=\"center\">");
	texte = string.gsub(texte,"{titre2:droite}","<h2 align=\"right\">");
	texte = string.gsub(texte,"{/titre2}","</h2>");
	texte = string.gsub(texte,"{titre3}","<h3>");
	texte = string.gsub(texte,"{titre3:centre}","<h3 align=\"center\">");
	texte = string.gsub(texte,"{titre3:droite}","<h3 align=\"right\">");
	texte = string.gsub(texte,"{/titre3}","</h3>");
	texte = string.gsub(texte,"{centre}","<P align=\"center\">");
	texte = string.gsub(texte,"{/centre}","</P>");
	texte = string.gsub(texte,"{droite}","<P align=\"right\">");
	texte = string.gsub(texte,"{/droite}","</P>");
	
	while string.find(texte,"<") and i<50 do
		--TRP2_debug("texte traité : "..texte)
		local avant,tag,apres;
		avant = string.sub(texte,1,string.find(texte,"<")-1);
		local taille = 0;
		if string.match(texte,"</(.-)>") then
			taille = string.len(string.match(texte,"</(.-)>"));
		end
		--TRP2_debug("taille : "..tostring(taille));
		if string.find(texte,"</") then
			tag = string.sub(texte,string.find(texte,"<"),string.find(texte,"</")+taille+2);
		else
			return TRP2_LOC_ErreurGen_2;
		end
		apres = string.sub(texte,string.len(avant)+string.len(tag)+1);

		tab[#tab+1] = avant;
		tab[#tab+1] = tag;
		texte = apres;
		
		i = i+1;
	end
	tab[#tab+1] = texte;
	texte = "";
	table.foreach(tab,function(i)
		if not string.find(tab[i],"<") then
			tab[i] = "<P>"..tab[i].."</P>";
		end
		tab[i] = string.gsub(tab[i],"\n","<br/>");
		
		tab[i] = string.gsub(tab[i],"{img%:(.-)%:(.-)%:(.-)%:(.-)}",function(arg1,arg2,arg3,arg4)
			return "</P><img src=\""..arg1.."\" align=\""..arg2.."\" width=\""..arg3.."\" height=\""..arg4.."\"/><P>";
		end);
		
		tab[i] = string.gsub(tab[i],"{link:(.-):(.-)}","<a href=\"%1\">|cff00ff00["..TRP2_LOC_Link.." : %2]|r</a>");
		
		--TRP2_debug(i.." : "..tab[i]);
		texte = texte..tab[i];
	end)
	texte = "<HTML><BODY>"..texte.."</BODY></HTML>";
	
	return TRP2_CTS(texte);
end

function TRP2_EraseTags(text)
	return string.gsub(text,"{.-}","");
end

function TRP2_CTS(text,bNocolor)
	if not text then return "" end;
	if bNocolor then
		text = string.gsub(text,"{[rvbjpcwno]}","");
		text = string.gsub(text,"{%x%x%x%x%x%x}","");
		text = string.gsub(text,"{li}","");
		text = string.gsub(text,"{col}","");
	end
	
	text = string.gsub(text,"%{randtext%:(.-)%}",function(rand)
		local randtab = TRP2_FetchToTabWithSeparator(rand,"%+");
		return randtab[random(#randtab)];
	end);
	text = TRP2_CheckForLanguage(text);
	text = TRP2_ITS(text);
	text = string.gsub(text,"%{([^{]-)%}",TRP2_CTS_Traiter);
	
	local i=0;
	while string.find(text,"{%[.-%].-%-%-.-}") and i<10 do
		local x = string.find(string.reverse(text),"%{");
		local n = string.len(text);
		local start = - x + n + 1;
		local final = string.find(text,"}",start);
		-- Start et final : on sait qu'il n'y a pas de balise de test dedans.
		if not final or final <= start or not string.find(text,"%[",start) or not string.find(text,"%]",start) then
			-- C'est qu'il a merdé sa balise : on sort et on l'affiche telle quel!
			break;
		end
		local monTexte = string.sub(text,start,final);
		local options = string.match(monTexte,"%[(.-)%]");
		local oui,non = string.match(monTexte,"{%[.-%](.-)%-%-(.-)}");
		options = string.gsub(options,"%+eq%+","$==$");
		options = string.gsub(options,"%+ne%+","$~=$");
		options = string.gsub(options,"%+gt%+","$>$");
		options = string.gsub(options,"%+lt%+","$<$");
		options = string.gsub(options,"%+ge%+","$>=$");
		options = string.gsub(options,"%+le%+","$<=$");
		local resultat = TRP2_CheckConditions(options,nil,true);
		
		if type(resultat) == "string" then
			text = string.sub(text,1,start-1)..resultat..string.sub(text,final+1);
		elseif resultat == true then
			text = string.sub(text,1,start-1)..oui..string.sub(text,final+1);
		else
			text = string.sub(text,1,start-1)..non..string.sub(text,final+1);
		end
		i = i + 1;
	end
	
	return text;
end

-- Echappement pour les effets
-- Donc :  $ et ;
function TRP2_STC(text)
	text = string.gsub(text,"[%$]","{do}");
	text = string.gsub(text,"[%;]","{pv}");
	return text;
end

function TRP2_STCinverse(text)
	text = string.gsub(text,"{pv}",";");
	text = string.gsub(text,"{do}","$");
	return text;
end

TRP2_CTS_DIRECTINSERT = {
	["r"] = "|cffff0000";
	["v"] = "|cff00ff00";
	["b"] = "|cff0000ff";
	["j"] = "|cffffff00";
	["p"] = "|cffff00ff";
	["c"] = "|cff00ffff";
	["w"] = "|cffffffff";
	["n"] = "|cff000000";
	["o"] = "|cffffaa00";
	["li"] = "\n";
	["pv"] = ";";
	["sh"] = "#";
	["do"] = "$";
	["ao"] = "{";
	["af"] = "}";
	["pi"] = "||";
	["col"] = "|r";
}

function TRP2_CTS_Traiter(balise)
	if TRP2_CTS_DIRECTINSERT[balise] then
		return TRP2_FT(TRP2_CTS_DIRECTINSERT[balise],balise);
	elseif string.find(balise,"%x%x%x%x%x%x") then
		return "|cff"..balise;
	elseif string.find(balise,"icone%:[%w%s%_%-%d]+%:%d+") then
		return "|TInterface\\ICONS\\"..tostring(string.match(balise,"icone%:([%w%s%_%-%d]+)%:%d+"))..":"
			..tostring(string.match(balise,"icone%:[%w%s%_%-%d]+%:(%d+)"))..":"
			..tostring(string.match(balise,"icone%:[%w%s%_%-%d]+%:(%d+)")).."|t";
	elseif balise == "de" then
		return "|2";
	end
	
	return "{"..balise.."}";
end

function TRP2_ITS(text)
	text = string.gsub(text,"%{([^{]-)%}",function(balise)
		if balise == "rotation" then
			return TRP2_GetFacing();
		elseif balise == "class" then
			return TRP2_locClass;
		elseif balise == "race" then
			return TRP2_locRace;
		elseif balise == "me" then
			return TRP2_GetPlayerPrenom();
		elseif balise == "pro" or balise == "proc" then
			if UnitSex("player") == 2 then
				return "his";
			else
				return "her";
			end
		elseif balise == "prod" then
			if UnitSex("player") == 2 then
				return "him";
			else
				return "her";
			end
		elseif balise == "ta" then
			return TRP2_GetTargetTRPName();
		elseif balise == "nom" then
			return TRP2_nomComplet(TRP2_Joueur,true);
		elseif balise == "nomt" then
			return TRP2_nomComplet(TRP2_Joueur);
		elseif balise == "cnom" then
			if UnitName("target") then
				return TRP2_nomComplet(UnitName("target"),true);
			else
				return "";
			end
		elseif balise == "cnomt" then
			if UnitName("target") then
				return TRP2_nomComplet(UnitName("target"));
			else
				return "";
			end
		elseif balise == "souszone" then
			return tostring(GetSubZoneText());
		elseif balise == "zone" then
			return tostring(GetZoneText());
		elseif string.match(balise,"rand%d+") == balise then
			local maxi = TRP2_NilToDefaut(tonumber(string.match(balise,"rand(%d+)")),1);
			return math.random(1,maxi);
		elseif balise == "coord" then
			local Coord = TRP2_GetPlanqueID(false);
			if Coord then return Coord else return "0" end
		else
			return "{"..balise.."}";
		end
	end);
	
	return text;
end

function TRP2_GetTargetTRPName()
	if not UnitName("target") then
		return UNKNOWN;
	else
		local nomPet, maitre = TRP2_RecupTTInfo();
		if nomPet and maitre then
			local petTab = TRP2_GetInfo(maitre,"Pets",{});
			if petTab[nomPet] and petTab[nomPet]["Nom"] then
				return petTab[nomPet]["Nom"];
			end
		elseif UnitIsPlayer("target") then
			return TRP2_GetWithDefaut(TRP2_GetInfo(UnitName("target"),"Registre",{}),"Prenom",UnitName("target"));
		end
		return UnitName("target");
	end
end

function TRP2_GetFacing()
	local rotation = GetPlayerFacing();
	-- 1.57 = 90°
	-- 0.785 = 45°
	-- 0.3925 = 22.5°
	if rotation < 0.3925 then
		return TRP2_LOC_Nord
	elseif rotation < 1.1775 then
		return TRP2_LOC_NordOuest
	elseif rotation < 1.9625 then
		return TRP2_LOC_Ouest
	elseif rotation < 2.7475 then
		return TRP2_LOC_SudOuest
	elseif rotation < 3.5325 then
		return TRP2_LOC_Sud
	elseif rotation < 4.3175 then
		return TRP2_LOC_SudEst
	elseif rotation < 5.1025 then
		return TRP2_LOC_Est
	elseif rotation < 5.8875 then
		return TRP2_LOC_NordEst
	else
		return TRP2_LOC_Nord
	end
end

function TRP2_DefautToNil(test,defaut)
	if test == defaut then
		test = nil;
	end
	return test;
end

function TRP2_NilToDefaut(test,defaut)
	if test == nil then
		return defaut;
	end
	return test;
end

function TRP2_BooleanToNumber(valeur)
	if valeur ~= nil then
		if valeur == true then 
			return 1;
		elseif valeur == false then
			return 0;
		end
	end
end

----------------------------------------------------------------------------
-- Autres
----------------------------------------------------------------------------

function TRP2_PlayScripts(scripts, creationID, ...)
	local arg1, arg2, arg3, arg4, arg5, arg6 = ...;
	if TRP2_EmptyToNil(scripts) and TRP2_EmptyToNil(creationID) then
		local creaTab = TRP2_GetTabInfo(creationID);
		if string.len(creationID) == 8 or TRP2_IsMine(TRP2_GetWithDefaut(creaTab,"Createur","")) or TRP2_GetAccess(TRP2_GetWithDefaut(creaTab,"Createur","")) >= TRP2_GetConfigValueFor("MinimumForScript",4) then
			-- Creating function creator
			local ok, func, realFunc, errorMess;
			scripts = "return function(arg1, arg2, arg3, arg4, arg5, arg6, arg7) "..scripts.." end";
			func, errorMess = loadstring(scripts);
			if not func then
				StaticPopupDialogs["TRP2_JUST_TEXT"].text = TRP2_CTS(TRP2_ENTETE..TRP2_FT("{r}Script syntax error for ID {v}"..creationID..":{w}\n\n"..errorMess));
				TRP2_ShowStaticPopup("TRP2_JUST_TEXT");
				return;
			end
			-- Creating function
			ok, realFunc = pcall(func);
			if not ok then
				assert(ok,"Script function creation error "..creationID.." :\n"..realFunc);
			end
			-- Calling function
			ok, errorMess = pcall(realFunc,creationID,arg1, arg2, arg3, arg4, arg5, arg6);
			if not ok then
				StaticPopupDialogs["TRP2_JUST_TEXT"].text = TRP2_CTS(TRP2_ENTETE..TRP2_FT("{r}Script execution error for ID {v}"..creationID..":{w}\n\n"..errorMess));
				TRP2_ShowStaticPopup("TRP2_JUST_TEXT");
				return;
			end
		else
			TRP2_debug("Blocked scripts.");
		end
	end
end

function TRP2_ConstructFNC(condiTAB)
	local FNCTab = {};
	local premier=true;
	local clauseNum=1;
	table.foreach(condiTAB,function(condition)
		if condiTAB[condition] ~= "" then
			if premier then --De toute manière le premier on le met dans la clause 1
				FNCTab[1] = {};
				FNCTab[1][1] = condition;
				premier = false;
			else
				if string.sub(condiTAB[condition],1,1) == "-" then
					FNCTab[clauseNum][#FNCTab[clauseNum]+1] = condition;
				else
					clauseNum = clauseNum + 1;
					FNCTab[clauseNum] = {};
					FNCTab[clauseNum][1] = condition;
				end
			end
		end
	end);
	
	local formule="";
	local clausesNum = 0;
	local clauses = "{o}"..TRP2_LOC_CONDITIONS.." :\n";
	local debut=true;
	table.foreach(FNCTab,function(clause)
		if not debut then
			formule = formule.."^";
		else
			debut=false;
		end
		formule = formule.."(";
		
		local cDebut=true;
		table.foreach(FNCTab[clause],function(condition)
			clausesNum = clausesNum + 1;
			if not cDebut then
				formule = formule.."v";
			else
				cDebut=false;
			end
			clauses = clauses.."{j}"..clausesNum..") "..TRP2_GetConditionString(condiTAB[FNCTab[clause][condition]]).."\n";
			formule = formule..FNCTab[clause][condition];
			--TRP2_debug(FNCTab[clause][condition].." : "..condiTAB[FNCTab[clause][condition]]);
		end);
		formule = formule..")";
	end);
	formule = clauses.."\n{o}"..TRP2_LOC_FNC.." :{w}\n"..formule.."\n\n";
	return FNCTab, formule;
end

function TRP2_PlayEffect(effects,enteteTexte,arg1,arg2,arg3,createur)
	if not TRP2_EmptyToNil(effects) then return true; end
	
	local effectsTab = TRP2_FetchToTabWithSeparator(effects,";");
	for num,value in pairs(effectsTab) do
		if TRP2_EmptyToNil(effectsTab[num]) then
			local effetScript = effectsTab[num];
			--TRP2_debug(effetScript);
			if string.match(effetScript,"%w+") then
				local prefixe = string.lower(string.match(effetScript,"(%w+)%$*.*"));
				local args = TRP2_FetchToTabWithSeparator(string.match(effetScript,"%w+%$*(.*)"),"$");
				if TRP2_EmptyToNil(prefixe) and TRP2_FunctionReplaceTAB[prefixe] then
					if prefixe == "parole" and ( TRP2_GetConfigValueFor("NoSpeackingEffect",false) or 
						TRP2_GetWithDefaut(TRP2_GetInfo(TRP2_Joueur,"Actu",{}),"StatutRP",2) == 1 or
						TRP2_GetAccess(createur) < TRP2_GetConfigValueFor("MinimumForDialog",3)) then -- Conversion de la parole en texte
						local texte = args[1];
						if string.sub(texte,1,3) == "|| " then
							if string.find(texte,TRP2_LOC_DIT) then
								local Nom = string.sub(texte,4,string.find(texte,TRP2_LOC_DIT)-2);
								local phrase = string.sub(texte,string.find(texte,TRP2_LOC_DIT)+string.len(TRP2_LOC_DIT));
								texte = "{o}"..Nom.."|r "..TRP2_LOC_DIT..phrase;
							elseif string.find(texte,TRP2_LOC_CRIE) then
								local Nom = string.sub(texte,4,string.find(texte,TRP2_LOC_CRIE)-2);
								local phrase = string.sub(texte,string.find(texte,TRP2_LOC_CRIE)+string.len(TRP2_LOC_CRIE));
								texte = "{o}"..Nom.."|r "..TRP2_LOC_CRIE..phrase;
							elseif string.find(texte,TRP2_LOC_WHISPER) then
								local Nom = string.sub(texte,4,string.find(texte,TRP2_LOC_WHISPER)-2);
								local phrase = string.sub(texte,string.find(texte,TRP2_LOC_WHISPER)+string.len(TRP2_LOC_WHISPER));
								texte = "{o}"..Nom.."|r "..TRP2_LOC_WHISPER..phrase;
							else
								texte = string.sub(texte,4);
							end
						else
							local personnage = TRP2_GetWithDefaut(TRP2_GetInfo(TRP2_Joueur,"Registre",{}),"Prenom",TRP2_Joueur);
							if TRP2_GetConfigValueFor("UseNameInChat",true) then
								if TRP2_GetWithDefaut(TRP2_GetInfo(TRP2_Joueur,"Registre",{}),"Nom") then -- On ajoute le nom si il existe
									personnage = personnage.." "..TRP2_GetWithDefaut(TRP2_GetInfo(TRP2_Joueur,"Registre",{}),"Nom");
								end
							end
							if _G["CHAT_"..TRP2_EFFETCHATTAB[tonumber(args[2])].."_GET"] then
								personnage = format(_G["CHAT_"..TRP2_EFFETCHATTAB[tonumber(args[2])].."_GET"],personnage);
							end
							texte = personnage..texte;
						end
						prefixe = "texte";
						args[1] = texte;
						args[2] = "1";
					end
					
					TRP2_FunctionReplaceTAB[prefixe](enteteTexte,
						TRP2_EmptyToNil(args[1]), -- %2
						TRP2_EmptyToNil(args[2]), -- %3
						TRP2_EmptyToNil(args[3]), -- %4
						TRP2_EmptyToNil(args[4]), -- %5
						TRP2_EmptyToNil(args[5]), -- %6
						arg2,arg3); -- %7 et %8

				else
					TRP2_debug("Erreur : prefixe inconnu"); -- Si affichage erreur
				end
			else
				TRP2_debug("Erreur : pattern foireux"); -- Si affichage erreur
			end
		end
	end
	return true;
end

function TRP2_CheckConditions(conditions, errorMessages,returnIfMerde)
	if not TRP2_EmptyToNil(conditions) then return true; end
	conditions = string.gsub(conditions,"\n","\\n");
	local errorTab;
	if errorMessages then
		errorMessages = string.gsub(errorMessages,"\n","");
		errorTab = TRP2_FetchToTabWithSeparator(errorMessages,";");
	end
	local conditionsTab = TRP2_FetchToTabWithSeparator(conditions,";");
	local FNCTab = TRP2_ConstructFNC(conditionsTab);
	local erreurGauche,erreurDroite;
	
	for condition,v in pairs(conditionsTab) do
		if v ~= "" then
			conditionScript = v;
			local code = "";
			if string.match(conditionScript,"%-?.+%$.+%$.+") then
				local membreGauche = string.match(conditionScript,"%-*(.+)%$.+%$.+");
				local membreDroite = string.match(conditionScript,"%-*.+%$.+%$(.+)");
				local comparator = string.match(conditionScript,"%-*.+%$(.+)%$.+");
				membreGauche,erreurGauche = TRP2_CheckTraiterMembre(membreGauche);
				membreDroite,erreurDroite = TRP2_CheckTraiterMembre(membreDroite);
				if not membreGauche or not membreDroite then
					if not membreGauche then
						-- print("erreurGauche : "..tostring(erreurGauche)); -- Si affichage erreur
						if returnIfMerde then return "Erreur de valeur" end
					end
					if not membreDroite then
						-- print("erreurDroite : "..tostring(erreurDroite)); -- Si affichage erreur
						if returnIfMerde then return "Erreur de valeur" end
					end
				else -- Si pas d'erreur
					code = "if %1 %2 %3 then return true; end return false;";
					code = TRP2_FT(code,membreGauche,comparator,membreDroite);
				end
			else
				-- print("raté 1 : pattern foireux"); -- Si affichage erreur
				if returnIfMerde then return "Erreur de pattern : "..conditionScript end
			end
			conditionsTab[condition] = code;
		end
	end
	-- On effectue les test dans l'ordre du FNC
	local retour = true;
	local erreur;
	local erreurMessNum = 0;
	table.foreach(FNCTab,function(clause)
		local valeurClause = false;
		erreurMessNum = erreurMessNum + 1;
		table.foreach(FNCTab[clause],function(condition)
			if TRP2_EmptyToNil(conditionsTab[FNCTab[clause][condition]]) then -- On effectue pas les tests vides. Ils sont neutres
				local singleton = FNCTab[clause][condition];
				local code = conditionsTab[singleton];
				local func = loadstring(code);
				local result = TRP2_PCall(func);
				--TRP2_debug(code);
				--TRP2_debug("Résultat = "..tostring(result));
				if result ~= nil then
					--TRP2_debug(conditionsTab[singleton]);
					--TRP2_debug(result);
					valeurClause = valeurClause or result;
				else
					erreur = true;
				end
			end
		end);
		retour = retour and valeurClause;
		if retour == false then
			return;
		end
	end);
	if erreur then return nil end
	if retour == false and errorTab and errorTab[erreurMessNum] then
		TRP2_Error(errorTab[erreurMessNum]);
	end
	return retour;
end

function TRP2_CheckTraiterMembre(membre)
	-- Soit une valeure directe = entre "" pour textuelle, ou numérique
	-- Soit une valeure à calculer sans argument = Valeur
	-- Soit une valeure à calculer avec argument = Valeur(argument)
	
	--TRP2_debug("membre : "..membre);
	
	if string.match(membre,"\".*\"") == membre  then -- Valeure directe textuelle
		return string.lower(membre);
	elseif string.match(membre,"%d+") == membre then -- Valeure directe numerique
		return membre;
	elseif string.match(membre,".+%(.*%)") then --Valeure à calculer avec cible
		local valeur = string.match(membre,"(.+)%(.*%)");
		local arg = string.match(membre,".+%((.*)%)");
		valeur = string.lower(valeur);
		--arg = string.lower(arg);
		--TRP2_debug(valeur);TRP2_debug(arg);
		if TRP2_FunctionReplaceTAB[valeur] then
			return TRP2_FT(TRP2_FunctionReplaceTAB[valeur],arg);
		else
			return nil,"Erreur à la valeur : "..tostring(valeur)..", Valeur inconnue.";
		end
	elseif string.match(membre,".+") then -- Valeure à calculer
		membre = string.lower(membre);
		if TRP2_FunctionReplaceTAB[membre] then
			return TRP2_FT(TRP2_FunctionReplaceTAB[membre],"\"player\"");
		else
			return nil,"Erreur à la valeur : "..tostring(membre)..", Valeur inconnue.";
		end
	end
	return nil,"Erreur de synthaxe au membre : "..tostring(membre);
end

function TRP2_ApplyPattern(finder,pattern)
	local ok,Error = TRP2_PCall(string.find,string.lower(finder),string.lower(pattern));
	if string.find(tostring(ok),"%d") then
		return true;
	end
	if not Error then
		return false;
	end
	return nil;
end

function TRP2_PCall(func,arg1,arg2,arg3,arg4,arg5,arg6,arg7,bBegin)
	if func then
		local trace = {pcall(func,arg1,arg2,arg3,arg4,arg5,arg6,arg7)};
		if not trace[1] then
			if not bBegin then
				TRP2_debug("Error in TRP2_PCall :\n");
				TRP2_debug(trace[2]);
			else
				print("Erreur :");
				TRP2_Montre(trace);
			end
			return nil,trace[2];
		else
			return trace[2],trace[3],trace[4];
		end
	else
		--TRP2_debug("Error in TRP2_PCall : func null");
	end
end

function TRP2_foundInTableString(tab,found)
	local foundOk = false;
	table.foreach(tab,
		function(option)
			if string.find(tab[option],found) then
				foundOk = true;
			end
	end);
	return foundOk;
end

function TRP2_matchInTableString(tab,found)
	local foundOk = false;
	table.foreach(tab,
		function(option)
			if found == tab[option] then
				foundOk = true;
			end
	end);
	return foundOk;
end

function TRP2_foundInTableString2(tab,found)
	local foundOk = false;
	table.foreach(tab,
		function(option)
			if string.find(found,tab[option]) then
				foundOk = true;
			end
	end);
	return foundOk;
end

function TRP2_isInBgOrArena()
	for i=1,MAX_BATTLEFIELD_QUEUES do
		if GetBattlefieldStatus(i) == "active" or IsActiveBattlefieldArena() ~= nil then
			return true;
		end
	end
	return false;
end

function TRP2_tcopy(to, from)
	if to == nil or from == nil then return end
    for k,v in pairs(from) do
		if(type(v)=="table") then
			to[k] = {};
			TRP2_tcopy(to[k], v);
		else
			to[k] = v;
		end
    end
end

function TRP2_StringNFirst(text, length)
	if string.len(text) > length then
		return string.sub(text,1,length).."...";
	end
	return text;
end

function TRP2_CreateID(OTY)
	return OTY..date("%m%d%H%M%S")..math.random(10000,99999);
end

function TRP2_deciToHexa(number)
	number = math.floor(number*255);
	local num1 = math.fmod(number, 16);
	local num2 = math.floor(number/16);
	if num2 == 10 then
		num2 = "A";
	elseif num2 == 11 then
		num2 = "B";
	elseif num2 == 12 then
		num2 = "C";
	elseif num2 == 13 then
		num2 = "D";
	elseif num2 == 14 then
		num2 = "E";
	elseif num2 == 15 then
		num2 = "F";
	end
	if num1 == 10 then
		num1 = "A";
	elseif num1 == 11 then
		num1 = "B";
	elseif num1 == 12 then
		num1 = "C";
	elseif num1 == 13 then
		num1 = "D";
	elseif num1 == 14 then
		num1 = "E";
	elseif num1 == 15 then
		num1 = "F";
	end
	return ""..num2..num1;
end

function TRP2_ColorToHexa(r,g,b)
	return "|cff"..TRP2_deciToHexa(r)..TRP2_deciToHexa(g)..TRP2_deciToHexa(b);
end

-- SOUNDS
function TRP2_PlaySound(soundFile)
	if GetCVar("Sound_EnableSFX") == "1" and TRP2_GetConfigValueFor("ActivateSound", true) then
		--TRP2_debug("Ok : "..soundFile);
		PlaySoundFile(soundFile);
	end
end

function TRP2_PlayLocalSound(soundFile,Radius)
	SetMapToCurrentZone();
	local zoneNum = TRP2_GetCurrentMapZone();
	if zoneNum ~= -1 then
		local x,y = GetPlayerMapPosition("player");
		x = tonumber(string.sub(tostring(x),1,7));
		y = tonumber(string.sub(tostring(y),1,7));
		TRP2_SendContentToChannel({soundFile,Radius,zoneNum,x,y},"LocalSound");
	end
	TRP2_PlaySound(soundFile);
end

function TRP2_PlaySoundScript(url,mode,porte)
	local urlTab = TRP2_FetchToTabWithSeparator(url,"\n");
	url = urlTab[random(#urlTab)];
	if mode == 1 then
		TRP2_PlaySound(url);
	elseif mode == 2 then
		TRP2_PlayLocalSound(url,porte);
	elseif mode == 3 then
		TRP2_SecureSendAddonMessageGroup("PLLS",url);
		TRP2_PlaySound(url);
	end
end

function TRP2_PlayGroupSound(url,sender)
	if not TRP2_EstDansLeReg(sender) or TRP2_GetInfo(sender,"bMute",false) or TRP2_GetAccess(sender) < TRP2_GetConfigValueFor("MinimumForSound", 3) then
		return;
	end
	if TRP2_GetConfigValueFor("bSoundLog",false) then
		TRP2_Afficher(TRP2_FT(TRP2_LOC_SoudPlayeedBy,sender,url),TRP2_GetConfigValueFor("SoundLogFrame",1));
	end
	TRP2_PlaySound(url);
end

function TRP2_CalculateLocalSound(sender,son,radius,zone,x,y)
	if not TRP2_EstDansLeReg(sender) or TRP2_GetInfo(sender,"bMute",false) or TRP2_GetAccess(sender) < TRP2_GetConfigValueFor("MinimumForSound", 3) then
		return;
	elseif not TRP2_GetConfigValueFor("bDontUseCoord",false) and not TRP2_GetWorldMap():IsVisible() then
		SetMapToCurrentZone();
		local myX,myY = GetPlayerMapPosition("player");
		local myZoneNum = TRP2_GetCurrentMapZone();
		if myZoneNum == zone and x and y and radius then
			radius = min(max(1,radius),100);
			local distance = math.floor(math.sqrt(((myX - x)^2) + ((myY - y)^2))*1000);
			--TRP2_debug(TRP2_FT("Son %3 radius %4 de %1, distance : %2",tostring(sender),tostring(distance),tostring(son),tostring(radius)));
			if distance <= radius then
				TRP2_PlaySound(son);
				if TRP2_GetConfigValueFor("bSoundLog",false) then
					TRP2_Afficher(TRP2_FT(TRP2_LOC_LocSoudPlayeedBy,sender,son),TRP2_GetConfigValueFor("SoundLogFrame",1));
				end
			end
		end
	end
end

function TRP2_GetIndexedTabSize(tab)
	if not tab then return 0 end
	local i = 0;
	for k,v in pairs(tab) do i = i + 1 end
	return i;
end

-- Convertit un total de seconde en un string pour affichage sur les icones
function TRP2_TimeToString(secondes)
	local jour,heure,minutes,message;
	if secondes > 86400 then
		jour = math.floor(secondes/86400);
		if jour == 1 then
			message = "2 j";
		else
			message = jour.." j";
		end
	elseif secondes > 3600 then
		heure = math.floor(secondes/3600);
		if heure == 1 then
			message = "2 h";
		else
			message = heure.." h";
		end
	elseif secondes > 60 then
		minutes = math.floor(secondes/60);
		if minutes == 1 then
			message = "2 m";
		else
			message = minutes.." m";
		end
	else
		message = secondes.." s";
	end
	return message;
end

function TRP2_GoldToText(gold)
	gold = string.reverse(tostring(gold));
	local Or="";
	local Argent="";
	local Bronze="";
	Bronze = string.reverse(string.sub(gold,1,2));
	Argent = string.reverse(string.sub(gold,3,4));
	Or = string.reverse(string.sub(gold,5));
	if Or ~= "" then
		Or = Or.."|TInterface\\MoneyFrame\\UI-GoldIcon.blp:15:15|t";
	end
	if Argent ~= "" and Argent ~= "00" then
		Argent = Argent.."|TInterface\\MoneyFrame\\UI-SilverIcon.blp:15:15|t";
	else
		Argent = "";
	end
	if Bronze ~= "" and Bronze ~= "00" then
		Bronze = Bronze.."|TInterface\\MoneyFrame\\UI-CopperIcon.blp:15:15|t";
	else
		Bronze = "";
	end
	return Or.." "..Argent.." "..Bronze;
end

function TRP2_GetEnglishClass(target)
	local prout, class = UnitClass(target);
	return class;
end

function TRP2_GetEnglishRace(target)
	local prout, race = UnitRace(target);
	return race;
end

function TRP2_GS(male,female)
	if TRP2_PlayerSex == 2 then
		return male;
	end
	return female;
end

function TRP2_Montre(tab)
	for k,v in pairs(tab) do
		print(k.." : "..tostring(v).." ( "..type(v).." )");
	end
end
