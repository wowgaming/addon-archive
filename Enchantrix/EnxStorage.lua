--[[
	Enchantrix Addon for World of Warcraft(tm).
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: EnxStorage.lua 3767 2008-11-05 17:57:29Z Norganna $
	URL: http://enchantrix.org/

	Database functions and saved variables.

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
]]
Enchantrix_RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Enchantrix/EnxStorage.lua $", "$Rev: 3767 $")

--[[
Usages:
  Enchantrix.Storage["4:2:4:1234"] = { [5432] = { 10, 20 } }
  print(Enchantrix.Storage["4:2:4"])
]]


-- Global functions
local getItemDisenchants			-- Enchantrix.Storage.GetItemDisenchants()
local getItemDisenchantTotals		-- Enchantrix.Storage.GetItemDisenchantTotals()
local getItemDisenchantFromTable	-- Enchantrix.Storage.GetItemDisenchantFromTable()
local getItemDisenchantFromTableForOneMaterial	-- Enchantrix.Storage.GetItemDisenchantFromTableForOneMaterial()
local saveDisenchant				-- Enchantrix.Storage.SaveDisenchant()
local addonLoaded					-- Enchantrix.Storage.AddonLoaded()
local saveNonDisenchantable			-- Enchantrix.Storage.SaveNonDisenchantable()

local saveProspect					-- Enchantrix.Storage.SaveProspect()
local getItemProspects				-- Enchantrix.Storage.GetItemProspects()
local getItemProspectTotals			-- Enchantrix.Storage.GetItemProspectTotals()

local saveMilling					-- Enchantrix.Storage.SaveMilling
local getItemMilling				-- Enchantrix.Storage.GetItemMilling()
local getItemMillingTotals			-- Enchantrix.Storage.GetItemMillingTotals()


-- Local functions
local unserialize
local serialize
local normalizeDisenchant
local mergeDisenchant
local mergeDisenchantLists

local tooltip = LibStub("nTipHelper:1")

-- Database

local N_DISENCHANTS = 1
local N_REAGENTS = 2


function unserialize(str)
	-- Break up a disenchant string to a table for easy manipulation
	local tbl = {}
	if type(str) == "string" then
		for de in Enchantrix.Util.Spliterator(str, ";") do
			local id, d, r = de:match("(%d+):(%d+):(%d+)")
			id, d, r = tonumber(id), tonumber(d), tonumber(r)
			if (id and d > 0 and r > 0) then
				tbl[id] = {[N_DISENCHANTS] = d, [N_REAGENTS] = r}
			end
		end
	end
	return tbl
end

function serialize(tbl)
	-- Serialize a table into a string
	if type(tbl) == "table" then
		local str
		for id, counts in pairs(tbl) do
			if (type(id) == "number" and counts[N_DISENCHANTS] > 0 and counts[N_REAGENTS] > 0) then
				if (str) then
					str = ("%s;%d:%d:%d:0"):format(str, id, counts[N_DISENCHANTS], counts[N_REAGENTS])
				else
					str = ("%d:%d:%d:0"):format(id, counts[N_DISENCHANTS], counts[N_REAGENTS])
				end
			end
		end
		return str
	end
end

function mergeDisenchant(str1, str2)
	-- Merge two disenchant strings into a single string
	local tbl1, tbl2 = unserialize(str1), unserialize(str2)
	for id, counts in pairs(tbl2) do
		if (not tbl1[id]) then
			tbl1[id] = counts
		else
			tbl1[id][N_DISENCHANTS] = tbl1[id][N_DISENCHANTS] + counts[N_DISENCHANTS]
			tbl1[id][N_REAGENTS] = tbl1[id][N_REAGENTS] + counts[N_REAGENTS]
		end
	end
	return serialize(tbl1)
end

