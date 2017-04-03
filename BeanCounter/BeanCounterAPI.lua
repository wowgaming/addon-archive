--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: BeanCounterAPI.lua 4678 2010-02-27 00:53:37Z Nechckn $

	BeanCounterAPI - Functions for other addons to get BeanCounter Data
	URL: http://auctioneeraddon.com/

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
		since that is it's designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat
]]
LibStub("LibRevision"):Set("$URL: http://svn.norganna.org/auctioneer/branches/5.8/BeanCounter/BeanCounterAPI.lua $","$Rev: 4678 $","5.1.DEV.", 'auctioneer', 'libs')

local lib = BeanCounter
lib.API = {}
local private, print, get, set, _BC = lib.getLocals()

--[[Use lib.API.isLoaded to check if beancounter is ready for use. It is false until DB is ready and all gui and API elements have been created]]

local type,select,strsplit,strjoin,ipairs,pairs = type,select,strsplit,strjoin,ipairs,pairs
local tostring,tonumber,strlower = tostring,tonumber,strlower
local tinsert,tremove,sort = tinsert,tremove,sort
local wipe = wipe
local time = time

local GetRealmName = GetRealmName
-- GLOBALS: BeanCounter, BeanCounterDB


local function debugPrint(...)
    if get("util.beancounter.debugAPI") then
        private.debugPrint("BeanCounterAPI",...)
    end
end
--[[External Search Stub, allows other addons searches to search to display in BC or get results of a BC search
Can be item Name or Link or itemID
If itemID or Link search will be faster than a plain text lookup
]]
local _
function lib.API.search(name, settings, queryReturn)
	if get("util.beancounter.externalSearch") then --is option enabled and have we already searched for this name (stop spam)
		--check for blank search request
		if name == "" and not queryReturn then return end
		name = tostring(name)
		
		--serverName is used as part of our cache ID string
		local serverName
		if settings and settings.servers and settings.servers[1] then
			serverName = settings.servers[1]
		else
			serverName = GetRealmName()
		end
		
		--playerName is also used as part of our cache ID string
		local playerName
		if settings and settings.selectbox and settings.selectbox[2] then
			playerName = settings.selectbox[2]
		else
			playerName = "server"
		end

		--the function getItemInfo will return a plain text name on itemID or itemLink searches and nil if a plain text search is passed
		local itemID, itemLink, itemName		
		itemID, itemLink = private.getItemInfo(name, "itemid")
		if not itemLink then 
			itemName = name
		else
			_, itemName =  lib.API.getItemString(itemLink)
		end
		
		local cached = private.checkSearchCache(itemName, serverName, playerName)
		--return cached search
		if queryReturn and cached then
			return cached
		end
		--if API query lacks a settings table use whatever filter options the player has currently selected
		if not settings then
			settings = private.getCheckboxSettings()
		end
	
		--search data
		if itemLink then
			--itemKey is used to filter results if exact is used. We need the key to remove of the XXX style items from returns
			_, settings.suffix = lib.API.decodeLink(itemLink)
			if settings.suffix == 0 then settings.suffix = nil end
			--cache search request
			private.searchByItemID(itemID, settings, queryReturn, nil, nil, itemName)
		else
			private.startSearch(itemName, settings, queryReturn)
		end
		--return data or displayItemName in select box
		if queryReturn then
			return private.checkSearchCache(itemName, serverName, playerName)
		else
			private.frame.searchBox:SetText(itemName)
		end
	end
end




-- Cache system for searches
local cache = setmetatable({}, {__mode="v"})

function private.checkSearchCache(name, serverName, playerName)
	if not name or not serverName or not playerName then return end --nil safe the cache check
	return cache[strlower(name)..serverName..playerName]
end

function private.addSearchCache(name, data, serverName, playerName)
	if not name or not serverName or not playerName then return end --nil safe the cache add
	cache[strlower(name)..serverName..playerName] = data
end

function private.wipeSearchCache()
	wipe(cache)
end


--[[ Returns the Sum of all AH sold vs AH buys along with the date range
If no player name is supplied then the entire server profit will be totaled
if no item name is provided then all items will be returned
if no date range is supplied then a sufficently large range to cover the entire BeanCounter History will be used.
The meta data option mean s we will add in the estimated value from an items discenchant.
This really only works when looking ONLY at the bid/buy datasets. When looking at sales as well you will end up with higher than expected profits
]]
local function addDEValue(meta)
	local mat, count, value = meta:match("DE:(%d-):(%d-):(%d-)|")
	if mat and count and value then
		return value*count
	end
	return 0
