--[[
Name: LibStatLogic-1.1
Description: A Library for stat conversion, calculation and summarization.
Revision: $Revision: 108 $
Author: Whitetooth
Email: hotdogee [at] gmail [dot] com
Last Update: $Date: 2010-10-06 00:11:07 -0500 (Wed, 06 Oct 2010) $
Website:
Documentation:
SVN: $URL $
Dependencies: UTF8
License: LGPL v3
Features:
	StatConversion -
		Ratings -> Effect
		Str -> AP, Block
		Agi -> Crit, Dodge, AP, RAP, Armor
		Sta -> Health, SpellDmg(Talent)
		Int -> Mana, SpellCrit
		Spi -> MP5, HP5
		and more!
	StatMods - Get stat mods from talents and buffs for every class
	BaseStats - for all classes and levels
	ItemStatParser - Fast multi level indexing algorithm instead of calling strfind for every stat
]]

local MAJOR = "LibStatLogic-1.1"
local MINOR = "$Revision: 108 $"

local StatLogic = LibStub:NewLibrary(MAJOR, MINOR)
if not StatLogic then return end


----------------------
-- Version Checking --
----------------------
local wowBuildNo = tonumber((select(2, GetBuildInfo())))
StatLogic.wowBuildNo = wowBuildNo
local toc = tonumber((select(4, GetBuildInfo())))


-------------------
-- Set Debugging --
-------------------
local DEBUG = false
function CmdHandler()
	DEBUG = not DEBUG
end
SlashCmdList["STATLOGICDEBUG"] = CmdHandler
SLASH_STATLOGICDEBUG1 = "/sldebug"


-----------------
-- Debug Tools --
-----------------
local function debugPrint(text)
	if DEBUG == true then
		print(text)
	end
end

--[[---------------------------------
	:SetTip(item)
-------------------------------------
Notes:
	* This is a debugging tool for localizers
	* Displays item in ItemRefTooltip
	* item:
	:;itemId : number - The numeric ID of the item. ie. 12345
	:;"itemString" : string - The full item ID in string format, e.g. "item:12345:0:0:0:0:0:0:0".
	:::Also supports partial itemStrings, by filling up any missing ":x" value with ":0", e.g. "item:12345:0:0:0"
	:;"itemName" : string - The Name of the Item, ex: "Hearthstone"
	:::The item must have been equiped, in your bags or in your bank once in this session for this to work.
	:;"itemLink" : string - The itemLink, when Shift-Clicking items.
Arguments:
	number or string - itemId or "itemString" or "itemName" or "itemLink"
Returns:
	None
Example:
	StatLogic:SetTip("item:3185:0:0:0:0:0:1957")
-----------------------------------]]
function StatLogic:SetTip(item)
	local name, link, _, _, reqLv, _, _, _, itemType = GetItemInfo(item)
	if not link then
		DEFAULT_CHAT_FRAME:AddMessage("|c00ff0000Item not in local cache. Run '/item itemid' to quary server(requires Sniff addon).|r")
		return
	end
	ItemRefTooltip:ClearLines()
	ShowUIPanel(ItemRefTooltip)
	if ( not ItemRefTooltip:IsShown() ) then
		ItemRefTooltip:SetOwner(UIParent, "ANCHOR_PRESERVE")
	end
	ItemRefTooltip:SetHyperlink(link)
end

-------------------------
-- Localization Tables --
-------------------------
--[[
Localization tips
1. Enable debugging in game with /sldebug
2. There are often ItemIDs in comments for you to check if the items works correctly in game
3. Use the addon Sniff(http://www.wowinterface.com/downloads/info6259/) to get a link in game from an ItemID, Usage: /item 19316
4. Atlas + AtlasLoot is also a good source of items to check
5. Red colored text output from debug means that line does not have a match
6. Building your own ItemStrings(ex: "item:28484:1503:0:2946:2945:0:0:0"): http://www.wowwiki.com/ItemString
   linkType, itemId, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, suffixId, uniqueId
7. Getting a visual on your ItemString:
	a. Display the ItemRefTooltip by clicking on a link in chat
	b. /dump StatLogic:SetTip("item:23344:2746")
6. Testing Enchants:
	a. Obtain the enchantId from wowhead.
		EX: Find the enchantId for [Golden Spellthread]:
		Find the spell page for the enchant: http://www.wowhead.com/?spell=31370
		Under Spell Details, look for "Enchant Item Permanent (2746)"
		2746 is the enchantId
	b. We need an item to attach the enchant, I like to use [Scout's Pants] ID:23344. (/item 23344 if you don't have it in your cache)
		ItemString: "item:23344:2746"
	c. /dump StatLogic:GetSum("item:23344:2746")
--]]
--[[
-- Item Stat Scanning Procedure
-- Trim spaces using strtrim(text)
-- Strip color codes
-- 1. Fast Exclude - Exclude obvious lines that do not need to be checked
--    Exclude a string by matching the whole string, these strings are indexed in L.Exclude.
--    Exclude a string by looking at the first X chars, these strings are indexed in L.Exclude.
--    Exclude lines starting with '"'. (Flavor text)
--    Exclude lines that are not white and green and normal (normal for Frozen Wrath bonus)
-- 2. Whole Text Lookup - Mainly used for enchants or stuff without numbers
--    Whole strings are indexed in L.WholeTextLookup
-- 3. Single Plus Stat Check - "+10 Spirit"
--    String is matched with pattern L.SinglePlusStatCheck, 2 captures are returned.
--    If a match is found, the non-number capture is looked up in L.StatIDLookup.
-- 4. Single Equip Stat Check - "Equip: Increases attack power by 81."
--    String is matched with pattern L.SingleEquipStatCheck, 2 captures are returned.
--    If a match is found, the non-number capture is looked up in L.StatIDLookup.
-- 5. Pre Scan - Short list of patterns that will be checked before going into Deep Scan.
-- 6. Deep Scan - When all the above checks fail, we will use the Deep Scan, this is slow but only about 10% of the lines need it.
--    Strip leading "Equip: ", "Socket Bonus: ".
--    Strip trailing ".".
--    Separate the string using L.DeepScanSeparators.
--    Check if the separated strings are found in L.WholeTextLookup.
--    Try to match each separated string to patterns in L.DeepScanPatterns in order, patterns in L.DeepScanPatterns should have less inclusive patterns listed first and more inclusive patterns listed last.
--    If no match then separate the string using L.DeepScanWordSeparators, then check again.
--]]
--[[DEBUG stuff, no need to translate
textTable = {
	"Spell Damage +6 and Spell Hit Rating +5",
	"+3 Stamina, +4 Critical Strike Rating",
	"+26 Healing Spells & 2% Reduced Threat",
	"+3 Stamina/+4 Critical Strike Rating",
	"Socket Bonus: 2 mana per 5 sec.",
	"Equip: Increases damage and healing done by magical spells and effects by up to 150.",
	"Equip: Increases the spell critical strike rating of all party members within 30 yards by 28.",
	"Equip: Increases damage and healing done by magical spells and effects of all party members within 30 yards by up to 33.",
	"Equip: Increases healing done by magical spells and effects of all party members within 30 yards by up to 62.",
	"Equip: Increases your spell damage by up to 120 and your healing by up to 300.",
	"Equip: Restores 11 mana per 5 seconds to all party members within 30 yards.",
	"Equip: Increases healing done by spells and effects by up to 300.",
	"Equip: Increases attack power by 420 in Cat, Bear, Dire Bear, and Moonkin forms only.",
	"+10 Defense Rating/+10 Stamina/+15 Block Value", -- ZG Enchant
	"+26 Attack Power and +14 Critical Strike Rating", -- Swift Windfire Diamond ID:28556
	"+26 Healing Spells & 2% Reduced Threat", -- Bracing Earthstorm Diamond ID:25897
	"+6 Spell Damage, +5 Spell Crit Rating", -- Potent Ornate Topaz ID: 28123
	----
	"Critical Rating +6 and Dodge Rating +5", -- Assassin's Fire Opal ID:30565
	"Healing +11 and 2 mana per 5 sec.", -- Royal Tanzanite ID: 30603
}
--]]
local PatternLocale = {}
local DisplayLocale = {}
PatternLocale.enUS = {
	["tonumber"] = tonumber,
	-----------------
	-- Armor Types --
	-----------------
	Plate = "Plate",
	Mail = "Mail",
	Leather = "Leather",
	Cloth = "Cloth",
	------------------
	-- Fast Exclude --
	------------------
	-- By looking at the first ExcludeLen letters of a line we can exclude a lot of lines
	["ExcludeLen"] = 5, -- using string.utf8len
	["Exclude"] = {
		[""] = true,
		[" \n"] = true,
		[ITEM_BIND_ON_EQUIP] = true, -- ITEM_BIND_ON_EQUIP = "Binds when equipped"; -- Item will be bound when equipped
		[ITEM_BIND_ON_PICKUP] = true, -- ITEM_BIND_ON_PICKUP = "Binds when picked up"; -- Item will be bound when picked up
		[ITEM_BIND_ON_USE] = true, -- ITEM_BIND_ON_USE = "Binds when used"; -- Item will be bound when used
		[ITEM_BIND_QUEST] = true, -- ITEM_BIND_QUEST = "Quest Item"; -- Item is a quest item (same logic as ON_PICKUP)
		[ITEM_SOULBOUND] = true, -- ITEM_SOULBOUND = "Soulbound"; -- Item is Soulbound
		[ITEM_STARTS_QUEST] = true, -- ITEM_STARTS_QUEST = "This Item Begins a Quest"; -- Item is a quest giver
		[ITEM_CANT_BE_DESTROYED] = true, -- ITEM_CANT_BE_DESTROYED = "That item cannot be destroyed."; -- Attempted to destroy a NO_DESTROY item
		[ITEM_CONJURED] = true, -- ITEM_CONJURED = "Conjured Item"; -- Item expires
		[ITEM_DISENCHANT_NOT_DISENCHANTABLE] = true, -- ITEM_DISENCHANT_NOT_DISENCHANTABLE = "Cannot be disenchanted"; -- Items which cannot be disenchanted ever
		["Disen"] = true, -- ITEM_DISENCHANT_ANY_SKILL = "Disenchantable"; -- Items that can be disenchanted at any skill level
		-- ITEM_DISENCHANT_MIN_SKILL = "Disenchanting requires %s (%d)"; -- Minimum enchanting skill needed to disenchant
		["Durat"] = true, -- ITEM_DURATION_DAYS = "Duration: %d days";
		["<Made"] = true, -- ITEM_CREATED_BY = "|cff00ff00<Made by %s>|r"; -- %s is the creator of the item
		["Coold"] = true, -- ITEM_COOLDOWN_TIME_DAYS = "Cooldown remaining: %d day";
		["Uniqu"] = true, -- Unique (20) -- ITEM_UNIQUE = "Unique"; -- Item is unique -- ITEM_UNIQUE_MULTIPLE = "Unique (%d)"; -- Item is unique
		["Requi"] = true, -- Requires Level xx -- ITEM_MIN_LEVEL = "Requires Level %d"; -- Required level to use the item
		["\nRequ"] = true, -- Requires Level xx -- ITEM_MIN_SKILL = "Requires %s (%d)"; -- Required skill rank to use the item
		["Class"] = true, -- Classes: xx -- ITEM_CLASSES_ALLOWED = "Classes: %s"; -- Lists the classes allowed to use this item
		["Races"] = true, -- Races: xx (vendor mounts) -- ITEM_RACES_ALLOWED = "Races: %s"; -- Lists the races allowed to use this item
		["Use: "] = true, -- Use: -- ITEM_SPELL_TRIGGER_ONUSE = "Use:";
		["Chanc"] = true, -- Chance On Hit: -- ITEM_SPELL_TRIGGER_ONPROC = "Chance on hit:";
		-- Set Bonuses
		-- ITEM_SET_BONUS = "Set: %s";
		-- ITEM_SET_BONUS_GRAY = "(%d) Set: %s";
		-- ITEM_SET_NAME = "%s (%d/%d)"; -- Set name (2/5)
		["Set: "] = true,
		["(2) S"] = true,
		["(3) S"] = true,
		["(4) S"] = true,
		["(5) S"] = true,
		["(6) S"] = true,
		["(7) S"] = true,
		["(8) S"] = true,
		-- Equip type
		["Projectile"] = true, -- Ice Threaded Arrow ID:19316
		[INVTYPE_AMMO] = true,
		[INVTYPE_HEAD] = true,
		[INVTYPE_NECK] = true,
		[INVTYPE_SHOULDER] = true,
		[INVTYPE_BODY] = true,
		[INVTYPE_CHEST] = true,
		[INVTYPE_ROBE] = true,
		[INVTYPE_WAIST] = true,
		[INVTYPE_LEGS] = true,
		[INVTYPE_FEET] = true,
		[INVTYPE_WRIST] = true,
		[INVTYPE_HAND] = true,
		[INVTYPE_FINGER] = true,
		[INVTYPE_TRINKET] = true,
		[INVTYPE_CLOAK] = true,
		[INVTYPE_WEAPON] = true,
		[INVTYPE_SHIELD] = true,
		[INVTYPE_2HWEAPON] = true,
		[INVTYPE_WEAPONMAINHAND] = true,
		[INVTYPE_WEAPONOFFHAND] = true,
		[INVTYPE_HOLDABLE] = true,
		[INVTYPE_RANGED] = true,
		[INVTYPE_THROWN] = true,
		[INVTYPE_RANGEDRIGHT] = true,
		[INVTYPE_RELIC] = true,
		[INVTYPE_TABARD] = true,
		[INVTYPE_BAG] = true,
	},
	-----------------------
	-- Whole Text Lookup --
	-----------------------
	-- Mainly used for enchants that doesn't have numbers in the text
	-- http://wow.allakhazam.com/db/enchant.html?slot=0&locale=enUS
	["WholeTextLookup"] = {
		[EMPTY_SOCKET_RED] = {["EMPTY_SOCKET_RED"] = 1}, -- EMPTY_SOCKET_RED = "Red Socket";
		[EMPTY_SOCKET_YELLOW] = {["EMPTY_SOCKET_YELLOW"] = 1}, -- EMPTY_SOCKET_YELLOW = "Yellow Socket";
		[EMPTY_SOCKET_BLUE] = {["EMPTY_SOCKET_BLUE"] = 1}, -- EMPTY_SOCKET_BLUE = "Blue Socket";
		[EMPTY_SOCKET_META] = {["EMPTY_SOCKET_META"] = 1}, -- EMPTY_SOCKET_META = "Meta Socket";

		["Minor Wizard Oil"] = {["SPELL_DMG"] = 8, ["HEAL"] = 8}, -- ID: 20744
		["Lesser Wizard Oil"] = {["SPELL_DMG"] = 16, ["HEAL"] = 16}, -- ID: 20746
		["Wizard Oil"] = {["SPELL_DMG"] = 24, ["HEAL"] = 24}, -- ID: 20750
		["Brilliant Wizard Oil"] = {["SPELL_DMG"] = 36, ["HEAL"] = 36, ["SPELL_CRIT_RATING"] = 14}, -- ID: 20749
		["Superior Wizard Oil"] = {["SPELL_DMG"] = 42, ["HEAL"] = 42}, -- ID: 22522
		["Blessed Wizard Oil"] = {["SPELL_DMG_UNDEAD"] = 60}, -- ID: 23123

		["Minor Mana Oil"] = {["MANA_REG"] = 4}, -- ID: 20745
		["Lesser Mana Oil"] = {["MANA_REG"] = 8}, -- ID: 20747
		["Brilliant Mana Oil"] = {["MANA_REG"] = 12, ["HEAL"] = 25}, -- ID: 20748
		["Superior Mana Oil"] = {["MANA_REG"] = 14}, -- ID: 22521

		--["Eternium Line"] = {["FISHING"] = 5}, -- +5 Fishing
		--["Savagery"] = {["AP"] = 70}, -- +70 Attack Power
		--["Vitality"] = {["MANA_REG"] = 4, ["HEALTH_REG"] = 4}, -- +4 Mana and Health every 5 sec
		--["Soulfrost"] = {["SHADOW_SPELL_DMG"] = 54, ["FROST_SPELL_DMG"] = 54}, -- Changed to +54 Shadow and Frost Spell Power
		--["Sunfire"] = {["ARCANE_SPELL_DMG"] = 50, ["FIRE_SPELL_DMG"] = 50}, -- Changed to +50 Arcane and Fire Spell Power

		-- ["Mithril Spurs"] = {["MOUNT_SPEED"] = 4}, -- +4% Mount Speed
		-- ["Minor Mount Speed Increase"] = {["MOUNT_SPEED"] = 2}, -- +2% Mount Speed
		["Equip: Run speed increased slightly."] = {["RUN_SPEED"] = 8}, -- [Highlander's Plate Greaves] ID: 20048
		["Minor Speed Increase"] = {["RUN_SPEED"] = 8}, -- EnchantID: 911 Enchant Boots - Minor Speed "Minor Speed Increase"
		["Minor Speed"] = {["RUN_SPEED"] = 8}, -- EnchantID: 2939 Enchant Boots - Cat's Swiftness "Minor Speed and +6 Agility"
		--["Surefooted"] = {["MELEE_HIT_RATING"] = 10, ["SPELL_HIT_RATING"] = 10, ["MELEE_CRIT_RATING"] = 10, ["SPELL_CRIT_RATING"] = 10}, -- EnchantID: 2658 Enchant Boots - Surefooted

		--["Subtlety"] = {["MOD_THREAT"] = -2}, -- EnchantID: 2621 Enchant Cloak - Subtlety
		["2% Reduced Threat"] = {["MOD_THREAT"] = -2}, -- EnchantID: 2621, 2832, 3296 
		["Equip: Allows underwater breathing."] = false, -- [Band of Icy Depths] ID: 21526
		["Allows underwater breathing"] = false, --
		["Equip: Immune to Disarm."] = false, -- [Stronghold Gauntlets] ID: 12639
		["Immune to Disarm"] = false, --
		["Crusader"] = false, -- Enchant Crusader
		["Lifestealing"] = false, -- Enchant Crusader

		--["Tuskar's Vitality"] = {["RUN_SPEED"] = 8, ["STA"] = 15}, -- EnchantID: 3232 +15 Stamina and Minor Speed Increase
		--["Wisdom"] = {["MOD_THREAT"] = -2, ["SPI"] = 10}, -- EnchantID: 3296 +10 Spirit and 2% Reduced Threat
		--["Accuracy"] = {["MELEE_HIT_RATING"] = 25, ["SPELL_HIT_RATING"] = 25, ["MELEE_CRIT_RATING"] = 25, ["SPELL_CRIT_RATING"] = 25}, -- EnchantID: 3788 +25 Hit Rating and +25 Critical Strike Rating
		--["Scourgebane"] = {["AP_UNDEAD"] = 140}, -- EnchantID: 3247 +140 Attack Power versus Undead
		--["Icewalker"] = {["MELEE_HIT_RATING"] = 12, ["SPELL_HIT_RATING"] = 12, ["MELEE_CRIT_RATING"] = 12, ["SPELL_CRIT_RATING"] = 12}, -- EnchantID: 3826 +12 Hit Rating and +12 Critical Strike Rating
		["Gatherer"] = {["HERBALISM"] = 5, ["MINING"] = 5, ["SKINNING"] = 5}, -- EnchantID: 3296
		--["Greater Vitality"] = {["MANA_REG"] = 6, ["HEALTH_REG"] = 6}, -- EnchantID: 3244 +7 Health and Mana every 5 sec

		--["+37 Stamina and +20 Defense"] = {["STA"] = 37, ["DEFENSE_RATING"] = 20}, -- EnchantID: 3818 Defense does not equal Defense Rating...
		["Rune of Swordbreaking"] = {["PARRY"] = 2}, -- EnchantID: 3594
		["Rune of Swordshattering"] = {["PARRY"] = 4}, -- EnchantID: 3365
		["Rune of the Stoneskin Gargoyle"] = {["DEFENSE"] = 25, ["MOD_STA"] = 2}, -- EnchantID: 3847
		["Rune of the Nerubian Carapace"] = {["DEFENSE"] = 13, ["MOD_STA"] = 1}, -- EnchantID: 3883
	},
	----------------------------
	-- Single Plus Stat Check --
	----------------------------
	-- depending on locale, it may be
	-- +19 Stamina = "^%+(%d+) (.-)%.?$"
	-- Stamina +19 = "^(.-) %+(%d+)%.?$"
	-- +19 耐力 = "^%+(%d+) (.-)%.?$"
	-- Some have a "." at the end of string like:
	-- Enchant Chest - Restore Mana Prime "+6 mana every 5 sec. "
	["SinglePlusStatCheck"] = "^([%+%-]%d+) (.-)%.?$",
	-----------------------------
	-- Single Equip Stat Check --
	-----------------------------
	-- stat1, value, stat2 = strfind
	-- stat = stat1..stat2
	-- "^Equip: (.-) by u?p? ?t?o? ?(%d+) ?(.-)%.?$"
	["SingleEquipStatCheck"] = "^Equip: (.-) by u?p? ?t?o? ?(%d+) ?(.-)%.?$",
	-------------
	-- PreScan --
	-------------
	-- Special cases that need to be dealt with before deep scan
	["PreScanPatterns"] = {
		--["^Equip: Increases attack power by (%d+) in Cat"] = "FERAL_AP",
		--["^Equip: Increases attack power by (%d+) when fighting Undead"] = "AP_UNDEAD", -- Seal of the Dawn ID:13029
		["^Increases attack power by (%d+) in Cat, Bear, Dire Bear, and Moonkin forms only%.$"] = "FERAL_AP", -- 3.0.8 FAP change
		["^(%d+) Block$"] = "BLOCK_VALUE",
		["^(%d+) Armor$"] = "ARMOR",
		["Reinforced %(%+(%d+) Armor%)"] = "ARMOR_BONUS",
		["Mana Regen (%d+) per 5 sec%.$"] = "MANA_REG",
		["^%+?%d+ %- (%d+) .-Damage$"] = "MAX_DAMAGE",
		["^%(([%d%.]+) damage per second%)$"] = "DPS",
		-- Exclude
		["^(%d+) Slot"] = false, -- Bags
		["^[%a '%-]+%((%d+)/%d+%)$"] = false, -- Set Name (0/9)
		["|cff808080"] = false, -- Gray text "  |cff808080Requires at least 2 Yellow gems|r\n  |cff808080Requires at least 1 Red gem|r"
		-- Procs
		--["[Cc]hance"] = false, -- [Mark of Defiance] ID:27924 -- [Staff of the Qiraji Prophets] ID:21128 -- Commented out because it was blocking [Insightful Earthstorm Diamond]
		["[Ss]ometimes"] = false, -- [Darkmoon Card: Heroism] ID:19287
		["[Ww]hen struck in combat"] = false, -- [Essence of the Pure Flame] ID: 18815
	},
	--------------
	-- DeepScan --
	--------------
	-- Strip leading "Equip: ", "Socket Bonus: "
	["Equip: "] = "Equip: ", -- ITEM_SPELL_TRIGGER_ONEQUIP = "Equip:";
	["Socket Bonus: "] = "Socket Bonus: ", -- ITEM_SOCKET_BONUS = "Socket Bonus: %s"; -- Tooltip tag for socketed item matched socket bonuses
	-- Strip trailing "."
	["."] = ".",
	["DeepScanSeparators"] = {
		"/", -- "+10 Defense Rating/+10 Stamina/+15 Block Value": ZG Enchant
		" & ", -- "+26 Healing Spells & 2% Reduced Threat": Bracing Earthstorm Diamond ID:25897
		", ", -- "+6 Spell Damage, +5 Spell Crit Rating": Potent Ornate Topaz ID: 28123
		"%. ", -- "Equip: Increases attack power by 81 when fighting Undead. It also allows the acquisition of Scourgestones on behalf of the Argent Dawn.": Seal of the Dawn
	},
	["DeepScanWordSeparators"] = {
		" and ", -- "Critical Rating +6 and Dodge Rating +5": Assassin's Fire Opal ID:30565
	},
	["DualStatPatterns"] = { -- all lower case
		["^%+(%d+) healing and %+(%d+) spell damage$"] = {{"HEAL",}, {"SPELL_DMG",},},
		["^%+(%d+) healing %+(%d+) spell damage$"] = {{"HEAL",}, {"SPELL_DMG",},},
		["^increases healing done by up to (%d+) and damage done by up to (%d+) for all magical spells and effects$"] = {{"HEAL",}, {"SPELL_DMG",},},
	},
	["DeepScanPatterns"] = {
		"^(.-) by u?p? ?t?o? ?(%d+) ?(.-)$", -- "xxx by up to 22 xxx" (scan first)
		"^(.-) ?([%+%-]%d+) ?(.-)$", -- "xxx xxx +22" or "+22 xxx xxx" or "xxx +22 xxx" (scan 2ed)
		"^(.-) ?([%d%.]+) ?(.-)$", -- 22.22 xxx xxx (scan last)
	},
	-----------------------
	-- Stat Lookup Table --
	-----------------------
	["StatIDLookup"] = {
		["% Threat"] = {"MOD_THREAT"}, -- StatLogic:GetSum("item:23344:2613")
		["% Intellect"] = {"MOD_INT"}, -- [Ember Skyflare Diamond] ID: 41333
		["% Shield Block Value"] = {"MOD_BLOCK_VALUE"}, -- [Eternal Earthsiege Diamond] ID: 41396
		["% Mount Speed"] = {"MOUNT_SPEED"}, -- Mithril Spurs, Minor Mount Speed Increase
		["Scope (Damage)"] = {"RANGED_DMG"}, -- Khorium Scope EnchantID: 2723
		["Scope (Critical Strike Rating)"] = {"RANGED_CRIT_RATING"}, -- Stabilized Eternium Scope EnchantID: 2724
		["Your attacks ignoreof your opponent's armor"] = {"IGNORE_ARMOR"}, -- StatLogic:GetSum("item:33733")
		["Increases your effective stealth level"] = {"STEALTH_LEVEL"}, -- [Nightscape Boots] ID: 8197
		["Weapon Damage"] = {"MELEE_DMG"}, -- Enchant
		["Increases mount speed%"] = {"MOUNT_SPEED"}, -- [Highlander's Plate Greaves] ID: 20048

		["All Stats"] = {"STR", "AGI", "STA", "INT", "SPI",},
		["to All Stats"] = {"STR", "AGI", "STA", "INT", "SPI",}, -- [Enchanted Tear] ID: 42702
		["Strength"] = {"STR",},
		["Agility"] = {"AGI",},
		["Stamina"] = {"STA",},
		["Intellect"] = {"INT",},
		["Spirit"] = {"SPI",},

		["Arcane Resistance"] = {"ARCANE_RES",},
		["Fire Resistance"] = {"FIRE_RES",},
		["Nature Resistance"] = {"NATURE_RES",},
		["Frost Resistance"] = {"FROST_RES",},
		["Shadow Resistance"] = {"SHADOW_RES",},
		["Arcane Resist"] = {"ARCANE_RES",}, -- Arcane Armor Kit +8 Arcane Resist
		["Fire Resist"] = {"FIRE_RES",}, -- Flame Armor Kit +8 Fire Resist
		["Nature Resist"] = {"NATURE_RES",}, -- Frost Armor Kit +8 Frost Resist
		["Frost Resist"] = {"FROST_RES",}, -- Nature Armor Kit +8 Nature Resist
		["Shadow Resist"] = {"SHADOW_RES",}, -- Shadow Armor Kit +8 Shadow Resist
		["Shadow resistance"] = {"SHADOW_RES",}, -- Demons Blood ID: 10779
		["All Resistances"] = {"ARCANE_RES", "FIRE_RES", "FROST_RES", "NATURE_RES", "SHADOW_RES",},
		["Resist All"] = {"ARCANE_RES", "FIRE_RES", "FROST_RES", "NATURE_RES", "SHADOW_RES",},

		["Fishing"] = {"FISHING",}, -- Fishing enchant ID:846
		["Fishing skill increased by"] = {"FISHING",}, -- Equip: Fishing skill increased by +20
		["Fishing Skill"] = {"FISHING",}, -- Fishing lure
		["Increased Fishing"] = {"FISHING",}, -- Equip: Increased Fishing +20.
		["Mining"] = {"MINING",}, -- Mining enchant ID:844
		["Herbalism"] = {"HERBALISM",}, -- Heabalism enchant ID:845
		["Skinning"] = {"SKINNING",}, -- Skinning enchant ID:865

		["Armor"] = {"ARMOR_BONUS",},
		["Defense"] = {"DEFENSE",},
		["Increased Defense"] = {"DEFENSE",},
		["Block"] = {"BLOCK_VALUE",}, -- +22 Block Value
		["Block Value"] = {"BLOCK_VALUE",}, -- +22 Block Value
		["Shield Block Value"] = {"BLOCK_VALUE",}, -- +10% Shield Block Value [Eternal Earthstorm Diamond] http://www.wowhead.com/?item=35501
		["Increases the block value of your shield"] = {"BLOCK_VALUE",},

		["Health"] = {"HEALTH",},
		["HP"] = {"HEALTH",},
		["Mana"] = {"MANA",},

		["Attack Power"] = {"AP",},
		["Increases attack power"] = {"AP",},
		["Attack Power when fighting Undead"] = {"AP_UNDEAD",},
		["Attack Power versus Undead"] = {"AP_UNDEAD",}, -- Scourgebane EnchantID: 3247
		-- [Wristwraps of Undead Slaying] ID:23093
		["Increases attack powerwhen fighting Undead"] = {"AP_UNDEAD",}, -- [Seal of the Dawn] ID:13209
		["Increases attack powerwhen fighting Undead.  It also allows the acquisition of Scourgestones on behalf of the Argent Dawn"] = {"AP_UNDEAD",}, -- [Seal of the Dawn] ID:13209
		["Increases attack powerwhen fighting Demons"] = {"AP_DEMON",},
		["Increases attack powerwhen fighting Undead and Demons"] = {"AP_UNDEAD", "AP_DEMON",}, -- [Mark of the Champion] ID:23206
		["Attack Power in Cat, Bear, and Dire Bear forms only"] = {"FERAL_AP",},
		["Increases attack powerin Cat, Bear, Dire Bear, and Moonkin forms only"] = {"FERAL_AP",},
		["Ranged Attack Power"] = {"RANGED_AP",},
		["Increases ranged attack power"] = {"RANGED_AP",}, -- [High Warlord's Crossbow] ID: 18837

		["Health Regen"] = {"MANA_REG",},
		["Health per"] = {"HEALTH_REG",},
		["health per"] = {"HEALTH_REG",}, -- Frostwolf Insignia Rank 6 ID:17909
		["Health every"] = {"MANA_REG",},
		["health every"] = {"HEALTH_REG",}, -- [Resurgence Rod] ID:17743
		["your normal health regeneration"] = {"HEALTH_REG",}, -- Demons Blood ID: 10779
		["Restoreshealth per 5 sec"] = {"HEALTH_REG",}, -- [Onyxia Blood Talisman] ID: 18406
		["Restoreshealth every 5 sec"] = {"HEALTH_REG",}, -- [Resurgence Rod] ID:17743
		["Mana Regen"] = {"MANA_REG",}, -- Prophetic Aura +4 Mana Regen/+10 Stamina/+24 Healing Spells http://wow.allakhazam.com/db/spell.html?wspell=24167
		["Mana per"] = {"MANA_REG",},
		["mana per"] = {"MANA_REG",}, -- Resurgence Rod ID:17743 Most common
		["Mana every"] = {"MANA_REG",},
		["mana every"] = {"MANA_REG",},
		["Mana every 5 seconds"] = {"MANA_REG",}, -- [Royal Nightseye] ID: 24057
		["Mana every 5 Sec"] = {"MANA_REG",}, --
		["mana every 5 sec"] = {"MANA_REG",}, -- Enchant Chest - Restore Mana Prime "+6 mana every 5 sec." http://wow.allakhazam.com/db/spell.html?wspell=33991
		["Mana per 5 Seconds"] = {"MANA_REG",}, -- [Royal Shadow Draenite] ID: 23109
		["Mana Per 5 sec"] = {"MANA_REG",}, -- [Royal Shadow Draenite] ID: 23109
		["Mana per 5 sec"] = {"MANA_REG",}, -- [Cyclone Shoulderpads] ID: 29031
		["mana per 5 sec"] = {"MANA_REG",}, -- [Royal Tanzanite] ID: 30603
		["Restoresmana per 5 sec"] = {"MANA_REG",}, -- [Resurgence Rod] ID:17743
		["Mana restored per 5 seconds"] = {"MANA_REG",}, -- Magister's Armor Kit +3 Mana restored per 5 seconds http://wow.allakhazam.com/db/spell.html?wspell=32399
		["Mana Regenper 5 sec"] = {"MANA_REG",}, -- Enchant Bracer - Mana Regeneration "Mana Regen 4 per 5 sec." http://wow.allakhazam.com/db/spell.html?wspell=23801
		["Mana per 5 Sec"] = {"MANA_REG",}, -- Enchant Bracer - Restore Mana Prime "6 Mana per 5 Sec." http://wow.allakhazam.com/db/spell.html?wspell=27913
		["Health and Mana every 5 sec"] = {"HEALTH_REG", "MANA_REG",}, -- Greater Vitality EnchantID: 3244

		["Spell Penetration"] = {"SPELLPEN",}, -- Enchant Cloak - Spell Penetration "+20 Spell Penetration" http://wow.allakhazam.com/db/spell.html?wspell=34003
		["Increases your spell penetration"] = {"SPELLPEN",},

		["Healing and Spell Damage"] = {"SPELL_DMG", "HEAL",}, -- Arcanum of Focus +8 Healing and Spell Damage http://wow.allakhazam.com/db/spell.html?wspell=22844
		["Damage and Healing Spells"] = {"SPELL_DMG", "HEAL",},
		["Spell Damage and Healing"] = {"SPELL_DMG", "HEAL",},
		["Spell Damage"] = {"SPELL_DMG", "HEAL",},
		["Increases damage and healing done by magical spells and effects"] = {"SPELL_DMG", "HEAL"},
		["Increases damage and healing done by magical spells and effects of all party members within 30 yards"] = {"SPELL_DMG", "HEAL"}, -- Atiesh
		["Spell Damage and Healing"] = {"SPELL_DMG", "HEAL",}, --StatLogic:GetSum("item:22630")
		["Damage"] = {"SPELL_DMG",},
		["Increases your spell damage"] = {"SPELL_DMG",}, -- Atiesh ID:22630, 22631, 22632, 22589
		["Spell Power"] = {"SPELL_DMG", "HEAL",},
		["Increases spell power"] = {"SPELL_DMG", "HEAL",}, -- WotLK
		["Holy Damage"] = {"HOLY_SPELL_DMG",},
		["Arcane Damage"] = {"ARCANE_SPELL_DMG",},
		["Fire Damage"] = {"FIRE_SPELL_DMG",},
		["Nature Damage"] = {"NATURE_SPELL_DMG",},
		["Frost Damage"] = {"FROST_SPELL_DMG",},
		["Shadow Damage"] = {"SHADOW_SPELL_DMG",},
		["Holy Spell Damage"] = {"HOLY_SPELL_DMG",},
		["Arcane Spell Damage"] = {"ARCANE_SPELL_DMG",},
		["Fire Spell Damage"] = {"FIRE_SPELL_DMG",},
		["Nature Spell Damage"] = {"NATURE_SPELL_DMG",},
		["Frost Spell Damage"] = {"FROST_SPELL_DMG",}, -- Acrobatic Staff of Frozen Wrath ID:3185:0:0:0:0:0:1957
		["Shadow Spell Damage"] = {"SHADOW_SPELL_DMG",},
		["Shadow and Frost Spell Power"] = {"SHADOW_SPELL_DMG", "FROST_SPELL_DMG",}, -- Soulfrost
		["Arcane and Fire Spell Power"] = {"ARCANE_SPELL_DMG", "FIRE_SPELL_DMG",}, -- Sunfire
		["Increases damage done by Shadow spells and effects"] = {"SHADOW_SPELL_DMG",}, -- Frozen Shadoweave Vest ID:21871
		["Increases damage done by Frost spells and effects"] = {"FROST_SPELL_DMG",}, -- Frozen Shadoweave Vest ID:21871
		["Increases damage done by Holy spells and effects"] = {"HOLY_SPELL_DMG",},
		["Increases damage done by Arcane spells and effects"] = {"ARCANE_SPELL_DMG",},
		["Increases damage done by Fire spells and effects"] = {"FIRE_SPELL_DMG",},
		["Increases damage done by Nature spells and effects"] = {"NATURE_SPELL_DMG",},
		["Increases the damage done by Holy spells and effects"] = {"HOLY_SPELL_DMG",}, -- Drape of the Righteous ID:30642
		["Increases the damage done by Arcane spells and effects"] = {"ARCANE_SPELL_DMG",}, -- Added just in case
		["Increases the damage done by Fire spells and effects"] = {"FIRE_SPELL_DMG",}, -- Added just in case
		["Increases the damage done by Frost spells and effects"] = {"FROST_SPELL_DMG",}, -- Added just in case
		["Increases the damage done by Nature spells and effects"] = {"NATURE_SPELL_DMG",}, -- Added just in case
		["Increases the damage done by Shadow spells and effects"] = {"SHADOW_SPELL_DMG",}, -- Added just in case

		["Increases damage done to Undead by magical spells and effects"] = {"SPELL_DMG_UNDEAD"}, -- [Robe of Undead Cleansing] ID:23085
		["Increases damage done to Undead by magical spells and effects.  It also allows the acquisition of Scourgestones on behalf of the Argent Dawn"] = {"SPELL_DMG_UNDEAD"}, -- [Rune of the Dawn] ID:19812
		["Increases damage done to Undead and Demons by magical spells and effects"] = {"SPELL_DMG_UNDEAD", "SPELL_DMG_DEMON"}, -- [Mark of the Champion] ID:23207

		["Healing Spells"] = {"HEAL",}, -- Enchant Gloves - Major Healing "+35 Healing Spells" http://wow.allakhazam.com/db/spell.html?wspell=33999
		["Increases Healing"] = {"HEAL",},
		["Healing"] = {"HEAL",}, -- StatLogic:GetSum("item:23344:206")
		["healing Spells"] = {"HEAL",},
		["Damage Spells"] = {"SPELL_DMG",}, -- 2.3.0 StatLogic:GetSum("item:23344:2343")
		["Healing Spells"] = {"HEAL",}, -- [Royal Nightseye] ID: 24057
		["Increases healing done"] = {"HEAL",}, -- 2.3.0
		["damage donefor all magical spells"] = {"SPELL_DMG",}, -- 2.3.0
		["Increases healing done by spells and effects"] = {"HEAL",},
		["Increases healing done by magical spells and effects of all party members within 30 yards"] = {"HEAL",}, -- Atiesh
		["your healing"] = {"HEAL",}, -- Atiesh

		["damage per second"] = {"DPS",},
		["Addsdamage per second"] = {"DPS",}, -- [Thorium Shells] ID: 15977

		["Defense Rating"] = {"DEFENSE_RATING",},
		["Increases defense rating"] = {"DEFENSE_RATING",},
		["Dodge Rating"] = {"DODGE_RATING",},
		["Increases your dodge rating"] = {"DODGE_RATING",},
		["Parry Rating"] = {"PARRY_RATING",},
		["Increases your parry rating"] = {"PARRY_RATING",},
		["Shield Block Rating"] = {"BLOCK_RATING",}, -- Enchant Shield - Lesser Block +10 Shield Block Rating http://wow.allakhazam.com/db/spell.html?wspell=13689
		["Block Rating"] = {"BLOCK_RATING",},
		["Increases your block rating"] = {"BLOCK_RATING",},
		["Increases your shield block rating"] = {"BLOCK_RATING",},

		["Hit Rating"] = {"MELEE_HIT_RATING", "SPELL_HIT_RATING"},
		["Improves hit rating"] = {"MELEE_HIT_RATING", "SPELL_HIT_RATING"}, -- ITEM_MOD_HIT_RATING
		["Increases your hit rating"] = {"MELEE_HIT_RATING", "SPELL_HIT_RATING"},
		["Improves melee hit rating"] = {"MELEE_HIT_RATING",}, -- ITEM_MOD_HIT_MELEE_RATING
		["Spell Hit"] = {"SPELL_HIT_RATING",}, -- Presence of Sight +18 Healing and Spell Damage/+8 Spell Hit http://wow.allakhazam.com/db/spell.html?wspell=24164
		["Spell Hit Rating"] = {"SPELL_HIT_RATING",},
		["Improves spell hit rating"] = {"SPELL_HIT_RATING",}, -- ITEM_MOD_HIT_SPELL_RATING
		["Increases your spell hit rating"] = {"SPELL_HIT_RATING",},
		["Ranged Hit Rating"] = {"RANGED_HIT_RATING",}, -- Biznicks 247x128 Accurascope EnchantID: 2523
		["Improves ranged hit rating"] = {"RANGED_HIT_RATING",}, -- ITEM_MOD_HIT_RANGED_RATING
		["Increases your ranged hit rating"] = {"RANGED_HIT_RATING",},

		["Crit Rating"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING"},
		["Critical Rating"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING"},
		["Critical Strike Rating"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING"},
		["Increases your critical hit rating"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING"},
		["Increases your critical strike rating"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING"},
		["Improves critical strike rating"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING"},
		["Improves melee critical strike rating"] = {"MELEE_CRIT_RATING",}, -- [Cloak of Darkness] ID:33122
		["Spell Critical Strike Rating"] = {"SPELL_CRIT_RATING",},
		["Spell Critical strike rating"] = {"SPELL_CRIT_RATING",},
		["Spell Critical Rating"] = {"SPELL_CRIT_RATING",},
		["Spell Crit Rating"] = {"SPELL_CRIT_RATING",},
		["Increases your spell critical strike rating"] = {"SPELL_CRIT_RATING",},
		["Increases the spell critical strike rating of all party members within 30 yards"] = {"SPELL_CRIT_RATING",},
		["Improves spell critical strike rating"] = {"SPELL_CRIT_RATING",},
		["Increases your ranged critical strike rating"] = {"RANGED_CRIT_RATING",}, -- Fletcher's Gloves ID:7348
		["Ranged Critical Strike"] = {"RANGED_CRIT_RATING",}, -- Heartseeker Scope EnchantID: 3608

		["Improves hit avoidance rating"] = {"MELEE_HIT_AVOID_RATING"}, -- ITEM_MOD_HIT_TAKEN_RATING
		["Improves melee hit avoidance rating"] = {"MELEE_HIT_AVOID_RATING"}, -- ITEM_MOD_HIT_TAKEN_MELEE_RATING
		["Improves ranged hit avoidance rating"] = {"RANGED_HIT_AVOID_RATING"}, -- ITEM_MOD_HIT_TAKEN_RANGED_RATING
		["Improves spell hit avoidance rating"] = {"SPELL_HIT_AVOID_RATING"}, -- ITEM_MOD_HIT_TAKEN_SPELL_RATING
		["Resilience"] = {"RESILIENCE_RATING",},
		["Resilience Rating"] = {"RESILIENCE_RATING",}, -- Enchant Chest - Major Resilience "+15 Resilience Rating" http://wow.allakhazam.com/db/spell.html?wspell=33992
		["Improves your resilience rating"] = {"RESILIENCE_RATING",},
		["Improves critical avoidance rating"] = {"MELEE_CRIT_AVOID_RATING",},
		["Improves melee critical avoidance rating"] = {"MELEE_CRIT_AVOID_RATING",},
		["Improves ranged critical avoidance rating"] = {"RANGED_CRIT_AVOID_RATING",},
		["Improves spell critical avoidance rating"] = {"SPELL_CRIT_AVOID_RATING",},

		["Haste Rating"] = {"MELEE_HASTE_RATING", "SPELL_HASTE_RATING"},
		["Improves haste rating"] = {"MELEE_HASTE_RATING", "SPELL_HASTE_RATING"},
		["Improves melee haste rating"] = {"MELEE_HASTE_RATING"},
		["Spell Haste Rating"] = {"SPELL_HASTE_RATING"},
		["Improves spell haste rating"] = {"SPELL_HASTE_RATING"},
		["Ranged Haste Rating"] = {"RANGED_HASTE_RATING"}, -- Micro Stabilizer EnchantID: 3607
		["Improves ranged haste rating"] = {"RANGED_HASTE_RATING"},

		["Increases dagger skill rating"] = {"DAGGER_WEAPON_RATING"},
		["Increases sword skill rating"] = {"SWORD_WEAPON_RATING"}, -- [Warblade of the Hakkari] ID:19865
		["Increases Two-Handed Swords skill rating"] = {"2H_SWORD_WEAPON_RATING"},
		["Increases axe skill rating"] = {"AXE_WEAPON_RATING"},
		["Two-Handed Axe Skill Rating"] = {"2H_AXE_WEAPON_RATING"}, -- [Ethereum Nexus-Reaver] ID:30722
		["Increases two-handed axes skill rating"] = {"2H_AXE_WEAPON_RATING"},
		["Increases mace skill rating"] = {"MACE_WEAPON_RATING"},
		["Increases two-handed maces skill rating"] = {"2H_MACE_WEAPON_RATING"},
		["Increases gun skill rating"] = {"GUN_WEAPON_RATING"},
		["Increases Crossbow skill rating"] = {"CROSSBOW_WEAPON_RATING"},
		["Increases Bow skill rating"] = {"BOW_WEAPON_RATING"},
		["Increases feral combat skill rating"] = {"FERAL_WEAPON_RATING"},
		["Increases fist weapons skill rating"] = {"FIST_WEAPON_RATING"}, -- Demonblood Eviscerator
		["Increases unarmed skill rating"] = {"FIST_WEAPON_RATING"}, -- Demonblood Eviscerator ID:27533
		["Increases staff skill rating"] = {"STAFF_WEAPON_RATING"}, -- Leggings of the Fang ID:10410

		["expertise rating"] = {"EXPERTISE_RATING"}, -- gems
		["armor penetration rating"] = {"ARMOR_PENETRATION_RATING"}, -- gems
		["Increases your expertise rating"] = {"EXPERTISE_RATING"},
		["Increases armor penetration rating"] = {"ARMOR_PENETRATION_RATING"},
		["Increases your armor penetration rating"] = {"ARMOR_PENETRATION_RATING"}, -- ID:43178

		-- Exclude
		["sec"] = false,
		["to"] = false,
		["Slot Bag"] = false,
		["Slot Quiver"] = false,
		["Slot Ammo Pouch"] = false,
		["Increases ranged attack speed"] = false, -- AV quiver
	},
}
DisplayLocale.enUS = {
	----------------
	-- Stat Names --
	----------------
	-- Please localize these strings too, global strings were used in the enUS locale just to have minimum
	-- localization effect when a locale is not available for that language, you don't have to use global
	-- strings in your localization.
  ["Stat Multiplier"] = "Stat Multiplier",
  ["Attack Power Multiplier"] = "Attack Power Multiplier",
  ["Reduced Physical Damage Taken"] = "Reduced Physical Damage Taken",
	["StatIDToName"] = {
		--[StatID] = {FullName, ShortName},
		---------------------------------------------------------------------------
		-- Tier1 Stats - Stats parsed directly off items
		["EMPTY_SOCKET_RED"] = {EMPTY_SOCKET_RED, EMPTY_SOCKET_RED}, -- EMPTY_SOCKET_RED = "Red Socket";
		["EMPTY_SOCKET_YELLOW"] = {EMPTY_SOCKET_YELLOW, EMPTY_SOCKET_YELLOW}, -- EMPTY_SOCKET_YELLOW = "Yellow Socket";
		["EMPTY_SOCKET_BLUE"] = {EMPTY_SOCKET_BLUE, EMPTY_SOCKET_BLUE}, -- EMPTY_SOCKET_BLUE = "Blue Socket";
		["EMPTY_SOCKET_META"] = {EMPTY_SOCKET_META, EMPTY_SOCKET_META}, -- EMPTY_SOCKET_META = "Meta Socket";

		["IGNORE_ARMOR"] = {"Ignore Armor", "Ignore Armor"},
		["MOD_THREAT"] = {"Threat(%)", "Threat(%)"},
		["STEALTH_LEVEL"] = {"Stealth Level", "Stealth"},
		["MELEE_DMG"] = {"Melee Weapon "..DAMAGE, "Wpn Dmg"}, -- DAMAGE = "Damage"
		["RANGED_DMG"] = {"Ranged Weapon "..DAMAGE, "Ranged Dmg"}, -- DAMAGE = "Damage"
		["MOUNT_SPEED"] = {"Mount Speed(%)", "Mount Spd(%)"},
		["RUN_SPEED"] = {"Run Speed(%)", "Run Spd(%)"},

		["STR"] = {SPELL_STAT1_NAME, "Str"},
		["AGI"] = {SPELL_STAT2_NAME, "Agi"},
		["STA"] = {SPELL_STAT3_NAME, "Sta"},
		["INT"] = {SPELL_STAT4_NAME, "Int"},
		["SPI"] = {SPELL_STAT5_NAME, "Spi"},
		["ARMOR"] = {ARMOR, ARMOR},
		["ARMOR_BONUS"] = {"Bonus "..ARMOR, "Bonus "..ARMOR},

		["FIRE_RES"] = {RESISTANCE2_NAME, "FR"},
		["NATURE_RES"] = {RESISTANCE3_NAME, "NR"},
		["FROST_RES"] = {RESISTANCE4_NAME, "FrR"},
		["SHADOW_RES"] = {RESISTANCE5_NAME, "SR"},
		["ARCANE_RES"] = {RESISTANCE6_NAME, "AR"},

		["FISHING"] = {"Fishing", "Fishing"},
		["MINING"] = {"Mining", "Mining"},
		["HERBALISM"] = {"Herbalism", "Herbalism"},
		["SKINNING"] = {"Skinning", "Skinning"},

		["BLOCK_VALUE"] = {"Block Value", "Block Value"},

		["AP"] = {ATTACK_POWER_TOOLTIP, "AP"},
		["RANGED_AP"] = {RANGED_ATTACK_POWER, "RAP"},
		["FERAL_AP"] = {"Feral "..ATTACK_POWER_TOOLTIP, "Feral AP"},
		["AP_UNDEAD"] = {ATTACK_POWER_TOOLTIP.." (Undead)", "AP(Undead)"},
		["AP_DEMON"] = {ATTACK_POWER_TOOLTIP.." (Demon)", "AP(Demon)"},

		["HEAL"] = {"Healing", "Heal"},

		["SPELL_DMG"] = {PLAYERSTAT_SPELL_COMBAT.." "..DAMAGE, PLAYERSTAT_SPELL_COMBAT.." Dmg"},
		["SPELL_DMG_UNDEAD"] = {PLAYERSTAT_SPELL_COMBAT.." "..DAMAGE.." (Undead)", PLAYERSTAT_SPELL_COMBAT.." Dmg".."(Undead)"},
		["SPELL_DMG_DEMON"] = {PLAYERSTAT_SPELL_COMBAT.." "..DAMAGE.." (Demon)", PLAYERSTAT_SPELL_COMBAT.." Dmg".."(Demon)"},
		["HOLY_SPELL_DMG"] = {SPELL_SCHOOL1_CAP.." "..DAMAGE, SPELL_SCHOOL1_CAP.." Dmg"},
		["FIRE_SPELL_DMG"] = {SPELL_SCHOOL2_CAP.." "..DAMAGE, SPELL_SCHOOL2_CAP.." Dmg"},
		["NATURE_SPELL_DMG"] = {SPELL_SCHOOL3_CAP.." "..DAMAGE, SPELL_SCHOOL3_CAP.." Dmg"},
		["FROST_SPELL_DMG"] = {SPELL_SCHOOL4_CAP.." "..DAMAGE, SPELL_SCHOOL4_CAP.." Dmg"},
		["SHADOW_SPELL_DMG"] = {SPELL_SCHOOL5_CAP.." "..DAMAGE, SPELL_SCHOOL5_CAP.." Dmg"},
		["ARCANE_SPELL_DMG"] = {SPELL_SCHOOL6_CAP.." "..DAMAGE, SPELL_SCHOOL6_CAP.." Dmg"},

		["SPELLPEN"] = {PLAYERSTAT_SPELL_COMBAT.." "..SPELL_PENETRATION, SPELL_PENETRATION},

		["HEALTH"] = {HEALTH, HP},
		["MANA"] = {MANA, MP},
		["HEALTH_REG"] = {HEALTH.." Regen", "HP5"},
		["MANA_REG"] = {MANA.." Regen", "MP5"},

		["MAX_DAMAGE"] = {"Max Damage", "Max Dmg"},
		["DPS"] = {"Damage Per Second", "DPS"},

		["DEFENSE_RATING"] = {COMBAT_RATING_NAME2, COMBAT_RATING_NAME2}, -- COMBAT_RATING_NAME2 = "Defense Rating"
		["DODGE_RATING"] = {COMBAT_RATING_NAME3, COMBAT_RATING_NAME3}, -- COMBAT_RATING_NAME3 = "Dodge Rating"
		["PARRY_RATING"] = {COMBAT_RATING_NAME4, COMBAT_RATING_NAME4}, -- COMBAT_RATING_NAME4 = "Parry Rating"
		["BLOCK_RATING"] = {COMBAT_RATING_NAME5, COMBAT_RATING_NAME5}, -- COMBAT_RATING_NAME5 = "Block Rating"
		["MELEE_HIT_RATING"] = {COMBAT_RATING_NAME6, COMBAT_RATING_NAME6}, -- COMBAT_RATING_NAME6 = "Hit Rating"
		["RANGED_HIT_RATING"] = {PLAYERSTAT_RANGED_COMBAT.." "..COMBAT_RATING_NAME6, PLAYERSTAT_RANGED_COMBAT.." "..COMBAT_RATING_NAME6}, -- PLAYERSTAT_RANGED_COMBAT = "Ranged"
		["SPELL_HIT_RATING"] = {PLAYERSTAT_SPELL_COMBAT.." "..COMBAT_RATING_NAME6, PLAYERSTAT_SPELL_COMBAT.." "..COMBAT_RATING_NAME6}, -- PLAYERSTAT_SPELL_COMBAT = "Spell"
		["MELEE_HIT_AVOID_RATING"] = {"Hit Avoidance "..RATING, "Hit Avoidance "..RATING},
		["RANGED_HIT_AVOID_RATING"] = {PLAYERSTAT_RANGED_COMBAT.." Hit Avoidance "..RATING, PLAYERSTAT_RANGED_COMBAT.." Hit Avoidance "..RATING},
		["SPELL_HIT_AVOID_RATING"] = {PLAYERSTAT_SPELL_COMBAT.." Hit Avoidance "..RATING, PLAYERSTAT_SPELL_COMBAT.." Hit Avoidance "..RATING},
		["MELEE_CRIT_RATING"] = {COMBAT_RATING_NAME9, COMBAT_RATING_NAME9}, -- COMBAT_RATING_NAME9 = "Crit Rating"
		["RANGED_CRIT_RATING"] = {PLAYERSTAT_RANGED_COMBAT.." "..COMBAT_RATING_NAME9, PLAYERSTAT_RANGED_COMBAT.." "..COMBAT_RATING_NAME9},
		["SPELL_CRIT_RATING"] = {PLAYERSTAT_SPELL_COMBAT.." "..COMBAT_RATING_NAME9, PLAYERSTAT_SPELL_COMBAT.." "..COMBAT_RATING_NAME9},
		["MELEE_CRIT_AVOID_RATING"] = {"Crit Avoidance "..RATING, "Crit Avoidance "..RATING},
		["RANGED_CRIT_AVOID_RATING"] = {PLAYERSTAT_RANGED_COMBAT.." Crit Avoidance "..RATING, PLAYERSTAT_RANGED_COMBAT.." Crit Avoidance "..RATING},
		["SPELL_CRIT_AVOID_RATING"] = {PLAYERSTAT_SPELL_COMBAT.." Crit Avoidance "..RATING, PLAYERSTAT_SPELL_COMBAT.." Crit Avoidance "..RATING},
		["RESILIENCE_RATING"] = {COMBAT_RATING_NAME15, COMBAT_RATING_NAME15}, -- COMBAT_RATING_NAME15 = "Resilience"
		["MELEE_HASTE_RATING"] = {"Haste "..RATING, "Haste "..RATING}, --
		["RANGED_HASTE_RATING"] = {PLAYERSTAT_RANGED_COMBAT.." Haste "..RATING, PLAYERSTAT_RANGED_COMBAT.." Haste "..RATING},
		["SPELL_HASTE_RATING"] = {PLAYERSTAT_SPELL_COMBAT.." Haste "..RATING, PLAYERSTAT_SPELL_COMBAT.." Haste "..RATING},
		["DAGGER_WEAPON_RATING"] = {"Dagger "..SKILL.." "..RATING, "Dagger "..RATING}, -- SKILL = "Skill"
		["SWORD_WEAPON_RATING"] = {"Sword "..SKILL.." "..RATING, "Sword "..RATING},
		["2H_SWORD_WEAPON_RATING"] = {"Two-Handed Sword "..SKILL.." "..RATING, "2H Sword "..RATING},
		["AXE_WEAPON_RATING"] = {"Axe "..SKILL.." "..RATING, "Axe "..RATING},
		["2H_AXE_WEAPON_RATING"] = {"Two-Handed Axe "..SKILL.." "..RATING, "2H Axe "..RATING},
		["MACE_WEAPON_RATING"] = {"Mace "..SKILL.." "..RATING, "Mace "..RATING},
		["2H_MACE_WEAPON_RATING"] = {"Two-Handed Mace "..SKILL.." "..RATING, "2H Mace "..RATING},
		["GUN_WEAPON_RATING"] = {"Gun "..SKILL.." "..RATING, "Gun "..RATING},
		["CROSSBOW_WEAPON_RATING"] = {"Crossbow "..SKILL.." "..RATING, "Crossbow "..RATING},
		["BOW_WEAPON_RATING"] = {"Bow "..SKILL.." "..RATING, "Bow "..RATING},
		["FERAL_WEAPON_RATING"] = {"Feral "..SKILL.." "..RATING, "Feral "..RATING},
		["FIST_WEAPON_RATING"] = {"Unarmed "..SKILL.." "..RATING, "Unarmed "..RATING},
		["STAFF_WEAPON_RATING"] = {"Staff "..SKILL.." "..RATING, "Staff "..RATING}, -- Leggings of the Fang ID:10410
		--["EXPERTISE_RATING"] = {STAT_EXPERTISE.." "..RATING, STAT_EXPERTISE.." "..RATING},
		["EXPERTISE_RATING"] = {"Expertise".." "..RATING, "Expertise".." "..RATING},
		["ARMOR_PENETRATION_RATING"] = {"Armor Penetration".." "..RATING, "ArP".." "..RATING},

		---------------------------------------------------------------------------
		-- Tier2 Stats - Stats that only show up when broken down from a Tier1 stat
		-- Str -> AP, Block Value
		-- Agi -> AP, Crit, Dodge
		-- Sta -> Health
		-- Int -> Mana, Spell Crit
		-- Spi -> mp5nc, hp5oc
		-- Ratings -> Effect
		["HEALTH_REG_OUT_OF_COMBAT"] = {HEALTH.." Regen (Out of combat)", "HP5(OC)"},
		["MANA_REG_NOT_CASTING"] = {MANA.." Regen (Not casting)", "MP5(NC)"},
		["MELEE_CRIT_DMG_REDUCTION"] = {"Crit Damage Reduction(%)", "Crit Dmg Reduc(%)"},
		["RANGED_CRIT_DMG_REDUCTION"] = {PLAYERSTAT_RANGED_COMBAT.." Crit Damage Reduction(%)", PLAYERSTAT_RANGED_COMBAT.." Crit Dmg Reduc(%)"},
		["SPELL_CRIT_DMG_REDUCTION"] = {PLAYERSTAT_SPELL_COMBAT.." Crit Damage Reduction(%)", PLAYERSTAT_SPELL_COMBAT.." Crit Dmg Reduc(%)"},
		["DEFENSE"] = {DEFENSE, "Def"},
		["DODGE"] = {DODGE.."(%)", DODGE.."(%)"},
		["PARRY"] = {PARRY.."(%)", PARRY.."(%)"},
		["BLOCK"] = {BLOCK.."(%)", BLOCK.."(%)"},
		["AVOIDANCE"] = {"Avoidance(%)", "Avoidance(%)"},
		["MELEE_HIT"] = {"Hit Chance(%)", "Hit(%)"},
		["RANGED_HIT"] = {PLAYERSTAT_RANGED_COMBAT.." Hit Chance(%)", PLAYERSTAT_RANGED_COMBAT.." Hit(%)"},
		["SPELL_HIT"] = {PLAYERSTAT_SPELL_COMBAT.." Hit Chance(%)", PLAYERSTAT_SPELL_COMBAT.." Hit(%)"},
		["MELEE_HIT_AVOID"] = {"Hit Avoidance(%)", "Hit Avd(%)"},
		["RANGED_HIT_AVOID"] = {PLAYERSTAT_RANGED_COMBAT.." Hit Avoidance(%)", PLAYERSTAT_RANGED_COMBAT.." Hit Avd(%)"},
		["SPELL_HIT_AVOID"] = {PLAYERSTAT_SPELL_COMBAT.." Hit Avoidance(%)", PLAYERSTAT_SPELL_COMBAT.." Hit Avd(%)"},
		["MELEE_CRIT"] = {MELEE_CRIT_CHANCE.."(%)", "Crit(%)"}, -- MELEE_CRIT_CHANCE = "Crit Chance"
		["RANGED_CRIT"] = {PLAYERSTAT_RANGED_COMBAT.." "..MELEE_CRIT_CHANCE.."(%)", PLAYERSTAT_RANGED_COMBAT.." Crit(%)"},
		["SPELL_CRIT"] = {PLAYERSTAT_SPELL_COMBAT.." "..MELEE_CRIT_CHANCE.."(%)", PLAYERSTAT_SPELL_COMBAT.." Crit(%)"},
		["MELEE_CRIT_AVOID"] = {"Crit Avoidance(%)", "Crit Avd(%)"},
		["RANGED_CRIT_AVOID"] = {PLAYERSTAT_RANGED_COMBAT.." Crit Avoidance(%)", PLAYERSTAT_RANGED_COMBAT.." Crit Avd(%)"},
		["SPELL_CRIT_AVOID"] = {PLAYERSTAT_SPELL_COMBAT.." Crit Avoidance(%)", PLAYERSTAT_SPELL_COMBAT.." Crit Avd(%)"},
		["MELEE_HASTE"] = {"Haste(%)", "Haste(%)"}, --
		["RANGED_HASTE"] = {PLAYERSTAT_RANGED_COMBAT.." Haste(%)", PLAYERSTAT_RANGED_COMBAT.." Haste(%)"},
		["SPELL_HASTE"] = {PLAYERSTAT_SPELL_COMBAT.." Haste(%)", PLAYERSTAT_SPELL_COMBAT.." Haste(%)"},
		["DAGGER_WEAPON"] = {"Dagger "..SKILL, "Dagger"}, -- SKILL = "Skill"
		["SWORD_WEAPON"] = {"Sword "..SKILL, "Sword"},
		["2H_SWORD_WEAPON"] = {"Two-Handed Sword "..SKILL, "2H Sword"},
		["AXE_WEAPON"] = {"Axe "..SKILL, "Axe"},
		["2H_AXE_WEAPON"] = {"Two-Handed Axe "..SKILL, "2H Axe"},
		["MACE_WEAPON"] = {"Mace "..SKILL, "Mace"},
		["2H_MACE_WEAPON"] = {"Two-Handed Mace "..SKILL, "2H Mace"},
		["GUN_WEAPON"] = {"Gun "..SKILL, "Gun"},
		["CROSSBOW_WEAPON"] = {"Crossbow "..SKILL, "Crossbow"},
		["BOW_WEAPON"] = {"Bow "..SKILL, "Bow"},
		["FERAL_WEAPON"] = {"Feral "..SKILL, "Feral"},
		["FIST_WEAPON"] = {"Unarmed "..SKILL, "Unarmed"},
		["STAFF_WEAPON"] = {"Staff "..SKILL, "Staff"}, -- Leggings of the Fang ID:10410
		--["EXPERTISE"] = {STAT_EXPERTISE, STAT_EXPERTISE},
		["EXPERTISE"] = {"Expertise", "Expertise"},
		["ARMOR_PENETRATION"] = {"Armor Penetration(%)", "ArP(%)"},

		---------------------------------------------------------------------------
		-- Tier3 Stats - Stats that only show up when broken down from a Tier2 stat
		-- Defense -> Crit Avoidance, Hit Avoidance, Dodge, Parry, Block
		-- Weapon Skill -> Crit, Hit, Dodge Neglect, Parry Neglect, Block Neglect
		-- Expertise -> Dodge Neglect, Parry Neglect
		["DODGE_NEGLECT"] = {DODGE.." Neglect(%)", DODGE.." Neglect(%)"},
		["PARRY_NEGLECT"] = {PARRY.." Neglect(%)", PARRY.." Neglect(%)"},
		["BLOCK_NEGLECT"] = {BLOCK.." Neglect(%)", BLOCK.." Neglect(%)"},

		---------------------------------------------------------------------------
		-- Talents
		["MELEE_CRIT_DMG"] = {"Crit Damage(%)", "Crit Dmg(%)"},
		["RANGED_CRIT_DMG"] = {PLAYERSTAT_RANGED_COMBAT.." Crit Damage(%)", PLAYERSTAT_RANGED_COMBAT.." Crit Dmg(%)"},
		["SPELL_CRIT_DMG"] = {PLAYERSTAT_SPELL_COMBAT.." Crit Damage(%)", PLAYERSTAT_SPELL_COMBAT.." Crit Dmg(%)"},

		---------------------------------------------------------------------------
		-- Spell Stats
		-- These values can be prefixed with a @ and spell name, using reverse translation to english from Babble-Spell-2.2
		-- ex: "Heroic Strike@RAGE_COST" for Heroic Strike rage cost
		-- ex: "Heroic Strike@THREAT" for Heroic Strike threat value
		-- Use strsplit("@", text) to seperate the spell name and statid
		["THREAT"] = {"Threat", "Threat"},
		["CAST_TIME"] = {"Casting Time", "Cast Time"},
		["MANA_COST"] = {"Mana Cost", "Mana Cost"},
		["RAGE_COST"] = {"Rage Cost", "Rage Cost"},
		["ENERGY_COST"] = {"Energy Cost", "Energy Cost"},
		["COOLDOWN"] = {"Cooldown", "CD"},

		---------------------------------------------------------------------------
		-- Stats Mods
		["MOD_STR"] = {"Mod "..SPELL_STAT1_NAME.."(%)", "Mod Str(%)"},
		["MOD_AGI"] = {"Mod "..SPELL_STAT2_NAME.."(%)", "Mod Agi(%)"},
		["MOD_STA"] = {"Mod "..SPELL_STAT3_NAME.."(%)", "Mod Sta(%)"},
		["MOD_INT"] = {"Mod "..SPELL_STAT4_NAME.."(%)", "Mod Int(%)"},
		["MOD_SPI"] = {"Mod "..SPELL_STAT5_NAME.."(%)", "Mod Spi(%)"},
		["MOD_HEALTH"] = {"Mod "..HEALTH.."(%)", "Mod "..HP.."(%)"},
		["MOD_MANA"] = {"Mod "..MANA.."(%)", "Mod "..MP.."(%)"},
		["MOD_ARMOR"] = {"Mod "..ARMOR.."from Items".."(%)", "Mod "..ARMOR.."(Items)".."(%)"},
		["MOD_BLOCK_VALUE"] = {"Mod Block Value".."(%)", "Mod Block Value".."(%)"},
		["MOD_DMG"] = {"Mod Damage".."(%)", "Mod Dmg".."(%)"},
		["MOD_DMG_TAKEN"] = {"Mod Damage Taken".."(%)", "Mod Dmg Taken".."(%)"},
		["MOD_CRIT_DAMAGE"] = {"Mod Crit Damage".."(%)", "Mod Crit Dmg".."(%)"},
		["MOD_CRIT_DAMAGE_TAKEN"] = {"Mod Crit Damage Taken".."(%)", "Mod Crit Dmg Taken".."(%)"},
		["MOD_THREAT"] = {"Mod Threat".."(%)", "Mod Threat".."(%)"},
		["MOD_AP"] = {"Mod "..ATTACK_POWER_TOOLTIP.."(%)", "Mod AP".."(%)"},
		["MOD_RANGED_AP"] = {"Mod "..PLAYERSTAT_RANGED_COMBAT.." "..ATTACK_POWER_TOOLTIP.."(%)", "Mod RAP".."(%)"},
		["MOD_SPELL_DMG"] = {"Mod "..PLAYERSTAT_SPELL_COMBAT.." "..DAMAGE.."(%)", "Mod "..PLAYERSTAT_SPELL_COMBAT.." Dmg".."(%)"},
		["MOD_HEALING"] = {"Mod Healing".."(%)", "Mod Heal".."(%)"},
		["MOD_CAST_TIME"] = {"Mod Casting Time".."(%)", "Mod Cast Time".."(%)"},
		["MOD_MANA_COST"] = {"Mod Mana Cost".."(%)", "Mod Mana Cost".."(%)"},
		["MOD_RAGE_COST"] = {"Mod Rage Cost".."(%)", "Mod Rage Cost".."(%)"},
		["MOD_ENERGY_COST"] = {"Mod Energy Cost".."(%)", "Mod Energy Cost".."(%)"},
		["MOD_COOLDOWN"] = {"Mod Cooldown".."(%)", "Mod CD".."(%)"},

		---------------------------------------------------------------------------
		-- Misc Stats
		["WEAPON_RATING"] = {"Weapon "..SKILL.." "..RATING, "Weapon"..SKILL.." "..RATING},
		["WEAPON_SKILL"] = {"Weapon "..SKILL, "Weapon"..SKILL},
		["MAINHAND_WEAPON_RATING"] = {"Main Hand Weapon "..SKILL.." "..RATING, "MH Weapon"..SKILL.." "..RATING},
		["OFFHAND_WEAPON_RATING"] = {"Off Hand Weapon "..SKILL.." "..RATING, "OH Weapon"..SKILL.." "..RATING},
		["RANGED_WEAPON_RATING"] = {"Ranged Weapon "..SKILL.." "..RATING, "Ranged Weapon"..SKILL.." "..RATING},
	},
}

PatternLocale.enGB = PatternLocale.enUS
DisplayLocale.enGB = DisplayLocale.enUS

-- koKR localization by fenlis, 7destiny, slowhand
PatternLocale.koKR = {
	["tonumber"] = tonumber,
	-----------------
	-- Armor Types --
	-----------------
	Plate = "판금",
	Mail = "사슬",
	Leather = "가죽",
	Cloth = "천",
	------------------
	-- Fast Exclude --
	------------------
	-- By looking at the first ExcludeLen letters of a line we can exclude a lot of lines
	["ExcludeLen"] = 3,
	["Exclude"] = {
		[""] = true,
		[" \n"] = true,
		[ITEM_BIND_ON_EQUIP] = true, -- ITEM_BIND_ON_EQUIP = "착용 시 귀속"; -- Item will be bound when equipped
		[ITEM_BIND_ON_PICKUP] = true, -- ITEM_BIND_ON_PICKUP = "획득 시 귀속"; -- Item wil be bound when picked up
		[ITEM_BIND_ON_USE] = true, -- ITEM_BIND_ON_USE = "사용 시 귀속"; -- Item will be bound when used
		[ITEM_BIND_QUEST] = true, -- ITEM_BIND_QUEST = "퀘스트 아이템"; -- Item is a quest item (same logic as ON_PICKUP)
		[ITEM_SOULBOUND] = true, -- ITEM_SOULBOUND = "귀속 아이템"; -- Item is Soulbound
		[ITEM_STARTS_QUEST] = true, -- ITEM_STARTS_QUEST = "퀘스트 시작 아이템"; -- Item is a quest giver
		[ITEM_CANT_BE_DESTROYED] = true, -- ITEM_CANT_BE_DESTROYED = "그 아이템은 버릴 수 없습니다."; -- Attempted to destroy a NO_DESTROY item
		[ITEM_CONJURED] = true, -- ITEM_CONJURED = "창조된 아이템"; -- Item expires
		[ITEM_DISENCHANT_NOT_DISENCHANTABLE] = true, -- ITEM_DISENCHANT_NOT_DISENCHANTABLE = "마력 추출 불가"; -- Items which cannot be disenchanted ever
		["마력 "] = true, -- ITEM_DISENCHANT_ANY_SKILL = "마력 추출 가능"; -- Items that can be disenchanted at any skill level
		-- ITEM_DISENCHANT_MIN_SKILL = "마력 추출 요구 사항: %s (%d)"; -- Minimum enchanting skill needed to disenchant
		["지속시"] = true, -- ITEM_DURATION_DAYS = "지속시간: %d일";
		["<제작"] = true, -- ITEM_CREATED_BY = "|cff00ff00<제작자: %s>|r"; -- %s is the creator of the item
		["재사용"] = true, -- ITEM_COOLDOWN_TIME_DAYS = "재사용 대기시간: %d일";
		["고유 "] = true, -- Unique (20)
		["최소 "] = true, -- Requires Level xx
		["\n최소"] = true, -- Requires Level xx
		["직업:"] = true, -- Classes: xx
		["종족:"] = true, -- Races: xx (vendor mounts)
		["사용 "] = true, -- Use:
		["발동 "] = true, -- Chance On Hit:
		-- Set Bonuses
		-- ITEM_SET_BONUS = "세트 효과: %s";
		-- ITEM_SET_BONUS_GRAY = "(%d) 세트 효과: %s";
		-- ITEM_SET_NAME = "%s (%d/%d)"; -- Set name (2/5)
		["세트 "] = true,
		["(2)"] = true,
		["(3)"] = true,
		["(4)"] = true,
		["(5)"] = true,
		["(6)"] = true,
		["(7)"] = true,
		["(8)"] = true,
		-- Equip type
		["투사체"] = true, -- Ice Threaded Arrow ID:19316
		[INVTYPE_AMMO] = true,
		[INVTYPE_HEAD] = true,
		[INVTYPE_NECK] = true,
		[INVTYPE_SHOULDER] = true,
		[INVTYPE_BODY] = true,
		[INVTYPE_CHEST] = true,
		[INVTYPE_ROBE] = true,
		[INVTYPE_WAIST] = true,
		[INVTYPE_LEGS] = true,
		[INVTYPE_FEET] = true,
		[INVTYPE_WRIST] = true,
		[INVTYPE_HAND] = true,
		[INVTYPE_FINGER] = true,
		[INVTYPE_TRINKET] = true,
		[INVTYPE_CLOAK] = true,
		[INVTYPE_WEAPON] = true,
		[INVTYPE_SHIELD] = true,
		[INVTYPE_2HWEAPON] = true,
		[INVTYPE_WEAPONMAINHAND] = true,
		[INVTYPE_WEAPONOFFHAND] = true,
		[INVTYPE_HOLDABLE] = true,
		[INVTYPE_RANGED] = true,
		[INVTYPE_THROWN] = true,
		[INVTYPE_RANGEDRIGHT] = true,
		[INVTYPE_RELIC] = true,
		[INVTYPE_TABARD] = true,
		[INVTYPE_BAG] = true,
	},
	-----------------------
	-- Whole Text Lookup --
	-----------------------
	-- Mainly used for enchants that doesn't have numbers in the text
	-- http://wow.allakhazam.com/db/enchant.html?slot=0&locale=enUS
	["WholeTextLookup"] = {
		[EMPTY_SOCKET_RED] = {["EMPTY_SOCKET_RED"] = 1}, -- EMPTY_SOCKET_RED = "Red Socket";
		[EMPTY_SOCKET_YELLOW] = {["EMPTY_SOCKET_YELLOW"] = 1}, -- EMPTY_SOCKET_YELLOW = "Yellow Socket";
		[EMPTY_SOCKET_BLUE] = {["EMPTY_SOCKET_BLUE"] = 1}, -- EMPTY_SOCKET_BLUE = "Blue Socket";
		[EMPTY_SOCKET_META] = {["EMPTY_SOCKET_META"] = 1}, -- EMPTY_SOCKET_META = "Meta Socket";

		["최하급 마술사 오일"] = {["SPELL_DMG"] = 8, ["HEAL"] = 8}, -- ID: 20744
		["하급 마술사 오일"] = {["SPELL_DMG"] = 16, ["HEAL"] = 16}, -- ID: 20746
		["마술사 오일"] = {["SPELL_DMG"] = 24, ["HEAL"] = 24}, -- ID: 20750
		["반짝이는 마술사 오일"] = {["SPELL_DMG"] = 36, ["HEAL"] = 36, ["SPELL_CRIT_RATING"] = 14}, -- ID: 20749
		["상급 마술사 오일"] = {["SPELL_DMG"] = 42, ["HEAL"] = 42}, -- ID: 22522
		["신성한 마술사 오일"] = {["SPELL_DMG_UNDEAD"] = 60}, -- ID: 23123

		["최하급 마나 오일"] = {["MANA_REG"] = 4}, -- ID: 20745
		["하급 마나 오일"] = {["MANA_REG"] = 8}, -- ID: 20747
		["반짝이는 마나 오일"] = {["MANA_REG"] = 12, ["HEAL"] = 25}, -- ID: 20748
		["상급 마나 오일"] = {["MANA_REG"] = 14}, -- ID: 22521

		["에터니움 낚시줄"] = {["FISHING"] = 5}, --
		["전투력"] = {["AP"] = 70}, --
		["활력"] = {["MANA_REG"] = 4, ["HEALTH_REG"] = 4}, -- Enchant Boots - Vitality "Vitality" http://wow.allakhazam.com/db/spell.html?wspell=27948
		["냉기의 영혼"] = {["SHADOW_SPELL_DMG"] = 54, ["FROST_SPELL_DMG"] = 54}, --
		["태양의 불꽃"] = {["ARCANE_SPELL_DMG"] = 50, ["FIRE_SPELL_DMG"] = 50}, --

		["미스릴 박차"] = {["MOUNT_SPEED"] = 4}, -- Mithril Spurs
		["최하급 탈것 속도 증가"] = {["MOUNT_SPEED"] = 2}, -- Enchant Gloves - Riding Skill
		["착용 효과: 달리기 속도가 약간 증가합니다."] = {["RUN_SPEED"] = 8}, -- [산악연대 판금 경갑] ID: 20048
		["달리기 속도가 약간 증가합니다."] = {["RUN_SPEED"] = 8}, --
		["최하급 달리기 속도 증가"] = {["RUN_SPEED"] = 8}, -- Enchant Boots - Minor Speed "Minor Speed Increase" http://wow.allakhazam.com/db/spell.html?wspell=13890
		["최하급 달리기 속도"] = {["RUN_SPEED"] = 8}, -- Enchant Boots - Cat's Swiftness "Minor Speed and +6 Agility" http://wow.allakhazam.com/db/spell.html?wspell=34007
		["침착함"] = {["MELEE_HIT_RATING"] = 10, ["SPELL_HIT_RATING"] = 10, ["MELEE_CRIT_RATING"] = 10, ["SPELL_CRIT_RATING"] = 10}, -- Enchant Boots - Surefooted "Surefooted" http://wow.allakhazam.com/db/spell.html?wspell=27954

		["위협 수준 감소"] = {["MOD_THREAT"] = -2}, -- Enchant Cloak - Subtlety
		["위협 수준 2%만큼 감소"] = {["MOD_THREAT"] = -2}, -- StatLogic:GetSum("item:23344:2832")
		["착용 효과: 물속에서 숨쉴 수 있도록 해줍니다."] = false, -- [얼음 심연의 고리] ID: 21526
		["물속에서 숨쉴 수 있도록 해줍니다"] = false, --
		["착용 효과: 무장 해제의 지속시간이 50%만큼 감소합니다."] = false, -- [야성의 건들릿] ID: 12639
		["무장해제에 면역이 됩니다"] = false, --
		["성전사"] = false, -- Enchant Crusader
		["흡혈"] = false, -- Enchant Crusader

		["투스카르의 활력"] = {["RUN_SPEED"] = 8, ["STA"] = 15}, -- EnchantID: 3232
		["지혜"] = {["MOD_THREAT"] = -2, ["SPI"] = 10}, -- EnchantID: 3296
		["적중"] = {["MELEE_HIT_RATING"] = 25, ["SPELL_HIT_RATING"] = 25, ["MELEE_CRIT_RATING"] = 25, ["SPELL_CRIT_RATING"] = 25}, -- EnchantID: 3788
		["스컬지 파멸"] = {["AP_UNDEAD"] = 140}, -- EnchantID: 3247
		["극지방랑자"] = {["MELEE_HIT_RATING"] = 12, ["SPELL_HIT_RATING"] = 12, ["MELEE_CRIT_RATING"] = 12, ["SPELL_CRIT_RATING"] = 12}, -- EnchantID: 3826
		["채집가"] = {["HERBALISM"] = 5, ["MINING"] = 5, ["SKINNING"] = 5}, -- EnchantID: 3296
		["상급 활력"] = {["MANA_REG"] = 6, ["HEALTH_REG"] = 6}, -- EnchantID: 3244
	},
	----------------------------
	-- Single Plus Stat Check --
	----------------------------
	-- depending on locale, it may be
	-- +19 Stamina = "^%+(%d+) (.-)%.?$"
	-- Stamina +19 = "^(.-) %+(%d+)%.?$"
	-- +19 耐力 = "^%+(%d+) (.-)%.?$"
	-- Some have a "." at the end of string like:
	-- Enchant Chest - Restore Mana Prime "+6 mana every 5 sec. "
	["SinglePlusStatCheck"] = "^(.-) ([%+%-]%d+)%.?$",
	-----------------------------
	-- Single Equip Stat Check --
	-----------------------------
	-- stat1, value, stat2 = strfind
	-- stat = stat1..stat2
	-- "^Equip: (.-) by u?p? ?t?o? ?(%d+) ?(.-)%.?$"
	["SingleEquipStatCheck"] = "^착용 효과: (.-) (%d+)만큼(.-)$",
	-------------
	-- PreScan --
	-------------
	-- Special cases that need to be dealt with before deep scan
	["PreScanPatterns"] = {
		--["^Equip: Increases attack power by (%d+) in Cat"] = "FERAL_AP",
		--["^Equip: Increases attack power by (%d+) when fighting Undead"] = "AP_UNDEAD", -- Seal of the Dawn ID:13029
		["^표범, 광포한 곰, 곰, 달빛야수 변신 상태일 때 전투력이 (%d+)만큼 증가합니다%.$"] = "FERAL_AP", -- 3.0.8 FAP change
		["^(%d+)의 피해 방어$"] = "BLOCK_VALUE",
		["^방어도 (%d+)$"] = "ARMOR",
		["방어도 보강 %(%+(%d+)%)"] = "ARMOR_BONUS",
		["매 5초마다 (%d+)의 생명력이 회복됩니다.$"] = "HEALTH_REG",
		["매 5초마다 (%d+)의 마나가 회복됩니다.$"] = "MANA_REG",
		["^.-공격력 %+?%d+ %- (%d+)$"] = "MAX_DAMAGE",
		["^%(초당 공격력 ([%d%.]+)%)$"] = "DPS",
		-- Exclude
		["^(%d+)칸"] = false, -- Bags
		["^[%D ]+ %((%d+)/%d+%)$"] = false, -- Set Name (0/9)
		["|cff808080"] = false, -- Gray text "  |cff808080Requires at least 2 Yellow gems|r\n  |cff808080Requires at least 1 Red gem|r"
		-- Procs
		["일정 확률로"] = false, -- [도전의 징표] ID:27924 -- [퀴라지 예언자의 지팡이] ID:21128
		["확률로"] = false, -- [다크문 카드: 영웅심] ID:19287
		["가격 당했을 때"] = false, -- [순수한 불꽃의 정수] ID: 18815
		["성공하면"] = false,
	},
	--------------
	-- DeepScan --
	--------------
	-- Strip leading "Equip: ", "Socket Bonus: "
	["Equip: "] = "착용 효과: ",
	["Socket Bonus: "] = "보석 장착 보너스: ",
	-- Strip trailing "."
	["."] = ".",
	["DeepScanSeparators"] = {
		"/", -- "+10 Defense Rating/+10 Stamina/+15 Block Value": ZG Enchant
		--", ", -- "+6 Spell Damage, +5 Spell Crit Rating": Potent Ornate Topaz ID: 28123
		"%. ", -- "Equip: Increases attack power by 81 when fighting Undead. It also allows the acquisition of Scourgestones on behalf of the Argent Dawn.": Seal of the Dawn
		" / ",
	},
	["DeepScanWordSeparators"] = {
		-- only put word separators here like "and" in english
	},
	["DualStatPatterns"] = { -- all lower case
		["^%+(%d+) 치유량 %+(%d+) 주문 공격력$"] = {{"HEAL",}, {"SPELL_DMG",},},
		["^모든 주문 및 효과에 의한 치유량이 최대 (%d+)만큼, 공격력이 최대 (%d+)만큼 증가합니다$"] = {{"HEAL",}, {"SPELL_DMG",},},
	},
	["DeepScanPatterns"] = {
		"^(.-) (%d+)만큼(.-)$", -- "xxx by up to 22 xxx" (scan first)
		"^(.-) 최대 (%d+)만큼(.-)$", -- "xxx by up to 22 xxx" (scan first)
		"^(.-) ?([%+%-]%d+) ?(.-)$", -- "xxx xxx +22" or "+22 xxx xxx" or "xxx +22 xxx" (scan 2ed)
		"^(.-) ?([%d%.]+) ?(.-)$", -- 22.22 xxx xxx (scan last)
	},
	-----------------------
	-- Stat Lookup Table --
	-----------------------
	["StatIDLookup"] = {
		["위협 수준%"] = {"MOD_THREAT"}, -- StatLogic:GetSum("item:23344:2613")
		["지능%"] = {"MOD_INT"}, -- [Ember Skyflare Diamond] ID: 41333
		["방패 피해 방어량%"] = {"MOD_BLOCK_VALUE"}, -- [Eternal Earthsiege Diamond] ID: 41396
		["조준경 (공격력)"] = {"RANGED_DMG"}, -- Khorium Scope EnchantID: 2723
		["조준경 (치명타 적중도)"] = {"RANGED_CRIT_RATING"}, -- Stabilized Eternium Scope EnchantID: 2724
		["공격 시 적의 방어도를 무시합니다"] = {"IGNORE_ARMOR"}, -- StatLogic:GetSum("item:33733")
		["은신의 효과 레벨이 증가합니다"] = {"STEALTH_LEVEL"}, -- [밤하늘 장화] ID: 8197
		["무기 공격력"] = {"MELEE_DMG"}, -- Enchant
		["탈것의 속도가 %만큼 증가합니다"] = {"MOUNT_SPEED"}, -- [산악연대 판금 경갑] ID: 20048

		["모든 능력치"] = {"STR", "AGI", "STA", "INT", "SPI",},
		["힘"] = {"STR",},
		["민첩성"] = {"AGI",},
		["체력"] = {"STA",},
		["지능"] = {"INT",},
		["정신력"] = {"SPI",},

		["비전 저항력"] = {"ARCANE_RES",},
		["화염 저항력"] = {"FIRE_RES",},
		["자연 저항력"] = {"NATURE_RES",},
		["냉기 저항력"] = {"FROST_RES",},
		["암흑 저항력"] = {"SHADOW_RES",},
		["비전 저항"] = {"ARCANE_RES",}, -- Arcane Armor Kit +8 Arcane Resist
		["화염 저항"] = {"FIRE_RES",}, -- Flame Armor Kit +8 Fire Resist
		["자연 저항"] = {"NATURE_RES",}, -- Frost Armor Kit +8 Frost Resist
		["냉기 저항"] = {"FROST_RES",}, -- Nature Armor Kit +8 Nature Resist
		["암흑 저항"] = {"SHADOW_RES",}, -- Shadow Armor Kit +8 Shadow Resist
		["암흑 저항력"] = {"SHADOW_RES",}, -- Demons Blood ID: 10779
		["모든 저항력"] = {"ARCANE_RES", "FIRE_RES", "FROST_RES", "NATURE_RES", "SHADOW_RES",},
		["모든 저항"] = {"ARCANE_RES", "FIRE_RES", "FROST_RES", "NATURE_RES", "SHADOW_RES",},

		["낚시"] = {"FISHING",}, -- Fishing enchant ID:846
		["낚시 숙련도"] = {"FISHING",}, -- Fishing lure
		["낚시 숙련도가 증가합니다"] = {"FISHING",}, -- Equip: Increased Fishing +20.
		["채광"] = {"MINING",}, -- Mining enchant ID:844
		["약초 채집"] = {"HERBALISM",}, -- Heabalism enchant ID:845
		["무두질"] = {"SKINNING",}, -- Skinning enchant ID:865

		["방어도"] = {"ARMOR_BONUS",},
		["방어 숙련"] = {"DEFENSE",},
		["방어 숙련 증가"] = {"DEFENSE",},
		["피해 방어"] = {"BLOCK_VALUE",}, -- +22 Block Value
		["피해 방어량"] = {"BLOCK_VALUE",}, -- +22 Block Value
		["방패의 피해 방어량이 증가합니다"] = {"BLOCK_VALUE",}, -- +10% Shield Block Value [Eternal Earthstorm Diamond] http://www.wowhead.com/?item=35501

		["생명력"] = {"HEALTH",},
		["HP"] = {"HEALTH",},
		["마나"] = {"MANA",},

		["전투력"] = {"AP",},
		["전투력이 증가합니다"] = {"AP",},
		["언데드에 대한 전투력"] = {"AP_UNDEAD",},
		-- [언데드 퇴치의 손목보호대] ID:23093
		["언데드에 대한 전투력이 증가합니다"] = {"AP_UNDEAD",}, -- [여명의 문장] ID:13209
		["언데드에 대한 전투력이 증가합니다. 또한 은빛 여명회를 대표하여 스컬지석을 획득할 수 있습니다"] = {"AP_UNDEAD",}, -- [여명의 문장] ID:13209
		["악마에 대한 전투력이 증가합니다"] = {"AP_DEMON",},
		["언데드 및 악마에 대한 전투력이 증가합니다"] = {"AP_UNDEAD", "AP_DEMON",},
		["언데드 및 악마에 대한 전투력이 증가합니다. 또한 은빛 여명회를 대표하여 스컬지석을 획득할 수 있습니다"] = {"AP_UNDEAD", "AP_DEMON",}, -- [용사의 징표] ID:23206
		["표범, 광포한 곰, 곰, 달빛야수 변신 상태일 때 전투력"] = {"FERAL_AP",},
		["표범, 광포한 곰, 곰, 달빛야수 변신 상태일 때 전투력이 증가합니다"] = {"FERAL_AP",},
		["원거리 전투력"] = {"RANGED_AP",},
		["원거리 전투력이 증가합니다"] = {"RANGED_AP",}, -- [대장군의 석궁] ID: 18837

		["생명력 회복량"] = {"HEALTH_REG",},
		["매 5초마다 (.+)의 생명력"] = {"HEALTH_REG",},
		["평상시 생명력 회복 속도"] = {"HEALTH_REG",}, -- [악마의 피] ID: 10779
		["마나 회복량"] = {"MANA_REG",}, -- Prophetic Aura +4 Mana Regen/+10 Stamina/+24 Healing Spells http://wow.allakhazam.com/db/spell.html?wspell=24167
		["매 5초마다 (.+)의 마나"] = {"MANA_REG",},
		["5초당 마나 회복량"] = {"MANA_REG",}, -- [호화로운 야안석] ID: 24057

		["주문 관통력"] = {"SPELLPEN",}, -- Enchant Cloak - Spell Penetration "+20 Spell Penetration" http://wow.allakhazam.com/db/spell.html?wspell=34003
		["주문 관통력이 증가합니다"] = {"SPELLPEN",},

		["치유량 및 주문 공격력"] = {"SPELL_DMG", "HEAL",}, -- Arcanum of Focus +8 Healing and Spell Damage http://wow.allakhazam.com/db/spell.html?wspell=22844
		["치유 및 주문 공격력"] = {"SPELL_DMG", "HEAL",},
		["주문 공격력 및 치유량"] = {"SPELL_DMG", "HEAL",},
		["주문 공격력"] = {"SPELL_DMG", "HEAL",},
		["모든 주문 및 효과의 공격력과 치유량이 증가합니다"] = {"SPELL_DMG", "HEAL"},
		["주위 30미터 반경에 있는 모든 파티원의 주문력이 증가합니다"] = {"SPELL_DMG", "HEAL"}, -- 아티쉬
		["주문 공격력 및 치유량"] = {"SPELL_DMG", "HEAL",}, --StatLogic:GetSum("item:22630")
		["피해"] = {"SPELL_DMG",},
		["주문 공격력이 증가합니다"] = {"SPELL_DMG",}, -- Atiesh ID:22630, 22631, 22632, 22589
		["주문력"] = {"SPELL_DMG", "HEAL",},
		["주문력이 증가합니다"] = {"SPELL_DMG", "HEAL",}, -- WotLK
		["신성 피해"] = {"HOLY_SPELL_DMG",},
		["비전 피해"] = {"ARCANE_SPELL_DMG",},
		["화염 피해"] = {"FIRE_SPELL_DMG",},
		["자연 피해"] = {"NATURE_SPELL_DMG",},
		["냉기 피해"] = {"FROST_SPELL_DMG",},
		["암흑 피해"] = {"SHADOW_SPELL_DMG",},
		["신성 주문력"] = {"HOLY_SPELL_DMG",},
		["비전 주문력"] = {"ARCANE_SPELL_DMG",},
		["화염 주문력"] = {"FIRE_SPELL_DMG",},
		["자연 주문력"] = {"NATURE_SPELL_DMG",},
		["냉기 주문력"] = {"FROST_SPELL_DMG",}, -- Acrobatic Staff of Frozen Wrath ID:3185:0:0:0:0:0:1957
		["암흑 주문력"] = {"SHADOW_SPELL_DMG",},
		["암흑 주문력이 증가합니다"] = {"SHADOW_SPELL_DMG",}, -- Frozen Shadoweave Vest ID:21871
		["냉기 주문력이 증가합니다"] = {"FROST_SPELL_DMG",}, -- Frozen Shadoweave Vest ID:21871
		["신성 주문력이 증가합니다"] = {"HOLY_SPELL_DMG",},
		["비전 주문력이 증가합니다"] = {"ARCANE_SPELL_DMG",},
		["화염 주문력이 증가합니다"] = {"FIRE_SPELL_DMG",},
		["자연 주문력이 증가합니다"] = {"NATURE_SPELL_DMG",},

		["언데드에 대한 주문력이 증가합니다"] = {"SPELL_DMG_UNDEAD"},
		["언데드에 대한 주문력이 증가합니다. 또한 은빛여명회의 대리인으로서 스컬지석을 모을 수 있습니다"] = {"SPELL_DMG_UNDEAD"},
		["언데드 및 악마에 대한 주문력이 증가합니다"] = {"SPELL_DMG_UNDEAD", "SPELL_DMG_DEMON"}, -- [용사의 징표] ID:23207

		["주문 치유량"] = {"HEAL",}, -- Enchant Gloves - Major Healing "+35 Healing Spells" http://wow.allakhazam.com/db/spell.html?wspell=33999
		["치유량 증가"] = {"HEAL",},
		["치유량"] = {"HEAL",},
		["주문 공격력"] = {"SPELL_DMG",}, -- 2.3.0 StatLogic:GetSum("item:23344:2343")
		["모든 주문 및 효과에 의한 치유량이"] = {"HEAL",}, -- 2.3.0
		["주문 피해가 증가합니다"] = {"SPELL_DMG",}, -- 2.3.0
		["모든 주문 및 효과에 의한 치유량이 증가합니다"] = {"HEAL",},

		["초당 공격력"] = {"DPS",},
		["초당의 피해 추가"] = {"DPS",}, -- [Thorium Shells] ID: 15977

		["방어 숙련도"] = {"DEFENSE_RATING",},
		["방어 숙련도가 증가합니다"] = {"DEFENSE_RATING",},
		["회피 숙련도"] = {"DODGE_RATING",},
		["회피 숙련도가 증가합니다."] = {"DODGE_RATING",},
		["무기 막기 숙련도"] = {"PARRY_RATING",},
		["무기 막기 숙련도가 증가합니다"] = {"PARRY_RATING",},
		["방패 막기 숙련도"] = {"BLOCK_RATING",},
		["방패 막기 숙련도가 증가합니다"] = {"BLOCK_RATING",},

		["적중도"] = {"MELEE_HIT_RATING", "SPELL_HIT_RATING"},
		["적중도가 증가합니다"] = {"MELEE_HIT_RATING", "SPELL_HIT_RATING"}, -- ITEM_MOD_HIT_RATING
		["근접 적중도가 증가합니다"] = {"MELEE_HIT_RATING",}, -- ITEM_MOD_HIT_MELEE_RATING
		["주문 적중"] = {"SPELL_HIT_RATING",}, -- Presence of Sight +18 Healing and Spell Damage/+8 Spell Hit http://wow.allakhazam.com/db/spell.html?wspell=24164
		["주문 적중도"] = {"SPELL_HIT_RATING",},
		["주문 적중도가 증가합니다"] = {"SPELL_HIT_RATING",}, -- ITEM_MOD_HIT_SPELL_RATING
		["원거리 적중도"] = {"RANGED_HIT_RATING",}, -- Biznicks 247x128 Accurascope EnchantID: 2523
		["원거리 적중도가 증가합니다"] = {"RANGED_HIT_RATING",}, -- ITEM_MOD_HIT_RANGED_RATING

		["치명타 적중도"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING",},
		["치명타 적중도가 증가합니다"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING",},
		["주문 극대화 적중도"] = {"SPELL_CRIT_RATING",},
		["주문 극대화 적중도가 증가합니다"] = {"SPELL_CRIT_RATING",},
		["주위 30미터 반경에 있는 모든 파티원의 주문 극대화 적중도가 증가합니다"] = {"SPELL_CRIT_RATING",},
		["원거리 치명타 적중도"] = {"RANGED_CRIT_RATING",}, -- Heartseeker Scope EnchantID: 3608
		["원거리 치명타 적중도가 증가합니다"] = {"RANGED_CRIT_RATING",}, -- Fletcher's Gloves ID:7348
		["치명타 및 주문 극대화 적중도"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING"},
		["치명타 및 주문 극대화 적중도가 증가합니다"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING"},

		["공격 회피 숙련도가 증가합니다"] = {"MELEE_HIT_AVOID_RATING"}, -- ITEM_MOD_HIT_TAKEN_RATING
		["근접 공격 회피 숙련도가 증가합니다"] = {"MELEE_HIT_AVOID_RATING"}, -- ITEM_MOD_HIT_TAKEN_MELEE_RATING
		["원거리 공격 회피 숙련도가 증가합니다"] = {"RANGED_HIT_AVOID_RATING"}, -- ITEM_MOD_HIT_TAKEN_RANGED_RATING
		["주문 공격 회피 숙련도가 증가합니다"] = {"SPELL_HIT_AVOID_RATING"}, -- ITEM_MOD_HIT_TAKEN_SPELL_RATING
		["탄력도"] = {"RESILIENCE_RATING",},
		["탄력도가 증가합니다"] = {"RESILIENCE_RATING",},
		["치명타 회피 숙련도가 증가합니다"] = {"MELEE_CRIT_AVOID_RATING",},
		["근접 치명타 회피 숙련도가 증가합니다"] = {"MELEE_CRIT_AVOID_RATING",},
		["원거리 치명타 회피 숙련도가 증가합니다"] = {"RANGED_CRIT_AVOID_RATING",},
		["주문 치명타 회피 숙련도가 증가합니다"] = {"SPELL_CRIT_AVOID_RATING",},

		["가속도"] = {"MELEE_HASTE_RATING", "SPELL_HASTE_RATING"},
		["가속도가 증가합니다"] = {"MELEE_HASTE_RATING", "SPELL_HASTE_RATING"},
		["근접 공격 가속도가 증가합니다"] = {"MELEE_HASTE_RATING"},
		["주문 시전 가속도"] = {"SPELL_HASTE_RATING"},
		["주문 시전 가속도가 증가합니다"] = {"SPELL_HASTE_RATING"},
		["원거리 공격 가속도"] = {"RANGED_HASTE_RATING"}, -- Micro Stabilizer EnchantID: 3607
		["원거리 공격 가속도가 증가합니다"] = {"RANGED_HASTE_RATING"},

		["단검류 숙련도가 증가합니다"] = {"DAGGER_WEAPON_RATING"},
		["한손 도검류 숙련도가 증가합니다"] = {"SWORD_WEAPON_RATING"},
		["양손 도검류 숙련도가 증가합니다"] = {"2H_SWORD_WEAPON_RATING"},
		["한손 도끼류 숙련도가 증가합니다"] = {"AXE_WEAPON_RATING"},
		["양손 도끼류 숙련도가 증가합니다"] = {"2H_AXE_WEAPON_RATING"},
		["한손 둔기류 숙련도가 증가합니다"] = {"MACE_WEAPON_RATING"},
		["양손 둔기류 숙련도가 증가합니다"] = {"2H_MACE_WEAPON_RATING"},
		["총기류 숙련도가 증가합니다"] = {"GUN_WEAPON_RATING"},
		["석궁류 숙련도가 증가합니다"] = {"CROSSBOW_WEAPON_RATING"},
		["활류 숙련도가 증가합니다"] = {"BOW_WEAPON_RATING"},
		["야성 전투 숙련도가 증가합니다"] = {"FERAL_WEAPON_RATING"},
		["장착 무기류 숙련도가 증가합니다"] = {"FIST_WEAPON_RATING"}, -- Demonblood Eviscerator
		["맨손 전투 숙련도가 증가합니다"] = {"FIST_WEAPON_RATING"}, -- Demonblood Eviscerator ID:27533
		["지팡이류 숙련도가 증가합니다"] = {"STAFF_WEAPON_RATING"}, -- Leggings of the Fang ID:10410

		["숙련"] = {"EXPERTISE_RATING"}, -- gems
		["방어구 관통력"] = {"ARMOR_PENETRATION_RATING"}, -- gems
		["숙련도가 증가합니다"] = {"EXPERTISE_RATING"},
		["방어구 관통력이 증가합니다"] = {"ARMOR_PENETRATION_RATING"},

		-- Exclude
		["초"] = false,
		["칸 가방"] = false,
		["칸 화살통"] = false,
		["칸 탄환 주머니"] = false,
		["원거리 공격 속도가%만큼 증가합니다"] = false, -- AV quiver
		["원거리 무기 공격 속도가%만큼 증가합니다"] = false, -- AV quiver
	},
}
DisplayLocale.koKR = {
	----------------
	-- Stat Names --
	----------------
	-- Please localize these strings too, global strings were used in the enUS locale just to have minimum
	-- localization effect when a locale is not available for that language, you don't have to use global
	-- strings in your localization.
  ["Stat Multiplier"] = "Stat Multiplier",
  ["Attack Power Multiplier"] = "Attack Power Multiplier",
  ["Reduced Physical Damage Taken"] = "Reduced Physical Damage Taken",
	["StatIDToName"] = {
		--[StatID] = {FullName, ShortName},
		---------------------------------------------------------------------------
		-- Tier1 Stats - Stats parsed directly off items
		["EMPTY_SOCKET_RED"] = {EMPTY_SOCKET_RED, "붉은 보석"}, -- EMPTY_SOCKET_RED = "Red Socket";
		["EMPTY_SOCKET_YELLOW"] = {EMPTY_SOCKET_YELLOW, "노란 보석"}, -- EMPTY_SOCKET_YELLOW = "Yellow Socket";
		["EMPTY_SOCKET_BLUE"] = {EMPTY_SOCKET_BLUE, "푸른 보석"}, -- EMPTY_SOCKET_BLUE = "Blue Socket";
		["EMPTY_SOCKET_META"] = {EMPTY_SOCKET_META, "얼개 보석"}, -- EMPTY_SOCKET_META = "Meta Socket";

		["IGNORE_ARMOR"] = {"방어도 무시", "방무"},
		["MOD_THREAT"] = {"위협(%)", "위협(%)"},
		["STEALTH_LEVEL"] = {"은신 레벨 증가", "은신 레벨"},
		["MELEE_DMG"] = {"근접 무기 공격력", "무기 공격력"}, -- DAMAGE = "Damage"
		["RANGED_DMG"] = {"원거리 무기 공격력", "원거리 공격력"}, -- DAMAGE = "Damage"
		["MOUNT_SPEED"] = {"탈것 속도(%)", "탈것 속도(%)"},
		["RUN_SPEED"] = {"이동 속도(%)", "이속(%)"},

		["STR"] = {SPELL_STAT1_NAME, SPELL_STAT1_NAME},
		["AGI"] = {SPELL_STAT2_NAME, "민첩"},
		["STA"] = {SPELL_STAT3_NAME, SPELL_STAT3_NAME},
		["INT"] = {SPELL_STAT4_NAME, SPELL_STAT4_NAME},
		["SPI"] = {SPELL_STAT5_NAME, SPELL_STAT5_NAME},
		["ARMOR"] = {ARMOR, ARMOR},
		["ARMOR_BONUS"] = {"효과에 의한"..ARMOR, ARMOR.."(보너스)"},

		["FIRE_RES"] = {RESISTANCE2_NAME, "화저"},
		["NATURE_RES"] = {RESISTANCE3_NAME, "자저"},
		["FROST_RES"] = {RESISTANCE4_NAME, "냉저"},
		["SHADOW_RES"] = {RESISTANCE5_NAME, "암저"},
		["ARCANE_RES"] = {RESISTANCE6_NAME, "비저"},

		["FISHING"] = {"낚시", "낚시"},
		["MINING"] = {"채광", "채광"},
		["HERBALISM"] = {"약초채집", "약초"},
		["SKINNING"] = {"무두질", "무두"},

		["BLOCK_VALUE"] = {"피해 방어량", "방어량"},

		["AP"] = {"전투력", "전투력"},
		["RANGED_AP"] = {RANGED_ATTACK_POWER, "원거리 전투력"},
		["FERAL_AP"] = {"야성 전투력", "야성 전투력"},
		["AP_UNDEAD"] = {"전투력 (언데드)", "전투력 (언데드)"},
		["AP_DEMON"] = {"전투력 (악마)", "전투력 (악마)"},

		["HEAL"] = {"치유량", "치유"},

		["SPELL_DMG"] = {PLAYERSTAT_SPELL_COMBAT.." 공격력", "공격력"},
		["SPELL_DMG_UNDEAD"] = {PLAYERSTAT_SPELL_COMBAT.." 공격력 (언데드)", "공격력 (언데드)"},
		["SPELL_DMG_DEMON"] = {PLAYERSTAT_SPELL_COMBAT.." 공격력 (악마)", "공격력 (악마)"},
		["HOLY_SPELL_DMG"] = {SPELL_SCHOOL1_CAP.." 공격력", SPELL_SCHOOL1_CAP.." 공격력"},
		["FIRE_SPELL_DMG"] = {SPELL_SCHOOL2_CAP.." 공격력", SPELL_SCHOOL2_CAP.." 공격력"},
		["NATURE_SPELL_DMG"] = {SPELL_SCHOOL3_CAP.." 공격력", SPELL_SCHOOL3_CAP.." 공격력"},
		["FROST_SPELL_DMG"] = {SPELL_SCHOOL4_CAP.." 공격력", SPELL_SCHOOL4_CAP.." 공격력"},
		["SHADOW_SPELL_DMG"] = {SPELL_SCHOOL5_CAP.." 공격력", SPELL_SCHOOL5_CAP.." 공격력"},
		["ARCANE_SPELL_DMG"] = {SPELL_SCHOOL6_CAP.." 공격력", SPELL_SCHOOL6_CAP.." 공격력"},

		["SPELLPEN"] = {PLAYERSTAT_SPELL_COMBAT.." "..SPELL_PENETRATION, PLAYERSTAT_SPELL_COMBAT.." "..SPELL_PENETRATION},

		["HEALTH"] = {HEALTH, "HP"},
		["MANA"] = {MANA, "MP"},
		["HEALTH_REG"] = {HEALTH.." 회복", "HP5"},
		["MANA_REG"] = {MANA.." 회복", "MP5"},

		["MAX_DAMAGE"] = {"최대 공격력", "맥뎀"},
		["DPS"] = {"초당 공격력", "DPS"},

		["DEFENSE_RATING"] = {COMBAT_RATING_NAME2, "방숙"}, -- COMBAT_RATING_NAME2 = "Defense Rating"
		["DODGE_RATING"] = {COMBAT_RATING_NAME3, "회피"}, -- COMBAT_RATING_NAME3 = "Dodge Rating"
		["PARRY_RATING"] = {COMBAT_RATING_NAME4, "무막"}, -- COMBAT_RATING_NAME4 = "Parry Rating"
		["BLOCK_RATING"] = {COMBAT_RATING_NAME5, "방막"}, -- COMBAT_RATING_NAME5 = "Block Rating"
		["MELEE_HIT_RATING"] = {COMBAT_RATING_NAME6, COMBAT_RATING_NAME6}, -- COMBAT_RATING_NAME6 = "Hit Rating"
		["RANGED_HIT_RATING"] = {PLAYERSTAT_RANGED_COMBAT.." "..COMBAT_RATING_NAME6, PLAYERSTAT_RANGED_COMBAT.." "..COMBAT_RATING_NAME6}, -- PLAYERSTAT_RANGED_COMBAT = "Ranged"
		["SPELL_HIT_RATING"] = {PLAYERSTAT_SPELL_COMBAT.." "..COMBAT_RATING_NAME6, PLAYERSTAT_SPELL_COMBAT.." "..COMBAT_RATING_NAME6}, -- PLAYERSTAT_SPELL_COMBAT = "Spell"
		["MELEE_HIT_AVOID_RATING"] = {"빗맞힘(숙련도)", "빗맞힘"},
		["RANGED_HIT_AVOID_RATING"] = {PLAYERSTAT_RANGED_COMBAT.." 빗맞힘(숙련도)", PLAYERSTAT_RANGED_COMBAT.." 빗맞힘"},
		["SPELL_HIT_AVOID_RATING"] = {PLAYERSTAT_RANGED_COMBAT.. "빗맞힘(숙련도)", PLAYERSTAT_RANGED_COMBAT.." 빗맞힘"},
		["MELEE_CRIT_RATING"] = {COMBAT_RATING_NAME9, "치명타"}, -- COMBAT_RATING_NAME9 = "Crit Rating"
		["RANGED_CRIT_RATING"] = {PLAYERSTAT_RANGED_COMBAT.." "..COMBAT_RATING_NAME9, PLAYERSTAT_RANGED_COMBAT.." 치명타"},
		["SPELL_CRIT_RATING"] = {PLAYERSTAT_SPELL_COMBAT.." "..COMBAT_RATING_NAME9, PLAYERSTAT_RANGED_COMBAT.." 치명타"},
		["MELEE_CRIT_AVOID_RATING"] = {"치명타 감소(숙련도)", "치명타 감소"},
		["RANGED_CRIT_AVOID_RATING"] = {PLAYERSTAT_RANGED_COMBAT.." 치명타 감소(숙련도)", PLAYERSTAT_RANGED_COMBAT.." 치명타 감소"},
		["SPELL_CRIT_AVOID_RATING"] = {PLAYERSTAT_SPELL_COMBAT.." 치명타 감소(숙련도)", PLAYERSTAT_SPELL_COMBAT.." 치명타 감소"},
		["RESILIENCE_RATING"] = {COMBAT_RATING_NAME15, COMBAT_RATING_NAME15}, -- COMBAT_RATING_NAME15 = "Resilience"
		["MELEE_HASTE_RATING"] = {"가속도", "가속도"},
		["RANGED_HASTE_RATING"] = {PLAYERSTAT_RANGED_COMBAT.." 가속도"..RATING, PLAYERSTAT_RANGED_COMBAT.." 가속도"},
		["SPELL_HASTE_RATING"] = {PLAYERSTAT_SPELL_COMBAT.." 가속도", PLAYERSTAT_SPELL_COMBAT.." 가속도"},
		["DAGGER_WEAPON_RATING"] = {"단검류 숙련도", "단검 숙련"}, -- SKILL = "Skill"
		["SWORD_WEAPON_RATING"] = {"도검류 숙련도", "도검 숙련"},
		["2H_SWORD_WEAPON_RATING"] = {"양손 도검류 숙련도", "양손 도검 숙련"},
		["AXE_WEAPON_RATING"] = {"도끼류 숙련도", "도끼 숙련"},
		["2H_AXE_WEAPON_RATING"] = {"양손 도끼류 숙련도", "양손 도끼 숙련"},
		["MACE_WEAPON_RATING"] = {"둔기류 숙련도", "둔기 숙련"},
		["2H_MACE_WEAPON_RATING"] = {"양손 둔기류 숙련도", "양손 둔기 숙련"},
		["GUN_WEAPON_RATING"] = {"총기류 숙련도", "총기 숙련"},
		["CROSSBOW_WEAPON_RATING"] = {"석궁류 숙련도", "석궁 숙련"},
		["BOW_WEAPON_RATING"] = {"활류 숙련도", "활 숙련"},
		["FERAL_WEAPON_RATING"] = {"야성 "..SKILL.." "..RATING, "야성 "..RATING},
		["FIST_WEAPON_RATING"] = {"맨손 전투 숙련도", "맨손 숙련"},
		["STAFF_WEAPON_RATING"] = {"지팡이류 숙련도", "지팡이 숙련"}, -- Leggings of the Fang ID:10410
		--["EXPERTISE_RATING"] = {STAT_EXPERTISE.." "..RATING, STAT_EXPERTISE.." "..RATING},
		["EXPERTISE_RATING"] = {"숙련".." "..RATING, "숙련".." "..RATING},
		["ARMOR_PENETRATION_RATING"] = {"방어구 관통력", "방어구 관통력"},

		---------------------------------------------------------------------------
		-- Tier2 Stats - Stats that only show up when broken down from a Tier1 stat
		-- Str -> AP, Block Value
		-- Agi -> AP, Crit, Dodge
		-- Sta -> Health
		-- Int -> Mana, Spell Crit
		-- Spi -> mp5nc, hp5oc
		-- Ratings -> Effect
		["HEALTH_REG_OUT_OF_COMBAT"] = {HEALTH.." 회복 (비전투)", "HP5(OC)"},
		["MANA_REG_NOT_CASTING"] = {MANA.." 회복 (비시전)", "MP5(NC)"},
		["MELEE_CRIT_DMG_REDUCTION"] = {"치명타 피해 감소(%)", "치명 피해감소(%)"},
		["RANGED_CRIT_DMG_REDUCTION"] = {PLAYERSTAT_RANGED_COMBAT.." 치명타 피해 감소(%)", PLAYERSTAT_RANGED_COMBAT.." 치명 피해감소(%)"},
		["SPELL_CRIT_DMG_REDUCTION"] = {PLAYERSTAT_SPELL_COMBAT.." 치명타 피해 감소(%)", PLAYERSTAT_SPELL_COMBAT.." 치명 피해감소(%)"},
		["DEFENSE"] = {DEFENSE, "방숙"},
		["DODGE"] = {DODGE.."(%)", DODGE.."(%)"},
		["PARRY"] = {PARRY.."(%)", PARRY.."(%)"},
		["BLOCK"] = {BLOCK.."(%)", BLOCK.."(%)"},
		["AVOIDANCE"] = {"방어행동(%)", "방어행동(%)"},
		["MELEE_HIT"] = {"적중(%)", "적중(%)"},
		["RANGED_HIT"] = {PLAYERSTAT_RANGED_COMBAT.." 적중(%)", PLAYERSTAT_RANGED_COMBAT.." 적중(%)"},
		["SPELL_HIT"] = {PLAYERSTAT_SPELL_COMBAT.." 적중(%)", PLAYERSTAT_SPELL_COMBAT.." 적중(%)"},
		["MELEE_HIT_AVOID"] = {"빗맞힘(%)", "빗맞힘(%)"},
		["RANGED_HIT_AVOID"] = {PLAYERSTAT_RANGED_COMBAT.." 빗맞힘(%)", PLAYERSTAT_RANGED_COMBAT.." 빗맞힘(%)"},
		["SPELL_HIT_AVOID"] = {PLAYERSTAT_SPELL_COMBAT.." 빗맞힘(%)", PLAYERSTAT_SPELL_COMBAT.." 빗맞힘(%)"},
		["MELEE_CRIT"] = {MELEE_CRIT_CHANCE.."(%)", "치명타(%)"}, -- MELEE_CRIT_CHANCE = "Crit Chance"
		["RANGED_CRIT"] = {PLAYERSTAT_RANGED_COMBAT.." "..MELEE_CRIT_CHANCE.."(%)", PLAYERSTAT_RANGED_COMBAT.." 치명타(%)"},
		["SPELL_CRIT"] = {PLAYERSTAT_SPELL_COMBAT.." "..SPELL_CRIT_CHANCE.."(%)", "극대화(%)"},
		["MELEE_CRIT_AVOID"] = {"치명타 감소(%)", "치명타 감소(%)"},
		["RANGED_CRIT_AVOID"] = {PLAYERSTAT_RANGED_COMBAT.." 치명타 감소(%)", PLAYERSTAT_RANGED_COMBAT.." 치명타 감소(%)"},
		["SPELL_CRIT_AVOID"] = {PLAYERSTAT_SPELL_COMBAT.." 치명타 감소(%)", PLAYERSTAT_SPELL_COMBAT.." 치명타 감소(%)"},
		["MELEE_HASTE"] = {"가속도(%)", "가속도(%)"},
		["RANGED_HASTE"] = {PLAYERSTAT_RANGED_COMBAT.." 가속도(%)", PLAYERSTAT_RANGED_COMBAT.." 가속도(%)"},
		["SPELL_HASTE"] = {PLAYERSTAT_SPELL_COMBAT.." 가속도(%)", PLAYERSTAT_SPELL_COMBAT.." 가속도(%)"},
		["DAGGER_WEAPON"] = {"단검류 숙련", "단검 숙련"}, -- SKILL = "Skill"
		["SWORD_WEAPON"] = {"도검류 숙련", "도검 숙련"},
		["2H_SWORD_WEAPON"] = {"양손 도검류 숙련", "양손 도검 숙련"},
		["AXE_WEAPON"] = {"도끼류 숙련", "도끼 숙련"},
		["2H_AXE_WEAPON"] = {"양손 도끼류 숙련", "양손 도끼 숙련"},
		["MACE_WEAPON"] = {"둔기류 숙련", "둔기 숙련"},
		["2H_MACE_WEAPON"] = {"양손 둔기류 숙련", "양손 둔기 숙련"},
		["GUN_WEAPON"] = {"총기류 숙련", "총기 숙련"},
		["CROSSBOW_WEAPON"] = {"석궁류 숙련", "석궁 숙련"},
		["BOW_WEAPON"] = {"활류 숙련", "활 숙련"},
		["FERAL_WEAPON"] = {"야성 "..SKILL, "야성"},
		["FIST_WEAPON"] = {"맨손 전투 숙련", "맨손 숙련"},
		["STAFF_WEAPON"] = {"지팡이류 숙련", "지팡이 숙련"}, -- Leggings of the Fang ID:10410
		--["EXPERTISE"] = {STAT_EXPERTISE, STAT_EXPERTISE},
		["EXPERTISE"] = {"숙련 ", "숙련"},
		["ARMOR_PENETRATION"] = {"방어구 관통(%)", "방어구 관통(%)"},

		---------------------------------------------------------------------------
		-- Tier3 Stats - Stats that only show up when broken down from a Tier2 stat
		-- Defense -> Crit Avoidance, Hit Avoidance, Dodge, Parry, Block
		-- Weapon Skill -> Crit, Hit, Dodge Neglect, Parry Neglect, Block Neglect
		-- Expertise -> Dodge Neglect, Parry Neglect
		["DODGE_NEGLECT"] = {"회피 무시(%)", "회피 무시(%)"},
		["PARRY_NEGLECT"] = {"무기 막기 무시(%)", "무막 무시(%)"},
		["BLOCK_NEGLECT"] = {"방패 막기 무시(%)", "방막 무시(%)"},

		---------------------------------------------------------------------------
		-- Talents
		["MELEE_CRIT_DMG"] = {"치명타 피해(%)", "치명타 피해(%)"},
		["RANGED_CRIT_DMG"] = {PLAYERSTAT_RANGED_COMBAT.." 치명타 피해(%)", PLAYERSTAT_RANGED_COMBAT.." 치명타 피해(%)"},
		["SPELL_CRIT_DMG"] = {PLAYERSTAT_SPELL_COMBAT.." 치명타 피해(%)", PLAYERSTAT_SPELL_COMBAT.." 치명타 피해(%)"},

		---------------------------------------------------------------------------
		-- Spell Stats
		-- These values can be prefixed with a @ and spell name, using reverse translation to english from Babble-Spell-2.2
		-- ex: "Heroic Strike@RAGE_COST" for Heroic Strike rage cost
		-- ex: "Heroic Strike@THREAT" for Heroic Strike threat value
		-- Use strsplit("@", text) to seperate the spell name and statid
		["THREAT"] = {"위협 수준", "위협"},
		["CAST_TIME"] = {"시전 시간", "시전"},
		["MANA_COST"] = {"마나 소비량", "마나"},
		["RAGE_COST"] = {"분노 소비량", "분노"},
		["ENERGY_COST"] = {"기력 소비량", "기력"},
		["COOLDOWN"] = {"재사용 대기시간", "쿨타임"},

		---------------------------------------------------------------------------
		-- Stats Mods
		["MOD_STR"] = {"효과: "..SPELL_STAT1_NAME.."(%)", "효과: "..SPELL_STAT1_NAME.."(%)"},
		["MOD_AGI"] = {"효과: "..SPELL_STAT2_NAME.."(%)", "효과: ".."민첩(%)"},
		["MOD_STA"] = {"효과: "..SPELL_STAT3_NAME.."(%)", "효과: "..SPELL_STAT3_NAME.."(%)"},
		["MOD_INT"] = {"효과: "..SPELL_STAT4_NAME.."(%)", "효과: "..SPELL_STAT4_NAME.."(%)"},
		["MOD_SPI"] = {"효과: "..SPELL_STAT5_NAME.."(%)", "효과: "..SPELL_STAT5_NAME.."(%)"},
		["MOD_HEALTH"] = {"효과: "..HEALTH.."(%)", "효과: HP(%)"},
		["MOD_MANA"] = {"효과: "..MANA.."(%)", "효과: MP(%)"},
		["MOD_ARMOR"] = {"효과: 아이템에 의한 "..ARMOR.."(%)", "효과: "..ARMOR.."(아이템)(%)"},
		["MOD_BLOCK_VALUE"] = {"효과: 피해 방어량(%)", "효과: 방어량(%)"},
		["MOD_DMG"] = {"효과: 공격력(%)", "효과: 공격력(%)"},
		["MOD_DMG_TAKEN"] = {"효과: 피해량(%)", "효과: 피해량(%)"},
		["MOD_CRIT_DAMAGE"] = {"효과: 치명타 공격력(%)", "효과: 치명타 공격력(%)"},
		["MOD_CRIT_DAMAGE_TAKEN"] = {"효과: 치명타 피해량(%)", "효과: 치명타 피해량(%)"},
		["MOD_THREAT"] = {"효과: 위협 수준(%)", "효과: 위협(%)"},
		["MOD_AP"] = {"효과: ".."전투력(%)", "효과: 전투력(%)"},
		["MOD_RANGED_AP"] = {"효과: "..PLAYERSTAT_RANGED_COMBAT.." 전투력(%)", "효과: "..PLAYERSTAT_RANGED_COMBAT.." 전투력(%)"},
		["MOD_SPELL_DMG"] = {"효과: "..PLAYERSTAT_SPELL_COMBAT.." 공격력(%)", "효과: "..PLAYERSTAT_SPELL_COMBAT.." 공격력(%)"},
		["MOD_HEALING"] = {"효과: 치유량(%)", "효과: 치유량(%)"},
		["MOD_CAST_TIME"] = {"효과: 시전 시간(%)", "효과: 시전(%)"},
		["MOD_MANA_COST"] = {"효과: 마나 소비량(%)", "효과: 마나(%)"},
		["MOD_RAGE_COST"] = {"효과: 분노 소비량(%)", "효과: 분노(%)"},
		["MOD_ENERGY_COST"] = {"효과: 기력 소비량(%)", "효과: 기력(%)"},
		["MOD_COOLDOWN"] = {"효과: 재사용 대기시간(%)", "효과: 쿨타임(%)"},

		---------------------------------------------------------------------------
		-- Misc Stats
		["WEAPON_RATING"] = {"무기 숙련도", "무기 숙련도"},
		["WEAPON_SKILL"] = {"무기 숙련", "무기 숙련"},
		["MAINHAND_WEAPON_RATING"] = {"주 장비 무기 숙련도", "주 장비 무기 숙련도"},
		["OFFHAND_WEAPON_RATING"] = {"보조 장비 무기 숙련도", "보조 장비 무기 숙련도"},
		["RANGED_WEAPON_RATING"] = {"원거리 무기 숙련도", "원거리 무기 숙련도"},
	},
}

-- zhTW localization by CuteMiyu, Ryuji
PatternLocale.zhTW = {
	["tonumber"] = tonumber,
	-----------------
	-- Armor Types --
	-----------------
	Plate = "鎧甲",
	Mail = "鎖甲",
	Leather = "皮甲",
	Cloth = "布甲",
	--["Dual Wield"] = "雙武器",
	-------------------
	-- Exclude Table --
	-------------------
	-- By looking at the first ExcludeLen letters of a line we can exclude a lot of lines
	["ExcludeLen"] = 3, -- using string.utf8len
	["Exclude"] = {
		[""] = true,
		[" \n"] = true,
		[ITEM_BIND_ON_EQUIP] = true, -- ITEM_BIND_ON_EQUIP = "Binds when equipped"; -- Item will be bound when equipped
		[ITEM_BIND_ON_PICKUP] = true, -- ITEM_BIND_ON_PICKUP = "Binds when picked up"; -- Item wil be bound when picked up
		[ITEM_BIND_ON_USE] = true, -- ITEM_BIND_ON_USE = "Binds when used"; -- Item will be bound when used
		[ITEM_BIND_QUEST] = true, -- ITEM_BIND_QUEST = "Quest Item"; -- Item is a quest item (same logic as ON_PICKUP)
		[ITEM_SOULBOUND] = true, -- ITEM_SOULBOUND = "Soulbound"; -- Item is Soulbound
		--[EMPTY_SOCKET_BLUE] = true, -- EMPTY_SOCKET_BLUE = "Blue Socket";
		--[EMPTY_SOCKET_META] = true, -- EMPTY_SOCKET_META = "Meta Socket";
		--[EMPTY_SOCKET_RED] = true, -- EMPTY_SOCKET_RED = "Red Socket";
		--[EMPTY_SOCKET_YELLOW] = true, -- EMPTY_SOCKET_YELLOW = "Yellow Socket";
		[ITEM_STARTS_QUEST] = true, -- ITEM_STARTS_QUEST = "This Item Begins a Quest"; -- Item is a quest giver
		[ITEM_CANT_BE_DESTROYED] = true, -- ITEM_CANT_BE_DESTROYED = "That item cannot be destroyed."; -- Attempted to destroy a NO_DESTROY item
		[ITEM_CONJURED] = true, -- ITEM_CONJURED = "Conjured Item"; -- Item expires
		[ITEM_DISENCHANT_NOT_DISENCHANTABLE] = true, -- ITEM_DISENCHANT_NOT_DISENCHANTABLE = "Cannot be disenchanted"; -- Items which cannot be disenchanted ever

		--["Disen"] = true, -- ITEM_DISENCHANT_ANY_SKILL = "Disenchantable"; -- Items that can be disenchanted at any skill level
		-- ITEM_DISENCHANT_MIN_SKILL = "Disenchanting requires %s (%d)"; -- Minimum enchanting skill needed to disenchant
		--["Durat"] = true, -- ITEM_DURATION_DAYS = "Duration: %d days";
		--["<Made"] = true, -- ITEM_CREATED_BY = "|cff00ff00<Made by %s>|r"; -- %s is the creator of the item
		--["Coold"] = true, -- ITEM_COOLDOWN_TIME_DAYS = "Cooldown remaining: %d day";
		["裝備單一限定"] = true, -- Unique-Equipped
		[ITEM_UNIQUE] = true, -- ITEM_UNIQUE = "Unique";
		["唯一("] = true, -- ITEM_UNIQUE_MULTIPLE = "Unique (%d)";
		["需要等"] = true, -- Requires Level xx
		["\n需要"] = true, -- Requires Level xx
		["需要 "] = true, -- Requires Level xx
		["需要騎"] = true, -- Requires Level xx
		["職業:"] = true, -- Classes: xx
		["種族:"] = true, -- Races: xx (vendor mounts)
		["使用:"] = true, -- Use:
		["擊中時"] = true, -- Chance On Hit:
		["需要鑄"] = true,
		["需要影"] = true,
		["需要月"] = true,
		["需要魔"] = true,
		-- Set Bonuses
		-- ITEM_SET_BONUS = "Set: %s";
		-- ITEM_SET_BONUS_GRAY = "(%d) Set: %s";
		-- ITEM_SET_NAME = "%s (%d/%d)"; -- Set name (2/5)
		["套裝:"] = true,
		["(2)"] = true,
		["(3)"] = true,
		["(4)"] = true,
		["(5)"] = true,
		["(6)"] = true,
		["(7)"] = true,
		["(8)"] = true,
		-- Equip type
		["彈藥"] = true, -- Ice Threaded Arrow ID:19316
		[INVTYPE_AMMO] = true,
		[INVTYPE_HEAD] = true,
		[INVTYPE_NECK] = true,
		[INVTYPE_SHOULDER] = true,
		[INVTYPE_BODY] = true,
		[INVTYPE_CHEST] = true,
		[INVTYPE_ROBE] = true,
		[INVTYPE_WAIST] = true,
		[INVTYPE_LEGS] = true,
		[INVTYPE_FEET] = true,
		[INVTYPE_WRIST] = true,
		[INVTYPE_HAND] = true,
		[INVTYPE_FINGER] = true,
		[INVTYPE_TRINKET] = true,
		[INVTYPE_CLOAK] = true,
		[INVTYPE_WEAPON] = true,
		[INVTYPE_SHIELD] = true,
		[INVTYPE_2HWEAPON] = true,
		[INVTYPE_WEAPONMAINHAND] = true,
		[INVTYPE_WEAPONOFFHAND] = true,
		[INVTYPE_HOLDABLE] = true,
		[INVTYPE_RANGED] = true,
		[INVTYPE_THROWN] = true,
		[INVTYPE_RANGEDRIGHT] = true,
		[INVTYPE_RELIC] = true,
		[INVTYPE_TABARD] = true,
		[INVTYPE_BAG] = true,
	},
	--[[
	textTable = {
		"+6法術傷害及+5法術命中等級",
		"+3  耐力, +4 致命一擊等級",
		"++26 治療法術 & 降低2% 威脅值",
		"+3 耐力/+4 致命一擊等級",
		"插槽加成:每5秒+2法力",
		"裝備： 使所有法術和魔法效果所造成的傷害和治療效果提高最多150點。",
		"裝備： 使半徑30碼範圍內所有小隊成員的法術致命一擊等級提高28點。",
		"裝備： 使30碼範圍內的所有隊友提高所有法術和魔法效果所造成的傷害和治療效果，最多33點。",
		"裝備： 使周圍半徑30碼範圍內隊友的所有法術和魔法效果所造成的治療效果提高最多62點。",
		"裝備： 使你的法術傷害提高最多120點，以及你的治療效果最多300點。",
		"裝備： 使周圍半徑30碼範圍內的隊友每5秒恢復11點法力。",
		"裝備： 使法術所造成的治療效果提高最多300點。",
		"裝備： 在獵豹、熊、巨熊和梟獸形態下的攻擊強度提高420點。",
		-- "+10 Defense Rating/+10 Stamina/+15 Block Value": ZG Enchant
		-- "+26 Attack Power and +14 Critical Strike Rating": Swift Windfire Diamond ID:28556
		"+26治療和+9法術傷害及降低2%威脅值", --: Bracing Earthstorm Diamond ID:25897
		-- "+6 Spell Damage, +5 Spell Crit Rating": Potent Ornate Topaz ID: 28123
		----
		-- "Critical Rating +6 and Dodge Rating +5": Assassin's Fire Opal ID:30565
		-- "Healing +11 and 2 mana per 5 sec.": Royal Tanzanite ID: 30603
	}
	--]]
	-----------------------
	-- Whole Text Lookup --
	-----------------------
	-- Mainly used for enchants that doesn't have numbers in the text
	["WholeTextLookup"] = {
		[EMPTY_SOCKET_RED] = {["EMPTY_SOCKET_RED"] = 1}, -- EMPTY_SOCKET_RED = "Red Socket";
		[EMPTY_SOCKET_YELLOW] = {["EMPTY_SOCKET_YELLOW"] = 1}, -- EMPTY_SOCKET_YELLOW = "Yellow Socket";
		[EMPTY_SOCKET_BLUE] = {["EMPTY_SOCKET_BLUE"] = 1}, -- EMPTY_SOCKET_BLUE = "Blue Socket";
		[EMPTY_SOCKET_META] = {["EMPTY_SOCKET_META"] = 1}, -- EMPTY_SOCKET_META = "Meta Socket";

		["初級巫師之油"] = {["SPELL_DMG"] = 8, ["HEAL"] = 8}, --
		["次級巫師之油"] = {["SPELL_DMG"] = 16, ["HEAL"] = 16}, --
		["巫師之油"] = {["SPELL_DMG"] = 24, ["HEAL"] = 24}, --
		["卓越巫師之油"] = {["SPELL_DMG"] = 36, ["HEAL"] = 36, ["SPELL_CRIT_RATING"] = 14}, --
		["超強巫師之油"] = {["SPELL_DMG"] = 42, ["HEAL"] = 42}, --
		["受祝福的巫師之油"] = {["SPELL_DMG_UNDEAD"] = 60}, -- ID: 23123

		["初級法力之油"] = {["MANA_REG"] = 4}, --
		["次級法力之油"] = {["MANA_REG"] = 8}, --
		["卓越法力之油"] = {["MANA_REG"] = 12, ["HEAL"] = 25}, --
		["超強法力之油"] = {["MANA_REG"] = 14}, --

		["恆金漁線釣魚"] = {["FISHING"] = 5}, --
		["兇蠻"] = {["AP"] = 70}, --
		["活力"] = {["MANA_REG"] = 4, ["HEALTH_REG"] = 4}, --
		["靈魂冰霜"] = {["SHADOW_SPELL_DMG"] = 54, ["FROST_SPELL_DMG"] = 54}, --
		["烈日火焰"] = {["ARCANE_SPELL_DMG"] = 50, ["FIRE_SPELL_DMG"] = 50}, --

		["秘銀馬刺"] = {["MOUNT_SPEED"] = 4}, -- Mithril Spurs
		["坐騎移動速度略微提升"] = {["MOUNT_SPEED"] = 2}, -- Enchant Gloves - Riding Skill
		["裝備：略微提高移動速度。"] = {["RUN_SPEED"] = 8}, -- [Highlander's Plate Greaves] ID: 20048
		["略微提高移動速度"] = {["RUN_SPEED"] = 8}, --
		["略微提高奔跑速度"] = {["RUN_SPEED"] = 8}, --
		["移動速度略微提升"] = {["RUN_SPEED"] = 8}, -- Enchant Boots - Minor Speed
		["初級速度"] = {["RUN_SPEED"] = 8}, -- Enchant Boots - Minor Speed
		["穩固"] = {["MELEE_HIT_RATING"] = 10}, -- Enchant Boots - Surefooted "Surefooted" http://wow.allakhazam.com/db/spell.html?wspell=27954

		["狡詐"] = {["MOD_THREAT"] = -2}, -- Enchant Cloak - Subtlety
		["威脅值降低2%"] = {["MOD_THREAT"] = -2}, -- StatLogic:GetSum("item:23344:2832")
		["裝備: 使你可以在水下呼吸。"] = false, -- [Band of Icy Depths] ID: 21526
		["使你可以在水下呼吸"] = false, --
		["裝備: 免疫繳械。"] = false, -- [Stronghold Gauntlets] ID: 12639
		["免疫繳械"] = false, --
		["十字軍"] = false, -- Enchant Crusader
		["生命偷取"] = false, -- Enchant Crusader

		["巨牙活力"] = {["RUN_SPEED"] = 8, ["STA"] = 15}, -- EnchantID: 3232
		["智慧精進"] = {["MOD_THREAT"] = -2, ["SPI"] = 10}, -- EnchantID: 3296
		["精確"] = {["MELEE_HIT_RATING"] = 25, ["SPELL_HIT_RATING"] = 25, ["MELEE_CRIT_RATING"] = 25, ["SPELL_CRIT_RATING"] = 25}, -- EnchantID: 3788
		["天譴剋星"] = {["AP_UNDEAD"] = 140}, -- EnchantID: 3247
		["冰行者"] = {["MELEE_HIT_RATING"] = 12, ["SPELL_HIT_RATING"] = 12, ["MELEE_CRIT_RATING"] = 12, ["SPELL_CRIT_RATING"] = 12}, -- EnchantID: 3826
		["採集者"] = {["HERBALISM"] = 5, ["MINING"] = 5, ["SKINNING"] = 5}, -- EnchantID: 3238
		["強效活力"] = {["MANA_REG"] = 6, ["HEALTH_REG"] = 6}, -- EnchantID: 3244
	},
	----------------------------
	-- Single Plus Stat Check --
	----------------------------
	-- depending on locale, it may be
	-- +19 Stamina = "^%+(%d+) ([%a ]+%a)$"
	-- Stamina +19 = "^([%a ]+%a) %+(%d+)$"
	-- +19 耐力 = "^%+(%d+) (.-)$"
	--["SinglePlusStatCheck"] = "^%+(%d+) ([%a ]+%a)$",
	["SinglePlusStatCheck"] = "^([%+%-]%d+) (.-)$",
	-----------------------------
	-- Single Equip Stat Check --
	-----------------------------
	-- stat1, value, stat2 = strfind
	-- stat = stat1..stat2
	-- "^Equip: (.-) by u?p? ?t?o? ?(%d+) ?(.-)%.$"
	--裝備: 提高法術命中等級28點
	--裝備: 使所有法術和魔法效果所造成的傷害和治療效果提高最多50點。
	--"裝備： (.-)提高(最多)?(%d+)(點)?(.-)。$",
	-- 用\230?\156?\128?\229?\164?\154?(%d+)\233?\187?\158?並不安全
	["SingleEquipStatCheck"] = "裝備: (.-)(%d+)點(.-)。$",
	-------------
	-- PreScan --
	-------------
	-- Special cases that need to be dealt with before deep scan
	["PreScanPatterns"] = {
		--["^Equip: Increases attack power by (%d+) in Cat"] = "FERAL_AP",
		--["^Equip: Increases attack power by (%d+) when fighting Undead"] = "AP_UNDEAD", -- Seal of the Dawn ID:13029
		["^使你在獵豹、熊、巨熊和梟獸形態下的攻擊強度提高(%d+)點。$"] = "FERAL_AP", -- 3.0.8 FAP change
		["^(%d+)格擋$"] = "BLOCK_VALUE",
		["^(%d+)點護甲$"] = "ARMOR",
		["強化護甲 %+(%d+)"] = "ARMOR_BONUS",
		["^%+?%d+ %- (%d+).-傷害$"] = "MAX_DAMAGE",
		["^%(每秒傷害([%d%.]+)%)$"] = "DPS",
		-- Exclude
		["^(%d+)格.-包"] = false, -- # of slots and bag type
		["^(%d+)格.-袋"] = false, -- # of slots and bag type
		["^(%d+)格容器"] = false, -- # of slots and bag type
		["^.+%((%d+)/%d+%)$"] = false, -- Set Name (0/9)
		["|cff808080"] = false, -- Gray text "  |cff808080Requires at least 2 Yellow gems|r\n  |cff808080Requires at least 1 Red gem|r"
		-- Procs
		--["機率"] = false, --[挑戰印記] ID:27924
		["有機會"] = false, -- [Mark of Defiance] ID:27924 -- [Staff of the Qiraji Prophets] ID:21128
		["有可能"] = false, -- [Darkmoon Card: Heroism] ID:19287
		["命中時"] = false, -- [黑色摧毀者手套] ID:22194
		["被擊中之後"] = false, -- [Essence of the Pure Flame] ID: 18815
		["在你殺死一個敵人"] = false, -- [注入精華的蘑菇] ID:28109
		["每當你的"] = false, -- [電光相容器] ID: 28785
		["被擊中時"] = false, --
	},
	--------------
	-- DeepScan --
	--------------
	-- Strip leading "Equip: ", "Socket Bonus: "
	["Equip: "] = "裝備: ", -- ITEM_SPELL_TRIGGER_ONEQUIP = "Equip:";
	["Socket Bonus: "] = "插槽加成:", -- ITEM_SOCKET_BONUS = "Socket Bonus: %s"; -- Tooltip tag for socketed item matched socket bonuses
	-- Strip trailing "."
	["."] = "。",
	["DeepScanSeparators"] = {
		"/", -- "+10 Defense Rating/+10 Stamina/+15 Block Value": ZG Enchant
		" & ", -- "+26 Healing Spells & 2% Reduced Threat": Bracing Earthstorm Diamond ID:25897
		", ", -- "+6 Spell Damage, +5 Spell Crit Rating": Potent Ornate Topaz ID: 28123
		"。", -- "裝備： 對不死生物的攻擊強度提高$s1點。同時也可為銀色黎明收集天譴石。": 黎明聖印
	},
	["DeepScanWordSeparators"] = {
		"及", "和", "並", "，" -- [發光的暗影卓奈石] ID:25894 "+24攻擊強度及略微提高奔跑速度", [刺客的火焰蛋白石] ID:30565 "+6致命一擊等級及+5閃躲等級"
	},
	["DualStatPatterns"] = { -- all lower case
		["^%+(%d+)治療和%+(%d+)法術傷害$"] = {{"HEAL",}, {"SPELL_DMG",},},
		["^%+(%d+)治療和%+(%d+)法術傷害及"] = {{"HEAL",}, {"SPELL_DMG",},},
		["^使法術和魔法效果所造成的治療效果提高最多(%d+)點，法術傷害提高最多(%d+)點$"] = {{"HEAL",}, {"SPELL_DMG",},},
	},
	["DeepScanPatterns"] = {
		"^(.-)提高最多([%d%.]+)點(.-)$", --
		"^(.-)提高最多([%d%.]+)(.-)$", --
		"^(.-)，最多([%d%.]+)點(.-)$", --
		"^(.-)，最多([%d%.]+)(.-)$", --
		"^(.-)最多([%d%.]+)點(.-)$", --
		"^(.-)最多([%d%.]+)(.-)$", --
		"^(.-)提高([%d%.]+)點(.-)$", --
		"^(.-)提高([%d%.]+)(.-)$", --
		"^提高(.-)([%d%.]+)點(.-)$", -- 提高法術能量98點 ID: 40685
		"^(.-)([%d%.]+)點(.-)$", --
		"^(.-) ?([%+%-][%d%.]+) ?點(.-)$", --
		"^(.-) ?([%+%-][%d%.]+) ?(.-)$", --
		"^(.-) ?([%d%.]+) ?點(.-)$", --
		"^(.-) ?([%d%.]+) ?(.-)$", --
	},
	-----------------------
	-- Stat Lookup Table --
	-----------------------
	["StatIDLookup"] = {
		--["%昏迷抗性"] = {},
		["你的攻擊無視目標點護甲值"] = {"IGNORE_ARMOR"},
		["使你的有效潛行等級提高"] = {"STEALTH_LEVEL"}, -- [Nightscape Boots] ID: 8197
		["潛行"] = {"STEALTH_LEVEL"}, -- Cloak Enchant
		["武器傷害"] = {"MELEE_DMG"}, -- Enchant
		["使坐騎速度提高%"] = {"MOUNT_SPEED"}, -- [Highlander's Plate Greaves] ID: 20048

		["所有屬性"] = {"STR", "AGI", "STA", "INT", "SPI",},
		["力量"] = {"STR",},
		["敏捷"] = {"AGI",},
		["耐力"] = {"STA",},
		["智力"] = {"INT",},
		["精神"] = {"SPI",},

		["秘法抗性"] = {"ARCANE_RES",},
		["火焰抗性"] = {"FIRE_RES",},
		["自然抗性"] = {"NATURE_RES",},
		["冰霜抗性"] = {"FROST_RES",},
		["暗影抗性"] = {"SHADOW_RES",},
		["陰影抗性"] = {"SHADOW_RES",}, -- Demons Blood ID: 10779
		["所有抗性"] = {"ARCANE_RES", "FIRE_RES", "FROST_RES", "NATURE_RES", "SHADOW_RES",},
		["全部抗性"] = {"ARCANE_RES", "FIRE_RES", "FROST_RES", "NATURE_RES", "SHADOW_RES",},
		["抵抗全部"] = {"ARCANE_RES", "FIRE_RES", "FROST_RES", "NATURE_RES", "SHADOW_RES",},
		["點所有魔法抗性"] = {"ARCANE_RES", "FIRE_RES", "FROST_RES", "NATURE_RES", "SHADOW_RES",}, -- [鋸齒黑曜石之盾] ID:22198

		["釣魚"] = {"FISHING",}, -- Fishing enchant ID:846
		["釣魚技能"] = {"FISHING",}, -- Fishing lure
		["使釣魚技能"] = {"FISHING",}, -- Equip: Increased Fishing +20.
		["採礦"] = {"MINING",}, -- Mining enchant ID:844
		["草藥學"] = {"HERBALISM",}, -- Heabalism enchant ID:845
		["剝皮"] = {"SKINNING",}, -- Skinning enchant ID:865

		["護甲"] = {"ARMOR_BONUS",},
		["護甲值"] = {"ARMOR_BONUS",},
		["強化護甲"] = {"ARMOR_BONUS",},
		["防禦"] = {"DEFENSE",},
		["增加防禦"] = {"DEFENSE",},
		["格擋"] = {"BLOCK_VALUE",}, -- +22 Block Value
		["格擋值"] = {"BLOCK_VALUE",}, -- +22 Block Value
		["提高格擋值"] = {"BLOCK_VALUE",},
		["使你盾牌的格擋值"] = {"BLOCK_VALUE",},
		["提高盾牌格擋值"] = {"BLOCK_VALUE",},

		["生命力"] = {"HEALTH",},
		["法力"] = {"MANA",},

		["攻擊強度"] = {"AP",},
		["使攻擊強度"] = {"AP",},
		["提高攻擊強度"] = {"AP",},
		["對不死生物的攻擊強度"] = {"AP_UNDEAD",}, -- [黎明聖印] ID:13209 -- [弒妖裹腕] ID:23093
		["對不死生物和惡魔的攻擊強度"] = {"AP_UNDEAD", "AP_DEMON",}, -- [勇士徽章] ID:23206
		["對惡魔的攻擊強度"] = {"AP_DEMON",},
		["在獵豹、熊、巨熊和梟獸形態下的攻擊強度"] = {"FERAL_AP",}, -- Atiesh ID:22632
		["在獵豹、熊、巨熊還有梟獸形態下的攻擊強度"] = {"FERAL_AP",}, --
		["遠程攻擊強度"] = {"RANGED_AP",}, -- [High Warlord's Crossbow] ID: 18837

		["每5秒恢復生命力"] = {"HEALTH_REG",}, -- [Resurgence Rod] ID:17743
		["一般的生命力恢復速度"] = {"HEALTH_REG",}, -- [Demons Blood] ID: 10779

		["每5秒法力"] = {"MANA_REG",}, --
		["每5秒恢復法力"] = {"MANA_REG",}, -- [Royal Tanzanite] ID: 30603
		["每五秒恢復法力"] = {"MANA_REG",}, -- 長者之XXX
		["法力恢復"] = {"MANA_REG",}, --
		["使周圍半徑30碼範圍內的隊友每5秒恢復法力"] = {"MANA_REG",}, --

		["法術穿透"] = {"SPELLPEN",},
		["法術穿透力"] = {"SPELLPEN",},
		["使你的法術穿透力"] = {"SPELLPEN",},

		["法術傷害和治療"] = {"SPELL_DMG", "HEAL",},
		["治療和法術傷害"] = {"SPELL_DMG", "HEAL",},
		["法術傷害"] = {"SPELL_DMG", "HEAL",},
		["使法術和魔法效果所造成的傷害和治療效果"] = {"SPELL_DMG", "HEAL"},
		["使所有法術和魔法效果所造成的傷害和治療效果"] = {"SPELL_DMG", "HEAL"},
		["使所有法術和魔法效果所造成的傷害和治療效果提高最多"] = {"SPELL_DMG", "HEAL"},
		["使周圍半徑30碼範圍內隊友的所有法術和魔法效果所造成的傷害和治療效果"] = {"SPELL_DMG", "HEAL"}, -- Atiesh, ID: 22630
		--StatLogic:GetSum("22630")
		--SetTip("22630")
		-- Atiesh ID:22630, 22631, 22632, 22589
				--裝備: 使周圍半徑30碼範圍內隊友的所有法術和魔法效果所造成的傷害和治療效果提高最多33點。 -- 22630 -- 2.1.0
				--裝備: 使周圍半徑30碼範圍內隊友的所有法術和魔法效果所造成的治療效果提高最多62點。 -- 22631
				--裝備: 使半徑30碼範圍內所有小隊成員的法術致命一擊等級提高28點。 -- 22589
				--裝備: 使周圍半徑30碼範圍內的隊友每5秒恢復11點法力。
		["使你的法術傷害"] = {"SPELL_DMG",}, -- Atiesh ID:22631
		["傷害"] = {"SPELL_DMG",},
		["法術能量"] = {"SPELL_DMG", "HEAL" },
		["神聖傷害"] = {"HOLY_SPELL_DMG",},
		["秘法傷害"] = {"ARCANE_SPELL_DMG",},
		["火焰傷害"] = {"FIRE_SPELL_DMG",},
		["自然傷害"] = {"NATURE_SPELL_DMG",},
		["冰霜傷害"] = {"FROST_SPELL_DMG",},
		["暗影傷害"] = {"SHADOW_SPELL_DMG",},
		["神聖法術傷害"] = {"HOLY_SPELL_DMG",},
		["秘法法術傷害"] = {"ARCANE_SPELL_DMG",},
		["火焰法術傷害"] = {"FIRE_SPELL_DMG",},
		["自然法術傷害"] = {"NATURE_SPELL_DMG",},
		["冰霜法術傷害"] = {"FROST_SPELL_DMG",}, -- Acrobatic Staff of Frozen Wrath ID:3185:0:0:0:0:0:1957
		["暗影法術傷害"] = {"SHADOW_SPELL_DMG",},
		["使秘法法術和效果所造成的傷害"] = {"ARCANE_SPELL_DMG",},
		["使火焰法術和效果所造成的傷害"] = {"FIRE_SPELL_DMG",},
		["使冰霜法術和效果所造成的傷害"] = {"FROST_SPELL_DMG",}, -- Frozen Shadoweave Vest ID:21871
		["使神聖法術和效果所造成的傷害"] = {"HOLY_SPELL_DMG",},
		["使自然法術和效果所造成的傷害"] = {"NATURE_SPELL_DMG",},
		["使暗影法術和效果所造成的傷害"] = {"SHADOW_SPELL_DMG",}, -- Frozen Shadoweave Vest ID:21871

		-- [Robe of Undead Cleansing] ID:23085
		["使魔法和法術效果對不死生物造成的傷害"] = {"SPELL_DMG_UNDEAD",}, -- [黎明符文] ID:19812
		["提高所有法術和效果對不死生物所造成的傷害"] = {"SPELL_DMG_UNDEAD",}, -- [淨妖長袍] ID:23085
		["提高法術和魔法效果對不死生物和惡魔所造成的傷害"] = {"SPELL_DMG_UNDEAD", "SPELL_DMG_DEMON",}, -- [勇士徽章] ID:23207

		["你的治療效果"] = {"HEAL",}, -- Atiesh ID:22631
		["治療法術"] = {"HEAL",}, -- +35 Healing Glove Enchant
		["治療效果"] = {"HEAL",}, -- [聖使祝福手套] Socket Bonus
		["治療"] = {"HEAL",},
		["神聖效果"] = {"HEAL",},-- Enchant Ring - Healing Power
		["使法術所造成的治療效果"] = {"HEAL",},
		["使法術和魔法效果所造成的治療效果"] = {"HEAL",},
		["使周圍半徑30碼範圍內隊友的所有法術和魔法效果所造成的治療效果"] = {"HEAL",}, -- Atiesh, ID: 22631

		["每秒傷害"] = {"DPS",},
		["每秒傷害提高"] = {"DPS",}, -- [Thorium Shells] ID: 15997

		["防禦等級"] = {"DEFENSE_RATING",},
		["提高防禦等級"] = {"DEFENSE_RATING",},
		["提高你的防禦等級"] = {"DEFENSE_RATING",},
		["使防禦等級"] = {"DEFENSE_RATING",},
		["使你的防禦等級"] = {"DEFENSE_RATING",},
		["閃躲等級"] = {"DODGE_RATING",},
		["提高閃躲等級"] = {"DODGE_RATING",},
		["提高你的閃躲等級"] = {"DODGE_RATING",},
		["使閃躲等級"] = {"DODGE_RATING",},
		["使你的閃躲等級"] = {"DODGE_RATING",},
		["招架等級"] = {"PARRY_RATING",},
		["提高招架等級"] = {"PARRY_RATING",},
		["提高你的招架等級"] = {"PARRY_RATING",},
		["使招架等級"] = {"PARRY_RATING",},
		["使你的招架等級"] = {"PARRY_RATING",},
		["格擋機率等級"] = {"BLOCK_RATING",},
		["提高格擋機率等級"] = {"BLOCK_RATING",},
		["提高你的格擋機率等級"] = {"BLOCK_RATING",},
		["使格擋機率等級"] = {"BLOCK_RATING",},
		["使你的格擋機率等級"] = {"BLOCK_RATING",},
		["格擋等級"] = {"BLOCK_RATING",},
		["提高格擋等級"] = {"BLOCK_RATING",},
		["提高你的格擋等級"] = {"BLOCK_RATING",},
		["使格擋等級"] = {"BLOCK_RATING",},
		["使你的格擋等級"] = {"BLOCK_RATING",},
		["盾牌格擋等級"] = {"BLOCK_RATING",},
		["提高盾牌格擋等級"] = {"BLOCK_RATING",},
		["提高你的盾牌格擋等級"] = {"BLOCK_RATING",},
		["使盾牌格擋等級"] = {"BLOCK_RATING",},
		["使你的盾牌格擋等級"] = {"BLOCK_RATING",},

		["命中等級"] = {"MELEE_HIT_RATING", "SPELL_HIT_RATING"},
		["提高命中等級"] = {"MELEE_HIT_RATING", "SPELL_HIT_RATING"}, -- ITEM_MOD_HIT_RATING
		["提高近戰命中等級"] = {"MELEE_HIT_RATING",}, -- ITEM_MOD_HIT_MELEE_RATING
		["使你的命中等級"] = {"MELEE_HIT_RATING",},
		["法術命中等級"] = {"SPELL_HIT_RATING",},
		["提高法術命中等級"] = {"SPELL_HIT_RATING",}, -- ITEM_MOD_HIT_SPELL_RATING
		["使你的法術命中等級"] = {"SPELL_HIT_RATING",},
		["遠程命中等級"] = {"RANGED_HIT_RATING",},
		["提高遠距命中等級"] = {"RANGED_HIT_RATING",}, -- ITEM_MOD_HIT_RANGED_RATING
		["使你的遠程命中等級"] = {"RANGED_HIT_RATING",},

		["致命一擊"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING"}, -- ID:31868
		["致命一擊等級"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING"},
		["提高致命一擊等級"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING"},
		["使你的致命一擊等級"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING"},
		["近戰致命一擊等級"] = {"MELEE_CRIT_RATING",},
		["提高近戰致命一擊等級"] = {"MELEE_CRIT_RATING",}, -- [屠殺者腰帶] ID:21639
		["使你的近戰致命一擊等級"] = {"MELEE_CRIT_RATING",},
		["法術致命一擊等級"] = {"SPELL_CRIT_RATING",},
		["提高法術致命一擊等級"] = {"SPELL_CRIT_RATING",}, -- [伊利達瑞的復仇] ID:28040
		["使你的法術致命一擊等級"] = {"SPELL_CRIT_RATING",},
		["使半徑30碼範圍內所有小隊成員的法術致命一擊等級"] = {"SPELL_CRIT_RATING",}, -- Atiesh, ID: 22589
		["遠程致命一擊等級"] = {"RANGED_CRIT_RATING",},
		["提高遠程致命一擊等級"] = {"RANGED_CRIT_RATING",},
		["使你的遠程致命一擊等級"] = {"RANGED_CRIT_RATING",},

		["提高命中迴避率"] = {"MELEE_HIT_AVOID_RATING"}, -- ITEM_MOD_HIT_TAKEN_RATING, Necklace of Trophies ID: 31275 (Patch 2.0.10 changed it to Hit Rating)
		["提高近戰命中迴避率"] = {"MELEE_HIT_AVOID_RATING"}, -- ITEM_MOD_HIT_TAKEN_MELEE_RATING
		["提高遠距命中迴避率"] = {"RANGED_HIT_AVOID_RATING"}, -- ITEM_MOD_HIT_TAKEN_RANGED_RATING
		["提高法術命中迴避率"] = {"SPELL_HIT_AVOID_RATING"}, -- ITEM_MOD_HIT_TAKEN_SPELL_RATING
		["韌性"] = {"RESILIENCE_RATING",},
		["韌性等級"] = {"RESILIENCE_RATING",},
		["使你的韌性等級"] = {"RESILIENCE_RATING",},
		["提高致命一擊等級迴避率"] = {"MELEE_CRIT_AVOID_RATING",},
		["提高近戰致命一擊等級迴避率"] = {"MELEE_CRIT_AVOID_RATING",},
		["提高遠距致命一擊等級迴避率"] = {"RANGED_CRIT_AVOID_RATING",},
		["提高法術致命一擊等級迴避率"] = {"SPELL_CRIT_AVOID_RATING",},

		["加速等級"] = {"MELEE_HASTE_RATING", "SPELL_HASTE_RATING"}, -- Enchant Gloves
		["攻擊速度"] = {"MELEE_HASTE_RATING", "SPELL_HASTE_RATING"},
		["攻擊速度等級"] = {"MELEE_HASTE_RATING", "SPELL_HASTE_RATING"},
		["提高加速等級"] = {"MELEE_HASTE_RATING", "SPELL_HASTE_RATING"},
		["提高近戰加速等級"] = {"MELEE_HASTE_RATING"},
		["法術加速等級"] = {"SPELL_HASTE_RATING"},
		["提高法術加速等級"] = {"SPELL_HASTE_RATING"},
		["遠程攻擊加速等級"] = {"RANGED_HASTE_RATING"},
		["提高遠程攻擊加速等級"] = {"RANGED_HASTE_RATING"},

		["使匕首技能等級"] = {"DAGGER_WEAPON_RATING"},
		["匕首武器技能等級"] = {"DAGGER_WEAPON_RATING"},
		["使劍類技能等級"] = {"SWORD_WEAPON_RATING"},
		["劍類武器技能等級"] = {"SWORD_WEAPON_RATING"},
		["使單手劍技能等級"] = {"SWORD_WEAPON_RATING"},
		["單手劍武器技能等級"] = {"SWORD_WEAPON_RATING"},
		["使雙手劍技能等級"] = {"2H_SWORD_WEAPON_RATING"},
		["雙手劍武器技能等級"] = {"2H_SWORD_WEAPON_RATING"},
		["使斧類技能等級"] = {"AXE_WEAPON_RATING"},
		["斧類武器技能等級"] = {"AXE_WEAPON_RATING"},
		["使單手斧技能等級"] = {"AXE_WEAPON_RATING"},
		["單手斧武器技能等級"] = {"AXE_WEAPON_RATING"},
		["使雙手斧技能等級"] = {"2H_AXE_WEAPON_RATING"},
		["雙手斧武器技能等級"] = {"2H_AXE_WEAPON_RATING"},
		["使錘類技能等級"] = {"MACE_WEAPON_RATING"},
		["錘類武器技能等級"] = {"MACE_WEAPON_RATING"},
		["使單手錘技能等級"] = {"MACE_WEAPON_RATING"},
		["單手錘武器技能等級"] = {"MACE_WEAPON_RATING"},
		["使雙手錘技能等級"] = {"2H_MACE_WEAPON_RATING"},
		["雙手錘武器技能等級"] = {"2H_MACE_WEAPON_RATING"},
		["使槍械技能等級"] = {"GUN_WEAPON_RATING"},
		["槍械武器技能等級"] = {"GUN_WEAPON_RATING"},
		["使弩技能等級"] = {"CROSSBOW_WEAPON_RATING"},
		["弩武器技能等級"] = {"CROSSBOW_WEAPON_RATING"},
		["使弓箭技能等級"] = {"BOW_WEAPON_RATING"},
		["弓箭武器技能等級"] = {"BOW_WEAPON_RATING"},
		["使野性戰鬥技巧等級"] = {"FERAL_WEAPON_RATING"},
		["野性戰鬥技巧等級"] = {"FERAL_WEAPON_RATING"},
		["使拳套技能等級"] = {"FIST_WEAPON_RATING"},
		["拳套武器技能等級"] = {"FIST_WEAPON_RATING"}, -- Demonblood Eviscerator ID:27533

		["使你的熟練等級提高"] = {"EXPERTISE_RATING"},
		["熟練等級"] = {"EXPERTISE_RATING"},
		["護甲穿透等級"] = {"ARMOR_PENETRATION_RATING"},
		["你的護甲穿透等級提高"] = {"ARMOR_PENETRATION_RATING"},

		-- Exclude
		["秒"] = false,
		--["to"] = false,
		["格容器"] = false,
		["格箭袋"] = false,
		["格彈藥袋"] = false,
		["遠程攻擊速度%"] = false, -- AV quiver
	},
}
DisplayLocale.zhTW = {
	----------------
	-- Stat Names --
	----------------
	-- Please localize these strings too, global strings were used in the enUS locale just to have minimum
	-- localization effect when a locale is not available for that language, you don't have to use global
	-- strings in your localization.
  ["Stat Multiplier"] = "總屬性提高%",
  ["Attack Power Multiplier"] = "攻擊強度提高%",
  ["Reduced Physical Damage Taken"] = "物理傷害減少%",
	["StatIDToName"] = {
		--[StatID] = {FullName, ShortName},
		---------------------------------------------------------------------------
		-- Tier1 Stats - Stats parsed directly off items
		["EMPTY_SOCKET_RED"] = {EMPTY_SOCKET_RED, EMPTY_SOCKET_RED}, -- EMPTY_SOCKET_RED = "Red Socket";
		["EMPTY_SOCKET_YELLOW"] = {EMPTY_SOCKET_YELLOW, EMPTY_SOCKET_YELLOW}, -- EMPTY_SOCKET_YELLOW = "Yellow Socket";
		["EMPTY_SOCKET_BLUE"] = {EMPTY_SOCKET_BLUE, EMPTY_SOCKET_BLUE}, -- EMPTY_SOCKET_BLUE = "Blue Socket";
		["EMPTY_SOCKET_META"] = {EMPTY_SOCKET_META, EMPTY_SOCKET_META}, -- EMPTY_SOCKET_META = "Meta Socket";

		["IGNORE_ARMOR"] = {"無視護甲", "無視護甲"},
		["MOD_THREAT"] = {"威脅(%)", "威脅(%)"},
		["STEALTH_LEVEL"] = {"偷竊等級", "偷竊"},
		["MELEE_DMG"] = {"近戰傷害", "近戰"},
		["RANGED_DMG"] = {"遠程傷害", "遠程"},
		["MOUNT_SPEED"] = {"騎乘速度(%)", "騎速(%)"},
		["RUN_SPEED"] = {"奔跑速度(%)", "跑速(%)"},

		["STR"] = {SPELL_STAT1_NAME, "力量"},
		["AGI"] = {SPELL_STAT2_NAME, "敏捷"},
		["STA"] = {SPELL_STAT3_NAME, "耐力"},
		["INT"] = {SPELL_STAT4_NAME, "智力"},
		["SPI"] = {SPELL_STAT5_NAME, "精神"},
		["ARMOR"] = {ARMOR, ARMOR},
		["ARMOR_BONUS"] = {"裝甲加成", "裝甲加成"},

		["FIRE_RES"] = {RESISTANCE2_NAME, "火抗"},
		["NATURE_RES"] = {RESISTANCE3_NAME, "自抗"},
		["FROST_RES"] = {RESISTANCE4_NAME, "冰抗"},
		["SHADOW_RES"] = {RESISTANCE5_NAME, "暗抗"},
		["ARCANE_RES"] = {RESISTANCE6_NAME, "秘抗"},

		["FISHING"] = {"釣魚", "釣魚"},
		["MINING"] = {"採礦", "採礦"},
		["HERBALISM"] = {"草藥", "草藥"},
		["SKINNING"] = {"剝皮", "剝皮"},

		["BLOCK_VALUE"] = {"格擋值", "格擋值"},

		["AP"] = {ATTACK_POWER_TOOLTIP, "攻擊強度"},
		["RANGED_AP"] = {RANGED_ATTACK_POWER, "遠攻強度"},
		["FERAL_AP"] = {"野性攻擊強度", "野性強度"},
		["AP_UNDEAD"] = {"攻擊強度(不死)", "攻擊強度(不死)"},
		["AP_DEMON"] = {"攻擊強度(惡魔)", "攻擊強度(惡魔)"},

		["HEAL"] = {"法術治療", "治療"},

		["SPELL_DMG"] = {"法術傷害", "法傷"},
		["SPELL_DMG_UNDEAD"] = {"法術傷害(不死)", "法傷(不死)"},
		["SPELL_DMG_DEMON"] = {"法術傷害(惡魔)", "法傷(惡魔)"},
		["HOLY_SPELL_DMG"] = {"神聖法術傷害", "神聖法傷"},
		["FIRE_SPELL_DMG"] = {"火焰法術傷害", "火焰法傷"},
		["NATURE_SPELL_DMG"] = {"自然法術傷害", "自然法傷"},
		["FROST_SPELL_DMG"] = {"冰霜法術傷害", "冰霜法傷"},
		["SHADOW_SPELL_DMG"] = {"暗影法術傷害", "暗影法傷"},
		["ARCANE_SPELL_DMG"] = {"秘法法術傷害", "秘法法傷"},

		["SPELLPEN"] = {"法術穿透", SPELL_PENETRATION},

		["HEALTH"] = {HEALTH, HP},
		["MANA"] = {MANA, MP},
		["HEALTH_REG"] = {"生命恢復", "HP5"},
		["MANA_REG"] = {"法力恢復", "MP5"},

		["MAX_DAMAGE"] = {"最大傷害", "大傷"},
		["DPS"] = {"每秒傷害", "DPS"},

		["DEFENSE_RATING"] = {COMBAT_RATING_NAME2, COMBAT_RATING_NAME2}, -- COMBAT_RATING_NAME2 = "Defense Rating"
		["DODGE_RATING"] = {COMBAT_RATING_NAME3, COMBAT_RATING_NAME3}, -- COMBAT_RATING_NAME3 = "Dodge Rating"
		["PARRY_RATING"] = {COMBAT_RATING_NAME4, COMBAT_RATING_NAME4}, -- COMBAT_RATING_NAME4 = "Parry Rating"
		["BLOCK_RATING"] = {COMBAT_RATING_NAME5, COMBAT_RATING_NAME5}, -- COMBAT_RATING_NAME5 = "Block Rating"
		["MELEE_HIT_RATING"] = {COMBAT_RATING_NAME6, COMBAT_RATING_NAME6}, -- COMBAT_RATING_NAME6 = "Hit Rating"
		["RANGED_HIT_RATING"] = {"遠程命中等級", "遠程命中等級"}, -- PLAYERSTAT_RANGED_COMBAT = "Ranged"
		["SPELL_HIT_RATING"] = {"法術命中等級", "法術命中等級"}, -- PLAYERSTAT_SPELL_COMBAT = "Spell"
		["MELEE_HIT_AVOID_RATING"] = {"避免命中等級", "避免命中等級"},
		["RANGED_HIT_AVOID_RATING"] = {"避免遠程命中等級", "避免遠程命中等級"},
		["SPELL_HIT_AVOID_RATING"] = {"避免法術命中等級", "避免法術命中等級"},
		["MELEE_CRIT_RATING"] = {COMBAT_RATING_NAME9, COMBAT_RATING_NAME9}, -- COMBAT_RATING_NAME9 = "Crit Rating"
		["RANGED_CRIT_RATING"] = {"遠程致命等級", "遠程致命等級"},
		["SPELL_CRIT_RATING"] = {"法術致命等級", "法術致命等級"},
		["MELEE_CRIT_AVOID_RATING"] = {"避免致命等級", "避免致命等級"},
		["RANGED_CRIT_AVOID_RATING"] = {"避免遠程致命等級", "避免遠程致命等級"},
		["SPELL_CRIT_AVOID_RATING"] = {"避免法術致命等級", "避免法術致命等級"},
		["RESILIENCE_RATING"] = {COMBAT_RATING_NAME15, COMBAT_RATING_NAME15}, -- COMBAT_RATING_NAME15 = "Resilience"
		["MELEE_HASTE_RATING"] = {"攻擊加速等級", "攻擊加速等級"}, --
		["RANGED_HASTE_RATING"] = {"遠程加速等級", "遠程加速等級"},
		["SPELL_HASTE_RATING"] = {"法術加速等級", "法術加速等級"},
		["DAGGER_WEAPON_RATING"] = {"匕首技能等級", "匕首等級"}, -- SKILL = "Skill"
		["SWORD_WEAPON_RATING"] = {"劍技能等級", "劍等級"},
		["2H_SWORD_WEAPON_RATING"] = {"雙手劍技能等級", "雙手劍等級"},
		["AXE_WEAPON_RATING"] = {"斧技能等級", "斧等級"},
		["2H_AXE_WEAPON_RATING"] = {"雙手斧技能等級", "雙手斧等級"},
		["MACE_WEAPON_RATING"] = {"鎚技能等級", "鎚等級"},
		["2H_MACE_WEAPON_RATING"] = {"雙手鎚技能等級", "雙手鎚等級"},
		["GUN_WEAPON_RATING"] = {"槍械技能等級", "槍械等級"},
		["CROSSBOW_WEAPON_RATING"] = {"弩技能等級", "弩等級"},
		["BOW_WEAPON_RATING"] = {"弓技能等級", "弓等級"},
		["FERAL_WEAPON_RATING"] = {"野性技能等級", "野性等級"},
		["FIST_WEAPON_RATING"] = {"徒手技能等級", "徒手等級"},
		["STAFF_WEAPON_RATING"] = {"法杖技能等級", "法杖等級"}, -- Leggings of the Fang ID:10410
		--["EXPERTISE_RATING"] = {STAT_EXPERTISE.." "..RATING, STAT_EXPERTISE.." "..RATING},
		["EXPERTISE_RATING"] = {"熟練等級", "熟練等級"},
		["ARMOR_PENETRATION_RATING"] = {"護甲穿透等級", "護甲穿透等級"},

		---------------------------------------------------------------------------
		-- Tier2 Stats - Stats that only show up when broken down from a Tier1 stat
		-- Str -> AP, Block Value
		-- Agi -> AP, Crit, Dodge
		-- Sta -> Health
		-- Int -> Mana, Spell Crit
		-- Spi -> mp5nc, hp5oc
		-- Ratings -> Effect
		["HEALTH_REG_OUT_OF_COMBAT"] = {"一般回血", "一般回血"},
		["MANA_REG_NOT_CASTING"] = {"一般回魔", "一般回魔"},
		["MELEE_CRIT_DMG_REDUCTION"] = {"致命減傷(%)", "致命減傷(%)"},
		["RANGED_CRIT_DMG_REDUCTION"] = {"遠程致命減傷(%)", "遠程致命減傷(%)"},
		["SPELL_CRIT_DMG_REDUCTION"] = {"法術致命減傷(%)", "法術致命減傷(%)"},
		["DEFENSE"] = {DEFENSE, DEFENSE},
		["DODGE"] = {DODGE.."(%)", DODGE.."(%)"},
		["PARRY"] = {PARRY.."(%)", PARRY.."(%)"},
		["BLOCK"] = {BLOCK.."(%)", BLOCK.."(%)"},
		["MELEE_HIT"] = {"命中(%)", "命中(%)"},
		["RANGED_HIT"] = {"遠程命中(%)", "遠程命中(%)"},
		["SPELL_HIT"] = {"法術命中(%)", "法術命中(%)"},
		["MELEE_HIT_AVOID"] = {"迴避命中(%)", "迴避命中(%)"},
		["RANGED_HIT_AVOID"] = {"迴避遠程命中(%)", "迴避遠程命中(%)"},
		["SPELL_HIT_AVOID"] = {"迴避法術命中(%)", "迴避法術命中(%)"},
		["MELEE_CRIT"] = {"致命(%)", "致命(%)"}, -- MELEE_CRIT_CHANCE = "Crit Chance"
		["RANGED_CRIT"] = {"遠程致命(%)", "遠程致命(%)"},
		["SPELL_CRIT"] = {"法術致命(%)", "法術致命(%)"},
		["MELEE_CRIT_AVOID"] = {"迴避致命(%)", "迴避致命(%)"},
		["RANGED_CRIT_AVOID"] = {"迴避遠程致命(%)", "迴避遠程致命(%)"},
		["SPELL_CRIT_AVOID"] = {"迴避法術致命(%)", "迴避法術致命(%)"},
		["MELEE_HASTE"] = {"攻擊加速(%)", "攻擊加速(%)"}, --
		["RANGED_HASTE"] = {"遠程加速(%)", "遠程加速(%)"},
		["SPELL_HASTE"] = {"法術加速(%)", "法術加速(%)"},
		["DAGGER_WEAPON"] = {"匕首技能", "匕首"}, -- SKILL = "Skill"
		["SWORD_WEAPON"] = {"劍技能", "劍"},
		["2H_SWORD_WEAPON"] = {"雙手劍技能", "雙手劍"},
		["AXE_WEAPON"] = {"斧技能", "斧"},
		["2H_AXE_WEAPON"] = {"雙手斧技能", "雙手斧"},
		["MACE_WEAPON"] = {"鎚技能", "鎚"},
		["2H_MACE_WEAPON"] = {"雙手鎚技能", "雙手鎚"},
		["GUN_WEAPON"] = {"槍械技能", "槍械"},
		["CROSSBOW_WEAPON"] = {"弩技能", "弩"},
		["BOW_WEAPON"] = {"弓技能", "弓"},
		["FERAL_WEAPON"] = {"野性技能", "野性"},
		["FIST_WEAPON"] = {"徒手技能", "徒手"},
		["STAFF_WEAPON"] = {"法杖技能", "法杖"}, -- Leggings of the Fang ID:10410
		--["EXPERTISE"] = {STAT_EXPERTISE, STAT_EXPERTISE},
		["EXPERTISE"] = {"熟練", "熟練"},
		["ARMOR_PENETRATION"] = {"護甲穿透(%)", "護甲穿透(%)"},

		---------------------------------------------------------------------------
		-- Tier3 Stats - Stats that only show up when broken down from a Tier2 stat
		-- Defense -> Crit Avoidance, Hit Avoidance, Dodge, Parry, Block
		-- Weapon Skill -> Crit, Hit, Dodge Neglect, Parry Neglect, Block Neglect
		-- Expertise -> Dodge Neglect, Parry Neglect
		["DODGE_NEGLECT"] = {"防止被閃躲(%)", "防止被閃躲(%)"},
		["PARRY_NEGLECT"] = {"防止被招架(%)", "防止被招架(%)"},
		["BLOCK_NEGLECT"] = {"防止被格擋(%)", "防止被格擋(%)"},

		---------------------------------------------------------------------------
		-- Talents
		["MELEE_CRIT_DMG"] = {"致命一擊(%)", "致命(%)"},
		["RANGED_CRIT_DMG"] = {"遠程致命一擊(%)", "遠程致命(%)"},
		["SPELL_CRIT_DMG"] = {"法術致命一擊(%)", "法術致命(%)"},

		---------------------------------------------------------------------------
		-- Spell Stats
		-- These values can be prefixed with a @ and spell name, using reverse translation to english from Babble-Spell-2.2
		-- ex: "Heroic Strike@RAGE_COST" for Heroic Strike rage cost
		-- ex: "Heroic Strike@THREAT" for Heroic Strike threat value
		-- Use strsplit("@", text) to seperate the spell name and statid
		["THREAT"] = {"威脅", "威脅"},
		["CAST_TIME"] = {"施法時間", "施法時間"},
		["MANA_COST"] = {"法力成本", "法力成本"},
		["RAGE_COST"] = {"怒氣成本", "怒氣成本"},
		["ENERGY_COST"] = {"能量成本", "能量成本"},
		["COOLDOWN"] = {"技能冷卻", "技能冷卻"},

		---------------------------------------------------------------------------
		-- Stats Mods
		["MOD_STR"] = {"修正力量(%)", "修正力量(%)"},
		["MOD_AGI"] = {"修正敏捷(%)", "修正敏捷(%)"},
		["MOD_STA"] = {"修正耐力(%)", "修正耐力(%)"},
		["MOD_INT"] = {"修正智力(%)", "修正智力(%)"},
		["MOD_SPI"] = {"修正精神(%)", "修正精神(%)"},
		["MOD_HEALTH"] = {"修正生命(%)", "修正生命(%)"},
		["MOD_MANA"] = {"修正法力(%)", "修正法力(%)"},
		["MOD_ARMOR"] = {"修正裝甲(%)", "修正裝甲(%)"},
		["MOD_BLOCK_VALUE"] = {"修正格擋值(%)", "修正格擋值(%)"},
		["MOD_DMG"] = {"修正傷害(%)", "修正傷害(%)"},
		["MOD_DMG_TAKEN"] = {"修正受傷害(%)", "修正受傷害(%)"},
		["MOD_CRIT_DAMAGE"] = {"修正致命(%)", "修正致命(%)"},
		["MOD_CRIT_DAMAGE_TAKEN"] = {"修正受致命(%)", "修正受致命(%)"},
		["MOD_THREAT"] = {"修正威脅(%)", "修正威脅(%)"},
		["MOD_AP"] = {"修正攻擊強度(%)", "修正攻擊強度(%)"},
		["MOD_RANGED_AP"] = {"修正遠程攻擊強度(%)", "修正遠攻強度(%)"},
		["MOD_SPELL_DMG"] = {"修正法術傷害(%)", "修正法傷(%)"},
		["MOD_HEALING"] = {"修正法術治療(%)", "修正治療(%)"},
		["MOD_CAST_TIME"] = {"修正施法時間(%)", "修正施法時間(%)"},
		["MOD_MANA_COST"] = {"修正法力成本(%)", "修正法力成本(%)"},
		["MOD_RAGE_COST"] = {"修正怒氣成本(%)", "修正怒氣成本(%)"},
		["MOD_ENERGY_COST"] = {"修正能量成本(%)", "修正能量成本(%)"},
		["MOD_COOLDOWN"] = {"修正技能冷卻(%)", "修正技能冷卻(%)"},

		---------------------------------------------------------------------------
		-- Misc Stats
		["WEAPON_RATING"] = {"武器技能等級", "武器技能等級"},
		["WEAPON_SKILL"] = {"武器技能", "武器技能"},
		["MAINHAND_WEAPON_RATING"] = {"主手武器技能等級", "主手武器技能等級"},
		["OFFHAND_WEAPON_RATING"] = {"副手武器技能等級", "副手武器技能等級"},
		["RANGED_WEAPON_RATING"] = {"遠程武器技能等級", "遠程武器技能等級"},
	},
}

-- deDE localization by Gailly, Dleh
PatternLocale.deDE = {
	["tonumber"] = function(s)
		local n = tonumber(s)
		if n then
			return n
		else
			return tonumber((gsub(s, ",", "%.")))
		end
	end,
	-----------------
	-- Armor Types --
	-----------------
	Plate = "Platte",
	Mail = "Schwere Rüstung",
	Leather = "Leder",
	Cloth = "Stoff",
	-------------------
	-- Fast Exclude --
	-------------------
	-- By looking at the first ExcludeLen letters of a line we can exclude a lot of lines
	["ExcludeLen"] = 5, -- using string.utf8len
	["Exclude"] = {
		[""] = true,
		[" \n"] = true,
		[ITEM_BIND_ON_EQUIP] = true, -- ITEM_BIND_ON_EQUIP = "Binds when equipped"; -- Item will be bound when equipped
		[ITEM_BIND_ON_PICKUP] = true, -- ITEM_BIND_ON_PICKUP = "Binds when picked up"; -- Item wil be bound when picked up
		[ITEM_BIND_ON_USE] = true, -- ITEM_BIND_ON_USE = "Binds when used"; -- Item will be bound when used
		[ITEM_BIND_QUEST] = true, -- ITEM_BIND_QUEST = "Quest Item"; -- Item is a quest item (same logic as ON_PICKUP)
		[ITEM_SOULBOUND] = true, -- ITEM_SOULBOUND = "Soulbound"; -- Item is Soulbound
		[ITEM_STARTS_QUEST] = true, -- ITEM_STARTS_QUEST = "This Item Begins a Quest"; -- Item is a quest giver
		[ITEM_CANT_BE_DESTROYED] = true, -- ITEM_CANT_BE_DESTROYED = "That item cannot be destroyed."; -- Attempted to destroy a NO_DESTROY item
		[ITEM_CONJURED] = true, -- ITEM_CONJURED = "Conjured Item"; -- Item expires
		[ITEM_DISENCHANT_NOT_DISENCHANTABLE] = true, -- ITEM_DISENCHANT_NOT_DISENCHANTABLE = "Cannot be disenchanted"; -- Items which cannot be disenchanted ever
		["Entza"] = true, -- ITEM_DISENCHANT_ANY_SKILL = "Disenchantable"; -- Items that can be disenchanted at any skill level
		-- ITEM_DISENCHANT_MIN_SKILL = "Disenchanting requires %s (%d)"; -- Minimum enchanting skill needed to disenchant
		["Dauer"] = true, -- ITEM_DURATION_DAYS = "Duration: %d days";
		["<Herg"] = true, -- ITEM_CREATED_BY = "|cff00ff00<Made by %s>|r"; -- %s is the creator of the item
		["Verbl"] = true, -- ITEM_COOLDOWN_TIME_DAYS = "Cooldown remaining: %d day";
		["Einzi"] = true, -- Unique (20) -- ITEM_UNIQUE = "Unique"; -- Item is unique
		["Limit"] = true, -- ITEM_UNIQUE_MULTIPLE = "Unique (%d)"; -- Item is unique
		["Benöt"] = true, -- Requires Level xx -- ITEM_MIN_LEVEL = "Requires Level %d"; -- Required level to use the item
		["\nBenö"] = true, -- Requires Level xx -- ITEM_MIN_SKILL = "Requires %s (%d)"; -- Required skill rank to use the item
		["Klass"] = true, -- Classes: xx -- ITEM_CLASSES_ALLOWED = "Classes: %s"; -- Lists the classes allowed to use this item
		["Völke"] = true, -- Races: xx (vendor mounts) -- ITEM_RACES_ALLOWED = "Races: %s"; -- Lists the races allowed to use this item
		["Benut"] = true, -- Use: -- ITEM_SPELL_TRIGGER_ONUSE = "Use:";
		["Treff"] = true, -- Chance On Hit: -- ITEM_SPELL_TRIGGER_ONPROC = "Chance on hit:";
		-- Set Bonuses
		-- ITEM_SET_BONUS = "Set: %s";
		-- ITEM_SET_BONUS_GRAY = "(%d) Set: %s";
		-- ITEM_SET_NAME = "%s (%d/%d)"; -- Set name (2/5)
		["Set: "] = true,
		["(2) S"] = true,
		["(3) S"] = true,
		["(4) S"] = true,
		["(5) S"] = true,
		["(6) S"] = true,
		["(7) S"] = true,
		["(8) S"] = true,
		-- Equip type
		["Projektil"] = true, -- Ice Threaded Arrow ID:19316
		[INVTYPE_AMMO] = true,
		[INVTYPE_HEAD] = true,
		[INVTYPE_NECK] = true,
		[INVTYPE_SHOULDER] = true,
		[INVTYPE_BODY] = true,
		[INVTYPE_CHEST] = true,
		[INVTYPE_ROBE] = true,
		[INVTYPE_WAIST] = true,
		[INVTYPE_LEGS] = true,
		[INVTYPE_FEET] = true,
		[INVTYPE_WRIST] = true,
		[INVTYPE_HAND] = true,
		[INVTYPE_FINGER] = true,
		[INVTYPE_TRINKET] = true,
		[INVTYPE_CLOAK] = true,
		[INVTYPE_WEAPON] = true,
		[INVTYPE_SHIELD] = true,
		[INVTYPE_2HWEAPON] = true,
		[INVTYPE_WEAPONMAINHAND] = true,
		[INVTYPE_WEAPONOFFHAND] = true,
		[INVTYPE_HOLDABLE] = true,
		[INVTYPE_RANGED] = true,
		[INVTYPE_THROWN] = true,
		[INVTYPE_RANGEDRIGHT] = true,
		[INVTYPE_RELIC] = true,
		[INVTYPE_TABARD] = true,
		[INVTYPE_BAG] = true,
	},
	-----------------------
	-- Whole Text Lookup --
	-----------------------
	-- Mainly used for enchants that doesn't have numbers in the text
	["WholeTextLookup"] = {
		[EMPTY_SOCKET_RED] = {["EMPTY_SOCKET_RED"] = 1}, -- EMPTY_SOCKET_RED = "Red Socket";
		[EMPTY_SOCKET_YELLOW] = {["EMPTY_SOCKET_YELLOW"] = 1}, -- EMPTY_SOCKET_YELLOW = "Yellow Socket";
		[EMPTY_SOCKET_BLUE] = {["EMPTY_SOCKET_BLUE"] = 1}, -- EMPTY_SOCKET_BLUE = "Blue Socket";
		[EMPTY_SOCKET_META] = {["EMPTY_SOCKET_META"] = 1}, -- EMPTY_SOCKET_META = "Meta Socket";

		["Wildheit"] = {["AP"] = 70}, --
		["Unbändigkeit"] = {["AP"] = 70}, --

		["Schwaches Zauberöl"] = {["SPELL_DMG"] = 8, ["HEAL"] = 8}, --
		["Geringes Zauberöl"] = {["SPELL_DMG"] = 16, ["HEAL"] = 16}, --
		["Zauberöl"] = {["SPELL_DMG"] = 24, ["HEAL"] = 24}, --
		["Überragendes Zauberöl"] = {["SPELL_DMG"] = 42, ["HEAL"] = 42}, --
		["Hervorragendes Zauberöl"] = {["SPELL_DMG"] = 36, ["HEAL"] = 36, ["SPELL_CRIT_RATING"] = 14}, --
		["Gesegnetes Zauberöl"] = {["SPELL_DMG_UNDEAD"] = 60}, -- ID: 23123

		["Schwaches Manaöl"] = {["MANA_REG"] = 4}, --
		["Geringes Manaöl"] = {["MANA_REG"] = 8}, --
		["Überragendes Manaöl"] = {["MANA_REG"] = 14}, --
		["Hervorragendes Manaöl"] = {["MANA_REG"] = 12, ["HEAL"] = 25}, --

		["Eterniumangelschnur"] = {["FISHING"] = 5}, --
		["Vitalität"] = {["MANA_REG"] = 4, ["HEALTH_REG"] = 4}, --
		["Seelenfrost"] = {["SHADOW_SPELL_DMG"] = 54, ["FROST_SPELL_DMG"] = 54}, --
		["Sonnenfeuer"] = {["ARCANE_SPELL_DMG"] = 50, ["FIRE_SPELL_DMG"] = 50}, --

		["Mithrilsporen"] = {["MOUNT_SPEED"] = 4}, -- Mithril Spurs
		["Schwache Reittierttempo-Strigerung"] = {["MOUNT_SPEED"] = 2}, -- Enchant Gloves - Riding Skill
		["Anlegen: Lauftempo ein wenig erhöht."] = {["RUN_SPEED"] = 8}, -- [Highlander's Plate Greaves] ID: 20048
		["Lauftempo ein wenig erhöht"] = {["RUN_SPEED"] = 8}, --
		["Schwache Temposteigerung"] = {["RUN_SPEED"] = 8}, -- Enchant Boots - Minor Speed
		["Schwaches Tempo"] = {["RUN_SPEED"] = 8}, -- Enchant Boots - Cat's Swiftness "Minor Speed and +6 Agility" http://wow.allakhazam.com/db/spell.html?wspell=34007
		["Sicherer Stand"] = {["MELEE_HIT_RATING"] = 10}, -- Enchant Boots - Surefooted "Surefooted" http://wow.allakhazam.com/db/spell.html?wspell=27954

		["Feingefühl"] = {["MOD_THREAT"] = -2}, -- Enchant Cloak - Subtlety
		["2% verringerte Bedrohung"] = {["MOD_THREAT"] = -2}, -- StatLogic:GetSum("item:23344:2832")
		["Anlegen: Ermöglicht Unterwasseratmung."] = false, -- [Band of Icy Depths] ID: 21526
		["Ermöglicht Unterwasseratmung"] = false, --
		["Anlegen: Immun gegen Entwaffnen."] = false, -- [Stronghold Gauntlets] ID: 12639
		["Immun gegen Entwaffnen"] = false, --
		["Kreuzfahrer"] = false, -- Enchant Crusader
		["Lebensdiebstahl"] = false, -- Enchant Crusader

		["Vitalität der Tuskarr"] = {["RUN_SPEED"] = 8, ["STA"] = 15}, -- EnchantID: 3232
		["Weisheit"] = {["MOD_THREAT"] = -2, ["SPI"] = 10}, -- EnchantID: 3296
		["Präzision"] = {["MELEE_HIT_RATING"] = 25, ["SPELL_HIT_RATING"] = 25, ["MELEE_CRIT_RATING"] = 25, ["SPELL_CRIT_RATING"] = 25}, -- EnchantID: 3788
		["Geißelbann"] = {["AP_UNDEAD"] = 140}, -- EnchantID: 3247
		["Eiswandler"] = {["MELEE_HIT_RATING"] = 12, ["SPELL_HIT_RATING"] = 12, ["MELEE_CRIT_RATING"] = 12, ["SPELL_CRIT_RATING"] = 12}, -- EnchantID: 3826
		["Sammler"] = {["HERBALISM"] = 5, ["MINING"] = 5, ["SKINNING"] = 5}, -- EnchantID: 3296
		["Große Vitalität"] = {["MANA_REG"] = 6, ["HEALTH_REG"] = 6}, -- EnchantID: 3244
		
		["+37 Ausdauer und +20 Verteidigung"] = {["STA"] = 37, ["DEFENSE_RATING"] = 20}, -- Defense does not equal Defense Rating...
		["Rune des Schwertbrechens"] = {["PARRY"] = 2}, -- EnchantID: 3594
		["Rune des Schwertberstens"] = {["PARRY"] = 4}, -- EnchantID: 3365
		["Rune des Steinhautgargoyles"] = {["DEFENSE"] = 25, ["MOD_STA"] = 2}, -- EnchantID: 3847
		["Rune der nerubischen Panzerung"] = {["DEFENSE"] = 13, ["MOD_STA"] = 1}, -- EnchantID: 3883
	},
	----------------------------
	-- Single Plus Stat Check --
	----------------------------
	-- depending on locale, it may be
	-- +19 Stamina = "^%+(%d+) ([%a ]+%a)$"
	-- Stamina +19 = "^([%a ]+%a) %+(%d+)$"
	-- +19 ?? = "^%+(%d+) (.-)$"
	--["SinglePlusStatCheck"] = "^%+(%d+) ([%a ]+%a)$",
	["SinglePlusStatCheck"] = "^%+(%d+) (.-)$",
	-- depending on locale, it may be
	-- +19 Stamina = "^%+(%d+) (.-)%.?$"
	-- Stamina +19 = "^(.-) %+(%d+)%.?$"
	-- +19 耐力 = "^%+(%d+) (.-)%.?$"
	-- +19 Ausdauer = "^%+(%d+) (.-)%.?$" (deDE :))
	-- Some have a "." at the end of string like:
	-- Enchant Chest - Restore Mana Prime "+6 mana every 5 sec. "
	["SinglePlusStatCheck"] = "^([%+%-]%d+) (.-)%.?$",
	-----------------------------
	-- Single Equip Stat Check --
	-----------------------------
	-- stat1, value, stat2 = strfind
	-- stat = stat1..stat2
	-- "^Equip: (.-) by u?p? ?t?o? ?(%d+) ?(.-)%.$"
	["SingleEquipStatCheck"] = "^Anlegen: (.-) um b?i?s? ?z?u? ?(%d+) ?(.-)%.$",
	-------------
	-- PreScan --
	-------------
	-- Special cases that need to be dealt with before base scan
	["PreScanPatterns"] = {
		--["^Equip: Increases attack power by (%d+) in Cat"] = "FERAL_AP",
		--["^Equip: Increases attack power by (%d+) when fighting Undead"] = "AP_UNDEAD", -- Seal of the Dawn ID:13029
		["^Erhöht die Angriffskraft um (%d+) nur in Katzen%-, Bären%-, Terrorbären%- und Mondkingestalt%.$"] = "FERAL_AP", -- 3.0.8 FAP change
		["^(%d+) Block$"] = "BLOCK_VALUE",
		["^(%d+) Rüstung$"] = "ARMOR",
		["Verstärkte %(%+(%d+) Rüstung%)"] = "ARMOR_BUFF",
		["Mana Regeneration (%d+) alle 5 Sek%.$"] = "MANA_REG",
		["^%+?%d+ %- (%d+) .-[Ss]chaden$"] = "MAX_DAMAGE",
		["^%(([%d%,]+) Schaden pro Sekunde%)$"] = "DPS",
		-- Exclude
		["^(%d+) Platz"] = false, -- Bags
		["^.+%((%d+)/%d+%)$"] = false, -- Set Name (0/9)
		["|cff808080"] = false, -- Gray text "  |cff808080Requires at least 2 Yellow gems|r\n  |cff808080Requires at least 1 Red gem|r"
		-- Procs
		["[Cc]hance"] = false, -- [Mark of Defiance] ID:27924 -- [Staff of the Qiraji Prophets] ID:21128
		["[Ee]s besteht eine Chance"] = false, -- [Darkmoon Card: Heroism] ID:19287
		["[Ff]ügt dem Angreifer"] = false, -- [Essence of the Pure Flame] ID: 18815
	},
	--------------
	-- DeepScan --
	--------------
	-- Strip leading "Equip: ", "Socket Bonus: "
	["Equip: "] = "Anlegen: ", -- ITEM_SPELL_TRIGGER_ONEQUIP = "Equip:";
	["Socket Bonus: "] = "Sockelbonus: ", -- ITEM_SOCKET_BONUS = "Socket Bonus: %s"; -- Tooltip tag for socketed item matched socket bonuses
	-- Strip trailing "."
	["."] = ".",
	["DeepScanSeparators"] = {
		"/", -- "+10 Defense Rating/+10 Stamina/+15 Block Value": ZG Enchant
		" & ", -- "+26 Healing Spells & 2% Reduced Threat": Bracing Earthstorm Diamond ID:25897
		", ", -- "+6 Spell Damage, +5 Spell Crit Rating": Potent Ornate Topaz ID: 28123
		"([^S][^e][^k])%. ",  -- "Equip: Increases attack power by 81 when fighting Undead. It also allows the acquisition of Scourgestones on behalf of the Argent Dawn.": Seal of the Dawn
								-- Importent for deDE to not separate "alle 5 Sek. 2 Mana"
	},
	["DeepScanWordSeparators"] = {
		" und ", -- "Critical Rating +6 and Dodge Rating +5": Assassin's Fire Opal ID:30565
	},
	["DualStatPatterns"] = { -- all lower case
		["^%+(%d+) heilzauber %+(%d+) schadenszauber$"] = {{"HEAL",}, {"SPELL_DMG",},},
		["^%+(%d+) heilung %+(%d+) zauberschaden$"] = {{"HEAL",}, {"SPELL_DMG",},},
		["^erhöht durch sämtliche zauber und magische effekte verursachte heilung um bis zu (%d+) und den verursachten schaden um bis zu (%d+)$"] = {{"HEAL",}, {"SPELL_DMG",},},
	},
	["DeepScanPatterns"] = {
		"^(.-) um b?i?s? ?z?u? ?(%d+) ?(.-)$", -- "xxx by up to 22 xxx" (scan first)
		"^(.-)5 [Ss]ek%. (%d+) (.-)$",  -- "xxx 5 Sek. 8 xxx" (scan 2nd)
		"^(.-) ?([%+%-]%d+) ?(.-)$", -- "xxx xxx +22" or "+22 xxx xxx" or "xxx +22 xxx" (scan 3rd)
		"^(.-) ?([%d%,]+) ?(.-)$", -- 22.22 xxx xxx (scan last)
	},
	-----------------------
	-- Stat Lookup Table --
	-----------------------
	["StatIDLookup"] = {
		["Eure Angriffe ignorierenRüstung eures Gegners"] = {"IGNORE_ARMOR"}, -- StatLogic:GetSum("item:33733")
		["% Bedrohung"] = {"MOD_THREAT"}, -- StatLogic:GetSum("item:23344:2613")
		["Erhöht Eure effektive Verstohlenheitsstufe"] = {"STEALTH_LEVEL"}, -- [Nightscape Boots] ID: 8197
		["Waffenschaden"] = {"MELEE_DMG"}, -- Enchant
		["Erhöht das Reittiertempo%"] = {"MOUNT_SPEED"}, -- [Highlander's Plate Greaves] ID: 20048

		["Alle Werte"] = {"STR", "AGI", "STA", "INT", "SPI",},
		["Stärke"] = {"STR",},
		["Beweglichkeit"] = {"AGI",},
		["Ausdauer"] = {"STA",},
		["Intelligenz"] = {"INT",},
		["Willenskraft"] = {"SPI",},

		["Arkanwiderstand"] = {"ARCANE_RES",},
		["Feuerwiderstand"] = {"FIRE_RES",},
		["Naturwiderstand"] = {"NATURE_RES",},
		["Frostwiderstand"] = {"FROST_RES",},
		["Schattenwiderstand"] = {"SHADOW_RES",}, -- Demons Blood ID: 10779
		["Alle Widerstände"] = {"ARCANE_RES", "FIRE_RES", "FROST_RES", "NATURE_RES", "SHADOW_RES",},
		["Alle Widerstandsarten"] = {"ARCANE_RES", "FIRE_RES", "FROST_RES", "NATURE_RES", "SHADOW_RES",},

		["Angeln"] = {"FISHING",}, -- Fishing enchant ID:846
		["Angelfertigkeit"] = {"FISHING",}, -- Fishing lure
		["Bergbau"] = {"MINING",}, -- Mining enchant ID:844
		["Kräuterkunde"] = {"HERBALISM",}, -- Heabalism enchant ID:845
		["Kürschnerei"] = {"SKINNING",}, -- Skinning enchant ID:865

		["Rüstung"] = {"ARMOR_BONUS",},
		["Verteidigung"] = {"DEFENSE",},
		["Erhöht die Verteidigungswertung"] = {"DEFENSE",},
		["Blocken"] = {"BLOCK_VALUE",}, -- +22 Block Value
		["Blockwert"] = {"BLOCK_VALUE",}, -- +22 Block Value
		["Erhöht den Blockwert Eures Schildes"] = {"BLOCK_VALUE",},
		["Erhöht den Blockwert Eures Schilds"] = {"BLOCK_VALUE",},

		["Gesundheit"] = {"HEALTH",},
		["HP"] = {"HEALTH",},
		["Mana"] = {"MANA",},

		["Angriffskraft"] = {"AP",},
		["Erhöht Angriffskraft"] = {"AP",},
		["Erhöht die Angriffskraft"] = {"AP",},
		["Erhöht die Angriffskraft im Kampf gegen Untote"] = {"AP_UNDEAD",}, -- [Wristwraps of Undead Slaying] ID:23093
		["Erhöht die Angriffskraft gegen Untote"] = {"AP_UNDEAD",}, -- [Seal of the Dawn] ID:13209
		["Erhöht die Angriffskraft im Kampf gegen Untote. Ermöglicht das Einsammeln von Geißelsteinen im Namen der Argentumdämmerung"] = {"AP_UNDEAD",}, -- [Seal of the Dawn] ID:13209
		["Erhöht die Angriffskraft im Kampf gegen Dämonen"] = {"AP_DEMON",}, -- [Mark of the Champion] ID:23206
		["Angriffskraft in Katzengestalt, Bärengestalt oder Terrorbärengestalt"] = {"FERAL_AP",},
		["Erhöht die Angriffskraft in Katzengestalt, Bärengestalt, Terrorbärengestalt oder Mondkingestalt"] = {"FERAL_AP",},
		["Distanzangriffskraft"] = {"RANGED_AP",},
		["Erhöht die Distanzangriffskraft"] = {"RANGED_AP",}, -- [High Warlord's Crossbow] ID: 18837

		["Gesundheit wieder her"] = {"HEALTH_REG",}, -- Frostwolf Insignia Rank 6 ID:17909
		["Gesundheitsregeneration"] = {"HEALTH_REG",}, -- Demons Blood ID: 10779
		["stellt alle gesundheit wieder her"] = {"HEALTH_REG",}, -- Shard of the Flame ID: 17082


		["Mana wieder her"] = {"MANA_REG",},
		["Mana alle 5 Sek"] = {"MANA_REG",}, -- [Royal Nightseye] ID: 24057
		["Mana alle 5 Sekunden"] = {"MANA_REG",},
		["alle 5 Sek.Mana"] = {"MANA_REG",}, -- [Royal Shadow Draenite] ID: 23109
		["Mana bei allen Gruppenmitgliedern, die sich im Umkreis von 30 befinden, wieder her"] = {"MANA_REG",}, -- Atiesh
		["Manaregeneration"] = {"MANA_REG",},
		["alle Mana"] = {"MANA_REG",},
		["stellt alle Mana wieder her"] = {"MANA_REG",},

		["Zauberdurchschlagskraft"] = {"SPELLPEN",},
		["Erhöht Eure Zauberdurchschlagskraft"] = {"SPELLPEN",},
		["Schaden und Heilung"] = {"SPELL_DMG", "HEAL",},
		["Damage and Healing Spells"] = {"SPELL_DMG", "HEAL",},
		["Zauberschaden und Heilung"] = {"SPELL_DMG", "HEAL",},
		["Zauberschaden"] = {"SPELL_DMG", "HEAL",},
		["Zauberkraft"] = {"SPELL_DMG", "HEAL",},
		["Erhöht durch Zauber und magische Effekte verursachten Schaden und Heilung"] = {"SPELL_DMG", "HEAL"},
		["Erhöht durch Zauber und magische Effekte zugefügten Schaden und Heilung aller Gruppenmitglieder, die sich im Umkreis von 30 befinden,"] = {"SPELL_DMG", "HEAL"}, -- Atiesh
		["Zauberschaden und Heilung"] = {"SPELL_DMG", "HEAL",}, --StatLogic:GetSum("item:22630")
		["Schaden"] = {"SPELL_DMG",},
		["Erhöht Euren Zauberschaden"] = {"SPELL_DMG",}, -- Atiesh ID:22630, 22631, 22632, 22589
		["Zauberschaden"] = {"SPELL_DMG",},
		["Zaubermacht"] = {"SPELL_DMG", "HEAL",},
		["Erhöht die Zaubermacht"] = {"SPELL_DMG", "HEAL",}, -- WotLK
		["Erhöht Zaubermacht"] = {"SPELL_DMG", "HEAL",}, -- WotLK
		["Erhöht Zaubermacht um"] = {"SPELL_DMG", "HEAL",},
		["Erhöht die Zaubermacht um"] = {"SPELL_DMG", "HEAL",},
		["Schadenszauber"] = {"SPELL_DMG"},
		["Heiligschaden"] = {"HOLY_SPELL_DMG",},
		["Arkanschaden"] = {"ARCANE_SPELL_DMG",},
		["Feuerschaden"] = {"FIRE_SPELL_DMG",},
		["Naturschaden"] = {"NATURE_SPELL_DMG",},
		["Frostschaden"] = {"FROST_SPELL_DMG",},
		["Schattenschaden"] = {"SHADOW_SPELL_DMG",},
		["Heiligzauberschaden"] = {"HOLY_SPELL_DMG",},
		["Arkanzauberschaden"] = {"ARCANE_SPELL_DMG",},
		["Feuerzauberschaden"] = {"FIRE_SPELL_DMG",},
		["Naturzauberschaden"] = {"NATURE_SPELL_DMG",},
		["Frostzauberschaden"] = {"FROST_SPELL_DMG",}, -- Acrobatic Staff of Frozen Wrath ID:3185:0:0:0:0:0:1957
		["Schattenzauberschaden"] = {"SHADOW_SPELL_DMG",},
		["Erhöht durch Arkanzauber und Arkaneffekte zugefügten Schaden"] = {"ARCANE_SPELL_DMG",},
		["Erhöht durch Feuerzauber und Feuereffekte zugefügten Schaden"] = {"FIRE_SPELL_DMG",},
		["Erhöht durch Frostzauber und Frosteffekte zugefügten Schaden"] = {"FROST_SPELL_DMG",}, -- Frozen Shadoweave Vest ID:21871
		["Erhöht durch Heiligzauber und Heiligeffekte zugefügten Schaden"] = {"HOLY_SPELL_DMG",},
		["Erhöht durch Naturzauber und Natureffekte zugefügten Schaden"] = {"NATURE_SPELL_DMG",},
		["Erhöht durch Schattenzauber und Schatteneffekte zugefügten Schaden"] = {"SHADOW_SPELL_DMG",}, -- Frozen Shadoweave Vest ID:21871

		["Erhöht den durch Zauber und magische Effekte zugefügten Schaden gegen Untote"] = {"SPELL_DMG_UNDEAD"}, -- [Robe of Undead Cleansing] ID:23085
		["Erhöht den durch Zauber und magische Effekte zugefügten Schaden gegen Untote um bis zu 48. Ermöglicht das Einsammeln von Geißelsteinen im Namen der Argentumdämmerung."] = {"SPELL_DMG_UNDEAD"}, -- [Rune of the Dawn] ID:19812
		["Erhöht den durch Zauber und magische Effekte zugefügten Schaden gegen Untote und Dämonen"] = {"SPELL_DMG_UNDEAD", "SPELL_DMG_DEMON"}, -- [Mark of the Champion] ID:23207

		["Erhöht Heilung"] = {"HEAL",},
		["Heilung"] = {"HEAL",},
		["Heilzauber"] = {"HEAL",}, -- [Royal Nightseye] ID: 24057

		["Erhöht durch Zauber und Effekte verursachte Heilung"] = {"HEAL",},
		["Erhöht durch Zauber und magische Effekte zugefügte Heilung aller Gruppenmitglieder, die sich im Umkreis von 30 befinden,"] = {"HEAL",}, -- Atiesh
		--					["your healing"] = {"HEAL",}, -- Atiesh

		["Schaden pro Sekunde"] = {"DPS",},
		["zusätzlichen Schaden pro Sekunde"] = {"DPS",}, -- [Thorium Shells] ID: 15997 "Verursacht 17.5 zusätzlichen Schaden pro Sekunde."
		["Verursacht zusätzlichen Schaden pro Sekunde"] = {"DPS",}, -- [Thorium Shells] ID: 15997

		["Verteidigungswertung"] = {"DEFENSE_RATING",},
		["Erhöht Verteidigungswertung"] = {"DEFENSE_RATING",},
		["Erhöht die Verteidigungswertung"] = {"DEFENSE_RATING",},
		["Ausweichwertung"] = {"DODGE_RATING",},
		["Erhöht Eure Ausweichwertung"] = {"DODGE_RATING",},
		["Parierwertung"] = {"PARRY_RATING",},
		["Erhöht Eure Parierwertung"] = {"PARRY_RATING",},
		["Blockwertung"] = {"BLOCK_RATING",},
		["Erhöht Eure Blockwertung"] = {"BLOCK_RATING",},
		["Erhöt den Blockwet Eures Schildes"] = {"BLOCK_RATING",},

		["Trefferwertung"] = {"MELEE_HIT_RATING", "SPELL_HIT_RATING"},
		["Erhöht Trefferwertung"] = {"MELEE_HIT_RATING", "SPELL_HIT_RATING"}, -- ITEM_MOD_HIT_RATING
		["Erhöht Eure Trefferwertung"] = {"MELEE_HIT_RATING",}, -- ITEM_MOD_HIT_MELEE_RATING
		["Zaubertrefferwertung"] = {"SPELL_HIT_RATING",},
		["Erhöht Zaubertrefferwertung"] = {"SPELL_HIT_RATING",}, -- ITEM_MOD_HIT_SPELL_RATING
		["Erhöht Eure Zaubertrefferwertung"] = {"SPELL_HIT_RATING",},
		["Distanztrefferwertung"] = {"RANGED_HIT_RATING",},
		["Erhöht Distanztrefferwertung"] = {"RANGED_HIT_RATING",}, -- ITEM_MOD_HIT_RANGED_RATING
		["Erhöht Eure Distanztrefferwertung"] = {"RANGED_HIT_RATING",},

		["kritische Trefferwertung"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING"},
		["Erhöht kritische Trefferwertung"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING"},
		["Erhöht Eure kritische Trefferwertung"] = {"MELEE_CRIT_RATING",},
		["kritische Zaubertrefferwertung"] = {"SPELL_CRIT_RATING",},
		["Erhöht kritische Zaubertrefferwertung"] = {"SPELL_CRIT_RATING",},
		["Erhöht Eure kritische Zaubertrefferwertung"] = {"SPELL_CRIT_RATING",},
		["Erhöht die kritische Zaubertrefferwertung aller Gruppenmitglieder innerhalb von 30 Metern"] = {"SPELL_CRIT_RATING",},
		["Erhöht Eure kritische Distanztrefferwertung"] = {"RANGED_CRIT_RATING",}, -- Fletcher's Gloves ID:7348

		--	["Improves hit avoidance rating"] = {"MELEE_HIT_AVOID_RATING"}, -- ITEM_MOD_HIT_TAKEN_RATING
		--	["Improves melee hit avoidance rating"] = {"MELEE_HIT_AVOID_RATING"}, -- ITEM_MOD_HIT_TAKEN_MELEE_RATING
		--	["Improves ranged hit avoidance rating"] = {"RANGED_HIT_AVOID_RATING"}, -- ITEM_MOD_HIT_TAKEN_RANGED_RATING
		--	["Improves spell hit avoidance rating"] = {"SPELL_HIT_AVOID_RATING"}, -- ITEM_MOD_HIT_TAKEN_SPELL_RATING
		["Abhärtung"] = {"RESILIENCE_RATING",},
		["Abhärtungswertung"] = {"RESILIENCE_RATING",},
		["Erhöht Eure Abhärtungswertung"] = {"RESILIENCE_RATING",},
		--	["Improves critical avoidance rating"] = {"MELEE_CRIT_AVOID_RATING",},
		--	["Improves melee critical avoidance rating"] = {"MELEE_CRIT_AVOID_RATING",},
		--	["Improves ranged critical avoidance rating"] = {"RANGED_CRIT_AVOID_RATING",},
		--	["Improves spell critical avoidance rating"] = {"SPELL_CRIT_AVOID_RATING",},

		["Tempowertung"] = {"MELEE_HASTE_RATING", "SPELL_HASTE_RATING"},
		["Angriffstempowertung"] = {"MELEE_HASTE_RATING", "SPELL_HASTE_RATING"},
		["Erhöht Tempowertung"] = {"MELEE_HASTE_RATING", "SPELL_HASTE_RATING"}, -- [Pfeilabwehrender Brustschutz] ID:33328
		["Erhöht Angriffstempowertung"] = {"MELEE_HASTE_RATING", "SPELL_HASTE_RATING"},
		["Erhöht Eure Angriffstempowertung"] = {"MELEE_HASTE_RATING", "SPELL_HASTE_RATING"},
		["Erhöht Zaubertempowertung"] = {"SPELL_HASTE_RATING"},
		["Zaubertempowertung"] = {"SPELL_HASTE_RATING"},
		["Distanzangriffstempowertung"] = {"RANGED_HASTE_RATING"},
		["Erhöht Eure Distanzangriffstempowertung"] = {"RANGED_HASTE_RATING"},

		["Erhöht die Fertigkeitswertung für Dolche"] = {"DAGGER_WEAPON_RATING"},
		["Erhöht die Fertigkeitswertung für Schwerter"] = {"SWORD_WEAPON_RATING"},
		["Erhöht die Fertigkeitswertung für Zweihandschwerter"] = {"2H_SWORD_WEAPON_RATING"},
		["Erhöht die Fertigkeitswertung für Äxte"] = {"AXE_WEAPON_RATING"},
		["Erhöht die Fertigkeitswertung für Zweihandäxte"] = {"2H_AXE_WEAPON_RATING"},
		["Erhöht die Fertigkeitswertung für Kolben"] = {"MACE_WEAPON_RATING"},
		["Erhöht die Fertigkeitswertung für Zweihandkolben"] = {"2H_MACE_WEAPON_RATING"},
		["Erhöht die Fertigkeitswertung für Schusswaffen"] = {"GUN_WEAPON_RATING"},
		["Erhöht die Fertigkeitswertung für Armbrüste"] = {"CROSSBOW_WEAPON_RATING"},
		["Erhöht die Fertigkeitswertung für Bögen"] = {"BOW_WEAPON_RATING"},
		["Erhöht die Fertigkeitswertung für 'Wilder Kampf'"] = {"FERAL_WEAPON_RATING"},
		["Erhöht die Fertigkeitswertung für Faustwaffen"] = {"FIST_WEAPON_RATING"}, -- Demonblood Eviscerator
		["Erhöht die Fertigkeitswertung für unbewaffneten Kampf"] = {"FIST_WEAPON_RATING"}, -- Demonblood Eviscerator ID:27533

		["Erhöht die Waffenkundewertung"] = {"EXPERTISE_RATING"},

		["Erhöht Eure Waffenkundewertung um"] = {"EXPERTISE_RATING"},
		["Rüstungsdurchschlagwertung"] = {"ARMOR_PENETRATION_RATING"},
		["Erhöht den Rüstungsdurchschlagwert um"] = {"ARMOR_PENETRATION_RATING"},
		["Erhöht die Rüstungsdurchschlagwertung um"] = {"ARMOR_PENETRATION_RATING"},
		["Erhöht Eure Rüstungsdurchschlagwertung um"] = {"ARMOR_PENETRATION_RATING"}, -- ID:43178

		-- Exclude
		["Sek"] = false,
		["bis"] = false,
		["Platz Tasche"] = false,
		["Platz Köcher"] = false,
		["Platz Munitionsbeutel"] = false,
		["Erhöht das Distanzangriffstempo"] = false, -- AV quiver
	},
}
DisplayLocale.deDE = {
	----------------
	-- Stat Names --
	----------------
	-- Please localize these strings too, global strings were used in the enUS locale just to have minimum
	-- localization effect when a locale is not available for that language, you don't have to use global
	-- strings in your localization.

  ["Stat Multiplier"] = "Wertemultiplikatoren",
  ["Attack Power Multiplier"] = "Angriffskraft-Multiplikatoren",
  ["Reduced Physical Damage Taken"] = "Reduzierter erlittener physischer Schaden",
	-- NOTE I left many of the english terms because german players tend to use them and germans are much tooo long
	["StatIDToName"] = {
		--[StatID] = {FullName, ShortName},
		---------------------------------------------------------------------------
		-- Tier1 Stats - Stats parsed directly off items
		["EMPTY_SOCKET_RED"] = {EMPTY_SOCKET_RED, EMPTY_SOCKET_RED}, -- EMPTY_SOCKET_RED = "Red Socket";
		["EMPTY_SOCKET_YELLOW"] = {EMPTY_SOCKET_YELLOW, EMPTY_SOCKET_YELLOW}, -- EMPTY_SOCKET_YELLOW = "Yellow Socket";
		["EMPTY_SOCKET_BLUE"] = {EMPTY_SOCKET_BLUE, EMPTY_SOCKET_BLUE}, -- EMPTY_SOCKET_BLUE = "Blue Socket";
		["EMPTY_SOCKET_META"] = {EMPTY_SOCKET_META, EMPTY_SOCKET_META}, -- EMPTY_SOCKET_META = "Meta Socket";

		["IGNORE_ARMOR"] = {"Rüstung ignorieren", "Rüstung igno."},
		["STEALTH_LEVEL"] = {"Verstohlenheitslevel", "Verstohlenheit"},
		["MELEE_DMG"] = {"Waffenschaden", "Waffenschaden"}, -- DAMAGE = "Damage"
		["RANGED_DMG"] = {"Ranged Weapon "..DAMAGE, "Ranged Dmg"}, -- DAMAGE = "Damage"
		["MOUNT_SPEED"] = {"Reitgeschwindigkeit(%)", "Reitgeschw.(%)"},
		["RUN_SPEED"] = {"Laufgeschwindigkeit(%)", "Laufgeschw.(%)"},

		["STR"] = {SPELL_STAT1_NAME, "Stärke"},
		["AGI"] = {SPELL_STAT2_NAME, "Bewegl"},
		["STA"] = {SPELL_STAT3_NAME, "Ausdauer"},
		["INT"] = {SPELL_STAT4_NAME, "Int"},
		["SPI"] = {SPELL_STAT5_NAME, "Wille"},
		["ARMOR"] = {ARMOR, ARMOR},
		["ARMOR_BONUS"] = {ARMOR.." von Bonus", ARMOR.."(Bonus)"},

		["FIRE_RES"] = {RESISTANCE2_NAME, "FW"},
		["NATURE_RES"] = {RESISTANCE3_NAME, "NW"},
		["FROST_RES"] = {RESISTANCE4_NAME, "FrW"},
		["SHADOW_RES"] = {RESISTANCE5_NAME, "SW"},
		["ARCANE_RES"] = {RESISTANCE6_NAME, "AW"},

		["FISHING"] = {"Angeln", "Angeln"},
		["MINING"] = {"Bergbau", "Bergbau"},
		["HERBALISM"] = {"Kräuterkunde", "Kräutern"},
		["SKINNING"] = {"Kürschnerei", "Küschnern"},

		["BLOCK_VALUE"] = {"Blockwert", "Blockwert"},

		["AP"] = {ATTACK_POWER_TOOLTIP, "AP"},
		["RANGED_AP"] = {RANGED_ATTACK_POWER, "RAP"},
		["FERAL_AP"] = {"Feral "..ATTACK_POWER_TOOLTIP, "Feral AP"},
		["AP_UNDEAD"] = {ATTACK_POWER_TOOLTIP.." (Untot)", "AP(Untot)"},
		["AP_DEMON"] = {ATTACK_POWER_TOOLTIP.." (Dämon)", "AP(Dämon)"},

		["HEAL"] = {"Heilung", "Heilung"},

		["SPELL_DMG"] = {PLAYERSTAT_SPELL_COMBAT.." "..DAMAGE, PLAYERSTAT_SPELL_COMBAT.." Schaden"},
		["SPELL_DMG_UNDEAD"] = {PLAYERSTAT_SPELL_COMBAT.." "..DAMAGE.." (Untot)", PLAYERSTAT_SPELL_COMBAT.." Schaden".."(Untot)"},
		["SPELL_DMG_DEMON"] = {PLAYERSTAT_SPELL_COMBAT.." "..DAMAGE.." (Dämon)", PLAYERSTAT_SPELL_COMBAT.." Schaden".."(Dämon)"},
		["HOLY_SPELL_DMG"] = {SPELL_SCHOOL1_CAP.." "..DAMAGE, SPELL_SCHOOL1_CAP.." Schaden"},
		["FIRE_SPELL_DMG"] = {SPELL_SCHOOL2_CAP.." "..DAMAGE, SPELL_SCHOOL2_CAP.." Schaden"},
		["NATURE_SPELL_DMG"] = {SPELL_SCHOOL3_CAP.." "..DAMAGE, SPELL_SCHOOL3_CAP.." Schaden"},
		["FROST_SPELL_DMG"] = {SPELL_SCHOOL4_CAP.." "..DAMAGE, SPELL_SCHOOL4_CAP.." Schaden"},
		["SHADOW_SPELL_DMG"] = {SPELL_SCHOOL5_CAP.." "..DAMAGE, SPELL_SCHOOL5_CAP.." Schaden"},
		["ARCANE_SPELL_DMG"] = {SPELL_SCHOOL6_CAP.." "..DAMAGE, SPELL_SCHOOL6_CAP.."Schaden"},

		["SPELLPEN"] = {PLAYERSTAT_SPELL_COMBAT.." "..SPELL_PENETRATION, SPELL_PENETRATION},

		["HEALTH"] = {HEALTH, HP},
		["MANA"] = {MANA, MP},
		["HEALTH_REG"] = {HEALTH.." Regeneration", "HP5"},
		["MANA_REG"] = {MANA.." Regeneration", "MP5"},

		["MAX_DAMAGE"] = {"Maximalschaden", "Max Schaden"},
		["DPS"] = {"Schaden pro Sekunde", "DPS"},

		["DEFENSE_RATING"] = {COMBAT_RATING_NAME2, COMBAT_RATING_NAME2}, -- COMBAT_RATING_NAME2 = "Defense Rating"
		["DODGE_RATING"] = {COMBAT_RATING_NAME3, COMBAT_RATING_NAME3}, -- COMBAT_RATING_NAME3 = "Dodge Rating"
		["PARRY_RATING"] = {COMBAT_RATING_NAME4, COMBAT_RATING_NAME4}, -- COMBAT_RATING_NAME4 = "Parry Rating"
		["BLOCK_RATING"] = {COMBAT_RATING_NAME5, COMBAT_RATING_NAME5}, -- COMBAT_RATING_NAME5 = "Block Rating"
		["MELEE_HIT_RATING"] = {COMBAT_RATING_NAME6, COMBAT_RATING_NAME6}, -- COMBAT_RATING_NAME6 = "Hit Rating"
		["RANGED_HIT_RATING"] = {PLAYERSTAT_RANGED_COMBAT.." "..COMBAT_RATING_NAME6, PLAYERSTAT_RANGED_COMBAT.." "..COMBAT_RATING_NAME6}, -- PLAYERSTAT_RANGED_COMBAT = "Ranged"
		["SPELL_HIT_RATING"] = {PLAYERSTAT_SPELL_COMBAT.." "..COMBAT_RATING_NAME6, PLAYERSTAT_SPELL_COMBAT.." "..COMBAT_RATING_NAME6}, -- PLAYERSTAT_SPELL_COMBAT = "Spell"
		["MELEE_HIT_AVOID_RATING"] = {"Treffervermeidung "..RATING, "Treffervermeidung "..RATING},
		["RANGED_HIT_AVOID_RATING"] = {PLAYERSTAT_RANGED_COMBAT.." Treffervermeidung "..RATING, PLAYERSTAT_RANGED_COMBAT.." Treffervermeidung "..RATING},
		["SPELL_HIT_AVOID_RATING"] = {PLAYERSTAT_SPELL_COMBAT.." Treffervermeidung "..RATING, PLAYERSTAT_SPELL_COMBAT.." Treffervermeidung "..RATING},
		["MELEE_CRIT_RATING"] = {COMBAT_RATING_NAME9, COMBAT_RATING_NAME9}, -- COMBAT_RATING_NAME9 = "Crit Rating"
		["RANGED_CRIT_RATING"] = {PLAYERSTAT_RANGED_COMBAT.." "..COMBAT_RATING_NAME9, PLAYERSTAT_RANGED_COMBAT.." "..COMBAT_RATING_NAME9},
		["SPELL_CRIT_RATING"] = {PLAYERSTAT_SPELL_COMBAT.." "..COMBAT_RATING_NAME9, PLAYERSTAT_SPELL_COMBAT.." "..COMBAT_RATING_NAME9},
		["MELEE_CRIT_AVOID_RATING"] = {"Kritvermeidung "..RATING, "Kritvermeidung "..RATING},
		["RANGED_CRIT_AVOID_RATING"] = {PLAYERSTAT_RANGED_COMBAT.." Kritvermeidung "..RATING, PLAYERSTAT_RANGED_COMBAT.." Kritvermeidung "..RATING},
		["SPELL_CRIT_AVOID_RATING"] = {PLAYERSTAT_SPELL_COMBAT.." Kritvermeidung "..RATING, PLAYERSTAT_SPELL_COMBAT.." Kritvermeidung "..RATING},
		["RESILIENCE_RATING"] = {COMBAT_RATING_NAME15, COMBAT_RATING_NAME15}, -- COMBAT_RATING_NAME15 = "Resilience"
		["MELEE_HASTE_RATING"] = {"Hast "..RATING, "Hast "..RATING}, --
		["RANGED_HASTE_RATING"] = {PLAYERSTAT_RANGED_COMBAT.." Hast "..RATING, PLAYERSTAT_RANGED_COMBAT.." Hast "..RATING},
		["SPELL_HASTE_RATING"] = {PLAYERSTAT_SPELL_COMBAT.." Hast "..RATING, PLAYERSTAT_SPELL_COMBAT.." Hast "..RATING},
		["EXPERTISE_RATING"] = {"Waffenkundewertung", "Waffenkundewertung"},
		["DAGGER_WEAPON_RATING"] = {"Dagger "..SKILL.." "..RATING, "Dagger "..RATING}, -- SKILL = "Skill"
		["SWORD_WEAPON_RATING"] = {"Sword "..SKILL.." "..RATING, "Sword "..RATING},
		["2H_SWORD_WEAPON_RATING"] = {"Two-Handed Sword "..SKILL.." "..RATING, "2H Sword "..RATING},
		["AXE_WEAPON_RATING"] = {"Axe "..SKILL.." "..RATING, "Axe "..RATING},
		["2H_AXE_WEAPON_RATING"] = {"Two-Handed Axe "..SKILL.." "..RATING, "2H Axe "..RATING},
		["MACE_WEAPON_RATING"] = {"Mace "..SKILL.." "..RATING, "Mace "..RATING},
		["2H_MACE_WEAPON_RATING"] = {"Two-Handed Mace "..SKILL.." "..RATING, "2H Mace "..RATING},
		["GUN_WEAPON_RATING"] = {"Gun "..SKILL.." "..RATING, "Gun "..RATING},
		["CROSSBOW_WEAPON_RATING"] = {"Crossbow "..SKILL.." "..RATING, "Crossbow "..RATING},
		["BOW_WEAPON_RATING"] = {"Bow "..SKILL.." "..RATING, "Bow "..RATING},
		["FERAL_WEAPON_RATING"] = {"Feral "..SKILL.." "..RATING, "Feral "..RATING},
		["FIST_WEAPON_RATING"] = {"Unarmed "..SKILL.." "..RATING, "Unarmed "..RATING},
		["ARMOR_PENETRATION_RATING"] = {"Rüstungsdurchschlag".." "..RATING, "ArP".." "..RATING},

		---------------------------------------------------------------------------
		-- Tier2 Stats - Stats that only show up when broken down from a Tier1 stat
		-- Str -> AP, Block Value
		-- Agi -> AP, Crit, Dodge
		-- Sta -> Health
		-- Int -> Mana, Spell Crit
		-- Spi -> mp5nc, hp5oc
		-- Ratings -> Effect
		["HEALTH_REG_OUT_OF_COMBAT"] = {HEALTH.." Regeneration (Nicht im Kampf)", "HP5(OC)"},
		["MANA_REG_NOT_CASTING"] = {MANA.." Regeneration (Nicht zaubernd)", "MP5(NC)"},
		["MELEE_CRIT_DMG_REDUCTION"] = {"Krit Schadenverminderung (%)", "Krit Schaden Verm(%)"},
		["RANGED_CRIT_DMG_REDUCTION"] = {PLAYERSTAT_RANGED_COMBAT.." Krit Schadenverminderung(%)", PLAYERSTAT_RANGED_COMBAT.." Krit Schaden Verm(%)"},
		["SPELL_CRIT_DMG_REDUCTION"] = {PLAYERSTAT_SPELL_COMBAT.." Krit Schadenverminderung(%)", PLAYERSTAT_SPELL_COMBAT.." Krit Schaden Verm(%)"},
		["DEFENSE"] = {DEFENSE, "Def"},
		["DODGE"] = {DODGE.."(%)", DODGE.."(%)"},
		["PARRY"] = {PARRY.."(%)", PARRY.."(%)"},
		["BLOCK"] = {BLOCK.."(%)", BLOCK.."(%)"},
		["AVOIDANCE"] = {"Vermeidung(%)", "Vermeidung(%)"},
		["MELEE_HIT"] = {"Trefferchance(%)", "Treffer(%)"},
		["RANGED_HIT"] = {PLAYERSTAT_RANGED_COMBAT.." Trefferchance(%)", PLAYERSTAT_RANGED_COMBAT.." Treffer(%)"},
		["SPELL_HIT"] = {PLAYERSTAT_SPELL_COMBAT.." Trefferchance(%)", PLAYERSTAT_SPELL_COMBAT.." Treffer(%)"},
		["MELEE_HIT_AVOID"] = {"Treffer Vermeidung(%)", "Treffer Vermeid(%)"},
		["RANGED_HIT_AVOID"] = {PLAYERSTAT_RANGED_COMBAT.." Treffer Vermeidung(%)", PLAYERSTAT_RANGED_COMBAT.." Trefferermeidung(%)"},
		["SPELL_HIT_AVOID"] = {PLAYERSTAT_SPELL_COMBAT.." Treffer Vermeidung(%)", PLAYERSTAT_SPELL_COMBAT.." Treffervermeidung(%)"},
		["MELEE_CRIT"] = {MELEE_CRIT_CHANCE.."(%)", "Krit(%)"}, -- MELEE_CRIT_CHANCE = "Crit Chance"
		["RANGED_CRIT"] = {PLAYERSTAT_RANGED_COMBAT.." "..MELEE_CRIT_CHANCE.."(%)", PLAYERSTAT_RANGED_COMBAT.." Krit(%)"},
		["SPELL_CRIT"] = {PLAYERSTAT_SPELL_COMBAT.." "..MELEE_CRIT_CHANCE.."(%)", PLAYERSTAT_SPELL_COMBAT.." Krit(%)"},
		["MELEE_CRIT_AVOID"] = {"Kritvermeidung(%)", "Kritvermeidung(%)"},
		["RANGED_CRIT_AVOID"] = {PLAYERSTAT_RANGED_COMBAT.." Kritvermeidung(%)", PLAYERSTAT_RANGED_COMBAT.." Kritvermeidung(%)"},
		["SPELL_CRIT_AVOID"] = {PLAYERSTAT_SPELL_COMBAT.." Kritvermeidung(%)", PLAYERSTAT_SPELL_COMBAT.." Kritvermeidung(%)"},
		["MELEE_HASTE"] = {"Hast(%)", "Hast(%)"}, --
		["RANGED_HASTE"] = {PLAYERSTAT_RANGED_COMBAT.." Hast(%)", PLAYERSTAT_RANGED_COMBAT.." Hast(%)"},
		["SPELL_HASTE"] = {PLAYERSTAT_SPELL_COMBAT.." Hast(%)", PLAYERSTAT_SPELL_COMBAT.." Hast(%)"},
		["EXPERTISE"] = {"Waffenkunde", "Waffenkunde"},
		["DAGGER_WEAPON"] = {"Dagger "..SKILL, "Dagger"}, -- SKILL = "Skill"
		["SWORD_WEAPON"] = {"Sword "..SKILL, "Sword"},
		["2H_SWORD_WEAPON"] = {"Two-Handed Sword "..SKILL, "2H Sword"},
		["AXE_WEAPON"] = {"Axe "..SKILL, "Axe"},
		["2H_AXE_WEAPON"] = {"Two-Handed Axe "..SKILL, "2H Axe"},
		["MACE_WEAPON"] = {"Mace "..SKILL, "Mace"},
		["2H_MACE_WEAPON"] = {"Two-Handed Mace "..SKILL, "2H Mace"},
		["GUN_WEAPON"] = {"Gun "..SKILL, "Gun"},
		["CROSSBOW_WEAPON"] = {"Crossbow "..SKILL, "Crossbow"},
		["BOW_WEAPON"] = {"Bow "..SKILL, "Bow"},
		["FERAL_WEAPON"] = {"Feral "..SKILL, "Feral"},
		["FIST_WEAPON"] = {"Unarmed "..SKILL, "Unarmed"},
		["ARMOR_PENETRATION"] = {"Rüstungsdurchschlag(%)", "ArP(%)"},

		---------------------------------------------------------------------------
		-- Tier3 Stats - Stats that only show up when broken down from a Tier2 stat
		-- Defense -> Crit Avoidance, Hit Avoidance, Dodge, Parry, Block
		-- Weapon Skill -> Crit, Hit, Dodge Neglect, Parry Neglect, Block Neglect
		["DODGE_NEGLECT"] = {DODGE.." Verhinderung(%)", DODGE.." Verhinderung(%)"},
		["PARRY_NEGLECT"] = {PARRY.." Verhinderung(%)", PARRY.." Verhinderung(%)"},
		["BLOCK_NEGLECT"] = {BLOCK.." Verhinderung(%)", BLOCK.." Verhinderung(%)"},

		---------------------------------------------------------------------------
		-- Talents
		["MELEE_CRIT_DMG"] = {"Krit Schaden(%)", "Crit Schaden(%)"},
		["RANGED_CRIT_DMG"] = {PLAYERSTAT_RANGED_COMBAT.." Krit Schaden(%)", PLAYERSTAT_RANGED_COMBAT.." Krit Schaden(%)"},
		["SPELL_CRIT_DMG"] = {PLAYERSTAT_SPELL_COMBAT.." Krit Schaden(%)", PLAYERSTAT_SPELL_COMBAT.." Krit Schaden(%)"},

		---------------------------------------------------------------------------
		-- Spell Stats
		-- These values can be prefixed with a @ and spell name, using reverse translation to english from Babble-Spell-2.2
		-- ex: "Heroic Strike@RAGE_COST" for Heroic Strike rage cost
		-- ex: "Heroic Strike@THREAT" for Heroic Strike threat value
		-- Use strsplit("@", text) to seperate the spell name and statid
		["THREAT"] = {"Bedrohung", "Bedrohung"},
		["CAST_TIME"] = {"Zauberzeit", "Zauberzeit"},
		["MANA_COST"] = {"Manakosten", "Mana"},
		["RAGE_COST"] = {"Wutkosten", "Wut"},
		["ENERGY_COST"] = {"Energiekosten", "Energie"},
		["COOLDOWN"] = {"Abklingzeit", "CD"},

		---------------------------------------------------------------------------
		-- Stats Mods
		["MOD_STR"] = {"Mod "..SPELL_STAT1_NAME.."(%)", "Mod Str(%)"},
		["MOD_AGI"] = {"Mod "..SPELL_STAT2_NAME.."(%)", "Mod Agi(%)"},
		["MOD_STA"] = {"Mod "..SPELL_STAT3_NAME.."(%)", "Mod Sta(%)"},
		["MOD_INT"] = {"Mod "..SPELL_STAT4_NAME.."(%)", "Mod Int(%)"},
		["MOD_SPI"] = {"Mod "..SPELL_STAT5_NAME.."(%)", "Mod Spi(%)"},
		["MOD_HEALTH"] = {"Mod "..HEALTH.."(%)", "Mod "..HP.."(%)"},
		["MOD_MANA"] = {"Mod "..MANA.."(%)", "Mod "..MP.."(%)"},
		["MOD_ARMOR"] = {"Mod "..ARMOR.."from Items".."(%)", "Mod "..ARMOR.."(Items)".."(%)"},
		["MOD_BLOCK_VALUE"] = {"Mod Block Value".."(%)", "Mod Block Value".."(%)"},
		["MOD_DMG"] = {"Mod Damage".."(%)", "Mod Dmg".."(%)"},
		["MOD_DMG_TAKEN"] = {"Mod Damage Taken".."(%)", "Mod Dmg Taken".."(%)"},
		["MOD_CRIT_DAMAGE"] = {"Mod Crit Damage".."(%)", "Mod Crit Dmg".."(%)"},
		["MOD_CRIT_DAMAGE_TAKEN"] = {"Mod Crit Damage Taken".."(%)", "Mod Crit Dmg Taken".."(%)"},
		["MOD_THREAT"] = {"Mod Threat".."(%)", "Mod Threat".."(%)"},
		["MOD_AP"] = {"Mod "..ATTACK_POWER_TOOLTIP.."(%)", "Mod AP".."(%)"},
		["MOD_RANGED_AP"] = {"Mod "..PLAYERSTAT_RANGED_COMBAT.." "..ATTACK_POWER_TOOLTIP.."(%)", "Mod RAP".."(%)"},
		["MOD_SPELL_DMG"] = {"Mod "..PLAYERSTAT_SPELL_COMBAT.." "..DAMAGE.."(%)", "Mod "..PLAYERSTAT_SPELL_COMBAT.." Dmg".."(%)"},
		["MOD_HEALING"] = {"Mod Healing".."(%)", "Mod Heal".."(%)"},
		["MOD_CAST_TIME"] = {"Mod Casting Time".."(%)", "Mod Cast Time".."(%)"},
		["MOD_MANA_COST"] = {"Mod Mana Cost".."(%)", "Mod Mana Cost".."(%)"},
		["MOD_RAGE_COST"] = {"Mod Rage Cost".."(%)", "Mod Rage Cost".."(%)"},
		["MOD_ENERGY_COST"] = {"Mod Energy Cost".."(%)", "Mod Energy Cost".."(%)"},
		["MOD_COOLDOWN"] = {"Mod Cooldown".."(%)", "Mod CD".."(%)"},

		---------------------------------------------------------------------------
		-- Misc Stats
		["WEAPON_RATING"] = {"Waffe "..SKILL.." "..RATING, "Waffe"..SKILL.." "..RATING},
		["WEAPON_SKILL"] = {"Waffe "..SKILL, "Waffe"..SKILL},
		["MAINHAND_WEAPON_RATING"] = {"Waffenhandwaffe "..SKILL.." "..RATING, "Waffenhand"..SKILL.." "..RATING},
		["OFFHAND_WEAPON_RATING"] = {"Schildhandwaffe "..SKILL.." "..RATING, "Schildhand"..SKILL.." "..RATING},
		["RANGED_WEAPON_RATING"] = {"Fernkampfwaffe "..SKILL.." "..RATING, "Fernkampf"..SKILL.." "..RATING},
	},
}

-- frFR localization by Tixu
PatternLocale.frFR = {
	["tonumber"] = function(s)
		local n = tonumber(s)
		if n then
			return n
		else
			return tonumber((gsub(s, ",", "%.")))
		end
	end,
	-----------------
	-- Armor Types --
	-----------------
	Plate = "Plaques",
	Mail = "Mailles",
	Leather = "Cuir",
	Cloth = "Tissu",
	------------------
	-- Fast Exclude --
	------------------
	-- By looking at the first ExcludeLen letters of a line we can exclude a lot of lines
	["ExcludeLen"] = 5, -- using string.utf8len
	["Exclude"] = {
		[""] = true,
		[" \n"] = true,
		[ITEM_BIND_ON_EQUIP] = true, -- ITEM_BIND_ON_EQUIP = "Binds when equipped"; -- Item will be bound when equipped
		[ITEM_BIND_ON_PICKUP] = true, -- ITEM_BIND_ON_PICKUP = "Binds when picked up"; -- Item wil be bound when picked up
		[ITEM_BIND_ON_USE] = true, -- ITEM_BIND_ON_USE = "Binds when used"; -- Item will be bound when used
		[ITEM_BIND_QUEST] = true, -- ITEM_BIND_QUEST = "Quest Item"; -- Item is a quest item (same logic as ON_PICKUP)
		[ITEM_SOULBOUND] = true, -- ITEM_SOULBOUND = "Soulbound"; -- Item is Soulbound
		--[EMPTY_SOCKET_BLUE] = true, -- EMPTY_SOCKET_BLUE = "Blue Socket";
		--[EMPTY_SOCKET_META] = true, -- EMPTY_SOCKET_META = "Meta Socket";
		--[EMPTY_SOCKET_RED] = true, -- EMPTY_SOCKET_RED = "Red Socket";
		--[EMPTY_SOCKET_YELLOW] = true, -- EMPTY_SOCKET_YELLOW = "Yellow Socket";
		[ITEM_STARTS_QUEST] = true, -- ITEM_STARTS_QUEST = "This Item Begins a Quest"; -- Item is a quest giver
		[ITEM_CANT_BE_DESTROYED] = true, -- ITEM_CANT_BE_DESTROYED = "That item cannot be destroyed."; -- Attempted to destroy a NO_DESTROY item
		[ITEM_CONJURED] = true, -- ITEM_CONJURED = "Conjured Item"; -- Item expires
		[ITEM_DISENCHANT_NOT_DISENCHANTABLE] = true, -- ITEM_DISENCHANT_NOT_DISENCHANTABLE = "Cannot be disenchanted"; -- Items which cannot be disenchanted ever
		--["Disen"] = true, -- ITEM_DISENCHANT_ANY_SKILL = "Disenchantable"; -- Items that can be disenchanted at any skill level
		--["Durat"] = true, -- ITEM_DURATION_DAYS = "Duration: %d days";
		["Temps"] = true, -- temps de recharge...
		["<Arti"] = true, -- artisan
		["Uniqu"] = true, -- Unique (20)
		["Nivea"] = true, -- Niveau
		["\nNive"] = true, -- Niveau
		["Class"] = true, -- Classes: xx
		["Races"] = true, -- Races: xx (vendor mounts)
		["Utili"] = true, -- Utiliser:
		["Chanc"] = true, -- Chance de toucher:
		["Requi"] = true, -- Requiert
		["\nRequ"] = true,-- Requiert
		["Néces"] = true,--nécessite plus de gemmes...
		-- Set Bonuses
		["Ensem"] = true,--ensemble
		["(2) E"] = true,
		["(2) E"] = true,
		["(3) E"] = true,
		["(4) E"] = true,
		["(5) E"] = true,
		["(6) E"] = true,
		["(7) E"] = true,
		["(8) E"] = true,
		-- Equip type
		["Proje"] = true, -- Ice Threaded Arrow ID:19316
		[INVTYPE_AMMO] = true,
		[INVTYPE_HEAD] = true,
		[INVTYPE_NECK] = true,
		[INVTYPE_SHOULDER] = true,
		[INVTYPE_BODY] = true,
		[INVTYPE_CHEST] = true,
		[INVTYPE_ROBE] = true,
		[INVTYPE_WAIST] = true,
		[INVTYPE_LEGS] = true,
		[INVTYPE_FEET] = true,
		[INVTYPE_WRIST] = true,
		[INVTYPE_HAND] = true,
		[INVTYPE_FINGER] = true,
		[INVTYPE_TRINKET] = true,
		[INVTYPE_CLOAK] = true,
		[INVTYPE_WEAPON] = true,
		[INVTYPE_SHIELD] = true,
		[INVTYPE_2HWEAPON] = true,
		[INVTYPE_WEAPONMAINHAND] = true,
		[INVTYPE_WEAPONOFFHAND] = true,
		[INVTYPE_HOLDABLE] = true,
		[INVTYPE_RANGED] = true,
		[INVTYPE_THROWN] = true,
		[INVTYPE_RANGEDRIGHT] = true,
		[INVTYPE_RELIC] = true,
		[INVTYPE_TABARD] = true,
		[INVTYPE_BAG] = true,
	},

	-----------------------
	-- Whole Text Lookup --
	-----------------------
	-- Mainly used for enchants that doesn't have numbers in the text
	["WholeTextLookup"] = {
		[EMPTY_SOCKET_RED] = {["EMPTY_SOCKET_RED"] = 1}, -- EMPTY_SOCKET_RED = "Red Socket";
		[EMPTY_SOCKET_YELLOW] = {["EMPTY_SOCKET_YELLOW"] = 1}, -- EMPTY_SOCKET_YELLOW = "Yellow Socket";
		[EMPTY_SOCKET_BLUE] = {["EMPTY_SOCKET_BLUE"] = 1}, -- EMPTY_SOCKET_BLUE = "Blue Socket";
		[EMPTY_SOCKET_META] = {["EMPTY_SOCKET_META"] = 1}, -- EMPTY_SOCKET_META = "Meta Socket";

		--ToDo
		["Huile de sorcier mineure"] = {["SPELL_DMG"] = 8, ["HEAL"] = 8}, --
		["Huile de sorcier inférieure"] = {["SPELL_DMG"] = 16, ["HEAL"] = 16}, --
		["Huile de sorcier"] = {["SPELL_DMG"] = 24, ["HEAL"] = 24}, --
		["Huile de sorcier brillante"] = {["SPELL_DMG"] = 36, ["HEAL"] = 36, ["SPELL_CRIT_RATING"] = 14}, --
		["Huile de sorcier excellente"] = {["SPELL_DMG"] = 42, ["HEAL"] = 42}, --
		["Huile de sorcier bénite"] = {["SPELL_DMG_UNDEAD"] = 60}, --

		["Huile de mana mineure"] = {["MANA_REG"] = 4}, --
		["Huile de mana inférieure"] = {["MANA_REG"] = 8}, --
		["Huile de mana brillante"] = {["MANA_REG"] = 12, ["HEAL"] = 25}, --
		["Huile de mana excellente"] = {["MANA_REG"] = 14}, --

		["Eternium Line"] = {["FISHING"] = 5}, --
		["Feu solaire"] = {["ARCANE_SPELL_DMG"] = 50, ["FIRE_SPELL_DMG"] = 50}, --
		["Augmentation mineure de la vitesse de la monture"] = {["MOUNT_SPEED"] = 2}, -- Enchant Gloves - Riding Skill
		["Pied sûr"] = {["MELEE_HIT_RATING"] = 10}, -- Enchant Boots - Surefooted "Surefooted" http://wow.allakhazam.com/db/spell.html?wspell=27954

		["Equip: Allows underwater breathing."] = false, -- [Band of Icy Depths] ID: 21526
		["Allows underwater breathing"] = false, --
		["Equip: Immune to Disarm."] = false, -- [Stronghold Gauntlets] ID: 12639
		["Immune to Disarm"] = false, --
		["Lifestealing"] = false, -- Enchant Crusader

		--translated
		["Eperons en mithril"] = {["MOUNT_SPEED"] = 4}, -- Mithril Spurs
		["Équipé\194\160: La vitesse de course augmente légèrement."] = {["RUN_SPEED"] = 8}, -- [Highlander's Plate Greaves] ID: 20048
		["La vitesse de course augmente légèrement"] = {["RUN_SPEED"] = 8}, --
		["Augmentation mineure de vitesse"] = {["RUN_SPEED"] = 8}, -- Enchant Boots - Minor Speed "Minor Speed Increase" http://wow.allakhazam.com/db/spell.html?wspell=13890
		["Vitalité"] = {["MANA_REG"] = 4, ["HEALTH_REG"] = 4}, -- Enchant Boots - Vitality "Vitality" http://wow.allakhazam.com/db/spell.html?wspell=27948
		["Âme de givre"] = {["SHADOW_SPELL_DMG"] = 54, ["FROST_SPELL_DMG"] = 54}, --
		["Sauvagerie"] = {["AP"] = 70}, --
		["Vitesse mineure"] = {["RUN_SPEED"] = 8},
		["Vitesse mineure et +9 en Endurance"] = {["RUN_SPEED"] = 8, ["STA"] = 9},--enchant

		["Croisé"] = false, -- Enchant Crusader
		["Mangouste"] = false, -- Enchant Mangouste
		["Arme impie"] = false,
		["Équipé : Evite à son porteur d'être entièrement englobé dans la Flamme d'ombre."] = false, --cape Onyxia

		["Vitalité rohart"] = {["RUN_SPEED"] = 8, ["STA"] = 15}, -- EnchantID: 3232
		["Sagesse"] = {["MOD_THREAT"] = -2, ["SPI"] = 10}, -- EnchantID: 3296
		["Précision"] = {["MELEE_HIT_RATING"] = 25, ["SPELL_HIT_RATING"] = 25, ["MELEE_CRIT_RATING"] = 25, ["SPELL_CRIT_RATING"] = 25}, -- EnchantID: 3788
		["Plaie-du-Fléau"] = {["AP_UNDEAD"] = 140}, -- EnchantID: 3247
		["Marcheglace"] = {["MELEE_HIT_RATING"] = 12, ["SPELL_HIT_RATING"] = 12, ["MELEE_CRIT_RATING"] = 12, ["SPELL_CRIT_RATING"] = 12}, -- EnchantID: 3826
		["Récolteur"] = {["HERBALISM"] = 5, ["MINING"] = 5, ["SKINNING"] = 5}, -- EnchantID: 3296
		["Vitalité supérieure"] = {["MANA_REG"] = 6, ["HEALTH_REG"] = 6}, -- EnchantID: 3244

	},
	----------------------------
	-- Single Plus Stat Check --
	----------------------------
	["SinglePlusStatCheck"] = "^([%+%-]%d+) (.-)%.?$",
	-----------------------------
	-- Single Equip Stat Check --
	-----------------------------
	["SingleEquipStatCheck"] = "^Équipé\194\160: Augmente (.-) ?de (%d+) ?a?u? ?m?a?x?i?m?u?m? ?(.-)%.?$",

	-------------
	-- PreScan --
	-------------
	-- Special cases that need to be dealt with before deep scan
	["PreScanPatterns"] = {
		["^Augmente la puissance d'attaque de (%d+) seulement en forme de félin, ours, ours redoutable ou sélénien%.$"] = "FERAL_AP", -- 3.0.8 FAP change
		["Bloquer.- (%d+)"] = "BLOCK_VALUE",
		["Armure.- (%d+)"] = "ARMOR",
		["^Équipé\194\160: Rend (%d+) points de vie toutes les 5 seco?n?d?e?s?%.?$"]= "HEAL_REG",
		["^Équipé\194\160: Rend (%d+) points de mana toutes les 5 seco?n?d?e?s?%.?$"]= "MANA_REG",
		["Renforcé %(%+(%d+) Armure%)"]= "ARMOR_BONUS",
		["Lunette %(%+(%d+) points? de dégâts?%)"]="RANGED_AP",
		["^%(([%d%,]+) dégâts par seconde%)$"] = "DPS",

		-- Exclude
		["^.- %(%d+/%d+%)$"] = false, -- Set Name (0/9)
		["|cff808080"] = false, -- Gray text "  |cff808080Requires at least 2 Yellow gems|r\n  |cff808080Requires at least 1 Red gem|r"
		--["Confère une chance"] = false, -- [Mark of Defiance] ID:27924 -- [Staff of the Qiraji Prophets] ID:21128
		["Rend parfois"] = false, -- [Darkmoon Card: Heroism] ID:19287
		["Vous gagnez une"] = false, -- condensateur de foudre
		["Dégâts ?:"] = false, -- ligne de degats des armes
		["Dégâts\194\160:"] = false, -- ligne de degats des armes
		["Votre technique"] = false,
		["^%+?%d+ %- %d+ points de dégâts %(.-%)$"]= false, -- ligne de degats des baguettes/ +degats (Thunderfury)
		["Permettent au porteur"] = false, -- Casques Ombrelunes
		["^.- %(%d+%) requis"] = false, --metier requis pour porter ou utiliser
		["^.- ?[Vv]?o?u?s? [Cc]onfèren?t? .-"] = false, --proc
		["^.- ?l?e?s? ?[Cc]hances .-"] = false, --proc
		["^.- par votre sort .-"] = false, --augmentation de capacité de sort
		["^.- la portée de .-"] = false, --augmentation de capacité de sort
		["^.- la durée de .-"] = false, --augmentation de capacité de sort
	},
	--------------
	-- DeepScan --
	--------------
	-- Strip leading "Equip: ", "Socket Bonus: "
	["Equip: "] = "Équipé\194\160: ", --\194\160= espace insécable
	["Socket Bonus: "] = "Bonus de sertissage\194\160: ",
	-- Strip trailing "."
	["."] = ".",
	["DeepScanSeparators"] = {
		"/", -- "+10 Defense Rating/+10 Stamina/+15 Block Value": ZG Enchant
		" & ", -- "+26 Healing Spells & 2% Reduced Threat": Bracing Earthstorm Diamond ID:25897
		", ", -- "+6 Spell Damage, +5 Spell Crit Rating": Potent Ornate Topaz ID: 28123
		"%. ", -- "Equip: Increases attack power by 81 when fighting Undead. It also allows the acquisition of Scourgestones on behalf of the Argent Dawn.": Seal of the Dawn
	},
	["DeepScanWordSeparators"] = {
		" et ", -- "Critical Rating +6 and Dodge Rating +5": Assassin's Fire Opal ID:30565
	},
	["DualStatPatterns"] = { -- all lower case
		["les soins %+(%d+) et les dégâts %+ (%d+)$"] = {{"HEAL",}, {"SPELL_DMG",},},
		["les soins %+(%d+) les dégâts %+ (%d+)"] = {{"HEAL",}, {"SPELL_DMG",},},
		["soins prodigués d'un maximum de (%d+) et les dégâts d'un maximum de (%d+)"] = {{"HEAL",}, {"SPELL_DMG",},},
	},
	["DeepScanPatterns"] = {
		"^(.-) ?([%+%-]%d+) ?(.-)%.?$", -- "xxx xxx +22" or "+22 xxx xxx" or "xxx +22 xxx" (scan 2ed)
		"^(.-) ?([%d%,]+) ?(.-)%.?$", -- 22.22 xxx xxx (scan last)
		"^.-: (.-)([%+%-]%d+) ?(.-)%.?$", --Bonus de sertissage : +3 xxx
		"^(.-) augmentée?s? de (%d+) ?(.-)%%?%.?$",--sometimes this pattern is needed but not often.
	},
	-----------------------
	-- Stat Lookup Table --
	-----------------------
	["StatIDLookup"] = {
		["votre niveau de camouflage actuel"] = {"STEALTH_LEVEL"},

		--dégats melee
		["aux dégâts des armes"] = {"MELEE_DMG"},
		["aux dégâts de l'arme"] = {"MELEE_DMG"},
		["aux dégâts en mêlée"] = {"MELEE_DMG"},
		["dégâts de l'arme"] = {"MELEE_DMG"},

		--vitesse de course
		["vitesse de monture"]= {"MOUNT_SPEED"},

		--caracteristiques
		["à toutes les caractéristiques"] = {"STR", "AGI", "STA", "INT", "SPI",},
		["force"] = {"STR",},
		["agilité"] = {"AGI",},
		["à l'agilité"] = {"AGI",}, -- Shifting Shadow Crystal [39935]
		["endurance"] = {"STA",},
		["en endurance"] = {"STA",},
		["à l'endurance"] = {"STA",}, -- Shifting Shadow Crystal [39935]
		["intelligence"] = {"INT",},
		["esprit"] = {"SPI",},
		["à l'esprit"] = {"SPI",}, -- Purified Shadowsong Amethyst [37503]


		--résistances
		["à la résistance arcanes"] = {"ARCANE_RES",},
		["à la résistance aux arcanes"] = {"ARCANE_RES",},

		["à la résistance feu"] = {"FIRE_RES",},
		["à la résistance au feu"] = {"FIRE_RES",},

		["à la résistance nature"] = {"NATURE_RES",},
		["à la résistance à la nature"] = {"NATURE_RES",},

		["à la résistance givre"] = {"FROST_RES",},
		["à la résistance au givre"] = {"FROST_RES",},

		["à la résistance ombre"] = {"SHADOW_RES",},
		["à la résistance à l'ombre"] = {"SHADOW_RES",},

		["à toutes les résistances"] = {"ARCANE_RES", "FIRE_RES", "FROST_RES", "NATURE_RES", "SHADOW_RES",},

		--artisanat
		["pêche"] = {"FISHING",},
		["minage"] = {"MINING",},
		["herboristerie"] = {"HERBALISM",}, -- Heabalism enchant ID:845
		["dépeçage"] = {"SKINNING",}, -- Skinning enchant ID:865

		--
		["armure"] = {"ARMOR_BONUS",},

		["défense"] = {"DEFENSE",},

		["valeur de blocage"] = {"BLOCK_VALUE",},
		["à la valeur de blocage"] = {"BLOCK_VALUE",},
		["la valeur de blocage de votre bouclier"] = {"BLOCK_VALUE",},

		["points de vie"] = {"HEALTH",},
		["aux points de vie"] = {"HEALTH",},
		["points de mana"] = {"MANA",},

		["la puissance d'attaque"] = {"AP",},
		["à la puissance d'attaque"] = {"AP",},
		["puissance d'attaque"] = {"AP",},



		--ToDo
		["Augmente dela puissance d'attaque lorsque vous combattez des morts-vivants"] = {"AP_UNDEAD",},
		--["Increases attack powerwhen fighting Undead"] = {"AP_UNDEAD",},
		--["Increases attack powerwhen fighting Undead.  It also allows the acquisition of Scourgestones on behalf of the Argent Dawn"] = {"AP_UNDEAD",},
		--["Increases attack powerwhen fighting Demons"] = {"AP_DEMON",},
		--["Attack Power in Cat, Bear, and Dire Bear forms only"] = {"FERAL_AP",},
		--["Increases attack powerin Cat, Bear, Dire Bear, and Moonkin forms only"] = {"FERAL_AP",},


		--ranged AP
		["la puissance des attaques à distance"] = {"RANGED_AP",},
		--Feral
		["la puissance d'attaque pour les formes de félin, d'ours, d'ours redoutable et de sélénien uniquement"] = {"FERAL_AP",},

		--regen
		["points de mana toutes les 5 secondes"] = {"MANA_REG",},
		["point de mana toutes les 5 secondes"] = {"MANA_REG",},
		["points de vie toutes les 5 secondes"] = {"HEALTH_REG",},
		["point de vie toutes les 5 secondes"] = {"HEALTH_REG",},
		["points de mana toutes les 5 sec"] = {"MANA_REG",},
		["points de vie toutes les 5 sec"] = {"HEALTH_REG",},
		["point de mana toutes les 5 sec"] = {"MANA_REG",},
		["point de vie toutes les 5 sec"] = {"HEALTH_REG",},
		["mana toutes les 5 secondes"] = {"MANA_REG",},
		["régén. de mana"] = {"MANA_REG",},


		--pénétration des sorts
		["la pénétration de vos sorts"] = {"SPELLPEN",},
		["à la pénétration des sorts"] = {"SPELLPEN",},
		--Puissance soins et sorts
		["à la puissance des sorts"] = {"SPELL_DMG", "HEAL"},
		["la puissance des sorts"] = {"SPELL_DMG", "HEAL"},
		["les soins prodigués par les sorts et effets"] = {"HEAL",},
		["augmente la puissance des sorts de"] = {"SPELL_DMG", "HEAL"},
		["les dégâts et les soins produits par les sorts et effets magiques"] = {"SPELL_DMG", "HEAL"},
		["aux dégâts des sorts et aux soins"] = {"SPELL_DMG", "HEAL"},
		["aux dégâts des sorts"] = {"SPELL_DMG",},
		["dégâts des sorts"] = {"SPELL_DMG",},
		["aux sorts de soins"] = {"HEAL",},
		["aux soins"] = {"HEAL",},
		["soins"] = {"HEAL",},
		["les soins prodigués par les sorts et effets d’un maximum"] = {"HEAL",},

		--ToDo
		["Augmente les dégâts infligés aux morts-vivants par les sorts et effets magiques d'un maximum de"] = {"SPELL_DMG_UNDEAD"},

		["les dégâts infligés par les sorts et effets d'ombre"]={"SHADOW_SPELL_DMG",},
		["aux dégâts des sorts d'ombre"]={"SHADOW_SPELL_DMG",},
		["aux dégâts d'ombre"]={"SHADOW_SPELL_DMG",},

		["les dégâts infligés par les sorts et effets de givre"]={"FROST_SPELL_DMG",},
		["aux dégâts des sorts de givre"]={"FROST_SPELL_DMG",},
		["aux dégâts de givre"]={"FROST_SPELL_DMG",},

		["les dégâts infligés par les sorts et effets de feu"]={"FIRE_SPELL_DMG",},
		["aux dégâts des sorts de feu"]={"FIRE_SPELL_DMG",},
		["aux dégâts de feu"]={"FIRE_SPELL_DMG",},

		["les dégâts infligés par les sorts et effets de nature"]={"NATURE_SPELL_DMG",},
		["aux dégâts des sorts de nature"]={"NATURE_SPELL_DMG",},
		["aux dégâts de nature"]={"NATURE_SPELL_DMG",},

		["les dégâts infligés par les sorts et effets des arcanes"]={"ARCANE_SPELL_DMG",},
		["aux dégâts des sorts d'arcanes"]={"ARCANE_SPELL_DMG",},
		["aux dégâts d'arcanes"]={"ARCANE_SPELL_DMG",},

		["les dégâts infligés par les sorts et effets du sacré"]={"HOLY_SPELL_DMG",},
		["aux dégâts des sorts du sacré"]={"HOLY_SPELL_DMG",},
		["aux dégâts du sacré"]={"HOLY_SPELL_DMG",},

		--ToDo
		--["Healing Spells"] = {"HEAL",}, -- Enchant Gloves - Major Healing "+35 Healing Spells" http://wow.allakhazam.com/db/spell.html?wspell=33999
		--["Increases Healing"] = {"HEAL",},
		--["Healing"] = {"HEAL",},
		--["healing Spells"] = {"HEAL",},
		--["Healing Spells"] = {"HEAL",}, -- [Royal Nightseye] ID: 24057
		--["Increases healing done by spells and effects"] = {"HEAL",},
		--["Increases healing done by magical spells and effects of all party members within 30 yards"] = {"HEAL",}, -- Atiesh
		--["your healing"] = {"HEAL",}, -- Atiesh

		["dégâts par seconde"] = {"DPS",},
		--["Addsdamage per second"] = {"DPS",}, -- [Thorium Shells] ID: 15977

		["score de défense"] = {"DEFENSE_RATING",},
		["au score de défense"] = {"DEFENSE_RATING",},
		["le score de défense"] = {"DEFENSE_RATING",},
		["votre score de défense"] = {"DEFENSE_RATING",},

		["score d'esquive"] = {"DODGE_RATING",},
		["le score d'esquive"] = {"DODGE_RATING",},
		["au score d'esquive"] = {"DODGE_RATING",},
		["votre score d'esquive"] = {"DODGE_RATING",},

		["score de parade"] = {"PARRY_RATING",},
		["au score de parade"] = {"PARRY_RATING",},
		["le score de parade"] = {"PARRY_RATING",},
		["votre score de parade"] = {"PARRY_RATING",},

		["score de blocage"] = {"BLOCK_RATING",}, -- Enchant Shield - Lesser Block +10 Shield Block Rating http://wow.allakhazam.com/db/spell.html?wspell=13689
		["le score de blocage"] = {"BLOCK_RATING",},
		["votre score de blocage"] = {"BLOCK_RATING",},
		["au score de blocage"] = {"BLOCK_RATING",},

		["score de toucher"] = {"MELEE_HIT_RATING", "SPELL_HIT_RATING",},
		["le score de toucher"] = {"MELEE_HIT_RATING", "SPELL_HIT_RATING",},
		["votre score de toucher"] = {"MELEE_HIT_RATING", "SPELL_HIT_RATING",},
		["au score de toucher"] = {"MELEE_HIT_RATING", "SPELL_HIT_RATING",},

		["score de coup critique"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING",},
		["score de critique"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING",},
		["le score de coup critique"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING",},
		["votre score de coup critique"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING",},
		["au score de coup critique"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING",},
		["au score de critique"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING",},

		["score de résilience"] = {"RESILIENCE_RATING",},
		["le score de résilience"] = {"RESILIENCE_RATING",},
		["au score de résilience"] = {"RESILIENCE_RATING",},
		["votre score de résilience"] = {"RESILIENCE_RATING",},
		["à la résilience"] = {"RESILIENCE_RATING",},

		["le score de toucher des sorts"] = {"SPELL_HIT_RATING",},
		["score de toucher des sorts"] = {"SPELL_HIT_RATING",},
		["au score de toucher des sorts"] = {"SPELL_HIT_RATING",},
		["votre score de toucher des sorts"] = {"SPELL_HIT_RATING",},


		["le score de coup critique des sorts"] = {"SPELL_CRIT_RATING",},
		["score de coup critique des sorts"] = {"SPELL_CRIT_RATING",},
		["score de critique des sorts"] = {"SPELL_CRIT_RATING",},
		["au score de coup critique des sorts"] = {"SPELL_CRIT_RATING",},
		["au score de critique des sorts"] = {"SPELL_CRIT_RATING",},
		["votre score de coup critique des sorts"] = {"SPELL_CRIT_RATING",},
		["au score de coup critique de sorts"] = {"SPELL_CRIT_RATING",},
		["aux score de coup critique des sorts"] = {"SPELL_CRIT_RATING",},--blizzard! faute d'orthographe!!

		--ToDo
		--["Ranged Hit Rating"] = {"RANGED_HIT_RATING",},
		--["Improves ranged hit rating"] = {"RANGED_HIT_RATING",}, -- ITEM_MOD_HIT_RANGED_RATING
		--["Increases your ranged hit rating"] = {"RANGED_HIT_RATING",},
		["votre score de coup critique à distance"] = {"RANGED_CRIT_RATING",}, -- Fletcher's Gloves ID:7348
		["au score de coup critique à distance"] = {"RANGED_CRIT_RATING",}, -- Enchant given by Heartseeker Scope [41167]

		["score de hâte"] = {"MELEE_HASTE_RATING", "SPELL_HASTE_RATING"},
		["le score de hâte"] = {"MELEE_HASTE_RATING", "SPELL_HASTE_RATING"},
		["au score de hâte"] = {"MELEE_HASTE_RATING", "SPELL_HASTE_RATING"},
		["votre score de hâte"] = {"MELEE_HASTE_RATING", "SPELL_HASTE_RATING"},
		["score de hâte des sorts"] = {"SPELL_HASTE_RATING"},
		["le score de hâte des sorts"] = {"SPELL_HASTE_RATING"},
		["score de hâte à distance"] = {"RANGED_HASTE_RATING"},
		["le score de hâte à distance"] = {"RANGED_HASTE_RATING"},

		["le score de pénétration d'armure"] = {"ARMOR_PENETRATION_RATING"},
		["votre score de pénétration d'armure"] = {"ARMOR_PENETRATION_RATING"},

		["votre score d'expertise"] = {"EXPERTISE_RATING"},
		["le score d'expertise"] = {"EXPERTISE_RATING"},

		["le score de la compétence dagues"] = {"DAGGER_WEAPON_RATING"},
		["score de la compétence dagues"] = {"DAGGER_WEAPON_RATING"},
		["le score de la compétence epées"] = {"SWORD_WEAPON_RATING"},
		["score de la compétence epées"] = {"SWORD_WEAPON_RATING"},
		["le score de la compétence epées à deux mains"] = {"2H_SWORD_WEAPON_RATING"},
		["score de la compétence epées à deux mains"] = {"2H_SWORD_WEAPON_RATING"},
		["le score de la compétence masses"]= {"MACE_WEAPON_RATING"},
		["score de la compétence masses"]= {"MACE_WEAPON_RATING"},
		["le score de la compétence masses à deux mains"]= {"2H_MACE_WEAPON_RATING"},
		["score de la compétence masses à deux mains"]= {"2H_MACE_WEAPON_RATING"},
		["le score de la compétence haches"] = {"AXE_WEAPON_RATING"},
		["score de la compétence haches"] = {"AXE_WEAPON_RATING"},
		["le score de la compétence haches à deux mains"] = {"2H_AXE_WEAPON_RATING"},
		["score de la compétence haches à deux mains"] = {"2H_AXE_WEAPON_RATING"},

		["le score de la compétence armes de pugilat"] = {"FIST_WEAPON_RATING"},
		["le score de compétence combat farouche"] = {"FERAL_WEAPON_RATING"},
		["le score de la compétence mains nues"] = {"FIST_WEAPON_RATING"},

		--ToDo
		--["Increases gun skill rating"] = {"GUN_WEAPON_RATING"},
		--["Increases Crossbow skill rating"] = {"CROSSBOW_WEAPON_RATING"},
		--["Increases Bow skill rating"] = {"BOW_WEAPON_RATING"},

		--ToDo
		-- Exclude
		--["sec"] = false,
		--["to"] = false,
		--["Slot Bag"] = false,
		--["Slot Quiver"] = false,
		--["Slot Ammo Pouch"] = false,
		--["Increases ranged attack speed"] = false, -- AV quiver
	},
}
DisplayLocale.frFR = {
	--ToDo
	----------------
	-- Stat Names --
	----------------
	-- Please localize these strings too, global strings were used in the enUS locale just to have minimum
	-- localization effect when a locale is not available for that language, you don't have to use global
	-- strings in your localization.
  ["Stat Multiplier"] = "Stat Multiplier",
  ["Attack Power Multiplier"] = "Attack Power Multiplier",
  ["Reduced Physical Damage Taken"] = "Reduced Physical Damage Taken",
	["StatIDToName"] = {
		--[StatID] = {FullName, ShortName},
		---------------------------------------------------------------------------
		-- Tier1 Stats - Stats parsed directly off items
		["EMPTY_SOCKET_RED"] = {EMPTY_SOCKET_RED, EMPTY_SOCKET_RED}, -- EMPTY_SOCKET_RED = "Red Socket";
		["EMPTY_SOCKET_YELLOW"] = {EMPTY_SOCKET_YELLOW, EMPTY_SOCKET_YELLOW}, -- EMPTY_SOCKET_YELLOW = "Yellow Socket";
		["EMPTY_SOCKET_BLUE"] = {EMPTY_SOCKET_BLUE, EMPTY_SOCKET_BLUE}, -- EMPTY_SOCKET_BLUE = "Blue Socket";
		["EMPTY_SOCKET_META"] = {EMPTY_SOCKET_META, EMPTY_SOCKET_META}, -- EMPTY_SOCKET_META = "Meta Socket";

		["IGNORE_ARMOR"] = {"Ignore Armor", "Ignore Armor"},
		["STEALTH_LEVEL"] = {"Stealth Level", "Stealth"},
		["MELEE_DMG"] = {"Melee Weapon "..DAMAGE, "Wpn Dmg"}, -- DAMAGE = "Damage"
		["RANGED_DMG"] = {"Ranged Weapon "..DAMAGE, "Ranged Dmg"}, -- DAMAGE = "Damage"
		["MOUNT_SPEED"] = {"Mount Speed(%)", "Mount Spd(%)"},
		["RUN_SPEED"] = {"Run Speed(%)", "Run Spd(%)"},

		["STR"] = {SPELL_STAT1_NAME, "For"},
		["AGI"] = {SPELL_STAT2_NAME, "Agi"},
		["STA"] = {SPELL_STAT3_NAME, "End"},
		["INT"] = {SPELL_STAT4_NAME, "Int"},
		["SPI"] = {SPELL_STAT5_NAME, "Esp"},
		["ARMOR"] = {ARMOR, ARMOR},
		["ARMOR_BONUS"] = {ARMOR.." from bonus", ARMOR.."(Bonus)"},

		["FIRE_RES"] = {RESISTANCE2_NAME, "RF"},
		["NATURE_RES"] = {RESISTANCE3_NAME, "RN"},
		["FROST_RES"] = {RESISTANCE4_NAME, "RG"},
		["SHADOW_RES"] = {RESISTANCE5_NAME, "RO"},
		["ARCANE_RES"] = {RESISTANCE6_NAME, "RA"},

		["FISHING"] = {"Pêche", "Pêche"},
		["MINING"] = {"Minage", "Minage"},
		["HERBALISM"] = {"Herboristerie", "Herboristerie"},
		["SKINNING"] = {"Dépeçage", "Dépeçage"},

		["BLOCK_VALUE"] = {"Valeur de blocage", "Valeur de blocage"},

		["AP"] = {ATTACK_POWER_TOOLTIP, "PA"},
		["RANGED_AP"] = {RANGED_ATTACK_POWER, "PAD"},
		["FERAL_AP"] = {ATTACK_POWER_TOOLTIP.." combat farouche", "PA C. Farouche"},
		["AP_UNDEAD"] = {ATTACK_POWER_TOOLTIP.." (mort-vivant)", "PA(démon)"},
		["AP_DEMON"] = {ATTACK_POWER_TOOLTIP.." (démon)", "PA(démon)"},

		["HEAL"] = {"Soins", "Soin"},

		["SPELL_DMG"] = {PLAYERSTAT_SPELL_COMBAT.." "..DAMAGE, PLAYERSTAT_SPELL_COMBAT.." Dmg"},
		["SPELL_DMG_UNDEAD"] = {PLAYERSTAT_SPELL_COMBAT.." "..DAMAGE.." (mort-vivant)", PLAYERSTAT_SPELL_COMBAT.." Dmg".."(démon)"},
		["SPELL_DMG_DEMON"] = {PLAYERSTAT_SPELL_COMBAT.." "..DAMAGE.." (démon)", PLAYERSTAT_SPELL_COMBAT.." Dmg".."(démon)"},
		["HOLY_SPELL_DMG"] = {SPELL_SCHOOL1_CAP.." "..DAMAGE, SPELL_SCHOOL1_CAP.." Dmg"},
		["FIRE_SPELL_DMG"] = {SPELL_SCHOOL2_CAP.." "..DAMAGE, SPELL_SCHOOL2_CAP.." Dmg"},
		["NATURE_SPELL_DMG"] = {SPELL_SCHOOL3_CAP.." "..DAMAGE, SPELL_SCHOOL3_CAP.." Dmg"},
		["FROST_SPELL_DMG"] = {SPELL_SCHOOL4_CAP.." "..DAMAGE, SPELL_SCHOOL4_CAP.." Dmg"},
		["SHADOW_SPELL_DMG"] = {SPELL_SCHOOL5_CAP.." "..DAMAGE, SPELL_SCHOOL5_CAP.." Dmg"},
		["ARCANE_SPELL_DMG"] = {SPELL_SCHOOL6_CAP.." "..DAMAGE, SPELL_SCHOOL6_CAP.." Dmg"},

		["SPELLPEN"] = {PLAYERSTAT_SPELL_COMBAT.." "..SPELL_PENETRATION, SPELL_PENETRATION},

		["HEALTH"] = {HEALTH, HP},
		["MANA"] = {MANA, MP},
		["HEALTH_REG"] = {"Regen "..HEALTH, "HP5"},
		["MANA_REG"] = {"Regen "..MANA, "MP5"},

		["MAX_DAMAGE"] = {"Dégât max", "Dmg max"},
		["DPS"] = {"Dégâts par seconde", "DPS"},

		["DEFENSE_RATING"] = {COMBAT_RATING_NAME2, COMBAT_RATING_NAME2}, -- COMBAT_RATING_NAME2 = "Defense Rating"
		["DODGE_RATING"] = {COMBAT_RATING_NAME3, COMBAT_RATING_NAME3}, -- COMBAT_RATING_NAME3 = "Dodge Rating"
		["PARRY_RATING"] = {COMBAT_RATING_NAME4, COMBAT_RATING_NAME4}, -- COMBAT_RATING_NAME4 = "Parry Rating"
		["BLOCK_RATING"] = {COMBAT_RATING_NAME5, COMBAT_RATING_NAME5}, -- COMBAT_RATING_NAME5 = "Block Rating"
		["MELEE_HIT_RATING"] = {COMBAT_RATING_NAME6, COMBAT_RATING_NAME6}, -- COMBAT_RATING_NAME6 = "Hit Rating"
		["RANGED_HIT_RATING"] = {PLAYERSTAT_RANGED_COMBAT.." "..COMBAT_RATING_NAME6, PLAYERSTAT_RANGED_COMBAT.." "..COMBAT_RATING_NAME6}, -- PLAYERSTAT_RANGED_COMBAT = "Ranged"
		["SPELL_HIT_RATING"] = {PLAYERSTAT_SPELL_COMBAT.." "..COMBAT_RATING_NAME6, PLAYERSTAT_SPELL_COMBAT.." "..COMBAT_RATING_NAME6}, -- PLAYERSTAT_SPELL_COMBAT = "Spell"
		["MELEE_HIT_AVOID_RATING"] = {"Hit Avoidance "..RATING, "Hit Avoidance "..RATING},
		["RANGED_HIT_AVOID_RATING"] = {PLAYERSTAT_RANGED_COMBAT.." Hit Avoidance "..RATING, PLAYERSTAT_RANGED_COMBAT.." Hit Avoidance "..RATING},
		["SPELL_HIT_AVOID_RATING"] = {PLAYERSTAT_SPELL_COMBAT.." Hit Avoidance "..RATING, PLAYERSTAT_SPELL_COMBAT.." Hit Avoidance "..RATING},
		["MELEE_CRIT_RATING"] = {COMBAT_RATING_NAME9, COMBAT_RATING_NAME9}, -- COMBAT_RATING_NAME9 = "Crit Rating"
		["RANGED_CRIT_RATING"] = {COMBAT_RATING_NAME9.." "..PLAYERSTAT_RANGED_COMBAT, COMBAT_RATING_NAME9.." "..PLAYERSTAT_RANGED_COMBAT},
		["SPELL_CRIT_RATING"] = {PLAYERSTAT_SPELL_COMBAT.." "..COMBAT_RATING_NAME9, PLAYERSTAT_SPELL_COMBAT.." "..COMBAT_RATING_NAME9},
		["MELEE_CRIT_AVOID_RATING"] = {"Crit Avoidance "..RATING, "Crit Avoidance "..RATING},
		["RANGED_CRIT_AVOID_RATING"] = {PLAYERSTAT_RANGED_COMBAT.." Crit Avoidance "..RATING, PLAYERSTAT_RANGED_COMBAT.." Crit Avoidance "..RATING},
		["SPELL_CRIT_AVOID_RATING"] = {PLAYERSTAT_SPELL_COMBAT.." Crit Avoidance "..RATING, PLAYERSTAT_SPELL_COMBAT.." Crit Avoidance "..RATING},
		["RESILIENCE_RATING"] = {COMBAT_RATING_NAME15, COMBAT_RATING_NAME15}, -- COMBAT_RATING_NAME15 = "Resilience"
		["MELEE_HASTE_RATING"] = {"Hâte "..RATING, "Hâte "..RATING}, --
		["RANGED_HASTE_RATING"] = {"Hâte "..PLAYERSTAT_RANGED_COMBAT..RATING, "Hâte "..PLAYERSTAT_RANGED_COMBAT..RATING},
		["SPELL_HASTE_RATING"] = {"Hâte "..PLAYERSTAT_SPELL_COMBAT..RATING, "Hâte "..PLAYERSTAT_SPELL_COMBAT..RATING},
		["DAGGER_WEAPON_RATING"] = {"Dague "..SKILL.." "..RATING, "Dague "..RATING}, -- SKILL = "Skill"
		["SWORD_WEAPON_RATING"] = {"Epée "..SKILL.." "..RATING, "Epée "..RATING},
		["2H_SWORD_WEAPON_RATING"] = {"Two-Handed Sword "..SKILL.." "..RATING, "2H Sword "..RATING},
		["AXE_WEAPON_RATING"] = {"Hache "..SKILL.." "..RATING, "Hache "..RATING},
		["2H_AXE_WEAPON_RATING"] = {"Two-Handed Axe "..SKILL.." "..RATING, "2H Axe "..RATING},
		["MACE_WEAPON_RATING"] = {"Masse "..SKILL.." "..RATING, "Masse "..RATING},
		["2H_MACE_WEAPON_RATING"] = {"Two-Handed Mace "..SKILL.." "..RATING, "2H Mace "..RATING},
		["GUN_WEAPON_RATING"] = {"Arme à feu "..SKILL.." "..RATING, "Arme à feu "..RATING},
		["CROSSBOW_WEAPON_RATING"] = {"Arbalète "..SKILL.." "..RATING, "Arbalète "..RATING},
		["BOW_WEAPON_RATING"] = {"Arc "..SKILL.." "..RATING, "Arc "..RATING},
		["FERAL_WEAPON_RATING"] = {"Feral "..SKILL.." "..RATING, "Feral "..RATING},
		["FIST_WEAPON_RATING"] = {"Unarmed "..SKILL.." "..RATING, "Unarmed "..RATING},
		["EXPERTISE_RATING"] = {"Expertise".." "..RATING, "Expertise".." "..RATING},
		["ARMOR_PENETRATION_RATING"] = {"Pénétration d'armure".." "..RATING, "ArP".." "..RATING},

		---------------------------------------------------------------------------
		-- Tier2 Stats - Stats that only show up when broken down from a Tier1 stat
		-- Str -> AP, Block Value
		-- Agi -> AP, Crit, Dodge
		-- Sta -> Health
		-- Int -> Mana, Spell Crit
		-- Spi -> mp5nc, hp5oc
		-- Ratings -> Effect
		["HEALTH_REG_OUT_OF_COMBAT"] = {"Regen vie (hors combat)", "HP5(HC)"},
		["MANA_REG_NOT_CASTING"] = {"Regen mana (hors cast)", "MP5(HC)"},
		["MELEE_CRIT_DMG_REDUCTION"] = {"Réduction des dégâts critiques(%)", "Réduc dmg crit(%)"},
		["RANGED_CRIT_DMG_REDUCTION"] = {"Réduction des dégâts à distance critiques(%)", "Réduc dmg crit disc(%)"},
		["SPELL_CRIT_DMG_REDUCTION"] = {"Réduction des dégâts des sorts critiques(%)", "Réduc dmg crit sorts(%)"},
		["DEFENSE"] = {DEFENSE, "Def"},
		["DODGE"] = {DODGE.."(%)", DODGE.."(%)"},
		["PARRY"] = {PARRY.."(%)", PARRY.."(%)"},
		["BLOCK"] = {BLOCK.."(%)", BLOCK.."(%)"},
		["MELEE_HIT"] = {"Toucher(%)", "Toucher(%)"},
		["RANGED_HIT"] = {"Toucher à distance(%)", "Toucher à distance (%)"},
		["SPELL_HIT"] = {"Toucher des sorts(%)", "Toucher des sorts (%)"},
		["MELEE_HIT_AVOID"] = {"Evitement(%)", "Evt(%)"},
		["RANGED_HIT_AVOID"] = {"Evitement à distance(%)", "Evt dist(%)"},
		["SPELL_HIT_AVOID"] = {"Evitement des sorts(%)", "Evt sorts(%)"},
		["MELEE_CRIT"] = {"Critique(%)", "Crit(%)"},
		["RANGED_CRIT"] = {"Critique à distance(%)", "Crit dist(%)"},
		["SPELL_CRIT"] = {"Critique des sorts(%)", "Crit sorts(%)"},
		["MELEE_CRIT_AVOID"] = {"Evitement des critiques(%)", "Evt crit(%)"},
		["RANGED_CRIT_AVOID"] = {"Evitement des critiques à distance(%)", "Evt crit dist(%)"},
		["SPELL_CRIT_AVOID"] = {"Evitement des critiques des sorts(%)", "Evt crit sorts(%)"},
		["MELEE_HASTE"] = {"Hâte(%)", "Hâte(%)"},
		["RANGED_HASTE"] = {"Hâte à distance(%)", "Hâte dist(%)"},
		["SPELL_HASTE"] = {"Hâte des sorts(%)", "Hâte sorts(%)"},
		["DAGGER_WEAPON"] = {"Compétence de dague", "Dague"},
		["SWORD_WEAPON"] = {"Compétence de d'épée", "Epée"},
		["2H_SWORD_WEAPON"] = {"Compétence d'épée à deux mains", "Epée 2M"},
		["AXE_WEAPON"] = {"Compétence de hache", "Hache"},
		["2H_AXE_WEAPON"] = {"Compétence de hache à deux mains", "Hache 2M"},
		["MACE_WEAPON"] = {"Compétence de masse", "Masse"},
		["2H_MACE_WEAPON"] = {"Compétence de masse à deux mains", "Masse 2M"},
		["GUN_WEAPON"] = {"Compétence d'arme à feu", "Arme à feu"},
		["CROSSBOW_WEAPON"] = {"Compétence d'arbalète", "Arbalète"},
		["BOW_WEAPON"] = {"Compétence d'arc", "Arc"},
		["FERAL_WEAPON"] = {"Feral "..SKILL, "Feral"},
		["FIST_WEAPON"] = {"Unarmed "..SKILL, "Unarmed"},
		["EXPERTISE"] = {"Expertise", "Expertise"},
		["ARMOR_PENETRATION"] = {"Pénétration d'armure(%)", "PenAr(%)"},

		---------------------------------------------------------------------------
		-- Tier3 Stats - Stats that only show up when broken down from a Tier2 stat
		-- Defense -> Crit Avoidance, Hit Avoidance, Dodge, Parry, Block
		-- Weapon Skill -> Crit, Hit, Dodge Neglect, Parry Neglect, Block Neglect
		["DODGE_NEGLECT"] = {DODGE.." Neglect(%)", DODGE.." Neglect(%)"},
		["PARRY_NEGLECT"] = {PARRY.." Neglect(%)", PARRY.." Neglect(%)"},
		["BLOCK_NEGLECT"] = {BLOCK.." Neglect(%)", BLOCK.." Neglect(%)"},

		---------------------------------------------------------------------------
		-- Talents
		["MELEE_CRIT_DMG"] = {"Crit Damage(%)", "Crit Dmg(%)"},
		["RANGED_CRIT_DMG"] = {PLAYERSTAT_RANGED_COMBAT.." Crit Damage(%)", PLAYERSTAT_RANGED_COMBAT.." Crit Dmg(%)"},
		["SPELL_CRIT_DMG"] = {PLAYERSTAT_SPELL_COMBAT.." Crit Damage(%)", PLAYERSTAT_SPELL_COMBAT.." Crit Dmg(%)"},

		---------------------------------------------------------------------------
		-- Spell Stats
		-- These values can be prefixed with a @ and spell name, using reverse translation to english from Babble-Spell-2.2
		-- ex: "Heroic Strike@RAGE_COST" for Heroic Strike rage cost
		-- ex: "Heroic Strike@THREAT" for Heroic Strike threat value
		-- Use strsplit("@", text) to seperate the spell name and statid
		["THREAT"] = {"Menace", "Menace"},
		["CAST_TIME"] = {"Temps d'incantation", "Tps incant"},
		["MANA_COST"] = {"Coût en mana", "Coût mana"},
		["RAGE_COST"] = {"Coût en rage", "Coût rage"},
		["ENERGY_COST"] = {"Coût en énergie", "Coût énergie"},
		["COOLDOWN"] = {"Cooldown", "CD"},

		---------------------------------------------------------------------------
		-- Stats Mods
		["MOD_STR"] = {"Mod "..SPELL_STAT1_NAME.."(%)", "Mod Str(%)"},
		["MOD_AGI"] = {"Mod "..SPELL_STAT2_NAME.."(%)", "Mod Agi(%)"},
		["MOD_STA"] = {"Mod "..SPELL_STAT3_NAME.."(%)", "Mod Sta(%)"},
		["MOD_INT"] = {"Mod "..SPELL_STAT4_NAME.."(%)", "Mod Int(%)"},
		["MOD_SPI"] = {"Mod "..SPELL_STAT5_NAME.."(%)", "Mod Spi(%)"},
		["MOD_HEALTH"] = {"Mod "..HEALTH.."(%)", "Mod "..HP.."(%)"},
		["MOD_MANA"] = {"Mod "..MANA.."(%)", "Mod "..MP.."(%)"},
		["MOD_ARMOR"] = {"Mod "..ARMOR.."from Items".."(%)", "Mod "..ARMOR.."(Items)".."(%)"},
		["MOD_BLOCK_VALUE"] = {"Mod Block Value".."(%)", "Mod Block Value".."(%)"},
		["MOD_DMG"] = {"Mod Damage".."(%)", "Mod Dmg".."(%)"},
		["MOD_DMG_TAKEN"] = {"Mod Damage Taken".."(%)", "Mod Dmg Taken".."(%)"},
		["MOD_CRIT_DAMAGE"] = {"Mod Crit Damage".."(%)", "Mod Crit Dmg".."(%)"},
		["MOD_CRIT_DAMAGE_TAKEN"] = {"Mod Crit Damage Taken".."(%)", "Mod Crit Dmg Taken".."(%)"},
		["MOD_THREAT"] = {"Mod Threat".."(%)", "Mod Threat".."(%)"},
		["MOD_AP"] = {"Mod "..ATTACK_POWER_TOOLTIP.."(%)", "Mod AP".."(%)"},
		["MOD_RANGED_AP"] = {"Mod "..PLAYERSTAT_RANGED_COMBAT.." "..ATTACK_POWER_TOOLTIP.."(%)", "Mod RAP".."(%)"},
		["MOD_SPELL_DMG"] = {"Mod "..PLAYERSTAT_SPELL_COMBAT.." "..DAMAGE.."(%)", "Mod "..PLAYERSTAT_SPELL_COMBAT.." Dmg".."(%)"},
		["MOD_HEALING"] = {"Mod Healing".."(%)", "Mod Heal".."(%)"},
		["MOD_CAST_TIME"] = {"Mod Casting Time".."(%)", "Mod Cast Time".."(%)"},
		["MOD_MANA_COST"] = {"Mod Mana Cost".."(%)", "Mod Mana Cost".."(%)"},
		["MOD_RAGE_COST"] = {"Mod Rage Cost".."(%)", "Mod Rage Cost".."(%)"},
		["MOD_ENERGY_COST"] = {"Mod Energy Cost".."(%)", "Mod Energy Cost".."(%)"},
		["MOD_COOLDOWN"] = {"Mod Cooldown".."(%)", "Mod CD".."(%)"},

		---------------------------------------------------------------------------
		-- Misc Stats
		["WEAPON_RATING"] = {"Weapon "..SKILL.." "..RATING, "Weapon"..SKILL.." "..RATING},
		["WEAPON_SKILL"] = {"Weapon "..SKILL, "Weapon"..SKILL},
		["MAINHAND_WEAPON_RATING"] = {"Main Hand Weapon "..SKILL.." "..RATING, "MH Weapon"..SKILL.." "..RATING},
		["OFFHAND_WEAPON_RATING"] = {"Off Hand Weapon "..SKILL.." "..RATING, "OH Weapon"..SKILL.." "..RATING},
		["RANGED_WEAPON_RATING"] = {"Ranged Weapon "..SKILL.." "..RATING, "Ranged Weapon"..SKILL.." "..RATING},
	},
}

-- zhCN localization by iceburn
PatternLocale.zhCN = {
	["tonumber"] = tonumber,
	-----------------
	-- Armor Types --
	-----------------
	Plate = "板甲",
	Mail = "锁甲",
	Leather = "皮甲",
	Cloth = "布甲",
	------------------
	-- Fast Exclude --
	------------------
	-- By looking at the first ExcludeLen letters of a line we can exclude a lot of lines
	["ExcludeLen"] = 3, -- using string.utf8len
	["Exclude"] = {
		[""] = true,
		[" \n"] = true,
		[ITEM_BIND_ON_EQUIP] = true, -- ITEM_BIND_ON_EQUIP = "Binds when equipped"; -- Item will be bound when equipped
		[ITEM_BIND_ON_PICKUP] = true, -- ITEM_BIND_ON_PICKUP = "Binds when picked up"; -- Item wil be bound when picked up
		[ITEM_BIND_ON_USE] = true, -- ITEM_BIND_ON_USE = "Binds when used"; -- Item will be bound when used
		[ITEM_BIND_QUEST] = true, -- ITEM_BIND_QUEST = "Quest Item"; -- Item is a quest item (same logic as ON_PICKUP)
		[ITEM_SOULBOUND] = true, -- ITEM_SOULBOUND = "Soulbound"; -- Item is Soulbound
		[ITEM_STARTS_QUEST] = true, -- ITEM_STARTS_QUEST = "This Item Begins a Quest"; -- Item is a quest giver
		[ITEM_CANT_BE_DESTROYED] = true, -- ITEM_CANT_BE_DESTROYED = "That item cannot be destroyed."; -- Attempted to destroy a NO_DESTROY item
		[ITEM_CONJURED] = true, -- ITEM_CONJURED = "Conjured Item"; -- Item expires
		[ITEM_DISENCHANT_NOT_DISENCHANTABLE] = true, -- ITEM_DISENCHANT_NOT_DISENCHANTABLE = "Cannot be disenchanted"; -- Items which cannot be disenchanted ever
		["分解"] = true, -- ITEM_DISENCHANT_ANY_SKILL = "Disenchantable"; -- Items that can be disenchanted at any skill level
		["分解需"] = true, -- ITEM_DISENCHANT_MIN_SKILL = "Disenchanting requires %s (%d)"; -- Minimum enchanting skill needed to disenchant
		["持续时"] = true, -- ITEM_DURATION_DAYS = "Duration: %d days";
		["<由%s"] = true, -- ITEM_CREATED_BY = "|cff00ff00<Made by %s>|r"; -- %s is the creator of the item
		["冷却时"] = true, -- ITEM_COOLDOWN_TIME_DAYS = "Cooldown remaining: %d day";
		["装备唯"] = true, -- Unique-Equipped
		["唯一"] = true, -- ITEM_UNIQUE = "Unique";
		["唯一("] = true, -- ITEM_UNIQUE_MULTIPLE = "Unique (%d)";
		["需要等"] = true, -- Requires Level xx
		["需要 "] = true, -- Requires Level xx
		["需要锻"] = true, -- Requires Level xx
		["\n需要"] = true, -- Requires Level xx
		["职业："] = true, -- Classes: xx
		["种族："] = true, -- Races: xx (vendor mounts)
		["使用："] = true, -- Use:
		["击中时"] = true, -- Chance On Hit:
		-- Set Bonuses
		-- ITEM_SET_BONUS = "Set: %s";
		-- ITEM_SET_BONUS_GRAY = "(%d) Set: %s";
		-- ITEM_SET_NAME = "%s (%d/%d)"; -- Set name (2/5)
		["套装："] = true,
		["(2) 套装"] = true,
		["(3) 套装"] = true,
		["(4) 套装"] = true,
		["(5) 套装"] = true,
		["(6) 套装"] = true,
		["(7) 套装"] = true,
		["(8) 套装"] = true,
		-- Equip type
		["弹药"] = true, -- Ice Threaded Arrow ID:19316
		[INVTYPE_AMMO] = true,
		[INVTYPE_HEAD] = true,
		[INVTYPE_NECK] = true,
		[INVTYPE_SHOULDER] = true,
		[INVTYPE_BODY] = true,
		[INVTYPE_CHEST] = true,
		[INVTYPE_ROBE] = true,
		[INVTYPE_WAIST] = true,
		[INVTYPE_LEGS] = true,
		[INVTYPE_FEET] = true,
		[INVTYPE_WRIST] = true,
		[INVTYPE_HAND] = true,
		[INVTYPE_FINGER] = true,
		[INVTYPE_TRINKET] = true,
		[INVTYPE_CLOAK] = true,
		[INVTYPE_WEAPON] = true,
		[INVTYPE_SHIELD] = true,
		[INVTYPE_2HWEAPON] = true,
		[INVTYPE_WEAPONMAINHAND] = true,
		[INVTYPE_WEAPONOFFHAND] = true,
		[INVTYPE_HOLDABLE] = true,
		[INVTYPE_RANGED] = true,
		[INVTYPE_THROWN] = true,
		[INVTYPE_RANGEDRIGHT] = true,
		[INVTYPE_RELIC] = true,
		[INVTYPE_TABARD] = true,
		[INVTYPE_BAG] = true,
	},
	--[[
	textTable = {
		"法术伤害 +6 及法术命中等级 +5",
		"+3  耐力, +4 爆击等级",
		"++26 治疗法术 & 降低2% 威胁值",
		"+3 耐力/+4 爆击等级",
		"插槽加成:每5秒+2法力",
		"装备: 使所有法术和魔法效果所造成的伤害和治疗效果提高最多150点。",
		"装备: 使半径30码范围内所有小队成员的法术爆击等级提高28点。",
		"装备: 使30码范围内的所有队友提高所有法术和魔法效果所造成的伤害和治疗效果，最多33点。",
		"装备: 使周围半径30码范围内队友的所有法术和魔法效果所造成的治疗效果提高最多62点。",
		"装备: 使你的法术伤害提高最多120点，以及你的治疗效果最多300点。",
		"装备: 使周围半径30码范围内的队友每5秒恢复11点法力。",
		"装备: 使法术所造成的治疗效果提高最多300点。",
		"装备: 在猎豹、熊、巨熊和枭兽形态下的攻击强度提高420点。",
		-- "+10 Defense Rating/+10 Stamina/+15 Block Value": ZG Enchant
		-- "+26 Attack Power and +14 Critical Strike Rating": Swift Windfire Diamond ID:28556
		-- "+26 Healing Spells & 2% Reduced Threat": Bracing Earthstorm Diamond ID:25897
		-- "+6 Spell Damage, +5 Spell Crit Rating": Potent Ornate Topaz ID: 28123
		----
		-- "Critical Rating +6 and Dodge Rating +5": Assassin's Fire Opal ID:30565
		-- "Healing +11 and 2 mana per 5 sec.": Royal Tanzanite ID: 30603
	}
	--]]
	-----------------------
	-- Whole Text Lookup --
	-----------------------
	-- Mainly used for enchants that doesn't have numbers in the text
	["WholeTextLookup"] = {
		[EMPTY_SOCKET_RED] = {["EMPTY_SOCKET_RED"] = 1}, -- EMPTY_SOCKET_RED = "Red Socket";
		[EMPTY_SOCKET_YELLOW] = {["EMPTY_SOCKET_YELLOW"] = 1}, -- EMPTY_SOCKET_YELLOW = "Yellow Socket";
		[EMPTY_SOCKET_BLUE] = {["EMPTY_SOCKET_BLUE"] = 1}, -- EMPTY_SOCKET_BLUE = "Blue Socket";
		[EMPTY_SOCKET_META] = {["EMPTY_SOCKET_META"] = 1}, -- EMPTY_SOCKET_META = "Meta Socket";

		["野性"] = {["AP"] = 70}, --

		["初级巫师之油"] = {["SPELL_DMG"] = 8, ["HEAL"] = 8}, --
		["次级巫师之油"] = {["SPELL_DMG"] = 16, ["HEAL"] = 16}, --
		["巫师之油"] = {["SPELL_DMG"] = 24, ["HEAL"] = 24}, --
		["卓越巫师之油"] = {["SPELL_DMG"] = 36, ["HEAL"] = 36, ["SPELL_CRIT_RATING"] = 14}, --
		["神圣巫师之油"] = {["SPELL_DMG_UNDEAD"] = 60}, --

		["超强法力之油"] = {["MANA_REG"] = 14}, --
		["初级法力之油"] = {["MANA_REG"] = 4}, --
		["次级法力之油"] = {["MANA_REG"] = 8}, --
		["卓越法力之油"] = {["MANA_REG"] = 12, ["HEAL"] = 25}, --
		["超强巫师之油"] = {["SPELL_DMG"] = 42, ["HEAL"] = 42}, --

		["恒金渔线"] = {["FISHING"] = 5}, --
		["活力"] = {["MANA_REG"] = 4, ["HEALTH_REG"] = 4}, --
		["魂霜"] = {["SHADOW_SPELL_DMG"] = 54, ["FROST_SPELL_DMG"] = 54}, --
		["阳炎"] = {["ARCANE_SPELL_DMG"] = 50, ["FIRE_SPELL_DMG"] = 50}, --
		["+40 法术伤害"] = {["SPELL_DMG"] = 40, ["HEAL"] = 40}, --
		["+30 法术伤害"] = {["SPELL_DMG"] = 30, ["HEAL"] = 30}, --

		["秘银马刺"] = {["MOUNT_SPEED"] = 4}, -- Mithril Spurs
		["坐骑移动速度略微提升"] = {["MOUNT_SPEED"] = 2}, -- Enchant Gloves - Riding Skill
		["装备： 略微提高移动速度。"] = {["RUN_SPEED"] = 8}, -- [Highlander's Plate Greaves] ID: 20048
		["移动速度略微提升"] = {["RUN_SPEED"] = 8}, --
		["略微提高奔跑速度"] = {["RUN_SPEED"] = 8}, --
		["移动速度略微提升"] = {["RUN_SPEED"] = 8}, -- Enchant Boots - Minor Speed
		["初级速度"] = {["RUN_SPEED"] = 8}, -- Enchant Boots - Minor Speed
		["稳固"] = {["MELEE_HIT_RATING"] = 10}, -- Enchant Boots - Surefooted "Surefooted"

		["狡诈"] = {["MOD_THREAT"] = -2}, -- Enchant Cloak - Subtlety
		["威胁减少2%"] = {["MOD_THREAT"] = -2}, -- StatLogic:GetSum("item:23344:2832")
		["装备： 使你可以在水下呼吸。"] = false, -- [Band of Icy Depths] ID: 21526
		["使你可以在水下呼吸"] = false, --
		["装备： 免疫缴械。"] = false, -- [Stronghold Gauntlets] ID: 12639
		["免疫缴械"] = false, --
		["十字军"] = false, -- Enchant Crusader
		["生命偷取"] = false, -- Enchant Crusader


		["海象人的活力"] = {["RUN_SPEED"] = 8, ["STA"] = 15}, -- EnchantID: 3232
		["智慧"] = {["MOD_THREAT"] = -2, ["SPI"] = 10}, -- EnchantID: 3296
		["精确"] = {["MELEE_HIT_RATING"] = 25, ["SPELL_HIT_RATING"] = 25, ["MELEE_CRIT_RATING"] = 25, ["SPELL_CRIT_RATING"] = 25}, -- EnchantID: 3788
		["天灾斩除"] = {["AP_UNDEAD"] = 140}, -- EnchantID: 3247
		["履冰"] = {["MELEE_HIT_RATING"] = 12, ["SPELL_HIT_RATING"] = 12, ["MELEE_CRIT_RATING"] = 12, ["SPELL_CRIT_RATING"] = 12}, -- EnchantID: 3826
		["采集"] = {["HERBALISM"] = 5, ["MINING"] = 5, ["SKINNING"] = 5}, -- EnchantID: 3238
		["强效活力"] = {["MANA_REG"] = 6, ["HEALTH_REG"] = 6}, -- EnchantID: 3244
	},
	----------------------------
	-- Single Plus Stat Check --
	----------------------------
	-- depending on locale, it may be
	-- +19 Stamina = "^%+(%d+) ([%a ]+%a)$"
	-- Stamina +19 = "^([%a ]+%a) %+(%d+)$"
	-- +19 耐力 = "^%+(%d+) (.-)$"
	-- Some have a "." at the end of string like:
	-- Enchant Chest - Restore Mana Prime "+6 mana every 5 sec. "
	["SinglePlusStatCheck"] = "^([%+%-]%d+) (.-)$",
	-----------------------------
	-- Single Equip Stat Check --
	-----------------------------
	-- stat1, value, stat2 = strfind
	-- stat = stat1..stat2
	-- "^Equip: (.-) by u?p? ?t?o? ?(%d+) ?(.-)%.$"
	--装备: 增加法术命中等级 11点。
	--装备: 提高所有法术和魔法效果所造成的伤害和治疗效果，最多46点。
	--"装备： (.-)提高(最多)?(%d+)(点)?(.-)。$",
	["SingleEquipStatCheck"] = "装备： (.-)(%d+)点(.-)。$",
	-------------
	-- PreScan --
	-------------
	-- Special cases that need to be dealt with before base scan
	["PreScanPatterns"] = {
		["^装备: 猫形态下的攻击强度增加(%d+)"] = "FERAL_AP",
		["^装备: 与亡灵作战时的攻击强度提高(%d+)点"] = "AP_UNDEAD", -- Seal of the Dawn ID:13029
		["^(%d+)格挡$"] = "BLOCK_VALUE",
		["^(%d+)点护甲$"] = "ARMOR",
		["强化护甲 %+(%d+)"] = "ARMOR_BONUS",
		["护甲值提高(%d+)点"] = "ARMOR_BONUS",
		["每5秒恢复(%d+)点法力值。$"] = "MANA_REG",
		["每5秒恢复(%d+)点生命值。$"] = "HEALTH_REG",
		["每5秒回复(%d+)点法力值。$"] = "MANA_REG",
		["每5秒回复(%d+)点法力值$"] = "MANA_REG",
		["每5秒回复(%d+)点生命值。$"] = "HEALTH_REG",
		["^%+?%d+ %- (%d+).-伤害$"] = "MAX_DAMAGE",
		["^（每秒伤害([%d%.]+)）$"] = "DPS",
		-- Exclude
		["^(%d+)格.-包"] = false, -- # of slots and bag type
		["^(%d+)格.-袋"] = false, -- # of slots and bag type
		["^(%d+)格容器"] = false, -- # of slots and bag type
		["^.+（(%d+)/%d+）$"] = false, -- Set Name (0/9)
		["|cff808080"] = false, -- Gray text "  |cff808080Requires at least 2 Yellow gems|r\n  |cff808080Requires at least 1 Red gem|r"
		-- Procs
		--["几率"] = false, --[挑战印记] ID:27924
		--["机率"] = false,
		--["有一定几率"] = false, -- [Mark of Defiance] ID:27924 -- [Staff of the Qiraji Prophets] ID:21128 --+12智力, 施法时有一定几率回复法力 gem ID:2835
		["有可能"] = false, -- [Darkmoon Card: Heroism] ID:19287
		["命中时"] = false, -- [黑色摧毁者手套] ID:22194
		["被击中之后"] = false, -- [Essence of the Pure Flame] ID: 18815
		["在杀死一个敌人"] = false, -- [注入精华的蘑菇] ID:28109
		["每当你的"] = false, -- [电光相容器] ID: 28785
		["被击中时"] = false, --
		["你每施放一次法术，此增益的效果就降低17点伤害和34点治疗效果"] = false, --赞达拉英雄护符 ID:19950
	},
	--------------
	-- DeepScan --
	--------------
	-- Strip leading "Equip: ", "Socket Bonus: "
	["Equip: "] = "装备: ", -- ITEM_SPELL_TRIGGER_ONEQUIP = "Equip:";
	["Socket Bonus: "] = "镶孔奖励: ", -- ITEM_SOCKET_BONUS = "Socket Bonus: %s"; -- Tooltip tag for socketed item matched socket bonuses
	-- Strip trailing "."
	["."] = "。",
	["DeepScanSeparators"] = {
		"/", -- "+10 Defense Rating/+10 Stamina/+15 Block Value": ZG Enchant
		" & ", -- "+26 Healing Spells & 2% Reduced Threat": Bracing Earthstorm Diamond ID:25897
		", ", -- "+6 Spell Damage, +5 Spell Crit Rating": Potent Ornate Topaz ID: 28123
		"、", -- 防御者雕文
		"。",
	},
	["DeepScanWordSeparators"] = {
		"及", "和", "并", "，","以及", "持续 "-- [发光的暗影卓奈石] ID:25894 "+24 攻击强度及略微提高奔跑速度", [刺客的火焰蛋白石] ID:30565 "爆击等级 +6 及躲闪等级 +5"
	},
	["DualStatPatterns"] = { -- all lower case
		["^%+(%d+)治疗和%+(%d+)法术伤害$"] = {{"HEAL",}, {"SPELL_DMG",},},
		["^%+(%d+)治疗和%+(%d+)法术伤害及"] = {{"HEAL",}, {"SPELL_DMG",},},
		["^使法术治疗提高最多(%d+)点，法术伤害提高最多(%d+)点$"] = {{"HEAL",}, {"SPELL_DMG",},},
	},
	["DeepScanPatterns"] = {
		"^(.-)提高最多([%d%.]+)点(.-)$", --
		"^(.-)提高最多([%d%.]+)(.-)$", --
		"^(.-)，最多([%d%.]+)点(.-)$", --
		"^(.-)，最多([%d%.]+)(.-)$", --
		"^(.-)最多([%d%.]+)点(.-)$", --
		"^(.-)最多([%d%.]+)(.-)$", --
		"^(.-)提高([%d%.]+)点(.-)$", --
		"^(.-)提高([%d%.]+)(.-)$", --
		"^(.-)([%d%.]+)点(.-)$", --
		"^(.-) ?([%+%-][%d%.]+) ?点(.-)$", --
		"^(.-) ?([%+%-][%d%.]+) ?(.-)$", --
		"^(.-) ?([%d%.]+) ?点(.-)$", --
		"^(.-) ?([%d%.]+) ?(.-)$", --
	},
	-----------------------
	-- Stat Lookup Table --
	-----------------------
	["StatIDLookup"] = {
		["你的攻击无视目标的点护甲值"] = {"IGNORE_ARMOR"}, -- StatLogic:GetSum("item:33733")
		["% 威胁"] = {"MOD_THREAT"}, -- StatLogic:GetSum("item:23344:2613")
		["使你的潜行等级提高"] = {"STEALTH_LEVEL"}, -- [Nightscape Boots] ID: 8197
		["潜行"] = {"STEALTH_LEVEL"}, -- Cloak Enchant
		["武器伤害"] = {"MELEE_DMG"}, -- Enchant
		["近战伤害"] = {"MELEE_DMG"}, -- Enchant
		["使坐骑速度提高%"] = {"MOUNT_SPEED"}, -- [Highlander's Plate Greaves] ID: 20048
		["坐骑速度"] = {"MOUNT_SPEED"}, -- [Highlander's Plate Greaves] ID: 20048

		["所有属性"] = {"STR", "AGI", "STA", "INT", "SPI",},
		["力量"] = {"STR",},
		["敏捷"] = {"AGI",},
		["耐力"] = {"STA",},
		["智力"] = {"INT",},
		["精神"] = {"SPI",},

		["奥术抗性"] = {"ARCANE_RES",},
		["火焰抗性"] = {"FIRE_RES",},
		["自然抗性"] = {"NATURE_RES",},
		["冰霜抗性"] = {"FROST_RES",},
		["暗影抗性"] = {"SHADOW_RES",},
		["阴影抗性"] = {"SHADOW_RES",}, -- Demons Blood ID: 10779
		["所有抗性"] = {"ARCANE_RES", "FIRE_RES", "FROST_RES", "NATURE_RES", "SHADOW_RES",},
		["全部抗性"] = {"ARCANE_RES", "FIRE_RES", "FROST_RES", "NATURE_RES", "SHADOW_RES",},
		["抵抗全部"] = {"ARCANE_RES", "FIRE_RES", "FROST_RES", "NATURE_RES", "SHADOW_RES",},
		["点所有魔法抗性"] = {"ARCANE_RES", "FIRE_RES", "FROST_RES", "NATURE_RES", "SHADOW_RES",}, -- [锯齿黑曜石之盾] ID:22198

		["钓鱼"] = {"FISHING",}, -- Fishing enchant ID:846
		["钓鱼技能"] = {"FISHING",}, -- Fishing lure
		["使钓鱼技能"] = {"FISHING",}, -- Equip: Increased Fishing +20.
		["采矿"] = {"MINING",}, -- Mining enchant ID:844
		["草药学"] = {"HERBALISM",}, -- Heabalism enchant ID:845
		["剥皮"] = {"SKINNING",}, -- Skinning enchant ID:865

		["护甲"] = {"ARMOR_BONUS",},
		["护甲值"] = {"ARMOR_BONUS",},
		["强化护甲"] = {"ARMOR_BONUS",},
		["护甲值提高(%d+)点"] = {"ARMOR_BONUS",},
		["防御"] = {"DEFENSE",},
		["增加防御"] = {"DEFENSE",},
		["格挡值"] = {"BLOCK_VALUE",}, -- +22 Block Value
		["使你的盾牌格挡值"] = {"BLOCK_VALUE",},

		["生命值"] = {"HEALTH",},
		["法力值"] = {"MANA",},

		["攻击强度"] = {"AP",},
		["攻击强度提高"] = {"AP",},
		["提高攻击强度"] = {"AP",},
		["与亡灵作战时的攻击强度"] = {"AP_UNDEAD",}, -- [黎明圣印] ID:13209 -- [弑妖裹腕] ID:23093
		["与亡灵和恶魔作战时的攻击强度"] = {"AP_UNDEAD", "AP_DEMON",}, -- [勇士徽章] ID:23206
		["与恶魔作战时的攻击强度"] = {"AP_DEMON",},
		["在猎豹、熊、巨熊和枭兽形态下的攻击强度"] = {"FERAL_AP",}, -- Atiesh ID:22632
		["使你的近战和远程攻击强度"] = {"AP"},
		["远程攻击强度"] = {"RANGED_AP",}, -- [High Warlord's Crossbow] ID: 18837

		["每5秒恢复(%d+)点生命值"] = {"HEALTH_REG",}, -- [Resurgence Rod] ID:17743
		["每5秒回复(%d+)点生命值"] = {"HEALTH_REG",},
		["生命值恢复速度"] = {"HEALTH_REG",}, -- [Demons Blood] ID: 10779

		["每5秒法力"] = {"MANA_REG",}, --
		["每5秒恢复法力"] = {"MANA_REG",}, -- [Royal Tanzanite] ID: 30603
		["每5秒恢复(%d+)点法力值"] = {"MANA_REG",},
		["每5秒回复(%d+)点法力值"] = {"MANA_REG",},
		["每5秒法力回复"] = {"MANA_REG",},
		["法力恢复"] = {"MANA_REG",},
		["法力回复"] = {"MANA_REG",},
		["使周围半径30码范围内的所有小队成员每5秒恢复(%d+)点法力值"] = {"MANA_REG",}, --

		["法术穿透"] = {"SPELLPEN",},
		["法术穿透力"] = {"SPELLPEN",},
		["使你的法术穿透提高"] = {"SPELLPEN",},

		["法术伤害和治疗"] = {"SPELL_DMG", "HEAL",},
		["法术强度"] = {"SPELL_DMG", "HEAL",},
		["法术治疗和伤害"] = {"SPELL_DMG", "HEAL",},
		["治疗和法术伤害"] = {"SPELL_DMG", "HEAL",},
		["法术伤害"] = {"SPELL_DMG",},
		["提高法术和魔法效果所造成的伤害和治疗效果"] = {"SPELL_DMG", "HEAL"},
		["使周围半径30码范围内的所有小队成员的法术和魔法效果所造成的伤害和治疗效果"] = {"SPELL_DMG", "HEAL"}, -- Atiesh, ID: 22630
		["提高所有法术和魔法效果所造成的伤害和治疗效果"] = {"SPELL_DMG", "HEAL"},		--StatLogic:GetSum("22630")
		["提高所有法术和魔法效果所造成的伤害和治疗效果，最多"] = {"SPELL_DMG", "HEAL"},
		--SetTip("22630")
		-- Atiesh ID:22630, 22631, 22632, 22589
						--装备: 使周围半径30码范围内队友的所有法术和魔法效果所造成的伤害和治疗效果提高最多33点。 -- 22630 -- 2.1.0
						--装备: 使周围半径30码范围内队友的所有法术和魔法效果所造成的治疗效果提高最多62点。 -- 22631
						--装备: 使半径30码范围内所有小队成员的法术爆击等级提高28点。 -- 22589
						--装备: 使周围半径30码范围内的队友每5秒恢复11点法力。
		["使你的法术伤害"] = {"SPELL_DMG",}, -- Atiesh ID:22631
		["伤害"] = {"SPELL_DMG",},
		["法术能量"] = {"SPELL_DMG", "HEAL",},
		["法术强度"] = {"SPELL_DMG", "HEAL",},
		["神圣伤害"] = {"HOLY_SPELL_DMG",},
		["奥术伤害"] = {"ARCANE_SPELL_DMG",},
		["火焰伤害"] = {"FIRE_SPELL_DMG",},
		["自然伤害"] = {"NATURE_SPELL_DMG",},
		["冰霜伤害"] = {"FROST_SPELL_DMG",},
		["暗影伤害"] = {"SHADOW_SPELL_DMG",},
		["神圣法术伤害"] = {"HOLY_SPELL_DMG",},
		["奥术法术伤害"] = {"ARCANE_SPELL_DMG",},
		["火焰法术伤害"] = {"FIRE_SPELL_DMG",},
		["自然法术伤害"] = {"NATURE_SPELL_DMG",},
		["冰霜法术伤害"] = {"FROST_SPELL_DMG",}, -- Acrobatic Staff of Frozen Wrath ID:3185:0:0:0:0:0:1957
		["暗影法术伤害"] = {"SHADOW_SPELL_DMG",},
		["提高奥术法术和效果所造成的伤害"] = {"ARCANE_SPELL_DMG",},
		["提高火焰法术和效果所造成的伤害"] = {"FIRE_SPELL_DMG",},
		["提高冰霜法术和效果所造成的伤害"] = {"FROST_SPELL_DMG",}, -- Frozen Shadoweave Vest ID:21871
		["提高神圣法术和效果所造成的伤害"] = {"HOLY_SPELL_DMG",},
		["提高自然法术和效果所造成的伤害"] = {"NATURE_SPELL_DMG",},
		["提高暗影法术和效果所造成的伤害"] = {"SHADOW_SPELL_DMG",}, -- Frozen Shadoweave Vest ID:21871

		["魔法和法术效果对亡灵造成的伤害"] = {"SPELL_DMG_UNDEAD",}, -- [黎明符文] ID:19812
		["所有法术和效果对亡灵所造成的伤害"] = {"SPELL_DMG_UNDEAD",}, -- [净妖长袍] ID:23085
		["魔法和法术效果对亡灵和恶魔所造成的伤害"] = {"SPELL_DMG_UNDEAD", "SPELL_DMG_DEMON",}, -- [勇士徽章] ID:23207

		["使法术治疗"] = {"HEAL",},
		["你的治疗效果"] = {"HEAL",}, -- Atiesh ID:22631
		["治疗法术"] = {"HEAL",}, -- +35 Healing Glove Enchant
		["治疗效果"] = {"HEAL",}, -- [圣使祝福手套] Socket Bonus
		["治疗"] = {"HEAL",},
		["法术治疗"] = {"HEAL",},
		["神圣效果"] = {"HEAL",},-- Enchant Ring - Healing Power
		["提高法术所造成的治疗效果"] = {"HEAL",},
		["提高所有法术和魔法效果所造成的治疗效果"] = {"HEAL",},
		["使周围半径30码范围内的所有小队成员的法术和魔法效果所造成的治疗效果"] = {"HEAL",}, -- Atiesh, ID: 22631

		["每秒伤害"] = {"DPS",},
		["每秒伤害提高"] = {"DPS",}, -- [Thorium Shells] ID: 15997

		["防御等级"] = {"DEFENSE_RATING",},
		["防御等级提高"] = {"DEFENSE_RATING",},
		["提高你的防御等级"] = {"DEFENSE_RATING",},
		["使防御等级"] = {"DEFENSE_RATING",},
		["使你的防御等级"] = {"DEFENSE_RATING",},

		["躲闪等级"] = {"DODGE_RATING",},
		["提高躲闪等级"] = {"DODGE_RATING",},
		["躲闪等级提高"] = {"DODGE_RATING",},
		["躲闪等级提高(%d+)"] = {"DODGE_RATING",},
		["提高你的躲闪等级"] = {"DODGE_RATING",},
		["使躲闪等级"] = {"DODGE_RATING",},
		["使你的躲闪等级"] = {"DODGE_RATING",},

		["招架等级"] = {"PARRY_RATING",},
		["提高招架等级"] = {"PARRY_RATING",},
		["提高你的招架等级"] = {"PARRY_RATING",},
		["使招架等级"] = {"PARRY_RATING",},
		["使你的招架等级"] = {"PARRY_RATING",},

		["盾挡等级"] = {"BLOCK_RATING",},
		["提高盾挡等级"] = {"BLOCK_RATING",},
		["提高你的盾挡等级"] = {"BLOCK_RATING",},
		["使盾挡等级"] = {"BLOCK_RATING",},
		["使你的盾挡等级"] = {"BLOCK_RATING",},

		["格挡等级"] = {"BLOCK_RATING",},
		["提高格挡等级"] = {"BLOCK_RATING",},
		["提高你的格挡等级"] = {"BLOCK_RATING",},
		["使格挡等级"] = {"BLOCK_RATING",},
		["使你的格挡等级"] = {"BLOCK_RATING",},

		["盾牌格挡等级"] = {"BLOCK_RATING",},
		["提高盾牌格挡等级"] = {"BLOCK_RATING",},
		["提高你的盾牌格挡等级"] = {"BLOCK_RATING",},
		["使盾牌格挡等级"] = {"BLOCK_RATING",},
		["使你的盾牌格挡等级"] = {"BLOCK_RATING",},

		["命中等级"] = {"MELEE_HIT_RATING", "SPELL_HIT_RATING",},
		["提高命中等级"] = {"MELEE_HIT_RATING", "SPELL_HIT_RATING",}, -- ITEM_MOD_HIT_RATING
		["使你的命中等级"] = {"MELEE_HIT_RATING", "SPELL_HIT_RATING",},
		["提高近战命中等级"] = {"MELEE_HIT_RATING",}, -- ITEM_MOD_HIT_MELEE_RATING

		["法术命中等级"] = {"SPELL_HIT_RATING",},
		["提高法术命中等级"] = {"SPELL_HIT_RATING",}, -- ITEM_MOD_HIT_SPELL_RATING
		["使你的法术命中等级"] = {"SPELL_HIT_RATING",},

		["远程命中等级"] = {"RANGED_HIT_RATING",},
		["提高远程命中等级"] = {"RANGED_HIT_RATING",}, -- ITEM_MOD_HIT_RANGED_RATING
		["使你的远程命中等级"] = {"RANGED_HIT_RATING",},

		["爆击等级"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING",},
		["提高爆击等级"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING",},
		["使你的爆击等级"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING",},

		["近战爆击等级"] = {"MELEE_CRIT_RATING",},
		["提高近战爆击等级"] = {"MELEE_CRIT_RATING",}, -- [屠杀者腰带] ID:21639
		["使你的近战爆击等级"] = {"MELEE_CRIT_RATING",},

		["法术爆击等级"] = {"SPELL_CRIT_RATING",},
		["法术爆击"] = {"SPELL_CRIT_RATING",},
		["提高法术爆击等级"] = {"SPELL_CRIT_RATING",}, -- [伊利达瑞的复仇] ID:28040
		["使你的法术爆击等级"] = {"SPELL_CRIT_RATING",},
		["使周围半径30码范围内的所有小队成员的法术爆击等级"] = {"SPELL_CRIT_RATING",}, -- Atiesh, ID: 22589

		["远程爆击等级"] = {"RANGED_CRIT_RATING",},
		["提高远程爆击等级"] = {"RANGED_CRIT_RATING",},
		["使你的远程爆击等级"] = {"RANGED_CRIT_RATING",},

		["提高命中躲闪等级"] = {"MELEE_HIT_AVOID_RATING"}, -- ITEM_MOD_HIT_TAKEN_RATING, Necklace of Trophies ID: 31275 (Patch 2.0.10 changed it to Hit Rating)
		["提高近战命中躲闪等级"] = {"MELEE_HIT_AVOID_RATING"}, -- ITEM_MOD_HIT_TAKEN_MELEE_RATING
		["提高远程命中躲闪等级"] = {"RANGED_HIT_AVOID_RATING"}, -- ITEM_MOD_HIT_TAKEN_RANGED_RATING
		["提高法术命中躲闪等级"] = {"SPELL_HIT_AVOID_RATING"}, -- ITEM_MOD_HIT_TAKEN_SPELL_RATING

		["韧性"] = {"RESILIENCE_RATING",},
		["韧性等级"] = {"RESILIENCE_RATING",},
		["使你的韧性等级"] = {"RESILIENCE_RATING",},
		["提高爆击躲闪等级"] = {"MELEE_CRIT_AVOID_RATING",},
		["提高近战爆击躲闪等级"] = {"MELEE_CRIT_AVOID_RATING",},
		["提高远程爆击躲闪等级"] = {"RANGED_CRIT_AVOID_RATING",},
		["提高法术爆击躲闪等级"] = {"SPELL_CRIT_AVOID_RATING",},

		["急速等级"] = {"MELEE_HASTE_RATING", "SPELL_HASTE_RATING"}, -- Enchant Gloves
		["攻击速度"] = {"MELEE_HASTE_RATING", "SPELL_HASTE_RATING"},
		["提高急速等级"] = {"MELEE_HASTE_RATING", "SPELL_HASTE_RATING"},
		["法术急速等级"] = {"SPELL_HASTE_RATING"},
		["远程急速等级"] = {"RANGED_HASTE_RATING"},
		["提高近战急速等级"] = {"MELEE_HASTE_RATING"},
		["提高法术急速等级"] = {"SPELL_HASTE_RATING"},
		["提高远程急速等级"] = {"RANGED_HASTE_RATING"},

		["匕首技能"] = {"DAGGER_WEAPON_RATING"},
		["匕首技能等级"] = {"DAGGER_WEAPON_RATING"},
		["剑类技能"] = {"SWORD_WEAPON_RATING"},
		["剑类武器技能等级"] = {"SWORD_WEAPON_RATING"},
		["单手剑技能"] = {"SWORD_WEAPON_RATING"},
		["单手剑技能等级"] = {"SWORD_WEAPON_RATING"},
		["双手剑技能"] = {"2H_SWORD_WEAPON_RATING"},
		["双手剑技能等级"] = {"2H_SWORD_WEAPON_RATING"},
		["斧类技能"] = {"AXE_WEAPON_RATING"},
		["斧类武器技能等级"] = {"AXE_WEAPON_RATING"},
		["单手斧技能"] = {"AXE_WEAPON_RATING"},
		["单手斧技能等级"] = {"AXE_WEAPON_RATING"},
		["双手斧技能"] = {"2H_AXE_WEAPON_RATING"},
		["双手斧技能等级"] = {"2H_AXE_WEAPON_RATING"},
		["锤类技能"] = {"MACE_WEAPON_RATING"},
		["锤类武器技能等级"] = {"MACE_WEAPON_RATING"},
		["单手锤技能"] = {"MACE_WEAPON_RATING"},
		["单手锤技能等级"] = {"MACE_WEAPON_RATING"},
		["双手锤技能"] = {"2H_MACE_WEAPON_RATING"},
		["双手锤技能等级"] = {"2H_MACE_WEAPON_RATING"},
		["枪械技能"] = {"GUN_WEAPON_RATING"},
		["枪械技能等级"] = {"GUN_WEAPON_RATING"},
		["弩技能"] = {"CROSSBOW_WEAPON_RATING"},
		["弩技能等级"] = {"CROSSBOW_WEAPON_RATING"},
		["弓技能"] = {"BOW_WEAPON_RATING"},
		["弓技能等级"] = {"BOW_WEAPON_RATING"},
		["野性战斗技能"] = {"FERAL_WEAPON_RATING"},
		["野性战斗技能等级"] = {"FERAL_WEAPON_RATING"},
		["拳套技能"] = {"FIST_WEAPON_RATING"},
		["拳套技能等级"] = {"FIST_WEAPON_RATING"}, -- Demonblood Eviscerator ID:27533

		["使你的精准等级提高"] = {"EXPERTISE_RATING"},
		["精准等级"] = {"EXPERTISE_RATING",},
		["提高精准等级"] = {"EXPERTISE_RATING",},
		["精准等级提高"] = {"EXPERTISE_RATING",},

		["护甲穿透等级"] = {"ARMOR_PENETRATION_RATING"},
		["护甲穿透等级提高"] = {"ARMOR_PENETRATION_RATING"},
		-- Exclude
		["秒"] = false,
		["到"] = false,
		["格容器"] = false,
		["格箭袋"] = false,
		["格弹药袋"] = false,
		["远程攻击速度%"] = false, -- AV quiver
	},
}
DisplayLocale.zhCN = {
	----------------
	-- Stat Names --
	----------------
	-- Please localize these strings too, global strings were used in the enUS locale just to have minimum
	-- localization effect when a locale is not available for that language, you don't have to use global
	-- strings in your localization.
  ["Stat Multiplier"] = "Stat Multiplier",
  ["Attack Power Multiplier"] = "Attack Power Multiplier",
  ["Reduced Physical Damage Taken"] = "Reduced Physical Damage Taken",
	["StatIDToName"] = {
		--[StatID] = {FullName, ShortName},
		---------------------------------------------------------------------------
		-- Tier1 Stats - Stats parsed directly off items
		["EMPTY_SOCKET_RED"] = {EMPTY_SOCKET_RED, EMPTY_SOCKET_RED}, -- EMPTY_SOCKET_RED = "Red Socket";
		["EMPTY_SOCKET_YELLOW"] = {EMPTY_SOCKET_YELLOW, EMPTY_SOCKET_YELLOW}, -- EMPTY_SOCKET_YELLOW = "Yellow Socket";
		["EMPTY_SOCKET_BLUE"] = {EMPTY_SOCKET_BLUE, EMPTY_SOCKET_BLUE}, -- EMPTY_SOCKET_BLUE = "Blue Socket";
		["EMPTY_SOCKET_META"] = {EMPTY_SOCKET_META, EMPTY_SOCKET_META}, -- EMPTY_SOCKET_META = "Meta Socket";

		["STEALTH_LEVEL"] = {"潜行等级", "潜行"},
		["IGNORE_ARMOR"] = {"你的攻击无视目标的 %d+ 点护甲值。", "忽略护甲"},
		["MELEE_DMG"] = {"近战伤害", "近战伤害"}, -- DAMAGE = "Damage"
		["RANGED_DMG"] = {"Ranged Weapon "..DAMAGE, "Ranged Dmg"}, -- DAMAGE = "Damage"
		["MOUNT_SPEED"] = {"骑乘速度(%)", "骑速(%)"},
		["RUN_SPEED"] = {"移动速度(%)", "跑速(%)"},

		["STR"] = {SPELL_STAT1_NAME, "力"},
		["AGI"] = {SPELL_STAT2_NAME, "敏"},
		["STA"] = {SPELL_STAT3_NAME, "耐"},
		["INT"] = {SPELL_STAT4_NAME, "智"},
		["SPI"] = {SPELL_STAT5_NAME, "精"},
		["ARMOR"] = {ARMOR, ARMOR},
		["ARMOR_BONUS"] = {"护甲加成", "护甲"},

		["FIRE_RES"] = {RESISTANCE2_NAME, "火抗"},
		["NATURE_RES"] = {RESISTANCE3_NAME, "自然抗"},
		["FROST_RES"] = {RESISTANCE4_NAME, "冰抗"},
		["SHADOW_RES"] = {RESISTANCE5_NAME, "暗抗"},
		["ARCANE_RES"] = {RESISTANCE6_NAME, "奥抗"},

		["FISHING"] = {"钓鱼", "钓鱼"},
		["MINING"] = {"采矿", "采矿"},
		["HERBALISM"] = {"草药学", "草药"},
		["SKINNING"] = {"剥皮", "剥皮"},

		["BLOCK_VALUE"] = {"盾牌格挡值", "格挡值"},

		["AP"] = {ATTACK_POWER_TOOLTIP, "攻强"},
		["RANGED_AP"] = {RANGED_ATTACK_POWER, "远攻强度"},
		["FERAL_AP"] = {"野性"..ATTACK_POWER_TOOLTIP, "野性强度"},
		["AP_UNDEAD"] = {ATTACK_POWER_TOOLTIP.."(亡灵)", "攻强(亡灵)"},
		["AP_DEMON"] = {ATTACK_POWER_TOOLTIP.."(恶魔)", "攻强(恶魔)"},

		["HEAL"] = {"法术治疗", "治疗"},

		["SPELL_DMG"] = {"法术伤害", "法伤"},
		["SPELL_DMG_UNDEAD"] = {"法术伤害(亡灵)", PLAYERSTAT_SPELL_COMBAT.."法伤".."(亡灵)"},
		["SPELL_DMG_DEMON"] = {"法术伤害(恶魔)", PLAYERSTAT_SPELL_COMBAT.."法伤".."(亡灵)"},
		["HOLY_SPELL_DMG"] = {"神圣法术伤害", SPELL_SCHOOL1_CAP.."法伤"},
		["FIRE_SPELL_DMG"] = {"火焰法术伤害", SPELL_SCHOOL2_CAP.."法伤"},
		["NATURE_SPELL_DMG"] = {"自然法术伤害", SPELL_SCHOOL3_CAP.."法伤"},
		["FROST_SPELL_DMG"] = {"冰霜法术伤害", SPELL_SCHOOL4_CAP.."法伤"},
		["SHADOW_SPELL_DMG"] = {"暗影法术伤害", SPELL_SCHOOL5_CAP.."法伤"},
		["ARCANE_SPELL_DMG"] = {"奥术法术伤害", SPELL_SCHOOL6_CAP.."法伤"},

		["SPELLPEN"] = {"法术穿透", SPELL_PENETRATION},

		["HEALTH"] = {HEALTH, HP},
		["MANA"] = {MANA, MP},
		["HEALTH_REG"] = {"生命恢复", "HP5"},
		["MANA_REG"] = {"法力恢复", "MP5"},

		["MAX_DAMAGE"] = {"最大伤害", "大伤"},
		["DPS"] = {"每秒伤害", "DPS"},

		["DEFENSE_RATING"] = {COMBAT_RATING_NAME2, COMBAT_RATING_NAME2}, -- COMBAT_RATING_NAME2 = "Defense Rating"
		["DODGE_RATING"] = {COMBAT_RATING_NAME3, COMBAT_RATING_NAME3}, -- COMBAT_RATING_NAME3 = "Dodge Rating"
		["PARRY_RATING"] = {COMBAT_RATING_NAME4, COMBAT_RATING_NAME4}, -- COMBAT_RATING_NAME4 = "Parry Rating"
		["BLOCK_RATING"] = {COMBAT_RATING_NAME5, COMBAT_RATING_NAME5}, -- COMBAT_RATING_NAME5 = "Block Rating"
		["MELEE_HIT_RATING"] = {COMBAT_RATING_NAME6, COMBAT_RATING_NAME6}, -- COMBAT_RATING_NAME6 = "Hit Rating"
		["RANGED_HIT_RATING"] = {"远程命中等级", "远程命中"}, -- PLAYERSTAT_RANGED_COMBAT = "Ranged"
		["SPELL_HIT_RATING"] = {"法术命中等级", "法术命中"}, -- PLAYERSTAT_SPELL_COMBAT = "Spell"
		["MELEE_HIT_AVOID_RATING"] = {"近战命中躲闪等级", "近战命中躲闪"},
		["RANGED_HIT_AVOID_RATING"] = {"远程命中躲闪等级", "远程命中躲闪"},
		["SPELL_HIT_AVOID_RATING"] = {"法术命中躲闪等级", "法术命中躲闪"},
		["MELEE_CRIT_RATING"] = {COMBAT_RATING_NAME9, COMBAT_RATING_NAME9}, -- COMBAT_RATING_NAME9 = "Crit Rating"
		["RANGED_CRIT_RATING"] = {"远程爆击等级", "远程爆击"},
		["SPELL_CRIT_RATING"] = {"法术爆击等级", "法术爆击"},
		["MELEE_CRIT_AVOID_RATING"] = {"爆击躲闪等级", "近战爆击躲闪"},
		["RANGED_CRIT_AVOID_RATING"] = {"远程爆击躲闪等级", "远程爆击躲闪"},
		["SPELL_CRIT_AVOID_RATING"] = {"法术爆击躲闪等级", "法术爆击躲闪"},
		["RESILIENCE_RATING"] = {COMBAT_RATING_NAME15, COMBAT_RATING_NAME15}, -- COMBAT_RATING_NAME15 = "Resilience"
		["MELEE_HASTE_RATING"] = {"近战急速等级", "近战急速"}, --
		["RANGED_HASTE_RATING"] = {"远程急速等级", "远程急速"},
		["SPELL_HASTE_RATING"] = {"法术急速等级", "法术急速"},
		["DAGGER_WEAPON_RATING"] = {"匕首技能等级", "匕首等级"}, -- SKILL = "Skill"
		["SWORD_WEAPON_RATING"] = {"剑类武器技能等级", "剑等级"},
		["2H_SWORD_WEAPON_RATING"] = {"双手剑技能等级", "双手剑等级"},
		["AXE_WEAPON_RATING"] = {"斧类武器技能等级", "斧等级"},
		["2H_AXE_WEAPON_RATING"] = {"双手斧技能等级", "双手斧等级"},
		["MACE_WEAPON_RATING"] = {"锤类武器技能等级", "锤等级"},
		["2H_MACE_WEAPON_RATING"] = {"双手锤技能等级", "双手锤等级"},
		["GUN_WEAPON_RATING"] = {"枪械技能等级", "枪等级"},
		["CROSSBOW_WEAPON_RATING"] = {"弩技能等级", "弩等级"},
		["BOW_WEAPON_RATING"] = {"弓技能等级", "弓等级"},
		["FERAL_WEAPON_RATING"] = {"野性技能等级", "野性等级"},
		["FIST_WEAPON_RATING"] = {"徒手技能等级", "徒手等级"},
		["STAFF_WEAPON_RATING"] = {"法杖技能等级", "法杖等级"}, -- Leggings of the Fang ID:10410
		["EXPERTISE_RATING"] = {"精准等级", "精准等级"},
		["ARMOR_PENETRATION_RATING"] = {"护甲穿透等级", "护甲穿透等级"},

		---------------------------------------------------------------------------
		-- Tier2 Stats - Stats that only show up when broken down from a Tier1 stat
		-- Str -> AP, Block Value
		-- Agi -> AP, Crit, Dodge
		-- Sta -> Health
		-- Int -> Mana, Spell Crit
		-- Spi -> mp5nc, hp5oc
		-- Ratings -> Effect
		["HEALTH_REG_OUT_OF_COMBAT"] = {"正常回血", "正常回血"},
		["MANA_REG_NOT_CASTING"] = {"正常回魔", "正常回魔"},
		["MELEE_CRIT_DMG_REDUCTION"] = {"爆击减伤(%)", "爆击减伤(%)"},
		["RANGED_CRIT_DMG_REDUCTION"] = {"远程爆击减伤(%)", "远程爆击减伤(%)"},
		["SPELL_CRIT_DMG_REDUCTION"] = {"法术爆击减伤(%)", "法术爆击减伤(%)"},
		["DEFENSE"] = {DEFENSE, DEFENSE},
		["DODGE"] = {DODGE.."(%)", DODGE.."(%)"},
		["PARRY"] = {PARRY.."(%)", PARRY.."(%)"},
		["BLOCK"] = {BLOCK.."(%)", BLOCK.."(%)"},
		["AVOIDANCE"] = {"完全豁免(%)", "豁免(%)"},
		["MELEE_HIT"] = {"物理命中(%)", "命中(%)"},
		["RANGED_HIT"] = {"远程命中(%)", "远程命中(%)"},
		["SPELL_HIT"] = {"法术命中(%)", "法术命中(%)"},
		["MELEE_HIT_AVOID"] = {"躲闪命中(%)", "躲闪命中(%)"},
		["RANGED_HIT_AVOID"] = {"躲闪远程命中(%)", "躲闪远程命中(%)"},
		["SPELL_HIT_AVOID"] = {"躲闪法术命中(%)", "躲闪法术命中(%)"},
		["MELEE_CRIT"] = {"物理爆击(%)", "物理爆击(%)"}, -- MELEE_CRIT_CHANCE = "Crit Chance"
		["RANGED_CRIT"] = {"远程爆击(%)", "远程爆击(%)"},
		["SPELL_CRIT"] = {"法术爆击(%)", "法术爆击(%)"},
		["MELEE_CRIT_AVOID"] = {"躲闪近战爆击(%)", "躲闪爆击(%)"},
		["RANGED_CRIT_AVOID"] = {"躲闪远程爆击(%)", "躲闪远程爆击(%)"},
		["SPELL_CRIT_AVOID"] = {"躲闪法术爆击(%)", "躲闪法术爆击(%)"},
		["MELEE_HASTE"] = {"近战急速(%)", "近战急速(%)"}, --
		["RANGED_HASTE"] = {"远程急速(%)", "远程急速(%)"},
		["SPELL_HASTE"] = {"法术急速(%)", "法术急速(%)"},
		["DAGGER_WEAPON"] = {"匕首技能", "匕首"}, -- SKILL = "Skill"
		["SWORD_WEAPON"] = {"剑技能", "剑"},
		["2H_SWORD_WEAPON"] = {"双手剑技能", "双手剑"},
		["AXE_WEAPON"] = {"斧技能", "斧"},
		["2H_AXE_WEAPON"] = {"双手斧技能", "双手斧"},
		["MACE_WEAPON"] = {"锤技能", "锤"},
		["2H_MACE_WEAPON"] = {"双手锤技能", "双手锤"},
		["GUN_WEAPON"] = {"枪械技能", "枪械"},
		["CROSSBOW_WEAPON"] = {"弩技能", "弩"},
		["BOW_WEAPON"] = {"弓技能", "弓"},
		["FERAL_WEAPON"] = {"野性技能", "野性"},
		["FIST_WEAPON"] = {"徒手战斗技能", "徒手"},
		["STAFF_WEAPON_RATING"] = {"法杖技能", "法杖"}, -- Leggings of the Fang ID:10410
		["EXPERTISE"] = {"精准", "精准"},
		["ARMOR_PENETRATION"] = {"护甲穿透(%)", "护甲穿透(%)"},

		---------------------------------------------------------------------------
		-- Tier3 Stats - Stats that only show up when broken down from a Tier2 stat
		-- Defense -> Crit Avoidance, Hit Avoidance, Dodge, Parry, Block
		-- Weapon Skill -> Crit, Hit, Dodge Neglect, Parry Neglect, Block Neglect
		-- Expertise -> Dodge Neglect, Parry Neglect
		["DODGE_NEGLECT"] = {"防止被躲闪(%)", "防止被躲闪(%)"},
		["PARRY_NEGLECT"] = {"防止被招架(%)", "防止被招架(%)"},
		["BLOCK_NEGLECT"] = {"防止被格挡(%)", "防止被格挡(%)"},

		---------------------------------------------------------------------------
		-- Talents
		["MELEE_CRIT_DMG"] = {"物理爆击(%)", "爆击(%)"},
		["RANGED_CRIT_DMG"] = {"远程爆击(%)", "远程爆击(%)"},
		["SPELL_CRIT_DMG"] = {"法术爆击(%)", "法爆(%)"},

		---------------------------------------------------------------------------
		-- Spell Stats
		-- These values can be prefixed with a @ and spell name, using reverse translation to english from Babble-Spell-2.2
		-- ex: "Heroic Strike@RAGE_COST" for Heroic Strike rage cost
		-- ex: "Heroic Strike@THREAT" for Heroic Strike threat value
		-- Use strsplit("@", text) to seperate the spell name and statid
		["THREAT"] = {"威胁值", "威胁"},
		["CAST_TIME"] = {"施法时间", "施法时间"},
		["MANA_COST"] = {"消耗法力", "消耗法力"},
		["RAGE_COST"] = {"消耗怒气", "消耗怒气"},
		["ENERGY_COST"] = {"消耗能量", "消耗能量"},
		["COOLDOWN"] = {"冷却时间", "冷却"},

		---------------------------------------------------------------------------
		-- Stats Mods
		["MOD_STR"] = {"修正力量(%)", "修正力量(%)"},
		["MOD_AGI"] = {"修正敏捷(%)", "修正敏捷(%)"},
		["MOD_STA"] = {"修正耐力(%)", "修正耐力(%)"},
		["MOD_INT"] = {"修正智力(%)", "修正智力(%)"},
		["MOD_SPI"] = {"修正精神(%)", "修正精神(%)"},
		["MOD_HEALTH"] = {"修正生命(%)", "修正生命(%)"},
		["MOD_MANA"] = {"修正法力(%)", "修正法力(%)"},
		["MOD_ARMOR"] = {"修正护甲(%)", "修正装甲(%)"},
		["MOD_BLOCK_VALUE"] = {"修正格挡值(%)", "修正格挡值(%)"},
		["MOD_DMG"] = {"修正伤害(%)", "修正伤害(%)"},
		["MOD_DMG_TAKEN"] = {"修正承受伤害(%)", "修正受伤害(%)"},
		["MOD_CRIT_DAMAGE"] = {"修正爆击(%)", "修正爆击(%)"},
		["MOD_CRIT_DAMAGE_TAKEN"] = {"修正承受爆击(%)", "修正受爆击(%)"},
		["MOD_THREAT"] = {"修正威胁(%)", "修正威胁(%)"},
		["MOD_AP"] = {"修正近战攻击强度(%)", "修正攻强(%)"},
		["MOD_RANGED_AP"] = {"修正远程攻击强度(%)", "修正远攻强度(%)"},
		["MOD_SPELL_DMG"] = {"修正法术伤害(%)", "修正法伤(%)"},
		["MOD_HEALING"] = {"修正法术治疗(%)", "修正治疗(%)"},
		["MOD_CAST_TIME"] = {"修正施法时间(%)", "修正施法时间(%)"},
		["MOD_MANA_COST"] = {"修正消耗法力(%)", "修正消耗法力(%)"},
		["MOD_RAGE_COST"] = {"修正消耗怒气(%)", "修正消耗怒气(%)"},
		["MOD_ENERGY_COST"] = {"修正消耗能量(%)", "修正消耗能量(%)"},
		["MOD_COOLDOWN"] = {"修正技能冷却(%)", "修正技能冷却(%)"},

		---------------------------------------------------------------------------
		-- Misc Stats
		["WEAPON_RATING"] = {"武器技能等级", "武器技能等级"},
		["WEAPON_SKILL"] = {"武器技能", "武器技能"},
		["MAINHAND_WEAPON_RATING"] = {"主手武器技能等级", "主手武器技能等级"},
		["OFFHAND_WEAPON_RATING"] = {"副手武器技能等级", "副手武器技能等级"},
		["RANGED_WEAPON_RATING"] = {"远程武器技能等级", "远程武器技能等级"},
	},
}

-- ruRU localization by Gezz
PatternLocale.ruRU = {
	["tonumber"] = function(s)
		local n = tonumber(s)
		if n then
			return n
		else
			return tonumber((gsub(s, ",", "%.")))
		end
	end,
	-----------------
	-- Armor Types --
	-----------------
	Plate = "Латы",
	Mail = "Кольчуга",
	Leather = "Кожа",
	Cloth = "Ткань",
	------------------
	-- Fast Exclude --
	------------------
	-- By looking at the first ExcludeLen letters of a line we can exclude a lot of lines
	["ExcludeLen"] = 5, -- using string.utf8len
	["Exclude"] = {
		[""] = true,
		[" \n"] = true,
		[ITEM_BIND_ON_EQUIP] = true, -- ITEM_BIND_ON_EQUIP = "Binds when equipped"; -- Item will be bound when equipped
		[ITEM_BIND_ON_PICKUP] = true, -- ITEM_BIND_ON_PICKUP = "Binds when picked up"; -- Item wil be bound when picked up
		[ITEM_BIND_ON_USE] = true, -- ITEM_BIND_ON_USE = "Binds when used"; -- Item will be bound when used
		[ITEM_BIND_QUEST] = true, -- ITEM_BIND_QUEST = "Quest Item"; -- Item is a quest item (same logic as ON_PICKUP)
		[ITEM_SOULBOUND] = true, -- ITEM_SOULBOUND = "Soulbound"; -- Item is Soulbound
		[ITEM_STARTS_QUEST] = true, -- ITEM_STARTS_QUEST = "This Item Begins a Quest"; -- Item is a quest giver
		[ITEM_CANT_BE_DESTROYED] = true, -- ITEM_CANT_BE_DESTROYED = "That item cannot be destroyed."; -- Attempted to destroy a NO_DESTROY item
		[ITEM_CONJURED] = true, -- ITEM_CONJURED = "Conjured Item"; -- Item expires
		[ITEM_DISENCHANT_NOT_DISENCHANTABLE] = true, -- ITEM_DISENCHANT_NOT_DISENCHANTABLE = "Cannot be disenchanted"; -- Items which cannot be disenchanted ever
		["Может"] = true, -- ITEM_DISENCHANT_ANY_SKILL = "Disenchantable"; -- Items that can be disenchanted at any skill level
		-- ITEM_DISENCHANT_MIN_SKILL = "Disenchanting requires %s (%d)"; -- Minimum enchanting skill needed to disenchant
		["Длите"] = true, -- ITEM_DURATION_DAYS = "Duration: %d days";
		["<Изго"] = true, -- ITEM_CREATED_BY = "|cff00ff00<Made by %s>|r"; -- %s is the creator of the item
		["Време"] = true, -- ITEM_COOLDOWN_TIME_DAYS = "Cooldown remaining: %d day";
		["Уника"] = true, -- Unique (20) -- ITEM_UNIQUE = "Unique"; -- Item is unique -- ITEM_UNIQUE_MULTIPLE = "Unique (%d)"; -- Item is unique
		["Требу"] = true, -- Requires Level xx -- ITEM_MIN_LEVEL = "Requires Level %d"; -- Required level to use the item
		["\nТреб"] = true, -- Requires Level xx -- ITEM_MIN_SKILL = "Requires %s (%d)"; -- Required skill rank to use the item
		["Класс"] = true, -- Classes: xx -- ITEM_CLASSES_ALLOWED = "Classes: %s"; -- Lists the classes allowed to use this item
		["Расы:"] = true, -- Races: xx (vendor mounts) -- ITEM_RACES_ALLOWED = "Races: %s"; -- Lists the races allowed to use this item
		["Испол"] = true, -- Use: -- ITEM_SPELL_TRIGGER_ONUSE = "Use:";
		["Возмо"] = true, -- Chance On Hit: -- ITEM_SPELL_TRIGGER_ONPROC = "Chance on hit:";
		["Верхо"] = true, -- Верховые животные
		-- Set Bonuses
		-- ITEM_SET_BONUS = "Set: %s";
		-- ITEM_SET_BONUS_GRAY = "(%d) Set: %s";
		-- ITEM_SET_NAME = "%s (%d/%d)"; -- Set name (2/5)
		["Компл"] = true,
		["(2) S"] = true,
		["(3) S"] = true,
		["(4) S"] = true,
		["(5) S"] = true,
		["(6) S"] = true,
		["(7) S"] = true,
		["(8) S"] = true,
		-- Equip type
		["Боеприпасы"] = true, -- Ice Threaded Arrow ID:19316
		[INVTYPE_AMMO] = true,
		[INVTYPE_HEAD] = true,
		[INVTYPE_NECK] = true,
		[INVTYPE_SHOULDER] = true,
		[INVTYPE_BODY] = true,
		[INVTYPE_CHEST] = true,
		[INVTYPE_ROBE] = true,
		[INVTYPE_WAIST] = true,
		[INVTYPE_LEGS] = true,
		[INVTYPE_FEET] = true,
		[INVTYPE_WRIST] = true,
		[INVTYPE_HAND] = true,
		[INVTYPE_FINGER] = true,
		[INVTYPE_TRINKET] = true,
		[INVTYPE_CLOAK] = true,
		[INVTYPE_WEAPON] = true,
		[INVTYPE_SHIELD] = true,
		[INVTYPE_2HWEAPON] = true,
		[INVTYPE_WEAPONMAINHAND] = true,
		[INVTYPE_WEAPONOFFHAND] = true,
		[INVTYPE_HOLDABLE] = true,
		[INVTYPE_RANGED] = true,
		[INVTYPE_THROWN] = true,
		[INVTYPE_RANGEDRIGHT] = true,
		[INVTYPE_RELIC] = true,
		[INVTYPE_TABARD] = true,
		[INVTYPE_BAG] = true,
	},
	-----------------------
	-- Whole Text Lookup --
	-----------------------
	-- Mainly used for enchants that doesn't have numbers in the text
	-- http://wow.allakhazam.com/db/enchant.html?slot=0&locale=enUS
	["WholeTextLookup"] = {
		[EMPTY_SOCKET_RED] = {["EMPTY_SOCKET_RED"] = 1}, -- EMPTY_SOCKET_RED = "Red Socket";
		[EMPTY_SOCKET_YELLOW] = {["EMPTY_SOCKET_YELLOW"] = 1}, -- EMPTY_SOCKET_YELLOW = "Yellow Socket";
		[EMPTY_SOCKET_BLUE] = {["EMPTY_SOCKET_BLUE"] = 1}, -- EMPTY_SOCKET_BLUE = "Blue Socket";
		[EMPTY_SOCKET_META] = {["EMPTY_SOCKET_META"] = 1}, -- EMPTY_SOCKET_META = "Meta Socket";

		["Слабое волшебное масло"] = {["SPELL_DMG"] = 8, ["HEAL"] = 8}, -- ID: 20744
		["Простое волшебное масло"] = {["SPELL_DMG"] = 16, ["HEAL"] = 16}, -- ID: 20746
		["Волшебное масло"] = {["SPELL_DMG"] = 24, ["HEAL"] = 24}, -- ID: 20750
		["Сверкающее волшебное масло"] = {["SPELL_DMG"] = 36, ["HEAL"] = 36, ["SPELL_CRIT_RATING"] = 14}, -- ID: 20749
		["Превосходное волшебное масло"] = {["SPELL_DMG"] = 42, ["HEAL"] = 42}, -- ID: 22522
		["Благословенное волшебное масло"] = {["SPELL_DMG_UNDEAD"] = 60}, -- ID: 23123

		["Слабое масло маны"] = {["MANA_REG"] = 4}, -- ID: 20745
		["Простое масло маны"] = {["MANA_REG"] = 8}, -- ID: 20747
		["Сверкающее масло маны"] = {["MANA_REG"] = 12, ["HEAL"] = 25}, -- ID: 20748
		["Превосходное масло маны"] = {["MANA_REG"] = 14}, -- ID: 22521

		["Eternium Line"] = {["FISHING"] = 5}, --
		["свирепость"] = {["AP"] = 70}, --
		["жизненная сила"] = {["MANA_REG"] = 4, ["HEALTH_REG"] = 4}, -- Enchant Boots - Vitality http://wow.allakhazam.com/db/spell.html?wspell=27948
		["Душелед"] = {["SHADOW_SPELL_DMG"] = 54, ["FROST_SPELL_DMG"] = 54}, --
		["Солнечный огонь"] = {["ARCANE_SPELL_DMG"] = 50, ["FIRE_SPELL_DMG"] = 50}, --

		["Мифриловые шпоры"] = {["MOUNT_SPEED"] = 4}, -- Mithril Spurs
		["Minor Mount Speed Increase"] = {["MOUNT_SPEED"] = 2}, -- Enchant Gloves - Riding Skill
		["Если на персонаже: скорость бега слегка увеличилась."] = {["RUN_SPEED"] = 8}, -- [Highlander's Plate Greaves] ID: 20048
		["Небольшое увеличение скорости"] = {["RUN_SPEED"] = 8}, -- Enchant Boots - Minor Speed "Minor Speed Increase" http://wow.allakhazam.com/db/spell.html?wspell=13890
		["Небольшое увеличение скорости бега"] = {["RUN_SPEED"] = 8}, --
		["Minor Speed"] = {["RUN_SPEED"] = 8}, -- Enchant Boots - Cat's Swiftness "Minor Speed and +6 Agility" http://wow.allakhazam.com/db/spell.html?wspell=34007
		["верный шаг"] = {["MELEE_HIT_RATING"] = 10}, -- Enchant Boots - Surefooted "Surefooted" http://wow.allakhazam.com/db/spell.html?wspell=27954

		["Скрытность"] = {["MOD_THREAT"] = -2}, -- Enchant Cloak - Subtlety
		["снижение угрозы на 2%"] = {["MOD_THREAT"] = -2}, -- StatLogic:GetSum("item:23344:2832")
		["Если на персонаже: возможность дышать под водой."] = false, -- [Band of Icy Depths] ID: 21526
		["Возможность дышать под водой."] = false, --
		["Если на персонаже: Неуязвимость к способности Разоружение."] = false, -- [Stronghold Gauntlets] ID: 12639
		["Неуязвимость к разоружению"] = false, --
		["Рыцарь"] = false, -- Enchant Crusader
		["Похищение жизни"] = false, -- Enchant Crusader
		
		["Живучесть клыкарра"] = {["RUN_SPEED"] = 8, ["STA"] = 15}, -- EnchantID: 3232
		["Мудрость"] = {["MOD_THREAT"] = -2, ["SPI"] = 10}, -- EnchantID: 3296
		["Точность"] = {["MELEE_HIT_RATING"] = 25, ["SPELL_HIT_RATING"] = 25, ["MELEE_CRIT_RATING"] = 25, ["SPELL_CRIT_RATING"] = 25}, -- EnchantID: 3788
		["Проклятие Плети"] = {["AP_UNDEAD"] = 140}, -- EnchantID: 3247
		["Ледопроходец"] = {["MELEE_HIT_RATING"] = 12, ["SPELL_HIT_RATING"] = 12, ["MELEE_CRIT_RATING"] = 12, ["SPELL_CRIT_RATING"] = 12}, -- EnchantID: 3826
		["Собиратель"] = {["HERBALISM"] = 5, ["MINING"] = 5, ["SKINNING"] = 5}, -- EnchantID: 3296
		["Живучесть II"] = {["MANA_REG"] = 6, ["HEALTH_REG"] = 6}, -- EnchantID: 3244

		["+37 к выносливости и +20 к рейтингу защиты"] = {["STA"] = 37, ["DEFENSE_RATING"] = 20}, -- Defense does not equal Defense Rating...
		["Руна сломанных мечей"] = {["PARRY"] = 2}, -- EnchantID: 3594
		["Руна расколотых мечей"] = {["PARRY"] = 4}, -- EnchantID: 3365
		["Руна каменной горгульи"] = {["DEFENSE"] = 25, ["MOD_STA"] = 2}, -- EnchantID: 
	},
	----------------------------
	-- Single Plus Stat Check --
	----------------------------
	-- depending on locale, it may be
	-- +19 Stamina = "^%+(%d+) (.-)%.?$"
	-- Stamina +19 = "^(.-) %+(%d+)%.?$"
	-- +19 ?? = "^%+(%d+) (.-)%.?$"
	-- Some have a "." at the end of string like:
	-- Enchant Chest - Restore Mana Prime "+6 mana every 5 sec. "
	-- ["SinglePlusStatCheck"] = "^([%+%-]%d+) (.-)%.?$",
	["SinglePlusStatCheck"] = "^(.-): %+(%d+)%.?$",
	-----------------------------
	-- Single Equip Stat Check --
	-----------------------------
	-- stat1, value, stat2 = strfind
	-- stat = stat1..stat2
	-- "^Equip: (.-) by u?p? ?t?o? ?(%d+) ?(.-)%.?$"
	["SingleEquipStatCheck"] = "^Если на персонаже: (.-) ?н?е? ?б?о?л?е?е? ?ч?е?м?,? на (%d+) ?е?д?.? ?(.-)%.?$",
	-------------
	-- PreScan --
	-------------
	-- Special cases that need to be dealt with before deep scan
	["PreScanPatterns"] = {
		--["^Если на персонаже: Увеличивает силу атаки на (%d+) ед. в облике кошки"] = "FERAL_AP",
		--["^Если на персонаже: Увеличение силы атаки на (%d+) ед. в битве с нежитью"] = "AP_UNDEAD", -- Seal of the Dawn ID:13029
		["^Блокирование: (%d+)$"] = "BLOCK_VALUE",
		["^Броня: (%d+)$"] = "ARMOR",
		["Доспех усилен %(%+(%d+) к броне%)"] = "ARMOR_BONUS",
		["Восполнение (%d+) ед%. маны раз в 5 сек%.$"] = "MANA_REG",
		["Восполнение (%d+) ед%. маны раз в 5 секунд"] = "MANA_REG",
		["Восполнение (%d+) ед%. маны в 5 секунд%."] = "MANA_REG",
		["^Урон: %+?%d+ %- (%d+)$"] = "MAX_DAMAGE",
		["^%(([%d%,]+) единицы урона в секунду%)$"] = "DPS",
		-- Exclude
		["^Комплект %((%d+) предмета%)"] = false, -- Set Name (0/9)
		["^Комплект"] = false, -- Set Name (0/9)
		["^.- %((%d+)/%d+%)$"] = false, -- Set Name (0/9)
		["|cff808080"] = false, -- Gray text "  |cff808080Requires at least 2 Yellow gems|r\n  |cff808080Requires at least 1 Red gem|r"
		-- Procs
		--["[Cc]hance"] = false, -- [Mark of Defiance] ID:27924 -- [Staff of the Qiraji Prophets] ID:21128 -- Commented out because it was blocking [Insightful Earthstorm Diamond]
		["[Ии]ногда"] = false, -- [Darkmoon Card: Heroism] ID:19287
		["[Пп]ри получении удара в бою"] = false, -- [Essence of the Pure Flame] ID: 18815

		["Увеличение урона, наносимого заклинаниями и эффектами темной магии, на (%d+) ед%."] = "SHADOW_SPELL_DMG",
		["Увеличение урона, наносимого заклинаниями и эффектами льда, на (%d+) ед%."] = "FROST_SPELL_DMG",
		["Увеличение урона, наносимого заклинаниями и эффектами сил природы, на (%d+) ед%."] = "NATURE_SPELL_DMG",

		["Повышение не более чем на (%d+) ед.% урона, наносимого нежити заклинаниями и магическими эффектами%."] = "SPELL_DMG_UNDEAD", -- [Robe of Undead Cleansing] ID:23085
		["Увеличение урона, наносимого нежити и демонам от магических эффектов и заклинаний, не более чем на (%d+) ед%."] = {"SPELL_DMG_UNDEAD", "SPELL_DMG_DEMON"}, -- [Mark of the Champion] ID:23207

		["Увеличивает силу атаки на (%d+) ед%. в облике кошки, медведя, лютого медведя или лунного совуха."] = "FERAL_AP",
	},
	--------------
	-- DeepScan --
	--------------
	-- Strip leading "Equip: ", "Socket Bonus: "
	["Equip: "] = "Если на персонаже: ", -- ITEM_SPELL_TRIGGER_ONEQUIP = "Equip:";
	["Socket Bonus: "] = "При соответствии цвета: ", -- ITEM_SOCKET_BONUS = "Socket Bonus: %s"; -- Tooltip tag for socketed item matched socket bonuses
	-- Strip trailing "."
	["."] = ".",
	["DeepScanSeparators"] = {
		"/", -- "+10 Defense Rating/+10 Stamina/+15 Block Value": ZG Enchant
		" & ", -- "+26 Healing Spells & 2% Reduced Threat": Bracing Earthstorm Diamond ID:25897
	},
	["DeepScanWordSeparators"] = {
		-- "%. ", -- "Equip: Increases attack power by 81 when fighting Undead. It also allows the acquisition of Scourgestones on behalf of the Argent Dawn.": Seal of the Dawn
		", ", -- "+6 Spell Damage, +5 Spell Crit Rating": Potent Ornate Topaz ID: 28123
		" и ", -- "Critical Rating +6 and Dodge Rating +5": Assassin's Fire Opal ID:30565
	},
	["DualStatPatterns"] = { -- all lower case
		["^%+(%d+) к лечению и %+(%d+) к урону от заклинаний$"] = {{"HEAL",}, {"SPELL_DMG",},},
		["^%+(%d+) к лечению %+(%d+) к урону от заклинаний$"] = {{"HEAL",}, {"SPELL_DMG",},},
		["^увеличение исцеляющих эффектов на (%d+) ед%. и урона от всех магических заклинаний и эффектов на (%d+) ед%.?$"] = {{"HEAL",}, {"SPELL_DMG",},},
		["увеличивает силу заклинаний на (%d+) ед%."] = {{"SPELL_DMG",},{"HEAL",},},
	},
	["DeepScanPatterns"] = {
		"^(.-) ?н?е? ?б?о?л?е?е? ?ч?е?м? на (%d+) ?е?д?.? ?(.-)$", -- "xxx by up to 22 xxx" (scan first)
		"^(.-) ?([%+%-]%d+) ?(.-)$", -- "xxx xxx +22" or "+22 xxx xxx" or "xxx +22 xxx" (scan 2ed)
		"^(.-) ?([%d%,]+) ?(.-)$", -- 22.22 xxx xxx (scan last)
	},
	-----------------------
	-- Stat Lookup Table --
	-----------------------
	["StatIDLookup"] = {
		--[[
		["Weapon Damage"] = {"MELEE_DMG"}, -- Enchant
		["All Stats"] = {"STR", "AGI", "STA", "INT", "SPI",},
		["Fishing"] = {"FISHING",}, -- Fishing enchant ID:846
		["Fishing Skill"] = {"FISHING",}, -- Fishing lure
		["Increased Fishing"] = {"FISHING",}, -- Equip: Increased Fishing +20.
		["Mining"] = {"MINING",}, -- Mining enchant ID:844
		["Herbalism"] = {"HERBALISM",}, -- Heabalism enchant ID:845
		["Skinning"] = {"SKINNING",}, -- Skinning enchant ID:865
		["Attack Power when fighting Undead"] = {"AP_UNDEAD",}, -- [Wristwraps of Undead Slaying] ID:23093
		["Increases attack powerwhen fighting Undead"] = {"AP_UNDEAD",}, -- [Seal of the Dawn] ID:13209
		["Increases attack powerwhen fighting Undead.  It also allows the acquisition of Scourgestones on behalf of the Argent Dawn"] = {"AP_UNDEAD",}, -- [Seal of the Dawn] ID:13209
		["Increases attack powerwhen fighting Demons"] = {"AP_DEMON",},
		["Increases attack powerwhen fighting Undead and Demons"] = {"AP_UNDEAD", "AP_DEMON",}, -- [Mark of the Champion] ID:23206
		["Attack Power in Cat, Bear, and Dire Bear forms only"] = {"FERAL_AP",},
		["Ranged Attack Power"] = {"RANGED_AP",},
		["Healing and Spell Damage"] = {"SPELL_DMG", "HEAL",}, -- Arcanum of Focus +8 Healing and Spell Damage http://wow.allakhazam.com/db/spell.html?wspell=22844
		["Damage and Healing Spells"] = {"SPELL_DMG", "HEAL",},
		["Spell Damage and Healing"] = {"SPELL_DMG", "HEAL",}, --StatLogic:GetSum("item:22630")
		["Damage"] = {"SPELL_DMG",},
		["Increases your spell damage"] = {"SPELL_DMG",}, -- Atiesh ID:22630, 22631, 22632, 22589
		["Spell Power"] = {"SPELL_DMG", "HEAL",},
		["Increases spell power"] = {"SPELL_DMG", "HEAL",}, -- WotLK
		["Holy Damage"] = {"HOLY_SPELL_DMG",},
		["Arcane Damage"] = {"ARCANE_SPELL_DMG",},
		["Fire Damage"] = {"FIRE_SPELL_DMG",},
		["Nature Damage"] = {"NATURE_SPELL_DMG",},
		["Frost Damage"] = {"FROST_SPELL_DMG",},
		["Shadow Damage"] = {"SHADOW_SPELL_DMG",},
		["Holy Spell Damage"] = {"HOLY_SPELL_DMG",},
		["Arcane Spell Damage"] = {"ARCANE_SPELL_DMG",},
		["Fire Spell Damage"] = {"FIRE_SPELL_DMG",},
		["Nature Spell Damage"] = {"NATURE_SPELL_DMG",},
		["Shadow Spell Damage"] = {"SHADOW_SPELL_DMG",},
		["Increases your block rating"] = {"BLOCK_RATING",},
		["Increases your shield block rating"] = {"BLOCK_RATING",},
		["Improves hit rating"] = {"MELEE_HIT_RATING",}, -- ITEM_MOD_HIT_RATING
		["Improves melee hit rating"] = {"MELEE_HIT_RATING",}, -- ITEM_MOD_HIT_MELEE_RATING
		["Increases your hit rating"] = {"MELEE_HIT_RATING",},
		["Improves spell hit rating"] = {"SPELL_HIT_RATING",}, -- ITEM_MOD_HIT_SPELL_RATING
		["Increases your spell hit rating"] = {"SPELL_HIT_RATING",},
		["Ranged Hit Rating"] = {"RANGED_HIT_RATING",},
		["Improves ranged hit rating"] = {"RANGED_HIT_RATING",}, -- ITEM_MOD_HIT_RANGED_RATING
		["Increases your ranged hit rating"] = {"RANGED_HIT_RATING",},
		["Increases damage done by Holy spells and effects"] = {"HOLY_SPELL_DMG",},
		["Increases damage done by Arcane spells and effects"] = {"ARCANE_SPELL_DMG",},
		["Increases damage done by Fire spells and effects"] = {"FIRE_SPELL_DMG",},
		["Increases damage done to Undead by magical spells and effects.  It also allows the acquisition of Scourgestones on behalf of the Argent Dawn"] = {"SPELL_DMG_UNDEAD"}, -- [Rune of the Dawn] ID:19812
		["Healing Spells"] = {"HEAL",}, -- Enchant Gloves - Major Healing "+35 Healing Spells" http://wow.allakhazam.com/db/spell.html?wspell=33999
		["Increases Healing"] = {"HEAL",},
		["Healing"] = {"HEAL",}, -- StatLogic:GetSum("item:23344:206")
		["healing Spells"] = {"HEAL",},
		["Damage Spells"] = {"SPELL_DMG",}, -- 2.3.0 StatLogic:GetSum("item:23344:2343")
		["Increases damage and healing done by magical spells and effects of all party members within 30 yards"] = {"SPELL_DMG", "HEAL"}, -- Atiesh
		["Increases healing done"] = {"HEAL",}, -- 2.3.0
		["damage donefor all magical spells"] = {"SPELL_DMG",}, -- 2.3.0
		["Increases healing done by spells and effects"] = {"HEAL",},
		["Increases healing done by magical spells and effects of all party members within 30 yards"] = {"HEAL",}, -- Atiesh
		["your healing"] = {"HEAL",}, -- Atiesh
		["damage per second"] = {"DPS",},
		["Critical Strike Rating"] = {"MELEE_CRIT_RATING",},
		["Increases your critical hit rating"] = {"MELEE_CRIT_RATING",},
		["Increases your critical strike rating"] = {"MELEE_CRIT_RATING",},
		["Improves critical strike rating"] = {"MELEE_CRIT_RATING",},
		["Improves melee critical strike rating"] = {"MELEE_CRIT_RATING",}, -- [Cloak of Darkness] ID:33122
		["Increases the spell critical strike rating of all party members within 30 yards"] = {"SPELL_CRIT_RATING",},
		["Increases your ranged critical strike rating"] = {"RANGED_CRIT_RATING",}, -- Fletcher's Gloves ID:7348
		["Improves hit avoidance rating"] = {"MELEE_HIT_AVOID_RATING"}, -- ITEM_MOD_HIT_TAKEN_RATING
		["Improves melee hit avoidance rating"] = {"MELEE_HIT_AVOID_RATING"}, -- ITEM_MOD_HIT_TAKEN_MELEE_RATING
		["Improves ranged hit avoidance rating"] = {"RANGED_HIT_AVOID_RATING"}, -- ITEM_MOD_HIT_TAKEN_RANGED_RATING
		["Improves spell hit avoidance rating"] = {"SPELL_HIT_AVOID_RATING"}, -- ITEM_MOD_HIT_TAKEN_SPELL_RATING
		["Improves your resilience rating"] = {"RESILIENCE_RATING",},
		["Improves critical avoidance rating"] = {"MELEE_CRIT_AVOID_RATING",},
		["Improves melee critical avoidance rating"] = {"MELEE_CRIT_AVOID_RATING",},
		["Improves ranged critical avoidance rating"] = {"RANGED_CRIT_AVOID_RATING",},
		["Improves spell critical avoidance rating"] = {"SPELL_CRIT_AVOID_RATING",},
		["Increases your parry rating"] = {"PARRY_RATING",},
		["Ranged Haste Rating"] = {"RANGED_HASTE_RATING"},
		["Improves haste rating"] = {"MELEE_HASTE_RATING"},
		["Improves melee haste rating"] = {"MELEE_HASTE_RATING"},
		["Improves spell haste rating"] = {"SPELL_HASTE_RATING"},
		["Improves ranged haste rating"] = {"RANGED_HASTE_RATING"},
		["Increases dagger skill rating"] = {"DAGGER_WEAPON_RATING"},
		["Increases sword skill rating"] = {"SWORD_WEAPON_RATING"}, -- [Warblade of the Hakkari] ID:19865
		["Increases Two-Handed Swords skill rating"] = {"2H_SWORD_WEAPON_RATING"},
		["Increases axe skill rating"] = {"AXE_WEAPON_RATING"},
		["Two-Handed Axe Skill Rating"] = {"2H_AXE_WEAPON_RATING"}, -- [Ethereum Nexus-Reaver] ID:30722
		["Increases two-handed axes skill rating"] = {"2H_AXE_WEAPON_RATING"},
		["Increases mace skill rating"] = {"MACE_WEAPON_RATING"},
		["Increases two-handed maces skill rating"] = {"2H_MACE_WEAPON_RATING"},
		["Increases gun skill rating"] = {"GUN_WEAPON_RATING"},
		["Increases Crossbow skill rating"] = {"CROSSBOW_WEAPON_RATING"},
		["Increases Bow skill rating"] = {"BOW_WEAPON_RATING"},
		["Increases feral combat skill rating"] = {"FERAL_WEAPON_RATING"},
		["Increases fist weapons skill rating"] = {"FIST_WEAPON_RATING"}, -- Demonblood Eviscerator
		["Increases unarmed skill rating"] = {"FIST_WEAPON_RATING"}, -- Demonblood Eviscerator ID:27533
		["Increases staff skill rating"] = {"STAFF_WEAPON_RATING"}, -- Leggings of the Fang ID:10410
		-- Exclude
		["sec"] = false,
		["to"] = false,
		["Slot Bag"] = false,
		["Slot Quiver"] = false,
		["Slot Ammo Pouch"] = false,
		["Increases ranged attack speed"] = false, -- AV quiver
		--]]

		["Увеличивает рейтинг пробивания брони на"] = {"IGNORE_ARMOR"}, -- StatLogic:GetSum("item:33733")
		["Повышает рейтинг пробивания брони на"] = {"ARMOR_PENETRATION_RATING"},
		["% угрозы"] = {"MOD_THREAT"}, -- StatLogic:GetSum("item:23344:2613")
		["увеличение уровня эффективного действия незаметности на"] = {"STEALTH_LEVEL"}, -- [Nightscape Boots] ID: 8197
		["Скорость бега слегка увеличилась."] = {"MOUNT_SPEED"}, -- [Highlander's Plate Greaves] ID: 20048

		["ко всем характеристикам"] = {"STR", "AGI", "STA", "INT", "SPI",},
		["Сила"] = {"STR",},
		["Ловкость"] = {"AGI",},
		["Выносливость"] = {"STA",},
		["Интеллект"] = {"INT",},
		["Дух"] = {"SPI",},

		["устойчивость:тайная магия"] = {"ARCANE_RES",},
		["устойчивость:огонь"] = {"FIRE_RES",},
		["устойчивость:природа"] = {"NATURE_RES",},
		["устойчивость:лед"] = {"FROST_RES",},
		["устойчивость:тьма"] = {"SHADOW_RES",},
		["к сопротивлению огню"] = {"FIRE_RES",},
		["к сопротивлению силам природы"] = {"NATURE_RES",},
		["к сопротивлению темной магии"] = {"SHADOW_RES",},
		["к сопротивлению тайной магии"] = {"ARCANE_RES",},
		["к сопротивлению всему"] = {"ARCANE_RES", "FIRE_RES", "FROST_RES", "NATURE_RES", "SHADOW_RES",},

		["Броня"] = {"ARMOR_BONUS",},
		["Защита"] = {"DEFENSE",},
		["Повышение защиты"] = {"DEFENSE",},
		["Блок"] = {"BLOCK_VALUE",}, -- +22 Block Value
		["к блоку"] = {"BLOCK_VALUE",},
		["Увеличение показателя блока щитом наед"] = {"BLOCK_VALUE",},

		["к силе"] = {"STR",},
		["к ловкости"] = {"AGI",},
		["к выносливости"] = {"STA",},
		["к интеллекту"] = {"INT",},
		["к духу"] = {"SPI",},
		["к здоровью"] = {"HEALTH",},
		["HP"] = {"HEALTH",},
		["Mana"] = {"MANA",},

		["сила атаки"] = {"AP",},
		["сила атаки увеличена на"] = {"AP",},
		["к силе атаки"] = {"AP",},
		["увеличение силы атаки на"] = {"AP",},
		["увеличивает силу атаки на"] = {"AP",},
		["увеличивает силу атаки наед"] = {"AP",},
		["Увеличение силы атаки в дальнем бою наед"] = {"RANGED_AP",}, -- [High Warlord's Crossbow] ID: 18837

		["здоровья каждые"] = {"HEALTH_REG",}, -- Frostwolf Insignia Rank 6 ID:17909
		["здоровья раз в"] = {"HEALTH_REG",}, -- [Resurgence Rod] ID:17743
		["ед. здоровья каждые 5 секунд"] = {"HEALTH_REG",}, -- [Royal Nightseye] ID: 24057
		["ед. здоровья каждые 5 сек"] = {"HEALTH_REG",}, -- [Royal Nightseye] ID: 24057
		["скорости восполнения здоровья - "] = {"HEALTH_REG",}, -- Demons Blood ID: 10779
		["восполняетед. здоровья каждые 5 сек"] = {"HEALTH_REG",}, -- [Onyxia Blood Talisman] ID: 18406
		["восполнениеед. здоровья каждые 5 сек"] = {"HEALTH_REG",}, -- [Resurgence Rod] ID:17743

		["маны раз в"] = {"MANA_REG",}, -- Resurgence Rod ID:17743 Most common
		["ед%. маны раз в 5 сек"] = {"MANA_REG",},
		["ед%. маны в 5 сек"] = {"MANA_REG",},
		["маны каждые 5 секунд"] = {"MANA_REG",}, -- [Royal Nightseye] ID: 24057
		["ед%. маны каждые 5 секунд"] = {"MANA_REG",}, -- [Royal Nightseye] ID: 24057
		["восполнениеманы раз в 5 сек."] = {"MANA_REG",}, -- [Resurgence Rod] ID:17743

		["проникающая способность заклинаний"] = {"SPELLPEN",}, -- Enchant Cloak - Spell Penetration "+20 Spell Penetration" http://wow.allakhazam.com/db/spell.html?wspell=34003
		["к проникающей способности заклинаний"] = {"SPELLPEN",}, -- Enchant Cloak - Spell Penetration "+20 Spell Penetration" http://wow.allakhazam.com/db/spell.html?wspell=34003
		["увеличение наед%. проникающей способности заклинаний на"] = {"SPELLPEN",},

       	["Увеличивает силу заклинаний на"] = {"SPELL_DMG", "HEAL",},
		["увеличивает силу заклинаний наед"] = {"SPELL_DMG", "HEAL",},
		["к урону от заклинаний и лечению"] = {"SPELL_DMG", "HEAL",},
		["к урону от заклинаний"] = {"SPELL_DMG", "HEAL",},
		["к силе заклинаний"] = {"SPELL_DMG", "HEAL",},
		["Увеличение урона и целительного действия магических заклинаний и эффектов"] = {"SPELL_DMG", "HEAL"},
		["к урону заклинаний от магии льда"] = {"FROST_SPELL_DMG",}, -- Acrobatic Staff of Frozen Wrath ID:3185:0:0:0:0:0:1957

		["Увеличение урона от светлой магии, действие до"] = {"HOLY_SPELL_DMG",}, -- Drape of the Righteous ID:30642
		["к лечению"] = {"HEAL",}, -- [Royal Nightseye] ID: 24057
		["Добавляетурона в секунду"] = {"DPS",}, -- [Thorium Shells] ID: 15977

		["рейтинг защиты"] = {"DEFENSE_RATING",},
		["увеличивает рейтинг защиты на"] = {"DEFENSE_RATING",}, -- [Golem Skull Helm] ID: 11746
		["к рейтингу защиты"] = {"DEFENSE_RATING",},
		["увеличение рейтинга защиты наед"] = {"DEFENSE_RATING",},
		["рейтинг уклонения"] = {"DODGE_RATING",},
		["к рейтингу уклонения"] = {"DODGE_RATING",},
		["увеличение рейтинга уклонения наед"] = {"DODGE_RATING",},
		["рейтинг парирования"] = {"PARRY_RATING",},
		["к рейтингу парирования"] = {"PARRY_RATING",},
		["рейтинг блокирования щитом"] = {"BLOCK_RATING",}, -- Enchant Shield - Lesser Block +10 Shield Block Rating http://wow.allakhazam.com/db/spell.html?wspell=13689
		["к рейтингу блока"] = {"BLOCK_RATING",}, --

		["рейтинг меткости"] = {"MELEE_HIT_RATING", "SPELL_HIT_RATING",},
		["к рейтингу меткости"] = {"MELEE_HIT_RATING", "SPELL_HIT_RATING",},
		["увеличение рейтинга меткости наед"] = {"MELEE_HIT_RATING", "SPELL_HIT_RATING",},
		["к рейтингу меткости заклинаний"] = {"SPELL_HIT_RATING",}, -- Presence of Sight +18 Healing and Spell Damage/+8 Spell Hit http://wow.allakhazam.com/db/spell.html?wspell=24164
		["рейтинг меткости (заклинания)"] = {"SPELL_HIT_RATING",},


		--["Critical Rating"] = {"MELEE_CRIT_RATING",}, -- БАГ - непереведенный камень (+8 att power + 5 crit rate)
		["рейтинг критического удара"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING",},
		["к рейтингу критического удара"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING",},
		["рейтинг крит%. удара оруж%. ближнего боя"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING",},
		["рейтинг критического удара (заклинания)"] = {"SPELL_CRIT_RATING",},
		["к рейтингу критического удара заклинаниями"] = {"SPELL_CRIT_RATING",},
		["к рейтингу критического удара заклинанием"] = {"SPELL_CRIT_RATING",},
		["Увеличение рейтинга критического эффекта заклинаний наед"] = {"SPELL_CRIT_RATING",},

		["Устойчивость"] = {"RESILIENCE_RATING",},
		["к устойчивости"] = {"RESILIENCE_RATING",},
		["рейтинг устойчивости"] = {"RESILIENCE_RATING",}, -- Enchant Chest - Major Resilience "+15 Resilience Rating" http://wow.allakhazam.com/db/spell.html?wspell=33992
		["к рейтингу устойчивости"] = {"RESILIENCE_RATING",}, -- Enchant Chest - Major Resilience "+15 Resilience Rating" http://wow.allakhazam.com/db/spell.html?wspell=33992
		
		["рейтинг скорости"] = {"MELEE_HASTE_RATING", "SPELL_HASTE_RATING"},
		["рейтинг скорости боя"] = {"MELEE_HASTE_RATING", "SPELL_HASTE_RATING"},
		["к рейтингу скорости боя"] = {"MELEE_HASTE_RATING", "SPELL_HASTE_RATING"},
		["к рейтингу скорости заклинаний"] = {"SPELL_HASTE_RATING"},
		["рейтинг скорости боя (заклинания)"] = {"SPELL_HASTE_RATING"},

		["рейтинг мастерства"] = {"EXPERTISE_RATING"},
		["к рейтингу мастерства"] = {"EXPERTISE_RATING"},
	},
}
DisplayLocale.ruRU = DisplayLocale.enUS

-- esES localization by Kaie Estirpe de las Sombras from Minahonda
PatternLocale.esES = {
	["tonumber"] = function(s)
		local n = tonumber(s)
		if n then
			return n
		else
			return tonumber((gsub(s, ",", "%.")))
		end
	end,
	-----------------
	-- Armor Types --
	-----------------
	Plate = "Placas",
	Mail = "Mallas",
	Leather = "Cuero",
	Cloth = "Tela",
	------------------
	-- Fast Exclude --
	------------------
	-- ExcludeLen Mirando a las primeras letras de una linea podemos excluir un monton de lineas
	["ExcludeLen"] = 5, -- using string.utf8len
	["Exclude"] = {
		[""] = true,
		[" \n"] = true,
		[ITEM_BIND_ON_EQUIP] = true, -- ITEM_BIND_ON_EQUIP = "Binds when equipped"; -- Item will be bound when equipped
		[ITEM_BIND_ON_PICKUP] = true, -- ITEM_BIND_ON_PICKUP = "Binds when picked up"; -- Item wil be bound when picked up
		[ITEM_BIND_ON_USE] = true, -- ITEM_BIND_ON_USE = "Binds when used"; -- Item will be bound when used
		[ITEM_BIND_QUEST] = true, -- ITEM_BIND_QUEST = "Quest Item"; -- Item is a quest item (same logic as ON_PICKUP)
		[ITEM_SOULBOUND] = true, -- ITEM_SOULBOUND = "Soulbound"; -- Item is Soulbound
		--[EMPTY_SOCKET_BLUE] = true, -- EMPTY_SOCKET_BLUE = "Blue Socket";
		--[EMPTY_SOCKET_META] = true, -- EMPTY_SOCKET_META = "Meta Socket";
		--[EMPTY_SOCKET_RED] = true, -- EMPTY_SOCKET_RED = "Red Socket";
		--[EMPTY_SOCKET_YELLOW] = true, -- EMPTY_SOCKET_YELLOW = "Yellow Socket";
		[ITEM_STARTS_QUEST] = true, -- ITEM_STARTS_QUEST = "This Item Begins a Quest"; -- Item is a quest giver
		[ITEM_CANT_BE_DESTROYED] = true, -- ITEM_CANT_BE_DESTROYED = "That item cannot be destroyed."; -- Attempted to destroy a NO_DESTROY item
		[ITEM_CONJURED] = true, -- ITEM_CONJURED = "Conjured Item"; -- Item expires
		[ITEM_DISENCHANT_NOT_DISENCHANTABLE] = true, -- ITEM_DISENCHANT_NOT_DISENCHANTABLE = "Cannot be disenchanted"; -- Items which cannot be disenchanted ever
		--["Desen"] = true, -- ITEM_DISENCHANT_ANY_SKILL = "Disenchantable"; -- Items that can be disenchanted at any skill level
		--["Durac"] = true, -- ITEM_DURATION_DAYS = "Duration: %d days";
		["Tiemp"] = true, -- temps de recharge…
		["<Hecho"] = true, -- artisan
		["Único"] = true, -- Unique (20)
		["Nivel"] = true, -- Niveau
		["\nNive"] = true, -- Niveau
		["Clase"] = true, -- Classes: xx
		["Razas"] = true, -- Races: xx (vendor mounts)
		["Uso: "] = true, -- Utiliser:
		["Posib"] = true, -- Chance de toucher:
		["Requi"] = true, -- Requiert
		["\nRequ"] = true,-- Requiert
		["Neces"] = true,--nécessite plus de gemmes...
		-- Set Bonuses
		["Bonif"] = true,--ensemble
		["(2) B"] = true,
		["(2) B"] = true,
		["(3) B"] = true,
		["(4) B"] = true,
		["(5) B"] = true,
		["(6) B"] = true,
		["(7) B"] = true,
		["(8) B"] = true,
		-- Equip type
		["Proye"] = true, -- Ice Threaded Arrow ID:19316
		[INVTYPE_AMMO] = true,
		[INVTYPE_HEAD] = true,
		[INVTYPE_NECK] = true,
		[INVTYPE_SHOULDER] = true,
		[INVTYPE_BODY] = true,
		[INVTYPE_CHEST] = true,
		[INVTYPE_ROBE] = true,
		[INVTYPE_WAIST] = true,
		[INVTYPE_LEGS] = true,
		[INVTYPE_FEET] = true,
		[INVTYPE_WRIST] = true,
		[INVTYPE_HAND] = true,
		[INVTYPE_FINGER] = true,
		[INVTYPE_TRINKET] = true,
		[INVTYPE_CLOAK] = true,
		[INVTYPE_WEAPON] = true,
		[INVTYPE_SHIELD] = true,
		[INVTYPE_2HWEAPON] = true,
		[INVTYPE_WEAPONMAINHAND] = true,
		[INVTYPE_WEAPONOFFHAND] = true,
		[INVTYPE_HOLDABLE] = true,
		[INVTYPE_RANGED] = true,
		[INVTYPE_THROWN] = true,
		[INVTYPE_RANGEDRIGHT] = true,
		[INVTYPE_RELIC] = true,
		[INVTYPE_TABARD] = true,
		[INVTYPE_BAG] = true,
	},

	-----------------------
	-- Whole Text Lookup --
	-----------------------
	-- Usado principalmente para encantamientos que no tienen numeros en el texto
	["WholeTextLookup"] = {
		[EMPTY_SOCKET_RED] = {["EMPTY_SOCKET_RED"] = 1}, -- EMPTY_SOCKET_RED = "Red Socket";
		[EMPTY_SOCKET_YELLOW] = {["EMPTY_SOCKET_YELLOW"] = 1}, -- EMPTY_SOCKET_YELLOW = "Yellow Socket";
		[EMPTY_SOCKET_BLUE] = {["EMPTY_SOCKET_BLUE"] = 1}, -- EMPTY_SOCKET_BLUE = "Blue Socket";
		[EMPTY_SOCKET_META] = {["EMPTY_SOCKET_META"] = 1}, -- EMPTY_SOCKET_META = "Meta Socket";

		--ToDo
		["Aceite de zahorí menor"] = {["SPELL_DMG"] = 8, ["HEAL"] = 8}, --
		["Aceite de zahorí inferior"] = {["SPELL_DMG"] = 16, ["HEAL"] = 16}, --
		["Aceite de zahorí"] = {["SPELL_DMG"] = 24, ["HEAL"] = 24}, --
		["Aceite de zahorí luminoso"] = {["SPELL_DMG"] = 36, ["HEAL"] = 36, ["SPELL_CRIT_RATING"] = 14}, --
		["Aceite de zahorí excelente"] = {["SPELL_DMG"] = 42, ["HEAL"] = 42}, --
		["Aceite de zahorí bendito"] = {["SPELL_DMG_UNDEAD"] = 60}, --

		["Aceite de maná menor"] = {["MANA_REG"] = 4}, --
		["Aceite de maná inferior"] = {["MANA_REG"] = 8}, --
		["Aceite de maná luminoso"] = {["MANA_REG"] = 12, ["HEAL"] = 25}, --
		["Aceite de maná excelente"] = {["MANA_REG"] = 14}, --

		["Sedal de eternio"] = {["FISHING"] = 5}, --
		["Fuego solar"] = {["ARCANE_SPELL_DMG"] = 50, ["FIRE_SPELL_DMG"] = 50}, --
		["Velocidad de la montura"] = {["MOUNT_SPEED"] = 2}, -- Enchant Gloves - Riding Skill
		["Pies de plomo"] = {["MELEE_HIT_RATING"] = 10}, -- Enchant Boots - Surefooted "Surefooted" http://wow.allakhazam.com/db/spell.html?wspell=27954

		["Sutileza"] = {["MOD_THREAT"] = -2}, -- Enchant Cloak - Subtlety
		-- ["2% Reduced Threat"] = {["MOD_THREAT"] = -2}, -- StatLogic:GetSum("item:23344:2832")
		["Equipar: Permite respirar bajo el agua"] = false, -- [Band of Icy Depths] ID: 21526
		["Permite respirar bajo el agua"] = false, --
		["Equipar: Duración de Desarmar reducida"] = false, -- [Stronghold Gauntlets] ID: 12639
		["Immune a desarmar"] = false, --
		["Robo de vida"] = false, -- Enchant Crusader

		--translated
		["Espuelas de mitril"] = {["MOUNT_SPEED"] = 4}, -- Mithril Spurs
		["Equipar: Velocidad de carrera aumentada ligeramente"] = {["RUN_SPEED"] = 8}, -- [Highlander's Plate Greaves] ID: 20048"
		["Aumenta ligeramente la velocidad de movimiento"] = {["RUN_SPEED"] = 8}, --
		["Aumenta ligeramente la velocidad de movimiento"] = {["RUN_SPEED"] = 8}, -- Enchant Boots - Minor Speed "Minor Speed Increase" http://wow.allakhazam.com/db/spell.html?wspell=13890
		["Vitalidad"] = {["MANA_REG"] = 4, ["HEALTH_REG"] = 4}, -- Enchant Boots - Vitality "Vitality" http://wow.allakhazam.com/db/spell.html?wspell=27948
		["Escarcha de alma"] = {["SHADOW_SPELL_DMG"] = 54, ["FROST_SPELL_DMG"] = 54}, --
		["Salvajismo"] = {["AP"] = 70}, --
		["Velocidad menor"] = {["RUN_SPEED"] = 8},
		-- ["Vitesse mineure et +9 en Endurance"] = {["RUN_SPEED"] = 8, ["STA"] = 9},--enchant

		["Cruzado"] = false, -- Enchant Crusader
		["Mangosta"] = false, -- Enchant Mangouste
		["Arma impia"] = false,
		-- ["Équipé : Evite à son porteur d'être entièrement englobé dans la Flamme d'ombre."] = false, --cape Onyxia
	},
	----------------------------
	-- Single Plus Stat Check --
	----------------------------
	["SinglePlusStatCheck"] = "^([%+%-]%d+) (.-)%.?$",
	-----------------------------
	-- Single Equip Stat Check --
	-----------------------------
	["SingleEquipStatCheck"] = "^Equipar: (.-) h?a?s?t?a? ?(%d+)(.-)?%.$",

	-------------
	-- PreScan --
	-------------
	-- Special cases that need to be dealt with before deep scan
	["PreScanPatterns"] = {
		["^(%d+) bloqueo$"] = "BLOCK_VALUE",
		["^(%d+) armadura$"] = "ARMOR",
		["^Equipar: Restaura (%d+) p. de salud cada 5 s"]= "HEAL_REG",
		["^Equipar: Restaura (%d+) p. de maná cada 5 s"]= "MANA_REG",
		["^Equipar: Aumenta (%d+) p. el poder de ataque"]= "AP",
		-- ["^Equipar: Mejora tu índice de golpe crítico (%d+) p"]= "MELEE_CRIT_RATING",
		["Refuerza %(%+(%d+) Armadura%)"]= "ARMOR_BONUS",
		-- ["Lunette %(%+(%d+) points? de dégâts?%)"]="RANGED_AP",
		["^%+?%d+ %- (%d+) .-Daño$"] = "MAX_DAMAGE",
		["^%(([%d%,]+) daño por segundo%)$"] = "DPS",

		-- Exclude
		["^.- %(%d+/%d+%)$"] = false, -- Set Name (0/9)
		["|cff808080"] = false, -- Gray text "  |cff808080Requires at least 2 Yellow gems|r\n  |cff808080Requires at least 1 Red gem|r"
		--["Confère une chance"] = false, -- [Mark of Defiance] ID:27924 -- [Staff of the Qiraji Prophets] ID:21128
		["A veces ganas"] = false, -- [Darkmoon Card: Heroism] ID:19287
		["Ganas una Carga"] = false, -- El condensador de rayos ID:28785
		["Daño:"] = false, -- ligne de degats des armes
		["Tu técnica"] = false,
		["^%+?%d+ %- %d+ puntos de daño %(.-%)$"]= false, -- ligne de degats des baguettes/ +degats (Thunderfury)
		-- ["Permettent au porteur"] = false, -- Casques Ombrelunes
		-- ["^.- %(%d+%) requis"] = false, --metier requis pour porter ou utiliser
		-- ["^.- ?[Vv]?o?u?s? [Cc]onfèren?t? .-"] = false, --proc
		-- ["^.- ?l?e?s? ?[Cc]hances .-"] = false, --proc
		-- ["^.- par votre sort .-"] = false, --augmentation de capacité de sort
		-- ["^.- la portée de .-"] = false, --augmentation de capacité de sort
		-- ["^.- la durée de .-"] = false, --augmentation de capacité de sort
	},
	--------------
	-- DeepScan --
	--------------
	-- Strip leading "Equip: ", "Socket Bonus: "
	["Equip: "] = "Equipar: ", --\194\160= espacio requerido
	["Socket Bonus: "] = "Bonus ranura: ",
		-- Strip trailing "."
	["."] = ".",
	["DeepScanSeparators"] = {
		"/", -- "+10 Defense Rating/+10 Stamina/+15 Block Value": ZG Enchant
		" y " , -- "+26 Healing Spells & 2% Reduced Threat": Bracing Earthstorm Diamond ID:25897
		", " , -- "+6 Spell Damage, +5 Spell Crit Rating": Potent Ornate Topaz ID: 28123
		"[^p]%." , -- cuando es p y punto no separa
	},
	["DeepScanWordSeparators"] = {
		 " y ", -- "Critical Rating +6 and Dodge Rating +5": Assassin's Fire Opal ID:30565
	},
	["DualStatPatterns"] = { -- all lower case
		["la salud %+(%d+) y el daño %+ (%d+)$"] = {{"HEAL",}, {"SPELL_DMG",},},
		["la salud %+(%d+) el dano %+ (%d+)"] = {{"HEAL",}, {"SPELL_DMG",},},
		["salud un máximo de (%d+) y el dano un máximo de (%d+)"] = {{"HEAL",}, {"SPELL_DMG",},},
	},
	["DeepScanPatterns"] = {
		"^(.-) ?(%d+) ?(.-)$", -- "xxx by up to 22 xxx" (scan first)
		-- "^(.-)5 [Ss]ek%. (%d+) (.-)$",  -- "xxx 5 Sek. 8 xxx" (scan 2nd)
		"^(.-) ?([%+%-]%d+) ?(.-)$", -- "xxx xxx +22" or "+22 xxx xxx" or "xxx +22 xxx" (scan 3rd)
		"^(.-) ?([%d%,]+) ?(.-)$", -- 22.22 xxx xxx (scan last)
	},
	-----------------------
	-- Stat Lookup Table --
	-----------------------
	["StatIDLookup"] = {
		["Mira de korio"] = {"RANGED_DMG"}, -- Khorium Scope EnchantID: 2723
		["Scope (Critical Strike Rating)"] = {"RANGED_CRIT_RATING"}, -- Stabilized Eternium Scope EnchantID: 2724
		["Your attacks ignoreof your opponent's armor"] = {"IGNORE_ARMOR"}, -- StatLogic:GetSum("item:33733")
		["% Threat"] = {"MOD_THREAT"}, -- StatLogic:GetSum("item:23344:2613")
		["Aumenta tu nivel efectivo de sigilo enp"] = {"STEALTH_LEVEL"}, -- [Nightscape Boots] ID: 8197
		-- ["Velocidad de carrera"] = {"MOUNT_SPEED"}, -- [Highlander's Plate Greaves] ID: 20048


		--dano melee
		["daño de arma"] = {"MELEE_DMG"},
		["daño del arma"] = {"MELEE_DMG"},
		["daño en melee"] = {"MELEE_DMG"},
		["daño de melee"] = {"MELEE_DMG"},


		--caracteristicas
		["todas las estadísticas"] = {"STR", "AGI", "STA", "INT", "SPI",},
		["Fuerza"] = {"STR",},
		["Agilidad"] = {"AGI",},
		["Aguante"] = {"STA",},
		["Intelecto"] = {"INT",},
		["Espíritu"] = {"SPI",},


		--resistencias
		["resistencia arcana"] = {"ARCANE_RES",},
		["resistencia a Arcano"] = {"ARCANE_RES",},

		["resistencia al fuego"] = {"FIRE_RES",},
		["resistencia al Fuego"] = {"FIRE_RES",},

		["resistencia a la naturaleza"] = {"NATURE_RES",},
		["resistencia a Naturaleza"] = {"NATURE_RES",},

		["resistencia a la Escarcha"] = {"FROST_RES",},
		["resistencia a Escarcha"] = {"FROST_RES",},

		["resistencia a Sombras"] = {"SHADOW_RES",},
		["resistencia a las sombras"] = {"SHADOW_RES",},

		["a todas las resistencias"] = {"ARCANE_RES", "FIRE_RES", "FROST_RES", "NATURE_RES", "SHADOW_RES",},

		--artesano
		["pesca"] = {"FISHING",},
		["mineria"] = {"MINING",},
		["herboristeria"] = {"HERBALISM",}, -- Heabalism enchant ID:845
		["desollar"] = {"SKINNING",}, -- Skinning enchant ID:865

		--
		["armadura"] = {"ARMOR_BONUS",},

		["defensa"] = {"DEFENSE",},

		["valor de bloqueo"] = {"BLOCK_VALUE",},
		["al valor de bloqueo"] = {"BLOCK_VALUE",},
		["aumenta el valor de bloqueo de tu escudop"] = {"BLOCK_VALUE",},

		["salud"] = {"HEALTH",},
		["puntos de vida"] = {"HEALTH",},
		["puntos de maná"] = {"MANA",},

		["aumenta el poder de ataquep"] = {"AP",},
		["al poder de ataque"] = {"AP",},
		["poder de ataque"] = {"AP",},
		["aumentap. el poder ataque"] = {"AP",}, -- id:38045



		--ToDo
		["Aumenta el poder de ataque contra muertos vivientes"] = {"AP_UNDEAD",},
		--["Increases attack powerwhen fighting Undead"] = {"AP_UNDEAD",},
		--["Increases attack powerwhen fighting Undead.  It also allows the acquisition of Scourgestones on behalf of the Argent Dawn"] = {"AP_UNDEAD",},
		--["Increases attack powerwhen fighting Demons"] = {"AP_DEMON",},
		--["Attack Power in Cat, Bear, and Dire Bear forms only"] = {"FERAL_AP",},
		--["Increases attack powerin Cat, Bear, Dire Bear, and Moonkin forms only"] = {"FERAL_AP",},


		--ranged AP
		["el poder de ataque a distancia"] = {"RANGED_AP",},
		--Feral
		["el poder de ataque para la formas felina, de oso"] = {"FERAL_AP",},

		--regenerar
		["maná cada 5 segundos"] = {"MANA_REG",},
		["maná cada 5 s"] = {"MANA_REG",},
		["puntos de vida cada 5 segundos"] = {"HEALTH_REG",},
		["puntos de salud cada 5 segundos"] = {"HEALTH_REG",},
		["points de mana toutes les 5 sec"] = {"MANA_REG",},
		["points de vie toutes les 5 sec"] = {"HEALTH_REG",},
		["p. de maná cada 5 s."] = {"MANA_REG",},
		["p. de salud cada 5 s."] = {"HEALTH_REG",},
		["regeneración de maná"] = {"MANA_REG",},


		--penetración de hechizos
		["aumenta el índice de penetración de tus hechizosp"] = {"SPELLPEN",},
		["penetración del hechizo"] = {"SPELLPEN",},
		["aumenta el índice de penetración de armadurap"] = {"SPELLPEN",},

		--Puissance soins et sorts
		["poder con hechizos"] = {"SPELL_DMG", "HEAL"},
		["el poder con hechizos"] = {"SPELL_DMG", "HEAL"},
		["Aumenta el poder con hechizosp"] = {"SPELL_DMG", "HEAL"},


		--ToDo
		["Augmente les dégâts infligés aux morts-vivants par les sorts et effets magiques d'un maximum de"] = {"SPELL_DMG_UNDEAD"},

		["el daño inflingido por los hechizos de sombras"]={"SHADOW_SPELL_DMG",},
		["el daño de hechizo de sombras"]={"SHADOW_SPELL_DMG",},
		["el daño de sombras"]={"SHADOW_SPELL_DMG",},

		["el daño inflingido por los hechizos de escarcha"]={"FROST_SPELL_DMG",},
		["el daño de hechizos de escarcha"]={"FROST_SPELL_DMG",},
		["el daño de escarcha"]={"FROST_SPELL_DMG",},

		["el daño inflingido por los hechizos de fuego"]={"FIRE_SPELL_DMG",},
		["el daño de hechizos de fuego"]={"FIRE_SPELL_DMG",},
		["el daño de fuego"]={"FIRE_SPELL_DMG",},

		["el daño inflingido por los hechizos de naturaleza"]={"NATURE_SPELL_DMG",},
		["el daño de hechizos de naturaleza"]={"NATURE_SPELL_DMG",},
		["el daño de naturaleza"]={"NATURE_SPELL_DMG",},

		["el daño inflingido por los hechizos arcanos"]={"ARCANE_SPELL_DMG",},
		["el daño de hechizos arcanos"]={"ARCANE_SPELL_DMG",},
		["el daño arcano"]={"ARCANE_SPELL_DMG",},

		["el daño inflingido por los hechizos de sagrado"]={"HOLY_SPELL_DMG",},
		["el daño de hechizos sagrado"]={"HOLY_SPELL_DMG",},
		["el daño de sagrado"]={"HOLY_SPELL_DMG",},

		--ToDo
		--["Healing Spells"] = {"HEAL",}, -- Enchant Gloves - Major Healing "+35 Healing Spells" http://wow.allakhazam.com/db/spell.html?wspell=33999
		--["Increases Healing"] = {"HEAL",},
		--["Healing"] = {"HEAL",},
		--["healing Spells"] = {"HEAL",},
		--["Healing Spells"] = {"HEAL",}, -- [Royal Nightseye] ID: 24057
		--["Increases healing done by spells and effects"] = {"HEAL",},
		--["Increases healing done by magical spells and effects of all party members within 30 yards"] = {"HEAL",}, -- Atiesh
		--["your healing"] = {"HEAL",}, -- Atiesh

		["da/195/177o por segundo"] = {"DPS",},
		--["Addsdamage per second"] = {"DPS",}, -- [Thorium Shells] ID: 15977

		["índice de defensa"] = {"DEFENSE_RATING",},
		["aumenta tu índice de defensap"] = {"DEFENSE_RATING",},
		["tu índice de defensa"] = {"DEFENSE_RATING",},

		["índice de esquivar"] = {"DODGE_RATING",},
		["aumenta tu índice de esquivarp"] = {"DODGE_RATING",},
		["tu índice de esquivar"] = {"DODGE_RATING",},

		["índice de parada"] = {"PARRY_RATING",},
		["tu índice de parada"] = {"PARRY_RATING",},
		["Aumenta tu índice de paradap"] = {"PARRY_RATING",},
		["Aumenta el índice de parada"] = {"PARRY_RATING",},

		["índice de bloqueo"] = {"BLOCK_RATING",}, -- Enchant Shield - Lesser Block +10 Shield Block Rating http://wow.allakhazam.com/db/spell.html?wspell=13689
		["aumenta el índice de bloqueo"] = {"BLOCK_RATING",},
		["tu índice de bloqueo"] = {"BLOCK_RATING",},

		["mejora tu índice de golpep"] = {"MELEE_HIT_RATING", "SPELL_HIT_RATING",},
		["índice de golpe"] = {"MELEE_HIT_RATING", "SPELL_HIT_RATING",},
		["tu índice de golpep"] = {"MELEE_HIT_RATING", "SPELL_HIT_RATING"},

		["mejora tu índice de golpe críticop"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING",},
		["índice de criticop"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING",},
		["tu índice de golpe críticop"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING",},

		["índice de temple"] = {"RESILIENCE_RATING",},
		["Mejora tu índice de templep"] = {"RESILIENCE_RATING",},
		["tu índice de temple"] = {"RESILIENCE_RATING",},
		["al temple"] = {"RESILIENCE_RATING",},

		["tu índice de golpe con hechizos"] = {"SPELL_HIT_RATING",},
		["índice de golpe de hechizos"] = {"SPELL_HIT_RATING",},
		["tu indice de golpe con hechizos"] = {"SPELL_HIT_RATING",},

		["el indice de golpe critico de hechizo"] = {"SPELL_CRIT_RATING",},
		["indice de golpe critico de los hechizos"] = {"SPELL_CRIT_RATING",},
		["indice de critico con hechizos"] = {"SPELL_CRIT_RATING",},

		--ToDo
		--["Ranged Hit Rating"] = {"RANGED_HIT_RATING",},
		--["Improves ranged hit rating"] = {"RANGED_HIT_RATING",}, -- ITEM_MOD_HIT_RANGED_RATING
		--["Increases your ranged hit rating"] = {"RANGED_HIT_RATING",},
		--["votre score de coup critique à distance"] = {"RANGED_CRIT_RATING",}, -- Fletcher's Gloves ID:7348

		["índice de celeridad"] = {"MELEE_HASTE_RATING", "SPELL_HASTE_RATING"},
		["mejora tu índice de celeridadp"] = {"MELEE_HASTE_RATING", "SPELL_HASTE_RATING",},
		["Mejora tu índice de celeridad"] = {"SPELL_HASTE_RATING"},
		["Mejora el índice de celeriad"] = {"RANGED_HASTE_RATING"},
		--["Improves haste rating"] = {"MELEE_HASTE_RATING"},
		--["Improves melee haste rating"] = {"MELEE_HASTE_RATING"},
		--["Improves ranged haste rating"] = {"SPELL_HASTE_RATING"},
		--["Improves spell haste rating"] = {"RANGED_HASTE_RATING"},

		["tu índice de pericia"] = {"EXPERTISE_RATING"},
		["el índice de pericia"] = {"EXPERTISE_RATING"},

		["índice de penetración de armadura"] = {"ARMOR_PENETRATION_RATING"}, -- gems
		-- ["Increases your expertise rating"] = {"EXPERTISE_RATING"},
		-- ["Increases armor penetration rating"] = {"ARMOR_PENETRATION_RATING"},
		["Aumenta tu índice de penetración de armadurap"] = {"ARMOR_PENETRATION_RATING"}, -- ID:43178

		-- no traducidos no se si se utilizan actualmente
		["le score de la compétence dagues"] = {"DAGGER_WEAPON_RATING"},
		["score de la compétence dagues"] = {"DAGGER_WEAPON_RATING"},
		["le score de la compétence epées"] = {"SWORD_WEAPON_RATING"},
		["score de la compétence epées"] = {"SWORD_WEAPON_RATING"},
		["le score de la compétence epées à deux mains"] = {"2H_SWORD_WEAPON_RATING"},
		["score de la compétence epées à deux mains"] = {"2H_SWORD_WEAPON_RATING"},
		["le score de la compétence masses"]= {"MACE_WEAPON_RATING"},
		["score de la compétence masses"]= {"MACE_WEAPON_RATING"},
		["le score de la compétence masses à deux mains"]= {"2H_MACE_WEAPON_RATING"},
		["score de la compétence masses à deux mains"]= {"2H_MACE_WEAPON_RATING"},
		["le score de la compétence haches"] = {"AXE_WEAPON_RATING"},
		["score de la compétence haches"] = {"AXE_WEAPON_RATING"},
		["le score de la compétence haches à deux mains"] = {"2H_AXE_WEAPON_RATING"},
		["score de la compétence haches à deux mains"] = {"2H_AXE_WEAPON_RATING"},

		["le score de la compétence armes de pugilat"] = {"FIST_WEAPON_RATING"},
		["le score de compétence combat farouche"] = {"FERAL_WEAPON_RATING"},
		["le score de la compétence mains nues"] = {"FIST_WEAPON_RATING"},

		--ToDo
		--["Increases gun skill rating"] = {"GUN_WEAPON_RATING"},
		--["Increases Crossbow skill rating"] = {"CROSSBOW_WEAPON_RATING"},
		--["Increases Bow skill rating"] = {"BOW_WEAPON_RATING"},

		--ToDo
		-- Exclude
		--["sec"] = false,
		--["to"] = false,
		["Bolsa"] = false,
		--["Slot Quiver"] = false,
		--["Slot Ammo Pouch"] = false,
		--["Increases ranged attack speed"] = false, -- AV quiver
	},
}
DisplayLocale.esES = {
	--ToDo
	----------------
	-- Stat Names --
	----------------
	-- Please localize these strings too, global strings were used in the enUS locale just to have minimum
	-- localization effect when a locale is not available for that language, you don't have to use global
	-- strings in your localization.
  ["Stat Multiplier"] = "Stat Multiplier",
  ["Attack Power Multiplier"] = "Attack Power Multiplier",
  ["Reduced Physical Damage Taken"] = "Reduced Physical Damage Taken",
	["StatIDToName"] = {
		--[StatID] = {FullName, ShortName},
		---------------------------------------------------------------------------
		-- Tier1 Stats - Stats parsed directly off items
		["EMPTY_SOCKET_RED"] = {EMPTY_SOCKET_RED, EMPTY_SOCKET_RED}, -- EMPTY_SOCKET_RED = "Red Socket";
		["EMPTY_SOCKET_YELLOW"] = {EMPTY_SOCKET_YELLOW, EMPTY_SOCKET_YELLOW}, -- EMPTY_SOCKET_YELLOW = "Yellow Socket";
		["EMPTY_SOCKET_BLUE"] = {EMPTY_SOCKET_BLUE, EMPTY_SOCKET_BLUE}, -- EMPTY_SOCKET_BLUE = "Blue Socket";
		["EMPTY_SOCKET_META"] = {EMPTY_SOCKET_META, EMPTY_SOCKET_META}, -- EMPTY_SOCKET_META = "Meta Socket";

		["IGNORE_ARMOR"] = {"Ignore Armor", "Ignore Armor"},
		["STEALTH_LEVEL"] = {"Stealth Level", "Stealth"},
		["MELEE_DMG"] = {"Melee Weapon "..DAMAGE, "Wpn Dmg"}, -- DAMAGE = "Damage"
		["RANGED_DMG"] = {"Ranged Weapon "..DAMAGE, "Ranged Dmg"}, -- DAMAGE = "Damage"
		["MOUNT_SPEED"] = {"Mount Speed(%)", "Mount Spd(%)"},
		["RUN_SPEED"] = {"Run Speed(%)", "Run Spd(%)"},

		["STR"] = {SPELL_STAT1_NAME, "Str"},
		["AGI"] = {SPELL_STAT2_NAME, "Agi"},
		["STA"] = {SPELL_STAT3_NAME, "Sta"},
		["INT"] = {SPELL_STAT4_NAME, "Int"},
		["SPI"] = {SPELL_STAT5_NAME, "Spi"},
		["ARMOR"] = {ARMOR, ARMOR},
		["ARMOR_BONUS"] = {ARMOR.." from bonus", ARMOR.."(Bonus)"},

		["FIRE_RES"] = {RESISTANCE2_NAME, "FR"},
		["NATURE_RES"] = {RESISTANCE3_NAME, "NR"},
		["FROST_RES"] = {RESISTANCE4_NAME, "FrR"},
		["SHADOW_RES"] = {RESISTANCE5_NAME, "SR"},
		["ARCANE_RES"] = {RESISTANCE6_NAME, "AR"},

		["FISHING"] = {"Fishing", "Fishing"},
		["MINING"] = {"Mining", "Mining"},
		["HERBALISM"] = {"Herbalism", "Herbalism"},
		["SKINNING"] = {"Skinning", "Skinning"},

		["BLOCK_VALUE"] = {"Bloqueo", "Block Value"},

		["AP"] = {ATTACK_POWER_TOOLTIP, "AP"},
		["RANGED_AP"] = {RANGED_ATTACK_POWER, "RAP"},
		["FERAL_AP"] = {"Feral "..ATTACK_POWER_TOOLTIP, "Feral AP"},
		["AP_UNDEAD"] = {ATTACK_POWER_TOOLTIP.." (Undead)", "AP(Undead)"},
		["AP_DEMON"] = {ATTACK_POWER_TOOLTIP.." (Demon)", "AP(Demon)"},

		["HEAL"] = {"Sanacion", "Heal"},

		["SPELL_DMG"] = {PLAYERSTAT_SPELL_COMBAT.." "..DAMAGE, PLAYERSTAT_SPELL_COMBAT.." Dmg"},
		["SPELL_DMG_UNDEAD"] = {PLAYERSTAT_SPELL_COMBAT.." "..DAMAGE.." (Undead)", PLAYERSTAT_SPELL_COMBAT.." Dmg".."(Undead)"},
		["SPELL_DMG_DEMON"] = {PLAYERSTAT_SPELL_COMBAT.." "..DAMAGE.." (Demon)", PLAYERSTAT_SPELL_COMBAT.." Dmg".."(Demon)"},
		["HOLY_SPELL_DMG"] = {SPELL_SCHOOL1_CAP.." "..DAMAGE, SPELL_SCHOOL1_CAP.." Dmg"},
		["FIRE_SPELL_DMG"] = {SPELL_SCHOOL2_CAP.." "..DAMAGE, SPELL_SCHOOL2_CAP.." Dmg"},
		["NATURE_SPELL_DMG"] = {SPELL_SCHOOL3_CAP.." "..DAMAGE, SPELL_SCHOOL3_CAP.." Dmg"},
		["FROST_SPELL_DMG"] = {SPELL_SCHOOL4_CAP.." "..DAMAGE, SPELL_SCHOOL4_CAP.." Dmg"},
		["SHADOW_SPELL_DMG"] = {SPELL_SCHOOL5_CAP.." "..DAMAGE, SPELL_SCHOOL5_CAP.." Dmg"},
		["ARCANE_SPELL_DMG"] = {SPELL_SCHOOL6_CAP.." "..DAMAGE, SPELL_SCHOOL6_CAP.." Dmg"},

		["SPELLPEN"] = {PLAYERSTAT_SPELL_COMBAT.." "..SPELL_PENETRATION, SPELL_PENETRATION},

		["HEALTH"] = {HEALTH, HP},
		["MANA"] = {MANA, MP},
		["HEALTH_REG"] = {HEALTH.." Regen", "HP5"},
		["MANA_REG"] = {MANA.." Regen", "MP5"},

		["MAX_DAMAGE"] = {"Max Daño", "Max Dmg"},
		["DPS"] = {"Daño por segundo", "DPS"},

		["DEFENSE_RATING"] = {COMBAT_RATING_NAME2, COMBAT_RATING_NAME2}, -- COMBAT_RATING_NAME2 = "Defense Rating"
		["DODGE_RATING"] = {COMBAT_RATING_NAME3, COMBAT_RATING_NAME3}, -- COMBAT_RATING_NAME3 = "Dodge Rating"
		["PARRY_RATING"] = {COMBAT_RATING_NAME4, COMBAT_RATING_NAME4}, -- COMBAT_RATING_NAME4 = "Parry Rating"
		["BLOCK_RATING"] = {COMBAT_RATING_NAME5, COMBAT_RATING_NAME5}, -- COMBAT_RATING_NAME5 = "Block Rating"
		["MELEE_HIT_RATING"] = {COMBAT_RATING_NAME6, COMBAT_RATING_NAME6}, -- COMBAT_RATING_NAME6 = "Hit Rating"
		["RANGED_HIT_RATING"] = {PLAYERSTAT_RANGED_COMBAT.." "..COMBAT_RATING_NAME6, PLAYERSTAT_RANGED_COMBAT.." "..COMBAT_RATING_NAME6}, -- PLAYERSTAT_RANGED_COMBAT = "Ranged"
		["SPELL_HIT_RATING"] = {PLAYERSTAT_SPELL_COMBAT.." "..COMBAT_RATING_NAME6, PLAYERSTAT_SPELL_COMBAT.." "..COMBAT_RATING_NAME6}, -- PLAYERSTAT_SPELL_COMBAT = "Spell"
		["MELEE_HIT_AVOID_RATING"] = {"Hit Avoidance "..RATING, "Hit Avoidance "..RATING},
		["RANGED_HIT_AVOID_RATING"] = {PLAYERSTAT_RANGED_COMBAT.." Hit Avoidance "..RATING, PLAYERSTAT_RANGED_COMBAT.." Hit Avoidance "..RATING},
		["SPELL_HIT_AVOID_RATING"] = {PLAYERSTAT_SPELL_COMBAT.." Hit Avoidance "..RATING, PLAYERSTAT_SPELL_COMBAT.." Hit Avoidance "..RATING},
		["MELEE_CRIT_RATING"] = {COMBAT_RATING_NAME9, COMBAT_RATING_NAME9}, -- COMBAT_RATING_NAME9 = "Crit Rating"
		["RANGED_CRIT_RATING"] = {PLAYERSTAT_RANGED_COMBAT.." "..COMBAT_RATING_NAME9, PLAYERSTAT_RANGED_COMBAT.." "..COMBAT_RATING_NAME9},
		["SPELL_CRIT_RATING"] = {PLAYERSTAT_SPELL_COMBAT.." "..COMBAT_RATING_NAME9, PLAYERSTAT_SPELL_COMBAT.." "..COMBAT_RATING_NAME9},
		["MELEE_CRIT_AVOID_RATING"] = {"Crit Avoidance "..RATING, "Crit Avoidance "..RATING},
		["RANGED_CRIT_AVOID_RATING"] = {PLAYERSTAT_RANGED_COMBAT.." Crit Avoidance "..RATING, PLAYERSTAT_RANGED_COMBAT.." Crit Avoidance "..RATING},
		["SPELL_CRIT_AVOID_RATING"] = {PLAYERSTAT_SPELL_COMBAT.." Crit Avoidance "..RATING, PLAYERSTAT_SPELL_COMBAT.." Crit Avoidance "..RATING},
		["RESILIENCE_RATING"] = {COMBAT_RATING_NAME15, COMBAT_RATING_NAME15}, -- COMBAT_RATING_NAME15 = "Resilience"
		["MELEE_HASTE_RATING"] = {"Haste "..RATING, "Haste "..RATING}, --
		["RANGED_HASTE_RATING"] = {PLAYERSTAT_RANGED_COMBAT.." Haste "..RATING, PLAYERSTAT_RANGED_COMBAT.." Haste "..RATING},
		["SPELL_HASTE_RATING"] = {PLAYERSTAT_SPELL_COMBAT.." Haste "..RATING, PLAYERSTAT_SPELL_COMBAT.." Haste "..RATING},
		["DAGGER_WEAPON_RATING"] = {"Dagger "..SKILL.." "..RATING, "Dagger "..RATING}, -- SKILL = "Skill"
		["SWORD_WEAPON_RATING"] = {"Sword "..SKILL.." "..RATING, "Sword "..RATING},
		["2H_SWORD_WEAPON_RATING"] = {"Two-Handed Sword "..SKILL.." "..RATING, "2H Sword "..RATING},
		["AXE_WEAPON_RATING"] = {"Axe "..SKILL.." "..RATING, "Axe "..RATING},
		["2H_AXE_WEAPON_RATING"] = {"Two-Handed Axe "..SKILL.." "..RATING, "2H Axe "..RATING},
		["MACE_WEAPON_RATING"] = {"Mace "..SKILL.." "..RATING, "Mace "..RATING},
		["2H_MACE_WEAPON_RATING"] = {"Two-Handed Mace "..SKILL.." "..RATING, "2H Mace "..RATING},
		["GUN_WEAPON_RATING"] = {"Gun "..SKILL.." "..RATING, "Gun "..RATING},
		["CROSSBOW_WEAPON_RATING"] = {"Crossbow "..SKILL.." "..RATING, "Crossbow "..RATING},
		["BOW_WEAPON_RATING"] = {"Bow "..SKILL.." "..RATING, "Bow "..RATING},
		["FERAL_WEAPON_RATING"] = {"Feral "..SKILL.." "..RATING, "Feral "..RATING},
		["FIST_WEAPON_RATING"] = {"Unarmed "..SKILL.." "..RATING, "Unarmed "..RATING},
		["EXPERTISE_RATING"] = {"Expertise".." "..RATING, "Expertise".." "..RATING},
		["ARMOR_PENETRATION_RATING"] = {"Armor Penetration".." "..RATING, "ArP".." "..RATING},

		---------------------------------------------------------------------------
		-- Tier2 Stats - Stats that only show up when broken down from a Tier1 Stat
		-- Str -> AP, Block Value
		-- Agi -> AP, Crit, Dodge
		-- Sta -> Health
		-- Int -> Mana, Spell Crit
		-- Spi -> mp5nc, hp5oc
		-- Ratings -> Effect
		["HEALTH_REG_OUT_OF_COMBAT"] = {HEALTH.." Regen (Out of combat)", "HP5(OC)"},
		["MANA_REG_NOT_CASTING"] = {MANA.." Regen (Not casting)", "MP5(NC)"},
		["MELEE_CRIT_DMG_REDUCTION"] = {"Crit Damage Reduction(%)", "Crit Dmg Reduc(%)"},
		["RANGED_CRIT_DMG_REDUCTION"] = {PLAYERSTAT_RANGED_COMBAT.." Crit Damage Reduction(%)", PLAYERSTAT_RANGED_COMBAT.." Crit Dmg Reduc(%)"},
		["SPELL_CRIT_DMG_REDUCTION"] = {PLAYERSTAT_SPELL_COMBAT.." Crit Damage Reduction(%)", PLAYERSTAT_SPELL_COMBAT.." Crit Dmg Reduc(%)"},
		["DEFENSE"] = {DEFENSE, "Def"},
		["DODGE"] = {DODGE.."(%)", DODGE.."(%)"},
		["PARRY"] = {PARRY.."(%)", PARRY.."(%)"},
		["BLOCK"] = {BLOCK.."(%)", BLOCK.."(%)"},
		["MELEE_HIT"] = {"Prob. Golpe(%)", "Hit(%)"},
		["RANGED_HIT"] = {PLAYERSTAT_RANGED_COMBAT.." Hit Chance(%)", PLAYERSTAT_RANGED_COMBAT.." Hit(%)"},
		["SPELL_HIT"] = {PLAYERSTAT_SPELL_COMBAT.." Hit Chance(%)", PLAYERSTAT_SPELL_COMBAT.." Hit(%)"},
		["MELEE_HIT_AVOID"] = {"Hit Avoidance(%)", "Hit Avd(%)"},
		["RANGED_HIT_AVOID"] = {PLAYERSTAT_RANGED_COMBAT.." Hit Avoidance(%)", PLAYERSTAT_RANGED_COMBAT.." Hit Avd(%)"},
		["SPELL_HIT_AVOID"] = {PLAYERSTAT_SPELL_COMBAT.." Hit Avoidance(%)", PLAYERSTAT_SPELL_COMBAT.." Hit Avd(%)"},
		["MELEE_CRIT"] = {MELEE_CRIT_CHANCE.."(%)", "Crit(%)"}, -- MELEE_CRIT_CHANCE = "Crit Chance"
		["RANGED_CRIT"] = {PLAYERSTAT_RANGED_COMBAT.." "..MELEE_CRIT_CHANCE.."(%)", PLAYERSTAT_RANGED_COMBAT.." Crit(%)"},
		["SPELL_CRIT"] = {PLAYERSTAT_SPELL_COMBAT.." "..MELEE_CRIT_CHANCE.."(%)", PLAYERSTAT_SPELL_COMBAT.." Crit(%)"},
		["MELEE_CRIT_AVOID"] = {"Crit Avoidance(%)", "Crit Avd(%)"},
		["RANGED_CRIT_AVOID"] = {PLAYERSTAT_RANGED_COMBAT.." Crit Avoidance(%)", PLAYERSTAT_RANGED_COMBAT.." Crit Avd(%)"},
		["SPELL_CRIT_AVOID"] = {PLAYERSTAT_SPELL_COMBAT.." Crit Avoidance(%)", PLAYERSTAT_SPELL_COMBAT.." Crit Avd(%)"},
		["MELEE_HASTE"] = {"Celeridad(%)", "Haste(%)"}, --
		["RANGED_HASTE"] = {PLAYERSTAT_RANGED_COMBAT.." Celeridad(%)", PLAYERSTAT_RANGED_COMBAT.." Haste(%)"},
		["SPELL_HASTE"] = {PLAYERSTAT_SPELL_COMBAT.." Celeridad(%)", PLAYERSTAT_SPELL_COMBAT.." Haste(%)"},
		["DAGGER_WEAPON"] = {"Dagger "..SKILL, "Dagger"}, -- SKILL = "Skill"
		["SWORD_WEAPON"] = {"Sword "..SKILL, "Sword"},
		["2H_SWORD_WEAPON"] = {"Two-Handed Sword "..SKILL, "2H Sword"},
		["AXE_WEAPON"] = {"Axe "..SKILL, "Axe"},
		["2H_AXE_WEAPON"] = {"Two-Handed Axe "..SKILL, "2H Axe"},
		["MACE_WEAPON"] = {"Mace "..SKILL, "Mace"},
		["2H_MACE_WEAPON"] = {"Two-Handed Mace "..SKILL, "2H Mace"},
		["GUN_WEAPON"] = {"Gun "..SKILL, "Gun"},
		["CROSSBOW_WEAPON"] = {"Crossbow "..SKILL, "Crossbow"},
		["BOW_WEAPON"] = {"Bow "..SKILL, "Bow"},
		["FERAL_WEAPON"] = {"Feral "..SKILL, "Feral"},
		["FIST_WEAPON"] = {"Unarmed "..SKILL, "Unarmed"},
		["EXPERTISE"] = {"Pericia", "Expertise"},
		["ARMOR_PENETRATION"] = {"Penetr. Armadura(%)", "ArP(%)"},

		---------------------------------------------------------------------------
		-- Tier3 Stats - Stats that only show up when broken down from a Tier2 Stat
		-- Defense -> Crit Avoidance, Hit Avoidance, Dodge, Parry, Block
		-- Weapon Skill -> Crit, Hit, Dodge Neglect, Parry Neglect, Block Neglect
		["DODGE_NEGLECT"] = {DODGE.." Neglect(%)", DODGE.." Neglect(%)"},
		["PARRY_NEGLECT"] = {PARRY.." Neglect(%)", PARRY.." Neglect(%)"},
		["BLOCK_NEGLECT"] = {BLOCK.." Neglect(%)", BLOCK.." Neglect(%)"},

		---------------------------------------------------------------------------
		-- Talents
		["MELEE_CRIT_DMG"] = {"Crit Damage(%)", "Crit Dmg(%)"},
		["RANGED_CRIT_DMG"] = {PLAYERSTAT_RANGED_COMBAT.." Crit Damage(%)", PLAYERSTAT_RANGED_COMBAT.." Crit Dmg(%)"},
		["SPELL_CRIT_DMG"] = {PLAYERSTAT_SPELL_COMBAT.." Crit Damage(%)", PLAYERSTAT_SPELL_COMBAT.." Crit Dmg(%)"},

		---------------------------------------------------------------------------
		-- Spell Stats
		-- These values can be prefixed with a @ and spell name, using reverse translation to english from Babble-Spell-2.2
		-- ex: "Heroic Strike@RAGE_COST" for Heroic Strike rage cost
		-- ex: "Heroic Strike@THREAT" for Heroic Strike threat value
		-- Use strsplit("@", text) to seperate the spell name and statid
		["THREAT"] = {"Threat", "Threat"},
		["CAST_TIME"] = {"Casting Time", "Cast Time"},
		["MANA_COST"] = {"Mana Cost", "Mana Cost"},
		["RAGE_COST"] = {"Rage Cost", "Rage Cost"},
		["ENERGY_COST"] = {"Energy Cost", "Energy Cost"},
		["COOLDOWN"] = {"Cooldown", "CD"},

		---------------------------------------------------------------------------
		-- Stats Mods
		["MOD_STR"] = {"Mod "..SPELL_STAT1_NAME.."(%)", "Mod Str(%)"},
		["MOD_AGI"] = {"Mod "..SPELL_STAT2_NAME.."(%)", "Mod Agi(%)"},
		["MOD_STA"] = {"Mod "..SPELL_STAT3_NAME.."(%)", "Mod Sta(%)"},
		["MOD_INT"] = {"Mod "..SPELL_STAT4_NAME.."(%)", "Mod Int(%)"},
		["MOD_SPI"] = {"Mod "..SPELL_STAT5_NAME.."(%)", "Mod Spi(%)"},
		["MOD_HEALTH"] = {"Mod "..HEALTH.."(%)", "Mod "..HP.."(%)"},
		["MOD_MANA"] = {"Mod "..MANA.."(%)", "Mod "..MP.."(%)"},
		["MOD_ARMOR"] = {"Mod "..ARMOR.."from Items".."(%)", "Mod "..ARMOR.."(Items)".."(%)"},
		["MOD_BLOCK_VALUE"] = {"Mod Block Value".."(%)", "Mod Block Value".."(%)"},
		["MOD_DMG"] = {"Mod Damage".."(%)", "Mod Dmg".."(%)"},
		["MOD_DMG_TAKEN"] = {"Mod Damage Taken".."(%)", "Mod Dmg Taken".."(%)"},
		["MOD_CRIT_DAMAGE"] = {"Mod Crit Damage".."(%)", "Mod Crit Dmg".."(%)"},
		["MOD_CRIT_DAMAGE_TAKEN"] = {"Mod Crit Damage Taken".."(%)", "Mod Crit Dmg Taken".."(%)"},
		["MOD_THREAT"] = {"Mod Threat".."(%)", "Mod Threat".."(%)"},
		["MOD_AP"] = {"Mod "..ATTACK_POWER_TOOLTIP.."(%)", "Mod AP".."(%)"},
		["MOD_RANGED_AP"] = {"Mod "..PLAYERSTAT_RANGED_COMBAT.." "..ATTACK_POWER_TOOLTIP.."(%)", "Mod RAP".."(%)"},
		["MOD_SPELL_DMG"] = {"Mod "..PLAYERSTAT_SPELL_COMBAT.." "..DAMAGE.."(%)", "Mod "..PLAYERSTAT_SPELL_COMBAT.." Dmg".."(%)"},
		["MOD_HEALING"] = {"Mod Healing".."(%)", "Mod Heal".."(%)"},
		["MOD_CAST_TIME"] = {"Mod Casting Time".."(%)", "Mod Cast Time".."(%)"},
		["MOD_MANA_COST"] = {"Mod Mana Cost".."(%)", "Mod Mana Cost".."(%)"},
		["MOD_RAGE_COST"] = {"Mod Rage Cost".."(%)", "Mod Rage Cost".."(%)"},
		["MOD_ENERGY_COST"] = {"Mod Energy Cost".."(%)", "Mod Energy Cost".."(%)"},
		["MOD_COOLDOWN"] = {"Mod Cooldown".."(%)", "Mod CD".."(%)"},

		---------------------------------------------------------------------------
		-- Misc Stats
		["WEAPON_RATING"] = {"Weapon "..SKILL.." "..RATING, "Weapon"..SKILL.." "..RATING},
		["WEAPON_SKILL"] = {"Weapon "..SKILL, "Weapon"..SKILL},
		["MAINHAND_WEAPON_RATING"] = {"Main Hand Weapon "..SKILL.." "..RATING, "MH Weapon"..SKILL.." "..RATING},
		["OFFHAND_WEAPON_RATING"] = {"Off Hand Weapon "..SKILL.." "..RATING, "OH Weapon"..SKILL.." "..RATING},
		["RANGED_WEAPON_RATING"] = {"Ranged Weapon "..SKILL.." "..RATING, "Ranged Weapon"..SKILL.." "..RATING},
	},
}

PatternLocale.esMX = PatternLocale.esES
DisplayLocale.esMX = DisplayLocale.esES

local locale = GetLocale()
local noPatternLocale
local L = PatternLocale[locale]
if not L then
	noPatternLocale = true
	L = PatternLocale.enUS
end
local D = DisplayLocale[locale] or DisplayLocale.enUS
PatternLocale = nil
DisplayLocale = nil

-- Add all lower case strings to ["StatIDLookup"]
local strutf8lower = string.utf8lower
local temp = {}
for k, v in pairs(L.StatIDLookup) do
	temp[strutf8lower(k)] = v
end
for k, v in pairs(temp) do
	L.StatIDLookup[k] = v
end


--[[---------------------------------
	:GetStatNameFromID(stat)
-------------------------------------
Notes:
	* Returns localized names for stat
Arguments:
	string - "StatID". ex: "DODGE", "DODGE_RATING"
Returns:
	; "longName" : string - The full name for stat.
	; "shortName" : string - The short name for stat.
Example:
	local longName, shortName = StatLogic:GetStatNameFromID("FIRE_RES") -- "Fire Resistance", "FR"
-----------------------------------]]
function StatLogic:GetStatNameFromID(stat)
	local name = D.StatIDToName[stat]
	if not name then return end
	return unpack(name)
end


-----------
-- Cache --
-----------
local cache = {}
setmetatable(cache, {__mode = "kv"}) -- weak table to enable garbage collection


--------------
-- Activate --
--------------
-- When a newer version is registered
local tip = StatLogic.tip
if not tip then
	-- Create a custom tooltip for scanning
	tip = CreateFrame("GameTooltip", "StatLogicTooltip", nil, "GameTooltipTemplate")
	StatLogic.tip = tip
	tip:SetOwner(UIParent, "ANCHOR_NONE")
	for i = 1, 30 do
		tip[i] = _G["StatLogicTooltipTextLeft"..i]
		if not tip[i] then
			tip[i] = tip:CreateFontString()
			tip:AddFontStrings(tip[i], tip:CreateFontString())
			_G["StatLogicTooltipTextLeft"..i] = tip[i]
		end
	end
elseif not _G["StatLogicTooltipTextLeft30"] then
	for i = 1, 30 do
		_G["StatLogicTooltipTextLeft"..i] = tip[i]
	end
end
local tipMiner = StatLogic.tipMiner
if not tipMiner then
	-- Create a custom tooltip for data mining
	tipMiner = CreateFrame("GameTooltip", "StatLogicMinerTooltip", nil, "GameTooltipTemplate")
	StatLogic.tipMiner = tipMiner
	tipMiner:SetOwner(UIParent, "ANCHOR_NONE")
	for i = 1, 30 do
		tipMiner[i] = _G["StatLogicMinerTooltipTextLeft"..i]
		if not tipMiner[i] then
			tipMiner[i] = tipMiner:CreateFontString()
			tipMiner:AddFontStrings(tipMiner[i], tipMiner:CreateFontString())
			_G["StatLogicMinerTooltipTextLeft"..i] = tipMiner[i]
		end
	end
elseif not _G["StatLogicMinerTooltipTextLeft30"] then
	for i = 1, 30 do
		_G["StatLogicMinerTooltipTextLeft"..i] = tipMiner[i]
	end
end


---------------------
-- Local Variables --
---------------------
-- Player info
local _, playerClass = UnitClass("player")
local _, playerRace = UnitRace("player")

-- Localize globals
local tonumber = L.tonumber
local _G = getfenv(0)
local strfind = strfind
local strsub = strsub
local strupper = strupper
local strmatch = strmatch
local strtrim = strtrim
local strsplit = strsplit
local strjoin = strjoin
local gmatch = gmatch
local gsub = gsub
local wipe = wipe
local pairs = pairs
local ipairs = ipairs
local type = type
local unpack = unpack
local strutf8lower = string.utf8lower
local strutf8sub = string.utf8sub
local GetInventoryItemLink = GetInventoryItemLink
local IsUsableSpell = IsUsableSpell
local UnitLevel = UnitLevel
local UnitStat = UnitStat
local GetShapeshiftForm = GetShapeshiftForm
local GetShapeshiftFormInfo = GetShapeshiftFormInfo
local GetTalentInfo = GetTalentInfo
local GetInventoryItemID = GetInventoryItemID
local GetSpellInfo = GetSpellInfo
local GetCVarBool = GetCVarBool

-- Cached GetItemInfo
local GetItemInfoCached = setmetatable({}, { __index = function(self, n)
	local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemCount, itemEquipLoc, itemTexture, itemSellValue = GetItemInfo(n)
	if itemName then
			-- store in cache only if it exists in the local cache
			self[n] = {itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemCount, itemEquipLoc, itemTexture, itemSellValue}
			return self[n] -- return result
	end
end })
local GetItemInfo = function(item)
	local info = GetItemInfoCached[item]
	if info then
		return unpack(info)
	end
end
StatLogic.GetItemInfo = GetItemInfo

-- taken from lua programming gems
local function memoize(f)
	local mem = {} -- memoizing table
	return function(x)
		if not mem[x] then
			mem[x] = f(x)
		end
		return mem[x]
	end
end
local loadstring = memoize(loadstring)

---------------
-- Lua Tools --
---------------
-- metatable for stat tables
local statTableMetatable = {
	__add = function(op1, op2)
		if type(op2) == "table" then
			for k, v in pairs(op2) do
				if type(v) == "number" then
					op1[k] = (op1[k] or 0) + v
					if op1[k] == 0 then
						op1[k] = nil
					end
				end
			end
		end
		return op1
	end,
	__sub = function(op1, op2)
		if type(op2) == "table" then
			for k, v in pairs(op2) do
				if type(v) == "number" then
					op1[k] = (op1[k] or 0) - v
					if op1[k] == 0 then
						op1[k] = nil
					end
				elseif k == "itemType" then
					local i = 1
					while op1["diffItemType"..i] do
						i = i + 1
					end
					op1["diffItemType"..i] = op2.itemType
				end
			end
		end
		return op1
	end,
}

-- Table pool borrowed from Tablet-2.0 (ckknight) --
local pool = {}

-- Delete table and return to pool
local function del(t)
	if t then
		for k in pairs(t) do
			t[k] = nil
		end
		setmetatable(t, nil)
		pool[t] = true
	end
end

local function delMulti(t)
	if t then
		for k in pairs(t) do
			if type(t[k]) == "table" then
				del(t[k])
			else
				t[k] = nil
			end
		end
		setmetatable(t, nil)
		pool[t] = true
	end
end

-- Copy table
local function copy(parent)
	local t = next(pool) or {}
	pool[t] = nil
	if parent then
		for k,v in pairs(parent) do
			t[k] = v
		end
		setmetatable(t, getmetatable(parent))
	end
	return t
end

-- New table
local function new(...)
	local t = next(pool) or {}
	pool[t] = nil

	for i = 1, select('#', ...), 2 do
		local k = select(i, ...)
		if k then
			t[k] = select(i+1, ...)
		else
			break
		end
	end
	return t
end

-- New stat table
local function newStatTable(...)
	local t = next(pool) or {}
	pool[t] = nil
	setmetatable(t, statTableMetatable)

	for i = 1, select('#', ...), 2 do
		local k = select(i, ...)
		if k then
			t[k] = select(i+1, ...)
		else
			break
		end
	end
	return t
end

StatLogic.StatTable = {}
StatLogic.StatTable.new = newStatTable
StatLogic.StatTable.del = del
StatLogic.StatTable.copy = copy

-- End of Table pool --

-- deletes the contents of a table, then returns itself
local function clearTable(t)
	if t then
		for k in pairs(t) do
			if type(t[k]) == "table" then
				del(t[k]) -- child tables get put into the pool
			else
				t[k] = nil
			end
		end
		setmetatable(t, nil)
	end
	return t
end

-- copyTable
local function copyTable(to, from)
	if not clearTable(to) then
		to = new()
	end
	for k,v in pairs(from) do
		if type(k) == "table" then
			k = copyTable(new(), k)
		end
		if type(v) == "table" then
			v = copyTable(new(), v)
		end
		to[k] = v
	end
	setmetatable(to, getmetatable(from))
	return to
end

-- Taken from AceLibrary
function StatLogic:argCheck(arg, num, kind, kind2, kind3, kind4, kind5)
	if type(num) ~= "number" then
		return error(self, "Bad argument #3 to `argCheck' (number expected, got %s)", type(num))
	elseif type(kind) ~= "string" then
		return error(self, "Bad argument #4 to `argCheck' (string expected, got %s)", type(kind))
	end
	arg = type(arg)
	if arg ~= kind and arg ~= kind2 and arg ~= kind3 and arg ~= kind4 and arg ~= kind5 then
		local stack = debugstack()
		local func = stack:match("`argCheck'.-([`<].-['>])")
		if not func then
			func = stack:match("([`<].-['>])")
		end
		if kind5 then
			return error(self, "Bad argument #%s to %s (%s, %s, %s, %s, or %s expected, got %s)", tonumber(num) or 0/0, func, kind, kind2, kind3, kind4, kind5, arg)
		elseif kind4 then
			return error(self, "Bad argument #%s to %s (%s, %s, %s, or %s expected, got %s)", tonumber(num) or 0/0, func, kind, kind2, kind3, kind4, arg)
		elseif kind3 then
			return error(self, "Bad argument #%s to %s (%s, %s, or %s expected, got %s)", tonumber(num) or 0/0, func, kind, kind2, kind3, arg)
		elseif kind2 then
			return error(self, "Bad argument #%s to %s (%s or %s expected, got %s)", tonumber(num) or 0/0, func, kind, kind2, arg)
		else
			return error(self, "Bad argument #%s to %s (%s expected, got %s)", tonumber(num) or 0/0, func, kind, arg)
		end
	end
end



--[[---------------------------------
	:GetClassIdOrName(class)
-------------------------------------
Notes:
	* Converts ClassID to and from "ClassName"
	* class:
	:{| class="wikitable"
	!ClassID!!"ClassName"
	|-
	|1||"WARRIOR"
	|-
	|2||"PALADIN"
	|-
	|3||"HUNTER"
	|-
	|4||"ROGUE"
	|-
	|5||"PRIEST"
	|-
	|6||"DEATHKNIGHT"
	|-
	|7||"SHAMAN"
	|-
	|8||"MAGE"
	|-
	|9||"WARLOCK"
	|-
	|10||"DRUID"
	|}
Arguments:
	number or string - ClassID or "ClassName"
Returns:
	None
Example:
	StatLogic:GetClassIdOrName("WARRIOR") -- 1
	StatLogic:GetClassIdOrName(10) -- "DRUID"
-----------------------------------]]

local ClassNameToID = {
	"WARRIOR",
	"PALADIN",
	"HUNTER",
	"ROGUE",
	"PRIEST",
	"DEATHKNIGHT",
	"SHAMAN",
	"MAGE",
	"WARLOCK",
	"DRUID",
	["WARRIOR"] = 1,
	["PALADIN"] = 2,
	["HUNTER"] = 3,
	["ROGUE"] = 4,
	["PRIEST"] = 5,
	["DEATHKNIGHT"] = 6,
	["SHAMAN"] = 7,
	["MAGE"] = 8,
	["WARLOCK"] = 9,
	["DRUID"] = 10,
}

function StatLogic:GetClassIdOrName(class)
	return ClassNameToID[class]
end

--[[ Interface\FrameXML\PaperDollFrame.lua
CR_WEAPON_SKILL = 1;
CR_DEFENSE_SKILL = 2;
CR_DODGE = 3;
CR_PARRY = 4;
CR_BLOCK = 5;
CR_HIT_MELEE = 6;
CR_HIT_RANGED = 7;
CR_HIT_SPELL = 8;
CR_CRIT_MELEE = 9;
CR_CRIT_RANGED = 10;
CR_CRIT_SPELL = 11;
CR_HIT_TAKEN_MELEE = 12;
CR_HIT_TAKEN_RANGED = 13;
CR_HIT_TAKEN_SPELL = 14;
CR_CRIT_TAKEN_MELEE = 15;
CR_CRIT_TAKEN_RANGED = 16;
CR_CRIT_TAKEN_SPELL = 17;
CR_HASTE_MELEE = 18;
CR_HASTE_RANGED = 19;
CR_HASTE_SPELL = 20;
CR_WEAPON_SKILL_MAINHAND = 21;
CR_WEAPON_SKILL_OFFHAND = 22;
CR_WEAPON_SKILL_RANGED = 23;
CR_EXPERTISE = 24;
CR_ARMOR_PENETRATION = 25;
--]]

local RatingNameToID
if toc < 40000 then
RatingNameToID = {
	[CR_WEAPON_SKILL] = "WEAPON_RATING",
	[CR_DEFENSE_SKILL] = "DEFENSE_RATING",
	[CR_DODGE] = "DODGE_RATING",
	[CR_PARRY] = "PARRY_RATING",
	[CR_BLOCK] = "BLOCK_RATING",
	[CR_HIT_MELEE] = "MELEE_HIT_RATING",
	[CR_HIT_RANGED] = "RANGED_HIT_RATING",
	[CR_HIT_SPELL] = "SPELL_HIT_RATING",
	[CR_CRIT_MELEE] = "MELEE_CRIT_RATING",
	[CR_CRIT_RANGED] = "RANGED_CRIT_RATING",
	[CR_CRIT_SPELL] = "SPELL_CRIT_RATING",
	[CR_HIT_TAKEN_MELEE] = "MELEE_HIT_AVOID_RATING",
	[CR_HIT_TAKEN_RANGED] = "RANGED_HIT_AVOID_RATING",
	[CR_HIT_TAKEN_SPELL] = "SPELL_HIT_AVOID_RATING",
	[CR_CRIT_TAKEN_MELEE] = "MELEE_CRIT_AVOID_RATING",
	[CR_CRIT_TAKEN_RANGED] = "RANGED_CRIT_AVOID_RATING",
	[CR_CRIT_TAKEN_SPELL] = "SPELL_CRIT_AVOID_RATING",
	[CR_HASTE_MELEE] = "MELEE_HASTE_RATING",
	[CR_HASTE_RANGED] = "RANGED_HASTE_RATING",
	[CR_HASTE_SPELL] = "SPELL_HASTE_RATING",
	[CR_WEAPON_SKILL_MAINHAND] = "MAINHAND_WEAPON_RATING",
	[CR_WEAPON_SKILL_OFFHAND] = "OFFHAND_WEAPON_RATING",
	[CR_WEAPON_SKILL_RANGED] = "RANGED_WEAPON_RATING",
	[CR_EXPERTISE] = "EXPERTISE_RATING",
	[CR_ARMOR_PENETRATION] = "ARMOR_PENETRATION_RATING",
	["DEFENSE_RATING"] = CR_DEFENSE_SKILL,
	["DODGE_RATING"] = CR_DODGE,
	["PARRY_RATING"] = CR_PARRY,
	["BLOCK_RATING"] = CR_BLOCK,
	["MELEE_HIT_RATING"] = CR_HIT_MELEE,
	["RANGED_HIT_RATING"] = CR_HIT_RANGED,
	["SPELL_HIT_RATING"] = CR_HIT_SPELL,
	["MELEE_CRIT_RATING"] = CR_CRIT_MELEE,
	["RANGED_CRIT_RATING"] = CR_CRIT_RANGED,
	["SPELL_CRIT_RATING"] = CR_CRIT_SPELL,
	["MELEE_HIT_AVOID_RATING"] = CR_HIT_TAKEN_MELEE,
	["RANGED_HIT_AVOID_RATING"] = CR_HIT_TAKEN_RANGED,
	["SPELL_HIT_AVOID_RATING"] = CR_HIT_TAKEN_SPELL,
	["MELEE_CRIT_AVOID_RATING"] = CR_CRIT_TAKEN_MELEE,
	["RANGED_CRIT_AVOID_RATING"] = CR_CRIT_TAKEN_RANGED,
	["SPELL_CRIT_AVOID_RATING"] = CR_CRIT_TAKEN_SPELL,
	["RESILIENCE_RATING"] = CR_CRIT_TAKEN_MELEE,
	["MELEE_HASTE_RATING"] = CR_HASTE_MELEE,
	["RANGED_HASTE_RATING"] = CR_HASTE_RANGED,
	["SPELL_HASTE_RATING"] = CR_HASTE_SPELL,
	["DAGGER_WEAPON_RATING"] = CR_WEAPON_SKILL,
	["SWORD_WEAPON_RATING"] = CR_WEAPON_SKILL,
	["2H_SWORD_WEAPON_RATING"] = CR_WEAPON_SKILL,
	["AXE_WEAPON_RATING"] = CR_WEAPON_SKILL,
	["2H_AXE_WEAPON_RATING"] = CR_WEAPON_SKILL,
	["MACE_WEAPON_RATING"] = CR_WEAPON_SKILL,
	["2H_MACE_WEAPON_RATING"] = CR_WEAPON_SKILL,
	["GUN_WEAPON_RATING"] = CR_WEAPON_SKILL,
	["CROSSBOW_WEAPON_RATING"] = CR_WEAPON_SKILL,
	["BOW_WEAPON_RATING"] = CR_WEAPON_SKILL,
	["FERAL_WEAPON_RATING"] = CR_WEAPON_SKILL,
	["FIST_WEAPON_RATING"] = CR_WEAPON_SKILL,
	["WEAPON_RATING"] = CR_WEAPON_SKILL,
	["MAINHAND_WEAPON_RATING"] = CR_WEAPON_SKILL_MAINHAND,
	["OFFHAND_WEAPON_RATING"] = CR_WEAPON_SKILL_OFFHAND,
	["RANGED_WEAPON_RATING"] = CR_WEAPON_SKILL_RANGED,
	["EXPERTISE_RATING"] = CR_EXPERTISE,
	["ARMOR_PENETRATION_RATING"] = CR_ARMOR_PENETRATION,
}
else
RatingNameToID = {
	[CR_WEAPON_SKILL] = "WEAPON_RATING",
	[CR_DEFENSE_SKILL] = "DEFENSE_RATING",
	[CR_DODGE] = "DODGE_RATING",
	[CR_PARRY] = "PARRY_RATING",
	[CR_BLOCK] = "BLOCK_RATING",
	[CR_HIT_MELEE] = "MELEE_HIT_RATING",
	[CR_HIT_RANGED] = "RANGED_HIT_RATING",
	[CR_HIT_SPELL] = "SPELL_HIT_RATING",
	[CR_CRIT_MELEE] = "MELEE_CRIT_RATING",
	[CR_CRIT_RANGED] = "RANGED_CRIT_RATING",
	[CR_CRIT_SPELL] = "SPELL_CRIT_RATING",
	[CR_HIT_TAKEN_MELEE] = "MELEE_HIT_AVOID_RATING",
	[CR_HIT_TAKEN_RANGED] = "RANGED_HIT_AVOID_RATING",
	[CR_HIT_TAKEN_SPELL] = "SPELL_HIT_AVOID_RATING",
	[COMBAT_RATING_RESILIENCE_CRIT_TAKEN] = "MELEE_CRIT_AVOID_RATING",
	[COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN] = "RANGED_CRIT_AVOID_RATING",
	[CR_CRIT_TAKEN_SPELL] = "SPELL_CRIT_AVOID_RATING",
	[CR_HASTE_MELEE] = "MELEE_HASTE_RATING",
	[CR_HASTE_RANGED] = "RANGED_HASTE_RATING",
	[CR_HASTE_SPELL] = "SPELL_HASTE_RATING",
	[CR_WEAPON_SKILL_MAINHAND] = "MAINHAND_WEAPON_RATING",
	[CR_WEAPON_SKILL_OFFHAND] = "OFFHAND_WEAPON_RATING",
	[CR_WEAPON_SKILL_RANGED] = "RANGED_WEAPON_RATING",
	[CR_EXPERTISE] = "EXPERTISE_RATING",
	[CR_ARMOR_PENETRATION] = "ARMOR_PENETRATION_RATING",
	[CR_MASTERY] = "MASTERY_RATING",
	["DEFENSE_RATING"] = CR_DEFENSE_SKILL,
	["DODGE_RATING"] = CR_DODGE,
	["PARRY_RATING"] = CR_PARRY,
	["BLOCK_RATING"] = CR_BLOCK,
	["MELEE_HIT_RATING"] = CR_HIT_MELEE,
	["RANGED_HIT_RATING"] = CR_HIT_RANGED,
	["SPELL_HIT_RATING"] = CR_HIT_SPELL,
	["MELEE_CRIT_RATING"] = CR_CRIT_MELEE,
	["RANGED_CRIT_RATING"] = CR_CRIT_RANGED,
	["SPELL_CRIT_RATING"] = CR_CRIT_SPELL,
	["MELEE_HIT_AVOID_RATING"] = CR_HIT_TAKEN_MELEE,
	["RANGED_HIT_AVOID_RATING"] = CR_HIT_TAKEN_RANGED,
	["SPELL_HIT_AVOID_RATING"] = CR_HIT_TAKEN_SPELL,
	["MELEE_CRIT_AVOID_RATING"] = COMBAT_RATING_RESILIENCE_CRIT_TAKEN,
	["RANGED_CRIT_AVOID_RATING"] = COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN,
	["SPELL_CRIT_AVOID_RATING"] = CR_CRIT_TAKEN_SPELL,
	["RESILIENCE_RATING"] = COMBAT_RATING_RESILIENCE_CRIT_TAKEN,
	["MELEE_HASTE_RATING"] = CR_HASTE_MELEE,
	["RANGED_HASTE_RATING"] = CR_HASTE_RANGED,
	["SPELL_HASTE_RATING"] = CR_HASTE_SPELL,
	["DAGGER_WEAPON_RATING"] = CR_WEAPON_SKILL,
	["SWORD_WEAPON_RATING"] = CR_WEAPON_SKILL,
	["2H_SWORD_WEAPON_RATING"] = CR_WEAPON_SKILL,
	["AXE_WEAPON_RATING"] = CR_WEAPON_SKILL,
	["2H_AXE_WEAPON_RATING"] = CR_WEAPON_SKILL,
	["MACE_WEAPON_RATING"] = CR_WEAPON_SKILL,
	["2H_MACE_WEAPON_RATING"] = CR_WEAPON_SKILL,
	["GUN_WEAPON_RATING"] = CR_WEAPON_SKILL,
	["CROSSBOW_WEAPON_RATING"] = CR_WEAPON_SKILL,
	["BOW_WEAPON_RATING"] = CR_WEAPON_SKILL,
	["FERAL_WEAPON_RATING"] = CR_WEAPON_SKILL,
	["FIST_WEAPON_RATING"] = CR_WEAPON_SKILL,
	["WEAPON_RATING"] = CR_WEAPON_SKILL,
	["MAINHAND_WEAPON_RATING"] = CR_WEAPON_SKILL_MAINHAND,
	["OFFHAND_WEAPON_RATING"] = CR_WEAPON_SKILL_OFFHAND,
	["RANGED_WEAPON_RATING"] = CR_WEAPON_SKILL_RANGED,
	["EXPERTISE_RATING"] = CR_EXPERTISE,
	["ARMOR_PENETRATION_RATING"] = CR_ARMOR_PENETRATION,
	["MASTERY_RATING"] = CR_MASTERY,
}
end

--[[---------------------------------
	:GetRatingIdOrName(rating)
-------------------------------------
Notes:
	* Converts RatingID to and from "StatID"
	* rating:
	:;RatingID : number - As defined in PaperDollFrame.lua of Blizzard default ui
	:;"StatID" : string - The the key values of the DisplayLocale table in StatLogic
	:{| class="wikitable"
	!RatingID!!"StatID"
	|-
	|CR_WEAPON_SKILL||"WEAPON_RATING"
	|-
	|CR_DEFENSE_SKILL||"DEFENSE_RATING"
	|-
	|CR_DODGE||"DODGE_RATING"
	|-
	|CR_PARRY||"PARRY_RATING"
	|-
	|CR_BLOCK||"BLOCK_RATING"
	|-
	|CR_HIT_MELEE||"MELEE_HIT_RATING"
	|-
	|CR_HIT_RANGED||"RANGED_HIT_RATING"
	|-
	|CR_HIT_SPELL||"SPELL_HIT_RATING"
	|-
	|CR_CRIT_MELEE||"MELEE_CRIT_RATING"
	|-
	|CR_CRIT_RANGED||"RANGED_CRIT_RATING"
	|-
	|CR_CRIT_SPELL||"SPELL_CRIT_RATING"
	|-
	|CR_HIT_TAKEN_MELEE||"MELEE_HIT_AVOID_RATING"
	|-
	|CR_HIT_TAKEN_RANGED||"RANGED_HIT_AVOID_RATING"
	|-
	|CR_HIT_TAKEN_SPELL||"SPELL_HIT_AVOID_RATING"
	|-
	|CR_CRIT_TAKEN_MELEE||"MELEE_CRIT_AVOID_RATING"
	|-
	|CR_CRIT_TAKEN_RANGED||"RANGED_CRIT_AVOID_RATING"
	|-
	|CR_CRIT_TAKEN_SPELL||"SPELL_CRIT_AVOID_RATING"
	|-
	|CR_HASTE_MELEE||"MELEE_HASTE_RATING"
	|-
	|CR_HASTE_RANGED||"RANGED_HASTE_RATING"
	|-
	|CR_HASTE_SPELL||"SPELL_HASTE_RATING"
	|-
	|CR_WEAPON_SKILL_MAINHAND||"MAINHAND_WEAPON_RATING"
	|-
	|CR_WEAPON_SKILL_OFFHAND||"OFFHAND_WEAPON_RATING"
	|-
	|CR_WEAPON_SKILL_RANGED||"RANGED_WEAPON_RATING"
	|-
	|CR_EXPERTISE||"EXPERTISE_RATING"
	|-
	|CR_ARMOR_PENETRATION||"ARMOR_PENETRATION_RATING"
	|}
Arguments:
	number or string - RatingID or "StatID"
Returns:
	None
Example:
	StatLogic:GetRatingIdOrStatId("CR_WEAPON_SKILL") -- 1
	StatLogic:GetRatingIdOrStatId("DEFENSE_RATING") -- 2
	StatLogic:GetRatingIdOrStatId("DODGE_RATING") -- 3
	StatLogic:GetRatingIdOrStatId(CR_PARRY) -- "PARRY_RATING"
-----------------------------------]]
function StatLogic:GetRatingIdOrStatId(rating)
	return RatingNameToID[rating]
end

local RatingIDToConvertedStat
if toc < 40000 then
RatingIDToConvertedStat = {
	"WEAPON_SKILL",
	"DEFENSE",
	"DODGE",
	"PARRY",
	"BLOCK",
	"MELEE_HIT",
	"RANGED_HIT",
	"SPELL_HIT",
	"MELEE_CRIT",
	"RANGED_CRIT",
	"SPELL_CRIT",
	"MELEE_HIT_AVOID",
	"RANGED_HIT_AVOID",
	"SPELL_HIT_AVOID",
	"MELEE_CRIT_AVOID",
	"RANGED_CRIT_AVOID",
	"SPELL_CRIT_AVOID",
	"MELEE_HASTE",
	"RANGED_HASTE",
	"SPELL_HASTE",
	"WEAPON_SKILL",
	"WEAPON_SKILL",
	"WEAPON_SKILL",
	"EXPERTISE",
	"ARMOR_PENETRATION",
}
else
RatingIDToConvertedStat = {
	"WEAPON_SKILL",
	"DEFENSE",
	"DODGE",
	"PARRY",
	"BLOCK",
	"MELEE_HIT",
	"RANGED_HIT",
	"SPELL_HIT",
	"MELEE_CRIT",
	"RANGED_CRIT",
	"SPELL_CRIT",
	"MELEE_HIT_AVOID",
	"RANGED_HIT_AVOID",
	"SPELL_HIT_AVOID",
	"MELEE_CRIT_AVOID",
	"PLAYER_DAMAGE_AVOID",
	"SPELL_CRIT_AVOID",
	"MELEE_HASTE",
	"RANGED_HASTE",
	"SPELL_HASTE",
	"WEAPON_SKILL",
	"WEAPON_SKILL",
	"WEAPON_SKILL",
	"EXPERTISE",
	"ARMOR_PENETRATION",
	"MASTERY",
}
end

----------------
-- Stat Tools --
----------------
local function StripGlobalStrings(text)
	-- ITEM_SOCKET_BONUS = "Socket Bonus: %s"; -- Tooltip tag for socketed item matched socket bonuses
	text = gsub(text, "%%%%", "%%") -- "%%" -> "%"
	text = gsub(text, " ?%%%d?%.?%d?%$?[cdsgf]", "") -- delete "%d", "%s", "%c", "%g", "%2$d", "%.2f" and a space in front of it if found
	-- So StripGlobalStrings(ITEM_SOCKET_BONUS) = "Socket Bonus:"
	return text
end

local function GetStanceIcon()
	local currentStance = GetShapeshiftForm()
	if currentStance ~= 0 then
		return GetShapeshiftFormInfo(currentStance)
	end
end
StatLogic.GetStanceIcon = GetStanceIcon

local function PlayerHasAura(aura)
	return UnitBuff("player", aura or "") or UnitDebuff("player", aura or "")
end
StatLogic.PlayerHasAura = PlayerHasAura


local function GetPlayerAuraRankStack(buff)
	--name, rank, icon, stack, debuffType, duration, expirationTime, isMine, isStealable = UnitAura("player", buff)
	local name, rank, _, stack = UnitBuff("player", buff)
  if not name then -- if not a buff, check for debuff
    name, rank, _, stack = UnitDebuff("player", buff)
  end
	if name then
		if not stack or stack == 0 then
			stack = 1
		end
		return tonumber(strmatch(rank, "(%d+)") or 1), stack
	end
end
StatLogic.GetPlayerAuraRankStack = GetPlayerAuraRankStack

local function GetTotalDefense(unit)
	local base, modifier = UnitDefense(unit);
	return base + modifier
end

local function PlayerHasGlyph(glyph, talentGroup)
	for i = 1, 6 do
		local _, _, glyphSpellID = GetGlyphSocketInfo(i, talentGroup)
		if glyphSpellID == glyph then
			return true
		end
	end
end
StatLogic.PlayerHasGlyph = PlayerHasGlyph

---------------
-- Item Sets --
---------------
local SetToItem -- SetID comes from ItemSet.dbc
if playerClass == "MAGE" then
	SetToItem = {
		[843] = {47748, 47749, 57750, 47751, 47752, 47753, 47754, 47755, 47756, 47757, 47758, 47759, 47760, 47761, 47762}, -- Khadgar's Regalia (T9 Mage Ally)
		[844] = {47773, 47774, 47775, 47776, 47777, 47768, 47769, 47770, 47771, 47772, 47763, 47764, 47765, 47766, 47767}, -- Sunstrider's Regalia (T9 Mage Horde)
	}
else
	SetToItem = {}
	SetToItem = {
		[845] = {47803, 47804, 47805, 47806, 47807},
		[837] = {46135, 46136, 46137, 46139, 46140},
	}
end
-- Build ItemToSet from SetToItem
ItemToSet = {}
for set, items in pairs(SetToItem) do
	for _, item in pairs(items) do
		ItemToSet[item] = set
	end
end

-- Create a frame
local ItemSetFrame = StatLogic.ItemSetFrame
if not ItemSetFrame then
	ItemSetFrame = CreateFrame("Frame", "StatLogicItemSetFrame")
	StatLogic.ItemSetFrame = ItemSetFrame
else
	ItemSetFrame:UnregisterAllEvents()
end

--[[
PlayerItemSets = {
	[844] = 4,
}
--]]
local PlayerItemSets = {}
-- API
function StatLogic:PlayerHasItemSet(itemset)
  return PlayerItemSets[itemset]
end
-- Don't set any scripts if the class doesn't have any sets to check
if table.maxn(ItemToSet) ~= 0 then
	local WatchInventoryID = {
		(GetInventorySlotInfo("HeadSlot")),
		(GetInventorySlotInfo("ShoulderSlot")),
		(GetInventorySlotInfo("ChestSlot")),
		(GetInventorySlotInfo("HandsSlot")),
		(GetInventorySlotInfo("LegsSlot")),
	}
	local function UpdatePlayerItemSets()
		wipe(PlayerItemSets)
		for _, slot in pairs(WatchInventoryID) do
			local set = ItemToSet[GetInventoryItemID('player', slot)]
			if set then
				PlayerItemSets[set] = (PlayerItemSets[set] or 0) + 1
			end
		end
	end
	-- we will schedule this since PLAYER_EQUIPMENT_CHANGED fires multiple times when you switch whole sets
	ItemSetFrame:SetScript("OnUpdate", function(self, elapsed)
		if self.updateTime and (GetTime() >= self.updateTime) then
			self.updateTime = nil
			UpdatePlayerItemSets()
		end
	end)
	ItemSetFrame:SetScript("OnEvent", function(self, event, ...) if self[event] then return self[event](self, event, ...) end end)
	ItemSetFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
	function ItemSetFrame:PLAYER_EQUIPMENT_CHANGED()
		self.updateTime = GetTime() + 0.1 -- 0.1 sec delay
	end
	-- Initialize on PLAYER_LOGIN
	if (IsLoggedIn()) then -- LOD
		UpdatePlayerItemSets()
	else
		ItemSetFrame:RegisterEvent("PLAYER_LOGIN")
		function ItemSetFrame:PLAYER_LOGIN()
			UpdatePlayerItemSets()
		end
	end
end
--============--
-- Base Stats --
--============--
--[[
local RaceClassStatBase = {
	-- The Human Spirit - Increase Spirit by 5%
	Human = { --{20, 20, 20, 20, 21}
		WARRIOR = { --{3, 0, 2, 0, 0}
			{23, 20, 22, 20, 22}
		},
		PALADIN = { --{2, 0, 2, 0, 1}
			{22, 20, 22, 20, 23}
		},
		ROGUE = { --{1, 3, 1, 0, 0}
			{21, 23, 21, 20, 22}
		},
		PRIEST = { --{0, 0, 0, 2, 3}
			{20, 20, 20, 22, 25}
		},
		MAGE = { --{0, 0, 0, 3, 2}
			{20, 20, 20, 23, 24}
		},
		WARLOCK = { --{0, 0, 1, 2, 2}
			{20, 20, 21, 22, 24}
		},
	},
	Dwarf = { --{22, 16, 23, 19, 19}
		WARRIOR = {
			{25, 16, 25, 19, 19}
		},
		PALADIN = {
			{24, 16, 25, 19, 20}
		},
		HUNTER = { --{0, 3, 1, 0, 1}
			{22, 19, 24, 19, 20}
		},
		ROGUE = {
			{23, 19, 24, 19, 19}
		},
		PRIEST = {
			{22, 16, 23, 21, 22}
		},
	},
	NightElf = { --{17, 25, 19, 20, 20}
		WARRIOR = {--{3, 0, 2, 0, 0}
			{20, 25, 21, 20, 20}
		},
		HUNTER = {
			{17, 28, 20, 20, 21}
		},
		ROGUE = {
			{18, 28, 20, 20, 20}
		},
		PRIEST = {
			{17, 25, 19, 22, 23}
		},
		DRUID = { --{1, 0, 0, 2, 2}
			{18, 25, 19, 22, 22}
		},
	},
	-- Expansive Mind - Increase Intelligence by 5%
	Gnome = { --{15, 23, 19, 24, 20}
		WARRIOR = {--{3, 0, 2, 0, 0}
			{18, 23, 21, 24, 20}
		},
		ROGUE = {
			{, , , , }
		},
		MAGE = {
			{, , , , }
		},
		WARLOCK = {
			{, , , , }
		},
	},
	Draenei = { --{21, 17, 19, 21, 22}
		WARRIOR = { --{3, 0, 2, 0, 0}
			{24, 17, 21, 21, 22}
		},
		PALADIN = { --{2, 0, 2, 0, 1}
			{23, 17, 21, 21, 23}
		},
		HUNTER = { --{0, 3, 1, 0, 1}
			{21, 20, 20, 21, 23}
		},
		PRIEST = { --{0, 0, 0, 2, 3}
			{21, 17, 19, 23, 25}
		},
		SHAMAN = { --{1, 0, 1, 1, 2}
			{26, 15, 23, 16, 24}
		},
		MAGE = { --{0, 0, 0, 3, 2}
			{21, 17, 19, 24, 24}
		},
	},
	Orc = { --{23, 17, 22, 17, 23}
		WARRIOR = {--{3, 0, 2, 0, 0}
			{26, 17, 24, 17, 23}
		},
		HUNTER = { --{0, 3, 1, 0, 1}
			{23, 20, 23, 17, 24}
		},
		ROGUE = { --{1, 3, 1, 0, 0}
			{, , , , }
		},
		SHAMAN = { --{1, 0, 1, 1, 2}
			{24, 17, 23, 18, 25}
		},
		WARLOCK = { --{0, 0, 1, 2, 2}
			{, , , , }
		},
	},
	Scourge = { --{19, 18, 21, 18, 25}
		WARRIOR = {--{3, 0, 2, 0, 0}
			{22, 18, 23, 18, 25}
		},
		ROGUE = {
			{, , , , }
		},
		PRIEST = {
			{, , , , }
		},
		MAGE = {
			{, , , , }
		},
		WARLOCK = {
			{, , , , }
		},
	},
	Tauren = { --{25, 15, 22, 15, 22}
		WARRIOR = {--{3, 0, 2, 0, 0}
			{28, 15, 24, 15, 22}
		},
		HUNTER = { --{0, 3, 1, 0, 1}
			{, , , , }
		},
		SHAMAN = {
			{, , , , }
		},
		DRUID = { --{1, 0, 0, 2, 2}
			{26, 15, 22, 17, 24}
		},
	},
	Troll = { --{21, 22, 21, 16, 21}
		WARRIOR = {--{3, 0, 2, 0, 0}
			{24, 22, 23, 16, 21}
		},
		HUNTER = { --{0, 3, 1, 0, 1}
			{, , , , }
		},
		ROGUE = {
			{, , , , }
		},
		PRIEST = {
			{, , , , }
		},
		SHAMAN = {
			{, , , , }
		},
		MAGE = {
			{, , , , }
		},
	},
	BloodElf = { --{17, 22, 18, 24, 19}
		PALADIN = {--{2, 0, 2, 0, 1}
			{24, 16, 25, 19, 20}
		},
		HUNTER = { --{0, 3, 1, 0, 1}
			{21, 25, 22, 16, 22}
		},
		ROGUE = {
			{, , , , }
		},
		PRIEST = {
			{, , , , }
		},
		MAGE = {
			{, , , , }
		},
		WARLOCK = {
			{, , , , }
		},
	},
}
--]]
local RaceBaseStat = {
	["Human"] = {20, 20, 20, 20, 21},
	["Dwarf"] = {22, 16, 23, 19, 19},
	["NightElf"] = {17, 25, 19, 20, 20},
	["Gnome"] = {15, 23, 19, 24, 20},
	["Draenei"] = {21, 17, 19, 21, 22},
	["Orc"] = {23, 17, 22, 17, 23},
	["Scourge"] = {19, 18, 21, 18, 25},
	["Tauren"] = {25, 15, 22, 15, 22},
	["Troll"] = {21, 22, 21, 16, 21},
	["BloodElf"] = {17, 22, 18, 24, 19},
}
local ClassBonusStat = {
	["DRUID"] = {1, 0, 0, 2, 2},
	["HUNTER"] = {0, 3, 1, 0, 1},
	["MAGE"] = {0, 0, 0, 3, 2},
	["PALADIN"] = {2, 0, 2, 0, 1},
	["PRIEST"] = {0, 0, 0, 2, 3},
	["ROGUE"] = {1, 3, 1, 0, 0},
	["SHAMAN"] = {1, 0, 1, 1, 2},
	["WARLOCK"] = {0, 0, 1, 2, 2},
	["WARRIOR"] = {3, 0, 2, 0, 0},
}
local ClassBaseHealth = {
	["DRUID"] = 54,
	["HUNTER"] = 46,
	["MAGE"] = 52,
	["PALADIN"] = 38,
	["PRIEST"] = 52,
	["ROGUE"] = 45,
	["SHAMAN"] = 47,
	["WARLOCK"] = 43,
	["WARRIOR"] = 40,
}
local ClassBaseMana = {
	["DRUID"] = 70,
	["HUNTER"] = 85,
	["MAGE"] = 120,
	["PALADIN"] = 80,
	["PRIEST"] = 130,
	["ROGUE"] = 0,
	["SHAMAN"] = 75,
	["WARLOCK"] = 110,
	["WARRIOR"] = 0,
}
--http://wowvault.ign.com/View.php?view=Stats.List&category_select_id=9

--==================================--
-- Stat Mods from Talents and Buffs --
--==================================--
--[[ Aura mods from Thottbot
Apply Aura: Mod Total Stat % (All stats)
Apply Aura: Mod Total Stat % (Strength)
Apply Aura: Mod Total Stat % (Agility)
Apply Aura: Mod Total Stat % (Stamina)
Apply Aura: Mod Total Stat % (Intellect)
Apply Aura: Mod Total Stat % (Spirit)
Apply Aura: Mod Max Health %
Apply Aura: Reduces Attacker Chance to Hit with Melee
Apply Aura: Reduces Attacker Chance to Hit with Ranged
Apply Aura: Reduces Attacker Chance to Hit with Spells (Spells)
Apply Aura: Reduces Attacker Chance to Crit with Melee
Apply Aura: Reduces Attacker Chance to Crit with Ranged
Apply Aura: Reduces Attacker Critical Hit Damage with Melee by %
Apply Aura: Reduces Attacker Critical Hit Damage with Ranged by %
Apply Aura: Mod Dmg % (Spells)
Apply Aura: Mod Dmg % Taken (Fire, Frost)
Apply Aura: Mod Dmg % Taken (Spells)
Apply Aura: Mod Dmg % Taken (All)
Apply Aura: Mod Dmg % Taken (Physical)
Apply Aura: Mod Base Resistance % (Physical)
Apply Aura: Mod Block Percent
Apply Aura: Mod Parry Percent
Apply Aura: Mod Dodge Percent
Apply Aura: Mod Shield Block %
Apply Aura: Mod Detect
Apply Aura: Mod Skill Talent (Defense)
--]]
--[[ StatModAuras, mods not in use are commented out for now
"MOD_STR",
"MOD_AGI",
"MOD_STA",
"MOD_INT",
"MOD_SPI",
"MOD_HEALTH",
"MOD_MANA",
"MOD_ARMOR",
"MOD_BLOCK_VALUE",
--"MOD_DMG", school,
"MOD_DMG_TAKEN", school,
--"MOD_CRIT_DAMAGE", school,
"MOD_CRIT_DAMAGE_TAKEN", school,
--"MOD_THREAT", school,

"ADD_DODGE", -- Used in StatLogic:GetDodgePerAgi()
--"ADD_PARRY",
--"ADD_BLOCK",
--"ADD_STEALTH_DETECT",
--"ADD_STEALTH",
--"ADD_DEFENSE",
--"ADD_THREAT", school,
"ADD_HIT_TAKEN", school,
"ADD_CRIT_TAKEN", school,

--Talents
"ADD_AP_MOD_STA" -- Hunter: Hunter vs. Wild
"ADD_AP_MOD_ARMOR" -- Death Knight: Bladed Armor
"ADD_AP_MOD_INT" -- Shaman: Mental Dexterity
"ADD_AP_MOD_SPELL_DMG" -- Warlock: Metamorphosis
"ADD_CR_PARRY_MOD_STR" -- Death Knight: Forceful Deflection - Passive
"ADD_SPELL_CRIT_RATING_MOD_SPI" -- Mage: Molten Armor - 3.1.0
"ADD_MANA_REG_MOD_INT"
"ADD_RANGED_AP_MOD_INT"
"ADD_ARMOR_MOD_INT"
"ADD_SCHOOL_SP_MOD_SPI" -- Priest: Twisted Faith
"ADD_SPELL_DMG_MOD_STR" -- Paladin: Touched by the Light
"ADD_SPELL_DMG_MOD_STA"
"ADD_SPELL_DMG_MOD_INT"
"ADD_SPELL_DMG_MOD_SPI"
"ADD_SPELL_DMG_MOD_AP" -- Shaman: Mental Quickness, Paladin: Sheath of Light
"ADD_HEALING_MOD_STR" -- Paladin: Touched by the Light
"ADD_HEALING_MOD_AGI"
"ADD_HEALING_MOD_STA"
"ADD_HEALING_MOD_INT"
"ADD_HEALING_MOD_SPI"
"ADD_HEALING_MOD_AP" -- Shaman: Mental Quickness
"ADD_MANA_REG_MOD_NORMAL_MANA_REG"
"MOD_AP"
"MOD_RANGED_AP"
"MOD_SPELL_DMG"
"MOD_HEALING"

--"ADD_CAST_TIME"
--"MOD_CAST_TIME"
--"ADD_MANA_COST"
--"MOD_MANA_COST"
--"ADD_RAGE_COST"
--"MOD_RAGE_COST"
--"ADD_ENERGY_COST"
--"MOD_ENERGY_COST"
--"ADD_COOLDOWN"
--"MOD_COOLDOWN"
--]]

local StatModInfo = {
	------------------------------------------------------------------------------
	-- initialValue: sets the initial value for the stat mod
	-- if initialValue == 0, inter-mod operations are done with addition,
	-- if initialValue == 1, inter-mod operations are done with multiplication,
	------------------------------------------------------------------------------
	-- finalAdjust: added to the final result before returning,
	-- so we can adjust the return value to be used in addition or multiplication
	-- for addition: initialValue + finalAdjust = 0
	-- for multiplication: initialValue + finalAdjust = 1
	------------------------------------------------------------------------------
	-- school: school arg is required for these mods
	------------------------------------------------------------------------------
	["ADD_CRIT_TAKEN"] = {
		initialValue = 0,
		finalAdjust = 0,
		school = true,
	},
	["ADD_HIT_TAKEN"] = {
		initialValue = 0,
		finalAdjust = 0,
		school = true,
	},
	["ADD_DODGE"] = {
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_AP_MOD_INT"] = {
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_AP_MOD_STA"] = {
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_AP_MOD_ARMOR"] = {
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_AP_MOD_SPELL_DMG"] = {
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_CR_PARRY_MOD_STR"] = {
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_SPELL_CRIT_RATING_MOD_SPI"] = {
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_RANGED_AP_MOD_INT"] = {
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_ARMOR_MOD_INT"] = {
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_SCHOOL_SP_MOD_SPI"] = {
		initialValue = 0,
		finalAdjust = 0,
		school = true,
	},
	["ADD_SPELL_DMG_MOD_AP"] = {
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_SPELL_DMG_MOD_STR"] = {
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_SPELL_DMG_MOD_STA"] = {
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_SPELL_DMG_MOD_INT"] = {
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_SPELL_DMG_MOD_INT"] = {
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_SPELL_DMG_MOD_SPI"] = {
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_SPELL_DMG_MOD_PET_STA"] = { -- Demonic Knowledge
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_SPELL_DMG_MOD_PET_INT"] = { -- Demonic Knowledge
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_HEALING_MOD_AP"] = {
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_HEALING_MOD_STR"] = {
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_HEALING_MOD_AGI"] = { -- Nurturing Instinct
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_HEALING_MOD_STA"] = {
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_HEALING_MOD_INT"] = {
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_HEALING_MOD_SPI"] = {
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_MANA_REG_MOD_INT"] = {
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_MANA_REG_MOD_MANA"] = {
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_MANA_REG_MOD_NORMAL_MANA_REG"] = {
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_PET_STA_MOD_STA"] = {
		initialValue = 1,
		finalAdjust = 0,
	},
	["ADD_PET_INT_MOD_INT"] = {
		initialValue = 1,
		finalAdjust = 0,
	},
	["MOD_CRIT_DAMAGE_TAKEN"] = {
		initialValue = 0,
		finalAdjust = 1,
		school = true,
	},
	["MOD_DMG_TAKEN"] = {
		initialValue = 0,
		finalAdjust = 1,
		school = true,
	},
	["MOD_CRIT_DAMAGE"] = {
		initialValue = 0,
		finalAdjust = 1,
		school = true,
	},
	["MOD_DMG"] = {
		initialValue = 0,
		finalAdjust = 1,
		school = true,
	},
	["MOD_ARMOR"] = {
		initialValue = 1,
		finalAdjust = 0,
	},
	["MOD_HEALTH"] = {
		initialValue = 1,
		finalAdjust = 0,
	},
	["MOD_MANA"] = {
		initialValue = 1,
		finalAdjust = 0,
	},
	["MOD_STR"] = {
		initialValue = 1,
		finalAdjust = 0,
	},
	["MOD_AGI"] = {
		initialValue = 1,
		finalAdjust = 0,
	},
	["MOD_STA"] = {
		initialValue = 1,
		finalAdjust = 0,
	},
	["MOD_INT"] = {
		initialValue = 1,
		finalAdjust = 0,
	},
	["MOD_SPI"] = {
		initialValue = 1,
		finalAdjust = 0,
	},
	["MOD_BLOCK_VALUE"] = {
		initialValue = 0,
		finalAdjust = 1,
	},
	["MOD_AP"] = {
		initialValue = 0,
		finalAdjust = 1,
	},
	["MOD_RANGED_AP"] = {
		initialValue = 0,
		finalAdjust = 1,
	},
	["MOD_SPELL_DMG"] = {
		initialValue = 0,
		finalAdjust = 1,
	},
	["MOD_HEALING"] = {
		initialValue = 0,
		finalAdjust = 1,
	},
}
StatLogic.StatModInfo = StatModInfo -- so other addons can use this directly

------------------
-- StatModTable --
------------------
--[[ How to add a glyph support?
1. Go to the glyph item on wowhead.
2. Click on the green Use: TEXT on the "tooltip" to go to a spell page.
3. Click on "See also" tab for a spell with a gear icon, the spell id for this page is what you put in here.
--]]
local StatModTable = {}
StatLogic.StatModTable = StatModTable -- so other addons can use this directly
if playerClass == "DRUID" then
	StatModTable["DRUID"] = {
		-- Druid: Master Shapeshifter (Rank 2) - 3,9
		--        Moonkin Form - Increases spell damage by 2%/4%.
		--      * Does not affect char window stats
		-- Druid: Earth and Moon (Rank 5) - 1,27
		--        Also increases your spell damage by 1%/2%/3%/4%/5%.
		--      * Does not affect char window stats
		--[[
		["MOD_SPELL_DMG"] = {
			{
				["rank"] = {
					0.02, 0.04,
				},
				["buff"] = 24858,		-- ["Moonkin Form"],
			},
			{
				["tab"] = 1,
				["num"] = 27,
				["rank"] = {
					0.01, 0.02, 0.03, 0.04, 0.05,
				},
			},
		},
		--]]
		-- Druid: Master Shapeshifter (Rank 2) - 3,9
		--        Tree of Life Form - Increases healing by 2%/4%.
		--      * Does not affect char window stats
		--[[
		["MOD_HEALING"] = {
			{
				["rank"] = {
					0.02, 0.04,
				},
				["buff"] = 33891,		-- ["Tree of Life"],
			},
		},
		--]]
		-- Druid: Improved Moonkin Form (Rank 3) - 1,19
		--        Your Moonkin Aura also causes affected targets to gain 1%/2%/3% haste and you to gain 10/20/30% of your spirit as additional spell damage.
		["ADD_SPELL_DMG_MOD_SPI"] = {
			{
				["tab"] = 1,
				["num"] = 19,
				["rank"] = {
					0.1, 0.2, 0.3,
				},
				["buff"] = 24858, -- ["Moonkin Form"],
			},
		},
		-- Druid: Improved Tree of Life (Rank 3) - 3,24
		--        Increases your Armor while in Tree of Life Form by 33%/66%/100%, and increases your healing spell power by 5%/10%/15% of your spirit while in Tree of Life Form.
		["ADD_HEALING_MOD_SPI"] = {
			{
				["tab"] = 3,
				["num"] = 24,
				["rank"] = {
					0.05, 0.10, 0.15,
				},
				["buff"] = 33891, -- ["Tree of Life"],
			},
		},
		-- Druid: Lunar Guidance (Rank 3) - 1,12
		--        Increases your spell damage and healing by 8%/16%/25% of your total Intellect.
		-- 3.0.1: Increases your spell damage and healing by 4%/8%/12% of your total Intellect.
		["ADD_SPELL_DMG_MOD_INT"] = {
			{
				["tab"] = 1,
				["num"] = 12,
				["rank"] = {
					0.04, 0.08, 0.12,
				},
			},
		},
		-- Druid: Lunar Guidance (Rank 3) - 1,12
		--        Increases your spell damage and healing by 8%/16%/25% of your total Intellect.
		-- 3.0.1: Increases your spell damage and healing by 4%/8%/12% of your total Intellect.
		["ADD_HEALING_MOD_INT"] = {
			{
				["tab"] = 1,
				["num"] = 12,
				["rank"] = {
					0.04, 0.08, 0.12,
				},
			},
		},
		-- Druid: Nurturing Instinct (Rank 2) - 2,14
		--        Increases your healing spells by up to 25%/50% of your Strength.
		-- 2.4.0: Increases your healing spells by up to 50%/100% of your Agility, and increases healing done to you by 10%/20% while in Cat form.
		-- 3.0.1: 2,15: Increases your healing spells by up to 35%/70% of your Agility, and increases healing done to you by 10%/20% while in Cat form.
		["ADD_HEALING_MOD_AGI"] = {
			{
				["tab"] = 2,
				["num"] = 15,
				["rank"] = {
					0.35, 0.7,
				},
			},
		},
		-- Druid: Intensity (Rank 3) - 3,6
		--        Allows 17/33/50% of your Mana regeneration to continue while casting and causes your Enrage ability to instantly generate 10 rage.
		["ADD_MANA_REG_MOD_NORMAL_MANA_REG"] = {
			{
				["tab"] = 3,
				["num"] = 7,
				["rank"] = {
					0.17, 0.33, 0.50,
				},
			},
		},
		-- Druid: Dreamstate (Rank 3) - 1,15
		--        Regenerate mana equal to 4%/7%/10% of your Intellect every 5 sec, even while casting.
		["ADD_MANA_REG_MOD_INT"] = {
			{
				["tab"] = 1,
				["num"] = 15,
				["rank"] = {
					0.04, 0.07, 0.10,
				},
			},
		},
		-- Druid: Feral Swiftness (Rank 2) - 2,6
		--        Increases your movement speed by 15%/30% while outdoors in Cat Form and increases your chance to dodge while in Cat Form, Bear Form and Dire Bear Form by 2%/4%.
		-- Druid: Natural Reaction (Rank 3) - 2,16
		--        Increases your dodge while in Bear Form or Dire Bear Form by 2%/4%/6%, and you regenerate 3 rage every time you dodge while in Bear Form or Dire Bear Form.
		["ADD_DODGE"] = {
			{
				["tab"] = 2,
				["num"] = 6,
				["rank"] = {
					2, 4,
				},
				["buff"] = 32357,		-- ["Bear Form"],
			},
			{
				["tab"] = 2,
				["num"] = 6,
				["rank"] = {
					2, 4,
				},
				["buff"] = 9634,		-- ["Dire Bear Form"],
			},
			{
				["tab"] = 2,
				["num"] = 6,
				["rank"] = {
					2, 4,
				},
				["buff"] = 32356,		-- ["Cat Form"],
			},
			{
				["tab"] = 2,
				["num"] = 16,
				["rank"] = {
					2, 4, 6,
				},
				["buff"] = 32357,		-- ["Bear Form"],
			},
			{
				["tab"] = 2,
				["num"] = 16,
				["rank"] = {
					2, 4, 6,
				},
				["buff"] = 9634,		-- ["Dire Bear Form"],
			},
		},
		-- Druid: Survival of the Fittest (Rank 3) - 2,18
		--        Increases all attributes by 2%/4%/6% and reduces the chance you'll be critically hit by melee attacks by 2%/4%/6%.
		["ADD_CRIT_TAKEN"] = {
			{
				["MELEE"] = true,
				["tab"] = 2,
				["num"] = 18,
				["rank"] = {
					-0.02, -0.04, -0.06,
				},
			},
		},
		-- Druid: Barkskin - Buff
		--        All damage taken is reduced by 20%.
		-- Druid: Improved Barkskin (Rank 2) - 3,25
		--        Increases the damage reduction granted by your Barkskin spell by 5/10%
		-- Druid: Natural Perfection (Rank 3) - 3,19
		--        Your critical strike chance with all spells is increased by 3% and critical strikes against you 
		--        give you the Natural Perfection effect reducing all damage taken by 2/3/4%.  Stacks up to 3 times.  Lasts 8 sec.
		-- Druid: Protector of the Pack (Rank 5) - 2,22
		--        Increases your attack power in Bear Form and Dire Bear Form by 2%/4%/6%, and for each friendly player 
		--        in your party when you enter Bear Form or Dire Bear Form, damage you take is reduced while in Bear Form and Dire Bear Form by 1%/2%/3%.
		-- Druid: Balance of Power (Rank 2) - 1,17
		--        Increases your chance to hit with all spells by 2%/4% and reduces the damage taken by all spells by 3%/6%.
		["MOD_DMG_TAKEN"] = {
			{-- Barkskin
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["rank"] = {
					-0.2,
				},
				["buff"] = 22812,		-- ["Barkskin"],
			},
			{-- Improved Barkskin
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["tab"] = 3,
				["num"] = 25,
				["rank"] = {
					-0.05, -0.1,
				},
				["buff"] = 22812,		-- ["Barkskin"],
			},
			{
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["tab"] = 3,
				["num"] = 19,
				["rank"] = {
					-0.02, -0.03, -0.04,
				},
				["buff"] = 45283,		-- ["Natural Perfection"],
				["buffStack"] = 3, -- max number of stacks
			},
			{
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["tab"] = 2,
				["num"] = 22,
				["rank"] = {
					-0.01, -0.02, -0.03,
				},
				["buff"] = 32357,		-- ["Bear Form"],
				["condition"] = "GetNumPartyMembers() == 1",
			},
			{
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["tab"] = 2,
				["num"] = 22,
				["rank"] = {
					-0.02, -0.04, -0.06,
				},
				["buff"] = 32357,		-- ["Bear Form"],
				["condition"] = "GetNumPartyMembers() == 2",
			},
			{
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["tab"] = 2,
				["num"] = 22,
				["rank"] = {
					-0.03, -0.06, -0.09,
				},
				["buff"] = 32357,		-- ["Bear Form"],
				["condition"] = "GetNumPartyMembers() == 3",
			},
			{
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["tab"] = 2,
				["num"] = 22,
				["rank"] = {
					-0.04, -0.08, -0.12,
				},
				["buff"] = 32357,		-- ["Bear Form"],
				["condition"] = "GetNumPartyMembers() == 4",
			},
			{
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["tab"] = 2,
				["num"] = 22,
				["rank"] = {
					-0.01, -0.02, -0.03,
				},
				["buff"] = 9634,		-- ["Dire Bear Form"],
				["condition"] = "GetNumPartyMembers() == 1",
			},
			{
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["tab"] = 2,
				["num"] = 22,
				["rank"] = {
					-0.02, -0.04, -0.06,
				},
				["buff"] = 9634,		-- ["Dire Bear Form"],
				["condition"] = "GetNumPartyMembers() == 2",
			},
			{
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["tab"] = 2,
				["num"] = 22,
				["rank"] = {
					-0.03, -0.06, -0.09,
				},
				["buff"] = 9634,		-- ["Dire Bear Form"],
				["condition"] = "GetNumPartyMembers() == 3",
			},
			{
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["tab"] = 2,
				["num"] = 22,
				["rank"] = {
					-0.04, -0.08, -0.12,
				},
				["buff"] = 9634,		-- ["Dire Bear Form"],
				["condition"] = "GetNumPartyMembers() == 4",
			},
			{--Balance of Power
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["tab"] = 1,
				["num"] = 17,
				["rank"] = {
					-0.03, -0.06,
				},
				["new"] = 10147,
			},
		},
		-- Druid: Balance of Power (Rank 2) - 1,17
		--        Increases your chance to hit with all spells by 2%/4% and reduces the damage taken by all spells by 3%/6%.
		["ADD_HIT_TAKEN"] = {
			{
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["tab"] = 1,
				["num"] = 17,
				["rank"] = {
					-0.02, -0.04,
				},
				["old"] = 10147,
			},
		},
		-- Druid: Thick Hide (Rank 3) - 2,5
		--        Increases your Armor contribution from items by 4%/7%/10%.
		-- Druid: Bear Form - buff (didn't use stance because Bear Form and Dire Bear Form has the same icon)
		--        Shapeshift into a bear, increasing melee attack power by 30, armor contribution from items by 180%, and stamina by 25%.
		-- Druid: Dire Bear Form - Buff
		--        Shapeshift into a dire bear, increasing melee attack power by 120, armor contribution from items by 370%, and stamina by 25%.
		-- Druid: Moonkin Form - Buff
		--        While in this form the armor contribution from items is increased by 370% and 
		--        all party and raid members within 45 yards have their spell critical chance increased by 5%.  
		--        Spell critical strikes in this form have a chance to instantly regenerate 2% of your total mana.
		-- Druid: Improved Tree of Life (Rank 3) - 3,24
		--        Increases your Armor while in Tree of Life Form by 67%/133%/200%
		-- Druid: Survival of the Fittest (Rank 3) - 2,18
		--        Increases all attributes by 2%/4%/6% and reduces the chance you'll be critically hit by melee attacks by 2%/4%/6%.
		--        , and increases your armor contribution from cloth and leather items in Bear Form and Dire Bear Form by 11/22/33%.
		["MOD_ARMOR"] = {
			{
				["tab"] = 2,
				["num"] = 5,
				["rank"] = {
					0.04, 0.07, 0.1,
				},
			},
			{
				["rank"] = {
					1.8,
				},
				["buff"] = 32357,		-- ["Bear Form"],
			},
			{
				["rank"] = {
					3.7,
				},
				["buff"] = 9634,		-- ["Dire Bear Form"],
			},
			{
				["rank"] = {
					3.7,
				},
				["buff"] = 24858,		-- ["Moonkin Form"],
			},
			{
				["tab"] = 3,
				["num"] = 24,
				["rank"] = {
					0.67, 1.33, 2,
				},
				["buff"] = 33891,		-- ["Tree of Life"],
			},
			{
				["tab"] = 2,
				["num"] = 18,
				["rank"] = {
					0.11, 0.22, 0.33,
				},
				["buff"] = 32357,		-- ["Bear Form"],
			},
			{
				["tab"] = 2,
				["num"] = 18,
				["rank"] = {
					0.11, 0.22, 0.33,
				},
				["buff"] = 9634,		-- ["Dire Bear Form"],
			},
		},
		-- Druid: Survival Instincts - Buff
		--        Health increased by 30% of maximum while in Bear Form, Cat Form, or Dire Bear Form.
		["MOD_HEALTH"] = {
			{
				["rank"] = {
					0.3,
				},
				["buff"] = 50322,		-- ["Survival Instincts"],
				["buff2"] = 32357,		-- ["Bear Form"],
			},
			{
				["rank"] = {
					0.3,
				},
				["buff"] = 50322,		-- ["Survival Instincts"],
				["buff2"] = 9634,		-- ["Dire Bear Form"],
			},
			{
				["rank"] = {
					0.3,
				},
				["buff"] = 50322,		-- ["Survival Instincts"],
				["buff2"] = 32356,		-- ["Cat Form"],
			},
		},
		-- Druid: Improved Mark of the Wild (Rank 2) - 3,1
		--        increases all of your total attributes by 1/2%.
		-- Druid: Heart of the Wild (Rank 5) - 2,17
		--        Increases your Intellect by 4%/8%/12%/16%/20%. In addition, 
		--        while in Bear or Dire Bear Form your Stamina is increased by 2/4/6/8/10% and 
		--        while in Cat Form your attack power is increased by 2/4/6/8/10%.
		-- Druid: Bear Form - Stance (use stance because bear and dire bear increases are the same)
		--        Shapeshift into a bear, increasing melee attack power by 30, armor contribution from items by 180%, and stamina by 25%.
		-- Druid: Dire Bear Form - Stance (use stance because bear and dire bear increases are the same)
		--        Shapeshift into a dire bear, increasing melee attack power by 120, armor contribution from items by 400%, and stamina by 25%.
		-- 9038:  Shapeshift into a dire bear, increasing melee attack power by 120, armor contribution from items by 370%, and stamina by 25%.
		-- Druid: Survival of the Fittest (Rank 3) - 2,18
		--        Increases all attributes by 2%/4%/6% and reduces the chance you'll be critically hit by melee attacks by 2%/4%/6%.
		["MOD_STA"] = {
			{ -- Improved Mark of the Wild
				["tab"] = 3,
				["num"] = 1,
				["rank"] = {
					0.01, 0.02,
				},
			},
			{ -- Heart of the Wild: +2/4/6/8/10% stamina in bear / dire bear
				["tab"] = 2,
				["num"] = 17,
				["rank"] = {
					0.02, 0.04, 0.06, 0.08, 0.1,
				},
				["buff"] = 32357,		-- ["Bear Form"],
			},
			{
				["tab"] = 2,
				["num"] = 17,
				["rank"] = {
					0.02, 0.04, 0.06, 0.08, 0.1,
				},
				["buff"] = 9634,		-- ["Dire Bear Form"],
			},
			{ -- Survival of the Fittest: 2%/4%/6% all stats
				["tab"] = 2,
				["num"] = 18,
				["rank"] = {
					0.02, 0.04, 0.06,
				},
			},
			{ -- Bear Form / Dire Bear Form: +25% stamina
				["rank"] = {
					0.25,
				},
				["buff"] = 32357,		-- ["Bear Form"],
			},
			{ -- Bear Form / Dire Bear Form: +25% stamina
				["rank"] = {
					0.25,
				},
				["buff"] = 9634,		-- ["Dire Bear Form"],
			},
		},
		-- Druid: Improved Mark of the Wild (Rank 2) - 3,1
		--        increases all of your total attributes by 1/2%.
		-- Druid: Survival of the Fittest (Rank 3) - 2,18
		--        Increases all attributes by 2%/4%/6% and reduces the chance you'll be critically hit by melee attacks by 2%/4%/6%.
		["MOD_STR"] = {
			{ -- Improved Mark of the Wild
				["tab"] = 3,
				["num"] = 1,
				["rank"] = {
					0.01, 0.02,
				},
			},
			{
				["tab"] = 2,
				["num"] = 18,
				["rank"] = {
					0.02, 0.04, 0.06,
				},
			},
		},
		-- Druid: Improved Mark of the Wild (Rank 2) - 3,1
		--        increases all of your total attributes by 1/2%.
		-- Druid: Heart of the Wild (Rank 5) - 2,17
		--        Increases your Intellect by 4%/8%/12%/16%/20%. In addition, 
		--        while in Bear or Dire Bear Form your Stamina is increased by 2/4/6/8/10% and 
		--        while in Cat Form your attack power is increased by 2/4/6/8/10%.
		-- Druid: Protector of the Pack (Rank 5) - 2,22
		--        Increases your attack power in Bear Form and Dire Bear Form by 2%/4%/6%, and for each friendly player in your party when you enter Bear Form or Dire Bear Form, damage you take is reduced while in Bear Form and Dire Bear Form by 1%/2%/3%.
		["MOD_AP"] = {
			{ -- Improved Mark of the Wild
				["tab"] = 3,
				["num"] = 1,
				["rank"] = {
					0.01, 0.02,
				},
			},
			{
				["tab"] = 2,
				["num"] = 17,
				["rank"] = {
					0.02, 0.04, 0.06, 0.08, 0.1,
				},
				["buff"] = 32356,		-- ["Cat Form"],
			},
			{
				["tab"] = 2,
				["num"] = 22,
				["rank"] = {
					0.02, 0.04, 0.06,
				},
				["buff"] = 32357,		-- ["Bear Form"],
			},
			{
				["tab"] = 2,
				["num"] = 22,
				["rank"] = {
					0.02, 0.04, 0.06,
				},
				["buff"] = 9634,		-- ["Dire Bear Form"],
			},
		},
		-- Druid: Improved Mark of the Wild (Rank 2) - 3,1
		--        increases all of your total attributes by 1/2%.
		-- Druid: Survival of the Fittest (Rank 3) - 2,18
		--        Increases all attributes by 2%/4%/6% and reduces the chance you'll be critically hit by melee attacks by 2%/4%/6%.
		["MOD_AGI"] = {
			{ -- Improved Mark of the Wild
				["tab"] = 3,
				["num"] = 1,
				["rank"] = {
					0.01, 0.02,
				},
			},
			{
				["tab"] = 2,
				["num"] = 18,
				["rank"] = {
					0.02, 0.04, 0.06,
				},
			},
		},
		-- Druid: Improved Mark of the Wild (Rank 2) - 3,1
		--        increases all of your total attributes by 1/2%.
		-- Druid: Heart of the Wild (Rank 5) - 2,17
		--        Increases your Intellect by 4%/8%/12%/16%/20%. In addition, 
		--        while in Bear or Dire Bear Form your Stamina is increased by 2/4/6/8/10% and 
		--        while in Cat Form your attack power is increased by 2/4/6/8/10%.
		-- Druid: Survival of the Fittest (Rank 3) - 2,18
		--        Increases all attributes by 2%/4%/6% and reduces the chance you'll be critically hit by melee attacks by 2%/4%/6%.
		-- Druid: Furor (Rank 5) - 3,3
		--        Increases your total Intellect while in Moonkin form by 2%/4%/6%/8%/10%.
		["MOD_INT"] = {
			{ -- Improved Mark of the Wild
				["tab"] = 3,
				["num"] = 1,
				["rank"] = {
					0.01, 0.02,
				},
			},
			{
				["tab"] = 2,
				["num"] = 17,
				["rank"] = {
					0.04, 0.08, 0.12, 0.16, 0.2,
				},
			},
			{
				["tab"] = 2,
				["num"] = 18,
				["rank"] = {
					0.02, 0.04, 0.06,
				},
			},
			{
				["tab"] = 3,
				["num"] = 3,
				["rank"] = {
					0.02, 0.04, 0.06, 0.08, 0.1,
				},
				["buff"] = 24858,		-- ["Moonkin Form"],
			},
		},
		-- Druid: Improved Mark of the Wild (Rank 2) - 3,1
		--        increases all of your total attributes by 1/2%.
		-- Druid: Living Spirit (Rank 3) - 3,17
		--        Increases your total Spirit by 5%/10%/15%.
		-- Druid: Survival of the Fittest (Rank 3) - 2,18
		--        Increases all attributes by 2%/4%/6% and reduces the chance you'll be critically hit by melee attacks by 2%/4%/6%.
		["MOD_SPI"] = {
			{ -- Improved Mark of the Wild
				["tab"] = 3,
				["num"] = 1,
				["rank"] = {
					0.01, 0.02,
				},
			},
			{
				["tab"] = 3,
				["num"] = 17,
				["rank"] = {
					0.05, 0.1, 0.15,
				},
			},
			{
				["tab"] = 2,
				["num"] = 18,
				["rank"] = {
					0.02, 0.04, 0.06,
				},
			},
		},
	}
elseif playerClass == "DEATHKNIGHT" then
	StatModTable["DEATHKNIGHT"] = {
		-- Death Knight: Forceful Deflection - Passive
		--               Increases your Parry Rating by 25% of your total Strength.
		["ADD_CR_PARRY_MOD_STR"] = {
			{
				["rank"] = {
					0.25,
				},
			},
		},
		-- Death Knight: Bladed Armor (Rank 5) - 1,4
		--               You gain 5/10/15/20/25 attack power for every 1000 points of your armor value.
		--         9014: Increases your attack power by 1/2/3/4/5 for every 180 armor value you have.
		["ADD_AP_MOD_ARMOR"] = {
			{
				["tab"] = 1,
				["num"] = 4,
				["rank"] = {
					1/180, 2/180, 3/180, 4/180, 5/180,
				},
			},
		},
		-- Death Knight: Blade Barrier - Buff - 1,3
		--               Whenever your Blood Runes are on cooldown, you gain the Blade Barrier effect, which decreases damage taken by 1/2/3/4/5% for the next 10 sec.
		-- Death Knight: Icebound Fortitude - Buff
		--               Damage taken reduced by 30%+def*0.15.
		-- Death Knight: Glyph of Icebound Fortitude - Major Glyph
		--               Your Icebound Fortitude now always grants at least 30% damage reduction, regardless of your defense skill.
		-- Death Knight: Bone Shield - Buff
		--               Damage reduced by 20%.
		-- Death Knight: Anti-Magic Shell - Buff
		--               Spell damage reduced by 75%.
		-- Death Knight: Frost Presence - Buff
		--               Increasing Stamina by 6%, armor contribution from cloth, leather, mail and plate items by 60%, and reducing damage taken by 8%.
		-- Death Knight: Will of the Necropolis (Rank 3) - 1,24
		--               Damage that would take you below 35% health or taken while you are at 35% health is reduced by 5%/10%/15%
		-- Death Knight: Magic Suppression (Rank 3) - 3,17
		--               You take 2%/4%/6% less damage from all magic.
		--        3.2.0: 3,18
		-- Enchant: Rune of Spellshattering - EnchantID: 3367
		--          Deflects 4% of all spell damage to 2h weapon
		-- Enchant: Rune of Spellbreaking - EnchantID: 3595
		--          Deflects 2% of all spell damage to 1h weapon
		-- Death Knight: Improved Frost Presence (Rank 2) - 2,21
		--               While in Blood Presence or Unholy Presence, you retain 3/6% stamina from Frost Presence, 
		--               and damage done to you is decreased by an additional 1/2% in Frost Presence.
		["MOD_DMG_TAKEN"] = {
			{
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["tab"] = 1,
				["num"] = 3,
				["rank"] = {
					-0.01, -0.02, -0.03, -0.04, -0.05,
				},
				["buff"] = 55226,		-- ["Blade Barrier"],
			},
			{
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["rank"] = {
					-0.30,
				},
				["buff"] = 48792,		-- ["Icebound Fortitude"],
			},
			{
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["rank"] = {
					-0.10,
				},
				["buff"] = 48792,		-- ["Icebound Fortitude"],
				["glyph"] = 58625, -- Glyph of Icebound Fortitude
			},
			{
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["rank"] = {
					-0.20,
				},
				["buff"] = 49222,		-- ["Bone Shield"],
			},
			{
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["rank"] = {
					-0.75,
				},
				["buff"] = 48707,		-- ["Anti-Magic Shell"],
			},
			{
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["rank"] = {
					-0.05,
				},
				["stance"] = "Interface\\Icons\\Spell_Deathknight_FrostPresence",
				["old"] = 10371,
			},
			{
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["rank"] = {
					-0.08,
				},
				["stance"] = "Interface\\Icons\\Spell_Deathknight_FrostPresence",
				["new"] = 10371,
			},
			{--Will of the Necropolis (Rank 3) - 1,24
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["tab"] = 1,
				["num"] = 24,
				["rank"] = {
					-0.05, -0.1, -0.15,
				},
				["condition"] = "((UnitHealth('player') / UnitHealthMax('player')) < 0.35)",
			},
			{--Magic Suppression (Rank 3) - 3,17
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["tab"] = 3,
				["num"] = 17,
				["rank"] = {
					-0.02, -0.04, -0.06,
				},
				["old"] = 10147,
			},
			{--Magic Suppression (Rank 3) - 3,18
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["tab"] = 3,
				["num"] = 18,
				["rank"] = {
					-0.02, -0.04, -0.06,
				},
				["new"] = 10147,
			},
			{-- Rune of Spellshattering
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["rank"] = {
					-0.04,
				},
				["slot"] = 16, -- main hand slot
				["enchant"] = 3367,
			},
			{-- Rune of Spellbreaking
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["rank"] = {
					-0.02,
				},
				["slot"] = 16, -- main hand slot
				["enchant"] = 3595,
			},
			{-- Rune of Spellbreaking
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["rank"] = {
					-0.02,
				},
				["slot"] = 17, -- off hand slot
				["enchant"] = 3595,
			},
			{-- Improved Frost Presence
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["tab"] = 2,
				["num"] = 21,
				["rank"] = {
					-0.01, -0.02,
				},
				["stance"] = "Interface\\Icons\\Spell_Deathknight_FrostPresence",
			},
		},
		-- Death Knight: Anticipation (Rank 5) - 3,3
		--               Increases your Dodge chance by 1%/2%/3%/4%/5%.
		["ADD_DODGE"] = {
			{
				["tab"] = 3,
				["num"] = 3,
				["rank"] = {
					1, 2, 3, 4, 5,
				},
			},
		},
		-- Death Knight: Frigid Dreadplate (Rank 3) - 2,13
		--               Reduces the chance melee attacks will hit you by 1%/2%/3%.
		["ADD_HIT_TAKEN"] = {
			{
				["tab"] = 2,
				["num"] = 13,
				["rank"] = {
					-0.01, -0.02, -0.03,
				},
			},
		},
		-- Death Knight: Toughness (Rank 5) - 2,3
		--               Increases your armor value from items by 2/4/6/8/10% and reduces the duration of all movement slowing effects by 50%.
		-- Death Knight: Unbreakable Armor - Buff
		--               Increases your armor by 25%, your total Strength by 20%
		-- Death Knight: Glyph of Unbreakable Armor - Major Glyph
		--               Increases the armor granted by Unbreakable Armor by 20%.
		-- Death Knight: Frost Presence - Buff
		--               Increasing Stamina by 6%, armor contribution from cloth, leather, mail and plate items by 60%, and reducing damage taken by 5%.
		["MOD_ARMOR"] = {
			{
				["tab"] = 2,
				["num"] = 3,
				["rank"] = {
					0.03, 0.06, 0.09, 0.12, 0.15,
				},
				["old"] = 10147,
			},
			{
				["tab"] = 2,
				["num"] = 3,
				["rank"] = {
					0.02, 0.04, 0.06, 0.08, 0.1,
				},
				["new"] = 10147,
			},
			{
				["rank"] = {
					0.25,
				},
				["buff"] = 51271,		-- ["Unbreakable Armor"],
				["new"] = 10371,
			},
			{
				["rank"] = {
					0.2,
				},
				["buff"] = 51271,		-- ["Unbreakable Armor"],
				["glyph"] = 58635,		-- ["Glyph of Unbreakable Armor"],
			},
			{
				["rank"] = {
					0.6,
				},
				["stance"] = "Interface\\Icons\\Spell_Deathknight_FrostPresence",
			},
		},
		-- Death Knight: Frost Presence - Buff
		--               Increasing Stamina by 6%, armor contribution from cloth, leather, mail 
		--               and plate items by 60%, and reducing damage taken by 5%.
		-- Death Knight: Improved Frost Presence (Rank 2) - 2,21
		--               While in Blood Presence or Unholy Presence, you retain 3/6% stamina from Frost Presence, 
		--               and damage done to you is decreased by an additional 1/2% in Frost Presence.
		["MOD_HEALTH"] = {
			{
				["rank"] = {
					0.1,
				},
				["stance"] = "Interface\\Icons\\Spell_Deathknight_FrostPresence",
				["old"] = 10147,
			},
			{
				["tab"] = 2,
				["num"] = 21,
				["rank"] = {
					0.05, 0.1,
				},
				["stance"] = "Interface\\Icons\\Spell_Deathknight_BloodPresence",
				["old"] = 10147,
			},
			{
				["tab"] = 2,
				["num"] = 21,
				["rank"] = {
					0.05, 0.1,
				},
				["stance"] = "Interface\\Icons\\Spell_Deathknight_UnholyPresence",
				["old"] = 10147,
			},
		},
		-- Death Knight: Veteran of the Third War (Rank 3) - 1,14
		--               Increases your total Strength by 2%/4%/6% and your total Stamina by 1%/2%/3%.
		-- Enchant: Rune of the Stoneskin Gargoyle - EnchantID: 3847
		--          +25 Defense and +2% Stamina to 2h weapon
		-- Death Knight: Frost Presence - Buff
		--               Increasing Stamina by 8%, armor contribution from cloth, leather, mail 
		--               and plate items by 60%, and reducing damage taken by 5%.
		-- Death Knight: Improved Frost Presence (Rank 2) - 2,21
		--               While in Blood Presence or Unholy Presence, you retain 3/6% stamina from Frost Presence, 
		--               and damage done to you is decreased by an additional 1/2% in Frost Presence.
		-- Death Knight: Endless Winter (Rank 2) - 2,12
		--               Your strength is increased by 2%/4%.
		["MOD_STA"] = {
			{
				["tab"] = 1,
				["num"] = 14,
				["rank"] = {
					0.02, 0.04, 0.06,
				},
				["old"] = 10147,
			},
			{
				["tab"] = 1,
				["num"] = 14,
				["rank"] = {
					0.01, 0.02, 0.03,
				},
				["new"] = 10147,
			},
			{
				["rank"] = {
					0.02,
				},
				["slot"] = 16, -- 2h weapon
				["enchant"] = 3847,
			},
			{
				["rank"] = {
					0.08,
				},
				["stance"] = "Interface\\Icons\\Spell_Deathknight_FrostPresence",
				["new"] = 10147,
			},
			{
				["tab"] = 2,
				["num"] = 21,
				["rank"] = {
					0.03, 0.06,
				},
				["stance"] = "Interface\\Icons\\Spell_Deathknight_BloodPresence",
				["new"] = 10147,
			},
			{
				["tab"] = 2,
				["num"] = 21,
				["rank"] = {
					0.03, 0.06,
				},
				["stance"] = "Interface\\Icons\\Spell_Deathknight_UnholyPresence",
				["new"] = 10147,
			},
			{-- Endless Winter
				["tab"] = 2,
				["num"] = 12,
				["rank"] = {
					0.02, 0.04,
				},
				["new"] = 11685,
			},
		},
		-- Death Knight: Veteran of the Third War (Rank 3) - 1,14
		--               Increases your total Strength by 6% and your total Stamina by 3%.
		-- Death Knight: Unbreakable Armor - Buff
		--               Increasing your armor by 25% and increasing your Strength by 20% for 20 sec.
		-- Death Knight: Ravenous Dead (Rank 3) - 3,7
		--               Increases your total Strength 1%/2%/3% and the contribution your Ghouls get from your Strength and Stamina by 20%/40%/60%
		-- Death Knight: Abomination's Might - 1,17
		--               Also increases your total Strength by 1%/2%.
		["MOD_STR"] = {
			{
				["tab"] = 1,
				["num"] = 14,
				["rank"] = {
					0.02, 0.04, 0.06,
				},
			},
			{
				["rank"] = {
					0.1,
				},
				["buff"] = 51271,		-- ["Unbreakable Armor"],
				["old"] = 11685,
			},
			{
				["rank"] = {
					0.2,
				},
				["buff"] = 51271,		-- ["Unbreakable Armor"],
				["new"] = 11685,
			},
			{
				["tab"] = 3,
				["num"] = 7,
				["rank"] = {
					0.01, 0.02, 0.03,
				},
			},
			{
				["tab"] = 1,
				["num"] = 17,
				["rank"] = {
					0.01, 0.02,
				},
			},
		},
	}
elseif playerClass == "HUNTER" then
	StatModTable["HUNTER"] = {
		-- Hunter: Hunter vs. Wild (Rank 3) - 3,14
		--         Increases you and your pet's attack power and ranged attack power equal to 10%/20%/30% of your total Stamina.
		["ADD_AP_MOD_STA"] = {
			{
				["tab"] = 3,
				["num"] = 14,
				["rank"] = {
					0.1, 0.2, 0.3,
				},
			},
		},
		-- Hunter: Careful Aim (Rank 3) - 2,4
		--         Increases your ranged attack power by an amount equal to 33%/66%/100% of your total Intellect.
		["ADD_RANGED_AP_MOD_INT"] = {
			{
				["tab"] = 2,
				["num"] = 4,
				["rank"] = {
					0.33, 0.66, 1,
				},
			},
		},
		-- Hunter: Catlike Reflexes (Rank 3) - 1,19
		--         Increases your chance to dodge by 1%/2%/3% and your pet's chance to dodge by an additional 3%/6%/9%.
		-- Hunter: Aspect of the Monkey - Buff
		--         The hunter takes on the aspects of a monkey, increasing chance to dodge by 18%. Only one Aspect can be active at a time.
		-- Hunter: Improved Aspect of the Monkey (Rank 3) - 1,4
		--         Increases the Dodge bonus of your Aspect of the Monkey and Aspect of the Dragonhawk by 2%/4%/6%.
		-- Hunter: Aspect of the Dragonhawk (Rank 2) - Buff
		--         The hunter takes on the aspects of a dragonhawk, increasing ranged attack power by 300 and chance to dodge by 18%. 
		["ADD_DODGE"] = {
			{
				["tab"] = 1,
				["num"] = 19,
				["rank"] = {
					1, 2, 3,
				},
			},
			{
				["rank"] = {
					18,
				},
				["buff"] = 13163,		-- ["Aspect of the Monkey"],
			},
			{
				["tab"] = 1,
				["num"] = 4,
				["rank"] = {
					2, 4, 6,
				},
				["buff"] = 13163,		-- ["Aspect of the Monkey"],
			},
			{
				["rank"] = {
					18, 18,
				},
				["buff"] = 61846,		-- ["Aspect of the Dragonhawk"],
			},
			{
				["tab"] = 1,
				["num"] = 4,
				["rank"] = {
					2, 4, 6,
				},
				["buff"] = 61846,		-- ["Aspect of the Dragonhawk"],
			},
		},
		-- Hunter: Survival Instincts (Rank 2) - 3,7
		--         Reduces all damage taken by 2%/4% and increases the critical strike chance of your Arcane Shot, Steady Shot, and Explosive Shot by 2%/4%.
		-- Hunter: Aspect Mastery - 1,8
		--         Aspect of the Monkey - Reduces the damage done to you while active by 5%.
		["MOD_DMG_TAKEN"] = {
			{
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["tab"] = 3,
				["num"] = 7,
				["rank"] = {
					-0.02, -0.04,
				},
			},
			{
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["tab"] = 1,
				["num"] = 8,
				["rank"] = {
					-0.05,
				},
				["buff"] = 13163,		-- ["Aspect of the Monkey"],
			},
		},
		-- Hunter: Thick Hide (Rank 3) - 1,5
		--         Increases the armor rating of your pets by 20% and your armor contribution from items by 4%/7%/10%.
		["MOD_ARMOR"] = {
			{
				["tab"] = 1,
				["num"] = 5,
				["rank"] = {
					0.04, 0.07, 0.1,
				},
			},
		},
		-- Hunter: Endurance Training (Rank 5) - 1,2
		--         Increases the Health of your pet by 2%/4%/6%/8%/10% and your total health by 1%/2%/3%/4%/5%.
		["MOD_HEALTH"] = {
			{
				["tab"] = 1,
				["num"] = 2,
				["rank"] = {
					0.01, 0.02, 0.03, 0.04, 0.05,
				},
			},
		},
		-- Hunter: Survivalist (Rank 5) - 3,8
		--         Increases your Stamina by 2%/4%/6%/8%/10%.
		["MOD_STA"] = {
			{
				["tab"] = 3,
				["num"] = 8,
				["rank"] = {
					0.02, 0.04, 0.06, 0.08, 0.1,
				},
			},
		},
		-- Hunter: Hunting Party (Rank 3) - 3,27
		--         Increases your total Agility by an additional 1/2/3%
		-- Hunter: Combat Experience (Rank 2) - 2,16
		--         Increases your total Agility and Intellect by 2%/4%.
		-- Hunter: Lightning Reflexes (Rank 5) - 3,17
		--         Increases your Agility by 3%/6%/9%/12%/15%.
		["MOD_AGI"] = {
			{
				["tab"] = 3,
				["num"] = 27,
				["rank"] = {
					0.01, 0.02, 0.03,
				},
			},
			{
				["tab"] = 2,
				["num"] = 16,
				["rank"] = {
					0.02, 0.04,
				},
			},
			{
				["tab"] = 3,
				["num"] = 17,
				["rank"] = {
					0.03, 0.06, 0.09, 0.12, 0.15,
				},
			},
		},
		-- Hunter: Combat Experience (Rank 2) - 2,16
		--         Increases your total Agility and Intellect by 2%/4%.
		["MOD_INT"] = {
			{
				["tab"] = 2,
				["num"] = 16,
				["rank"] = {
					0.02, 0.04,
				},
			},
		},
	}
elseif playerClass == "MAGE" then
	StatModTable["MAGE"] = {
		-- Mage: Molten Armor (Rank 3) - Buff
		--       increases your critical strike rating by 35% of your spirit
		-- Mage: Glyph of Molten Armor - Major Glyph
		--       Your Molten Armor grants an additional 20% of your spirit as critical strike rating.
		-- Mage: Khadgar's Regalia(843), Sunstrider's Regalia(844) 2pc - Item Set
		--       Increases the armor you gain from Ice Armor by 20%, the mana regeneration you gain from Mage Armor by 10%, 
		--       and converts an additional 15% of your spirit into critical strike rating when Molten Armor is active.
		["ADD_SPELL_CRIT_RATING_MOD_SPI"] = {
			{
				["rank"] = {
					0.35, 0.35, 0.35, 0.35, 0.35, 0.35, -- 3 ranks
				},
				["buff"] = 30482, -- ["Molten Armor"],
			},
			{
				["rank"] = {
					0.2, 0.2, 0.2, 0.2, 0.2, 0.2, -- 3 ranks
				},
				["buff"] = 30482, -- ["Molten Armor"],
				["glyph"] = 56382, -- Glyph of Molten Armor,
			},
			{
				["rank"] = {
					0.15, 0.15, 0.15, 0.15, 0.15, 0.15, -- 3 ranks
				},
				["buff"] = 30482, -- ["Molten Armor"],
				["itemset"] = {843, 2}, -- Khadgar's Regalia,
			},
			{
				["rank"] = {
					0.15, 0.15, 0.15, 0.15, 0.15, 0.15, -- 3 ranks
				},
				["buff"] = 30482, -- ["Molten Armor"],
				["itemset"] = {844, 2}, -- Sunstrider's Regalia,
			},
		},
		-- Mage: Arcane Fortitude - 1,4
		--       Increases your armor by an amount equal to 50%/100%/150% of your Intellect.
		["ADD_ARMOR_MOD_INT"] = {
			{
				["tab"] = 1,
				["num"] = 4,
				["rank"] = {
					0.5, 1, 1.5,
				},
			},
		},
		-- Mage: Arcane Meditation (Rank 3) - 1,13
		--       Allows 17/33/50% of your Mana regeneration to continue while casting.
		-- Mage: Mage Armor (Rank 6) - Buff
		--       Resistance to all magic schools increased by 40 and allows 50% of your mana regeneration to continue while casting.
		-- Mage: Khadgar's Regalia(843), Sunstrider's Regalia(844) 2pc - Item Set
		--       Increases the armor you gain from Ice Armor by 20%, the mana regeneration you gain from Mage Armor by 10%, 
		--       and converts an additional 15% of your spirit into critical strike rating when Molten Armor is active.
		-- Mage: Glyph of Mage Armor - Major Glyph
		--       Your Mage Armor spell grants an additional 20% mana regeneration while casting.
		-- Mage: Pyromaniac (Rank 3) - 2,19
		--       Increases chance to critically hit by 1%/2%/3% and allows 17/33/50% of your mana regeneration to continue while casting.
		["ADD_MANA_REG_MOD_NORMAL_MANA_REG"] = {
			{
				["tab"] = 1,
				["num"] = 13,
				["rank"] = {
					0.17, 0.33, 0.5,
				},
			},
			{
				["rank"] = {
					0.5, 0.5, 0.5, 0.5, 0.5, 0.5, -- 6 ranks
				},
				["buff"] = 6117, -- ["Mage Armor"],
			},
			{
				["rank"] = {
					0.1, 0.1, 0.1, 0.1, 0.1, 0.1, -- 3 ranks
				},
				["buff"] = 6117, -- ["Mage Armor"],
				["itemset"] = {843, 2}, -- Khadgar's Regalia,
			},
			{
				["rank"] = {
					0.1, 0.1, 0.1, 0.1, 0.1, 0.1, -- 3 ranks
				},
				["buff"] = 6117, -- ["Mage Armor"],
				["itemset"] = {844, 2}, -- Sunstrider's Regalia,
			},
			{
				["rank"] = {
					0.2, 0.2, 0.2, 0.2, 0.2, 0.2, -- 6 ranks
				},
				["buff"] = 6117, -- ["Mage Armor"],
				["glyph"] = 56383, -- Glyph of Mage Armor,
			},
			{
				["tab"] = 2,
				["num"] = 19,
				["rank"] = {
					0.17, 0.33, 0.5,
				},
			},
		},
		-- Mage: Mind Mastery (Rank 5) - 1,25
		--       Increases spell damage by up to 3%/6%/9%/12%/15% of your total Intellect.
		["ADD_SPELL_DMG_MOD_INT"] = {
			{
				["tab"] = 1,
				["num"] = 25,
				["rank"] = {
					0.03, 0.06, 0.09, 0.12, 0.15,
				},
			},
		},
		["ADD_HEALING_MOD_INT"] = {
			{
				["tab"] = 1,
				["num"] = 25,
				["rank"] = {
					0.03, 0.06, 0.09, 0.12, 0.15,
				},
			},
		},
		-- Mage: Arctic Winds (Rank 5) - 3,20
		--       Reduces the chance melee and ranged attacks will hit you by 1%/2%/3%/4%/5%.
		-- 3.0.1: 3,21
		-- Mage: Improved Blink (Rank 2) - Buff - 1,13
		--       Chance to be hit by all attacks and spells reduced by 13%/25%.
		-- 3.0.1: 1,15: Chance to be hit by all attacks and spells reduced by 15%/30%.
		["ADD_HIT_TAKEN"] = {
			{
				["MELEE"] = true,
				["RANGED"] = true,
				["tab"] = 3,
				["num"] = 21,
				["rank"] = {
					-0.01, -0.02, -0.03, -0.04, -0.05,
				},
			},
			{
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["tab"] = 1,
				["num"] = 15,
				["rank"] = {
					-0.15, -0.30,
				},
				["buff"] = 46989,		-- ["Improved Blink"],
			},
		},
		-- Mage: Prismatic Cloak (Rank 3) - 1,16
		--       Reduces all damage taken by 2%/4%.
		-- 3.0.1: 1,18: Reduces all damage taken by 2%/4%/6%.
		-- Mage: Playing with Fire (Rank 3) - 2,13
		--       Increases all spell damage caused by 1%/2%/3%(doesn't effect char tab stat) and all spell damage taken by 1%/2%/3%.
		-- 3.0.1: 2,14
		-- Mage: Frozen Core (Rank 3) - 3,14
		--       Reduces the damage taken by Frost and Fire effects by 2%/4%/6%.
		-- 3.0.1: 3,16
		-- 8962: Reduces the damage taken from all spells by 2%/4%/6%.
		["MOD_DMG_TAKEN"] = {
			{
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["tab"] = 1,
				["num"] = 18,
				["rank"] = {
					-0.02, -0.04, -0.06,
				},
			},
			{
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["tab"] = 2,
				["num"] = 14,
				["rank"] = {
					-0.01, -0.02, -0.03,
				},
			},
			{
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["tab"] = 3,
				["num"] = 16,
				["rank"] = {
					-0.02, -0.04, -0.06,
				},
			},
		},
		-- Mage: Arcane Instability (Rank 3) - 1,19
		--       Increases your spell damage and critical strike chance by 1%/2%/3%.
		-- This does not increase spell power
		-- ["MOD_SPELL_DMG"] = {
			-- {
				-- ["tab"] = 1,
				-- ["num"] = 19,
				-- ["rank"] = {
					-- 0.01, 0.02, 0.03,
				-- },
			-- },
		-- },
		-- Mage: Arcane Mind (Rank 5) - 1,15
		--       Increases your total Intellect by 3%/6%/9%/12%/15%.
		-- 3.0.1: 1,17
		["MOD_INT"] = {
			{
				["tab"] = 1,
				["num"] = 17,
				["rank"] = {
					0.03, 0.06, 0.09, 0.12, 0.15,
				},
			},
		},
		-- Mage: Student of the Mind (Rank 3) - 1,9
		--       Increases your total Spirit by 4%/7%/10%.
		["MOD_SPI"] = {
			{
				["tab"] = 1,
				["num"] = 9,
				["rank"] = {
					0.04, 0.07, 0.1,
				},
			},
		},
	}
elseif playerClass == "PALADIN" then
	StatModTable["PALADIN"] = {
		-- Paladin: Sheath of Light (Rank 3) - 3,24
		--          Increases your spell power by an amount equal to 10%/20%/30% of your attack power
		--   3.1.0: 3,24
		["ADD_SPELL_DMG_MOD_AP"] = {
			{
				["tab"] = 3,
				["num"] = 24,
				["rank"] = {
					0.1, 0.2, 0.3,
				},
			},
		},
		["ADD_HEALING_MOD_AP"] = {
			{
				["tab"] = 3,
				["num"] = 24,
				["rank"] = {
					0.1, 0.2, 0.3,
				},
			},
		},
		-- Paladin: Touched by the Light (Rank 3) - 2,21
		--          Increases your spell power by an amount equal to 20/40/60% of your Strength
		["ADD_SPELL_DMG_MOD_STR"] = {
			{
				["tab"] = 2,
				["num"] = 21,
				["rank"] = {
					0.2, 0.4, 0.6,
				},
				["new"] = 10371,
			},
		},
		["ADD_HEALING_MOD_STR"] = {
			{
				["tab"] = 2,
				["num"] = 20,
				["rank"] = {
					0.2, 0.4, 0.6,
				},
				["new"] = 10371,
			},
		},
		["ADD_SPELL_DMG_MOD_STA"] = {
			{
				["tab"] = 2,
				["num"] = 21,
				["rank"] = {
					0.1, 0.2, 0.3,
				},
				["old"] = 10371,
			},
		},
		["ADD_HEALING_MOD_STA"] = {
			{
				["tab"] = 2,
				["num"] = 20,
				["rank"] = {
					0.1, 0.2, 0.3,
				},
				["old"] = 10371,
			},
		},
		-- Paladin: Holy Guidance (Rank 5) - 1,21
		--          Increases your spell power by 4%/8%/12%/16%/20% of your total Intellect.
		["ADD_SPELL_DMG_MOD_INT"] = {
			{
				["tab"] = 1,
				["num"] = 21,
				["rank"] = {
					0.04, 0.08, 0.12, 0.16, 0.2,
				},
			},
		},
		-- Paladin: Holy Guidance (Rank 5) - 1,21
		--          Increases your spell damage and healing by 7%/14%/21%/28%/35% of your total Intellect.
		["ADD_HEALING_MOD_INT"] = {
			{
				["tab"] = 1,
				["num"] = 21,
				["rank"] = {
					0.04, 0.08, 0.12, 0.16, 0.2,
				},
			},
		},
		-- Paladin: Anticipation (Rank 5) - 2,5
		--          Increases your chance to dodge by 1%/2%/3%/4%/5%.
		["ADD_DODGE"] = {
			{
				["tab"] = 2,
				["num"] = 5,
				["rank"] = {
					1, 2, 3, 4, 5,
				},
			},
		},
		-- Paladin: Divine Purpose (Rank 2) - 3,16
		--          Reduces your chance to be hit by spells and ranged attacks by 2%/4% and 
		--          gives your Hand of Freedom spell a 50%/100% chance to remove any Stun effects on the target.
		["ADD_HIT_TAKEN"] = {
			{
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["tab"] = 3,
				["num"] = 16,
				["rank"] = {
					-0.02, -0.04,
				},
			},
		},
		-- Paladin: Blessed Life (Rank 3) - 1,19
		--          All attacks against you have a 4%/7%/10% chance to cause half damage.
		-- Paladin: Ardent Defender (Rank 3) - 2,18
		--          When you have less than 35% health, all damage taken is reduced by 7/13/20%.
		-- Paladin: Improved Righteous Fury (Rank 3) - 2,7
		--          While Righteous Fury is active, all damage taken is reduced by 2%/4%/6%.
		-- Paladin: Guarded by the Light (Rank 2) - 2,23
		--          Reduces spell damage taken by 3%/6% and reduces the mana cost of your Holy Shield, Avenger's Shield and Shield of Righteousness spells by 15%/30%.
		-- Paladin: Shield of the Templar (Rank 3) - 2,24
		--          Reduces all damage taken by 1/2/3%
		-- Paladin: Glyph of Divine Plea - Major Glyph
		--          While Divine Plea is active, you take 3% reduced damage from all sources.
		["MOD_DMG_TAKEN"] = {
			{
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["tab"] = 1,
				["num"] = 19,
				["rank"] = {
					-0.02, -0.035, -0.05,
				},
			},
			{-- Ardent Defender
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["tab"] = 2,
				["num"] = 18,
				["rank"] = {
					-0.1, -0.2, -0.3,
				},
				["condition"] = "((UnitHealth('player') / UnitHealthMax('player')) < 0.35)",
				["old"] = 10371,
			},
			{-- Ardent Defender
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["tab"] = 2,
				["num"] = 18,
				["rank"] = {
					-0.07, -0.13, -0.2,
				},
				["condition"] = "((UnitHealth('player') / UnitHealthMax('player')) < 0.35)",
				["new"] = 10371,
			},
			{-- Improved Righteous Fury
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["tab"] = 2,
				["num"] = 7,
				["rank"] = {
					-0.02, -0.04, -0.06,
				},
				["buff"] = 25781,		-- ["Righteous Fury"],
			},
			{-- Guarded by the Light
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["tab"] = 2,
				["num"] = 23,
				["rank"] = {
					-0.03, -0.06,
				},
			},
			{-- Shield of the Templar
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["tab"] = 2,
				["num"] = 24,
				["rank"] = {
					-0.01, -0.02, -0.03,
				},
			},
			{-- Glyph of Divine Plea
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["rank"] = {
					-0.03,
				},
				["buff"] = 54428,		-- ["Divine Plea"],
				["glyph"] = 63223, -- Glyph of Shield Wall,
			},
		},
		-- Paladin: Toughness (Rank 5) - 2,8
		--          Increases your armor value from items by 2%/4%/6%/8%/10%.
		["MOD_ARMOR"] = {
			{
				["tab"] = 2,
				["num"] = 8,
				["rank"] = {
					0.02, 0.04, 0.06, 0.08, 0.1,
				},
			},
		},
		-- Paladin: Divine Strength (Rank 5) - 2,2
		--          Increases your total Strength by 3%/6%/9%/12%/15%.
		["MOD_STR"] = {
			{
				["tab"] = 2,
				["num"] = 2,
				["rank"] = {
					0.03, 0.06, 0.09, 0.12, 0.15,
				},
			},
		},
		-- Paladin: Sacred Duty (Rank 2) - 2,14
		--          Increases your total Stamina by 4%/8%
		--          Sacred Duty now provides 2 / 4% Stamina, down from 4 / 8% Stamina.
		-- Paladin: Combat Expertise (Rank 3) - 2,20
		--          Increases your expertise by 2/4/6, total Stamina and chance to critically hit by 2%/4%/6%.
		["MOD_STA"] = {
			{
				["tab"] = 2,
				["num"] = 14,
				["rank"] = {
					0.02, 0.04,
				},
			},
			{
				["tab"] = 2,
				["num"] = 20,
				["rank"] = {
					0.02, 0.04, 0.06,
				},
			},
		},
		-- Paladin: Divine Intellect (Rank 5) - 1,4
		--          Increases your total Intellect by 2/4/6/8/10%.
		["MOD_INT"] = {
			{
				["tab"] = 1,
				["num"] = 4,
				["rank"] = {
					0.03, 0.06, 0.09, 0.12, 0.15,
				},
				["old"] = 10147,
			},
			{
				["tab"] = 1,
				["num"] = 4,
				["rank"] = {
					0.02, 0.04, 0.06, 0.08, 0.1,
				},
				["new"] = 10147,
			},
		},
		-- Paladin: Redoubt (Rank 3) - 2,19
		--          Increases your block value by 10%/20%/30% and 
		--          damaging melee and ranged attacks against you have a 10% chance to increase your chance to block by 30%.  Lasts 10 sec or 5 blocks.
		["MOD_BLOCK_VALUE"] = {
			{
				["tab"] = 2,
				["num"] = 19,
				["rank"] = {
					0.1, 0.2, 0.3,
				},
			},
		},
	}
elseif playerClass == "PRIEST" then
	StatModTable["PRIEST"] = {
		-- Priest: Focused Power (Rank 2) - 1,16
		--         Increases your total spell damage and healing done by 2%/4%.
		-- ["MOD_SPELL_DMG"] = {
			-- {
				-- ["tab"] = 1,
				-- ["num"] = 16,
				-- ["rank"] = {
					-- 0.02, 0.04,
				-- },
			-- },
		-- },
		-- Priest: Focused Power (Rank 2) - 1,16
		--         Increases your total spell damage and healing done by 2%/4%.
		-- ["MOD_HEALING"] = {
			-- {
				-- ["tab"] = 1,
				-- ["num"] = 16,
				-- ["rank"] = {
					-- 0.02, 0.04,
				-- },
			-- },
		-- },
		-- Priest: Meditation (Rank 3) - 1,7
		--         Allows 17/33/50% of your Mana regeneration to continue while casting.
		["ADD_MANA_REG_MOD_NORMAL_MANA_REG"] = {
			{
				["tab"] = 1,
				["num"] = 7,
				["rank"] = {
					0.17, 0.33, 0.5,
				},
			},
		},
		-- Priest: Spiritual Guidance (Rank 5) - 2,14
		--         Increases spell power by up to 5%/10%/15%/20%/25% of your total Spirit.
		-- Priest: Twisted Faith (Rank 5) - 3,26
		--         Increases your spell power by 4/8/12/16/20% of your total Spirit
		["ADD_SPELL_DMG_MOD_SPI"] = {
			{
				["tab"] = 2,
				["num"] = 14,
				["rank"] = {
					0.05, 0.1, 0.15, 0.2, 0.25,
				},
			},
			{
				["tab"] = 3,
				["num"] = 26,
				["rank"] = {
					0.02, 0.04, 0.06, 0.08, 0.1,
				},
				["old"] = 10371,
			},
			{
				["tab"] = 3,
				["num"] = 26,
				["rank"] = {
					0.04, 0.08, 0.12, 0.16, 0.2,
				},
				["new"] = 10371,
			},
		},
		-- Priest: Spiritual Guidance (Rank 5) - 2,14
		--         Increases spell power by up to 5%/10%/15%/20%/25% of your total Spirit.
		-- Priest: Twisted Faith (Rank 5) - 3,26
		--         Increases your spell power by 4/8/12/16/20% of your total Spirit
		["ADD_HEALING_MOD_SPI"] = {
			{
				["tab"] = 2,
				["num"] = 14,
				["rank"] = {
					0.05, 0.1, 0.15, 0.2, 0.25,
				},
			},
			{
				["tab"] = 3,
				["num"] = 26,
				["rank"] = {
					0.02, 0.04, 0.06, 0.08, 0.1,
				},
				["old"] = 10371,
			},
			{
				["tab"] = 3,
				["num"] = 26,
				["rank"] = {
					0.04, 0.08, 0.12, 0.16, 0.2,
				},
				["new"] = 10371,
			},
		},
		-- Priest: Spell Warding (Rank 5) - 2,4
		--         Reduces all spell damage taken by 2%/4%/6%/8%/10%.
		-- Priest: Dispersion - Buff
		--         Reduces all damage by 90%
		["MOD_DMG_TAKEN"] = {
			{
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["tab"] = 2,
				["num"] = 4,
				["rank"] = {
					-0.02, -0.04, -0.06, -0.08, -0.1,
				},
			},
			{
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["rank"] = {
					-0.9,
				},
				["buff"] = 47585,		-- ["Dispersion"],
			},
		},
		-- Priest: Enlightenment (Rank 5) - 1,17
		--         Increases your total Stamina and Spirit by 1%/2%/3%/4%/5% and increases your spell haste by 1%/2%/3%/4%/5%.
		-- Priest: Improved Power Word: Fortitude (Rank 2) - 1,5
		--         Increases your total Stamina by 2/4%.
		["MOD_STA"] = {
			{
				["tab"] = 1,
				["num"] = 17,
				["rank"] = {
					0.01, 0.02, 0.03, 0.04, 0.05,
				},
			},
			{
				["tab"] = 1,
				["num"] = 5,
				["rank"] = {
					0.02, 0.04,
				},
			},
		},
		-- Priest: Mental Strength (Rank 5) - 1,14
		--         Increases your total Intellect by 3%/6%/9%/12%/15%.
		["MOD_INT"] = {
			{
				["tab"] = 1,
				["num"] = 14,
				["rank"] = {
					0.03, 0.06, 0.09, 0.12, 0.15,
				},
			},
		},
		-- Priest: Enlightenment (Rank 5) - 1,17
		--         Increases your total Stamina and Spirit by 1%/2%/3%/4%/5% and increases your spell haste by 1%/2%/3%/4%/5%.
		-- Priest: Spirit of Redemption - 2,13
		--         Increases total Spirit by 5% and upon death, the priest becomes the Spirit of Redemption for 15 sec.
		["MOD_SPI"] = {
			{
				["tab"] = 1,
				["num"] = 17,
				["rank"] = {
					0.01, 0.02, 0.03, 0.04, 0.05,
				},
			},
			{
				["tab"] = 2,
				["num"] = 13,
				["rank"] = {
					0.05,
				},
			},
		},
	}
elseif playerClass == "ROGUE" then
	StatModTable["ROGUE"] = {
		-- Rogue: Deadliness (Rank 5) - 3,18
		--        Increases your attack power by 2%/4%/6%/8%/10%.
		-- Rogue: Savage Combat (Rank 2) - 2,26
		--        Increases your total attack power by 2%/4%.
		["MOD_AP"] = {
			{
				["tab"] = 3,
				["num"] = 18,
				["rank"] = {
					0.02, 0.04, 0.06, 0.08, 0.1,
				},
			},
			{
				["tab"] = 2,
				["num"] = 26,
				["rank"] = {
					0.02, 0.04,
				},
			},
		},
		-- Rogue: Lightning Reflexes (Rank 5) - 2,12
		--        Increases your Dodge chance by 2/4/6% and gives you 4/7/10% melee haste.
		-- Rogue: Evasion (Rank 1/2) - Buff
		--        Dodge chance increased by 50%/50% and chance ranged attacks hit you reduced by 0%/25%.
		-- Rogue: Ghostly Strike - Buff
		--        Dodge chance increased by 15%.
		["ADD_DODGE"] = {
			{
				["tab"] = 2,
				["num"] = 12,
				["rank"] = {
					2, 4, 6,
				},
			},
			{
				["rank"] = {
					50, 50,
				},
				["buff"] = 26669,		-- ["Evasion"],
			},
			{
				["rank"] = {
					15,
				},
				["buff"] = 31022,		-- ["Ghostly Strike"],
			},
		},
		-- Rogue: Sleight of Hand (Rank 2) - 3,4
		--        Reduces the chance you are critically hit by melee and ranged attacks by 1%/2% and increases the threat reduction of your Feint ability by 10%/20%.
		["ADD_CRIT_TAKEN"] = {
			{
				["MELEE"] = true,
				["RANGED"] = true,
				["tab"] = 3,
				["num"] = 4,
				["rank"] = {
					-0.01, -0.02,
				},
			},
		},
		-- Rogue: Heightened Senses (Rank 2) - 3,13
		--        Increases your Stealth detection and reduces the chance you are hit by spells and ranged attacks by 2%/4%.
		-- Rogue: Cloak of Shadows - buff
		--        Instantly removes all existing harmful spell effects and increases your chance to resist all spells by 90% for 5 sec. Does not remove effects that prevent you from using Cloak of Shadows.
		-- Rogue: Evasion (Rank 1/2) - Buff
		--        Dodge chance increased by 50%/50% and chance ranged attacks hit you reduced by 0%/25%.
		["ADD_HIT_TAKEN"] = {
			{
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["tab"] = 3,
				["num"] = 13,
				["rank"] = {
					-0.02, -0.04,
				},
			},
			{
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["rank"] = {
					-0.9,
				},
				["buff"] = 39666,		-- ["Cloak of Shadows"],
			},
			{
				["RANGED"] = true,
				["rank"] = {
					0, -0.25,
				},
				["buff"] = 26669,		-- ["Evasion"],
			},
		},
		-- Rogue: Deadened Nerves (Rank 3) - 1,20
		--        Reduces all damage taken by 2%/4%/6%.
		["MOD_DMG_TAKEN"] = {
			{
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["tab"] = 1,
				["num"] = 20,
				["rank"] = {
					-0.02, -0.04, -0.06,
				},
			},
		},
		-- Rogue: Sinister Calling (Rank 5) - 3,22
		--        Increases your total Agility by 3%/6%/9%/12%/15%.
		["MOD_AGI"] = {
			{
				["tab"] = 3,
				["num"] = 22,
				["rank"] = {
					0.03, 0.06, 0.09, 0.12, 0.15,
				},
			},
		},
		-- Rogue: Endurance (Rank 2) - 2,7
		--        increases your total Stamina by 2%/4%.
		["MOD_STA"] = {
			{
				["tab"] = 2,
				["num"] = 7,
				["rank"] = {
					0.02, 0.04,
				},
			},
		},
	}
elseif playerClass == "SHAMAN" then
	StatModTable["SHAMAN"] = {
		-- Shaman: Mental Dexterity (Rank 3) - 2,15
		--         Increases your Attack Power by 33%/66%/100% of your Intellect.
		["ADD_AP_MOD_INT"] = {
			{
				["tab"] = 2,
				["num"] = 15,
				["rank"] = {
					0.33, 0.66, 1,
				},
			},
		},
		-- Shaman: Mental Quickness (Rank 3) - 2,25
		--         Reduces the mana cost of your instant cast spells by 2%/4%/6% and increases your spell power equal to 10%/20%/30% of your attack power.
		--  3.1.0: 2,25
		["ADD_SPELL_DMG_MOD_AP"] = {
			{
				["tab"] = 2,
				["num"] = 25,
				["rank"] = {
					0.1, 0.2, 0.3,
				},
			},
		},
		-- Shaman: Mental Quickness (Rank 3) - 2,25
		--         Reduces the mana cost of your instant cast spells by 2%/4%/6% and increases your spell power equal to 10%/20%/30% of your attack power.
		--  3.1.0: 2,25
		["ADD_HEALING_MOD_AP"] = {
			{
				["tab"] = 2,
				["num"] = 25,
				["rank"] = {
					0.1, 0.2, 0.3,
				},
			},
		},
		-- Shaman: Unrelenting Storm (Rank 3) - 1,13
		--         Regenerate mana equal to 4%/8%/12% of your Intellect every 5 sec, even while casting.
		["ADD_MANA_REG_MOD_INT"] = {
			{
				["tab"] = 1,
				["num"] = 13,
				["rank"] = {
					0.04, 0.08, 0.12,
				},
			},
		},
		-- Shaman: Nature's Blessing (Rank 3) - 3,21
		--         Increases your healing by an amount equal to 5%/10%/15% of your Intellect.
		["ADD_HEALING_MOD_INT"] = {
			{
				["tab"] = 3,
				["num"] = 21,
				["rank"] = {
					0.05, 0.1, 0.15,
				},
			},
		},
		-- Shaman: Anticipation (Rank 5) - 2,10
		--         Increases your chance to dodge by an additional 1%/2%/3%
		["ADD_DODGE"] = {
			{
				["tab"] = 2,
				["num"] = 10,
				["rank"] = {
					1, 2, 3,
				},
			},
		},
		-- Shaman: Elemental Warding (Rank 3) - 1,4
		--         Now reduces all damage taken by 2/4/6%.
		-- Shaman: Shamanistic Rage - Buff
		--         Reduces all damage taken by 30% and gives your successful melee attacks a chance to regenerate mana equal to 15% of your attack power. Lasts 30 sec.
		-- Shaman: Astral Shift - Buff
		--         When stunned, feared or silenced you shift into the Astral Plane reducing all damage taken by 30% for the duration of the stun, fear or silence effect.
		["MOD_DMG_TAKEN"] = {
			{
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["tab"] = 1,
				["num"] = 4,
				["rank"] = {
					-0.02, -0.04, -0.06,
				},
			},
			{
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["rank"] = {
					-0.3,
				},
				["buff"] = 30823,		-- ["Shamanistic Rage"],
			},
			{
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["rank"] = {
					-0.3,
				},
				["buff"] = 51479,		-- ["Astral Shift"],
			},
		},
		-- Shaman: Toughness (Rank 5) - 2,12
		--         Increases your total stamina by 2/4/6/8/10%. 
		["MOD_STA"] = {
			{
				["tab"] = 2,
				["num"] = 12,
				["rank"] = {
					0.02, 0.04, 0.06, 0.08, 0.1,
				},
			},
		},
		-- Shaman: Ancestral Knowledge (Rank 5) - 2,3
		--         Increases your intellect by 2%/4%/6%/8%/10%.
		["MOD_INT"] = {
			{
				["tab"] = 2,
				["num"] = 3,
				["rank"] = {
					0.02, 0.04, 0.06, 0.08, 0.1,
				},
			},
		},
	}
elseif playerClass == "WARLOCK" then
	StatModTable["WARLOCK"] = {
		-- Warlock: Metamorphosis - Buff
		--          This form increases your armor by 600%, damage by 20%, reduces the chance you'll be critically hit by melee attacks by 6% and reduces the duration of stun and snare effects by 50%.
		["ADD_CRIT_TAKEN"] = {
			{
				["MELEE"] = true,
				["rank"] = {
					-0.06,
				},
				["buff"] = 47241,		-- ["Metamorphosis"],
			},
		},
		-- Warlock: Metamorphosis - Buff
		--          This form increases your armor by 600%, damage by 20%, reduces the chance you'll be critically hit by melee attacks by 6% and reduces the duration of stun and snare effects by 50%.
		["MOD_ARMOR"] = {
			{
				["rank"] = {
					6,
				},
				["buff"] = 47241,		-- ["Metamorphosis"],
			},
		},
		-- Warlock: Demonic Pact - 2,26
		--          Your pet's criticals apply the Demonic Pact effect to your party or raid members. Demonic Pact increases spell power by 2%/4%/6%/8%/10% of your Spell Damage for 12 sec.
		-- Warlock: Malediction (Rank 3) - 1,23
		--          Increases the damage bonus effect of your Curse of the Elements spell by an additional 3%, and increases your spell damage by 1%/2%/3%.
		--        * Does not affect char window stats
		["MOD_SPELL_DMG"] = {
			{
				["tab"] = 2,
				["num"] = 26,
				["rank"] = {
					0.02, 0.04, 0.06, 0.08, 0.1,
				},
				["buff"] = 47240,		-- ["Demonic Pact"],
			},
		},
		-- Warlock: Demonic Pact - 2,26
		--          Your pet's criticals apply the Demonic Pact effect to your party or raid members. Demonic Pact increases spell power by 2%/4%/6%/8%/10% of your Spell Damage for 12 sec.
		["MOD_HEALING"] = {
			{
				["tab"] = 2,
				["num"] = 26,
				["rank"] = {
					0.02, 0.04, 0.06, 0.08, 0.1,
				},
				["buff"] = 47240,		-- ["Demonic Pact"],
			},
		},
		-- Warlock: Fel Armor (Rank 4) - Buff
		--          Surrounds the caster with fel energy, increasing spell power by 50/100/150/180 plus additional spell power equal to 30% of your Spirit.
		-- Warlock: Demonic Aegis (Rank 3) - 2,11
		--          Increases the effectiveness of your Demon Armor and Fel Armor spells by 10%/20%/30%.
		-- Warlock: Glyph of Life Tap - Major Glyph
		--          When you use Life Tap, you gain 20% of your Spirit as spell power for 40 sec.
		--          Life Tap - Buff
		["ADD_SPELL_DMG_MOD_SPI"] = {
			{
				["rank"] = {
					0.3, 0.3, 0.3, 0.3, -- 4 ranks
				},
				["buff"] = 28176, -- ["Fel Armor"],
			},
			{
				["tab"] = 2,
				["num"] = 11,
				["rank"] = {
					0.03, 0.06, 0.09,
				},
				["buff"] = 28176, -- ["Fel Armor"],
			},
			{
				["rank"] = {
					0.2,
				},
				["buff"] = 63321, -- ["Life Tap"],
			},
		},
		-- Warlock: Fel Armor (Rank 4) - Buff
		--          Surrounds the caster with fel energy, increasing spell power by 50/100/150/180 plus additional spell power equal to 30% of your Spirit.
		-- Warlock: Demonic Aegis (Rank 3) - 2,11
		--          Increases the effectiveness of your Demon Armor and Fel Armor spells by 10%/20%/30%.
		--   3.1.0: 2,11
		["ADD_HEALING_MOD_SPI"] = {
			{
				["rank"] = {
					0.3, 0.3, 0.3, 0.3, -- 4 ranks
				},
				["buff"] = 28176,		-- ["Fel Armor"],
			},
			{
				["tab"] = 2,
				["num"] = 11,
				["rank"] = {
					0.03, 0.06, 0.09,
				},
				["buff"] = 28176,		-- ["Fel Armor"],
			},
			{
				["rank"] = {
					0.2,
				},
				["buff"] = 63321, -- ["Life Tap"],
			},
		},
		-- 3.3.0 Imp stam total 233: pet base 118, player base 90, pet sta from player sta 0.75, pet kings 1.1, fel vitality 1.15
		-- /dump floor((118+floor(90*0.75))*1.1)*1.05 = 233.45 match
		-- /dump (118+floor(90*0.75))*1.1*1.05 = 224.025 wrong
		-- Warlock: Fel Vitality (Rank 3) - 2,7
		--          Increases the Stamina and Intellect of your Imp, Voidwalker, Succubus, Felhunter and Felguard by 15% and increases your maximum health and mana by 1%/2%/3%.
		["ADD_PET_STA_MOD_STA"] = {
			{ -- Base
				["rank"] = {
					0.75-1,
				},
				["condition"] = "UnitExists('pet')",
			},
			{ -- Blessings on pet: floor() * 1.1
				["rank"] = {
					0.1,
				}, -- BoK, BoSanc
        ["oldtoc"] = 38000,
				["condition"] = "UnitBuff('pet', GetSpellInfo(20217)) or UnitBuff('pet', GetSpellInfo(25898)) or UnitBuff('pet', GetSpellInfo(20911)) or UnitBuff('pet', GetSpellInfo(25899))",
			},
			{ -- Fel Vitality: floor() * 1.15
				["tab"] = 2,
				["num"] = 7,
				["rank"] = {
					0.05, 0.1, 0.15,
				},
				["condition"] = "UnitExists('pet')",
			},
		},
		["ADD_PET_INT_MOD_INT"] = {
			{ -- Base
				["rank"] = {
					0.3-1,
				},
				["condition"] = "UnitExists('pet')",
			},
			{ -- Blessings on pet
				["rank"] = {
					0.1,
				},
        ["oldtoc"] = 38000,
				["condition"] = "UnitBuff('pet', GetSpellInfo(20217)) or UnitBuff('pet', GetSpellInfo(25898)) or UnitBuff('pet', GetSpellInfo(20911)) or UnitBuff('pet', GetSpellInfo(25899))",
			},
			{ -- Fel Vitality
				["tab"] = 2,
				["num"] = 7,
				["rank"] = {
					0.05, 0.1, 0.15,
				},
				["condition"] = "UnitExists('pet')",
			},
		},
		-- Warlock: Demonic Knowledge (Rank 3) - 2,20 - UnitExists("pet") - WARLOCK_PET_BONUS["PET_BONUS_STAM"] = 0.3; its actually 0.75
		--          Increases your spell damage by an amount equal to 4/8/12% of the total of your active demon's Stamina plus Intellect.
		["ADD_SPELL_DMG_MOD_PET_STA"] = {
			{
				["tab"] = 2,
				["num"] = 20,
				["rank"] = {
					0.04, 0.08, 0.12,
				},
				["condition"] = "UnitExists('pet')",
			},
		},
		-- Warlock: Demonic Knowledge (Rank 3) - 2,20 - UnitExists("pet") - WARLOCK_PET_BONUS["PET_BONUS_INT"] = 0.3;
		--          Increases your spell damage by an amount equal to 4/8/12% of the total of your active demon's Stamina plus Intellect.
		["ADD_SPELL_DMG_MOD_PET_INT"] = {
			{
				["tab"] = 2,
				["num"] = 20,
				["rank"] = {
					0.04, 0.08, 0.12,
				},
				["condition"] = "UnitExists('pet')",
			},
		},
		-- Warlock: Demonic Resilience (Rank 3) - 2,18
		--          Reduces the chance you'll be critically hit by melee and spells by 1%/2%/3% and reduces all damage your summoned demon takes by 15%.
		["ADD_CRIT_TAKEN"] = {
			{
				["MELEE"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["tab"] = 2,
				["num"] = 18,
				["rank"] = {
					-0.01, -0.02, -0.03,
				},
			},
		},
		-- Warlock: Master Demonologist (Rank 5) - 2,16
		--          Voidwalker - Reduces physical damage taken by 2%/4%/6%/8%/10%.
		--          Felhunter - Reduces all spell damage taken by 2%/4%/6%/8%/10%.
		--          Felguard - Increases all damage done by 5%, and reduces all damage taken by 1%/2%/3%/4%/5%.
		-- Warlock: Soul Link (Rank 1) - Buff
		--          When active, 15% of all damage taken by the caster is taken by your Imp, Voidwalker, Succubus, Felhunter, Felguard, or enslaved demon instead.  That damage cannot be prevented. Lasts as long as the demon is active and controlled.
		["MOD_DMG_TAKEN"] = {
			{ -- Voidwalker
				["MELEE"] = true,
				["RANGED"] = true,
				["tab"] = 2,
				["num"] = 16,
				["rank"] = {
					-0.02, -0.04, -0.06, -0.08, -0.1,
				},
				["condition"] = "IsUsableSpell('"..(GetSpellInfo(27490) or "").."')" -- ["Torment"]
			},
			{ -- Felhunter
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["tab"] = 2,
				["num"] = 16,
				["rank"] = {
					-0.02, -0.04, -0.06, -0.08, -0.1,
				},
				["condition"] = "IsUsableSpell('"..(GetSpellInfo(27496) or "").."')" -- ["Devour Magic"]
			},
			{ -- Felguard
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["tab"] = 2,
				["num"] = 16,
				["rank"] = {
					-0.01, -0.02, -0.03, -0.04, -0.05,
				},
				["condition"] = "IsUsableSpell('"..(GetSpellInfo(47993) or "").."')" -- ["Anguish"]
			},
			{
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["rank"] = {
					-0.15,
				},
				["buff"] = 25228,		-- ["Soul Link"],
			},
		},
		-- Warlock: Fel Vitality (Rank 3) - 2,7
		--          Increases the Stamina and Intellect of your Imp, Voidwalker, Succubus, Felhunter and Felguard by 5%/10%/15% and increases your maximum health and mana by 1%/2%/3%.
		["MOD_HEALTH"] = {
			{
				["tab"] = 2,
				["num"] = 7,
				["rank"] = {
					0.01, 0.02, 0.03,
				},
			},
		},
		-- Warlock: Fel Vitality (Rank 3) - 2,7
		--          Increases the Stamina and Intellect of your Imp, Voidwalker, Succubus, Felhunter and Felguard by 15% and increases your maximum health and mana by 1%/2%/3%.
		["MOD_MANA"] = {
			{
				["tab"] = 2,
				["num"] = 7,
				["rank"] = {
					0.01, 0.02, 0.03,
				},
			},
		},
		-- Warlock: Demonic Embrace (Rank 5) - 2,3
		--          Increases your total Stamina by 4/7/10%.
		["MOD_STA"] = {
			{
				["tab"] = 2,
				["num"] = 3,
				["rank"] = {
					0.04, 0.07, 0.1,
				},
			},
		},
	}
elseif playerClass == "WARRIOR" then
	StatModTable["WARRIOR"] = {
		-- Warrior: Improved Spell Reflection (Rank 2) - 3,10
		--          Reduces the chance you'll be hit by spells by 2%/4%
		["ADD_HIT_TAKEN"] = {
			{
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["tab"] = 3,
				["num"] = 10,
				["rank"] = {
					-0.02, -0.04,
				},
			},
		},
		-- Warrior: Armored to the Teeth (Rank 3) - 2,1
		--          Increases your attack power by 1/2/3 for every 108 armor value you have.
		["ADD_AP_MOD_ARMOR"] = {
			{
				["tab"] = 2,
				["num"] = 1,
				["rank"] = {
					1/180, 2/180, 3/180,
				},
				["old"] = 10147,
			},
			{
				["tab"] = 2,
				["num"] = 1,
				["rank"] = {
					1/108, 2/108, 3/108,
				},
				["new"] = 10147,
			},
		},
		-- Warrior: Anticipation (Rank 5) - 3,5
		--          Increases your Dodge chance by 1%/2%/3%/4%/5%.
		["ADD_DODGE"] = {
			{
				["tab"] = 3,
				["num"] = 5,
				["rank"] = {
					1, 2, 3, 4, 5,
				},
			},
		},
		-- Warrior: Shield Wall - Buff
		--          All damage taken reduced by 60%.
		-- Warrior: Glyph of Shield Wall - Major Glyph
		--          Reduces the cooldown on Shield Wall by 2 min, but Shield Wall now only reduces damage taken by 40%.
		-- Warrior: Defensive Stance - stance
		--          A defensive combat stance. Decreases damage taken by 10% and damage caused by 10%. Increases threat generated.
		-- Warrior: Berserker Stance - stance
		--          An aggressive stance. Critical hit chance is increased by 3% and all damage taken is increased by 5%.
		-- Warrior: Death Wish - Buff
		--          When activated, increases your physical damage by 20% and makes you immune to Fear effects, but increases all damage taken by 5%. Lasts 30 sec.
		-- Warrior: Recklessness - Buff
		--          The warrior will cause critical hits with most attacks and will be immune to Fear effects for the next 15 sec, but all damage taken is increased by 20%.
		-- Warrior: Improved Defensive Stance (Rank 2) - 3,17
		--          While in Defensive Stance all spell damage is reduced by 3%/6%.
		["MOD_DMG_TAKEN"] = {
			{
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["rank"] = {
					-0.6,
				},
				["buff"] = 41196,		-- ["Shield Wall"],
			},
			{
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["rank"] = {
					0.2,
				},
				["buff"] = 41196,		-- ["Shield Wall"],
				["glyph"] = 63329, -- Glyph of Shield Wall,
			},
			{
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["rank"] = {
					-0.1,
				},
				["stance"] = "Interface\\Icons\\Ability_Warrior_DefensiveStance",
			},
			{
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["rank"] = {
					0.05,
				},
				["stance"] = "Interface\\Icons\\Ability_Racial_Avatar",
			},
			{
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["rank"] = {
					0.05,
				},
				["buff"] = 12292,		-- ["Death Wish"],
			},
			{
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["rank"] = {
					0.2,
				},
				["buff"] = 13847,		-- ["Recklessness"],
			},
			{ -- Improved Defensive Stance
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["tab"] = 3,
				["num"] = 17,
				["rank"] = {
					-0.03, -0.06,
				},
			},
		},
		-- Warrior: Last Stand - Buff
		--          When activated, this ability temporarily grants you 30% of your maximum health for 20 sec.
		["MOD_HEALTH"] = {
			{
				["rank"] = {
					0.3,
				},
				["buff"] = 12975,		-- ["Last Stand"],
			},
		},
		-- Warrior: Toughness (Rank 5) - 3,9
		--          Increases your armor value from items by 2%/4%/6%/8%/10%.
		["MOD_ARMOR"] = {
			{
				["tab"] = 3,
				["num"] = 9,
				["rank"] = {
					0.02, 0.04, 0.06, 0.08, 0.1,
				},
			},
		},
		-- Warrior: Vitality (Rank 3) - 3,20
		--          Increases your total Strength and Stamina by 3/6/9% and your Expertise by 2/4/6.
		-- Warrior: Strength of Arms (Rank 2) - 1,22
		--          Increases your total Strength and Stamina by 2%/4% and your Expertise by 2/4.
		["MOD_STA"] = {
			{
				["tab"] = 3,
				["num"] = 20,
				["rank"] = {
					0.02, 0.04, 0.06,
				},
				["old"] = 11685,
			},
			{
				["tab"] = 3,
				["num"] = 20,
				["rank"] = {
					0.03, 0.06, 0.09,
				},
				["new"] = 11685,
			},
			{
				["tab"] = 1,
				["num"] = 22,
				["rank"] = {
					0.02, 0.04,
				},
			},
		},
		-- Warrior: Vitality (Rank 3) - 3,20
		--          Increases your total Strength and Stamina by 2%/4%/6% and your Expertise by 2/4/6.
		-- Warrior: Strength of Arms (Rank 2) - 1,22
		--          Increases your total Strength and total health by 2%/4%.
		-- Warrior: Improved Berserker Stance (Rank 5) - 2,22 - Stance
		--          Increases strength by 4/8/12/16/20% while in Berserker Stance.
		--   3.1.0: Increases strength by 4/8/12/16/20% while in Berserker Stance.
		["MOD_STR"] = {
			{
				["tab"] = 3,
				["num"] = 20,
				["rank"] = {
					0.02, 0.04, 0.06,
				},
			},
			{
				["tab"] = 1,
				["num"] = 22,
				["rank"] = {
					0.02, 0.04,
				},
			},
			{
				["tab"] = 2,
				["num"] = 22,
				["rank"] = {
					0.04, 0.08, 0.12, 0.16, 0.2,
				},
				["stance"] = "Interface\\Icons\\Ability_Racial_Avatar",
			},
		},
		-- Warrior: Shield Mastery (Rank 2) - 3,8
		--          Increases your block value by 15%/30% and reduces the cooldown of your Shield Block ability by 10/20 sec.
		["MOD_BLOCK_VALUE"] = {
			{
				["tab"] = 3,
				["num"] = 8,
				["rank"] = {
					0.15, 0.3,
				},
			},
		},
	}
end
	StatModTable["ALL"] = {
		-- ICC: Chill of the Throne
		--      Chance to dodge reduced by 20%.
		["ADD_DODGE"] = {
			{
				["rank"] = {
					-20, 
				},
				["buff"] = 69127,		-- ["Chill of the Throne"],
			},
		},
		-- Replenishment - Buff
		--   Replenishes 1% of maximum mana per 5 sec.
		-- Priest: Vampiric Touch
		--         Priest's party or raid members gain 1% of their maximum mana per 5 sec when the priest deals damage from Mind Blast.
		-- Paladin: Judgements of the Wise
		--          Your damaging Judgement spells have a 100% chance to grant the Replenishment effect to 
    --          up to 10 party or raid members mana regeneration equal to 1% of their maximum mana per 5 sec for 15 sec
		-- Hunter: Hunting Party
		--         Your Arcane Shot, Explosive Shot and Steady Shot critical strikes have a 100% chance to 
    --         grant up to 10 party or raid members mana regeneration equal to 1% of the maximum mana per 5 sec.
		["ADD_MANA_REG_MOD_MANA"] = {
			{
				["rank"] = {
					0.01,
				},
				["buff"] = 57669,		-- ["Replenishment"],
			},
		},
		-- Priest: Pain Suppression - Buff
		--         Instantly reduces a friendly target's threat by 5%, reduces all damage taken by 40% and increases resistance to Dispel mechanics by 65% for 8 sec.
		-- Priest: Grace - Buff
		--         Reduces damage taken by 1%.
		-- Warrior: Vigilance - Buff
		--          Damage taken reduced by 3% and 10% of all threat transferred to warrior.
		-- Paladin: Blessing of Sanctuary - Buff
		--          Damage taken reduced by up to 3%, strength and stamina increased by 10%.
		-- MetaGem: Effulgent Skyflare Diamond - 41377
		--          +32 Stamina and Reduce Spell Damage Taken by 2%
		-- Paladin: Lay on Hands (Rank 1/2) - Buff
		--          Physical damage taken reduced by 10/20%.
		-- Priest: Inspiration (Rank 1/2/3) - Buff
		--         Reduces physical damage taken by 3/7/10%.
		-- Shaman: Ancestral Fortitude (Rank 1/2/3) - Buff
		--         Reduces physical damage taken by 3/7/10%.
		["MOD_DMG_TAKEN"] = {
			{-- Pain Suppression
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["rank"] = {
					-0.4,
				},
				["buff"] = 33206,		-- ["Pain Suppression"],
			},
			{-- Grace
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["rank"] = {
					-0.01,
				},
				["buff"] = 47930,		-- ["Grace"],
			},
			{-- Vigilance
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["rank"] = {
					-0.03,
				},
				["buff"] = 50720,		-- ["Vigilance"],
			},
			{-- Blessing of Sanctuary
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["rank"] = {
					-0.03,
				},
				["buff"] = 20911,		-- ["Blessing of Sanctuary"],
			},
			{-- Greater Blessing of Sanctuary
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["rank"] = {
					-0.03,
				},
				["buff"] = 25899,		-- ["Greater Blessing of Sanctuary"],
			},
			{-- Effulgent Skyflare Diamond
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["rank"] = {
					-0.02,
				},
				["meta"] = 41377,
			},
			{-- Lay on Hands
				["MELEE"] = true,
				["RANGED"] = true,
				["rank"] = {
					-0.1, -0.2,
				},
				["buff"] = 20236,		-- ["Lay on Hands"],
				["new"] = 10147,
			},
			{
				["MELEE"] = true,
				["RANGED"] = true,
				["rank"] = {
					-0.03, -0.07, -0.1,
				},
				["buff"] = 15363,		-- ["Inspiration"],
        ["group"] = D["Reduced Physical Damage Taken"],
				["new"] = 10147,
			},
			{
				["MELEE"] = true,
				["RANGED"] = true,
				["rank"] = {
					-0.03, -0.07, -0.1,
				},
				["buff"] = 16237,		-- ["Ancestral Fortitude"],
        ["group"] = D["Reduced Physical Damage Taken"],
				["new"] = 10147,
			},
		},
		-- Priest: Power Infusion - Buff
		--         Infuses the target with power, increasing their spell damage and healing by 20%. Lasts 15 sec.
		["MOD_SPELL_DMG"] = {
			{
				["rank"] = {
					0.2,
				},
				["buff"] = 37274,		-- ["Power Infusion"],
			},
		},
		-- Priest: Power Infusion - Buff
		--         Infuses the target with power, increasing their spell damage and healing by 20%. Lasts 15 sec.
		["MOD_HEALING"] = {
			{
				["rank"] = {
					0.2,
				},
				["buff"] = 37274,		-- ["Power Infusion"],
			},
		},
		-- Night Elf : Quickness - Racial
		--             Reduces the chance that melee and ranged attackers will hit you by 2%.
		["ADD_HIT_TAKEN"] = {
			{
				["MELEE"] = true,
				["RANGED"] = true,
				["rank"] = {
					-0.02,
				},
				["race"] = "NightElf",
			},
		},
		-- MetaGem: Eternal Earthsiege Diamond - 41396
		--          +21 Defense Rating and +5% Shield Block Value
		-- MetaGem: Eternal Earthstorm Diamond - 35501
		--          +12 Defense Rating and +5% Shield Block Value
		["MOD_BLOCK_VALUE"] = {
			{
				["rank"] = {
					0.05,
				},
				["meta"] = 41396,
			},
			{
				["rank"] = {
					0.05,
				},
				["meta"] = 35501,
			},
		},
		-- Paladin: Lay on Hands (Rank 1/2) - Buff
		--          Physical damage taken reduced by 10%/20%.
		-- Priest: Inspiration (Rank 1/2/3) - Buff
		--         Reduces physical damage taken by 3/7/10%.
		-- Shaman: Ancestral Fortitude (Rank 1/2/3) - Buff
		--         Reduces physical damage taken by 3/7/10%.
		-- MetaGem: Austere Earthsiege Diamond - 41380
		--          +32 Stamina and 2% Increased Armor Value from Items
		["MOD_ARMOR"] = {
			{
				["rank"] = {
					0.15, 0.30,
				},
				["buff"] = 20236,		-- ["Lay on Hands"],
				["old"] = 10147,
			},
			{
				["rank"] = {
					0.08, 0.16, 0.25,
				},
				["buff"] = 15363,		-- ["Inspiration"],
				["old"] = 10147,
			},
			{
				["rank"] = {
					0.08, 0.16, 0.25,
				},
				["buff"] = 16237,		-- ["Ancestral Fortitude"],
				["old"] = 10147,
			},
			{
				["rank"] = {
					0.02,
				},
				["meta"] = 41380,
			},
		},
		-- Hunter: Trueshot Aura - Buff
		--         Attack power increased by 10%.
		-- Death Knight: Abomination's Might - Buff
		--               Attack power increased by 5/10%.
		-- Shaman: Unleashed Rage - Buff
		--         Melee attack power increased by 4/7/10%.
		["MOD_AP"] = {
			{
				["rank"] = {
					0.1,
				},
				["buff"] = 19506,		-- ["Trueshot Aura"],
        ["group"] = D["Attack Power Multiplier"],
			},
			{
				["rank"] = {
					0.05, 0.1,
				},
				["buff"] = 55972,		-- ["Abominable Might"],
        ["group"] = D["Attack Power Multiplier"],
			},
			{
				["rank"] = {
					0.04, 0.07, 0.1,
				},
				["buff"] = 30809,		-- ["Unleashed Rage"],
        ["group"] = D["Attack Power Multiplier"],
			},
		},
		-- MetaGem: Beaming Earthsiege Diamond - 41389
		--          +21 Critical Strike Rating and +2% Mana
		["MOD_MANA"] = {
			{
				["rank"] = {
					0.02,
				},
				["meta"] = 41389,
			},
		},
		-- Paladin: Blessing of Kings, Greater Blessing of Kings - Buff
		--          Increases stats by 10%.
		-- Paladin: Blessing of Sanctuary, Greater Blessing of Sanctuary - Buff
		--          Damage taken reduced by up to 3%, strength and stamina increased by 10%. Does not stack with Blessing of Kings.
		-- Leatherworking: Blessing of Forgotten Kings - Buff
		--                 Increases stats by 8%.
		["MOD_STR"] = {
			{
				["rank"] = {
					0.1,
				},
				["buff"] = 20217,		-- ["Blessing of Kings"],
        ["group"] = D["Stat Multiplier"],
			},
			{
				["rank"] = {
					0.1,
				},
				["buff"] = 25898,		-- ["Greater Blessing of Kings"],
        ["group"] = D["Stat Multiplier"],
			},
			{-- Blessing of Sanctuary
				["rank"] = {
					0.1,
				},
				["buff"] = 20911,		-- ["Blessing of Sanctuary"],
				["new"] = 10371,
        ["group"] = D["Stat Multiplier"],
			},
			{-- Greater Blessing of Sanctuary
				["rank"] = {
					0.1,
				},
				["buff"] = 25899,		-- ["Greater Blessing of Sanctuary"],
				["new"] = 10371,
        ["group"] = D["Stat Multiplier"],
			},
			{
				["rank"] = {
					0.08,
				},
				["buff"] = 69378,		-- ["Blessing of Forgotten Kings"],
        ["group"] = D["Stat Multiplier"],
			},
		},
		-- Paladin: Blessing of Kings, Greater Blessing of Kings - Buff
		--          Increases stats by 10%.
		-- Leatherworking: Blessing of Forgotten Kings - Buff
		--                 Increases stats by 8%.
		["MOD_AGI"] = {
			{
				["rank"] = {
					0.1,
				},
				["buff"] = 20217,		-- ["Blessing of Kings"],
        ["group"] = D["Stat Multiplier"],
			},
			{
				["rank"] = {
					0.1,
				},
				["buff"] = 25898,		-- ["Greater Blessing of Kings"],
        ["group"] = D["Stat Multiplier"],
			},
			{
				["rank"] = {
					0.08,
				},
				["buff"] = 69378,		-- ["Blessing of Forgotten Kings"],
        ["group"] = D["Stat Multiplier"],
			},
		},
		-- Paladin: Blessing of Kings, Greater Blessing of Kings - Buff
		--          Increases stats by 10%.
		-- Paladin: Blessing of Sanctuary, Greater Blessing of Sanctuary - Buff
		--          Damage taken reduced by up to 3%, strength and stamina increased by 10%. Does not stack with Blessing of Kings.
		-- Leatherworking: Blessing of Forgotten Kings - Buff
		--                 Increases stats by 8%.
		["MOD_STA"] = {
			{
				["rank"] = {
					0.1,
				},
				["buff"] = 20217,		-- ["Blessing of Kings"],
        ["group"] = D["Stat Multiplier"],
			},
			{
				["rank"] = {
					0.1,
				},
				["buff"] = 25898,		-- ["Greater Blessing of Kings"],
        ["group"] = D["Stat Multiplier"],
			},
			{-- Blessing of Sanctuary
				["rank"] = {
					0.1,
				},
				["buff"] = 20911,		-- ["Blessing of Sanctuary"],
				["new"] = 10147,
        ["group"] = D["Stat Multiplier"],
			},
			{-- Greater Blessing of Sanctuary
				["rank"] = {
					0.1,
				},
				["buff"] = 25899,		-- ["Greater Blessing of Sanctuary"],
				["new"] = 10147,
        ["group"] = D["Stat Multiplier"],
			},
			{
				["rank"] = {
					0.08,
				},
				["buff"] = 69378,		-- ["Blessing of Forgotten Kings"],
        ["group"] = D["Stat Multiplier"],
			},
		},
		-- Paladin: Blessing of Kings, Greater Blessing of Kings - Buff
		--          Increases stats by 10%.
		-- Leatherworking: Blessing of Forgotten Kings - Buff
		--                 Increases stats by 8%.
		-- Gnome: Expansive Mind - Racial
		--        Increase Intelligence by 5%.
		-- MetaGem: Ember Skyfire Diamond - 35503
		--          +14 Spell Power and +2% Intellect
		-- MetaGem: Ember Skyflare Diamond - 41333
		--          +25 Spell Power and +2% Intellect
		["MOD_INT"] = {
			{
				["rank"] = {
					0.1,
				},
				["buff"] = 20217,		-- ["Blessing of Kings"],
        ["group"] = D["Stat Multiplier"],
			},
			{
				["rank"] = {
					0.1,
				},
				["buff"] = 25898,		-- ["Greater Blessing of Kings"],
        ["group"] = D["Stat Multiplier"],
			},
			{
				["rank"] = {
					0.08,
				},
				["buff"] = 69378,		-- ["Blessing of Forgotten Kings"],
        ["group"] = D["Stat Multiplier"],
			},
			{
				["rank"] = {
					0.05,
				},
				["race"] = "Gnome",
			},
			{
				["rank"] = {
					0.02,
				},
				["meta"] = 35503,
			},
			{
				["rank"] = {
					0.02,
				},
				["meta"] = 41333,
			},
		},
		-- Paladin: Blessing of Kings, Greater Blessing of Kings - Buff
		--          Increases stats by 10%.
		-- Leatherworking: Blessing of Forgotten Kings - Buff
		--                 Increases stats by 8%.
		-- Human: The Human Spirit - Racial
		--        Increase Spirit by 10%.
		-- 3.0.2: Spirit increased by 3%.
		["MOD_SPI"] = {
			{
				["rank"] = {
					0.1,
				},
				["buff"] = 20217,		-- ["Blessing of Kings"],
        ["group"] = D["Stat Multiplier"],
			},
			{
				["rank"] = {
					0.1,
				},
				["buff"] = 25898,		-- ["Greater Blessing of Kings"],
        ["group"] = D["Stat Multiplier"],
			},
			{
				["rank"] = {
					0.08,
				},
				["buff"] = 69378,		-- ["Blessing of Forgotten Kings"],
        ["group"] = D["Stat Multiplier"],
			},
			{
				["rank"] = {
					0.03,
				},
				["race"] = "Human",
			},
		},
	}

-- Generate buff names
for class, tables in pairs(StatModTable) do
  for modName, mods in pairs(tables) do
    for key, mod in pairs(mods) do
      if mod.buff then
        mod.buffName = GetSpellInfo(mod.buff)
      end
      if mod.buff2 then
        mod.buff2Name = GetSpellInfo(mod.buff2)
      end
    end
  end
end

local function IsMetaGemActive(item)
	-- Check item
	if (type(item) == "string") or (type(item) == "number") then
	elseif type(item) == "table" and type(item.GetItem) == "function" then
		-- Get the link
		_, item = item:GetItem()
		if type(item) ~= "string" then return end
	else
		return
	end
	-- Check if item is in local cache
	local name, link, _, _, _, _, itemSubType = GetItemInfo(item)
	if not name or itemSubType ~= META_GEM then return end
	-- Start parsing
	tip:ClearLines() -- this is required or SetX won't work the second time its called
	tip:SetHyperlink(link)
	if not strfind(tip[3]:GetText(), "|cff808080") then
		-- Metagem requirements satisfied, check if metagem is equipped
		local headLink = GetInventoryItemLink("player", 1)
		if not headLink then return end
		local gemId = StatLogic:GetGemID(item)
		if not gemId then return end
		if strfind(headLink, ":"..gemId..":") then
			return true
		end
	end
end
StatLogic.IsMetaGemActive = IsMetaGemActive

local function SlotHasEnchant(enchantId, slotId)
	-- Check args
	if type(enchantId) ~= "number" then return end
	if (type(slotId) ~= "number") and (type(slotId) ~= "nil") then return end
	-- If slot is specified
	if type(slotId) == "number" then
		local slotLink = GetInventoryItemLink("player", slotId)
		if not slotLink then return end
		if strfind(slotLink, ":"..enchantId..":") then
			return 1
		end
	else
		-- check all slots 1 to 18 if slotId is nil
		local count = 0
		for slotId = 1, 18 do
			local slotLink = GetInventoryItemLink("player", slotId)
			if slotLink and strfind(slotLink, ":"..enchantId..":") then
				count = count + 1
			end
		end
		if count ~= 0 then
			return count
		end
	end
end
StatLogic.SlotHasEnchant = SlotHasEnchant

--[[---------------------------------
	:GetStatMod(stat, school)
-------------------------------------
Notes:
	* Calculates various stat mod values from talents and buffs.
	* initialValue: sets the initial value for the stat mod.
	::if initialValue == 0, inter-mod operations are done with addition,
	::if initialValue == 1, inter-mod operations are done with multiplication,
	* finalAdjust: added to the final result before returning, so we can adjust the return value to be used in addition or multiplication.
	:: for addition: initialValue + finalAdjust = 0
	:: for multiplication: initialValue + finalAdjust = 1
	* stat:
	:{| class="wikitable"
	!"StatMod"!!Initial value!!Final adjust!!schoo required
	|-
	|"ADD_CRIT_TAKEN"||0||0||Yes
	|-
	|"ADD_HIT_TAKEN"||0||0||Yes
	|-
	|"ADD_DODGE"||0||0||No
	|-
	|"ADD_AP_MOD_INT"||0||0||No
	|-
	|"ADD_AP_MOD_STA"||0||0||No
	|-
	|"ADD_AP_MOD_ARMOR"||0||0||No
	|-
	|"ADD_AP_MOD_SPELL_DMG"||0||0||No
	|-
	|"ADD_CR_PARRY_MOD_STR"||0||0||No
	|-
	|"ADD_MANA_REG_MOD_INT"||0||0||No
	|-
	|"ADD_RANGED_AP_MOD_INT"||0||0||No
	|-
	|"ADD_ARMOR_MOD_INT"||0||0||No
	|-
	|"ADD_SCHOOL_SP_MOD_SPI"||0||0||Yes
	|-
	|"ADD_SPELL_DMG_MOD_AP"||0||0||No
	|-
	|"ADD_SPELL_DMG_MOD_STA"||0||0||No
	|-
	|"ADD_SPELL_DMG_MOD_INT"||0||0||No
	|-
	|"ADD_SPELL_DMG_MOD_SPI"||0||0||No
	|-
	|"ADD_HEALING_MOD_AP"||0||0||No
	|-
	|"ADD_HEALING_MOD_STR"||0||0||No
	|-
	|"ADD_HEALING_MOD_AGI"||0||0||No
	|-
	|"ADD_HEALING_MOD_STA"||0||0||No
	|-
	|"ADD_HEALING_MOD_INT"||0||0||No
	|-
	|"ADD_HEALING_MOD_SPI"||0||0||No
	|-
	|"ADD_MANA_REG_MOD_NORMAL_MANA_REG"||0||0||No
	|-
	|"MOD_CRIT_DAMAGE_TAKEN"||0||1||Yes
	|-
	|"MOD_DMG_TAKEN"||0||1||Yes
	|-
	|"MOD_CRIT_DAMAGE"||0||1||Yes
	|-
	|"MOD_DMG"||0||1||Yes
	|-
	|"MOD_ARMOR"||1||0||No
	|-
	|"MOD_HEALTH"||1||0||No
	|-
	|"MOD_MANA"||1||0||No
	|-
	|"MOD_STR"||0||1||No
	|-
	|"MOD_AGI"||0||1||No
	|-
	|"MOD_STA"||0||1||No
	|-
	|"MOD_INT"||0||1||No
	|-
	|"MOD_SPI"||0||1||No
	|-
	|"MOD_BLOCK_VALUE"||0||1||No
	|-
	|"MOD_AP"||0||1||No
	|-
	|"MOD_RANGED_AP"||0||1||No
	|-
	|"MOD_SPELL_DMG"||0||1||No
	|-
	|"MOD_HEALING"||0||1||No
	|}
Arguments:
	string - The type of stat mod you want to get
	[optional] string - Certain stat mods require an extra school argument
Returns:
	None
Example:
	StatLogic:GetStatMod("MOD_INT")
-----------------------------------]]
local buffGroup = {}
function StatLogic:GetStatMod(stat, school, talentGroup)
	local statModInfo = StatModInfo[stat]
	local mod = statModInfo.initialValue
	-- if school is required for this statMod but not given
	if statModInfo.school and not school then return mod + statModInfo.finalAdjust end
  -- disable for 4.0.1 until we get talent/buffs data implemented
  if toc >= 40000 then return mod + statModInfo.finalAdjust end
  wipe(buffGroup)
	-- Class specific mods
	if type(StatModTable[playerClass][stat]) == "table" then
		for _, case in ipairs(StatModTable[playerClass][stat]) do
			local ok = true
			if school and not case[school] then ok = nil end
			if ok and case.newtoc and toc < case.newtoc then ok = nil end
			if ok and case.oldtoc and toc >= case.oldtoc then ok = nil end
			if ok and case.new and wowBuildNo < case.new then ok = nil end
			if ok and case.old and wowBuildNo >= case.old then ok = nil end
			if ok and case.condition and not loadstring("return "..case.condition)() then ok = nil end
			if ok and case.buffName and not PlayerHasAura(case.buffName) then ok = nil end
			if ok and case.buff2Name and not PlayerHasAura(case.buff2Name) then ok = nil end
			if ok and case.stance and case.stance ~= GetStanceIcon() then ok = nil end
			if ok and case.glyph and not PlayerHasGlyph(case.glyph, talentGroup) then ok = nil end
			if ok and case.enchant and not SlotHasEnchant(case.enchant, case.slot) then ok = nil end
			if ok and case.itemset and ((not PlayerItemSets[case.itemset[1]]) or PlayerItemSets[case.itemset[1]] < case.itemset[2]) then ok = nil end
			if ok then
				local r, _
				local s = 1
				-- if talent field
				if case.tab and case.num then
					_, _, _, _, r = GetTalentInfo(case.tab, case.num, nil, nil, talentGroup)
					if case.buffName and case.buffStack then
						_, s = GetPlayerAuraRankStack(case.buffName) -- Gets buff stack count, but use talent as rank
					end
				-- no talent but buff is given
				elseif case.buffName then
					r, s = GetPlayerAuraRankStack(case.buffName)
					if not case.buffStack then
						s = 1
					end
				-- no talent but all other given conditions are statisfied
				else--if case.condition or case.stance then
					r = 1
				end
				if r and r ~= 0 and case.rank[r] then
					if statModInfo.initialValue == 0 then
            if not case.group then
              mod = mod + case.rank[r] * s
            elseif not buffGroup[case.group] then -- this mod is part of a group, but not seen before
              mod = mod + case.rank[r] * s
              buffGroup[case.group] = case.rank[r] * s
            elseif (case.rank[r] * s) > buffGroup[case.group] then -- seen before and this one is better, do upgrade
              mod = mod + case.rank[r] * s - buffGroup[case.group]
              buffGroup[case.group] = case.rank[r] * s
            else -- seen before but not better, do nothing
            end
					else
            if not case.group then
              mod = mod * (case.rank[r] * s + 1)
            elseif not buffGroup[case.group] then -- this mod is part of a group, but not seen before
              mod = mod * (case.rank[r] * s + 1)
              buffGroup[case.group] = (case.rank[r] * s + 1)
            elseif (case.rank[r] * s + 1) > buffGroup[case.group] then -- seen before and this one is better, do upgrade
              mod = mod * (case.rank[r] * s + 1) / buffGroup[case.group]
              buffGroup[case.group] = (case.rank[r] * s + 1)
            else -- seen before but not better, do nothing
            end
					end
				end
			end
		end
	end
	-- Non class specific mods
	if type(StatModTable["ALL"][stat]) == "table" then
		for _, case in ipairs(StatModTable["ALL"][stat]) do
			local ok = true
			if school and not case[school] then ok = nil end
			if ok and case.new and wowBuildNo < case.new then ok = nil end
			if ok and case.old and wowBuildNo >= case.old then ok = nil end
			if ok and case.condition and not loadstring("return "..case.condition)() then ok = nil end
			if ok and case.buffName and not PlayerHasAura(case.buffName) then ok = nil end
			if ok and case.stance and case.stance ~= GetStanceIcon() then ok = nil end
			if ok and case.race and case.race ~= playerRace then ok = nil end
			if ok and case.meta and not IsMetaGemActive(case.meta) then ok = nil end
			if ok then
				local r, _
				local s = 1
				-- if talent field
				if case.tab and case.num then
					_, _, _, _, r = GetTalentInfo(case.tab, case.num, nil, nil, talentGroup)
					if case.buffName and case.buffStack then
						_, s = GetPlayerAuraRankStack(case.buffName) -- Gets buff rank and stack count
					end
				-- no talent but buff is given
				elseif case.buffName then
					r, s = GetPlayerAuraRankStack(case.buffName)
					if not case.buffStack then
						s = 1
					end
				-- no talent but all other given conditions are statisfied
				else--if case.condition or case.stance then
					r = 1
				end
				if r and r ~= 0 and case.rank[r] then
					if statModInfo.initialValue == 0 then
            if not case.group then
              mod = mod + case.rank[r] * s
            elseif not buffGroup[case.group] then -- this mod is part of a group, but not seen before
              mod = mod + case.rank[r] * s
              buffGroup[case.group] = case.rank[r] * s
            elseif (case.rank[r] * s) > buffGroup[case.group] then -- seen before and this one is better, do upgrade
              mod = mod + case.rank[r] * s - buffGroup[case.group]
              buffGroup[case.group] = case.rank[r] * s
            else -- seen before but not better, do nothing
            end
					else
            if not case.group then
              mod = mod * (case.rank[r] * s + 1)
            elseif not buffGroup[case.group] then -- this mod is part of a group, but not seen before
              mod = mod * (case.rank[r] * s + 1)
              buffGroup[case.group] = (case.rank[r] * s + 1)
            elseif (case.rank[r] * s + 1) > buffGroup[case.group] then -- seen before and this one is better, do upgrade
              mod = mod * (case.rank[r] * s + 1) / buffGroup[case.group]
              buffGroup[case.group] = (case.rank[r] * s + 1)
            else -- seen before but not better, do nothing
            end
					end
				end
			end
		end
	end

	return mod + statModInfo.finalAdjust
end

--=====================================--
-- Avoidance stats diminishing returns --
--=====================================--
-- Formula reverse engineered by Whitetooth (hotdogee [at] gmail [dot] com)
--[[---------------------------------
This includes
1. Dodge from Dodge Rating, Defense, Agility.
2. Parry from Parry Rating, Defense.
3. Chance to be missed from Defense.

The following is the result of hours of work gathering data from beta servers and then spending even more time running multiple regression analysis on the data.

1. DR for Dodge, Parry, Missed are calculated separately.
2. Base avoidances are not affected by DR, (ex: Dodge from base Agility)
3. Death Knight's Parry from base Strength is affected by DR, base for parry is 5%.
4. Direct avoidance gains from talents and spells(ex: Evasion) are not affected by DR.
5. Indirect avoidance gains from talents and spells(ex: +Agility from Kings) are affected by DR
6. c and k values depend on class but does not change with level.

7. The DR formula:

1/x' = 1/c+k/x

x' is the diminished stat before converting to IEEE754.
x is the stat before diminishing returns.
c is the cap of the stat, and changes with class.
k is is a value that changes with class.
-----------------------------------]]
-- The following K, C_p, C_d are calculated by Whitetooth (hotdogee [at] gmail [dot] com)
local K = {
	0.956, 0.956, 0.988, 0.988, 0.983, 0.956, 0.988, 0.983, 0.983, 0.972,
	--["WARRIOR"]     = 0.956,
	--["PALADIN"]     = 0.956,
	--["HUNTER"]      = 0.988,
	--["ROGUE"]       = 0.988,
	--["PRIEST"]      = 0.983,
	--["DEATHKNIGHT"] = 0.956,
	--["SHAMAN"]      = 0.988,
	--["MAGE"]        = 0.983,
	--["WARLOCK"]     = 0.983,
	--["DRUID"]       = 0.972,
}
local C_p = {
	1/0.021275, 1/0.021275, 1/0.006870, 1/0.006870, 1/0.021275, 1/0.021275, 1/0.006870, 1/0.021275, 1/0.021275, 1/0.021275,
	--["WARRIOR"]     = 1/0.021275,
	--["PALADIN"]     = 1/0.021275,
	--["HUNTER"]      = 1/0.006870,
	--["ROGUE"]       = 1/0.006870,
	--["PRIEST"]      = 0, --use tank stats
	--["DEATHKNIGHT"] = 1/0.021275,
	--["SHAMAN"]      = 1/0.006870,
	--["MAGE"]        = 0, --use tank stats
	--["WARLOCK"]     = 0, --use tank stats
	--["DRUID"]       = 0, --use tank stats
}
local C_d = {
	1/0.011347, 1/0.011347, 1/0.006870, 1/0.006870, 1/0.006650, 1/0.011347, 1/0.006870, 1/0.006650, 1/0.006650, 1/0.008555,
	--["WARRIOR"]     = 1/0.011347,
	--["PALADIN"]     = 1/0.011347,
	--["HUNTER"]      = 1/0.006870,
	--["ROGUE"]       = 1/0.006870,
	--["PRIEST"]      = 1/0.006650,
	--["DEATHKNIGHT"] = 1/0.011347,
	--["SHAMAN"]      = 1/0.006870,
	--["MAGE"]        = 1/0.006650,
	--["WARLOCK"]     = 1/0.006650,
	--["DRUID"]       = 1/0.008555,
}
if toc >= 40000 then
K = {
	0.956, 0.956, 0.988, 0.988, 0.983, 0.956, 0.988, 0.983, 0.983, 0.972,
	--["WARRIOR"]     = 0.956,
	--["PALADIN"]     = 0.956,
	--["HUNTER"]      = 0.988,
	--["ROGUE"]       = 0.988,
	--["PRIEST"]      = 0.983,
	--["DEATHKNIGHT"] = 0.956,
	--["SHAMAN"]      = 0.988,
	--["MAGE"]        = 0.983,
	--["WARLOCK"]     = 0.983,
	--["DRUID"]       = 0.972,
}
C_p = {
	1/0.0152366, 1/0.0152366, 1/0.006870, 1/0.006870, 1/0.0152366, 1/0.0152366, 1/0.006870, 1/0.0152366, 1/0.0152366, 1/0.0152366,
	--["WARRIOR"]     = 1/0.0152366,
	--["PALADIN"]     = 1/0.0152366,
	--["HUNTER"]      = 1/0.006870,
	--["ROGUE"]       = 1/0.006870,
	--["PRIEST"]      = 0, --use tank stats
	--["DEATHKNIGHT"] = 1/0.0152366,
	--["SHAMAN"]      = 1/0.006870,
	--["MAGE"]        = 0, --use tank stats
	--["WARLOCK"]     = 0, --use tank stats
	--["DRUID"]       = 0, --use tank stats
}
C_d = {
	1/0.0152366, 1/0.0152366, 1/0.006870, 1/0.006870, 1/0.006650, 1/0.0152366, 1/0.006870, 1/0.006650, 1/0.006650, 1/0.008555,
	--["WARRIOR"]     = 1/0.0152366,
	--["PALADIN"]     = 1/0.0152366,
	--["HUNTER"]      = 1/0.006870,
	--["ROGUE"]       = 1/0.006870,
	--["PRIEST"]      = 1/0.006650,
	--["DEATHKNIGHT"] = 1/0.0152366,
	--["SHAMAN"]      = 1/0.006870,
	--["MAGE"]        = 1/0.006650,
	--["WARLOCK"]     = 1/0.006650,
	--["DRUID"]       = 1/0.008555,
}
end

-- I've done extensive tests that show the miss cap is 16% for warriors.
-- Because the only tank I have with 150 pieces of epic gear required for the tests is a warrior,
-- Until someone that has the will and gear to preform the tests for other classes, I'm going to assume the cap is the same(which most likely isn't)
local C_m = {16, 16, 16, 16, 16, 16, 16, 16, 16, 16, }

function StatLogic:GetMissedChanceBeforeDR()
	local baseDefense, additionalDefense = UnitDefense("player")
	local defenseFromDefenseRating = floor(self:GetEffectFromRating(GetCombatRating(CR_DEFENSE_SKILL), CR_DEFENSE_SKILL))
	local modMissed = defenseFromDefenseRating * 0.04
	local drFreeMissed = 5 + (baseDefense + additionalDefense - defenseFromDefenseRating) * 0.04
	return modMissed, drFreeMissed
end
--[[---------------------------------
	:GetDodgeChanceBeforeDR()
-------------------------------------
Notes:
	* Calculates your current Dodge% before diminishing returns.
	* Dodge% = modDodge + drFreeDodge
	* drFreeDodge includes:
	** Base dodge
	** Dodge from base agility
	** Dodge modifier from base defense
	** Dodge modifers from talents or spells
	* modDodge includes
	** Dodge from dodge rating
	** Dodge from additional defense
	** Dodge from additional dodge
Arguments:
	None
Returns:
	; modDodge : number - The part that is affected by diminishing returns.
	; drFreeDodge : number - The part that isn't affected by diminishing returns.
Example:
	local modDodge, drFreeDodge = StatLogic:GetDodgeChanceBeforeDR()
-----------------------------------]]
local BaseDodge
function StatLogic:GetDodgeChanceBeforeDR()
	local class = ClassNameToID[playerClass]

	-- drFreeDodge
	local stat, effectiveStat, posBuff, negBuff = UnitStat("player", 2) -- 2 = Agility
	local baseAgi = stat - posBuff - negBuff
	local dodgePerAgi = self:GetDodgePerAgi()
	--[[
	local drFreeDodge = BaseDodge[class] + dodgePerAgi * baseAgi
		+ self:GetStatMod("ADD_DODGE") + (baseDefense - UnitLevel("player") * 5) * 0.04
	--]]
	-- modDodge
	local dodgeFromDodgeRating = self:GetEffectFromRating(GetCombatRating(CR_DODGE), CR_DODGE, UnitLevel("player"))
	local dodgeFromDefenceRating = floor(self:GetEffectFromRating(GetCombatRating(CR_DEFENSE_SKILL), CR_DEFENSE_SKILL)) * 0.04
	local dodgeFromAdditionalAgi = dodgePerAgi * (effectiveStat - baseAgi)
	local modDodge = dodgeFromDodgeRating + dodgeFromDefenceRating + dodgeFromAdditionalAgi

	local drFreeDodge = GetDodgeChance() - self:GetAvoidanceAfterDR("DODGE", modDodge, class)

	return modDodge, drFreeDodge
end

--[[---------------------------------
	:GetParryChanceBeforeDR()
-------------------------------------
Notes:
	* Calculates your current Parry% before diminishing returns.
	* Parry% = modParry + drFreeParry
	* drFreeParry includes:
	** Base parry
	** Parry from base agility
	** Parry modifier from base defense
	** Parry modifers from talents or spells
	* modParry includes
	** Parry from parry rating
	** Parry from additional defense
	** Parry from additional parry
Arguments:
	None
Returns:
	; modParry : number - The part that is affected by diminishing returns.
	; drFreeParry : number - The part that isn't affected by diminishing returns.
Example:
	local modParry, drFreeParry = StatLogic:GetParryChanceBeforeDR()
-----------------------------------]]
function StatLogic:GetParryChanceBeforeDR()
	local class = ClassNameToID[playerClass]

	-- Defense is floored
	local parryFromParryRating = self:GetEffectFromRating(GetCombatRating(CR_PARRY), CR_PARRY)
	local parryFromDefenceRating = floor(self:GetEffectFromRating(GetCombatRating(CR_DEFENSE_SKILL), CR_DEFENSE_SKILL)) * 0.04
	local modParry = parryFromParryRating + parryFromDefenceRating

	-- drFreeParry
	local drFreeParry = GetParryChance() - self:GetAvoidanceAfterDR("PARRY", modParry, class)

	return modParry, drFreeParry
end

--[[---------------------------------
	:GetAvoidanceAfterDR(avoidanceType, avoidanceBeforeDR[, class])
-------------------------------------
Notes:
	* Avoidance DR formula and k, C_p, C_d constants derived by Whitetooth (hotdogee [at] gmail [dot] com)
	* avoidanceBeforeDR is the part that is affected by diminishing returns.
	* See :GetClassIdOrName(class) for valid class values.
	* Calculates the avoidance after diminishing returns, this includes:
	*# Dodge from Dodge Rating, Defense, Agility.
	*# Parry from Parry Rating, Defense.
	*# Chance to be missed from Defense.
	* The DR formula: 1/x' = 1/c+k/x
	** x' is the diminished stat before converting to IEEE754.
	** x is the stat before diminishing returns.
	** c is the cap of the stat, and changes with class.
	** k is is a value that changes with class.
	* Formula details:
	*# DR for Dodge, Parry, Missed are calculated separately.
	*# Base avoidances are not affected by DR, (ex: Dodge from base Agility)
	*# Death Knight's Parry from base Strength is affected by DR, base for parry is 5%.
	*# Direct avoidance gains from talents and spells(ex: Evasion) are not affected by DR.
	*# Indirect avoidance gains from talents and spells(ex: +Agility from Kings) are affected by DR
	*# c and k values depend on class but does not change with level.
	:{| class="wikitable"
	! !!k!!C_p!!1/C_p!!C_d!!1/C_d
	|-
	|Warrior||0.9560||47.003525||0.021275||88.129021||0.011347
	|-
	|Paladin||0.9560||47.003525||0.021275||88.129021||0.011347
	|-
	|Hunter||0.9880||145.560408||0.006870||145.560408||0.006870
	|-
	|Rogue||0.9880||145.560408||0.006870||145.560408||0.006870
	|-
	|Priest||0.9530||0||0||150.375940||0.006650
	|-
	|Deathknight||0.9560||47.003525||0.021275||88.129021||0.011347
	|-
	|Shaman||0.9880||145.560408||0.006870||145.560408||0.006870
	|-
	|Mage||0.9530||0||0||150.375940||0.006650
	|-
	|Warlock||0.9530||0||0||150.375940||0.006650
	|-
	|Druid||0.9720||0||0||116.890707||0.008555
	|}
Arguments:
	string - "DODGE", "PARRY", "MELEE_HIT_AVOID"(NYI)
	number - amount of avoidance before diminishing returns in percentages.
	[optional] string or number - ClassID or "ClassName". Default: PlayerClass<br>See :GetClassIdOrName(class) for valid class values.
Returns:
	; avoidanceAfterDR : number - avoidance after diminishing returns in percentages.
Example:
	local modParry, drFreeParry = StatLogic:GetParryChanceBeforeDR()
	local modParryAfterDR = StatLogic:GetAvoidanceAfterDR("PARRY", modParry)
	local parry = modParryAfterDR + drFreeParry

	local modParryAfterDR = StatLogic:GetAvoidanceAfterDR("PARRY", modParry, "WARRIOR")
	local parry = modParryAfterDR + drFreeParry
-----------------------------------]]
function StatLogic:GetAvoidanceAfterDR(avoidanceType, avoidanceBeforeDR, class)
	-- argCheck for invalid input
	self:argCheck(avoidanceType, 2, "string")
	self:argCheck(avoidanceBeforeDR, 3, "number")
	self:argCheck(class, 4, "nil", "string", "number")
	-- if class is a class string, convert to class id
	if type(class) == "string" and ClassNameToID[strupper(class)] ~= nil then
		class = ClassNameToID[strupper(class)]
	-- if class is invalid input, default to player class
	elseif type(class) ~= "number" or class < 1 or class > 10 then
		class = ClassNameToID[playerClass]
	end

	local C = C_d
	if avoidanceType == "PARRY" then
		C = C_p
	elseif avoidanceType == "MELEE_HIT_AVOID" then
		C = C_m
	end

	return 1 / (1 / C[class] + K[class] / avoidanceBeforeDR)
end

--[[---------------------------------
	:GetAvoidanceGainAfterDR(avoidanceType, gainBeforeDR)
-------------------------------------
Notes:
	* Calculates the avoidance gain after diminishing returns with player's current stats.
Arguments:
	string - "DODGE", "PARRY", "MELEE_HIT_AVOID"(NYI)
	number - Avoidance gain before diminishing returns in percentages.
Returns:
	; gainAfterDR : number - Avoidance gain after diminishing returns in percentages.
Example:
	-- How much dodge will I gain with +30 Agi after DR?
	local gainAfterDR = StatLogic:GetAvoidanceGainAfterDR("DODGE", 30*StatLogic:GetDodgePerAgi())
	-- How much dodge will I gain with +20 Parry Rating after DR?
	local gainAfterDR = StatLogic:GetAvoidanceGainAfterDR("PARRY", StatLogic:GetEffectFromRating(20, CR_PARRY))
-----------------------------------]]
function StatLogic:GetAvoidanceGainAfterDR(avoidanceType, gainBeforeDR)
	-- argCheck for invalid input
	self:argCheck(gainBeforeDR, 2, "number")
	local class = ClassNameToID[playerClass]

	if avoidanceType == "PARRY" then
		local modAvoidance, drFreeAvoidance = self:GetParryChanceBeforeDR()
		local newAvoidanceChance = self:GetAvoidanceAfterDR(avoidanceType, modAvoidance + gainBeforeDR) + drFreeAvoidance
		if newAvoidanceChance < 0 then newAvoidanceChance = 0 end
		return newAvoidanceChance - GetParryChance()
	elseif avoidanceType == "DODGE" then
		local modAvoidance, drFreeAvoidance = self:GetDodgeChanceBeforeDR()
		local newAvoidanceChance = self:GetAvoidanceAfterDR(avoidanceType, modAvoidance + gainBeforeDR) + drFreeAvoidance
		if newAvoidanceChance < 0 then newAvoidanceChance = 0 end -- because GetDodgeChance() is 0 when negative
		return newAvoidanceChance - GetDodgeChance()
	elseif avoidanceType == "MELEE_HIT_AVOID" then
		local modAvoidance = self:GetMissedChanceBeforeDR()
		return self:GetAvoidanceAfterDR(avoidanceType, modAvoidance + gainBeforeDR) - self:GetAvoidanceAfterDR(avoidanceType, modAvoidance)
	end
end


--=================--
-- Stat Conversion --
--=================--
--[[---------------------------------
	:GetReductionFromArmor(armor, attackerLevel)
-------------------------------------
Notes:
	* Calculates the damage reduction from armor for given attacker level.
Arguments:
	[optional] string - Armor value. Default: player's armor value
	[optional] number - Attacker level. Default: player's level
Returns:
	; damageRecudtion : number - Damage reduction value from 0 to 1. (not percentage)
Example:
	local damageRecudtion = StatLogic:GetReductionFromArmor(35000, 80) -- 0.69676006569452
-----------------------------------]]
function StatLogic:GetReductionFromArmor(armor, attackerLevel)
	self:argCheck(armor, 2, "nil", "number")
	self:argCheck(attackerLevel, 3, "nil", "number")
	if not armor then
		armor = select(2, UnitArmor("player"))
	end
	if not attackerLevel then
		attackerLevel = UnitLevel("player")
	end

	local levelModifier = attackerLevel
	if ( levelModifier > 80 ) then
		levelModifier = levelModifier + (4.5 * (levelModifier - 59)) + (20 * (levelModifier - 80));
	elseif ( levelModifier > 59 ) then
		levelModifier = levelModifier + (4.5 * (levelModifier - 59))
	end
	local temp = armor / (85 * levelModifier + 400)
	local armorReduction = temp / (1 + temp)
	-- caps at 0.75
	if armorReduction > 0.75 then
		armorReduction = 0.75
	end
	if armorReduction < 0 then
		armorReduction = 0
	end
	return armorReduction
end

--[[---------------------------------
	:GetEffectFromDefense(defense, attackerLevel)
-------------------------------------
Notes:
	* Calculates the effective avoidance% from defense (before diminishing returns) for given attacker level
Arguments:
	[optional] string - Total defense value. Default: player's armor value
	[optional] number - Attacker level. Default: player's level
Returns:
	; effect : number - 0.04% per effective defense.
Example:
	local effect = StatLogic:GetEffectFromDefense(415, 83) -- 0
-----------------------------------]]
function StatLogic:GetEffectFromDefense(defense, attackerLevel)
	self:argCheck(defense, 2, "nil", "number")
	self:argCheck(attackerLevel, 3, "nil", "number")
	if not armor then
		local base, add = UnitDefense("player")
		armor = base + add
	end
	if not attackerLevel then
		attackerLevel = UnitLevel("player")
	end
	return (defense - attackerLevel * 5) * 0.04
end


--[[---------------------------------
	:GetEffectFromRating(rating, id[, level][, class])
-------------------------------------
Notes:
	* Combat Rating formula and constants derived by Whitetooth (hotdogee [at] gmail [dot] com)
	* Calculates the stat effects from ratings for any level.
	* id: Rating ID as definded in PaperDollFrame.lua
	::CR_WEAPON_SKILL = 1
	::CR_DEFENSE_SKILL = 2
	::CR_DODGE = 3
	::CR_PARRY = 4
	::CR_BLOCK = 5
	::CR_HIT_MELEE = 6
	::CR_HIT_RANGED = 7
	::CR_HIT_SPELL = 8
	::CR_CRIT_MELEE = 9
	::CR_CRIT_RANGED = 10
	::CR_CRIT_SPELL = 11
	::CR_HIT_TAKEN_MELEE = 12
	::CR_HIT_TAKEN_RANGED = 13
	::CR_HIT_TAKEN_SPELL = 14
	::CR_CRIT_TAKEN_MELEE = 15
	::CR_CRIT_TAKEN_RANGED = 16
	::CR_CRIT_TAKEN_SPELL = 17
	::CR_HASTE_MELEE = 18
	::CR_HASTE_RANGED = 19
	::CR_HASTE_SPELL = 20
	::CR_WEAPON_SKILL_MAINHAND = 21
	::CR_WEAPON_SKILL_OFFHAND = 22
	::CR_WEAPON_SKILL_RANGED = 23
	::CR_EXPERTISE = 24
	::CR_ARMOR_PENETRATION = 25
	* The Combat Rating formula:
	** Percentage = Rating / RatingBase / H
	*** Level 1 to 10:  H = 2/52
	*** Level 10 to 60: H = (level-8)/52
	*** Level 60 to 70: H = 82/(262-3*level)
	*** Level 70 to 80: H = (82/52)*(131/63)^((level-70)/10)
	::{| class="wikitable"
	!RatingID!!RatingBase
	|-
	|CR_WEAPON_SKILL||2.5
	|-
	|CR_DEFENSE_SKILL||1.5
	|-
	|CR_DODGE||12
	|-
	|CR_PARRY||15
	|-
	|CR_BLOCK||5
	|-
	|CR_HIT_MELEE||10
	|-
	|CR_HIT_RANGED||10
	|-
	|CR_HIT_SPELL||8
	|-
	|CR_CRIT_MELEE||14
	|-
	|CR_CRIT_RANGED||14
	|-
	|CR_CRIT_SPELL||14
	|-
	|CR_HIT_TAKEN_MELEE||10
	|-
	|CR_HIT_TAKEN_RANGED||10
	|-
	|CR_HIT_TAKEN_SPELL||8
	|-
	|CR_CRIT_TAKEN_MELEE||25
	|-
	|CR_CRIT_TAKEN_RANGED||25
	|-
	|CR_CRIT_TAKEN_SPELL||25
	|-
	|CR_HASTE_MELEE||10
	|-
	|CR_HASTE_RANGED||10
	|-
	|CR_HASTE_SPELL||10
	|-
	|CR_WEAPON_SKILL_MAINHAND||2.5
	|-
	|CR_WEAPON_SKILL_OFFHAND||2.5
	|-
	|CR_WEAPON_SKILL_RANGED||2.5
	|-
	|CR_EXPERTISE||2.5
	|-
	|CR_ARMOR_PENETRATION||4.69512176513672
	|}
	* Parry Rating, Defense Rating, Block Rating and Resilience: Low-level players will now convert these ratings into their corresponding defensive stats at the same rate as level 34 players.
Arguments:
	number - Rating value
	number - Rating ID as defined in PaperDollFrame.lua
	[optional] number - Level used in calculations. Default: player's level
	[optional] string or number - ClassID or "ClassName". Default: PlayerClass<br>See :GetClassIdOrName(class) for valid class values.
Returns:
	; effect : number - Effect value
	; effect name : string - Stat ID of converted effect, ex: "DODGE", "PARRY"
Example:
	StatLogic:GetEffectFromRating(10, CR_DODGE)
	StatLogic:GetEffectFromRating(10, CR_DODGE, 70)
-----------------------------------]]

--[[ Rating ID as definded in PaperDollFrame.lua
CR_WEAPON_SKILL = 1;
CR_DEFENSE_SKILL = 2;
CR_DODGE = 3;
CR_PARRY = 4;
CR_BLOCK = 5;
CR_HIT_MELEE = 6;
CR_HIT_RANGED = 7;
CR_HIT_SPELL = 8;
CR_CRIT_MELEE = 9;
CR_CRIT_RANGED = 10;
CR_CRIT_SPELL = 11;
CR_HIT_TAKEN_MELEE = 12;
CR_HIT_TAKEN_RANGED = 13;
CR_HIT_TAKEN_SPELL = 14;
CR_CRIT_TAKEN_MELEE = 15;
CR_CRIT_TAKEN_RANGED = 16;
CR_CRIT_TAKEN_SPELL = 17;
CR_HASTE_MELEE = 18;
CR_HASTE_RANGED = 19;
CR_HASTE_SPELL = 20;
CR_WEAPON_SKILL_MAINHAND = 21;
CR_WEAPON_SKILL_OFFHAND = 22;
CR_WEAPON_SKILL_RANGED = 23;
CR_EXPERTISE = 24;
CR_ARMOR_PENETRATION = 25;
--]]

-- Level 60 rating base
local RatingBase
local Level34Ratings
if toc < 40000 then
RatingBase = {
	[CR_WEAPON_SKILL] = 2.5,
	[CR_DEFENSE_SKILL] = 1.5,
	[CR_DODGE] = 12,
	[CR_PARRY] = 15,
	[CR_BLOCK] = 5,
	[CR_HIT_MELEE] = 10,
	[CR_HIT_RANGED] = 10,
	[CR_HIT_SPELL] = 8,
	[CR_CRIT_MELEE] = 14,
	[CR_CRIT_RANGED] = 14,
	[CR_CRIT_SPELL] = 14,
	[CR_HIT_TAKEN_MELEE] = 10, -- hit avoidance
	[CR_HIT_TAKEN_RANGED] = 10,
	[CR_HIT_TAKEN_SPELL] = 8,
	[CR_CRIT_TAKEN_MELEE] = 25, -- resilience
	[CR_CRIT_TAKEN_RANGED] = 25,
	[CR_CRIT_TAKEN_SPELL] = 25,
	[CR_HASTE_MELEE] = 10, -- changed in 2.2
	[CR_HASTE_RANGED] = 10, -- changed in 2.2
	[CR_HASTE_SPELL] = 10, -- changed in 2.2
	[CR_WEAPON_SKILL_MAINHAND] = 2.5,
	[CR_WEAPON_SKILL_OFFHAND] = 2.5,
	[CR_WEAPON_SKILL_RANGED] = 2.5,
	[CR_EXPERTISE] = 2.5,
	[CR_ARMOR_PENETRATION] = 4.69512176513672 / 1.25, --1.25 in gtOCTClassCombatRatingScalar.csv
}
Level34Ratings = {
	[CR_DEFENSE_SKILL] = true,
	[CR_DODGE] = true,
	[CR_PARRY] = true,
	[CR_BLOCK] = true,
	[CR_CRIT_TAKEN_MELEE] = true,
	[CR_CRIT_TAKEN_RANGED] = true,
	[CR_CRIT_TAKEN_SPELL] = true,
}
else
RatingBase = {
	[CR_WEAPON_SKILL] = 2.5,
	[CR_DEFENSE_SKILL] = 1.5,
	[CR_DODGE] = 13.8,
	[CR_PARRY] = 13.8,
	[CR_BLOCK] = 6.9,
	[CR_HIT_MELEE] = 9.37931,
	[CR_HIT_RANGED] = 9.37931,
	[CR_HIT_SPELL] = 8,
	[CR_CRIT_MELEE] = 14,
	[CR_CRIT_RANGED] = 14,
	[CR_CRIT_SPELL] = 14,
	[CR_HIT_TAKEN_MELEE] = 10, -- hit avoidance
	[CR_HIT_TAKEN_RANGED] = 10,
	[CR_HIT_TAKEN_SPELL] = 8,
	[COMBAT_RATING_RESILIENCE_CRIT_TAKEN] = 21.5625, -- resilience
	[COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN] = 21.5625,
	[CR_CRIT_TAKEN_SPELL] = 28.75,
	[CR_HASTE_MELEE] = 10, -- changed in 2.2
	[CR_HASTE_RANGED] = 10, -- changed in 2.2
	[CR_HASTE_SPELL] = 10, -- changed in 2.2
	[CR_WEAPON_SKILL_MAINHAND] = 2.5,
	[CR_WEAPON_SKILL_OFFHAND] = 2.5,
	[CR_WEAPON_SKILL_RANGED] = 2.5,
	[CR_EXPERTISE] = 2.34483,
	[CR_ARMOR_PENETRATION] = 4.69512176513672 / 1.25, -- still manually calculated cause its still 4.69 in dbc
	[CR_MASTERY] = 14,
}
Level34Ratings = {
	[CR_DEFENSE_SKILL] = true,
	[CR_DODGE] = true,
	[CR_PARRY] = true,
	[CR_BLOCK] = true,
	[COMBAT_RATING_RESILIENCE_CRIT_TAKEN] = true,
	[COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN] = true,
	[CR_CRIT_TAKEN_SPELL] = true,
}
end
-- 80-85 H data
local H = {
  [80] = 3.2789989471436,
  [81] = 4.3056015014648,
  [82] = 5.6539749145508,
  [83] = 7.4275451660156,
  [84] = 9.7527236938477,
  [85] = 12.8057159423828,
}
--[[
3.1.0
- Armor Penetration Rating: All classes now receive 25% more benefit from Armor Penetration Rating. 
- Haste Rating: shamans7, paladins2, druids10, and death knights6 now receive 30% more melee haste from Haste Rating. 
--]]
local ExtraHasteClasses = {
	[2] = true, -- PALADIN
	[6] = true, -- DK
	[7] = true, -- SHAMAN
	[10] = true, -- DRUID
}

--[[
3.2.0
- Dodge Rating: The amount of dodge rating required per percentage of dodge has been increased by 15%.
- Parry Rating: The amount of parry rating required per percentage of parry has been reduced by 8%.
- Resilience: The amount of resilience needed to reduce critical strike chance, critical strike damage and overall damage has been increased by 15%.
--]]
if wowBuildNo >= 10147 and toc < 40000 then
	RatingBase[CR_DODGE] = 13.8
	RatingBase[CR_PARRY] = 13.8
	RatingBase[CR_CRIT_TAKEN_MELEE] = 28.75
	RatingBase[CR_CRIT_TAKEN_RANGED] = 28.75
	RatingBase[CR_CRIT_TAKEN_SPELL] = 28.75
end
--[[
3.2.2.10371
- Armor Penetration Rating: All classes now receive 10% more benefit from Armor Penetration Rating. down from 25%
--]]
if wowBuildNo >= 10371 then
	RatingBase[CR_ARMOR_PENETRATION] = 4.69512176513672 / 1.1
end

-- Formula reverse engineered by Whitetooth (hotdogee [at] gmail [dot] com)
-- Percentage = Rating / RatingBase / H
--
-- Level 1 to 10:  H = 2/52
-- Level 10 to 60: H = (level-8)/52
-- Level 60 to 70: H = 82/(262-3*level)
-- Level 70 to 80: H = (82/52)*(131/63)^((level-70)/10)
--
--  Parry Rating, Defense Rating, Block Rating and Resilience: Low-level players
--   will now convert these ratings into their corresponding defensive
--   stats at the same rate as level 34 players.
--  Dodge Rating too
function StatLogic:GetEffectFromRating(rating, id, level, class)
	-- if id is stringID then convert to numberID
	if type(id) == "string" and RatingNameToID[id] then
		id = RatingNameToID[id]
	end
	-- check for invalid input
	if type(rating) ~= "number" or id < 1 or id > 26 then return 0 end
	-- defaults to player level if not given
	level = level or UnitLevel("player")
	-- argCheck for invalid input
	self:argCheck(class, 2, "nil", "string", "number")
	-- if class is a class string, convert to class id
	if type(class) == "string" and ClassNameToID[strupper(class)] ~= nil then
		class = ClassNameToID[strupper(class)]
	-- if class is invalid input, default to player class
	elseif type(class) ~= "number" or class < 1 or class > 10 then
		class = ClassNameToID[playerClass]
	end
	--2.4.3  Parry Rating, Defense Rating, and Block Rating: Low-level players
	--   will now convert these ratings into their corresponding defensive
	--   stats at the same rate as level 34 players.
	if level < 34 and Level34Ratings[id] then
		level = 34
	end
	-- Haste Rating: shamans, paladins, druids, and death knights now receive 30% more melee haste from Haste Rating. 
	if (id == CR_HASTE_MELEE) and ExtraHasteClasses[class] then
		rating = rating * 1.3
	end
  if level >= 80 and level <= 85 then
		return rating/RatingBase[id]/H[level], RatingIDToConvertedStat[id]
	elseif level >= 70 then
		return rating/RatingBase[id]/((82/52)*(131/63)^((level-70)/10)), RatingIDToConvertedStat[id]
	elseif level >= 60 then
		return rating/RatingBase[id]/(82/(262-3*level)), RatingIDToConvertedStat[id]
	elseif level >= 10 then
		return rating/RatingBase[id]/((level-8)/52), RatingIDToConvertedStat[id]
	else
		return rating/RatingBase[id]/(2/52), RatingIDToConvertedStat[id]
	end
end


--[[---------------------------------
	:GetAPPerStr([class])
-------------------------------------
Notes:
	* Returns the attack power per strength for given class.
	* Player level does not effect attack power per strength.
Arguments:
	[optional] string or number - ClassID or "ClassName". Default: PlayerClass<br>See :GetClassIdOrName(class) for valid class values.
Returns:
	; ap : number - Attack power per strength
	; statid : string - "AP"
Example:
	local ap = StatLogic:GetAPPerStr()
	local ap = StatLogic:GetAPPerStr("WARRIOR")
-----------------------------------]]

local APPerStr = {
	2, 2, 1, 1, 1, 2, 1, 1, 1, 2,
	--["WARRIOR"] = 2,
	--["PALADIN"] = 2,
	--["HUNTER"] = 1,
	--["ROGUE"] = 1,
	--["PRIEST"] = 1,
	--["DEATHKNIGHT"] = 2,
	--["SHAMAN"] = 1,
	--["MAGE"] = 1,
	--["WARLOCK"] = 1,
	--["DRUID"] = 2,
}
if toc >= 40000 then
APPerStr = {
	2, 2, 1, 1, 2, 2, 1, 2, 2, 2,
	--["WARRIOR"] = 2,
	--["PALADIN"] = 2,
	--["HUNTER"] = 1,
	--["ROGUE"] = 1,
	--["PRIEST"] = 2,
	--["DEATHKNIGHT"] = 2,
	--["SHAMAN"] = 1,
	--["MAGE"] = 2,
	--["WARLOCK"] = 2,
	--["DRUID"] = 2,
}
end

function StatLogic:GetAPPerStr(class)
	-- argCheck for invalid input
	self:argCheck(class, 2, "nil", "string", "number")
	-- if class is a class string, convert to class id
	if type(class) == "string" and ClassNameToID[strupper(class)] ~= nil then
		class = ClassNameToID[strupper(class)]
	-- if class is invalid input, default to player class
	elseif type(class) ~= "number" or class < 1 or class > 10 then
		class = ClassNameToID[playerClass]
	end
	return APPerStr[class], "AP"
end


--[[---------------------------------
	:GetAPFromStr(str, [class])
-------------------------------------
Description:
	* Calculates the attack power from strength for given class.
Arguments:
	number - Strength
	[optional] string or number - ClassID or "ClassName". Default: PlayerClass<br>See :GetClassIdOrName(class) for valid class values.
Returns:
	; ap : number - Attack power
	; statid : string - "AP"
Examples:
	local ap = StatLogic:GetAPFromStr(1) -- GetAPPerStr
	local ap = StatLogic:GetAPFromStr(10)
	local ap = StatLogic:GetAPFromStr(10, "WARRIOR")
-----------------------------------]]
function StatLogic:GetAPFromStr(str, class)
	-- argCheck for invalid input
	self:argCheck(str, 2, "number")
	self:argCheck(class, 3, "nil", "string", "number")
	-- if class is a class string, convert to class id
	if type(class) == "string" and ClassNameToID[strupper(class)] ~= nil then
		class = ClassNameToID[strupper(class)]
	-- if class is invalid input, default to player class
	elseif type(class) ~= "number" or class < 1 or class > 10 then
		class = ClassNameToID[playerClass]
	end
	-- Calculate
	return str * APPerStr[class], "AP"
end


--[[---------------------------------
	:GetBlockValuePerStr([class])
-------------------------------------
Notes:
	* Gets the block value per strength for given class.
	* Player level does not effect block value per strength.
Arguments:
	[optional] string or number - ClassID or "ClassName". Default: PlayerClass<br>See :GetClassIdOrName(class) for valid class values.
Returns:
	; blockValue : number - Block value per strength
	; statid : string - "BLOCK_VALUE"
Example:
	local blockPerStr = StatLogic:GetBlockValuePerStr()
	local blockPerStr = StatLogic:GetBlockValuePerStr("WARRIOR")
-----------------------------------]]

local BlockValuePerStr = {
	0.5, 0.5, 0, 0, 0, 0, 0.5, 0, 0, 0,
	--["WARRIOR"] = 0.5,
	--["PALADIN"] = 0.5,
	--["HUNTER"] = 0,
	--["ROGUE"] = 0,
	--["PRIEST"] = 0,
	--["DEATHKNIGHT"] = 0,
	--["SHAMAN"] = 0.5,
	--["MAGE"] = 0,
	--["WARLOCK"] = 0,
	--["DRUID"] = 0,
}
if toc >= 40000 then
BlockValuePerStr = {
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	--["WARRIOR"] = 0.5,
	--["PALADIN"] = 0.5,
	--["HUNTER"] = 0,
	--["ROGUE"] = 0,
	--["PRIEST"] = 0,
	--["DEATHKNIGHT"] = 0,
	--["SHAMAN"] = 0.5,
	--["MAGE"] = 0,
	--["WARLOCK"] = 0,
	--["DRUID"] = 0,
}
end

function StatLogic:GetBlockValuePerStr(class)
	-- argCheck for invalid input
	self:argCheck(class, 2, "nil", "string", "number")
	-- if class is a class string, convert to class id
	if type(class) == "string" and ClassNameToID[strupper(class)] ~= nil then
		class = ClassNameToID[strupper(class)]
	-- if class is invalid input, default to player class
	elseif type(class) ~= "number" or class < 1 or class > 10 then
		class = ClassNameToID[playerClass]
	end
	return BlockValuePerStr[class], "BLOCK_VALUE"
end


--[[---------------------------------
	:GetBlockValueFromStr(str, [class])
-------------------------------------
Notes:
	* Calculates the block value from strength for given class.
	* Player level does not effect block value per strength.
Arguments:
	number - Strength
	[optional] string or number - ClassID or "ClassName". Default: PlayerClass<br>See :GetClassIdOrName(class) for valid class values.
Returns:
	; blockValue : number - Block value
	; statid : string - "BLOCK_VALUE"
Example:
	local bv = StatLogic:GetBlockValueFromStr(1) -- GetBlockValuePerStr
	local bv = StatLogic:GetBlockValueFromStr(10)
	local bv = StatLogic:GetBlockValueFromStr(10, "WARRIOR")
-----------------------------------]]

function StatLogic:GetBlockValueFromStr(str, class)
	-- argCheck for invalid input
	self:argCheck(str, 2, "number")
	self:argCheck(class, 3, "nil", "string", "number")
	-- if class is a class string, convert to class id
	if type(class) == "string" and ClassNameToID[strupper(class)] ~= nil then
		class = ClassNameToID[strupper(class)]
	-- if class is invalid input, default to player class
	elseif type(class) ~= "number" or class < 1 or class > 10 then
		class = ClassNameToID[playerClass]
	end
	-- Calculate
	return str * BlockValuePerStr[class] - 10, "BLOCK_VALUE"
end


--[[---------------------------------
	:GetAPPerAgi([class])
-------------------------------------
Notes:
	* Gets the attack power per agility for given class.
	* Player level does not effect attack power per agility.
	* Will check for Cat Form.
Arguments:
	[optional] string or number - ClassID or "ClassName". Default: PlayerClass<br>See :GetClassIdOrName(class) for valid class values.
Returns:
	; ap : number - Attack power per agility
	; statid : string - "AP"
Example:
	local apPerAgi = StatLogic:GetAPPerAgi()
	local apPerAgi = StatLogic:GetAPPerAgi("ROGUE")
-----------------------------------]]

local APPerAgi = {
	0, 0, 1, 1, 0, 0, 1, 0, 0, 0,
	--["WARRIOR"] = 0,
	--["PALADIN"] = 0,
	--["HUNTER"] = 1,
	--["ROGUE"] = 1,
	--["PRIEST"] = 0,
	--["DEATHKNIGHT"] = 0,
	--["SHAMAN"] = 1,
	--["MAGE"] = 0,
	--["WARLOCK"] = 0,
	--["DRUID"] = 0,
}

function StatLogic:GetAPPerAgi(class)
	-- argCheck for invalid input
	self:argCheck(class, 2, "nil", "string", "number")
	-- if class is a class string, convert to class id
	if type(class) == "string" and ClassNameToID[strupper(class)] ~= nil then
		class = ClassNameToID[strupper(class)]
	-- if class is invalid input, default to player class
	elseif type(class) ~= "number" or class < 1 or class > 10 then
		class = ClassNameToID[playerClass]
	end
	-- Check druid cat form
	if (class == 10) and PlayerHasAura((GetSpellInfo(32356))) then		-- ["Cat Form"]
    if toc >= 40000 then
      return 2
    else
      return 1
    end
	end
	return APPerAgi[class], "AP"
end


--[[---------------------------------
	:GetAPFromAgi(agi, [class])
-------------------------------------
Notes:
	* Calculates the attack power from agility for given class.
Arguments:
	number - Agility
	[optional] string or number - ClassID or "ClassName". Default: PlayerClass<br>See :GetClassIdOrName(class) for valid class values.
Returns:
	; ap : number - Attack power
	; statid : string - "AP"
Example:
	local ap = StatLogic:GetAPFromAgi(1) -- GetAPPerAgi
	local ap = StatLogic:GetAPFromAgi(10)
	local ap = StatLogic:GetAPFromAgi(10, "WARRIOR")
-----------------------------------]]

function StatLogic:GetAPFromAgi(agi, class)
	-- argCheck for invalid input
	self:argCheck(agi, 2, "number")
	self:argCheck(class, 3, "nil", "string", "number")
	-- if class is a class string, convert to class id
	if type(class) == "string" and ClassNameToID[strupper(class)] ~= nil then
		class = ClassNameToID[strupper(class)]
	-- if class is invalid input, default to player class
	elseif type(class) ~= "number" or class < 1 or class > 10 then
		class = ClassNameToID[playerClass]
	end
	-- Calculate
	return agi * APPerAgi[class], "AP"
end


--[[---------------------------------
	:GetRAPPerAgi([class])
-------------------------------------
Notes:
	* Gets the ranged attack power per agility for given class.
	* Player level does not effect ranged attack power per agility.
Arguments:
	[optional] string or number - ClassID or "ClassName". Default: PlayerClass<br>See :GetClassIdOrName(class) for valid class values.
Returns:
	; rap : number - Ranged attack power per agility
	; statid : string - "RANGED_AP"
Example:
	local rapPerAgi = StatLogic:GetRAPPerAgi()
	local rapPerAgi = StatLogic:GetRAPPerAgi("HUNTER")
-----------------------------------]]

local RAPPerAgi = {
	1, 0, 1, 1, 0, 0, 0, 0, 0, 0,
	--["WARRIOR"] = 1,
	--["PALADIN"] = 0,
	--["HUNTER"] = 1,
	--["ROGUE"] = 1,
	--["PRIEST"] = 0,
	--["DEATHKNIGHT"] = 0,
	--["SHAMAN"] = 0,
	--["MAGE"] = 0,
	--["WARLOCK"] = 0,
	--["DRUID"] = 0,
}

function StatLogic:GetRAPPerAgi(class)
	-- argCheck for invalid input
	self:argCheck(class, 2, "nil", "string", "number")
	-- if class is a class string, convert to class id
	if type(class) == "string" and ClassNameToID[strupper(class)] ~= nil then
		class = ClassNameToID[strupper(class)]
	-- if class is invalid input, default to player class
	elseif type(class) ~= "number" or class < 1 or class > 10 then
		class = ClassNameToID[playerClass]
	end
	return RAPPerAgi[class], "RANGED_AP"
end


--[[---------------------------------
	:GetRAPFromAgi(agi, [class])
-------------------------------------
Notes:
	* Calculates the ranged attack power from agility for given class.
Arguments:
	number - Agility
	[optional] string or number - ClassID or "ClassName". Default: PlayerClass<br>See :GetClassIdOrName(class) for valid class values.
Returns:
	; rap : number - Ranged attack power
	; statid : string - "RANGED_AP"
Example:
	local rap = StatLogic:GetRAPFromAgi(1) -- GetRAPPerAgi
	local rap = StatLogic:GetRAPFromAgi(10)
	local rap = StatLogic:GetRAPFromAgi(10, "WARRIOR")
-----------------------------------]]

function StatLogic:GetRAPFromAgi(agi, class)
	-- argCheck for invalid input
	self:argCheck(agi, 2, "number")
	self:argCheck(class, 3, "nil", "string", "number")
	-- if class is a class string, convert to class id
	if type(class) == "string" and ClassNameToID[strupper(class)] ~= nil then
		class = ClassNameToID[strupper(class)]
	-- if class is invalid input, default to player class
	elseif type(class) ~= "number" or class < 1 or class > 10 then
		class = ClassNameToID[playerClass]
	end
	-- Calculate
	return agi * RAPPerAgi[class], "RANGED_AP"
end


--[[---------------------------------
	:GetBaseDodge([class])
-------------------------------------
Notes:
	* BaseDodge values derived by Whitetooth (hotdogee [at] gmail [dot] com)
	* Gets the base dodge percentage for given class.
	* Base dodge is the amount of dodge you have with 0 Agility, independent of level.
Arguments:
	[optional] string or number - ClassID or "ClassName". Default: PlayerClass<br>See :GetClassIdOrName(class) for valid class values.
Returns:
	; dodge : number - Base dodge in percentages
	; statid : string - "DODGE"
Example:
	local baseDodge = StatLogic:GetBaseDodge()
	local baseDodge = StatLogic:GetBaseDodge("WARRIOR")
-----------------------------------]]
-- local BaseDodge declared at StatLogic:GetDodgeChanceBeforeDR()
-- Numbers derived by Whitetooth (hotdogee [at] gmail [dot] com)
BaseDodge = {
	3.4636, 3.2685, -5.4500, -0.5900, 3.1830, 3.4636, 1.6750, 3.4575, 2.0350, 4.951,
	--["WARRIOR"] =     3.4636,
	--["PALADIN"] =     3.2685,
	--["HUNTER"] =     -5.4500,
	--["ROGUE"] =      -0.5900,
	--["PRIEST"] =      3.1830,
	--["DEATHKNIGHT"] = 3.4636,
	--["SHAMAN"] =      1.6750,
	--["MAGE"] =        3.4575,
	--["WARLOCK"] =     2.0350,
	--["DRUID"] =       4.951,
}
if wowBuildNo >= 10147 then
BaseDodge = {
	3.6640, 3.4943, -4.0873, 2.0957, 3.4178, 3.6640, 2.1080, 3.6587, 2.4211, 5.6097,
	--["WARRIOR"] =     3.6640,
	--["PALADIN"] =     3.4943,
	--["HUNTER"] =     -4.0873,
	--["ROGUE"] =       2.0957,
	--["PRIEST"] =      3.4178,
	--["DEATHKNIGHT"] = 3.6640,
	--["SHAMAN"] =      2.1080,
	--["MAGE"] =        3.6587,
	--["WARLOCK"] =     2.4211,
	--["DRUID"] =       5.6097,
}
end
if toc >= 40000 then
BaseDodge = {
	3.7580, 3.6520, -5.450, -0.590, 3.1830, 3.6640, 1.6750, 3.4575, 2.0350, 4.9510,
	--["WARRIOR"] =     3.7580,
	--["PALADIN"] =     3.6520,
	--["HUNTER"] =      -5.450,
	--["ROGUE"] =       -0.590,
	--["PRIEST"] =      3.1830,
	--["DEATHKNIGHT"] = 3.6640,
	--["SHAMAN"] =      1.6750,
	--["MAGE"] =        3.4575,
	--["WARLOCK"] =     2.0350,
	--["DRUID"] =       4.9510,
}
end

function StatLogic:GetBaseDodge(class)
	-- argCheck for invalid input
	self:argCheck(class, 2, "nil", "string", "number")
	-- if class is a class string, convert to class id
	if type(class) == "string" and ClassNameToID[strupper(class)] ~= nil then
		class = ClassNameToID[strupper(class)]
	-- if class is invalid input, default to player class
	elseif type(class) ~= "number" or class < 1 or class > 10 then
		class = ClassNameToID[playerClass]
	end
	return BaseDodge[class], "DODGE"
end

--[[---------------------------------
	:GetDodgePerAgi()
-------------------------------------
Arguments:
	None
Returns:
	; dodge : number - Dodge percentage per agility
	; statid : string - "DODGE"
Notes:
	* Formula by Whitetooth (hotdogee [at] gmail [dot] com)
	* Calculates the dodge percentage per agility for your current class and level.
	* Only works for your currect class and current level, does not support class and level args.
	* Calculations got a bit more complicated with the introduction of the avoidance DR in WotLK, these are the values we know or can be calculated easily:
	** D'=Total Dodge% after DR
	** D_r=Dodge from Defense and Dodge Rating before DR
	** D_b=Dodge unaffected by DR (BaseDodge + Dodge from talent/buffs + Lower then normal defense correction)
	** A=Total Agility
	** A_b=Base Agility (This is what you have with no gear on)
	** A_g=Total Agility - Base Agility
	** Let d be the Dodge/Agi value we are going to calculate.

	#  1     1     k
	# --- = --- + ---
	#  x'    c     x

	# x'=D'-D_b-A_b*d
	# x=A_g*d+D_r

	# 1/(D'-D_b-A_b*d)=1/C_d+k/(A_g*d+D_r)=(A_g*d+D_r+C_d*k)/(C_d*A_g*d+C_d*D_r)

	# C_d*A_g*d+C_d*D_r=[(D'-D_b)-A_b*d]*[Ag*d+(D_r+C_d*k)]

	# After rearranging the terms, we get an equation of type a*d^2+b*d+c where
	# a=-A_g*A_b
	# b=A_g(D'-D_b)-A_b(D_r+C_d*k)-C_dA_g
	# c=(D'-D_b)(D_r+C_d*k)-C_d*D_r
	** Dodge/Agi=(-b-(b^2-4ac)^0.5)/(2a)
Example:
	local dodge, statid = StatLogic:GetDodgePerAgi()
-----------------------------------]]

local DodgePerAgiStatic = {
	0.0118, 0.0167, 0.0116, 0.0209, 0.0167, 0.0118, 0.0167, 0.017, 0.0167, 0.0209, 
	--["WARRIOR"] =     0.0118,
	--["PALADIN"] =     0.0167,
	--["HUNTER"] =      0.0116,
	--["ROGUE"] =       0.0209,
	--["PRIEST"] =      0.0167,
	--["DEATHKNIGHT"] = 0.0118,
	--["SHAMAN"] =      0.0167,
	--["MAGE"] =        0.017, 
	--["WARLOCK"] =     0.0167,
	--["DRUID"] =       0.0209,
}
if toc >= 40000 then
DodgePerAgiStatic = {
	0.0135962, 0.0192366, 0.0133266, 0.0240537, 0.0192366, 0.0135962, 0.0192366, 0.0195253, 0.0192366, 0.0240458, 
	--["WARRIOR"] =     0.0135962,
	--["PALADIN"] =     0.0192366,
	--["HUNTER"] =      0.0133266,
	--["ROGUE"] =       0.0240537,
	--["PRIEST"] =      0.0192366,
	--["DEATHKNIGHT"] = 0.0135962,
	--["SHAMAN"] =      0.0192366,
	--["MAGE"] =        0.0195253, 
	--["WARLOCK"] =     0.0192366,
	--["DRUID"] =       0.0240458,
}
end

local ModAgiClasses = {
	["DRUID"] = true,
	["HUNTER"] = true,
	["ROGUE"] = true,
}
local BoK = GetSpellInfo(20217)
local GBoK = GetSpellInfo(25898) -- 4.0 removed
function StatLogic:GetDodgePerAgi()
	local level = UnitLevel("player")
	local class = ClassNameToID[playerClass]
	if level == 80 and DodgePerAgiStatic[class] then
		return DodgePerAgiStatic[class], "DODGE"
	end
	-- Collect data
	local D_dr = GetDodgeChance()
	local dodgeFromDodgeRating = self:GetEffectFromRating(GetCombatRating(CR_DODGE), CR_DODGE, level)
	local baseDefense, modDefense = UnitDefense("player")
  if toc >= 40000 then
    baseDefense, modDefense = level * 5, 0
  end
	local dodgeFromModDefense = modDefense * 0.04
	local D_r = dodgeFromDodgeRating + dodgeFromModDefense
	local D_b = BaseDodge[class] + self:GetStatMod("ADD_DODGE") + (baseDefense - level * 5) * 0.04
	local stat, effectiveStat, posBuff, negBuff = UnitStat("player", 2) -- 2 = Agility
	-- Talents that modify AGI will not add to posBuff, so we need to calculate baseAgi
	-- But Kings added AGi will add to posBuff, so we need to check for Kings
	local modAgi = 1
	if ModAgiClasses[playerClass] then
		modAgi = self:GetStatMod("MOD_AGI")
		if PlayerHasAura(BoK) or PlayerHasAura(GBoK) then
			modAgi = modAgi - 0.1
		end
	end
	local A = effectiveStat
	local A_b = ceil((stat - posBuff - negBuff) / modAgi)
	local A_g = A - A_b
	local C = C_d[class]
	local k = K[class]
	-- Solve a*x^2+b*x+c
	local a = -A_g*A_b
	local b = A_g*(D_dr-D_b)-A_b*(D_r+C*k)-C*A_g
	local c = (D_dr-D_b)*(D_r+C*k)-C*D_r
	--RatingBuster:Print(a, b, c, D_b, D_r, A_b, A_g, C, k)
	local dodgePerAgi = (-b-(b^2-4*a*c)^0.5)/(2*a)
	if a == 0 then
		dodgePerAgi = -c / b
	end
	--return dodgePerAgi
	--return floor(dodgePerAgi*10000+0.5)/10000, "DODGE"
	return dodgePerAgi, "DODGE"
end

--[[---------------------------------
	:GetDodgeFromAgi(agi)
-------------------------------------
Notes:
	* Calculates the dodge chance from agility for your current class and level.
	* Only works for your currect class and current level, does not support class and level args.
Arguments:
	number - Agility
Returns:
	; dodge : number - Dodge percentage
	; statid : string - "DODGE"
Example:
	local dodge = StatLogic:GetDodgeFromAgi(1) -- GetDodgePerAgi
	local dodge = StatLogic:GetDodgeFromAgi(10)
-----------------------------------]]

function StatLogic:GetDodgeFromAgi(agi)
	-- argCheck for invalid input
	self:argCheck(agi, 2, "number")
	-- Calculate
	return agi * self:GetDodgePerAgi(), "DODGE"
end


--[[---------------------------------
	:GetCritFromAgi(agi, [class], [level])
-------------------------------------
Notes:
	* CritPerAgi values reverse engineered by Whitetooth (hotdogee [at] gmail [dot] com)
	* Calculates the melee/ranged crit chance from agility for given class and level.
Arguments:
	number - Agility
	[optional] string or number - ClassID or "ClassName". Default: PlayerClass<br>See :GetClassIdOrName(class) for valid class values.
	[optional] number - Level used in calculations. Default: player's level
Returns:
	; crit : number - Melee/ranged crit percentage
	; statid : string - "MELEE_CRIT"
Example:
	local crit = StatLogic:GetCritFromAgi(1) -- GetCritPerAgi
	local crit = StatLogic:GetCritFromAgi(10)
	local crit = StatLogic:GetCritFromAgi(10, "WARRIOR")
	local crit = StatLogic:GetCritFromAgi(10, nil, 70)
	local crit = StatLogic:GetCritFromAgi(10, "WARRIOR", 70)
-----------------------------------]]

-- Numbers reverse engineered by Whitetooth (hotdogee [at] gmail [dot] com)
local CritPerAgi
if toc < 40000 then
CritPerAgi = {
	[1] = {0.2587, 0.2164, 0.2840, 0.4476, 0.0912, 0.2587, 0.1039, 0.0773, 0.1189, 0.1262, },
	[2] = {0.2264, 0.2164, 0.2834, 0.4290, 0.0912, 0.2264, 0.1039, 0.0773, 0.1189, 0.1262, },
	[3] = {0.2264, 0.2164, 0.2711, 0.4118, 0.0912, 0.2264, 0.0990, 0.0773, 0.1132, 0.1202, },
	[4] = {0.2264, 0.1924, 0.2530, 0.3813, 0.0868, 0.2264, 0.0990, 0.0736, 0.1132, 0.1202, },
	[5] = {0.2264, 0.1924, 0.2430, 0.3677, 0.0868, 0.2264, 0.0945, 0.0736, 0.1132, 0.1148, },
	[6] = {0.2012, 0.1924, 0.2337, 0.3550, 0.0868, 0.2012, 0.0945, 0.0736, 0.1081, 0.1148, },
	[7] = {0.2012, 0.1924, 0.2251, 0.3321, 0.0868, 0.2012, 0.0945, 0.0736, 0.1081, 0.1098, },
	[8] = {0.2012, 0.1732, 0.2171, 0.3217, 0.0829, 0.2012, 0.0903, 0.0736, 0.1081, 0.1098, },
	[9] = {0.2012, 0.1732, 0.2051, 0.3120, 0.0829, 0.2012, 0.0903, 0.0736, 0.1034, 0.1052, },
	[10] = {0.2012, 0.1732, 0.1984, 0.2941, 0.0829, 0.2012, 0.0866, 0.0703, 0.1034, 0.0971, },
	[11] = {0.1811, 0.1732, 0.1848, 0.2640, 0.0829, 0.1811, 0.0866, 0.0703, 0.0991, 0.0935, },
	[12] = {0.1811, 0.1732, 0.1670, 0.2394, 0.0793, 0.1811, 0.0831, 0.0703, 0.0991, 0.0935, },
	[13] = {0.1646, 0.1574, 0.1547, 0.2145, 0.0793, 0.1646, 0.0831, 0.0703, 0.0991, 0.0902, },
	[14] = {0.1646, 0.1574, 0.1441, 0.1980, 0.0793, 0.1646, 0.0799, 0.0703, 0.0959, 0.0902, },
	[15] = {0.1509, 0.1443, 0.1330, 0.1775, 0.0793, 0.1509, 0.0770, 0.0672, 0.0944, 0.0842, },
	[16] = {0.1509, 0.1443, 0.1267, 0.1660, 0.0760, 0.1509, 0.0742, 0.0672, 0.0928, 0.0842, },
	[17] = {0.1509, 0.1443, 0.1194, 0.1560, 0.0760, 0.1509, 0.0742, 0.0672, 0.0914, 0.0814, },
	[18] = {0.1393, 0.1332, 0.1117, 0.1450, 0.0760, 0.1393, 0.0717, 0.0672, 0.0899, 0.0789, },
	[19] = {0.1393, 0.1332, 0.1060, 0.1355, 0.0729, 0.1393, 0.0717, 0.0672, 0.0885, 0.0789, },
	[20] = {0.1293, 0.1237, 0.0998, 0.1271, 0.0729, 0.1293, 0.0670, 0.0644, 0.0871, 0.0701, },
	[21] = {0.1293, 0.1237, 0.0962, 0.1197, 0.0729, 0.1293, 0.0670, 0.0644, 0.0857, 0.0701, },
	[22] = {0.1293, 0.1237, 0.0910, 0.1144, 0.0729, 0.1293, 0.0649, 0.0644, 0.0844, 0.0682, },
	[23] = {0.1207, 0.1154, 0.0872, 0.1084, 0.0701, 0.1207, 0.0649, 0.0644, 0.0831, 0.0664, },
	[24] = {0.1132, 0.1082, 0.0829, 0.1040, 0.0701, 0.1132, 0.0630, 0.0618, 0.0818, 0.0664, },
	[25] = {0.1132, 0.1082, 0.0797, 0.0980, 0.0701, 0.1132, 0.0611, 0.0618, 0.0805, 0.0631, },
	[26] = {0.1065, 0.1082, 0.0767, 0.0936, 0.0675, 0.1065, 0.0594, 0.0618, 0.0792, 0.0631, },
	[27] = {0.1065, 0.1019, 0.0734, 0.0903, 0.0675, 0.1065, 0.0594, 0.0618, 0.0780, 0.0616, },
	[28] = {0.1006, 0.1019, 0.0709, 0.0865, 0.0675, 0.1006, 0.0577, 0.0618, 0.0768, 0.0601, },
	[29] = {0.1006, 0.0962, 0.0680, 0.0830, 0.0651, 0.1006, 0.0577, 0.0595, 0.0756, 0.0601, },
	[30] = {0.0953, 0.0962, 0.0654, 0.0792, 0.0651, 0.0953, 0.0547, 0.0595, 0.0745, 0.0549, },
	[31] = {0.0953, 0.0911, 0.0637, 0.0768, 0.0651, 0.0953, 0.0547, 0.0595, 0.0733, 0.0537, },
	[32] = {0.0905, 0.0911, 0.0614, 0.0741, 0.0629, 0.0905, 0.0533, 0.0595, 0.0722, 0.0537, },
	[33] = {0.0905, 0.0866, 0.0592, 0.0715, 0.0629, 0.0905, 0.0520, 0.0573, 0.0711, 0.0526, },
	[34] = {0.0862, 0.0866, 0.0575, 0.0691, 0.0629, 0.0862, 0.0520, 0.0573, 0.0700, 0.0515, },
	[35] = {0.0862, 0.0825, 0.0556, 0.0664, 0.0608, 0.0862, 0.0495, 0.0573, 0.0690, 0.0505, },
	[36] = {0.0823, 0.0825, 0.0541, 0.0643, 0.0608, 0.0823, 0.0483, 0.0552, 0.0679, 0.0495, },
	[37] = {0.0823, 0.0825, 0.0524, 0.0628, 0.0608, 0.0823, 0.0483, 0.0552, 0.0669, 0.0485, },
	[38] = {0.0787, 0.0787, 0.0508, 0.0609, 0.0588, 0.0787, 0.0472, 0.0552, 0.0659, 0.0485, },
	[39] = {0.0787, 0.0787, 0.0493, 0.0592, 0.0588, 0.0787, 0.0472, 0.0552, 0.0649, 0.0476, },
	[40] = {0.0755, 0.0753, 0.0481, 0.0572, 0.0588, 0.0755, 0.0452, 0.0533, 0.0639, 0.0443, },
	[41] = {0.0724, 0.0753, 0.0470, 0.0556, 0.0570, 0.0724, 0.0442, 0.0533, 0.0630, 0.0435, },
	[42] = {0.0724, 0.0753, 0.0457, 0.0542, 0.0570, 0.0724, 0.0442, 0.0533, 0.0620, 0.0435, },
	[43] = {0.0696, 0.0721, 0.0444, 0.0528, 0.0553, 0.0696, 0.0433, 0.0533, 0.0611, 0.0428, },
	[44] = {0.0696, 0.0693, 0.0433, 0.0512, 0.0553, 0.0696, 0.0424, 0.0515, 0.0602, 0.0421, },
	[45] = {0.0671, 0.0693, 0.0421, 0.0497, 0.0553, 0.0671, 0.0416, 0.0515, 0.0593, 0.0407, },
	[46] = {0.0671, 0.0666, 0.0413, 0.0486, 0.0536, 0.0671, 0.0407, 0.0515, 0.0584, 0.0401, },
	[47] = {0.0647, 0.0666, 0.0402, 0.0474, 0.0536, 0.0647, 0.0400, 0.0499, 0.0576, 0.0401, },
	[48] = {0.0624, 0.0641, 0.0391, 0.0464, 0.0521, 0.0624, 0.0392, 0.0499, 0.0567, 0.0394, },
	[49] = {0.0624, 0.0641, 0.0382, 0.0454, 0.0521, 0.0624, 0.0392, 0.0499, 0.0559, 0.0388, },
	[50] = {0.0604, 0.0618, 0.0373, 0.0440, 0.0521, 0.0604, 0.0378, 0.0483, 0.0551, 0.0366, },
	[51] = {0.0604, 0.0597, 0.0366, 0.0431, 0.0507, 0.0604, 0.0371, 0.0483, 0.0543, 0.0361, },
	[52] = {0.0584, 0.0597, 0.0358, 0.0422, 0.0507, 0.0584, 0.0365, 0.0483, 0.0535, 0.0356, },
	[53] = {0.0566, 0.0577, 0.0350, 0.0412, 0.0493, 0.0566, 0.0365, 0.0468, 0.0527, 0.0351, },
	[54] = {0.0566, 0.0577, 0.0341, 0.0404, 0.0493, 0.0566, 0.0358, 0.0468, 0.0519, 0.0351, },
	[55] = {0.0549, 0.0559, 0.0334, 0.0394, 0.0480, 0.0549, 0.0346, 0.0468, 0.0512, 0.0341, },
	[56] = {0.0549, 0.0559, 0.0328, 0.0386, 0.0480, 0.0549, 0.0341, 0.0455, 0.0504, 0.0337, },
	[57] = {0.0533, 0.0541, 0.0321, 0.0378, 0.0468, 0.0533, 0.0335, 0.0455, 0.0497, 0.0332, },
	[58] = {0.0517, 0.0525, 0.0314, 0.0370, 0.0468, 0.0517, 0.0335, 0.0455, 0.0490, 0.0328, },
	[59] = {0.0517, 0.0525, 0.0307, 0.0364, 0.0456, 0.0517, 0.0330, 0.0442, 0.0483, 0.0324, },
	[60] = {0.0503, 0.0509, 0.0301, 0.0355, 0.0456, 0.0503, 0.0320, 0.0442, 0.0476, 0.0308, },
	[61] = {0.0477, 0.0495, 0.0297, 0.0334, 0.0445, 0.0477, 0.0310, 0.0442, 0.0469, 0.0299, },
	[62] = {0.0453, 0.0481, 0.0290, 0.0322, 0.0446, 0.0453, 0.0304, 0.0442, 0.0462, 0.0295, },
	[63] = {0.0431, 0.0468, 0.0284, 0.0307, 0.0443, 0.0431, 0.0294, 0.0429, 0.0455, 0.0285, },
	[64] = {0.0421, 0.0456, 0.0279, 0.0296, 0.0434, 0.0421, 0.0285, 0.0429, 0.0449, 0.0279, },
	[65] = {0.0402, 0.0444, 0.0273, 0.0286, 0.0427, 0.0402, 0.0281, 0.0429, 0.0442, 0.0274, },
	[66] = {0.0385, 0.0444, 0.0270, 0.0276, 0.0421, 0.0385, 0.0273, 0.0418, 0.0436, 0.0269, },
	[67] = {0.0370, 0.0422, 0.0264, 0.0268, 0.0415, 0.0370, 0.0267, 0.0418, 0.0430, 0.0265, },
	[68] = {0.0355, 0.0422, 0.0259, 0.0262, 0.0413, 0.0355, 0.0261, 0.0418, 0.0424, 0.0258, },
	[69] = {0.0342, 0.0412, 0.0254, 0.0256, 0.0412, 0.0342, 0.0255, 0.0407, 0.0418, 0.0254, },
	[70] = {0.0335, 0.0403, 0.0250, 0.0250, 0.0401, 0.0335, 0.0250, 0.0407, 0.0412, 0.0250, },
	[71] = {0.0312, 0.0368, 0.0232, 0.0232, 0.0372, 0.0312, 0.0232, 0.0377, 0.0384, 0.0232, },
	[72] = {0.0287, 0.0346, 0.0216, 0.0216, 0.0344, 0.0287, 0.0216, 0.0351, 0.0355, 0.0216, },
	[73] = {0.0266, 0.0321, 0.0201, 0.0201, 0.0320, 0.0266, 0.0201, 0.0329, 0.0330, 0.0201, },
	[74] = {0.0248, 0.0299, 0.0187, 0.0187, 0.0299, 0.0248, 0.0187, 0.0303, 0.0309, 0.0187, },
	[75] = {0.0232, 0.0275, 0.0173, 0.0173, 0.0276, 0.0232, 0.0173, 0.0281, 0.0287, 0.0173, },
	[76] = {0.0216, 0.0258, 0.0161, 0.0161, 0.0257, 0.0216, 0.0161, 0.0262, 0.0264, 0.0161, },
	[77] = {0.0199, 0.0240, 0.0150, 0.0150, 0.0240, 0.0199, 0.0150, 0.0242, 0.0245, 0.0150, },
	[78] = {0.0185, 0.0222, 0.0139, 0.0139, 0.0222, 0.0185, 0.0139, 0.0227, 0.0229, 0.0139, },
	[79] = {0.0172, 0.0206, 0.0129, 0.0129, 0.0207, 0.0172, 0.0129, 0.0209, 0.0212, 0.0129, },
	[80] = {0.0160, 0.0192, 0.0120, 0.0120, 0.0192, 0.0160, 0.0120, 0.0196, 0.0198, 0.0120, },
	[81] = {0.0148, 0.0180, 0.0131, 0.0112, 0.0385, 0.0148, 0.0371, 0.0184, 0.0366, 0.0376, },
	[82] = {0.0138, 0.0168, 0.0129, 0.0105, 0.0385, 0.0138, 0.0363, 0.0174, 0.0366, 0.0369, },
	[83] = {0.0128, 0.0159, 0.0127, 0.0099, 0.0377, 0.0128, 0.0359, 0.0164, 0.0361, 0.0366, },
	[84] = {0.0120, 0.0151, 0.0124, 0.0094, 0.0370, 0.0120, 0.0355, 0.0156, 0.0357, 0.0363, },
	[85] = {0.0111, 0.0142, 0.0123, 0.0089, 0.0370, 0.0111, 0.0347, 0.0149, 0.0349, 0.0353, },
	[86] = {0.0103, 0.0135, 0.0121, 0.0085, 0.0364, 0.0103, 0.0344, 0.0142, 0.0345, 0.0350, },
	[87] = {0.0096, 0.0128, 0.0119, 0.0081, 0.0357, 0.0096, 0.0340, 0.0136, 0.0341, 0.0347, },
	[88] = {0.0089, 0.0123, 0.0117, 0.0077, 0.0357, 0.0089, 0.0333, 0.0130, 0.0333, 0.0342, },
	[89] = {0.0083, 0.0118, 0.0115, 0.0074, 0.0351, 0.0083, 0.0330, 0.0125, 0.0330, 0.0339, },
	[90] = {0.0077, 0.0112, 0.0114, 0.0071, 0.0345, 0.0077, 0.0324, 0.0120, 0.0323, 0.0333, },
	[91] = {0.0072, 0.0108, 0.0112, 0.0068, 0.0345, 0.0072, 0.0320, 0.0115, 0.0319, 0.0328, },
	[92] = {0.0067, 0.0104, 0.0111, 0.0065, 0.0339, 0.0067, 0.0314, 0.0111, 0.0316, 0.0325, },
	[93] = {0.0062, 0.0100, 0.0109, 0.0063, 0.0333, 0.0062, 0.0311, 0.0107, 0.0313, 0.0320, },
	[94] = {0.0057, 0.0097, 0.0108, 0.0061, 0.0328, 0.0057, 0.0308, 0.0104, 0.0309, 0.0318, },
	[95] = {0.0053, 0.0093, 0.0106, 0.0059, 0.0328, 0.0053, 0.030, 0.0100, 0.0303, 0.0311, },
	[96] = {0.0050, 0.0090, 0.0105, 0.0057, 0.0323, 0.0050, 0.0297, 0.0097, 0.0300, 0.0308, },
	[97] = {0.0046, 0.0087, 0.0103, 0.0055, 0.0317, 0.0046, 0.0295, 0.0094, 0.0297, 0.0304, },
	[98] = {0.0043, 0.0084, 0.0102, 0.0053, 0.0313, 0.0043, 0.0289, 0.0091, 0.0291, 0.0299, },
	[99] = {0.0040, 0.0082, 0.0100, 0.0052, 0.0308, 0.0040, 0.0287, 0.0089, 0.0288, 0.0297, },
	[100] = {0.0037, 0.0080, 0.0099, 0.0050, 0.0308, 0.0037, 0.0282, 0.0086, 0.0283, 0.0291, },
}
else
CritPerAgi = {
  [1] = {0.24999999, 0.21740000, 0.28400000, 0.44760900, 0.09117500, 0.24999999, 0.10390000, 0.07730000, 0.11890000, 0.12622500, },
  [2] = {0.23809499, 0.20704800, 0.28343401, 0.42895800, 0.09117500, 0.23809499, 0.10390000, 0.07730000, 0.11890000, 0.12622500, },
  [3] = {0.23809499, 0.20704800, 0.27107401, 0.41180002, 0.09117500, 0.23809499, 0.09895239, 0.07730000, 0.11323800, 0.12021400, },
  [4] = {0.22727300, 0.19763601, 0.25299001, 0.38129601, 0.08683330, 0.22727300, 0.09895239, 0.07361900, 0.11323800, 0.12021400, },
  [5] = {0.21739099, 0.19763601, 0.24300499, 0.36767900, 0.08683330, 0.21739099, 0.09445450, 0.07361900, 0.11323800, 0.11475000, },
  [6] = {0.20833299, 0.18904300, 0.23373601, 0.35500000, 0.08683330, 0.20833299, 0.09445450, 0.07361900, 0.10809100, 0.11475000, },
  [7] = {0.20833299, 0.18904300, 0.22510700, 0.33209701, 0.08683330, 0.20833299, 0.09445450, 0.07361900, 0.10809100, 0.10976100, },
  [8] = {0.20000001, 0.18116700, 0.21705499, 0.32171900, 0.08288640, 0.20000001, 0.09034780, 0.07361900, 0.10809100, 0.10976100, },
  [9] = {0.19230800, 0.18116700, 0.20513700, 0.31196999, 0.08288640, 0.19230800, 0.09034780, 0.07361900, 0.10339100, 0.10518699, },
  [10] = {0.19230800, 0.17392000, 0.19836400, 0.29414301, 0.08288640, 0.19230800, 0.08658330, 0.07027270, 0.10339100, 0.09709620, },
  [11] = {0.18518500, 0.17392000, 0.18475300, 0.26397400, 0.08288640, 0.18518500, 0.08658330, 0.07027270, 0.09908330, 0.09350000, },
  [12] = {0.17857100, 0.16723101, 0.16697299, 0.23941901, 0.07928260, 0.17857100, 0.08312000, 0.07027270, 0.09908330, 0.09350000, },
  [13] = {0.16666700, 0.15528600, 0.15469900, 0.21447900, 0.07928260, 0.16666700, 0.08312000, 0.07027270, 0.09908330, 0.09016070, },
  [14] = {0.16129001, 0.15528600, 0.14408800, 0.19798100, 0.07928260, 0.16129001, 0.07992310, 0.07027270, 0.09588690, 0.09016070, },
  [15] = {0.15625000, 0.14493300, 0.13299300, 0.17750000, 0.07928260, 0.15625000, 0.07696300, 0.06721740, 0.09435100, 0.08415000, },
  [16] = {0.15151500, 0.14493300, 0.12666400, 0.16604800, 0.07597920, 0.15151500, 0.07421430, 0.06721740, 0.09284450, 0.08415000, },
  [17] = {0.14705900, 0.14025799, 0.11942200, 0.15598499, 0.07597920, 0.14705900, 0.07421430, 0.06721740, 0.09136670, 0.08143550, },
  [18] = {0.13888900, 0.13175800, 0.11166499, 0.14500000, 0.07597920, 0.13888900, 0.07165520, 0.06721740, 0.08991690, 0.07889060, },
  [19] = {0.13513500, 0.13175800, 0.10597800, 0.13546100, 0.07294000, 0.13513500, 0.07165520, 0.06721740, 0.08849440, 0.07889060, },
  [20] = {0.12820500, 0.12422900, 0.09980580, 0.12709900, 0.07294000, 0.12820500, 0.06703230, 0.06441670, 0.08709860, 0.07012500, },
  [21] = {0.12820500, 0.12077800, 0.09615530, 0.11970900, 0.07294000, 0.12820500, 0.06703230, 0.06441670, 0.08572890, 0.07012500, },
  [22] = {0.12500000, 0.12077800, 0.09103050, 0.11438900, 0.07294000, 0.12500000, 0.06493750, 0.06441670, 0.08438450, 0.06822970, },
  [23] = {0.11904800, 0.11442100, 0.08718610, 0.10836800, 0.07013460, 0.11904800, 0.06493750, 0.06441670, 0.08306500, 0.06643420, },
  [24] = {0.11627900, 0.11148700, 0.08293830, 0.10399000, 0.07013460, 0.11627900, 0.06296970, 0.06184000, 0.08176980, 0.06643420, },
  [25] = {0.11111100, 0.10870000, 0.07972230, 0.09804760, 0.07013460, 0.11111100, 0.06111760, 0.06184000, 0.08049830, 0.06311250, },
  [26] = {0.10869600, 0.10604900, 0.07674040, 0.09359090, 0.06753700, 0.10869600, 0.05937140, 0.06184000, 0.07924990, 0.06311250, },
  [27] = {0.10638300, 0.10352400, 0.07341370, 0.09030700, 0.06753700, 0.10638300, 0.05937140, 0.06184000, 0.07802420, 0.06157320, },
  [28] = {0.10204100, 0.10111600, 0.07086710, 0.08651260, 0.06753700, 0.10204100, 0.05772220, 0.06184000, 0.07682060, 0.06010710, },
  [29] = {0.10000000, 0.09881820, 0.06801100, 0.08302420, 0.06512500, 0.10000000, 0.05772220, 0.05946150, 0.07563860, 0.06010710, },
  [30] = {0.09615380, 0.09452170, 0.06537160, 0.07919230, 0.06512500, 0.09615380, 0.05468420, 0.05946150, 0.07447780, 0.05488040, },
  [31] = {0.09433960, 0.09251060, 0.06374390, 0.07682840, 0.06512500, 0.09433960, 0.05468420, 0.05946150, 0.07333770, 0.05371280, },
  [32] = {0.09259260, 0.09251060, 0.06141140, 0.07406470, 0.06287930, 0.09259260, 0.05328210, 0.05946150, 0.07221780, 0.05371280, },
  [33] = {0.08928570, 0.08873470, 0.05923970, 0.07149310, 0.06287930, 0.08928570, 0.05195000, 0.05725930, 0.07111760, 0.05259370, },
  [34] = {0.08771930, 0.08696000, 0.05754870, 0.06909400, 0.06287930, 0.08771930, 0.05195000, 0.05725930, 0.07003690, 0.05152040, },
  [35] = {0.08474580, 0.08361540, 0.05563030, 0.06641940, 0.06078330, 0.08474580, 0.04947620, 0.05725930, 0.06897500, 0.05049000, },
  [36] = {0.08333330, 0.08203770, 0.05412970, 0.06434370, 0.06078330, 0.08333330, 0.04832560, 0.05521430, 0.06793170, 0.04950000, },
  [37] = {0.08196720, 0.08203770, 0.05242280, 0.06277440, 0.06078330, 0.08196720, 0.04832560, 0.05521430, 0.06690650, 0.04854810, },
  [38] = {0.07936510, 0.07905450, 0.05081710, 0.06091720, 0.05882260, 0.07936510, 0.04722730, 0.05521430, 0.06589910, 0.04854810, },
  [39] = {0.07812500, 0.07764290, 0.04930400, 0.05916670, 0.05882260, 0.07812500, 0.04722730, 0.05521430, 0.06490910, 0.04763210, },
  [40] = {0.07575760, 0.07496550, 0.04811060, 0.05719440, 0.05882260, 0.07575760, 0.04517390, 0.05331030, 0.06393600, 0.04428950, },
  [41] = {0.07352940, 0.07369490, 0.04697090, 0.05564860, 0.05698440, 0.07352940, 0.04421280, 0.05331030, 0.06297960, 0.04352590, },
  [42] = {0.07246380, 0.07369490, 0.04566750, 0.05418420, 0.05698440, 0.07246380, 0.04421280, 0.05331030, 0.06203950, 0.04352590, },
  [43] = {0.07042250, 0.07127870, 0.04443200, 0.05279490, 0.05525760, 0.07042250, 0.04329170, 0.05331030, 0.06111540, 0.04278810, },
  [44] = {0.06944440, 0.07012900, 0.04325920, 0.05121890, 0.05525760, 0.06944440, 0.04240820, 0.05153330, 0.06020690, 0.04207500, },
  [45] = {0.06756760, 0.06793750, 0.04214440, 0.04973430, 0.05525760, 0.06756760, 0.04156000, 0.05153330, 0.05931370, 0.04071770, },
  [46] = {0.06666670, 0.06689230, 0.04125640, 0.04856130, 0.05363240, 0.06666670, 0.04074510, 0.05153330, 0.05843550, 0.04007140, },
  [47] = {0.06493510, 0.06587880, 0.04023690, 0.04744240, 0.05363240, 0.06493510, 0.03996150, 0.04987100, 0.05757210, 0.04007140, },
  [48] = {0.06329110, 0.06394120, 0.03910780, 0.04637390, 0.05210000, 0.06329110, 0.03920750, 0.04987100, 0.05672300, 0.03944530, },
  [49] = {0.06250000, 0.06301450, 0.03818660, 0.04535240, 0.05210000, 0.06250000, 0.03920750, 0.04987100, 0.05588810, 0.03883850, },
  [50] = {0.06097560, 0.06123940, 0.03730590, 0.04399570, 0.05210000, 0.06097560, 0.03778180, 0.04831250, 0.05506700, 0.03658700, },
  [51] = {0.05952380, 0.06038890, 0.03659920, 0.04307530, 0.05065280, 0.05952380, 0.03710710, 0.04831250, 0.05425950, 0.03606430, },
  [52] = {0.05882350, 0.05956160, 0.03578580, 0.04219260, 0.05065280, 0.05882350, 0.03645610, 0.04831250, 0.05346520, 0.03555630, },
  [53] = {0.05747130, 0.05797330, 0.03500600, 0.04118000, 0.04928380, 0.05747130, 0.03645610, 0.04684850, 0.05268400, 0.03506250, },
  [54] = {0.05617980, 0.05721050, 0.03413840, 0.04037250, 0.04928380, 0.05617980, 0.03582760, 0.04684850, 0.05191560, 0.03506250, },
  [55] = {0.05494510, 0.05574360, 0.03342470, 0.03944440, 0.04798680, 0.05494510, 0.03463330, 0.04684850, 0.05115970, 0.03411490, },
  [56] = {0.05434780, 0.05503800, 0.03284840, 0.03855810, 0.04798680, 0.05434780, 0.03406560, 0.04547060, 0.05041610, 0.03366000, },
  [57] = {0.05319150, 0.05435000, 0.03207870, 0.03784930, 0.04675640, 0.05319150, 0.03351610, 0.04547060, 0.04968460, 0.03321710, },
  [58] = {0.05208330, 0.05302440, 0.03144320, 0.03703240, 0.04675640, 0.05208330, 0.03351610, 0.04547060, 0.04896490, 0.03278570, },
  [59] = {0.05102040, 0.05238550, 0.03073430, 0.03637810, 0.04558750, 0.05102040, 0.03298410, 0.04417140, 0.04825680, 0.03236540, },
  [60] = {0.05000000, 0.05115290, 0.03014770, 0.03550000, 0.04558750, 0.05000000, 0.03196920, 0.04417140, 0.04756000, 0.03078660, },
  [61] = {0.04761900, 0.04940910, 0.02967120, 0.03343390, 0.04449120, 0.04761900, 0.03102490, 0.04417140, 0.04687440, 0.02988460, },
  [62] = {0.04545450, 0.04831110, 0.02903510, 0.03217750, 0.04458550, 0.04545450, 0.03040300, 0.04417140, 0.04619980, 0.02950110, },
  [63] = {0.04347830, 0.04726090, 0.02842440, 0.03063990, 0.04426580, 0.04347830, 0.02935380, 0.04294440, 0.04553590, 0.02849640, },
  [64] = {0.04166670, 0.04576840, 0.02791680, 0.02959690, 0.04344670, 0.04166670, 0.02848270, 0.04294440, 0.04488250, 0.02791070, },
  [65] = {0.04000000, 0.04482470, 0.02734930, 0.02861530, 0.04271900, 0.04000000, 0.02807010, 0.04294440, 0.04423950, 0.02738060, },
  [66] = {0.03846150, 0.04391920, 0.02695050, 0.02767470, 0.04207770, 0.03846150, 0.02734040, 0.04178380, 0.04360670, 0.02690250, },
  [67] = {0.03703700, 0.04262750, 0.02641880, 0.02680990, 0.04151880, 0.03703700, 0.02668210, 0.04178380, 0.04298380, 0.02647340, },
  [68] = {0.03571430, 0.04180770, 0.02590650, 0.02618690, 0.04133470, 0.03571430, 0.02608150, 0.04178380, 0.04237070, 0.02577280, },
  [69] = {0.03448280, 0.04101890, 0.02541250, 0.02560950, 0.04117830, 0.03448280, 0.02552060, 0.04068420, 0.04176730, 0.02537310, },
  [70] = {0.03333330, 0.04025930, 0.02499810, 0.02499880, 0.04014610, 0.03333330, 0.02499630, 0.04068420, 0.04117320, 0.02499810, },
  [71] = {0.03105590, 0.03716240, 0.02323340, 0.02323930, 0.03721430, 0.03105590, 0.02323170, 0.03770730, 0.03835480, 0.02323340, },
  [72] = {0.02873560, 0.03450790, 0.02159330, 0.02158280, 0.03440570, 0.02873560, 0.02159180, 0.03513640, 0.03549250, 0.02159330, },
  [73] = {0.02673800, 0.03220740, 0.02006910, 0.02006820, 0.03199120, 0.02673800, 0.02006760, 0.03289360, 0.03302780, 0.02006910, },
  [74] = {0.02487560, 0.02978080, 0.01865240, 0.01865040, 0.02989340, 0.02487560, 0.01865100, 0.03031370, 0.03088310, 0.01865240, },
  [75] = {0.02314810, 0.02769430, 0.01733570, 0.01733160, 0.02762880, 0.02314810, 0.01733440, 0.02810910, 0.02865060, 0.01733570, },
  [76] = {0.02145920, 0.02572780, 0.01611190, 0.01611110, 0.02568310, 0.02145920, 0.01611080, 0.02620340, 0.02642220, 0.01611190, },
  [77] = {0.01992030, 0.02389010, 0.01497460, 0.01496370, 0.02399340, 0.01992030, 0.01497350, 0.02415630, 0.02451550, 0.01497460, },
  [78] = {0.01851850, 0.02229740, 0.01391750, 0.01391220, 0.02223780, 0.01851850, 0.01391650, 0.02273530, 0.02286540, 0.01391750, },
  [79] = {0.01724140, 0.02070480, 0.01293510, 0.01293340, 0.02072160, 0.01724140, 0.01293410, 0.02089190, 0.02123210, 0.01293510, },
  [80] = {0.01602560, 0.01923890, 0.01202200, 0.01202690, 0.01919470, 0.01602560, 0.01202110, 0.01956960, 0.01981670, 0.01202200, },
  [81] = {0.01219510, 0.01463970, 0.00915552, 0.00915925, 0.01461810, 0.01220460, 0.00915486, 0.01486540, 0.01509170, 0.00915552, },
  [82] = {0.00929368, 0.01114870, 0.00697209, 0.00697493, 0.01113190, 0.00929400, 0.00697159, 0.01136760, 0.01149260, 0.00697209, },
  [83] = {0.00707214, 0.00849219, 0.00530727, 0.00530944, 0.00847380, 0.00707475, 0.00530689, 0.00863687, 0.00874836, 0.00530727, },
  [84] = {0.00538793, 0.00647024, 0.00404195, 0.00404360, 0.00645353, 0.00538804, 0.00404166, 0.00657872, 0.00666263, 0.00404195, },
  [85] = {0.00410509, 0.00492412, 0.00307831, 0.00307957, 0.00491496, 0.00410348, 0.00307809, 0.00500324, 0.00507420, 0.00307831, },
  [86] = {0.00192160, 0.00230663, 0.00144129, 0.00144188, 0.00230122, 0.00192160, 0.00144118, 0.00234598, 0.00237578, 0.00144129, },
  [87] = {0.00134916, 0.00161937, 0.00101208, 0.00101249, 0.00161592, 0.00134916, 0.00101200, 0.00164819, 0.00166828, 0.00101208, },
  [88] = {0.00094733, 0.00113733, 0.00071069, 0.00071098, 0.00113472, 0.00094733, 0.00071064, 0.00115719, 0.00117148, 0.00071069, },
  [89] = {0.00066525, 0.00079868, 0.01154730, 0.00049925, 0.03508770, 0.00066525, 0.03300000, 0.00081240, 0.03296700, 0.03388430, },
  [90] = {0.00046711, 0.00056081, 0.01136360, 0.00035058, 0.03448280, 0.00046711, 0.03235290, 0.00057048, 0.03225810, 0.03333330, },
  [91] = {0.00032802, 0.00039381, 0.01123600, 0.00024617, 0.03448280, 0.00032802, 0.03203880, 0.00040052, 0.03191490, 0.03280000, },
  [92] = {0.00023034, 0.00027652, 0.01106190, 0.00017286, 0.03389830, 0.00023034, 0.03142860, 0.00028130, 0.03157890, 0.03253970, },
  [93] = {0.00016174, 0.00019418, 0.01089320, 0.00012139, 0.03333330, 0.00016174, 0.03113210, 0.00019752, 0.03125000, 0.03203130, },
  [94] = {0.00011358, 0.00013635, 0.01075270, 0.00008524, 0.03278690, 0.00011358, 0.03084110, 0.00013869, 0.03092780, 0.03178290, },
  [95] = {0.00007976, 0.00009575, 0.01059320, 0.00005985, 0.03278690, 0.00007976, 0.03000000, 0.00009739, 0.03030300, 0.03106060, },
  [96] = {0.00005600, 0.00006723, 0.01046030, 0.00004203, 0.03225810, 0.00005600, 0.02972970, 0.00006839, 0.03000000, 0.03082710, },
  [97] = {0.00003933, 0.00004721, 0.01030930, 0.00002951, 0.03174600, 0.00003933, 0.02946430, 0.00004802, 0.02970300, 0.03037040, },
  [98] = {0.00002762, 0.00003315, 0.01016260, 0.00002072, 0.03125000, 0.00002762, 0.02894740, 0.00003372, 0.02912620, 0.02992700, },
  [99] = {0.00001939, 0.00002328, 0.01002000, 0.00001455, 0.03076920, 0.00001939, 0.02869570, 0.00002368, 0.02884620, 0.02971010, },
  [100] = {0.00001362, 0.00001635, 0.00988142, 0.00001022, 0.03076920, 0.00001362, 0.02820510, 0.00001663, 0.02830190, 0.02907800, },
}
end
function StatLogic:GetCritFromAgi(agi, class, level)
	-- argCheck for invalid input
	self:argCheck(agi, 2, "number")
	self:argCheck(class, 3, "nil", "string", "number")
	self:argCheck(level, 4, "nil", "number")
	-- if class is a class string, convert to class id
	if type(class) == "string" and ClassNameToID[strupper(class)] ~= nil then
		class = ClassNameToID[strupper(class)]
	-- if class is invalid input, default to player class
	elseif type(class) ~= "number" or class < 1 or class > 10 then
		class = ClassNameToID[playerClass]
	end
	-- if level is invalid input, default to player level
	if type(level) ~= "number" or level < 1 or level > 100 then
		level = UnitLevel("player")
	end
	-- Calculate
	return agi * CritPerAgi[level][class], "MELEE_CRIT"
end


--[[---------------------------------
	:GetSpellCritFromInt(int, [class], [level])
-------------------------------------
Notes:
	* SpellCritPerInt values reverse engineered by Whitetooth (hotdogee [at] gmail [dot] com)
	* Calculates the spell crit chance from intellect for given class and level.
Arguments:
	number - Intellect
	[optional] string or number - ClassID or "ClassName". Default: PlayerClass<br>See :GetClassIdOrName(class) for valid class values.
	[optional] number - Level used in calculations. Default: player's level
Returns:
	; spellcrit : number - Spell crit percentage
	; statid : string - "SPELL_CRIT"
Example:
	local spellCrit = StatLogic:GetSpellCritFromInt(1) -- GetSpellCritPerInt
	local spellCrit = StatLogic:GetSpellCritFromInt(10)
	local spellCrit = StatLogic:GetSpellCritFromInt(10, "MAGE")
	local spellCrit = StatLogic:GetSpellCritFromInt(10, nil, 70)
	local spellCrit = StatLogic:GetSpellCritFromInt(10, "MAGE", 70)
-----------------------------------]]

-- Numbers reverse engineered by Whitetooth (hotdogee [at] gmail [dot] com)
local SpellCritPerInt
if toc < 40000 then
SpellCritPerInt = {
	--WARRIOR, PALADIN, HUNTER, ROGUE, PRIEST, DEATHKNIGHT, SHAMAN, MAGE, WARLOCK, DRUID
	[1] = {0.0000, 0.0832, 0.0699, 0.0000, 0.1710, 0.0000, 0.1333, 0.1637, 0.1500, 0.1431, },
	[2] = {0.0000, 0.0793, 0.0666, 0.0000, 0.1636, 0.0000, 0.1272, 0.1574, 0.1435, 0.1369, },
	[3] = {0.0000, 0.0793, 0.0666, 0.0000, 0.1568, 0.0000, 0.1217, 0.1516, 0.1375, 0.1312, },
	[4] = {0.0000, 0.0757, 0.0635, 0.0000, 0.1505, 0.0000, 0.1217, 0.1411, 0.1320, 0.1259, },
	[5] = {0.0000, 0.0757, 0.0635, 0.0000, 0.1394, 0.0000, 0.1166, 0.1364, 0.1269, 0.1211, },
	[6] = {0.0000, 0.0724, 0.0608, 0.0000, 0.1344, 0.0000, 0.1120, 0.1320, 0.1222, 0.1166, },
	[7] = {0.0000, 0.0694, 0.0608, 0.0000, 0.1297, 0.0000, 0.1077, 0.1279, 0.1179, 0.1124, },
	[8] = {0.0000, 0.0694, 0.0583, 0.0000, 0.1254, 0.0000, 0.1037, 0.1240, 0.1138, 0.1124, },
	[9] = {0.0000, 0.0666, 0.0583, 0.0000, 0.1214, 0.0000, 0.1000, 0.1169, 0.1100, 0.1086, },
	[10] = {0.0000, 0.0666, 0.0559, 0.0000, 0.1140, 0.0000, 0.1000, 0.1137, 0.1065, 0.0984, },
	[11] = {0.0000, 0.0640, 0.0559, 0.0000, 0.1045, 0.0000, 0.0933, 0.1049, 0.0971, 0.0926, },
	[12] = {0.0000, 0.0616, 0.0538, 0.0000, 0.0941, 0.0000, 0.0875, 0.0930, 0.0892, 0.0851, },
	[13] = {0.0000, 0.0594, 0.0499, 0.0000, 0.0875, 0.0000, 0.0800, 0.0871, 0.0825, 0.0807, },
	[14] = {0.0000, 0.0574, 0.0499, 0.0000, 0.0784, 0.0000, 0.0756, 0.0731, 0.0767, 0.0750, },
	[15] = {0.0000, 0.0537, 0.0466, 0.0000, 0.0724, 0.0000, 0.0700, 0.0671, 0.0717, 0.0684, },
	[16] = {0.0000, 0.0537, 0.0466, 0.0000, 0.0684, 0.0000, 0.0666, 0.0639, 0.0688, 0.0656, },
	[17] = {0.0000, 0.0520, 0.0451, 0.0000, 0.0627, 0.0000, 0.0636, 0.0602, 0.0635, 0.0617, },
	[18] = {0.0000, 0.0490, 0.0424, 0.0000, 0.0597, 0.0000, 0.0596, 0.0568, 0.0600, 0.0594, },
	[19] = {0.0000, 0.0490, 0.0424, 0.0000, 0.0562, 0.0000, 0.0571, 0.0538, 0.0569, 0.0562, },
	[20] = {0.0000, 0.0462, 0.0399, 0.0000, 0.0523, 0.0000, 0.0538, 0.0505, 0.0541, 0.0516, },
	[21] = {0.0000, 0.0450, 0.0388, 0.0000, 0.0502, 0.0000, 0.0518, 0.0487, 0.0516, 0.0500, },
	[22] = {0.0000, 0.0438, 0.0388, 0.0000, 0.0470, 0.0000, 0.0500, 0.0460, 0.0493, 0.0477, },
	[23] = {0.0000, 0.0427, 0.0368, 0.0000, 0.0453, 0.0000, 0.0474, 0.0445, 0.0471, 0.0463, },
	[24] = {0.0000, 0.0416, 0.0358, 0.0000, 0.0428, 0.0000, 0.0459, 0.0422, 0.0446, 0.0437, },
	[25] = {0.0000, 0.0396, 0.0350, 0.0000, 0.0409, 0.0000, 0.0437, 0.0405, 0.0429, 0.0420, },
	[26] = {0.0000, 0.0387, 0.0341, 0.0000, 0.0392, 0.0000, 0.0424, 0.0390, 0.0418, 0.0409, },
	[27] = {0.0000, 0.0387, 0.0333, 0.0000, 0.0376, 0.0000, 0.0412, 0.0372, 0.0398, 0.0394, },
	[28] = {0.0000, 0.0370, 0.0325, 0.0000, 0.0362, 0.0000, 0.0394, 0.0338, 0.0384, 0.0384, },
	[29] = {0.0000, 0.0362, 0.0318, 0.0000, 0.0348, 0.0000, 0.0383, 0.0325, 0.0367, 0.0366, },
	[30] = {0.0000, 0.0347, 0.0304, 0.0000, 0.0333, 0.0000, 0.0368, 0.0312, 0.0355, 0.0346, },
	[31] = {0.0000, 0.0340, 0.0297, 0.0000, 0.0322, 0.0000, 0.0354, 0.0305, 0.0347, 0.0339, },
	[32] = {0.0000, 0.0333, 0.0297, 0.0000, 0.0311, 0.0000, 0.0346, 0.0294, 0.0333, 0.0325, },
	[33] = {0.0000, 0.0326, 0.0285, 0.0000, 0.0301, 0.0000, 0.0333, 0.0286, 0.0324, 0.0318, },
	[34] = {0.0000, 0.0320, 0.0280, 0.0000, 0.0289, 0.0000, 0.0325, 0.0278, 0.0311, 0.0309, },
	[35] = {0.0000, 0.0308, 0.0269, 0.0000, 0.0281, 0.0000, 0.0314, 0.0269, 0.0303, 0.0297, },
	[36] = {0.0000, 0.0303, 0.0264, 0.0000, 0.0273, 0.0000, 0.0304, 0.0262, 0.0295, 0.0292, },
	[37] = {0.0000, 0.0297, 0.0264, 0.0000, 0.0263, 0.0000, 0.0298, 0.0254, 0.0284, 0.0284, },
	[38] = {0.0000, 0.0287, 0.0254, 0.0000, 0.0256, 0.0000, 0.0289, 0.0248, 0.0277, 0.0276, },
	[39] = {0.0000, 0.0282, 0.0250, 0.0000, 0.0249, 0.0000, 0.0283, 0.0241, 0.0268, 0.0269, },
	[40] = {0.0000, 0.0273, 0.0241, 0.0000, 0.0241, 0.0000, 0.0272, 0.0235, 0.0262, 0.0256, },
	[41] = {0.0000, 0.0268, 0.0237, 0.0000, 0.0235, 0.0000, 0.0267, 0.0230, 0.0256, 0.0252, },
	[42] = {0.0000, 0.0264, 0.0237, 0.0000, 0.0228, 0.0000, 0.0262, 0.0215, 0.0248, 0.0244, },
	[43] = {0.0000, 0.0256, 0.0229, 0.0000, 0.0223, 0.0000, 0.0254, 0.0211, 0.0243, 0.0240, },
	[44] = {0.0000, 0.0256, 0.0225, 0.0000, 0.0216, 0.0000, 0.0248, 0.0206, 0.0236, 0.0233, },
	[45] = {0.0000, 0.0248, 0.0218, 0.0000, 0.0210, 0.0000, 0.0241, 0.0201, 0.0229, 0.0228, },
	[46] = {0.0000, 0.0245, 0.0215, 0.0000, 0.0206, 0.0000, 0.0235, 0.0197, 0.0224, 0.0223, },
	[47] = {0.0000, 0.0238, 0.0212, 0.0000, 0.0200, 0.0000, 0.0231, 0.0192, 0.0220, 0.0219, },
	[48] = {0.0000, 0.0231, 0.0206, 0.0000, 0.0196, 0.0000, 0.0226, 0.0188, 0.0214, 0.0214, },
	[49] = {0.0000, 0.0228, 0.0203, 0.0000, 0.0191, 0.0000, 0.0220, 0.0184, 0.0209, 0.0209, },
	[50] = {0.0000, 0.0222, 0.0197, 0.0000, 0.0186, 0.0000, 0.0215, 0.0179, 0.0204, 0.0202, },
	[51] = {0.0000, 0.0219, 0.0194, 0.0000, 0.0183, 0.0000, 0.0210, 0.0176, 0.0200, 0.0198, },
	[52] = {0.0000, 0.0216, 0.0192, 0.0000, 0.0178, 0.0000, 0.0207, 0.0173, 0.0195, 0.0193, },
	[53] = {0.0000, 0.0211, 0.0186, 0.0000, 0.0175, 0.0000, 0.0201, 0.0170, 0.0191, 0.0191, },
	[54] = {0.0000, 0.0208, 0.0184, 0.0000, 0.0171, 0.0000, 0.0199, 0.0166, 0.0186, 0.0186, },
	[55] = {0.0000, 0.0203, 0.0179, 0.0000, 0.0166, 0.0000, 0.0193, 0.0162, 0.0182, 0.0182, },
	[56] = {0.0000, 0.0201, 0.0177, 0.0000, 0.0164, 0.0000, 0.0190, 0.0154, 0.0179, 0.0179, },
	[57] = {0.0000, 0.0198, 0.0175, 0.0000, 0.0160, 0.0000, 0.0187, 0.0151, 0.0176, 0.0176, },
	[58] = {0.0000, 0.0191, 0.0170, 0.0000, 0.0157, 0.0000, 0.0182, 0.0149, 0.0172, 0.0173, },
	[59] = {0.0000, 0.0189, 0.0168, 0.0000, 0.0154, 0.0000, 0.0179, 0.0146, 0.0168, 0.0169, },
	[60] = {0.0000, 0.0185, 0.0164, 0.0000, 0.0151, 0.0000, 0.0175, 0.0143, 0.0165, 0.0164, },
	[61] = {0.0000, 0.0159, 0.0157, 0.0000, 0.0148, 0.0000, 0.0164, 0.0143, 0.0159, 0.0162, },
	[62] = {0.0000, 0.0154, 0.0154, 0.0000, 0.0145, 0.0000, 0.0159, 0.0143, 0.0154, 0.0157, },
	[63] = {0.0000, 0.0149, 0.0150, 0.0000, 0.0143, 0.0000, 0.0152, 0.0143, 0.0148, 0.0150, },
	[64] = {0.0000, 0.0145, 0.0144, 0.0000, 0.0139, 0.0000, 0.0147, 0.0143, 0.0143, 0.0146, },
	[65] = {0.0000, 0.0140, 0.0141, 0.0000, 0.0137, 0.0000, 0.0142, 0.0142, 0.0138, 0.0142, },
	[66] = {0.0000, 0.0136, 0.0137, 0.0000, 0.0134, 0.0000, 0.0138, 0.0138, 0.0135, 0.0137, },
	[67] = {0.0000, 0.0134, 0.0133, 0.0000, 0.0132, 0.0000, 0.0134, 0.0134, 0.0130, 0.0133, },
	[68] = {0.0000, 0.0131, 0.0130, 0.0000, 0.0130, 0.0000, 0.0131, 0.0131, 0.0127, 0.0131, },
	[69] = {0.0000, 0.0128, 0.0128, 0.0000, 0.0127, 0.0000, 0.0128, 0.0128, 0.0126, 0.0128, },
	[70] = {0.0000, 0.0125, 0.0125, 0.0000, 0.0125, 0.0000, 0.0125, 0.0125, 0.0125, 0.0125, },
	[71] = {0.0000, 0.0116, 0.0116, 0.0000, 0.0116, 0.0000, 0.0116, 0.0116, 0.0116, 0.0116, },
	[72] = {0.0000, 0.0108, 0.0108, 0.0000, 0.0108, 0.0000, 0.0108, 0.0108, 0.0108, 0.0108, },
	[73] = {0.0000, 0.0101, 0.0101, 0.0000, 0.0101, 0.0000, 0.0101, 0.0101, 0.0101, 0.0101, },
	[74] = {0.0000, 0.0093, 0.0093, 0.0000, 0.0093, 0.0000, 0.0093, 0.0093, 0.0093, 0.0093, },
	[75] = {0.0000, 0.0087, 0.0087, 0.0000, 0.0087, 0.0000, 0.0087, 0.0087, 0.0087, 0.0087, },
	[76] = {0.0000, 0.0081, 0.0081, 0.0000, 0.0081, 0.0000, 0.0081, 0.0081, 0.0081, 0.0081, },
	[77] = {0.0000, 0.0075, 0.0075, 0.0000, 0.0075, 0.0000, 0.0075, 0.0075, 0.0075, 0.0075, },
	[78] = {0.0000, 0.0070, 0.0070, 0.0000, 0.0070, 0.0000, 0.0070, 0.0070, 0.0070, 0.0070, },
	[79] = {0.0000, 0.0065, 0.0065, 0.0000, 0.0065, 0.0000, 0.0065, 0.0065, 0.0065, 0.0065, },
	[80] = {0.0000, 0.0060, 0.0060, 0.0000, 0.0060, 0.0000, 0.0060, 0.0060, 0.0060, 0.0060, },
	[81] = {0.0000, 0.0056, 0.0056, 0.0000, 0.0056, 0.0000, 0.0056, 0.0056, 0.0056, 0.0056, },
	[82] = {0.0000, 0.0053, 0.0053, 0.0000, 0.0053, 0.0000, 0.0053, 0.0053, 0.0053, 0.0053, },
	[83] = {0.0000, 0.0050, 0.0050, 0.0000, 0.0050, 0.0000, 0.0050, 0.0050, 0.0050, 0.0050, },
	[84] = {0.0000, 0.0047, 0.0047, 0.0000, 0.0047, 0.0000, 0.0047, 0.0047, 0.0047, 0.0047, },
	[85] = {0.0000, 0.0044, 0.0044, 0.0000, 0.0044, 0.0000, 0.0044, 0.0044, 0.0044, 0.0044, },
	[86] = {0.0000, 0.0042, 0.0042, 0.0000, 0.0042, 0.0000, 0.0042, 0.0042, 0.0042, 0.0042, },
	[87] = {0.0000, 0.0040, 0.0040, 0.0000, 0.0040, 0.0000, 0.0040, 0.0040, 0.0040, 0.0040, },
	[88] = {0.0000, 0.0038, 0.0038, 0.0000, 0.0038, 0.0000, 0.0038, 0.0038, 0.0038, 0.0038, },
	[89] = {0.0000, 0.0037, 0.0037, 0.0000, 0.0037, 0.0000, 0.0037, 0.0037, 0.0037, 0.0037, },
	[90] = {0.0000, 0.0035, 0.0035, 0.0000, 0.0035, 0.0000, 0.0035, 0.0035, 0.0035, 0.0035, },
	[91] = {0.0000, 0.0034, 0.0034, 0.0000, 0.0034, 0.0000, 0.0034, 0.0034, 0.0034, 0.0034, },
	[92] = {0.0000, 0.0033, 0.0033, 0.0000, 0.0033, 0.0000, 0.0033, 0.0033, 0.0033, 0.0033, },
	[93] = {0.0000, 0.0031, 0.0031, 0.0000, 0.0031, 0.0000, 0.0031, 0.0031, 0.0031, 0.0031, },
	[94] = {0.0000, 0.0030, 0.0030, 0.0000, 0.0030, 0.0000, 0.0030, 0.0030, 0.0030, 0.0030, },
	[95] = {0.0000, 0.0029, 0.0029, 0.0000, 0.0029, 0.0000, 0.0029, 0.0029, 0.0029, 0.0029, },
	[96] = {0.0000, 0.0028, 0.0028, 0.0000, 0.0028, 0.0000, 0.0028, 0.0028, 0.0028, 0.0028, },
	[97] = {0.0000, 0.0027, 0.0027, 0.0000, 0.0027, 0.0000, 0.0027, 0.0027, 0.0027, 0.0027, },
	[98] = {0.0000, 0.0027, 0.0027, 0.0000, 0.0027, 0.0000, 0.0027, 0.0027, 0.0027, 0.0027, },
	[99] = {0.0000, 0.0026, 0.0026, 0.0000, 0.0026, 0.0000, 0.0026, 0.0026, 0.0026, 0.0026, },
	[100] = {0.0000, 0.0025, 0.0025, 0.0000, 0.0025, 0.0000, 0.0025, 0.0025, 0.0025, 0.0025, },
}
else

SpellCritPerInt = {
	--WARRIOR, PALADIN, HUNTER, ROGUE, PRIEST, DEATHKNIGHT, SHAMAN, MAGE, WARLOCK, DRUID
  [1] = {0.00000000, 0.08322500, 0.06990000, 0.00000000, 0.17102300, 0.00000000, 0.13328600, 0.16370000, 0.15000000, 0.14311400, },
  [2] = {0.00000000, 0.07926190, 0.06657140, 0.00000000, 0.16358700, 0.00000000, 0.12722700, 0.15740400, 0.14347800, 0.13689100, },
  [3] = {0.00000000, 0.07926190, 0.06657140, 0.00000000, 0.15677100, 0.00000000, 0.12169600, 0.15157399, 0.13750000, 0.13118699, },
  [4] = {0.00000000, 0.07565910, 0.06354550, 0.00000000, 0.15050001, 0.00000000, 0.12169600, 0.14112100, 0.13200000, 0.12594000, },
  [5] = {0.00000000, 0.07565910, 0.06354550, 0.00000000, 0.13935200, 0.00000000, 0.11662500, 0.13641700, 0.12692300, 0.12109600, },
  [6] = {0.00000000, 0.07236960, 0.06078260, 0.00000000, 0.13437500, 0.00000000, 0.11196000, 0.13201600, 0.12222200, 0.11661100, },
  [7] = {0.00000000, 0.06935420, 0.06078260, 0.00000000, 0.12974100, 0.00000000, 0.10765400, 0.12789100, 0.11785700, 0.11244600, },
  [8] = {0.00000000, 0.06935420, 0.05825000, 0.00000000, 0.12541700, 0.00000000, 0.10366699, 0.12401500, 0.11379300, 0.11244600, },
  [9] = {0.00000000, 0.06658000, 0.05825000, 0.00000000, 0.12137101, 0.00000000, 0.09996430, 0.11692900, 0.11000000, 0.10856900, },
  [10] = {0.00000000, 0.06658000, 0.05592000, 0.00000000, 0.11401500, 0.00000000, 0.09996430, 0.11368101, 0.10645200, 0.09839060, },
  [11] = {0.00000000, 0.06401920, 0.05592000, 0.00000000, 0.10451400, 0.00000000, 0.09330000, 0.10493600, 0.09705880, 0.09260290, },
  [12] = {0.00000000, 0.06164810, 0.05376920, 0.00000000, 0.09406250, 0.00000000, 0.08746880, 0.09301140, 0.08918920, 0.08509460, },
  [13] = {0.00000000, 0.05944640, 0.04992860, 0.00000000, 0.08750000, 0.00000000, 0.07997140, 0.08707450, 0.08250000, 0.08073080, },
  [14] = {0.00000000, 0.05739660, 0.04992860, 0.00000000, 0.07838540, 0.00000000, 0.07564860, 0.07308040, 0.07674420, 0.07496430, },
  [15] = {0.00000000, 0.05369350, 0.04660000, 0.00000000, 0.07235580, 0.00000000, 0.06997500, 0.06709020, 0.07173910, 0.06844570, },
  [16] = {0.00000000, 0.05369350, 0.04660000, 0.00000000, 0.06840910, 0.00000000, 0.06664290, 0.06394530, 0.06875000, 0.06559370, },
  [17] = {0.00000000, 0.05201560, 0.04509680, 0.00000000, 0.06270830, 0.00000000, 0.06361360, 0.06018380, 0.06346150, 0.06173530, },
  [18] = {0.00000000, 0.04895590, 0.04236360, 0.00000000, 0.05972220, 0.00000000, 0.05955320, 0.05684030, 0.06000000, 0.05940570, },
  [19] = {0.00000000, 0.04895590, 0.04236360, 0.00000000, 0.05615670, 0.00000000, 0.05712240, 0.05384870, 0.05689660, 0.05622320, },
  [20] = {0.00000000, 0.04623610, 0.03994290, 0.00000000, 0.05225690, 0.00000000, 0.05382690, 0.05052470, 0.05409840, 0.05161480, },
  [21] = {0.00000000, 0.04498650, 0.03883330, 0.00000000, 0.05016670, 0.00000000, 0.05183330, 0.04872020, 0.05156250, 0.04997620, },
  [22] = {0.00000000, 0.04380260, 0.03883330, 0.00000000, 0.04703120, 0.00000000, 0.04998210, 0.04598310, 0.04925370, 0.04770450, },
  [23] = {0.00000000, 0.04267950, 0.03678950, 0.00000000, 0.04533130, 0.00000000, 0.04744070, 0.04448370, 0.04714290, 0.04630150, },
  [24] = {0.00000000, 0.04161250, 0.03584620, 0.00000000, 0.04275570, 0.00000000, 0.04588520, 0.04219070, 0.04459460, 0.04372920, },
  [25] = {0.00000000, 0.03963100, 0.03495000, 0.00000000, 0.04089670, 0.00000000, 0.04373440, 0.04051980, 0.04285710, 0.04198000, },
  [26] = {0.00000000, 0.03870930, 0.03409760, 0.00000000, 0.03919270, 0.00000000, 0.04240910, 0.03897620, 0.04177220, 0.04088960, },
  [27] = {0.00000000, 0.03870930, 0.03328570, 0.00000000, 0.03762500, 0.00000000, 0.04116180, 0.03720450, 0.03975900, 0.03935630, },
  [28] = {0.00000000, 0.03698890, 0.03251160, 0.00000000, 0.03617790, 0.00000000, 0.03942250, 0.03382230, 0.03837210, 0.03839630, },
  [29] = {0.00000000, 0.03618480, 0.03177270, 0.00000000, 0.03483800, 0.00000000, 0.03834250, 0.03248020, 0.03666670, 0.03661050, },
  [30] = {0.00000000, 0.03467710, 0.03039130, 0.00000000, 0.03329650, 0.00000000, 0.03682890, 0.03124050, 0.03548390, 0.03459890, },
  [31] = {0.00000000, 0.03396940, 0.02974470, 0.00000000, 0.03215810, 0.00000000, 0.03543040, 0.03054100, 0.03473680, 0.03385480, },
  [32] = {0.00000000, 0.03329000, 0.02974470, 0.00000000, 0.03109500, 0.00000000, 0.03455560, 0.02944240, 0.03333330, 0.03245880, },
  [33] = {0.00000000, 0.03263730, 0.02853060, 0.00000000, 0.03010000, 0.00000000, 0.03332140, 0.02861890, 0.03235290, 0.03180300, },
  [34] = {0.00000000, 0.03200960, 0.02796000, 0.00000000, 0.02894230, 0.00000000, 0.03254650, 0.02784010, 0.03113210, 0.03086760, },
  [35] = {0.00000000, 0.03082410, 0.02688460, 0.00000000, 0.02807840, 0.00000000, 0.03144940, 0.02692430, 0.03027520, 0.02970280, },
  [36] = {0.00000000, 0.03026360, 0.02637740, 0.00000000, 0.02726450, 0.00000000, 0.03042390, 0.02623400, 0.02946430, 0.02915280, },
  [37] = {0.00000000, 0.02972320, 0.02637740, 0.00000000, 0.02631120, 0.00000000, 0.02977660, 0.02541930, 0.02844830, 0.02836490, },
  [38] = {0.00000000, 0.02869830, 0.02541820, 0.00000000, 0.02559520, 0.00000000, 0.02885570, 0.02480300, 0.02773110, 0.02761840, },
  [39] = {0.00000000, 0.02821190, 0.02496430, 0.00000000, 0.02491720, 0.00000000, 0.02827270, 0.02407350, 0.02682930, 0.02691030, },
  [40] = {0.00000000, 0.02728690, 0.02410340, 0.00000000, 0.02411860, 0.00000000, 0.02717480, 0.02352010, 0.02619050, 0.02559760, },
  [41] = {0.00000000, 0.02684680, 0.02369490, 0.00000000, 0.02351560, 0.00000000, 0.02665710, 0.02299160, 0.02558140, 0.02518800, },
  [42] = {0.00000000, 0.02642060, 0.02369490, 0.00000000, 0.02280300, 0.00000000, 0.02615890, 0.02153950, 0.02481200, 0.02440700, },
  [43] = {0.00000000, 0.02560770, 0.02291800, 0.00000000, 0.02226330, 0.00000000, 0.02544550, 0.02109540, 0.02426470, 0.02403440, },
  [44] = {0.00000000, 0.02560770, 0.02254840, 0.00000000, 0.02162360, 0.00000000, 0.02476990, 0.02056530, 0.02357140, 0.02332220, },
  [45] = {0.00000000, 0.02484330, 0.02184380, 0.00000000, 0.02101960, 0.00000000, 0.02412930, 0.02006130, 0.02291670, 0.02281520, },
  [46] = {0.00000000, 0.02447790, 0.02150770, 0.00000000, 0.02056010, 0.00000000, 0.02352100, 0.01967550, 0.02244900, 0.02232980, },
  [47] = {0.00000000, 0.02377860, 0.02118180, 0.00000000, 0.02001330, 0.00000000, 0.02313220, 0.01921360, 0.02200000, 0.02186460, },
  [48] = {0.00000000, 0.02311810, 0.02055880, 0.00000000, 0.01959640, 0.00000000, 0.02257260, 0.01877290, 0.02142860, 0.02141840, },
  [49] = {0.00000000, 0.02280140, 0.02026090, 0.00000000, 0.01909900, 0.00000000, 0.02203940, 0.01835200, 0.02088610, 0.02085100, },
  [50] = {0.00000000, 0.02219330, 0.01969010, 0.00000000, 0.01862620, 0.00000000, 0.02153080, 0.01794960, 0.02037040, 0.02018270, },
  [51] = {0.00000000, 0.02190130, 0.01941670, 0.00000000, 0.01826460, 0.00000000, 0.02104510, 0.01764010, 0.02000000, 0.01980190, },
  [52] = {0.00000000, 0.02161690, 0.01915070, 0.00000000, 0.01783180, 0.00000000, 0.02073330, 0.01726790, 0.01952660, 0.01931600, },
  [53] = {0.00000000, 0.02106960, 0.01864000, 0.00000000, 0.01750000, 0.00000000, 0.02013670, 0.01698130, 0.01907510, 0.01908180, },
  [54] = {0.00000000, 0.02080620, 0.01839470, 0.00000000, 0.01710230, 0.00000000, 0.01985110, 0.01656880, 0.01864410, 0.01863020, },
  [55] = {0.00000000, 0.02029880, 0.01792310, 0.00000000, 0.01664820, 0.00000000, 0.01930340, 0.01624010, 0.01823200, 0.01819940, },
  [56] = {0.00000000, 0.02005420, 0.01769620, 0.00000000, 0.01635870, 0.00000000, 0.01904080, 0.01544340, 0.01793480, 0.01788920, },
  [57] = {0.00000000, 0.01981550, 0.01747500, 0.00000000, 0.01601060, 0.00000000, 0.01866000, 0.01510150, 0.01755320, 0.01758940, },
  [58] = {0.00000000, 0.01913220, 0.01704880, 0.00000000, 0.01574270, 0.00000000, 0.01817530, 0.01488180, 0.01718750, 0.01729950, },
  [59] = {0.00000000, 0.01891480, 0.01684340, 0.00000000, 0.01535710, 0.00000000, 0.01794230, 0.01456410, 0.01683670, 0.01692740, },
  [60] = {0.00000000, 0.01849440, 0.01644710, 0.00000000, 0.01505000, 0.00000000, 0.01749370, 0.01430940, 0.01650000, 0.01639840, },
  [61] = {0.00000000, 0.01585240, 0.01571290, 0.00000000, 0.01481300, 0.00000000, 0.01638980, 0.01430940, 0.01590570, 0.01615360, },
  [62] = {0.00000000, 0.01541200, 0.01539680, 0.00000000, 0.01447120, 0.00000000, 0.01585240, 0.01430940, 0.01540280, 0.01565850, },
  [63] = {0.00000000, 0.01486160, 0.01496970, 0.00000000, 0.01425190, 0.00000000, 0.01519880, 0.01430940, 0.01476210, 0.01502430, },
  [64] = {0.00000000, 0.01447390, 0.01442100, 0.00000000, 0.01393520, 0.00000000, 0.01467380, 0.01425960, 0.01428430, 0.01457140, },
  [65] = {0.00000000, 0.01398740, 0.01406840, 0.00000000, 0.01368180, 0.00000000, 0.01422450, 0.01421010, 0.01384890, 0.01415760, },
  [66] = {0.00000000, 0.01364340, 0.01375000, 0.00000000, 0.01343750, 0.00000000, 0.01378730, 0.01377950, 0.01345140, 0.01373170, },
  [67] = {0.00000000, 0.01342340, 0.01333460, 0.00000000, 0.01320180, 0.00000000, 0.01338800, 0.01337420, 0.01302730, 0.01334290, },
  [68] = {0.00000000, 0.01310630, 0.01303730, 0.00000000, 0.01297410, 0.00000000, 0.01307380, 0.01311700, 0.01273350, 0.01305880, },
  [69] = {0.00000000, 0.01280380, 0.01275940, 0.00000000, 0.01271110, 0.00000000, 0.01277850, 0.01282920, 0.01261620, 0.01277080, },
  [70] = {0.00000000, 0.01251500, 0.01250000, 0.00000000, 0.01250000, 0.00000000, 0.01250000, 0.01251530, 0.01250000, 0.01250000, },
  [71] = {0.00000000, 0.01162640, 0.01162640, 0.00000000, 0.01162640, 0.00000000, 0.01162640, 0.01162640, 0.01162640, 0.01162640, },
  [72] = {0.00000000, 0.01079820, 0.01079820, 0.00000000, 0.01079820, 0.00000000, 0.01079820, 0.01079820, 0.01079820, 0.01079820, },
  [73] = {0.00000000, 0.01005530, 0.01005530, 0.00000000, 0.01005530, 0.00000000, 0.01005530, 0.01005530, 0.01005530, 0.01005530, },
  [74] = {0.00000000, 0.00934361, 0.00934361, 0.00000000, 0.00934361, 0.00000000, 0.00934361, 0.00934361, 0.00934361, 0.00934361, },
  [75] = {0.00000000, 0.00868896, 0.00868896, 0.00000000, 0.00868896, 0.00000000, 0.00868896, 0.00868896, 0.00868896, 0.00868896, },
  [76] = {0.00000000, 0.00807199, 0.00807199, 0.00000000, 0.00807199, 0.00000000, 0.00807199, 0.00807199, 0.00807199, 0.00807199, },
  [77] = {0.00000000, 0.00749542, 0.00749542, 0.00000000, 0.00749542, 0.00000000, 0.00749542, 0.00749542, 0.00749542, 0.00749542, },
  [78] = {0.00000000, 0.00697189, 0.00697189, 0.00000000, 0.00697189, 0.00000000, 0.00697189, 0.00697189, 0.00697189, 0.00697189, },
  [79] = {0.00000000, 0.00647547, 0.00647547, 0.00000000, 0.00647547, 0.00000000, 0.00647547, 0.00647547, 0.00647547, 0.00647547, },
  [80] = {0.00000000, 0.00601838, 0.00601838, 0.00000000, 0.00601838, 0.00000000, 0.00601838, 0.00601838, 0.00601838, 0.00601838, },
  [81] = {0.00000000, 0.00458339, 0.00458339, 0.00000000, 0.00458339, 0.00000000, 0.00458339, 0.00458339, 0.00458339, 0.00458339, },
  [82] = {0.00000000, 0.00349034, 0.00349034, 0.00000000, 0.00349034, 0.00000000, 0.00349034, 0.00349034, 0.00349034, 0.00349034, },
  [83] = {0.00000000, 0.00265690, 0.00265690, 0.00000000, 0.00265690, 0.00000000, 0.00265690, 0.00265690, 0.00265690, 0.00265690, },
  [84] = {0.00000000, 0.00202346, 0.00202346, 0.00000000, 0.00202346, 0.00000000, 0.00202346, 0.00202346, 0.00202346, 0.00202346, },
  [85] = {0.00000000, 0.00154105, 0.00154105, 0.00000000, 0.00154105, 0.00000000, 0.00154105, 0.00154105, 0.00154105, 0.00154105, },
  [86] = {0.00000000, 0.00072153, 0.00072153, 0.00000000, 0.00072153, 0.00000000, 0.00072153, 0.00072153, 0.00072153, 0.00072153, },
  [87] = {0.00000000, 0.00050666, 0.00050666, 0.00000000, 0.00050666, 0.00000000, 0.00050666, 0.00050666, 0.00050666, 0.00050666, },
  [88] = {0.00000000, 0.00035578, 0.00035578, 0.00000000, 0.00035578, 0.00000000, 0.00035578, 0.00035578, 0.00035578, 0.00035578, },
  [89] = {0.00000000, 0.00024983, 0.00024983, 0.00000000, 0.00024983, 0.00000000, 0.00024983, 0.00024983, 0.00024983, 0.00024983, },
  [90] = {0.00000000, 0.00017543, 0.00017543, 0.00000000, 0.00017543, 0.00000000, 0.00017543, 0.00017543, 0.00017543, 0.00017543, },
  [91] = {0.00000000, 0.00012319, 0.00012319, 0.00000000, 0.00012319, 0.00000000, 0.00012319, 0.00012319, 0.00012319, 0.00012319, },
  [92] = {0.00000000, 0.00008650, 0.00008650, 0.00000000, 0.00008650, 0.00000000, 0.00008650, 0.00008650, 0.00008650, 0.00008650, },
  [93] = {0.00000000, 0.00006074, 0.00006074, 0.00000000, 0.00006074, 0.00000000, 0.00006074, 0.00006074, 0.00006074, 0.00006074, },
  [94] = {0.00000000, 0.00004265, 0.00004265, 0.00000000, 0.00004265, 0.00000000, 0.00004265, 0.00004265, 0.00004265, 0.00004265, },
  [95] = {0.00000000, 0.00002995, 0.00002995, 0.00000000, 0.00002995, 0.00000000, 0.00002995, 0.00002995, 0.00002995, 0.00002995, },
  [96] = {0.00000000, 0.00002103, 0.00002103, 0.00000000, 0.00002103, 0.00000000, 0.00002103, 0.00002103, 0.00002103, 0.00002103, },
  [97] = {0.00000000, 0.00001477, 0.00001477, 0.00000000, 0.00001477, 0.00000000, 0.00001477, 0.00001477, 0.00001477, 0.00001477, },
  [98] = {0.00000000, 0.00001037, 0.00001037, 0.00000000, 0.00001037, 0.00000000, 0.00001037, 0.00001037, 0.00001037, 0.00001037, },
  [99] = {0.00000000, 0.00000728, 0.00000728, 0.00000000, 0.00000728, 0.00000000, 0.00000728, 0.00000728, 0.00000728, 0.00000728, },
  [100] = {0.00000000, 0.00000511, 0.00000511, 0.00000000, 0.00000511, 0.00000000, 0.00000511, 0.00000511, 0.00000511, 0.00000511, },
}
end

function StatLogic:GetSpellCritFromInt(int, class, level)
	-- argCheck for invalid input
	self:argCheck(int, 2, "number")
	self:argCheck(class, 3, "nil", "string", "number")
	self:argCheck(level, 4, "nil", "number")
	-- if class is a class string, convert to class id
	if type(class) == "string" and ClassNameToID[strupper(class)] ~= nil then
		class = ClassNameToID[strupper(class)]
	-- if class is invalid input, default to player class
	elseif type(class) ~= "number" or class < 1 or class > 10 then
		class = ClassNameToID[playerClass]
	end
	-- if level is invalid input, default to player level
	if type(level) ~= "number" or level < 1 or level > 100 then
		level = UnitLevel("player")
	end
	-- Calculate
	return int * SpellCritPerInt[level][class], "SPELL_CRIT"
end


local BaseManaRegenPerSpi
--[[---------------------------------
	:GetNormalManaRegenFromSpi(spi, [int], [level])
-------------------------------------
Notes:
	* Formula and BASE_REGEN values derived by Whitetooth (hotdogee [at] gmail [dot] com)
	* Calculates the mana regen per 5 seconds from spirit when out of 5 second rule for given intellect and level.
	* Player class is no longer a parameter
	* ManaRegen(SPI, INT, LEVEL) = (0.001+SPI*BASE_REGEN[LEVEL]*(INT^0.5))*5
Arguments:
	number - Spirit
	[optional] number - Intellect. Default: player's intellect
	[optional] number - Level used in calculations. Default: player's level
Returns:
	; mp5o5sr : number - Mana regen per 5 seconds when out of 5 second rule
	; statid : string - "MANA_REG_NOT_CASTING"
Example:
	local mp5o5sr = StatLogic:GetNormalManaRegenFromSpi(1) -- GetNormalManaRegenPerSpi
	local mp5o5sr = StatLogic:GetNormalManaRegenFromSpi(10, 15)
	local mp5o5sr = StatLogic:GetNormalManaRegenFromSpi(10, 15, 70)
-----------------------------------]]

-- Numbers reverse engineered by Whitetooth (hotdogee [at] gmail [dot] com)
local BaseManaRegenPerSpi = {
	[1] =  0.020979,
	[2] =  0.020515,
	[3] =  0.020079,
	[4] =  0.019516,
	[5] =  0.018997,
	[6] =  0.018646,
	[7] =  0.018314,
	[8] =  0.017997,
	[9] =  0.017584,
	[10] = 0.017197,
	[11] = 0.016551,
	[12] = 0.015729,
	[13] = 0.015229,
	[14] = 0.014580,
	[15] = 0.014008,
	[16] = 0.013650,
	[17] = 0.013175,
	[18] = 0.012832,
	[19] = 0.012475,
	[20] = 0.012073,
	[21] = 0.011840,
	[22] = 0.011494,
	[23] = 0.011292,
	[24] = 0.010990,
	[25] = 0.010761,
	[26] = 0.010546,
	[27] = 0.010321,
	[28] = 0.010151,
	[29] = 0.009949,
	[30] = 0.009740,
	[31] = 0.009597,
	[32] = 0.009425,
	[33] = 0.009278,
	[34] = 0.009123,
	[35] = 0.008974,
	[36] = 0.008847,
	[37] = 0.008698,
	[38] = 0.008581,
	[39] = 0.008457,
	[40] = 0.008338,
	[41] = 0.008235,
	[42] = 0.008113,
	[43] = 0.008018,
	[44] = 0.007906,
	[45] = 0.007798,
	[46] = 0.007713,
	[47] = 0.007612,
	[48] = 0.007524,
	[49] = 0.007430,
	[50] = 0.007340,
	[51] = 0.007268,
	[52] = 0.007184,
	[53] = 0.007116,
	[54] = 0.007029,
	[55] = 0.006945,
	[56] = 0.006884,
	[57] = 0.006805,
	[58] = 0.006747,
	[59] = 0.006667,
	[60] = 0.006600,
	[61] = 0.006421,
	[62] = 0.006314,
	[63] = 0.006175,
	[64] = 0.006072,
	[65] = 0.005981,
	[66] = 0.005885,
	[67] = 0.005791,
	[68] = 0.005732,
	[69] = 0.005668,
	[70] = 0.005596,
	[71] = 0.005316,
	[72] = 0.005049,
	[73] = 0.004796,
	[74] = 0.004555,
	[75] = 0.004327,
	[76] = 0.004110,
	[77] = 0.003903,
	[78] = 0.003708,
	[79] = 0.003522,
	[80] = 0.003345,
	[81] = 0.003345,
	[82] = 0.003345,
	[83] = 0.003345,
	[84] = 0.003345,
	[85] = 0.003345,
}

function StatLogic:GetNormalManaRegenFromSpi(spi, int, level)
	-- argCheck for invalid input
	self:argCheck(spi, 2, "number")
	self:argCheck(int, 3, "nil", "number")
	self:argCheck(level, 4, "nil", "number")

	-- if level is invalid input, default to player level
	if type(level) ~= "number" or level < 1 or level > 80 then
		level = UnitLevel("player")
	end

	-- if int is invalid input, default to player int
	if type(int) ~= "number" then
		local _
		_, int = UnitStat("player",4)
	end
	-- Calculate
	return (0.001 + spi * BaseManaRegenPerSpi[level] * (int ^ 0.5)) * 5, "MANA_REG_NOT_CASTING"
end


--[[---------------------------------
	:GetHealthRegenFromSpi(spi, [class])
-------------------------------------
Notes:
	* HealthRegenPerSpi values derived by Whitetooth (hotdogee [at] gmail [dot] com)
	* Calculates the health regen per 5 seconds when out of combat from spirit for given class.
	* Player level does not effect health regen per spirit.
Arguments:
	number - Spirit
	[optional] string or number - ClassID or "ClassName". Default: PlayerClass<br>See :GetClassIdOrName(class) for valid class values.
Returns:
	; hp5oc : number - Health regen per 5 seconds when out of combat
	; statid : string - "HEALTH_REG_OUT_OF_COMBAT"
Example:
	local hp5oc = StatLogic:GetHealthRegenFromSpi(1) -- GetHealthRegenPerSpi
	local hp5oc = StatLogic:GetHealthRegenFromSpi(10)
	local hp5oc = StatLogic:GetHealthRegenFromSpi(10, "MAGE")
-----------------------------------]]

-- Numbers reverse engineered by Whitetooth (hotdogee [at] gmail [dot] com)
local HealthRegenPerSpi = {
	0.5, 0.125, 0.125, 0.333333, 0.041667, 0.5, 0.071429, 0.041667, 0.045455, 0.0625,
	--["WARRIOR"] = 0.5,
	--["PALADIN"] = 0.125,
	--["HUNTER"] = 0.125,
	--["ROGUE"] = 0.333333,
	--["PRIEST"] = 0.041667,
	--["DEATHKNIGHT"] = 0.5,
	--["SHAMAN"] = 0.071429,
	--["MAGE"] = 0.041667,
	--["WARLOCK"] = 0.045455,
	--["DRUID"] = 0.0625,
}

function StatLogic:GetHealthRegenFromSpi(spi, class)
	-- argCheck for invalid input
	self:argCheck(spi, 2, "number")
	self:argCheck(class, 3, "nil", "string", "number")
	-- if class is a class string, convert to class id
	if type(class) == "string" and ClassNameToID[strupper(class)] ~= nil then
		class = ClassNameToID[strupper(class)]
	-- if class is invalid input, default to player class
	elseif type(class) ~= "number" or class < 1 or class > 10 then
		class = ClassNameToID[playerClass]
	end
	-- Calculate
	return spi * HealthRegenPerSpi[class] * 5, "HEALTH_REG_OUT_OF_COMBAT"
end


----------
-- Gems --
----------

--[[---------------------------------
	:RemoveEnchant(link)
-------------------------------------
Notes:
	* Remove item's enchants.
Arguments:
	string - "itemlink"
Returns:
	; link : number - The modified link
Example:
	local link = StatLogic:RemoveEnchant("Hitem:31052:425:525:525:525:525:0:0")
-----------------------------------]]
function StatLogic:RemoveEnchant(link)
	-- check link
	if not strfind(link, "item:%d+:%d+:%d+:%d+:%d+:%d+:%-?%d+:%-?%d+") then
		return link
	end
	local linkType, itemId, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, suffixId, uniqueId, level = strsplit(":", link)
	if level then
		return strjoin(":", linkType, itemId, 0, jewelId1, jewelId2, jewelId3, jewelId4, suffixId, uniqueId, level)
	else
		return strjoin(":", linkType, itemId, 0, jewelId1, jewelId2, jewelId3, jewelId4, suffixId, uniqueId)
	end
end

--[[---------------------------------
	:RemoveGem(link)
-------------------------------------
Notes:
	* Remove item's gems.
Arguments:
	string - "itemlink"
Returns:
	; link : number - The modified link
Example:
	local link = StatLogic:RemoveGem("Hitem:31052:425:525:525:525:525:0:0")
-----------------------------------]]
function StatLogic:RemoveGem(link)
	-- check link
	if not strfind(link, "item:%d+:%d+:%d+:%d+:%d+:%d+:%-?%d+:%-?%d+") then
		return link
	end
	local linkType, itemId, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, suffixId, uniqueId, level = strsplit(":", link)
	if level then
		return strjoin(":", linkType, itemId, enchantId, 0, 0, 0, 0, suffixId, uniqueId, level)
	else
		return strjoin(":", linkType, itemId, enchantId, 0, 0, 0, 0, suffixId, uniqueId)
	end
end

--[[---------------------------------
	:RemoveExtraSocketGem(link)
-------------------------------------
Notes:
	* Remove gems socketed in Prismatic Sockets, this includes Eternal Belt Buckles and Blacksmith only Bracer Socket and Glove Socket.
Arguments:
	string - "itemlink"
Returns:
	; link : number - The modified link
Example:
	local link = StatLogic:RemoveExtraSocketGem("Hitem:31052:425:525:525:525:525:0:0")
-----------------------------------]]
local itemStatsTable = {}
local GetExtraSocketGemLoc = setmetatable({}, { __index = function(self, n)
	-- We are here because what we want is not in cache
	-- Get last gem location
	local lastGemLoc = 0
	local _, _, _, jewelId1, jewelId2, jewelId3, jewelId4 = strsplit(":", n)
	if jewelId4 ~= "0" then
		lastGemLoc = 4
	elseif jewelId3 ~= "0" then
		lastGemLoc = 3
	elseif jewelId2 ~= "0" then
		lastGemLoc = 2
	elseif jewelId1 ~= "0" then
		lastGemLoc = 1
	end
	if lastGemLoc == 0 then
		self[n] = 0
		return 0
	end
	-- Get number of sockets
	wipe(itemStatsTable)
	GetItemStats(n, itemStatsTable)
	--RatingBuster:Print(itemStatsTable)
	local numSockets = (itemStatsTable["EMPTY_SOCKET_RED"] or 0) + (itemStatsTable["EMPTY_SOCKET_YELLOW"] or 0) + (itemStatsTable["EMPTY_SOCKET_BLUE"] or 0)
	if numSockets < lastGemLoc then
		self[n] = lastGemLoc
		return lastGemLoc
	else
		self[n] = 0
		return 0
	end
end })

local extraSocketLoc = {
	["INVTYPE_WAIST"] = true,
	["INVTYPE_WRIST"] = true,
	["INVTYPE_HAND"] = true,
}
function StatLogic:RemoveExtraSocketGem(link)
	-- check link
	if not strfind(link, "item:%d+:%d+:%d+:%d+:%d+:%d+:%-?%d+:%-?%d+") then
		return link
	end
	-- check only belt, bracer and gloves
	local _, _, _, _, _, _, _, _, itemType = GetItemInfo(link)
	if not extraSocketLoc[itemType] then return link end
	-- Get current gem count
	local extraGemLoc = GetExtraSocketGemLoc[link]
	if extraGemLoc == 0 then return link end
	local linkType, itemId, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, suffixId, uniqueId, level = strsplit(":", link)
	if extraGemLoc == 1 then
		jewelId1 = "0"
	elseif extraGemLoc == 2 then
		jewelId2 = "0"
	elseif extraGemLoc == 3 then
		jewelId3 = "0"
	elseif extraGemLoc == 4 then
		jewelId4 = "0"
	end
	if level then
		return strjoin(":", linkType, itemId, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, suffixId, uniqueId, level)
	else
		return strjoin(":", linkType, itemId, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, suffixId, uniqueId)
	end
end


--[[---------------------------------
	:RemoveEnchantGem(link)
-------------------------------------
Notes:
	* Remove item's gems and enchants.
Arguments:
	string - "itemlink"
Returns:
	; link : number - The modified link
Example:
	local link = StatLogic:RemoveEnchantGem("Hitem:31052:425:525:525:525:525:0:0")
-----------------------------------]]
function StatLogic:RemoveEnchantGem(link)
	-- check link
	if not strfind(link, "item:%d+:%d+:%d+:%d+:%d+:%d+:%-?%d+:%-?%d+") then
		return link
	end
	local linkType, itemId, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, suffixId, uniqueId, level = strsplit(":", link)
	if level then
		return strjoin(":", linkType, itemId, 0, 0, 0, 0, 0, suffixId, uniqueId, level)
	else
		return strjoin(":", linkType, itemId, 0, 0, 0, 0, 0, suffixId, uniqueId)
	end
end

--[[---------------------------------
	:ModEnchantGem(link, enc, gem1, gem2, gem3, gem4)
-------------------------------------
Notes:
	* Add/Replace item's enchants or gems with given enchants or gems.
Arguments:
	string - "itemlink"
	[optional] number or string - enchantID to replace the current enchant. Default: no change
	[optional] number or string - gemID to replace the first gem. Default: no change
	[optional] number or string - gemID to replace the second gem. Default: no change
	[optional] number or string - gemID to replace the third gem. Default: no change
	[optional] number or string - gemID to replace the fourth gem. Default: no change
Returns:
	; link : number - The modified link
Example:
	local link = StatLogic:ModEnchantGem("Hitem:31052:0:0:0:0:0:0:0", 1394)
-----------------------------------]]
function StatLogic:ModEnchantGem(link, enc, gem1, gem2, gem3, gem4)
	-- check link
	if not strfind(link, "item:%d+") then
		return
	end
	local linkType, itemId, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, suffixId, uniqueId, level = strsplit(":", link)
	if level then
		return strjoin(":", linkType, itemId, enc or enchantId or 0, gem1 or jewelId1 or 0, gem2 or jewelId2 or 0, gem3 or jewelId3 or 0, gem4 or jewelId4 or 0, suffixId or 0, uniqueId or 0, level)
	else
		return strjoin(":", linkType, itemId, enc or enchantId or 0, gem1 or jewelId1 or 0, gem2 or jewelId2 or 0, gem3 or jewelId3 or 0, gem4 or jewelId4 or 0, suffixId or 0, uniqueId or 0)
	end
end

--[[---------------------------------
	:BuildGemmedTooltip(item, red, yellow, blue, meta)
-------------------------------------
Notes:
	* Returns a modified link with all empty sockets replaced with the specified gems, sockets already gemmed will remain.
	* item:
	:;tooltip : table - The tooltip showing the item
	:;itemId : number - The numeric ID of the item. ie. 12345
	:;"itemString" : string - The full item ID in string format, e.g. "item:12345:0:0:0:0:0:0:0".
	:::Also supports partial itemStrings, by filling up any missing ":x" value with ":0", e.g. "item:12345:0:0:0"
	:;"itemName" : string - The Name of the Item, ex: "Hearthstone"
	:::The item must have been equiped, in your bags or in your bank once in this session for this to work.
	:;"itemLink" : string - The itemLink, when Shift-Clicking items.
Arguments:
	number or string or table - tooltip or itemId or "itemString" or "itemName" or "itemLink"
	number or string - gemID to replace a red socket
	number or string - gemID to replace a yellow socket
	number or string - gemID to replace a blue socket
	number or string - gemID to replace a meta socket
Returns:
	; link : string - modified item link
Example:
	local link = StatLogic:BuildGemmedTooltip(28619, 3119, 3119, 3119, 3119)
	StatLogic:SetTip("item:28619")
	StatLogic:SetTip(StatLogic:BuildGemmedTooltip(28619, 3119, 3119, 3119, 3119))
-----------------------------------]]
local EmptySocketLookup = {
	[EMPTY_SOCKET_RED] = 0, -- EMPTY_SOCKET_RED = "Red Socket";
	[EMPTY_SOCKET_YELLOW] = 0, -- EMPTY_SOCKET_YELLOW = "Yellow Socket";
	[EMPTY_SOCKET_BLUE] = 0, -- EMPTY_SOCKET_BLUE = "Blue Socket";
	[EMPTY_SOCKET_META] = 0, -- EMPTY_SOCKET_META = "Meta Socket";
}
function StatLogic:BuildGemmedTooltip(item, red, yellow, blue, meta)
	local _
	-- Check item
	if (type(item) == "string") or (type(item) == "number") then
	elseif type(item) == "table" and type(item.GetItem) == "function" then
		-- Get the link
		_, item = item:GetItem()
		if type(item) ~= "string" then return item end
	else
		return item
	end
	-- Check if item is in local cache
	local name, link, _, _, reqLv, _, _, _, itemType = GetItemInfo(item)
	if not name then return item end

	-- Check gemID
	if not red or not tonumber(red) then red = 0 end
	if not yellow or not tonumber(yellow) then yellow = 0 end
	if not blue or not tonumber(blue) then blue = 0 end
	if not meta or not tonumber(meta) then meta = 0 end
	if red == 0 and yellow == 0 and blue == 0 and meta == 0 then return link end -- nothing to modify
	-- Fill EmptySocketLookup
	EmptySocketLookup[EMPTY_SOCKET_RED] = red
	EmptySocketLookup[EMPTY_SOCKET_YELLOW] = yellow
	EmptySocketLookup[EMPTY_SOCKET_BLUE] = blue
	EmptySocketLookup[EMPTY_SOCKET_META] = meta

	-- Build socket list
	local socketList = {}
	-- Get a link without any socketed gems
	local cleanLink = link:match("(item:%d+)")
	-- Start parsing
	tip:ClearLines() -- this is required or SetX won't work the second time its called
	tip:SetHyperlink(link)
	for i = 2, tip:NumLines() do
		local text = tip[i]:GetText()
		-- Trim spaces
		text = strtrim(text)
		-- Strip color codes
		if strsub(text, -2) == "|r" then
			text = strsub(text, 1, -3)
		end
		if strfind(strsub(text, 1, 10), "|c%x%x%x%x%x%x%x%x") then
			text = strsub(text, 11)
		end
		local socketFound = EmptySocketLookup[text]
		if socketFound then
			socketList[#socketList+1] = socketFound
		end
	end
	-- If there are no sockets
	if #socketList == 0 then return link end
	-- link breakdown
	local linkType, itemId, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, suffixId, uniqueId, level = strsplit(":", link)
	if socketList[1] and (not jewelId1 or jewelId1 == "0") then jewelId1 = socketList[1] end
	if socketList[2] and (not jewelId2 or jewelId2 == "0") then jewelId2 = socketList[2] end
	if socketList[3] and (not jewelId3 or jewelId3 == "0") then jewelId3 = socketList[3] end
	if socketList[4] and (not jewelId4 or jewelId4 == "0") then jewelId4 = socketList[4] end
	if level then
		return strjoin(":", linkType, itemId, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, suffixId, uniqueId, level)
	else
		return strjoin(":", linkType, itemId, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, suffixId, uniqueId)
	end
end

--[[---------------------------------
	:GetGemID(item)
-------------------------------------
Notes:
	* Returns the gemID and gemText of a gem for use in links
	* item:
	:;tooltip : table - The tooltip showing the item
	:;itemId : number - The numeric ID of the item. ie. 12345
	:;"itemString" : string - The full item ID in string format, e.g. "item:12345:0:0:0:0:0:0:0".
	:::Also supports partial itemStrings, by filling up any missing ":x" value with ":0", e.g. "item:12345:0:0:0"
	:;"itemName" : string - The Name of the Item, ex: "Hearthstone"
	:::The item must have been equiped, in your bags or in your bank once in this session for this to work.
	:;"itemLink" : string - The itemLink, when Shift-Clicking items.
Arguments:
	number or string or table - Gem, tooltip or itemId or "itemString" or "itemName" or "itemLink"
Returns:
	; gemID or false : number or bool - The gemID of this gem, false if invalid input
	; gemText : string - The text shown in the tooltip when socketed in an item
Example:
	local gemID, gemText = StatLogic:GetGemID(28363)
-----------------------------------]]
-- SetTip("item:3185:0:2946")
function StatLogic:GetGemID(item)
	local t = GetTime()
	-- Check item
	if (type(item) == "string") or (type(item) == "number") then
	elseif type(item) == "table" and type(item.GetItem) == "function" then
		-- Get the link
		_, item = item:GetItem()
		if type(item) ~= "string" then return false end
	else
		return false
	end
	-- Check if item is in local cache
	local name, link = GetItemInfo(item)
	if not name then
		if tonumber(item) then
			-- Query server for item
			tipMiner:ClearLines()
			tipMiner:SetHyperlink("item:"..item)
		else
			item = item:match("item:(%d+)")
			if item then
				-- Query server for item
				tipMiner:ClearLines()
				tipMiner:SetHyperlink("item:"..item)
			else
				return false
			end
		end
		return
	end
	local itemID = strmatch(link, "item:(%d+)")
	local len = strlen(itemID)-1
	if not GetItemInfo(6948) then -- Hearthstone
		-- Query server for Hearthstone
		tipMiner:ClearLines()
		tipMiner:SetHyperlink("item:6948")
		return
	end
	local gemScanLink = "item:6948:0:0:0:%d:%d"
	local gemID
	-- Start GemID scan
	for gemID = 4000, 1, -1 do
		local itemLink = gemScanLink:format(gemID, gemID)
		local _, gem1Link = GetItemGem(itemLink, 3)
		--if gem1Link and itemID == gem1Link:match("item:(%d+)") then
		if gem1Link and strsub(gem1Link, 18, 18+len) == itemID then
			tipMiner:ClearLines() -- this is required or SetX won't work the second time its called
			tipMiner:SetHyperlink(itemLink)
			if GetCVarBool("colorblindMode") then
				return gemID, StatLogicMinerTooltipTextLeft6:GetText(), GetTime()-t
			else
				return gemID, StatLogicMinerTooltipTextLeft5:GetText(), GetTime()-t
			end
		end
	end
end

-- will sometimes disconnect
-- StatLogic:GetEnchantID("+10 All Stats")
--[[
function StatLogic:GetEnchantID(spell)
	-- Check item
	if not ((type(spell) == "string") or (type(spell) == "number")) then
		return
	end
	local spellName = spell
	if type(spell) == "number" then
		spellName = GetSpellInfo(spell)
	end
	if not GetItemInfo(6948) then -- Hearthstone
		-- Query server for Hearthstone
		tipMiner:ClearLines()
		tipMiner:SetHyperlink("item:6948")
		return
	end
	local scanLink = "item:6948:%d:%d:%d:%d:%d"
	local id
	-- Start EnchantID scan
	for id = 4000, 5, -5 do
		local itemLink = scanLink:format(id, id-1, id-2, id-3, id-4)
		tipMiner:ClearLines() -- this is required or SetX won't work the second time its called
		tipMiner:SetHyperlink(itemLink)
		if StatLogicMinerTooltipTextLeft4:GetText() == spellName then
			return id, StatLogicMinerTooltipTextLeft4:GetText()
		elseif StatLogicMinerTooltipTextLeft5:GetText() and strfind(StatLogicMinerTooltipTextLeft5:GetText(), spellName) then
			return id, StatLogicMinerTooltipTextLeft5:GetText()
		elseif StatLogicMinerTooltipTextLeft6:GetText() and strfind(StatLogicMinerTooltipTextLeft6:GetText(), spellName) then
			return id, StatLogicMinerTooltipTextLeft6:GetText()
		elseif StatLogicMinerTooltipTextLeft7:GetText() and strfind(StatLogicMinerTooltipTextLeft7:GetText(), spellName) then
			return id, StatLogicMinerTooltipTextLeft7:GetText()
		elseif StatLogicMinerTooltipTextLeft8:GetText() == spellName then
			return id, StatLogicMinerTooltipTextLeft8:GetText()
		end
	end
end
--]]

-- ================== --
-- Stat Summarization --
-- ================== --
--[[---------------------------------
	:GetSum(item, [table])
-------------------------------------
Notes:
	* Calculates the sum of all stats for a specified item.
	* item:
	:;tooltip : table - The tooltip showing the item
	:;itemId : number - The numeric ID of the item. ie. 12345
	:;"itemString" : string - The full item ID in string format, e.g. "item:12345:0:0:0:0:0:0:0".
	:::Also supports partial itemStrings, by filling up any missing ":x" value with ":0", e.g. "item:12345:0:0:0"
	:;"itemName" : string - The Name of the Item, ex: "Hearthstone"
	:::The item must have been equiped, in your bags or in your bank once in this session for this to work.
	:;"itemLink" : string - The itemLink, when Shift-Clicking items.
Arguments:
	number or string or table - tooltip or itemId or "itemString" or "itemName" or "itemLink"
	table - The sum of stat values are writen to this table if provided
Returns:
	; sumTable : table - The table with stat sum values
	:{
	::	["itemType"] = itemType,
	::	["STAT_ID1"] = value,
	::	["STAT_ID2"] = value,
	:}
Example:
	StatLogic:GetSum(21417) -- [Ring of Unspoken Names]
	StatLogic:GetSum("item:28040:2717")
	StatLogic:GetSum("item:19019:117") -- TF
	StatLogic:GetSum("item:3185:0:0:0:0:0:1957") -- Acrobatic Staff of Frozen Wrath ID:3185:0:0:0:0:0:1957
	StatLogic:GetSum(24396)
	SetTip("item:3185:0:0:0:0:0:1957")
	-- [Deadly Fire Opal] ID:30582 - Attack Power +8 and Critical Rating +5
	-- [Gnomeregan Auto-Blocker 600] ID:29387
	StatLogic:GetSum("item:30538:3011:2739:2739:2739:0") -- [Midnight Legguards] with enchant and gems
	StatLogic:GetSum("item:30538:3011:2739:2739:2739:0") -- [Midnight Legguards] with enchant and gems
-----------------------------------]]
--[[
0 = Poor
1 = Common
2 = Uncommon
3 = Rare
4 = Epic
5 = Legendary
6 = Artifact
7 = Heirloom
--]]
-- baseArmorTable[rarity][equipLoc][armorType][ilvl] = armorValue
-- Not interested in lower level items
local baseArmorTable = {
	[4] = {
		["INVTYPE_CLOAK"] = {
			[L["Cloth"]] = {
				[200] = 150, -- Cloak of Armed Strife ID:39225
				[213] = 154, -- Cloak of the Shadowed Sun ID:40252
			},
		},
		["INVTYPE_LEGS"] = {
			[L["Plate"]] = {
				[226] = 2054, -- Saronite Plated Legguards ID:45267
			},
		},
	},
	[3] = {
		["INVTYPE_CLOAK"] = {
			[L["Cloth"]] = {
				[167] = 127,
				[187] = 140,
			},
		},
	},
}
local bonusArmorItemEquipLoc = {
	["INVTYPE_WEAPON"] = true,
	["INVTYPE_2HWEAPON"] = true,
	["INVTYPE_WEAPONMAINHAND"] = true,
	["INVTYPE_WEAPONOFFHAND"] = true,
	["INVTYPE_HOLDABLE"] = true,
	["INVTYPE_RANGED"] = true,
	["INVTYPE_THROWN"] = true,
	["INVTYPE_RANGEDRIGHT"] = true,
	["INVTYPE_NECK"] = true,
	["INVTYPE_FINGER"] = true,
	["INVTYPE_TRINKET"] = true,
}
function StatLogic:GetSum(item, table)
	-- Locale check
	if noPatternLocale then return end
	local _
	-- Check item
	if (type(item) == "string") or (type(item) == "number") then -- common case first
	elseif type(item) == "table" and type(item.GetItem) == "function" then
		-- Get the link
		_, item = item:GetItem()
		if type(item) ~= "string" then return end
	else
		return
	end
	-- Check if item is in local cache
	local name, link, rarity , ilvl, reqLv, _, armorType, _, itemType = GetItemInfo(item)
	if not name then return end

	-- Clear table values
	clearTable(table)
	-- Initialize table
	table = table or new()
	setmetatable(table, statTableMetatable)

	-- Get data from cache if available
	if cache[link] then
		copyTable(table, cache[link])
		return table
	end

	-- Set metadata
	table.itemType = itemType
	table.link = link

	-- Don't scan Relics because they don't have general stats
	if itemType == "INVTYPE_RELIC" then
		cache[link] = copy(table)
		return table
	end

	-- Start parsing
	tip:ClearLines() -- this is required or SetX won't work the second time its called
	tip:SetHyperlink(link)
	debugPrint(link)
	for i = 2, tip:NumLines() do
		local text = tip[i]:GetText()

		-- Trim spaces
		text = strtrim(text)
		-- Strip color codes
		if strsub(text, -2) == "|r" then
			text = strsub(text, 1, -3)
		end
		if strfind(strsub(text, 1, 10), "|c%x%x%x%x%x%x%x%x") then
			text = strsub(text, 11)
		end

		local r, g, b = tip[i]:GetTextColor()
		-----------------------
		-- Whole Text Lookup --
		-----------------------
		-- Mainly used for enchants or stuff without numbers:
		-- "Mithril Spurs"
		local found
		local idTable = L.WholeTextLookup[text]
		if idTable == false then
			found = true
			debugPrint("|cffadadad".."  WholeText Exclude: "..text)
		elseif idTable then
			found = true
			for id, value in pairs(L.WholeTextLookup[text]) do
				-- sum stat
				table[id] = (table[id] or 0) + value
				debugPrint("|cffff5959".."  WholeText: ".."|cffffc259"..text..", ".."|cffffff59"..tostring(id).."="..tostring(value))
			end
		end
		-- Fast Exclude --
		-- Exclude obvious strings that do not need to be checked, also exclude lines that are not white and green and normal (normal for Frozen Wrath bonus)
		if not (found or L.Exclude[text] or L.Exclude[strutf8sub(text, 1, L.ExcludeLen)] or strsub(text, 1, 1) == '"' or g < 0.8 or (b < 0.99 and b > 0.1)) then
			--debugPrint(text.." = ")
			-- Strip enchant time
			-- ITEM_ENCHANT_TIME_LEFT_DAYS = "%s (%d day)";
			-- ITEM_ENCHANT_TIME_LEFT_DAYS_P1 = "%s (%d days)";
			-- ITEM_ENCHANT_TIME_LEFT_HOURS = "%s (%d hour)";
			-- ITEM_ENCHANT_TIME_LEFT_HOURS_P1 = "%s (%d hrs)";
			-- ITEM_ENCHANT_TIME_LEFT_MIN = "%s (%d min)"; -- Enchantment name, followed by the time left in minutes
			-- ITEM_ENCHANT_TIME_LEFT_SEC = "%s (%d sec)"; -- Enchantment name, followed by the time left in seconds
			--[[ Seems temp enchants such as mana oil can't be seen from item links, so commented out
			if strfind(text, "%)") then
				debugPrint("test")
				text = gsub(text, gsub(gsub(ITEM_ENCHANT_TIME_LEFT_DAYS, "%%s ", ""), "%%", "%%%%"), "")
				text = gsub(text, gsub(gsub(ITEM_ENCHANT_TIME_LEFT_DAYS_P1, "%%s ", ""), "%%", "%%%%"), "")
				text = gsub(text, gsub(gsub(ITEM_ENCHANT_TIME_LEFT_HOURS, "%%s ", ""), "%%", "%%%%"), "")
				text = gsub(text, gsub(gsub(ITEM_ENCHANT_TIME_LEFT_HOURS_P1, "%%s ", ""), "%%", "%%%%"), "")
				text = gsub(text, gsub(gsub(ITEM_ENCHANT_TIME_LEFT_MIN, "%%s ", ""), "%%", "%%%%"), "")
				text = gsub(text, gsub(gsub(ITEM_ENCHANT_TIME_LEFT_SEC, "%%s ", ""), "%%", "%%%%"), "")
			end
			--]]
			----------------------------
			-- Single Plus Stat Check --
			----------------------------
			-- depending on locale, L.SinglePlusStatCheck may be
			-- +19 Stamina = "^%+(%d+) ([%a ]+%a)$"
			-- Stamina +19 = "^([%a ]+%a) %+(%d+)$"
			-- +19 耐力 = "^%+(%d+) (.-)$"
			if not found then
				local _, _, value, statText = strfind(strutf8lower(text), L.SinglePlusStatCheck)
				if value then
					if tonumber(statText) then
						value, statText = statText, value
					end
					local idTable = L.StatIDLookup[statText]
					if idTable == false then
						found = true
						debugPrint("|cffadadad".."  SinglePlus Exclude: "..text)
					elseif idTable then
						found = true
						local debugText = "|cffff5959".."  SinglePlus: ".."|cffffc259"..text
						for _, id in ipairs(idTable) do
							--debugPrint("  '"..value.."', '"..id.."'")
							-- sum stat
							table[id] = (table[id] or 0) + tonumber(value)
							debugText = debugText..", ".."|cffffff59"..tostring(id).."="..tostring(value)
						end
						debugPrint(debugText)
					else
						-- pattern match but not found in L.StatIDLookup, keep looking
					end
				end
			end
			-----------------------------
			-- Single Equip Stat Check --
			-----------------------------
			-- depending on locale, L.SingleEquipStatCheck may be
			-- "^Equip: (.-) by u?p? ?t?o? ?(%d+) ?(.-)%.$"
			if not found then
				local _, _, statText1, value, statText2 = strfind(text, L.SingleEquipStatCheck)
				if value then
					local statText = statText1..statText2
					local idTable = L.StatIDLookup[strutf8lower(statText)]
					if idTable == false then
						found = true
						debugPrint("|cffadadad".."  SingleEquip Exclude: "..text)
					elseif idTable then
						found = true
						local debugText = "|cffff5959".."  SingleEquip: ".."|cffffc259"..text
						for _, id in ipairs(idTable) do
							--debugPrint("  '"..value.."', '"..id.."'")
							-- sum stat
							table[id] = (table[id] or 0) + tonumber(value)
							debugText = debugText..", ".."|cffffff59"..tostring(id).."="..tostring(value)
						end
						debugPrint(debugText)
					else
						-- pattern match but not found in L.StatIDLookup, keep looking
					end
				end
			end
			-- PreScan for special cases, that will fit wrongly into DeepScan
			-- PreScan also has exclude patterns
			-- This is where base armor gets scanned, check text color for bonus armor
			if not found then
				for pattern, id in pairs(L.PreScanPatterns) do
					local value
					found, _, value = strfind(text, pattern)
					if found then
						--found = true
						if id ~= false then
							local debugText = "|cffff5959".."  PreScan: ".."|cffffc259"..text
							--debugPrint("  '"..value.."' = '"..id.."'")
							-- check text color for bonus armor
							if id == "ARMOR" and r == 0 and b == 0 and
							baseArmorTable[rarity] and baseArmorTable[rarity][itemType] and 
							baseArmorTable[rarity][itemType][armorType] and baseArmorTable[rarity][itemType][armorType][ilvl] and
							tonumber(value) > baseArmorTable[rarity][itemType][armorType][ilvl] then
								table["ARMOR"] = (table["ARMOR"] or 0) + baseArmorTable[rarity][itemType][armorType][ilvl]
								table["ARMOR_BONUS"] = (table["ARMOR_BONUS"] or 0) + tonumber(value) - baseArmorTable[rarity][itemType][armorType][ilvl]
								debugText = debugText..", ".."|cffffff59ARMOR="..baseArmorTable[rarity][itemType][armorType][ilvl]..", ARMOR_BONUS="..(tonumber(value) - baseArmorTable[rarity][itemType][armorType][ilvl])
							else
								-- sum stat
								table[id] = (table[id] or 0) + tonumber(value)
								debugText = debugText..", ".."|cffffff59"..tostring(id).."="..tostring(value)
							end
							debugPrint(debugText)
						else
							debugPrint("|cffadadad".."  PreScan Exclude: "..text.."("..pattern..")")
						end
						break
					end
				end
				if found then

				end
			end
			--------------
			-- DeepScan --
			--------------
			--[[
			-- Strip trailing "."
			["."] = ".",
			["DeepScanSeparators"] = {
				"/", -- "+10 Defense Rating/+10 Stamina/+15 Block Value": ZG Enchant
				" & ", -- "+26 Healing Spells & 2% Reduced Threat": Bracing Earthstorm Diamond ID:25897
				", ", -- "+6 Spell Damage, +5 Spell Crit Rating": Potent Ornate Topaz ID: 28123
				"%. ", -- "Equip: Increases attack power by 81 when fighting Undead. It also allows the acquisition of Scourgestones on behalf of the Argent Dawn.": Seal of the Dawn
			},
			["DeepScanWordSeparators"] = {
				" and ", -- "Critical Rating +6 and Dodge Rating +5": Assassin's Fire Opal ID:30565
			},
			["DeepScanPatterns"] = {
				"^(.-) by u?p? ?t?o? ?(%d+) ?(.-)$", -- "xxx by up to 22 xxx" (scan first)
				"^(.-) ?%+(%d+) ?(.-)$", -- "xxx xxx +22" or "+22 xxx xxx" or "xxx +22 xxx" (scan 2ed)
				"^(.-) ?([%d%.]+) ?(.-)$", -- 22.22 xxx xxx (scan last)
			},
			--]]
			if not found then
				-- Get a local copy
				local text = text
				-- Strip leading "Equip: ", "Socket Bonus: "
				text = gsub(text, ITEM_SPELL_TRIGGER_ONEQUIP, "") -- ITEM_SPELL_TRIGGER_ONEQUIP = "Equip:";
				text = gsub(text, StripGlobalStrings(ITEM_SOCKET_BONUS), "") -- ITEM_SOCKET_BONUS = "Socket Bonus: %s"; -- Tooltip tag for socketed item matched socket bonuses
				-- Trim spaces
				text = strtrim(text)
				-- Strip trailing "."
				if strutf8sub(text, -1) == L["."] then
					text = strutf8sub(text, 1, -2)
				end
				-- Replace separators with @
				for _, sep in ipairs(L.DeepScanSeparators) do
					if strfind(text, sep) then
						 -- if there is a capture, for deDE
						if strsub(sep, 1, 1) == "(" then
							text = gsub(text, sep, "%1@")
						else
							text = gsub(text, sep, "@")
						end
					end
				end
				-- Split text using @
				text = {strsplit("@", text)}
				for i, text in ipairs(text) do
					-- Trim spaces
					text = strtrim(text)
					-- Strip trailing "."
					if strutf8sub(text, -1) == L["."] then
						text = strutf8sub(text, 1, -2)
					end
					debugPrint("|cff008080".."S"..i..": ".."'"..text.."'")
					-- Whole Text Lookup
					local foundWholeText = false
					local idTable = L.WholeTextLookup[text]
					if idTable == false then
						foundWholeText = true
						found = true
						debugPrint("|cffadadad".."  DeepScan WholeText Exclude: "..text)
					elseif idTable then
						foundWholeText = true
						found = true
						for id, value in pairs(L.WholeTextLookup[text]) do
							-- sum stat
							table[id] = (table[id] or 0) + value
							debugPrint("|cffff5959".."  DeepScan WholeText: ".."|cffffc259"..text..", ".."|cffffff59"..tostring(id).."="..tostring(value))
						end
					else
						-- pattern match but not found in L.WholeTextLookup, keep looking
					end
					-- Scan DualStatPatterns
					if not foundWholeText then
						for pattern, dualStat in pairs(L.DualStatPatterns) do
							local lowered = strutf8lower(text)
							local _, dEnd, value1, value2 = strfind(lowered, pattern)
							if value1 and value2 then
								foundWholeText = true
								found = true
								local debugText = "|cffff5959".."  DeepScan DualStat: ".."|cffffc259"..text
								for _, id in ipairs(dualStat[1]) do
									--debugPrint("  '"..value.."', '"..id.."'")
									-- sum stat
									table[id] = (table[id] or 0) + tonumber(value1)
									debugText = debugText..", ".."|cffffff59"..tostring(id).."="..tostring(value1)
								end
								for _, id in ipairs(dualStat[2]) do
									--debugPrint("  '"..value.."', '"..id.."'")
									-- sum stat
									table[id] = (table[id] or 0) + tonumber(value2)
									debugText = debugText..", ".."|cffffff59"..tostring(id).."="..tostring(value2)
								end
								debugPrint(debugText)
								if dEnd ~= string.len(lowered) then
									foundWholeText = false
									text = string.sub(text, dEnd + 1)
								end
								break
							end
						end
					end
					local foundDeepScan1 = false
					if not foundWholeText then
						local lowered = strutf8lower(text)
						-- Pattern scan
						for _, pattern in ipairs(L.DeepScanPatterns) do -- try all patterns in order
							local _, _, statText1, value, statText2 = strfind(lowered, pattern)
							if value then
								local statText = statText1..statText2
								local idTable = L.StatIDLookup[statText]
								if idTable == false then
									foundDeepScan1 = true
									found = true
									debugPrint("|cffadadad".."  DeepScan Exclude: "..text)
									break -- break out of pattern loop and go to the next separated text
								elseif idTable then
									foundDeepScan1 = true
									found = true
									local debugText = "|cffff5959".."  DeepScan: ".."|cffffc259"..text
									for _, id in ipairs(idTable) do
										--debugPrint("  '"..value.."', '"..id.."'")
										-- sum stat
										table[id] = (table[id] or 0) + tonumber(value)
										debugText = debugText..", ".."|cffffff59"..tostring(id).."="..tostring(value)
									end
									debugPrint(debugText)
									break -- break out of pattern loop and go to the next separated text
								else
									-- Not matching pattern
								end
							end
						end
					end
					-- If still not found, use the word separators to split the text
					if not foundWholeText and not foundDeepScan1 then
						-- Replace separators with @
						for _, sep in ipairs(L.DeepScanWordSeparators) do
							if strfind(text, sep) then
								text = gsub(text, sep, "@")
							end
						end
						-- Split text using @
						text = {strsplit("@", text)}
						for j, text in ipairs(text) do
							-- Trim spaces
							text = strtrim(text)
							-- Strip trailing "."
							if strutf8sub(text, -1) == L["."] then
								text = strutf8sub(text, 1, -2)
							end
							debugPrint("|cff008080".."S"..i.."-"..j..": ".."'"..text.."'")
							-- Whole Text Lookup
							local foundWholeText = false
							local idTable = L.WholeTextLookup[text]
							if idTable == false then
								foundWholeText = true
								found = true
								debugPrint("|cffadadad".."  DeepScan2 WholeText Exclude: "..text)
							elseif idTable then
								foundWholeText = true
								found = true
								for id, value in pairs(L.WholeTextLookup[text]) do
									-- sum stat
									table[id] = (table[id] or 0) + value
									debugPrint("|cffff5959".."  DeepScan2 WholeText: ".."|cffffc259"..text..", ".."|cffffff59"..tostring(id).."="..tostring(value))
								end
							else
								-- pattern match but not found in L.WholeTextLookup, keep looking
							end
							-- Scan DualStatPatterns
							if not foundWholeText then
								for pattern, dualStat in pairs(L.DualStatPatterns) do
									local lowered = strutf8lower(text)
									local _, _, value1, value2 = strfind(lowered, pattern)
									if value1 and value2 then
										foundWholeText = true
										found = true
										local debugText = "|cffff5959".."  DeepScan2 DualStat: ".."|cffffc259"..text
										for _, id in ipairs(dualStat[1]) do
											--debugPrint("  '"..value.."', '"..id.."'")
											-- sum stat
											table[id] = (table[id] or 0) + tonumber(value1)
											debugText = debugText..", ".."|cffffff59"..tostring(id).."="..tostring(value1)
										end
										for _, id in ipairs(dualStat[2]) do
											--debugPrint("  '"..value.."', '"..id.."'")
											-- sum stat
											table[id] = (table[id] or 0) + tonumber(value2)
											debugText = debugText..", ".."|cffffff59"..tostring(id).."="..tostring(value2)
										end
										debugPrint(debugText)
										break
									end
								end
							end
							local foundDeepScan2 = false
							if not foundWholeText then
								local lowered = strutf8lower(text)
								-- Pattern scan
								for _, pattern in ipairs(L.DeepScanPatterns) do
									local _, _, statText1, value, statText2 = strfind(lowered, pattern)
									if value then
										local statText = statText1..statText2
										local idTable = L.StatIDLookup[statText]
										if idTable == false then
											foundDeepScan2 = true
											found = true
											debugPrint("|cffadadad".."  DeepScan2 Exclude: "..text)
											break
										elseif idTable then
											foundDeepScan2 = true
											found = true
											local debugText = "|cffff5959".."  DeepScan2: ".."|cffffc259"..text
											for _, id in ipairs(idTable) do
												--debugPrint("  '"..value.."', '"..id.."'")
												-- sum stat
												table[id] = (table[id] or 0) + tonumber(value)
												debugText = debugText..", ".."|cffffff59"..tostring(id).."="..tostring(value)
											end
											debugPrint(debugText)
											break
										else
											-- pattern match but not found in L.StatIDLookup, keep looking
											debugPrint("  DeepScan2 Lookup Fail: |cffffd4d4'"..statText.."'|r, pattern = |cff72ff59'"..pattern.."'")
										end
									end
								end -- for
							end
							if not foundWholeText and not foundDeepScan2 then
								debugPrint("  DeepScan2 Fail: |cffff0000'"..text.."'")
							end
						end
					end -- if not foundWholeText and not foundDeepScan1 then
				end
			end

			if not found then
				debugPrint("  No Match: |cffff0000'"..text.."'")
				-- if DEBUG and RatingBuster then
					-- RatingBuster.db.profile.test = text
				-- end
			end
		else
			--debugPrint("Excluded: "..text)
		end
	end
	-- Tooltip scanning done, do post processing
	--[[ 3.0.8
	Bonus Armor: The mechanics for items with bonus armor on them has 
	changed (any cloth, leather, mail, or plate items with extra armor,
	or any other items with any armor). Bonus armor beyond the base 
	armor of an item will no longer be multiplied by any talents or by 
	the bonuses of Bear Form, Dire Bear Form, or Frost Presence.
	--]]
	if bonusArmorItemEquipLoc[itemType] and table["ARMOR"] then
		-- Convert "ARMOR" to "ARMOR_BONUS"
		table["ARMOR_BONUS"] = (table["ARMOR_BONUS"] or 0) + table["ARMOR"]
		table["ARMOR"] = nil
	end
	cache[link] = copy(table)
	return table
end

function StatLogic:GetFinalArmor(item, text)
	-- Locale check
	if noPatternLocale then return end
	local _
	-- Check item
	if (type(item) == "string") or (type(item) == "number") then -- common case first
	elseif type(item) == "table" and type(item.GetItem) == "function" then
		-- Get the link
		_, item = item:GetItem()
		if type(item) ~= "string" then return end
	else
		return
	end
	-- Check if item is in local cache
	local name, _, rarity , ilvl, _, _, armorType, _, itemType = GetItemInfo(item)
	if not name then return end
	
	
	for pattern, id in pairs(L.PreScanPatterns) do
		if id == "ARMOR" or id == "ARMOR_BONUS" then
			local found, _, value = strfind(text, pattern)
			if found then
				local armor = 0
				local bonus_armor = 0
				if id == "ARMOR" and baseArmorTable[rarity] and baseArmorTable[rarity][itemType] and 
				baseArmorTable[rarity][itemType][armorType] and baseArmorTable[rarity][itemType][armorType][ilvl] and
				tonumber(value) > baseArmorTable[rarity][itemType][armorType][ilvl] then
					armor = baseArmorTable[rarity][itemType][armorType][ilvl]
					bonus_armor = tonumber(value) - baseArmorTable[rarity][itemType][armorType][ilvl]
				else
					armor = tonumber(value)
				end
				if bonusArmorItemEquipLoc[itemType] then
					bonus_armor = bonus_armor + armor
					armor = 0
				end
				return armor * self:GetStatMod("MOD_ARMOR") + bonus_armor
			end
		end
	end
end

--[[---------------------------------
	:GetDiffID(item, [ignoreEnchant], [ignoreGem], [red], [yellow], [blue], [meta], [ignorePris])
-------------------------------------
Notes:
	* Returns a unique identification string of the diff calculation, the identification string is made up of links concatenated together, can be used for cache indexing
	* item:
	:;tooltip : table - The tooltip showing the item
	:;itemId : number - The numeric ID of the item. ie. 12345
	:;"itemString" : string - The full item ID in string format, e.g. "item:12345:0:0:0:0:0:0:0".
	:::Also supports partial itemStrings, by filling up any missing ":x" value with ":0", e.g. "item:12345:0:0:0"
	:;"itemName" : string - The Name of the Item, ex: "Hearthstone"
	:::The item must have been equiped, in your bags or in your bank once in this session for this to work.
	:;"itemLink" : string - The itemLink, when Shift-Clicking items.
Arguments:
	number or string or table - tooltip or itemId or "itemString" or "itemName" or "itemLink"
	boolean - Ignore enchants when calculating the id if true
	boolean - Ignore gems when calculating the id if true
	number or string - gemID to replace a red socket
	number or string - gemID to replace a yellow socket
	number or string - gemID to replace a blue socket
	number or string - gemID to replace a meta socket
	boolean - Ignore prismatic sockets when calculating the id if true
Returns:
	; id : string - a unique identification string of the diff calculation, for use as cache key
	; link : string - link of main item
	; linkDiff1 : string - link of compare item 1
	; linkDiff2 : string - link of compare item 2
Example:
	StatLogic:GetDiffID(21417) -- Ring of Unspoken Names
	StatLogic:GetDiffID("item:18832:2564:0:0:0:0:0:0", true, true) -- Brutality Blade with +15 agi enchant
	http://www.wowwiki.com/EnchantId
-----------------------------------]]

local getSlotID = {
	INVTYPE_AMMO           = 0,
	INVTYPE_GUNPROJECTILE  = 0,
	INVTYPE_BOWPROJECTILE  = 0,
	INVTYPE_HEAD           = 1,
	INVTYPE_NECK           = 2,
	INVTYPE_SHOULDER       = 3,
	INVTYPE_BODY           = 4,
	INVTYPE_CHEST          = 5,
	INVTYPE_ROBE           = 5,
	INVTYPE_WAIST          = 6,
	INVTYPE_LEGS           = 7,
	INVTYPE_FEET           = 8,
	INVTYPE_WRIST          = 9,
	INVTYPE_HAND           = 10,
	INVTYPE_FINGER         = {11,12},
	INVTYPE_TRINKET        = {13,14},
	INVTYPE_CLOAK          = 15,
	INVTYPE_WEAPON         = {16,17},
	INVTYPE_2HWEAPON       = 16+17,
	INVTYPE_WEAPONMAINHAND = 16,
	INVTYPE_WEAPONOFFHAND  = 17,
	INVTYPE_SHIELD         = 17,
	INVTYPE_HOLDABLE       = 17,
	INVTYPE_RANGED         = 18,
	INVTYPE_RANGEDRIGHT    = 18,
	INVTYPE_RELIC          = 18,
	INVTYPE_GUN            = 18,
	INVTYPE_CROSSBOW       = 18,
	INVTYPE_WAND           = 18,
	INVTYPE_THROWN         = 18,
	INVTYPE_TABARD         = 19,
}

function HasTitanGrip(talentGroup)
	if playerClass == "WARRIOR" then
		local _, _, _, _, r = GetTalentInfo(2, 27, nil, nil, talentGroup)
		return r > 0
	end
end

function StatLogic:GetDiffID(item, ignoreEnchant, ignoreGem, red, yellow, blue, meta, ignorePris)
	local _, name, itemType, link, linkDiff1, linkDiff2
	-- Check item
	if (type(item) == "string") or (type(item) == "number") then
	elseif type(item) == "table" and type(item.GetItem) == "function" then
		-- Get the link
		_, item = item:GetItem()
		if type(item) ~= "string" then return end
	else
		return
	end
	-- Check if item is in local cache
	name, link, _, _, _, _, _, _, itemType = GetItemInfo(item)
	if not name then return end
	-- Get equip location slot id for use in GetInventoryItemLink
	local slotID = getSlotID[itemType]
	-- Don't do bags
	if not slotID then return end

	-- 1h weapon, check if player can dual wield, check for 2h equipped
	if itemType == "INVTYPE_WEAPON" then
		linkDiff1 = GetInventoryItemLink("player", 16) or "NOITEM"
		-- If player can Dual Wield, calculate offhand difference
		if IsUsableSpell(GetSpellInfo(674)) then		-- ["Dual Wield"]
			local _, _, _, _, _, _, _, _, eqItemType = GetItemInfo(linkDiff1)
			-- If 2h is equipped, copy diff1 to diff2
			if eqItemType == "INVTYPE_2HWEAPON" and not HasTitanGrip() then
				linkDiff2 = linkDiff1
			else
				linkDiff2 = GetInventoryItemLink("player", 17) or "NOITEM"
			end
		end
	-- Ring or trinket
	elseif type(slotID) == "table" then
		-- Get slot link
		linkDiff1 = GetInventoryItemLink("player", slotID[1]) or "NOITEM"
		linkDiff2 = GetInventoryItemLink("player", slotID[2]) or "NOITEM"
	-- 2h weapon, so we calculate the difference with equipped main hand and off hand
	elseif itemType == "INVTYPE_2HWEAPON" then
		linkDiff1 = GetInventoryItemLink("player", 16) or "NOITEM"
		linkDiff2= GetInventoryItemLink("player", 17) or "NOITEM"
	-- Off hand slot, check if we have 2h equipped
	elseif slotID == 17 then
		linkDiff1 = GetInventoryItemLink("player", 16) or "NOITEM"
		-- If 2h is equipped
		local _, _, _, _, _, _, _, _, eqItemType = GetItemInfo(linkDiff1)
		if eqItemType ~= "INVTYPE_2HWEAPON" then
			linkDiff1 = GetInventoryItemLink("player", 17) or "NOITEM"
		end
	-- Single slot item
	else
		linkDiff1 = GetInventoryItemLink("player", slotID) or "NOITEM"
	end

	-- Ignore Enchants
	if ignoreEnchant then
		link = self:RemoveEnchant(link)
		linkDiff1 = self:RemoveEnchant(linkDiff1)
		if linkDiff2 then
			linkDiff2 = self:RemoveEnchant(linkDiff2)
		end
	end
	if ignorePris then
		link = self:RemoveExtraSocketGem(link)
		linkDiff1 = self:RemoveExtraSocketGem(linkDiff1)
		if linkDiff2 then
			linkDiff2 = self:RemoveExtraSocketGem(linkDiff2)
		end
	end

	-- Ignore Gems
	if ignoreGem then
		link = self:RemoveGem(link)
		linkDiff1 = self:RemoveGem(linkDiff1)
		if linkDiff2 then
			linkDiff2 = self:RemoveGem(linkDiff2)
		end
	else
		link = self:BuildGemmedTooltip(link, red, yellow, blue, meta)
		linkDiff1 = self:BuildGemmedTooltip(linkDiff1, red, yellow, blue, meta)
		if linkDiff2 then
			linkDiff2 = self:BuildGemmedTooltip(linkDiff2, red, yellow, blue, meta)
		end
	end

	-- Build ID string
	local id = link..linkDiff1
	if linkDiff2 then
		id = id..linkDiff2
	end

	return id, link, linkDiff1, linkDiff2
end


--[[---------------------------------
	:GetDiff(item, [diff1], [diff2], [ignoreEnchant], [ignoreGem], [red], [yellow], [blue], [meta], [ignorePris])
-------------------------------------
Notes:
	* Calculates the stat diffrence from the specified item and your currently equipped items.
	* item:
	:;tooltip : table - The tooltip showing the item
	:;itemId : number - The numeric ID of the item. ie. 12345
	:;"itemString" : string - The full item ID in string format, e.g. "item:12345:0:0:0:0:0:0:0".
	:::Also supports partial itemStrings, by filling up any missing ":x" value with ":0", e.g. "item:12345:0:0:0"
	:;"itemName" : string - The Name of the Item, ex: "Hearthstone"
	:::The item must have been equiped, in your bags or in your bank once in this session for this to work.
	:;"itemLink" : string - The itemLink, when Shift-Clicking items.
Arguments:
	number or string or table - tooltip or itemId or "itemString" or "itemName" or "itemLink"
	table - Stat difference of item and equipped item 1 are writen to this table if provided
	table - Stat difference of item and equipped item 2 are writen to this table if provided
	boolean - Ignore enchants when calculating stat diffrences
	boolean - Ignore gems when calculating stat diffrences
	number or string - gemID to replace a red socket
	number or string - gemID to replace a yellow socket
	number or string - gemID to replace a blue socket
	number or string - gemID to replace a meta socket
	boolean - Ignore prismatic sockets when calculating the id if true
Returns:
	; diff1 : table - The table with stat diff values for item 1
	:{
	::	["STAT_ID1"] = value,
	::	["STAT_ID2"] = value,
	:}
	; diff2 : table - The table with stat diff values for item 2
	:{
	::	["STAT_ID1"] = value,
	::	["STAT_ID2"] = value,
	:}
Example:
	StatLogic:GetDiff(21417, {}) -- Ring of Unspoken Names
	StatLogic:GetDiff(21452) -- Staff of the Ruins
-----------------------------------]]

-- TODO 2.1.0: Use SetHyperlinkCompareItem in StatLogic:GetDiff
function StatLogic:GetDiff(item, diff1, diff2, ignoreEnchant, ignoreGem, red, yellow, blue, meta, ignorePris)
	-- Locale check
	if noPatternLocale then return end

	-- Get DiffID
	local id, link, linkDiff1, linkDiff2 = self:GetDiffID(item, ignoreEnchant, ignoreGem, red, yellow, blue, meta, ignorePris)
	if not id then return end

	-- Clear Tables
	clearTable(diff1)
	clearTable(diff2)

	-- Get diff data from cache if available
	if cache[id..1] then
		copyTable(diff1, cache[id..1])
		if cache[id..2] then
			copyTable(diff2, cache[id..2])
		end
		return diff1, diff2
	end

	-- Get item sum, results are written into diff1 table
	itemSum = self:GetSum(link)
	if not itemSum then return end
	local itemType = itemSum.itemType

	if itemType == "INVTYPE_2HWEAPON" and not HasTitanGrip() then
		local equippedSum1, equippedSum2
		-- Get main hand item sum
		if linkDiff1 == "NOITEM" then
			equippedSum1 = newStatTable()
		else
			equippedSum1 = self:GetSum(linkDiff1)
		end
		-- Get off hand item sum
		if linkDiff2 == "NOITEM" then
			equippedSum2 = newStatTable()
		else
			equippedSum2 = self:GetSum(linkDiff2)
		end
		-- Calculate diff
		diff1 = copyTable(diff1, itemSum) - equippedSum1 - equippedSum2
		-- Return table to pool
		del(equippedSum1)
		del(equippedSum2)
	else
		local equippedSum
		-- Get equipped item 1 sum
		if linkDiff1 == "NOITEM" then
			equippedSum = newStatTable()
		else
			equippedSum = self:GetSum(linkDiff1)
		end
		-- Calculate item 1 diff
		diff1 = copyTable(diff1, itemSum) - equippedSum
		-- Clean up
		del(equippedSum)
		equippedSum = nil
		-- Check if item has a second equip slot
		if linkDiff2 then -- If so
			-- Get equipped item 2 sum
			if linkDiff2 == "NOITEM" then
				equippedSum = newStatTable()
			else
				equippedSum = self:GetSum(linkDiff2)
			end
			-- Calculate item 2 diff
			diff2 = copyTable(diff2, itemSum) - equippedSum
			-- Clean up
			del(equippedSum)
		end
	end
	-- Return itemSum table to pool
	del(itemSum)
	-- Write cache
	copyTable(cache[id..1], diff1)
	if diff2 then
		copyTable(cache[id..2], diff2)
	end
	-- return tables
	return diff1, diff2
end


-----------
-- DEBUG --
-----------
-- StatLogic:Bench(1000)
---------
-- self:GetSum(link, table)
-- 1000 times: 0.6 sec without cache
-- 1000 times: 0.012 sec with cache
---------
-- ItemBonusLib:ScanItemLink(link)
-- 1000 times: 1.58 sec
---------
-- LibItemBonus:ScanItem(link, true)
-- 1000 times: 0.72 sec without cache
-- 1000 times: 0.009 sec with cache
---------
--[[
LoadAddOn("LibItemBonus-2.0")
local LibItemBonus = LibStub("LibItemBonus-2.0")
-- #NODOC
function StatLogic:Bench(k)
	DEFAULT_CHAT_FRAME:AddMessage("test")
	local t = GetTime()
	local link = GetInventoryItemLink("player", 12)
	local table = {}
	--local GetItemInfo = _G["GetItemInfo"]
	for i = 1, k do
		---------------------------------------------------------------------------
		--self:SplitDoJoin("+24 Agility/+4 Stamina, +4 Dodge and +4 Spell Crit/+5 Spirit", {"/", " and ", ","})
		---------------------------------------------------------------------------
		self:GetSum(link)
		--LibItemBonus:ScanItemLink(link)
		---------------------------------------------------------------------------
		--ItemRefTooltip:SetScript("OnTooltipSetItem", function(frame, ...) RatingBuster:Print("OnTooltipSetItem") end)
		---------------------------------------------------------------------------
		--GetItemInfo(link)
	end
	DEFAULT_CHAT_FRAME:AddMessage(GetTime() - t)
	t = GetTime()
	for i = 1, k do
		LibItemBonus:ScanItem(link, true)
	end
	DEFAULT_CHAT_FRAME:AddMessage(GetTime() - t)
	--return GetTime() - t1
end
--]]
--[[
-- #NODOC
function StatLogic:PatternTest()
	patternTable = {
		"(%a[%a ]+%a) ?%d* ?%a* by u?p? ?t?o? ?(%d+) ?a?n?d? ?", -- xxx xxx by 22 (scan first)
		"(%a[%a ]+) %+(%d+) ?a?n?d? ?", -- xxx xxx +22 (scan 2ed)
		"(%d+) ([%a ]+) ?a?n?d? ?", -- 22 xxx xxx (scan last)
	}
	textTable = {
		"Spell Damage +6 and Spell Hit Rating +5",
		"+3 Stamina, +4 Critical Strike Rating",
		"+26 Healing Spells & 2% Reduced Threat",
		"+3 Stamina/+4 Critical Strike Rating",
		"Socket Bonus: 2 mana per 5 sec.",
		"Equip: Increases damage and healing done by magical spells and effects by up to 150.",
		"Equip: Increases the spell critical strike rating of all party members within 30 yards by 28.",
		"Equip: Increases damage and healing done by magical spells and effects of all party members within 30 yards by up to 33.",
		"Equip: Increases healing done by magical spells and effects of all party members within 30 yards by up to 62.",
		"Equip: Increases your spell damage by up to 120 and your healing by up to 300.",
		"Equip: Restores 11 mana per 5 seconds to all party members within 30 yards.",
		"Equip: Increases healing done by spells and effects by up to 300.",
		"Equip: Increases attack power by 420 in Cat, Bear, Dire Bear, and Moonkin forms only.",
	}
	for _, text in ipairs(textTable) do
		DEFAULT_CHAT_FRAME:AddMessage(text.." = ")
		for _, pattern in ipairs(patternTable) do
			local found
			for k, v in gmatch(text, pattern) do
				found = true
				DEFAULT_CHAT_FRAME:AddMessage("  '"..k.."', '"..v.."'")
			end
			if found then
				DEFAULT_CHAT_FRAME:AddMessage("  using: "..pattern)
				DEFAULT_CHAT_FRAME:AddMessage("----------------------------")
				break
			end
		end
	end
end
--]]

_G.StatLogic = StatLogic

----------------------
-- API doc template --
----------------------
--[[---------------------------------
	:SetTip(item)
-------------------------------------
Notes:
	* This is a debugging tool for localizers
	* Displays item in ItemRefTooltip
	* item:
	:;itemId : number - The numeric ID of the item. ie. 12345
	:;"itemString" : string - The full item ID in string format, e.g. "item:12345:0:0:0:0:0:0:0".
	:::Also supports partial itemStrings, by filling up any missing ":x" value with ":0", e.g. "item:12345:0:0:0"
	:;"itemName" : string - The Name of the Item, ex: "Hearthstone"
	:::The item must have been equiped, in your bags or in your bank once in this session for this to work.
	:;"itemLink" : string - The itemLink, when Shift-Clicking items.
	* Converts ClassID to and from "ClassName"
	* class:
	:{| class="wikitable"
	!ClassID!!"ClassName"
	|-
	|1||"WARRIOR"
	|-
	|2||"PALADIN"
	|-
	|3||"HUNTER"
	|-
	|4||"ROGUE"
	|-
	|5||"PRIEST"
	|-
	|6||"DEATHKNIGHT"
	|-
	|7||"SHAMAN"
	|-
	|8||"MAGE"
	|-
	|9||"WARLOCK"
	|-
	|10||"DRUID"
	|}
Arguments:
	number or string - itemId or "itemString" or "itemName" or "itemLink"
	[optional] string - Armor value. Default: player's armor value
	[optional] number - Attacker level. Default: player's level
	[optional] string or number - ClassID or "ClassName". Default: PlayerClass<br>See :GetClassIdOrName(class) for valid class values.
Returns:
	; modParry : number - The part that is affected by diminishing returns.
	; drFreeParry : number - The part that isn't affected by diminishing returns.
Example:
	StatLogic:SetTip("item:3185:0:0:0:0:0:1957")
-----------------------------------]]
