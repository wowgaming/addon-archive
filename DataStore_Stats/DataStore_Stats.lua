--[[	*** DataStore_Stats ***
Written by : Thaoky, EU-Marécages de Zangar
July 18th, 2009
--]]
if not DataStore then return end

local addonName = "DataStore_Stats"

_G[addonName] = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0")

local addon = _G[addonName]

local THIS_ACCOUNT = "Default"

local AddonDB_Defaults = {
	global = {
		Characters = {
			['*'] = {				-- ["Account.Realm.Name"] 
				lastUpdate = nil,
				Stats = {},
			}
		}
	}
}

-- ** Mixins **
local function _GetStats(character, statType)
	local data = character.Stats[statType]
	if not data then return end
	
	return strsplit("|", data)
	
	-- if there's a need to automate the tonumber of each var, do this ( improve it), since most of the time, these data will be used for display purposes, strings are acceptable
	-- local var1, var2, var3, var4, var5, var6 = strsplit("|", data)
	-- return tonumber(var1), tonumber(var2), tonumber(var3), tonumber(var4), tonumber(var5), tonumber(var6)
end

local PublicMethods = {
	GetStats = _GetStats,
}

function addon:OnInitialize()
	addon.db = LibStub("AceDB-3.0"):New(addonName .. "DB", AddonDB_Defaults)

	DataStore:RegisterModule(addonName, addon, PublicMethods)
	DataStore:SetCharacterBasedMethod("GetStats")
end

-- *** Scanning functions ***
local function ScanStats()
	local stats = addon.ThisCharacter.Stats
	wipe(stats)
	
	stats["HealthMax"] = UnitHealthMax("player")
	-- info on power types here : http://www.wowwiki.com/API_UnitPowerType
	stats["MaxPower"] = UnitPowerType("player") .. "|" .. UnitPowerMax("player")
	
	local t = {}
	-- *** resistances  ***
	for i = 1, 6 do
		_, t[i] = UnitResistance("player", i)
		-- base, total, bonus, minus = UnitResistance(unitId [, resistanceIndex])
		-- base = base
		-- total = total after all modifiers
		-- bonus = positive modif total
		-- minus = negative ...
	end
	stats["Resistances"] = table.concat(t, "|")	--	["Resistances"] = "holy | fire | nature | frost | shadow | arcane"

	-- *** base stats ***
	for i = 1, 5 do
		t[i] = UnitStat("player", i)
		-- stat, effectiveStat, posBuff, negBuff = UnitStat("player", statIndex);
	end
	t[6] = UnitArmor("player")
	stats["Base"] = table.concat(t, "|")	--	["Base"] = "strength | agility | stamina | intellect | spirit | armor"
	
	-- *** melee stats ***
	local minDmg, maxDmg = UnitDamage("player")
	t[1] = floor(minDmg) .."-" ..ceil(maxDmg)				-- Damage "215-337"
	t[2] = UnitAttackSpeed("player")
	t[3] = UnitAttackPower("player")
	t[4] = GetCombatRating(CR_HIT_MELEE)
	t[5] = GetCritChance()
	t[6] = GetExpertise()
	stats["Melee"] = table.concat(t, "|")	--	["Melee"] = "Damage | Speed | Power | Hit rating | Crit chance | Expertise"
	
	-- *** ranged stats ***
	local speed
	speed, minDmg, maxDmg = UnitRangedDamage("player")
	t[1] = floor(minDmg) .."-" ..ceil(maxDmg)
	t[2] = speed
	t[3] = UnitRangedAttackPower("player")
	t[4] = GetCombatRating(CR_HIT_RANGED)
	t[5] = GetRangedCritChance()
	t[6] = nil
	stats["Ranged"] = table.concat(t, "|")	--	["Ranged"] = "Damage | Speed | Power | Hit rating | Crit chance"
	
	-- *** spell stats ***
	t[1] = GetSpellBonusDamage(2)			-- 2, since 1 = physical damage
	t[2] = GetSpellBonusHealing()
	t[3] = GetCombatRating(CR_HIT_SPELL)
	t[4] = GetSpellCritChance(2)
	t[5] = GetCombatRating(CR_HASTE_SPELL)
	t[6] = floor(GetManaRegen() * 5.0)
	stats["Spell"] = table.concat(t, "|")	--	["Spell"] = "+Damage | +Healing | Hit | Crit chance | Haste | Mana Regen"
	
	-- *** defenses stats ***
	t[1] = UnitArmor("player")
	t[2] = UnitDefense("player")
	t[3] = GetDodgeChance()
	t[4] = GetParryChance()
	t[5] = GetBlockChance()
	local minResilience = min(GetCombatRating(CR_CRIT_TAKEN_MELEE), GetCombatRating(CR_CRIT_TAKEN_RANGED))
	t[6] = min(minResilience, GetCombatRating(CR_CRIT_TAKEN_SPELL))
	stats["Defense"] = table.concat(t, "|")	--	["Defense"] = "Armor | Defense | Dodge | Parry | Block | Resilience"

	-- *** PVP Stats ***
	t[1], t[2] = GetPVPLifetimeStats()
	t[3] = GetArenaCurrency()
	t[4] = GetHonorCurrency()
	t[5] = nil
	t[6] = nil
	stats["PVP"] = table.concat(t, "|")	--	["PVP"] = "honorable kills | dishonorable kills | arena points | honor points"
	
	-- *** Arena Teams ***
	for i = 1, MAX_ARENA_TEAMS do
		local teamName, teamSize = GetArenaTeam(i)
		if teamName then
			stats["Arena"..teamSize] = table.concat({ GetArenaTeam(i) }, "|")
			-- more info here : http://www.wowwiki.com/API_GetArenaTeam
		end
	end
	
	addon.ThisCharacter.lastUpdate = time()
end

function addon:OnEnable()
	addon:RegisterEvent("PLAYER_ALIVE")
	addon:RegisterEvent("UNIT_INVENTORY_CHANGED", ScanStats)
end

function addon:OnDisable()
	addon:UnregisterEvent("PLAYER_ALIVE")
	addon:UnregisterEvent("UNIT_INVENTORY_CHANGED")
end

-- *** EVENT HANDLERS ***
function addon:PLAYER_ALIVE()
	ScanStats()
end
