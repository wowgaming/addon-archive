local AceConfig = LibStub('AceConfigDialog-3.0')
local L = LibStub('AceLocale-3.0'):GetLocale('RaidBuffStatus')
local GT = LibStub("LibGroupTalents-1.0")

RaidBuffStatus = LibStub("AceAddon-3.0"):NewAddon("RaidBuffStatus", "AceEvent-3.0", "AceTimer-3.0", "AceConsole-3.0")

RaidBuffStatus.L = L
RaidBuffStatus.GT = GT
RaidBuffStatus.bars = {}

local band = _G.bit.band

local buttons = {}
local optionsbuttons = {}
local incombat = false
local dashwasdisplayed = true
local tankList = '|'
local nextscan = 0
RaidBuffStatus.timer = false
local playerid = UnitGUID("player")
local playername = UnitName("player")
local _, playerclass = UnitClass("player")
local xperltankrequest = false
local xperltankrequestt = 0
local nextfeastannounce = 0
local nexttableannounce = 0
local nextsoulannounce = 0
local nextrepairannounce = 0
local nextdurability = 0
local nextitemcheck = 0
local pallypowersendersseen = {}
RaidBuffStatus.version = ""
RaidBuffStatus.revision = ""
RaidBuffStatus.rbsversions = {}
local toldaboutnewversion = false
local toldaboutpallysetting = 0
RaidBuffStatus.ppmsgqueued = false
RaidBuffStatus.durability = {}
RaidBuffStatus.broken = {}
RaidBuffStatus.itemcheck = {}

-- babblespell replacement using GetSpellInfo(key)
local BSmeta = {}
local BS = setmetatable({}, BSmeta)
local BSI = setmetatable({}, BSmeta)
BSmeta.__index = function(self, key)
	local name, icon
	if type(key) == "number" then
		name, _, icon = GetSpellInfo(key)
	else
		geterrorhandler()(("Unknown spell key %q"):format(key))
	end
	if name then
		BS[key] = name
		BS[name] = name
		BSI[key] = icon
		BSI[name] = icon
	else
		BS[key] = false
		BSI[key] = false
		geterrorhandler()(("Unknown spell info key %q"):format(key))
	end
	return self[key]
end

local function SpellName(spellID)
	local name = GetSpellInfo(spellID)
	return name
end

-- List originally copied from BigBrother addon (Thanks BB)
local ccspells = {
	BS[118], -- Polymorph
	BS[9484], -- Shackle Undead
	BS[18658], -- Hibernate
	BS[14309], -- Freezing Trap Effect
	BS[60210], -- Freezing Arrow Effect
	BS[6770], -- Sap
	BS[20066], -- Repentance
	BS[5782], -- Fear
	BS[2094], -- Blind
	BS[51514], -- Hex
}
local ccspellshash = {} -- much faster matching than a loop
for _, spell in ipairs(ccspells) do
	ccspellshash[spell] = true
end

local rezspells = {
	BS[20484], -- Rebirth
	BS[7328], -- Redemption
	BS[2006], -- Resurrection
	BS[2008], -- Ancestral Spirit
	BS[50769], -- Revive
}
local rezspellshash = {}
for _, spell in ipairs(rezspells) do
	rezspellshash[spell] = true
end

local taunts = {
	-- Death Knights
	56222, -- Dark Command
	49576, -- Death Grip
	-- Warrior
	1161, -- Challenging Shout
	355, -- Taunt
	694, -- Mocking Blow
	-- Druid
	5209, -- Challenging Roar
	6795, -- Growl
	-- Paladin
	31790, -- Righteous Defense
	62124, -- Hand of Reckoning
	-- Hunter
	20736, -- Distracting Shot
}


local ppblessings = {
	["1"] = BS[19742], -- Blessing of Wisdom
	["2"] = BS[19740], -- Blessing of Might
	["3"] = BS[20217], -- Blessing of Kings
	["4"] = BS[20911], -- Blessing of Sanctuary
}

local ppclasses = {
	["1"] = "WARRIOR",
	["2"] = "ROGUE",
	["3"] = "PRIEST",
	["4"] = "DRUID",
	["5"] = "PALADIN",
	["6"] = "HUNTER",
	["7"] = "MAGE",
	["8"] = "WARLOCK",
	["9"] = "SHAMAN",
	["10"] = "DEATHKNIGHT",
}

local ppassignments = {
	WARRIOR = {},
	ROGUE = {},
	PRIEST = {},
	DRUID = {},
	PALADIN = {},
	HUNTER = {},
	MAGE = {},
	WARLOCK = {},
	SHAMAN = {},
	DEATHKNIGHT = {},
}
local pppallies = {}
RaidBuffStatus.pppallies = pppallies
RaidBuffStatus.ppassignments = ppassignments

local longtoshortblessing = {
	[BS[20217]] = L["BoK"], -- Blessing of Kings
	[BS[20911]] = L["BoS"], -- Blessing of Sanctuary
	[BS[19742]] = L["BoW"], -- Blessing of Wisdom
	[BS[19740]] = L["BoM"], -- Blessing of Might
}
RaidBuffStatus.longtoshortblessing = longtoshortblessing
local blessingtogreater = {
	[BS[20217]] = BS[25898], -- Blessing of Kings, Greater Blessing of Kings
	[BS[20911]] = BS[25899], -- Blessing of Sanctuary, Greater Blessing of Sanctuary
	[BS[19742]] = BS[25894], -- Blessing of Wisdom, Greater Blessing of Wisdom
	[BS[19740]] = BS[25782], -- Blessing of Might, Greater Blessing of Might
}

local classes = {
	"WARRIOR",
	"ROGUE",
	"PRIEST",
	"DRUID",
	"PALADIN",
	"HUNTER",
	"MAGE",
	"WARLOCK",
	"SHAMAN",
	"DEATHKNIGHT",
}

local raid = {
	classes = {
		PRIEST = {},
		DRUID = {},
		PALADIN = {},
		ROGUE = {},
		MAGE = {},
		WARLOCK = {},
		SHAMAN = {},
		WARRIOR = {},
		HUNTER = {},
		DEATHKNIGHT = {},
	},
	SanctuaryTalent = {},
	maxbowpoints = 0,
	maxrestorativetotemspoints = 0,
	VigilanceTalent = {},
	ClassNumbers = {},
	BuffTimers = {},
	TankList = {},
	ManaList = {},
	DPSList = {},
	HealerList = {},
	israid = false,
	isparty = false,
	isbattle = false,
	readid = 0,
	size = 1,
	guilds = {},
	pug = false,
	LastDeath = {},
}
RaidBuffStatus.raid = raid
raid.reset = function()
	raid.classes = {}
	raid.classes.PRIEST = {}
	raid.classes.DRUID = {}
	raid.classes.PALADIN = {}
	raid.classes.ROGUE = {}
	raid.classes.MAGE = {}
	raid.classes.WARLOCK = {}
	raid.classes.SHAMAN = {}
	raid.classes.WARRIOR = {}
	raid.classes.HUNTER = {}
	raid.classes.DEATHKNIGHT = {}
	raid.VigilanceTalent = {}
	raid.SanctuaryTalent = {}
	raid.maxbowpoints = 0
	raid.maxrestorativetotemspoints = 0
	raid.ClassNumbers = {}
	raid.BuffTimers = {}
	raid.TankList = {}
	raid.ManaList = {}
	raid.DPSList = {}
	raid.HealerList = {}
	raid.israid = false
	raid.isparty = false
	raid.isbattle = false
	raid.readid = 0
	raid.size = 1
	raid.guilds = {}
	raid.pug = false
	raid.LastDeath = {}
end
RaidBuffStatus.raid = raid

local specicons = {
	UNKNOWN = "Interface\\Icons\\INV_Misc_QuestionMark",
	Hybrid = "Interface\\Icons\\Spell_Nature_ElementalAbsorption",
}

local classicons = {
	PALADIN = "Interface\\Icons\\Ability_ThunderBolt",
	PRIEST = "Interface\\Icons\\INV_Staff_30",
	DRUID = "Interface\\Icons\\Ability_Druid_Maul",
	MAGE = "Interface\\Icons\\INV_Staff_13",
	ROGUE = "Interface\\Icons\\INV_ThrowingKnife_04",
	WARLOCK = "Interface\\Icons\\Spell_Nature_FaerieFire",
	SHAMAN = "Interface\\Icons\\Spell_Nature_BloodLust",
	WARRIOR = "Interface\\Icons\\INV_Sword_27",
	HUNTER = "Interface\\Icons\\INV_Weapon_Bow_07",
	DEATHKNIGHT = "Interface\\Icons\\Spell_Deathknight_ClassIcon",
	UNKNOWN = "Interface\\Icons\\INV_Misc_QuestionMark",
}

local roleicons = {
	MeleeDPS = "Interface\\Icons\\INV_ThrowingKnife_03",
	RangedDPS = "Interface\\Icons\\INV_Staff_13",
	Tank = "Interface\\Icons\\INV_Shield_06",
	Healer = "Interface\\Icons\\Spell_Holy_FlashHeal",
	UNKNOWN = "Interface\\Icons\\INV_Misc_QuestionMark",
}


local tfi = {
	namewidth = 120,
	classwidth = 55,
	specwidth = 55,
	rolewidth = 55,
	specialisationswidth = 210,
	gap = 2,
	edge = 5,
	inset = 3,
	topedge = 45,
	rowheight = 17,
	rowgap = 0,
	maxrows = 40,
	okbuttonheight = 55,
	rowdata = {},
	rowframes = {},
	buttonsize = 15,
	sort = "role",
	sortorder = 1,
}
RaidBuffStatus.tfi = tfi
tfi.namex = tfi.edge
tfi.classx = tfi.namex + tfi.namewidth + tfi.gap
tfi.specx = tfi.classx + tfi.classwidth + tfi.gap
tfi.rolex = tfi.specx + tfi.specwidth + tfi.gap
tfi.specialisationsx = tfi.rolex + tfi.rolewidth + tfi.gap
tfi.framewidth = tfi.specialisationsx + tfi.specialisationswidth + tfi.edge
tfi.rowwidth = tfi.framewidth - tfi.edge - tfi.edge - tfi.inset - tfi.inset

-- diameter of the Minimap in game yards at
-- the various possible zoom levels
-- from Astrolabe
local MinimapSize = {
	indoor = {
		[0] = 300, -- scale -- this one is wrong but I don't know the correct value
		[1] = 240, -- 1.25
		[2] = 180, -- 5/3
		[3] = 120, -- 2.5
		[4] = 80,  -- 3.75
		[5] = 50,  -- 6
	},
	outdoor = {
		[0] = 466 + 2/3, -- scale
		[1] = 400,       -- 7/6
		[2] = 333 + 1/3, -- 1.4
		[3] = 266 + 2/6, -- 1.75
		[4] = 200,       -- 7/3
		[5] = 133 + 1/3, -- 3.5
	},
}

local function GUIDHasTalent(guid, talentName)
	return GT:GUIDHasTalent(guid, talentName) or 0
end

local SP = {
	vigilancetalent = {
		order = 1010,
		icon = BSI[50720], -- Vigilance
		tip = BS[50720], -- Vigilance
		callalways = true,
		code = function()
			raid.VigilanceTalent = {}
			for name,rcn in pairs(raid.classes.WARRIOR) do
				if GUIDHasTalent(rcn.guid, BS[50720]) > 0 then -- Vigilance
					table.insert(raid.VigilanceTalent, name)
					rcn.specialisations.vigilancetalent = true
				end
			end
		end,
	},
	improvedblizzardone = {
		order = 1000,
		icon = BSI[11185], -- Improved Blizzard
		tip = BS[11185] .. " +1", -- Improved Blizzard
		callalways = false,
		code = function()
			for name,rcn in pairs(raid.classes.MAGE) do
				if GUIDHasTalent(rcn.guid, BS[11185]) >= 1 then -- Improved Blizzard
					rcn.specialisations.improvedblizzardone = true
				end
			end
		end,
	},
	improvedblizzardtwo = {
		order = 990,
		icon = BSI[11185], -- Improved Blizzard
		tip = BS[11185] .. " +2", -- Improved Blizzard
		callalways = false,
		code = function()
			for name,rcn in pairs(raid.classes.MAGE) do
				if GUIDHasTalent(rcn.guid, BS[11185]) >= 2 then -- Improved Blizzard
					rcn.specialisations.improvedblizzardtwo = true
				end
			end
		end,
	},
	improvedblizzardthree = {
		order = 980,
		icon = BSI[11185], -- Improved Blizzard
		tip = BS[11185] .. " +3", -- Improved Blizzard
		callalways = false,
		code = function()
			for name,rcn in pairs(raid.classes.MAGE) do
				if GUIDHasTalent(rcn.guid, BS[11185]) >= 3 then -- Improved Blizzard
					rcn.specialisations.improvedblizzardthree = true
				end
			end
		end,
	},
	improvedmotwone = {
		order = 970,
		icon = BSI[1126], -- Mark of the Wild
		tip = BS[1126] .. " +1", -- Mark of the Wild
		callalways = true,
		code = function()
			for name,rcn in pairs(raid.classes.DRUID) do
				if GUIDHasTalent(rcn.guid, BS[17050]) >= 1 then -- Improved Mark of the Wild
					rcn.specialisations.improvedmotwone = true
				end
			end
		end,
	},
	improvedmotwtwo = {
		order = 960,
		icon = BSI[1126], -- Mark of the Wild
		tip = BS[1126] .. " +2", -- Mark of the Wild
		callalways = true,
		code = function()
			for name,rcn in pairs(raid.classes.DRUID) do
				if GUIDHasTalent(rcn.guid, BS[17050]) >= 2 then -- Improved Mark of the Wild
					rcn.specialisations.improvedmotwtwo = true
				end
			end
		end,
	},
	improvedhealthstoneone = {
		order = 920,
		icon = "Interface\\Icons\\INV_Stone_04",
		tip = L["Improved Health Stone level 1"],
		callalways = true,
		code = function()
			for name,rcn in pairs(raid.classes.WARLOCK) do
				if GUIDHasTalent(rcn.guid, BS[18692]) >= 1 then -- Improved Healthstone
					rcn.specialisations.improvedhealthstoneone = true
				end
			end
		end,
	},
	improvedhealthstonetwo = {
		order = 920,
		icon = "Interface\\Icons\\INV_Stone_04",
		tip = L["Improved Health Stone level 2"],
		callalways = true,
		code = function()
			for name,rcn in pairs(raid.classes.WARLOCK) do
				if GUIDHasTalent(rcn.guid, BS[18692]) >= 2 then -- Improved Healthstone
					rcn.specialisations.improvedhealthstonetwo = true
				end
			end
		end,
	},
	spiritofredemption = {
		order = 916,
		icon = BSI[27827], -- Spirit of Redemption
		tip = BS[27827], -- Spirit of Redemption
		callalways = true,
		code = function()
			for name,rcn in pairs(raid.classes.PRIEST) do
				if GUIDHasTalent(rcn.guid, BS[27827]) >= 1 then -- Spirit of Redemption
					rcn.specialisations.spiritofredemption = true
				end
			end
		end,
	},
	circleofhealing = {
		order = 915,
		icon = BSI[34861], -- Circle of Healing
		tip = BS[34861], -- Circle of Healing
		callalways = false,
		code = function()
			for name,rcn in pairs(raid.classes.PRIEST) do
				if GUIDHasTalent(rcn.guid, BS[34861]) >= 1 then -- Circle of Healing
					rcn.specialisations.circleofhealing = true
				end
			end
		end,
	},
	lightwell = {
		order = 910,
		icon = BSI[724], -- Lightwell
		tip = BS[724], -- Lightwell
		callalways = false,
		code = function()
			for name,rcn in pairs(raid.classes.PRIEST) do
				if GUIDHasTalent(rcn.guid, BS[724]) >= 1 then -- Lightwell
					rcn.specialisations.lightwell = true
				end
			end
		end,
	},
	improvedfortitudeone = {
		order = 900,
		icon = BSI[1243], -- Power Word: Fortitude
		tip = BS[1243] .. " +1", -- Power Word: Fortitude
		callalways = true,
		code = function()
			for name,rcn in pairs(raid.classes.PRIEST) do
				if GUIDHasTalent(rcn.guid, BS[14749]) >= 1 then -- Improved Power Word: Fortitude
					rcn.specialisations.improvedfortitudeone = true
				end
			end
		end,
	},
	improvedfortitudetwo = {
		order = 890,
		icon = BSI[1243], -- Power Word: Fortitude
		tip = BS[1243] .. " +2", -- Power Word: Fortitude
		callalways = true,
		code = function()
			for name,rcn in pairs(raid.classes.PRIEST) do
				if GUIDHasTalent(rcn.guid, BS[14749]) >= 2 then -- Improved Power Word: Fortitude
					rcn.specialisations.improvedfortitudetwo = true
				end
			end
		end,
	},
	shadowform = {
		order = 885,
		icon = BSI[15473], -- Shadowform
		tip = BS[15473], -- Shadowform
		callalways = true,
		code = function()
			for name,rcn in pairs(raid.classes.PRIEST) do
				if GUIDHasTalent(rcn.guid, BS[15473]) >= 1 then -- Shadowform
					rcn.specialisations.shadowform = true
				end
			end
		end,
	},
	vampiricembrace = {
		order = 883,
		icon = BSI[15286], -- Shadowform
		tip = BS[15286], -- Shadowform
		callalways = true,
		code = function()
			for name,rcn in pairs(raid.classes.PRIEST) do
				if GUIDHasTalent(rcn.guid, BS[15286]) >= 1 then -- Vampiric Embrace
					rcn.specialisations.vampiricembrace = true
				end
			end
		end,
	},
	improveddemoone = {
		order = 880,
		icon = BSI[1160], -- Demoralizing Shout
		tip = BS[1160] .. " +1", -- Demoralizing Shout
		callalways = false,
		code = function()
			for name,rcn in pairs(raid.classes.WARRIOR) do
				if GUIDHasTalent(rcn.guid, BS[12324]) >= 1 then -- Improved Demoralizing Shout
					rcn.specialisations.improveddemoone = true
				end
			end
		end,
	},
	improveddemotwo = {
		order = 870,
		icon = BSI[1160], -- Demoralizing Shout
		tip = BS[1160] .. " +2", -- Demoralizing Shout
		callalways = false,
		code = function()
			for name,rcn in pairs(raid.classes.WARRIOR) do
				if GUIDHasTalent(rcn.guid, BS[12324]) >= 2 then -- Improved Demoralizing Shout
					rcn.specialisations.improveddemotwo = true
				end
			end
		end,
	},
	improveddemothree = {
		order = 860,
		icon = BSI[1160], -- Demoralizing Shout
		tip = BS[1160] .. " +3", -- Demoralizing Shout
		callalways = false,
		code = function()
			for name,rcn in pairs(raid.classes.WARRIOR) do
				if GUIDHasTalent(rcn.guid, BS[12324]) >= 3 then -- Improved Demoralizing Shout
					rcn.specialisations.improveddemothree = true
				end
			end
		end,
	},
	improveddemofour = {
		order = 850,
		icon = BSI[1160], -- Demoralizing Shout
		tip = BS[1160] .. " +4", -- Demoralizing Shout
		callalways = false,
		code = function()
			for name,rcn in pairs(raid.classes.WARRIOR) do
				if GUIDHasTalent(rcn.guid, BS[12324]) >= 4 then -- Improved Demoralizing Shout
					rcn.specialisations.improveddemofour = true
				end
			end
		end,
	},
	improveddemofive = {
		order = 840,
		icon = BSI[1160], -- Demoralizing Shout
		tip = BS[1160] .. " +5", -- Demoralizing Shout
		callalways = false,
		code = function()
			for name,rcn in pairs(raid.classes.WARRIOR) do
				if GUIDHasTalent(rcn.guid, BS[12324]) >= 5 then -- Improved Demoralizing Shout
					rcn.specialisations.improveddemofive = true
				end
			end
		end,
	},
	improvedbattleone = {
		order = 780,
		icon = BSI[2048], -- Battle Shout
		tip = BS[2048] .. " +1", -- Battle Shout
		callalways = false,
		code = function()
			for name,rcn in pairs(raid.classes.WARRIOR) do
				if GUIDHasTalent(rcn.guid, BS[12318]) >= 1 then -- Commanding Presence
					rcn.specialisations.improvedbattleone = true
				end
			end
		end,
	},
	improvedbattletwo = {
		order = 770,
		icon = BSI[2048], -- Battle Shout
		tip = BS[2048] .. " +2", -- Battle Shout
		callalways = false,
		code = function()
			for name,rcn in pairs(raid.classes.WARRIOR) do
				if GUIDHasTalent(rcn.guid, BS[12318]) >= 2 then -- Commanding Presence
					rcn.specialisations.improvedbattletwo = true
				end
			end
		end,
	},
	improvedbattlethree = {
		order = 760,
		icon = BSI[2048], -- Battle Shout
		tip = BS[2048] .. " +3", -- Battle Shout
		callalways = false,
		code = function()
			for name,rcn in pairs(raid.classes.WARRIOR) do
				if GUIDHasTalent(rcn.guid, BS[12318]) >= 3 then -- Commanding Presence
					rcn.specialisations.improvedbattlethree = true
				end
			end
		end,
	},
	improvedbattlefour = {
		order = 750,
		icon = BSI[2048], -- Battle Shout
		tip = BS[2048] .. " +4", -- Battle Shout
		callalways = false,
		code = function()
			for name,rcn in pairs(raid.classes.WARRIOR) do
				if GUIDHasTalent(rcn.guid, BS[12318]) >= 4 then -- Commanding Presence
					rcn.specialisations.improvedbattlefour = true
				end
			end
		end,
	},
	improvedbattlefive = {
		order = 740,
		icon = BSI[2048], -- Battle Shout
		tip = BS[2048] .. " +5", -- Battle Shout
		callalways = false,
		code = function()
			for name,rcn in pairs(raid.classes.WARRIOR) do
				if GUIDHasTalent(rcn.guid, BS[12318]) >= 5 then -- Commanding Presence
					rcn.specialisations.improvedbattlefive = true
				end
			end
		end,
	},
	blessingofsanctuary = {
		order = 820,
		icon = BSI[20911], -- Blessing of Sanctuary
		tip = BS[20911], -- Blessing of Sanctuary
		callalways = true,
		code = function()
			raid.SanctuaryTalent = {}
			for name,rcn in pairs(raid.classes.PALADIN) do
				if GUIDHasTalent(rcn.guid, BS[20911]) >= 1 then -- Blessing of Sanctuary
					table.insert(raid.SanctuaryTalent, name)
					rcn.specialisations.blessingofsanctuary = true
				end
			end
		end,
	},
	auramastery = {
		order = 815,
		icon = "Interface\\Icons\\Spell_Holy_AuraMastery",
		tip = L["Has Aura Mastery"],
		callalways = false,
		code = function()
			for name,rcn in pairs(raid.classes.PALADIN) do
				if GUIDHasTalent(rcn.guid, BS[31821]) >= 1 then -- Aura Mastery
					rcn.specialisations.auramastery = true
				end
			end
		end,
	},
	improvedblessingofwisdomone = {
		order = 812,
		icon = BSI[19742], -- Blessing of Wisdom
		tip = BS[19742] .. " +1", -- Blessing of Wisdom
		callalways = true,
		code = function()
			for name,rcn in pairs(raid.classes.PALADIN) do
				if GUIDHasTalent(rcn.guid, BS[20244]) >= 1 then -- Improved Blessing of Wisdom
					rcn.specialisations.improvedblessingofwisdomone = true
					if raid.maxbowpoints < 1 then
						raid.maxbowpoints = 1
					end
				end
			end
		end,
	},
	improvedblessingofwisdomtwo = {
		order = 811,
		icon = BSI[19742], -- Blessing of Wisdom
		tip = BS[19742] .. " +2", -- Blessing of Wisdom
		callalways = true,
		code = function()
			for name,rcn in pairs(raid.classes.PALADIN) do
				if GUIDHasTalent(rcn.guid, BS[20244]) >= 2 then -- Improved Blessing of Wisdom
					rcn.specialisations.improvedblessingofwisdomtwo = true
					if raid.maxbowpoints < 2 then
						raid.maxbowpoints = 2
					end
				end
			end
		end,
	},
	improvedretributionaura = {
		order = 810,
		icon = BSI[7294], -- Retribution Aura
		tip = BS[7294] .. " +1", -- Retribution Aura
		callalways = true,
		code = function()
			for name,rcn in pairs(raid.classes.PALADIN) do
				if GUIDHasTalent(rcn.guid, BS[31869]) >= 1 then -- Sanctified Retribution
					rcn.specialisations.improvedretributionaura = true
				end
			end
		end,
	},
	improveddevotionauraone = {
		order = 810,
		icon = BSI[465], -- Devotion Aura
		tip = BS[465] .. " +1", -- Devotion Aura
		callalways = true,
		code = function()
			for name,rcn in pairs(raid.classes.PALADIN) do
				if GUIDHasTalent(rcn.guid, BS[20138]) >= 1 then -- Improved Devotion Aura
					rcn.specialisations.improveddevotionauraone = true
				end
			end
		end,
	},
	improveddevotionauratwo = {
		order = 809,
		icon = BSI[465], -- Devotion Aura
		tip = BS[465] .. " +2", -- Devotion Aura
		callalways = true,
		code = function()
			for name,rcn in pairs(raid.classes.PALADIN) do
				if GUIDHasTalent(rcn.guid, BS[20138]) >= 2 then -- Improved Devotion Aura
					rcn.specialisations.improveddevotionauratwo = true
				end
			end
		end,
	},
	improveddevotionaurathree = {
		order = 809,
		icon = BSI[465], -- Devotion Aura
		tip = BS[465] .. " +3", -- Devotion Aura
		callalways = true,
		code = function()
			for name,rcn in pairs(raid.classes.PALADIN) do
				if GUIDHasTalent(rcn.guid, BS[20138]) >= 3 then -- Improved Devotion Aura
					rcn.specialisations.improveddevotionaurathree = true
				end
			end
		end,
	},
	sacredcleansing = {
		order = 790,
		icon = BSI[53553], -- Sacred Cleansing
		tip = BS[53553], -- Sacred Cleansing
		callalways = true,
		code = function()
			for name,rcn in pairs(raid.classes.PALADIN) do
				if GUIDHasTalent(rcn.guid, BS[53553]) >= 1 then -- Sacred Cleansing
					rcn.specialisations.sacredcleansing = true
				end
			end
		end,
	},
	earthshield = {
		order = 785,
		icon = BSI[974], -- Earth Shield
		tip = BS[974], -- Earth Shield
		callalways = true,
		code = function()
			for name,rcn in pairs(raid.classes.SHAMAN) do
				if GUIDHasTalent(rcn.guid, BS[974]) >= 1 then -- Earth Shield
					rcn.specialisations.earthshield = true
				end
			end
		end,
	},
	dualwield = {
		order = 781,
		icon = "Interface\\Icons\\Ability_DualWield",
		tip = L["Dual wield"],
		callalways = true,
		code = function()
			for name,rcn in pairs(raid.classes.SHAMAN) do
				if GUIDHasTalent(rcn.guid, BS[30798]) >= 1 then -- Dual Wield
					rcn.specialisations.dualwield = true
				end
			end
		end,
	},
	focusmagic = {
		order = 780,
		icon = BSI[54646], -- Focus Magic
		tip = BS[54646], -- Focus Magic
		callalways = true,
		code = function()
			for name,rcn in pairs(raid.classes.MAGE) do
				if GUIDHasTalent(rcn.guid, BS[54646]) >= 1 then -- Focus Magic
					rcn.specialisations.focusmagic = true
				end
			end
		end,
	},
	amplifymagicone = {
		order = 775,
		icon = BS[33946], -- Amplify Magic
		tip = BS[33946] .. " +1", -- Amplify Magic
		callalways = true,
		code = function()
			for name,rcn in pairs(raid.classes.MAGE) do
				if GUIDHasTalent(rcn.guid, BS[11247]) >= 1 then -- Magic Attunement
					rcn.specialisations.amplifymagicone = true
				end
			end
		end,
	},
	amplifymagictwo = {
		order = 775,
		icon = BS[33946], -- Amplify Magic
		tip = BS[33946] .. " +2", -- Amplify Magic
		callalways = true,
		code = function()
			for name,rcn in pairs(raid.classes.MAGE) do
				if GUIDHasTalent(rcn.guid, BS[11247]) >= 2 then -- Magic Attunement
					rcn.specialisations.amplifymagictwo = true
				end
			end
		end,
	},
	boneshield = {
		order = 730,
		icon = BSI[49222], -- Bone Shield
		tip = BS[49222], -- Bone Shield
		callalways = true,
		code = function()
			for name,rcn in pairs(raid.classes.DEATHKNIGHT) do
				if GUIDHasTalent(rcn.guid, BS[49222]) >= 1 then -- Bone Shield
					rcn.specialisations.boneshield = true
				end
			end
		end,
	},
	antimagiczone = {
		order = 720,
		icon = BSI[51052], -- Anti-Magic Zone
		tip = BS[51052], -- Anti-Magic Zone
		callalways = false,
		code = function()
			for name,rcn in pairs(raid.classes.DEATHKNIGHT) do
				if GUIDHasTalent(rcn.guid, BS[51052]) >= 1 then -- Anti-Magic Zone
					rcn.specialisations.antimagiczone = true
				end
			end
		end,
	},
	ebonplaguebringerone = {
		order = 710,
		icon = BSI[51099], -- Ebon Plaguebringer
		tip = BS[51099], -- Ebon Plaguebringer
		callalways = false,
		code = function()
			for name,rcn in pairs(raid.classes.DEATHKNIGHT) do
				if GUIDHasTalent(rcn.guid, BS[51099]) >= 1 then -- Ebon Plaguebringer
					rcn.specialisations.ebonplaguebringerone = true
				end
			end
		end,
	},
	ebonplaguebringertwo = {
		order = 700,
		icon = BSI[51099], -- Ebon Plaguebringer
		tip = BS[51099] .. " +1", -- Ebon Plaguebringer
		callalways = false,
		code = function()
			for name,rcn in pairs(raid.classes.DEATHKNIGHT) do
				if GUIDHasTalent(rcn.guid, BS[51099]) >= 2 then -- Ebon Plaguebringer
					rcn.specialisations.ebonplaguebringertwo = true
				end
			end
		end,
	},
	ebonplaguebringerthree = {
		order = 690,
		icon = BSI[51099], -- Ebon Plaguebringer
		tip = BS[51099] .. " +2", -- Ebon Plaguebringer
		callalways = false,
		code = function()
			for name,rcn in pairs(raid.classes.DEATHKNIGHT) do
				if GUIDHasTalent(rcn.guid, BS[51099]) >= 3 then -- Ebon Plaguebringer
					rcn.specialisations.ebonplaguebringerthree = true
				end
			end
		end,
	},
	improvedfaeriefireone = {
		order = 680,
		icon = BSI[770], -- Faerie Fire
		tip = BS[770] .. " +1", -- Faerie Fire
		callalways = true,
		code = function()
			for name,rcn in pairs(raid.classes.DRUID) do
				if GUIDHasTalent(rcn.guid, BS[33600]) >= 1 then -- Improved Faerie Fire
					rcn.specialisations.improvedfaeriefireone = true
				end
			end
		end,
	},
	improvedfaeriefiretwo = {
		order = 670,
		icon = BSI[770], -- Faerie Fire
		tip = BS[770] .. " +2", -- Faerie Fire
		callalways = true,
		code = function()
			for name,rcn in pairs(raid.classes.DRUID) do
				if GUIDHasTalent(rcn.guid, BS[33600]) >= 2 then -- Improved Faerie Fire
					rcn.specialisations.improvedfaeriefiretwo = true
				end
			end
		end,
	},
	improvedfaeriefirethree = {
		order = 660,
		icon = BSI[770], -- Faerie Fire
		tip = BS[770] .. " +3", -- Faerie Fire
		callalways = true,
		code = function()
			for name,rcn in pairs(raid.classes.DRUID) do
				if GUIDHasTalent(rcn.guid, BS[33600]) >= 3 then -- Improved Faerie Fire
					rcn.specialisations.improvedfaeriefirethree = true
				end
			end
		end,
	},
	earthandmoonone = {
		order = 650,
		icon = BSI[48506], -- Earth and Moon
		tip = BS[48506], -- Earth and Moon
		callalways = true,
		code = function()
			for name,rcn in pairs(raid.classes.DRUID) do
				if GUIDHasTalent(rcn.guid, BS[48506]) >= 1 then -- Earth and Moon
					rcn.specialisations.earthandmoonone = true
				end
			end
		end,
	},
	earthandmoontwo = {
		order = 640,
		icon = BSI[48506], -- Earth and Moon
		tip = BS[48506] .. " +1", -- Earth and Moon
		callalways = true,
		code = function()
			for name,rcn in pairs(raid.classes.DRUID) do
				if GUIDHasTalent(rcn.guid, BS[48506]) >= 2 then -- Earth and Moon
					rcn.specialisations.earthandmoontwo = true
				end
			end
		end,
	},
	earthandmoonthree = {
		order = 630,
		icon = BSI[48506], -- Earth and Moon
		tip = BS[48506] .. " +2", -- Earth and Moon
		callalways = true,
		code = function()
			for name,rcn in pairs(raid.classes.DRUID) do
				if GUIDHasTalent(rcn.guid, BS[48506]) >= 3 then -- Earth and Moon
					rcn.specialisations.earthandmoonethree = true
				end
			end
		end,
	},
	demonicpactone = {
		order = 620,
		icon = BSI[53646], -- Demonic Pact
		tip = BS[53646], -- Demonic Pact
		callalways = true,
		code = function()
			for name,rcn in pairs(raid.classes.WARLOCK) do
				if GUIDHasTalent(rcn.guid, BS[53646]) >= 1 then -- Demonic Pact
					rcn.specialisations.demonicpactone = true
				end
			end
		end,
	},
	demonicpacttwo = {
		order = 610,
		icon = BSI[53646], -- Demonic Pact
		tip = BS[53646] .. " +1", -- Demonic Pact
		callalways = true,
		code = function()
			for name,rcn in pairs(raid.classes.WARLOCK) do
				if GUIDHasTalent(rcn.guid, BS[53646]) >= 2 then -- Demonic Pact
					rcn.specialisations.demonicpacttwo = true
				end
			end
		end,
	},
	demonicpactthree = {
		order = 600,
		icon = BSI[53646], -- Demonic Pact
		tip = BS[53646] .. " +2", -- Demonic Pact
		callalways = true,
		code = function()
			for name,rcn in pairs(raid.classes.WARLOCK) do
				if GUIDHasTalent(rcn.guid, BS[53646]) >= 3 then -- Demonic Pact
					rcn.specialisations.demonicpactthree = true
				end
			end
		end,
	},
	demonicpactfour = {
		order = 590,
		icon = BSI[53646], -- Demonic Pact
		tip = BS[53646] .. " +3", -- Demonic Pact
		callalways = true,
		code = function()
			for name,rcn in pairs(raid.classes.WARLOCK) do
				if GUIDHasTalent(rcn.guid, BS[53646]) >= 4 then -- Demonic Pact
					rcn.specialisations.demonicpactfour = true
				end
			end
		end,
	},
	demonicpactfive = {
		order = 580,
		icon = BSI[53646], -- Demonic Pact
		tip = BS[53646] .. " +4", -- Demonic Pact
		callalways = true,
		code = function()
			for name,rcn in pairs(raid.classes.WARLOCK) do
				if GUIDHasTalent(rcn.guid, BS[53646]) >= 5 then -- Demonic Pact
					rcn.specialisations.demonicpactfive = true
				end
			end
		end,
	},
	bladebarrier = {
		order = 570,
		icon = BSI[49182], -- Blade Barrier
		tip = BS[49182], -- Blade Barrier
		callalways = true,
		code = function()
			for name,rcn in pairs(raid.classes.DEATHKNIGHT) do
				if GUIDHasTalent(rcn.guid, BS[49182]) >= 1 then -- Blade Barrier
					rcn.specialisations.bladebarrier = true
				end
			end
		end,
	},
	toughness = {
		order = 560,
		icon = BSI[49042], -- Toughness
		tip = BS[49042], -- Toughness
		callalways = true,
		code = function()
			for name,rcn in pairs(raid.classes.DEATHKNIGHT) do
				if GUIDHasTalent(rcn.guid, BS[49042]) >= 1 then -- Toughness
					rcn.specialisations.toughness = true
				end
			end
		end,
	},
	anticipation = {
		order = 550,
		icon = BSI[55129], -- Anticipation
		tip = BS[55129], -- Anticipation
		callalways = true,
		code = function()
			for name,rcn in pairs(raid.classes.DEATHKNIGHT) do
				if GUIDHasTalent(rcn.guid, BS[55129]) >= 1 then -- Anticipation
					rcn.specialisations.anticipation = true
				end
			end
		end,
	},
	restorativetotemsone = {
		order = 530,
		icon = BSI[16187], -- Restorative Totems
		tip = BS[16187] .. " +1", -- Restorative Totems
		callalways = true,
		code = function()
			if raid.ClassNumbers.SHAMAN < 1 then
				raid.maxrestorativetotemspoints = 0
				return
			end
			for name,rcn in pairs(raid.classes.SHAMAN) do
				if GUIDHasTalent(rcn.guid, BS[16187]) >= 1 then -- Restorative Totems
					rcn.specialisations.restorativetotemsone = true
					if raid.maxrestorativetotemspoints < 1 then
						raid.maxrestorativetotemspoints = 1
					end
				end
			end
		end,
	},
	restorativetotemstwo = {
		order = 520,
		icon = BSI[16187], -- Restorative Totems
		tip = BS[16187] .. " +2", -- Restorative Totems
		callalways = true,
		code = function()
			for name,rcn in pairs(raid.classes.SHAMAN) do
				if GUIDHasTalent(rcn.guid, BS[16187]) >= 2 then -- Restorative Totems
					rcn.specialisations.restorativetotemstwo = true
					if raid.maxrestorativetotemspoints < 2 then
						raid.maxrestorativetotemspoints = 2
					end
				end
			end
		end,
	},
	restorativetotemsthree = {
		order = 510,
		icon = BSI[16187], -- Restorative Totems
		tip = BS[16187] .. " +3", -- Restorative Totems
		callalways = true,
		code = function()
			for name,rcn in pairs(raid.classes.SHAMAN) do
				if GUIDHasTalent(rcn.guid, BS[16187]) >= 3 then -- Restorative Totems
					rcn.specialisations.restorativetotemstwo = true
					if raid.maxrestorativetotemspoints < 3 then
						raid.maxrestorativetotemspoints = 3
					end
				end
			end
		end,
	},
}
RaidBuffStatus.SP = SP

