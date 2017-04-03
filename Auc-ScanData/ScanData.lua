--[[
	Auctioneer - ScanData
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: ScanData.lua 4696 2010-03-24 22:04:27Z Nechckn $
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
--]]
if not AucAdvanced then return end

local libType, libName = "Util", "ScanData"
local lib,parent,private = AucAdvanced.NewModule(libType, libName)
if not lib then return end

local DATABASE_VERSION = 1.3
local INTERFACE_VERSION = "A" -- must match CoreScan's SCANDATA_VERSION

local aucPrint,decode,_,_,replicate,empty,get,set,default,debugPrint,fill = AucAdvanced.GetModuleLocals()

private.distributionCache = {}
private.worthCache = {}

local Const = AucAdvanced.Const
local QueryImage = AucAdvanced.API.QueryImage
local PriceCalcLevel = AucAdvanced.Modules.Util.PriceLevel and AucAdvanced.Modules.Util.PriceLevel.CalcLevel

local HomeRealm = GetRealmName()
local HomeKey = HomeRealm.."-"..UnitFactionGroup("player")
local NeutralKey = HomeRealm.."-Neutral"

local type = type
local pairs = pairs
local format = format
local floor = floor
local tostring, strjoin = tostring, strjoin
local tinsert, tremove, tconcat, unpack, wipe = tinsert, tremove, table.concat, unpack, wipe

local colorDist = {
	exact = { red=0, orange=0, yellow=0, green=0, blue=0 },
	suffix = { red=0, orange=0, yellow=0, green=0, blue=0 },
	base = { red=0, orange=0, yellow=0, green=0, blue=0 },
    stack = { },
	all = { red=0, orange=0, yellow=0, green=0, blue=0 },
}

--[[ MODULE FUNCTIONS ]]--

function lib.Processor(callbackType, ...)
	if (callbackType == "tooltip") then
		private.ProcessTooltip(...)
	elseif (callbackType == "scanstats") then
		wipe(private.distributionCache)
		wipe(private.worthCache)
	elseif callbackType == "load" then
		local addon = ...
		if addon == "auc-scandata" then
			if private.OnLoad then
				private.OnLoad()
			end
		end
	end
end

local tmp = {}
function lib.Colored(doIt, counts, alt, shorten)
	local n=0
	if (counts.blue > 0) then
		n=n+1
		if shorten and counts.blue>=1000 then
			tmp[n] = format("|cff3399ff%dk|r", floor(counts.blue/1000+0.5))
		else
			tmp[n] = format("|cff3399ff%d|r", counts.blue)
		end
	end
	if (counts.green > 0) then
		n=n+1
		if shorten and counts.green>=1000 then
			tmp[n] = format("|cff33ff44%dk|r", floor(counts.green/1000+0.5))
		else
			tmp[n] = format("|cff33ff44%d|r", counts.green)
		end
	end
	if (counts.yellow > 0) then
		n=n+1
		if shorten and counts.yellow>=1000 then
			tmp[n] = format("|cffffff00%dk|r", floor(counts.yellow/1000+0.5))
		else
			tmp[n] = format("|cffffff00%d|r", counts.yellow)
		end
	end
	if (counts.orange > 0) then
		n=n+1
		if shorten and counts.orange>=1000 then
			tmp[n] = format("|cffff9900%dk|r", floor(counts.orange/1000+0.5))
		else
			tmp[n] = format("|cffff9900%d|r", counts.orange)
		end
	end
	if (counts.red > 0) then
		n=n+1
		if shorten and counts.red>=1000 then
			tmp[n] = format("|cffff0000%dk|r", floor(counts.red/1000+0.5))
		else
			tmp[n] = format("|cffff0000%d|r", counts.red)
		end
	end
	local text = tconcat(tmp, " / ", 1, n)
	if alt then
		if text and text ~= "" then
			text = "( "..text.." )"
		else
			text = alt
		end
	end
	return text
end

