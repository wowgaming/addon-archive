--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: BeanCounterMail.lua 4713 2010-04-13 00:09:44Z Nechckn $
	URL: http://auctioneeraddon.com/

	BeanCounterMail - Handles recording of all auction house related mail

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
LibStub("LibRevision"):Set("$URL: http://svn.norganna.org/auctioneer/branches/5.8/BeanCounter/BeanCounterMail.lua $","$Rev: 4713 $","5.1.DEV.", 'auctioneer', 'libs')

local lib = BeanCounter
local private, print, get, set, _BC = lib.getLocals() --_BC localization function

local _G = _G
local pairs,ipairs,select,type = pairs,ipairs,select,type
local tonumber,tostring,format = tonumber,tostring,format
local tinsert,tremove = tinsert,tremove
local strsplit = strsplit
local time = time
local GetTime = GetTime
local floor = floor

local function debugPrint(...)
    if get("util.beancounter.debugMail") then
        private.debugPrint("BeanCounterMail",...)
    end
end

local expiredLocale = AUCTION_EXPIRED_MAIL_SUBJECT:gsub("(.+)%%s", "%1")
local salePendingLocale = AUCTION_INVOICE_MAIL_SUBJECT:gsub("(.+)%%s", "%1") --sale pending
local outbidLocale = AUCTION_OUTBID_MAIL_SUBJECT:gsub("(.+)%%s", "%1")
local cancelledLocale = AUCTION_REMOVED_MAIL_SUBJECT:gsub("(.+)%%s", "%1")
local successLocale = AUCTION_SOLD_MAIL_SUBJECT:gsub("(.+)%%s", "%1")
local wonLocale = AUCTION_WON_MAIL_SUBJECT:gsub("(.+)%%s", "%1")
--[[
Essamyns improved parser. Need to test before comiting	
local expiredLocale = AUCTION_EXPIRED_MAIL_SUBJECT:gsub("%%s", "(.+)")
local salePendingLocale = AUCTION_INVOICE_MAIL_SUBJECT:gsub("%%s", "(.+)") --sale pending
local outbidLocale = AUCTION_OUTBID_MAIL_SUBJECT:gsub("%%s", "(.+)")
local cancelledLocale = AUCTION_REMOVED_MAIL_SUBJECT:gsub("%%s", "(.+)")
local successLocale = AUCTION_SOLD_MAIL_SUBJECT:gsub("%%s", "(.+)")
local wonLocale = AUCTION_WON_MAIL_SUBJECT:gsub("%%s", "(.+)")
]]
local reportTotalMail, reportAHMail, reportReadMail, reportAlreadyReadMail = 0, 0, 0, 0 --Used as a debug check on mail scanning engine

local registeredAltaholicHook = false
local registeredInboxFrameHook = false
function private.mailMonitor(event,arg1)
	if (event == "MAIL_INBOX_UPDATE") then
		private.updateInboxStart()
			
	elseif (event == "MAIL_SHOW") then
		private.inboxStart = {} --clear the inbox list, if we errored out this should give us a fresh start.
		if not registeredInboxFrameHook then --make sure we only ever register this hook once
			registeredInboxFrameHook = true
			hooksecurefunc("InboxFrame_OnClick", private.mailFrameClick)
			hooksecurefunc("InboxFrame_Update", private.mailFrameUpdate)
		end
		--We cannot use mail show since the GetInboxNumItems() returns 0 till the first "MAIL_INBOX_UPDATE"

	elseif (event == "MAIL_CLOSED") then
		private.HideMailGUI()
		private.sumDatabase() --Sum total fo DB for the display on browse pane
	end
end

--[[Watch who reads the mail. and what they read. Use this to play nicely with altaholic and other addons]]
private.mailReadOveride = {}
function private.PreGetInboxTextHook(n, ...)
	if n and n > 0 then
		local _, _, sender, subject, money, _, daysLeft, _, wasRead, _, _, _ = GetInboxHeaderInfo(n)
		if sender and subject and not wasRead then
			--print("they read", n, sender, subject)
			private.mailReadOveride[n] = sender..n
		elseif wasRead then
			--print("Already read", n, sender, subject) 
		end
	end
	return private.GetInboxText(n, ...)
end
--hook and replace GetInboxText()
private.GetInboxText = GetInboxText
GetInboxText = private.PreGetInboxTextHook

