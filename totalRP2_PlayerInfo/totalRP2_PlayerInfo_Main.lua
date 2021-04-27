-------------------------------------------------------------------
--                          Total RP 2
--            A roleplay addon for World of Warcraft
-- Created by Sylvain "Telkostrasz" Cossement (up to version 1.017)
--   Licence : CC BY-NC-SA (http://creativecommons.org/licenses/)
-------------------------------------------------------------------

----------------------------------------------------------------------------
-- TOTAL RP 2
----------------------------------------------------------------------------
TRP2_HASBEENPRESENTED = false;

function TRP2_SePresenterSurLeChan()
	if TRP2_HASBEENPRESENTED then
		return;
	end
	local tab = {};
	tab[1] = TRP2_version;
	TRP2_SendContentToChannel(tab,"HELLO");
	TRP2_HASBEENPRESENTED = true;
end

function TRP2_NewVersionDispo(version)
	StaticPopupDialogs["TRP2_JUST_TEXT"].text = TRP2_CTS(TRP2_ENTETE..TRP2_FT(TRP2_LOC_NEWVERSION,tostring(version),TRP2_version));
	TRP2_ShowStaticPopup("TRP2_JUST_TEXT");
end

function TRP2_Set_Module_PlayerInfos()
	if not TRP2_Module_PlayerInfo then
		TRP2_Module_PlayerInfo = {};
	end
	if not TRP2_Module_PlayerInfo[TRP2_Royaume] then
		TRP2_Module_PlayerInfo[TRP2_Royaume] = {};
	end
	if not TRP2_Module_PlayerInfo[TRP2_Royaume][TRP2_Joueur] then
		TRP2_Module_PlayerInfo[TRP2_Royaume][TRP2_Joueur] = {};
	end
	-- Les infos de languages
	if not TRP2_Module_Language then
		TRP2_Module_Language = {};
	end
	-- Magasins
	if not TRP2_Module_Vendeur then
		TRP2_Module_Vendeur = {};
	end
	if not TRP2_Module_Vendeur[TRP2_Royaume] then
		TRP2_Module_Vendeur[TRP2_Royaume] = {};
	end
	if not TRP2_Module_Vendeur[TRP2_Royaume][TRP2_Joueur] then
		TRP2_Module_Vendeur[TRP2_Royaume][TRP2_Joueur] = {};
	end
	-- Auras
	if not TRP2_Module_Auras then
		TRP2_Module_Auras = {};
	end
	if not TRP2_Module_AurasTemp then
		TRP2_Module_AurasTemp = {};
	end
	-- Psycho :
	-- TRP2_Module_PlayerInfo[TRP2_Royaume][TRP2_Joueur]["Langues"] = nil;
	-- http://forums.wow-europe.com/thread.html?topicId=272947621&sid=2
end

function TRP2_TraiterTooltipPerso(Nom,infoTab,j,TT_Type)
	local persoTab,petsTab;
	persoTab = TRP2_GetInfoTab(Nom,{});
	petsTab = TRP2_GetInfo(Nom,"Pets",{});
	actuTab = TRP2_GetInfo(Nom,"Actu",{});
	registreTab = TRP2_GetInfo(Nom,"Registre",{});
	
	if persoTab then
		local i = 1;
		local Localclass,englishClass = UnitClass(TT_Type);
		local C = RAID_CLASS_COLORS[englishClass];
		-- Statut + Nom complet + statut RP
		local texteADroite = "";
		local prout,royaume = UnitName(TT_Type);
		local nomTotal = TRP2_ColorToHexa(C.r,C.g,C.b)..TRP2_nomComplet(Nom,TRP2_GetConfigValueFor("TTPersoCompoTitre",false), royaume);
		if TRP2_GetConfigValueFor("UseColorInTooltip",true) then
			else
						nomTotal = TRP2_DeleteColorCode(nomTotal);
					end
		if TRP2_GetWithDefaut(actuTab,"StatutRP",2) == 1 then
			local prout,royaume = UnitName(TT_Type)
			nomTotal = nomTotal.." {r}("..TRP2_LOC_StatutHRP..")";
		end
		-- Icones
		if TRP2_GetConfigValueFor("TTPersoCompoIcon1",true) then
			if UnitIsAFK(TT_Type) then
				texteADroite = texteADroite.."|TInterface\\ICONS\\Spell_Nature_Sleep:25:25|t";
			elseif UnitIsDND(TT_Type) then
				texteADroite = texteADroite.."|TInterface\\ICONS\\Ability_Mage_IncantersAbsorbtion:25:25|t";
			end
			if TRP2_GetConfigValueFor("TTPersoCompoRel",true) then
				local Relation = TRP2_GetRelation(Nom,TRP2_Joueur);
				if Relation ~= 2 and TRP2_relation_texture[Relation] then
					texteADroite = texteADroite.."|T"..TRP2_relation_texture[Relation]..":25:25|t";
				end
			end
			if true then -- icone joueur
				if TRP2_GetWithDefaut(actuTab,"PlayerIcon") then
					nomTotal = "|TInterface\\ICONS\\"..TRP2_GetWithDefaut(actuTab,"PlayerIcon")..":30:30|t  "..nomTotal;
				elseif UnitFactionGroup(TT_Type) == "Alliance" then
					nomTotal = "|TInterface\\ICONS\\INV_BannerPVP_02:25:25|t  "..nomTotal;
				elseif UnitFactionGroup(TT_Type) == "Horde" then
					nomTotal = "|TInterface\\ICONS\\INV_BannerPVP_01:25:25|t  "..nomTotal;
				end
			end
			if UnitIsPVP(TT_Type) then -- Icone PVP
				texteADroite = texteADroite.."|TInterface\\ICONS\\Ability_DualWield:25:25|t";
			end
			if TRP2_GetWithDefaut(actuTab,"StatutXP") and TRP2_GetWithDefaut(actuTab,"StatutXP") ~= 2 then -- Icone XP
				texteADroite = texteADroite..TRP2_IconeXP[tostring(TRP2_GetWithDefaut(actuTab,"StatutXP"))].."25:25|t";
			end
		end
		
		TRP2_PersoTooltip:AddDoubleLine(TRP2_CTS(nomTotal),TRP2_CTS(texteADroite));
		getglobal(TRP2_PersoTooltip:GetName().."TextLeft" .. i):SetFont("Fonts\\FRIZQT__.TTF",TRP2_GetConfigValueFor("TTPersoTailleTitre",16));
		getglobal(TRP2_PersoTooltip:GetName().."TextRight" .. i):SetFont("Fonts\\FRIZQT__.TTF",TRP2_GetConfigValueFor("TTPersoTailleTitre",16));
		i = i + 1;
		-- Titre complet
		if TRP2_GetConfigValueFor("TTPersoCompoSousTitre",true) then
			if TRP2_GetWithDefaut(registreTab,"TitreComplet") then
				if TRP2_GetConfigValueFor("UseColorInTooltip",true) then
					TRP2_PersoTooltip:AddLine(TRP2_CTS("{ff7700}< "..TRP2_GetWithDefaut(registreTab,"TitreComplet").." {ff7700}>"),1,1,1,1);
			else
					TRP2_PersoTooltip:AddLine(TRP2_CTS("{ff7700}< "..TRP2_DeleteColorCode(TRP2_GetWithDefaut(registreTab,"TitreComplet")).." {ff7700}>"),1,1,1,1);

					end
				getglobal(TRP2_PersoTooltip:GetName().."TextLeft" .. i):SetFont("Fonts\\FRIZQT__.TTF",TRP2_GetConfigValueFor("TTPersoTailleInfo",12));
				i = i + 1;
			elseif UnitPVPName(TT_Type) ~= Nom then
				TRP2_PersoTooltip:AddLine(TRP2_CTS("{ff7700}< "..UnitPVPName(TT_Type).." >"));
				getglobal(TRP2_PersoTooltip:GetName().."TextLeft" .. i):SetFont("Fonts\\FRIZQT__.TTF",TRP2_GetConfigValueFor("TTPersoTailleInfo",12));
				i = i + 1;
			end
		end
		--  Race, Classe et lvl
		if TRP2_GetConfigValueFor("TTPersoCompoCRLvl",true) then
					local race = TRP2_GetWithDefaut(registreTab,"RacePerso") or UnitRace(TT_Type);
					local class = TRP2_GetWithDefaut(registreTab,"ClassePerso") or Localclass;
			if UnitLevel(TT_Type) ~= -1 then
				if TRP2_GetConfigValueFor("UseColorInTooltip",true) then
					TRP2_PersoTooltip:AddDoubleLine(TRP2_CTS("{w}"..race.." "..TRP2_ColorToHexa(C.r,C.g,C.b)..class),TRP2_CTS("{w}("..TRP2_LOC_LEVEL.." "..UnitLevel(TT_Type)..")"));
			else
					TRP2_PersoTooltip:AddDoubleLine(TRP2_CTS("{w}"..TRP2_DeleteColorCode(race).." "..TRP2_ColorToHexa(C.r,C.g,C.b)..TRP2_DeleteColorCode(class)),TRP2_CTS("{w}("..TRP2_LOC_LEVEL.." "..UnitLevel(TT_Type)..")"));
					end
			else
				TRP2_PersoTooltip:AddDoubleLine(TRP2_CTS("{w}"..race.." "..TRP2_ColorToHexa(C.r,C.g,C.b)..class),TRP2_CTS("{w}("..TRP2_LOC_LEVEL.." ??)"));
			end
			getglobal(TRP2_PersoTooltip:GetName().."TextLeft" .. i):SetFont("Fonts\\FRIZQT__.TTF",TRP2_GetConfigValueFor("TTPersoTailleInfo",12));
			getglobal(TRP2_PersoTooltip:GetName().."TextRight" .. i):SetFont("Fonts\\FRIZQT__.TTF",TRP2_GetConfigValueFor("TTPersoTailleInfo",12));
			i = i + 1;
		end
		--  Royaume
		local prout,royaume = UnitName(TT_Type)
		if TRP2_GetConfigValueFor("TTPersoCompoRoyaume",true) and royaume then
			TRP2_PersoTooltip:AddLine(TRP2_CTS("{w}"..TRP2_LOC_REALM.." : {o}"..royaume));
			getglobal(TRP2_PersoTooltip:GetName().."TextLeft" .. i):SetFont("Fonts\\FRIZQT__.TTF",TRP2_GetConfigValueFor("TTPersoTailleInfo",12));
			i = i + 1;
		end
		--  Guilde
		if TRP2_GetConfigValueFor("TTPersoCompoGuilde",true) and GetGuildInfo(TT_Type) then
			local guilde, grade = GetGuildInfo(TT_Type);
			TRP2_PersoTooltip:AddLine(TRP2_CTS(TRP2_FT(TRP2_LOC_GUILD_TT,grade,guilde)));
			getglobal(TRP2_PersoTooltip:GetName().."TextLeft" .. i):SetFont("Fonts\\FRIZQT__.TTF",TRP2_GetConfigValueFor("TTPersoTailleInfo",12));
			i = i + 1;
		end
		-- Actuellement Texte
		if TRP2_GetConfigValueFor("TTPersoCompoActu",true) and TRP2_GetWithDefaut(actuTab,"ActuTexte") then
			TRP2_PersoTooltip:AddLine(TRP2_CTS("{w}"..TRP2_LOC_Actu3.." :"));
			getglobal(TRP2_PersoTooltip:GetName().."TextLeft" .. i):SetFont("Fonts\\FRIZQT__.TTF",TRP2_GetConfigValueFor("TTPersoTailleInfo",12));
			i = i + 1;
			local descri = TRP2_GetWithDefaut(actuTab,"ActuTexte");
			if TRP2_GetConfigValueFor("CouperDescri",0) ~= 0 and string.len(descri) > TRP2_GetConfigValueFor("CouperDescri") then
				descri = string.sub(descri,1,TRP2_GetConfigValueFor("CouperDescri",0)).."...";
			end
			if TRP2_GetConfigValueFor("UseColorInTooltip",true) then
					TRP2_PersoTooltip:AddLine(TRP2_CTS("{o}\""..descri.."{o}\""),1,1,1,1);
			else
					TRP2_PersoTooltip:AddLine(TRP2_CTS("{o}\""..TRP2_DeleteColorCode(descri).."{o}\""),1,1,1,1);

					end
			
			getglobal(TRP2_PersoTooltip:GetName().."TextLeft" .. i):SetFont("Fonts\\FRIZQT__.TTF",TRP2_GetConfigValueFor("TTPersoTailleDescri",10));
			i = i + 1;
		end
		-- Actuellement HRP
		if TRP2_GetConfigValueFor("TTPersoCompoActuHRP",true) and TRP2_GetWithDefaut(actuTab,"ActuTexteHRP") then
			TRP2_PersoTooltip:AddLine(TRP2_CTS("{w}"..TRP2_LOC_HRPINFO.." :"));
			getglobal(TRP2_PersoTooltip:GetName().."TextLeft" .. i):SetFont("Fonts\\FRIZQT__.TTF",TRP2_GetConfigValueFor("TTPersoTailleInfo",12));
			i = i + 1;
			local descri = TRP2_GetWithDefaut(actuTab,"ActuTexteHRP");
			if TRP2_GetConfigValueFor("CouperDescri",0) ~= 0 and string.len(descri) > TRP2_GetConfigValueFor("CouperDescri") then
				descri = string.sub(descri,1,TRP2_GetConfigValueFor("CouperDescri",0)).."...";
			end
			if TRP2_GetConfigValueFor("UseColorInTooltip",true) then
					TRP2_PersoTooltip:AddLine(TRP2_CTS("{o}\""..descri.."{o}\""),1,1,1,1);
			else
					TRP2_PersoTooltip:AddLine(TRP2_CTS("{o}\""..TRP2_DeleteColorCode(descri).."{o}\""),1,1,1,1);

					end
			getglobal(TRP2_PersoTooltip:GetName().."TextLeft" .. i):SetFont("Fonts\\FRIZQT__.TTF",TRP2_GetConfigValueFor("TTPersoTailleDescri",10));
			i = i + 1;
		end
		-- Notes Texte
		if TRP2_GetConfigValueFor("TTPersoCompoNotes",true) and TRP2_Joueur ~= Nom and TRP2_GetWithDefaut(persoTab,"Notes") then
			TRP2_PersoTooltip:AddLine(TRP2_CTS("{w}"..TRP2_LOC_NOTES.." :"));
			getglobal(TRP2_PersoTooltip:GetName().."TextLeft" .. i):SetFont("Fonts\\FRIZQT__.TTF",TRP2_GetConfigValueFor("TTPersoTailleInfo",12));
			i = i + 1;
			local descri = TRP2_GetWithDefaut(persoTab,"Notes");
			if TRP2_GetConfigValueFor("CouperNotes",0) ~= 0 and string.len(descri) > TRP2_GetConfigValueFor("CouperNotes",0) then
				descri = string.sub(descri,1,TRP2_GetConfigValueFor("CouperNotes",0)).."...";
			end
			TRP2_PersoTooltip:AddLine(TRP2_CTS("{o}\""..descri.."{o}\""),1,1,1,1);
			getglobal(TRP2_PersoTooltip:GetName().."TextLeft" .. i):SetFont("Fonts\\FRIZQT__.TTF",TRP2_GetConfigValueFor("TTPersoTailleDescri",10));
			i = i + 1;
		end
		-- Auras
		if TRP2_GetConfigValueFor("TTPersoCompoAuras",true) and TRP2_GetIndexedTabSize(TRP2_GetInfo(Nom,"AurasTab",{})) > 0 then
			local auraText = TRP2_FormatAuraToText(Nom);
			if string.gsub(auraText,"%s","") ~= "" then
				TRP2_PersoTooltip:AddLine(TRP2_CTS("{w}"..TRP2_LOC_Auras.." :"));
				getglobal(TRP2_PersoTooltip:GetName().."TextLeft" .. i):SetFont("Fonts\\FRIZQT__.TTF",TRP2_GetConfigValueFor("TTPersoTailleInfo",12));
				i = i + 1;
				TRP2_PersoTooltip:AddLine(auraText);
				getglobal(TRP2_PersoTooltip:GetName().."TextLeft" .. i):SetFont("Fonts\\FRIZQT__.TTF",TRP2_GetConfigValueFor("TTPersoTailleInfo",12));
				i = i + 1;
			end
		end
		-- Cible
		if TRP2_GetConfigValueFor("TTPersoCompoCible",true) and TRP2_EmptyToNil(UnitName(TT_Type.."target")) then
			TRP2_PersoTooltip:AddLine(TRP2_CTS("{w}"..STATUS_TEXT_TARGET.." : {o}"..UnitName(TT_Type.."target")));
			getglobal(TRP2_PersoTooltip:GetName().."TextLeft" .. i):SetFont("Fonts\\FRIZQT__.TTF",TRP2_GetConfigValueFor("TTPersoTailleInfo",12));
			i = i + 1;
		end
		if TRP2_EstIgnore(Nom) then
			TRP2_PersoTooltip:AddLine(TRP2_CTS("{o}< {r}"..TRP2_LOC_PersoIgnroe.." {o}>"));
			getglobal(TRP2_PersoTooltip:GetName().."TextLeft" .. i):SetFont("Fonts\\FRIZQT__.TTF",TRP2_GetConfigValueFor("TTPersoTailleInfo",12));
			i = i + 1;
		end
		-- Client
		if TRP2_GetConfigValueFor("TTPersoCompoClient",true) then
			if Nom == TRP2_Joueur then
				TRP2_PersoTooltip:AddDoubleLine(" ",TRP2_CTS("{w}".."TotalRP2 v"..TRP2_version));
				getglobal(TRP2_PersoTooltip:GetName().."TextLeft" .. i):SetFont("Fonts\\FRIZQT__.TTF",8);
				getglobal(TRP2_PersoTooltip:GetName().."TextRight" .. i):SetFont("Fonts\\FRIZQT__.TTF",8);
				i = i + 1;
			elseif TRP2_GetWithDefaut(persoTab,"Client") then
				TRP2_PersoTooltip:AddDoubleLine(" ",TRP2_CTS("{w}"..TRP2_GetWithDefaut(persoTab,"Client")));
				getglobal(TRP2_PersoTooltip:GetName().."TextLeft" .. i):SetFont("Fonts\\FRIZQT__.TTF",8);
				getglobal(TRP2_PersoTooltip:GetName().."TextRight" .. i):SetFont("Fonts\\FRIZQT__.TTF",8);
				i = i + 1;
			end
		end
		-- Montures
		-- @ AFFICHAGE DES MONTURES
		if TRP2_GetConfigValueFor("TTPersoCompoMonture",true) then
			local monture="";
			local j=1;
			while(monture) do
				monture = UnitBuff(TT_Type, j);
				if monture and petsTab[monture] then
					petsTab = petsTab[monture];
					
					TRP2_MountTooltip:AddLine(TRP2_CTS("{w}|TInterface\\ICONS\\"..TRP2_GetWithDefaut(petsTab,"Icone","Ability_Mount_Charger")..":30:30|t "..TRP2_GetWithDefaut(petsTab,"Nom",monture)));
					getglobal(TRP2_MountTooltip:GetName().."TextLeft" .. 1):SetFont("Fonts\\FRIZQT__.TTF",TRP2_GetConfigValueFor("TTPersoTailleTitre",16));
					
					TRP2_MountTooltip:AddLine(TRP2_CTS("{w}< "..TRP2_FT(TRP2_LOC_SMOUNT,Nom).."{w} >"));
					getglobal(TRP2_MountTooltip:GetName().."TextLeft" .. 2):SetFont("Fonts\\FRIZQT__.TTF",TRP2_GetConfigValueFor("TTPersoTailleInfo",12));
					
					if TRP2_GetWithDefaut(petsTab,"Description") then
						-- DESCRIPTION
						TRP2_MountTooltip:AddLine(TRP2_CTS("{w}"..TRP2_LOC_Description.." :"));
						getglobal(TRP2_MountTooltip:GetName().."TextLeft" .. 3):SetFont("Fonts\\FRIZQT__.TTF",TRP2_GetConfigValueFor("TTPersoTailleInfo",12));
						-- DESCRIPTION CONTENU
						TRP2_MountTooltip:AddLine(TRP2_CTS("{o}\""..TRP2_GetWithDefaut(petsTab,"Description").."{o}\""),1,1,1,1);
						getglobal(TRP2_MountTooltip:GetName().."TextLeft" .. 4):SetFont("Fonts\\FRIZQT__.TTF",TRP2_GetConfigValueFor("TTPersoTailleDescri",10));
					end
					-- Auras
					if true then
						if TRP2_GetIndexedTabSize(TRP2_GetWithDefaut(petsTab,"AurasTab",{})) > 0 then
							local auraText = TRP2_FormatAuraToTextPet(Nom,monture);
							if string.gsub(auraText,"%s","") ~= "" then
								TRP2_MountTooltip:AddLine(TRP2_CTS("{w}"..TRP2_LOC_Auras.." :"));
								getglobal(TRP2_MountTooltip:GetName().."TextLeft" .. 5):SetFont("Fonts\\FRIZQT__.TTF",TRP2_GetConfigValueFor("TTPersoTailleInfo",12));
								TRP2_MountTooltip:AddLine(auraText);
								getglobal(TRP2_MountTooltip:GetName().."TextLeft" .. 5):SetFont("Fonts\\FRIZQT__.TTF",TRP2_GetConfigValueFor("TTPersoTailleInfo",12));
							end
						end
					end
					TRP2_MountTooltip:Show();
					break;
				end
				j = j+1;
			end
		end
	end
end

function TRP2_TraiterTooltipPet(NomMaitre,Nom,CustomNomPet,infoTab,j,TT_Type)
	local petTab = TRP2_GetInfo(NomMaitre,"Pets",{});
	if petTab[Nom] then
		petTab = petTab[Nom];
	end
	if petTab then
		local i = 1;
		local creatureFamily = UnitCreatureFamily(TT_Type);
		local creatureType = UnitCreatureType(TT_Type);
		local icone = "";
		-- Icone du pet
		if TRP2_GetWithDefaut(petTab,"Icone") then
			icone = "|TInterface\\ICONS\\"..TRP2_GetWithDefaut(petTab,"Icone")..":35:35|t ";
		elseif TRP2_PetFamilyTab[creatureFamily] then
			icone = "|TInterface\\ICONS\\"..TRP2_PetFamilyTab[creatureFamily]..".blp:35:35|t ";
		end
		-- Nom
		if true then
                        if CustomNomPet then
                            TRP2_PersoTooltip:AddLine(TRP2_CTS(icone.."{v}"..TRP2_GetWithDefaut(petTab,"Nom",CustomNomPet)));
                        else
                            TRP2_PersoTooltip:AddLine(TRP2_CTS(icone.."{v}"..TRP2_GetWithDefaut(petTab,"Nom",Nom)));
                        end
			getglobal(TRP2_PersoTooltip:GetName().."TextLeft" .. i):SetFont("Fonts\\FRIZQT__.TTF",TRP2_GetConfigValueFor("TTPersoTailleTitre",16));
			i = i + 1;
		end
		-- Compagnon de ...
		if true then
			if string.find(infoTab[2],NomMaitre) then
				local Phrase = "{w}< "..infoTab[2].." >";
				Phrase = string.gsub(Phrase,NomMaitre,"{o}"..NomMaitre.."{w}");
				TRP2_PersoTooltip:AddLine(TRP2_CTS(Phrase));
				getglobal(TRP2_PersoTooltip:GetName().."TextLeft" .. i):SetFont("Fonts\\FRIZQT__.TTF",TRP2_GetConfigValueFor("TTPersoTailleInfo",12));
				i = i + 1;
			end
		end
		-- Famille
		if true then
			if creatureFamily and not TRP2_PetFamilyTab[creatureFamily] then
				TRP2_PersoTooltip:AddLine(TRP2_CTS("{o}"..creatureFamily));
				getglobal(TRP2_PersoTooltip:GetName().."TextLeft" .. i):SetFont("Fonts\\FRIZQT__.TTF",TRP2_GetConfigValueFor("TTPersoTailleInfo",12));
				i = i + 1;
			end
		end
		-- Type
		if true then
			if creatureType then
				TRP2_PersoTooltip:AddLine(TRP2_CTS("{w}"..creatureType));
				getglobal(TRP2_PersoTooltip:GetName().."TextLeft" .. i):SetFont("Fonts\\FRIZQT__.TTF",TRP2_GetConfigValueFor("TTPersoTailleInfo",12));
				i = i + 1;
			end
		end
		-- Description
		if true then
			if TRP2_GetWithDefaut(petTab,"Description") then
				TRP2_PersoTooltip:AddLine(TRP2_CTS("{w}"..TRP2_LOC_Description.." :"));
				getglobal(TRP2_PersoTooltip:GetName().."TextLeft" .. i):SetFont("Fonts\\FRIZQT__.TTF",TRP2_GetConfigValueFor("TTPersoTailleInfo",12));
				i = i + 1;
				local descri = TRP2_GetWithDefaut(petTab,"Description");
				if TRP2_GetConfigValueFor("CouperDescri",0) ~= 0 and string.len(descri) > TRP2_GetConfigValueFor("CouperDescri",0) then
					descri = string.sub(descri,1,TRP2_GetConfigValueFor("CouperDescri",0)).."...";
				end
				TRP2_PersoTooltip:AddLine(TRP2_CTS("{w}\"{o}"..descri.."{w}\""),1,1,1,1);
				getglobal(TRP2_PersoTooltip:GetName().."TextLeft" .. i):SetFont("Fonts\\FRIZQT__.TTF",TRP2_GetConfigValueFor("TTPersoTailleDescri",10));
				i = i + 1;
			end
		end
		if UnitName("pet") == Nom and TRP2_Joueur == NomMaitre and TRP2_GetConfigValueFor("TTFamFood",true) then
			local petFoodList = "|cff00ff00";
			local liste = {GetPetFoodTypes()};
			if liste and #liste > 0 then
				for _,v in pairs(liste) do
					if not TRP2_FoodIconTable[v] then
						petFoodList = petFoodList..v..", ";
					else
						petFoodList = petFoodList.."|TInterface\\ICONS\\"..TRP2_FoodIconTable[v]..":20:20|t  ";
					end
				end
				petFoodList = string.sub(petFoodList,1,-3);
				petFoodList = string.gsub(PET_DIET_TEMPLATE,"%%s",petFoodList);
				TRP2_PersoTooltip:AddLine(TRP2_CTS("{w}"..petFoodList));
				getglobal(TRP2_PersoTooltip:GetName().."TextLeft" .. i):SetFont("Fonts\\FRIZQT__.TTF",TRP2_GetConfigValueFor("TTPersoTailleInfo",12));
				i = i + 1;
			end
		end
		-- Niveau
		if true then
			if UnitLevel(TT_Type) and UnitLevel(TT_Type) ~= 1 then
				if UnitLevel(TT_Type) ~= -1 then
					TRP2_PersoTooltip:AddLine(TRP2_CTS("{w}"..LEVEL.." "..UnitLevel(TT_Type)));
				else
					TRP2_PersoTooltip:AddLine(TRP2_CTS("{w}"..LEVEL.." ??"));
				end
				getglobal(TRP2_PersoTooltip:GetName().."TextLeft" .. i):SetFont("Fonts\\FRIZQT__.TTF",TRP2_GetConfigValueFor("TTPersoTailleInfo",12));
				i = i + 1;
			end
		end
		-- Auras
		if true then
			if TRP2_GetIndexedTabSize(TRP2_GetWithDefaut(petTab,"AurasTab",{})) > 0 then
				local auraText = TRP2_FormatAuraToTextPet(NomMaitre,Nom);
				if string.gsub(auraText,"%s","") ~= "" then
					TRP2_PersoTooltip:AddLine(TRP2_CTS("{w}"..TRP2_LOC_Auras.." :"));
					getglobal(TRP2_PersoTooltip:GetName().."TextLeft" .. i):SetFont("Fonts\\FRIZQT__.TTF",TRP2_GetConfigValueFor("TTPersoTailleInfo",12));
					i = i + 1;
					TRP2_PersoTooltip:AddLine(auraText);
					getglobal(TRP2_PersoTooltip:GetName().."TextLeft" .. i):SetFont("Fonts\\FRIZQT__.TTF",TRP2_GetConfigValueFor("TTPersoTailleInfo",12));
					i = i + 1;
				end
			end
		end
	end
end

function TRP2_SetFicheGeneralConsulte(Nom)
	local message = "";
	local registreTab = TRP2_GetInfo(Nom,"Registre",{});
	TRP2MainFrameFicheJoueurGeneralConsulte:Show();

	-- Encadré nom complet et titre complet
	TRP2_PanelJoueurNomComplet:SetText(TRP2_CTS(TRP2_nomComplet(Nom)));
	TRP2_PanelJoueurTitreComplet:SetText(TRP2_CTS(TRP2_GetWithDefaut(registreTab,"TitreComplet",TRP2_LOC_NOTITRE)));

	-- Scroll du dessus
	-- Premier string
	if TRP2_GetWithDefaut(registreTab,"Age") then
		message = message.."{o}"..TRP2_LOC_AGE.." : {w}"..TRP2_GetWithDefaut(registreTab,"Age").."\n";
	end
	if TRP2_GetWithDefaut(registreTab,"Habitation") then
		message = message.."{o}"..TRP2_LOC_HABITAT.." : {w}"..TRP2_GetWithDefaut(registreTab,"Habitation").."\n";
	end
	if TRP2_GetWithDefaut(registreTab,"Origine") then
		message = message.."{o}"..TRP2_LOC_ORIGINE.." : {w}"..TRP2_GetWithDefaut(registreTab,"Origine").."\n";
	end
	if TRP2_GetWithDefaut(registreTab,"RacePerso") then
		message = message.."{o}"..RACE.." : {w}"..TRP2_GetWithDefaut(registreTab,"RacePerso").."\n";
	elseif TRP2_GetInfo(Nom,"RaceLoc") then
		message = message.."{o}"..RACE.." : {w}"..TRP2_GetInfo(Nom,"RaceLoc").."\n";
	elseif Nom == TRP2_Joueur then
		message = message.."{o}"..RACE.." : {w}"..UnitRace("player").."\n";
	end
	if TRP2_GetWithDefaut(registreTab,"ClassePerso") then
		message = message.."{o}"..CLASS.." : {w}"..TRP2_GetWithDefaut(registreTab,"ClassePerso").."\n";
	elseif TRP2_GetInfo(Nom,"ClassLoc") then
		message = message.."{o}"..CLASS.." : {w}"..TRP2_GetInfo(Nom,"ClassLoc").."\n";
	elseif Nom == TRP2_Joueur then
		message = message.."{o}"..CLASS.." : {w}"..UnitClass("player").."\n";
	end
	if message ~= "" then
		TRP2_FicheJoueurConsulteInfoBaseTitre:SetText("|TInterface\\ICONS\\INV_Misc_Book_02.blp:40:40|t "..TRP2_CTS("{j}"..TRP2_LOC_DETAILREG));
		TRP2_FicheJoueurConsulteInfoBase:SetText(TRP2_CTS(message));
	else
		TRP2_FicheJoueurConsulteInfoBaseTitre:SetText("");
		TRP2_FicheJoueurConsulteInfoBase:SetText("");
	end
	
	TRP2_FicheJoueurConsulteInfoPhysiqueTitre:SetText("|TInterface\\ICONS\\Spell_Nature_Strength.blp:40:40|t "..TRP2_CTS("{j}"..TRP2_LOC_PHYSIQUE));
	message = "";
	message = message.."{o}"..TRP2_LOC_TAILLE.." : {w}"..TRP2_LOC_TAILLE_TEXTE[TRP2_GetWithDefaut(registreTab,"Taille",3)].."\n";
	message = message.."{o}"..TRP2_LOC_SILHOUETTE.." : {w}"..TRP2_LOC_SILHOUETTE_TEXTE[TRP2_GetWithDefaut(registreTab,"Silhouette",2)].."\n";
	TRP2_FicheJoueurConsulteInfoPhysique:SetText(TRP2_CTS(message));
	if TRP2_GetWithDefaut(registreTab,"TraitVisage") or TRP2_GetWithDefaut(registreTab,"YeuxVisage") or TRP2_GetWithDefaut(registreTab,"Piercing") then
		TRP2_FicheJoueurConsulteInfoVisageTitre:SetText("|TInterface\\ICONS\\Spell_Shadow_MindSteal.blp:40:40|t "..TRP2_CTS("{j}"..TRP2_LOC_DETAILVISAGE));
		message = "";
		if TRP2_GetWithDefaut(registreTab,"TraitVisage") then
			message = message.."{o}"..TRP2_LOC_VISAGETRAIT.." : {w}"..TRP2_GetWithDefaut(registreTab,"TraitVisage").."\n";
		end
		if TRP2_GetWithDefaut(registreTab,"YeuxVisage") then
			message = message.."{o}"..TRP2_LOC_VISAGEYEUX.." : {w}"..TRP2_GetWithDefaut(registreTab,"YeuxVisage").."\n";
		end
		if TRP2_GetWithDefaut(registreTab,"Piercing") then
			message = message.."{o}"..TRP2_LOC_VISAGEPIERCING.." : {w}"..TRP2_GetWithDefaut(registreTab,"Piercing").."\n";
		end
		TRP2_FicheJoueurConsulteInfoVisage:SetText(TRP2_CTS(message));
	else
		TRP2_FicheJoueurConsulteInfoVisageTitre:SetText("");
		TRP2_FicheJoueurConsulteInfoVisage:SetText("");
	end
end

function TRP2_SetFicheGeneralEdit()
	local registreTab = TRP2_GetInfo(TRP2_Joueur,"Registre",{});
	TRP2MainFrameFicheJoueurGeneralEdition:Show();
	TRP2_FicheJoueurPrenomSaisie:SetText(TRP2_GetWithDefaut(registreTab,"Prenom",TRP2_Joueur));
	TRP2_FicheJoueurNomSaisie:SetText(TRP2_GetWithDefaut(registreTab,"Nom",""));
	TRP2_FicheJoueurTitreSaisie:SetText(TRP2_GetWithDefaut(registreTab,"Titre",""));
	TRP2_FicheJoueurTitreCompletSaisie:SetText(TRP2_GetWithDefaut(registreTab,"TitreComplet",""));
	TRP2_FicheJoueurAgeSaisie:SetText(TRP2_GetWithDefaut(registreTab,"Age",""));
	TRP2_FicheJoueurOrigineSaisie:SetText(TRP2_GetWithDefaut(registreTab,"Origine",""));
	TRP2_FicheJoueurHabitationSaisie:SetText(TRP2_GetWithDefaut(registreTab,"Habitation",""));
	TRP2_FicheJoueurRaceSaisie:SetText(TRP2_GetWithDefaut(registreTab,"RacePerso",""));
	TRP2_FicheJoueurClassSaisie:SetText(TRP2_GetWithDefaut(registreTab,"ClassePerso",""));
	TRP2_FicheJoueurTraitSaisie:SetText(TRP2_GetWithDefaut(registreTab,"TraitVisage",""));
	TRP2_FicheJoueurYeuxSaisie:SetText(TRP2_GetWithDefaut(registreTab,"YeuxVisage",""));
	TRP2_FicheJoueurPiercingSaisie:SetText(TRP2_GetWithDefaut(registreTab,"Piercing",""));
	TRP2_FicheJoueurTailleSliderValeur:SetText(TRP2_LOC_TAILLE_TEXTE[TRP2_GetWithDefaut(registreTab,"Taille",3)]);
	TRP2_FicheJoueurTailleSlider.Valeur = TRP2_GetWithDefaut(registreTab,"Taille",3);
	TRP2_FicheJoueurSilhouetteSliderValeur:SetText(TRP2_LOC_SILHOUETTE_TEXTE[TRP2_GetWithDefaut(registreTab,"Silhouette",2)]);
	TRP2_FicheJoueurSilhouetteSlider.Valeur = TRP2_GetWithDefaut(registreTab,"Silhouette",2);
	TRP2MainFrameFicheJoueurMenuOngletOngletConsulte:Show();
end

function TRP2_DD_Taille(frame,level,menuList)
	UIDropDownMenu_SetWidth(frame, 50);
	UIDropDownMenu_SetButtonWidth(frame, 15);
	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_LOC_TAILLE;
	info.func = function() end;
	info.isTitle = true;
	UIDropDownMenu_AddButton(info);

	local i;
	for i=1,5,1 do
		info = TRP2_CreateSimpleDDButton();
		if TRP2_FicheJoueurTailleSlider.Valeur == i then
			info.text = TRP2_CTS(TRP2_LOC_TAILLE_TEXTE[i]);
			info.checked = true;
			info.disabled = true;
		else
			info.text = TRP2_CTS(TRP2_LOC_TAILLE_TEXTE[i]);
		end
		info.func = function()
			TRP2_FicheJoueurTailleSlider.Valeur = i;
			TRP2_FicheJoueurTailleSliderValeur:SetText(TRP2_LOC_TAILLE_TEXTE[i]);
		end;
		UIDropDownMenu_AddButton(info,level);
	end
	info = TRP2_CreateSimpleDDButton();
	info.text = CANCEL;
	UIDropDownMenu_AddButton(info,level);
end

function TRP2_DD_Silhouette(frame,level,menuList)
	UIDropDownMenu_SetWidth(frame, 50);
	UIDropDownMenu_SetButtonWidth(frame, 15);
	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_LOC_SILHOUETTE;
	info.func = function() end;
	info.isTitle = true;
	UIDropDownMenu_AddButton(info);

	local i;
	for i=1,4,1 do
		info = TRP2_CreateSimpleDDButton();
		if TRP2_FicheJoueurSilhouetteSlider.Valeur == i then
			info.text = TRP2_CTS(TRP2_LOC_SILHOUETTE_TEXTE[i]);
			info.checked = true;
			info.disabled = true;
		else
			info.text = TRP2_CTS(TRP2_LOC_SILHOUETTE_TEXTE[i]);
		end
		info.func = function()
			TRP2_FicheJoueurSilhouetteSlider.Valeur = i;
			TRP2_FicheJoueurSilhouetteSliderValeur:SetText(TRP2_LOC_SILHOUETTE_TEXTE[i]);
		end;
		UIDropDownMenu_AddButton(info,level);
	end
	info = TRP2_CreateSimpleDDButton();
	info.text = CANCEL;
	UIDropDownMenu_AddButton(info,level);
end

function TRP2_SetFicheGeneralSave()
	local registreTab = TRP2_GetInfo(TRP2_Joueur,"Registre",{});
	registreTab["Prenom"] = TRP2_DefautToNil(TRP2_EmptyToNil(TRP2_FicheJoueurPrenomSaisie:GetText()),TRP2_Joueur);
	registreTab["Nom"] = TRP2_EmptyToNil(TRP2_FicheJoueurNomSaisie:GetText());
	registreTab["Titre"] = TRP2_EmptyToNil(TRP2_FicheJoueurTitreSaisie:GetText());
	registreTab["TitreComplet"] = TRP2_EmptyToNil(TRP2_FicheJoueurTitreCompletSaisie:GetText());
	registreTab["Age"] = TRP2_EmptyToNil(TRP2_FicheJoueurAgeSaisie:GetText());
	registreTab["Origine"] = TRP2_EmptyToNil(TRP2_FicheJoueurOrigineSaisie:GetText());
	registreTab["Habitation"] = TRP2_EmptyToNil(TRP2_FicheJoueurHabitationSaisie:GetText());
	registreTab["RacePerso"] = TRP2_EmptyToNil(TRP2_FicheJoueurRaceSaisie:GetText());
	registreTab["ClassePerso"] = TRP2_EmptyToNil(TRP2_FicheJoueurClassSaisie:GetText());
	registreTab["TraitVisage"] = TRP2_EmptyToNil(TRP2_FicheJoueurTraitSaisie:GetText());
	registreTab["YeuxVisage"] = TRP2_EmptyToNil(TRP2_FicheJoueurYeuxSaisie:GetText());
	registreTab["Piercing"] = TRP2_EmptyToNil(TRP2_FicheJoueurPiercingSaisie:GetText());
	registreTab["Taille"] = TRP2_DefautToNil(TRP2_FicheJoueurTailleSlider.Valeur,3);
	registreTab["Silhouette"] = TRP2_DefautToNil(TRP2_FicheJoueurSilhouetteSlider.Valeur,2);
	TRP2_SetInfo(TRP2_Joueur,"Registre",registreTab);
	TRP2_IncreaseVernNum("Registre");
	TRP2_MSP_RegistreUpdate(registreTab);
end

function TRP2_SetFichePhysiqueConsulte(Nom)
	TRP2MainFrameFicheJoueurPhysiqueConsulte:Show();
	local texte = TRP2_ConvertToHTML(TRP2_GetWithDefaut(TRP2_GetInfo(Nom,"Physique",{}),"PhysiqueTexte","{titre1:centre}\n\n\n\n\n"..TRP2_LOC_NODESCRI.."{/titre1}"));
	TRP2_FicheJoueurPhysiqueBox:SetText(texte);
end

function TRP2_SetFichePhysiqueEdit()
	TRP2MainFrameFicheJoueurPhysiqueEdition:Show();
	TRP2_FicheJoueurPhysiqueEditBox:SetText(TRP2_GetWithDefaut(TRP2_GetInfo(TRP2_Joueur,"Physique",{}),"PhysiqueTexte",""));
	TRP2MainFrameFicheJoueurMenuOngletOngletConsulte:Show();
end

function TRP2_SetFichePhysiqueSave()
	TRP2_IncreaseVernNum("Physique");
	local tab = TRP2_GetInfo(TRP2_Joueur,"Physique",{});
	tab["PhysiqueTexte"] = TRP2_EmptyToNil(TRP2_FicheJoueurPhysiqueEditBox:GetText());
	TRP2_MSP_DescriUpdate(tab);
	TRP2_SetInfo(TRP2_Joueur,"Physique",tab);
end

function TRP2_SetFicheHistoireConsulte(Nom)
	TRP2MainFrameFicheJoueurHistoireConsulte:Show();
	local texte = TRP2_ConvertToHTML(TRP2_GetWithDefaut(TRP2_GetInfo(Nom,"Histoire",{}),"HistoireTexte","{titre1:centre}\n\n\n\n\n"..TRP2_LOC_NOHISTO.."{/titre1}"));
	TRP2_FicheJoueurHistoireBox:SetText(texte);
end

function TRP2_SetFicheHistoireEdit()
	TRP2MainFrameFicheJoueurHistoireEdition:Show();
	TRP2_FicheJoueurHistoireEditBox:SetText(TRP2_GetWithDefaut(TRP2_GetInfo(TRP2_Joueur,"Histoire",{}),"HistoireTexte",""));
	TRP2MainFrameFicheJoueurMenuOngletOngletConsulte:Show();
end

function TRP2_SetFicheHistoireSave()
	TRP2_IncreaseVernNum("Histoire");
	local tab = TRP2_GetInfo(TRP2_Joueur,"Histoire",{});
	tab["HistoireTexte"] = TRP2_EmptyToNil(TRP2_FicheJoueurHistoireEditBox:GetText());
	TRP2_MSP_HistoryUpdate(tab);
	TRP2_SetInfo(TRP2_Joueur,"Histoire",tab);
end

function TRP2_SetFichePsychoConsulte(Nom)
	TRP2MainFrameFicheJoueurPsychoConsulte:Show();
	local psychoTab =  TRP2_GetInfo(Nom,"Psycho",{});
	TRP2_FicheJoueurPsychoBar1.PsyVal =  TRP2_GetWithDefaut(psychoTab,"ChaLux",10) / 20;
	TRP2_FicheJoueurPsychoBar2.PsyVal =  TRP2_GetWithDefaut(psychoTab,"IndRen",10) / 20;
	TRP2_FicheJoueurPsychoBar3.PsyVal =  TRP2_GetWithDefaut(psychoTab,"GenEgo",10) / 20;
	TRP2_FicheJoueurPsychoBar4.PsyVal =  TRP2_GetWithDefaut(psychoTab,"SinTro",10) / 20;
	TRP2_FicheJoueurPsychoBar5.PsyVal =  TRP2_GetWithDefaut(psychoTab,"MisCru",10) / 20;
	TRP2_FicheJoueurPsychoBar6.PsyVal =  TRP2_GetWithDefaut(psychoTab,"ModVan",10) / 20;
	TRP2_FicheJoueurPsychoBar7.PsyVal =  TRP2_GetWithDefaut(psychoTab,"PiePra",10) / 20;
	TRP2_FicheJoueurPsychoBar8.PsyVal =  TRP2_GetWithDefaut(psychoTab,"RefImp",10) / 20;
	TRP2_FicheJoueurPsychoBar9.PsyVal =  TRP2_GetWithDefaut(psychoTab,"AceBon",10) / 20;
	TRP2_FicheJoueurPsychoBar10.PsyVal =  TRP2_GetWithDefaut(psychoTab,"ValCou",10) / 20;
	TRP2_FicheJoueurPsychoBar11.PsyVal =  TRP2_GetWithDefaut(psychoTab,"ChaLoy",10) / 20;
end

function TRP2_SetFichePsychoEdit()
	TRP2MainFrameFicheJoueurPsychoEdition:Show();
	local psychoTab =  TRP2_GetInfo(TRP2_Joueur,"Psycho",{});
	TRP2_FicheJoueurChaLuxSlider.Valeur = TRP2_GetWithDefaut(psychoTab,"ChaLux",10);
	TRP2_FicheJoueurIndRenSlider.Valeur = TRP2_GetWithDefaut(psychoTab,"IndRen",10);
	TRP2_FicheJoueurGenEgoSlider.Valeur = TRP2_GetWithDefaut(psychoTab,"GenEgo",10);
	TRP2_FicheJoueurSinTroSlider.Valeur = TRP2_GetWithDefaut(psychoTab,"SinTro",10);
	TRP2_FicheJoueurMisCruSlider.Valeur = TRP2_GetWithDefaut(psychoTab,"MisCru",10);
	TRP2_FicheJoueurModVanSlider.Valeur = TRP2_GetWithDefaut(psychoTab,"ModVan",10);
	TRP2_FicheJoueurPiePraSlider.Valeur = TRP2_GetWithDefaut(psychoTab,"PiePra",10);
	TRP2_FicheJoueurRefImpSlider.Valeur = TRP2_GetWithDefaut(psychoTab,"RefImp",10);
	TRP2_FicheJoueurAceBonSlider.Valeur = TRP2_GetWithDefaut(psychoTab,"AceBon",10);
	TRP2_FicheJoueurValCouSlider.Valeur = TRP2_GetWithDefaut(psychoTab,"ValCou",10);
	TRP2_FicheJoueurChaLoySlider.Valeur = TRP2_GetWithDefaut(psychoTab,"ChaLoy",10);
	TRP2MainFrameFicheJoueurMenuOngletOngletConsulte:Show();
end

function TRP2_SetFichePsychoSave()
	TRP2_IncreaseVernNum("Psycho");
	local psychoTab =  TRP2_GetInfo(TRP2_Joueur,"Psycho",{});
	psychoTab["ChaLux"] = TRP2_DefautToNil(TRP2_FicheJoueurChaLuxSlider.Valeur,10);
	psychoTab["IndRen"] = TRP2_DefautToNil(TRP2_FicheJoueurIndRenSlider.Valeur,10);
	psychoTab["GenEgo"] = TRP2_DefautToNil(TRP2_FicheJoueurGenEgoSlider.Valeur,10);
	psychoTab["SinTro"] = TRP2_DefautToNil(TRP2_FicheJoueurSinTroSlider.Valeur,10);
	psychoTab["MisCru"] = TRP2_DefautToNil(TRP2_FicheJoueurMisCruSlider.Valeur,10);
	psychoTab["ModVan"] = TRP2_DefautToNil(TRP2_FicheJoueurModVanSlider.Valeur,10);
	psychoTab["PiePra"] = TRP2_DefautToNil(TRP2_FicheJoueurPiePraSlider.Valeur,10);
	psychoTab["RefImp"] = TRP2_DefautToNil(TRP2_FicheJoueurRefImpSlider.Valeur,10);
	psychoTab["AceBon"] = TRP2_DefautToNil(TRP2_FicheJoueurAceBonSlider.Valeur,10);
	psychoTab["ValCou"] = TRP2_DefautToNil(TRP2_FicheJoueurValCouSlider.Valeur,10);
	psychoTab["ChaLoy"] = TRP2_DefautToNil(TRP2_FicheJoueurChaLoySlider.Valeur,10);
	TRP2_SetInfo(TRP2_Joueur,"Psycho",psychoTab);
end

function TRP2_SetFicheActuConsulte(Nom)
	local ActuTab = TRP2_GetInfo(Nom,"Actu",{});
	local playerTab = TRP2_GetInfoTab(Nom,{});
	TRP2MainFrameFicheJoueurActuConsulte:Show();
	TRP2_FicheJoueurActuActuScrollEditBox:SetText(TRP2_CTS("{w}"..TRP2_GetWithDefaut(ActuTab,"ActuTexte","")));
	TRP2_FicheJoueurActuHRPScrollEditBox:SetText(TRP2_CTS("{w}"..TRP2_GetWithDefaut(ActuTab,"ActuTexteHRP","")));
	TRP2_FicheJoueurActuStatutRPValeur:SetText(TRP2_CTS(TRP2_LOC_StatutRP_Tab[TRP2_GetWithDefaut(ActuTab,"StatutRP",2)]));
	TRP2_FicheJoueurActuStatutXPValeur:SetText(TRP2_IconeXP[tostring(TRP2_GetWithDefaut(ActuTab,"StatutXP",2))].."20:20|t".." "..TRP2_CTS(TRP2_LOC_StatutXP_Tab[TRP2_GetWithDefaut(ActuTab,"StatutXP",2)]));
	if TRP2_GetWithDefaut(ActuTab,"PlayerIcon") then
		TRP2_FicheJoueurActuPlayerIconIcon:SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(ActuTab,"PlayerIcon",""));
	elseif TRP2_GetWithDefaut(playerTab,"Sex") and TRP2_GetWithDefaut(playerTab,"Race") then
		TRP2_FicheJoueurActuPlayerIconIcon:SetTexture("Interface\\ICONS\\"..TRP2_textureRace[TRP2_enRace][TRP2_textureSex[UnitSex("player")]]);
	else
		TRP2_FicheJoueurActuPlayerIconIcon:SetTexture("Interface\\ICONS\\Temp");
	end
	TRP2_FicheJoueurActuActuButton:Hide();
	TRP2_FicheJoueurActuHRPButton:Hide();
	TRP2_FicheJoueurActuNotesButton:Hide();
	if Nom ~= TRP2_Joueur then
		TRP2_FicheJoueurActuNotesScrollEditBox:SetText(TRP2_CTS("{w}"..TRP2_GetWithDefaut(playerTab,"Notes","")));
		TRP2_FicheJoueurActuActuBoutonHide:Hide();
		TRP2_FicheJoueurActuHRPBoutonHide:Hide();
		TRP2_FicheJoueurActuNotesBoutonHide:Show();
		TRP2_FicheJoueurActuHRPScrollEditBox.disabled = true;
		TRP2_SetTooltipForFrame(TRP2_FicheJoueurActuActuScrollEditBox,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_Actu3);
		TRP2_SetTooltipForFrame(TRP2_FicheJoueurActuActuScroll,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_Actu3);
		TRP2_SetTooltipForFrame(TRP2_FicheJoueurActuHRPScrollEditBox,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_HRPINFO);
		TRP2_SetTooltipForFrame(TRP2_FicheJoueurActuHRPScroll,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_HRPINFO);
	else
		TRP2_FicheJoueurActuHRPBoutonHide:Show();
		TRP2_FicheJoueurActuActuBoutonHide:Show();
		TRP2_FicheJoueurActuNotesBoutonHide:Hide();
		TRP2_SetTooltipForFrame(TRP2_FicheJoueurActuActuScrollEditBox,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_Actu3,TRP2_LOC_ActuTT);
		TRP2_SetTooltipForFrame(TRP2_FicheJoueurActuActuScroll,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_Actu3,TRP2_LOC_ActuTT);
		TRP2_SetTooltipForFrame(TRP2_FicheJoueurActuHRPScrollEditBox,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_HRPINFO,TRP2_LOC_HRPINFO_TT);
		TRP2_SetTooltipForFrame(TRP2_FicheJoueurActuHRPScroll,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_HRPINFO,TRP2_LOC_HRPINFO_TT);
	end
	TRP2_FicheJoueurActuNotesTexte:SetText(TRP2_CTS("{w}"..TRP2_LOC_NOTES));
	TRP2_FicheJoueurActuActuTexte:SetText(TRP2_CTS("{w}"..TRP2_LOC_Actu3));
	TRP2_FicheJoueurActuHRPTexte:SetText(TRP2_CTS("{w}"..TRP2_LOC_HRPINFO));
