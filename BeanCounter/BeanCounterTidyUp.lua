--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: BeanCounterTidyUp.lua 4475 2009-09-28 12:15:25Z Mikk $
	URL: http://auctioneeraddon.com/
	
	BeanCounterTidyUp - Database clean up and maintenance functions

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
LibStub("LibRevision"):Set("$URL: http://svn.norganna.org/auctioneer/branches/5.8/BeanCounter/BeanCounterTidyUp.lua $","$Rev: 4475 $","5.1.DEV.", 'auctioneer', 'libs')

local lib = BeanCounter
local private = lib.Private
local private, print, get, set, _BC = lib.getLocals()
local pairs,ipairs,next,select,type = pairs,ipairs,next,select,type
local strsplit = strsplit

local function debugPrint(...)
    if get("util.beancounter.debugTidyUp") then
        private.debugPrint("BeanCounterTidyUp", ...)
    end
end
--Sum all entries for display in window  TODO:Add in check for lua key value limitations
function private.sumDatabase()
	private.DBSumEntry, private.DBSumItems = 0, 0
	for player, v in pairs(private.serverData) do
		for DB, data in pairs(v) do
			if  DB == "failedBids" or DB == "failedAuctions" or DB == "completedAuctions" or DB == "completedBidsBuyouts" or DB == "failedBidsNeutral" or DB == "failedAuctionsNeutral" or DB == "completedAuctionsNeutral" or DB == "completedBidsBuyoutsNeutralNeutral" then
				for itemID, value in pairs(data) do
					for itemString, data in pairs(value) do
						private.DBSumEntry = private.DBSumEntry +1
						for index, text in pairs(data) do
							private.DBSumItems = private.DBSumItems + 1
						end
					end
				end
			end
		end
	end
	private.frame.DBCount:SetText("Items: "..private.DBSumEntry)
	private.frame.DBItems:SetText("Entries: "..private.DBSumItems)
end

--Recreate/refresh ItemIName to ItemID array
function private.refreshItemIDArray(announce)
	for player, v in pairs(private.serverData)do
		for DB,data in pairs(private.serverData[player]) do
			if DB ~= "mailbox" and type(data) == "table" then
				for itemID, value in pairs(data) do
					for itemString, text in pairs(value) do
						local key, suffix = lib.API.decodeLink(itemString)
						if not BeanCounterDB["ItemIDArray"][key..":"..suffix] then
							local _, itemLink = private.getItemInfo(itemString, "itemid")
							if itemLink then
								debugPrint("Added to array, missing value",  itemLink)
								lib.API.storeItemLinkToArray(itemLink)
							end
						end
					end
				end
			end
		end
	end
	if announce then print("Finished refresing ItemName Array") end
end

--[[ --Possible code to use to purge itemID array links that no longer have transactions
]]
local function pruneItemNameArrayHelper(itemID)
	for server, serverData in pairs(BeanCounterDB) do
		if  server ~= "settings" and server ~= "ItemIDArray"  then
			for player, playerData in pairs(serverData) do
				for DB, data in pairs(playerData) do
					if DB ~= "mailbox" and type(data) == "table" then
						if data[itemID] then
							--found a match
							return true
						end
					end
				end
			end
		end
	end
end

function private.pruneItemNameArray()
	local  itemID, key
	for i, link in pairs(BeanCounterDB["ItemIDArray"]) do
		itemID, key = strsplit(":", i)
		if not pruneItemNameArrayHelper(itemID) then
			print("Never seen", itemID, link) 
		end
	end
end

--Moves entries older than 40 days into compressed( non uniqueID) Storage
--Removes data older than X  months from the DB
--Array refresh needs to run before this function
function private.compactDB(announce)
	debugPrint("Compressing database entries older than 40 days")
	for DB,data in pairs(private.playerData) do -- just do current player to make process as fast as possible
		if  DB == "failedBids" or DB == "failedAuctions" or DB == "completedAuctions" or DB == "completedBidsBuyouts" or DB == "failedBidsNeutral" or DB == "failedAuctionsNeutral" or DB == "completedAuctionsNeutral" or DB == "completedBidsBuyoutsNeutralNeutral" then
			for itemID, value in pairs(data) do
				for itemString, index in pairs(value) do
					local _, suffix, uniqueID = lib.API.decodeLink(itemString)
					if uniqueID ~= "0" and string.len(uniqueID) > 8 then --ignore the already compacted keys, compacted keys are uniqueID of 0 or the scaling factor for negative suffix items
						private.removeUniqueID(index, DB, itemString)
					elseif lib.GetSetting("oldDataExpireEnabled") then
						--for non unique strings we know they are already older than the compress date, So check to see if they are old enough to be pruned by the Remove Old transactions option
						local months = lib.GetSetting("monthstokeepdata")
						local expire =  time() - (months * 30 * 24 * 60 * 60)
						private.removeOldData(index, DB, itemString, expire)
					end
					--remove itemStrings that are now empty, all the keys have been moved to compressed format
					if #index == 0 then debugPrint("Removed empty table:", itemString) private.playerData[DB][itemID][itemString] = nil end
				end
			end
		end
	end
	if announce then print("Finished compressing Databases") end