--New function to hide/unhide mail GUI.
local HideMailGUI
function private.HideMailGUI( hide )
	if hide then
		HideMailGUI = true
		InboxCloseButton:Hide()
		InboxFrame:Hide()
		MailFrameTab2:Hide()
		private.MailGUI:Show()
		private.wipeSearchCache() --clear the search cache, we are updating data so it is now outdated
	else
		HideMailGUI = false
		InboxCloseButton:Show()
		InboxFrame:Show()
		MailFrameTab2:Show()
		private.MailGUI:Hide()
		private.wipeSearchCache() --clear the search cache, we are updating data so it is now outdated
	end
end
--Mailbox Snapshots
function private.updateInboxStart()
	reportTotalMail = GetInboxNumItems()
	for n = reportTotalMail, 1, -1 do
		local _, _, sender, subject, money, _, daysLeft, _, wasRead, _, _, _ = GetInboxHeaderInfo(n)
		if sender and subject and (not wasRead or private.mailReadOveride[n]) then
			local auctionHouse --A, H, N flag for which AH the trxn came from
			if sender ==_BC('MailAllianceAuctionHouse') then
				auctionHouse = "A"
			elseif sender == _BC('MailHordeAuctionHouse') then
				auctionHouse = "H"
			elseif sender == _BC('MailNeutralAuctionHouse') then
				auctionHouse = "N"
			end
			if auctionHouse then
				private.HideMailGUI(true)
				reportAHMail = reportAHMail + 1
				wasRead = wasRead or 0 --its nil unless its has been read
				local itemLink = GetInboxItemLink(n, 1)
				local _, _, stack, _, _ = GetInboxItem(n)
				local invoiceType, itemName, playerName, bid, buyout, deposit, consignment, retrieved, startTime = private.getInvoice(n,sender, subject)
				tinsert(private.inboxStart, {["n"] = n, ["sender"]=sender, ["subject"]=subject,["money"]=money, ["read"]=wasRead, ["age"] = daysLeft,
						["invoiceType"] = invoiceType, ["itemName"] = itemName, ["Seller/buyer"] = playerName, ['bid'] = bid, ["buyout"] = buyout,
						["deposit"] = deposit, ["fee"] = consignment, ["retrieved"] = retrieved, ["startTime"] = startTime, ["itemLink"] = itemLink, ["stack"] = stack, ["auctionHouse"] = auctionHouse,
						})
				private.GetInboxText(n) --read message
			end
			reportReadMail = reportReadMail + 1
		end
		private.lastCheckedMail = GetTime() --this keeps us from hiding the mail UI to early and causing flicker
	end
	private.mailReadOveride = {}
	private.wipeSearchCache() --clear the search cache, we are updating data so it is now outdated
end

function private.getInvoice(n, sender, subject)
	if sender:match(_BC('MailAllianceAuctionHouse')) or sender:match(_BC('MailHordeAuctionHouse')) or sender:match(_BC('MailNeutralAuctionHouse')) then
		if subject:match(successLocale) or subject:match(wonLocale) then
			local invoiceType, itemName, playerName, bid, buyout, deposit, consignment = GetInboxInvoiceInfo(n)
			if invoiceType and playerName and playerName ~= "" and bid and bid > 0 then --Silly name throttling lead to missed invoice lookups
				--debugPrint("getInvoice", invoiceType, itemName, playerName, bid, buyout, deposit, consignment, "yes")
				return invoiceType, itemName, playerName, bid, buyout, deposit, consignment, "yes", time()
			else
				--debugPrint("getInvoice", invoiceType, itemName, playerName, bid, buyout, deposit, consignment, "no")
				return invoiceType, itemName, playerName, bid, buyout, deposit, consignment, "no", time()
			end
		end
	end
	return
end

