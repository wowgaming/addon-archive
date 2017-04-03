local AceLocale = LibStub("AceLocale-3.0")
local L = AceLocale:GetLocale( "Recount" )
local BossIDs = LibStub("LibBossIDs-1.0")

local Recount = _G.Recount

local revision = tonumber(string.sub("$Revision: 1124 $", 12, -3))
if Recount.Version < revision then Recount.Version = revision end

local dbCombatants

--Data for Recount is tracked within this file
local Tracking={}

local UnitName = UnitName
local UnitHealth = UnitHealth
local UnitHealthMax = UnitHealthMax
local UnitIsFeignDeath = UnitIsFeignDeath
local GetTime = GetTime

local tonumber = tonumber
local type = type
local pairs = pairs
local unpack = unpack

local tinsert = table.insert

local string_upper = string.upper
local string_lower = string.lower
local string_sub = string.sub

local math_floor = math.floor
local math_abs = math.abs
local math_fmod = math.fmod

-- Elsia: This is straight from GUIDRegistryLib-0.1 by ArrowMaster.
local bit_bor	= bit.bor
local bit_band  = bit.band

local COMBATLOG_OBJECT_AFFILIATION_MINE		= COMBATLOG_OBJECT_AFFILIATION_MINE		or 0x00000001
local COMBATLOG_OBJECT_AFFILIATION_PARTY	= COMBATLOG_OBJECT_AFFILIATION_PARTY	or 0x00000002
local COMBATLOG_OBJECT_AFFILIATION_RAID		= COMBATLOG_OBJECT_AFFILIATION_RAID		or 0x00000004
local COMBATLOG_OBJECT_AFFILIATION_OUTSIDER	= COMBATLOG_OBJECT_AFFILIATION_OUTSIDER	or 0x00000008
local COMBATLOG_OBJECT_AFFILIATION_MASK		= COMBATLOG_OBJECT_AFFILIATION_MASK		or 0x0000000F
-- Reaction
local COMBATLOG_OBJECT_REACTION_FRIENDLY	= COMBATLOG_OBJECT_REACTION_FRIENDLY	or 0x00000010
local COMBATLOG_OBJECT_REACTION_NEUTRAL		= COMBATLOG_OBJECT_REACTION_NEUTRAL		or 0x00000020
local COMBATLOG_OBJECT_REACTION_HOSTILE		= COMBATLOG_OBJECT_REACTION_HOSTILE		or 0x00000040
local COMBATLOG_OBJECT_REACTION_MASK		= COMBATLOG_OBJECT_REACTION_MASK		or 0x000000F0
-- Ownership
local COMBATLOG_OBJECT_CONTROL_PLAYER		= COMBATLOG_OBJECT_CONTROL_PLAYER		or 0x00000100
local COMBATLOG_OBJECT_CONTROL_NPC			= COMBATLOG_OBJECT_CONTROL_NPC			or 0x00000200
local COMBATLOG_OBJECT_CONTROL_MASK			= COMBATLOG_OBJECT_CONTROL_MASK			or 0x00000300
-- Unit type
local COMBATLOG_OBJECT_TYPE_PLAYER			= COMBATLOG_OBJECT_TYPE_PLAYER			or 0x00000400
local COMBATLOG_OBJECT_TYPE_NPC				= COMBATLOG_OBJECT_TYPE_NPC				or 0x00000800
local COMBATLOG_OBJECT_TYPE_PET				= COMBATLOG_OBJECT_TYPE_PET				or 0x00001000
local COMBATLOG_OBJECT_TYPE_GUARDIAN		= COMBATLOG_OBJECT_TYPE_GUARDIAN		or 0x00002000
local COMBATLOG_OBJECT_TYPE_OBJECT			= COMBATLOG_OBJECT_TYPE_OBJECT			or 0x00004000
local COMBATLOG_OBJECT_TYPE_MASK			= COMBATLOG_OBJECT_TYPE_MASK			or 0x0000FC00

-- Special cases (non-exclusive)
local COMBATLOG_OBJECT_TARGET				= COMBATLOG_OBJECT_TARGET				or 0x00010000
local COMBATLOG_OBJECT_FOCUS				= COMBATLOG_OBJECT_FOCUS				or 0x00020000
local COMBATLOG_OBJECT_MAINTANK				= COMBATLOG_OBJECT_MAINTANK				or 0x00040000
local COMBATLOG_OBJECT_MAINASSIST			= COMBATLOG_OBJECT_MAINASSIST			or 0x00080000
local COMBATLOG_OBJECT_RAIDTARGET1			= COMBATLOG_OBJECT_RAIDTARGET1			or 0x00100000
local COMBATLOG_OBJECT_RAIDTARGET2			= COMBATLOG_OBJECT_RAIDTARGET2			or 0x00200000
local COMBATLOG_OBJECT_RAIDTARGET3			= COMBATLOG_OBJECT_RAIDTARGET3			or 0x00400000
local COMBATLOG_OBJECT_RAIDTARGET4			= COMBATLOG_OBJECT_RAIDTARGET4			or 0x00800000
local COMBATLOG_OBJECT_RAIDTARGET5			= COMBATLOG_OBJECT_RAIDTARGET5			or 0x01000000
local COMBATLOG_OBJECT_RAIDTARGET6			= COMBATLOG_OBJECT_RAIDTARGET6			or 0x02000000
local COMBATLOG_OBJECT_RAIDTARGET7			= COMBATLOG_OBJECT_RAIDTARGET7			or 0x04000000
local COMBATLOG_OBJECT_RAIDTARGET8			= COMBATLOG_OBJECT_RAIDTARGET8			or 0x08000000
local COMBATLOG_OBJECT_NONE					= COMBATLOG_OBJECT_NONE					or 0x80000000
local COMBATLOG_OBJECT_SPECIAL_MASK			= COMBATLOG_OBJECT_SPECIAL_MASK			or 0xFFFF0000

local LIB_FILTER_RAIDTARGET	= bit_bor(
	COMBATLOG_OBJECT_RAIDTARGET1, COMBATLOG_OBJECT_RAIDTARGET2, COMBATLOG_OBJECT_RAIDTARGET3, COMBATLOG_OBJECT_RAIDTARGET4,
	COMBATLOG_OBJECT_RAIDTARGET5, COMBATLOG_OBJECT_RAIDTARGET6, COMBATLOG_OBJECT_RAIDTARGET7, COMBATLOG_OBJECT_RAIDTARGET8
)
local LIB_FILTER_ME = bit_bor(
	COMBATLOG_OBJECT_AFFILIATION_MINE, COMBATLOG_OBJECT_CONTROL_PLAYER, COMBATLOG_OBJECT_TYPE_PLAYER
)
local LIB_FILTER_MY_PET = bit_bor(
						COMBATLOG_OBJECT_AFFILIATION_MINE,
						COMBATLOG_OBJECT_CONTROL_PLAYER,
						COMBATLOG_OBJECT_TYPE_PET
						)
local LIB_FILTER_PARTY = bit_bor(COMBATLOG_OBJECT_TYPE_PLAYER, COMBATLOG_OBJECT_AFFILIATION_PARTY)
local LIB_FILTER_RAID  = bit_bor(COMBATLOG_OBJECT_TYPE_PLAYER, COMBATLOG_OBJECT_AFFILIATION_RAID)
local LIB_FILTER_GROUP = bit_bor(LIB_FILTER_PARTY, LIB_FILTER_RAID)

local HotTickTimeId={
	[746]=1, -- First Aid (rank 1)
	[1159]=1,
	[3267]=1,
	[3268]=1,
	[7926]=1,
	[7927]=1,
	[23569]=1,
	[24412]=1,
	[10838]=1,
	[10839]=1,
	[23568]=1,
	[24413]=1,
	[18608]=1,
	[18610]=1,
	[23567]=1,
	[23696]=1,
	[24414]=1,
	[27030]=1,
	[27031]=1, -- First Aid (rank 12)
	[33763]=1, -- Lifebloom (rank 1) no other ranks
}

local DotTickTimeId={
	-- Mage Ticks
	[133]=2, -- Fireball (rank 1)
	[143]=2,
	[145]=2,
	[3140]=2,
	[8400]=2,
	[8401]=2,
	[8402]=2,
	[10148]=2,
	[10149]=2,
	[10150]=2,
	[10151]=2,
	[25306]=2,
	[27070]=2,
	[38692]=2, -- Fireball (rank 14)
	[11119]=2, -- Ignite (rank 1)
	[11120]=2,
	[12846]=2,
	[12847]=2,
	[12848]=2, -- Ignite (rank 5)
	[15407]=1, -- Mind Flay (rank 1)
	[17311]=1,
	[17312]=1,
	[17313]=1,
	[17314]=1,
	[18807]=1,
	[25387]=1, -- Mind Flay (rank 7)
	[980]=2, -- Curse of Agony (rank 1)
	[1014]=2,
	[6217]=2,
	[11711]=2,
	[11712]=2,
	[11713]=2,
	[27218]=2, -- Curse of Agony (rank 7)
	[603]=60, -- Curse of Doom (rank 1)
	[30910]=60, -- Curse of Doom (rank 2)
	[689]=1, -- Drain Life (rank 1) Elsia: According to wowhead it's 1. Which makes sense compared to Mind Flay...
	[699]=1,
	[709]=1,
	[7651]=1,
	[11699]=1,
	[11700]=1,
	[27219]=1,
	[27220]=1, -- Drain Life (rank 8)
	[755]=1, -- Health Funnel (rank 1)
	[3698]=1,
	[3699]=1,
	[3700]=1,
	[11693]=1,
	[11694]=1,
	[11695]=1,
	[27259]=1, -- Health Funnel (rank 8)
	[1949]=1, -- Hellfire (rank 1)
	[11683]=1,
	[11684]=1,
	[27213]=1, -- Hellfire (rank 4)
}

