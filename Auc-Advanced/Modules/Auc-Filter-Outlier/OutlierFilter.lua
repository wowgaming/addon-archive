--[[
	Auctioneer - Outlier Filter
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: OutlierFilter.lua 4432 2009-08-29 14:55:35Z dinesh $
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
]]
if not AucAdvanced then return end

local libType, libName = "Filter", "Outlier"
local lib,parent,private = AucAdvanced.NewModule(libType, libName)
if not lib then return end
local print,decode,_,_,replicate,empty,get,set,default,debugPrint,fill, _TRANS = AucAdvanced.GetModuleLocals()

local data

local reset = true
local cache, model, minseen, levels

function lib.Processor(callbackType, ...)
	if callbackType == "config" then
		private.SetupConfigGui(...)
	elseif callbackType == "scanstats" then
		reset = true
	end
end

function lib.AuctionFilter(operation, itemData)
	if not get("filter.outlier.activated") then
		return
	end
	if reset then
		model = get("filter.outlier.model")
		if model ~= "market" and not AucAdvanced.API.IsValidAlgorithm(model) then
			model = "market"
		end
		minseen = get("filter.outlier.minseen")
		cache = {}
		levels = {}
		if get("filter.outlier.poor.enabled") then levels[0] = get("filter.outlier.poor.level")/100 end
		if get("filter.outlier.common.enabled") then levels[1] = get("filter.outlier.common.level")/100 end
		if get("filter.outlier.uncommon.enabled") then levels[2] = get("filter.outlier.uncommon.level")/100 end
		if get("filter.outlier.rare.enabled") then levels[3] = get("filter.outlier.rare.level")/100 end
		if get("filter.outlier.epic.enabled") then levels[4] = get("filter.outlier.epic.level")/100 end
		if get("filter.outlier.legendary.enabled") then levels[5] = get("filter.outlier.legendary.level")/100 end
		if get("filter.outlier.artifact.enabled") then levels[6] = get("filter.outlier.artifact.level")/100 end
		reset = false
	end

	local quality = itemData.quality
	-- If we're not allowed to filter this quality of item
	if not levels[quality] then return false end

	local link = itemData.link
	local value = cache[link]
	if not value then
		local seen
		if model == "market" then
			value, seen = AucAdvanced.API.GetMarketValue(link)
		else
			value, seen = AucAdvanced.API.GetAlgorithmValue(model, link)
		end

		if not value or not seen or seen < minseen then
			value = 0
		end
		cache[link] = value
	end

	-- If there's no value then we can't filter it
	if value == 0 then return false end

	-- Check to see if the item price is below the price
	local price = itemData.buyoutPrice or itemData.price
	local level = levels[quality]
	local maxcap = value * level

	-- If the price is acceptible then allow it
	if itemData.stackSize > 1 then price = math.floor(price / itemData.stackSize) end
	if price < maxcap then return false end

	-- Otherwise this item needs to be filtered
	-- We need to see if this auction is to be ignored or not.
	if nLog then
		nLog.AddMessage(
			"auc-"..libType.."-"..libName,
			"AuctionFilter",
			N_INFO,
			"Filtered Data",
			"Auction Filter Removed Data for ", itemData.itemName,
			" from ", (itemData.sellerName or "UNKNOWN"),
			", quality ", tostring(quality or 0),
			", item level ", tostring(itemData.itemLevel or 0),
			".\n",
			"Price ", price, " > Cap ", maxcap
		)
	end
	return true
end

function lib.OnLoad(addon)
	default("filter.outlier.activated", true)
	default("filter.outlier.model", "market")
	default("filter.outlier.minseen", 10)
	default("filter.outlier.poor.enabled", true)
	default("filter.outlier.common.enabled", true)
	default("filter.outlier.uncommon.enabled", true)
	default("filter.outlier.rare.enabled", true)
	default("filter.outlier.epic.enabled", true)
	default("filter.outlier.legendary.enabled", true)
	default("filter.outlier.artifact.enabled", true)
	default("filter.outlier.poor.level", 200)
	default("filter.outlier.common.level", 200)
	default("filter.outlier.uncommon.level", 200)
	default("filter.outlier.rare.level", 250)
	default("filter.outlier.epic.level", 300)
	default("filter.outlier.legendary.level", 300)
	default("filter.outlier.artifact.level", 300)