end

function TRP2_EnregistrerIcone(bouton)
	local ActuTab = TRP2_GetInfo(TRP2_Joueur,"Actu",{});
	ActuTab["PlayerIcon"] = TRP2_EmptyToNil(bouton.icone);
	TRP2_SetInfo(TRP2_Joueur,"Actu",ActuTab);
	TRP2_IncreaseVernNum("Actu");
	if TRP2MainFrame:IsVisible() then
		TRP2_OpenPanel(TRP2MainFrame.Panel, TRP2MainFrame.Onglet,TRP2MainFrame.SousOnglet,"Consulte",TRP2_Joueur);
	end
end

function TRP2_SetFicheCaractConsulte(nom)
	TRP2_AfficherAurasPour(nom);
end

-- COMBAT

function TRP2_SwitchStatutRP()
	local ActuTab = TRP2_GetInfo(TRP2_Joueur,"Actu",{});
	if TRP2_GetWithDefaut(ActuTab,"StatutRP",2) == 2 then -- RP -> HRP
		ActuTab["StatutRP"] = 1;
		TRP2_Afficher(TRP2_LOC_HRP_GOTO);
	else -- HRP -> RP
		ActuTab["StatutRP"] = 2;
		TRP2_Afficher(TRP2_LOC_RP_GOTO);
	end
	TRP2_SetInfo(TRP2_Joueur,"Actu",ActuTab);
	TRP2_MSP_ActuUpdate(ActuTab);
	if TRP2MainFrame:IsVisible() then
		TRP2_OpenPanel(TRP2MainFrame.Panel, TRP2MainFrame.Onglet,TRP2MainFrame.SousOnglet,"Consulte",TRP2_Joueur);
	end
	TRP2_IncreaseVernNum("Actu");