-- Identified Absorb abilities by spell ID and contains their respective expected durations (currently unused).
local AbsorbSpellDuration = 
{
	-- Death Knight
	[48707] = 5, -- Anti-Magic Shell (DK) Rank 1 -- Does not currently seem to show tracable combat log events. It shows energizes which do not reveal the amount of damage absorbed
	[51052] = 10, -- Anti-Magic Zone (DK)( Rank 1 (Correct spellID?)
		-- Does DK Spell Deflection show absorbs in the CL?
	[51271] = 20, -- Unbreakable Armor (DK)
	-- Druid
	[62606] = 10, -- Savage Defense proc. (Druid) Tooltip of the original spell doesn't clearly state that this is an absorb, but the buff does.
	-- Mage
	[11426] = 60, -- Ice Barrier (Mage) Rank 1
	[13031] = 60,
	[13032] = 60,
	[13033] = 60,
	[27134] = 60,
	[33405] = 60,
	[43038] = 60,
	[43039] = 60, -- Rank 8
	[6143] = 30, -- Frost Ward (Mage) Rank 1
	[8461] = 30, 
	[8462] = 30,  
	[10177] = 30,  
	[28609] = 30,
	[32796] = 30,
	[43012] = 30, -- Rank 7
	[1463] = 60, --  Mana shield (Mage) Rank 1
	[8494] = 60,
	[8495] = 60,
	[10191] = 60,
	[10192] = 60,
	[10193] = 60,
	[27131] = 60,
	[43019] = 60,
	[43020] = 60, -- Rank 9
	[543] = 30 , -- Fire Ward (Mage) Rank 1
	[8457] = 30,
	[8458] = 30,
	[10223] = 30,
	[10225] = 30,
	[27128] = 30,
	[43010] = 30, -- Rank 7
	-- Paladin
	[58597] = 6, -- Sacred Shield (Paladin) proc (Fixed, thanks to Julith)
	-- Priest
	[17] = 30, -- Power Word: Shield (Priest) Rank 1
	[592] = 30,
	[600] = 30,
	[3747] = 30,
	[6065] = 30,
	[6066] = 30,
	[10898] = 30,
	[10899] = 30,
	[10900] = 30,
	[10901] = 30,
	[25217] = 30,
	[25218] = 30,
	[48065] = 30,
	[48066] = 30, -- Rank 14
	[47509] = 12, -- Divine Aegis (Priest) Rank 1
	[47511] = 12,
	[47515] = 12, -- Divine Aegis (Priest) Rank 3 (Some of these are not actual buff spellIDs)
	[47753] = 12, -- Divine Aegis (Priest) Rank 1
	[54704] = 12, -- Divine Aegis (Priest) Rank 1
	[47788] = 10, -- Guardian Spirit  (Priest) (50 nominal absorb, this may not show in the CL)
	-- Warlock
	[7812] = 30, -- Sacrifice (warlock) Rank 1
	[19438] = 30,
	[19440] = 30,
	[19441] = 30,
	[19442] = 30,
	[19443] = 30,
	[27273] = 30,
	[47985] = 30,
	[47986] = 30, -- rank 9
	[6229] = 30, -- Shadow Ward (warlock) Rank 1
	[11739] = 30,
	[11740] = 30,
	[28610] = 30,
	[47890] = 30,
	[47891] = 30, -- Rank 6
	-- Consumables
	[29674] = 86400, -- Lesser Ward of Shielding
	[29719] = 86400, -- Greater Ward of Shielding (these have infinite duration, set for a day here :P)
	[29701] = 86400,
	[28538] = 120, -- Major Holy Protection Potion
	[28537] = 120, -- Major Shadow
	[28536] = 120, --  Major Arcane
	[28513] = 120, -- Major Nature
	[28512] = 120, -- Major Frost
	[28511] = 120, -- Major Fire
	[7233] = 120, -- Fire
	[7239] = 120, -- Frost
	[7242] = 120, -- Shadow Protection Potion
	[7245] = 120, -- Holy
	[6052] = 120, -- Nature Protection Potion
	[53915] = 120, -- Mighty Shadow Protection Potion
	[53914] = 120, -- Mighty Nature Protection Potion
	[53913] = 120, -- Mighty Frost Protection Potion
	[53911] = 120, -- Mighty Fire
	[53910] = 120, -- Mighty Arcane
	[17548] = 120, --  Greater Shadow
	[17546] = 120, -- Greater Nature
	[17545] = 120, -- Greater Holy
	[17544] = 120, -- Greater Frost
	[17543] = 120, -- Greater Fire
	[17549] = 120, -- Greater Arcane
	[28527] = 15, -- Fel Blossom
	[29432] = 3600, -- Frozen Rune usage (Naxx classic)
	-- Item usage
	[36481] = 4, -- Arcane Barrier (TK Kael'Thas) Shield
	[57350] = 6, -- Darkmoon Card: Illusion
	[17252] = 30, -- Mark of the Dragon Lord (LBRS epic ring) usage
	[25750] = 15, -- Defiler's Talisman/Talisman of Arathor Rank 1
	[25747] = 15,
	[25746] = 15,
	[23991] = 15,
	[31000] = 300, -- Pendant of Shadow's End Usage
	[30997] = 300, -- Pendant of Frozen Flame Usage
	[31002] = 300, -- Pendant of the Null Rune
	[30999] = 300, -- Pendant of Withering
	[30994] = 300, -- Pendant of Thawing
	[31000] = 300, -- 
	[23506]= 20, -- Arena Grand Master Usage (Aura of Protection)
	[12561] = 60, -- Goblin Construction Helmet usage
	[31771] = 20, -- Runed Fungalcap usage
	[21956] = 10, -- Mark of Resolution usage
	[29506] = 20, -- The Burrower's Shell
	[4057] = 60, -- Flame Deflector
	[4077] = 60, -- Ice Deflector
	[39228] = 20, -- Argussian Compass (may not be an actual absorb)
	-- Item procs
	[27779] = 30, -- Divine Protection - Priest dungeon set 1/2  Proc
	[11657] = 20, -- Jang'thraze (Zul Farrak) proc
	[10368] = 15, -- Uther's Strength proc
	[37515] = 15, -- Warbringer Armor Proc
	[42137] = 86400, -- Greater Rune of Warding Proc
	[26467] = 30, -- Scarab Brooch proc
	[27539] = 6, -- Thick Obsidian Breatplate proc
	[28810] = 30, -- Faith Set Proc Armor of Faith
	[54808] = 12, -- Noise Machine proc Sonic Shield 
	[55019] = 12, -- Sonic Shield (one of these too ought to be wrong)
	[64411] = 15, -- Blessing of the Ancient (Val'anyr Hammer of Ancient Kings equip effect)
	[64413] = 8, -- Val'anyr, Hammer of Ancient Kings proc Protection of Ancient Kings
	-- Misc
	[40322] = 30, -- Teron's Vengeful Spirit Ghost - Spirit Shield
	-- Boss abilities
	[65874] = 15, -- Twin Val'kyr's Shield of Darkness 175000
	[67257] = 15, -- 300000
	[67256] = 15, -- 700000
	[67258] = 15, -- 1200000
	[65858] = 15, -- Twin Val'kyr's Shield of Lights 175000
	[67260] = 15, -- 300000
	[67259] = 15, -- 700000
	[67261] = 15, -- 1200000
}

local bossIDs = BossIDs.BossIDs

function Recount.IsBoss(GUID)
   return GUID and bossIDs[tonumber(GUID:sub(9, 12), 16)]
end

	
-- Base Events: SWING ‚Äì These events relate to melee swings, commonly called ‚ÄúWhite Damage‚Äù. RANGE ‚Äì These events relate to hunters shooting their bow or a warlock shooting their wand. SPELL ‚Äì These events relate to spells and abilities. SPELL_CAST ‚Äì These events relate to spells starting and failing. SPELL_AURA ‚Äì These events relate to buffs and debuffs. SPELL_PERIODIC ‚Äì These events relate to HoT, DoTs and similar effects. DAMAGE_SHIELD ‚Äì These events relate to damage shields, such as Thorns ENCHANT ‚Äì These events relate to temporary and permanent item buffs. ENVIRONMENTAL ‚Äì This is any damage done by the world. Fires, Lava, Falling, etc.
-- Suffixes: _DAMAGE ‚Äì If the event resulted in damage, here it is. _MISSED - If the event resulted in failure, such as missing, resisting or being blocked. _HEAL ‚Äì If the event resulted in a heal. _ENERGIZE ‚Äì If the event resulted in a power restoration. _LEECH ‚Äì If the event transferred health or power. _DRAIN ‚Äì If the event reduces power, but did not transfer it.
-- Special Events: PARTY_KILL ‚Äì Fired when you or a party member kills something. UNIT_DIED ‚Äì Fired when any nearby unit dies. 

local SPELLSCHOOL_PHYSICAL = 1
local SPELLSCHOOL_HOLY = 2
local SPELLSCHOOL_FIRE = 4
local SPELLSCHOOL_NATURE = 8
local SPELLSCHOOL_NATUREFIRE = SPELLSCHOOL_FIRE + SPELLSCHOOL_NATURE
local SPELLSCHOOL_FROST = 16
local SPELLSCHOOL_FROSTFIRE = SPELLSCHOOL_FIRE + SPELLSCHOOL_FROST
local SPELLSCHOOL_SHADOW = 32
local SPELLSCHOOL_ARCANE = 64

Recount.SpellSchoolName = {
	[SPELLSCHOOL_PHYSICAL] = "Physical",  -- Elsia: Do NOT localize this, it breaks functionality!!! If you need this localized contact me on WowAce or Curse.
	[SPELLSCHOOL_HOLY] = "Holy",  -- Elsia: Do NOT localize this, it breaks functionality!!! If you need this localized contact me on WowAce or Curse.
	[SPELLSCHOOL_FIRE] = "Fire",  -- Elsia: Do NOT localize this, it breaks functionality!!! If you need this localized contact me on WowAce or Curse.
	[SPELLSCHOOL_NATURE] = "Nature",  -- Elsia: Do NOT localize this, it breaks functionality!!! If you need this localized contact me on WowAce or Curse.
	[SPELLSCHOOL_NATUREFIRE] = "Naturefire",  -- Elsia: Do NOT localize this, it breaks functionality!!! If you need this localized contact me on WowAce or Curse.
	[SPELLSCHOOL_FROST] = "Frost",  -- Elsia: Do NOT localize this, it breaks functionality!!! If you need this localized contact me on WowAce or Curse.
	[SPELLSCHOOL_FROSTFIRE] = "Frostfire", -- Elsia: Do NOT localize this, it breaks functionality!!! If you need this localized contact me on WowAce or Curse.
	[SPELLSCHOOL_SHADOW] = "Shadow",  -- Elsia: Do NOT localize this, it breaks functionality!!! If you need this localized contact me on WowAce or Curse.
	[SPELLSCHOOL_ARCANE] = "Arcane",  -- Elsia: Do NOT localize this, it breaks functionality!!! If you need this localized contact me on WowAce or Curse.
}

function Recount:MatchGUID(nName,nGUID,nFlags)
	if not Recount.PlayerName or not Recount.PlayerGUID then
		if bit_band(nFlags, LIB_FILTER_ME) == LIB_FILTER_ME then
			Recount.PlayerName = nName
			Recount.PlayerGUID = nGUID
			return
		end
	end
--[[
	if bit_band(nFlags,LIB_FILTER_MY_PET) == LIB_FILTER_MY_PET then
		if not Recount.PlayerPet or not Recount.PlayerPetGUID or nGUID~=Recount.PlayerPetGUID then
			--Recount:Print("NewPet detected: "..nName.." "..nGUID.."("..(Recount.PlayerPetGUID or "nil")..")")
			Recount.PlayerPetGUID = nGUID
			if Recount.PlayerPet ~= nName then
				Recount.PlayerPet = nName
			end
			return
		end
	end]]
end

function Recount:SwingDamage(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,amount, overkill,school, resisted, blocked, absorbed, critical, glancing, crushing)
	Recount:SpellDamage(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,0, L["Melee"], SPELLSCHOOL_PHYSICAL, amount, overkill,school, resisted, blocked, absorbed, critical, glancing, crushing)
end

function Recount:SpellBuildingDamage(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing)
-- Ignoring these for now
end

function Recount:SpellBuildingHeal(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, amount, overheal,critical)
-- Ignoring these for now
end

function Recount:SpellDamage(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing)

--	amount = amount - overkill -- Taking out overdamage on killing blows

	local HitType="Hit" -- Elsia: Do NOT localize this, it breaks functionality!!! If you need this localized contact me on WowAce or Curse.
        local isDot
	if eventtype == "SPELL_PERIODIC_DAMAGE" then

		HitType="Tick"  -- Elsia: Do NOT localize this, it breaks functionality!!! If you need this localized contact me on WowAce or Curse.
		spellName = spellName .." ("..L["DoT"]..")"
		isDot = true
	end
	if critical then
		HitType="Crit"  -- Elsia: Do NOT localize this, it breaks functionality!!! If you need this localized contact me on WowAce or Curse.
	end
	if eventtype == "DAMAGE_SPLIT" then
		HitType="Split"  -- Elsia: Do NOT localize this, it breaks functionality!!! If you need this localized contact me on WowAce or Curse.
	end
	if crushing then
		HitType="Crushing"  -- Elsia: Do NOT localize this, it breaks functionality!!! If you need this localized contact me on WowAce or Curse.
	end
	if glancing	then
		HitType="Glancing"  -- Elsia: Do NOT localize this, it breaks functionality!!! If you need this localized contact me on WowAce or Curse.
	end
--[[	if blocked then
		HitType="Block"
	end
	if absorbed then
		HitType="Absorbed"
	end--]]
	if eventtype == "RANGE_DAMAGE" then spellSchool = school end

	Recount:AddDamageData(srcName, dstName, spellName, Recount.SpellSchoolName[spellSchool], HitType, amount, resisted, srcGUID, srcFlags, dstGUID, dstFlags, spellId, blocked, absorbed, isDot)
end

function Recount:EnvironmentalDamage(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,enviromentalType, amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing)

	local HitType = "Hit"  -- Elsia: Do NOT localize this, it breaks functionality!!! If you need this localized contact me on WowAce or Curse.
	if critical then
		HitType="Crit"  -- Elsia: Do NOT localize this, it breaks functionality!!! If you need this localized contact me on WowAce or Curse.
	end
	if crushing then
		HitType="Crushing"  -- Elsia: Do NOT localize this, it breaks functionality!!! If you need this localized contact me on WowAce or Curse.
	end
	if glancing	then
		HitType="Glancing"  -- Elsia: Do NOT localize this, it breaks functionality!!! If you need this localized contact me on WowAce or Curse.
	end
	--[[if blocked then
		HitType="Block"
	end
	if absorbed then
		HitType="Absorbed"
	end--]]

	Recount:AddDamageData("Environment", dstName, Recount:FixCaps(enviromentalType), Recount.SpellSchoolName[school], HitType, amount, resisted, srcGUID, 0, dstGUID, dstFlags, nil, blocked, absorbed)
end

function Recount:FixCaps(capsstr)
	if type(capsstr)=="string" then
		return string_upper(string_sub(capsstr,1,1))..string_lower(string_sub(capsstr,2))
	else
		return nil
	end
end

function Recount:SwingMissed(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, missType, missAmount)
	
	local blocked
	local absorbed
	local spellId = L["Melee"]

	if missType == "ABSORB" then
		absorbed = missAmount
	elseif missType == "BLOCK" then
		blocked = missAmount
	end
	
	Recount:AddDamageData(srcName, dstName, L["Melee"], nil, Recount:FixCaps(missType),nil,nil, srcGUID, srcFlags, dstGUID, dstFlags, spellId, blocked, absorbed)  -- Elsia: Do NOT localize this, it breaks functionality!!! If you need this localized contact me on WowAce or Curse.
end

function Recount:SpellMissed(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType, missAmount)

	local blocked
	local absorbed

	if missType == "ABSORB" then
		absorbed = missAmount
	elseif missType == "BLOCK" then
		blocked = missAmount
	end

	Recount:AddDamageData(srcName, dstName, spellName, Recount.SpellSchoolName[spellSchool], Recount:FixCaps(missType),nil,nil, srcGUID, srcFlags, dstGUID, dstFlags, spellId, blocked, absorbed)
end

function Recount:SpellHeal(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, amount, overheal,absorbed, critical)

	local healtype="Hit"  -- Elsia: Do NOT localize this, it breaks functionality!!! If you need this localized contact me on WowAce or Curse.
        local isHot
	if eventtype == "SPELL_PERIODIC_HEAL" then
	   
		healtype="Tick"  -- Elsia: Do NOT localize this, it breaks functionality!!! If you need this localized contact me on WowAce or Curse.
	        isHot = true
		-- Not activated yet: spellName=spellName.." ("..L["HoT"]..")"
	end

	if absorbed==1 and not critical then -- 3.1 to 3.2 combatibility
		critical = absorbed
		absorbed = nil
	end
	
	if critical then
		healtype="Crit"  -- Elsia: Do NOT localize this, it breaks functionality!!! If you need this localized contact me on WowAce or Curse.
	end

	Recount:AddHealData(srcName, dstName, spellName, healtype, amount,overheal, srcGUID,srcFlags,dstGUID,dstFlags,spellId,isHot, absorbed)-- Elsia: Overheal missing!!!
end

local extraattacks

function Recount:SpellExtraAttacks(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, amount)
--[[	source = Recount.curr_srcName
	victim = Recount.curr_dstName

	local healtype="Hit"

	Recount:Print(Recount.curr_type.." "..spellName.." "..amount)
	Recount:AddDamageData(source, victim, spellName, Recount.SpellSchoolName[spellSchool], HitType, amount)--]]

	-- Elsia: Don't have use for extra attacks currently, amount is number of extra attacks it seems from combat log traces.
	
	extraattacks = extraattacks or {}
	if extraattacks[srcName] then
		Recount:DPrint("Double proc: "..spellName.." "..extraattacks[srcName].spellName)
	else
		extraattacks[srcName] = {}
		extraattacks[srcName].spellName = spellName
		extraattacks[srcName].amount = amount
		extraattacks[srcName].proctime = GetTime()
		Recount:DPrint("Proc: "..spellName.." "..extraattacks[srcName].spellName)
	end
end

function Recount:SpellDrain(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, amount, powerType, extraAmount)

-- Currently unused.
end

-- Biffur: Keep track of active shields on each target
local AllShields={}

function Recount:AddAbsorbCredit(source, victim, spellName, spellId, absorbed)
	Recount:DPrint("Absorb goes to "..source.." having used spell "..spellName.."("..spellId..")" ..":"..absorbed)
	if not Recount.db2.combatants[source] then
		Recount:DPrint("No source combatant!")
	else
		local sourceData=Recount.db2.combatants[source]
		Recount:AddAmount(sourceData,"Absorbs",absorbed)
		Recount:AddTableDataStats(sourceData,"Absorbed",spellName,victim,absorbed)

		if Recount.db.profile.MergeAbsorbs then -- Elsia: This cannot be unsplit, but it saves memory.
			Recount:AddTableDataStats(sourceData,"Heals",spellName,"Absorb",absorbed)
			Recount:AddTableDataSum(sourceData,"HealedWho",victim,spellName,absorbed)
		end
	end
end

function Recount:SpellAuraApplied(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, auraType, amount)
	-- Is this an absorb effect?
	if AbsorbSpellDuration[spellId] and amount then
		-- Yes? Add shield
		AllShields[dstName] = AllShields[dstName] or {}
		Recount:DPrint("Assigning active " .. spellName .." on " .. dstName .." cast by " ..srcName)
		AllShields[dstName][spellId] = AllShields[dstName][spellId] or {}
		if AllShields[dstName][spellId][srcName] then
			Recount:DPrint("Valid shield is being rewritten without having been removed first: "..srcName.." "..dstName.." "..spellName)
		end
		AllShields[dstName][spellId][srcName] = {}
		AllShields[dstName][spellId][srcName] = amount
		
		if not Recount.db2.combatants[srcName]  then
			Recount:DPrint("No source combatant!")
		else
			local sourceData=Recount.db2.combatants[srcName]
			Recount:AddTableDataSum(sourceData,"ShieldedWho",dstName,spellName,1)
		end

	end
end

function Recount:SpellAuraRefresh(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, auraType,amount)
	if AbsorbSpellDuration[spellId] and amount then
		-- Yes? Update shield if it is tracked
		if AllShields[dstName] and AllShields[dstName][spellId] and AllShields[dstName][spellId][srcName] then
				Recount:DPrint("Updating " .. spellName .." from " .. dstName .. " at time ".. timestamp .. " old stamp was "..AllShields[dstName][spellId][srcName].." "..amount)

--			if AllShields[dstName][spellId][srcName].expiration < timestamp then
--				Recount:DPrint("EXPIRED REFRESH FOUND!")
--			end
			local absorb = AllShields[dstName][spellId][srcName] - amount
			AllShields[dstName][spellId][srcName] = amount
			if absorb > 0 then
				Recount:AddAbsorbCredit(srcName, dstName, spellName, spellId, absorb)
			end
		else
			Recount:DPrint("ORPHAN REFRESH FOUND! Rescuing")
			Recount:SpellAuraApplied(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, auraType, amount)
		end
	end
end

function Recount:SpellAuraRemoved(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, auraType)

	-- Spirit of Redemption and Shadow of Death handling
	if spellId == 54223 or spellId == 27827 then
		Recount:HandleDoubleDeath(srcName, dstName, spellName,srcGUID,srcFlags,dstGUID,dstFlags,spellId)		

		-- Is this an absorb effect?
	elseif AbsorbSpellDuration[spellId] and amount then
		-- Yes? Lets remove it if it was tracked
		if AllShields[dstName] and AllShields[dstName][spellId] and AllShields[dstName][spellId][srcName] then
			
			local absorb = AllShields[dstName][spellId][srcName] - amount
			if absorb > 0 then
				Recount:AddAbsorbCredit(source, victim, spellName, spellId, absorb)
			end
			AllShields[dstName][spellId][srcName]=0
		else
			Recount:DPrint("Shield "..spellName.." was removed on target "..dstName.." but wasn't detected as applied")
		end
	end
end

function Recount:SpellAuraAppliedRemovedDose(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, auraType, amount)
-- Not sure yet how to handle this

end

function Recount:SpellCastStartSuccess(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool)
	if eventtype == "SPELL_INSTAKILL" then
		--Recount:Print(Recount.curr_type .." "..source.." "..victim)
		Recount:AddDeathData(srcName, dstName, nil, srcGUID, srcFlags, dstGUID, dstFlags, spellId)
	end
end

-- Note: GetSpellLink(id) gets spell name from ID.
--  GetSpellInfo(id)

function Recount:SpellCastFailed(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, failedType)
-- Not sure yet how to handle this, are these interrupts?
end

function Recount:EnchantAppliedRemoved(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellName, itemId, itemName)
-- Not sure yet how to handle this, 
end

function Recount:PartyKill(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags)
	--Recount:AddDeathData(srcName , dstName, nil, srcGUID, srcFlags, dstGUID, dstFlags, nil)
-- Could be killing blow tracker
end

function Recount:UnitDied(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags)
	Recount:AddDeathData(nil , dstName, nil, srcGUID, srcFlags, dstGUID, dstFlags, nil)
end

function Recount:SpellSummon(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool)
	Recount:AddPetCombatant(dstGUID,dstName,dstFlags,srcGUID,srcName,srcFlags)
end

function Recount:SpellCreate(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool)
-- Elsia: We do nothing for these yet.
end

local EventParse =
{
	["SWING_DAMAGE"] = Recount.SwingDamage, -- Elsia: Melee swing damage
	["RANGE_DAMAGE"] = Recount.SpellDamage, -- Elsia: Ranged and spell damage types
	["SPELL_DAMAGE"] = Recount.SpellDamage,
	["SPELL_PERIODIC_DAMAGE"] = Recount.SpellDamage,
	["DAMAGE_SHIELD"] = Recount.SpellDamage,
	["DAMAGE_SPLIT"] = Recount.SpellDamage,
	["ENVIRONMENTAL_DAMAGE"] = Recount.EnvironmentalDamage, -- Elsia: Environmental damage
	["SWING_MISSED"] = Recount.SwingMissed, -- Elsia: Misses
	["RANGE_MISSED"] = Recount.SpellMissed,
	["SPELL_MISSED"] = Recount.SpellMissed,
	["SPELL_PERIODIC_MISSED"] = Recount.SpellMissed,
	["DAMAGE_SHIELD_MISSED"] = Recount.SpellMissed,
	["SPELL_HEAL"] = Recount.SpellHeal, -- Elsia: heals
	["SPELL_PERIODIC_HEAL"] = Recount.SpellHeal,
	["SPELL_ENERGIZE"] = Recount.SpellEnergize, -- Elsia: Energize
	["SPELL_PERIODIC_ENERGIZE"] = Recount.SpellEnergize,
	["SPELL_EXTRA_ATTACKS"] = Recount.SpellExtraAttacks, -- Elsia: Extra attacks
	["SPELL_INTERRUPT"] = Recount.SpellInterrupt, -- Elsia: Interrupts
	["SPELL_DRAIN"] = Recount.SpellDrain, -- Elsia: Drains and leeches.
	["SPELL_LEECH"] = Recount.SpellLeech,
	["SPELL_PERIODIC_DRAIN"] = Recount.SpellDrain,
	["SPELL_PERIODIC_LEECH"] = Recount.SpellLeech,
	["SPELL_DISPEL_FAILED"] = Recount.SpellAuraDispelFailed, -- Elsia: Failed dispell
--	["SPELL_AURA_DISPELLED"] = Recount.SpellAuraDispelledStolen, -- Removed with 2.4.3
--	["SPELL_AURA_STOLEN"] = Recount.SpellAuraDispelledStolen, -- Removed with 2.4.3
	["SPELL_AURA_APPLIED"] = Recount.SpellAuraApplied, -- Elsia: Auras
	["SPELL_AURA_REMOVED"] = Recount.SpellAuraRemoved,
	["SPELL_AURA_APPLIED_DOSE"] = Recount.SpellAuraAppliedRemovedDose, -- Elsia: Aura doses
	["SPELL_AURA_REMOVED_DOSE"] = Recount.SpellAuraAppliedRemovedDose,
	["SPELL_CAST_START"] = Recount.SpellCastStartSuccess, -- Elsia: Spell casts
	["SPELL_CAST_SUCCESS"] = Recount.SpellCastStartSuccess,
	["SPELL_INSTAKILL"] = Recount.SpellCastStartSuccess,
	["SPELL_DURABILITY_DAMAGE"] = Recount.SpellCastStartSuccess,
	["SPELL_DURABILITY_DAMAGE_ALL"] = Recount.SpellCastStartSuccess,
	["SPELL_CAST_FAILED"] = Recount.SpellCastFailed, -- Elsia: Spell aborts/fails
	["ENCHANT_APPLIED"] = Recount.EnchantAppliedRemoved, -- Elsia: Enchants
	["ENCHANT_REMOVED"] = Recount.EnchantAppliedRemoved,
	["PARTY_KILL"] = Recount.PartyKill, -- Elsia: Party killing blow
	["UNIT_DIED"] = Recount.UnitDied, -- Elsia: Unit died
	["UNIT_DESTROYED"] = Recount.UnitDied,
	["SPELL_SUMMON"] = Recount.SpellSummon, -- Elsia: Summons
	["SPELL_CREATE"] = Recount.SpellCreate, -- Elsia: Creations
	["SPELL_AURA_BROKEN"] = Recount.SpellAuraBroken, -- New with 2.4.3
	["SPELL_AURA_BROKEN_SPELL"] = Recount.SpellAuraBroken, -- New with 2.4.3
	["SPELL_AURA_REFRESH"] = Recount.SpellAuraRefresh, -- New with 2.4.3
	["SPELL_DISPEL"] = Recount.SpellAuraDispelledStolen, -- Post 2.4.3
	["SPELL_STOLEN"] = Recount.SpellAuraDispelledStolen, -- Post 2.4.3
	["SPELL_RESURRECT"] = Recount.SpellResurrect, -- Post WotLK
	["SPELL_BUILDING_DAMAGE"] = Recount.SpellBuildingDamage, -- Post WotLK
	["SPELL_BUILDING_HEAL"] = Recount.SpellBuildingHeal,
	["UNIT_DISSIPATES"] = Recount.UnitDied, -- Post 3.2
}

local QuickExitEvents =
{
--	["SPELL_AURA_APPLIED"] = true,
--	["SPELL_AURA_REMOVED"] = true,
	["SPELL_AURA_APPLIED_DOSE"] = true,
	["SPELL_AURA_REMOVED_DOSE"] = true,
--	["SPELL_AURA_REFRESH"] = true,
	["SPELL_CAST_START"] = true,
	["SPELL_CAST_SUCCESS"] = true,
	["SPELL_CAST_FAILED"] = true,
	["SPELL_DRAIN"] = true, 
--	["SPELL_LEECH"] = true, 
	["PARTY_KILL"] = true,
	["SPELL_PERIODIC_DRAIN"] = true, 
--	["SPELL_PERIODIC_LEECH"] = true, 
	["SPELL_DISPEL_FAILED"] = true,
	["SPELL_DURABILITY_DAMAGE"] = true,
	["SPELL_DURABILITY_DAMAGE_ALL"] = true,
	["ENCHANT_APPLIED"] = true,
	["ENCHANT_REMOVED"] = true,
	["SPELL_CREATE"] = true,
	["SPELL_BUILDING_DAMAGE"] = true,
}

-- This is to allow modularity of the tracker code. Functions that are not registered to be handled will be quickexited.
if not Recount.SpellResurrect then
	QuickExitEvents["SPELL_RESURRECT"] = true
end
if not Recount.SpellAuraBroken then
	QuickExitEvents["SPELL_AURA_BROKEN"] = true
	QuickExitEvents["SPELL_AURA_BROKEN_SPELL"] = true
end
if not Recount.SpellAuraDispelledStolen then
	QuickExitEvents["SPELL_DISPEL"] = true
	QuickExitEvents["SPELL_STOLEN"] = true
end
if not Recount.SpellEnergize then
	QuickExitEvents["SPELL_ENERGIZE"] = true
	QuickExitEvents["SPELL_PERIODIC_ENERGIZE"] = true
	QuickExitEvents["SPELL_LEECH"] = true
	QuickExitEvents["SPELL_PERIODIC_LEECH"] = true
end
if not Recount.SpellInterrupt then
	QuickExitEvents["SPELL_INTERRUPT"] = true
end


local GROUPED_FILTER_BITMASK = COMBATLOG_OBJECT_AFFILIATION_MINE+COMBATLOG_OBJECT_AFFILIATION_PARTY+COMBATLOG_OBJECT_AFFILIATION_RAID
local SELF_FILTER_BITMASK = COMBATLOG_OBJECT_AFFILIATION_MINE+COMBATLOG_OBJECT_TYPE_PLAYER
local UNGROUPED_FILTER_BITMASK = COMBATLOG_OBJECT_TYPE_PLAYER+COMBATLOG_OBJECT_REACTION_FRIENDLY
local PET_FILTER_BITMASK = COMBATLOG_OBJECT_TYPE_PET+COMBATLOG_OBJECT_TYPE_GUARDIAN
local GROUPED_PET_FILTER_BITMASK = COMBATLOG_OBJECT_AFFILIATION_PARTY+COMBATLOG_OBJECT_AFFILIATION_RAID
local UNGROUPED_PET_FILTER_BITMASK = COMBATLOG_OBJECT_AFFILIATION_OUTSIDER+COMBATLOG_OBJECT_REACTION_FRIENDLY

function Recount:CheckRetentionFromFlags(nameFlags,name,nameGUID)

  local filters = Recount.db.profile.Filters.Data

  if filters["Grouped"] and bit_band(nameFlags, GROUPED_FILTER_BITMASK) ~= 0 then

    return true -- Grouped

  elseif filters["Self"] and bit_band(nameFlags, SELF_FILTER_BITMASK) == SELF_FILTER_BITMASK then

    return true -- Self

  elseif filters["Ungrouped"] and bit_band(nameFlags, UNGROUPED_FILTER_BITMASK) == UNGROUPED_FILTER_BITMASK then

    return true -- Ungrouped

  elseif filters["Hostile"] and bit_band(nameFlags, COMBATLOG_OBJECT_CONTROL_PLAYER) ~=0 then

    return true

  elseif filters["Pet"] and bit_band(nameFlags, PET_FILTER_BITMASK) ~=0 then

    if filters["Self"] and bit_band(nameFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) ~=0 then

      return true

    elseif filters["Grouped"] and  bit_band(nameFlags, GROUPED_PET_FILTER_BITMASK) ~=0 then

      return true

    elseif filters["Ungrouped"] and bit_band(nameFlags, UNGROUPED_PET_FILTER_BITMASK) == UNGROUPED_PET_FILTER_BITMASK then

      return true

	elseif bit_band(nameFlags, COMBATLOG_OBJECT_TYPE_GUARDIAN)~=0 and Recount:GetGuardianOwnerByGUID(nameGUID) then -- This is necessary because guardian combat log flags can be wrong in 3.0.9

	  return true

    end

  elseif bit_band(nameFlags, COMBATLOG_OBJECT_CONTROL_NPC) ~=0 then 

     local isBoss = Recount.IsBoss(nameGUID) 

     if not isBoss and (filters["Trivial"] or filters["Nontrivial"]) then

        return true

     elseif isBoss and filters["Boss"] then

        return true

     end

  end

  return false

end

Recount.srcRetention = false
Recount.dstRetention = false
local srcRetention = Recount.srcRetention
local dstRetention = Recount.dstRetention
local parsefunc
function Recount:CombatLogEvent(_,timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	if not Recount.db.profile.GlobalDataCollect or not Recount.CurrentDataCollect then
		return
	end

	if QuickExitEvents[eventtype] then -- Counter bursty combat log events we don't care about.
		return
	end
	
	srcRetention = Recount:CheckRetentionFromFlags(srcFlags,srcName,srcGUID)
	dstRetention = Recount:CheckRetentionFromFlags(dstFlags,dstName,dstGUID)
 	
	if not srcRetention and not dstRetention then
		return
	end
	
	Recount.srcRetention = srcRetention
	Recount.dstRetention = dstRetention

	if srcName == nil then
		srcName = "No One"
	else
		Recount:MatchGUID(srcName,srcGUID,srcFlags)
	end
	if dstName == nil then
		dstName = "No One"
	else
		Recount:MatchGUID(dstName,dstGUID,dstFlags)
	end

	parsefunc = EventParse[eventtype]
	
	if parsefunc then
		parsefunc(self, timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	else
		Recount:Print("Unknown combat log event type: "..eventtype)
	end
end

function Recount:SetActive(who)
	if not who then return end

	who.LastActive=Recount.CurTime
end

local eventtime
local Adding
function Recount:AddTimeEvent(who, onWho, ability, friendly)

	if not who then return end

	eventtime=GetTime()
	who.LastAbility = who.LastAbility or 0
	Adding=eventtime-who.LastAbility
	
	who.LastAbility=eventtime
	
	if Adding>3.5 then
		Adding=3.5
	end

	Adding=math_floor(100*Adding+0.5)/100

	Recount:AddOwnerPetLazySyncAmount(who,"ActiveTime", Adding)
	--Recount:AddSyncAmount(who,"ActiveTime", Adding)
	

	Recount:AddAmount(who,"ActiveTime",Adding)
	Recount:AddTableDataSum(who,"TimeSpent",onWho,ability,Adding)

	if friendly then
		Recount:AddAmount(who,"TimeHeal",Adding)
		Recount:AddTableDataSum(who,"TimeHealing",onWho,ability,Adding)
	else
		Recount:AddAmount(who,"TimeDamage",Adding)
		Recount:AddTableDataSum(who,"TimeDamaging",onWho,ability,Adding)
	end
end


--Only care about event tracking for those we want to track deaths for
function Recount:AddCurrentEvent(who, eventType, incoming, number, event)
	if not who then return end
	if Recount.db.profile.Filters.TrackDeaths[who.type] then
		who.LastEvents = who.LastEvents or {}
		who.LastEventTimes = who.LastEventTimes or {}
		who.LastEventType = who.LastEventType or {}
		who.LastEventIncoming = who.LastEventIncoming or {}
		who.NextEventNum = who.NextEventNum or 1
		who.LastEventTimes[who.NextEventNum]=GetTime()
		who.LastEventType[who.NextEventNum]=eventType
		who.LastEventIncoming[who.NextEventNum]=incoming
		who.LastEvents[who.NextEventNum]=event --(eventType or "").." "..(abiliy or "").." "..(number or "")

		if (not who.unit) or (UnitName(who.unit)~=who.Name) and who.UnitLockout<Recount.UnitLockout then
			who.unit=Recount:FindUnit(who.Name)
			who.UnitLockout=Recount.CurTime
		end
		
		if who.unit then
			if UnitHealthMax(who.unit)~=100 then
				who.LastEventHealth = who.LastEventHealth or {}
				who.LastEventHealth[who.NextEventNum]=UnitHealth(who.unit).." ("..math_floor(100*UnitHealth(who.unit)/UnitHealthMax(who.unit)).."%)"
				if number then
					who.LastEventNum = who.LastEventNum or {}
					who.LastEventNum[who.NextEventNum]=100*number/UnitHealthMax(who.unit)
				elseif who.LastEventNum then
					who.LastEventNum[who.NextEventNum]=nil
				end
			else
				who.LastEventHealth = who.LastEventHealth or {}
				who.LastEventHealth[who.NextEventNum]=UnitHealth(who.unit).."%"
				if who.LastEventNum then
					who.LastEventNum[who.NextEventNum]=nil
				end
			end
			who.LastEventHealthNum = who.LastEventHealthNum or {}
			who.LastEventHealthNum[who.NextEventNum]=100*UnitHealth(who.unit)/UnitHealthMax(who.unit)
		else
			who.LastEventHealth = who.LastEventHealth or {}
			who.LastEventHealthNum = who.LastEventHealthNum or {}
			who.LastEventHealth[who.NextEventNum]="???"
			who.LastEventHealthNum[who.NextEventNum]=0
			if who.LastEventNum then
				who.LastEventNum[who.NextEventNum]=nil
			end
		end		
		
		who.NextEventNum=who.NextEventNum+1

		if who.NextEventNum>Recount.db.profile.MessagesTracked then
			who.NextEventNum=who.NextEventNum-Recount.db.profile.MessagesTracked
		end
	end
end

--Functions for adding data 

function Recount:AddAmount(who,datatype,amount)
	if not who then return end
	if not Recount.db.profile.Filters.Data[who.type] or not Recount.db.profile.GlobalDataCollect or not Recount.CurrentDataCollect then
		return
	end

	Recount.NewData = true -- Inform MainWindow that we got new data stored.

	--We add the data to both overall & current fight data
	who.Fights = who.Fights or {}
	who.Fights.OverallData = who.Fights.OverallData or {}
	who.Fights.OverallData[datatype] = who.Fights.OverallData[datatype] or 0
	who.Fights.OverallData[datatype]=who.Fights.OverallData[datatype]+amount
	who.Fights.CurrentFightData = who.Fights.CurrentFightData or {}
	who.Fights.CurrentFightData[datatype] = who.Fights.CurrentFightData[datatype] or 0
	who.Fights.CurrentFightData[datatype]=who.Fights.CurrentFightData[datatype]+amount

	--Now add the time data
--	if who.TimeWindows[datatype] then
	who.TimeWindows = who.TimeWindows or {}
	who.TimeWindows[datatype] = who.TimeWindows[datatype] or {}
	who.TimeWindows[datatype][Recount.TimeStep] = who.TimeWindows[datatype][Recount.TimeStep] or 0
	who.TimeWindows[datatype][Recount.TimeStep]=who.TimeWindows[datatype][Recount.TimeStep]+amount

	who.TimeLast = who.TimeLast or {}
	who.TimeLast[datatype]=Recount.CurTime
	who.TimeLast["OVERALL"]=Recount.CurTime
--	end
end

--Meant for like elemental data and this type isn't expected to be initialized 
function Recount:AddAmount2(who,datatype,secondary,amount)
	if not who then return end
	if not Recount.db.profile.Filters.Data[who.type]  or not Recount.db.profile.GlobalDataCollect or not Recount.CurrentDataCollect then
		return
	end
	if not secondary then
		Recount:DPrint("Empty secondary: "..datatype)
		return
	end
	
	--We add the data to both overall & current fight data
	who.Fights = who.Fights or {}
	who.Fights.OverallData = who.Fights.OverallData or {}
	who.Fights.OverallData[datatype] = who.Fights.OverallData[datatype] or {}
	who.Fights.OverallData[datatype][secondary]=(who.Fights.OverallData[datatype][secondary] or 0)+amount
	who.Fights.CurrentFightData = who.Fights.CurrentFightData or {}
	who.Fights.CurrentFightData[datatype] = who.Fights.CurrentFightData[datatype] or {}
	who.Fights.CurrentFightData[datatype][secondary]=(who.Fights.CurrentFightData[datatype][secondary] or 0)+amount
end

--Two Different Types of table functions
--First type tracks min/max & count while the other only counts the total sum in the count column
local CurTable
local Details
function Recount:AddTableDataStats(who,datatype,secondary,detailtype,amount)
	if not who then return end
	if not Recount.db.profile.Filters.Data[who.type] or not Recount.db.profile.GlobalDataCollect or not Recount.CurrentDataCollect then
		return
	end

	who.Fights = who.Fights or {}
	who.Fights.OverallData = who.Fights.OverallData or {}
	who.Fights.OverallData[datatype] = who.Fights.OverallData[datatype] or {}
	CurTable=who.Fights.OverallData[datatype][secondary]

	if type(CurTable)~="table" then
		who.Fights.OverallData[datatype][secondary]=Recount:GetTable()
		CurTable=who.Fights.OverallData[datatype][secondary]
		CurTable.count=0
		CurTable.amount=0
		CurTable.Details=Recount:GetTable()
	end	

	CurTable.count=CurTable.count+1
	CurTable.amount=CurTable.amount+amount

	if type(CurTable.Details[detailtype])~="table" then
		CurTable.Details[detailtype]=Recount:GetTable()
		CurTable.Details[detailtype].count=0
		CurTable.Details[detailtype].amount=0
	end
	Details=CurTable.Details[detailtype]

	Details.count=Details.count+1
	Details.amount=Details.amount+amount

	if Details.max then
		if amount>Details.max then
			Details.max=amount
		elseif amount<Details.min then
			Details.min=amount
		end
	else--If no max has been set time to initialize
		Details.max=amount
		Details.min=amount
	end
	
	--[[if type(who.Fights.CurrentFightData[datatype])~="table" then
		who.Fights.CurrentFightData[datatype]=Recount:GetTable()
	end]]
	who.Fights.CurrentFightData = who.Fights.CurrentFightData or {}
	who.Fights.CurrentFightData[datatype] = who.Fights.CurrentFightData[datatype] or {}
	CurTable=who.Fights.CurrentFightData[datatype][secondary]
	--Now for the current fight data
	if type(CurTable)~="table" then
		who.Fights.CurrentFightData[datatype][secondary]=Recount:GetTable()
		CurTable=who.Fights.CurrentFightData[datatype][secondary]
		CurTable.count=0
		CurTable.amount=0
		CurTable.Details=Recount:GetTable()
	end

	

	CurTable.count=CurTable.count+1
	CurTable.amount=CurTable.amount+amount

	if type(CurTable.Details[detailtype])~="table" then
		CurTable.Details[detailtype]=Recount:GetTable()
		CurTable.Details[detailtype].count=0
		CurTable.Details[detailtype].amount=0
	end
	Details=CurTable.Details[detailtype]

	Details.count=Details.count+1
	Details.amount=Details.amount+amount

	if Details.max then
		if amount>Details.max then
			Details.max=amount
		elseif amount<Details.min then
			Details.min=amount
		end
	else--If no max has been set time to initialize
		Details.max=amount
		Details.min=amount
	end
end
local first=false
function Recount:CorrectTableData(who,datatype,secondary,amount)
	if not who then return end
	if not Recount.db.profile.Filters.Data[who.type]   or Recount.db.profile.GlobalDataCollect == false  or not Recount.CurrentDataCollect then
		return
	end

	who.Fights = who.Fights or {}
	who.Fights.OverallData = who.Fights.OverallData or {}
	who.Fights.OverallData[datatype] = who.Fights.OverallData[datatype] or {}
	CurTable=who.Fights.OverallData[datatype][secondary]

	if type(CurTable)~="table" then
		who.Fights.OverallData[datatype][secondary]=Recount:GetTable()
		CurTable=who.Fights.OverallData[datatype][secondary]
		CurTable.count=0
		CurTable.amount=0
		CurTable.Details=Recount:GetTable()
	end	
--[[	if not CurTable.count and not first then
		Recount:Print(datatype,secondary,amount)
		Recount:Print(debugstack())
	end]]
	if CurTable.count then
		CurTable.count=CurTable.count-1
	end
	CurTable.amount=CurTable.amount-amount

	who.Fights.CurrentFightData = who.Fights.CurrentFightData or {}
	who.Fights.CurrentFightData[datatype] = who.Fights.CurrentFightData[datatype] or {}
	CurTable=who.Fights.CurrentFightData[datatype][secondary]
	--Now for the current fight data
	if type(CurTable)~="table" then
		who.Fights.CurrentFightData[datatype][secondary]=Recount:GetTable()
		CurTable=who.Fights.CurrentFightData[datatype][secondary]
		CurTable.count=0
		CurTable.amount=0
		CurTable.Details=Recount:GetTable()
	end

	
	if CurTable.count then
		CurTable.count=CurTable.count-1
	end
	CurTable.amount=CurTable.amount-amount
end



function Recount:AddTableDataStatsNoAmount(who,datatype,secondary,detailtype)
	if not who then return end
	if not Recount.db.profile.Filters.Data[who.type] or not Recount.db.profile.GlobalDataCollect or not Recount.CurrentDataCollect then
		return
	end

	who.Fights = who.Fights or {}
	who.Fights.OverallData = who.Fights.OverallData or {}
	who.Fights.OverallData[datatype] = who.Fights.OverallData[datatype] or {}
	CurTable=who.Fights.OverallData[datatype][secondary]

	if type(CurTable)~="table" then
		who.Fights.OverallData[datatype][secondary]=Recount:GetTable()
		CurTable=who.Fights.OverallData[datatype][secondary]
		CurTable.count=0
		CurTable.amount=0
		CurTable.Details=Recount:GetTable()
	end


	
	CurTable.count=CurTable.count+1

	if type(CurTable.Details[detailtype])~="table" then
		CurTable.Details[detailtype]=Recount:GetTable()
		CurTable.Details[detailtype].count=0
		CurTable.Details[detailtype].amount=0
	end
	Details=CurTable.Details[detailtype]

	Details.count=Details.count+1

	--Now for the current fight data
	--[[if type(who.Fights.CurrentFightData[datatype])~="table" then
		who.Fights.CurrentFightData[datatype]=Recount:GetTable()
	end]]
	who.Fights.CurrentFightData = who.Fights.CurrentFightData or {}
	who.Fights.CurrentFightData[datatype] = who.Fights.CurrentFightData[datatype] or {}
	CurTable=who.Fights.CurrentFightData[datatype][secondary]
	if type(CurTable)~="table" then
		who.Fights.CurrentFightData[datatype][secondary]=Recount:GetTable()
		CurTable=who.Fights.CurrentFightData[datatype][secondary]
		CurTable.count=0
		CurTable.amount=0
		CurTable.Details=Recount:GetTable()
	end



	CurTable.count=CurTable.count+1

	if type(CurTable.Details[detailtype])~="table" then
		CurTable.Details[detailtype]=Recount:GetTable()
		CurTable.Details[detailtype].count=0
		CurTable.Details[detailtype].amount=0
	end
	Details=CurTable.Details[detailtype]

	Details.count=Details.count+1
end

function Recount:AddTableDataSum(who,datatype,secondary,detailtype,amount)
	if not who then return end
	if (not Recount.db.profile.Filters.Data[who.type]) or not Recount.db.profile.GlobalDataCollect  or not Recount.CurrentDataCollect then
		--Have to make sure this won't be used by something that needs to have data recorded for it
		
		if dbCombatants[secondary] then
			if not Recount.db.profile.Filters.Data[dbCombatants[secondary].type] or Recount.db.profile.GlobalDataCollect == false then
				return
			end
		else		
			return
		end
	end

	who.Fights = who.Fights or {}
	who.Fights.OverallData = who.Fights.OverallData or {}
	who.Fights.OverallData[datatype] = who.Fights.OverallData[datatype] or {}
	
	CurTable=who.Fights.OverallData[datatype][secondary]
	if type(CurTable)~="table" then
		who.Fights.OverallData[datatype][secondary]=Recount:GetTable()
		CurTable=who.Fights.OverallData[datatype][secondary]
		CurTable.amount=0
		CurTable.Details=Recount:GetTable()
	end

	CurTable.amount=(CurTable.amount or 0)+amount

	if detailtype == nil then
		Recount:DPrint("DEBUG at: ".. (who or "nil").." "..(datatype or "nil").." ".. (secondary or "nil"))
	end

	if type(CurTable.Details[detailtype])~="table" then
		CurTable.Details[detailtype]=Recount:GetTable()
		CurTable.Details[detailtype].count=0
	end

	Details=CurTable.Details[detailtype]
	Details.count=Details.count+amount

	--Now for the current fight data
	--[[if type(who.Fights.CurrentFightData[datatype])~="table" then
		who.Fights.CurrentFightData[datatype]=Recount:GetTable()
	end]]
	who.Fights.CurrentFightData = who.Fights.CurrentFightData or {}
	who.Fights.CurrentFightData[datatype] = who.Fights.CurrentFightData[datatype] or {}
	CurTable=who.Fights.CurrentFightData[datatype][secondary]

	if type(CurTable)~="table" then
		who.Fights.CurrentFightData[datatype][secondary]=Recount:GetTable()
		CurTable=who.Fights.CurrentFightData[datatype][secondary]
		CurTable.amount=0
		CurTable.Details=Recount:GetTable()
	end

	CurTable.amount=(CurTable.amount or 0)+amount

	if type(CurTable.Details[detailtype])~="table" then
		CurTable.Details[detailtype]=Recount:GetTable()
		CurTable.Details[detailtype].count=0
	end

	Details=CurTable.Details[detailtype]

	Details.count=Details.count+amount
end

-- Elsia: Borrowed shamelessly from Threat-2.0
function Recount:NPCID(guid)
	return tonumber(guid:sub(-12,-7),16)
end

function Recount:DetectPet(name, nGUID, nFlags)
	local ownerID
	local owner
	local petName
	
	petName, owner = name:match("(.-) <(.*)>")
	
	if not petName then
		petName = name
	else
		name = petName
	end
	
	if nFlags and bit_band(nFlags, COMBATLOG_OBJECT_TYPE_PET+COMBATLOG_OBJECT_TYPE_GUARDIAN)~=0 then
		if bit_band(nFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) ~=0 then
			name = name.." <"..Recount.PlayerName..">"
			owner = Recount.PlayerName -- Elsia: Fix up so that owner properly gets set
			ownerID = Recount.PlayerGUID
--			if bit_band(nFlags, COMBATLOG_OBJECT_TYPE_PET) ~=0 then
--				Recount.PlayerPetGUID = nGUID
--			else -- Guardians
--				Recount.LatestGuardian = Recount.LatestGuardian + 1
--				Recount.GuardiansGUIDs[Recount.LatestGuardian]=nGUID
--				if Recount.LatestGuardian > 20 then -- Elsia: Max guardians set to 20 for now
--					Recount.LatestGuardian = 0
--				end
--			end
		elseif bit_band(nFlags, COMBATLOG_OBJECT_AFFILIATION_PARTY+COMBATLOG_OBJECT_AFFILIATION_RAID)~=0 then
--			if nFlags and bit_band(nFlags, COMBATLOG_OBJECT_TYPE_PET)~=0 then
--			elseif nFlags and bit_band(nFlags, COMBATLOG_OBJECT_TYPE_GUARDIAN)~=0 then
				owner = Recount:GetGuardianOwnerByGUID(nGUID)
				ownerID = owner and dbCombatants[owner] and dbCombatants[owner].GUID
				if not owner then
					owner, ownerID = Recount:FindOwnerPetFromGUID(name,nGUID)
			
					if not owner then
					   Recount:DPrint("NoOwner: "..name.." "..(nGUID or "nil"))
					end
				end
				if owner then name = name.." <"..owner..">" end
	--			Recount:DPrint("Party guardian: "..name.." "..(nGUID or "nil").." "..(owner or "nil").." "..(ownerID or "nil"))
--			end
		else
			petName = Recount:GetGuardianOwnerByGUID(nameGUID)
			if petName then
				petName, owner = petName:match("(.-) <(.*)>")
			end
		end
	end
	return name, owner, ownerID
end

function Recount:BossFightWho(srcFlags,dstFlags,victimData, victim)
	if Recount:InGroup(srcFlags) and not Recount:IsFriend(dstFlags) then
		if not victimData.level then
			--Recount:Print(victimData.Name.." lacks level, please report") -- This happens for freezing traps intriguingly enough
			victimData.level = 1
		end
		if (victimData.level==-1) or ((Recount.FightingLevel~=-1) and (victimData.level>Recount.FightingLevel)) then
			Recount.FightingWho=victim
			Recount.FightingLevel=victimData.level
		end
	end
end

function Recount:BossFightWhoFromFlags(srcFlags, dstFlags, victim, victimGUID)
	if Recount:InGroup(srcFlags) and not Recount:IsFriend(dstFlags) then
	   if Recount.IsBoss(victimGUID) then 
	      Recount.FightingWho = victim
	      Recount.FightingLevel = -1
	   elseif Recount.FightingWho=="" then
	      Recount.FightingWho = victim
	      Recount.FightingLevel = 1
	   end
	end
end

local dottime -- Duration of a dot
local DPass -- nil or damage to record
function Recount:AddDamageData(source, victim, ability, element, hittype, damage, resist, srcGUID, srcFlags, dstGUID, dstFlags, spellId, blocked, absorbed, isDot)

	--Is this friendly fire?
	local FriendlyFire = Recount:IsFriendlyFire(srcFlags,dstFlags)
	
	--Before any further processing need to check if we are going to be placed in combat or in combat 
	if not Recount.InCombat and Recount.db.profile.RecordCombatOnly then
		if (not FriendlyFire) and (Recount:InGroup(srcFlags) or Recount:InGroup(dstFlags)) then
			Recount:PutInCombat()
		end
	end

	if spellId == 70890 then -- Elsia: This isn't elegant but alas... this disambiguates Scourge Strike by attaching the spell-school as label if it's the shadow portion. Blizz really should not have given both parts the exact same spell name.
		if not element then
			element = "Shadow" -- This is a band-aid, this should never be necessary but evidentally some scourge strike events arrive with broken spell school fields!
		end
		ability = ability.." ("..element..")"
	end
	
	-- Name and ID of pet owners
	local sourceowner
	local sourceownerID
	local victimowner
	local victimownerID

	source, sourceowner, sourceownerID = Recount:DetectPet(source, srcGUID, srcFlags)
	victim, victimowner, victimownerID = Recount:DetectPet(victim, dstGUID, dstFlags)

	-- Extra attack handling
	if extraattacks and extraattacks[source] and not extraattacks[source].ability then
		Recount:DPrint("Proc ability: "..ability)
		extraattacks[source].ability = ability
	elseif extraattacks and extraattacks[source] and extraattacks[source].ability and ability==L["Melee"] then
		if extraattacks[source].proctime < GetTime()-5 then -- This is an outdated proc of which we never saw damage contributions. Timeout at 5 seconds
			extraattacks[source] = nil
		else
			Recount:DPrint("Damage proc: "..ability.." "..extraattacks[source].spellName.." "..(damage or "0"))
			ability = extraattacks[source].ability .. " ("..extraattacks[source].spellName..")"
			extraattacks[source].amount = extraattacks[source].amount - 1
			if extraattacks[source].amount == 0 then
				extraattacks[source] = nil
			end
		end
	end

	-- Death log entry text
	Recount.cleventtext = source.." "..ability.." "..victim.." "..hittype
	if damage then
		Recount.cleventtext = Recount.cleventtext.." -"..damage
	end
	if resist and resist > 0 then
		Recount.cleventtext = Recount.cleventtext .." ("..resist..L[" resisted"]..")"
	end
	if absorbed and absorbed > 0 then
		Recount.cleventtext = Recount.cleventtext .." ("..absorbed.." "..L["Absorbed"]..")"
	end
	if element then
		Recount.cleventtext = Recount.cleventtext.." ("..element..")"
	end

	if srcRetention then
		if not dbCombatants[source] then
			Recount:AddCombatant(source,sourceowner,srcGUID,srcFlags, sourceownerID)
		end
	

		-- Reference to combatant data
		local sourceData=dbCombatants[source]

		if sourceData then
		
			Recount:SetActive(sourceData)
			--Need to add events for potential deaths
			Recount:AddCurrentEvent(sourceData, "DAMAGE", false, nil,Recount.cleventtext)

			--Fight tracking purposes to speed up leaving combat
			sourceData.LastFightIn=Recount.db2.FightNum
			--Melee is always considered Melee since its handled differently from specials keep it seperate
			if ability==L["Melee"] then
				element="Melee"
			end
			--Need to set the source as active
			Recount:AddTimeEvent(sourceData,victim,ability,false)
			--Stats for keeping track of DOT Uptime
			if isDot or hittype=="Tick" then
				--3 is default time since most abilities have 3 seconds inbetween ticks

				dottime = DotTickTimeId[spellId] or 3
				Recount:AddAmount(sourceData,"DOT_Time",dottime)
				Recount:AddTableDataSum(sourceData,"DOTs",ability,victim,dottime)
			end
			if damage then
				--Record the element type
--			sourceData.AbilityType = sourceData.AbilityType or {}
--			sourceData.AbilityType[ability]=element
					
				--Alright now if there was a friendly damage done or not decides where this data goes for the source
				if not FriendlyFire then
					Recount:AddOwnerPetLazySyncAmount(sourceData,"Damage", damage)
					--Recount:AddSyncAmount(sourceData, "Damage", damage)
					Recount:AddAmount(sourceData,"Damage",damage)	
					local newhittype = hittype
					if blocked then
						newhittype = hittype .. " ("..L["Blocked"]..")"
					end
					Recount:AddTableDataStats(sourceData,"Attacks",ability,newhittype,damage)
					Recount:AddAmount2(sourceData,"ElementDone",element,damage)
				else
					--Recount:AddOwnerPetLazySyncAmount(sourceData,"FDamage", damage) -- We don't currently sync friendly damage
					--Recount:AddSyncAmount(sourceData, "FDamage", damage)
					Recount:AddAmount(sourceData,"FDamage",damage)
					Recount:AddTableDataStats(sourceData,"FAttacks",ability,hittype,damage)
					Recount:AddTableDataSum(sourceData,"FDamagedWho",victim,ability,damage)
					-- Fix to track friendly fire contributions in death log.
					if dstRetention then
						if not dbCombatants[victim] then
							Recount:AddCombatant(victim,victimowner,dstGUID,dstFlags, victimownerID)
						end

						-- Reference to combatant data
						local victimData=dbCombatants[victim]

						if victimData then
							--Need to add events for potential deaths
							DPass=damage
							if DPass==0 then
								DPass=nil
							end
							Recount:AddCurrentEvent(victimData, "DAMAGE", true, DPass, Recount.cleventtext)
						end
					end
					return
				end
					
				Recount:AddTableDataSum(sourceData,"DamagedWho",victim,ability,damage)	
			else
				Recount:AddTableDataStatsNoAmount(sourceData,"Attacks",ability,hittype)
			end

			-- Elsia: Moved this out because we want this recorded regardless whether it was friendly damage or not
			-- Elsia: Also removed bug, victims resist/block/absorb!
			if resist then
				Recount:AddAmount2(sourceData,"ElementDoneResist",element,resist)
			end

			if blocked then
				Recount:AddAmount2(sourceData,"ElementDoneBlock",element,blocked)
			end
				
			if absorbed then
				Recount:AddAmount2(sourceData,"ElementDoneAbsorb",element,absorbed)
			end

			--Needs to be here for tracking so we don't add Friendly Damage as well
			if Tracking["DAMAGE"] then
				if Tracking["DAMAGE"][source] then
					for _, v in pairs(Tracking["DAMAGE"][source]) do
						v.func(v.pass,damage)
					end
				end

				if Recount:InGroup(srcFlags) and Tracking["DAMAGE"]["!RAID"] then
					for _, v in pairs(Tracking["DAMAGE"]["!RAID"]) do
						v.func(v.pass,damage)
					end
				end
			end
		

			Recount:BossFightWho(dstFlags,srcFlags,sourceData,source)

			if element then
				Recount:AddTableDataSum(sourceData,"ElementHitsDone",element,hittype,1)
			end	
		     end
		  else
		     Recount:BossFightWhoFromFlags(dstFlags,srcFlags,source,srcGUID)
	end
		
	if dstRetention then
		if not dbCombatants[victim] then
			Recount:AddCombatant(victim,victimowner,dstGUID,dstFlags, victimownerID)
		end

		-- Reference to combatant data
		local victimData=dbCombatants[victim]

		if victimData then
			
			Recount:SetActive(victimData)
			--Need to add events for potential deaths
			DPass=damage
			if DPass==0 then
				DPass=nil
			end
			Recount:AddCurrentEvent(victimData, "DAMAGE", true, DPass, Recount.cleventtext)

			--Fight tracking purposes to speed up leaving combat
			victimData.LastFightIn=Recount.db2.FightNum
			--Melee is always considered Melee since its handled differently from specials keep it seperate
			if ability==L["Melee"] then
				element="Melee"
			end

			if damage then
				--Victim always cares
				Recount:AddAmount(victimData,"DamageTaken",damage)		
				Recount:AddTableDataSum(victimData,"WhoDamaged",source,ability,damage)	

				--Sync Data
				Recount:AddOwnerPetLazySyncAmount(victimData,"DamageTaken", damage)
				--Recount:AddSyncAmount(victimData, "DamageTaken", damage)

				Recount:AddAmount2(victimData,"ElementTaken",element,damage)
				
				--For identifying who killed when no message is triggered
				victimData.LastAttackedBy=source
				victimData.LastDamageTaken=damage
				victimData.LastDamageAbility=ability
			end

			if resist then -- Elsia: Fixed bug, source has to "take" resists, blocks and absorbs.
				if hittype=="Crit" then
					resist=resist*2
				end
				Recount:AddAmount2(victimData,"ElementTakenResist",element,resist)
				if resist<(damage/2.5) then
					--25% Resist
					Recount:AddTableDataStats(victimData,"PartialResist",ability,"25%"..L["Resist"],resist)
				elseif resist<(1.25*damage) then
					--50% Resist
					Recount:AddTableDataStats(victimData,"PartialResist",ability,"50%"..L["Resist"],resist)
				else
					--75% Resist
					Recount:AddTableDataStats(victimData,"PartialResist",ability,"75%"..L["Resist"],resist)
				end
			else
				Recount:AddTableDataStats(victimData,"PartialResist",ability,L["No Resist"],0)
			end
			
			if blocked or hittype=="Block" then
				Recount:AddAmount2(victimData,"ElementTakenBlock",element,blocked)
				if blocked then
					Recount:AddTableDataStats(victimData,"PartialBlock",ability,L["Blocked"],blocked)
				else
					Recount:AddTableDataStats(victimData,"PartialBlock",ability,L["No Block"],0)
				end
			end
			
			if absorbed then
				Recount:AddAmount2(victimData,"ElementTakenAbsorb",element,absorbed)
				Recount:AddTableDataStats(victimData,"PartialAbsorb",ability,L["Absorbed"],absorbed)
			else
				Recount:AddTableDataStats(victimData,"PartialAbsorb",ability,L["No Absorb"],0)
			end
			-- Elsia: Moved this out because we want this recorded regardless whether it was friendly damage or not
			-- Elsia: Also removed bug, victims resist/block/absorb!

			--Tracking for passing data to other functions	
			if Tracking["DAMAGETAKEN"] then 
				if Tracking["DAMAGETAKEN"][victim] then
					for _, v in pairs(Tracking["DAMAGETAKEN"][victim]) do
						v.func(v.pass,damage)
					end
				end

				if Recount:InGroup(dstFlags) and Tracking["DAMAGETAKEN"]["!RAID"] then
					for _, v in pairs(Tracking["DAMAGETAKEN"]["!RAID"]) do
						v.func(v.pass,damage)
					end
				end
			end

			Recount:BossFightWho(srcFlags,dstFlags,victimData, victim)
			
			if element then
				Recount:AddTableDataSum(victimData,"ElementHitsTaken",element,hittype,1)
			end	
		end
	else
		     Recount:BossFightWhoFromFlags(srcFlags,dstFlags,victim,dstGUID)
	end

end

function Recount:AddHealData(source, victim, ability, healtype, amount, overheal,srcGUID,srcFlags,dstGUID,dstFlags,spellId,isHot)
   --First lets figure if there was overhealing
   --Get the tables	
   
   -- Name and ID of pet owners
   local sourceowner
   local sourceownerID
   local victimowner
   local victimownerID
   
   source, sourceowner, sourceownerID = Recount:DetectPet(source, srcGUID, srcFlags)
   
   victim, victimowner, victimownerID = Recount:DetectPet(victim, dstGUID, dstFlags)
   
   Recount.cleventtext = source.." "..ability.." "..victim
   if healtype then
      Recount.cleventtext = Recount.cleventtext.." "..healtype
   end
   if amount then
      Recount.cleventtext = Recount.cleventtext.." +"..amount
   end
   
   if overheal and overheal ~= 0 then 
      Recount.cleventtext = Recount.cleventtext .." ("..overheal..L[" overheal"]..")"
   end

   local sourceData

   if srcRetention then
      if not dbCombatants[source] then
	 Recount:AddCombatant(source,sourceowner,srcGUID,srcFlags,sourceownerID)
      end
      
      sourceData=dbCombatants[source]
      if sourceData then
	 Recount:SetActive(sourceData)
	 
	 --Need to add events for potential deaths
	 if source~=victim then
	    Recount:AddCurrentEvent(sourceData, "HEAL", false, nil,Recount.cleventtext)
	 end
	 
      end
   end
   
   local victimData
   if dstRetention then
      if not dbCombatants[victim] then
	 Recount:AddCombatant(victim,victimowner,dstGUID,dstFlags, victimownerID) -- Elsia: Bug, owner was missing here
      end
      victimData=dbCombatants[victim]
      if victimData then
	 
	 Recount:SetActive(victimData)
	 --Need to add events for potential deaths
	 Recount:AddCurrentEvent(victimData, "HEAL", true, amount,Recount.cleventtext)
      end

      --Before any further processing need to check if we are in combat 
      if not Recount.InCombat and Recount.db.profile.RecordCombatOnly then
	 return
      end
   end
      --Fight tracking purposes to speed up leaving combat
      
      --if not sourceData then Recount:DPrint("Source-less heal: "..(ability or "nil")..(source or "nil").." "..(victim or "nil").." Please report!") end

	if Recount:IsFriend(dstFlags) then -- Only record heals of friends as heals.
      
   if overheal == nil then
      overheal=0
   elseif  overheal > 0 then
      amount = amount - overheal
   end
      
   if srcRetention and sourceData then
	 
      sourceData.LastFightIn=Recount.db2.FightNum
      
      Recount:AddOwnerPetLazySyncAmount(sourceData,"Healing", amount)
      Recount:AddOwnerPetLazySyncAmount(sourceData,"Overhealing", overheal)
      
      
      --Tracking for passing data to other functions
      if Tracking["HEALING"] then
	 if Tracking["HEALING"][source] then
	    for _, v in pairs(Tracking["HEALING"][source]) do
	       v.func(v.pass,amount)
	    end
	 end
	 
	 if sourceData and Recount:InGroup(srcFlags) and Tracking["HEALING"]["!RAID"] then
	    for _, v in pairs(Tracking["HEALING"]["!RAID"]) do
	       v.func(v.pass,amount)
	    end
	 end
      end
	 
      --Need to set the source as active
	 if amount > 0 then -- Restore legacy behavior, i.e. pure overheals are not counted.
		Recount:AddTimeEvent(sourceData,victim,ability,true)
	 end
	 
      --Stats for keeping track of HOT Uptime
      if isHot or healtype=="Tick" then
	 --3 is default time since most abilities have 3 seconds inbetween ticks
	 local hottime=HotTickTimeId[spellId] or 3
	 Recount:AddAmount(sourceData,"HOT_Time",hottime)
	 Recount:AddTableDataSum(sourceData,"HOTs",ability,victim,hottime)
      end
	 
      --No reason to add information if everything was overhealing
      if amount>0 then
	 Recount:AddAmount(sourceData,"Healing",amount)
	 Recount:AddTableDataStats(sourceData,"Heals",ability,healtype,amount)
	 Recount:AddTableDataSum(sourceData,"HealedWho",victim,ability,amount)
      end
	 
      --Now if there was overhealing lets add that data in
      if overheal>0 then
	 Recount:AddAmount(sourceData,"Overhealing",overheal)
	 Recount:AddTableDataStats(sourceData,"OverHeals",ability,healtype,overheal)
      end
   end
   end

 
   if dstRetention and victimData then
	 
      victimData.LastFightIn=Recount.db2.FightNum
	 
--[[	 local VictimUnit=victimData.unit
	 
	 if (not VictimUnit or victim~=UnitName(VictimUnit)) and (victimData.UnitLockout>Recount.UnitLockout) then
	    victimData.UnitLockout=Recount.CurTime
	    VictimUnit=Recount:FindUnit(victim)
	    victimData.unit=VictimUnit
	 end
]]	 
      Recount:AddOwnerPetLazySyncAmount(victimData,"HealingTaken", amount)
	 
      if Tracking["HEALINGTAKEN"] then
	 if Tracking["HEALINGTAKEN"][victim] then
	    for _, v in pairs(Tracking["HEALINGTAKEN"][victim]) do
	       v.func(v.pass,amount)
	    end
	 end
	    
	 if Recount:InGroup(dstFlags) and Tracking["HEALINGTAKEN"]["!RAID"] then
	    for _, v in pairs(Tracking["HEALINGTAKEN"]["!RAID"]) do
	       v.func(v.pass,amount)
	    end
	 end
      end
	 
      --No reason to add information if everything was overhealing
      if amount>0 then
	 Recount:AddAmount(victimData,"HealingTaken",amount)
	 Recount:AddTableDataSum(victimData,"WhoHealed",source,ability,amount)
      end
   end
end

function Recount:HandleDoubleDeath(source, victim, skill,srcGUID,srcFlags,dstGUID,dstFlags,spellId)

   if dstRetention then
      
      -- Name and ID of pet owners
      local victimowner
      local victimownerID

      victim, victimowner, victimownerID = Recount:DetectPet(victim, dstGUID, dstFlags)
      
      --Get the tables	
      if not dbCombatants[victim] then
	 Recount:AddCombatant(victim, victimowner,dstGUID,dstFlags, victimownerID) -- Elsia: Bug owner missing
      end
      
      local victimData=dbCombatants[victim]
      if not victimData then return end
      
      victimData.DoubleDeathSpellID = spellId
      victimData.DoubleDeathSpellName = skill
      victimData.DoubleDeathTime = GetTime()
   end
end

local deathargs={}
local timeofdeath
local doubleDeathDelay
function Recount:AddDeathData(source, victim, skill,srcGUID,srcFlags,dstGUID,dstFlags,spellId)
	--Before any further processing need to check if we are in combat 
	
	--Recount:DPrint("Add Death: "..victim)
	
--[[	if not Recount.InCombat and Recount.db.profile.RecordCombatOnly then
		--Recount:Print("Death out of combat, not recorded")
		return
	end]] -- Record all deaths.

        -- Name and ID of pet owners
        local sourceowner
        local sourceownerID
        local victimowner
        local victimownerID

	if source and type(source) == "string" then -- Elsia: Fix bug when death doesn't have a killer
	
		source, sourceowner, sourceownerID = Recount:DetectPet(source, srcGUID, srcFlags)

	end
		
	victim, victimowner, victimownerID = Recount:DetectPet(victim, dstGUID, dstFlags)
	
	if srcRetention then
	   
	   --Need to add events for potential deaths	
	   if source and source~=victim then -- Elsia: May be worth removing the source~=victim check
	      if not dbCombatants[source] then
		 Recount:AddCombatant(source,sourceowner,srcGUID,srcFlags, sourceownerID)
	      end
	      local sourceData=dbCombatants[source]
	      if sourceData then
		 sourceData.LastFightIn=Recount.db2.FightNum
		 Recount:AddCurrentEvent(sourceData, "MISC", false)
	      end
	   end	
	end

	if dstRetention then

	   --Get the tables	
	   if not dbCombatants[victim] then
	      Recount:AddCombatant(victim, victimowner,dstGUID,dstFlags, victimownerID) -- Elsia: Bug owner missing
	   end

	   local victimData=dbCombatants[victim]
	   
	   if victimData then

	      -- This is fix to prevent feign death to show as real deaths.
	      if Recount:InGroup(dstFlags) and UnitIsFeignDeath(victim) then
		 --Recount:Print("Yikes: Feign Death reported as real, please report!")
		 return -- No need to record this!
	      end
	
	      --Fight tracking purposes to speed up leaving combat
	      victimData.LastFightIn=Recount.db2.FightNum
	     
	      Recount.cleventtext = victim..L[" dies."]
	
	      -- Check for Spirit of Redemption or Ghoul
	      timeofdeath = GetTime()
	      doubleDeathDelay = victimData.DoubleDeathTime and timeofdeath-victimData.DoubleDeathTime or 10
	      
	      if doubleDeathDelay < 2 then
		 Recount.cleventtext = Recount.cleventtext .. " ("..victimData.DoubleDeathSpellName..")"
		 
	      end

	      Recount:AddCurrentEvent(victimData, "MISC", true,nil,Recount.cleventtext)
	      --This saves who/what killed the victim
	      if source then
		 victimData.LastKilledBy=source
		 victimData.LastKilledAt=timeofdeath
	      elseif skill then
		 victimData.LastKilledBy=skill
		 victimData.LastKilledAt=timeofdeath
	      elseif not victimData.DoubleDeathSpellID or doubleDeathDelay >= 2 then -- We don't count spirits and ghouls
		 --The case where we actually add a deathcount
		 Recount:AddAmount(victimData,"DeathCount",1)
	      end
	      
	      -- Removed cached double event if it existed.
	      victimData.DoubleDeathSpellID = nil
	      victimData.DoubleDeathSpellName = nil
	      victimData.DoubleDeathTime = nil
	      
	      --We delay the saving of the event logs just in case more messages come later
	      if Recount.db.profile.Filters.TrackDeaths[victimData.type] then
		 --Recount:ScheduleTimer(Recount.HandleDeath,2,Recount,victim,GetTime(),dstGUID,dstFlags)
		 deathargs={} -- Elsia: Make sure we create new ones in case of overlapping deaths!
		 deathargs[1]=victim
		 deathargs[2]=timeofdeath
		 deathargs[3]=dstGUID
		 deathargs[4]=dstFlags
		 Recount:ScheduleTimer("HandleDeath",2,deathargs)
		 --Recount:HandleDeath(deathargs)
	      end
	   end
	end
end

function Recount:HandleDeath(arg)

	local victim,DeathTime,dstGUID,dstFlags = unpack(arg)
	
--	Recount:DPrint("death: "..victim)
		
	if not dbCombatants[victim] then
		return
	end

	local who=dbCombatants[victim]

	
	local num=Recount.db.profile.MessagesTracked
	local DeathLog=Recount:GetTable()

	DeathLog.DeathAt=Recount.CurTime
	DeathLog.Messages=Recount:GetTable()
	DeathLog.MessageTimes=Recount:GetTable()
	DeathLog.MessageType=Recount:GetTable()
	DeathLog.MessageIncoming=Recount:GetTable()
	DeathLog.Health=Recount:GetTable()
	DeathLog.HealthNum=Recount:GetTable()
	DeathLog.EventNum=Recount:GetTable()

	if who.LastKilledBy and math_abs(who.LastKilledAt-DeathTime)<2 then
		DeathLog.KilledBy=who.LastKilledBy
	elseif who.LastAttackedBy then
		DeathLog.KilledBy=who.LastAttackedBy
		who.LastAttackedBy=nil
	end
			
	local offset
	for i=1,num do
		offset=math_fmod(who.NextEventNum+i+num-2,num)+1
		if who.LastEvents[offset] and (who.LastEventTimes[offset]-DeathTime)>-15 then
			DeathLog.MessageTimes[#DeathLog.MessageTimes+1]=who.LastEventTimes[offset]-DeathTime
			DeathLog.Messages[#DeathLog.Messages+1]=who.LastEvents[offset] or ""
			DeathLog.MessageType[#DeathLog.MessageType+1]=who.LastEventType[offset] or "MISC"
			DeathLog.MessageIncoming[#DeathLog.MessageIncoming+1]=who.LastEventIncoming[offset] or false
			DeathLog.Health[#DeathLog.Health+1]=who.LastEventHealth[offset] or 0
			DeathLog.HealthNum[#DeathLog.HealthNum+1]=who.LastEventHealthNum[offset] or 0
			DeathLog.EventNum[#DeathLog.HealthNum]=who.LastEventNum and who.LastEventNum[offset] or 0
		end
	end

	who.DeathLogs = who.DeathLogs or {}
	tinsert(who.DeathLogs,1,DeathLog)

	if RecountDeathTrack then
		--Recount:DPrint(who.LastDamageTaken)
		RecountDeathTrack:AddDeath(victim, DeathTime-(Recount.InCombatT2 or DeathTime), who.LastDamageTaken , who, who.DeathLogs)--[[who.LastDamageAbility.." "..who.LastDamageTaken]]--
	end

	--who.DeathLogs[#who.DeathLogs+1]=DeathLog
end

function Recount:SpellAuraDispelFailed(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, extraSpellId, extraSpellName, extraSpellSchool)
-- Ignoring this one for now
end

--Potential Tracking
--"DAMAGE"
--"DAMAGETAKEN"
--"HEALING"
--"HEALINGTAKEN"

--function Recount:FPSUpdate(pass)
--end

function Recount:RegisterTracking(id, who, stat, func, pass)
	--Special trackers handled first
	
	local idtoken
	
	if stat=="FPS" then
		idtoken=Recount:ScheduleRepeatingTimer(function() func(pass,GetFramerate()*0.1) end,0.1) -- id.."_TRACKER",
		--return -- Elsia: Removed this so we store tokens
	elseif stat=="LAG" then
		idtoken=Recount:ScheduleRepeatingTimer(function() local _, _, lag = GetNetStats(); func(pass,lag*0.1) end,0.1)
	elseif stat=="UP_TRAFFIC" then
		idtoken=Recount:ScheduleRepeatingTimer(function() local _, up  = GetNetStats(); func(pass,1024*up*0.1) end,0.1)
	elseif stat=="DOWN_TRAFFIC" then
		idtoken=Recount:ScheduleRepeatingTimer(function() local down  = GetNetStats(); func(pass,1024*down*0.1) end,0.1)
	elseif stat=="AVAILABLE_BANDWIDTH" then
		idtoken=Recount:ScheduleRepeatingTimer(function() func(pass,ChatThrottleLib:UpdateAvail()*0.1) end,0.1)
	end
	
	if type(Tracking[stat])~="table" then
		Tracking[stat]=Recount:GetTable()
	end

	if type(Tracking[stat][who])~="table" then
		Tracking[stat][who]=Recount:GetTable()
	end

	if type(Tracking[stat][who][id])~="table" then
		Tracking[stat][who][id]=Recount:GetTable()
	end

	Tracking[stat][who][id].func=func
	Tracking[stat][who][id].pass=pass
	Tracking[stat][who][id].token=idtoken
end	

function Recount:UnregisterTracking(id, who, stat)
	if stat=="FPS" or stat=="LAG" or stat=="UP_TRAFFIC" or stat=="DOWN_TRAFFIC" or stat=="AVAILABLE_BANDWIDTH" then
		Recount:CancelTimer(Tracking[stat][who][id].token) -- Was id.."_TRACKER"
		return
	end

	if type(Tracking[stat])~="table" or type(Tracking[stat][who])~="table"  then
		return
	end

	Tracking[stat][who][id]=nil
end

local oldlocalizer = Recount.LocalizeCombatants
function Recount.LocalizeCombatants()
	dbCombatants = Recount.db2.combatants
	oldlocalizer()
end

