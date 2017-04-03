--[[
	Auctioneer
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: CoreScan.lua 4711 2010-04-11 00:26:20Z Nechckn $
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

--[[
	Auctioneer Scanning Engine.

	Provides a service to walk through an AH Query, reporting changes in the AH to registered utilities and stats modules
]]
if not AucAdvanced then return end

if (not AucAdvanced.Scan) then AucAdvanced.Scan = {} end

local SCANDATA_VERSION = "A" -- must match Auc-ScanData INTERFACE_VERSION

local lib = AucAdvanced.Scan
local private = {}
lib.Private = private

local Const = AucAdvanced.Const
local _print,decode,_,_,replicate,empty,get,set,default,debugPrint,fill = AucAdvanced.GetModuleLocals()
private.Print = _print
local GetFaction = AucAdvanced.GetFaction
local EquipCodeToInvIndex = AucAdvanced.Const.EquipCodeToInvIndex

local tinsert, tremove = tinsert, tremove
local bitand, bitor, bitnot = bit.band, bit.bor, bit.bnot
local type, wipe = type, wipe
local pairs, ipairs = pairs, ipairs
local tonumber = tonumber

local GetTime = GetTime

private.isScanning = false

function private.LoadScanData()
	if not private.loadingScanData then
		local _, _, _, enabled, load, reason = GetAddOnInfo("Auc-ScanData")
		if not (enabled and load) then
			private.loadingScanData = "fallback"
			message("The Auc-ScanData storage module could not be loaded: "..(reason or "Unknown reason"))
		elseif IsAddOnLoaded("Auc-ScanData") then
			-- if another AddOn has force-loaded Auc-ScanData
			private.loadingScanData = "loading"
		else
			private.loadingScanData = "block" -- prevents re-entry to this function during the LoadAddOn call
			load, reason = LoadAddOn("Auc-ScanData")
			if load then
				private.loadingScanData = "loading"
			elseif reason then
				private.loadingScanData = "fallback"
				message("The Auc-ScanData storage module could not be loaded: "..reason)
			else
				-- LoadAddOn sometimes returns nil, nil if called too early during game startup
				-- assume it needs to be called again at a later stage
				private.loadingScanData = nil
			end
		end
	end
	if private.loadingScanData == "loading" then
		local ready, version
		local scanmodule = AucAdvanced.Modules.Util.ScanData
		if scanmodule and scanmodule.GetAddOnInfo then
			ready, version = scanmodule.GetAddOnInfo()
		end
		if version ~= SCANDATA_VERSION then
			private.loadingScanData = "fallback"
			message("The Auc-ScanData storage module could not be loaded: ".."Incorrect version")
		elseif ready then
			-- install functions from Auc-ScanData
			private.GetScanData = scanmodule.GetScanData
			lib.ClearScanData = scanmodule.ClearScanData
			-- cleanup
			private.loadingScanData = nil
			private.LoadScanData = nil
			-- signal success
			return private.GetScanData
		end
	end
	if private.loadingScanData == "fallback" then
		-- cannot load Auc-ScanData, go to fallback image handler
		local fallbackscandata = {}
		private.GetScanData = function(serverKey)
			local scandata = fallbackscandata[serverKey]
			if scandata then return scandata end
			local test = AucAdvanced.SplitServerKey(serverKey)
			if not test then return end
			scandata = {image = {}, scanstats = {ImageUpdated = time()}}
			fallbackscandata[serverKey] = scandata
			return scandata
		end
		-- cleanup
		private.loadingScanData = nil
		private.LoadScanData = nil
		-- signal success
		return private.GetScanData
	end
end

function lib.GetImage()
	-- Deprecated
	if private.LoadScanData then private.LoadScanData() end
end

function lib.LoadScanData()
	if private.LoadScanData then private.LoadScanData() end
end

-- scandataTable = private.GetScanData(serverKey)
-- parameter: serverKey (required)
-- returns: scandataTable = {image = imageTable, scanstats = scanstatsTable} for the specified serverKey
-- returns: nil if there is no data for serverKey (or if serverKey is invalid)
-- CAUTION: the following is a stub function, which will be overloaded with the real function by LoadScanData
function private.GetScanData(serverKey)
	if private.LoadScanData then
		local newfunc = private.LoadScanData()
		if newfunc then
			return newfunc(serverKey)
		end
	end
end

-- AucAdvanced.Scan.ClearScanData(serverKey)
-- AucAdvanced.Scan.ClearScanData(realmName)
-- AucAdvanced.Scan.ClearScanData("SERVER") -- all data for current server
-- AucAdvanced.Scan.ClearScanData("FACTION") -- data for current faction (as determined by AucAdvanced.GetFaction())
-- AucAdvanced.Scan.ClearScanData("ALL")
-- CAUTION: the following is a stub function, which will be overloaded with the real function by LoadScanData
function lib.ClearScanData(key)
	private.Print("Scan Data cannot be cleared because {{Auc-ScanData}} is not loaded")
end

function lib.StartPushedScan(name, minLevel, maxLevel, invTypeIndex, classIndex, subclassIndex, isUsable, qualityIndex, GetAll, NoSummary)
	if not private.scanStack then private.scanStack = {} end

	name, minLevel, maxLevel, invTypeIndex, classIndex, subclassIndex, isUsable, qualityIndex = private.QueryScrubParameters(
		name, minLevel, maxLevel, invTypeIndex, classIndex, subclassIndex, isUsable, qualityIndex)

	if private.scanStack then
		for _, scan in ipairs(private.scanStack) do
			if private.QueryCompareParameters(scan[3], name, minLevel, maxLevel, invTypeIndex, classIndex, subclassIndex, isUsable, qualityIndex) then
				-- duplicate of exisiting queued query
				if (nLog) then
					nLog.AddMessage("Auctioneer", "Scan", N_INFO, "Duplicate pushed scan detected, cancelling duplicate")
				end
				return
			end
		end
	end

	local query = private.NewQueryTable(name, minLevel, maxLevel, invTypeIndex, classIndex, subclassIndex, isUsable, qualityIndex)
	query.qryinfo.pushed = true
	if NoSummary then query.qryinfo.nosummary = true end

	if (nLog) then
		nLog.AddMessage("Auctioneer", "Scan", N_INFO, ("Starting pushed scan %d (%s)"):format(query.qryinfo.id, query.qryinfo.sig))
	end

	local now = GetTime()
	tinsert(private.scanStack, {time(), false, query, {}, {}, now, 0, now})
end

function lib.PushScan()
	if private.isGetAll then
		-- A GetAll scan cannot be Popped; do not allow it to be Pushed
		private.Print("Warning: Scan cannot be Pushed because it is a GetAll scan")
		return
	end
	if private.isScanning then
		if (nLog) then
			nLog.AddMessage("Auctioneer", "Scan", N_INFO, ("Scan %d (%s) Paused, next page to scan is %d"):format(private.curQuery.qryinfo.id, private.curQuery.qryinfo.sig, private.curQuery.qryinfo.page+1))
		end
		-- private.Print(("Pausing current scan at page {{%d}}."):format(private.curQuery.qryinfo.page+1))
		if not private.scanStack then private.scanStack = {} end
		tinsert(private.scanStack, {
			private.scanStartTime,
			private.sentQuery,
			private.curQuery,
			private.curPages,
			private.curScan,
			private.scanStarted,
			private.totalPaused,
			GetTime()
		})
		local oldquery = private.curQuery
		private.curQuery = nil
		private.scanStartTime = nil
		private.scanStarted = nil
		private.totalPaused = nil
		private.curScan = nil

		private.curPages = nil
		private.sentQuery = nil
		private.isScanning = false
		private.UpdateScanProgress(false, nil, nil, nil, nil, nil, oldquery)
	end
end

function lib.PopScan()
	if private.scanStack and #private.scanStack > 0 then
		local now, pauseTime = GetTime()
		private.scanStartTime,
		private.sentQuery,
		private.curQuery,
		private.curPages,
		private.curScan,
		private.scanStarted,
		private.totalPaused,
		pauseTime = unpack(private.scanStack[1])
		tremove(private.scanStack, 1)

		local elapsed = now - pauseTime
		if elapsed > 300 then
			-- 5 minutes old
			--private.Print("Paused scan is older than 5 minutes, commiting what we have and aborting")
			if (nLog) then
				nLog.AddMessage("Auctioneer", "Scan", N_WARN, ("Scan %d Too Old, committing what we have and aborting"):format(private.curQuery.qryinfo.id))
			end
			private.Commit(true, false) --  Incomplete, non-GetAll Scan
			return
		end

		private.totalPaused = private.totalPaused + elapsed
		if (nLog) then
			nLog.AddMessage("Auctioneer", "Scan", N_INFO, ("Scan %d Resumed, next page to scan is %d"):format(private.curQuery.qryinfo.id, private.curQuery.qryinfo.page+1))
		end
		--private.Print(("Resuming paused scan at page {{%d}}..."):format(private.curQuery.qryinfo.page+1))
		private.isScanning = true
		private.sentQuery = false
		private.ScanPage(private.curQuery.qryinfo.page+1)
		private.UpdateScanProgress(true, nil, nil, nil, nil, nil, private.curQuery)
	end
end

local CommitProgressBar = CreateFrame("STATUSBAR", "$parentHealthBar", UIParent, "TextStatusBar")
CommitProgressBar:SetWidth(300)
CommitProgressBar:SetHeight(18)
CommitProgressBar:SetPoint("CENTER", UIParent, "CENTER", -5,5)
CommitProgressBar:SetBackdrop({
  bgFile="Interface\\Tooltips\\UI-Tooltip-Background",
  edgeFile="Interface\\Tooltips\\UI-Tooltip-Border",
  tile=1, tileSize=10, edgeSize=10,
  insets={left=1, right=1, top=1, bottom=1}
})

CommitProgressBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
CommitProgressBar:SetStatusBarColor(0.6,0,0,0.4)
CommitProgressBar:SetMinMaxValues(0,100)
CommitProgressBar:SetValue(50)
CommitProgressBar:Hide()

CommitProgressBar.text = CommitProgressBar:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
CommitProgressBar.text:SetPoint("CENTER", CommitProgressBar, "CENTER")
CommitProgressBar.text:SetJustifyH("CENTER")
CommitProgressBar.text:SetJustifyV("CENTER")
CommitProgressBar.text:SetText("Auctioneer: Processing")
CommitProgressBar.text:SetTextColor(1,1,1)

local GetAllProgressBar = CreateFrame("STATUSBAR", "$parentHealthBar", UIParent, "TextStatusBar")
GetAllProgressBar:SetWidth(300)
GetAllProgressBar:SetHeight(18)
GetAllProgressBar:SetPoint("CENTER", UIParent, "CENTER", -5,5)
GetAllProgressBar:SetBackdrop({
  bgFile="Interface\\Tooltips\\UI-Tooltip-Background",
  edgeFile="Interface\\Tooltips\\UI-Tooltip-Border",
  tile=1, tileSize=10, edgeSize=10,
  insets={left=1, right=1, top=1, bottom=1}
})

GetAllProgressBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
GetAllProgressBar:SetStatusBarColor(0.6,0,0,0.4)
GetAllProgressBar:SetMinMaxValues(0,100)
GetAllProgressBar:SetValue(50)
GetAllProgressBar:Hide()

GetAllProgressBar.text = GetAllProgressBar:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
GetAllProgressBar.text:SetPoint("CENTER", GetAllProgressBar, "CENTER")
GetAllProgressBar.text:SetJustifyH("CENTER")
GetAllProgressBar.text:SetJustifyV("CENTER")
GetAllProgressBar.text:SetText("Auctioneer: Scanning")
GetAllProgressBar.text:SetTextColor(1,1,1)

--controls the display, anchor, and text of our progress bars
function lib.ProgressBars(self, value, show, text)
	--setup parent so we can display even if AH is closed
	if AuctionFrame:IsShown() then
		self:SetParent(AuctionFrame)
		self:SetPoint("TOPRIGHT", AuctionFrame, "TOPRIGHT", -5, 5)
	else
		self:SetParent(UIParent)
	end
	--turn bar on/off
	if show then
		self:Show()
	else
		self:Hide()
	end
	--prevent overlap
	if CommitProgressBar:IsShown() then
		GetAllProgressBar:SetPoint("TOPRIGHT", AuctionFrame, "TOPRIGHT", -5, 23) --set our point above commitbar
	else
		GetAllProgressBar:SetPoint("TOPRIGHT", AuctionFrame, "TOPRIGHT", -5, 5) --set our point to the auctionframe
	end
	--update progress
	if value then
		self:SetValue(value)
	end
	--change bars text if desired
	if text then
		self.text:SetText(text)
	end
end

function lib.StartScan(name, minUseLevel, maxUseLevel, invTypeIndex, classIndex, subclassIndex, isUsable, qualityIndex, GetAll, NoSummary)
	if AuctionFrame and AuctionFrame:IsVisible() then
		if private.isPaused then
			message("Scanning is currently paused")
			return
		end
		if private.isScanning then
			message("Scan is currently in progress")
			return
		end
		local CanQuery, CanQueryAll = CanSendAuctionQuery()
		if GetAll then
			local now = time()
			if not CanQueryAll then
				local text = "You cannot do a GetAll scan at this time."
				if private.LastGetAll then
					local timeleft = 900 - (now - private.LastGetAll) -- 900 = 15 * 60 sec = 15 min
					if timeleft > 0 then
						local minleft = floor(timeleft / 60)
						local secleft = timeleft - minleft * 60
						text = text.." You must wait "..minleft..":"..secleft.." until you can scan again."
					end
				end
				message(text)
				return
			end

			AucAdvanced.API.BlockUpdate(true, false)
			BrowseSearchButton:Hide()
			lib.ProgressBars(GetAllProgressBar, 0, true)
			private.isGetAll = true -- indicates that certain functions must take special action, and that the above changes need to be undone

			private.LastGetAll = now
		else
			if not CanQuery then
				private.queueScan = {
					name, minUseLevel, maxUseLevel, invTypeIndex, classIndex, subclassIndex, isUsable, qualityIndex, GetAll
				}
				return
			end
		end

		if private.curQuery then
			private.Commit(true, false) -- sets private.curQuery to nil
		end

		private.isScanning = true
		private.isNoSummary = NoSummary
		local startPage = 0

		QueryAuctionItems(name or "", minUseLevel or "", maxUseLevel or "",
				invTypeIndex, classIndex, subclassIndex, startPage, isUsable, qualityIndex, GetAll)
		if not private.curQuery then
			-- private.curQuery will have been set if QueryAuctionItems succeeded
			-- this should never fail? we checked CanSendAuctionQuery() earlier
			message("Scan failed: unable to send query")
			if private.isGetAll then
				lib.ProgressBars(GetAllProgressBar, nil, false)
				BrowseSearchButton:Show()
				AucAdvanced.API.BlockUpdate(false)
				private.isGetAll = nil
			end
			return
		end
		AuctionFrameBrowse.page = startPage
		if (NoSummary) then
			private.curQuery.qryinfo.nosummary = true
		end
		if GetAll then
			private.curQuery.qryinfo.getall = true
		end
		private.isNoSummary = false

		--Show the progress indicator
		private.UpdateScanProgress(true, nil, nil, nil, nil, nil, private.curQuery)
	else
		message("Steady on; You'll need to talk to the auctioneer first!")
	end
end

function lib.IsScanning()
	return private.isScanning or (private.queueScan ~= nil)
end

function lib.IsPaused()
	return private.isPaused
end

function private.Unpack(item, storage)
	if not storage then storage = {} end
	storage.id = item[Const.ID]
	storage.link = item[Const.LINK]
	storage.useLevel = item[Const.ULEVEL]
	storage.itemLevel = item[Const.ILEVEL]
	storage.itemType = item[Const.ITYPE]
	storage.subType = item[Const.ISUB]
	storage.equipPos = item[Const.IEQUIP]
	storage.price = item[Const.PRICE]
	storage.timeLeft = item[Const.TLEFT]
	storage.seenTime = item[Const.TIME]
	storage.itemName = item[Const.NAME]
	storage.texture = item[Const.TEXTURE]
	storage.stackSize = item[Const.COUNT]
	storage.quality = item[Const.QUALITY]
	storage.canUse = item[Const.CANUSE]
	storage.minBid = item[Const.MINBID]
	storage.curBid = item[Const.CURBID]
	storage.increment = item[Const.MININC]
	storage.sellerName = item[Const.SELLER]
	storage.buyoutPrice = item[Const.BUYOUT]
	storage.amBidder = item[Const.AMHIGH]
	storage.dataFlag = item[Const.FLAG]
	storage.itemId = item[Const.ITEMID]
	storage.itemSuffix = item[Const.SUFFIX]
	storage.itemFactor = item[Const.FACTOR]
	storage.itemEnchant = item[Const.ENCHANT]
	storage.itemSeed = item[Const.SEED]

	return storage
end
-- Define a public accessor for the above upack function
lib.UnpackImageItem = private.Unpack

--The first parameter will be true if we want to show the process indicator, false if we want to hide it. and nil if we only want to update it.
--The second parameter will be a number that is the max number of items in the scan.
--The third parameter is the current progress of the scan.
function private.UpdateScanProgress(state, totalAuctions, scannedAuctions, elapsedTime, page, maxPages, query)
	if (not (lib.IsScanning() or (state == false))) then
		return
	end
	local scanCount = 0
	if (private.scanStack) then scanCount=#private.scanStack end
	AucAdvanced.SendProcessorMessage("scanprogress", state, totalAuctions, scannedAuctions, elapsedTime, page, maxPages, query, scanCount)
end

function private.IsIdentical(focus, compare)
	for i = 1, Const.SELLER do
		if (i ~= Const.TIME and i ~= Const.CANUSE and focus[i] ~= compare[i]) then
			return false
		end
	end
	return true
end

function private.IsSameItem(focus, compare, onlyDirt)
	if onlyDirt then
		local flag = focus[Const.FLAG]
		if not flag or bitand(flag, Const.FLAG_DIRTY) == 0 then
			return false
		end
	end
	if (focus[Const.LINK] ~= compare[Const.LINK]) then return false end
	if (focus[Const.COUNT] ~= compare[Const.COUNT]) then return false end
	if (focus[Const.MINBID] ~= compare[Const.MINBID]) then return false end
	if (focus[Const.BUYOUT] ~= compare[Const.BUYOUT]) then return false end
	if (focus[Const.CURBID] > compare[Const.CURBID]) then return false end
	return true
end

function lib.FindItem(item, image, lut)
	local focus
	-- If we have a lookuptable, then we don't need to scan the whole lot
	if (lut) then
		local list = lut[item[Const.LINK]]
		if not list then return false
		elseif type(list) == "number" then
			if (private.IsSameItem(image[list], item, true)) then return list end
		else
			local pos
			for i=1, #list do
				pos = list[i]
				if (private.IsSameItem(image[pos], item, true)) then return pos end
			end
		end
	else
		-- We need to scan the whole thing cause there's no lookup table
		for i = 1, #image do
			if (private.IsSameItem(image[i], item, true)) then return i end
		end
	end
end

local statItem = {}
local statItemOld = {}
local function processStats(operation, curItem, oldItem)
	local filtered = false
	if (curItem) then private.Unpack(curItem, statItem) end
	if (oldItem) then private.Unpack(oldItem, statItemOld) end
	if (operation == "create") then
		--[[
			Filtering out happens here so we only have to do Unpack once.
			Only filter on create because once its in the system, dropping it can give the wrong impression to other mods.
			(it could think it was sold, for instance)
		]]
		local modules = AucAdvanced.GetAllModules("AuctionFilter", "Filter")
		for pos, engineLib in ipairs(modules) do
			local pOK, result=pcall(engineLib.AuctionFilter, operation, statItem)
			if (pOK) then
				if (result) then
					curItem[Const.FLAG] = bitor(curItem[Const.FLAG] or 0, Const.FLAG_FILTER)
					filtered = true
					break
				end
			else
				if (nLog) then
					nLog.AddMessage("Auctioneer", "Scan", N_WARN, ("AuctionFilter %s Returned Error %s"):format(engineLib.GetName(), errormsg))
				end
			end
		end
	elseif curItem and bitand(curItem[Const.FLAG] or 0, Const.FLAG_FILTER) == Const.FLAG_FILTER then
		-- This item is a filtered item
		filtered = true
	end
	if filtered then
		return false
	end

	local modules = AucAdvanced.GetAllModules("ScanProcessors")
	for pos, engineLib in ipairs(modules) do
		if engineLib.ScanProcessors[operation] then
			local pOK, errormsg
			if (oldItem) then
				pOK, errormsg = pcall(engineLib.ScanProcessors[operation],operation, statItem, statItemOld)
			else
				pOK, errormsg = pcall(engineLib.ScanProcessors[operation],operation, statItem)
			end
			if (not pOK) then
				if (nLog) then
					nLog.AddMessage("Auctioneer", "Scan", N_WARN, ("ScanProcessor %s Returned Error %s"):format(engineLib.GetName(), errormsg))
				end
			end
		end
	end
	return true
end

function private.IsInQuery(curQuery, data)
	if 	(not curQuery.class or curQuery.class == data[Const.ITYPE])
			and (not curQuery.subclass or (curQuery.subclass == data[Const.ISUB]))
			and (not curQuery.minUseLevel or (data[Const.ULEVEL] >= curQuery.minUseLevel))
			and (not curQuery.maxUseLevel or (data[Const.ULEVEL] <= curQuery.maxUseLevel))
			and (not curQuery.name or (data[Const.NAME] and data[Const.NAME]:lower():find(curQuery.name, 1, true))) -- curQuery.name is already lowercased
			and (not curQuery.isUsable or (private.CanUse(data[Const.LINK])))
			and (not curQuery.invType or (EquipCodeToInvIndex[data[Const.IEQUIP]] == curQuery.invType)) -- must convert iEquip code to invTypeIndex for comparison
			and (not curQuery.quality or (data[Const.QUALITY] >= curQuery.quality))
			then
		return true
	end
	return false
end

local idLists = {}
function private.BuildIDList(scandata, serverKey)
	local idList = idLists[serverKey]
	if idList then return idList end
	idList = {0} -- dummy entry ensures that list is never empty and that counting starts from 1
	idLists[serverKey] = idList
	local image = scandata.image
	for i = 1, #image do
		tinsert(idList, image[i][Const.ID])
	end
	table.sort(idList)
	return idList
end

function private.GetNextID(idList)
	local nextId = idList[1] + 1
	local second = idList[2]
	while second == nextId do
		nextId = second + 1
		tremove(idList, 1)
		second = idList[2]
	end
	idList[1] = nextId
	return nextId
end

-- Library wrapper for private.GetScanData. Deprecated function
function lib.GetScanData(serverKey, reserved)
	AucAdvanced.API.ShowDeprecationAlert(nil, "Direct access to the ScanData image is deprecated. Instead QueryImage, GetImageCopy or GetImageItem should be used")
	if serverKey then
		local realmName, faction = AucAdvanced.SplitServerKey(serverKey)
		if not realmName then
			if serverKey == "Alliance" or serverKey == "Horde" or serverKey == "Neutral" then
				faction = serverKey
			else
				error("Invalid serverKey passed to GetScanData")
			end
			if reserved then
				realmName = reserved
			else
				realmName = GetRealmName()
			end
			serverKey = realmName.."-"..faction
		end
	else
		serverKey = GetFaction()
	end
	return private.GetScanData(serverKey)
end

function lib.GetScanStats(serverKey)
	local scandata = private.GetScanData(serverKey or GetFaction())
	if scandata then
		return scandata.scanstats
	end
end

function lib.GetImageCopy(serverKey)
	-- Create a fully independent copy of the image - intended for use by coroutines
	local scandata = private.GetScanData(serverKey or GetFaction())
	if scandata then
		local image = scandata.image
		local size = Const.LASTENTRY
		local copy = {}
		for i = 1, #image do
			tinsert(copy, {unpack(image[i], 1, size)})
		end
		return copy
	end
end

function lib.GetImageSize(serverKey)
	local scandata = private.GetScanData(serverKey or GetFaction())
	if scandata then
		return #scandata.image
	end
end

function lib.GetImageItem(index, serverKey, reserved)
	-- reserved flag for possible future expansion
	local scandata = private.GetScanData(serverKey or GetFaction())
	if scandata then
		local item = scandata.image[index]
		if item then return {unpack(item, 1, Const.LASTENTRY)} end
	end
end


private.scandataIndex = {}
private.prevQuery = {}
-- private.queryResults is nil initially
-- private.prevQueryServerKey is nil initially

function private.clearImageCaches(scanstats)
	local serverKey = scanstats and scanstats.serverKey
	if serverKey then
		local cache = private.scandataIndex[serverKey]
		if cache then
			wipe(cache)
		end
	else -- no serverKey provided: affects multiple serverKeys (or unknown source), clear all caches
		for _, cache in pairs(private.scandataIndex) do
			wipe(cache)
		end
	end

	private.prevQueryServerKey = nil
	private.queryResults = nil -- not required but frees some memory
end

-- ensure home and neutral factions for current realm are always present
-- unlike the tables for other serverKeys, these tables are *not* weak
private.scandataIndex[GetRealmName().."-"..UnitFactionGroup("player")] = {}
private.scandataIndex[GetRealmName().."-Neutral"] = {}
local weaktablemeta = {__mode="kv"}
function private.SubImageCache(itemId, serverKey)
	local indexResults = private.scandataIndex[serverKey]
	if not indexResults then
		if not AucAdvanced.SplitServerKey(serverKey) then return end -- valid serverKey format?
		indexResults = setmetatable({}, weaktablemeta) -- use weak tables for other serverKeys
		private.scandataIndex[serverKey] = indexResults
	end

	local itemResults = indexResults[itemId]
	if not itemResults then
		local scandata = private.GetScanData(serverKey)
		if not scandata then return end
		itemResults = {}
		for pos, data in ipairs(scandata.image) do
			if data[Const.ITEMID] == itemId then
				tinsert(itemResults, data)
			end
		end
		indexResults[itemId] = itemResults
	end

	return itemResults
end

function lib.QueryImage(query, serverKey, reserved, ...)
	serverKey = serverKey or GetFaction()
	local prevQuery = private.prevQuery
	local queryResults = private.queryResults

	-- is this the same query as last time?
	if serverKey == private.prevQueryServerKey then
		local samequery = true
		for k,v in pairs(prevQuery) do
			if v ~= query[k] then
				samequery = false
				break
			end
		end
		if samequery then
			for k,v in pairs(query) do
				if v ~= prevQuery[k] then
					samequery = false
					break
				end
			end
			if samequery then
				return queryResults
			end
		end
	end

	-- reset results and save a copy of query
	queryResults = {} -- cannot use wipe; needs to be a new table here {ADV-534}
	private.queryResults = queryResults
	wipe(prevQuery)
	for k, v in pairs(query) do prevQuery[k] = v end
	private.prevQueryServerKey = serverKey

	-- get image to search - may be the whole snapshot or a subset
	local image
	if query.itemId then
		image = private.SubImageCache(query.itemId, serverKey)
	else
		local scandata = private.GetScanData(serverKey)
		if scandata then
			image = scandata.image
		end
	end
	if not image then return queryResults end -- return empty results table

	local saneQueryLink
	if query.link then
		saneQueryLink = SanitizeLink(query.link)
	end

	local lowerName
	if query.name then
		lowerName = query.name:lower()
	end

	-- scan image to build a table of auctions that match query
	local ptr, finish = 1, #image
	while ptr <= finish do
		repeat
			local data = image[ptr]
			ptr = ptr + 1
			if not data then break end
			if bitand(data[Const.FLAG] or 0, Const.FLAG_UNSEEN) == Const.FLAG_UNSEEN then break end
			if query.filter and query.filter(data, ...) then break end
			if saneQueryLink and data[Const.LINK] ~= saneQueryLink then break end
			if query.suffix and data[Const.SUFFIX] ~= query.suffix then break end
			if query.factor and data[Const.FACTOR] ~= query.factor then break end
			if query.minUseLevel and data[Const.ULEVEL] < query.minUseLevel then break end
			if query.maxUseLevel and data[Const.ULEVEL] > query.maxUseLevel then break end
			if query.minItemLevel and data[Const.ILEVEL] < query.minItemLevel then break end
			if query.maxItemLevel and data[Const.ILEVEL] > query.maxItemLevel then break end
			if query.class and data[Const.ITYPE] ~= query.class then break end
			if query.subclass and data[Const.ISUB] ~= query.subclass then break end
			if query.quality and data[Const.QUALITY] ~= query.quality then break end
			if query.invType and data[Const.IEQUIP] ~= query.invType then break end
			if query.seller and data[Const.SELLER] ~= query.seller then break end
			if lowerName then
				local name = data[Const.NAME]
				if not (name and name:lower():find(lowerName, 1, true)) then break end
			end

			local stack = data[Const.COUNT]
			local nextBid = data[Const.PRICE]
			local buyout = data[Const.BUYOUT]
			if query.perItem and stack > 1 then
				nextBid = ceil(nextBid / stack)
				buyout = ceil(buyout / stack)
			end
			if query.minStack and stack < query.minStack then break end
			if query.maxStack and stack > query.maxStack then break end
			if query.minBid and nextBid < query.minBid then break end
			if query.maxBid and nextBid > query.maxBid then break end
			if query.minBuyout and buyout < query.minBuyout then break end
			if query.maxBuyout and buyout > query.maxBuyout then break end

			-- If we're still here, then we've got a winner
			tinsert(queryResults, data)
		until true
	end

	return queryResults
end


private.CommitQueue = {}

local CommitRunning = false
local Commitfunction = function()
	local speed = get("scancommit.speed")/100
	speed = speed^2.5
	local processingTime = speed * 0.1 + 0.015
		-- Min (1): 0.02s (~50 fps)      --    Max (100): 0.12s  (~8 fps).   Default (50):  0.037s (~25 fps)
	local inscount, delcount = 0, 0
	if #private.CommitQueue == 0 then CommitRunning = false return end
	CommitRunning = true

	--grab the first item in the commit queue, and bump everything else down
	local TempcurCommit = tremove(private.CommitQueue)
	-- setup various locals for later use
	local TempcurScan = TempcurCommit.Scan
	local TempcurQuery = TempcurCommit.Query
	local wasIncomplete = TempcurCommit.wasIncomplete
	local wasGetAll = TempcurCommit.wasGetAll
	local scanStarted = TempcurCommit.scanStarted
	local scanStartTime = TempcurCommit.scanStartTime
	local totalPaused = TempcurCommit.totalPaused
	local wasOnePage = wasGetAll or (TempcurQuery.qryinfo.page == 0) -- retrieved all records in single pull (only one page scanned or was GetAll)
	local wasUnrestricted = not (TempcurQuery.class or TempcurQuery.subclass or TempcurQuery.minUseLevel
		or TempcurQuery.name or TempcurQuery.isUsable or TempcurQuery.invType or TempcurQuery.quality) -- no restrictions, potentially a full scan

	local serverKey = TempcurQuery.qryinfo.serverKey or GetFaction()
	local scandata = private.GetScanData(serverKey)
	assert(scandata, "Critical error: scandata does not exist for serverKey "..serverKey)
	local idList = private.BuildIDList(scandata, serverKey)
	local now = time()
	if get("scancommit.progressbar") then
		lib.ProgressBars(CommitProgressBar, 0, true)
	end
	local oldCount = #scandata.image
	local scanCount = #TempcurScan

	local progresscounter = 0
	local progresstotal = 3*oldCount + 4*scanCount
	local lastPause = GetTime()

	local filterDeleteCount,filterOldCount, filterNewCount, updateCount, sameCount, newCount, updateRecoveredCount, sameRecoveredCount, missedCount, earlyDeleteCount, expiredDeleteCount = 0,0,0,0,0,0,0,0,0,0,0


	--[[ *** Stage 1: Mark all matching auctions as DIRTY, and build a LookUpTable *** ]]
	local dirtyCount = 0
	local lut = {}

	for pos, data in ipairs(scandata.image) do
		local link = data[Const.LINK]
		progresscounter = progresscounter + 1
		if GetTime() - lastPause >= processingTime then
			lib.ProgressBars(CommitProgressBar, 100*progresscounter/progresstotal, true, "Auctioneer: Processing Stage 1")
			coroutine.yield()
			lastPause = GetTime()
		end
		if link then
			if private.IsInQuery(TempcurQuery, data) then
				-- Mark dirty
				data[Const.FLAG] = bitor(data[Const.FLAG] or 0, Const.FLAG_DIRTY)
				dirtyCount = dirtyCount+1

				-- Build lookup table
				local list = lut[link]
				if (not list) then
					lut[link] = pos
				else
					if (type(list) == "number") then
						lut[link] = {}
						tinsert(lut[link], list)
					end
					tinsert(lut[link], pos)
				end
			else
				-- Mark NOT dirty
				data[Const.FLAG] = bitand(data[Const.FLAG] or 0, bitnot(Const.FLAG_DIRTY))
			end
		end
	end


	--[[ *** Stage 2: Merge new scan into ScanData *** ]]
	lib.ProgressBars(CommitProgressBar, 100*progresscounter/progresstotal, true, "Auctioneer: Starting Stage 2") -- change displayed text for reporting purposes
	processStats("begin")
	for index, data in ipairs(TempcurScan) do
		local itemPos
		progresscounter = progresscounter + 4
		if GetTime() - lastPause >= processingTime then
			lib.ProgressBars(CommitProgressBar, 100*progresscounter/progresstotal, true, "Auctioneer: Processing Stage 2")
			coroutine.yield()
			lastPause = GetTime()
		end
		itemPos = lib.FindItem(data, scandata.image, lut)
		data[Const.FLAG] = bitand(data[Const.FLAG] or 0, bitnot(Const.FLAG_DIRTY))
		data[Const.FLAG] = bitand(data[Const.FLAG], bitnot(Const.FLAG_UNSEEN))
		if (itemPos) then
			local oldItem = scandata.image[itemPos]
			data[Const.ID] = oldItem[Const.ID]
			data[Const.FLAG] = bitand(oldItem[Const.FLAG] or 0, bitnot(Const.FLAG_DIRTY+Const.FLAG_UNSEEN))
			if data[Const.SELLER] == "" then -- unknown seller name in new data; copy the old name if it exists
				data[Const.SELLER] = oldItem[Const.SELLER]
			end
			if (bitand(data[Const.FLAG], Const.FLAG_FILTER)==Const.FLAG_FILTER) then
				filterOldCount = filterOldCount + 1
			else
				if not private.IsIdentical(oldItem, data) then
					if processStats("update", data, oldItem) then
						updateCount = updateCount + 1
					end
					if bitand(oldItem[Const.FLAG] or 0, Const.FLAG_UNSEEN) == Const.FLAG_UNSEEN then
						updateRecoveredCount = updateRecoveredCount + 1
					end
				else
					if processStats("leave", data) then
						sameCount = sameCount + 1
					end
					if bitand(oldItem[Const.FLAG] or 0, Const.FLAG_UNSEEN) == Const.FLAG_UNSEEN then
						sameRecoveredCount = sameRecoveredCount + 1
					end
				end
			end
			scandata.image[itemPos] = replicate(data)
		else
			if (processStats("create", data)) then
				newCount = newCount + 1
			else -- processStats("create"...) filtered the auction: flag it
				data[Const.FLAG] = bitor(data[Const.FLAG] or 0, Const.FLAG_FILTER)
				filterNewCount = filterNewCount + 1
			end
			data[Const.ID] = private.GetNextID(idList)
			tinsert(scandata.image, replicate(data))
		end
	end


	--[[ *** Stage 3: Cleanup deleted auctions *** ]]
	local numempty = 0
	local progressstep = 1
	if #scandata.image > 0 then -- (avoid potential div0)
		-- #scandata.image is probably now larger than when we originally calculated progresstotal -- adjust the step size to compensate
		progressstep = (progresstotal - progresscounter) / #scandata.image
	end
	for pos = #scandata.image, 1, -1 do
		local data = scandata.image[pos]
		progresscounter = progresscounter + progressstep
		if GetTime() - lastPause >= processingTime then
			lib.ProgressBars(CommitProgressBar, 100*progresscounter/progresstotal, true, "Auctioneer: Processing Stage 3")
			coroutine.yield()
			lastPause = GetTime()
		end
		if (bitand(data[Const.FLAG] or 0, Const.FLAG_DIRTY) == Const.FLAG_DIRTY) then
			local auctionmaxtime = Const.AucMaxTimes[data[Const.TLEFT]] or 172800
			local dodelete = false

			if data[Const.TIME] and (now - data[Const.TIME] > auctionmaxtime) then
				-- delete items that have passed their expiry time - even if scan was incomplete
				dodelete = true
				if bitand(data[Const.FLAG] or 0, Const.FLAG_FILTER) == Const.FLAG_FILTER then
					filterDeleteCount = filterDeleteCount + 1
				else
					expiredDeleteCount = expiredDeleteCount + 1
				end
			elseif wasIncomplete then
				missedCount = missedCount + 1
			elseif wasOnePage then
				-- a *completed* one-page scan should not have missed any auctions
				dodelete = true
				if bitand(data[Const.FLAG] or 0, Const.FLAG_FILTER) == Const.FLAG_FILTER then
					filterDeleteCount = filterDeleteCount + 1
				else
					earlyDeleteCount = earlyDeleteCount + 1
				end
			else
				if bitand(data[Const.FLAG] or 0, Const.FLAG_UNSEEN) == Const.FLAG_UNSEEN then
					dodelete = true
					if bitand(data[Const.FLAG] or 0, Const.FLAG_FILTER) == Const.FLAG_FILTER then
						filterDeleteCount = filterDeleteCount + 1
					else
						earlyDeleteCount = earlyDeleteCount + 1
					end
				else
					data[Const.FLAG] = bitor(data[Const.FLAG] or 0, Const.FLAG_UNSEEN)
					missedCount = missedCount + 1
				end
			end
			if dodelete then
				if not (bitand(data[Const.FLAG] or 0, Const.FLAG_FILTER) == Const.FLAG_FILTER) then
					processStats("delete", data)
				end
				tremove(scandata.image, pos)
			end
		elseif not data[Const.LINK] then --if there isn't a link in the data, remove the entry
			tremove(scandata.image, pos)
			numempty = numempty + 1
		end
	end


	--[[ *** Stage 4: Reports *** ]]
	lib.ProgressBars(CommitProgressBar, 100, true, "Auctioneer: Processing Finished")
	processStats("complete")

	local currentCount = #scandata.image
	if (updateCount + sameCount + newCount + filterNewCount + filterOldCount ~= scanCount) then
		if nLog then
			nLog.AddMessage("Auctioneer", "Scan", N_WARN, "Scan Count Discrepency Seen",
				("%d updated + %d same + %d new + %d filtered != %d scanned"):format(updateCount, sameCount,
					newCount, filterOldCount+filterNewCount, scanCount))
		end
	end

	if numempty > 0 then
		if nLog then
			nLog.AddMessage("Auctioneer", "Scan", N_ERROR, "ScanData Missing Links",
				("We saw %d entries in scandata without links"):format(numempty))
		end
	end
	-- image contains filtered items now.  Need to account for new entries that are flagged as filtered (not shown to stats modules)
	if (oldCount - earlyDeleteCount - expiredDeleteCount + newCount + filterNewCount - filterDeleteCount ~= currentCount) then
		if nLog then
			nLog.AddMessage("Auctioneer", "Scan", N_WARN, "Current Count Discrepency Seen",
				("%d - %d - %d + %d + %d - %d != %d"):format(oldCount, earlyDeleteCount, expiredDeleteCount,
					newCount, filterNewCount, filterDeleteCount, currentCount))
		end
	end

	local now = time()
	local scanTimeSecs = math.floor(GetTime() - scanStarted - totalPaused)
	local scanTimeMins = floor(scanTimeSecs / 60)
	scanTimeSecs =  mod(scanTimeSecs, 60)
	local scanTimeHours = floor(scanTimeMins / 60)
	scanTimeMins = mod(scanTimeMins, 60)

	--Hides the end of scan summary if user is not interested
	local printSummary, scanSize = false, ""
	scanSize = TempcurQuery.qryinfo.scanSize
	if scanSize=="Full" then
		printSummary = get("scandata.summaryonfull");
	elseif scanSize=="Partial" then
		printSummary = get("scandata.summaryonpartial")
	else -- scanSize=="Micro"
		printSummary = get("scandata.summaryonmicro")
	end
	if (TempcurQuery.qryinfo.nosummary) then
		printSummary = false
		scanSize = "NoSum-"..scansize
	end

	if (nLog or printSummary) then
		local scanTime = " "
		local summaryLine
		local summary

		if scanTimeHours ~= 0 then
			scanTime = scanTime..scanTimeHours.." Hours "
		end
		if scanTimeMins ~= 0 then
			scanTime = scanTime..scanTimeMins.." Mins "
		end
		if scanTimeSecs ~= 0 or (scanTimeHours == 0 and scanTimeMins == 0) then
			scanTime = scanTime..scanTimeSecs.." Secs "
		end

		if (wasIncomplete) then
			summaryLine = "Auctioneer scanned {{"..scanCount.."}} auctions over{{"..scanTime.."}}before stopping:"
		else
			summaryLine = "Auctioneer finished scanning {{"..scanCount.."}} auctions over{{"..scanTime.."}}:"
		end
		if (printSummary) then private.Print(summaryLine) end
		summary = summaryLine

		summaryLine = "  {{"..oldCount.."}} items in DB at start ({{"..dirtyCount.."}} matched query); {{"..currentCount.."}} at end"
		if (printSummary) then private.Print(summaryLine) end
		summary = summary.."\n"..summaryLine

		if (sameCount > 0) then
			if (sameRecoveredCount > 0) then
				summaryLine = "  {{"..sameCount.."}} unchanged items (of which, "..sameRecoveredCount.." were missed last scan)"
			else
				summaryLine = "  {{"..sameCount.."}} unchanged items"
			end
			if (printSummary) then private.Print(summaryLine) end
			summary = summary.."\n"..summaryLine
		end
		if (updateCount > 0) then
			if (updateRecoveredCount > 0) then
				summaryLine = "  {{"..updateCount.."}} updated items (of which, "..updateRecoveredCount.." were missed last scan)"
			else
				summaryLine = "  {{"..updateCount.."}} updated items"
			end
			if (printSummary) then private.Print(summaryLine) end
			summary = summary.."\n"..summaryLine
		end
		if (newCount > 0) then
			summaryLine = "  {{"..newCount.."}} new items"
			if (printSummary) then private.Print(summaryLine) end
			summary = summary.."\n"..summaryLine
		end
		if (earlyDeleteCount+expiredDeleteCount > 0) then
			if expiredDeleteCount > 0 then
				summaryLine = "  {{"..earlyDeleteCount+expiredDeleteCount.."}} items removed (of which, {{"..expiredDeleteCount.."}} were past expiry time)"
			else
				summaryLine = "  {{"..earlyDeleteCount+expiredDeleteCount.."}} items removed"
			end
			if (printSummary) then private.Print(summaryLine) end
			summary = summary.."\n"..summaryLine
		end
		if (filterNewCount+filterOldCount > 0) then
			summaryLine = "  {{"..filterNewCount+filterOldCount.."}} filtered items"
			if (printSummary) then private.Print(summaryLine) end
			summary = summary.."\n"..summaryLine
		end
		if (filterDeleteCount > 0) then
			summaryLine = "  {{"..filterDeleteCount.."}} filtered items removed"
			if (printSummary) then private.Print(summaryLine) end
			summary = summary.."\n"..summaryLine
		end
		if (missedCount > 0) then
			if (wasIncomplete) then
				summaryLine = "  (Incomplete scan missed {{"..missedCount.."}} items)"
			else
				summaryLine = "  {{"..missedCount.."}} missed items"
			end
			if (printSummary) then private.Print(summaryLine) end
			summary = summary.."\n"..summaryLine
		end
		if (nLog) then nLog.AddMessage("Auctioneer", "Scan", N_INFO, "Scan "..TempcurQuery.qryinfo.id.."("..TempcurQuery.qryinfo.sig..") Committed", summary) end
	end

	local TempcurScanStats = {
		source = "scan",
		serverKey = serverKey,
		scanCount = scanCount,
		oldCount = oldCount,
		sameCount = sameCount,
		newCount = newCount,
		updateCount = updateCount,
		matchedCount = dirtyCount,
		earlyDeleteCount = earlyDeleteCount,
		expiredDeleteCount = expiredDeleteCount,
		currentCount = currentCount,
		missedCount = missedCount,
		filteredCount = filterNewCount+filterOldCount,
		wasIncomplete = wasIncomplete or false,
		wasGetAll = wasGetAll or false,
		startTime = scanStartTime,
		endTime = now,
		started = scanStarted,
		paused = totalPaused,
		ended = GetTime(),
		elapsed = GetTime() - scanStarted - totalPaused,
		query = TempcurQuery,
	}

	local scanstats = scandata.scanstats
	if not scanstats then
		scanstats = {}
		scandata.scanstats = scanstats
	end

	scanstats.LastScan = now
	if oldCount ~= currentCount or scanCount > 0 or dirtyCount > 0  or numempty > 0 then
		scanstats.ImageUpdated = now
	end
	if wasUnrestricted and not wasIncomplete then scanstats.LastFullScan = now end

	-- keep 2 old copies for compatibility
	scanstats[2] = scandata.scanstats[1]
	scanstats[1] = scandata.scanstats[0]
	scanstats[0] = TempcurScanStats

	-- Tell everyone that our stats are updated
	TempcurQuery.qryinfo.finished = true
	AucAdvanced.SendProcessorMessage("scanstats", TempcurScanStats)

	--Hide the progress indicator
	lib.ProgressBars(CommitProgressBar, nil, false)
	private.UpdateScanProgress(false, nil, nil, nil, nil, nil, TempcurQuery)
	lib.PopScan()
	CommitRunning = false
	if not private.curQuery then
		private.ResetAll()
	end
	AucAdvanced.SendProcessorMessage("scanfinish", scanSize, TempcurQuery.qryinfo.sig, TempcurQuery.qryinfo, not wasIncomplete)
end

local CoCommit, CoStore

local function CoroutineResume(...)
	local status, result = coroutine.resume(...)
	if not status and result then
		geterrorhandler()("Error occurred in coroutine: "..result, nil, debugstack((...)));
	end
	return status, result
end

function private.Commit(wasIncomplete, wasGetAll)
	private.StopStorePage()
	if not private.curScan then return end
	tinsert(private.CommitQueue, {
		Query = private.curQuery,
		Scan = private.curScan,
		wasIncomplete = wasIncomplete,
		wasGetAll = wasGetAll,
		scanStarted = private.scanStarted,
		scanStartTime = private.scanStartTime,
		totalPaused = private.totalPaused,
	})

	private.curQuery = nil
	private.curScan = nil
	private.isScanning = false

	if not CoCommit or coroutine.status(CoCommit) == "dead" then
		CoCommit = coroutine.create(Commitfunction)
		CoroutineResume(CoCommit)
	end
	-- in all other cases wait for the next update to resume CoCommit
end

function private.QuerySent(query, isSearch, ...)
	-- Tell everyone that our stats are updated
	AucAdvanced.SendProcessorMessage("querysent", query, isSearch, ...)
	return ...
end

function private.FinishedPage(nextPage)
	-- Tell everyone that our stats are updated
	local modules = AucAdvanced.GetAllModules("FinishedPage")
	for pos, engineLib in ipairs(modules) do
		local pOK, finished = pcall(engineLib.FinishedPage,nextPage)
		if (pOK) then
			if (finished~=nil) and (finished==false) then
				return false
			end
		else
			if (nLog) then
				nLog.AddMessage("Auctioneer", "Scan", N_WARN, ("FinishedPage %s Returned Error %s"):format(engineLib.GetName(), finished))
			end
		end
	end
	return true
end

function private.ScanPage(nextPage, really)
	if (private.isScanning) then
		local CanQuery, CanQueryAll = CanSendAuctionQuery()
		if not (CanQuery and private.FinishedPage(nextPage) and really) then
			private.scanNext = GetTime() + 0.1
			private.scanNextPage = nextPage
			return
		end
		private.sentQuery = true
		private.Hook.QueryAuctionItems(private.curQuery.name or "",
			private.curQuery.minUseLevel or "", private.curQuery.maxUseLevel or "",
			private.curQuery.invType, private.curQuery.classIndex, private.curQuery.subclassIndex, nextPage,
			private.curQuery.isUsable, private.curQuery.quality)
		AuctionFrameBrowse.page = nextPage

		-- The maximum time we'll wait for the pagedata to be returned to us:
		local now = GetTime()
		private.scanDelay = now + 8 -- Only wait for up to ?? seconds
		private.nextCheck = now + 1 -- Check complete in ?? seconds
		private.verifyStart = nil
	end
end

function private.HasAllData()
	local check = private.nextCheck
	if not check then return true end
	local now = GetTime()
	if now > check then -- Wait at least 1 second before checking
		-- Check to see if we have all the page data
		local numBatchAuctions, totalAuctions = GetNumAuctionItems("list")
		if not private.NoOwnerList then
			private.NoOwnerList = {}
			for i = 1, numBatchAuctions do
				private.NoOwnerList[i] = i
			end
		end
		local _, owner = 0, {}
		for i, j in ipairs(private.NoOwnerList) do
			_,_,_,_,_,_,_,_,_,_,_,owner[j] = GetAuctionItemInfo("list", j)
		end
		for i = #private.NoOwnerList, 1, -1 do
			local j = private.NoOwnerList[i]
			if owner[j] then
				-- Remove from the lookuptable
				tremove(private.NoOwnerList, i)
			end
		end
		if #private.NoOwnerList ~= 0 then
			private.nextCheck = now + 0.25
			return false
		end
		private.NoOwnerList = nil
		return true
	end
	return false
end

--[[ Not currently used
function private.NoDupes(pageData, compare)
	if not pageData then return true end
	for pos, pageItem in ipairs(pageData) do
		if (compare[Const.LINK] == pageItem[Const.LINK]) then
			if (private.IsSameItem(pageItem, compare)) then
				return false
			end
		end
	end
	return true
end
--]]

function lib.GetAuctionItem(list, i)
	local itemLink = GetAuctionItemLink(list, i)
	if itemLink then
		itemLink = AucAdvanced.SanitizeLink(itemLink)
		local _,_,_,itemLevel,_,itemType,itemSubType,_,itemEquipLoc = GetItemInfo(itemLink)
		local _, itemId, itemSuffix, itemFactor, itemEnchant, itemSeed = AucAdvanced.DecodeLink(itemLink)
		--[[
			Returns Integer giving range of time left for query
			1 -- short time (Less than 30 mins)
			2 -- medium time (30 mins to 2 hours)
			3 -- long time (2 hours to 8 hours)
			4 -- very long time (8 hours+)
		]]
		local timeLeft = GetAuctionItemTimeLeft(list, i)
		local name, texture, count, quality, canUse, level, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, owner, saleStatus = GetAuctionItemInfo(list, i)
		local invType = Const.EquipEncode[itemEquipLoc]
		buyoutPrice = buyoutPrice or 0
		minBid = minBid or 0

		local nextBid
		if bidAmount > 0 then
			nextBid = bidAmount + minIncrement
			if buyoutPrice > 0 and nextBid > buyoutPrice then
				nextBid = buyoutPrice
			end
		elseif minBid > 0 then
			nextBid = minBid
		else
			nextBid = 1
		end

		if not count or count == 0 then count = 1 end
		if not highBidder then highBidder = false
		else highBidder = true end
		if not owner then owner = "" end
		local curTime = time()

		return {
			itemLink, itemLevel, itemType, itemSubType, invType, nextBid,
			timeLeft, curTime, name, texture, count, quality, canUse, level,
			minBid, minIncrement, buyoutPrice, bidAmount, highBidder, owner,
			0, -1, itemId, itemSuffix, itemFactor, itemEnchant, itemSeed
		}
	end
end

function lib.GetAuctionSellItem(minBid, buyoutPrice, runTime)
	local itemLink = private.auctionItem
	local name, texture, count, quality, canUse, price = GetAuctionSellItemInfo();

	if name and itemLink then
		itemLink = AucAdvanced.SanitizeLink(itemLink)
		local _,_,_,itemLevel,level,itemType,itemSubType,_,itemEquipLoc = GetItemInfo(itemLink)
		local _, itemId, itemSuffix, itemFactor, itemEnchant, itemSeed = AucAdvanced.DecodeLink(itemLink)
		local timeLeft = 4
		if runTime <= 12*60 then timeLeft = 3 end
		local curTime = time()

		return {
			itemLink, itemLevel, itemType, itemSubType, invType, minBid,
			timeLeft, curTime, name, texture, count, quality, canUse, level,
			minBid, 0, buyoutPrice, 0, nil, UnitName("player"),
			0, -1, itemId, itemSuffix, itemFactor, itemEnchant, itemSeed
		}, price
	end
end

local StorePageFunction = function()
	if (not private.curQuery) or (private.curQuery.name == "empty page") then
		return
	end
	private.sentQuery = false
	local page = AuctionFrameBrowse.page
	if not private.curScan then
		private.curScan = {}
	end
	if not private.curPages then
		private.curPages = {}
	end
	local curQuery, curScan, curPages = private.curQuery, private.curScan, private.curPages

	local EventFramesRegistered = {}
	local numBatchAuctions, totalAuctions = GetNumAuctionItems("list")
	local maxPages = ceil(totalAuctions / 50)
	local isGetAll = false
	if (numBatchAuctions > 50) then
		isGetAll = true
		maxPages = 1
		EventFramesRegistered = {GetFramesRegisteredForEvent("AUCTION_ITEM_LIST_UPDATE")}
		for _, frame in pairs(EventFramesRegistered) do
			frame:UnregisterEvent("AUCTION_ITEM_LIST_UPDATE")
		end
		private.verifyStart = 1
		local now = GetTime()
		private.nextCheck = now
		private.scanDelay = now + 30
		coroutine.yield()
	end

	--Update the progress indicator
	local elapsed = GetTime() - private.scanStarted - private.totalPaused
	--store queued scans to pass along on the callback, used by scanbutton and searchUI etc to display how many scans are still queued

	--page, maxpages, name  lets a module know when a "scan" they have queued is actually in progress. scansQueued lets a module know how may scans are left to go
	private.UpdateScanProgress(nil, totalAuctions, #curScan, elapsed, page+1, maxPages, curQuery) --page starts at 0 so we need to add +1

	local curTime = time()
	local getallspeed = get("GetAllSpeed") or 500


	local storecount = 0
	if not private.breakStorePage and (page > curQuery.qryinfo.page) then

		for i = 1, numBatchAuctions do
			if isGetAll and ((i % getallspeed) == 0) then --only start yielding once the first page is done, so it won't affect normal scanning
				lib.ProgressBars(GetAllProgressBar, 100*i/numBatchAuctions, true)
				coroutine.yield()
				if private.breakStorePage then
					break
				end
			end

			local itemData = lib.GetAuctionItem("list", i)
			if itemData then
--				local legacyScanning = private.legacyScanning
--				if legacyScanning == nil then
--					if Auctioneer and Auctioneer.ScanManager and Auctioneer.ScanManager.IsScanning then
--						legacyScanning = Auctioneer.ScanManager.IsScanning
--					else
--						legacyScanning = function () return false end
--					end
--					private.legacyScanning = legacyScanning
--				end

				-- We only store one of the same item/owner/price/quantity in the scan
				-- unless we are doing a forward scan (in which case we can be sure they
				-- are not duplicate entries.
--			if private.isScanning
--			or totalAuctions <= 50
--			or numBatchAuctions > 50 --if GetAll, we can be sure they aren't duplicates
--			or legacyScanning() -- Is AucClassic scanning?
--			or private.NoDupes(curScan, itemData) then
				tinsert(curScan, itemData)
				storecount = storecount + 1
			end
		end

		if (storecount > 0) then
			curQuery.qryinfo.page = page
			curPages[page] = true -- we have pulled this page
		end
	end
	if isGetAll then
		local oldThis = this
		for _, frame in pairs(EventFramesRegistered) do
			frame:RegisterEvent("AUCTION_ITEM_LIST_UPDATE")
			this = frame
			local eventscript = frame:GetScript("OnEvent")
			if eventscript then
				pcall(eventscript, this, "AUCTION_ITEM_LIST_UPDATE")
			end
		end
		this = oldThis
		EventFramesRegistered=nil
	end

	-- Just updated the page if it was a new page, so record it as latest page.
	if (page > curQuery.qryinfo.page) then
		curQuery.qryinfo.page = page
	end

	--Send a Processor event to modules letting them know we are done with the page
	AucAdvanced.SendProcessorMessage("pagefinished", page)

	-- Clear GetAll changes made by StartScan
	if private.isGetAll then -- in theory private.isGetAll should be true iff (local) isGetAll is true -- unless total auctions <=50 (e.g. on PTR)
		lib.ProgressBars(GetAllProgressBar, 100, false)
		BrowseSearchButton:Show()
		AucAdvanced.API.BlockUpdate(false)
		private.isGetAll = nil
	end

	-- Send the next page query or finish scanning
	if isGetAll then
		if not private.breakStorePage then
			private.Commit((#curScan < totalAuctions - 100), true)
			-- Clear the getall output. We don't want to create a new query so use the hook
			private.Hook.QueryAuctionItems("empty page", "", "", nil, nil, nil, nil, nil, nil)
		end
	elseif private.isScanning then
		if (page+1 < maxPages) then
			private.ScanPage(page + 1)
		else
			local incomplete = false
			if (#curScan < totalAuctions - 10) then -- we just got scan size above, so they should be close.
				incomplete = true
			end
			private.Commit(incomplete, false)
		end
	elseif (maxPages == page+1) then
		local incomplete = false
		for i = 0, maxPages-1 do
			if not curPages[i] then
				incomplete = true
				break
			end
		end
		private.Commit(incomplete, false)
	end
end

function private.StopStorePage(silent)
	if not CoStore or coroutine.status(CoStore) ~= "suspended" then return end
	-- flag to break out of the loop, or prevent the loop being entered, within the coroutine
	private.breakStorePage = true
	while coroutine.status(CoStore) == "suspended" do
		CoroutineResume(CoStore)
	end
	private.breakStorePage = nil
	if not silent then
		message("Warning: GetAll scan is incomplete because it was interrupted")
	end
end

function lib.StorePage()
	if not CoStore or coroutine.status(CoStore) == "dead" then
		CoStore = coroutine.create(StorePageFunction)
		CoroutineResume(CoStore)
	elseif coroutine.status(CoStore) == "suspended" then
		CoroutineResume(CoStore)
	end
end

--[[ AucAdvanced.Scan.QuerySafeName(name)
	Library function to convert a name to the 'normalized' form used by scan querys
	Note: performs truncation on names over 63 bytes as QueryAuctionItems cannot handle longer strings
--]]
function lib.QuerySafeName(name)
	if type(name) == "string" and #name > 0 then
		if #name > 63 then
			if name:byte(63) >= 192 then -- UTF-8 multibyte first byte
				name = name:sub(1, 62)
			elseif name:byte(62) >= 224 then -- UTF-8 triplebyte first byte
				name = name:sub(1, 61)
			else
				name = name:sub(1, 63)
			end
		end
		return name:lower()
	end
end

--[[ AucAdvanced.Scan.CreateQuerySig(name, minLevel, maxLevel, invTypeIndex, classIndex, subclassIndex, isUsable, qualityIndex)
	Library function to allow other modules to obtain a query sig
	Returns the sig that would be used in a scan with the specified parameters
--]]
function lib.CreateQuerySig(...)
	return private.CreateQuerySig(private.QueryScrubParameters(...))
end

function private.QueryScrubParameters(name, minLevel, maxLevel, invTypeIndex, classIndex, subclassIndex, isUsable, qualityIndex)
	-- Converts the parameters that we will store in our scanQuery table into a consistent format:
	-- converts each parameter to correct type;
	-- converts all strings to lowercase;
	-- converts all "" and 0 to nil;
	-- converts any invalid parameters to nil.
	name = lib.QuerySafeName(name)
	minLevel = tonumber(minLevel)
	if minLevel and minLevel < 1 then minLevel = nil end
	maxLevel = tonumber(maxLevel)
	if maxLevel and maxLevel < 1 then maxLevel = nil end
	classIndex = tonumber(classIndex)
	if classIndex and classIndex < 1 then classIndex = nil end
	if classIndex then
		subclassIndex = tonumber(subclassIndex)
		if subclassIndex and subclassIndex < 1 then subclassIndex = nil end
	else
		subclassIndex = nil -- subclassIndex is only valid if we have a classIndex
	end
	invTypeIndex = tonumber(invTypeIndex) or Const.EquipLocToInvIndex[invTypeIndex] -- accepts "INVTYPE_*" strings
	if invTypeIndex and invTypeIndex < 1 then invTypeIndex = nil end
	if isUsable and isUsable ~= 0 then
		isUsable = 1
	else
		isUsable = nil
	end
	qualityIndex = tonumber(qualityIndex)
	if qualityIndex and qualityIndex < 1 then qualityIndex = nil end

	return name, minLevel, maxLevel, invTypeIndex, classIndex, subclassIndex, isUsable, qualityIndex
end

function private.CreateQuerySig(name, minLevel, maxLevel, invTypeIndex, classIndex, subclassIndex, isUsable, qualityIndex)
	return strjoin("#",
		name or "",
		minLevel or "",
		maxLevel or "",
		invTypeIndex or "",
		classIndex or "",
		subclassIndex or "",
		isUsable or "",
		qualityIndex or ""
	) -- can use strsplit("#", sig) to extract params
end

function private.QueryCompareParameters(query, name, minLevel, maxLevel, invTypeIndex, classIndex, subclassIndex, isUsable, qualityIndex)
	-- Returns true if the parameters are identical to the values stored in the specified scanQuery table
	-- Use this function to avoid creating a duplicate scanQuery table
	-- Parameters must have been scrubbed first
	-- Note: to compare two scanQuery tables for equality, just compare the sigs
	if query.name == name -- note: both already converted to lowercase when scrubbed
	and query.minUseLevel == minLevel
	and query.maxUseLevel == maxLevel
	and query.classIndex == classIndex
	and query.subclassIndex == subclassIndex
	and query.quality == qualityIndex
	and query.invType == invTypeIndex
	and query.isUsable == isUsable
	then
		return true
	end
end

private.querycount = 0

function private.NewQueryTable(name, minLevel, maxLevel, invTypeIndex, classIndex, subclassIndex, isUsable, qualityIndex)
	-- Assumes the parameters have already been scrubbed
	local class, subclass
	local query, qryinfo = {}, {}
	query.qryinfo = qryinfo

	query.name = name
	query.minUseLevel = minLevel
	query.maxUseLevel = maxLevel
	query.invType = invTypeIndex
	if classIndex then
		class = Const.CLASSES[classIndex]
		query.class = class
		query.classIndex = classIndex
	end
	if subclassIndex then
		subclass = Const.SUBCLASSES[classIndex][subclassIndex]
		query.subclass = subclass
		query.subclassIndex = subclassIndex
	end
	query.isUsable = isUsable
	query.quality = qualityIndex

	qryinfo.page = -1 -- use this to store highest page seen by query, and we haven't seen any yet.
	qryinfo.id = private.querycount
	private.querycount = private.querycount+1
	qryinfo.sig = private.CreateQuerySig(name, minLevel, maxLevel, invTypeIndex, classIndex, subclassIndex, isUsable, qualityIndex)

	-- the return value from GetFaction() can change when the Auctionhouse closes
	-- (Neutral Auctionhouse and "Always Home Faction" option enabled - this is on by default)
	-- store the current return value - this will be used throughout processing to avoid problems
	qryinfo.serverKey = GetFaction()

	local scanSize = false, ""
	if ((not query.class) and (not query.subclass) and (not query.minUseLevel)
			and (not query.maxUseLevel)
			and (not query.name) and (not query.isUsable)
			and (not query.invType) and (not query.quality)) then
		qryinfo.scanSize = "Full"
	elseif (query.name and query.class and query.subclass and query.quality) then
		qryinfo.scanSize = "Micro"
	else
		qryinfo.scanSize = "Partial"
	end

	return query
end

private.Hook = {}
private.Hook.PlaceAuctionBid = PlaceAuctionBid
function PlaceAuctionBid(type, index, bid, ...)
	local itemData = lib.GetAuctionItem(type, index)
	if itemData then
		private.Unpack(itemData, statItem)
		local modules = AucAdvanced.GetAllModules("ScanProcessors")
		for pos, engineLib in ipairs(modules) do
			if engineLib.ScanProcessors["placebid"] then
				pcall(engineLib.ScanProcessors["placebid"],"placebid", statItem, type, index, bid)
			end
		end
	end
	return private.Hook.PlaceAuctionBid(type, index, bid, ...)
end

private.Hook.ClickAuctionSellItemButton = ClickAuctionSellItemButton
function ClickAuctionSellItemButton(...)
	local ctype, itemID, itemLink = GetCursorInfo()
	if ctype == "item" then
		private.auctionItem = itemLink
	else
		private.auctionItem = nil
	end
	return private.Hook.ClickAuctionSellItemButton(...)
end

private.Hook.StartAuction = StartAuction
function StartAuction(minBid, buyoutPrice, runTime, ...)
	local itemData, price = lib.GetAuctionSellItem(minBid, buyoutPrice, runTime)
	if itemData then
		private.Unpack(itemData, statItem)
		local modules = AucAdvanced.GetAllModules("ScanProcessors")
		for pos, engineLib in ipairs(modules) do
			if engineLib.ScanProcessors["newauc"] then
				pcall(engineLib.ScanProcessors["newauc"],"newauc", statItem, minBid, buyoutPrice, runTime, price)
			end
		end
	end
	return private.Hook.StartAuction(minBid, buyoutPrice, runTime, ...)
end

private.Hook.TakeInboxMoney = TakeInboxMoney
function TakeInboxMoney(index, ...)
	local invoiceType, itemName, playerName, bid, buyout, deposit, consignment = GetInboxInvoiceInfo(index)
	if invoiceType then
		local modules = AucAdvanced.GetAllModules("ScanProcessors")
		local _,_, sender = GetInboxHeaderInfo(index)

		local faction = "Neutral"
		if sender:find(FACTION_ALLIANCE) then
			faction = "Alliance"
		elseif sender:find(FACTION_HORDE) then
			faction = "Horde"
		end

		for pos, engineLib in ipairs(modules) do
			if engineLib.ScanProcessors["aucsold"] then
				pcall(engineLib.ScanProcessors["aucsold"],"aucsold", faction, itemName, playerName, bid, buyout, deposit, consignment)
			end
		end
	end
	return private.Hook.TakeInboxMoney(index, ...)
end

private.Hook.QueryAuctionItems = QueryAuctionItems

local isSecure, taint = issecurevariable("CanSendAuctionQuery")
if not isSecure then
	private.warnTaint = taint
end
private.CanSend = CanSendAuctionQuery

function QueryAuctionItems(name, minLevel, maxLevel, invTypeIndex, classIndex, subclassIndex, page, isUsable, qualityIndex, GetAll, ...)
	if private.warnTaint then
		private.Print("\nAuctioneer:\n  WARNING, The CanSendAuctionQuery() function was tainted by the addon: {{"..private.warnTaint.."}}.\n  This may cause minor inconsistencies with scanning.\n  If possible, adjust the load order to get me to load first.\n ")
		private.warnTaint = nil
	end
	if not private.CanSend() then
		private.Print("Can't send query just at the moment")
		return
	end

	local isSearch = (BrowseSearchButton:GetButtonState() == "PUSHED")

	-- If we're getting called after we've sent a query, but before it's been stored, take this chance to save it.
	if private.sentQuery then
		lib.StorePage()
	end

	name, minLevel, maxLevel, invTypeIndex, classIndex, subclassIndex, isUsable, qualityIndex = private.QueryScrubParameters(
		name, minLevel, maxLevel, invTypeIndex, classIndex, subclassIndex, isUsable, qualityIndex)

	local query
	if private.curQuery then
		if private.QueryCompareParameters(private.curQuery, name, minLevel, maxLevel, invTypeIndex, classIndex, subclassIndex, isUsable, qualityIndex) then
			query = private.curQuery
			if (nLog) then
				nLog.AddMessage("Auctioneer", "Scan", N_INFO, ("Sending exisiting query %d (%s)"):format(query.qryinfo.id, query.qryinfo.sig))
			end
		else
			private.Commit(true, false)
		end
	end
	if not query then
		query = private.NewQueryTable(name, minLevel, maxLevel, invTypeIndex, classIndex, subclassIndex, isUsable, qualityIndex)
		private.scanStartTime = time()
		private.scanStarted = GetTime()
		private.totalPaused = 0
		private.curQuery = query
	end

	page = tonumber(page) or 0
	if (page==0) then
		local scanSize = query.qryinfo.scanSize
		if (query.qryinfo.NoSummary) then
			scanSize = "NoSum-"..scansize
		end
		AucAdvanced.SendProcessorMessage("scanstart", scanSize, query.qryinfo.sig, query)
		if (nLog) then
			nLog.AddMessage("Auctioneer", "Scan", N_INFO, ("Sending new query %d (%s)"):format(query.qryinfo.id, query.qryinfo.sig))
		end
	end


	private.sentQuery = true
	lib.lastReq = GetTime()

	return private.QuerySent(query, isSearch,
		private.Hook.QueryAuctionItems(
			name or "", minLevel or "", maxLevel or "", invTypeIndex, classIndex, subclassIndex,
			page, isUsable, qualityIndex, GetAll, ...))
end

function lib.SetPaused(pause)
	if private.isGetAll then
		-- A GetAll scan cannot be Popped or Pushed
		private.Print("Scan cannot be paused/unpaused because it is a GetAll scan")
		return
	end
	if pause then
		if private.isPaused then return end
		lib.PushScan()
		private.isPaused = true
	elseif private.isPaused then
		lib.PopScan()
		private.isPaused = false
	end
end

private.unexpectedClose = false
local flipb, flopb = false, false
function private.OnUpdate(me, dur)
	if CoCommit then
		local costat = coroutine.status(CoCommit)
		if costat == "suspended" then
			CoroutineResume(CoCommit)
		elseif costat == "dead" then
			if #private.CommitQueue > 0 then
				CoCommit = coroutine.create(Commitfunction)
				CoroutineResume(CoCommit)
			else
				CoCommit = nil
			end
		end
	end
	local now = GetTime()
	if not AuctionFrame then return end
	if private.isPaused then return end

	if private.queueScan then
		if CanSendAuctionQuery() and (not private.CanSend or private.CanSend()) then
			local queued = private.queueScan
			private.queueScan = nil
			lib.StartScan(unpack(queued))
		end
		return
	end
	if private.scanDelay then
		-- If we are within the delay interval
		if now < private.scanDelay then
			-- Check to see if all the auctions have fully populated
			if not private.HasAllData() then
				-- If not, we still have time to wait
				return
			end
		end
		private.NoOwnerList = nil
		private.scanDelay = nil
	end
	if CoStore and coroutine.status(CoStore) == "suspended" and AuctionFrame and AuctionFrame:IsVisible() then
		flipb = not flipb
		if flipb then
			flopb = not flopb
			if flopb then
				CoroutineResume(CoStore)
			end
		end
	end
	if private.scanNext then
		if now > private.scanNext and CanSendAuctionQuery() then
			local nextPage = private.scanNextPage
			private.scanNext = nil
			private.ScanPage(nextPage, true)
		end
		return
	end

	if AuctionFrame:IsVisible() then
		if private.unexpectedClose then
			private.unexpectedClose = false
			lib.PopScan()
			return
		end

		if private.sentQuery and CanSendAuctionQuery() then
			lib.StorePage()
		end
	elseif private.curQuery then
		lib.Interrupt()
	end
end
private.updater = CreateFrame("Frame", nil, UIParent)
private.updater:SetScript("OnUpdate", private.OnUpdate)

function lib.Cancel()
	if (private.curQuery) then
		private.Print("Cancelling current scan")
		private.Commit(true, false)
	end
	private.ResetAll()
end

function lib.Interrupt()
	if private.curQuery and not AuctionFrame:IsVisible() then
		if private.isGetAll then
			-- GetAll cannot be pushed/popped so we have to commit here instead
			private.Commit(true, true)
			private.sentQuery = false
			if private.isGetAll then
				-- If the StorePage function didn't run, we need to cleanup here instead
				lib.ProgressBars(GetAllProgressBar, nil, false)
				BrowseSearchButton:Show()
				AucAdvanced.API.BlockUpdate(false)
				private.isGetAll = nil
			end
		elseif private.isScanning then
			private.unexpectedClose = true
			lib.PushScan()
		else
			private.Commit(true, false)
			private.sentQuery = false
		end
	end
end

function lib.Abort()
	if (private.curQuery) then
		private.Print("Aborting current scan")
	end
	private.ResetAll()
end

function private.ResetAll()
	private.StopStorePage(true)

	-- Fallback in case private.isGetAll and related actions were not cleared during processing
	lib.ProgressBars(GetAllProgressBar, nil, false)
	BrowseSearchButton:Show()
	AucAdvanced.API.BlockUpdate(false)
	private.isGetAll = nil

	local oldquery = private.curQuery
	private.curQuery = nil
	private.curScan = nil
	private.isPaused = nil
	private.sentQuery = nil
	private.isScanning = false
	private.unexpectedClose = false

	if CommitRunning then
		private.UpdateScanProgress(false, nil, nil, nil, nil, nil, oldquery)
		return
	end
	private.scanStartTime = nil
	private.scanStarted = nil
	private.totalPaused = nil

	private.curPages = nil
	private.scanStack = nil

	private.Pausing = nil
	--Hide the progress indicator
	private.UpdateScanProgress(false, nil, nil, nil, nil, nil, oldquery)
end

-- In the absence of a proper API function to do it, it's necessary to inspect an item's tooltip to
-- figure out if it's usable by the player
local ItemUsableTooltip = {
	tooltipFrame = nil,
	fontString = {},
	maxLines = 100,

	CanUse = function(this, link)
		-- quick level check first
		local minLevel = select(5, GetItemInfo(link)) or 0
		if UnitLevel("player") < minLevel then
			return false
		end

		-- set up if not done already
		if not this.tooltipFrame then
			this.tooltipFrame = CreateFrame("GameTooltip")
			this.tooltipFrame:SetOwner(UIParent, "ANCHOR_NONE")
			for i = 1, this.maxLines do
				this.fontString[i] = {}
				for j = 1, 2 do
					this.fontString[i][j] = this.tooltipFrame:CreateFontString()
					this.fontString[i][j]:SetFontObject(GameFontNormal)
				end
				this.tooltipFrame:AddFontStrings(this.fontString[i][1], this.fontString[i][2])
			end
			this.minLevelPattern = string.gsub(ITEM_MIN_LEVEL, "(%%d)", "(.+)")
		end

		-- clear tooltip
		local numLines
		numLines = math.min(this.maxLines, this.tooltipFrame:NumLines())
		for i = 1, numLines do
			for j = 1, 2 do
				this.fontString[i][j]:SetText()
				this.fontString[i][j]:SetTextColor(0, 0, 0)
			end
		end

		-- populate tooltip
		this.tooltipFrame:SetHyperlink(link)

		-- search tooltip for red text
		numLines = math.min(this.maxLines, this.tooltipFrame:NumLines())
		for i = 1, numLines do
			for j = 1, 2 do
				local r, g, b = this.fontString[i][j]:GetTextColor()
				if r > 0.8 and g < 0.2 and b < 0.2 then
					-- item is not usable, with one exception: if it doesn't have a level
					-- requirement, red "requires level xxx" text refers to some other item,
					-- e.g. that created by a recipe
					local text = string.lower(this.fontString[i][j]:GetText())
					if not (minLevel == 0 and string.find(text, this.minLevelPattern)) then
						return false
					end
				end
			end
		end

		return true
	end,
}

-- Caching wrapper for ItemUsableTooltip. Invalidates cache when certain events occur
-- (player levels up, learns a new recipe, etc.)
local ItemUsableCached = {
	eventFrame = nil,
	patterns = {},
	cache = {},
	tooltip = ItemUsableTooltip,

	OnEvent = function(this, event, arg1, ...)
		local dirty = false
		-- print("got event " .. event .. ", arg1 " .. arg1)
		if event == "CHAT_MSG_SYSTEM" or event == "CHAT_MSG_SKILL" then
			for _, pattern in pairs(this.patterns) do
				if string.find(arg1, pattern) then
					dirty = true
					break
				end
			end
		elseif event == "PLAYER_LEVEL_UP" then
			dirty = true
		end

		if dirty then
			-- print("invalidating")
			this.cache = {}
		end
	end,

	RegisterChatString = function(this, chatString)
		local pattern = chatString
		pattern = gsub(pattern, "%%s", ".+")
		pattern = gsub(pattern, "%%d", ".+")
		pattern = gsub(pattern, "%%%d+%$s", ".+")
		pattern = gsub(pattern, "%%%d+%$d", ".+")
		pattern = gsub(pattern, "|3%-%d+%(%%s%)", ".+")
		tinsert(this.patterns, pattern)
	end,

	CanUse = function(this, link)
		-- set up if not done already
		if not this.eventFrame then
			this.eventFrame = CreateFrame("Frame")

			-- forward events from frame to self
			this.eventFrame.forwardEventsTo = this
			this.eventFrame:SetScript(
				"OnEvent",
				function(eventFrame, ...)
					eventFrame.forwardEventsTo:OnEvent(...)
				end)

			-- register events and chat patterns
			this.eventFrame:RegisterEvent("CHAT_MSG_SYSTEM")
			this.eventFrame:RegisterEvent("CHAT_MSG_SKILL")
			this.eventFrame:RegisterEvent("PLAYER_LEVEL_UP")

			this:RegisterChatString(ERR_LEARN_ABILITY_S)
			this:RegisterChatString(ERR_LEARN_RECIPE_S)
			this:RegisterChatString(ERR_LEARN_SPELL_S)
			this:RegisterChatString(ERR_SPELL_UNLEARNED_S)
			this:RegisterChatString(ERR_SKILL_GAINED_S)
			this:RegisterChatString(ERR_SKILL_UP_SI)
		end

		local itemType, id = AucAdvanced.DecodeLink(link)
		if not itemType or itemType ~= "item" then return end

		-- check cache first. failing that, do a tooltip scan
		if this.cache[id] == nil then
			-- print("miss " .. link)
			this.cache[id] = this.tooltip:CanUse(link)
		else
			-- print("hit  " .. link)
		end

		return this.cache[id]
	end,
}

private.itemUsable = ItemUsableCached
function private.CanUse(link)
	return private.itemUsable:CanUse(link)
end

function lib.GetScanCount()
	local scanCount = 0
	if (private.scanStack) then scanCount = #private.scanStack end
	if (private.isScanning) then
		scanCount = scanCount + 1
	end
	return scanCount
end

function lib.GetStackedScanCount()
	local scanCount = private.scanStack or 0
	if (private.scanStack) then scanCount = #private.scanStack end
	return scanCount
end

function lib.AHClosed()
	lib.Interrupt()
end

function lib.Logout()
	AucAdvancedData.Scandata = nil -- delete obsolete data. it's here because CoreScan doesn't have an OnLoad processor
	private.Commit(true, false)
	if CoCommit then
		while coroutine.status(CoCommit) == "suspended" do
			CoroutineResume(CoCommit)
		end
	end
end

function lib.Processor(event, ...)
	if event == "scanstats" then
		private.clearImageCaches(...)
	end
end


AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Auc-Advanced/CoreScan.lua $", "$Rev: 4711 $")
