--[[
	Auctioneer - Item Suggest module
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: Auc-Util-ItemSuggest.lua 4432 2009-08-29 14:55:35Z dinesh $
	URL: http://auctioneeraddon.com/

	This is an Auctioneer module that allows the added tooltip for suggesting
	what should be done with an item based on weights and skills set. This module is also
	used by other modules in Auctioneer.

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

local libType, libName = "Util", "ItemSuggest"
local lib,parent,private = AucAdvanced.NewModule(libType, libName)
if not lib then return end
local print,decode,_,_,replicate,empty,get,set,default,debugPrint,fill = AucAdvanced.GetModuleLocals()
local GetAprPrice = AucAdvanced.Modules.Util.Appraiser.GetPrice
local AppraiserValue, DisenchantValue, ProspectValue, MillingValue, ConvertValue, VendorValue, bestmethod, bestvalue, _
local resultcache
local cutRate = 0.05 -- "home" AH cut / broker fee. todo: Is it worth introducing a "neutral" AH option?

function lib.GetName()
	return libName
end

function lib.Processor(callbackType, ...)
	if (callbackType == "tooltip") then lib.ProcessTooltip(...) --Called when the tooltip is being drawn.
	elseif (callbackType == "config") then lib.SetupConfigGui(...) --Called when you should build your Configator tab.
	elseif (callbackType == "listupdate") then --Called when the AH Browse screen receives an update.
	elseif (callbackType == "configchanged") then --Called when your config options (if Configator) have been changed.
		resultcache = nil
	elseif (callbackType == "scanstats") then
		resultcache = nil
	end
end

function lib.ProcessTooltip(tooltip, name, hyperlink, quality, quantity, cost, additional)
	if (get("util.itemsuggest.enablett")) then
		local aimethod = lib.itemsuggest(hyperlink, quantity)
		tooltip:AddLine("Suggestion: ".. aimethod.. " this item")
	end
end

function lib.OnLoad()
	print("AucAdvanced: {{"..libType..":"..libName.."}} loaded!")
	-- Check for invalid setting from older versions of ItemSuggest (<=r3872)
	local validate, deplength = {[12]=true,[24]=true,[48]=true}, get("util.itemsuggest.deplength")
	if not validate[deplength] then
		deplength = tonumber(deplength)
		deplength = validate[deplength] and deplength or 48
		set ("util.itemsuggest.deplength", deplength)
	end
end

local ahdeplength = {
	{12, "12 hour"},
	{24, "24 hour"},
	{48, "48 hour"},
}
default("util.itemsuggest.enablett", 1) --Enables Item Suggest from Item AI to be displayed in tooltip
default("util.itemsuggest.enchantskill", 450) -- Used for item AI
default("util.itemsuggest.jewelcraftskill", 450)-- Used for item AI
default("util.itemsuggest.inscriptionskill", 450)-- Used for item AI
default("util.itemsuggest.vendorweight", 100)-- Used for item AI
default("util.itemsuggest.auctionweight", 100)-- Used for item AI
default("util.itemsuggest.prospectweight", 100)-- Used for item AI
default("util.itemsuggest.millingweight", 100)-- Used for item AI
default("util.itemsuggest.disenchantweight", 100)-- Used for item AI
default("util.itemsuggest.convertweight", 100)-- Used for item AI
default("util.itemsuggest.relisttimes", 1)-- Used for item AI
default("util.itemsuggest.includebrokerage", 1)-- Used for item AI
default("util.itemsuggest.includedeposit", 1)-- Used for item AI
default("util.itemsuggest.deplength", 48)

function lib.SetupConfigGui(gui)
	local id = gui:AddTab(libName)
	gui:MakeScrollable(id)

	gui:AddHelp(id, "what itemsuggest",
        "What is the ItemSuggest module?",
        "ItemSuggest adds a tooltip line that suggests whether or not to auction, vendor, disenchant, prospect, mill or convert that item.")

	gui:AddControl(id, "Header",     0,    "ItemSuggest Options")
	gui:AddControl(id, "Checkbox",      0, 1, "util.itemsuggest.enablett", "Display ItemSuggest tooltips")
	gui:AddTip(id,  "If enabled, will show ItemSuggest tooltip information.")

    gui:AddControl(id, "Header",     0,    "Skill usage Limits")
	gui:AddControl(id, "WideSlider",           0, 2, "util.itemsuggest.enchantskill", 0, 450, 5, "Max Enchanting Skill On Realm: %s")
	gui:AddTip(id, "Set ItemSuggest limits based upon Enchanting skill for your characters on this realm.")
	gui:AddControl(id, "WideSlider",           0, 2, "util.itemsuggest.jewelcraftskill", 0, 450, 5, "Max JewelCrafting Skill On Realm: %s")
	gui:AddTip(id, "Set ItemSuggest limits based upon Jewelcrafting skill for your characters on this realm.")
	gui:AddControl(id, "WideSlider",           0, 2, "util.itemsuggest.inscriptionskill", 0, 450, 5, "Max Inscription Skill On Realm: %s")
	gui:AddTip(id, "Set ItemSuggest limits based upon Inscription skill for your characters on this realm.")

	gui:AddControl(id, "Header",     0,    "ItemSuggest Recommendation Bias")
	gui:AddControl(id, "WideSlider",           0, 2, "util.itemsuggest.vendorweight", 0, 200, 1, "Vendor Bias %s")
	gui:AddTip(id, "Weight ItemSuggest recommendations for vendor resale higher or lower.")
	gui:AddControl(id, "WideSlider",           0, 2, "util.itemsuggest.auctionweight", 0, 200, 1, "Auction Bias %s")
	gui:AddTip(id, "Weight ItemSuggest recommendations for auction resale higher or lower.")
	gui:AddControl(id, "WideSlider",           0, 2, "util.itemsuggest.disenchantweight", 0, 200, 1, "Disenchant Bias %s")
	gui:AddTip(id, "Weight ItemSuggest recommendations for Disenchanting higher or lower.")
	gui:AddControl(id, "WideSlider",           0, 2, "util.itemsuggest.prospectweight", 0, 200, 1, "Prospect Bias %s")
   	gui:AddTip(id, "Weight ItemSuggest recommendations for Prospecting higher or lower.")
	gui:AddControl(id, "WideSlider",           0, 2, "util.itemsuggest.millingweight", 0, 200, 1, "Milling Bias %s")
   	gui:AddTip(id, "Weight ItemSuggest recommendations for Milling higher or lower.")
	gui:AddControl(id, "WideSlider",           0, 2, "util.itemsuggest.convertweight", 0, 200, 1, "Conversion Bias %s")
   	gui:AddTip(id, "Weight ItemSuggest recommendations for Conversion higher or lower.")

	gui:AddControl(id, "Header",     0,    "Deposit cost influence")
	gui:AddControl(id, "Checkbox",     0, 1, "util.itemsuggest.includedeposit", "Include deposit costs")
	gui:AddTip(id, "Set whether or not to include Auction House deposit costs as part of ItemSuggest tooltip calculations.")
	gui:AddControl(id, "Selectbox",		0, 1, 	ahdeplength, "util.itemsuggest.deplength", "Base deposits on what length of auction.")
	gui:AddTip(id, "If Auction House deposit costs are included, set the default Auction period used for purposes of calculating Auction House deposit costs.")
	gui:AddControl(id, "WideSlider",       0, 2, "util.itemsuggest.relisttimes", 1, 20, 0.1, "Average # of listings: %0.1fx")
	gui:AddTip(id, "Set the estimated average number of times an auction item is relisted.")
	gui:AddControl(id, "Checkbox",     0, 1, "util.itemsuggest.includebrokerage", "Include AH brokerage costs")
	gui:AddTip(id, "Set whether or not to include Auction House brokerage costs as part of ItemSuggest tooltip calculations.")

end

function lib.itemsuggest(hyperlink, quantity)
	if resultcache and resultcache[hyperlink] then
		local bestmethod, bestvalue = strsplit(";", resultcache[hyperlink])
		return bestmethod, tonumber(bestvalue)
	end
	-- Determine Base Values
	if (quantity == nil) then quantity = 1 end
	VendorValue = lib.GetVendorValue(hyperlink, quantity) or 0
	AppraiserValue = lib.GetAppraiserValue(hyperlink, quantity) or 0
	ConvertValue = lib.GetConvertValue (hyperlink, quantity) or 0

	if (get("util.itemsuggest.jewelcraftskill") == 0) then
		ProspectValue = 0
	else
		ProspectValue = lib.GetProspectValue(hyperlink, quantity) or 0
	end

	if (get("util.itemsuggest.inscriptionskill") == 0) then
		MillingValue = 0
	else
		MillingValue = lib.GetMillingValue(hyperlink, quantity) or 0
	end

	if (get("util.itemsuggest.enchantskill") == 0) then
		DisenchantValue = 0
	else
		DisenchantValue = lib.GetDisenchantValue(hyperlink, quantity) or 0
	end

	-- Adjust final values based on custom weights by enduser
	local adjustment = get("util.itemsuggest.vendorweight") or 0
	VendorValue = VendorValue * adjustment / 100
	adjustment = get("util.itemsuggest.auctionweight") or 0
	AppraiserValue = AppraiserValue * adjustment / 100
	adjustment = get("util.itemsuggest.prospectweight") or 0
	ProspectValue = ProspectValue * adjustment / 100
	adjustment = get("util.itemsuggest.millingweight") or 0
	MillingValue = MillingValue * adjustment / 100
	adjustment = get("util.itemsuggest.disenchantweight") or 0
	DisenchantValue = DisenchantValue * adjustment / 100
	adjustment = get("util.itemsuggest.convertweight") or 0
	ConvertValue = ConvertValue * adjustment / 100

	-- Determine which method 'wins' the battle
	bestvalue = math.max(0, VendorValue, AppraiserValue, ProspectValue, MillingValue, ConvertValue, DisenchantValue)
	bestmethod = "Unknown"
	if bestvalue == 0 then
		bestmethod = "Unknown"
		bestvalue = "Unknown"
	elseif bestvalue == VendorValue then
		bestmethod = "Vendor"
	elseif bestvalue == AppraiserValue then
		bestmethod = "Auction"
	elseif bestvalue == ProspectValue then
		bestmethod = "Prospect"
	elseif bestvalue == MillingValue then
		bestmethod = "Mill"
	elseif bestvalue == DisenchantValue then
		bestmethod = "Disenchant"
	elseif bestvalue == ConvertValue then
		bestmethod = "Convert"
	end

	if not resultcache then resultcache = {} end
	resultcache[hyperlink] = strjoin(";", bestmethod, tostring(bestvalue))
	-- Hand the winner back to caller...
	return bestmethod, bestvalue
end

function lib.GetAppraiserValue(hyperlink, quantity)
	AppraiserValue = GetAprPrice(hyperlink, nil, true) or 0
	AppraiserValue = AppraiserValue * quantity
	local brokerRate, depositRate = 0.05, 0.05
	if (get("util.itemsuggest.includebrokerage")) then
		AppraiserValue = AppraiserValue - AppraiserValue * brokerRate
	end
	if (get("util.itemsuggest.includedeposit")) then
		local aadvdepcost = GetDepositCost(hyperlink, get("util.itemsuggest.deplength"), nil, quantity) or 0
		local depcost = aadvdepcost * get("util.itemsuggest.relisttimes")
		AppraiserValue = AppraiserValue - depcost
	end

return AppraiserValue end

function lib.GetDisenchantValue(hyperlink, quantity)
	if not (Enchantrix and Enchantrix.Storage) then return end
	local DisenchantValue = 0
	local _, _, iQual, iLevel = GetItemInfo(hyperlink)
	if (iQual == nil or iQual <= 1 or iLevel == nil) then return end
	local skillneeded = Enchantrix.Util.DisenchantSkillRequiredForItemLevel(iLevel, iQual)
	local market

	if (skillneeded > get("util.itemsuggest.enchantskill"))  then
		return DisenchantValue
	else
		_, _, _, market = Enchantrix.Storage.GetItemDisenchantTotals(hyperlink)

		if (market == 0)  then
			return DisenchantValue
		end
	end

	local adjusted = market or 0

	if (get("util.itemsuggest.includebrokerage")) then
		local brokerRate, depositRate = 0.05, 0.05
		local amount = (adjusted * brokerRate)
		adjusted = adjusted - amount
	end

	DisenchantValue = adjusted * quantity -- quantity may be more than 1 when mousing over Appraiser
return DisenchantValue end

function lib.GetProspectValue(hyperlink, quantity)
	if not Enchantrix then return end
	local jcSkillRequired = Enchantrix.Util.JewelCraftSkillRequiredForItem(hyperlink)
	if not jcSkillRequired or jcSkillRequired > get("util.itemsuggest.jewelcraftskill")  then
		return
	end
	local prospects = Enchantrix.Storage.GetItemProspects(hyperlink)
	if not prospects then return end
	
	local marketTotal, depositTotal = 0, 0
	local depositAucLength, depositRelistTimes
	local includeDeposit = get("util.itemsuggest.includedeposit")
	if includeDeposit then
		depositAucLength = get("util.itemsuggest.deplength")
		depositRelistTimes = get("util.itemsuggest.relisttimes")
	end

	for result, yield in pairs(prospects) do
		-- adjust for stack size
		yield = yield * quantity / 5

		-- fetch value of each result from Enchantrix
		local _, _, _, market = Enchantrix.Util.GetReagentPrice(result)
		market = market or 0 -- treat nil value as 0
		marketTotal = marketTotal + market * yield

		-- calculate deposit for each result
		if includeDeposit then
			local aadvdepcost = GetDepositCost(result, depositAucLength, nil, nil) or 0
			depositTotal = depositTotal + aadvdepcost * yield * depositRelistTimes
		end
	end
	
	-- Adjustments
	if get("util.itemsuggest.includebrokerage") then -- Auction House cut
		marketTotal = marketTotal * (1 - cutRate)
	end
	marketTotal = marketTotal - depositTotal

	return marketTotal
end

function lib.GetMillingValue(hyperlink, quantity)
	if not Enchantrix then return end
	local insSkillRequired = Enchantrix.Util.InscriptionSkillRequiredForItem(hyperlink)
	if not insSkillRequired or insSkillRequired > get("util.itemsuggest.inscriptionskill")  then
		return
	end
	local pigments = Enchantrix.Storage.GetItemMilling(hyperlink)
	if not pigments then return end
	
	local marketTotal, depositTotal = 0, 0
	local depositAucLength, depositRelistTimes
	local includeDeposit = get("util.itemsuggest.includedeposit")
	if includeDeposit then
		depositAucLength = get("util.itemsuggest.deplength")
		depositRelistTimes = get("util.itemsuggest.relisttimes")
	end

	for result, yield in pairs(pigments) do
		-- adjust for stack size
		yield = yield * quantity / 5

		-- fetch value of each result from Enchantrix
		local _, _, _, market = Enchantrix.Util.GetReagentPrice(result)
		market = market or 0 -- treat nil value as 0
		marketTotal = marketTotal + market * yield

		-- calculate deposit for each result
		if includeDeposit then
			local aadvdepcost = GetDepositCost(result, depositAucLength, nil, nil) or 0
			depositTotal = depositTotal + aadvdepcost * yield * depositRelistTimes
		end
	end
	
	-- Adjustments
	if get("util.itemsuggest.includebrokerage") then -- Auction House cut
		marketTotal = marketTotal * (1 - cutRate)
	end
	marketTotal = marketTotal - depositTotal

	return marketTotal
end

local findConvertable = {}
do -- build table for Converter-suggest
	-- Copied and modified from SearcherConverter.lua
	-- todo: possibly modify SearchUI to export its table, and reuse the same table here?
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
	
	-- Build the table
	-- ItemSuggest version
	-- Two-way
	for idl, idg in pairs (lesser_greater) do
		findConvertable[idl] = {idg, 1/3}
		findConvertable[idg] = {idl, 3}
	end
	for idc, ide in pairs (crystallized_eternal) do
		findConvertable[idc] = {ide, 0.1}
		findConvertable[ide] = {idc, 10}
	end
	-- One-way
	for id, idto in pairs (mote2primal) do
		findConvertable[id] = {idto, 0.1}
	end
	for id, idto in pairs (depleted2enhanced) do
		findConvertable[id] = {idto, 1}
	end
end

function lib.GetConvertValue (hyperlink, quantity)
	-- assume type(hyperlink) == "string" in all cases... if not, insert test here
	local id = tonumber(strmatch(hyperlink, "item:(%d+):"))
	local convert = findConvertable[id]
	if not convert then return end
	
	id = convert[1] -- id of item we can convert to
	
	local market = GetAprPrice(id, nil, true) or 0
	market = market * quantity
	if (get("util.itemsuggest.includebrokerage")) then
		market = market * (1 - cutRate)
	end
	if (get("util.itemsuggest.includedeposit")) then
		local aadvdepcost = GetDepositCost(id, get("util.itemsuggest.deplength"), nil, quantity) or 0
		market = market - aadvdepcost * get("util.itemsuggest.relisttimes")
	end
	
	-- Adjust for yield
	market = market * convert[2]

	return market
end

function lib.GetVendorValue(hyperlink, quantity)
	VendorValue = GetSellValue and GetSellValue(hyperlink) or 0
	VendorValue = VendorValue * quantity
return VendorValue end

AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Auc-Util-ItemSuggest/Auc-Util-ItemSuggest.lua $", "$Rev: 4432 $")
