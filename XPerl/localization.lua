-- X-Perl UnitFrames
-- Author: Zek <Boodhoof-EU>
-- License: GNU GPL v3, 29 June 2007 (see LICENSE.txt)

XPerl_ProductName		= "|cFFD00000X-Perl|r UnitFrames"
XPerl_ShortProductName	= "|cFFD00000X-Perl|r"
XPerl_Author			= "|cFFFF8080Zek|r"
XPerl_Description		= XPerl_ProductName.." by "..XPerl_Author
XPerl_VersionNumber 	= "3.0.9"
XPerl_Version			= XPerl_Description.." - "..XPerl_VersionNumber
XPerl_LongDescription	= "UnitFrame replacement for new look Player, Pet, Party, Target, Target's Target, Focus, Raid"
XPerl_ModMenuIcon		= "Interface\\Icons\\INV_Misc_Gem_Pearl_02"

XPERL_COMMS_PREFIX		= "X-Perl"
XPERL_MINIMAP_HELP1		= "|c00FFFFFFLeft click|r for Options (and to |c0000FF00unlock frames|r)"
XPERL_MINIMAP_HELP2		= "|c00FFFFFFRight click|r to drag this icon"
XPERL_MINIMAP_HELP3		= "\rReal Raid Members: |c00FFFF80%d|r\rReal Party Members: |c00FFFF80%d|r"
XPERL_MINIMAP_HELP4		= "\rYou are leader of the real party/raid"
XPERL_MINIMAP_HELP5		= "|c00FFFFFFAlt|r for X-Perl memory usage"
XPERL_MINIMAP_HELP6		= "|c00FFFFFF+Shift|r for X-Perl memory usage since startup"

XPERL_MINIMENU_OPTIONS	= "Options"
XPERL_MINIMENU_ASSIST	= "Show Assists Frame"
XPERL_MINIMENU_CASTMON	= "Show Casting Monitor"
XPERL_MINIMENU_RAIDAD	= "Show Raid Admin"
XPERL_MINIMENU_ITEMCHK	= "Show Item Checker"
XPERL_MINIMENU_RAIDBUFF = "Raid Buffs"
XPERL_MINIMENU_ROSTERTEXT="Roster Text"
XPERL_MINIMENU_RAIDSORT = "Raid Sort"
XPERL_MINIMENU_RAIDSORT_GROUP = "Sort by Group"
XPERL_MINIMENU_RAIDSORT_CLASS = "Sort by Class"

XPERL_TYPE_NOT_SPECIFIED = "Not specified"
XPERL_TYPE_PET		= PET			-- "Pet"
XPERL_TYPE_BOSS 	= "Boss"
XPERL_TYPE_RAREPLUS = "Rare+"
XPERL_TYPE_ELITE	= "Elite"
XPERL_TYPE_RARE 	= "Rare"

-- Zones
XPERL_LOC_ZONE_SERPENTSHRINE_CAVERN = "Serpentshrine Cavern"
XPERL_LOC_ZONE_BLACK_TEMPLE = "Black Temple"
XPERL_LOC_ZONE_HYJAL_SUMMIT = "Hyjal Summit"
XPERL_LOC_ZONE_KARAZHAN = "Karazhan"
XPERL_LOC_ZONE_SUNWELL_PLATEAU = "Sunwell Plateau"
XPERL_LOC_ZONE_NAXXRAMAS = "Naxxramas"
XPERL_LOC_ZONE_OBSIDIAN_SANCTUM = "The Obsidian Sanctum"
XPERL_LOC_ZONE_EYE_OF_ETERNITY = "The Eye of Eternity"
XPERL_LOC_ZONE_ULDUAR = "Ulduar"
XPERL_LOC_ZONE_TRIAL_OF_THE_CRUSADER = "Trial of the Crusader"
XPERL_LOC_ZONE_ICECROWN_CITADEL = "Icecrown Citadel"
XPERL_LOC_ZONE_RUBY_SANCTUM = "The Ruby Sanctum"

