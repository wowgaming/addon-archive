--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: BidMonitor.lua 4426 2009-08-28 01:39:55Z kandoko $
	URL: http://auctioneeraddon.com/

	BidMonitor - Records bids posted in the Auctionhouse

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
LibStub("LibRevision"):Set("$URL: http://svn.norganna.org/auctioneer/branches/5.8/BeanCounter/BidMonitor.lua $","$Rev: 4426 $","5.1.DEV.", 'auctioneer', 'libs')

local libName = "BeanCounter"
local libType = "Util"
local lib = BeanCounter
local private, print, get, set, _BC = lib.getLocals()

local function debugPrint(...)
    if get("util.beancounter.debugBid") then
        private.debugPrint("BidMonitor",...)
    end
end

-------------------------------------------------------------------------------
-- Called after PlaceAuctionBid()
-------------------------------------------------------------------------------
function private.postPlaceAuctionBidHook(_, _, listType, index, bid)
	local name, texture, count, quality, canUse, level, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, owner = GetAuctionItemInfo(listType, index)
	local itemLink = GetAuctionItemLink(listType, index)
	local timeLeft = GetAuctionItemTimeLeft(listType, index)
	if (name and count and bid) then
		private.addPendingBid(name, count, bid, owner, (bid == buyoutPrice), highBidder, timeLeft, itemLink)
	end
end

-------------------------------------------------------------------------------
-- Adds a pending bid to the queue.
-------------------------------------------------------------------------------
function private.addPendingBid(name, count, bid, owner, isBuyout, isHighBidder, timeLeft, itemLink)
	-- Add a pending bid to the queue.
	local pendingBid = {}
	pendingBid.name = name
	pendingBid.count = count
	pendingBid.bid = bid
	pendingBid.owner = owner
	pendingBid.isBuyout = isBuyout
	pendingBid.isHighBidder = isHighBidder
	pendingBid.timeLeft = timeLeft
	pendingBid.itemLink = itemLink
	table.insert(private.PendingBids, pendingBid)
	debugPrint("addPendingBid() - Added pending bid")

	-- Register for the response events if this is the first pending bid.
	if (#private.PendingBids == 1) then
		debugPrint("addPendingBid() - Registering for CHAT_MSG_SYSTEM and UI_ERROR_MESSAGE")
		Stubby.RegisterEventHook("CHAT_MSG_SYSTEM", "BeanCounter_BidMonitor", private.onEventHookBid)
		Stubby.RegisterEventHook("UI_ERROR_MESSAGE", "BeanCounter_BidMonitor", private.onEventHookBid)
	end
end

-------------------------------------------------------------------------------
-- Removes the pending bid from the queue.
-------------------------------------------------------------------------------
function private.removePendingBid()
	if (#private.PendingBids > 0) then
		-- Remove the first pending bid.
		local bid = private.PendingBids[1]
		table.remove(private.PendingBids, 1)
		debugPrint("removePendingBid() - Removed pending bid")

		-- Unregister for the response events if this is the last pending bid.
		if (#private.PendingBids == 0) then
			debugPrint("removePendingBid() - Unregistering for CHAT_MSG_SYSTEM and UI_ERROR_MESSAGE")
			Stubby.UnregisterEventHook("CHAT_MSG_SYSTEM", "BeanCounter_BidMonitor", private.onEventHookBid)
			Stubby.UnregisterEventHook("UI_ERROR_MESSAGE", "BeanCounter_BidMonitor", private.onEventHookBid)
		end

		return bid
	end

	-- No pending bid to remove!
	return nil
end

-------------------------------------------------------------------------------
-- OnEvent handler BIDS. these are unhooked when not needed
-------------------------------------------------------------------------------
function private.onEventHookBid(_, event, arg1)
	if (event == "CHAT_MSG_SYSTEM" and arg1) then
		if (arg1 == ERR_AUCTION_BID_PLACED) then
		 	private.onBidAccepted()
		end
	elseif (event == "UI_ERROR_MESSAGE" and arg1) then
		if (arg1) then debugPrint("    "..arg1) end
		if (arg1 == ERR_ITEM_NOT_FOUND or
			arg1 == ERR_NOT_ENOUGH_MONEY or
			arg1 == ERR_AUCTION_BID_OWN or
			arg1 == ERR_AUCTION_HIGHER_BID or
			arg1 == ERR_ITEM_MAX_COUNT) then
			private.onBidFailed()
		end
	end
end

-------------------------------------------------------------------------------
-- Called when a bid is accepted by the server.
-------------------------------------------------------------------------------
function private.onBidAccepted()
	local bid = private.removePendingBid()
	if (bid) then

	local itemID = lib.API.decodeLink(bid.itemLink)
	local text = private.packString(bid.count, bid.bid, bid.owner, bid.isBuyout, bid.timeLeft, time(), "")
		debugPrint(bid.isBuyout, bid.isHighBidder)
		--we use the bid/buy data for storing "BTM/SearchUI reasons" and outbid data
		if (bid.isBuyout) then
			if bid.isHighBidder then-- If the player is buying out an auction they already bid on, we need to remove the pending bid
				debugPrint('private.databaseRemove(',"postedBids", itemID, bid.name, bid.owner, bid.bid)
				private.databaseRemove("postedBids", itemID, bid.itemLink, bid.owner, bid.count) --remove old entry
			end
			debugPrint('private.databaseAdd(pendingBids', itemID, text)
			private.databaseAdd("postedBids", bid.itemLink, nil, text) --replace with buyout entry.
		else
		debugPrint('private.databaseAdd(pendingBids', itemID, text)
		private.databaseAdd("postedBids", bid.itemLink, nil, text)
		end
	end
end

-------------------------------------------------------------------------------
-- Called when a bid is rejected by the server.
-------------------------------------------------------------------------------
function private.onBidFailed()
	private.removePendingBid()
end
