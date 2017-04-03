--[[
	Auctioneer - Search UI - Filter IgnoreItemauctionhistory
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: FilterItemAuctionHistory.lua 4432 2009-08-29 14:55:35Z dinesh $
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
		You have an implicit licence to use this AddOn with these facilities
		since that is its designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat
--]]
-- Create a new instance of our lib with our parent
local lib, parent, private = AucSearchUI.NewFilter("ItemAuctionHistory")
if not lib then return end
local print,decode,_,_,replicate,empty,_,_,_,debugPrint,fill = AucAdvanced.GetModuleLocals()
local get,set,default,Const = AucSearchUI.GetSearchLocals()
lib.tabname = "ItemAuctionHistory"

-- Set our defaults
default("ignoreitemauctionhistory.enable", false)
default("ignoreitemauctionhistory.maxtime", 2)
default("ignoreitemauctionhistory.target_ratio", 0.2)
default("ignoreitemauctionhistory.min_scan_filter", 2)

-- This function is automatically called when we need to create our search parameters
function lib:MakeGuiConfig(gui)
	-- Get our tab and populate it with our controls
	local id = gui:AddTab(lib.tabname, "Filters")
	gui:MakeScrollable(id)

	gui:AddControl(id, "Header",     0,      "ItemAuctionHistory Filter Criteria")
	
	local last = gui:GetLast(id)
	gui:AddControl(id, "Checkbox",    0, 1,  "ignoreitemauctionhistory.enable", "Enable item auction history filtering")

	gui:AddControl(id, "Subhead",     0,     "Never filter unless there at least this many data points:")
	gui:AddControl(id, "WideSlider", 0, 1, "ignoreitemauctionhistory.min_scan_filter", 0, 100, 1, "%s")

	gui:AddControl(id, "Subhead",     0,     "Filter at and below this success/total ratio:")
	gui:AddControl(id, "WideSlider", 0, 1, "ignoreitemauctionhistory.target_ratio", 0, 1, 0.05, "%s")
	
	gui:SetLast(id, last)
	gui:AddControl(id, "Subhead",     .5, "Filter for:")
	for name, searcher in pairs(AucSearchUI.Searchers) do
		if searcher and searcher.Search then
			gui:AddControl(id, "Checkbox", 0.5, 1, "ignoreitemauctionhistory.filter."..name, name)
			gui:AddTip(id, "Filter Item Auction History when searching with "..name)
			default("ignoreitemauctionhistory.filter."..name, false)
		end
	end
end

--lib.Filter(item, searcher)
--This function will return true if the item is to be filtered
--Item is the itemtable, and searcher is the name of the searcher being called. If searcher is not given, it will assume you want it active.
function lib.Filter(item, searcher)

	if (not get("ignoreitemauctionhistory.enable"))
			or (get("ignoreitemauctionhistory.onlyonbids"))
			or (searcher and (not get("ignoreitemauctionhistory.filter."..searcher))) then
		return
	end

	local price = 0
	local filterModule=false

	-- If this item is grey, forget about it.
	if (item.qual == 0) then return end

	local itemId = item[Const.ITEMID]

	local _, _, itemRarity, itemLevel, _, itemType  = GetItemInfo(itemId)
	
	if (not itemLevel) then return end
	if (not itemType) then return end

	local minLevel=0

	local success = 0
	local failed = 0

	if BeanCounter and BeanCounter.Private.playerData then
		if BeanCounter.Private.playerData["completedAuctions"][tostring(itemId)] then
			for key in pairs(BeanCounter.Private.playerData["completedAuctions"][tostring(itemId)]) do
				success = #BeanCounter.Private.playerData["completedAuctions"][tostring(itemId)][key]
			end
		end
		if BeanCounter.Private.playerData["failedAuctions"][tostring(itemId)] then
			for key in pairs(BeanCounter.Private.playerData["failedAuctions"][tostring(itemId)]) do
				failed = #BeanCounter.Private.playerData["failedAuctions"][tostring(itemId)][key]
			end
		end
	end

	local s = success
	local f = failed
	
	local target_ratio = get("ignoreitemauctionhistory.target_ratio")
	local min_scan_filter = get("ignoreitemauctionhistory.min_scan_filter")

	local actual_ratio = 0
	
	-- if we have fewer than the minimum sightings, we're not filtering
	if (s+f) < min_scan_filter then
		return false -- not filtering
	end

	actual_ratio = s/(s+f)

	local sName, sLink, iRarity, iLevel, iMinLevel, sType, sSubType, iStackCount = GetItemInfo(itemId);

	if (actual_ratio <= target_ratio) then
--		print("Filtered "..sLink.." "..tostring(actual_ratio).." <= "..tostring(target_ratio))
		return true, actual_ratio
	end

	return false
end

AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Auc-Util-SearchUI/FilterItemAuctionHistory.lua $", "$Rev: 4432 $")
