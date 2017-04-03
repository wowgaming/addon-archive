--[[
	Auctioneer - AutoMagic Utility module
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: Core.lua 4678 2010-02-27 00:53:37Z Nechckn $
	URL: http://auctioneeraddon.com/

	AutoMagic is an Auctioneer module which automates mundane tasks for you.

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

local lib = AucAdvanced.Modules.Util.AutoMagic
local print,decode,_,_,replicate,empty,get,set,default,debugPrint,fill = AucAdvanced.GetModuleLocals()
local AppraiserValue, DisenchantValue, ProspectValue, VendorValue, bestmethod, bestvalue, runstop, _

-- This table is validating that each ID within it is a gem from prospecting.
local isGem =
	{
	[818] = true,--TIGERSEYE
	[774] = true,--MALACHITE
	[1210] = true,--SHADOWGEM
	[1705] = true,--LESSERMOONSTONE
	[1206] = true,--MOSSAGATE
	[3864] = true,--CITRINE
	[1529] = true,--JADE
	[7909] = true,--AQUAMARINE
	[7910] = true,--STARRUBY
	[12800] = true,--AZEROTHIANDIAMOND
	[12361] = true,--BLUESAPPHIRE
	[12799] = true,--LARGEOPAL
	[12364] = true,--HUGEEMERALD
	[23077] = true,--BLOODGARNET
	[21929] = true,--FLAMESPESSARITE
	[23112] = true,--GOLDENDRAENITE
	[23709] = true,--DEEPPERIDOT
	[23117] = true,--AZUREMOONSTONE
	[23107] = true,--SHADOWDRAENITE
	[23436] = true,--LIVINGRUBY
	[23439] = true,--NOBLETOPAZ
	[23440] = true,--DAWNSTONE
	[23437] = true,--TALASITE
	[23428] = true,--STAROFELUNE
	[23441] = true,--NIGHTSEYE
	[36920] = true,--SUNCRYSTAL
	[36926] = true,--SHADOWCRYSTAL
	[36929] = true,--HUGECITRINE
	[36932] = true,--DARKJADE
	[36923] = true,--CHALCEDONY
	[36917] = true,--BLOODSTONE
	[36927] = true,--TWILIGHTOPAL
	[36924] = true,--SKYSAPPHIRE
	[36918] = true,--SCARLETRUBY
	[36930] = true,--MONARCHTOPAZ
	[36933] = true,---FORESTEMERALD
	[36921] = true,--AUTUMNSGLOW
	--EPIC 80
	[36919] = true,--CARDNIALRUBY
	[36922] = true,--KING'S AMBER
	[36925] = true,--Majestic Zircon
	[36928] = true,--DREADSTONE
	[36931] = true,--AMETRINE
	[36934] = true,--EYE OF ZUL
}

-- This table is validating that each ID within it is a mat from disenchanting.
local isDEMats =
	{
	[34057] = true,--Abyss Crystal
	[22450] = true,--Void Crystal
	[20725] = true,--Nexus Crystal
	[34052] = true,--Dream Shard
	[34053] = true,--Small Dream Shard
	[22449] = true,--Large Prismatic Shards
	[14344] = true,--Large Brillianr Shards
	[11178] = true,--Large Radiant Shards
	[11139] = true,--Large Glowing Shards
	[11084] = true,--Large Glimmering Shards
	[22448] = true,--Small Primatic Shards
	[14343] = true,--Small Brilliant Shards
	[11177] = true,--Small Radiant Shards
	[11138] = true,--Small Glowing Shards
	[10978] = true,--Small Glimmering Shards
	[34055] = true,--Greater Cosmic Essence
	[34056] = true,--Lesser Cosmic Essence
	[22446] = true,--Greater Planer Essence
	[16203] = true,--Greater Eternal Essence
	[11175] = true,--Greater Nether Essence
	[11135] = true,--Greater Mystic Essence
	[11082] = true,--Greater Astral Essence
	[10939] = true,--Greater Magic Essence
	[22447] = true,--Lesser Planer Essence
	[16202] = true,--Lesser Eternal Essence
	[11174] = true,--Lesser Nether Essence
	[11134] = true,--Lesser Mystic Essence
	[10998] = true,--Lesser Astral Essence
	[10938] = true,--Lesser Magic Essence
	[34054] = true, --Infinite Dust
	[22445] = true,--Arcane Dust
	[16204] = true,--Illusion Dust
	[11176] = true,--Dream Dust
	[11137] = true,--Vision Dust
	[11083] = true,--Soul Dust
	[10940] = true,--Strange Dust
}

-- This table is validating that each ID within it is a mat from Milling (table from enchantrix)
local isPigmentMats =
	{
	[39151] = true,	-- ALABASTER_PIGMENT
	[39334] = true,	-- DUSKY_PIGMENT
	[39338] = true,	-- GOLDEN_PIGMENT
	[39339] = true,	-- EMERALD_PIGMENT
	[39340] = true,	-- VIOLET_PIGMENT
	[39341] = true, 	-- SILVERY_PIGMENT
	[43103] = true,	-- VERDANT_PIGMENT
	[43104] = true,	-- BURNT_PIGMENT
	[43105] = true,	-- INDIGO_PIGMENT
	[43106] = true,	-- RUBY_PIGMENT
	[43107] = true, 	-- SAPPHIRE_PIGMENT
	[39342] = true, 	-- NETHER_PIGMENT
	[43108] = true, 	-- EBON_PIGMENT
	[39343] = true, 	-- AZURE_PIGMENT
	[43109] = true, 	-- ICY_PIGMENT
}
-- This table is validating that each ID within it is a herb. Data from informant. This allows locale independent herbs
local isHerb =
	{
	[765] = true, --  Silverleaf
	[785] = true, --  Mageroyal
	[2447] = true, --  Peacebloom
	[2449] = true, --  Earthroot
	[2450] = true, --  Briarthorn
	[2452] = true, --  Swiftthistle
	[2453] = true, --  Bruiseweed
	[3355] = true, --  Wild Steelbloom
	[3356] = true, --  Kingsblood
	[3357] = true, --  Liferoot
	[3358] = true, --  Khadgar's Whisker
	[3369] = true, --  Grave Moss
	[3818] = true, --  Fadeleaf
	[3819] = true, --  Wintersbite
	[3820] = true, --  Stranglekelp
	[3821] = true, --  Goldthorn
	[4625] = true, --  Firebloom
	[8153] = true, --  Wildvine
	[8831] = true, --  Purple Lotus
	[8836] = true, --  Arthas' Tears
	[8838] = true, --  Sungrass
	[8839] = true, --  Blindweed
	[8845] = true, --  Ghost Mushroom
	[8846] = true, --  Gromsblood
	[13463] = true, --  Dreamfoil
	[13464] = true, --  Golden Sansam
	[13465] = true, --  Mountain Silversage
	[13466] = true, --  Plaguebloom
	[13467] = true, --  Icecap
	[13468] = true, --  Black Lotus
	[19726] = true, --  Bloodvine
	[19727] = true, --  Blood Scythe
	[22710] = true, --  Bloodthistle
	[22785] = true, --  Felweed
	[22786] = true, --  Dreaming Glory
	[22787] = true, --  Ragveil
	[22788] = true, --  Flame Cap
	[22789] = true, --  Terocone
	[22790] = true, --  Ancient Lichen
	[22791] = true, --  Netherbloom
	[22792] = true, --  Nightmare Vine
	[22793] = true, --  Mana Thistle
	[22794] = true, --  Fel Lotus
	[22797] = true, --  Nightmare Seed
	[36901] = true, --  Goldclover
	[36902] = true, --  Constrictor Grass
	[36903] = true, --  Adder's Tongue
	[36904] = true, --  Tiger Lily
	[36905] = true, --  Lichbloom
	[36906] = true, --  Icethorn
	[36907] = true, --  Talandra's Rose
	[36908] = true, --  Frost Lotus
	[37921] = true, --  Deadnettle
	[39970] = true, -- Fire Leaf
	}

--this set of tables allows us to match the locale dependet itemtype to the gear a player class can use
local isGear = {
	--armor
	["cloth"] = GetSpellInfo(9078),
	["leather"] = GetSpellInfo(9077),
	["mail"] = GetSpellInfo(8737),
	["plate"] = GetSpellInfo(750),
	["shield"] = GetSpellInfo(9116),
	--weapons
	["bows"] = GetSpellInfo(264),
	["crossbows"] = GetSpellInfo(5011),
	["daggers"] = GetSpellInfo(1180),
	["fist weapons"] = GetSpellInfo(15590),
	["guns"] = GetSpellInfo(266),
	["one-handed axes"] = GetSpellInfo(196),
	["one-handed maces"] = GetSpellInfo(198),
	["one-handed swords"] = GetSpellInfo(201),
	["polearms"] = GetSpellInfo(200),
	["staves"] = GetSpellInfo(227),
	["thrown"] = GetSpellInfo(2567),
	["two-handed axes"] = GetSpellInfo(197),
	["two-handed maces"] = GetSpellInfo(199),
	["two-handed swords"] = GetSpellInfo(202),
	["wands"] = GetSpellInfo(5009),
}
--what gear each class CANNOT use
local isClass = {
	["DEATHKNIGHT"] = "shield|thrown|staves|crossbows|bows|fist weapons|leather|mail|guns|cloth|wands|daggers",
	["SHAMAN"] = "one-handed swords|thrown|staves|crossbows|plate|bows|two-handed swords|leather|guns|polearms|cloth|wands",
	["MAGE"] = "two-handed maces|shield|thrown|crossbows|plate|one-handed maces|one-handed axes|bows|fist weapons|two-handed swords|leather|mail|guns|polearms|two-handed axes",
	["PRIEST"] = "one-handed swords|two-handed maces|shield|thrown|crossbows|plate|one-handed axes|bows|fist weapons|two-handed swords|leather|mail|guns|polearms|two-handed axes",
	["WARLOCK"] = "two-handed maces|shield|thrown|crossbows|plate|one-handed maces|one-handed axes|bows|fist weapons|two-handed swords|leather|mail|guns|polearms|two-handed axes",
	["DRUID"] = "one-handed swords|shield|thrown|crossbows|plate|one-handed axes|bows|fist weapons|two-handed swords|mail|guns|polearms|cloth|wands|two-handed axes",
	["ROGUE"] = "two-handed maces|shield|staves|plate|two-handed swords|mail|polearms|cloth|wands|two-handed axes",
	--lvl 40
	["WARRIOR"] = "leather|mail|cloth|wands",
	["WARRIORLOW"] = "leather|cloth|wands", --warriors and paladins plate does not appear before 40,
	["HUNTER"] = "two-handed maces|shield|plate|one-handed maces|leather|cloth|wands",
	["HUNTERLOW"] = "two-handed maces|shield|plate|one-handed maces|mail|cloth|wands",
	["PALADIN"] = "thrown|staves|crossbows|bows|fist weapons|leather|mail|guns|cloth|wands|daggers",
	["PALADINLOW"] = "thrown|staves|crossbows|bows|fist weapons|leather|guns|cloth|wands|daggers",
	}

local playerClassEquipment
function classexpand()
	local _, class =  UnitClass("player")
	local level = UnitLevel("player")
	if not isClass[class] then print("Unknown player class..", class) return end
	
	if level < 40 and (class == "WARRIOR" or class == "PALADIN" or class == "HUNTER") then
		class = class.."LOW"
	end
	
	local temp = {}
	for usable in isClass[class]:gmatch("(.-)|") do
		local skill = isGear[usable]
		if skill then
			temp[skill] = usable
		end
	end
	return temp
end
--Taken from auc core, used to find soulbound state
local BindTypes = {
	[ITEM_SOULBOUND] = "Bound",
	[ITEM_BIND_ON_PICKUP] = "Bound",
}
--Auc Core tooltip scanner
local ScanTip  = AppraiserTip
local ScanTip2  = AppraiserTipTextLeft2
local ScanTip3 = AppraiserTipTextLeft3

lib.vendorlist = {}
function lib.vendorAction(autovendor)
	if not playerClassEquipment then 
		 playerClassEquipment = classexpand()--create the players localized usable gear list
	end
	empty(lib.vendorlist) --this needs to be cleared on every vendor open
	for bag=0,4 do
		for slot=1,GetContainerNumSlots(bag) do
			if (GetContainerItemLink(bag,slot)) then
				local itemLink = GetContainerItemLink(bag,slot)
				local texture, itemCount, locked, _, lootable = GetContainerItemInfo(bag, slot) --items that have been vedored but are still in players bag (lag) will be locked by server.
				if itemLink and not locked then
					if not itemCount then itemCount = 1 end
					local _, itemID, _, _, _, _ = decode(itemLink)
					local itemSig = AucAdvanced.API.GetSigFromLink(itemLink) -- future plan is to use itemSig in place of itemID throughout - to eliminate problems for items with suffixes
					local itemName, _, itemRarity, _, _, itemType, itemSubType = GetItemInfo(itemLink)
					local key = bag..":"..slot -- key needs to be unique, but is not currently used for anything. future: rethink if this can be made useful
					--tooltip checks soulbound status
					ScanTip:SetOwner(UIParent, "ANCHOR_NONE")
					ScanTip:ClearLines()
					ScanTip:SetBagItem(bag, slot)
					local soulbound = BindTypes[ScanTip2:GetText()] or BindTypes[ScanTip3:GetText()]
					ScanTip:Hide()
					--autovendor  is used to sell without confirmation.
					if autovendor then
						if get("util.automagic.autoselllist") and get("util.automagic.autoselllistnoprompt") and lib.autoSellList[ itemID ] then
							lib.vendorlist[key] = {itemLink, itemSig, itemCount, bag, slot, "Sell List"}
						elseif itemRarity == 0 and get("util.automagic.autosellgrey") and get("util.automagic.autosellgreynoprompt") then
							lib.vendorlist[key] = {itemLink, itemSig, itemCount, bag, slot, "Grey"}
						elseif soulbound and get("util.automagic.vendorunusablebop") and get("util.automagic.autosellbopnoprompt") and IsEquippableItem(itemLink) and itemRarity < 3 and not lootable and playerClassEquipment[itemSubType] then
							lib.vendorlist[key] = {itemLink, itemSig, itemCount, bag, slot, "Unusable"}
						elseif get("util.automagic.autosellreason") and get("util.automagic.autosellreasonnoprompt") then
							local reason, text = lib.getReason(itemLink, itemName, itemCount, "vendor")
							if reason and text then
								lib.vendorlist[key] = {itemLink, itemSig, itemCount, bag, slot, text}
							end
						end
					else
						if get("util.automagic.autoselllist") and lib.autoSellList[ itemID ] then
							lib.vendorlist[key] = {itemLink, itemSig, itemCount, bag, slot, "Sell List"}
						elseif itemRarity == 0 and get("util.automagic.autosellgrey") then
							lib.vendorlist[key] = {itemLink, itemSig, itemCount, bag, slot, "Grey"}
						elseif soulbound and get("util.automagic.vendorunusablebop") and IsEquippableItem(itemLink) and itemRarity < 3 and not lootable and playerClassEquipment[itemSubType] then
							lib.vendorlist[key] = {itemLink, itemSig, itemCount, bag, slot, "Unusable"}
						elseif get("util.automagic.autosellreason") then
							local reason, text = lib.getReason(itemLink, itemName, itemCount, "vendor")
							if reason and text then
								lib.vendorlist[key] = {itemLink, itemSig, itemCount, bag, slot, text}
							end
						end
					end
				end
			end
		end
	end
	if autovendor then
		lib.ASCConfirmContinue()
	else
		lib.ASCPrompt()
	end
end

function lib.disenchantAction()
	MailFrameTab_OnClick(nil, 2)
	for bag=0,4 do
		for slot=1,GetContainerNumSlots(bag) do
			if (GetContainerItemLink(bag,slot)) then
				local itemLink, itemCount = GetContainerItemLink(bag,slot)
				if (itemLink == nil) then return end
				if itemCount == nil then _, itemCount = GetContainerItemInfo(bag, slot) end
				if itemCount == nil then itemCount = 1 end
				runstop = 0
				local _, itemID, _, _, _, _ = decode(itemLink)
				local itemName, _, itemRarity, _, _, _, _, _, _, _ = GetItemInfo(itemLink)
				if (AucAdvanced.Modules.Util.ItemSuggest and get("util.automagic.overidebtmmail") == true) then
					local aimethod = AucAdvanced.Modules.Util.ItemSuggest.itemsuggest(itemLink, itemCount)
					if(aimethod == "Disenchant") then
						if (get("util.automagic.chatspam")) then
							print("AutoMagic has loaded", itemName, " due to Item Suggest(Disenchant)")
						end
						UseContainerItem(bag, slot)
						runstop = 1
					end
				else --look for btmScan or SearchUI reason codes if above fails
					local reason, text = lib.getReason(itemLink, itemName, itemCount, "disenchant")
					if reason and text then
						if (get("util.automagic.chatspam")) then
							print("AutoMagic has loaded", itemName, " due to", text ,"Rule(Disenchant)")
						end
						UseContainerItem(bag, slot)
					end
				end
			end
		end
	end
end

function lib.prospectAction()
	MailFrameTab_OnClick(nil, 2)
	for bag=0,4 do
		for slot=1,GetContainerNumSlots(bag) do
			if (GetContainerItemLink(bag,slot)) then
				local itemLink, itemCount = GetContainerItemLink(bag,slot)
				if (itemLink == nil) then return end
				if itemCount == nil then _, itemCount = GetContainerItemInfo(bag, slot) end
				if itemCount == nil then itemCount = 1 end
				local _, itemID, _, _, _, _ = decode(itemLink)
				local itemName, _, itemRarity, _, _, _, _, _, _, _ = GetItemInfo(itemLink)
				runstop = 0
				if (AucAdvanced.Modules.Util.ItemSuggest and get("util.automagic.overidebtmmail") == true) then
					local aimethod = AucAdvanced.Modules.Util.ItemSuggest.itemsuggest(itemLink, itemCount)
					if(aimethod == "Prospect") then
						if (get("util.automagic.chatspam")) then
							print("AutoMagic has loaded", itemName, " due to Item Suggest(Prospect)")
						end
						UseContainerItem(bag, slot)
						runstop = 1
					end
				else --look for btmScan or SearchUI reason codes if above fails
					local reason, text = lib.getReason(itemLink, itemName, itemCount, "prospect")
					if reason and text then
						if (get("util.automagic.chatspam")) then
							print("AutoMagic has loaded", itemName, " due to", text ,"Rule(Prospect)")
						end
						UseContainerItem(bag, slot)
					end
				end
			end
		end
	end
end

function lib.gemAction()
	MailFrameTab_OnClick(nil, 2)
	for bag=0,4 do
		for slot=1,GetContainerNumSlots(bag) do
			if (GetContainerItemLink(bag,slot)) then
				local itemLink, itemCount = GetContainerItemLink(bag,slot)
				if (itemLink == nil) then return end
				if itemCount == nil then _, itemCount = GetContainerItemInfo(bag, slot) end
				if itemCount == nil then itemCount = 1 end
				local _, itemID, _, _, _, _ = decode(itemLink)
				local itemName, _, itemRarity, _, _, _, _, _, _, _ = GetItemInfo(itemLink)
				if isGem[ itemID ] then
					if (get("util.automagic.chatspam")) then
						print("AutoMagic has loaded", itemName, " because it is a gem!")
					end
					UseContainerItem(bag, slot)
				end
			end
		end
	end
end

function lib.dematAction()
	MailFrameTab_OnClick(nil, 2)
	for bag=0,4 do
		for slot=1,GetContainerNumSlots(bag) do
			if (GetContainerItemLink(bag,slot)) then
				local itemLink, itemCount = GetContainerItemLink(bag,slot)
				if (itemLink == nil) then return end
				if itemCount == nil then _, itemCount = GetContainerItemInfo(bag, slot) end
				if itemCount == nil then itemCount = 1 end
				local _, itemID, _, _, _, _ = decode(itemLink)
				local itemName, _, itemRarity, _, _, _, _, _, _, _ = GetItemInfo(itemLink)
				if isDEMats[ itemID ] then
					if (get("util.automagic.chatspam")) then
						print("AutoMagic has loaded", itemName, " because it is a mat used for enchanting.")
					end
					UseContainerItem(bag, slot)
				end
			end
		end
	end
end

function lib.pigmentAction()
	MailFrameTab_OnClick(nil, 2)
	for bag=0,4 do
		for slot=1,GetContainerNumSlots(bag) do
			if (GetContainerItemLink(bag,slot)) then
				local itemLink, itemCount = GetContainerItemLink(bag,slot)
				if (itemLink == nil) then return end
				if itemCount == nil then _, itemCount = GetContainerItemInfo(bag, slot) end
				if itemCount == nil then itemCount = 1 end
				local _, itemID, _, _, _, _ = decode(itemLink)
				local itemName, _, itemRarity, _, _, _, _, _, _, _ = GetItemInfo(itemLink)
				if isPigmentMats[ itemID ] then
					if (get("util.automagic.chatspam")) then
						print("AutoMagic has loaded", itemName, " because it is a pigment used for milling.")
					end
					UseContainerItem(bag, slot)
				end
			end
		end
	end
end

function lib.herbAction()
	MailFrameTab_OnClick(nil, 2)
	for bag=0,4 do
		for slot=1,GetContainerNumSlots(bag) do
			if (GetContainerItemLink(bag,slot)) then
				local itemLink, itemCount = GetContainerItemLink(bag,slot)
				if (itemLink == nil) then return end
				if itemCount == nil then _, itemCount = GetContainerItemInfo(bag, slot) end
				if itemCount == nil then itemCount = 1 end
				local _, itemID, _, _, _, _ = decode(itemLink)
				local itemName, _, itemRarity, _, _, _, _, _, _, _ = GetItemInfo(itemLink)
				if isHerb[ itemID ] then
					if (get("util.automagic.chatspam")) then
						print("AutoMagic has loaded", itemName, " because it is a herb.")
					end
					UseContainerItem(bag, slot)
				end
			end
		end
	end
end

--Searches for reason and returns values if found nil other wise.
--Consolidates code into one function instead of 5-6 places that need editing/maintaining
function lib.getReason(itemLink, itemName, itemCount, text)
	if (BtmScan) then
		local bidlist = BtmScan.Settings.GetSetting("bid.list")
		if (bidlist) then
			local id, suffix, enchant, seed = BtmScan.BreakLink(itemLink)
			local sig = ("%d:%d:%d"):format(id, suffix, enchant)
			local bids = bidlist[sig..":"..seed.."x"..itemCount]

			if(bids and bids[1] and bids[1] == text) then
				return bids[1], "BTM"
			end
		end
	end

	if (BeanCounter and BeanCounter.API.isLoaded) then
		local reason = BeanCounter.API.getBidReason(itemLink, itemCount) or ""
		if reason:lower() == text then
			return reason, "SearchUI"
		end
	end

	return
end

AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Auc-Util-AutoMagic/Core.lua $", "$Rev: 4678 $")
