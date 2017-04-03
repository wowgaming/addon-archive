--[[
	Auctioneer
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: CorePost.lua 4696 2010-03-24 22:04:27Z Nechckn $
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
	Auctioneer Posting Engine.

	This code helps modules that need to post things to do so in an extremely easy and
	queueable fashion.

	This code takes "sigs" as input to most of it's functions. A "sig" is a string containing
	a colon seperated concatenation of itemId:suffixId:suffixFactor:enchantId
	A sig must be shortened by truncating trailing 0's - this is required for equality testing
	Any missing values at the end will be set to zero when the sig is decoded
	The function AucAdvanced.API.GetSigFromLink(link) may be used to construct a valid sig
]]
if not AucAdvanced then return end

if (not AucAdvanced.Post) then AucAdvanced.Post = {} end

local lib = AucAdvanced.Post
local private = {}
lib.Private = private

lib.Print = AucAdvanced.Print
local Const = AucAdvanced.Const
local print = lib.Print
local debugPrint = AucAdvanced.Debug.DebugPrint
local _TRANS = AucAdvanced.localizations
local DecodeSig -- to be filled with AucAdvanced.API.DecodeSig when it has loaded

local floor = floor
local type = type

-- Tooltip Scanning locals for speed, to be filled in near end of file
local ScanTip
local ScanTip2
local ScanTip3

local BindTypes = {
	[ITEM_SOULBOUND] = "Bound",
	[ITEM_BIND_QUEST] = "Quest",
	[ITEM_BIND_ON_PICKUP] = "Bound",
	[ITEM_CONJURED] = "Conjured",
	[ITEM_ACCOUNTBOUND] = "Accountbound",
	[ITEM_BIND_TO_ACCOUNT] = "Accountbound",
}

-- todo: in OnLoad auto-replace values with translations based on table key: "ADV_Help_PostError"..key - e.g. "ADV_Help_PostErrorBound"
-- Some of these errors are only of use when debugging, so should probably not be translated. i.e. the "InvalidX" codes
local ErrorText = {
	Bound = "Cannot auction a Soulbound item",
	Accountbound = "Cannot auction an Account Bound item",
	Conjured = "Cannot auction a Conjured item",
	Quest = "Cannot auction a Quest item",
	Lootable = "Cannot auction a Lootable item",
	Damaged = "Cannot auction a Damaged item",
	InvalidBid = "Bid value is invalid",
	InvalidBuyout = "Buyout value is invalid",
	InvalidDuration = "Duration value is invalid",
	InvalidSig = "Function requires a valid item sig",
	InvalidSize = "Size value is invalid",
	UnknownItem = "Item is unknown",
	MaxSize = "Item cannot be stacked that high",
	NotFound = "Item was not found in inventory",
	NotEnough = "Not enough of item available",
	NoBlank = "Requires a free bag slot that can hold a new stack of this item for posting",
	FailRetry = "Posting failed too many times",
	FailTimeout = "Timed out while waiting for posted item to clear from bags",
	FailSlot = "Unable to place item in the Auction slot",
}
lib.ErrorText = ErrorText

-- local constants to index the posting request tables
local REQ_SIG = 1
local REQ_COUNT = 2
local REQ_BID = 3
local REQ_BUYOUT = 4
local REQ_DURATION = 5
local REQ_ID = 6
local REQ_POSTLINK = 7
local REQ_BAG = 8
local REQ_SLOT = 9
local REQ_TIMEOUT = 10
local REQ_FLAGPOSTFAIL = 11
local REQ_FLAGNOSPACE = 12
-- function to create a new posting request table; keep sync'd with the above constants
private.lastPostId = 0
function private.NewRequestTable(sig, count, bid, buyout, duration)
	local postId = private.lastPostId + 1
	private.lastPostId = postId
	local request = {
		sig, --REQ_SIG
		count, --REQ_COUNT
		bid, --REQ_BID
		buyout, --REQ_BUYOUT
		duration, --REQ_DURATION
		postId, --REQ_ID
		false, --REQ_POSTLINK
		0, --REQ_BAG
		0, --REQ_SLOT
		0, --REQ_TIMEOUT
		false, --REQ_FLAGPOSTFAIL
		false, --REQ_FLAGNOSPACE
	}
	return request
