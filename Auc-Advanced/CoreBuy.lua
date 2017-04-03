--[[
	Auctioneer
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: CoreBuy.lua 4696 2010-03-24 22:04:27Z Nechckn $
	URL: http://auctioneeraddon.com/

	This is an addon for World of Warcraft that adds statistical history to the auction data that is collected
	when the auction is scanned, so that you can easily determine what price
	you will be able to sell an item for at auction or at a vendor whenever you
	mouse-over an item in the game

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

--[[
	Auctioneer Purchasing Engine.

	This code helps modules that need to purchase things to do so in an extremely easy and
	queueable fashion.
]]
if not AucAdvanced then return end

if (not AucAdvanced.Buy) then AucAdvanced.Buy = {} end

local lib = AucAdvanced.Buy
local private = {}
lib.Private = private

local aucPrint,decode,_,_,replicate,_,get,set,default,debugPrint,fill = AucAdvanced.GetModuleLocals()
local Const = AucAdvanced.Const
local highlight = "|cffff7f3f"

private.BuyRequests = {}
private.PendingBids = {}
private.Searching = false
private.lastPrompt = false
private.lastQueue = 0
function private.QueueReport()
	local queuelen = #private.BuyRequests
	local prompt = private.Prompt:IsShown()
	if queuelen ~= private.lastQueue or prompt ~= private.lastPrompt then
		private.lastQueue = queuelen
		private.lastPrompt = prompt
		AucAdvanced.SendProcessorMessage("buyqueue", prompt and queuelen+1 or queuelen) -- quick'n'dirty "queue count"
	end
end
function private.QueueInsert(request, pos)
	if pos and pos <= #private.BuyRequests then
		tinsert(private.BuyRequests, pos, request)
	else
		tinsert(private.BuyRequests, request)
	end
	private.QueueReport()
end
function private.QueueRemove(index)
	if private.BuyRequests[index] then
		local removed = tremove(private.BuyRequests, index)
		private.QueueReport()
		return removed
	end
end

--[[
	GetQueueStatus returns:
	number of items in queue
	total cost of items in queue
	string showing link and number of items if Prompt is open, nil otherwise
	cost of item(s) in Prompt, or 0 if closed
--]]
function lib.GetQueueStatus()
	local queuelen = #private.BuyRequests
	local queuecost = 0
	for i, request in ipairs(private.BuyRequests) do
		queuecost = queuecost + request.price
	end
	local prompt = private.Prompt:IsShown() and private.CurAuction.count.."x "..private.CurAuction.link
	local promptcost = prompt and private.CurAuction.price or 0

	return queuelen, queuecost, prompt, promptcost
end

--[[
	Securely clears the Buy Request queue
	if prompt is true, cancels the Buy Prompt (without sending a "bidcancelled" message)
--]]
function lib.CancelBuyQueue(prompt)
	if prompt and private.Prompt:IsShown() then
		private.HidePrompt(true) -- silent
	end
	private.Searching = false
	wipe(private.BuyRequests)
	private.QueueReport()
end

--[[
	Add an auction to the Buy Queue:
	AucAdvanced.Buy.QueueBuy(link, seller, count, minbid, buyout, price, reason, nosearch)
	This is the main entry point for the lib, and so contains the most parameter checks
	link = (string) 'sanitized' link
	seller = (string, optional) name of seller
	count = (number) stack count
	minbid = (number) original min bid
	buyout = (number) buyout price
	price = (number) price to pay
	reason = (string, optional) reason to display in the buy prompt dialog
	nosearch = (boolean, optional) flag specifying that the auction is on the current page - if not found there, no search will be triggered
	Auctioneer will buy the first auction it sees fitting the specifics at price.
	If item cannot be found on Auctionhouse, will output a warning message to chat
]]
local function QueueBuyErrorHelper(link, reason)
	aucPrint(format("Auctioner: Unable to buy %s : %s", link, reason))
	return false, reason -- note: under development: the specific return strings may be changed
end
function lib.QueueBuy(link, seller, count, minbid, buyout, price, reason, nosearch)
	if type(link) ~= "string" then return QueueBuyErrorHelper("\""..tostring(link).."\"", "Invalid link") end
	if seller ~= nil and type(seller) ~= "string" then return QueueBuyErrorHelper(link, "Invalid seller") end
	count = tonumber(count)
	if not count or count < 1 then return QueueBuyErrorHelper(link, "Invalid count") end
	minbid = tonumber(minbid)
	if not minbid or minbid < 0 then return QueueBuyErrorHelper(link, "Invalid minbid") end -- it is sometimes possible for auctions to report minbid == 0
	buyout = tonumber(buyout)
	if not buyout or buyout < 0 then return QueueBuyErrorHelper(link, "Invalid buyout") end
	price = tonumber(price)
	local canbuy, problem = lib.CanBuy(price, seller, minbid, buyout)
	if not canbuy then return QueueBuyErrorHelper(link, problem) end
	link = AucAdvanced.SanitizeLink(link)
	local name, _, quality, _, minlevel, classname, subclassname = GetItemInfo(link)
	if not name then return QueueBuyErrorHelper(link, "Unable to find info for this item")
	end
	local classindex = AucAdvanced.Const.CLASSESREV[classname]
	local subclassindex
	if classindex then subclassindex = AucAdvanced.Const.SUBCLASSESREV[classname][subclassname] end
	local isbid = buyout == 0 or price < buyout

	if get("ShowPurchaseDebug") then
		if isbid then
			aucPrint("Auctioneer: Queueing Bid of "..link.." from seller "..tostring(seller).." for "..AucAdvanced.Coins(price))
		else
			aucPrint("Auctioneer: Queueing Buyout of "..link.." from seller "..tostring(seller).." for "..AucAdvanced.Coins(price))
		end
	end

	private.QueueInsert({
		link = link,
		sellername = seller or "",
		count = count,
		minbid = minbid,
		buyout = buyout,
		price = price,
		reason = tostring(reason or ""),
		itemname = name:lower(),
		uselevel = minlevel or 0,
		classindex = classindex,
		subclassindex = subclassindex,
		quality = quality or 0,
		isbid = isbid,
		nosearch = not not nosearch, -- double 'not' to force boolean type
	})
	private.ActivateEvents()
	lib.ScanPage()
	return true
end

--[[
	This function will return false, reason if an auction by seller at price cannot be bought
	Else it will return true.
	Note that this will not catch all, but if it says you can't, you can't
	Parameter 'price' is required, all others are optional
]]
function lib.CanBuy(price, seller, minbid, buyout)
	if type(price) ~= "number" then
		return false, "no price given"
	elseif floor(price) ~= price then
		return false, "price must be an integer"
	elseif price < 1 then
		return false, "price cannot be less than 1"
	elseif GetMoney() < price then
		return false, "not enough money"
	elseif minbid and price < minbid then
		return false, "price below minimum bid"
	elseif buyout and buyout > 0 and price > buyout then
		return false, "price higher than buyout"
	elseif seller and AucAdvancedConfig["users."..GetRealmName().."."..seller] then
		return false, "own auction"
	end
	return true
end

function private.PushSearch()
	if AucAdvanced.Scan.IsPaused() then return end
	local nextRequest = private.BuyRequests[1]
	if nextRequest.nosearch then -- backup check (should have been removed by ScanPage)
		private.QueueRemove(1)
		return
	end
	local canbuy, reason = lib.CanBuy(nextRequest.price, nextRequest.sellername)
	if not canbuy then
		aucPrint("Auctioneer: Can't buy "..nextRequest.link.." : "..reason)
		private.QueueRemove(1)
		return
	end

	AucAdvanced.Scan.PushScan()
	if AucAdvanced.Scan.IsScanning() then return end -- check that PushScan succeeded
	private.Searching = true
	AucAdvanced.Scan.StartScan(nextRequest.itemname, nextRequest.uselevel, nextRequest.uselevel, nil,
		nextRequest.classindex, nextRequest.subclassindex, nil, nextRequest.quality)
end

function lib.FinishedSearch() end -- temporary dummy function
function private.FinishedSearch(scanstats)
	if not scanstats or scanstats.wasIncomplete then return end
	local query = scanstats.query
	if not query or query.isUsable or query.invType or not query.name then return end
	local queuecount = #private.BuyRequests
	if queuecount > 0 then
		local queryname = query.name -- lowercase and may have been truncated when query was created
		local queryminlevel = query.minUseLevel
		local querymaxlevel = query.maxUseLevel
		local queryquality = query.quality
		local queryclassindex = query.classIndex
		local querysubclassindex = query.subclassIndex
		for ind = queuecount, 1, -1 do
			local request = private.BuyRequests[ind]
			if request.itemname:find(queryname, 1, true) -- already lowercased/plain text matching
			and (not queryminlevel or request.uselevel >= queryminlevel)
			and (not querymaxlevel or request.uselevel <= querymaxlevel)
			and (not queryquality or request.quality >= queryquality)
			and (not queryclassindex or request.classindex == queryclassindex)
			and (not querysubclassindex or request.subclassindex == querysubclassindex)
			then
				aucPrint("Auctioneer: Auction for "..request.link.." no longer exists")
				private.QueueRemove(ind)
			end
		end
	end
	private.Searching = false
end

function private.PromptPurchase(thisAuction)
	if type(thisAuction.price) ~= "number" then
		aucPrint(highlight.."Cancelling bid: invalid price: "..type(thisAuction.price)..":"..tostring(thisAuction.price))
		return
	elseif type(thisAuction.index) ~= "number" then
		aucPrint(highlight.."Cancelling bid: invalid index: "..type(thisAuction.index)..":"..tostring(thisAuction.index))
		return
	end
	AucAdvanced.Scan.SetPaused(true)
	private.CurAuction = thisAuction
	private.Prompt:Show()
	if (thisAuction.price < thisAuction.buyout) or (thisAuction.buyout == 0) then
		private.Prompt.Text:SetText("Are you sure you want to bid on")
	else
		private.Prompt.Text:SetText("Are you sure you want to buyout")
	end
	if thisAuction.count == 1 then
		private.Prompt.Value:SetText(thisAuction.link.." for "..AucAdvanced.Coins(thisAuction.price,true).."?")
	else
		private.Prompt.Value:SetText(thisAuction.count.."x "..thisAuction.link.." for "..AucAdvanced.Coins(thisAuction.price,true).."?")
	end
	private.Prompt.Item.tex:SetTexture(thisAuction.texture)
	private.Prompt.Reason:SetText(thisAuction.reason or "")
	local width = private.Prompt.Value:GetStringWidth() or 0
	private.Prompt.Frame:SetWidth(max((width + 70), 400))
	private.QueueReport()
end

function private.HidePrompt(silent)
	private.Prompt:Hide()
	private.CurAuction = nil
	if not silent then
		private.QueueReport()
	end
	AucAdvanced.Scan.SetPaused(false)
end

function lib.ScanPage(startat)
	if #private.BuyRequests == 0 then return end
	if private.Prompt:IsVisible() then return end
	local batch = GetNumAuctionItems("list")
	if startat and startat < batch then
		batch = startat
	end
	for i = batch, 1, -1 do
		local link = GetAuctionItemLink("list", i)
		link = AucAdvanced.SanitizeLink(link)
		for j = #private.BuyRequests, 1, -1 do -- must check in reverse order as there are table removes inside the loop
			local BuyRequest = private.BuyRequests[j]
			if link == BuyRequest.link then
				local price = BuyRequest.price
				local buy = BuyRequest.buyout
				local name, texture, count, _, _, _, minBid, minIncrement, buyout, curBid, ishigh, owner = GetAuctionItemInfo("list", i)
				if ishigh and ((not buy) or (buy <= 0) or (price < buy)) then
					aucPrint("Unable to bid on "..link..". Already highest bidder")
					private.QueueRemove(j)
				else
					local brSeller = BuyRequest.sellername
					if (not owner or brSeller == "" or owner == brSeller)
					and (count == BuyRequest.count)
					and (minBid == BuyRequest.minbid)
					and (buyout == BuyRequest.buyout) then --found the auction we were looking for
						if (BuyRequest.price >= (curBid + minIncrement)) or (BuyRequest.price == buyout) then
							BuyRequest.index = i
							BuyRequest.texture = texture
							private.QueueRemove(j)
							private.PromptPurchase(BuyRequest)
							return
						else
							aucPrint(highlight.."Unable to bid on "..link..". Price invalid")
							private.QueueRemove(j)
						end
					end
				end
			end
		end
	end
	-- check for nosearch flags
	for j = #private.BuyRequests, 1, -1 do
		local BuyRequest = private.BuyRequests[j]
		if BuyRequest.nosearch then
			if startat then
				-- we need to be *certain* the whole batch has been scanned before deciding this item is not there.
				-- recurse with no restriction. should only be needed rarely.
				return lib.ScanPage()
			end
			private.QueueRemove(j)
		end
	end
end

--Cancels the current auction
--Also sends out a Callback with a callback string of "<link>;<price>;<count>"
function private.CancelPurchase()
	private.Searching = false
	local CallBackString = strjoin(";", tostringall(private.CurAuction.link, private.CurAuction.price, private.CurAuction.count))
	AucAdvanced.SendProcessorMessage("bidcancelled", CallBackString)
	private.HidePrompt()
	--scan the page again for other auctions
	lib.ScanPage()
end

function private.PerformPurchase()
	if not private.CurAuction then return end
	private.Searching = false
	--first, do some Sanity Checking
	local index = private.CurAuction.index
	local price = private.CurAuction.price
	if type(price)~="number" then
		aucPrint(highlight.."Cancelling bid: invalid price: "..type(price)..":"..tostring(price))
		private.HidePrompt()
		return
	elseif type(index) ~= "number" then
		aucPrint(highlight.."Cancelling bid: invalid index: "..type(index)..":"..tostring(index))
		private.HidePrompt()
		return
	end
	local link = GetAuctionItemLink("list", index)
	link = AucAdvanced.SanitizeLink(link)
	local name, texture, count, _, _, _, minBid, minIncrement, buyout, curBid, ishigh, owner = GetAuctionItemInfo("list", index)

	if (private.CurAuction.link ~= link) then
		aucPrint(highlight.."Cancelling bid: "..tostring(index).." not found")
		private.HidePrompt()
		return
	elseif (price < minBid) then
		aucPrint(highlight.."Cancelling bid: Bid below minimum bid: "..AucAdvanced.Coins(price))
		private.HidePrompt()
		return
	elseif (curBid and curBid > 0 and price < curBid + minIncrement and price < buyout) then
		aucPrint(highlight.."Cancelling bid: Already higher bidder")
		private.HidePrompt()
		return
	end
	if get("ShowPurchaseDebug") then
		if buyout > 0 and price >= buyout then
			aucPrint("Auctioneer: Buying out "..link.." for "..AucAdvanced.Coins(price))
		else
			aucPrint("Auctioneer: Bidding on "..link.." for "..AucAdvanced.Coins(price))
		end
	end

	PlaceAuctionBid("list", index, price)

	private.CurAuction.reason = private.Prompt.Reason:GetText()
	--Add bid to list of bids we're watching for
	local pendingBid = replicate(private.CurAuction)
	tinsert(private.PendingBids, pendingBid)
	--register for the Response events if this is the first pending bid
	if (#private.PendingBids == 1) then
		private.updateFrame:RegisterEvent("CHAT_MSG_SYSTEM")
		private.updateFrame:RegisterEvent("UI_ERROR_MESSAGE")
	end

	--get ready for next bid action
	private.HidePrompt()
	lib.ScanPage(index-1)--check the page for any more auctions
end

function private.removePendingBid()
	if (#private.PendingBids > 0) then
		tremove(private.PendingBids, 1)

		--Unregister events if no more bids pending
		if (#private.PendingBids == 0) then
			private.updateFrame:UnregisterEvent("CHAT_MSG_SYSTEM")
			private.updateFrame:UnregisterEvent("UI_ERROR_MESSAGE")
		end
	end
end

function private.onBidAccepted()
	--"itemlink;seller;count;buyout;price;reason"
	local bid = private.PendingBids[1]
	local CallBackString = strjoin(";", tostringall(bid.link, bid.sellername, bid.count, bid.buyout, bid.price, bid.reason))
	AucAdvanced.SendProcessorMessage("bidplaced", CallBackString)
	private.removePendingBid()
end

--private.onBidFailed(arg1)
--This function is called when a bid fails
--purpose is to output to chat the reason for the failure, and then pass the Bid on to private.removePendingBid()
--The output may duplicate some client output.  If so, those lines need to be removed.
function private.onBidFailed(arg1)
	aucPrint(highlight.."Bid Failed: "..arg1)
	private.removePendingBid()
end

--[[ Timer, Event Handler and Message Processor ]]--

function private.ActivateEvents()
	-- Called when a new auction is queued, or when the Auctionhouse is opened
	if not private.isActivated and #private.BuyRequests > 0 then
		private.isActivated = true
		private.updateFrame:Show() -- start timer
		private.updateFrame:RegisterEvent("AUCTION_ITEM_LIST_UPDATE")
	end
end

function private.DeactivateEvents()
	-- Called when there are no items left in the buy requests list, or when the Auctionhouse is closed
	private.Searching = false
	if private.isActivated then
		private.isActivated = nil
		private.updateFrame:Hide() -- stop timer
		private.updateFrame:UnregisterEvent("AUCTION_ITEM_LIST_UPDATE")
	end
end

local function OnUpdate()
	if not (private.Searching or private.CurAuction) then
		if #private.BuyRequests > 0 then
			private.PushSearch()
		else
			private.DeactivateEvents()
		end
	end
end

local function OnEvent(frame, event, arg1, ...)
	if event == "AUCTION_ITEM_LIST_UPDATE" then
		lib.ScanPage()
	elseif event == "AUCTION_HOUSE_SHOW" then
		private.ActivateEvents()
	elseif event == "AUCTION_HOUSE_CLOSED" then
		if private.CurAuction then -- prompt is open: cancel prompt and requeue auction
			private.QueueInsert(private.CurAuction, 1)
			private.HidePrompt(true) -- silent
		end
		private.DeactivateEvents()
	elseif event == "CHAT_MSG_SYSTEM" then
		if arg1 == ERR_AUCTION_BID_PLACED then
		 	private.onBidAccepted()
		end
	elseif event == "UI_ERROR_MESSAGE" then
		if (arg1 == ERR_ITEM_NOT_FOUND or
			arg1 == ERR_NOT_ENOUGH_MONEY or
			arg1 == ERR_AUCTION_BID_OWN or
			arg1 == ERR_AUCTION_HIGHER_BID or
			arg1 == ERR_AUCTION_BID_INCREMENT or
			arg1 == ERR_AUCTION_MIN_BID or
			arg1 == ERR_ITEM_MAX_COUNT) then
			private.onBidFailed(arg1)
		end
	end
end

function lib.Processor(event, ...)
	if event == "scanstats" then
		private.FinishedSearch(...)
	end
end

private.updateFrame = CreateFrame("Frame")
private.updateFrame:RegisterEvent("AUCTION_HOUSE_SHOW")
private.updateFrame:RegisterEvent("AUCTION_HOUSE_CLOSED")
private.updateFrame:SetScript("OnUpdate", OnUpdate)
private.updateFrame:SetScript("OnEvent", OnEvent)
private.updateFrame:Hide()

--[[ Prompt Frame ]]--

--this is a anchor frame that never changes size
private.Prompt = CreateFrame("frame", "AucAdvancedBuyPrompt", UIParent)
private.Prompt:Hide()
private.Prompt:SetPoint("TOPRIGHT", "UIParent", "TOPRIGHT", -400, -100)
private.Prompt:SetFrameStrata("DIALOG")
private.Prompt:SetHeight(120)
private.Prompt:SetWidth(400)
private.Prompt:SetMovable(true)
private.Prompt:SetClampedToScreen(true)

--The "graphic" frame and backdrop that we resize. Only thing anchored to it is the item Box
private.Prompt.Frame = CreateFrame("frame", nil, private.Prompt)
private.Prompt.Frame:SetPoint("CENTER",private.Prompt, "CENTER" )
local level = private.Prompt:GetFrameLevel()
private.Prompt.Frame:SetFrameLevel(level - 1)
private.Prompt.Frame:SetHeight(120)
private.Prompt.Frame:SetWidth(400)
private.Prompt.Frame:SetClampedToScreen(true)
private.Prompt.Frame:SetBackdrop({
	bgFile = "Interface/Tooltips/UI-Tooltip-Background",
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
	tile = true, tileSize = 32, edgeSize = 32,
	insets = { left = 9, right = 9, top = 9, bottom = 9 }
})
private.Prompt.Frame:SetBackdropColor(0,0,0,0.8)

-- Helper functions
local function ShowTooltip()
	GameTooltip:SetOwner(AuctionFrameCloseButton, "ANCHOR_NONE")
	GameTooltip:SetHyperlink(private.CurAuction["link"])
	GameTooltip:ClearAllPoints()
	GameTooltip:SetPoint("TOPRIGHT", private.Prompt.Item, "TOPLEFT", -10, -20)
end
local function HideTooltip()
	GameTooltip:Hide()
end
local function ClearReasonFocus()
	private.Prompt.Reason:ClearFocus()
end
local function DragStart()
	private.Prompt:StartMoving()
end
local function DragStop()
	private.Prompt:StopMovingOrSizing()
end

private.Prompt.Item = CreateFrame("Button", "AucAdvancedBuyPromptItem", private.Prompt)
private.Prompt.Item:SetNormalTexture("Interface\\Buttons\\UI-Slot-Background")
private.Prompt.Item:GetNormalTexture():SetTexCoord(0,0.640625, 0, 0.640625)
private.Prompt.Item:SetPoint("TOPLEFT", private.Prompt.Frame, "TOPLEFT", 15, -15)
private.Prompt.Item:SetHeight(37)
private.Prompt.Item:SetWidth(37)
private.Prompt.Item:SetScript("OnEnter", ShowTooltip)
private.Prompt.Item:SetScript("OnLeave", HideTooltip)
private.Prompt.Item.tex = private.Prompt.Item:CreateTexture(nil, "OVERLAY")
private.Prompt.Item.tex:SetPoint("TOPLEFT", private.Prompt.Item, "TOPLEFT", 0, 0)
private.Prompt.Item.tex:SetPoint("BOTTOMRIGHT", private.Prompt.Item, "BOTTOMRIGHT", 0, 0)

private.Prompt.Text = private.Prompt:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
private.Prompt.Text:SetPoint("TOPLEFT", private.Prompt, "TOPLEFT", 52, -20)
private.Prompt.Text:SetPoint("TOPRIGHT", private.Prompt, "TOPRIGHT", -15, -20)
private.Prompt.Text:SetJustifyH("CENTER")

private.Prompt.Value = private.Prompt:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
private.Prompt.Value:SetPoint("CENTER", private.Prompt.Frame, "CENTER", 20, 15)

private.Prompt.Reason = CreateFrame("EditBox", "AucAdvancedBuyPromptReason", private.Prompt, "InputBoxTemplate")
private.Prompt.Reason:SetPoint("TOPLEFT", private.Prompt, "TOPLEFT", 150, -55)
private.Prompt.Reason:SetPoint("TOPRIGHT", private.Prompt, "TOPRIGHT", -30, -55)
private.Prompt.Reason:SetHeight(20)
private.Prompt.Reason:SetAutoFocus(false)
private.Prompt.Reason:SetScript("OnEnterPressed", ClearReasonFocus)
private.Prompt.Reason:SetText("")

private.Prompt.Reason.Label = private.Prompt.Reason:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
private.Prompt.Reason.Label:SetPoint("TOPRIGHT", private.Prompt.Reason, "TOPLEFT", 0, 0)
private.Prompt.Reason.Label:SetPoint("TOPLEFT", private.Prompt, "TOPLEFT", 52, -55)
private.Prompt.Reason.Label:SetText("Reason:")
private.Prompt.Reason.Label:SetHeight(15)

private.Prompt.Yes = CreateFrame("Button", "AucAdvancedBuyPromptYes", private.Prompt, "OptionsButtonTemplate")
private.Prompt.Yes:SetText("Yes")
private.Prompt.Yes:SetPoint("BOTTOMRIGHT", private.Prompt, "BOTTOMRIGHT", -10, 10)
private.Prompt.Yes:SetScript("OnClick", private.PerformPurchase)

private.Prompt.No = CreateFrame("Button", "AucAdvancedBuyPromptNo", private.Prompt, "OptionsButtonTemplate")
private.Prompt.No:SetText("Cancel")
private.Prompt.No:SetPoint("BOTTOMRIGHT", private.Prompt.Yes, "BOTTOMLEFT", -60, 0)
private.Prompt.No:SetScript("OnClick", private.CancelPurchase)

private.Prompt.DragTop = CreateFrame("Button", nil, private.Prompt)
private.Prompt.DragTop:SetPoint("TOPLEFT", private.Prompt, "TOPLEFT", 10, -5)
private.Prompt.DragTop:SetPoint("TOPRIGHT", private.Prompt, "TOPRIGHT", -10, -5)
private.Prompt.DragTop:SetHeight(6)
private.Prompt.DragTop:SetHighlightTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar")
private.Prompt.DragTop:SetScript("OnMouseDown", DragStart)
private.Prompt.DragTop:SetScript("OnMouseUp", DragStop)

private.Prompt.DragBottom = CreateFrame("Button", nil, private.Prompt)
private.Prompt.DragBottom:SetPoint("BOTTOMLEFT", private.Prompt, "BOTTOMLEFT", 10, 5)
private.Prompt.DragBottom:SetPoint("BOTTOMRIGHT", private.Prompt, "BOTTOMRIGHT", -10, 5)
private.Prompt.DragBottom:SetHeight(6)
private.Prompt.DragBottom:SetHighlightTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar")
private.Prompt.DragBottom:SetScript("OnMouseDown", DragStart)
private.Prompt.DragBottom:SetScript("OnMouseUp", DragStop)

AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Auc-Advanced/CoreBuy.lua $", "$Rev: 4696 $")