end
function private.removeUniqueID(data, DB, itemString)
	local _, _, _, _, _, _, _, postTime  = private.unpackString(data[1])
	if data[1] and (time() - postTime) >= 3456000 then --we have an old data entry lets process this
		debugPrint("Compressed", "|H"..itemString, data[1] )
		private.databaseAdd(DB, nil, itemString, data[1], true) --store using the compress option set to true
		table.remove(data, 1)
		private.removeUniqueID(data, DB, itemString)
	end
end

function private.removeOldData(data, DB, itemString, expire)
	local _, _, _, _, _, _, _, postTime = private.unpackString(data[1])
	postTime = tonumber(postTime)
	if data[1] and (postTime) <= expire then --we have an old data entry lets process this
		debugPrint("Removed", "|H"..itemString, data[1] , date("%c", postTime), "Older than",  date("%c", keep) )
		table.remove(data, 1)
		private.removeOldData(data, DB, itemString, expire)
	end
end

--Sort all array entries by Date oldest to newest
--Helps make compact more efficent needs to run once per week or so
function private.sortArrayByDate(announce)
	for player, v in pairs(private.serverData)do
		for DB, data in pairs(private.serverData[player]) do
			if  DB == "failedBids" or DB == "failedAuctions" or DB == "completedAuctions" or DB == "completedBidsBuyouts" or DB == "failedBidsNeutral" or DB == "failedAuctionsNeutral" or DB == "completedAuctionsNeutral" or DB == "completedBidsBuyoutsNeutralNeutral" then
				for itemID, value in pairs(data) do
					for itemString, index in pairs(value) do
						table.sort(index,  function(a,b)
							local _, _, _, _, _, _, _, postTimeA = private.unpackString(a)
							local _, _, _, _, _, _, _, postTimeB = private.unpackString(b)
							return postTimeA < postTimeB end)
						private.serverData[player][DB][itemID][itemString] = index
					end
				end
			end
		end
	end
	if announce then print("Finished sorting database") end
end
--Prune Old keys from postedXXXX tables
--First we find a itemID that needs pruning then we check all other keys for that itemID and prune.
function private.prunePostedDB(announce)
	--Used to clean up post DB
	debugPrint("Cleaning posted Databases")
	for DB,data in pairs(private.playerData) do -- just do current player to make process as fast as possible
		if  DB == "postedBids" or DB == "postedAuctions"  then
			for itemID, value in pairs(data) do
				for itemString, index in pairs(value) do
					--While the entrys remain 40 days old remove entry
					local _, _ ,_ ,_ ,_ ,TIME
					if index[1] then 
						_, _ ,_ ,_ ,_ ,TIME = strsplit(";", index[1])
					end
					while index[1] and (time() - TIME) >= 3456000 do
						--debugPrint("Removed Old posted entry", itemString)
						table.remove(index, 1)
						if index[1] then 
							_, _ ,_ ,_ ,_ ,TIME = strsplit(";", index[1])
						end
					end
					-- remove empty itemString tables
					if #index == 0 then
						--debugPrint("Removed empty itemString table", itemID, itemString)
						private.playerData[DB][itemID][itemString] = nil
					end
				end
				--after removing the itemStrings look to see if there are itemID's that need removing
				if next (value) == nil then
					debugPrint("Removed empty itemID:", itemID) 
					private.playerData[DB][itemID] = nil
				end
			end
		end
	end
	if announce then print("Finished pruning Posted Databases") end
end
--deletes all entries matching a itemLink from database for that server
function private.deleteExactItem(itemLink)
	if not itemLink or not itemLink:match("^(|c%x+|H.+|h%[.+%])") then return end
	for player, playerData in pairs(private.serverData) do
		for DB, data in pairs(playerData) do
			if DB ~= "mailbox" and type(data) == "table" then
				for itemID, itemIDData in pairs(data) do
					for itemString, itemStringData in pairs(itemIDData) do
						local  _,_,_,_,_,_, _, suffix, uniqueID = strsplit(":", itemString)
						local linkID, linkSuffix = lib.API.decodeLink(itemLink)
						if linkID == itemID and suffix == linkSuffix then
							debugPrint("matched", itemLink, itemString, linkSuffix, suffix)
							itemIDData[itemString] = nil
						end
					end
				end
			end
		end
	end
end