end

--[[
	Functions to safely handle the Post Request queue
	Direct access of private.postRequests is deprecated
]]
private.postRequests = {}
private.lastReported = 0
private.reportLock = 0
function private.QueueReport()
	private.lastCountSig = nil
	if private.reportLock ~= 0 then return end
	local queuelength = #private.postRequests
	if private.lastReported ~= queuelength then
		private.lastReported = queuelength
		AucAdvanced.SendProcessorMessage("postqueue", queuelength)
	end
end
function private.SetQueueReports(activate)
	if activate then
		if private.reportLock > 0 then
			private.reportLock = private.reportLock - 1
		end
		private.QueueReport()
	else
		private.reportLock = private.reportLock + 1
	end
end
function private.QueueInsert(request)
	tinsert(private.postRequests, request)
	private.QueueReport()
end
function private.QueueRemove(index)
	index = index or 1
	if private.postRequests[index] then
		local request = tremove(private.postRequests, index)
		private.QueueReport()
		return request
	end
end
function private.QueueReorder(indexfrom, indexto)
	local queuelen = #private.postRequests
	if queuelen < 2 then return end
	indexfrom = indexfrom or 1
	local request = tremove(private.postRequests, indexfrom)
	if not request then return end
	if indexto and indexto ~= indexfrom and indexto <= queuelen then
		tinsert(private.postRequests, indexto, request)
	else
		tinsert(private.postRequests, request)
	end
	private.QueueReport()
	return true
end
function private.GetQueueIndex(index)
	return private.postRequests[index]
end

--[[ GetQueueLen()
	Return number of requests remaining in the Post Queue
--]]
function lib.GetQueueLen()
	return #private.postRequests
end

--[[ GetQueueItemCount(sig)
	Return number of requests and total number of items matching the sig
--]]
function lib.GetQueueItemCount(sig)
	if sig and sig == private.lastCountSig then
		-- "last item" cache: this function tends to get called multiple times for the same sig
		return private.lastCountRequests, private.lastCountItems
	end
	local requestCount, itemCount = 0, 0
	for _, request in ipairs(private.postRequests) do
		if request[REQ_SIG] == sig then
			requestCount = requestCount + 1
			itemCount = itemCount + request[REQ_COUNT]
		end
	end
	private.lastCountSig = sig
	private.lastCountRequests = requestCount
	private.lastCountItems = itemCount
	return requestCount, itemCount
end

--[[ CancelPostQueue()
	Safely removes all possible Post requests from the Post queue
	If we are in the process of posting an auction, that request cannot be removed
--]]
function lib.CancelPostQueue()
	if #private.postRequests > 0 then
		local request = private.postRequests[1] -- save the first request
		wipe(private.postRequests)
		if request[REQ_POSTLINK] then -- if 'request' is currently being posted, put it back in the queue until the posting resolves
			tinsert(private.postRequests, request)
		end
		private.QueueReport()
	end
end

--[[ End of Post Request Queue section; there should be no references to private.postRequests after this point]]

