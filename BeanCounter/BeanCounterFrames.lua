--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: BeanCounterFrames.lua 4640 2010-01-26 02:18:04Z Nechckn $
	URL: http://auctioneeraddon.com/

	BeanCounterFrames - AuctionHouse UI for Beancounter

	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 2
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GPL.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

	Note:
		This AddOn's source code is specifically designed to work with
		World of Warcraft's interpreted AddOn system.
		You have an implicit license to use this AddOn with these facilities
		since that is it's designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat
]]
LibStub("LibRevision"):Set("$URL: http://svn.norganna.org/auctioneer/branches/5.8/BeanCounter/BeanCounterFrames.lua $","$Rev: 4640 $","5.1.DEV.", 'auctioneer', 'libs')

local lib = BeanCounter
local private, print, get, set, _BC = lib.getLocals()

local function debugPrint(...)
    if get("util.beancounter.debugFrames") then
        private.debugPrint("BeanCounterFrames",...)
    end
end

local frame
local auctionUICreated
function private.AuctionUI()
	if auctionUICreated then return end
	frame = private.frame

	--Create the TAB
	frame.ScanTab = CreateFrame("Button", "AuctionFrameTabUtilBeanCounter", AuctionFrame, "AuctionTabTemplate")
	frame.ScanTab:SetText("BeanCounter")
	frame.ScanTab:SetScript("OnEnter", function() private.buttonTooltips( frame.ScanTab, _BC('TT_BeanCounterAHTab')) end) -- Right click to display BeanCounter in a external window.
	frame.ScanTab:SetScript("OnLeave", function() GameTooltip:Hide() end)
	frame.ScanTab:RegisterForClicks("LeftButtonUp" , "RightButtonUp")
	frame.ScanTab:Show()
	PanelTemplates_DeselectTab(frame.ScanTab)

	if AucAdvanced then
		AucAdvanced.AddTab(frame.ScanTab, frame)
	else
		private.AddTab(frame.ScanTab, frame)
	end
	local last = 1
	function frame.ScanTab.OnClick(self, button, index)
		if not index then index = self:GetID() end
		local tab = getglobal("AuctionFrameTab"..index)
		
		if button == "RightButton" and tab and tab:GetName() == "AuctionFrameTabUtilBeanCounter" then
			local tab = getglobal("AuctionFrameTab"..last)
			tab:Click() --use this so we stay on users currently selected tab
			private.displayGUI(  )
			return
		end
		last = index
		
		if (tab and tab:GetName() == "AuctionFrameTabUtilBeanCounter") then
			--Modified Textures
			AuctionFrameTopLeft:SetTexture("Interface\\AddOns\\BeanCounter\\Textures\\BC-TopLeft")
			AuctionFrameTop:SetTexture("Interface\\AddOns\\BeanCounter\\Textures\\BC-Top")
			AuctionFrameTopRight:SetTexture("Interface\\AddOns\\BeanCounter\\Textures\\BC-TopRight")
			--Default AH textures
			AuctionFrameBotLeft:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Bid-BotLeft")
			AuctionFrameBot:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Bid-Bot")
			AuctionFrameBotRight:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Bid-BotRight")

			if (AuctionDressUpFrame:IsVisible()) then
				AuctionDressUpFrame:Hide()
				AuctionDressUpFrame.reshow = true
			end
			private.displayGUI("ShowAHGUI")
		else
			if (AuctionDressUpFrame.reshow) then
				AuctionDressUpFrame:Show()
				AuctionDressUpFrame.reshow = nil
			end
			AuctionFrameMoneyFrame:Show()
			private.displayGUI("HideAHGUI")
		end
	end
	auctionUICreated = true
	hooksecurefunc("AuctionFrameTab_OnClick", frame.ScanTab.OnClick)
end

--function handles showing the standalone or intergrated UI
function private.displayGUI( action )
	frame = private.frame

	if action == "HideAHGUI" then --hide unless is on the external GUI
		if not BeanCounterBaseFrame:IsVisible() then
			frame:Hide()
		else --when tab is created frame parent is set to AH, we dont want this
			frame:SetParent("BeanCounterBaseFrame")
			frame:SetAllPoints(BeanCounterBaseFrame)
		end
	elseif action == "ShowAHGUI" then
		frame:SetParent(AuctionFrame)
		frame:SetAllPoints("AuctionFrame")
		private.relevelFrame(frame)--make sure our frame stays in proper order
		BeanCounterBaseFrame:Hide()
		frame:Show()
	elseif BeanCounterBaseFrame:IsVisible() then
		BeanCounterBaseFrame:Hide()
		frame:Hide()
	else
		frame:SetParent("BeanCounterBaseFrame")
		frame:SetAllPoints(BeanCounterBaseFrame)
		private.relevelFrame(frame)--make sure our frame stays in proper order
		BeanCounterBaseFrame:Show()
		frame:Show()
	end
	--show the last postponed query if one was sent while frame was hidden
	if private.storedQuery and frame:IsVisible() then
		private.searchByItemID(private.storedQuery)
		private.storedQuery = nil
	end
end
--Change parent to our GUI base frame/ Also used to display our Config frame
function private.GUI(_, button)
	if (button == "LeftButton") then
		private.displayGUI()
	else
		if not lib.Gui:IsVisible() then
			lib.Gui:Show()
		else
			lib.Gui:Hide()
		end
	end
end