end
function lib.API.getAHProfit(player, item, lowDate, highDate, includeMeta)
	if not player or player == "" then player = "server" end
	if not item then item = "" end
	
	local sum, low, high, date = 0, 9999999999, 0
	local settings = {["selectbox"] = {"1", player} , ["bid"] = true, ["auction"] = true, ["failedauction"] = true}
	local tbl
	--allow a already API searched data table to be passed instead of just a text string
	if type(item) == "string" then
		tbl = private.startSearch(item, settings, true)
	elseif type(item) == "table" then
		tbl = item
	end
	if not tbl then return end
		
	for i,v in pairs(tbl) do
		date = tonumber(v[12])
		--if user passes a low and high date to use, filter out any not in the range
		local dateRange = true
		if date and lowDate and highDate then--if we have high/low then set range to false 
			dateRange = false
			if lowDate < date and date < highDate then --set back to true if we meet conditions
				dateRange = true
			end
		end
		
		if dateRange then
			--store lower and upper date ranges
			if date and date < low then low = date end
			if date and date > high then high = date end
			--Sum the trxns	
			if v[2] == _BC('UiAucSuccessful') then
				sum = sum + v[5] - v[9] --sum sale - deposit. fee's have already been subtracted
			elseif v[2] == _BC('UiAucExpired') then
				sum = sum - v[9] --subtract failed deposits
			elseif v[2] == _BC('UiWononBid') then
				sum = sum - v[3] --subtract bought items
				if includeMeta then
					sum = sum + addDEValue(v[14]) --meta data is the exact mats/count/and market value at time of de
				end
			elseif v[2] == _BC('UiWononBuyout') then
				sum = sum - v[4]
				if includeMeta then
					sum = sum + addDEValue(v[14])
				end
			end
		end
	end
	return sum, lowDate or low, highDate or high
end

