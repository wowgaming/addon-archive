-------------------------------------------------------------------
--                          Total RP 2
--            A roleplay addon for World of Warcraft
-- Created by Sylvain "Telkostrasz" Cossement (up to version 1.017)
--   Licence : CC BY-NC-SA (http://creativecommons.org/licenses/)
-------------------------------------------------------------------

function TRP2_InitialisationUI()
	TRP2_WorldMapButtonMenuIcon:SetTexture("Interface\\ICONS\\ABILITY_SEAL");
	TRP2_MailOutBoxButtonIcon:SetTexture("Interface\\ICONS\\INV_Letter_06");
	TRP2_MailInBoxButtonIcon:SetTexture("Interface\\ICONS\\INV_Letter_14");
	TRP2_RegistreListeDeleteAllIcon:SetTexture("Interface\\ICONS\\Achievement_BG_killX_flagcarriers_before_leave_base");
	TRP2_RegistreListeEpurerIcon:SetTexture("Interface\\ICONS\\Spell_Holy_SenseUndead");
	
	TRP2_WorldMapButtonPlanqueIcon:SetTexture("Interface\\ICONS\\ACHIEVEMENT_GUILDPERK_MOBILEBANKING");
	TRP2_WorldMapButtonMagasinIcon:SetTexture("Interface\\ICONS\\ACHIEVEMENT_GUILDPERK_BARTERING");
	TRP2_WorldMapButtonPanneauIcon:SetTexture("Interface\\ICONS\\TRADE_ARCHAEOLOGY_SKETCHDESERTPALACE");
	TRP2_WorldMapButtonRefreshIcon:SetTexture("Interface\\ICONS\\INV_Misc_EngGizmos_20");
	TRP2_WorldMapButtonHousingIcon:SetTexture("Interface\\ICONS\\Achievement_Zone_Gilneas_02");
	-- Onglet principaux
	TRP2MainFrameMenuBarOngletFicheIcon:SetTexture("Interface\\ICONS\\"..TRP2_textureRace[TRP2_enRace][TRP2_textureSex[UnitSex("player")]]);
	TRP2MainFrameMenuBarOngletRegistreIcon:SetTexture("Interface\\ICONS\\INV_Misc_Book_02");
	TRP2MainFrameMenuBarOngletCreationIcon:SetTexture("Interface\\ICONS\\INV_Misc_EngGizmos_swissArmy");
	TRP2MainFrameMenuBarOngletOptionsIcon:SetTexture("Interface\\ICONS\\INV_Misc_ScrewDriver_02");
	TRP2MainFrameMenuBarOngletLangageIcon:SetTexture("Interface\\ICONS\\Ability_Warrior_RallyingCry");
	TRP2MainFrameMenuBarOngletQuestIcon:SetTexture("Interface\\ICONS\\Achievement_Quests_Completed_01");
	TRP2MainFrameMenuBarOngletGuideIcon:SetTexture("Interface\\ICONS\\INV_Misc_Toy_01");
	TRP2MainFrameFicheJoueurMenuOngletOngletDeleteIcon:SetTexture("Interface\\ICONS\\Ability_Rogue_Eviscerate");
	-- Onglet Fiche joueur : REGISTRE
	TRP2MainFrameFicheJoueurMenuOngletOngletRegistreIcon:SetTexture("Interface\\ICONS\\INV_Misc_Book_02");
	TRP2MainFrameFicheJoueurMenuOngletOngletRetourListeIcon:SetTexture("Interface\\ICONS\\INV_Misc_Note_05");
	TRP2MainFrameFicheJoueurOngletRegistreOngletGeneralIcon:SetTexture("Interface\\ICONS\\INV_Misc_GroupLooking");
	TRP2MainFrameFicheJoueurOngletRegistreOngletPhysiqueIcon:SetTexture("Interface\\ICONS\\Ability_Warrior_StrengthOfArms");
	TRP2MainFrameFicheJoueurOngletRegistreOngletPsychoIcon:SetTexture("Interface\\ICONS\\Spell_Arcane_MindMastery");
	TRP2MainFrameFicheJoueurOngletRegistreOngletHistoireIcon:SetTexture("Interface\\ICONS\\INV_Misc_Book_09");
	TRP2MainFrameFicheJoueurOngletRegistreOngletActuIcon:SetTexture("Interface\\ICONS\\INV_Misc_Note_03");
	TRP2MainFrameFicheJoueurOngletRegistreOngletCaracteristiquesIcon:SetTexture("Interface\\ICONS\\Spell_Holy_ImprovedResistanceAuras");
	TRP2MainFrameFicheJoueurMenuOngletOngletConsulteIcon:SetTexture("Interface\\ICONS\\INV_Inscription_TradeSkill01");
	TRP2MainFrameFicheJoueurMenuOngletOngletEditionIcon:SetTexture("Interface\\ICONS\\INV_Inscription_TradeSkill01");
	TRP2_RegistreOngletMenuAuraIcon:SetTexture("Interface\\ICONS\\Spell_ChargePositive");
	TRP2MainFrameFicheJoueurMenuOngletOngletPetsListIcon:SetTexture("Interface\\ICONS\\INV_Box_PetCarrier_01");
	TRP2_PetFrameOngletEditionIcon:SetTexture("Interface\\ICONS\\INV_Inscription_TradeSkill01");
	TRP2_PetFrameOngletConsulteIcon:SetTexture("Interface\\ICONS\\INV_Inscription_TradeSkill01");
	TRP2_PetOngletMenuAuraIcon:SetTexture("Interface\\ICONS\\Spell_ChargePositive");
	-- Onglet Fiche joueur : Langue
	TRP2_FicheLanguagesOngletMenuLanguesIcon:SetTexture("Interface\\ICONS\\Spell_ChargePositive");
        TRP2_PurgeLanguagesButtonIcon:SetTexture("Interface\\ICONS\\Spell_ChargeNegative");
	-- Onglet Registre
	TRP2_NPCAnimFrameOngletEmoteIcon:SetTexture("Interface\\ICONS\\Spell_DeathKnight_IceBoundFortitude");
	TRP2_NPCAnimFrameOngletParoleIcon:SetTexture("Interface\\ICONS\\Ability_Warrior_RallyingCry");
	TRP2_NPCAnimFrameOngletTexteIcon:SetTexture("Interface\\ICONS\\INV_MISC_NOTE_06");
	TRP2_NPCAnimFrameOngletCrierIcon:SetTexture("Interface\\ICONS\\Ability_Warrior_WarCry");
	TRP2_NPCAnimFrameOngletChuchotterIcon:SetTexture("Interface\\ICONS\\Spell_Holy_Silence");
	-- Position de l'icone minimap
	TRP2_IconePosition();
	TRP2_SetTargetEtatPosition();
	-- Popup statique
	TRP_InitialiseStaticPopup();
	-- Tooltip
	GameTooltip:SetScript("OnTooltipSetAchievement",function() TRP2_PersoTooltip:Hide(); end);
	GameTooltip:SetScript("OnTooltipSetSpell",function() TRP2_PersoTooltip:Hide(); end);

	TRP2_SetMouseWheel(TRP2_CreationFrameDocumentFrameListePage,TRP2_CreationFrameDocumentFrameListePageSlider);
	TRP2_SetMouseWheel(TRP2_CreationFrameDocumentFramePageMainListeElem,TRP2_CreationFrameDocumentFramePageMainListeElemSlider);
	TRP2_SetMouseWheel(TRP2MainFrameQuestsLogListe,TRP2MainFrameQuestsLogListeSlider);
	TRP2_SetMouseWheel(TRP2MainFrameRegistreListe,TRP2MainFrameRegistreListeCadreListeButtonSlider);
	TRP2_SetMouseWheel(TRP2_ListeSmall,TRP2_ListeSmallSlider);
	TRP2_SetMouseWheel(TRP2_ListeSound,TRP2_ListeSoundSlider);
	TRP2_SetMouseWheel(TRP2_ListeSoundFav,TRP2_ListeSoundFavSlider);
	TRP2_SetMouseWheel(TRP2_CreationFrameBaseListeObjet,TRP2_CreationFrameBaseListeObjetSlider);
	TRP2_SetMouseWheel(TRP2_CreationFrameBaseListeAura,TRP2_CreationFrameBaseListeAuraSlider);
	TRP2_SetMouseWheel(TRP2_CreationFrameBaseListeDocument,TRP2_CreationFrameBaseListeDocumentSlider);
	TRP2_SetMouseWheel(TRP2_CreationFrameBaseListeLangage,TRP2_CreationFrameBaseListeLangageSlider);
	TRP2_SetMouseWheel(TRP2_CreationFrameBaseListePackages,TRP2_CreationFrameBaseListePackagesSlider);
	TRP2_SetMouseWheel(TRP2_CreationFrameQuestFrameListeAction,TRP2_CreationFrameQuestFrameListeActionSlider);
	TRP2_SetMouseWheel(TRP2_CreationFrameQuestFrameListeEtape,TRP2_CreationFrameQuestFrameListeEtapeSlider);
	TRP2_SetMouseWheel(TRP2_TriggerEditFrameEffet,TRP2_TriggerEditFrameEffetSlider);
	TRP2_SetMouseWheel(TRP2_TriggerEditFrameCondition,TRP2_TriggerEditFrameConditionSlider);
	TRP2_SetMouseWheel(TRP2MainFrameFicheJoueurPetsListe,TRP2MainFrameFicheJoueurPetsListeCadreListeButtonSlider);
	TRP2_SetMouseWheel(TRP2_OpenedPackage,TRP2_OpenedPackageSlider);
	TRP2_SetMouseWheel(TRP2_StateImportList,TRP2_StateImportListSlider);

	TRP2_SetMouseWheel(TRP2_CreationFrameBaseListeEvent,TRP2_CreationFrameBaseListeEventSlider);
	-- Construction de la config
	TRP2_ConstructConfigFrames();
	-- Construction de la creation
	TRP2_InitUICreation();
	--Initialisation des variable de playlist
	if not TRP2_Module_Interface then
		TRP2_Module_Interface = {};
	end
	if not TRP2_Module_Interface["BannedID"] then
		TRP2_Module_Interface["BannedID"] = {};
	end
	if not TRP2_Module_Interface["AnyID"] then
		TRP2_Module_Interface["AnyID"] = {};
	end
	if not TRP2_Module_Interface["SoundPlaylist"] then
		TRP2_Module_Interface["SoundPlaylist"] = {};
		TRP2_Module_Interface["SoundPlaylist"]["ActualPlaylist"] = 1;
		TRP2_Module_Interface["SoundPlaylist"]["Playlist"] = {{},{},{},{},{}};
	end
	if not TRP2_Module_Interface["HudButton"] then
		TRP2_Module_Interface["HudButton"] = {};
	end
	if not TRP2_Module_Interface["History"] then
		TRP2_Module_Interface["History"] = {};
	end
	
	if not IsAddOnLoaded("totalRP2_Guide") and not IsAddOnLoaded("totalRP2_Guide_En") then
		TRP2MainFrameMenuBarOngletGuide:Disable();
		TRP2MainFrameMenuBarOngletGuideIcon:SetDesaturated(true);
	end
	
	TRP2_InitHudButton();
	--Hooking
	TRP2_HookAll();
	if not TRP2_GetConfigValueFor("RaccBarShow",true) then
		TRP2_RaccBar:Hide();
	end
	TRP2_RaccBar:SetAlpha(TRP2_GetConfigValueFor("RaccBarAlpha",100)/100);
	
	-- SimpleHTML
	TRP2_FicheJoueurPhysiqueBox:SetFontObject("h1",GameFontNormalHuge);
	TRP2_FicheJoueurPhysiqueBox:SetFontObject("h2",GameFontNormalLarge);
	TRP2_FicheJoueurPhysiqueBox:SetFontObject("h3",GameFontNormal);
	TRP2_FicheJoueurPhysiqueBox:SetTextColor("h1",1,1,1);
	TRP2_FicheJoueurPhysiqueBox:SetTextColor("h2",1,1,1);
	TRP2_FicheJoueurPhysiqueBox:SetTextColor("h3",1,1,1);
	TRP2_FicheJoueurHistoireBox:SetFontObject("h1",GameFontNormalHuge);
	TRP2_FicheJoueurHistoireBox:SetFontObject("h2",GameFontNormalLarge);
	TRP2_FicheJoueurHistoireBox:SetFontObject("h3",GameFontNormal);
	TRP2_FicheJoueurHistoireBox:SetTextColor("h1",1,1,1);
	TRP2_FicheJoueurHistoireBox:SetTextColor("h2",1,1,1);
	TRP2_FicheJoueurHistoireBox:SetTextColor("h3",1,1,1);
	
	TRP2_GuideFrameTexteA:SetFont("h1","Fonts\\FRIZQT__.ttf", 21);
	TRP2_GuideFrameTexteA:SetFont("h2","Fonts\\FRIZQT__.ttf", 17);
	TRP2_GuideFrameTexteA:SetFont("h3","Fonts\\FRIZQT__.ttf", 13);
	TRP2_GuideFrameTexteA:SetFont("Fonts\\FRIZQT__.TTF",11);
	TRP2_GuideFrameTexteA:SetTextColor(1,1,1);
	TRP2_GuideFrameTexteA:SetTextColor("h1",1,0.65,0);
	TRP2_GuideFrameTexteA:SetTextColor("h2",1,0.75,0);
	TRP2_GuideFrameTexteA:SetTextColor("h3",1,0.85,0);
	TRP2_GuideFrameTexteA:SetShadowColor(0,0,0);
	TRP2_GuideFrameTexteA:SetShadowOffset(1,-1);
	TRP2_GuideFrameTexteA:SetShadowColor("h1",0,0,0);
	TRP2_GuideFrameTexteA:SetShadowOffset("h1",1,-1);
	TRP2_GuideFrameTexteA:SetShadowColor("h2",0,0,0);
	TRP2_GuideFrameTexteA:SetShadowOffset("h2",1,-1);
	TRP2_GuideFrameTexteA:SetShadowColor("h3",0,0,0);
	TRP2_GuideFrameTexteA:SetShadowOffset("h3",1,-1);
	
	TRP2_GuideFrameTexteB:SetFont("h1","Fonts\\FRIZQT__.ttf", 21);
	TRP2_GuideFrameTexteB:SetFont("h2","Fonts\\FRIZQT__.ttf", 17);
	TRP2_GuideFrameTexteB:SetFont("h3","Fonts\\FRIZQT__.ttf", 13);
	TRP2_GuideFrameTexteB:SetFont("Fonts\\FRIZQT__.TTF",11);
	TRP2_GuideFrameTexteB:SetTextColor(1,1,1);
	TRP2_GuideFrameTexteB:SetTextColor("h1",1,0.65,0);
	TRP2_GuideFrameTexteB:SetTextColor("h2",1,0.75,0);
	TRP2_GuideFrameTexteB:SetTextColor("h3",1,0.85,0);
	TRP2_GuideFrameTexteB:SetShadowColor(0,0,0);
	TRP2_GuideFrameTexteB:SetShadowOffset(1,-1);
	TRP2_GuideFrameTexteB:SetShadowColor("h1",0,0,0);
	TRP2_GuideFrameTexteB:SetShadowOffset("h1",1,-1);
	TRP2_GuideFrameTexteB:SetShadowColor("h2",0,0,0);
	TRP2_GuideFrameTexteB:SetShadowOffset("h2",1,-1);
	TRP2_GuideFrameTexteB:SetShadowColor("h3",0,0,0);
	TRP2_GuideFrameTexteB:SetShadowOffset("h3",1,-1);
	
	TRP2_FicheJoueurActuNotesApercu:Hide();
	TRP2_FicheJoueurActuActuApercu:Hide();
	TRP2_FicheJoueurActuHRPApercu:Hide();
	TRP2_CreationPlanqueFrameAccessNomsApercu:Hide();
	TRP2_CreationPanneauFrameAccessNomsApercu:Hide();
	TRP2_OpenedPackageRecherche:Hide();
	
	TRP2_PanelJoueurNomComplet:SetNonSpaceWrap(true);
	TRP2_PanelJoueurTitreComplet:SetNonSpaceWrap(true);
	TRP2_FicheJoueurConsulteInfoBase:SetNonSpaceWrap(true);
	TRP2_FicheJoueurConsulteInfoPhysique:SetNonSpaceWrap(true);
	TRP2_FicheJoueurConsulteInfoVisage:SetNonSpaceWrap(true);
	TRP2_PetsDescription:SetNonSpaceWrap(true);
	TRP2_NPCAnimFrameApercu:SetNonSpaceWrap(true);
	
	ChatFrame1EditBox:SetScript("OnShow",function()
		if IsControlKeyDown() then
			TRP2_AnimPersoShow(TRP2_NPCAnimFrame.Mode);
			TRP2_NPCAnimFrameScrollScrollEditBox:SetFocus();
			ChatFrame1EditBox:Hide();
		else
			ChatEdit_OnShow(ChatFrame1EditBox);
		end
	end);
	GossipFrame:SetScript("OnEvent",TRP2_GossipFrame_OnEvent);
	
	TRP2_FicheJoueurPrenomSaisie.tabulation = TRP2_FicheJoueurNomSaisie;
	TRP2_FicheJoueurNomSaisie.tabulation = TRP2_FicheJoueurTitreSaisie;
	TRP2_FicheJoueurTitreSaisie.tabulation = TRP2_FicheJoueurTitreCompletSaisie;
	TRP2_FicheJoueurTitreCompletSaisie.tabulation = TRP2_FicheJoueurAgeSaisie;
	TRP2_FicheJoueurAgeSaisie.tabulation = TRP2_FicheJoueurOrigineSaisie;
	TRP2_FicheJoueurOrigineSaisie.tabulation = TRP2_FicheJoueurHabitationSaisie;
	TRP2_FicheJoueurHabitationSaisie.tabulation = TRP2_FicheJoueurRaceSaisie;
	TRP2_FicheJoueurRaceSaisie.tabulation = TRP2_FicheJoueurClassSaisie;
	TRP2_FicheJoueurClassSaisie.tabulation = TRP2_FicheJoueurTraitSaisie;
	TRP2_FicheJoueurTraitSaisie.tabulation = TRP2_FicheJoueurYeuxSaisie;
	TRP2_FicheJoueurYeuxSaisie.tabulation = TRP2_FicheJoueurPiercingSaisie;
	TRP2_FicheJoueurPiercingSaisie.tabulation = TRP2_FicheJoueurPrenomSaisie;
	
	TRP2_ListeSmallDropDownCategorieValeur:SetText(TRP2_Auras_Categorie[1]);
	TRP2_ListeSmallDropDownCategorie.Value = 1; 
	
	TRP2_MagasinFrameReputSurFond:SetTexture(0,0,0);
end

function TRP2_DD_AuraCategory(frame,level,menuList)
	UIDropDownMenu_SetWidth(frame, 50);
	UIDropDownMenu_SetButtonWidth(frame, 15);
	info = TRP2_CreateSimpleDDButton();
	info.text = CATEGORY;
	info.func = function() end;
	info.isTitle = true;
	UIDropDownMenu_AddButton(info);

	local i;
	for i=1,#TRP2_Auras_Categorie,1 do
		info = TRP2_CreateSimpleDDButton();
		if TRP2_ListeSmallDropDownCategorie.Value == i then
			info.text = TRP2_Auras_Categorie[i];
			info.checked = true;
			info.disabled = true;
		else
			info.text = TRP2_Auras_Categorie[i];
		end
		info.func = function() 
			TRP2_ListeSmallDropDownCategorie.Value = i;
			TRP2_ListeSmallDropDownCategorieValeur:SetText(TRP2_Auras_Categorie[i]);
			TRP2_SetListFor(TRP2_ListeSmall.listType,nil,true,TRP2_ListeSmall.arg1,TRP2_ListeSmall.arg2,TRP2_ListeSmall.arg3,true);
		end;
		UIDropDownMenu_AddButton(info,level);
	end
	info = TRP2_CreateSimpleDDButton();
	info.text = CANCEL;
	UIDropDownMenu_AddButton(info,level);
end

function TRP2_NPCAnimSelectFrameOnShow(self)
	TRP2_NPCAnimSelectFrameModele:SetUnit("player");
	TRP2_NPCAnimSelectFrameSequence:SetText(1);
end

function TRP2_SetTargetIconPosition()
	TRP2_TargetButton:ClearAllPoints();
	local frame = TargetFrame;
	if getglobal(TRP2_GetConfigValueFor("TargetIconFrame")) then
		frame = getglobal(TRP2_GetConfigValueFor("TargetIconFrame"));
	end
	TRP2_TargetButton:SetParent(frame);
	TRP2_TargetButton:SetPoint("Center",frame,"center",TRP2_GetConfigValueFor("TargetIconX",65)-200,TRP2_GetConfigValueFor("TargetIconY",210)-200);
end

function TRP2_PlacerIconeCible(nom)
	if UnitIsPlayer("target") then
		local nom, royaume  = UnitName("target");
		if royaume then
			nom = nom.."-"..royaume;
		end
		TRP2_AuraTargetFrame.master = nil;
		if nom == TRP2_Joueur then
			SetPortraitToTexture(TRP2_TargetButtonIcon,"Interface\\ICONS\\INV_Misc_GroupLooking");
			TRP2_SetTooltipForFrame(TRP2_TargetButton,TRP2_TargetButton,"BOTTOMRIGHT",10,0,
				"{v}"..TRP2_nomComplet(nom,true));
			TRP2_TargetButton:SetScript("OnClick",function()
				TRP2CHATNAME = nil;
				TRP2_InitUIDropDown(TRP2_DD_PotraitIconeClick);
			end);
			TRP2_AuraTargetFrame.target = TRP2_Joueur;
			TRP2_UpdateAuraTargetFrame();
			TRP2_AuraTargetFrame:Show();
		elseif TRP2_EstDansLeReg(nom) then
			SetPortraitToTexture(TRP2_TargetButtonIcon,string.gsub(TRP2_relation_texture[TRP2_GetRelation(nom,TRP2_Joueur)],"%.blp",""));
			TRP2_SetTooltipForFrame(TRP2_TargetButton,TRP2_TargetButton,"BOTTOMRIGHT",10,0,
				"{v}"..TRP2_nomComplet(nom,true));
			TRP2_TargetButton:SetScript("OnClick",function()
				TRP2CHATNAME = nil;
				TRP2_InitUIDropDown(TRP2_DD_PotraitIconeClick);
			end);
			TRP2_AuraTargetFrame.target = nom;
			TRP2_UpdateAuraTargetFrame();
			TRP2_AuraTargetFrame:Show();
		else
			SetPortraitToTexture(TRP2_TargetButtonIcon,"Interface\\ICONS\\INV_Misc_GroupNeedMore");
			TRP2_SetTooltipForFrame(TRP2_TargetButton,TRP2_TargetButton,"BOTTOMRIGHT",10,0,
				"{v}"..TRP2_nomComplet(nom,true));
			TRP2_TargetButton:SetScript("OnClick",function()
				TRP2CHATNAME = nil;
				TRP2_InitUIDropDown(TRP2_DD_PotraitIconeClick);
			end);
			TRP2_AuraTargetFrame.target = nil;
		end
		if TRP2_GetWithDefaut(TRP2_GetInfo(nom,"Actu",{}),"PlayerIcon") and TRP2_GetConfigValueFor("UsePlayerIcon",true) then
			retOK, ret1 = pcall (SetPortraitToTexture, TargetFramePortrait, "Interface\\ICONS\\"..TRP2_GetWithDefaut(TRP2_GetInfo(nom,"Actu",{}),"PlayerIcon"));
			if retOK then
				else
					TargetFramePortrait:SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(TRP2_GetInfo(nom,"Actu",{}),"PlayerIcon"));
			end
		end
		TRP2_SetTargetIconPosition();
		TRP2_TargetButton:Show();
	elseif TRP2_PNJTAB and TRP2_PNJTAB[nom] then -- Magasin
		SetPortraitToTexture(TRP2_TargetButtonIcon,"Interface\\ICONS\\"..TRP2_GetWithDefaut(TRP2_PNJTAB[nom],"Icone","Temp"));
		TRP2_SetTooltipForFrame(TRP2_TargetButton,TRP2_TargetButton,"BOTTOM",0,-5,
					"{v}"..TRP2_GetWithDefaut(TRP2_PNJTAB[nom],"NomMagasin",TRP2_LOC_MAG_Boutik),
					"{j}"..TRP2_LOC_CLIC.." {w}: "..TRP2_LOC_MAG_BoutikVisit);
		TRP2_SetTargetIconPosition();
		TRP2_TargetButton:Show();
		TRP2_TargetButton:SetScript("OnClick",function()
			TRP2_SetListeMagasin(nom);
		end);
	else
		local nomPet, maitre = TRP2_RecupTTInfo();
		if nomPet and maitre then
			local petTab = TRP2_GetInfo(maitre,"Pets",{});
			if petTab[nomPet] or maitre == TRP2_Joueur then
				TRP2_SetTooltipForFrame(TRP2_TargetButton,TRP2_TargetButton,"BOTTOMRIGHT",10,0,
					"{v}"..nomPet,
					"{o}< "..TRP2_FT(TRP2_LOC_PEtMaster,maitre).." >\n{j}"..TRP2_LOC_CLIC.." {w}: "..TRP2_LOC_PEtMasterShow);
				SetPortraitTexture(TRP2_TargetButtonIcon,"target");
				TRP2_SetTargetIconPosition();
				TRP2_TargetButton:Show();
				TRP2_TargetButton:SetScript("OnClick",function()
					TRP2_OpenPanel("Fiche","Pets","ConsultePet",nomPet,maitre);
				end);
			end
			TRP2_AuraTargetFrame.master = maitre;
			TRP2_AuraTargetFrame.target = nomPet;
			TRP2_UpdateAuraTargetFrame();
			TRP2_AuraTargetFrame:Show();
		end
	end
end

