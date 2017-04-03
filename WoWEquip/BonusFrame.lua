----------------------------------------------------------------------------------------
-- WoWEquip file for the Bonus Frame

local WoWEquip = LibStub("AceAddon-3.0"):GetAddon("WoWEquip")
local L = LibStub("AceLocale-3.0"):GetLocale("WoWEquip", false)
local LS = LibStub("AceLocale-3.0"):GetLocale("WoWEquipLS", false)
local LIB = LibStub("LibItemBonus-2.0")
local LSL = LibStub("LibStatLogic-1.1")


----------------------------------------------------------------------------------------
-- Constants

local CAT_TITLES = {
	PLAYERSTAT_BASE_STATS, -- 1
	PLAYERSTAT_DEFENSES,   -- 2
	PLAYERSTAT_MELEE_COMBAT.."/"..PLAYERSTAT_RANGED_COMBAT, -- 3
	SPELLS,                -- 4
	L["Health and Mana"],  -- 5
	L["Resistances"],      -- 6
	L["Gems"],             -- 7
	L["Others"],           -- 8
	L["Sets"],             -- 9
}
local BONUS_CAT = {
	-- A table of constants describing which category a stat should be displayed under
	STR = 1,
	AGI = 1,
	STA = 1,
	INT = 1,
	SPI = 1,
	ARMOR = 2,
	BASE_ARMOR = -1,
	ARMOR_BONUS = -1,

	ARCANERES = 6,
	FIRERES = 6,
	FROSTRES = 6,
	HOLYRES = 6,
	NATURERES = 6,
	SHADOWRES = 6,

	FISHING = 8,
	MINING = 8,
	HERBALISM = 8,
	SKINNING = 8,
	DEFENSE = 2,

	BLOCK = 2,
	BLOCKVALUE = 2,
	DODGE = 2,
	PARRY = 2,
	ATTACKPOWER = 3,
	ATTACKPOWERUNDEAD = 3,
	ATTACKPOWERBEAST = 3,
	ATTACKPOWERFERAL = 3,
	CRIT = 3,
	RANGEDATTACKPOWER = 3,
	RANGEDCRIT = 3,
	TOHIT = 3,
	THREATREDUCTION = 8,

	SPELLPOWER = 4,
	SPELLCRIT = 4,
	SPELLTOHIT = 4,
	SPELLPEN = 4,

	HEALTHREG = 5,
	MANAREG = 5,
	HEALTH = 5,
	MANA = 5,

	--CR_WEAPON = 2,
	CR_DEFENSE = 2,
	CR_DODGE = 2,
	CR_PARRY = 2,
	CR_BLOCK = 2,
	CR_HIT = 3,
	CR_CRIT = 3,
	CR_HASTE = 3,
	CR_EXPERTISE = 3,
	CR_RESILIENCE = 2,
	CR_WEAPON_AXE = 3,
	CR_WEAPON_DAGGER = 3,
	CR_WEAPON_MACE = 3,
	CR_WEAPON_SWORD = 3,
	CR_WEAPON_SWORD_2H = 3,
	CR_ARMOR_PENETRATION = 3,

	CR_RANGEDCRIT = 3,
	CR_RANGEDHIT = 3,
	CR_WEAPON_FERAL = 3,
	CR_WEAPON_FIST = 3,
	CR_WEAPON_CROSSBOW = 3,
	CR_WEAPON_GUN = 3,
	CR_WEAPON_BOW = 3,
	CR_WEAPON_STAFF = 3,
	CR_WEAPON_MACE_2H = 3,
	CR_WEAPON_AXE_2H = 3,

	ATTACKPOWERDEMON = 2,
	ATTACKPOWERELEMENTAL = 2,
	ATTACKPOWERDRAGON = 2,

	CASTINGREG = 5,
	CASTINGREGROWTH = -1,
	CASTINGHOLYLIGHT = -1,
	CASTINGHEALINGTOUCH = -1,
	CASTINGFLASHHEAL = -1,
	CASTINGCHAINHEAL = -1,
	DURATIONREJUV = -1,
	DURATIONRENEW = -1,
	MANAREGNORMAL = -1,
	IMPCHAINHEAL = -1,
	IMPREJUVENATION = -1,
	IMPLESSERHEALINGWAVE = -1,
	IMPFLASHOFLIGHT = -1,
	REFUNDHEALINGWAVE = -1,
	JUMPHEALINGWAVE = -1,
	CHEAPERDRUID = -1,
	REFUNDHTCRIT = -1,
	CHEAPERRENEW = -1,

	STEALTH = 8,
	RANGED_SPEED_BONUS = 3, -- bags are not scanned
	SWIMSPEED = 8,
	MOUNTSPEED = 8,
	RUNSPEED = 8,
	--NEGPARRY = 2,
	MELEETAKEN = 8,
	DMGTAKEN = 8,
	CRITDMG = 8,
	MOD_BLOCKVALUE = 2,
	MOD_STA = 1,
	MELEEDMG = -1,
	HEALTHREG_P = 5,
	UNDERWATER = 8,
	LOCKPICK = 8,
	STEALTHDETECT = 8,
	DISARMREDUCTION = 8,
	SLOWFALL = 8,
	--IMPRESS = 8, -- not scanned
	--MOJO = 8, -- not scanned

	ARCANESPELLPOWER = 4,
	FIRESPELLPOWER = 4,
	FROSTSPELLPOWER = 4,
	HOLYSPELLPOWER = 4,
	NATURESPELLPOWER = 4,
	SHADOWSPELLPOWER = 4,

	--[[ Do we need these?
	ARCANECRIT = 4, FIRECRIT = 4, FROSTCRIT = 4, HOLYCRIT = 4, NATURECRIT = 4, SHADOWCRIT = 4,
	ARCANEHIT = 4, FIREHIT = 4, FROSTHIT = 4, HOLYHIT = 4, NATUREHIT = 4, SHADOWHIT = 4,
	--]]

	EMPTY_SOCKET_BLUE = 7,
	EMPTY_SOCKET_META = 7,
	EMPTY_SOCKET_RED = 7,
	EMPTY_SOCKET_YELLOW = 7,
	BLUE_GEM = 7,
	META_GEM = 7,
	RED_GEM = 7,
	YELLOW_GEM = 7,

	EXPERTISE = 3,
	MOD_ARMOR = 2,
	MOD_MANA = 5,
	MOD_DAMAGE_CRIT = 8,
	MOD_INT = 1,
	MOD_HEAL_CRIT = 4,
	SNAREREDUCTION = 8,
	SILENCEREDUCTION = 8,
	FEARREDUCTION = 8,
	STUNREDUCTION = 8,

	-- Additional duplicated stats because they apply to both melee
	-- and spells and have a separate conversion formula
	CR_SPELLHIT = 4,
	CR_SPELLCRIT = 4,
	CR_SPELLHASTE = 4,
}
local BONUS_CAT_T2 = {
	HEALTHFROMHP = 5,
	HEALTHFROMSTA = 5,
	HEALTHTOTAL = 5,
	MANAFROMMP = 5,
	MANAFROMINT = 5,
	MANATOTAL = 5,
}
-- Create a metatable for this table to generate new unknown entries to classify under "Others"
setmetatable(BONUS_CAT, {__index = function(tbl, key)
	if type(key) == "string" then
		tbl[key] = 8
		return 8
	end
end})
local BONUS_IS_RATING = {
	-- A table of constants describing which stats are ratings with conversion formulas
	CR_DEFENSE = true,
	CR_DODGE = true,
	CR_PARRY = true,
	CR_BLOCK = true,
	CR_HIT = true,
	CR_CRIT = true,
	CR_HASTE = true,
	CR_EXPERTISE = true,
	CR_RESILIENCE = true,
	CR_WEAPON_AXE = true,
	CR_WEAPON_DAGGER = true,
	CR_WEAPON_MACE = true,
	CR_WEAPON_SWORD = true,
	CR_WEAPON_SWORD_2H = true,
	CR_ARMOR_PENETRATION = true,
	CR_RANGEDCRIT = true,
	CR_RANGEDHIT = true,
	CR_WEAPON_FERAL = true,
	CR_WEAPON_FIST = true,
	CR_WEAPON_CROSSBOW = true,
	CR_WEAPON_GUN = true,
	CR_WEAPON_BOW = true,
	CR_WEAPON_STAFF = true,
	CR_WEAPON_MACE_2H = true,
	CR_WEAPON_AXE_2H = true,
	-- Additional duplicated stats because they apply to both melee
	-- and spells and have a separate conversion formula
	CR_SPELLHIT = true,
	CR_SPELLCRIT = true,
	CR_SPELLHASTE = true,
}
local BONUS_HAS_PERCENT = {
	-- A table of constants describing which stats should be shown with a % sign
	-- A stat in the BONUS_IS_RATING[] table is always displayed with no % when unconverted
	BLOCK = true,
	DODGE = true,
	PARRY = true,
	CRIT = true,
	RANGEDCRIT = true,
	TOHIT = true,

	SPELLCRIT = true,
	SPELLTOHIT = true,

	CR_DODGE = true,
	CR_PARRY = true,
	CR_BLOCK = true,
	CR_HIT = true,
	CR_CRIT = true,
	CR_HASTE = true,
	CR_RESILIENCE = true,
	CR_ARMOR_PENETRATION = true,
	CR_RANGEDCRIT = true,
	CR_RANGEDHIT = true,

	--[[ Do we need these?
	ARCANECRIT = true, FIRECRIT = true, FROSTCRIT = true, HOLYCRIT = true, NATURECRIT = true, SHADOWCRIT = true,
	ARCANEHIT = true, FIREHIT = true, FROSTHIT = true, HOLYHIT = true, NATUREHIT = true, SHADOWHIT = true,
	--]]

	-- Additional duplicated stats because they apply to both melee
	-- and spells and have a separate conversion formula
	CR_SPELLHIT = true,
	CR_SPELLCRIT = true,
	CR_SPELLHASTE = true,
}
local BONUS_HAS_PERCENT_NODECIMAL = {
	THREATREDUCTION = true,
	DISARMREDUCTION = true,
	MOD_ARMOR = true,
	MOD_MANA = true,
	MOD_DAMAGE_CRIT = true,
	MOD_INT = true,
	MOD_HEAL_CRIT = true,
	SNAREREDUCTION = true,
	SILENCEREDUCTION = true,
	FEARREDUCTION = true,
	STUNREDUCTION = true,

	CASTINGREG = true,

	RANGED_SPEED_BONUS = true, -- bags are not scanned
	SWIMSPEED = true,
	MOUNTSPEED = true,
	RUNSPEED = true,
	--NEGPARRY = true,
	CRITDMG = true,
	MOD_BLOCKVALUE = true,
	MOD_STA = true,
	SLOWFALL = true,
}
-- Set one table to include the other
setmetatable(BONUS_HAS_PERCENT, {__index = BONUS_HAS_PERCENT_NODECIMAL})
local USES_SPELLPOWER_BASE = {
	ARCANESPELLPOWER = true,
	FIRESPELLPOWER = true,
	FROSTSPELLPOWER = true,
	HOLYSPELLPOWER = true,
	NATURESPELLPOWER = true,
	SHADOWSPELLPOWER = true,
}
local USES_AP_BASE = {
	ATTACKPOWERUNDEAD = true,
	ATTACKPOWERBEAST = true,
	ATTACKPOWERFERAL = true,
	ATTACKPOWERDEMON = true,
	ATTACKPOWERELEMENTAL = true,
	ATTACKPOWERDRAGON = true,
	RANGEDATTACKPOWER = true,
}
--[[
local T2LOOKUP = {
	HEALTHFROMHP = "HEALTH",
	HEALTHFROMSTA = "STA",
	MANAFROMMP = "MANA",
	MANAFROMINT = "INT",
}
]]
local ITEM_SET_NAME_R = ITEM_SET_NAME:gsub("%d%$", ""):gsub("%(", "%%("):gsub("%)", "%%)"):gsub("%%s", "(.*)"):gsub("%%d", "(%%d)")
local CLASS_STRING = {
	WARRIOR = L["Warrior"],
	PALADIN = L["Paladin"],
	HUNTER = L["Hunter"],
	ROGUE = L["Rogue"],
	PRIEST = L["Priest"],
	DEATHKNIGHT = L["Death Knight"],
	SHAMAN = L["Shaman"],
	MAGE = L["Mage"],
	WARLOCK = L["Warlock"],
	DRUID = L["Druid"],
}
WoWEquip.CLASSES = CLASS_STRING


