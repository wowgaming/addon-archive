--[[
	Auctioneer - Search UI - Searcher Snatch
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: SearcherSnatch.lua 4432 2009-08-29 14:55:35Z dinesh $
	URL: http://auctioneeraddon.com/

	This is a plugin module for the SearchUI that assists in searching by refined paramaters

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
		since that is its designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat
--]]

-- Create a new instance of our lib with our parent
local lib, parent, private = AucSearchUI.NewSearcher("Snatch")
if not lib then return end
local print,decode,_,_,replicate,empty,_,_,_,debugPrint,fill, _TRANS = AucAdvanced.GetModuleLocals()
local get, set, default, Const, resources = parent.GetSearchLocals()
lib.tabname = "Snatch"
lib.Private = private

default("snatch.allow.bid", true)
default("snatch.allow.buy", true)
default("snatch.maxprice", 10000000)
default("snatch.maxprice.enable", false)
default("snatch.allow.beginerTooltips", true)
default("snatch.price.model", "market")
private.snatchList = {} -- dummy table

private.workingItemLink = nil
local frame

--[[
The slash command will take the following input
<link> 1g 2s 3c   where  g s c are defined  in any combination
or
<link> 1gold 2 Silver  3c   where  g s c are defined  in any text form
or
<link>  10203   where the price is given in total copper]]
local tooltip = LibStub("nTipHelper:1")
function lib.SlashCommand(cmd)
	local itemlink, GSC, price, extra = cmd:match("(|c%x+|H.+|h%[.*%]|h|r).-((%d+)(.*))") --split command into link and price. check if price is defined as total copper ot as a g s c value
	--parse for gsc if more data than just a simple value
	if extra and extra ~= "" and price then
		local g,s,c
		g = GSC:lower():match("(%d+)%s-g") or 0
		s = GSC:lower():match("(%d+)%s-s") or 0
		c = GSC:lower():match("(%d+)%s-c") or 0
		price = (g*COPPER_PER_GOLD + s*COPPER_PER_SILVER + c) --sum gsc to total copper value
	end
	price = tonumber(price)

	--parse for % command  % or percent
	local pct
	if extra and extra ~= "" and price == 0 then
		pct = GSC:lower():match("(%d+)%s-%%") or GSC:lower():match("(%d+)%s-p")
	end
	pct = tonumber(pct)

	--pass to snatch
	if itemlink and price and price > 0 then
		lib.AddSnatch(itemlink, price)
		price = tooltip:Coins(price)--convert to fancy gsc icon format
		print("Added snatch for", itemlink, "at", price, "or lower")
	elseif itemlink and pct and pct > 0 then
		lib.AddSnatch(itemlink, nil, pct)
		print("Added snatch for", itemlink, "at", pct, "%  of market price or lower")
	else
		print("FORMAT: <link> <price in copper> or <link> Xg Xs Xc or <link> X% or <link> Xp")
	end
end