function TRP2_SetListFor(listType,anchorFrame,noAnchor,arg1,arg2,arg3,Search)
	if not noAnchor then
		if anchorFrame then
			TRP2_ListeSmall:ClearAllPoints();
			TRP2_ListeSmall:SetParent(anchorFrame);
			TRP2_ListeSmall:SetFrameStrata("FULLSCREEN");
			TRP2_ListeSmall:SetPoint("CENTER",anchorFrame,"CENTER",0, 0);
		else
			TRP2_ListeSmall:ClearAllPoints();
			TRP2_ListeSmall:SetParent(TRP2MainFrame);
			TRP2_ListeSmall:SetFrameStrata("FULLSCREEN");
			TRP2_ListeSmall:SetPoint("LEFT",TRP2MainFrame,"RIGHT",-5, -5);
		end
	end
	if not Search then
		TRP2_ListeSmallRecherche:SetText("");
	end
	TRP2_ListeSmallURLBox:Hide();
	TRP2_ListeSmall:Show();
	local i = 0; -- Nombre total
	local j = 0; -- Nombre pris
	local search = TRP2_EmptyToNil(TRP2_ListeSmallRecherche:GetText());
	if search and TRP2_ApplyPattern("meuh.",search) == nil then
		search = nil;
	end
	TRP2_ListeSmallSlider:Hide();
	TRP2_ListeSmallSlider:SetValue(0);
	wipe(TRP2_GeneralListTab);
	local aucun="";
	local titre="";
	
	TRP2_ListeSmallCheckDatabase:Hide();
	TRP2_ListeSmallCheckOther:Hide();
	TRP2_ListeSmallDropDownCategorie:Hide();
	
	if listType == "courrSend" then
		titre = TRP2_LOC_OUTBOX;
		aucun = TRP2_LOC_NOCOURR;
		for letter,_ in pairs(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["OutBox"]) do
			i = i+1;
			j = j + 1;
			TRP2_GeneralListTab[j] = letter;
		end
	elseif listType == "courrReceiv" then
		titre = TRP2_LOC_INBOX;
		aucun = TRP2_LOC_NOCOURR;
		for letter,_ in pairs(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["InBox"]) do
			i = i+1;
			j = j + 1;
			TRP2_GeneralListTab[j] = letter;
		end
	elseif listType == "mascotte" then
		titre = PETS;
		aucun = TRP2_LOC_NoPet;
		for i=1,GetNumCompanions("CRITTER") do
			local creatureID, creatureName,_,icon = GetCompanionInfo("CRITTER", i);
			i = i+1;
			if not search or TRP2_ApplyPattern(creatureName,search) then
				j = j + 1;
				TRP2_GeneralListTab[creatureName] = icon;
			end
		end
		for i=1,GetNumCompanions("MOUNT") do
			local creatureID, creatureName,_,icon = GetCompanionInfo("MOUNT", i);
			i = i+1;
			if not search or TRP2_ApplyPattern(creatureName,search) then
				j = j + 1;
				TRP2_GeneralListTab[creatureName] = icon;
			end
		end
	elseif listType == "icones" then
		titre = TRP2_LOC_LIST_ICON;
		aucun = TRP2_LOC_NO_ICON;
		table.foreach(ListeIconeTab,function(iconNum)
			i = i+1;
			if not search or TRP2_ApplyPattern(ListeIconeTab[iconNum],search) then
				j = j + 1;
				TRP2_GeneralListTab[j] = iconNum;
			end
		end);
	elseif listType == "langage" then
		titre = TRP2_LOC_LanguesListe;
		aucun = TRP2_LOC_NODIALECTES;
		TRP2_ListeSmallCheckDatabase:Show();
		TRP2_ListeSmallCheckOther:Show();
		if TRP2_ListeSmallCheckDatabase:GetChecked() and TRP2_DB_Languages then
			for LangueID,LangueTab in pairs(TRP2_DB_Languages) do
				if UnitFactionGroup("player") --[[~= TRP2_GetWithDefaut(LangueTab,"Faction")]] and not TRP2_GetWithDefaut(LangueTab,"bNotInList")--Editted by Lixxel (So you can learn your own faction languages.)
				and (not LangueTab["Locale"] or string.find(LangueTab["Locale"],string.sub(GetLocale(),1,2))) then
					i = i+1;
					if (not search or TRP2_ApplyPattern(TRP2_GetWithDefaut(LangueTab,"Nom",TRP2_LOC_NewAura),search)) then
						j = j + 1;
						TRP2_GeneralListTab[j] = LangueID;
					end
				end
			end;
		end
		table.foreach(TRP2_Module_Language,function(LangueID)
			i = i+1;
			if (TRP2_Module_Language[LangueID]["Createur"] == TRP2_Joueur or TRP2_ListeSmallCheckOther:GetChecked()) and 
			(not search or TRP2_ApplyPattern(TRP2_GetWithDefaut(TRP2_Module_Language[LangueID],"Nom",TRP2_LOC_NewAura),search)) then
				j = j + 1;
				TRP2_GeneralListTab[j] = LangueID;
			end
		end);
		table.sort(TRP2_GeneralListTab);
	elseif listType == "auras" or listType == "auraspet" then
		titre = TRP2_LOC_LIST_AURAS;
		aucun = TRP2_LOC_NO_AURAS;
		TRP2_ListeSmallDropDownCategorieButton:SetScript("OnClick",function(self)
			TRP2_InitUIDropDown(TRP2_DD_AuraCategory,self,-110,0);
		end);
		TRP2_ListeSmallDropDownCategorie:Show();
		TRP2_ListeSmallCheckDatabase:Show();
		TRP2_ListeSmallCheckOther:Show();
		if TRP2_ListeSmallCheckDatabase:GetChecked() and TRP2_DB_Auras then
			table.foreach(TRP2_DB_Auras,function(auraID)
				i = i+1;
				if TRP2_ListeSmallDropDownCategorie.Value == 1 or TRP2_ListeSmallDropDownCategorie.Value == tonumber(TRP2_GetWithDefaut(TRP2_DB_Auras[auraID],"EtatCat",2)) then
					if TRP2_GetWithDefaut(TRP2_DB_Auras[auraID],"bAjout",true) then
						if not search or TRP2_ApplyPattern(TRP2_GetWithDefaut(TRP2_DB_Auras[auraID],"Nom",TRP2_LOC_NewAura),search) then
							j = j + 1;
							TRP2_GeneralListTab[j] = auraID;
						end
					end
				end
			end);
		end
		table.foreach(TRP2_Module_Auras,function(auraID)
			i = i+1;
			if TRP2_ListeSmallDropDownCategorie.Value == 1 or TRP2_ListeSmallDropDownCategorie.Value == tonumber(TRP2_GetWithDefaut(TRP2_Module_Auras[auraID],"EtatCat",2)) then
				if (TRP2_Module_Auras[auraID]["Createur"] == TRP2_Joueur or TRP2_ListeSmallCheckOther:GetChecked()) and TRP2_GetWithDefaut(TRP2_Module_Auras[auraID],"bAjout",true) then
					if not search or TRP2_ApplyPattern(TRP2_GetWithDefaut(TRP2_Module_Auras[auraID],"Nom",TRP2_LOC_NewAura),search) then
						j = j + 1;
						TRP2_GeneralListTab[j] = auraID;
					end
				end
			end
		end);
		table.sort(TRP2_GeneralListTab);
	elseif listType == "aurasID" then
		titre = TRP2_LOC_LIST_AURAS;
		aucun = TRP2_LOC_NO_AURAS;
		TRP2_ListeSmallDropDownCategorieButton:SetScript("OnClick",function(self)
			TRP2_InitUIDropDown(TRP2_DD_AuraCategory,self,-110,0);
		end);
		TRP2_ListeSmallCheckDatabase:Show();
		TRP2_ListeSmallDropDownCategorie:Show();
		TRP2_ListeSmallCheckOther:Show();
		if TRP2_ListeSmallCheckDatabase:GetChecked() and TRP2_DB_Auras then
			table.foreach(TRP2_DB_Auras,function(auraID)
				i = i+1;
				if TRP2_ListeSmallDropDownCategorie.Value == 1 or TRP2_ListeSmallDropDownCategorie.Value == tonumber(TRP2_GetWithDefaut(TRP2_DB_Auras[auraID],"EtatCat",2)) then
					if not search or TRP2_ApplyPattern(TRP2_GetWithDefaut(TRP2_DB_Auras[auraID],"Nom",TRP2_LOC_NewAura),search) then
						j = j + 1;
						TRP2_GeneralListTab[j] = auraID;
					end
				end
			end);
		end
		table.foreach(TRP2_Module_Auras,function(auraID)
			i = i+1;
			if TRP2_ListeSmallDropDownCategorie.Value == 1 or TRP2_ListeSmallDropDownCategorie.Value == tonumber(TRP2_GetWithDefaut(TRP2_Module_Auras[auraID],"EtatCat",2)) then
				if (TRP2_Module_Auras[auraID]["Createur"] == TRP2_Joueur or TRP2_ListeSmallCheckOther:GetChecked()) and
				(not search or TRP2_ApplyPattern(TRP2_GetWithDefaut(TRP2_Module_Auras[auraID],"Nom",TRP2_LOC_NewAura),search)) then
					j = j + 1;
					TRP2_GeneralListTab[j] = auraID;
				end
			end
		end);
		table.sort(TRP2_GeneralListTab);
	elseif listType == "objetID" then
		titre = TRP2_LOC_UI_ListeObjet;
		aucun = TRP2_LOC_UI_NoObjet;
		TRP2_ListeSmallCheckDatabase:Show();
		TRP2_ListeSmallCheckOther:Show();
		if TRP2_ListeSmallCheckDatabase:GetChecked() and TRP2_DB_Objects then
			table.foreach(TRP2_DB_Objects,function(objetID)
				i = i+1;
				if not search or TRP2_ApplyPattern(TRP2_GetWithDefaut(TRP2_DB_Objects[objetID],"Nom",TRP2_LOC_NEW_Objet),search)
					or 	TRP2_ApplyPattern(TRP2_GetWithDefaut(TRP2_DB_Objects[objetID],"Categorie",""),search) then
					j = j + 1;
					TRP2_GeneralListTab[j] = objetID;
				end
			end);
		end
		table.foreach(TRP2_Module_ObjetsPerso,function(objetID)
			i = i+1;
			if (TRP2_Module_ObjetsPerso[objetID]["Createur"] == TRP2_Joueur or TRP2_ListeSmallCheckOther:GetChecked()) and
			(not search or TRP2_ApplyPattern(TRP2_GetWithDefaut(TRP2_Module_ObjetsPerso[objetID],"Nom",TRP2_LOC_NEW_Objet),search) 
				or 	TRP2_ApplyPattern(TRP2_GetWithDefaut(TRP2_Module_ObjetsPerso[objetID],"Categorie",""),search)) then
				j = j + 1;
				TRP2_GeneralListTab[j] = objetID;
			end
		end);
		table.sort(TRP2_GeneralListTab);
	elseif listType == "quests" then
		titre = TRP2_LOC_UI_ListeQuest;
		aucun = TRP2_LOC_NoQuest;
		TRP2_ListeSmallCheckDatabase:Show();
		TRP2_ListeSmallCheckOther:Show();
		if TRP2_ListeSmallCheckDatabase:GetChecked() and TRP2_DB_Objects then
			table.foreach(TRP2_DB_Quests,function(questID)
				i = i+1;
				if (not search or TRP2_ApplyPattern(TRP2_GetWithDefaut(TRP2_DB_Quests[questID],"Nom",TRP2_LOC_NEWQUEST),search))
				and TRP2_GetWithDefaut(TRP2_DB_Quests[questID],"bManual",true) then
					j = j + 1;
					TRP2_GeneralListTab[j] = questID;
				end
			end);
		end
		table.foreach(TRP2_Module_Quests,function(questID)
			i = i+1;
			if (TRP2_Module_Quests[questID]["Createur"] == TRP2_Joueur or TRP2_ListeSmallCheckOther:GetChecked()) and
			(not search or TRP2_ApplyPattern(TRP2_GetWithDefaut(TRP2_Module_Quests[questID],"Nom",TRP2_LOC_NEWQUEST),search))
				and TRP2_GetWithDefaut(TRP2_Module_Quests[questID],"bManual",true) then
				j = j + 1;
				TRP2_GeneralListTab[j] = questID;
			end
		end);
		table.sort(TRP2_GeneralListTab);
	elseif listType == "questsID" then
		titre = TRP2_LOC_UI_ListeQuest;
		aucun = TRP2_LOC_NoQuest;
		TRP2_ListeSmallCheckDatabase:Show();
		TRP2_ListeSmallCheckOther:Show();
		if TRP2_ListeSmallCheckDatabase:GetChecked() and TRP2_DB_Objects then
			table.foreach(TRP2_DB_Quests,function(questID)
				i = i+1;
				if not search or TRP2_ApplyPattern(TRP2_GetWithDefaut(TRP2_DB_Quests[questID],"Nom",TRP2_LOC_NEWQUEST),search) then
					j = j + 1;
					TRP2_GeneralListTab[j] = questID;
				end
			end);
		end
		table.foreach(TRP2_Module_Quests,function(questID)
			i = i+1;
			if (TRP2_Module_Quests[questID]["Createur"] == TRP2_Joueur or TRP2_ListeSmallCheckOther:GetChecked()) and
			(not search or TRP2_ApplyPattern(TRP2_GetWithDefaut(TRP2_Module_Quests[questID],"Nom",TRP2_LOC_NEWQUEST),search)) then
				j = j + 1;
				TRP2_GeneralListTab[j] = questID;
			end
		end);
		table.sort(TRP2_GeneralListTab);
	elseif listType == "docuID" then
		titre = TRP2_LOC_UI_ListeDocu;
		aucun = TRP2_LOC_NoDoc;
		TRP2_ListeSmallCheckDatabase:Show();
		TRP2_ListeSmallCheckOther:Show();
		if TRP2_ListeSmallCheckDatabase:GetChecked() and TRP2_DB_Documents then
			table.foreach(TRP2_DB_Documents,function(ID)
				i = i+1;
				if not search or TRP2_ApplyPattern(TRP2_GetWithDefaut(TRP2_DB_Documents[ID],"Nom",TRP2_LOC_NEWDOCU),search) then
					j = j + 1;
					TRP2_GeneralListTab[j] = ID;
				end
			end);
		end
		table.foreach(TRP2_Module_Documents,function(ID)
			i = i+1;
			if (TRP2_Module_Documents[ID]["Createur"] == TRP2_Joueur or TRP2_ListeSmallCheckOther:GetChecked()) and
			(not search or TRP2_ApplyPattern(TRP2_GetWithDefaut(TRP2_Module_Documents[ID],"Nom",TRP2_LOC_NEWDOCU),search)) then
				j = j + 1;
				TRP2_GeneralListTab[j] = ID;
			end
		end);
		table.sort(TRP2_GeneralListTab);
	elseif listType == "langID" then
		titre = TRP2_LOC_UI_ListeDial;
		aucun = TRP2_LOC_UI_NoDial;
		TRP2_ListeSmallCheckDatabase:Show();
		TRP2_ListeSmallCheckOther:Show();
		if TRP2_ListeSmallCheckDatabase:GetChecked() and TRP2_DB_Languages then
			for ID,LangueTab in pairs(TRP2_DB_Languages) do
				if not TRP2_GetWithDefaut(LangueTab,"bNotInList") and (not LangueTab["Locale"] or string.find(LangueTab["Locale"],string.sub(GetLocale(),1,2))) then
					i = i+1;
					if not search or TRP2_ApplyPattern(TRP2_GetWithDefaut(LangueTab,"Entete",TRP2_LOC_NEWDIALECTE),search) then
						j = j + 1;
						TRP2_GeneralListTab[j] = ID;
					end
				end
			end;
		end
		table.foreach(TRP2_Module_Language,function(ID)
			i = i+1;
			if (TRP2_Module_Language[ID]["Createur"] == TRP2_Joueur or TRP2_ListeSmallCheckOther:GetChecked()) and
			(not search or TRP2_ApplyPattern(TRP2_GetWithDefaut(TRP2_Module_Language[ID],"Entete",TRP2_LOC_NEWDIALECTE),search)) then
				j = j + 1;
				TRP2_GeneralListTab[j] = ID;
			end
		end);
		table.sort(TRP2_GeneralListTab);
	elseif listType == "sounds" then
		titre = TRP2_LOC_UI_ListeSon;
		table.foreach(TRP2_LISTE_SOUNDS,function(soundNum)
			i = i+1;
			if not search or TRP2_ApplyPattern(TRP2_LISTE_SOUNDS[soundNum],search) then
				j = j + 1;
				TRP2_GeneralListTab[j] = soundNum;
			end
		end);
	elseif listType == "valeurs" then
		titre = TRP2_LOC_UI_ListeValeur;
		local triTab = {};
		table.foreach(TRP2_LISTE_VALEURS,function(valeur)
			i = i+1;
			if not search or TRP2_ApplyPattern(TRP2_LISTE_VALEURS[valeur]["Titre"],search) then
				if not arg2 or TRP2_LISTE_VALEURS[valeur]["bNumeric"] then
					j = j + 1;
					triTab[j] = TRP2_LISTE_VALEURS[valeur]["Titre"];
				end
			end
		end);
		-- Un vilain O(n²) mais je vois pas d'autre solution ...
		table.sort(triTab);
		for k,v in pairs(triTab) do
			for l,o in pairs(TRP2_LISTE_VALEURS) do
				if o["Titre"] == v then
					TRP2_GeneralListTab[k] = l;
				end
			end
		end
	elseif listType == "effets" then
		titre = TRP2_LOC_UI_ListeEffet;
		local triTab = {};
		table.foreach(TRP2_LISTE_EFFETS,function(valeur)
			i = i+1;
			if not search or TRP2_ApplyPattern(TRP2_LISTE_EFFETS[valeur]["Titre"],search) then
				j = j + 1;
				triTab[j] = TRP2_LISTE_EFFETS[valeur]["Titre"];
			end
		end);
		-- Un vilain O(n²) mais je vois pas d'autre solution ...
		table.sort(triTab);
		for k,v in pairs(triTab) do
			for l,o in pairs(TRP2_LISTE_EFFETS) do
				if o["Titre"] == v then
					TRP2_GeneralListTab[k] = l;
				end
			end
		end
	end

	TRP2_ListeSmall.listType = listType;
	TRP2_ListeSmall.arg1 = arg1;
	TRP2_ListeSmall.arg2 = arg2;
	TRP2_ListeSmall.arg3 = arg3;

	if j > 0 then
		TRP2_ListeSmallEmpty:SetText("");
	elseif i == 0 then
		TRP2_ListeSmallEmpty:SetText(aucun);
	else
		TRP2_ListeSmallEmpty:SetText(TRP2_LOC_SelectVide);
	end
	if j > 49 then
		TRP2_ListeSmallSlider:Show();
		local total = floor((j-1)/49);
		TRP2_ListeSmallSlider:SetMinMaxValues(0,total);
	end
	TRP2_ListeSmallSlider:SetScript("OnValueChanged",function(self)
		if self:IsVisible() then
			TRP2_LoadListePage(self:GetValue());
		end
	end)
	TRP2_ListeSmallRecherche:SetScript("OnTextChanged",function(self)
		if self:IsVisible() then
			TRP2_SetListFor(TRP2_ListeSmall.listType,TRP2_ListeSmall:GetParent(),true,TRP2_ListeSmall.arg1,TRP2_ListeSmall.arg2,TRP2_ListeSmall.arg3,true);
		end
	end)
	TRP2_ListeSmallTitre:SetText(titre.." ( "..j.." / "..i.." )");
	
	TRP2_LoadListePage(0);
end

function TRP2_LoadListePage(num)
	for k=1,49,1 do --Initialisation
		getglobal("TRP2_ListeSmallSlot"..k):Hide();
	end
	local i = 1;
	local j = 1;
	table.foreach(TRP2_GeneralListTab,
	function(TabIndex)
		if i > num*49 and i <= (num+1)*49 then
			local TabElement = TRP2_GeneralListTab[TabIndex];
			getglobal("TRP2_ListeSmallSlot"..j):Show();
			-- Mascotte
			if TRP2_ListeSmall.listType == "mascotte" then
				-- TabIndex == nom
				-- TabElement == icone
				getglobal("TRP2_ListeSmallSlot"..j.."Icon"):SetTexture(TabElement);
				getglobal("TRP2_ListeSmallSlot"..j):SetScript("OnClick", function(self,button)
					if TRP2_ListeSmall.arg1 then
						TRP2_ListeSmall.arg1:SetText(TabIndex);
					end
					TRP2_ListeSmall:Hide();
				end);
				TRP2_SetTooltipForFrame(
					getglobal("TRP2_ListeSmallSlot"..j),
					TRP2_ListeSmall,"TOPLEFT",0,0,
					"|T"..TabElement..":35:35|t "..TabIndex
				);
			-- Boite d'envoi
			elseif TRP2_ListeSmall.listType == "courrSend" then
				local tab = TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["OutBox"][TabElement];
				getglobal("TRP2_ListeSmallSlot"..j.."Icon"):SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(TRP2_GetObjectTab(tab["ID"]),"Icone","Temp"));
				getglobal("TRP2_ListeSmallSlot"..j):SetScript("OnClick", function(self,button)
					if button == "LeftButton" then
						TRP2_SendColis(TabElement);
					else
						StaticPopupDialogs["TRP2_CONFIRM_ACTION_NS"].text = TRP2_CTS(TRP2_ENTETE..TRP2_LOC_UI_DeleteColis);
						TRP2_ShowStaticPopup("TRP2_CONFIRM_ACTION_NS",TRP2_ListeSmall,function()
							TRP2_InvAddObjet(tab["ID"],"Sac",tab["Charges"],tab["Qte"],tab["Lifetime"],nil,true);
							wipe(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["OutBox"][TabElement])
							TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["OutBox"][TabElement] = nil;
							TRP2_SetListFor("courrSend",UIParent);
						end);
					end
				end);
				TRP2_SetTooltipForFrame(
					getglobal("TRP2_ListeSmallSlot"..j),
					TRP2_ListeSmall,"TOPLEFT",0,0,
					TRP2_ColisToString(tab,"Send")
				);
			elseif TRP2_ListeSmall.listType == "courrReceiv" then
				local tab = TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["InBox"][TabElement];
				getglobal("TRP2_ListeSmallSlot"..j.."Icon"):SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(TRP2_GetObjectTab(tab["ID"]),"Icone","Temp"));
				getglobal("TRP2_ListeSmallSlot"..j):SetScript("OnClick", function(self,button)
					if button == "LeftButton" then
						TRP2_InvAddObjet(tab["ID"],"Sac",tab["Charges"],tab["Qte"],tab["Lifetime"],nil,true);
						wipe(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["InBox"][TabElement])
						TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["InBox"][TabElement] = nil;
						TRP2_SetListFor("courrReceiv",UIParent);
					else
						StaticPopupDialogs["TRP2_CONFIRM_ACTION_NS"].text = TRP2_CTS(TRP2_ENTETE..TRP2_LOC_UI_Delete2Colis);
						TRP2_ShowStaticPopup("TRP2_CONFIRM_ACTION_NS",TRP2_ListeSmall,function()
							wipe(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["InBox"][TabElement]);
							TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["InBox"][TabElement] = nil;
							TRP2_SetListFor("courrReceiv",UIParent);
						end);
					end
				end);
				TRP2_SetTooltipForFrame(
					getglobal("TRP2_ListeSmallSlot"..j),
					TRP2_ListeSmall,"TOPLEFT",0,0,
					TRP2_ColisToString(tab)
				);
			-- ICONES
			elseif TRP2_ListeSmall.listType == "icones" then
				getglobal("TRP2_ListeSmallSlot"..j.."Icon"):SetTexture("Interface\\ICONS\\"..ListeIconeTab[TabElement]);
				getglobal("TRP2_ListeSmallSlot"..j):SetScript("OnClick", function()
					if IsShiftKeyDown() then
						TRP2_ListeSmallURLBox:Show();
						TRP2_ListeSmallURLBox:SetText(ListeIconeTab[TabElement]);
						return;
					end
					if TRP2_ListeSmall.arg1 and getglobal(TRP2_ListeSmall.arg1) then -- Arg1 == icone du bouton prenneur d'icone
						getglobal(TRP2_ListeSmall.arg1):SetTexture("Interface\\ICONS\\"..ListeIconeTab[TabElement]);
					end
					if TRP2_ListeSmall.arg2 and getglobal(TRP2_ListeSmall.arg2) then -- Arg2 == bouton prenneur d'icone
						getglobal(TRP2_ListeSmall.arg2).icone = ListeIconeTab[TabElement];
					end
					if TRP2_ListeSmall.arg3 then
						TRP2_PCall(TRP2_ListeSmall.arg3,getglobal(TRP2_ListeSmall.arg2));
					end
					TRP2_ListeSmall:Hide();
				end);
				TRP2_SetTooltipForFrame(
					getglobal("TRP2_ListeSmallSlot"..j),
					TRP2_ListeSmall,"TOPLEFT",0,0,
					"{w}|TInterface\\ICONS\\"..ListeIconeTab[TabElement]..":60:60|t",
					"{o}"..ListeIconeTab[TabElement].."\n{j}"..TRP2_LOC_CLIC.." : {w}"..TRP2_LOC_ICON_CHOIX.."\n{j}"..TRP2_LOC_CLICMAJ.." : {w}"..TRP2_LOC_AfficherNom
				);
			-- AURAS
			elseif TRP2_ListeSmall.listType == "auras" then
				local auraInfo = TRP2_GetAuraInfo(TabElement);
				getglobal("TRP2_ListeSmallSlot"..j.."Icon"):SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(auraInfo,"Icone","Temp"));
				getglobal("TRP2_ListeSmallSlot"..j):SetScript("OnClick", function()
					if TRP2_GetWithDefaut(auraInfo,"TimeSet",false) then
						StaticPopupDialogs["TRP2_ADD_AURA_TIME"].text = TRP2_CTS(TRP2_FT(TRP2_ENTETE..TRP2_LOC_AuraTimeDemand,TRP2_GetWithDefaut(auraInfo,"Nom",TRP2_LOC_NewAura),TRP2_Joueur));
						TRP2_ShowStaticPopup("TRP2_ADD_AURA_TIME",TRP2MainFrame,TRP2_Joueur,TabElement,nil,nil,true,TRP2_GetWithDefaut(auraInfo,"DureeDefaut",0));
					else
						TRP2_AddAura(TabElement,TRP2_GetWithDefaut(auraInfo,"DureeDefaut",0),true);
					end
					TRP2_ListeSmall:Hide();
				end);
				local descri = "";
				descri = descri.."{v}< "..TRP2_Auras_Categorie[TRP2_GetInt(tonumber(TRP2_GetWithDefaut(auraInfo,"EtatCat",2)))].." >\n";
				descri = descri.."{w}\"{o}"..TRP2_GetWithDefaut(auraInfo,"Description","").."{w}\"";
				descri = descri.."\n{j}Type : "..TRP2_LOC_AuraType[TRP2_GetInt(TRP2_GetWithDefaut(auraInfo,"Type",2))];
				if TRP2_GetWithDefaut(auraInfo,"DureeDefaut",0) ~= 0 then
					descri = descri.."\n{j}"..TRP2_LOC_DUREEDEF.." : {v}"..TRP2_TimeToString(TRP2_GetWithDefaut(auraInfo,"DureeDefaut",0));
				end
				if TRP2_GetWithDefaut(auraInfo,"TimeSet",false) then
					descri = descri.."\n{v}< "..TRP2_LOC_ChoixDuree.." >";
				end
				if not TRP2_GetWithDefaut(auraInfo,"bDeletable",true) then
					descri = descri.."\n{r}< "..TRP2_LOC_NoDelete.." >";
				end
				TRP2_SetTooltipForFrame(
					getglobal("TRP2_ListeSmallSlot"..j),
					TRP2_ListeSmall,"TOPLEFT",0,0,
					TRP2_Auras_Color[TRP2_GetInt(TRP2_GetWithDefaut(auraInfo,"Type",2))].."|TInterface\\ICONS\\"..TRP2_GetWithDefaut(auraInfo,"Icone","Temp")..":30:30|t\n"..TRP2_GetWithDefaut(auraInfo,"Nom",TRP2_LOC_NewAura),
					descri
				);
			-- AURA PET
			elseif TRP2_ListeSmall.listType == "auraspet" then
				local auraInfo = TRP2_GetAuraInfo(TabElement);
				getglobal("TRP2_ListeSmallSlot"..j.."Icon"):SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(auraInfo,"Icone","Temp"));
				getglobal("TRP2_ListeSmallSlot"..j):SetScript("OnClick", function()
					TRP2_AddAuraPet(TabElement,0,true,TRP2MainFrame.Mode);
					TRP2_ListeSmall:Hide();
				end);
				local descri = "";
				descri = descri.."{v}< "..TRP2_Auras_Categorie[TRP2_GetInt(tonumber(TRP2_GetWithDefaut(auraInfo,"EtatCat",2)))].." >\n";
				descri = descri.."{w}\"{o}"..TRP2_GetWithDefaut(auraInfo,"Description","").."{w}\"";
				descri = descri.."\n{j}Type : "..TRP2_LOC_AuraType[TRP2_GetInt(TRP2_GetWithDefaut(auraInfo,"Type",2))];
				TRP2_SetTooltipForFrame(
					getglobal("TRP2_ListeSmallSlot"..j),
					TRP2_ListeSmall,"TOPLEFT",0,0,
					TRP2_Auras_Color[TRP2_GetWithDefaut(auraInfo,"Type",2)].."|TInterface\\ICONS\\"..TRP2_GetWithDefaut(auraInfo,"Icone","Temp")..":30:30|t\n"..TRP2_GetWithDefaut(auraInfo,"Nom",TRP2_LOC_NewAura),
					descri
				);
			-- LANGAGE
			elseif TRP2_ListeSmall.listType == "langage" then
				local langueTab = TRP2_GetLangageInfo(TabElement);
				getglobal("TRP2_ListeSmallSlot"..j.."Icon"):SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(langueTab,"Icone","Temp"));
				getglobal("TRP2_ListeSmallSlot"..j):SetScript("OnClick", function()
					TRP2_AddLangage(TabElement,nil,true);
					TRP2_ListeSmall:Hide();
				end);
				TRP2_SetTooltipForFrame(
					getglobal("TRP2_ListeSmallSlot"..j),
					TRP2_ListeSmall,"TOPLEFT",0,0,
					"|TInterface\\ICONS\\"..TRP2_GetWithDefaut(langueTab,"Icone","Temp")..":35:35|t "..TRP2_GetWithDefaut(langueTab,"Nom",TabElement),
					TRP2_GetWithDefaut(langueTab,"Description")
				);
			-- QUEST
			elseif TRP2_ListeSmall.listType == "quests" then
				local questTab = TRP2_GetQuestsInfo(TabElement);
				getglobal("TRP2_ListeSmallSlot"..j.."Icon"):SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(questTab,"Icone","Temp"));
				getglobal("TRP2_ListeSmallSlot"..j):SetScript("OnClick", function()
					if not TRP2_IsQuestActive(TabElement) then
						TRP2_AddQuest(TabElement);
						TRP2_LoadQuestsList();
					end
					TRP2_ListeSmall:Hide();
				end);
				local descri = "";
				descri = descri.."{w}\"{o}"..TRP2_GetWithDefaut(questTab,"Description","").."{w}\"";
				TRP2_SetTooltipForFrame(
					getglobal("TRP2_ListeSmallSlot"..j),
					TRP2_ListeSmall,"TOPLEFT",0,0,
					"|TInterface\\ICONS\\"..TRP2_GetWithDefaut(questTab,"Icone","Temp")..":35:35|t "..TRP2_GetWithDefaut(questTab,"Nom",TabElement),
					descri
				);
			--SOUND
			elseif TRP2_ListeSmall.listType == "sounds" then
				getglobal("TRP2_ListeSmallSlot"..j.."Icon"):SetTexture("Interface\\ICONS\\INV_Misc_Ear_Human_01");
				getglobal("TRP2_ListeSmallSlot"..j):SetScript("OnClick", function(self,button)
					if IsShiftKeyDown() then
						TRP2_ListeSmallURLBox:Show();
						TRP2_ListeSmallURLBox:SetText(tostring(TRP2_LISTE_SOUNDS[TabElement]));
						return;
					end
					if button == "LeftButton" then
						if TRP2_ListeSmall.arg1 then
							if TRP2_ListeSmall.arg2 == true then
								TRP2_ListeSmall.arg1:Insert(string.gsub(TRP2_LISTE_SOUNDS[TabElement],"\\","\\\\"));
							else
								TRP2_ListeSmall.arg1:SetText(string.gsub(TRP2_LISTE_SOUNDS[TabElement],"\\","\\\\"));
							end
						end
						TRP2_ListeSmall:Hide();
					else
						TRP2_PlaySound(TRP2_LISTE_SOUNDS[TabElement]);
					end
				end);
				TRP2_SetTooltipForFrame(
					getglobal("TRP2_ListeSmallSlot"..j),
					TRP2_ListeSmall,"TOPLEFT",0,0,
					"|TInterface\\ICONS\\INV_Misc_Ear_Human_01:35:35|t {w}"..ENABLE_SOUNDFX.." n°"..TabElement,
					TRP2_GetLastRep(TRP2_LISTE_SOUNDS[TabElement])
					.."\n\n{j}"..TRP2_LOC_CLIC.." {w}: "..TRP2_LOC_UI_Select.."\n{j}"..TRP2_LOC_CLICDROIT.." {w}: "..TRP2_LOC_Sound_PreListen
				);
			-- VALEUR
			elseif TRP2_ListeSmall.listType == "valeurs" then
				getglobal("TRP2_ListeSmallSlot"..j.."Icon"):SetTexture("Interface\\ICONS\\"..TRP2_LISTE_VALEURS[TabElement]["Icone"]);
				getglobal("TRP2_ListeSmallSlot"..j):SetScript("OnClick", function()
					if TRP2_ListeSmall.arg1 then
						TRP2_ListeSmall.arg1.Arg = nil;
						TRP2_ListeSmall.arg1.Condi = TabElement;
					end
					TRP2_ListeSmall:Hide();
					if TRP2_LISTE_VALEURS[TabElement]["ListeArg"] then
						TRP2_SetListFor(TRP2_LISTE_VALEURS[TabElement]["ListeArg"],nil,true,TRP2_ListeSmall.arg1);
					end
				end);
				local descri = "{o}"..TRP2_LISTE_VALEURS[TabElement]["ExpliDetails"];
				if TRP2_LISTE_VALEURS[TabElement]["bNumeric"] then
					descri = descri.."\n{v}"..TRP2_LOC_NUMCONDI;
				end
				TRP2_SetTooltipForFrame(
					getglobal("TRP2_ListeSmallSlot"..j),
					TRP2_ListeSmall,"TOPLEFT",0,0,
					TRP2_LISTE_VALEURS[TabElement]["Titre"],descri
				);
			-- EFFET
			elseif TRP2_ListeSmall.listType == "effets" then
				getglobal("TRP2_ListeSmallSlot"..j.."Icon"):SetTexture("Interface\\ICONS\\"..TRP2_LISTE_EFFETS[TabElement]["Icone"]);
				getglobal("TRP2_ListeSmallSlot"..j):SetScript("OnClick", function()
					TRP2_NewEffet(TabElement);
					TRP2_ListeSmall:Hide();
				end);
				TRP2_SetTooltipForFrame(
					getglobal("TRP2_ListeSmallSlot"..j),
					TRP2_ListeSmall,"TOPLEFT",0,0,
					TRP2_LISTE_EFFETS[TabElement]["Titre"],TRP2_LISTE_EFFETS[TabElement]["Explication"]
				);
			-- AURA ID
			elseif TRP2_ListeSmall.listType == "aurasID" then
				local auraInfo = TRP2_GetAuraInfo(TabElement);
				getglobal("TRP2_ListeSmallSlot"..j.."Icon"):SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(auraInfo,"Icone","Temp"));
				getglobal("TRP2_ListeSmallSlot"..j):SetScript("OnClick", function()
					if TRP2_ListeSmall.arg1 then
						TRP2_ListeSmall.arg1.Arg = TabElement;
						getglobal(TRP2_ListeSmall.arg1:GetName().."Icon"):SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(auraInfo,"Icone","Temp"));
					end
					TRP2_ListeSmall:Hide();
				end);
				local descri = "";
				descri = descri.."{v}< "..TRP2_Auras_Categorie[tonumber(TRP2_GetWithDefaut(auraInfo,"EtatCat",2))].." >\n";
				descri = descri.."{w}\"{o}"..TRP2_GetWithDefaut(auraInfo,"Description","").."{w}\"";
				descri = descri.."\n{j}Type : "..TRP2_LOC_AuraType[TRP2_GetWithDefaut(auraInfo,"Type",2)];
				if not TRP2_GetWithDefaut(auraInfo,"bDeletable",true) then
					descri = descri.."\n{r}< "..TRP2_LOC_NoDelete.." >";
				end
				TRP2_SetTooltipForFrame(
					getglobal("TRP2_ListeSmallSlot"..j),
					TRP2_ListeSmall,"TOPLEFT",0,0,
					TRP2_Auras_Color[TRP2_GetWithDefaut(auraInfo,"Type",2)].."|TInterface\\ICONS\\"..TRP2_GetWithDefaut(auraInfo,"Icone","Temp")..":40:40|t "..TRP2_GetWithDefaut(auraInfo,"Nom",TRP2_LOC_NewAura),
					descri
				);
			-- OBJET ID
			elseif TRP2_ListeSmall.listType == "objetID" then
				-- TabElement == ID
				local ObjetInfo = TRP2_GetObjectTab(TabElement);
				getglobal("TRP2_ListeSmallSlot"..j.."Icon"):SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(ObjetInfo,"Icone","Temp"));
				getglobal("TRP2_ListeSmallSlot"..j):SetScript("OnClick", function()
					if TRP2_ListeSmall.arg1 then
						TRP2_ListeSmall.arg1.Arg = TabElement;
						getglobal(TRP2_ListeSmall.arg1:GetName().."Icon"):SetDesaturated(false);
						getglobal(TRP2_ListeSmall.arg1:GetName().."Icon"):SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(ObjetInfo,"Icone","Temp"));
					end
					TRP2_ListeSmall:Hide();
				end);
				TRP2_SetTooltipForFrame(
					getglobal("TRP2_ListeSmallSlot"..j),
					TRP2_ListeSmall,"TOPLEFT",0,0,
					TRP2_GenerateSmallTooltipObject(ObjetInfo)
				);
			-- QUEST ID
			elseif TRP2_ListeSmall.listType == "questsID" then
				local questTab = TRP2_GetQuestsInfo(TabElement);
				getglobal("TRP2_ListeSmallSlot"..j.."Icon"):SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(questTab,"Icone","Temp"));
				getglobal("TRP2_ListeSmallSlot"..j):SetScript("OnClick", function()
					if TRP2_ListeSmall.arg1 then
						TRP2_ListeSmall.arg1.Arg = TabElement;
						getglobal(TRP2_ListeSmall.arg1:GetName().."Icon"):SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(questTab,"Icone","Temp"));
					end
					TRP2_ListeSmall:Hide();
				end);
				TRP2_SetTooltipForFrame(
					getglobal("TRP2_ListeSmallSlot"..j),
					TRP2_ListeSmall,"TOPLEFT",0,0,
					TRP2_CreatSimpleTooltipQuest(questTab)
				);
			-- DOCU ID
			elseif TRP2_ListeSmall.listType == "docuID" then
				local Tab = TRP2_GetDocumentInfo(TabElement);
				getglobal("TRP2_ListeSmallSlot"..j.."Icon"):SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(Tab,"Icone","Temp"));
				getglobal("TRP2_ListeSmallSlot"..j):SetScript("OnClick", function()
					if TRP2_ListeSmall.arg1 then
						TRP2_ListeSmall.arg1.Arg = TabElement;
						getglobal(TRP2_ListeSmall.arg1:GetName().."Icon"):SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(Tab,"Icone","Temp"));
					end
					TRP2_ListeSmall:Hide();
				end);
				TRP2_SetTooltipForFrame(
					getglobal("TRP2_ListeSmallSlot"..j),
					TRP2_ListeSmall,"TOPLEFT",0,0,
					TRP2_CreatSimpleTooltipDocument(Tab)
				);
			-- LAN ID
			elseif TRP2_ListeSmall.listType == "langID" then
				local Tab = TRP2_GetLangageInfo(TabElement);
				getglobal("TRP2_ListeSmallSlot"..j.."Icon"):SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(Tab,"Icone","Temp"));
				getglobal("TRP2_ListeSmallSlot"..j):SetScript("OnClick", function()
					if TRP2_ListeSmall.arg1 then
						TRP2_ListeSmall.arg1.Arg = TabElement;
						getglobal(TRP2_ListeSmall.arg1:GetName().."Icon"):SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(Tab,"Icone","Temp"));
					end
					TRP2_ListeSmall:Hide();
				end);
				TRP2_SetTooltipForFrame(
					getglobal("TRP2_ListeSmallSlot"..j),
					TRP2_ListeSmall,"TOPLEFT",0,0,
					TRP2_CreatSimpleTooltipDialecte(Tab),
					TRP2_GetWithDefaut(Tab,"Description")
				);
			end
			j = j + 1;
		end
		i = i + 1;
	end);