----------------------------------------------------------------------------------------
-- Local Variables

local currProfileValidSet = {}
local compProfileValidSet = {}
local textL = {}
local textR = {}
local str = {}
local setsizes = {}
local currTier2Data = {} --setmetatable({}, {})
local compTier2Data = {} --setmetatable({}, {})


----------------------------------------------------------------------------------------
-- Local Widget Functions

local function LevelInputBox_OnEditFocusLost(self)
	local level = tonumber(self:GetText()) or 0
	if level < 1 then
		level = 1
	elseif level > 80 then
		level = 80
	end
	self:SetText(level)
	self:HighlightText(0, 0)
	WoWEquip.curProfile.level = level
	WoWEquip:ChangeAllItemLinkLevels(level)
	WoWEquip:UpdateBonusFrame()
end

local function WoWEquip_ImportButton_OnClick(self, button, down)
	local WoWEquip_ImportFrame = WoWEquip.ImportFrame
	if WoWEquip_ImportFrame:IsShown() then
		WoWEquip_ImportFrame:Hide()
	else
		WoWEquip_ImportFrame:Show()
	end
end

----------------------------------------------------------------------------------------
-- Bonus Frame Functions

-- This function extracts the set size of an item belonging to a set
local function scanSetSize(itemLink)
	if not itemLink then return end
	local tt = WoWEquip.tooltip
	tt:ClearLines()
	tt:SetHyperlink(itemLink)

	for k = 2, tt:NumLines() do
		local text = tt.left[k]:GetText()
		local setname, _, setsize = strmatch(text, ITEM_SET_NAME_R)
		if setname and setsize then -- Note: setsize can be 0 if the item isn't fully in the cache
			setsizes[setname] = tonumber(setsize)
			BONUS_CAT[setname] = 9
			return
		end
	end
