local lib = LibStub("LibItemBonus-2.0")

if not lib._LOADING then return end

local function find_start(link, start, stop)
	while true do
		local pos = link:find(":", start + 1, true) or stop
		if pos >= stop then return start end
		start = pos
	end
end

function lib:CheckEnchantId(link, bonuses)
	local start, stop, enchant = link:find("item:%d+:(%d+)")
	if not start then return link end
	local p = self.ENCHANTS[tonumber(enchant)]
	if not p then return link end
	if bonuses then
		for effect, value in pairs(p) do
			self:AddValue(bonuses, effect, value)
		end
	end
	return link:sub(1, find_start(link, start + 5, stop)).."0"..link:sub(stop + 1)
end

lib.ENCHANTS = {
	[3594] = { PARRY = 2, DISARMREDUCTION = 50}, -- Rune of Swordbreaking
	[3365] = { PARRY = 4, DISARMREDUCTION = 50}, -- Rune of Swordshattering
	[3847] = { DEFENSE = 25, MOD_STA = 2}, -- Rune of the Stoneskin Gargoyle
	[3883] = { DEFENSE = 13, MOD_STA = 1}, -- Rune of the Nerubian Carapace
	[3849] = { CR_BLOCK = 40, DISARMREDUCTION = 50}, -- Titanium Plating
	[3730] = { SPI = 1, }, -- Swordguard Embroidery
	[3728] = { SPI = 1, }, -- Darkglow Embroidery
	[3722] = { SPI = 1, }, -- Lightweave Embroidery
	[3595] = { MOD_SPELLDAMAGE_TAKEN = 2, SILENCEREDUCTION = 50}, -- Rune of Spellbreaking
	[3367] = { MOD_SPELLDAMAGE_TAKEN = 4, SILENCEREDUCTION = 50}, -- Rune of Spellshattering
	[2603] = { FISHING = 5, }, -- Eternium Line
	[2656] = { MANAREG = 4, HEALTHREG = 4}, -- Vitality
	[3244] = { MANAREG = 6, HEALTHREG = 6}, -- Greater Vitality
	[2672] = { FROSTSPELLPOWER = 54, SHADOWSPELLPOWER = 54}, -- Soulfrost
	[2671] = { ARCANESPELLPOWER = 50, FIRESPELLPOWER = 50}, -- Sunfire
	[2667] = { ATTACKPOWER = 70, }, -- Savagery
	[2613] = { THREATREDUCTION = -2, }, -- +2% Threat
	[2621] = { THREATREDUCTION = 2, }, -- Subtlety
	[3238] = { HERBALISM = 5, MINING = 5, SKINNING = 5}, -- Gatherer
	[3826] = { CR_CRIT = 12, CR_HIT = 12}, -- Icewalker
	[3247] = { ATTACKPOWERUNDEAD = 140, }, -- Scourgebane
	[3788] = { CR_CRIT = 25, CR_HIT = 25}, -- Accuracy
	[3296] = { THREATREDUCTION = 2, SPI = 10}, -- Wisddom
	[3232] = { RUNSPEED = 8, STA = 15}, -- Tuskar's Vitality
	[3818] = { STA = 37, CR_DEFENSE = 20}, -- Arcanum of the Stalwart Protector
	[2724] = { CR_RANGEDCRIT = 28, }, -- Stabilitzed Eternium Scope
	[3608] = { CR_RANGEDCRIT = 40, }, -- Heartseeker Scope
	[3607] = { CR_RANGEDHASTE = 40, }, -- Sun Scope
	[2523] = { CR_RANGEDHIT = 30, }, -- Biznicks 247x128 Accurascope

	[3605] = { AGI = 15, }, -- Flexweave underlay
	[3859] = { SPELLPOWER = 18, }, -- Springy Arachnoweave
	[3606] = { CR_CRIT = 16, }, -- Nitro Boosts

	[3223] = { CR_PARRY = 15, }, -- Admantite Weapon Chain
	[3731] = { CR_HIT = 28, } -- Titanium Weapon Chain
}
