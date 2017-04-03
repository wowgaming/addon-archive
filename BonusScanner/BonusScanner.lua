--------------------------------------------------
-- BonusScanner Continued v5.2
-- Originally developed by Crowley <crowley@headshot.de>
-- performance improvements by Archarodim
-- Updated for WoW 2.0 by jmlsteele
-- Updated for WoW 3.0 by Tristanian <tristanian@live.com>
-- get the latest version here:
-- http://www.wowinterface.com/downloads/info7919 (WoWI)
-------------------------------------------------- 

-- Library references
local TipHooker = LibStub("LibTipHooker-1.1")
local AceTimer = LibStub("AceTimer-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("BonusScanner", true)
local _G = getfenv(0);

-- Initialize locals/tables
local BONUSSCANNER_VERSION = "5.2";

-- Patterns
local BONUSSCANNER_PATTERN_SETNAME = "^(.*) %(%d/%d%)$";
local BONUSSCANNER_PATTERN_GENERIC_PREFIX = "^%+?(%d+)%%?(.*)$";
local BONUSSCANNER_PATTERN_GENERIC_SUFFIX = "^(.*)%+ ?(%d+)%%?$";
local BONUSSCANNER_PATTERN_GENERIC_SUFFIX2 = "^(.*)%s(%d+)%%";
local bsDPSTemplate1 = string.gsub(_G["DPS_TEMPLATE"], "%%.1f", "(%%d+%%.%%d+)")
local bsDPSTemplate2 = string.gsub(_G["DPS_TEMPLATE"], "%%.1f", "(%%d+%%,%%d+)")
  
local ItemCache = {} -- Cache table for items
local nosetcheck;

-- Create frame and register events
local BonusScanner = CreateFrame("Frame", "BonusScanner")
AceTimer:Embed(BonusScanner)
BonusScanner:RegisterEvent("PLAYER_ENTERING_WORLD");
BonusScanner:RegisterEvent("PLAYER_LEAVING_WORLD");
BonusScanner:RegisterEvent("ADDON_LOADED");
BonusScanner:RegisterEvent("PLAYER_LOGIN");

BonusScanner:SetScript("OnEvent", function(_, event, ...)
	BonusScanner[event](BonusScanner, ...)
end)

-- Create the bonus fields, subtables etc
BonusScanner.bonuses = {}
BonusScanner.bonuses_details = {}

-- These are purely used for debugging purposes, leave them alone if you don't know what you are doing !
BonusScanner.ShowDebug = false -- tells when the equipment is scanned
BonusScanner.Verbose = false -- Shows a LOT of debug information
    
-- variable counters for number of gems of the appropriate color		
BonusScanner.GemsRed = 0
BonusScanner.GemsYellow = 0
BonusScanner.GemsBlue = 0
BonusScanner.GemsPrismatic = 0
		
-- average item level
BonusScanner.AverageiLvl = 0
BonusScanner.active = false

BonusScanner.temp = { 
		sets = {},
		set = "",
		slot = "",
		bonuses = {},
		details = {},
		GemsRed = 0,
		GemsYellow = 0,
		GemsBlue = 0,
		GemsPrismatic = 0,
		AverageiLvl = 0
	}

BonusScanner.slots = {
		"Head",
		"Neck",
		"Shoulder",
		"Shirt",
		"Chest",
		"Waist",
		"Legs",
		"Feet",
		"Wrist",
		"Hands",
		"Finger0",
		"Finger1",
		"Trinket0",
		"Trinket1",
		"Back",
		"MainHand",
		"SecondaryHand",
		"Ranged",
		"Tabard",
	}


-- bonus effects, basically a refined version of bonus names indexed by category
 local BONUSSCANNER_EFFECTS = {
	{ effect = "STR", cat = "ATT" },
	{ effect = "AGI", cat = "ATT" },
	{ effect = "STA",	cat = "ATT" },
	{ effect = "INT",	cat = "ATT" },
	{ effect = "SPI",	cat = "ATT" },
	{ effect = "ARMOR", cat = "ATT" },
	{ effect = "MASTERY", cat = "ATT"},
	{ effect = "ARCANERES", cat = "RES" },
	{ effect = "FIRERES", cat = "RES" },
	{ effect = "NATURERES", cat = "RES" },
	{ effect = "FROSTRES", cat = "RES" },
	{ effect = "SHADOWRES", cat = "RES" },

	{ effect = "DEFENSE", pformat="%d pt", cat = "SKILL" },
	{ effect = "EXPERTISE", pformat="%d pt", cat = "SKILL" },
	{ effect = "FISHING",	cat = "SKILL" },
	{ effect = "HERBALISM", cat = "SKILL" },
	{ effect = "MINING", cat = "SKILL" },
	{ effect = "SKINNING", cat = "SKILL" },
  
	{ effect = "ATTACKPOWER", cat = "BON" },
	{ effect = "ATTACKPOWERUNDEAD", cat = "BON" },
	{ effect = "ATTACKPOWERFERAL", cat = "BON" },
	{ effect = "ARMORPEN", pformat="%.2f%%", cat = "BON" },
	{ effect = "BLOCK", pformat="%.2f%%",	cat = "BON" },
  { effect = "BLOCKVALUE", cat = "BON" },
  { effect = "CRIT", pformat="%.2f%%", cat = "BON" },
  { effect = "DODGE", pformat="%.2f%%", cat = "BON" },
	{ effect = "HASTE",	pformat="%.2f%%",	cat = "BON" },
	{ effect = "TOHIT", pformat="%.2f%%",	cat = "BON" },
	{ effect = "RANGEDHIT", pformat="%.2f%%",	cat = "BON" },
	{ effect = "PARRY", pformat="%.2f%%", cat = "BON" },
	{ effect = "RANGEDATTACKPOWER", cat = "BON" },
  { effect = "RANGEDCRIT", pformat="%.2f%%", cat = "BON" },
  { effect = "RANGEDDMG", cat = "BON" },
	{ effect = "RESILIENCE", pformat="%.2f%%", cat = "BON" },
	{ effect = "DMGWPN", cat = "BON" },
	{ effect = "DPSMAIN", cat = "BON" },
	{ effect = "DPSRANGED", cat = "BON" },
	{ effect = "DPSTHROWN", cat = "BON" },
	
	{ effect = "DMGUNDEAD",	cat = "SBON" },	
	{ effect = "SPELLPOW", cat = "SBON" },
  --{ effect = "HOLYCRIT", pformat="%.2f%%", cat = "SBON" },
	{ effect = "SPELLPEN", cat = "SBON" },
	{ effect = "ARCANEDMG", cat = "SBON" },
	{ effect = "FIREDMG", cat = "SBON" },
	{ effect = "FROSTDMG", cat = "SBON" },
	{ effect = "HOLYDMG", cat = "SBON" },
	{ effect = "NATUREDMG", cat = "SBON" },
	{ effect = "SHADOWDMG", cat = "SBON" },

	{ effect = "HEALTH", cat = "OBON" },
	{ effect = "HEALTHREG",	cat = "OBON" },
	{ effect = "MANA", cat = "OBON" },
	{ effect = "MANAREG",	cat = "OBON" },
	
	{ effect = "THREATREDUCTION",	cat = "EBON" },
	{ effect = "THREATINCREASE",	cat = "EBON" },
	{ effect = "INCRCRITDMG",	cat = "EBON" },
	{ effect = "SPELLREFLECT",	cat = "EBON" },	
	{ effect = "STUNRESIST",	cat = "EBON" },
	{ effect = "PERCINT",	cat = "EBON" },
	{ effect = "PERCBLOCKVALUE",	cat = "EBON" },
	
	{ effect = "PERCARMOR",	cat = "EBON" },
	{ effect = "PERCMANA",	cat = "EBON" },
	{ effect = "PERCREDSPELLDMG",	cat = "EBON" },
	{ effect = "PERCSNARE",	cat = "EBON" },
	{ effect = "PERCSILENCE",	cat = "EBON" },
	{ effect = "PERCFEAR",	cat = "EBON" },
	{ effect = "PERCSTUN",	cat = "EBON" },
	{ effect = "PERCCRITHEALING",	cat = "EBON" },
};

local BaseRatings = {
{ effect = "EXPERTISE", baseval = 2.5},
{ effect = "DEFENSE", baseval = 1.5},
{ effect = "DODGE", baseval = 13.8}, -- 3.2 Dodge Rating: The amount of dodge rating required per percentage of dodge has been increased by 15%.
{ effect = "PARRY", baseval = 13.8}, -- 3.2 Parry Rating: The amount of parry rating required per percentage of parry has been reduced by 8%.
{ effect = "BLOCK", baseval = 5},
{ effect = "TOHIT", baseval = 10},
{ effect = "CRIT", baseval = 14},
{ effect = "RANGEDHIT", baseval = 10},		
{ effect = "RANGEDCRIT", baseval = 14},	 
{ effect = "HASTE", baseval = 10},
{ effect = "SPELLTOHIT", baseval = 8},
{ effect = "SPELLCRIT", baseval = 14},
{ effect = "HOLYCRIT", baseval = 14}, 
{ effect = "SPELLH", baseval = 10},
{ effect = "RESILIENCE", baseval = 28.75}, -- 3.2 Resilience: The amount of resilience needed to reduce critical strike chance, critical strike damage and overall damage has been increased by 15%.
{ effect = "ARMORPEN", baseval = 3.756097412109376} -- 3.1 Armor Penetration Rating: All classes now receive 25% more benefit from Armor Penetration Rating.
}

local BaseRatingsLvl34 = {
	DEFENSE = true,
	DODGE = true,
	PARRY = true,
	BLOCK = true,
	RESILIENCE = true
}

local HasteClasses31 = {
	PALADIN = true,
	DEATHKNIGHT = true,
	SHAMAN = true,
	DRUID = true
}

-- locale independent special enchants
local SpecialEnchants = {
[3605] = { AGI = 23 }, -- Flexweave underlay
[3859] = { SPELLPOW = 27 }, -- Springy Arachnoweave
[3606] = { CRIT = 24 }, -- Nitro Boosts
[3847] = { DEFENSE = 123 }, -- Rune of the Stoneskin Gargoyle
[3883] = { DEFENSE = 64 }, -- Rune of the Nerubian Carapace
[3849] = { BLOCKVALUE = 81 }, -- Titanium Plating
[3730] = { SPI = 1 }, -- Swordguard Embroidery
[3728] = { SPI = 1 }, -- Darkglow Embroidery
[3722] = { SPI = 1 }, -- Lightweave Embroidery
[3595] = { PERCSILENCE = 50 }, -- Rune of Spellbreaking
[3367] = { PERCSILENCE = 50 }, -- Rune of Spellshattering
[2603] = { FISHING = 5 }, -- Eternium Line
[2672] = { FROSTDMG = 54, SHADOWDMG = 54 }, -- Soulfrost
[2671] = { ARCANEDMG = 50, FIREDMG = 50 }, -- Sunfire
[3238] = { HERBALISM = 5, MINING = 5, SKINNING = 5 }, -- Gatherer
[3731] = { TOHIT = 28 }, -- Titanium Weapon Chain
[3223] = { PARRY = 15 }, -- Adamantite Weapon Chain
}

local function ClassColorise(class, localizedclass)
if not class then return localizedclass or "" end
	local classUpper = strupper(class)
	local pclass = string.gsub(classUpper, " ", "")
	local colortable = _G["CUSTOM_CLASS_COLORS"] or _G["RAID_CLASS_COLORS"]
	local r = string.format("%x", math.floor(colortable[pclass].r * 255))
	if strlen(r) == 1 then
		r = "0"..r
	end
	local g = string.format("%x", math.floor(colortable[pclass].g * 255))
	if strlen(g) == 1 then
		g = "0"..g
	end
	local b = string.format("%x", math.floor(colortable[pclass].b * 255))
	if strlen(b) == 1 then
		b = "0"..b
	end
	return "|cff"..r..g..b..localizedclass.._G["FONT_COLOR_CODE_CLOSE"]
end

local function ScanTooltipGem()
	local tempGemRed, tempGemYellow, tempGemBlue, tempGemPrismatic  = 0, 0, 0, 0
	local numoflines = BonusScannerTooltip:NumLines()
		for i = 2, numoflines, 1 do
		local tmpText = _G["BonusScannerTooltipTextLeft"..i]:GetText()
			if tmpText then
				local lowtext = string.lower(tmpText)
				for k,v in pairs(L["BONUSCANNER_GEM_STRINGS"]) do
					local exists = string.find(lowtext, k, 1, true)
					if exists then
						tempGemRed = tempGemRed + v.red
						tempGemYellow = tempGemYellow + v.yellow
						tempGemBlue = tempGemBlue + v.blue
						tempGemPrismatic = tempGemPrismatic + v.prismatic
						break
					end
				end
			end
		end
	return tempGemRed, tempGemYellow, tempGemBlue, tempGemPrismatic
end


function BonusScanner:clearCache()
	for k in pairs(ItemCache) do
		ItemCache[k] = nil
	end
end

function BonusScanner:GetRatingMultiplier(level, bonustype)
	-- 3.1 Parry Rating, Defense Rating, and Block Rating: Low-level players will now convert these ratings into their corresponding defensive stats at the same rate as level 34 players.
		if level < 34 and BaseRatingsLvl34[bonustype] then
			level = 34
		end
		if level < 10 then
			return 52 / 2
		elseif level <= 60 then
			return 52 / (level - 8)
		elseif level <= 70 then
			return (-3/82)*level+(131/41)
		else
		  return 1/((82/52)*(131/63)^((level - 70)/10))
		end
end
	
function BonusScanner:GetRatingBonus(bonustype, value, level, class)
	if not class or type(class) ~= "string" then class = strupper(select(2,UnitClass("player"))) end
	class = strupper(class)
	 local ref, F;
	 for _,ref in pairs (BaseRatings) do
	  if ref.effect == bonustype then
	    F = ref.baseval;
	  end
	 end
		if not F then
			return nil
		end
		-- 3.1 Haste Rating: shamans, paladins, druids, and death knights now receive 30% more melee haste from Haste Rating.	 		
		if bonustype == "HASTE" and HasteClasses31[class] then value = value * 1.3 end		
		return value / F * self:GetRatingMultiplier(level, bonustype)
end

-- Global update function to hook into. 
-- Gets called, when Equipment changes (after UNIT_INVENTORY_CHANGED)
function BonusScanner_Update()
end

function BonusScanner:GetBonus(bonus)
	if self.bonuses[bonus] then
		return self.bonuses[bonus]
	end
	return 0
end

function BonusScanner:GetSlotBonuses(slotname)
	local i, bonus, details
	local bonuses = {}
	for bonus, details in pairs(self.bonuses_details) do
		if details[slotname] then
			bonuses[bonus] = details[slotname]
		end
	end
	return bonuses
end

function BonusScanner:GetBonusDetails(bonus)
	if self.bonuses_details[bonus] then
		return self.bonuses_details[bonus]
	end
	return {}
end

function BonusScanner:GetSlotBonus(bonus, slotname)
	if self.bonuses_details[bonus] then
		if self.bonuses_details[bonus][slotname] then
			return self.bonuses_details[bonus][slotname]
		end
	end
	return 0
end

function BonusScanner:ItemHasEnchant(itemlink)
	if not itemlink or itemlink == "" then return false, nil end
	local _, enchantID = itemlink:match("item:(%-?%d+):(%-?%d+)")
	if enchantID and enchantID ~= "0" then return true, tonumber(enchantID) end
	return false, nil
end

function BonusScanner:GetEmptySockets(itemlink)
 if not itemlink or itemlink == "" then return 0,0,0,0 end
 local emptyMetaSockets, emptyRedSockets, emptyBlueSockets, emptyYellowSockets = 0, 0, 0, 0
 local emptyMetaTexture = "Interface\\ItemSocketingFrame\\UI-EmptySocket-Meta"
 local emptyRedTexture = "Interface\\ItemSocketingFrame\\UI-EmptySocket-Red"
 local emptyBlueTexture = "Interface\\ItemSocketingFrame\\UI-EmptySocket-Blue"
 local emptyYellowTexture = "Interface\\ItemSocketingFrame\\UI-EmptySocket-Yellow"
 -- clear the textures first
 for i = 1, 4 do
 	if _G["BonusScannerTooltipTexture"..i] then
 		_G["BonusScannerTooltipTexture"..i]:SetTexture("")
 	end
 end
 BonusScannerTooltip:SetOwner(_G["BonusScanner"],"ANCHOR_NONE")
 BonusScannerTooltip:ClearLines()
 BonusScannerTooltip:SetHyperlink(itemlink)
 for i = 1, 4 do
 	local temp = _G["BonusScannerTooltipTexture"..i]:GetTexture()
 	-- texture check
 	--if temp then DEFAULT_CHAT_FRAME:AddMessage(i..": "..temp) end --debug code
 	if temp and temp == emptyMetaTexture then emptyMetaSockets = emptyMetaSockets + 1 end
 	if temp and temp == emptyRedTexture then emptyRedSockets = emptyRedSockets + 1 end
 	if temp and temp == emptyYellowTexture then emptyYellowSockets = emptyYellowSockets + 1 end 	
 	if temp and temp == emptyBlueTexture then emptyBlueSockets = emptyBlueSockets + 1 end 	
 end
 return emptyMetaSockets, emptyRedSockets, emptyYellowSockets, emptyBlueSockets
end


function BonusScanner:ProcessSpecialBonus (bonus, value, level, class)	
	local specialval = ""
	local points = self:GetRatingBonus(bonus, value, level, class)
		if bonus == "RESILIENCE" then
				specialval = " (-"..format("%.2f%%", points)..L["BONUSSCANNER_SPECIAL1_LABEL"]..")"
		elseif bonus == "EXPERTISE" then
		  local tempval = points * 0.25
				specialval = " ("..format("%d pt", points)..", -"..format("%.2f%%", tempval)..L["BONUSSCANNER_SPECIAL2_LABEL"]..")"
		elseif bonus == "DEFENSE" then
			local tempval = points / 25			
			  specialval = " ("..format("%d pt", points)..", -"..format("%.2f%%", tempval)..L["BONUSSCANNER_SPECIAL1_LABEL"]..")"
		elseif bonus == "TOHIT" then
			local tempval = self:GetRatingBonus("SPELLTOHIT", value,level, class)
			 specialval = " ("..format("%.2f%%", points)..L["BONUSSCANNER_SPECIAL3_LABEL"]..", "..format("%.2f%%", tempval)..L["BONUSSCANNER_SPECIAL4_LABEL"]..")"
		elseif bonus == "HASTE" then
			-- 3.1 Haste Rating: shamans, paladins, druids, and death knights now receive 30% more melee haste from Haste Rating.
	 		local meleehaste = points
	 		local spellhaste = self:GetRatingBonus("SPELLH", value,level, class)
	 		if meleehaste ~= spellhaste then
	 			specialval = " ("..format("%.2f%%", meleehaste)..L["BONUSSCANNER_SPECIAL3_LABEL"]..", "..format("%.2f%%", spellhaste)..L["BONUSSCANNER_SPECIAL5_LABEL"]..")"
	 		end
		end		
		return specialval, points
end


function BonusScanner:GetGemSum(link)
local tempGemRed, tempGemYellow, tempGemBlue, tempGemPrismatic  = 0, 0, 0, 0
local red, yellow, blue, prism = 0, 0, 0, 0

	-- Set hyperlinks and check tooltip
	BonusScannerTooltip:SetOwner(_G["BonusScanner"],"ANCHOR_NONE")
	
	for i = 1, 4 do
		local gemitemlink = select(2, GetItemGem(link, i))
		if gemitemlink then
			BonusScannerTooltip:ClearLines()
			BonusScannerTooltip:SetHyperlink(gemitemlink)
			red, yellow, blue, prism = ScanTooltipGem()
 			tempGemRed = tempGemRed + red
			tempGemYellow = tempGemYellow + yellow
			tempGemBlue = tempGemBlue + blue
			tempGemPrismatic = tempGemPrismatic + prism
		end
	end
	
	return tempGemRed, tempGemYellow, tempGemBlue, tempGemPrismatic
end 

function BonusScanner.ProcessTooltip(tooltip, name, link)
BonusScannerTooltip:SetOwner(_G["BonusScanner"],"ANCHOR_NONE")

if BonusScannerConfig.tooltip == 1 then

--itemparams
local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemCount, itemEquipLoc, itemTexture = GetItemInfo(link)
--check to avoid errors if item is not in the player's cache
if not itemLink then return end
--get properties of item
local baseID, enchantID, gem1ID, gem2ID, gem3ID, gem4ID, suffixID, instanceID = itemLink:match("item:(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+)")

	if BonusScannerConfig.basiciteminfo == 1 then
		tooltip:AddLine(_G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["BONUSSCANNER_ITEMID_LABEL"]..baseID.._G["LIGHTYELLOW_FONT_COLOR_CODE"]..", "..L["BONUSSCANNER_ILVL_LABEL"]..itemLevel)
		tooltip:Show()
	end
	
	if BonusScannerConfig.extendediteminfo == 1 then
		tooltip:AddLine(_G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["BONUSSCANNER_ENCHANTID_LABEL"]..enchantID.._G["LIGHTYELLOW_FONT_COLOR_CODE"]..", "..L["BONUSSCANNER_GEM1ID_LABEL"]..gem1ID.._G["LIGHTYELLOW_FONT_COLOR_CODE"]..", "..L["BONUSSCANNER_GEM2ID_LABEL"]..gem2ID.._G["LIGHTYELLOW_FONT_COLOR_CODE"]..", "..L["BONUSSCANNER_GEM3ID_LABEL"]..gem3ID)
		tooltip:Show()
	end
	
	
	local e, f, level, ratingval, points, bonuses, cbonuses
	local GemnoRed, GemnoYellow, GemnoBlue, GemnoPrismatic  = 0, 0, 0, 0
	local cat = ""
	local nobonus = true
	local ifound = false
	local temptable = {}
	
	-- search the addon cache to locate the itemlink
	-- search for baseID, enchantID, socketed gems and suffixID (for green items). This should cover everything
	for _,f in pairs(ItemCache) do	
		if f.baseID==baseID and f.enchantID==enchantID and f.gem1ID==gem1ID and f.gem2ID==gem2ID and f.gem3ID==gem3ID and f.gem4ID==gem4ID and f.suffixID==suffixID then
			bonuses = f.cbonuses
			GemnoRed = f.gemsred
			GemnoYellow = f.gemsyellow
			GemnoBlue = f.gemsblue
			GemnoPrismatic = f.gemsprismatic
			ifound = true
		end
	end
	--ONLY if the item is not in the addon cache do we scan it
	if not ifound then
		bonuses = BonusScanner:ScanItem(link)
		if gem1ID~="0" or gem2ID~="0" or gem3ID~="0" or gem4ID~="0" then
			GemnoRed, GemnoYellow, GemnoBlue, GemnoPrismatic = BonusScanner:GetGemSum(link)
		end
	 	temptable = {baseID=baseID, enchantID=enchantID, gem1ID=gem1ID, gem2ID=gem2ID, gem3ID=gem3ID, gem4ID=gem4ID, suffixID=suffixID, setname=BonusScanner.temp.set, gemsred=GemnoRed, gemsyellow=GemnoYellow, gemsblue=GemnoBlue, gemsprismatic=GemnoPrismatic, ilvl=itemLevel, cbonuses=bonuses}
	 	tinsert(ItemCache, temptable)
	end
					
	if bonuses then
		level = UnitLevel("player")
	
		if next(bonuses) == nil then
		else
			nobonus = false
		end
	
if not nobonus then
tooltip:AddLine(" ")
tooltip:AddLine(L["BONUSSCANNER_BONUSSUM_LABEL"])

	for _,e in pairs (BONUSSCANNER_EFFECTS) do
		if bonuses[e.effect] then
				if e.cat ~= cat then
					cat = e.cat
					tooltip:AddLine(_G["GREEN_FONT_COLOR_CODE"]..L["BONUSSCANNER_CAT_"..cat]..":")
				 end
				 --handle rating conversion here
				 if e.pformat then
				 	  ratingval, points = BonusScanner:ProcessSpecialBonus (e.effect, bonuses[e.effect], level)
				 	  if ratingval == "" then
				 			ratingval = " ("..format(e.pformat,points)..") "
				 	  end
				 	tooltip:AddLine(_G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["BONUSSCANNER_NAMES"][e.effect]..": ".._G["HIGHLIGHT_FONT_COLOR_CODE"]..bonuses[e.effect]..ratingval)
				 else
					tooltip:AddLine(_G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["BONUSSCANNER_NAMES"][e.effect]..": ".._G["HIGHLIGHT_FONT_COLOR_CODE"]..bonuses[e.effect])
			   end
		end			  
	end
	
	if IsControlKeyDown() or BonusScannerConfig.showgemcount == 1 then
 		if GemnoRed~=0 or GemnoYellow~=0 or GemnoBlue~=0 or GemnoPrismatic~=0 then
 			tooltip:AddLine(_G["GREEN_FONT_COLOR_CODE"]..L["BONUSSCANNER_CAT_GEMS"]..":")
 		end
 		if GemnoRed~=0 then
 			tooltip:AddLine(_G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["BONUSSCANNER_GEMCOUNT_LABEL"].._G["RED_FONT_COLOR_CODE"]..L["BONUSSCANNER_GEMRED_LABEL"].._G["LIGHTYELLOW_FONT_COLOR_CODE"]..": ".._G["HIGHLIGHT_FONT_COLOR_CODE"]..GemnoRed)
 		end
 		if GemnoYellow~=0 then
 			tooltip:AddLine(_G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["BONUSSCANNER_GEMCOUNT_LABEL"].."|cffffd200"..L["BONUSSCANNER_GEMYELLOW_LABEL"].._G["LIGHTYELLOW_FONT_COLOR_CODE"]..": ".._G["HIGHLIGHT_FONT_COLOR_CODE"]..GemnoYellow)
 		end
 		if GemnoBlue~=0 then
 			tooltip:AddLine(_G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["BONUSSCANNER_GEMCOUNT_LABEL"].."|cff2459ff"..L["BONUSSCANNER_GEMBLUE_LABEL"].._G["LIGHTYELLOW_FONT_COLOR_CODE"]..": ".._G["HIGHLIGHT_FONT_COLOR_CODE"]..GemnoBlue)
  	end
  	if GemnoPrismatic~=0 then
 			tooltip:AddLine(_G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["BONUSSCANNER_GEMCOUNT_LABEL"].._G["HIGHLIGHT_FONT_COLOR_CODE"]..L["BONUSSCANNER_GEMPRISM_LABEL"].._G["LIGHTYELLOW_FONT_COLOR_CODE"]..": ".._G["HIGHLIGHT_FONT_COLOR_CODE"]..GemnoPrismatic)
  	end
  end --end IsControlKeyDown()
	
tooltip:Show()
		end --end (nobonus)
		end --end if (bonuses)
end --end BonusScannerConfig.tooltip
end --end function ProcessTooltip


function BonusScanner:CheckForEquipedChanges(updatedelay)
if not updatedelay then updatedelay = 2 end
	for i, slotname in pairs(self.slots) do
		local slotid = GetInventorySlotInfo(slotname.. "Slot")
		local itemLink = GetInventoryItemLink("player", slotid)
		if itemLink and itemLink ~= BonusScannerConfig.slots[slotname] then
			self:CancelAllTimers()
			self:ScheduleTimer("Update", updatedelay)
			break
		end
	end
end

function BonusScanner:UNIT_INVENTORY_CHANGED(unit, ...)
	if self.active and unit == "player" then
		self:CheckForEquipedChanges(2)
	end
end

function BonusScanner:PLAYER_ENTERING_WORLD()
	self.active = true
	self:ScheduleTimer("Update", 1)
	self:RegisterEvent("UNIT_INVENTORY_CHANGED")
end

function BonusScanner:PLAYER_LEAVING_WORLD()
	self:UnregisterEvent("UNIT_INVENTORY_CHANGED")
end

function BonusScanner:PLAYER_LOGIN()
	if BonusScannerConfig.loadbroker == 1 and not IsAddOnLoaded("Broker_BonusScanner") then LoadAddOn("Broker_BonusScanner") end
	self:UnregisterEvent("PLAYER_LOGIN")
  self.PLAYER_LOGIN = nil
end

function BonusScanner:ADDON_LOADED(addon)
	if addon == "BonusScanner" then
		if not BonusScannerConfig then 
        -- initialize default configuration
        BonusScannerConfig = { 
				tooltip = 0; -- 1 for 'Enabled', 0 for 'Disabled'
				basiciteminfo = 0;
				extendediteminfo = 0;
				showgemcount = 0;
				loadbroker = 1;
        }
    end
    if not BonusScannerConfig.slots then
    	BonusScannerConfig.slots = {
				["Head"] = "",
				["Neck"] = "",
				["Shoulder"] = "",
				["Shirt"] = "",
				["Chest"] = "",
				["Waist"] = "",
				["Legs"] = "",
				["Feet"] = "",
				["Wrist"] = "",
				["Hands"] = "",
				["Finger0"] = "",
				["Finger1"] = "",
				["Trinket0"] = "",
				["Trinket1"] = "",
				["Back"] = "",
				["MainHand"] = "",
				["SecondaryHand"] = "",
				["Ranged"] = "",
				["Tabard"] = "",
			}
    end
    if not BonusScannerConfig.loadbroker then BonusScannerConfig.loadbroker = 1 end
    if BonusScannerConfig.tooltip == 1 then TipHooker:Hook(self.ProcessTooltip, "item") end
    self:UnregisterEvent("ADDON_LOADED")
    self.ADDON_LOADED = nil
	end
end


-- A little debug function
function BonusScanner:Debug(Message)
    if self.ShowDebug then
			DEFAULT_CHAT_FRAME:AddMessage("BonusScanner Debug: " .. Message, 0.5, 0.8, 1);
		end	
end


function BonusScanner:Update()
	self.bonuses, self.bonuses_details, self.GemsRed, self.GemsYellow, self.GemsBlue, self.GemsPrismatic, self.AverageiLvl = self:ScanEquipment("player") -- scan the equiped items
	BonusScanner_Update()	  -- call the update function (for the mods using this library)	
end


function BonusScanner:ScanEquipment(target)
	local slotid, slotname, itemLink, ifound
	local totalLevel = 0
	local itemLevels, SetCache, tbonuses, temptable = {}, {}, {}, {}
	self.temp.GemsRed, self.temp.GemsYellow, self.temp.GemsBlue, self.temp.GemsPrismatic, self.temp.AverageiLvl = 0, 0, 0, 0, 0
	 	
	BonusScannerTooltip:SetOwner(_G["BonusScanner"],"ANCHOR_NONE")

  self:Debug("Scanning Equipment has requested")
     
-- Phase 1 : Check if the equipped items are cached, if not scan and cache them, if yes get the bonuses from the ItemCache
	for i, slotname in pairs(self.slots) do
		slotid = GetInventorySlotInfo(slotname.. "Slot")
		local GemnoRed = 0
		local GemnoYellow = 0
		local GemnoBlue = 0
		local GemnoPrismatic = 0
		ifound = false
		itemLink = GetInventoryItemLink(target, slotid)
		
	if itemLink then

-- store the itemlink if the target is the player
if target == "player" and BonusScannerConfig.slots[slotname] ~= itemLink then BonusScannerConfig.slots[slotname] = itemLink end

--get properties of item		
local baseID, enchantID, gem1ID, gem2ID, gem3ID, gem4ID, suffixID, instanceID = itemLink:match("item:(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+)")

--search the addon cache to locate the itemlink
	--search for baseID, enchantID, socketed gems and suffixID (for green items). This should cover everything
	for _,f in pairs(ItemCache) do
		if f.baseID==baseID and f.enchantID==enchantID and f.gem1ID==gem1ID and f.gem2ID==gem2ID and f.gem3ID==gem3ID and f.gem4ID==gem4ID and f.suffixID==suffixID then
			tbonuses = f.cbonuses
			GemnoRed = f.gemsred
			GemnoYellow = f.gemsyellow
			GemnoBlue = f.gemsblue
			GemnoPrismatic = f.gemsprismatic
			itemLevels[slotname] = f.ilvl or 0
			ifound = true
		end
	end
	--ONLY if the item is not in the addon cache do we scan it
	if not ifound then
		tbonuses = self:ScanItem(itemLink)
		itemLevels[slotname] = select(4, GetItemInfo(itemLink)) or 0
		if gem1ID~="0" or gem2ID~="0" or gem3ID~="0" or gem4ID~="0" then
			GemnoRed, GemnoYellow, GemnoBlue, GemnoPrismatic = self:GetGemSum(itemLink)
		end
		temptable = {baseID=baseID, enchantID=enchantID, gem1ID=gem1ID, gem2ID=gem2ID, gem3ID=gem3ID, gem4ID=gem4ID, suffixID=suffixID, setname=self.temp.set, gemsred=GemnoRed, gemsyellow=GemnoYellow, gemsblue=GemnoBlue, gemsprismatic=GemnoPrismatic, ilvl=itemLevels[slotname], cbonuses=tbonuses}
		tinsert(ItemCache, temptable)
	end
	
	self.temp.GemsRed = self.temp.GemsRed + GemnoRed
	self.temp.GemsYellow = self.temp.GemsYellow + GemnoYellow
	self.temp.GemsBlue = self.temp.GemsBlue + GemnoBlue
	self.temp.GemsPrismatic = self.temp.GemsPrismatic + GemnoPrismatic
	
end --end if itemLink
end --end for

-- Handle item Levels
for i,k in pairs(itemLevels) do
 -- ignore Tabard, Shirt and Ranged item levels
	if i ~= "Tabard" and i ~= "Shirt" and i ~= "Ranged" then
		if i == "MainHand" and not itemLevels["SecondaryHand"] then
			totalLevel = totalLevel + k * 2
		else
			totalLevel = totalLevel + k
		end
	end
end

self.temp.AverageiLvl = tonumber(format("%.2f", totalLevel / (#self.slots - 3))) -- ignore Tabard, Shirt and Ranged slots

-- Phase 2: Check if an item is part of a set, if it is, scan the tooltip to ensure set bonuses are picked up
-- if the item is not part of a set, use the cached bonuses if any

 		self.temp.bonuses = {}
	  self.temp.details = {}
	  self.temp.sets = {}
		self.temp.set = ""
		
		BonusScannerTooltip:SetOwner(_G["BonusScanner"],"ANCHOR_NONE")
		
for i, slotname in pairs(self.slots) do
		slotid = GetInventorySlotInfo(slotname.. "Slot")
		BonusScannerTooltip:ClearLines()
		BonusScannerTooltip:SetInventoryItem(target, slotid)
		itemLink = GetInventoryItemLink(target, slotid)

if itemLink then
		
--get properties of item		
local baseID, enchantID, gem1ID, gem2ID, gem3ID, gem4ID, suffixID, instanceID = itemLink:match("item:(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+)")

local setnotcached = true

-- search the addon cache to locate the itemlink
	-- if the item is a set item, we scan it to get the setbonus (if available)
	for _,f in pairs(ItemCache) do
	if f.baseID==baseID and f.enchantID==enchantID and f.gem1ID==gem1ID and f.gem2ID==gem2ID and f.gem3ID==gem3ID and f.gem4ID==gem4ID and f.suffixID==suffixID and (f.setname~="" or slotname=="Head") then
		  for _,k in pairs(SetCache) do
	   		if k.setname==f.setname then
	   				setnotcached=false
	   		end
	   end
	if setnotcached then
		--DEFAULT_CHAT_FRAME:AddMessage("Checking Set Item:"..itemLink)
		self.temp.slot = slotname
		nosetcheck = false
  	self:ScanTooltip()
  	if self.temp.set ~= "" then
			self.temp.sets[self.temp.set] = 1
		end
		if f.setname~="" then
			temptable = {setname=f.setname}
			tinsert(SetCache, temptable)
		end
		tbonuses = {}
	end --end if (setnotcached)
	end --end if f.baseID==baseID...
	
	if f.baseID==baseID and f.enchantID==enchantID and f.gem1ID==gem1ID and f.gem2ID==gem2ID and f.gem3ID==gem3ID and f.gem4ID==gem4ID and f.suffixID==suffixID and (f.setname=="" or setnotcached==false) and slotname~="Head" then
		--DEFAULT_CHAT_FRAME:AddMessage("Using Cached data for :"..itemLink)
		tbonuses = f.cbonuses
	end
	end --end for

self.temp.slot = slotname
for _,k in pairs (BONUSSCANNER_EFFECTS) do
	if tbonuses and tbonuses[k.effect] then
	  	self:AddValue(k.effect, tbonuses[k.effect])
	end
end
end --end if itemLink
end --end for

	return self.temp.bonuses, self.temp.details, self.temp.GemsRed, self.temp.GemsYellow, self.temp.GemsBlue, self.temp.GemsPrismatic, self.temp.AverageiLvl
end

function BonusScanner:ScanItem(itemlink)
		if not itemlink or itemlink == "" then return end
		local k
		local _, enchantID = itemlink:match("item:(%-?%d+):(%-?%d+)")
		self.temp.bonuses = {}
		self.temp.sets = {}
		self.temp.set = ""
		self.temp.slot = ""
		nosetcheck = true
	  BonusScannerTooltip:ClearLines()
	  BonusScannerTooltip:SetHyperlink(itemlink)
		self:ScanTooltip()
		-- Second pass for special enchants
		if enchantID and enchantID~= "0" then		
			k = SpecialEnchants[tonumber(enchantID)]
			if k then
				for effect, value in pairs(k) do
					self:AddValue(effect, value)
				end
			end
		end
		return self.temp.bonuses
end

function BonusScanner:ScanTooltip()
	local tmpTxt, line, tmpTxt2, line2, rline, r, g, b
	local lines = BonusScannerTooltip:NumLines()
	local wtype = 0 -- 0 for none, 1 for two-hand, one-hand, main hand or offhand, 2 for ranged, 3 for thrown
		
	for i=2, lines, 1 do
		tmpText = _G["BonusScannerTooltipTextLeft"..i]
		tmpText2 = _G["BonusScannerTooltipTextRight"..i]
		if (tmpText2:GetText()) then
		line2 = tmpText2:GetText()
		rline = string.find(line2, L["BONUSSCANNER_WEAPON_SPEED"], 1,true)
		end
		if (tmpText:GetText()) then
			line = tmpText:GetText()
			r,g,b = tmpText:GetTextColor()
			r, g, b = ceil(r*255), ceil(g*255), ceil(b*255)
			if rline then
			 line=""
			 rline=nil
			end
			-- detect weapon type
			if line == _G["INVTYPE_2HWEAPON"] or line == _G["INVTYPE_WEAPON"] or line == _G["INVTYPE_WEAPONMAINHAND"] or line == _G["INVTYPE_WEAPONOFFHAND"] then wtype = 1 end
			if line == _G["INVTYPE_RANGED"] then wtype = 2 end
			if line == _G["INVTYPE_THROWN"] then wtype = 3 end
			self:ScanLine(line, r, g, b, wtype)
		end
	end
end
	
		
function BonusScanner:AddValue(effect, value)
	if(type(effect) == "string") then
		value = tonumber(value)
	  if self.Verbose then
			self:Debug("Adding Effect: " .. effect .. " Value: " .. value)
		end
		if self.temp.bonuses[effect] then
			self.temp.bonuses[effect] = self.temp.bonuses[effect] + value
		else
			self.temp.bonuses[effect] = value
		end
		
		if self.temp.slot then
			if self.temp.details[effect] then
				if self.temp.details[effect][self.temp.slot] then
					self.temp.details[effect][self.temp.slot] = self.temp.details[effect][self.temp.slot] + value
				else
					self.temp.details[effect][self.temp.slot] = value
				end
			else
				self.temp.details[effect] = {}
				self.temp.details[effect][self.temp.slot] = value
			end
		end
	else 
	-- list of effects
		if(type(value) == "table") then
			for i,e in pairs(effect) do
				self:AddValue(e, value[i])
			end
		else
			for i,e in pairs(effect) do
				self:AddValue(e, value)
			end
		end
	end
end

function BonusScanner:ScanLine(line, r, g, b, wtype)
	local tmpStr, found, newline,f, value
	self:Debug(line .. " (".. string.len(line) .. ")")
	
	-- Experimental : Get rid of gray lines
	if (r==128 and g==128 and b==128) or (string.sub(line,0,10) == "|cff808080") then line="" return end
		
	-- Check for DPS Template	
	 _, _, _, value = string.find(line, bsDPSTemplate1)
	 
	 if not value then
	 	_, _, _, value = string.find(line, bsDPSTemplate2)
	 end
	 
	 if value and wtype and wtype ~= 0 then
	 	value = string.gsub(value, ",", ".")	 	
	 	if wtype == 1 then self:AddValue("DPSMAIN", value) end
	 	if wtype == 2 then self:AddValue("DPSRANGED", value) end
	 	if wtype == 3 then self:AddValue("DPSTHROWN", value) end
	 end
		
	-- Check for "Equip: "
		if(string.sub(line,0,string.len(_G["ITEM_SPELL_TRIGGER_ONEQUIP"])) == _G["ITEM_SPELL_TRIGGER_ONEQUIP"]) then
		tmpStr = string.sub(line,string.len(_G["ITEM_SPELL_TRIGGER_ONEQUIP"])+2)
		self:CheckPassive(tmpStr)

	-- Check for "Set: "
	elseif string.sub(line,0,string.len(L["BONUSSCANNER_PREFIX_SET"])) == L["BONUSSCANNER_PREFIX_SET"] and self.temp.set ~= "" and not self.temp.sets[self.temp.set] and not nosetcheck then
		tmpStr = string.sub(line,string.len(L["BONUSSCANNER_PREFIX_SET"])+1)
		self.temp.slot = "Set"
		self:CheckPassive(tmpStr)
		
	--Socket Bonus:
	elseif(string.sub(line,0,string.len(L["BONUSSCANNER_PREFIX_SOCKET"])) == L["BONUSSCANNER_PREFIX_SOCKET"]) then
		--See if the line is green
		--if (color[1] < 0.1 and color[2] > 0.99 and color[3] < 0.1 and color[4] > 0.99) then
		 if (r==0 and g==255 and b==0) then
			tmpStr = string.sub(line,string.len(L["BONUSSCANNER_PREFIX_SOCKET"])+1)
			found = self:CheckOther(tmpStr)
		 if not found then
		   self:CheckGeneric(tmpStr)
		 end
		end

	-- any other line (standard stats, enchantment, set name, etc.)
	else
		
	--enchantment/stat fix for green items and red text 
		if (string.sub(line,0,10) == "|cffffffff") or (string.sub(line,0,10) == "|cffff2020") then
			newline = string.sub(line,11,-3)
			line = newline
			line = string.gsub(line, "%|$", "" )
		end	
		
		-- Check for set name
		_, _, tmpStr = string.find(line, BONUSSCANNER_PATTERN_SETNAME)
		if tmpStr then
			self.temp.set = tmpStr
		else
			found = self:CheckOther(line)
			if not found then
				found = self:CheckGeneric(line)
			end
		end
	end	
end

-- Scans passive bonuses like "Set: " and "Equip: "
function BonusScanner:CheckPassive(line)
	local i, p, results, resultCount, found, start, value
	
	for i,p in pairs(L["BONUSSCANNER_PATTERNS_PASSIVE"]) do
		results = {string.find(line, "^" .. p.pattern)}
		resultCount = table.getn(results)
		if resultCount == 3 then
			self:AddValue(p.effect, results[3])
			found = 1
			break -- prevent duplicated patterns to cause bonuses to be counted several times
		elseif resultCount > 3 then
			local values = {}
			for i=3,resultCount do
				table.insert(values,results[i])
			end
			self:AddValue(p.effect,values)
			found = 1
			break -- prevent duplicated patterns to cause bonuses to be counted several times
		end
		start, _, value = string.find(line, "^" .. p.pattern)
		if start and p.value then
			self:AddValue(p.effect, p.value)
			found = 1
			break
		end
	end
	  if not found and self.temp.slot == "Set" then
		  self:CheckGeneric(line)
	  end
end

-- Scans generic bonuses like "+3 Intellect" or "Arcane Resistance +4"
-- Changes for TBC (multi value gems)
function BonusScanner:CheckGeneric(line)
	local value, token, pos, pos2, pos3, tmpStr, sep, sepend, found

-- consolidate multilines	
	line = string.gsub( line, "\n", L["BONUSSCANNER_GLOBAL_SEP"])
		
	while(string.len(line) > 0) do
	found = false
	
	-- Nasty hack, the following code has been implemented as the 'final' solution to Blizzard's retarded choice of different 'separators'
	-- meaning symbols to distinguish between multibonus patterns. Essentially what we do is forcibly replace all those different separators
	-- with our own, global one.
	
	for _, sep in ipairs(L["BONUSSCANNER_SEPARATORS"]) do
	line = string.gsub(line, sep,L["BONUSSCANNER_GLOBAL_SEP"])
	end
	
	-- ensures that set bonuses will not be counted if they are prefixed
	pos = string.find(line, L["BONUSSCANNER_PREFIX_SET"], 1, true)
	if pos then line = "" return end
	
	pos = string.find(line, L["BONUSSCANNER_GLOBAL_SEP"], 1, true)
	if pos then
		tmpStr = string.sub(line,1,pos-1)
		line = string.sub(line,pos+string.len(L["BONUSSCANNER_GLOBAL_SEP"]))
	else
		tmpStr = line
		line = ""
	end
						
	-- trim line
	tmpStr = string.gsub( tmpStr, "^%s+", "" )
  tmpStr = string.gsub( tmpStr, "%s+$", "" )
  tmpStr = string.gsub( tmpStr, "%.$", "" )
  tmpStr = string.gsub( tmpStr, "\n", "" )
    
  -- code for debugging purposes
	--DEFAULT_CHAT_FRAME:AddMessage("TmpStr:"..tmpStr)
	--DEFAULT_CHAT_FRAME:AddMessage("Line:"..line)
	--/code for debugging purposes
  
		--Check Prefix (+20 Strength)
		  _, _, value, token = string.find(tmpStr, BONUSSCANNER_PATTERN_GENERIC_PREFIX)
	          	
		--Check Suffix (Strength +20)
		if not value then
			_, _, token, value = string.find(tmpStr, BONUSSCANNER_PATTERN_GENERIC_SUFFIX)
		end
		
		--Check Suffix (Strength 20%)
		if not value then
			_, _, token, value = string.find(tmpStr, BONUSSCANNER_PATTERN_GENERIC_SUFFIX2)
		end
													
		if token and value then
			-- trim token
		  token = string.gsub( token, "^%s+", "" )
    	token = string.gsub( token, "%s+$", "" )
	    token = string.gsub( token, "%.$", "" )
	    token = string.gsub( token, "|r", "" )	  
	    	      	      
			if self:CheckToken(token,value) then
				found = true
			end
			else
			self:CheckOther(tmpStr)
		end
	end
	return found
end

-- Identifies simple tokens like "Intellect" and composite tokens like "Fire damage" and 
-- add the value to the respective bonus. 
-- returns true if some bonus is found
function BonusScanner:CheckToken(token, value)
	local i, p, s1, s2
	
	if(L["BONUSSCANNER_PATTERNS_GENERIC_LOOKUP"][token]) then
		self:AddValue(L["BONUSSCANNER_PATTERNS_GENERIC_LOOKUP"][token], value)
		return true
	else
		for i,p in pairs(L["BONUSSCANNER_PATTERNS_GENERIC_STAGE1"]) do
			if(string.find(token,p.pattern,1,1)) then
				s1 = p.effect
			end
		end	
		for i,p in pairs(L["BONUSSCANNER_PATTERNS_GENERIC_STAGE2"]) do
			if(string.find(token,p.pattern,1,1)) then
				s2 = p.effect
			end
		end	
		if s1 and s2 then
			self:AddValue(s1..s2, value)
			return true
		end 
	end
	return false
end

-- Last fallback for non generic/special enchants/effects, like "Mana Regen x per 5 sec."
function BonusScanner:CheckOther(line)
	local i, p, value, start, found
	
	for i,p in pairs(L["BONUSSCANNER_PATTERNS_OTHER"]) do
		start, _, value = string.find(line, "^" .. p.pattern)
		if start then
			self:Debug("Special match found: \"" .. p.pattern .. "\"")
			if p.value then
				self:AddValue(p.effect, p.value)
			elseif value then
				self:AddValue(p.effect, value)
			end
			return true
		end
	end
	return false
end

-- Call inventory scan for target (if it exists)
function BonusScanner:ScanUnitInventory(WhisperParam)
local name = GetUnitName("target")
	
	-- if target was deselected display a message and return
	if not name then DEFAULT_CHAT_FRAME:AddMessage(_G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["BONUSSCANNER_SELTAR_LABEL"]) return end

  	local bonuses, details, GemnoRed, GemnoYellow, GemnoBlue, GemnoPrismatic, AverageiLvl = BonusScanner:ScanEquipment("target") -- scan the equiped items
			-- check if bonuses is empty and return a message ?
			
		if CheckInteractDistance("target", 1) then
			if UnitIsPlayer("target") and CanInspect("target") then					
				if WhisperParam then
					SendChatMessage(L["BONUSSCANNER_IBONUS_LABEL"]..name..", ".._G["LEVEL"].." "..UnitLevel("target").." "..UnitClass("target"),"WHISPER",nil,WhisperParam)
					SendChatMessage(L["BONUSSCANNER_AVERAGE_ILVL_LABEL"]..": "..AverageiLvl, "WHISPER", nil, WhisperParam)				
				else
					DEFAULT_CHAT_FRAME:AddMessage(_G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["BONUSSCANNER_IBONUS_LABEL"].."|cffffd200"..name.."|r".._G["LIGHTYELLOW_FONT_COLOR_CODE"]..", ".._G["LEVEL"].." "..UnitLevel("target").." "..ClassColorise(select(2,UnitClass("target")), UnitClass("target") ))
					DEFAULT_CHAT_FRAME:AddMessage(_G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["BONUSSCANNER_AVERAGE_ILVL_LABEL"]..": ".."|cffffd200"..AverageiLvl.."|r")
				end
				BonusScanner:PrintInfo(bonuses, GemnoRed, GemnoYellow, GemnoBlue, GemnoPrismatic, WhisperParam)
			else
				DEFAULT_CHAT_FRAME:AddMessage(_G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["BONUSSCANNER_INVALIDTAR_LABEL"])
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage("|cffffd200"..name.._G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["BONUSSCANNER_OOR_LABEL"])
		end --end CheckInteractDistance
end

-- Slash Command handler
function BonusScanner:Cmd(cmd)
local pos, temp, e, WhisperParam, IsItem
--chat = ChatFrameEditBox:GetAttribute("chatType")

		-- Split string for optional params
		-- Itemlink whisper
		pos = string.find(cmd, "]|h|r%s", 1)
		if pos then
			WhisperParam = string.sub(cmd,pos+6)
		end
		-- If no space after itemlink treat as regular link regardless of text entered after
		pos = string.find(cmd, "]|h|r", 1)
		if pos then
			temp = string.sub(cmd,pos+5)
			cmd = string.sub(cmd,0,(string.len(cmd)-string.len(temp)))
		end
		-- Scan Target whisper
		pos = string.find(cmd, "target%s",1)
		if pos then
		 WhisperParam = string.sub(cmd,pos+7)
		 cmd = string.sub(cmd,0,(string.len(cmd)-string.len(WhisperParam))-1)
		end
				
	local _, _, itemlink, itemid = string.find(cmd, "|c%x+|H(item:(%-?%d+):%-?%d+:%-?%d+:%-?%d+:%-?%d+:%-?%d+:%-?%d+:%-?%d+:%-?%d+)|h%[.-%]|h|r")
	 
	if itemid then
  		local name = GetItemInfo(itemid)
		if name and name ~="" then
		
		BonusScannerTooltip:SetOwner(_G["BonusScanner"],"ANCHOR_NONE")
			local bonuses = self:ScanItem(itemlink)
			local GemnoRed, GemnoYellow, GemnoBlue, GemnoPrismatic = self:GetGemSum(itemlink)
			local nobonus = true
						
			if next (bonuses) == nil then
			else
			nobonus = false
			end
			
			if not nobonus then 
			
			if WhisperParam then
			SendChatMessage(L["BONUSSCANNER_IBONUS_LABEL"]..cmd,"WHISPER",nil,WhisperParam)
			else
			DEFAULT_CHAT_FRAME:AddMessage(_G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["BONUSSCANNER_IBONUS_LABEL"]..cmd)
		  end
		  IsItem = true
	  	self:PrintInfo(bonuses, GemnoRed, GemnoYellow, GemnoBlue, GemnoPrismatic, WhisperParam, IsItem)
		  else
		  DEFAULT_CHAT_FRAME:AddMessage(_G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["BONUSSCANNER_NOBONUS_LABEL"])
		  end --end if not (nobonus)
		  else
		  DEFAULT_CHAT_FRAME:AddMessage(_G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["BONUSSCANNER_FAILEDPARSE_LABEL"])
  		end --end if (name)
  		return
  	end
  	if string.lower(cmd) == "show" then
	  	DEFAULT_CHAT_FRAME:AddMessage(_G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["BONUSSCANNER_CUREQ_LABEL"])
	  	DEFAULT_CHAT_FRAME:AddMessage(_G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["BONUSSCANNER_AVERAGE_ILVL_LABEL"]..": ".."|cffffd200"..self.AverageiLvl.."|r")
			self:PrintInfo(self.bonuses, self.GemsRed, self.GemsYellow, self.GemsBlue, self.GemsPrismatic)
  		return
  	end
  	
  	if string.lower(cmd) == "broker" then
  		if BonusScannerConfig.loadbroker == 0 then
  			BonusScannerConfig.loadbroker = 1
  			if not IsAddOnLoaded("Broker_BonusScanner") then
  				LoadAddOn("Broker_BonusScanner")
  			end
  			DEFAULT_CHAT_FRAME:AddMessage(_G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["BONUSSCANNER_LDB_PLUGIN_LABEL"].."[".._G["GREEN_FONT_COLOR_CODE"]..L["BONUSSCANNER_TOOLTIP_ENABLED"].._G["LIGHTYELLOW_FONT_COLOR_CODE"].."]")
  		else
  			BonusScannerConfig.loadbroker = 0
  			DEFAULT_CHAT_FRAME:AddMessage(_G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["BONUSSCANNER_LDB_PLUGIN_LABEL"].."[".._G["RED_FONT_COLOR_CODE"]..L["BONUSSCANNER_TOOLTIP_DISABLED"].._G["LIGHTYELLOW_FONT_COLOR_CODE"].."]. "..L["BONUSSCANNER_NEEDS_RELOADUI_LABEL"])
  		end
  		return
  	end
  	  	
  	if string.lower(cmd) == "tooltip" then
	  	if BonusScannerConfig.tooltip == 1 then
	  	 TipHooker:Unhook(self.ProcessTooltip, "item")
	  	 BonusScannerConfig.tooltip = 0
	  	 DEFAULT_CHAT_FRAME:AddMessage(_G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["BONUSSCANNER_TOOLTIP_STRING"].."[".._G["RED_FONT_COLOR_CODE"]..L["BONUSSCANNER_TOOLTIP_DISABLED"].._G["LIGHTYELLOW_FONT_COLOR_CODE"].."]")
	  	 else
	  	 TipHooker:Hook(self.ProcessTooltip, "item")
	  	 BonusScannerConfig.tooltip = 1
	  	 DEFAULT_CHAT_FRAME:AddMessage(_G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["BONUSSCANNER_TOOLTIP_STRING"].."[".._G["GREEN_FONT_COLOR_CODE"]..L["BONUSSCANNER_TOOLTIP_ENABLED"].._G["LIGHTYELLOW_FONT_COLOR_CODE"].."]")
	  	 end
  		return
  	end
  	
  	if string.lower(cmd) == "itembasic" then
  			if BonusScannerConfig.basiciteminfo == 1 then
  			  BonusScannerConfig.basiciteminfo = 0
  			  DEFAULT_CHAT_FRAME:AddMessage(_G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["BONUSSCANNER_BASICLINKID_STRING"].."[".._G["RED_FONT_COLOR_CODE"]..L["BONUSSCANNER_TOOLTIP_DISABLED"].._G["LIGHTYELLOW_FONT_COLOR_CODE"].."]")
  			  else
  			  BonusScannerConfig.basiciteminfo = 1
  			  DEFAULT_CHAT_FRAME:AddMessage(_G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["BONUSSCANNER_BASICLINKID_STRING"].."[".._G["GREEN_FONT_COLOR_CODE"]..L["BONUSSCANNER_TOOLTIP_ENABLED"].._G["LIGHTYELLOW_FONT_COLOR_CODE"].."]")
  			  end
  		return
  	end
  	
  	if string.lower(cmd) == "itemextend" then
  			if BonusScannerConfig.extendediteminfo == 1 then
  			  BonusScannerConfig.extendediteminfo = 0
  			  DEFAULT_CHAT_FRAME:AddMessage(_G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["BONUSSCANNER_EXTENDEDLINKID_STRING"].."[".._G["RED_FONT_COLOR_CODE"]..L["BONUSSCANNER_TOOLTIP_DISABLED"].._G["LIGHTYELLOW_FONT_COLOR_CODE"].."]")
  			  else
  			  BonusScannerConfig.extendediteminfo = 1
  			  DEFAULT_CHAT_FRAME:AddMessage(_G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["BONUSSCANNER_EXTENDEDLINKID_STRING"].."[".._G["GREEN_FONT_COLOR_CODE"]..L["BONUSSCANNER_TOOLTIP_ENABLED"].._G["LIGHTYELLOW_FONT_COLOR_CODE"].."]")
  			  end
  		return
  	end
  	
  	if string.lower(cmd) == "tooltip gems" then
  	if BonusScannerConfig.showgemcount == 1 then
	  	 BonusScannerConfig.showgemcount = 0
	  	 DEFAULT_CHAT_FRAME:AddMessage(_G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["BONUSSCANNER_TOOLTIPGEMS_STRING"].."[".._G["RED_FONT_COLOR_CODE"]..L["BONUSSCANNER_TOOLTIP_DISABLED"].._G["LIGHTYELLOW_FONT_COLOR_CODE"].."]")
	  	 else
	  	 BonusScannerConfig.showgemcount = 1
	  	 DEFAULT_CHAT_FRAME:AddMessage(_G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["BONUSSCANNER_TOOLTIPGEMS_STRING"].."[".._G["GREEN_FONT_COLOR_CODE"]..L["BONUSSCANNER_TOOLTIP_ENABLED"].._G["LIGHTYELLOW_FONT_COLOR_CODE"].."]")
	  	 end	  	 
  		return
  	end
  	
  	if string.lower(cmd) == "clearcache" then
			self:clearCache()
			DEFAULT_CHAT_FRAME:AddMessage(_G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["BONUSSCANNER_CACHECLEAR_LABEL"])
  	 return
  	end
  	
  	if string.lower(cmd) == "details" then
	  	DEFAULT_CHAT_FRAME:AddMessage(_G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["BONUSSCANNER_CUREQDET_LABEL"])
			self:PrintInfoDetailed()
  		return
  	end
  	
  	if string.lower(cmd) == "target" then
		local name  = GetUnitName("target")
		if name then
			NotifyInspect("target")
			--self:CancelAllTimers() -- we don't really need this
			self:ScheduleTimer("ScanUnitInventory", 1, WhisperParam)
		else
			DEFAULT_CHAT_FRAME:AddMessage(_G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["BONUSSCANNER_SELTAR_LABEL"])
		end --end if (name)
		return
	end
	for i, slotname in pairs(self.slots) do
		if string.lower(cmd) == string.lower(slotname) then
		  	DEFAULT_CHAT_FRAME:AddMessage(_G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["BONUSSCANNER_IBONUS_LABEL"].."'".."|cffffd200"..slotname.._G["LIGHTYELLOW_FONT_COLOR_CODE"].."' "..L["BONUSSCANNER_SLOT_LABEL"])
		  	local bonuses = self:GetSlotBonuses(slotname)
		  	IsItem = true
		  	local slotid, _ = GetInventorySlotInfo(slotname.. "Slot")
		  	BonusScannerTooltip:ClearLines()
				local hasItem = BonusScannerTooltip:SetInventoryItem("player", slotid)
				if hasItem and GetInventoryItemLink("player", slotid) then
				_, itemLink = BonusScannerTooltip:GetItem()
				local GemnoRed, GemnoYellow, GemnoBlue, GemnoPrismatic = self:GetGemSum(itemLink)
		    self:PrintInfo(bonuses, GemnoRed, GemnoYellow, GemnoBlue, GemnoPrismatic, nil, IsItem)
		    end
		  	return
		end
	end
	--display help text on slash commands
  	DEFAULT_CHAT_FRAME:AddMessage(L["BONUSSCANNER_SLASH_STRING1"].._G["LIGHTYELLOW_FONT_COLOR_CODE"]..BONUSSCANNER_VERSION..L["BONUSSCANNER_SLASH_STRING1a"])
  	local k,numitems
  			numitems = 0
				for k in pairs(ItemCache) do
				if ItemCache[k] then
				 numitems = numitems + 1
				end
				end
		DEFAULT_CHAT_FRAME:AddMessage(_G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["BONUSSCANNER_CACHESUMMARY_LABEL"].."|cffffd200"..numitems)
  	DEFAULT_CHAT_FRAME:AddMessage(L["BONUSSCANNER_SLASH_STRING2"])
  	DEFAULT_CHAT_FRAME:AddMessage(L["BONUSSCANNER_SLASH_STRING3"])
  	DEFAULT_CHAT_FRAME:AddMessage(L["BONUSSCANNER_SLASH_STRING4"])
  	if BonusScannerConfig.tooltip == 1 then
  		DEFAULT_CHAT_FRAME:AddMessage(L["BONUSSCANNER_SLASH_STRING5"].._G["GREEN_FONT_COLOR_CODE"]..L["BONUSSCANNER_TOOLTIP_ENABLED"]..L["BONUSSCANNER_SLASH_STRING5a"])
  	else
  		DEFAULT_CHAT_FRAME:AddMessage(L["BONUSSCANNER_SLASH_STRING5"].._G["RED_FONT_COLOR_CODE"]..L["BONUSSCANNER_TOOLTIP_DISABLED"]..L["BONUSSCANNER_SLASH_STRING5a"])
  	end
  	if BonusScannerConfig.showgemcount == 1 then
  		DEFAULT_CHAT_FRAME:AddMessage(L["BONUSSCANNER_SLASH_STRING14"].._G["GREEN_FONT_COLOR_CODE"]..L["BONUSSCANNER_TOOLTIP_ENABLED"]..L["BONUSSCANNER_SLASH_STRING14a"])
  	else
  		DEFAULT_CHAT_FRAME:AddMessage(L["BONUSSCANNER_SLASH_STRING14"].._G["RED_FONT_COLOR_CODE"]..L["BONUSSCANNER_TOOLTIP_DISABLED"]..L["BONUSSCANNER_SLASH_STRING14a"])
  	end
  	if BonusScannerConfig.basiciteminfo == 1 then
  		DEFAULT_CHAT_FRAME:AddMessage(L["BONUSSCANNER_SLASH_STRING12"].._G["GREEN_FONT_COLOR_CODE"]..L["BONUSSCANNER_TOOLTIP_ENABLED"]..L["BONUSSCANNER_SLASH_STRING12a"])
  	else
  		DEFAULT_CHAT_FRAME:AddMessage(L["BONUSSCANNER_SLASH_STRING12"].._G["RED_FONT_COLOR_CODE"]..L["BONUSSCANNER_TOOLTIP_DISABLED"]..L["BONUSSCANNER_SLASH_STRING12a"])
  	end
  	if BonusScannerConfig.extendediteminfo == 1 then
  		DEFAULT_CHAT_FRAME:AddMessage(L["BONUSSCANNER_SLASH_STRING13"].._G["GREEN_FONT_COLOR_CODE"]..L["BONUSSCANNER_TOOLTIP_ENABLED"]..L["BONUSSCANNER_SLASH_STRING13a"])
  	else
  		DEFAULT_CHAT_FRAME:AddMessage(L["BONUSSCANNER_SLASH_STRING13"].._G["RED_FONT_COLOR_CODE"]..L["BONUSSCANNER_TOOLTIP_DISABLED"]..L["BONUSSCANNER_SLASH_STRING13a"])
  	end
  	if BonusScannerConfig.loadbroker == 1 then
  		DEFAULT_CHAT_FRAME:AddMessage(L["BONUSSCANNER_SLASH_STRING15"].._G["GREEN_FONT_COLOR_CODE"]..L["BONUSSCANNER_TOOLTIP_ENABLED"]..L["BONUSSCANNER_SLASH_STRING15a"])
  	else
  		DEFAULT_CHAT_FRAME:AddMessage(L["BONUSSCANNER_SLASH_STRING15"].._G["RED_FONT_COLOR_CODE"]..L["BONUSSCANNER_TOOLTIP_DISABLED"]..L["BONUSSCANNER_SLASH_STRING15a"])
  	end
  	DEFAULT_CHAT_FRAME:AddMessage(L["BONUSSCANNER_SLASH_STRING11"])
  	DEFAULT_CHAT_FRAME:AddMessage(L["BONUSSCANNER_SLASH_STRING6"])
  	DEFAULT_CHAT_FRAME:AddMessage(L["BONUSSCANNER_SLASH_STRING7"])
  	DEFAULT_CHAT_FRAME:AddMessage(L["BONUSSCANNER_SLASH_STRING8"])
  	DEFAULT_CHAT_FRAME:AddMessage(L["BONUSSCANNER_SLASH_STRING9"])
  	DEFAULT_CHAT_FRAME:AddMessage(L["BONUSSCANNER_SLASH_STRING10"])
end

SLASH_BONUSSCANNER1 = "/bonusscanner"
SLASH_BONUSSCANNER2 = "/bscan"
SlashCmdList["BONUSSCANNER"] = function(msg, editbox) BonusScanner:Cmd(msg) end

function BonusScanner:PrintInfoDetailed()
	local bonus, name, i, j, slot, first, s, e, ratingval, points
	
for _, bonus in pairs(BONUSSCANNER_EFFECTS) do
		if self.bonuses[bonus.effect] then
			first = true
			s = "("
			for j, slot in pairs(self.slots) do 
				if self.bonuses_details[bonus.effect][slot] then
					if(not first) then
						s = s .. ", "
					else
						first = false
					end
				  s = s .._G["LIGHTYELLOW_FONT_COLOR_CODE"]..slot.._G["HIGHLIGHT_FONT_COLOR_CODE"]..": "..self.bonuses_details[bonus.effect][slot]
				end
			end
			if self.bonuses_details[bonus.effect]["Set"] then
				if not first then
					s = s .. ", "
				end
				s = s .._G["LIGHTYELLOW_FONT_COLOR_CODE"].."Set".._G["HIGHLIGHT_FONT_COLOR_CODE"]..": "..self.bonuses_details[bonus.effect]["Set"]
				end
			s = s .. ")"
			--rating conversion handled here
			if  bonus.pformat then
					ratingval, points = self:ProcessSpecialBonus(bonus.effect, self.bonuses[bonus.effect], UnitLevel("player"))
					if ratingval == "" then
				 ratingval = " ("..format(bonus.pformat,points)..") "
				  end
				 else
				 ratingval = ""
			end	 				 
			DEFAULT_CHAT_FRAME:AddMessage(_G["GREEN_FONT_COLOR_CODE"]..L["BONUSSCANNER_NAMES"][bonus.effect]..": ".._G["HIGHLIGHT_FONT_COLOR_CODE"]..self.bonuses[bonus.effect]..ratingval.." " ..s)
		end
	end --end for

end --end function

function BonusScanner:PrintInfo(bonuses, GemnoRed, GemnoYellow, GemnoBlue, GemnoPrismatic, WhisperParam, IsItem)
	local bonus, name, e, level, class, ratingval, points
	local cat = ""
	-- Obligatory check	
	if not bonuses then return end
		
	for _,e in pairs (BONUSSCANNER_EFFECTS) do
	  if bonuses[e.effect] then
	  --set the level of the target for rating conversions. If we are scanning an item then use the player's level
			local tar = GetUnitName("target")
			if tar and not IsItem then
	  		level = UnitLevel("target")
	  		class = strupper(select(2,UnitClass("target")))
	  	else
	  		level = UnitLevel("player")
	  		class = strupper(select(2,UnitClass("player")))
	  	end
	  	--handle whispers with or without conversion here 
			if WhisperParam then
			  if e.pformat then
			   if IsItem then
			   ratingval = ""
			   else
			   	ratingval, points = self:ProcessSpecialBonus(e.effect, bonuses[e.effect], level, class)
			   	if ratingval == "" then
				 ratingval = " ("..format(e.pformat,points)..") "
				  end
				 end				   				 
		       SendChatMessage(L["BONUSSCANNER_NAMES"][e.effect]..": ".. bonuses[e.effect]..ratingval,"WHISPER",nil,WhisperParam)
        else
           SendChatMessage(L["BONUSSCANNER_NAMES"][e.effect]..": ".. bonuses[e.effect],"WHISPER",nil,WhisperParam)
         end
			else
				 if e.cat ~= cat then
				cat = e.cat
				DEFAULT_CHAT_FRAME:AddMessage(_G["GREEN_FONT_COLOR_CODE"]..L["BONUSSCANNER_CAT_"..cat]..":")
				 end
				 --handle rating conversion here
				 if e.pformat then
				 	ratingval, points = self:ProcessSpecialBonus (e.effect, bonuses[e.effect], level, class)
				 	if ratingval =="" then
				 ratingval = " ("..format(e.pformat,points or 0)..") "
				  end
				 DEFAULT_CHAT_FRAME:AddMessage(_G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["BONUSSCANNER_NAMES"][e.effect]..": ".._G["HIGHLIGHT_FONT_COLOR_CODE"]..bonuses[e.effect]..ratingval)
				 else
			     DEFAULT_CHAT_FRAME:AddMessage(_G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["BONUSSCANNER_NAMES"][e.effect]..": ".._G["HIGHLIGHT_FONT_COLOR_CODE"]..bonuses[e.effect])
			   end
			end			
	  end
	end --end for
	
if not WhisperParam then	
	if GemnoRed~=0 or GemnoYellow~=0 or GemnoBlue~=0 or GemnoPrismatic~=0 then
					DEFAULT_CHAT_FRAME:AddMessage(_G["GREEN_FONT_COLOR_CODE"]..L["BONUSSCANNER_CAT_GEMS"]..":")
				 end
				 if GemnoRed~=0 then
					DEFAULT_CHAT_FRAME:AddMessage(_G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["BONUSSCANNER_GEMCOUNT_LABEL"].._G["RED_FONT_COLOR_CODE"]..L["BONUSSCANNER_GEMRED_LABEL"].._G["LIGHTYELLOW_FONT_COLOR_CODE"]..": ".._G["HIGHLIGHT_FONT_COLOR_CODE"]..GemnoRed)
				 end
				 if GemnoYellow~=0 then
					DEFAULT_CHAT_FRAME:AddMessage(_G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["BONUSSCANNER_GEMCOUNT_LABEL"].."|cffffd200"..L["BONUSSCANNER_GEMYELLOW_LABEL"].._G["LIGHTYELLOW_FONT_COLOR_CODE"]..": ".._G["HIGHLIGHT_FONT_COLOR_CODE"]..GemnoYellow)
				 end
				if GemnoBlue~=0 then
					DEFAULT_CHAT_FRAME:AddMessage(_G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["BONUSSCANNER_GEMCOUNT_LABEL"].."|cff2459ff"..L["BONUSSCANNER_GEMBLUE_LABEL"].._G["LIGHTYELLOW_FONT_COLOR_CODE"]..": ".._G["HIGHLIGHT_FONT_COLOR_CODE"]..GemnoBlue)
				 end
				 if GemnoPrismatic~=0 then
					DEFAULT_CHAT_FRAME:AddMessage(_G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["BONUSSCANNER_GEMCOUNT_LABEL"].._G["HIGHLIGHT_FONT_COLOR_CODE"]..L["BONUSSCANNER_GEMPRISM_LABEL"].._G["LIGHTYELLOW_FONT_COLOR_CODE"]..": ".._G["HIGHLIGHT_FONT_COLOR_CODE"]..GemnoPrismatic)
				 end
	else
	  if GemnoRed~=0 or GemnoYellow~=0 or GemnoBlue~=0 or GemnoPrismatic~=0 then
					SendChatMessage(L["BONUSSCANNER_CAT_GEMS"]..":","WHISPER",nil,WhisperParam)
				 end
				 if GemnoRed~=0 then
					SendChatMessage(L["BONUSSCANNER_GEMCOUNT_LABEL"]..L["BONUSSCANNER_GEMRED_LABEL"]..": "..GemnoRed,"WHISPER",nil,WhisperParam)
				 end
				 if GemnoYellow~=0 then
					SendChatMessage(L["BONUSSCANNER_GEMCOUNT_LABEL"]..L["BONUSSCANNER_GEMYELLOW_LABEL"]..": "..GemnoYellow,"WHISPER",nil,WhisperParam)
				 end
				if GemnoBlue~=0 then
					SendChatMessage(L["BONUSSCANNER_GEMCOUNT_LABEL"]..L["BONUSSCANNER_GEMBLUE_LABEL"]..": "..GemnoBlue,"WHISPER",nil,WhisperParam)
				 end
				if GemnoPrismatic~=0 then
					SendChatMessage(L["BONUSSCANNER_GEMCOUNT_LABEL"]..L["BONUSSCANNER_GEMPRISM_LABEL"]..": "..GemnoPrismatic,"WHISPER",nil,WhisperParam)
				 end
 end
end --end function