local query3 = {} -- 3 fields itemId, suffix & factor
function lib.GetImageCounts(hyperlink, maxPrice, items, serverKey)
	if type(hyperlink) == "number" then
		query3.itemId = hyperlink
		query3.suffix = 0
		query3.factor = 0
	else
		local iType, iID, iSuffix, iFactor = decode(hyperlink)
		if iType == "item" then
			query3.itemId = iID
			query3.suffix = iSuffix
			query3.factor = iFactor
		else
			return
		end
	end
	local image = QueryImage(query3, serverKey)

	local totalBid, totalBuy = 0, 0

	for i=1, #image do
		local item = image[i]
		local count = item[Const.COUNT]
		local bid = item[Const.PRICE]
		local buy = item[Const.BUYOUT]

		local matched = false
		if maxPrice then
			if buy > 0 and buy <= maxPrice then
				totalBuy = totalBuy + count
				matched = true
			elseif bid <= maxPrice then
				totalBid = totalBid + count
				matched = true
			end
		else
			if buy > 0 then
				totalBuy = totalBuy + count
				matched = true
			else
				totalBid = totalBid + count
				matched = true
			end
		end
		if items and matched then
			tinsert(items, item)
		end
	end

	return totalBuy, totalBid
end

local query1 = {} -- only 1 field itemId
function lib.GetDistribution(hyperlink)
	local iType, iID, iSuffix, iFactor = decode(hyperlink)
	if iType ~= "item" then return end
	local sig = strjoin(":", iID, iSuffix, iFactor)
	if private.distributionCache[sig] then return unpack(private.distributionCache[sig]) end

	local exact, suffix, base, myColors = 0,0,0,{}
	for k,v in pairs(colorDist) do
		myColors[k] = {}
		for c,n in pairs(v) do
			myColors[k][c] = 0
		end
	end

	query1.itemId = iID
	local image = QueryImage(query1)
	local sigTemplate = iID..":%d:%d"
	for i=1, #image do
		local item = image[i]
		local vSuffix = item[Const.SUFFIX]
		local vFactor = item[Const.FACTOR]
		local vCount = item[Const.COUNT]

		local vColor
		if (PriceCalcLevel) then
			local _
			local vLink = item[Const.LINK]
			local vBid = item[Const.PRICE]
			local vBuy = item[Const.BUYOUT]
			local vSig = sigTemplate:format(vSuffix, vFactor)
			_,_,_,_,_, vColor, private.worthCache[vSig] = PriceCalcLevel(vLink, vCount, vBid, vBuy, private.worthCache[vSig])
		end

		if (vSuffix == iSuffix) then
			if (vFactor == iFactor) then
				exact = exact + vCount
				if (vColor) then
					myColors.exact[vColor] = myColors.exact[vColor] + vCount
				end
			else
				suffix = suffix + vCount
				if (vColor) then
					myColors.suffix[vColor] = myColors.suffix[vColor] + vCount
				end
			end
		else
			base = base + vCount
			if (vColor) then
				myColors.base[vColor] = myColors.base[vColor] + vCount
			end
		end
		if (vColor) then
			myColors.all[vColor] = myColors.all[vColor] + vCount
			-- Set up colours per stack size as well.
			if not myColors.stack[vCount] then myColors.stack[vCount] =  { red=0, orange=0, yellow=0, green=0, blue=0 } end
			myColors.stack[vCount][vColor] = myColors.stack[vCount][vColor] + vCount
		end
	end

	private.distributionCache[sig] = {exact, suffix, base, myColors}
	return exact, suffix, base, myColors
end

