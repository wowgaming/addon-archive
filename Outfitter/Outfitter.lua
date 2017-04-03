----------------------------------------
-- Outfitter Copyright 2009, 2010 John Stephen, wobbleworks.com
-- All rights reserved, unauthorized redistribution is prohibited
----------------------------------------

Outfitter.Debug =
{
	InventoryCache = false,
	EquipmentChanges = false,
	EquipmentManager = false,
	NewItems = false,
	TemporaryItems = false,
	Optimize = false,
}

----------------------------------------
Outfitter.CreditPlayersByRealm =
--
-- 0 Friend
-- 1 Tester or developer (bugfixes, enhancements, etc.)
-- 2 Localizer
-- 3 Donor
----------------------------------------
{
	[Outfitter.cGermanLocalization] =
	{
		["Ani"] = 2,
		["Zokrym"] = 2,
		["Dessa"] = 2,
	},
	[Outfitter.cChineseLocalization] =
	{
		["AndyAska"] = 2,
		["xingdvd"] = 2,
	},
	[Outfitter.cFrenchLocalization] =
	{
		["Jullye"] = 2,
		["Quetzaco"] = 2,
		["Ekhurr"] = 2,
		["Negwe"] = 2,
	},
	[Outfitter.cSpanishLocalization] =
	{
		["Marutak"] = 2,
		["Marosth"] = 2,
	},
	[Outfitter.cRussianLocalization] =
	{
		["Delika"] = 2,
	},
	[Outfitter.cKoreanLocalization] =
	{
		["Unknown"] = 2,
	},
	[Outfitter.cContributingDeveloper] =
	{
		["Dridzt"] = 1,
		["Bruce Quinton"] = 1,
		["Kal_Zakath13"] = 1,
		["Smurfy"] = 1,
		["XMinionX"] = 1,
		["Dussander"] = 1,
		["Echobravo"] = 1,
		["MacGregor"] = 1,
		["LaoTseu"] = 1,
	},
	["Tester"] =
	{
		["Whishann"] = 1,
		["HunterZ"] = 1,
		["docthis"] = 1,
		["Irdx"] = 1,
		["TigaFIN"] = 1,
		["iceeagle"] = 1,
		["Denrax"] = 1,
		["rasmoe"] = 1,
		["Katlefiya"] = 1,
		["gtmsece"] = 1,
		["Militis"] = 1,
		["Casard"] = 1,
		["saltorio"] = 1,
		["elusif"] = 1,
		["DanoPDX"] = 1,
	},
	["Alterac Mountains"] =
	{
		["Asgeirr\n<The Stone Council>"] = 3,
	},
	["Aman'Thul"] =
	{
		["Blessmie\n<Chairman of the Horde>"] = 3,
		["Zanoroy\n<The Mighty Few>"] = 3,
	},
	["Antonidas"] =
	{
		["Colina\n<Drunken Monkey Brigade>"] = 3,
	},
	["Anvilmar"] =
	{
		["Droodwrmycar"] = 3,
	},
	["Azgalore"] =
	{
		["Dankris\n<Caligula's Pleasures>"] = 3,
	},
	["Blackwater Raiders"] =
	{
		["Maumau\n<No Quarter>"] = 3,
	},
	["Bronzebeard"] =
	{
		["Jiminimonka\n<Go Rin No Sho>"] = 3,
	},
	["Dalaran"] =
	{
		["Y C\n<Blurred Reality>"] = 3,
	},
	["Draenor"] =
	{
		["Emmerald\n<Adept>"] = 3,
	}, 
	["Draka"] =
	{
		["Nagem\n<Loch Modan Yacht Club"] = 3,
	},
	["Durotar"] =
	{
		["Haguen"] = 3,
	},
	Ghostlands =
	{
		Nounchok = 3,
	},
	["Gnomeregan"] =
	{
		["Calind\n<Swords of the Alliance>"] = 3,
	},
	["Jubei'Thos"] =
	{
		["Thoresen\n<Verb>"] = 3,
		["Thorgils"] = 3,
	},
	["Kargath"] =
	{
		["Leara"] = 3,
		["Burnaron\nLiga of Faliviens"] = 3,
	},
	["Khaz Modan"] =
	{
		["Faizal"] = 3,
	},
	["Khaz'goroth"] =
	{
		["Xentric\n<Cult of the Nuzzled Nark>"] = 3,
	},
	["Kul'Tiras"] =
	{
		["Tharca"] = 3,
	},
	["Lightbringer"] =
	{
		["Teldra\n<The Trust>"] = 3,
	},
	["Llane"] =
	{
		["Chirily"] = 3,
	},
	["Malfurion"] =
	{
		["Zetac\n<Hold Fast>"] = 3,
	},
	["Moonglade"] =
	{
		["Ciev"] = 3,
	},
	["Rexxar"] =
	{
		["Blitzi\n<Absolution>"] = 3,
	},
	["Scilla"] =
	{
		["Blam\n<Syndicate>"] = 3,
	},
	["Sentinels"] =
	{
		["Dhaktar"] = 3,
	},
	["Skywall"] =
	{
		["Valerya"] = 3,
	},
	["Suramar"] =
	{
		["Zendex"] = 3,
		["Klaxon\n<Forbidden Planet"] = 3,
	},
	["Terrokkar"] =
	{
		["Extropianus\n<The First Immortals>"] = 3,
	},
	["Thorium Brotherhood"] =
	{
		["Pitchifus\n<Bloodforged>"] = 0,
		Tiae = 0,
		Airmid = 0,
		Pistachio = 0,
		Fizzlebang = 0,
		[Outfitter.cGuildCreditFormat:format("Bloodforged")] = 1,
	},
	["Ysondre"] =
	{
		["Steikfrit"] = 3,
	},
	["Zangarmarsh"] =
	{
		["Feliany"] = 3,
	},
}

-- The following players are guilty of douchebaggery and
-- I refuse to support their gameplay in my addons.  They
-- have either demonstrated a complete disregard for other
-- players, engaged in racist or hateful public speech,
-- or have publicly stated how little they value the free
-- and generous work of addon authors.  In any case, they
-- can do without my addons

Outfitter.Douchebags =
{
	["Thorium Brotherhood"] =
	{
		Viu = true,
		Criska = true,
		Dolnis = true,
		Karan = true,
		Argos = true,
		Puldifrin = true,
		Carebearslol = true,
		["Núke"] = true,
		Tizzoke = true, -- "if i hear from a GM directly that what i am doing is against the rules, then i would stop"
		Azarra = true, -- just an asshole
		Rainbowblush = true, -- walking over other player's bobbers to help a friend win the fishing tournament? seriously? douchebag.
		Maveste = true,
		Atmosphear = true, -- "Fuck the president. Someone needs to shoot that fuck in the face" orly? Douche.  Hope the Secret Service or FBI finds you.
	},
	["Terenas"] =
	{
		Mulaut = true,
	},
	["Illidan"] =
	{
		Moof = true, -- "I'm sure you can get a similar addon for free. You really must be a tool to buy an addon."
	},
	["Eldre'Thalas"] =
	{
		Printer = true, -- Personal and unwarranted attack on a community member I admire
	},
	["Hakkar"] =
	{
		Forcore = true, -- idiot
	},
}

----------------------------------------
----------------------------------------

gOutfitter_Settings = nil
gOutfitter_GlobalSettings = nil

Outfitter.Initialized = false
Outfitter.Suspended = false
	
-- Outfit state
	
Outfitter.OutfitStack = {}
Outfitter.OutfitStack.Outfits = {}

Outfitter.CurrentOutfit = nil
Outfitter.ExpectedOutfit = nil
Outfitter.CurrentInventoryOutfit = nil

Outfitter.EquippedNeedsUpdate = false
Outfitter.LastEquipmentUpdateTime = 0

Outfitter.SpecialState = {} -- The current state as determined by the engine, not necessarily the state of the outfit itself

-- Player state

Outfitter.CurrentZone = ""
Outfitter.CurrentZoneIDs = {}

Outfitter.InCombat = false
Outfitter.MaybeInCombat = false

Outfitter.IsDead = false
Outfitter.IsFeigning = false

Outfitter.BankFrameIsOpen = false

Outfitter.HasHWEvent = false

Outfitter.SettingTypeInfo =
{
	string      = {Default = "",    FrameType = "EditBox"          },
	number      = {Default = 0,     FrameType = "EditBox"          },
	stringtable = {Default = {},    FrameType = "ScrollableEditBox"},
	zonelist    = {Default = {},    FrameType = "ZoneListEditBox"  },
	boolean     = {Default = false, FrameType = "Checkbox"         },
}

Outfitter.Style = {}

Outfitter.Style.ButtonBar =
{
	ButtonHeight = 37,
	ButtonWidth = 37,
	
	BackgroundTextureHeight = 128,
	BackgroundTextureWidth = 128,
	
	BackgroundWidth = 42,
	BackgroundWidth0 = 26,
	BackgroundWidthN = 27,
	
	BackgroundHeight = 41,
	BackgroundHeight0 = 28,
	BackgroundHeightN = 25,
}

-- UI

Outfitter.CurrentPanel = 0
Outfitter.Collapsed = {}
Outfitter.SelectedOutfit = nil
Outfitter.DisplayIsDirty = true
Outfitter.OutfitInfoCache = {}

Outfitter.MaxSimpleTitles = 10

function Outfitter:FormatItemList(pList)
	local vNumItems = #pList
	
	if vNumItems == 0 then
		return ""
	elseif vNumItems == 1 then
		return string.format(self.cSingleItemFormat, pList[1])
	elseif vNumItems == 2 then
		return string.format(self.cTwoItemFormat, pList[1], pList[2])
	else
		local vStartIndex, vEndIndex, vPrefix, vRepeat, vSuffix = string.find(self.cMultiItemFormat, "(.*){{(.*)}}(.*)")
		local vResult
		local vParamIndex = 1
		
		if vPrefix and string.find(vPrefix, "%%") then
			vResult = string.format(vPrefix, pList[1])
			vParamIndex = 2
		else
			vResult = vPrefix or ""
		end
		
		if vRepeat then
			for vIndex = vParamIndex, vNumItems - 1 do
				vResult = vResult..string.format(vRepeat, pList[vIndex])
			end
		end
			
		if vSuffix then
			vResult = vResult..string.format(vSuffix, pList[vNumItems])
		end
		
		return vResult
	end
end

-- Define global variables to be used directly in the XML
-- file since those references can't be object paths

Outfitter_cTitle = Outfitter.cTitle
Outfitter_cTitleVersion = Outfitter.cTitleVersion

Outfitter_cCreateUsingTitle = Outfitter.cCreateUsingTitle
Outfitter_cAutomationLabel = Outfitter.cAutomationLabel
Outfitter_cOutfitterTabTitle = Outfitter.cOutfitterTabTitle
Outfitter_cOptionsTabTitle = Outfitter.cOptionsTabTitle
Outfitter_cAboutTabTitle = Outfitter.cAboutTabTitle

Outfitter_cNewOutfit = Outfitter.cNewOutfit
Outfitter_cNameAlreadyUsedError = Outfitter.cNameAlreadyUsedError
Outfitter_cEnableAll = Outfitter.cEnableAll
Outfitter_cEnableNone = Outfitter.cEnableNone
Outfitter_cOptionsTitle = Outfitter.cOptionsTitle

Outfitter_cEditScriptTitle = Outfitter.cEditScriptTitle
Outfitter_cEditScriptEllide = Outfitter.cEditScriptEllide
Outfitter_cPresetScript = Outfitter.cPresetScript
Outfitter_cSettings = Outfitter.cSettings
Outfitter_cSource = Outfitter.cSource

Outfitter_cIconFilterLabel = Outfitter.cIconFilterLabel
Outfitter_cIconSetLabel = Outfitter.cIconSetLabel

-- These definitions are for backward compatibility with third-party addons
-- which call into Outfitter directly (OutfitterFu, FishingBuddy, ArkInventory)
-- Hopefully the authors of those addons will eventually migrate their code to
-- use the new functions instead so that these can eventually be eliminated.

Outfitter_cFishingStatName = Outfitter.LibStatLogic:GetStatNameFromID("FISHING")

Outfitter_cCompleteOutfits = Outfitter.cCompleteOutfits
Outfitter_cAccessoryOutfits = Outfitter.cAccessoryOutfits
Outfitter_cOddsNEndsOutfits = Outfitter.cOddsNEndsOutfits

function Outfitter_OnLoad(...) return Outfitter:OnLoad(...) end
function Outfitter_IsInitialized(...) return Outfitter:IsInitialized(...) end
function Outfitter_Update(...) return Outfitter:Update(...) end

function Outfitter_FindOutfitByStatID(...) return Outfitter:FindOutfitByStatID(...) end
function Outfitter_FindOutfitByName(...) return Outfitter:FindOutfitByName(...) end

function Outfitter_GetCategoryOrder(...) return Outfitter:GetCategoryOrder(...) end
function Outfitter_GetOutfitsByCategoryID(...) return Outfitter:GetOutfitsByCategoryID(...) end
function Outfitter_HasVisibleOutfits(...) return Outfitter:HasVisibleOutfits(...) end
function Outfitter_OutfitIsVisible(...) return Outfitter:OutfitIsVisible(...) end

function Outfitter_GenerateSmartOutfit(pName, pStat, pInventoryCache, pAllowEmptyOutfit) return Outfitter:GenerateSmartOutfit(pName, pStat, pInventoryCache, pAllowEmptyOutfit) end
function Outfitter_AddOutfit(...) return Outfitter:AddOutfit(...) end
function Outfitter_DeleteOutfit(...) return Outfitter:DeleteOutfit(...) end

function Outfitter_WearOutfit(pOutfit, pCategoryID, pWearBelowOutfit) return Outfitter:WearOutfit(pOutfit) end
function Outfitter_RemoveOutfit(...) return Outfitter:RemoveOutfit(...) end
function Outfitter_WearingOutfit(...) return Outfitter:WearingOutfit(...) end

function Outfitter_RegisterOutfitEvent(...) return Outfitter:RegisterOutfitEvent(...) end
function Outfitter_UnregisterOutfitEvent(...) return Outfitter:UnregisterOutfitEvent(...) end

function Outfitter_GetOutfitFromListItem(...) return Outfitter:GetOutfitFromListItem(...) end
function Outfitter_GetCurrentOutfitInfo(...) return Outfitter:GetCurrentOutfitInfo(...) end
function Outfitter_SetShowMinimapButton(...) return Outfitter:SetShowMinimapButton(...) end

function Outfitter_GetItemInfoFromLink(...) return Outfitter:GetItemInfoFromLink(...) end
function Outfitter_GetOutfitsUsingItem(...) return Outfitter:GetOutfitsUsingItem(...) end

function OutfitterItemList_GetEquippableItems(...) return Outfitter:GetInventoryCache(...) end
function OutfitterItemList_GetMissingItems(pItemList, ...) return pItemList:GetMissingItems(...) end

function Outfitter.ItemList_GetEquippableItems(...) return Outfitter:GetInventoryCache(...) end
function Outfitter.ItemList_GetMissingItems(pItemList, ...) return pItemList:GetMissingItems(...) end

function OutfitterMinimapButton_ItemSelected(...) return Outfitter.MinimapButton_ItemSelected(...) end

function Outfitter:OutfitUsesItem(pOutfit, pItemInfo) return pOutfit:OutfitUsesItem(pItemInfo) end

--

Outfitter.OrigGameTooltipOnShow = nil
Outfitter.OrigGameTooltipOnHide = nil

Outfitter.cMinEquipmentUpdateInterval = 1.5

Outfitter.cInitializationEvents =
{
	["PLAYER_ENTERING_WORLD"] = true,
	["BAG_UPDATE"] = true,
	["UNIT_INVENTORY_CHANGED"] = true,
	["ZONE_CHANGED_NEW_AREA"] = true,
	["ZONE_CHANGED"] = true,
	["ZONE_CHANGED_INDOORS"] = true,
	["PLAYER_ALIVE"] = true,
}

Outfitter.BANKED_FONT_COLOR = {r = 0.25, g = 0.2, b = 1.0}
Outfitter.BANKED_FONT_COLOR_CODE = "|cff4033ff"
Outfitter.OUTFIT_MESSAGE_COLOR = {r = 0.2, g = 0.75, b = 0.3}

Outfitter.IsWoW4 = UnitGetIncomingHeals ~= nil
if Outfitter.IsWoW4 then
	Outfitter.cItemLinkFormat = "|Hitem:(-?%d+):(-?%d+):(-?%d+):(-?%d+):(-?%d+):(-?%d+):(-?%d+):(-?%d+):(-?%d+):(-?%d+)|h%[([^%]]*)%]|h"
else
	Outfitter.cItemLinkFormat = "|Hitem:(-?%d+):(-?%d+):(-?%d+):(-?%d+):(-?%d+):(-?%d+):(-?%d+):(-?%d+):(-?%d+)|h%[([^%]]*)%]|h"
end


Outfitter.cUniqueGemEnchantIDs =
{
	[2850] = 2850, -- Blood of Amber, ItemCode 33140, +13 Spell Critical Strike Rating
	[2749] = 2749, -- Brilliant Bladestone, ItemCode 33139, +12 Intellect
	[1068] = 1068, -- Charmed Amani Jewel, ItemCode 34256, +15 Stamina
	[1593] = 1593, -- Crimson Sun, ItemCode 33131, +24 Attack Power
	[368] = 368, -- Delicate Fire Ruby, ItemCode 33132, +12 Agility
	[3210] = 3210, -- Don Julio's Heart, ItemCode 33133
	[1957] = 1957, -- Facet of Eternity, ItemCode 33144, +12 Defense Rating
	[1071] = 1071, -- Falling Star, ItemCode 33135, +18 Stamina
	
	[3218] = 3218, -- Great Bladestone, ItemCode 33141, +12 Spell Hit Rating
	[3211] = 3211, -- Kailee's Rose, ItemCode 33134, +26 Healing and +9 Spell Damage
	[3215] = 3215, -- Mystic Bladestone, ItemCode 33138, +12 Resilience Rating
	[1591] = 1591, -- Radiant Spencerite, ItemCode 32735, +20 Attack Power
	[2784] = 2784, -- Rigid Bladestone, ItemCode 33142, +12 Hit Rating
	[370] = 370, -- Sparkling Falling Star, ItemCode 33137, +12 Spirit
	
	[3220] = 3220, -- Stone of Blades, ItemCode 33143, +12 Critical Strike Rating
	[2891] = 2891, -- Sublime Mystic Dawnstone, ItemCode 27679, +10 Resilience Rating
	[2899] = 2899, -- Barbed Deep Peridot, ItemCode 27786 & 27809, +3 Stamina, +4 Critical Strike Rating
	[3103] = 3103, -- Don Amancio's Heart, ItemCode 30598, +8 Strength (numerous enchants of +8 str)
	[3065] = 3065, -- Don Rodrigo's Heart, ItemCode 30571, +8 Strength
	[3268] = 3268, -- Eye of the Sea, ItemCode 34831, +15 Stamina
	[2943] = 2943, -- Mighty Blood Garnet, ItemCode 28360, +14 Attack Power
	[2944] = 2944, -- Mighty Blood Garnet, ItemCode 28361, +14 Attack Power
	[2898] = 2898, -- Notched Deep Peridot, ItemCode 27785, +3 Stamina, +4 Spell Critical Strike Rating
	[2923] = 2923, -- Notched Deep Peridot, ItemCode 27820, +3 Stamina, +4 Spell Critical Strike Rating
	[2896] = 2896, -- Stark Blood Garnet, ItemCode 27777, +8 Spell Damage
	[2924] = 2924, -- Stark Blood Garnet, ItemCode 27812, +8 Spell Damage
	[2970] = 2970, -- Swift Starfire Diamond, ItemCode 28557, +12 Spell Damage and Minor Run Speed Increase
	[2969] = 2969, -- Swift Windfire Diamond, ItemCode 28556, +20 Attack Power and Minor Run Speed Increase

	[3156] = 3156, -- Unstable Amethyst, ItemCode 32634, +8 Attack Power and +6 Stamina
	[3159] = 3159, -- Unstable Citrine, ItemCode 32637, +8 Attack Power
	[3157] = 3157, -- Unstable Peridot, ItemCode 32635,
	[3158] = 3158, -- Unstable Sapphire, ItemCode 32636
	[3161] = 3161, -- Unstable Talasite, ItemCode 32639
	[3160] = 3160, -- Unstable Topaz, ItemCode 32638
	
	-- WotLK unique-equipped
	
	[3749] = 3749, -- Enchanted Pearl, +4 all stats, ItemCode 42701
	[3750] = 3750, -- Enchanted Tear, +6 all stats, ItemCode 42702
	[3792] = 3792, -- Kharmaa's Grace, +20 resilience, ItemCode 44066
	
	-- WotLK JC Prismatics (unique-equipped x 3)
	
	[3732] = "PRISM3", -- Bold Dragon's Eye, 27str, ItemCode 42142
	[3292] = "PRISM3", -- Bright Dragon's Eye, 54att, ItemCode 36766
	[3737] = "PRISM3", -- Brilliant Dragon's Eye, 27int, ItemCode 42148
	[3733] = "PRISM3", -- Delicate Dragon's Eye, 27agi, ItemCode 42143
	[3741] = "PRISM3", -- Flashing Dragon's Eye, 27parry, ItemCode 42152
	[3745] = "PRISM3", -- Fractured Dragon's Eye, 27armorpen, ItemCode 42153
	[3736] = "PRISM3", -- Lustrous Dragon's Eye, 11mp5, ItemCode 42146
	[3744] = "PRISM3", -- Mystic Dragon's Eye, 27resil, ItemCode 42158
	[3746] = "PRISM3", -- Precise Dragon's Eye, 27exp, ItemCode 42154
	[3739] = "PRISM3", -- Quick Dragon's Eye, 27haste, ItemCode 42150
	[3742] = "PRISM3", -- Rigid Dragon's Eye, 27hit, ItemCode 42156
	[3734] = "PRISM3", -- Runed Dragon's Eye, 32spell, ItemCode 42144
	[3738] = "PRISM3", -- Smooth Dragon's Eye, 27crit, ItemCode 42149
	[3293] = "PRISM3", -- Solid Dragon's Eye, 41stam, ItemCode 36767
	[3735] = "PRISM3", -- Sparkling Dragon's Eye, 27spi, ItemCode 42145
	[3747] = "PRISM3", -- Stormy Dragon's Eye, 32spellpen, ItemCode 42155
	[3740] = "PRISM3", -- Subtle Dragon's Eye, 27dodge, ItemCode 42151
	[3743] = "PRISM3", -- Thick Dragon's Eye, 27def, ItemCode 42157
}

Outfitter.cUniqueGemItemIDs =
{
	[33140] = 33140, -- Blood of Amber, ItemCode 33140, +13 Spell Critical Strike Rating
	[33139] = 33139, -- Brilliant Bladestone, ItemCode 33139, +12 Intellect
	[34256] = 34256, -- Charmed Amani Jewel, ItemCode 34256, +15 Stamina
	[33131] = 33131, -- Crimson Sun, ItemCode 33131, +24 Attack Power
	[33132] = 33132, -- Delicate Fire Ruby, ItemCode 33132, +12 Agility
	[33133] = 33133, -- Don Julio's Heart, ItemCode 33133
	[33144] = 33144, -- Facet of Eternity, ItemCode 33144, +12 Defense Rating
	[33135] = 33135, -- Falling Star, ItemCode 33135, +18 Stamina
	
	[33141] = 33141, -- Great Bladestone, ItemCode 33141, +12 Spell Hit Rating
	[33134] = 33134, -- Kailee's Rose, ItemCode 33134, +26 Healing and +9 Spell Damage
	[33138] = 33138, -- Mystic Bladestone, ItemCode 33138, +12 Resilience Rating
	[32735] = 32735, -- Radiant Spencerite, ItemCode 32735, +20 Attack Power
	[33142] = 33142, -- Rigid Bladestone, ItemCode 33142, +12 Hit Rating
	[33137] = 33137, -- Sparkling Falling Star, ItemCode 33137, +12 Spirit
	
	[33143] = 3220, -- Stone of Blades, ItemCode 33143, +12 Critical Strike Rating
	[27679] = 2891, -- Sublime Mystic Dawnstone, ItemCode 27679, +10 Resilience Rating
	[27786] = 2899, -- Barbed Deep Peridot, ItemCode 27786 & 27809, +3 Stamina, +4 Critical Strike Rating
	[27809] = 2899, -- Barbed Deep Peridot, ItemCode 27786 & 27809, +3 Stamina, +4 Critical Strike Rating
	[30598] = 3103, -- Don Amancio's Heart, ItemCode 30598, +8 Strength (numerous enchants of +8 str)
	[30571] = 3065, -- Don Rodrigo's Heart, ItemCode 30571, +8 Strength
	[34831] = 3268, -- Eye of the Sea, ItemCode 34831, +15 Stamina
	[28360] = 2943, -- Mighty Blood Garnet, ItemCode 28360, +14 Attack Power
	[28361] = 2944, -- Mighty Blood Garnet, ItemCode 28361, +14 Attack Power
	[27785] = 2898, -- Notched Deep Peridot, ItemCode 27785, +3 Stamina, +4 Spell Critical Strike Rating
	[27820] = 2923, -- Notched Deep Peridot, ItemCode 27820, +3 Stamina, +4 Spell Critical Strike Rating
	[27777] = 2896, -- Stark Blood Garnet, ItemCode 27777, +8 Spell Damage
	[27812] = 2924, -- Stark Blood Garnet, ItemCode 27812, +8 Spell Damage
	[28557] = 2970, -- Swift Starfire Diamond, ItemCode 28557, +12 Spell Damage and Minor Run Speed Increase
	[28556] = 2969, -- Swift Windfire Diamond, ItemCode 28556, +20 Attack Power and Minor Run Speed Increase

	[32634] = 3156, -- Unstable Amethyst, ItemCode 32634, +8 Attack Power and +6 Stamina
	[32635] = 3157, -- Unstable Peridot, ItemCode 32635,
	[32636] = 3158, -- Unstable Sapphire, ItemCode 32636
	[32637] = 3159, -- Unstable Citrine, ItemCode 32637, +8 Attack Power
	[32638] = 3160, -- Unstable Topaz, ItemCode 32638
	[32639] = 3161, -- Unstable Talasite, ItemCode 32639
	
	-- WotLK unique-equipped
	
	[42701] = 3749, -- Enchanted Pearl, +4 all stats, ItemCode 42701
	[42702] = 3750, -- Enchanted Tear, +6 all stats, ItemCode 42702
	[44066] = 3792, -- Kharmaa's Grace, +20 resilience, ItemCode 44066
	
	-- WotLK JC Prismatics (unique-equipped x 3)
	
	[36766] = "PRISM3", -- Bright Dragon's Eye, 54att, ItemCode 36766
	[36767] = "PRISM3", -- Solid Dragon's Eye, 41stam, ItemCode 36767
	[42142] = "PRISM3", -- Bold Dragon's Eye, 27str, ItemCode 42142
	[42143] = "PRISM3", -- Delicate Dragon's Eye, 27agi, ItemCode 42143
	[42144] = "PRISM3", -- Runed Dragon's Eye, 32spell, ItemCode 42144
	[42145] = "PRISM3", -- Sparkling Dragon's Eye, 27spi, ItemCode 42145
	[42146] = "PRISM3", -- Lustrous Dragon's Eye, 11mp5, ItemCode 42146
	[42148] = "PRISM3", -- Brilliant Dragon's Eye, 27int, ItemCode 42148
	[42149] = "PRISM3", -- Smooth Dragon's Eye, 27crit, ItemCode 42149
	[42150] = "PRISM3", -- Quick Dragon's Eye, 27haste, ItemCode 42150
	[42151] = "PRISM3", -- Subtle Dragon's Eye, 27dodge, ItemCode 42151
	[42152] = "PRISM3", -- Flashing Dragon's Eye, 27parry, ItemCode 42152
	[42153] = "PRISM3", -- Fractured Dragon's Eye, 27armorpen, ItemCode 42153
	[42154] = "PRISM3", -- Precise Dragon's Eye, 27exp, ItemCode 42154
	[42155] = "PRISM3", -- Stormy Dragon's Eye, 32spellpen, ItemCode 42155
	[42156] = "PRISM3", -- Rigid Dragon's Eye, 27hit, ItemCode 42156
	[42157] = "PRISM3", -- Thick Dragon's Eye, 27def, ItemCode 42157
	[42158] = "PRISM3", -- Mystic Dragon's Eye, 27resil, ItemCode 42158
	
	-- Patch 3.2
	
	[49110] = 49110, -- Nightmare Tear
}

StaticPopupDialogs.OUTFITTER_CANT_RELOADUI =
{
	text = Outfitter.cCantReloadUI,
	button1 = OKAY,
	OnAccept = function() end,
	OnCancel = function() end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1,
	showAlert = 1,
}

StaticPopupDialogs.OUTFITTER_SERVER_FULL =
{
	text = Outfitter.cTooManyServerOutfits,
	button1 = OKAY,
	OnAccept = function() end,
	OnCancel = function() end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1,
	showAlert = 1,
}

StaticPopupDialogs.OUTFITTER_CANT_SET_ICON =
{
	text = Outfitter.cCantSetIcon,
	button1 = Outfitter.cChangeIcon,
	button2 = CANCEL,
	OnAccept = function() end,
	OnCancel = function() end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1,
	showAlert = 1,
}

StaticPopupDialogs.OUTFITTER_CONFIRM_DELETE =
{
	text = TEXT(Outfitter.cConfirmDeleteMsg),
	button1 = TEXT(DELETE),
	button2 = TEXT(CANCEL),
	OnAccept = function() Outfitter:DeleteSelectedOutfit() end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
}

StaticPopupDialogs.OUTFITTER_CONFIRM_REBUILD =
{
	text = TEXT(Outfitter.cConfirmRebuildMsg),
	button1 = TEXT(Outfitter.cRebuild),
	button2 = TEXT(CANCEL),
	OnAccept = function() Outfitter:RebuildOutfit(Outfitter.OutfitToRebuild) Outfitter.OutfitToRebuild = nil end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1,
}

StaticPopupDialogs.OUTFITTER_CONFIRM_SET_CURRENT =
{
	text = TEXT(Outfitter.cConfirmSetCurrentMsg),
	button1 = TEXT(Outfitter.cSetCurrent),
	button2 = TEXT(CANCEL),
	OnAccept = function() Outfitter:SetOutfitToCurrent(Outfitter.OutfitToRebuild); Outfitter.OutfitToRebuild = nil end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1,
}

Outfitter.cCategoryDescriptions =
{
	Complete = Outfitter.cCompleteCategoryDescription,
	Accessory = Outfitter.cAccessoryCategoryDescription,
	OddsNEnds = Outfitter.cOddsNEndsCategoryDescription,
}

Outfitter.cSlotNames =
{
	-- First priority goes to armor
	
	"HeadSlot",
	"ShoulderSlot",
	"ChestSlot",
	"WristSlot",
	"HandsSlot",
	"WaistSlot",
	"LegsSlot",
	"FeetSlot",
	
	-- Second priority goes to weapons
	
	"MainHandSlot",
	"SecondaryHandSlot",
	"RangedSlot",
	"AmmoSlot",
	
	-- Last priority goes to items with no durability
	
	"BackSlot",
	"NeckSlot",
	"ShirtSlot",
	"TabardSlot",
	"Finger0Slot",
	"Finger1Slot",
	"Trinket0Slot",
	"Trinket1Slot",
}

Outfitter.cSlotOrder = {}

for vIndex, vSlotName in ipairs(Outfitter.cSlotNames) do
	Outfitter.cSlotOrder[vSlotName] = vIndex
end

Outfitter.cSlotDisplayNames =
{
	HeadSlot = HEADSLOT,
	NeckSlot = NECKSLOT,
	ShoulderSlot = SHOULDERSLOT,
	BackSlot = BACKSLOT,
	ChestSlot = CHESTSLOT,
	ShirtSlot = SHIRTSLOT,
	TabardSlot = TABARDSLOT,
	WristSlot = WRISTSLOT,
	HandsSlot = HANDSSLOT,
	WaistSlot = WAISTSLOT,
	LegsSlot = LEGSSLOT,
	FeetSlot = FEETSLOT,
	Finger0Slot = Outfitter.cFinger0SlotName,
	Finger1Slot = Outfitter.cFinger1SlotName,
	Trinket0Slot = Outfitter.cTrinket0SlotName,
	Trinket1Slot = Outfitter.cTrinket1SlotName,
	MainHandSlot = MAINHANDSLOT,
	SecondaryHandSlot = SECONDARYHANDSLOT,
	RangedSlot = RANGEDSLOT,
	AmmoSlot = AMMOSLOT,
}

Outfitter.cInvTypeToSlotName =
{
	INVTYPE_2HWEAPON = {SlotName = "MainHandSlot", MetaSlotName = "TwoHandSlot"},
	INVTYPE_BODY = {SlotName = "ShirtSlot"},
	INVTYPE_CHEST = {SlotName = "ChestSlot"},
	INVTYPE_CLOAK = {SlotName = "BackSlot"},
	INVTYPE_FEET = {SlotName = "FeetSlot"},
	INVTYPE_FINGER = {SlotName = "Finger0Slot"},
	INVTYPE_HAND = {SlotName = "HandsSlot"},
	INVTYPE_HEAD = {SlotName = "HeadSlot"},
	INVTYPE_HOLDABLE = {SlotName = "SecondaryHandSlot"},
	INVTYPE_LEGS = {SlotName = "LegsSlot"},
	INVTYPE_NECK = {SlotName = "NeckSlot"},
	INVTYPE_RANGED = {SlotName = "RangedSlot"},
	INVTYPE_ROBE = {SlotName = "ChestSlot"},
	INVTYPE_SHIELD = {SlotName = "SecondaryHandSlot"},
	INVTYPE_SHOULDER = {SlotName = "ShoulderSlot"},
	INVTYPE_TABARD = {SlotName = "TabardSlot"},
	INVTYPE_TRINKET = {SlotName = "Trinket0Slot"},
	INVTYPE_WAIST = {SlotName = "WaistSlot"},
	INVTYPE_WEAPON = {SlotName = "MainHandSlot", MetaSlotName = "Weapon0Slot"},
	INVTYPE_WEAPONMAINHAND = {SlotName = "MainHandSlot"},
	INVTYPE_WEAPONOFFHAND = {SlotName = "SecondaryHandSlot"},
	INVTYPE_WRIST = {SlotName = "WristSlot"},
	INVTYPE_RANGEDRIGHT = {SlotName = "RangedSlot"},
	INVTYPE_AMMO = {SlotName = "AmmoSlot"},
	INVTYPE_THROWN = {SlotName = "RangedSlot"},
	INVTYPE_RELIC = {SlotName = "RangedSlot"},
}

Outfitter.cHalfAlternateStatSlot =
{
	Trinket0Slot = "Trinket1Slot",
	Finger0Slot = "Finger1Slot",
	Weapon0Slot = "Weapon1Slot",
}

Outfitter.cFullAlternateStatSlot =
{
	Trinket0Slot = "Trinket1Slot",
	Trinket1Slot = "Trinket0Slot",
	Finger0Slot = "Finger1Slot",
	Finger1Slot = "Finger0Slot",
	Weapon0Slot = "Weapon1Slot",
	Weapon1Slot = "Weapon0Slot",
}

Outfitter.cCategoryOrder =
{
	"Complete",
	"Accessory"
}

Outfitter.cItemAliases =
{
	[18608] = 18609,	-- Benediction -> Anathema
	[18609] = 18608,	-- Anathema -> Benediction
	[17223] = 17074,	-- Thunderstrike -> Shadowstrike
	[17074] = 17223,	-- Shadowstrike -> Thunderstrike
	
	[46069] = 46106,	-- Alliance Lance -> Argent Lance
	[46070] = 46106,	-- Horde Lance -> Argent Lance
	[46106] = 46069,	-- Argent Lance -> Alliance Lance (will be replaced by Horde Lance at runtime)
}

Outfitter.cIgnoredUnusedItems = 
{
	[2901] = "Mining Pick",
	[5956] = "Blacksmith hammer",
	[6219] = "Arclight Spanner",
	[7005] = "Skinning Knife",
	[7297] = "Morbent's Bane",
	[10696] = "Enchanted Azsharite Felbane Sword",
	[10697] = "Enchanted Azsharite Felbane Dagger",
	[10698] = "Enchanted Azsharite Felbane Staff",
	[20406] = "Twilight Cultist Mantle",
	[20407] = "Twilight Cultist Robe",
	[20408] = "Twilight Cultist Cowl",
}

Outfitter.cSmartOutfits =
{
	{Name = Outfitter.cFishingOutfit, StatID = "FISHING", ScriptID = "Fishing"},
	{Name = Outfitter.cHerbalismOutfit, StatID = "HERBALISM", ScriptID = "Herbalism"},
	{Name = Outfitter.cMiningOutfit, StatID = "MINING", ScriptID = "Mining"},
	{Name = Outfitter.cSkinningOutfit, StatID = "SKINNING", ScriptID = "Skinning"},
	{Name = Outfitter.cFireResistOutfit, StatID = "FIRE_RES"},
	{Name = Outfitter.cNatureResistOutfit, StatID = "NATURE_RES"},
	{Name = Outfitter.cShadowResistOutfit, StatID = "SHADOW_RES"},
	{Name = Outfitter.cArcaneResistOutfit, StatID = "ARCANE_RES"},
	{Name = Outfitter.cFrostResistOutfit, StatID = "FROST_RES"},
}