-- Status
XPERL_LOC_DEAD		= DEAD			-- "Dead"
XPERL_LOC_GHOST 	= "Ghost"
XPERL_LOC_FEIGNDEATH	= "Feign Death"
XPERL_LOC_OFFLINE	= PLAYER_OFFLINE	-- "Offline"
XPERL_LOC_RESURRECTED	= "Resurrected"
XPERL_LOC_SS_AVAILABLE	= "SS Available"
XPERL_LOC_UPDATING	= "Updating"
XPERL_LOC_ACCEPTEDRES	= "Accepted"		-- Res accepted
XPERL_RAID_GROUP	= "Group %d"
XPERL_RAID_GROUPSHORT	= "G%d"

XPERL_LOC_NONEWATCHED	= "none watched"

XPERL_LOC_STATUSTIP = "Status Highlights: " 	-- Tooltip explanation of status highlight on unit
XPERL_LOC_STATUSTIPLIST = {
	HOT = "Heal over Time",
	AGGRO = "Aggro",
	MISSING = "Missing your class' buff",
	HEAL = "Being healed",
	SHIELD = "Shielded"
}

XPERL_OK		= "OK"
XPERL_CANCEL		= "Cancel"

XPERL_LOC_LARGENUMDIV	= 1000
XPERL_LOC_LARGENUMTAG	= "K"
XPERL_LOC_HUGENUMDIV	= 1000000
XPERL_LOC_HUGENUMTAG	= "M"

BINDING_HEADER_XPERL = XPerl_ProductName
BINDING_NAME_TOGGLERAID = "Toggle Raid Windows"
BINDING_NAME_TOGGLERAIDSORT = "Toggle Raid Sort by Class/Group"
BINDING_NAME_TOGGLERAIDPETS = "Toggle Raid Pets"
BINDING_NAME_TOGGLEOPTIONS = "Toggle Options Window"
BINDING_NAME_TOGGLEBUFFTYPE = "Toggle Buffs/Debuffs/none"
BINDING_NAME_TOGGLEBUFFCASTABLE = "Toggle Castable/Curable"
BINDING_NAME_TEAMSPEAKMONITOR = "Teamspeak Monitor"
BINDING_NAME_TOGGLERANGEFINDER = "Toggle Range Finder"

XPERL_KEY_NOTICE_RAID_BUFFANY = "All buffs/debuffs shown"
XPERL_KEY_NOTICE_RAID_BUFFCURECAST = "Only castable/curable buffs or debuffs shown"
XPERL_KEY_NOTICE_RAID_BUFFS = "Raid Buffs shown"
XPERL_KEY_NOTICE_RAID_DEBUFFS = "Raid Debuffs shown"
XPERL_KEY_NOTICE_RAID_NOBUFFS = "No raid buffs shown"

XPERL_DRAGHINT1		= "|c00FFFFFFClick|r to scale window"
XPERL_DRAGHINT2		= "|c00FFFFFFShift+Click|r to resize window"

-- Usage
XPerlUsageNameList	= {XPerl = "Core", XPerl_Player = "Player", XPerl_PlayerPet = "Pet", XPerl_Target = "Target", XPerl_TargetTarget = "Target's Target", XPerl_Party = "Party", XPerl_PartyPet = "Party Pets", XPerl_RaidFrames = "Raid Frames", XPerl_RaidHelper = "Raid Helper", XPerl_RaidAdmin = "Raid Admin", XPerl_TeamSpeak = "TS Monitor", XPerl_RaidMonitor = "Raid Monitor", XPerl_RaidPets = "Raid Pets", XPerl_ArcaneBar = "Arcane Bar", XPerl_PlayerBuffs = "Player Buffs", XPerl_GrimReaper = "Grim Reaper"}
XPERL_USAGE_MEMMAX	= "UI Mem Max: %d"
XPERL_USAGE_MODULES = "Modules: "
XPERL_USAGE_NEWVERSION	= "*Newer version"
XPERL_USAGE_AVAILABLE	= "%s |c00FFFFFF%s|r is available for download"

