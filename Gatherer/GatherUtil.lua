--[[
	Gatherer Addon for World of Warcraft(tm).
	Version: 3.1.14 (<%codename%>)
	Revision: $Id: GatherUtil.lua 783 2008-12-05 08:13:41Z Esamynn $

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

	Utility functions
]]
Gatherer_RegisterRevision("$URL: http://svn.norganna.org/gatherer/release/Gatherer/GatherUtil.lua $", "$Rev: 783 $")

-- reference to the Astrolabe mapping library
local Astrolabe = DongleStub(Gatherer.AstrolabeVersion)

function Gatherer.Util.Round(x)
	return math.ceil(x - 0.5);
end

function Gatherer.Util.BreakLink(link)
	--DEFAULT_CHAT_FRAME:AddMessage("Breaking link: " .. (link or "None"))

	if (type(link) ~= 'string') then return end
--	local item, name = link:match("|H(.-)|h[[]([^]]+)[]]|h")
	local i,j, item, name = string.find(link, "|H(.-)|h[[](.-)[]]|h")
	--DEFAULT_CHAT_FRAME:AddMessage(" found item "..(item or "None")..": " .. (name or "None"))
	local itype, id, enchant, slot1,slot2,slot3,slot4, random, uniq = strsplit(":", item)
	
	--DEFAULT_CHAT_FRAME:AddMessage(" id: "..(id or "None"))
	if (random == nil) then
		random, uniq = slot1, slot2
		slot1, slot2, slot3, slot4 = 0, 0, 0, 0
	end
	return
		tonumber(id) or 0,
		tonumber(enchant) or 0,
		tonumber(random) or 0,
		tonumber(slot1) or 0,
		tonumber(slot2) or 0,
		tonumber(slot3) or 0,
		tonumber(slot4) or 0,
		tonumber(uniq) or 0,
		name, itype
end

--[[
function Gatherer.Util.GetMenuName(inputName, specificType)
	local name, info
	if (inputName) then
		local firstLetter = string.sub(inputName, 1, 2)
		local carReplace = {
			["à"] = "a", ["á"] = "a", ["â"] = "a", ["ä"] = "a", ["ã"] = "a",
			["è"] = "e", ["é"] = "e", ["ê"] = "e", ["ë"] = "e",
			["ì"] = "i", ["í"] = "i", ["î"] = "i", ["ï"] = "i",
			["ò"] = "o", ["ó"] = "o", ["ô"] = "o", ["ö"] = "o", ["õ"] = "o",
			["ù"] = "u", ["ú"] = "u", ["û"] = "u", ["ü"] = "u"
		}

		local found
		for code, repl in pairs(carReplace) do
			firstLetter, found = string.gsub(firstLetter, code, repl)
			if (found > 0) then
				break
			end
		end
		if (found > 0) then
			name = string.upper(firstLetter)..(string.sub(inputName, 3) or "")
		else
			name = string.upper(string.sub(inputName, 1, 1))..(string.sub(inputName, 2) or "")
		end

		if not ( specificType ) then
			specificType = Gatherer_GetDB_IconByGatherName(inputName)
		end
		specificType = specificType or inputName
		for _, rareMatch in pairs(Gatherer_RareMatches) do
			if (specificType == rareMatch) then
				name = name.." ["..TYPE_RARE.."]"
				break
			end
		end
		if (Gather_SkillLevel[specificType]) then
			name = name.." ["..Gather_SkillLevel[specificType].."]"
		end
	end
	return name, info
end
]]

function Gatherer.Util.DumpAll()
	local gatherCont, gatherZone, gatherName, contData, zoneData, nameData, gatherPos, gatherItem

	for _, continent in Gatherer.Storage.GetAreaIndices() do --continents
		for _, zone in Gatherer.Storage.GetAreaIndices(continent) do
			for gatherName, gtype in Gatherer.Storage.ZoneGatherNames(continent, zone) do
				for index, x, y, count in Gatherer.Storage.ZoneGatherNodes(continent, zone, gatherName) do
					Gatherer.Util.Print(gtype.." "..gatherName.." was found in zone "..continent..":"..zone.." at "..x..","..y.."  ("..count.." times)")
				end
			end
		end
	end
end