Outfitter.cSpecialIDEvents =
{
	Battle = {Equip = "BATTLE_STANCE", Unequip = "NOT_BATTLE_STANCE"},
	Defensive = {Equip = "DEFENSIVE_STANCE", Unequip = "NOT_DEFENSIVE_STANCE"},
	Berserker = {Equip = "BERSERKER_STANCE", Unequip = "NOT_BERSERKER_STANCE"},
	
	Bear = {Equip = "BEAR_FORM", Unequip = "NOT_BEAR_FORM"},
	Cat = {Equip = "CAT_FORM", Unequip = "NOT_CAT_FORM"},
	Aquatic = {Equip = "AQUATIC_FORM", Unequip = "NOT_AQUATIC_FORM"},
	Travel = {Equip = "TRAVEL_FORM", Unequip = "NOT_TRAVEL_FORM"},
	Moonkin = {Equip = "MOONKIN_FORM", Unequip = "NOT_MOONKIN_FORM"},
	Tree = {Equip = "TREE_FORM", Unequip = "NOT_TREE_FORM"},
	Prowl = {Equip = "STEALTH", Unequip = "NOT_STEALTH"},
	Flight = {Equip = "FLIGHT_FORM", Unequip = "NOT_FLIGHT_FORM"},
	Caster = {Equip = "CASTER_FORM", Unequip = "NOT_CASTER_FORM"},
	
	Shadowform = {Equip = "SHADOWFORM", Unequip = "NOT_SHADOWFORM"},

	Stealth = {Equip = "STEALTH", Unequip = "NOT_STEALTH"},

	GhostWolf = {Equip = "GHOST_WOLF", Unequip = "NOT_GHOST_WOLF"},

	Monkey = {Equip = "MONKEY_ASPECT", Unequip = "NOT_MONKEY_ASPECT"},
	Hawk = {Equip = "HAWK_ASPECT", Unequip = "NOT_HAWK_ASPECT"},
	Cheetah = {Equip = "CHEETAH_ASPECT", Unequip = "NOT_CHEETAH_ASPECT"},
	Pack = {Equip = "PACK_ASPECT", Unequip = "NOT_PACK_ASPECT"},
	Beast = {Equip = "BEAST_ASPECT", Unequip = "NOT_BEAST_ASPECT"},
	Wild = {Equip = "WILD_ASPECT", Unequip = "NOT_WILD_ASPECT"},
	Viper = {Equip = "VIPER_ASPECT", Unequip = "NOT_VIPER_ASPECT"},
	Dragonhawk = {Equip = "DRAGONHAWK_ASPECT", Unequip = "NOT_DRAGONHAWK_ASPECT"},
	Feigning = {Equip = "FEIGN_DEATH", Unequip = "NOT_FEIGN_DEATH"},
	
	Evocate = {Equip = "EVOCATE", Unequip = "NOT_EVOCATE"},
	
	Blood = {Equip = "BLOOD", Unequip = "NOT_BLOOD"},
	Frost = {Equip = "FROST", Unequip = "NOT_FROST"},
	Unholy = {Equip = "UNHOLY", Unequip = "NOT_UNHOLY"},

	Dining = {Equip = "DINING", Unequip = "NOT_DINING"},
	City = {Equip = "CITY", Unequip = "NOT_CITY"},
	Riding = {Equip = "MOUNTED", Unequip = "NOT_MOUNTED"},
	Swimming = {Equip = "SWIMMING", Unequip = "NOT_SWIMMING"},
	Spirit = {Equip = "SPIRIT_REGEN", Unequip = "NOT_SPIRIT_REGEN"},
	ArgentDawn = {Equip = "ARGENT_DAWN", Unequip = "NOT_ARGENT_DAWN"},

	Battleground = {Equip = "BATTLEGROUND", Unequip = "NOT_BATTLEGROUND"},
	AB = {Equip = "BATTLEGROUND_AB", Unequip = "NOT_BATTLEGROUND_AB"},
	AV = {Equip = "BATTLEGROUND_AV", Unequip = "NOT_BATTLEGROUND_AV"},
	WSG = {Equip = "BATTLEGROUND_WSG", Unequip = "NOT_BATTLEGROUND_WSG"},
	EotS = {Equip = "BATTLEGROUND_EOTS", Unequip = "NOT_BATTLEGROUND_EOTS"},
	SotA = {Equip = "BATTLEGROUND_SOTA", Unequip = "NOT_BATTLEGROUND_SOTA"},
	IoC = {Equip = "BATTLEGROUND_IOC", Unequip = "NOT_BATTLEGROUND_IOC"},
	Wintergrasp = {Equip = "BATTLEGROUND_WG", Unequip = "NOT_BATTLEGROUND_WG"},
	Sewers = {Equip = "BATTLEGROUND_SEWERS", Unequip = "NOT_BATTLEGROUND_SEWERS"},
	RingOfValor = {Equip = "BATTLEGROUND_ROV", Unequip = "NOT_BATTLEGROUND_ROV"},
	Arena = {Equip = "BATTLEGROUND_ARENA", Unequip = "NOT_BATTLEGROUND_ARENA"},
	BladesEdgeArena = {Equip = "BATTLEGROUND_BLADESEDGE", Unequip = "NOT_BATTLEGROUND_BLADESEDGE"},
	NagrandArena = {Equip = "BATTLEGROUND_NAGRAND", Unequip = "NOT_BATTLEGROUND_NAGRAND"},
	LordaeronArena = {Equip = "BATTLEGROUND_LORDAERON", Unequip = "NOT_BATTLEGROUND_LORDAERON"},
}

Outfitter.cClassSpecialOutfits =
{
	WARRIOR =
	{
		{Name = Outfitter.cWarriorBattleStance, ScriptID = "Battle"},
		{Name = Outfitter.cWarriorDefensiveStance, ScriptID = "Defensive"},
		{Name = Outfitter.cWarriorBerserkerStance, ScriptID = "Berserker"},
	},
	
	DRUID =
	{
		{Name = Outfitter.cDruidCasterForm, ScriptID = "Caster"},
		{Name = Outfitter.cDruidBearForm, ScriptID = "Bear"},
		{Name = Outfitter.cDruidCatForm, ScriptID = "Cat"},
		{Name = Outfitter.cDruidAquaticForm, ScriptID = "Aquatic"},
		{Name = Outfitter.cDruidTravelForm, ScriptID = "Travel"},
		{Name = Outfitter.cDruidMoonkinForm, ScriptID = "Moonkin"},
		{Name = Outfitter.cDruidTreeOfLifeForm, ScriptID = "Tree"},
		{Name = Outfitter.cDruidProwl, ScriptID = "Prowl"},
		{Name = Outfitter.cDruidFlightForm, ScriptID = "Flight"},
	},
	
	PRIEST =
	{
		{Name = Outfitter.cPriestShadowform, ScriptID = "Shadowform"},
	},
	
	ROGUE =
	{
		{Name = Outfitter.cRogueStealth, ScriptID = "Stealth"},
	},
	
	SHAMAN =
	{
		{Name = Outfitter.cShamanGhostWolf, ScriptID = "GhostWolf"},
	},
	
	HUNTER =
	{
		{Name = Outfitter.cHunterMonkey, ScriptID = "Monkey"},
		{Name = Outfitter.cHunterHawk, ScriptID = "Hawk"},
		{Name = Outfitter.cHunterCheetah, ScriptID = "Cheetah"},
		{Name = Outfitter.cHunterPack, ScriptID = "Pack"},
		{Name = Outfitter.cHunterBeast, ScriptID = "Beast"},
		{Name = Outfitter.cHunterWild, ScriptID = "Wild"},
		{Name = Outfitter.cHunterViper, ScriptID = "Viper"},
		{Name = Outfitter.cHunterDragonhawk, ScriptID = "Dragonhawk"},
	},
	
	MAGE =
	{
		{Name = Outfitter.cMageEvocate, ScriptID = "Evocate"},
	},
	
	DEATHKNIGHT =
	{
		{Name = Outfitter.cDeathknightBlood, ScriptID = "Blood"},
		{Name = Outfitter.cDeathknightFrost, ScriptID = "Frost"},
		{Name = Outfitter.cDeathknightUnholy, ScriptID = "Unholy"},
	},
}

Outfitter.cSpellIDToSpecialID =
{
	[5118] = "Cheetah",
	[13159] = "Pack",
	[13161] = "Beast",
	[13163] = "Monkey",
	[20043] = "Wild",
	[20190] = "Wild",
	[27045] = "Wild",
	[49071] = "Wild",
	[34074] = "Viper",
	
	[13165] = "Hawk",
	[14318] = "Hawk",
	[14319] = "Hawk",
	[14320] = "Hawk",
	[14321] = "Hawk",
	[14322] = "Hawk",
	[25296] = "Hawk",
	[27044] = "Hawk",
	
	[61846] = "Hawk",
	[61847] = "Hawk",
	
	[12051] = "Evocate",
	[15473] = "Shadowform",
	[2645] = "GhostWolf",
	[5384] = "Feigning",
	[5215] = "Prowl",
}

Outfitter.cAuraIconSpecialID =
{
	["INV_Misc_Fork&Knife"] = "Dining",
}