function normalizeDisenchant(str)
	-- Divide all counts in disenchant string by gcd
	local div = 0
	local count = 0
	local tbl = unserialize(str)
	for id, counts in pairs(tbl) do
		div = Enchantrix.Util.GCD(div, counts[N_DISENCHANTS])
		div = Enchantrix.Util.GCD(div, counts[N_REAGENTS])
		count = count + 1
	end
	-- Only normalize if there's more than one kind of reagent
	if count > 1 then
		for id, counts in pairs(tbl) do
			counts[N_DISENCHANTS] = counts[N_DISENCHANTS] / div
			counts[N_REAGENTS] = counts[N_REAGENTS] / div
		end
		return serialize(tbl)
	end
	return str
end


function mergeDisenchantLists()

-- DisenchantList no longer exists
-- it used to be merged in here

--[[
	-- Merge items from EnchantedLocal into EnchantedItemTypes
	-- now only useful to developers

	EnchantedItemTypes = {}
	for sig, disenchant in pairs(EnchantedLocal) do
		local item = Enchantrix.Util.GetItemIdFromSig(sig)
		local itype = Enchantrix.Util.GetItemType(item)
		if itype then
			EnchantedItemTypes[itype] = mergeDisenchant(EnchantedItemTypes[itype], disenchant)
		end
	end
]]

	-- now we need to merge the user non-disenchantables with the default non-disenchantables
	if not NonDisenchantablesLocal then NonDisenchantablesLocal = {} end
	for sig, value in pairs(NonDisenchantablesLocal) do
		NonDisenchantables[sig] = value;
	end

	-- Take out the trash
	collectgarbage("collect")

end


function saveDisenchant(sig, reagentID, count)
	-- Update tables after a disenchant has been detected
	assert(type(sig) == "string");
	assert(tonumber(reagentID));
	assert(tonumber(count));

	local id = Enchantrix.Util.GetItemIdFromSig(sig)
	local itype = Enchantrix.Util.GetIType(id)

	local disenchant = ("%d:1:%d:0"):format(reagentID, count)
	EnchantedLocal[sig] = mergeDisenchant(EnchantedLocal[sig], disenchant)
	if itype then
		EnchantedItemTypes[itype] = mergeDisenchant(EnchantedItemTypes[itype], disenchant)
	end
end



-- for this, we need to pass in a list of reagents
function saveProspect(sig, reagentList )
	-- Update tables after a prospect has been detected
	assert(type(sig) == "string");

	local id = Enchantrix.Util.GetItemIdFromSig(sig)
	if (not ProspectedLocal[id]) then
		ProspectedLocal[id] = {}
		ProspectedLocal[id].total = 0;
	end

	ProspectedLocal[id].total = ProspectedLocal[id].total + 1;
	for reagentID, quantity in pairs( reagentList ) do
		if (not ProspectedLocal[id][reagentID]) then
			ProspectedLocal[id][reagentID] = 0;
		end
		ProspectedLocal[id][reagentID] = ProspectedLocal[id][reagentID] + quantity;
	end
end

-- this will return nil for anything that is not prospectable
function getItemProspects(link)
	local itemType, itemID = tooltip:DecodeLink(link)
	if (itemType ~= "item") then return end

	return Enchantrix.Constants.ProspectableItems[ itemID ];
end



-- for this, we need to pass in a list of reagents
function saveMilling(sig, reagentList )
	-- Update tables after a prospect has been detected
	assert(type(sig) == "string");

	local id = Enchantrix.Util.GetItemIdFromSig(sig)
	if (not MillingLocal[id]) then
		MillingLocal[id] = {}
		MillingLocal[id].total = 0;
	end

	MillingLocal[id].total = MillingLocal[id].total + 1;
	for reagentID, quantity in pairs( reagentList ) do
		if (not MillingLocal[id][reagentID]) then
			MillingLocal[id][reagentID] = 0;
		end
		MillingLocal[id][reagentID] = MillingLocal[id][reagentID] + quantity;
	end
end

-- this will return nil for anything that is not millable

