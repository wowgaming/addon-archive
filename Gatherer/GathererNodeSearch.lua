--[[
	Gatherer Addon for World of Warcraft(tm).
	Version: 3.1.14 (<%codename%>)
	Revision: $Id: GathererNodeSearch.lua 854 2009-04-16 06:13:47Z Esamynn $

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
		since that is it's designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat

	Node density and zone availability search UI
--]]


Gatherer_RegisterRevision("$URL: http://svn.norganna.org/gatherer/release/Gatherer/GathererNodeSearch.lua $", "$Rev: 854 $")

Gatherer.NodeSearch = {}
local lib = Gatherer.NodeSearch
local private = {}

lib.private = private

private.frame = CreateFrame("Frame", nil, UIParent)
local frame = private.frame

frame:SetBackdrop({
        bgFile = "Interface/Tooltips/ChatBubble-Background",
        edgeFile = "Interface/Tooltips/ChatBubble-BackDrop",
        tile = true, tileSize = 32, edgeSize = 32,
        insets = { left = 32, right = 32, top = 32, bottom = 32 }
})
frame:SetBackdropColor(0,0,0, 1)

frame:SetPoint("CENTER", UIParent, "CENTER")
frame:SetWidth(450)
frame:SetHeight(450)

frame:SetMovable(true)
frame:EnableMouse(true)
frame:Hide()

frame.Drag = CreateFrame("Button", nil, frame)
frame.Drag:SetPoint("TOPLEFT", frame, "TOPLEFT", 10,-5)
frame.Drag:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -10,-5)
frame.Drag:SetHeight(6)
frame.Drag:SetHighlightTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar")

frame.Drag:SetScript("OnMouseDown", function() frame:StartMoving() end)
frame.Drag:SetScript("OnMouseUp", function() frame:StopMovingOrSizing() end)

frame.DragBottom = CreateFrame("Button",nil, frame)
frame.DragBottom:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 10,5)
frame.DragBottom:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -10,5)
frame.DragBottom:SetHeight(6)
frame.DragBottom:SetHighlightTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar")

frame.DragBottom:SetScript("OnMouseDown", function() frame:StartMoving() end)
frame.DragBottom:SetScript("OnMouseUp", function() frame:StopMovingOrSizing() end)

--Hide frame
frame.Done = CreateFrame("Button", nil, frame, "OptionsButtonTemplate")
frame.Done:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -10, 10)
frame.Done:SetScript("OnClick", function() frame:Hide() end)
frame.Done:SetText("Done")

--Display Gathereables Report
frame.GatherablesReport = CreateFrame("Button", nil, frame, "OptionsButtonTemplate")
frame.GatherablesReport:SetWidth(150)
frame.GatherablesReport:SetPoint("BOTTOM", frame, "BOTTOM", -142, 10)
frame.GatherablesReport:SetScript("OnClick", function() frame:Hide() GathererReportFrame:Show() end)
frame.GatherablesReport:SetText("Gatherables Report")

--Display Configuration
frame.Config = CreateFrame("Button", "", frame, "OptionsButtonTemplate")
frame.Config:SetPoint("BOTTOM", frame, "BOTTOM", -20, 10)
frame.Config:SetScript("OnClick", function() frame:Hide() Gatherer.Config.ShowOptions() end)
frame.Config:SetText("Config")

--Add Title to the Top
frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
frame.title:SetPoint("CENTER", frame, "TOP", 0, -20)
frame.title:SetText("Node Density Report")

local SelectBox = LibStub:GetLibrary("SelectBox")
local ScrollSheet = LibStub:GetLibrary("ScrollSheet")

--Search box
frame.searchBox = CreateFrame("EditBox", nil, frame, "InputBoxTemplate")
frame.searchBox:SetPoint("TOPLEFT", frame, "TOPLEFT", 20, -60)
frame.searchBox:SetAutoFocus(false)
frame.searchBox:SetHeight(15)
frame.searchBox:SetWidth(150)
frame.searchBox:SetScript("OnEnterPressed", function() private.startSearch(_, _, frame.searchBox:GetText() ) end)

--Search Button
frame.searchButton = CreateFrame("Button", nil, frame, "OptionsButtonTemplate")
frame.searchButton:SetPoint("TOPLEFT", frame.searchBox, "BOTTOMLEFT", -6, -1)
frame.searchButton:SetText("Search")
frame.searchButton:SetScript("OnClick", function() private.startSearch(_, _, frame.searchBox:GetText() ) end)

--Select Box, used to choose which Continent Stats come from
frame.SelectBoxSetting = {"all", "all"}
function private.ChangeControls(obj, arg1,arg2,...)
	frame.SelectBoxSetting = {arg1, arg2}
end

-- Use a callback to generate the list of continents, so that the call
-- to GetMapContinents is deferred until it is defined. Also establish
-- the maximum continent index here
local continents
local maxCont
local function vals()
	if not continents then
		continents = {GetMapContinents()}
		maxCont = table.maxn(continents)
	end
	local items = {
		{"all", "All"},
	}
	for n, text in ipairs(continents) do
		table.insert(items, {n, text})
	end
	return items
end

frame.selectbox = CreateFrame("Frame", "GathererNodeSearchBox", frame)
frame.selectbox.box = SelectBox:Create("GathererNodeSearchBox", frame.selectbox, 120, private.ChangeControls, vals, "default")
frame.selectbox.box:SetPoint("TOPLEFT", frame, "TOPLEFT", 180,-56)
frame.selectbox.box.element = "selectBox"
frame.selectbox.box:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
frame.selectbox.box:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 0,-90)
frame.selectbox.box:SetText("All")

