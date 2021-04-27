-------------------------------------------------------------------
--                          Total RP 2
--            A roleplay addon for World of Warcraft
-- Created by Sylvain "Telkostrasz" Cossement (up to version 1.017)
--   Licence : CC BY-NC-SA (http://creativecommons.org/licenses/)
-------------------------------------------------------------------

--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- CREATION DOCUMENT
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

TRP2_DOCUMENTAPERCU = {
	["Icone"] = "Ability_Warrior_Revenge";
	["Page001"] = {};
};

function TRP2_DD_CreaStringFont(frame,level,menuList)
	UIDropDownMenu_SetWidth(frame, 50);
	UIDropDownMenu_SetButtonWidth(frame, 15);
	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_LOC_DOC_Font;
	info.func = function() end;
	info.isTitle = true;
	UIDropDownMenu_AddButton(info);
	local i;
	for i=1,#TRP2_DocumentFont - 1,2 do
		info = TRP2_CreateSimpleDDButton();
		if TRP2_CreationFrameDocumentFrameStringFont.Valeur == i then
			info.text = TRP2_CTS(TRP2_DocumentFont[i]);
			info.checked = true;
			info.disabled = true;
		else
			info.text = TRP2_CTS(TRP2_DocumentFont[i]);
		end
		info.func = function()
			TRP2_CreationFrameDocumentFrameStringFont.Valeur = i;
			TRP2_CreationFrameDocumentFrameStringFontValeur:SetText(TRP2_CTS(TRP2_DocumentFont[i]));
			
		end;
		UIDropDownMenu_AddButton(info,level);
	end

	info = TRP2_CreateSimpleDDButton();
	info.text = CANCEL;
	UIDropDownMenu_AddButton(info,level);
end

function TRP2_DD_CreaStringVertical(frame,level,menuList)
	UIDropDownMenu_SetWidth(frame, 50);
	UIDropDownMenu_SetButtonWidth(frame, 15);
	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_LOC_DOC_VALIGN;
	info.func = function() end;
	info.isTitle = true;
	UIDropDownMenu_AddButton(info);

	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_CTS(TRP2_LOC_DOC_VALIGN1);
	if TRP2_CreationFrameDocumentFrameStringAlignV.Valeur == "TOP" then
		info.checked = true;
		info.disabled = true;
	end
	info.func = function()
		TRP2_CreationFrameDocumentFrameStringAlignV.Valeur = "TOP";
		TRP2_CreationFrameDocumentFrameStringAlignVValeur:SetText(TRP2_CTS(TRP2_LOC_DOC_VALIGN1));
		
	end;
	UIDropDownMenu_AddButton(info,level);
	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_CTS(TRP2_LOC_DOC_VALIGN2);
	if TRP2_CreationFrameDocumentFrameStringAlignV.Valeur == "MIDDLE" then
		info.checked = true;
		info.disabled = true;
	end
	info.func = function()
		TRP2_CreationFrameDocumentFrameStringAlignV.Valeur = "MIDDLE";
		TRP2_CreationFrameDocumentFrameStringAlignVValeur:SetText(TRP2_CTS(TRP2_LOC_DOC_VALIGN2));
		
	end;
	UIDropDownMenu_AddButton(info,level);
	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_CTS(TRP2_LOC_DOC_VALIGN3);
	if TRP2_CreationFrameDocumentFrameStringAlignV.Valeur == "BOTTOM" then
		info.checked = true;
		info.disabled = true;
	end
	info.func = function()
		TRP2_CreationFrameDocumentFrameStringAlignV.Valeur = "BOTTOM";
		TRP2_CreationFrameDocumentFrameStringAlignVValeur:SetText(TRP2_CTS(TRP2_LOC_DOC_VALIGN3));
		
	end;
	UIDropDownMenu_AddButton(info,level);
	info = TRP2_CreateSimpleDDButton();
	info.text = CANCEL;
	UIDropDownMenu_AddButton(info,level);
end

function TRP2_DD_CreaStringHorizontal(frame,level,menuList)
	UIDropDownMenu_SetWidth(frame, 50);
	UIDropDownMenu_SetButtonWidth(frame, 15);
	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_LOC_DOC_HALIGN;
	info.func = function() end;
	info.isTitle = true;
	UIDropDownMenu_AddButton(info);

	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_CTS(TRP2_LOC_DOC_HALIGN1);
	if TRP2_CreationFrameDocumentFrameStringAlignH.Valeur == "LEFT" then
		info.checked = true;
		info.disabled = true;
	end
	info.func = function()
		TRP2_CreationFrameDocumentFrameStringAlignH.Valeur = "LEFT";
		TRP2_CreationFrameDocumentFrameStringAlignHValeur:SetText(TRP2_CTS(TRP2_LOC_DOC_HALIGN1));
		
	end;
	UIDropDownMenu_AddButton(info,level);
	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_CTS(TRP2_LOC_DOC_HALIGN2);
	if TRP2_CreationFrameDocumentFrameStringAlignH.Valeur == "CENTER" then
		info.checked = true;
		info.disabled = true;
	end
	info.func = function()
		TRP2_CreationFrameDocumentFrameStringAlignH.Valeur = "CENTER";
		TRP2_CreationFrameDocumentFrameStringAlignHValeur:SetText(TRP2_CTS(TRP2_LOC_DOC_HALIGN2));
		
	end;
	UIDropDownMenu_AddButton(info,level);
	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_CTS(TRP2_LOC_DOC_HALIGN3);
	if TRP2_CreationFrameDocumentFrameStringAlignH.Valeur == "RIGHT" then
		info.checked = true;
		info.disabled = true;
	end
	info.func = function()
		TRP2_CreationFrameDocumentFrameStringAlignH.Valeur = "RIGHT";
		TRP2_CreationFrameDocumentFrameStringAlignHValeur:SetText(TRP2_CTS(TRP2_LOC_DOC_HALIGN3));
		
	end;
	UIDropDownMenu_AddButton(info,level);
	info = TRP2_CreateSimpleDDButton();
	info.text = CANCEL;
	UIDropDownMenu_AddButton(info,level);
end

function TRP2_DD_CreaImageDegrad(frame,level,menuList)
	UIDropDownMenu_SetWidth(frame, 50);
	UIDropDownMenu_SetButtonWidth(frame, 15);
	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_LOC_DOC_DALIGN;
	info.func = function() end;
	info.isTitle = true;
	UIDropDownMenu_AddButton(info);

	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_CTS("Horizontal");
	if TRP2_CreationFrameDocumentFrameImageAlignement.Valeur == "HORIZONTAL" then
		info.checked = true;
		info.disabled = true;
	end
	info.func = function()
		TRP2_CreationFrameDocumentFrameImageAlignement.Valeur = "HORIZONTAL";
		TRP2_CreationFrameDocumentFrameImageAlignementValeur:SetText(TRP2_CTS("Horizontal"));
		TRP2_CreationFrameDocumentFrameImageSave:Enable();
	end;
	UIDropDownMenu_AddButton(info,level);
	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_CTS("Vertical");
	if TRP2_CreationFrameDocumentFrameImageAlignement.Valeur == "VERTICAL" then
		info.checked = true;
		info.disabled = true;
	end
	info.func = function()
		TRP2_CreationFrameDocumentFrameImageAlignement.Valeur = "VERTICAL";
		TRP2_CreationFrameDocumentFrameImageAlignementValeur:SetText(TRP2_CTS("Vertical"));
		TRP2_CreationFrameDocumentFrameImageSave:Enable();
	end;
	UIDropDownMenu_AddButton(info,level);

	info = TRP2_CreateSimpleDDButton();
	info.text = CANCEL;
	UIDropDownMenu_AddButton(info,level);
end

function TRP2_CreaDocuChargerPage(Page)
	TRP2_CreationFrameDocumentFramePageMainTitle:SetText(TRP2_CTS(TRP2_LOC_DOC_EDITPAGE..string.match(Page,"%d+")));
	TRP2_CreationFrameDocument.Page = Page;
	
	--  Copie des éléments dans le tableau d'elements
	if TRP2_CreationFrameDocument.PageContenuTab then
		wipe(TRP2_CreationFrameDocument.PageContenuTab);
	else
		TRP2_CreationFrameDocument.PageContenuTab = {};
	end
	if TRP2_CreationFrameDocument.PageTab[Page] then
		for key,value in pairs(TRP2_CreationFrameDocument.PageTab[Page]) do
			if string.match(key,"Image%d+") == key or string.match(key,"String%d+") == key then -- Variable de page
				TRP2_CreationFrameDocument.PageContenuTab[key] = {};
				TRP2_tcopy(TRP2_CreationFrameDocument.PageContenuTab[key],value);
			end
		end
	else
		TRP2_CreationFrameDocument.PageTab[Page] = {};
		TRP2_ListerPageDocument();
	end
	-- Chargement du texte
	TRP2_CreationFrameDocumentFramePageMainTexteScrollEditBox:SetScript("OnTextChanged",function(self)
		self:SetText(string.gsub(self:GetText(),"[%#%~%µ%$%@]",""));
		if TRP2_EmptyToNil(self:GetText()) ~= TRP2_EmptyToNil(TRP2_GetWithDefaut(TRP2_CreationFrameDocument.PageTab[Page],"Texte","")) then
			
		end
		if self:IsVisible() and self:GetCursorPosition() == string.len(self:GetText()) then
			self:GetParent():SetVerticalScroll(self:GetParent():GetVerticalScrollRange());
		end
	end);
	TRP2_CreationFrameDocumentFramePageMainTexteScrollEditBox:SetText(TRP2_GetWithDefaut(TRP2_CreationFrameDocument.PageTab[Page],"Texte",""));
	-- Setting de l'enregistrement futur
	TRP2_CreationFrameDocumentFramePageMainSave:SetScript("OnClick",function()
		if TRP2_CreationFrameDocument.PageTab[Page] then
			wipe(TRP2_CreationFrameDocument.PageTab[Page]);
		else
			TRP2_CreationFrameDocument.PageTab[Page] = {};
		end
		TRP2_CreationFrameDocument.PageTab[Page]["Texte"] = TRP2_EmptyToNil(TRP2_CreationFrameDocumentFramePageMainTexteScrollEditBox:GetText());
		for key,value in pairs(TRP2_CreationFrameDocument.PageContenuTab) do
			TRP2_CreationFrameDocument.PageTab[Page][key] = {};
			TRP2_tcopy(TRP2_CreationFrameDocument.PageTab[Page][key],value);
		end
		TRP2_ListerPageDocument();
		if TRP2_CreationFrameDocumentFrameMenuSave.Can ~= false then 
			TRP2_CreationFrameDocumentFrameMenuSave:Enable();
		end
	end);
	
	TRP2_CreationFrameDocumentFramePageMainListeElemAjout:SetScript("OnClick",function(self,button)
		if button == "LeftButton" then
			local ID = TRP2_FoundFreePlace(TRP2_CreationFrameDocument.PageContenuTab,"Image",3);
			TRP2_CreaDocuChargerImage("Image"..ID,string.match(ID,"Image(%d+)"));
		else
			local ID = TRP2_FoundFreePlace(TRP2_CreationFrameDocument.PageContenuTab,"String",3);
			TRP2_CreaDocuChargerString("String"..ID,string.match(ID,"String(%d+)"));
		end
	end);
	
	TRP2_ListerPageContenu();
	TRP2_CreationFrameDocumentFramePageMain:Show();
	TRP2_CreationFrameDocumentFrameImage:Hide();
	TRP2_CreationFrameDocumentFrameString:Hide();
end

function TRP2_ListerPageContenu()
	local i = 0; -- Nombre total
	local j = 0; -- Nombre pris
	local search = TRP2_EmptyToNil(TRP2_CreationFrameDocumentFramePageMainListeElemRecherche:GetText());
	TRP2_CreationFrameDocumentFramePageMainListeElemSlider:Hide();
	TRP2_CreationFrameDocumentFramePageMainListeElemSlider:SetValue(0);
	wipe(TRP2_CreaListTabLang);
	
	table.foreach(TRP2_CreationFrameDocument.PageContenuTab,function(Num)
		i = i+1;
		if not search or TRP2_ApplyPattern(Num,search) then
			j = j + 1;
			TRP2_CreaListTabLang[j] = Num;
		end
	end);
	
	table.sort(TRP2_CreaListTabLang);

	if j > 0 then
		TRP2_CreationFrameDocumentFramePageMainListeElemEmpty:SetText("");
	elseif i == 0 then
		TRP2_CreationFrameDocumentFramePageMainListeElemEmpty:SetText(TRP2_LOC_DOC_NOELEM);
	else
		TRP2_CreationFrameDocumentFramePageMainListeElemEmpty:SetText(TRP2_LOC_SelectVide);
	end
	if j > 49 then
		TRP2_CreationFrameDocumentFramePageMainListeElemSlider:Show();
		local total = floor((j-1)/49);
		TRP2_CreationFrameDocumentFramePageMainListeElemSlider:SetMinMaxValues(0,total);
	end
	TRP2_CreationFrameDocumentFramePageMainListeElemSlider:SetScript("OnValueChanged",function(self)
		if self:IsVisible() then
			TRP2_ListerPageContenuPage(self:GetValue());
		end
	end)
	TRP2_CreationFrameDocumentFramePageMainListeElemRecherche:SetScript("OnTextChanged",function(self)
		if self:IsVisible() then
			TRP2_ListerPageContenu();
		end
	end)
	TRP2_ListerPageContenuPage(0);
end

function TRP2_ListerPageContenuPage(num)
	for k=1,49,1 do --Initialisation
		getglobal("TRP2_CreationFrameDocumentFramePageMainListeElemSlot"..k):Hide();
	end
	local i = 1;
	local j = 1;
	table.foreach(TRP2_CreaListTabLang,
	function(TabIndex)
		if i > num*49 and i <= (num+1)*49 then
			local ID = TRP2_CreaListTabLang[TabIndex];
			getglobal("TRP2_CreationFrameDocumentFramePageMainListeElemSlot"..j):Show();
			if string.match(ID,"Image%d+") == ID then
				getglobal("TRP2_CreationFrameDocumentFramePageMainListeElemSlot"..j.."Icon"):SetTexture("Interface\\ICONS\\INV_Inscription_TarotChaos");
			else
				getglobal("TRP2_CreationFrameDocumentFramePageMainListeElemSlot"..j.."Icon"):SetTexture("Interface\\ICONS\\INV_Inscription_TradeSkill01");
			end
			getglobal("TRP2_CreationFrameDocumentFramePageMainListeElemSlot"..j):SetScript("OnClick", function(self,button)
				if button == "LeftButton" then
					local funct = function()
						if string.match(ID,"Image%d+") == ID then
							if IsControlKeyDown() then
								local newID = "Image"..TRP2_FoundFreePlace(TRP2_CreationFrameDocument.PageContenuTab,"Image",3);
								TRP2_CreationFrameDocument.PageContenuTab[newID] = {};
								TRP2_tcopy(TRP2_CreationFrameDocument.PageContenuTab[newID],TRP2_CreationFrameDocument.PageContenuTab[ID]);
								--TRP2_CreaDocuChargerImage(newID,string.match(newID,"Image(%d+)"));
								TRP2_ListerPageContenu();
								
							else
								TRP2_CreaDocuChargerImage(ID,string.match(ID,"Image(%d+)"));
							end
						elseif string.match(ID,"String%d+") == ID then
							if IsControlKeyDown() then
								local newID = "String"..TRP2_FoundFreePlace(TRP2_CreationFrameDocument.PageContenuTab,"String",3);
								TRP2_CreationFrameDocument.PageContenuTab[newID] = {};
								TRP2_tcopy(TRP2_CreationFrameDocument.PageContenuTab[newID],TRP2_CreationFrameDocument.PageContenuTab[ID]);
								--TRP2_CreaDocuChargerImage(newID,string.match(newID,"String(%d+)"));
								TRP2_ListerPageContenu();
								
							else
								TRP2_CreaDocuChargerString(ID,string.match(ID,"String(%d+)"));
							end
						end
					end
					funct();
				else
					StaticPopupDialogs["TRP2_CONFIRM_ACTION_NS"].text = TRP2_CTS(TRP2_FT(TRP2_ENTETE..TRP2_LOC_DOC_DELELEM,ID));
					TRP2_ShowStaticPopup("TRP2_CONFIRM_ACTION_NS",nil,function()
						wipe(TRP2_CreationFrameDocument.PageContenuTab[ID]);
						TRP2_CreationFrameDocument.PageContenuTab[ID] = nil;
						TRP2_ListerPageContenu();
						
					end);
				end
			end);
			local Titre;
			local Suite;
			if string.match(ID,"Image%d+") == ID then
				Titre = "{w}{icone:INV_Inscription_TarotChaos:35} "..TRP2_LOC_DOC_IMAGE.." n°"..string.match(ID,"%d+");
				Suite = "{j}"..TRP2_LOC_DOC_IMAGE.." :";
				Suite = Suite.."\n|T"..TRP2_GetWithDefaut(TRP2_CreationFrameDocument.PageContenuTab[ID],"Url","Interface\\ICONS\\Temp")..":"..TRP2_GetWithDefaut(TRP2_CreationFrameDocument.PageContenuTab[ID],"DimY",100)..":"..TRP2_GetWithDefaut(TRP2_CreationFrameDocument.PageContenuTab[ID],"DimX",100).."|t\n";
				Suite = Suite.."{v}"..TRP2_GetWithDefaut(TRP2_CreationFrameDocument.PageContenuTab[ID],"Url","Interface\\ICONS\\Temp").."\n\n";
				Suite = Suite.."{j}"..TRP2_LOC_CLIC.." : {w}"..TRP2_LOC_DOC_IMAGEEDIT.."\n{j}"..TRP2_LOC_CLICDROIT.." : {w}"..TRP2_LOC_DOC_IMAGEDEL;
				Suite = Suite.."\n{j}"..TRP2_LOC_CLICCTRL.." : {w}"..TRP2_LOC_DOC_IMAGECOPY;
				Suite = Suite.."\n\n"..TRP2_LOC_DOWUWARNELEM;
				TRP2_SetTooltipForFrame(
					getglobal("TRP2_CreationFrameDocumentFramePageMainListeElemSlot"..j),
					getglobal("TRP2_CreationFrameDocumentFramePageMainListeElemSlot"..j),"TOPLEFT",0,0,
					Titre,Suite
				);
			elseif string.match(ID,"String%d+") == ID then
				Titre = "{w}{icone:INV_Inscription_TradeSkill01:35} "..TRP2_LOC_DOC_TEXTE.." n°"..string.match(ID,"%d+");
				Suite = "{j}"..TRP2_LOC_DOC_TEXTE.." :\n{o}\""..TRP2_GetWithDefaut(TRP2_CreationFrameDocument.PageContenuTab[ID],"Texte","("..TRP2_LOC_DOC_NOTEXTE..")").."{o}\"\n\n";
				Suite = Suite.."{j}"..TRP2_LOC_CLIC.." : {w}"..TRP2_LOC_DOC_TEXTEEDIT.."\n{j}"..TRP2_LOC_CLICDROIT.." : {w}"..TRP2_LOC_DOC_TEXTEDEL;
				Suite = Suite.."\n{j}"..TRP2_LOC_CLICCTRL.." : {w}"..TRP2_LOC_DOC_TEXTECOPY;
				Suite = Suite.."\n\n"..TRP2_LOC_DOWUWARNELEM;
				TRP2_SetTooltipForFrame(
					getglobal("TRP2_CreationFrameDocumentFramePageMainListeElemSlot"..j),
					getglobal("TRP2_CreationFrameDocumentFramePageMainListeElemSlot"..j),"TOPLEFT",0,0,
					Titre,Suite
				);
			end
			j = j + 1;
		end
		i = i + 1;
	end);
end

function TRP2_ListerPageDocument()
	local i = 0; -- Nombre total
	local j = 0; -- Nombre pris
	local search = TRP2_EmptyToNil(TRP2_CreationFrameDocumentFrameListePageRecherche:GetText());
	TRP2_CreationFrameDocumentFrameListePageSlider:Hide();
	TRP2_CreationFrameDocumentFrameListePageSlider:SetValue(0);
	wipe(TRP2_CreaListTabEvent);
	
	table.foreach(TRP2_CreationFrameDocument.PageTab,function(Num)
		i = i+1;
		if not search or TRP2_ApplyPattern(Num,search) then
			j = j + 1;
			TRP2_CreaListTabEvent[j] = Num;
		end
	end);
	
	table.sort(TRP2_CreaListTabEvent);

	if j > 0 then
		TRP2_CreationFrameDocumentFrameListePageEmpty:SetText("");
	elseif i == 0 then
		TRP2_CreationFrameDocumentFrameListePageEmpty:SetText(TRP2_LOC_DOC_NOPAGE);
	else
		TRP2_CreationFrameDocumentFrameListePageEmpty:SetText(TRP2_LOC_SelectVide);
	end
	if j > 49 then
		TRP2_CreationFrameDocumentFrameListePageSlider:Show();
		local total = floor((j-1)/49);
		TRP2_CreationFrameDocumentFrameListePageSlider:SetMinMaxValues(0,total);
	end
	TRP2_CreationFrameDocumentFrameListePageSlider:SetScript("OnValueChanged",function(self)
		if self:IsVisible() then
			TRP2_ListerPageDocumentPage(self:GetValue());
		end
	end)
	TRP2_CreationFrameDocumentFrameListePageRecherche:SetScript("OnTextChanged",function(self)
		if self:IsVisible() then
			TRP2_ListerPageDocument();
		end
	end)
	TRP2_ListerPageDocumentPage(0);
end

function TRP2_ListerPageDocumentPage(num)
	for k=1,49,1 do --Initialisation
		getglobal("TRP2_CreationFrameDocumentFrameListePageSlot"..k):Hide();
	end
	local i = 1;
	local j = 1;
	table.foreach(TRP2_CreaListTabEvent,
	function(TabIndex)
		if i > num*49 and i <= (num+1)*49 then
			local ID = TRP2_CreaListTabEvent[TabIndex];
			getglobal("TRP2_CreationFrameDocumentFrameListePageSlot"..j):Show();
			getglobal("TRP2_CreationFrameDocumentFrameListePageSlot"..j.."Icon"):SetTexture("Interface\\ICONS\\INV_Inscription_Scroll");
			getglobal("TRP2_CreationFrameDocumentFrameListePageSlot"..j):SetScript("OnClick", function(self,button)
				if button == "LeftButton" then
					if IsControlKeyDown() then
						local newID = "Page"..TRP2_FoundFreePlace(TRP2_CreationFrameDocument.PageTab,"Page",3);
						TRP2_CreationFrameDocument.PageTab[newID] = {};
						TRP2_tcopy(TRP2_CreationFrameDocument.PageTab[newID],TRP2_CreationFrameDocument.PageTab[ID]);
						TRP2_ListerPageDocument();
						TRP2_CreationFrameDocumentFrameMenuSave:Enable();
					else
						TRP2_CreaDocuChargerPage(ID);
					end
				else
					StaticPopupDialogs["TRP2_CONFIRM_ACTION_NS"].text = TRP2_CTS(TRP2_FT(TRP2_ENTETE.."Supprimer la page %1 ?",ID));
					TRP2_ShowStaticPopup("TRP2_CONFIRM_ACTION_NS",nil,function()
						wipe(TRP2_CreationFrameDocument.PageTab[ID]);
						TRP2_CreationFrameDocument.PageTab[ID] = nil;
						TRP2_ListerPageDocument();
						TRP2_CreationFrameDocumentFrameMenuSave:Enable();
						if TRP2_CreationFrameDocument.Page == ID then
							TRP2_CreationFrameDocumentFramePageMain:Hide();
						end
					end);
				end
			end);
			local Titre = "{w}{icone:INV_Inscription_Papyrus:35} "..TRP2_LOC_DOC_PAGE.." n°"..string.match(ID,"Page(%d+)");
			local Suite = "{j}"..TRP2_LOC_DOC_PAGEAPER.." :\n\"{w}"..string.sub(string.gsub(TRP2_GetWithDefaut(TRP2_CreationFrameDocument.PageTab[ID],"Texte","("..TRP2_LOC_DOC_NOTEXTE..")"),"\n+","\n"),1,250).."{j}\"\n\n";
			Suite = Suite.."{j}"..TRP2_LOC_CLIC.." : {w}"..TRP2_LOC_DOC_PAGEEDIT.."\n{j}"..TRP2_LOC_CLICDROIT.." : {w}"..TRP2_LOC_DOC_PAGEDEL;
			Suite = Suite.."\n{j}"..TRP2_LOC_CLICCTRL.." : {w}"..TRP2_LOC_DOC_PAGECOPY;
			Suite = Suite.."\n\n"..TRP2_LOC_DOWUWARNPAGE;
			-- Calcul du tooltip
			TRP2_SetTooltipForFrame(
				getglobal("TRP2_CreationFrameDocumentFrameListePageSlot"..j),
				getglobal("TRP2_CreationFrameDocumentFrameListePageSlot"..j),"TOPLEFT",0,0,
				Titre,
				Suite
			);
			j = j + 1;
		end
		i = i + 1;
	end);
end

function TRP2_CreaDocuChargerString(Elem,num)
	if not TRP2_CreationFrameDocument.PageContenuTab[Elem] then
		TRP2_CreationFrameDocument.PageContenuTab[Elem] = {};
		TRP2_ListerPageContenu();
	end
	local tab = TRP2_CreationFrameDocument.PageContenuTab[Elem];
	TRP2_CreationFrameDocument.ActualElem = Elem;
	TRP2_CreationFrameDocumentFrameStringSave:SetScript("OnClick",function()
		if TRP2_CreationFrameDocument.PageContenuTab[Elem] then
			wipe(TRP2_CreationFrameDocument.PageContenuTab[Elem]);
		else
			TRP2_CreationFrameDocument.PageContenuTab[Elem] = {};
		end
		TRP2_CreationFrameDocument.PageContenuTab[Elem] = TRP2_CreaDocuCreateTabString();
		TRP2_ListerPageContenu();
	end);
	
	TRP2_SetFrameSaveButton(TRP2_CreationFrameDocumentFrameStringLevel,TRP2_GetWithDefaut(tab,"Level",1),TRP2_CreationFrameDocumentFrameStringSave);
	TRP2_SetFrameSaveButton(TRP2_CreationFrameDocumentFrameStringDimX,TRP2_GetWithDefaut(tab,"DimX",0),TRP2_CreationFrameDocumentFrameStringSave);
	TRP2_SetFrameSaveButton(TRP2_CreationFrameDocumentFrameStringDimY,TRP2_GetWithDefaut(tab,"DimY",0),TRP2_CreationFrameDocumentFrameStringSave);
	TRP2_SetFrameSaveButton(TRP2_CreationFrameDocumentFrameStringPosX,TRP2_GetWithDefaut(tab,"PosX",0),TRP2_CreationFrameDocumentFrameStringSave);
	TRP2_SetFrameSaveButton(TRP2_CreationFrameDocumentFrameStringPosY,TRP2_GetWithDefaut(tab,"PosY",0),TRP2_CreationFrameDocumentFrameStringSave);
	TRP2_SetFrameSaveButton(TRP2_CreationFrameDocumentFrameStringTaille,TRP2_GetWithDefaut(tab,"Taille",12),TRP2_CreationFrameDocumentFrameStringSave);
	TRP2_SetFrameSaveButton(TRP2_CreationFrameDocumentFrameStringTexteScrollEditBox,TRP2_GetWithDefaut(tab,"Texte",""),TRP2_CreationFrameDocumentFrameStringSave);
	TRP2_SetFrameSaveButton(TRP2_CreationFrameDocumentFrameStringSpacing,TRP2_GetWithDefaut(tab,"Spacing",0),TRP2_CreationFrameDocumentFrameStringSave);
	TRP2_SetFrameSaveButton(TRP2_CreationFrameDocumentFrameStringShadowX,TRP2_GetWithDefaut(tab,"ShadowX",1),TRP2_CreationFrameDocumentFrameStringSave);
	TRP2_SetFrameSaveButton(TRP2_CreationFrameDocumentFrameStringShadowY,TRP2_GetWithDefaut(tab,"ShadowY",-1),TRP2_CreationFrameDocumentFrameStringSave);
	TRP2_SetFrameSaveButton(TRP2_CreationFrameDocumentFrameStringContours,nil,TRP2_CreationFrameDocumentFrameStringSave);
	
	TRP2_CreationFrameDocumentFrameStringTitle:SetText(TRP2_CTS(TRP2_FT(TRP2_LOC_DOC_TEXTEEDIT.." n°%1",string.match(Elem,"%d+"))));
	TRP2_CreationFrameDocumentFrameStringLevel:SetText(TRP2_GetWithDefaut(tab,"Level",1));
	TRP2_CreationFrameDocumentFrameStringDimX:SetText(TRP2_GetWithDefaut(tab,"DimX",0));
	TRP2_CreationFrameDocumentFrameStringDimY:SetText(TRP2_GetWithDefaut(tab,"DimY",0));
	TRP2_CreationFrameDocumentFrameStringPosX:SetText(TRP2_GetWithDefaut(tab,"PosX",0));
	TRP2_CreationFrameDocumentFrameStringPosY:SetText(TRP2_GetWithDefaut(tab,"PosY",0));
	TRP2_CreationFrameDocumentFrameStringTaille:SetText(TRP2_GetWithDefaut(tab,"Taille",12));
	TRP2_CreationFrameDocumentFrameStringTexteScrollEditBox:SetText(TRP2_GetWithDefaut(tab,"Texte",""));
	TRP2_CreationFrameDocumentFrameStringSpacing:SetText(TRP2_GetWithDefaut(tab,"Spacing",0));
	TRP2_CreationFrameDocumentFrameStringShadowX:SetText(TRP2_GetWithDefaut(tab,"ShadowX",1));
	TRP2_CreationFrameDocumentFrameStringShadowY:SetText(TRP2_GetWithDefaut(tab,"ShadowY",-1));
	TRP2_CreationFrameDocumentFrameStringFont.Valeur = TRP2_GetWithDefaut(tab,"Font",1);
	TRP2_CreationFrameDocumentFrameStringFontValeur:SetText(TRP2_CTS(TRP2_DocumentFont[TRP2_CreationFrameDocumentFrameStringFont.Valeur]));
	TRP2_CreationFrameDocumentFrameStringAlignV.Valeur = TRP2_GetWithDefaut(tab,"AlignV","MIDDLE");
	TRP2_CreationFrameDocumentFrameStringAlignVValeur:SetText(TRP2_CTS(_G["TRP2_LOC_ALIGNV"..TRP2_CreationFrameDocumentFrameStringAlignV.Valeur]));
	TRP2_CreationFrameDocumentFrameStringAlignH.Valeur = TRP2_GetWithDefaut(tab,"AlignH","CENTER");
	TRP2_CreationFrameDocumentFrameStringAlignHValeur:SetText(TRP2_CTS(_G["TRP2_LOC_ALIGNH"..TRP2_CreationFrameDocumentFrameStringAlignH.Valeur]));
	TRP2_CreationFrameDocumentFrameStringContours:SetChecked(TRP2_GetWithDefaut(tab,"bContours",0));
	TRP2_CreationFrameDocumentFrameStringColor.R = TRP2_GetWithDefaut(tab,"R",1);
	TRP2_CreationFrameDocumentFrameStringColor.G = TRP2_GetWithDefaut(tab,"G",1);
	TRP2_CreationFrameDocumentFrameStringColor.B = TRP2_GetWithDefaut(tab,"B",1);
	TRP2_CreationFrameDocumentFrameStringColor.A = TRP2_GetWithDefaut(tab,"A",1);
	local couleurHexa = TRP2_ColorToHexa(TRP2_CreationFrameDocumentFrameStringColor.R,TRP2_CreationFrameDocumentFrameStringColor.G,TRP2_CreationFrameDocumentFrameStringColor.B);
	TRP2_CreationFrameDocumentFrameStringColor:SetText(TRP2_CTS(couleurHexa..TRP2_LOC_Couleur));
	TRP2_CreationFrameDocumentFrameStringShadowColor.R = TRP2_GetWithDefaut(tab,"ShadowR",0);
	TRP2_CreationFrameDocumentFrameStringShadowColor.G = TRP2_GetWithDefaut(tab,"ShadowG",0);
	TRP2_CreationFrameDocumentFrameStringShadowColor.B = TRP2_GetWithDefaut(tab,"ShadowB",0);
	TRP2_CreationFrameDocumentFrameStringShadowColor.A = TRP2_GetWithDefaut(tab,"ShadowA",1);
	couleurHexa = TRP2_ColorToHexa(TRP2_CreationFrameDocumentFrameStringShadowColor.R,TRP2_CreationFrameDocumentFrameStringShadowColor.G,TRP2_CreationFrameDocumentFrameStringShadowColor.B);
	TRP2_CreationFrameDocumentFrameStringShadowColor:SetText(TRP2_CTS(couleurHexa..TRP2_LOC_Ombre));
	
	TRP2_CreationFrameDocumentFrameStringColor:SetScript("OnClick",function(self,button)
		
		if button == "LeftButton" then
			ColorPickerFrame.func = function() 
				TRP2_CreationFrameDocumentFrameStringColor.R,TRP2_CreationFrameDocumentFrameStringColor.G,TRP2_CreationFrameDocumentFrameStringColor.B = ColorPickerFrame:GetColorRGB();
				TRP2_CreationFrameDocumentFrameStringColor.A = OpacitySliderFrame:GetValue();
				local couleurHexa = TRP2_ColorToHexa(TRP2_CreationFrameDocumentFrameStringColor.R,TRP2_CreationFrameDocumentFrameStringColor.G,TRP2_CreationFrameDocumentFrameStringColor.B);
				TRP2_CreationFrameDocumentFrameStringColor:SetText(TRP2_CTS(couleurHexa..TRP2_LOC_Couleur));
			end;
			ColorPickerFrame.opacityFunc = ColorPickerFrame.func;
			local R,G,B,A;
			R = TRP2_CreationFrameDocumentFrameStringColor.R;
			G = TRP2_CreationFrameDocumentFrameStringColor.G;
			B = TRP2_CreationFrameDocumentFrameStringColor.B;
			A = TRP2_CreationFrameDocumentFrameStringColor.A;
			ColorPickerFrame.cancelFunc = function() 
				TRP2_CreationFrameDocumentFrameStringColor.R = R;
				TRP2_CreationFrameDocumentFrameStringColor.G = G;
				TRP2_CreationFrameDocumentFrameStringColor.B = B;
				TRP2_CreationFrameDocumentFrameStringColor.A = A;
				local couleurHexa = TRP2_ColorToHexa(TRP2_CreationFrameDocumentFrameStringColor.R,TRP2_CreationFrameDocumentFrameStringColor.G,TRP2_CreationFrameDocumentFrameStringColor.B);
				TRP2_CreationFrameDocumentFrameStringColor:SetText(TRP2_CTS(couleurHexa..TRP2_LOC_Couleur));
			end;
			ColorPickerFrame:SetColorRGB(TRP2_CreationFrameDocumentFrameStringColor.R,TRP2_CreationFrameDocumentFrameStringColor.G,TRP2_CreationFrameDocumentFrameStringColor.B);
			ColorPickerFrame.opacity = TRP2_CreationFrameDocumentFrameStringColor.A;
			ColorPickerFrame.hasOpacity = true;
			ShowUIPanel(ColorPickerFrame);
		else
			TRP2_CreationFrameDocumentFrameStringColor.R = 1;
			TRP2_CreationFrameDocumentFrameStringColor.G = 1;
			TRP2_CreationFrameDocumentFrameStringColor.B = 1;
			TRP2_CreationFrameDocumentFrameStringColor.A = 1;
			local couleurHexa = TRP2_ColorToHexa(TRP2_CreationFrameDocumentFrameStringColor.R,TRP2_CreationFrameDocumentFrameStringColor.G,TRP2_CreationFrameDocumentFrameStringColor.B);
			TRP2_CreationFrameDocumentFrameStringColor:SetText(TRP2_CTS(couleurHexa..TRP2_LOC_Couleur));
		end
	end);
	TRP2_CreationFrameDocumentFrameStringShadowColor:SetScript("OnClick",function(self,button)
		
		if button == "LeftButton" then
			ColorPickerFrame.func = function() 
				TRP2_CreationFrameDocumentFrameStringShadowColor.R,TRP2_CreationFrameDocumentFrameStringShadowColor.G,TRP2_CreationFrameDocumentFrameStringShadowColor.B = ColorPickerFrame:GetColorRGB();
				TRP2_CreationFrameDocumentFrameStringShadowColor.A = OpacitySliderFrame:GetValue();
				local couleurHexa = TRP2_ColorToHexa(TRP2_CreationFrameDocumentFrameStringShadowColor.R,TRP2_CreationFrameDocumentFrameStringShadowColor.G,TRP2_CreationFrameDocumentFrameStringShadowColor.B);
				TRP2_CreationFrameDocumentFrameStringShadowColor:SetText(TRP2_CTS(couleurHexa..TRP2_LOC_Ombre));
			end;
			ColorPickerFrame.opacityFunc = ColorPickerFrame.func;
			local R,G,B,A;
			R = TRP2_CreationFrameDocumentFrameStringShadowColor.R;
			G = TRP2_CreationFrameDocumentFrameStringShadowColor.G;
			B = TRP2_CreationFrameDocumentFrameStringShadowColor.B;
			A = TRP2_CreationFrameDocumentFrameStringShadowColor.A;
			ColorPickerFrame.cancelFunc = function() 
				TRP2_CreationFrameDocumentFrameStringShadowColor.R = R;
				TRP2_CreationFrameDocumentFrameStringShadowColor.G = G;
				TRP2_CreationFrameDocumentFrameStringShadowColor.B = B;
				TRP2_CreationFrameDocumentFrameStringShadowColor.A = A;
				local couleurHexa = TRP2_ColorToHexa(TRP2_CreationFrameDocumentFrameStringShadowColor.R,TRP2_CreationFrameDocumentFrameStringShadowColor.G,TRP2_CreationFrameDocumentFrameStringShadowColor.B);
				TRP2_CreationFrameDocumentFrameStringShadowColor:SetText(TRP2_CTS(couleurHexa..TRP2_LOC_Ombre));
			end;
			ColorPickerFrame:SetColorRGB(TRP2_CreationFrameDocumentFrameStringShadowColor.R,TRP2_CreationFrameDocumentFrameStringShadowColor.G,TRP2_CreationFrameDocumentFrameStringShadowColor.B);
			ColorPickerFrame.opacity = TRP2_CreationFrameDocumentFrameStringShadowColor.A;
			ColorPickerFrame.hasOpacity = true;
			ShowUIPanel(ColorPickerFrame);
		else
			TRP2_CreationFrameDocumentFrameStringShadowColor.R = 0;
			TRP2_CreationFrameDocumentFrameStringShadowColor.G = 0;
			TRP2_CreationFrameDocumentFrameStringShadowColor.B = 0;
			TRP2_CreationFrameDocumentFrameStringShadowColor.A = 1;
			local couleurHexa = TRP2_ColorToHexa(TRP2_CreationFrameDocumentFrameStringShadowColor.R,TRP2_CreationFrameDocumentFrameStringShadowColor.G,TRP2_CreationFrameDocumentFrameStringShadowColor.B);
			TRP2_CreationFrameDocumentFrameStringShadowColor:SetText(TRP2_CTS(couleurHexa..TRP2_LOC_Ombre));
		end
	end);
	
	TRP2_CreationFrameDocumentFrameImage:Hide();
	TRP2_CreationFrameDocumentFrameString:Show();
end

function TRP2_CreaDocuChargerImage(Elem,num)
	if not TRP2_CreationFrameDocument.PageContenuTab[Elem] then
		TRP2_CreationFrameDocument.PageContenuTab[Elem] = {};
		TRP2_ListerPageContenu();
	end
	local tab = TRP2_CreationFrameDocument.PageContenuTab[Elem];
	TRP2_CreationFrameDocument.ActualElem = Elem;
	TRP2_CreationFrameDocument.ActualString = TRP2_LOC_DOC_IMAGE.." n°"..tostring(num);
	TRP2_CreationFrameDocumentFrameImage:Hide();
	TRP2_CreationFrameDocumentFrameImageSave:SetScript("OnClick",function()
		if TRP2_CreationFrameDocument.PageContenuTab[Elem] then
			wipe(TRP2_CreationFrameDocument.PageContenuTab[Elem]);
		end
		TRP2_CreationFrameDocument.PageContenuTab[Elem] = TRP2_CreaDocuCreateTabImage();
		TRP2_ListerPageContenu();
		
		TRP2_CreaDocuChargerImage(Elem);
	end);
	
	TRP2_SetFrameSaveButton(TRP2_CreationFrameDocumentFrameImageLevel,TRP2_GetWithDefaut(tab,"Level",1),TRP2_CreationFrameDocumentFrameImageSave);
	TRP2_SetFrameSaveButton(TRP2_CreationFrameDocumentFrameImageUrl,TRP2_GetWithDefaut(tab,"Url","Interface\\ICONS\\Temp"),TRP2_CreationFrameDocumentFrameImageSave);
	TRP2_SetFrameSaveButton(TRP2_CreationFrameDocumentFrameImageDimX,TRP2_GetWithDefaut(tab,"DimX",100),TRP2_CreationFrameDocumentFrameImageSave);
	TRP2_SetFrameSaveButton(TRP2_CreationFrameDocumentFrameImageDimY,TRP2_GetWithDefaut(tab,"DimY",100),TRP2_CreationFrameDocumentFrameImageSave);
	TRP2_SetFrameSaveButton(TRP2_CreationFrameDocumentFrameImagePosX,TRP2_GetWithDefaut(tab,"PosX",0),TRP2_CreationFrameDocumentFrameImageSave);
	TRP2_SetFrameSaveButton(TRP2_CreationFrameDocumentFrameImagePosY,TRP2_GetWithDefaut(tab,"PosX",0),TRP2_CreationFrameDocumentFrameImageSave);
	TRP2_SetFrameSaveButton(TRP2_CreationFrameDocumentFrameImageRognerLeft,TRP2_GetWithDefaut(tab,"Left",0),TRP2_CreationFrameDocumentFrameImageSave);
	TRP2_SetFrameSaveButton(TRP2_CreationFrameDocumentFrameImageRognerRight,TRP2_GetWithDefaut(tab,"Right",100),TRP2_CreationFrameDocumentFrameImageSave);
	TRP2_SetFrameSaveButton(TRP2_CreationFrameDocumentFrameImageRognerUp,TRP2_GetWithDefaut(tab,"Top",0),TRP2_CreationFrameDocumentFrameImageSave);
	TRP2_SetFrameSaveButton(TRP2_CreationFrameDocumentFrameImageRognerDown,TRP2_GetWithDefaut(tab,"Bottom",100),TRP2_CreationFrameDocumentFrameImageSave);
	TRP2_SetFrameSaveButton(TRP2_CreationFrameDocumentFrameImageDesaturated,nil,TRP2_CreationFrameDocumentFrameImageSave);
	TRP2_SetFrameSaveButton(TRP2_CreationFrameDocumentFrameImageRounded,nil,TRP2_CreationFrameDocumentFrameImageSave);
	
	TRP2_CreationFrameDocumentFrameImageTitle:SetText(TRP2_CTS(TRP2_FT(TRP2_LOC_DOC_IMAGEEDIT.." n°%1",string.match(Elem,"%d+"))));
	TRP2_CreationFrameDocumentFrameImageLevel:SetText(TRP2_GetWithDefaut(tab,"Level",1));
	TRP2_CreationFrameDocumentFrameImageUrl:SetText(TRP2_GetWithDefaut(tab,"Url","Interface\\ICONS\\Temp"));
	TRP2_CreationFrameDocumentFrameImageDimX:SetText(TRP2_GetWithDefaut(tab,"DimX",100));
	TRP2_CreationFrameDocumentFrameImageDimY:SetText(TRP2_GetWithDefaut(tab,"DimY",100));
	TRP2_CreationFrameDocumentFrameImagePosX:SetText(TRP2_GetWithDefaut(tab,"PosX",0));
	TRP2_CreationFrameDocumentFrameImagePosY:SetText(TRP2_GetWithDefaut(tab,"PosY",0));
	TRP2_CreationFrameDocumentFrameImageRognerLeft:SetText(TRP2_GetWithDefaut(tab,"Left",0));
	TRP2_CreationFrameDocumentFrameImageRognerRight:SetText(TRP2_GetWithDefaut(tab,"Right",100));
	TRP2_CreationFrameDocumentFrameImageRognerUp:SetText(TRP2_GetWithDefaut(tab,"Top",0));
	TRP2_CreationFrameDocumentFrameImageRognerDown:SetText(TRP2_GetWithDefaut(tab,"Bottom",100));
	TRP2_CreationFrameDocumentFrameImageColorStart.R = TRP2_GetWithDefaut(tab,"R",1);
	TRP2_CreationFrameDocumentFrameImageColorStart.G = TRP2_GetWithDefaut(tab,"G",1);
	TRP2_CreationFrameDocumentFrameImageColorStart.B = TRP2_GetWithDefaut(tab,"B",1);
	TRP2_CreationFrameDocumentFrameImageColorStart.A = TRP2_GetWithDefaut(tab,"A",1);
	local couleurHexa = TRP2_ColorToHexa(TRP2_CreationFrameDocumentFrameImageColorStart.R,TRP2_CreationFrameDocumentFrameImageColorStart.G,TRP2_CreationFrameDocumentFrameImageColorStart.B);
	TRP2_CreationFrameDocumentFrameImageColorStart:SetText(TRP2_CTS(couleurHexa..TRP2_LOC_Couleur.." 1"));
	TRP2_CreationFrameDocumentFrameImageDesaturated:SetChecked(TRP2_GetWithDefaut(tab,"Desaturated",0));
	TRP2_CreationFrameDocumentFrameImageRounded:SetChecked(TRP2_GetWithDefaut(tab,"bRound",0));
	TRP2_CreationFrameDocumentFrameImageColorEnd.R = TRP2_GetWithDefaut(tab,"EndR",1);
	TRP2_CreationFrameDocumentFrameImageColorEnd.G = TRP2_GetWithDefaut(tab,"EndG",1);
	TRP2_CreationFrameDocumentFrameImageColorEnd.B = TRP2_GetWithDefaut(tab,"EndB",1);
	TRP2_CreationFrameDocumentFrameImageColorEnd.A = TRP2_GetWithDefaut(tab,"EndA",1);
	couleurHexa = TRP2_ColorToHexa(TRP2_CreationFrameDocumentFrameImageColorEnd.R,TRP2_CreationFrameDocumentFrameImageColorEnd.G,TRP2_CreationFrameDocumentFrameImageColorEnd.B);
	TRP2_CreationFrameDocumentFrameImageColorEnd:SetText(TRP2_CTS(couleurHexa..TRP2_LOC_Couleur.." 2"));
	TRP2_CreationFrameDocumentFrameImageAlignement.Valeur = TRP2_GetWithDefaut(tab,"Grad","HORIZONTAL");
	TRP2_CreationFrameDocumentFrameImageAlignementValeur:SetText(TRP2_CTS(TRP2_GetWithDefaut(tab,"Grad","HORIZONTAL")));
	TRP2_CreationFrameDocumentFrameImageColorStart:SetScript("OnClick",function(self,button)
		TRP2_CreationFrameDocumentFrameImageSave:Enable();
		if button == "LeftButton" then
			if IsShiftKeyDown() then
				TRP2_CreationFrameDocumentFrameImageColorStart.R = TRP2_CreationFrameDocumentFrameImageColorEnd.R;
				TRP2_CreationFrameDocumentFrameImageColorStart.G = TRP2_CreationFrameDocumentFrameImageColorEnd.G;
				TRP2_CreationFrameDocumentFrameImageColorStart.B = TRP2_CreationFrameDocumentFrameImageColorEnd.B;
				TRP2_CreationFrameDocumentFrameImageColorStart.A = TRP2_CreationFrameDocumentFrameImageColorEnd.A;
				local couleurHexa = TRP2_ColorToHexa(TRP2_CreationFrameDocumentFrameImageColorStart.R,TRP2_CreationFrameDocumentFrameImageColorStart.G,TRP2_CreationFrameDocumentFrameImageColorStart.B);
				TRP2_CreationFrameDocumentFrameImageColorStart:SetText(TRP2_CTS(couleurHexa..TRP2_LOC_Couleur.." 1"));
			elseif IsControlKeyDown() then
				local R,G,B,A;
				R = TRP2_CreationFrameDocumentFrameImageColorStart.R;
				G = TRP2_CreationFrameDocumentFrameImageColorStart.G;
				B = TRP2_CreationFrameDocumentFrameImageColorStart.B;
				A = TRP2_CreationFrameDocumentFrameImageColorStart.A;
				TRP2_CreationFrameDocumentFrameImageColorStart.R = TRP2_CreationFrameDocumentFrameImageColorEnd.R;
				TRP2_CreationFrameDocumentFrameImageColorStart.G = TRP2_CreationFrameDocumentFrameImageColorEnd.G;
				TRP2_CreationFrameDocumentFrameImageColorStart.B = TRP2_CreationFrameDocumentFrameImageColorEnd.B;
				TRP2_CreationFrameDocumentFrameImageColorStart.A = TRP2_CreationFrameDocumentFrameImageColorEnd.A;
				TRP2_CreationFrameDocumentFrameImageColorEnd.R = R;
				TRP2_CreationFrameDocumentFrameImageColorEnd.G = G;
				TRP2_CreationFrameDocumentFrameImageColorEnd.B = B;
				TRP2_CreationFrameDocumentFrameImageColorEnd.A = A;
				local couleurHexa = TRP2_ColorToHexa(TRP2_CreationFrameDocumentFrameImageColorStart.R,TRP2_CreationFrameDocumentFrameImageColorStart.G,TRP2_CreationFrameDocumentFrameImageColorStart.B);
				TRP2_CreationFrameDocumentFrameImageColorStart:SetText(TRP2_CTS(couleurHexa..TRP2_LOC_Couleur.." 1"));
				local couleurHexa = TRP2_ColorToHexa(TRP2_CreationFrameDocumentFrameImageColorEnd.R,TRP2_CreationFrameDocumentFrameImageColorEnd.G,TRP2_CreationFrameDocumentFrameImageColorEnd.B);
				TRP2_CreationFrameDocumentFrameImageColorEnd:SetText(TRP2_CTS(couleurHexa..TRP2_LOC_Couleur.." 2"));
			else
				ColorPickerFrame.func = function() 
					TRP2_CreationFrameDocumentFrameImageColorStart.R,TRP2_CreationFrameDocumentFrameImageColorStart.G,TRP2_CreationFrameDocumentFrameImageColorStart.B = ColorPickerFrame:GetColorRGB();
					TRP2_CreationFrameDocumentFrameImageColorStart.A = OpacitySliderFrame:GetValue();
					local couleurHexa = TRP2_ColorToHexa(TRP2_CreationFrameDocumentFrameImageColorStart.R,TRP2_CreationFrameDocumentFrameImageColorStart.G,TRP2_CreationFrameDocumentFrameImageColorStart.B);
					TRP2_CreationFrameDocumentFrameImageColorStart:SetText(TRP2_CTS(couleurHexa..TRP2_LOC_Couleur.." 1"));
				end;
				ColorPickerFrame.opacityFunc = ColorPickerFrame.func;
				local R,G,B,A;
				R = TRP2_CreationFrameDocumentFrameImageColorStart.R;
				G = TRP2_CreationFrameDocumentFrameImageColorStart.G;
				B = TRP2_CreationFrameDocumentFrameImageColorStart.B;
				A = TRP2_CreationFrameDocumentFrameImageColorStart.A;
				ColorPickerFrame.cancelFunc = function() 
					TRP2_CreationFrameDocumentFrameImageColorStart.R = R;
					TRP2_CreationFrameDocumentFrameImageColorStart.G = G;
					TRP2_CreationFrameDocumentFrameImageColorStart.B = B;
					TRP2_CreationFrameDocumentFrameImageColorStart.A = A;
					local couleurHexa = TRP2_ColorToHexa(TRP2_CreationFrameDocumentFrameImageColorStart.R,TRP2_CreationFrameDocumentFrameImageColorStart.G,TRP2_CreationFrameDocumentFrameImageColorStart.B);
					TRP2_CreationFrameDocumentFrameImageColorStart:SetText(TRP2_CTS(couleurHexa..TRP2_LOC_Couleur.." 1"));
				end;
				ColorPickerFrame:SetColorRGB(TRP2_CreationFrameDocumentFrameImageColorStart.R,TRP2_CreationFrameDocumentFrameImageColorStart.G,TRP2_CreationFrameDocumentFrameImageColorStart.B);
				ColorPickerFrame.opacity = TRP2_CreationFrameDocumentFrameImageColorStart.A;
				ColorPickerFrame.hasOpacity = true;
				ShowUIPanel(ColorPickerFrame);
			end
		else
			TRP2_CreationFrameDocumentFrameImageColorStart.R = 1;
			TRP2_CreationFrameDocumentFrameImageColorStart.G = 1;
			TRP2_CreationFrameDocumentFrameImageColorStart.B = 1;
			TRP2_CreationFrameDocumentFrameImageColorStart.A = 1;
			local couleurHexa = TRP2_ColorToHexa(TRP2_CreationFrameDocumentFrameImageColorStart.R,TRP2_CreationFrameDocumentFrameImageColorStart.G,TRP2_CreationFrameDocumentFrameImageColorStart.B);
			TRP2_CreationFrameDocumentFrameImageColorStart:SetText(TRP2_CTS(couleurHexa..TRP2_LOC_Couleur.." 1"));
		end
	end);
	TRP2_CreationFrameDocumentFrameImageColorEnd:SetScript("OnClick",function(self,button)
		TRP2_CreationFrameDocumentFrameImageSave:Enable();
		if button == "LeftButton" then
			if IsShiftKeyDown() then
				TRP2_CreationFrameDocumentFrameImageColorEnd.R = TRP2_CreationFrameDocumentFrameImageColorStart.R;
				TRP2_CreationFrameDocumentFrameImageColorEnd.G = TRP2_CreationFrameDocumentFrameImageColorStart.G;
				TRP2_CreationFrameDocumentFrameImageColorEnd.B = TRP2_CreationFrameDocumentFrameImageColorStart.B;
				TRP2_CreationFrameDocumentFrameImageColorEnd.A = TRP2_CreationFrameDocumentFrameImageColorStart.A;
				local couleurHexa = TRP2_ColorToHexa(TRP2_CreationFrameDocumentFrameImageColorEnd.R,TRP2_CreationFrameDocumentFrameImageColorEnd.G,TRP2_CreationFrameDocumentFrameImageColorEnd.B);
				TRP2_CreationFrameDocumentFrameImageColorEnd:SetText(TRP2_CTS(couleurHexa..TRP2_LOC_Couleur.." 2"));
			elseif IsControlKeyDown() then
				local R,G,B,A;
				R = TRP2_CreationFrameDocumentFrameImageColorStart.R;
				G = TRP2_CreationFrameDocumentFrameImageColorStart.G;
				B = TRP2_CreationFrameDocumentFrameImageColorStart.B;
				A = TRP2_CreationFrameDocumentFrameImageColorStart.A;
				TRP2_CreationFrameDocumentFrameImageColorStart.R = TRP2_CreationFrameDocumentFrameImageColorEnd.R;
				TRP2_CreationFrameDocumentFrameImageColorStart.G = TRP2_CreationFrameDocumentFrameImageColorEnd.G;
				TRP2_CreationFrameDocumentFrameImageColorStart.B = TRP2_CreationFrameDocumentFrameImageColorEnd.B;
				TRP2_CreationFrameDocumentFrameImageColorStart.A = TRP2_CreationFrameDocumentFrameImageColorEnd.A;
				TRP2_CreationFrameDocumentFrameImageColorEnd.R = R;
				TRP2_CreationFrameDocumentFrameImageColorEnd.G = G;
				TRP2_CreationFrameDocumentFrameImageColorEnd.B = B;
				TRP2_CreationFrameDocumentFrameImageColorEnd.A = A;
				local couleurHexa = TRP2_ColorToHexa(TRP2_CreationFrameDocumentFrameImageColorStart.R,TRP2_CreationFrameDocumentFrameImageColorStart.G,TRP2_CreationFrameDocumentFrameImageColorStart.B);
				TRP2_CreationFrameDocumentFrameImageColorStart:SetText(TRP2_CTS(couleurHexa..TRP2_LOC_Couleur.." 1"));
				local couleurHexa = TRP2_ColorToHexa(TRP2_CreationFrameDocumentFrameImageColorEnd.R,TRP2_CreationFrameDocumentFrameImageColorEnd.G,TRP2_CreationFrameDocumentFrameImageColorEnd.B);
				TRP2_CreationFrameDocumentFrameImageColorEnd:SetText(TRP2_CTS(couleurHexa..TRP2_LOC_Couleur.." 2"));
			else
				ColorPickerFrame.func = function() 
					TRP2_CreationFrameDocumentFrameImageColorEnd.R,TRP2_CreationFrameDocumentFrameImageColorEnd.G,TRP2_CreationFrameDocumentFrameImageColorEnd.B = ColorPickerFrame:GetColorRGB();
					TRP2_CreationFrameDocumentFrameImageColorEnd.A = OpacitySliderFrame:GetValue();
					local couleurHexa = TRP2_ColorToHexa(TRP2_CreationFrameDocumentFrameImageColorEnd.R,TRP2_CreationFrameDocumentFrameImageColorEnd.G,TRP2_CreationFrameDocumentFrameImageColorEnd.B);
					TRP2_CreationFrameDocumentFrameImageColorEnd:SetText(TRP2_CTS(couleurHexa..TRP2_LOC_Couleur.." 2"));
				end;
				local R,G,B,A;
				R = TRP2_CreationFrameDocumentFrameImageColorEnd.R;
				G = TRP2_CreationFrameDocumentFrameImageColorEnd.G;
				B = TRP2_CreationFrameDocumentFrameImageColorEnd.B;
				A = TRP2_CreationFrameDocumentFrameImageColorEnd.A;
				ColorPickerFrame.cancelFunc = function() 
					TRP2_CreationFrameDocumentFrameImageColorEnd.R = R;
					TRP2_CreationFrameDocumentFrameImageColorEnd.G = G;
					TRP2_CreationFrameDocumentFrameImageColorEnd.B = B;
					TRP2_CreationFrameDocumentFrameImageColorEnd.A = A;
					local couleurHexa = TRP2_ColorToHexa(TRP2_CreationFrameDocumentFrameImageColorEnd.R,TRP2_CreationFrameDocumentFrameImageColorEnd.G,TRP2_CreationFrameDocumentFrameImageColorEnd.B);
					TRP2_CreationFrameDocumentFrameImageColorEnd:SetText(TRP2_CTS(couleurHexa..TRP2_LOC_Couleur.." 2"));
				end;
				ColorPickerFrame.opacityFunc = ColorPickerFrame.func;
				ColorPickerFrame:SetColorRGB(TRP2_CreationFrameDocumentFrameImageColorEnd.R,TRP2_CreationFrameDocumentFrameImageColorEnd.G,TRP2_CreationFrameDocumentFrameImageColorEnd.B);
				ColorPickerFrame.opacity = TRP2_CreationFrameDocumentFrameImageColorEnd.A;
				ColorPickerFrame.hasOpacity = true;
				ShowUIPanel(ColorPickerFrame);
			end
		else
			TRP2_CreationFrameDocumentFrameImageColorEnd.R = 1;
			TRP2_CreationFrameDocumentFrameImageColorEnd.G = 1;
			TRP2_CreationFrameDocumentFrameImageColorEnd.B = 1;
			TRP2_CreationFrameDocumentFrameImageColorEnd.A = 1;
			local couleurHexa = TRP2_ColorToHexa(TRP2_CreationFrameDocumentFrameImageColorEnd.R,TRP2_CreationFrameDocumentFrameImageColorEnd.G,TRP2_CreationFrameDocumentFrameImageColorEnd.B);
			TRP2_CreationFrameDocumentFrameImageColorEnd:SetText(TRP2_CTS(couleurHexa..TRP2_LOC_Couleur.." 2"));
		end
	end);

	TRP2_CreationFrameDocumentFrameString:Hide();
	TRP2_CreationFrameDocumentFrameImage:Show();
end

function TRP2_CreaDocuCreateTabString()
	local tab = {};
	tab["Level"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameDocumentFrameStringLevel:GetText()),1);
	tab["DimX"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameDocumentFrameStringDimX:GetText()),0);
	tab["DimY"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameDocumentFrameStringDimY:GetText()),0);
	tab["PosX"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameDocumentFrameStringPosX:GetText()),0);
	tab["PosY"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameDocumentFrameStringPosY:GetText()),0);
	tab["Taille"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameDocumentFrameStringTaille:GetText()),12);
	tab["Font"] = TRP2_EmptyToNil(TRP2_CreationFrameDocumentFrameStringFont.Valeur,1);
	tab["AlignV"] = TRP2_DefautToNil(TRP2_CreationFrameDocumentFrameStringAlignV.Valeur,"MIDDLE");
	tab["AlignH"] = TRP2_DefautToNil(TRP2_CreationFrameDocumentFrameStringAlignH.Valeur,"CENTER");
	tab["Texte"] = TRP2_EmptyToNil(TRP2_CreationFrameDocumentFrameStringTexteScrollEditBox:GetText());
	tab["Spacing"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameDocumentFrameStringSpacing:GetText()),0);
	tab["ShadowX"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameDocumentFrameStringShadowX:GetText()),1);
	tab["ShadowY"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameDocumentFrameStringShadowY:GetText()),-1);
	tab["bContours"] = TRP2_DefautToNil(TRP2_CreationFrameDocumentFrameStringContours:GetChecked() == 1,false);
	tab["R"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameDocumentFrameStringColor.R),1);
	tab["G"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameDocumentFrameStringColor.G),1);
	tab["B"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameDocumentFrameStringColor.B),1);
	tab["A"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameDocumentFrameStringColor.A),1);
	tab["ShadowR"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameDocumentFrameStringShadowColor.R),0);
	tab["ShadowG"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameDocumentFrameStringShadowColor.G),0);
	tab["ShadowB"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameDocumentFrameStringShadowColor.B),0);
	tab["ShadowA"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameDocumentFrameStringShadowColor.A),1);
	return tab;
