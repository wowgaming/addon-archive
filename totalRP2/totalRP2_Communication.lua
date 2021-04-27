-------------------------------------------------------------------
--                          Total RP 2
--            A roleplay addon for World of Warcraft
-- Created by Sylvain "Telkostrasz" Cossement (up to version 1.017)
--   Licence : CC BY-NC-SA (http://creativecommons.org/licenses/)
-------------------------------------------------------------------

TRP2_COMM_VERSION = "1";
TRP2_COMM_PREFIX = "TRP2."..TRP2_COMM_VERSION;
TRP2_COMM_PREFIX_SIZE = string.len(TRP2_COMM_PREFIX);

-- print(IsAddonMessagePrefixRegistered(TRP2_COMM_PREFIX))

function TRP2_SecureSendAddonMessage(Prefixe,Message,Cible,prior)

	if not prior then prior = "NORMAL" end

	if Prefixe == nil then
		TRP2_debug("Prefixe nil")
		return;
	elseif Message == nil then
		TRP2_debug("Message nil")
		return;
	elseif Cible == nil then
		TRP2_debug("Cible nil")
		return;
	end
	
	if not TRP2_GetConfigValueFor("ActivateExchange",true) then
		return;
	end

	local taille = string.len(Prefixe) + string.len(Message) + 1 + TRP2_COMM_PREFIX_SIZE;
	if taille > 254 then
		TRP2_Error("Internal Error : Tentative de TRPSecureSendAddonMessage avec une taille de "..taille.."!\nEnvoi annulé !");
		return;
	end
	ChatThrottleLib:SendAddonMessage(prior,TRP2_COMM_PREFIX,Prefixe..TRP2_ReservedChar..Message, "WHISPER", Cible);
end

function TRP2_SecureSendAddonMessageGroup(Prefixe,Message, prior)
	if not prior then prior = "NORMAL" end
	
	if Prefixe == nil then
		TRP2_debug("Prefixe nil")
		return;
	elseif Message == nil then
		TRP2_debug("Message nil")
		return;
	end
	
	if not TRP2_GetConfigValueFor("ActivateExchange",true) then
		return;
	end

	local taille = string.len(Prefixe) + string.len(Message) + 1 + TRP2_COMM_PREFIX_SIZE;
	
	if taille > 254 then
		TRP2_Error("Internal Error : Tentative de TRP2_SecureSendAddonMessageGroup avec une taille de "..taille.."!\nEnvoi annulé !");
		return;
	end
	if GetNumRaidMembers() > 0 then
		ChatThrottleLib:SendAddonMessage(prior,TRP2_COMM_PREFIX,Prefixe..TRP2_ReservedChar..Message, "RAID");
	elseif GetNumPartyMembers() > 0 then
		ChatThrottleLib:SendAddonMessage(prior,TRP2_COMM_PREFIX,Prefixe..TRP2_ReservedChar..Message, "PARTY");
	end
end

function TRP2_SendContentToChannel(infoTab,prefix)
	if not TRP2_GetConfigValueFor("UseBroadcast",true) or not TRP2_GetConfigValueFor("ActivateExchange",true) then
		return;
	end
	local message = TRP2_COMM_PREFIX..TRP2_ReservedChar..prefix;
	for _,info in pairs(infoTab) do
		message = message..TRP2_ReservedChar..info;
	end
	if string.len(message) < 254 then
		local channelName = GetChannelName(TRP2_GetConfigValueFor("ChannelToUse","xtensionxtooltip2"));
		ChatThrottleLib:SendChatMessage("NORMAL",TRP2_COMM_PREFIX, message, "CHANNEL", select(2, GetDefaultLanguage("player")), channelName);
	else
		TRP2_Error("Internal Error : Tentative de TRP2_SendContentToChannel avec une taille de "..string.len(message).."!\nEnvoi annulé !");
	end
end

function TRP2_ReceiveMessageChannel(message,sender)
	if sender == TRP2_Joueur or TRP2_EstIgnore(sender) or not TRP2_GetConfigValueFor("ActivateExchange",true) then
		return;
	end
	local messageTab = TRP2_fetchInformations(message);
	-- Un message n'est jamais seul.
	if not messageTab[1] == TRP2_COMM_PREFIX or not messageTab[2] then
		return;
	end
	
	if messageTab[2] == "GetLocalCoord" then
		TRP2_SendCoordonnees(sender,messageTab[3]);
	elseif messageTab[2] == "LocalSound" then
		TRP2_CalculateLocalSound(sender,messageTab[3],tonumber(messageTab[4]),tonumber(messageTab[5]),tonumber(messageTab[6]),tonumber(messageTab[7]));
	elseif messageTab[2] == "HELLO" then
		if tonumber(messageTab[3]) and not TRP2_bAlreadyTell and (tonumber(messageTab[3]) > tonumber(TRP2_version)) and TRP2_GetConfigValueFor("NotifyOnNew",true) then
			TRP2_bAlreadyTell = true;
			TRP2_NewVersionDispo(tonumber(messageTab[3]));
		end
		if not TRP2_EstDansLeReg(sender) and TRP2_GetConfigValueFor("AutoNew",true) then
			local nom, royaume = UnitName("target");
			if royaume then
				nom = nom.."-"..royaume;
			end
			TRP2_AjouterAuRegistre(sender, nom == sender);
		end
	elseif messageTab[2] == "GetPlanque" then
		TRP2_ChanGetPlanque(sender,messageTab[3]);
	elseif messageTab[2] == "GetPanneau" then
		TRP2_ChanGetPanneau(sender,messageTab[3]);
	elseif messageTab[2] == "GetLocalPlanquesCoord" then
		TRP2_SendCoordonneesPlanque(sender,messageTab[3]);
	elseif messageTab[2] == "GetLocalPanneauxCoord" then
		TRP2_SendCoordonneesPanneau(sender,messageTab[3]);
	elseif messageTab[2] == "GetLocalHousesCoord" then
		TRP2_SendCoordonneesHouse(sender,messageTab[3]);
	end
	
	
end

function TRP2_receiveMessage(message,sender)
	local prefixe = string.sub(message, 1, string.find(message,TRP2_ReservedChar)-1);
	message = string.sub(message,string.len(prefixe)+2);
	
	TRP2_debug("RECU : "..prefixe.." "..sender);

	------------------
	--- VERNUM
	------------------
	if prefixe == "GTVN" then -- GET VerNum
		-- On recoit une liste des versions, on renvoie directement sa liste des versions
		TRP2_SecureSendAddonMessage("SNVN",TRP2_SendVernNum(),sender,"ALERT");
		-- On traite les vernum reçu
		TRP2_ReceiveVerNumList(TRP2_fetchInformations(message),sender);
	elseif prefixe == "SNVN" then --SEND VerNum
		-- On traite les vernum reçu
		TRP2_ReceiveVerNumList(TRP2_fetchInformations(message),sender);
	------------------
	--- REGISTRE
	------------------
	elseif prefixe == "RRMI" then --REGISTRE REQUEST Info Minion
		TRP2_MinionJoueurFormatAndSend(sender);
	elseif prefixe == "RRMO" then --REGISTRE REQUEST Info Mount
		TRP2_MountJoueurFormatAndSend(sender);
	elseif prefixe == "RSMI" then --REGISTRE SENDING Info Minion
		TRP2_ReceiveMinion(message,sender);
	elseif prefixe == "RSMO" then --REGISTRE SENDING Info Mount
		TRP2_ReceiveMount(message,sender);
	------------------
	--- DIVERS
	------------------
	elseif prefixe == "SNHO" then --MAP Send House Coordonnees
		TRP2_AddHouseToMapTab(sender,TRP2_fetchInformations(message));
	elseif prefixe == "SNPL" then --MAP Send Planque Coordonnees
		TRP2_AddPlanqueToMapTab(sender,TRP2_fetchInformations(message));
	elseif prefixe == "SNCC" then --MAP Send Coordonnees
		TRP2_AddPlayerToMapTab(sender,TRP2_fetchInformations(message));
	elseif prefixe == "MESS" then -- Message
		local tab = TRP2_fetchInformations(message);
		TRP2_Afficher(TRP2_FT(_G[tab[1]],tab[2],tab[3],tab[4],tab[5]));
	elseif prefixe == "MERP" then -- Message RP
		TRP2_Afficher(message,TRP2_GetConfigValueFor("InvMessageFrameRP",1),true);
	elseif prefixe == "PLLS" then -- Play sound
		TRP2_PlayGroupSound(message,sender);
	------------------
	--- OBJECTS (n'importe quel tableau de données)
	------------------
	elseif prefixe == "ORIN" then --OBJET REQUEST Info
		local object = TRP2_GetObjectTab(message,TRP2_Joueur,{},sender);
		TRP2_SendObjectParts(message,object,sender);
	elseif prefixe == "ORSE" then --OBJET REQUEST Info
		TRP2_CheckDoIHaveInfo(TRP2_fetchInformations(message),sender);
	elseif prefixe == "OSIN" then --OBJET SEND Info
		TRP2_ReceiveObjectPart(message,sender);
	elseif prefixe == "OSRE" then --OBJET SEND Refusal
		TRP2_RefusalTab(TRP2_fetchInformations(message),sender);
		
	
	------------------
	--- TRADE
	------------------
	elseif prefixe == "OTST" then --OBJET TRADE START
		TRP2_StartExchangeAsk(message,sender);
	elseif prefixe == "OTUP" then --OBJET TRADE UPDATE
		TRP2_ExchangeReceiveTab(message,sender);
	elseif prefixe == "OTCA" then --OBJET TRADE CANCEL
		TRP2_CancelTransactionReceive(sender);
	elseif prefixe == "OTOK" then --OBJET TRADE OK
		TRP2_OKTransactionReceive(sender);
	elseif prefixe == "COSN" then --Colis Send
		TRP2_ReceiveColis(TRP2_fetchInformations(message),sender);
	elseif prefixe == "COOK" then --Colis Send
		TRP2_ReceiveColisOK(tonumber(message),sender);
	------------------
	--- PLANQUE
	------------------
	elseif prefixe == "PLSI" then --PLANQUE send info (from owner)
		TRP2_PlanqueReceiveInfo(sender,TRP2_fetchInformations(message));
	elseif prefixe == "PLIN" then --PLANQUE init visit (from visitor)
		TRP2_PlanqueInitVisit(sender,message);
	elseif prefixe == "PLSU" then --PLANQUE send update (from owner)
		TRP2_GetUpdateFromPlanque(sender,TRP2_fetchInformations(message));
	elseif prefixe == "PLST" then --PLANQUE STOP (from owner)
		TRP2_PlanqueStop(sender,message);
	elseif prefixe == "PLRL" then --PLANQUE Release lock (from visitor)
		TRP2_PlanqueReleaseLock(sender,message);
	elseif prefixe == "PLUL" then --PLANQUE send Update (from visitor)
		TRP2_GetUpdateFromVisitor(sender,TRP2_fetchInformations(message));
	elseif prefixe == "PLLO" then --PLANQUE Log (from visitor)
		TRP2_GetPlanqueLog(sender,TRP2_fetchInformations(message));
	elseif prefixe == "PLAS" then --PLANQUE Ask (from visitor)
		TRP2_PlanqueAsk(sender,message);
	elseif prefixe == "PLOK" then --PLANQUE Ask ok (from owner)
		TRP2_PlanqueAskOk(sender);
	------------------
	--- PANNEAU
	------------------
	elseif prefixe == "PASI" then --PANNEAU send info (from owner)
		TRP2_PanneauReceiveInfo(sender,TRP2_fetchInformations(message));
	elseif prefixe == "SNPA" then --MAP Send Panneau Coordonnees
		TRP2_AddPanneauToMapTab(sender,TRP2_fetchInformations(message));
	------------------
	--- LANGAGE
	------------------
	elseif prefixe == "LATR" then -- Demande de traduction
		TRP2_ReceiveTranslateRequest(sender,TRP2_fetchInformations(message));
	elseif prefixe == "LASN" then -- Reception de traduction
		TRP2_ReceiveTranslate(sender,TRP2_fetchInformations(message));
	------------------
	--- ITEM LINK
	------------------
	elseif prefixe == "ILGT" then -- Asking for item id
		TRP2_ItemLinkIDRequested(message,sender);
	elseif prefixe == "ILSN" then -- Receive item id
		TRP2_ItemLinkIDReceived(message,sender);
	------------------
	--- PACKAGE
	------------------
	elseif prefixe == "PKMD" then -- Reception Package Metadata
		TRP2_GetPackageMetadata(sender,TRP2_fetchInformations(message));
	end
end

-----------------------------------
-- DATA REQUESTS - SYNCRHONIZED TAB
-----------------------------------

-- Ouverture de "Est ce que tu as besoin de ID ?"
function TRP2_GetCreaInfo(target,ID,VerNum)
	TRP2_SecureSendAddonMessage("ORSE",ID..TRP2_ReservedChar..VerNum,target);
end

-- Vérification de "Est ce que j'ai besoin de ID ?"
function TRP2_CheckDoIHaveInfo(tab,sender)
	if string.sub(tab[1],1,3) == "PAK" then
		TRP2_OpenRequestForObject(tab[1],sender);
		return;
	end
	local tableau = TRP2_GetTabInfo(tab[1]);
	if not TRP2_Module_Interface["BannedID"][tab[1]] and (not tableau or TRP2_GetWithDefaut(tableau,"VerNum",1) < tonumber(tab[2])) then
		TRP2_OpenRequestForObject(tab[1],sender);
	end
end

-- Vérifie que le tableau de synchro est existant pour cible, si pas on le créer.
function TRP2_OpenRequestTabFor(cible)
	if not TRP2_SynchronisedTab[cible] then 
		TRP2_SynchronisedTab[cible] = {};
	end
end

-- On recois un refus
function TRP2_RefusalTab(tab,sender)
	if TRP2_EmptyToNil(tab[1]) then --ID
		--TRP2_debug("REFUSAL de "..sender.." : Id "..tab[1]);
		if TRP2_SynchronisedTab[sender] and TRP2_SynchronisedTab[sender][tab[1]] then
			TRP2_SynchronisedTab[sender][tab[1]] = nil;
			TRP2_TerminerSynchroWith(sender);
		end
	end
end

-- On supprime le tableau de synchronisation avec sender si il est vide.
function TRP2_TerminerSynchroWith(sender)
	if TRP2_SynchronisedTab[sender] and TRP2_GetIndexedTabSize(TRP2_SynchronisedTab[sender]) == 0 then
		TRP2_SynchronisedTab[sender] = nil;
	end
end

-- Cette fonction préparer la requete d'un tableau
function TRP2_OpenRequestForObject(ID,cible)
	if not TRP2_GetConfigValueFor("ActivateExchange",true) then return; end
	TRP2_OpenRequestTabFor(cible);
	if not TRP2_SynchronisedTab[cible][ID] then
		TRP2_SynchronisedTab[cible][ID] = {};
		TRP2_SecureSendAddonMessage("ORIN",ID,cible);
		--TRP2_debug("Request for "..cible.." : "..ID);
	end -- ELSE : Requete déjà en cours pour cet object
end

-----------------------------------
-- DATA SENDING
-----------------------------------

-- Streamise un tableau (via Ace-Serializer) et l'envoi à target
function TRP2_SendObjectParts(id,infoTab,target)
	if not id or not target then 
		TRP2_Error("Erreur TRP2_SendObjectTo : id or target null");
		return;
	end
	if not infoTab then 
		TRP2_SecureSendAddonMessage("OSRE",id,target);
		return;
	end
	TRP2_debug("STREAMING "..id);
	-- Serialization
	local serializedStream = TRP2_Libs:Serialize(infoTab);
	local serializedStreamSize = string.len(serializedStream);
	local position = 1;
	local streamParts = {};
	local partsNbr = 0;
	-- Stream Cutting
	local idSize = string.len(id);
	while true do
		-- TRP2_COMM_PREFIX_SIZE + PREFIX(4) + SC(1) + id + SC(1) + part + SC(1)
		local partSizeAllowed = 254 - TRP2_COMM_PREFIX_SIZE - idSize - string.len(tostring(partsNbr + 1)) - 8;
		local part = string.sub(serializedStream,position,position+partSizeAllowed);
		-- Break condition
		if string.len(part) == 0 then
			break;
		end
		partsNbr = partsNbr + 1;
		-- Stream part = object id + part number + part info
		streamParts[partsNbr] = id..TRP2_ReservedChar..partsNbr..TRP2_ReservedChar..part;
		position = position + partSizeAllowed + 1; 
	end
	-- Fin de transmission
	partsNbr = partsNbr + 1;
	streamParts[partsNbr] = id..TRP2_ReservedChar.."0"..TRP2_ReservedChar;
	TRP2_debug("Parts : "..(partsNbr));
	
	for k,part in pairs(streamParts) do
		TRP2_SecureSendAddonMessage("OSIN",part,target);
	end
end

-----------------------------------
-- DATA RECEIVING
-----------------------------------

-- Réception d'un morceau de stream
function TRP2_ReceiveObjectPart(message,sender)
	if TRP2_SynchronisedTab[sender] then
		local id, index, stream = strsplit(TRP2_ReservedChar, message);
		index = tonumber(index);
		if TRP2_SynchronisedTab[sender][id] then 
			if index == 0 then -- Fin de transmission
				TRP2_ReceiveObjectFinish(sender,id);
			else
				TRP2_SynchronisedTab[sender][id][index] = stream;
			end
		else
			TRP2_debug("Pas de query attendu pour cet object... "..id);
		end
	else
		TRP2_debug("Pas que query attendu... "..sender);
	end
end

-- Recomposition de l'objet
function TRP2_ReceiveObjectFinish(sender,id)
	local completeStream = TRP2_SuperFetchInformations(TRP2_SynchronisedTab[sender][id]);
	local success, object = TRP2_Libs:Deserialize(completeStream);
	if not success then
		TRP2_Error("Deserialization error");
	else
		TRP2_TraiterTab(id,object,sender,completeStream);
	end
	wipe(TRP2_SynchronisedTab[sender][id]);
	TRP2_SynchronisedTab[sender][id] = nil;
	TRP2_TerminerSynchroWith(sender);
end

-- On traite l'objet qu'on viens de recomposer pour prendre des décisions de stockage
function TRP2_TraiterTab(id,infoTab,sender,completeStream)
	if id == "Auras" then
		TRP2_SaveSendedAurasTab(sender,infoTab);
		TRP2_RefreshRegistre(sender);
	elseif id == "Actu" then
		wipe(TRP2_GetInfo(sender,"Actu",{}));
		TRP2_SetInfo(sender,"Actu",infoTab);
		TRP2_RefreshRegistre(sender);
	elseif id == "Registre" then
		wipe(TRP2_GetInfo(sender,"Registre",{}));
		TRP2_SetInfo(sender,"Registre",infoTab);
		TRP2_RefreshRegistre(sender);
	elseif id == "Physique" then
		wipe(TRP2_GetInfo(sender,"Physique",{}));
		TRP2_SetInfo(sender,"Physique",infoTab);
	elseif id == "Histoire" then
		wipe(TRP2_GetInfo(sender,"Histoire",{}));
		TRP2_SetInfo(sender,"Histoire",infoTab);
		TRP2_RefreshRegistre(sender);
	elseif id == "Psycho" then
		wipe(TRP2_GetInfo(sender,"Psycho",{}));
		TRP2_SetInfo(sender,"Psycho",infoTab);
		TRP2_RefreshRegistre(sender);
	elseif string.sub(id,1,3) == "PET" then
		local petTab = TRP2_GetInfo(sender,"Pets",{});
		wipe(TRP2_GetWithDefaut(petTab,string.sub(id,4),{}));
		petTab[string.sub(id,4)] = infoTab;
		TRP2_SetInfo(sender,"Pets",petTab);
		
		if TRP2MainFrame:IsVisible() and TRP2MainFrame.Onglet == "Pets" and TRP2MainFrame.Nom == sender then
			TRP2_OpenPanel("Fiche", "Pets", TRP2MainFrame.SousOnglet, TRP2MainFrame.Mode, TRP2MainFrame.Nom);
		end
	elseif string.sub(id,1,4) == "APET" then
		local petTab = TRP2_GetInfo(sender,"Pets",{});
		if not petTab[string.sub(id,5)] then petTab[string.sub(id,5)] = {}; end
		-- On ne tient pas compte de l'état si pas niveau d'accès
		local realTab = {};
		for auraID,auraVernum in pairs(infoTab) do
			if not TRP2_Module_Interface["BannedID"][auraID] then
				realTab[auraID] = auraVernum;
				if string.len(auraID) == TRP2_IDSIZE and TRP2_GetWithDefaut(TRP2_GetAuraInfo(auraID),"VerNum",0) < tonumber(auraVernum) then
					if not TRP2_Module_AurasTemp[auraID] then
						TRP2_Module_AurasTemp[auraID] = {};
					end
					TRP2_OpenRequestForObject(auraID,sender);
				end
			end
		end
		-- On enregistre
		petTab[string.sub(id,5)]["AurasTab"] = realTab;
		TRP2_SetInfo(sender,"Pets",petTab);
		if TRP2MainFrame:IsVisible() and TRP2MainFrame.Onglet == "Pets" and TRP2MainFrame.Nom == sender then
			TRP2_OpenPanel("Fiche", "Pets", TRP2MainFrame.SousOnglet, TRP2MainFrame.Mode, TRP2MainFrame.Nom);
		end
	else
		local prefix = string.sub(id,1,3);
		if prefix == "ITE" then
			if TRP2_Module_ObjetsPerso[id] then wipe(TRP2_Module_ObjetsPerso[id]) end
			TRP2_Module_ObjetsPerso[id] = infoTab;
			if TRP2_CreationFrameBase:IsVisible() then
				TRP2_CreationPanel();
			end
			if TRP2_ItemLinkTooltip:IsVisible() and TRP2_ItemLinkTooltip.savedTab and TRP2_ItemLinkTooltip.savedTab["ID"] == id then
				TRP2_ShowItemLink(TRP2_ItemLinkTooltip.savedTab);
			end
		elseif prefix == "AUR" then
			if not TRP2_Module_Auras[id] and TRP2_Module_AurasTemp[id] ~= nil then
				TRP2_Module_AurasTemp[id] = infoTab;
				TRP2_Module_AurasTemp[id]["custom"] = true;
			else
				if TRP2_Module_Auras[id] then wipe(TRP2_Module_Auras[id]) end
				TRP2_Module_Auras[id] = infoTab;
			end

			if TRP2MainFrame:IsVisible() and TRP2MainFrame.Panel == "Fiche" and TRP2MainFrame.Onglet == "Pets" and TRP2MainFrame.Nom == sender then
				TRP2_OpenPanel("Fiche", "Pets", TRP2MainFrame.SousOnglet, TRP2MainFrame.Mode, sender);
			end
			if TRP2_CreationFrameBase:IsVisible() then
				TRP2_CreationPanel();
			end
			-- Check si on a l'état sur nous !
			for key,_ in pairs(TRP2_GetInfo(TRP2_Joueur,"AurasTab",{})) do
				if key == id then
					TRP2_IncreaseVerNumAura();
					break;
				end
			end
			if sender == UnitName("mouseover") then
				TRP2_MouseOverTooltip("mouseover");
			end
			if sender == UnitName("target") then
				TRP2_PlacerIconeCible(sender);
			end
			return; -- Pas de liaison dans le cadre d'un package !
		elseif prefix == "DOC" then
			if TRP2_Module_Documents[id] then wipe(TRP2_Module_Documents[id]) end
			TRP2_Module_Documents[id] = infoTab;
			if TRP2_DocumentFrame:IsVisible() and TRP2_DocumentFrame.Id == id then
				TRP2_ChargerDocument(infoTab,TRP2_DocumentFrame.Page,id,bApercu);
			end
			if TRP2_CreationFrameBase:IsVisible() then
				TRP2_CreationPanel();
			end
		elseif prefix == "QUE" then
			if TRP2_Module_Quests[id] then wipe(TRP2_Module_Quests[id]) end
			TRP2_Module_Quests[id] = infoTab;
			if TRP2_CreationFrameBase:IsVisible() then
				TRP2_CreationPanel();
			end
		elseif prefix == "PAK" then
			TRP2_UnpackPackage(infoTab, id, sender);
			return; -- Pas de liaison dans le cadre d'un package !
		end
		TRP2_FindAndGetLiaisons(completeStream,sender,id);
	end
	
	if sender == UnitName("mouseover") then
		TRP2_MouseOverTooltip("mouseover");
	end
end

-- Recherche de référence dans un stream et ouverture de requêtes
function TRP2_FindAndGetLiaisons(stream,sender,ID)
	if string.sub(ID,1,3) == "AUR" and tonumber(TRP2_GetWithDefaut(TRP2_GetAuraInfo(ID),"EtatCat",2)) == 3 then -- Pas de liaison si état de type quête !
		return;
	end
	local IDList = TRP2_FindIDInStream(stream);
	for k,v in pairs(IDList) do
		if not TRP2_Module_Interface["BannedID"][k] and not TRP2_GetTabInfo(k) then
			TRP2_OpenRequestForObject(k,sender);
		end
	end
end

-- Recherche des références objets dans un stream
function TRP2_FindIDInStream(stream)
	--TRP2_debug(stream);
	local tab = {};
	string.gsub(stream,"ITE%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d",function(ITE)
		if not tab[ITE] then
			tab[ITE] = 0;
		end
		tab[ITE] = tab[ITE] + 1;
		return ITE;
	end);
	string.gsub(stream,"AUR%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d",function(AUR)
		if not tab[AUR] then
			tab[AUR] = 0;
		end
		tab[AUR] = tab[AUR] + 1;
		return AUR;
	end);
	string.gsub(stream,"DOC%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d",function(DOC)
		if not tab[DOC] then
			tab[DOC] = 0;
		end
		tab[DOC] = tab[DOC] + 1;
		return DOC;
	end);
	string.gsub(stream,"QUE%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d",function(QUE)
		if not tab[QUE] then
			tab[QUE] = 0;
		end
		tab[QUE] = tab[QUE] + 1;
		return QUE;
	end);
	return tab;
end

-- Trouve le tableau en fonction de l'id.
function TRP2_GetObjectTab(id,nom,defaut,asking)
	-- Verif le OTY
	if nom then
		if id == "Actu" then
			return TRP2_GetInfo(nom,"Actu",defaut);
		elseif id == "Registre" then
			return TRP2_GetInfo(nom,"Registre",defaut);
		elseif id == "Physique" then
			return TRP2_GetInfo(nom,"Physique",defaut);
		elseif id == "Histoire" then
			if not asking or TRP2_GetAccess(asking) >= TRP2_GetConfigValueFor("AccessHisto",3) then
				return TRP2_GetInfo(nom,"Histoire",defaut);
			else
				local tableau = {};
				TRP2_tcopy(tableau,TRP2_GetInfo(nom,"Histoire",defaut));
				tableau["HistoireTexte"] = "\n\n\n{titre3:centre}"..TRP2_LOC_TRUSTNEEDED.."{/titre3}";
				return tableau;
			end
		elseif id == "Psycho" then
			return TRP2_GetInfo(nom,"Psycho",defaut);
		end
	end
	-- Tableaux des auras
	if id == "Auras" then
		return TRP2_FormatAuraToSend(TRP2_Joueur);
	end
	
	local prefix = string.sub(id,1,3);
	local prefixLong = string.sub(id,1,4);
	
	if prefix == "PET" then
		local petTab = TRP2_GetInfo(nom,"Pets",{});
		return TRP2_GetWithDefaut(petTab,string.sub(id,4),{});
	elseif prefixLong == "APET" then
		local petTab = TRP2_GetWithDefaut(TRP2_GetWithDefaut(TRP2_GetInfo(nom,"Pets",{}),string.sub(id,5),{}),"AurasTab",{});
		local auraTab = {};
		for auraID,v in pairs(petTab) do
			local info = TRP2_GetAuraInfo(auraID);
			if tonumber(TRP2_GetWithDefaut(info,"EtatCat",2)) ~= 2 then
				auraTab[auraID] = v;
			end
		end
		return auraTab;
	elseif prefix == "ITE" then
		return TRP2_GetItemInfo(id);
	elseif prefix == "AUR" then
		return TRP2_GetAuraInfo(id);
	elseif prefix == "QUE" then
		return TRP2_GetQuestsInfo(id);
	elseif prefix == "DOC" then
		return TRP2_GetDocumentInfo(id);
	elseif prefix == "PAK" then
		return TRP2_GetPackageCompleteTab(id);
	end
	return defaut;
end