end

function TRP2_SwitchStatutABS(bouton)
	if UnitIsAFK("player") then
		SendChatMessage("","AFK");
	elseif UnitIsDND("player") then
		SendChatMessage("","DND");
	else
		if bouton == "LeftButton" then
			SendChatMessage("","AFK");
		else
			SendChatMessage("","DND");
		end
	end
end

----------------------------------------------------------
-- GETTERS AND SETTERS : SAFE VERSION
----------------------------------------------------------
function TRP2_IsMine(nom)
	return TRP2_Module_PlayerInfo[TRP2_Royaume][nom] ~= nil;
end

function TRP2_GetInfo(nom,info,defaut)
	if TRP2_Module_PlayerInfo[TRP2_Royaume] and nom == TRP2_Joueur then
		if TRP2_Module_PlayerInfo[TRP2_Royaume][nom] and TRP2_Module_PlayerInfo[TRP2_Royaume][nom][info] ~= nil then
			return TRP2_Module_PlayerInfo[TRP2_Royaume][nom][info];
		end
	elseif TRP2_Module_Registre[TRP2_Royaume] then
		if TRP2_Module_Registre[TRP2_Royaume][nom] and TRP2_Module_Registre[TRP2_Royaume][nom][info] ~= nil then
			return TRP2_Module_Registre[TRP2_Royaume][nom][info];
		end
	end
	return defaut;