--- ccox - WOTLK - this needs to use item level not just item->result
-- similar code in EnxTooltip.lua / millingTooltip

function getItemMilling(link)
	local itemType, itemID = tooltip:DecodeLink(link)
	if (itemType ~= "item") then return end

	local resultGroup = Enchantrix.Constants.MillableItems[ itemID ];
	if not resultGroup then
		return nil
	end
	return Enchantrix.Constants.MillGroupYields[ resultGroup ];
end


function getItemDisenchants(link)
	local iType

	if (type(link) == "string") then
		-- link format:   item number, enchant, dk, dk, dk, dk, random unique id
		local id = link:match("(%d+):%d+:%d+:%d+:%d+:%d+:%d+:%d+")
		id = tonumber(id)
		if (id) then
			iType = Enchantrix.Util.GetIType("item:"..id..":0:0:0:0:0:0:0")
		else
			iType = Enchantrix.Util.GetIType(link)
		end
	else
		-- probably a number
		iType = Enchantrix.Util.GetIType(link)
	end

	if (not iType) then
		-- NOTE - ccox - GetIType can return nil for items that are not disenchantable
		-- a nil result does not mean that we could not find the IType
		return nil
	end

	-- see if it is on our non-disenchantable list
	if type(link) == "string" then
		sig = Enchantrix.Util.GetSigFromLink(link);
	else
		local _, sLink = GetItemInfo(link);
		sig = Enchantrix.Util.GetSigFromLink(sLink);
	end

	if (NonDisenchantables[sig]) then
		return nil
	end

	local data = Enchantrix.Storage[iType]
	if not data then
		-- we really should have data
		Enchantrix.Util.DebugPrint("getItemDisenchants", ENX_INFO, "No data", "No data returned for iType:", iType, link)
		return nil
	end
	return data
end



-- NOTE - Rabbitbunny - copied from getItemDisenchantTotals directly below
-- NOTE - ccox - calculation copied from itemTooltip, I couldn't easily reuse the code
-- TODO - REVISIT - ccox - share the code with itemTooltip
-- NOTE - RockSlice - this function now returns value for one ore
function getItemProspectTotals(link)
	local data = Enchantrix.Storage.GetItemProspects(link)
	if not data then
		-- error message would have been printed inside GetItemProspects
		return
	end
	local totalHSP, totalMed, totalMkt, totalFive = 0,0,0,0

	for result, resProb in pairs(data) do
		local style, extra = Enchantrix.Util.GetPricingModel()
		local hsp, med, mkt, five = Enchantrix.Util.GetReagentPrice(result,extra)
		local resHSP, resMed, resMkt, resFive = (hsp or 0)*resProb, (med or 0)*resProb, (mkt or 0)*resProb, (five or 0)*resProb
		totalHSP = totalHSP + resHSP
		totalMed = totalMed + resMed
		totalMkt = totalMkt + resMkt
		totalFive = totalFive + resFive
	end
	--so far, we've been calculating per prospect.  We need price per unit
	totalHSP, totalMed, totalMkt, totalFive = totalHSP/5, totalMed/5, totalMkt/5, totalFive/5
	return totalHSP, totalMed, totalMkt, totalFive
end



