--[[
	Auctioneer - Search UI - Searcher General
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: SearcherGeneral.lua 4446 2009-09-13 09:33:34Z brykrys $
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
local lib, parent, private = AucSearchUI.NewSearcher("General")
if not lib then return end
local print,decode,_,_,replicate,empty,_,_,_,debugPrint,fill = AucAdvanced.GetModuleLocals()
local get,set,default,Const = AucSearchUI.GetSearchLocals()
lib.tabname = "General"

function private.getTypes()
	if not private.typetable then
		private.typetable = {GetAuctionItemClasses()}
		table.insert(private.typetable,1, "All")
	end
	return private.typetable
end

function private.getSubTypes()
	local subtypetable, typenumber
	local typename = get("general.type")
	local typetable = private.getTypes()
	if typename ~= "All" then
		for i, j in pairs(typetable) do
			if j == typename then
				typenumber = i
				break
			end
		end
	end
	if typenumber then
		subtypetable = {GetAuctionItemSubClasses(typenumber-1)}-- subtract 1 because 1 is the "All" category
		table.insert(subtypetable, 1, "All")
	else
		subtypetable = {[1]="All"}
	end
	return subtypetable
end

function private.getQuality()
	return {
			{-1, "All"},
			{0, "Poor"},
			{1, "Common"},
			{2, "Uncommon"},
			{3, "Rare"},
			{4, "Epic"},
			{5, "Legendary"},
			{6, "Artifact"},
		}
end

function private.getTimeLeft()
	return {
			{0, "Any"},
			{1, "less than 30 min"},
			{2, "2 hours"},
			{3, "12 hours"},
			{4, "48 hours"},
		}
end

-- Set our defaults
default("general.name", "")
default("general.name.exact", false)
default("general.name.regexp", false)
default("general.name.invert", false)
default("general.type", "All")
default("general.subtype", "All")
default("general.quality", -1)
default("general.timeleft", 0)
default("general.ilevel.min", 0)
default("general.ilevel.max", 300)
default("general.ulevel.min", 0)
default("general.ulevel.max", 80)
default("general.seller", "")
default("general.seller.exact", false)
default("general.seller.regexp", false)
default("general.seller.invert", false)
default("general.minbid", 0)
default("general.minbuy", 0)
default("general.maxbid", 999999999)
default("general.maxbuy", 999999999)

-- This function is automatically called when we need to create our search generals
function lib:MakeGuiConfig(gui)
	-- Get our tab and populate it with our controls
	local id = gui:AddTab(lib.tabname, "Searchers")

	-- Add the help
	gui:AddSearcher("General", "Search for items by general properties such as name, level etc", 100)
	gui:AddHelp(id, "general searcher",
		"What does this searcher do?",
		"This searcher provides the ability to search for specific items that are in the scan database by name, level, type, subtype, seller, price, timeleft and other similar generals.")

	gui:MakeScrollable(id)
	gui:AddControl(id, "Header",     0,      "Search criteria")

	local last = gui:GetLast(id)
	gui:SetControlWidth(0.35)
	gui:AddControl(id, "Text",       0,   1, "general.name", "Item name")
	local cont = gui:GetLast(id)
	gui:SetLast(id, last)
	gui:AddControl(id, "Checkbox",   0.11, 0, "general.name.exact", "Exact")
	gui:SetLast(id, last)
	gui:AddControl(id, "Checkbox",   0.21, 0, "general.name.regexp", "Regexp")
	gui:SetLast(id, last)
	gui:AddControl(id, "Checkbox",   0.35, 0, "general.name.invert", "Invert")

	gui:SetLast(id, cont)
	last = cont

	gui:AddControl(id, "Note",       0.0, 1, 100, 14, "Type:")
	gui:AddControl(id, "Selectbox",   0.0, 1, private.getTypes, "general.type", "ItemType")
	gui:SetLast(id, last)
	gui:AddControl(id, "Note",       0.3, 1, 100, 14, "SubType:")
	gui:AddControl(id, "Selectbox",   0.3, 1, private.getSubTypes, "general.subtype", "ItemSubType")
	gui:SetLast(id, last)
	gui:AddControl(id, "Note",       0.7, 1, 100, 14, "TimeLeft:")
	gui:AddControl(id, "Selectbox",  0.7, 1, private.getTimeLeft(), "general.timeleft", "TimeLeft")

	gui:AddControl(id, "Note",       0.0, 1, 100, 14, "Quality:")
	gui:AddControl(id, "Selectbox",   0.0, 1, private.getQuality(), "general.quality", "ItemQuality")

	last = gui:GetLast(id)
	gui:SetControlWidth(0.37)
	gui:AddControl(id, "NumeriSlider",     0,   1, "general.ilevel.min", 0, 300, 1, "Min item level")
	gui:SetControlWidth(0.37)
	gui:AddControl(id, "NumeriSlider",     0,   1, "general.ilevel.max", 0, 300, 1, "Max item level")
	cont = gui:GetLast(id)

	gui:SetLast(id, last)
	gui:SetControlWidth(0.17)
	gui:AddControl(id, "NumeriSlider",     0.6, 0, "general.ulevel.min", 0, 80, 1, "Min user level")
	gui:SetControlWidth(0.17)
	gui:AddControl(id, "NumeriSlider",     0.6, 0, "general.ulevel.max", 0, 80, 1, "Max user level")

	gui:SetLast(id, cont)

	last = gui:GetLast(id)
	gui:SetControlWidth(0.35)
	gui:AddControl(id, "Text",       0,   1, "general.seller", "Seller name")
	cont = gui:GetLast(id)
	gui:SetLast(id, last)
	gui:AddControl(id, "Checkbox",   0.13, 0, "general.seller.exact", "Exact")
	gui:SetLast(id, last)
	gui:AddControl(id, "Checkbox",   0.23, 0, "general.seller.regexp", "Regexp")
	gui:SetLast(id, last)
	gui:AddControl(id, "Checkbox",   0.37, 0, "general.seller.invert", "Invert")

	gui:SetLast(id, cont)
	gui:AddControl(id, "MoneyFramePinned", 0, 1, "general.minbid", 0, 999999999, "Minimum Bid")
	gui:SetLast(id, cont)
	gui:AddControl(id, "MoneyFramePinned", 0.5, 1, "general.minbuy", 0, 999999999, "Minimum Buyout")
	last = gui:GetLast(id)
	gui:AddControl(id, "MoneyFramePinned", 0, 1, "general.maxbid", 0, 999999999, "Maximum Bid")
	gui:SetLast(id, last)
	gui:AddControl(id, "MoneyFramePinned", 0.5, 1, "general.maxbuy", 0, 999999999, "Maximum Buyout")
end

function lib.Search(item)
	private.debug = ""
	if private.NameSearch("name", item[Const.NAME])
			and private.TypeSearch(item[Const.ITYPE], item[Const.ISUB])
			and private.TimeSearch(item[Const.TLEFT])
			and private.QualitySearch(item[Const.QUALITY])
			and private.LevelSearch("ilevel", item[Const.ILEVEL])
			and private.LevelSearch("ulevel", item[Const.ULEVEL])
			and private.NameSearch("seller", item[Const.SELLER])
			and private.PriceSearch("Bid", item[Const.PRICE])
			and private.PriceSearch("Buy", item[Const.BUYOUT]) then
		return true
	else
		return false, private.debug
	end
end

function private.LevelSearch(levelType, itemLevel)
	local min = get("general."..levelType..".min")
	local max = get("general."..levelType..".max")

	if itemLevel < min then
		private.debug = levelType.." too low"
		return false
	end
	if itemLevel > max then
		private.debug = levelType.." too high"
		return false
	end
	return true
end

function private.NameSearch(nametype,itemName)
	local name = get("general."..nametype)

	-- If there's no name, then this matches
	if not name or name == "" then
		return true
	end

	-- Lowercase the input
	name = name:lower()
	itemName = itemName:lower()

	-- Get the matching options
	local nameExact = get("general."..nametype..".exact")
	local nameRegexp = get("general."..nametype..".regexp")
	local nameInvert = get("general."..nametype..".invert")

	-- if we need to make a non-regexp, exact match:
	if nameExact and not nameRegexp then
		-- If the name matches or we are inverted
		if name == itemName and not nameInvert then
			return true
		elseif name ~= itemName and nameInvert then
			return true
		end
		private.debug = nametype.." is not exact match"
		return false
	end

	local plain, text
	text = name
	if not nameRegexp then
		plain = 1
	elseif nameExact then
		text = "^"..name.."$"
	end

	local matches = itemName:find(text, 1, plain)
	if matches and not nameInvert then
		return true
	elseif not matches and nameInvert then
		return true
	end
	private.debug = nametype.." does not match critia"
	return false
end

function private.TypeSearch(itype, isubtype)
	local searchtype = get("general.type")
	if searchtype == "All" then
		return true
	elseif searchtype == itype then
		local searchsubtype = get("general.subtype")
		if searchsubtype == "All" then
			return true
		elseif searchsubtype == isubtype then
			return true
		else
			private.debug = "Wrong Subtype"
			return false
		end
	else
		private.debug = "Wrong Type"
		return false
	end
end

function private.TimeSearch(iTleft)
	local tleft = get("general.timeleft")
	if tleft == 0 then
		return true
	elseif tleft == iTleft then
		return true
	else
		private.debug = "Time left wrong"
		return false
	end
end

function private.QualitySearch(iqual)
	local quality = get("general.quality")
	if quality == -1 then
		return true
	elseif quality == iqual then
		return true
	else
		private.debug = "Wrong Quality"
		return false
	end
end

function private.PriceSearch(buybid, price)
	local minprice, maxprice
	if buybid == "Bid" then
		minprice = get("general.minbid")
		maxprice = get("general.maxbid")
	else
		minprice = get("general.minbuy")
		maxprice = get("general.maxbuy")
	end
	if (price <= maxprice) and (price >= minprice) then
		return true
	elseif price < minprice then
		private.debug = buybid.." price too low"
	else
		private.debug = buybid.." price too high"
	end
	return false
end
AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Auc-Util-SearchUI/SearcherGeneral.lua $", "$Rev: 4446 $")