end

local function addGemColors(enchantID, bonusTable)
	local t = WoWEquip.GemColorData
	if t.blue[enchantID] then bonusTable.BLUE_GEM = (bonusTable.BLUE_GEM or 0) + 1 end
	if t.red[enchantID] then bonusTable.RED_GEM = (bonusTable.RED_GEM or 0) + 1 end
	if t.yellow[enchantID] then bonusTable.YELLOW_GEM = (bonusTable.YELLOW_GEM or 0) + 1 end
	if t.meta[enchantID] then bonusTable.META_GEM = (bonusTable.META_GEM or 0) + 1 end
end

-- This function sorts the bonuses in the bonus frame to be displayed
local function sortBonus(a, b)
	if BONUS_CAT[a] == BONUS_CAT[b] then
		return LS[a] < LS[b]
	else
		return BONUS_CAT[a] < BONUS_CAT[b]
	end
end

-- LibStatLogic version
--[[
local function sortBonus2(a, b)
	if BONUS_CAT[a] == BONUS_CAT[b] or not BONUS_CAT[a] or not BONUS_CAT[b] then
		return (LSL:GetStatNameFromID(a) or a) < (LSL:GetStatNameFromID(b) or b)
	else
		return BONUS_CAT[a] < BONUS_CAT[b]
	end
end
]]

-- This function modifies specialized bonuses to include the generic bonus
local function modifyBonuses(a, b)
	local admg = (a.SPELLPOWER or 0)
	local bdmg = (b.SPELLPOWER or 0)
	for bonus in next, USES_SPELLPOWER_BASE do
		if a[bonus] or b[bonus] then
			a[bonus] = (a[bonus] or 0) + admg
			b[bonus] = (b[bonus] or 0) + bdmg
		end
	end

	local aap = (a.ATTACKPOWER or 0)
	local bap = (b.ATTACKPOWER or 0)
	for bonus in next, USES_AP_BASE do
		if a[bonus] or b[bonus] then
			a[bonus] = (a[bonus] or 0) + aap
			b[bonus] = (b[bonus] or 0) + bap
		end
	end

	if a.CR_RANGEDCRIT or b.CR_RANGEDCRIT then
		a.CR_RANGEDCRIT = (a.CR_RANGEDCRIT or 0) + (a.CR_CRIT or 0)
		b.CR_RANGEDCRIT = (b.CR_RANGEDCRIT or 0) + (b.CR_CRIT or 0)
	end

	if a.CR_RANGEDHIT or b.CR_RANGEDHIT then
		a.CR_RANGEDHIT = (a.CR_RANGEDHIT or 0) + (a.CR_HIT or 0)
		b.CR_RANGEDHIT = (b.CR_RANGEDHIT or 0) + (b.CR_HIT or 0)
	end

	if a.CR_RANGEDHASTE or b.CR_RANGEDHASTE then
		a.CR_RANGEDHASTE = (a.CR_RANGEDHASTE or 0) + (a.CR_HASTE or 0)
		b.CR_RANGEDHASTE = (b.CR_RANGEDHASTE or 0) + (b.CR_HASTE or 0)
	end
	
	a.ARMOR = (a.BASE_ARMOR or 0) + (a.ARMOR_BONUS or 0)
	b.ARMOR = (b.BASE_ARMOR or 0) + (b.ARMOR_BONUS or 0)
	if a.ARMOR == 0 and b.ARMOR == 0 then
		a.ARMOR = nil
		b.ARMOR = nil
	end
end

