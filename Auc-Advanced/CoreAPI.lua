--[[
	Auctioneer Advanced
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: CoreAPI.lua 4678 2010-02-27 00:53:37Z Nechckn $
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
]]
if not AucAdvanced then return end
local AucAdvanced = AucAdvanced

AucAdvanced.API = {}
local lib = AucAdvanced.API
local private = {}

lib.Print = AucAdvanced.Print
local Const = AucAdvanced.Const
local GetFaction = AucAdvanced.GetFaction
local GetSetting = AucAdvanced.Settings.GetSetting
local DecodeLink = AucAdvanced.DecodeLink
local SanitizeLink = AucAdvanced.SanitizeLink

local tinsert = table.insert
local tremove = table.remove
local next,pairs,ipairs,type = next,pairs,ipairs,type
local wipe = wipe
local ceil,floor,max,abs = ceil,floor,max,abs
local tostring,tonumber,strjoin,strsplit,format = tostring,tonumber,strjoin,strsplit,format
local GetItemInfo = GetItemInfo
-- GLOBALS: nLog, N_NOTICE, N_WARNING, N_ERROR


--[[
	The following functions are defined for modules's exposed methods:

	GetName()         (ALL*)  Should return this module's full name
	OnLoad()          (ALL*)  Receives load message for all modules
	Processor()       (ALL)   Processes messages sent by Auctioneer
	CommandHandler()  (ALL)   Slash command handler for this module
	ScanProcessor {}  (ALL)   Processes items from the scan manager
	GetPrice()        (STAT*) Returns estimated price for item link
	GetPriceColumns() (STAT)  Returns the column names for GetPrice
	StartScan()       (SCAN*) Begins an AH scan session
	IsScanning()      (SCAN*) Indicates an AH scan is in session
	AbortScan()       (SCAN)  Cancels the currently running scan
	Hook { }          (ALL)   Functions that are hooked by the module
    GetItemPDF()      (STAT*) Provides a probability distribution function for an item price


	Module type in parentheses to describe which ones provide.
	Possible Module Types are STAT, UTIL, SCAN.  ALL is a shorthand for all three.
	A * after the module type states the function is REQUIRED.

	Please visit http://norganna.org/wiki/Auctioneer/5.0/Modules_API for a
	more complete specification.
]]

-- this is actually called from a dummy module in CoreUtil
function lib.Processor(event, ...)
	if event == "scanstats" then
		lib.ClearMarketCache()
	elseif event == "configchanged" then
		lib.ClearMarketCache()
	elseif event == "newmodule" then
		private.ClearEngineCache()
		lib.ClearMarketCache()
	end
end

