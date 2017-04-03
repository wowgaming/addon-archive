local addon = LibStub("AceAddon-3.0"):GetAddon("EveryQuest")
local L = LibStub("AceLocale-3.0"):GetLocale("EveryQuest")

function addon:SetupFrames()
	---------------------------------------------------------------------
	--- Setup Frames
	EveryQuestTitleText:SetText(L["EveryQuest Log"]) -- Main frame title
	EveryQuestExitButton:SetText(CLOSE)
	BINDING_HEADER_eqTITLE = L["EveryQuest"] -- Key Binding group name
	BINDING_NAME_eqTOGGLE = L["Toggle Frame"] -- Frame toggle key binding name
	addon.frames = {}
	-- Create the "EQ" toggle button for the questlog frame
	addon.frames.Show = CreateFrame("Button",nil, QuestLogFrame, "UIPanelButtonTemplate")
	addon.frames.Show:SetWidth(28)
	addon.frames.Show:SetHeight(18)
	addon.frames.Show:SetText("EQ")
	addon.frames.Show:Show()
	addon.frames.Show:ClearAllPoints()
	addon.frames.Show:SetPoint("TOPLEFT",QuestLogFrame, "TOPLEFT",75,-15)
	addon.frames.Show:SetScript("OnClick", function() addon:Toggle()	end)
	
	
	
	addon.frames.ShownTT = CreateFrame("Frame",nil, EveryQuestFrame)
	addon.frames.ShownTT:SetWidth(122)
	addon.frames.ShownTT:SetBackdropColor(1,0,0,1)
	addon.frames.ShownTT:SetHeight(21)
	addon.frames.ShownTT:Show()
	addon.frames.ShownTT:ClearAllPoints()
	addon.frames.ShownTT:SetPoint("BOTTOMLEFT",EveryQuestFrame, "BOTTOMLEFT",18,5)
	addon.frames.ShownTT:EnableMouse(1)
	addon.frames.ShownTT:SetScript("OnLeave", function() GameTooltip:Hide() end)
	addon.frames.ShownTT:SetScript("OnEnter", function()
		--GameTooltip:SetOwner(addon.frames.ShownTT, "ANCHOR_TOPRIGHT");
		GameTooltip_SetDefaultAnchor( GameTooltip, UIParent )
		GameTooltip:SetText(string.format(L["%d Shown"], cshown), 1, 1, 1) -- Main frame list count tooltip
		GameTooltip:AddLine(addon:Colorize(EQ_TextColors["s2"].hex, string.format(L["%d Turned In"], addon.cdone))) -- Main frame list count tooltip
		GameTooltip:AddLine(addon:Colorize(EQ_TextColors["s1"].hex, string.format(L["%d Completed"], addon.ccompleted))) -- Main frame list count tooltip
		GameTooltip:AddLine(addon:Colorize(EQ_TextColors["s0"].hex, string.format(L["%d In Progress"], addon.cprogress))) -- Main frame list count tooltip
		GameTooltip:AddLine(addon:Colorize(EQ_TextColors["s-1"].hex, string.format(L["%d Failed/Abandoned"], addon.cfailed))) -- Main frame list count tooltip
		GameTooltip:AddLine(addon:Colorize(EQ_TextColors["unknown"].hex, string.format(L["%d Unknown"], addon.cunknown))) -- Main frame list count tooltip
		GameTooltip:AddLine(addon:Colorize(EQ_TextColors["ignored"].hex, string.format(L["%d Ignored"], addon.cignored))) -- Main frame list count tooltip
		GameTooltip:AddLine(addon:Colorize("ffffff", string.format(L["%d Hidden"], addon.chidden))) -- Main frame list count tooltip
		GameTooltip:Show() 
	end)
	-- Create the List toggle button to toggle between quest history and quests in a category
	addon.frames.Shown = addon.frames.ShownTT:CreateFontString(nil,"ARTWORK","GameFontNormal")
	--addon.frames.Shown = CreateFrame("FontString", nil, EveryQuestFrame)
	addon.frames.Shown:SetWidth(122)
	addon.frames.Shown:SetHeight(21)
	addon.frames.Shown:SetText(" ")
	addon.frames.Shown:Show()
	addon.frames.Shown:ClearAllPoints()
	addon.frames.Shown:SetPoint("BOTTOMLEFT",addon.frames.ShownTT, "BOTTOMLEFT",0,0)
	--addon.frames.ShownTT:SetScript("OnClick", function() addon:List("toggle") end)

	addon.frames.Filters = CreateFrame("Button",nil, EveryQuestFrame, "UIPanelButtonTemplate")
	addon.frames.Filters:SetWidth(60)
	addon.frames.Filters:SetHeight(21)
	addon.frames.Filters:SetText(L["Filters"]) -- Main frame button
	addon.frames.Filters:Show()
	addon.frames.Filters:ClearAllPoints()
	addon.frames.Filters:SetPoint("BOTTOMLEFT",EveryQuestFrame, "BOTTOMLEFT",140,5)
	addon.frames.Filters:SetScript("OnClick", function() InterfaceOptionsFrame_OpenToCategory(self.optionsFrames.Filters) end)
	
	addon.frames.Options = CreateFrame("Button",nil, EveryQuestFrame, "UIPanelButtonTemplate")
	addon.frames.Options:SetWidth(60)
	addon.frames.Options:SetHeight(21)
	addon.frames.Options:SetText(L["Options"]) -- Main frame button
	addon.frames.Options:Show()
	addon.frames.Options:ClearAllPoints()
	addon.frames.Options:SetPoint("TOPLEFT",addon.frames.Filters, "TOPRIGHT",0,0)
	addon.frames.Options:SetScript("OnClick", function() self:ShowConfig() end)

	
	local button = CreateFrame("Button", "EveryQuestTitle1", EveryQuestFrame,"EveryQuestTitleButtonTemplate")
	button:SetID(1)
	button:Hide()
	button:ClearAllPoints()
	button:SetPoint("TOPLEFT", EveryQuestFrame, "BOTTOMLEFT", 19, -75)
	for i = 2, 27 do
		button = CreateFrame("Button", "EveryQuestTitle" .. i, EveryQuestFrame,"EveryQuestTitleButtonTemplate")
		button:SetID(i)
		button:Hide()
		button:ClearAllPoints()
		button:SetPoint("TOPLEFT", getglobal("EveryQuestTitle" .. (i-1)), "BOTTOMLEFT", 0, 1)
	end
	
	-- Zone Menu creation
	addon.frames.Menu = CreateFrame("Frame", "EQ_Menu", EveryQuestFrame, "UIDropDownMenuTemplate")
	addon.frames.Menu:Show()
	_G["EQDropdown"] = addon.frames.Menu
	addon.frames.Menu:ClearAllPoints()
	addon.frames.Menu:SetPoint("TOPRIGHT",EveryQuestFrame, "TOPRIGHT", -100,-40)
	UIDropDownMenu_SetWidth(EQ_Menu, 200, 0)
	UIDropDownMenu_SetButtonWidth(EQ_Menu, 20)
	EQ_MenuButton:SetScript("OnClick", function(self, button, down)
		ToggleDropDownMenu(1, nil, EveryQuest_ZoneMenu, self:GetName(), 0, 0)
	end)
	
	UIDropDownMenu_SetText(EQ_Menu, L["- Select -"]) -- Starting dropdown menu text
	tinsert(UISpecialFrames,"EveryQuestFrame")
	
	if IsAddOnLoaded("Carbonite") == nil then
		EveryQuestFrame:SetScale(QuestLogFrame:GetScale())
	end
	
	local LDB = LibStub("LibDataBroker-1.1", true)
	local launcher = LDB:NewDataObject("EveryQuest", {
		type = "launcher",
		icon = "Interface\\AddOns\\EveryQuest\\icon",
		OnClick = function(clickedframe, button)
			if button == "RightButton" then addon:ShowConfig() else addon:Toggle() end
		end,
		OnTooltipShow = function(tt) 
			tt:AddLine(L["EveryQuest"]) -- LDB Tooltip title
			tt:AddLine(L["Click to toggle the main window"]) -- LDB click help: toggle
			tt:AddLine(L["Right-click to open the options menu"]) -- LDB right-click help: options
		end,
	})
end