function private.ProcessTooltip(tooltip, name, hyperlink, quality, quantity, cost)
	if not get("scandata.tooltip.display") then return  end

	tooltip:SetColor(0.3, 0.9, 0.8)

	local doColor = true
	local exact, suffix, base, dist = lib.GetDistribution(hyperlink)

	if base+suffix+exact <= 0 then
		tooltip:AddLine("No matches in image.")
	else
		if get("scandata.tooltip.modifier") and IsShiftKeyDown() then
			tooltip:AddLine("Items in image:")
			if (exact > 0) then
				tooltip:AddLine("  |cffddeeff"..exact.."|r exact "..lib.Colored(doColor, dist.exact, "matches"))
			end
			if (suffix > 0) then
				tooltip:AddLine("  |cffddeeff"..suffix.."|r suffix "..lib.Colored(doColor, dist.suffix, "matches"))
			end
			if (base > 0) then
				tooltip:AddLine("  |cffddeeff"..base.."|r base "..lib.Colored(doColor, dist.base, "matches"))
			end
			if (dist.stack) then
				for stackSize, stackColor in pairs(dist.stack) do
					tooltip:AddLine("  Stacks of "..stackSize.."  "..lib.Colored(doColor, stackColor, "in image"))
				end
			end
		else
			if (suffix+base > 0) then
				tooltip:AddLine("|cffddeeff"..exact.." +"..(suffix+base).."|r matches "..lib.Colored(doColor, dist.all, "in image"))
			else
				tooltip:AddLine("|cffddeeff"..exact.."|r matches "..lib.Colored(doColor, dist.exact, "in image"))
			end
		end
	end
end

--[[ DATABASE FUNCTIONS ]]--
function lib.GetAddOnInfo()
	return private.isLoaded, INTERFACE_VERSION
end

private.dataCache = {}
function lib.GetScanData(serverKey)
	local cache = private.dataCache[serverKey]
	if cache then return cache end

	local realm, faction = AucAdvanced.SplitServerKey(serverKey)
	if not realm then
		debugPrint("AucScanData: invalid serverKey passed to GetScanData: "..tostring(serverKey), "ScanData", "Invalid serverKey", "Error")
		return
	end

	local realmdata = AucScanData.scans[realm]
	if not realmdata then return end -- not in database

	local livedata = serverKey == HomeKey or serverKey == NeutralKey -- 'live' data can be changed by scanning
	local scandata = realmdata[faction]
	if scandata then
		if not livedata then
			-- Copy scandata info into a clone table and call Unpack on that
			-- The original does not get unpacked, so does not need repacking
			local clone = {
				image = scandata.image, -- will be overwritten by unpack
				ropes = scandata.ropes, -- will be deleted by unpack
				scanstats = replicate(scandata.scanstats)
			}
			scandata = clone
		end
		if type(scandata.scanstats) ~= "table" then
			scandata.scanstats = {ImageUpdated = scandata.time or time()}
		end
		if not scandata.image then
			scandata.image = {}
			scandata.scanstats.ImageUpdated = time()
		end
		-- delete obsolete entries
		scandata.nextID = nil
		scandata.time = nil
		scandata.LastFullScan = nil
		scandata.LastGetAll = nil
	else
		scandata = {image = {}, scanstats = {ImageUpdated = time()} }
		if livedata then
			realmdata[faction] = scandata
		end
	end

	private.Unpack(scandata)
	private.dataCache[serverKey] = scandata
	return scandata
end

function lib.ClearScanData(key)
	local report, serverKey
	if key == "ALL" then
		wipe(AucScanData.scans)
		report = "all realms"
	elseif key == "SERVER" then
		AucScanData.scans[HomeRealm] = nil
		report = HomeRealm
	elseif key == "FACTION" then
		local sKey, realm, faction = AucAdvanced.GetFaction()
		AucScanData.scans[realm][faction] = nil
		local _, _, text = AucAdvanced.SplitServerKey(sKey)
		report = text
		serverKey = sKey
	elseif AucScanData.scans[key] then -- it's a realm name
		AucScanData.scans[key] = nil
		report = key
	else
		-- is it a serverKey?
		local realm, faction, text = AucAdvanced.SplitServerKey(key)
		if faction and AucScanData.scans[realm] then
			AucScanData.scans[realm][faction] = nil
			report = text
			serverKey = key
		end
	end
	wipe(private.dataCache)
	-- Our functions expect home faction to exist - create a new one if it has just been deleted
	if not AucScanData.scans[HomeRealm] then AucScanData.scans[HomeRealm] = {} end
	lib.GetScanData(HomeKey) -- force create (if needed) and put back in cache
	if report then
		aucPrint("Auctioneer: ScanData cleared for {{"..report.."}}.")
		local clearstats = {
			source = "clear",
			clearRequest = key,
			clearReport = report,
			serverKey = serverKey,
		}
		AucAdvanced.SendProcessorMessage("scanstats", clearstats)
	else
		aucPrint("Auctioneer: Cannot clear ScanData for \""..tostring(key).."\"")
	end