--[[
    PostAuction(sig, size, bid, buyout, duration, [multiple])

	Places the request to post a stack of the "sig" item, "size" high
	into the auction house for "bid" minimum bid, and "buy" buyout and
	posted for "duration" minutes. The request will be posted
	"multiple" number of times.

	This is the main entry point to the Post library for other AddOns, so has the strictest parameter checking
	"multiple" is optional, defaulting to 1. All other parameters are required.

	If successful it returns a table of post request ids; the id will be included in the "postresult" Processor message for each request
	If a problem is detected it returns nil, reason
		reason is an internal short text code; it can be converted to a displayable text message using lib.ErrorCodes[reason]
]]
function lib.PostAuction(sig, size, bid, buyout, duration, multiple)
	local id = DecodeSig(sig)
	if not id then
		return nil, "InvalidSig"
	elseif type(size) ~= "number" then
		return nil, "InvalidSize"
	elseif type(bid) ~= "number" or bid < 1 then
		return nil, "InvalidBid"
	elseif type(buyout) ~= "number" or (buyout < bid and buyout ~= 0) then
		return nil, "InvalidBuyout"
	--duration used to be passed as a time instead of the 1 2 3 value added in WOW patch 3.3.  So check and convert if needed
	elseif duration == 720 then
		duration = 1
	elseif duration == 1440 then
		duration = 2
	elseif duration == 2880 then
		duration = 3
	elseif duration < 1 or duration > 3 then
		return nil, "InvalidDuration"
	end

	local name,_,_,_,_,_,_, maxSize = GetItemInfo(id)
	if not name then
		return nil, "UnknownItem"
	elseif size > maxSize then
		return nil, "MaxSize"
	end

	multiple = tonumber(multiple) or 1
	local available, total, _, _, _, reason = lib.CountAvailableItems(sig)
	if total == 0 then
		return nil, reason or "NotFound"
	elseif available < size * multiple then
		return nil, "NotEnough"
	end

	local postIds = {}
	private.SetQueueReports(false)
	for i = 1, multiple do
		local request = private.NewRequestTable(sig, size, bid, buyout, duration)
		private.QueueInsert(request)
		tinsert(postIds, request[REQ_ID])
	end
	private.SetQueueReports(true)
	private.Wait(0) -- delay until next OnUpdate
	return postIds
end

--[[
    DecodeSig(sig)
    DecodeSig(itemid, suffix, factor, enchant)
    Returns: itemid, suffix, factor, enchant
	Retained for library compatibility
	Real function moved to AucAdvanced.API, with the other sig functions
]]
function lib.DecodeSig(matchId, matchSuffix, matchFactor, matchEnchant)
	if (type(matchId) == "string") then
		return DecodeSig(matchId)
	end
	matchId = tonumber(matchId)
	if not matchId or matchId == 0 then return end
	matchSuffix = tonumber(matchSuffix) or 0
	matchFactor = tonumber(matchFactor) or 0
	matchEnchant = tonumber(matchEnchant) or 0

	return matchId, matchSuffix, matchFactor, matchEnchant
end

--[[
    IsAuctionable(bag, slot)
    Returns:
		true : if the item is possibly auctionable.
		false, reason : if the item is not auctionable
			reason is an internal (non-localized) string code, use lib.ErrorText[errorcode] for a printable text string

    This function does not check everything, but if it says no,
    then the item is definately not auctionable.
]]
function lib.IsAuctionable(bag, slot)
	local _,_,_,_,_,lootable = GetContainerItemInfo(bag, slot)
	if lootable then
		return false, "Lootable"
	end

	ScanTip:SetOwner(UIParent, "ANCHOR_NONE")
	ScanTip:ClearLines()
	ScanTip:SetBagItem(bag, slot)
	local test = BindTypes[ScanTip2:GetText()] or BindTypes[ScanTip3:GetText()]
	ScanTip:Hide()
	if test then
		return false, test
	end

	-- Check for 'fixable' conditions only after checking all 'unfixable' conditions

	local damage, maxdur = GetContainerItemDurability(bag, slot)
	if damage and damage ~= maxdur then
		return false, "Damaged"
	end

	return true
end

--[[
	CountAvailableItems(sig)
	Returns: availableCount, totalCount, unpostableCount, queuedCount, nil, unpostableError
	The Posting modules need to know how many items are available to be posted;
	this is not the same as the number of items currently in the bags
--]]
function lib.CountAvailableItems(sig)
	local matchId, matchSuffix, matchFactor, matchEnchant = DecodeSig(sig)
	if not matchId then return end
	local totalCount, unpostableCount = 0, 0
	local expansionspace, unpostableError

	for bag = 0, NUM_BAG_FRAMES do
		for slot = 1, GetContainerNumSlots(bag) do
			local link = GetContainerItemLink(bag, slot)
			if link then
				local _, itemId, itemSuffix, itemFactor, itemEnchant = AucAdvanced.DecodeLink(link)
				if itemId == matchId
				and itemSuffix == matchSuffix
				and itemFactor == matchFactor
				and itemEnchant == matchEnchant then
					local _, count = GetContainerItemInfo(bag, slot)
					if not count or count < 1 then count = 1 end
					totalCount = totalCount + count
					local test, code = lib.IsAuctionable(bag, slot)
					if not test then
						unpostableCount = unpostableCount + count
						if unpostableError ~= "Damaged" then -- if there are both "Damaged" and "Soulbound" items, we want to report the "Damaged" code here
							unpostableError = code
						end
					end
				end
			end
		end
	end

	local _, queuedCount = lib.GetQueueItemCount(sig)

	return (totalCount - unpostableCount - queuedCount), totalCount, unpostableCount, queuedCount, expansionspace, unpostableError