-- This function is automatically called when we need to create our search parameters
function lib:MakeGuiConfig(gui)
	lib.MakeGuiConfig = nil
	-- Get our tab and populate it with our controls
	local id = gui:AddTab(lib.tabname, "Searchers")
	gui:MakeScrollable(id)

	-- Add the help
	gui:AddSearcher("Snatch", "Search for items which you want to buy when they are available for less than a given price", 100)
	gui:AddHelp(id, "snatch searcher",
		"What does this searcher do?",
		"This searcher provides the ability to snap up items which meet your fixed price constraints. It is useful whenever you say \"I always want to buy this when it is cheaper than X per item\".")

	--we add a single invisible element with height attribute to anchor the normal gui
	gui:AddControl(id, "Note", 0, 1, nil, 110, " ")

	local SelectBox = LibStub:GetLibrary("SelectBox")
	local ScrollSheet = LibStub:GetLibrary("ScrollSheet")
	--Add Drag slot / Item icon
	frame = gui.tabs[id].content
	private.frame = frame

	--Create the snatch list results frame
	frame.snatchlist = CreateFrame("Frame", nil, frame)
	frame.snatchlist:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true, tileSize = 32, edgeSize = 16,
		insets = { left = 5, right = 5, top = 5, bottom = 5 }
	})

	frame.snatchlist:SetBackdropColor(0, 0, 0.0, 0.5)
	frame.snatchlist:SetPoint("TOPLEFT", frame, "TOPLEFT", 275, 2) --Anchor to left side. The GUI is resized from the right when we embed in AH
	frame.snatchlist:SetPoint("BOTTOM", frame, "BOTTOM", 0, -100)
	frame.snatchlist:SetWidth(380)

	frame.slot = frame:CreateTexture(nil, "ARTWORK")
	frame.slot:SetPoint("TOPLEFT", frame, "TOPLEFT", 8, 0)
	frame.slot:SetWidth(45)
	frame.slot:SetHeight(45)
	frame.slot:SetTexCoord(0.17, 0.83, 0.17, 0.83)
	frame.slot:SetTexture("Interface\\Buttons\\UI-EmptySlot")

	--ICON box, used to drag item and display Icon
	function frame.IconClicked()
		local objtype, _, link = GetCursorInfo()
		ClearCursor()
		if objtype == "item" then
			lib.SetWorkingItem(link)
		end
	end
	frame.icon = CreateFrame("Button", nil, frame)
	frame.icon:SetPoint("TOPLEFT", frame.slot, "TOPLEFT", 2, -2)
	frame.icon:SetPoint("BOTTOMRIGHT", frame.slot, "BOTTOMRIGHT", -2, 2)
	frame.icon:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square.blp")
	frame.icon:SetScript("OnClick", frame.IconClicked)
	frame.icon:SetScript("OnReceiveDrag", frame.IconClicked)
	frame.icon:SetScript("OnEnter", function() --set mouseover tooltip
		if private.workingItemLink then
				GameTooltip:SetOwner(frame.icon, "ANCHOR_BOTTOMRIGHT")
				GameTooltip:SetHyperlink(private.workingItemLink)
			end
		end)
	frame.icon:SetScript("OnLeave", function() GameTooltip:Hide() end)

	frame.slot.help = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	frame.slot.help:SetPoint("LEFT", frame.slot, "RIGHT", 2, 0)
	frame.slot.help:SetText(("Drop item into box")) --"Drop item into box to search."
	frame.slot.help:SetWidth(220)
	frame.slot.help:SetJustifyH("LEFT")

	frame.snatchlist.sheet = ScrollSheet:Create(frame.snatchlist, {
		{ "Snatching", "TOOLTIP", 170 },
		{ "%", "NUMBER", 25 },
		{ "Buy each", "COIN", 70},
		{ "Valuation", "COIN", 70 },
		})

	--Processor function for all scrollframe events for this frame
	function frame.snatchlist.sheet.Processor(callback, self, button, column, row, order, curDir, ...)
		if (callback == "ColumnOrder") then
			set("snatch.columnorder", order)
		elseif (callback == "ColumnWidthSet") then
			private.OnResize(self, column, button:GetWidth() )
		elseif (callback == "ColumnWidthReset") then
			private.onResize(self, column, nil)
		elseif (callback == "OnEnterCell")  then
			private.OnEnterSnatch(button, row, column)
		elseif (callback == "OnLeaveCell") then
			GameTooltip:Hide()
		elseif (callback == "OnClickCell") then
			private.OnClickSnatch(button, row, column)
		elseif (callback == "ColumnSort") then
			set("snatch.columnsortcurDir", curDir)
			set("snatch.columnsortcurSort", column)
		end
	end

	--If we have a saved order reapply
	if get("snatch.columnorder") then
		--print("saved order applied")
		frame.snatchlist.sheet:SetOrder( get("snatch.columnorder") )
	end
	--Apply last column sort used
	if get("snatch.columnsortcurSort") then
		frame.snatchlist.sheet.curSort = get("snatch.columnsortcurSort") or 1
		frame.snatchlist.sheet.curDir = get("snatch.columnsortcurDir") or 1
		frame.snatchlist.sheet:PerformSort()
	end


	-- "Price" and "Percent of Valuation" Input Frames
	-- Making changes to one of these will affect the other (with some specific exceptions to avoid unwanted recursion)
	frame.money = CreateFrame("Frame", "AucSearchUISearcherSnatchMoney", frame, "MoneyInputFrameTemplate")
	frame.money.isMoneyFrame = true
	frame.money:SetPoint("LEFT", frame.slot, "BOTTOM", -16, -10)
	-- Note: never call MoneyInputFrame_SetCopper on frame.money; use private.setMoneyFrame instead (performs required additional checking)
	function frame.money.onValueChangedFunc()
		if frame.money.internal then
			frame.money.internal = nil
		else
			-- money frame edited manually by user: "fixed price" mode. clear percent box
			frame.pctBox:SetText("")
		end
	end

	frame.pctBox = CreateFrame("EditBox", nil, frame, "InputBoxTemplate")
	frame.pctBox:SetPoint("TOP", frame.money, "BOTTOM", -70, 0)
	frame.pctBox:SetAutoFocus(false)
	frame.pctBox:SetNumeric(true)
	frame.pctBox:SetMaxLetters(4) --no more than 4 digits
	frame.pctBox:SetTextColor(1, 0, 0) -- red text
	frame.pctBox:SetWidth(35)
	frame.pctBox:SetHeight(32)
	--Set money frame to % of market. Visual Only Calculated each session
	frame.pctBox:SetScript("OnTextChanged", function()
		local price, pct = 0, frame.pctBox:GetNumber()
		if private.workingItemLink then
			price = private.getPrice(private.workingItemLink)
		end
		--this stops us from clearing money when we just reset % after a new selection
		if pct ~= 0 then
			private.setMoneyFrame(price * pct/100)
			frame.money:SetAlpha(.6) -- "fade" money frame (to indicate it is only an example)
		else
			frame.money:SetAlpha(1)
		end
	end)

	frame.pctBox.help = frame.pctBox:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	frame.pctBox.help:SetPoint("LEFT", frame.pctBox, "RIGHT", 0, 0)
	frame.pctBox.help:SetWidth(130)
	frame.pctBox.help:SetJustifyH("LEFT")
	frame.pctBox.help:SetText("Buy as percent of selected statistic")


	--Add Item to list button
	frame.additem = CreateFrame("Button", nil, frame, "OptionsButtonTemplate")
	frame.additem:SetPoint("LEFT", frame.money, "RIGHT", -10, 0)
	frame.additem:SetText(('Add Item'))
	frame.additem:SetScript("OnClick", function()
								local copper = MoneyInputFrame_GetCopper(frame.money)
								local percent = frame.pctBox:GetNumber()
								lib.AddSnatch(private.workingItemLink, copper, percent)
							end)
	frame.additem:SetScript("OnEnter", function() lib.buttonTooltips( frame.additem, "Click to add current selection to the snatch list") end)
	frame.additem:SetScript("OnLeave", function() GameTooltip:Hide() end)

	--Remove Item from list button
	frame.removeitem = CreateFrame("Button", nil, frame, "OptionsButtonTemplate")
	frame.removeitem:SetPoint("TOP", frame.additem, "BOTTOM", 0, -10)
	frame.removeitem:SetText(('Remove Item'))
	frame.removeitem:SetScript("OnClick", function() lib.RemoveSnatch(private.workingItemLink) end)
	frame.removeitem:SetScript("OnEnter", function() lib.buttonTooltips( frame.removeitem, "Click to remove current selection from the snatch list") end)
	frame.removeitem:SetScript("OnLeave", function() GameTooltip:Hide() end)

	--Reset snatch list
	frame.resetList = CreateFrame("Button", nil, frame, "OptionsButtonTemplate")
	frame.resetList:SetPoint("TOP", frame.snatchlist, "BOTTOM", 0, -15)
	frame.resetList:SetText(("Clear List"))
	frame.resetList:SetScript("OnClick", function()
								if ( IsAltKeyDown() and IsShiftKeyDown() and IsControlKeyDown() )then
									private.snatchList = {}
									set("snatch.itemsList", private.snatchList)
									private.refreshDisplay()
								else
									print("This will clear the snatch list permanently. To use hold ALT+CTRL+SHIFT while clicking this button")
								end
							end)
	frame.resetList:SetScript("OnEnter", function() lib.buttonTooltips( frame.resetList, "Shift+Ctrl+Alt Click to remove all items from the snatch list") end)
	frame.resetList:SetScript("OnLeave", function() GameTooltip:Hide() end)

	-- Normal GUI controls
	-- Anchored to the hidden "Note" control we added earlier
	gui:AddControl(id, "Subhead",0, "Snatch search settings:")
	gui:AddControl(id, "Note", 0, 1, nil, nil, " ")
	last = gui:GetLast(id)
	gui:AddControl(id, "Checkbox", 0, 1, "snatch.allow.bid", "Allow Bids")
	gui:AddTip(id, "Allow Snatch searcher to suggest bids")
	gui:SetLast(id, last)
	gui:AddControl(id, "Checkbox", 0, 11, "snatch.allow.buy", "Allow Buyouts")
	gui:AddTip(id, "Allow Snatch searcher to suggest buyouts")
	gui:AddControl(id, "Checkbox", 0, 1, "snatch.maxprice.enable", "Enable individual maximum price:")
	gui:AddTip(id, "Limit the maximum amount you want to spend with the Snatch searcher")
	gui:AddControl(id, "MoneyFramePinned", 0, 2, "snatch.maxprice", 1, 99999999, "Maximum Price for Snatch")

	gui:AddControl(id, "Subhead", 0, "Price Valuation Method:")
	gui:AddControl(id, "Selectbox", 0, 1, resources.selectorPriceModels, "snatch.price.model")
	gui:AddTip(id, "The pricing model that is used to work out the calculated value of items at the Auction House.")

	gui:AddControl(id, "Note", 0, 1, nil, nil, " ")
	gui:AddControl(id, "Checkbox", 0, 1,  "snatch.allow.beginerTooltips", "Display beginner popup help.")
	gui:AddTip(id, "Display beginner tooltips.")

	gui:AddHelp(id, "what are commands",
		'How to use slash commands',
[[After SearchUI has been opened, you can use the /snatch  slash command.
You can easily add items via
/snatch  <itemlink>  TotalValue in Copper
or
/snatch  <itemlink>  xG xS xC
if the command is accepted you should see a chat message confirming the item and price snatch will buy at.]]
		)

	private.refreshDisplay()


	SLASH_SNATCH1 = "/snatch";
	SlashCmdList["SNATCH"] = lib.SlashCommand