end

function TRP2_GetInfoTab(nom,defaut)
	if nom == TRP2_Joueur and TRP2_Module_PlayerInfo[TRP2_Royaume] and TRP2_Module_PlayerInfo[TRP2_Royaume][nom] then
		return TRP2_Module_PlayerInfo[TRP2_Royaume][nom];
	elseif TRP2_Module_Registre[TRP2_Royaume] and TRP2_Module_Registre[TRP2_Royaume][nom] then
		return TRP2_Module_Registre[TRP2_Royaume][nom];
	end
	return defaut;
end

function TRP2_SetInfo(nom,info,value)
	if nom == TRP2_Joueur and TRP2_Module_PlayerInfo[TRP2_Royaume] and TRP2_Module_PlayerInfo[TRP2_Royaume][nom] then
		TRP2_Module_PlayerInfo[TRP2_Royaume][nom][info] = value;
	elseif TRP2_Module_Registre[TRP2_Royaume] and TRP2_Module_Registre[TRP2_Royaume][nom] then
		TRP2_Module_Registre[TRP2_Royaume][nom][info] = value;
	end
end

function TRP2_IncreaseVernNum(verNum)
	local infoTab = TRP2_GetInfo(TRP2_Joueur,verNum,{});
	if TRP2_GetWithDefaut(infoTab,"VerNum") then
		infoTab["VerNum"] = infoTab["VerNum"] + 1;
		if infoTab["VerNum"] > 999 then
			infoTab["VerNum"] = 1;
		end
	else
		infoTab["VerNum"] = 1;
	end
	TRP2_SetInfo(TRP2_Joueur,verNum,infoTab);