end

--[[
    FindMatchesInBags(sig)
    FindMatchesInBags(itemId, [suffix, [factor, [enchant, [seed] ] ] ])
    Returns: { {bag, slot, count}, ... }, itemCount, blankBagId, blankSlotNumber, foundLink, foundLocked
	Library wrapper for the internal version, to check parameters (and to support anticipated future changes)
]]
function lib.FindMatchesInBags(...)
	return private.FindMatchesInBags(lib.DecodeSig(...))
end
-- Internal implementation of FindMatchesInBags
function private.FindMatchesInBags(matchId, matchSuffix, matchFactor, matchEnchant)
	if not matchId then return end
	local matches = {}
	local total = 0
	local blankBag, blankSlot, foundLink, foundLocked

	local itemtype = GetItemFamily(matchId) or 0
	if itemtype > 0 then
		-- check to see if item is itself a bag
		local _,_,_,_,_,_,_,_,equiploc = GetItemInfo(matchId)
		if equiploc == "INVTYPE_BAG" then
			itemtype = 0 -- can only be placed in general-purpose bags
		end
	end

	for bag = 0, 4 do
		local slots = GetContainerNumSlots(bag)
		if slots > 0 then
			local _, bagtype = GetContainerNumFreeSlots(bag)
			-- can this bag contain the item we're looking for?
			if bagtype == 0 or bit.band(bagtype, itemtype) ~= 0 then
				for slot = 1, slots do
					local link = GetContainerItemLink(bag,slot)
					if link then
						local texture, itemCount, locked, quality, readable = GetContainerItemInfo(bag,slot)
						local itype, itemId, suffix, factor, enchant = AucAdvanced.DecodeLink(link)
						if itype == "item"
						and itemId == matchId
						and suffix == matchSuffix
						and factor == matchFactor
						and enchant == matchEnchant
						and lib.IsAuctionable(bag, slot) then
							if not itemCount or itemCount < 1 then itemCount = 1 end
							tinsert(matches, {bag, slot, itemCount})
							total = total + itemCount
							foundLink = link
							if locked then
								foundLocked = true
							end
						end
					else -- blank slot
						if not blankBag then
							blankBag = bag
							blankSlot = slot
						end
					end
				end
			end
		end
	end
	return matches, total, blankBag, blankSlot, foundLink, foundLocked
end