--Seperated frame items from frame creation, this should allow the same code to be reused for AH UI and Standalone UI
function private.CreateFrames()

	--Create the base frame for external GUI
	local base = CreateFrame("Frame", "BeanCounterBaseFrame", UIParent)
	base:SetFrameStrata("HIGH")
	base:SetBackdrop({
		bgFile = "Interface/Tooltips/ChatBubble-Background",
		edgeFile = "Interface/Tooltips/ChatBubble-BackDrop",
		tile = true, tileSize = 32, edgeSize = 32,
		insets = { left = 32, right = 32, top = 32, bottom = 32 }
	})
	base:SetBackdropColor(0,0,0, 1)
	base:Hide()

	base:SetPoint("CENTER", UIParent, "CENTER")
	base:SetWidth(834.5)
	base:SetHeight(450)


	base:SetMovable(true)
	base:EnableMouse(true)
	base:SetToplevel(true)
	base:SetResizable(true)
	base:SetMinResize(834, 450)
	base:SetMaxResize(1500, 450)

	--resize button for base GUI
	base.Resizer = CreateFrame("Button", nil, base)
	base.Resizer:SetPoint("BOTTOMRIGHT", base, "BOTTOMRIGHT", -8, 8)
	base.Resizer:SetHeight(32)
	base.Resizer:SetWidth(32)
	base.Resizer:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")
	base.Resizer:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")
	base.Resizer:SetScript("OnMouseDown", function() base:StartSizing() end)
	base.Resizer:SetScript("OnMouseUp", function()  base:StopMovingOrSizing()  end)
	base.Resizer:SetScript("OnEnter", function() private.buttonTooltips( base.Resizer, _BC('Click and drag to resize window')) end)
	base.Resizer:SetScript("OnLeave", function() GameTooltip:Hide() end)
	
	
	base.Drag = CreateFrame("Button", nil, base)
	base.Drag:SetPoint("TOPLEFT", base, "TOPLEFT", 10,-5)
	base.Drag:SetPoint("TOPRIGHT", base, "TOPRIGHT", -10,-5)
	base.Drag:SetHeight(6)
	base.Drag:SetHighlightTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar")

	base.Drag:SetScript("OnMouseDown", function() base:StartMoving() end)
	base.Drag:SetScript("OnMouseUp", function() base:StopMovingOrSizing() private.setter("configator.left", base:GetLeft()) private.setter("configator.top", base:GetTop()) end)

	base.DragBottom = CreateFrame("Button",nil, base)
	base.DragBottom:SetPoint("BOTTOMLEFT", base, "BOTTOMLEFT", 10,5)
	base.DragBottom:SetPoint("BOTTOMRIGHT", base, "BOTTOMRIGHT", -10,5)
	base.DragBottom:SetHeight(6)
	base.DragBottom:SetHighlightTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar")

	base.DragBottom:SetScript("OnMouseDown", function() base:StartMoving() end)
	base.DragBottom:SetScript("OnMouseUp", function() base:StopMovingOrSizing() private.setter("configator.left", base:GetLeft()) private.setter("configator.top", base:GetTop()) end)

	--Close BeanCounter GUI Config frame
	base.Done = CreateFrame("Button", nil, base, "OptionsButtonTemplate")
	base.Done:SetPoint("BOTTOMRIGHT", base, "BOTTOMRIGHT", -50, 10)
	base.Done:SetScript("OnClick", function() base:Hide() end)
	base.Done:SetText(_BC('UiDone'))

	--Create the Actual Usable Frame
	local frame = CreateFrame("Frame", "BeanCounterUiFrame", base)
	private.frame = frame
	frame:Hide()

	private.frame:SetPoint("TOPLEFT", base, "TOPLEFT")
	private.frame:SetWidth(828)
	private.frame:SetHeight(450)

	--Add Title to the Top
	local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", frame, "TOPLEFT", 80, -17)
	title:SetText(_BC("UiAddonTitle"))

	local SelectBox = LibStub:GetLibrary("SelectBox")
	local ScrollSheet = LibStub:GetLibrary("ScrollSheet")

	--Beginner Tooltips script display for all UI elements
	function private.buttonTooltips(self, text)
		if get("util.beancounter.displaybeginerTooltips") and text and self then
			GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
			GameTooltip:SetText(text)
		end
	end

	--Add Configuration Button for those who dont use sidebar.
	frame.Config = CreateFrame("Button", nil, frame, "OptionsButtonTemplate")
	frame.Config:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -139, -13)
	frame.Config:SetScript("OnClick", function() private.GUI() end)
	frame.Config:SetText("Configure")
	frame.Config:SetScript("OnEnter", function() private.buttonTooltips( frame.Config, _BC('TTOpenconfig')) end)--"Opens the BeanCounter configuration window"
	frame.Config:SetScript("OnLeave", function() GameTooltip:Hide() end)


	
	--ICON box, used to drag item and display ICo for item being searched. Based Appraiser Code
	function frame.IconClicked()
		local objtype, _, link = GetCursorInfo()
		ClearCursor()
		if objtype == "item" then
			local itemID = lib.API.decodeLink(link)
			local _, itemName =  lib.API.getItemString(link)
			local itemTexture = select(2, private.getItemInfo(link, "name")) 
			frame.searchBox:SetText(itemName)
			private.searchByItemID(itemID, private.getCheckboxSettings(), nil, 150, itemTexture, itemName)
		end
	end

	frame.slot = frame:CreateTexture(nil, "BORDER")
	frame.slot:SetPoint("TOPLEFT", frame, "TOPLEFT", 23, -125)
	frame.slot:SetWidth(45)
	frame.slot:SetHeight(45)
	frame.slot:SetTexCoord(0.15, 0.85, 0.15, 0.85)
	frame.slot:SetTexture("Interface\\Buttons\\UI-EmptySlot")

	frame.icon = CreateFrame("Button", nil, frame)
	frame.icon:SetPoint("TOPLEFT", frame.slot, "TOPLEFT", 3, -3)
	frame.icon:SetWidth(38)
	frame.icon:SetHeight(38)
	frame.icon:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square.blp")
	frame.icon:SetScript("OnClick", frame.IconClicked)
	frame.icon:SetScript("OnReceiveDrag", frame.IconClicked)
	frame.icon:SetScript("OnEnter", function() private.buttonTooltips( frame.icon, _BC('TT_ItemIconBox')) end) --"Drop an item here to start a search for it.\nDisplays current search's icon if possible"
	frame.icon:SetScript("OnLeave", function() GameTooltip:Hide() end)

	--help text
	frame.slot.help = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	frame.slot.help:SetPoint("LEFT", frame.slot, "RIGHT", 2, 7)
	frame.slot.help:SetText(_BC('HelpGuiItemBox')) --"Drop item into box to search."
	frame.slot.help:SetWidth(100)

	--Select box, used to chooose where the stats comefrom we show server/faction/player/all
	frame.SelectBoxSetting = {"1","server"}
	function private.ChangeControls(obj, arg1,arg2,...)
		frame.SelectBoxSetting = {arg1, arg2}
	end
	--Default Server wide
	--Used GLOBALSTRINGS for the horde alliance translations
	local vals = {{"server", private.realmName.." ".._BC('UiData')},{"alliance", FACTION_ALLIANCE.." ".._BC('UiData')},{"horde", FACTION_HORDE.." ".._BC('UiData')}, {"neutral", _BC('MailNeutralAuctionHouse')}}
	for name,data in pairs(private.serverData) do
		table.insert(vals,{name, name.." ".._BC('UiData')})
	end

	frame.selectbox = CreateFrame("Frame", "BeanCounterSelectBox", frame)
	frame.selectbox.box = SelectBox:Create("BeanCounterSelectBox", frame.selectbox, 140, private.ChangeControls, vals, "default")
	frame.selectbox.box:SetPoint("TOPLEFT", frame, "TOPLEFT", 4,-80)
	frame.selectbox.box.element = "selectBox"
	frame.selectbox.box:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	frame.selectbox.box:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 0,-90)
	frame.selectbox.box:SetText(private.realmName.." ".._BC('UiData'))
	frame.selectbox.box.button:SetScript("OnEnter", function() private.buttonTooltips( frame.selectbox.box.button, _BC('TT_BeanCounterSelectBox')) end)--"Filter search results by server, player, faction"
	frame.selectbox.box.button:SetScript("OnLeave", function() GameTooltip:Hide() end)

	--Search box
	frame.searchBox = CreateFrame("EditBox", "BeancountersearchBox", frame, "InputBoxTemplate")
	frame.searchBox:SetPoint("TOPLEFT", frame, "TOPLEFT", 29, -180)
	frame.searchBox:SetAutoFocus(false)
	frame.searchBox:SetHeight(15)
	frame.searchBox:SetWidth(150)
	frame.searchBox:SetScript("OnEnterPressed", function()
		local itemName = frame.searchBox:GetText()
		-- Allow beancounter searches to add the text to the AH frame
		if AuctionFrame and get("sendSearchBrowseFrame") then
			BrowseName:SetText(itemName)
		end
		private.startSearch(itemName, private.getCheckboxSettings())
	end)
	frame.searchBox:SetScript("OnEnter", function() private.buttonTooltips( frame.searchBox, _BC("TT_SearchBox")) end) --"Enter search query's here or leave blank to search all"
	frame.searchBox:SetScript("OnLeave", function() GameTooltip:Hide() end)

	
	--Search Button
	frame.searchButton = CreateFrame("Button", nil, frame, "OptionsButtonTemplate")
	frame.searchButton:SetPoint("TOPLEFT", frame.searchBox, "BOTTOMLEFT", -6, -1)
	frame.searchButton:SetText(_BC('UiSearch'))
	frame.searchButton:SetScript("OnClick", function()
		local itemName = frame.searchBox:GetText()
		-- Allow beancounter searches to add the text to the AH frame
		if AuctionFrame and get("sendSearchBrowseFrame") then
			BrowseName:SetText(itemName)
		end
		private.startSearch(itemName, private.getCheckboxSettings())
	end)
	--Clicking for BC search --Thanks for the code Rockslice
	function private.ClickBagHook(_, _, self, button)
		if (frame.searchBox and frame.searchBox:IsVisible()) then
			local bag = self:GetParent():GetID()
			local slot = self:GetID()
			local link = GetContainerItemLink(bag, slot)
			if link then
				local itemID = lib.API.decodeLink(link)
				local _, itemName = lib.API.getItemString(link)
				local _, itemTexture = private.getItemInfo(link, "name")
				if (button == "LeftButton") and (IsAltKeyDown()) and itemName then
					debugPrint(itemName, itemID,itemTexture, link)
					frame.searchBox:SetText(itemName)
					private.searchByItemID(itemID, private.getCheckboxSettings(), nil, 150, itemTexture, itemName)
				end
			end
		end
	end
	Stubby.RegisterFunctionHook("ContainerFrameItemButton_OnModifiedClick", -50, private.ClickBagHook)

	function private.ClickLinkHook(self, itemString, link, button)
			if (frame.searchBox and frame.searchBox:IsVisible()) then
			if link then
				local itemID = lib.API.decodeLink(link)
				local _, itemName = lib.API.getItemString(link)
				local _, itemTexture = private.getItemInfo(link, "name")
				if (button == "LeftButton") and (IsAltKeyDown()) and itemName then
					--debugPrint(itemName, itemID,itemTexture, link)
					frame.searchBox:SetText(itemName)
					private.searchByItemID(itemID, private.getCheckboxSettings(), nil, 150, itemTexture, itemName)
				end
			end
		end
	end
	hooksecurefunc("ChatFrame_OnHyperlinkShow", private.ClickLinkHook)

	--Check boxes to narrow our search
	frame.exactCheck = CreateFrame("CheckButton", "BeancounterexactCheck", frame, "OptionsCheckButtonTemplate")
	frame.exactCheck:SetChecked(get("util.beancounter.ButtonExactCheck")) --get the last used checked/unchecked value Then use below script to store state changes
	frame.exactCheck:SetPoint("TOPLEFT", frame, "TOPLEFT", 19, -217)
	frame.exactCheck:SetScript("OnClick", function() local on if frame.exactCheck:GetChecked() then on = true end set("util.beancounter.ButtonExactCheck", on) private.wipeSearchCache() end)
	getglobal("BeancounterexactCheckText"):SetText(_BC('UiExactNameSearch'))
	frame.exactCheck:SetScript("OnEnter", function() private.buttonTooltips( frame.exactCheck, _BC('TT_ExactCheck')) end) --"Only match the Exact text in the search box"
	frame.exactCheck:SetScript("OnLeave", function() GameTooltip:Hide() end)

	--search classic data
	frame.neutralCheck = CreateFrame("CheckButton", "BeancounterneutralCheck", frame, "OptionsCheckButtonTemplate")
	frame.neutralCheck:SetChecked(false) --Set this to false We only want this to be true/searchabe if there is a classic DB to search
	frame.neutralCheck:SetScript("OnClick", function() local on if frame.neutralCheck:GetChecked() then on = true end set("util.beancounter.ButtonneutralCheck", on) private.wipeSearchCache() end)
	getglobal("BeancounterneutralCheckText"):SetText(_BC('UiNeutralCheckBox'))
	frame.neutralCheck:SetPoint("TOPLEFT", frame, "TOPLEFT", 19, -242)
	frame.neutralCheck:SetScript("OnEnter", function() private.buttonTooltips( frame.neutralCheck, _BC('TT_neutralCheck')) end) --"Display results from BeanCounter Classic Database"
	frame.neutralCheck:SetScript("OnLeave", function() GameTooltip:Hide() end)

	

	--search bids
	frame.bidCheck = CreateFrame("CheckButton", "BeancounterbidCheck", frame, "OptionsCheckButtonTemplate")
	frame.bidCheck:SetChecked(get("util.beancounter.ButtonBidCheck"))
	frame.bidCheck:SetScript("OnClick", function() local on if frame.bidCheck:GetChecked() then on = true end set("util.beancounter.ButtonBidCheck", on) private.wipeSearchCache() end)
	getglobal("BeancounterbidCheckText"):SetText(_BC('UiBids'))
	frame.bidCheck:SetScale(0.85)
	frame.bidCheck:SetPoint("TOPLEFT", frame, "TOPLEFT", 25, -335)
	frame.bidCheck:SetScript("OnEnter", function() private.buttonTooltips( frame.bidCheck, _BC('TT_BidCheck')) end) --"Display items bought from the Auction House"
	frame.bidCheck:SetScript("OnLeave", function() GameTooltip:Hide() end)


	
	frame.bidFailedCheck = CreateFrame("CheckButton", "BeancounterbidFailedCheck", frame, "OptionsCheckButtonTemplate")
	frame.bidFailedCheck:SetChecked(get("util.beancounter.ButtonBidFailedCheck"))
	frame.bidFailedCheck:SetScript("OnClick", function() local on if frame.bidFailedCheck:GetChecked() then on = true end set("util.beancounter.ButtonBidFailedCheck", on) private.wipeSearchCache() end)
	frame.bidFailedCheck:SetScale(0.85)
	getglobal("BeancounterbidFailedCheckText"):SetText(_BC('UiOutbids'))
	frame.bidFailedCheck:SetPoint("TOPLEFT", frame, "TOPLEFT", 25, -435)
	frame.bidFailedCheck:SetScript("OnEnter", function() private.buttonTooltips( frame.bidFailedCheck, _BC('TT_BidFailedCheck')) end) --"Display items you were outbided on."
	frame.bidFailedCheck:SetScript("OnLeave", function() GameTooltip:Hide() end)

	--search Auctions
	frame.auctionCheck = CreateFrame("CheckButton", "BeancounterauctionCheck", frame, "OptionsCheckButtonTemplate")
	frame.auctionCheck:SetChecked(get("util.beancounter.ButtonAuctionCheck"))
	frame.auctionCheck:SetScript("OnClick", function() local on if frame.auctionCheck:GetChecked() then on = true end set("util.beancounter.ButtonAuctionCheck", on) private.wipeSearchCache() end)
	getglobal("BeancounterauctionCheckText"):SetText(_BC('UiAuctions'))
	frame.auctionCheck:SetScale(0.85)
	frame.auctionCheck:SetPoint("TOPLEFT", frame, "TOPLEFT", 25, -360)
	frame.auctionCheck:SetScript("OnEnter", function() private.buttonTooltips( frame.auctionCheck, _BC('TT_AuctionCheck')) end) --"Display items sold at the Auction House"
	frame.auctionCheck:SetScript("OnLeave", function() GameTooltip:Hide() end)


	
	frame.auctionFailedCheck = CreateFrame("CheckButton", "BeancounterauctionFailedCheck", frame, "OptionsCheckButtonTemplate")
	frame.auctionFailedCheck:SetChecked(get("util.beancounter.ButtonAuctionFailedCheck"))
	frame.auctionFailedCheck:SetScript("OnClick", function() local on if frame.auctionFailedCheck:GetChecked() then on = true end set("util.beancounter.ButtonAuctionFailedCheck", on) private.wipeSearchCache() end)
	frame.auctionFailedCheck:SetScale(0.85)
	getglobal("BeancounterauctionFailedCheckText"):SetText(_BC('UiFailedAuctions'))
	frame.auctionFailedCheck:SetPoint("TOPLEFT", frame, "TOPLEFT", 25, -460)
	frame.auctionFailedCheck:SetScript("OnEnter", function() private.buttonTooltips( frame.auctionFailedCheck, _BC('TT_AuctionFailedCheck')) end) --Display items you failed to sell.
	frame.auctionFailedCheck:SetScript("OnLeave", function() GameTooltip:Hide() end)

	--[[search Purchases (vendor/trade)
	frame.buyCheck = CreateFrame("CheckButton", "BeancounterbuyCheck", frame, "OptionsCheckButtonTemplate")
	frame.buyCheck:SetChecked(true)
	getglobal(BeancounterbuyCheck:GetName().."Text"):SetText("Buys")
	frame.buyCheck:SetPoint("TOPLEFT", frame, "TOPLEFT", 19, -255)
	--search Sold (vendor/trade)
	frame.sellCheck = CreateFrame("CheckButton", "BeancountersellCheck", frame, "OptionsCheckButtonTemplate")
	frame.sellCheck:SetChecked(true)
	getglobal(BeancountersellCheck:GetName().."Text"):SetText("Sold")
	frame.sellCheck:SetPoint("TOPLEFT", frame, "TOPLEFT", 19, -330)]]
	--creates teh report text that tells info on # of entries
	frame.DBCount = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	frame.DBCount:SetPoint("TOPLEFT", frame, "TOPLEFT", 70, -40)
	frame.DBCount:SetText("Items: "..private.DBSumEntry)
	
	frame.DBItems = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	frame.DBItems:SetPoint("TOPLEFT", frame, "TOPLEFT", 70, -55)
	frame.DBItems:SetText("Entries: "..private.DBSumItems)
	private.sumDatabase() --Sums database Done on first Start and Search of the session
	
	--Edit box for changing UI reason codes
	frame.reasonEditBox = CreateFrame("EditBox", nil, frame, "InputBoxTemplate")
	frame.reasonEditBox:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
	frame.reasonEditBox:SetAutoFocus(true)
	frame.reasonEditBox:Hide()
	frame.reasonEditBox:SetHeight(15)
	frame.reasonEditBox:SetFrameStrata("DIALOG")
	frame.reasonEditBox:SetWidth(30)
	frame.reasonEditBox:SetScript("OnEscapePressed", function() frame.reasonEditBox:Hide() end)
	frame.reasonEditBox:SetScript("OnEnterPressed", function()
		local self = frame.resultlist.sheet
		self.selected = self.selectedForEdit[1] --pass stored selection back to frame

		local data = frame.resultlist.sheet:GetSelection()
		local newReason = frame.reasonEditBox:GetText()
		if data then
			local itemLink, bid, buy, net, quanity, seller, deposit, fee, currentReason, date = data[1], data[3], data[4], data[5], data[6], data[8], data[9], data[10], data[11], data[12]
			lib.API.updatedReason(nil, newReason, itemLink, bid, buy, net, quanity, seller, deposit, fee, currentReason, date)
		end

		--update the current display data to reflect change
		local rows = self.rows
		local data = self.data
		local sort = self.sort

		local vPos = math.floor(self.panel.vPos)
		local hSize = self.hSize
		local rowNum = sort[vPos + self.selectedForEdit[2]]
		local rowPos = (rowNum-1)*hSize  --
		local pos = rowPos +  self.selectedForEdit[3]

		self.data[pos] = newReason
		self:Render()

		frame.reasonEditBox:Hide()
	end)


	--Create the results window
	frame.resultlist = CreateFrame("Frame", nil, frame)
	frame.resultlist:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true, tileSize = 32, edgeSize = 16,
		insets = { left = 5, right = 5, top = 5, bottom = 5 }
	})

	frame.resultlist:SetBackdropColor(0, 0, 0.0, 0.5)
	frame.resultlist:SetPoint("TOPLEFT", frame, "TOPLEFT", 187, -32.5) --change anchors to allow for vert resize
	frame.resultlist:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -3, 0)
	frame.resultlist:SetPoint("BOTTOM", frame, "BOTTOM", 0, 35)

	--Scripts that are executed when we mouse over a TOOLTIP frame
	function private.scrollSheetOnEnter(button, row, index)
		local link, name, _
		link = frame.resultlist.sheet.rows[row][index]:GetText() or "FAILED LINK"
		if link:match("^(|c%x+|H.+|h%[.+%])") then
			_, name = lib.API.getItemString(link)
		end
		GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
		if frame.resultlist.sheet.rows[row][index]:IsShown()then --Hide tooltip for hidden cells
			if link and name then
				GameTooltip:SetHyperlink(link)
				--private.tooltip:ShowItemLink(GameTooltip, link, 1)
			end
		end
        end
	--records the column width changes
	 --store width by header name, that way if column reorginizing is added we apply size to proper column
	function private.onResize(self, column, width)
		if not width then
			set("columnwidth."..self.labels[column]:GetText(), "default") --reset column if no width is passed. We use CTRL+rightclick to reset column
			self.labels[column].button:SetWidth(get("columnwidth."..self.labels[column]:GetText()))
		else
			set("columnwidth."..self.labels[column]:GetText(), width)
		end
	end
	--Allows user to shift click on itemlinks in beacounter to Chat or BeanCounters select box
	function private.scrollSheetOnClick(button, row, column)
		local self = frame.resultlist.sheet
		local clickedFrame = self.rows[row][column]
		if not clickedFrame:IsVisible() then return end --Old data is still in the frames, just hidden
		
		local text = clickedFrame:GetText()
		if not text then text = "" end
		
		local columnName = self.labels[column]:GetText()
		if columnName == _BC('UiNameHeader') then
			if IsShiftKeyDown() then
				ChatEdit_InsertLink(text)--sends to chat or auction house
			elseif IsAltKeyDown() then -- Search for the item in BeanCounter
				private.wipeSearchCache()
				local _, text = lib.API.getItemString(text) --convert itemlink to plain text
				frame.searchBox:SetText(text)
				private.startSearch(text, private.getCheckboxSettings())
			end
		elseif columnName == _BC('UiReason') then
			frame.reasonEditBox:ClearAllPoints()
			frame.reasonEditBox:SetAllPoints(clickedFrame)
			frame.reasonEditBox:ClearFocus() --clear focus then set so we highlight current text
			frame.reasonEditBox:SetText(text)
			frame.reasonEditBox:Show()
			frame.reasonEditBox:SetFocus()
			self.selectedForEdit = {self.sort[row + math.floor(self.panel.vPos)], row, column}
			
		end
	end

	local Buyer, Seller = string.match(_BC('UiBuyerSellerHeader'), "(.*)/(.*)")
	frame.resultlist.sheet = ScrollSheet:Create(frame.resultlist, {
		{ _BC('UiNameHeader'), "TOOLTIP",  get("columnwidth.".._BC('UiNameHeader')) },
		{ _BC('UiTransactions'), "TEXT", get("columnwidth.".._BC('UiTransactions')) },

		{_BC('UiBidTransaction') , "COIN", get("columnwidth.".._BC('UiBidTransaction')) },
		{ _BC('UiBuyTransaction') , "COIN", get("columnwidth.".._BC('UiBuyTransaction')) },
		{ _BC('UiNetHeader'), "COIN", get("columnwidth.".._BC('UiNetHeader')) },
		{ _BC('UiQuantityHeader'), "TEXT", get("columnwidth.".._BC('UiQuantityHeader')) },
		{ _BC('UiPriceper'), "COIN", get("columnwidth.".._BC('UiPriceper')) },

		{ "|CFFFFFF00"..Seller.."/|CFF4CE5CC"..Buyer, "TEXT", get("columnwidth.".."|CFFFFFF00"..Seller.."/|CFF4CE5CC"..Buyer) },

		{ _BC('UiDepositTransaction'), "COIN", get("columnwidth.".._BC('UiDepositTransaction')) },
		{ _BC("UiFee"), "COIN", get("columnwidth.".._BC("UiFee")) },
		{ _BC('UiReason'), "TEXT", get("columnwidth.".._BC('UiReason')) },
		{ _BC('UiDateHeader'), "TEXT", get("columnwidth.".._BC('UiDateHeader')) },
	} )

	--Add tooltip help to the scrollframe headers
	for i = 1, #frame.resultlist.sheet.labels do
		local self = frame.resultlist.sheet.labels[i].button
		self:SetScript("OnEnter", function() private.buttonTooltips( self, _BC('TT_ScrollHeader') ) end) --Rightclick+Drag to move\nALT++RightClick to resize\nCTRL+RightClick to reset
		self:SetScript("OnLeave", function() GameTooltip:Hide() end)
	end
	--If we have a saved order reapply
	if get("columnorder") then
		--print("saved order applied")
		frame.resultlist.sheet:SetOrder(get("columnorder") )
	end
	--Apply last column sort used
	if get("columnsortcurSort") then
		frame.resultlist.sheet.curSort = get("columnsortcurSort") or 1
		frame.resultlist.sheet.curDir = get("columnsortcurDir") or 1
		frame.resultlist.sheet:PerformSort()
	end
	--After we have finished creating the scrollsheet and all saved settings have been applyed set our event processor
	function frame.resultlist.sheet.Processor(callback, self, button, column, row, order, curDir, ...)
		if (callback == "ColumnOrder") then
			set("columnorder", order)
		elseif (callback == "ColumnWidthSet") then
			private.onResize(self, column, button:GetWidth() )
		elseif (callback == "ColumnWidthReset") then
			private.onResize(self, column, nil)
		elseif (callback == "OnEnterCell")  then
			private.scrollSheetOnEnter(button, row, column)
		elseif (callback == "OnLeaveCell") then
			GameTooltip:Hide()
		elseif (callback == "OnClickCell") then
			private.scrollSheetOnClick(button, row, column)
		elseif (callback == "ColumnSort") then
			set("columnsortcurDir", curDir)
			set("columnsortcurSort", column)
		end
	end
	
	--All the UI settings are stored here. We then split it to get the appropriate search settings
	function private.getCheckboxSettings()
		return {["selectbox"] = frame.SelectBoxSetting , ["exact"] = frame.exactCheck:GetChecked(), ["neutral"] = frame.neutralCheck:GetChecked(),
			["bid"] = frame.bidCheck:GetChecked(), ["failedbid"] = frame.bidFailedCheck:GetChecked(), ["auction"] = frame.auctionCheck:GetChecked(),
			["failedauction"] = frame.auctionFailedCheck:GetChecked()
			}
	end
	--set parent of the Reason edit box to the created scrollframe. This prevents overlaping.
	frame.reasonEditBox:SetParent(frame.resultlist.sheet.content)
	private.CreateMailFrames()