end

function TRP2_GetPlayerPrenom()
	return TRP2_GetWithDefaut(TRP2_GetInfo(TRP2_Joueur,"Registre",{}),"Prenom",TRP2_Joueur);
end

function TRP2_GetGuildScript(mode)
	local guildname = GetGuildInfo(mode);
	return string.lower(tostring(guildname));
end

----------------------------------------------------------
-- INFOS PETS
----------------------------------------------------------

function TRP2_MascotteScript(nom)
	for i=1,GetNumCompanions("CRITTER") do
		local creatureID, creatureName = GetCompanionInfo("CRITTER", i);
		if nom == creatureName then
			CallCompanion("CRITTER", i);
			return;
		end
	end
	for i=1,GetNumCompanions("MOUNT") do
		local creatureID, creatureName = GetCompanionInfo("MOUNT", i);
		if nom == creatureName then
			CallCompanion("MOUNT", i);
			return;
		end
	end
end

function TRP2_GetActualMinionName(default)
	for i=1,GetNumCompanions("CRITTER") do
		local creatureID, creatureName, creatureSpellID, icon, issummoned = GetCompanionInfo("CRITTER", i);
		if issummoned then
			return creatureName;
		end
	end
	return default;
end

function TRP2_GetMinionIcone(nom)
	for i=1,GetNumCompanions("CRITTER") do
		local creatureID, creatureName, creatureSpellID, icon, issummoned = GetCompanionInfo("CRITTER", i);
		if creatureName == nom then
			return icon;
		end
	end
	return "Interface\\ICONS\\INV_Box_PetCarrier_01";