--[[
    PRIVATE: FindOrMakeStack(sig, size)
      Returns: bag, slot ~ if successful
	  Returns: nil, reason ~ if there are any errors
	  Returns: nil, nil ~ if waiting for an event

      If it is possible to make a stack of the specified size, with items
      of the specified sig, this function will combine or split items to
      make the stack.
      Preference is given first to currently existing stacks of the correct
      size first.
      Next, stacks will be split or combined from the smallest stacks first
      until a correctly sized stack is created.
]]
private.moveWait = {}
private.moveEmpty = {}
local function SortCompare(a, b) return a[3] < b[3] end
function private.FindOrMakeStack(sig, size)
	-- if we were splitting or combining a stack, check that the stack count has changed
	if private.moveWait[1] then
		local bag, slot, prev, wait = unpack(private.moveWait)
		if GetTime() < wait then
			local _, count = GetContainerItemInfo(bag,slot)
			if count == prev then
				return
			end
		end
		private.moveWait[1] = nil
	end
	-- if we were moving a stack to an empty slot, check that there is something in that slot now
	if private.moveEmpty[1] then
		local bag, slot, wait = unpack(private.moveEmpty)
		if GetTime() < wait then
			if not GetContainerItemLink(bag,slot) then
				return
			end
		end
		private.moveEmpty[1] = nil
	end

	-- If there is anything on the cursor we can't proceed until it is dropped
	if GetCursorInfo() or SpellIsTargeting() then
		return
	end

	local itemId, suffix, factor, enchant, seed = DecodeSig(sig)
	local _,link,_,_,_,_,_, maxSize = GetItemInfo(itemId)
	if not link then return nil, "UnknownItem" end

	if size > maxSize then
		return nil, "MaxSize"
	end

	local matches, total, blankBag, blankSlot, _, locked = private.FindMatchesInBags(itemId, suffix, factor, enchant, seed)

	if locked then -- at least one of the stacks is locked - wait for it to clear
		return
	end

	if #matches == 0 then
		return nil, "NotFound"
	end

	if total < size then
		return nil, "NotEnough"
	end

	-- Try to find a stack that's exactly the right size
	for i=1, #matches do
		local match = matches[i]
		if match[3] == size then
			return match[1], match[2]
		end
	end

	-- Join up smallest to largest stacks to build a larger stack
	-- or, split a larger stack to the right size (if space available)
	table.sort(matches, SortCompare)
	if (matches[1][3] > size) then
		-- Our smallest stack is bigger than what we need
		-- We will need to split it
		if not blankBag then
			-- Dang, no slots to split stuff into
			return nil, "NoBlank"
		end

		SplitContainerItem(matches[1][1], matches[1][2], size)
		PickupContainerItem(blankBag, blankSlot)
		private.moveEmpty[1] = blankBag
		private.moveEmpty[2] = blankSlot
		private.moveEmpty[3] = GetTime() + 6
	elseif (matches[1][3] + matches[2][3] > size) then
		-- The smallest stack + next smallest is > than our needs, do a partial combine
		SplitContainerItem(matches[2][1], matches[2][2], size - matches[1][3])
		PickupContainerItem(matches[1][1], matches[1][2])
	else
		-- Combine the 2 smallest stacks
		PickupContainerItem(matches[1][1], matches[1][2])
		PickupContainerItem(matches[2][1], matches[2][2])
	end
	private.moveWait[1] = matches[1][1]
	private.moveWait[2] = matches[1][2]
	private.moveWait[3] = matches[1][3]
	private.moveWait[4] = GetTime() + 6
end

--[[
    GetDepositCost(item, duration, faction, count)
    item: itemID or "itemString" or "itemName" or "itemLink" [Required]
	duration: 12, 24, or 48 [defaults to 24]
	faction: "home" or "neutral" or "Neutral" [defaults to home]
    count: <stacksize> [defaults to 1]
]]
function GetDepositCost(item, duration, faction, count)
	if not item then return end
	--[[
	Deposit Cost = RoundDown(VendorPrice * FactionMultiplier * StackSize, 3) * DurationMultiplier
	FactionMultiplier = (0.15 for Home, 0.75 for Neutral)
	DurationMultiplier = (1 for 12hrs, 2 for 24hrs, 4 for 48hrs)
	However as there is no lua function for "round down to the nearest multiple of 3",
	we shall implement this by dividing the FactionMultiplier by 3 (0.05 and 0.25)
	using 'floor' to round down to the nearest integer
	and then multiplying the DurationMultiplier by 3 (3, 6 and 12)
	--]]

	-- Set up function defaults if not specifically provided
	if duration == 12 then duration = 3 elseif duration == 48 then duration = 12 else duration = 6 end
	if faction == "neutral" or faction == "Neutral" then faction = .25 else faction = .05 end
	count = count or 1

	local _,_,_,_,_,_,_,_,_,_,gsv = GetItemInfo(item)
	if not gsv and GetSellValue then
		-- if item is not in local cache, fallback to GetSellValue
		-- some people may still be using a GetSellValue provider with a saved price database
		gsv = GetSellValue(item)
	end
	if gsv then
		return floor(faction * gsv * count) * duration
	end
end