end

function private.CreateMailFrames()
	local frame = CreateFrame("Frame", "BeanCounterMail", MailFrame)
	frame:Hide()
	private.MailGUI = frame
	local count, total = 0,0

	frame:SetPoint("TOPLEFT", MailFrame, "TOPLEFT", 19,-71)
	frame:SetPoint("BOTTOMRIGHT", MailFrame, "BOTTOMRIGHT", -39,115)
	--Add Title to the Top
	local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	title:SetPoint("CENTER", frame, "CENTER", 0,60)
	title:SetText(_BC('UiMailFrameRecording')) --BeanCounter is recording your mail

	local body = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	body:SetPoint("CENTER", frame, "CENTER", 0, 30)
	body:SetText(_BC('UiMailFrameWait1')) --Please do not close the mail frame or
	local body1 = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	body1:SetPoint("CENTER", frame, "CENTER", 0,0)
	body1:SetText(_BC('UiMailFrameWait2')) --"Auction Items will not be recorded"

	local countdown = frame:CreateFontString("BeanCounterMailCount", "OVERLAY", "GameFontNormalLarge")
	private.CountGUI = countdown
	countdown:SetPoint("CENTER", frame, "CENTER", 0, -60)
	countdown:SetText("Recording: "..count.." of "..total.." items")