--[[This will return profits in date segments  allow easy to create graphs
Similar to API.getProfit()  This utility return a table containing the profit earned in day based segments. useful for graphing a change over time
example: entering (player, "arcane dust", 7) would return the the profit for arcane dust in 7 day segments starting from most recent to oldest
]]
function lib.API.getAHProfitGraph(player, item ,days)
	if not player or player == "" then player = "server" end
	if not item then item = "" end
	if not days then days = 7 end
	--Get data from BeanCounter
	local settings = {["selectbox"] = {"1", player} , ["bid"] =true, ["auction"] = true}
	local tbl = private.startSearch(item, settings, "none")
	--Merge and edit provided table to needed format
	for i,v in pairs(tbl) do
		for a,b in pairs(v) do
			tinsert(tbl, b)
		end
	end
	--remove now redundant table entries
	tbl.completedAuctions, tbl["completedBidsBuyouts"], tbl.failedAuctions, tbl.failedBids = nil, nil, nil, nil
	--check if we actually have any results from the search
	if #tbl == 0 then return {0}, 0, 0 end
	--sort by date
	sort(tbl, function(a,b) return a[5] > b[5] end)
	--get min and max dates.
	local high, low, count, sum, number = tbl[1][5], tbl[#tbl][5], 1, 0, 0
	local range = high - (days* 86400)

	tbl.sums = {}
	tbl.sums[count] = {}
	for i,v in ipairs(tbl) do
		if tonumber(v[5]) >= range then
			if v[4] == "Auction successful" then
				number = tonumber(v[3]:match(".-;.-;.-;.-;.-;(.-);.*")) or 0
				sum = sum + number
			elseif v[4] == "Auction won" then
				number = tonumber(v[3]:match(".-;.-;.-;.-;.-;.-;(.-);.*")) or 0
				sum = sum - number
			end
			tbl.sums[count] = sum
		else
			count = count + 1
			range = range - (days * 86400)
			tbl.sums[count] = {}
			sum = 0
			if v[4] == "Auction successful" then
				number = tonumber(v[3]:match(".-;.-;.-;.-;.-;(.-);.*")) or 0
				sum = sum + number
			elseif v[4] == "Auction won" then
				number = tonumber(v[3]:match(".-;.-;.-;.-;.-;.-;(.-);.*")) or 0
				sum = sum - number
			end
			tbl.sums[count] = sum
		end
	end
	return tbl.sums, low, high
end

--[[
Get  Sold / Failed Ratio
Used by match beancounter, made into an API  to allow other addons easier access to this data
This returns the Sold/Failed number of auctions and Sold/Failed  number of items
Adds ability to use  serverKey  ==  realm.."-"..faction
]]
function lib.API.getAHSoldFailed(player, link, days, serverKey)
	if not link or not player then return end
	--check for server key or use home
	local server
	if serverKey then
		server = lib.API.SplitServerKey(serverKey)
	else
		server = private.realmName
	end
	
	if not BeanCounterDB[server] or not BeanCounterDB[server][player] then return end
	local playerData = BeanCounterDB[server][player] --alias
	
	local itemID = lib.API.decodeLink(link)
	if not itemID then return end
		
	local now = time()
	local success, failed, sucessStack, failedStack = 0, 0, 0, 0
	--if we want to filter to a date range then we use this, if we want EVERY trxn uses second lookup
	--the second lookup is mesurably  faster but not noticable in real use due to not having to expand the DB. 100 trxns may have a  0.0001 sec diffrence
	if days then
		days = days * 86400 --days to seconds
		if playerData["completedAuctions"][itemID] then
			for key in pairs(playerData["completedAuctions"][itemID] ) do
				for i, text in pairs(playerData["completedAuctions"][itemID][key]) do
					local stack, _, _, _, _, _, _, auctime = strsplit(";", text)
					auctime, stack = tonumber(auctime), tonumber(stack)
					
					if (now - auctime) < (days) then
						success = success + 1
						sucessStack = sucessStack + stack
					end
				end
			end
		end
		if playerData["failedAuctions"][itemID] then
			for key in pairs(playerData["failedAuctions"][itemID]) do
				for i, text in pairs(playerData["failedAuctions"][itemID][key]) do
					local stack, _, _, _, _, _, _, auctime = strsplit(";", text)
					auctime, stack = tonumber(auctime), tonumber(stack)
					
					if (now - auctime) < (days) then
						failed = failed + 1
						failedStack = failedStack + stack
					end
				end
			end
		end
	else
		if private.playerData then
			if playerData["completedAuctions"][itemID]  then
				for key in pairs(playerData["completedAuctions"][itemID] ) do
					success = success + #playerData["completedAuctions"][itemID][key]
				end
			end
			if playerData["failedAuctions"][itemID] then
				for key in pairs(playerData["failedAuctions"][itemID]) do
					failed = failed + #playerData["failedAuctions"][itemID][key]
				end
			end
		end
	end
	
	return success, failed, sucessStack, failedStack
end
--[[Change or add a reason code to a transaction]]
function  lib.API.updatedReason(serverKey, newReason, itemLink, bid, buy, net, stack, sellerName, deposit, fee, currentReason, Time)
	--to string all number values for comparison to stored data
	bid, buy, net, stack, deposit, fee, Time = tostring(bid), tostring(buy), tostring(net), tostring(stack), tostring(deposit), tostring(fee), tostring(Time)
	--convert ... back to 0
	if currentReason == "..." then currentReason = "0" end
	if sellerName == "..." then sellerName = "0" end
	--if no serverKey provided use current server
	local server =  lib.API.SplitServerKey(serverKey) or private.realmName
	local itemString = lib.API.getItemString(itemLink)
	local itemID, suffix = lib.API.decodeLink(itemLink)
	
	for  player, playerData in pairs(BeanCounterDB[server]) do
		for DB, data in pairs(playerData) do
			if  DB == "failedBids" or DB == "failedAuctions" or DB == "completedAuctions" or DB == "completedBidsBuyouts" or DB == "failedBidsNeutral" or DB == "failedAuctionsNeutral" or DB == "completedAuctionsNeutral" or DB == "completedBidsBuyoutsNeutral" then
				if data[itemID] and data[itemID][itemString] then
					for i, text in pairs(data[itemID][itemString]) do
						local STACK, NET, DEPOSIT , FEE, BUY , BID, SELLERNAME, TIME, CURRENTREASON, LOCATION = private.unpackString(text)
						if currentReason == CURRENTREASON and stack == STACK and sellerName == SELLERNAME and bid == BID and buy == BUY and net == NET and deposit == DEPOSIT and Time == TIME then
							local newText = private.packString(STACK, NET, DEPOSIT , FEE, BUY , BID, SELLERNAME, TIME, newReason, LOCATION)
					
							table.remove(data[itemID][itemString], i)
							private.databaseAdd(DB, nil, itemString, newText)
							private.wipeSearchCache() --clear cached searches
							return
						end
					end
				end
			end
		end
	end
end


--**********************************************************************************************************************
--ITEMLINK AND STRING API'S USE THESE IN PLACE OF LOCAL :MATCH() CALLS
--[[ Retrives the itemLink from the name array when passed an itemKey
we store itemKeys with a unique ID but our name array does not
]]
function lib.API.getArrayItemLink(itemString)
	local itemID, suffix, uniqueID = lib.API.decodeLink(itemString)
	local itemKey = itemID..":"..suffix
	if BeanCounterDB.ItemIDArray[itemKey] then
		return lib.API.createItemLinkFromArray(itemKey, uniqueID) --uniqueID is used as a scaling factor for "of the" suffix items
	end
	debugPrint("Searching DB for ItemID..", suffix, itemID, "Failed Item does not exist")
	return
end

--[[Converts the compressed link stored in the itemIDArray back to a standard blizzard format]]
function lib.API.createItemLinkFromArray(itemKey, uniqueID)
	if BeanCounterDB["ItemIDArray"][itemKey] then
		if not uniqueID then uniqueID = 0 end
		local itemID, suffix = strsplit(":", itemKey)
		local color, name = strsplit(";", BeanCounterDB["ItemIDArray"][itemKey])
		return strjoin("", "|", color, "|Hitem:", itemID,":0:0:0:0:0:", suffix, ":", uniqueID, ":80|h[", name, "]|h|r")
	end
	return
end
--[[Convert and store an itemLink into teh compressed format used in teh itemIDArray]]
function lib.API.storeItemLinkToArray(itemLink)
	if not itemLink then return end
	local color, itemID, suffix, name = itemLink:match("|(.-)|Hitem:(.-):.-:.-:.-:.-:.-:(.-):.+|h%[(.-)%]|h|r")
	
	if color and itemID and suffix and name then
		BeanCounterDB["ItemIDArray"][itemID..":"..suffix] =  color..";"..name
	end
end

--[[Turns an itemLink into an itemString and extracts the itemName
Returns sanitized itemlinks. Since hyperlinks now vary depending on level of player who looks/creates them
]]
function lib.API.getItemString(itemLink)
	if not itemLink or not type(itemLink) == "string" then return end
	local itemString, itemName = itemLink:match("H(item:.-)|h%[(.-)%]")
	if not itemString then return end
	itemString = itemString:gsub("(item:[^:]+:[^:]+:[^:]+:[^:]+:[^:]+:[^:]+:[^:]+:[^:]+):%d+", "%1:80")
	return itemString, itemName
end

--[[Returns id, suffix, uniqueID when passed an itemLink or itemString, this a mildly tweaked version of the one found in AucAdv.
Handles Hitem:string,  item:string, or full itemlinks
]]
local function breakHyperlink(match, matchlen, ...)
	local v
	local n = select("#", ...)
	for i = 1, n do
		v = select(i, ...)
		if (v:sub(1,matchlen) == match) then
			return strsplit(":", v) --for item:0:...  style links bean stores
		elseif(v:sub(2, matchlen+1) == match) then
			return strsplit(":", v:sub(2))  --for Hitem:0:... normal itemStrings and hyperlinks
		end
	end
end
function lib.API.decodeLink(link)
	local vartype = type(link)
	if (vartype == "string") then
		local lType, id, enchant, gem1, gem2, gem3, gemBonus, suffix, uniqueID, lichKing = breakHyperlink("item:", 5, strsplit("|", link))
		if (lType ~= "item") then return end
			return id, suffix, uniqueID
		end
	return
end

--[[Return REASON codes for tooltip or other use
This allows a way to get it that wont break if I change the internal DB layout
Pass a itemlink and stack count
Returns :  "Reason, time of purchase, what you payed"  or nil
NOTE: Reason could possibly be "", decided to return data anyways, calling module can decide if it want to use data or not
]]
function lib.API.getBidReason(itemLink, quantity)
	if not itemLink or not quantity then return end

	local itemString = lib.API.getItemString(itemLink)
	local itemID, suffix = lib.API.decodeLink(itemLink)

	if private.playerData["completedBidsBuyouts"][itemID] and private.playerData["completedBidsBuyouts"][itemID][itemString] then
		for i,v in pairs(private.playerData["completedBidsBuyouts"][itemID][itemString]) do
			local quan, _, _ , _, _, bid, _, Time, reason = private.unpackString(v)
			if tonumber(quan) == tonumber(quantity) and reason and Time then
				return reason, Time, tonumber(bid)
			end
		end
	end
	--not found on the current player lets see if we bought it on another player
	for player in pairs(private.serverData) do
		if private.serverData[player]["completedBidsBuyouts"][itemID] and private.serverData[player]["completedBidsBuyouts"][itemID][itemString] then
			for i,v in pairs(private.serverData[player]["completedBidsBuyouts"][itemID][itemString]) do
				local quan, _, _ , _, _, bid, _, Time, reason = private.unpackString(v)
				if tonumber(quan) == tonumber(quantity) and reason and Time then
					return reason, Time, tonumber(bid), player
				end
			end
		end
	end
	
	return --if nothing found return nil
end
--[[Any itemlink passed into this function will be prompted to remove from the database]]
function lib.API.deleteItem(itemLink)
	if itemLink and itemLink:match("^(|c%x+|H.+|h%[.+%])") then
		private.deletePromptFrame.item:SetText(itemLink)
		private.deletePromptFrame:Show()
	else
		print("Invalid itemLink")
	end
end

--[[Duplicate of the function in auctioneer,  Splits and caches serverKey variable
 realm, faction, localizedFaction = lib.API.SplitServerKey(serverKey)   ]]
local splitcache = {}
local localizedfactions = {
["Alliance"] = FACTION_ALLIANCE,
["Horde"] = FACTION_HORDE,
["Neutral"] = COMBATLOG_FILTER_STRING_NEUTRAL_UNITS, -- if this is not the right context in other locales, may need to create our own localizer entry
}
function lib.API.SplitServerKey(serverKey)
	if not serverKey then return end
	local split = splitcache[serverKey]
	if not split then
		local realm, faction = strmatch(serverKey, "^(.+)%-(%u%l+)$")
		local transfaction = localizedfactions[faction]
		if not transfaction then return end
		split = {realm, faction, realm.." - "..transfaction}
		splitcache[serverKey] = split
	end
	return split[1], split[2], split[3]
end




--[[===========================================================================
--|| Deprecation Alert Functions
--||=========================================================================]]
-- GLOBALS: debugstack, geterrorhandler
 --Ths function was created by Shirik all thanks and blame go to him :P
do
	local SOURCE_PATTERN = "([^\\/:]+:%d+): in function ([^\"']+)[\"']";
	local seenCalls = {};
	local uid = 0;
	-------------------------------------------------------------------------------
	-- Shows a deprecation alert. Indicates that a deprecated function has
	-- been called and provides a stack trace that can be used to help
	-- find the culprit.
	-- @param replacementName (Optional) The displayable name of the replacement function
	-- @param comments (Optional) Any extra text to display
	-------------------------------------------------------------------------------
	function lib.ShowDeprecationAlert(replacementName, comments)
		local caller, source, functionName =
		debugstack(3):match(SOURCE_PATTERN),        -- Keep in mind this will be truncated to only the first in the tuple
		debugstack(2):match(SOURCE_PATTERN);        -- This will give us both the source and the function name

		caller, source, functionName = caller or "Unknown.lua:000", source or "Unknown.lua:000", functionName or "Unknown" --Stop nil errors if data is missing
		functionName = functionName .. "()";

		-- Check for this source & caller combination
		seenCalls[source] = seenCalls[source] or {};
		if not seenCalls[source][caller] then
			-- Not warned yet, so warn them!
			seenCalls[source][caller]=true
			-- Display it
			debugPrint(
			"Auctioneer: "..
			functionName .. " has been deprecated and was called by |cFF9999FF"..caller:match("^(.+)%.[lLxX][uUmM][aAlL]:").."|r. "..
				(replacementName and ("Please use "..replacementName.." instead. ") or "")..
				(comments or "")
				);
				geterrorhandler()(
				"Deprecated function call occurred in BeanCounter API:\n     {{{Deprecated Function:}}} "..functionName..
				"\n     {{{Source Module:}}} "..source:match("^(.+)%.[lLxX][uUmM][aAlL]:")..
				"\n     {{{Calling Module:}}} "..caller:match("^(.+)%.[lLxX][uUmM][aAlL]:")..
				"\n     {{{Available Replacement:}}} "..replacementName..
				(comments and "\n\n"..comments or "")
				)
		end

	end

end