end

function TRP2_GetMountIcone(nom)
	for i=1,GetNumCompanions("MOUNT") do
		local creatureID, creatureName, creatureSpellID, icon, issummoned = GetCompanionInfo("MOUNT", i);
		if creatureName == nom then
			return icon;
		end
	end
	return "Interface\\ICONS\\INV_Box_PetCarrier_01";
end

function TRP2_GetActualPetName(default)
	if UnitName("pet") then
		return UnitName("pet");
	end
	return default;
end

function TRP2_GetActualMountName(default)
	for i=1,GetNumCompanions("MOUNT") do
		local creatureID, creatureName, creatureSpellID, icon, issummoned = GetCompanionInfo("MOUNT", i);
		if issummoned then
			return creatureName;
		end
	end
	return default;
end

function TRP2_GetActualMinionInfo(info,default)
	for i=1,GetNumCompanions("CRITTER") do
		-- TODO : peut être plus utile pour avoir la liste complète des familiers
		-- local petID, speciesID, owned, customName, level, favorite, isRevoked, speciesName, icon, petType, companionID, tooltip, description, isWild, canBattle, isTradeable, isUnique, obtainable = C_PetJournal.GetPetInfoByIndex(i);
		local creatureID, creatureName, creatureSpellID, icon, issummoned = GetCompanionInfo("CRITTER", i);
		if issummoned then
			local petTab = TRP2_GetInfo(TRP2_Joueur,"Pets",{})[creatureName];
			if petTab and petTab[info] then
				return petTab[info];
			end
			return default;
		end
	end
	return default;
end

function TRP2_GetActualPetInfo(info,default)
	local petTab = TRP2_GetInfo(TRP2_Joueur,"Pets",{});
	if UnitName("pet") and petTab[UnitName("pet")] and petTab[UnitName("pet")][info] then
		return petTab[UnitName("pet")][info];
	end
	return default;
end

function TRP2_GetActualMountInfo(info,default)
	for i=1,GetNumCompanions("MOUNT") do
	-- TODO GETCOMPANIONINFO -> CHECK NAME FOR PET USED VIA SPELL
	-- MAYBE CHANGE THE ENTIRE THING TO USE ID INSTEAD
		local creatureID, creatureName, creatureSpellID, icon, issummoned = GetCompanionInfo("MOUNT", i);
		if issummoned then
			local petTab = TRP2_GetInfo(TRP2_Joueur,"Pets",{})[creatureName];
			if petTab and petTab[info] then
				return petTab[info];
			end
			return default;
		end
	end
	return default;
end

----------------------------------------------------------
-- FORMAT FOR SENDING
----------------------------------------------------------

function TRP2_SendVernNum()
	return TRP2_version..TRP2_ReservedChar..TRP2_BuildVerNumMessage();
end

function TRP2_BuildVerNumMessage()
	local formatString = "";
	formatString = formatString..TRP2_GetWithDefaut(TRP2_GetInfo(TRP2_Joueur,"Actu",{}),"VerNum",0)..TRP2_ReservedChar;
	formatString = formatString..TRP2_GetWithDefaut(TRP2_GetInfo(TRP2_Joueur,"Registre",{}),"VerNum",0)..TRP2_ReservedChar;
	formatString = formatString..TRP2_GetWithDefaut(TRP2_GetInfo(TRP2_Joueur,"Physique",{}),"VerNum",0)..TRP2_ReservedChar;
	formatString = formatString..TRP2_GetWithDefaut(TRP2_GetInfo(TRP2_Joueur,"Psycho",{}),"VerNum",0)..TRP2_ReservedChar;
	formatString = formatString..TRP2_GetWithDefaut(TRP2_GetInfo(TRP2_Joueur,"Histoire",{}),"VerNum",0)..TRP2_ReservedChar;
	formatString = formatString..TRP2_GetWithDefaut(TRP2_GetInfo(TRP2_Joueur,"Aura",{}),"VerNum",0)..TRP2_ReservedChar;
	formatString = formatString..TRP2_GetActualMinionName("")..TRP2_ReservedChar; -- Minipet nom
	formatString = formatString..TRP2_GetActualMinionInfo("VerNum","-1")..TRP2_ReservedChar; -- Minipet vernum
	formatString = formatString..TRP2_GetActualMountName("")..TRP2_ReservedChar; -- Mount nom
	formatString = formatString..TRP2_GetActualMountInfo("VerNum","-1")..TRP2_ReservedChar; -- Mount vernum
	formatString = formatString..TRP2_GetActualPetName("")..TRP2_ReservedChar; -- Pet nom
	formatString = formatString..TRP2_GetActualPetInfo("VerNum","-1")..TRP2_ReservedChar; -- Pet vernum
	formatString = formatString..TRP2_GetInfo(TRP2_Joueur,"AuraVerNum",0)..TRP2_ReservedChar; -- Perso aura vernum
	formatString = formatString..""..TRP2_ReservedChar; -- Perso combat score
	formatString = formatString..TRP2_GetActualMinionInfo("AurasVerNum","")..TRP2_ReservedChar; -- Minion Aura vernum
	formatString = formatString..TRP2_GetActualMountInfo("AurasVerNum","")..TRP2_ReservedChar; -- Mount Aura vernum
	formatString = formatString..TRP2_GetActualPetInfo("AurasVerNum","")..TRP2_ReservedChar; -- Pet Aura vernum

	--TRP2_debug(formatString);
	return formatString;
end

function TRP2_RefreshRegistre(nom)
	if TRP2MainFrame:IsVisible() and TRP2MainFrame.Panel == "Fiche" and TRP2MainFrame.Nom == nom then
		TRP2_OpenPanel("Fiche", TRP2MainFrame.Onglet, TRP2MainFrame.SousOnglet, TRP2MainFrame.Mode, TRP2MainFrame.Nom);
	end
end

----------------------------------------------------------
-- REALISTE
----------------------------------------------------------

function TRP2_UpdateRealiste()
	if TRP2_GetWithDefaut(TRP2_GetInfo(TRP2_Joueur,"Actu",{}),"StatutRP",2) == 2 then
		if IsSwimming() then
			if not TRP2_PlayerHasAura("AUR00905") then
				TRP2_AddAura("AUR00905",600,true);
			else
				TRP2_SetAuraTime("AUR00905",600);
			end
		end
	end
end

----------------------------------------------------------
-- CARTES ET COORDONNEES
----------------------------------------------------------
TRP2_MINIMAPBUTTON = {};

-- Update de la map quand on recois un nouveau perso dans le tab
function TRP2_MapUpdate()
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
	
	for perso, persoTab in pairs(TRP2_PlayersPosition) do
		i = i+1;
		local playerButton = _G["TRP2_WordMapPlayer"..i];
		local partyX = persoTab["x"];
		local partyY = persoTab["y"];
		if not playerButton then
			playerButton = CreateFrame("Frame","TRP2_WordMapPlayer"..i,WorldMapButton,"WorldMapRaidUnitTemplate")
		end
		partyX = partyX * WorldMapDetailFrame:GetWidth();
		partyY = -partyY * WorldMapDetailFrame:GetHeight();
		_G["TRP2_WordMapPlayer"..i.."Icon"]:SetTexture("Interface\\Minimap\\OBJECTICONS");
		if TRP2_GetInfo(perso,"Seen") then
			_G["TRP2_WordMapPlayer"..i.."Icon"]:SetTexCoord(0, 0.125, 0, 0.125);
		else
			_G["TRP2_WordMapPlayer"..i.."Icon"]:SetTexCoord(0.125, 0.250, 0, 0.125);
		end
		playerButton.name = perso;
		playerButton:SetPoint("CENTER", "WorldMapDetailFrame", "TOPLEFT", partyX, partyY);
		playerButton:SetScript("OnEnter", function(self)
			WorldMapPOIFrame.allowBlobTooltip = false;
			local j=1;
			WorldMapTooltip:Hide();
			WorldMapTooltip:SetOwner(self, "ANCHOR_RIGHT",0,0);
			WorldMapTooltip:AddLine(TRP2_CTS("|TInterface\\ICONS\\Achievement_GuildPerk_EverybodysFriend:18:18|t "..TRP2_LOC_AFFICHERGENS.." :"), 1, 1, 1,true);
			while(_G["TRP2_WordMapPlayer"..j]) do
				if _G["TRP2_WordMapPlayer"..j]:IsVisible() and _G["TRP2_WordMapPlayer"..j]:IsMouseOver() then
					local name = _G["TRP2_WordMapPlayer"..j].name;
					if name then
						local icone = "";
						if TRP2_EmptyToNil(TRP2_GetInfo(name,"Actu",{})["PlayerIcon"]) then
							icone = " |TInterface\\ICONS\\"..TRP2_GetInfo(name,"Actu",{})["PlayerIcon"]..":18:18|t";
						elseif TRP2_GetInfo(name,"Sex") and TRP2_GetInfo(name,"Race") then
							icone = " |TInterface\\ICONS\\"..TRP2_textureRace[TRP2_enRace][TRP2_textureSex[UnitSex("player")]]..":18:18|t";
						end
						name = TRP2_nomComplet(name,true);
						WorldMapTooltip:AddLine(TRP2_CTS("- "..name..icone), 1, 1, 1,true);
					end
				end
				j = j+1;
			end
			WorldMapTooltip:Show();
		end);
		playerButton:SetScript("OnLeave", function()
			WorldMapPOIFrame.allowBlobTooltip = true;
			WorldMapTooltip:Hide();
		end);
		playerButton:Show();
		tinsert(TRP2_MINIMAPBUTTON,1,playerButton);
	end
end

-- Demande des coordonnées des gens sur la carte
function TRP2_GetCoordonnees()
	if not TRP2_GetConfigValueFor("MinimapShow",true) then
		TRP2_Error(ERR_CLIENT_LOCKED_OUT);
		return;
	end
	if TRP2_GetCurrentMapZone() < 1 then
		TRP2_Error(ERR_CLIENT_LOCKED_OUT);
		return;
	end
	
	local infoTab = {};
	infoTab[1] = TRP2_GetCurrentMapZone();
	TRP2_GetWorldMap().TRP2_Zone = infoTab[1];
	wipe(TRP2_PlayersPosition);
	TRP2_SendContentToChannel(infoTab,"GetLocalCoord");
	TRP2_MapUpdate();
end

function TRP2_SendCoordonnees(sender,ZoneID)
	if TRP2_GetConfigValueFor("MinimapShow",true) and sender and ZoneID then
		ZoneID = tonumber(ZoneID);
		if TRP2_GetWorldMap():IsVisible() then
			return;
		end
		SetMapToCurrentZone();
		local x,y = GetPlayerMapPosition("player");
		local zoneNum = TRP2_GetCurrentMapZone();
		if zoneNum == ZoneID then
			TRP2_SecureSendAddonMessage("SNCC",x..TRP2_ReservedChar..y,sender);
		end
	end
end

function TRP2_AddPlayerToMapTab(personnage,tab)
	if TRP2_PlayersPosition[personnage] then
		wipe(TRP2_PlayersPosition[personnage])
	end
	TRP2_PlayersPosition[personnage] = {};
	TRP2_PlayersPosition[personnage]["x"] = tab[1];
	TRP2_PlayersPosition[personnage]["y"] = tab[2];
	TRP2_MapUpdate();
end

function TRP2_GetCurrentMapZone()
	return GetCurrentMapAreaID();