end


function private.createDeleteItemPrompt()
	--Create the base frame for external GUI
	local frame = CreateFrame("Frame", nil, UIParent)
	frame:SetFrameStrata("DIALOG")
	frame:SetBackdrop({
		bgFile = "Interface/Tooltips/ChatBubble-Background",
		edgeFile = "Interface/Tooltips/ChatBubble-BackDrop",
		tile = true, tileSize = 32, edgeSize = 32,
		insets = { left = 32, right = 32, top = 32, bottom = 32 }
	})
	frame:SetBackdropColor(0,0,0, 1)
	frame:Hide()

	frame:SetPoint("CENTER", UIParent, "CENTER")
	frame:SetWidth(500)
	frame:SetHeight(200)
	
	frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	frame.title:SetPoint("CENTER", frame, "CENTER", 0,30)
	frame.title:SetText(_BC('Do you want to delete this item from the database?'))
	
	frame.item = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	frame.item:SetPoint("CENTER", frame, "CENTER", 0,0)
	
	frame.yes = CreateFrame("Button", nil, frame, "OptionsButtonTemplate")
	frame.yes:SetPoint("CENTER", frame, "CENTER", -120, -60)
	frame.yes:SetText(_BC('Yes'))
	frame.yes:SetScript("OnClick", function() private.deleteExactItem( frame.item:GetText() )
								frame:Hide()
								frame.item:SetText("")
					end)
	
	frame.no = CreateFrame("Button", nil, frame, "OptionsButtonTemplate")
	frame.no:SetPoint("LEFT", frame.yes, "RIGHT", 50, 0)
	frame.no:SetText(_BC('No'))
	frame.no:SetScale(1.8)
	frame.no:SetScript("OnClick", function()  frame:Hide() frame.item:SetText("") end)
	
	private.deletePromptFrame = frame
