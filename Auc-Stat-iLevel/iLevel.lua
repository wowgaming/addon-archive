--[[
	Auctioneer - iLevel Standard Deviation Statistics module
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: iLevel.lua 4640 2010-01-26 02:18:04Z Nechckn $
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

local libType, libName = "Stat", "iLevel"
local lib,parent,private = AucAdvanced.NewModule(libType, libName)
if not lib then return end
local print,decode,_,_,replicate,_,get,set,default,debugPrint,fill, _TRANS = AucAdvanced.GetModuleLocals()

local select,next,pairs,ipairs,type,unpack,wipe = select,next,pairs,ipairs,type,unpack,wipe
local tonumber,tostring,strsplit,strjoin = tonumber,tostring,strsplit,strjoin
local floor,abs,max = floor,abs,max
local concat = table.concat
local strmatch = strmatch

local EquipEncode = AucAdvanced.Const.EquipEncode
local GetFaction = AucAdvanced.GetFaction

local KEEP_NUM_POINTS = 250

local ZValues = {.063, .126, .189, .253, .319, .385, .454, .525, .598, .675, .756, .842, .935, 1.037, 1.151, 1.282, 1.441, 1.646, 1.962, 20, 20000}

function lib.CommandHandler(command, ...)
	local serverKey = GetFaction()
	if (command == "help") then
		print(_TRANS('ILVL_Help_SlashHelp1') )--Help for Auctioneer Advanced - iLevel
		local line = AucAdvanced.Config.GetCommandLead(libType, libName)
		print(line, "help}} - ".._TRANS('ILVL_Help_SlashHelp2') ) -- this iLevel help
		print(line, "clear}} - ".._TRANS('ILVL_Help_SlashHelp3'):format(serverKey) ) --clear current %s iLevel price database
	elseif (command ==_TRANS( 'clear') ) then
		print(_TRANS('ILVL_Help_SlashHelp5').." {{", serverKey, "}}") --Clearing iLevel stats for
		private.ClearData(serverKey)
	end
end

function lib.Processor(callbackType, ...)
	if (callbackType == "tooltip") then
		lib.ProcessTooltip(...)
	elseif (callbackType == "config") then
		if private.SetupConfigGui then -- only call it once
			private.SetupConfigGui(...)
		end
	elseif (callbackType == "scanstats") then
		private.ResetCache()
		private.RepackStats()
	end
end

lib.ScanProcessors = {}
function lib.ScanProcessors.create(operation, itemData, oldData)
	if not get("stat.ilevel.enable") then return end
	-- This function is responsible for processing and storing the stats after each scan
	-- Note: itemData gets reused over and over again, so do not make changes to it, or use
	-- it in places where you rely on it. Make a deep copy of it if you need it after this
	-- function returns.

	-- We're only interested in items with buyouts.
	local buyout = itemData.buyoutPrice
	if not buyout or buyout == 0 then return end
	if (itemData.stackSize > 1) then
		buyout = buyout.."/"..itemData.stackSize
	end

	-- Get the signature of this item and find it's stats.
	local iLevel, quality, equipPos = itemData.itemLevel, itemData.quality, itemData.equipPos
	if quality < 1 then return end
	if not equipPos then return end
	if equipPos < 1 then return end
	local itemSig = ("%d:%d"):format(equipPos, quality)

	local serverKey = GetFaction()
	local stats = private.GetUnpackedStats(serverKey, itemSig, true) -- read/write
	if not stats[iLevel] then stats[iLevel] = {} end
    local sz = #stats[iLevel]
	stats[iLevel][sz+1] = buyout
end

local BellCurve = AucAdvanced.API.GenerateBellCurve();
-----------------------------------------------------------------------------------
-- The PDF for standard deviation data, standard bell curve
-----------------------------------------------------------------------------------
function lib.GetItemPDF(hyperlink, serverKey)
	if not get("stat.ilevel.enable") then return end
	-- Get the data
	local average, mean, _, stddev, variance, count, confidence = lib.GetPrice(hyperlink, serverKey)

	if not (average and stddev) or average == 0 or stddev == 0 then
		return nil;                 -- No data, cannot determine pricing
	end

	local lower, upper = average - 3 * stddev, average + 3 * stddev;

	-- Build the PDF based on standard deviation & average
	BellCurve:SetParameters(average, stddev);
	return BellCurve, lower, upper;   -- This has a __call metamethod so it's ok
end

-----------------------------------------------------------------------------------

function private.GetCfromZ(Z)
	--C = 0.05*i
	if (not Z) then
		return .05
	end
	if (Z > 10) then
		return .99
	end
	local i = 1
	while Z > ZValues[i] do
		i = i + 1
	end
	if i == 1 then
		return .05
	else
		i = i - 1 + ((Z - ZValues[i-1]) / (ZValues[i] - ZValues[i-1]))
		return i*0.05
	end
end

local weakmeta = {__mode="kv"}
local pricecache = setmetatable({}, weakmeta)
function private.ResetCache()
	wipe(pricecache)
end

local datapoints_price = {}   -- used temporarily in .GetPrice() to avoid unpacking strings multiple times
local datapoints_stack = {}

function lib.GetPrice(hyperlink, serverKey)
	if not get("stat.ilevel.enable") then return end
	local itemSig, iLevel = private.GetItemDetail(hyperlink)
	if not itemSig then return end
	if not serverKey then serverKey = GetFaction() end

	local average, mean, stdev, variance, count, confidence

	local cacheSig = serverKey..itemSig..";"..iLevel
	if pricecache[cacheSig] then
		average, mean, stdev, variance, count, confidence = unpack(pricecache[cacheSig], 1, 6)
		return average, mean, false, stdev, variance, count, confidence
	end

	local stats = private.GetUnpackedStats(serverKey, itemSig) -- read only
	if not stats[iLevel] then return end

	count = #stats[iLevel]
	if (count < 1) then return end

	local total, number = 0, 0
	for i = 1, count do
		local price, stack = strsplit("/", stats[iLevel][i])
		price = tonumber(price) or 0
		stack = tonumber(stack) or 1
		if (stack < 1) then stack = 1 end
		datapoints_price[i] = price
		datapoints_stack[i] = stack
		total = total + tonumber(price)
		number = number + stack
	end
	mean = total / number

	if (count < 2) then return 0,0,0, mean, count end

	variance = 0
	for i = 1, count do
		variance = variance + ((mean - datapoints_price[i]/datapoints_stack[i]) ^ 2);
	end

	variance = variance / count;
	stdev = variance ^ 0.5

	local deviation = 1.5 * stdev
	total = 0	-- recomputing with only data within deviation
	number = 0

	for i = 1, count do
		local price,stack = datapoints_price[i], datapoints_stack[i]
		if abs((price/stack) - mean) < deviation then
			total = total + price
			number = number + stack
		end
	end

	confidence = .01
	if (number > 0) then	-- number<1  will happen if we have e.g. two big clusters: one at 1g and one at 10g
		average = total / number
		confidence = (.15*average)*(number^0.5)/(stdev)
		confidence = private.GetCfromZ(confidence)
	end
	pricecache[cacheSig] = {average, mean, stdev, variance, count, confidence}
	return average, mean, false, stdev, variance, count, confidence
end

function lib.GetPriceColumns()
	return "Average", "Mean", false, "Std Deviation", "Variance", "Count", "Confidence"
end

local array = {}
function lib.GetPriceArray(hyperlink, serverKey)
	if not get("stat.ilevel.enable") then return end
	-- Clean out the old array
	wipe(array)

	-- Get our statistics
	local average, mean, _, stdev, variance, count, confidence = lib.GetPrice(hyperlink, serverKey)

	-- These 3 are the ones that most algorithms will look for
	array.price = average or mean
	array.seen = 0
	array.confidence = confidence
	-- This is additional data
	array.normalized = average
	array.mean = mean
	array.deviation = stdev
	array.variance = variance
	array.processed = count

	-- Return a temporary array. Data in this array is
	-- only valid until this function is called again.
	return array
end

function private.SetupConfigGui(gui)
	private.SetupConfigGui = nil
	local id = gui:AddTab(lib.libName, lib.libType.." Modules")
	--gui:MakeScrollable(id)

	gui:AddHelp(id, "what ilevel stats",
		_TRANS('ILVL_Help_WhatIlevelStats') ,--What are ilevel stats?
		_TRANS('ILVL_Help_WhatIlevelStatsAnswer') )--ilevel stats are the numbers that are generated by the iLevel module consisting of a filtered Standard Deviation calculation of item cost.

	gui:AddHelp(id, "filtered ilevel",
		_TRANS('ILVL_Help_WhatFiltered') ,--What do you mean filtered?
		_TRANS('ILVL_Help_WhatFilteredAnswer') )--Items outside a (1.5*Standard) variance are ignored and assumed to be wrongly priced when calculating the deviation.

	--all options in here will be duplicated in the tooltip frame
	function private.addTooltipControls(id)
		gui:AddHelp(id, "what standard deviation",
			_TRANS('ILVL_Help_WhatStdDev') ,--What is a Standard Deviation calculation?
			_TRANS('ILVL_Help_WhatStdDevAnswer') )--In short terms, it is a distance to mean average calculation.

		gui:AddHelp(id, "what normalized",
			_TRANS('ILVL_Help_WhatNormalized') ,--What is the Normalized calculation?
			_TRANS('ILVL_Help_WhatNormalizedAnswer') )--In short terms again, it is the average of those values determined within the standard deviation variance calculation.

		gui:AddHelp(id, "what confidence",
			_TRANS('ILVL_Help_WhatConfidence') ,--What does confidence mean?
			_TRANS('ILVL_Help_WhatConfidenceAnswer') )--Confidence is a value between 0 and 1 that determines the strength of the calculations (higher the better).

		gui:AddHelp(id, "why multiply stack size ilevel",
			_TRANS('ILVL_Help_WhyStackSize') ,--Why have the option to multiply by stack size?
			_TRANS('ILVL_Help_WhyStackSizeAnswer') )--The original Stat-ilevel multiplied by the stack size of the item, but some like dealing on a per-item basis.

		gui:AddControl(id, "Header",     0,   _TRANS('ILVL_Interface_IlevelOptions') )--ilevel options
		gui:AddControl(id, "Note",       0, 1, nil, nil, " ")
		gui:AddControl(id, "Checkbox",   0, 1, "stat.ilevel.enable", _TRANS('ILVL_Interface_EnableILevelStats') )--Enable iLevel Stats
		gui:AddTip(id, _TRANS('ILVL_HelpTooltip_EnableILevelStats') )--Allow iLevel to gather and return price data
		gui:AddControl(id, "Note",       0, 1, nil, nil, " ")

		gui:AddControl(id, "Checkbox",   0, 4, "stat.ilevel.tooltip", _TRANS('ILVL_Interface_ShowiLevel') )--Show iLevel stats in the tooltips?
		gui:AddTip(id, _TRANS('ILVL_HelpTooltip_ShowiLevel') )--Toggle display of stats from the iLevel module on or off
		gui:AddControl(id, "Checkbox",   0, 6, "stat.ilevel.mean", _TRANS('ILVL_Interface_DisplayMean') )--Display Mean
		gui:AddTip(id, _TRANS('ILVL_HelpTooltip_DisplayMean') )--Toggle display of 'Mean' calculation in tooltips on or off
		gui:AddControl(id, "Checkbox",   0, 6, "stat.ilevel.normal", _TRANS('ILVL_Interface_DisplayNormalized') )--Display Normalized'
		gui:AddTip(id, _TRANS('ILVL_HelpTooltip_DisplayNormalized') )--Toggle display of \'Normalized\' calculation in tooltips on or off
		gui:AddControl(id, "Checkbox",   0, 6, "stat.ilevel.stdev", _TRANS('ILVL_Interface_DisplayStdDeviation') )--Display Standard Deviation
		gui:AddTip(id, _TRANS('ILVL_HelpTooltip_DisplayStdDeviation') )--Toggle display of \'Standard Deviation\' calculation in tooltips on or off
		gui:AddControl(id, "Checkbox",   0, 6, "stat.ilevel.confid", _TRANS('ILVL_Interface_DisplayConfidence') )--Display Confidence
		gui:AddTip(id, _TRANS('ILVL_HelpTooltip_DisplayConfidence') )--Toggle display of \'Confidence\' calculation in tooltips on or off
		gui:AddControl(id, "Note",       0, 1, nil, nil, " ")
		gui:AddControl(id, "Checkbox",   0, 4, "stat.ilevel.quantmul", _TRANS('ILVL_Interface_MultiplyStack') )--Multiply by Stack Size
		gui:AddTip(id, _TRANS('ILVL_HelpTooltip_MultiplyStack') )--Multiplies by current stack size if on
		gui:AddControl(id, "Note",       0, 1, nil, nil, " ")
	end
	--This is the Tooltip tab provided by Auctioneer so all tooltip configuration is in one place
	local tooltipID = AucAdvanced.Settings.Gui.tooltipID

	--now we create a duplicate of these in the tooltip frame
	private.addTooltipControls(id)
	if tooltipID then private.addTooltipControls(tooltipID) end
end

function lib.ProcessTooltip(tooltip, name, hyperlink, quality, quantity, cost, ...)
	if not get("stat.ilevel.tooltip") then return end

	if not quantity or quantity < 1 then quantity = 1 end
	if not get("stat.ilevel.quantmul") then quantity = 1 end
	local average, mean, _, stdev, var, count, confidence = lib.GetPrice(hyperlink)

	if (mean and mean > 0) then
		tooltip:SetColor(0.3, 0.9, 0.8)

		tooltip:AddLine(_TRANS('ILVL_Tooltip_iLevelPrices'):format(count) )--iLevel prices (%s points):

		if get("stat.ilevel.mean") then
			tooltip:AddLine("  ".._TRANS('ILVL_Tooltip_MeanPrice') , mean*quantity)--Mean price
		end
		if (average and average > 0) then
			if get("stat.ilevel.normal") then
				tooltip:AddLine("  ".._TRANS('ILVL_Tooltip_Normalized') , average*quantity)--Normalized
				if (quantity > 1) then
					tooltip:AddLine("  ".._TRANS('ILVL_Tooltip_Individually') , average)--(or individually)
				end
			end
			if get("stat.ilevel.stdev") then
				tooltip:AddLine("  ".._TRANS('ILVL_Tooltip_StdDeviation') , stdev*quantity)--Std Deviation
                if (quantity > 1) then
                    tooltip:AddLine("  ".._TRANS('ILVL_Tooltip_Individually') , stdev)--(or individually)
                end

			end
			if get("stat.ilevel.confid") then
				tooltip:AddLine("  ".._TRANS('ILVL_Tooltip_Confidence'):format((floor(confidence*1000))/1000) )--Confidence: %s
			end
		end
	end
end

function lib.OnLoad(addon)
	default("stat.ilevel.tooltip", false)
	default("stat.ilevel.mean", false)
	default("stat.ilevel.normal", false)
	default("stat.ilevel.stdev", true)
	default("stat.ilevel.confid", true)
	default("stat.ilevel.quantmul", true)
	default("stat.ilevel.enable", true)
	if private.InitData then private.InitData() end
end

function lib.ClearItem(hyperlink, serverKey)
	local itemSig, iLevel, equipPos, quality = private.GetItemDetail(hyperlink)
	if not itemSig then return end

	if not serverKey then serverKey = GetFaction() end
	local stats = private.GetUnpackedStats(serverKey, itemSig, true)
	if stats[iLevel] then
		print(_TRANS('ILVL_Interface_ClearingItems'):format(iLevel, quality, equipPos, serverKey))--Stat-iLevel: clearing data for iLevel=%d/quality=%d/equip=%d items for {{%s}}
		stats[iLevel] = nil
		private.RepackStats()
		private.ResetCache()
		return
	end
	print(_TRANS('ILVL_Interface_ItemNotFound') )--Stat-iLevel: item is not in database
end

--[[ Internal functions ]]--

local ILRealmData
local unpacked, updated = {}, {}

function private.InitData()
	private.InitData = nil
	if not AucAdvancedStat_iLevelData then AucAdvancedStat_iLevelData = {} end
	ILRealmData = AucAdvancedStat_iLevelData

end

function private.ClearData(serverKey)
	ILRealmData[serverKey] = nil
	unpacked[serverKey] = nil
end

--[[
itemSig, iLevel, equipPos, quality = GetItemDetail(hyperlink)
--]]
function private.GetItemDetail(hyperlink)
	if type(hyperlink) ~= "string" then return end
	if not hyperlink:match("item:%d") then return end

	local _,_, quality, iLevel, _,_,_,_, equipPos = GetItemInfo(hyperlink)
	if not quality or quality < 1 then return end
	equipPos = EquipEncode[equipPos]
	if not equipPos then return end
	local itemSig = ("%d:%d"):format(equipPos, quality)

	return itemSig, iLevel, equipPos, quality
end

--[[
stats = GetUnpackedStats (serverKey, itemSig, writing)
Obtain a cached data table for itemSig in serverKey's data.
Set writing to true if you intend to change the data
Caution: if you set 'writing' to true, RepackStats() must be called before the end of the session to save the changes
--]]
function private.GetUnpackedStats(serverKey, itemSig, writing)
	local stats = unpacked[serverKey] and unpacked[serverKey][itemSig]
	if stats then
		if writing then
			updated[stats] = true
		end
		return stats
	end

	local realmdata = ILRealmData[serverKey]
	if not realmdata then
		if type(serverKey) ~= "string" or not strmatch(serverKey, ".%-%u%l") then
			error("Invalid serverKey passed to Stat-iLevel")
		end
		realmdata = {}
		ILRealmData[serverKey] = realmdata
	end

	stats = private.UnpackStats(realmdata, itemSig)

	if not unpacked[serverKey] then unpacked[serverKey] = {} end
	unpacked[serverKey][itemSig] = stats
	if writing then
		updated[stats] = true
	end

	return stats
end

--[[
RepackStats()
Write any changed tables in the unpacked cache back to ILRealmData
--]]
function private.RepackStats()
	for serverKey, realmData in pairs(unpacked) do
		for item, stats in pairs(realmData) do
			if updated[stats] then
				local packed = private.PackStats(stats)
				if packed == "" then
					ILRealmData[serverKey][item] = nil -- delete empty entries from the database
				else
					ILRealmData[serverKey][item] = packed
				end
			end
		end
	end
	updated = {}
end

--[[ Subfunctions ]]--

function private.UnpackStatIter(data, ...)
	local c = select("#", ...)
	local v
	for i = 1, c do
		v = select(i, ...)
		local property, info = strsplit(":", v)
		property = tonumber(property) or property
		if (property and info) then
			local t= {strsplit(";", info)}
			for k,v in ipairs(t) do
				t[k] = tonumber(v) or v
			end
			data[property] = t
		end
	end
end
function private.UnpackStats(data, item)
	local stats = {}
	if (data and data[item]) then
		private.UnpackStatIter(stats, strsplit(",", data[item]))
	end
	return stats
end
local tmp={}
function private.PackStats(data)
	local ntmp=0
	for property, info in pairs(data) do
		ntmp=ntmp+1
		local n = max(1, #info - KEEP_NUM_POINTS + 1)
        tmp[ntmp] = property..":"..concat(info, ";", n)
	end
	return concat(tmp, ",", 1, ntmp)
end

AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Auc-Stat-iLevel/iLevel.lua $", "$Rev: 4640 $")