end

----------- DOMICILE ---------

function TRP2_HouseHere()
	if not TRP2_CanPlanqueHere(true) then
		TRP2_Error(TRP2_LOC_CANHOUSEHERE);
		return;
	end
	if not UIParent:IsVisible() then
		WorldMapFrame_ToggleWindowSize();
	end
	StaticPopupDialogs["TRP2_GET_TEXT_NS"].text = TRP2_CTS(TRP2_ENTETE..TRP2_LOC_DOMICILETEXT);
	local coord = TRP2_GetPlanqueID(true);
	TRP2_ShowStaticPopup("TRP2_GET_TEXT_NS",nil,function(note)
		TRP2_SetInfo( TRP2_Joueur,"HouseCoord",coord);
		TRP2_SetInfo( TRP2_Joueur,"HouseNote",note);
		TRP2_Afficher(TRP2_FT(TRP2_LOC_HOUSEDONE,TRP2_Joueur,coord,note));
	end,nil,nil,nil,nil,TRP2_LOC_HOUSENAME);
end

TRP2_HousesPositions = {};

-- Demande des coordonnées des maisons sur la carte
function TRP2_GetLocalHouses()
	if TRP2_GetCurrentMapZone() < 1 then
		TRP2_Error(ERR_CLIENT_LOCKED_OUT);
		return;
	end
	
	local infoTab = {};
	infoTab[1] = TRP2_GetCurrentMapZone();
	TRP2_GetWorldMap().TRP2_Zone = infoTab[1];
	wipe(TRP2_HousesPositions);
	TRP2_SendContentToChannel(infoTab,"GetLocalHousesCoord");
	if TRP2_GetInfo(TRP2_Joueur,"HouseCoord") then
		local zone, x, y = strsplit(" ", TRP2_GetInfo(TRP2_Joueur,"HouseCoord"));
		if zone == tostring(infoTab[1]) then
			TRP2_HousesPositions[TRP2_Joueur] = {};
			TRP2_HousesPositions[TRP2_Joueur]["x"] = tonumber(x);
			TRP2_HousesPositions[TRP2_Joueur]["y"] = tonumber(y);
			TRP2_HousesPositions[TRP2_Joueur]["note"] = TRP2_GetInfo(TRP2_Joueur,"HouseNote");
		end
	end
	TRP2_MapHouseUpdate();
end

-- Envoie des données de notre maison
function TRP2_SendCoordonneesHouse(sender,ZoneID)
	if sender and ZoneID and TRP2_GetInfo(TRP2_Joueur,"HouseCoord") then
		local zone, x, y = strsplit(" ", TRP2_GetInfo(TRP2_Joueur,"HouseCoord"))
		if zone == ZoneID then
		--TODO: check visibility
			local Message = x..TRP2_ReservedChar;
			Message = Message..y..TRP2_ReservedChar;
			Message = Message..TRP2_GetInfo(TRP2_Joueur,"HouseNote");
			TRP2_SecureSendAddonMessage("SNHO",Message,sender);
		end
	end
end

-- Ajout d'une maison dans la liste
function TRP2_AddHouseToMapTab(personnage,tab)
	if not TRP2_HousesPositions[personnage] then
		TRP2_HousesPositions[personnage] = {};
	end
	TRP2_HousesPositions[personnage]["x"] = tonumber(tab[1]);
	TRP2_HousesPositions[personnage]["y"] = tonumber(tab[2]);
	TRP2_HousesPositions[personnage]["note"] = tab[3];
	TRP2_MapHouseUpdate();
end

-- Update de la map quand on recois une nouvelle maison
function TRP2_MapHouseUpdate()
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
	
	for personame, maison in pairs(TRP2_HousesPositions) do
		i = i+1; -- Compteur de maison totale sur la carte
		-- Création du bouton si il n'existe pas
		local houseButton = _G["TRP2_WordMapPlayer"..i];
		if not houseButton then
			houseButton = CreateFrame("Frame","TRP2_WordMapPlayer"..i,WorldMapButton,"WorldMapRaidUnitTemplate")
		end
		-- On adapte selon la taille de la carte
		local partyX = (maison["x"]/TRP2_PrecisionPlanque) * WorldMapDetailFrame:GetWidth();
		local partyY = ((-maison["y"])/TRP2_PrecisionPlanque) * WorldMapDetailFrame:GetHeight();
		-- Visuel du point
		_G["TRP2_WordMapPlayer"..i.."Icon"]:SetTexture("Interface\\Minimap\\POIICONS");
		_G["TRP2_WordMapPlayer"..i.."Icon"]:SetTexCoord(0.357143, 0.422, 0, 0.036);
		-- On place les info dans le bouton
		houseButton.info = maison;
		-- Tooltip
		houseButton:SetPoint("CENTER", "WorldMapDetailFrame", "TOPLEFT", partyX, partyY);
		houseButton:SetScript("OnEnter", function(self)
			WorldMapPOIFrame.allowBlobTooltip = false;
			local j=1;
			WorldMapTooltip:Hide();
			WorldMapTooltip:SetOwner(self, "ANCHOR_RIGHT",0,0);
			WorldMapTooltip:AddLine(TRP2_CTS("|TInterface\\ICONS\\Achievement_Zone_Gilneas_02:18:18|t {w}"..TRP2_LOC_HABITATS.." : "));
			while(_G["TRP2_WordMapPlayer"..j]) do
				if _G["TRP2_WordMapPlayer"..j]:IsVisible() and _G["TRP2_WordMapPlayer"..j]:IsMouseOver() then
					local info = _G["TRP2_WordMapPlayer"..j].info;
					if info then
						local prenom = TRP2_GetWithDefaut(TRP2_GetInfo(personame,"Registre",{}),"Prenom",personame);
						WorldMapTooltip:AddLine(TRP2_CTS("{o}- "..info["note"].." {v}("..prenom..")"), 1, 1, 1,true);
					end
				end
				j = j+1;
			end
			WorldMapTooltip:Show();
		end);
		houseButton:SetScript("OnLeave", function()
			WorldMapPOIFrame.allowBlobTooltip = true;
			WorldMapTooltip:Hide();
		end);
		houseButton:Show();
		tinsert(TRP2_MINIMAPBUTTON,1,houseButton);
	end
end

----------------------------------------------------------
-- DROPDOWN MENUS
----------------------------------------------------------

function TRP2_DD_PlayerInfoSaveButton(frame,level,menuList)
	UIDropDownMenu_SetWidth(frame, 20);
	UIDropDownMenu_SetButtonWidth(frame, 15);
	info = TRP2_CreateSimpleDDButton();
	info.text = SAVE_CHANGES;
	info.func = function() 
		if TRP2MainFrame.SousOnglet == "General" then
			TRP2_SetFicheGeneralSave();
		elseif TRP2MainFrame.SousOnglet == "Psycho" then
			TRP2_SetFichePsychoSave();
		elseif TRP2MainFrame.SousOnglet == "Physique" then
			TRP2_SetFichePhysiqueSave();
		elseif TRP2MainFrame.SousOnglet == "Histoire" then
			TRP2_SetFicheHistoireSave();
		end
		TRP2_OpenPanel(TRP2MainFrame.Panel, TRP2MainFrame.Onglet,TRP2MainFrame.SousOnglet,"Consulte",TRP2_Joueur);
	end;
	UIDropDownMenu_AddButton(info);
	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_LOC_DontSaveChanges;
	info.func = function() 
		TRP2_OpenPanel(TRP2MainFrame.Panel, TRP2MainFrame.Onglet,TRP2MainFrame.SousOnglet,"Consulte",TRP2_Joueur);
	end;
	UIDropDownMenu_AddButton(info);
	info = TRP2_CreateSimpleDDButton();
	info.text = CANCEL;
	UIDropDownMenu_AddButton(info,level);
end

function TRP2_DD_MenuRelation(frame,level,menuList)
	UIDropDownMenu_SetWidth(frame, 50);
	UIDropDownMenu_SetButtonWidth(frame, 15);
	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_LOC_RelationChange;
	info.func = function() end;
	info.isTitle = true;
	UIDropDownMenu_AddButton(info);
	
	local relation = TRP2_GetRelation(TRP2MainFrame.Nom,TRP2_Joueur);
	
	local i;
	for i=1,7,1 do
		info = TRP2_CreateSimpleDDButton();
		if relation == i then
			info.text = TRP2_LOC_RelationTab[i];
			info.checked = true;
			info.disabled = true;
		else
			info.text = TRP2_LOC_RelationTab[i];
		end
		info.func = function() 
			TRP2_SetRelation(TRP2MainFrame.Nom,TRP2_Joueur,i);
			if TRP2MainFrame:IsVisible() then
				TRP2_OpenPanel(TRP2MainFrame.Panel, TRP2MainFrame.Onglet,TRP2MainFrame.SousOnglet,"Consulte",TRP2MainFrame.Nom);
			end
			if UnitName("target") == TRP2MainFrame.Nom then
				TRP2_PlacerIconeCible(TRP2MainFrame.Nom);
			end
		end;
		UIDropDownMenu_AddButton(info,level);
	end
	info = TRP2_CreateSimpleDDButton();
	info.text = CANCEL;
	UIDropDownMenu_AddButton(info,level);
end

function TRP2_DD_MenuAccess(frame,level,menuList)
	UIDropDownMenu_SetWidth(frame, 50);
	UIDropDownMenu_SetButtonWidth(frame, 15);
	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_LOC_AccessChange;
	info.func = function() end;
	info.isTitle = true;
	UIDropDownMenu_AddButton(info);
	
	local access = TRP2_GetAccess(TRP2MainFrame.Nom);
	
	local i;
	for i=1,4,1 do
		info = TRP2_CreateSimpleDDButton();
		if access == i then
			info.text = TRP2_LOC_AccessTab[i];
			info.checked = true;
			info.disabled = true;
		else
			info.text = TRP2_LOC_AccessTab[i];
		end
		info.func = function() 
			TRP2_SetAccess(TRP2MainFrame.Nom,i)
			if TRP2MainFrame:IsVisible() then
				TRP2_OpenPanel(TRP2MainFrame.Panel, TRP2MainFrame.Onglet,TRP2MainFrame.SousOnglet,"Consulte",TRP2MainFrame.Nom);
			end
		end;
		UIDropDownMenu_AddButton(info,level);
	end
	info = TRP2_CreateSimpleDDButton();
	info.text = CANCEL;
	UIDropDownMenu_AddButton(info,level);
end

function TRP2_DD_ListeLevel(frame,level,menuList)
	UIDropDownMenu_SetWidth(frame, 50);
	UIDropDownMenu_SetButtonWidth(frame, 15);
	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_LOC_AccessLevel;
	info.func = function() end;
	info.isTitle = true;
	UIDropDownMenu_AddButton(info);

	local i;
	for i=1,5,1 do
		info = TRP2_CreateSimpleDDButton();
		info.text = TRP2_LOC_AccessTab[i];
		if TRP2_RegistreListeLevelSlider.Valeur == i then
			info.checked = true;
			info.disabled = true;
		end
		info.func = function() 
			TRP2_RegistreListeLevelSlider.Valeur = i;
			TRP2_RegistreListeLevelSliderValeur:SetText(TRP2_LOC_AccessTab[i]);
			TRP2_ChargerListeRegistre();
		end;
		UIDropDownMenu_AddButton(info,level);
	end
	info = TRP2_CreateSimpleDDButton();
	info.text = CANCEL;
	UIDropDownMenu_AddButton(info,level);
end

