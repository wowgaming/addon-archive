-------------------------------------------------------------------
--                          Total RP 2
--            A roleplay addon for World of Warcraft
-- Created by Sylvain "Telkostrasz" Cossement (up to version 1.017)
--   Licence : CC BY-NC-SA (http://creativecommons.org/licenses/)
-------------------------------------------------------------------

TRP2_Libs = LibStub("AceAddon-3.0"):NewAddon("MyAddon", "AceSerializer-3.0")

function TRP2_OnLoad(self)
	self:RegisterEvent("ADDON_LOADED");
	self:RegisterEvent("CHAT_MSG_ADDON");
	self:RegisterEvent("PLAYER_TARGET_CHANGED");
	self:RegisterEvent("CHAT_MSG_CHANNEL");
	self:RegisterEvent("PLAYER_REGEN_DISABLED");
	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
	self:RegisterEvent("WORLD_MAP_UPDATE");
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	self:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE");
end

TRP2_UPDATERTAB = {};

function TRP2_OnEvent(self,event,...)
	local arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11,arg12 = ...;
	if(event=="ADDON_LOADED" and arg1=="totalRP2") then
		-- Chargement sécurisé
		local arg1,errorCall = TRP2_PCall(function() 
			TRP2_OnLoaded();
		end,nil,nil,nil,nil,nil,nil,nil,true);
		if errorCall then
			local Nom = string.sub(texte,4,string.find(texte,TRP2_LOC_DIT)-2);
		end
		
	elseif event=="CHAT_MSG_ADDON" then
		if arg1 == TRP2_COMM_PREFIX then
			if TRP2_EstIgnore(arg2) or arg2 == TRP2_Joueur or not TRP2_GetConfigValueFor("ActivateExchange",true) then
				return;
			end
			TRP2_receiveMessage(arg2,arg4);
		end
	elseif event=="CHAT_MSG_CHANNEL_NOTICE" then
		if arg1 == "YOU_JOINED" then
			TRP2_SePresenterSurLeChan();
		end
	elseif event=="PLAYER_ENTERING_WORLD" then
		RegisterAddonMessagePrefix(TRP2_COMM_PREFIX);
	elseif(event=="UPDATE_MOUSEOVER_UNIT") then
		local nom,royaume = UnitName("mouseover");
		if nom and nom ~= UNKNOWN and TRP2_EstDansLeReg(nom) and CheckInteractDistance("mouseover", 4) and not royaume and UnitIsPlayer("mouseover") and nom~=TRP2_Joueur and UnitFactionGroup("mouseover") == UnitFactionGroup("player") then
			if not TRP2_UPDATERTAB[nom] or time() - TRP2_UPDATERTAB[nom] > 1 then -- Optimisation (1 sec)
				TRP2_UPDATERTAB[nom] = time();
				TRP2_SecureSendAddonMessage("GTVN",TRP2_SendVernNum(),nom); -- Send VerNumTab avec request des VerNum adverses
				TRP2_MSP_Request(nom); -- MSP compatibility
			end
		end
		if TRP2_GetConfigValueFor("UseBroadcast",true) then
			if GetChannelName(string.lower(TRP2_GetConfigValueFor("ChannelToUse","xtensionxtooltip2"))) == 0 then
				JoinChannelByName(string.lower(TRP2_GetConfigValueFor("ChannelToUse","xtensionxtooltip2")));
			else -- Case of ReloadUI()
				TRP2_SePresenterSurLeChan();
			end
		end
		TRP2_MouseOverTooltip("mouseover");
		TRP2_UpdateRegistre();
	elseif(event=="PLAYER_TARGET_CHANGED") then
		local nom,royaume = UnitName("target");
		TRP2_TargetButton:Hide();
		TRP2_AuraTargetFrame:Hide();
		if nom and nom ~= UNKNOWN then -- Si on a une cible
			TRP2_PlacerIconeCible(nom);
			if not TRP2_EstDansLeReg(nom) and not royaume and UnitIsPlayer("target") and nom~=TRP2_Joueur and UnitFactionGroup("target") == UnitFactionGroup("player") then
				TRP2_MSP_Request(nom); -- MSP compatibility
				TRP2_SecureSendAddonMessage("GTVN",TRP2_SendVernNum(),nom); -- Send VerNumTab avec request des VerNum adverses
			end
		end
		--TRP2_debug(UnitCreatureFamily("target"));
	elseif(event=="CHAT_MSG_CHANNEL") then
		--Spécifique au Module Registre
		if string.lower(arg9) == string.lower(TRP2_GetConfigValueFor("ChannelToUse","xtensionxtooltip2")) then
			desaoulage = string.gsub(arg1, "%.%.%.hips %!", "");
			TRP2_ReceiveMessageChannel(arg1,arg2);
		end
	elseif(event=="PLAYER_REGEN_DISABLED") then -- Marche uniquement quand aggro.
		if TRP2_GetConfigValueFor("CloseOnCombat",false) then
			TRP2MainFrame:Hide();
			TRP2_CreationFrame:Hide();
		end
	elseif(event=="COMBAT_LOG_EVENT") then -- Prise de dégats
		TRP2_GererDegats(...);
	elseif event=="WORLD_MAP_UPDATE" then
		if not TRP2_GetConfigValueFor("bDontUseCoord",false) and TRP2_GetWorldMap():IsVisible() and TRP2_GetWorldMap().TRP2_Zone ~= TRP2_GetCurrentMapZone() then
			wipe(TRP2_PlayersPosition);
			for _,v in pairs(TRP2_MINIMAPBUTTON) do
				v:Hide();
			end
			wipe(TRP2_MINIMAPBUTTON);
		end
	end
end

function TRP2_GetWorldMap()
	if getglobal(TRP2_GetConfigValueFor("WorldMapToUse","WorldMapFrame")) then
		return getglobal(TRP2_GetConfigValueFor("WorldMapToUse","WorldMapFrame"));
	end
	return WorldMapFrame;
end

function TRP2_GossipFrame_OnEvent(self, event, ...)
	if ( event == "GOSSIP_SHOW" ) then
		if ( not GossipFrame:IsShown() ) then
			ShowUIPanel(self);
			if ( not self:IsShown() ) then
				CloseGossip();
				return;
			end
		end
		GossipFrameUpdate();
	elseif ( event == "GOSSIP_CLOSED" ) then
		HideUIPanel(self);
	end
end

function TRP2_test()
	TRP2_DebugScripterFrameScrollEditBox:SetText("");
	TRP2_DebugScripterFrameScrollEditBox:Insert("---- Continent 6 ----\n");
	for k,v in pairs({ GetMapZones(6)}) do
		TRP2_DebugScripterFrameScrollEditBox:Insert("\""..v.."\", -- "..k.."\n");
	end
	--print("huhu |cffffffff|Htotalrp2:Telkostrasz|h[Texte]|h|r");
	
end

function TRP2_OnLoaded()
	-- Configuration load
	TRP2_Set_Module_Configuration();
	-- Locale detection
	if not TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur]["Langue"] then
		if GetLocale() == "frFR" then
			TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur]["Langue"] = 1;
		elseif GetLocale() == "esES" then
			TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur]["Langue"] = 3;
		elseif GetLocale() == "deDE" then
			TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur]["Langue"] = 4;
		else
			TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur]["Langue"] = 2;
		end
	end
	-- Saving variables load
	TRP2_Set_Module_PlayerInfos();
	TRP2_Set_Module_Registre();
	TRP2_Set_Module_Inventaire();
	TRP2_Set_Module_Quests();
	TRP2_Set_Module_Document();
	TRP2_Set_Module_Packages();
	-- Data base and guide
	TRP2_LoadDataBase();
	TRP2_LoadGuide();
	-- Localization
	TRP2_SetLocalisation();
	-- UI loading;
	TRP2_InitialisationUI();
	TRP2_Localisation_SetUI();
	-- Welcoming message
	TRP2_Afficher(TRP2_LOC_ACCUEIL);
	-- Fichier export
	if not TRP2_Module_Interface["bHasWelcomed"] then
		TRP2_Module_Interface["bHasWelcomed"] = true;
		if TRP2_Guide_OpenPage then
			TRP2_Guide_OpenPage("Welcome");
		end
	end
	if TRP2_Module_Interface["bHasExport"] then
		TRP2_Module_Interface["bHasExport"] = nil;
		StaticPopupDialogs["TRP2_JUST_TEXT"].text = TRP2_CTS(TRP2_ENTETE..TRP2_LOC_EXPORTWIN);
		TRP2_ShowStaticPopup("TRP2_JUST_TEXT");
	end
	-- MSP support
	TRP2_MSP_InitialLoad();
	-- Si tout s'est bien passé, on charge le onUpdate général
	TRP2_DebugSynchronizedFrame:Show();
	
	if TRP2_GetConfigValueFor("DebugMode",false) then
		UIParentLoadAddOn("Blizzard_DebugTools");
		TRP2_Afficher("TRP2 : Debug mode activated");
	end