end

--Gets price for choosen item using current selected pricing model
function private.getPrice(link)
	local model = get("snatch.price.model")
	local price = resources.lookupPriceModel[model](model, link)
	return price or 0
end

function private.setMoneyFrame(price)
	frame.money.internal = true -- flag as internal so we don't clear the pctBox
	if price then
		MoneyInputFrame_SetCopper(frame.money, math.floor(price))
	else
		MoneyInputFrame_ResetMoney(frame.money)
	end
end

function private.doValidation()
	if not resources.isValidPriceModel(get("snatch.price.model")) then
		message("Snatch Searcher Warning!\nCurrent price model setting ("..get("snatch.price.model")..") is not valid. Select a new price model")
	else
		private.doValidation = nil
	end
end

--Processor function
--this handles any notifications that SearchUI core needs to send us
function lib.Processor(event, subevent, setting)
	if event == "config" then
		if subevent == "loaded" or subevent == "reset" or subevent == "deleted" then
			--saved search has changed, so reload our private ignorelist
			private.snatchList = get("snatch.itemsList")
			--if there was no saved snatchList, create an empty table
			if not private.snatchList then
				private.snatchList = {}
				set("snatch.itemsList", private.snatchList) -- Caution: this causes a Processor("config", "changed", ...) event
			end
			private.refreshDisplay()
		elseif subevent == "changed" and setting == "snatch.price.model" then -- this is the only "change" that requires a refresh
			private.refreshDisplay()
		end
	elseif event == "selecttab" and subevent == lib.tabname then
		if private.doValidation then
			private.doValidation()
		end
		private.refreshDisplay() -- redraw whenever tab is selected
	elseif event == "postscanupdate" then
		private.refreshDisplay() -- redraw whenever valuations may have changed
	end
