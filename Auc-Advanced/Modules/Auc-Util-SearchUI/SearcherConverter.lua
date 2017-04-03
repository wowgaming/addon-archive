--[[
	Auctioneer - Search UI - Searcher Converter
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: SearcherConverter.lua 4432 2009-08-29 14:55:35Z dinesh $
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
local lib, parent, private = AucSearchUI.NewSearcher("Converter")
if not lib then return end
--local print,decode,_,_,replicate,empty,_,_,_,debugPrint,fill = AucAdvanced.GetModuleLocals()
local get, set, default, Const, resources = parent.GetSearchLocals()
lib.tabname = "Converter"

-- Build a table to do all our work
-- findConvertable[itemID] = {conversionID, yield, checkstring}
-- Note: ItemSuggest uses a copy of this code; if you change it here, change it in ItemSuggest as well!
local findConvertable = {}
do
	-- Set our constants
	--Essences
	local GCOSMIC = 34055
	local GPLANAR = 22446
	local GETERNAL = 16203
	local GNETHER = 11175
	local GMYSTIC = 11135
	local GASTRAL = 11082
	local GMAGIC = 10939
	local LCOSMIC = 34056
	local LPLANAR = 22447
	local LETERNAL = 16202
	local LNETHER = 11174
	local LMYSTIC = 11134
	local LASTRAL = 10998
	local LMAGIC = 10938
	--Motes/Primals
	local PAIR = 22451
	local MAIR = 22572
	local PEARTH= 22452
	local MEARTH = 22573
	local PFIRE = 21884
	local MFIRE = 22574
	local PLIFE = 21886
	local MLIFE = 22575
	local PMANA = 22457
	local MMANA = 22576
	local PSHADOW = 22456
	local MSHADOW = 22577
	local PWATER = 21885
	local MWATER = 22578
	--Crystallized/Eternal
	local CAIR = 37700
	local EAIR = 35623
	local CEARTH = 37701
	local EEARTH = 35624
	local CSHADOW = 37703
	local ESHADOW = 35627
	local CLIFE = 37704
	local ELIFE = 35625
	local CFIRE = 37702
	local EFIRE = 36860
	local CWATER = 37705
	local EWATER = 35622
	--Depleted items
	local DCBRACER = 32676 -- Depleted Cloth Bracers
	local DCBRACERTO = 32655 -- Crystalweave Bracers
	local DMGAUNTLETS = 32675 -- Depleted Mail Gauntlets
	local DMGAUNTLETSTO = 32656 -- Crystalhide Handwraps
	local DBADGE = 32672 -- Depleted Badge
	local DBADGETO = 32658 -- Badge of Tenacity
	local DCLOAK = 32677 -- Depleted Cloak
	local DCLOAKTO = 32665 -- Crystalweave Cape
	local DDAGGER = 32673 -- Depleted Dagger
	local DDAGGERTO = 32659	-- Crystal-Infused Shiv
	local DMACE = 32671 -- Depleted Mace
	local DMACETO = 32661 -- Apexis Crystal Mace
	local DRING = 32678 -- Depleted Ring
	local DRINGTO = 32664 -- Dreamcrystal Band
	local DSTAFF = 32679 -- Depleted Staff
	local DSTAFFTO = 32662 -- Flaming Quartz Staff
	local DSWORD = 32674 -- Depleted Sword
	local DSWORDTO = 32660 -- Crystalforged Sword
	local DTHAXE = 32670 -- Depleted Two-Handed Axe
	local DTHAXETO = 32663 -- Apexis Cleaver

	-- Temporary tables to help build the working table
	-- To add new conversions, edit these tables

	-- TWO WAY Tables

	local lesser_greater = {
		[LCOSMIC] = GCOSMIC,
		[LPLANAR] = GPLANAR,
		[LETERNAL] = GETERNAL,
		[LNETHER] = GNETHER,
		[LMYSTIC] = GMYSTIC,
		[LASTRAL] = GASTRAL,
		[LMAGIC] = GMAGIC,
	}
	local crystallized_eternal = {
		[CAIR] = EAIR,
		[CEARTH] = EEARTH,
		[CSHADOW] = ESHADOW,
		[CLIFE] = ELIFE,
		[CFIRE] = EFIRE,
		[CWATER] = EWATER,
	}

	-- ONE WAY Tables

	local mote2primal = {
		[MAIR] = PAIR,
		[MEARTH] = PEARTH,
		[MFIRE] = PFIRE,
		[MLIFE] = PLIFE,
		[MMANA] = PMANA,
		[MSHADOW] = PSHADOW,
		[MWATER] = PWATER,
	}
	local depleted2enhanced = {
		[DCBRACER] = DCBRACERTO,
		[DMGAUNTLETS] = DMGAUNTLETSTO,
		[DBADGE] = DBADGETO,
		[DCLOAK] = DCLOAKTO,
		[DDAGGER] = DDAGGERTO,
		[DMACE] = DMACETO,
		[DRING] = DRINGTO,
		[DSTAFF] = DSTAFFTO,
		[DSWORD] = DSWORDTO,
		[DTHAXE] = DTHAXETO,
	}

	--[[ placeholder for future development - not sure how this will work yet...
	-- Trade Professions need to be handled differently as yields may vary
	local smelt = {
		[10] = {
			[PEARTH] = MEARTH,
			[PFIRE] = MFIRE,
		},
	}
	--]]

	-- Build the table
	-- Two-way
	for idl, idg in pairs (lesser_greater) do
		findConvertable[idl] = {idg, 1/3, "converter.enableEssence"}
		findConvertable[idg] = {idl, 3, "converter.enableEssence"}
	end
	for idc, ide in pairs (crystallized_eternal) do
		findConvertable[idc] = {ide, 0.1, "converter.enableCrystallized"}
		findConvertable[ide] = {idc, 10, "converter.enableCrystallized"}
	end
	-- One-way
	for id, idto in pairs (mote2primal) do
		findConvertable[id] = {idto, 0.1, "converter.enableMote"}
	end
	for id, idto in pairs (depleted2enhanced) do
		findConvertable[id] = {idto, 1, "converter.enableDepleted"}
	end
end
-- export the table for other addons to reference
resources.SearcherConverterLookupTable = findConvertable

default("converter.profit.min", 1)
default("converter.profit.pct", 50)
default("converter.adjust.brokerage", true)
default("converter.adjust.deposit", true)
default("converter.adjust.deplength", 48)
default("converter.adjust.listings", 3)
default("converter.allow.bid", true)
default("converter.allow.buy", true)
default("converter.maxprice", 10000000)
default("converter.maxprice.enable", false)
--default("converter.matching.check", true)
--default("converter.buyout.check", true)
default("converter.enableEssence", true)
default("converter.enableMote", true)
default("converter.enableCrystallized", true)
default("converter.enableDepleted", false)
default("converter.model", "market")

function private.doValidation()
	if not resources.isValidPriceModel(get("converter.model")) then
		message("Converter Searcher Warning!\nCurrent price model setting ("..get("converter.model")..") is not valid. Select a new price model")
	else
		private.doValidation = nil
	end
end

-- This function is automatically called from AucSearchUI.NotifyCallbacks
private.validationRequired = true
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
	gui:AddSearcher("Converter", "Search for items which can be converted into other items for profit (essences, motes, etc)", 100)
	gui:AddHelp(id, "converter searcher",
		"What does this searcher do?",
		"This searcher provides the ability to search for items that can be converted to another item which is worth more money.")

	gui:AddControl(id, "Header",     0,      "Converter search criteria")
	local last = gui:GetLast(id)

	gui:AddControl(id, "MoneyFramePinned",  0, 1, "converter.profit.min", 1, 99999999, "Minimum Profit")
	gui:AddControl(id, "Slider",            0, 1, "converter.profit.pct", 1, 100, .5, "Min Discount: %0.01f%%")

	gui:AddControl(id, "Subhead",           0,   "Include in search")
	gui:AddControl(id, "Checkbox",          0, 1, "converter.enableEssence", "Essence: Greater <> Lesser")
	gui:AddControl(id, "Checkbox",          0, 1, "converter.enableMote", "Mote > Primal")
	gui:AddControl(id, "Checkbox",          0, 1, "converter.enableCrystallized", "Crystallized <> Eternal")
	gui:AddControl(id, "Checkbox",          0, 1, "converter.enableDepleted", "Depleted Items")
	gui:AddTip(id, "Warning: depleted items require Apexis Shards to convert. Apexis Shards can only be obtained from certain locations in Outland.")

	gui:SetLast(id, last)
	gui:AddControl(id, "Checkbox",          0.42, 1, "converter.allow.bid", "Allow Bids")
	gui:SetLast(id, last)
	gui:AddControl(id, "Checkbox",          0.56, 1,  "converter.allow.buy", "Allow Buyouts")
	gui:AddControl(id, "Checkbox",          0.42, 1, "converter.maxprice.enable", "Enable individual maximum price:")
	gui:AddTip(id, "Limit the maximum amount you want to spend with the Converter searcher")
	gui:AddControl(id, "MoneyFramePinned",  0.42, 2, "converter.maxprice", 1, 99999999, "Maximum Price for Converter")

	gui:AddControl(id, "Subhead",           0.42,    "Price Valuation Method:")
	gui:AddControl(id, "Selectbox",         0.42, 1, resources.selectorPriceModels, "converter.model")
	gui:AddTip(id, "The pricing model that is used to work out the calculated value of items at the Auction House.")

	gui:AddControl(id, "Subhead",           0.42,    "Fees Adjustment")
	gui:AddControl(id, "Checkbox",          0.42, 1, "converter.adjust.brokerage", "Subtract auction fees")
	gui:AddControl(id, "Checkbox",          0.42, 1, "converter.adjust.deposit", "Subtract deposit cost")
	gui:AddControl(id, "Selectbox",         0.42, 1, resources.selectorAuctionLength, "converter.adjust.deplength")
	gui:AddControl(id, "Slider",            0.42, 1, "converter.adjust.listings", 1, 10, .1, "Ave relistings: %0.1fx")

	--gui:AddControl(id, "Subhead",           0.42,  "Appraiser Value Origination")
	--gui:AddControl(id, "Checkbox",          0.42, 1, "converter.matching.check", "Use Market Matched")
	--gui:AddControl(id, "Checkbox",          0.42, 1, "converter.buyout.check", "Use buyout not bid")

	gui:SetLast(id, last)
end

function lib.Search (item)
	local convert = findConvertable[item[Const.ITEMID]]
	if not convert then
		return false, "Item not convertable"
	end

	local newID, yield, test = unpack(convert)
	if not get(test) then
		return false, "Category disabled"
	end

	local bidprice, buyprice = item[Const.PRICE], item[Const.BUYOUT]
	local maxprice = get("converter.maxprice.enable") and get("converter.maxprice")
	if buyprice <= 0 or not get("converter.allow.buy") or (maxprice and buyprice > maxprice) then
		buyprice = nil
	end
	if not get("converter.allow.bid") or (maxprice and bidprice > maxprice) then
		bidprice = nil
	end
	if not (bidprice or buyprice) then
		return false, "Does not meet bid/buy requirements"
	end

	local market = resources.GetPrice(get("converter.model"), newID)
	if not market then
		return false, "No market price"
	end
	local count = item[Const.COUNT] * yield
	market = market * count

	--adjust for brokerage/deposit costs
	if get("converter.adjust.brokerage") then
		market = market * resources.CutAdjust
	end
	if get("converter.adjust.deposit") then
		-- note: GetDepositCost calls GetSellValue API, which handles numerical itemIDs (prefers them actually)
		local amount = GetDepositCost(newID, get("converter.adjust.deplength"), resources.faction, count)
		if amount then
			market = market - amount * get("converter.adjust.listings")
		end
	end

	local value = min (market*(100-get("converter.profit.pct"))/100, market-get("converter.profit.min"))
	if buyprice and buyprice <= value then
		return "buy", market
	elseif bidprice and bidprice <= value then
		return "bid", market
	end
	return false, "Not enough profit"
end

AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Auc-Util-SearchUI/SearcherConverter.lua $", "$Rev: 4432 $")
