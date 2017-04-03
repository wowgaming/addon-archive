--[[
	Auctioneer - Search UI - Searcher Milling
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: SearcherMilling.lua 4432 2009-08-29 14:55:35Z dinesh $
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
local lib, parent, private = AucSearchUI.NewSearcher("Milling")
if not lib then return end
--local print,decode,_,_,replicate,empty,_,_,_,debugPrint,fill = AucAdvanced.GetModuleLocals()
local get, set, default, Const, resources = parent.GetSearchLocals()

lib.tabname = "Milling"
-- Set our defaults
default("milling.profit.min", 1)
default("milling.profit.pct", 50)
default("milling.level.custom", false)
default("milling.level.min", 0)
default("milling.level.max", 450)
default("milling.adjust.brokerage", true)
default("milling.adjust.deposit", true)
default("milling.adjust.deplength", 48)
default("milling.adjust.listings", 3)
default("milling.allow.bid", true)
default("milling.allow.buy", true)
default("milling.maxprice", 10000000)
default("milling.maxprice.enable", false)
default("milling.model", "Enchantrix")

function private.doValidation()
	if not resources.isEnchantrixLoaded then
		message("Milling Searcher Warning!\nEnchantrix not detected\nThis searcher will not function until Enchantrix is loaded")
	elseif not resources.isValidPriceModel(get("milling.model")) then
		message("Milling Searcher Warning!\nCurrent price model setting ("..get("milling.model")..") is not valid. Select a new price model")
	else
		private.doValidation = nil
	end
end

-- This function is automatically called from AucSearchUI.NotifyCallbacks
function lib.Processor(event, subevent)
	if event == "selecttab" then
		if subevent == lib.tabname and private.doValidation then
			private.doValidation()
		end
	end
end

-- This function is automatically called when we need to create our search parameters
function lib:MakeGuiConfig(gui)
	-- Get our tab and populate it with our controls
	local id = gui:AddTab(lib.tabname, "Searchers")

	-- Add the help
	gui:AddSearcher("Milling", "Search for items which can be milled for profit", 100)
	gui:AddHelp(id, "milling searcher",
		"What does this searcher do?",
		"This searcher provides the ability to search for herbs which will mill into pigments that on average will have a greater value than the purchase price of the original herbs.")

	gui:AddControl(id, "Header",     0,      "Milling search criteria")

	local last = gui:GetLast(id)

	gui:AddControl(id, "MoneyFramePinned",  0, 1, "milling.profit.min", 1, 99999999, "Minimum Profit")
	gui:AddControl(id, "Slider",            0, 1, "milling.profit.pct", 1, 100, .5, "Min Discount: %0.01f%%")
	gui:AddControl(id, "Checkbox",          0, 1, "milling.level.custom", "Use custom levels")
	gui:AddControl(id, "Slider",            0, 2, "milling.level.min", 0, 450, 25, "Minimum skill: %s")
	gui:AddControl(id, "Slider",            0, 2, "milling.level.max", 25, 450, 25, "Maximum skill: %s")
	gui:AddControl(id, "Subhead",           0, "Note:")
	gui:AddControl(id, "Note",              0, 1, 290, 30, "The \"Pct\" Column is \% of Milling Value")

	gui:SetLast(id, last)
	gui:AddControl(id, "Checkbox",          0.42, 1, "milling.allow.bid", "Allow Bids")
	gui:SetLast(id, last)
	gui:AddControl(id, "Checkbox",          0.56, 1, "milling.allow.buy", "Allow Buyouts")
	gui:AddControl(id, "Checkbox",          0.42, 1, "milling.maxprice.enable", "Enable individual maximum price:")
	gui:AddTip(id, "Limit the maximum amount you want to spend with the Milling searcher")
	gui:AddControl(id, "MoneyFramePinned",  0.42, 2, "milling.maxprice", 1, 99999999, "Maximum Price for Milling")

	gui:AddControl(id, "Subhead",           0.42,    "Price Valuation Method:")
	gui:AddControl(id, "Selectbox",         0.42, 1, resources.selectorPriceModelsEnx, "milling.model")
	gui:AddTip(id, "The pricing model that is used to work out the calculated value of items at the Auction House.")

	gui:AddControl(id, "Subhead",           0.42,    "Fees Adjustment")
	gui:AddControl(id, "Checkbox",          0.42, 1, "milling.adjust.brokerage", "Subtract auction fees")
	gui:AddControl(id, "Checkbox",          0.42, 1, "milling.adjust.deposit", "Subtract deposit")
	gui:AddControl(id, "Selectbox",         0.42, 1, resources.selectorAuctionLength, "milling.adjust.deplength")
	gui:AddControl(id, "Slider",            0.42, 1, "milling.adjust.listings", 1, 10, .1, "Ave relistings: %0.1fx")
end

function lib.Search(item)
	if not resources.isEnchantrixLoaded then
		return false, "Enchantrix not detected"
	end
	if item[Const.QUALITY] ~= 1 then -- All millable herbs are "Common" quality
		return false, "Item not millable"
	end

	local bidprice, buyprice = item[Const.PRICE], item[Const.BUYOUT]
	local maxprice = get("milling.maxprice.enable") and get("milling.maxprice")
	if buyprice <= 0 or not get("milling.allow.buy") or (maxprice and buyprice > maxprice) then
		buyprice = nil
	end
	if not get("milling.allow.bid") or (maxprice and bidprice > maxprice) then
		bidprice = nil
	end
	if not (bidprice or buyprice) then
		return false, "Does not meet bid/buy requirements"
	end
	
	local itemID = item[Const.ITEMID]

	-- Give up if it doesn't mill to anything
	local pigments = Enchantrix.Storage.GetItemMilling(itemID)
	if not pigments then
		return false, "Item not millable"
	end

	local minskill, maxskill
	if get("milling.level.custom") then
		minskill = get("milling.level.min")
		maxskill = get("milling.level.max")
	else
		minskill = 0
		maxskill = Enchantrix.Util.GetUserInscriptionSkill()
	end
	local skillneeded = Enchantrix.Util.InscriptionSkillRequiredForItem(itemID)
	if (skillneeded < minskill) or (skillneeded > maxskill) then
		return false, "Skill not high enough to mill"
	end

	local market, deposit = 0, 0
	
	-- prep locals to speed up access inside the loop
	local depositAucLength, depositRelistTimes, depositFaction
	local includeDeposit = get("milling.adjust.deposit")
	if includeDeposit then
		depositAucLength = get("milling.adjust.deplength")
		depositRelistTimes = get("milling.adjust.listings")
		depositFaction = resources.faction
	end
	local model = get("milling.model")
	local GetPrice = resources.lookupPriceModel[model]

	for result, yield in pairs(pigments) do
		local price = GetPrice(model, result) or 0
		market = market + price * yield

		-- calculate deposit for each result
		if includeDeposit then
			local aadvdepcost = GetDepositCost(result, depositAucLength, depositFaction, nil) or 0
			deposit = deposit + aadvdepcost * yield * depositRelistTimes
		end
	end

	-- Adjust for fees and costs
	if get("milling.adjust.brokerage") then
		market = market * resources.CutAdjust
	end
	market = market - deposit
	
	-- Adjust for stack size and note that yield is per stack of 5
	market = market* item[Const.COUNT] / 5
	local value = min (market*(100-get("milling.profit.pct"))/100, market-get("milling.profit.min"))
	if buyprice and buyprice <= value then
		return "buy", market
	elseif bidprice and bidprice <= value then
		return "bid", market
	end
	return false, "Not enough profit"
end

AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Auc-Util-SearchUI/SearcherMilling.lua $", "$Rev: 4432 $")
