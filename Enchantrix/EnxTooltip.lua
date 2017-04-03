--[[
	Enchantrix Addon for World of Warcraft(tm).
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: EnxTooltip.lua 4587 2009-12-17 22:00:31Z Nechckn $
	URL: http://enchantrix.org/

	Tooltip functions.

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
Enchantrix_RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Enchantrix/EnxTooltip.lua $", "$Rev: 4587 $")

-- Global functions
local addonLoaded	-- Enchantrix.Tooltip.AddonLoaded()
local tooltipFormat	-- Enchantrix.Tooltip.Format

-- Local functions
local itemTooltip
local enchantTooltip
local hookItemTooltip, hookSpellTooltip

local tooltip = LibStub("nTipHelper:1")

function addonLoaded()
	-- Hook in new tooltip code
	tooltip:Activate()
	tooltip:AddCallback( { type = "item", callback = hookItemTooltip }, 400)
	tooltip:AddCallback( { type = "spell", callback = hookSpellTooltip }, 400)
end

tooltipFormat = {
	currentFormat = "fancy",
	format = {
		["fancy"] = "  $prob% |q$name|r $rate",
		["default"] = "  $name: $prob% $rate",
	},
	patterns = {
		-- Strings
		["$prob"]	= "",			-- Probability: "75"
		["$name"]	= "",			-- Name: "Lesser Magic Essence"
		["$rate"]	= "",			-- Avg drop amount: "x1.5"
		-- Colors
		["|q"]		= "",			-- Quality color
		["|E"]		= "|cffcccc33",	-- Yellow ("Enchantrix" color)
		["|e"]		= "|cff7f7f00",	-- Dark yellow
		["|r"]		= "|r",			-- Reset color
	},
	SelectFormat = function(this, fmt)
		if this.format[fmt] then
			this.currentFormat = fmt
		else
			this.currentFormat = "default"
		end
	end,
	SetFormat = function(this, fmt, val, counts)
		this.format[fmt] = val
	end,
	GetFormat = function(this, fmt, counts)
		if not this.format[fmt] then return end
		return this.format[fmt]
	end,
	GetString = function(this)
		local line = this.format[this.currentFormat]
		-- Replace patterns
		for pat, repl in pairs(this.patterns) do
			line = line:gsub(pat, repl or "")
		end
		return line
	end,
	SetPattern = function(this, pat, repl)
		this.patterns[pat] = repl
	end,
}


local function prospectTooltip(prospect, tooltip, name, link, quality, count)

	local embed = Enchantrix.Settings.GetSetting('ToolTipEmbedInGameTip')

	local lines

	local totalFive = {}
	local totalHSP, totalMed, totalMkt, totalFive = 0,0,0,0
	local totalNumber, totalQuantity

	for result, resYield in pairs( prospect ) do
		if (not lines) then lines = {} end
		local style, extra = Enchantrix.Util.GetPricingModel();
		local hsp, med, mkt, five = Enchantrix.Util.GetReagentPrice(result,extra)
		local resHSP, resMed, resMkt, resFive = (hsp or 0)*resYield, (med or 0)*resYield, (mkt or 0)*resYield, (five or 0)*resYield
		totalHSP = totalHSP + resHSP
		totalMed = totalMed + resMed
		totalMkt = totalMkt + resMkt
		totalFive = totalFive + resFive

		-- Probabilities
		local prob = tostring( resYield * 100 )
		tooltipFormat:SetPattern("$prob", prob)

		-- Name and quality
		local rName, _, rQuality = Enchantrix.Util.GetReagentInfo(result)
		local _, _, _, color = GetItemQualityColor(rQuality or 0)
		tooltipFormat:SetPattern("|q", color or "|cffcccc33")
		if (not rName) then rName = "item:"..result; end
		tooltipFormat:SetPattern("$name", rName)

		-- Rate is always unity here (not really 1, but handled in the probability)
		tooltipFormat:SetPattern("$rate", "")

		-- Store this line and sort key
		local line = tooltipFormat:GetString(false)	-- no counts here
		table.insert(lines,  {str = line, sort = resYield})
	end


	-- multiply values by the number of items in this stack
	local groups = count / 5;
	totalHSP = totalHSP * groups;
	totalMed = totalMed * groups;
	totalMkt = totalMkt * groups;
	totalFive = totalFive * groups;

	tooltip:SetColor(0.8,0.8,0.2);
	if (Enchantrix.Settings.GetSetting('TooltipProspectMats')) then
		-- Header
		local totalText = ""
		tooltip:AddLine(_ENCH('FrmtProspectInto')..totalText, nil, embed);
		-- Sort in order of decreasing probability before adding to tooltip
		table.sort(lines, function(a, b) return a.sort > b.sort end)
		for n, line in ipairs(lines) do
			tooltip:AddLine(line.str, nil, embed)
			if n >= 13 then break end -- Don't add more than 13 lines (1 Powder + 6 Uncommon + 6 Rare)
		end
	end

	if (Enchantrix.Settings.GetSetting('TooltipProspectLevels')) then
		local reqSkill = Enchantrix.Util.JewelCraftSkillRequiredForItem(link);
		local userSkill = Enchantrix.Util.GetUserJewelCraftingSkill();
		local deText = format(_ENCH("TooltipProspectLevel"), reqSkill );
		if (userSkill < reqSkill) then
			tooltip:AddLine(deText, nil, 0.8,0.1,0.1, embed);		-- reddish
		else
			tooltip:AddLine(deText, nil, 0.1,0.8,0.1, embed);		-- greenish
		end
	end

	tooltip:SetColor(0.1,0.6,0.6);
	if (Enchantrix.Settings.GetSetting('TooltipProspectValues')) then
		if (AucAdvanced and Enchantrix.Settings.GetSetting('TooltipProspectShowAuctAdvValue') and totalFive > 0) then
			tooltip:AddLine(_ENCH('FrmtProspectValueAuctVal'), totalFive, embed);
		end
		if (Enchantrix.Settings.GetSetting('TooltipProspectShowAuctValueHSP') and totalHSP > 0) then
			tooltip:AddLine(_ENCH('FrmtProspectValueAuctHsp'), totalHSP, embed);
		end
		if (Enchantrix.Settings.GetSetting('TooltipProspectShowAuctValueMedian') and totalMed > 0) then
			tooltip:AddLine(_ENCH('FrmtProspectValueAuctMed'), totalMed, embed);
		end
		if (Enchantrix.Settings.GetSetting('TooltipProspectShowBaselineValue') and totalMkt > 0) then
			tooltip:AddLine(_ENCH('FrmtProspectValueMarket'), totalMkt, embed);
		end
	end

end


-- ccox - TODO WOTLK - change strings to milling, see if this can share code with prospecting!
-- probably not

local function millingTooltip(prospect, tooltip, name, link, quality, count)

	local embed = Enchantrix.Settings.GetSetting('ToolTipEmbedInGameTip')

	local lines

	local totalFive = {}
	local totalHSP, totalMed, totalMkt, totalFive = 0,0,0,0
	local totalNumber, totalQuantity

	for result, resYield in pairs( prospect ) do
		if (not lines) then lines = {} end
		local style, extra = Enchantrix.Util.GetPricingModel();
		local hsp, med, mkt, five = Enchantrix.Util.GetReagentPrice(result,extra)
		local resHSP, resMed, resMkt, resFive = (hsp or 0)*resYield, (med or 0)*resYield, (mkt or 0)*resYield, (five or 0)*resYield
		totalHSP = totalHSP + resHSP
		totalMed = totalMed + resMed
		totalMkt = totalMkt + resMkt
		totalFive = totalFive + resFive

		-- Probabilities
		local prob = tostring( resYield * 100 )
		tooltipFormat:SetPattern("$prob", prob)

		-- Name and quality
		local rName, _, rQuality = Enchantrix.Util.GetReagentInfo(result)
		local _, _, _, color = GetItemQualityColor(rQuality or 0)
		tooltipFormat:SetPattern("|q", color or "|cffcccc33")
		if (not rName) then rName = "item:"..result; end
		tooltipFormat:SetPattern("$name", rName)

		-- Rate is always unity here (not really 1, but handled in the probability)
		tooltipFormat:SetPattern("$rate", "")

		-- Store this line and sort key
		local line = tooltipFormat:GetString(false)	-- no counts here
		table.insert(lines,  {str = line, sort = resYield})
	end


	-- multiply values by the number of items in this stack
	local groups = count / 5;
	totalHSP = totalHSP * groups;
	totalMed = totalMed * groups;
	totalMkt = totalMkt * groups;
	totalFive = totalFive * groups;

	tooltip:SetColor(0.8,0.8,0.2)
	if (Enchantrix.Settings.GetSetting('TooltipMillingMats')) then
		-- Header
		local totalText = ""
		tooltip:AddLine(_ENCH('FrmtMillsInto')..totalText, nil, embed);
		-- Sort in order of decreasing probability before adding to tooltip
		table.sort(lines, function(a, b) return a.sort > b.sort end)
		for n, line in ipairs(lines) do
			tooltip:AddLine(line.str, nil, embed)
			if n >= 13 then break end -- Don't add more than 13 lines (1 Powder + 6 Uncommon + 6 Rare)
		end
	end


	if (Enchantrix.Settings.GetSetting('TooltipMillingLevels')) then
		local reqSkill = Enchantrix.Util.InscriptionSkillRequiredForItem(link);
		local userSkill = Enchantrix.Util.GetUserInscriptionSkill();
		local deText = format(_ENCH("TooltipMillingLevel"), reqSkill );
		if (userSkill < reqSkill) then
			tooltip:AddLine(deText, nil, 0.8,0.1,0.1, embed);		-- reddish
		else
			tooltip:AddLine(deText, nil, 0.1,0.8,0.1, embed);		-- greenish
		end
	end

	tooltip:SetColor(0.1,0.6,0.6)
	if (Enchantrix.Settings.GetSetting('TooltipMillingValues')) then
		if (AucAdvanced and Enchantrix.Settings.GetSetting('TooltipMillingShowAuctAdvValue') and totalFive > 0) then
			tooltip:AddLine(_ENCH('FrmtMillingValueAuctVal'), totalFive, embed);
		end
		if (Enchantrix.Settings.GetSetting('TooltipMillingShowAuctValueHSP') and totalHSP > 0) then
			tooltip:AddLine(_ENCH('FrmtMillingValueAuctHsp'), totalHSP, embed);
		end
		if (Enchantrix.Settings.GetSetting('TooltipMillingShowAuctValueMedian') and totalMed > 0) then
			tooltip:AddLine(_ENCH('FrmtMillingValueAuctMed'), totalMed, embed);
		end
		if (Enchantrix.Settings.GetSetting('TooltipProspectShowBaselineValue') and totalMkt > 0) then
			tooltip:AddLine(_ENCH('FrmtMillingValueMarket'), totalMkt, embed);
		end
	end
end


function itemTooltip(tooltip, name, link, itemType, itemId, quality, count)
	if Enchantrix.Settings.GetSetting('ModTTShow') and not IsAltKeyDown() then
		return
	end
	
	-- see if this is a simple reagent produced from disenchanting, prospecting or milling
	if ( Enchantrix.Settings.GetSetting('TooltipShowMatSources') ) then
		
		local deReagent = Enchantrix.Constants.ReverseDisenchantLevelList[ itemId ]
		if (deReagent) then
			local lowest = deReagent[1]
			local highest = deReagent[2]
			if (lowest and highest) then
				local deText = format( _ENCH('FrmtDEItemLevels'), lowest, highest )
				tooltip:SetColor(0.8,0.8,0.2);
				tooltip:AddLine(deText, nil, embed)
				return
			end
		end
		
		local prospectGem = Enchantrix.Constants.ReverseProspectingSources[ itemId ]
		if (prospectGem) then
			local oreCount = #prospectGem
			local oreString = Enchantrix.Util.GetReagentInfo( prospectGem[1] )
			for index = 2, oreCount, 1 do
				oreString = oreString..", "..Enchantrix.Util.GetReagentInfo( prospectGem[ index ] )
			end
			local prospectText = format( _ENCH('FrmtProspectFrom'), oreString )
			tooltip:SetColor(0.8,0.8,0.2);
			tooltip:AddLine( prospectText, nil, embed)
			return
		end
		
		local inkList = Enchantrix.Constants.ReverseInkList[ itemId ]
		if (inkList) then
			local pigmentString = Enchantrix.Util.GetReagentInfo( inkList[1] )
			local inkText = format( _ENCH('FrmtInkFrom'), pigmentString )
			tooltip:SetColor(0.8,0.8,0.2);
			tooltip:AddLine(inkText, nil, embed)
			return
		end
	
	end
	
	
	-- first, see if this is a prospectable item (short list)
	local prospect = Enchantrix.Storage.GetItemProspects(link)
	if (prospect and Enchantrix.Settings.GetSetting('TooltipShowProspecting')) then
		prospectTooltip(prospect, tooltip, name, link, quality, count)
		return
	end

	-- next, see if this is a millable item (short list)
	local milling = Enchantrix.Storage.GetItemMilling(link)
	if (milling and Enchantrix.Settings.GetSetting('TooltipShowMilling')) then
		millingTooltip(milling, tooltip, name, link, quality, count)
		return
	end

	-- then see if it's disenchantable
	local data = Enchantrix.Storage.GetItemDisenchants(link)
	if not data then
		-- error message would have been printed inside GetItemDisenchants
		return
	end

	local lines

	local total = data.total
	local totalFive = {}
	local totalHSP, totalMed, totalMkt, totalFive = 0,0,0,0
	local totalNumber, totalQuantity
	local allFixed = true

	if (total and total[1] > 0) then
		totalNumber, totalQuantity = unpack(total)
		for result, resData in pairs(data) do
			if (result ~= "total") then
				if (not lines) then lines = {} end

				local resNumber, resQuantity = unpack(resData)
				local style, extra = Enchantrix.Util.GetPricingModel()
				local hsp, med, mkt, five, fix = Enchantrix.Util.GetReagentPrice(result, extra)
				local resProb, resCount = resNumber/totalNumber, resQuantity/resNumber
				local resYield = resProb * resCount;	-- == resQuantity / totalNumber;
				local resHSP, resMed, resMkt, resFive, resFix = (hsp or 0)*resYield, (med or 0)*resYield, (mkt or 0)*resYield, (five or 0)*resYield, (fix or 0)*resYield
				if (fix) then
					resHSP, resMed, resMkt, resFive = resFix,resFix,resFix,resFix
				else
					allFixed = false
				end
				totalHSP = totalHSP + resHSP
				totalMed = totalMed + resMed
				totalMkt = totalMkt + resMkt
				totalFive = totalFive + resFive

				local prob = 100 * resProb

				-- Probabilities
				tooltipFormat:SetPattern("$prob", tostring(prob))

				-- Name and quality
				local rName, _, rQuality = Enchantrix.Util.GetReagentInfo(result)
				local _, _, _, color = GetItemQualityColor(rQuality or 0)
				tooltipFormat:SetPattern("|q", color or "|cffcccc33")
				if (not rName) then rName = "item:"..result; end
				tooltipFormat:SetPattern("$name", rName)

				-- Rate
                tooltipFormat:SetPattern("$rate", ("x%0.1f"):format(resCount))

				-- Store this line and sort key
				local line = tooltipFormat:GetString()
				table.insert(lines,  {str = line, sort = prob})
			end
		end
	else
		return
	end
	
	-- normally disenchanting deals with single items
	-- but the appraiser window can show multiple items and wants a value for the group
	totalHSP = totalHSP * count;
	totalMed = totalMed * count;
	totalMkt = totalMkt * count;
	totalFive = totalFive * count;

	local embed = Enchantrix.Settings.GetSetting('ToolTipEmbedInGameTip')

	tooltip:SetColor(0.8,0.8,0.2);
	if (Enchantrix.Settings.GetSetting('TooltipShowDisenchantMats')) then
		-- Header
		local totalText = ""
		tooltip:AddLine(_ENCH('FrmtDisinto')..totalText, nil, embed);
		-- Sort in order of decreasing probability before adding to tooltip
		table.sort(lines, function(a, b) return a.sort > b.sort end)
		for n, line in ipairs(lines) do
			tooltip:AddLine(line.str, nil, embed)
			if n >= 5 then break end -- Don't add more than 5 lines
		end
	end

	if (Enchantrix.Settings.GetSetting('TooltipShowDisenchantLevel')) then
		local reqSkill = Enchantrix.Util.DisenchantSkillRequiredForItem(link);
		local userSkill = Enchantrix.Util.GetUserEnchantingSkill();
		local deText = format(_ENCH("TooltipShowDisenchantLevel"), reqSkill );
		if (userSkill < reqSkill) then
			tooltip:AddLine(deText, nil, 0.8,0.1,0.1, embed);		-- reddish
		else
			tooltip:AddLine(deText, nil, 0.1,0.8,0.1, embed);		-- greenish
		end
	end

	tooltip:SetColor(0.1,0.6,0.6);
	if (Enchantrix.Settings.GetSetting('TooltipShowValues')) then
		if (allFixed) then
			tooltip:AddLine(_ENCH('FrmtValueFixedVal'), totalHSP, embed);
		else
			if (AucAdvanced and Enchantrix.Settings.GetSetting('TooltipShowAuctAdvValue') and totalFive > 0) then
				tooltip:AddLine(_ENCH('FrmtValueAuctVal'), totalFive, embed);
			end
			if (Enchantrix.Settings.GetSetting('TooltipShowAuctValueHSP') and totalHSP > 0) then
				tooltip:AddLine(_ENCH('FrmtValueAuctHsp'), totalHSP, embed);
			end
			if (Enchantrix.Settings.GetSetting('TooltipShowAuctValueMedian') and totalMed > 0) then
				tooltip:AddLine(_ENCH('FrmtValueAuctMed'), totalMed, embed);
			end
			if (Enchantrix.Settings.GetSetting('TooltipShowBaselineValue') and totalMkt > 0) then
				tooltip:AddLine(_ENCH('FrmtValueMarket'), totalMkt, embed);
			end
		end
	end
end

-- using the Trade APIs
local function getReagentsFromTradeFrame(craftIndex)
	local reagentList = {}

	local numReagents = GetTradeSkillNumReagents(craftIndex)
	for i = 1, numReagents do
		local link = GetTradeSkillReagentItemLink(craftIndex, i)
		if link then
			local hlink = link:match("|H([^|]+)|h")
			local reagentName, reagentTexture, reagentCount, playerReagentCount = GetTradeSkillReagentInfo(craftIndex, i)
			table.insert(reagentList, {hlink, reagentCount})
		end
	end

	return reagentList
end

-- NOTE - ccox - to match non enchants, I'd need to search for "Requires (.+)"
local function getReagentsFromTooltip(frame)
	local frameName = frame:GetName()
	local nLines = frame:NumLines()
	local reagents
	-- Find reagents line ("Reagents: ...")
	for i = 1, nLines do
		local text = getglobal(frameName.."TextLeft"..i):GetText()

		-- text:find("Reagents: (.+)")
		local _, _, r = text:find(_ENCH('PatReagents'))
		if r then
			reagents = r
			--Enchantrix.Util.DebugPrintQuick("matched reagents line ", reagents )
			break
		end
	end
	if not reagents then return end

	local reagentList = {}
	local name, quality, color, hlink
	-- Process reagents separated by ","
	for reagent in Enchantrix.Util.Spliterator(reagents, ",") do
		-- Chomp whitespace
		reagent = reagent:gsub("^%s*", "")	-- remove leading spaces
		reagent = reagent:gsub("%s*$", "")	-- remove trailing spaces
		--reagent = reagent:gsub("%c*", "")	-- remove all control characters
		-- ...and newlines
		reagent = reagent:gsub("%|n", "")	-- remove blizzard style newline codes
		-- ...and color codes
		reagent = reagent:gsub("^%|c%x%x%x%x%x%x%x%x", "")
		reagent = reagent:gsub("%|r$", "")	-- remove blizzard style return at end of line

		-- NOTE - ccox - if reagents aren't being found, Blizzard may have added more formatting that needs to be removed above
		-- Enchantrix.Util.DebugPrintQuick("cleaned reagent string ", reagent )

		-- Get and chomp counts, e.g "Strange Dust (2)"
		local _, _, count = reagent:find("%((%d+)%)$")
		if count then
			reagent = reagent:gsub("%s*%(%d+%)$", "")
			count = tonumber(count)
		else
			count = 1
		end

		hlink = Enchantrix.Util.GetLinkFromName(reagent)
		if hlink then
			table.insert(reagentList, {hlink, count})
		else
			return
		end
	end

	return reagentList
end


-- this can be used by non enchanters when clicking on an enchant tooltip
-- this WAS also used inside the enchanting/crafting trade window, but that broke when the new tooltip library was added

function enchantTooltip(tooltip, name, link, isItem)

-- TODO - ccox - for items, get the number made!  But what about items with random yield?
-- TODO - ccox - this really should recursively descend crafted items for true costs not AH prices
--		most of the time they'll be in the cache, so it won't add a lot of time to the search
	local craftIndex = nil
	local tradeIndex = nil
	local reagentList
	local frame = tooltip:GetFrame()
	
	-- if it's an item, try our cache
	if isItem then
		reagentList = Enchantrix.Util.GetCraftReagentInfoFromCache(name)
	end

	if not reagentList or (#reagentList < 1) then

		-- clean up the craft item string
		--Enchantrix.Util.DebugPrintQuick("original name is ", name )
		name = name:gsub("^%a+:", "")	-- remove crafting type "Enchanting:"
		name = name:gsub("^%s*", "")	-- remove leading spaces
		--Enchantrix.Util.DebugPrintQuick("cleaned name is ", name )
		
		for i = GetFirstTradeSkill(), GetNumTradeSkills() do
			local tradeName = GetTradeSkillInfo(i);
			if name == tradeName then
				tradeIndex = i
				break
			end
		end

		if tradeIndex then
			reagentList = getReagentsFromTradeFrame(tradeIndex)
		else
			-- if all else fails
			reagentList = getReagentsFromTooltip(frame)
		end
		
		if not reagentList or (#reagentList < 1) then
			--Enchantrix.Util.DebugPrintQuick("no reagents found for ", link, " in ", name )
			return
		end

		-- now save it to the cache
		if isItem then
			Enchantrix.Util.SaveCraftReagentInfoToCache( name, reagentList );
		end

	end

	-- Append additional reagent info
	for _, reagent in ipairs(reagentList) do
		local rName, _, rQuality = Enchantrix.Util.GetReagentInfo(reagent[1])
		local style, extra = Enchantrix.Util.GetPricingModel();
		local hsp, median, market, five, fix = Enchantrix.Util.GetReagentPrice(reagent[1],extra)
		local _, _, _, color = GetItemQualityColor(rQuality)

		reagent[1] = rName
		table.insert(reagent, rQuality)
		table.insert(reagent, color)
		if fix then
			table.insert(reagent, fix)
		elseif AucAdvanced and five and five > 0 then
			table.insert(reagent, five)
		else
			table.insert(reagent, hsp)
		end
	end

	local NAME, COUNT, QUALITY, COLOR, PRICE = 1, 2, 3, 4, 5

	-- Sort by rarity and price
	table.sort(reagentList, function(a,b)
		if (not b) or (not a) then return end
		return ((b[QUALITY] or -1) < (a[QUALITY] or -1)) or ((b[PRICE] or 0) < (a[PRICE] or 0))
	end)

	-- Header
	tooltip:SetColor(0.7,0.7,0.1)
	local embed = Enchantrix.Settings.GetSetting('ToolTipEmbedInGameTip');
	if not embed and not isItem then
		local hLink = link:match("|H([^|]+)|h")
		if not hLink then hLink = link end
		tooltip:AddLine(hLink)
	end
	tooltip:AddLine(_ENCH('FrmtSuggestedPrice'), 0.8,0.8,0.2, embed)

	local price = 0
	local unknownPrices
	-- Add reagent list to tooltip and sum reagent prices
	for _, reagent in pairs(reagentList) do
		local line = "  "

		if reagent[COLOR] then
			line = line..reagent[COLOR]
		end
		line = line..reagent[NAME]
		if reagent[COLOR] then
			line = line.."|r"
		end
		line = line.." x"..reagent[COUNT]
		if reagent[COUNT] > 1 and reagent[PRICE] then
			line = line.." ".._ENCH('FrmtPriceEach'):format(AucAdvanced.Coins(Enchantrix.Util.Round(reagent[PRICE], 3)))
			tooltip:AddLine(line, Enchantrix.Util.Round(reagent[PRICE] * reagent[COUNT], 3), embed)
			price = price + reagent[PRICE] * reagent[COUNT]
		elseif reagent[PRICE] then
			tooltip:AddLine(line, Enchantrix.Util.Round(reagent[PRICE], 3), embed)
			price = price + reagent[PRICE]
		else
			tooltip:AddLine(line, nil, embed)
			unknownPrices = true
		end
	end

	-- Totals
	tooltip:SetColor(0.8,0.8,0.2)
	if price > 0 then
		tooltip:AddLine(_ENCH('FrmtTotal'), Enchantrix.Util.Round(price, 2.5), embed)

		-- add barker line, if barker is loaded
		if (Barker and Barker.Settings.GetSetting('barker')) then
			local margin = Barker.Settings.GetSetting("barker.profit_margin")
			local profit = price * margin * 0.01
			profit = math.min(profit, Barker.Settings.GetSetting("barker.highest_profit"))
			local barkerPrice = Enchantrix.Util.Round(price + profit)
			-- "Barker Price (%d%% margin)"
			tooltip:AddLine(_ENCH('FrmtBarkerPrice'):format(Barker.Util.Round(margin)), barkerPrice, embed)
		end

		if not Enchantrix.State.Auctioneer_Loaded then
			tooltip:AddLine(_ENCH('FrmtWarnAuctNotLoaded'), 0.6,0.6,0.1, embed)
		end

		if unknownPrices then
			tooltip:AddLine(_ENCH('FrmtWarnPriceUnavail'), 0.6,0.6,0.1, embed)
		end
	else
		tooltip:AddLine(_ENCH('FrmtWarnNoPrices'), 0.6,0.6,0.1, embed)
	end
end

function hookItemTooltip(tipFrame, item, count, name, link, quality)
	if ((not Enchantrix.Settings.GetSetting('all'))
		or (not Enchantrix.Settings.GetSetting('TooltipShowReagents'))) then return end
	
	-- we're getting nil links in here somehow, just return if that happens
	if (link == nil) then return end
	
	tooltip:SetFrame(tipFrame)
	-- ccox - tooltip:DecodeLink will only work with type "item"
	local itemType, itemId = tooltip:DecodeLink(link)
	
	if itemType == "item" then
		name = name or ""
		-- safety, some other addons pass in strings for count by mistake
		count = tonumber(count) or 1
		itemTooltip(tooltip, name, link, itemType, itemId, quality, count)
		if (Enchantrix.Settings.GetSetting('ShowAllCraftReagents')) then
			enchantTooltip(tooltip, name, link, true)
		end
	end
	tooltip:ClearFrame(tipFrame)
end

function hookSpellTooltip(tipFrame, link, name, rank)
	if ((not Enchantrix.Settings.GetSetting('all'))
		or (not Enchantrix.Settings.GetSetting('TooltipShowReagents'))) then return end
	
	-- we're getting nil links in here somehow, just return if that happens
	if (link == nil) then return end
	
	tooltip:SetFrame(tipFrame)
	if link:sub(0, 8) == "enchant:" or link:sub(0, 6) == "spell:" then
		link = "|H"..link.."|h|cffffffff["..name.."]|r|h"
	end
	-- ccox - tooltip:DecodeLink will only work with type "item", returning nil for any other link type
	-- so we have to do this the hard way
	local itemType, itemId = tooltip:BreakHyperlink("H", 1, strsplit("|", link))
	
	if itemType == "enchant" or itemType == "spell" then
		name = name or ""
		enchantTooltip(tooltip, name, link, false)
	end
	tooltip:ClearFrame(tipFrame)
end

Enchantrix.Tooltip = {
	Revision		= "$Revision: 4587 $",

	AddonLoaded		= addonLoaded,
	Format			= tooltipFormat,
}
