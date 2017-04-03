--[[
	Auctioneer - Appraisals and Auction Posting
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: Appraiser.lua 4552 2009-12-02 15:09:46Z brykrys $
	URL: http://auctioneeraddon.com/

	This is an addon for World of Warcraft that adds an appraisals tab to the AH for
	easy posting of your auctionables when you are at the auction house.

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
if not AucAdvanced then return end

local libType, libName = "Util", "Appraiser"
local lib,parent,private = AucAdvanced.NewModule(libType, libName)
if not lib then return end
local print,decode,_,_,replicate,_,get,set,default,debugPrint,fill, _TRANS = AucAdvanced.GetModuleLocals()
local empty = wipe

local GetFaction = AucAdvanced.GetFaction

local pricecache -- cache for GetPrice; only used in certain circumstances
local tooltipcache = {} -- cache for ProcessTooltip

function lib.Processor(callbackType, ...)
	if (callbackType == "tooltip") then
		lib.ProcessTooltip(...)
	elseif (callbackType == "auctionui") then
		if private.CreateFrames then private.CreateFrames(...) end
	elseif (callbackType == "config") then
		private.SetupConfigGui(...)
	elseif (callbackType == "configchanged") then
		local change, value = ... --get the reason if its a scrollframe color change re-render the window
		if private.frame then
			private.frame.salebox.config = true
			--	private.frame.SetPriceFromModel()
			private.frame.UpdatePricing()
			private.frame.UpdateDisplay()
			--	private.frame.salebox.config = nil
			if change == "util.appraiser.color" or change == "util.appraiser.colordirection" then
				private.frame.UpdateImage()
			end
			--show/hide the appraiser tab on the AH
			if change == "util.appraiser.displayauctiontab" then
				if value then
					AucAdvanced.AddTab(private.frame.ScanTab, private.frame)
				else
					AucAdvanced.RemoveTab(private.frame.ScanTab, private.frame)
				end
			end
		end
		if change:sub(1, 20) == "util.appraiser.round" then
			private.updateRoundExample()
		end
		-- clear cache for any changes, as we can't always predict what will change our cached values
		empty(tooltipcache)
	elseif (callbackType == "inventory") then
		if private.frame and private.frame:IsVisible() then
			private.frame.GenerateList()
		end
	elseif (callbackType == "scanstats") then
		if private.frame then
			private.frame.cache = {}
			-- caution: other modules may not yet have flushed their caches
			-- flag to update our display next OnUpdate
			private.frame.scanstatsEvent = true
		end
		empty(tooltipcache)
	elseif (callbackType == "postresult") then
		private.frame.Reselect(select(3, ...))
	elseif callbackType == "postqueue" then
		if private.UpdatePostQueueProgress then private.UpdatePostQueueProgress(...) end
	elseif callbackType == "searchbegin" then
		pricecache = {} -- use cache when SearchUI is running a search
	elseif callbackType == "searchcomplete" then
		pricecache = nil -- stop using cache when search ends
	end
end

-- For backwards compatibility, leave these here. This is now a capability of the core API
lib.GetSigFromLink = AucAdvanced.API.GetSigFromLink;
lib.GetLinkFromSig = AucAdvanced.API.GetLinkFromSig;

function lib.ProcessTooltip(tooltip, name, hyperlink, quality, quantity, cost, additional)
	if not AucAdvanced.Settings.GetSetting("util.appraiser.enable") then return end
	if not AucAdvanced.Settings.GetSetting("util.appraiser.model") then return end
	local sig = lib.GetSigFromLink(hyperlink)
	if not sig then return end

	tooltip:SetColor(0.3, 0.9, 0.8)

	local value, bid, curModel, _

	if tooltipcache[sig] then
		value, bid, curModel = unpack(tooltipcache[sig]) -- all values should be non-nil
	else
		value, bid, _, curModel = private.GetPriceCore(sig, hyperlink, GetFaction(), true)
		if curModel ~= "Enchantrix" then -- don't cache values based on modules which don't broadcast configchanged
			tooltipcache[sig] = {value, bid, curModel}
		end
	end

	if value then
		tooltip:AddLine(_TRANS('APPR_Tooltip_AppraiserCurModel'):format(curModel, quantity) , value * quantity)--Appraiser ({{%s}}x{{%s}}
		if AucAdvanced.Settings.GetSetting("util.appraiser.bidtooltip") then
			tooltip:AddLine("  ".._TRANS('APPR_Tooltip_StartingBid'):format(quantity), bid * quantity)--Starting bid x {{%d}}
		end
	end
    if AucAdvanced.Settings.GetSetting("util.appraiser.ownauctions") then
        local itemName = name

        local colored = get('util.appraiser.manifest.color') and AucAdvanced.Modules.Util.PriceLevel

		local results = lib.ownResults[itemName]
		local counts = lib.ownCounts[itemName]

		if counts and #counts>0 then
            local sumBid, sumBO = 0, 0
            local countBid, countBO = 0, 0
			for _,count in ipairs(counts) do
				local res = results[count]
				sumBid = sumBid + res.sumBid --*res.stackCount
                sumBO = sumBO + res.sumBO --*res.stackCount
                countBid = countBid + res.countBid --*res.stackCount
                countBO = countBO + res.countBO --*res.stackCount
			end
            local avgBid =  countBid>0 and (sumBid / countBid) or nil
            local avgBO =  countBO>0 and (sumBO / countBO) or nil
            local r,g,b,_
			if colored then
				_, _, r,g,b = AucAdvanced.Modules.Util.PriceLevel.CalcLevel(hyperlink, 1, avgBid, avgBO)
			end
			r,g,b = r or 1,g or 1, b or 1

            tooltip:AddLine("  ".._TRANS('APPR_Tooltip_PostedCount'):format(countBO or countBid, avgBO and "" or " (bid)"), avgBO or avgBid, r,g,b)--Posted %2d at avg/ea %s
		end
    end
end

function lib.GetPrice(link, serverKey)
	local sig = lib.GetSigFromLink(link)
	if not sig then
       	return 0, 0, false, 0, "Unknown", "", 0, 0, 0
	end
	local match = true
	local currentKey = GetFaction()
	if not serverKey then
		serverKey = currentKey
	elseif serverKey ~= currentKey then
		-- Matching API cannot handle serverKey correctly, only works for currentKey
		match = false
	end
	local newBuy, newBid, seen, curModelText, MatchString, stack, number, duration

	if pricecache then
		local cacheSig = serverKey..sig
		if pricecache[cacheSig] then
			newBuy, newBid, seen, curModelText, MatchString, stack, number, duration = unpack(pricecache[cacheSig], 1, 8) -- some values may be nil
		else
			newBuy, newBid, seen, curModelText, MatchString, stack, number, duration = private.GetPriceCore(sig, link, serverKey, match)
			pricecache[cacheSig] = {newBuy, newBid, seen, curModelText, MatchString, stack, number, duration}
		end
	else
		newBuy, newBid, seen, curModelText, MatchString, stack, number, duration = private.GetPriceCore(sig, link, serverKey, match)
	end

	return newBuy, newBid, false, seen, curModelText, MatchString, stack, number, duration
end

function lib.GetPriceUnmatched(link, serverKey)
	local sig = lib.GetSigFromLink(link)
	if not sig then
       	return 0, 0, false, 0, "Unknown", "", 0, 0, 0
	end

	local newBuy, newBid, seen, curModelText, MatchString, stack, number, duration
	newBuy, newBid, seen, curModelText, MatchString, stack, number, duration = private.GetPriceCore(sig, link, serverKey)
	return newBuy, newBid, false, seen, curModelText, MatchString, stack, number, duration
end

function lib.GetPriceColumns()
	return "Buyout", "Bid", false, "seen", "curModelText", "MatchString", "Stack", "Number", "Duration"
end

local array = {}
--returns pricing and posting settings
function lib.GetPriceArray(link, serverKey)
	empty(array)

	local newBuy, newBid, _, seen, curModelText, MatchString, stack, number, duration = lib.GetPrice(link, serverKey)

	array.price = newBuy
	array.seen = seen

	array.stack = stack
	array.number = number
	array.duration = duration

	return array
end

function lib.OnLoad()
	-- Configure our defaults
	AucAdvanced.Settings.SetDefault("util.appraiser.enable", false)
	AucAdvanced.Settings.SetDefault("util.appraiser.bidtooltip", true)
	AucAdvanced.Settings.SetDefault("util.appraiser.model", "market")
	AucAdvanced.Settings.SetDefault("util.appraiser.ownauctions", false)
	AucAdvanced.Settings.SetDefault("util.appraiser.altModel", "market")
	AucAdvanced.Settings.SetDefault("util.appraiser.duration", 2880)
	AucAdvanced.Settings.SetDefault("util.appraiser.round.bid", false)
	AucAdvanced.Settings.SetDefault("util.appraiser.round.buy", false)
	AucAdvanced.Settings.SetDefault("util.appraiser.round.method", "unit")
	AucAdvanced.Settings.SetDefault("util.appraiser.round.position", 0.10)
	AucAdvanced.Settings.SetDefault("util.appraiser.round.magstep", 5)
	AucAdvanced.Settings.SetDefault("util.appraiser.round.subtract", 1)
	AucAdvanced.Settings.SetDefault("util.appraiser.bid.markdown", 10)
	AucAdvanced.Settings.SetDefault("util.appraiser.bid.subtract", 0)
	AucAdvanced.Settings.SetDefault("util.appraiser.bid.deposit", true)
	AucAdvanced.Settings.SetDefault("util.appraiser.bid.vendor", true)
	AucAdvanced.Settings.SetDefault("util.appraiser.color", true)
	AucAdvanced.Settings.SetDefault("util.appraiser.colordirection","RIGHT")
	AucAdvanced.Settings.SetDefault("util.appraiser.manifest.color", true)
	AucAdvanced.Settings.SetDefault("util.appraiser.tint.color", true)
	AucAdvanced.Settings.SetDefault("util.appraiser.match", "on")
	AucAdvanced.Settings.SetDefault("util.appraiser.stack", "max")
	AucAdvanced.Settings.SetDefault("util.appraiser.number", "maxplus")
	AucAdvanced.Settings.SetDefault("util.appraiser.clickhookany", true)
	AucAdvanced.Settings.SetDefault("util.appraiser.reselect", true)
	AucAdvanced.Settings.SetDefault("util.appraiser.buttontips", true)
	AucAdvanced.Settings.SetDefault("util.appraiser.displayauctiontab", true)
	--Default sizes for the scrollframe column widths
	AucAdvanced.Settings.SetDefault("util.appraiser.columnwidth.".._TRANS('APPR_Interface_Seller'), 71) --Seller
	AucAdvanced.Settings.SetDefault("util.appraiser.columnwidth.".._TRANS('APPR_Interface_Left'), 25) --Left
	AucAdvanced.Settings.SetDefault("util.appraiser.columnwidth.".._TRANS('APPR_Interface_Stk'), 27 ) --Stk
	AucAdvanced.Settings.SetDefault("util.appraiser.columnwidth.".._TRANS('APPR_Interface_Min/ea'), 65) --Min/ea
	AucAdvanced.Settings.SetDefault("util.appraiser.columnwidth.".._TRANS('APPR_Interface_Cur/ea'), 65) --Cur/ea
	AucAdvanced.Settings.SetDefault("util.appraiser.columnwidth.".._TRANS('APPR_Interface_Buy/ea'), 65) --Buy/ea
	AucAdvanced.Settings.SetDefault("util.appraiser.columnwidth.".._TRANS('APPR_Interface_MinBid'), 65) --MinBid
	AucAdvanced.Settings.SetDefault("util.appraiser.columnwidth.".._TRANS('APPR_Interface_CurBid'), 65) --CurBid
	AucAdvanced.Settings.SetDefault("util.appraiser.columnwidth.".._TRANS('APPR_Interface_Buyout'), 68) --Buyout
	AucAdvanced.Settings.SetDefault("util.appraiser.columnwidth.BLANK", 0.05)
end

function lib.CanSupplyMarket()
	return false
end

function lib.ClearItem()
	-- we only need this to clear caches
	empty(tooltipcache)
	if pricecache then empty(pricecache) end
end

function private.GetPriceCore(sig, link, serverKey, match)
	local curModel, curModelText

	curModel = AucAdvanced.Settings.GetSetting("util.appraiser.item."..sig..".model") or "default"
	curModelText = curModel
	local duration = AucAdvanced.Settings.GetSetting("util.appraiser.item."..sig..".duration") or AucAdvanced.Settings.GetSetting("util.appraiser.duration")

	-- valuation
	local newBuy, newBid, seen, _, DiffFromModel, MatchString
	if curModel == "default" then
		curModel = AucAdvanced.Settings.GetSetting("util.appraiser.model") or "market"
		if curModel == "market" then
			newBuy, seen = AucAdvanced.API.GetMarketValue(link, serverKey)
		else
			newBuy, seen = AucAdvanced.API.GetAlgorithmValue(curModel, link, serverKey)
		end
		if (not newBuy) or (newBuy == 0) then
			curModel = AucAdvanced.Settings.GetSetting("util.appraiser.altModel")
			if curModel == "market" then
				newBuy, seen = AucAdvanced.API.GetMarketValue(link, serverKey)
			else
				newBuy, seen = AucAdvanced.API.GetAlgorithmValue(curModel, link, serverKey)
			end
		end
		curModelText = curModelText.."("..curModel..")"
	elseif curModel == "fixed" then
		newBuy = AucAdvanced.Settings.GetSetting("util.appraiser.item."..sig..".fixed.buy")
		newBid = AucAdvanced.Settings.GetSetting("util.appraiser.item."..sig..".fixed.bid")
		seen = 99
	elseif curModel == "market" then
		newBuy, seen = AucAdvanced.API.GetMarketValue(link, serverKey)
	else
		newBuy, seen = AucAdvanced.API.GetAlgorithmValue(curModel, link, serverKey)
	end

	-- matching
	if match then
		match = AucAdvanced.Settings.GetSetting("util.appraiser.item."..sig..".match")
		if match == nil then
			match = AucAdvanced.Settings.GetSetting("util.appraiser.match")
		end
	end
	if match then
		local biddown
		if curModel == "fixed" then
			if newBuy and newBuy > 0 then
				biddown = newBid/newBuy
				newBuy, _, _, DiffFromModel, MatchString = AucAdvanced.API.GetBestMatch(link, newBuy, serverKey)
				newBid = newBuy * biddown
			end
		else
			newBuy, _, _, DiffFromModel, MatchString = AucAdvanced.API.GetBestMatch(link, newBuy, serverKey)
		end
	end

	-- generate bid value
	if curModel ~= "fixed" then
		if newBuy and not newBid then
			local markdown = math.floor(AucAdvanced.Settings.GetSetting("util.appraiser.bid.markdown") or 0)/100
			local subtract = AucAdvanced.Settings.GetSetting("util.appraiser.bid.subtract") or 0
			local deposit = AucAdvanced.Settings.GetSetting("util.appraiser.bid.deposit") or false
			if deposit then
				local rate = AucAdvanced.depositRate or 0.05
				local newfaction
				if rate == .25 then newfaction = "neutral" end
				deposit = GetDepositCost(link, 12, newfaction)
			end
			if (not deposit) then deposit = 0 end

			--scale up for duration > 12 hours
			if deposit > 0 then
				deposit = deposit * duration/720
			end

			markdown = newBuy * markdown
			newBid = math.max(newBuy - markdown - subtract - deposit, 1)
		end

		if not newBid then
			newBid = 0
		end
		if GetSellValue and AucAdvanced.Settings.GetSetting("util.appraiser.bid.vendor") then
			local vendor = (GetSellValue(link) or 0)
			if vendor and vendor>0 then
				vendor = math.ceil(vendor / (1 - (AucAdvanced.cutRate or 0.05)))
				if newBid < vendor then
					newBid = vendor
				end
			end
		end


		if newBid and (not newBuy or newBid > newBuy) then
			newBuy = newBid
		end
	end

	-- pricing: final checks
	newBid = math.floor((newBid or 0) + 0.5)
	newBuy = math.floor((newBuy or 0) + 0.5)

	-- other return values
	local stack = AucAdvanced.Settings.GetSetting("util.appraiser.item."..sig..".stack") or AucAdvanced.Settings.GetSetting("util.appraiser.stack")
	local number = AucAdvanced.Settings.GetSetting("util.appraiser.item."..sig..".number") or AucAdvanced.Settings.GetSetting("util.appraiser.number")
	if stack == "max" then
		_, _, _, _, _, _, _, stack = GetItemInfo(link)
	end
	if number == "maxplus" then
		number = -1
	elseif number == "maxfull" then
		number = -2
	end
	stack = tonumber(stack)
	number = tonumber(number)

	-- Caution: this is NOT the same return order as GetPrice
	return newBuy, newBid, seen, curModelText, MatchString, stack, number, duration
end

lib.ownResults = {}
lib.ownCounts = {}
function lib.GetOwnAuctionDetails()
	local results = lib.ownResults
	local counts = lib.ownCounts
	empty(results)
	empty(counts)
	local numBatchAuctions, totalAuctions = GetNumAuctionItems("owner");
	if totalAuctions >0 then
		for i=1, totalAuctions do
			local name, _, count, _, _, _, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, owner  = GetAuctionItemInfo("owner", i)
			if name and (count>0) then
				if not results[name] then
					results[name] = {}
					counts[name] = {}
				end
				local r = results[name][count]
				if not r then
					r = { stackCount=0, countBid=0, sumBid=0, countBO=0, sumBO=0 }
					results[name][count] = r
					tinsert(counts[name], count)
				end
				if (minBid or 0)>0 then
					r.countBid = r.countBid + count
					r.sumBid = r.sumBid + bidAmount
				end
				if (buyoutPrice or 0)>0 then
					r.countBO = r.countBO + count
					r.sumBO = r.sumBO + buyoutPrice
				end
				r.stackCount = r.stackCount + 1
			end
		end
	end
end
Stubby.RegisterEventHook("AUCTION_OWNED_LIST_UPDATE", "Auc-Util-Appraiser", lib.GetOwnAuctionDetails)

AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Auc-Util-Appraiser/Appraiser.lua $", "$Rev: 4552 $")