end

--ONLOAD Error frame, used to show missmatched DB versus client errors that stop BC load NEEDS LOCALIZATION
function private.CreateErrorFrames(error, expectedVersion, playerVersion)
	frame = private.scriptframe
	frame.loadError = CreateFrame("Frame", nil, UIParent)
	frame.loadError:SetFrameStrata("HIGH")
	frame.loadError:SetBackdrop({
		bgFile = "Interface/Tooltips/ChatBubble-Background",
		edgeFile = "Interface/Tooltips/ChatBubble-BackDrop",
		tile = true, tileSize = 32, edgeSize = 32,
		insets = { left = 32, right = 32, top = 32, bottom = 32 }
	})
	frame.loadError:SetBackdropColor(0,0,0, 1)
	frame.loadError:Show()

	frame.loadError:SetPoint("CENTER", UIParent, "CENTER")
	frame.loadError:SetWidth(300)
	frame.loadError:SetHeight(200)

	frame.loadError.close = CreateFrame("Button", nil, frame.loadError, "OptionsButtonTemplate")
	frame.loadError.close:SetPoint("BOTTOMRIGHT", frame.loadError, "BOTTOMRIGHT", -10, 10)
	frame.loadError.close:SetScript("OnClick", function() frame.loadError:Hide() end)
	frame.loadError.close:SetText( _BC('Ok') )

	frame.loadError.text = frame.loadError:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	frame.loadError.text:SetPoint("LEFT", frame.loadError, "LEFT", 25, 30)
	frame.loadError.text:SetWidth(250)
	if error == "bean older" then
		print ("Your database has been created with a newer version of BeanCounter than the one you are currently using. BeanCounter will not load to prevent possibly corrupting the saved data. Please go to http://auctioneeraddon.com and update to the latest version")
		frame.loadError.text:SetText("Your database has been created with a newer version of BeanCounter "..playerVersion.." than the one you are currently using. "..expectedVersion.." BeanCounter will not load to prevent possibly corrupting the saved data. Please go to http://auctioneeraddon.com and update to the latest version")
	elseif error == "failed update" then
		print ("Your database has failed to update. BeanCounter expects "..private.version.."BeanCounter will not load to prevent possibly corrupting the saved data. Please go to the forums at http://auctioneeraddon.com")
		frame.loadError.text:SetText("Your database has failed to update. BeanCounter expects "..expectedVersion.." But the player's version is still "..playerVersion.." BeanCounter will not load to prevent possibly corrupting the saved data. Please go to the forums at http://auctioneeraddon.com")
	else
		frame.loadError.text:SetText("Unknow Error on loading. BeanCounter will not load to prevent possibly corrupting the saved data. Please go to the forums at http://auctioneeraddon.com")
	end
	frame.loadError.title = frame.loadError:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	frame.loadError.title:SetPoint("CENTER", frame.loadError, "TOP", 0,-15)
	frame.loadError.title:SetText("|CFFFF0000 BEANCOUNTER WARNING")