private.lastCheckedMail = GetTime()
function private.mailonUpdate()
	local total = #private.inboxStart
	if total > 0 then
		for i = total, 1, -1 do -- in pairs(private.inboxStart) do
			--update mail GUI Count
			local count = #private.inboxStart
			private.CountGUI:SetText("Recording: "..total-count.." of "..total.." items")
					
			local data = private.inboxStart[i]
			if not data.retrieved then --Send non invoiceable mails through
				tinsert(private.reconcilePending, data)
				--private.inboxStart[i] = nil
				tremove(private.inboxStart, i)
				--debugPrint("not a invoice mail type", i)

			elseif  data.retrieved == "failed" then
				tinsert(private.reconcilePending, data)
				--private.inboxStart[i] = nil
				tremove(private.inboxStart, i)
				--debugPrint("data.retrieved == failed", i)

			elseif  data.retrieved == "yes" then
				tinsert(private.reconcilePending, data)
				--private.inboxStart[i] = nil
				tremove(private.inboxStart, i)
				--debugPrint("data.retrieved == yes", i)

			elseif  time() - data.startTime > get("util.beacounter.invoicetime") then --time exceded so fail it and process on next update
				debugPrint("time to retrieve invoice exceeded, most likely waiting on players name if this is blank>..", data["Seller/buyer"], i)
				data["retrieved"] = "failed" --time to get invoice exceded
			else
				--debugPrint("Invoice retieve attempt",data["subject"])
				data["invoiceType"], data["itemName"], data["Seller/buyer"], data['bid'], data["buyout"] , data["deposit"] , data["fee"], data["retrieved"], _ = private.getInvoice(data.n, data.sender, data.subject)
			end
		end
	end
	if (#private.inboxStart == 0) and (HideMailGUI == true) and (private.lastCheckedMail + 1 < GetTime() ) then --time delay added to prevent possible flicker
		--debugPrint("Total Mail in inbox:{{", reportTotalMail, "}}Had alredy been read:{{", reportAlreadyReadMail, "}}Mails to read:{{",reportReadMail, "}}Mail from AH:{{", reportAHMail, "}}")
		reportTotalMail, reportAHMail, reportReadMail = 0, 0, 0
		private.HideMailGUI( )
		private.mailBoxColorStart() --delay recolor system till we have had a chance to read the mail
	end

	if (#private.reconcilePending > 0) then
		private.mailSort()
	end
end

function private.mailSort()
	for i in pairs(private.reconcilePending) do
		--Get Age of message for timestamp
		local messageAgeInSeconds = floor((30 - private.reconcilePending[i]["age"]) * 24 * 60 * 60)
		private.reconcilePending[i]["time"] = (time() - messageAgeInSeconds)

		if private.reconcilePending[i]["sender"]:match(_BC('MailAllianceAuctionHouse')) or private.reconcilePending[i]["sender"]:match(_BC('MailHordeAuctionHouse')) or private.reconcilePending[i]["sender"]:match(_BC('MailNeutralAuctionHouse')) then
			if private.reconcilePending[i].subject:match(successLocale) and (private.reconcilePending[i].retrieved == "yes" or private.reconcilePending[i].retrieved == "failed") then
				private.sortCompletedAuctions( i )

			elseif private.reconcilePending[i].subject:match(expiredLocale)then
				private.sortFailedAuctions( i )

			elseif private.reconcilePending[i].subject:match(wonLocale) and (private.reconcilePending[i].retrieved == "yes" or private.reconcilePending[i].retrieved == "failed") then
				private.sortCompletedBidsBuyouts( i )

			elseif private.reconcilePending[i].subject:match(outbidLocale) then
				private.sortFailedBids( i )

			elseif private.reconcilePending[i].subject:match(cancelledLocale) then
				private.sortCancelledAuctions( i )
	
			elseif private.reconcilePending[i].subject:match(salePendingLocale) then
				--ignore We dont care about this message
				tremove(private.reconcilePending,i)
			else
				debugPrint("We had an Auction mail that failed mailsort()", private.reconcilePending[i].subject)
				tremove(private.reconcilePending,i)
			end
		else --if its not AH do we care? We need to record cash arrival from other toons
			debugPrint("OTHER", private.reconcilePending[i].subject)
			tremove(private.reconcilePending, i)

		end
	end
end
--retrieves the itemID from the DB
function private.matchDB(text)
	local itemID
	for itemKey, data in pairs(BeanCounterDB.ItemIDArray) do
		local _, name = strsplit(";", data)
		if text == name then
			itemID = string.split(":", itemKey)
			local itemLink = lib.API.createItemLinkFromArray(itemKey)
			--debugPrint("|CFFFFFF00Searching",data,"for",text,"Sucess: link is",itemLink)
			return itemID, itemLink
		end
	end
	debugPrint("Searching DB for ItemID..", text, "Failed Item does not exist in the name array")
	return nil
end

function private.sortCompletedAuctions( i )
	--Get itemID from database
	local itemName = private.reconcilePending[i].subject:match(successLocale.."(.*)")
	local itemID, itemLink = private.matchDB(itemName)
	if itemID then  --Get the Bid and stack size if possible
		local stack, bid = private.findStackcompletedAuctions("postedAuctions", itemID, itemLink, private.reconcilePending[i].deposit, private.reconcilePending[i]["buyout"], private.reconcilePending[i]["time"])
		if stack then
			local value = private.packString(stack, private.reconcilePending[i]["money"], private.reconcilePending[i]["deposit"], private.reconcilePending[i]["fee"], private.reconcilePending[i]["buyout"], bid, private.reconcilePending[i]["Seller/buyer"], private.reconcilePending[i]["time"], "", private.reconcilePending[i]["auctionHouse"])
			if private.reconcilePending[i]["auctionHouse"] == "A" or private.reconcilePending[i]["auctionHouse"] == "H" then
				private.databaseAdd("completedAuctions", itemLink, nil, value)
				--debugPrint("databaseAdd completedAuctions", itemID, itemLink)
			else
				private.databaseAdd("completedAuctionsNeutral", itemLink, nil, value)
			end
		else
			debugPrint("Failure for completedAuctions", itemID, itemLink, "index", private.reconcilePending[i].n)
		end
	end
	tremove(private.reconcilePending, i)
end
--Find the stack information in postedAuctions to add into the completedAuctions DB on mail arrivial
function private.findStackcompletedAuctions(key, itemID, itemLink, soldDeposit, soldBuy, soldTime)
	if not private.playerData[key][itemID] then return end --if no keys present abort

	local soldDeposit, soldBuy, soldTime ,oldestPossible = tonumber(soldDeposit), tonumber(soldBuy), tonumber(soldTime), tonumber(soldTime - 173400) --48H 15min oldest we will go back
	--ItemLink will be used minus its unique ID
	local itemString  =  lib.API.getItemString(itemLink)
	itemString = itemString:match("(item:.+):.-:.-")-- ignore Unique ID
	
	for i,v in pairs (private.playerData[key][itemID]) do
		if i:match(itemString) or i == itemString then
			for index, text in pairs(v) do
				if not text:match(".*USED.*") then
					local postStack, postBid, postBuy, postRunTime, postDeposit, postTime, postReason = strsplit(";", private.playerData[key][itemID][i][index])
					 postDeposit, postBuy, postBid, postTime = tonumber(postDeposit), tonumber(postBuy), tonumber(postBid), tonumber(postTime)
					--if the deposits and buyouts match, check if time range would make this a possible match
					 if postDeposit == soldDeposit and postBuy >= soldBuy and postBid <= soldBuy then --We may have sold it on a bid so we need to loosen this search
						if (soldTime > postTime) and (oldestPossible < postTime) then
							tremove(private.playerData[key][itemID][i], index) --remove the matched item From postedAuctions DB
							--private.playerData[key][itemID][i][index] = private.playerData[key][itemID][i][index]..";USED Sold"
							--debugPrint("postedAuction removed as sold", itemID, itemLink)
							return tonumber(postStack), tonumber(postBid)
						end
					end
				
				end
			end
		end
	end
	--return 1 if the item is nonstackable and no match was found
	if private.getItemInfo(itemID, "stack") == 1 then return 1 end
end

function private.sortFailedAuctions( i )
	local itemID =  lib.API.decodeLink(private.reconcilePending[i]["itemLink"])
	if itemID then
		local stack, bid, buyout, deposit = private.findStackfailedAuctions("postedAuctions", itemID, private.reconcilePending[i]["itemLink"], private.reconcilePending[i]["stack"], private.reconcilePending[i]["time"])
		if stack then
			local value = private.packString(stack, "", deposit , "", buyout, bid, "", private.reconcilePending[i]["time"], "", private.reconcilePending[i]["auctionHouse"])
			if private.reconcilePending[i]["auctionHouse"] == "A" or private.reconcilePending[i]["auctionHouse"] == "H" then
				private.databaseAdd("failedAuctions", private.reconcilePending[i]["itemLink"], nil, value)
				--debugPrint("databaseAdd failedAuctions", itemID, private.reconcilePending[i]["itemLink"])
			else
				private.databaseAdd("failedAuctionsNeutral", private.reconcilePending[i]["itemLink"], nil, value)
			end
		else
			debugPrint("Failure for failedAuctions", itemID, private.reconcilePending[i]["itemLink"], "index", private.reconcilePending[i].n)
		end
	end
	tremove(private.reconcilePending, i, private.reconcilePending[i]["itemLink"])
end
--find stack, bid and buy info for failedauctions
function private.findStackfailedAuctions(key, itemID, itemLink, returnedStack, expiredTime)
	if not private.playerData[key][itemID] then return end --if no keys present abort
	local itemString = lib.API.getItemString(itemLink) --use the UniqueID stored to match this
 	for i,v in pairs (private.playerData[key][itemID]) do
		if i:match(itemString) or i == itemString then --we still stack check and data range check but match should be assured by now
 			for index, text in pairs(v) do
				if not text:match(".*USED.*") then
			
				local postStack, postBid, postBuy, postRunTime, postDeposit, postTime, postReason = strsplit(";", private.playerData[key][itemID][i][index])
					if returnedStack == tonumber(postStack) then --stacks same see if we can match time
						local timeAuctionPosted, timeFailedAuctionStarted = tonumber(postTime), tonumber(expiredTime - (postRunTime * 60)) --Time this message should have been posted
						if (timeAuctionPosted - 7200) <= timeFailedAuctionStarted and timeFailedAuctionStarted <= (timeAuctionPosted + 7200) then
							tremove(private.playerData[key][itemID][i], index) --remove the matched item From postedAuctions DB
							--private.playerData[key][itemID][i][index] = private.playerData[key][itemID][i][index]..";USED Failed"
							--debugPrint("postedAuction removed as Failed", itemID, itemLink )
							return postStack, postBid, postBuy, postDeposit
						end
					end
				
				end
 			end
		end
	end
end

--Cancled auctions are stored and treated as failed auctions with just cancelled added as the reason tag
function private.sortCancelledAuctions( i )	
	local itemID =  lib.API.decodeLink(private.reconcilePending[i]["itemLink"])
	if itemID then
		local stack, bid, buyout, deposit = private.findStackCancelledAuctions("postedAuctions", itemID, private.reconcilePending[i]["itemLink"], private.reconcilePending[i]["stack"], private.reconcilePending[i]["time"])
		if stack then
			local value = private.packString(stack, "", deposit , "", buyout, bid, "", private.reconcilePending[i]["time"], _BC('Cancelled'), private.reconcilePending[i]["auctionHouse"])
			if private.reconcilePending[i]["auctionHouse"] == "A" or private.reconcilePending[i]["auctionHouse"] == "H" then
				private.databaseAdd("failedAuctions", private.reconcilePending[i]["itemLink"], nil, value)
				--debugPrint("databaseAdd failedAuctions", itemID, private.reconcilePending[i]["itemLink"])
			else
				private.databaseAdd("failedAuctionsNeutral", private.reconcilePending[i]["itemLink"], nil, value)
			end
		else
			debugPrint("Failure for cancelledAuctions", itemID, private.reconcilePending[i]["itemLink"], "index", private.reconcilePending[i].n)
		end
	end
	tremove(private.reconcilePending, i, private.reconcilePending[i]["itemLink"])
end
--find stack, bid and buy info for Cancelledauctions
function private.findStackCancelledAuctions(key, itemID, itemLink, returnedStack, expiredTime)
	if not private.playerData[key][itemID] then return end --if no keys present abort
	local itemString = lib.API.getItemString(itemLink) --use the UniqueID stored to match this
 	for i,v in pairs (private.playerData[key][itemID]) do
		if i:match(itemString) or i == itemString then --we still stack check and data range check but match should be assured by now
 			for index, text in pairs(v) do
				if not text:match(".*USED.*") then
					local postStack, postBid, postBuy, postRunTime, postDeposit, postTime, postReason = strsplit(";", private.playerData[key][itemID][i][index])
					if returnedStack == tonumber(postStack) then --stacks same see if we can match time
						local timeAuctionPosted, timeCancelledAuctionStarted = tonumber(postTime), tonumber(expiredTime - (postRunTime * 60)) --Earrliest time we could have posted the auction
						if (timeAuctionPosted - 7200) > (timeCancelledAuctionStarted) then --cancelled auctions could have just been posted so no way to age check beyond oldest possible
							tremove(private.playerData[key][itemID][i], index) --remove the matched item From postedAuctions DB
							--private.playerData[key][itemID][i][index] = private.playerData[key][itemID][i][index]..";USED Cancelled"
							--debugPrint("postedAuction removed as Cancelled", itemID, itemLink )
							return postStack, postBid, postBuy, postDeposit
						end
					end
				
				end
 			end
		end
	end
end
 --No need to reconcile, all needed data has been provided in the invoice We do need to clear entries so outbid has less to wade through
function private.sortCompletedBidsBuyouts( i )
	local itemID = lib.API.decodeLink(private.reconcilePending[i]["itemLink"])
	local reason = private.findCompletedBids(itemID, private.reconcilePending[i]["Seller/buyer"], private.reconcilePending[i]["bid"], private.reconcilePending[i]["itemLink"])
	if itemID then
		--For a Won Auction money, deposit, fee are always 0  so we can use them as placeholders for BeanCounter Data
		local value = private.packString(private.reconcilePending[i]["stack"], private.reconcilePending[i]["money"], deposite, private.reconcilePending[i]["fee"], private.reconcilePending[i]["buyout"], private.reconcilePending[i]["bid"], private.reconcilePending[i]["Seller/buyer"], private.reconcilePending[i]["time"], reason, private.reconcilePending[i]["auctionHouse"])
		if private.reconcilePending[i]["auctionHouse"] == "A" or private.reconcilePending[i]["auctionHouse"] == "H" then
			private.databaseAdd("completedBidsBuyouts", private.reconcilePending[i]["itemLink"], nil, value)
		else
			private.databaseAdd("completedBidsBuyoutsNeutral", private.reconcilePending[i]["itemLink"], nil, value)
		end
		--debugPrint("databaseAdd completedBidsBuyouts", itemID, private.reconcilePending[i]["itemLink"])
	else
		debugPrint("Failure for completedBidsBuyouts", itemID, private.reconcilePending[i]["itemLink"], value, "index", private.reconcilePending[i].n)
	end

	tremove(private.reconcilePending,i)
end
--Used only to clear postedBid entries so failed bids is less likely to miss
function private.findCompletedBids(itemID, seller, bid, itemLink)
	local bid = tonumber(bid)
	local itemString = lib.API.getItemString(itemLink) --use the UniqueID stored to match this
	--debugPrint("Starting search to remove posted Bid")
	if private.playerData["postedBids"][itemID] and private.playerData["postedBids"][itemID][itemString] then
		for index, text in pairs(private.playerData["postedBids"][itemID][itemString]) do
			if not text:match(".*USED.*") then
				local postStack, postBid, postSeller, isBuyout, postTimeLeft, postTime, reason = private.unpackString(text)
				postStack, postBid = tonumber(postStack), tonumber(postBid)
				--if seller ==  postSeller and postBid == bid then --Seller is mostly useless thanks to blizzards item name cahce chamges. Can often be nil  esp after a getall
				if postBid == bid then
					tremove(private.playerData["postedBids"][itemID][itemString], index) --remove the matched item From postedBids DB
					--private.playerData["postedBids"][itemID][itemString][index] = private.playerData["postedBids"][itemID][itemString][index] ..";USED WON"
					--debugPrint("posted Bid removed as Won", itemString, index, reason)
					return reason --return the reason code provided for why we bid/bought item
				end
			end
		end
	end
end
function private.sortFailedBids( i )
	local itemName = private.reconcilePending[i].subject:match(outbidLocale.."(.*)")
	local itemID, itemLink = private.matchDB(itemName)
	local postStack, postSeller, reason = private.findFailedBids(itemID, itemLink, private.reconcilePending[i]["money"])
	if itemID then
		local value = private.packString(postStack, "", "", "", "", private.reconcilePending[i]["money"], postSeller, private.reconcilePending[i]["time"], reason, private.reconcilePending[i]["auctionHouse"])
		if private.reconcilePending[i]["auctionHouse"] == "A" or private.reconcilePending[i]["auctionHouse"] == "H" then
			private.databaseAdd("failedBids", itemLink, nil, value)
		else
			private.databaseAdd("failedBidsNeutral", itemLink, nil, value)
		end
		--debugPrint("databaseAdd failedBids", itemID, itemLink, value)
	else
		debugPrint("Failure for failedBids", itemID, itemLink, "index", private.reconcilePending[i].n)
	end
	tremove(private.reconcilePending,i)
end
function private.findFailedBids(itemID, itemLink, gold)
	gold = tonumber(gold)
	if not itemLink then debugPrint("Failed auction ItemStrig nil", itemID, itemLink) return end
	local itemString = lib.API.getItemString(itemLink) --use the UniqueID stored to match this
	if private.playerData["postedBids"][itemID] and private.playerData["postedBids"][itemID][itemString] then
		for index, text in pairs(private.playerData["postedBids"][itemID][itemString]) do
 			if not text:match(".*USED.*") then
				local postStack, postBid, postSeller, isBuyout, postTimeLeft, postTime, reason = private.unpackString(text)
				if tonumber(postBid) == gold then
					tremove(private.playerData["postedBids"][itemID][itemString], index) --remove the matched item From postedBids DB
					--private.playerData["postedBids"][itemID][itemString][index] = private.playerData["postedBids"][itemID][itemString][index] ..";USED FAILED"
					--debugPrint("posted Bid removed as Failed", itemString, index)
					return postStack, postSeller, reason
				end
			end
		end
	end
end
--Hook, take money event, if this still has an unretrieved invoice we delay X sec or invoice retrieved
local inboxHookMessage = false --Stops spam of the message.
function private.PreTakeInboxMoneyHook(funcArgs, retVal, index, ignore)
	if #private.inboxStart > 0 or HideMailGUI then
		if not inboxHookMessage then
			print("Please allow BeanCounter time to reconcile the mail box")
			inboxHookMessage = true
		end
		return "abort"
	end
end

--Hook, take item event, if this still has an unretrieved invoice we delay X sec or invoice retrieved
function private.PreTakeInboxItemHook( ignore, retVal, index)
	if #private.inboxStart > 0 or HideMailGUI then
		if not inboxHookMessage then
			print("Please allow BeanCounter time to reconcile the mail box")
			inboxHookMessage = true
		end
		return "abort"
	end
end

--[[
The below code manages the mailboxes Icon color /read/unread status

]]--
function private.mailFrameClick(self, index)
	if BeanCounterDB[private.realmName][private.playerName]["mailbox"][index] then
		BeanCounterDB[private.realmName][private.playerName]["mailbox"][index]["read"] = 2
	end
end

local NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR = NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR

function private.mailFrameUpdate()
	--Change Icon back color if only addon read
	local db = BeanCounterDB[private.realmName][private.playerName]
	if not db["mailbox"] then return end  --we havn't read mail yet
	if get("util.beancounter.mailrecolor") == "off" then return end

	local numItems = GetInboxNumItems()
	local  index
	if (InboxFrame.pageNum * 7) < numItems then
		index = 7
	else
		index = 7 - ((InboxFrame.pageNum * 7) - numItems)
	end
	for i = 1, index do
		local basename=format("MailItem%d",i)
		local button = _G[basename.."Button"]
		local buttonIcon = _G[basename.."ButtonIcon"]
		local senderText = _G[basename.."Sender"]
		local subjectText = _G[basename.."Subject"]
		button:Show()

		local itemindex = ((InboxFrame.pageNum * 7) - 7 + i) --this gives us the actual itemindex as oposed to teh 1-7 button index
		local _, _, sender, subject, money, _, daysLeft, _, wasRead, _, _, _ = GetInboxHeaderInfo(itemindex)
		if db["mailbox"][itemindex] then
			local sender = db["mailbox"][itemindex]["sender"]
			if sender and (sender:match(_BC('MailHordeAuctionHouse')) or sender:match(_BC('MailAllianceAuctionHouse')) or sender:match(_BC('MailNeutralAuctionHouse'))) then
				if (db["mailbox"][itemindex]["read"] < 2) then
					if get("util.beancounter.mailrecolor") == "icon" or get("util.beancounter.mailrecolor") == "both" then
						_G[basename.."ButtonSlot"]:SetVertexColor(1.0, 0.82, 0)
						SetDesaturation(buttonIcon, nil)
					end
					if get("util.beancounter.mailrecolor") == "text" or get("util.beancounter.mailrecolor") == "both" then
						senderText:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
						subjectText:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
					end
				end
			end
		end
	end

end
--CHANGE THIS TO REVERSE ORDER
local mailCurrent
local group = {["n"] = "", ["start"] = 1, ["end"] = 1} --stores the start and end locations for a group of same name items
function private.mailBoxColorStart()
	mailCurrent = {} --clean table every update
	local db=BeanCounterDB[private.realmName][private.playerName]

	for n = 1,GetInboxNumItems() do
		local _, _, sender, subject, money, _, daysLeft, _, wasRead, _, _, _ = GetInboxHeaderInfo(n);
		mailCurrent[n] = {["time"] = daysLeft ,["sender"] = sender, ["subject"] = subject, ["read"] = wasRead or 0 }
	end

	--Fix reported errors of mail DB not existing for some reason.
	if not db["mailbox"] then db["mailbox"] = {} end
	--Create Characters Mailbox, or resync if we get more that 5 mails out of tune
	if #db["mailbox"] > (#mailCurrent+2) or #db["mailbox"] == 0 then
		--debugPrint("Mail tables too far out of sync, resyncing #mailCurrent", #mailCurrent,"#mailData" ,#BeanCounterDB[private.realmName][private.playerName]["mailbox"])
		db["mailbox"] = {}
		for i, v in pairs(mailCurrent) do
			db["mailbox"][i] = v
		end
	end

	if #db["mailbox"] >= #mailCurrent then --mail removed or same
		for i in ipairs(mailCurrent) do
			if db["mailbox"][i]["subject"] == group["n"] then
				if group["start"] then group["end"] = i else group["start"] = i end
			else
				group["n"], group["start"], group["end"] = db["mailbox"][i]["subject"], i, i
			end

			if mailCurrent[i]["subject"] ~= db["mailbox"][i]["subject"] then
				--debugPrint("group = ",group["n"], group["start"], group["end"])
				if db["mailbox"][i]["read"] == 2 then
					--debugPrint("This is marked read so removing ", i)
					tremove(db["mailbox"], i)
					break
				elseif db["mailbox"][i]["read"] < 2 then
	--This message has not been read, so we have a sequence of messages with the same name. Need to go back recursivly till we find the "Real read" message that need removal
					for V = group["end"], group["start"], -1 do
						if db["mailbox"][V]["read"] == 2 then
							--debugPrint("recursive read group",group["end"] ,"--",group["start"], "found read at",V )
							tremove(db["mailbox"], V)
							break
						end
					end
				end
				break
			end
		end
	elseif #db["mailbox"] < #mailCurrent then --mail added
		for i,v in ipairs(mailCurrent) do
			if db["mailbox"][i] then
				if mailCurrent[i]["subject"] ~=  db["mailbox"][i]["subject"] then
					--debugPrint("#private.mailData < #mailCurrent adding", i, mailCurrent[i]["subject"])
					tinsert(db["mailbox"], i, v)
				end
			else
			--debugPrint("need to add key ", i)
				tinsert(db["mailbox"], i, v)
			end
		end

	end
	private.mailFrameUpdate()
	private.hasUnreadMail()
end

function private.hasUnreadMail()
	--[[if HasNewMail() then MiniMapMailFrame:Show() debugPrint("We have real unread mail, mail icon show/hide code bypassed") return end  --no need to process if we have real unread messages waiting
	if not get("util.beancounter.mailrecolor") then MiniMapMailFrame:Hide() return end --no need to do this if user isn't using recolor system, and mail icon should not show since HasnewMail() failed

	local mailunread = false
	for i,v in pairs(BeanCounterDB[private.realmName][private.playerName]["mailbox"]) do
		if BeanCounterDB[private.realmName][private.playerName]["mailbox"][i]["read"] < 2 then
		    mailunread = true
		end
	end
	if mailunread then
		lib.SetSetting("util.beancounter.hasUnreadMail", true)
		MiniMapMailFrame:Show()
	else
		lib.SetSetting("util.beancounter.hasUnreadMail", false)
		MiniMapMailFrame:Hide()
	end]]
end
