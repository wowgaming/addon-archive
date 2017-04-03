--[[
Name: LibTipHooker-1.1.lua
Description: A Library for hooking tooltips.
Revision: $Revision: 7 $
Author: Whitetooth
Email: hotdogee [at] gmail [dot] com
LastUpdate: $Date: 2009-08-09 17:24:10 +0000 (Sun, 09 Aug 2009) $
Website:
Documentation:
SVN: $URL $
License: LGPL v3
]]

--[[ Features
{
1. Why not use the OnTooltipSetItem script hook?
	OnTooltipSetItem is bugged that it's called twice on proffesion patterns, once for the pattern and once for the item it makes.
2. Maintains support for most tooltip mods
3. Hooks dynamically created tooltips
}
--]]
--[[ Tips for using TipHooker
{
This library provides tooltip hooks, mainly for use with item tooltip modification, you can easily append or modify text in a tooltip with TipHookerLib.
If you need to not only modify the tooltip but also need to scan the tooltip for information, you should use other libraries with TipHookerLib.
Because TipHookerLib passes the real tooltip frame to your handler function,
which may already be modifided by other addons and may not be suited for scanning.
For simple custom scaning you can use GratuityLib, it creates a custom tooltip and scan that for patterns.
For a complete item scanning solution to stat scanning you can use ItemBonusLib or StatLogicLib.
}
--]]


local MAJOR = "LibTipHooker-1.1"
local MINOR = "$Revision: 7 $"

local TipHooker = LibStub:NewLibrary(MAJOR, MINOR)
if not TipHooker then return end

local VariablesLoaded

-----------
-- Tools --
-----------
local DEBUG = false

-- Localize globals
local _G = getfenv(0)
local type = type
local pairs = pairs
local select = select
local ipairs = ipairs
local strfind = strfind
local tinsert = tinsert
local hooksecurefunc = hooksecurefunc
local EnumerateFrames = EnumerateFrames

local function print(text)
	if DEBUG then
		DEFAULT_CHAT_FRAME:AddMessage(text)
	end
end

-----------------------
-- Hook Tooltip Core --
-----------------------
local TooltipList = {
	item = {
		"GameTooltip",
		"ItemRefTooltip",
		"ShoppingTooltip",
		"ComparisonTooltip",-- EquipCompare
		"EQCompareTooltip",-- EQCompare
		"tekKompareTooltip",-- tekKompare
		"LinkWrangler",-- LinkWrangler
		"LinksTooltip",-- Links
		"AtlasLootTooltip",-- AtlasLoot
		"ItemMagicTooltip",-- ItemMagic
		"SniffTooltip",-- Sniff
		"MirrorTooltip",-- Mirror
		"TooltipExchange_TooltipShow",-- TooltipExchange
		"AtlasQuestTooltip",-- AtlasQuest
	},
	buff = {
		"GameTooltip",
	},
	spell = {
		"GameTooltip",
	},
	talant = {
		"GameTooltip",
	},
	unit = {
		"GameTooltip",
	},
	action = {
		"GameTooltip",
	},
}

local MethodList = {
	item = {
		"SetHyperlink",
		"SetBagItem",
		"SetInventoryItem",
		-- auction
		"SetAuctionItem",
		"SetAuctionSellItem",
		-- loot
		"SetLootItem",
		"SetLootRollItem",
		-- crafting
		"SetTradeSkillItem",
		"SetTrainerService",
		-- mail
		"SetInboxItem",
		"SetSendMailItem",
		-- quest log
		"SetQuestItem",
		"SetQuestLogItem",
		-- trade
		"SetTradePlayerItem",
		"SetTradeTargetItem",
		-- vendor tooltip
		"SetMerchantItem",
		"SetBuybackItem",
		"SetMerchantCostItem",
		-- socketing interface
		"SetSocketGem",
		"SetExistingSocketGem",
		-- 2.1.0
		"SetHyperlinkCompareItem",
		-- 2.3.0
		"SetGuildBankItem",
		-- 3.0
		"SetCurrencyToken",
		"SetBackpackToken",
	},
	buff = {
		"SetPlayerBuff",
		"SetUnitBuff",
		"SetUnitDebuff",
	},
	spell = {
		"SetSpell",
		"SetTrackingSpell",
		"SetShapeshift",
	},
	talant = {
		"SetTalent",
	},
	unit = {
		"SetUnit",
	},
	action = {
		"SetAction",
		"SetPetAction",
	},
}

local HandlerList = TipHooker.HandlerList or {}
TipHooker.HandlerList = HandlerList
local Set = {
	item = function(tooltip, ...)
		if not tooltip.GetItem then return end
		local name, link = tooltip:GetItem()
		if not name then return end -- Check if tooltip really has an item
		for handler in pairs(HandlerList.item) do
			handler(tooltip, name, link)
		end
	end,
	buff = function(tooltip, unitId, buffIndex, raidFilter)
		if not unitId then
			unitId = "player"
		end
		for handler in pairs(HandlerList.buff) do
			handler(tooltip, unitId, buffIndex, raidFilter)
		end
	end,
	spell = function(tooltip, spellId, bookType)
		for handler in pairs(HandlerList.spell) do
			handler(tooltip, spellId, bookType)
		end
	end,
	talant = function(tooltip, tabIndex, talentIndex)
		for handler in pairs(HandlerList.talant) do
			handler(tooltip, tabIndex, talentIndex)
		end
	end,
	unit = function(tooltip, unit)
		if not tooltip.GetUnit then return end
		local name = tooltip:GetUnit()
		for handler in pairs(HandlerList.unit) do
			handler(tooltip, unit)
		end
	end,
	action = function(tooltip, slot)
		for handler in pairs(HandlerList.action) do
			handler(tooltip, slot)
		end
	end,
}