end

function TRP2_CreaDocuCreateTabImage()
	local tab = {};
	tab["Level"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameDocumentFrameImageLevel:GetText()),1);
	tab["DimX"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameDocumentFrameImageDimX:GetText()),100);
	tab["DimY"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameDocumentFrameImageDimY:GetText()),100);
	tab["PosX"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameDocumentFrameImagePosX:GetText()),0);
	tab["PosY"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameDocumentFrameImagePosY:GetText()),0);
	tab["Left"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameDocumentFrameImageRognerLeft:GetText()),0);
	tab["Right"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameDocumentFrameImageRognerRight:GetText()),100);
	tab["Top"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameDocumentFrameImageRognerUp:GetText()),0);
	tab["Bottom"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameDocumentFrameImageRognerDown:GetText()),100);
	tab["R"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameDocumentFrameImageColorStart.R),1);
	tab["G"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameDocumentFrameImageColorStart.G),1);
	tab["B"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameDocumentFrameImageColorStart.B),1);
	tab["A"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameDocumentFrameImageColorStart.A),1);
	tab["EndR"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameDocumentFrameImageColorEnd.R),1);
	tab["EndG"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameDocumentFrameImageColorEnd.G),1);
	tab["EndB"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameDocumentFrameImageColorEnd.B),1);
	tab["EndA"] = TRP2_DefautToNil(tonumber(TRP2_CreationFrameDocumentFrameImageColorEnd.A),1);
	tab["Url"] = TRP2_DefautToNil(TRP2_CreationFrameDocumentFrameImageUrl:GetText(),"");
	tab["Desaturated"] = TRP2_DefautToNil(TRP2_CreationFrameDocumentFrameImageDesaturated:GetChecked() == 1,false);
	tab["bRound"] = TRP2_DefautToNil(TRP2_CreationFrameDocumentFrameImageRounded:GetChecked() == 1,false);
	tab["Grad"] = TRP2_DefautToNil(TRP2_CreationFrameDocumentFrameImageAlignement.Valeur,"HORIZONTAL");
	return tab;