function WoWEquip:GenerateTier2Data(i, o, level, class) -- i = input, o = output
	wipe(o)
	local defenseBonus	= floor(LIB:GetRatingBonus("CR_DEFENSE", i.CR_DEFENSE or 0, level, class)) * 0.04 -- to block/parry/dodge

	--o.HEALTHFROMHP = (i.HEALTH or 0)
	--o.HEALTHFROMSTA = (i.STA or 0) * 10 * (1 + (i.MOD_STA or 0)/100)
	--o.HEALTHTOTAL = o.HEALTHFROMHP + o.HEALTHFROMSTA
	o.HEALTH = (i.HEALTH or 0) + (i.STA or 0) * 10 * (1 + (i.MOD_STA or 0)/100)

	--o.MANAFROMMP = (i.MANA or 0) * (1 + (i.MOD_MANA or 0)/100)
	--o.MANAFROMINT = (i.INT or 0) * 15 * (1 + (i.MOD_INT or 0)/100) * (1 + (i.MOD_MANA or 0)/100)
	--o.MANATOTAL = (o.MANAFROMMP + o.MANAFROMINT)
	o.MANA = ((i.MANA or 0) + (i.INT or 0) * 15 * (1 + (i.MOD_INT or 0)/100)) * (1 + (i.MOD_MANA or 0)/100)

	o.ATTACKPOWER = (i.ATTACKPOWER or 0) + LSL:GetAPFromStr(i.STR or 0, class) + LSL:GetAPFromAgi(i.AGI or 0, class)
	o.RANGEDATTACKPOWER = (i.RANGEDATTACKPOWER or i.ATTACKPOWER or 0) + LSL:GetRAPFromAgi(i.AGI or 0, class)
	o.CRIT = LIB:GetRatingBonus("CR_CRIT", i.CR_CRIT or 0, level, class) + LSL:GetCritFromAgi(i.AGI or 0, class, level)
	o.RANGEDCRIT = LIB:GetRatingBonus("CR_RANGEDCRIT", i.CR_RANGEDCRIT or i.CR_CRIT or 0, level, class) + LSL:GetCritFromAgi(i.AGI or 0, class, level)
	o.SPELLCRIT = LIB:GetRatingBonus("CR_SPELLCRIT", i.CR_SPELLCRIT or 0, level, class) + LSL:GetSpellCritFromInt(i.INT or 0, class, level)
	o.ARMOR = (i.ARMOR or 0) + (i.AGI or 0) * 2

	-- Because StatLogic doesn't return 0 for non-shield-using classes
	-- Formula: str * BlockValuePerStr[class] - 10
	local blockFromStr = floor(LSL:GetBlockValueFromStr(i.STR or 0, class))
	if blockFromStr == -10 then blockFromStr = 0 end
	o.BLOCKVALUE = (i.BLOCKVALUE or 0) + blockFromStr

	o.BLOCK = LIB:GetRatingBonus("CR_BLOCK", i.CR_BLOCK or 0, level, class) + defenseBonus
	o.DODGE = LIB:GetRatingBonus("CR_DODGE", i.CR_DODGE or 0, level, class) + LSL:GetDodgeFromAgi(i.AGI or 0, class, level) + defenseBonus
	o.PARRY = LIB:GetRatingBonus("CR_PARRY", i.CR_PARRY or 0, level, class) + defenseBonus
end

function WoWEquip:GenerateBonusString(currBonuses, currLevel, currClass, compBonuses, compLevel, compClass, textL, textR)
	local db = self.db.global
	local compare = db.CompareOption
	local showRating = db.ShowRating

	-- Sort the bonuses by category and text
	local line = 0
	wipe(str)
	for bonus, value in pairs(currBonuses) do
		if BONUS_CAT[bonus] ~= -1 then -- Ignore any bonus with a category of -1
			line = line + 1
			str[line] = bonus
		end
	end
	table.sort(str, sortBonus)
	--table.sort(str, sortBonus2) -- LibStatLogic version

	-- Generate the text
	wipe(textL)
	wipe(textR)
	line = 0
	local currCat = 0
	for i = 1, #str do
		local bonus = str[i]
		local cat = BONUS_CAT[bonus]
		local value, diff, color

		-- Convert ratings?
		if BONUS_IS_RATING[bonus] and not showRating then
			value = LIB:GetRatingBonus(bonus, currBonuses[bonus], currLevel, currClass)
			diff = compare == 1 and 0 or value - LIB:GetRatingBonus(bonus, compBonuses[bonus], compLevel, compClass)
			-- LibStatLogic version
			--value = LSL:GetEffectFromRating(currBonuses[bonus], bonus, currLevel, currClass)
			--diff = compare == 1 and 0 or value - LSL:GetEffectFromRating(compBonuses[bonus], bonus, compLevel, compClass)
		else
			value = currBonuses[bonus]
			diff = compare == 1 and 0 or value - compBonuses[bonus]
		end
		color = diff >= 0 and GREEN_FONT_COLOR_CODE or RED_FONT_COLOR_CODE --"|cFF00FF00" or "|cFFFF0000"

		-- Add the category header?
		if cat ~= currCat then
			if currCat ~= 0 then
				line = line + 1
				textL[line] = " "
				textR[line] = " "
			end
			line = line + 1
			textL[line] = "|cFFFFFFFF"..CAT_TITLES[cat].."|r"
			textR[line] = " "
			currCat = cat
		end

		-- Add the stat line
		line = line + 1
		if cat == 9 then
			local setsize = setsizes[bonus]
			if setsize == 0 then
				-- Refresh the display 1 second later to rescan the set size
				setsize = "?"
				WoWEquip.frame.elapsed = 0
				WoWEquip.frame:SetScript("OnUpdate", WoWEquip.frame.RefreshBonus)
			end
			textL[line] = format("  %s |cFF00FF00(%d/%s)|r", bonus, value, setsize)
		else
			textL[line] = "  "..LS[bonus]
			--textL[line] = format("  "..LS[bonus], currBonuses[ T2LOOKUP[bonus] ] or 0)
			--textL[line] = "  "..(LSL:GetStatNameFromID(bonus) or bonus) -- LibStatLogic version
		end
		if compare == 1 then
			if BONUS_HAS_PERCENT[bonus] and (not BONUS_IS_RATING[bonus] or not showRating) then
				if BONUS_HAS_PERCENT_NODECIMAL[bonus] then
					textR[line] = format("%d%%", value)
				else
					textR[line] = format("%.2f%%", value)
				end
			else
				textR[line] = value
			end
		else
			if BONUS_HAS_PERCENT[bonus] and (not BONUS_IS_RATING[bonus] or not showRating) then
				if BONUS_HAS_PERCENT_NODECIMAL[bonus] then
					textR[line] = format("%d%% %s(%+d%%)|r", value, color, diff)
				else
					textR[line] = format("%.2f%% %s(%+.2f%%)|r", value, color, diff)
				end
			else
				textR[line] = format("%d %s(%+d)|r", value, color, diff)
			end
		end
	end