--[[
	PRIVATE: ProcessPosts()
	This function is responsible for maintaining and processing the post queue.
]]
local LAG_ADJUST = (3 / 1000)
local POST_TIMEOUT = 6 -- seconds general timeout
local POST_ERROR_PAUSE = 1 -- seconds pause after error before trying next request
local POST_THROTTLE = 0 -- time before starting to post the next item in the queue
function private.ProcessPosts(source)
	if lib.GetQueueLen() <= 0 or not (AuctionFrame and AuctionFrame:IsVisible()) then
		private.Wait() -- put timer to sleep
		return
	end
	-- use longer timeout delays if connectivity is bad, but always at least 1 second
	local _,_, lag = GetNetStats()
	lag = max(lag * LAG_ADJUST, 1)
	private.Wait(lag) -- set default wait time (overwritten later in certain cases)

	local request = private.GetQueueIndex(1)

	if request[REQ_POSTLINK] then
		-- We're waiting for the item to vanish from the bags
		local link = GetContainerItemLink(request[REQ_BAG], request[REQ_SLOT])
		if not link or link ~= request[REQ_POSTLINK] then
			-- Successful Auction!
			private.QueueRemove()
			private.Wait(POST_THROTTLE)
			AucAdvanced.SendProcessorMessage("postresult", true, request[REQ_ID], request)
		elseif GetTime() > request[REQ_TIMEOUT] then
			-- Can't auction this item!
			local _, itemCount = GetContainerItemInfo(request[REQ_BAG], request[REQ_SLOT])
			local msg = ("Unable to confirm auction for %s x%d: %s"):format(link, itemCount, ErrorText["FailTimeout"])
			debugPrint(msg, "CorePost", "Posting timeout", "Warning")
			private.QueueRemove()
			private.Wait(POST_ERROR_PAUSE)
			AucAdvanced.SendProcessorMessage("postresult", false, request[REQ_ID], request, "FailTimeout")
			message(msg)
		end
		return
	end

	local bag, slot = private.FindOrMakeStack(request[REQ_SIG], request[REQ_COUNT])
	if not bag and slot then
		local err = slot
		local link, name = AucAdvanced.API.GetLinkFromSig(request[REQ_SIG])
		private.Wait(POST_ERROR_PAUSE)
		if err == "NoBlank" then -- special case
			private.Wait(0)
			if not request[REQ_FLAGNOSPACE] then
				request[REQ_FLAGNOSPACE] = true
				if private.QueueReorder() then
					return
				end
			end
		end
		local msg = ("Aborting post request for %s x%d: %s"):format(link, request[REQ_COUNT], ErrorText[err])
		debugPrint(msg, "CorePost", "Post request aborted", "Warning")
		private.QueueRemove()
		AucAdvanced.SendProcessorMessage("postresult", false, request[REQ_ID], request, err)
		message(msg)
		return
	end
	if bag then
		local failed = request[REQ_FLAGPOSTFAIL]
		if failed and GetTime() < request[REQ_TIMEOUT] then
			-- Auction posting failed the first time; wait for full delay time before retrying
			return
		end
		local link = GetContainerItemLink(bag,slot)
		if GetAuctionSellItemInfo() then
			-- auction slot is already occupied, try to clear it
			ClickAuctionSellItemButton()
			ClearCursor()
			if GetAuctionSellItemInfo() then
				-- it's locked, wait for it to clear
				return
			end
		end

		PickupContainerItem(bag, slot)
		if not CursorHasItem() then
			-- failed to pick up from bags, probably due to some unfinished operation; wait for another cycle
			return
		end

		ClickAuctionSellItemButton()
		if not GetAuctionSellItemInfo() then
			-- failed to drop item in auction slot, probably because item is not auctionable (but was missed by our checks)
			local _, itemCount = GetContainerItemInfo(bag,slot)
			local msg = ("Unable to create auction for %s x%d: %s"):format(link, itemCount, ErrorText["FailSlot"])
			debugPrint(msg, "CorePost", "Posting Failure", "Warning")
			private.QueueRemove()
			private.Wait(POST_ERROR_PAUSE)
			AucAdvanced.SendProcessorMessage("postresult", false, request[REQ_ID], request, "FailSlot")
			message(msg)
			return
		end

		StartAuction(request[REQ_BID], request[REQ_BUYOUT], request[REQ_DURATION])
		ClickAuctionSellItemButton()
		if (CursorHasItem()) then -- Didn't auction successfully
			ClearCursor() -- Put it back in the bags
			if failed then
				-- Auction posting has failed twice - abort this request
				local _, itemCount = GetContainerItemInfo(bag,slot)
				local msg = ("Unable to create auction for %s x%d: %s"):format(link, itemCount, ErrorText["FailRetry"])
				debugPrint(msg, "CorePost", "Posting Failure", "Warning")
				private.QueueRemove()
				private.Wait(POST_ERROR_PAUSE)
				AucAdvanced.SendProcessorMessage("postresult", false, request[REQ_ID], request, "FailRetry")
				message(msg)
				return
			else
				-- First time the auction posting has failed
				-- The problem may be due to lag or something else that will clear given enough time
				request[REQ_TIMEOUT] = GetTime() + lag * POST_TIMEOUT -- delay before trying to post this auction again
				request[REQ_FLAGPOSTFAIL] = true
				private.QueueReorder() -- Move to the back of the queue and try a different auction (if possible)
			end
		else -- Successful post - wait for this item to vanish from bag
			request[REQ_TIMEOUT] = GetTime() + lag * POST_TIMEOUT
			request[REQ_POSTLINK] = link
			request[REQ_BAG] = bag
			request[REQ_SLOT] = slot
		end
	end