end

function private.OnEnterSnatch(button, row, index)
	if frame.snatchlist.sheet.rows[row][index]:IsShown() then --Hide tooltip for hidden cells
		local link = frame.snatchlist.sheet.rows[row][index]:GetText()
		--check is a valid itemlink
		if link and link:match("Hitem:.+|h%[(.-)%]|h|r") then
			GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
			GameTooltip:SetHyperlink(link)
		end
	end
end

function private.OnClickSnatch(button, row, index)
	local link = frame.snatchlist.sheet.rows[row][index]:GetText()
	--lib.SetWorkingItem(link) handles the job of checking that link is valid
	lib.SetWorkingItem(link)
end

function private.OnResize(...)
	--print(...)
end

--Beginner Tooltips script display for all UI elements
function lib.buttonTooltips(self, text)
	if get("snatch.allow.beginerTooltips") and text and self then
		GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
		GameTooltip:SetText(text)
	end
end

--[[ for reference:
	ItemTable[Const.LINK]    = hyperlink
	ItemTable[Const.ILEVEL]  = iLevel
	ItemTable[Const.ITYPE]   = iType
	ItemTable[Const.ISUB]    = iSubType
	ItemTable[Const.IEQUIP]  = iEquip
	ItemTable[Const.PRICE]   = price
	ItemTable[Const.TLEFT]   = timeleft
	ItemTable[Const.NAME]    = name
	ItemTable[Const.COUNT]   = count
	ItemTable[Const.QUALITY] = quality
	ItemTable[Const.CANUSE]  = canUse
	ItemTable[Const.ULEVEL]  = level
	ItemTable[Const.MINBID]  = minBid
	ItemTable[Const.MININC]  = minInc
	ItemTable[Const.BUYOUT]  = buyout
	ItemTable[Const.CURBID]  = curBid
	ItemTable[Const.AMHIGH]  = isHigh
	ItemTable[Const.SELLER]  = owner
	ItemTable[Const.ITEMID]  = itemid
	ItemTable[Const.SUFFIX]  = suffix
	ItemTable[Const.FACTOR]  = factor
	ItemTable[Const.ENCHANT]  = enchant
	ItemTable[Const.SEED]  = seed
]]
--returns if a item meets snatch criteria
function lib.Search(item)
	local itemsig = (":"):join(item[Const.ITEMID], item[Const.SUFFIX] , item[Const.ENCHANT])
	local iteminfo = private.snatchList[itemsig]

	if iteminfo then
		local bidprice, buyprice = item[Const.PRICE], item[Const.BUYOUT]
		local maxprice = get("snatch.maxprice.enable") and get("snatch.maxprice")
		if buyprice <= 0 or not get("snatch.allow.buy") or (maxprice and buyprice > maxprice) then
			buyprice = nil
		end
		if not get("snatch.allow.bid") or (maxprice and bidprice > maxprice) then
			bidprice = nil
		end
		if not (bidprice or buyprice) then
			return false, "Does not meet bid/buy requirements"
		end

		local value
		if iteminfo.percent then
			value = private.getPrice(iteminfo.link) * iteminfo.percent / 100
		else
			value = iteminfo.price
		end
		value = value * (item[Const.COUNT] or 1)

		if buyprice and buyprice <= value then
			return "buy", value
		elseif bidprice and bidprice <= value then
			return "bid", value
		else
			return false, "Price not low enough"
		end
	end
	return false, "Not in snatch list"