end

function TRP2_InitUIDropDown(initFunction,frame,x,y)
	if not getglobal("TRP2_UIDD") then
		CreateFrame("Frame","TRP2_UIDD",UIParent,"UIDropDownMenuTemplate");
	end
	UIDropDownMenu_Initialize(getglobal("TRP2_UIDD"), initFunction, "MENU");
	if not frame then
		ToggleDropDownMenu(1, nil, getglobal("TRP2_UIDD"), "cursor");
	else
		ToggleDropDownMenu(1, nil, getglobal("TRP2_UIDD"), frame:GetName(),x,y);
	end
end

function TRP2_OpenMainMenu(bOpen)
	if bOpen then
		TRP2_OpenPanel();
	else
		TRP2MainFrame:Hide();
	end
end

function TRP2_HideAllFrame()
	TRP2MainFrame:Hide();
	
	TRP2MainFrameFicheJoueur:Hide();

	TRP2MainFrameFicheJoueurGeneralConsulte:Hide();
	TRP2MainFrameFicheJoueurGeneralEdition:Hide();
	TRP2MainFrameFicheJoueurPhysiqueConsulte:Hide();
	TRP2MainFrameFicheJoueurPhysiqueEdition:Hide();
	TRP2MainFrameFicheJoueurHistoireConsulte:Hide();
	TRP2MainFrameFicheJoueurHistoireEdition:Hide();
	TRP2MainFrameFicheJoueurPsychoConsulte:Hide();
	TRP2MainFrameFicheJoueurPsychoEdition:Hide();
	TRP2MainFrameFicheJoueurActuConsulte:Hide();
	TRP2MainFrameFicheJoueurCaracteristiques:Hide();
	TRP2MainFrameFicheJoueurPetsListe:Hide();
	TRP2MainFrameFicheJoueurPetsFrameConsulte:Hide();
	TRP2MainFrameFicheJoueurPetsFrameEdite:Hide();
	
	TRP2_RegistreOngletMenuAura:Hide();
	TRP2MainFrameFicheJoueurMenuOngletOngletConsulte:Hide();
	TRP2MainFrameFicheJoueurMenuOngletOngletEdition:Hide();
	TRP2MainFrameFicheJoueurMenuOngletOngletRetourListe:Hide();
	TRP2MainFrameFicheJoueurOngletRegistre:Hide();
	
	TRP2_PetFrameOngletConsulte:Hide();
	TRP2_PetFrameOngletEdition:Hide();
	
	TRP2MainFrameRegistre:Hide();
	TRP2MainFrameRegistreListe:Hide();
	TRP2MainFrameFicheJoueurMenuOngletOngletRelation:Hide();
	TRP2MainFrameFicheJoueurMenuOngletOngletDelete:Hide();
	
	TRP2MainFrameLangage:Hide();
	TRP2MainFrameQuestsLog:Hide();
	
	TRP2MainFrameConfig:Hide();
	for i=1,10,1 do
		if getglobal("TRP2_ConfigFrameScroll"..i) then
			getglobal("TRP2_ConfigFrameScroll"..i):Hide();
		end
	end
end

function TRP2_DisableIcon(icone,bDisable,bDesa)
	if bDisable then
		icone:Disable();
		getglobal(icone:GetName().."Icon"):SetAlpha(0.5);
		if bDesa then
			getglobal(icone:GetName().."Icon"):SetDesaturated(true);
		end
	else
		icone:Enable();
		getglobal(icone:GetName().."Icon"):SetAlpha(1);
		getglobal(icone:GetName().."Icon"):SetDesaturated(false);
	end
end

function TRP2_OpenPanel(panel, onglet, sousonglet, mode, nom, arg1, arg2)
	-- Adaptation de l'icone
	TRP2_HideAllFrame();
	TRP2_ListeSmall:Hide();
	
	if not panel then
		panel = "Fiche";
	end
	
	if not nom then
		nom = TRP2_Joueur;
	end
	if nom == TRP2_Joueur then
		if TRP2_GetWithDefaut(TRP2_GetInfo(TRP2_Joueur,"Actu",{}),"PlayerIcon") then
			retOK, ret1 = pcall (SetPortraitToTexture, TRP2_PanelPortrait, "Interface\\ICONS\\"..TRP2_GetWithDefaut(TRP2_GetInfo(nom,"Actu",{}),"PlayerIcon"));
			if retOK then
				else
					TRP2_PanelPortrait:SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(TRP2_GetInfo(nom,"Actu",{}),"PlayerIcon"));
					TRP2_PanelPortrait:SetTexCoord(0,1,0,1);
			end
		else
			SetPortraitTexture(TRP2_PanelPortrait,"player");
		end
	end
	
	if panel == "Creation" then
		TRP2MainFrame:Hide();
		TRP2_CreationPanel("Base");
		return;
	elseif panel == "Fiche" then
		onglet, sousonglet, mode, nom, arg1, arg2 = TRP2_OpenPanelFiche(panel, onglet, sousonglet, mode, nom, arg1, arg2);
	elseif panel == "Langage" then
		onglet, sousonglet, mode, nom, arg1, arg2 = TRP2_OpenPanelLangues(onglet, sousonglet, mode, nom, arg1, arg2);
	elseif panel == "Registre" then
		if not onglet then
			onglet = "ListeRegistre";
		end
		TRP2_PanelTitle:SetText(TRP2_LOC_REGISTRE.." : ".._G["TRP2_LOC_"..onglet]);
		TRP2MainFrameRegistre:Show();
		if onglet == "ListeRegistre" then
			TRP2MainFrameRegistreListe:Show();
			TRP2_ChargerListeRegistre();
		end
	elseif panel == "Options" then
		if not onglet then
			onglet = "";
		end
		if not sousonglet then
			sousonglet = "1";
		end
		TRP2_ChargerConfigValues();
		TRP2MainFrameConfig:Show();
		if getglobal("TRP2_ConfigFrameScroll"..sousonglet) then
			getglobal("TRP2_ConfigFrameScroll"..sousonglet):Show();
		end
		TRP2_PanelTitle:SetText(TRP2_LOC_PARAMS);
	elseif panel == "Quests" then
		if not onglet then
			onglet = "";
		end
		if not sousonglet then
			sousonglet = "";
		end
		TRP2_LoadQuestsLog();
	end
	
	TRP2MainFrame.Panel = panel;
	TRP2MainFrame.Onglet = onglet;
	TRP2MainFrame.SousOnglet = sousonglet;
	TRP2MainFrame.Mode = mode;
	TRP2MainFrame.Nom = nom;
	TRP2MainFrame:Show();
end

function TRP2_AnimPersoShow(mode)
	if UnitExists("target") then
		TRP2_NPCAnimFrameScrollNomSaisie:SetText(TRP2_GetTargetTRPName());
	end
	if not mode then
		if UnitExists("target") then
			mode = "Parole";
		else
			mode = "Texte";
		end
	end
	local nom = TRP2_EmptyToNil(TRP2_NPCAnimFrameScrollNomSaisie:GetText());
	TRP2_NPCAnimFrame:Show();
	TRP2_NPCAnimFrame.Mode = mode;
	TRP2_NPCAnimFrame.Nom = nom;

	if mode == "Texte" then
		TRP2_NPCAnimFrameTitre:SetText(TRP2_CTS(TRP2_LOC_TEXTE));
	elseif mode == "Parole" then
		TRP2_NPCAnimFrameTitre:SetText(TRP2_CTS(CHAT_MSG_SAY));
	elseif mode == "Crier" then
		TRP2_NPCAnimFrameTitre:SetText(TRP2_CTS(CHAT_MSG_YELL));
	elseif mode == "Chuchotter" then
		TRP2_NPCAnimFrameTitre:SetText(TRP2_CTS(CHAT_MSG_WHISPER_INFORM));
	elseif mode == "Emote" then
		TRP2_NPCAnimFrameTitre:SetText(TRP2_CTS(CHAT_MSG_EMOTE));
	end
	
	TRP2_NPCAnimFrameScrollNomSaisie.disabled = false;
	if mode == "Texte" then
		TRP2_NPCAnimFrameTitre:SetText(TRP2_LOC_TEXTE);
		TRP2_NPCAnimFrameScrollNomSaisie.disabled = true;
	end
	local total = TRP2_CalculCarRestant(TRP2_NPCAnimFrameScrollScrollEditBox:GetText(),TRP2_NPCAnimFrame.Mode,TRP2_NPCAnimFrame.Nom);
	TRP2_NPCAnimFrameScrollTexte:SetText((total+string.len(TRP2_NPCAnimFrameScrollScrollEditBox:GetText())).."/250");
	TRP2_NPCAnimFrameApercu:SetText(TRP2_CTS(TRP2_LOC_APERCU.." :\n"..TRP2_AnimNPCFormat(TRP2_NPCAnimFrameScrollScrollEditBox:GetText(),mode,nom,true)));
	TRP2_NPCAnimFrameScrollScrollEditBox:SetText(string.sub(TRP2_NPCAnimFrameScrollScrollEditBox:GetText(),1,250-total));
end

function TRP2_NPCAnimRecalculTailleApercu()
	TRP2_NPCAnimFrameApercuFrame:SetHeight(TRP2_NPCAnimFrameApercu:GetHeight() + 25);
end

function TRP2_CalculCarRestant(texte,mode,nom)
	if texte and mode then
		local totalActuel = 0;
		if not TRP2_EmptyToNil(nom) then
			nom = UNKNOWN;
		end
		if mode == "Texte" then
			totalActuel = 2;
		elseif mode == "Parole" then
			totalActuel = string.len(nom) + string.len(TRP2_LOC_DIT) + 2;
		elseif mode == "Crier" then
			totalActuel = string.len(nom) + string.len(TRP2_LOC_CRIE) + 2;
		elseif mode == "Chuchotter" then
			totalActuel = string.len(nom) + string.len(TRP2_LOC_WHISPER) + 2;
		elseif mode == "Emote" then
			totalActuel = string.len(nom) + 3;
		end
		return totalActuel;
	end
	return 0;
end

function TRP2_AnimNPCFormat(texte,mode,nom,preview)
	if texte and texte ~= "" then
		if not TRP2_EmptyToNil(nom) then
			nom = UNKNOWN;
		end
		local texteFinal = "";
		local colorEmote = "{"..TRP2_deciToHexa(ChatTypeInfo["MONSTER_EMOTE"].r)..TRP2_deciToHexa(ChatTypeInfo["MONSTER_EMOTE"].g)..TRP2_deciToHexa(ChatTypeInfo["MONSTER_EMOTE"].b).."}";
		local colorSay = "{"..TRP2_deciToHexa(ChatTypeInfo["MONSTER_SAY"].r)..TRP2_deciToHexa(ChatTypeInfo["MONSTER_SAY"].g)..TRP2_deciToHexa(ChatTypeInfo["MONSTER_SAY"].b).."}";
		local colorYell = "{"..TRP2_deciToHexa(ChatTypeInfo["MONSTER_YELL"].r)..TRP2_deciToHexa(ChatTypeInfo["MONSTER_YELL"].g)..TRP2_deciToHexa(ChatTypeInfo["MONSTER_YELL"].b).."}";
		local colorWhisp = "{"..TRP2_deciToHexa(ChatTypeInfo["MONSTER_WHISPER"].r)..TRP2_deciToHexa(ChatTypeInfo["MONSTER_WHISPER"].g)..TRP2_deciToHexa(ChatTypeInfo["MONSTER_WHISPER"].b).."}";
		if not preview then
			texteFinal = "|| ";
		end
		if mode == "Texte" then
			return colorEmote..texteFinal..texte;
		elseif mode == "Parole" then
			return "{o}"..texteFinal..nom.." "..colorSay..TRP2_LOC_DIT..texte;
		elseif mode == "Crier" then
			return "{o}"..texteFinal..nom.." "..colorYell..TRP2_LOC_CRIE..texte;
		elseif mode == "Chuchotter" then
			return "{o}"..texteFinal..nom.." "..colorWhisp..TRP2_LOC_WHISPER..texte;
		elseif mode == "Emote" then
			return colorEmote..texteFinal..nom.." "..texte;
		end
	end
	return "";
end

function TRP2_AnimPersoSend()
	ChatThrottleLib:SendChatMessage("NORMAL",TRP2_COMM_PREFIX,string.sub(TRP2_CTS(TRP2_AnimNPCFormat(TRP2_NPCAnimFrameScrollScrollEditBox:GetText(),TRP2_NPCAnimFrame.Mode,TRP2_NPCAnimFrame.Nom),true),1,250),"EMOTE");
	TRP2_NPCAnimFrameScrollScrollEditBox:SetText("");
end

function TRP2_IconePosition()
	if getglobal(TRP2_GetConfigValueFor("MiniMapToUse","Minimap")) then
		local x = sin(TRP2_GetConfigValueFor("MiniMapIconDegree",210))*TRP2_GetConfigValueFor("MiniMapIconPosition",80);
		local y = cos(TRP2_GetConfigValueFor("MiniMapIconDegree",210))*TRP2_GetConfigValueFor("MiniMapIconPosition",80);
		TRP2_MinimapButton:SetParent(getglobal(TRP2_GetConfigValueFor("MiniMapToUse","Minimap")));
		TRP2_MinimapButton:SetPoint("CENTER",getglobal(TRP2_GetConfigValueFor("MiniMapToUse","Minimap")),"CENTER",x,y);
	end
end

function TRP2_SetTooltipForFrame(Frame,GenFrame,GenFrameAnch,GenFrameX,GenFrameY,tooltipTexte,tooltipTexteSuite,texteDroite)
	if Frame and GenFrame then
		Frame.GenFrame = GenFrame;
		Frame.GenFrameX = GenFrameX;
		Frame.GenFrameY = GenFrameY;
		Frame.tooltipTexte = tooltipTexte;
		Frame.tooltipTexteSuite = tooltipTexteSuite;
		Frame.texteDroite = texteDroite;
		if GenFrameAnch then
			Frame.GenFrameAnch = "ANCHOR_"..GenFrameAnch;
		else
			Frame.GenFrameAnch = "ANCHOR_TOPRIGHT";
		end
	end
end

function TRP2_RefreshTooltipForFrame(Frame)
	if Frame.tooltipTexte and Frame.GenFrame and Frame.GenFrameX and Frame.GenFrameY and Frame.GenFrameAnch then
		TRP2_MainTooltip:Hide();
		TRP2_MainTooltip:SetOwner(Frame.GenFrame, Frame.GenFrameAnch,Frame.GenFrameX,Frame.GenFrameY);
		if not Frame.texteDroite then
			TRP2_MainTooltip:AddLine(TRP2_CTS(Frame.tooltipTexte), 1, 1, 1,true);
		else
			TRP2_MainTooltip:AddDoubleLine(TRP2_CTS(Frame.tooltipTexte),TRP2_CTS(Frame.texteDroite));
			TRP2_MainTooltipTextRight1:SetFont("Fonts\\FRIZQT__.TTF",TRP2_GetConfigValueFor("AideTaille",10)+4);
			TRP2_MainTooltipTextRight1:SetNonSpaceWrap(true);
		end
		TRP2_MainTooltipTextLeft1:SetFont("Fonts\\FRIZQT__.TTF",TRP2_GetConfigValueFor("AideTaille",10)+4);
		TRP2_MainTooltipTextLeft1:SetNonSpaceWrap(true);
		if Frame.tooltipTexteSuite then
			TRP2_MainTooltip:AddLine(TRP2_CTS(Frame.tooltipTexteSuite),1,0.6666,0,true);
			TRP2_MainTooltipTextLeft2:SetFont("Fonts\\FRIZQT__.TTF",TRP2_GetConfigValueFor("AideTaille",10));
			TRP2_MainTooltipTextLeft2:SetNonSpaceWrap(true);
		end
		TRP2_MainTooltip:Show();
	end
end

function TRP2_MouseOverTooltip(TT_Type)
	if not TRP2_GetConfigValueFor("UseTRPTooltip",true) or (UnitAffectingCombat("player") and not TRP2_GetConfigValueFor("UseTTInCombat",true)) then
		return;
	end

	TRP2_PersoTooltip:Hide();
	TRP2_MountTooltip:Hide();
	local Nom, royaume = UnitName(TT_Type);
	if royaume then
		Nom = Nom.."-"..royaume;
	end
	if Nom then -- NPC or Joueur
		if getglobal(TRP2_GetConfigValueFor("TTAnchors","GameTooltip")) then
			TRP2_PersoTooltip:SetOwner(getglobal(TRP2_GetConfigValueFor("TTAnchors","GameTooltip")),TRP2_AnchorTab[TRP2_GetConfigValueFor("TTPersoAnchorPoint",3)]);
		else
			TRP2_PersoTooltip:SetOwner(GameTooltip,TRP2_AnchorTab[TRP2_GetConfigValueFor("TTPersoAnchorPoint",3)]);
		end
		if getglobal(TRP2_GetConfigValueFor("TTAnchorsMount","TRP2_PersoTooltip")) then
			TRP2_MountTooltip:SetOwner(getglobal(TRP2_GetConfigValueFor("TTAnchorsMount","TRP2_PersoTooltip")),TRP2_AnchorTab[TRP2_GetConfigValueFor("TTMountAnchorPoint",3)]);
		else
			TRP2_MountTooltip:SetOwner(TRP2_PersoTooltip,TRP2_AnchorTab[TRP2_GetConfigValueFor("TTMountAnchorPoint",3)]);
		end
		--GameTooltip_SetDefaultAnchor(TRP2_PersoTooltip, UIParent);
		local infoTab = {};
		local i = GameTooltip:NumLines();
		for j = 1, GameTooltip:NumLines() do
			infoTab[j] = getglobal("GameTooltipTextLeft" ..  j):GetText();
		end
		if UnitIsPlayer(TT_Type) then -- La cible est un joueur
			TRP2_TraiterTooltipPerso(Nom,infoTab,i,TT_Type,royaume);
			TRP2_PersoTooltip.Nom = Nom;
			TRP2_PersoTooltip.TT_Type = TT_Type;
			TRP2_PersoTooltip:Show();
			if TRP2_GetConfigValueFor("HideOldTooltip",true) then
				GameTooltip:Hide();
			end
		elseif infoTab[2] and TRP2_foundInTableString2(TRP2_compagnonPrefixe,infoTab[2]) then
			local nomMaitre = infoTab[2];
			local nomPet = infoTab[1];
			nomMaitre = TRP2_IsolerNomMaitre(nomMaitre);
			TRP2_TraiterTooltipPet(nomMaitre,nomPet,false,infoTab,i,TT_Type);
			TRP2_PersoTooltip.Nom = Nom;
			TRP2_PersoTooltip.TT_Type = TT_Type;
			TRP2_PersoTooltip:Show();
			if TRP2_GetConfigValueFor("HideOldTooltip",true) then
				GameTooltip:Hide();
			end
                    --Added by Lixxel MORE COPYPASTA
                    elseif infoTab[3] and TRP2_foundInTableString2(TRP2_compagnonPrefixe,infoTab[3]) then
			local nomMaitre = infoTab[3];
                        local nomSpecies = infoTab[2];
			local nomPet = infoTab[1];
			nomMaitre = TRP2_IsolerNomMaitre(nomMaitre);
			TRP2_TraiterTooltipPet(nomMaitre,nomSpecies,nomPet,infoTab,i,TT_Type);
			TRP2_PersoTooltip.Nom = Nom;
			TRP2_PersoTooltip.TT_Type = TT_Type;
			TRP2_PersoTooltip:Show();
			if TRP2_GetConfigValueFor("HideOldTooltip",true) then
				GameTooltip:Hide();
			end
		else
			TRP2_PersoTooltip:Hide();
		end
		TRP2_PersoTooltip:ClearAllPoints();
	end
end

function TRP2_SetMouseWheel(frame,slider)
	frame:SetScript("OnMouseWheel",function(arg1,arg2,arg3) 
		local mini,maxi = slider:GetMinMaxValues();
		if tonumber(arg2) == 1 and slider:GetValue() > mini then
			slider:SetValue(slider:GetValue()-1);
		elseif tonumber(arg2) == -1 and slider:GetValue() < maxi then
			slider:SetValue(slider:GetValue()+1);
		end
	end);
	frame:EnableMouseWheel(1);
end

function TRP2_HookAll()
	if not TRP2_GetConfigValueFor("bAnchorNoChat",false) then
		TRP2_Hooking_FrameEvent(); -- Hook de la réception de message dans la frame
	end
	if not TRP2_GetConfigValueFor("bAnchorNoParoles",false) then
		TRP2_HookSendChatMessage(); -- Hook d'envoi de message de chat
	end
	if not TRP2_GetConfigValueFor("bAnchorNoEmote",false) then
		TRP2_Hooking_DoEmote(); -- Hook du jeu d'émote
	end
	if not TRP2_GetConfigValueFor("bAnchorNoItemRef",false) then
		TRP2_ItemRef(); -- Hook du jeu d'émote
	end
end

function TRP2_ItemRef()
	function TRP2_SetItemRef(link, text, button, chatFrame)
		local tab = TRP2_FetchToTabWithSeparator(link,":");
		if tab[1] == "player" and button == "RightButton" and IsControlKeyDown() then
			TRP2CHATNAME = tab[2];
			TRP2_InitUIDropDown(TRP2_DD_PotraitIconeClick);
			return;
		elseif tab[1] == "totalrp2" then
			local item = string.match(text,"%[(.*)%]");
			if tab[2] and item then
				TRP2_HandleItemLink(tab[2], item, chatFrame);
			end
			return;
		end
		TRP2_Saved_SetItemRef(link, text, button, chatFrame);
	end
	TRP2_Saved_SetItemRef = SetItemRef;
	SetItemRef = TRP2_SetItemRef;
end

TRP2_ACTUALEDITBOX = nil;