local report = {
	checking = {},
	RaidHealth = 100,
	RaidMana = 100,
	DPSMana = 100,
	HealerMana = 100,
	TankHealth = 100,
	Alive = 100,
	TanksAlive = 100,
	HealersAlive = 100,
	raidhealthlist = {},
	raidmanalist = {},
	dpsmanalist = {},
	healermanalist = {},
	tankhealthlist = {},
	alivelist = {}, -- actually dead list
	tanksalivelist = {}, -- actually dead list
	healersalivelist = {}, -- actually dead list
}
report.reset = function()
	for reportname,_ in pairs(report) do
		if type(report[reportname]) == "number" then
			report[reportname] = 0
		elseif type(report[reportname]) == "table" then
			report[reportname] = {}
		end
	end
end
RaidBuffStatus.report = report

-- End of inits


function RaidBuffStatus:OnInitialize()
	RaidBuffStatus.profiledefaults = { profile = {
		options = {},
		TellWizard = true,
		ReportSelf = false,
		ReportChat = true,
		ReportOfficer = false,
		PrependRBS = false,
		ShowMany = true,
		WhisperMany = true,
		HowMany = 4,
		HowOften = 3,
		GoodTBC = true,
		GoodFoodOnly = true,
		TBCFlasksElixirs = false,
		ShowGroupNumber = true,
--		ShowMissingBlessing = true,
		ShortMissingBlessing = true,
		LockWindow = false,
		IgnoreLastThreeGroups = false,
		DisableInCombat = true,
		usepallypower = true,
		noppifpaladinmissing = true,
		LeftClick = "enabledisable",
		RightClick = "buff",
		ControlLeftClick = "whisper",
		ControlRightClick = "none",
		ShiftLeftClick = "report",
		ShiftRightClick = "none",
		AltLeftClick = "buff",
		AltRightClick = "none",
		onlyusetanklist = false,
		tankwarn = false,
		bossonly = false,
		failselfimmune = true,
		failsoundimmune = true,
		failrwimmune = false,
		failraidimmune = true,
		failpartyimmune = false,
		failselfresist = true,
		failsoundresist = true,
		failrwresist = false,
		failraidresist = true,
		failpartyresist = false,
		otherfailself = true,
		otherfailsound = true,
		otherfailrw = false,
		otherfailraid = false,
		otherfailparty = false,
		ninjaself = true,
		ninjasound = true,
		ninjarw = false,
		ninjaraid = false,
		ninjaparty = false,
		tauntself = true,
		tauntsound = true,
		tauntrw = false,
		tauntraid = false,
		tauntparty = false,
		tauntmeself = true,
		tauntmesound = true,
		tauntmerw = false,
		tauntmeraid = false,
		tauntmeparty = false,
		nontanktauntself = true,
		nontanktauntsound = true,
		nontanktauntrw = false,
		nontanktauntraid = false,
		nontanktauntparty = false,
		ccwarn = true,
		cconlyme = false,
		ccwarntankself = false,
		ccwarntanksound = false,
		ccwarntankrw = false,
		ccwarntankraid = false,
		ccwarntankparty = false,
		ccwarnnontankself = true,
		ccwarnnontanksound = true,
		ccwarnnontankrw = false,
		ccwarnnontankraid = false,
		ccwarnnontankparty = false,
		misdirectionwarn = false,
		misdirectionself = true,
		misdirectionsound = true,
		deathwarn = true,
		tankdeathself = true,
		tankdeathsound = true,
		tankdeathrw = false,
		tankdeathraid = false,
		tankdeathparty = false,
		rangeddpsdeathself = true,
		rangeddpsdeathsound = true,
		rangeddpsdeathrw = false,
		rangeddpsdeathraid = false,
		rangeddpsdeathparty = false,
		meleedpsdeathself = true,
		meleedpsdeathsound = true,
		meleedpsdeathrw = false,
		meleedpsdeathraid = false,
		meleedpsdeathparty = false,
		healerdeathself = true,
		healerdeathsound = true,
		healerdeathrw = false,
		healerdeathraid = false,
		healerdeathparty = false,
		RaidHealth = false,
		TankHealth = true,
		RaidMana = false,
		HealerMana = true,
		DPSMana = true,
		Alive = false,
		TanksAlive = true,
		HealersAlive = true,
		bgr = 0,
		bgg = 0,
		bgb = 0,
		bga = 0.85,
		bbr = 0,
		bbg = 0,
		bbb = 0,
		bba = 1,
		x = 0,
		y = 0,
		MiniMap = true,
		AutoShowDashParty = true,
		AutoShowDashRaid = true,
		AutoShowDashBattle = false,
		MiniMapAngle = random(0, 359),
		dashcols = 5,
		ShortenNames = false,
		HighlightMyBuffs = true,
		movewithaltclick = false,
		hidebossrtrash = false,
		Debug = false,
		fishfeast = true,
		refreshmenttable = true,
		soulwell = true,
		repair = true,
		antispam = true,
		feastautowhisper = true,
		wellautowhisper = false,
		versionannounce = true,
	}}
	local BF = RaidBuffStatus.BF
	for buffcheck, _ in pairs(BF) do
		if BF[buffcheck].list then
			report[BF[buffcheck].list] = {} -- add empty list to report
		end
		if BF[buffcheck].default then  -- if default setting for buff check is enabled
			RaidBuffStatus.profiledefaults.profile[BF[buffcheck].check] = true
		else
			RaidBuffStatus.profiledefaults.profile[BF[buffcheck].check] = false
		end
		for _, defname in ipairs({"buff", "warning", "dash", "dashcombat", "boss", "trash"}) do
			if BF[buffcheck]["default" .. defname] then
				RaidBuffStatus.profiledefaults.profile[buffcheck .. defname] = true
			else
				RaidBuffStatus.profiledefaults.profile[buffcheck .. defname] = false
			end
		end
	end
	RaidBuffStatusDefaultProfile = RaidBuffStatusDefaultProfile or {false, "Modders: In your SavedVars, replace the first argument of this table with the profile you want loaded by default, like 'Default'."}
	self.db = LibStub("AceDB-3.0"):New("RaidBuffStatusDB", RaidBuffStatus.profiledefaults, RaidBuffStatusDefaultProfile[1])
	RaidBuffStatus.optFrame = AceConfig:AddToBlizOptions("RaidBuffStatus", "RaidBuffStatus")
	self.configOptions.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	self.db.RegisterCallback(self, "OnProfileChanged", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileCopied", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileReset", "OnProfileChanged")
	GT.RegisterCallback(self, "LibGroupTalents_Update")
--	RaidBuffStatus:Debug('Init, init?')
end

-- credit for original code goes to Peragor and GridLayoutPlus
function RaidBuffStatus:oRA_MainTankUpdate()
--	RaidBuffStatus:Debug('oRA_MainTankUpdate()')
	-- oRa2 and CT raid integration: get list of unitids for configured tanks
	local tankTable = nil
	tankList = '|'
	if oRA and oRA.maintanktable then
		tankTable = oRA.maintanktable
		RaidBuffStatus:Debug('Using ora')
	elseif XPerl_MainTanks then
		tankTable = {}
		for _,v in pairs(XPerl_MainTanks) do
			tankTable[v[2]] = v[2]
		end
		RaidBuffStatus:Debug('Using xperl')
	elseif CT_RA_MainTanks then
		tankTable = CT_RA_MainTanks
		RaidBuffStatus:Debug('Using ctra')
	end
	if tankTable then
		for key, val in pairs(tankTable) do
			local unit = RaidBuffStatus:GetUnitFromName(val)
			if unit then
				local unitid = unit.unitid
				if unitid and UnitExists(unitid) and UnitPlayerOrPetInRaid(unitid) then
					tankList = tankList .. val .. '|'
				end
			end
		end
	end
end

function RaidBuffStatus:ShowReportFrame()
	if (InCombatLockdown()) then
		return
	end
	ShowUIPanel(RBSFrame)
end

function RaidBuffStatus:HideReportFrame()
	if (InCombatLockdown()) then
		return
	end
	HideUIPanel(RBSFrame)
end

function RaidBuffStatus:ToggleOptionsFrame()
	if (InCombatLockdown()) then
		return
	end
	if RaidBuffStatus.optionsframe:IsVisible() then
		HideUIPanel(RBSOptionsFrame)
	else
		RaidBuffStatus:ShowOptionsFrame()
	end
end

function RaidBuffStatus:ShowOptionsFrame()
	RaidBuffStatus:UpdateOptionsButtons()
	ShowUIPanel(RBSOptionsFrame)
end

function RaidBuffStatus:ToggleTalentsFrame()
	if RaidBuffStatus.talentframe:IsVisible() then
		HideUIPanel(RBSTalentsFrame)
	else
		RaidBuffStatus:ShowTalentsFrame()
	end
end

function RaidBuffStatus:ShowTalentsFrame()
	RaidBuffStatus:UpdateTalentsFrame()
	ShowUIPanel(RBSTalentsFrame)
end

function RaidBuffStatus:UpdateMiniMapButton()
	if RaidBuffStatus.db.profile.MiniMap then
		RBSMinimapButton:UpdatePosition()
		RBSMinimapButton:Show()
	else
		RBSMinimapButton:Hide()
	end
end

function RaidBuffStatus:UpdateTalentsFrame()
	local height = tfi.topedge + (raid.size * (tfi.rowheight + tfi.rowgap)) + tfi.okbuttonheight
	RaidBuffStatus.talentframe:SetHeight(height)
	for i = 1, tfi.maxrows do
		tfi.rowframes[i].rowframe:Hide()
	end
	if not raid.israid and not raid.isparty then
		return
	end
	for speccheck, _ in pairs(SP) do
		SP[speccheck].code()
	end
	RaidBuffStatus:GetTalentRowData()
	RaidBuffStatus:SortTalentRowData(tfi.sort, tfi.sortorder)
	RaidBuffStatus:CopyTalentRowDataToRowFrames()
	for i = 1, raid.size do
		tfi.rowframes[i].rowframe:Show()
	end
end

function RaidBuffStatus:GetTalentRowData()
	tfi.rowdata = {}
	local row = 1
	for class,_ in pairs(raid.classes) do
		for name,_ in pairs(raid.classes[class]) do
			local unit = raid.classes[class][name]
			local role = ""
			local roleicon = roleicons.UNKNOWN
			if unit.istank then
				role = L["Tank"]
				roleicon = roleicons.Tank
			elseif unit.ishealer then
				role = L["Healer"]
				roleicon = roleicons.Healer
			elseif unit.ismeleedps then
				role = L["Melee DPS"]
				roleicon = roleicons.MeleeDPS
			elseif unit.israngeddps then
				role = L["Ranged DPS"]
				roleicon = roleicons.RangedDPS
			end
			tfi.rowdata[row] = {}
			tfi.rowdata[row].name = name
			tfi.rowdata[row].class = class
			tfi.rowdata[row].role = role
			tfi.rowdata[row].roleicon = roleicon
			tfi.rowdata[row].specialisations = {}
			tfi.rowdata[row].spec = unit.spec
			tfi.rowdata[row].specicon = unit.specicon
			if unit.talents then
				for speccheck, _ in pairs(SP) do
					if unit.specialisations[speccheck] then
						table.insert(tfi.rowdata[row].specialisations, speccheck)
					end
				end
			end
			table.sort(tfi.rowdata[row].specialisations, function (a,b)
				return(SP[a].order > SP[b].order)
			end)
			row = row + 1
		end
	end
end