end

--[[Snatch GUI functinality code]]
function lib.AddSnatch(itemlink, price, percent, count)
	local linkType, itemid, itemsuffix, itemenchant = AucAdvanced.DecodeLink(itemlink)
	if linkType ~= "item" or not itemid then return end
	local itemsig = (":"):join(itemid, itemsuffix, itemenchant)

	price, count, percent = tonumber(price), tonumber(count), tonumber(percent)
	if price and price <=0 then
		price = nil
	end
	if count and count <= 0 then
		count = nil
	end
	if percent then
		if percent <= 0 then
			percent = nil
		end
	end
	--Do not store a % and a price
	if price and percent then
		price = nil --it will be calculated as needed
	end

	--add item to snatch list
	if price or percent then
		private.snatchList[itemsig] = {["link"] =  itemlink, ["price"] = price, ["count"] = count, ["percent"] = percent}
	else
		private.snatchList[itemsig] = nil
	end
	set("snatch.itemsList", private.snatchList)
	private.finishedItem()
end

function lib.RemoveSnatch(itemlink)
	local linkType, itemid, itemsuffix, itemenchant = AucAdvanced.DecodeLink(itemlink)
	if linkType ~= "item" or not itemid then return end
	local itemsig = (":"):join(itemid, itemsuffix, itemenchant)

	--remove from snatch list
	private.snatchList[itemsig] = nil
	set("snatch.itemsList", private.snatchList)
	private.finishedItem()