function Gatherer.Util.ChatPrint(str)
	if ( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage(str, 1.0, 0.5, 0.25)
	end
end

function Gatherer.Util.Print(str, add)
	if ((Gatherer.Var.LastPrited) and (str == Gatherer.Var.LastPrited)) then
		return
	end
	Gatherer.Var.LastPrited = str
	if (add) then
		str = str..": "..add
	end
	if(ChatFrame2) then
		ChatFrame2:AddMessage(str, 1.0, 1.0, 0.0)
	end
end

function Gatherer.Util.Debug(str, ...)
	if not ( type(Gatherer.Util.DebugFrame) == "table" and Gatherer.Util.DebugFrame.AddMessage ) then
		return
	end
	str = str..": "..strjoin(", ", tostringall(...))
	Gatherer.Util.DebugFrame:AddMessage("DEBUG: "..str, 1.0, 1.0, 0.0)
end

--[[
function Gatherer.Util.TitleCase(str)
	if (GetLocale() == "frFR") then return str; end
	
	local function ucaseWord(first, rest)
		return string.upper(first)..string.lower(rest)
	end
	return string.gsub(str, "([a-zA-Z])([a-zA-Z']*)", ucaseWord)
end

function Gatherer.Util.MakeName(frameID)
	local tmpClosest = Gatherer.Var.Closest
	local tmpItemIDtable = { }
	local tmpCount = 1
	if ( Gatherer.Var.Loaded ) then
		local gatherInfo = tmpClosest.items[frameID]

		tmpItemIDtable[tmpCount] = {}
		tmpItemIDtable[tmpCount].name  = Gatherer.Util.GetMenuName(gatherInfo.name)
		tmpItemIDtable[tmpCount].count = gatherInfo.item.count
		tmpItemIDtable[tmpCount].dist  = math.floor(gatherInfo.dist*10000)/10

		tmpCount = tmpCount + 1

		for id in pairs(tmpClosest.items) do
			if (id ~= frameID and
					(abs(gatherInfo.item.x - tmpClosest.items[id].item.x) <= Gatherer.Var.ClosestCheck or
				 Gatherer.Util.Round(gatherInfo.item.x * 10) == Gatherer.Util.Round(tmpClosest.items[id].item.x * 10)) and
				(abs(gatherInfo.item.y - tmpClosest.items[id].item.y) <= Gatherer.Var.ClosestCheck or
				 Gatherer.Util.Round(gatherInfo.item.y * 10) == Gatherer.Util.Round(tmpClosest.items[id].item.y * 10))) then
				tmpItemIDtable[tmpCount] = {}
				tmpItemIDtable[tmpCount].name  = Gatherer.Util.GetMenuName(tmpClosest.items[id].name)
				tmpItemIDtable[tmpCount].count = tmpClosest.items[id].item.count
				tmpItemIDtable[tmpCount].dist  = math.floor(tmpClosest.items[id].dist*10000)/10

				tmpCount = tmpCount + 1
			end
		end
	else
		tmpItemIDtable[1].name = "Unknown"
		tmpItemIDtable[1].count = 0
		tmpItemIDtable[1].dist = 0
	end

	return tmpItemIDtable
end
]]

local checkingSkills = false

function Gatherer.Util.GetSkills()
	if ( checkingSkills ) then return end -- avoid infinate loops
	checkingSkills = true
	local GatherExpandedHeaders = {}
	local i, j
	
	if ( not Gatherer.Var.Skills ) then Gatherer.Var.Skills = {}; end
		
	-- search the skill tree for gathering skills
	for i=0, GetNumSkillLines(), 1 do
		local skillName, header, isExpanded, skillRank = GetSkillLineInfo(i)
	
		-- expand the header if necessary
		if ( header and not isExpanded ) then
			GatherExpandedHeaders[i] = skillName
		end
	end
	
	ExpandSkillHeader(0)
	for i=1, GetNumSkillLines(), 1 do
		local skillName, header, _, skillRank = GetSkillLineInfo(i)
		-- check for the skill name
		if (skillName and not header) then
			if (skillName == Gatherer.Locale.TrClient("TRADE_HERBALISM")) then
				Gatherer.Var.Skills.HERB = skillRank
			elseif (skillName == Gatherer.Locale.TrClient("TRADE_MINING")) then
				Gatherer.Var.Skills.MINE = skillRank
			end
		end
		
		-- once we got both, no need to look the rest
		if ( Gatherer.Var.Skills.HERB and Gatherer.Var.Skills.MINE ) then
			break
		end
	end
	
	-- close headers expanded during search process
	for i=0, GetNumSkillLines() do
		local skillName, header, isExpanded = GetSkillLineInfo(i)
		for j in pairs(GatherExpandedHeaders) do
			if ( header and skillName == GatherExpandedHeaders[j] ) then
				CollapseSkillHeader(i)
				GatherExpandedHeaders[j] = nil
			end
		end
	end
	checkingSkills = false
end

local function GetTrackingMode()
	return Gatherer.Constants.TrackingTextures[GetTrackingTexture()]
end
Gatherer.Util.GetTrackingMode = GetTrackingMode

function Gatherer.Util.IsNodeTracked( nodeId )
	local trackingMode = GetTrackingMode()
	if not ( trackingMode ) then
		return false
	end
	
	local trackType = Gatherer.Nodes.Objects[nodeId]
	
	-- check for a tracking type override
	local category = Gatherer.Categories.ObjectCategories[nodeId]
	trackType = Gatherer.Constants.TrackingOverrides[category] or trackType
	
	return (trackingMode == trackType)
end


local nodeNames = {}
for name, objid in pairs(Gatherer.Nodes.Names) do
	nodeNames[objid] = name
end
function Gatherer.Util.GetNodeName(objectID)
	return Gatherer.Categories.CategoryNames[objectID] or nodeNames[objectID] or ("Unknown: "..objectID)
end

function Gatherer.Util.BuildLoot(coins, ...)
	local loot = {}
	coins = tonumber(coins) or 0
	for i=1, select("#", ...) do
		local lootItem = select(i, ...)
		local itemID, count = strsplit("x", lootItem)
		itemID = tonumber(itemID)
		count = tonumber(count)
		if (itemID and count) then
			table.insert(loot, { id = itemID, count = count })
		end
	end
	return coins, loot
end

function Gatherer.Util.LootSplit(lootString)
	return Gatherer.Util.BuildLoot(strsplit(":", lootString))
end

local parseStrings = {}
local parseStringInfo = {}
local returnCache = {}

local function processMatches( format, ... )
	local parseInfo = parseStringInfo[format]
	for i = 1, select("#", ...) do
		if ( parseInfo[i] ) then
			returnCache[i] = select(parseInfo[i], ...)
		else
			returnCache[i] = ""
		end
	end
	return unpack(returnCache, 1, select("#", ...))
end

local function replaceAllBut( char )
	if ( char ~= "$" and char ~= "%" ) then
		return "%"..char
	end
end

function Gatherer.Util.ParseFormattedMessage(format, message)
	local parser = parseStrings[format]
	if not ( parser ) then
		parser = string.gsub(format, "([%p])", replaceAllBut)
		local parseInfo = {}
		local curPos = 0
		local count = 0
		local function analyzeMatch( index, check, type )
			if ( #index > 1 ) then return end
			index = tonumber(index)
			if ( index ) then
				curPos = index
				if ( check ~= "$" ) then
					return
				end
			else
				curPos = curPos + 1
			end
			local replacement
			if ( type == "s" ) then
				replacement = "(.-)"
			elseif ( type == "d" ) then
				replacement = "(-?%d+)"
			else
				return
			end
			count = count + 1
			parseInfo[curPos] = count
			return replacement
		end
		parser = string.gsub(parser, "%%(%d?)(%$?)([sd])", analyzeMatch)
		parseStringInfo[format] = parseInfo
		parser = string.gsub(parser, "%$", "%%$")
		parser = "^"..parser.."$"
		parseStrings[format] = parser
	end
	return processMatches(format, string.match(message, parser))
end

function Gatherer.Util.GetNodeTexture( nodeID )
	local selectedTexture
	local trimTexture = false
	
	if (Gatherer.Icons[nodeID]) then
		selectedTexture = "Interface\\AddOns\\Gatherer\\Icons\\"..Gatherer.Icons[nodeID]
	end
	
	if not ( selectedTexture ) then
		selectedTexture = GetItemIcon(Gatherer.Nodes.PrimaryItems[nodeID])
		trimTexture = selectedTexture and true or false
	end
	
	if not ( selectedTexture ) then
		local prime, pcount = Gatherer.DropRates.GetPrimaryItem(nodeID)
		if ( prime ) then
			local primaryName, _, _, _, _, _, _, _, _, nodeTexture = GetItemInfo(prime)
			selectedTexture = nodeTexture
			trimTexture = true
		end
	end
	
	-- Check to see if we found the item
	if (not selectedTexture) then
		selectedTexture = "Interface\\AddOns\\Gatherer\\Shaded\\Red"
		trimTexture = false
	end
	
	return selectedTexture, trimTexture
end

Gatherer.Util.ZoneNames = {GetMapContinents()}
for index, cname in pairs(Gatherer.Util.ZoneNames) do
	local zones = {GetMapZones(index)}
	Gatherer.Util.ZoneNames[index] = zones
	for index, name in ipairs(zones) do
		zones[name] = index
	end
	zones[0] = cname
end

function Gatherer.Util.GetPositionInCurrentZone()
	local realZoneText = GetRealZoneText()
	local continent, zone
	local c, z, px, py
	for cont, zones in pairs(Gatherer.Util.ZoneNames) do
		zone = zones[realZoneText]
		if ( zone ) then
			continent = cont
			break
		end
	end
	-- if there is no zone map named for the realZoneText then search by
	-- changing the current map zoom
	if not ( zone ) then
		return Astrolabe:GetCurrentPlayerPosition()
	else
		c, z, px, py = Astrolabe:GetCurrentPlayerPosition()
	end
	if not ( c and z ) then
		return
	end
	-- translate coordiantes to current zone map
	px, py = Astrolabe:TranslateWorldMapPosition(c, z, px, py, continent, zone)
	return continent, zone, px, py
end


function Gatherer.Util.SecondsToTime(seconds, noSeconds)
	local time = ""
	local count = 0
	local GetText = Gatherer.Locale.GetText
	seconds = floor(seconds)
	if ( seconds >= 604800 ) then
		local tempTime = floor(seconds / 604800)
		time = tempTime.." "..GetText("WEEKS_ABBR", tempTime).." "
		seconds = (seconds % 604800)
		count = count + 1
	end
	if ( seconds >= 86400  ) then
		local tempTime = floor(seconds / 86400)
		time = time..tempTime.." "..GetText("DAYS_ABBR", tempTime).." "
		seconds = (seconds % 86400)
		count = count + 1
	end
	if ( count < 2 and seconds >= 3600  ) then
		local tempTime = floor(seconds / 3600)
		time = time..tempTime.." "..GetText("HOURS_ABBR", tempTime).." "
		seconds = (seconds % 3600)
		count = count + 1
	end
	if ( count < 2 and seconds >= 60  ) then
		local tempTime = floor(seconds / 60)
		time = time..tempTime.." "..GetText("MINUTES_ABBR",tempTime).." "
		seconds = (seconds % 60)
		count = count + 1
	end
	if ( count < 2 and seconds > 0 and not noSeconds ) then
		time = time..seconds.." "..GetText("SECONDS_ABBR", seconds).." "
	end
	return time
end


--******************************************************
-- Client Item Cache Refresh System
--******************************************************

local refreshFrame = CreateFrame("Frame")
local tooltip = CreateFrame("GameTooltip")
refreshFrame:Hide()
local itemIdList = {}
local lastItem = nil
local timer = 0


function Gatherer.Util.StartClientItemCacheRefresh()
	if ( Gatherer.DropRates.OldData ) then
		for nodeId, nodeData in pairs(Gatherer.DropRates.OldData) do
			for itemId in pairs(nodeData) do
				if ( type(itemId) == "number" ) then
					itemIdList[itemId] = true
				end
			end
		end
	end
	for cont, contData in ipairs(Gatherer.DropRates.Data) do
		for zone, zoneData in pairs(contData) do
			for nodeId, nodeData in pairs(zoneData) do
				for itemId in pairs(nodeData) do
					if ( type(itemId) == "number" ) then
						itemIdList[itemId] = true
					end
				end
			end
		end
	end
	
	lastItem = nil
	timer = 0
	refreshFrame:Show()
end

refreshFrame:SetScript("OnUpdate",
	function( self, elapsed )
		timer = timer + elapsed
		if ( timer > 5 ) then
			timer = 0
			local itemId = next(itemIdList, lastItem)
			if not ( itemId ) then
				self:Hide()
				return
			end
			
			while ( itemId and GetItemInfo(itemId) ) do
				itemId = next(itemIdList, itemId)
			end
			if not ( itemId ) then
				self:Hide()
				return
			end
			tooltip:SetOwner(refreshFrame, "ANCHOR_NONE")
			tooltip:SetHyperlink("item:"..itemId..":0:0:0:0:0:0:0")
			lastItem = itemId
		end
	end
)