-- NOTE - ccox - calculation copied from itemTooltip, I couldn't easily reuse the code
-- TODO - REVISIT - ccox - share the code with itemTooltip
function getItemDisenchantTotals(link)
	local data = Enchantrix.Storage.GetItemDisenchants(link)
	if not data then
		-- error message would have been printed inside GetItemDisenchants
		return
	end

	local total = data.total
	local totalHSP, totalMed, totalMkt, totalFive = 0,0,0,0

	if (total and total[1] > 0) then
		local totalNumber, totalQuantity = unpack(total)
		for result, resData in pairs(data) do
			if (result ~= "total") then

				local resNumber, resQuantity = unpack(resData)
				local style, extra = Enchantrix.Util.GetPricingModel()
				local hsp, med, mkt, five = Enchantrix.Util.GetReagentPrice(result,extra)
				local resProb, resCount = resNumber/totalNumber, resQuantity/resNumber
				local resYield = resProb * resCount;	-- == resQuantity / totalNumber;
				local resHSP, resMed, resMkt, resFive = (hsp or 0)*resYield, (med or 0)*resYield, (mkt or 0)*resYield, (five or 0)*resYield
				totalHSP = totalHSP + resHSP
				totalMed = totalMed + resMed
				totalMkt = totalMkt + resMkt
				totalFive = totalFive + resFive
			end
		end
	else
		return
	end

	return totalHSP, totalMed, totalMkt, totalFive
end


-- NOTE - ccox - calculation copied from itemTooltip, I couldn't easily reuse the code
-- TODO - REVISIT - ccox - share the code with itemTooltip
-- NOTE - RockSlice - this function now returns value for one herb
function getItemMillingTotals(link)
	local data = Enchantrix.Storage.GetItemMilling(link)
	if not data then
		-- error message would have been printed inside GetItemMilling
		return
	end
	local totalHSP, totalMed, totalMkt, totalFive = 0,0,0,0

	for result, resProb in pairs(data) do
		local style, extra = Enchantrix.Util.GetPricingModel()
		local hsp, med, mkt, five = Enchantrix.Util.GetReagentPrice(result,extra)
		local resHSP, resMed, resMkt, resFive = (hsp or 0)*resProb, (med or 0)*resProb, (mkt or 0)*resProb, (five or 0)*resProb
		totalHSP = totalHSP + resHSP
		totalMed = totalMed + resMed
		totalMkt = totalMkt + resMkt
		totalFive = totalFive + resFive
	end
	--so far, we've been calculating per milling.  We need price per unit
	totalHSP, totalMed, totalMkt, totalFive = totalHSP/5, totalMed/5, totalMkt/5, totalFive/5
	return totalHSP, totalMed, totalMkt, totalFive
end


-- NOTE - ccox - calculation copied from itemTooltip, but not remotely shareable
-- this version takes a table of pre-calculated reagent prices
-- this simplifies the inner loop of some calculations, and allow for custom pricing

function getItemDisenchantFromTable(link, reagentTable)
	local data = Enchantrix.Storage.GetItemDisenchants(link)
	if not data then
		-- error message would have been printed inside GetItemDisenchants
		return
	end

	local total = data.total
	local priceTotal = 0;

	if (total and total[1] > 0) then
		local totalNumber, totalQuantity = unpack(total)
		for result, resData in pairs(data) do
			if (result ~= "total") then
				local resNumber, resQuantity = unpack(resData)
				local reagentPrice = reagentTable[ result ];
				if (not reagentPrice) then
					Enchantrix.Util.DebugPrint("reagentTable", ENX_INFO, "No data", "No data in reagent table for ", result, reagentTable )
				end
				local resYield = resQuantity / totalNumber;
				local resPrice = (reagentPrice or 0) * resYield;
				priceTotal = priceTotal + resPrice;
			end
		end
	else
		return
	end

	return priceTotal
end


function getItemDisenchantFromTableForOneMaterial(link, reagentTable, material)
	local data = Enchantrix.Storage.GetItemDisenchants(link)
	if not data then
		-- error message would have been printed inside GetItemDisenchants
		return
	end

	local total = data.total
	local priceTotal = 0;

	if (total and total[1] > 0) then
		local totalNumber, totalQuantity = unpack(total)
		for result, resData in pairs(data) do
			if (result ~= "total" and result == material) then

				local resNumber, resQuantity = unpack(resData)
				local reagentPrice = reagentTable[ result ];
				if (not reagentPrice) then
					Enchantrix.Util.DebugPrint("reagentTable", ENX_INFO, "No data", "No data in reagent table for ", result, reagentTable )
				end
				local resYield = resQuantity / totalNumber;
				local resPrice = (reagentPrice or 0) * resYield;
				local percentage = resNumber / totalNumber;
				local simpleYield = resQuantity/resNumber;
				return resPrice, percentage, simpleYield;
			end
		end
	end

	-- material not matched
	return
