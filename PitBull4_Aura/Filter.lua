-- Filter.lua : Code to handle Filtering the Auras.

if select(6, GetAddOnInfo("PitBull4_" .. (debugstack():match("[o%.][d%.][u%.]les\\(.-)\\") or ""))) ~= "MISSING" then return end

local _G = getfenv(0)
local PitBull4 = _G.PitBull4
local L = PitBull4.L
local PitBull4_Aura = PitBull4:GetModule("Aura")
local wrath_310, wrath_333
do
	local _,wow_build,_,wow_interface = GetBuildInfo()
	wrath_310 = wow_interface >= 30100
	wrath_333 = tonumber(wow_build) >= 11599
end

local _,player_class = UnitClass('player')
local _,player_race = UnitRace('player')

--- Return the DB dictionary for the specified filter.
-- Filter Types should use this to get their db.
-- @param filter the name of the filter
-- @usage local db = PitBull4_Aura:GetFilterDB("myfilter")
-- @return the DB dictionrary for the specified filter or nil
function PitBull4_Aura:GetFilterDB(filter)
	return self.db.profile.global.filters[filter]
end

-- Return true if the talent matching the name of the spell given by
-- spellid has at least one point spent in it or false otherwise
local function scan_for_known_talent(spellid)
	local wanted_name = GetSpellInfo(spellid)
	if not wanted_name then return nil end
	local num_tabs = GetNumTalentTabs()
	for t=1, num_tabs do
		local num_talents = GetNumTalents(t)
		for i=1, num_talents do
			local name_talent, _, _, _, current_rank = GetTalentInfo(t,i)
			if name_talent and (name_talent == wanted_name) then
				if current_rank and (current_rank > 0) then
					return true
				else
					return false
				end
			end
		end
	end
	return false
end

-- Setup the data for who can dispel what types of auras.
local can_dispel = {
	DEATHKNIGHT = {},
	DRUID = {
		Curse = true,
		Poison = true,
	},
	HUNTER = {
		Magic = true,
		Enrage = true,
	},
	MAGE = {
		Curse = true,
	},
	PALADIN = {
		Magic = true,
		Poison = true,
		Disease = true,
	},
	PRIEST = {
		Magic = true,
		Disease = true,
	},
	ROGUE = {
		Enrage = true,
	},
	SHAMAN = {
		Poison = true,
		Disease = true,
		Curse = scan_for_known_talent(51886),
	},
	WARLOCK = {
		Magic = true,
	},
	WARRIOR = {
		Magic = true,
	},
}
can_dispel.player = can_dispel[player_class]
PitBull4_Aura.can_dispel = can_dispel

-- Handle PLAYER_TALENT_CHANGED and CHARACTER_POINTS_CHANGED events.
-- If the points aren't changed due to leveling, rescan the talents
-- for the relevent talents that change what we can dispel.
function PitBull4_Aura:PLAYER_TALENT_UPDATE(event, count, levels)
	-- Not interested in gained points from leveling	
	if event == "CHARACTER_POINTS_CHANGED" and levels > 0 then return end
	local curse = scan_for_known_talent(51886)
	can_dispel.SHAMAN.Curse = curse -- can_dispel table
	self:GetFilterDB('23').aura_type_list.Curse = curse -- Shaman can dispel filter
end

-- Setup the data for which auras belong to whom
local friend_buffs,friend_debuffs,self_buffs,self_debuffs,pet_buffs,enemy_debuffs = {},{},{},{},{},{}