function RaidBuffStatus:SortTalentRowData(sort, sortorder)
	tfi.sort = sort
	tfi.sortorder = sortorder
	if sort == "name" then
		table.sort(tfi.rowdata, function (a,b)
			return (RaidBuffStatus:Compare(a.name, b.name, sortorder))
		end)
	elseif sort == "class" then
		table.sort(tfi.rowdata, function (a,b)
			if a.class == b.class then
				if a.spec == b.spec then
					return (RaidBuffStatus:Compare(a.name, b.name, sortorder))
				end
				return (RaidBuffStatus:Compare(a.spec, b.spec, sortorder))
			else
				return (RaidBuffStatus:Compare(a.class, b.class, sortorder))
			end
		end)
	elseif sort == "spec" then
		table.sort(tfi.rowdata, function (a,b)
			if a.spec == b.spec then
				return (RaidBuffStatus:Compare(a.class, b.class, sortorder))
			else
				return (RaidBuffStatus:Compare(a.spec, b.spec, sortorder))
			end
		end)
	elseif sort == "role" then
		table.sort(tfi.rowdata, function (a,b)
			if a.role == b.role then
				return (RaidBuffStatus:Compare(a.class, b.class, sortorder))
			else
				return (RaidBuffStatus:Compare(a.role, b.role, sortorder))
			end
		end)
	elseif sort == "specialisations" then
		table.sort(tfi.rowdata, function (a,b)
			if #a.specialisations == #b.specialisations then
				return (RaidBuffStatus:Compare(a.name, b.name, sortorder))
			end
			return (RaidBuffStatus:Compare(#a.specialisations, #b.specialisations, sortorder))
		end)
	end
end

function RaidBuffStatus:Compare(a, b, sortorder)
	if sortorder == 1 then
			return (a < b)
		else
			return (a > b)
	end
end

function RaidBuffStatus:CopyTalentRowDataToRowFrames()
	for i, _ in ipairs(tfi.rowdata) do
		local class = tfi.rowdata[i].class
		local name = tfi.rowdata[i].name
		local role = tfi.rowdata[i].role
		local roleicon = tfi.rowdata[i].roleicon
		local r = RAID_CLASS_COLORS[class].r
		local g = RAID_CLASS_COLORS[class].g
		local b = RAID_CLASS_COLORS[class].b
		tfi.rowframes[i].name:SetText(name)
		tfi.rowframes[i].name:SetTextColor(r,g,b)
		tfi.rowframes[i].class:SetNormalTexture(classicons[class] or classicons.UNKNOWN)
		tfi.rowframes[i].class:SetScript("OnEnter", function() 
			RaidBuffStatus:Tooltip(tfi.rowframes[i].class, LOCALIZED_CLASS_NAMES_MALE[class], nil)
		end )
		tfi.rowframes[i].class:SetScript("OnLeave", function()
			GameTooltip:Hide()
		end)
		tfi.rowframes[i].role:SetNormalTexture(roleicon)
		tfi.rowframes[i].role:SetScript("OnEnter", function() 
			RaidBuffStatus:Tooltip(tfi.rowframes[i].role, role, nil)
		end )
		tfi.rowframes[i].role:SetScript("OnLeave", function()
			GameTooltip:Hide()
		end)
		if raid.classes[class][name].talents then
			local spec = raid.classes[class][name].spec
			local specicon = raid.classes[class][name].specicon
			tfi.rowframes[i].spec:SetScript("OnEnter", function()
				RaidBuffStatus:Tooltip(tfi.rowframes[i].spec, spec)
			end )
			tfi.rowframes[i].spec:SetScript("OnLeave", function()
				GameTooltip:Hide()
			end)
			if spec == "Hybrid" then
				tfi.rowframes[i].spec:SetNormalTexture(specicons.Hybrid)
			else
				tfi.rowframes[i].spec:SetNormalTexture(specicon or specicons.UNKNOWN)
			end
		else
			tfi.rowframes[i].spec:SetNormalTexture(specicons.UNKNOWN)
			tfi.rowframes[i].spec:SetScript("OnEnter", function()
				RaidBuffStatus:Tooltip(tfi.rowframes[i].spec, "Unknown")
			end )
			tfi.rowframes[i].spec:SetScript("OnLeave", function()
				GameTooltip:Hide()
			end)
		end
		for j, v in ipairs (tfi.rowframes[i].specialisations) do
			v:Hide()
			local speccheck = tfi.rowdata[i].specialisations[j]
			if speccheck then
				v:SetNormalTexture(SP[speccheck].icon)
				v:SetScript("OnEnter", function()
					RaidBuffStatus:Tooltip(v, SP[speccheck].tip)
				end )
				v:SetScript("OnLeave", function()
					GameTooltip:Hide()
				end)
				v:Show()
			end
		end
	end
end

function RaidBuffStatus:DoReport(force)
	if not force then
		if nextscan > GetTime() then
			return  -- ensure we don't get called many times a second
		end
		if incombat and RaidBuffStatus.db.profile.DisableInCombat then
			return  -- no buff checking in combat
		end
		if raid.isbattle and not RaidBuffStatus.db.profile.AutoShowDashBattle then
			return -- no buff checking in battlegrounds
		end
	end
	nextscan = GetTime() + 1
	if xperltankrequest then
		if GetTime() > xperltankrequestt then
			RaidBuffStatus:oRA_MainTankUpdate()
			xperltankrequest = false
		end
	end

	report:reset()
	RaidBuffStatus:ReadRaid()
	RaidBuffStatus:CleanPPAssignments()
	if (not raid.israid) and (not raid.isparty) and (not raid.isbattle) then
		RaidBuffStatus:UpdateButtons()
		return
	end
	RaidBuffStatus:CalculateReport()
	RaidBuffStatus:UpdateButtons()
	if RaidBuffStatus.talentframe:IsVisible() then
		RaidBuffStatus:UpdateTalentsFrame()
	end
	if RaidBuffStatus.tooltipupdate then
		RaidBuffStatus:tooltipupdate()
	end
	playerid = UnitGUID("player") -- this never changes but on logging in it may take time before it returns a value
	playername = UnitName("player") -- ditto
	_, playerclass = UnitClass("player") -- ditto
	if raid.israid and not incombat then
		if report.checking.durabilty and GetTime() > nextdurability then
			if #report.durabilitylist > 0 then
				nextdurability = GetTime() + 30 -- check more often if someone is broken
			else
				nextdurability = GetTime() + 60 * 5
			end
			SendAddonMessage("CTRA", "DURC", "RAID")
		end
		if GetTime() > nextitemcheck  then
			for itemcheck, _ in pairs(RaidBuffStatus.itemcheck) do
				if report.checking[RaidBuffStatus.itemcheck[itemcheck].check] and GetTime() > RaidBuffStatus.itemcheck[itemcheck].next then
					nextitemcheck = GetTime() + 3
--					RaidBuffStatus:Debug("Item:" .. RaidBuffStatus.itemcheck[itemcheck].item)
					SendAddonMessage("CTRA", "ITMC " .. RaidBuffStatus.itemcheck[itemcheck].item, "RAID")
					if #report[RaidBuffStatus.itemcheck[itemcheck].list] >= RaidBuffStatus.itemcheck[itemcheck].min then
						RaidBuffStatus.itemcheck[itemcheck].next = GetTime() + RaidBuffStatus.itemcheck[itemcheck].frequencymissing
					else
						RaidBuffStatus.itemcheck[itemcheck].next = GetTime() + RaidBuffStatus.itemcheck[itemcheck].frequency
					end
					break
				end
			end
		end
	end

end

function RaidBuffStatus:CalculateReport()
	local BF = RaidBuffStatus.BF
	-- PRE HERE
	for buffcheck, _ in pairs(BF) do
		if BF[buffcheck].pre then
			if RaidBuffStatus.db.profile[BF[buffcheck].check] then
				if (not incombat) or (incombat and RaidBuffStatus.db.profile[buffcheck .. "dashcombat"]) then
					BF[buffcheck].pre(self, raid, report)
				end
			end
		end
	end

	-- MAIN HERE
	local thiszone = GetRealZoneText()
	local maxspecage = GetTime() - 60 * 2
	local healthcount = 0
	local health = 0
	local manacount = 0
	local mana = 0
	local tankhealthcount = 0
	local tankhealth = 0
	local healermanacount = 0
	local healermana = 0
	local dpsmanacount = 0
	local dpsmana = 0
	local alivecount = 0
	local alive = 0
	local tanksalivecount = 0
	local tanksalive = 0
	local healersalivecount = 0
	local healersalive = 0
	for class,_ in pairs(raid.classes) do
		for name,_ in pairs(raid.classes[class]) do
			local unit = raid.classes[class][name]
			if unit.online then
				local zonedin = true
				if raid.israid then
					if thiszone ~= unit.zone then
						zonedin = false
						if RaidBuffStatus.db.profile.checkzone then
							table.insert(report.zonelist, name)
						end
					end
				end

				for buffcheck, _ in pairs(BF) do
					if RaidBuffStatus.db.profile[BF[buffcheck].check] then
						if zonedin or BF[buffcheck].checkzonedout then
							if (not incombat) or (incombat and RaidBuffStatus.db.profile[buffcheck .. "dashcombat"]) then
								if BF[buffcheck].main then
									BF[buffcheck].main(self, name, class, unit, raid, report)
								end
							end
						end
					end
				end
				if zonedin then
					alivecount = alivecount + 1
					if unit.isdead then
						report.alivelist[name] = L["Dead"]
						if unit.istank then
							report.tanksalivelist[name] = L["Dead"]
							tanksalivecount = tanksalivecount + 1
						elseif unit.ishealer then
							report.healersalivelist[name] = L["Dead"]
							healersalivecount = healersalivecount + 1
						end
					else
						alive = alive + 1
						local h = math.floor(UnitHealth(unit.unitid)/UnitHealthMax(unit.unitid)*100)
						local m = math.floor(UnitMana(unit.unitid)/UnitManaMax(unit.unitid)*100)                                                                                                                                      
						health = health + h
						healthcount = healthcount + 1
						if h < 100 then
							report.raidhealthlist[name] = h
						end
						if unit.hasmana then
							mana = mana + m
							manacount = manacount + 1
							if m < 100 then
								report.raidmanalist[name] = m
							end
						end
						if unit.istank then
							tankhealth = tankhealth + h
							tankhealthcount = tankhealthcount + 1
							if h < 100 then
								report.tankhealthlist[name] = h
							end
							tanksalivecount = tanksalivecount + 1
							tanksalive = tanksalive + 1
						end
						if unit.ishealer then  -- all healers have mana
							healermana = healermana + m
							healermanacount = healermanacount + 1
							if m < 100 then
								report.healermanalist[name] = m
							end
							healersalivecount = healersalivecount + 1
							healersalive = healersalive + 1
						end
						if unit.hasmana and unit.isdps then
							dpsmana = dpsmana + m
							dpsmanacount = dpsmanacount + 1
							if m < 100 then
								report.dpsmanalist[name] = m
							end
						end
					end
				end
			else
				if RaidBuffStatus.db.profile.checkoffline then
					table.insert(report.offlinelist, name)  -- used by offline warning check
				end
			end
		end
	end

	if health < 1 then
		report.RaidHealth = 0
	else
		report.RaidHealth = math.floor(health / healthcount)
	end

	if manacount < 1 then
		report.RaidMana = L["n/a"]
	elseif mana < 1 then
		report.RaidMana = 0
	else
		report.RaidMana = math.floor(mana / manacount)
	end

	if tankhealthcount < 1 then
		report.TankHealth = L["n/a"]
	elseif tankhealth < 1 then
		report.TankHealth = 0
	else
		report.TankHealth = math.floor(tankhealth / tankhealthcount)
	end

	if healermanacount < 1 then
		report.HealerMana = L["n/a"]
	elseif healermana < 1 then
		report.HealerMana = 0
	else
		report.HealerMana = math.floor(healermana / healermanacount)
	end

	if dpsmanacount < 1 then
		report.DPSMana = L["n/a"]
	elseif dpsmana < 1 then
		report.DPSMana = 0
	else
		report.DPSMana = math.floor(dpsmana / dpsmanacount)
	end

	if alivecount < 1 then -- yes there may be no one in the raid for short time until they appear
		report.Alive = L["n/a"]
	else
		report.Alive = math.floor(alive / alivecount * 100)
	end
	
	if tanksalivecount < 1 then
		report.TanksAlive = L["n/a"]
	else
		report.TanksAlive = math.floor(tanksalive / tanksalivecount * 100)
	end
	if healersalivecount < 1 then
		report.HealersAlive = L["n/a"]
	else
		report.HealersAlive = math.floor(healersalive / healersalivecount * 100)
	end

	-- do timers
	local thetimenow = math.floor(GetTime())
	for buffcheck, _ in pairs(BF) do
		if BF[buffcheck].timer then
			if not raid.BuffTimers[buffcheck .. "timerlist"] then
				raid.BuffTimers[buffcheck .. "timerlist"] = {}
			end
			for _, v in ipairs(report[BF[buffcheck].list]) do  -- first add those on the list to the timer list if not there
				local missing = true
				for n, t in pairs(raid.BuffTimers[buffcheck .. "timerlist"]) do
					if v == n then
						missing = false
						break
					end
				end
				if missing then
					raid.BuffTimers[buffcheck .. "timerlist"][v] = thetimenow
				end
			end
			for n, t in pairs(raid.BuffTimers[buffcheck .. "timerlist"]) do -- now remove those who are no longer on the list
				local missing = true
				for _, v in ipairs(report[BF[buffcheck].list]) do
					if v == n then
						missing = false
						break
					end
				end
				if missing then
					raid.BuffTimers[buffcheck .. "timerlist"][n] = nil
				end
			end
		end
	end

	-- sort names
	for buffcheck, _ in pairs(BF) do
		if # report[BF[buffcheck].list] > 1 then
			table.sort(report[BF[buffcheck].list])
		end
	end

	-- POST HERE
	for buffcheck, _ in pairs(BF) do
		if BF[buffcheck].post then
			if RaidBuffStatus.db.profile[BF[buffcheck].check] and report.checking[buffcheck] then
				if (not incombat) or (incombat and RaidBuffStatus.db.profile[buffcheck .. "dashcombat"]) then
					BF[buffcheck].post(self, raid, report)
				end
			end
		end
	end
end

function RaidBuffStatus:ReportToChat(boss, channel)
	local BF = RaidBuffStatus.BF
	local warnings = 0
	local buffs = 0
	local canspeak = IsRaidLeader() or IsRaidOfficer() or raid.pug
	if not canspeak and RaidBuffStatus.db.profile.ReportChat and raid.israid then
		RaidBuffStatus:OfficerWarning()
	end
	for buffcheck, _ in pairs(BF) do
		if # report[BF[buffcheck].list] > 0 then
			if (boss and RaidBuffStatus.db.profile[buffcheck .. "boss"]) or ((not boss) and RaidBuffStatus.db.profile[buffcheck .. "trash"]) then
				if RaidBuffStatus.db.profile[buffcheck .. "warning"] then
					warnings = warnings + # report[BF[buffcheck].list]
				end
				if RaidBuffStatus.db.profile[buffcheck .. "buff"] then
					buffs = buffs + # report[BF[buffcheck].list]
				end
			end
		end
	end
	if warnings > 0 then
		RaidBuffStatus:Say(L["Warnings: "] .. warnings, nil, true, channel)
		for buffcheck, _ in pairs(BF) do
			if # report[BF[buffcheck].list] > 0 then
				if (boss and RaidBuffStatus.db.profile[buffcheck .. "boss"] ) or ((not boss) and RaidBuffStatus.db.profile[buffcheck .. "trash"]) then
					if RaidBuffStatus.db.profile[buffcheck .. "warning"] then
						if type(BF[buffcheck].chat) == "string" then
							if BF[buffcheck].timer then
								local timerlist = {}
								for _, n in ipairs(report[BF[buffcheck].list]) do
									if raid.BuffTimers[buffcheck .. "timerlist"][n] then
										table.insert(timerlist, n .. "(" .. RaidBuffStatus:TimeSince(raid.BuffTimers[buffcheck .. "timerlist"][n]) .. ")")
									else
										table.insert(timerlist, n)
									end
								end
								RaidBuffStatus:Say("<" .. BF[buffcheck].chat .. ">: " .. table.concat(timerlist, ", "), nil, nil, channel)
							else
								if RaidBuffStatus.db.profile.ShowMany and BF[buffcheck].raidbuff and #report[BF[buffcheck].list] >= RaidBuffStatus.db.profile.HowMany then
									RaidBuffStatus:Say("<" .. BF[buffcheck].chat .. ">: " .. L["MANY!"], nil, nil, channel)
								else
									RaidBuffStatus:Say("<" .. BF[buffcheck].chat .. ">: " .. table.concat(report[BF[buffcheck].list], ", "), nil, nil, channel)
								end
							end
						elseif type(BF[buffcheck].chat) == "function" then
							BF[buffcheck].chat(report, raid, nil, channel)
						end
					end
				end
			end
		end
	end
	if buffs > 0 then
		if boss then
			RaidBuffStatus:Say(L["Missing buffs (Boss): "] .. buffs, nil, true, channel)
		else
			RaidBuffStatus:Say(L["Missing buffs (Trash): "] .. buffs, nil, true, channel)
		end
		for buffcheck, _ in pairs(BF) do
			if # report[BF[buffcheck].list] > 0 then
				if (boss and RaidBuffStatus.db.profile[buffcheck .. "boss"] ) or ((not boss) and RaidBuffStatus.db.profile[buffcheck .. "trash"]) then
					if RaidBuffStatus.db.profile[buffcheck .. "buff"] then
						if type(BF[buffcheck].chat) == "string" then
							if RaidBuffStatus.db.profile.ShowMany and BF[buffcheck].raidbuff and #report[BF[buffcheck].list] >= RaidBuffStatus.db.profile.HowMany then
								RaidBuffStatus:Say("<" .. BF[buffcheck].chat .. ">: " .. L["MANY!"], nil, nil, channel)
							else
								RaidBuffStatus:Say("<" .. BF[buffcheck].chat .. ">: " .. table.concat(report[BF[buffcheck].list], ", "), nil, nil, channel)
							end
						elseif type(BF[buffcheck].chat) == "function" then
							BF[buffcheck].chat(report, raid)
						end
					end
				end
			end
		end
	else
		if boss then
			RaidBuffStatus:Say(L["No buffs needed! (Boss)"], nil, true, channel)
		else
			RaidBuffStatus:Say(L["No buffs needed! (Trash)"], nil, true, channel)
		end
	end
end

function RaidBuffStatus:ReportToWhisper(boss)
	local BF = RaidBuffStatus.BF
	local prefix
	for buffcheck, _ in pairs(BF) do
		if # report[BF[buffcheck].list] > 0 then
			if (boss and RaidBuffStatus.db.profile[buffcheck .. "boss"]) or ((not boss) and RaidBuffStatus.db.profile[buffcheck .. "trash"]) then
				if RaidBuffStatus.db.profile[buffcheck .. "buff"] then
					prefix = L["Missing buff: "]
				else
					prefix = L["Warning: "]
				end
				RaidBuffStatus:WhisperBuff(BF[buffcheck], report, raid, prefix)
			end
		end
	end
end



function RaidBuffStatus:ReadRaid()
	raid.readid = raid.readid + 1
	raid.TankList = {}
	raid.ManaList = {}
	raid.DPSList = {}
	raid.HealerList = {}
	raid.maxrestorativetotemspoints = 0
	raid.maxbowpoints = 0
	for _,class in ipairs(classes) do
		raid.ClassNumbers[class] = 0
	end
	local raidnum = GetNumRaidMembers()
	local partynum = GetNumPartyMembers()
--	RaidBuffStatus:Debug("tankList:" .. tankList)
	if raidnum < 2 then
		if partynum < 1 then
			raid.reset()
			return
		else
			raid.isparty = true
			raid.israid = false
			raid.size = partynum + 1
			for i = 1, partynum do
				RaidBuffStatus:ReadUnit("party" .. i, i)
			end
			RaidBuffStatus:ReadUnit("player", partynum + 1)
		end
	else
		if raid.isparty then -- Party has converted to Raid!
			if RaidBuffStatus.db.profile.AutoShowDashRaid then
				RaidBuffStatus:ShowReportFrame()
			end
			RaidBuffStatus:TriggerXPerlTankUpdate()
			raid.reset()
			for _,class in ipairs(classes) do
				raid.ClassNumbers[class] = 0
			end
		end
		raid.isparty = false
		raid.israid = true
		raid.size = raidnum
		local it = select(2, IsInInstance())
		raid.isbattle = (it == "pvp") or (it == "arena")

		for i = 1, raidnum do
			RaidBuffStatus:ReadUnit("raid" .. i, i)
		end
	end
	RaidBuffStatus:DeleteOldUnits()
	for speccheck, _ in pairs(SP) do
		if SP[speccheck].callalways then
			SP[speccheck].code()
		end
	end
	if raid.israid then
		local minguildies = 0.75 * raidnum
		raid.pug = true
		for _,v in pairs(raid.guilds) do
			if v > minguildies then
				raid.pug = false
				break
			end
		end
	end
end


-- raid = { classes = { CLASS = { NAME = { readid, unitid, guid, group, zone, online, isdead, istank, hasmana, isdps, ishealer, class, talents = {spec, tree = { talent = {}}}, hasbuff = {}
function RaidBuffStatus:ReadUnit(unitid, unitindex)
	if not UnitExists(unitid) then
		return
	end
	local wellfed = GetSpellInfo(35272)-- Well Fed
	local name = UnitName(unitid)
	if name and name ~= UNKNOWNOBJECT and name ~= UKNOWNBEING then

		local class = select(2, UnitClass(unitid))
		local guid = UnitGUID(unitid) or 0
		local isDead = UnitIsDeadOrGhost(unitid) or false
		local rank = 0
		local subgroup = 1
		local online = UnitIsConnected(unitid)
		local role = ""
		local zone = "UNKNOWN"
		local nametwo = name
		local isML = false
		local istank = false
		local hasmana = false
		local isdps = false
		local ismeleedps = false
		local israngeddps = false
		local ishealer = false
		local level = UnitLevel(unitid)
		local hasbuff = {}
		local guild = GetGuildInfo(unitid)
		if guild then
			if not raid.guilds[guild] then
				raid.guilds[guild] = 1
			else
				raid.guilds[guild] = raid.guilds[guild] + 1
			end
		end
		if raid.israid then
			nametwo, rank, subgroup, _, _, _, zone, _, _, role, isML = GetRaidRosterInfo(unitindex)
		end
		if RaidBuffStatus.db.profile.IgnoreLastThreeGroups then
			if subgroup > 5 then
				raid.size = raid.size - 1
				return
			end
		end
		if raid.classes[class][name] == nil then
			raid.classes[class][name] = {}
		end
		raid.ClassNumbers[class] = raid.ClassNumbers[class] + 1
		local rcn = raid.classes[class][name]
		if not rcn.specialisations then
			rcn.specialisations = {}
		end
		RaidBuffStatus:UpdateSpec(rcn, GT:GetGUIDTalentSpec(guid))

		for b = 1, 32 do
			local buffName = UnitBuff(unitid, b)
			if buffName then
				if buffName == wellfed then
					RBSToolScanner:ClearLines()
					RBSToolScanner:SetUnitBuff(unitid, b)
					hasbuff["foodz"] = getglobal('RBSToolScannerTextLeft2'):GetText()
				end
				hasbuff[buffName] = true
			else
				break
			end
		end
		if raid.israid and (tankList ~= '|' or role == "MAINTANK") then
			if (string.find(tankList, '|' .. name .. '|')) or role == "MAINTANK" then
				if class ~= "PRIEST" and class ~= "ROGUE" then
					if not RaidBuffStatus.db.profile.onlyusetanklist then
						if class == "PALADIN" then
							if hasbuff[BS[25780]] then -- Righteous Fury
								istank = true
							elseif raid.classes.PALADIN[name].spec == L["Protection"] then
								istank = true
							end
						elseif class == "WARRIOR" then
							if raid.classes.WARRIOR[name].spec == L["Protection"] then
								istank = true
							end
						elseif class == "DRUID" then
							local powerType = UnitPowerType(unitid) or -1
							if powerType == 1 then -- bear form
								istank = true
							elseif GUIDHasTalent(raid.classes.DRUID[name].guid, BS[33853]) >= 3 and GUIDHasTalent(raid.classes.DRUID[name].guid, BS[57873]) >= 3 then -- Survival of the Fittest AND Protector of the Pack
								istank = true
							end
						elseif class == "DEATHKNIGHT" then
							if raid.classes.DEATHKNIGHT[name].specialisations.bladebarrier and raid.classes.DEATHKNIGHT[name].specialisations.toughness and raid.classes.DEATHKNIGHT[name].specialisations.anticipation then
								istank = true
							end
						else
							istank = true
						end
					else
						istank = true
					end
				end
			end
		else
			if class == "PALADIN" then
				if hasbuff[BS[25780]] then -- Righteous Fury
					istank = true
				elseif raid.classes.PALADIN[name].spec == L["Protection"] then
					istank = true
				end
			elseif class == "WARRIOR" then
				if raid.classes.WARRIOR[name].spec == L["Protection"] then
					istank = true
				end
			elseif class == "DRUID" then
				local powerType = UnitPowerType(unitid) or -1
				if powerType == 1 then -- bear form
					istank = true
				elseif GUIDHasTalent(raid.classes.DRUID[name].guid, BS[33853]) >= 3 and GUIDHasTalent(raid.classes.DRUID[name].guid, BS[57873]) >= 3 then -- Survival of the Fittest AND Protector of the Pack
					istank = true
				end
			elseif class == "DEATHKNIGHT" then
				if raid.classes.DEATHKNIGHT[name].specialisations.bladebarrier and raid.classes.DEATHKNIGHT[name].specialisations.toughness and raid.classes.DEATHKNIGHT[name].specialisations.anticipation then
					istank = true
				end
			end
		end

		if class == "PRIEST" or class == "PALADIN" or class == "HUNTER" or class == "MAGE" or class == "WARLOCK" or class == "SHAMAN" then
			hasmana = true
		elseif class == "DRUID" then
			if raid.classes.DRUID[name].spec ~= L["Feral Combat"] then
				hasmana = true
			end
		end
		if class == "PRIEST" then
			if raid.classes.PRIEST[name].spec ~= L["Shadow"] then
				ishealer = true
			end
		elseif class == "PALADIN" then
			if raid.classes.PALADIN[name].spec == L["Holy"] then
				ishealer = true
			end
		elseif class == "DRUID" then
			if raid.classes.DRUID[name].spec == L["Restoration"] then
				ishealer = true
			end
		elseif class == "SHAMAN" then
			if raid.classes.SHAMAN[name].spec == L["Restoration"] then
				ishealer = true
			end
		end

		if class == "HUNTER" or class == "MAGE" or class == "WARLOCK" then
			isdps = true
			israngeddps = true
		elseif class == "ROGUE" then
			isdps = true
			ismeleedps = true
		elseif class == "DRUID" then
			if not ishealer and not istank and raid.classes.DRUID[name].talents then
				isdps = true
				if raid.classes.DRUID[name].spec == L["Feral Combat"] then
					ismeleedps = true
				else
					israngeddps = true
				end
			end
		elseif class == "PALADIN" then
			if not ishealer and not istank and raid.classes.PALADIN[name].talents then
				isdps = true
				ismeleedps = true
			end
		elseif class == "SHAMAN" then
			if not ishealer then
				if raid.classes.SHAMAN[name].talents then
					isdps = true
					if raid.classes.SHAMAN[name].spec == L["Enhancement"] then
						ismeleedps = true
					else
						israngeddps = true
					end
				end
			end
		elseif class == "PRIEST" then
			if not ishealer and raid.classes.PRIEST[name].talents then
				isdps = true
				israngeddps = true
			end
		elseif class == "DEATHKNIGHT" then
			if not istank and raid.classes.DEATHKNIGHT[name].talents then
				isdps = true
				ismeleedps = true
			end
		elseif class == "WARRIOR" then
			if not istank and raid.classes.WARRIOR[name].talents then
				isdps = true
				ismeleedps = true
			end
		end

		if istank then
			table.insert(raid.TankList, name)
		end
		if hasmana then
			table.insert(raid.ManaList, name)
		end
		if isdps then
			table.insert(raid.DPSList, name)
		end
		if ishealer then
			table.insert(raid.HealerList, name)
		end
		
		rcn.readid = raid.readid
		rcn.unitid = unitid
		rcn.guid = guid
		rcn.group = subgroup
		rcn.zone = zone
		rcn.online = online
		rcn.isdead = isDead
		rcn.role = role
		rcn.rank = rank
		rcn.istank = istank
		rcn.hasmana = hasmana
		rcn.isdps = isdps
		rcn.ismeleedps = ismeleedps
		rcn.israngeddps = israngeddps
		rcn.ishealer = ishealer
		rcn.class = class
		rcn.level = level
		rcn.hasbuff = hasbuff
		rcn.guild = guild
		rcn.name = name
	end
end

function RaidBuffStatus:DeleteOldUnits()
	for class,_ in pairs(raid.classes) do
		for name,_ in pairs(raid.classes[class]) do
			if raid.classes[class][name].readid < raid.readid then
				raid.classes[class][name] = nil
			end
		end
	end
end


function RaidBuffStatus:Say(msg, player, prepend, channel)
	if not msg then
		msg = "nil"
	end
	local pre = ""
	if prepend or RaidBuffStatus.db.profile.PrependRBS then
		pre = "RBS::"
	end
	local str = pre
	local canspeak = IsRaidLeader() or IsRaidOfficer() or raid.pug
	for _,s in pairs({strsplit(" ", msg)}) do
		if #str + #s >= 150 then
			if player then
				SendChatMessage(str, "WHISPER", nil, player)
			else
				if channel then
					SendChatMessage(str, channel)
				else
					if RaidBuffStatus.db.profile.ReportChat and raid.isparty and not raid.isbattle then SendChatMessage(str, "party") end
					if RaidBuffStatus.db.profile.ReportChat and raid.israid and canspeak and not raid.isbattle then SendChatMessage(str, "raid") end
					if RaidBuffStatus.db.profile.ReportSelf then RaidBuffStatus:Print(str) end
					if RaidBuffStatus.db.profile.ReportOfficer then SendChatMessage(str, "officer") end
				end
			end
			str = pre
		end
		str = str .. " " .. s
	end
	if player then
		SendChatMessage(str, "WHISPER", nil, player)
	else
		if channel then
			SendChatMessage(str, channel)
		else
			if RaidBuffStatus.db.profile.ReportChat and raid.isparty and not raid.isbattle then SendChatMessage(str, "party") end
			if RaidBuffStatus.db.profile.ReportChat and raid.israid and canspeak and not raid.isbattle then SendChatMessage(str, "raid") end
			if RaidBuffStatus.db.profile.ReportSelf then RaidBuffStatus:Print(str) end
			if RaidBuffStatus.db.profile.ReportOfficer then SendChatMessage(str, "officer") end
		end
	end
end

function RaidBuffStatus:Debug(msg)
	if not RaidBuffStatus.db.profile.Debug then
		return
	end
	local str = "RBS::"
	for _,s in pairs({strsplit(" ", msg)}) do
		if #str + #s >= 250 then
			RaidBuffStatus:Print(str)
			str = "RBS::"
		end
		str = str .. " " .. s
	end
	RaidBuffStatus:Print(str)
end


function RaidBuffStatus:DicSize(dic) -- is there really no built-in function to do this??
	local i = 0
	for _,_ in pairs(dic) do
		i = i + 1
	end
	return i
end

function RaidBuffStatus:OnProfileChanged()
	RaidBuffStatus:LoadFramePosition()
	RaidBuffStatus:AddBuffButtons()
	RaidBuffStatus:SetFrameColours()
end

function RaidBuffStatus:SetFrameColours()
	RaidBuffStatus.frame:SetBackdropBorderColor(RaidBuffStatus.db.profile.bbr, RaidBuffStatus.db.profile.bbg, RaidBuffStatus.db.profile.bbb, RaidBuffStatus.db.profile.bba)
	RaidBuffStatus.frame:SetBackdropColor(RaidBuffStatus.db.profile.bgr, RaidBuffStatus.db.profile.bgg, RaidBuffStatus.db.profile.bgb, RaidBuffStatus.db.profile.bga)
	RaidBuffStatus.talentframe:SetBackdropBorderColor(RaidBuffStatus.db.profile.bbr, RaidBuffStatus.db.profile.bbg, RaidBuffStatus.db.profile.bbb, RaidBuffStatus.db.profile.bba)
	RaidBuffStatus.talentframe:SetBackdropColor(RaidBuffStatus.db.profile.bgr, RaidBuffStatus.db.profile.bgg, RaidBuffStatus.db.profile.bgb, RaidBuffStatus.db.profile.bga)
	RaidBuffStatus.optionsframe:SetBackdropBorderColor(RaidBuffStatus.db.profile.bbr, RaidBuffStatus.db.profile.bbg, RaidBuffStatus.db.profile.bbb, RaidBuffStatus.db.profile.bba)
	RaidBuffStatus.optionsframe:SetBackdropColor(RaidBuffStatus.db.profile.bgr, RaidBuffStatus.db.profile.bgg, RaidBuffStatus.db.profile.bgb, RaidBuffStatus.db.profile.bga)
end

function RaidBuffStatus:SetupFrames()
	-- main frame
	RaidBuffStatus.frame = CreateFrame("Frame", "RBSFrame", UIParent)
	RaidBuffStatus.frame:Hide()
	RaidBuffStatus.frame:EnableMouse(true)
	RaidBuffStatus.frame:SetFrameStrata("MEDIUM")
	RaidBuffStatus.frame:SetMovable(true)
	RaidBuffStatus.frame:SetToplevel(true)
	RaidBuffStatus.frame:SetWidth(128)
	RaidBuffStatus.frame:SetHeight(190)
	RaidBuffStatus.rbsfs = RaidBuffStatus.frame:CreateFontString("$parentTitle","ARTWORK","GameFontNormal")
	RaidBuffStatus.rbsfs:SetText("RBS " .. RaidBuffStatus.version)
	RaidBuffStatus.rbsfs:SetPoint("TOP",0,-5)
	RaidBuffStatus.rbsfs:SetTextColor(.9,0,0)
	RaidBuffStatus.rbsfs:Show()
	RaidBuffStatus.frame:SetBackdrop( { 
		bgFile = "Interface\\Buttons\\WHITE8X8",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, 
		insets = { left = 5, right = 5, top = 5, bottom = 5 }
	})
	RaidBuffStatus.frame:ClearAllPoints()
	RaidBuffStatus.frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	RaidBuffStatus.frame:SetScript("OnMouseDown",function()
		if ( arg1 == "LeftButton" ) then
			if not RaidBuffStatus.db.profile.LockWindow then
				if not RaidBuffStatus.db.profile.movewithaltclick or (RaidBuffStatus.db.profile.movewithaltclick and IsAltKeyDown()) then
					this:StartMoving()
				end
			end
		end
	end)
	RaidBuffStatus.frame:SetScript("OnMouseUp",function()
		if ( arg1 == "LeftButton" ) then
			this:StopMovingOrSizing()
			RaidBuffStatus:SaveFramePosition()
		end
	end)
	RaidBuffStatus.frame:SetScript("OnHide",function() this:StopMovingOrSizing() end)
	RaidBuffStatus.frame:SetClampedToScreen(true)
	RaidBuffStatus:LoadFramePosition()

	RaidBuffStatus.bossbutton = CreateFrame("Button", "", RaidBuffStatus.frame, "OptionsButtonTemplate")
	RaidBuffStatus.bossbutton:SetText(L["Boss"])
	RaidBuffStatus.bossbutton:SetWidth(45)
	RaidBuffStatus.bossbutton:SetPoint("BOTTOMLEFT", RaidBuffStatus.frame, "BOTTOMLEFT", 7, 5)
	RaidBuffStatus.bossbutton:SetScript("OnClick", function() RaidBuffStatus:DoReport()
		if IsControlKeyDown() then
			RaidBuffStatus:ReportToWhisper(true)
		else
			if IsShiftKeyDown() then
				RaidBuffStatus:ReportToChat(true, "officer")
			else
				RaidBuffStatus:ReportToChat(true)
			end
		end
	end)
	RaidBuffStatus.bossbutton:Show()

	RaidBuffStatus.button = CreateFrame("Button", "", RaidBuffStatus.frame, "OptionsButtonTemplate")
	RaidBuffStatus.button:SetText(L["Trash"])
	RaidBuffStatus.button:SetWidth(45)
	RaidBuffStatus.button:SetPoint("BOTTOMRIGHT", RaidBuffStatus.frame, "BOTTOMRIGHT", -7, 5)
	RaidBuffStatus.button:SetScript("OnClick", function() RaidBuffStatus:DoReport()
		if IsControlKeyDown() then
			RaidBuffStatus:ReportToWhisper(false)
		else
			if IsShiftKeyDown() then
				RaidBuffStatus:ReportToChat(false, "officer")
			else
				RaidBuffStatus:ReportToChat(false)
			end
		end
	end)
	RaidBuffStatus.button:Show()
	RaidBuffStatus.trashbutton = RaidBuffStatus.button
	RaidBuffStatus.button = CreateFrame("Button", "", RaidBuffStatus.frame, "OptionsButtonTemplate")
	RaidBuffStatus.button:SetText(L["R"])
	RaidBuffStatus.button:SetWidth(22)
	RaidBuffStatus.button:SetPoint("BOTTOM", RaidBuffStatus.frame, "BOTTOM", 0, 5)
	RaidBuffStatus.button:SetScript("OnClick", function()
		if IsRaidLeader() or IsRaidOfficer() then
			DoReadyCheck()
		else
			RaidBuffStatus:OfficerWarning()
		end
	end)
	RaidBuffStatus.button:Show()
	RaidBuffStatus.readybutton = RaidBuffStatus.button

	RaidBuffStatus.talentsbutton = CreateFrame("Button", "talentsbutton", RaidBuffStatus.frame, "SecureActionButtonTemplate")
	RaidBuffStatus.talentsbutton:SetWidth(20)
	RaidBuffStatus.talentsbutton:SetHeight(20)
	RaidBuffStatus.talentsbutton:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up")
	RaidBuffStatus.talentsbutton:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Down") 
	RaidBuffStatus.talentsbutton:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")
	RaidBuffStatus.talentsbutton:ClearAllPoints()
	RaidBuffStatus.talentsbutton:SetPoint("TOPLEFT", RaidBuffStatus.frame, "TOPLEFT", 5, -5)
	RaidBuffStatus.talentsbutton:SetScript("OnClick", function()
		RaidBuffStatus:ToggleTalentsFrame()
	end
	)
	RaidBuffStatus.talentsbutton:Show()

	RaidBuffStatus.optionsbutton = CreateFrame("Button", "optionsbutton", RaidBuffStatus.frame, "SecureActionButtonTemplate")
	RaidBuffStatus.optionsbutton:SetWidth(20)
	RaidBuffStatus.optionsbutton:SetHeight(20)
	RaidBuffStatus.optionsbutton:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up")
	RaidBuffStatus.optionsbutton:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Down") 
	RaidBuffStatus.optionsbutton:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")
	RaidBuffStatus.optionsbutton:ClearAllPoints()
	RaidBuffStatus.optionsbutton:SetPoint("TOPRIGHT", RaidBuffStatus.frame, "TOPRIGHT", -5, -5)
	RaidBuffStatus.optionsbutton:SetScript("OnClick", function()
		RaidBuffStatus:ToggleOptionsFrame()
	end
	)
	RaidBuffStatus.optionsbutton:Show()

	-- Dashboard scan button
	RaidBuffStatus.button = CreateFrame("Button", "", RaidBuffStatus.frame, "OptionsButtonTemplate")
	RaidBuffStatus.button:SetText(L["Scan"])
	RaidBuffStatus.button:SetWidth(55)
	RaidBuffStatus.button:SetHeight(15)
	RaidBuffStatus.button:SetPoint("TOP", RaidBuffStatus.frame, "TOP", 0, -18)
	RaidBuffStatus.button:SetScript("OnClick", function()
		nextdurability = 0
		nextitemcheck = 0
		for itemcheck, _ in pairs(RaidBuffStatus.itemcheck) do
			RaidBuffStatus.itemcheck[itemcheck].next = 0
		end
		RaidBuffStatus:DoReport(true)
		RaidBuffStatus:Debug("Scan button")
		RaidBuffStatus:SendPPMessage(true)
	end)
	RaidBuffStatus.button:Show()
	RaidBuffStatus.scanbutton = RaidBuffStatus.button

	RaidBuffStatus:AddBuffButtons()

	-- talents window frame

	RaidBuffStatus.talentframe = CreateFrame("Frame", "RBSTalentsFrame", UIParent, "DialogBoxFrame")
	RaidBuffStatus.talentframe:Hide()
	RaidBuffStatus.talentframe:EnableMouse(true)
	RaidBuffStatus.talentframe:SetFrameStrata("MEDIUM")
	RaidBuffStatus.talentframe:SetMovable(true)
	RaidBuffStatus.talentframe:SetToplevel(true)
	RaidBuffStatus.talentframe:SetWidth(tfi.framewidth)
	RaidBuffStatus.talentframe:SetHeight(190)
	RaidBuffStatus.rbsfs = RaidBuffStatus.talentframe:CreateFontString("$parentTitle","ARTWORK","GameFontNormal")
	RaidBuffStatus.rbsfs:SetText("RBS " .. RaidBuffStatus.version .. " - " .. L["Talent Specialisations"])
	RaidBuffStatus.rbsfs:SetPoint("TOP",0,-5)
	RaidBuffStatus.rbsfs:SetTextColor(1,1,1)
	RaidBuffStatus.rbsfs:Show()
	RaidBuffStatus.talentframe:SetBackdrop( { 
		bgFile = "Interface\\Buttons\\WHITE8X8", 
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, 
		insets = { left = 5, right = 5, top = 5, bottom = 5 }
	})
	RaidBuffStatus.talentframe:ClearAllPoints()
	RaidBuffStatus.talentframe:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	RaidBuffStatus.talentframe:SetScript("OnMouseDown",function()
		if ( arg1 == "LeftButton" ) then
			if not RaidBuffStatus.db.profile.LockWindow then
				this:StartMoving()
			end
		end
	end)
	RaidBuffStatus.talentframe:SetScript("OnMouseUp",function()
		if ( arg1 == "LeftButton" ) then
			this:StopMovingOrSizing()
			RaidBuffStatus:SaveFramePosition()
		end
	end)
	RaidBuffStatus.talentframe:SetScript("OnHide",function() this:StopMovingOrSizing() end)
	RaidBuffStatus.button = CreateFrame("Button", "", RaidBuffStatus.talentframe, "OptionsButtonTemplate")
	RaidBuffStatus.button:SetText(L["Name"])
	RaidBuffStatus.button:SetWidth(tfi.namewidth)
	RaidBuffStatus.button:SetPoint("TOPLEFT", RaidBuffStatus.talentframe, "TOPLEFT", tfi.namex, -20)
	RaidBuffStatus.button:SetScript("OnClick", function()
		tfi.sort = "name"
		tfi.sortorder = 0 - tfi.sortorder
		RaidBuffStatus:ShowTalentsFrame()
	end)
	RaidBuffStatus.button:Show()
	RaidBuffStatus.button = CreateFrame("Button", "", RaidBuffStatus.talentframe, "OptionsButtonTemplate")
	RaidBuffStatus.button:SetText(L["Class"])
	RaidBuffStatus.button:SetWidth(tfi.classwidth)
	RaidBuffStatus.button:SetPoint("TOPLEFT", RaidBuffStatus.talentframe, "TOPLEFT", tfi.classx, -20)
		RaidBuffStatus.button:SetScript("OnClick", function()
		tfi.sort = "class"
		tfi.sortorder = 0 - tfi.sortorder
		RaidBuffStatus:ShowTalentsFrame()
	end)
	RaidBuffStatus.button:Show()
	RaidBuffStatus.button = CreateFrame("Button", "", RaidBuffStatus.talentframe, "OptionsButtonTemplate")
	RaidBuffStatus.button:SetText(L["Spec"])
	RaidBuffStatus.button:SetWidth(tfi.specwidth)
	RaidBuffStatus.button:SetPoint("TOPLEFT", RaidBuffStatus.talentframe, "TOPLEFT", tfi.specx, -20)
		RaidBuffStatus.button:SetScript("OnClick", function()
		tfi.sort = "spec"
		tfi.sortorder = 0 - tfi.sortorder
		RaidBuffStatus:ShowTalentsFrame()
	end)
	RaidBuffStatus.button:Show()
	RaidBuffStatus.button = CreateFrame("Button", "", RaidBuffStatus.talentframe, "OptionsButtonTemplate")
	RaidBuffStatus.button:SetText(L["Role"])
	RaidBuffStatus.button:SetWidth(tfi.specwidth)
	RaidBuffStatus.button:SetPoint("TOPLEFT", RaidBuffStatus.talentframe, "TOPLEFT", tfi.rolex, -20)
		RaidBuffStatus.button:SetScript("OnClick", function()
		tfi.sort = "role"
		tfi.sortorder = 0 - tfi.sortorder
		RaidBuffStatus:ShowTalentsFrame()
	end)
	RaidBuffStatus.button:Show()
	RaidBuffStatus.button = CreateFrame("Button", "", RaidBuffStatus.talentframe, "OptionsButtonTemplate")
	RaidBuffStatus.button:SetText(L["Specialisations"])
	RaidBuffStatus.button:SetWidth(tfi.specialisationswidth)
	RaidBuffStatus.button:SetPoint("TOPLEFT", RaidBuffStatus.talentframe, "TOPLEFT", tfi.specialisationsx, -20)
		RaidBuffStatus.button:SetScript("OnClick", function()
		tfi.sort = "specialisations"
		tfi.sortorder = 0 - tfi.sortorder
		RaidBuffStatus:ShowTalentsFrame()
	end)
	RaidBuffStatus.button:Show()
	RaidBuffStatus.button = CreateFrame("Button", "", RaidBuffStatus.talentframe, "OptionsButtonTemplate")
	RaidBuffStatus.button:SetText(L["Refresh"])
	RaidBuffStatus.button:SetWidth(90)
	RaidBuffStatus.button:SetPoint("BOTTOMRIGHT", RaidBuffStatus.talentframe, "BOTTOMRIGHT", -5, 5)
	RaidBuffStatus.button:SetScript("OnClick", function()
		RaidBuffStatus:RefreshTalents()
	end)
	RaidBuffStatus.button:Show()

	rowy = 0 - tfi.topedge
	for i = 1, tfi.maxrows do
		tfi.rowframes[i] = {}
		RaidBuffStatus.rowframe = CreateFrame("Frame", "", RaidBuffStatus.talentframe)
		tfi.rowframes[i].rowframe = RaidBuffStatus.rowframe
		RaidBuffStatus.rowframe:SetWidth(tfi.rowwidth)
		RaidBuffStatus.rowframe:SetHeight(tfi.rowheight)
		RaidBuffStatus.rowframe:ClearAllPoints()
		RaidBuffStatus.rowframe:SetPoint("TOPLEFT", RaidBuffStatus.talentframe, "TOPLEFT", tfi.edge + tfi.inset, rowy)
		RaidBuffStatus.rbsfs = RaidBuffStatus.rowframe:CreateFontString(nil,"ARTWORK","GameFontNormal")
		tfi.rowframes[i].name = RaidBuffStatus.rbsfs
		RaidBuffStatus.rbsfs:SetText("Must be in a party/raid")
		RaidBuffStatus.rbsfs:SetPoint("TOPLEFT", RaidBuffStatus.rowframe, "TOPLEFT", 0, -2)
		RaidBuffStatus.rbsfs:SetTextColor(.9,0,0)
		RaidBuffStatus.rbsfs:Show()

		RaidBuffStatus.button = CreateFrame("Button", "", RaidBuffStatus.rowframe)
		tfi.rowframes[i].class = RaidBuffStatus.button
		RaidBuffStatus.button:SetWidth(tfi.buttonsize)
		RaidBuffStatus.button:SetHeight(tfi.buttonsize)
		RaidBuffStatus.button:SetNormalTexture("Interface\\Icons\\INV_ValentinesCandy")
		RaidBuffStatus.button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")
		RaidBuffStatus.button:SetPoint("TOPLEFT", RaidBuffStatus.rowframe, "TOPLEFT", tfi.classx + ((tfi.classwidth - 30) / 2), 0)
		RaidBuffStatus.button:Show()

		RaidBuffStatus.button = CreateFrame("Button", "", RaidBuffStatus.rowframe)
		tfi.rowframes[i].role = RaidBuffStatus.button
		RaidBuffStatus.button:SetWidth(tfi.buttonsize)
		RaidBuffStatus.button:SetHeight(tfi.buttonsize)
		RaidBuffStatus.button:SetNormalTexture("Interface\\Icons\\INV_ValentinesCandy")
		RaidBuffStatus.button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")
		RaidBuffStatus.button:SetPoint("TOPLEFT", RaidBuffStatus.rowframe, "TOPLEFT", tfi.rolex + ((tfi.rolewidth - 30) / 2), 0)
		RaidBuffStatus.button:Show()

		RaidBuffStatus.button = CreateFrame("Button", "", RaidBuffStatus.rowframe)
		tfi.rowframes[i].spec = RaidBuffStatus.button
		RaidBuffStatus.button:SetWidth(tfi.buttonsize)
		RaidBuffStatus.button:SetHeight(tfi.buttonsize)
		RaidBuffStatus.button:SetNormalTexture("Interface\\Icons\\Ability_ThunderBolt")
		RaidBuffStatus.button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")
		RaidBuffStatus.button:SetPoint("TOPLEFT", RaidBuffStatus.rowframe, "TOPLEFT", tfi.specx + ((tfi.specwidth - 30) / 2), 0)
		RaidBuffStatus.button:Show()
		
		tfi.rowframes[i].specialisations = {}
		RaidBuffStatus.button = CreateFrame("Button", "", RaidBuffStatus.rowframe)
		tfi.rowframes[i].specialisations[1] = RaidBuffStatus.button
		RaidBuffStatus.button:SetWidth(tfi.buttonsize)
		RaidBuffStatus.button:SetHeight(tfi.buttonsize)
		RaidBuffStatus.button:SetNormalTexture("Interface\\Icons\\Ability_ThunderBolt")
		RaidBuffStatus.button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")
		RaidBuffStatus.button:SetPoint("TOPRIGHT", RaidBuffStatus.rowframe, "TOPRIGHT", 0 - tfi.inset, 0)
		RaidBuffStatus.button:Show()
		
		for j = 2, 10 do
			RaidBuffStatus.button = CreateFrame("Button", "", RaidBuffStatus.rowframe)
			tfi.rowframes[i].specialisations[j] = RaidBuffStatus.button
			RaidBuffStatus.button:SetWidth(tfi.buttonsize)
			RaidBuffStatus.button:SetHeight(tfi.buttonsize)
			RaidBuffStatus.button:SetNormalTexture("Interface\\Icons\\Ability_ThunderBolt")
			RaidBuffStatus.button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")
			RaidBuffStatus.button:SetPoint("TOPRIGHT", tfi.rowframes[i].specialisations[j - 1], "TOPLEFT", 0, 0)
			RaidBuffStatus.button:Show()
		end
		rowy = rowy - tfi.rowheight - tfi.rowgap
	end


	-- options window frame
	RaidBuffStatus.optionsframe = CreateFrame("Frame", "RBSOptionsFrame", UIParent, "DialogBoxFrame")
	RaidBuffStatus.optionsframe:Hide()
	RaidBuffStatus.optionsframe:EnableMouse(true)
	RaidBuffStatus.optionsframe:SetFrameStrata("MEDIUM")
	RaidBuffStatus.optionsframe:SetMovable(true)
	RaidBuffStatus.optionsframe:SetToplevel(true)
	RaidBuffStatus.optionsframe:SetWidth(300)
	RaidBuffStatus.optionsframe:SetHeight(228)
	RaidBuffStatus.rbsfs = RaidBuffStatus.optionsframe:CreateFontString("$parentTitle","ARTWORK","GameFontNormal")
	RaidBuffStatus.rbsfs:SetText("RBS " .. RaidBuffStatus.version .. " - " .. L["Buff Options"])
	RaidBuffStatus.rbsfs:SetPoint("TOP",0,-5)
	RaidBuffStatus.rbsfs:SetTextColor(1,1,1)
	RaidBuffStatus.rbsfs:Show()
	RaidBuffStatus.optionsframe:SetBackdrop( { 
		bgFile = "Interface\\Buttons\\WHITE8X8", 
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, 
		insets = { left = 5, right = 5, top = 5, bottom = 5 }
	})
	RaidBuffStatus.optionsframe:ClearAllPoints()
	RaidBuffStatus.optionsframe:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	RaidBuffStatus.optionsframe:SetScript("OnMouseDown",function()
		if ( arg1 == "LeftButton" ) then
			if not RaidBuffStatus.db.profile.LockWindow then
				this:StartMoving()
			end
		end
	end)
	RaidBuffStatus.optionsframe:SetScript("OnMouseUp",function()
		if ( arg1 == "LeftButton" ) then
			this:StopMovingOrSizing()
			RaidBuffStatus:SaveFramePosition()
		end
	end)
	RaidBuffStatus.optionsframe:SetScript("OnHide",function() this:StopMovingOrSizing() end)

	RaidBuffStatus.rbsfs = RaidBuffStatus.optionsframe:CreateFontString("$parentTitle","ARTWORK","GameFontNormal")
	RaidBuffStatus.rbsfs:SetText(L["Is a warning"] .. ":")
	RaidBuffStatus.rbsfs:SetPoint("TOPLEFT",10,-53)
	RaidBuffStatus.rbsfs:SetTextColor(1,1,1)
	RaidBuffStatus.rbsfs:Show()
	RaidBuffStatus.rbsfs = RaidBuffStatus.optionsframe:CreateFontString("$parentTitle","ARTWORK","GameFontNormal")
	RaidBuffStatus.rbsfs:SetText(L["Is a buff"] .. ":")
	RaidBuffStatus.rbsfs:SetPoint("TOPLEFT",10,-73)
	RaidBuffStatus.rbsfs:SetTextColor(1,1,1)
	RaidBuffStatus.rbsfs:Show()
	RaidBuffStatus.rbsfs = RaidBuffStatus.optionsframe:CreateFontString("$parentTitle","ARTWORK","GameFontNormal")
	RaidBuffStatus.rbsfs:SetText(L["Show on dashboard"] .. ":")
	RaidBuffStatus.rbsfs:SetPoint("TOPLEFT",10,-93)
	RaidBuffStatus.rbsfs:SetTextColor(1,1,1)
	RaidBuffStatus.rbsfs:Show()
	RaidBuffStatus.rbsfs = RaidBuffStatus.optionsframe:CreateFontString("$parentTitle","ARTWORK","GameFontNormal")
	RaidBuffStatus.rbsfs:SetText(L["Show/Report in combat"] .. ":")
	RaidBuffStatus.rbsfs:SetPoint("TOPLEFT",10,-113)
	RaidBuffStatus.rbsfs:SetTextColor(1,1,1)
	RaidBuffStatus.rbsfs:Show()
	RaidBuffStatus.rbsfs = RaidBuffStatus.optionsframe:CreateFontString("$parentTitle","ARTWORK","GameFontNormal")
	RaidBuffStatus.rbsfs:SetText(L["Report on Trash"] .. ":")
	RaidBuffStatus.rbsfs:SetPoint("TOPLEFT",10,-133)
	RaidBuffStatus.rbsfs:SetTextColor(1,1,1)
	RaidBuffStatus.rbsfs:Show()
	RaidBuffStatus.rbsfs = RaidBuffStatus.optionsframe:CreateFontString("$parentTitle","ARTWORK","GameFontNormal")
	RaidBuffStatus.rbsfs:SetText(L["Report on Boss"] .. ":")
	RaidBuffStatus.rbsfs:SetPoint("TOPLEFT",10,-153)
	RaidBuffStatus.rbsfs:SetTextColor(1,1,1)
	RaidBuffStatus.rbsfs:Show()

	RaidBuffStatus.button = CreateFrame("Button", "", RaidBuffStatus.optionsframe, "OptionsButtonTemplate")
	RaidBuffStatus.button:SetText(L["Buff Wizard"])
	RaidBuffStatus.button:SetPoint("BOTTOMLEFT", RaidBuffStatus.optionsframe, "BOTTOMLEFT", 10, 25)
	RaidBuffStatus.button:SetScript("OnClick", function()
		RaidBuffStatus:OpenBlizzAddonOptions()
	end)
	RaidBuffStatus.button:Show()

	local bufflist = {}
	local BF = RaidBuffStatus.BF
	for buffcheck, _ in pairs(BF) do
		table.insert(bufflist, buffcheck)
	end
	table.sort(bufflist, function (a,b) return BF[a].order > BF[b].order end)

	local saveradio = function ()
		local name = this:GetName()
		RaidBuffStatus.db.profile[name] = this:GetChecked() and true or false
		local buffradio = false
		local isbuff = false
		if name:find("buff$") then
			buffradio = name:sub(1, name:find("buff$") - 1)
			isbuff = true
		elseif name:find("warning$") then
			buffradio = name:sub(1, name:find("warning$") - 1)
		end
		if buffradio then
			local value = true
			if RaidBuffStatus.db.profile[name] then
				value = false  -- if I am ticked then make the other unticked
			end
			if isbuff then
				RaidBuffStatus.db.profile[buffradio .. "warning"] = value
			else
				RaidBuffStatus.db.profile[buffradio .. "buff"] = value
			end
			RaidBuffStatus:UpdateOptionsButtons()
		end
		RaidBuffStatus:AddBuffButtons()
		RaidBuffStatus:UpdateButtons()
	end

	local currentx = 165
	for _, buffcheck in ipairs(bufflist) do
		RaidBuffStatus:AddOptionsBuffButton(buffcheck, currentx, -25, BF[buffcheck].icon, BF[buffcheck].tip)
		RaidBuffStatus:AddOptionsBuffRadioButton(buffcheck .. "warning", currentx, -50, saveradio, "Radio")
		RaidBuffStatus:AddOptionsBuffRadioButton(buffcheck .. "buff", currentx, -70, saveradio, "Radio")
		RaidBuffStatus:AddOptionsBuffRadioButton(buffcheck .. "dash", currentx, -90, saveradio, "Check")
		RaidBuffStatus:AddOptionsBuffRadioButton(buffcheck .. "dashcombat", currentx, -110, saveradio, "Check")
		RaidBuffStatus:AddOptionsBuffRadioButton(buffcheck .. "trash", currentx, -130, saveradio, "Check")
		RaidBuffStatus:AddOptionsBuffRadioButton(buffcheck .. "boss", currentx, -150, saveradio, "Check")
		currentx = currentx + 22
	end
	RaidBuffStatus.optionsframe:SetWidth(currentx + 9)
	RaidBuffStatus:SetFrameColours()
end


function RaidBuffStatus:SaveFramePosition()
	RaidBuffStatus.db.profile.x = RaidBuffStatus.frame:GetLeft()
	RaidBuffStatus.db.profile.y = RaidBuffStatus.frame:GetTop() - UIParent:GetTop()
end

function RaidBuffStatus:LoadFramePosition()
	RaidBuffStatus.frame:ClearAllPoints()
	if (RaidBuffStatus.db.profile.x ~= 0) or (RaidBuffStatus.db.profile.y ~= 0) then
		RaidBuffStatus.frame:SetPoint("TOPLEFT", UIParent,"TOPLEFT", RaidBuffStatus.db.profile.x, RaidBuffStatus.db.profile.y)
	else
		RaidBuffStatus.frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	end
end


function RaidBuffStatus:AddBuffButtons()
	if (InCombatLockdown()) then
		return
	end
	RaidBuffStatus:HideAllBars()
	local buffs = {}
	local warnings = {}
	local bosses = {}
	for _, v in ipairs(buttons) do
		v.free = true
		v:Hide()
	end
	local BF = RaidBuffStatus.BF
	for buffcheck, _ in pairs(BF) do
		
		if not RaidBuffStatus.db.profile[buffcheck .. "dash"] and not RaidBuffStatus.db.profile[buffcheck .. "dashcombat"] and not RaidBuffStatus.db.profile[buffcheck .. "boss"] and not RaidBuffStatus.db.profile[buffcheck .. "trash"] then
			 RaidBuffStatus.db.profile[BF[buffcheck].check] = false -- if nothing using it then switch off
		end
		if not RaidBuffStatus.db.profile[buffcheck .. "dash"] and RaidBuffStatus.db.profile[buffcheck .. "dashcombat"] then
			 RaidBuffStatus.db.profile[BF[buffcheck].check] = true
		end

		if  (not incombat and RaidBuffStatus.db.profile[buffcheck .. "dash"]) or (incombat and RaidBuffStatus.db.profile[buffcheck .. "dashcombat"]) then
			if RaidBuffStatus.db.profile[buffcheck .. "boss"] and (not RaidBuffStatus.db.profile[buffcheck .. "trash"]) then
				table.insert(bosses, buffcheck)
			else
				if RaidBuffStatus.db.profile[buffcheck .. "warning"] then
					table.insert(warnings, buffcheck)
				end
				if RaidBuffStatus.db.profile[buffcheck .. "buff"] then
					table.insert(buffs, buffcheck)
				end
			end
		end
		
	end
	RaidBuffStatus:SortButtons(bosses)
	RaidBuffStatus:SortButtons(buffs)
	RaidBuffStatus:SortButtons(warnings)
	local currenty
	if incombat or RaidBuffStatus.db.profile.hidebossrtrash then
		currenty = -14
	else
		currenty = 8
	end
	local maxcols = RaidBuffStatus.db.profile.dashcols
	local cols = { 10, 32, 54, 76, 98, 120, 142, 164, 186, 208, 230, 252, 274, 296, 318, 340, 362, 384, 402, 424, 446, 468, 490}
	if # bosses > 0 then
		currenty = RaidBuffStatus:AddButtonType(bosses, maxcols, cols, currenty)
	end
	if # buffs > 0 then
		currenty = RaidBuffStatus:AddButtonType(buffs, maxcols, cols, currenty)
	end
	if RaidBuffStatus.db.profile.TanksAlive then
		RaidBuffStatus:CreateBar(currenty + 19, "TanksAlive", L["Tanks alive"], .3, .7, .7, 0.8, function() RaidBuffStatus:BarTip(RaidBuffStatus.bars.TanksAlive.barframe, L["Dead tanks"], report.tanksalivelist) end)
		currenty = currenty + 11
	end
	if RaidBuffStatus.db.profile.HealersAlive then
		RaidBuffStatus:CreateBar(currenty + 19, "HealersAlive", L["Healers alive"], .9, .9, .9, 0.8, function() RaidBuffStatus:BarTip(RaidBuffStatus.bars.HealersAlive.barframe, L["Dead healers"], report.healersalivelist) end)
		currenty = currenty + 11
	end
	if RaidBuffStatus.db.profile.Alive then
		RaidBuffStatus:CreateBar(currenty + 19, "Alive", L["Alive"], .1, .2, .2, 0.8, function() RaidBuffStatus:BarTip(RaidBuffStatus.bars.Alive.barframe, L["I see dead people"], report.alivelist) end)
		currenty = currenty + 11
	end
	if RaidBuffStatus.db.profile.DPSMana then
		RaidBuffStatus:CreateBar(currenty + 19, "DPSMana", L["DPS mana"], RAID_CLASS_COLORS.WARLOCK.r, RAID_CLASS_COLORS.WARLOCK.g, RAID_CLASS_COLORS.WARLOCK.b, 0.8, function() RaidBuffStatus:BarTip(RaidBuffStatus.bars.DPSMana.barframe, L["DPS mana"] .. " %", report.dpsmanalist) end)
		currenty = currenty + 11
	end
	if RaidBuffStatus.db.profile.HealerMana then
		RaidBuffStatus:CreateBar(currenty + 19, "HealerMana", L["Healer mana"], RAID_CLASS_COLORS.PALADIN.r, RAID_CLASS_COLORS.PALADIN.g, RAID_CLASS_COLORS.PALADIN.b, 0.8, function() RaidBuffStatus:BarTip(RaidBuffStatus.bars.HealerMana.barframe, L["Healer mana"] .. " %", report.healermanalist) end)
		currenty = currenty + 11
	end
	if RaidBuffStatus.db.profile.RaidMana then
		RaidBuffStatus:CreateBar(currenty + 19, "RaidMana", L["Raid mana"], 0, 0, 1, 0.8, function() RaidBuffStatus:BarTip(RaidBuffStatus.bars.RaidMana.barframe, L["Raid mana"] .. " %", report.raidmanalist) end)
		currenty = currenty + 11
	end
	if RaidBuffStatus.db.profile.TankHealth then
		RaidBuffStatus:CreateBar(currenty + 19, "TankHealth", L["Tank health"], RAID_CLASS_COLORS.WARRIOR.r, RAID_CLASS_COLORS.WARRIOR.g, RAID_CLASS_COLORS.WARRIOR.b, 0.8, function() RaidBuffStatus:BarTip(RaidBuffStatus.bars.TankHealth.barframe, L["Tank health"] .. " %", report.tankhealthlist) end)
		currenty = currenty + 11
	end
	if RaidBuffStatus.db.profile.RaidHealth then
		RaidBuffStatus:CreateBar(currenty + 19, "RaidHealth", L["Raid health"], 1, 0, 0, 0.8, function() RaidBuffStatus:BarTip(RaidBuffStatus.bars.RaidHealth.barframe, L["Raid health"], report.raidhealthlist) end)
		currenty = currenty + 11
	end
	if # warnings > 0 then
		currenty = RaidBuffStatus:AddButtonType(warnings, maxcols, cols, currenty)
	end
	if incombat or RaidBuffStatus.db.profile.hidebossrtrash then
		RaidBuffStatus.bossbutton:Hide()
		RaidBuffStatus.trashbutton:Hide()
		RaidBuffStatus.readybutton:Hide()
		if incombat then
			RaidBuffStatus.talentsbutton:Hide()
			RaidBuffStatus.optionsbutton:Hide()
			RaidBuffStatus.scanbutton:Hide()
			currenty = currenty - 18
		end
	else
		RaidBuffStatus.bossbutton:Show()
		RaidBuffStatus.trashbutton:Show()
		RaidBuffStatus.readybutton:Show()
		RaidBuffStatus.talentsbutton:Show()
		RaidBuffStatus.optionsbutton:Show()
		RaidBuffStatus.scanbutton:Show()
	end
	RaidBuffStatus.frame:SetHeight(currenty + 50)
	RaidBuffStatus.frame:SetWidth(maxcols * 22 + 18)
	RaidBuffStatus:SetBarsWidth()
end

function RaidBuffStatus:AddButtonType(buttonlist, maxcols, cols, currenty)
	local BF = RaidBuffStatus.BF
	for i, v in ipairs(buttonlist) do
		local x = cols[((i - 1) % maxcols) + 1]
		local y = currenty + (22 * (math.ceil((# buttonlist)/maxcols) - math.floor((i - 1) / maxcols)))
		RaidBuffStatus:AddBuffButton(v, x, y, BF[v].icon, BF[v].update, BF[v].click, BF[v].tip)
	end
	return (currenty + 6 + 22 * math.ceil((# buttonlist)/maxcols))
end

function RaidBuffStatus:SortButtons(buttonlist)
	local BF = RaidBuffStatus.BF
	table.sort(buttonlist, function (a,b)
		return (BF[a].order > BF[b].order)
	end)
end


function RaidBuffStatus:AddBuffButton(name, x, y, icon, update, click, tooltip)
	RaidBuffStatus.button = nil
	for _, v in ipairs(buttons) do
		if v.free then
			RaidBuffStatus.button = v
			RaidBuffStatus.button.update = nil
			RaidBuffStatus.button:SetScript("PreClick", nil)
			RaidBuffStatus.button:SetScript("PostClick", nil)
			RaidBuffStatus.button:SetScript("OnEnter", nil)
			RaidBuffStatus.button:SetScript("OnLeave", nil)
			RaidBuffStatus.button:SetAttribute("type", nil)
			RaidBuffStatus.button:SetAttribute("spell", nil)
			RaidBuffStatus.button:SetAttribute("unit", nil)
			RaidBuffStatus.button:SetAttribute("name", nil)
			RaidBuffStatus.button.count:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
			RaidBuffStatus.button.count:SetText("")
			break
		end
	end
	if not RaidBuffStatus.button then
		RaidBuffStatus.button = CreateFrame("Button", nil, RaidBuffStatus.frame, "SecureActionButtonTemplate")
		RaidBuffStatus.button:RegisterForClicks("LeftButtonUp","RightButtonUp")
		table.insert(buttons, RaidBuffStatus.button)
		RaidBuffStatus.button:Hide()
		RaidBuffStatus.button:SetWidth(20)
		RaidBuffStatus.button:SetHeight(20)
		RaidBuffStatus.button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")
		RaidBuffStatus.button:SetAlpha(1)
		RaidBuffStatus.count = RaidBuffStatus.button:CreateFontString(nil, "ARTWORK","GameFontNormalSmall")
		RaidBuffStatus.button.count = RaidBuffStatus.count
		RaidBuffStatus.count:SetWidth(20)
		RaidBuffStatus.count:SetHeight(20)
		RaidBuffStatus.count:SetFont(RaidBuffStatus.count:GetFont(),11,"OUTLINE")
		RaidBuffStatus.count:SetPoint("CENTER", self.button, "CENTER", 0, 0)
		RaidBuffStatus.count:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
		RaidBuffStatus.count:SetText("X")
		RaidBuffStatus.count:Show()
	end
	RaidBuffStatus.button.free = false
	RaidBuffStatus.button:SetNormalTexture(icon)
	RaidBuffStatus.button:SetPoint("BOTTOMLEFT", RaidBuffStatus.frame, "BOTTOMLEFT", x, y)
	if click then
		RaidBuffStatus.button:SetScript("PreClick", click)
	end
	if update then
		RaidBuffStatus.button.update = update
	end
	if tooltip then
		RaidBuffStatus.button:SetScript("OnEnter", function (self)
			tooltip(self)
			RaidBuffStatus.tooltipupdate = function ()
				tooltip(self)
			end
		end)
		RaidBuffStatus.button:SetScript("OnLeave", function()
			RaidBuffStatus.tooltipupdate = nil
			GameTooltip:Hide()
		end)
	end
	RaidBuffStatus.button:Show()
end

function RaidBuffStatus:AddOptionsBuffButton(name, x, y, icon, tooltip)
	RaidBuffStatus.button = CreateFrame("Button", name, RaidBuffStatus.optionsframe, "SecureActionButtonTemplate")
	RaidBuffStatus.button:Hide()
	RaidBuffStatus.button:SetWidth(20)
	RaidBuffStatus.button:SetHeight(20)
	RaidBuffStatus.button:SetNormalTexture(icon)
	RaidBuffStatus.button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")
	RaidBuffStatus.button:SetPoint("TOPLEFT", RaidBuffStatus.optionsframe, "TOPLEFT", x, y)
	if tooltip then
		RaidBuffStatus.button:SetScript("OnEnter", tooltip)
		RaidBuffStatus.button:SetScript("OnLeave", function() GameTooltip:Hide() end)
	end
	RaidBuffStatus.button:Show()
end

function RaidBuffStatus:AddOptionsBuffRadioButton(name, x, y, click, type)
	RaidBuffStatus.button = CreateFrame("CheckButton", name, RaidBuffStatus.optionsframe, "UI" .. type .. "ButtonTemplate")
	table.insert(optionsbuttons, RaidBuffStatus.button)
	RaidBuffStatus.button:Hide()
	RaidBuffStatus.button:SetWidth(20)
	RaidBuffStatus.button:SetHeight(20)
	RaidBuffStatus.button:SetPoint("TOPLEFT", RaidBuffStatus.optionsframe, "TOPLEFT", x, y)
	RaidBuffStatus.button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")
	if click then
		RaidBuffStatus.button:SetScript("OnClick", click)
	end
	RaidBuffStatus.button:Show()
end



function RaidBuffStatus:ToggleCheck(...)
	if RaidBuffStatus.db.profile[...] then
		RaidBuffStatus.db.profile[...] = false
	else
		RaidBuffStatus.db.profile[...] = true
		RaidBuffStatus:DoReport()
	end
	RaidBuffStatus:UpdateButtons()
end


function RaidBuffStatus:UpdateButtons()
	for _,v in ipairs(buttons) do
		if not v.free then
			if v.update then
				v:update(v)
			end
		end
	end
	if RaidBuffStatus.db.profile.TanksAlive then
		RaidBuffStatus:SetPercent("TanksAlive", report.TanksAlive)
	end
	if RaidBuffStatus.db.profile.HealersAlive then
		RaidBuffStatus:SetPercent("HealersAlive", report.HealersAlive)
	end
	if RaidBuffStatus.db.profile.Alive then
		RaidBuffStatus:SetPercent("Alive", report.Alive)
	end
	if RaidBuffStatus.db.profile.RaidHealth then
		RaidBuffStatus:SetPercent("RaidHealth", report.RaidHealth)
	end
	if RaidBuffStatus.db.profile.TankHealth then
		RaidBuffStatus:SetPercent("TankHealth", report.TankHealth)
	end
	if RaidBuffStatus.db.profile.RaidMana then
		RaidBuffStatus:SetPercent("RaidMana", report.RaidMana)
	end
	if RaidBuffStatus.db.profile.DPSMana then
		RaidBuffStatus:SetPercent("DPSMana", report.DPSMana)
	end
	if RaidBuffStatus.db.profile.HealerMana then
		RaidBuffStatus:SetPercent("HealerMana", report.HealerMana)
	end
end

function RaidBuffStatus:UpdateOptionsButtons()
	for _,v in ipairs(optionsbuttons) do
		v:SetChecked(RaidBuffStatus.db.profile[v:GetName()])
	end
end


function RaidBuffStatus:OnProfileEnable()
	RaidBuffStatus:LoadFramePosition()
	RaidBuffStatus:DoReport(true)
end

function RaidBuffStatus:JoinedPartyRaidChanged()
	local oldstatus = raid.isparty or raid.israid
	RaidBuffStatus:DoReport(true)
	if oldstatus then  -- was a raid or party last check
		if raid.isparty or raid.israid then -- still is a raid or party
			RaidBuffStatus:TriggerXPerlTankUpdate()
--			RaidBuffStatus:SendPPMessage()
		else	-- no longer in raid or party
			RaidBuffStatus:HideReportFrame()
			if RaidBuffStatus.timer then
				RaidBuffStatus:CancelTimer(RaidBuffStatus.timer)
				RaidBuffStatus.timer = false
			end
		end
	else
		if raid.isparty or raid.israid then -- newly entered raid or party
			RaidBuffStatus:TriggerXPerlTankUpdate()
			RaidBuffStatus.timer = RaidBuffStatus:ScheduleRepeatingTimer(RaidBuffStatus.DoReport, RaidBuffStatus.db.profile.HowOften)
			pallypowersendersseen = {}
			RaidBuffStatus:SendVersion()
			if RaidBuffStatus.db.profile.TellWizard then
				RaidBuffStatus:PopUpWizard()
			end
		end
		if raid.israid and raid.isbattle then
			if RaidBuffStatus.db.profile.AutoShowDashBattle then
				RaidBuffStatus:ShowReportFrame()
			else
				RaidBuffStatus:HideReportFrame()
			end
		elseif (raid.isparty and RaidBuffStatus.db.profile.AutoShowDashParty) or (raid.israid and RaidBuffStatus.db.profile.AutoShowDashRaid) then
			RaidBuffStatus:ShowReportFrame()
		end
	end
end


function RaidBuffStatus:OnEnable()
	RaidBuffStatus.version = (GetAddOnMetadata("RaidBuffStatus", "X-Curse-Packaged-Version") or GetAddOnMetadata("RaidBuffStatus", "Version"))
	local _, _, revision = string.find(GetAddOnMetadata("RaidBuffStatus", "X-Build"), ".* (.*) .*")
	RaidBuffStatus.revision = revision
	RaidBuffStatus:SendVersion()
	RaidBuffStatus:SetupFrames()
	RaidBuffStatus:JoinedPartyRaidChanged()
	RaidBuffStatus:UpdateMiniMapButton()
	RaidBuffStatus:RegisterEvent("RAID_ROSTER_UPDATE", "JoinedPartyRaidChanged")
	RaidBuffStatus:RegisterEvent("PARTY_MEMBERS_CHANGED", "JoinedPartyRaidChanged")
	RaidBuffStatus:RegisterEvent("PLAYER_ENTERING_WORLD", "JoinedPartyRaidChanged")
	RaidBuffStatus:RegisterEvent("PLAYER_REGEN_ENABLED", "LeftCombat")
	RaidBuffStatus:RegisterEvent("PLAYER_REGEN_DISABLED", "EnteringCombat")
	RaidBuffStatus:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", "COMBAT_LOG_EVENT_UNFILTERED")
	RaidBuffStatus:RegisterEvent("CHAT_MSG_ADDON", "CHAT_MSG_ADDON")
--	RaidBuffStatus:RegisterEvent("CHAT_MSG_EMOTE", "CHAT_MSG_MONSTER_EMOTE")--
--	RaidBuffStatus:RegisterEvent("CHAT_MSG_TEXT_EMOTE", "CHAT_MSG_MONSTER_EMOTE")--
--	RaidBuffStatus:RegisterEvent("CHAT_MSG_MONSTER_EMOTE", "CHAT_MSG_MONSTER_EMOTE") -- not used any more as use spellid for fish feast
	RaidBuffStatus:RegisterEvent("CHAT_MSG_RAID_WARNING", "CHAT_MSG_RAID_WARNING")
--	RaidBuffStatus:Debug('Enabled!')
	if oRA then
		RaidBuffStatus:Debug('Registering oRA tank event')
		RaidBuffStatus.oRAEvent:RegisterForTankEvent(function() RaidBuffStatus:oRA_MainTankUpdate() end)
	elseif XPerl_MainTanks then
		RaidBuffStatus:Debug('XPerl_MainTanks')
	elseif CT_RA_MainTanks then
		RaidBuffStatus:Debug('Registering CTRA event')
		hooksecurefunc("CT_RAOptions_UpdateMTs", function() RaidBuffStatus:oRA_MainTankUpdate() end)
	end
	RaidBuffStatus:SendPPMessage()
	WorldMapFrame:Show()
	WorldMapFrame:Hide() 
end

function RaidBuffStatus:OnDisable()
	RaidBuffStatus:Debug('Disabled!')
	RaidBuffStatus:UnregisterAllEvents()
	RaidBuffStatus.oRAEvent:UnRegisterForTankEvent()
end

function RaidBuffStatus:EnteringCombat()
	incombat = true
	if (InCombatLockdown()) then
		return
	end
	if RaidBuffStatus.db.profile.DisableInCombat then
		if RaidBuffStatus.frame:IsVisible() then
			dashwasdisplayed = true
			RaidBuffStatus:HideReportFrame()
		else
			dashwasdisplayed = false
		end
		return
	end
	RaidBuffStatus:AddBuffButtons()
	RaidBuffStatus:UpdateButtons()
end

function RaidBuffStatus:LeftCombat()
	incombat = false
	RaidBuffStatus:AddBuffButtons()
	RaidBuffStatus:UpdateButtons()
	if RaidBuffStatus.db.profile.DisableInCombat and dashwasdisplayed then
		RaidBuffStatus:ShowReportFrame()	
	end
end

function RaidBuffStatus:Tooltip(self, title, list, tlist, blist, slist, ppmissinglist, itemcountlist, unknownlist, pallyblessingsmessagelist, ppproblems, gotitlist)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetText(title,1,1,1,1,1)
	local str = ""
	if list then
		if #list > 0 then
			local thelisttouse = list
			local timerlist = {}
			if tlist then
				for _, n in ipairs(list) do
					if tlist[n] then
						table.insert(timerlist, n .. "(" .. RaidBuffStatus:TimeSince(tlist[n]) .. ")")
					else
						table.insert(timerlist, n)
					end
				end
				thelisttouse = timerlist
			end
			for _,s in pairs({strsplit(" ", table.concat(thelisttouse, ", "))}) do
				str = str .. " " .. s
			end
			GameTooltip:AddLine(str,nil,nil,nil,1)
		end
	end
	if blist then
		if #blist > 0 then
			str = L["Buffers: "]
			for _,s in pairs({strsplit(" ", table.concat(blist, ", "))}) do
				str = str .. " " .. s
			end
			GameTooltip:AddLine(str,GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b, 1)
		end
	end
	if gotitlist then
		if #gotitlist > 0 then
			str = L["Has buff: "]
			for _,s in pairs({strsplit(" ", table.concat(gotitlist, ", "))}) do
				str = str .. " " .. s
			end
			GameTooltip:AddLine(str,nil,nil,nil,1)
		end
	end
	if ppproblems then
		for message,_ in pairs(ppproblems) do
			GameTooltip:AddLine(message,nil,nil,nil,1)
		end
	end
	if slist then
		if #slist > 0 then
			str = L["Slackers: "]
			for _,s in pairs({strsplit(" ", table.concat(slist, ", "))}) do
				str = str .. " " .. s
			end
			GameTooltip:AddLine(str,RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b, 1)
		end
	end
	if pallyblessingsmessagelist then
		for message,_ in pairs(pallyblessingsmessagelist) do
			GameTooltip:AddLine(message,GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b, 1)
		end
	end
	if ppmissinglist then
		if #ppmissinglist > 0 then
			str = L["Paladins missing Pally Power: "]
			for _,s in pairs({strsplit(" ", table.concat(ppmissinglist, ", "))}) do
				str = str .. " " .. s
			end
			GameTooltip:AddLine(str,nil,nil,nil,1)
		end
	end
	if itemcountlist then
		if #itemcountlist > 0 then
			GameTooltip:AddLine(L["Item count: "], 1, 0, 1, 1)
			for _,s in pairs(itemcountlist) do
				GameTooltip:AddLine(s, 1, 0, 1, 1)
			end
		end
	end
	if unknownlist then
		if #unknownlist > 0 then
			str = L["Missing or not working oRA2: "]
			for _,s in pairs({strsplit(" ", table.concat(unknownlist, ", "))}) do
				str = str .. " " .. s
			end
			GameTooltip:AddLine(str,nil,nil,nil,1)
		end
	end
	GameTooltip:Show()
end

function RaidBuffStatus:DefaultButtonUpdate(self, thosemissing, profile, checking, morework)
	if profile == false then
		self.count:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
		self.count:SetText("X")
		self:SetAlpha("0.5")
	else
		if checking then
			local r = NORMAL_FONT_COLOR.r
			local g = NORMAL_FONT_COLOR.g
			local b = NORMAL_FONT_COLOR.b
			if RaidBuffStatus.db.profile.HighlightMyBuffs then
				if #thosemissing > 0 then
					if morework and RaidBuffStatus:AmIListed(morework) then
						r = RED_FONT_COLOR.r
						g = RED_FONT_COLOR.g
						b = RED_FONT_COLOR.b
					elseif RaidBuffStatus:AmIListed(thosemissing) then
						r = 0
						g = 1
						b = 1
					end
				end
			end
			self.count:SetTextColor(r, g, b)
			self.count:SetText(#thosemissing)
			self:SetAlpha("1")
		else
			self.count:SetText("")
			self:SetAlpha("0.15")
		end
	end
end


function RaidBuffStatus:ButtonClick(self, button, down, buffcheck, cheapspell, reagentspell, reagent, nonselfbuff)
	local BF = RaidBuffStatus.BF
	local check = BF[buffcheck].check
	local prefix
	if RaidBuffStatus.db.profile[buffcheck .. "buff"] then
		prefix = L["Missing buff: "]
	else
		prefix = L["Warning: "]
	end
	if RaidBuffStatus.db.profile[check] then
		local action = "none"
		if button == "LeftButton" then
			if IsAltKeyDown() then
				action = RaidBuffStatus.db.profile.AltLeftClick
			elseif IsShiftKeyDown() then
				action = RaidBuffStatus.db.profile.ShiftLeftClick
			elseif IsControlKeyDown() then
				action = RaidBuffStatus.db.profile.ControlLeftClick
			else
				action = RaidBuffStatus.db.profile.LeftClick
			end
		elseif button == "RightButton" then
			if IsAltKeyDown() then
				action = RaidBuffStatus.db.profile.AltRightClick
			elseif IsShiftKeyDown() then
				action = RaidBuffStatus.db.profile.ShiftRightClick
			elseif IsControlKeyDown() then
				action = RaidBuffStatus.db.profile.ControlRightClick
			else
				action = RaidBuffStatus.db.profile.RightClick
			end
		end
		if not InCombatLockdown() and cheapspell then
			self:SetAttribute("type", nil)
			self:SetAttribute("spell", nil)
			self:SetAttribute("unit", nil)
			self:SetScript("PostClick", nil)
		end
		if cheapspell and action == "buff" then
			RaidBuffStatus:DoReport()
			if not InCombatLockdown() and # report[BF[buffcheck].list] > 0 then
				self:SetAttribute("type", "spell")
				if nonselfbuff then
					if # report[BF[buffcheck].list] > 0 then
						local unitidtobuff, spelltobuff
						if BF[buffcheck].raidbuff then
							unitidtobuff, spelltobuff = RaidBuffStatus:RaidBuff(report[BF[buffcheck].list], cheapspell, reagentspell, reagent)
						elseif BF[buffcheck].partybuff then
							unitidtobuff, spelltobuff = RaidBuffStatus:PartyBuff(report[BF[buffcheck].list], cheapspell, reagentspell, reagent)
						elseif BF[buffcheck].singlebuff then
							unitidtobuff, spelltobuff = RaidBuffStatus:SingleBuff(report[BF[buffcheck].list], cheapspell)
						elseif BF[buffcheck].paladinbuff then
							unitidtobuff, spelltobuff = RaidBuffStatus:PaladinBuff(reagent)  -- special case for blessings
						end
						self:SetAttribute("spell", spelltobuff)
						self:SetAttribute("unit", unitidtobuff)
						if unitidtobuff then  -- maybe none in range
							self:SetScript("PostClick", function(self)
								self:SetAttribute("type", nil)
								self:SetAttribute("spell", nil)
								self:SetAttribute("unit", nil)
								self:SetScript("PostClick", nil)
							end)
						end
					end
				else
					self:SetAttribute("spell", cheapspell)
				end
			end
		elseif action == "report" then
			local canspeak = IsRaidLeader() or IsRaidOfficer() or raid.pug
			if not canspeak and RaidBuffStatus.db.profile.ReportChat and raid.israid then
				RaidBuffStatus:OfficerWarning()
			end
			if type(BF[buffcheck].chat) == "string" then
				if # report[BF[buffcheck].list] > 0 then
					if BF[buffcheck].timer then
						local timerlist = {}
						for _, n in ipairs(report[BF[buffcheck].list]) do
							if raid.BuffTimers[buffcheck .. "timerlist"][n] then
								table.insert(timerlist, n .. "(" .. RaidBuffStatus:TimeSince(raid.BuffTimers[buffcheck .. "timerlist"][n]) .. ")")
							else
								table.insert(timerlist, n)
							end
						end
						RaidBuffStatus:Say("<" .. BF[buffcheck].chat .. ">: " .. table.concat(timerlist, ", "))
					else
						RaidBuffStatus:Say(prefix .. "<" .. BF[buffcheck].chat .. ">: " .. table.concat(report[BF[buffcheck].list], ", "))
					end
				end
			elseif type(BF[buffcheck].chat) == "function" then
				BF[buffcheck].chat(report, raid, prefix)
			end
		elseif action == "whisper" then
			RaidBuffStatus:WhisperBuff(BF[buffcheck], report, raid, prefix)
			
		elseif action == "enabledisable" then
			RaidBuffStatus:ToggleCheck(check)
		end
	else
		RaidBuffStatus:ToggleCheck(check)
	end
end

function RaidBuffStatus:WhisperBuff(buff, report, raid, prefix)
	if buff.selfbuff then
		if type(buff.chat) == "string" then
			if # report[buff.list] > 0 then
				for _, v in ipairs(report[buff.list]) do
					local name = v
					if v:find("%(") then
						name = string.sub(v, 1, v:find("%(") - 1)
					end
					RaidBuffStatus:Say(prefix .. "<" .. buff.chat .. ">: " .. v, name)
				end
			end
		elseif type(buff.chat) == "function" then
			buff.chat(report, raid, prefix)
		end
	elseif buff.whispertobuff then
		if #report[buff.list] > 0 then
			buff.whispertobuff(report[buff.list], prefix)
		end
	end
end

function RaidBuffStatus:SortNameBySuffix(thetable)
	table.sort(thetable, function (a,b)
		local grpa = select(3, a:find"(%d+)")
		local grpb = select(3, b:find"(%d+)")
		if grpa and grpb then
			if grpa == grpb then
				return a < b
			end
			return grpa < grpb
		else
			return a < b
		end
	end)
end

function RaidBuffStatus:TitleCaps(str)
	str = string.lower(str)
	return str:gsub("%a", string.upper, 1)
end

function RaidBuffStatus:TimeSince(thetimethen)
	local thedifference = math.floor(GetTime() - thetimethen)
	if thedifference < 60 then
		return (thedifference .. "s")
	end
	return (math.floor(thedifference / 60) .. "m" .. (thedifference % 60) .. "s")
end


function RaidBuffStatus:GetUnitFromName(whom)
	if whom:find("%(") then
		whom = string.sub(whom, 1, whom:find("%(") - 1)
	end
	for class,_ in pairs(raid.classes) do
		for name,_ in pairs(raid.classes[class]) do
			if whom == name then
				return raid.classes[class][name]
			end
		end
	end
	return nil
end


function RaidBuffStatus:RaidBuff(list, cheapspell, reagentspell, reagent) -- raid-wide buffs
	local usable, nomana = IsUsableSpell(cheapspell)
	if not usable and not nomana then
		return nil
	end
	local pb = {}
	local outofrange
	for _, v in ipairs(list) do
		if v:find("%(") then
			v = string.sub(v, 1, v:find("%(") - 1)
		end
		local unit = RaidBuffStatus:GetUnitFromName(v)
		if unit and unit.unitid and (not unit.isdead or rezspellshash[cheapspell]) and unit.online then
			RaidBuffStatus:Debug(v)
			table.insert(pb, unit.unitid)
		end
	end
	for _, v in ipairs(pb) do
		if IsSpellInRange(cheapspell, v) == 1 then
			if #pb >= RaidBuffStatus.db.profile.HowMany then
				if RaidBuffStatus:GotReagent(reagent) then
					return v, reagentspell
				end
			end
			return v, cheapspell
		end
		outofrange = UnitName(v)
	end
	if #pb == 0 then
		return nil
	end
	RaidBuffStatus:Print("RBS: " .. L["Out of range"] .. ": " .. outofrange)
	UIErrorsFrame:AddMessage("RBS: " .. L["Out of range"] .. ": " .. outofrange, 0, 1.0, 1.0, 1.0, 1)
	return nil
end

function RaidBuffStatus:PartyBuff(list, cheapspell, reagentspell, reagent) -- party-wide buffs
	local usable, nomana = IsUsableSpell(cheapspell)
	if not usable and not nomana then
		return nil
	end
	local pb = {{},{},{},{},{},{},{},{}}
	local outofrange
	for _, v in ipairs(list) do
		if v:find("%(") then
			v = string.sub(v, 1, v:find("%(") - 1)
		end
		local unit = RaidBuffStatus:GetUnitFromName(v)
		if unit and unit.unitid and not unit.isdead and unit.online then
			table.insert(pb[unit.group], unit.unitid)
		end
	end
	table.sort(pb, function (a,b)
		return(#a > #b)
	end)
	for i,_ in ipairs(pb) do
		for _, v in ipairs(pb[i]) do
			if IsSpellInRange(cheapspell, v) == 1 then
				if #pb[i] >= RaidBuffStatus.db.profile.HowMany then
					if RaidBuffStatus:GotReagent(reagent) then
						return v, reagentspell
					end
				end
				return v, cheapspell
			end
			outofrange = v
		end
	end
	if #pb == 0 then
		return nil
	end
	RaidBuffStatus:Print("RBS: " .. L["Out of range"] .. ": " .. outofrange)
	UIErrorsFrame:AddMessage("RBS: " .. L["Out of range"] .. ": " .. outofrange, 0, 1.0, 1.0, 1.0, 1)
	return nil
end

function RaidBuffStatus:SingleBuff(list, cheapspell) -- single unit buffs
	local usable, nomana = IsUsableSpell(cheapspell)
	if not usable and not nomana then
		return nil
	end
	return RaidBuffStatus:RaidBuff(list, cheapspell, cheapspell)
end

function RaidBuffStatus:PaladinBuff(reagent)  -- special case for blessings
	if #report.slackingpaladinsnames < 1 then
		return -- either nothing to do or no pally power
	end
	local outofrangep, outofranges
	local nowtforme = true
	for doclass = 1, 2 do
		for name,_ in pairs(report.paladinsresponsible) do
			if name == playername then
				for nom,_ in pairs(report.paladinsresponsible[name]) do
					local unit = RaidBuffStatus:GetUnitFromName(nom)
					if unit and unit.unitid and not unit.isdead and unit.online then
						for spell,_ in pairs(report.paladinsresponsible[name][nom]) do
							if (report.paladinsresponsible[name][nom][spell].class and doclass == 1) or (not report.paladinsresponsible[name][nom][spell].class and doclass == 2) then
								nowtforme = false
								if IsSpellInRange(spell, nom) == 1 then
									if RaidBuffStatus:GotReagent(reagent) and doclass == 1 then
										return nom, blessingtogreater[spell]
									else
										return nom, spell
									end
								end
								outofrangep = nom
								outofranges = spell
							end
						end
					end
				end
			end
		end
	end
	if nowtforme then
		return nil -- Maybe a message will be added here.
	else
		RaidBuffStatus:Print("RBS: " .. L["Out of range"] .. ": " .. outofrangep .. ", " .. outofranges)
		UIErrorsFrame:AddMessage("RBS: " .. L["Out of range"] .. ": " .. outofrangep .. ", " .. outofranges, 0, 1.0, 1.0, 1.0, 1)
	end
	return nil
end

function RaidBuffStatus:GotReagent(reagent)
	if reagent == nil then
		return true
	end
	for bag = 0, NUM_BAG_FRAMES do
		for slot = 1, GetContainerNumSlots(bag) do
			local item = GetContainerItemLink(bag, slot);
			if item then
				if string.find(item, "[" .. reagent .. "]", 1, true) then
					return true
				end
			end
		end
	end
	return false
end

function RaidBuffStatus:COMBAT_LOG_EVENT_UNFILTERED(event, timestamp, subevent, srcGUID, srcname, srcflags, dstGUID, dstname, dstflags, spellID, spellname, spellschool, extraspellID, extraspellname, extraspellschool, auratype)
	if not raid.israid and not raid.isparty then
		return
	end
	if (subevent == "UNIT_DIED" and band(tonumber(dstGUID:sub(0,5), 16), 0x00f) == 0x000) or (spellID == 27827 and subevent == "SPELL_AURA_APPLIED") then -- Spirit of Redemption
		local unit = RaidBuffStatus:GetUnitFromName(dstname)
		if not unit then
			return
		end
--		RaidBuffStatus:Debug(subevent .. " someone died:" .. dstname)
		if subevent == "UNIT_DIED" and unit.specialisations.spiritofredemption then
			RaidBuffStatus:Debug("was a priest with spirit of redemption")
			return
		end
		RaidBuffStatus:SomebodyDied(unit)
		return
	end
	if RaidBuffStatus.db.profile.misdirectionwarn and subevent == "SPELL_CAST_SUCCESS" and (spellID == 34477 or spellID == 57934) then
		RaidBuffStatus:MisdirectionEventLog(srcname, spellname, dstname)
		return
	end
	if not incombat then
			if not subevent or not spellID or not srcname or not spellname then
				return
			end
			if subevent == "SPELL_CAST_START" then
				if spellID == 57426 then -- Fish Feast
					RaidBuffStatus:CHAT_MSG_MONSTER_EMOTE("", "Fish", srcname)
				end
				return
			elseif subevent == "SPELL_CAST_SUCCESS" then
				if spellID == 58659 then -- Ritual of Refreshment (rank 2)
					RaidBuffStatus:CHAT_MSG_MONSTER_EMOTE("", "Table", srcname)
				elseif spellID == 58887 then -- Ritual of Souls (rank 2)
					RaidBuffStatus:CHAT_MSG_MONSTER_EMOTE("", "Soul", srcname)
				elseif spellID == 67826 or spellID == 22700 or spellID == 44389 or spellID == 54711 then -- Jeeves, Field Repair Bot 74A, Field Repair Bot 110G, Scrapbot
					RaidBuffStatus:CHAT_MSG_MONSTER_EMOTE("", "Repair", srcname)
				end
			end
		return
	end
	if not spellID or not dstGUID or not srcname then
		return
	end
	if band(tonumber(dstGUID:sub(0,5), 16), 0x00f) == 0x000 then
		return  -- the destination is a player and we only care about stuff to mobs
	end
	if (subevent == "SPELL_MISSED" or subevent == "SPELL_AURA_APPLIED") and RaidBuffStatus.db.profile.tankwarn then
		RaidBuffStatus:TauntEventLog(event, timestamp, subevent, srcGUID, srcname, srcflags, dstGUID, dstname, dstflags, spellID, spellname, spellschool, extraspellID, extraspellname)
	elseif spellname and spellID and (subevent == "SPELL_AURA_BROKEN" or subevent == "SPELL_AURA_BROKEN_SPELL" ) and ccspellshash[spellname] and RaidBuffStatus.db.profile.ccwarn then
		RaidBuffStatus:CCEventLog(event, timestamp, subevent, srcGUID, srcname, srcflags, dstGUID, dstname, dstflags, spellID, spellname, spellschool, extraspellID, extraspellname)
	
	end
end

function RaidBuffStatus:MisdirectionEventLog(srcname, spellname, dstname)
	if RaidBuffStatus.db.profile.misdirectionself then
		UIErrorsFrame:AddMessage(L["%s cast %s on %s"]:format(srcname, spellname, dstname), 0, 1.0, 1.0, 1.0, 1)
		RaidBuffStatus:Print(L["%s cast %s on %s"]:format(srcname, spellname, dstname))
	end
	if RaidBuffStatus.db.profile.misdirectionsound then
		PlaySoundFile("Sound\\Doodad\\ET_Cage_Close.wav")
	end
end


function RaidBuffStatus:CCEventLog(event, timestamp, subevent, srcGUID, srcname, srcflags, dstGUID, dstname, dstflags, spellID, spellname, spellschool, extraspellID, extraspellname)
	if not spellID or not dstGUID or not srcname then
		return
	end
	if band(tonumber(dstGUID:sub(0,5), 16), 0x00f) ~= 0x003 then
		return  -- the destination is not a creature
	end
	if RaidBuffStatus.db.profile.cconlyme and not srcGUID == playerid then
		return
	end
	local unit = RaidBuffStatus:GetUnitFromName(srcname)
	if not unit then
		return
	end
	local cctype = "ccwarnnontank"
	local prepend =  true
	if unit.istank then
		cctype = "ccwarntank"
		prepend = false
	end
	local dsticon = dstflags and RaidBuffStatus:GetIcon(dstflags) or ""
	if dsticon ~= "" then
		dsticon = "{rt" .. dsticon .. "}"
	end
	if subevent == "SPELL_AURA_BROKEN" then
		if prepend then
			RaidBuffStatus:CCBreakSay((L["Non-tank %s broke %s on %s%s%s"]):format(srcname, spellname, dsticon, dstname, dsticon), cctype)
		else
			RaidBuffStatus:CCBreakSay((L["%s broke %s on %s%s%s"]):format(srcname, spellname, dsticon, dstname, dsticon), cctype)
		end
		
	elseif subevent == "SPELL_AURA_BROKEN_SPELL" then
		if prepend then
			RaidBuffStatus:CCBreakSay((L["Non-tank %s broke %s on %s%s%s with %s"]):format(srcname, spellname, dsticon, dstname, dsticon, extraspellname), cctype)
		else
			RaidBuffStatus:CCBreakSay((L["%s broke %s on %s%s%s with %s"]):format(srcname, spellname, dsticon, dstname, dsticon, extraspellname), cctype)
		end
	end
end


function RaidBuffStatus:TauntEventLog(event, timestamp, subevent, srcGUID, srcname, srcflags, dstGUID, dstname, dstflags, spellID, spellname, spellschool, misstype)
	local targetid = UnitGUID("target")
	local mytarget = true
	if dstGUID ~= targetid then
		if not RaidBuffStatus.db.profile.tauntmeself and not RaidBuffStatus.db.profile.tauntmesound and not RaidBuffStatus.db.profile.tauntmerw and not RaidBuffStatus.db.profile.tauntmeraid and not RaidBuffStatus.db.profile.tauntmeparty then
			return
		end
		if band(tonumber(dstGUID:sub(0,5), 16), 0x00f) ~= 0x003 then
			return  -- the destination is not a creature
		end
		mytarget = false
	end
	local boss = false
	if UnitLevel("target") == -1 then
		boss = true
	end
	if RaidBuffStatus.db.profile.bossonly and not boss then
		return
	end
	local dsticon = dstflags and RaidBuffStatus:GetIcon(dstflags) or ""
	if dsticon ~= "" then
		dsticon = "{rt" .. dsticon .. "}"
	end
	local miss = ""
	if subevent == "SPELL_MISSED" then
		if misstype == "EVADE" or misstype == "IMMUNE" then
			miss = L["[IMMUNE]"]
		else
			miss = L["[RESIST]"]
		end
	end
	if srcGUID == playerid then
		if subevent ~= "SPELL_MISSED" then
			return
		end
		for _,v in ipairs (taunts) do
			if spellID == v then
				if misstype == "EVADE" or misstype == "IMMUNE" then
					if boss then
						RaidBuffStatus:TauntSay(miss .. " " .. srcname .. L[" FAILED TO TAUNT his boss target ("] .. dsticon .. dstname .. dsticon .. L[") with "] .. spellname, "failedtauntimmune")
					else
						RaidBuffStatus:TauntSay(miss .. " " .. srcname .. L[" FAILED TO TAUNT his target ("] .. dsticon .. dstname .. dsticon .. L[") with "] .. spellname, "failedtauntimmune")
					end
					return
				else
					if boss then
						RaidBuffStatus:TauntSay(miss .. " " .. srcname .. L[" FAILED TO TAUNT his boss target ("] .. dsticon .. dstname .. dsticon .. L[") with "] .. spellname, "failedtauntresist")
					else
						RaidBuffStatus:TauntSay(miss .. " " .. srcname .. L[" FAILED TO TAUNT his target ("] .. dsticon .. dstname .. dsticon .. L[") with "] .. spellname, "failedtauntresist")
					end
					return
				end
			end
		end
		return
	end
	if not mytarget then
		if subevent ~= "SPELL_AURA_APPLIED" then
			return -- only care about suceeding taunts to mobs targeting me
		end
		for _,v in ipairs (taunts) do
			if spellID == v then
				if UnitGUID(srcname .. "-target") == dstGUID and UnitGUID(srcname .. "-target-target") == playerid then
					if boss then
						RaidBuffStatus:TauntSay(srcname .. L[" taunted my boss mob ("] .. dsticon .. dstname .. dsticon .. L[") with "] .. spellname, "tauntme")
					else
						RaidBuffStatus:TauntSay(srcname .. L[" taunted my mob ("] .. dsticon .. dstname .. dsticon .. L[") with "] .. spellname, "tauntme")
					end
				end
				return
			end
		end
		return
	end
	local ninja = false
	if UnitGUID("targettarget") == playerid then
		ninja = true
	end
	for _,v in ipairs (taunts) do
		if spellID == v then
			if subevent == "SPELL_AURA_APPLIED" then
				local unit = RaidBuffStatus:GetUnitFromName(srcname)
				if not unit then
					return
				end
				if unit.istank then
					if ninja then
						if boss then
							RaidBuffStatus:TauntSay(srcname .. L[" ninjaed my boss target ("] .. dsticon.. dstname .. dsticon .. L[") with "] .. spellname, "ninjataunt")
						else
							RaidBuffStatus:TauntSay(srcname .. L[" ninjaed my target ("] .. dsticon .. dstname .. dsticon .. L[") with "] .. spellname, "ninjataunt")
						end
					else
						if boss then
							RaidBuffStatus:TauntSay(srcname .. L[" taunted my boss target ("] .. dsticon .. dstname .. dsticon .. L[") with "] .. spellname, "taunt")
						else
							RaidBuffStatus:TauntSay(srcname .. L[" taunted my target ("] .. dsticon .. dstname .. dsticon .. L[") with "] .. spellname, "taunt")
						end
					end
				else
					if boss then
						RaidBuffStatus:TauntSay(L["NON-TANK "] .. srcname .. L[" taunted my boss target ("] .. dsticon .. dstname .. dsticon .. L[") with "] .. spellname, "nontanktaunt")
					else
						RaidBuffStatus:TauntSay(L["NON-TANK "] .. srcname .. L[" taunted my target ("] .. dsticon .. dstname .. dsticon .. L[") with "] .. spellname, "nontanktaunt")
					end
				end
				
			else
				if ninja then
					if boss then
						RaidBuffStatus:TauntSay(miss .. " " .. srcname .. L[" FAILED TO NINJA my boss target ("] .. dsticon .. dstname .. dsticon .. L[") with "] .. spellname, "otherfail")
					else
						RaidBuffStatus:TauntSay(miss .. " " .. srcname .. L[" FAILED TO NINJA my target ("] .. dsticon .. dstname .. dsticon .. L[") with "] .. spellname, "otherfail")
					end
				else
					if boss then
						RaidBuffStatus:TauntSay(miss .. " " .. srcname .. L[" FAILED TO TAUNT my boss target ("] .. dsticon .. dstname .. dsticon .. L[") with "] .. spellname, "otherfail")
					else
						RaidBuffStatus:TauntSay(miss .. " " .. srcname .. L[" FAILED TO TAUNT my target ("] .. dsticon .. dstname .. dsticon .. L[") with "] .. spellname, "otherfail")
					end
				end
			end
		end
	end
end

function RaidBuffStatus:TauntSay(msg, typeoftaunt)
	local canspeak = IsRaidLeader() or IsRaidOfficer()
	if typeoftaunt == "taunt" then
		if RaidBuffStatus.db.profile.tauntself then
			local fancyicon = RaidBuffStatus:MakeFancyIcon(msg)
			UIErrorsFrame:AddMessage(fancyicon, 0, 1.0, 1.0, 1.0, 1)
			RaidBuffStatus:Print(fancyicon)
		end
		if RaidBuffStatus.db.profile.tauntsound then
			PlaySoundFile("Sound\\interface\\PickUp\\PickUpMetalSmall.wav")
		end
		if RaidBuffStatus.db.profile.tauntrw then
			if not canspeak and raid.israid then
				RaidBuffStatus:OfficerWarning()
			else
				SendChatMessage(msg, "RAID_WARNING")
			end
		end
		if RaidBuffStatus.db.profile.tauntraid and not raid.isbattle then
			SendChatMessage(msg, "raid")
		end
		if RaidBuffStatus.db.profile.tauntparty and not raid.isbattle then
			SendChatMessage(msg, "party")
		end
	elseif typeoftaunt == "failedtauntimmune" then
		if RaidBuffStatus.db.profile.failselfimmune then
			local fancyicon = RaidBuffStatus:MakeFancyIcon(msg)
			UIErrorsFrame:AddMessage(fancyicon, 0, 1.0, 1.0, 1.0, 1)
			RaidBuffStatus:Print(fancyicon)
		end
		if RaidBuffStatus.db.profile.failsoundimmune then
			PlaySoundFile("Sound\\Spells\\SimonGame_Visual_GameFailedLarge.wav")
		end
		if RaidBuffStatus.db.profile.failrwimmune then
			if not canspeak and raid.israid then
				RaidBuffStatus:OfficerWarning()
			else
				SendChatMessage(msg, "RAID_WARNING")
			end
		end
		if RaidBuffStatus.db.profile.failraidimmune and not raid.isbattle then
			SendChatMessage(msg, "raid")
		end
		if RaidBuffStatus.db.profile.failpartyimmune and not raid.isbattle then
			SendChatMessage(msg, "party")
		end
	elseif typeoftaunt == "failedtauntresist" then
		if RaidBuffStatus.db.profile.failselfresist then
			local fancyicon = RaidBuffStatus:MakeFancyIcon(msg)
			UIErrorsFrame:AddMessage(fancyicon, 0, 1.0, 1.0, 1.0, 1)
			RaidBuffStatus:Print(fancyicon)
		end
		if RaidBuffStatus.db.profile.failsoundresist then
			PlaySoundFile("Sound\\Spells\\SimonGame_Visual_GameFailedSmall.wav")
		end
		if RaidBuffStatus.db.profile.failrwresist then
			if not canspeak and raid.israid then
				RaidBuffStatus:OfficerWarning()
			else
				SendChatMessage(msg, "RAID_WARNING")
			end
		end
		if RaidBuffStatus.db.profile.failraidresist and not raid.isbattle then
			SendChatMessage(msg, "raid")
		end
		if RaidBuffStatus.db.profile.failpartyresist and not raid.isbattle then
			SendChatMessage(msg, "party")
		end
	elseif typeoftaunt == "ninjataunt" then
		if RaidBuffStatus.db.profile.ninjaself then
			local fancyicon = RaidBuffStatus:MakeFancyIcon(msg)
			UIErrorsFrame:AddMessage(fancyicon, 0, 1.0, 1.0, 1.0, 1)
			RaidBuffStatus:Print(fancyicon)
		end
		if RaidBuffStatus.db.profile.ninjasound then
			PlaySoundFile("Sound\\Doodad\\G_NecropolisWound.wav")
		end
		if RaidBuffStatus.db.profile.ninjarw then
			if not canspeak and raid.israid then
				RaidBuffStatus:OfficerWarning()
			else
				SendChatMessage(msg, "RAID_WARNING")
			end
		end
		if RaidBuffStatus.db.profile.ninjaraid and not raid.isbattle then
			SendChatMessage(msg, "raid")
		end
		if RaidBuffStatus.db.profile.ninjaparty and not raid.isbattle then
			SendChatMessage(msg, "party")
		end
	elseif typeoftaunt == "nontanktaunt" then
		if RaidBuffStatus.db.profile.nontanktauntself then
			local fancyicon = RaidBuffStatus:MakeFancyIcon(msg)
			UIErrorsFrame:AddMessage(fancyicon, 0, 1.0, 1.0, 1.0, 1)
			RaidBuffStatus:Print(fancyicon)
		end
		if RaidBuffStatus.db.profile.nontanktauntsound then
			PlaySoundFile("Sound\\Creature\\Voljin\\VoljinAggro01.wav")
		end
		if RaidBuffStatus.db.profile.nontanktauntrw then
			if not canspeak and raid.israid then
				RaidBuffStatus:OfficerWarning()
			else
				SendChatMessage(msg, "RAID_WARNING")
			end
		end
		if RaidBuffStatus.db.profile.nontanktauntraid and not raid.isbattle then
			SendChatMessage(msg, "raid")
		end
		if RaidBuffStatus.db.profile.nontanktauntparty and not raid.isbattle then
			SendChatMessage(msg, "party")
		end
	elseif typeoftaunt == "otherfail" then
		if RaidBuffStatus.db.profile.otherfailself then
			local fancyicon = RaidBuffStatus:MakeFancyIcon(msg)
			UIErrorsFrame:AddMessage(fancyicon, 0, 1.0, 1.0, 1.0, 1)
			RaidBuffStatus:Print(fancyicon)
		end
		if RaidBuffStatus.db.profile.otherfailsound then
			PlaySoundFile("Sound\\Doodad\\ZeppelinHeliumA.wav")
		end
		if RaidBuffStatus.db.profile.otherfailtauntrw then
			if not canspeak and raid.israid then
				RaidBuffStatus:OfficerWarning()
			else
				SendChatMessage(msg, "RAID_WARNING")
			end
		end
		if RaidBuffStatus.db.profile.otherfailtauntraid and not raid.isbattle then
			SendChatMessage(msg, "raid")
		end
		if RaidBuffStatus.db.profile.otherfailtauntparty and not raid.isbattle then
			SendChatMessage(msg, "party")
		end
	elseif typeoftaunt == "tauntme" then
		if RaidBuffStatus.db.profile.tauntmeself then
			local fancyicon = RaidBuffStatus:MakeFancyIcon(msg)
			UIErrorsFrame:AddMessage(fancyicon, 0, 1.0, 1.0, 1.0, 1)
			RaidBuffStatus:Print(fancyicon)
		end
		if RaidBuffStatus.db.profile.tauntmesound then
			PlaySoundFile("Sound\\interface\\MagicClick.wav")
		end
		if RaidBuffStatus.db.profile.tauntmerw then
			if not canspeak and raid.israid then
				RaidBuffStatus:OfficerWarning()
			else
				SendChatMessage(msg, "RAID_WARNING")
			end
		end
		if RaidBuffStatus.db.profile.tauntmeraid and not raid.isbattle then
			SendChatMessage(msg, "raid")
		end
		if RaidBuffStatus.db.profile.tauntmeparty and not raid.isbattle then
			SendChatMessage(msg, "party")
		end
	end
end


function RaidBuffStatus:CCBreakSay(msg, typeoftaunt)
	local canspeak = IsRaidLeader() or IsRaidOfficer()
	if typeoftaunt == "ccwarntank" then
		if RaidBuffStatus.db.profile.ccwarntankself then
			local fancyicon = RaidBuffStatus:MakeFancyIcon(msg)
			UIErrorsFrame:AddMessage(fancyicon, 0, 1.0, 1.0, 1.0, 1)
			RaidBuffStatus:Print(fancyicon)
		end
		if RaidBuffStatus.db.profile.ccwarntanksound then
			PlaySoundFile("Sound\\Creature\\Ram\\RamPreAggro.wav")
		end
		if RaidBuffStatus.db.profile.ccwarntankrw then
			if not canspeak and raid.israid then
				RaidBuffStatus:OfficerWarning()
			else
				SendChatMessage(msg, "RAID_WARNING")
			end
		end
		if RaidBuffStatus.db.profile.ccwarntankraid and not raid.isbattle then
			SendChatMessage(msg, "raid")
		end
		if RaidBuffStatus.db.profile.ccwarntankparty and not raid.isbattle then
			local fancyicon = RaidBuffStatus:MakeFancyIcon(msg)
			SendChatMessage(fancyicon, "party")
		end
	elseif typeoftaunt == "ccwarnnontank" then
		if RaidBuffStatus.db.profile.ccwarnnontankself then
			local fancyicon = RaidBuffStatus:MakeFancyIcon(msg)
			UIErrorsFrame:AddMessage(fancyicon, 0, 1.0, 1.0, 1.0, 1)
			RaidBuffStatus:Print(fancyicon)
		end
		if RaidBuffStatus.db.profile.ccwarnnontanksound then
			PlaySoundFile("Sound\\Creature\\Sheep\\SheepDeath.wav")
		end
		if RaidBuffStatus.db.profile.ccwarnnontankrw then
			if not canspeak and raid.israid then
				RaidBuffStatus:OfficerWarning()
			else
				SendChatMessage(msg, "RAID_WARNING")
			end
		end
		if RaidBuffStatus.db.profile.ccwarnnontankraid and not raid.isbattle then
			SendChatMessage(msg, "raid")
		end
		if RaidBuffStatus.db.profile.ccwarnnontankparty and not raid.isbattle then
			SendChatMessage(msg, "party")
		end
	end
end

function RaidBuffStatus:MakeFancyIcon(msg)
	if not msg then
		msg = "nil"
	end
	while (msg:find("{rt(%d)}")) do
		local pos,_,num = msg:find("{rt(%d)}")
		local path = COMBATLOG_OBJECT_RAIDTARGET1 * (num ^ (num - 1))
		msg = msg:sub(1, pos - 1) .. "|Hicon:"..path..":dest|h|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_"..num..".blp:0|t|h" .. msg:sub(pos + 5)
	end
	return msg
end


function RaidBuffStatus:OfficerWarning()
	UIErrorsFrame:AddMessage("RBS: " .. L["You need to be leader or assistant to do this"], 0, 1.0, 1.0, 1.0, 1);
	RaidBuffStatus:Print(L["You need to be leader or assistant to do this"])
end

function RaidBuffStatus:TriggerXPerlTankUpdate()
	xperltankrequest = true
	xperltankrequestt = GetTime() + 5 -- wait for 5 seconds to allow message to be processed by other addons before reading tank list again
end

function RaidBuffStatus:CHAT_MSG_ADDON(CHAT_MSG_ADDON, prefix, message, distribution, sender)
--	RaidBuffStatus:Debug(message)
	if prefix == "CTRA" and distribution == "RAID" and message and message:find("^DUR") then
		local cur, max, broken, requestby = select(3, message:find("^DUR (%d+) (%d+) (%d+) ([^%s]+)$"))
		if cur and requestby then
			local p = math.floor(cur / max * 100)
			RaidBuffStatus.durability[sender] = p
			RaidBuffStatus.broken[sender] = broken
			if nextdurability - GetTime() < 10 then
				nextdurability = GetTime() + 30  -- stops it calling again too often when another person or addon does a durability check
			end
		end
		return
	elseif prefix == "CTRA" and distribution == "RAID" and message and message:find("^ITM ") then
		local numitems, itemname, requestby = message:match("^ITM ([-%d]+) (.+) ([^%s]+)$")
		for itemcheck, _ in pairs(RaidBuffStatus.itemcheck) do
			if itemname == RaidBuffStatus.itemcheck[itemcheck].item then
				RaidBuffStatus.itemcheck[itemcheck].results[sender] = tonumber(numitems)
				if RaidBuffStatus.itemcheck[itemcheck].next - GetTime() < (RaidBuffStatus.itemcheck[itemcheck].frequencymissing - 15) then
					RaidBuffStatus.itemcheck[itemcheck].next = GetTime() + RaidBuffStatus.itemcheck[itemcheck].frequency
				end
				break
			end
		end
	elseif XPerl_MainTanks and prefix == "CTRA" and distribution == "RAID" and message then
		if strsub(message, 1, 4) == "SET " or strsub(message, 1, 2) == "R " then
			RaidBuffStatus:Debug("triggered xperl tank update")
			RaidBuffStatus:TriggerXPerlTankUpdate()
		end
	elseif prefix == "RBS" then
		if strsub(message, 1, 4) == "VER " then
			local _, _, revision, version = string.find(message, "^VER (.*) (.*)")
			RaidBuffStatus.rbsversions[sender] = version .. " build-" .. revision
			if not toldaboutnewversion and RaidBuffStatus.db.profile.versionannounce and revision > RaidBuffStatus.revision then
				toldaboutnewversion = true
				RaidBuffStatus:Print(L["%s has a newer version of RBS (%s) than you (%s)"]:format(sender, RaidBuffStatus.rbsversions[sender], RaidBuffStatus.version .. " build-" .. RaidBuffStatus.revision))
			end
		end
	elseif prefix ~= "PLPWR" or raid.isbattle then
		return
	end
--	RaidBuffStatus:Debug("Received prefix: " .. prefix .. " from: " .. sender .. ", message: " .. message)
	if string.find(message, "^MASSIGN") then
		local _, _, name, skill = string.find(message, "^MASSIGN (.*) (.*)")
		for _, class in ipairs(classes) do
			RaidBuffStatus:RemovePlayerPP(name, class)
		end
		if (skill + 0) > 0 then
			if RaidBuffStatus:CheckAssignNotHere(sender, name) then
				return
			end
			for i, class in ipairs(classes) do
				local spell = ppblessings[skill]
				if spell then
					ppassignments[class][spell] = name
				end
			end
		end
--		RaidBuffStatus:SendPPMessage()
		return
	elseif string.find(message, "^ASSIGN") then
		local _, _, pname, c, s = string.find(message, "^ASSIGN (.*) (.*) (.*)")
		if pname then
			local class = ppclasses[c]
			if class then
				RaidBuffStatus:RemovePlayerPP(pname, class)
				if (s + 0) > 0 then
					if RaidBuffStatus:CheckAssignNotHere(sender, pname) then
						return
					end
					local skill = ppblessings[s]
					if skill then
						ppassignments[class][skill] = pname
					end
				end
			end
		end
--		RaidBuffStatus:SendPPMessage()
		return
	elseif string.find(message, "^SELF") then
		local assign = select(4, string.find(message, "SELF ([0-9n]*)@([0-9n]*)"))
		if assign then
			RaidBuffStatus:RemovePlayerPP(sender)
			pppallies[sender] = true
			for i, class in ipairs(classes) do
				local ass = string.sub(assign, i, i)
				local spell = ppblessings[ass]
				if spell then
					ppassignments[class][spell] = sender
				end
			end
		end
	elseif string.find(message, "^NASSIGN") then
--		RaidBuffStatus:Debug("Received prefix: " .. prefix .. " from: " .. sender .. ", message: " .. message)
		for pname, class, tname, skill in string.gmatch(string.sub(message, 9), "([^@]*) ([^@]*) ([^@]*) ([^@]*)") do
			if not ppassignments[tname] then
				ppassignments[tname] = {}
			end
			if (skill + 0) > 0 then
				if RaidBuffStatus:CheckAssignNotHere(sender, pname) then
					return
				end
				local spell = ppblessings[skill]
				if spell then
					ppassignments[tname][spell] = pname
				end
			else
				for spell,_ in pairs(ppassignments[tname]) do
					if ppassignments[tname][spell] == pname then
						ppassignments[tname][spell] = nil
					end
				end
			end
		end
--		RaidBuffStatus:SendPPMessage()
	elseif string.find(message, "^FREEASSIGN") then
		if not pallypowersendersseen[sender] then
			pallypowersendersseen[sender] = true
			RaidBuffStatus:Debug("Not seen:" .. sender)
			RaidBuffStatus:SendPPMessage()
		end
	elseif string.find(message, "^CLEAR") then
		RaidBuffStatus:ClearPPAssignments()
		RaidBuffStatus:Debug("CLEAR:" .. sender)
		RaidBuffStatus:SendPPMessage()
	end
end

function RaidBuffStatus:CheckAssignNotHere(sender, name)
	if sender ~= playername or toldaboutpallysetting > GetTime() then  -- only warns the if you are the person doing the setting
		return
	end
	if IsRaidLeader() or (IsRaidOfficer() and pppallies[playername]) then -- Limits to raid leader or officer who is a pally who has pally power
		if not RaidBuffStatus:GetUnitFromName(name) then
			toldaboutpallysetting = GetTime() + 5
			UIErrorsFrame:AddMessage(L["%s is setting Pally Power for %s but they are not in the raid/party"]:format(sender, name), 0, 1.0, 1.0, 1.0, 1)
			RaidBuffStatus:Print(L["%s is setting Pally Power for %s but they are not in the raid/party"]:format(sender, name))
			PlaySoundFile("Sound\\Creature\\Voljin\\VoljinAggro01.wav")
			return true
		end
		return false
	end
end

function RaidBuffStatus:ClearPPAssignments()
	for class, c in pairs(ppassignments) do
		ppassignments[class] = {}
	end
end

function RaidBuffStatus:CleanPPAssignments()
	local assignedleft = {}
	for class, c in pairs(ppassignments) do -- not just class but also single players
		for spell, name in pairs(c) do
			local found = false
			for pname,_ in pairs(raid.classes.PALADIN) do
				if name == pname then
					found = true
					break
				end
			end
			if not found then
				ppassignments[class][spell] = nil
				assignedleft[name] = true
			end
		end
	end
	for name,_ in pairs(pppallies) do
		if not raid.classes.PALADIN[name] then
			RaidBuffStatus.pppallies[name] = nil -- remove as no longer in raid
		end
	end
	if IsRaidLeader() or (IsRaidOfficer() and pppallies[playername])  then -- Limits to raid leader or officer who is a pally who has pally power
		for name,_ in pairs(assignedleft) do
			RaidBuffStatus:Debug("Delayed pala leaving scheduled:" .. name)
			RaidBuffStatus:ScheduleTimer(function()
				if raid.israid and ((raid.size >= 23 and raid.size <= 25) or (raid.size >= 9 and raid.size <= 10)) then  -- idea is to warn only when it's one guy swapping not when everyone is leaving the raid
					UIErrorsFrame:AddMessage(L["Paladin %s has left the raid and had Pally Power blessings assigned to them"]:format(name), 0, 1.0, 1.0, 1.0, 1)
					RaidBuffStatus:Print(L["Paladin %s has left the raid and had Pally Power blessings assigned to them"]:format(name))
					PlaySoundFile("Sound\\Creature\\MrSmite\\MrSmiteAlarm01.wav")
				end
			end, 10)
		end
	end
end

function RaidBuffStatus:RemovePlayerPP(sender, classonly)
	for class, c in pairs(ppassignments) do -- not just class but also single players
		if not classonly or class == classonly then
			for spell, name in pairs(c) do
				if name == sender then
					ppassignments[class][spell] = nil
				end
			end
		end
	end
end

function RaidBuffStatus:GetPaladinsAssignments(name, short)
	local spellindex = {}
	for class, c in pairs(ppassignments) do
		if (raid.ClassNumbers[class] and raid.ClassNumbers[class] > 0) or not raid.ClassNumbers[class] then -- handles single buffs too not just class
			for spell, pname in pairs(c) do
				if pname == name then
					if short then
						spellindex[longtoshortblessing[spell]] = true
					else
						spellindex[spell] = true
					end
				end
			end
		end
	end
	local spells = {}
	for spell, _ in pairs (spellindex) do
		table.insert(spells, spell)
	end
	return spells
end

function RaidBuffStatus:FindPaladinsResponsible(whichmiss)
	local palaindex = {}
	for class, v in pairs(whichmiss) do
		for tname, spellsmiss in pairs(v) do
			for _,spellmiss in ipairs(spellsmiss) do
				for assclass, c in pairs(ppassignments) do
					if assclass == class or assclass == tname then
						for spell, pname in pairs(c) do
							if spell == spellmiss then
								if not palaindex[pname] then
									palaindex[pname] = {}
								end
								if not palaindex[pname][tname] or assclass == tname then  -- if assclass == tname then it's a short buff so overrides a long assignment
									palaindex[pname][tname] = {}
									palaindex[pname][tname][spell] = {}
									if assclass == class then
										palaindex[pname][tname][spell].class = true
									end
								end
								break
							end
						end
					end
				end
			end
		end
	end
	return palaindex
end

--function RaidBuffStatus:IsPPAssigned(name, class, blessing)
--	local whichmiss = {}
--	whichmiss[class] = {}
--	whichmiss[class][name] = {}
--	whichmiss[class][name][1] = blessing
--	RaidBuffStatus:Debug("looking for:" .. blessing .. " on " .. name)
--	if RaidBuffStatus:DicSize(RaidBuffStatus:FindPaladinsResponsible(whichmiss)) > 0 then
--		RaidBuffStatus:Debug("found a pala")
--		return true
--	end
--	RaidBuffStatus:Debug("not found a pala")
--	return false
--end

function RaidBuffStatus:SendPPMessage(force)
	RaidBuffStatus:Debug("SendPPMessage()")
	if incombat then
		RaidBuffStatus:Debug("in combat")
		return
	end
	if raid.isbattle then
		RaidBuffStatus:Debug("isbattle")
		return
	end
	if force then
		SendAddonMessage("PLPWR", "REQ", "RAID")
		return
	end
	if not RaidBuffStatus.ppmsgqueued then
		RaidBuffStatus:Debug("Delayed PLPWR scheduled")
		RaidBuffStatus.ppmsgqueued = true
		RaidBuffStatus:ScheduleTimer(function()
			SendAddonMessage("PLPWR", "REQ", "RAID")
			RaidBuffStatus.ppmsgqueued = false
			RaidBuffStatus:Debug("Delayed PLPWR called")
		end, 15)
	end
end

function RaidBuffStatus:SendVersion()
	local version = RaidBuffStatus.revision .. " " .. RaidBuffStatus.version
	if raid.israid then
		SendAddonMessage("RBS", "VER " .. version, "RAID")
	elseif raid.isparty then
		SendAddonMessage("RBS", "VER " .. version, "PARTY")
	else
		SendAddonMessage("RBS", "VER " .. version, "GUILD")
	end
end



function RaidBuffStatus:CreateBar(currenty, name, text, r, g, b, a, tooltip)
	if RaidBuffStatus.bars[name] then
		RaidBuffStatus.bars[name].barframe:SetPoint("BOTTOMLEFT", RaidBuffStatus.frame, "BOTTOMLEFT", 10, currenty)
		RaidBuffStatus.bars[name].barframe:Show()
		return
	end
	local barframe = CreateFrame("Button", nil, RaidBuffStatus.frame)
	barframe:SetHeight(10)
	barframe:SetPoint("BOTTOMLEFT", RaidBuffStatus.frame, "BOTTOMLEFT", 10, currenty)

	local bar = barframe:CreateTexture()
	bar:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	bar:SetPoint("TOPLEFT", barframe, "TOPLEFT", 0, 0)
	bar:SetHeight(10)
	bar:SetGradientAlpha("HORIZONTAL", r, g, b, a, 0.3, 0.3, 0.3, a)

	local bartext = barframe:CreateFontString(nil, "ARTWORK","GameFontNormalSmall")
	bartext:SetPoint("LEFT", barframe, "LEFT", 0, 1)
	bartext:SetFont(bartext:GetFont(), 9)
	bartext:SetShadowColor(0, 0, 0, 1)
	bartext:SetText(text)

	local barvalue = barframe:CreateFontString(nil, "ARTWORK","GameFontNormalSmall")
	barvalue:SetPoint("RIGHT", barframe, "RIGHT", 0, 1)
	barvalue:SetFont(barvalue:GetFont(), 8)
	bartext:SetShadowColor(0, 0, 0, 1)
	barvalue:SetText("100%")

	if tooltip then
		barframe:SetScript("OnEnter", function (self)
			tooltip(self)
			RaidBuffStatus.tooltipupdate = function ()
				tooltip(self)
			end
		end)
		barframe:SetScript("OnLeave", function()
			RaidBuffStatus.tooltipupdate = nil
			GameTooltip:Hide()
		end)
	end

	RaidBuffStatus.bars[name] = {}
	RaidBuffStatus.bars[name].barframe = barframe
	RaidBuffStatus.bars[name].bar = bar
	RaidBuffStatus.bars[name].bartext = bartext
	RaidBuffStatus.bars[name].barvalue = barvalue
end

function RaidBuffStatus:SetBarsWidth()
	local width = RaidBuffStatus.frame:GetWidth() - 20
	for _,v in pairs(RaidBuffStatus.bars) do
		v.barframe:SetWidth(width)
		v.bar:SetWidth(width)
	end
end

function RaidBuffStatus:SetPercent(name, percent)
	local percentwidth
	if percent == L["n/a"] then
		percentwidth = 1
	elseif percent > 99 then
		percent = 100
		percentwidth = RaidBuffStatus.bars[name].barframe:GetWidth()
	elseif percent < 1 then
		percentwidth = 1
		percent = 0
	else
		percentwidth = RaidBuffStatus.bars[name].barframe:GetWidth() / 100 * percent
	end
	RaidBuffStatus.bars[name].bar:SetWidth(percentwidth)
	RaidBuffStatus.bars[name].barvalue:SetText(percent .. "%")
end

function RaidBuffStatus:HideAllBars()
	for _,v in pairs(RaidBuffStatus.bars) do
		v.barframe:Hide()
	end
end

function RaidBuffStatus:BarTip(owner, title, list)
	GameTooltip:SetOwner(owner, "ANCHOR_LEFT")
	GameTooltip:SetText(title,1,1,1,1,1)
	if list then
		for name, percent in pairs(list) do
			local class = RaidBuffStatus:GetUnitFromName(name).class
			GameTooltip:AddDoubleLine(name, percent, RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)
		end
	end
	GameTooltip:Show()
end

function RaidBuffStatus:AmIListed(list)
	if not list then
		return
	end
	for _,v in ipairs(list) do
		local name = v
		if v:find("%(") then
			name = string.sub(v, 1, v:find("%(") - 1)
		end
		if name == playername then
			return true
		end
	end
	return false
end

function RaidBuffStatus:RefreshTalents()
	GT:PurgeAndRescanTalents()
	for class,_ in pairs(raid.classes) do
		for name,rcn in pairs(raid.classes[class]) do
			rcn.talents = nil
			rcn.spec = "UNKNOWN"
			rcn.specicon = "UNKNOWN"
		end
	end
	RaidBuffStatus:UpdateTalentsFrame()
end

function RaidBuffStatus:CHAT_MSG_MONSTER_EMOTE(chan, message, who, callback)
	if not message or not who then
		return
	end
	if raid.isbattle then
		RaidBuffStatus:Debug("battle")
		return
	end
	local isdead = UnitIsDeadOrGhost("player") or false

--	RaidBuffStatus:Debug(":" .. chan .. ":" .. who .. ":" .. message .. ":")
	local msg = ""
	local canspeak = IsRaidLeader() or IsRaidOfficer()
	if RaidBuffStatus.db.profile.fishfeast then
		if message == "Fish" then
			if not callback or callback ~= "callback" then
				RaidBuffStatus:ScheduleTimer(function()
					RaidBuffStatus:CHAT_MSG_MONSTER_EMOTE(chan, message, who, "callback")
				end, RaidBuffStatus:calcdelay())
				return
			end
			if GetTime() > nextfeastannounce and RaidBuffStatus:GetUnitFromName(who) then
				msg = who .. " " .. L["prepares a Fish Feast!"]
				nextfeastannounce = GetTime() + 15
				RaidBuffStatus:ScheduleTimer(function()
					RaidBuffStatus:CHAT_MSG_MONSTER_EMOTE(chan, "FishExpiring", who)
				end, 130)
			end
			RaidBuffStatus:PingMinimap(who)
		elseif message == "FishExpiring" and not incombat and not isdead then
			if report.foodlist then
				if #report.foodlist == 1 then
					msg = L["Fish Feast about to expire!"] .. " " .. report.foodlist[1]
				elseif #report.foodlist > 1 then
					msg = L["Fish Feast about to expire!"]
				end
				if canspeak and RaidBuffStatus.db.profile.feastautowhisper and #report.foodlist > 0 then
					RaidBuffStatus:DoReport()
					if report.foodlist and #report.foodlist > 0 then
						for _,name in ipairs(report.foodlist) do
							RaidBuffStatus:Say("<" .. L["Not Well Fed"] .. ">: " .. name, name)
						end
					end
				end
			else
				msg = L["Fish Feast about to expire!"]
			end
		end
	end
	if RaidBuffStatus.db.profile.refreshmenttable then
		if message == "Table" then
			if not callback or callback ~= "callback" then
				RaidBuffStatus:ScheduleTimer(function()
					RaidBuffStatus:CHAT_MSG_MONSTER_EMOTE(chan, message, who, "callback")
				end, RaidBuffStatus:calcdelay())
--				RaidBuffStatus:Debug("Table callback")
				return
			end
			if GetTime() > nexttableannounce and RaidBuffStatus:GetUnitFromName(who) then
				msg = who .. L[" has set us up a Refreshment Table"]
				nexttableannounce = GetTime() + 15
				RaidBuffStatus:ScheduleTimer(function()
					RaidBuffStatus:CHAT_MSG_MONSTER_EMOTE(chan, "TableExpiring", who)
				end, 130)
			end
			RaidBuffStatus:PingMinimap(who)
		elseif message == "TableExpiring" and not incombat and not isdead then
			msg = L["Refreshment Table about to expire!"]
		end
	end
	if RaidBuffStatus.db.profile.soulwell then
		if message == "Soul" then
			if not callback or callback ~= "callback" then
				RaidBuffStatus:ScheduleTimer(function()
					RaidBuffStatus:CHAT_MSG_MONSTER_EMOTE(chan, message, who, "callback")
				end, RaidBuffStatus:calcdelay())
				return
			end
			local unit = RaidBuffStatus:GetUnitFromName(who)
			if GetTime() > nextsoulannounce and unit then
				local bonus = ""
				if unit.talents then
					if unit.specialisations.improvedhealthstonetwo then
						bonus = " (5k)"
					elseif unit.specialisations.improvedhealthstoneone then
						bonus = " (4.5k)"
					else
						bonus = " (4k)"
					end
				end
				msg = who .. L[" has set us up a Soul Well"] .. bonus
				nextsoulannounce = GetTime() + 15
				RaidBuffStatus:ScheduleTimer(function()
					RaidBuffStatus:CHAT_MSG_MONSTER_EMOTE(chan, "SoulExpiring", who)
				end, 130)
			end
			RaidBuffStatus:PingMinimap(who)
		elseif message == "SoulExpiring" and not incombat and not isdead then
			if report.healthstonelist then
				if #report.healthstonelist == 1 then
					msg = L["Soul Well about to expire!"] .. " " .. report.healthstonelist[1]
				elseif #report.healthstonelist > 1 then
					msg = L["Soul Well about to expire!"]
				end
				if canspeak and RaidBuffStatus.db.profile.wellautowhisper and #report.healthstonelist > 0 then
					RaidBuffStatus:DoReport()
					if report.healthstonelist and #report.healthstonelist > 0 then
						for _,name in ipairs(report.healthstonelist) do
							RaidBuffStatus:Say("<" .. L["Missing "] .. BS[5720] .. ">: " .. name, name)
						end
					end
				end
			else
				msg = L["Soul Well about to expire!"]
			end
		end
	end
	if RaidBuffStatus.db.profile.repair then
		if message == "Repair" then
			if not callback or callback ~= "callback" then
				RaidBuffStatus:ScheduleTimer(function()
					RaidBuffStatus:CHAT_MSG_MONSTER_EMOTE(chan, message, who, "callback")
				end, RaidBuffStatus:calcdelay())
				return
			end
			if GetTime() > nextrepairannounce and RaidBuffStatus:GetUnitFromName(who) then
				msg = who .. L[" has set us up a Repair Bot"]
				nextrepairannounce = GetTime() + 15
				RaidBuffStatus:ScheduleTimer(function()
					RaidBuffStatus:CHAT_MSG_MONSTER_EMOTE(chan, "RepairExpiring", who)
				end, 540)
			end
			RaidBuffStatus:PingMinimap(who)
		elseif message == "RepairExpiring" and not incombat and not isdead then
			if not raid.LastDeath[name] or (raid.LastDeath[name] and GetTime() - raid.LastDeath[name] > 540) then
				msg = L["Repair Bot about to expire!"]
			else
				RaidBuffStatus:Debug("Not announcing bot expire as bot person has died.")
			end
		end
	end
	if msg == "" then
		return
	end
	if canspeak then
		SendChatMessage(msg, "RAID_WARNING")
	else
		UIErrorsFrame:AddMessage(msg, 0, 1.0, 1.0, 1.0, 1)
		RaidBuffStatus:Print(msg)
	end
end

function RaidBuffStatus:CHAT_MSG_RAID_WARNING(chan, message, who)
	if not message or not who then
		return
	end
	if message:find(L[" has set us up a Refreshment Table"]) then
		nexttableannounce = GetTime() + 15
	elseif message:find(L["prepares a Fish Feast!"]) then
		nextfeastannounce = GetTime() + 15
	elseif message:find(L[" has set us up a Soul Well"]) then
		nextsoulannounce = GetTime() + 15
	elseif message:find(L[" has set us up a Repair Bot"]) then
		RaidBuffStatus:Debug("Bot warning detected.")
		nextrepairannounce = GetTime() + 15
	end
end

function RaidBuffStatus:calcdelay()
	if IsRaidLeader() or not RaidBuffStatus.db.profile.antispam then
		return 0.1 -- don't wait when leader
	elseif IsRaidOfficer() then
		local unit = RaidBuffStatus:GetUnitFromName(playername)
		if unit then
			local guidlist = {}
			for class,_ in pairs(raid.classes) do
				for name,_ in pairs(raid.classes[class]) do
					table.insert(guidlist, raid.classes[class][name].guid)
				end
			end
			table.sort(guidlist)
			local pos = 40
			for i, g in ipairs(guidlist) do
				if g == playerid then
					pos = i
					break
				end
			end
			local delay = pos * 0.5 + 0.3
			return delay
		end
	end
	return 10
end

function RaidBuffStatus:PingMinimap(whom)
	if not Minimap:IsVisible() then
		return
	end
	if whom == playername then
		Minimap:PingLocation(0,0) -- it's me
		return
	end
	local myx, myy = GetPlayerMapPosition("player")
	local hisx, hisy = GetPlayerMapPosition(whom)
	local hisx = 0.280537
	local hisy = 0.698122
	if (myx == 0 and myy == 0) or (hisx == 0 and hisy == 0) then
		return -- can't get coords
	end
	
	if true then
		return -- does not work yet..... so return
	end

	local zoneheight = 527.6066263822604 -- Blizz PLEASE provide an API for reading this!
	local zonewidth = 790.625237342102

	myy =  myy * zoneheight
	hisy = hisy * zoneheight
	myx = myx * zonewidth
	hisx = hisx * zonewidth

	local pingx = hisx - myx -- now distance in yards
	local pingy = hisy - myy

	local mapWidth = Minimap:GetWidth()
	local mapHeight = Minimap:GetHeight()
	local minimapZoom = Minimap:GetZoom()
	local mapDiameter;
	local minimapOutside
	if ( GetCVar("minimapZoom") == Minimap:GetZoom() ) then
		mapDiameter = MinimapSize.outdoor[minimapZoom]
	else
		mapDiameter = MinimapSize.indoor[minimapZoom]
	end
	local xscale = mapDiameter / mapWidth
	local yscale = mapDiameter / mapHeight

	if GetCVar("rotateMinimap") ~= "0" then
		RaidBuffStatus:Debug("rotated minimap")
		local minimapRotationOffset = GetPlayerFacing()
		local sinTheta = sin(minimapRotationOffset)
		local cosTheta = cos(minimapRotationOffset)
		local dx, dy = pingx, pingy
		pingx = (dx * cosTheta) - (dy * sinTheta)
		pingy = (dx * sinTheta) + (dy * cosTheta)
	end
	RaidBuffStatus:Debug("minimapZoom:" .. minimapZoom)
	RaidBuffStatus:Debug(pingx .. " " .. pingy)

	Minimap:PingLocation(pingx / xscale, -pingy / yscale)
end


function RaidBuffStatus:GetIcon(flag)
	if band(flag, COMBATLOG_OBJECT_SPECIAL_MASK) == 0 then
		return
	end
	for i = 1, 8 do
		local mask = COMBATLOG_OBJECT_RAIDTARGET1 * (2 ^ (i - 1))
		local mark = (band(flag, mask) == mask)
		if mark then
			return i
		end
	end
	return nil
end

function RaidBuffStatus:SayMe(msg)
	RaidBuffStatus:Print(msg)
	UIErrorsFrame:AddMessage(msg, 0, 1.0, 1.0, 1.0, 1)
end

function RaidBuffStatus:SelectPalaAura()
	if not raid.classes.PALADIN[playername] then
		return nil
	end
	local auraspell = SpellName(465) -- Devotion Aura
	if raid.classes.PALADIN[playername].talents then
		if raid.classes.PALADIN[playername].spec == L["Retribution"] then
			auraspell = SpellName(7294) -- Retribution Aura
		elseif raid.classes.PALADIN[playername].spec == L["Holy"] then
			auraspell = SpellName(19746) -- Concentration Aura
		end
	end
	return auraspell
end

function RaidBuffStatus:SomebodyDied(unit)
	local unitid = unit.unitid
	local name = unit.name
	raid.LastDeath[name] = GetTime()
	if not RaidBuffStatus.db.profile.deathwarn then
		return
	end
	if unitid and not UnitIsFeignDeath(unitid) then
		if unit.istank then
--			RaidBuffStatus:Debug(L["Tank %s has died!"]:format(name), "tank")
			RaidBuffStatus:DeathSay(L["Tank %s has died!"]:format(name), "tank")
		elseif unit.ishealer then
--			RaidBuffStatus:Debug(L["Healer %s has died!"]:format(name), "healer")
			RaidBuffStatus:DeathSay(L["Healer %s has died!"]:format(name), "healer")
		elseif unit.ismeleedps then
--			RaidBuffStatus:Debug(L["Melee DPS %s has died!"]:format(name), "meleedps")
			RaidBuffStatus:DeathSay(L["Melee DPS %s has died!"]:format(name), "meleedps")
		elseif unit.israngeddps then
--			RaidBuffStatus:Debug(L["Ranged DPS %s has died!"]:format(name), "rangeddps")
			RaidBuffStatus:DeathSay(L["Ranged DPS %s has died!"]:format(name), "rangeddps")
		end
	end
end


function RaidBuffStatus:DeathSay(msg, typeofdeath)
	local canspeak = IsRaidLeader() or IsRaidOfficer()
	if typeofdeath == "tank" then
		if RaidBuffStatus.db.profile.tankdeathself then
			UIErrorsFrame:AddMessage(msg, 0, 1.0, 1.0, 1.0, 1)
			RaidBuffStatus:Print(msg)
		end
		if RaidBuffStatus.db.profile.tankdeathsound then
			PlaySoundFile("Sound\\interface\\igQuestFailed.wav")
		end
		if RaidBuffStatus.db.profile.tankdeathrw then
			if not canspeak and raid.israid then
				RaidBuffStatus:OfficerWarning()
			else
				SendChatMessage(msg, "RAID_WARNING")
			end
		end
		if RaidBuffStatus.db.profile.tankdeathraid and not raid.isbattle then
			SendChatMessage(msg, "raid")
		end
		if RaidBuffStatus.db.profile.tankdeathparty and not raid.isbattle then
			SendChatMessage(msg, "party")
		end
	elseif typeofdeath == "healer" then
		if RaidBuffStatus.db.profile.healerdeathself then
			UIErrorsFrame:AddMessage(msg, 0, 1.0, 1.0, 1.0, 1)
			RaidBuffStatus:Print(msg)
		end
		if RaidBuffStatus.db.profile.healerdeathsound then
			PlaySoundFile("Sound\\Event Sounds\\Wisp\\WispPissed1.wav")
		end
		if RaidBuffStatus.db.profile.healerdeathrw then
			if not canspeak and raid.israid then
				RaidBuffStatus:OfficerWarning()
			else
				SendChatMessage(msg, "RAID_WARNING")
			end
		end
		if RaidBuffStatus.db.profile.healerdeathraid and not raid.isbattle then
			SendChatMessage(msg, "raid")
		end
		if RaidBuffStatus.db.profile.healerdeathparty and not raid.isbattle then
			SendChatMessage(msg, "party")
		end
	elseif typeofdeath == "meleedps" then
		if RaidBuffStatus.db.profile.meleedpsdeathself then
			UIErrorsFrame:AddMessage(msg, 0, 1.0, 1.0, 1.0, 1)
			RaidBuffStatus:Print(msg)
		end
		if RaidBuffStatus.db.profile.meleedpsdeathsound then
			PlaySoundFile("Sound\\interface\\iCreateCharacterA.wav")
		end
		if RaidBuffStatus.db.profile.meleedpsdeathrw then
			if not canspeak and raid.israid then
				RaidBuffStatus:OfficerWarning()
			else
				SendChatMessage(msg, "RAID_WARNING")
			end
		end
		if RaidBuffStatus.db.profile.meleedpsdeathraid and not raid.isbattle then
			SendChatMessage(msg, "raid")
		end
		if RaidBuffStatus.db.profile.meleedpsdeathparty and not raid.isbattle then
			SendChatMessage(msg, "party")
		end
	elseif typeofdeath == "rangeddps" then
		if RaidBuffStatus.db.profile.rangeddpsdeathself then
			UIErrorsFrame:AddMessage(msg, 0, 1.0, 1.0, 1.0, 1)
			RaidBuffStatus:Print(msg)
		end
		if RaidBuffStatus.db.profile.rangeddpsdeathsound then
			PlaySoundFile("Sound\\interface\\iCreateCharacterA.wav")
		end
		if RaidBuffStatus.db.profile.rangeddpsdeathrw then
			if not canspeak and raid.israid then
				RaidBuffStatus:OfficerWarning()
			else
				SendChatMessage(msg, "RAID_WARNING")
			end
		end
		if RaidBuffStatus.db.profile.rangeddpsdeathraid and not raid.isbattle then
			SendChatMessage(msg, "raid")
		end
		if RaidBuffStatus.db.profile.rangeddpsdeathparty and not raid.isbattle then
			SendChatMessage(msg, "party")
		end
	end
end

function RaidBuffStatus:SelectSeal()
	if not raid.classes.PALADIN[playername] then
		return
	end
	if raid.classes.PALADIN[playername].spec == L["Holy"] then
		return BS[20165] -- Seal of Light
	end
	return BS[31801] -- Seal of Vengeance
end

function RaidBuffStatus:SelectRezSpell()
	if incombat then  -- this won't work as one can't change buttons during combat but I will fix it one day
		RaidBuffStatus:Debug("COMBAT")
		if raid.classes.DRUID[playername] then
			RaidBuffStatus:Debug("REBIRTH")
			return BS[20484] -- Rebirth
		end
		return
	elseif raid.classes.PALADIN[playername] then
		return BS[7328] -- Redemption
	elseif raid.classes.PRIEST[playername] then
		return BS[2006] -- Resurrection
	elseif raid.classes.SHAMAN[playername] then
		return BS[2008] -- Ancestral Spirit
	elseif raid.classes.DRUID[playername] then
		return BS[50769] -- Revive
	end
end

function RaidBuffStatus:LibGroupTalents_Update(e, guid, unit, spec, c1, c2, c3)
	local rcn = raid.classes[select(2, UnitClass(unit))][UnitName(unit)]
	if rcn == nil then
		return
	end
	rcn.specialisations = {}
	RaidBuffStatus:UpdateSpec(rcn, spec, c1, c2, c3)
	if RaidBuffStatus.talentframe:IsVisible() then
		RaidBuffStatus:UpdateTalentsFrame()
	end
end

function RaidBuffStatus:UpdateSpec(rcn, spec, c1, c2, c3)
	if spec == nil then
		rcn.talents = nil
		rcn.spec = "UNKNOWN"
		rcn.specicon = "UNKNOWN"
	else
		local t = 0
		if c1 > 36 then t = 1 end
		if c2 > 36 then t = 2 end
		if c3 > 36 then t = 3 end
		if t ~= 0 then
			rcn.spec = select(t, GT:GetTreeNames(rcn.class))
			rcn.specicon = select(t, GT:GetTreeIcons(rcn.class))
		else
			rcn.spec = "Hybrid"
			rcn.specicon = "UNKNOWN"
		end
		rcn.talents = true
	end
end

function RaidBuffStatus:UsePalaKings(raid, report)
	if not RaidBuffStatus.db.profile.checkdrumskings then
		return true
	end
	if raid.ClassNumbers.PALADIN > 3 then
		return true
	end
	if raid.ClassNumbers.PALADIN < 2 then
		return false
	end
	local gotwiz = false
	if (raid.maxbowpoints + 1) >= raid.maxrestorativetotemspoints then
		gotwiz = true
	end
	local gotsanc = false
	if # raid.SanctuaryTalent > 0 then
		gotsanc = true
	end
	if gotsanc and gotwiz then
		return false
	end
	if raid.ClassNumbers.PALADIN == 3 then
		return true  -- in this case 3 pala can do all the buffs
	end
	if gotsanc or gotwiz then
		return false
	end
--	if raid.ClassNumbers.HUNTER > 0 then
---		if gotsanc or gotwiz then
--			return false
--		end
--	end
--	for name,rcn in pairs(raid.classes.PALADIN) do
--		if rcn.spec == L["Retribution"] then
--			if gotsanc or gotwiz then
--				return false
--			end
--		end
--	end
--	for name,rcn in pairs(raid.classes.DRUID) do
--		if rcn.spec == L["Feral Combat"] then
--			if gotsanc or gotwiz then
--				return false
--			end
--		end
--	end
--	for name,rcn in pairs(raid.classes.SHAMAN) do
--		if rcn.spec == L["Enhancement"] then
--			if gotsanc or gotwiz then
--				return false
--			end
--		end
--	end
	return true -- in this case 2 pala can do all the buffs
end



function RaidBuffStatus:GetAllocatedBlessings(tname, class)
	local unitblessings = {}
	local seenpala = {}
	for i = 1, 2 do
		for assclass, c in pairs(ppassignments) do
			if (i == 1 and assclass == tname) or (i == 2 and assclass == class) then
				for spell, pname in pairs(c) do
					if not seenpala[pname] then  -- don't want to expect more than one blessing per pala.  Also need to get person specific blessings (short) first before class
						unitblessings[spell] = RaidBuffStatus.nametoblessinglist[spell]
						seenpala[pname] = true
					end
				end
			end
		end
	end
	return unitblessings
end



function RaidBuffStatus:SetAllOptions(mode)
	local BF = RaidBuffStatus.BF
	for buffcheck, _ in pairs(BF) do
		for _, defname in ipairs({"buff", "warning", "dash", "dashcombat", "boss", "trash"}) do
			if BF[buffcheck]["default" .. defname] then
				RaidBuffStatus.db.profile[buffcheck .. defname] = true
			else
				RaidBuffStatus.db.profile[buffcheck .. defname] = false
			end
		end
		local enable = false
		if mode == "justmybuffs" then
			if BF[buffcheck].class and BF[buffcheck].class[playerclass] then
				enable = true
				RaidBuffStatus.db.profile[buffcheck .. "dash"] = true
				RaidBuffStatus.db.profile[buffcheck .. "boss"] = true
				RaidBuffStatus.db.profile[buffcheck .. "trash"] = true
			end
		elseif mode == "raidleader" then
			if BF[buffcheck].default then
				enable = true
			end
		elseif mode == "coreraidbuffs" then
			if BF[buffcheck].core then
				enable = true
				RaidBuffStatus.db.profile[buffcheck .. "dash"] = true
--				RaidBuffStatus.db.profile[buffcheck .. "boss"] = true
--				RaidBuffStatus.db.profile[buffcheck .. "trash"] = true
			end
		end
		if enable then
			RaidBuffStatus.db.profile[BF[buffcheck].check] = true
		else
			RaidBuffStatus.db.profile[BF[buffcheck].check] = false
			RaidBuffStatus.db.profile[buffcheck .. "dash"] = false
		end
	end
	if mode == "justmybuffs" then
		RaidBuffStatus.db.profile.hidebossrtrash = true
		RaidBuffStatus.db.profile.RaidHealth = false
		RaidBuffStatus.db.profile.TankHealth = false
		RaidBuffStatus.db.profile.RaidMana = false
		RaidBuffStatus.db.profile.HealerMana = false
		RaidBuffStatus.db.profile.DPSMana = false
		RaidBuffStatus.db.profile.Alive = false
		RaidBuffStatus.db.profile.TanksAlive = false
		RaidBuffStatus.db.profile.HealersAlive = false
	elseif mode == "raidleader" then
		RaidBuffStatus.db.profile.hidebossrtrash = RaidBuffStatus.profiledefaults.profile.hidebossrtrash
		RaidBuffStatus.db.profile.RaidHealth = RaidBuffStatus.profiledefaults.profile.RaidHealth
		RaidBuffStatus.db.profile.TankHealth = RaidBuffStatus.profiledefaults.profile.TankHealth
		RaidBuffStatus.db.profile.RaidMana = RaidBuffStatus.profiledefaults.profile.RaidMana
		RaidBuffStatus.db.profile.HealerMana = RaidBuffStatus.profiledefaults.profile.HealerMana
		RaidBuffStatus.db.profile.DPSMana = RaidBuffStatus.profiledefaults.profile.DPSMana
		RaidBuffStatus.db.profile.Alive = RaidBuffStatus.profiledefaults.profile.Alive
		RaidBuffStatus.db.profile.TanksAlive = RaidBuffStatus.profiledefaults.profile.TanksAlive
		RaidBuffStatus.db.profile.HealersAlive = RaidBuffStatus.profiledefaults.profile.HealersAlive
	elseif mode == "coreraidbuffs" then
		RaidBuffStatus.db.profile.hidebossrtrash = false
		RaidBuffStatus.db.profile.RaidHealth = false
		RaidBuffStatus.db.profile.TankHealth = false
		RaidBuffStatus.db.profile.RaidMana = false
		RaidBuffStatus.db.profile.HealerMana = false
		RaidBuffStatus.db.profile.DPSMana = false
		RaidBuffStatus.db.profile.Alive = false
		RaidBuffStatus.db.profile.TanksAlive = false
		RaidBuffStatus.db.profile.HealersAlive = false
	end
	RaidBuffStatus:AddBuffButtons()
	RaidBuffStatus:UpdateButtons()
	RaidBuffStatus:UpdateOptionsButtons()
end

function RaidBuffStatus:PopUpWizard()
	StaticPopupDialogs["RBS_WIZARD"] = {
		text = L["This is the first time RaidBuffStatus has been activated since installation or settings were reset. Would you like to visit the Buff Wizard to help you get RBS buffs configured? If you are a raid leader then you can click No as the defaults are already set up for you."],
		button1 = L["Buff Wizard"],
		button2 = L["No"],
		button3 = L["Remind me later"],
		OnAccept = function()
			RaidBuffStatus:OpenBlizzAddonOptions()
			RaidBuffStatus.db.profile.TellWizard = false
		end,
		OnCancel = function (_,reason)
			RaidBuffStatus.db.profile.TellWizard = false
		end,
		sound = "levelup2",
		timeout = 200,
		whileDead = true,
		hideOnEscape = true,
	}
	StaticPopup_Show("RBS_WIZARD")
end

function RaidBuffStatus:OpenBlizzAddonOptions()
--	if RaidBuffStatus.optionsframe:IsVisible() then
--		HideUIPanel(RBSOptionsFrame)
--	end
	InterfaceOptionsFrame_OpenToCategory("RaidBuffStatus")
end