end

function TRP2_SetFrameSaveButton(frame,valeur,savebutton)
	if frame:IsObjectType("EditBox") then
		frame:SetScript("OnTextChanged",function(self)
			self:SetText(string.gsub(self:GetText(),"[%#%~%µ%$%@]","")); 
			if savebutton.Can ~= false and self:GetText() ~= tostring(valeur) then savebutton:Enable(); end
		end);
	elseif frame:IsObjectType("Button") or frame:IsObjectType("CheckButton") then
		frame:SetScript("OnClick",function()
			if savebutton.Can ~= false then 
				savebutton:Enable();
			end
		end);
	end
end

function TRP2_ChargerCreaDocumentPanel(DocuID)
	local DocuTab = TRP2_GetDocumentInfo(DocuID);
	if not DocuTab then
		DocuTab = {};
	end
	
	local titre = TRP2_LOC_CREA_DOCU.." : ".."{o}[{v}"..TRP2_GetWithDefaut(DocuTab,"Nom",TRP2_LOC_NEWDOCU).."{o}]";
	if TRP2_CanWrite(DocuTab,DocuID) then
		titre = titre.." {j}("..TRP2_LOC_Edition..")";
		TRP2_CreationFrameDocumentFrameMenuSave.Can = true;
		TRP2_CreationFrameDocumentFrameMenuWriteLock:Enable();
		TRP2_CreationFrameDocumentFrameMenuWriteLock.disabled = nil;
	else
		titre = titre.." {v}("..TRP2_LOC_Consulte..")";
		TRP2_CreationFrameDocumentFrameMenuSave.Can = false;
		TRP2_CreationFrameDocumentFrameMenuWriteLock:Disable();
		TRP2_CreationFrameDocumentFrameMenuWriteLock.disabled = 1;
	end
	TRP2_CreationFrameDocumentFrameMenuSave:Disable();
	TRP2_CreationFrameHeaderTitle:SetText(TRP2_CTS(titre));
	TRP2_CreationFrameDocumentFrameMenuIcone.icone = TRP2_GetWithDefaut(DocuTab,"Icone","Temp");
	TRP2_CreationFrameDocumentFrameMenuIconeIcon:SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(DocuTab,"Icone","Temp"));
	TRP2_CreationFrameDocumentFrameMenuTitre:SetText(TRP2_GetWithDefaut(DocuTab,"Nom",TRP2_LOC_NEWDOCU));
	TRP2_CreationFrameDocumentFrameMenuWriteLock:SetChecked(TRP2_GetWithDefaut(DocuTab,"bWriteLock",1));
	TRP2_CreationFrameDocumentFrameInfoID:SetText(TRP2_CTS("{o}ID : {w}"..DocuID));
	TRP2_CreationFrameDocumentFrameInfoCreateur:SetText(TRP2_CTS("{o}"..TRP2_LOC_CREATOR.." : {w}"..TRP2_GetWithDefaut(DocuTab,"Createur",TRP2_Joueur)));
	TRP2_DOCUMENTAPERCU["Createur"] = TRP2_GetWithDefaut(DocuTab,"Createur",TRP2_Joueur);
	TRP2_CreationFrameDocumentFrameInfoVernum:SetText(TRP2_CTS("{o}"..GAME_VERSION_LABEL.." : {w}"..TRP2_GetWithDefaut(DocuTab,"VerNum",1)));
	TRP2_CreationFrameDocumentFrameInfoDate:SetText(TRP2_CTS("{o}"..TRP2_LOC_LASTDATE.." : {w}"..TRP2_GetWithDefaut(DocuTab,"Date",date("%d/%m/%y, %H:%M:%S"))));
	
	TRP2_SetFrameSaveButton(TRP2_CreationFrameDocumentFrameMenuTitre,TRP2_GetWithDefaut(DocuTab,"Nom",TRP2_LOC_NEWDOCU),TRP2_CreationFrameDocumentFrameMenuSave);
	TRP2_SetFrameSaveButton(TRP2_CreationFrameDocumentFrameMenuWriteLock,nil,TRP2_CreationFrameDocumentFrameMenuSave);
	
	TRP2_CreationFrameDocument.Id = DocuID;
	TRP2_CreationFrameDocument.Page = 1;
	-- Chargement des variables de pages
	if TRP2_CreationFrameDocument.PageTab then
		wipe(TRP2_CreationFrameDocument.PageTab);
	else
		TRP2_CreationFrameDocument.PageTab = {};
	end
	for key,value in pairs(DocuTab) do
		if string.match(key,"Page%d+") == key then -- Variable de page
			TRP2_CreationFrameDocument.PageTab[key] = {};
			TRP2_tcopy(TRP2_CreationFrameDocument.PageTab[key],value);
		end
	end
	
	TRP2_ListerPageDocument();
	TRP2_CreationFrameDocumentFrameImage:Hide();
	TRP2_CreationFrameDocumentFrameString:Hide();
	TRP2_CreationFrameDocumentFramePageMain:Hide();
	TRP2_CreationFrameDocument:Show();
	
	TRP2_CreationFrameDocumentFrameListePageAjout:SetScript("OnClick",function(self,button)
		if button == "LeftButton" then
			TRP2_CreaDocuChargerPage("Page"..TRP2_FoundFreePlace(TRP2_CreationFrameDocument.PageTab,"Page",3));
		end
	end);
	
	TRP2_CreationFrameDocumentFrameMenuAnnuler:SetScript("OnClick",function()
		TRP2_CreationPanel();
	end);
	
	StaticPopupDialogs["TRP2_NOT_ANYMORE"].text = TRP2_CTS(TRP2_ENTETE..TRP2_LOC_DOCWARNING);
	TRP2_ShowStaticPopupAny("TRP2_NOT_ANYMORE","docuWarn1");
	