end


local _G
local lib = Enchantrix.Storage
lib.data = {}


local function addResults(data, ...)
	if not data then return end
	local result, number, quantity
	local n = select("#", ...)
	local stats
	if (not data.total) then data.total = { 0, 0 } end
	for i = 1, n do
		stats = select(i, ...)
		result, number, quantity = strsplit(":", stats)
		result = tonumber(result)
		if (result) then
			number = tonumber(number) or 0
			quantity = tonumber(quantity) or 0
			if (not data[result]) then data[result] = { 0, 0 } end
			data[result][1] = data[result][1] + number
			data[result][2] = data[result][2] + quantity
			data.total[1] = data.total[1] + number
			data.total[2] = data.total[2] + quantity
		end
	end
end


-- take an ilevel and round it up to the corresponding bracket
local function roundupLevel(level)
	for _, bracket in pairs(Enchantrix.Constants.levelUpperBounds) do
		if bracket >= level then
			return bracket
		end
	end
	return nil
end

-- get entry from disenchant table (or nil if nothing found)
local function getBaseTableDisenchants(level, quality, type, item)
	local rLevel = roundupLevel(level);

	if Enchantrix.Constants.baseDisenchantTable[quality]
		and Enchantrix.Constants.baseDisenchantTable[quality][type]
		and Enchantrix.Constants.baseDisenchantTable[quality][type][rLevel] then
			return Enchantrix.Constants.baseDisenchantTable[quality][type][rLevel]
	end

	-- no matching entry found, this is bad because this is the backup!
	Enchantrix.Util.DebugPrint("disenchantTable", ENX_INFO, "No data", "No match found in base disenchant table for", rLevel, quality, type, level, item )
	return nil
end


-- normal (history) data is material, number of times disenchanted, number of items returned
-- base data is material, percentage given, number returned
-- this will work as-is, but return a total count of 1
-- we have to multiply this to get a reasonable result after the confidence function
-- TODO - ccox - clean this up now that the confidence function is gone
local BASE_SCALE = 1000

local function addResultFromBaseTable(data, baseData)
	if not data then return end
	local result, number, quantity
	if (not data.total) then data.total = { 0, 0 } end
    for _, stats in pairs(baseData) do
		result, number, quantity = stats[1], stats[2], stats[3];
		result = tonumber(result)
		if (result) then
			number = tonumber(number) or 0
			quantity = tonumber(quantity) or 0
			number = BASE_SCALE * number
			quantity = number * quantity
			if (not data[result]) then data[result] = { 0, 0 } end
			data[result][1] = number
			data[result][2] = quantity
			data.total[1] = data.total[1] + number
			data.total[2] = data.total[2] + quantity
		end
	end
end


local compactres = {}
local function compact(data)
	while #compactres > 0 do
		table.remove(compactres)
	end
	for item, value in pairs(data) do
		table.insert(compactres, strjoin(":", item, value[1], value[2]))
	end
	return strjoin(",", unpack(compactres))
end

local function index(self, key)
	local iLevel,iQual,iType,iItem
	if (type(key) == "string") then
		iLevel,iQual,iType,iItem = strsplit(":", key)
	end
	if (iQual) then
		local data = {}
		iLevel = tonumber(iLevel) or 0
		iQual = tonumber(iQual) or 0
		iType = tonumber(iType) or 0
		if (iLevel > 0 and iQual >= 2 and (iType == 2 or iType == 4)) then

			local baseData = getBaseTableDisenchants(iLevel,iQual,iType,iItem);
			if (baseData) then
				addResultFromBaseTable(data,baseData);
			end
		end
		return data
	end
	local val = rawget(self, key)
	if (val) then
		return val
	end
	return nil
