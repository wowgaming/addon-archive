--[[
	Auctioneer - WoWEcon price statistics module
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: WOWEcon.lua 4432 2009-08-29 14:55:35Z dinesh $
	URL: http://auctioneeraddon.com/

	This is an Auctioneer statistic module that returns a price based on 
	any WoWEcon data you have.  You must have the WoWEcon addon installed
	for this statistic to have any affect.

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

local libType, libName = "Stat", "WOWEcon"
local lib,parent,private = AucAdvanced.NewModule(libType, libName)
if not lib then return end
local print,decode,_,_,replicate,empty,get,set,default,debugPrint,fill, _TRANS = AucAdvanced.GetModuleLocals()

function private.Sanitize(hyperlink)
	local lType, id, suffix, factor, enchant, seed = decode(hyperlink)
	if lType == "item" then
		local newbit, newlink
		if AucAdvanced.Settings.GetSetting("stat.wowecon.sanitize") then
			-- If the settings say to sanitize this item, them remove all the
			-- specificness from the hyperlink before sending it in.
			newbit = ("|Hitem:%d:%d:%d:%d:%d:%d:%d:%d|h"):format(id,0,0,0,0,0,suffix,factor)
			newlink = hyperlink:gsub("|Hitem:[%d%p:]+|h", newbit)
		else
			-- Only remove the random seed component from the link, leave the factor
			newlink = hyperlink:gsub("(|Hitem:[%d%p:]+):[%p%d]+|h", "%1:"..factor.."|h")
		end
		assert(newlink, "Link sanitization failed")
		return newlink
	end
	return hyperlink
end

function lib.GetPrice(hyperlink, faction, realm)
	if not AucAdvanced.Settings.GetSetting("stat.wowecon.enable") then return end
	if not (Wowecon and Wowecon.API) then return end
	hyperlink = private.Sanitize(hyperlink)

	local price,seen,specific = Wowecon.API.GetAuctionPrice_ByLink(hyperlink)
	if specific and AucAdvanced.Settings.GetSetting("stat.wowecon.useglobal") then
		price,seen = Wowecon.API.GetAuctionPrice_ByLink(hyperlink, Wowecon.API.GLOBAL_PRICE)
	end
	return price, false, seen, specific
end

function lib.GetPriceColumns()
	if not (Wowecon and Wowecon.API) then return end
	return "WOWEcon Price", false, "WOWEcon Seen"
end

local array = {}
function lib.GetPriceArray(hyperlink, faction, realm)
	if not AucAdvanced.Settings.GetSetting("stat.wowecon.enable") then return end
	if not (Wowecon and Wowecon.API) then return end

	--Remove trailing :80 from item link, WoWEcon doesn't expect it and can't handle it.
	hyperlink = string.gsub(hyperlink, "(|Hitem:[^:]+:[^:]+:[^:]+:[^:]+:[^:]+:[^:]+:[^:]+:[^:]+):%d+(|h)", "%1%2")

	array.hyperlink = hyperlink
	hyperlink = private.Sanitize(hyperlink)
	array.sanitized = hyperlink

	-- Get our statistics
	local price,seen,specific = Wowecon.API.GetAuctionPrice_ByLink(hyperlink)

	array.price = price
	array.seen = seen or 0
	array.specific = specific

	if (specific) then
		array.s_price = price
		array.s_seen = seen
		price,seen = Wowecon.API.GetAuctionPrice_ByLink(hyperlink, Wowecon.API.GLOBAL_PRICE)
	else
		array.s_price = nil
		array.s_seen = 0
	end
	array.g_price = price
	array.g_seen = seen or 0

	if AucAdvanced.Settings.GetSetting("stat.wowecon.useglobal") then
		array.price = array.g_price
		array.seen = array.g_seen
		array.specific = false
	end

	return array
end

function lib.IsValidAlgorithm()
	if not (Wowecon and Wowecon.API) then return false end
	return true
end

function lib.CanSupplyMarket()
	if not (Wowecon and Wowecon.API) then return false end
	return true
end

function lib.Processor(callbackType, ...)
	if (callbackType == "config") then
		--Called when you should build your Configator tab.
		private.SetupConfigGui(...)
	elseif (callbackType == "load") then
		lib.OnLoad(...)
	elseif (callbackType == "tooltip") then
		lib.ProcessTooltip(...)
	end
end

function private.SetupConfigGui(gui)
	local id = gui:AddTab(lib.libName, lib.libType.." Modules")

	gui:AddHelp(id, "what global price",
		_TRANS('WECN_Help_WhatGlobalPrices') ,--What are global prices?
		_TRANS('WECN_Help_WhatGlobalPricesAnswer')--Wowecon provides two different types of prices: a global price, averaged across all servers, and a server specific price, for just your server and faction.
		)

	gui:AddHelp(id, "why use global",
		_TRANS('WECN_Help_WhyGlobalPrices') ,--Why should I use global prices?
		_TRANS('WECN_Help_WhyGlobalPricesAnswer') --Server specific prices can be useful if your server has prices which are far removed from the average, but often these prices are based on many fewer data points, causing your server specific price to possibly get out of whack for some items.  This option lets you force the Wowecon stat to always use global prices, if you\'d prefer.
		)

	gui:AddHelp(id, "prices dont match",
		_TRANS('WECN_Help_WoweconNoMatch') ,--The Wowecon price used by Appraiser doesn't match the Wowecon tooltip.  What gives?
		_TRANS('WECN_Help_WoweconNoMatchAnswer') --Wowecon gives you the option to hide server specific prices if seen fewer than a given number of times.  Even though these prices are hidden from the tooltip, they are still reported to Appraiser.  If you are not using the global price option here, you should check to make sure there isn\'t a hidden server specific price for your server, with just a small number of seen times.
		)

	gui:AddHelp(id, "sanitize link",
		_TRANS('WECN_Help_WhatSanitize') ,--What does the sanitize link option do?
		_TRANS('WECN_Help_WhatSanitizeAnswer') --Sanitizing the link can improve the price data you receive from WOWEcon by removing the parts of the link that are very specific (such as enchants, item factors, and gem informatio) to just get the price information for the common base item. This will generally only affect items that are slightly different from the normal base item, and have no, or very little price data due to their uniqueness.
		)

	gui:AddHelp(id, "show price tooltip",
		_TRANS('WECN_Help_WhyWOWEcon') ,--Why would I want to show the WOWEcon price in the tooltip?
		_TRANS('WECN_Help_WhyWOWEconAnswer') --The pricing data that Appraiser uses for the items may be different to the price data that WOWEcon displays by default, since WOWEcon can get very specific with the data that it returns. Enabling this option will let you see the exact price that this module is reporting for the current item.
		)

	--all options in here will be duplicated in the tooltip frame
	function private.addTooltipControls(id)
		gui:AddControl(id, "Header",     0,    _TRANS('WECN_Interface_WOWEconOptions') )--WOWEcon options
		gui:AddControl(id, "Note",       0, 1, nil, nil, " ")
		
		gui:AddControl(id, "Checkbox",   0, 1, "stat.wowecon.enable", _TRANS('WECN_Interface_EnableWOWEconStats') )--Enable WOWEcon Stats
		gui:AddTip(id, _TRANS('WECN_HelpTooltip_EnableWOWEconStats') )--Allow WOWEcon to gather and return price data

		gui:AddControl(id, "Checkbox",   0, 1, "stat.wowecon.useglobal", _TRANS('WECN_Interface_AlwaysGlobalPrice') )--Always use global price, not server price
		gui:AddTip(id, _TRANS('WECN_HelpTooltip_AlwaysGlobalPrice') )--Toggle use of server specific Wowecon price stats, if they exist
		gui:AddControl(id, "Checkbox",   0, 1, "stat.wowecon.sanitize", _TRANS('WECN_Interface_SanitizeWOWEcon') )--Sanitize links before sending to WOWEcon API
		gui:AddTip(id, _TRANS('WECN_HelpTooltip_SanitizeWOWEcon') )--Removes ultra-specific item data from links before issuing the price request
		gui:AddControl(id, "Checkbox",   0, 1, "stat.wowecon.tooltip", _TRANS('WECN_Interface_ShowWOWEconTooltip') )--Show WOWEcon value in tooltip (see note)
		gui:AddTip(id, _TRANS('WECN_HelpTooltip_ShowWOWEconTooltip') )--Note: WOWEcon already shows this by default, this may produce redundant information in your tooltip
		gui:AddControl(id, "Note",       0, 1, nil, nil, " ")
	end
	--This is the Tooltip tab provided by aucadvnced so all tooltip configuration is in one place
	local tooltipID = AucAdvanced.Settings.Gui.tooltipID
	
	--now we create a duplicate of these in the tooltip frame
	private.addTooltipControls(id)
	if tooltipID then private.addTooltipControls(tooltipID) end
end

function lib.OnLoad(addon)
	AucAdvanced.Settings.SetDefault("stat.wowecon.useglobal", true)
	AucAdvanced.Settings.SetDefault("stat.wowecon.enable", false)
	AucAdvanced.Settings.SetDefault("stat.wowecon.sanitize", true)
	AucAdvanced.Settings.SetDefault("stat.wowecon.tooltip", false)
end

function lib.ProcessTooltip(tooltip, name, hyperlink, quality, quantity, cost, ...)
	if not AucAdvanced.Settings.GetSetting("stat.wowecon.enable") then return end
	if not AucAdvanced.Settings.GetSetting("stat.wowecon.tooltip") then return end
	lib.GetPriceArray(hyperlink)

	if array.seen and array.seen > 0 then
		tooltip:SetColor(0.3, 0.9, 0.8)

		tooltip:AddLine(_TRANS('WECN_Tooltip_PricesSeen')..array.seen)--WOWEcon prices seen:

		if array.specific then
			tooltip:AddLine("  ".._TRANS('WECN_Tooltip_ServerPrice') , array.price * quantity)--Server price:
		else
			tooltip:AddLine("  ".._TRANS('WECN_Tooltip_GlobalPrice') , array.price * quantity)--Global price:
		end
		if (quantity > 1) then
			tooltip:AddLine("  ".._TRANS('WECN_Tooltip_Individually') , array.price)--(or individually)
		end

		if IsModifierKeyDown() then
			if array.specific then
				tooltip:AddLine("  ".._TRANS('WECN_Tooltip_GlobalSeen'):format(array.g_seen), array.g_price * quantity)--Global seen {{%s}}:
			elseif array.s_seen > 0 then
				tooltip:AddLine("  ".._TRANS('WECN_Tooltip_ServerSeen'):format(array.s_seen), array.s_price * quantity)--Server seen {{%s}}:
			else
				tooltip:AddLine("  ".._TRANS('WECN_Tooltip_NeverSeen') )-- Never seen for server
			end
		end

	end
end

AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Auc-Stat-WOWEcon/WOWEcon.lua $", "$Rev: 4432 $")