--Create Scrollframe
frame.resultlist = CreateFrame("Frame", nil, frame)
frame.resultlist:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        tile = true, tileSize = 32, edgeSize = 16,
        insets = { left = 5, right = 5, top = 5, bottom = 5 }
})

frame.resultlist:SetBackdropColor(1, 0, 0, 0.5)
frame.resultlist:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 5, 350)
frame.resultlist:SetPoint("TOPRIGHT", frame, "BOTTOMRIGHT", -5, 0)
frame.resultlist:SetPoint("BOTTOM", frame, "BOTTOM",0, 38)

--local print = BeanCounter.Print
function private.onEnter(...)
--print(...)
end
function private.onLeave(...)
--print(...)
end
function private.onMouseover(...)
--print(...)
end
function private.onClick(...)
--print(...)
end
function private.onResize(...)
--print(...)
end
function private.onSelect(...)
--print(...)
end

frame.resultlist.sheet = ScrollSheet:Create(frame.resultlist, {
		{ "Location", "TEXT",  123},
		{ "Type", "TEXT",  137},
		{ "# Nodes", "NUMBER",  67},
		{ "Percent", "NUMBER",  67},


	},private.onEnter, private.onLeave, private.onClick, private.onResize, private.onSelect)

--[[GLOBAL Zone Name == Gatherer.ZoneTokens.GetZoneToken(continent, zone)
--NODE Name to ID table    Gatherer.Nodes.Names
--Actual Localized Zone Names  Gatherer.Util.ZoneNames[continent][zone]

--Get node type Gatherer.Nodes.Objects[  id ]

-- Returns the count of nodes for each "Gather Type" in the zone specified
lib.GetNodeCountsByGatherType( continent, zone )

-- Returns information on a specific node
--
-- Return Values:
-- x - the node's x coordinate value
-- y - the node's y coordinate value
-- count - the node's count value
-- gtype - gather type of this node
-- lastHarvested - time at which the node was last harvested
-- lastInspected - time at which the node was last inspected
-- source - the source of this node
--------------------------------------------------------------------------
lib.GetNodeInfo( continent, zone, gatherName, index )

]]
local Data = {}
function private.getZonesWithNodes(start, finish, gatherName)
	--Scan zones and add zones matching the nodes to the table
	for continent = start, finish do
		for _, zone in Gatherer.Storage.GetAreaIndices(continent) do
			if Gatherer.Storage.IsGatherInZone( continent, zone, gatherName ) then
				local nodes = Gatherer.Storage.GetGatherCountsForZone( continent, zone, gatherName )
				local totalAll = Gatherer.Storage.GetNodeCounts( continent, zone )
				local treasures, herbs, ores = Gatherer.Storage.GetNodeCountsByGatherType( continent, zone )
				local type = Gatherer.Nodes.Objects[gatherName]
				table.insert(Data, {["continent"] = continent, ["zone"] = zone, ["gatherName"] = gatherName, ["nodes"] = nodes, ["totalAll"] = totalAll, ["HERB"] = herbs, ["MINE"] = ores, ["OPEN"] = treasures, ["type"] = type})
			end
		end
	end
end

function private.startSearch(start, finish, name)
	--allow user to filter continents searched
	if frame.SelectBoxSetting[2] == "all" then
		if not maxCont then vals() end --Since we do not define maxCont unless select box has been changed
		start, finish = 1, maxCont
	else
		start, finish = frame.SelectBoxSetting[2], frame.SelectBoxSetting[2]
	end
	--find matching node ID's for entered string, send all to be searched
	for text, gatherName in pairs(Gatherer.Nodes.Names) do
		if text:lower():match(name:lower()) then
			private.getZonesWithNodes(start, finish, gatherName)
		end
	end
	--What type of data did the user want returned
	private.nodesByPercent()
end
function private.nodesByPercent()
	--take results of search and prep for sending to scrollframe
	local data = {}
	for i,v in pairs( Data ) do
		local nodes = v.nodes
		local total = v[v.type] -- We store the type as HERB, MINE, OPEN  and can then use it here to refrence Data.HERB Data.OPEN etc..
		local pct =  floor(nodes*100/total + 0.5)

		table.insert(data, {Gatherer.Util.ZoneNames[v.continent][v.zone], Gatherer.Util.GetNodeName(v.gatherName), nodes, pct,} )
	end
	Data = {} --clear data for next round of searches
	frame.resultlist.sheet:SetData(data, style)
end

--[[NOT USED ATM tring to decide how we can group like types for results.
local equivilents = {
	-- Ores
	[324] = 324, -- Small Thorium Vein
	[123848] = 324, -- Ooze Covered Thorium Vein

	[175404] = 175404, -- Rich Thorium Vein
	[177388] = 175404, -- Ooze Covered Rich Thorium Vein

	[1732] = 1732, -- Tin Vein
	[1733] = 1732, -- Silver Vein
	[73940] = 1732, -- Ooze Covered Silver Vein

	[1735] = 1735, -- Iron Deposit
	[1734] = 1735, -- Gold Vein
	[73941] = 1735, -- Ooze Covered Gold Vein

	[2040] = 2040, -- Mithril Deposit
	[2047] = 2047, -- Truesilver Deposit
	[123309] = 123309, -- Ooze Covered Truesilver Deposit
	[123310] = 123310, -- Ooze Covered Mithril Deposit

	[165658] = 165658, -- Dark Iron Deposit


	[181556] = 181556, -- Adamantite Deposit
	[181569] =  181556, -- Rich Adamantite Deposit

	[181557] = 181557, -- Khorium Vein
}
]]