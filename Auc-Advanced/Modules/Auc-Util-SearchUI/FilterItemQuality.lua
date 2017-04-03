--[[
	Auctioneer - Search UI - Filter IgnoreItemQuality
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: FilterItemQuality.lua 4432 2009-08-29 14:55:35Z dinesh $
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
local lib, parent, private = AucSearchUI.NewFilter("ItemQuality")
if not lib then return end
local print,decode,_,_,replicate,empty,_,_,_,debugPrint,fill = AucAdvanced.GetModuleLocals()
local get,set,default,Const = AucSearchUI.GetSearchLocals()
lib.tabname = "ItemQuality"
-- Set our defaults
default("ignoreitemquality.enable", false)

local typename

local qualname = {
	[0] = "Poor",
	[1] = "Common",
	[2] = "Uncommon",
	[3] = "Rare",
	[4] = "Epic",
	[5] = "Legendary",
	[6] = "Artifact",
}

-- This function is automatically called when we need to create our search parameters
function lib:MakeGuiConfig(gui)
	if not typename then
		typename = {GetAuctionItemClasses()}
	end
	-- Get our tab and populate it with our controls
	local id = gui:AddTab(lib.tabname, "Filters")
	gui:MakeScrollable(id)

	-- Add the help
	gui:AddSearcher("ItemQuality", "Filter items by quality and type", 600)
	gui:AddHelp(id, "itemquality filter",
		"What does this filter do?",
		"This filter provides the ability to filter out specific item types which have a given quality. It can selectively apply it's filters only for certain types of searches.")

	gui:AddControl(id, "Header",     0,      "ItemQuality Filter Criteria")

	gui:AddControl(id, "Checkbox",    0, 1,  "ignoreitemquality.enable", "Enable ItemQuality filtering")
	gui:AddControl(id, "Subhead",     0, "Filter for:")
	for name, searcher in pairs(AucSearchUI.Searchers) do
		if searcher and searcher.Search then
			gui:AddControl(id, "Checkbox", 0, 1, "ignoreitemquality.filter."..name, name)
			gui:AddTip(id, "Filter Item Quality when searching with "..name)
			default("ignoreitemquality.filter."..name, false)
		end
	end

	gui:AddControl(id, "Subhead",      0,    "Ignore Item Quality by Type")
	for i = 0, 6 do
		local last = gui:GetLast(id)
		gui:AddControl(id, "Note", i*0.07, 1, 50, 20, qualname[i])
		if i < 6 then
			gui:SetLast(id, last)
		end
	end
	for i = 1, #typename do
		for j = 0, 6 do
			local last = gui:GetLast(id)
			gui:AddControl(id, "Checkbox", j*0.07+0.02, 1, "ignoreitemquality."..typename[i].."."..qualname[j], "")
			gui:AddTip(id, "Ignore "..qualname[j].." "..typename[i])
			gui:SetLast(id, last)
		end
		gui:AddControl(id, "Note", 0.49, 1, 200, 20, typename[i])
	end
end

--lib.Filter(item, searcher)
--This function will return true if the item is to be filtered
--Item is the itemtable, and searcher is the name of the searcher being called. If searcher is not given, it will assume you want it active.
function lib.Filter(item, searcher)
	if not typename then
		typename = {GetAuctionItemClasses()}
	end
	if (not get("ignoreitemquality.enable"))
			or (searcher and (not get("ignoreitemquality.filter."..searcher))) then
		return
	end

	local itype = item[Const.ITYPE]
	local quality = item[Const.QUALITY]
	quality = qualname[quality]
	if not quality then return end -- protection against Blizzard returning an unexpected value, e.g. after a patch

	if get("ignoreitemquality."..itype.."."..quality) then
		return true, quality.." "..itype.." filtered"
	end
	return false
end

AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Auc-Util-SearchUI/FilterItemQuality.lua $", "$Rev: 4432 $")