XPERL_CMD_MENU		= "menu"
XPERL_CMD_OPTIONS	= "options"
XPERL_CMD_LOCK		= "lock"
XPERL_CMD_UNLOCK	= "unlock"
XPERL_CMD_CONFIG	= "config"
XPERL_CMD_LIST		= "list"
XPERL_CMD_DELETE	= "delete"
XPERL_CMD_HELP		= "|c00FFFF80Usage: |c00FFFFFF/xperl menu | lock | unlock | config list | config delete <realm> <name>"
XPERL_CANNOT_DELETE_CURRENT = "Cannot delete you current config"
XPERL_CONFIG_DELETED		= "Deleted config for %s/%s"
XPERL_CANNOT_FIND_DELETE_TARGET = "Cannot find config to delete (%s/%s)"
XPERL_CANNOT_DELETE_BADARGS = "Please give realm name and player name"
XPERL_CONFIG_LIST		= "Config List:"
XPERL_CONFIG_CURRENT		= " (Current)"

XPERL_RAID_TOOLTIP_WITHBUFF	= "With buff: (%s)"
XPERL_RAID_TOOLTIP_WITHOUTBUFF	= "Without buff: (%s)"
XPERL_RAID_TOOLTIP_BUFFEXPIRING	= "%s's %s expires in %s"	-- Name, buff name, time to expire

-- Status highlight spells
-- Cata client check
if select(4, _G.GetBuildInfo()) >= 40000 then
XPERL_HIGHLIGHT_SPELLS = {
	hotSpells  = {
		[GetSpellInfo(774)] = 12,			-- Rejuvenation (old id 26982)
		[GetSpellInfo(8936)] = 21,			-- Regrowth (old id 26980)
		[GetSpellInfo(139)] = 15,			-- Renew (old id 25222)
	    [GetSpellInfo(48438)] = 7,			-- Wild Growth 
		[GetSpellInfo(33763)] = 8,			-- Lifebloom
		[GetSpellInfo(28880)] = 15,			-- Gift of the Naaru (Racial)
		[GetSpellInfo(61295)] = 15,			-- Riptide
		-- [GetSpellInfo(66922)] = 10,			-- Flash of Light hot
	},
	pomSpells = {
		[GetSpellInfo(33076)] = 30			-- Prayer of Mending
	},
	shieldSpells = {
		--[GetSpellInfo(25218)] = 30,			-- Power Word: Shield
		[GetSpellInfo(974)] = 600			-- Earth Shield	(old id32594)		-- TODO change me
	},
	healSpells = {
		[GetSpellInfo(2061)] = 1,			-- Flash Heal (old id 25235)
		[GetSpellInfo(2060)] = 3,			-- Greater Heal (old id 25213)
		[GetSpellInfo(2050)] = 3,			-- Heal (old id 6064)
		[GetSpellInfo(5185)] = 2,			-- Healing Touch (old id 26979)
		[GetSpellInfo(8936)] = 2,			-- Regrowth (old id 26980)
		[GetSpellInfo(331)] = 3,			-- Healing Wave (old id 25396)
		[GetSpellInfo(8004)] = 2,			-- Lesser Healing Wave (old id 25420)
		[GetSpellInfo(19750)] = 1.5,		-- Flash of Light (old id 27137)
		[GetSpellInfo(635)] = 2.5,			-- Holy Light (old id 27136))
		[GetSpellInfo(34861)] = 0.5,		-- Circle of Healing (old id 34866)
		[GetSpellInfo(50464)] = 1.5			-- Nourish
	},
	buffSpells = {
		PRIEST = {
			[GetSpellInfo(21532)] = true,	-- Power Word: Fortitude (old id 25389)
			[GetSpellInfo(39231)] = true	-- Prayer of Fortitude (old id 25392)
		},
	    DRUID = {
			[GetSpellInfo(1126)] = true		-- Mark of the Wild (old id 26990)
			-- TODO Find Gift Of the Wild
		},
	    MAGE = {
			[GetSpellInfo(1459)] = true		-- Arcane Intellect (old id 27126)
			-- TODO Find Arcane Brilliance
		},
	},
	groupHealSpells = {
		[GetSpellInfo(596)] = 3,			-- Prayer of Healing (old id 25308)
	},
}


