--[[
Name: LibTipHooker-1.1.lua
Description: A Library for hooking tooltips.
Revision: $Revision: 2 $
Author: Whitetooth
Email: hotdogee [at] gmail [dot] com
LastUpdate: $Date: 2008-12-30 12:03:42 +0000 (Tue, 30 Dec 2008) $
Website:
Documentation:
SVN: $URL $
License: LGPL v3
]]

-- This library is still in early development

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
local MINOR = "$Revision: 2 $"

local TipHooker = LibStub:NewLibrary(MAJOR, MINOR)
if not TipHooker then return end

local VariablesLoaded

-----------
-- Tools --
-----------
local DEBUG = false

-- Localize globals
local _G = getfenv(0)
local select = select
local pairs = pairs
local ipairs = ipairs
local IsAddOnLoaded = IsAddOnLoaded

local function print(text)
	if DEBUG then
		DEFAULT_CHAT_FRAME:AddMessage(text)
	end
end

-- copyTable
local function copyTable(to, from)
	if not to then
		to = {}
	end
	for k,v in pairs(from) do
		if type(k) == "table" then
			k = copyTable({}, k)
		end
		if type(v) == "table" then
			v = copyTable({}, v)
		end
		to[k] = v
	end
	setmetatable(to, getmetatable(from))
	return to
end

-----------------------
-- Hook Tooltip Core --
-----------------------
local TooltipList = {
	item = {
		"GameTooltip",
		"ItemRefTooltip",
		"ShoppingTooltip",
		-- EquipCompare support
		"ComparisonTooltip",
		-- EQCompare support
		"EQCompareTooltip",
		-- takKompare support
		"tekKompareTooltip",
		-- LinkWrangler support
		"IRR_",
		"LinkWrangler",
		-- MultiTips support
		-- Links support
		"LinksTooltip",
		-- AtlasLoot support
		"AtlasLootTooltip",
		-- ItemMagic support
		"ItemMagicTooltip",
		-- Sniff support
		"SniffTooltip",
		-- LinkHeaven support
		"LH_",
		-- Mirror support
		"MirrorTooltip",
		-- TooltipExchange support
		"TooltipExchange_TooltipShow",
		-- AtlasQuest support
		"AtlasQuestTooltip",
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
		"SetCraftSpell",
		"SetCraftItem",
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
	item = function(tooltip)
		if not tooltip.GetItem then return end
		local name, link = tooltip:GetItem()
		-- Check for empty slots
		if not name then return end
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
TipHooker.SupportedTooltips = {}
TipHooker.HookedFrames = {}
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
			        	print("InitializeHook("..tipType..") = "..name)
						for _, methodName in ipairs(MethodList[tipType]) do
							if type(tooltip[methodName]) == "function" then
								hooksecurefunc(tooltip, methodName, Set[tipType])
							end
						end
						tinsert(_G.TipHooker.SupportedTooltips, tooltip)
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

local function CreateFrameHook(frameType, name, parent, inheritFrame)
	if name and frameType == "GameTooltip" then
		for tipType in pairs(HandlerList) do
	        for _, v in ipairs(TooltipList[tipType]) do
	        	if strfind(name, v) then
			        print("CreateFrameHook("..tipType..") = "..name)
		        	local tooltip = _G[name]
					for _, methodName in ipairs(MethodList[tipType]) do
						-- prevent double hooking by checking HookedFrames table
						if (type(tooltip[methodName]) == "function") and (not _G.TipHooker.HookedFrames[name]) then
							_G.TipHooker.HookedFrames[name] = true
							hooksecurefunc(tooltip, methodName, Set[tipType])
						end
					end
					tinsert(_G.TipHooker.SupportedTooltips, tooltip)
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
	print(event)
	VariablesLoaded = true
	print("VariablesLoaded = true")
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
		print("TipHooker:Hook("..tipType..")")
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
	Unhooks handler from tooltip SetX methods
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
function TipHooker:RegisterCustomTooltip(tipType,frameName)
	local tooltip = getglobal(frameName);
	if(tooltip == nil) then
		return;
	end
	print("InitializeHook("..tipType..") = "..frameName)
	for _, methodName in ipairs(MethodList[tipType]) do
		if type(tooltip[methodName]) == "function" then
			hooksecurefunc(tooltip, methodName, Set[tipType])
		end
	end
	tinsert(_G.TipHooker.SupportedTooltips, tooltip)
end

_G.TipHooker = TipHooker