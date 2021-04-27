-------------------------------------------------------------------
--                          Total RP 2
--            A roleplay addon for World of Warcraft
-- Created by Sylvain "Telkostrasz" Cossement (up to version 1.017)
--   Licence : CC BY-NC-SA (http://creativecommons.org/licenses/)
-------------------------------------------------------------------

--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- Gestion des packages (ca va etre super !)
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

function TRP2_Set_Module_Packages()
	if not TRP2_Module_Packages then
		TRP2_Module_Packages = {};
	end
	if not TRP2_Module_Packages[TRP2_Royaume] then
		TRP2_Module_Packages[TRP2_Royaume] = {};
	end
	if not TRP2_Module_Packages[TRP2_Royaume][TRP2_Joueur] then
		TRP2_Module_Packages[TRP2_Royaume][TRP2_Joueur] = {};
	end
	
	for k=1,49,1 do --Initialisation
		getglobal("TRP2_CreationFrameBaseListePackagesSlot"..k.."Icon"):SetTexture("Interface\\ICONS\\INV_Misc_Gift_05");
	end
end

function TRP2_GetPlayerPackages()
	return TRP2_Module_Packages[TRP2_Royaume][TRP2_Joueur];
end

function TRP2_PackageCreation()
	StaticPopupDialogs["TRP2_GET_TEXT_NS"].text = TRP2_CTS(TRP2_ENTETE..TRP2_LOC_CREATEPACKAGE);
	TRP2_ShowStaticPopup("TRP2_GET_TEXT_NS",nil,function(name)
		local ID = TRP2_CreateID("PAK");
		TRP2_Module_Packages[TRP2_Royaume][TRP2_Joueur][ID] = {};
		TRP2_Module_Packages[TRP2_Royaume][TRP2_Joueur][ID]["Objects"] = {};
		TRP2_Module_Packages[TRP2_Royaume][TRP2_Joueur][ID]["DateCreation"] = date("%d/%m/%y à %H:%M:%S");
		TRP2_Module_Packages[TRP2_Royaume][TRP2_Joueur][ID]["Nom"] = TRP2_EmptyToNil(name);
		TRP2_ListerPackages();
	end,nil,nil,nil,nil,TRP2_LOC_PACKAGE);
end

TRP2_CreaListTabPackages = {};

-- Demande d'envoi des metadata (coté ENVOYEUR)
function TRP2_SendPackageMetadata(target,packageID)
	-- 1 : packID (18)
	-- 2 : pack name (100)
	-- 3 : pack size (7)
	-- 4 : pack num item (4)
	local packageTab = TRP2_GetPlayerPackages()[packageID];
	local Message = packageID..TRP2_ReservedChar..TRP2_StringNFirst(TRP2_GetWithDefaut(packageTab,"Nom",TRP2_PACKAGE),97)..TRP2_ReservedChar;
	local size = 0;
	for creaID,_ in pairs(packageTab["Objects"]) do
		size = size + string.len(TRP2_Libs:Serialize(TRP2_GetTabInfo(creaID)));
	end
	Message = Message..size..TRP2_ReservedChar..TRP2_GetIndexedTabSize(packageTab["Objects"]);
	
	TRP2_SecureSendAddonMessage("PKMD",Message,target);
end

-- Reception du metadata (coté RECEVEUR)
function TRP2_GetPackageMetadata(sender, tab)
	-- 1 : packID
	-- 2 : pack name
	-- 3 : pack size
	-- 4 : pack num item
	local packageID = tab[1];
	local packageName = tab[2];
	local packageSize = tonumber(tab[3]);
	local packageItemNum = tab[4];
	local messNum = math.ceil(packageSize/221);
	local temps = math.ceil((messNum - 4)/3.14);
	
	StaticPopupDialogs["TRP2_CONFIRM_ACTION_NS"].text = TRP2_CTS(TRP2_ENTETE.."\n"..TRP2_FT(TRP2_LOC_PACKASK,
		packageName,
		packageItemNum,
		TRP2_OctetstoString(packageSize),
		messNum,
		TRP2_StringToMinutes(temps),
		sender));
	TRP2_ShowStaticPopup("TRP2_CONFIRM_ACTION_NS",nil,function() 
		TRP2_OpenRequestForObject(packageID,sender);
		TRP2_PackageDownloader.owner = sender;
		TRP2_PackageDownloader.packageID = packageID;
		TRP2_PackageDownloader.packageSize = messNum;
		TRP2_PackageDownloader:Show();
		TRP2_SetTooltipForFrame(TRP2_PackageDownloaderHeaderButton,TRP2_PackageDownloaderHeaderButton,"RIGHT",0,0,"{w}"..packageName,
			"{o}"..TRP2_FT(TRP2_LOC_RECEIVFROM,sender).."\n{o}"..TRP2_LOC_CreaNbr.." : {w}"..packageItemNum
			.."\n{o}"..TRP2_LOC_PACKAGESIZE.." : {w}"..TRP2_OctetstoString(packageSize).."\n{o}"..TRP2_LOC_ESTIMATIONTRANSF.." : {w}"..TRP2_StringToMinutes(temps)
			.."\n\n{j}"..TRP2_LOC_PACKAGESENDINFO1);
	end);
	
end

-- Mise à jour du loading bar
function TRP2_PackageLoadingBar(owner,packageID,packageSize)
	if TRP2_SynchronisedTab[owner] and TRP2_SynchronisedTab[owner][packageID] then
		local size = #TRP2_SynchronisedTab[owner][packageID];
		local rapport = math.ceil((size/packageSize)*100);
		TRP2_PackageDownloaderLoadingFrameText:SetText(TRP2_CTS("{w}"..TRP2_LOC_Downloading.." : ".." : {w}"..rapport.."%"));
		TRP2_PackageDownloaderLoadingFrameProgress:SetWidth(145*(rapport/100));
	else
		TRP2_PackageDownloader:Hide();
	end
end

-- Reception de la demande de package
function TRP2_GetPackageCompleteTab(packageID)
	local packageTab = TRP2_GetPlayerPackages()[packageID];
	local completeTab = {};
	for creaID,_ in pairs(packageTab["Objects"]) do
		local creaTab = TRP2_GetTabInfo(creaID);
		if creaTab then
			completeTab[creaID] = creaTab;
		end
	end
	return completeTab;
end

-- On déballe le package et on prend ce dont on a besoin
function TRP2_UnpackPackage(packageTab,packageID,sender)
	local number = 0;
	for creaID,creaTab in pairs(packageTab) do
		local myCreaTab = TRP2_GetTabInfo(creaID);
		if not myCreaTab or TRP2_GetWithDefaut(myCreaTab,"VerNum",0) < TRP2_GetWithDefaut(creaTab,"VerNum",0) then
			number = number + 1;
			local prefix = string.sub(creaID,1,3);
			if prefix == "ITE" then
				if TRP2_Module_ObjetsPerso[creaID] then
					wipe(TRP2_Module_ObjetsPerso[creaID]);
				else
					TRP2_Module_ObjetsPerso[creaID] = {};
				end
				TRP2_tcopy(TRP2_Module_ObjetsPerso[creaID],creaTab);
			elseif prefix == "AUR" then
				if TRP2_Module_Auras[creaID] then
					wipe(TRP2_Module_Auras[creaID]);
				else
					TRP2_Module_Auras[creaID] = {};
				end
				TRP2_tcopy(TRP2_Module_Auras[creaID],creaTab);
			elseif prefix == "DOC" then
				if TRP2_Module_Documents[creaID] then
					wipe(TRP2_Module_Documents[creaID]);
				else
					TRP2_Module_Documents[creaID] = {};
				end
				TRP2_tcopy(TRP2_Module_Documents[creaID],creaTab);
			elseif prefix == "QUE" then
				if TRP2_Module_Quests[creaID] then
					wipe(TRP2_Module_Quests[creaID]);
				else
					TRP2_Module_Quests[creaID] = {};
				end
				TRP2_tcopy(TRP2_Module_Quests[creaID],creaTab);
			end
		end
	end
	if TRP2_CreationFrameBase:IsVisible() then
		TRP2_CreationPanel();
	end
	TRP2_Afficher(TRP2_FT(TRP2_LOC_PACKAGEDONE,sender,number));
	TRP2_SecureSendAddonMessage("MESS","TRP2_LOC_AKNOWLEDGEPACK"..TRP2_ReservedChar..TRP2_Joueur..TRP2_ReservedChar..number,sender,"ALERT");
end

function TRP2_ListerPackages()
	local i = 0; -- Nombre total
	local j = 0; -- Nombre pris
	local search = TRP2_EmptyToNil(TRP2_CreationFrameBaseListePackagesRecherche:GetText());
	TRP2_CreationFrameBaseListePackagesSlider:Hide();
	TRP2_CreationFrameBaseListePackagesSlider:SetValue(0);
	wipe(TRP2_CreaListTabPackages);
	
	for packageID, packageTab in pairs(TRP2_GetPlayerPackages()) do
		i = i+1;
		if not search or TRP2_ApplyPattern(TRP2_GetWithDefaut(packageTab,"Nom",""),search) then
			j = j + 1;
			TRP2_CreaListTabPackages[j] = packageID;
		end
	end
	
	table.sort(TRP2_CreaListTabPackages);

	if j > 0 then
		TRP2_CreationFrameBaseListePackagesEmpty:SetText("");
	elseif i == 0 then
		TRP2_CreationFrameBaseListePackagesEmpty:SetText(TRP2_LOC_NoPACKAGES);
	else
		TRP2_CreationFrameBaseListePackagesEmpty:SetText(TRP2_LOC_SelectVide);
	end
	if j > 49 then
		TRP2_CreationFrameBaseListePackagesSlider:Show();
		local total = floor((j-1)/49);
		TRP2_CreationFrameBaseListePackagesSlider:SetMinMaxValues(0,total);
	end
	TRP2_CreationFrameBaseListePackagesSlider:SetScript("OnValueChanged",function(self)
		if self:IsVisible() then
			TRP2_ListerPackagesPage(self:GetValue());
		end
	end)
	TRP2_CreationFrameBaseListePackagesRecherche:SetScript("OnTextChanged",function(self)
		if self:IsVisible() then
			TRP2_ListerPackages();
		end
	end)
	TRP2_ListerPackagesPage(0);
end

function TRP2_ListerPackagesPage(num)
	for k=1,49,1 do --Initialisation
		getglobal("TRP2_CreationFrameBaseListePackagesSlot"..k):Hide();
	end
	local i = 1;
	local j = 1;
	for _,packageID in pairs(TRP2_CreaListTabPackages) do
		if i > num*49 and i <= (num+1)*49 then
			local ID = packageID;
			local PackagesTab = TRP2_GetPlayerPackages()[ID];
			getglobal("TRP2_CreationFrameBaseListePackagesSlot"..j):Show();
			getglobal("TRP2_CreationFrameBaseListePackagesSlot"..j):SetScript("OnClick", function(self,button)
				if button == "LeftButton" then
					if IsControlKeyDown() then
						-- Envoi in game du package
						if UnitName("target") and UnitName("target") ~= TRP2_Joueur and UnitIsPlayer("target") and UnitFactionGroup("target") == UnitFactionGroup("player") then
							TRP2_SendPackageMetadata(UnitName("target"),ID);
						else
							StaticPopupDialogs["TRP2_GET_TEXT_NS"].text = TRP2_CTS(TRP2_FT(TRP2_ENTETE..TRP2_LOC_SendInfoTT,TRP2_GetWithDefaut(PackagesTab,"Nom",UNKNOWN)));
							TRP2_ShowStaticPopup("TRP2_GET_TEXT_NS",nil,TRP2_SendPackageMetadata,ID);
						end
					else
						-- Ouvrir le package
						TRP2_OpenPackage(ID);
					end
				elseif button == "RightButton" then
					if IsControlKeyDown() then
						-- Statistiques
						TRP2_ProcessPackageStats(ID);
					elseif IsShiftKeyDown() then
						-- Export de ce package vers le package d'exportation
						TRP2_ExportAdd(ID);
					else
						-- Suppression
						StaticPopupDialogs["TRP2_CONFIRM_ACTION_NS"].text = TRP2_CTS(TRP2_FT(TRP2_ENTETE..TRP2_LOC_DEL_REF_PACK,TRP2_GetWithDefaut(PackagesTab,"Nom",TRP2_LOC_PACKAGE)));
						TRP2_ShowStaticPopup("TRP2_CONFIRM_ACTION_NS",nil,function()
							wipe(TRP2_Module_Packages[TRP2_Royaume][TRP2_Joueur][ID]);
							TRP2_Module_Packages[TRP2_Royaume][TRP2_Joueur][ID] = nil;
							if TRP2_OpenedPackage.packageID == ID then
								TRP2_OpenedPackage:Hide();
							end
							TRP2_ListerPackages();
						end);
					end
				end
			end);
			-- Calcul du tooltip
			local Message="ID n° "..ID;
			Message = Message.."\n{v}< "..TRP2_LOC_CREADATE.." : {o}"..TRP2_GetWithDefaut(PackagesTab,"DateCreation",date("%d/%m/%y à %H:%M:%S")).."{v} >";
			Message = Message.."\n{v}< "..TRP2_LOC_LASTDATE.." : {o}"..TRP2_GetWithDefaut(PackagesTab,"Date",date("%d/%m/%y à %H:%M:%S")).."{v} >";
			Message = Message.."\n{v}"..TRP2_LOC_CreaNbr.." : {w}"..TRP2_GetIndexedTabSize(PackagesTab["Objects"]);
		
			Message = Message.."\n\n{j}"..TRP2_LOC_CLIC.." {w}: "..TRP2_LOC_OPENPACK;
			Message = Message.."\n{j}"..TRP2_LOC_CLICDROIT.." {w}: "..TRP2_LOC_DELETEPACK;
			Message = Message.."\n{j}"..TRP2_LOC_CLICCTRL.." {w}: "..TRP2_LOC_SendPackage;
			Message = Message.."\n{j}"..TRP2_LOC_CLICDROITCTRL.." {w}: "..TRP2_LOC_AFFICHERSTAT;
			Message = Message.."\n{j}"..TRP2_LOC_CLICDROITMAJ.." {w}: "..TRP2_LOC_EXPORTPAKINPAK;
			TRP2_SetTooltipForFrame(
				getglobal("TRP2_CreationFrameBaseListePackagesSlot"..j),
				TRP2_CreationFrameBase,"TOPLEFT",262,-515,
				"{w}{icone:INV_Misc_Gift_05:30} "..TRP2_GetWithDefaut(PackagesTab,"Nom",TRP2_LOC_PACKAGE),
				Message
			);
			j = j + 1;
		end
		i = i + 1;
	end;
end

--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- Gestion d'un package
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

function TRP2_OpenPackage(ID)
	local PackagesTab = TRP2_GetPlayerPackages()[ID];
	TRP2_ListerPackage(ID);
	TRP2_OpenedPackage:Show();
	TRP2_OpenedPackageTitre:SetText(TRP2_CTS("|TInterface\\ICONS\\INV_Misc_Gift_03:25:25|t {w}"..TRP2_GetWithDefaut(PackagesTab,"Nom",TRP2_LOC_PACKAGE).." |TInterface\\ICONS\\INV_Misc_Gift_03:25:25|t"));
end

function TRP2_AddObjectToPackage(ID, notFirstTime)
	ResetCursor();
	if string.len(ID) ~= TRP2_IDSIZE then
		TRP2_Error(TRP2_LOC_ExporteError1);
		return;
	end
	if TRP2_GetPlayerPackages()[TRP2_OpenedPackage.packageID]["Objects"][ID] == nil then
		TRP2_GetPlayerPackages()[TRP2_OpenedPackage.packageID]["Objects"][ID] = true;
		TRP2_OpenPackage(TRP2_OpenedPackage.packageID);
		TRP2_ListerPackages();
		-- Check references
		local refTab = TRP2_FindIDInStream(TRP2_Libs:Serialize(TRP2_GetTabInfo(ID)));
		local cyclingFunction = function()
			for creaID,_ in pairs(refTab) do
				TRP2_AddObjectToPackage(creaID, true);
			end
		end;
		if TRP2_GetIndexedTabSize(refTab) > 0 then
			if not notFirstTime then -- Si c'est la première fois, on demande gentillement
				StaticPopupDialogs["TRP2_CONFIRM_ACTION_NS"].text = TRP2_CTS(TRP2_ENTETE.."\n"..TRP2_LOC_ADDCHAINPACK);
				TRP2_ShowStaticPopup("TRP2_CONFIRM_ACTION_NS",nil,cyclingFunction);
			else
				cyclingFunction();
			end
		end
	end
end

function TRP2_ProcessPackageStats(packageID)
	local packageTab = TRP2_GetPlayerPackages()[packageID];
	local size = 0;
	local itemNbr = TRP2_GetIndexedTabSize(packageTab["Objects"]);
	local messNum = 0;
	local temps = 0;
	
	for creaID,_ in pairs(packageTab["Objects"]) do
		size = size + string.len(TRP2_Libs:Serialize(TRP2_GetTabInfo(creaID)));
	end
	messNum = math.ceil(size/221);
	temps = math.ceil((messNum - 4)/3.14);
	local message = TRP2_FT(TRP2_LOC_PACKSTATS,
		TRP2_GetWithDefaut(packageTab,"Nom",TRP2_LOC_PACKAGE),
		itemNbr,
		TRP2_OctetstoString(size),
		messNum,
		TRP2_StringToMinutes(temps)
	);
	StaticPopupDialogs["TRP2_JUST_TEXT"].text = TRP2_CTS(TRP2_ENTETE..message);
	TRP2_ShowStaticPopup("TRP2_JUST_TEXT");
end

function TRP2_StringToMinutes(secondes)
	local minutes = math.floor(secondes/60);
	local secondesRestantes = math.fmod(secondes,60);
	if minutes == 0 then
		return secondesRestantes.." sec";
	end
	return minutes.." min "..secondesRestantes.." sec";
end

TRP2_CreaListTabPackageElement = {};

function TRP2_ListerPackage(packageID)
	local j = 0; -- Nombre total
	TRP2_OpenedPackageSlider:Hide();
	TRP2_OpenedPackageSlider:SetValue(0);
	wipe(TRP2_CreaListTabPackageElement);
	TRP2_OpenedPackage.packageID = packageID;
	
	for elementID,_ in pairs(TRP2_GetPlayerPackages()[packageID]["Objects"]) do
		j = j + 1;
		TRP2_CreaListTabPackageElement[elementID] = true;
	end
	
	table.sort(TRP2_CreaListTabPackageElement);

	if j > 0 then
		TRP2_OpenedPackageEmpty:SetText("");
	else
		TRP2_OpenedPackageEmpty:SetText(TRP2_LOC_PackEmpty);
	end
	if j > 49 then
		TRP2_OpenedPackageSlider:Show();
		local total = floor((j-1)/49);
		TRP2_OpenedPackageSlider:SetMinMaxValues(0,total);
	end
	TRP2_OpenedPackageSlider:SetScript("OnValueChanged",function(self)
		if self:IsVisible() then
			TRP2_ListerPackagePage(self:GetValue());
		end
	end)
	TRP2_ListerPackagePage(0);
end

function TRP2_ListerPackagePage(num)
	for k=1,49,1 do --Initialisation
		getglobal("TRP2_OpenedPackageSlot"..k):Hide();
	end
	local i = 1;
	local j = 1;
	for elementID,_ in pairs(TRP2_CreaListTabPackageElement) do
		if i > num*49 and i <= (num+1)*49 then
			local elementTab = TRP2_GetTabInfo(elementID);
			getglobal("TRP2_OpenedPackageSlot"..j):Show();
			getglobal("TRP2_OpenedPackageSlot"..j.."Icon"):SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(elementTab,"Icone","Temp"));
			getglobal("TRP2_OpenedPackageSlot"..j):SetScript("OnClick", function(self,button)
				TRP2_GetPlayerPackages()[TRP2_OpenedPackage.packageID]["Objects"][elementID] = nil;
				TRP2_ListerPackage(TRP2_OpenedPackage.packageID);
				TRP2_ListerPackages();
			end);
			-- Calcul du tooltip
			local Titre,Message = TRP2_ExportImportTooltip(elementID,elementTab);
			TRP2_SetTooltipForFrame(
				_G["TRP2_OpenedPackageSlot"..j],
				_G["TRP2_OpenedPackageSlot"..j],"TOPLEFT",0,0,
				Titre,
				Message.."\n{j}"..TRP2_LOC_CLIC.." : {w}"..TRP2_LOC_PackRemoveFrom
			);
			j = j + 1;
		end
		i = i + 1;
	end;
end