end

function private.Unpack(scandata)
	if type(scandata.image) == "string" then
		if scandata.image ~= "rope" then
			scandata.ropes = { scandata.image }
		end

		scandata.image = {}
		for pos, rope in ipairs(scandata.ropes) do
			local loader, err = loadstring(rope)
			if loader then
				local test, items = pcall(loader)
				if test then
					for pos, item in ipairs(items) do
						tinsert(scandata.image, item)
					end
					err = nil
				else
					err = items
				end
			end
			if err then
				aucPrint("Error loading scan image: {{", err, "}}")
				-- if we get an error from any rope, assume the whole packed image is corrupt
				scandata.image = {}
				scandata.scanstats.ImageUpdated = time()
				break
			end
		end
	elseif type(scandata.image) ~= "table" then
		scandata.image = {}
		scandata.scanstats.ImageUpdated = time()
	end
	scandata.ropes = nil
end

function private.OnLoad()
	private.OnLoad = nil
	private.UpgradeDB()
	if not AucScanData.scans[HomeRealm] then AucScanData.scans[HomeRealm] = {} end
	lib.GetScanData(HomeKey) -- force unpack of home faction data
	private.isLoaded = true
end

function private.UpgradeDB()
	private.UpgradeDB = nil

	if AucScanData then
		if type(AucScanData.scans) ~= "table" then AucScanData.scans = {} end
		if AucScanData.Version == DATABASE_VERSION then return end

		if AucScanData.Version == "1.2" then
			-- version "1.2" to version 1.3
			-- Database structure is virtually the same, we won't try to update the whole database here
			-- Each time GetScanData is called it will check/update that record as needed
			aucPrint("Auc-ScanData is upgrading database version 1.2 to 1.3")
			AucScanData.Version = DATABASE_VERSION
			return
		end

		-- Unknown version - wipe and start from fresh
		aucPrint("Auc-ScanData database error: unknown version, resetting database")
		wipe(AucScanData.scans)
		AucScanData.Version = DATABASE_VERSION
	else
		AucScanData = { Version = DATABASE_VERSION, scans = {} }
	end
end

function lib.OnUnload()
	local StringRope = LibStub:GetLibrary("StringRope")
	local rope = StringRope:New(-1)

	local maxLen = 2^22

	if not (AucScanData and AucScanData.scans) then return end

	-- Convert all image data to loadstring strings
	for server, sData in pairs(AucScanData.scans) do
		for faction, fData in pairs(sData) do
			if fData.image and type(fData.image) == "table" then
				fData.ropes = {}
				rope:Add("return {")
				local fCount = #fData.image
				for i = 1, fCount do
					local item = fData.image[i]
					if item and type(item) == "table" then
						rope:Add("{")
						local pos = 1
						while item[pos] or item[pos+1] or item[pos+2] or item[pos+3] do
							local v = item[pos]
							if v == nil then
								rope:Add("nil,")
							else
								local t = type(v)
								if t == "string" then
									rope:Add(("%q,"):format(v))
								elseif t == "number" then
									rope:Add(v..",")
								elseif t == "boolean" then
									rope:Add(tostring(v)..",")
								else
									rope:Add("nil--[["..t.."]],")
								end
							end
							pos = pos + 1
						end
						rope:Add("},")
					elseif item == nil then
						rope:Add("nil,")
					else
						rope:Add("nil--[["..type(item).."]],")
					end
					if rope.len and rope.len > maxLen then
						rope:Add("}");
						tinsert(fData.ropes, rope:Get())
						rope:Clear()
						rope:Add("return {")
					end
				end
				rope:Add("}")
				fData.image = "rope"
				tinsert(fData.ropes, rope:Get())
				rope:Clear()
			end
		end
	end
end

AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Auc-ScanData/ScanData.lua $", "$Rev: 4696 $")