end

function TRP2_LoadDataBase()
	local langue = TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur]["Langue"];
	--Auras
	if _G["TRP2_LoadDBAuras_"..langue] ~= nil then
		_G["TRP2_LoadDBAuras_"..langue]();
	else
		message("Total RP 2\nAn error occured during the loading of the states database. The addon won't work correctly.");
		return;
	end
	--Document
	if _G["TRP2_LoadDBDocuments_"..langue] ~= nil then
		_G["TRP2_LoadDBDocuments_"..langue]();
	else
		message("Total RP 2\nAn error occured during the loading of the documents database. The addon won't work correctly.");
		return;
	end
	--Items
	if _G["TRP2_LoadDBItems_"..langue] ~= nil then
		_G["TRP2_LoadDBItems_"..langue]();
	else
		message("Total RP 2\nAn error occured during the loading of the items database. The addon won't work correctly.");
		return;
	end
	--Quests
	if _G["TRP2_LoadDBQuests_"..langue] ~= nil then
		_G["TRP2_LoadDBQuests_"..langue]();
	else
		message("Total RP 2\nAn error occured during the loading of the quests database. The addon won't work correctly.");
		return;
	end
end

function TRP2_LoadGuide()
	local langue = TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur]["Langue"];
	if _G["TRP2_LoadGuide_"..langue] ~= nil then
		_G["TRP2_LoadGuide_"..langue]();
	else
		message("Total RP 2\nAn error occured during the loading of the guidebook. The addon won't work correctly.");
		return;
	end
end