end

WoWEquip.frame.elapsed = 0
function WoWEquip.frame.RefreshBonus(self, elapsed)
	self.elapsed = self.elapsed + elapsed
	if self.elapsed >= 1 then
		self:SetScript("OnUpdate", nil)
		WoWEquip:UpdateBonusFrame()
	end
end

function WoWEquip:UpdateBonusFrame()
	if not self.frame:IsShown() then return end

	local db = self.db.global
	local compare = db.CompareOption
	local showRating = db.ShowRating
	local notInCache = false

	if compare == 1 then
		self.frame.BonusFrame.CompareText:SetText(L["Comparing:"].." "..L["Don't compare"])
	elseif compare == 2 then
		self.frame.BonusFrame.CompareText:SetText(L["Comparing:"].." "..L["Currently equipped gear"])
	elseif compare == 3 then
		self.frame.BonusFrame.CompareText:SetText(L["Comparing:"].." "..db.CompareProfile)
	end

	-- Build sets of equipment that are only available in the cache
	wipe(currProfileValidSet)
	local currLevel = self.curProfile.level
	local currClass = self.curProfile.class
	for slotname, itemLink in pairs(self.curProfile.eq) do
		if GetItemInfo(itemLink) then
			currProfileValidSet[slotname] = itemLink
		else
			notInCache = true
		end
	end

	-- Build valid set for compared set
	wipe(compProfileValidSet)
	local compLevel
	local compClass
	if compare == 2 then
		compLevel = UnitLevel("player")
		compClass = select(2, UnitClass("player"))
		for slotname, button in pairs(self.PaperDoll) do
			compProfileValidSet[slotname] = GetInventoryItemLink("player", button.slotnum)
		end
	elseif compare == 3 then
		local compProfile = db.profiles[db.CompareProfile]
		compLevel = compProfile.level
		compClass = compProfile.class
		for slotname, itemLink in pairs(compProfile.eq) do
			if GetItemInfo(itemLink) then
				compProfileValidSet[slotname] = itemLink
			else
				notInCache = true
			end
		end
	end

	-- Note: LIB returns new tables everytime
	local currDetails, currSetCount = LIB:BuildBonusSet(currProfileValidSet)
	local compDetails, compSetCount = LIB:BuildBonusSet(compProfileValidSet)
	local currBonuses = LIB:MergeDetails(currDetails)
	local compBonuses = LIB:MergeDetails(compDetails)

	-- Duplicate Hit, Crit and Haste ratings for their melee/spell versions
	if currBonuses.CR_HIT then currBonuses.CR_SPELLHIT = currBonuses.CR_HIT end
	if currBonuses.CR_CRIT then currBonuses.CR_SPELLCRIT = currBonuses.CR_CRIT end
	if currBonuses.CR_HASTE then currBonuses.CR_SPELLHASTE = currBonuses.CR_HASTE end
	if compBonuses.CR_HIT then compBonuses.CR_SPELLHIT = compBonuses.CR_HIT end
	if compBonuses.CR_CRIT then compBonuses.CR_SPELLCRIT = compBonuses.CR_CRIT end
	if compBonuses.CR_HASTE then compBonuses.CR_SPELLHASTE = compBonuses.CR_HASTE end

	-- LibStatLogic version
	--[[
	local currBonuses = {}
	local compBonuses = {}
	local temptable = {}
	-- LSL:GetSum() returns temptable with a __add metamethod
	for slotname, itemLink in pairs(currProfileValidSet) do
		currBonuses = currBonuses + LSL:GetSum(itemLink, temptable)
	end
	for slotname, itemLink in pairs(compProfileValidSet) do
		compBonuses = compBonuses + LSL:GetSum(itemLink, temptable)
	end
	]]

	-- Add the set counts to the bonuses
	for setname, value in pairs(currSetCount) do
		currBonuses[setname] = value
		local setsize = setsizes[setname]
		if not setsize or setsize == 0 then
			for slotname, itemLink in pairs(currProfileValidSet) do
				scanSetSize(itemLink)
			end
		end
	end
	for setname, value in pairs(compSetCount) do
		compBonuses[setname] = value
		local setsize = setsizes[setname]
		if not setsize or setsize == 0 then
			for slotname, itemLink in pairs(compProfileValidSet) do
				scanSetSize(itemLink)
			end
		end
	end

	-- Scan socketed gem color data
	for slotname, itemLink in pairs(currProfileValidSet) do
		local jewelId1, jewelId2, jewelId3, jewelId4 = strmatch(itemLink, "item:%d+:%d+:(%d+):(%d+):(%d+):(%d+)")
		addGemColors(tonumber(jewelId1), currBonuses)
		addGemColors(tonumber(jewelId2), currBonuses)
		addGemColors(tonumber(jewelId3), currBonuses)
		addGemColors(tonumber(jewelId4), currBonuses)
	end
	for slotname, itemLink in pairs(compProfileValidSet) do
		local jewelId1, jewelId2, jewelId3, jewelId4 = strmatch(itemLink, "item:%d+:%d+:(%d+):(%d+):(%d+):(%d+)")
		addGemColors(tonumber(jewelId1), compBonuses)
		addGemColors(tonumber(jewelId2), compBonuses)
		addGemColors(tonumber(jewelId3), compBonuses)
		addGemColors(tonumber(jewelId4), compBonuses)
	end

	-- If we're comparing profiles, make every key in both tables exist in the other table
	if compare ~= 1 then
		for bonus, value in pairs(currBonuses) do
			if not compBonuses[bonus] then compBonuses[bonus] = 0 end
		end
		for bonus, value in pairs(compBonuses) do
			if not currBonuses[bonus] then currBonuses[bonus] = 0 end
		end
	end

	-- Modify the bonuses to apply generic bonuses on specific ones
	modifyBonuses(currBonuses, compBonuses)

	-- Generate the strings for Equipment Stats
	self:GenerateBonusString(currBonuses, currLevel, currClass, compBonuses, compLevel, compClass, textL, textR)
	WoWEquip_BonusScrollFrame.ScrollChild.BonusTextL:SetText(table.concat(textL, "\n"))
	WoWEquip_BonusScrollFrame.ScrollChild.BonusTextR:SetText(table.concat(textR, "\n"))

	-- Generate Tier2 stats data
	self:GenerateTier2Data(currBonuses, currTier2Data, currLevel, currClass)
	self:GenerateTier2Data(compBonuses, compTier2Data, compLevel, compClass)

	if compare == 1 then
		-- If not comparing profiles, then remove all the 0 entries from the target
		-- profile table so that negative difference entries don't get generated
		for k, v in pairs(currTier2Data) do
			if v == 0 then currTier2Data[k] = nil end
		end
	else
		-- If we're comparing profiles, make every key in both tables exist in the other table
		-- unless they are both 0
		for bonus, value in pairs(currTier2Data) do
			if not compTier2Data[bonus] then compTier2Data[bonus] = 0 end
			if compTier2Data[bonus] == 0 and currTier2Data[bonus] == 0 then
				 currTier2Data[bonus] = nil
				 compTier2Data[bonus] = nil
			end
		end
		for bonus, value in pairs(compTier2Data) do
			if not currTier2Data[bonus] then currTier2Data[bonus] = 0 end
		end
	end

	-- Generate the strings for Derived Stats
	--getmetatable(currTier2Data).__index = currBonuses
	--getmetatable(compTier2Data).__index = compBonuses
	self:GenerateBonusString(currTier2Data, currLevel, currClass, compTier2Data, compLevel, compClass, textL, textR)
	--getmetatable(currTier2Data).__index = nil
	--getmetatable(compTier2Data).__index = nil
	textL[#textL+1] = ""
	textR[#textR+1] = ""
	if notInCache then
		textL[#textL+1] = L["WOW_EQUIP_NOT_IN_CACHE"]
		textL[#textL+1] = ""
	end
	WoWEquip_BonusScrollFrame.ScrollChild.BonusTextL2:SetText(table.concat(textL, "\n"))
	WoWEquip_BonusScrollFrame.ScrollChild.BonusTextR2:SetText(table.concat(textR, "\n"))
end

function WoWEquip:VerifyCompareProfile()
	local db = self.db.global
	if db.CompareProfile ~= "" and not db.profiles[db.CompareProfile] then
		-- Compared profile is renamed or deleted, set to Don't Compare if needed
		db.CompareProfile = ""
		if db.CompareOption == 3 then
			self.SetCompareOption(nil, 1, nil, nil)
		end
	end
end

function WoWEquip:SetCompareProfile(name)
	local db = self.db.global
	if db.profiles[name] then
		db.CompareProfile = name
		db.CompareOption = 3
		WoWEquip:UnregisterEvent("UNIT_INVENTORY_CHANGED")
		self:UpdateBonusFrame()
	end
end

function WoWEquip.SetCompareOption(dropdownbutton, arg1, arg2, checked)
	if arg1 == 3 then
		WoWEquip.ProfileButton_OnClick(WoWEquip.frame.BonusFrame.CompareButton, "LeftButton", nil)
	else
		if arg1 == 2 and WoWEquip.frame:IsShown() then
			WoWEquip:RegisterEvent("UNIT_INVENTORY_CHANGED")
		else
			WoWEquip:UnregisterEvent("UNIT_INVENTORY_CHANGED")
		end
		WoWEquip.db.global.CompareOption = arg1
		WoWEquip:UpdateBonusFrame()
	end
end

function WoWEquip.CompareMenu(self, level)
	if not level then return end
	local info = self.info
	wipe(info)
	local compare = WoWEquip.db.global.CompareOption
	if level == 1 then
		info.isTitle = 1
		info.text = L["Compare against..."]
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, level)

		info.notCheckable = nil
		info.disabled = nil
		info.isTitle = nil

		-- Don't Compare
		info.text = L["Don't compare"]
		info.arg1 = 1
		info.checked = compare == 1
		info.func = WoWEquip.SetCompareOption
		UIDropDownMenu_AddButton(info, level)

		-- Currently equipped gear
		info.text = L["Currently equipped gear"]
		info.arg1 = 2
		info.checked = compare == 2
		info.func = WoWEquip.SetCompareOption
		UIDropDownMenu_AddButton(info, level)

		-- Compare against selected saved profile
		info.text = L["Selected profile..."]
		info.arg1 = 3
		info.checked = compare == 3
		info.func = WoWEquip.SetCompareOption
		UIDropDownMenu_AddButton(info, level)

		-- Close menu item
		info.notCheckable = 1
		info.checked = nil
		info.arg1 = nil
		info.text = CLOSE
		info.func = self.HideMenu
		UIDropDownMenu_AddButton(info, level)
	end
end

function WoWEquip.SetClass(dropdownbutton, arg1, arg2, checked)
	WoWEquip.curProfile.class = arg1
	WoWEquip.frame.BonusFrame.ClassButton:SetText(CLASS_STRING[arg1])
	if (strfind(WoWEquip.curProfile.name, ".* %(%d+%):.*%(.*%)")) then
		WoWEquip.curProfile.name = gsub(WoWEquip.curProfile.name, ".*( %(%d+%):.*%(.*%))", CLASS_STRING[arg1].."%1")
	end
	WoWEquip:UpdateBonusFrame()
end

local function sortClasses(a, b)
	return CLASS_STRING[a] < CLASS_STRING[b]
end

function WoWEquip.ClassMenu(self, level)
	if not level then return end
	local info = self.info
	wipe(info)
	local class = WoWEquip.curProfile.class
	if level == 1 then
		info.isTitle = 1
		info.text = L["Select class"]
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, level)

		info.notCheckable = nil
		info.disabled = nil
		info.isTitle = nil

		-- Sort the classes by text
		local line = 0
		wipe(str)
		for CLASS, class in pairs(CLASS_STRING) do
			line = line + 1
			str[line] = CLASS
		end
		table.sort(str, sortClasses)

		for i = 1, #str do
			local CLASS = str[i]
			info.text = CLASS_STRING[CLASS]
			info.arg1 = CLASS
			info.checked = class == CLASS
			info.func = WoWEquip.SetClass
			UIDropDownMenu_AddButton(info, level)
		end

		-- Close menu item
		info.notCheckable = 1
		info.checked = nil
		info.arg1 = nil
		info.text = CLOSE
		info.func = self.HideMenu
		UIDropDownMenu_AddButton(info, level)
	end
end


----------------------------------------------------------------------------------------
-- Create the frames used by the Bonus Frame

do
	local INITIAL_WIDTH = 188

	-- Create the Item Bonus Summary frame
	local WoWEquip_BonusFrame = CreateFrame("Frame", nil, WoWEquip_Frame)
	WoWEquip_BonusFrame:SetWidth(222)
	WoWEquip_BonusFrame:SetHeight(324)
	WoWEquip_BonusFrame:SetPoint("TOPRIGHT", 3, -53)
	WoWEquip_BonusFrame:EnableMouse(true)
	WoWEquip.frame.BonusFrame = WoWEquip_BonusFrame

	-- Create the text above the bonus frame
	local temp = WoWEquip_BonusFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	temp:SetJustifyH("CENTER")
	temp:SetJustifyV("TOP")
	temp:SetWidth(INITIAL_WIDTH + 10)
	temp:SetHeight(22)
	temp:SetPoint("BOTTOM", WoWEquip_BonusFrame, "TOP", -17, 3)
	temp:SetText(L["Comparing:"])
	WoWEquip_BonusFrame.CompareText = temp

	-- Create and position the Lvl: Text next to the editbox
	WoWEquip_BonusFrame.LevelText = WoWEquip_BonusFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	WoWEquip_BonusFrame.LevelText:SetPoint("TOPLEFT", WoWEquip.frame, "TOPLEFT", 5, -23)
	WoWEquip_BonusFrame.LevelText:SetText(L["Lvl:"])

	-- Create the Level Input Box
	WoWEquip_BonusFrame.LevelInputBox = CreateFrame("EditBox", nil, WoWEquip_BonusFrame)
	WoWEquip_BonusFrame.LevelInputBox:SetWidth(20)
	WoWEquip_BonusFrame.LevelInputBox:SetHeight(15)
	WoWEquip_BonusFrame.LevelInputBox:SetMaxLetters(2)
	WoWEquip_BonusFrame.LevelInputBox:SetNumeric(true)
	WoWEquip_BonusFrame.LevelInputBox:SetAutoFocus(false)
	WoWEquip_BonusFrame.LevelInputBox:SetFontObject("GameFontHighlightSmall")
	temp = WoWEquip_BonusFrame.LevelInputBox:CreateTexture(nil, "BACKGROUND")
	temp:SetTexture("Interface\\Common\\Common-Input-Border")
	temp:SetWidth(4)
	temp:SetHeight(15)
	temp:SetPoint("TOPLEFT", -4, 0)
	temp:SetTexCoord(0, 0.03125, 0.03125, 0.625)
	local temp2 = WoWEquip_BonusFrame.LevelInputBox:CreateTexture(nil, "BACKGROUND")
	temp2:SetTexture("Interface\\Common\\Common-Input-Border")
	temp2:SetWidth(4)
	temp2:SetHeight(15)
	temp2:SetPoint("RIGHT")
	temp2:SetTexCoord(0.96875, 1, 0.03125, 0.625)
	local temp3 = WoWEquip_BonusFrame.LevelInputBox:CreateTexture(nil, "BACKGROUND")
	temp3:SetTexture("Interface\\Common\\Common-Input-Border")
	temp3:SetWidth(12)
	temp3:SetHeight(15)
	temp3:SetPoint("LEFT", temp, "RIGHT")
	temp3:SetPoint("RIGHT", temp2, "LEFT")
	temp3:SetTexCoord(0.0625, 0.9375, 0.03125, 0.625)
	WoWEquip_BonusFrame.LevelInputBox:SetPoint("LEFT", WoWEquip_BonusFrame.LevelText, "RIGHT", 7, 0)
	WoWEquip_BonusFrame.LevelInputBox:SetScript("OnEditFocusGained", WoWEquip_BonusFrame.LevelInputBox.HighlightText)
	WoWEquip_BonusFrame.LevelInputBox:SetScript("OnEnterPressed", WoWEquip_BonusFrame.LevelInputBox.ClearFocus)
	WoWEquip_BonusFrame.LevelInputBox:SetScript("OnEscapePressed", WoWEquip_BonusFrame.LevelInputBox.ClearFocus)
	WoWEquip_BonusFrame.LevelInputBox:SetScript("OnEditFocusLost", LevelInputBox_OnEditFocusLost)

	-- Create the Class button
	temp = CreateFrame("Button", nil, WoWEquip_BonusFrame, "OptionsButtonTemplate")
	temp:SetWidth(88)
	temp:SetHeight(16)
	-- Some locales have insanely long class-names (deDE)
	temp:GetFontString():SetWidth(temp:GetWidth()-5)
	temp:GetFontString():SetHeight(temp:GetHeight())
	temp:SetPoint("TOPLEFT", WoWEquip_BonusFrame.LevelText, "BOTTOMLEFT", -4, -2)
	temp:SetNormalFontObject("GameFontNormalSmall")
	temp:SetHighlightFontObject("GameFontHighlightSmall")
	temp:SetDisabledFontObject("GameFontDisableSmall")
	temp:SetScript("OnClick", WoWEquip_DropDownMenu.OnClick)
	temp:SetScript("OnHide", WoWEquip_DropDownMenu.HideMenu)
	temp.initMenuFunc = WoWEquip.ClassMenu
	WoWEquip_BonusFrame.ClassButton = temp

	-- Create the Toggle Rating <--> %  button
	temp = CreateFrame("Button", nil, WoWEquip_BonusFrame, "OptionsButtonTemplate")
	temp:SetWidth(18)
	temp:SetHeight(16)
	temp:SetPoint("LEFT", WoWEquip_BonusFrame.LevelInputBox, "RIGHT", 1, 0)
	temp:SetText("%")
	temp:SetScript("OnClick", function(self, button, down)
		WoWEquip.db.global.ShowRating = not WoWEquip.db.global.ShowRating
		WoWEquip:UpdateBonusFrame()
	end)
	WoWEquip_BonusFrame.ToggleRatingButton = temp

	-- Create the Compare button
	temp = CreateFrame("Button", nil, WoWEquip_BonusFrame, "OptionsButtonTemplate")
	temp:SetWidth(18)
	temp:SetHeight(16)
	temp:SetPoint("LEFT", WoWEquip_BonusFrame.ToggleRatingButton, "RIGHT", 2, 0)
	temp:SetText(L["WOW_EQUIP_COMPARE_LETTER"])
	temp:SetScript("OnClick", WoWEquip_DropDownMenu.OnClick)
	temp:SetScript("OnHide", WoWEquip_DropDownMenu.HideMenu)
	temp.initMenuFunc = WoWEquip.CompareMenu
	temp.mode = "compare"
	WoWEquip_BonusFrame.CompareButton = temp

	-- Create the Import button
	temp = CreateFrame("Button", nil, WoWEquip_BonusFrame, "OptionsButtonTemplate")
	temp:SetWidth(18)
	temp:SetHeight(16)
	temp:SetPoint("LEFT", WoWEquip_BonusFrame.CompareButton, "RIGHT", 2, 0)
	temp:SetText(L["WOW_EQUIP_IMPORT_LETTER"])
	temp:SetScript("OnClick", WoWEquip_ImportButton_OnClick)
	WoWEquip_BonusFrame.ImportButton = temp

	-- Create the ScrollFrame for the Item Bonus Summary
	WoWEquip_BonusScrollFrame = CreateFrame("ScrollFrame", "WoWEquip_BonusScrollFrame", WoWEquip_BonusFrame, "UIPanelScrollFrameTemplate")
	WoWEquip_BonusScrollFrame:SetWidth(INITIAL_WIDTH)
	WoWEquip_BonusScrollFrame:SetHeight(317)
	WoWEquip_BonusScrollFrame:SetPoint("TOPLEFT", 0, -2)
	-- Reposition the scrollbars slightly to match our texture
	WoWEquip_BonusScrollFrameScrollBar:ClearAllPoints()
	WoWEquip_BonusScrollFrameScrollBar:SetPoint("TOPLEFT", WoWEquip_BonusScrollFrame, "TOPRIGHT", 7, -14)
	WoWEquip_BonusScrollFrameScrollBar:SetPoint("BOTTOMLEFT", WoWEquip_BonusScrollFrame, "BOTTOMRIGHT", 7, 16)
	-- Create the ScrollChild frame and its contents
	WoWEquip_BonusScrollFrame.ScrollChild = CreateFrame("Frame", nil, WoWEquip_BonusScrollFrame)
	temp = WoWEquip_BonusScrollFrame.ScrollChild
	temp:SetWidth(INITIAL_WIDTH)
	temp:SetHeight(20)
	-- Equipment Stats fontstring
	temp.eqstring = temp:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	temp.eqstring:SetTextColor(1.0, 1.0, 0.1)
	temp.eqstring:SetText(L["Equipment Stats"])
	temp.eqstring:SetPoint("TOPLEFT", 0, 0)
	temp.eqstring:SetWidth(INITIAL_WIDTH)
	-- The 2 summary strings
	temp.BonusTextL = temp:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	temp.BonusTextL:SetJustifyH("LEFT")
	temp.BonusTextL:SetPoint("TOPLEFT", temp.eqstring, "BOTTOMLEFT", 0, 0)
	temp.BonusTextL:SetWidth(INITIAL_WIDTH)
	temp.BonusTextR = temp:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	temp.BonusTextR:SetJustifyH("RIGHT")
	temp.BonusTextR:SetPoint("TOPRIGHT", temp.eqstring, "BOTTOMRIGHT", 0, 0)
	temp.BonusTextR:SetWidth(INITIAL_WIDTH)
	-- Derived Stats font string
	temp.dsstring = temp:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	temp.dsstring:SetTextColor(1.0, 1.0, 0.1)
	temp.dsstring:SetText(L["Derived Stats"])
	temp.dsstring:SetPoint("TOPLEFT", temp.BonusTextL, "BOTTOMLEFT", 0, -10)
	temp.dsstring:SetWidth(INITIAL_WIDTH)
	-- Add a note string
	temp.notestring = temp:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	temp.notestring:SetText(L["WOW_EQUIP_DERIVED_STATS_NOTE"].."\n")
	temp.notestring:SetPoint("TOPLEFT", temp.dsstring, "BOTTOMLEFT", 0, 0)
	temp.notestring:SetJustifyH("LEFT")
	temp.notestring:SetWidth(INITIAL_WIDTH)
	temp.notestring:SetNonSpaceWrap(true)
	-- The 2 derived summary strings
	temp.BonusTextL2 = temp:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	temp.BonusTextL2:SetJustifyH("LEFT")
	temp.BonusTextL2:SetPoint("TOPLEFT", temp.notestring, "BOTTOMLEFT", 0, 0)
	temp.BonusTextL2:SetWidth(INITIAL_WIDTH)
	temp.BonusTextR2 = temp:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	temp.BonusTextR2:SetJustifyH("RIGHT")
	temp.BonusTextR2:SetPoint("TOPRIGHT", temp.notestring, "BOTTOMRIGHT", 0, 0)
	temp.BonusTextR2:SetWidth(INITIAL_WIDTH)
	-- The beta status string
	temp.betatext = temp:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	temp.betatext:SetWidth(INITIAL_WIDTH)
	temp.betatext:SetNonSpaceWrap(true)
	temp.betatext:SetJustifyH("LEFT")
	temp.betatext:SetPoint("TOPLEFT", temp.BonusTextL2, "BOTTOMLEFT", 0, 0)
	temp.betatext:SetText(L["WOW_EQUIP_BETA_TEXT"])

	-- Attach the ScrollChild to the ScrollFrame
	WoWEquip_BonusScrollFrame:SetScrollChild(WoWEquip_BonusScrollFrame.ScrollChild)
end

-- vim: ts=4 noexpandtab