end

--[[

    Our frames for feeding event functions and processing tooltips

]]

-- Simple timer to keep actions up-to-date even if an event misfires
--[[
	PRIVATE: Wait(delay)
	Used to control the timer
	Use delay = nil to stop the timer
	Use delay >= 0 to start the timer and set the delay length
--]]
function private.Wait(delay)
	if delay then
		if not private.updateFrame.timer then
			private.updateFrame:Show()
		end
		private.updateFrame.timer = delay
	else
		if private.updateFrame.timer then
			private.updateFrame:Hide()
			private.updateFrame.timer = nil
		end
	end
end

private.updateFrame = CreateFrame("frame", nil, UIParent)
private.updateFrame:Hide()
private.updateFrame:SetScript("OnUpdate", function(obj, delay)
	obj.timer = obj.timer - delay
	if obj.timer <= 0 then
		private.ProcessPosts("timer") -- obj.timer will be updated by ProcessPosts
	end
end)

function lib.Processor(event, ...)
	if event == "inventory" then
		if private.updateFrame.timer then
			private.ProcessPosts(event)
		end
	elseif event == "auctionopen" then
		if lib.GetQueueLen() > 0 then
			private.ProcessPosts(event)
		end
	elseif event == "auctionclose" then
		if lib.GetQueueLen() > 0 then
			if AucAdvanced.Settings.GetSetting("post.clearonclose") then
				if AucAdvanced.Settings.GetSetting("post.confirmonclose") then
					StaticPopup_Show("POST_CANCEL_QUEUE_AH_CLOSED")
				else
					lib.CancelPostQueue()
				end
			end
		end
	end
end

function lib.OnLoad(addon)
	if addon == "auc-advanced" then
		-- Install values into locals/tables, that are not available until Auctioneer is fully loaded
		DecodeSig = AucAdvanced.API.DecodeSig
		for code, text in pairs(ErrorText) do
			local transkey = "ADV_Help_PostError"..code
			local transtext = _TRANS(transkey)
			if transtext ~= transkey then -- _TRANS returns transkey if there is no available translation
				ErrorText[code] = transtext
			end
		end
	end
end

-- Local tooltip for getting soulbound line from tooltip contents
ScanTip = CreateFrame("GameTooltip", "AppraiserTip", UIParent, "GameTooltipTemplate")
ScanTip2 = _G["AppraiserTipTextLeft2"]
ScanTip3 = _G["AppraiserTipTextLeft3"]

StaticPopupDialogs["POST_CANCEL_QUEUE_AH_CLOSED"] = {
  text = "The Auctionhouse has closed. Do you want to clear the Posting queue?",
  button1 = YES,
  button2 = NO,
  OnAccept = lib.CancelPostQueue,
  timeout = 20,
  whileDead = true,
  hideOnEscape = true,
}

AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Auc-Advanced/CorePost.lua $", "$Rev: 4696 $")
