--[[
	Informant - An addon for World of Warcraft that shows pertinent information about
	an item in a tooltip when you hover over the item in the game.
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: InfMain.lua 4678 2010-02-27 00:53:37Z Nechckn $
	URL: http://auctioneeraddon.com/dl/Informant/

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
Informant_RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Informant/InfMain.lua $","$Rev: 4678 $")

INFORMANT_VERSION = "5.8.4723"
if (INFORMANT_VERSION == "<".."%version%>") then
	INFORMANT_VERSION = "5.2.DEV"
end

local _G=_G
local type,pairs,ipairs,select = type,pairs,ipairs,select
local tonumber,tostring,strmatch = tonumber,tostring,strmatch
local strsplit,strsub,format = strsplit,strsub,format
local tinsert,wipe = tinsert,wipe
local GetItemInfo = GetItemInfo
local Informant
-- GLOBALS: INFORMANT_VERSION, _TRANS, this, LibStub
-- GLOBALS: InformantLocalUpdates, InformantConfig
-- GLOBALS: InformantFrame, InformantFrameScrollBar
-- GLOBALS: UIParent, MerchantFrame
-- GLOBALS: UnitGUID, UnitFactionGroup, UnitName
-- GLOBALS: InRepairMode, GetMerchantItemLink, GetMerchantItemInfo, GetMerchantNumItems


-- LOCAL FUNCTION PROTOTYPES:
local addLine				-- addLine(text, color)
local clear					-- clear()
local debugPrint            -- debugPrint(message, title, errorCode, level)
local frameActive			-- frameActive(isActive)
local frameLoaded			-- frameLoaded()
local getCatName			-- getCatName(catID)
local getItem				-- getItem(itemID)
local getLocale
local getRowCount			-- getRowCount()
local infDebugPrint         -- debugPrint(message, category, title, errorCode, level)
local onEvent				-- onEvent(event)
local onLoad				-- onLoad()
local onVariablesLoaded		-- onVariablesLoaded()
local onQuit				-- onQuit()
local scrollUpdate			-- scrollUpdate(offset)
local setDatabase			-- setDatabase(database)
local setRequirements		-- setRequirements(requirements)
local setSkills				-- setSkills(skills)
local setVendors			-- setVendors(vendors)
local setVendorLocation			-- setVendorLocation(vendors)
local setQuestStarts
local setQuestRequires
local setQuestRewards
local setQuestNames
local setZones				--
local setCrafted			-- setCrafted(crafted)
local setCraftCount			-- setCraftCount(craft_counts)
local showHideInfo			-- showHideInfo()
local skillToName			-- skillToName(userSkill)
local split					-- split(str, at)
local Dump
local debugPrintQuick
local idFromLink
local OnTooltipAddMoney


-- LOCAL VARIABLES

local self = {}
local lines = {}
local addonName = "Informant"

local tooltip = LibStub("nTipHelper:1")

-- GLOBAL VARIABLES

BINDING_HEADER_INFORMANT_HEADER = _TRANS('INF_Interface_BindingHeader')
BINDING_NAME_INFORMANT_POPUPDOWN = _TRANS('INF_Interface_BindingTitle')

InformantConfig = {}

-- LOCAL DEFINES

CLASS_TO_CATEGORY_MAP = {
	[2] = 1, --Weapon
	[4] = 2, --Armor
	[1] = 3, --Container
	[0] = 4, --Consumable
	[16] = 5, --Glyph
	[7] = 6, --Trade Goods
	[6] = 7, --Projectile
	[11] = 8, --Quiver
	[9] = 9, --Recipe
	[3] = 10, --Gem
	[10] = 11, --Miscellaneous(Currency)
	[15] = 11, --Miscellaneous
	[13] = 11, --Miscellaneous
	[5] = 11, --Miscellaneous
	[12] = 12, --Quest
} 


-- FUNCTION DEFINITIONS

function split(str, at)
	if (not (type(str) == "string")) then
		return
	end

	if (not str) then
		str = ""
	end

	if (not at) then
		return {str}

	else
		return {strsplit(at, str)};
	end
end

-- utility, so we don't have to maintain multiple copies of this
function idFromLink( itemLink )
	return tonumber(strmatch(itemLink, "item:(%d+)"))
end

function skillToName(userSkill)
	local skillName = self.skills[tonumber(userSkill)]
	local localized = "Unknown"
	if (skillName) then
		localized = _TRANS('INF_Tooltip_Skill'..skillName) or "Unknown: "..skillName
	end
	return localized, skillName
end

local staticDataItem={}
local emptyTable={}
local staticDataID
local cache = setmetatable({}, {__mode="v"})
function getItem(itemID, static)
	if (not itemID) then return end
	if (static and staticDataID and staticDataID==itemID) then return staticDataItem end
	if cache[itemID] then return cache[itemID] end
	
	local baseData = self.database[itemID]
	local buy, class, quality, stack, additional, usedby, quantity, limited, merchantlist
	local itemName, itemLink, itemQuality, itemLevel, itemUseLevel, itemType, itemSubType, itemStackSize, itemEquipLoc, itemTexture = GetItemInfo(tonumber(itemID))

	if (baseData) then
		buy, class, quality, stack, additional, usedby, quantity, limited, merchantlist = strsplit(":", baseData)
		buy = tonumber(buy)
	end
	
	-- work around a blizzard bug where honor tokens return stack size 2147483647
	-- this only seems to happen for the obsolete honor tokens shown in the currency frame
	-- See JIRA INF-41
	if (itemStackSize == 2147483647) then
		itemStackSize = nil
		stack = nil
	end
	
	-- if we have a local correction for this item, merge in the corrected data
	local itemUpdateData
	if (InformantLocalUpdates and InformantLocalUpdates.items) then
		itemUpdateData = InformantLocalUpdates.items[ itemID ]
		if (itemUpdateData) then
			if (itemUpdateData.buy) then
				buy = tonumber(itemUpdateData.buy)
			end
			if (itemUpdateData.sell) then
				sell = tonumber(itemUpdateData.sell)
			end
			if (itemUpdateData.stack) then
				stack = tonumber(itemUpdateData.stack)
			end
			if (itemUpdateData.quantity) then
				quantity = tonumber(itemUpdateData.quantity)
			end
		end
	end

	class = tonumber(class)
	quality = tonumber(quality) or itemQuality
	stack = tonumber(itemStackSize) or tonumber(stack)
	local cat = CLASS_TO_CATEGORY_MAP[class]

	sell = select(11,GetItemInfo(itemID))
	local dataItem = (static and staticDataItem or {})
	dataItem.buy = buy
	dataItem.sell = sell
	dataItem.class = class
	dataItem.classText = itemType
	dataItem.cat = cat
	dataItem.quality = quality
	dataItem.stack = stack
	dataItem.additional = additional
	dataItem.usedby = usedby
	dataItem.quantity = quantity
	dataItem.limited = limited
	dataItem.texture = itemTexture
	dataItem.itemLevel = itemLevel
	dataItem.reqLevel = itemUseLevel

	local addition = ""
	if (additional and additional ~= "") then
		addition = " - ".._TRANS('INF_Tooltip_Addit'..additional)
	end
	local catName = getCatName(cat)
	if (not catName) then
		if (itemType) then
			dataItem.classText = itemType..addition
		else
			dataItem.classText = "Unknown"..addition
		end
	else
		dataItem.classText = catName..addition
	end

	if (usedby and usedby ~= '') then
		local usedList = split(usedby, ",")
		local skillName, localized, localeString
		local usage = ""
		dataItem.usedList = {}
		if (usedList) then
			for pos, userSkill in pairs(usedList) do
				localized = skillToName(userSkill)
				if (usage == "") then
					usage = localized
				else
					usage = usage .. ", " .. localized
				end
				tinsert(dataItem.usedList, localized)
			end
		end
		dataItem.usageText = usage
	else
		dataItem.usedList = nil
		dataItem.usageText = nil
	end

	local tradeSkillCode = 0
	local tradeSkillLevel = 0
	local tradeSkillName = ""

	local skillsRequired = self.requirements[itemID]
	if (skillsRequired) then
		tradeSkillCode, tradeSkillLevel = strsplit(":", skillsRequired)
		tradeSkillName = skillToName(tradeSkillCode)
	end

	dataItem.isPlayerMade = (tradeSkillCode ~= 0)
	dataItem.tradeSkillLevel = tradeSkillLevel
	dataItem.tradeSkillCode = tradeSkillCode
	dataItem.tradeSkillName = tradeSkillName

	if (merchantlist ~= '') then
		local merchList = split(merchantlist, ",")
		if (itemUpdateData and itemUpdateData.merchants) then
			-- check update list for additional merchants
			local moreMerch = split(itemUpdateData.merchants, ",")
			if (#moreMerch > 0 and not merchList) then merchList = {} end
			for pos, merchID in pairs(moreMerch) do
				tinsert(merchList, merchID)
			end
		end
		local vendList = {}
		local vendLoc = {}
		if (merchList) then
			for pos, merchID in pairs(merchList) do
				merchID = tonumber(merchID)
				local vendName = self.vendors[ merchID ]
				if (not vendName and InformantLocalUpdates and InformantLocalUpdates.vendor) then
					-- can't find it, try the update list
					local vendorInfo = InformantLocalUpdates.vendor[ merchID ]
					if (vendorInfo) then
						vendName = vendorInfo.name
					end
				end
				if (vendName) then
					tinsert(vendList, vendName)
					local zone,xloc,yloc
					if self.vendorLocation[merchID] then
						zone,xloc,yloc = strsplit(",",self.vendorLocation[merchID])
					end
					if zone then
						local location
						zone = tonumber(zone)
						if self.infZones[zone] then
							zone = self.infZones[zone]
						end
						location = zone
						if xloc and yloc then
							location = location.." ("..xloc..","..yloc..")"
						end
						vendLoc[vendName] = location
					else
						vendLoc[vendName] = "No set location for this vendor"
					end
				end
			end
		end
		dataItem.merchantList = merchList
		dataItem.vendors = vendList
		dataItem.vendorLoc = vendLoc
	else
		dataItem.merchantList = nil
		dataItem.vendors = nil
	end

	dataItem.startsQuest = self.questStarts[itemID]

	local questItemUse = self.questRequires[itemID]
	if (questItemUse) then
		local list
		if (type(questItemUse) == 'number') then
			list = { questItemUse }
		else
			list = { strsplit(',', questItemUse) }
		end
		for i=1, #list do
			list[i] = { strsplit('x', list[i]) }
			list[i][1] = tonumber(list[i][1])
			if not list[i][2] then list[i][2] = 1 end
		end
		dataItem.requiredFor = list
	else
		dataItem.requiredFor = (static and emptyTable or {})
	end

	questItemUse = self.questRewards[itemID]
	if (questItemUse) then
		local list
		if (type(questItemUse) == 'number') then
			list = { questItemUse }
		else
			list = { strsplit(',', questItemUse) }
		end
		for i=1, #list do
			list[i] = tonumber(list[i])
		end
		dataItem.rewardFrom = list
	else
		dataItem.rewardFrom = (static and emptyTable or {})
	end
	
	-- see if this is a recipe, and what it might create
	if (self.crafted) then
		local recipe_number = tonumber(itemID)
		local crafted_item = self.crafted[ recipe_number ]
		if (crafted_item) then
			dataItem.crafts = crafted_item
			-- see if it crafts more than 1 at a time
			if (self.craftCount) then
				local crafted_count = self.craftCount[ recipe_number ]
				dataItem.craftsCount = crafted_count or 1
			end
		end
	end
	
	-- we adjusted the static table, if called with static = true
	-- so save the itemID for future calls
	if static then
		staticDataID = itemID
	else
		cache[itemID] = dataItem
	end
	return dataItem
end

local function getInformantVendorInfo(id)
	local isVendored,isLimited,itemCost,toSell,buyStack,maxStack
	local itemID = tonumber(id)
	local itemData = getItem(itemID)
	if itemData.merchantList then
		isVendored = true
	else
		isVendored = false
	end
	local itemLimited = itemData.limited
	if itemLimited and tonumber(itemLimited) > 0 then
		isLimited = true
	else
		isLimited = false
	end
	itemCost = tonumber(itemData.buy) or 0
	toSell = tonumber(itemData.sell) or 0
	buyStack = tonumber(itemData.quantity) or 1
	maxStack = tonumber(itemData.stack) or 1
	return isVendored,isLimited,itemCost,toSell,buyStack,maxStack
end

--Implementation of GetSellValue API proposed by Tekkub at http://www.wowwiki.com/API_GetSellValue
local origGetSellValue = GetSellValue
function GetSellValue(item)
	local itemName, itemLink, _, _, _, _, _, _, _, _, itemSellPrice = GetItemInfo(item)
	if itemSellPrice then
		return itemSellPrice
	end

	local id
	if type(item) == "number" then
		id = item
	elseif type(item) == "string" then
		id = tonumber(strmatch(item, "item:(%d+)"))
		if not id and itemLink then
			id = tonumber(strmatch(itemLink, "item:(%d+)"))
		end
	end

	-- Return out if we didn't find an id
	if not id then return end

	local itemInfo = Informant.GetItem(id)
	local sellval

-- ccox - TODO - is this correct for items sold in stacks?
-- see Informant.TooltipHandler

	if (itemInfo) then
		sellval = itemInfo.sell
		if (sellval) then
			sellval = tonumber(sellval)
		end
	end

	if sellval then
		return sellval
	elseif origGetSellValue then
		-- Call our hook if present, pass the id to save processing it again
		return origGetSellValue(id)
	end
end

function setSkills(skills)
	self.skills = skills
	Informant.SetSkills = nil -- Set only once
end
function setRequirements(requirements)
	self.requirements = requirements
	Informant.SetRequirements = nil -- Set only once
end
function setVendors(vendors)
	self.vendors = vendors
	Informant.SetVendors = nil -- Set only once
end
function setDatabase(database)
	self.database = database
	Informant.SetDatabase = nil -- Set only once
end
function setQuestStarts(list)
	self.questStarts = list
	Informant.SetQuestStarts = nil -- Set only once
end
function setQuestRewards(list)
	self.questRewards = list
	Informant.SetQuestRewards = nil -- Set only once
end
function setQuestRequires(list)
	self.questRequires = list
	Informant.SetQuestRequires = nil -- Set only once
end
function setQuestNames(list)
	self.questNames = list
	Informant.SetQuestNames = nil -- Set only once
end
function setVendorLocation(list)
	self.vendorLocation = list
	Informant.SetVendorLocation = nil -- Set only once
end
function setZones(zones)
	self.infZones = zones
	Informant.zonestest = self.infZones
	Informant.SetZones = nil -- Set only once
end
function setCrafted(crafted)
	self.crafted = crafted
	Informant.SetCrafted = nil -- Set only once
end
function setCraftCount(craft_counts)
	self.craftCount = craft_counts
	Informant.SetCraftCount = nil -- Set only once
end

function getLocale()
	local locale = Informant.GetFilterVal('locale');
	if (locale ~= 'on') and (locale ~= 'off') and (locale ~= 'default') then
		return locale;
	end
	return GetLocale();
end

local categories = {GetAuctionItemClasses()};
function getCatName(catID)
	for cat, name in ipairs(categories) do
		if (cat == catID) then
			return name
		end
	end
end

local function getQuestName(questID)
	questID = tonumber(questID) or 0
	local questName
	if (self.questNames[questID]) then
		questName = self.questNames[questID]
	else
		questName = _TRANS('INF_Interface_InfWinQuestUnknown'):format(questID)
	end
	-- format as just text, looks better
	return "|cff5599ff"..questName

-- try to format as a link, but we don't make it clickable anywhere
-- if we want a linkable quest, we'll have to redo this
--	return "|HinfQuest:"..questID.."|h|cff5599ff["..questName.."]|r|h"
end

local function showItem(itemInfo)
	if (itemInfo) then
		InformantFrameTitle:SetText(_TRANS('INF_Interface_InfWinTitle'))

		-- Woohoo! We need to provide any information we can from the item currently in itemInfo
		local quality = itemInfo.itemQuality or itemInfo.quality or 0

		local color = "ffffff"
		if (quality == 4) then color = "a335ee"
		elseif (quality == 3) then color = "0070dd"
		elseif (quality == 2) then color = "1eff00"
		elseif (quality == 0) then color = "9d9d9d"
		end

		clear()
		addLine(_TRANS('INF_Interface_InfWinInfoHeader'):format(color, itemInfo.itemName))

		local buy = itemInfo.itemBuy or itemInfo.buy or 0
		local sell = itemInfo.itemSell or itemInfo.sell or 0
		local quant = itemInfo.itemQuant or itemInfo.quantity or 0
		local count = itemInfo.itemCount or 1

		if ((buy > 0) or (sell > 0)) then
			local bgsc = tooltip:Coins(buy)
			local sgsc = tooltip:Coins(sell)

			if (count and (count > 1)) then
				local bqgsc = tooltip:Coins(buy*count)
				local sqgsc = tooltip:Coins(sell*count)
				addLine(_TRANS('INF_Tooltip_ShowVendorBuyMult'):format(count, bgsc)..": "..bqgsc, "ee8822")
				addLine(_TRANS('INF_Tooltip_ShowVendorSellMult'):format(count, sgsc)..": "..sqgsc, "ee8822")
			else
				addLine(_TRANS('INF_Tooltip_ShowVendorBuy'):format()..": "..bgsc, "ee8822")
				addLine(_TRANS('INF_Tooltip_ShowVendorSell'):format()..": "..sgsc, "ee8822")
			end
		end

		if (itemInfo.stack and itemInfo.stack > 1) then
			addLine(_TRANS('INF_Tooltip_StackSize'):format(itemInfo.stack))
		end

		local reagentInfo = ""
		if (itemInfo.classText and itemInfo.classText ~= "") then
			reagentInfo = _TRANS('INF_Tooltip_Class'):format(itemInfo.classText)
			addLine(reagentInfo, "aa66ee")
		end

		if (itemInfo.usageText and itemInfo.usageText ~= "") then
			reagentInfo = _TRANS('INF_Tooltip_Use'):format(itemInfo.usageText)
			addLine(reagentInfo, "aa66ee")
		end

		if (itemInfo.isPlayerMade) then
			addLine(_TRANS('INF_Interface_InfWinPlayerMade'):format(itemInfo.tradeSkillLevel, itemInfo.tradeSkillName), "5060ff")
		end
		
		local numReq = 0
		local numRew = 0
		local numSta = 0
		if (itemInfo.startsQuest) then numSta = 1 end
		if (itemInfo.requiredFor) then numReq = #itemInfo.requiredFor end
		if (itemInfo.rewardFrom) then numRew = #itemInfo.rewardFrom end

		local questCount = numReq + numRew + numSta

		if (questCount > 0) then
			addLine("")
			addLine(_TRANS('INF_Interface_InfWinQuest'):format(questCount), nil, nil --[[TODO: this used to say: embed. what gives?!]])

			if (numSta > 0) then
				addLine(_TRANS('INF_Interface_InfWinQuestStart'), "70ee90")
				addLine("  ".._TRANS('INF_Interface_InfWinQuestLine'):format(getQuestName(itemInfo.startsQuest)), "80ee80")
			end
			if (numRew > 0) then
				addLine(_TRANS('INF_Interface_InfWinQuestReward'):format(numRew), "70ee90")
				for i=1, numRew do
					local quest = itemInfo.rewardFrom[i]
					addLine("  ".._TRANS('INF_Interface_InfWinQuestLine'):format(getQuestName(quest)), "80ee80")
				end
			end
			if (numReq > 0) then
				addLine(_TRANS('INF_Interface_InfWinQuestRequires'):format(numReq), "70ee90")
				for i=1, numReq do
					local quest = itemInfo.requiredFor[i]
					addLine("  ".._TRANS('INF_Interface_InfWinQuestMultiLine'):format(quest[2], getQuestName(quest[1])), "80ee80")
				end
			end
			addLine(_TRANS('INF_Interface_InfWinQuestSource'):format().." WoWHead.com");
		end

		if (itemInfo.vendors) then
			local vendorCount = #itemInfo.vendors
			if (vendorCount > 0) then
				addLine("")
				addLine(_TRANS('INF_Interface_InfWinVendorCount'):format(vendorCount), "ddff40")
				for pos, merchant in pairs(itemInfo.vendors) do
					addLine("-".._TRANS('INF_Interface_InfWinVendorName'):format(merchant), "dede3c")
					if itemInfo.vendorLoc[merchant] then
						addLine("     ".._TRANS('INF_Interface_InfWinVendorName'):format(itemInfo.vendorLoc[merchant]), "ffff86")
					end
				end
			end
		end
		InformantFrame:Show()
	else
		clear()
		addLine(_TRANS('INF_Interface_InfWinNoItem'), "ff4010")
		InformantFrame:Show()
	end
end

function showHideInfo(iType, iId)
	if not iType then iType = "curitem" end
	iId = tonumber(iId) or 0

	local iTypeCur = tostring(InformantFrame.iType)
	local iIdCur = tonumber(InformantFrame.iId) or 0

	if (InformantFrame:IsVisible() and iType == iTypeCur and iId == iIdCur) then
		return InformantFrame:Hide()
	elseif (iType == "curitem") then
		showItem(Informant.itemInfo)
	elseif (iType == "item") then
	elseif (iType == "quest") then
	end
end





function OnTooltipAddMoney(self, money)
	Informant_ScanTooltip.scanningMoneyFound = money
end


local function TooltipScanBagItem(bag, slot)
	local tt = Informant_ScanTooltip
	tt.scanningMoneyFound = false
	tt:ClearLines()
	local _, count = GetContainerItemInfo(bag, slot)
	if (not count or count < 1) then return end
	tt.scanningStack = count

	-- magic happens here as OnTooltipAddMoney gets called
	local _, repairCost = tt:SetBagItem(bag, slot)
	if (type(repairCost) == "number" and repairCost > 0) then
		-- don't count price for items that need repair
		tt.scanningMoneyFound = false
		return
	end
end


local function updateSellPricesFromMerchant()
	if (not InformantLocalUpdates.items) then InformantLocalUpdates.items = {} end
	local tt = Informant_ScanTooltip
	
	for bag = 0, NUM_BAG_FRAMES do
		for slot = 1, GetContainerNumSlots(bag) do
			local scanningLink = GetContainerItemLink(bag, slot)
			if (scanningLink) then
				TooltipScanBagItem(bag, slot)
				if (tt.scanningMoneyFound) then
					local itemid = idFromLink(scanningLink)
					local informantItemInfo = getItem( itemid )
					if (informantItemInfo) then

						local sellPrice = tt.scanningMoneyFound / tt.scanningStack

						if (informantItemInfo.sell ~= sellPrice) then
							-- is this item sell price correct in our database? or missing from our database?
							local itemName, itemLink, itemQuality, itemLevel, itemUseLevel, itemType, itemSubType, itemStackSize, itemEquipLoc, itemTexture = GetItemInfo(scanningLink)

							local newItemInfo = InformantLocalUpdates.items[ itemid ]
							if (not newItemInfo) then newItemInfo = {} end
							newItemInfo.sell = sellPrice
							newItemInfo.stack = itemStackSize
							newItemInfo.quantity = itemStackSize
							InformantLocalUpdates.items[ itemid ] = newItemInfo

						end

					end
				end	-- if money found
			end	-- if link
		end	-- for slot
	end	-- for bag
end


local function updateBuyPricesFromMerchant( vendorID )
	if (not InformantLocalUpdates.items) then InformantLocalUpdates.items = {} end
	for index = 1, GetMerchantNumItems() do
		local link = GetMerchantItemLink(index)
		if (link) then
			local itemid = idFromLink( link )
			local name, texture, price, quantity, numAvailable, isUsableFlag, extendedCostFlag = GetMerchantItemInfo(index)
			if (extendedCostFlag) then
				--local honorPoints, arenaPoints, itemCount = GetMerchantItemCostInfo(index);
				-- NOTE - currently not using this information
			end

			local informantItemInfo = getItem( itemid )
			if (informantItemInfo) then		-- this should always be true

				if (price ~= informantItemInfo.buy) then
					-- is this item buy price correct in our database? or missing from our database?

					local itemName, itemLink, itemQuality, itemLevel, itemUseLevel, itemType, itemSubType, itemStackSize, itemEquipLoc, itemTexture = GetItemInfo(link)

-- ccox - currently this will hit often, because we don't take reputation discounts into account for buy pricing
-- should we try to get rep discounts, or just update the price as seen?  Then they'll be wrong for alts!
-- could we account for the rep discounts and calculate a baseline?

					local newItemInfo = InformantLocalUpdates.items[ itemid ]
					if (not newItemInfo) then newItemInfo = {} end
					newItemInfo.buy = price
					newItemInfo.stack = itemStackSize
					newItemInfo.quantity = quantity
					InformantLocalUpdates.items[ itemid ] = newItemInfo

				end

				local foundMerchant = false
				if (informantItemInfo.merchantList) then
					-- some vendors are known for this item, check the list and see if this vendor is on it
					for pos, merchID in pairs(informantItemInfo.merchantList) do
						merchID = tonumber(merchID)
						if (merchID == vendorID) then
							foundMerchant = true
							break
						end
					end
				end

				-- if no vendors are known, or this vendor isn't on the list, add this vendor
				if (not foundMerchant) then
					local newItemInfo = InformantLocalUpdates.items[ itemid ]
					if (not newItemInfo) then newItemInfo = {} end
					local oldList = newItemInfo.merchants
					
					if (oldList) then
						local moreMerch = split(oldList, ",")
						for pos, merchID in pairs(moreMerch) do
							if (tonumber(merchID) == vendorID) then
								foundMerchant = true
								break
							end
						end
					end
					
					if (not foundMerchant) then
						if (oldList) then
							newItemInfo.merchants = oldList..","..tostring( vendorID )
						else
							newItemInfo.merchants = tostring( vendorID )
						end
	
						InformantLocalUpdates.items[ itemid ] = newItemInfo
					end
				end

			end	-- if info
		end	-- if link
	end	--	for GetMerchantNumItems
end


local function updateMerchantName()

	if (not InformantLocalUpdates.vendor) then InformantLocalUpdates.vendor = {} end

	local vendorName = UnitName("NPC")
	local vendorFaction = UnitFactionGroup("NPC")
	if (vendorFaction ~= UnitFactionGroup("player")) then
		vendorFaction = "Neutral"
	end
	-- TODO - we are not currently using the faction information for vendors

	local vendorGUID = UnitGUID("NPC")
	local vendorID = tonumber(strsub(vendorGUID,6,12),16)

	if (not self.vendors[ vendorID ] and not InformantLocalUpdates.vendor[ vendorID ]) then
		-- add the new vendor name to our update list
		local vendorInfo = {}
		vendorInfo.name = vendorName;
		vendorInfo.faction = vendorFaction;
		InformantLocalUpdates.vendor[ vendorID ] = vendorInfo
	end

	return vendorID
end


local function doUpdateMerchant()

	if (not InformantLocalUpdates) then InformantLocalUpdates = {} end

	if ((not MerchantFrame:IsVisible()) or InRepairMode()) then return end

	if (not Informant.Settings.GetSetting('auto-update')) then return end

	local vendorID = updateMerchantName()
	updateBuyPricesFromMerchant( vendorID )
	updateSellPricesFromMerchant()

	wipe(cache)
end


-- cleanup data errors
-- INF-77 - duplicate merchant IDs crept in, blowing the length of the string
local function scrubLocalUpdateInfo()

	if (InformantLocalUpdates and InformantLocalUpdates.items
		and not InformantLocalUpdates.scrubbedForDupeMerchants) then
		
		for itemID, itemInfo in pairs(InformantLocalUpdates.items) do
			if (itemInfo.merchants) then
				
				-- make sure vendor IDs are unique by regenerating the list into a table
				local newTable = {}
				local merchList = split(itemInfo.merchants, ",")
				for pos, merchID in pairs(merchList) do
					newTable[ tonumber( merchID ) ] = true
				end
				
				-- then converting that table back into our string format
				local first = true
				local newList
				for merchID, _ in pairs(newTable) do
					if (first) then
						newList = tostring( merchID )
					else
						newList = newList..","..tostring( merchID )
					end
					first = false
				end
				
				-- finally, replace the existing info with scrubbed info
				itemInfo.merchants = newList
				InformantLocalUpdates.items[ itemID ] = itemInfo
				
			end
		end
		
		InformantLocalUpdates.scrubbedForDupeMerchants = true;	-- we should only do this once
	end

end


function onQuit()
	if (not InformantConfig.position) then
		InformantConfig.position = { }
	end
	InformantConfig.position.x, InformantConfig.position.y = InformantFrame:GetCenter()
end

local function slidebarclickhandler(_, button)
	--if we rightclick open the configuration window for the whole addon
	Informant.Settings.MakeGuiConfig()
	local gui = Informant.Settings.Gui
	if (gui:IsVisible()) then
		gui:Hide()
	else
		gui:Show()
	end
end

local sideIcon
local function slidebar()
	if LibStub then
		local SlideBar = LibStub:GetLibrary("SlideBar", true)
		if SlideBar then
			sideIcon = SlideBar.AddButton("Informant", "Interface\\AddOns\\Informant\\inficon")
			sideIcon:RegisterForClicks("LeftButtonUp","RightButtonUp")
			sideIcon:SetScript("OnClick", slidebarclickhandler)
			sideIcon.tip = {
				"Informant Configuration",
			}
		end
	end
end

function onLoad()
	this:RegisterEvent("ADDON_LOADED")
	
	Informant_ScanTooltip:SetScript("OnTooltipAddMoney", OnTooltipAddMoney);
	
	this:RegisterEvent("MERCHANT_SHOW");
	this:RegisterEvent("MERCHANT_UPDATE");

	Informant_ScanTooltip:SetScript("OnTooltipAddMoney", OnTooltipAddMoney);

	this:RegisterEvent("MERCHANT_SHOW");
	this:RegisterEvent("MERCHANT_UPDATE");

	InformantFrameTitle:SetText(_TRANS('INF_Interface_InfWinTitle'))
	slidebar()
end

local function frameLoaded()
	Stubby.RegisterEventHook("PLAYER_LEAVING_WORLD", "Informant", onQuit)

	tooltip:Activate()
	tooltip:AddCallback(Informant.TooltipHandler, 300)

	onLoad()

	-- Setup the default for stubby to always load (people can override this on a
	-- per toon basis)
	Stubby.SetConfig("Informant", "LoadType", "always", true)
	
	-- Register our temporary command hook with stubby
	Stubby.RegisterBootCode("Informant", "CommandHandler", 
	-- Localize Me! 
	[[
		local function cmdHandler(msg)
			local cmd, param = msg:lower():match("^(%w+)%s*(.*)$")
			cmd = cmd or msg:lower() or "";
			param = param or "";
			if (cmd == "load") then
				if (param == "") then
					Stubby.Print("Manually loading Informant...")
					LoadAddOn("Informant")
				elseif (param == "always") then
					Stubby.Print("Setting Informant to always load for this character")
					Stubby.SetConfig("Informant", "LoadType", param)
					LoadAddOn("Informant")
				elseif (param == "never") then
					Stubby.Print("Setting Informant to never load automatically for this character (you may still load manually)")
					Stubby.SetConfig("Informant", "LoadType", param)
				else
					Stubby.Print("Your command was not understood")
				end
			else
				Stubby.Print("Informant is currently not loaded.")
				Stubby.Print("  You may load it now by typing |cffffffff/informant load|r")
				Stubby.Print("  You may also set your loading preferences for this character by using the following commands:")
				Stubby.Print("  |cffffffff/informant load always|r - Informant will always load for this character")
				Stubby.Print("  |cffffffff/informant load never|r - Informant will never load automatically for this character (you may still load it manually)")
			end
		end
		SLASH_INFORMANT1 = "/informant"
		SLASH_INFORMANT2 = "/inform"
		SLASH_INFORMANT3 = "/info"
		SLASH_INFORMANT4 = "/inf"
		SlashCmdList["INFORMANT"] = cmdHandler
	]]);
	Stubby.RegisterBootCode("Informant", "Triggers", [[
		local loadType = Stubby.GetConfig("Informant", "LoadType")
		if (loadType == "always") then
			LoadAddOn("Informant")
		else
			Stubby.Print("]].._TRANS('INF_Help_CmdLoadMsg')..[[");
		end
	]]);
end

function onVariablesLoaded()
	if (not InformantConfig) then
		InformantConfig = {}
	end

	InformantFrameTitle:SetText(_TRANS('INF_Interface_InfWinTitle'))

	if (InformantConfig.position) then
		InformantFrame:ClearAllPoints()
		InformantFrame:SetPoint("CENTER", UIParent, "BOTTOMLEFT", InformantConfig.position.x, InformantConfig.position.y)
	end

	if (not InformantConfig.welcomed) then
		clear()
		addLine(_TRANS('INF_Help_FirstUse'))
		InformantConfig.welcomed = true
	end

	Informant.InitCommands()
end

function onEvent(event, addon)

	if (event == "ADDON_LOADED" and addon:lower() == "informant") then
		onVariablesLoaded()
		this:UnregisterEvent("ADDON_LOADED")
		scrubLocalUpdateInfo()		-- to fix up data errors
	end

	if( event == "MERCHANT_SHOW" or event == "MERCHANT_UPDATE" ) then
		doUpdateMerchant()
	end
	
end

function frameActive(isActive)
	if (isActive) then
		scrollUpdate(0)
	end
end

function getRowCount()
	return #lines
end

function scrollUpdate()
	local numLines = getRowCount()
	local offset = 0
	if (numLines > 25) then
		offset = FauxScrollFrame_GetOffset(InformantFrameScrollBar)
	end
	local line
	for i=1, 25 do
		line = lines[i+offset]
		local f = _G[format("InformantFrameText%d",i)]
		if (line) then
			f:SetText(line)
			f:Show()
		else
			f:Hide()
		end
	end
	if (numLines > 25) then
		FauxScrollFrame_Update(InformantFrameScrollBar, numLines, 25, numLines)
		InformantFrameScrollBar:Show()
	else
		InformantFrameScrollBar:Hide()
	end
end

local function testWrap(text)
	InformantFrameTextTest:SetText(text)
	if (InformantFrameTextTest:GetWidth() < InformantFrame:GetWidth() - 20) then
		return text, ""
	end

	local pos, test, best, rest
	best = text
	rest = nil
	pos = text:find("%s")
	while (pos) do
		test = text:sub(1, pos-1)
		InformantFrameTextTest:SetText(test)
		if (InformantFrameTextTest:GetWidth() < InformantFrame:GetWidth() - 20) or (not rest) then
			best = test
			rest = test:sub(pos+1)
		else
			break
		end
		pos = text:find("%s", pos+1)
	end
	return best, rest
end

function addLine(text, color, level)
	if (not text) then return end
	if (not level) then level = 1 end
	if (level > 100) then
		return
	end

	if (type(text) == "table") then
		for pos, line in pairs(text) do
			addLine(line, color, level)
		end
		return
	end

	if (not text) then
		tinsert(lines, "nil")
	else
		local best, rest = testWrap(text)
		if (color) then
			tinsert(lines, ("|cff%s%s|r"):format(color, best))
		else
			tinsert(lines, best)
		end
		if (rest) and (rest ~= "") then
			addLine(rest, color, level+1)
		end
	end
	scrollUpdate()
end

function clear()
	lines = {}
	scrollUpdate()
end

-- GLOBAL OBJECT

local DebugLib = LibStub("DebugLib")
local debug, assert, printquick
if DebugLib then
	debug, assert, printquick = DebugLib("Informant")
else
	function debug() end
	assert = debug
	printquick = debug
end

-------------------------------------------------------------------------------
-- Prints the specified message to nLog.
--
-- syntax:
--    errorCode, message = infDebugPrint([message][, category][, title][, errorCode][, level])
--
-- parameters:
--    message   - (string) the error message
--                nil, no error message specified
--    category  - (string) the category of the debug message
--                nil, no category specified
--    title     - (string) the title for the debug message
--                nil, no title specified
--    errorCode - (number) the error code
--                nil, no error code specified
--    level     - (string) nLog message level
--                         Any nLog.levels string is valid.
--                nil, no level specified
--
-- returns:
--    errorCode - (number) errorCode, if one is specified
--                nil, otherwise
--    message   - (string) message, if one is specified
--                nil, otherwise
-------------------------------------------------------------------------------
function infDebugPrint(message, category, title, errorCode, level)
	return debug(addonName, message, category, title, errorCode, level)
end

-------------------------------------------------------------------------------
-- Prints the specified message to nLog.
--
-- syntax:
--    errorCode, message = debugPrint([message][, title][, errorCode][, level])
--
-- parameters:
--    message   - (string) the error message
--                nil, no error message specified
--    title     - (string) the title for the debug message
--                nil, no title specified
--    errorCode - (number) the error code
--                nil, no error code specified
--    level     - (string) nLog message level
--                         Any nLog.levels string is valid.
--                nil, no level specified
--
-- returns:
--    errorCode - (number) errorCode, if one is specified
--                nil, otherwise
--    message   - (string) message, if one is specified
--                nil, otherwise
-------------------------------------------------------------------------------
function debugPrint(message, title, errorCode, level)
	return Informant.DebugPrint(message, "InfMain", title, errorCode, level)
end

function Dump(...)
	return debug:Dump(...)
end

function debugPrintQuick(...)
	return printquick(...)
end

Informant = {
	version = INFORMANT_VERSION,
	GetItem = getItem,
	GetRowCount = getRowCount,
	AddLine = addLine,
	Clear = clear,
	ShowHideInfo = showHideInfo,
	getItemVendorInfo = getInformantVendorInfo,

	-- These functions are only meant for internal use.
	SetSkills = setSkills,
	SetRequirements = setRequirements,
	SetVendors = setVendors,
	SetDatabase = setDatabase,
	SetQuestStarts = setQuestStarts,
	SetQuestRewards = setQuestRewards,
	SetQuestRequires = setQuestRequires,
	SetQuestNames = setQuestNames,
	SetVendorLocation = setVendorLocation,
	SetZones = setZones,
	SetCrafted = setCrafted,
	SetCraftCount = setCraftCount,
	FrameActive = frameActive,
	FrameLoaded = frameLoaded,
	ScrollUpdate = scrollUpdate,
	GetLocale = getLocale,
	GetQuestName = getQuestName,
	OnEvent = onEvent,
	DebugPrint = infDebugPrint,
	DebugPrintQuick = debugPrintQuick
}

_G.Informant = Informant