-- Default spells for range checking in the healer visual out-of-range cues.
XPerl_DefaultRangeSpells = {
	DRUID	= {spell = GetSpellInfo(5185)},				-- Healing Touch
	PALADIN = {spell = GetSpellInfo(635)},				-- Holy Light
	PRIEST	= {spell = GetSpellInfo(2061)},				-- Flash Heal
	SHAMAN	= {spell = GetSpellInfo(331)},				-- Healing Wave
	MAGE	= {spell = GetSpellInfo(475)},				-- Remove Lesser Curse
	WARLOCK	= {spell = GetSpellInfo(5227)},				-- Underwater Breathing
	ANY		= {item = "Heavy Netherweave Bandage"}		-- TODO - Use Item ID
}

-- Don't highlight these magical debuffs
XPerl_ArcaneExclusions = {
	[GetSpellInfo(63559)] = true,						-- Bind Life
	[GetSpellInfo(30451)] = true,						-- Arcane Blast (again) (old 42897)
	[GetSpellInfo(30108)] = true,						-- Unstable Affliction (old 30405)
	[GetSpellInfo(15822)] = true,						-- Dreamless Sleep
	[GetSpellInfo(24360)] = true,						-- Greater Dreamless Sleep
	[GetSpellInfo(28504)] = true,						-- Major Dreamless Sleep
	[GetSpellInfo(31257)] = true,						-- Chilled
	[GetSpellInfo(710)] = true,							-- Banish
	[GetSpellInfo(44836)] = true,						-- Also Banish !?
	[GetSpellInfo(24306)] = true,						-- Delusions of Jin'do
	[GetSpellInfo(46543)] = {ROGUE = true, WARRIOR = true},	-- Ignite Mana
	[GetSpellInfo(16567)] = {ROGUE = true, WARRIOR = true},	-- Tainted Mind
	[GetSpellInfo(39052)] = {ROGUE = true},				-- Sonic Burst
	[GetSpellInfo(41190)] = {ROGUE = true, WARRIOR = true}, -- Mind-numbing Poison
	[GetSpellInfo(25195)] = {ROGUE = true},				-- Curse of Tongues
	[GetSpellInfo(30129)] = true,						-- Charred Earth - Nightbane debuff, can't be cleansed, but shows as magic
	[GetSpellInfo(31651)] = {MAGE = true, WARLOCK = true, PRIEST = true},	-- Banshee Curse, Melee hit rating debuff
	[GetSpellInfo(38913)] = {ROGUE = true},				-- Silence
	[GetSpellInfo(31555)] = {ROGUE = true, WARRIOR = true}, -- Decayed Intellect
}
else
XPERL_HIGHLIGHT_SPELLS = {
	hotSpells  = {
		[GetSpellInfo(26982)] = 12,			-- Rejuvenation
		[GetSpellInfo(26980)] = 21,			-- Regrowth
		[GetSpellInfo(25222)] = 15,			-- Renew
		[GetSpellInfo(48438)] = 7,			-- Wild Growth
		[GetSpellInfo(33763)] = 8,			-- Lifebloom
		[GetSpellInfo(28880)] = 15,			-- Gift of the Naaru (Racial)
		[GetSpellInfo(61295)] = 15,			-- Riptide
		[GetSpellInfo(66922)] = 10,			-- Flash of Light hot
	},
	pomSpells = {
		[GetSpellInfo(33076)] = 30			-- Prayer of Mending
	},
	shieldSpells = {
		--[GetSpellInfo(25218)] = 30,			-- Power Word: Shield
		[GetSpellInfo(32594)] = 600			-- Earth Shield			-- TODO change me
	},
	healSpells = {
		[GetSpellInfo(25235)] = 1,			-- Flash Heal
		[GetSpellInfo(25213)] = 3,			-- Greater Heal
		[GetSpellInfo(2053)] = 2,			-- Lesser Heal
		[GetSpellInfo(6064)] = 2,			-- Heal
		[GetSpellInfo(26979)] = 2,			-- Healing Touch
		[GetSpellInfo(26980)] = 2,			-- Regrowth
		[GetSpellInfo(25396)] = 3,			-- Healing Wave
		[GetSpellInfo(25420)] = 2,			-- Lesser Healing Wave
		[GetSpellInfo(27137)] = 1.5,		-- Flash of Light
		[GetSpellInfo(27136)] = 2.5,		-- Holy Light
		[GetSpellInfo(34866)] = 0.5,		-- Circle of Healing
		[GetSpellInfo(50464)] = 1.5,		-- Nourish
	},
	buffSpells = {
		PRIEST = {
			[GetSpellInfo(25389)] = true,	-- Power Word: Fortitude
			[GetSpellInfo(25392)] = true	-- Prayer of Fortitude
		},
	    DRUID = {
			[GetSpellInfo(26990)] = true,	-- Mark of the Wild
			[GetSpellInfo(26991)] = true	-- Gift of the Wild
		},
	    MAGE = {
			[GetSpellInfo(27126)] = true,	-- Arcane Intellect
			[GetSpellInfo(27127)] = true	-- "Arcane Brilliance"
		},
	},
	groupHealSpells = {
		[GetSpellInfo(25308)] = 3,			-- Prayer of Healing
	},
}