end

--set UI for next item choice
function private.finishedItem()
	--reset UI
	frame.slot.help:SetText(("Drop item into box"))
	frame.icon:SetNormalTexture(nil)
	frame.pctBox:SetText("")
	private.setMoneyFrame()
	--reset current working item
	private.workingItemLink = nil
	--refresh displays
	private.refreshDisplay()
end

--get the current item we may want to add or remove
function lib.SetWorkingItem(link)
	if type(link)~="string" then return end
	if not frame then return end
	local linkType, itemid, itemsuffix, itemenchant = AucAdvanced.DecodeLink(link)
	if linkType ~= "item" or not itemid then return end

	--Get the current saved value if already in snatch list
	local itemsig = (":"):join(itemid, itemsuffix, itemenchant)
	local iteminfo = private.snatchList[itemsig]

	if iteminfo then
		if iteminfo.percent then
			frame.pctBox:SetText(iteminfo.percent)
		else
			frame.pctBox:SetText("")
			private.setMoneyFrame(iteminfo.price)
		end
	else
		frame.pctBox:SetText("")
		private.setMoneyFrame()
	end

	--set edit box texture and name
	frame.icon:SetNormalTexture(GetItemIcon(link)) --set icon texture
	frame.slot.help:SetText(link)

	--set current working item
	private.workingItemLink = link
end

function private.ClickLinkHook(_, _, link, button)
	if link and private.frame and private.frame:IsShown() then
		if (button == "LeftButton") then --and (IsAltKeyDown()) and itemName then -- Commented mod key, I want to catch any item clicked.
			lib.SetWorkingItem(link)
		end
	end
end
hooksecurefunc("ChatFrame_OnHyperlinkShow", private.ClickLinkHook)

function private.refreshDisplay()
	if not (frame and frame:IsVisible()) then
		return -- only redraw if Snatch is visible
	end

	-- Repopulate snatch listbox
	local Data, Style = {}, {}
	for itemsig, iteminfo in pairs(private.snatchList) do
		local price
		local market = private.getPrice(iteminfo.link)
		--if we are buying by % of market price
		if iteminfo.percent then
			price = math.floor(market * iteminfo.percent/100) --set buy price to % of market

			local row = #Data+1 -- row number of the item we are about to add
			Style[row] = {}
			Style[row][1] = {["rowColor"] = {0, 1, 0, 0, 0.2, "Horizontal"}} -- green background for row
			Style[row][2] = {["textColor"] = {1,0,0}} -- red text
		else
			price = iteminfo.price
		end
		tinsert(Data, {iteminfo.link, iteminfo.percent or 0, price, market})
	end
	frame.snatchlist.sheet:SetData(Data, Style)

	--update "help" text to display current
	frame.pctBox.help:SetText(format("Buy as percent of %s value", get("snatch.price.model") or "market") )
end

AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Auc-Util-SearchUI/SearcherSnatch.lua $", "$Rev: 4432 $")
