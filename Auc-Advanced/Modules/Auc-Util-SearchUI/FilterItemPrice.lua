--[[
	Auctioneer - Search UI - Filter IgnoreItemPrice
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: FilterItemPrice.lua 4432 2009-08-29 14:55:35Z dinesh $
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
local lib, parent, private = AucSearchUI.NewFilter("ItemPrice")
if not lib then return end
local print,decode,_,_,replicate,empty,_,_,_,debugPrint,fill = AucAdvanced.GetModuleLocals()
local get,set,default,Const = AucSearchUI.GetSearchLocals()
lib.tabname = "ItemPrice"

-- Set our defaults
default("ignoreitemprice.enable", true)

local ignorelist = {}
private.tempignorelist = {}
private.sheetdata = {}

function private.OnEnterSheet(button, row, index)
	if private.ignorelistGUI.sheet.rows[row][index]:IsShown()then --Hide tooltip for hidden cells
		local link, name
		link = private.ignorelistGUI.sheet.rows[row][index]:GetText()
		name = GetItemInfo(link)
		if link and name then
			GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
			AucAdvanced.ShowItemLink(GameTooltip, link, count)
		end
	end
end

function private.OnLeaveSheet(button, row, index)
	GameTooltip:Hide()
end

function private.OnClickSheet(button, row, index)
end

--Processor function
--this handles any notifications that SearchUI core needs to send us
function lib.Processor(msg, ...)
	if msg == "config" then --saved search has changed, so reload the ignorelist
		ignorelist = get("ignoreitemprice.ignorelist")
		if not ignorelist then
			ignorelist = {}
		end
		empty(private.sheetdata)
		for item, cost in pairs(ignorelist) do
			local link = AucAdvanced.API.GetLinkFromSig(item)
			if not link then
				link = item
			end
			table.insert(private.sheetdata, {link, cost})
		end
		if private.ignorelistGUI and private.ignorelistGUI.sheet then
			private.ignorelistGUI.sheet:SetData(private.sheetdata)
		end
	end
end

--lib.AddIgnore(sig, price, temp)
--this function adds an item to the ignorelist at copper price
--if temp is true then item will be added to the temp list, which doesn't last across sessions
--this setting will override any current setting for that item
--if price==nil, item will be removed from the list
function lib.AddIgnore(sig, price, temp)
	if temp then
		private.tempignorelist[sig] = price
	else
		ignorelist[sig] = price
		set("ignoreitemprice.ignorelist", ignorelist)
		AucSearchUI.CleanTable(private.sheetdata)
		for item, cost in pairs(ignorelist) do
			local link = AucAdvanced.API.GetLinkFromSig(item)
			if not link then
				link = item
			end
			table.insert(private.sheetdata, {link, cost})
		end
		if private.ignorelistGUI and private.ignorelistGUI.sheet then
			private.ignorelistGUI.sheet:SetData(private.sheetdata)
		end
	end
end

--private.remove()
--removes the selected item from the ignore list
function private.remove()
	local link = private.ignorelistGUI.sheet:GetSelection()[1]
	if link then
		if string.find(link, "item:") then
			local sig = AucAdvanced.API.GetSigFromLink(link)
			if sig then
				lib.AddIgnore(sig) --second var is nil, removes item from list
			end
		else
			lib.AddIgnore(link)
		end
	end
end

-- This function is automatically called when we need to create our search parameters
function lib:MakeGuiConfig(gui)
	local ScrollSheet = LibStub("ScrollSheet")

	-- Get our tab and populate it with our controls
	local id = gui:AddTab(lib.tabname, "Filters")
	gui:MakeScrollable(id)

	-- Add the help
	gui:AddSearcher("Item Price", "Filter specific items by their price", 600)
	gui:AddHelp(id, "itemprice filter",
		"What does this filter do?",
		"This filter provides the ability to exclude specific items that exceed a certain \"ignore\" price. You can selectively apply this filter to specific searches.")

	gui:AddControl(id, "Header",     0,      "ItemPrice Filter Criteria")

	gui:AddControl(id, "Checkbox",    0, 1,  "ignoreitemprice.enable", "Enable ItemPrice filtering")
	gui:AddControl(id, "Subhead",     0, "Filter for:")
	for name, searcher in pairs(AucSearchUI.Searchers) do
		if searcher and searcher.Search then
			gui:AddControl(id, "Checkbox", 0, 1, "ignoreitemprice.filter."..name, name)
			gui:AddTip(id, "Filter ItemPrice (Ignorelist) when searching with "..name)
			default("ignoreitemprice.filter."..name, true)
		end
	end

	function private.UpdateControls()
		if private.ignorelistGUI.sheet.selected then
			private.removebutton:Enable()
		else
			private.removebutton:Disable()
		end
	end

	private.ignorelistGUI = CreateFrame("Frame", nil, gui.tabs[id][3])
	private.ignorelistGUI:SetPoint("BOTTOMRIGHT", gui.tabs[id][3], "TOPRIGHT", -50, -200)
	private.ignorelistGUI:SetPoint("TOPLEFT", gui.tabs[id][3], "TOPRIGHT", -350, -20)
	private.ignorelistGUI:SetBackdrop({
		bgFile = "Interface/Tooltips/ChatBubble-Background",
		edgeFile = "Interface/Tooltips/ChatBubble-BackDrop",
		tile = true, tileSize = 32, edgeSize = 32,
		insets = { left = 32, right = 32, top = 32, bottom = 32 }
	})
	private.ignorelistGUI:SetBackdropColor(0, 0, 0, 1)

	private.ignorelistGUI.sheet = ScrollSheet:Create(private.ignorelistGUI, {
		{ "Item", "TOOLTIP", 170},
		{ "Ignore Price", "COIN", 90},
	}, private.OnEnterSheet, private.OnLeaveSheet, private.OnClickSheet, nil, private.UpdateControls)
	private.ignorelistGUI.sheet:EnableSelect(true)
	private.ignorelistGUI.sheet:SetData(private.sheetdata)

	private.removebutton = CreateFrame("Button", nil, gui.tabs[id][3], "OptionsButtonTemplate")
	private.removebutton:SetPoint("TOPRIGHT", private.ignorelistGUI, "TOPLEFT", -10, -20)
	private.removebutton:SetText("Remove Selected")
	private.removebutton:SetWidth(150)
	private.removebutton:SetScript("OnClick", private.remove)
	private.removebutton:Disable()

	local selected
end

--lib.Filter(item, searcher)
--This function will return true if the item is to be filtered
--Item is the itemtable, and searcher is the name of the searcher being called. If searcher is not given, it will assume you want it active.
--This function only checks if the min bid needed would be above the ignore amount, because this filter prevents the searchers from looking at the item in the first place.
--lib.PostFilter will be run after the searcher is done, to verify that the price found isn't above ignore value.
function lib.Filter(item, searcher)
	if (not get("ignoreitemprice.enable"))
			or (searcher and (not get("ignoreitemprice.filter."..searcher))) then
		return
	end
	if not item[Const.PRICE] then DevTools_Dump(item) end
	local price = item[Const.PRICE]
	local count = item[Const.COUNT] or 1
	price = math.floor(price/count)

	local sig = AucAdvanced.API.GetSigFromLink(item[Const.LINK])
	if ignorelist[sig] then
		if price >= ignorelist[sig] then
			return true, "Item ignored at "..AucAdvanced.Coins(ignorelist[sig], true)
		end
	end
	if private.tempignorelist[sig] then
		if price >= private.tempignorelist[sig] then
			return true, "Item ignored for session at "..AucAdvanced.Coins(private.tempignorelist[sig], true)
		end
	end
end

--lib.PostFilter(item, searcher, buyorbid)
--Similar to lib.Filter, but should get called after the searcher, and gets passed the searcher's buyorbid return
function lib.PostFilter(item, searcher, buyorbid)
	if (not get("ignoreitemprice.enable"))
			or (searcher and (not get("ignoreitemprice.filter."..searcher))) then
		return
	end
	local price
	if buyorbid and buyorbid == "bid" then
		price = item[Const.PRICE]
	else
		price = item[Const.BUYOUT]
	end
	local count = item[Const.COUNT] or 1
	price = math.floor(price/count)

	local sig = AucAdvanced.API.GetSigFromLink(item[Const.LINK])
	if ignorelist[sig] then
		if price >= ignorelist[sig] then
			return true, "Item ignored at "..AucAdvanced.Coins(ignorelist[sig], true)
		end
	end
	if private.tempignorelist[sig] then
		if price >= private.tempignorelist[sig] then
			return true, "Item ignored for session at "..AucAdvanced.Coins(private.tempignorelist[sig], true)
		end
	end
end

AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Auc-Util-SearchUI/FilterItemPrice.lua $", "$Rev: 4432 $")