end

function TRP2_PanelCreationDocumentOnUpdate()
	if TRP2_CreationFrameDocumentFramePageMain:IsVisible() then
		wipe(TRP2_DOCUMENTAPERCU["Page001"]);
		TRP2_DOCUMENTAPERCU["Page001"]["Texte"] = TRP2_EmptyToNil(TRP2_CreationFrameDocumentFramePageMainTexteScrollEditBox:GetText());
		for k,v in pairs(TRP2_CreationFrameDocument.PageContenuTab) do
			if (not TRP2_CreationFrameDocumentFrameImage:IsVisible() and not TRP2_CreationFrameDocumentFrameString:IsVisible()) or k ~= TRP2_CreationFrameDocument.ActualElem then
				TRP2_DOCUMENTAPERCU["Page001"][k] = v;
			end
		end
		if TRP2_CreationFrameDocumentFrameImage:IsVisible() then
			TRP2_DOCUMENTAPERCU["Page001"][TRP2_CreationFrameDocument.ActualElem] = TRP2_CreaDocuCreateTabImage();
		elseif TRP2_CreationFrameDocumentFrameString:IsVisible() then
			local tab = TRP2_CreaDocuCreateTabString();
			TRP2_DOCUMENTAPERCU["Page001"][TRP2_CreationFrameDocument.ActualElem] = tab;
			local anchor;
			if TRP2_GetWithDefaut(tab,"AlignV","MIDDLE") == "MIDDLE" and TRP2_GetWithDefaut(tab,"AlignH","CENTER") == "CENTER" then
				anchor = "CENTER";
			else
				anchor = string.gsub(TRP2_GetWithDefaut(tab,"AlignV","MIDDLE"),"MIDDLE","")..string.gsub(TRP2_GetWithDefaut(tab,"AlignH","CENTER"),"CENTER","");
			end
			TRP2_CreationFrameDocumentFrameStringApercuCadre:ClearAllPoints();
			TRP2_CreationFrameDocumentFrameStringApercuCadre:SetPoint(anchor, TRP2_GetWithDefaut(tab,"PosX",0)-10
																		, TRP2_GetWithDefaut(tab,"PosY",0));
			TRP2_CreationFrameDocumentFrameStringApercuCadre:SetHeight(TRP2_GetWithDefaut(tab,"DimY",0)+5);
			TRP2_CreationFrameDocumentFrameStringApercuCadre:SetWidth(TRP2_GetWithDefaut(tab,"DimX",0)+5);
		end
		TRP2_ChargerDocument(TRP2_DOCUMENTAPERCU,1,id,true);
		if TRP2_CreationFrameDocumentFrameString:IsVisible() then
			TRP2_CreationFrameDocumentFrameStringApercuCadre:Show();
		end
		if TRP2_CreationFrameDocumentFrameStringShowGrad:GetChecked() then
			TRP2_CreationFrameDocumentFrameStringApercuGrad:Show();
		end
	end