function TRP2_DD_ListeRelation(frame,level,menuList)
	UIDropDownMenu_SetWidth(frame, 50);
	UIDropDownMenu_SetButtonWidth(frame, 15);
	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_LOC_Relation;
	info.func = function() end;
	info.isTitle = true;
	UIDropDownMenu_AddButton(info);
	
	local i;
	for i=1,8,1 do
		info = TRP2_CreateSimpleDDButton();
		info.text = TRP2_LOC_RelationTab[i];
		if TRP2_RegistreListeRelationSlider.Valeur == i then
			info.checked = true;
			info.disabled = true;
		end
		info.func = function() 
			TRP2_RegistreListeRelationSlider.Valeur = i;
			TRP2_RegistreListeRelationSliderValeur:SetText(TRP2_LOC_RelationTab[i]);
			TRP2_ChargerListeRegistre();
		end;
		UIDropDownMenu_AddButton(info,level);
	end
	info = TRP2_CreateSimpleDDButton();
	info.text = CANCEL;
	UIDropDownMenu_AddButton(info,level);
end

function TRP2_DD_MenuJoueur(frame,level,menuList)
	UIDropDownMenu_SetWidth(frame, 50);
	UIDropDownMenu_SetButtonWidth(frame, 15);

	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_Joueur;
	info.func = function() end;
	info.isTitle = true;
	UIDropDownMenu_AddButton(info);
	
	if TRP2MainFrame.SousOnglet ~= "Caracteristiques" then
		info = TRP2_CreateSimpleDDButton();
		info.text = TRP2_LOC_Edition_TT;
		info.func = function() 
			TRP2_OpenPanel(TRP2MainFrame.Panel, TRP2MainFrame.Onglet,TRP2MainFrame.SousOnglet,"Edition",TRP2_Joueur);
		end;
		UIDropDownMenu_AddButton(info,level);
	end
	
	info = TRP2_CreateSimpleDDButton();
	info.text = CANCEL;
	UIDropDownMenu_AddButton(info,level);
end

function TRP2_DD_StatutRP(frame,level,menuList)
	UIDropDownMenu_SetWidth(frame, 50);
	UIDropDownMenu_SetButtonWidth(frame, 15);
	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_LOC_StatutRP;
	info.func = function() end;
	info.isTitle = true;
	UIDropDownMenu_AddButton(info);
	
	local statut = TRP2_GetWithDefaut(TRP2_GetInfo(TRP2_Joueur,"Actu",{}),"StatutRP",2);
	
	local i;
	for i=1,2,1 do
		info = TRP2_CreateSimpleDDButton();
		info.text = TRP2_CTS(TRP2_LOC_StatutRP_Tab[i],true);
		if statut == i then
			info.checked = true;
			info.disabled = true;
		end
		info.func = function()
			local ActuTab = TRP2_GetInfo(TRP2_Joueur,"Actu",{});
			ActuTab["StatutRP"] = i;
			TRP2_SetInfo(TRP2_Joueur,"Actu",ActuTab);
			TRP2_MSP_ActuUpdate(ActuTab);
			TRP2_IncreaseVernNum("Actu");
			if TRP2MainFrame:IsVisible() then
				TRP2_OpenPanel(TRP2MainFrame.Panel, TRP2MainFrame.Onglet,TRP2MainFrame.SousOnglet,"Consulte",TRP2MainFrame.Nom);
			end
		end;
		UIDropDownMenu_AddButton(info,level);
	end
	info = TRP2_CreateSimpleDDButton();
	info.text = CANCEL;
	UIDropDownMenu_AddButton(info,level);
end

function TRP2_DD_StatutXP(frame,level,menuList)
	UIDropDownMenu_SetWidth(frame, 50);
	UIDropDownMenu_SetButtonWidth(frame, 15);
	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_LOC_StatutXP;
	info.func = function() end;
	info.isTitle = true;
	UIDropDownMenu_AddButton(info);
	
	local statut = TRP2_GetWithDefaut(TRP2_GetInfo(TRP2_Joueur,"Actu",{}),"StatutXP",2);
	
	local i;
	for i=1,3,1 do
		info = TRP2_CreateSimpleDDButton();
		info.text = TRP2_IconeXP[tostring(i)].."20:20|t"..TRP2_CTS(TRP2_LOC_StatutXP_Tab[i],true);
		if statut == i then
			info.checked = true;
			info.disabled = true;
		end
		info.func = function() 
			local ActuTab = TRP2_GetInfo(TRP2_Joueur,"Actu",{});
			ActuTab["StatutXP"] = i;
			TRP2_SetInfo(TRP2_Joueur,"Actu",ActuTab);
			TRP2_IncreaseVernNum("Actu");
			if TRP2MainFrame:IsVisible() then
				TRP2_OpenPanel(TRP2MainFrame.Panel, TRP2MainFrame.Onglet,TRP2MainFrame.SousOnglet,"Consulte",TRP2MainFrame.Nom);
			end
		end;
		UIDropDownMenu_AddButton(info,level);
	end
	info = TRP2_CreateSimpleDDButton();
	info.text = CANCEL;
	UIDropDownMenu_AddButton(info,level);
end

function TRP2_DD_PetInfoSaveButton(frame,level,menuList)
	UIDropDownMenu_SetWidth(frame, 20);
	UIDropDownMenu_SetButtonWidth(frame, 15);
	info = TRP2_CreateSimpleDDButton();
	info.text = SAVE_CHANGES;
	info.func = function() 
		TRP2_SaveInfoPet();
	end;
	UIDropDownMenu_AddButton(info);
	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_LOC_DontSaveChanges;
	info.func = function() 
		TRP2_OpenPanel("Fiche","Pets","ConsultePet",TRP2MainFrame.Mode,TRP2_Joueur);
	end;
	UIDropDownMenu_AddButton(info);
	info = TRP2_CreateSimpleDDButton();
	info.text = CANCEL;
	UIDropDownMenu_AddButton(info,level);
end

function TRP2_DD_PotraitIconeClick(frame,level,menuList)
	local nom = TRP2CHATNAME;
	if not nom then
		nom, royaume = UnitName("target"); 
		if royaume then
			nom = nom.."-"..royaume;
		end
	end
	if not nom then return end
	level = level or 1;
	UIDropDownMenu_SetWidth(frame, 20);
	UIDropDownMenu_SetButtonWidth(frame, 15);
	if level == 1 then
		info = TRP2_CreateSimpleDDButton();
		info.text = nom;
		info.isTitle = true;
		UIDropDownMenu_AddButton(info,level);
	end
	
	if nom == TRP2_Joueur then
		info = TRP2_CreateSimpleDDButton();
		info.text = TRP2_CTS(TRP2_FT(TRP2_LOC_FICHE,nom));
		info.func = function() 
			TRP2_OpenPanel("Fiche","Registre","General","Consulte",TRP2_Joueur);
		end;
		UIDropDownMenu_AddButton(info,level);
		if IsMounted() and not UnitOnTaxi("target") then
			local mountName = TRP2_GetActualMountInfo("Nom",TRP2_GetActualMountName());
			if mountName then
				info = TRP2_CreateSimpleDDButton();
				info.text = TRP2_CTS(TRP2_FT(TRP2_LOC_FICHE,mountName));
				info.func = function() 
					if IsMounted() and not UnitOnTaxi("target") then
						TRP2_OpenPanel("Fiche","Pets","ConsultePet",TRP2_GetActualMountName(),TRP2_Joueur);
					end
				end;
				UIDropDownMenu_AddButton(info,level);
			end
		end
		if UnitName("pet") then
			local petName = TRP2_GetActualPetName("Nom",UnitName("pet"));
			info = TRP2_CreateSimpleDDButton();
			info.text = TRP2_CTS(TRP2_FT(TRP2_LOC_FICHE,petName));
			info.func = function()
				if UnitName("pet") then
					TRP2_OpenPanel("Fiche","Pets","ConsultePet",UnitName("pet"),TRP2_Joueur);
				end
			end;
			UIDropDownMenu_AddButton(info,level);
		end
		if TRP2_GetActualMinionName() then
			local petName = TRP2_GetActualMinionInfo("Nom",TRP2_GetActualMinionName());
			info = TRP2_CreateSimpleDDButton();
			info.text = TRP2_CTS(TRP2_FT(TRP2_LOC_FICHE,petName));
			info.func = function() 
				if TRP2_GetActualMinionName() then
					TRP2_OpenPanel("Fiche","Pets","ConsultePet",TRP2_GetActualMinionName(),TRP2_Joueur);
				end
			end;
			UIDropDownMenu_AddButton(info,level);
		end
		info = TRP2_CreateSimpleDDButton();
		if TRP2_GetWithDefaut(TRP2_GetInfo(TRP2_Joueur,"Actu",{}),"StatutRP",2) == 1 then
			info.text = TRP2_CTS("-> {v}"..TRP2_LOC_GOTORP);
		else
			info.text = TRP2_CTS("-> {r}"..TRP2_LOC_GOTOHRP);
		end
		info.func = function() 
			TRP2_SwitchStatutRP();
		end;
		UIDropDownMenu_AddButton(info,level);
	else
		if not TRP2_EstDansLeReg(nom) then
			info = TRP2_CreateSimpleDDButton();
			info.text = TRP2_CTS(TRP2_FT(TRP2_LOC_ADDTOREGISTER,nom));
			info.func = function() 
				TRP2_AjouterAuRegistre(nom, UnitName("target") == nom);
				TRP2_PlacerIconeCible(nom);
			end;
			UIDropDownMenu_AddButton(info,level);
		else
			if level == 1 then
				info = TRP2_CreateSimpleDDButton();
				info.text = TRP2_CTS(TRP2_FT(TRP2_LOC_FICHE,nom));
				info.func = function() 
					TRP2_OpenPanel("Fiche","Registre","General","Consulte",nom);
				end;
				UIDropDownMenu_AddButton(info,level);
				info = TRP2_CreateSimpleDDButton();
				info.text = TRP2_CTS(TRP2_LOC_AccessLevel);
				info.hasArrow = true;
				info.notCheckable = true;
				UIDropDownMenu_AddButton(info,level);
				info = TRP2_CreateSimpleDDButton();
				if TRP2_GetInfo(nom,"bMute",false) then
					info.text = TRP2_CTS(TRP2_LOC_UNMUTE);
					info.func = function() 
						TRP2_SetInfo(nom,"bMute",false);
						TRP2_Afficher(TRP2_FT(TRP2_LOC_UNMUTETT,nom));
					end;
				else
					info.text = TRP2_CTS(TRP2_LOC_MUTE);
					info.func = function() 
						TRP2_SetInfo(nom,"bMute",true);
						TRP2_Afficher(TRP2_FT(TRP2_LOC_MUTETT,nom));
					end;
				end
				UIDropDownMenu_AddButton(info,level);
			elseif level == 2 then
				info = TRP2_CreateSimpleDDButton();
				info.text = TRP2_LOC_AccessLevel;
				info.isTitle = true;
				UIDropDownMenu_AddButton(info,level);
				local access = TRP2_GetAccess(nom);
				local i;
				for i=1,4,1 do
					info = TRP2_CreateSimpleDDButton();
					if access == i then
						info.text = TRP2_LOC_AccessTab[i];
						info.checked = true;
						info.disabled = true;
					else
						info.text = TRP2_LOC_AccessTab[i];
					end
					info.func = function() 
						TRP2_SetAccess(nom,i);
						if TRP2MainFrame:IsVisible() then
							TRP2_OpenPanel(TRP2MainFrame.Panel, TRP2MainFrame.Onglet,TRP2MainFrame.SousOnglet,"Consulte",TRP2MainFrame.Nom);
						end
					end;
					UIDropDownMenu_AddButton(info,level);
				end
			end
		end
		if TRP2CHATNAME then
			info = TRP2_CreateSimpleDDButton();
			info.text = REPORT_SPAM;
			info.func = function() 
				local dialog = StaticPopup_Show("CONFIRM_REPORT_SPAM_CHAT", nom);
				if ( dialog ) then
					dialog.data = nom;
				end
			end;
			UIDropDownMenu_AddButton(info,level);
		end
	end
	
	info = TRP2_CreateSimpleDDButton();
	info.text = CANCEL;
	UIDropDownMenu_AddButton(info,level);
end