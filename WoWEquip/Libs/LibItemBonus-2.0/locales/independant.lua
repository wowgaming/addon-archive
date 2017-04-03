local lib = LibStub("LibItemBonus-2.0")

if not lib._LOADING then return end

local old_OnInitialize = lib.OnInitialize

lib.OnInitialize = function (lib)
	old_OnInitialize(lib)

local p = lib.patterns

if not p then return end

local function mixin(base, t, force)
	for k, v in pairs(t) do
		if force or not base[k] then
			base[k] = v
		end
	end
end

local function append(base, t)
	for i, entry in ipairs(t) do
		if entry.pattern then
			local found
			for _, v in ipairs(base) do
				if v.pattern == entry.pattern then
					found = true
					break
				end
			end
			if not found then
				table.insert(base, entry) -- insert them first
			end
		end
	end
end

local function escape(s)
	return string.gsub(s, "([%(%)%.%*%+%-%[%]%?%^%$%%])", "%%%1")
end

local GetSpellName = function(spellId)
	return escape(GetSpellInfo(spellId))
end
local GetEnchantName
do
	local tooltip = lib.tooltip
	local validLinkItemId
	do
		local function FindValidItemId()
			local tooltip = lib.tooltip
			local check = function(link)
				if link then
					local id = link:match("item:(%d+)")
					if id then
						link = "item:"..id
					end
					tooltip:SetLink(link)
					if tooltip:NumLines() >= 2 then
						validLinkItemId = link
						return true
					end
				end
			end
			for slot = 1, 23 do
				if check(GetInventoryItemLink("player", slot)) then return true end
			end
			for bag = 1, 4 do
				for slot = 1, GetContainerNumSlots(bag) do
					if check(GetContainerItemLink(bag, slot)) then return true end
				end
			end
		end
		FindValidItemId()
	end
	if not validLinkItemId then
		lib:error("GetEnchantName() initialization failed, because no item found in the cache. Reloading will fix this")
		GetEnchantName = function () end
		return
	end
	tooltip:SetLink(validLinkItemId)
	local lines = tooltip:NumLines()
	local temp = {}
	for i = 1, lines do
		temp[i] = tooltip.lefts[i]:GetText()
	end
	lines = nil
	tooltip:SetLink(validLinkItemId..":2603")
	for i = 1, tooltip:NumLines() do
		if tooltip.lefts[i]:GetText() ~= temp[i] then
			lines = i
			break
		end
	end
	assert(lines, "GetEnchantName() initialization failed, for some unknown reason")
	lib:Debug("GetEnchantName() initialized using %q (%d)", validLinkItemId, lines)
	function GetEnchantName(enchantId)
		tooltip:SetLink(("%s:%d"):format(validLinkItemId, enchantId))
		local fs = tooltip.lefts[lines]
		if fs and fs:IsShown() then
			local enchant = escape(fs:GetText())
			lib:Debug("GetEnchantName %d %q", enchantId, enchant)
			return enchant
		end
	end
end
local GetEnchantPattern = function (enchantId)
	local s = GetEnchantName(enchantId)
	if s then return s:gsub("%d+", "(%%d+)") end
end
local GetMetaGemPattern = function (enchantId, skipNumberPattern)
	local pattern = GetEnchantName(enchantId)
	if not skipNumberPattern and pattern then pattern = pattern:gsub("%d+", "(%%d+)") end
	return pattern
end

mixin(p.NAMES, {
	STR = SPELL_STAT1_NAME,
	AGI = SPELL_STAT2_NAME,
	STA = SPELL_STAT3_NAME,
	INT = SPELL_STAT4_NAME,
	SPI = SPELL_STAT5_NAME,

	CR_WEAPON = COMBAT_RATING_NAME1,
	CR_DEFENSE = COMBAT_RATING_NAME2,
	CR_DODGE = COMBAT_RATING_NAME3,
	CR_PARRY = COMBAT_RATING_NAME4,
	CR_BLOCK = COMBAT_RATING_NAME5,
	CR_HIT = COMBAT_RATING_NAME6,
	CR_CRIT = COMBAT_RATING_NAME9,
	CR_RESILIENCE = COMBAT_RATING_NAME15,
	CR_EXPERTISE = COMBAT_RATING_NAME24,
})

