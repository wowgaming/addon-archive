--[[
	Auctioneer - Search UI - Searcher Arbitrage
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: SearcherArbitrage.lua 4432 2009-08-29 14:55:35Z dinesh $
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
local lib, parent, private = AucSearchUI.NewSearcher("Arbitrage")
if not lib then return end
--local print,decode,_,_,replicate,empty,_,_,_,debugPrint,fill = AucAdvanced.GetModuleLocals()
local get, set, default, Const, resources = parent.GetSearchLocals()
lib.tabname = "Arbitrage"

do -- limit scope of locals
	local styles = {
			"Neutral",
			"Cross-Faction",
			"Cross-Realm",
		}
	function private.getStyles()
		return styles
	end

	factions = {
			"Neutral",
			"Alliance",
			"Horde",
		}
	function private.getFactions()
		return factions
	end

	local realmlist
	function private.getRealmList()
		return realmlist
	end
	function private.createRealmList()
		-- called from onload event for SearchUI
		-- saved variables are loaded but some resources may not be available
		private.createRealmList = nil

		realmlist = {}

		local realms = AucAdvancedData.AserArbitrageRealms
		if not realms then
			realms = {}
			AucAdvancedData.AserArbitrageRealms = realms
		end

		local playerRealm = GetRealmName()
		if not realms[playerRealm] then
			realms[playerRealm] = UnitName("player")
		end

		for realm, _ in pairs(realms) do
			-- apparently some serverKeys got into the table in the past
			-- they shouldn't be there, so strip them out
			-- eventually this check can be removed altogether
			local len = #realm
			if strsub(realm, len-7) == "Alliance"
			or strsub(realm, len-6) == "Neutral"
			or strsub(realm, len-4) == "Horde"
			then
				realms[realm] = nil
			end

			-- insert all realms *including* our current realm
			-- this is a workaround for problems with Selectboxes if the current saved setting is not in the list
			table.insert(realmlist, realm)
		end
	end
end

-- Set our defaults
default("arbitrage.profit.min", 1)
default("arbitrage.profit.pct", 50)
default("arbitrage.seen.check", false)
default("arbitrage.seen.min", 10)
default("arbitrage.adjust.brokerage", true)
default("arbitrage.adjust.deposit", true)
default("arbitrage.adjust.deplength", 48)
default("arbitrage.adjust.listings", 3)
default("arbitrage.allow.bid", true)
default("arbitrage.allow.buy", true)
default("arbitrage.maxprice", 10000000)
default("arbitrage.maxprice.enable", false)
default("arbitrage.model", "market")
default("arbitrage.search.crossrealmfaction", "Alliance")
default("arbitrage.search.style", "Cross-Faction")

function private.doValidation()
	if not resources.isValidPriceModel(get("arbitrage.model")) then
		message("Arbitrage Searcher Warning!\nCurrent price model setting ("..get("arbitrage.model")..") is not valid. Select a new price model")
	else
		private.doValidation = nil
	end
end

function lib.Processor(event, subevent, ...)
	if event == "search" and subevent == "complete" and private.factionUpdateRequired then
		-- something changed during a search - complete the update now the search has finished
		private.factionUpdateRequired = nil
		private.SetCurrentFaction()
	elseif event == "selecttab" then
		if subevent == lib.tabname and private.doValidation then
			private.doValidation()
		end
	elseif event == "config" then
		-- update private variables, but only if a relevant setting may have changed
		if subevent == "changed" then
			local setting = ...
			if setting and setting:match("^arbitrage") then
				private.SetCurrentFaction()
			end
		elseif subevent == "loaded" or subevent == "reset" or subevent == "deleted" then
			private.SetCurrentFaction()
		end
	elseif event == "resources" and subevent == "faction" then
		private.SetCurrentFaction()
	elseif event == "onload" and subevent == "auc-util-searchui" then
		if private.createRealmList then
			private.createRealmList()
		end
	end
end

-- Keep our internal settings up to date with any changes, so that Search can just use the values
function private.SetCurrentFaction()
	if parent.IsSearching() then
		-- cannot update settings until the search finishes - flag it and exit
		private.factionUpdateRequired = true
		return
	end

	local playerFaction = UnitFactionGroup("player")
	local playerRealm = resources.Realm

	local searchRealm, searchFaction
	local searchstyle = get("arbitrage.search.style")

	if searchstyle == "Neutral" then
		-- if at neutral compare to home. if at home, compare to neutral
		searchFaction = resources.Faction == "Neutral" and playerFaction or "Neutral"
		searchRealm = playerRealm
	elseif searchstyle == "Cross-Faction" then
		-- search opposing faction (even if at neutral AH)
		searchFaction = playerFaction == "Alliance" and "Horde" or "Alliance"
		searchRealm = playerRealm
	elseif searchstyle == "Cross-Realm" then
		-- search whatever combination is in the two crossrealm* dropdown boxes
		searchFaction = get("arbitrage.search.crossrealmfaction")
		searchRealm = get("arbitrage.search.crossrealmrealm")

		-- force there to always be a crossrealmrealm setting, to avoid Selectbox problems
		-- we cannot set a default as this causes problems using Arbitrage on different servers - which defeats the purpose
		if not searchRealm then
			searchRealm = playerRealm
			set("arbitrage.search.crossrealmrealm", searchRealm)
		end
	else
		-- invalid setting - clear it and bail out - calling set() will recurse into SetCurrentFaction
		set("arbitrage.search.style", nil)
		return
	end
	private.searchKey = searchRealm.."-"..searchFaction -- serverKey
	private.searchFaction = searchFaction:lower()
	private.searchAdjust = searchFaction == "Neutral" and 0.85 or 0.95 -- cut rate adjustment
	private.searchLabel = "|cffffff7fSearching: "..searchRealm.."/"..searchFaction.."|r"

	-- Display our current search destination in the GUI
	if private.displaySearch then
		private.displaySearch:SetText(private.searchLabel)
	end
end

-- This function is automatically called when we need to create our search parameters
function lib:MakeGuiConfig(gui)
	-- Get our tab and populate it with our controls
	local id = gui:AddTab(lib.tabname, "Searchers")
	gui:MakeScrollable(id)

	-- Add the help
	gui:AddSearcher("Arbitrage", "Find items which can be neutral, cross-faction or cross-realm traded", 100)
	gui:AddHelp(id, "arbitrage searcher",
		"What does this searcher do?",
		"This searcher provides the ability to search for specific items that can be traded to neutral, cross faction or cross realm for a profit.")

	gui:AddControl(id, "Header",     0,      "Arbitrage search criteria")

	local last = gui:GetLast(id)

	gui:AddControl(id, "MoneyFramePinned",  0, 1, "arbitrage.profit.min", 1, 99999999, "Minimum Profit")
	gui:AddControl(id, "Slider",            0, 1, "arbitrage.profit.pct", 1, 100, .5, "Min Discount: %0.01f%%")
	gui:AddControl(id, "Checkbox",          0, 1, "arbitrage.seen.check", "Check Seen count")
	gui:AddControl(id, "Slider",            0, 2, "arbitrage.seen.min", 1, 100, 1, "Min seen count: %s")

	gui:AddControl(id, "Subhead",           0, "Search against")
	private.displaySearch = gui:AddControl(id, "Label", 0, 1, nil, private.searchLabel)
	gui:AddControl(id, "Label",             0, 1, nil, "Search type:")
	gui:AddControl(id, "Selectbox",         0, 1, private.getStyles, "arbitrage.search.style")
	gui:AddControl(id, "Label",             0, 1, nil, "Cross-Realm additional settings:")
	gui:AddControl(id, "Selectbox",         0, 1, private.getRealmList, "arbitrage.search.crossrealmrealm")
	gui:AddControl(id, "Selectbox",         0, 1, private.getFactions, "arbitrage.search.crossrealmfaction")

	gui:SetLast(id, last)
	gui:AddControl(id, "Checkbox",          0.42, 1, "arbitrage.allow.bid", "Allow Bids")
	gui:SetLast(id, last)
	gui:AddControl(id, "Checkbox",          0.56, 1, "arbitrage.allow.buy", "Allow Buyouts")
	gui:AddControl(id, "Checkbox",          0.42, 1, "arbitrage.maxprice.enable", "Enable individual maximum price:")
	gui:AddTip(id, "Limit the maximum amount you want to spend with the Arbitrage searcher")
	gui:AddControl(id, "MoneyFramePinned",  0.42, 2, "arbitrage.maxprice", 1, 99999999, "Maximum Price for Arbitrage")

	gui:AddControl(id, "Subhead",           0.42,    "Price Valuation Method:")
	gui:AddControl(id, "Selectbox",         0.42, 1, resources.selectorPriceModels, "arbitrage.model")
	gui:AddTip(id, "The pricing model that is used to work out the calculated value of items at the Auction House.")

	gui:AddControl(id, "Subhead",           0.42,    "Fees Adjustment")
	gui:AddControl(id, "Checkbox",          0.42, 1, "arbitrage.adjust.brokerage", "Subtract auction fees")
	gui:AddControl(id, "Checkbox",          0.42, 1, "arbitrage.adjust.deposit", "Subtract deposit:")
	gui:AddControl(id, "Selectbox",         0.42, 1, resources.selectorAuctionLength, "arbitrage.adjust.deplength")
	gui:AddControl(id, "Slider",            0.42, 1, "arbitrage.adjust.listings", 1, 10, .1, "Ave relistings: %0.1fx")
end

function lib.Search(item)
	local link = item[Const.LINK]
	if not link then
		return false, "No link"
	end
	local bidprice, buyprice = item[Const.PRICE], item[Const.BUYOUT]
	local maxprice = get("arbitrage.maxprice.enable") and get("arbitrage.maxprice")
	if buyprice <= 0 or not get("arbitrage.allow.buy") or (maxprice and buyprice > maxprice) then
		buyprice = nil
	end
	if not get("arbitrage.allow.bid") or (maxprice and bidprice > maxprice) then
		bidprice = nil
	end
	if not (bidprice or buyprice) then
		return false, "Does not meet bid/buy requirements"
	end

	local market, seen, curModel = resources.GetPrice(get("arbitrage.model"), link, private.searchKey)
	if not market then
		return false, "No market price"
	end
	local count = item[Const.COUNT]
	market = market * count

	if (get("arbitrage.seen.check")) and curModel ~= "fixed" then
		if ((not seen) or (seen < get("arbitrage.seen.min"))) then
			return false, "Seen count too low"
		end
	end

	--set up correct brokerage/deposit costs for our target AH
	if get("arbitrage.adjust.brokerage") then
		market = market * private.searchAdjust
	end
	if get("arbitrage.adjust.deposit") then
		local amount = GetDepositCost(link, get("arbitrage.adjust.deplength"), private.searchFaction, count)
		if amount then
			market = market - amount * get("arbitrage.adjust.listings")
		end
	end

	local value = min(market*(100-get("arbitrage.profit.pct"))/100, market-get("arbitrage.profit.min"))
	if buyprice and buyprice <= value then
		return "buy", market
	elseif bidprice and bidprice <= value then
		return "bid", market
	end
	return false, "Not enough profit"
end

AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Auc-Util-SearchUI/SearcherArbitrage.lua $", "$Rev: 4432 $")