TRP2_BALISETAB = {
	{
		["Nom"] = "{00ffff}Très grand titre (gauche)";
		["Code"] = "{titre1}Très grand titre{/titre1}";
	},
	{
		["Nom"] = "{00ffff}Très grand titre (centre)";
		["Code"] = "{titre1:centre}Très grand titre{/titre1}";
	},
	{
		["Nom"] = "{00ffff}Très grand titre (droite)";
		["Code"] = "{titre1:droite}Très grand titre{/titre1}";
	},
	
	{
		["Nom"] = "{00ffcc}Grand titre (gauche)";
		["Code"] = "{titre2}Grand titre{/titre2}";
	},
	{
		["Nom"] = "{00ffcc}Grand titre (centre)";
		["Code"] = "{titre2:centre}Grand titre{/titre2}";
	},
	{
		["Nom"] = "{00ffcc}Grand titre (droite)";
		["Code"] = "{titre2:droite}Grand titre{/titre2}";
	},
	
	{
		["Nom"] = "{00ccff}Titre (gauche)";
		["Code"] = "{titre3}Titre{/titre3}";
	},
	{
		["Nom"] = "{00ccff}Titre (centre)";
		["Code"] = "{titre3:centre}Titre{/titre3}";
	},
	{
		["Nom"] = "{00ccff}Titre (droite)";
		["Code"] = "{titre3:droite}Titre{/titre3}";
	},
	
	{
		["Nom"] = "{v}Texte (centre)";
		["Code"] = "{centre}Texte centré{/centre}";
	},
	{
		["Nom"] = "{v}Texte (droite)";
		["Code"] = "{droite}Texte à droite{/droite}";
	},
	{
		["Nom"] = "{j}Balise de lien";
		["Code"] = "{link:votre_url:votre_texte}";
	},
	
}

TRP2_BALISETABNORMAL = {
	{
		["Nom"] = "{j}Balise de rotation";
		["Code"] = "{rotation}";
	},
	{
		["Nom"] = "{v}Balise de coordonnées";
		["Code"] = "{coord}";
	},
	{
		["Nom"] = "{j}Balise de cible";
		["Code"] = "{ta}";
	},
	{
		["Nom"] = "{v}Balise de personnage";
		["Code"] = "{me}";
	},
	{
		["Nom"] = "{j}Balise d'icône";
		["Code"] = "{icone:Temp:25}";
	},
	{
		["Nom"] = "{j}Balise de zone";
		["Code"] = "{zone}";
	},
	{
		["Nom"] = "{j}Balise de sous-zone";
		["Code"] = "{souszone}";
	},
	{
		["Nom"] = "{j}Balise aléatoire {888888}(Remplacez le X)";
		["Code"] = "{randX}";
	},
	{
		["Nom"] = "{j}Balise de dialecte {888888}(Remplacez l'ID)";
		["Code"] = "{dial:ID}Votre texte{/dial}";
	},
	{
		["Nom"] = "{j}Balise de texte aléatoire {888888}(Remplacez les textes)";
		["Code"] = "{randtext:texte1+texte2}";
	},
}

function TRP2_CreateSimpleDDButton()
	local info = UIDropDownMenu_CreateInfo();
	info.notCheckable = "true";
	return info;
end

TRP2_SELECTEDCOLOR = "ffffff";

function TRP2_DD_BalisesNormales(frame,level,menuList)
	UIDropDownMenu_SetWidth(frame, 50);
	UIDropDownMenu_SetButtonWidth(frame, 15);
	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_LOC_UI_BalTexte;
	info.notCheckable = "true";
	info.func = function() end;
	info.isTitle = true;
	UIDropDownMenu_AddButton(info);
	
	if TRP2_ACTUALEDITBOX and TRP2_ACTUALEDITBOX:IsVisible() then
		for k,v in pairs(TRP2_BALISETABNORMAL) do
			info = TRP2_CreateSimpleDDButton();
			info.text = TRP2_CTS(v["Nom"]);
			info.notCheckable = "true";
			info.func = function()
				TRP2_ACTUALEDITBOX:SetText(string.sub(TRP2_ACTUALEDITBOX:GetText(),1,TRP2_ACTUALEDITBOX:GetCursorPosition())..v["Code"]..string.sub(TRP2_ACTUALEDITBOX:GetText(),TRP2_ACTUALEDITBOX:GetCursorPosition()+1));
			end;
			UIDropDownMenu_AddButton(info,level);
		end
		info = TRP2_CreateSimpleDDButton();
		info.text = TRP2_CTS("{"..TRP2_SELECTEDCOLOR.."}"..TRP2_LOC_UI_BalCoul);
		info.notCheckable = "true";
		info.hasColorSwatch = true;
		info.r = 1;
		info.g = 1;
		info.b = 1;
		info.swatchFunc = function(r,g,b)
			local r,g,b = ColorPickerFrame:GetColorRGB();
			TRP2_SELECTEDCOLOR = TRP2_deciToHexa(r)..TRP2_deciToHexa(g)..TRP2_deciToHexa(b);
		end;
		info.func = function()
			TRP2_ACTUALEDITBOX:SetText(string.sub(TRP2_ACTUALEDITBOX:GetText(),1,TRP2_ACTUALEDITBOX:GetCursorPosition()).."{"..tostring(TRP2_SELECTEDCOLOR).."}"..string.sub(TRP2_ACTUALEDITBOX:GetText(),TRP2_ACTUALEDITBOX:GetCursorPosition()+1));
		end;
		UIDropDownMenu_AddButton(info,level);
	end
		
	info = TRP2_CreateSimpleDDButton();
	info.text = CANCEL;
	UIDropDownMenu_AddButton(info,level);
end

function TRP2_DD_Balises(frame,level,menuList)
	UIDropDownMenu_SetWidth(frame, 50);
	UIDropDownMenu_SetButtonWidth(frame, 15);
	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_LOC_UI_BalPage;
	info.func = function() end;
	info.isTitle = true;
	UIDropDownMenu_AddButton(info);
	
	if TRP2_ACTUALEDITBOX and TRP2_ACTUALEDITBOX:IsVisible() then
		for k,v in pairs(TRP2_BALISETAB) do
			info = TRP2_CreateSimpleDDButton();
			info.text = TRP2_CTS(v["Nom"]);
			info.func = function()
				TRP2_ACTUALEDITBOX:SetText(string.sub(TRP2_ACTUALEDITBOX:GetText(),1,TRP2_ACTUALEDITBOX:GetCursorPosition())..v["Code"]..string.sub(TRP2_ACTUALEDITBOX:GetText(),TRP2_ACTUALEDITBOX:GetCursorPosition()+1));
			end;
			UIDropDownMenu_AddButton(info,level);
		end
	end
		
	info = TRP2_CreateSimpleDDButton();
	info.text = CANCEL;
	UIDropDownMenu_AddButton(info,level);
end

function TRP2_DoARand(randType)
	if not TRP2_EmptyToNil(randType) or randType == "?" then
		TRP2_Afficher("{j}"..TRP2_LOC_UI_JetDeDes.." :");
		TRP2_Afficher("{j}".."/trp2 Rand 1 : 1-100");
		TRP2_Afficher("{j}".."/trp2 Rand 2 : 1d6");
		TRP2_Afficher("{j}".."/trp2 Rand 3 : 2d6");
		TRP2_Afficher("{j}".."/trp2 Rand 4 : 3d6");
		TRP2_Afficher("{j}".."/trp2 Rand 5 : 1d10");
		TRP2_Afficher("{j}".."/trp2 Rand 6 : 2d10");
		TRP2_Afficher("{j}".."/trp2 Rand 7 : 3d10");
		TRP2_Afficher("{j}".."/trp2 Rand 8 : 1d12");
		TRP2_Afficher("{j}".."/trp2 Rand 9 : 2d12");
		TRP2_Afficher("{j}".."/trp2 Rand 10 : 1d20");
		TRP2_Afficher("{j}".."/trp2 Rand 11 : 2d20");
	else
		local rand;
		if randType == "1" then
			rand = "|TInterface\\ICONS\\INV_Misc_Dice_01:25:25|t "..TRP2_Joueur.." "..TRP2_LOC_UI_JetDeDesGET.." : "..math.random(100).." (1-100)";
		elseif randType == "2" then
			rand = "|TInterface\\ICONS\\INV_Misc_Dice_01:25:25|t "..TRP2_Joueur.." "..TRP2_LOC_UI_JetDeDesGET.." : "..math.random(6).." (1d6)";
		elseif randType == "3" then
			local tir1 = math.random(6);
			local tir2 = math.random(6);
			local total = tir1 + tir2;
			rand = "|TInterface\\ICONS\\INV_Misc_Dice_01:25:25|t "..TRP2_Joueur.." "..TRP2_LOC_UI_JetDeDesGET.." : "..tir1.." + "..tir2.." = "..total.." (2d6)";
		elseif randType == "4" then
			local tir1 = math.random(6);
			local tir2 = math.random(6);
			local tir3 = math.random(6);
			local total = tir1 + tir2 + tir3;
			rand = "|TInterface\\ICONS\\INV_Misc_Dice_01:25:25|t "..TRP2_Joueur.." "..TRP2_LOC_UI_JetDeDesGET.." : "..tir1.." + "..tir2.." + "..tir3.." = "..total.." (3d6)";
		elseif randType == "5" then
			rand = "|TInterface\\ICONS\\INV_Misc_Dice_01:25:25|t "..TRP2_Joueur.." "..TRP2_LOC_UI_JetDeDesGET.." : "..math.random(10).." (1d10)";
		elseif randType == "6" then
			local tir1 = math.random(10);
			local tir2 = math.random(10);
			local total = tir1 + tir2;
			rand = "|TInterface\\ICONS\\INV_Misc_Dice_01:25:25|t "..TRP2_Joueur.." "..TRP2_LOC_UI_JetDeDesGET.." : "..tir1.." + "..tir2.." = "..total.." (2d10)";
		elseif randType == "7" then
			local tir1 = math.random(10);
			local tir2 = math.random(10);
			local tir3 = math.random(10);
			local total = tir1 + tir2 + tir3;
			rand = "|TInterface\\ICONS\\INV_Misc_Dice_01:25:25|t "..TRP2_Joueur.." "..TRP2_LOC_UI_JetDeDesGET.." : "..tir1.." + "..tir2.." + "..tir3.." = "..total.." (3d10)";
		elseif randType == "8" then
			rand = "|TInterface\\ICONS\\INV_Misc_Dice_01:25:25|t "..TRP2_Joueur.." "..TRP2_LOC_UI_JetDeDesGET.." : "..math.random(12).." (1d12)";
		elseif randType == "9" then
			local tir1 = math.random(12);
			local tir2 = math.random(12);
			local total = tir1 + tir2;
			rand = "|TInterface\\ICONS\\INV_Misc_Dice_01:25:25|t "..TRP2_Joueur.." "..TRP2_LOC_UI_JetDeDesGET.." : "..tir1.." + "..tir2.." = "..total.." (2d12)";
		elseif randType == "10" then
			rand = "|TInterface\\ICONS\\INV_Misc_Dice_01:25:25|t "..TRP2_Joueur.." "..TRP2_LOC_UI_JetDeDesGET.." : "..math.random(20).." (1d20)";
		elseif randType == "11" then
			local tir1 = math.random(20);
			local tir2 = math.random(20);
			local total = tir1 + tir2;
			rand = "|TInterface\\ICONS\\INV_Misc_Dice_01:25:25|t "..TRP2_Joueur.." "..TRP2_LOC_UI_JetDeDesGET.." : "..tir1.." + "..tir2.." = "..total.." (2d20)";
		end
		TRP2_Afficher("{j}"..rand,TRP2_GetConfigValueFor("InvMessageFrameRP",1),true);
		TRP2_SecureSendAddonMessageGroup("MERP","{j}"..rand);
		if UnitExists("target") and not UnitInRaid("target") and not UnitInParty("target") then
			TRP2_SecureSendAddonMessage("MERP","{j}"..rand,UnitName("target"));
		end
	end
end

function TRP2_Histolink(link,texte)
	StaticPopupDialogs["TRP2_GET_TEXT_NS"].text = TRP2_CTS(TRP2_FT(TRP2_ENTETE..TRP2_LOC_URLCLIC,texte));
	TRP2_ShowStaticPopup("TRP2_GET_TEXT_NS",nil,nil,nil,nil,nil,nil,"http://"..link);
end

-------------------------------
--- BARRE DE CASTING
-------------------------------

function TRP2_CastingBarFrameStart(texte, endTime, anim, func, arg1, arg2, arg3, arg4, arg5, bCanStop, bImmo)
	
	local selfName = TRP2_CastingBarFrame:GetName();
	local barSpark = _G[selfName.."Spark"];
	local barText = _G[selfName.."Text"];
	local barBorder = _G[selfName.."Border"];

	TRP2_CastingBarFrame:SetStatusBarColor(1.0, 0.7, 0.0);
	if ( barSpark ) then
		barSpark:Show();
	end
	TRP2_CastingBarFrame.value = 0;
	TRP2_CastingBarFrame.maxValue = endTime;
	TRP2_CastingBarFrame.func = func;
	TRP2_CastingBarFrame.arg1 = arg1;
	TRP2_CastingBarFrame.arg2 = arg2;
	TRP2_CastingBarFrame.arg3 = arg3;
	TRP2_CastingBarFrame.arg4 = arg4;
	TRP2_CastingBarFrame.arg5 = arg5;
	TRP2_CastingBarFrame.bCanStop = bCanStop;
	TRP2_CastingBarFrame.bImmo = bCanStop;
	if anim then
		TRP2_CastingBarFrameModele.seqtime=0;
		TRP2_CastingBarFrameModele.sequence=anim;
		TRP2_CastingBarFrameModele:SetUnit("player");
		TRP2_CastingBarFrameModele:Show();
	else
		TRP2_CastingBarFrameModele:Hide();
	end
	
	TRP2_CastingBarFrame:SetMinMaxValues(0, TRP2_CastingBarFrame.maxValue);
	TRP2_CastingBarFrame:SetValue(TRP2_CastingBarFrame.value);
	if ( barText ) then
		barText:SetText(texte);
	end
	TRP2_CastingBarFrame:SetAlpha(1.0);
	TRP2_CastingBarFrame.holdTime = 0;
	TRP2_CastingBarFrame.casting = 1;
	TRP2_CastingBarFrame.fadeOut = nil;
	if ( barBorder ) then
		barBorder:Show();
	end
	TRP2_CastingBarFrame:Show();
end

function TRP2_CastingBarFrameInterrupt(intType)
	if TRP2_CastingBarFrame:IsShown() and not TRP2_CastingBarFrame.fadeOut and TRP2_CastingBarFrame.bCanStop then
		local selfName = TRP2_CastingBarFrame:GetName();
		local barSpark = _G[selfName.."Spark"];
		local barText = _G[selfName.."Text"];
		TRP2_CastingBarFrame:SetValue(TRP2_CastingBarFrame.maxValue);
		TRP2_CastingBarFrame:SetStatusBarColor(1.0, 0.0, 0.0);
		if ( barSpark ) then
			barSpark:Hide();
		end
		if ( barText ) then
			if ( intType == "FAILED" ) then
				barText:SetText(FAILED);
			else
				barText:SetText(INTERRUPTED);
			end
		end
		TRP2_CastingBarFrame.casting = nil;
		TRP2_CastingBarFrame.fadeOut = 1;
		TRP2_CastingBarFrame.holdTime = GetTime() + CASTING_BAR_HOLD_TIME;
	end
end
	
function TRP2_CastingBarFrame_OnUpdate (self, elapsed)
	local barSpark = _G[self:GetName().."Spark"];
	local barFlash = _G[self:GetName().."Flash"];

	if ( self.casting ) then
		if self.bImmo and GetUnitSpeed("player") > 0 then
			TRP2_CastingBarFrameInterrupt("INTERRUPTED");
			return;
		end
		self.value = self.value + elapsed;
		if ( self.value >= self.maxValue ) then
			self:SetValue(self.maxValue);
			TRP2_CastingBarFrame_Finish(self, barSpark, barFlash);
			return;
		end
		self:SetValue(self.value);
		if ( barFlash ) then
			barFlash:Hide();
		end
		if ( barSpark ) then
			local sparkPosition = (self.value / self.maxValue) * self:GetWidth();
			barSpark:SetPoint("CENTER", self, "LEFT", sparkPosition, 2);
		end
	elseif ( GetTime() < self.holdTime ) then
		return;
	elseif ( self.flash ) then
		local alpha = 0;
		if ( barFlash ) then
			alpha = barFlash:GetAlpha() + CASTING_BAR_FLASH_STEP;
		end
		if ( alpha < 1 ) then
			if ( barFlash ) then
				barFlash:SetAlpha(alpha);
			end
		else
			if ( barFlash ) then
				barFlash:SetAlpha(1.0);
			end
			self.flash = nil;
		end
	elseif ( self.fadeOut ) then
		local alpha = self:GetAlpha() - CASTING_BAR_ALPHA_STEP;
		if ( alpha > 0 ) then
			self:SetAlpha(alpha);
		else
			self.fadeOut = nil;
			self:Hide();
		end
	end
end

function TRP2_CastingBarFrame_Finish (self, barSpark, barFlash)
	self:SetStatusBarColor(0.0, 1.0, 0.0);
	if ( barSpark ) then
		barSpark:Hide();
	end
	if ( barFlash ) then
		barFlash:SetAlpha(0.0);
		barFlash:Show();
	end
	self.flash = 1;
	self.fadeOut = 1;
	self.casting = nil;
	
	if self.func then
		TRP2_PCall(self.func,self.arg1,self.arg2,self.arg3,self.arg4,self.arg5);
	end
end