-- Note that zone special outfits will be worn in the order
-- the are listed here, with later outfits being worn over
-- earlier outfits (when they're being applied at the same time)
-- This allows BG-specific outfits to take priority over the generic
-- BG outfit

Outfitter.cZoneSpecialIDs =
{
	"ArgentDawn",
	
	"City",
	"Battleground",
	"Arena",
	
	"AV",
	"AB",
	"WSG",
	"EotS",
	"SotA",
	"IoC",
	
	"BladesEdgeArena",
	"NagrandArena",
	"LordaeronArena",
}

Outfitter.cZoneSpecialIDMap =
{
	[Outfitter.LZ["Western Plaguelands"]] = {"ArgentDawn"},
	[Outfitter.LZ["Eastern Plaguelands"]] = {"ArgentDawn"},
	[Outfitter.LZ["Stratholme"]] = {"ArgentDawn"},
	[Outfitter.LZ["Scholomance"]] = {"ArgentDawn"},
	[Outfitter.LZ["Naxxramas"]] = {"Naxx"},
	[Outfitter.LZ["Alterac Valley"]] = {"Battleground", "AV"},
	[Outfitter.LZ["Arathi Basin"]] = {"Battleground", "AB"},
	[Outfitter.LZ["Warsong Gulch"]] = {"Battleground", "WSG"},
	[Outfitter.cSilverwingHold] = {"Battleground", "WSG"},
	[Outfitter.cWarsongLumberMill] = {"Battleground", "WSG"},
	[Outfitter.LZ["Eye of the Storm"]] = {"Battleground", "EotS"},
	[Outfitter.LZ["Strand of the Ancients"]] = {"Battleground", "SotA"},
	[Outfitter.LZ["Isle of Conquest"]] = {"Battleground", "IoC"},
	[Outfitter.LZ["Wintergrasp"]] = {"Battleground", "Wintergrasp"},
	[Outfitter.LZ["Dalaran Sewers"]] = {"Battleground", "Arena", "Sewers"},
	[Outfitter.LZ["The Ring of Valor"]] = {"Battleground", "Arena", "RingOfValor"},
	
	[Outfitter.LZ["Blade's Edge Arena"]] = {"Battleground", "BladesEdgeArena", "Arena"},
	[Outfitter.LZ["Nagrand Arena"]] = {"Battleground", "NagrandArena", "Arena"},
	[Outfitter.LZ["Ruins of Lordaeron"]] = {"Battleground", "LordaeronArena", "Arena"},
	
	[Outfitter.LZ["Ironforge"]] = {"City"},
	[Outfitter.LZ["Darnassus"]] = {"City"},
	[Outfitter.LZ["Stormwind"]] = {"City"},
	[Outfitter.LZ["Stormwind City"]] = {"City"},
	[Outfitter.LZ["Orgrimmar"]] = {"City"},
	[Outfitter.LZ["Thunder Bluff"]] = {"City"},
	[Outfitter.LZ["Undercity"]] = {"City"},
	[Outfitter.LZ["Silvermoon City"]] = {"City"},
	[Outfitter.LZ["The Exodar"]] = {"City"},
	[Outfitter.LZ["Shattrath City"]] = {"City"},
	[Outfitter.LZ["Dalaran"]] = {"City"},
}

-- As of patch 3.3 automated combat swaps aren't allowed.  I'm
-- leaving the code in but emptying the slot list in
-- case an acceptable workaround is discovered which would
-- make it useful again.

Outfitter.cCombatEquipmentSlots =
{
--[[
	MainHandSlot = true,
	SecondaryHandSlot = true,
	RangedSlot = true,
	AmmoSlot = true,
]]
}

Outfitter.InventoryCache = nil

Outfitter.cMaxDisplayedItems = 14

Outfitter.cPanelFrames =
{
	"OutfitterMainFrame",
	"OutfitterOptionsFrame",
	"OutfitterAboutFrame",
}

Outfitter.cShapeshiftTextureInfo =
{
	-- Warriors
	
	Ability_Warrior_OffensiveStance = {ID = "Battle"},
	Ability_Warrior_DefensiveStance = {ID = "Defensive"},
	Ability_Racial_Avatar = {ID = "Berserker"},
	
	-- Druids
	
	Ability_Racial_BearForm = {ID = "Bear", MaybeInCombat = true},
	Ability_Druid_CatForm = {ID = "Cat"},
	Ability_Druid_AquaticForm = {ID = "Aquatic"},
	Ability_Druid_TravelForm = {ID = "Travel"},
	Spell_Nature_ForceOfNature = {ID = "Moonkin"},
	Ability_Druid_TreeofLife = {ID = "Tree"},
	Ability_Druid_FlightForm = {ID = "Flight"},
	CasterForm = {ID = "Caster"}, -- this is a psuedo-form which is active when no other druid form is
	
	-- Rogues
	
	Ability_Stealth = {ID = "Stealth"},
	Spell_Nature_Invisibility = {ID = "Stealth"},
	
	-- Deathknight
	
	Spell_Deathknight_BloodPresence = {ID = "Blood"},
	Spell_Deathknight_FrostPresence = {ID = "Frost"},
	Spell_Deathknight_UnholyPresence = {ID = "Unholy"},
}

function Outfitter:ToggleOutfitterFrame()
	if self:IsOpen() then
		OutfitterFrame:Hide()
	else
		OutfitterFrame:Show()
	end
end

function Outfitter:IsOpen()
	return OutfitterFrame:IsVisible()
end

function Outfitter:OnLoad()
	for vEventID, _ in pairs(self.cInitializationEvents) do
		self.EventLib:RegisterEvent(vEventID, self.InitializationCheck, self)
	end
end

function Outfitter:OnShow()
	self.SetFrameLevel(OutfitterFrame, PaperDollFrame:GetFrameLevel() - 1)
	
	self:ShowPanel(1) -- Always switch to the main view when showing the window
end

function Outfitter:OnHide()
	self:ClearSelection()
	
	if self.QuickSlots then
		self.QuickSlots:Close()
	end
	
	if self.NameOutfitDialog:IsShown() then
		self.NameOutfitDialog:Cancel()
	end
	
	if self.RebuildOutfitDialog:IsShown() then
		self.RebuildOutfitDialog:Cancel()
	end
	
	OutfitterFrame:Hide()  -- This seems redundant, but the OnHide handler gets called
	                       -- in response to the parent being hidden (the character window)
	                       -- so calling Hide() on the frame here ensures that when the
	                       -- character window is hidden then Outfitter won't be displayed
	                       -- next time it's opened
end

function Outfitter:SchedulePlayerEnteringWorld()
	self.SchedulerLib:RescheduleTask(0.05, self.PlayerEnteringWorld, self)
end

function Outfitter:PlayerEnteringWorld()
	self.IsCasting = false
	self.IsChanneling = false
	
	self:BeginEquipmentUpdate()
	
	self:FlushInventoryCache()
	
	self:RegenEnabled()
	self:UpdateAuraStates()
	
	self:ScheduleUpdateZone()
	
	self:ResumeLoadScreenEvents()
	self:ScheduleSynch() -- Always sync on entering world
	
	self:SynchronizeEM()

	self:EndEquipmentUpdate()
end

function Outfitter:PlayerLeavingWorld()
	-- To improve load screen performance, suspend events which are
	-- fired repeatedly and rapidly during zoning
	
	self.Suspended = true
	
	self.EventLib:UnregisterEvent("BAG_UPDATE", self.BagUpdate, self)
	self.EventLib:UnregisterEvent("UNIT_INVENTORY_CHANGED", self.UnitInventoryChanged, self)
	self.EventLib:UnregisterEvent("UNIT_AURA", self.UnitAuraChanged, self)
	self.EventLib:UnregisterEvent("PLAYERBANKSLOTS_CHANGED", self.BankSlotsChanged, self)
end

function Outfitter:ResumeLoadScreenEvents()
	if self.Suspended then
		-- To improve load screen performance, suspend events which are
		-- fired repeatedly and rapidly during zoning
		
		self.Suspended = false

		self.EventLib:RegisterEvent("BAG_UPDATE", self.BagUpdate, self)
		self.EventLib:RegisterEvent("UNIT_INVENTORY_CHANGED", self.UnitInventoryChanged, self, true) -- Register as a blind event handler (no event id param)
		self.EventLib:RegisterEvent("UNIT_AURA", self.UnitAuraChanged, self)
		self.EventLib:RegisterEvent("PLAYERBANKSLOTS_CHANGED", self.BankSlotsChanged, self)
	end
end

function Outfitter:VariablesLoaded()
	self.Settings = gOutfitter_Settings
end

function Outfitter:BankSlotsChanged()
	self:ScheduleSynch()
end

function Outfitter:BagUpdate()
	self:ScheduleSynch()
end

Outfitter.OutfitEvents = {}

function Outfitter:RegisterOutfitEvent(pEvent, pFunction)
	local vHandlers = self.OutfitEvents[pEvent]
	
	if not vHandlers then
		vHandlers = {}
		self.OutfitEvents[pEvent] = vHandlers
	end
	
	table.insert(vHandlers, pFunction)
end

function Outfitter:UnregisterOutfitEvent(pEvent, pFunction)
	local vHandlers = self.OutfitEvents[pEvent]
	
	if not vHandlers then
		return
	end
	
	for vIndex, vFunction in ipairs(vHandlers) do
		if vFunction == pFunction then
			table.remove(vHandlers, vIndex)
			return
		end
	end
end

function Outfitter:DispatchOutfitEvent(pEvent, pParameter1, pParameter2)
	-- Don't send out events until we're initialized
	
	if not self.Initialized then
		return
	end
	
	-- Post a message
	
	local vHandlers = self.OutfitEvents[pEvent]
	
	if vHandlers then
		for _, vFunction in ipairs(vHandlers) do
			-- Call in protected mode so that if they fail it doesn't
			-- screw up Outfitter or other addons wishing to be notified
			
			local vSucceeded, vMessage = pcall(vFunction, pEvent, pParameter1, pParameter2)
			
			if vMessage then
				self:ErrorMessage("Error dispatching event "..pEvent)
				self:ErrorMessage(vMessage)
			end
		end
	end
	
	local vEventID
	
	if pEvent == "WEAR_OUTFIT" then
		vEventID = "OUTFIT_EQUIPPED"
	elseif pEvent == "UNWEAR_OUTFIT" then
		vEventID = "OUTFIT_UNEQUIPPED"
	end
	
	local vOutfits = self.OutfitScriptEvents[vEventID]
	
	if vOutfits then
		local vScriptContext = vOutfits[pParameter2]
		
		if vScriptContext then
			local vSucceeded, vMessage = pcall(vScriptContext.Function, vScriptContext, vEventID)
			
			if vMessage then
				self:ErrorMessage("Error dispatching outfit event %s", pEvent or "nil")
				self:ErrorMessage(vMessage)
			end
		end
	end

	-- Translate to the event ids for dispatch through the event system
	
	if pEvent == "WEAR_OUTFIT" then
		self.EventLib:DispatchEvent("WEAROUTFIT")
	elseif pEvent == "UNWEAR_OUTFIT" then
		self.EventLib:DispatchEvent("UNWEAROUTFIT")
	end

	-- Set the correct Helm and Cloak settings.
	
	self.OutfitStack:UpdateOutfitDisplay()
	
	--self.SchedulerLib:ScheduleUniqueTask(0.5, self.OutfitStack.UpdateOutfitDisplay, self.OutfitStack)
	self.SchedulerLib:ScheduleUniqueTask(0.1, self.UpdateCurrentOutfitIcon, self)
end

function Outfitter:UpdateCurrentOutfitIcon()
	local _, vOutfit = self:GetCurrentOutfitInfo()
	
	local vTexture = self.OutfitBar:GetOutfitTexture(vOutfit)
	
	SetPortraitToTexture(OutfitterMinimapButton.CurrentOutfitTexture, vTexture)
end

function Outfitter:BankFrameOpened()
	self.BankFrameIsOpen = true
	self:BankSlotsChanged()
end

function Outfitter:BankFrameClosed()
	self.BankFrameIsOpen = false
	self:BankSlotsChanged()
end

function Outfitter:RegenDisabled(pEvent)
	self.InCombat = true
	
	if self.OutfitBar then
		self.OutfitBar:AdjustAlpha()
	end
end

function Outfitter:RegenEnabled(pEvent)
	self:BeginEquipmentUpdate()
	self.InCombat = false
	self:EndEquipmentUpdate()
	
	if self.OutfitBar then
		self.OutfitBar:AdjustAlpha()
	end
end

function Outfitter:PlayerDead(pEvent)
	self.IsDead = true
end

function Outfitter:PlayerAlive(pEvent)
	self:BeginEquipmentUpdate()
	self.IsDead = false
	self:UpdateAuraStates()
	self:EndEquipmentUpdate()
end

function Outfitter:UnitHealthOrManaChanged(pUnitID)
	if pUnitID ~= "player" then
		return
	end
	
	self:BeginEquipmentUpdate()
	
	-- Check to see if the player is full while dining
	
	if self.SpecialState.Dining
	and self:PlayerIsFull() then
		self:SetSpecialOutfitEnabled("Dining", false)
	end
	
	-- If the mana drops, see if there was a recent spellcast
	
	local vPlayerMana = UnitPower("player")
	
	if vPlayerMana and (not self.PreviousManaLevel or vPlayerMana < self.PreviousManaLevel) then
		local vTime = GetTime()
		
		if self.SpellcastSentTime and vTime < self.SpellcastSentTime + 10 then
			self.SpellcastSentTime = nil
			
			-- Five second rule has begun
			
			if self.SpiritRegenEnabled then
				self.SpiritRegenEnabled = false
				self:SetSpecialOutfitEnabled("Spirit", false)
			end
			
			self.SchedulerLib:RescheduleTask(5.0, self.SpiritRegenTimer, self)
		end
	end
	
	self.PreviousManaLevel = vPlayerMana
	
	--
	
	if self.SpellcastSentMana then
		self.SchedulerLib:RescheduleTask(0.01, self.CheckSpellcastManaDrop, self)
	end
	
	--
	
	self:EndEquipmentUpdate()
end

function Outfitter:UnitSpellcastDebug(pEventID, pUnitID, pSpellName)
	if pUnitID ~= "player" then
		return
	end
	
	self:DebugMessage("UnitSpellcastDebug: %s %s %s", pEventID, pUnitID, pSpellName)
end

function Outfitter:UnitSpellcastSent(pEventID, pUnitID, pSpellName)
	if pUnitID ~= "player" then
		return
	end
	
	self.SpellcastSentTime = GetTime()
	
	if not self.IsCasting then
		self.IsCasting = true
	end
end

function Outfitter:UnitSpellcastChannelStart(pEventID, pUnitID, pSpellName)
	if pUnitID ~= "player" then
		return
	end
	
	self.IsChanneling = true
end

function Outfitter:UnitSpellcastChannelStop(pEventID, pUnitID, pSpellName)
	if pUnitID ~= "player" then
		return
	end
	
	if not self.IsChanneling then
		return
	end

	self:BeginEquipmentUpdate()
	self.IsChanneling = false
	self.IsCasting = false
	self:SetUpdateDelay(GetTime(), 0.5) -- Need a short delay because the 'in combat' message doesn't come until after the spellcast is done
	self:EndEquipmentUpdate()
end

function Outfitter:UnitSpellcastStop(pEventID, pUnitID, pSpellName)
	if pUnitID ~= "player" then
		return
	end
	
	if not self.IsCasting then
		return
	end
	
	self:BeginEquipmentUpdate()
	self.IsCasting = false
	self:SetUpdateDelay(GetTime(), 0.5) -- Need a short delay because the 'in combat' message doesn't come until after the spellcast is done
	self:EndEquipmentUpdate()
end

function Outfitter:SpiritRegenTimer()
	self.SpiritRegenEnabled = true
	self:SetSpecialOutfitEnabled("Spirit", true)
end

function Outfitter:PlayerIsFull()
	if UnitHealth("player") < (UnitHealthMax("player") * 0.85) then
		return false
	end

	if UnitPowerType("player") ~= 0 then
		return true
	end
	
	return UnitPower("player") > (UnitPowerMax("player") * 0.85)
end

function Outfitter:UnitInventoryChanged(pUnitID)
	if pUnitID == "player" then
		self:ScheduleSynch()
	end
end

function Outfitter:InventoryChanged()
	self.DisplayIsDirty = true -- Update the list so the checkboxes reflect the current state
	
	local vNewItemsOutfit, vCurrentOutfit = self:GetNewItemsOutfit(self.CurrentOutfit)
	
	if vNewItemsOutfit then
		-- Save the new outfit
		
		self.CurrentOutfit = vCurrentOutfit
		
		-- Update the selected outfit or temporary outfit
		
		self:SubtractOutfit(vNewItemsOutfit, self.ExpectedOutfit)
		
		if next(vNewItemsOutfit.Items) then
			if self.SelectedOutfit then
				self:UpdateOutfitFromInventory(self.SelectedOutfit, vNewItemsOutfit)
			else
				self:UpdateTemporaryOutfit(vNewItemsOutfit)
			end
		end
		
		if self.QuickSlots then
			self.QuickSlots:InventoryChanged(vNewItemsOutfit:IsAmmoOnly())
		end
	end
	
	-- Fire off an event if the current outfit matches the expected outfit
	
	if not self.EquippedNeedsUpdate
	and self:OutfitItemsAreSame(self.CurrentOutfit, self.ExpectedOutfit, nil, true) then
		if self.Debug.TemporaryItems then
			self:DebugMessage("Swap complete")
		end
		
		self.EventLib:DispatchEvent("OUTFITTER_SWAP_COMPLETE")
	elseif self.Debug.TemporaryItems then
		self:DebugMessage("Swap not complete")
		self:DebugTable(self.CurrentOutfit, "CurrentOutfit", 2)
		self:DebugTable(self.ExpectedOutfit, "ExpectedOutfit", 2)
	end
	
	--
	
	self:Update(true)
end

function Outfitter:ExecuteCommand(pCommand)
	local vCommands =
	{
		wear = {useOutfit = true, func = self.WearOutfitNow},
		unwear = {useOutfit = true, func = self.RemoveOutfitNow},
		toggle = {useOutfit = true, func = self.ToggleOutfitNow},
		reset = {func = self.AskReset},
		
		deposit = {useOutfit = true, func = self.DepositOutfit},
		depositunique = {useOutfit = true, func = self.DepositOutfitUnique},
		depositothers = {useOutfit = true, func = self.DepositOtherOutfits},
		withdraw = {useOutfit = true, func = self.WithdrawOutfit},
		withdrawothers = {useOutfit = true, func = self.WithdrawOtherOutfits},
		
		update = {useOutfit = true, func = self.SetOutfitToCurrent},
		updatetitle = {func = function () Outfitter.OutfitStack:UpdateOutfitDisplay() end},
		
		summary = {func = self.OutfitSummary},
		rating = {func = self.RatingSummary},
		sortbags = {func = self.SortBags},
		iteminfo = {func = self.ShowLinkInfo},
		itemstats = {func = self.ShowLinkStats},
		
		missing = {func = self.ShowMissingItems},
		
		sound = {func = self.SetSoundOption},
		help = {func = self.ShowCommandHelp},
		
		disable = {func = self.DisableAutoChanges},
		enable = {func = self.EnableAutoChanges},
		
		errors = {func = self.SetErrorsOption},
		daxdax = {func = self.SetErrorsOption},
	}
	
	-- Evaluate options if the command uses them
	
	local vCommand
	
	if string.find(pCommand, "|h") then -- Commands which use item links don't appear to parse correctly
		vCommand = pCommand
	else
		vCommand = SecureCmdOptionParse(pCommand)
	end
	
	if not vCommand then
		return
	end
	
	--
	
	local vStartIndex, vEndIndex, vCommand, vParameter = string.find(vCommand, "(%w+) ?(.*)")
	
	if not vCommand then
		self:ShowCommandHelp()
		return
	end
	
	vCommand = strlower(vCommand)
	
	local vCommandInfo = vCommands[vCommand]
	
	if not vCommandInfo then
		self:ShowCommandHelp()
		self:ErrorMessage("Unknown command %s", vCommand)
		return
	end
	
	local vOutfit = nil
	local vCategoryID = nil
	
	if vCommandInfo.useOutfit then
		if not vParameter then
			self:ErrorMessage("Expected outfit name for "..vCommand.." command")
			return
		end
		
		vOutfit, vCategoryID = self:FindOutfitByName(vParameter)
		
		if not vOutfit then
			self:ErrorMessage("Couldn't find outfit named "..vParameter)
			return
		end
		
		Outfitter.HasHWEvent = true
		vCommandInfo.func(self, vOutfit)
		Outfitter.HasHWEvent = false
	else
		vCommandInfo.func(self, vParameter)
	end
end

function Outfitter:DisableAutoChanges()
	self:SetAutoSwitch(false)
	self:NoteMessage(self.cAutoChangesDisabled)
end

function Outfitter:EnableAutoChanges()
	self:SetAutoSwitch(true)
	self:NoteMessage(self.cAutoChangesEnabled)
end

function Outfitter:ShowCommandHelp()
	self:NoteMessage(HIGHLIGHT_FONT_COLOR_CODE.."/outfitter wear outfitName"..NORMAL_FONT_COLOR_CODE..": Wear an outfit")
	self:NoteMessage(HIGHLIGHT_FONT_COLOR_CODE.."/outfitter unwear outfitName"..NORMAL_FONT_COLOR_CODE..": Remove an outfit")
	self:NoteMessage(HIGHLIGHT_FONT_COLOR_CODE.."/outfitter toggle outfitName"..NORMAL_FONT_COLOR_CODE..": Wears or removes an outfit")
	self:NoteMessage(HIGHLIGHT_FONT_COLOR_CODE.."/outfitter reset"..NORMAL_FONT_COLOR_CODE..": Resets Outfitter, restoring default settings and outfits")
	self:NoteMessage("")
	self:NoteMessage(HIGHLIGHT_FONT_COLOR_CODE.."/outfitter deposit outfitName"..NORMAL_FONT_COLOR_CODE..": Deposits an outfit to the bank")
	self:NoteMessage(HIGHLIGHT_FONT_COLOR_CODE.."/outfitter depositunique outfitName"..NORMAL_FONT_COLOR_CODE..": Deposits an outfit to the bank, except for items used by other outfits")
	self:NoteMessage(HIGHLIGHT_FONT_COLOR_CODE.."/outfitter depositothers outfitName"..NORMAL_FONT_COLOR_CODE..": Deposits all outfits except one to the bank")
	self:NoteMessage(HIGHLIGHT_FONT_COLOR_CODE.."/outfitter withdraw outfitName"..NORMAL_FONT_COLOR_CODE..": Withdraws an outfit from the bank")
	self:NoteMessage(HIGHLIGHT_FONT_COLOR_CODE.."/outfitter withdrawothers outfitName"..NORMAL_FONT_COLOR_CODE..": Withdraws all outfits except one from the bank")
	self:NoteMessage("")
	self:NoteMessage(HIGHLIGHT_FONT_COLOR_CODE.."/outfitter update outfitName"..NORMAL_FONT_COLOR_CODE..": Updates the outfit with currently equipped items")
	self:NoteMessage(HIGHLIGHT_FONT_COLOR_CODE.."/outfitter updatetitle"..NORMAL_FONT_COLOR_CODE..": Refreshes the current player title based on equipped items")
	self:NoteMessage("")
	self:NoteMessage(HIGHLIGHT_FONT_COLOR_CODE.."/outfitter sound [on|off]"..NORMAL_FONT_COLOR_CODE..": Turns equipment sound effects off during Outfitter's gear changes")
	self:NoteMessage(HIGHLIGHT_FONT_COLOR_CODE.."/outfitter disable"..NORMAL_FONT_COLOR_CODE..": Prevents all scripts from running")
	self:NoteMessage(HIGHLIGHT_FONT_COLOR_CODE.."/outfitter enable"..NORMAL_FONT_COLOR_CODE..": Allows enabled scripts to run")
	self:NoteMessage(HIGHLIGHT_FONT_COLOR_CODE.."/outfitter missing"..NORMAL_FONT_COLOR_CODE..": Generates a list of items which are in your outfits but can't be found")
	self:NoteMessage(HIGHLIGHT_FONT_COLOR_CODE.."/outfitter errors [on|off]"..NORMAL_FONT_COLOR_CODE..": Enables/disables missing item messages during gear changes")
end

function Outfitter:UnequipItemByName(pItemName)
	local vInventoryID = tonumber(pItemName)
	
	if pItemName ~= tostring(vInventoryID) then
		local vLowerItemName = pItemName:lower()
		
		-- Search the inventory for a matching item name
		
		vInventoryID = nil
		
		for _, vSlotID in ipairs(self.cSlotIDs) do
			local vItemCode,
				  vItemEnchantCode,
				  vItemJewelCode1,
				  vItemJewelCode2,
				  vItemJewelCode3,
				  vItemJewelCode4,
				  vItemSubCode,
				  vItemUniqueID,
				  vItemUnknownCode1,
				  vItemName = self:GetSlotIDLinkInfo(vSlotID)
			
			if vItemName and vItemName:lower() == vLowerItemName then
				vInventoryID = vSlotID
			end
		end
		
		if not vInventoryID then
			self:ErrorMessage("Couldn't find an item named "..pItemName)
		end
	end
	
	local vEmptyBagSlot = self:GetEmptyBagSlot(NUM_BAG_SLOTS, 1)
	
	if not vEmptyBagSlot then
		self:ErrorMessage("Couldn't unequip "..pItemName.." because all bags are full")
		return
	end
	
	PickupInventoryItem(vInventoryID)
	PickupContainerItem(vEmptyBagSlot.BagIndex, vEmptyBagSlot.BagSlotIndex)
end

function Outfitter:AskRebuildOutfit(pOutfit)
	self.OutfitToRebuild = pOutfit
	
	StaticPopup_Show("OUTFITTER_CONFIRM_REBUILD", self.OutfitToRebuild.Name)
end

function Outfitter:AskSetCurrent(pOutfit)
	self.OutfitToRebuild = pOutfit
	
	StaticPopup_Show("OUTFITTER_CONFIRM_SET_CURRENT", self.OutfitToRebuild.Name)
end

function Outfitter:RebuildOutfit(pOutfit)
	if not pOutfit then
		return
	end
	
	local vStatConfig = pOutfit.StatConfig
	
	if not vStatConfig and pOutfit.StatID then
		vStatConfig = {{StatID = pOutfit.StatID}}
	end
	
	local vOutfit = self:GenerateSmartOutfit(
		pOutfit.Name,
		vStatConfig,
		self:GetInventoryCache(),
		false,
		function (pNewOutfit)
			local vNewItems = pNewOutfit:GetItems()
			
			if pOutfit:IsComplete(UnitHasRelicSlot("player")) then
				local vOldItems = pOutfit:GetItems()
				
				for vItemSlot, vOldItem in pairs(vOldItems) do
					if not vNewItems[vItemSlot] then
						vNewItems[vItemSlot] = vOldItem
					end
				end
			end
			
			pOutfit:SetItems(vNewItems)
			self:OutfitSettingsChanged(pOutfit)
			self:WearOutfit(pOutfit)
			self:Update(true)
		end)
	
	if vOutfit then
		local vNewItems = vOutfit:GetItems()
		
		if pOutfit:IsComplete(UnitHasRelicSlot("player")) then
			local vOldItems = pOutfit:GetItems()
			
			for vItemSlot, vOldItem in pairs(vOldItems) do
				if not vNewItems[vItemSlot] then
					vNewItems[vItemSlot] = vOldItem
				end
			end
		end
		pOutfit:SetItems(vNewItems)
		self:OutfitSettingsChanged(pOutfit)
		self:WearOutfit(pOutfit)
		self:Update(true)
	end
end

function Outfitter:SetOutfitToCurrent(pOutfit)
	if not pOutfit then
		return
	end
	
	pOutfit:SetToCurrentInventory()
	
	self:OutfitSettingsChanged(pOutfit)
	self:WearOutfit(pOutfit)
	
	self:Update(true)
end

function Outfitter:AskDeleteOutfit(pOutfit)
	gOutfitter_OutfitToDelete = pOutfit
	StaticPopup_Show("OUTFITTER_CONFIRM_DELETE", gOutfitter_OutfitToDelete.Name)
end

function Outfitter:DeleteSelectedOutfit()
	if not gOutfitter_OutfitToDelete then
		return
	end
	
	self:DeleteOutfit(gOutfitter_OutfitToDelete)
	
	self:Update(true)
end

function Outfitter:TalentsChanged()
	if self.PlayerClass == "WARRIOR" then
		local vNumTalents = GetNumTalents(2)
		
		for vTalentIndex = 1, vNumTalents do
			local vTalentName, vIconPath, vTier, vColumn, vCurrentRank, vMaxRank, vIsExceptional, vMeetsPrereq = GetTalentInfo(2, vTalentIndex)
			
			if vIconPath == "Interface\\Icons\\Ability_Warrior_TitansGrip" then
				--self:TestMessage("%s has %s points", vTalentName, vCurrentRank)
				
				self.CanDualWield2H = vCurrentRank == 1
				break
			end
		end
	else
		self.CanDualWield2H = false
	end
end

function Outfitter:SetScript(pOutfit, pScript)
	self:DeactivateScript(pOutfit)
	
	if pScript == "" then
		pScript = nil
	end
	
	pOutfit.Script = pScript
	pOutfit.ScriptID = nil
	
	self:OutfitSettingsChanged(self.SelectedOutfit)
	self:ActivateScript(pOutfit)
end

function Outfitter:SetScriptID(pOutfit, pScriptID)
	self:DeactivateScript(pOutfit)
	
	if pScriptID == "" then
		pScriptID = nil
	end
	
	pOutfit.Script = nil
	pOutfit.ScriptID = pScriptID
	
	self:OutfitSettingsChanged(self.SelectedOutfit)
	self:ActivateScript(pOutfit)
end

function Outfitter:GetScript(pOutfit)
	if pOutfit.ScriptID then
		local vPresetScript = self:GetPresetScriptByID(pOutfit.ScriptID)
		
		if vPresetScript then
			local vScript = vPresetScript.Script:gsub("([\r\t])", {["\r"] = "", ["\t"] = "    "})
			
			return vScript, pOutfit.ScriptID
		end
	else
		return pOutfit.Script
	end
end

function Outfitter:ShowPanel(pPanelIndex)
	self:CancelDialogs() -- Force any dialogs to close if they're open
	
	if self.CurrentPanel > 0
	and self.CurrentPanel ~= pPanelIndex then
		self:HidePanel(self.CurrentPanel)
	end
	
	-- NOTE: Don't check for redundant calls since this function
	-- will be called to reset the field values as well as to 
	-- actually show the panel when it's hidden
	
	self.CurrentPanel = pPanelIndex
	
	local vPanelFrame = _G[self.cPanelFrames[pPanelIndex]]
	
	vPanelFrame:Show()
	
	PanelTemplates_SetTab(OutfitterFrame, pPanelIndex)
	
	-- Update the control values
	
	if pPanelIndex == 1 then
		-- Main panel
		
	elseif pPanelIndex == 2 then
		-- Options panel
		
	elseif pPanelIndex == 3 then
		-- About panel
		
		if not self.AboutView then
			self.AboutView = self:New(self._AboutView)
		end
	else
		self:ErrorMessage("Unknown index (%d) in ShowPanel()", pPanelIndex)
	end
	
	self:Update(false)
end

function Outfitter:HidePanel(pPanelIndex)
	if self.CurrentPanel ~= pPanelIndex then
		return
	end
	
	_G[self.cPanelFrames[pPanelIndex]]:Hide()
	self.CurrentPanel = 0
end

function Outfitter:CancelDialogs()
end

function Outfitter:AddDividerMenuItem()
	local vInfo = UIDropDownMenu_CreateInfo()
	
	vInfo.text = " "
	vInfo.notCheckable = true
	vInfo.notClickable = true
	
	UIDropDownMenu_AddButton(vInfo, UIDROPDOWNMENU_MENU_LEVEL)
end

function Outfitter:AddCategoryMenuItem(pName)
	local vInfo = UIDropDownMenu_CreateInfo()
	
	vInfo.text = pName
	vInfo.notCheckable = true
	vInfo.notClickable = true
	
	UIDropDownMenu_AddButton(vInfo, UIDROPDOWNMENU_MENU_LEVEL)
end

function Outfitter:AddMenuItem(pFrame, pName, pValue, pChecked, pLevel, pColorCode, pDisabled, pAdditionalOptions)
	if not pColorCode then
		pColorCode = NORMAL_FONT_COLOR_CODE
	elseif type(pColorCode) ~= "string" then
		self:ErrorMessage("AddMenuItem: pColorCode is not a string")
		self:DebugStack()
		pColorCode = nil
	end
	
	local vInfo = UIDropDownMenu_CreateInfo()

	vInfo.text = pName
	vInfo.checked = pChecked
	vInfo.arg1 = pFrame
	vInfo.arg2 = pValue
	vInfo.value = pValue
	vInfo.func = self.DropDown_OnClick
	vInfo.colorCode = pColorCode
	vInfo.disabled = pDisabled
	
	if pAdditionalOptions then
		for vKey, vValue in pairs(pAdditionalOptions) do
			vInfo[vKey] = vValue
		end
	end
	
	UIDropDownMenu_AddButton(vInfo, pLevel or UIDROPDOWNMENU_MENU_LEVEL)
end

function Outfitter:AddSubmenuItem(pFrame, pName, pValue, pDisabled, pAdditionalOptions)
	local vInfo = UIDropDownMenu_CreateInfo()

	vInfo.text = pName
	vInfo.hasArrow = 1
	vInfo.arg1 = pFrame
	vInfo.arg2 = pValue
	vInfo.value = pValue
	vInfo.colorCode = NORMAL_FONT_COLOR_CODE
	vInfo.disabled = pDisabled
	
	if pAdditionalOptions then
		for vKey, vValue in pairs(pAdditionalOptions) do
			vInfo[vKey] = vValue
		end
	end
	
	UIDropDownMenu_AddButton(vInfo, UIDROPDOWNMENU_MENU_LEVEL)
end

function Outfitter:InitializeOutfitMenu(pFrame, pOutfit)
	if not pOutfit then
		return
	end
	
	if UIDROPDOWNMENU_MENU_LEVEL == 1 then
		self:AddCategoryMenuItem(pOutfit:GetName())
		
		-- General
		
		self:AddMenuItem(pFrame, PET_RENAME, "RENAME")
		self:AddSubmenuItem(pFrame, self.cKeyBinding, "BINDING")
		self:AddSubmenuItem(pFrame, self.cOutfitDisplay, "DISPLAY")
		self:AddSubmenuItem(pFrame, self.cBankCategoryTitle, "BANKING")
		if pOutfit.CategoryID ~= "Complete" then
			self:AddMenuItem(pFrame, self.cUnequipOthers, "UNEQUIP_OTHERS", pOutfit.UnequipOthers)
		end
		self:AddMenuItem(pFrame, DELETE, "DELETE")
		
		-- Rebuild
		
		self:AddCategoryMenuItem(self.cRebuild)
		
		self:AddMenuItem(pFrame, self.cSetCurrentItems, "SET_CURRENT")
		
		local vStatName
		
		if pOutfit.StatConfig then
			vStatName = self:GetStatConfigName(pOutfit.StatConfig)
		elseif pOutfit.StatID then
			vStatName = self:GetStatIDName(pOutfit.StatID)
		end
		
		if vStatName then
			self:AddMenuItem(pFrame, format(self.cRebuildOutfitFormat, vStatName), "REBUILD")
		end
		
		self:AddMenuItem(pFrame, self.cRebuildFor, "REBUILD_FOR")
		
		-- Automation
		
		self:AddCategoryMenuItem(self.cAutomation)
		
		local vPresetScript = self:GetPresetScriptByID(pOutfit.ScriptID)
		local vScriptName
		
		if vPresetScript then
			vScriptName = vPresetScript.Name
		elseif pOutfit.Script then
			vScriptName = self.cCustomScript
		else
			vScriptName = nil
		end
		
		self:AddSubmenuItem(pFrame, string.format(self.cScriptFormat, vScriptName or self.cNoScript), "SCRIPT")
		self:AddMenuItem(pFrame, self.cScriptSettings, "SCRIPT_SETTINGS", nil, UIDROPDOWNMENU_MENU_LEVEL, nil, vScriptName == nil)
		self:AddMenuItem(pFrame, self.cDisableScript, "DISABLE", pOutfit.Disabled, UIDROPDOWNMENU_MENU_LEVEL, nil, vScriptName == nil)
		self:AddMenuItem(pFrame, self.cDisableOutfitInCombat, "COMBATDISABLE", pOutfit.CombatDisabled, UIDROPDOWNMENU_MENU_LEVEL, nil, vScriptName == nil)
		
		-- Outfit bar
		
		if self.OutfitBar then
			self:AddCategoryMenuItem(self.cOutfitBar)
			self:AddMenuItem(pFrame, self.cShowInOutfitBar, "OUTFITBAR_SHOW", self.OutfitBar:IsOutfitShown(pOutfit), UIDROPDOWNMENU_MENU_LEVEL)
			self:AddMenuItem(pFrame, self.cChangeIcon, "OUTFITBAR_CHOOSEICON", nil, UIDROPDOWNMENU_MENU_LEVEL)
		end
		
	elseif UIDROPDOWNMENU_MENU_LEVEL == 2 then
		if UIDROPDOWNMENU_MENU_VALUE == "BANKING" then
			self:AddMenuItem(pFrame, self.cDepositToBank, "DEPOSIT", nil, UIDROPDOWNMENU_MENU_LEVEL, nil, not self.BankFrameIsOpen)
			self:AddMenuItem(pFrame, self.cDepositUniqueToBank, "DEPOSITUNIQUE", nil, UIDROPDOWNMENU_MENU_LEVEL, nil, not self.BankFrameIsOpen)
			self:AddMenuItem(pFrame, self.cWithdrawFromBank, "WITHDRAW", nil, UIDROPDOWNMENU_MENU_LEVEL, nil, not self.BankFrameIsOpen)
			self:AddDividerMenuItem()
			self:AddMenuItem(pFrame, self.cDepositOthersToBank, "DEPOSITOTHERS", nil, UIDROPDOWNMENU_MENU_LEVEL, nil, not self.BankFrameIsOpen)
			self:AddMenuItem(pFrame, self.cWithdrawOthersFromBank, "WITHDRAWOTHERS", nil, UIDROPDOWNMENU_MENU_LEVEL, nil, not self.BankFrameIsOpen)
		elseif UIDROPDOWNMENU_MENU_VALUE == "BINDING" then
			self:AddMenuItem(pFrame, self.cNone, "BINDING_NONE", not pOutfit.BindingIndex, UIDROPDOWNMENU_MENU_LEVEL)
			
			for vIndex = 1, 10 do
				self:AddMenuItem(pFrame, _G["BINDING_NAME_OUTFITTER_OUTFIT"..vIndex], "BINDING_"..vIndex, pOutfit.BindingIndex == vIndex, UIDROPDOWNMENU_MENU_LEVEL)
			end
		elseif UIDROPDOWNMENU_MENU_VALUE == "DISPLAY" then
			self:AddCategoryMenuItem(self.cHelm)
			self:AddMenuItem(pFrame, self.cDontChange, "IGNOREHELM", pOutfit.ShowHelm == nil, UIDROPDOWNMENU_MENU_LEVEL)
			self:AddMenuItem(pFrame, self.cShow, "SHOWHELM", pOutfit.ShowHelm == true, UIDROPDOWNMENU_MENU_LEVEL)
			self:AddMenuItem(pFrame, self.cHide, "HIDEHELM", pOutfit.ShowHelm == false, UIDROPDOWNMENU_MENU_LEVEL)
			
			self:AddCategoryMenuItem(self.cCloak)
			self:AddMenuItem(pFrame, self.cDontChange, "IGNORECLOAK", pOutfit.ShowCloak == nil, UIDROPDOWNMENU_MENU_LEVEL)
			self:AddMenuItem(pFrame, self.cShow, "SHOWCLOAK", pOutfit.ShowCloak == true, UIDROPDOWNMENU_MENU_LEVEL)
			self:AddMenuItem(pFrame, self.cHide, "HIDECLOAK", pOutfit.ShowCloak == false, UIDROPDOWNMENU_MENU_LEVEL)
			
			self:AddCategoryMenuItem(self.cPlayerTitle)
			
			self:AddMenuItem(pFrame, self.cDontChange, "IGNORETITLE", pOutfit.ShowTitleID == nil, UIDROPDOWNMENU_MENU_LEVEL)
			self:AddMenuItem(pFrame, NONE, "TITLE_-1", 0 == pOutfit.ShowTitleID, UIDROPDOWNMENU_MENU_LEVEL)
			
			local vNumTitles = GetNumTitles()
			local vNumVisibleTitles = 0
			
			for vTitleID = 1, vNumTitles do
				if IsTitleKnown(vTitleID) ~= 0 then
					vNumVisibleTitles = vNumVisibleTitles + 1
					
					if vNumVisibleTitles > self.MaxSimpleTitles then
						self:AddSubmenuItem(pFrame, self.cMore, "TITLE")
						break
					end
					
					self:AddMenuItem(pFrame, GetTitleName(vTitleID), "TITLE_"..vTitleID, vTitleID == pOutfit.ShowTitleID, UIDROPDOWNMENU_MENU_LEVEL)
				end
			end
		elseif UIDROPDOWNMENU_MENU_VALUE == "SCRIPT" then
			self:AddMenuItem(pFrame, self.cNoScript, "PRESET_NONE", pOutfit.ScriptID == nil and self:GetScript(pOutfit) == nil, UIDROPDOWNMENU_MENU_LEVEL)
			self:AddMenuItem(pFrame, self.cEditScriptEllide, "EDIT_SCRIPT", pOutfit.ScriptID == nil and self:GetScript(pOutfit) ~= nil, UIDROPDOWNMENU_MENU_LEVEL)
			
			local vCategory
			
			for _, vPresetScript in ipairs(self.PresetScripts) do
				if not vPresetScript.Class
				or vPresetScript.Class == self.PlayerClass then
					-- Start a new category if it's changing
					
					local vNewCategory = vPresetScript.Category or vPresetScript.Class or "GENERAL"
					
					if vCategory ~= vNewCategory then
						vCategory = vNewCategory
						self:AddSubmenuItem(pFrame, self.cScriptCategoryName[vCategory] or self.cClassName[vCategory], vCategory)
					end
				end -- if
			end -- for
		end -- elseif
	elseif UIDROPDOWNMENU_MENU_LEVEL == 3 then
		if UIDROPDOWNMENU_MENU_VALUE == "TITLE" then
			local vNumTitles = GetNumTitles()
			local vNumVisibleTitles = 0
			
			for vTitleID = 1, vNumTitles do
				if IsTitleKnown(vTitleID) ~= 0 then
					vNumVisibleTitles = vNumVisibleTitles + 1
					
					if vNumVisibleTitles > self.MaxSimpleTitles then
						self:AddMenuItem(pFrame, GetTitleName(vTitleID), "TITLE_"..vTitleID, vTitleID == pOutfit.ShowTitleID, UIDROPDOWNMENU_MENU_LEVEL)
					end
				end
			end
		elseif type(UIDROPDOWNMENU_MENU_VALUE) == "string" and UIDROPDOWNMENU_MENU_VALUE:sub(1, 8) == "REBUILD_" then
			local vCategory = self:GetCategoryByID(UIDROPDOWNMENU_MENU_VALUE:sub(9))
			
			if vCategory then
				local vNumStats = vCategory:GetNumStats()
				
				for vStatIndex = 1, vNumStats do
					local vStat = vCategory:GetIndexedStat(vStatIndex)
					self:AddMenuItem(pFrame, vStat.Name, "REBUILD_STAT_"..vStat.ID)
				end
			end
		else
			for _, vPresetScript in ipairs(self.PresetScripts) do
				if not vPresetScript.Class
				or vPresetScript.Class == self.PlayerClass then
					local vCategory = vPresetScript.Category or vPresetScript.Class or "GENERAL"
					
					if vCategory == UIDROPDOWNMENU_MENU_VALUE then
						local vName = vPresetScript.Name
						local vScriptFields = self:ParseScriptFields(vPresetScript.Script)
						
						if vScriptFields.Inputs ~= nil and #vScriptFields.Inputs ~= 0 then
							vName = vName.."..."
						end
						
						self:AddMenuItem(
								pFrame,
								vName,
								"PRESET_"..vPresetScript.ID,
								pOutfit.ScriptID == vPresetScript.ID,
								nil, -- Level
								nil, -- Color
								nil, -- Disabled
								{tooltipTitle = vName, tooltipText = vScriptFields.Description})
					end -- if
				end -- if
			end -- for
		end -- else
	end -- elseif
end

function Outfitter.ItemDropDown_Initialize(pFrame)
	local vItem = pFrame:GetParent():GetParent()
	local vOutfit = Outfitter:GetOutfitFromListItem(vItem)
	
	Outfitter:InitializeOutfitMenu(pFrame, vOutfit)
	
	pFrame:SetHeight(pFrame.SavedHeight)
end

function Outfitter:SetAutoSwitch(pAutoSwitch)
	local vDisableAutoSwitch = not pAutoSwitch
	
	if self.Settings.Options.DisableAutoSwitch == vDisableAutoSwitch then
		return
	end
	
	self.Settings.Options.DisableAutoSwitch = vDisableAutoSwitch
	
	if pAutoSwitch then
		self:ActivateAllScripts()
	else
		self:DeactivateAllScripts()
	end
	
	self.DisplayIsDirty = true
	self:Update(false)
end

function Outfitter:SetShowTooltipInfo(pShowInfo)
	self.Settings.Options.DisableToolTipInfo = not pShowInfo
	self:Update(false)
end

function Outfitter:SetShowItemComparisons(pShowComparisons)
	self.Settings.Options.DisableItemComparisons = not pShowComparisons
	
	if pShowComparisons and not self.ExtendedCompareTooltip then
		self.ExtendedCompareTooltip = self:New(self._ExtendedCompareTooltip)
	end
end

function Outfitter:SetShowMinimapButton(pShowButton)
	self.Settings.Options.HideMinimapButton = not pShowButton
	
	if self.Settings.Options.HideMinimapButton then
		OutfitterMinimapButton:Hide()
	else
		OutfitterMinimapButton:Show()
	end
	
	self:Update(false)
end

function Outfitter:SetShowHotkeyMessages(pShowHotkeyMessages)
	self.Settings.Options.DisableHotkeyMessages = not pShowHotkeyMessages
	
	self:Update(false)
end

function Outfitter.UIDropDownMenu_SetAnchor(...) UIDropDownMenu_SetAnchor(...) end

function Outfitter.MinimapDropDown_OnLoad(self)
	Outfitter.UIDropDownMenu_SetAnchor(self, 3, -7, "TOPRIGHT", self:GetName(), "TOPLEFT")
	Outfitter:DropDownMenu_Initialize(self, Outfitter.MinimapDropDown_Initialize)
	--self:Refresh() -- Don't refresh on menus which don't have a text portion
	
	if not Outfitter.RegisteredMinimapEvents then
		Outfitter:RegisterOutfitEvent("WEAR_OUTFIT", Outfitter.MinimapDropDown_OutfitEvent)
		Outfitter:RegisterOutfitEvent("UNWEAR_OUTFIT", Outfitter.MinimapDropDown_OutfitEvent)
		
		Outfitter.RegisteredMinimapEvents = true
	end
end

function Outfitter.MinimapDropDown_OutfitEvent(pEvent, pParameter1, pParameter2)
	Outfitter.SchedulerLib:ScheduleUniqueTask(0.1, Outfitter.MinimapDropDown_OutfitEvent2)
end

function Outfitter.MinimapDropDown_OutfitEvent2()
	if UIDROPDOWNMENU_OPEN_MENU ~= OutfitterMinimapButton then
		return
	end
	
	Outfitter:DropDownMenu_Initialize(OutfitterMinimapButton, Outfitter.MinimapDropDown_Initialize)
end

function Outfitter.MinimapDropDown_AdjustScreenPosition(pMenu)
	local vListFrame = DropDownList1
	
	if not vListFrame:IsVisible() then
		return
	end
	
	local vCenterX, vCenterY = pMenu:GetCenter()
	local vScreenWidth, vScreenHeight = GetScreenWidth(), GetScreenHeight()
	
	local vAnchor
	local vOffsetX, vOffsetY
	
	if vCenterY < vScreenHeight / 2 then
		vAnchor = "BOTTOM"
		vOffsetY = -8
	else
		vAnchor = "TOP"
		vOffsetY = -17
	end
	
	if vCenterX < vScreenWidth / 2 then
		vAnchor = vAnchor.."LEFT"
		vOffsetX = 21
	else
		vAnchor = vAnchor.."RIGHT"
		vOffsetX = 3
	end
	
	vListFrame:ClearAllPoints()
	vListFrame:SetPoint(vAnchor, pMenu.relativeTo, pMenu.relativePoint, vOffsetX, vOffsetY)
end

function Outfitter:OutfitIsVisible(pOutfit)
	return not pOutfit.Disabled
	   and not pOutfit:IsEmpty()
	   and (not pOutfit.OutfitBar or not pOutfit.OutfitBar.Hide)
end

function Outfitter:HasVisibleOutfits(pOutfits)
	if not pOutfits then
		return false
	end
	
	for vIndex, vOutfit in pairs(pOutfits) do
		if self:OutfitIsVisible(vOutfit) then	
			return true
		end
	end
	
	return false
end

function Outfitter.MinimapDropDown_Initialize(pFrame)
	-- Just return if not initialized yet
	
	if not Outfitter.Initialized then
		return
	end
	
	--
	
	Outfitter:AddCategoryMenuItem(Outfitter.cTitleVersion)
	Outfitter:AddMenuItem(pFrame, Outfitter.cOpenOutfitter, 0)
	Outfitter:AddMenuItem(pFrame, Outfitter.cAutoSwitch, -1, Outfitter.Settings.Options.DisableAutoSwitch)
	
	Outfitter.MinimapDropDown_InitializeOutfitList(pFrame)
end

function Outfitter:GetCategoryOrder()
	return self.cCategoryOrder
end

function Outfitter:GetOutfitsByCategoryID(pCategoryID)
	return self.Settings.Outfits[pCategoryID]
end

function Outfitter.MinimapDropDown_InitializeOutfitList(pFrame)
	-- Just return if not initialized yet
	
	if not Outfitter.Initialized then
		return
	end
	
	--
	
	local vInventoryCache = Outfitter:GetInventoryCache()
	local vCategoryOrder = Outfitter:GetCategoryOrder()
		
	for vCategoryIndex, vCategoryID in ipairs(vCategoryOrder) do
		local vCategoryName = Outfitter["c"..vCategoryID.."Outfits"]
		local vOutfits = Outfitter:GetOutfitsByCategoryID(vCategoryID)

		if Outfitter:HasVisibleOutfits(vOutfits) then
			Outfitter:AddCategoryMenuItem(vCategoryName)
			
			for vIndex, vOutfit in ipairs(vOutfits) do
				if Outfitter:OutfitIsVisible(vOutfit) then
					local vWearingOutfit = Outfitter:WearingOutfit(vOutfit)
					local vMissingItems, vBankedItems = vInventoryCache:GetMissingItems(vOutfit)
					local vItemColor = NORMAL_FONT_COLOR_CODE
					
					if vMissingItems then
						vItemColor = RED_FONT_COLOR_CODE
					elseif vBankedItems then
						vItemColor = Outfitter.BANKED_FONT_COLOR_CODE
					end
					
					Outfitter:AddMenuItem(
							pFrame,
							vOutfit:GetName(),
							{CategoryID = vCategoryID, Index = vIndex},
							vWearingOutfit, -- Checked
							nil, -- Level
							vItemColor, -- Color
							nil, -- Disabled
							{icon = Outfitter.OutfitBar:GetOutfitTexture(vOutfit)})
				end
			end
		end
	end
end

function Outfitter.DropDown_OnClick(pItem, pOwner, pValue)
	if not pOwner then
		Outfitter:DebugTable(pItem, "OnClick Item")
		return
	end
	
	if pOwner.AutoSetValue then
		pOwner:SetSelectedValue(pValue)
	end
	
	if pOwner.ChangedValueFunc then
		pOwner.ChangedValueFunc(pOwner, pValue)
	end
	
	CloseDropDownMenus()
end

function Outfitter.Item_SetTextColor(pItem, pRed, pGreen, pBlue)
	local vItemNameField
	
	if pItem.isCategory then
		vItemNameField = _G[pItem:GetName().."CategoryName"]
	else
		vItemNameField = _G[pItem:GetName().."OutfitName"]
	end
	
	vItemNameField:SetTextColor(pRed, pGreen, pBlue)
end

function Outfitter:GenerateItemListString(pLabel, pListColorCode, pItems)
	local vItemList = nil

	for vIndex, vOutfitItem in ipairs(pItems) do
		if not vItemList then
			vItemList = HIGHLIGHT_FONT_COLOR_CODE..pLabel..pListColorCode..tostring(vOutfitItem.Name)
		else
			vItemList = vItemList..self.cMissingItemsSeparator..tostring(vOutfitItem.Name)
		end
	end
	
	return vItemList
end

function Outfitter.AddNewbieTip(pItem, pNormalText, pRed, pGreen, pBlue, pNewbieText, pNoNormalText)
	if SHOW_NEWBIE_TIPS == "1" then
		GameTooltip_SetDefaultAnchor(GameTooltip, pItem)
		if pNormalText then
			GameTooltip:SetText(pNormalText, pRed, pGreen, pBlue)
			GameTooltip:AddLine(pNewbieText, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1)
		else
			GameTooltip:SetText(pNewbieText, pRed, pGreen, pBlue, 1, 1)
		end
		GameTooltip:Show()
	else
		if not pNoNormalText then
			GameTooltip:SetOwner(pItem, "ANCHOR_RIGHT")
			GameTooltip:SetText(pNormalText, pRed, pGreen, pBlue)
		end
	end
end

function Outfitter.Item_OnEnter(pItem)
	Outfitter.Item_SetTextColor(pItem, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
	
	if pItem.isCategory then
		local vDescription = Outfitter.cCategoryDescriptions[pItem.categoryID]
		
		if vDescription then
			local CvategoryName = Outfitter["c"..pItem.categoryID.."Outfits"]
			
			Outfitter.AddNewbieTip(pItem, vCategoryName, 1.0, 1.0, 1.0, vDescription, 1)
		end
		
		ResetCursor()
	elseif pItem.isOutfitItem then
		local vHasCooldown, vRepairCost
		
		GameTooltip:SetOwner(pItem, "ANCHOR_TOP")
		
		if pItem.outfitItem.Location.SlotName
		or pItem.outfitItem.Location.SlotID then
			if not pItem.outfitItem.Location.SlotID then
				pItem.outfitItem.Location.SlotID = Outfitter.cSlotIDs[pItem.outfitItem.Location.SlotName]
			end
			
			GameTooltip:SetInventoryItem("player", pItem.outfitItem.Location.SlotID)
		elseif pItem.outfitItem.Location.BagIndex == -1 then
			GameTooltip:SetInventoryItem("player", BankButtonIDToInvSlotID(pItem.outfitItem.Location.BagSlotIndex))
		else
			vHasCooldown, vRepairCost = GameTooltip:SetBagItem(pItem.outfitItem.Location.BagIndex, pItem.outfitItem.Location.BagSlotIndex)
		end
		
		GameTooltip:Show()

		if InRepairMode() and (vRepairCost and vRepairCost > 0) then
			GameTooltip:AddLine(TEXT(REPAIR_COST), "", 1, 1, 1)
			SetTooltipMoney(GameTooltip, vRepairCost)
			GameTooltip:Show()
		elseif MerchantFrame:IsShown() and MerchantFrame.selectedTab == 1 then
			if pItem.outfitItem.Location.BagIndex then
				ShowContainerSellCursor(pItem.outfitItem.Location.BagIndex, pItem.outfitItem.Location.BagSlotIndex)
			end
		else
			ResetCursor()
		end
	else
		local vOutfit = Outfitter:GetOutfitFromListItem(pItem)
		
		Outfitter:ShowOutfitTooltip(vOutfit, pItem, pItem.MissingItems, pItem.BankedItems)
	end
end

function Outfitter:ShowOutfitTooltip(pOutfit, pOwner, pMissingItems, pBankedItems, pShowEmptyTooltips, pTooltipAnchor)
	-- local vInventoryCache = self:GetInventoryCache()
	-- local vMissingItems, vBankedItems = vInventoryCache:GetMissingItems(pOutfit)
	
	local vDescription = self:GetOutfitDescription(pOutfit)
	
	if pMissingItems
	or pBankedItems
	or pShowEmptyTooltips then
		GameTooltip:SetOwner(pOwner, pTooltipAnchor or "ANCHOR_LEFT")
		
		GameTooltip:AddLine(pOutfit:GetName())
		
		if vDescription then
			GameTooltip:AddLine(vDescription, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b, true)
		end
		
		if pMissingItems then
			local vItemList = self:GenerateItemListString(self.cMissingItemsLabel, RED_FONT_COLOR_CODE, pMissingItems)
			GameTooltip:AddLine(vItemList, RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b, true)
		end
		
		if pBankedItems then
			local vItemList = self:GenerateItemListString(self.cBankedItemsLabel, self.BANKED_FONT_COLOR_CODE, pBankedItems)
			GameTooltip:AddLine(vItemList, RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b, true)
		end
		
		GameTooltip:Show()
	elseif vDescription then
		self.AddNewbieTip(pOwner, pOutfit:GetName(), 1.0, 1.0, 1.0, vDescription, 1)
	end
	
	ResetCursor()
end

function Outfitter:GetOutfitDescription(pOutfit)
	return self:GetScriptDescription(self:GetScript(pOutfit))
end

function Outfitter:OutfitHasSettings(pOutfit)
	return self:ScriptHasSettings(self:GetScript(pOutfit))
end

function Outfitter.Item_OnLeave(pItem)
	if pItem.isCategory then
		Outfitter.Item_SetTextColor(pItem, 1, 1, 1)
	else
		Outfitter.Item_SetTextColor(pItem, pItem.DefaultColor.r, pItem.DefaultColor.g, pItem.DefaultColor.b)
	end
	
	GameTooltip:Hide()
end

function Outfitter.Item_OnClick(pItem, pButton, pIgnoreModifiers)
	if pItem.isCategory then
		local vCategoryOutfits = Outfitter.Settings.Outfits[pItem.categoryID]
		
		Outfitter.Collapsed[pItem.categoryID] = not Outfitter.Collapsed[pItem.categoryID]
		Outfitter.DisplayIsDirty = true
	elseif pItem.isOutfitItem then
		if pButton == "LeftButton" then
			Outfitter:PickupItemLocation(pItem.outfitItem.Location)
			StackSplitFrame:Hide()
		else
			if MerchantFrame:IsShown() and MerchantFrame.selectedTab == 2 then
				-- Don't sell the item if the buyback tab is selected
				return
			else
				if pItem.outfitItem.Location.BagIndex then
					UseContainerItem(pItem.outfitItem.Location.BagIndex, pItem.outfitItem.Location.BagSlotIndex)
					StackSplitFrame:Hide()
				end
			end
		end
	else
		local vOutfit = Outfitter:GetOutfitFromListItem(pItem)
		
		if not vOutfit then
			-- Error: outfit not found
			return
		end
		
		if pButton == "LeftButton" then
			vOutfit.Disabled = nil
			Outfitter:WearOutfit(vOutfit)
		else
			if DropDownList1:IsShown() then
				ToggleDropDownMenu(nil, nil, pItem.OutfitMenu)
			else
				ToggleDropDownMenu(nil, nil, pItem.OutfitMenu, "cursor")
				PlaySound("igMainMenuOptionCheckBoxOn")
			end
		end
	end
	
	Outfitter:Update(true)
end

function Outfitter:Item_CheckboxClicked(pItem)
	if pItem.isCategory then
		return
	end
	
	local vOutfits = Outfitter.Settings.Outfits[pItem.categoryID]
	
	if not vOutfits then
		-- Error: outfit category not found
		return
	end
	
	local vOutfit = vOutfits[pItem.outfitIndex]
	
	if not vOutfit then
		-- Error: outfit not found
		return
	end
	
	local vCheckbox = _G[pItem:GetName().."OutfitSelected"]
	
	if vCheckbox:GetChecked() then
		vOutfit.Disabled = nil
		Outfitter:WearOutfit(vOutfit)
	else
		Outfitter:RemoveOutfit(vOutfit)
	end
	
	self.DisplayIsDirty = true
	self:Update(true)
end

function Outfitter:Item_StoreOnServerClicked(pItem)
	if pItem.isCategory then
		return
	end
	
	local vOutfits = self.Settings.Outfits[pItem.categoryID]
	
	if not vOutfits then
		-- Error: outfit category not found
		return
	end
	
	local vOutfit = vOutfits[pItem.outfitIndex]
	
	if not vOutfit then
		-- Error: outfit not found
		return
	end
	
	local vCheckbox = _G[pItem:GetName().."OutfitServerButton"]
	
	if vCheckbox:GetChecked() then
		if vOutfit ~= self.SelectedOutfit then
			self:WearOutfit(vOutfit)
			self:SelectOutfit(vOutfit)
		else
			vOutfit:StoreOnServer()
		end
	else
		vOutfit:StoreLocally()
	end
	
	self.DisplayIsDirty = true
	self:Update(true)
end

function Outfitter.Item_SetToOutfit(pItemIndex, pOutfit, pCategoryID, pOutfitIndex, pInventoryCache)
	local vItemName = "OutfitterItem"..pItemIndex
	local vItem = _G[vItemName]
	local vOutfitFrameName = vItemName.."Outfit"
	local vOutfitFrame = _G[vOutfitFrameName]
	local vItemFrame = _G[vItemName.."Item"]
	local vCategoryFrame = _G[vItemName.."Category"]
	local vMissingItems, vBankedItems = pInventoryCache:GetMissingItems(pOutfit)
	
	vOutfitFrame:Show()
	vCategoryFrame:Hide()
	vItemFrame:Hide()
	
	local vItemSelectedCheckmark = _G[vOutfitFrameName.."Selected"]
	local vItemNameField = _G[vOutfitFrameName.."Name"]
	local vItemMenu = _G[vOutfitFrameName.."Menu"]
	local vItemServerButton = _G[vOutfitFrameName.."ServerButton"]
	
	vItemSelectedCheckmark:Show()
	
	if Outfitter:WearingOutfit(pOutfit) then
		vItemSelectedCheckmark:SetChecked(true)
	else
		vItemSelectedCheckmark:SetChecked(nil)
	end
	
	vItemServerButton:SetChecked(pOutfit.StoredInEM)
	
	vItem.MissingItems = vMissingItems
	vItem.BankedItems = vBankedItems
	
	if pOutfit.Disabled then
		vItemNameField:SetText(format(Outfitter.cDisabledOutfitName, pOutfit:GetName()))
		vItem.DefaultColor = GRAY_FONT_COLOR
	else
		vItemNameField:SetText(pOutfit:GetName())
		if vMissingItems then
			vItem.DefaultColor = RED_FONT_COLOR
		elseif vBankedItems then
			vItem.DefaultColor = Outfitter.BANKED_FONT_COLOR
		else
			vItem.DefaultColor = NORMAL_FONT_COLOR
		end
	end
	
	vItemNameField:SetTextColor(vItem.DefaultColor.r, vItem.DefaultColor.g, vItem.DefaultColor.b)
	
	vItemMenu:Show()
	
	vItem.isCategory = false
	vItem.isOutfitItem = false
	vItem.outfitItem = nil
	vItem.categoryID = pOutfit.CategoryID
	vItem.outfitIndex = pOutfitIndex
	
	vItem:Show()
	
	-- Show the script icon if there's one attached
	
	local vScriptIcon = _G[vOutfitFrameName.."ScriptIcon"]
	
	if pOutfit.ScriptID or pOutfit.Script then
		vScriptIcon:SetTexture("Interface\\Addons\\Outfitter\\Textures\\Gear")
		
		if Outfitter.Settings.Options.DisableAutoSwitch or pOutfit.Disabled then
			vScriptIcon:SetVertexColor(0.4, 0.4, 0.4)
		else
			vScriptIcon:SetVertexColor(1, 1, 1)
		end

		vScriptIcon:Show()
	else
		vScriptIcon:Hide()
	end
	
	-- Update the highlighting
	
	if Outfitter.SelectedOutfit == pOutfit then
		OutfitterMainFrameHighlight:SetPoint("TOPLEFT", vItem, "TOPLEFT", 0, 0)
		OutfitterMainFrameHighlight:Show()
	end
end

function Outfitter.Item_SetToItem(pItemIndex, pOutfitItem)
	local vItemName = "OutfitterItem"..pItemIndex
	local vItem = _G[vItemName]
	local vCategoryFrameName = vItemName.."Category"
	local vItemFrameName = vItemName.."Item"
	local vItemFrame = _G[vItemFrameName]
	local vOutfitFrame = _G[vItemName.."Outfit"]
	local vCategoryFrame = _G[vCategoryFrameName]
	
	vItem.isOutfitItem = true
	vItem.isCategory = false
	vItem.outfitItem = pOutfitItem
	
	vItemFrame:Show()
	vOutfitFrame:Hide()
	vCategoryFrame:Hide()

	local vItemNameField = _G[vItemFrameName.."Name"]
	local vItemIcon = _G[vItemFrameName.."Icon"]
	
	vItemNameField:SetText(pOutfitItem.Name)
	
	if pOutfitItem.Quality then
		vItem.DefaultColor = ITEM_QUALITY_COLORS[(pOutfitItem.Quality ~= 7 and pOutfitItem.Quality) or 6]
	else
		vItem.DefaultColor = GRAY_FONT_COLOR
	end
	
	if pOutfitItem.Texture then
		vItemIcon:SetTexture(pOutfitItem.Texture)
		vItemIcon:Show()
	else
		vItemIcon:Hide()
	end
	
	vItemNameField:SetTextColor(vItem.DefaultColor.r, vItem.DefaultColor.g, vItem.DefaultColor.b)
	
	vItem:Show()
end

function Outfitter.Item_SetToCategory(pItemIndex, pCategoryID)
	local vCategoryName = Outfitter["c"..pCategoryID.."Outfits"]
	local vItemName = "OutfitterItem"..pItemIndex
	local vItem = _G[vItemName]
	local vCategoryFrameName = vItemName.."Category"
	local vOutfitFrame = _G[vItemName.."Outfit"]
	local vItemFrame = _G[vItemName.."Item"]
	local vCategoryFrame = _G[vCategoryFrameName]
	
	vOutfitFrame:Hide()
	vCategoryFrame:Show()
	vItemFrame:Hide()
	
	local vItemNameField = _G[vCategoryFrameName.."Name"]
	local vExpandButton = _G[vCategoryFrameName.."Expand"]
	
	vItem.MissingItems = nil
	vItem.BankedItems = nil
	
	if Outfitter.Collapsed[pCategoryID] then
		vExpandButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up")
	else
		vExpandButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up")
	end
	
	vItemNameField:SetText(vCategoryName)
	
	vItem.isCategory = true
	vItem.isOutfitItem = false
	vItem.outfitItem = nil
	vItem.categoryID = pCategoryID
	
	vItem:Show()
end

function Outfitter:AddOutfitsToList(pOutfits, pCategoryID, pItemIndex, pFirstItemIndex, pInventoryCache)
	local vOutfits = pOutfits[pCategoryID]
	local vItemIndex = pItemIndex
	local vFirstItemIndex = pFirstItemIndex
	
	if vFirstItemIndex == 0 then
		self.Item_SetToCategory(vItemIndex, pCategoryID, false)
		vItemIndex = vItemIndex + 1
	else
		vFirstItemIndex = vFirstItemIndex - 1
	end

	if vItemIndex >= self.cMaxDisplayedItems then
		return vItemIndex, vFirstItemIndex
	end

	if not self.Collapsed[pCategoryID]
	and vOutfits then
		for vIndex, vOutfit in ipairs(vOutfits) do
			if vFirstItemIndex == 0 then
				self.Item_SetToOutfit(vItemIndex, vOutfit, pCategoryID, vIndex, pInventoryCache)
				vItemIndex = vItemIndex + 1
				
				if vItemIndex >= self.cMaxDisplayedItems then
					return vItemIndex, vFirstItemIndex
				end
			else
				vFirstItemIndex = vFirstItemIndex - 1
			end
		end
	end
	
	return vItemIndex, vFirstItemIndex
end

function Outfitter:AddOutfitItemsToList(pOutfitItems, pCategoryID, pItemIndex, pFirstItemIndex)
	local vItemIndex = pItemIndex
	local vFirstItemIndex = pFirstItemIndex
	
	if vFirstItemIndex == 0 then
		self.Item_SetToCategory(vItemIndex, pCategoryID, false)
		vItemIndex = vItemIndex + 1
	else
		vFirstItemIndex = vFirstItemIndex - 1
	end

	if vItemIndex >= self.cMaxDisplayedItems then
		return vItemIndex, vFirstItemIndex
	end

	if not self.Collapsed[pCategoryID] then
		for vIndex, vOutfitItem in ipairs(pOutfitItems) do
			if vFirstItemIndex == 0 then
				self.Item_SetToItem(vItemIndex, vOutfitItem)
				vItemIndex = vItemIndex + 1
				
				if vItemIndex >= self.cMaxDisplayedItems then
					return vItemIndex, vFirstItemIndex
				end
			else
				vFirstItemIndex = vFirstItemIndex - 1
			end
		end
	end
	
	return vItemIndex, vFirstItemIndex
end

function Outfitter:SortOutfits()
	for vCategoryID, vOutfits in pairs(self.Settings.Outfits) do
		table.sort(vOutfits, Outfiter_CompareOutfitNames)
	end
end

function Outfiter_CompareOutfitNames(pOutfit1, pOutfit2)
	if pOutfit1.Name ~= pOutfit2.Name then
		if not pOutfit1.Name then
			return false
		end
		
		if not pOutfit2.Name then
			return true
		end
		
		return pOutfit1.Name < pOutfit2.Name
	end
	
	return pOutfit1.StoredInEM and not pOutfit2.StoredInEM
end

function Outfitter:Update(pOutfitsChanged)
	-- Flush the caches
	
	if pOutfitsChanged then
		self:EraseTable(self.OutfitInfoCache)
	end
	
	-- Just leave if we're not visible (when does this happen?)
	
	if not OutfitterFrame:IsVisible() then
		return
	end
	
	--
	
	if self.CurrentPanel == 1 then
		-- Main panel
		
		if not self.DisplayIsDirty then
			return
		end
		
		self.DisplayIsDirty = false
		
		-- Sort the outfits
		
		self:SortOutfits()
		
		-- Get the equippable items so outfits can be marked if they're missing anything
		
		local vInventoryCache = self:GetInventoryCache()
		
		-- Update the slot enables if they're shown
		
		if pOutfitsChanged
		and OutfitterSlotEnables:IsVisible() then
			self:UpdateSlotEnables(self.SelectedOutfit, vInventoryCache)
		end
		
		vInventoryCache:CompiledUnusedItemsList()
		
		-- Update the list
		
		OutfitterMainFrameHighlight:Hide()
		
		local vFirstItemIndex = FauxScrollFrame_GetOffset(OutfitterMainFrameScrollFrame)
		local vItemIndex = 0
		
		vInventoryCache:ResetIgnoreItemFlags()
		
		for vCategoryIndex, vCategoryID in ipairs(self.cCategoryOrder) do
			vItemIndex, vFirstItemIndex = self:AddOutfitsToList(self.Settings.Outfits, vCategoryID, vItemIndex, vFirstItemIndex, vInventoryCache)
			
			if vItemIndex >= self.cMaxDisplayedItems then
				break
			end
		end
		
		if vItemIndex < self.cMaxDisplayedItems
		and vInventoryCache.UnusedItems then
			vItemIndex, vFirstItemIndex = self:AddOutfitItemsToList(vInventoryCache.UnusedItems, "OddsNEnds", vItemIndex, vFirstItemIndex)
		end
		
		-- Hide any unused items
		
		for vItemIndex2 = vItemIndex, (self.cMaxDisplayedItems - 1) do
			local vItemName = "OutfitterItem"..vItemIndex2
			local vItem = _G[vItemName]
			
			vItem:Hide()
		end
		
		local vTotalNumItems = 0
		
		for vCategoryIndex, vCategoryID in ipairs(self.cCategoryOrder) do
			vTotalNumItems = vTotalNumItems + 1
			
			local vOutfits = self.Settings.Outfits[vCategoryID]
			
			if not self.Collapsed[vCategoryID]
			and vOutfits then
				vTotalNumItems = vTotalNumItems + #vOutfits
			end
		end
		
		if vInventoryCache.UnusedItems then
			vTotalNumItems = vTotalNumItems + 1
			
			if not self.Collapsed["OddsNEnds"] then
				vTotalNumItems = vTotalNumItems + #vInventoryCache.UnusedItems
			end
		end
		
		FauxScrollFrame_Update(
				OutfitterMainFrameScrollFrame,
				vTotalNumItems,                 -- numItems
				self.cMaxDisplayedItems,        -- numToDisplay
				18,                             -- valueStep
				nil, nil, nil,                  -- button, smallWidth, bigWidth
				nil,                            -- highlightFrame
				0, 0)                           -- smallHighlightWidth, bigHighlightWidth
	elseif self.CurrentPanel == 2 then -- Options panel
		OutfitterAutoSwitch:SetChecked(self.Settings.Options.DisableAutoSwitch)
		OutfitterShowMinimapButton:SetChecked(not self.Settings.Options.HideMinimapButton)
		OutfitterTooltipInfo:SetChecked(not self.Settings.Options.DisableToolTipInfo)
		OutfitterShowHotkeyMessages:SetChecked(not self.Settings.Options.DisableHotkeyMessages)
		OutfitterShowOutfitBar:SetChecked(self.Settings.OutfitBar.ShowOutfitBar)
		OutfitterItemComparisons:SetChecked(not self.Settings.Options.DisableItemComparisons)
	end
end

function Outfitter.OnVerticalScroll(pScrollFrame)
	Outfitter.DisplayIsDirty = true
	Outfitter:Update(false)
end

function Outfitter:SelectOutfit(pOutfit)
	if not self:IsOpen() then
		return
	end
	
	self.SelectedOutfit = pOutfit
	
	-- Get the equippable items so outfits can be marked if they're missing anything
	
	local vInventoryCache = self:GetInventoryCache()
	
	-- Update the slot enables
	
	self:UpdateSlotEnables(pOutfit, vInventoryCache)
	OutfitterSlotEnables:Show()
	
	-- Done, rebuild the list
	
	self.DisplayIsDirty = true
end

function Outfitter:UpdateSlotEnables(pOutfit, pInventoryCache)
	if UnitHasRelicSlot("player") then
		OutfitterEnableAmmoSlot:Hide()
	else
		OutfitterEnableAmmoSlot:Show()
	end
	
	for _, vInventorySlot in ipairs(self.cSlotNames) do
		local vCheckbox = _G["OutfitterEnable"..vInventorySlot]
		
		if not pOutfit:SlotIsEnabled(vInventorySlot) then
			vCheckbox:SetChecked(false)
		else
			if pOutfit:SlotIsEquipped(vInventorySlot, pInventoryCache) then
				vCheckbox:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
				vCheckbox.IsUnknown = false
			else
				vCheckbox:SetCheckedTexture("Interface\\Addons\\Outfitter\\Textures\\CheckboxUnknown")
				vCheckbox.IsUnknown = true
			end
			
			vCheckbox:SetChecked(true)
		end
	end
end

function Outfitter:ClearSelection()
	self.SelectedOutfit = nil
	self.DisplayIsDirty = true
	OutfitterSlotEnables:Hide()
end

function Outfitter:FindOutfitItemIndex(pOutfit)
	local vOutfitCategoryID, vOutfitIndex = self:FindOutfit(pOutfit)
	
	if not vOutfitCategoryID then
		return nil
	end
	
	local vItemIndex = 0
	
	for vCategoryIndex, vCategoryID in ipairs(self.cCategoryOrder) do
		vItemIndex = vItemIndex + 1
		
		if not self.Collapsed[vCategoryID] then
			if vOutfitCategoryID == vCategoryID then
				return vItemIndex + vOutfitIndex - 1
			else
				vItemIndex = vItemIndex + #self.Settings.Outfits[vCategoryID]
			end
		end
	end
	
	return nil
end

function Outfitter:WearOutfitByName(pOutfitName, pLayerID)
	vOutfit = self:FindOutfitByName(pOutfitName)
	
	if not vOutfit then
		self:ErrorMessage("Couldn't find outfit named %s", pOutfitName)
		return
	end
	
	self:WearOutfit(vOutfit, pLayerID)
end

function Outfitter:RemoveOutfitByName(pOutfitName, pLayerID)
	vOutfit = self:FindOutfitByName(pOutfitName)
	
	if not vOutfit then
		self:ErrorMessage("Couldn't find outfit named %s", pOutfitName)
		return
	end
	
	self:RemoveOutfit(vOutfit)
end

function Outfitter:WearOutfitNow(pOutfit, pLayerID, pCallerIsScript)
	self:BeginEquipmentUpdate()
	self:WearOutfit(pOutfit, pLayerID, pCallerIsScript)
	self:EndEquipmentUpdate(nil, true)
end

function Outfitter:WearOutfit(pOutfit, pLayerID, pCallerIsScript)
	self:BeginEquipmentUpdate()
	
	-- Update the equipment
	
	pOutfit.didEquip = pCallerIsScript
	pOutfit.didUnequip = false
	
	self.EquippedNeedsUpdate = true
	
	-- Add the outfit to the stack
	
	if pOutfit.CategoryID == "Complete" then
		self.OutfitStack:Clear()
	elseif pOutfit.UnequipOthers then
		self.OutfitStack:ClearCategory("Accessory")
	end
	
	self.OutfitStack:AddOutfit(pOutfit, pLayerID)
	
	-- If it's a Complete outfit, push it onto the list of recent complete outfits
	
	if pOutfit.CategoryID == "Complete" and pOutfit:GetName() then
		local vOutfitName = pOutfit:GetName()
		
		for vRecentIndex, vRecentName in ipairs(self.Settings.RecentCompleteOutfits) do
			if vRecentName == vOutfitName then
				table.remove(self.Settings.RecentCompleteOutfits, vRecentIndex)
				break
			end
		end
		
		table.insert(self.Settings.RecentCompleteOutfits, vOutfitName)
	end
	
	-- If Outfitter is open then also select the outfit.  This is important
	-- because the UI can't function correctly if the selected outfit and
	-- top outfit don't stay the same.
	
	if self:IsOpen() then
		if self.OutfitStack:IsTopmostOutfit(pOutfit) then
			self:SelectOutfit(pOutfit)
		else
			self:ClearSelection()
		end
	end
	
	self:EndEquipmentUpdate("Outfitter:WearOutfit")
end

function Outfitter:RemoveOutfitNow(pOutfit, pCallerIsScript)
	self:BeginEquipmentUpdate()
	self:RemoveOutfit(pOutfit, pCallerIsScript)
	self:EndEquipmentUpdate(nil, true)
end


function Outfitter:RemoveOutfit(pOutfit, pCallerIsScript)
	-- HACK: Disabling the unequipping of Complete outfits to see it works better
	-- for more end-user situations
	
	-- UPDATE: It doesn't :(  Stealth, riding and other gear as Complete outfits
	-- fail to unequip
	
	--if pOutfit.CategoryID == "Complete" then
	--	return
	--end
	
	-- Remove it from the stack
	
	if not self.OutfitStack:RemoveOutfit(pOutfit) then
		return
	end
	
	-- If it's a Complete outfit, move it to the bottom of the list of recent complete outfits
	
	if pOutfit.CategoryID == "Complete" and pOutfit:GetName() then
		for vRecentIndex, vRecentName in ipairs(self.Settings.RecentCompleteOutfits) do
			if vRecentName == pOutfit:GetName() then
				table.remove(self.Settings.RecentCompleteOutfits, vRecentIndex)
				break
			end
		end
		
		table.insert(self.Settings.RecentCompleteOutfits, 1, pOutfit:GetName())
	end
	
	--
	
	self:BeginEquipmentUpdate()
	
	-- Clear the selection if the outfit being removed
	-- is selected too
	
	if self.SelectedOutfit == pOutfit then
		self:ClearSelection()
	end

	-- Update the list
	
	pOutfit.didEquip = false
	pOutfit.didUnequip = pCallerIsScript
	
	self.EquippedNeedsUpdate = true
	
	self:EndEquipmentUpdate("Outfitter:RemoveOutfit")
	
	self:DispatchOutfitEvent("UNWEAR_OUTFIT", pOutfit:GetName(), pOutfit)
	
	-- If they're removing a complete outfit, find something else to wear instead
	
	if pOutfit.CategoryID == "Complete"
	and #self.Settings.RecentCompleteOutfits then
		local vOutfit
		
		while not vOutfit do
			local vOutfitName = self.Settings.RecentCompleteOutfits[#self.Settings.RecentCompleteOutfits]
			
			vOutfit = self:FindOutfitByName(vOutfitName)
			
			if vOutfit and vOutfit.CategoryID == "Complete" then
				self:WearOutfit(vOutfit)
				break
			end
			
			table.remove(self.Settings.RecentCompleteOutfits)
			
			if #self.Settings.RecentCompleteOutfits then
				break
			end
		end
	end
end

function Outfitter:ToggleOutfitNow(pOutfit)
	if self:WearingOutfit(pOutfit) then
		self:RemoveOutfitNow(pOutfit)
		return false
	else
		self:WearOutfitNow(pOutfit)
		return true
	end
end

function Outfitter:ToggleOutfit(pOutfit)
	if self:WearingOutfit(pOutfit) then
		self:RemoveOutfit(pOutfit)
		return false
	else
		self:WearOutfit(pOutfit)
		return true
	end
end

function Outfitter:SetSoundOption(pParam)
	if pParam == "on" then
		self.Settings.EnableEquipSounds = true
		self:NoteMessage("Outfitter will no longer affect sounds during equipment changes")
	elseif pParam == "off" then
		self.Settings.EnableEquipSounds = nil
		self:NoteMessage("Outfitter will now disable sound effects during equipment changes")
	else
		self:NoteMessage("Valid sound options are 'on' and 'off'")
	end
end

function Outfitter:SetErrorsOption(pParam)
	if pParam == "on" then
		self.Settings.DisableEquipErrors = nil
		self:NoteMessage("Outfitter will report errors during equipment changes")
	elseif pParam == "off" then
		self.Settings.DisableEquipErrors = true
		self:NoteMessage("Outfitter will not report errors during equipment changes")
	else
		self:NoteMessage("Valid error options are 'on' and 'off'")
	end
end

function Outfitter:ShowLinkStats(pLink)
	local vStats = self:GetItemLinkStats(pLink)
	
	if not vStats then
		self:NoteMessage("Couldn't get item stats from the link provided")
		return
	end
	
	-- self:ConvertRatingsToStats(vStats)
	-- self:DistributeSecondaryStats(vStats, self:GetPlayerStatDistribution())
	
	for vStatName, vStatValue in pairs(vStats) do
		self:NoteMessage("%s: %s", vStatName, vStatValue or "nil")
	end
end

function Outfitter:ShowLinkInfo(pLink)
	local vItemInfo = self:GetItemInfoFromLink(pLink)
	
	if not vItemInfo then
		self:NoteMessage("Couldn't get item info from the link provided")
		return
	end
	
	self:NoteMessage("Name: "..vItemInfo.Name)
	self:NoteMessage("Quality: "..vItemInfo.Quality)
	self:NoteMessage("Code: "..vItemInfo.Code)
	self:NoteMessage("SubCode: "..vItemInfo.SubCode)
	self:NoteMessage("Type: "..vItemInfo.Type)
	self:NoteMessage("SubType: "..vItemInfo.SubType)
	self:NoteMessage("InvType: "..vItemInfo.InvType)
	self:NoteMessage("Level: "..vItemInfo.Level)
	if vItemInfo.EnchantCode then
		self:NoteMessage("EnchantCode: "..vItemInfo.EnchantCode)
	end
	if vItemInfo.JewelCode1 then
		self:NoteMessage("JewelCode1: "..vItemInfo.JewelCode1)
	end
	if vItemInfo.JewelCode2 then
		self:NoteMessage("JewelCode2: "..vItemInfo.JewelCode2)
	end
	if vItemInfo.JewelCode3 then
		self:NoteMessage("JewelCode3: "..vItemInfo.JewelCode3)
	end
	if vItemInfo.JewelCode4 then
		self:NoteMessage("JewelCode4: "..vItemInfo.JewelCode4)
	end
	if vItemInfo.UniqueID then
		self:NoteMessage("UniqueID: "..vItemInfo.UniqueID)
	end
	
	local vStats = self:GetItemLinkStats(pLink)
	
	--self:ConvertRatingsToStats(vStats)
	--self:DistributeSecondaryStats(vStats, self:GetPlayerStatDistribution())
	
	self:DebugTable(vStats, "Stats")
end

function Outfitter:DepositOutfitUnique(pOutfit)
	self:DepositOutfit(pOutfit, true)
end

StaticPopupDialogs.OUTFITTER_CONFIRM_RESET =
{
	text = TEXT(Outfitter.cConfirmResetMsg),
	button1 = TEXT(Outfitter.cReset),
	button2 = TEXT(CANCEL),
	OnAccept = function() Outfitter:Reset() end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1,
}

function Outfitter.AskReset()
	StaticPopup_Show("OUTFITTER_CONFIRM_RESET")
end

function Outfitter:Reset()
	OutfitterFrame:Hide()
	
	self:ClearSelection()
	self.OutfitStack:Clear()
	
	self:InitializeSettings()

	self.CurrentOutfit = self:GetInventoryOutfit()
	self:InitializeOutfits()
	self:SynchronizeEM()
	
	self.EquippedNeedsUpdate = false
end

function Outfitter:SetOutfitBindingIndex(pOutfit, pBindingIndex)
	if pBindingIndex then
		for vCategoryID, vOutfits in pairs(self.Settings.Outfits) do
			for vOutfitIndex, vOutfit in ipairs(vOutfits) do
				if vOutfit.BindingIndex == pBindingIndex then
					vOutfit.BindingIndex = nil
				end
			end
		end
	end
	
	pOutfit.BindingIndex = pBindingIndex
end

Outfitter.LastBindingIndex = nil
Outfitter.LastBindingTime = nil

Outfitter.cMinBindingTime = 0.75

function Outfitter:WearBoundOutfit(pBindingIndex)
	-- Check for the user spamming the button to prevent the outfit from
	-- toggling if they're panicking
	
	local vTime = GetTime()
	
	if self.LastBindingIndex == pBindingIndex then
		local vElapsed = vTime - self.LastBindingTime
		
		if vElapsed < self.cMinBindingTime then
			self.LastBindingTime = vTime
			return
		end
	end
	
	--
	
	for vCategoryID, vOutfits in pairs(self.Settings.Outfits) do
		for vOutfitIndex, vOutfit in ipairs(vOutfits) do
			if vOutfit.BindingIndex == pBindingIndex then
				vOutfit.Disabled = nil
				Outfitter.HasHWEvent = true
				if vCategoryID == "Complete" then
					self:WearOutfitNow(vOutfit)
					if not self.Settings.Options.DisableHotkeyMessages then
						UIErrorsFrame:AddMessage(format(self.cEquipOutfitMessageFormat, vOutfit:GetName()), self.OUTFIT_MESSAGE_COLOR.r, self.OUTFIT_MESSAGE_COLOR.g, self.OUTFIT_MESSAGE_COLOR.b)
					end
				else
					local vEquipped = self:ToggleOutfitNow(vOutfit, vCategoryID)
					
					if not self.Settings.Options.DisableHotkeyMessages then
						if vEquipped then
							UIErrorsFrame:AddMessage(format(self.cEquipOutfitMessageFormat, vOutfit:GetName()), self.OUTFIT_MESSAGE_COLOR.r, self.OUTFIT_MESSAGE_COLOR.g, self.OUTFIT_MESSAGE_COLOR.b)
						else
							UIErrorsFrame:AddMessage(format(self.cUnequipOutfitMessageFormat, vOutfit:GetName()), self.OUTFIT_MESSAGE_COLOR.r, self.OUTFIT_MESSAGE_COLOR.g, self.OUTFIT_MESSAGE_COLOR.b)
						end
					end
				end
				Outfitter.HasHWEvent = false
				
				-- Remember the binding used to filter for button spam
				
				self.LastBindingIndex = pBindingIndex
				self.LastBindingTime = vTime
				
				return
			end
		end
	end
end

function Outfitter:FindOutfit(pOutfit)
	for vCategoryID, vOutfits in pairs(self.Settings.Outfits) do
		for vOutfitIndex, vOutfit in ipairs(vOutfits) do
			if vOutfit == pOutfit then
				return vCategoryID, vOutfitIndex
			end
		end
	end
	
	return nil, nil
end

function Outfitter:FindOutfitByName(pName)
	if not pName
	or pName == "" then
		return nil
	end
	
	local vLowerName = strlower(pName)
	
	for vCategoryID, vOutfits in pairs(self.Settings.Outfits) do
		for vOutfitIndex, vOutfit in ipairs(vOutfits) do
			if strlower(vOutfit:GetName()) == vLowerName then
				return vOutfit, vCategoryID, vOutfitIndex
			end
		end
	end
	
	return nil, nil
end

function Outfitter:GetOutfitCategoryID(pOutfit)
	for vCategoryID, vOutfits in pairs(self.Settings.Outfits) do
		for vOutfitIndex, vOutfit in ipairs(vOutfits) do
			if vOutfit == pOutfit then
				return vCategoryID, vOutfitIndex
			end
		end
	end
end

-- Outfitter doesn't use this function, but other addons such as
-- Fishing Buddy might use it to locate specific generated outfits

function Outfitter:FindOutfitByStatID(pStatID)
	if not pStatID or pStatID == "" then
		return nil
	end

	for vCategoryID, vOutfits in pairs(self.Settings.Outfits) do
		for vOutfitIndex, vOutfit in ipairs(vOutfits) do
			if vOutfit.StatID and vOutfit.StatID == pStatID then
				return vOutfit, vCategoryID, vOutfitIndex
			end
		end
	end
	
	return nil
end

function Outfitter:GetPlayerStatDistribution()
	local vClassDist = self.cStatDistribution[self.PlayerClass]
	local vRatingsDist = self:GetPlayerRatingStatDistribution()
	
	for vStatID, vDist in pairs(vRatingsDist) do
		vClassDist[vStatID] = vDist
	end
	
	return vClassDist
end

Outfitter.BaseRatings61 =
{
	ArmorPenetration = 3.75,
	Expertise = 2.5,
	
	MeleeHaste = 10,
	MeleeHit = 10,
	MeleeCrit = 14,
	
	SpellHaste = 10,
	SpellHit = 8,
	SpellCrit = 14,
	
	Defense = 1.5,
	Dodge = 12,
	Parry = 15,
	Block = 5,
	Resilience = 25,
}

function Outfitter:GetPlayerRatingStatDistribution()
	local vLevel = UnitLevel("player")
	
	if self.RatingStatDistribution
	and self.RatingStatDistributionLevel == vLevel then
		return self.RatingStatDistribution
	end
	
	--
	
	self.RatingStatDistribution = {}
	
	if vLevel < 10 then
		vLevel = 10
	end
	
	local vLevelFactor
	local vDodgeLevelFactor
	
	if vLevel <= 10 then
		vLevelFactor = 1 / 26
	elseif vLevel <= 60 then
		vLevelFactor = (vLevel - 8) / 52
	elseif vLevel <= 70 then
		vLevelFactor = 82 / (262 - 3 * vLevel)
	else
		vLevelFactor = (82 / 52) * (131 / 63) ^ ((vLevel - 70) / 10)
	end
	
	if vLevel <= 34 then
		vDodgeLevelFactor = 1 / 2
	else
		vDodgeLevelFactor = (vLevel - 8) / 52
	end
	
	for vStatID, vBase in pairs(self.BaseRatings61) do
		if vStatID == "Dodge" then
			self.RatingStatDistribution[vStatID.."Rating"] = {[vStatID] = {Coeff = 1.0 / (vBase * vDodgeLevelFactor)}}
		else
			self.RatingStatDistribution[vStatID.."Rating"] = {[vStatID] = {Coeff = 1.0 / (vBase * vLevelFactor)}}
		end
	end
	
	return self.RatingStatDistribution
end
	
function Outfitter:OutfitSummary()
	local vStatDistribution = self:GetPlayerStatDistribution()
	
	self:DebugTable(vStatDistribution, "StatDistribution")
	
	local vCurrentOutfitStats = self.TankPoints_GetCurrentOutfitStats(vStatDistribution)
	
	self:DebugTable(vCurrentOutfitStats, "Current Stats")
end

function Outfitter:RatingSummary()
	local vRatingIDs =
	{
		"Weapon",
		"Defense",
		"Dodge",
		"Parry",
		"Block",
		"Melee Hit",
		"Ranged Hit",
		"Spell Hit",
		"Melee Crit",
		"Ranged Crit",
		"Spell Crit",
		"Melee Hit Taken",
		"Ranged Hit Taken",
		"Spell Hit Taken",
		"Melee Crit Taken",
		"Ranged Crit Taken",
		"Spell Crit Taken",
		"Melee Haste",
		"Ranged Haste",
		"Spell Haste",
	}
	
	for vRatingID, vRatingName in ipairs(vRatingIDs) do
		local vRating = GetCombatRating(vRatingID)
		local vRatingBonus = GetCombatRatingBonus(vRatingID)
		
		if vRatingBonus > 0 then
			self:NoteMessage(vRatingName..": "..(vRating / vRatingBonus))
		end
	end
end

-- Work-in-progress for bag organization.  Probably will get split into another addon
-- at some point, just playing around with it for now.

local gOutfitter_SortBagItems
local gOutfitter_Categories =
{
	"Armor",
	"Weapons",
	"Consumables",
		"Potions",
		"Healthstone",
		"Mana gem",
		"Flasks",
		"Elixirs",
		"Bandages",
		"Trinkets",
	"Tradeskill",
		"Herbs",
		"Metals",
		"Gems",
		"Cloth",
		"Leather",
		"Cooking",
			"Spices",
			"Meat",
	"QuestItems",
	"Loot",
		"BoEs",
	"Junk",
}

local gOutfitterItemCorrections =
{
	[6533] = {Type = "Consumable", SubType = "Other"}, -- Aquadynamic Fish Attractor
	[27503] = {SubType = "Scroll"}, -- Scroll of Protection V
	[27515] = {Type = "Trade Goods", SubType = "Meat", InvType = ""}, -- Huge Spotted Feltail
}

function Outfitter:CorrectItemInfo(pItemInfo)
	local vCorrection = gOutfitterItemCorrections[pItemInfo.Code]
	
	if not vCorrection then
		return
	end
	
	for vIndex, vValue in pairs(vCorrection) do
		pItemInfo[vIndex] = vValue
	end
end

function Outfitter.GetItemSortRank(pItem)
	if pItem.ItemIsUsed then
		return 0
	elseif pItem.Quality == 0 then
		return 3
	elseif pItem.Equippable then
		return 2
	else
		return 1
	end
end

function Outfitter:SortBags()
	self.SortBagsCoroutineRef = coroutine.create(self.SortBagsThread)
	
	self:RunThreads()
end

function Outfitter:RunThreads()
	if self.SortBagsCoroutineRef then
		local vSuccess, vMessage = coroutine.resume(self.SortBagsCoroutineRef, self)
		
		if not vSuccess then
			self:ErrorMessage("SortBags resume failed: %s", vMessage)
		end
	end
end

function Outfitter:SortBagsThread()
	self.EventLib:RegisterEvent("BAG_UPDATE", self.BagSortBagsChanged, self)
	self.EventLib:RegisterEvent("PLAYERBANKSLOTS_CHANGED", self.BagSortBagsChanged, self)
	
	if true then
		self:SortBagRange(NUM_BAG_SLOTS, 0)
		
		if self.BankFrameOpened then
			for vBankSlot = NUM_BAG_SLOTS + 1, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do
				self:SortBagRange(vBankSlot, vBankSlot)
			end
			
			self:SortBagRange(-1, -1)
		end
	else
		self:SortBagRange(5, 5)
	end

	self.EventLib:UnregisterEvent("BAG_UPDATE", self.BagSortBagsChanged, self)
	self.EventLib:UnregisterEvent("PLAYERBANKSLOTS_CHANGED", self.BagSortBagsChanged, self)
	
	self.SortBagsCoroutineRef = nil
end

function Outfitter:BagSortBagsChanged()
	self.BagChangeTime = GetTime()
	
	self.SchedulerLib:RescheduleTask(0.5, self.RunThreads, self)
end

function Outfitter:SortBagRange(pStartIndex, pEndIndex)
	self:DebugMessage("SortBagRange: %s, %s", pStartIndex or "nil", pEndIndex or "nil")
	
	-- Gather a list of the items
	
	local vItems = {}
	local vIterator = self:New(self._BagIterator, pStartIndex, pEndIndex)
	
	while vIterator:NextSlot() do
		self:DebugMessage("Checking slot %d, %d", vIterator.BagIndex, vIterator.BagSlotIndex)
		
		local vItemInfo = self:GetBagItemInfo(vIterator.BagIndex, vIterator.BagSlotIndex)
		
		if vItemInfo then
			self:CorrectItemInfo(vItemInfo)
			
			vItemInfo.ItemIsUsed = self:GetOutfitsUsingItem(vItemInfo)
			vItemInfo.Equippable = vItemInfo.InvType ~= ""
			vItemInfo.SortRank = self.GetItemSortRank(vItemInfo)
			
			table.insert(vItems, vItemInfo)
		end
	end
	
	-- Sort the items
	
	self:DebugMessage("Sorting the items")
	
	table.sort(vItems, self.BagSortCompareItems)
	
	-- Assign the items to bag slots
	
	self:DebugMessage("Assigning locations")
	
	local vDestBagSlot = self:New(self._BagIterator, pStartIndex, pEndIndex)
	
	for _, vItemInfo in ipairs(vItems) do
		if not vDestBagSlot:NextSlot() then
			break
		end
		
		vItemInfo.DestBagIndex = vDestBagSlot.BagIndex
		vItemInfo.DestBagSlotIndex = vDestBagSlot.BagSlotIndex
	end
	
	--
	
	self:DebugMessage("Starting item moves")
	
	while self:BagSortMoveItems(vItems) do
		self:DebugMessage("Completed one move")
		
		while not self.BagChangeTime or GetTime() - self.BagChangeTime < 0.5 do
			self:DebugMessage("Yielding")
			self:BagSortBagsChanged()
			coroutine.yield()
		end
	end
	
	self:DebugMessage("Done moving items")
end	

function Outfitter:BagSortMoveItems(pItems)
	self:DebugMessage("BagSortMoveItems")
	
	local vDidMove = false
	local vBagSlotUsed = {}
	
	for vIndex = -1, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do
		vBagSlotUsed[vIndex] = {}
	end
	
	-- Move the items to their destinations
	
	local vSaved_EnableSFX = GetCVar("Sound_EnableSFX")
	SetCVar("Sound_EnableSFX", "0")
	
	local vNumMoves = 0
	
	for _, vItemInfo in ipairs(pItems) do
		if (vItemInfo.Location.BagIndex ~= vItemInfo.DestBagIndex
		or vItemInfo.Location.BagSlotIndex ~= vItemInfo.DestBagSlotIndex)
		and not vBagSlotUsed[vItemInfo.Location.BagIndex][vItemInfo.Location.BagSlotIndex]
		and not vBagSlotUsed[vItemInfo.DestBagIndex][vItemInfo.DestBagSlotIndex] then
			
			self:DebugMessage("Checking item in %d, %d", vItemInfo.Location.BagIndex, vItemInfo.Location.BagSlotIndex)
			
			-- Find the item currently at the destination (if any)
			
			local vDestItemInfo
			
			for _, vItemInfo2 in ipairs(pItems) do
				if vItemInfo2.Location.BagSlotIndex == vItemInfo.DestBagSlotIndex
				and vItemInfo2.Location.BagIndex == vItemInfo.DestBagIndex then
					self:DebugMessage("Found item in pItems")
					vDestItemInfo = vItemInfo2
					break
				end
			end
			
			-- Move/swap the items
			
			self:NoteMessage(format(
					"Moving %s from bag %d, %d to %d, %d",
					vItemInfo.Name,
					vItemInfo.Location.BagIndex, vItemInfo.Location.BagSlotIndex,
					vItemInfo.DestBagIndex, vItemInfo.DestBagSlotIndex))
			
			
			ClearCursor()
			self:PickupItemLocation(vItemInfo.Location)
			self:PickupItemLocation({BagIndex = vItemInfo.DestBagIndex, BagSlotIndex = vItemInfo.DestBagSlotIndex})
			if vDestItemInfo then self:PickupItemLocation(vItemInfo.Location) end
			ClearCursor()
			
			-- Mark the bag slots as already being involved in this round
			
			vBagSlotUsed[vItemInfo.Location.BagIndex][vItemInfo.Location.BagSlotIndex] = true
			vBagSlotUsed[vItemInfo.DestBagIndex][vItemInfo.DestBagSlotIndex] = true
			
			-- Update the source and dest item info
			
			if vDestItemInfo then
				vDestItemInfo.Location.BagIndex = vItemInfo.Location.BagIndex
				vDestItemInfo.Location.BagSlotIndex = vItemInfo.Location.BagSlotIndex
			end
			
			vItemInfo.Location.BagIndex = vItemInfo.DestBagIndex
			vItemInfo.Location.BagSlotIndex = vItemInfo.DestBagSlotIndex
			
			vDidMove = true
			
			self:BagSortBagsChanged()
			
			-- Yield every ten item moves
			
			vNumMoves = vNumMoves + 1
			
			if vNumMoves >= 10 then
				SetCVar("Sound_EnableSFX", vSaved_EnableSFX)
				coroutine.yield()
				SetCVar("Sound_EnableSFX", "0")
				
				vNumMoves = 0
			end
		end
	end
	
	SetCVar("Sound_EnableSFX", vSaved_EnableSFX)
	
	self:DebugMessage("BagSortMoveItems completed: vDidMove = %s", tostring(vDidMove))
	
	return vDidMove
end

function Outfitter.BagSortCompareItems(pItem1, pItem2) -- Must not be method since it's called by table.sort
	if pItem1.SortRank ~= pItem2.SortRank then
		return pItem1.SortRank < pItem2.SortRank
	end
	
	-- If both items are equippable, sort them by
	-- slot first
	
	if pItem1.Equippable then
		return pItem1.InvType < pItem2.InvType
	end
	
	-- Sort items by type
	
	if pItem1.Type ~= pItem2.Type then
		return pItem1.Type < pItem2.Type
	end
	
	-- Sort by subtype
	
	if pItem1.SubType ~= pItem2.SubType then
		return pItem1.SubType < pItem2.SubType
	end
	
	-- Sort by name
	
	if pItem1.Name ~= pItem2.Name then
		return pItem1.Name < pItem2.Name
	end
	
	-- Sort by where they're already at if they're the same item
	
	if pItem1.Location.BagIndex ~= pItem2.Location.BagIndex then
		return pItem1.Location.BagIndex > pItem2.Location.BagIndex
	end
	
	if pItem1.Location.BagSlotIndex ~= pItem2.Location.BagSlotIndex then
		return pItem1.Location.BagSlotIndex < pItem2.Location.BagSlotIndex
	end
	
	return false
end

Outfitter._BagIterator = {}
Outfitter.cGeneralBagType = 0

function Outfitter._BagIterator:Construct(pStartIndex, pEndIndex)
	self:Reset(pStartIndex, pEndIndex)
end

function Outfitter._BagIterator:Reset(pStartIndex, pEndIndex)
	if not pStartIndex then
		pStartIndex = NUM_BAG_SLOTS
		pEndIndex = 0
	end
	
	if not pEndIndex then
		pEndIndex = pStartIndex
	end
	
	if pStartIndex <= pEndIndex then
		self.Direction = 1
	else
		self.Direction = -1
	end
	
	self.BagIndex = pStartIndex
	self.EndBagIndex = pEndIndex
	
	self.BagSlotIndex = 0
	
	if pStartIndex == pEndIndex
	or Outfitter:GetBagType(self.BagIndex)== Outfitter.cGeneralBagType then
		self.NumBagSlots = GetContainerNumSlots(self.BagIndex)
	else
		self.NumBagSlots = 0
	end
end

function Outfitter._BagIterator:NextSlot()
	self.BagSlotIndex = self.BagSlotIndex + 1
	
	while self.BagSlotIndex > self.NumBagSlots do
		if self.BagIndex == self.EndBagIndex then
			return false
		end
		
		self.BagIndex = self.BagIndex + self.Direction
		
		self.BagSlotIndex = 1
		
		if Outfitter:GetBagType(self.BagIndex) == Outfitter.cGeneralBagType then
			self.NumBagSlots = GetContainerNumSlots(self.BagIndex)
		else
			self.NumBagSlots = 0
		end
	end
	
	return true
end

function Outfitter:ItemUsesBothWeaponSlots(pItem)
	if not pItem then
		self:DebugMessage("ItemUsesBothWeaponSlots: nil item")
		self:DebugStack()
		return false
	end
	
	if pItem.InvType ~= "INVTYPE_2HWEAPON"then
		return false
	end
	
	if not self.CanDualWield2H then
		return true
	end
	
	if not pItem.SubType then
		self:DebugMessage("ItemUsesBothWeaponSlots: SubType not specified")
		self:DebugTable(pItem, "pItem")
		self:DebugStack()
	end
	
	local vIsDualWieldable2H = pItem.SubType == Outfitter.LBI["Two-Handed Axes"]
	                        or pItem.SubType == Outfitter.LBI["Two-Handed Maces"]
	                        or pItem.SubType == Outfitter.LBI["Two-Handed Swords"]
	
	return not vIsDualWieldable2H
end

function Outfitter:GetItemMetaSlot(pItem)
	if pItem.MetaSlotName == "TwoHandSlot"
	and not self:ItemUsesBothWeaponSlots(pItem) then
		return "Weapon0Slot"
	else
		return pItem.MetaSlotName
	end
end

function Outfitter:GetCompiledOutfit()
	local vCompiledOutfit = self:NewEmptyOutfit()
	
	vCompiledOutfit.SourceOutfit = {}
	
	-- Start with the current inventory
	
	if self.CurrentInventoryOutfit then
		local vItems = self.CurrentInventoryOutfit:GetItems()
		
		for vInventorySlot, vOutfitItem in pairs(vItems) do
			vCompiledOutfit:SetItem(vInventorySlot, vOutfitItem)
			vCompiledOutfit.SourceOutfit[vInventorySlot] = "Equipped"
		end
	end
	
	-- Layer each selected outfit
	
	for vStackIndex, vOutfit in ipairs(Outfitter.OutfitStack.Outfits) do
		local vItems = vOutfit:GetItems()
		
		if vItems then
			for vInventorySlot, vOutfitItem in pairs(vItems) do
				vCompiledOutfit:SetItem(vInventorySlot, vOutfitItem)
				vCompiledOutfit.SourceOutfit[vInventorySlot] = vOutfit:GetName()
			end
		end
	end
	
	-- Make sure the OH slot is marked as empty if a 2H weapon is equipped
	-- and the player can't dual-wield 2H weapons
	
	vCompiledOutfit:AdjustOffhandSlot()
	
	return vCompiledOutfit
end

function Outfitter:GetExpectedOutfit(pExcludeOutfit)
	local vCompiledOutfit = self:NewEmptyOutfit()
	
	vCompiledOutfit.SourceOutfit = {}
	
	for vStackIndex, vOutfit in ipairs(self.OutfitStack.Outfits) do
		if vOutfit ~= pExcludeOutfit then
			local vItems = vOutfit:GetItems()
			
			for vInventorySlot, vOutfitItem in pairs(vItems) do
				vCompiledOutfit:SetItem(vInventorySlot, vOutfitItem)
				vCompiledOutfit.SourceOutfit[vInventorySlot] = vOutfit:GetName()
			end
		end
	end
	
	return vCompiledOutfit
end

function Outfitter:GetBagType(pBagIndex)
	if pBagIndex == 0
	or pBagIndex == -1 then -- special case 0 and -1 since ContainerIDToInventoryID will barf on it
		return Outfitter.cGeneralBagType
	end
	
	if pBagIndex < 0 then
		pBagIndex = 4 - pBagIndex
	end
	
	local vItemLink = GetInventoryItemLink("player", ContainerIDToInventoryID(pBagIndex))
	
	if not vItemLink then
		return nil
	end
	
	return GetItemFamily(vItemLink)
end

function Outfitter:GetEmptyBagSlot(pStartBagIndex, pStartBagSlotIndex, pIncludeBank)
	local vStartBagIndex = pStartBagIndex
	local vStartBagSlotIndex = pStartBagSlotIndex
	
	if not vStartBagIndex then
		vStartBagIndex = NUM_BAG_SLOTS
	end
	
	if not vStartBagSlotIndex then
		vStartBagSlotIndex = 1
	end
	
	local vEndBagIndex = 0
	
	if pIncludeBank then
		vEndBagIndex = -1
	end
	
	for vBagIndex = vStartBagIndex, vEndBagIndex, -1 do
		local vNumEmptySlots, vBagType = GetContainerNumFreeSlots(vBagIndex)
		
		if vNumEmptySlots > 0 then
			local vNumBagSlots = GetContainerNumSlots(vBagIndex)
			
			for vSlotIndex = vStartBagSlotIndex, vNumBagSlots do
				if not GetContainerItemLink(vBagIndex, vSlotIndex) then
					return {BagIndex = vBagIndex, BagSlotIndex = vSlotIndex, BagType = vBagType}
				end
			end
		end
		
		vStartBagSlotIndex = 1
	end
	
	return nil
end

function Outfitter:GetEmptyBagSlotList()
	local vEmptyBagSlots = {}
	
	local vBagIndex = NUM_BAG_SLOTS
	local vBagSlotIndex = 1
	
	while true do
		local vBagSlotInfo = self:GetEmptyBagSlot(vBagIndex, vBagSlotIndex)
		
		if not vBagSlotInfo then
			return vEmptyBagSlots
		end
		
		table.insert(vEmptyBagSlots, vBagSlotInfo)
		
		vBagIndex = vBagSlotInfo.BagIndex
		vBagSlotIndex = vBagSlotInfo.BagSlotIndex + 1
	end
end

function Outfitter:GetEmptyBankSlotList()
	local vEmptyBagSlots = {}
	
	local vBagIndex = NUM_BAG_SLOTS + NUM_BANKBAGSLOTS
	local vBagSlotIndex = 1
	
	while true do
		local vBagSlotInfo = self:GetEmptyBagSlot(vBagIndex, vBagSlotIndex, true)
		
		if not vBagSlotInfo then
			return vEmptyBagSlots
		
		elseif vBagSlotInfo.BagIndex > NUM_BAG_SLOTS
		or vBagSlotInfo.BagIndex < 0 then
			table.insert(vEmptyBagSlots, vBagSlotInfo)
		end
		
		vBagIndex = vBagSlotInfo.BagIndex
		vBagSlotIndex = vBagSlotInfo.BagSlotIndex + 1
	end
end

function Outfitter:FindItemsInBagsForSlot(pSlotName, pIgnoreItems)
	-- Alias the slot names down for finger and trinket
	
	local vInventorySlot = pSlotName
	
	if vInventorySlot == "Finger1Slot" then
		vInventorySlot = "Finger0Slot"
	elseif vInventorySlot == "Trinket1Slot" then
		vInventorySlot = "Trinket0Slot"
	end
	
	--
	
	local vItems = {}
	local vNumBags, vFirstBagIndex = self:GetNumBags()
	
	for vBagIndex = vFirstBagIndex, vNumBags do
		local vNumBagSlots = GetContainerNumSlots(vBagIndex)
		
		if vNumBagSlots > 0 then
			for vSlotIndex = 1, vNumBagSlots do
				local vItemInfo = self:GetBagItemInfo(vBagIndex, vSlotIndex)
				
				if vItemInfo
				and (not pIgnoreItems or not pIgnoreItems[vItemInfo.Code]) then
					local vItemSlotName = vItemInfo.ItemSlotName
					
					if vItemInfo.MetaSlotName then
						vItemSlotName = self:GetItemMetaSlot(vItemInfo)
					end
					
					if vItemSlotName == "TwoHandSlot" then
						vItemSlotName = "MainHandSlot"
					
					elseif vItemSlotName == "Weapon0Slot" then
						if vInventorySlot == "MainHandSlot"
						or vInventorySlot == "SecondaryHandSlot" then
							vItemSlotName = vInventorySlot
						end
					end
					
					if vItemSlotName == vInventorySlot then
						table.insert(vItems, vItemInfo)
					end
				end
			end
		end
	end
	
	if #vItems == 0 then	
		return nil
	end
	
	return vItems
end

function Outfitter:CreateNewOutfit()
	Outfitter.NameOutfitDialog:Open(nil)
end

function Outfitter:NewNakedOutfit(pName)
	local vOutfit = self:NewEmptyOutfit(pName)

	for _, vInventorySlot in ipairs(Outfitter.cSlotNames) do
		vOutfit:AddItem(vInventorySlot, nil)
	end
	
	return vOutfit
end

function Outfitter:NewEmptyItemInfo()
	return
	{
		Name = "",
		Code = 0,
		SubCode = 0,
		EnchantCode = 0,
		JewelCode1 = 0,
		JewelCode2 = 0,
		JewelCode3 = 0,
		JewelCode4 = 0,
		UniqueID = 0,
		InvType = nil,
	}
end

function Outfitter:GetInventoryOutfit(pName, pOutfit)
	local vOutfit
	
	if pOutfit then
		vOutfit = pOutfit
	else
		vOutfit = self:NewEmptyOutfit(pName)
	end
	
	for _, vInventorySlot in ipairs(Outfitter.cSlotNames) do
		local vItemInfo = self:GetInventoryItemInfo(vInventorySlot)
		
		-- To avoid extra memory operations, only update the item if it's different
		
		local vExistingItem = vOutfit:GetItem(vInventorySlot)
		
		if not vItemInfo then
			if not vExistingItem
			or vExistingItem.Code ~= 0 then
				vOutfit:AddItem(vInventorySlot, nil)
			end
		else
			if not vExistingItem
			or vExistingItem.Code ~= vItemInfo.Code
			or vExistingItem.SubCode ~= vItemInfo.SubCode
			or vExistingItem.EnchantCode ~= vItemInfo.EnchantCode 
			or vExistingItem.JewelCode1 ~= vItemInfo.JewelCode1
			or vExistingItem.JewelCode2 ~= vItemInfo.JewelCode2
			or vExistingItem.JewelCode3 ~= vItemInfo.JewelCode3
			or vExistingItem.JewelCode4 ~= vItemInfo.JewelCode4
			or vExistingItem.UniqueID ~= vItemInfo.UniqueID then
				vOutfit:AddItem(vInventorySlot, vItemInfo)
			end
		end
	end
	
	return vOutfit
end

function Outfitter:UpdateOutfitFromInventory(pOutfit, pNewItemsOutfit)
	if not pNewItemsOutfit then
		return
	end
	
	local vNewItems = pNewItemsOutfit:GetItems()
	
	pOutfit:AddNewItems(vNewItems)
	
	self:OutfitSettingsChanged(pOutfit)
end

function Outfitter:SubtractOutfit(pOutfit1, pOutfit2, pCheckAlternateSlots)
	local vInventoryCache = self:GetInventoryCache()
	
	-- Remove items from pOutfit1 if they match the item in pOutfit2
	
	for _, vInventorySlot in ipairs(self.cSlotNames) do
		local vItem1 = pOutfit1:GetItem(vInventorySlot)
		local vItem2 = pOutfit2:GetItem(vInventorySlot)
		
		if vInventoryCache:ItemsAreSame(vItem1, vItem2) then
			pOutfit1:RemoveItem(vInventorySlot)
		elseif pCheckAlternateSlots then
			local vAlternateSlotName = self.cFullAlternateStatSlot[vInventorySlot]
			
			vItem2 = pOutfit2:GetItem(vAlternateSlotName)
			
			if vInventoryCache:ItemsAreSame(vItem1, vItem2) then
				pOutfit1:RemoveItem(vInventorySlot)
			end
		end
	end
end

function Outfitter:OutfitItemsAreSame(pOutfit1, pOutfit2, pCheckAlternateSlots, pIgnoreAmmo)
	local vInventoryCache = self:GetInventoryCache()
	
	local vIgnoreAmmoSlot = pIgnoreAmmo or UnitHasRelicSlot("player")
	
	for _, vInventorySlot in ipairs(Outfitter.cSlotNames) do
		if vInventorySlot ~= "AmmoSlot" or not vIgnoreAmmoSlot then
			local vItem1 = pOutfit1:GetItem(vInventorySlot)
			local vItem2 = pOutfit2:GetItem(vInventorySlot)
			
			if vInventoryCache:ItemsAreSame(vItem1, vItem2) then
				-- do nothing
			elseif pCheckAlternateSlots then
				local vAlternateSlotName = self.cFullAlternateStatSlot[vInventorySlot]
				
				vItem2 = pOutfit2:GetItem(vAlternateSlotName)
				
				if vInventoryCache:ItemsAreSame(vItem1, vItem2) then
					-- do nothing
				else
					return false
				end
			else
				return false
			end
		end
	end
	
	return true
end

function Outfitter:GetNewItemsOutfit(pPreviousOutfit)
	-- Get the current outfit and the list
	-- of equippable items
	
	self.CurrentInventoryOutfit = self:GetInventoryOutfit(self.CurrentInventoryOutfit)
	
	local vInventoryCache = self:GetInventoryCache()
	
	-- Create a temporary outfit from the differences
	
	local vNewItemsOutfit = self:NewEmptyOutfit()
	local vOutfitHasItems = false
	
	for _, vInventorySlot in ipairs(self.cSlotNames) do
		local vCurrentItem = self.CurrentInventoryOutfit:GetItem(vInventorySlot)
		local vPreviousItem = pPreviousOutfit:GetItem(vInventorySlot)
		local vSkipSlot = false
		
		if vInventorySlot == "SecondaryHandSlot" then
			local vMainHandItem = pPreviousOutfit:GetItem("MainHandSlot")
			
			if not vMainHandItem then
				--self:DebugMessage("MainHandItem is nil")
				--self:DebugTable(pPreviousOutfit:GetItems(), "Items")
			end
			
			if self:ItemUsesBothWeaponSlots(vMainHandItem) then
				vSkipSlot = true
			end
		elseif vInventorySlot == "AmmoSlot"
		and (not vCurrentItem or vCurrentItem.Code == 0) then
			vSkipSlot = true
		end
		
		if not vSkipSlot
		and not vInventoryCache:InventorySlotContainsItem(vInventorySlot, vPreviousItem) then
			if self.Debug.NewItems then
				self:DebugMessage("New item in slot %s", tostring(vInventorySlot))
				self:DebugTable(vCurrentItem, "NewItem", 1)
			end
			
			vNewItemsOutfit:SetItem(vInventorySlot, vCurrentItem)
			vOutfitHasItems = true
		end
	end
	
	if not vOutfitHasItems then
		return nil
	end
	
	return vNewItemsOutfit, self.CurrentInventoryOutfit
end

function Outfitter:UpdateTemporaryOutfit(pNewItemsOutfit)
	-- Just return if nothing has changed
	
	if not pNewItemsOutfit then
		return
	end
	
	-- Merge the new items with an existing temporary outfit
	
	local vTemporaryOutfit = Outfitter.OutfitStack:GetTemporaryOutfit()
	local vUsingExistingTempOutfit = false
	
	if vTemporaryOutfit then
		local vNewItems = pNewItemsOutfit:GetItems()
		
		for vInventorySlot, vItem in pairs(vNewItems) do
			vTemporaryOutfit:SetItem(vInventorySlot, vItem)
		end
		
		vUsingExistingTempOutfit = true
	
	-- Otherwise add the new items as the temporary outfit
	
	else
		vTemporaryOutfit = pNewItemsOutfit
	end
	
	-- Subtract out items which are expected to be in the outfit
	
	local vExpectedOutfit = self:GetExpectedOutfit(vTemporaryOutfit)
	
	self:SubtractOutfit(vTemporaryOutfit, vExpectedOutfit)
	
	if vTemporaryOutfit:IsEmpty() then
		if vUsingExistingTempOutfit then
			self:RemoveOutfit(vTemporaryOutfit)
		end
	else
		if not vUsingExistingTempOutfit then
			Outfitter.OutfitStack:AddOutfit(vTemporaryOutfit)
		end
	end
	
	-- Add the new items to the current compiled outfit
	
	local vNewItems = pNewItemsOutfit:GetItems()
	
	if self.Debug.EquipmentChanges then
		self:DebugMessage("Adding new items to temporary outfit")
		self:DebugTable(vNewItems, "NewItems", 2)
	end
	
	for vInventorySlot, vItem in pairs(vNewItems) do
		Outfitter.ExpectedOutfit:SetItem(vInventorySlot, vItem)
	end
end

function Outfitter:SetSlotEnable(pSlotName, pEnable)
	if not self.SelectedOutfit then
		return
	end
	
	if pEnable then
		self.SelectedOutfit:SetInventoryItem(pSlotName)
	else
		self.SelectedOutfit:RemoveItem(pSlotName)
	end
	
	self.DisplayIsDirty = true
end

function Outfitter:GetOutfitByScriptID(pScriptID)
	for vCategoryID, vOutfits in pairs(self.Settings.Outfits) do
		for _, vOutfit in ipairs(vOutfits) do
			if vOutfit.ScriptID == pScriptID then
				return vOutfit
			end
		end
	end
	
	return nil
end

Outfitter.AuraStates =
{
	Dining = false,
	Shadowform = false,
	GhostWolf = false,
	Feigning = false,
	Evocate = false,
	Monkey = false,
	Hawk = false,
	Cheetah = false,
	Pack = false,
	Beast = false,
	Wild = false,
	Viper = false,
	Dragonhawk = false,
	Prowl = false,
}

function Outfitter:GetPlayerAuraStates()
	local vBuffIndex = 1
	
	for vKey, _ in pairs(self.AuraStates) do
		self.AuraStates[vKey] = false
	end
	
	while true do
		local vName, _, vTexture, _, _, _, _, _, _, _, vSpellID = UnitBuff("player", vBuffIndex) 
		
		if not vName then
			return self.AuraStates
		end
		
		--
		
		local vSpecialID = Outfitter.cAuraIconSpecialID[vName]
		local vTextureName
		
		if not vSpecialID then
			_, _, vTextureName = vTexture:find("([^%\\]*)$")
			
			vSpecialID = Outfitter.cAuraIconSpecialID[vTextureName]
		end
		
		if not vSpecialID then
			vSpecialID = self.cSpellIDToSpecialID[vSpellID]
		end
			
		if vSpecialID then
			self.AuraStates[vSpecialID] = true
		
		--
		
		elseif not self.AuraStates.Dining
		and vTextureName:find("INV_Drink") then
			self.AuraStates.Dining = true
		end
		
		vBuffIndex = vBuffIndex + 1
	end
end

function Outfitter:GetBuffTooltipText(pBuffIndex)
	OutfitterTooltip:SetOwner(OutfitterFrame, "ANCHOR_BOTTOMRIGHT", 0, 0)
	OutfitterTooltip:SetUnitBuff("player", pBuffIndex)
	
	local vText1, vText2
	
	if OutfitterTooltipTextLeft1:IsShown() then
		vText1 = OutfitterTooltipTextLeft1:GetText()
	end -- if IsShown

	if OutfitterTooltipTextLeft2:IsShown() then
		vText2 = OutfitterTooltipTextLeft2:GetText()
	end -- if IsShown

	OutfitterTooltip:Hide()
	
	return vText1, vText2
end

function Outfitter:UpdateSwimming()
	self:BeginEquipmentUpdate()
	
	self.EventLib:DispatchEvent("TIMER")
	
	self:UpdateMountedState()
	
	local vSwimming = false
	
	if IsSwimming() then
		vSwimming = true
	end
	
	if not self.SpecialState.Swimming then
		self.SpecialState.Swimming = false
	end
	
	self:SetSpecialOutfitEnabled("Swimming", vSwimming)
	self:EndEquipmentUpdate()
end

function Outfitter:UnitAuraChanged(pEvent, pUnitID)
	if pUnitID ~= "player" then
		return
	end
	
	if self.InCombat then
		self.SchedulerLib:ScheduleUniqueTask(2.0, self.UpdateAuraStates, self)
	else
		self:UpdateAuraStates()
	end
end

function Outfitter:UpdateAuraStates()
	self:BeginEquipmentUpdate()
	
	-- Check for special aura outfits

	local vAuraStates = self:GetPlayerAuraStates()
	
	for vSpecialID, vIsActive in pairs(vAuraStates) do
		if vSpecialID == "Feigning" then
			self.IsFeigning = vIsActive
		end
		
		if not Outfitter.SpecialState[vSpecialID] then
			self.SpecialState[vSpecialID] = false
		end
		
		-- Don't equip the dining outfit if health and mana are almost topped up

		if vSpecialID == "Dining"
		and vIsActive
		and self:PlayerIsFull() then
			vIsActive = false
		end
		
		-- Update the state
		
		self:SetSpecialOutfitEnabled(vSpecialID, vIsActive)
	end
	
	self:UpdateMountedState()
	
	self:EndEquipmentUpdate()
	
	-- Update shapeshift state on aura change too
	-- NOTE: Currently (WoW client 2.3) the shapeshift info isn't
	-- always up-to-date when the AURA event comes in, so update
	-- the shapeshift state after about 1 frame to allow the state to
	-- synch
	
	self.SchedulerLib:ScheduleUniqueTask(0.01, self.UpdateShapeshiftState, self)
end

function Outfitter:UpdateMountedState()
	local vRiding = IsMounted() and not UnitOnTaxi("player")
	
	self:SetSpecialOutfitEnabled("Riding", vRiding)
end

function Outfitter:UpdateShapeshiftState()
	self:BeginEquipmentUpdate()
	
	if not self.Settings.ShapeshiftIndexInfo then
		self.Settings.ShapeshiftIndexInfo = {}
	end
	
	local vNumForms = GetNumShapeshiftForms()
	
	-- Deactivate the previous shapeshift form first
	
	local vActiveForm
	
	for vIndex = 1, vNumForms do
		local vTexture, vName, vIsActive, vIsCastable = GetShapeshiftFormInfo(vIndex)
		
		_, _, vTexture = vTexture:find("([^\\]+)$")
		
		-- self:TestMessage("%s texture = %s (%d) %s", vName, vTexture, vTexture:len(), tern(vIsActive, "ACTIVE", "not active"))
		
		local vShapeshiftInfo = self.cShapeshiftTextureInfo[vTexture]
		
		if vShapeshiftInfo then
			self.Settings.ShapeshiftIndexInfo[vIndex] = vShapeshiftInfo
		else
			vShapeshiftInfo = self.Settings.ShapeshiftIndexInfo[vIndex]
		end
		
		if vShapeshiftInfo then
			if not vIsActive then
				self:UpdateShapeshiftInfo(vShapeshiftInfo, false)
			else
				vActiveForm = vShapeshiftInfo
			end
		end
	end
	
	-- Substitute the druid caster pseudo-form if necessary or deactivate it
	-- if it's not
	
	if self.PlayerClass == "DRUID" then
		if not vActiveForm then
			vActiveForm = self.cShapeshiftTextureInfo.CasterForm
		else
			self:UpdateShapeshiftInfo(self.cShapeshiftTextureInfo.CasterForm, false)
		end
	end
	
	-- Activate the new form
	
	if vActiveForm then
		self:UpdateShapeshiftInfo(vActiveForm, true)
	end
	
	self:EndEquipmentUpdate()
end

function Outfitter:UpdateShapeshiftInfo(pShapeshiftInfo, pIsActive)
	-- Ensure a proper boolean
	
	if pIsActive then
		pIsActive = true
	else
		pIsActive = false
	end
	
	--
	
	if self.SpecialState[pShapeshiftInfo.ID] == nil then
		self.SpecialState[pShapeshiftInfo.ID] = self:WearingOutfitWithScriptID(pShapeshiftInfo.ID)
	end
	
	if self.SpecialState[pShapeshiftInfo.ID] ~= pIsActive then
		if pIsActive and pShapeshiftInfo.MaybeInCombat then
			self.MaybeInCombat = true
		end
		
		self:SetSpecialOutfitEnabled(pShapeshiftInfo.ID, pIsActive)
	end
end

function Outfitter:SetSpecialOutfitEnabled(pSpecialID, pEnable)
	-- Ensure a proper boolean
	
	if pEnable then
		pEnable = true
	else
		pEnable = false
	end
	
	if self.SpecialState[pSpecialID] == pEnable then
		return
	end
	
	-- Suspend or resume monitoring the player health
	-- if the dining outfit is being changed
	
	if pSpecialID == "Dining" and pEnable then
		self.EventLib:RegisterEvent("UNIT_HEALTH", self.UnitHealthOrManaChanged, self, true) -- Register as a blind event handler
	else
		self.EventLib:UnregisterEvent("UNIT_HEALTH", self.UnitHealthOrManaChanged, self)
	end
	
	--
	
	self.SpecialState[pSpecialID] = pEnable
	
	-- Dispatch the special ID events
	
	local vEvents = self.cSpecialIDEvents[pSpecialID]
	
	if vEvents then
		if pEnable then
			self.EventLib:DispatchEvent(vEvents.Equip)
		else
			self.EventLib:DispatchEvent(vEvents.Unequip)
		end
	else
		self:ErrorMessage("No events found for "..pSpecialID)
	end
end

function Outfitter:WearingOutfitWithScriptID(pSpecialID)
	for vIndex, vOutfit in ipairs(self.OutfitStack.Outfits) do
		if vOutfit.ScriptID == pSpecialID then
			return true, vIndex
		end
	end
end

function Outfitter:ScheduleUpdateZone()
	self.SchedulerLib:RescheduleTask(0.01, self.UpdateZone, self)
end

function Outfitter:UpdateZone()
	local vCurrentZone = GetZoneText()
	
	-- Treat Vault of Archavon as its own zone so
	-- that it doesn't register as the Wintergrasp
	-- PvP zone
	
	if vCurrentZone == self.LZ["Wintergrasp"] then
		local vMinimapZone = GetMinimapZoneText()
		
		if vMinimapZone == self.LZ["Vault of Archavon"] then
			vCurrentZone = vMinimapZone
		end
	end
	
	-- Just return if the zone isn't changing
	
	if vCurrentZone == self.CurrentZone then
		return
	end
	
	self.CurrentZone = vCurrentZone
	self.CurrentZoneIDs = self:GetCurrentZoneIDs(self.CurrentZoneIDs)
	
	self:BeginEquipmentUpdate()
	
	--
	
	for _, vSpecialID in ipairs(self.cZoneSpecialIDs) do
		local vIsActive = self.CurrentZoneIDs[vSpecialID] == true
		local vCurrentIsActive = self.SpecialState[vSpecialID]
		
		if vCurrentIsActive == nil then
			vCurrentIsActive = self:WearingOutfitWithScriptID(vSpecialID)
			self.SpecialState[vSpecialID] = vCurrentIsActive
		end
		
		self:SetSpecialOutfitEnabled(vSpecialID, vIsActive)
	end
	
	self:EndEquipmentUpdate()
end

function Outfitter:GetCurrentZoneIDs(pRecycleTable)
	local vZoneIDs = self:RecycleTable(pRecycleTable)
	
	local vZoneSpecialIDMap = self.cZoneSpecialIDMap[self.CurrentZone]
	
	if not vZoneSpecialIDMap then
		vZoneSpecialIDMap = self.cZoneSpecialIDMap[GetRealZoneText()]
	end
	
	local vPVPType, vIsArena, vFactionName = GetZonePVPInfo()
	
	if vZoneSpecialIDMap then
		for _, vZoneSpecialID in ipairs(vZoneSpecialIDMap) do
			if vZoneSpecialID ~= "City" or vPVPType ~= "hostile" then
				vZoneIDs[vZoneSpecialID] = true
			end
		end
	end
	
	return vZoneIDs
end

function Outfitter:InZoneType(pZoneType)
	return self.CurrentZoneIDs[pZoneType] == true
end

function Outfitter:InBattlegroundZone()
	return self:InZoneType("Battleground")
end

function Outfitter:SetAllSlotEnables(pEnable)
	if pEnable then
		self.SelectedOutfit:EnableAllSlots()
	else
		self.SelectedOutfit:DisableAllSlots()
	end
	
	self:OutfitSettingsChanged(self.SelectedOutfit)
	self:Update(true)
end

function Outfitter:OutfitSettingsChanged(pOutfit)
	if not pOutfit then
		return
	end
	
	local vTargetCategoryID = pOutfit:CalculateOutfitCategory()
	
	if pOutfit.CategoryID ~= vTargetCategoryID then
		local vOutfitCategoryID, vOutfitIndex = self:FindOutfit(pOutfit)
		
		if not vOutfitCategoryID then
			self:ErrorMessage(pOutfit:GetName().." not found in outfit list")
			return
		end
		
		if vOutfitCategoryID ~= pOutfit.CategoryID then
			self:DebugMessage("OutfitSettingsChanged: "..pOutfit:GetName().." says it's in "..pOutfit.CategoryID.." but it's in "..vOutfitCategoryID)
		end
		
		table.remove(self.Settings.Outfits[vOutfitCategoryID], vOutfitIndex)
		
		self:AddOutfit(pOutfit)
	end
	
	self.DisplayIsDirty = true
	
	self:DispatchOutfitEvent("EDIT_OUTFIT", pOutfit:GetName(), pOutfit)
end

function Outfitter:DeleteOutfit(pOutfit)
	local vWearingOutfit = self:WearingOutfit(pOutfit)
	
	-- Deselect the outfit
	
	if pOutfit == self.SelectedOutfit then
		self:ClearSelection()
	end
	
	-- Remove the outfit if it's being worn
	
	self:RemoveOutfit(pOutfit)
	self:DeactivateScript(pOutfit)
	
	local vOutfitCategoryID, vOutfitIndex = self:FindOutfit(pOutfit)
	
	if not vOutfitCategoryID then
		return
	end
	
	-- Delete the outfit
	
	table.remove(self.Settings.Outfits[vOutfitCategoryID], vOutfitIndex)
	
	pOutfit:Delete()

	--
	
	self.DisplayIsDirty = true
	
	self:DispatchOutfitEvent("DELETE_OUTFIT", pOutfit:GetName(), pOutfit)
end

function Outfitter:AddOutfit(pOutfit)
	local vCategoryID
	
	vCategoryID = pOutfit:CalculateOutfitCategory()
	
	if not self.Settings.Outfits then
		self.Settings.Outfits = {}
	end
	
	if not self.Settings.Outfits[vCategoryID] then
		self.Settings.Outfits[vCategoryID] = {}
	end
	
	table.insert(self.Settings.Outfits[vCategoryID], pOutfit)
	pOutfit.CategoryID = vCategoryID
	
	self.DisplayIsDirty = true
	
	self:DispatchOutfitEvent("ADD_OUTFIT", pOutfit:GetName(), pOutfit)
	
	return vCategoryID
end

function Outfitter:SlotEnableClicked(pCheckbox, pButton)
	-- If the user is attempting to drop an item put it in the slot for them
	
	if CursorHasItem() then
		PickupInventoryItem(self.cSlotIDs[pCheckbox.SlotName])
		return
	end
	
	--
	
	local vChecked = pCheckbox:GetChecked()
	
	if pCheckbox.IsUnknown then
		pCheckbox.IsUnknown = false
		pCheckbox:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
		vChecked = true
	end
	
	self:SetSlotEnable(pCheckbox.SlotName, vChecked)
	self:OutfitSettingsChanged(self.SelectedOutfit)
	self:Update(true)
end

function Outfitter:FindMultipleItemLocation(pItems, pInventoryCache)
	for vListIndex, vListItem in ipairs(pItems) do
		local vItem = pInventoryCache:FindItemOrAlt(vListItem)
		
		if vItem then
			return vItem, vListItem
		end
	end
	
	return nil, nil
end

function Outfitter:FindAndAddItemsToOutfit(pOutfit, pSlotName, pItems, pInventoryCache)
	vItemLocation, vItem = self:FindMultipleItemLocation(pItems, pInventoryCache)
	
	if vItemLocation then
		local vInventorySlot = pSlotName
		
		if not vInventorySlot then
			vInventorySlot = vItemLocation.ItemSlotName
		end
		
		pOutfit:AddItem(vInventorySlot, vItem)
	end
end

function Outfitter:IsInitialized()
	return self.Initialized
end

function Outfitter:InitializationCheck()
	-- Don't initialize for a short time after WoW comes up to allow
	-- time for WoW to load inventory, bags, talent trees, etc.
	
	self.SchedulerLib:RescheduleTask(1, self.Initialize, self)
end

function Outfitter:Initialize()
	if self.Initialized then
		return
	end
	
	-- Unregister the initialization events
	
	for vEventID, _ in pairs(self.cInitializationEvents) do
		self.EventLib:UnregisterEvent(vEventID, self.InitializationCheck, self)
	end
	
	-- Makes sure they're not upgrading with a reloadui when there are new files
	
	if not self._QuickSlots
	or not self._OutfitIterator
	or not self.BuildEquipmentChangeList
	or not self._AboutView
	or not self.New then
		OutfitterMinimapButton:Hide() -- Remove access to Outfitter so more errors don't start coming up
		OutfitterButtonFrame:Hide()
		StaticPopup_Show("OUTFITTER_CANT_RELOADUI")
		return
	end
	
	-- Get the basic player info
	
	self.PlayerName = UnitName("player")
	self.RealmName = GetRealmName()
	
	local _, vPlayerClass = UnitClass("player")
	
	self.PlayerClass = vPlayerClass
	
	-- Swap in the Horde Lance for the Alliance Lance mapping
	
	if UnitFactionGroup("player") == "Horde" then
		Outfitter.cItemAliases[46106] = 46070 -- Argent Lance -> Horde Lance
	end
	
	--
	
	if not gOutfitter_GlobalSettings then
		self:InitializeGlobalSettings()
	end
	
	if (self.Douchebags[self.RealmName]
	and self.Douchebags[self.RealmName][self.PlayerName])
	or gOutfitter_GlobalSettings.Banned then
		gOutfitter_GlobalSettings.Banned = true
		
		OutfitterMinimapButton:Hide()
		OutfitterButtonFrame:Hide()
		self:ErrorMessage("Your character is banned from Outfitter.  Use something else for your gear management.")
		return
	end

	self.MenuManager = self:New(self._MenuManager)
	-- self.MenuManager:Test()
	
	--
	
	-- Initialize the main UI tabs
	
	self._SidebarWindowFrame.Construct(OutfitterFrame)
	
	PanelTemplates_SetNumTabs(OutfitterFrame, #self.cPanelFrames)
	OutfitterFrame.selectedTab = self.CurrentPanel
	PanelTemplates_UpdateTabs(OutfitterFrame)
	
	-- Install the /outfit command handler

	SlashCmdList.OUTFITTER = function (pCommand) Outfitter:ExecuteCommand(pCommand) end
	SLASH_OUTFITTER1 = "/outfitter"
	
	if not SlashCmdList.UNEQUIP then
		SlashCmdList.UNEQUIP = self.UnequipItemByName
		SLASH_UNEQUIP1 = "/unequip"
	end
	
	-- Initialize the slot ID map
	
	self.cSlotIDs = {}
	self.cSlotIDToInventorySlot = {}
		
	for _, vInventorySlot in ipairs(self.cSlotNames) do
		local vSlotID = GetInventorySlotInfo(vInventorySlot)
		
		self.cSlotIDs[vInventorySlot] = vSlotID
		self.cSlotIDToInventorySlot[vSlotID] = vInventorySlot
	end
	
	-- Initialize the settings
	
	if not gOutfitter_Settings then
		self:InitializeSettings()
	else
		self.Settings = gOutfitter_Settings
	end
	
	-- Initialize the outfits
	
	self.CurrentOutfit = self:GetInventoryOutfit()
	
	if not self.Settings.Outfits then
		self:InitializeOutfits()
	end
	
	self:AttachOutfitMethods()
	self:CheckDatabase()
	
	-- Initialize the outfit stack
	
	self.OutfitStack:Initialize()
	
	-- Clean up any recent complete outfits which don't exist as
	-- well as duplicate entries
	
	local vUsedRecentNames = {}
	
	for vIndex = #self.Settings.RecentCompleteOutfits, 1, -1 do
		local vName = self.Settings.RecentCompleteOutfits[vIndex]
		
		if not self:FindOutfitByName(vName)
		or vUsedRecentNames[vName] then
			table.remove(self.Settings.RecentCompleteOutfits, vIndex)
		else
			vUsedRecentNames[vName] = true
		end
	end
	
	-- Set the minimap button
	
	if self.Settings.Options.HideMinimapButton then
		OutfitterMinimapButton:Hide()
	else
		OutfitterMinimapButton:Show()
	end
	
	if not self.Settings.Options.MinimapButtonAngle
	and not self.Settings.Options.MinimapButtonX then
		self.Settings.Options.MinimapButtonAngle = -1.5708
	end
	
	if self.Settings.Options.MinimapButtonAngle then
		self.MinimapButton_SetPositionAngle(self.Settings.Options.MinimapButtonAngle)
	else
		self.MinimapButton_SetPosition(self.Settings.Options.MinimapButtonX, self.Settings.Options.MinimapButtonY)
	end
	
	self.NameOutfitDialog = Outfitter:New(Outfitter._NameOutfitDialog, OutfitterFrame)
	self.RebuildOutfitDialog = Outfitter:New(Outfitter._RebuildOutfitDialog, OutfitterFrame)
	
	-- Move the Equipment Manager button in case the user wants to use both
	
	GearManagerToggleButton:ClearAllPoints()
	if self.IsWoW4 then
		GearManagerToggleButton:SetPoint("TOPLEFT", PaperDollFrame, "TOPLEFT", 63, -28)
		-- FIXME: This needs to be in the XML file for 4.0, but for now
		-- it's just patched at runtime
		OutfitterButton:ClearAllPoints()
		OutfitterButton:SetPoint("TOPRIGHT", OutfitterButtonFrame, "TOPRIGHT", 0, -27)
		OutfitterFrame:ClearAllPoints()
		OutfitterFrame:SetPoint("TOPLEFT", OutfitterButtonFrame, "TOPRIGHT", 0, -30)
	else
		GearManagerToggleButton:SetPoint("TOPLEFT", PaperDollFrame, "TOPLEFT", 70, -39)
	end
	
	-- Initialize player state
	
	self.SpiritRegenEnabled = true
	
	-- Done initializing
	
	self.Initialized = true
	
	-- Make sure the outfit state is good
	
	self:SetSpecialOutfitEnabled("Riding", false)
	self:SetSpecialOutfitEnabled("Spirit", false)
	self:UpdateAuraStates()
	
	-- Start listening for events
	
	self.EventLib:RegisterEvent("PLAYER_ENTERING_WORLD", self.SchedulePlayerEnteringWorld, self)
	self.EventLib:RegisterEvent("PLAYER_LEAVING_WORLD", self.PlayerLeavingWorld, self)
	
	-- For monitoring mounted, dining and shadowform states
	
	self.EventLib:RegisterEvent("UNIT_AURA", self.UnitAuraChanged, self)
	
	hooksecurefunc("ShapeshiftBar_UpdateState", function () Outfitter.SchedulerLib:ScheduleUniqueTask(0.01, self.UpdateShapeshiftState, self) end)
	
	-- For monitoring plaguelands and battlegrounds
	
	self.EventLib:RegisterEvent("ZONE_CHANGED_NEW_AREA", self.ScheduleUpdateZone, self)
	self.EventLib:RegisterEvent("ZONE_CHANGED", self.ScheduleUpdateZone, self)
	self.EventLib:RegisterEvent("ZONE_CHANGED_INDOORS", self.ScheduleUpdateZone, self)
	
	-- For monitoring player combat state
	
	self.EventLib:RegisterEvent("PLAYER_REGEN_ENABLED", self.RegenEnabled, self)
	self.EventLib:RegisterEvent("PLAYER_REGEN_DISABLED", self.RegenDisabled, self)
	
	-- For monitoring player dead/alive state
	
	self.EventLib:RegisterEvent("PLAYER_DEAD", self.PlayerDead, self)
	self.EventLib:RegisterEvent("PLAYER_ALIVE", self.PlayerAlive, self)
	self.EventLib:RegisterEvent("PLAYER_UNGHOST", self.PlayerAlive, self)
	
	self.EventLib:RegisterEvent("UNIT_INVENTORY_CHANGED", self.UnitInventoryChanged, self, true) -- Register as a blind event handler (no event id param)
	self.EventLib:RegisterEvent("OUTFITTER_INVENTORY_CHANGED", self.InventoryChanged, self, true) -- Register as a blind event handler (no event id param)

	-- For indicating which outfits are missing items
	
	self.EventLib:RegisterEvent("BAG_UPDATE", self.BagUpdate, self)
	self.EventLib:RegisterEvent("PLAYERBANKSLOTS_CHANGED", self.BankSlotsChanged, self)
	
	-- For monitoring bank bags
	
	self.EventLib:RegisterEvent("BANKFRAME_OPENED", self.BankFrameOpened, self)
	self.EventLib:RegisterEvent("BANKFRAME_CLOSED", self.BankFrameClosed, self)
	
	-- For unequipping the dining outfit
	
	self.EventLib:RegisterEvent("UNIT_MANA", self.UnitHealthOrManaChanged, self, true) -- Register as a blind event handler (no event id param)
	
	-- For monitoring spellcasts
	
--[[
	for _, vEventID in ipairs({
		"UNIT_SPELLCAST_CHANNEL_START",
		"UNIT_SPELLCAST_CHANNEL_STOP",
		"UNIT_SPELLCAST_CHANNEL_UPDATE",
		"UNIT_SPELLCAST_DELAYED",
		"UNIT_SPELLCAST_FAILED",
		"UNIT_SPELLCAST_FAILED_QUIET",
		"UNIT_SPELLCAST_INTERRUPTED",
		"UNIT_SPELLCAST_SENT",
		"UNIT_SPELLCAST_START",
		"UNIT_SPELLCAST_STOP",
		"UNIT_SPELLCAST_SUCCEEDED",
		"UNIT_SPELLMISS"
	}) do
		self.EventLib:RegisterEvent(vEventID, self.UnitSpellcastDebug, self)
	end
]]
	
	self.EventLib:RegisterEvent("UNIT_SPELLCAST_SENT", self.UnitSpellcastSent, self)
	self.EventLib:RegisterEvent("UNIT_SPELLCAST_START", self.UnitSpellcastSent, self)
	
	self.EventLib:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED", self.UnitSpellcastStop, self)
	self.EventLib:RegisterEvent("UNIT_SPELLCAST_STOP", self.UnitSpellcastStop, self)
	
	self.EventLib:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START", self.UnitSpellcastChannelStart, self)
	self.EventLib:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP", self.UnitSpellcastChannelStop, self)
	
	self.EventLib:RegisterEvent("UNIT_SPELLCAST_FAILED", self.UnitSpellcastStop, self)
	self.EventLib:RegisterEvent("UNIT_SPELLCAST_FAILED_QUIET", self.UnitSpellcastStop, self)
	self.EventLib:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", self.UnitSpellcastStop, self)
	
	--
	
	self.EventLib:RegisterEvent("CHARACTER_POINTS_CHANGED", self.TalentsChanged, self)
	self.EventLib:RegisterEvent("PLAYER_TALENT_UPDATE", self.TalentsChanged, self)
	
	self:TalentsChanged()
	
	-- Patch GameTooltip so we can monitor hide/show events
	
	self:HookScript(GameTooltip, "OnShow", self.GameToolTip_OnShow)
	self:HookScript(GameTooltip, "OnHide", self.GameToolTip_OnHide)
	
	-- Patch MobInfo tooltip since it replaces the GameToolTip (blech)
	
	if MI2_TooltipFrame then
		self:HookScript(MI2_TooltipFrame, "OnShow", self.GameToolTip_OnShow)
		self:HookScript(MI2_TooltipFrame, "OnHide", self.GameToolTip_OnHide)
	end
	
	-- Synchronize with the Equipment Manager
	
	self.EventLib:RegisterEvent("EQUIPMENT_SETS_CHANGED", self.SynchronizeEM, self)
	
	--
	
	self:DispatchOutfitEvent("OUTFITTER_INIT")
	
	self.SchedulerLib:ScheduleUniqueRepeatingTask(0.5, self.UpdateSwimming, self, nil, "Outfitter:UpdateSwimming")
	
	-- Activate all outfit scripts
	
	if not self.Settings.Options.DisableAutoSwitch then
		self:ActivateAllScripts()
	end
	
	-- Install the "Used by outfits" tooltip feature
	
	GameTooltip.Outfitter_OrigSetBagItem = GameTooltip.SetBagItem
	GameTooltip.SetBagItem = self.GameTooltip_SetBagItem
	
	GameTooltip.Outfitter_OrigSetInventoryItem = GameTooltip.SetInventoryItem
	GameTooltip.SetInventoryItem = self.GameTooltip_SetInventoryItem
	
	GameTooltip.Outfitter_OrigSetHyperlink = GameTooltip.SetHyperlink
	GameTooltip.SetHyperlink = self.GameTooltip_SetHyperlink
	
	-- Install the item compare tooltips
	
	if not self.Settings.Options.DisableItemComparisons then
		self.ExtendedCompareTooltip = Outfitter:New(Outfitter._ExtendedCompareTooltip)
	end
	
	-- Fire things up with a simulated entrance
	
	self:SchedulePlayerEnteringWorld()
end

function Outfitter:InitializeSettings()
	gOutfitter_Settings =
	{
		Version = 18,
		Options = {},
		LastOutfitStack = {},
		LayerIndex = {},
		RecentCompleteOutfits = {},
	}
	
	self.Settings = gOutfitter_Settings
	
	self.OutfitBar:InitializeSettings()
end

function Outfitter:InitializeGlobalSettings()
	gOutfitter_GlobalSettings =
	{
		Version = 1,
		SavedScripts = {},
	}
end

function Outfitter:AttachOutfitMethods()
	for vCategoryID, vOutfits in pairs(self.Settings.Outfits) do
		for vIndex, vOutfit in ipairs(vOutfits) do
			if vOutfit.StoredInEM then
				setmetatable(vOutfit, Outfitter._OutfitMetaTableEM)
			else
				setmetatable(vOutfit, Outfitter._OutfitMetaTable)
			end
		end
	end
end

function Outfitter:SynchronizeEM()
	local vNumEMOutfits = GetNumEquipmentSets()
	
	-- Mark all the EM outfits as unused
	
	for vCategoryID, vOutfits in pairs(self.Settings.Outfits) do
		for vIndex, vOutfit in ipairs(vOutfits) do
			if vOutfit.StoredInEM then
				vOutfit.Unused = true
			end
		end
	end
	
	-- If NumEquipmentSets is zero, assume that the EM is flaking out
	-- and save the EM-based outfits so they can be restored if the EM
	-- happens to straighten up later
	
	if vNumEMOutfits == 0 then
		if not self.Settings.PreservedEMOutfits then
			self.Settings.PreservedEMOutfits = {}
		end
		
		for vCategoryID, vOutfits in pairs(self.Settings.Outfits) do
			for vIndex, vOutfit in ipairs(vOutfits) do
				if vOutfit.StoredInEM then
					self.Settings.PreservedEMOutfits[vOutfit.Name] = vOutfit
				end
			end
		end
	end
	
	-- Scan the EM outfits
	
	for vIndex = 1, vNumEMOutfits do
		local vName = GetEquipmentSetInfo(vIndex)
		local vOutfit = self:FindEMOutfitByName(vName)
		
		-- If the outfit is missing, see if it can be restored from
		-- the preserved list
		
		if not vOutfit
		and self.Settings.PreservedEMOutfits then
			vOutfit = self.Settings.PreservedEMOutfits[vName]
			
			if vOutfit then
				setmetatable(vOutfit, Outfitter._OutfitMetaTableEM)
				self:AddOutfit(vOutfit)
				
				Outfitter:ActivateScript(vOutfit)
			end
		end
		
		if not vOutfit then
			vOutfit =
			{
				Name = vName,
				StoredInEM = true,
				Items = {},
			}
			
			setmetatable(vOutfit, Outfitter._OutfitMetaTableEM)
			
			self:AddOutfit(vOutfit)
		else
			vOutfit.Unused = nil
		end
	end
	
	-- Delete unused outfits
	
	for vCategoryID, vOutfits in pairs(self.Settings.Outfits) do
		local vNumOutfits = #vOutfits
		local vIndex = 1
		
		while vIndex <= vNumOutfits do
			local vOutfit = vOutfits[vIndex]
			
			if vOutfit.StoredInEM and vOutfit.Unused then
				Outfitter:DeactivateScript(vOutfit)
				
				table.remove(vOutfits, vIndex)
				vNumOutfits = vNumOutfits - 1
			else
				vIndex = vIndex + 1
			end
		end
	end
	
	-- If NumEquipmentSets is not zero, assume that the EM is working correctly
	-- and get rid of any preserved outfits
	
	if vNumEMOutfits > 0 then
		self.Settings.PreservedEMOutfits = nil
	end
	
	-- Done
	
	self.DisplayIsDirty = true
end

function Outfitter:FindEMOutfitByName(pName)
	local vLowerName = pName:lower()
	
	for vCategoryID, vOutfits in pairs(self.Settings.Outfits) do
		for vIndex, vOutfit in ipairs(vOutfits) do
			if vOutfit.StoredInEM
			and vOutfit.Name:lower() == vLowerName then
				return vOutfit
			end
		end
	end
end

function Outfitter:InitializeOutfits()
	local vOutfit, vItemLocation, vItem
	local vInventoryCache = Outfitter:GetInventoryCache()
	
	-- Create the outfit categories
	
	self.Settings.Outfits = {}
	
	for vCategoryIndex, vCategoryID in ipairs(Outfitter.cCategoryOrder) do
		self.Settings.Outfits[vCategoryID] = {}
	end

	-- Create the normal outfit using the current
	-- inventory and set it as the currently equipped outfit
	
	vOutfit = Outfitter:GetInventoryOutfit(Outfitter.cNormalOutfit)
	Outfitter:AddOutfit(vOutfit)
	self.Settings.LastOutfitStack = {{Name = Outfitter.cNormalOutfit}}
	Outfitter.OutfitStack.Outfits = {vOutfit}
	
	-- Create the naked outfit
	
	vOutfit = Outfitter:NewNakedOutfit(Outfitter.cNakedOutfit)
	Outfitter:AddOutfit(vOutfit)
	
	-- Generate the smart outfits
	
	for vSmartIndex, vSmartOutfit in ipairs(Outfitter.cSmartOutfits) do
		vOutfit = Outfitter:GenerateSmartOutfit(vSmartOutfit.Name, vSmartOutfit.StatID, vInventoryCache)
		
		if vOutfit then
			vOutfit.ScriptID = vSmartOutfit.ScriptID
			Outfitter:AddOutfit(vOutfit)
		end
	end
	
	Outfitter:InitializeSpecialOccasionOutfits()
end

function Outfitter:CreateEmptySpecialOccasionOutfit(pScriptID, pName)
	vOutfit = Outfitter:GetOutfitByScriptID(pScriptID)
	
	if vOutfit then
		return
	end
	
	vOutfit = Outfitter:NewEmptyOutfit(pName)
	vOutfit.ScriptID = pScriptID
	
	Outfitter:AddOutfit(vOutfit)
end

function Outfitter:InitializeSpecialOccasionOutfits()
	local vInventoryCache = self:GetInventoryCache()
	local vOutfit
	
	-- Find an argent dawn trinket and set the argent dawn outfit
	--[[ Taking this out since post-TBC it's largely irrelevant
	vOutfit = self:GetOutfitByScriptID("ArgentDawn")
	
	if not vOutfit then
		vOutfit = self:GenerateSmartOutfit(Outfitter.cArgentDawnOutfit, "ArgentDawn", vInventoryCache, true)
		vOutfit.ScriptID = "ArgentDawn"
		Outfitter:AddOutfit(vOutfit)
	end
	]]--
	-- Find riding items
	
	vOutfit = Outfitter:GetOutfitByScriptID("Riding")
	
	if not vOutfit then
		vOutfit = Outfitter:GenerateSmartOutfit(Outfitter.cRidingOutfit, "MOUNT_SPEED", vInventoryCache, true)
		vOutfit.ScriptID = "Riding"
		vOutfit.ScriptSettings = {}
		vOutfit.ScriptSettings.DisableBG = true -- Default to disabling in BGs since that appears to be the most popular
		Outfitter:AddOutfit(vOutfit)
	end
	
	-- Create the Battlegrounds outfits
	
	Outfitter:CreateEmptySpecialOccasionOutfit("Battleground", Outfitter.cBattlegroundOutfit)
	
	-- Create the swimming outfit
	
	Outfitter:CreateEmptySpecialOccasionOutfit("Swimming", Outfitter.cSwimmingOutfit)
	
	-- Create class-specific outfits
	
	Outfitter:InitializeClassOutfits()
end

function Outfitter:InitializeClassOutfits()
	local vOutfits = Outfitter.cClassSpecialOutfits[Outfitter.PlayerClass]
	
	if not vOutfits then
		return
	end
	
	for vIndex, vOutfitInfo in ipairs(vOutfits) do
		Outfitter:CreateEmptySpecialOccasionOutfit(vOutfitInfo.ScriptID, vOutfitInfo.Name)
	end
end

Outfitter.cDeformat =
{
	s = "(.-)",
	d = "(-?[%d]+)",
	f = "(-?[%d%.]+)",
	g = "(-?[%d%.]+)",
	["%"] = "%%",
}

function Outfitter:ConvertFormatStringToSearchPattern(pFormat)
	local vFormat = pFormat:gsub(
			"[%[%]%.]",
			function (pChar) return "%"..pChar end)
	
	return vFormat:gsub(
			"%%[%-%d%.]-([sdgf%%])",
			self.cDeformat)
end

function Outfitter:FindTooltipLine(pTooltip, pText, pPlain)
	local vTooltipName = pTooltip:GetName()
	
	for vLineIndex = 1, 100 do
		local vLeftTextFrame = _G[vTooltipName.."TextLeft"..vLineIndex]
		
		if not vLeftTextFrame then
			break
		end
		
		local vLeftText = vLeftTextFrame:GetText()
		
		if vLeftText
		and vLeftText:find(pText, nil, pPlain) then
			return vLineIndex, vLeftTextFrame
		end
	end -- for vLineIndex
end

function Outfitter:CanEquipBagItem(pBagIndex, pBagSlotIndex)
	local vItemCode,
	      vItemEnchantCode,
	      vItemJewelCode1,
	      vItemJewelCode2,
	      vItemJewelCode3,
	      vItemJewelCode4,
	      vItemSubCode,
	      vItemUniqueID,
	      vItemUnknownCode1,
	      vItemName,
	      vItemFamilyName,
	      vItemLink,
	      vItemQuality,
	      vItemLevel,
	      vItemMinLevel,
	      vItemType,
	      vItemSubType,
	      vItemCount,
	      vItemInvType = self:GetExtendedBagItemLinkInfo(pBagIndex, pBagSlotIndex)
	
	return Outfitter.cInvTypeToSlotName[vItemInvType] ~= nil
	       and (not vItemMinLevel or UnitLevel("player") >= vItemMinLevel)
end

function Outfitter:BagItemWillBind(pBagIndex, pBagSlotIndex)
	local vItemLink = GetContainerItemLink(pBagIndex, pBagSlotIndex)
	
	if not vItemLink then
		return nil
	end
	
	OutfitterTooltip:SetOwner(OutfitterFrame, "ANCHOR_BOTTOMRIGHT", 0, 0)
	OutfitterTooltip:SetBagItem(pBagIndex, pBagSlotIndex)
	
	local vIsBOE = self:FindTooltipLine(OutfitterTooltip, ITEM_BIND_ON_EQUIP, true) ~= nil
	
	OutfitterTooltip:Hide()
	
	return vIsBOE
end

function Outfitter:ArrayIsEmpty(pArray)
	if not pArray then
		return true
	end
	
	return next(pArray) == nil
end

----------------------------------------
Outfitter._NameOutfitDialog = {}
----------------------------------------

function Outfitter._NameOutfitDialog:New(pParent)
	return Outfitter:New(Outfitter.UIElementsLib._ModalDialogFrame, pParent, Outfitter._cNewOutfit, 315, 207)
end

function Outfitter._NameOutfitDialog:Construct(pParent)
	self:Hide()
	
	--self:SetTopLevel(true)
	self:SetFrameStrata("DIALOG")
	self:EnableMouse(true)
	
	-- Controls
	
	self.InfoSection = Outfitter:New(Outfitter.UIElementsLib._Section, self, Outfitter.cInfo)
	self.BuildSection = Outfitter:New(Outfitter.UIElementsLib._Section, self, Outfitter.cBuild)
	self.StatsSection = Outfitter:New(Outfitter.UIElementsLib._Section, self, Outfitter.cStats)
	
	self.Name = Outfitter:New(Outfitter.UIElementsLib._EditBox, self.InfoSection, Outfitter.cNameLabel, 40, 170)
	
	self.ScriptMenu = Outfitter:New(Outfitter.UIElementsLib._DropDownMenu, self.InfoSection, function (...) self:ScriptMenuFunc(...) end)
	self.ScriptMenu:SetTitle(Outfitter.cAutomationLabel)
	
	self.EmptyOutfitCheckButton = Outfitter:New(Outfitter.UIElementsLib._CheckButton, self.BuildSection, Outfitter.cUseEmptyOutfit, true)
	self.ExistingOutfitCheckButton = Outfitter:New(Outfitter.UIElementsLib._CheckButton, self.BuildSection, Outfitter.cUseCurrentOutfit, true)
	self.GenerateOutfitCheckButton = Outfitter:New(Outfitter.UIElementsLib._CheckButton, self.BuildSection, Outfitter.cCreateUsingTitle, true)
	
	self.MultiStatConfig = Outfitter:New(Outfitter._MultiStatConfig, self.StatsSection)
	
	self.Error = self:CreateFontString(nil, "ARTWORK", "GameFontRed")
	
	-- Layout
	
	self:SetPoint("TOPLEFT", OutfitterFrame, "TOPLEFT", 20, -40)
	
	-- Info section
	
	self.InfoSection:SetPoint("TOPLEFT", self, "TOPLEFT", 20, -25)
	self.InfoSection:SetWidth(295)
	self.InfoSection:SetHeight(100)
	
	self.Name:SetPoint("TOPLEFT", self.InfoSection, "TOPLEFT", 100, -20)
	
	self.ScriptMenu:SetPoint("TOPLEFT", self.Name, "TOPLEFT", 0, -35)
	self.ScriptMenu:SetWidth(170)
	
	-- Build section
	
	self.BuildSection:SetPoint("TOPLEFT", self.InfoSection, "TOPRIGHT", 10, 0)
	self.BuildSection:SetPoint("BOTTOM", self.InfoSection, "BOTTOM")
	self.BuildSection:SetPoint("RIGHT", self, "RIGHT", -20, 0)
	
	self.EmptyOutfitCheckButton:SetPoint("TOPLEFT", self.BuildSection, "TOPLEFT", 30, -23)
	self.ExistingOutfitCheckButton:SetPoint("TOPLEFT", self.EmptyOutfitCheckButton, "TOPLEFT", 0, -25)
	self.GenerateOutfitCheckButton:SetPoint("TOPLEFT", self.ExistingOutfitCheckButton, "TOPLEFT", 0, -25)
	
	-- Stats section
	
	self.StatsSection:SetPoint("TOPLEFT", self.InfoSection, "BOTTOMLEFT", 0, -10)
	self.StatsSection:SetPoint("RIGHT", self.BuildSection, "RIGHT", 0, 0)
	
	self.MultiStatConfig:SetPoint("TOPLEFT", self.StatsSection, "TOPLEFT", 25, -15)
	
	-- Error message
	
	self.Error:Hide()
	self.Error:SetWidth(280)
	self.Error:SetPoint("RIGHT", self.DoneButton, "LEFT", -30, 0)
	
	-- Events
	
	self:SetScript("OnShow", function (self) Outfitter.UIElementsLib:BeginDialog(self) end)
	self:SetScript("OnHide", function (self) Outfitter.UIElementsLib:EndDialog(self) end)
	
	self.Name:SetScript("OnEnterPressed", function (self) self:Done() end)
	self.Name:SetScript("OnTextChanged", function () self:Update() end)
	
	self.ScriptMenu.ItemClickedFunc = function (pMenu, pValue)
		self:PresetScriptChanged(pMenu, pValue)
	end
	
	self.EmptyOutfitCheckButton:SetScript("OnClick", function (pCheckButton)
		self.EmptyOutfitCheckButton:SetChecked(true)
		self.ExistingOutfitCheckButton:SetChecked(false)
		self.GenerateOutfitCheckButton:SetChecked(false)
		self.MultiStatConfig:Hide()
		self:AdjustSize()
	end)
	
	self.ExistingOutfitCheckButton:SetScript("OnClick", function (pCheckButton)
		self.EmptyOutfitCheckButton:SetChecked(false)
		self.ExistingOutfitCheckButton:SetChecked(true)
		self.GenerateOutfitCheckButton:SetChecked(false)
		self.MultiStatConfig:Hide()
		self:AdjustSize()
	end)
	
	self.GenerateOutfitCheckButton:SetScript("OnClick", function (pCheckButton)
		self.EmptyOutfitCheckButton:SetChecked(false)
		self.ExistingOutfitCheckButton:SetChecked(false)
		self.GenerateOutfitCheckButton:SetChecked(true)
		self.MultiStatConfig:Show()
		self:AdjustSize()
	end)
	
	self.MultiStatConfig.OnNumLinesChanged = function (pMultiStatConfig, pNumLines)
		self:AdjustSize()
	end
end

function Outfitter._NameOutfitDialog:Open(pOutfit)
	self.OutfitToRename = pOutfit
	
	if self.OutfitToRename then
		self.Title:SetText(Outfitter.cRenameOutfit)
		
		self.Name:SetText(self.OutfitToRename.Name)
		
	else
		self.Title:SetText(Outfitter.cNewOutfit)
		
		self.Name:SetText("")
		
		self.ScriptMenu:SetSelectedValue("NONE")
		
		self.EmptyOutfitCheckButton:SetChecked(false)
		self.ExistingOutfitCheckButton:SetChecked(true)
		self.GenerateOutfitCheckButton:SetChecked(false)
		
		self.MultiStatConfig:SetConfig(nil)
		self.MultiStatConfig:Hide()
	end
	
	self:AdjustSize()
	self:Show()
	self.Name:SetFocus()
end

function Outfitter._NameOutfitDialog:AdjustSize()
	local vHeight = 78
	local vWidth = 335
	
	if not self.OutfitToRename then
		self.ScriptMenu:Show()
		self.InfoSection:SetHeight(100)
		
		vHeight = vHeight + 100
		
		vWidth = vWidth + 200
		
		if self.MultiStatConfig:IsShown() then
			local vStatConfigHeight = self.MultiStatConfig:GetHeight()
			
			vHeight = vHeight + vStatConfigHeight + 33
			
			local vStatWidth = 20 + self.MultiStatConfig:GetWidth() + 20
			
			if vStatWidth > vWidth then
				vWidth = vStatWidth
			end
			
			self.StatsSection:SetHeight(vStatConfigHeight + 25)
			self.StatsSection:Show()
		else
			self.StatsSection:Hide()
		end
		
		self.BuildSection:Show()
	else
		self.ScriptMenu:Hide()
		self.InfoSection:SetHeight(65)
		
		vHeight = vHeight + 65
		
		self.BuildSection:Hide()
		self.StatsSection:Hide()
	end
	
	self:SetWidth(vWidth)
	self:SetHeight(vHeight)
end

function Outfitter._NameOutfitDialog:ScriptMenuFunc(pMenu)
	if UIDROPDOWNMENU_MENU_LEVEL == 2 then
		for _, vPresetScript in ipairs(Outfitter.PresetScripts) do
			if not vPresetScript.Class
			or vPresetScript.Class == Outfitter.PlayerClass then
				local vCategory = vPresetScript.Category or vPresetScript.Class or "GENERAL"
				
				if vCategory == UIDROPDOWNMENU_MENU_VALUE then
					pMenu:AddNormalItem(vPresetScript.Name, vPresetScript.ID)
					-- TODO: tooltipText = Outfitter:GetScriptDescription(vPresetScript.Script)
				end
			end
		end
	else
		local vCategory
		
		pMenu:AddNormalItem(Outfitter.cNoScript, "NONE")
		
		for _, vPresetScript in ipairs(Outfitter.PresetScripts) do
			if not vPresetScript.Class
			or vPresetScript.Class == Outfitter.PlayerClass then
				-- Start a new category if it's changing
				
				local vNewCategory = vPresetScript.Category or vPresetScript.Class or "GENERAL"
				
				if vCategory ~= vNewCategory then
					vCategory = vNewCategory
					pMenu:AddChildMenu(
						Outfitter.cScriptCategoryName[vCategory] or Outfitter.cClassName[vCategory],
						vCategory)
				end
			end
		end
	end
end

function Outfitter._NameOutfitDialog:Done()
	local vName = self.Name:GetText()
	
	if vName
	and vName ~= "" then
		if self.OutfitToRename then
			local vWearingOutfit = Outfitter:WearingOutfit(self.OutfitToRename)
			
			if vWearingOutfit then
				Outfitter:DispatchOutfitEvent("UNWEAR_OUTFIT", self.OutfitToRename.Name, self.OutfitToRename)
			end
			
			self.OutfitToRename:SetName(vName)
			Outfitter.DisplayIsDirty = true

			if vWearingOutfit then
				Outfitter:DispatchOutfitEvent("WEAR_OUTFIT", self.OutfitToRename.Name, self.OutfitToRename)
			end
		else
			-- Create the new outift
			
			local vScriptID = self.ScriptMenu:GetSelectedValue()
			
			local vOutfit
			
			if self.EmptyOutfitCheckButton:GetChecked() then
				vOutfit = Outfitter:NewEmptyOutfit(vName)
			elseif self.ExistingOutfitCheckButton:GetChecked() then
				vOutfit = Outfitter:GetInventoryOutfit(vName)
			else
				local vStatConfig = self.MultiStatConfig:GetConfig()
				
				vOutfit = Outfitter:GenerateSmartOutfit(vName, vStatConfig, Outfitter:GetInventoryCache(), true, function (pOutfit)
					if pOutfit and not pOutfit:IsEmpty() then
						pOutfit.StatConfig = vStatConfig
						self:AddOutfit(pOutfit, vScriptID)
					else
						Outfitter:ErrorMessage(Outfitter.cNoItemsWithStat);
					end
				end)
				
				self:Hide()
				return
			end
			
			if not vOutfit then
				vOutfit = Outfitter:NewEmptyOutfit(vName)
			end
			
			self:AddOutfit(vOutfit, vScriptID)
		end
	end
	
	self:Hide()
end

function Outfitter._NameOutfitDialog:PresetScriptChanged(pMenu, pValue)
	pMenu:SetSelectedValue(pValue)
	
	-- Set the default name if there isn't one or it's the previous default
	
	local vName = self.Name:GetText()
	
	if pValue ~= "NONE"
	and (not vName or vName == "" or vName == self.PreviousDefaultName) then
		vName = Outfitter:GetPresetScriptByID(pValue).Name
		
		self.Name:SetText(vName)
		self.PreviousDefaultName = vName
	end
end

function Outfitter._NameOutfitDialog:CheckForStatOutfit(pMenu, pValue)
	self:Update(true)
end

function Outfitter._NameOutfitDialog:Cancel()
	self:Hide()
end

function Outfitter._NameOutfitDialog:Update(pCheckForStatOutfit)
	local vEnableDoneButton = true
	local vErrorMessage = nil
	
	-- If there's no name entered then disable the okay button
	
	local vName = self.Name:GetText()
	
	if not vName
	or vName == "" then
		vEnableDoneButton = false
	else
		local vOutfit = Outfitter:FindOutfitByName(vName)
		
		if vOutfit
		and vOutfit ~= self.OutfitToRename then
			vErrorMessage = Outfitter.cNameAlreadyUsedError
			vEnableDoneButton = false
		end
	end
	
	-- 
	
	if not vErrorMessage
	and pCheckForStatOutfit then
	--[[
		local vStat = self.OptimizeMenu:GetSelectedValue()
		
		if vStat
		and vStat ~= 0
		and vStat ~= "EMPTY"
		and not vStat.Complex then -- Don't attempt to test for iterative outfits
			local vOutfit = Outfitter:GenerateSmartOutfit("temp outfit", vStat, Outfitter:GetInventoryCache())
			
			if not vOutfit
			or vOutfit:IsEmpty() then
				vErrorMessage = Outfitter.cNoItemsWithStatError
			end
		end
	]]
	end
	
	if vErrorMessage then
		self.Error:SetText(vErrorMessage)
		self.Error:Show()
	else
		self.Error:Hide()
	end
	
	self.DoneButton:SetEnabled(vEnableDoneButton)
	
	self:AdjustSize()
end

function Outfitter._NameOutfitDialog:AddOutfit(pOutfit, pScriptID)
	-- Add the outfit

	local vCategoryID = Outfitter:AddOutfit(pOutfit)

	-- Set the script

	if pScriptID and pScriptID ~= "NONE" then
		Outfitter:SetScriptID(pOutfit, pScriptID)
	end

	-- Wear the outfit

	Outfitter:WearOutfit(pOutfit)
	
	Outfitter:Update(true)
end

----------------------------------------
Outfitter._RebuildOutfitDialog = {}
----------------------------------------

function Outfitter._RebuildOutfitDialog:New(pParent)
	return Outfitter:New(Outfitter.UIElementsLib._ModalDialogFrame, pParent, Outfitter.cRebuild, 315, 207)
end

function Outfitter._RebuildOutfitDialog:Construct(pParent)
	self:Hide()
	
	--self:SetTopLevel(true)
	self:SetFrameStrata("DIALOG")
	self:EnableMouse(true)
	
	-- Controls
	
	self.StatsSection = Outfitter:New(Outfitter.UIElementsLib._Section, self, Outfitter.cStats)
	self.MultiStatConfig = Outfitter:New(Outfitter._MultiStatConfig, self.StatsSection)
	
	-- Layout
	
	self:SetPoint("TOPLEFT", OutfitterFrame, "TOPLEFT", 20, -40)
	
	-- Stats section
	
	self.StatsSection:SetPoint("TOPLEFT", self, "TOPLEFT", 20, -25)
	self.StatsSection:SetPoint("RIGHT", self, "RIGHT", -20, 0)
	
	self.MultiStatConfig:SetPoint("TOPLEFT", self.StatsSection, "TOPLEFT", 25, -15)
	
	-- Events
	
	self:SetScript("OnShow", function (self) Outfitter.UIElementsLib:BeginDialog(self) end)
	self:SetScript("OnHide", function (self) Outfitter.UIElementsLib:EndDialog(self) end)
	
	self.MultiStatConfig.OnNumLinesChanged = function (pMultiStatConfig, pNumLines)
		self:AdjustSize()
	end
end

function Outfitter._RebuildOutfitDialog:Open(pOutfit)
	self.Outfit = pOutfit
	
	if self.Outfit.StatID
	and not self.Outfit.StatConfig then
		self.Outfit.StatConfig = {{StatID = self.Outfit.StatID}}
	end
	
	self.MultiStatConfig:SetConfig(self.Outfit.StatConfig)
	
	self:AdjustSize()
	self:Show()
end

function Outfitter._RebuildOutfitDialog:AdjustSize()
	local vStatConfigHeight = self.MultiStatConfig:GetHeight()
	
	local vHeight = 51 + vStatConfigHeight + 48
	local vWidth = 40 + self.MultiStatConfig:GetWidth() + 40
	
	self.StatsSection:SetHeight(vStatConfigHeight + 25)
			
	self:SetWidth(vWidth)
	self:SetHeight(vHeight)
end

function Outfitter._RebuildOutfitDialog:Done()
	self.Outfit.StatConfig = self.MultiStatConfig:GetConfig()
	
	self:Hide()
	
	Outfitter:RebuildOutfit(self.Outfit)
end

function Outfitter._RebuildOutfitDialog:Cancel()
	self:Hide()
end

----------------------------------------
--
----------------------------------------

function Outfitter:SetButtonEnable(pButton, pEnabled)
	if pEnabled then
		pButton:Enable()
		pButton:SetAlpha(1.0)
		pButton:EnableMouse(true)
		--_G[pButton:GetName().."Text"]:SetAlpha(1.0)
	else
		pButton:Disable()
		pButton:SetAlpha(0.7)
		pButton:EnableMouse(false)
		--_G[pButton:GetName().."Text"]:SetAlpha(0.7)
	end
end

function Outfitter:GetOutfitFromListItem(pItem)
	if pItem.isCategory then
		return nil
	end
	
	if not self.Settings.Outfits then
		return nil
	end
	
	local vOutfits = self.Settings.Outfits[pItem.categoryID]
	
	if not vOutfits then
		-- Error: outfit category not found
		return nil
	end
	
	return vOutfits[pItem.outfitIndex]
end

Outfitter.OutfitMenuActions = {}

function Outfitter.OutfitMenuActions:DELETE(pOutfit)
	self:AskDeleteOutfit(pOutfit)
end

function Outfitter.OutfitMenuActions:RENAME(pOutfit)
	self.NameOutfitDialog:Open(pOutfit)
end

function Outfitter.OutfitMenuActions:SCRIPT_SETTINGS(pOutfit)
	OutfitterEditScriptDialog:Open(pOutfit)
end

function Outfitter.OutfitMenuActions:EDIT_SCRIPT(pOutfit)
	if pOutfit.ScriptID == nil and pOutfit.Script == nil then
		pOutfit.Script = pOutfit.SavedScript
		pOutfit.SavedScript = nil
	end
	
	OutfitterEditScriptDialog:Open(pOutfit, true)
end

function Outfitter.OutfitMenuActions:DISABLE(pOutfit)
	self:SetScriptEnabled(pOutfit, pOutfit.Disabled)
end

function Outfitter:SetScriptEnabled(pOutfit, pEnable)
	if (not pEnable) == (pOutfit.Disabled or false) then
		return
	end
	
	pOutfit.Disabled = not pEnable
	
	if pOutfit.Disabled then
		self:DeactivateScript(pOutfit)
	else
		self:ActivateScript(pOutfit)
	end
	
	self:OutfitSettingsChanged(pOutfit)
end

function Outfitter.OutfitMenuActions:SHOWHELM(pOutfit)
	pOutfit.ShowHelm = true
	self.OutfitStack:UpdateOutfitDisplay()
	self:OutfitSettingsChanged(pOutfit)
end

function Outfitter.OutfitMenuActions:HIDEHELM(pOutfit)
	pOutfit.ShowHelm = false
	self.OutfitStack:UpdateOutfitDisplay()
	self:OutfitSettingsChanged(pOutfit)
end

function Outfitter.OutfitMenuActions:IGNOREHELM(pOutfit)
	pOutfit.ShowHelm = nil
	self.OutfitStack:UpdateOutfitDisplay()
	self:OutfitSettingsChanged(pOutfit)
end

function Outfitter.OutfitMenuActions:SHOWCLOAK(pOutfit)
	pOutfit.ShowCloak = true
	self.OutfitStack:UpdateOutfitDisplay()
	self:OutfitSettingsChanged(pOutfit)
end

function Outfitter.OutfitMenuActions:HIDECLOAK(pOutfit)
	pOutfit.ShowCloak = false
	self.OutfitStack:UpdateOutfitDisplay()
	self:OutfitSettingsChanged(pOutfit)
end

function Outfitter.OutfitMenuActions:IGNORECLOAK(pOutfit)
	pOutfit.ShowCloak = nil
	self.OutfitStack:UpdateOutfitDisplay()
	self:OutfitSettingsChanged(pOutfit)
end

function Outfitter.OutfitMenuActions:IGNORETITLE(pOutfit)
	pOutfit.ShowTitleID = nil
	self.OutfitStack:UpdateOutfitDisplay()
	self:OutfitSettingsChanged(pOutfit)
end

function Outfitter.OutfitMenuActions:COMBATDISABLE(pOutfit)
	if pOutfit.CombatDisabled then
		pOutfit.CombatDisabled = nil
	else
		pOutfit.CombatDisabled = true
	end
	
	self:OutfitSettingsChanged(pOutfit)
end

function Outfitter.OutfitMenuActions:REBUILD(pOutfit)
	self:AskRebuildOutfit(pOutfit)
end

function Outfitter.OutfitMenuActions:REBUILD_FOR(pOutfit)
	self.RebuildOutfitDialog:Open(pOutfit)
end

function Outfitter.OutfitMenuActions:SET_CURRENT(pOutfit)
	self:AskSetCurrent(pOutfit)
end

function Outfitter.OutfitMenuActions:UNEQUIP_OTHERS(pOutfit)
	if pOutfit.UnequipOthers then
		pOutfit.UnequipOthers = nil
	else
		pOutfit.UnequipOthers = true
	end
	
	self:OutfitSettingsChanged(pOutfit)
end

function Outfitter.OutfitMenuActions:DEPOSIT(pOutfit)
	self:DepositOutfit(pOutfit)
end

function Outfitter.OutfitMenuActions:DEPOSITUNIQUE(pOutfit)
	self:DepositOutfit(pOutfit, true)
end

function Outfitter.OutfitMenuActions:DEPOSITOTHERS(pOutfit)
	self:DepositOtherOutfits(pOutfit)
end

function Outfitter.OutfitMenuActions:WITHDRAW(pOutfit)
	self:WithdrawOutfit(pOutfit)
end

function Outfitter.OutfitMenuActions:WITHDRAWOTHERS(pOutfit)
	self:WithdrawOtherOutfits(pOutfit)
end

function Outfitter.OutfitMenuActions:OUTFITBAR_SHOW(pOutfit)
	local vSettings = self.OutfitBar:GetOutfitSettings(pOutfit)
	
	vSettings.Hide = not vSettings.Hide
	
	self:OutfitSettingsChanged(pOutfit)
end

function Outfitter.OutfitMenuActions:OUTFITBAR_CHOOSEICON(pOutfit)
	OutfitterChooseIconDialog:Open(pOutfit)
end

function Outfitter:PerformAction(pActionID, pOutfit)
	local vActionFunc = Outfitter.OutfitMenuActions[pActionID]
	
	if vActionFunc then
		vActionFunc(self, pOutfit)
	elseif string.sub(pActionID, 1, 8) == "BINDING_" then
		local vBindingIndex = string.sub(pActionID, 9)
		
		if vBindingIndex == "NONE" then
			Outfitter:SetOutfitBindingIndex(pOutfit, nil)
		else
			Outfitter:SetOutfitBindingIndex(pOutfit, tonumber(vBindingIndex))
		end
	elseif string.sub(pActionID, 1, 7) == "PRESET_" then
		local vScriptID = string.sub(pActionID, 8)
		
		if vScriptID == "NONE" then
			Outfitter:DeactivateScript(pOutfit)
			
			pOutfit.SavedScript = pOutfit.Script
			
			pOutfit.ScriptID = nil
			pOutfit.Script = nil
		else
			pOutfit.SavedScript = nil
			
			Outfitter:SetScriptID(pOutfit, vScriptID)
			
			-- If the script has settings then open the
			-- dialog
			
			if Outfitter:OutfitHasSettings(pOutfit) then
				OutfitterEditScriptDialog:Open(pOutfit)
			end
		end
		
		Outfitter:OutfitSettingsChanged(pOutfit)
	elseif string.sub(pActionID, 1, 6) == "TITLE_" then
		local vTitleID = tonumber(string.sub(pActionID, 7))
		
		pOutfit.ShowTitleID = vTitleID
		
		self.SchedulerLib:ScheduleUniqueTask(0.5, self.OutfitStack.UpdateOutfitDisplay, self.OutfitStack)
	elseif string.sub(pActionID, 1, 13) == "REBUILD_STAT_" then
		local vStatID = string.sub(pActionID, 14)
		
		pOutfit.StatID = vStatID
		Outfitter:AskRebuildOutfit(pOutfit)
	else
		return
	end
	
	Outfitter:Update(true)
end

function Outfitter.OutfitItemSelected(pMenu, pValue)
	local vItem = pMenu:GetParent():GetParent()
	local vOutfit = Outfitter:GetOutfitFromListItem(vItem)

	if not vOutfit then
		Outfitter:ErrorMessage("Outfit for menu item "..vItem:GetName().." not found")
		return
	end

	Outfitter:PerformAction(pValue, vOutfit)
end

function Outfitter.PresetScriptDropDown_OnLoad(self)
	Outfitter:DropDownMenu_Initialize(self, Outfitter.PresetScriptDropdown_Initialize)
	self:SetMenuWidth(150)
	self:Refresh()
	
	self.AutoSetValue = true
	self.ChangedValueFunc = Outfitter.PresetScriptDropdown_ChangedValue
end

function Outfitter.PresetScriptDropdown_ChangedValue(pFrame, pValue)
	pFrame.Dialog:SetPresetScriptID(pValue)
end

function Outfitter.PresetScriptDropdown_Initialize(pFrame)
	if UIDROPDOWNMENU_MENU_LEVEL == 2 then
		for _, vPresetScript in ipairs(Outfitter.PresetScripts) do
			if not vPresetScript.Class
			or vPresetScript.Class == Outfitter.PlayerClass then
				local vCategory = vPresetScript.Category or vPresetScript.Class or "GENERAL"
				
				if vCategory == UIDROPDOWNMENU_MENU_VALUE then
					UIDropDownMenu_AddButton({
						text = vPresetScript.Name,
						arg1 = pFrame,
						arg2 = vPresetScript.ID,
						value = vPresetScript.ID,
						func = Outfitter.DropDown_OnClick,
						tooltipTitle = vPresetScript.Name,
						tooltipText = Outfitter:GetScriptDescription(vPresetScript.Script),
						colorCode = NORMAL_FONT_COLOR_CODE,
					}, UIDROPDOWNMENU_MENU_LEVEL)
				end
			end
		end
	else
		local vCategory
		
		for _, vPresetScript in ipairs(Outfitter.PresetScripts) do
			if not vPresetScript.Class
			or vPresetScript.Class == Outfitter.PlayerClass then
				-- Start a new category if it's changing
				
				local vNewCategory = vPresetScript.Category or vPresetScript.Class or "GENERAL"
				
				if vCategory ~= vNewCategory then
					vCategory = vNewCategory
					
					UIDropDownMenu_AddButton({
						text = Outfitter.cScriptCategoryName[vCategory] or Outfitter.cClassName[vCategory],
						hasArrow = 1,
						arg1= pFrame,
						arg2 = vCategory,
						value = vCategory}, UIDROPDOWNMENU_MENU_LEVEL)
				end
			end
		end
	end
end

----------------------------------------
-- Outfitter.StatDropDown
----------------------------------------

function Outfitter.StatDropDown_OnLoad(self)
	Outfitter:DropDownMenu_Initialize(self, Outfitter.StatDropdown_Initialize)
	self:SetMenuWidth(150)
	self:Refresh()

	self.AutoSetValue = true
end

function Outfitter.StatDropdown_Initialize(pFrame)
	if UIDROPDOWNMENU_MENU_LEVEL == 2 then
		local vCategory = Outfitter:GetCategoryByID(UIDROPDOWNMENU_MENU_VALUE)
		
		if vCategory then
			local vNumStats = vCategory:GetNumStats()
			
			for vStatIndex = 1, vNumStats do
				local vStat = vCategory:GetIndexedStat(vStatIndex)
				
				UIDropDownMenu_AddButton({text = vStat.Name, arg1 = pFrame, arg2 = vStat, value = vStat, func = Outfitter.DropDown_OnClick}, UIDROPDOWNMENU_MENU_LEVEL)
			end
		end
	else
		UIDropDownMenu_AddButton({text = Outfitter.cUseCurrentOutfit, arg1 = pFrame, arg2 = 0, value = 0, func = Outfitter.DropDown_OnClick})
		UIDropDownMenu_AddButton({text = Outfitter.cUseEmptyOutfit, arg1 = pFrame, arg2 = "EMPTY", value = "EMPTY", func = Outfitter.DropDown_OnClick})
		
		UIDropDownMenu_AddButton({text = " ", notCheckable = true, notClickable = true})
		
		for _, vCategory in ipairs(Outfitter.StatCategories) do
			UIDropDownMenu_AddButton({text = vCategory.Name, hasArrow = 1, arg1 = pFrame, arg2 = vCategory.CategoryID, value = vCategory.CategoryID})
		end
	end
end

----------------------------------------
Outfitter._DropDownMenu = {}
----------------------------------------

function Outfitter:DropDownMenu_Initialize(pFrame, pInitFunction, pDisplayMode, pLevel, pMenuList)
	if not pFrame:GetName() then
		self:ErrorMessage("DropDownMenu_Initialize: pFrame is anonymous")
		self:DebugStack()
		return
	end
	
	for vName, vFunction in pairs(self._DropDownMenu) do
		pFrame[vName] = vFunction
	end
	
	UIDropDownMenu_Initialize(pFrame, pInitFunction, pDisplayMode, pLevel, pMenuList)
end

function Outfitter._DropDownMenu:SetMenuWidth(pWidth, pPadding)
	UIDropDownMenu_SetWidth(self, pWidth, pPadding)
end

function Outfitter._DropDownMenu:SetMenuText(pText)
	UIDropDownMenu_SetText(self, pText)
end

function Outfitter._DropDownMenu:Refresh()
	UIDropDownMenu_Refresh(self)
end

function Outfitter._DropDownMenu:SetSelectedValue(pValue)
	UIDropDownMenu_SetSelectedValue(self, pValue)
end

----------------------------------------
-- Outfitter.AutomationDropDown
----------------------------------------

function Outfitter.AutomationDropDown_OnLoad(self)
	Outfitter:DropDownMenu_Initialize(self, Outfitter.AutomationDropdown_Initialize)
	self:SetMenuWidth(150)
	self:Refresh()
end

function Outfitter.AutomationDropdown_Initialize(pFrame)
	if UIDROPDOWNMENU_MENU_LEVEL == 2 then
		for _, vPresetScript in ipairs(Outfitter.PresetScripts) do
			if not vPresetScript.Class
			or vPresetScript.Class == Outfitter.PlayerClass then
				local vCategory = vPresetScript.Category or vPresetScript.Class or "GENERAL"
				
				if vCategory == UIDROPDOWNMENU_MENU_VALUE then
					local vName = vPresetScript.Name
					local vDescription = Outfitter:GetScriptDescription(vPresetScript.Script)
					
					Outfitter:AddMenuItem(
							pFrame,
							vName,
							vPresetScript.ID,
							nil, -- Checked
							UIDROPDOWNMENU_MENU_LEVEL,
							nil, -- Color
							nil, -- Disabled
							{tooltipTitle = vName, tooltipText = vDescription})
				end
			end
		end
	else
		local vCategory
		
		Outfitter:AddMenuItem(pFrame, Outfitter.cNoScript, "NONE")
		
		local vCategory
		
		for _, vPresetScript in ipairs(Outfitter.PresetScripts) do
			if not vPresetScript.Class
			or vPresetScript.Class == Outfitter.PlayerClass then
				-- Start a new category if it's changing
				
				local vNewCategory = vPresetScript.Category or vPresetScript.Class or "GENERAL"
				
				if vCategory ~= vNewCategory then
					vCategory = vNewCategory
					
					UIDropDownMenu_AddButton({
						text = Outfitter.cScriptCategoryName[vCategory] or Outfitter.cClassName[vCategory],
						hasArrow = 1,
						arg1 = pFrame,
						arg2 = vCategory,
						colorCode = NORMAL_FONT_COLOR_CODE,
						value = vCategory}, UIDROPDOWNMENU_MENU_LEVEL)
				end
			end
		end
	end
end

----------------------------------------
-- 
----------------------------------------

--[[
function UIDropDownMenu_Refresh(frame, useValue, dropdownLevel)
	Outfitter:DebugMessage("UIDropDownMenu_Refresh: frame selected value is %s", UIDropDownMenu_GetSelectedValue(frame) or "nil")
	
	local button, checked, checkImage, normalText, width;
	local maxWidth = 0;
	assert(frame);
	if ( not dropdownLevel ) then
		dropdownLevel = UIDROPDOWNMENU_MENU_LEVEL;
	end
	
	-- Just redraws the existing menu
	for i=1, UIDROPDOWNMENU_MAXBUTTONS do
		button = _G["DropDownList"..dropdownLevel.."Button"..i]
		Outfitter:DebugMessage(" Examinging button %d, title %s, value is %s", i, button:GetText() or "nil", button.value or "nil")
		
		checked = nil;
		-- See if checked or not
		if ( UIDropDownMenu_GetSelectedName(frame) ) then
			if ( button:GetText() == UIDropDownMenu_GetSelectedName(frame) ) then
				checked = 1;
			end
		elseif ( UIDropDownMenu_GetSelectedID(frame) ) then
			if ( button:GetID() == UIDropDownMenu_GetSelectedID(frame) ) then
				checked = 1;
			end
		elseif ( UIDropDownMenu_GetSelectedValue(frame) ) then
			if ( button.value == UIDropDownMenu_GetSelectedValue(frame) ) then
				checked = 1;
			end
		end

		-- If checked show check image
		checkImage = _G["DropDownList"..dropdownLevel.."Button"..i.."Check"]
		if ( checked ) then
			Outfitter:DebugMessage(" Item is checked")
			
			if ( useValue ) then
				UIDropDownMenu_SetText(frame, button.value);
			else
				UIDropDownMenu_SetText(frame, button:GetText());
			end
			button:LockHighlight();
			checkImage:Show();
		else
			Outfitter:DebugMessage(" Item is not checked")
			button:UnlockHighlight();
			checkImage:Hide();
		end

		if ( button:IsShown() ) then
			normalText = _G[button:GetName().."NormalText"]
			-- Determine the maximum width of a button
			width = normalText:GetWidth() + 40;
			-- Add padding if has and expand arrow or color swatch
			if ( button.hasArrow or button.hasColorSwatch ) then
				width = width + 10;
			end
			if ( button.notCheckable ) then
				width = width - 30;
			end
			if ( width > maxWidth ) then
				maxWidth = width;
			end
		end
	end
	for i=1, UIDROPDOWNMENU_MAXBUTTONS do
		button = _G["DropDownList"..dropdownLevel.."Button"..i]
		button:SetWidth(maxWidth);
	end
	_G["DropDownList"..dropdownLevel]:SetWidth(maxWidth+15);
end
]]

function Outfitter.DropDown_SetSelectedValue(pDropDown, pValue)
	pDropDown:SetMenuText("") -- Set to empty in case the selected value isn't there
	Outfitter:DropDownMenu_Initialize(pDropDown, pDropDown.initialize)
	pDropDown:SetSelectedValue(pValue)
	
	-- All done if the item text got set successfully
	
	local vItemText = UIDropDownMenu_GetText(pDropDown)
	
	if vItemText and vItemText ~= "" then
		return
	end
	
	-- Scan for submenus
	
	local vRootListFrameName = "DropDownList1"
	local vRootListFrame = _G[vRootListFrameName]
	local vRootNumItems = vRootListFrame.numButtons
	
	for vRootItemIndex = 1, vRootNumItems do
		local vItem = _G[vRootListFrameName.."Button"..vRootItemIndex]
		
		if vItem.hasArrow then
			local vSubMenuFrame = DropDownList2
			
			UIDROPDOWNMENU_OPEN_MENU = pDropDown
			UIDROPDOWNMENU_MENU_VALUE = vItem.value
			UIDROPDOWNMENU_MENU_LEVEL = 2
			
			Outfitter:DropDownMenu_Initialize(pDropDown, pDropDown.initialize, nil, 2)
			pDropDown:SetSelectedValue(pValue)
			
			-- All done if the item text got set successfully
			
			local vItemText = UIDropDownMenu_GetText(pDropDown)
			
			if vItemText and vItemText ~= "" then
				return
			end
			
			-- Switch back to the root menu
			
			UIDROPDOWNMENU_OPEN_MENU = nil
			Outfitter:DropDownMenu_Initialize(pDropDown, pDropDown.initialize, nil, 1)
		end
	end
end

function Outfitter.ScrollbarTrench_SizeChanged(pScrollbarTrench)
	local vScrollbarTrenchName = pScrollbarTrench:GetName()
	local vScrollbarTrenchMiddle = _G[vScrollbarTrenchName.."Middle"]
	
	local vMiddleHeight= pScrollbarTrench:GetHeight() - 51
	vScrollbarTrenchMiddle:SetHeight(vMiddleHeight)
end

function Outfitter.InputBox_OnLoad(self, pChildDepth)
	if not pChildDepth then
		pChildDepth = 0
	end
	
	local vParent = self:GetParent()
	
	for vDepthIndex = 1, pChildDepth do
		vParent = vParent:GetParent()
	end
	
	if vParent.lastEditBox then
		self.prevEditBox = vParent.lastEditBox
		self.nextEditBox = vParent.lastEditBox.nextEditBox
		
		self.prevEditBox.nextEditBox = self
		self.nextEditBox.prevEditBox = self
	else
		self.prevEditBox = self
		self.nextEditBox = self
	end

	vParent.lastEditBox = self
end

function Outfitter.InputBox_TabPressed(self)
	local vReverse = IsShiftKeyDown()
	local vEditBox = self
	
	for vIndex = 1, 50 do
		local vNextEditBox
			
		if vReverse then
			vNextEditBox = vEditBox.prevEditBox
		else
			vNextEditBox = vEditBox.nextEditBox
		end
		
		if vNextEditBox:IsVisible()
		and not vNextEditBox.isDisabled then
			vNextEditBox:SetFocus()
			return
		end
		
		vEditBox = vNextEditBox
	end
end

function Outfitter:ToggleUI(pToggleCharWindow)
	if self:IsOpen() then
		OutfitterFrame:Hide()
		
		if pToggleCharWindow then
			HideUIPanel(CharacterFrame)
		end
	else
		self:OpenUI()
	end
end

function Outfitter:OpenUI()
	ShowUIPanel(CharacterFrame)
	CharacterFrame_ShowSubFrame("PaperDollFrame")
	OutfitterFrame:Show()
end

function Outfitter:WearingOutfitName(pOutfitName)
	local vOutfit = Outfitter:FindOutfitByName(pOutfitName)
	
	return vOutfit and Outfitter:WearingOutfit(vOutfit)
end

function Outfitter:WearingOutfit(pOutfit)
	return Outfitter.OutfitStack:FindOutfit(pOutfit)
end

function Outfitter:CheckDatabase()
	local vOutfit
	
	if not self.Settings.Version then
		local vOutfits = self.Settings.Outfits[vCategoryID]
		
		if self.Settings.Outfits then
			for vCategoryID, vOutfits in pairs(self.Settings.Outfits) do
				for vIndex, vOutfit in ipairs(vOutfits) do
					if vOutfit:IsComplete(true) then
						vOutfit:AddItem("AmmoSlot", nil)
					end
				end
			end
		end
		
		self.Settings.Version = 1
	end
	
	-- Versions 1 and 2 both simply add class outfits
	-- so just reinitialize those
	
	if self.Settings.Version < 3 then
		self:InitializeClassOutfits()
		self.Settings.Version = 3
	end
	
	-- Version 4 sets the BGDisabled flag for the mounted outfit
	
	if self.Settings.Version < 4 then
		local vRidingOutfit = self:GetOutfitByScriptID("Riding")
		
		if vRidingOutfit then
			vRidingOutfit.BGDisabled = true
		end
		
		self.Settings.Version = 4
	end
	
	-- Version 5 adds moonkin form, just reinitialize class outfits

	if self.Settings.Version < 5 then
		self:InitializeClassOutfits()
		self.Settings.Version = 5
	end
	
	-- Make sure all outfits have an associated category ID
	
	if self.Settings.Outfits then
		for vCategoryID, vOutfits in pairs(self.Settings.Outfits) do
			for vIndex, vOutfit in ipairs(vOutfits) do
				vOutfit.CategoryID = vCategoryID
			end
		end
	end
	
	-- Version 6 and 7 adds item sub-code and enchantment codes
	-- (7 tries to clean up failed updates from 6)
	
	if self.Settings.Version < 7 then
		self.SchedulerLib:ScheduleTask(5, Outfitter.UpdateDatabaseItemCodes, Outfitter)
		
		self.Settings.Version = 7
	end
	
	-- Version 8 removes the old style cloak/helm settings
	
	if self.Settings.Version < 8 then
		self.Settings.HideHelm = nil
		self.Settings.HideCloak = nil
		self.Settings.Version = 8
	end
	
	-- Version 9 converts old SpecialIDs to ScriptIDs
	-- and removes the parial and special categories
	
	if self.Settings.Version < 9 then
		local vUpdatedOutfits = {}
		local vDeletedOutfits = {}
		
		local vPreservedOutfits =
		{
			Battle = true,
			Defensive = true,
			Berserker = true,
			
			Bear = true,
			Cat = true,
			Aquatic = true,
			Travel = true,
			Moonkin = true,
			Tree = true,
			Prowl = true,
			Flight = true,

			Shadowform = true,

			Stealth = true,

			GhostWolf = true,

			Monkey = true,
			Hawk = true,
			Cheetah = true,
			Pack = true,
			Beast = true,
			Wild = true,
			Viper = true,
			Dragonhawk = true,
			Feigning = true,
			
			Evocate = true,
			
			ArgentDawn = true,

			Battleground = true,
		}
		
		for _, vOutfit in ipairs(self.Settings.Outfits.Special) do
			if vOutfit:IsEmpty()
			and not vPreservedOutfits[vOutfit.SpecialID] then
				table.insert(vDeletedOutfits, vOutfit)
			else
				vOutfit.ScriptID = vOutfit.SpecialID
				vOutfit.SpecialID = nil
				
				table.insert(vUpdatedOutfits, vOutfit)
			end
		end
		
		--
		
		for _, vOutfit in ipairs(self.Settings.Outfits.Partial) do
			vOutfit.IsAccessory = nil
			table.insert(vUpdatedOutfits, vOutfit)
		end
		
		--
		
		for _, vOutfit in ipairs(vUpdatedOutfits) do
			self:OutfitSettingsChanged(vOutfit)
		end
		
		for _, vOutfit in ipairs(vDeletedOutfits) do
			self:DeleteOutfit(vOutfit)
		end
		
		self.Settings.Outfits.Special = nil
		self.Settings.Outfits.Partial = nil
		
		self.Settings.Version = 9
	end
	
	-- Version 10 eliminates the ScriptEvents field and moves
	-- it to the source instead
	
	if self.Settings.Version < 10 then
		for vCategoryID, vOutfits in pairs(self.Settings.Outfits) do
			for vIndex, vOutfit in ipairs(vOutfits) do
				if vOutfit.Script and vOutfit.ScriptEvents then
					vOutfit.Script = "-- $EVENTS "..vOutfit.ScriptEvents.."\n"..vOutfit.Script
				end
				vOutfit.ScriptEvents = nil
			end
		end
		
		self.Settings.Version = 10
	end
	
	-- Version 11 prevents scripted outfits from being treated as complete outfits
	
	if self.Settings.Version < 11 then
		self:CheckOutfitCategories()
		self.Settings.Version = 11
	end
	
	-- Version 12 moves the BGDisabled, AQDisabled and NaxxDisabled flags to
	-- the script settings for the riding outfiZt
	
	if self.Settings.Version < 12 then
		local vRidingOutfit = self:GetOutfitByScriptID("Riding")
		
		if vRidingOutfit then
			if not vRidingOutfit.ScriptSettings then
				vRidingOutfit.ScriptSettings = {}
			end
			
			vRidingOutfit.ScriptSettings.DisableAQ40 = vRidingOutfit.AQDisabled
			vRidingOutfit.ScriptSettings.DisableBG = vRidingOutfit.BGDisabled
			vRidingOutfit.ScriptSettings.DisableNaxx = vRidingOutfit.NaxxDisabled
			
			vRidingOutfit.AQDisabled = nil
			vRidingOutfit.BGDisabled = nil
			vRidingOutfit.NaxxDisabled = nil
		end
		
		self.Settings.Version = 12
	end
	
	-- Version 13 adds the LayerIndex table
	
	if self.Settings.Version < 13 then
		self.Settings.LayerIndex = {}
		self.Settings.Version = 13
	end
	
	-- Version 14 updates all outfits with InvType fields
	
	if self.Settings.Version < 14 then
		self.SchedulerLib:ScheduleTask(5, Outfitter.UpdateInvTypes, Outfitter)
		
		self.Settings.Version = 14
	end
	
	-- Version 15 allows scripted outfits to be complete outfits
	
	if self.Settings.Version < 15 then
		self:CheckOutfitCategories()
		self.Settings.Version = 15
	end
	
	-- Version 16 adds the RecentCompleteOutfits list to the settings
	
	if self.Settings.Version < 16 then
		self.Settings.RecentCompleteOutfits = {}
		self.Settings.Version = 16
	end
	
	-- Version 17 updates all outfits with SubType fields
	
	if self.Settings.Version < 17 then
		self.SchedulerLib:ScheduleTask(5, Outfitter.UpdateSubTypes, Outfitter)
		
		self.Settings.Version = 17
	end
	
	-- Version 18 converts all outfits JewelCode fields to Gem fields
	
	if self.Settings.Version < 18 then
		if self.Settings.Outfits then
			for vCategoryID, vOutfits in pairs(self.Settings.Outfits) do
				for vIndex, vOutfit in ipairs(vOutfits) do
					if vOutfit.Items then
						for vInventorySlot, vItemInfo in pairs(vOutfit.Items) do
							vItemInfo.Gem1 = Outfitter.cUniqueGemEnchantIDs[vItemInfo.JewelCode1]
							vItemInfo.Gem2 = Outfitter.cUniqueGemEnchantIDs[vItemInfo.JewelCode2]
							vItemInfo.Gem3 = Outfitter.cUniqueGemEnchantIDs[vItemInfo.JewelCode3]
						end
					end
				end
			end
		end
		
		self.Settings.Version = 18
	end
	
	-- Repair missing settings
	
	if not self.Settings.RecentCompleteOutfits then
		self.Settings.RecentCompleteOutfits = {}
	end
	
	if not self.Settings.LayerIndex then
		self.Settings.LayerIndex = {}
	end
	
	if not self.Settings.LastOutfitStack then
		self.Settings.LastOutfitStack = {}
	end
	
	if not self.Settings.RecentCompleteOutfits then
		self.Settings.RecentCompleteOutfits = {}
	end
	
	if not self.Settings.OutfitBar then
		self.Settings.OutfitBar = {}
		self.Settings.OutfitBar.ShowOutfitBar = true
	end
	
	-- Scan the outfits and make sure everything is in order
	
	for vCategoryID, vOutfits in pairs(self.Settings.Outfits) do
		for vIndex, vOutfit in ipairs(vOutfits) do
			vOutfit:CheckOutfit(vCategoryID)
		end
	end
end

function Outfitter:CheckOutfitCategories()
	local vAllOutfits = {}
	
	for vCategoryID, vOutfits in pairs(self.Settings.Outfits) do
		for _, vOutfit in ipairs(vOutfits) do
			table.insert(vAllOutfits, vOutfit)
		end
	end
	
	for _, vOutfit in ipairs(vAllOutfits) do
		self:OutfitSettingsChanged(vOutfit)
	end
end

function Outfitter:UpdateInvTypes()
	local vInventoryCache = self:GetInventoryCache()
	local vResult = true
	
	for vCategoryID, vOutfits in pairs(self.Settings.Outfits) do
		for vIndex, vOutfit in ipairs(vOutfits) do
			if not vOutfit:UpdateInvTypes(vInventoryCache) then
				vResult = false
			end
		end
	end
	
	return vResult
end

function Outfitter:UpdateSubTypes()
	local vInventoryCache = self:GetInventoryCache()
	local vResult = true
	
	for vCategoryID, vOutfits in pairs(self.Settings.Outfits) do
		for vIndex, vOutfit in ipairs(vOutfits) do
			if not vOutfit:UpdateSubTypes(vInventoryCache) then
				vResult = false
			end
		end
	end
	
	return vResult
end

function Outfitter:UpdateDatabaseItemCodes()
	local vInventoryCache = self:GetInventoryCache()
	local vResult = true
	
	for vCategoryID, vOutfits in pairs(self.Settings.Outfits) do
		for vIndex, vOutfit in ipairs(vOutfits) do
			if not vOutfit:UpdateDatabaseItemCodes(vInventoryCache) then
				vResult = false
			end
		end
	end
	
	return vResult
end

function Outfitter:GetPlayerStat(pStatIndex)
	local _, vEffectiveValue, vPosValue, vNegValue = UnitStat("player", pStatIndex)
	
	return vEffectiveValue - vPosValue - vNegValue, vPosValue + vNegValue
end

function Outfitter:DepositOutfit(pOutfit, pUniqueItemsOnly)
	-- Deselect any outfits to avoid them from being updated when
	-- items get put away
	
	self:ClearSelection()
	
	-- Build a list of items for the outfit
	
	local vInventoryCache = self:GetInventoryCache()
	
	vInventoryCache:ResetIgnoreItemFlags()
	
	-- Make a copy of the outfit
	
	local vUnequipOutfit = self:NewEmptyOutfit()
	local vItems = pOutfit:GetItems()
	
	for vInventorySlot, vItem in pairs(vItems) do
		vUnequipOutfit:SetItem(vInventorySlot, vItem)
	end
	
	-- Subtract out items from other outfits if unique is specified
	
	if pUniqueItemsOnly then
		for vCategoryID, vOutfits in pairs(self.Settings.Outfits) do
			for vOutfitIndex, vOutfit in ipairs(vOutfits) do
				if vOutfit ~= pOutfit then
					local vMissingItems, vBankedItems = vInventoryCache:GetMissingItems(vOutfit)
					
					-- Only subtract out items from outfits which aren't themselves partialy banked
					
					if vBankedItems == nil then
						self:SubtractOutfit(vUnequipOutfit, vOutfit, true)
					end
				end -- if vOutfit
			end -- for vOutfitIndex
		end -- for vCategoryID
	end -- if pUniqueItemsOnly
	
	-- Build the change list
	
	vInventoryCache:ResetIgnoreItemFlags()
	
	local vEquipmentChangeList = self:BuildUnequipChangeList(vUnequipOutfit, vInventoryCache)
	
	if not vEquipmentChangeList then
		return
	end
	
	-- Eliminate items which are already banked
	
	local vChangeIndex = 1
	local vNumChanges = #vEquipmentChangeList
	
	while vChangeIndex <= vNumChanges do
		vEquipmentChange = vEquipmentChangeList[vChangeIndex]
		
		if self:IsBankBagIndex(vEquipmentChange.FromLocation.BagIndex) then
			table.remove(vEquipmentChangeList, vChangeIndex)
			vNumChanges = vNumChanges - 1
		else
			vChangeIndex = vChangeIndex + 1
		end
	end
	
	-- Get the list of empty bank slots
	
	local vEmptyBankSlots = self:GetEmptyBankSlotList()
	
	-- Execute the changes
	
	self:ExecuteEquipmentChangeList2(vEquipmentChangeList, vEmptyBankSlots, self.cDepositBagsFullError, vExpectedInventoryCache)
	
	self:DispatchOutfitEvent("EDIT_OUTFIT", pOutfit:GetName(), pOutfit)
end

function Outfitter:DepositOtherOutfits(pOutfit)
	-- Deselect any outfits to avoid them from being updated when
	-- items get put away
	
	self:ClearSelection()
	
	-- Get a list of equippable items
	
	local vInventoryCache = self:GetInventoryCache()
	
	vInventoryCache:ResetIgnoreItemFlags()
	
	-- Mark all items in the current outfit so they won't be deposited
	
	local vItems = pOutfit:GetItems()
	
	for vInventorySlot, vOutfitItem in pairs(vItems) do
		local vItem, vIgnoredItem = vInventoryCache:FindItemOrAlt(vOutfitItem, true)
		
		-- Nothing more to do, the find command marks the item
	end -- for
	
	-- Build a list of items in all outfits
	
	local vEquipmentChangeList = {}
	
	for vCategoryID, vOutfits in pairs(self.Settings.Outfits) do
		for vOutfitIndex, vOutfit in ipairs(vOutfits) do
			if vOutfit ~= pOutfit then
				local vItems = vOutfit:GetItems()
				
				for vInventorySlot, vOutfitItem in pairs(vItems) do
					local vItem, vIgnoredItem = vInventoryCache:FindItemOrAlt(vOutfitItem, true)
					
					if vItem
					and not self:IsBankBagIndex(vItem.Location.BagIndex) then
						table.insert(vEquipmentChangeList, {FromLocation = vItem.Location, Item = vItem, ToLocation = nil})
					end
				end -- for
			end -- if vOutfit
		end -- for vOutfitIndex
	end -- for vCategoryID
	
	if #vEquipmentChangeList == 0 then
		return
	end
	
	-- Get the list of empty bank slots
	
	local vEmptyBankSlots = self:GetEmptyBankSlotList()
	
	-- Execute the changes
	
	self:ExecuteEquipmentChangeList2(vEquipmentChangeList, vEmptyBankSlots, self.cDepositBagsFullError, vExpectedInventoryCache)
	
	self:DispatchOutfitEvent("EDIT_OUTFIT", pOutfit:GetName(), pOutfit)
end

function Outfitter:WithdrawOutfit(pOutfit)
	local vInventoryCache = self:GetInventoryCache()
	
	-- Build a list of items for the outfit
	
	vInventoryCache:ResetIgnoreItemFlags()
	
	local vEquipmentChangeList = self:BuildUnequipChangeList(pOutfit, vInventoryCache)
	
	if not vEquipmentChangeList then
		return
	end
	
	-- Eliminate items which aren't in the bank
	
	local vChangeIndex = 1
	local vNumChanges = #vEquipmentChangeList
	
	while vChangeIndex <= vNumChanges do
		vEquipmentChange = vEquipmentChangeList[vChangeIndex]
		
		if not self:IsBankBagIndex(vEquipmentChange.FromLocation.BagIndex) then
			table.remove(vEquipmentChangeList, vChangeIndex)
			vNumChanges = vNumChanges - 1
		else
			vChangeIndex = vChangeIndex + 1
		end
	end
	
	-- Get the list of empty bag slots

	local vEmptyBagSlots = self:GetEmptyBagSlotList()
	
	-- Execute the changes
	
	self:ExecuteEquipmentChangeList2(vEquipmentChangeList, vEmptyBagSlots, self.cWithdrawBagsFullError, vExpectedInventoryCache)
	
	self:DispatchOutfitEvent("EDIT_OUTFIT", pOutfit:GetName(), pOutfit)
end

function Outfitter:WithdrawOtherOutfits(pOutfit)
	local vInventoryCache = self:GetInventoryCache()
	
	-- Build a list of items in all other outfits
	
	local vEquipmentChangeList = {}
	
	for vCategoryID, vOutfits in pairs(self.Settings.Outfits) do
		for vOutfitIndex, vOutfit in ipairs(vOutfits) do
			if vOutfit ~= pOutfit then
				local vItems = vOutfit:GetItems()
				
				for vInventorySlot, vOutfitItem in pairs(vItems) do
					local vItem, vIgnoredItem = vInventoryCache:FindItemOrAlt(vOutfitItem, true)
					
					if vItem
					and self:IsBankBagIndex(vItem.Location.BagIndex) then
						table.insert(vEquipmentChangeList, {FromLocation = vItem.Location, Item = vItem, ToLocation = nil})
					end
				end -- for
			end -- if vOutfit
		end -- for vOutfitIndex
	end -- for vCategoryID
	
	if #vEquipmentChangeList == 0 then
		return
	end
	
	-- Get the list of empty bag slots

	local vEmptyBagSlots = self:GetEmptyBagSlotList()
	
	-- Execute the changes
	
	self:ExecuteEquipmentChangeList2(vEquipmentChangeList, vEmptyBagSlots, self.cWithdrawBagsFullError, vExpectedInventoryCache)
	
	self:DispatchOutfitEvent("EDIT_OUTFIT", pOutfit:GetName(), pOutfit)
end

function Outfitter:TestAmmoSlot()
	local vItemInfo = self:GetInventoryItemInfo("AmmoSlot")
	local vSlotID = self.cSlotIDs.AmmoSlot
	local vItemLink = GetInventoryItemLink("player", vSlotID)
	
	self:DebugTable(vItemInfo, "vItemInfo")
	
	self:DebugMessage("SlotID: "..vSlotID)
	self:DebugMessage("ItemLink: "..vItemLink)
end

function Outfitter.GameToolTip_OnShow(...)
	Outfitter.EventLib:DispatchEvent("GAMETOOLTIP_SHOW")
end

function Outfitter.GameToolTip_OnHide(...)
	Outfitter.EventLib:DispatchEvent("GAMETOOLTIP_HIDE")
end

function Outfitter:GetOutfitsUsingItem(pItemInfo)
	local vFoundOutfits
	
	for vCategoryID, vOutfits in pairs(self.Settings.Outfits) do
		for _, vOutfit in ipairs(vOutfits) do
			if vOutfit:OutfitUsesItem(pItemInfo) then
				if not vFoundOutfits then
					vFoundOutfits = {}
				end
				
				table.insert(vFoundOutfits, vOutfit)
			end
		end
	end
	
	return vFoundOutfits
end

function Outfitter:GetOutfitsListAsText(pOutfits)
	if not pOutfits
	or #pOutfits == 0 then
		return
	end
	
	local vInventoryCache = self:GetInventoryCache()
	local vNames = nil
	
	for _, vOutfit in ipairs(pOutfits) do
		local vMissingItems, vBankedItems = vInventoryCache:GetMissingItems(vOutfit)
		local vName
		
		if vOutfit.Disabled then
			vName = GRAY_FONT_COLOR_CODE
		elseif vMissingItems then
			vName = RED_FONT_COLOR_CODE
		elseif vBankedItems then
			vName = self.BANKED_FONT_COLOR_CODE
		else
			vName = HIGHLIGHT_FONT_COLOR_CODE
		end

		 vName = vName..vOutfit:GetName()..FONT_COLOR_CODE_CLOSE
		
		if vNames then
			vNames = vNames..", "..vName
		else
			vNames = vName
		end
	end
	
	return vNames
end

function Outfitter:AddOutfitsUsingItemToTooltip(pTooltip, pItemInfo)
	local vOutfitListString
	
	if self.OutfitInfoCache.OutfitsUsingItem
	and self.OutfitInfoCache.OutfitsUsingItem.Link
	and self.OutfitInfoCache.OutfitsUsingItem.Link == pItemInfo.Link then
		vOutfitListString = self.OutfitInfoCache.OutfitsUsingItem.String
	else
		local vOutfits = self:GetOutfitsUsingItem(pItemInfo)
		
		if vOutfits then
			vOutfitListString = self:GetOutfitsListAsText(vOutfits)
		end
		
		-- Update the cache
		
		if pItemInfo.Link then
			if not self.OutfitInfoCache.OutfitsUsingItem then
				self.OutfitInfoCache.OutfitsUsingItem = {}
			end
			
			self.OutfitInfoCache.OutfitsUsingItem.Link = pItemInfo.Link
			self.OutfitInfoCache.OutfitsUsingItem.String = vOutfitListString
		end
	end
	
	--
	
	if vOutfitListString then
		local vEquipmentSetsPattern = Outfitter:ConvertFormatStringToSearchPattern(EQUIPMENT_SETS)
		
		local vTooltipListString = EQUIPMENT_SETS:format(vOutfitListString)
		local vLineIndex, vLineFrame = Outfitter:FindTooltipLine(pTooltip, vEquipmentSetsPattern)
		
		-- Found an existing EQUIPMENT_SETS line
		
		if vLineIndex then
			vLineFrame:SetText(vTooltipListString)
		
		-- Add a new line
		
		else
			pTooltip:AddLine(vTooltipListString, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, true)
			pTooltip:Show()
		end
	end
end

function Outfitter.GameTooltip_SetBagItem(pTooltip, pBag, pSlot, ...)
	local vResult = {pTooltip:Outfitter_OrigSetBagItem(pBag, pSlot, ...)}
	
	if not Outfitter.Settings.Options.DisableToolTipInfo then
		local vItemInfo = Outfitter:GetBagItemInfo(pBag, pSlot)
		
		if vItemInfo then
			Outfitter:AddOutfitsUsingItemToTooltip(pTooltip, vItemInfo)
		end
	end
	
	return unpack(vResult)
end

function Outfitter.GameTooltip_SetInventoryItem(pTooltip, pUnit, pSlotID, pNameOnly, ...)
	local vResult = {pTooltip:Outfitter_OrigSetInventoryItem(pUnit, pSlotID, pNameOnly, ...)}
	
	-- Add the list of outfits the item is used by
	
	if not Outfitter.Settings.Options.DisableToolTipInfo
	and UnitIsUnit(pUnit, "player") then
		local vInventorySlot = Outfitter.cSlotIDToInventorySlot[pSlotID]
		local vItemInfo = Outfitter:GetSlotIDItemInfo(pSlotID)
		
		if vItemInfo then
			vItemInfo.Location = {SlotName = vInventorySlot}
			
			Outfitter:AddOutfitsUsingItemToTooltip(pTooltip, vItemInfo)
		end
	end
	
	return unpack(vResult)
end

function Outfitter.GameTooltip_SetHyperlink(pTooltip, pLink, ...)
	local vResult = {pTooltip:Outfitter_OrigSetHyperlink(pLink, ...)}
	
	-- Add the list of outfits the item is used by
	
	if not Outfitter.Settings.Options.DisableToolTipInfo then
		local vItemInfo = Outfitter:GetItemInfoFromLink(pLink)
		
		if vItemInfo then
			Outfitter:AddOutfitsUsingItemToTooltip(pTooltip, vItemInfo)
		end
	end
	
	return unpack(vResult)
end

function Outfitter:InitializeFrameMethods(pFrame, pMethods)
	if pMethods then
		for vMethodField, vMethodFunction in pairs(pMethods) do
			pFrame[vMethodField] = vMethodFunction
		end
	end
end

function Outfitter:InitializeFrameWidgets(pFrame, pWidgets)
	if pWidgets then
		local vFrameName = pFrame:GetName()
		
		for _, vWidgetName in pairs(pWidgets) do
			if string.sub(vWidgetName, -1) == "*" then
				vWidgetName = vWidgetName:sub(1, -2)
				
				pFrame[vWidgetName] = {ParentFrame = _G[vFrameName..vWidgetName]}
				
				local vIndex = 1
				
				while true do
					local vWidget = _G[vFrameName..vWidgetName..vIndex]
					
					if not vWidget then
						break
					end
					
					vWidget:SetID(vIndex)
					table.insert(pFrame[vWidgetName], vWidget)
					
					vIndex = vIndex + 1
				end
			else
				pFrame[vWidgetName] = _G[vFrameName..vWidgetName]
			end
		end
	end
end

function Outfitter:TooltipContainsLine(pTooltip, pText)
	local vTooltipName = pTooltip:GetName()
	
	for vLine = 1, 30 do
		local vText = _G[vTooltipName.."TextLeft"..vLine]
		
		if not vText then
			return false
		end
		
		local vTextString = vText:GetText()
		
		if not vTextString then
			return false
		end
		
		if vTextString:find(pText) then
			local vColor = {}
			
			vColor.r, vColor.g, vColor.b = vText:GetTextColor()
			
			local vHSVColor = Outfitter:RGBToHSV(vColor)
			
			return true, vHSVColor.s > 0.2 and vHSVColor.v > 0.2 and (vHSVColor.h < 50 or vHSVColor.h > 150)
		end
	end
end

function Outfitter:RGBToHSV(pRGBColor)
	local vHSVColor = {}
	local vBaseAngle
	local vHueColor
	
	if not pRGBColor.r
	or not pRGBColor.g
	or not pRGBColor.b then
		vHSVColor.h = 0
		vHSVColor.s = 0
		vHSVColor.v = 1
		
		return vHSVColor
	end
	
	if pRGBColor.r >= pRGBColor.g
	and pRGBColor.r >= pRGBColor.b then
		-- Red is dominant
		
		vHSVColor.v = pRGBColor.r
		
		vBaseAngle = 0
		
		if pRGBColor.g >= pRGBColor.b then
			vHSVColor.s = 1 - pRGBColor.b
			vHueColor = pRGBColor.g
		else
			vHSVColor.s = 1 - pRGBColor.g
			vHueColor = -pRGBColor.b
		end
	elseif pRGBColor.g >= pRGBColor.b then
		-- Green is dominant

		vHSVColor.v = pRGBColor.g

		vBaseAngle = 120
		
		if pRGBColor.r >= pRGBColor.b then
			vHSVColor.s = 1 - pRGBColor.b
			vHueColor = -pRGBColor.r
		else
			vHSVColor.s = 1 - pRGBColor.r
			vHueColor = pRGBColor.b
		end
	else
		-- Blue is dominant
		
		vHSVColor.v = pRGBColor.b

		vBaseAngle = 240
		
		if pRGBColor.r >= pRGBColor.g then
			vHSVColor.s = 1 - pRGBColor.g
			vHueColor = pRGBColor.r
		else
			vHSVColor.s = 1 - pRGBColor.r
			vHueColor = -pRGBColor.g
		end
	end
	
	vHSVColor.h = vBaseAngle + (vHueColor / vHSVColor.v) * 60
	
	if vHSVColor.h < 0 then
		vHSVColor.h = vHSVColor.h + 360
	end
	
	return vHSVColor
end

function Outfitter:FrameEditBox(pEditBox)
	local vLeftTexture = pEditBox:CreateTexture(nil, "ARTWORK")
	
	vLeftTexture:SetWidth(12)
	vLeftTexture:SetPoint("TOPLEFT", pEditBox, "TOPLEFT", -11, 0)
	vLeftTexture:SetPoint("BOTTOMLEFT", pEditBox, "BOTTOMLEFT", -11, -9)
	vLeftTexture:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-FilterBorder")
	vLeftTexture:SetTexCoord(0, 0.09375, 0, 1)
	
	local vRightTexture = pEditBox:CreateTexture(nil, "ARTWORK")
	
	vRightTexture:SetWidth(12)
	vRightTexture:SetPoint("TOPRIGHT", pEditBox, "TOPRIGHT", -12, 0)
	vRightTexture:SetPoint("BOTTOMRIGHT", pEditBox, "BOTTOMRIGHT", -12, -9)
	vRightTexture:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-FilterBorder")
	vRightTexture:SetTexCoord(0.90625, 1, 0, 1)
	
	local vMiddleTexture = pEditBox:CreateTexture(nil, "ARTWORK")
	
	vMiddleTexture:SetPoint("TOPLEFT", vLeftTexture, "TOPRIGHT")
	vMiddleTexture:SetPoint("BOTTOMLEFT", vLeftTexture, "BOTTOMRIGHT")
	vMiddleTexture:SetPoint("TOPRIGHT", vRightTexture, "TOPLEFT")
	vMiddleTexture:SetPoint("BOTTOMRIGHT", vRightTexture, "BOTTOMLEFT")
	vMiddleTexture:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-FilterBorder")
	vMiddleTexture:SetTexCoord(0.09375, 0.90625, 0, 1)
end

function Outfitter:ConstructFrame(pFrame, pMethods, ...)
	for vKey, vValue in pairs(pMethods) do
		if vKey == "Widgets" and type(vValue) == "table" then
			if not pFrame.Widgets then
				pFrame.Widgets = {}
			end
			
			local vNamePrefix
			
			if pFrame.GetName then
				vNamePrefix = pFrame:GetName()
			else
				vNamePrefix = vValue._Prefix
			end
			
			if vNamePrefix then
				for _, vName in ipairs(vValue) do
					local vWidget = _G[vNamePrefix..vName]
					
					if vWidget == nil then
						self:ErrorMessage("Couldn't find global "..vNamePrefix..vName)
					else
						pFrame.Widgets[vName] = vWidget
					end
				end
			else
				Outfitter:ErrorMessage("ConstructFrame: Can't initialize widgets for frame because there's no name prefix")
				Outfitter:DebugStack()
			end
		else
			pFrame[vKey] = vValue
		end
	end
	
	if pMethods.Construct then
		pFrame:Construct(...)
	end
	
	return pFrame
end

function Outfitter.InitializeFrame(pObject, ...)
	if not pObject then
		Outfitter:DebugMessage("InitializeFrame called with nil object")
		Outfitter:DebugStack()
		return
	end
	
	local vNumClasses = select("#", ...)
	
	for vIndex = 1, vNumClasses do
		local vFunctionTable = select(vIndex, ...)
		
		for vFunctionName, vFunction in pairs(vFunctionTable) do
			if type(vFunction) == "table" then
				local vTable = {}
				
				pObject[vFunctionName] = vTable
				
				local vNamePrefix
				
				if pObject.GetName then
					vNamePrefix = pObject:GetName()
				else
					vNamePrefix = pObject[vFunctionName.."Prefix"]
				end
				
				for _, vName in ipairs(vFunction) do
					local vValue = _G[vNamePrefix..vName]
					
					if vValue == nil then
						self:ErrorMessage("Couldn't find global "..vNamePrefix..vName)
					else
						vTable[vName] = vValue
					end
				end
			else
				pObject[vFunctionName] = vFunction
			end
		end
	end
end

function Outfitter:GetCurrentOutfitInfo()
	return self.OutfitStack:GetCurrentOutfitInfo()
end

function Outfitter:SetUpdateDelay(pTime, pDelay)
	local vUpdateTime = pTime + (pDelay - self.cMinEquipmentUpdateInterval)

	if vUpdateTime > self.LastEquipmentUpdateTime then
		self.LastEquipmentUpdateTime = vUpdateTime
	end
end

function Outfitter:CalcItemHasUseFeature(pItemLink)
	-- Set the tooltip
	
	OutfitterTooltip:SetOwner(OutfitterFrame, "ANCHOR_BOTTOMRIGHT", 0, 0)
	
	if not OutfitterTooltip:SetHyperlink(pItemLink) then
		OutfitterTooltip:Hide()
		return false
	end
	
	-- Scan for a "Use:" line
	
	for vLineIndex = 1, 100 do
		local vLeftTextFrame = _G["OutfitterTooltipTextLeft"..vLineIndex]
		
		if not vLeftTextFrame then
			break
		end
		
		local vLeftText = vLeftTextFrame:GetText()
		
		if vLeftText then
			local vStartIndex, vEndIndex = vLeftText:find(Outfitter.cUseTooltipLineFormat)
			
			if vStartIndex then
				OutfitterTooltip:Hide()
				return true
			end
		end
	end -- for vLineIndex
	
	OutfitterTooltip:Hide()
	return false
end

function Outfitter:CalcItemUseDuration(pItemLink)
	-- Set the tooltip
	
	OutfitterTooltip:SetOwner(OutfitterFrame, "ANCHOR_BOTTOMRIGHT", 0, 0)
	
	if not OutfitterTooltip:SetHyperlink(pItemLink) then
		OutfitterTooltip:Hide()
		return false
	end
	
	-- Scan for a "Use:" line
	
	for vLineIndex = 1, 100 do
		local vLeftTextFrame = _G["OutfitterTooltipTextLeft"..vLineIndex]
		
		if not vLeftTextFrame then
			break
		end
		
		local vLeftText = vLeftTextFrame:GetText()
		
		if vLeftText then
			local vStartIndex, vEndIndex, vSeconds = vLeftText:find(Outfitter.cUseDurationTooltipLineFormat)
			
			if not vSeconds then
				vStartIndex, vEndIndex, vSeconds = vLeftText:find(Outfitter.cUseDurationTooltipLineFormat2)
			end
			
			if vSeconds then
				OutfitterTooltip:Hide()
				return tonumber(vSeconds)
			end
		end
	end -- for vLineIndex
	
	OutfitterTooltip:Hide()
	return 0
end

Outfitter.cItemHasUseFeature = {}
Outfitter.cItemUseDuration = {}

function Outfitter:ItemHasUseFeature(pItemLink)
	local vItemCode = self:ParseItemLink(pItemLink)
	local vHasUseFeature
	
	if self.cItemHasUseFeature[vItemCode] ~= nil then
		vHasUseFeature = self.cItemHasUseFeature[vItemCode]
	else
		vHasUseFeature = self:CalcItemHasUseFeature(pItemLink)
		
		self.cItemHasUseFeature[vItemCode] = vHasUseFeature
	end
	
	return vHasUseFeature
end

function Outfitter:GetItemUseDuration(pItemLink)
	local vItemCode = self:ParseItemLink(pItemLink)
	local vUseDuration
	
	if self.cItemUseDuration[vItemCode] then
		vUseDuration  = self.cItemUseDuration[vItemCode]
	else
		vUseDuration = self:CalcItemUseDuration(pItemLink)
		
		if not vUseDuration then
			vUseDuration = 0
		end
		
		self.cItemUseDuration[vItemCode] = vUseDuration
	end
	
	return vUseDuration
end

function Outfitter:InventoryItemIsActive(pInventorySlot)
	-- See if the item is on cooldown at all
	
	local vSlotID = self.cSlotIDs[pInventorySlot]
	local vItemLink = self:GetInventorySlotIDLink(vSlotID)
	local vStartTime, vDuration, vEnable = GetItemCooldown(vItemLink)
	
	if not vStartTime or vStartTime == 0 then
		return false
	end
	
	-- Determine if there's an activity period for the item
	
	local vUseDuration = self:GetItemUseDuration(vItemLink)
	
	-- If the time since started is less than the use duration the item is still active
	-- and shouldn't be unequipped
	
	return GetTime() < vStartTime + vUseDuration
end

-- Some diagnostic code for finding functions that take a long time to
-- execute.  This isn't installed automatically and must be manually called

function Outfitter:Hook()
	self:HookTable(Outfitter, "Outfitter")
end

function Outfitter:HookTable(pTable, pPrefix)
	for vKey, vValue in pairs(pTable) do
		if type(vKey) == "string"
		and type(vValue) == "function"
		and not vKey:find("Outfitter") then
			pTable[vKey] = function (...)
				local vStartTime = GetTime()
				local vResult = {vValue(...)}
				local vEndTime = GetTime()
				if vEndTime - vStartTime > 0.1 then
					self:DebugMessage("Function %s.%s took %f seconds", pPrefix, vKey, vEndTime - vStartTime)
				end
				
				return unpack(vResult)
			end
		end
	end
end

function Outfitter:ShowAllLinks()
	for vCategory, vOutfits in pairs(self.Settings.Outfits) do
		for _, vOutfit in ipairs(vOutfits) do
			local vItems = vOutfit:GetItems()
			
			for _, vItem in pairs(vItems) do
				if vItem.Code ~= 0 then
					self:NoteMessage(self:GenerateItemLink(vItem))
				end
			end
		end
	end
end

function Outfitter:GenerateItemLink(pItem)
	if not pItem or pItem.Code == 0 then
		return
	end
	
	local _, _, vQuality = GetItemInfo(pItem.Code)
	local _, _, _, vQualityColorCode = GetItemQualityColor(vQuality or 1)
	
	return string.format("%s|Hitem:%d:%d:%d:%d:%d:%d:%d:%d:%d|h[%s]|h|r", vQualityColorCode, pItem.Code, pItem.EnchantCode or 0, pItem.JewelCode1 or 0, pItem.JewelCode2 or 0, pItem.JewelCode3 or 0, pItem.JewelCode4 or 0, pItem.SubCode or 0, pItem.UniqueID or 0, 0, pItem.Name), vQuality or 1
end

function Outfitter:ShowMissingItems()
	if not Outfitter.BankFrameIsOpen then
		Outfitter:ErrorMessage(Outfitter.cMustBeAtBankError)
		return
	end
	
	local vInventoryCache = Outfitter:GetInventoryCache()
	local vFoundItems
	
	for vCategory, vOutfits in pairs(self.Settings.Outfits) do
		for _, vOutfit in ipairs(vOutfits) do
			local vMissingItems = vInventoryCache:GetMissingItems(vOutfit)
			
			if vMissingItems then
				for _, vItem in pairs(vMissingItems) do
					if not vFoundItems then
						Outfitter:NoteMessage(Outfitter.cMissingItemReportIntro)
						vFoundItems = true
					end
					
					Outfitter:NoteMessage(Outfitter:GenerateItemLink(vItem))
				end
			end
		end
	end
	
	if not vFoundItems then
		Outfitter:NoteMessage(Outfitter.cNoMissingItems)
	end
end

function Outfitter:CallCompanionByName(pName)
	local vNumCompanions = GetNumCompanions("CRITTER")
	local vLowerName = pName:lower()
	
	for vIndex = 1, vNumCompanions do
		if GetCompanionInfo("CRITTER", vIndex):lower() == vLowerName then
			CallCompanion("CRITTER", vIndex)
			return
		end
	end
	
	self:ErrorMessage("CallCompanionByName: couldn't find a pet named %s", tostring(pName))
end

function Outfitter:PlayerIsOnQuestID(pQuestID)
	local vNumQuests = GetNumQuestLogEntries()
	
	for vQuestIndex = 1, vNumQuests do
		local vQuestLink = GetQuestLink(vQuestIndex)
		
		if vQuestLink then
			local _, _, vQuestID = vQuestLink:find("|Hquest:(%d+)")
			
			if tonumber(vQuestID) == pQuestID then
				local _, _, vComplete = GetQuestLogLeaderBoard(1, vQuestIndex)
				
				return true, vComplete
			end
		end
	end
	
	return false
end

function Outfitter:GetCurrentTracking()
	local vNumTypes = GetNumTrackingTypes()
	
	for vIndex = 1, vNumTypes do
		local vName, vTexture, vActive = GetTrackingInfo(vIndex)
		
		if vActive then
			return vName, vTexture
		end
	end
end

function Outfitter:SetTrackingByName(pTrackingName)
	if not pTrackingName then
		SetTracking(nil)
		return
	end
	
	local vNumTypes = GetNumTrackingTypes()
	local vLowerName = pTrackingName and pTrackingName:lower()
	
	for vIndex = 1, vNumTypes do
		local vName, vTexture, vActive = GetTrackingInfo(vIndex)
		
		if vName:lower() == vLowerName then
			if not vActive then
				SetTracking(vIndex)
			end
			return
		end
	end
end

function Outfitter:SetTrackingByTexture(pTexture)
	if not pTexture then
		SetTracking(nil)
		return
	end
	
	local vNumTypes = GetNumTrackingTypes()
	local vLowerTexture = pTexture and pTexture:lower()
	
	for vIndex = 1, vNumTypes do
		local vName, vTexture, vActive = GetTrackingInfo(vIndex)
		
		if vTexture:lower() == vLowerTexture then
			if not vActive then
				SetTracking(vIndex)
			end
			return
		end
	end
end

----------------------------------------
Outfitter._ExtendedCompareTooltip = {}
----------------------------------------

function Outfitter._ExtendedCompareTooltip:Construct()
	hooksecurefunc("GameTooltip_ShowCompareItem", function (pShift)
		if not Outfitter.Settings.Options.DisableItemComparisons then
			self:ShowCompareItem(pShift)
		end
	end)
	
	GameTooltip:HookScript("OnHide", function ()
		self:HideCompareItems()
	end)
	
	self.Tooltips = {}
	self.NumTooltipsShown = 0
	self.MaxTooltipsShown = 5
end

function Outfitter._ExtendedCompareTooltip:ShowCompareItem()
	self:HideCompareItems()
	
	local _, vLink = GameTooltip:GetItem()
	
	if not vLink then
		return
	end
	
	local vTooltipItemCode,
	      vTooltipItemEnchantCode,
	      vTooltipItemJewelCode1,
	      vTooltipItemJewelCode2,
	      vTooltipItemJewelCode3,
	      vTooltipItemJewelCode4,
	      vTooltipItemSubCode,
	      vTooltipItemUniqueID,
	      vTooltipItemUnknownCode1,
	      vTooltipItemName = Outfitter:ParseItemLink(vLink)
	
	if not vTooltipItemCode then
		return
	end
	
	local vTooltipItemFamilyName,
	      vTooltipItemLink,
	      vTooltipItemQuality,
	      vTooltipItemLevel,
	      vTooltipItemMinLevel,
	      vTooltipItemType,
	      vTooltipItemSubType,
	      vTooltipItemCount,
	      vTooltipItemInvType = GetItemInfo(vTooltipItemCode)

	if not vTooltipItemInvType then
		return
	end
	
	-- Figure out which direction to stack in
	
	local vLeftDist = GameTooltip:GetLeft() or 0
	local vRightDist = GetScreenWidth() - (GameTooltip:GetRight() or 0)
	
	self.LeftToRight = vLeftDist < vRightDist
	
	-- Figure out which tooltip to attach to and
	-- append the 'used by' info on shopping tooltips
	
	self.AnchorToTooltip = GameTooltip
	
	for vIndex = 1, 100 do
		local vShoppingTooltip = _G["ShoppingTooltip"..vIndex]
		
		if not vShoppingTooltip then
			break
		end
		
		if not vShoppingTooltip:IsVisible() then
			break
		end
		
		local _, vShoppingLink = vShoppingTooltip:GetItem()
		local vShoppingItemInfo = Outfitter:GetItemInfoFromLink(vShoppingLink)
		
		if vShoppingItemInfo then
			Outfitter:AddOutfitsUsingItemToTooltip(vShoppingTooltip, vShoppingItemInfo)
			vShoppingTooltip:Show()
		end
		
		self.AnchorToTooltip = vShoppingTooltip
	end
	
	-- Determine which slots need to be examined
	
	local vInventorySlots = {}
	
	local vInvSlotInfo = Outfitter.cInvTypeToSlotName[vTooltipItemInvType]
	
	if not vInvSlotInfo then
		return
	end
	
	table.insert(vInventorySlots, vInvSlotInfo.SlotName)
	
	local vMetaSlotName = vInvSlotInfo.MetaSlotName or vInvSlotInfo.SlotName
	
	if vMetaSlotName == "Weapon0Slot" then
		table.insert(vInventorySlots, "SecondaryHandSlot")
	elseif vMetaSlotName == "Finger0Slot" then
		table.insert(vInventorySlots, "Finger1Slot")
	elseif vMetaSlotName == "Trinket0Slot" then
		table.insert(vInventorySlots, "Trinket1Slot")
	end
	
	-- Search outfits for items which can go in the same slot but which aren't
	-- listed in any of the currently shown tooltips
	
	local vShoppingItems = {}
	
	for vCategoryID, vOutfits in pairs(Outfitter.Settings.Outfits) do
		for vOutfitIndex, vOutfit in ipairs(vOutfits) do
			
			for _, vInventorySlot in ipairs(vInventorySlots) do
				local vItem = vOutfit:GetItem(vInventorySlot)
				
				if vItem then
					local vItemLink, vItemQuality = Outfitter:GenerateItemLink(vItem)
					
					if vItemLink
					and vItemQuality >= ITEM_QUALITY_UNCOMMON then
						table.insert(vShoppingItems, {Item = vItem, OutfitName = vOutfit:GetName(), Link = vItemLink})
					end
				end
			end
		end
	end
	
	table.sort(vShoppingItems, function (pItem1, pItem2)
		return (pItem1.Item.Level or 0) > (pItem2.Item.Level or 0)
	end)
	
	for _, vItem in ipairs(vShoppingItems) do
		if self.NumTooltipsShown >= self.MaxTooltipsShown then
			break
		end
		
		if not self:ShoppingItemIsShown(vItem.Item) then
			self:AddShoppingLink(vItem.OutfitName, vItem.Item.Name, vItem.Link)
		end
	end
end

function Outfitter._ExtendedCompareTooltip:HideCompareItems()
	for _, vTooltip in ipairs(self.Tooltips) do
		vTooltip:ClearAllPoints()
		vTooltip:Hide()
	end
	
	self.NumTooltipsShown = 0
	self.MaxTooltipsShown = 5
end

function Outfitter._ExtendedCompareTooltip:ItemsAreEquivalent(pItemInfo1, pItemInfo2)
	return pItemInfo1.Code == pItemInfo2.Code
	and pItemInfo1.SubCode == pItemInfo2.SubCode
	and (pItemInfo1.UniqueID == pItemInfo2.UniqueID or pItemInfo1.InvType == "INVTYPE_AMMO" or pItemInfo2.InvType == "INVTYPE_AMMO")
end

function Outfitter._ExtendedCompareTooltip:ShoppingItemIsShown(pItemInfo)
	local _, vTooltipLink = GameTooltip:GetItem()
	local vTooltipItemInfo = Outfitter:GetItemInfoFromLink(vTooltipLink)
	
	--Outfitter:DebugMessage("ShoppingLinkIsShown: Comparing GameTooltip %s to %s", tostring(vTooltipLink):gsub("|", "||"), tostring(vLink):gsub("|", "||"))
	
	if self:ItemsAreEquivalent(pItemInfo, vTooltipItemInfo) then
		return true
	end
	
	for vIndex = 1, 100 do
		local vTooltip = _G["ShoppingTooltip"..vIndex]
		
		if not vTooltip then
			break
		end
		
		if not vTooltip:IsVisible() then
			break
		end
		
		local _, vTooltipLink = vTooltip:GetItem()
		local vTooltipItemInfo = Outfitter:GetItemInfoFromLink(vTooltipLink)
		
		--Outfitter:DebugMessage("ShoppingLinkIsShown: Comparing ShoppingTooltip%d %s to %s", vIndex, tostring(vTooltipLink):gsub("|", "||"), tostring(vLink):gsub("|", "||"))
		--Outfitter:DebugTable(vTooltipItemInfo, "ItemInfo")
		
		if self:ItemsAreEquivalent(pItemInfo, vTooltipItemInfo) then
			return true
		end
	end
	
	for vIndex, vTooltip in ipairs(self.Tooltips) do
		if vIndex > self.NumTooltipsShown then
			break
		end
		
		local _, vTooltipLink = vTooltip:GetItem()
		local vTooltipItemInfo = Outfitter:GetItemInfoFromLink(vTooltipLink)
		
		--Outfitter:DebugMessage("ShoppingLinkIsShown: Comparing OutfitterShoppingTooltip%d %s to %s", vIndex, tostring(vTooltipLink):gsub("|", "||"), tostring(vLink):gsub("|", "||"))
		
		if self:ItemsAreEquivalent(pItemInfo, vTooltipItemInfo) then
			return true
		end
	end
	
	return false
end

function Outfitter._ExtendedCompareTooltip:AddShoppingLink(pTitle, pItemName, pLink)
	self.NumTooltipsShown = self.NumTooltipsShown + 1
	
	local vTooltip = self.Tooltips[self.NumTooltipsShown]
	
	if not vTooltip then
		vTooltip = CreateFrame("GameTooltip", "OutfitterCompareTooltip"..self.NumTooltipsShown, UIParent, "ShoppingTooltipTemplate")
		vTooltip:Hide()
		
		self.Tooltips[self.NumTooltipsShown] = vTooltip
	else
		local vTooltipName = vTooltip:GetName()
		local vLine = 2
		
		while true do
			local vTextLeft = _G[vTooltipName.."TextLeft"..vLine]
			
			if not vTextLeft then
				break
			end
			
			local vPoint, vRelativeTo, vRelativePoint, vOffsetX, vOffsetY = vTextLeft:GetPoint(1)
			
			vTextLeft:SetPoint(vPoint, vRelativeTo, vRelativePoint, 0, vOffsetY)
			
			vLine = vLine + 1
		end
	end
	
	local vTooltipName = vTooltip:GetName()
	
	vTooltip:SetOwner(self.AnchorToTooltip, "ANCHOR_NONE")
	
	if self.LeftToRight then
		vTooltip:SetPoint("TOPLEFT", self.AnchorToTooltip, "TOPRIGHT", 0, 0)
	else
		vTooltip:SetPoint("TOPRIGHT", self.AnchorToTooltip, "TOPLEFT", 0, 0)
	end
	
	vTooltip:SetHyperlink(pLink)
	
	-- Shift all lines down by one
	
	self:ShiftTooltipDown(vTooltip)
	
	-- Set the first line to the outfit name and Outfitter label
	
	local vTextLeft, vTextRight = _G[vTooltipName.."TextLeft1"], _G[vTooltipName.."TextRight1"]
	
	vTextLeft:SetText(pTitle)
	vTextLeft:SetTextColor(0.5, 0.5, 0.5)
	
	vTextRight:SetText(Outfitter.cTitle)
	vTextRight:SetTextColor(0.5, 0.5, 0.5)
	vTextRight:Show()
	
	-- Call LibTipHooker clients so they can add extra info
	
	if Outfitter.LibTipHooker.HandlerList.item then
		for vHandler in pairs(Outfitter.LibTipHooker.HandlerList.item) do
			vHandler(vTooltip, pItemName, pLink)
		end
	end
	
	-- Add "Used by:" info (should integrate this with LibTipHooker)
		
	local vItemInfo = Outfitter:GetItemInfoFromLink(pLink)
	
	if vItemInfo then
		Outfitter:AddOutfitsUsingItemToTooltip(vTooltip, vItemInfo)
	end
	
	vTooltip:Show()
	
	self.AnchorToTooltip = vTooltip
end

function Outfitter._ExtendedCompareTooltip:ShiftTooltipDown(pTooltip)
	local vTooltipName = pTooltip:GetName()
	local vNumLines = pTooltip:NumLines()
	
	-- Make room for the last line
	
	pTooltip:AddLine(" ", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1)
	
	-- Shift all lines down, starting from the bottom and going up
	
	for vLine = vNumLines, 1, -1 do
		local vTextLeft, vTextRight = _G[vTooltipName.."TextLeft"..vLine], _G[vTooltipName.."TextRight"..vLine]
		local vNextTextLeft, vNextTextRight = _G[vTooltipName.."TextLeft"..(vLine + 1)], _G[vTooltipName.."TextRight"..(vLine + 1)]
		
		self:CopyFontString(vTextLeft, vNextTextLeft)
		self:CopyFontString(vTextRight, vNextTextRight)
		
		-- Copy the horiz offset if it isn't line 1
		
		if vLine > 1 then
			local vPoint, vRelativeTo, vRelativePoint, vOffsetX, vOffsetY = vTextLeft:GetPoint(1)
			local vNextPoint, vNextRelativeTo, vNextRelativePoint, vNextOffsetX, vNextOffsetY = vNextTextLeft:GetPoint(1)
			vNextTextLeft:ClearAllPoints()
			vNextTextLeft:SetPoint(vNextPoint, vNextRelativeTo, vNextRelativePoint, vOffsetX, vNextOffsetY)
		end
	end
	
	-- Re-position any textures being used
	
	for vIndex = 1, pTooltip:NumLines() do
		local vTexture = _G[vTooltipName.."Texture"..vIndex]
		
		if not vTexture then
			break
		end
		
		if vTexture:IsVisible() then
			local vPoint, vRelativeTo, vRelativePoint, vOffsetX, vOffsetY = vTexture:GetPoint(1)
			
			vRelativeTo = vRelativeTo:GetName():gsub("(%d+)$", function (pIndex) return tonumber(pIndex) + 1 end)
			
			vTexture:ClearAllPoints()
			vTexture:SetPoint(vPoint, vRelativeTo, vRelativePoint, vOffsetX, vOffsetY)
		end
	end
end

function Outfitter._ExtendedCompareTooltip:CopyFontString(pFromString, pToString)
	-- pToString:SetFont(pFromString:GetFont())
	-- pToString:SetJustifyH(pFromString:GetJustifyH())
	-- pToString:SetJustifyV(pFromString:GetJustifyV())
	-- pToString:SetShadowColor(pFromString:GetShadowColor())
	-- pToString:SetShadowOffset(pFromString:GetShadowOffset())
	-- pToString:SetSpacing(pFromString:GetSpacing())
	pToString:SetTextColor(pFromString:GetTextColor())
	pToString:SetText(pFromString:GetText())
end

function Outfitter:NewEmptyOutfit(pName)
	local vOutfit =
	{
		Name = pName,
		Items = {},
	}
	
	setmetatable(vOutfit, Outfitter._OutfitMetaTable)
	
	return vOutfit
end

function Outfitter:GetIconIndex(pTexture)
	if not pTexture then
		return
	end
	
	local _, _, vTexture = pTexture:find("([^\\]*)$")

	for vIndex = INVSLOT_FIRST_EQUIPPED, INVSLOT_LAST_EQUIPPED do
		local vTexture2 = GetInventoryItemTexture("player", vIndex)
		
		if vTexture2 then
			_, _, vTexture2 = vTexture2:find("([^\\]*)$")
			
			if vTexture2 == vTexture then
				return -vIndex
			end
		end
	end
	
	local vNumIcons = GetNumMacroIcons()
	
	for vIndex = 1, vNumIcons do
		local vTexture2 = GetMacroIconInfo(vIndex)
		_, _, vTexture2 = vTexture2:find("([^\\]*)$")
		
		if vTexture2 == vTexture then
			return vIndex
		end
	end
end

function Outfitter:SummonCompanionByName(pName, pDelay)
	local vNumCompanions = GetNumCompanions("CRITTER")
	local vLowerName = pName:lower()

	for vIndex = 1, vNumCompanions do
		local vCreatureID, vName, vSpellID, vIcon, vIsSummoned = GetCompanionInfo("CRITTER", vIndex)
		
		if vName:lower() == vLowerName then
			if not vIsSummoned then
				if pDelay then
					Outfitter.SchedulerLib:ScheduleTask(2, function () CallCompanion("CRITTER", vIndex) end)
				else
					CallCompanion("CRITTER", vIndex)
				end
			end
			
			return true
		end
	end
end

function Outfitter:Run(pText)
	local vCommand = pText:match("^(/[^%s]+)") or ""
	local vMessage

	if vCommand ~= pText then
		vMessage = pText:sub(vCommand:len() + 2);
	else
		vMessage = ""
	end

	vCommand = vCommand:upper()
	
	for vCommandID, vCommandFunc in pairs(SlashCmdList) do
		local vIndex = 1
		local vString = _G["SLASH_"..vCommandID..vIndex]
		
		while vString do
			if vString:upper() == vCommand then
				vCommandFunc(pText)
				return
			end
			vIndex = vIndex + 1
			vString = _G["SLASH_"..vCommandID..vIndex]
		end
	end
	
end