end

function TRP2_CreateDocumentTabCreation()
	local Docu = {};
	
	TRP2_tcopy(Docu,TRP2_CreationFrameDocument.PageTab);
	Docu["Nom"] = TRP2_EmptyToNil(TRP2_CreationFrameDocumentFrameMenuTitre:GetText());
	Docu["bWriteLock"] = TRP2_DefautToNil(TRP2_CreationFrameDocumentFrameMenuWriteLock:GetChecked() == 1,true);
	Docu["Icone"] = TRP2_DefautToNil(TRP2_EmptyToNil(TRP2_CreationFrameDocumentFrameMenuIcone.icone),"Temp");
	
	return Docu;
end

function TRP2_DocumentSave(ID)
	local objet = TRP2_CreateDocumentTabCreation();
	-- Ici t'aura un check
	objet["Createur"] = TRP2_GetWithDefaut(TRP2_Module_Documents[ID],"Createur",TRP2_Joueur);
	objet["Date"] = date("%d/%m/%y, %H:%M:%S").." "..TRP2_LOC_By.." "..TRP2_Joueur;
	if TRP2_GetWithDefaut(TRP2_Module_Documents[ID],"VerNum",1) < 10000 then
		objet["VerNum"] = TRP2_GetWithDefaut(TRP2_Module_Documents[ID],"VerNum",1) + 1;
	end
	if TRP2_Module_Documents[ID] then
		wipe(TRP2_Module_Documents[ID]);
	else
		TRP2_Module_Documents[ID] = {};
	end
	TRP2_tcopy(TRP2_Module_Documents[ID], objet);
	TRP2_Afficher(TRP2_FT(TRP2_LOC_CREA_AURA_SAVE,TRP2_GetWithDefaut(TRP2_Module_Documents[ID],"Nom",TRP2_LOC_NEWDOCU)));
	TRP2_ChargerCreaDocumentPanel(ID);
end

function TRP2_DocumentSaveAs()
	local IDnew = TRP2_CreateNewEmpty("Document");
	TRP2_DocumentSave(IDnew);
	TRP2_ChargerCreaDocumentPanel(IDnew);
end

function TRP2_CreatSimpleTooltipDocument(tab)
	return "{icone:"..TRP2_GetWithDefaut(tab,"Icone","Temp")..":35} "..TRP2_GetWithDefaut(tab,"Nom",TRP2_LOC_NEWDOCU);
end

function TRP2_CreatSimpleTooltipDocumentNext(tab,ID)
	local message = "{w}ID : {o}"..ID.."\n".."{w}"..TRP2_LOC_CREAVERNHELP.." : {o}"..TRP2_GetWithDefaut(tab,"VerNum","0").."\n";
	message = message.."{w}"..TRP2_LOC_CREATOR.." : {o}"..TRP2_GetWithDefaut(tab,"Createur",UNKNOWN).."\n";
	local serializedStreamSize = string.len(TRP2_Libs:Serialize(tab));
	message = message.."{w}"..TRP2_LOC_DOCUMENTSIZE.." : {o}"..(serializedStreamSize/1000).." Ko\n";
	message = message.."{w}"..TRP2_LOC_MESSNUM.." : {o}"..math.ceil(serializedStreamSize/221);
	return message;
end

--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- AFFICHAGE
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

function TRP2_Set_Module_Document()
	if not TRP2_Module_Documents then
		TRP2_Module_Documents = {};
	end
	
	TRP2_CreationFrameDocumentFrameMenuApercu:SetScript("OnClick",function()
		local funct = function()
			TRP2_CreationFrameDocumentFramePageMain:Hide();
			local tab = TRP2_CreateDocumentTabCreation();
			tab["Createur"] = TRP2_GetWithDefaut(tab,"Createur",TRP2_Joueur);
			TRP2_ChargerDocument(tab,1,TRP2_CreationFrameDocument.Id);
		end
		if TRP2_CreationFrameDocumentFramePageMain:IsVisible() then
			StaticPopupDialogs["TRP2_CONFIRM_ACTION_NS"].text = TRP2_CTS(TRP2_ENTETE..TRP2_LOC_AVERTDOCU5);
			TRP2_ShowStaticPopup("TRP2_CONFIRM_ACTION_NS",nil,
			function() funct() end);
		else
			funct();
		end
	end);
	
	
	TRP2_CreationFrameDocumentFrameImageLevel.min = 1;
	TRP2_CreationFrameDocumentFrameImageLevel.max = 5;
	TRP2_CreationFrameDocumentFrameStringLevel.min = 1;
	TRP2_CreationFrameDocumentFrameStringLevel.max = 5;
	TRP2_CreationFrameDocumentFrameStringTaille.min = 1;
	TRP2_CreationFrameDocumentFrameStringTaille.max = 28;
	TRP2_CreationFrameDocumentFrameImageRognerLeft.min = 0;
	TRP2_CreationFrameDocumentFrameImageRognerLeft.max = 100;
	TRP2_CreationFrameDocumentFrameImageRognerRight.min = 0;
	TRP2_CreationFrameDocumentFrameImageRognerRight.max = 100;
	TRP2_CreationFrameDocumentFrameImageRognerUp.min = 0;
	TRP2_CreationFrameDocumentFrameImageRognerUp.max = 100;
	TRP2_CreationFrameDocumentFrameImageRognerDown.min = 0;
	TRP2_CreationFrameDocumentFrameImageRognerDown.max = 100;
	TRP2_CreationFrameDocumentFrameImageDimY.min = 1;
	TRP2_CreationFrameDocumentFrameImageDimX.min = 1;
	TRP2_CreationFrameDocumentFrameStringDimY.min = 0;
	TRP2_CreationFrameDocumentFrameStringDimX.min = 0;
	TRP2_CreationFrameDocumentFrameStringSpacing.min = 0;
	
	TRP2_DocumentFrameScrollTexte:SetFont("h1","Fonts\\FRIZQT__.ttf", 25);
	TRP2_DocumentFrameScrollTexte:SetFont("h2","Fonts\\FRIZQT__.ttf", 20);
	TRP2_DocumentFrameScrollTexte:SetFont("h3","Fonts\\FRIZQT__.ttf", 13);
	TRP2_DocumentFrameScrollTexte:SetFont("Fonts\\FRIZQT__.TTF",11);
	TRP2_DocumentFrameScrollTexte:SetTextColor(1,1,1);
	TRP2_DocumentFrameScrollTexte:SetTextColor("h1",0.7,0.7,0.7);
	TRP2_DocumentFrameScrollTexte:SetTextColor("h2",0.8,0.8,0.8);
	TRP2_DocumentFrameScrollTexte:SetTextColor("h3",0.9,0.9,0.9);
	TRP2_DocumentFrameScrollTexte:SetShadowColor(0,0,0);
	TRP2_DocumentFrameScrollTexte:SetShadowOffset(1,-1);
	TRP2_DocumentFrameScrollTexte:SetShadowColor("h1",0,0,0);
	TRP2_DocumentFrameScrollTexte:SetShadowOffset("h1",1,-1);
	TRP2_DocumentFrameScrollTexte:SetShadowColor("h2",0,0,0);
	TRP2_DocumentFrameScrollTexte:SetShadowOffset("h2",1,-1);
	TRP2_DocumentFrameScrollTexte:SetShadowColor("h3",0,0,0);
	TRP2_DocumentFrameScrollTexte:SetShadowOffset("h3",1,-1);
end

function TRP2_GetDocumentInfo(id)
	if id and string.len(id) == TRP2_IDSIZE then
		return TRP2_Module_Documents[id];
	elseif TRP2_DB_Documents then
		return TRP2_DB_Documents[id];
	end
end

TRP2_DOCUMENTIMAGES = {};

function TRP2_CompleteThis(num,zero)
	num = tostring(num);
	for i=1,zero-string.len(num),1 do
		num = "0"..num;
	end
	return num;
end

