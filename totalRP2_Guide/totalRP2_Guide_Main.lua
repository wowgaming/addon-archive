-------------------------------------------------------------------
--                          Total RP 2
--            A roleplay addon for World of Warcraft
-- Created by Sylvain "Telkostrasz" Cossement (up to version 1.017)
--   Licence : CC BY-NC-SA (http://creativecommons.org/licenses/)
-------------------------------------------------------------------

TRP2_Guide_HasBeenInit = false;
TRP2_GUIDE_MAXHISTORY = 10;

function TRP2_Guide_Init()
	if TRP2_Guide_HasBeenInit then return end
	TRP2_Guide_HasBeenInit = true;
	if not TRP2_Module_Guide then
		TRP2_Module_Guide = {};
	end
end

function TRP2_Guide_OpenPage(page,direct,bCanHide,url)
	if page and string.find(page,"%.") then
		TRP2_Histolink(page,url);
		return;
	end


	local i;
	local pageTab;
	TRP2_Guide_Init();
	for i=1,TRP2_GUIDE_MAXHISTORY,1 do
		getglobal("TRP2_GuideFrameHist"..i):Hide();
		getglobal("TRP2_GuideFrameHist"..i):Enable();
		getglobal("TRP2_GuideFrameHist"..i.."Icon"):SetDesaturated(false);
	end
	if not page then page="Principale" end
	
	if bCanHide then
		TRP2_GuideFrameTexteA:Hide();
		TRP2_GuideFrameTexteB:Hide();
	end
	
	if TRP2_GuideFrame.mode == "A" then
		TRP2_GuideFrame.mode = "B";
	else
		TRP2_GuideFrame.mode = "A";
	end
	
	--TRP2_debug(page.." "..TRP2_GuideFrame.mode);
	
	_G["TRP2_GuideFrameTexte"..TRP2_GuideFrame.mode]:Show();
	
	if page == "Index" then -- Index
		local texte = "<h2 align=\"center\">"..TRP2_LOC_GUI_Table.."</h2><p align=\"center\">";
		texte = texte.."<br/><a href=\"Merci\">{v}["..TRP2_LOC_GUI_MErci.."]</a><br/></p><p><br/>";
		for i=1,#TRP2_GUIDE_INDEX,1 do
			local indexPage = TRP2_GUIDE_INDEX[i][1];
			local indexNum = TRP2_GUIDE_INDEX[i][2];
			local titre = TRP2_GetWithDefaut(TRP2_GUIDES_PAGES[indexPage],"Titre","{r}"..indexPage);
			if TRP2_Module_Guide[indexPage] then
				texte = texte.."<a href=\""..indexPage.."\">"..indexNum..") ["..titre.."]|r</a><br/>";
			else
				texte = texte.."<a href=\""..indexPage.."\">"..indexNum..") ["..titre.."] {o}(!)|r</a><br/>";
			end
		end
		texte = texte.."<br/><br/></p>";
		_G["TRP2_GuideFrameTexte"..TRP2_GuideFrame.mode]:SetText(TRP2_CTS("<html><body>"..texte.."</body></html>"));
		SetPortraitToTexture(TRP2_GuideFramePortrait,"Interface\\ICONS\\INV_Misc_Note_01");
	elseif TRP2_GUIDES_PAGES[page] then
		pageTab = TRP2_GUIDES_PAGES[page];
		_G["TRP2_GuideFrameTexte"..TRP2_GuideFrame.mode]:SetText(TRP2_ConvertToHTML(pageTab["Texte"]));
		if not TRP2_IsInHistory(page) then -- Placement dans l'historique
			if #TRP2_Module_Interface["History"] < TRP2_GUIDE_MAXHISTORY then
				tinsert(TRP2_Module_Interface["History"],1,page);
			else
				tremove(TRP2_Module_Interface["History"],TRP2_GUIDE_MAXHISTORY);
				tinsert(TRP2_Module_Interface["History"],1,page);
			end
		end
		--Icone
		SetPortraitToTexture(TRP2_GuideFramePortrait,"Interface\\ICONS\\"..TRP2_GetWithDefaut(pageTab,"Icone","INV_Misc_QuestionMark"));
	else
		_G["TRP2_GuideFrameTexte"..TRP2_GuideFrame.mode]:SetText(TRP2_ConvertToHTML(TRP2_GUIDES_PAGES["404"]["Texte"]));
		SetPortraitToTexture(TRP2_GuideFramePortrait,"Interface\\ICONS\\INV_Misc_Note_01");
	end
	TRP2_GuideFrameScroll:SetVerticalScroll(0);
	
	-- Historique
	for i=1,#TRP2_Module_Interface["History"],1 do
		pageTab = TRP2_GUIDES_PAGES[TRP2_Module_Interface["History"][i]];
		getglobal("TRP2_GuideFrameHist"..i):Show();
		getglobal("TRP2_GuideFrameHist"..i.."Icon"):SetTexture("Interface\\ICONS\\"..TRP2_GetWithDefaut(pageTab,"Icone","INV_Misc_QuestionMark"));
		if TRP2_Module_Interface["History"][i] == page then
			getglobal("TRP2_GuideFrameHist"..i):Disable();
			getglobal("TRP2_GuideFrameHist"..i.."Icon"):SetDesaturated(true);
		end
		getglobal("TRP2_GuideFrameHist"..i):SetScript("OnClick",function()
			TRP2_Guide_OpenPage(TRP2_Module_Interface["History"][i],false,true);
		end);
		TRP2_SetTooltipForFrame(getglobal("TRP2_GuideFrameHist"..i),getglobal("TRP2_GuideFrameHist"..i),"TOP",0,0,TRP2_GetWithDefaut(pageTab,"Titre",TRP2_LOC_GUI_NoPage));
	end
	
	TRP2_Module_Guide[page] = true;
	
	TRP2_GuideFrame.Page = page;
	TRP2_GuideFrame:Show();
end

function TRP2_IsInHistory(page)
	local i;
	for i=1,#TRP2_Module_Interface["History"],1 do
		if TRP2_Module_Interface["History"][i] == page then
			return true;
		end
	end
	return false;
end