-- This gets called during VARIABLES_LOADED and :Hook()
-- InitializeHook will hook all methods in MethodList[tipType]
-- from tooltips in TooltipList[tipType] to the Set[tipType] function
local Initialized = {}
local function InitializeHook(tipType)
	if Initialized[tipType] then return end
	-- Walk through all frames
	local tooltip = EnumerateFrames()
	while tooltip do
	    if tooltip:GetObjectType() == "GameTooltip" then
	        local name = tooltip:GetName()
	        if name then
		        for _, v in ipairs(TooltipList[tipType]) do
		        	if strfind(name, v) then
			        	--print("InitializeHook("..tipType..") = "..name)
						for _, methodName in ipairs(MethodList[tipType]) do
							if type(tooltip[methodName]) == "function" then
								hooksecurefunc(tooltip, methodName, Set[tipType])
							end
						end
						break
					end
		        end
		    end
	    end
	    tooltip = EnumerateFrames(tooltip)
	end
	-- Destroy tooltip list so we don't have double hooking accidents
	Initialized[tipType] = true
end

local HookedFrames = {}
local function CreateFrameHook(frameType, name, parent, inheritFrame)
	if name and frameType == "GameTooltip" then
		for tipType in pairs(HandlerList) do
	        for _, v in ipairs(TooltipList[tipType]) do
				-- prevent double hooking by checking HookedFrames table
	        	if strfind(name, v) and not HookedFrames[name] then
					HookedFrames[name] = true
			        --print("CreateFrameHook("..tipType..") = "..name)
		        	local tooltip = _G[name]
					for _, methodName in ipairs(MethodList[tipType]) do
						if type(tooltip[methodName]) == "function" then
							hooksecurefunc(tooltip, methodName, Set[tipType])
						end
					end
					break
				end
	        end
		end
	end
end

------------------
-- OnEventFrame --
------------------
if TipHooker.OnEventFrame then -- Check for old frame
	TipHooker.OnEventFrame:UnregisterAllEvents()
	TipHooker.OnEventFrame:SetScript("OnEvent", nil)
end

local OnEventFrame = CreateFrame("Frame")

OnEventFrame:RegisterEvent("VARIABLES_LOADED")

OnEventFrame:SetScript("OnEvent", function(self, event, ...)
	--print(event)
	VariablesLoaded = true
	--print("VariablesLoaded = true")
	-- Check for exsiting hooks
	for tipType in pairs(HandlerList) do
		InitializeHook(tipType)
	end
	hooksecurefunc("CreateFrame", CreateFrameHook)
end)

TipHooker.OnEventFrame = OnEventFrame


--[[---------------------------------
{	:Hook(handler, ...)
-------------------------------------
-- Description
	Hooks tooltip SetX methods with handler
-- Args
	handler
	    func - handler func
	...
	    string - list of tooltips that you want to hook:
	        "item": Items
	        "buff": Buff/Debuff
	        "spell": Spells
	        "talant": Talants
	        "unit": Units
	        "action": Action button
-- Examples
}
-----------------------------------]]
function TipHooker:Hook(handler, ...)
	for i = 1, select('#', ...) do
		local tipType = select(i, ...)
		--print("TipHooker:Hook("..tipType..")")
		if VariablesLoaded then
			InitializeHook(tipType)
		end
		if not HandlerList[tipType] then
			HandlerList[tipType] = {}
		end
		HandlerList[tipType][handler] = true
	end
end

--[[---------------------------------
{	:Unhook(handler, ...)
-------------------------------------
-- Description
	Unhooks handler from tooltip SetX methods
-- Args
	handler
	    func - handler func
	...
	    string - list of tooltips that you want to hook:
	        "item": Items
	        "buff": Buff/Debuff
	        "spell": Spells
	        "talant": Talants
	        "unit": Units
	        "action": Action button
-- Examples
}
-----------------------------------]]
function TipHooker:Unhook(handler, ...)
	for i = 1, select('#', ...) do
		local tipType = select(i, ...)
		if HandlerList[tipType] then
			HandlerList[tipType][handler] = nil
		end
	end
end

--[[---------------------------------
{	:IsHooked(handler, tipType)
-------------------------------------
-- Description
	Check if handler is hooker
-- Args
	handler
	    func - handler func
	tipType
	    string - tooltip that you want to hook:
	        "item": Items
	        "buff": Buff/Debuff
	        "spell": Spells
	        "talant": Talants
	        "unit": Units
	        "action": Action button
-- Examples
}
-----------------------------------]]
function TipHooker:IsHooked(handler, tipType)
	if HandlerList[tipType] then
		return HandlerList[tipType][handler]
	end
end

--[[---------------------------------
{	:RegisterCustomTooltip(tipType,frameName)
-------------------------------------
-- Description
	Unhooks handler from tooltip SetX methods
-- Args
	tipType
	    string - tooltip that you want to hook:
	        "item": Items
	        "buff": Buff/Debuff
	        "spell": Spells
	        "talant": Talants
	        "unit": Units
	        "action": Action button
	frameName
	    string - name of your tooltip frame you want to be hooked
-- Examples
}
-----------------------------------]]
function TipHooker:RegisterCustomTooltip(tipType, frameName)
	local tooltip = _G[frameName]
	if(tooltip == nil) then
		return
	end
	--print("InitializeHook("..tipType..") = "..frameName)
	for _, methodName in ipairs(MethodList[tipType]) do
		if type(tooltip[methodName]) == "function" then
			hooksecurefunc(tooltip, methodName, Set[tipType])
		end
	end
end

--_G.TipHooker = TipHooker