end

--Taken from AucCore to make beancounter Standalone, Need to remove Redudundant stuff
function private.AddTab(tabButton, tabFrame)
	-- Count the number of auction house tabs (including the tab we are going
	-- to insert).
	local tabCount = 1;
	while (getglobal("AuctionFrameTab"..(tabCount))) do
		tabCount = tabCount + 1;
	end

	-- Find the correct location to insert our Search Auctions and Post Auctions
	-- tabs. We want to insert them at the end or before BeanCounter's
	-- Transactions tab.
	local tabIndex = 1;
	while (getglobal("AuctionFrameTab"..(tabIndex)) and
		   getglobal("AuctionFrameTab"..(tabIndex)):GetName() ~= "AuctionFrameTabTransactions") do
		tabIndex = tabIndex + 1;
	end

	-- Make room for the tab, if needed.
	for index = tabCount, tabIndex + 1, -1  do
		setglobal("AuctionFrameTab"..(index), getglobal("AuctionFrameTab"..(index - 1)));
		getglobal("AuctionFrameTab"..(index)):SetID(index);
	end

	-- Configure the frame.
	tabFrame:SetParent("AuctionFrame");
	tabFrame:SetPoint("TOPLEFT", "AuctionFrame", "TOPLEFT", 0, 0);
	private.relevelFrame(tabFrame);

	-- Configure the tab button.
	setglobal("AuctionFrameTab"..tabIndex, tabButton);
	tabButton:SetParent("AuctionFrame");
	tabButton:SetPoint("TOPLEFT", getglobal("AuctionFrameTab"..(tabIndex - 1)):GetName(), "TOPRIGHT", -8, 0);
	tabButton:SetID(tabIndex);
	tabButton:Show();

	-- Update the tab count.
	PanelTemplates_SetNumTabs(AuctionFrame, tabCount)