end

function private.SetupConfigGui(gui)
	-- The defaults for the following settings are set in the lib.OnLoad function
	local id = gui:AddTab(libName, libType.." Modules")

	gui:AddHelp(id, "what outlier filter",
		_TRANS('OUTL_Help_WhatOutlierFilter') ,--What is this Outlier Filter?
		_TRANS('OUTL_Help_WhatOutlierFilterAnswer') )--When you get auctions that are posted up, many of the more common ones can become prey to people listing auctions for many times the 'real worth' of the actual item.\nThis filter detects such outliers and prevents them from being entered into the data stream if it\'s value exceeds a specified percentage of the normal value of the item. While still allowing for normal fluctuations in the prices of the items from day to day.

	gui:AddHelp(id, "can retroactive",
		_TRANS('OUTL_Help_RemoveOldOutliers') ,--Can it remove old outliers?
		_TRANS('OUTL_Help_RemoveOldOutliersAnswer') )--The simple answer is no, it only works from this point on. Any settings you apply are applied from here on in, and any current stats are left alone.\nThe complex answer? Well, you see there's this bowl of soup...

	gui:AddControl(id, "Header",     0,    _TRANS('OUTL_Interface_OutlierOptions') )--Outlier options
	gui:AddControl(id, "Checkbox",   0, 1, "filter.outlier.activated", _TRANS('OUTL_Interface_EnableOutlierFilter') )--Enable use of the outlier filter
	gui:AddTip(id, _TRANS('OUTL_HelpTooltip_EnableOutlierFilter') )--Ticking this box will enable the outlier filter to perform filtering of your auction scans

	gui:AddControl(id, "Subhead",    0,    _TRANS('OUTL_Interface_PriceMethod') )--Price valuation method:
	gui:AddControl(id, "Selectbox",  0, 1, parent.selectorPriceModels, "filter.outlier.model", _TRANS('OUTL_Interface_PricingModel') )--Pricing model to use for the valuation
	gui:AddTip(id, _TRANS('OUTL_HelpTooltip_PricingModel') )--The pricing model that will be used to determine the base pricing level

	gui:AddControl(id, "WideSlider", 0, 1, "filter.outlier.minseen", 1, 50, 1, _TRANS('OUTL_Interface_MinimumSeen') )--Minimum seen: %d
	gui:AddTip(id, _TRANS('OUTL_HelpTooltip_MinimumSeen') )--If an item has been seen less than this many times, it will not be filtered

	gui:AddControl(id, "Subhead",    0,    _TRANS('OUTL_Interface_SettingsQuality') )--Settings per quality:

	local _,_,_, hex = GetItemQualityColor(0)
	gui:AddControl(id, "Checkbox",   0, 1, "filter.outlier.poor.enabled", _TRANS('OUTL_Interface_EnablePoor'):format(hex, "|r") )--Enable filtering %s poor %s quality items
	gui:AddTip(id, _TRANS('OUTL_HelpTooltip_EnablePoor') )--Ticking this box will enable outlier filtering on poor quality items
	gui:AddControl(id, "WideSlider", 0, 1, "filter.outlier.poor.level", 100, 5000, 25, _TRANS('OUTL_Interface_CapGrowth').." %d%%")--Cap growth to:
	gui:AddTip(id, _TRANS('OUTL_HelpTooltip_MaximumPct') )--Set the maximum percentage that an item's price can grow before being filtered

	local _,_,_, hex = GetItemQualityColor(1)
	gui:AddControl(id, "Checkbox",   0, 1, "filter.outlier.common.enabled", _TRANS('OUTL_Interface_EnableCommon'):format(hex, "|r") )--Enable filtering %s common %s quality items
	gui:AddTip(id, _TRANS('OUTL_HelpTooltip_EnableCommon') )--Ticking this box will enable outlier filtering on common quality items
	gui:AddControl(id, "WideSlider", 0, 1, "filter.outlier.common.level", 100, 5000, 25, _TRANS('OUTL_Interface_CapGrowth').." %d%%")--Cap growth to:
	gui:AddTip(id, _TRANS('OUTL_HelpTooltip_MaximumPct') )--Set the maximum percentage that an item's price can grow before being filtered

	local _,_,_, hex = GetItemQualityColor(2)
	gui:AddControl(id, "Checkbox",   0, 1, "filter.outlier.uncommon.enabled", _TRANS('OUTL_Interface_EnableUnCommon'):format(hex, "|r") )--Enable filtering %s uncommon %s quality items
	gui:AddTip(id, _TRANS('OUTL_HelpTooltip_EnableUnCommon') )--Ticking this box will enable outlier filtering on uncommon quality items
	gui:AddControl(id, "WideSlider", 0, 1, "filter.outlier.uncommon.level", 100, 5000, 25, _TRANS('OUTL_Interface_CapGrowth').." %d%%")--Cap growth to:
	gui:AddTip(id, _TRANS('OUTL_HelpTooltip_MaximumPct') )--Set the maximum percentage that an items price can grow before being filtered

	local _,_,_, hex = GetItemQualityColor(3)
	gui:AddControl(id, "Checkbox",   0, 1, "filter.outlier.rare.enabled", _TRANS('OUTL_Interface_EnableRare'):format(hex, "|r") )--Enable filtering %s rare %s quality items
	gui:AddTip(id, _TRANS('OUTL_HelpTooltip_EnableRare') )--Ticking this box will enable outlier filtering on rare quality items
	gui:AddControl(id, "WideSlider", 0, 1, "filter.outlier.rare.level", 100, 5000, 25, _TRANS('OUTL_Interface_CapGrowth').." %d%%")--Cap growth to:
	gui:AddTip(id, _TRANS('OUTL_HelpTooltip_MaximumPct') )--Set the maximum percentage that an items price can grow before being filtered

	local _,_,_, hex = GetItemQualityColor(4)
	gui:AddControl(id, "Checkbox",   0, 1, "filter.outlier.epic.enabled", _TRANS('OUTL_Interface_EnableEpic'):format(hex, "|r") )--Enable filtering %s epic %s quality items
	gui:AddTip(id, _TRANS('OUTL_HelpTooltip_EnableEpic') )--Ticking this box will enable outlier filtering on epic quality items
	gui:AddControl(id, "WideSlider", 0, 1, "filter.outlier.epic.level", 100, 5000, 25, _TRANS('OUTL_Interface_CapGrowth').." %d%%")--Cap growth to:
	gui:AddTip(id, _TRANS('OUTL_HelpTooltip_MaximumPct') )--Set the maximum percentage that an items price can grow before being filtered

	local _,_,_, hex = GetItemQualityColor(5)
	gui:AddControl(id, "Checkbox",   0, 1, "filter.outlier.legendary.enabled", _TRANS('OUTL_Interface_EnableLegendary'):format(hex, "|r") )--Enable filtering %s legendary %s quality items
	gui:AddTip(id, _TRANS('OUTL_HelpTooltip_EnableLegendary') )--Ticking this box will enable outlier filtering on legendary quality items
	gui:AddControl(id, "WideSlider", 0, 1, "filter.outlier.legendary.level", 100, 5000, 25, _TRANS('OUTL_Interface_CapGrowth').." %d%%")--Cap growth to:
	gui:AddTip(id, _TRANS('OUTL_HelpTooltip_MaximumPct') )--Set the maximum percentage that an items price can grow before being filtered

	local _,_,_, hex = GetItemQualityColor(6)
	gui:AddControl(id, "Checkbox",   0, 1, "filter.outlier.artifact.enabled", _TRANS('OUTL_Interface_EnableArtifact'):format(hex, "|r") )--Enable filtering %s artifact %s quality items
	gui:AddTip(id, _TRANS('OUTL_HelpTooltip_EnableArtifact') )--Ticking this box will enable outlier filtering on artifact quality items
	gui:AddControl(id, "WideSlider", 0, 1, "filter.outlier.artifact.level", 100, 5000, 25, _TRANS('OUTL_Interface_CapGrowth').." %d%%")--Cap growth to:
	gui:AddTip(id, _TRANS('OUTL_HelpTooltip_MaximumPct') )--Set the maximum percentage that an items price can grow before being filtered

end

AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Auc-Filter-Outlier/OutlierFilter.lua $", "$Rev: 4432 $")