end

local function newindex(self, key, value)
	local iLevel,iQual,iType,iItem
	if (type(key) == "string") then
		iLevel,iQual,iType,iItem = strsplit(":", key)
	end
	if (iQual) then
		if (type(value) ~= "table") then return end

		local data = {}
		iLevel = tonumber(iLevel) or 0
		iQual = tonumber(iQual) or 0
		iType = tonumber(iType) or 0
		iItem = tonumber(iItem) or 0

		if (iLevel > 0 and iQual >= 2 and (iType == 2 or iType == 4) and iItem > 0) then
			local key = strjoin(":", iLevel, iQual, iType)
			if (not EnchantrixData) then EnchantrixData = {} end
			if (not EnchantrixData.disenchants) then EnchantrixData.disenchants = {} end
			if (not EnchantrixData.disenchants[key]) then EnchantrixData.disenchants[key] = {}
			else
				for itemId, itemData in pairs(EnchantrixData.disenchants[key]) do
					if (itemId == iItem) then
						addResults(data, strsplit(",", itemData))
						break
					end
				end
			end
			for resultId, resultData in pairs(value) do
				if (not data[resultId]) then data[resultId] = { 0, 0 } end
				local node = data[resultId]
				node[1] = node[1] + resultData[1]
				node[2] = node[2] + resultData[2]
			end

			EnchantrixData.disenchants[key][iItem] = compact(data)
		end
		return
	end
	if (self.locked) then return end
	rawset(self, key, value)
end


function saveNonDisenchantable(itemLink)
	if not NonDisenchantablesLocal then NonDisenchantablesLocal = {} end
	local sig = Enchantrix.Util.GetSigFromLink(itemLink);
	-- put this in the local and combined list
	-- only the local list will be saved in SavedVariables
	if (not NonDisenchantables[sig]) then
		if (Enchantrix.Settings.GetSetting('chatShowFindings')) then
			Enchantrix.Util.ChatPrint(_ENCH("FrmtFoundNotDisenchant"):format(itemLink))
		end
		NonDisenchantablesLocal[sig] = true;
		NonDisenchantables[sig] = true;
	end
end


function addonLoaded()
	-- Create and setup saved variables
	if not EnchantedLocal then EnchantedLocal = {} end
	if not EnchantedBaseItems then EnchantedBaseItems = {} end
	if not EnchantedItemTypes then EnchantedItemTypes = {} end
	if not NonDisenchantables then NonDisenchantables = {} end
	if not NonDisenchantablesLocal then NonDisenchantablesLocal = {} end
	if not ProspectedLocal then ProspectedLocal = {} end
	if not MillingLocal then MillingLocal = {} end

	mergeDisenchantLists()
end


Enchantrix.Storage = {
	data={},
	locked=false,
	AddonLoaded			= addonLoaded,

	GetItemDisenchants	= getItemDisenchants,
	GetItemDisenchantTotals = getItemDisenchantTotals,
	GetItemDisenchantFromTable = getItemDisenchantFromTable,
	GetItemDisenchantFromTableForOneMaterial = getItemDisenchantFromTableForOneMaterial,
	SaveDisenchant = saveDisenchant,
	SaveNonDisenchantable = saveNonDisenchantable,

	SaveProspect = saveProspect,
	GetItemProspects = getItemProspects,
	GetItemProspectTotals = getItemProspectTotals,

	SaveMilling = saveMilling,
	GetItemMilling = getItemMilling,
	GetItemMillingTotals = getItemMillingTotals,
}

-- Make all globals local to this file
_G = getfenv(0)
local metatable = {__index = index, __newindex = newindex}
setmetatable(Enchantrix.Storage, metatable)
setfenv(1, Enchantrix.Storage)

-- Stops any other addon from modifying our stuff.
loaded = true