mixin(p.PATTERNS_GENERIC_LOOKUP, {
	SPELL_STAT1_NAME = "STR",
	SPELL_STAT2_NAME = "AGI",
	SPELL_STAT3_NAME = "STA",
	SPELL_STAT4_NAME = "INT",
	SPELL_STAT5_NAME = "SPI",

	COMBAT_RATING_NAME1 = "CR_WEAPON",
	COMBAT_RATING_NAME2 = "CR_DEFENSE",
	COMBAT_RATING_NAME3 = "CR_DODGE",
	COMBAT_RATING_NAME4 = "CR_PARRY",
	COMBAT_RATING_NAME5 = "CR_BLOCK",
	COMBAT_RATING_NAME6 = "CR_HIT",
	COMBAT_RATING_NAME9 = "CR_CRIT",
	COMBAT_RATING_NAME15 = "CR_RESILIENCE",
	COMBAT_RATING_NAME24 = "CR_EXPERTISE",
})

append(p.PATTERNS_OTHER, {
	{ pattern = escape(EMPTY_SOCKET_BLUE), effect = "EMPTY_SOCKET_BLUE", value = 1},
	{ pattern = escape(EMPTY_SOCKET_META), effect = "EMPTY_SOCKET_META", value = 1},
	{ pattern = escape(EMPTY_SOCKET_RED), effect = "EMPTY_SOCKET_RED", value = 1},
	{ pattern = escape(EMPTY_SOCKET_YELLOW), effect = "EMPTY_SOCKET_YELLOW", value = 1},

--[[
These enchants have the same name as their enchant string counterpart.
It is assumed that it's true for all locale, otherwise GetEnchantName() should be called instead.
]]
	{ pattern = GetSpellName(25117), effect = "SPELLPOWER", value = 8 }, -- Minor Wizard Oil
	{ pattern = GetSpellName(25119), effect = "SPELLPOWER", value = 16 }, -- Lesser Wizard Oil
	{ pattern = GetSpellName(25121), effect = "SPELLPOWER", value = 24 }, -- Wizard Oil
	{ pattern = GetSpellName(25122), effect = {"SPELLPOWER", "CR_CRIT"}, value = {36, 14} }, -- Brilliant Wizard Oil
	{ pattern = GetSpellName(28017), effect = "SPELLPOWER", value = 42 }, -- Superior Wizard Oil
	{ pattern = GetSpellName(47906), effect = "SPELLPOWER", value = 56 }, -- Exceptional Wizard Oil

	{ pattern = GetSpellName(25118), effect = "MANAREG", value = 4 }, -- Minor Mana Oil
	{ pattern = GetSpellName(25120), effect = "MANAREG", value = 8 }, -- Lesser Mana Oil
	{ pattern = GetSpellName(25123), effect = {"MANAREG", "SPELLPOWER"}, value = {12, 13} }, -- "Brilliant Mana Oil"
	{ pattern = GetSpellName(28013), effect = "MANAREG", value = 14 }, -- Superior Mana Oil
	{ pattern = GetSpellName(47904), effect = "MANAREG", value = 19 }, -- Exceptional Mana Oil
--[[ -- THESES are now handled by :CheckEnchantId()
	{ pattern = GetSpellName(54446), effect = {"PARRY", "DISARMREDUCTION"}, value = {2, 50} }, -- Rune of Swordbreaking
	{ pattern = GetSpellName(53323), effect = {"PARRY", "DISARMREDUCTION"}, value = {4, 50} }, -- Rune of Swordshattering
	{ pattern = GetSpellName(62158), effect = {"DEFENSE", "MOD_STA"}, value = {25, 2} }, -- Rune of the Stoneskin Gargoyle

	{ pattern = GetSpellName(62201), effect = {"CR_BLOCK", "DISARMREDUCTION"}, value = {40, 50} }, -- Titanium Plating

	{ pattern = GetSpellName(55777), effect = "SPIRIT", value = 1 }, -- Swordguard Embroidery
	{ pattern = GetSpellName(55769), effect = "SPIRIT", value = 1 }, -- Darkglow Embroidery
	{ pattern = GetSpellName(55642), effect = "SPIRIT", value = 1 }, -- Lightweave Embroidery

	{ pattern = GetSpellName(54447), effect = {"MOD_SPELLDAMAGE_TAKEN","SILENCEREDUCTION"}, value = {2, 50} }, -- Rune of Spellbreaking
	{ pattern = GetSpellName(53342), effect = {"MOD_SPELLDAMAGE_TAKEN","SILENCEREDUCTION"}, value = {4, 50} }, -- Rune of Spellshattering

	-- The following have a different enchant string than their spellid, so require some tooltip scanning
	{ pattern = GetEnchantName(2603), effect = "FISHING", value = 5 }, -- Eternium Line
	{ pattern = GetEnchantName(2656), effect = {"MANAREG", "HEALTHREG"}, value = {4, 4} }, -- Vitality
	{ pattern = GetEnchantName(3244), effect = {"MANAREG", "HEALTHREG"}, value = {6, 6} }, -- Greater Vitality
	{ pattern = GetEnchantName(2672), effect = {"FROSTSPELLPOWER", "SHADOWSPELLPOWER"}, value = {54, 54} }, -- Soulfrost
	{ pattern = GetEnchantName(2671), effect = {"ARCANESPELLPOWER", "FIRESPELLPOWER"}, value = {50, 50} }, -- Sunfire
	{ pattern = GetEnchantName(2667), effect = "ATTACKPOWER", value = 70 }, -- Savagery
	{ pattern = GetEnchantName(2613), effect = "THREATREDUCTION", value = -2 }, -- +2% Threat
	{ pattern = GetEnchantName(2621), effect = "THREATREDUCTION", value = 2 }, -- Subtlety
	{ pattern = GetEnchantName(3238), effect = {"HERBALISM", "MINING", "SKINNING"}, value = {5, 5, 5}, }, -- Gatherer
	{ pattern = GetEnchantName(3826), effect = {"CR_CRIT", "CR_HIT"}, value = {12, 12}, }, -- Icewalker
	{ pattern = GetEnchantName(3247), effect = "ATTACKPOWERUNDEAD", value = 140, }, -- Scourgebane
	{ pattern = GetEnchantName(3788), effect = {"CR_CRIT", "CR_HIT"}, value = {25, 25}, }, -- Accuracy
	{ pattern = GetEnchantName(3296), effect = {"THREATREDUCTION", "SPI"}, value = {2, 10}, }, -- Wisddom
	{ pattern = GetEnchantName(3232), effect = {"RUNSPEED", "STA"}, value = {8, 15}, }, -- Tuskar's Vitality
	{ pattern = GetEnchantName(3818), effect = {"STA", "CR_DEFENSE"}, value = {37, 20}, }, -- Arcanum of the Stalwart Protector
	{ pattern = GetEnchantName(2724), effect = "CR_RANGEDCRIT", value = 28, }, -- Stabilitzed Eternium Scope
	{ pattern = GetEnchantName(3608), effect = "CR_RANGEDCRIT", value = 40, }, -- Heartseeker Scope
	{ pattern = GetEnchantName(3607), effect = "CR_RANGEDHASTE", value = 40, }, -- Sun Scope
	{ pattern = GetEnchantName(2523), effect = "CR_RANGEDHIT", value = 30, }, -- Biznicks 247x128 Accurascope
]]
	-- meta gems@80
	{ pattern = GetMetaGemPattern(3637), effect = {"STA", "MOD_ARMOR"}, }, -- Austere Earthsiege Diamond
	{ pattern = GetMetaGemPattern(3641), effect = {"CR_CRIT", "MOD_MANA"}, }, -- Beaming Earthsiege Diamond
	{ pattern = GetMetaGemPattern(3626), effect = {"SPELLPOWER", "THREATREDUCTION"}, }, -- Bracing Earthsiege Diamond
	{ pattern = GetMetaGemPattern(3621), effect = {"CR_CRIT", "MOD_DAMAGE_CRIT"}, }, -- Chaotic Skyflare Diamond
	{ pattern = GetMetaGemPattern(3622), effect = {"CR_CRIT", "SPELLREFLECT"}, }, -- Destructive Skyflare Diamond
	{ pattern = GetMetaGemPattern(3634), effect = {"STA", "DMGTAKEN"}, }, -- Effulgent Skyflare Diamond
	{ pattern = GetMetaGemPattern(3623), effect = {"SPELLPOWER", "MOD_INT"}, }, -- Ember Skyflare Diamond
	{ pattern = GetMetaGemPattern(3624), effect = {"CR_CRIT", "SNAREREDUCTION"}, }, -- Enigmatic Skyflare Diamond / Enigmatic Starflare Diamond
	{ pattern = GetMetaGemPattern(3631), effect = {"CR_DEFENSE", "MOD_BLOCKVALUE"}, }, -- Eternal Earthsiege Diamond
	{ pattern = GetMetaGemPattern(3635), effect = {"SPELLPOWER", "SILENCEREDUCTION"}, }, -- Forlorn Skyflare Diamond / Forlorn Starflare Diamond
	{ pattern = GetMetaGemPattern(3636), effect = {"CR_CRIT", "FEARREDUCTION"}, }, -- Impassive Skyflare Diamond / Impassive Starflare Diamond
	-- { pattern = GetMetaGemPattern(3627), effect = "INT", }, -- Insightful Earthsiege Diamond
	{ pattern = GetMetaGemPattern(3640), effect = "ATTACKPOWER", }, -- Invigorating Earthsiege Diamond
	{ pattern = GetMetaGemPattern(3638), effect = {"ATTACKPOWER", "STUNREDUCTION"}, }, -- Persistent Earthshatter Diamond / Persistent Earthsiege Diamond
	{ pattern = GetMetaGemPattern(3642), effect = {"STA", "STUNREDUCTION"}, }, -- Powerful Earthshatter Diamond / Powerful Earthsiege Diamond
	{ pattern = GetMetaGemPattern(3628), effect = {"AGI", "MOD_DAMAGE_CRIT"}, }, -- Relentless Earthsiege Diamond
	{ pattern = GetMetaGemPattern(3633, true), effect = {"MANAREG", "MOD_HEAL_CRIT"}, value = {8, 3}, }, -- Revitalizing Skyflare Diamond
	{ pattern = GetMetaGemPattern(3625, true), effect = {"ATTACKPOWER", "RUNSPEED"}, value = {42, 8}, }, -- Swift Skyflare Diamond
	{ pattern = GetMetaGemPattern(3798, true), effect = {"ATTACKPOWER", "RUNSPEED"}, value = {34, 8}, }, -- Swift Starflare Diamond
	-- { pattern = GetEnchantPattern(3643), effect = nil, }, -- Thundering Skyflare Diamond
	{ pattern = GetMetaGemPattern(3632, true), effect = {"SPELLPOWER", "RUNSPEED"}, value = {25, 8}, }, -- Tireless Skyflare Diamond
	{ pattern = GetMetaGemPattern(3799, true), effect = {"SPELLPOWER", "RUNSPEED"}, value = {20, 8}, }, -- Tireless Starflare Diamond
	{ pattern = GetMetaGemPattern(3639), effect = {"SPELLPOWER", "STUNREDUCTION"}, }, -- Trenchant Earthshatter Diamond / Trenchant Earthsiege Diamond

	-- meta gems@70
	-- { pattern = GetMetaGemPattern(2832), effect = {"SPELLPOWER", "THREATREDUCTION"}, }, -- Bracing Earthstorm Diamond
	{ pattern = GetMetaGemPattern(2834), effect = "MELEEDMG", }, -- Brutal Earthstorm Diamond
	-- { pattern = GetMetaGemPattern(?), effect ={"CR_CRIT", "MOD_DAMAGE_CRIT"}, }, -- Chaotic Skyfire Diamond
	-- { pattern = GetMetaGemPattern(?), effect ={"CR_CRIT", "SPELLREFLECT"}, }, -- Destructive Skyfire Diamond
	-- { pattern = GetMetaGemPattern(?), effect ={"SPELLPOWER", "MOD_INT"}, }, -- Ember Skyfire Diamond
	-- { pattern = GetMetaGemPattern(?), effect ={"CR_CRIT", "SNAREREDUCTION"}, }, -- Enigmatic Skyfire Diamond
	-- { pattern = GetMetaGemPattern(?), effect ={"CR_DEFENSE", "MOD_BLOCKVALUE"}, }, -- Eternal Earthstorm Diamond
	{ pattern = GetMetaGemPattern(3163), effect ={"SPELLPOWER", "STUNRESIST"}, }, -- Imbued Unstable Diamond
	-- { pattern = GetMetaGemPattern(?), effect ="INT", }, -- Insightful Earthstorm Diamond
	-- { pattern = GetMetaGemPattern(?), effect = nil, }, -- Mystical Skyfire Diamond
	{ pattern = GetMetaGemPattern(3162), effect = {"ATTACKPOWER", "STUNRESIST"}, }, -- Potent Unstable Diamond
	-- { pattern = GetMetaGemPattern(?), effect = {"STA", "STUNREDUCTION"}, }, -- Powerful Earthstorm Diamond
	-- { pattern = GetMetaGemPattern(?), effect = {"AGI", "MOD_DAMAGE_CRIT"}, }, -- Relentless Earthstorm Diamond
	{ pattern = GetMetaGemPattern(2829, true), effect = {"ATTACKPOWER", "RUNSPEED"}, value = {24, 8}, }, -- Swift Skyfire Diamond
	{ pattern = GetMetaGemPattern(2970, true), effect = {"SPELLPOWER", "RUNSPEED"}, value = {12, 8}, }, -- Swift Starfire Diamond
	{ pattern = GetMetaGemPattern(2969, true), effect = {"ATTACKPOWER", "RUNSPEED"}, value = {20, 8}, }, -- Swift Windfire Diamond
	{ pattern = GetMetaGemPattern(2833), effect = "CR_DEFENSE", }, -- Tenacious Earthstorm Diamond
	-- { pattern = GetMetaGemPattern(?), effect = nil, }, -- Thundering Skyfire Diamond
})

end