do
    local EPSILON = 0.000001;
    local IMPROVEMENT_FACTOR = 0.8;
    local CORRECTION_FACTOR = 1000; -- 10 silver per gold, integration steps at tail
    local FALLBACK_ERROR = 1;       -- 1 silver per gold fallback error max

	-- cache[serverKey][itemsig]={value, seen, #stats}
    local cache = setmetatable({}, { __index = function(tbl,key)
			tbl[key] = {}
			return tbl[key]
		end
	})
    local pdfList = {};
    local engines = {};
    local ERROR = 0.05;
    -- local LOWER_INT_LIMIT, HIGHER_INT_LIMIT = -100000, 10000000;
    --[[
        This function acquires the current market value of the mentioned item using
        a configurable algorithm to process the data used by the other installed
        algorithms.

        The returned value is the most probable value that the item is worth
        using the algorithms in each of the STAT modules as specified
        by the GetItemPDF() function.

        AucAdvanced.API.GetMarketValue(itemLink, serverKey)
    ]]
    function lib.GetMarketValue(itemLink, serverKey)
        local _;
        if type(itemLink) == 'number' then _, itemLink = GetItemInfo(itemLink) end
		if not itemLink then return end

		local cacheSig = lib.GetSigFromLink(itemLink)
		if not cacheSig then return end -- not a valid item link
		serverKey = serverKey or GetFaction() -- call GetFaction once here, instead of in every Stat module

        local cacheEntry = cache[serverKey][cacheSig]
        if cacheEntry then
            return cacheEntry[1], cacheEntry[2], cacheEntry[3] -- explicit indexing faster than 'unpack' for 3 values
        end

        ERROR = GetSetting("marketvalue.accuracy");
        local saneLink = SanitizeLink(itemLink)

        local upperLimit, lowerLimit, seen = 0, 1e11, 0;

        if #engines == 0 then
            -- Rebuild the engine cache
            local modules = AucAdvanced.GetAllModules(nil, "Stat")
            for pos, engineLib in ipairs(modules) do
                local fn = engineLib.GetItemPDF;
                if fn then
                    tinsert(engines, {pdf = fn, array = engineLib.GetPriceArray});
                elseif nLog then
                    nLog.AddMessage("Auctioneer", "Market Pricing", N_WARNING, "Missing PDF", "Auctioneer engine '"..engineLib.GetName().."' does not have a GetItemPDF() function. This check will be removed in the near future in favor of faster calls. Implement this function.");
                end
            end
        end

        -- Run through all of the stat modules and get the PDFs
        local c, oldPdfMax, total = 0, #pdfList, 0;
        local convergedFallback = nil;
        for _, engine in ipairs(engines) do
            local i, min, max, area = engine.pdf(saneLink, serverKey);

            if type(i) == 'number' then
                -- This is a fallback
                if convergedFallback == nil or (type(convergedFallback) == 'number' and abs(convergedFallback - i) < FALLBACK_ERROR * convergedFallback / 10000) then
                    convergedFallback = i;
                else
                    convergedFallback = false;      -- Cannot converge on fallback pricing
                end
            end

            local priceArray = engine.array(saneLink, serverKey);

            if priceArray and (priceArray.seen or 0) > seen then
                seen = priceArray.seen;
            end

            if i and type(i) ~= 'number' then   -- pdfList[++c] = i;
                total = total + (area or 1);                                -- Add total area, assume 1 if not supplied
                c = c + 1;
                pdfList[c] =  i;
                if min < lowerLimit then lowerLimit = min; end
                if max > upperLimit then upperLimit = max; end
            end
        end

        -- Clean out extras if needed
        for i = c+1, oldPdfMax do
            pdfList[i] = nil;
        end

        if #pdfList == 0 and convergedFallback then
            if nLog then nLog.AddMessage("Auctioneer", "Market Pricing", N_WARNING, "Fallback Pricing Used", "Fallback pricing used due to no available PDFs on item "..itemLink); end
            return convergedFallback, 1, 1;
        end


        if not (lowerLimit > -1/0 and upperLimit < 1/0) then
			error("Invalid bounds detected while pricing "..(GetItemInfo(itemLink) or itemLink)..": "..tostring(lowerLimit).." to "..tostring(upperLimit))
		end


        -- Determine the totals from the PDFs
        local delta = (upperLimit - lowerLimit) * .01;

        if #pdfList == 0 or delta < EPSILON or total < EPSILON then
            return;                 -- No PDFs available for this item
        end

        local limit = total/2;
        local midpoint, lastMidpoint = 0, 0;

        -- Now find the 50% point
        repeat
            lastMidpoint = midpoint;
            total = 0;

            if not(delta > 0) then
				error("Infinite loop detected during market pricing for "..(GetItemInfo(itemLink) or itemLink))
			end

            for x = lowerLimit, upperLimit, delta do
                for i = 1, #pdfList do
                    local val = pdfList[i](x);
                    total = total + val * delta;
                end

                if total > limit then
                    midpoint = x;
                    break;
                end
            end

            delta = delta * IMPROVEMENT_FACTOR;


            if midpoint ~= midpoint or midpoint == 0 then
                if nLog and midpoint ~= midpoint then
                    nLog.AddMessage("Auctioneer", "Market Pricing", N_WARNING, "Unable To Calculate", "A NaN value was detected while processing the midpoint for PDF of "..(GetItemInfo(itemLink) or itemLink).."... Giving up.");
                elseif nLog then
                    nLog.AddMessage("Auctioneer", "Market Pricing", N_NOTICE, "Unable To Calculate", "A zero total was detected while processing the midpoint for PDF of "..(GetItemInfo(itemLink) or itemLink).."... Giving up.");
                end

                if convergedFallback then
                    if nLog then
                        nLog.AddMessage("Auctioneer", "Market Pricing", N_WARNING, "Fallback Pricing Used", "Fallback pricing used due to NaN/Zero total for item "..itemLink);
                    end
                    return convergedFallback, 1, 1;
                end
                return;                 -- Cannot calculate: NaN
            end

        until abs(midpoint - lastMidpoint)/midpoint < ERROR;

        if midpoint and midpoint > 0 then
            midpoint = floor(midpoint + 0.5);   -- Round to nearest copper

            -- Cache before finishing up
			cache[serverKey][cacheSig] = {midpoint, seen, #pdfList}

            return midpoint, seen, #pdfList;
        else
            if nLog then
                nLog.AddMessage("Auctioneer", "Market Pricing", N_WARNING, "Unable To Calculate", "No midpoint was detected for item "..(GetItemInfo(itemLink) or itemLink).."... Giving up.");
            end
            return;
        end

    end

	-- Clear the cache of Stats engines (called if a new module is registered)
	function private.ClearEngineCache()
		wipe(engines)
	end

    -- Clears the results cache for AucAdvanced.API.GetMarketValue()
    function lib.ClearMarketCache()
		wipe(cache)
    end
end

function lib.ClearItem(itemLink, serverKey)
	local saneLink = SanitizeLink(itemLink)
	local modules = AucAdvanced.GetAllModules("ClearItem")
	for pos, engineLib in ipairs(modules) do
		engineLib.ClearItem(saneLink, serverKey)
	end
	lib.ClearMarketCache()
end

function lib.GetAlgorithms(itemLink)
	local saneLink = SanitizeLink(itemLink)
	local engines = {}
	local modules = AucAdvanced.GetAllModules()
	for pos, engineLib in ipairs(modules) do
		if engineLib.GetPrice or engineLib.GetPriceArray then
			if not engineLib.IsValidAlgorithm
			or engineLib.IsValidAlgorithm(saneLink) then
				local engine = engineLib.GetName()
				tinsert(engines, engine)
			end
		end
	end
	return engines
end

function lib.IsValidAlgorithm(algorithm, itemLink)
	local saneLink = SanitizeLink(itemLink)
	local modules = AucAdvanced.GetAllModules()
	for pos, engineLib in ipairs(modules) do
		if engineLib.GetName() == algorithm and (engineLib.GetPrice or engineLib.GetPriceArray) then
			if engineLib.IsValidAlgorithm then
				return engineLib.IsValidAlgorithm(saneLink)
			end
			return true
		end
	end
	return false
end

private.algorithmstack = {}
function lib.GetAlgorithmValue(algorithm, itemLink, serverKey, reserved)
	if (not algorithm) then
        if nLog then nLog.AddMessage("Auctioneer", "API", N_ERROR, "Incorrect Usage", "No pricing algorithm supplied to GetAlgorithmValue") end
		return
	end
	if type(itemLink) == "number" then
		local _
		_, itemLink = GetItemInfo(itemLink)
	end
	if (not itemLink) then
		if nLog then nLog.AddMessage("Auctioneer", "API", N_ERROR, "Incorrect Usage", "No itemLink supplied to GetAlgorithmValue") end
		return
	end

    if reserved then
        lib.ShowDeprecationAlert("AucAdvanced.API.GetAlgorithmValue(algorithm, itemLink, serverKey)",
            "The 'faction' and 'realm' parameters are deprecated in favor of the new 'serverKey' parameter. Use this instead."
        );

        serverKey = reserved.."-"..serverKey;
    end
    serverKey = serverKey or GetFaction()

	local saneLink = SanitizeLink(itemLink)
	local modules = AucAdvanced.GetAllModules()
	for pos, engineLib in ipairs(modules) do
		if engineLib.GetName() == algorithm and (engineLib.GetPrice or engineLib.GetPriceArray) then
			if engineLib.IsValidAlgorithm
			and not engineLib.IsValidAlgorithm(saneLink) then
				return
			end
			local algosig = strjoin(":", algorithm, saneLink, serverKey)
			for pos, history in ipairs(private.algorithmstack) do
				if (history == algosig) then
					-- We are looping
					local origAlgo = private.algorithmstack[1]
					local endSize = #(private.algorithmstack)+1
					while (#(private.algorithmstack)) do
						tremove(private.algorithmstack)
					end
					error(("Cannot solve price algorithm for: %s. (Recursion at level %d->%d: %s)"):format(origAlgo, algosig, endSize, pos))
				end
			end

			local price, seen, array
			tinsert(private.algorithmstack, algosig)
			if (engineLib.GetPriceArray) then
				array = engineLib.GetPriceArray(saneLink, serverKey)
				if (array) then
					price = array.price
					seen = array.seen
				end
			else
				price = engineLib.GetPrice(saneLink, serverKey)
			end
			tremove(private.algorithmstack, -1)
			return price, seen, array
		end
	end
	--error(("Cannot find pricing algorithm: %s"):format(algorithm))
	return
end

-- resultsTable = AucAdvanced.API.QueryImage(queryTable, serverKey, reserved, ...)
-- {previous form was QueryImage(query, faction, realm, ...), this is deprecated, use 'serverKey' instead}
-- 'reserved' should always be nil
function lib.QueryImage(query, serverKey, reserved, ...)
	if serverKey then
		if not AucAdvanced.SplitServerKey(serverKey) then
			-- check for parameters in the old (deprecated) format
			local faction, realmName, deprecated
			if serverKey == "Alliance" or serverKey == "Horde" or serverKey == "Neutral" then
				deprecated = true
				faction = serverKey
			else
				error("Invalid serverKey passed to AucAdvanced.API.QueryImage")
			end
			if reserved then
				realmName = reserved
				deprecated = true
			else
				realmName = GetRealmName()
			end
			serverKey = realmName.."-"..faction
			if deprecated then
				lib.ShowDeprecationAlert("AucAdvanced.API.QueryImage(queryTable, serverKey, reserved, ...)",
					"The 'faction' and 'realm' parameters are deprecated in favor of the new 'serverKey' parameter.")
			end
		end
	else
		serverKey = AucAdvanced.GetFaction()
	end

	return AucAdvanced.Scan.QueryImage(query, serverKey, nil, ...)
end

-- unpackedTable = AucAdvanced.API.UnpackImageItem(imageItem)
-- imageItem is one of the values (subtables) in the table returned by QueryImage or GetImageCopy
function lib.UnpackImageItem(item)
	return AucAdvanced.Scan.UnpackImageItem(item)
end

-- scanStatsTable = AucAdvanced.API.GetScanStats(serverKey)
-- Timestamps: scanstats.LastScan, scanstats.LastFullScan, scanstats.ImageUpdated
-- Scan statistics subtables: scanstats[0] (last scan), scanstats[1], scanstats[2] (two scans prior to last scan)
lib.GetScanStats = AucAdvanced.Scan.GetScanStats

-- imageTable = AucAdvanced.API.GetImageCopy(serverKey)
-- Generates an independent copy of the current scan data image for the specified serverKey
lib.GetImageCopy = AucAdvanced.Scan.GetImageCopy

function lib.ListUpdate()
	if lib.IsBlocked() then return end
	AucAdvanced.SendProcessorMessage("listupdate")
end

function lib.BlockUpdate(block, propagate)
	local blocked
	if block == true then
		blocked = true
		private.isBlocked = true
		AuctionFrameBrowse:UnregisterEvent("AUCTION_ITEM_LIST_UPDATE")
	else
		blocked = false
		private.isBlocked = nil
		AuctionFrameBrowse:RegisterEvent("AUCTION_ITEM_LIST_UPDATE")
	end

	if (propagate) then
		AucAdvanced.SendProcessorMessage("blockupdate", blocked)
	end
end

function lib.IsBlocked()
	return private.isBlocked == true
end

--[[ Market matcher APIs ]]--

function lib.GetBestMatch(itemLink, algorithm, serverKey, reserved)
	local saneLink = SanitizeLink(itemLink)

    if reserved then
        lib.ShowDeprecationAlert("AucAdvanced.API.GetBestMatch(itemLink, algorithm, serverKey)",
            "The 'realm' and 'faction' parameters have been removed in favor of a single "..
            "variable 'serverKey' which should be used in the future."
        );

        serverKey = reserved.."-"..serverKey;
    end

	-- TODO: Make a configurable algorithm.
	-- This algorithm is currently less than adequate.

	local price
	if algorithm == "market" then
		price = lib.GetMarketValue(saneLink, serverKey)
	elseif type(algorithm) == "string" then
		price = lib.GetAlgorithmValue(algorithm, saneLink, serverKey)
	else
		price = algorithm
	end
	if not price then return end

	local matchers = lib.GetMatchers(saneLink)
	local total, count, diff = 0, 0, 0
	local infoString = ""

	for index, matcher in ipairs(matchers) do
		if lib.IsValidMatcher(matcher, saneLink) then -- todo: shoudn't this already be valid from calling lib.GetMatchers(saneLink) ?
			local value, MatchpriceArray = lib.GetMatcherValue(matcher, saneLink, price, serverKey)
			price = value
			count = count + 1
			diff = diff + MatchpriceArray.diff
			if MatchpriceArray.returnstring then
				infoString = infoString.."\n"..MatchpriceArray.returnstring -- using two .. is faster than calling strjoin
			end
		end
	end
	if count > 1 then
		diff = diff / count
	end

	if price > 0 then
		return price, total, count, diff, infoString
	end
end

function lib.GetMatcherDropdownList()
	private.matcherlist = GetSetting("matcherlist")
	if not private.matcherlist or #private.matcherlist == 0 then
		lib.GetMatchers()
	end
	if not private.matcherlist or #private.matcherlist == 0 then
		return
	end
	local dropdownlist = {}
	for index, value in ipairs(private.matcherlist) do
		dropdownlist[index] = tostring(index)..": "..tostring(private.matcherlist[index])
	end
	return dropdownlist
end

function lib.GetMatchers(itemLink)
	local saneLink = SanitizeLink(itemLink)
	private.matcherlist = GetSetting("matcherlist")
	local engines = {}
	local modules = AucAdvanced.GetAllModules()
	for pos, engineLib in ipairs(modules) do
		if engineLib.GetMatchArray then
			if not engineLib.IsValidMatcher
			or engineLib.IsValidMatcher(saneLink) then
				local engine = engineLib.GetName()
				tinsert(engines, engine)
			end
		end
	end
	local insetting = false
	local stillactive = false
	--check to see if there are any new matchers.  If so, add them to the end of the running order.
	--There is no check to see if matchers are missing, as this would destroy the saved order.  Instead, invalid matchers can be called without errors.
	if private.matcherlist then
		for index, matcher in ipairs(engines) do
			for i, j in ipairs(private.matcherlist) do
				if matcher == j then insetting = true
				end
			end
			if not insetting then
				AucAdvanced.Print("AucAdvanced: New matcher found: "..tostring(matcher))
				tinsert(private.matcherlist, matcher)
			end
			insetting = false
		end
	else
		private.matcherlist = engines
	end
	AucAdvanced.Settings.SetSetting("matcherlist", private.matcherlist)
	return private.matcherlist
end

function lib.IsValidMatcher(matcher, itemLink)
	local saneLink = SanitizeLink(itemLink)
	local engines = {}
	local modules = AucAdvanced.GetAllModules()
	for pos, engineLib in ipairs(modules) do
		local engine = engineLib.GetName()
		if engine == matcher and engineLib.GetMatchArray then
			if engineLib.IsValidMatcher then
				return engineLib.IsValidMatcher(saneLink)
			end
			return engineLib
		end
	end
	return false
end

function lib.GetMatcherValue(matcher, itemLink, price, serverKey)
	local saneLink = SanitizeLink(itemLink)
	if (type(matcher) == "string") then
		matcher = lib.IsValidMatcher(matcher, saneLink)
	end
	if not matcher then return end
	--If matcher is not a table at this point, the following code will throw an "attempt to index a <something> value" type error
	local matchArray = matcher.GetMatchArray(saneLink, price, serverKey)
	if not matchArray then
		matchArray = {}
		matchArray.value = price
		matchArray.diff = 0
	end

	return matchArray.value, matchArray
end


-- Signature conversion functions

-- Creates an AucAdvanced signature from an item link
function lib.GetSigFromLink(link)
	local sig
	local itype, id, suffix, factor, enchant = DecodeLink(link)
	if itype == "item" then
		if enchant ~= 0 then
			sig = ("%d:%d:%d:%d"):format(id, suffix, factor, enchant)
		elseif factor ~= 0 then
			sig = ("%d:%d:%d"):format(id, suffix, factor)
		elseif suffix ~= 0 then
			sig = ("%d:%d"):format(id, suffix)
		else
			sig = tostring(id)
		end
	else
		lib.Print("Link is not item")
	end
	return sig
end

-- Creates an item link from an AucAdvanced signature
function lib.GetLinkFromSig(sig)
	local id, suffix, factor, enchant = strsplit(":", sig)

	local itemstring = format("item:%d:%d:0:0:0:0:%d:%d:0", id, enchant or 0, suffix or 0, factor or 0)
	local name, link = GetItemInfo(itemstring)
	link = SanitizeLink(link)
	return link, name -- name is ignored by most calls
end

-- Decodes an AucAdvanced signature into numerical values
-- Can be compared to the return values from DecodeLink
function lib.DecodeSig(sig)
	if type(sig) ~= "string" then return end
	local id, suffix, factor, enchant = strsplit(":", sig)
	id = tonumber(id)
	if not id or id == 0 then return end
	suffix = tonumber(suffix) or 0
	factor = tonumber(factor) or 0
	enchant = tonumber(enchant) or 0
	return id, suffix, factor, enchant
end

-------------------------------------------------------------------------------
-- Statistical devices created by Matthew 'Shirik' Del Buono
-- For Auctioneer
-------------------------------------------------------------------------------
local sqrtpi = math.sqrt(math.pi);
local sqrtpiinv = 1/sqrtpi;
local sq2pi = math.sqrt(2*math.pi);
local pi = math.pi;
local exp = math.exp;
local bellCurveMeta = {
    __index = {
        SetParameters = function(self, mean, stddev)
            if (stddev == 0) then
                error("Standard deviation cannot be zero");
            elseif (stddev ~= stddev) then
                error("Standard deviation must be a real number");
            end
			if stddev < .1 then --need to prevent obsurdly small stddevs like 1e-11, as they cause freeze-ups
				stddev = .1
			end
            self.mean = mean;
            self.stddev = stddev;
            self.param1 = 1/(stddev*sq2pi);     -- Make __call a little faster where we can
            self.param2 = 2*stddev^2;
        end
    },
    -- Simple bell curve call
    __call = function(self, x)
        local n = self.param1*exp(-(x-self.mean)^2/self.param2);
        -- if n ~= n then
            -- DEFAULT_CHAT_FRAME:AddMessage("-----------------");
            -- DevTools_Dump{param1 = self.param1, param2 = self.param2, x = x, mean = self.mean, stddev = self.stddev, exp = exp(-(x-self.mean)^2/self.param2)};
            -- error(x.." produced NAN ("..tostring(n)..")");
        -- end
        return n;
    end
}
-------------------------------------------------------------------------------
-- Creates a bell curve object that can then be manipulated to pass
-- as a PDF function. This is a recyclable object -- the mean and
-- standard deviation can be updated as necessary so that it does not have
-- to be regenerated
--
-- Note: This creates a bell curve with a standard deviation of 1 and
-- mean of 0. You will probably want to update it to your own desired
-- values by calling return:SetParameters(mean, stddev)
-------------------------------------------------------------------------------
function lib.GenerateBellCurve()
    return setmetatable({mean=0, stddev=1, param1=sqrtpiinv, param2=2}, bellCurveMeta);
end

-- Dumps out market pricing information for debugging. Only handles bell curves for now.
function lib.DumpMarketPrice(itemLink, serverKey)
	local modules = AucAdvanced.GetAllModules(nil, "Stat");
	for pos, engineLib in ipairs(modules) do
		local success, result = pcall(engineLib.GetItemPDF, itemLink, serverKey);
		if success then
			if getmetatable(result) == bellCurveMeta then
				print(engineLib.GetName() .. ": Mean = " .. result.mean .. ", Standard Deviation = " .. result.stddev);
			else
				print(engineLib.GetName() .. ": Non-Standard PDF: " .. tostring(result));
			end
		else
			print(engineLib.GetName() .. ": Reported error: " .. tostring(result));
		end
	end
end

--[[===========================================================================
--|| Deprecation Alert Functions
--||=========================================================================]]
do
    local SOURCE_PATTERN = "([^\\/:]+:%d+): in function `([^\"']+)[\"']";
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

        functionName = functionName .. "()";

        -- Check for this source & caller combination
        seenCalls[source] = seenCalls[source] or {};
        if not seenCalls[source][caller] then
            -- Not warned yet, so warn them!
            seenCalls[source][caller]=true
            -- Display it
            AucAdvanced.Print(
                "Auctioneer: "..
                functionName .. " has been deprecated and was called by |cFF9999FF"..caller:match("^(.+)%.[lLxX][uUmM][aAlL]:").."|r. "..
                (replacementName and ("Please use "..replacementName.." instead. ") or "")..
                (comments or "")
            );
	        geterrorhandler()(
	            "Deprecated function call occurred in Auctioneer API:\n     {{{Deprecated Function:}}} "..functionName..
	                "\n     {{{Source Module:}}} "..source:match("^(.+)%.[lLxX][uUmM][aAlL]:")..
	                "\n     {{{Calling Module:}}} "..caller:match("^(.+)%.[lLxX][uUmM][aAlL]:")..
	                "\n     {{{Available Replacement:}}} "..(replacementName or "None")..
	                (comments and "\n\n"..comments or "")
			)
		end



    end

end

AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Auc-Advanced/CoreAPI.lua $", "$Rev: 4678 $")