function TRP2_ChargerDocument(infoTab,page,id,bApercu,bForce)
	if TRP2_DocumentFrame:IsVisible() and not bForce and id == TRP2_DocumentFrame.Id then
		page = TRP2_DocumentFrame.Page;
	end
	---------------------------------
	-- Variables communes aux pages
	---------------------------------
	-- Icone
	SetPortraitToTexture(TRP2_DocumentFramePortrait,"Interface\\ICONS\\"..TRP2_GetWithDefaut(infoTab,"Icone","Temp"));
	-- Titre
	TRP2_DocumentFrameTitre:SetText(TRP2_CTS("{w}"..TRP2_GetWithDefaut(infoTab,"Nom",TRP2_LOC_NEWDOCU)));
	
	---------------------------------
	-- Variable de la page
	---------------------------------
	
	if bApercu then
		TRP2_CreationFrameDocumentFrameStringShowGrad:Show();
	else
		TRP2_CreationFrameDocumentFrameStringShowGrad:Hide();
	end
	
	if not page then page = 1; end
	local pageTab = TRP2_GetWithDefaut(infoTab,"Page"..TRP2_CompleteThis(page,3),{});
	-- Texte de la page
	TRP2_DocumentFrameScroll:Show();
	if TRP2_GetWithDefaut(pageTab,"HideScroll") then
		TRP2_DocumentFrameScroll:Hide();
	end
	if TRP2_EmptyToNil(TRP2_GetWithDefaut(pageTab,"Texte","")) then
		TRP2_DocumentFrameScroll:Show();
		TRP2_DocumentFrameScrollTexte:SetText(TRP2_ConvertToHTML(TRP2_GetWithDefaut(pageTab,"Texte","")));
	else
		TRP2_DocumentFrameScroll:Hide();
	end
	TRP2_CreationFrameDocumentFrameStringApercuCadre:Hide();
	TRP2_CreationFrameDocumentFrameStringApercuGrad:Hide();
	-- Images et string
	table.foreach(TRP2_DOCUMENTIMAGES,function(image)
		TRP2_DOCUMENTIMAGES[image]:Hide();
	end);
	local lvl_count={};
	lvl_count[1] = 0;
	lvl_count[2] = 0;
	lvl_count[3] = 0;
	lvl_count[4] = 0;
	lvl_count[5] = 0;
	local str_lvl_count={};
	str_lvl_count[1] = 0;
	str_lvl_count[2] = 0;
	str_lvl_count[3] = 0;
	str_lvl_count[4] = 0;
	str_lvl_count[5] = 0;
	
	table.foreach(pageTab, function(image)
		if string.find(image,"Image%d+") then
			local imageTab = TRP2_GetWithDefaut(pageTab,image,{});
			local imageLevel = tonumber(TRP2_GetWithDefaut(imageTab,"Level",1));
			local frameToAttach,levelToAttach;
			lvl_count[imageLevel] = lvl_count[imageLevel] + 1;
			local texture = getglobal("TRP2_DocumentFrameImage_"..imageLevel.."_"..lvl_count[imageLevel]);
			if not texture then -- Si n'existe pas, création
				if imageLevel == 1 then
					frameToAttach = TRP2_DocumentFrame;
					levelToAttach = "artwork";
				else
					frameToAttach = TRP2_DocumentUnderFrame;
					if imageLevel == 2 then
						levelToAttach = "background";
					elseif imageLevel == 3 then
						levelToAttach = "border";
					elseif imageLevel == 4 then
						levelToAttach = "artwork";
					else
						levelToAttach = "overlay";
					end
				end
				texture = frameToAttach:CreateTexture("TRP2_DocumentFrameImage_"..imageLevel.."_"..lvl_count[imageLevel],levelToAttach);
				TRP2_DOCUMENTIMAGES[#TRP2_DOCUMENTIMAGES+1] = texture;
			end
			if (TRP2_GetWithDefaut(imageTab,"Url","Interface\\ICONS\\Temp") == "target" and UnitExists("target")) or TRP2_GetWithDefaut(imageTab,"Url","Interface\\ICONS\\Temp") == "player" then
				SetPortraitTexture(texture,TRP2_GetWithDefaut(imageTab,"Url","Interface\\ICONS\\Temp"));
			elseif TRP2_GetWithDefaut(imageTab,"bRound") then
				SetPortraitToTexture(texture,TRP2_GetWithDefaut(imageTab,"Url","Interface\\ICONS\\Temp"));
			else
				texture:SetTexture(TRP2_GetWithDefaut(imageTab,"Url","Interface\\ICONS\\Temp"));
			end
			texture:SetHeight(TRP2_GetWithDefaut(imageTab,"DimY",100));
			texture:SetWidth(TRP2_GetWithDefaut(imageTab,"DimX",100));
			texture:ClearAllPoints();
			texture:SetPoint("Center", TRP2_GetWithDefaut(imageTab,"PosX",0)-5, TRP2_GetWithDefaut(imageTab,"PosY",0));
			texture:SetDesaturated(TRP2_GetWithDefaut(imageTab,"Desaturated",0));
			--texture:SetRotation(TRP2_GetWithDefaut(imageTab,"Rot",0));
			texture:SetTexCoord(TRP2_GetWithDefaut(imageTab,"Left",0)/100,
					TRP2_GetWithDefaut(imageTab,"Right",100)/100,
					TRP2_GetWithDefaut(imageTab,"Top",0)/100,
					TRP2_GetWithDefaut(imageTab,"Bottom",100)/100);
			texture:SetGradientAlpha(TRP2_GetWithDefaut(imageTab,"Grad","HORIZONTAL"),
						TRP2_GetWithDefaut(imageTab,"R",1),
						TRP2_GetWithDefaut(imageTab,"G",1),
						TRP2_GetWithDefaut(imageTab,"B",1),
						TRP2_GetWithDefaut(imageTab,"A",1),
						
						TRP2_GetWithDefaut(imageTab,"EndR",1),
						TRP2_GetWithDefaut(imageTab,"EndG",1),
						TRP2_GetWithDefaut(imageTab,"EndB",1),
						TRP2_GetWithDefaut(imageTab,"EndA",1));
			texture:Show();
		elseif string.find(image,"String%d+") then
			local stringTab = TRP2_GetWithDefaut(pageTab,image,{});
			local imageLevel = tonumber(TRP2_GetWithDefaut(stringTab,"Level",1));
			local frameToAttach,levelToAttach;
			str_lvl_count[imageLevel] = str_lvl_count[imageLevel] + 1;
			local fontstring = getglobal("TRP2_DocumentFrameString_"..imageLevel.."_"..str_lvl_count[imageLevel]);
			if not fontstring then -- Si n'existe pas, création
				if imageLevel == 1 then
					frameToAttach = TRP2_DocumentFrame;
					levelToAttach = "artwork";
				else
					frameToAttach = TRP2_DocumentUnderFrame;
					if imageLevel == 2 then
						levelToAttach = "background";
					elseif imageLevel == 3 then
						levelToAttach = "border";
					elseif imageLevel == 4 then
						levelToAttach = "artwork";
					else
						levelToAttach = "overlay";
					end
				end
				fontstring = frameToAttach:CreateFontString("TRP2_DocumentFrameString_"..imageLevel.."_"..str_lvl_count[imageLevel],levelToAttach);
				TRP2_DOCUMENTIMAGES[#TRP2_DOCUMENTIMAGES+1] = fontstring;
			end
			local anchor;
			if TRP2_GetWithDefaut(stringTab,"AlignV","MIDDLE") == "MIDDLE" and TRP2_GetWithDefaut(stringTab,"AlignH","CENTER") == "CENTER" then
				anchor = "CENTER";
			else
				anchor = string.gsub(TRP2_GetWithDefaut(stringTab,"AlignV","MIDDLE"),"MIDDLE","")..string.gsub(TRP2_GetWithDefaut(stringTab,"AlignH","CENTER"),"CENTER","");
			end
			fontstring:ClearAllPoints();
			fontstring:SetPoint(anchor, TRP2_GetWithDefaut(stringTab,"PosX",0)-10,TRP2_GetWithDefaut(stringTab,"PosY",0));
			fontstring:SetHeight(TRP2_GetWithDefaut(stringTab,"DimY",0));
			fontstring:SetWidth(TRP2_GetWithDefaut(stringTab,"DimX",0));
			fontstring:SetJustifyH(TRP2_GetWithDefaut(stringTab,"AlignH","CENTER"));
			fontstring:SetJustifyV(TRP2_GetWithDefaut(stringTab,"AlignV","MIDDLE"));
			if TRP2_GetWithDefaut(stringTab,"bContours",false) then
				fontstring:SetFont(TRP2_DocumentFont[TRP2_GetWithDefaut(stringTab,"Font",1)+1],TRP2_GetWithDefaut(stringTab,"Taille",12),"OUTLINE");
			else
				fontstring:SetFont(TRP2_DocumentFont[TRP2_GetWithDefaut(stringTab,"Font",1)+1],TRP2_GetWithDefaut(stringTab,"Taille",12));
			end
			fontstring:SetText("");
			fontstring:SetText(TRP2_CTS(TRP2_GetWithDefaut(stringTab,"Texte","")));
			fontstring:SetTextColor(TRP2_GetWithDefaut(stringTab,"R",1),
						TRP2_GetWithDefaut(stringTab,"G",1),
						TRP2_GetWithDefaut(stringTab,"B",1),
						TRP2_GetWithDefaut(stringTab,"A",1));
			--fontstring:SetAlphaGradient(TRP2_NilToDefaut(tonumber(TRP2_CreationFrameDocumentFrameStringFadeStart:GetText()),0),
			--															TRP2_NilToDefaut(tonumber(TRP2_CreationFrameDocumentFrameStringFadeLength:GetText()),0));
			fontstring:SetShadowOffset(TRP2_GetWithDefaut(stringTab,"ShadowX",1),TRP2_GetWithDefaut(stringTab,"ShadowY",-1));
			fontstring:SetShadowColor(TRP2_GetWithDefaut(stringTab,"ShadowR",0),
						TRP2_GetWithDefaut(stringTab,"ShadowG",0),
						TRP2_GetWithDefaut(stringTab,"ShadowB",0),
						TRP2_GetWithDefaut(stringTab,"ShadowA",1));
			fontstring:SetSpacing(TRP2_GetWithDefaut(stringTab,"Spacing",0));
			fontstring:Show();
		end
	end);
	
	TRP2_DocumentFrameBoutonSuiv:Hide();
	TRP2_DocumentFrameBoutonPrec:Hide();
	
	local pagination = {};
	local pagetotal = 0;
	local pagipage = {};
	
	if infoTab then
		for pageNum,tab in pairs(infoTab) do
			if string.find(pageNum,"Page%d%d%d") then
				pagipage[#pagipage+1] = string.match(pageNum,"Page(%d%d%d)");
				pagetotal = pagetotal + 1;
			end
		end
		table.sort(pagipage);
		--TRP2_Montre(pagipage);
		for k,pageNum in pairs(pagipage) do
			pagination[pageNum] = k;
		end
		--TRP2_Montre(pagination);
	end
	
	if pagination[TRP2_CompleteThis(page,3)] then
		if pagipage[pagination[TRP2_CompleteThis(page,3)]-1] then
			TRP2_DocumentFrameBoutonPrec:Show();
			TRP2_DocumentFrameBoutonPrec:SetScript("OnClick",function()
				TRP2_ChargerDocument(infoTab,tonumber(pagipage[pagination[TRP2_CompleteThis(page,3)]-1]),id,nil,true);
			end);
		end
		if pagipage[pagination[TRP2_CompleteThis(page,3)]+1] then
			TRP2_DocumentFrameBoutonSuiv:Show();
			TRP2_DocumentFrameBoutonSuiv:SetScript("OnClick",function()
				TRP2_ChargerDocument(infoTab,tonumber(pagipage[pagination[TRP2_CompleteThis(page,3)]+1]),id,nil,true);
			end);
		end
	end
	
	if pagetotal < 2 then
		TRP2_DocumentFrameAuteur:SetText("");
	else
		TRP2_DocumentFrameAuteur:SetText(TRP2_CTS(TRP2_FT(TRP2_LOC_DOC_PAGE.." %1/%2",pagination[TRP2_CompleteThis(page,3)],pagetotal)));
	end
	
	TRP2_DocumentFrame.Page = page;
	TRP2_DocumentFrame.Id = id;
	TRP2_DocumentFrame:Show();
end

TRP2_DocumentFont = {
	"Friz",
	"Fonts\\FRIZQT__.TTF",
	"Arial",
	"Fonts\\ARIALN.TTF",
	"Skurri",
	"Fonts\\skurri.ttf",
	"Morpheus",
	"Fonts\\MORPHEUS.ttf",
	"Courrier New",
	"Interface\\AddOns\\totalRP2_Documents\\Fonts\\cour.ttf",
	"AnkeCall",
	"Interface\\AddOns\\totalRP2_Documents\\Fonts\\AnkeCall.ttf",
	"AquilineTwo",
	"Interface\\AddOns\\totalRP2_Documents\\Fonts\\AquilineTwo.ttf",
	"ArgPriht",
	"Interface\\AddOns\\totalRP2_Documents\\Fonts\\ArgPriht.ttf",
	"beneg___",
	"Interface\\AddOns\\totalRP2_Documents\\Fonts\\beneg___.ttf",
	"BlackNight",
	"Interface\\AddOns\\totalRP2_Documents\\Fonts\\BlackNight.ttf",
	"OldLondon",
	"Interface\\AddOns\\totalRP2_Documents\\Fonts\\OldLondon.ttf",
	"RAPSCALL",
	"Interface\\AddOns\\totalRP2_Documents\\Fonts\\RAPSCALL.ttf",
	"Saint-Andrews-Queen",
	"Interface\\AddOns\\totalRP2_Documents\\Fonts\\Saint-Andrews-Queen.ttf",
	"Inga-Stone-Signs",
	"Interface\\AddOns\\totalRP2_Documents\\Fonts\\Inga-Stone-Signs.ttf",
	"AZTEC",
	"Interface\\AddOns\\totalRP2_Documents\\Fonts\\AZTEC___.ttf",
	"tngani",
	"Interface\\AddOns\\totalRP2_Documents\\Fonts\\tngani.ttf",
	"RUNE",
	"Interface\\AddOns\\totalRP2_Documents\\Fonts\\RUNE.ttf",
	"HaraldRunic",
	"Interface\\AddOns\\totalRP2_Documents\\Fonts\\HaraldRunic.ttf",
	"ALPMAGI",
	"Interface\\AddOns\\totalRP2_Documents\\Fonts\\ALPMAGI.ttf",
	"FanjLeod",
	"Interface\\AddOns\\totalRP2_Documents\\Fonts\\FanjLeod.ttf",
	"RunesThe_elder_scroll",
	"Interface\\AddOns\\totalRP2_Documents\\Fonts\\RunesThe_elder_scroll.ttf",
	"EasyCuneiform",
	"Interface\\AddOns\\totalRP2_Documents\\Fonts\\EasyCuneiform.ttf",
}

--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- PANNEAUX D'AFFICHAGE
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

-- Détection d'un panneau
function TRP2_DetectAndGetPanneau(force)
	-- Sécurité : indisponible si Carte ouverte !!!
	if not TRP2_CanPlanqueHere(force) then
		return nil;
	end
	return TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Panneau"][TRP2_GetPlanqueID(force)];
end

--Delete panneau
function TRP2_DeletePanneau(fonction)
	if TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Panneau"][TRP2InventaireFramePanneau.panneauID] then
		StaticPopupDialogs["TRP2_CONFIRM_ACTION_NS"].text = TRP2_CTS(TRP2_ENTETE..TRP2_LOC_DELPANNEAUTT);
		TRP2_ShowStaticPopup("TRP2_CONFIRM_ACTION_NS",nil,function()
			TRP2_Afficher("{j}"..TRP2_FT(TRP2_LOC_DELETE_PANNEAU,"{o}"..TRP2_GetWithDefaut(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Panneau"][TRP2InventaireFramePanneau.panneauID],"Nom",TRP2_LOC_NEWPANNEAU).."{j}"));
			wipe(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Panneau"][TRP2InventaireFramePanneau.panneauID]);
			TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Panneau"][TRP2InventaireFramePanneau.panneauID] = nil;
			if fonction then
				fonction();
			end
			TRP2InventaireFramePanneau:Hide();
		end);
	end
end

--Edit panneau
function TRP2_EditPanneau(fonction)
	local panneauTab = {};
	TRP2InventaireFramePanneau:Hide();
	TRP2_CreationPanneauFrameTitle:SetText(TRP2_CTS("{w}"..TRP2_LOC_MODIFPANNEAU));
	TRP2_tcopy(panneauTab,TRP2InventaireFramePanneau.panneauTab);
	TRP2_CreationPanneauFrame:Show();
	TRP2_CreationPanneauFramePublic:SetChecked(TRP2_GetWithDefaut(panneauTab,"bPublic",true));
	TRP2_CreationPanneauFrameNom:SetText(TRP2_GetWithDefaut(panneauTab,"Nom",TRP2_LOC_NEWPLANQUE));
	TRP2_CreationPanneauFrameAccessNomsScrollEditBox:SetText(TRP2_GetWithDefaut(panneauTab,"AccessNom",""));
	TRP2_CreationPanneauFrameAccessLevel.Value = TRP2_GetWithDefaut(panneauTab,"Access",3);
	TRP2_CreationPanneauFrameAccessLevelValeur:SetText(TRP2_LOC_AccessTab[TRP2_GetWithDefaut(panneauTab,"Access",3)]);
	TRP2_CreationPanneauFrameIconeIcon:SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(TRP2_GetDocumentInfo(TRP2_GetWithDefaut(panneauTab,"documentID","DOC00010")),"Icone","Temp"));
	TRP2_CreationPanneauFrameIcone.Arg = TRP2_GetWithDefaut(panneauTab,"documentID","DOC00010");
	TRP2_CreationPanneauFrameSave:SetScript("OnClick",function()
		panneauTab["bPublic"] = TRP2_NilToDefaut(TRP2_CreationPanneauFramePublic:GetChecked() == 1,false);
		panneauTab["Nom"] = TRP2_EmptyToNil(TRP2_CreationPanneauFrameNom:GetText());
		panneauTab["AccessNom"] = TRP2_EmptyToNil(TRP2_CreationPanneauFrameAccessNomsScrollEditBox:GetText());
		panneauTab["Access"] = TRP2_DefautToNil(TRP2_CreationPanneauFrameAccessLevel.Value,3);
		panneauTab["documentID"] = TRP2_CreationPanneauFrameIcone.Arg;
		TRP2_CreerPanneau(TRP2_GetWithDefaut(panneauTab,"Nom",TRP2_LOC_NEWPANNEAU),panneauTab,TRP2InventaireFramePanneau.panneauID,true);
		TRP2_CreationPanneauFrame:Hide();
		if fonction then
			fonction();
		end
	end);
end

-- Création d'un panneau : étape 1
function TRP2_ConstructPanneau()
	TRP2_SearchPanneauListe:Hide();
	SetMapToCurrentZone();
	local zoneNum = TRP2_GetCurrentMapZone();
	local x,y = GetPlayerMapPosition("player");
	x = math.floor(x * TRP2_PrecisionPlanque);
	y = math.floor(y * TRP2_PrecisionPlanque);
	local ID = tostring(zoneNum).." "..tostring(x).." "..tostring(y);
	
	if TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Panneau"][ID] then
		TRP2_Error(TRP2_LOC_ALREADY_PANNEAU);
	elseif not TRP2_CanPlanqueHere(true) then
		TRP2_Error(TRP2_LOC_CANTPLANQUEHERE);
	else
		local panneauTab = {};
		TRP2_CreationPanneauFrameTitle:SetText(TRP2_CTS("{w}"..TRP2_LOC_CREATEPANNEAU));
		panneauTab["Zone"] = GetZoneText();
		panneauTab["SousZone"] = GetSubZoneText();
		panneauTab["ZoneNum"] = zoneNum;
		panneauTab["CoordX"] = x;
		panneauTab["CoordY"] = y;
		TRP2_CreationPanneauFrame:Show();
		TRP2_CreationPanneauFramePublic:SetChecked(true);
		TRP2_CreationPanneauFrameNom:SetText(TRP2_LOC_NEWPANNEAU);
		TRP2_CreationPanneauFrameAccessNomsScrollEditBox:SetText("");
		TRP2_CreationPanneauFrameAccessLevel.Value = 3;
		TRP2_CreationPanneauFrameAccessLevelValeur:SetText(TRP2_LOC_AccessTab[3]);
		TRP2_CreationPanneauFrameIcone.Arg = "DOC00010";
		TRP2_CreationPanneauFrameIconeIcon:SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(TRP2_GetDocumentInfo("DOC00010"),"Icone","Temp"));
		TRP2_CreationPanneauFrameSave:SetScript("OnClick",function()
			panneauTab["bPublic"] = TRP2_NilToDefaut(TRP2_CreationPanneauFramePublic:GetChecked() == 1,false);
			panneauTab["Nom"] = TRP2_EmptyToNil(TRP2_CreationPanneauFrameNom:GetText());
			panneauTab["AccessNom"] = TRP2_EmptyToNil(TRP2_CreationPanneauFrameAccessNomsScrollEditBox:GetText());
			panneauTab["Access"] = TRP2_DefautToNil(TRP2_CreationPanneauFrameAccessLevel.Value,3);
			panneauTab["documentID"] = TRP2_CreationPanneauFrameIcone.Arg;
			TRP2_CreerPanneau(TRP2_GetWithDefaut(panneauTab,"Nom",TRP2_LOC_NEWPANNEAU),panneauTab,ID);
			TRP2_CreationPanneauFrame:Hide();
		end);
	end
end

-- Création d'un Panneau : étape 2, finition
function TRP2_CreerPanneau(Nom,panneauTab,ID,bEdit)
	if panneauTab then
		TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Panneau"][ID] = {};
		TRP2_tcopy(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Panneau"][ID],panneauTab);
		if bEdit then
			TRP2_Afficher("{j}"..TRP2_FT(TRP2_LOC_MODIF_PANNEAU,"{o}"..TRP2_GetWithDefaut(panneauTab,"Nom",TRP2_LOC_NEWPANNEAU).."{j}"));
		else
			TRP2_Afficher("{j}"..TRP2_FT(TRP2_LOC_CREATE_PANNEAU,"{o}"..TRP2_GetWithDefaut(panneauTab,"Nom",TRP2_LOC_NEWPANNEAU).."{j}"));
		end
		if TRP2_GetPlanqueID(true) == ID and not bEdit then
			TRP2_ShowPanneau(TRP2_Joueur,ID);
		end
	end
end

-- Montre panneau
function TRP2_ShowPanneau(Nom,panneauID)
	if not Nom or not panneauID or TRP2_GetPlanqueID(true) ~= panneauID then
		TRP2InventaireFramePanneau:Hide();
		return;
	end

	local panneau;
	local docuTab;
	
	-- Definition du tableau panneau
	if Nom == TRP2_Joueur then
		panneau = TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Panneau"][panneauID];
		TRP2InventaireFramePanneauEdit:Show();
	elseif TRP2_Panneaux[Nom] and TRP2_Panneaux[Nom]["ID"] == panneauID then
		panneau = TRP2_Panneaux[Nom];
		TRP2InventaireFramePanneauEdit:Hide();
	else
		return;
	end
	if not panneau then
		TRP2InventaireFramePanneau:Hide();
		return;
	end
	
	-- Definition du tableau document
	-- Affichage direct si : Soit c'est nous le peye, soit c'est un document DB, soit il est connu et à jour.
	local docuID = TRP2_GetWithDefaut(panneau,"documentID","DOC00010");
	if Nom == TRP2_Joueur or string.len(docuID) ~= TRP2_IDSIZE or
		(TRP2_GetDocumentInfo(docuID) ~= nil and TRP2_GetDocumentInfo(docuID)["VerNum"] >= TRP2_Panneaux[Nom]["Docu-VerNum"]) then
		docuTab = TRP2_GetDocumentInfo(docuID);
		-- Clickage du document
		TRP2InventaireFramePanneauSlot:SetScript("OnClick", function(self)
			TRP2InventaireFramePanneau:Hide();
			TRP2_ChargerDocument(docuTab);
		end);
	else
		docuTab = {
			Nom = TRP2_Panneaux[Nom]["Docu-Nom"],
			Icone = TRP2_Panneaux[Nom]["Docu-Icone"],
			Size = TRP2_Panneaux[Nom]["Docu-Size"],
			VerNum = TRP2_Panneaux[Nom]["Docu-VerNum"]
		};
		TRP2InventaireFramePanneau.docuSize = docuTab.Size;
		-- Clickage du document
		TRP2InventaireFramePanneauSlot:SetScript("OnClick", function(self)
			-- Download
			TRP2_OpenRequestForObject(docuID,Nom);
			TRP2InventaireFramePanneauLoadingFrame.TimeSinceLastUpdate = 10;
			TRP2InventaireFramePanneauLoadingFrame:Show();
		end);
	end

	TRP2_SearchPanneauListe:Hide();
	TRP2_CreationPanneauFrame:Hide();
	TRP2InventaireFramePanneauLoadingFrame:Hide();
	-- Nom
	TRP2InventaireFramePanneauNomText:SetText(TRP2_CTS("{w}"..TRP2_GetWithDefaut(panneau,"Nom",TRP2_LOC_NEWPANNEAU)));
	-- Tooltip du header
	TRP2_SetTooltipForFrame(TRP2InventaireFramePanneauHeaderButton,TRP2InventaireFramePanneauHeaderButton,"TOP",0,0,
		TRP2_GetPanneauHeaderTooltip(panneau,Nom));
	TRP2InventaireFramePanneauSlotIcon:SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(docuTab,"Icone","Temp"));
	-- Dejà vu ?
	if true then
		TRP2InventaireFramePanneauSlotQuest:Hide();
	else
		TRP2InventaireFramePanneauSlotQuest:Show();
	end
	-- Tooltip du document
	TRP2_SetTooltipForFrame(TRP2InventaireFramePanneauSlot,TRP2InventaireFramePanneauSlot,"RIGHT",0,0,
		TRP2_GetPanneauDocumentTooltip(docuTab,TRP2_GetWithDefaut(panneau,"documentID","DOC00010")));

	TRP2InventaireFramePanneau.panneauTab = panneau;
	TRP2InventaireFramePanneau.panneauID = panneauID;
	TRP2InventaireFramePanneau.panneauNom = Nom;
	TRP2InventaireFramePanneau.docuID = docuID;
	
	TRP2InventaireFramePanneau:Show();
end

-- Mise à jour du loading bar
function TRP2_PanneauLoadingBar(owner,documentID,documentSize)
	if TRP2_SynchronisedTab[owner] and TRP2_SynchronisedTab[owner][documentID] then
		local size = #TRP2_SynchronisedTab[owner][documentID];
		local rapport = math.ceil((size/documentSize)*100);
		TRP2InventaireFramePanneauLoadingText:SetText(TRP2_CTS("{w}"..TRP2_LOC_Downloading.." : ".." : {w}"..rapport.."%"));
		TRP2InventaireFramePanneauLoadingBarProgress:SetWidth(145*(rapport/100));
	else
		TRP2InventaireFramePanneau:Hide();
		TRP2_ChargerDocument(TRP2_GetDocumentInfo(documentID));
	end
end

-- Tooltip du document d'un panneau
function TRP2_GetPanneauDocumentTooltip(tab,panneauID)
	if tab then
		local Titre = "{w}|TInterface\\ICONS\\"..TRP2_GetWithDefaut(tab,"Icone","Temp")..".blp:35:35|t ".."{w}"..TRP2_GetWithDefaut(tab,"Nom",TRP2_LOC_CreationTypeDoc);
		local Suite = "";
		
		local myVersion = TRP2_GetDocumentInfo(panneauID);
		if not myVersion then
			local temps 
			if TRP2_GetWithDefaut(tab,"Size",0) > 17 then
				temps = math.ceil((TRP2_GetWithDefaut(tab,"Size",0)-16)/3);
				temps = TRP2_TimeToString(temps);
			else
				temps = SPELL_CAST_TIME_INSTANT_NO_MANA;
			end
			Suite = "{o}"..TRP2_LOC_MESSNUM.." : {w}"..TRP2_GetWithDefaut(tab,"Size","0")
			.."\n\n{j}"..TRP2_LOC_HAVETODOWNLOADDOCU.."\n"
			.."\n{o}"..TRP2_LOC_ESTIMATIONTRANSF.." : {w}"..temps
			.."\n{j}"..TRP2_LOC_ESTIMATIONTT.."\n\n";
		elseif TRP2_GetWithDefaut(myVersion,"VerNum",0) < TRP2_GetWithDefaut(tab,"VerNum",0) then
			local temps 
			if TRP2_GetWithDefaut(tab,"Size",0) > 17 then
				temps = math.ceil((TRP2_GetWithDefaut(tab,"Size",0)-16)/3);
				temps = TRP2_TimeToString(temps);
			else
				temps = SPELL_CAST_TIME_INSTANT_NO_MANA;
			end
			Suite = "{o}"..TRP2_LOC_MESSNUM.." : {w}"..TRP2_GetWithDefaut(tab,"Size","0")
			.."\n\n{j}"..TRP2_LOC_HAVETOUPDATEDOCU.."\n"
			.."\n{o}"..TRP2_LOC_ESTIMATIONTRANSF.." : {w}"..temps
			.."\n{j}"..TRP2_LOC_ESTIMATIONTT.."\n\n";
		end
		
		-- Dejà vu ?
		if not true then
			Suite = Suite.."{v}< "..TRP2_LOC_PASENCORELU.." >\n\n";
		end
		
		Suite = Suite.."{j}"..TRP2_LOC_CLIC.." : {w}"..TRP2_LOC_READDOCU;
		
		return Titre, Suite;
	end
end

-- Tooltip du header button d'un panneau
function TRP2_GetPanneauHeaderTooltip(tab, owner)
	if tab then
		local Titre = "{w}"..TRP2_GetWithDefaut(tab,"Nom",TRP2_LOC_NEWPANNEAU);
		local Suite = "{j}"..TRP2_LOC_OWNER.." : {w}"..owner.."\n{o}< "..TRP2_GetWithDefaut(tab,"Zone","").." >\n";
		if TRP2_EmptyToNil(TRP2_GetWithDefaut(tab,"SousZone")) then
			Suite = Suite.."{o}< "..TRP2_GetWithDefaut(tab,"SousZone").." >\n";
		end
		if TRP2_EmptyToNil(TRP2_GetWithDefaut(tab,"bPublic")) then
			Suite = Suite.."\n{v}< "..TRP2_LOC_PANNEAUPUBLIC.." >\n";
		end
		Suite = Suite.."\n{j}"..TRP2_LOC_COORD.." :\n{w}< "..TRP2_GetWithDefaut(tab,"CoordX",0).." - "..TRP2_GetWithDefaut(tab,"CoordY",0).." >";
		return Titre, Suite;
	end
end

-- Liste de NOS panneaux : 1
function TRP2_LoadPanneauList()
	local i = 0; -- Nombre total
	local j = 0; -- Nombre pris
	TRP2_PanneauListeSlider:Hide();
	TRP2_PanneauListeSlider:SetValue(0);
	wipe(TRP2_PanneauList);
	
	for k,v in pairs(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Panneau"]) do
		i = i + 1;
		j = j + 1;
		TRP2_PanneauList[j] = k;
	end
	
	table.sort(TRP2_PanneauList);

	if j > 0 then
		TRP2_PanneauListeEmpty:SetText("");
	elseif i == 0 then
		TRP2_PanneauListeEmpty:SetText(TRP2_LOC_NOPANNEAU);
	else
		TRP2_PanneauListeEmpty:SetText(TRP2_LOC_SelectVide);
	end
	if j > 42 then
		TRP2_PanneauListeSlider:Show();
		local total = floor((j-1)/49);
		TRP2_PanneauListeSlider:SetMinMaxValues(0,total);
	end
	TRP2_PanneauListeSlider:SetScript("OnValueChanged",function(self)
		if self:IsVisible() then
			TRP2_LoadPanneauListPage(self:GetValue());
		end
	end)
	TRP2_LoadPanneauListPage(0);
end

-- Liste de nos panneaux : 2
function TRP2_LoadPanneauListPage(num)
	for k=1,49,1 do --Initialisation
		getglobal("TRP2_PanneauListeSlot"..k):Hide();
	end
	local i = 1;
	local j = 1;
	table.foreach(TRP2_PanneauList,
	function(TabIndex)
		if i > num*49 and i <= (num+1)*49 then
			local ID = TRP2_PanneauList[TabIndex];
			local panneauTab = TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Panneau"][ID];
			getglobal("TRP2_PanneauListeSlot"..j):Show();
			getglobal("TRP2_PanneauListeSlot"..j):SetScript("OnClick", function(self,button)
				TRP2InventaireFramePanneau:Hide();
				TRP2InventaireFramePanneau.panneauTab = panneauTab;
				TRP2InventaireFramePanneau.panneauID = ID;
				if button == "LeftButton" then
					TRP2_EditPanneau(function() TRP2_PanneauListe:Show() end);
					TRP2_PanneauListe:Hide();
				else
					TRP2_DeletePanneau(function() TRP2_PanneauListe:Show() end);
					TRP2_PanneauListe:Hide();
				end
			end);
			local titre,suite = TRP2_GetPanneauHeaderTooltip(panneauTab,TRP2_Joueur);
			TRP2_SetTooltipForFrame(
				getglobal("TRP2_PanneauListeSlot"..j),
				getglobal("TRP2_PanneauListeSlot"..j),"RIGHT",0,0,
				titre,suite.."\n\n{j}"..TRP2_LOC_CLIC.." : {w}"..TRP2_LOC_MODIFPANNEAU.."\n{j}"..TRP2_LOC_CLICDROIT.." : {w}"..TRP2_LOC_DELETEPANNEAU
			);
			j = j + 1;
		end
		i = i + 1;
	end);
end

-------------------
-- PANNEAUX DES AUTRES
-------------------

TRP2_Panneaux = {};

-- Demande de panneau sur le chan
function TRP2_StartSearchPanneau()
	wipe(TRP2_Panneaux);
	TRP2InventaireFramePanneau:Hide();
	TRP2_CreationPanneauFrame:Hide();
	TRP2_SearchPanneauListe:Show();
	TRP2_LoadSearchPanneauList();
	local ID = TRP2_GetPlanqueID(true);
	TRP2_SendContentToChannel({ID},"GetPanneau");
end

-- On recois une demande de panneau par le channel, et on regarde si on a un panneau à cet endroit.
function TRP2_ChanGetPanneau(sender,panneauID)
	-- Est ce que j'ai une planque ici ?
	local panneauTab = TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Panneau"][panneauID];
	if panneauTab then
		if TRP2_CheckPlanqueAccess(panneauTab,sender) then --Check de l'accès (même que pour les planques alors on recycle :)
			local Message = panneauID..TRP2_ReservedChar; -- 1 : ID
			Message = Message..TRP2_GetWithDefaut(panneauTab,"Nom",TRP2_LOC_NEWPANNEAU)..TRP2_ReservedChar; -- 2 : Nom du panneau
			Message = Message..TRP2_GetWithDefaut(panneauTab,"documentID","DOC00010")..TRP2_ReservedChar; -- 3 : ID du document
			-- Si document perso ...
			if string.len(TRP2_GetWithDefaut(panneauTab,"documentID","DOC00010")) == TRP2_IDSIZE then
				local docuTab = TRP2_GetDocumentInfo(TRP2_GetWithDefaut(panneauTab,"documentID","DOC00010"));
				Message = Message..TRP2_GetWithDefaut(docuTab,"Nom",TRP2_LOC_CreationTypeDoc)..TRP2_ReservedChar; -- 4 : Nom du document
				Message = Message..TRP2_GetWithDefaut(docuTab,"Icone","Temp")..TRP2_ReservedChar; -- 5 : Icone du document
				Message = Message..TRP2_GetWithDefaut(docuTab,"VerNum","0")..TRP2_ReservedChar; -- 6 : Vernum du document
				Message = Message..math.ceil(string.len(TRP2_Libs:Serialize(docuTab))/221); -- 7 : Taille du document
			end
			TRP2_SecureSendAddonMessage("PASI",Message,sender);
		end
	end
end

-- On reçois les info d'un panneau de la part de quelqu'un
function TRP2_PanneauReceiveInfo(sender,panneauTab)
	-- 1 : ID
	-- 2 : Nom du panneau
	-- 3 : ID document
	-- 4 : Nom du document
	-- 5 : Icone du document
	-- 6 : Vernum du document (number)
	-- 7 : Taille du document (number)
	SetMapToCurrentZone();
	local zoneNum = TRP2_GetCurrentMapZone();
	local x,y = GetPlayerMapPosition("player");
	x = math.floor(x * TRP2_PrecisionPlanque);
	y = math.floor(y * TRP2_PrecisionPlanque);
	local ID = tostring(zoneNum).." "..tostring(x).." "..tostring(y);
	if TRP2_SearchPanneauListe:IsVisible() and ID == panneauTab[1] then -- Si on a pas bougé
		if TRP2_Panneaux[sender] then
			wipe(TRP2_Panneaux[sender]);
		else
			TRP2_Panneaux[sender] = {};
		end
		TRP2_Panneaux[sender] = {};
		TRP2_Panneaux[sender]["Zone"] = GetZoneText();
		TRP2_Panneaux[sender]["SousZone"] = GetSubZoneText();
		TRP2_Panneaux[sender]["ZoneNum"] = zoneNum;
		TRP2_Panneaux[sender]["CoordX"] = x;
		TRP2_Panneaux[sender]["CoordY"] = y;
		TRP2_Panneaux[sender]["Nom"] = panneauTab[2];
		TRP2_Panneaux[sender]["documentID"] = panneauTab[3];
		-- Si document perso
		if string.len(panneauTab[3]) == TRP2_IDSIZE then
			TRP2_Panneaux[sender]["Docu-Nom"] = panneauTab[4];
			TRP2_Panneaux[sender]["Docu-Icone"] = panneauTab[5];
			TRP2_Panneaux[sender]["Docu-VerNum"] = tonumber(panneauTab[6]);
			TRP2_Panneaux[sender]["Docu-Size"] = tonumber(panneauTab[7]);
		end
		TRP2_Panneaux[sender]["ID"] = ID;
		TRP2_LoadSearchPanneauList();
	end
end

-- Liste des planques aux autres
function TRP2_LoadSearchPanneauList()
	local i = 0; -- Nombre total
	TRP2_SearchPanneauListeSlider:Hide();
	TRP2_SearchPanneauListeSlider:SetValue(0);
	wipe(TRP2_PanneauList);
	
	for k,v in pairs(TRP2_Panneaux) do
		i = i + 1;
		TRP2_PanneauList[i] = k;
	end
	
	table.sort(TRP2_PanneauList);

	if i > 0 then
		TRP2_SearchPanneauListeEmpty:SetText("");
	elseif i == 0 then
		TRP2_SearchPanneauListeEmpty:SetText(TRP2_LOC_NOPANNEAUHERE);
	end
	if i > 42 then
		TRP2_SearchPanneauListeSlider:Show();
		local total = floor((i-1)/49);
		TRP2_SearchPanneauListeSlider:SetMinMaxValues(0,total);
	end
	TRP2_SearchPanneauListeSlider:SetScript("OnValueChanged",function(self)
		if self:IsVisible() then
			TRP2_LoadSearchPanneauListPage(self:GetValue());
		end
	end)
	TRP2_LoadSearchPanneauListPage(0);
end

function TRP2_LoadSearchPanneauListPage(num)
	for k=1,49,1 do --Initialisation
		getglobal("TRP2_SearchPanneauListeSlot"..k):Hide();
	end
	local i = 1;
	local j = 1;
	table.foreach(TRP2_PanneauList,
	function(TabIndex)
		if i > num*49 and i <= (num+1)*49 then
			local Nom = TRP2_PanneauList[TabIndex]; -- Nom du joueur qui possède la planque
			local panneauTab = TRP2_Panneaux[Nom];
			getglobal("TRP2_SearchPanneauListeSlot"..j):Show();
			getglobal("TRP2_SearchPanneauListeSlot"..j):SetScript("OnClick", function()
				TRP2InventaireFramePanneau:Hide();
				TRP2_SearchPanneauListe:Hide();
				TRP2_ShowPanneau(Nom,TRP2_Panneaux[Nom]["ID"]);
			end);
			local titre,suite = TRP2_GetPanneauHeaderTooltip(panneauTab,Nom);
			TRP2_SetTooltipForFrame(
				getglobal("TRP2_SearchPanneauListeSlot"..j),
				getglobal("TRP2_SearchPanneauListeSlot"..j),"RIGHT",0,0,
				titre,suite.."\n\n{j}"..TRP2_LOC_CLIC.." : {w}"..TRP2_LOC_OPENPANNEAU
			);
			j = j + 1;
		end
		i = i + 1;
	end);
end

------------------------------
-- PANNEAU PUBLICS
------------------------------

TRP2_PanneauPositions = {};

-- Demande des coordonnées des panneaux sur la carte
function TRP2_GetLocalPanneaux()
	if TRP2_GetCurrentMapZone() < 1 then
		TRP2_Error(ERR_CLIENT_LOCKED_OUT);
		return;
	end
	
	local infoTab = {};
	infoTab[1] = TRP2_GetCurrentMapZone();
	TRP2_GetWorldMap().TRP2_Zone = infoTab[1];
	wipe(TRP2_PanneauPositions);
	TRP2_SendContentToChannel(infoTab,"GetLocalPanneauxCoord");
	TRP2_MapPanneauUpdate();
end

-- Envoie des données de nos panneaux
function TRP2_SendCoordonneesPanneau(sender,ZoneID)
	if sender and ZoneID then
		-- Pour chaque planque
		for panneauID,panneauTab in pairs(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Panneau"]) do
			-- Si la zone correspond
			if panneauTab["ZoneNum"] == tonumber(ZoneID) then
				-- Si elle est publique
				if TRP2_GetWithDefaut(panneauTab,"bPublic",true) then
					-- Si access
					if TRP2_CheckPlanqueAccess(panneauTab,sender) then
						local Message = panneauID..TRP2_ReservedChar;
						Message = Message..TRP2_GetWithDefaut(panneauTab,"CoordX","0")..TRP2_ReservedChar;
						Message = Message..TRP2_GetWithDefaut(panneauTab,"CoordY","0")..TRP2_ReservedChar;
						Message = Message..TRP2_GetWithDefaut(panneauTab,"Nom",TRP2_LOC_NEWPANNEAU);
						TRP2_SecureSendAddonMessage("SNPA",Message,sender);
					end
				end
			end
		end
	end
end

-- Ajout d'un panneau dans la liste
function TRP2_AddPanneauToMapTab(personnage,tab)
	if not TRP2_PanneauPositions[personnage] then
		TRP2_PanneauPositions[personnage] = {};
	end
	if not TRP2_PanneauPositions[personnage][tab[1]] then
		TRP2_PanneauPositions[personnage][tab[1]] = {};
	end
	TRP2_PanneauPositions[personnage][tab[1]]["x"] = tonumber(tab[2]);
	TRP2_PanneauPositions[personnage][tab[1]]["y"] = tonumber(tab[3]);
	TRP2_PanneauPositions[personnage][tab[1]]["name"] = tab[4];
	TRP2_MapPanneauUpdate();
end

-- Update de la map quand on recois un nouveau panneaux
function TRP2_MapPanneauUpdate()
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
	
	for personame, panneaux in pairs(TRP2_PanneauPositions) do
		for panneauID, panneauTab in pairs(panneaux) do
			i = i+1; -- Compteur de planque totale sur la carte
			-- Création du bouton si il n'existe pas
			local panneauButton = _G["TRP2_WordMapPlayer"..i];
			if not panneauButton then
				panneauButton = CreateFrame("Frame","TRP2_WordMapPlayer"..i,WorldMapButton,"WorldMapRaidUnitTemplate")
			end
			-- On adapte selon la taille de la carte
			local partyX = (panneauTab["x"]/TRP2_PrecisionPlanque) * WorldMapDetailFrame:GetWidth();
			local partyY = ((-panneauTab["y"])/TRP2_PrecisionPlanque) * WorldMapDetailFrame:GetHeight();
			-- Visuel du point
			_G["TRP2_WordMapPlayer"..i.."Icon"]:SetTexture("Interface\\Minimap\\POIICONS");
			_G["TRP2_WordMapPlayer"..i.."Icon"]:SetTexCoord(0.5, 0.57142, 0, 0.036);
			-- On place les info dans le bouton
			panneauButton.info = panneauTab;
			-- Tooltip
			panneauButton:SetPoint("CENTER", "WorldMapDetailFrame", "TOPLEFT", partyX, partyY);
			panneauButton:SetScript("OnEnter", function(self)
				WorldMapPOIFrame.allowBlobTooltip = false;
				local j=1;
				WorldMapTooltip:Hide();
				WorldMapTooltip:SetOwner(self, "ANCHOR_RIGHT",0,0);
				WorldMapTooltip:AddLine(TRP2_CTS("|TInterface\\ICONS\\TRADE_ARCHAEOLOGY_SKETCHDESERTPALACE:18:18|t "..TRP2_LOC_PANNEAUX.." :"), 1, 1, 1,true);
				while(_G["TRP2_WordMapPlayer"..j]) do
					if _G["TRP2_WordMapPlayer"..j]:IsVisible() and _G["TRP2_WordMapPlayer"..j]:IsMouseOver() then
						local info = _G["TRP2_WordMapPlayer"..j].info;
						if info then
							local icone = " |TInterface\\ICONS\\inv_misc_enchantedscroll:18:18|t";
							WorldMapTooltip:AddLine(TRP2_CTS(info["name"]..icone.." ("..panneauTab["x"]..","..panneauTab["y"]..")"), 1, 1, 1,true);
						end
					end
					j = j+1;
				end
				WorldMapTooltip:Show();
			end);
			panneauButton:SetScript("OnLeave", function()
				WorldMapPOIFrame.allowBlobTooltip = true;
				WorldMapTooltip:Hide();
			end);
			panneauButton:Show();
			tinsert(TRP2_MINIMAPBUTTON,1,panneauButton);
		end
	end
end

-- Affichage de NOS panneaux
function TRP2_ShowMinimapPanneau()
	TRP2_GetWorldMap().TRP2_Zone = TRP2_GetCurrentMapZone();
	local ID = TRP2_GetWorldMap().TRP2_Zone;
	-- On cache tout !
	local i = 1;
	while(getglobal("TRP2_WordMapPlayer"..i)) do
		getglobal("TRP2_WordMapPlayer"..i):Hide();
		i = i+1;
	end
	i = 0;
	for panneauID,panneauTab in pairs(TRP2_Module_Inventaire[TRP2_Royaume][TRP2_Joueur]["Panneau"]) do
		if string.find(panneauID,"^"..ID) then
			i = i+1;
			local panneauButton = _G["TRP2_WordMapPlayer"..i];
			local partyX = TRP2_GetWithDefaut(panneauTab,"CoordX",0)/TRP2_PrecisionPlanque;
			local partyY = TRP2_GetWithDefaut(panneauTab,"CoordY",0)/TRP2_PrecisionPlanque;
			if not panneauButton then
				panneauButton = CreateFrame("Frame","TRP2_WordMapPlayer"..i,WorldMapButton,"WorldMapRaidUnitTemplate")
			end
			partyX = partyX * WorldMapDetailFrame:GetWidth();
			partyY = -partyY * WorldMapDetailFrame:GetHeight();
			_G["TRP2_WordMapPlayer"..i.."Icon"]:SetTexture("Interface\\Minimap\\POIICONS");
			_G["TRP2_WordMapPlayer"..i.."Icon"]:SetTexCoord(0.5, 0.57142, 0, 0.036);
			-- Info
			local titre, suite = TRP2_GetPanneauHeaderTooltip(panneauTab,TRP2_Joueur);
			panneauButton.titre = "|TInterface\\ICONS\\inv_misc_enchantedscroll:18:18|t "..titre;
			panneauButton.suite = suite;
			-- Tooltip
			panneauButton:SetPoint("CENTER", "WorldMapDetailFrame", "TOPLEFT", partyX, partyY);
			panneauButton:SetScript("OnEnter", function(self)
				WorldMapPOIFrame.allowBlobTooltip = false;
				local j=1;
				WorldMapTooltip:Hide();
				WorldMapTooltip:SetOwner(self, "ANCHOR_RIGHT",0,0);
				while(_G["TRP2_WordMapPlayer"..j]) do
					if _G["TRP2_WordMapPlayer"..j]:IsVisible() and _G["TRP2_WordMapPlayer"..j]:IsMouseOver() then
						WorldMapTooltip:AddLine(TRP2_CTS(_G["TRP2_WordMapPlayer"..j].titre), 1, 1, 1,true);
						WorldMapTooltip:AddLine(TRP2_CTS(_G["TRP2_WordMapPlayer"..j].suite), 1, 1, 1,true);
					end
					j = j+1;
				end
				WorldMapTooltip:Show();
			end);
			panneauButton:Show();
			tinsert(TRP2_MINIMAPBUTTON,1,panneauButton);
			panneauButton:SetScript("OnLeave", function()
				WorldMapPOIFrame.allowBlobTooltip = true;
				WorldMapTooltip:Hide();
			end);
		end
	end
end