function TRP2_Localisation_SetUI()
	TRP2_SetTooltipForFrame(TRP2_CreationFrameBaseListeAuraImport,TRP2_CreationFrameBaseListeAuraImport,"BOTTOM",0,0,"{w}"..TRP2_LOC_IMPORTSTATE,"{o}"..TRP2_LOC_IMPORTSTATETT);
	TRP2_SetTooltipForFrame(TRP2_RaccBarPlanqueBouton,TRP2_RaccBarPlanqueBouton,"BOTTOM",0,0,"{w}"..TRP2_LOC_COORDGEST,"{j}"..TRP2_LOC_CLIC.." : {w}"..TRP2_LOC_SHOWMENU);
	TRP2_SetTooltipForFrame(TRP2ConfigSliderTTPersoAnchorPoint,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_PAR_AnchorPoint,"{o}"..TRP2_LOC_PAR_AnchorPointTT1);
	TRP2_SetTooltipForFrame(TRP2ConfigSliderTTMountAnchorPoint,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_PAR_AnchorPoint,"{o}"..TRP2_LOC_PAR_AnchorPointTT2);
	TRP2_SetTooltipForFrame(TRP2ConfigSliderAnchorTTTRP,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_PAR_AnchorTT,"{o}"..TRP2_LOC_PAR_AnchorTT_TT1);
	TRP2_SetTooltipForFrame(TRP2ConfigSliderAnchorTTMount,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_PAR_AnchorTT,"{o}"..TRP2_LOC_PAR_AnchorTT_TT2);
	TRP2_SetTooltipForFrame(TRP2ConfigEditBoxMapToUse,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_PAR_MapToUse,"{o}"..TRP2_LOC_PAR_MapToUseTT);
	TRP2_SetTooltipForFrame(TRP2ConfigCheckChatNoGuild,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_PAR_GuildIC,"{o}"..TRP2_LOC_PAR_GuildICTT);
	TRP2_SetTooltipForFrame(TRP2ConfigCheckUseCoord,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_PAR_UseCoord,"{o}"..TRP2_LOC_PAR_UseCoordTT);
	TRP2_RegistreAurasPanelBoutonForce:SetText(TRP2_LOC_RECUP);
	TRP2_SetTooltipForFrame(TRP2_RegistreAurasPanelBoutonForce,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_RECUP,"{o}"..TRP2_LOC_RECUPTT);
	TRP2_SetTooltipForFrame(TRP2ConfigSliderAccessEtat,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_PAR_EtatAcces,"{o}"..TRP2_LOC_PAR_EtatAccesTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameBaseListeAuraEpurer,TRP2_CreationFrameBaseListeAuraEpurer,"bottom",0,-5,"{w}"..TRP2_LOC_EPURETATPre,"{o}"..TRP2_LOC_EPURETATTT);
	TRP2_SetTooltipForFrame(TRP2ConfigCheckActivexc,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_PAR_ActivateExchange,"{o}"..TRP2_LOC_PAR_ActivateExchangeTT);
	TRP2_SetTooltipForFrame(TRP2ConfigCheckChatNoName,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_NomDeFamille,"{o}"..TRP2_LOC_NomDeFamilleTT);
	TRP2_SetTooltipForFrame(TRP2ConfigCheckChatNoTitle,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_TITRE,"{o}"..TRP2_LOC_TitreTT);
	TRP2_SetTooltipForFrame(TRP2ConfigCheckChatNoColor,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_COLOR,"{o}"..TRP2_LOC_NoColorTT);
	TRP2_SetTooltipForFrame(TRP2ConfigCheckTooltipNoColor,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_COLOR,"{o}"..TRP2_LOC_NoTooltipColorTT);
	TRP2_SetTooltipForFrame(TRP2_ListeSmallCheckDatabase,TRP2_ListeSmallCheckDatabase,"bottom",0,-5,"{w}"..TRP2_LOC_DB,"{o}"..TRP2_LOC_DBTT);
	TRP2_SetTooltipForFrame(TRP2_ListeSmallCheckOther,TRP2_ListeSmallCheckOther,"bottom",0,-5,"{w}"..TRP2_LOC_OTHERS,"{o}"..TRP2_LOC_OTHERSTT);
	TRP2_SetTooltipForFrame(TRP2ConfigCheckTTUseTTTRP,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_PAR_TRPTT,"{o}"..TRP2_LOC_PAR_TRPTTTT);
	TRP2_SetTooltipForFrame(TRP2ConfigCheckTTUseTTMount,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_PAR_TRPTTMount,"{o}"..TRP2_LOC_PAR_TRPTTMountTT);
	TRP2_SetTooltipForFrame(TRP2ConfigCheckTTUseTTCombat,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_PAR_TRPTTInCombat,"{o}"..TRP2_LOC_PAR_TRPTTInCombatTT);
	TRP2_SetTooltipForFrame(TRP2ConfigCheckChatNoEmoteCrier,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_PAR_NoYellingEmote,"{o}"..TRP2_LOC_PAR_NoYellingEmoteTT);
	TRP2_SetTooltipForFrame(TRP2ConfigCheckAnchorChatFrame,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_Achnor_Chat,"{o}"..TRP2_LOC_Achnor_ChatTT);
	TRP2_SetTooltipForFrame(TRP2ConfigCheckAnchorSpeack,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_Achnor_Paroles,"{o}"..TRP2_LOC_Achnor_ParolesTT);
	TRP2_SetTooltipForFrame(TRP2ConfigCheckAnchorEmote,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_Achnor_Emote,"{o}"..TRP2_LOC_Achnor_EmoteTT);
	TRP2_SetTooltipForFrame(TRP2ConfigCheckAnchorItemRef,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_Achnor_ItemRef,"{o}"..TRP2_LOC_Achnor_ItemRefTT);
	TRP2_SetTooltipForFrame(TRP2ConfigCheckCreaNoSpeckEffet,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_NODIAL,"{o}"..TRP2_LOC_NODIALTT);
	TRP2_SetTooltipForFrame(TRP2ConfigCheckMinimap,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_MINIMAPOK,"{o}"..TRP2_LOC_MINIMAPOKTT);
	TRP2_SetTooltipForFrame(TRP2ConfigSliderScriptsAcces,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_AccessLevelScript,"{o}"..TRP2_LOC_AccessLevelScriptTT);
	TRP2_SetTooltipForFrame(TRP2ConfigSliderSonsglobauxAcces,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_AccessLevelSound,"{o}"..TRP2_LOC_GlobSoundAccesTT);
	TRP2_SetTooltipForFrame(TRP2ConfigSliderParolesAcces,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_AccessLevelDialog,"{o}"..TRP2_LOC_AccessLevelDialogTT);
	TRP2_SetTooltipForFrame(TRP2ConfigCheckTTHideold,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_PAR_HideOT,"{o}"..TRP2_LOC_PAR_HideOT_TT);
	TRP2_SetTooltipForFrame(TRP2ConfigCheckTTPerso_Titre,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_PAR_NomReduit,"{o}"..TRP2_LOC_PAR_NomReduitTT);
	TRP2_SetTooltipForFrame(TRP2ConfigCheckUseSound,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..ENABLE_SOUND,"{o}"..TRP2_LOC_ENABLE_SOUNDTT);
	TRP2_SetTooltipForFrame(TRP2ConfigSliderAccessHisto,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_PAR_DefautHisto,"{o}"..TRP2_LOC_PAR_DefautHistoTT);
	TRP2_SetTooltipForFrame(TRP2ConfigSliderAccessDefaut,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_PAR_DefautAcces,"{o}"..TRP2_LOC_PAR_DefautAccesTT);
	TRP2_SetTooltipForFrame(TRP2ConfigCheckNotifyNew,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_PAR_NotifyNew,"{o}"..TRP2_LOC_PAR_NotifyNewTT);
	TRP2_SetTooltipForFrame(TRP2ConfigCheckAutoNew,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_PAR_AutoNew,"{o}"..TRP2_LOC_PAR_AutoNewTT);
	TRP2_SetTooltipForFrame(TRP2ConfigCheckUseIcon,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_PAR_UsePlayerIcon,"{o}"..TRP2_LOC_PAR_UsePlayerIconTT);
	TRP2_SetTooltipForFrame(TRP2ConfigSliderPNJMode,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_PNJMODE,"{o}"..TRP2_LOC_PNJMODETT);
	TRP2_SetTooltipForFrame(TRP2ConfigSliderEmoteMode,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_EMOTEMODE,"{o}"..TRP2_LOC_EMOTEMODETT);
	TRP2_SetTooltipForFrame(TRP2ConfigSliderHRPMode,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_HRPMODE,"{o}"..TRP2_LOC_HRPMODETT);
	TRP2_SetTooltipForFrame(TRP2ConfigCheckChatIconeBalise,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_PAR_BALIICO,"{o}"..TRP2_LOC_PAR_BALIICOTT);
	TRP2_SetTooltipForFrame(TRP2ConfigCheckAffichageRacc,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_RACCAFF,"{o}"..TRP2_LOC_RACCAFFTT);
	TRP2_SetTooltipForFrame(TRP2ConfigSliderAlpharaccbar,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_AlphaRaccBar,"{o}"..TRP2_LOC_AlphaRaccBarTT);
	TRP2_SetTooltipForFrame(TRP2ConfigSliderTargetEtatFrame,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_PAR_MMtoUse,"{o}"..TRP2_LOC_PAR_ETAFRameTT);
	TRP2_SetTooltipForFrame(TRP2ConfigSliderTargetEtatsY,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_PAR_ICOTARPOSY,"{o}"..TRP2_LOC_PAR_ETAYTT);
	TRP2_SetTooltipForFrame(TRP2ConfigSliderTargetEtatsX,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_PAR_ICOTARPOSX,"{o}"..TRP2_LOC_PAR_ETAXTT);
	TRP2_SetTooltipForFrame(TRP2ConfigSliderTargetIconFrame,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_PAR_MMtoUse,"{o}"..TRP2_LOC_PAR_PORFRameTT);
	TRP2_SetTooltipForFrame(TRP2ConfigSliderTargetIconY,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_PAR_ICOTARPOSY,"{o}"..TRP2_LOC_PAR_PORYTT);
	TRP2_SetTooltipForFrame(TRP2ConfigSliderTargetIconX,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_PAR_ICOTARPOSX,"{o}"..TRP2_LOC_PAR_PORXTT);
	TRP2_SetTooltipForFrame(TRP2ConfigCheckNotify,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_Notify,"{o}"..TRP2_LOC_NotifyTT);
	TRP2_SetTooltipForFrame(TRP2ConfigCheckCloseCombat,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_CloseCombat,"{o}"..TRP2_LOC_CloseCombatTT);
	TRP2_SetTooltipForFrame(TRP2ConfigEditBoxChannelToUse,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_PAR_ChannelToUseNom,"{o}"..TRP2_LOC_PAR_ChannelToUseNomTT);
	TRP2_SetTooltipForFrame(TRP2MainFrameMenuBarOngletGuide,TRP2MainFrameMenuBarOngletGuide,"top",0,5,"{w}"..TRP2_LOC_OPEN_HELP);
	TRP2_SetTooltipForFrame(TRP2_EffetMascotteFrameNom,TRP2_EffetMascotteFrameNom,"top",0,5,"{w}"..TRP2_LOC_NOM,"{o}"..TRP2_LOC_MascotteNomTT);
	
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurActuHRPBoutonHide,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_HRPINFO,"{j}"..TRP2_LOC_CLIC.." {w}: "..TRP2_LOC_MODIF);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurActuActuBoutonHide,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_Actu3,"{j}"..TRP2_LOC_CLIC.." {w}: "..TRP2_LOC_MODIF);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurActuNotesBoutonHide,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_NOTES,
		"{j}"..TRP2_LOC_CLIC.." {w}: "..TRP2_LOC_MODIF);
	TRP2_SetTooltipForFrame(TRP2MainFrameQuestsLogAffichageHelp,TRP2MainFrameQuestsLogAffichageHelp,"Top",0,0,"{w}"..DISPLAY,"{o}"..TRP2_LOC_QUESTDISPLAY);
	TRP2_SetTooltipForFrame(TRP2_RegistreListeEpurer,TRP2_RegistreListeEpurer,"Bottom",0,0,"{w}"..TRP2_LOC_EPURER,"{o}"..TRP2_LOC_EPURERTT);
	TRP2_SetTooltipForFrame(TRP2_RegistreListeDeleteAll,TRP2_RegistreListeDeleteAll,"Bottom",0,0,"{w}"..TRP2_LOC_DELETEALL,"{o}"..TRP2_LOC_REGDELALLTT);
	TRP2_SetTooltipForFrame(TRP2_NPCAnimFrameScrollScrollEditBox,TRP2_NPCAnimFrameScrollScroll,"top",0,10,"{w}"..TRP2_LOC_TEXT,"{o}"..TRP2_LOC_TEXTEANIMTT);
	TRP2_SetTooltipForFrame(TRP2_NPCAnimFrameScrollScroll,TRP2_NPCAnimFrameScrollScroll,"top",0,10,"{w}"..TRP2_LOC_TEXT,"{o}"..TRP2_LOC_TEXTEANIMTT);
	TRP2_SetTooltipForFrame(TRP2_NPCAnimFrameScrollNomSaisie,TRP2_NPCAnimFrameScrollNomSaisie,"top",0,0,"{w}"..TARGET,"{o}"..TRP2_LOC_TARGETTAKE);
	TRP2_SetTooltipForFrame(TRP2_DialQuestFramePlayButton,TRP2_DialQuestFramePlayButton,"Bottom",0,0,"{w}"..TRP2_LOC_PLAY,"{o}"..TRP2_LOC_PLAYTT);
	TRP2_SetTooltipForFrame(TRP2_FicheLanguagesOngletMenuLangues,TRP2_FicheLanguagesOngletMenuLangues,"TOP",0,0,"{w}"..ADD,"{o}"..TRP2_LOC_STARTDIAL);
        TRP2_SetTooltipForFrame(TRP2_PurgeLanguagesButton,TRP2_PurgeLanguagesButton,"TOP",0,0,"{w}"..TRP2_LOC_PURGELANG,"{o}"..TRP2_LOC_PURGELANGTT);
	TRP2_SetTooltipForFrame(TRP2MainFrameQuestsLogListeAjout,TRP2MainFrameQuestsLogListeAjout,"TOP",0,0,"{w}"..ADD,"{o}"..TRP2_LOC_STARTQUEST2);
	TRP2_SetTooltipForFrame(TRP2_EffetQuestFrameSaisieEtape,TRP2_EffetQuestFrameSaisieEtape,"TOP",0,0,"{w}"..TRP2_LOC_ETAPESID,"{o}"..TRP2_LOC_ETAPEIDTT);
	TRP2_SetTooltipForFrame(TRP2_EffetQuestFrameModeHelp,TRP2_EffetQuestFrameModeHelp,"TOP",0,0,"{w}"..MODE,"{o}"..TRP2_LOC_MODEQUESTS);
	TRP2_SetTooltipForFrame(TRP2_EffetDurabiliteFrameSaisieQte,TRP2_EffetDurabiliteFrameSaisieQte,"TOP",0,0,"{w}"..TRP2_LOC_MONTANT,"{o}"..TRP2_LOC_MONTANTDGTSAC);
	TRP2_SetTooltipForFrame(TRP2_EffetDurabiliteFrameModeHelp,TRP2_EffetDurabiliteFrameModeHelp,"TOP",0,0,"{w}"..MODE,"{o}"..TRP2_LOC_DEGATYPE);
	TRP2_SetTooltipForFrame(TRP2_EffetDurabiliteFrameTypeHelp,TRP2_EffetDurabiliteFrameTypeHelp,"TOP",0,0,"{w}"..BAGSLOTTEXT,"{o}"..TRP2_LOC_DEGATCIBLE);
	TRP2_SetTooltipForFrame(TRP2_EffetSonFrameSaisiePorte,TRP2_EffetSonFrameSaisiePorte,"TOP",0,0,"{w}"..TRP2_LOC_PORTESON,"{o}"..TRP2_LOC_PORTESONTT);
	TRP2_SetTooltipForFrame(TRP2_EffetSonFrameModeHelp,TRP2_EffetSonFrameModeHelp,"TOP",0,0,"{w}"..MODE,"{o}"..TRP2_LOC_URLSONMODETT);
	TRP2_SetTooltipForFrame(TRP2_EffetSonFrameSaisieSonScrollEditBox,TRP2_EffetSonFrameSaisieSonScroll,"TOP",0,0,"{w}"..TRP2_LOC_URLSON,"{o}"..TRP2_LOC_URLSONTT);
	TRP2_SetTooltipForFrame(TRP2_EffetSonFrameSaisieSonScroll,TRP2_EffetSonFrameSaisieSonScroll,"TOP",0,0,"{w}"..TRP2_LOC_URLSON,"{o}"..TRP2_LOC_URLSONTT);
	TRP2_SetTooltipForFrame(TRP2_EffetCoolFrameSaisieTime,TRP2_EffetCoolFrameSaisieTime,"TOP",0,0,"{w}"..TRP2_LOC_DUREE,"{o}"..TRP2_LOC_DUREECOOL);
	TRP2_SetTooltipForFrame(TRP2_EffetObjetFrameSaisieQte,TRP2_EffetObjetFrameSaisieQte,"TOP",0,0,"{w}"..TRP2_LOC_QUANTITE,"{o}"..TRP2_LOC_QUANTITEOBJ_TT);
	TRP2_SetTooltipForFrame(TRP2_EffetObjetFrameModeHelp,TRP2_EffetObjetFrameModeHelp,"TOP",0,0,"{w}"..MODE,"{o}"..TRP2_LOC_MODEOBJTT);
	TRP2_SetTooltipForFrame(TRP2_EffetLifetimeFrameSaisieTime,TRP2_EffetLifetimeFrameSaisieTime,"TOP",0,0,"{w}"..TRP2_LOC_DUREE,"{o}"..TRP2_LOC_DUREETIMETT);
	TRP2_SetTooltipForFrame(TRP2_EffetLangFrameSaisieEtape,TRP2_EffetLangFrameSaisieEtape,"TOP",0,0,"{w}"..TRP2_LOC_MAITRISE,"{o}"..TRP2_LOC_MAITRISETT);
	TRP2_SetTooltipForFrame(TRP2_EffetLangFrameModeHelp,TRP2_EffetLangFrameModeHelp,"TOP",0,0,"{w}"..TRP2_LOC_ADDMETHODE,"{o}"..TRP2_LOC_ADDMETHODEQUEST_TT);
	TRP2_SetTooltipForFrame(TRP2_EffetTexteFrameTypeDropDownHelp,TRP2_EffetTexteFrameTypeDropDownHelp,"TOP",0,0,"{w}"..DISPLAY,"{o}"..TRP2_LOC_TEXTDISPLAY_TT);
	TRP2_SetTooltipForFrame(TRP2_EffetOrFrameSaisieQte,TRP2_EffetOrFrameSaisieQte,"TOP",0,0,"{w}"..TRP2_LOC_MONTANT,"{o}"..TRP2_LOC_MONTANTTT);
	TRP2_SetTooltipForFrame(TRP2_EffetOrFrameModeHelp,TRP2_EffetOrFrameModeHelp,"TOP",0,0,"{w}"..MODE,"{o}"..TRP2_LOC_MODEORTT);
	TRP2_EffetAuraFrameAuraTitre:SetText(TRP2_CTS("{o}"..TRP2_LOC_AURACHOOSE));
	TRP2_SetTooltipForFrame(TRP2_EffetAuraFrameSaisieTime,TRP2_EffetAuraFrameSaisieTime,"TOP",0,0,"{w}"..TRP2_LOC_DUREE,"{o}"..TRP2_LOC_DUREEAURA_TT);
	TRP2_SetTooltipForFrame(TRP2_EffetAuraFrameModeHelp,TRP2_EffetAuraFrameModeHelp,"TOP",0,0,"{w}"..MODE,"{o}"..TRP2_LOC_MODEAURATT);
	TRP2_SetTooltipForFrame(TRP2_EffetAuraFrameCibleHelp,TRP2_EffetAuraFrameCibleHelp,"TOP",0,0,"{w}"..TARGET,"{o}"..TRP2_LOC_TARGETTT);
	TRP2_SetTooltipForFrame(TRP2_CreationPlanqueFrameNom,TRP2_CreationPlanqueFrameNom,"TOP",0,0,"{w}"..TRP2_LOC_NOM,"{o}"..TRP2_LOC_NOMPLANQUE_TT);
	TRP2_SetTooltipForFrame(TRP2_CreationPlanqueFrameAccessNomsScroll,TRP2_CreationPlanqueFrameAccessNomsScroll,"TOP",0,10,"{w}"..TRP2_LOC_PersonnagePerm,"{o}"..TRP2_LOC_PersonnagePerm_TT);
	TRP2_SetTooltipForFrame(TRP2_CreationPlanqueFrameAccessNomsScrollEditBox,TRP2_CreationPlanqueFrameAccessNomsScroll,"TOP",0,10,"{w}"..TRP2_LOC_PersonnagePerm,"{o}"..TRP2_LOC_PersonnagePerm_TT);
	TRP2_SetTooltipForFrame(TRP2_CreationPlanqueFrameAccessLevelHelp,TRP2_CreationPlanqueFrameAccessLevelHelp,"TOP",0,0,"{w}"..TRP2_LOC_AccessChange,"{o}"..TRP2_LOC_PlanqueAcces_TT);
	TRP2_SetTooltipForFrame(TRP2_CreationPlanqueFrameIcone,TRP2_CreationPlanqueFrameIcone,"TOP",0,0,"{w}"..TRP2_LOC_ICONEOBJ,"{j}"..TRP2_LOC_CLIC.." : {w}"..TRP2_LOC_ICON_CHOIX);
	TRP2_SetTooltipForFrame(TRP2InventaireFramePanneauEdit,TRP2InventaireFramePanneauEdit,"BOTTOM",0,0,"{w}"..GAMEOPTIONS_MENU,"{j}"..TRP2_LOC_CLIC.." : {w}"..TRP2_LOC_MODIFPANNEAU.."\n{j}"..TRP2_LOC_CLICDROIT.." : {w}"..TRP2_LOC_DELETEPANNEAU);
	TRP2_SetTooltipForFrame(TRP2_CreationPanneauFrameNom,TRP2_CreationPanneauFrameNom,"TOP",0,0,"{w}"..TRP2_LOC_NOM,"{o}"..TRP2_LOC_NOMPANNEAU_TT);
	TRP2_SetTooltipForFrame(TRP2_CreationPanneauFrameAccessNomsScroll,TRP2_CreationPanneauFrameAccessNomsScroll,"TOP",0,10,"{w}"..TRP2_LOC_PersonnagePerm,"{o}"..TRP2_LOC_PanneauPerm_TT);
	TRP2_SetTooltipForFrame(TRP2_CreationPanneauFrameAccessNomsScrollEditBox,TRP2_CreationPanneauFrameAccessNomsScroll,"TOP",0,10,"{w}"..TRP2_LOC_PersonnagePerm,"{o}"..TRP2_LOC_PanneauPerm_TT);
	TRP2_SetTooltipForFrame(TRP2_CreationPanneauFrameAccessLevelHelp,TRP2_CreationPanneauFrameAccessLevelHelp,"TOP",0,0,"{w}"..TRP2_LOC_AccessChange,"{o}"..TRP2_LOC_PanneauAcces_TT);
	TRP2_SetTooltipForFrame(TRP2_CreationPanneauFrameIcone,TRP2_CreationPanneauFrameIcone,"TOP",0,0,"{w}"..TRP2_LOC_ICONEOBJ,"{j}"..TRP2_LOC_CLIC.." : {w}"..TRP2_LOC_ICON_CHOIX);
	
	-- CREATIONS
	TRP2_SetTooltipForFrame(TRP2_EffetOrFrameSaisieQteCheck,TRP2_EffetOrFrameSaisieQteCheck,"TOP",0,0,"{w}"..TRP2_LOC_RANDOM,"{o}"..TRP2_LOC_RANDOM_TT);
	TRP2_SetTooltipForFrame(TRP2_EffetLifetimeFrameSaisieTimeCheck,TRP2_EffetLifetimeFrameSaisieTimeCheck,"TOP",0,0,"{w}"..TRP2_LOC_RANDOM,"{o}"..TRP2_LOC_RANDOM_TT);
	TRP2_SetTooltipForFrame(TRP2_EffetCoolFrameSaisieTimeCheck,TRP2_EffetCoolFrameSaisieTimeCheck,"TOP",0,0,"{w}"..TRP2_LOC_RANDOM,"{o}"..TRP2_LOC_RANDOM_TT);
	TRP2_SetTooltipForFrame(TRP2_EffetObjetFrameSaisieQteCheck,TRP2_EffetObjetFrameSaisieQteCheck,"TOP",0,0,"{w}"..TRP2_LOC_RANDOM,"{o}"..TRP2_LOC_RANDOM_TT);
	TRP2_SetTooltipForFrame(TRP2_EffetAuraFrameSaisieTimeCheck,TRP2_EffetAuraFrameSaisieTimeCheck,"TOP",0,0,"{w}"..TRP2_LOC_RANDOM,"{o}"..TRP2_LOC_RANDOM_TT);
	TRP2_SetTooltipForFrame(TRP2_EffetDurabiliteFrameSaisieQteCheck,TRP2_EffetDurabiliteFrameSaisieQteCheck,"TOP",0,0,"{w}"..TRP2_LOC_RANDOM,"{o}"..TRP2_LOC_RANDOM_TT);
	TRP2_EffetOrFrameSaisieQteCheckText:SetText(TRP2_LOC_RANDOM);
	TRP2_EffetDurabiliteFrameSaisieQteCheckText:SetText(TRP2_LOC_RANDOM);
	TRP2_EffetAuraFrameSaisieTimeCheckText:SetText(TRP2_LOC_RANDOM);
	TRP2_EffetObjetFrameSaisieQteCheckText:SetText(TRP2_LOC_RANDOM);
	TRP2_EffetCoolFrameSaisieTimeCheckText:SetText(TRP2_LOC_RANDOM);
	TRP2_EffetLifetimeFrameSaisieTimeCheckText:SetText(TRP2_LOC_RANDOM);
	TRP2_StateImportListTitre:SetText(TRP2_LOC_IMPORTSTATE);
	
	TRP2_CreationPanneauFrameTitle:SetText(TRP2_CTS(TRP2_LOC_CREATIONPANNEAU));
	TRP2_CreationFrameBaseCategorie:SetText(TRP2_LOC_CATEGORIES);
	TRP2_CreationFrameBaseListeObjetTitre:SetText(TRP2_CTS("|TInterface\\ICONS\\Inv_Gizmo_01.blp:25:25|t {w}"..TRP2_LOC_CREA_OBJET.." |TInterface\\ICONS\\Inv_Gizmo_01.blp:25:25|t"));
	TRP2_CreationFrameBaseListeAuraTitre:SetText(TRP2_CTS("|TInterface\\ICONS\\Spell_Holy_ImprovedResistanceAuras.blp:25:25|t {w}"..TRP2_LOC_CREA_AURA.." |TInterface\\ICONS\\Spell_Holy_ImprovedResistanceAuras.blp:25:25|t"));
	TRP2_CreationFrameBaseListeLangageTitre:SetText(TRP2_CTS("|TInterface\\ICONS\\Ability_Warrior_RallyingCry.blp:25:25|t {w}"..TRP2_LOC_CREA_LANG.." |TInterface\\ICONS\\Ability_Warrior_RallyingCry.blp:25:25|t"));
	TRP2_CreationFrameBaseListeDocumentTitre:SetText(TRP2_CTS("|TInterface\\ICONS\\INV_MISC_NOTE_02.blp:25:25|t {w}"..TRP2_LOC_CREA_DOCU.." |TInterface\\ICONS\\INV_MISC_NOTE_02.blp:25:25|t"));
	TRP2_CreationFrameBaseListeEventTitre:SetText(TRP2_CTS("|TInterface\\ICONS\\Achievement_Quests_Completed_05.blp:25:25|t {w}"..TRP2_LOC_CREA_EVENT.." |TInterface\\ICONS\\Achievement_Quests_Completed_05.blp:25:25|t"));
	TRP2_CreationFrameBaseListePackagesTitre:SetText(TRP2_CTS("|TInterface\\ICONS\\INV_Misc_Gift_05:25:25|t {w}"..TRP2_LOC_PACKAGES.." |TInterface\\ICONS\\INV_Misc_Gift_05:25:25|t"));
	TRP2_SetTooltipForFrame(TRP2_RegistreListeRelationSliderHelp,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_Relation,"{o}"..TRP2_LOC_REL_TT);
	TRP2_SetTooltipForFrame(TRP2_RegistreListeLevelSliderHelp,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_AccessLevel,"{o}"..TRP2_LOC_ACCESS_TT);
	TRP2_SetTooltipForFrame(TRP2_RegistreListeRechercheSaisie,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..SEARCH,"{o}"..TRP2_FT(TRP2_LOC_CHERCHER_TT,TRP2_LOC_CRIT_NOM));
	TRP2_SetTooltipForFrame(TRP2_PetFrameEditionFrameDescriScroll,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_PHYSIQUE,"{o}"..TRP2_LOC_PETPHYS_TT);
	TRP2_SetTooltipForFrame(TRP2_PetFrameEditionFrameDescriScrollEditBox,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_PHYSIQUE,"{o}"..TRP2_LOC_PETPHYS_TT);
	TRP2_SetTooltipForFrame(TRP2_PetFrameEditionFrameHistoireScroll,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_Histoire,"{o}"..TRP2_LOC_PETHIST_TT);
	TRP2_SetTooltipForFrame(TRP2_PetFrameEditionFrameHistoireScrollEditBox,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_Histoire,"{o}"..TRP2_LOC_PETHIST_TT);
	TRP2_SetTooltipForFrame(TRP2_PetFrameEditionNom,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_NOM,TRP2_LOC_PETNAME_TT);
	TRP2_SetTooltipForFrame(TRP2_PetFrameEditionIconChoix,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_ICONEOBJ,"{j}"..TRP2_LOC_CLIC.." {w}: "..TRP2_LOC_ICON_CHOIX);
	TRP2_SetTooltipForFrame(TRP2_PetsListeRechercheSaisie,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..SEARCH,"{o}"..TRP2_FT(TRP2_LOC_CHERCHER_TT,TRP2_LOC_CRIT_NOMPET));
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurActuStatutRPHelp,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_StatutRP,"{o}"..TRP2_LOC_StatutRP_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurActuStatutXPHelp,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_StatutXP,"{o}"..TRP2_LOC_StatutXP_TT);
	-- Psychobarre consulte
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurPsychoBar1HelpGauche,TRP2MainFrame,"RIGHT",-10,-415,"{icone:Spell_Holy_HolyGuidance:35} {w}"..TRP2_LOC_Pieux,"{o}"..TRP2_LOC_Pieux_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurPsychoBar1HelpDroite,TRP2MainFrame,"RIGHT",-10,-415,"{icone:INV_Gizmo_02:35} {w}"..TRP2_LOC_Rationnel,"{o}"..TRP2_LOC_Rationnel_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurPsychoBar2HelpGauche,TRP2MainFrame,"RIGHT",-10,-415,"{icone:Achievement_BG_CaptureFlag_EOS:35} {w}"..TRP2_LOC_Impulsif,"{o}"..TRP2_LOC_Impulsif_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurPsychoBar2HelpDroite,TRP2MainFrame,"RIGHT",-10,-415,"{icone:Spell_Shadow_Brainwash:35} {w}"..TRP2_LOC_Reflechi,"{o}"..TRP2_LOC_Reflechi_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurPsychoBar3HelpGauche,TRP2MainFrame,"RIGHT",-10,-415,"{icone:INV_Misc_Food_PineNut:35} {w}"..TRP2_LOC_Acete,"{o}"..TRP2_LOC_Acete_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurPsychoBar3HelpDroite,TRP2MainFrame,"RIGHT",-10,-415,"{icone:INV_Misc_Food_99:35} {w}"..TRP2_LOC_Bonvivant,"{o}"..TRP2_LOC_Bonvivant_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurPsychoBar4HelpGauche,TRP2MainFrame,"RIGHT",-10,-415,"{icone:Ability_Druid_Cower:35} {w}"..TRP2_LOC_Couard,"{o}"..TRP2_LOC_Couard_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurPsychoBar4HelpDroite,TRP2MainFrame,"RIGHT",-10,-415,"{icone:Ability_Paladin_BeaconofLight:35} {w}"..TRP2_LOC_Valeureux,"{o}"..TRP2_LOC_Valeureux_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurPsychoBar5HelpGauche,TRP2MainFrame,"RIGHT",-10,-415,"{icone:INV_Belt_27:35} {w}"..TRP2_LOC_Chaste,"{o}"..TRP2_LOC_Chaste_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurPsychoBar5HelpDroite,TRP2MainFrame,"RIGHT",-10,-415,"{icone:Spell_Shadow_SummonSuccubus:35} {w}"..TRP2_LOC_Luxurieux,"{o}"..TRP2_LOC_Luxurieux_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurPsychoBar6HelpGauche,TRP2MainFrame,"RIGHT",-10,-415,"{icone:INV_Misc_Coin_02:35} {w}"..TRP2_LOC_Egoiste,"{o}"..TRP2_LOC_Egoiste_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurPsychoBar6HelpDroite,TRP2MainFrame,"RIGHT",-10,-415,"{icone:INV_Misc_Gift_02:35} {w}"..TRP2_LOC_Genereux,"{o}"..TRP2_LOC_Genereux_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurPsychoBar7HelpGauche,TRP2MainFrame,"RIGHT",-10,-415,"{icone:Ability_Rogue_Disguise:35} {w}"..TRP2_LOC_Trompeur,"{o}"..TRP2_LOC_Trompeur_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurPsychoBar7HelpDroite,TRP2MainFrame,"RIGHT",-10,-415,"{icone:INV_Misc_Toy_07:35} {w}"..TRP2_LOC_Sincere,"{o}"..TRP2_LOC_Sincere_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurPsychoBar8HelpGauche,TRP2MainFrame,"RIGHT",-10,-415,"{icone:Ability_Warrior_Trauma:35} {w}"..TRP2_LOC_Cruel,"{o}"..TRP2_LOC_Cruel_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurPsychoBar8HelpDroite,TRP2MainFrame,"RIGHT",-10,-415,"{icone:INV_ValentinesCandySack:35} {w}"..TRP2_LOC_Misericordieux,"{o}"..TRP2_LOC_Misericordieux_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurPsychoBar9HelpGauche,TRP2MainFrame,"RIGHT",-10,-415,"{icone:Ability_Rogue_HonorAmongstThieves:35} {w}"..TRP2_LOC_Pragmatique,"{o}"..TRP2_LOC_Pragmatique_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurPsychoBar9HelpDroite,TRP2MainFrame,"RIGHT",-10,-415,"{icone:INV_Misc_GroupNeedMore:35} {w}"..TRP2_LOC_Conciliant,"{o}"..TRP2_LOC_Conciliant_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurPsychoBar10HelpGauche,TRP2MainFrame,"RIGHT",-10,-415,"{icone:INV_RoseBouquet01:35} {w}"..TRP2_LOC_Indulgent,"{o}"..TRP2_LOC_Indulgent_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurPsychoBar10HelpDroite,TRP2MainFrame,"RIGHT",-10,-415,"{icone:Ability_Hunter_SniperShot:35} {w}"..TRP2_LOC_Rencunier,"{o}"..TRP2_LOC_Rencunier_TT);
	-- Psychobarre edit
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurChaLuxSliderHelpDroite,TRP2MainFrame,"RIGHT",-10,-415,"{icone:INV_Gizmo_02:35} {w}"..TRP2_LOC_Rationnel,"{o}"..TRP2_LOC_Rationnel_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurChaLuxSliderHelpGauche,TRP2MainFrame,"RIGHT",-10,-415,"{icone:Spell_Holy_HolyGuidance:35} {w}"..TRP2_LOC_Pieux,"{o}"..TRP2_LOC_Pieux_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurIndRenSliderHelpDroite,TRP2MainFrame,"RIGHT",-10,-415,"{icone:Spell_Shadow_Brainwash:35} {w}"..TRP2_LOC_Reflechi,"{o}"..TRP2_LOC_Reflechi_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurIndRenSliderHelpGauche,TRP2MainFrame,"RIGHT",-10,-415,"{icone:Achievement_BG_CaptureFlag_EOS:35} {w}"..TRP2_LOC_Impulsif,"{o}"..TRP2_LOC_Impulsif_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurGenEgoSliderHelpDroite,TRP2MainFrame,"RIGHT",-10,-415,"{icone:INV_Misc_Food_99:35} {w}"..TRP2_LOC_Bonvivant,"{o}"..TRP2_LOC_Bonvivant_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurGenEgoSliderHelpGauche,TRP2MainFrame,"RIGHT",-10,-415,"{icone:INV_Misc_Food_PineNut:35} {w}"..TRP2_LOC_Acete,"{o}"..TRP2_LOC_Acete_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurSinTroSliderHelpDroite,TRP2MainFrame,"RIGHT",-10,-415,"{icone:Ability_Paladin_BeaconofLight:35} {w}"..TRP2_LOC_Valeureux,"{o}"..TRP2_LOC_Valeureux_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurSinTroSliderHelpGauche,TRP2MainFrame,"RIGHT",-10,-415,"{icone:Ability_Druid_Cower:35} {w}"..TRP2_LOC_Couard,"{o}"..TRP2_LOC_Couard_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurMisCruSliderHelpDroite,TRP2MainFrame,"RIGHT",-10,-415,"{icone:Spell_Shadow_SummonSuccubus:35} {w}"..TRP2_LOC_Luxurieux,"{o}"..TRP2_LOC_Luxurieux_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurMisCruSliderHelpGauche,TRP2MainFrame,"RIGHT",-10,-415,"{icone:INV_Belt_27:35} {w}"..TRP2_LOC_Chaste,"{o}"..TRP2_LOC_Chaste_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurModVanSliderHelpDroite,TRP2MainFrame,"RIGHT",-10,-415,"{icone:INV_Misc_Gift_02:35} {w}"..TRP2_LOC_Genereux,"{o}"..TRP2_LOC_Genereux_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurModVanSliderHelpGauche,TRP2MainFrame,"RIGHT",-10,-415,"{icone:INV_Misc_Coin_02:35} {w}"..TRP2_LOC_Egoiste,"{o}"..TRP2_LOC_Egoiste_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurPiePraSliderHelpDroite,TRP2MainFrame,"RIGHT",-10,-415,"{icone:INV_Misc_Toy_07:35} {w}"..TRP2_LOC_Sincere,"{o}"..TRP2_LOC_Sincere_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurPiePraSliderHelpGauche,TRP2MainFrame,"RIGHT",-10,-415,"{icone:Ability_Rogue_Disguise:35} {w}"..TRP2_LOC_Trompeur,"{o}"..TRP2_LOC_Trompeur_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurRefImpSliderHelpDroite,TRP2MainFrame,"RIGHT",-10,-415,"{icone:INV_ValentinesCandySack:35} {w}"..TRP2_LOC_Misericordieux,"{o}"..TRP2_LOC_Misericordieux_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurRefImpSliderHelpGauche,TRP2MainFrame,"RIGHT",-10,-415,"{icone:Ability_Warrior_Trauma:35} {w}"..TRP2_LOC_Cruel,"{o}"..TRP2_LOC_Cruel_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurAceBonSliderHelpDroite,TRP2MainFrame,"RIGHT",-10,-415,"{icone:INV_Misc_GroupNeedMore:35} {w}"..TRP2_LOC_Conciliant,"{o}"..TRP2_LOC_Conciliant_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurAceBonSliderHelpGauche,TRP2MainFrame,"RIGHT",-10,-415,"{icone:Ability_Rogue_HonorAmongstThieves:35} {w}"..TRP2_LOC_Pragmatique,"{o}"..TRP2_LOC_Pragmatique_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurValCouSliderHelpDroite,TRP2MainFrame,"RIGHT",-10,-415,"{icone:Ability_Hunter_SniperShot:35} {w}"..TRP2_LOC_Rencunier,"{o}"..TRP2_LOC_Rencunier_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurValCouSliderHelpGauche,TRP2MainFrame,"RIGHT",-10,-415,"{icone:INV_RoseBouquet01:35} {w}"..TRP2_LOC_Indulgent,"{o}"..TRP2_LOC_Indulgent_TT);
	
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurChaLoySliderHelpGauche,TRP2MainFrame,"RIGHT",-10,-415,"{icone:Ability_Rogue_WrongfullyAccused:35} {w}"..TRP2_LOC_Chaotique,"{o}"..TRP2_LOC_Chaotique_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurChaLoySliderHelpDroite,TRP2MainFrame,"RIGHT",-10,-415,"{icone:Ability_Paladin_SanctifiedWrath:35} {w}"..TRP2_LOC_Loyal,"{o}"..TRP2_LOC_Loyal_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurPsychoBar11HelpGauche,TRP2MainFrame,"RIGHT",-10,-415,"{icone:Ability_Rogue_WrongfullyAccused:35} {w}"..TRP2_LOC_Chaotique,"{o}"..TRP2_LOC_Chaotique_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurPsychoBar11HelpDroite,TRP2MainFrame,"RIGHT",-10,-415,"{icone:Ability_Paladin_SanctifiedWrath:35} {w}"..TRP2_LOC_Loyal,"{o}"..TRP2_LOC_Loyal_TT);
	
	TRP2_FicheJoueurChaLoySlider.textDroite = TRP2_LOC_Loyal;
	TRP2_FicheJoueurChaLoySlider.textGauche = TRP2_LOC_Chaotique;
	
	TRP2_CreationFrameDocumentFrameStringShowGradText:SetText(TRP2_CTS("{o}"..TRP2_LOC_REPERES));
	
	TRP2_SetTooltipForFrame(TRP2MainFrameFicheJoueurHistoireEdition,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_Histoire,"{o}"..TRP2_LOC_Histoire_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurHistoireEditBox,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_Histoire,"{o}"..TRP2_LOC_Histoire_TT);
	TRP2_SetTooltipForFrame(TRP2MainFrameFicheJoueurPhysiqueEdition,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_PHYSIQUE,"{o}"..TRP2_LOC_PHYSIQUE_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurPhysiqueEditBox,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_PHYSIQUE,"{o}"..TRP2_LOC_PHYSIQUE_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurTailleSliderHelp,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_TAILLE,"{o}"..TRP2_LOC_TAILLE_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurSilhouetteSliderHelp,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_SILHOUETTE,"{o}"..TRP2_LOC_SILHOUETTE_TT);
	TRP2_SetTooltipForFrame(TRP2_PetFrameOngletConsulte,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_Consulte,"{o}"..TRP2_LOC_Consulte_TT);
	TRP2_SetTooltipForFrame(TRP2_PetFrameOngletEdition,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_Edition,"{o}"..TRP2_LOC_Edition_TT);
	TRP2_SetTooltipForFrame(TRP2MainFrameFicheJoueurMenuOngletOngletEdition,TRP2MainFrame,"RIGHT",-10,-415,TRP2_LOC_Edition,TRP2_LOC_Edition_TT);
	TRP2_SetTooltipForFrame(TRP2MainFrameFicheJoueurMenuOngletOngletConsulte,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_Consulte,"{o}"..TRP2_LOC_Consulte_TT);
	TRP2_SetTooltipForFrame(TRP2_PetOngletMenuAura,TRP2MainFrame,"RIGHT",-10,-415,TRP2_LOC_AURAAjout,TRP2_LOC_AURAAjoutTTPET);
	TRP2_SetTooltipForFrame(TRP2_RegistreOngletMenuAura,TRP2MainFrame,"RIGHT",-10,-415,TRP2_LOC_AURAAjout,TRP2_LOC_AURAAjoutTT);
	TRP2_SetTooltipForFrame(TRP2PlanqueFrameEdit,TRP2PlanqueFrameEdit,"RIGHT",0,0,"{w}"..TRP2_LOC_Edition,"{j}"..TRP2_LOC_CLIC.." : {w}"..TRP2_LOC_MODIFPLANQUE.."\n{j}"..TRP2_LOC_CLICDROIT.." : {w}"..TRP2_LOC_DELETEPLANQUE);
	
	TRP2_SetTooltipForFrame(TRP2MainFrameFicheJoueurOngletRegistreOngletGeneral,TRP2MainFrameFicheJoueurOngletRegistreOngletGeneral,"BOTTOM",0,0,TRP2_LOC_General);
	TRP2_SetTooltipForFrame(TRP2MainFrameFicheJoueurOngletRegistreOngletPhysique,TRP2MainFrameFicheJoueurOngletRegistreOngletPhysique,"BOTTOM",0,0,TRP2_LOC_Physique);
	TRP2_SetTooltipForFrame(TRP2MainFrameFicheJoueurOngletRegistreOngletPsycho,TRP2MainFrameFicheJoueurOngletRegistreOngletPsycho,"BOTTOM",0,0,TRP2_LOC_Psycho);
	TRP2_SetTooltipForFrame(TRP2MainFrameFicheJoueurOngletRegistreOngletHistoire,TRP2MainFrameFicheJoueurOngletRegistreOngletHistoire,"BOTTOM",0,0,TRP2_LOC_Histoire);
	TRP2_SetTooltipForFrame(TRP2MainFrameFicheJoueurOngletRegistreOngletCaracteristiques,TRP2MainFrameFicheJoueurOngletRegistreOngletCaracteristiques,"BOTTOM",0,0,TRP2_LOC_AuraCaract);
	TRP2_SetTooltipForFrame(TRP2MainFrameFicheJoueurOngletRegistreOngletActu,TRP2MainFrameFicheJoueurOngletRegistreOngletActu,"BOTTOM",0,0,TRP2_LOC_Actuellement);
	
	TRP2_SetTooltipForFrame(TRP2_MinimapButton,TRP2_MinimapButton,"LEFT",10,0,"{v}"..TRP2_LOC_TOTALRP,
		"{j}"..TRP2_LOC_CLIC.." {w}: "..TRP2_LOC_OPENMENU.."\n{j}"..TRP2_LOC_CLICDROIT.." {w}: "..TRP2_LOC_OPENRACC);
	-- Inventaire
	TRP2_SetTooltipForFrame(TRP2SacGoldBouton,TRP2SacGoldBouton,"bottom",0,0,
		"|TInterface\\ICONS\\INV_Misc_Coin_02.blp:35:35|t {w}"..TRP2_LOC_BOURSE,"{w}"..TRP2_LOC_BOURSE_TT);
	TRP2_SetTooltipForFrame(TRP2SacFramePortraitBouton,TRP2SacFramePortraitBouton,"RIGHT",0,-23,"","");
	
	TRP2_SetTooltipForFrame(TRP2PlanqueGoldBouton,TRP2PlanqueGoldBouton,"bottom",0,0,
		"|TInterface\\ICONS\\INV_Misc_Coin_02.blp:35:35|t {w}"..TRP2_LOC_ORPLANQUE,"{w}"..TRP2_LOC_ORPLANQUE_TT);
	TRP2_SetTooltipForFrame(TRP2CoffreGoldBouton,TRP2CoffreGoldBouton,"bottom",0,0,
		"|TInterface\\ICONS\\INV_Misc_Coin_02.blp:35:35|t {w}"..TRP2_LOC_ORCOFFRE,"{w}"..TRP2_LOC_ORCOFFRE_TT);
	TRP2_SetTooltipForFrame(TRP2CoffreFramePortraitBouton,TRP2CoffreFramePortraitBouton,"RIGHT",0,-23,"","");
	TRP2_SetTooltipForFrame(TRP2SacPoidsBouton,TRP2SacPoidsBouton,"bottom",0,0,
		"|TInterface\\ICONS\\INV_Stone_WeightStone_06.blp:35:35|t {w}"..TRP2_LOC_POIDSTOTAL,"{w}"..TRP2_LOC_POIDSTOTAL_TT);
	TRP2_SetTooltipForFrame(TRP2CoffrePoidsBouton,TRP2CoffrePoidsBouton,"bottom",0,0,
		"|TInterface\\ICONS\\INV_Stone_WeightStone_06.blp:35:35|t {w}"..TRP2_LOC_POIDSTOTAL,"{w}"..TRP2_LOC_POIDSCOFFRE_TT);
	TRP2_SetTooltipForFrame(TRP2SacDurabilityBouton,TRP2SacDurabilityBouton,"bottom",0,0,
		"|TInterface\\ICONS\\INV_Gizmo_RocketBoot_Destroyed_02:35:35|t {w}"..DURABILITY,"{w}"..TRP2_LOC_DURABILITYSAC_TT);
	TRP2_SetTooltipForFrame(TRP2CoffreDurabilityBouton,TRP2CoffreDurabilityBouton,"bottom",0,0,
		"|TInterface\\ICONS\\INV_Gizmo_RocketBoot_Destroyed_02:35:35|t {w}"..DURABILITY,"{w}"..TRP2_LOC_DURABILITYCOFFRE_TT);
	TRP2_SetTooltipForFrame(TRP2MainFrameFicheJoueurOngletRegistreOngletConsulte,TRP2MainFrameFicheJoueurOngletRegistreOngletConsulte,"RIGHT",0,0,"{w}"..TRP2_LOC_Consulte,"{o}"..TRP2_LOC_Consulte_TT);
	TRP2_SetTooltipForFrame(TRP2MainFrameFicheJoueurMenuOngletOngletRetourListe,TRP2MainFrameFicheJoueurMenuOngletOngletRetourListe,"bottom",0,0,"{w}"..TRP2_LOC_ListeRegistre,"{o}"..TRP2_LOC_ListeRegistre_TT);
	-- Onglet principaux
	TRP2_SetTooltipForFrame(TRP2MainFrameMenuBarOngletFiche,TRP2MainFrameMenuBarOngletFiche,"TOP",0,5,TRP2_FT("{w}"..TRP2_LOC_FICHE,TRP2_Joueur));
	TRP2_SetTooltipForFrame(TRP2MainFrameMenuBarOngletRegistre,TRP2MainFrameMenuBarOngletRegistre,"TOP",0,5,"{w}"..TRP2_LOC_REGISTRE);
	TRP2_SetTooltipForFrame(TRP2MainFrameMenuBarOngletCreation,TRP2MainFrameMenuBarOngletCreation,"TOP",0,5,"{w}"..TRP2_LOC_CREATION);
	TRP2_SetTooltipForFrame(TRP2MainFrameMenuBarOngletOptions,TRP2MainFrameMenuBarOngletOptions,"TOP",0,5,"{w}"..TRP2_LOC_PARAMS);
	TRP2_SetTooltipForFrame(TRP2MainFrameMenuBarOngletLangage,TRP2MainFrameMenuBarOngletLangage,"TOP",0,5,"{w}"..TRP2_LOC_DIALECTES);
	TRP2_SetTooltipForFrame(TRP2MainFrameMenuBarOngletQuest,TRP2MainFrameMenuBarOngletQuest,"TOP",0,5,"{w}"..QUESTS_LABEL);
	TRP2_SetTooltipForFrame(TRP2_ListeSoundFavButtonAdd,TRP2_ListeSoundFavButtonAdd,"TOP",0,5,"{w}"..TRP2_LOC_SoundURLExtern);
	
	
	--Editeur parole
	TRP2_SetTooltipForFrame(TRP2_NPCAnimFrameOngletEmote,TRP2_NPCAnimFrameOngletEmote,"BOTTOM",0,0,"{w}"..CHAT_MSG_EMOTE);
	TRP2_SetTooltipForFrame(TRP2_NPCAnimFrameOngletTexte,TRP2_NPCAnimFrameOngletTexte,"BOTTOM",0,0,"{w}"..TRP2_LOC_TEXTE);
	TRP2_SetTooltipForFrame(TRP2_NPCAnimFrameOngletParole,TRP2_NPCAnimFrameOngletParole,"BOTTOM",0,0,"{w}"..CHAT_MSG_SAY);
	TRP2_SetTooltipForFrame(TRP2_NPCAnimFrameOngletCrier,TRP2_NPCAnimFrameOngletCrier,"BOTTOM",0,0,"{w}"..CHAT_MSG_YELL);
	TRP2_SetTooltipForFrame(TRP2_NPCAnimFrameOngletChuchotter,TRP2_NPCAnimFrameOngletChuchotter,"BOTTOM",0,0,"{w}"..CHAT_MSG_WHISPER_INFORM);
	-- Liste sons
	TRP2_SetTooltipForFrame(TRP2_ListeSoundFavButtonAfficheList,TRP2_ListeSoundFavButtonAfficheList,"TOPLEFT",0,0,"{w}"..TRP2_LOC_ShowHideList);
	TRP2_SetTooltipForFrame(TRP2_ListeSoundFavButtonMenu,TRP2_ListeSoundFavButtonMenu,"TOPLEFT",0,0,"{w}"..TRP2_LOC_Sound_PlayChange);

	--Config
	TRP2_SetTooltipForFrame(TRP2ConfigUseBroadcast,TRP2MainFrame,"RIGHT",-10,-415,TRP2_LOC_PAR_UseBroadcast,TRP2_LOC_PAR_UseBroadcast_TT);
	TRP2_SetTooltipForFrame(TRP2ConfigEditBoxMiniMapToUse,TRP2MainFrame,"RIGHT",-10,-415,TRP2_LOC_PAR_MMtoUse,TRP2_LOC_PAR_MMtoUseTT,68,TRP2_LOC_PAR_MMtoUseMM);
	TRP2_SetTooltipForFrame(TRP2ConfigSliderMiniMapIconDegree,TRP2MainFrame,"RIGHT",-10,-415,TRP2_LOC_PAR_MMRotation,TRP2_LOC_PAR_MMRotationTT);
	TRP2_SetTooltipForFrame(TRP2ConfigSliderMiniMapIconPosition,TRP2MainFrame,"RIGHT",-10,-415,TRP2_LOC_PAR_MMPosition,TRP2_LOC_PAR_MMPositionTT);
	TRP2_SetTooltipForFrame(TRP2ConfigCheckDebug,TRP2MainFrame,"RIGHT",-10,-415,TRP2_LOC_PAR_DebugCheck,TRP2_LOC_PAR_DebugCheckTT);
	TRP2_SetTooltipForFrame(TRP2ConfigCheckTips,TRP2MainFrame,"RIGHT",-10,-415,TRP2_LOC_PAR_TipsCheck,TRP2_LOC_PAR_TipsCheck_TT);
	TRP2_SetTooltipForFrame(TRP2ConfigEditBoxDebugFrame,TRP2MainFrame,"RIGHT",-10,-415,TRP2_LOC_PAR_DebugFrame,TRP2_LOC_PAR_DebugFrameTT);
	TRP2_SetTooltipForFrame(TRP2ConfigSliderAideTaille,TRP2MainFrame,"RIGHT",-10,-415,TRP2_LOC_PAR_AideTaille,TRP2_LOC_PAR_AideTailleTT);
	TRP2_SetTooltipForFrame(TRP2ConfigCheckSoundlog,TRP2MainFrame,"RIGHT",-10,-415,TRP2_LOC_PAR_SoundLog,TRP2_LOC_PAR_SoundLogTT);
	-- Registre
	TRP2_SetTooltipForFrame(TRP2MainFrameFicheJoueurMenuOngletOngletRegistre,TRP2MainFrameFicheJoueurMenuOngletOngletRegistre,"BOTTOM",0,0,TRP2_LOC_FICHEPERSO);
	TRP2_SetTooltipForFrame(TRP2MainFrameFicheJoueurMenuOngletOngletPetsList,TRP2MainFrameFicheJoueurMenuOngletOngletPetsList,"BOTTOM",0,0,TRP2_LOC_PETSPERSO);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurPrenomSaisie,TRP2MainFrame,"RIGHT",-10,-415,TRP2_LOC_PRENOM,TRP2_LOC_PRENOM_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurNomSaisie,TRP2MainFrame,"RIGHT",-10,-415,TRP2_LOC_NOM,TRP2_LOC_NOM_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurTitreSaisie,TRP2MainFrame,"RIGHT",-10,-415,TRP2_LOC_TITRE,TRP2_LOC_TITRE_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurTitreCompletSaisie,TRP2MainFrame,"RIGHT",-10,-415,TRP2_LOC_SOUSTITRE,TRP2_LOC_SOUSTITRE_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurAgeSaisie,TRP2MainFrame,"RIGHT",-10,-415,TRP2_LOC_AGE,TRP2_LOC_AGE_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurOrigineSaisie,TRP2MainFrame,"RIGHT",-10,-415,TRP2_LOC_ORIGINE,TRP2_LOC_ORIGINE_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurHabitationSaisie,TRP2MainFrame,"RIGHT",-10,-415,TRP2_LOC_HABITAT,TRP2_LOC_HABITAT_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurRaceSaisie,TRP2MainFrame,"RIGHT",-10,-415,TRP2_LOC_RACE,TRP2_LOC_RACE_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurClassSaisie,TRP2MainFrame,"RIGHT",-10,-415,CLASS,TRP2_LOC_CLASS_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurTraitSaisie,TRP2MainFrame,"RIGHT",-10,-415,TRP2_LOC_VISAGETRAIT,TRP2_LOC_VISAGETRAIT_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurYeuxSaisie,TRP2MainFrame,"RIGHT",-10,-415,TRP2_LOC_VISAGEYEUX,TRP2_LOC_VISAGEYEUX_TT);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurPiercingSaisie,TRP2MainFrame,"RIGHT",-10,-415,TRP2_LOC_VISAGEPIERCING,TRP2_LOC_VISAGEPIERCING_TT);
	
	TRP2_SetTooltipForFrame(TRP2_DocumentFrameBoutonSuiv,TRP2_DocumentFrameBoutonSuiv,"TOP",0,0,TRP2_LOC_PAGESUIV);
	TRP2_SetTooltipForFrame(TRP2_DocumentFrameBoutonPrec,TRP2_DocumentFrameBoutonPrec,"TOP",0,0,TRP2_LOC_PAGEPREC);
	TRP2_SetTooltipForFrame(TRP2_RegistreListeConnectedCheck,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_ConnectNow,TRP2_LOC_ConnectOnly);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurActuPlayerIcon,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_PlayerIcon,"{j}"..TRP2_LOC_CLIC.." {w}: "..TRP2_LOC_ICON_CHOIX.."\n{j}"..TRP2_LOC_CLICDROIT.." {w}: "..TRP2_LOC_ICON_REINIT);
	TRP2_SetTooltipForFrame(TRP2_NPCAnimFrameTarget,TRP2_NPCAnimFrameTarget,"TOP",0,0,TRP2_LOC_COPYNAME);
	TRP2_SetTooltipForFrame(TRP2_ExchangeFrameHelp,TRP2_ExchangeFrameHelp,"TOP",0,0,CALENDAR_STATUS_STANDBY,TRP2_LOC_WAITINGEXCHANGE);
	TRP2_SetTooltipForFrame(TRP2_PetsListAllCheck,TRP2MainFrame,"RIGHT",-10,-415,TRP2_LOC_AFFICHERTOUT,TRP2_LOC_AFFICHERTOUTTT);

	TRP2_SetTooltipForFrame(TRP2_CreationPanneauFramePublic,TRP2_CreationPanneauFramePublic,"RIGHT",-50,0,"{w}"..TRP2_LOC_PANNEAUPUBLIC,TRP2_LOC_PANNEAUPUBLIC_TT);
	TRP2_SetTooltipForFrame(TRP2_CreationPlanqueFramePublic,TRP2_CreationPlanqueFramePublic,"RIGHT",-50,0,"{w}"..TRP2_LOC_PLANQUEPUBLIC,TRP2_LOC_PLANQUEPUBLICTT);
	--TRP2_SetTooltipForFrame(TRP2_CreationPlanqueFrameReadOnly,TRP2_CreationPlanqueFrameReadOnly,"RIGHT",-50,0,"{w}"..TRP2_LOC_PLANQUEREADONLY,TRP2_LOC_PLANQUEREADONLYTT);
	--TRP2_CreationPlanqueFrameReadOnlyText:SetText(TRP2_CTS("{w}"..TRP2_LOC_PLANQUEREADONLY));
	TRP2InventaireFramePanneauHeaderText:SetText(TRP2_CTS("{w}"..TRP2_LOC_PANNEAUTWO));
	TRP2_CreationPanneauFramePublicText:SetText(TRP2_CTS("{w}"..TRP2_LOC_PANNEAUPUBLIC));
	TRP2_CreationPlanqueFramePublicText:SetText(TRP2_CTS("{w}"..TRP2_LOC_PLANQUEPUBLIC));
	TRP2_MagasinFrameReputation:SetText(TRP2_CTS("{w}"..REPUTATION));
	TRP2_MagasinFrameEtat:SetText(TRP2_CTS("{w}"..TRP2_LOC_ETATSMAG));
	TRP2_GuideFrameTitre:SetText(TRP2_CTS("{w}"..TRP2_LOC_TITREGUIDE));
	TRP2_EffetLangFrameLangTitre:SetText(TRP2_CTS("{o}"..TRP2_LOC_DIALCHOOSE));
	TRP2_EffetLangFrameSaisieEtape.texte = TRP2_CTS("{o}"..TRP2_LOC_MAITRISE);
	TRP2_EffetLangFrameModeLabel:SetText(TRP2_CTS("{o}"..TRP2_LOC_ADDMETHODE));
	TRP2_EffetLangFrameTitle:SetText(TRP2_CTS("{w}"..TRP2_LISTE_EFFETS["lang"]["Titre"]));
	TRP2_EffetDocumentFrameDocumentTitre:SetText(TRP2_CTS("{o}"..TRP2_LOC_DocuCHOOSE));
	TRP2_EffetObjetFrameObjetTitre:SetText(TRP2_CTS("{o}"..TRP2_LOC_OBJCHOOSE));
	TRP2_EffetCoolFrameObjetTitre:SetText(TRP2_CTS("{o}"..TRP2_LOC_OBJCHOOSE));
	TRP2_EffetQuestFrameQuestTitre:SetText(TRP2_CTS("{o}"..TRP2_LOC_QUESTCHOOSE));
	TRP2_DialQuestFramePlayButton:SetText(TRP2_LOC_PLAY);
	TRP2MainFrameQuestsLogAffichageLabel:SetText(TRP2_CTS("{o}"..DISPLAY));
	TRP2_ColisFrameMessage.texte = TRP2_CTS("{o}"..TRP2_LOC_Message);
	TRP2_ColisFrameNom.texte = TRP2_CTS("{o}"..TRP2_LOC_Destinataire);
	TRP2_ColisFrameTitle:SetText(TRP2_CTS("{w}"..TRP2_LOC_CREACOLIS));
	TRP2_CreationFrameOthersCheckText:SetText(TRP2_CTS("{o}"..TRP2_LOC_OTHERCREA));
	TRP2_NPCAnimSelectFrameTitre:SetText(TRP2_CTS("{w}"..TRP2_LOC_ANIMSELECT));
	TRP2_EffetMascotteFrameNom.texte = TRP2_CTS("{o}"..TRP2_LOC_NOM);
	TRP2_PlanqueListeTitle:SetText(TRP2_CTS("{w}"..TRP2_LOC_ListeVosPlanque));
	TRP2_SearchPlanqueListeTitle:SetText(TRP2_CTS("{w}"..TRP2_LOC_ListeLeurPlanque));
	TRP2PlanqueFrameEdit:SetText(TRP2_LOC_Edition);
	TRP2_CreationPlanqueFrameNom.texte = TRP2_CTS("{o}"..TRP2_LOC_NOM);
	TRP2_CreationPlanqueFrameAccessNomsTexte:SetText(TRP2_CTS("{o}"..TRP2_LOC_PersonnagePerm));
	TRP2_CreationPlanqueFrameAccessLevelLabel:SetText(TRP2_CTS("{o}"..TRP2_LOC_AccessLevel));
	TRP2_CreationPlanqueFrameIconeTexte:SetText(TRP2_CTS("{o}"..TRP2_LOC_ICONEOBJ));
	
	TRP2_CreationPanneauFrameNom.texte = TRP2_CTS("{o}"..TRP2_LOC_NOM);
	TRP2_CreationPanneauFrameAccessNomsTexte:SetText(TRP2_CTS("{o}"..TRP2_LOC_PersonnagePerm));
	TRP2_CreationPanneauFrameAccessLevelLabel:SetText(TRP2_CTS("{o}"..TRP2_LOC_AccessLevel));
	TRP2_CreationPanneauFrameIconeTexte:SetText(TRP2_CTS("{o}"..TRP2_LOC_DocuCHOOSE));
	
	TRP2_ExchangeFrameSynchro:SetText(TRP2_CTS("{icone:Spell_Nature_Sleep:16} {r}"..CALENDAR_STATUS_STANDBY.."..."));
	TRP2_AuraTargetFrameEmpty:SetText(TRP2_CTS("{o}"..TRP2_LOC_NO_AURAS));
	TRP2_AuraTargetFrameTitre:SetText(TRP2_CTS("{o}"..TRP2_LOC_Auras));
	TRP2_CaractJaugeFatigue.texte = BREATH_LABEL;
	TRP2_CaractJaugeInGameFatigue.texte = BREATH_LABEL;
	TRP2_DialQuestFrameAnimCheckText:SetText(TRP2_CTS("{o}"..TRP2_LOC_Animate));
	TRP2_PetsListAllCheckText:SetText(TRP2_CTS("{o}"..TRP2_LOC_AFFICHERTOUT));
	TRP2_ListeSmallURLBox.texte = TRP2_CTS("{o}"..COPY_NAME);
	TRP2_CarnetNotesTexte:SetText(TRP2_CTS("{w}"..TRP2_LOC_CarnetNotes));
	TRP2_EffetDocumentFrameTitle:SetText(TRP2_CTS("{w}"..TRP2_LISTE_EFFETS["docu"]["Titre"]));
	TRP2_EffetQuestFrameTitle:SetText(TRP2_CTS("{w}"..TRP2_LISTE_EFFETS["quest"]["Titre"]));
	TRP2_EffetMascotteFrameTitle:SetText(TRP2_CTS("{w}"..TRP2_LISTE_EFFETS["mascotte"]["Titre"]));
	TRP2_EffetQuestFrameSaisieEtape.texte = TRP2_CTS("{o}"..TRP2_LOC_ETAPESID);
	TRP2_EffetQuestFrameModeLabel:SetText(TRP2_CTS("{o}"..MODE));
	TRP2_EffetLifetimeFrameTitle:SetText(TRP2_CTS("{w}"..TRP2_LISTE_EFFETS["lifetime"]["Titre"]));
	TRP2_EffetLifetimeFrameSaisieTime.texte = TRP2_CTS("{o}"..TRP2_LOC_DUREE);
	TRP2_EffetCoolFrameTitle:SetText(TRP2_CTS("{w}"..TRP2_LISTE_EFFETS["cool"]["Titre"]));
	TRP2_EffetCoolFrameSaisieTime.texte = TRP2_CTS("{o}"..TRP2_LOC_DUREE);
	TRP2_EffetObjetFrameTitle:SetText(TRP2_CTS("{w}"..TRP2_LISTE_EFFETS["objet"]["Titre"]));
	TRP2_EffetObjetFrameSaisieQte.texte = TRP2_CTS("{o}"..TRP2_LOC_QUANTITE);
	TRP2_EffetObjetFrameModeLabel:SetText(TRP2_CTS("{o}"..MODE));
	TRP2_EffetSonFrameTitle:SetText(TRP2_CTS("{w}"..TRP2_LISTE_EFFETS["son"]["Titre"]));
	TRP2_EffetSonFrameSaisieSonTexte:SetText(TRP2_CTS("{o}"..TRP2_LOC_URLSON));
	TRP2_EffetSonFrameSaisiePorte.texte = TRP2_CTS("{o}"..TRP2_LOC_PORTESON);
	TRP2_EffetSonFrameModeLabel:SetText(TRP2_CTS("{o}"..MODE));
	TRP2_EffetDialogFrameTexteTexte:SetText(TRP2_CTS("{w}"..TRP2_LOC_AFFICHTEXTEB));
	TRP2_EffetDialogFrameTitle:SetText(TRP2_CTS("{w}"..TRP2_LISTE_EFFETS["parole"]["Titre"]));
	TRP2_EffetDialogFrameSave:SetText(TRP2_CTS("{w}"..SAVE));
	TRP2_EffetAuraFrameTitle:SetText(TRP2_CTS("{w}"..TRP2_LISTE_EFFETS["aura"]["Titre"]));
	TRP2_EffetAuraFrameSaisieTime.texte = TRP2_CTS("{o}"..TRP2_LOC_DUREE);
	TRP2_EffetAuraFrameCibleLabel:SetText(TRP2_CTS("{o}"..TARGET));
	TRP2_EffetAuraFrameModeLabel:SetText(TRP2_CTS("{o}"..MODE));
	TRP2_EffetOrFrameModeLabel:SetText(TRP2_CTS("{o}"..MODE));
	TRP2_EffetOrFrameTitle:SetText(TRP2_CTS("{w}"..TRP2_LISTE_EFFETS["or"]["Titre"]));
	TRP2_EffetOrFrameSaisieQte.texte = TRP2_CTS("{o}"..TRP2_LOC_MONTANT);
	TRP2_PetAurasPanelEmpty:SetText(TRP2_CTS("{w}"..TRP2_LOC_NO_AURAS));
	TRP2_PetAurasPanelTitle:SetText(TRP2_CTS("{w}"..TRP2_PET_AURAS));
	TRP2_EffetDialogFrameChannelDropDownLabel:SetText(TRP2_CTS("{o}"..CHANNEL));
	TRP2_EffetTexteFrameTypeDropDownLabel:SetText(TRP2_CTS("{o}"..DISPLAY));
	TRP2_EffetTexteFrameTexteTexte:SetText(TRP2_CTS("{w}"..TRP2_LOC_AFFICHTEXTEB));
	TRP2_EffetTexteFrameTitle:SetText(TRP2_CTS("{w}"..TRP2_LISTE_EFFETS["texte"]["Titre"]));
	TRP2_EffetTexteFrameSave:SetText(TRP2_CTS("{w}"..SAVE));
	TRP2_CondiConstructorFrameSave:SetText(TRP2_CTS("{w}"..SAVE));
	TRP2_CondiConstructorFrameTitle:SetText(TRP2_CTS("{w}"..TRP2_LOC_CONDICONSTRUCTOR));
	TRP2_TriggerEditFrameSave:SetText(TRP2_CTS("{w}"..SAVE));
	TRP2_TriggerEditFrameConditionTitle:SetText(TRP2_CTS("{w}"..TRP2_LOC_CONDITIONS));
	TRP2_TriggerEditFrameEffetTitle:SetText(TRP2_CTS("{w}"..TRP2_LOC_EFFETS));
	TRP2_EffetDurabiliteFrameModeLabel:SetText(TRP2_CTS("{o}"..MODE));
	TRP2_EffetDurabiliteFrameTypeLabel:SetText(TRP2_CTS("{o}"..BAGSLOTTEXT));
	TRP2_EffetDurabiliteFrameTitle:SetText(TRP2_CTS("{w}"..TRP2_LISTE_EFFETS["durabilite"]["Titre"]));
	TRP2_EffetDurabiliteFrameSaisieQte.texte = TRP2_CTS("{o}"..TRP2_LOC_MONTANT);
	
	TRP2_SetTooltipForFrame(TRP2_ComposantBouton1Qte,TRP2_ComposantBouton1Qte,"BOTTOM",0,-5,TRP2_LOC_QUANTITE);
	TRP2_SetTooltipForFrame(TRP2_ComposantBouton2Qte,TRP2_ComposantBouton2Qte,"BOTTOM",0,-5,TRP2_LOC_QUANTITE);
	TRP2_SetTooltipForFrame(TRP2_ComposantBouton3Qte,TRP2_ComposantBouton3Qte,"BOTTOM",0,-5,TRP2_LOC_QUANTITE);
	TRP2_SetTooltipForFrame(TRP2_ComposantBouton4Qte,TRP2_ComposantBouton4Qte,"BOTTOM",0,-5,TRP2_LOC_QUANTITE);
	TRP2_SetTooltipForFrame(TRP2_ComposantBouton5Qte,TRP2_ComposantBouton5Qte,"BOTTOM",0,-5,TRP2_LOC_QUANTITE);
	TRP2_SetTooltipForFrame(TRP2_ComposantBouton6Qte,TRP2_ComposantBouton6Qte,"BOTTOM",0,-5,TRP2_LOC_QUANTITE);
	TRP2_SetTooltipForFrame(TRP2_ComposantBouton7Qte,TRP2_ComposantBouton7Qte,"BOTTOM",0,-5,TRP2_LOC_QUANTITE);
	TRP2_SetTooltipForFrame(TRP2_ComposantBouton8Qte,TRP2_ComposantBouton8Qte,"BOTTOM",0,-5,TRP2_LOC_QUANTITE);
	TRP2_SetTooltipForFrame(TRP2_ComposantBouton9Qte,TRP2_ComposantBouton9Qte,"BOTTOM",0,-5,TRP2_LOC_QUANTITE);
	TRP2_SetTooltipForFrame(TRP2_ComposantBouton10Qte,TRP2_ComposantBouton10Qte,"BOTTOM",0,-5,TRP2_LOC_QUANTITE);
	
	TRP2_SetTooltipForFrame(TRP2_OutilBouton1Qte,TRP2_OutilBouton1Qte,"BOTTOM",0,-5,TRP2_LOC_QUANTITE);
	TRP2_SetTooltipForFrame(TRP2_OutilBouton2Qte,TRP2_OutilBouton2Qte,"BOTTOM",0,-5,TRP2_LOC_QUANTITE);
	TRP2_SetTooltipForFrame(TRP2_OutilBouton3Qte,TRP2_OutilBouton3Qte,"BOTTOM",0,-5,TRP2_LOC_QUANTITE);
	TRP2_SetTooltipForFrame(TRP2_OutilBouton4Qte,TRP2_OutilBouton4Qte,"BOTTOM",0,-5,TRP2_LOC_QUANTITE);
	TRP2_SetTooltipForFrame(TRP2_OutilBouton5Qte,TRP2_OutilBouton5Qte,"BOTTOM",0,-5,TRP2_LOC_QUANTITE);
	
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameMenuSave,TRP2_CreationFrameDocumentFrameMenuSave,"TOP",0,10,SAVE,TRP2_LOC_SAVEAURA);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameMenuAnnuler,TRP2_CreationFrameDocumentFrameMenuAnnuler,"TOP",0,10,CLOSE,TRP2_LOC_CLOSECREA);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameMenuSaveSous,TRP2_CreationFrameDocumentFrameMenuSaveSous,"TOP",0,10,TRP2_LOC_SAVEAS,TRP2_LOC_SAVEASAURA);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameInfoIDHelp,TRP2_CreationFrameDocumentFrameInfoIDHelp,"BOTTOM",0,-5,TRP2_LOC_CREAIDHELP,TRP2_LOC_CREAIDHELPTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameInfoDateHelp,TRP2_CreationFrameDocumentFrameInfoDateHelp,"BOTTOM",0,-5,TRP2_LOC_CREADATEHELP,TRP2_LOC_CREADATEHELPTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameInfoVernumHelp,TRP2_CreationFrameDocumentFrameInfoVernumHelp,"BOTTOM",0,-5,TRP2_LOC_CREAVERNHELP,TRP2_LOC_CREAVERNHELPTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameInfoAuteurHelp,TRP2_CreationFrameDocumentFrameInfoAuteurHelp,"BOTTOM",0,-5,TRP2_LOC_CREAAuteurHELP,TRP2_LOC_CREAAuteurHELPTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameMenuWriteLock,TRP2_CreationFrameDocumentFrameMenuWriteLock,"TOP",0,10,TRP2_LOC_WRITELOCK,TRP2_LOC_WRITELOCKTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameMenuTitre,TRP2_CreationFrameDocumentFrameMenuTitre,"TOP",0,10,TRP2_LOC_TITRE,TRP2_LOC_TITREDOCTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameMenuIcone,TRP2_CreationFrameDocumentFrameMenuIcone,"TOP",0,10,TRP2_LOC_ICONEOBJ,TRP2_LOC_ICODOCU);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameMenuApercu,TRP2_CreationFrameDocumentFrameMenuApercu,"TOP",0,10,TRP2_LOC_APERCU,TRP2_LOC_DOCUAPER);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameListePageAjout,TRP2_CreationFrameDocumentFrameListePageAjout,"TOP",0,10,TRP2_LOC_AJOUTPAGE,TRP2_LOC_AJOUTPAGETT.."\n\n"..TRP2_LOC_DOWUWARNPAGE);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFramePageMainSave,TRP2_CreationFrameDocumentFramePageMainSave,"TOP",0,10,SAVE,TRP2_LOC_SAVEPAGETT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFramePageMainCancel,TRP2_CreationFrameDocumentFramePageMainCancel,"TOP",0,10,CLOSE,TRP2_LOC_CANCELPAGETT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFramePageMainTexteScroll,TRP2_CreationFrameDocumentFramePageMainTexteScroll,"TOP",0,10,TRP2_LOC_MAINTEXT,TRP2_LOC_TEXTEPAGETT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFramePageMainTexteScrollEditBox,TRP2_CreationFrameDocumentFramePageMainTexteScroll,"TOP",0,10,TRP2_LOC_MAINTEXT,TRP2_LOC_TEXTEPAGETT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFramePageMainListeElemAjout,TRP2_CreationFrameDocumentFramePageMainListeElemAjout,"TOP",0,10,TRP2_LOC_AJOUTELEM,TRP2_LOC_AJOUTELEMTT.."\n\n"..TRP2_LOC_DOWUWARNELEM);
	
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameImageLevel,TRP2_CreationFrameDocumentFrameImageLevel,"TOP",0,10,LEVEL,TRP2_LOC_LEVELTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameStringLevel,TRP2_CreationFrameDocumentFrameStringLevel,"TOP",0,10,LEVEL,TRP2_LOC_LEVELTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameImageUrl,TRP2_CreationFrameDocumentFrameImageUrl,"TOP",0,10,TRP2_LOC_URLSON,TRP2_LOC_URLTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameImageDimX,TRP2_CreationFrameDocumentFrameImageDimX,"TOP",0,10,TRP2_LOC_Width,TRP2_LOC_WidthTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameImageDimY,TRP2_CreationFrameDocumentFrameImageDimY,"TOP",0,10,TRP2_LOC_Heigth,TRP2_LOC_HeigthTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameImagePosX,TRP2_CreationFrameDocumentFrameImagePosX,"TOP",0,10,TRP2_LOC_PAR_ICOTARPOSX,TRP2_LOC_PAR_ICOTARPOSXTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameImagePosY,TRP2_CreationFrameDocumentFrameImagePosY,"TOP",0,10,TRP2_LOC_PAR_ICOTARPOSY,TRP2_LOC_PAR_ICOTARPOSYTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameStringPosX,TRP2_CreationFrameDocumentFrameStringPosX,"TOP",0,10,TRP2_LOC_PAR_ICOTARPOSX,TRP2_LOC_PAR_ICOTARPOSXTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameStringPosY,TRP2_CreationFrameDocumentFrameStringPosY,"TOP",0,10,TRP2_LOC_PAR_ICOTARPOSY,TRP2_LOC_PAR_ICOTARPOSYTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameImageRognerLeft,TRP2_CreationFrameDocumentFrameImageRognerLeft,"TOP",0,10,TRP2_LOC_Rogner,TRP2_LOC_PAR_ROGNERTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameImageRognerRight,TRP2_CreationFrameDocumentFrameImageRognerRight,"TOP",0,10,TRP2_LOC_Rogner,TRP2_LOC_PAR_ROGNERTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameImageRognerUp,TRP2_CreationFrameDocumentFrameImageRognerUp,"TOP",0,10,TRP2_LOC_Rogner,TRP2_LOC_PAR_ROGNERTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameImageRognerDown,TRP2_CreationFrameDocumentFrameImageRognerDown,"TOP",0,10,TRP2_LOC_Rogner,TRP2_LOC_PAR_ROGNERTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameImageRounded,TRP2_CreationFrameDocumentFrameImageRounded,"TOP",0,10,TRP2_LOC_Arrondir,TRP2_LOC_PAR_ROUNDEDTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameImageDesaturated,TRP2_CreationFrameDocumentFrameImageDesaturated,"TOP",0,10,TRP2_LOC_Desaturer,TRP2_LOC_DesaturerTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameImageAlignementHelp,TRP2_CreationFrameDocumentFrameImageAlignementHelp,"TOP",0,10,TRP2_LOC_ALIGNEMENT,TRP2_LOC_ALIGNEMENTTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameImageColorStart,TRP2_CreationFrameDocumentFrameImageColorStart,"TOP",0,10,TRP2_LOC_Couleur.." 1",TRP2_LOC_Couleur1TT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameImageColorEnd,TRP2_CreationFrameDocumentFrameImageColorEnd,"TOP",0,10,TRP2_LOC_Couleur.." 2",TRP2_LOC_Couleur2TT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameImageSave,TRP2_CreationFrameDocumentFrameImageSave,"TOP",0,10,SAVE);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameStringSave,TRP2_CreationFrameDocumentFrameImageSave,"TOP",0,10,SAVE);
	
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameStringTaille,TRP2_CreationFrameDocumentFrameStringTaille,"TOP",0,10,FONT_SIZE,TRP2_LOC_FONT_SIZE);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameStringDimX,TRP2_CreationFrameDocumentFrameStringDimX,"TOP",0,10,TRP2_LOC_CADRELARG,TRP2_LOC_CADRELARGTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameStringDimY,TRP2_CreationFrameDocumentFrameStringDimY,"TOP",0,10,TRP2_LOC_CADREHAUT,TRP2_LOC_CADREHAUTTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameStringSpacing,TRP2_CreationFrameDocumentFrameStringSpacing,"TOP",0,10,TRP2_LOC_SPACINg,TRP2_LOC_ESPACETT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameStringFontHelp,TRP2_CreationFrameDocumentFrameStringFontHelp,"TOP",0,10,TRP2_LOC_FONT,TRP2_LOC_FONTTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameStringAlignVHelp,TRP2_CreationFrameDocumentFrameStringAlignVHelp,"TOP",0,10,TRP2_LOC_ALIGNEMENTV,TRP2_LOC_ALIGNEMENTVTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameStringAlignHHelp,TRP2_CreationFrameDocumentFrameStringAlignHHelp,"TOP",0,10,TRP2_LOC_ALIGNEMENTH,TRP2_LOC_ALIGNEMENTHTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameStringTexteScrollEditBox,TRP2_CreationFrameDocumentFrameStringTexteScroll,"TOP",0,10,TRP2_LOC_AFFICHTEXTEB);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameStringShadowX,TRP2_CreationFrameDocumentFrameStringShadowX,"TOP",0,10,TRP2_LOC_PAR_ICOTARPOSX,TRP2_LOC_PAR_ICOTARPOSShadX);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameStringShadowY,TRP2_CreationFrameDocumentFrameStringShadowY,"TOP",0,10,TRP2_LOC_PAR_ICOTARPOSY,TRP2_LOC_PAR_ICOTARPOSShadY);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameStringColor,TRP2_CreationFrameDocumentFrameStringColor,"TOP",0,10,TRP2_LOC_Couleur,TRP2_LOC_CouleurTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameStringShadowColor,TRP2_CreationFrameDocumentFrameStringShadowColor,"TOP",0,10,TRP2_LOC_Ombre,TRP2_LOC_OmbreTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameDocumentFrameStringContours,TRP2_CreationFrameDocumentFrameStringContours,"TOP",0,10,TRP2_LOC_Contours,TRP2_LOC_ContoursTT);
	
	TRP2_SetTooltipForFrame(TRP2_CreationFrameObjetFrameMenuSave,TRP2_CreationFrameObjetFrameMenuSave,"TOP",0,10,SAVE,TRP2_LOC_SAVEAURA);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameObjetFrameMenuAnnuler,TRP2_CreationFrameObjetFrameMenuAnnuler,"TOP",0,10,CLOSE,TRP2_LOC_CLOSECREA);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameObjetFrameMenuSaveSous,TRP2_CreationFrameObjetFrameMenuSaveSous,"TOP",0,10,TRP2_LOC_SAVEAS,TRP2_LOC_SAVEASAURA);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameObjetFrameGeneralNom,TRP2_CreationFrameObjetFrameGeneralNom,"TOP",0,10,NAME,TRP2_LOC_CREAOBJETNOM);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameObjetFrameGeneralCategorie,TRP2_CreationFrameObjetFrameGeneralCategorie,"TOP",0,10,CATEGORY,TRP2_LOC_CREAOBJETCATE);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameObjetFrameGeneralUnique,TRP2_CreationFrameObjetFrameGeneralUnique,"TOP",0,10,ITEM_UNIQUE,TRP2_LOC_CREAOBJETUNIQUE);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameObjetFrameGeneralPoids,TRP2_CreationFrameObjetFrameGeneralPoids,"TOP",0,10,TRP2_LOC_Objet_POIDS,TRP2_LOC_CREAOBJETPOIDS);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameObjetFrameGeneralLifetime,TRP2_CreationFrameObjetFrameGeneralLifetime,"TOP",0,10,TRP2_LOC_Objet_LIFETIME,TRP2_LOC_CREAOBJETLIFETIME);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameObjetFrameGeneralValeur,TRP2_CreationFrameObjetFrameGeneralValeur,"TOP",0,10,TRP2_LOC_Objet_VALEUR,TRP2_LOC_CREAOBJETVALEUR);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameObjetFrameGeneralDescriptionScroll,TRP2_CreationFrameObjetFrameGeneralDescriptionScroll,"TOP",0,10,TRP2_LOC_Description,TRP2_LOC_CREAOBJETDESCR);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameObjetFrameGeneralDescriptionScrollEditBox,TRP2_CreationFrameObjetFrameGeneralDescriptionScroll,"TOP",0,10,TRP2_LOC_Description,TRP2_LOC_CREAOBJETDESCR);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameObjetFrameGeneralIcone,TRP2_CreationFrameObjetFrameGeneralIcone,"TOP",0,10,TRP2_LOC_ICONEOBJ,TRP2_LOC_CREAOBJETICONE);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameObjetFrameGeneralStack,TRP2_CreationFrameObjetFrameGeneralStack,"TOP",0,10,TRP2_LOC_PILE,TRP2_LOC_CREAOBJETSTACK);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameObjetFrameGeneralQualite,TRP2_CreationFrameObjetFrameGeneralQualite,"TOP",0,10,QUALITY,TRP2_LOC_CREAOBJETQUALITY);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameObjetFrameUtilisationCharge,TRP2_CreationFrameObjetFrameUtilisationCharge,"TOP",0,10,TRP2_LOC_CHARGES,TRP2_LOC_CREAOBJETCHARGES);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameObjetFrameUtilisationTooltip,TRP2_CreationFrameObjetFrameUtilisationTooltip,"TOP",0,10,TRP2_LOC_ACTIONNAME,TRP2_LOC_CREAOBJETACTNAME);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameObjetFrameUtilisationCooldown,TRP2_CreationFrameObjetFrameUtilisationCooldown,"TOP",0,10,TRP2_LOC_RECHARGE,TRP2_LOC_RECHARGE_TT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameObjetFrameUtilisationDuree,TRP2_CreationFrameObjetFrameUtilisationDuree,"TOP",0,10,TRP2_LOC_DUREETEXT,TRP2_LOC_DUREETEXT_TT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameObjetFrameUtilisationAnim,TRP2_CreationFrameObjetFrameUtilisationAnim,"TOP",0,10,ANIMATION,TRP2_LOC_ANIMATION_TT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameObjetFrameUtilisationAction,TRP2_CreationFrameObjetFrameUtilisationAction,"TOP",0,10,TRP2_LOC_ACTIONTEXT,TRP2_LOC_ACTIONTEXT_TT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameObjetFrameInfoIDHelp,TRP2_CreationFrameObjetFrameInfoIDHelp,"BOTTOM",0,-5,TRP2_LOC_CREAIDHELP,TRP2_LOC_CREAIDHELPTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameObjetFrameInfoDateHelp,TRP2_CreationFrameObjetFrameInfoDateHelp,"BOTTOM",0,-5,TRP2_LOC_CREADATEHELP,TRP2_LOC_CREADATEHELPTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameObjetFrameInfoVernumHelp,TRP2_CreationFrameObjetFrameInfoVernumHelp,"BOTTOM",0,-5,TRP2_LOC_CREAVERNHELP,TRP2_LOC_CREAVERNHELPTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameObjetFrameInfoAuteurHelp,TRP2_CreationFrameObjetFrameInfoAuteurHelp,"BOTTOM",0,-5,TRP2_LOC_CREAAuteurHELP,TRP2_LOC_CREAAuteurHELPTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameObjetFrameFlagsWriteLock,TRP2_CreationFrameObjetFrameFlagsWriteLock,"TOP",0,10,TRP2_LOC_WRITELOCK,TRP2_LOC_WRITELOCKTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameObjetFrameFlagsStealable,TRP2_CreationFrameObjetFrameFlagsStealable,"TOP",0,10,TRP2_LOC_STOLABLE,TRP2_LOC_STOLABLETT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameObjetFrameFlagsUsable,TRP2_CreationFrameObjetFrameFlagsUsable,"TOP",0,10,TRP2_LOC_USABLE,TRP2_LOC_USABLETT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameObjetFrameFlagsGivable,TRP2_CreationFrameObjetFrameFlagsGivable,"TOP",0,10,TRP2_LOC_GIVABLE,TRP2_LOC_GIVABLETT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameObjetFrameFlagsDestroyable,TRP2_CreationFrameObjetFrameFlagsDestroyable,"TOP",0,10,TRP2_LOC_DESTROYABLE,TRP2_LOC_DESTROYABLETT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameObjetFrameFlagsManual,TRP2_CreationFrameObjetFrameFlagsManual,"TOP",0,10,TRP2_LOC_MANUAL,TRP2_LOC_MANUALTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameObjetFrameFlagsQuest,TRP2_CreationFrameObjetFrameFlagsQuest,"TOP",0,10,ITEM_BIND_QUEST,TRP2_LOC_QUESTOBJETTT);
	
	TRP2_PackageDownloaderHeaderText:SetText(TRP2_CTS("{w}"..TRP2_LOC_PACKDOWNLOAD));
	TRP2_CreationFrameObjetFrameOutilsTitle:SetText(TRP2_CTS("{w}"..TRP2_LOC_OUTILS));
	TRP2_CreationFrameObjetFrameCompoTitle:SetText(TRP2_CTS("{w}"..MINIMAP_TRACKING_VENDOR_REAGENT));
	TRP2_CreationFrameObjetFrameUtilisationTitle:SetText(TRP2_CTS("{w}"..TRP2_LOC_UTILISATION));
	TRP2_CreationFrameObjetFrameUtilisationCharge.texte = TRP2_CTS(TRP2_LOC_CHARGES);
	TRP2_CreationFrameObjetFrameUtilisationTooltip.texte = TRP2_CTS(TRP2_LOC_ACTIONNAME);
	TRP2_CreationFrameObjetFrameUtilisationCooldown.texte = TRP2_CTS(TRP2_LOC_RECHARGE);
	TRP2_CreationFrameObjetFrameUtilisationDuree.texte = TRP2_CTS(TRP2_LOC_DUREETEXT);
	TRP2_CreationFrameObjetFrameUtilisationAnim.texte = TRP2_CTS(ANIMATION);
	TRP2_CreationFrameObjetFrameUtilisationAction.texte = TRP2_CTS(TRP2_LOC_ACTIONTEXT);
	TRP2_CreationFrameObjetFrameFlagsTitle:SetText(TRP2_CTS("{w}"..TRP2_LOC_FLAGS));
	TRP2_CreationFrameObjetFrameFlagsWriteLockText:SetText(TRP2_CTS(TRP2_LOC_WRITELOCK));
	TRP2_CreationFrameObjetFrameFlagsStealableText:SetText(TRP2_CTS(TRP2_LOC_STOLABLE));
	TRP2_CreationFrameObjetFrameFlagsUsableText:SetText(TRP2_CTS(TRP2_LOC_USABLE));
	TRP2_CreationFrameObjetFrameFlagsGivableText:SetText(TRP2_CTS(TRP2_LOC_GIVABLE));
	TRP2_CreationFrameObjetFrameFlagsDestroyableText:SetText(TRP2_CTS(TRP2_LOC_DESTROYABLE));
	TRP2_CreationFrameObjetFrameFlagsQuestText:SetText(TRP2_CTS(ITEM_BIND_QUEST));
	TRP2_CreationFrameObjetFrameFlagsManualText:SetText(TRP2_CTS(TRP2_LOC_MANUAL));
	TRP2_CreationFrameObjetFrameTriggerTitle:SetText(TRP2_CTS("{w}"..TRP2_LOC_TRIGGERS));
	TRP2_CreationFrameObjetFrameInfoTitle:SetText(TRP2_CTS("{w}"..TRP2_LOC_INFOSUPP));
	TRP2_CreationFrameObjetFrameTriggerOnReceiveTexte:SetText(TRP2_CTS(TRP2_LOC_TRIGOBJ_RECEIVE));
	TRP2_CreationFrameObjetFrameTriggerOnTimeoutTexte:SetText(TRP2_CTS(TRP2_LOC_TRIGOBJ_TIMEOUT));
	TRP2_CreationFrameObjetFrameTriggerOnCooldownTexte:SetText(TRP2_CTS(TRP2_LOC_TRIGOBJ_COOLDOWN));
	TRP2_CreationFrameObjetFrameTriggerOnDestroyTexte:SetText(TRP2_CTS(TRP2_LOC_TRIGOBJ_DESTROY));
	TRP2_CreationFrameObjetFrameTriggerOnUseStartTexte:SetText(TRP2_CTS(TRP2_LOC_TRIGOBJ_USESTART));
	TRP2_CreationFrameObjetFrameTriggerOnUseStartFailTexte:SetText(TRP2_CTS(TRP2_LOC_TRIGOBJ_USESTARTF));
	TRP2_CreationFrameObjetFrameTriggerOnUseEndTexte:SetText(TRP2_CTS(TRP2_LOC_TRIGOBJ_USEEND));
	TRP2_CreationFrameObjetFrameTriggerOnUseEndFailTexte:SetText(TRP2_CTS(TRP2_LOC_TRIGOBJ_USEENDF));
	TRP2_CreationFrameObjetFrameTriggerOnUsedTexte:SetText(TRP2_CTS(TRP2_LOC_TRIGOBJ_USED));
	TRP2_CreationFrameObjetFrameGeneralTitle:SetText(TRP2_CTS("{w}"..TRP2_LOC_INFOGENERAL));
	TRP2_CreationFrameObjetFrameGeneralNom.texte = TRP2_CTS(NAME);
	TRP2_CreationFrameObjetFrameGeneralCategorie.texte = TRP2_CTS(CATEGORY);
	TRP2_CreationFrameObjetFrameGeneralUnique.texte = TRP2_CTS(ITEM_UNIQUE);
	TRP2_CreationFrameObjetFrameGeneralPoids.texte = TRP2_CTS(TRP2_LOC_Objet_POIDS);
	TRP2_CreationFrameObjetFrameGeneralLifetime.texte = TRP2_CTS(TRP2_LOC_Objet_LIFETIME);
	TRP2_CreationFrameObjetFrameGeneralValeur.texte = TRP2_CTS(TRP2_LOC_Objet_VALEUR);
	TRP2_CreationFrameObjetFrameGeneralDescriptionTexte:SetText(TRP2_CTS("{o}"..TRP2_LOC_Description));
	TRP2_CreationFrameObjetFrameGeneralIconeTexte:SetText(TRP2_CTS("{o}"..TRP2_LOC_ICONEOBJ));
	TRP2_CreationFrameObjetFrameGeneralStack.texte = TRP2_CTS(TRP2_LOC_PILE);
	TRP2_CreationFrameObjetFrameGeneralNom.defaut = TRP2_LOC_NEW_Objet;
	TRP2_CreationFrameObjetFrameMenuSave:SetText(TRP2_CTS("{w}"..SAVE));
	TRP2_CreationFrameObjetFrameMenuSaveSous:SetText(TRP2_CTS("{w}"..TRP2_LOC_SAVEAS));
	TRP2_CreationFrameObjetFrameMenuAnnuler:SetText(TRP2_CTS("{w}"..CLOSE));
	TRP2_CreationFrameObjetFrameMenuApercuTexte:SetText(TRP2_CTS("{w}"..TRP2_LOC_APERCU));
	TRP2_CreationFrameObjetFrameMenuTitle:SetText(TRP2_CTS("{w}"..TRP2_LOC_MENU));
	TRP2_CreationFrameDocumentFramePageMainSave:SetText(TRP2_CTS(SAVE));
	TRP2_CreationFrameDocumentFrameMenuSave:SetText(TRP2_CTS(SAVE));
	TRP2_CreationFrameDocumentFrameMenuSaveSous:SetText(TRP2_CTS(TRP2_LOC_SAVEAS));
	TRP2_CreationFrameDocumentFrameMenuApercu:SetText(TRP2_CTS(TRP2_LOC_APERCU));
	TRP2_CreationFrameDocumentFrameMenuAnnuler:SetText(TRP2_CTS(CLOSE));
	TRP2_CreationFrameDocumentFramePageMainListeElemTitre:SetText(TRP2_CTS(TRP2_LOC_ELEMLIST));
	TRP2_CreationFrameDocumentFrameListePageTitre:SetText(TRP2_CTS(TRP2_LOC_PAGELIST));
	TRP2_CreationFrameDocumentFramePageMainTexteTexte:SetText(TRP2_CTS(TRP2_LOC_MAINTEXT));
	TRP2_CreationFrameDocumentFrameStringLevelTitle:SetText(TRP2_CTS(GENERAL_LABEL));
	TRP2_CreationFrameDocumentFrameStringLevel.texte = TRP2_CTS(LEVEL);
	TRP2_CreationFrameDocumentFrameStringTaille.texte = TRP2_CTS(FONT_SIZE);
	TRP2_CreationFrameDocumentFrameStringDimXTitle:SetText(TRP2_CTS(TRP2_LOC_DIMENSIONS));
	TRP2_CreationFrameDocumentFrameStringDimX.texte = TRP2_CTS(TRP2_LOC_CADRELARG);
	TRP2_CreationFrameDocumentFrameStringDimY.texte = TRP2_CTS(TRP2_LOC_CADREHAUT);
	TRP2_CreationFrameDocumentFrameStringPosXTitle:SetText(TRP2_CTS(TRP2_LOC_Position));
	TRP2_CreationFrameDocumentFrameStringPosX.texte = TRP2_CTS(TRP2_LOC_Position.." : X");
	TRP2_CreationFrameDocumentFrameStringPosY.texte = TRP2_CTS(TRP2_LOC_Position.." : Y");
	TRP2_CreationFrameDocumentFrameStringFontLabel:SetText(TRP2_CTS(TRP2_LOC_FONT));
	TRP2_CreationFrameDocumentFrameStringAlignVLabel:SetText(TRP2_CTS(TRP2_LOC_ALIGNEMENTV));
	TRP2_CreationFrameDocumentFrameStringAlignHLabel:SetText(TRP2_CTS(TRP2_LOC_ALIGNEMENTH));
	TRP2_CreationFrameDocumentFrameStringTexteTexte:SetText(TRP2_CTS(TRP2_LOC_TEXT));
	TRP2_CreationFrameDocumentFrameStringSpacing.texte = TRP2_CTS(TRP2_LOC_SPACINg);
	TRP2_CreationFrameDocumentFrameStringShadowX.texte = TRP2_CTS(TRP2_LOC_Position.." : X");
	TRP2_CreationFrameDocumentFrameStringShadowY.texte = TRP2_CTS(TRP2_LOC_Position.." : Y");
	TRP2_CreationFrameDocumentFrameStringShadowXTitle:SetText(TRP2_CTS(TRP2_LOC_Ombre));
	TRP2_CreationFrameDocumentFrameStringContoursText:SetText(TRP2_CTS(TRP2_LOC_Contours));
	TRP2_CreationFrameDocumentFrameMenuIconeTexte:SetText(TRP2_CTS("{o}"..TRP2_LOC_ICONEOBJ));
	TRP2_CreationFrameDocumentFrameMenuWriteLockText:SetText(TRP2_CTS(TRP2_LOC_WRITELOCK));
	TRP2_CreationFrameDocumentFrameMenuTitre.texte = TRP2_CTS(TRP2_LOC_TITRE);
	TRP2_CreationFrameDocumentFrameInfoTitle:SetText(TRP2_CTS(TRP2_LOC_INFO));
	TRP2_CreationFrameDocumentFrameImageLevelTitle:SetText(TRP2_CTS(GENERAL_LABEL));
	TRP2_CreationFrameDocumentFrameImageLevel.texte = TRP2_CTS(LEVEL);
	TRP2_CreationFrameDocumentFrameImageUrl.texte = TRP2_CTS(TRP2_LOC_URLSON);
	TRP2_CreationFrameDocumentFrameImageDimXTitle:SetText(TRP2_CTS(TRP2_LOC_DIMENSIONS));
	TRP2_CreationFrameDocumentFrameImageDimX.texte = TRP2_CTS(TRP2_LOC_Width);
	TRP2_CreationFrameDocumentFrameImageDimY.texte = TRP2_CTS(TRP2_LOC_Heigth);
	TRP2_CreationFrameDocumentFrameImagePosXTitle:SetText(TRP2_CTS(TRP2_LOC_Position));
	TRP2_CreationFrameDocumentFrameImagePosX.texte = TRP2_CTS(TRP2_LOC_Position.." : X");
	TRP2_CreationFrameDocumentFrameImagePosY.texte = TRP2_CTS(TRP2_LOC_Position.." : Y");
	TRP2_CreationFrameDocumentFrameImageRognerLeftTitle:SetText(TRP2_CTS(TRP2_LOC_Rogner));
	TRP2_CreationFrameDocumentFrameImageRognerLeft.texte = TRP2_CTS(TRP2_LOC_ALIGNHLEFT);
	TRP2_CreationFrameDocumentFrameImageRognerRight.texte = TRP2_CTS(TRP2_LOC_ALIGNHRIGHT);
	TRP2_CreationFrameDocumentFrameImageRognerUp.texte = TRP2_CTS(TRP2_LOC_ALIGNVTOP);
	TRP2_CreationFrameDocumentFrameImageRognerDown.texte = TRP2_CTS(TRP2_LOC_ALIGNVBOTTOM);
	TRP2_CreationFrameDocumentFrameImageDesaturatedTitle:SetText(TRP2_CTS(TRP2_LOC_Couleurs));
	TRP2_CreationFrameDocumentFrameImageDesaturatedText:SetText(TRP2_CTS(TRP2_LOC_Desaturer));
	TRP2_CreationFrameDocumentFrameImageRoundedText:SetText(TRP2_CTS(TRP2_LOC_Arrondir));
	TRP2_CreationFrameDocumentFrameImageAlignementLabel:SetText(TRP2_CTS(TRP2_LOC_AlignDegrad));
	TRP2_CreationFrameQuestFrameListeEtapeTitle:SetText(TRP2_CTS(TRP2_LOC_ETAPES));
	TRP2_CreationFrameQuestFrameListeActionTitle:SetText(TRP2_CTS(TRP2_LOC_ACTIONS));
	TRP2_CreationFrameQuestFrameEtapeEtapeNum.texte = TRP2_CTS("{o}"..TRP2_LOC_ETAPESID);
	TRP2_CreationFrameQuestFrameEtapeEtatLabel:SetText(TRP2_CTS("{o}"..TRP2_LOC_FLAG));
	TRP2_CreationFrameQuestFrameActionTypeLabel:SetText(TRP2_CTS("{o}"..TRP2_LOC_ACTION));
	TRP2_CreationFrameQuestFrameInfoTitle:SetText(TRP2_CTS(TRP2_LOC_INFOSUPP));
	TRP2_CreationFrameQuestFrameFlagsTitle:SetText(TRP2_CTS(TRP2_LOC_FLAGS));
	TRP2_CreationFrameQuestFrameMenuTitle:SetText(TRP2_CTS(TRP2_LOC_MENU));
	TRP2_CreationFrameQuestFrameGeneralTitle:SetText(TRP2_CTS(TRP2_LOC_INFOGENERAL));
	TRP2_CreationFrameQuestFrameMenuSaveSous:SetText(TRP2_CTS(TRP2_LOC_SAVEAS));
	TRP2_CreationFrameQuestFrameMenuSave:SetText(TRP2_CTS(SAVE));
	TRP2_CreationFrameQuestFrameMenuAnnuler:SetText(TRP2_CTS(CLOSE));
	TRP2_CreationFrameQuestFrameActionSave:SetText(TRP2_CTS(SAVE));
	TRP2_CreationFrameQuestFrameActionCancel:SetText(TRP2_CTS(CANCEL));
	TRP2_CreationFrameQuestFrameActionOnActionTexte:SetText(TRP2_CTS(TRP2_LOC_ACTION));
	TRP2_CreationFrameQuestFrameEtapeSave:SetText(TRP2_CTS(SAVE));
	TRP2_CreationFrameQuestFrameEtapeCancel:SetText(TRP2_CTS(CANCEL));
	TRP2_CreationFrameQuestFrameEtapeOnEtapeTexte:SetText(TRP2_CTS(TRP2_LOC_ETAPE));
	TRP2_CreationFrameQuestFrameGeneralTitre.texte = TRP2_CTS("{o}"..TRP2_LOC_TITRE);
	TRP2_CreationFrameQuestFrameActionEtape.texte = TRP2_CTS("{o}"..TRP2_LOC_ETAPES);
	TRP2_CreationFrameQuestFrameEtapeDescriptionTexte:SetText(TRP2_CTS("{o}"..TRP2_LOC_Description));
	TRP2_CreationFrameQuestFrameGeneralDescriptionTexte:SetText(TRP2_CTS("{o}"..TRP2_LOC_Description));
	TRP2_CreationFrameQuestFrameGeneralIconeTexte:SetText(TRP2_CTS("{o}"..TRP2_LOC_ICONEOBJ));
	TRP2_CreationFrameQuestFrameFlagsWriteLockText:SetText(TRP2_CTS("{o}"..TRP2_LOC_WRITELOCK));
	TRP2_CreationFrameQuestFrameFlagsManualText:SetText(TRP2_CTS("{o}"..TRP2_LOC_MANUAL));
	TRP2_CreationFrameQuestFrameFlagsReinitText:SetText(TRP2_CTS("{o}"..TRP2_LOC_REINIT));
	
	TRP2_ListeSoundCategorieLabel:SetText(TRP2_CTS("{w}"..TRP2_LOC_REPERT));
	
	TRP2_CreationFrameAuraFrameTriggerOnUpdateTexte:SetText(TRP2_CTS(TRP2_LOC_SECONDS));
	TRP2_CreationFrameAuraFrameTriggerOnLifeTimeTexte:SetText(TRP2_CTS(TRP2_LOC_TRIGOBJ_TIMEOUT));
	TRP2_CreationFrameAuraFrameTriggerOnDestroyTexte:SetText(TRP2_CTS(TRP2_LOC_TRIGOBJ_DESTROY));
	TRP2_CreationFrameAuraFrameTriggerOnReceiveTexte:SetText(TRP2_CTS(TRP2_LOC_TRIGOBJ_RECEIVE));
	TRP2_CreationFrameAuraFrameTriggerTitle:SetText(TRP2_CTS("{w}"..TRP2_LOC_TRIGGERS));
	TRP2_CreationFrameAuraFrameInfoTitle:SetText(TRP2_CTS("{w}"..TRP2_LOC_INFOSUPP));
	TRP2_CreationFrameAuraFrameModifTitle:SetText(TRP2_CTS("{w}"..TRP2_LOC_MODIFICATEURS));
	TRP2_CreationFrameAuraFrameFlagsDeletableText:SetText(TRP2_CTS(TRP2_LOC_DELETABLE));
	TRP2_CreationFrameAuraFrameFlagsAjoutableText:SetText(TRP2_CTS(TRP2_LOC_MANUAL));
	TRP2_CreationFrameAuraFrameFlagsTimeSetText:SetText(TRP2_CTS(TRP2_LOC_TIMESET));
	TRP2_CreationFrameAuraFrameFlagsTitle:SetText(TRP2_CTS("{w}"..TRP2_LOC_FLAGS));
	TRP2_CreationFrameAuraFrameFlagsWriteLockText:SetText(TRP2_CTS(TRP2_LOC_WRITELOCK));
	TRP2_CreationFrameAuraFrameGeneralDureeDefaut.texte = TRP2_CTS(TRP2_LOC_DUREEDEF);
	TRP2_CreationFrameAuraFrameGeneralIconeTexte:SetText(TRP2_CTS("{o}"..TRP2_LOC_ICONEOBJ));
	TRP2_CreationFrameAuraFrameGeneralDescriptionTexte:SetText(TRP2_CTS("{o}"..TRP2_LOC_Description));
	TRP2_CreationFrameAuraFrameGeneralTitle:SetText(TRP2_CTS("{w}"..TRP2_LOC_INFOGENERAL));
	TRP2_CreationFrameAuraFrameGeneralNom.texte = TRP2_CTS(NAME);
	TRP2_CreationFrameAuraFrameMenuSave:SetText(TRP2_CTS("{w}"..SAVE));
	TRP2_CreationFrameAuraFrameMenuSaveSous:SetText(TRP2_CTS("{w}"..TRP2_LOC_SAVEAS));
	TRP2_CreationFrameAuraFrameMenuAnnuler:SetText(TRP2_CTS("{w}"..CLOSE));
	TRP2_CreationFrameAuraFrameMenuApercuTexte:SetText(TRP2_CTS("{w}"..TRP2_LOC_APERCU));
	TRP2_CreationFrameAuraFrameMenuTitle:SetText(TRP2_CTS("{w}"..TRP2_LOC_MENU));
	TRP2_ActionBarBut:SetText(TRP2_LOC_CreationTypeQuest);
	
	TRP2_SetTooltipForFrame(TRP2_CondiConstructorFrameNumeric,TRP2_CondiConstructorFrameNumeric,"TOP",0,0,TRP2_LOC_NUMERIC,TRP2_LOC_NUMERICTT);
	TRP2_SetTooltipForFrame(TRP2_CondiConstructorFrameTextuelle,TRP2_CondiConstructorFrameTextuelle,"TOP",0,0,TRP2_LOC_TEXTUELLE,TRP2_LOC_TEXTUELLETT);
	TRP2_SetTooltipForFrame(TRP2_TriggerEditFrameConditionAjoutCondition,TRP2_TriggerEditFrameConditionAjoutCondition,"TOP",0,0,TRP2_LOC_AJOUTCONDI);
	TRP2_SetTooltipForFrame(TRP2_TriggerEditFrameEffetAjoutEffet,TRP2_TriggerEditFrameEffetAjoutEffet,"TOP",0,0,TRP2_LOC_AJOUTEFFET);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameAuraFrameFlagsTimeSet,TRP2_CreationFrameAuraFrameFlagsTimeSet,"TOP",0,10,TRP2_LOC_TIMESET,TRP2_LOC_TIMESETTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameAuraFrameFlagsAjoutable,TRP2_CreationFrameAuraFrameFlagsAjoutable,"TOP",0,10,TRP2_LOC_MANUAL,TRP2_LOC_AURAAJOUTTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameAuraFrameFlagsDeletable,TRP2_CreationFrameAuraFrameFlagsDeletable,"TOP",0,10,TRP2_LOC_DELETABLE,TRP2_LOC_AURADELETETT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameAuraFrameFlagsWriteLock,TRP2_CreationFrameAuraFrameFlagsWriteLock,"TOP",0,10,TRP2_LOC_WRITELOCK,TRP2_LOC_WRITELOCKTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameAuraFrameGeneralDureeDefaut,TRP2_CreationFrameAuraFrameGeneralDureeDefaut,"TOP",0,10,TRP2_LOC_DUREEDEF,TRP2_LOC_DUREEDEFAUTTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameAuraFrameGeneralNom,TRP2_CreationFrameAuraFrameGeneralNom,"TOP",0,10,NAME,TRP2_LOC_AURANOMTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameAuraFrameGeneralDescriptionScroll,TRP2_CreationFrameAuraFrameGeneralDescriptionScroll,"TOP",0,10,TRP2_LOC_Description,TRP2_LOC_AURADESCRITT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameAuraFrameGeneralDescriptionScrollEditBox,TRP2_CreationFrameAuraFrameGeneralDescriptionScroll,"TOP",0,10,TRP2_LOC_Description,TRP2_LOC_AURADESCRITT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameAuraFrameGeneralType,TRP2_CreationFrameAuraFrameGeneralType,"TOP",0,10,TRP2_LOC_TYPE,TRP2_LOC_TYPEAURATT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameAuraFrameGeneralIcone,TRP2_CreationFrameAuraFrameGeneralIcone,"TOP",0,10,TRP2_LOC_ICONEOBJ,"{j}"..TRP2_LOC_CLIC.." : {w}"..TRP2_LOC_ICON_CHOIX);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameAuraFrameMenuSave,TRP2_CreationFrameAuraFrameMenuSave,"TOP",0,10,SAVE,TRP2_LOC_SAVEAURA);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameAuraFrameMenuAnnuler,TRP2_CreationFrameAuraFrameMenuAnnuler,"TOP",0,10,CLOSE,TRP2_LOC_CLOSECREA);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameAuraFrameMenuSaveSous,TRP2_CreationFrameAuraFrameMenuSaveSous,"TOP",0,10,TRP2_LOC_SAVEAS,TRP2_LOC_SAVEASAURA);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameAuraFrameInfoIDHelp,TRP2_CreationFrameAuraFrameInfoIDHelp,"BOTTOM",0,-5,TRP2_LOC_CREAIDHELP,TRP2_LOC_CREAIDHELPTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameAuraFrameInfoDateHelp,TRP2_CreationFrameAuraFrameInfoDateHelp,"BOTTOM",0,-5,TRP2_LOC_CREADATEHELP,TRP2_LOC_CREADATEHELPTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameAuraFrameInfoVernumHelp,TRP2_CreationFrameAuraFrameInfoVernumHelp,"BOTTOM",0,-5,TRP2_LOC_CREAVERNHELP,TRP2_LOC_CREAVERNHELPTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameAuraFrameInfoAuteurHelp,TRP2_CreationFrameAuraFrameInfoAuteurHelp,"BOTTOM",0,-5,TRP2_LOC_CREAAuteurHELP,TRP2_LOC_CREAAuteurHELPTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameBaseListeAuraAjout,TRP2_CreationFrameBaseListeAuraAjout,"TOP",0,10,TRP2_LOC_NewAura);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameBaseListeObjetAjout,TRP2_CreationFrameBaseListeObjetAjout,"TOP",0,10,TRP2_LOC_NEW_Objet);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameBaseListeDocumentAjout,TRP2_CreationFrameBaseListeDocumentAjout,"TOP",0,10,TRP2_LOC_NEWDOCU);
	TRP2_SetTooltipForFrame(TRP2_EffetDialogFrameTexteScrollEditBox,TRP2_EffetDialogFrameTexte,"TOP",0,10,TRP2_LOC_AFFICHTEXTEB,TRP2_LOC_EFFETPAROLETT);
	TRP2_SetTooltipForFrame(TRP2_EffetDialogFrameTexteScroll,TRP2_EffetDialogFrameTexte,"TOP",0,10,TRP2_LOC_AFFICHTEXTEB,TRP2_LOC_EFFETPAROLETT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameBaseListePackagesAjout,TRP2_CreationFrameBaseListePackagesAjout,"TOP",0,10,TRP2_LOC_NEWPACKAGE);
	
	TRP2_SetTooltipForFrame(TRP2_CreationFrameQuestFrameInfoIDHelp,TRP2_CreationFrameQuestFrameInfoIDHelp,"BOTTOM",0,-5,TRP2_LOC_CREAIDHELP,TRP2_LOC_CREAIDHELPTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameQuestFrameInfoDateHelp,TRP2_CreationFrameQuestFrameInfoDateHelp,"BOTTOM",0,-5,TRP2_LOC_CREADATEHELP,TRP2_LOC_CREADATEHELPTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameQuestFrameInfoVernumHelp,TRP2_CreationFrameQuestFrameInfoVernumHelp,"BOTTOM",0,-5,TRP2_LOC_CREAVERNHELP,TRP2_LOC_CREAVERNHELPTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameQuestFrameInfoAuteurHelp,TRP2_CreationFrameQuestFrameInfoAuteurHelp,"BOTTOM",0,-5,TRP2_LOC_CREAAuteurHELP,TRP2_LOC_CREAAuteurHELPTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameQuestFrameMenuSave,TRP2_CreationFrameQuestFrameMenuSave,"TOP",0,10,SAVE,TRP2_LOC_SAVEAURA);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameQuestFrameMenuAnnuler,TRP2_CreationFrameQuestFrameMenuAnnuler,"TOP",0,10,CLOSE,TRP2_LOC_CLOSECREA);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameQuestFrameMenuSaveSous,TRP2_CreationFrameQuestFrameMenuSaveSous,"TOP",0,10,TRP2_LOC_SAVEAS,TRP2_LOC_SAVEASAURA);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameQuestFrameGeneralIcone,TRP2_CreationFrameQuestFrameGeneralIcone,"TOP",0,10,TRP2_LOC_ICONEOBJ,"{j}"..TRP2_LOC_CLIC.." : {w}"..TRP2_LOC_ICON_CHOIX);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameQuestFrameFlagsWriteLock,TRP2_CreationFrameQuestFrameFlagsWriteLock,"TOP",0,10,TRP2_LOC_WRITELOCK,TRP2_LOC_WRITELOCKTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameQuestFrameFlagsManual,TRP2_CreationFrameQuestFrameFlagsManual,"TOP",0,10,TRP2_LOC_MANUAL,TRP2_LOC_MANUALQUESTTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameQuestFrameFlagsReinit,TRP2_CreationFrameQuestFrameFlagsReinit,"TOP",0,10,TRP2_LOC_REINIT,TRP2_LOC_REINITTT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameQuestFrameGeneralTitre,TRP2_CreationFrameQuestFrameGeneralTitre,"TOP",0,10,TRP2_LOC_TITRE,TRP2_LOC_QUESTTITRETT);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameQuestFrameGeneralDescriptionScrollEditBox,TRP2_CreationFrameQuestFrameGeneralDescriptionScroll,"TOP",0,10,TRP2_LOC_Description,TRP2_LOC_DescriptionQUEST);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameQuestFrameGeneralDescriptionScroll,TRP2_CreationFrameQuestFrameGeneralDescriptionScroll,"TOP",0,10,TRP2_LOC_Description,TRP2_LOC_DescriptionQUEST);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameBaseListeEventAjout,TRP2_CreationFrameBaseListeEventAjout,"TOP",0,10,TRP2_LOC_NEWQUEST);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameQuestFrameListeEtapeAjout,TRP2_CreationFrameQuestFrameListeEtapeAjout,"TOP",0,10,TRP2_LOC_AJOUTETAPE);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameQuestFrameListeActionAjout,TRP2_CreationFrameQuestFrameListeActionAjout,"TOP",0,10,TRP2_LOC_AJOUTACTION);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameQuestFrameEtapeEtapeNum,TRP2_CreationFrameQuestFrameEtapeEtapeNum,"TOP",0,10,TRP2_LOC_ETAPESID,TRP2_LOC_ETAPENUM);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameQuestFrameEtapeDescriptionScrollEditBox,TRP2_CreationFrameQuestFrameEtapeDescriptionScroll,"TOP",0,10,TRP2_LOC_Description,TRP2_LOC_ETAPEDESCR);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameQuestFrameEtapeDescriptionScroll,TRP2_CreationFrameQuestFrameEtapeDescriptionScroll,"TOP",0,10,TRP2_LOC_Description,TRP2_LOC_ETAPEDESCR);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameQuestFrameEtapeEtatHelp,TRP2_CreationFrameQuestFrameEtapeEtatHelp,"TOP",0,10,TRP2_LOC_FLAG,TRP2_LOC_STATEQUEST);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameQuestFrameActionTypeHelp,TRP2_CreationFrameQuestFrameActionTypeHelp,"TOP",0,10,TRP2_LOC_ACTION,TRP2_LOC_ACTIONTYPETT);	
	TRP2_SetTooltipForFrame(TRP2_CreationFrameQuestFrameActionEtape,TRP2_CreationFrameQuestFrameActionEtape,"TOP",0,10,TRP2_LOC_ETAPES,TRP2_LOC_ACTIONETAPES);
	TRP2_SetTooltipForFrame(TRP2_CreationFrameQuestFrameActionParole,TRP2_CreationFrameQuestFrameActionParole,"TOP",0,10,TRP2_LOC_PAROLES,TRP2_LOC_ACTIONPAROLES);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurActuNotesScrollEditBox,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_NOTES);
	TRP2_SetTooltipForFrame(TRP2_FicheJoueurActuNotesScroll,TRP2MainFrame,"RIGHT",-10,-415,"{w}"..TRP2_LOC_NOTES);
		
	TRP2_SearchPanneauListeTitle:SetText(TRP2_CTS("{w}"..TRP2_LOC_RecherchePanneau));
	TRP2_PanneauListeTitle:SetText(TRP2_CTS("{w}"..TRP2_LOC_ListeVosPanneau));
	TRP2InventaireFramePanneauEdit:SetText(GAMEOPTIONS_MENU);
	TRP2_ListeSmallDropDownCategorieLabel:SetText(TRP2_CTS("{v}"..CATEGORY));
	TRP2_CreationFrameQuestFrameActionParole.texte = TRP2_LOC_PAROLES;
	TRP2_NPCAnimFrameScrollNomSaisie.texte = TRP2_CTS("{o}"..STATUS_TEXT_TARGET);
	TRP2_PetFrameEditionNom.texte = TRP2_CTS("{o}"..TRP2_LOC_NOM);
	TRP2_PetFrameEditionFrameHistoireTexte:SetText(TRP2_CTS("{w}"..TRP2_LOC_Histoire));
	TRP2_PetFrameEditionFrameDescriTexte:SetText(TRP2_CTS("{w}"..TRP2_LOC_Description));
	TRP2_FicheLanguagesListeTitle:SetText(TRP2_CTS("{w}"..TRP2_LOC_LanguesListe));
	TRP2_RegistreListeFiltreText:SetText(TRP2_CTS("{w}"..TRP2_LOC_Filtres));
	TRP2_RegistreListeRelationSliderLabel:SetText(TRP2_CTS("{o}"..TRP2_LOC_Relation));
	TRP2_RegistreAurasPanelEmpty:SetText(TRP2_CTS("{w}"..TRP2_LOC_NO_AURAS));
	TRP2_RegistreAurasPanelTitle:SetText(TRP2_CTS("{j}"..TRP2_LOC_Auras));
	TRP2_FicheJoueurActuActuTexte:SetText(TRP2_CTS("{w}"..TRP2_LOC_Actu3));
	TRP2_FicheJoueurActuHRPTexte:SetText(TRP2_CTS("{w}"..TRP2_LOC_HRPINFO));
	TRP2_FicheJoueurActuNotesTexte:SetText(TRP2_CTS("{w}"..TRP2_LOC_NOTES));
	TRP2_RaccBarTitleString:SetText(TRP2_CTS("{w}"..TRP2_LOC_RACCBAR));
	TRP2_ListeSmallRecherche.texte = TRP2_CTS("{o}"..SEARCH);
	TRP2_PetsListeRechercheSaisie.texte = TRP2_CTS("{o}"..SEARCH);
	TRP2_RegistreListeLevelSliderLabel:SetText(TRP2_CTS("{o}"..TRP2_LOC_AccessLevel));
	TRP2_RegistreListeConnectedCheckText:SetText(TRP2_CTS("{o}"..TRP2_LOC_ConnectSmall));
	TRP2_RegistreListeRechercheSaisie.texte = TRP2_CTS("{o}"..SEARCH);
	TRP2_FicheJoueurActuStatutRPLabel:SetText(TRP2_CTS("{o}"..TRP2_LOC_StatutRP));
	TRP2_FicheJoueurActuStatutXPLabel:SetText(TRP2_CTS("{o}"..TRP2_LOC_StatutXP));
	TRP2_FicheJoueurAgeSaisie.texte = TRP2_CTS("{o}"..TRP2_LOC_AGE);
	TRP2_FicheJoueurOrigineSaisie.texte = TRP2_CTS("{o}"..TRP2_LOC_ORIGINE);
	TRP2_FicheJoueurHabitationSaisie.texte = TRP2_CTS("{o}"..TRP2_LOC_HABITAT);
	TRP2_FicheJoueurClassSaisie.texte = TRP2_CTS("{o}"..CLASS);
	TRP2_FicheJoueurRaceSaisie.texte = TRP2_CTS("{o}"..RACE);
	TRP2_FicheJoueurTraitSaisie.texte = TRP2_CTS("{o}"..TRP2_LOC_VISAGETRAIT);
	TRP2_FicheJoueurYeuxSaisie.texte = TRP2_CTS("{o}"..TRP2_LOC_VISAGEYEUX);
	TRP2_FicheJoueurPiercingSaisie.texte = TRP2_CTS("{o}"..TRP2_LOC_VISAGEPIERCING);
	TRP2_FicheJoueurTailleSliderLabel:SetText(TRP2_CTS("{o}"..TRP2_LOC_TAILLE));
	TRP2_FicheJoueurSilhouetteSliderLabel:SetText(TRP2_CTS("{o}"..TRP2_LOC_SILHOUETTE));
	TRP2_FicheJoueurPrenomSaisie.texte = TRP2_CTS("{o}"..TRP2_LOC_PRENOM);
	TRP2_FicheJoueurNomSaisie.texte = TRP2_CTS("{o}"..TRP2_LOC_NOM);
	TRP2_FicheJoueurTitreSaisie.texte = TRP2_CTS("{o}"..TRP2_LOC_TITRE);
	TRP2_FicheJoueurTitreCompletSaisie.texte = TRP2_CTS("{o}"..TRP2_LOC_SOUSTITRE);
	TRP2_FicheJoueurBaseInfoGeneraleEdit:SetText(TRP2_CTS("{j}"..TRP2_LOC_DETAILREG));
	TRP2_FicheJoueurBaseInfoVisageEdit:SetText(TRP2_CTS("{j}"..TRP2_LOC_DETAILVISAGE));
	TRP2_FicheJoueurBaseInfoPhysiqueEdit:SetText(TRP2_CTS("{j}"..TRP2_LOC_PHYSIQUE));
	TRP2_FicheJoueurPsychoPersonnelTexte:SetText(TRP2_CTS("{w}"..TRP2_LOC_PsyPerso));
	TRP2_FicheJoueurPsychoSocialTexte:SetText(TRP2_CTS("{w}"..SOCIAL_LABEL));
	TRP2_FicheJoueurPsychoEditPersonnelTexte:SetText(TRP2_CTS("{w}"..TRP2_LOC_PsyPerso));
	TRP2_FicheJoueurPsychoEditSocialTexte:SetText(TRP2_CTS("{w}"..SOCIAL_LABEL));
	TRP2_FicheJoueurChaLuxSlider.textDroite = TRP2_LOC_Rationnel;
	TRP2_FicheJoueurChaLuxSlider.textGauche = TRP2_LOC_Pieux;
	TRP2_FicheJoueurIndRenSlider.textDroite = TRP2_LOC_Reflechi;
	TRP2_FicheJoueurIndRenSlider.textGauche = TRP2_LOC_Impulsif;
	TRP2_FicheJoueurGenEgoSlider.textDroite = TRP2_LOC_Bonvivant;
	TRP2_FicheJoueurGenEgoSlider.textGauche = TRP2_LOC_Acete;
	TRP2_FicheJoueurSinTroSlider.textDroite = TRP2_LOC_Valeureux;
	TRP2_FicheJoueurSinTroSlider.textGauche = TRP2_LOC_Couard;
	TRP2_FicheJoueurMisCruSlider.textDroite = TRP2_LOC_Luxurieux;
	TRP2_FicheJoueurMisCruSlider.textGauche = TRP2_LOC_Chaste;
	TRP2_FicheJoueurModVanSlider.textDroite = TRP2_LOC_Genereux;
	TRP2_FicheJoueurModVanSlider.textGauche = TRP2_LOC_Egoiste;
	TRP2_FicheJoueurPiePraSlider.textDroite = TRP2_LOC_Sincere
	TRP2_FicheJoueurPiePraSlider.textGauche = TRP2_LOC_Trompeur;
	TRP2_FicheJoueurRefImpSlider.textDroite = TRP2_LOC_Misericordieux;
	TRP2_FicheJoueurRefImpSlider.textGauche = TRP2_LOC_Cruel;
	TRP2_FicheJoueurAceBonSlider.textDroite = TRP2_LOC_Conciliant;
	TRP2_FicheJoueurAceBonSlider.textGauche = TRP2_LOC_Pragmatique;
	TRP2_FicheJoueurValCouSlider.textDroite = TRP2_LOC_Rencunier;
	TRP2_FicheJoueurValCouSlider.textGauche = TRP2_LOC_Indulgent;
	TRP2_FicheJoueurPsychoBar1.textGauche = TRP2_LOC_Pieux;
	TRP2_FicheJoueurPsychoBar1.textDroite = TRP2_LOC_Rationnel;
	TRP2_FicheJoueurPsychoBar2.textGauche = TRP2_LOC_Impulsif;
	TRP2_FicheJoueurPsychoBar2.textDroite = TRP2_LOC_Reflechi;
	TRP2_FicheJoueurPsychoBar3.textGauche = TRP2_LOC_Acete;
	TRP2_FicheJoueurPsychoBar3.textDroite = TRP2_LOC_Bonvivant;
	TRP2_FicheJoueurPsychoBar4.textGauche = TRP2_LOC_Couard;
	TRP2_FicheJoueurPsychoBar4.textDroite = TRP2_LOC_Valeureux;
	TRP2_FicheJoueurPsychoBar5.textGauche = TRP2_LOC_Chaste;
	TRP2_FicheJoueurPsychoBar5.textDroite = TRP2_LOC_Luxurieux;
	TRP2_FicheJoueurPsychoBar6.textGauche = TRP2_LOC_Egoiste;
	TRP2_FicheJoueurPsychoBar6.textDroite = TRP2_LOC_Genereux;
	TRP2_FicheJoueurPsychoBar7.textGauche = TRP2_LOC_Trompeur;
	TRP2_FicheJoueurPsychoBar7.textDroite = TRP2_LOC_Sincere;
	TRP2_FicheJoueurPsychoBar8.textGauche = TRP2_LOC_Cruel;
	TRP2_FicheJoueurPsychoBar8.textDroite = TRP2_LOC_Misericordieux;
	TRP2_FicheJoueurPsychoBar9.textGauche = TRP2_LOC_Pragmatique;
	TRP2_FicheJoueurPsychoBar9.textDroite = TRP2_LOC_Conciliant;
	TRP2_FicheJoueurPsychoBar10.textGauche = TRP2_LOC_Indulgent;
	TRP2_FicheJoueurPsychoBar10.textDroite = TRP2_LOC_Rencunier;
	TRP2_FicheJoueurPsychoBar11.textGauche = TRP2_LOC_Chaotique;
	TRP2_FicheJoueurPsychoBar11.textDroite = TRP2_LOC_Loyal;
	
	TRP2_CondiConstructorFrameTextuelle.texte = TRP2_LOC_Objet_VALEUR;
	TRP2_CondiConstructorFrameNumeric.texte = TRP2_LOC_NUMERIC;

	-- UI
	TRP2_ListeSoundFavSliderDistance:SetValue(12);
end