

local TourGuide = TourGuide
local L = TourGuide.Locale
local GAP = 8
local tekcheck = LibStub("tekKonfig-Checkbox")
local tekbutton = LibStub("tekKonfig-Button")


local frame = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
TourGuide.configpanel = frame
frame.name = "Tour Guide"
frame:Hide()
frame:SetScript("OnShow", function()
	local title, subtitle = LibStub("tekKonfig-Heading").new(frame, "Tour Guide", L["These settings are saved on a per-char basis."])

	local qtrack = tekcheck.new(frame, nil, L["Automatically track quests"], "TOPLEFT", subtitle, "BOTTOMLEFT", -2, -GAP)
	qtrack.tiptext = L["Automatically toggle the default quest tracker for current 'complete quest' objectives."]
	local checksound = qtrack:GetScript("OnClick")
	qtrack:SetScript("OnClick", function(self) checksound(self); TourGuide.db.char.trackquests = not TourGuide.db.char.trackquests end)
	qtrack:SetChecked(TourGuide.db.char.trackquests)


	local showstatusframe = tekcheck.new(frame, nil, L["Show status frame"], "TOPLEFT", qtrack, "BOTTOMLEFT", 0, -GAP)
	showstatusframe.tiptext = L["Display the status frame with current quest objective."]
	showstatusframe:SetScript("OnClick", function(self) checksound(self); TourGuide.db.char.showstatusframe = not TourGuide.db.char.showstatusframe; TourGuide:PositionStatusFrame() end)
	showstatusframe:SetChecked(TourGuide.db.char.showstatusframe)

	local resetpos = tekbutton.new_small(frame, "TOP", showstatusframe, "CENTER", 0, 11)
	resetpos:SetPoint("RIGHT", -16, 0)
	resetpos:SetText(L["Reset"])
	resetpos.tiptext = L["Reset the status frame to the default position"]
	resetpos:SetScript("OnClick", function(self)
		TourGuide.db.profile.statusframepoint, TourGuide.db.profile.statusframex, TourGuide.db.profile.statusframey = nil
		TourGuide:PositionStatusFrame()
	end)


	local showuseitem = tekcheck.new(frame, nil, L["Show item button"], "TOPLEFT", showstatusframe, "BOTTOMLEFT", 0, -GAP)
	showuseitem.tiptext = L["Display a button when you must use an item to start or complete a quest."]
	showuseitem:SetChecked(TourGuide.db.char.showuseitem)

	local resetpos2 = tekbutton.new_small(frame, "TOP", showuseitem, "CENTER", 0, 11)
	resetpos2:SetPoint("RIGHT", -16, 0)
	resetpos2:SetText(L["Reset"])
	resetpos2.tiptext = L["Reset the item button to the default position"]
	resetpos2:SetScript("OnClick", function(self)
		TourGuide.db.profile.itemframepoint, TourGuide.db.profile.itemframex, TourGuide.db.profile.itemframey = nil
		TourGuide:PositionItemFrame()
	end)

	local showuseitemcomplete, showuseitemcompletelabel = tekcheck.new(frame, nil, L["Show buttom for 'complete' objectives"], "TOPLEFT", showuseitem, "BOTTOMLEFT", GAP*2, -GAP)
	showuseitemcomplete.tiptext = L["The advanced quest tracker in the default UI will show these items.  Enable this if you would rather have TourGuide's button."]
	showuseitemcomplete:SetScript("OnClick", function(self) checksound(self); TourGuide.db.char.showuseitemcomplete = not TourGuide.db.char.showuseitemcomplete; TourGuide:UpdateStatusFrame() end)
	showuseitemcomplete:SetChecked(TourGuide.db.char.showuseitemcomplete)
	if TourGuide.db.char.showuseitem then
		showuseitemcomplete:Enable()
		showuseitemcompletelabel:SetFontObject(GameFontHighlight)
	else
		showuseitemcomplete:Disable()
		showuseitemcompletelabel:SetFontObject(GameFontDisable)
	end

	showuseitem:SetScript("OnClick", function(self)
		checksound(self)
		TourGuide.db.char.showuseitem = not TourGuide.db.char.showuseitem
		TourGuide:UpdateStatusFrame()
		if TourGuide.db.char.showuseitem then
			showuseitemcomplete:Enable()
			showuseitemcompletelabel:SetFontObject(GameFontHighlight)
		else
			showuseitemcomplete:Disable()
			showuseitemcompletelabel:SetFontObject(GameFontDisable)
		end
	end)


	local mapnotecoords = tekcheck.new(frame, nil, L["Map note coords"], "TOPLEFT", showuseitemcomplete, "BOTTOMLEFT", -GAP*2, -GAP)
	mapnotecoords.tiptext = L["Map coordinates found in tooltip notes (requires TomTom)."]
	mapnotecoords:SetScript("OnClick", function(self) checksound(self); TourGuide.db.char.mapnotecoords = not TourGuide.db.char.mapnotecoords end)
	mapnotecoords:SetChecked(TourGuide.db.char.mapnotecoords)

	local mapquestgivers = tekcheck.new(frame, nil, L["Automatically map questgivers"], "TOPLEFT", mapnotecoords, "BOTTOMLEFT", 0, -GAP)
	mapquestgivers.tiptext = L["Automatically map questgivers for accept and turnin objectives (requires LightHeaded and TomTom)."]
	mapquestgivers:SetChecked(TourGuide.db.char.mapquestgivers)

	local mapquestgivernotes, mapquestgivernoteslabel = tekcheck.new(frame, nil, L["Always map coords from notes"], "TOPLEFT", mapquestgivers, "BOTTOMLEFT", GAP*2, -GAP)
	mapquestgivernotes.tiptext = L["Map note coords even when LightHeaded provides coords."]
	mapquestgivernotes:SetScript("OnClick", function(self) checksound(self); TourGuide.db.char.alwaysmapnotecoords = not TourGuide.db.char.alwaysmapnotecoords end)
	mapquestgivernotes:SetChecked(TourGuide.db.char.alwaysmapnotecoords)
	if TourGuide.db.char.mapquestgivers then
		mapquestgivernotes:Enable()
		mapquestgivernoteslabel:SetFontObject(GameFontHighlight)
	else
		mapquestgivernotes:Disable()
		mapquestgivernoteslabel:SetFontObject(GameFontDisable)
	end

	mapquestgivers:SetScript("OnClick", function(self)
		checksound(self)
		TourGuide.db.char.mapquestgivers = not TourGuide.db.char.mapquestgivers
		if TourGuide.db.char.mapquestgivers then
			mapquestgivernotes:Enable()
			mapquestgivernoteslabel:SetFontObject(GameFontHighlight)
		else
			mapquestgivernotes:Disable()
			mapquestgivernoteslabel:SetFontObject(GameFontDisable)
		end
	end)

	local rafmode = tekcheck.new(frame, nil, L["Recruit-a-friend mode"], "TOPLEFT", mapquestgivernotes, "BOTTOMLEFT", -GAP*2, -GAP)
	rafmode.tiptext = L["Use recruit-a-friend modifications to guides, if present."]
	rafmode:SetScript("OnClick", function(self)
		checksound(self)
		TourGuide.db.char.rafmode = not TourGuide.db.char.rafmode
		TourGuide:LoadGuide(TourGuide.db.char.currentguide)
		TourGuide:UpdateStatusFrame()
		TourGuide:UpdateGuidesPanel()
	end)
	rafmode:SetChecked(TourGuide.db.char.rafmode)

	frame:SetScript("OnShow", nil)
end)

InterfaceOptions_AddCategory(frame)


----------------------------
--      LDB Launcher      --
----------------------------

local ldb = LibStub:GetLibrary("LibDataBroker-1.1")
local dataobj = ldb:GetDataObjectByName("TourGuideLauncher") or ldb:NewDataObject("TourGuideLauncher", {type = "launcher", icon = "Interface\\Icons\\Ability_Hunter_Pathfinding", tocname = "TourGuide"})
dataobj.OnClick = function() InterfaceOptionsFrame_OpenToCategory(frame) end
