--[[
	Auctioneer - StatPurchased
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: StatPurchased.lua 4640 2010-01-26 02:18:04Z Nechckn $
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

local libType, libName = "Stat", "Purchased"
local lib,parent,private = AucAdvanced.NewModule(libType, libName)
if not lib then return end

-- AucAdvanced locals
local print,decode,_,_,replicate,empty,get,set,default,debugPrint,fill, _TRANS = AucAdvanced.GetModuleLocals()
local Const = AucAdvanced.Const
local GetFaction = AucAdvanced.GetFaction

-- globals -> locals
local assert = assert
local tinsert = tinsert
local sqrt = sqrt
local select,ipairs,pairs,unpack,type,wipe = select,ipairs,pairs,unpack,type,wipe
local tonumber = tonumber
local strsplit = strsplit
local time = time
local concat = table.concat
local strmatch = strmatch

-- Internal variables
local SPRealmData

local pricecache = setmetatable({}, {__mode="v"})

function private.ClearCache()
	wipe(pricecache)
end

function lib.CommandHandler(command, ...)
	local serverKey = GetFaction()
	if (command == "help") then
		print(_TRANS('PURC_Help_SlashHelp1') )--Help for Auctioneer - Purchased
		local line = AucAdvanced.Config.GetCommandLead(libType, libName)
		print(line, "help}} - ".._TRANS('PURC_Help_SlashHelp2') ) --this Purchased help
		print(line, "clear}} - ".._TRANS('PURC_Help_SlashHelp3'):format(serverKey) ) --clear current {{%s}} Purchased price database
		print(line, "push}} - ".._TRANS('PURC_Help_SlashHelp4'):format(serverKey) ) --force the {{%s}} Purchased daily stats to archive (start a new day)
	elseif (command == _TRANS('clear') ) then
		private.ClearData(...)
	elseif (command == _TRANS('push') ) then
		print(_TRANS('PURC_Help_SlashHelp5'):format(serverKey) ) --Archiving {{%s}} daily stats and starting a new day
		private.PushStats(serverKey)
	end
end

function lib.Processor(callbackType, ...)
	if (callbackType == "tooltip") then
		private.ProcessTooltip(...)
	elseif (callbackType == "config") then
		--Called when you should build your Configator tab.
		private.SetupConfigGui(...)
	elseif callbackType == "scanstats" then
		private.ClearCache()
	end
end

lib.ScanProcessors = {}
function lib.ScanProcessors.delete(operation, itemData, oldData)
	local price

	local auctionmaxtime = Const.AucMinTimes[itemData.timeLeft] or 86400
	if (time() - itemData.seenTime <= auctionmaxtime) then
		-- Auction deleted earlier than expected expiry time
		local buy = itemData.buyoutPrice
		if buy and buy > 0 then
			-- assume bought out
			price = buy
		end
	elseif (itemData.timeLeft <= 1) then     -- Auction deleted later than earliest expected expiry time and was seen close to its end (last 30 mins)
		local bid = itemData.curBid
		if bid and bid > 0 then
			-- assume won on last bid we saw, but since there isn't much more time, it should be close.
			price = bid
		end
	end

	if not price then return end

	price = price / itemData.stackSize

	local pricedata = private.GetPriceData(GetFaction())
	local itemType, itemId, property, factor = decode(itemData.link)
	if (factor ~= 0) then property = property.."x"..factor end
	if not pricedata.daily[itemId] then pricedata.daily[itemId] = "" end
	local stats = private.UnpackStats(pricedata.daily[itemId])
	if not stats[property] then stats[property] = { 0, 0 } end
	stats[property][1] = stats[property][1] + price
	stats[property][2] = stats[property][2] + 1
	pricedata.daily[itemId] = private.PackStats(stats)
end

-- Determines the sample estimated standard deviation based on the deviation
-- of the daily, 3day, 7day, and 14day averages. This is not technically
-- correct because they are not independent samples (the 7 day average
-- includes data from the 3 day and daily averages, for example). Still
-- it provides a good estimation in the presence of lack of data. If you
-- want to discuss the math behind this estimation, find Shirik
-- @param hyperlink The item to look up
-- @param serverKey The realm-faction key from which to look up the data
-- @return The estimated population mean
-- @return The estimated population standard deviation
-- @return The number of views found to base the standard deviation upon

local dataset = {}

function private.EstimateStandardDeviation(hyperlink, serverKey)
	local dayAverage, avg3, avg7, avg14, _, dayTotal, dayCount, seenDays, seenCount = lib.GetPrice(hyperlink, serverKey)

	if not seenDays then return end

    local count = 0
    if dayAverage then --[[dayAverage should never be nil at this point. It may be 0 if item has not been seen today - does that mess up the stats?]]
        count = count + 1
        dataset[count] = dayAverage
    end
    if seenDays >= 3 then
        count = count + 1
        dataset[count] = avg3
        if seenDays >= 7 then
            count = count + 1
            dataset[count] = avg7
            if seenDays >= 14 then
                count = count + 1
                dataset[count] = avg14
           end
        end
    end

    if count == 0 then                               -- No data
         print(_TRANS('PURC_Interface_WarningPurchasedEmpty'):format(hyperlink) )--Warning: Purchased dataset for %s is empty.
        return
    end

    local mean = 0
	for i=1,count do
		mean = mean + dataset[count]
	end
	mean = mean / count

    local variance = 0
	for i=1,count do
        variance = variance + (mean - dataset[count])^2
    end

    return mean, sqrt(variance), count
end


local bellCurve = AucAdvanced.API.GenerateBellCurve();
-- Gets the PDF curve for a given item. This curve indicates
-- the probability of an item's mean price. Uses an estimation
-- of the normally distributed bell curve by performing
-- calculations on the daily, 3-day, 7-day, and 14-day averages
-- stored by SIMP
-- @param hyperlink The item to generate the PDF curve for
-- @param serverKey The realm-faction key from which to look up the data
-- @return The PDF for the requested item, or nil if no data is available
-- @return The lower limit of meaningful data for the PDF (determined
-- as the mean minus 5 standard deviations)
-- @return The upper limit of meaningful data for the PDF (determined
-- as the mean plus 5 standard deviations)
function lib.GetItemPDF(hyperlink, serverKey)
    -- TODO: This is an estimate. Can we touch this up later? Especially the stddev==0 case
    if not get("stat.purchased.enable") then return end --disable purchased if desired

    -- Calculate the SE estimated standard deviation & mean
    local mean, stddev, count = private.EstimateStandardDeviation(hyperlink, serverKey)

    if stddev ~= stddev or mean ~= mean or not mean or mean == 0 then
        return ;                         -- No available data or cannot estimate
    end

    if not count or count == 0 then
	    print(mean)
	    print(stddev)
	    print(count)
	    print(_TRANS('PURC_Interface_CountBroken') ..hyperlink)--count broken! for
	    count = 1
    end
    -- If the standard deviation is zero, we'll have some issues, so we'll estimate it by saying
    -- the std dev is 100% of the mean divided by square root of number of views
    if stddev == 0 then stddev = mean / sqrt(count); end


    -- Calculate the lower and upper bounds as +/- 3 standard deviations
    local lower, upper = mean - 3*stddev, mean + 3*stddev;

    bellCurve:SetParameters(mean, stddev);
    return bellCurve, lower, upper;
end

function lib.GetPrice(hyperlink, serverKey)
	if not get("stat.purchased.enable") then return end --disable purchased if desired
	serverKey = serverKey or GetFaction()

	local data = private.GetPriceData(serverKey)

	local linkType,itemId,property,factor = decode(hyperlink)
	if (linkType ~= "item") then return end
	if (factor ~= 0) then property = property.."x"..factor end

	local cachesig = serverKey..itemId..":"..property
	if pricecache[cachesig] then
		local dayAverage, avg3, avg7, avg14, dayTotal, dayCount, seenDays, seenCount = unpack(pricecache[cachesig], 1, 8)
		return dayAverage, avg3, avg7, avg14, false, dayTotal, dayCount, seenDays, seenCount
	end

	local dayTotal, dayCount, dayAverage = 0,0,0
	local seenDays, seenCount, avg3, avg7, avg14 = 0,0,0,0,0

	if data.daily[itemId] then
		local stats = private.UnpackStats(data.daily[itemId])
		if stats[property] then
			dayTotal, dayCount = unpack(stats[property])
			dayAverage = dayTotal/dayCount
		end
	end
	if data.means[itemId] then
		local stats = private.UnpackStats(data.means[itemId])
		if stats[property] then
			seenDays, seenCount, avg3, avg7, avg14 = unpack(stats[property])
		end
	end
	pricecache[cachesig] = {dayAverage, avg3, avg7, avg14, dayTotal, dayCount, seenDays, seenCount}
	return dayAverage, avg3, avg7, avg14, false, dayTotal, dayCount, seenDays, seenCount
end

function lib.GetPriceColumns()
	return "Daily Avg", "3 Day Avg", "7 Day Avg", "14 Day Avg", false, "Daily Total", "Daily Count", "Seen Days", "Seen Count"
end

local pricearray={} -- used to return stuff in
function lib.GetPriceArray(hyperlink, serverKey)
	if not get("stat.purchased.enable") then return end --disable purchased if desired
	wipe(pricearray)

	-- Get our statistics
	local dayAverage, avg3, avg7, avg14, _, dayTotal, dayCount, seenDays, seenCount = lib.GetPrice(hyperlink, serverKey)

	-- pricearray.price and pricearray.seen are the ones that most algorithms will look for
	pricearray.seen = seenCount
	if not get("stat.purchased.reportsafe") then
		pricearray.price = avg3 or dayAverage
	else
		-- Safe mode: prefer longer-running averages for low-volume items
		if seenCount>100 and seenCount > seenDays*10 then
			pricearray.price = avg3 or dayAverage
			-- print(hyperlink..": seen "..seenCount.." over "..seenDays.. "days. going with avg3")
		else
			local a3 = avg3 or dayAverage
			local a7 = avg7 or a3
			local a14 = avg14 or a7
			if seenCount >= seenDays*7 then
				pricearray.price = (a3+a7)/2
				-- print(hyperlink..": seen "..seenCount.." over "..seenDays.. "days. going with avg(a3,a7)")
			else
				local mix3 = seenCount / (seenDays*7*2) -- 0.07 for 1/1, 0.5 for 7/1
				local mix14 = 0.5-mix3
				local mix7 = 1-mix3-mix14	-- actually always==0.5 :-)
				pricearray.price = a3*mix3 + a7*mix7 + a14*mix14
				-- print(hyperlink..": seen "..seenCount.." over "..seenDays.. "days. mix3="..mix3.." mix7="..mix7.." mix14="..mix14)
			end
		end
	end

	-- This is additional data
	pricearray.avgday = dayAverage
	pricearray.avg3 = avg3
	pricearray.avg7 = avg7
	pricearray.avg14 = avg14
	pricearray.daytotal = dayTotal
	pricearray.daycount = dayCount
	pricearray.seendays = seenDays

	return pricearray
end

function lib.OnLoad(addon)
	if SPRealmData then return end
	-- set defaults
	default("stat.purchased.tooltip", false)
	default("stat.purchased.avg3", false)
	default("stat.purchased.avg7", false)
	default("stat.purchased.avg14", false)
	default("stat.purchased.quantmul", true)
	default("stat.purchased.enable", true)
	default("stat.purchased.reportsafe", false)

	private.InitData()
end

function private.SetupConfigGui(gui)
	local id = gui:AddTab(lib.libName, lib.libType.." Modules")
	--gui:MakeScrollable(id)

	gui:AddHelp(id, "what purchased stats",
		_TRANS('PURC_Help_WhatPurchasedStats') ,--What are purchased stats?
		_TRANS('PURC_Help_WhatPurchasedStatsAnswer') )--Purchased stats are the numbers that are generated by the Purchased module, the Purchased module attempts to determine if an auction was bought out or purchased on a bid.  It also calculates a Moving Average (3/7/14).

	--all options in here will be duplicated in the tooltip frame
	function private.addTooltipControls(id)
		gui:AddHelp(id, "what moving day average purchased",
			_TRANS('PURC_Help_WhatMovingAverage') ,--What does 'moving average' mean?
			_TRANS('PURC_Help_WhatMovingAverageAnswer') )--'Moving average means that it places more value on yesterday\'s moving average than today\'s average.  The determined amount is then used for tomorrow\'s moving average calculation.

		gui:AddHelp(id, "how day average calculated purchased",
			_TRANS('PURC_Help_HowMovingAverage') ,--How is the moving day averages calculated exactly?
			_TRANS('PURC_Help_HowMovingAverageAnswer') )--Todays Moving Average is ((X-1)*YesterdaysMovingAverage + TodaysAverage) / X, where X is the number of days (3,7, or 14).

		gui:AddHelp(id, "no day saved purchased",
			_TRANS('PURC_Help_DayAverage') ,--So you aren\'t saving a day-to-day average?
			_TRANS('PURC_Help_DayAverageAnswer') )--No, that would not only take up space, but heavy calculations on each auction house scan.

		gui:AddHelp(id, "why multiply stack size stddev",
			_TRANS('PURC_Help_MultiplyStack') ,--Why have the option to multiply stack size?
			_TRANS('PURC_Help_MultiplyStackAnswer') )--The original Stat-Purchased multiplied by the stack size of the item, but some like dealing on a per-item basis.

		gui:AddHelp(id, "report safe safer price prices value low volume item items",
			_TRANS('PURC_Help_SaferPrices') ,--How are the \'safer\' prices computed?
			_TRANS('PURC_Help_SaferPricesAnswer') )--For anything seen more than 100 times and selling more than 10 items per day (on average), we simply use the 3 day average.\n\nFor others, we value the 7-day average at 50%, and the 3- and 14-day averages at between 0--50% and 50--0%, respectively, depending on how many are seen per day (between 1 and 7).

		
		gui:AddControl(id, "Header",     0,    libName.." options")
		gui:AddControl(id, "Note",       0, 1, nil, nil, " ")
			
		gui:AddControl(id, "Checkbox",   0, 1, "stat.purchased.enable", _TRANS('PURC_Interface_EnablePurchasedStats') )--Enable Purchased Stats
		gui:AddTip(id, _TRANS('PURC_HelpTooltip_EnablePurchasedStats') )--Allow Stat Purchased to gather and return price data
		gui:AddControl(id, "Note",       0, 1, nil, nil, " ")
		
		gui:AddControl(id, "Checkbox",   0, 4, "stat.purchased.tooltip", _TRANS('PURC_Interface_ShowPurchased') )--Show purchased stats in the tooltips?
		gui:AddTip(id, _TRANS('PURC_HelpTooltip_ShowPurchased') )--Toggle display of stats from the Purchased module on or off
		
		gui:AddControl(id, "Checkbox",   0, 6, "stat.purchased.avg3", _TRANS('PURC_Interface_Toggle3Day') )--Display Moving 3 Day Average
		gui:AddTip(id, _TRANS('PURC_HelpTooltip_Toggle3Day') )--Toggle display of 3-Day average from the Purchased module on or off
		gui:AddControl(id, "Checkbox",   0, 6, "stat.purchased.avg7", _TRANS('PURC_Interface_Toggle7Day') )--Display Moving 7 Day Average
		gui:AddTip(id, _TRANS('PURC_HelpTooltip_Toggle7Day') )--Toggle display of 7-Day average from the Purchased module on or off
		gui:AddControl(id, "Checkbox",   0, 6, "stat.purchased.avg14", _TRANS('PURC_Interface_Toggle14Day') )--Display Moving 14 Day Average
		gui:AddTip(id, _TRANS('PURC_HelpTooltip_Toggle14Day') )--Toggle display of 14-Day average from the Purchased module on or off

		gui:AddControl(id, "Note",       0, 1, nil, nil, " ")

		gui:AddControl(id, "Checkbox",   0, 4, "stat.purchased.reportsafe", _TRANS('PURC_Interface_ReportSaferPrices') )--Report safer prices for low volume items
		gui:AddTip(id, _TRANS('PURC_HelpTooltip_ReportSaferPrices') )--Returns longer averages (7-day, or even 14-day) for low-volume items
		gui:AddControl(id, "Checkbox",   0, 4, "stat.purchased.quantmul", _TRANS('PURC_Interface_MultiplyStack') )--Multiply by Stack Size
		gui:AddTip(id, _TRANS('PURC_HelpTooltip_MultiplyStack') )--Multiplies by current Stack Size if on
		gui:AddControl(id, "Note",       0, 1, nil, nil, " ")
	end
	--This is the Tooltip tab provided by aucadvnced so all tooltip configuration is in one place
	local tooltipID = AucAdvanced.Settings.Gui.tooltipID
	
	--now we create a duplicate of these in the tooltip frame
	private.addTooltipControls(id)
	if tooltipID then private.addTooltipControls(tooltipID) end

end

--[[ Local functions ]]--
function private.ProcessTooltip(tooltip, name, hyperlink, quality, quantity, cost)
	if not get("stat.purchased.tooltip") then return end

	if not quantity or quantity < 1 then quantity = 1 end
	if not get("stat.purchased.quantmul") then quantity = 1 end
	local dayAverage, avg3, avg7, avg14, _, dayTotal, dayCount, seenDays, seenCount = lib.GetPrice(hyperlink)
	if (not dayAverage) then return end

	if (seenDays + dayCount > 0) then
		tooltip:AddLine(_TRANS('PURC_Tooltip_PurchasedPrices'))--Purchased prices:

		if (seenDays > 0) then
			if (dayCount>0) then seenDays = seenDays + 1 end
			tooltip:AddLine("  ".._TRANS('PURC_Tooltip_SeenNumberDays'):format(seenCount+dayCount, seenDays) )--Seen {{%s}} over {{%s}} days:
		end
		if (seenDays > 6) and get("stat.purchased.avg14") then
			tooltip:AddLine("  ".._TRANS('PURC_Tooltip_14DayAverage'), avg14*quantity)-- 14 day average
		end
		if (seenDays > 2) and get("stat.purchased.avg7") then
			tooltip:AddLine("  ".._TRANS('PURC_Tooltip_7DayAverage'), avg7*quantity)-- 7 day average
		end
		if (seenDays > 0) and get("stat.purchased.avg3") then
			tooltip:AddLine("  ".._TRANS('PURC_Tooltip_3DayAverage'), avg3*quantity)-- 3 day average
		end
		if (dayCount > 0) then
			tooltip:AddLine("  ".._TRANS('PURC_Tooltip_SeenToday'):format(dayCount), dayAverage*quantity)--Seen {{%s}} today
		end
	end
end

-- This is a function which migrates the data from a daily average to the
-- Exponential Moving Averages over the 3, 7 and 14 day ranges.
function private.PushStats(serverKey)
	local dailyAvg

	local data = private.GetPriceData(serverKey)

	local pdata, fdata
	for itemId, stats in pairs(data.daily) do
		if (itemId ~= "created") then
			pdata = private.UnpackStats(stats)
			fdata = private.UnpackStats(data.means[itemId] or "")
			for property, info in pairs(pdata) do
				dailyAvg = info[1] / info[2]
				if not fdata[property] then
					fdata[property] = {
						1,
						info[2],
						("%0.01f"):format(dailyAvg),
						("%0.01f"):format(dailyAvg),
						("%0.01f"):format(dailyAvg),
					}
				else
					fdata[property][1] = fdata[property][1] + 1
					fdata[property][2] = fdata[property][2] + info[2]
					fdata[property][3] = ("%0.01f"):format(((fdata[property][3] * 2) + dailyAvg)/3)
					fdata[property][4] = ("%0.01f"):format(((fdata[property][4] * 6) + dailyAvg)/7)
					fdata[property][5] = ("%0.01f"):format(((fdata[property][5] * 13) + dailyAvg)/14)
				end
			end
			data.means[itemId] = private.PackStats(fdata)
		end
	end
	data.daily = { created = time() }
	private.ClearCache()
end

function private.UnpackStatIter(data, ...)
	local c = select("#", ...)
	local v
	for i = 1, c do
		v = select(i, ...)
		local property, info = strsplit(":", v)
		property = tonumber(property) or property
		if (property and info) then
			data[property] = { strsplit(";", info) }
			local item
			for i=1, #data[property] do
				item = data[property][i]
				data[property][i] = tonumber(item) or item
			end
		end
	end
end

function private.UnpackStats(dataItem)
	local data = {}
	private.UnpackStatIter(data, strsplit(",", dataItem))
	return data
end

local tmp={}
function private.PackStats(data)
	local n=0
	for property, info in pairs(data) do
		tmp[n+1]=property
		tmp[n+2]=":"
		tmp[n+3]=concat(info, ";")
		tmp[n+4]=","
		n=n+4
	end
	return concat(tmp, "", 1, n-1)   -- n-1 to skip last ","
end

-- The following Functions are the routines used to access the permanent store data

function private.UpgradeDb()
	private.UpgradeDb = nil
	if type(AucAdvancedStatPurchasedData) == "table" and AucAdvancedStatPurchasedData.Version == "2.0" then return end

	local newSave = { Version = "2.0", RealmData = {} }

	if type(AucAdvancedStatPurchasedData) == "table" and AucAdvancedStatPurchasedData.Version == "1.0" then
		-- convert from type "1.0" database to type "2.0"
		for realm, realmData in pairs (AucAdvancedStatPurchasedData.RealmData) do
			if type(realm) == "string" and type(realmData) == "table" then
				for faction, data in pairs (realmData) do
					if type(faction) == "string" and type(data) == "table" and strmatch(faction, "^%u%l+$") then
						-- looks like a valid realm/faction combination
						local serverKey = realm.."-"..faction
						local stats = data.stats
						if type(stats) == "table" then
							if type(data.means) ~= "table" then
								data.means = {}
							end
							if type(data.daily) ~= "table" then
								data.daily = { created = time () }
							elseif type(data.daily.created) ~= "number" then
								data.daily.created = time ()
							end
							newSave.RealmData[serverKey] = stats
						end
					end
				end
			end
		end
	end

	AucAdvancedStatPurchasedData = newSave
end

function private.ClearData(serverKey)
	serverKey = serverKey or GetFaction()
	if SPRealmData[serverKey] then
		print(_TRANS('PURC_Interface_ClearingPurchased').." {{"..serverKey.."}}")--Clearing Purchased stats for
		SPRealmData[serverKey] = nil
		private.ClearCache()
	end
end

function lib.ClearItem(hyperlink, serverKey)
	local linkType,itemID,property,factor = decode(hyperlink)
	if (linkType ~= "item") then return end
	if (factor and factor ~= 0) then property = property.."x"..factor end

	serverKey = serverKey or GetFaction ()

	local data = private.GetPriceData(serverKey)

	local cleareditem = false

	if data.daily[itemID] then
		local stats = private.UnpackStats (data.daily[itemID])
		if stats[property] then
			stats[property] = nil
			cleareditem = true
			data.daily[itemID] = private.PackStats (stats)
		end
	end

	if data.means[itemID] then
		local stats = private.UnpackStats (data.means[itemID])
		if stats[property] then
			stats[property] = nil
			cleareditem = true
			data.means[itemID] = private.PackStats (stats)
		end
	end

	if cleareditem then
		print(_TRANS('PURC_Interface_ClearingPurchasedLink'):format(hyperlink, serverKey) )--Stat - Purchased: clearing data for {{%s}} for {{%s}}
		private.ClearCache()
	end
end

function private.GetPriceData(serverKey)
	local data = SPRealmData[serverKey]
	if not data then
		if type(serverKey) ~= "string" or not strmatch(serverKey, ".%-%u%l") then
			error("Invalid serverKey passed to Stat-Purchased")
		end
		data = {means = {}, daily = {created = time()}}
		SPRealmData[serverKey] = data
	end
	return data
end

function private.InitData()
	private.InitData = nil

	-- Load Data
	private.UpgradeDb()
	SPRealmData = AucAdvancedStatPurchasedData.RealmData
	if not SPRealmData then
		SPRealmData = {} -- dummy table to avoid errors in future events; data will not be saved
		error("Error loading or creating Stat-Purchased database")
	end

	-- Data maintenance
	for serverKey, data in pairs(SPRealmData) do
		if type(serverKey) ~= "string" or not strmatch(serverKey, ".%-%u%l") then
			-- not a valid serverKey - remove it
			SPRealmData[serverKey] = nil
		else
			-- lots of checks to make sure we ONLY have valid data in this table
			for key, _ in pairs (data) do
				if key ~= "means" and key ~= "daily" then
					data[key] = nil
				end
			end
			if type(data.means) == "table" then
				for id, packed in pairs(data.means) do
					if type(id) ~= "number" or type(packed) ~= "string" then
						data.means[id] = nil
					end
				end
			else
				data.means = {}
			end
			if type(data.daily) == "table" then
				for id, packed in pairs(data.daily) do
					if id ~= "created" and (type(id) ~= "number" or type(packed) ~= "string") then
						data.daily[id] = nil
					end
				end
				if type(data.daily.created) ~= "number" then
					data.daily.created = time()
				end
			else
				data.daily = {created = time()}
			end

			if time() - data.daily.created > 3600*16 then
				-- This data is more than 16 hours old, we classify this as "yesterday's data"
				private.PushStats(serverKey)
			end
		end
	end
end

AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Auc-Stat-Purchased/StatPurchased.lua $", "$Rev: 4640 $")
