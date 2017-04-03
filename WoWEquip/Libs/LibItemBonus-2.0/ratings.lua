local lib = LibStub"LibItemBonus-2.0"

if not lib.OnInitialize then return end

local _, build = GetBuildInfo()
build = assert(tonumber(build))

local CombatRatingMap = {
	CR_WEAPON = 2.5,
	CR_WEAPON_DAGGER = 2.5,
	CR_WEAPON_SWORD = 2.5,
	CR_WEAPON_SWORD_2H = 2.5,
	CR_WEAPON_AXE = 2.5,
	CR_WEAPON_AXE_2H = 2.5,
	CR_WEAPON_MACE = 2.5,
	CR_WEAPON_MACE_2H = 2.5,
	CR_WEAPON_BOW = 2.5,
	CR_WEAPON_XBOW = 2.5,
	CR_WEAPON_GUN = 2.5,
	CR_WEAPON_FIST = 2.5,
	CR_WEAPON_STAFF = 2.5,
	CR_WEAPON_POLEARM = 2.5,

	CR_DEFENSE = 1.5,
	CR_DODGE = build >= 10192 and 13.8 or 12,
	CR_PARRY = build >= 10192 and 13.8 or 15,
	CR_BLOCK = 5,
	CR_HIT = 10,
	CR_RANGEDHIT = 10,
	CR_SPELLHIT = 8,
	CR_CRIT = 14,
	CR_RANGEDCRIT = 14,
	CR_SPELLCRIT = 14,
	CR_HASTE = 10,
	CR_SPELLHASTE = 10,
	CR_RANGEDHASTE = 10,
	CR_RESILIENCE = build >= 10192 and 28.75 or 25,
	CR_HIT_TAKEN = 10,
	CR_RANGEDHIT_TAKEN = 10,
	CR_SPELLHIT_TAKEN = 8,
	CR_EXPERTISE = 2.5,
	CR_ARMOR_PENETRATION = build >= 9742 and 3.756097412109376 or 4.69512176513672,
}

local lowerlimit34 = {
	CR_DEFENSE = true,
	CR_DODGE = true,
	CR_PARRY = true,
	CR_BLOCK = true,
	CR_HIT_TAKEN = true,
	CR_SPELLHIT_TAKEN = true,
}

local BonusRatingMap = {
	DEFENSE = "CR_DEFENSE",
	DODGE = "CR_DODGE",
	PARRY = "CR_PARRY",
	TOHIT = "CR_HIT",
	CRIT = "CR_CRIT",
	SPELLTOHIT = "CR_SPELLHIT",
	SPELLCRIT = "CR_CRIT",
	BLOCK = "CR_BLOCK",
	ARMORPEN = "CR_ARMOR_PENETRATION",
}

local InverseBonusRatingMap = {}
for k, v in pairs(BonusRatingMap) do
	InverseBonusRatingMap[v] = k
end

local ratingMultiplier = setmetatable({},{
	__index = function (self, level)
		--[[
		The following calculations are based on Whitetooth's calculations:
		http://www.wowinterface.com/downloads/info5819-Rating_Buster.html
		]]
		local value
		if level < 10 then
			value = 26
		elseif level <= 60 then
			value = 52 / (level - 8)
		elseif level <= 70 then
			value = (262-3*level) / 82
		elseif level <= 80 then
			value = 1 / ((82/52)*(131/63)^((level-70)/10))
		end
		self[level] = value
		return value
	end,
})

if build >= 9742 then
	local hasteBonusClasses = {
		DEATHKNIGHT = true,
		DRUID = true,
		PALADIN = true,
		SHAMAN = true,
	}
	function lib:GetRatingBonus(type, value, level, class)
		local F = CombatRatingMap[type]
		if not F then return end

		if type == "CR_HASTE" then
			if not class then
				local _
				_, class = UnitClass"player"
			end

			if hasteBonusClasses[class] then
				value = value * 1.3 -- or F /= 1.3
			end
		end

		level = level or UnitLevel"player"
		if level < 34 and lowerlimit34[type] then
			level = 34
		end

		return value / F * ratingMultiplier[level]
	end
else
	function lib:GetRatingBonus(type, value, level)
		local F = CombatRatingMap[type]
		if not F then return end

		level = level or UnitLevel"player"
		if level < 34 and lowerlimit34[type] then
			level = 34
		end

		return value / F * ratingMultiplier[level]
	end
end

local function GetBonus(type, map, level)
	local value = map[type]
	if not value then
		local rating = BonusRatingMap[type]
		if rating then
			value = map[rating]
			if value then
				value = lib:GetRatingBonus(rating, value, level)
			end
		elseif type == "ARMOR" then
			return GetBonus("BASE_ARMOR", map, level) + GetBonus("ARMOR_BONUS", map, level)
		elseif type == "DMG" or type == "HEAL" then
			return GetBonus("SPELLPOWER", map, level)
		end
	end
	return value or 0
end

function lib:GetFriendlyBonus(type, map, level)
	local rev = InverseBonusRatingMap[type]
	if not rev then
		return type, map[type]
	end
	return rev, self:GetRatingBonus(type, map[type], level)
end

function lib:GetBonus(bonus, table, level)
	return GetBonus(bonus, table or self.bonuses, level)
end