-- DEATHKNIGHT
friend_buffs.DEATHKNIGHT = {
	[53136] = not wrath_333 or nil, -- Abominable Might (Abomination's Might) pre 3.3.3
	[53137] = wrath_333 or nil, -- Abomination's Might post 3.3.3
	[57623] = true, -- Horn of Winter
	[49016] = true, -- Hysteria
	[3714]  = true, -- Path of Frost
}
friend_debuffs.DEATHKNIGHT = {}
self_buffs.DEATHKNIGHT = {
	[49222] = true, -- Bone Shield
	[55226] = true, -- Blade Barrier
	[49028] = true, -- Dancing Rune Weapon
	[49796] = true, -- Deathchill
	[50466] = not wrath_310 or nil, -- Death Trance! (Sudden Doom)
	[59052] = true, -- Freezing Fog (Rime)
	[51124] = true, -- Killing Machine
	[49039] = true, -- Lichborne
	[48792] = true, -- Icebound Fortitude
	[50421] = true, -- Scent of Blood
	[49206] = true, -- Summon Gargoyle
	[55233] = true, -- Vampiric Blood
	[51271] = true, -- Unbreakable Armor
}
self_debuffs.DEATHKNIGHT = {}
pet_buffs.DEATHKNIGHT = {
	[19705] = true, -- Well Fed
}
enemy_debuffs.DEATHKNIGHT = {
	[55078] = true, -- Blood Plague
	[45524] = true, -- Chains of Ice
	[50510] = true, -- Crypt Fever
	[51735] = true, -- Ebon Plague
	[55095] = true, -- Frost Fever
	[49203] = true, -- Hungering Cold
	[49005] = true, -- Mark of Blood
	[47476] = true, -- Strangulate
	[50536] = true, -- Unholy Blight
}

-- DRUID
friend_buffs.DRUID = {
	[2893]  = true, -- Abolish Poison
	[21849] = true, -- Gift of the Wild
	[29166] = true, -- Innervate
	[17007] = true, -- Leader of the Pack
	[33763] = true, -- Lifebloom
	[48496] = true, -- Living Seed
	[1126]  = true, -- Mark of the Wild
	[24907] = true, -- Moonkin Aura
	[8936]  = true, -- Regrowth
	[774]   = true, -- Rejuvenation
	[467]   = true, -- Thorns
	[740]   = true, -- Tranquility
	[5420]  = true, -- Tree of Life
	[48438] = true, -- Wild Growth
}
friend_debuffs.DRUID = {}
self_buffs.DRUID = {
	[1066]  = true, -- Aquatic Form
	[20655] = true, -- Barkskin
	[50334] = true, -- Berserk
	[5487]  = true, -- Bear Form
	[768]   = true, -- Cat Form
	[12536] = true, -- Clearcasting
	[1850]  = true, -- Dash
	[9634]  = true, -- Dire Bear Form
	[48517] = true, -- Eclipse
	[3019]  = true, -- Enrage
	[33943] = true, -- Flight Form
	[22842] = true, -- Frenzied Regeneration
	[24858] = true, -- Moonkin Form
	[33883] = true, -- Natural Perfection
	[16880] = true, -- Nature's Grace
	[16689] = true, -- Nature's Grasp
	[16188] = true, -- Nature's Swiftness
	[16864] = true, -- Omen of Clarity
	[48389] = true, -- Owlkin Frenzy
	[5215]  = true, -- Prowl
	[52610]	= true, -- Savage Roar
	[48505] = true, -- Starfall
	[61336] = true, -- Survival Instincts
	[40120] = true, -- Swift Flight Form
	[5217]  = true, -- Tiger's Fury
	[5225]  = true, -- Track Humanoids
	[783]   = true, -- Travel Form
}
self_debuffs.DRUID = {}
pet_buffs.DRUID = {}
enemy_debuffs.DRUID = {
	[5211]  = true, -- Bash
	[5209]  = true, -- Challenging Roar
	[29538] = true, -- Cyclone
	[99]    = true, -- Demoralizing Roar
	[339]   = true, -- Entangling Roots
	[48506] = true, -- Earth and Moon
	[770]   = true, -- Faerie Fire
	[16857] = true, -- Faerie Fire (Feral)
	[16979] = true, -- Feral Charge
	[2637]  = true, -- Hibernate
	[16914] = true, -- Hurricane
	[48483] = true, -- Infected Wounds
	[5570]  = true, -- Insect Swarm
	[5422]  = true, -- Lacerate
	[22570] = true, -- Maim
	[33878] = true, -- Mangle (Bear)
	[33876] = true, -- Mangle (Cat)
	[563]   = true, -- Moonfire
	[9005]  = true, -- Pounce
	[1822]  = true, -- Rake
	[1079]  = true, -- Rip
	[2908]  = true, -- Soothe Animal
}

-- HUNTER
friend_buffs.HUNTER = {
	[13159] = true, -- Aspect of the Pack
	[20043] = true, -- Aspect of the Wild
	[34455] = true, -- Ferocious Inspiration
	[34477] = true, -- Misdirection
	[19578] = true, -- Spirit Bond
	[19506] = true, -- Trueshot Aura
	[57669] = true, -- Replenishment
	[54216] = wrath_310 or nil, -- Master's Call
}
friend_debuffs.HUNTER = {}
self_buffs.HUNTER = {
	[13161] = true, -- Aspect of the Beast
	[5118]  = true, -- Aspect of the Cheetah
	[61846] = true, -- Aspect of the Dragonhawk
	[13165] = true, -- Aspect of the Hawk
	[13163] = true, -- Aspect of the Monkey
	[34074] = true, -- Aspect of the Viper
	[19263] = true, -- Deterrence
	[6197]  = true, -- Eagle Eye
	[1002]  = true, -- Eyes of the Beast
	[5384]  = true, -- Feign Death
	[34506] = true, -- Master Tactician
	[6150]  = true, -- Quick Shots
	[3045]  = true, -- Rapid Fire
	[34948] = true, -- Rapid Killing
	[34471] = true, -- The Beast Within
}
self_debuffs.HUNTER = {}
pet_buffs.HUNTER = {
	[19574] = true, -- Bestial Wrath
	[3385]  = true, -- Boar Charge
	[1850]  = true, -- Dash
	[23145] = true, -- Dive
	[1539]  = true, -- Feed Pet Effect
	[19451] = true, -- Frenzy
	[3149]  = true, -- Furious Howl
	[136]   = true, -- Mend Pet
	[5215]  = true, -- Prowl
	[26064] = true, -- Shell Shield
	[32920] = true, -- Warp
	[19705] = true, -- Well Fed
}
enemy_debuffs.HUNTER = {
	[19434] = true, -- Aimed Shot
	[1462]  = true, -- Beast Lore
	[3385]  = true, -- Boar Charge
	[53359]	= true, -- Chimera Shot - Scorpid
	[35100] = true, -- Concussive Barrage
	[5116]  = true, -- Concussive Shot
	[19306] = true, -- Counterattack
	[3408]  = true, -- Crippling Poison
	[2818]  = true, -- Deadly Poison
	[19184] = true, -- Entrapment
	[13812] = true, -- Explosive Trap Effect
	[7140]  = true, -- Expose Weakness
	[34889] = true, -- Fire Breath
	[1543]  = true, -- Flare
	[3355]  = true, -- Freezing Trap Effect
	[13810] = true, -- Frost Trap Aura
	[1853]  = true, -- Growl
	[1130]  = true, -- Hunter's Mark
	[19407] = true, -- Improved Concussive Shot
	[19228] = not wrath_310 or nil, -- Improved Wing Clip
	[7093]  = true, -- Intimidation
	[5760]  = true, -- Mind-numbing Poison
	[32093] = true, -- Poison Spit
	[1513]  = true, -- Scare Beast
	[19503] = true, -- Scatter Shot
	[6411]  = true, -- Scorpid Poison
	[3043]  = true, -- Scorpid Sting
	[24423] = true, -- Screech
	[1978]  = true, -- Serpent Sting
	[34490] = true, -- Silencing Shot
	[1515]  = true, -- Tame Beast
	[3034]  = true, -- Viper Sting
	[2974]  = true, -- Wing Clip
	[19386] = true, -- Wyvern Sting
}

-- MAGE
friend_buffs.MAGE = {
	[1008]  = true, -- Amplify Magic
	[23028] = true, -- Arcane Brilliance
	[1459]  = true, -- Arcane Intellect
	[61316] = true, -- Dalaran Brilliance
	[61024] = true, -- Dalaran Intellect
	[54648] = true, -- Focus Magic
	[604]   = true, -- Dampen Magic
	[130]   = true, -- Slow Fall
	[57669] = wrath_310 or nil, -- Replenishment
}
friend_debuffs.MAGE = {}
self_buffs.MAGE = {
	[31571] = true, -- Arcane Potency
	[12042] = true, -- Arcane Power
	[31641] = true, -- Blazing Speed
	[1953]  = true, -- Blink
	[12536] = true, -- Clearcasting
	[11129] = true, -- Combustion
	[12051] = true, -- Evocation
	[543]   = true, -- Fire Ward
	[57761] = true, -- Fireball! (instant cast fireball proc from Brain Freeze)
	[54741] = true, -- Firestarter
	[44440] = true, -- Firey Payback
	[168]   = true, -- Frost Armor
	[6143]  = true, -- Frost Ward
	[44445] = true, -- Hot Streak
	[7302]  = true, -- Ice Armor
	[11426] = true, -- Ice Barrier
	[27619] = true, -- Ice Block
	[44394] = true, -- Incanter's Absorption
	[66]    = true, -- Invisibility
	[6117]  = true, -- Mage Armor
	[1463]  = true, -- Mana Shield
	[44401] = true, -- Missile Barrage
	[30482] = true, -- Molten Armor
	[12043] = true, -- Presence of Mind
}
self_debuffs.MAGE = {
	[10833] = true, -- Arcane Blast
	[41425] = true, -- Hypothermia
}
pet_buffs.MAGE = {}
enemy_debuffs.MAGE = {
	[11113]	= true, -- Blast Wave
	[10]    = true, -- Blizzard
	[6136]  = true, -- Chilled
	[120]   = true, -- Cone of Cold
	[29964] = true, -- Dragon's Breath
	[22959] = true, -- Fire Vulnerability
	[133]   = true, -- Fireball
	[2120]  = true, -- Flamestrike
	[168]   = true, -- Frost Armor
	[122]   = true, -- Frost Nova
	[11071] = true, -- Frostbite
	[116]   = true, -- Frostbolt
	[7302]  = true, -- Ice Armor
	[3261]  = true, -- Ignite
	[11103] = true, -- Impact
	[44457] = true, -- Living Bomb
	[118]   = true, -- Polymorph
	[11366] = true, -- Pyroblast
	[246]   = true, -- Slow
	[11180] = true, -- Winter's Chill
}

-- PALADIN
friend_buffs.PALADIN = {
	[64364]	= wrath_310 or nil, -- Aura Mastery
	[53563] = true, -- Beacon of Light
	[20217] = true, -- Blessing of Kings
	[19740] = true, -- Blessing of Might
	[20911] = true, -- Blessing of Sanctuary
	[19742] = true, -- Blessing of Wisdom
	[19746] = true, -- Concentration Aura
	[32223] = true, -- Crusader Aura
	[465]   = true, -- Devotion Aura
	[19752] = true, -- Divine Intervention
	[19891] = true, -- Fire Resistance Aura
	[19888] = true, -- Frost Resistance Aura
	[25898] = true, -- Greater Blessing of Kings
	[25782] = true, -- Greater Blessing of Might
	[25899] = true, -- Greater Blessing of Sanctuary
	[25894] = true, -- Greater Blessing of Wisdom
	[1044]  = true, -- Hand of Freedom
	[1022]  = true, -- Hand of Protection
	[6940]  = true, -- Hand of Sacrifice
	[20233]	= true, -- Improved Lay on Hands
	[7294]  = true, -- Retribution Aura
	[53659]	= true, -- Sacred Cleansing
	[53601] = true, -- Sacred Shield
	[58597]	= true, -- Sacred Shield Proc
	[19876] = true, -- Shadow Resistance Aura
	[54203]	= true, -- Sheath of Light
	[57669] = true, -- Replenishment
}
friend_debuffs.PALADIN = {
	[25771] = true, -- Forbearance
}
self_buffs.PALADIN = {
	[31884] = true, -- Avenging Wrath
	[20216] = true, -- Divine Favor
	[31842] = true, -- Divine Illumination
	[54428]	= true, -- Divine Plea
	[498]   = true, -- Divine Protection
	[64205]	= wrath_310 or nil, -- Divine Sacrifice
	[642]   = true, -- Divine Shield
	[9800]  = true, -- Holy Shield
	[54149]	= true, -- Infusion of Light
	[54153]	= true, -- Judgements of the Pure
	[31834]	= true, -- Light's Grace
	[20178]	= true, -- Reckoning
	[25780] = true, -- Righteous Fury
	[31892] = player_race == "BloodElf", -- Seal of Blood
	[20375] = true, -- Seal of Command
	[53736] = player_race == "BloodElf", -- Seal of Corruption
	[20164] = true, -- Seal of Justice
	[20165] = true, -- Seal of Light
	[53720] = player_race == "Human" or player_race == "Dwarf" or player_race == "Draenei", -- Seal of the Martyr
	[20154] = true, -- Seal of Righteousness
	[31801] = player_race == "Human" or player_race == "Dwarf" or player_race == "Draenei", -- Seal of Vengeance
	[20166] = true, -- Seal of Wisdom
	[5502]  = true, -- Sense Undead
	[23214] = true, -- Summon Charger
	[13819] = true, -- Summon Warhorse
	[53489]	= true, -- The Art of War
}
self_debuffs.PALADIN = {}
pet_buffs.PALADIN = {}
enemy_debuffs.PALADIN = {
	[31935] = true, -- Avenger's Shield
	[53742] = player_race == "BloodElf", -- Dot, from Seal of Corruption (Blood Corruption)
	[20116] = true, -- Consecration
	[853]   = true, -- Hammer of Justice
	[21183]	= true, -- Heart of the Crusader
	[31803] = player_race == "Human" or player_race == "Dwarf" or player_race == "Draenei", -- Dot from, Seal of Vengeance (Holy Vengeance)
	[20184] = true, -- Judgement of Justice
	[20185] = true, -- Judgement of Light
	[20186] = true, -- Judgement of Wisdom
	[20066] = true, -- Repentance
	[61840] = true, -- Righteous Vengeance
	[25]    = true, -- Stun, from Seal of Justice
	[10326] = true, -- Turn Evil
	[67]	= true, -- Vindication
}


-- PRIEST
friend_buffs.PRIEST = {
	[552]   = true, -- Abolish Disease
	[47753]	= true, -- Divine Aegis
	[14752] = true, -- Divine Spirit
	[6346]  = true, -- Fear Ward
	[56161] = true, -- Glyph of Prayer of Healing
	[47930]	= true, -- Grace
	[47788]	= true, -- Guardian Spirit
	[60931] = not wrath_310 or nil, -- Hymn of Hope
	[14892] = true, -- Inspiration
	[1706]  = true, -- Levitate
	[7001]	= true, -- Lightwell Renew
	[10060] = true, -- Power Infusion
	[1243]  = true, -- Power Word: Fortitude
	[17]    = true, -- Power Word: Shield
	[21562] = true, -- Prayer of Fortitude
	[33206] = true, -- Pain Suppression
	[33076] = true, -- Prayer of Mending
	[27683] = true, -- Prayer of Shadow Protection
	[27681] = true, -- Prayer of Spirit
	[139]   = true, -- Renew
	[63944] = wrath_310 or nil, -- Renewed Hope
	[976]   = true, -- Shadow Protection
	[57669] = true, -- Replenishment
}
friend_debuffs.PRIEST = {
	[2096]  = true, -- Mind Vision
	[6788]  = true, -- Weakened Soul
}
self_buffs.PRIEST = {
	[27811] = true, -- Blessed Recovery
	[33143]	= true, -- Blessed Resilience
	[59887]	= true, -- Borrowed Time
	[34754]	= true, -- Clearcasting
	[47585] = true, -- Dispersion
	[586]   = true, -- Fade
	[14743] = true, -- Focused Casting
	[45237]	= true, -- Focused Will
	[34753]	= true, -- Holy Concentration
	[47894]	= not wrath_310 or nil, -- Improved Holy Concentration
	[588]   = true, -- Inner Fire
	[14751] = true, -- Inner Focus
	[2096]  = true, -- Mind Vision
	[63731]	= wrath_310 or nil, -- Serendipity
	[15258] = true, -- Shadow Weaving
	[15473] = true, -- Shadowform
	[27827] = true, -- Spirit of Redemption
	[33151]	= true, -- Surge of Light
}
self_debuffs.PRIEST = {}
pet_buffs.PRIEST = {}
enemy_debuffs.PRIEST = {
	[2944]  = true, -- Devouring Plague
	[14914] = true, -- Holy Fire
	[605]   = true, -- Mind Control
	[15407] = true, -- Mind Flay
	[49821]	= true, -- Mind Sear
	[453]   = true, -- Mind Soothe
	[2096]  = true, -- Mind Vision
	[33196]	= true, -- Misery
	[59980]	= not wrath_310 or nil, -- Psychic Horror 3.0.x
	[64058] = wrath_310 or nil, -- Psychic Horror 3.1.x+
	[8122]  = true, -- Psychic Scream
	[9484]  = true, -- Shackle Undead
	[589]   = true, -- Shadow Word: Pain
	[6726]  = true, -- Silence
	[15286] = true, -- Vampiric Embrace
	[34914] = true, -- Vampiric Touch
}

-- ROGUE
friend_buffs.ROGUE = {
	[57934] = true, -- Tricks of the Trade
}
friend_debuffs.ROGUE = {}
self_buffs.ROGUE = {
	[13750] = true, -- Adrenaline Rush
	[13877] = true, -- Blade Flurry
	[31224] = true, -- Cloak of Shadows
	[14177] = true, -- Cold Blood
	[4086]  = true, -- Evasion
	[14278] = true, -- Ghostly Strike
	[51662] = true, -- Hunger For Blood
	[14143] = true, -- Remorseless
	[36554] = true, -- Shadowstep
	[5171]  = true, -- Slice and Dice
	[2983]  = true, -- Sprint
	[1784]  = true, -- Stealth
	[1856]  = true, -- Vanish
}
self_debuffs.ROGUE = {}
pet_buffs.ROGUE = {}
enemy_debuffs.ROGUE = {
	[2094]  = true, -- Blind
	[1833]  = true, -- Cheap Shot
	[3408]  = true, -- Crippling Poison
	[2818]  = true, -- Deadly Poison
	[26679] = true, -- Deadly Throw
	[8647]  = true, -- Expose Armor
	[703]   = true, -- Garrote
	[1330]  = true, -- Garrote - Silence
	[1776]  = true, -- Gouge
	[16511] = true, -- Hemorrhage
	[18425] = true, -- Kick - Silenced
	[408]   = true, -- Kidney Shot
	[5530]  = true, -- Mace Stun Effect
	[5760]  = true, -- Mind-numbing Poison
	[14251] = true, -- Riposte
	[1943]  = true, -- Rupture
	[2070]  = true, -- Sap
	[13218] = true, -- Wound Poison
}

-- SHAMAN
friend_buffs.SHAMAN = {
	[16177] = true, -- Ancestral Fortitude
	[2825]  = player_race == "Troll" or player_race == "Tauren" or player_race == "Orc", -- Bloodlust
	[379]   = true, -- Earth Shield
	[51945] = true, -- Earthliving
	[51466] = true, -- Elemental Oath
	[4057]  = true, -- Fire Resistance
	[8227]  = true, -- Flametongue Totem
	[4077]  = true, -- Frost Resistance
	[8178]  = true, -- Grounding Totem Effect
	[5672]  = true, -- Healing Stream
	[29202] = true, -- Healing Way
	[23682] = player_race == "Draenei", -- Heroism
	[5677]  = true, -- Mana Spring
	[16191] = true, -- Mana Tide
	[4081]  = true, -- Nature Resistance
	[61295] = true, -- Riptide
	[8072]  = true, -- Stoneskin
	[8076]  = true, -- Strength of Earth
	[30706] = true, -- Totem of Wrath
	[131]   = true, -- Water Breathing
	[546]   = true, -- Water Walking
	[27621] = true, -- Windfury Totem
	[2895]  = true, -- Wrath of Air Totem
}
friend_debuffs.SHAMAN = {
	[57723] = player_race == "Draenei", -- Exhaustion
	[57724] = player_race == "Troll" or player_race == "Tauren" or player_race == "Orc", -- Sated
}
self_buffs.SHAMAN = {
	[52179] = true, -- Astral Shift
	[12536] = true, -- Clearcasting
	[29177] = true, -- Elemental Devastation
	[16166] = true, -- Elemental Mastery
	[6196]  = true, -- Far Sight
	[14743] = true, -- Focused Casting
	[2645]  = true, -- Ghost Wolf
	[324]   = true, -- Lightning Shield
	[53817] = true, -- Maelstrom Weapon
	[16188] = true, -- Nature's Swiftness
	[6495]  = true, -- Sentry Totem
	[43339] = true, -- Shamanistic Focus (Focused)
	[30823] = true, -- Shamanistic Rage
	[55166] = true, -- Tidal Force
	[53390] = true, -- Tidal Waves
	[23575] = true, -- Water Shield
	[16257]	= true, -- Flurry
	[58875]	= true, -- Spirit Walk
}
self_debuffs.SHAMAN = {}
pet_buffs.SHAMAN = {
	[58875]	= true, -- Spirit Walk
}
enemy_debuffs.SHAMAN = {
	[3600]  = true, -- Earthbind
	[8050]  = true, -- Flame Shock
	[8056]  = true, -- Frost Shock
	[8034]  = true, -- Frostbrand Attack
	[39796] = true, -- Stoneclaw Stun
	[17364] = true, -- Stormstrike
	[30708]	= true, -- Totem of Wrath
	[51514]	= true, -- Hex
	[58861]	= true, -- Bash
}

-- WARLOCK
friend_buffs.WARLOCK = {
	[6307]  = true, -- Blood Pact
	[132]   = true, -- Detect Invisibility
	[134]   = true, -- Fire Shield
	[54424] = true, -- Fel Intelligence
	[20707] = true, -- Soulstone Resurrection
	[5697]  = true, -- Unending Breath
	[57669] = wrath_310 or nil, -- Replenishment
}
friend_debuffs.WARLOCK = {}
self_buffs.WARLOCK = {
	[47258] = true, -- Backdraft
	[34935] = true, -- Backlash
	[63156] = true, -- Decimation
	[706]   = true, -- Demon Armor
	[687]   = true, -- Demon Skin
	[35691] = true, -- Demonic Knowledge
	[18788] = true, -- Demonic Sacrifice
	[47195] = true, -- Eradication
	[28176] = true, -- Fel Armor
	[18708] = true, -- Fel Domination
	[63321] = true, -- Life Tap (Glyph of)
	[23759] = true, -- Master Demonologist
	[47245] = true, -- Molten Core
	[30299] = true, -- Nether Protection
	[1050]  = true, -- Sacrifice
	[5500]  = true, -- Sense Demons
	[17941] = true, -- Shadow Trance
	[6229]  = true, -- Shadow Ward
	[19028] = true, -- Soul Link
	[23161] = true, -- Summon Dreadsteed
	[1710]  = true, -- Summon Felsteed
	[47241]	= true, -- Metamorphosis
}
self_debuffs.WARLOCK = {}
pet_buffs.WARLOCK = {
	[23257] = true, -- Demonic Frenzy
	[19705] = true, -- Well Fed
}
enemy_debuffs.WARLOCK = {
	[18118] = true, -- Aftermath
	[710]   = true, -- Banish
	[172]   = true, -- Corruption
	[89]    = true, -- Cripple
	[980]   = true, -- Curse of Agony
	[603]   = true, -- Curse of Doom
	[18223] = true, -- Curse of Exhaustion
	[704]   = not wrath_310 or nil, -- Curse of Recklessness
	[1714]  = true, -- Curse of Tongues
	[702]   = true, -- Curse of Weakness
	[1490]  = true, -- Curse of the Elements
	[6789]  = true, -- Death Coil
	[689]   = true, -- Drain Life
	[5138]  = true, -- Drain Mana
	[1120]  = true, -- Drain Soul
	[5782]  = true, -- Fear
	[48181] = true, -- Haunt
	[1949]  = true, -- Hellfire
	[5484]  = true, -- Howl of Terror
	[348]   = true, -- Immolate
	[1122]  = true, -- Inferno
	[18073] = true, -- Pyroclasm
	[4629]  = true, -- Rain of Fire
	[6358]  = true, -- Seduction
	[27243] = true, -- Seed of Corruption
	[32385] = true, -- Shadow Embrace
	[15258] = true, -- Shadow Vulnerability
	[17877] = true, -- Shadowburn
	[30283] = true, -- Shadowfury
	[6726]  = true, -- Silence
	[18265] = not wrath_310 or nil, -- Siphon Life
	[6360]  = true, -- Soothing Kiss
	[19244] = true, -- Spell Lock
	[17735] = true, -- Suffering
	[54049] = true, -- Shadow Bite
	[61291] = true, -- Shadowflame
	[30108] = true, -- Unstable Affliction
}

-- WARRIOR
friend_buffs.WARRIOR = {
	[2048]  = true, -- Battle Shout
	[469]   = true, -- Commanding Shout
	[3411]  = true, -- Intervene
	[50720] = true, -- Vigilance
}
friend_debuffs.WARRIOR = {}
self_buffs.WARRIOR = {
	[18499] = true, -- Berserker Rage
	[16487] = true, -- Blood Craze
	[2687]  = true, -- Bloodrage
	[23880] = true, -- Bloodthirst
	[3019]  = true, -- Enrage
	[55694]	= true, -- Enraged Regeneration
	[12319] = true, -- Flurry
	[12975] = true, -- Last Stand
	[8285]  = true, -- Rampage
	[1719]  = true, -- Recklessness
	[20230] = true, -- Retaliation
	[15604] = true, -- Second Wind
	[2565]  = true, -- Shield Block
	[871]   = true, -- Shield Wall
	[9941]  = true, -- Spell Reflection
	[12328] = true, -- Sweeping Strikes
	-- T4, Tank, 2/4 piece bonus
	[37514] = true, -- Blade Turning
	[6572]  = true, -- Revenge
	-- T5, Tank, 2/4 piece bonus
	[37525] = true, -- Battle Rush
	[37523] = true, -- Reinforced Shield
	-- T5, DPS, 2 piece bonus
	[7384]  = true, -- Overpower
	[40729] = true, -- Heightened Reflexes
	[61571] = true, -- Spirits of the Lost
	[46916] = true, -- Slam!
}
self_debuffs.WARRIOR = {
	[12292] = true, -- Death Wish
}
pet_buffs.WARRIOR = {}
enemy_debuffs.WARRIOR = {
	[16952] = true, -- Blood Frenzy
	[1161]  = true, -- Challenging Shout
	[7922]  = true, -- Charge Stun
	[12809] = true, -- Concussion Blow
	[1604]  = true, -- Dazed
	[12721] = true, -- Deep Wound
	[1160]  = true, -- Demoralizing Shout
	[676]   = true, -- Disarm
	[1715]  = true, -- Hamstring
	[12289] = true, -- Improved Hamstring
	[20253] = true, -- Intercept Stun
	[5246]  = true, -- Intimidating Shout
	[5530]  = true, -- Mace Stun Effect
	[694]   = true, -- Mocking Blow
	[9347]  = true, -- Mortal Strike
	[10576] = true, -- Piercing Howl
	[772]   = true, -- Rend
	[12798] = true, -- Revenge Stun
	[18498] = true, -- Shield Bash - Silenced
	[7386]  = true, -- Sunder Armor
	[355]   = true, -- Taunt
	[6343]  = true, -- Thunder Clap
}

-- Human
friend_buffs.Human = {
	[23333] = true, -- Warsong Flag
}
friend_debuffs.Human = {}
self_buffs.Human = {}
self_debuffs.Human = {}
pet_buffs.Human = {}
enemy_debuffs.Human = {}

-- Dwarf
friend_buffs.Dwarf = {
	[23333] = true, -- Warsong Flag
}
friend_debuffs.Dwarf = {}
self_buffs.Dwarf = {
	[2481] = true, -- Find Treasure
	[7020] = true, -- Stoneform
}
self_debuffs.Dwarf = {}
pet_buffs.Dwarf = {}
enemy_debuffs.Dwarf = {}

-- NightElf
friend_buffs.NightElf = {
	[23333] = true, -- Warsong Flag
}
friend_debuffs.NightElf = {}
self_buffs.NightElf = {
	[58984] = true, -- Shadowmeld
}
self_debuffs.NightElf = {}
pet_buffs.NightElf = {}
enemy_debuffs.NightElf = {}

-- Gnome
friend_buffs.Gnome = {
	[23333] = true, -- Warsong Flag
}
friend_debuffs.Gnome = {}
self_buffs.Gnome = {}
self_debuffs.Gnome = {}
pet_buffs.Gnome = {}
enemy_debuffs.Gnome = {}

-- Draenei
friend_buffs.Draenei = {
	[28880] = true, -- Gift of the Naaru
	[23333] = true, -- Warsong Flag
}
friend_debuffs.Draenei = {}
self_buffs.Draenei = {}
self_debuffs.Draenei = {}
pet_buffs.Draenei = {}
enemy_debuffs.Draenei = {}

-- Orc
friend_buffs.Orc = {
	[23335] = true, -- Silverwing Flag
}
friend_debuffs.Orc = {}
self_buffs.Orc = {
	[20572] = true, -- Blood Fury
}
self_debuffs.Orc = {
	[20572] = true, -- Blood Fury
}
pet_buffs.Orc = {}
enemy_debuffs.Orc = {}

-- Scourge
friend_buffs.Scourge = {
	[23335] = true, -- Silverwing Flag
}
friend_debuffs.Scourge = {}
self_buffs.Scourge = {
	[20577] = true, -- Cannibalize
	[7744] = true, -- Will of the Forsaken
}
self_debuffs.Scourge = {}
pet_buffs.Scourge = {}
enemy_debuffs.Scourge = {}

-- Tauren
friend_buffs.Tauren = {
	[23335] = true, -- Silverwing Flag
}
friend_debuffs.Tauren = {}
self_buffs.Tauren = {}
self_debuffs.Tauren = {}
pet_buffs.Tauren = {}
enemy_debuffs.Tauren = {
	[45] = true, -- War Stomp
}

-- Troll
friend_buffs.Troll = {
	[23335] = true, -- Silverwing Flag
}
friend_debuffs.Troll = {}
self_buffs.Troll = {
	[26297] = true, -- Berserking
}
self_debuffs.Troll = {}
pet_buffs.Troll = {}
enemy_debuffs.Troll = {}

-- BloodElf
friend_buffs.BloodElf = {
	[23335] = true, -- Silverwing Flag
}
friend_debuffs.BloodElf = {}
self_buffs.BloodElf = {}
self_debuffs.BloodElf = {}
pet_buffs.BloodElf = {}
enemy_debuffs.BloodElf = {
	[25046] = true, -- Arcane Torrent
}

-- Everyone
local extra_buffs = {
	[34976] = true, -- Netherstorm Flag
}

local function turn(t, shallow)
	local tmp = {}
	local function turn(entry)
		for id,v in pairs(entry) do
			local spell = GetSpellInfo(id)
			if not spell then
				DEFAULT_CHAT_FRAME:AddMessage(string.format("PitBull4_Aura: Unknown spell ID: %d",id))
			else
				tmp[spell] = v
			end
		end
		wipe(entry)
		for spell,v in pairs(tmp) do
			entry[spell] = v
		end
	end
	if shallow then
		turn(t)
		return
	end
	for k in pairs(t) do
		local entry = t[k]
		wipe(tmp)
		turn(entry)
	end
end
turn(friend_buffs)
turn(friend_debuffs)
turn(self_buffs)
turn(self_debuffs)
turn(pet_buffs)
turn(enemy_debuffs)
turn(extra_buffs, true)

PitBull4_Aura.friend_buffs = friend_buffs
PitBull4_Aura.friend_debuffs = friend_debuffs
PitBull4_Aura.self_buffs = self_buffs
PitBull4_Aura.self_debuffs = self_debuffs
PitBull4_Aura.pet_buffs = pet_buffs
PitBull4_Aura.enemy_debuffs = enemy_debuffs
PitBull4_Aura.extra_buffs = extra_buffs

function PitBull4_Aura:FilterEntry(name, entry, frame)
	if not name or name == "" then return true end
	local filter = self:GetFilterDB(name)
	if not filter then return true end
	local filter_func = self.filter_types[filter.filter_type].filter_func
	return filter_func(name, entry, frame)
end
