--[[
	Auctioneer - Search UI - Searcher Resale
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: SearcherResale.lua 4432 2009-08-29 14:55:35Z dinesh $
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
local lib, parent, private = AucSearchUI.NewSearcher("Resale")
if not lib then return end
--local print,decode,_,_,replicate,empty,_,_,_,debugPrint,fill = AucAdvanced.GetModuleLocals() -- commenting out as unused, re-enable if needed
local get, set, default, Const, resources = parent.GetSearchLocals()
lib.tabname = "Resale"

-- Set our defaults
default("resale.profit.min", 1)
default("resale.profit.pct", 50)
default("resale.seen.check", false)
default("resale.seen.min", 10)
default("resale.adjust.brokerage", true)
default("resale.adjust.deposit", true)
default("resale.adjust.deplength", 48)
default("resale.adjust.listings", 3)
default("resale.allow.bid", true)
default("resale.allow.buy", true)
default("resale.maxprice", 10000000)
default("resale.maxprice.enable", false)
default("resale.model", "market")

-- This function is automatically called from AucSearchUI.NotifyCallbacks
private.validationRequired = true
function lib.Processor(event, subevent)
	if event == "selecttab" then
		if subevent == lib.tabname and private.validationRequired then
			if not resources.isValidPriceModel(get("resale.model")) then
				message("Resale Searcher Warning!\nCurrent price model setting ("..get("resale.model")..") is not valid. Select a new price model")
			else
				private.validationRequired = nil
			end
		end
	end
end

-- This function is automatically called when we need to create our search parameters
function lib:MakeGuiConfig(gui)
	-- Get our tab and populate it with our controls
	local id = gui:AddTab(lib.tabname, "Searchers")

	-- Add the help
	gui:AddSearcher("Resale", "Search for undervalued items which can be directly resold for profit", 100)
	gui:AddHelp(id, "resale searcher",
		"What does this searcher do?",
		"This searcher provides the ability to search for items that are being sold under market value, and which you can resell for profit after the fees and deposits are accounted for.")

	gui:AddControl(id, "Header",     0,      "Resale search criteria")

	local last = gui:GetLast(id)

	gui:AddControl(id, "MoneyFramePinned",  0, 1, "resale.profit.min", 1, 99999999, "Minimum Profit")
	gui:AddControl(id, "Slider",            0, 1, "resale.profit.pct", 1, 100, .5, "Min Discount: %0.01f%%")
	gui:AddControl(id, "Checkbox",          0, 1, "resale.seen.check", "Check Seen count")
	gui:AddControl(id, "Slider",            0, 2, "resale.seen.min", 1, 100, 1, "Min seen count: %s")

	gui:SetLast(id, last)
	gui:AddControl(id, "Checkbox",          0.42, 1, "resale.allow.bid", "Allow Bids")
	gui:SetLast(id, last)
	gui:AddControl(id, "Checkbox",          0.56, 1, "resale.allow.buy", "Allow Buyouts")
	gui:AddControl(id, "Checkbox",          0.42, 1, "resale.maxprice.enable", "Enable individual maximum price:")
	gui:AddTip(id, "Limit the maximum amount you want to spend with the Resale searcher")
	gui:AddControl(id, "MoneyFramePinned",  0.42, 2, "resale.maxprice", 1, 99999999, "Maximum Price for Resale")

	gui:AddControl(id, "Subhead",           0.42,    "Price Valuation Method:")
	gui:AddControl(id, "Selectbox",         0.42, 1, resources.selectorPriceModels, "resale.model")
	gui:AddTip(id, "The pricing model that is used to work out the calculated value of items at the Auction House.")

	gui:AddControl(id, "Subhead",           0.42,    "Fees Adjustment")
	gui:AddControl(id, "Checkbox",          0.42, 1, "resale.adjust.brokerage", "Subtract auction fees")
	gui:AddControl(id, "Checkbox",          0.42, 1, "resale.adjust.deposit", "Subtract deposit")
	gui:AddControl(id, "Selectbox",         0.42, 1, resources.selectorAuctionLength, "resale.adjust.deplength")
	gui:AddControl(id, "Slider",            0.42, 1, "resale.adjust.listings", 1, 10, .1, "Ave relistings: %0.1fx")
end

function lib.Search(item)
	local link = item[Const.LINK]
	if not link then
		return false, "No link"
	end

	local bidprice, buyprice = item[Const.PRICE], item[Const.BUYOUT]
	local maxprice = get("resale.maxprice.enable") and get("resale.maxprice")
	if buyprice <= 0 or not get("resale.allow.buy") or (maxprice and buyprice > maxprice) then
		buyprice = nil
	end
	if not get("resale.allow.bid") or (maxprice and bidprice > maxprice) then
		bidprice = nil
	end
	if not (bidprice or buyprice) then
		return false, "Does not meet bid/buy requirements"
	end

	local model = get("resale.model")
	local market, seen, curModel = resources.lookupPriceModel[model](model, link)
	if not market then
		return false, "No market price"
	end
	local count = item[Const.COUNT]
	market = market * count

	if (get("resale.seen.check")) and curModel ~= "fixed" then
		if ((not seen) or (seen < get("resale.seen.min"))) then
			return false, "Seen count too low"
		end
	end

	--adjust for brokerage/deposit costs
	if get("resale.adjust.brokerage") then
		market = market * resources.CutAdjust
	end
	if get("resale.adjust.deposit") then
		local amount = GetDepositCost(link, get("resale.adjust.deplength"), resources.faction, count)
		if amount then
			market = market - amount * get("resale.adjust.listings")
		end
	end

	local value = min(market*(100-get("resale.profit.pct"))/100, market-get("resale.profit.min"))
	if buyprice and buyprice <= value then
		return "buy", market
	elseif bidprice and bidprice <= value then
		return "bid", market
	end
	return false, "Not enough profit"
end

AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Auc-Util-SearchUI/SearcherResale.lua $", "$Rev: 4432 $")