end

function private.relevelFrame(frame)
	return private.relevelFrames(frame:GetFrameLevel() + 2, frame:GetChildren())
end

function private.relevelFrames(myLevel, ...)
	for i = 1, select("#", ...) do
		local child = select(i, ...)
		child:SetFrameLevel(myLevel)
		private.relevelFrame(child)
	end
end
--Created SearchUI reason code data into tooltips
function private.processTooltip(tip, itemLink, quantity)
	if not itemLink then return end
	if get("ModTTShow") and not IsAltKeyDown() then
		return
	end
	
	if not get("util.beancounter.displayReasonCodeTooltip") then return end

	private.tooltip:SetFrame(tip)
	local reason, Time, bid, player = lib.API.getBidReason(itemLink, quantity)
		
	--debugPrint("Add to Tooltip", itemLink, reason)
	if reason then
		if reason == "0" then reason = "Unknown" end
		Time = SecondsToTime((time() - Time))
		local text = ""
		if player then
			text = ("Last won by {{%s}} for {{%s}} { {{%s}} } ago}"):format(player or "", reason, Time)
		else
			text = ("Last won for {{%s}} { {{%s}} } ago}"):format(reason, Time)
		end
		local cost = tonumber(bid)
		private.tooltip:AddLine(text, cost, 0.9,0.6,0.2)
	end
	private.tooltip:ClearFrame(tip)
end