--[[INTEGRITY CHECKS
Make sure the DB format is correct removing any entries that were missed by updating.
To be run after every DB update
]]--
local integrity = {} --table containing teh DB layout
	integrity["completedBidsBuyouts"] = {"number", "number", "number", "number", "number", "number", "string", "number", "string", "string"}--10
	integrity["completedAuctions"] = {"number", "number", "number", "number", "number", "number", "string", "number", "string", "string"}--10
	integrity["failedBids"] = {"number", "number", "number", "number", "number", "number", "string", "number", "string", "string"}--10
	integrity["failedAuctions"] = {"number", "number", "number", "number", "number", "number", "string", "number", "string", "string"}--10
	integrity["postedBids"] = {"number", "number", "string", "string", "number", "number", "string" } --7
	integrity["postedAuctions"] = {"number", "number", "number", "number", "number" ,"number", "string"} --7
	
	integrity["completedBidsBuyoutsNeutral"] = {"number", "number", "number", "number", "number", "number", "string", "number", "string", "string"}--10
	integrity["completedAuctionsNeutral"] = {"number", "number", "number", "number", "number", "number", "string", "number", "string", "string"}--10
	integrity["failedBidsNeutral"] = {"number", "number", "number", "number", "number", "number", "string", "number", "string", "string"}--10
	integrity["failedAuctionsNeutral"] = {"number", "number", "number", "number", "number", "number", "string", "number", "string", "string"}--10
local integrityClean, integrityCount = true, 1
 function private.integrityCheck(complete, server)
	if not server then server = private.realmName end
	local tbl
	debugPrint(integrityCount)
	for player, v in pairs(BeanCounterDB[server])do
		for DB, data in pairs(v) do
			if  DB == "failedBids" or DB == "failedAuctions" or DB == "completedAuctions" or DB == "completedBidsBuyouts" or DB == "postedBids" or DB == "postedAuctions" or DB == "failedBidsNeutral" or DB == "failedAuctionsNeutral" or DB == "completedAuctionsNeutral" or DB == "completedBidsBuyoutsNeutralNeutral" then
				for itemID, value in pairs(data) do
					for itemString, data in pairs(value) do
						local _, itemStringLength = itemString:gsub(":", ":")
						--check that the data is a string and table
						if type(itemString) ~= "string"  or  type(data) ~= "table" then
							BeanCounterDB[server][player][DB][itemID][itemString] = nil
							debugPrint("Failed: Invalid format", DB, data, "", itemString)
							integrityClean = false
						elseif itemStringLength > 10 then --Bad itemstring purge
							debugPrint("Failed: Invalid itemString", DB, data, "", itemString)
							local _, link = GetItemInfo(itemString) --ask server for a good itemlink
							local itemStringNew = lib.API.getItemString(link) --get NEW itemString from itemlink
							if itemStringNew then
								debugPrint(itemStringNew, "New link recived replacing")
								BeanCounterDB[server][player][DB][itemID][itemStringNew] = data
								BeanCounterDB[server][player][DB][itemID][itemString] = nil
							else
								debugPrint(itemString, "New link falied purging item")
								BeanCounterDB[server][player][DB][itemID][itemString] = nil
							end
							integrityClean = false
						elseif itemStringLength < 9 then
							local itemStringNew = itemString..":80"
							BeanCounterDB[server][player][DB][itemID][itemStringNew] = data
							BeanCounterDB[server][player][DB][itemID][itemString] = nil
							integrityClean = false
						else
							for index, text in pairs(data) do
								tbl = {strsplit(";", text)}
									--check entries for missing data points
								if #integrity[DB] ~= #tbl then
									debugPrint("Failed: Number of entries invalid", player, DB, #tbl, text)
									table.remove(data, index)
									integrityClean = false
								elseif complete and private.IC(tbl, DB) then
									--do a full check type() = check
									debugPrint("Failed type() check", player, DB)
									table.remove(data, index)
									integrityClean = false
								end
							end
						end
					end

				end
			end
		end
	end
	--rerun integrity 10 times or until it goes cleanly
	if not integrityClean and  integrityCount < 10 then
		integrityCount = integrityCount + 1
		integrityClean = true
		private.integrityCheck(complete, server)
	else
		print("BeanCounter Integrity Check Completed after:",integrityCount, "passes")
		integrityClean, integrityCount = true, 1
		--set("util.beancounter.integrityCheckComplete", true)
		--set("util.beancounter.integrityCheck", true)
	end

end
--look at each value and compare to the number, string, number pattern for that specific DB
function private.IC(tbl, DB, text)
	for i,v in pairs(tbl) do
		if v ~= "" then --<nil> is a placeholder for string and number values, ignore
			v = tonumber(v) or v
			if type(v) ~= integrity[DB][i] then
				return true
			end
		end
	end
	return false
end