-- Default spells for range checking in the healer visual out-of-range cues.
XPerl_DefaultRangeSpells = {
	DRUID	= {spell = GetSpellInfo(26979)},			-- Healing Touch
	PALADIN = {spell = GetSpellInfo(27136)},			-- Holy Light
	PRIEST	= {spell = GetSpellInfo(2053)},				-- Lesser Heal
	SHAMAN	= {spell = GetSpellInfo(25396)},			-- Healing Wave
	MAGE	= {spell = GetSpellInfo(475)},				-- Remove Lesser Curse
	WARLOCK	= {spell = GetSpellInfo(132)},				-- Detect Invisibility
	ANY		= {item = "Heavy Netherweave Bandage"}		-- TODO - Use Item ID
}

-- Don't highlight these magical debuffs
XPerl_ArcaneExclusions = {
	[GetSpellInfo(63559)] = true,						-- Bind Life
	[GetSpellInfo(42897)] = true,						-- Arcane Blast (again)
	[GetSpellInfo(30405)] = true,						-- Unstable Affliction
	[GetSpellInfo(15822)] = true,						-- Dreamless Sleep
	[GetSpellInfo(24360)] = true,						-- Greater Dreamless Sleep
	[GetSpellInfo(28504)] = true,						-- Major Dreamless Sleep
	[GetSpellInfo(31257)] = true,						-- Chilled
	[GetSpellInfo(44836)] = true,						-- Banish
	[GetSpellInfo(24306)] = true,						-- Delusions of Jin'do
	[GetSpellInfo(46543)] = {ROGUE = true, WARRIOR = true},	-- Ignite Mana
	[GetSpellInfo(16567)] = {ROGUE = true, WARRIOR = true},	-- Tainted Mind
	[GetSpellInfo(39052)] = {ROGUE = true},				-- Sonic Burst
	[GetSpellInfo(41190)] = {ROGUE = true, WARRIOR = true}, -- Mind-numbing Poison
	[GetSpellInfo(25195)] = {ROGUE = true},				-- Curse of Tongues
	[GetSpellInfo(30129)] = true,						-- Charred Earth - Nightbane debuff, can't be cleansed, but shows as magic
	[GetSpellInfo(31651)] = {MAGE = true, WARLOCK = true, PRIEST = true},	-- Banshee Curse, Melee hit rating debuff
	[GetSpellInfo(38913)] = {ROGUE = true},				-- Silence
	[GetSpellInfo(31555)] = {ROGUE = true, WARRIOR = true}, -- Decayed Intellect
}
end