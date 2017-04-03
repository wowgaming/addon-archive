PowaAuras = {
	Version = GetAddOnMetadata("PowerAuras", "Version");
	
	CurrentAuraId = 1;
	NextCheck = 0.2; 
	Tstep = 0.09765625;
	NextDebugCheck = 0;
	InspectTimeOut = 12;
	InspectDelay = 2;
	ExportMaxSize = 4000;
	ExportWidth = 500;
	
	DebugEvents = false;
	
	-- Internal counters
	DebugTimer = 0;
	ChecksTimer = 0; 
	ThrottleTimer = 0;
	TimerUpdateThrottleTimer = 0;	
	NextInspectTimeOut = 0;

	
	--[[
	-- Profiling
	NextProfileCheck = 0;
	ProfileTimer = 0;
	UpdateCount = 0;
	CheckCount = 0;
	EffectCount = 0;
	AuraCheckCount = 0;
	AuraCheckShowCount = 0;
	BuffRaidCount = 0;
	BuffUnitSetCount = 0;
	BuffUnitCount = 0;
	BuffSlotCount = 0;
	AuraTypeCount = {};
	]]
	
	VariablesLoaded = false;
	SetupDone = false;
	Initialising = true;
	ModTest = false;
	DebugCycle = false; 	
	ResetTargetTimers = false;
	
	ActiveTalentGroup = GetActiveTalentGroup();

	WeAreInCombat = false;
	WeAreInRaid = false;
	WeAreInParty = false;
	WeAreMounted = false;
	WeAreInVehicle = false;
	WeAreAlive = true;
	PvPFlagSet = false;
	Instance = "none";

	GroupUnits = {};
	GroupNames = {};
	
	Pending = {}; --- Workaround for 'silent' cooldown end (no event fired)
	Cascade = {}; -- Dependant auras that need checking

	PowaStance = {[0] = "Humanoid"};
	
	PowaGTFO = {[0] = "High Damage", [1] = "Low Damage", [2] = "Fail Alert"};

		
	allowedOperators = {
		["="] = true,
		[">"] = true,
		["<"] = true,
		["!"] = true,
		[">="] = true,
		["<="] = true,
		["-"] = true,
	};

	DefaultOperator = ">=";

	MainOptionPage = 1;
	CurrentAuraPage = 1;
	
	maxtextures = 0;

	MoveEffect = 0; -- 1 = copie / 2 = move
	
	Auras = {};
	SecondaryAuras = {};
	Frames = {};
	SecondaryFrames = {};
	Textures = {};
	SecondaryTextures = {};
	TimerFrame = {};
	StacksFrames = {};
	
	Sound = {};
	BeginAnimDisplay = {};
	EndAnimDisplay = {};
	Text = {};
	Anim = {};
	
	DebuffCatSpells = {};
	
	AoeAuraAdded = {};
	AoeAuraFaded = {};
	AoeAuraTexture = {};

	playerclass = "unknown";
	
	Events = {};
	AlwaysEvents = 
	{
		ACTIVE_TALENT_GROUP_CHANGED = true,	
		INSPECT_TALENT_READY = true,	
		PARTY_MEMBERS_CHANGED = true,	
		PLAYER_ALIVE = true,
		PLAYER_DEAD = true,	
		PLAYER_REGEN_DISABLED = true,
		PLAYER_REGEN_ENABLED = true,
		PLAYER_TALENT_UPDATE = true,	
		PLAYER_UNGHOST = true,
		PLAYER_UPDATE_RESTING = true,	
		RAID_ROSTER_UPDATE = true,		
		UNIT_ENTERED_VEHICLE = true,
		UNIT_EXITED_VEHICLE = true,	
		UNIT_FACTION = true,
		UNIT_SPELLCAST_SUCCEEDED = true,
		ZONE_CHANGED_NEW_AREA = true,
	};

	RelativeToParent = 
	{
		TOPLEFT     = "BOTTOMRIGHT", 
		TOP         = "BOTTOM", 
		TOPRIGHT    = "BOTTOMLEFT", 
		RIGHT       = "LEFT", 
		BOTTOMRIGHT = "TOPLEFT", 
		BOTTOM      = "TOP", 
		BOTTOMLEFT  = "TOPRIGHT", 
		LEFT        = "RIGHT", 
		CENTER      = "CENTER",
	},
	
	ChangedUnits =
	{
		Buffs = {},
	};

	InspectedRoles = {};
	FixRoles = {};
	
	Spells =
	{
		ACTIVATE_FIRST_TALENT  = GetSpellInfo(63645),
		ACTIVATE_SECOND_TALENT = GetSpellInfo(63644),
		BUFF_BLOOD_PRESENCE    = GetSpellInfo(48266),
		BUFF_FROST_PRESENCE    = GetSpellInfo(48263),
		BUFF_UNHOLY_PRESENCE   = GetSpellInfo(48265),
		MOONKIN_FORM   		   = GetSpellInfo(24858),
		TREE_OF_LIFE   		   = GetSpellInfo(65139),
		SHADOWFORM    		   = GetSpellInfo(15473),
		DRUID_SHIFT_CAT 	   = GetSpellInfo(768),
		DRUID_SHIFT_BEAR	   = GetSpellInfo(5487),
		DRUID_SHIFT_DIREBEAR   = GetSpellInfo(9634),
		DRUID_SHIFT_MOONKIN    = GetSpellInfo(24858),
	};
	
	ExtraUnitEvent = {};
	CastOnMe = {};
	
	DoCheck =
	{
		Buffs = false,
		TargetBuffs = false,
		PartyBuffs = false,
		RaidBuffs = false,
		GroupOrSelfBuffs = false,
		UnitBuffs = false,
		FocusBuffs = false,

		Health = false,
		TargetHealth = false,
		PartyHealth = false,
		RaidHealth = false,
		FocusHealth = false,
		NamedUnitHealth = false,

		Mana = false,
		TargetMana = false,
		PartyMana = false,
		RaidMana = false,
		FocusMana = false,
		NamedUnitMana = false,

		Power = false,
		TargetPower = false,
		PartyPower = false,
		RaidPower = false,
		FocusPower = false,
		UnitPower = false,

		Combo = false,
		Aoe = false,
		
		Pet = false,

		Stance = false,
		Actions = false,
		Enchants = false,

		All = false,

		PvP = false,
		PartyPvP = false,
		RaidPvP = false,
		TargetPvP = false,

		Aggro = false,
		PartyAggro = false,
		RaidAggro = false,

		Spells = false,
		TargetSpells = false,
		FocusSpells = false,
		PlayerSpells = false,
		PartySpells = false,
		RaidSpells = false,
		
		OwnSpells = false,
		
		Totems = false,
		Runes = false,
		Items = false,
		Slots = false,
		Tracking = false,
		
		GTFO = false,
	};

	BuffTypes =
	{
		Buff=1,
		Debuff=2,
		TypeDebuff=3,
		AoE=4,
		Enchant=5,
		Combo=6,
		ActionReady=7,
		Health=8,
		Mana=9,
		EnergyRagePower=10,
		Aggro=11,
		PvP=12,
		SpellAlert=13,
		Stance=14,
		OwnSpell=15,
		StealableSpell=16,
		PurgeableSpell=17,
		Static=18,
		Totems=19,
		Pet=20,
		Runes=21,
		Items=22,
		Slots=23,
		Tracking=24,
		GTFO=50,
	};
	
	PowerTypes =
	{
		Any=0,
		Rage=1,
		Focus=2,
		Energy=3,
		Happiness=4,
		RunicPower=6,
		HolyPower=10,
	};

	AnimationBeginTypes =
	{
		None=0,
		ZoomIn=1,
		ZoomOut=2,
		FadeIn=3,
		TranslateLeft=4,
		TranslateTopLeft=5,
		TranslateTop=6,
		TranslateTopRight=7,
		TranslateRight=8,
		TranslateBottomRight=9,
		TranslateBottom=10,
		TranslateBottomLeft=11,
		Bounce=12,
	};
	
	AnimationEndTypes =
	{
		None=0,
		GrowAndFade=1,
		ShrinkAndFade=2,
		Fade=3,
		SpinAndFade=4,
		SpinShrinkAndFade=5,
	};
	
	AnimationTypes =
	{
		Invisible=0,
		Static=1,
		Flashing=2,
		Growing=3,
		Pulse=4,
		Bubble=5,
		WaterDrop=6,
		Electric=7,
		Shrinking=8,
		Flame=9,
		Orbit=10,
		SpinClockwise=11,
		SpinAntiClockwise=12,		
	};
	
		
	AurasByType =
	{
		Buffs = {},
		TargetBuffs = {},
		PartyBuffs = {},
		RaidBuffs = {},
		GroupOrSelfBuffs = {},
		UnitBuffs = {},
		FocusBuffs = {},
		
		Health = {},
		TargetHealth = {},
		FocusHealth = {},
		PartyHealth = {},
		RaidHealth = {},
		NamedUnitHealth = {},

		Mana = {},
		TargetMana = {},
		FocusMana = {},
		PartyMana = {},
		RaidMana = {},
		NamedUnitMana = {},

		Power = {},
		TargetPower = {},
		PartyPower = {},
		RaidPower = {},
		FocusPower = {},
		UnitPower = {},

		Combo = {},
		Aoe = {},

		Stance = {},
		Actions = {},
		Enchants = {},

		PvP = {},
		PartyPvP = {},
		RaidPvP = {},
		TargetPvP = {},
		
		Aggro = {},
		PartyAggro = {},
		RaidAggro = {},
		
		Spells = {},
		TargetSpells = {},
		FocusSpells = {},
		PlayerSpells = {},
		PartySpells = {},
		RaidSpells = {},
		GroupOrSelfSpells = {};
		
		StealableSpells = {},
		StealableTargetSpells = {},
		StealableFocusSpells = {},
		
		PurgeableSpells = {},
		PurgeableTargetSpells = {},
		PurgeableFocusSpells = {},

		OwnSpells = {},
		
		Static = {},
		
		Totems = {},		
		Pet = {},	
		Runes = {},
		Slots = {},
		Items = {},
		Tracking = {},
		
		GTFOHigh = {},
		GTFOLow = {},
		GTFOFail = {},
	};
	
	DebuffCatType =
	{
		CC = 1,
		Silence = 2,
		Snare = 3,
		Root = 4,
		Disarm = 5,
		Stun = 6,
		PvE = 10,
	};

	Sound = {
		[1] = "LEVELUP",
		[2] = "LOOTWINDOWCOINSOUND",
		[3] = "MapPing",
		[4] = "Exploration",
		[5] = "QUESTADDED",
		[6] = "QUESTCOMPLETED",
		[7] = "WriteQuest",
		[8] = "Fishing Reel in",
		[9] = "igPVPUpdate",
		[10] = "ReadyCheck",
		[11] = "RaidWarning",
		[12] = "AuctionWindowOpen",
		[13] = "AuctionWindowClose",
		[14] = "TellMessage",
		[15] = "igBackPackOpen",
		[16] = "aggro.wav",
		[17] = "bam.wav",
		[18] = "cat2.mp3",
		[19] = "cookie.mp3",
		[20] = "moan.mp3",
		[21] = "phone.mp3",
		[22] = "shot.mp3",
		[23] = "sonar.mp3",
		[24] = "splash.mp3",
		[25] = "wilhelm.mp3",
		[26] = "huh_1.wav",
		--[27] = "huh_1.wav",
		--[28] = "huh_1.wav",
		--[29] = "huh_1.wav",
		--[30] = "NONE",
		[31] = "bear_polar.wav",
		[32] = "bigkiss.wav",
		[33] = "BITE.wav",
		[34] = "PUNCH.wav",
		[35] = "burp4.wav",
		[36] = "chimes.wav",
		[37] = "Gasp.wav",
		[38] = "hic3.wav",
		[39] = "hurricane.wav",
		[40] = "hyena.wav",
		[41] = "Squeakypig.wav",
		[42] = "panther1.wav",
		[43] = "rainroof.wav",
		[44] = "snakeatt.wav",
		[45] = "sneeze.wav",
		[46] = "thunder.wav",
		[47] = "wickedmalelaugh1.wav",
		[48] = "wlaugh.wav",
		[49] = "wolf5.wav",
		[50] = "swordecho.wav",	
		[51] = "throwknife.wav",
		[52] = "yeehaw.wav",
		[53] = "Fireball.wav", 
		[54] = "rocket.wav", 
		[55] = "Arrow_Swoosh.wav", 
		[56] = "ESPARK1.wav", 
		[57] = "chant4.wav", 
		[58] = "chant2.wav", 
		[59] = "shipswhistle.wav", 
		[60] = "kaching.wav", 
		[61] = "heartbeat.wav",
	};

	WowTextures = {
		-- auras types
		[1] = "Spells\\AuraRune_B",
		[2] = "Spells\\AuraRune256b",
		[3] = "Spells\\Circle",
		[4] = "Spells\\GENERICGLOW2B",
		[5] = "Spells\\GenericGlow2b1",
		[6] = "Spells\\ShockRingCrescent256",
		[7] = "SPELLS\\AuraRune1",
		[8] = "SPELLS\\AuraRune5Green",
		[9] = "SPELLS\\AuraRune7",
		[10] = "SPELLS\\AuraRune8",
		[11] = "SPELLS\\AuraRune9",
		[12] = "SPELLS\\AuraRune11",
		[13] = "SPELLS\\AuraRune_A",
		[14] = "SPELLS\\AuraRune_C",
		[15] = "SPELLS\\AuraRune_D",
		[16] = "SPELLS\\Holy_Rune1",
		[17] = "SPELLS\\Rune1d_GLOWless",
		[18] = "SPELLS\\Rune4blue",
		[19] = "SPELLS\\RuneBC1",
		[20] = "SPELLS\\RuneBC2",
		[21] = "SPELLS\\RUNEFROST",
		[22] = "Spells\\Holy_Rune_128",
		[23] = "Spells\\Nature_Rune_128",
		[24] = "SPELLS\\Death_Rune",
		[25] = "SPELLS\\DemonRune6",
		[26] = "SPELLS\\DemonRune7",
		[27] = "Spells\\DemonRune5backup",
		-- icon types
		[28] = "Particles\\Intellect128_outline",
		[29] = "Spells\\Intellect_128",
		[30] = "SPELLS\\GHOST1",
		[31] = "Spells\\Aspect_Beast",
		[32] = "Spells\\Aspect_Hawk",
		[33] = "Spells\\Aspect_Wolf",
		[34] = "Spells\\Aspect_Snake",
		[35] = "Spells\\Aspect_Cheetah",
		[36] = "Spells\\Aspect_Monkey",
		[37] = "Spells\\Blobs",
		[38] = "Spells\\Blobs2",
		[39] = "Spells\\GradientCrescent2",
		[40] = "Spells\\InnerFire_Rune_128",
		[41] = "Spells\\RapidFire_Rune_128",
		[42] = "Spells\\Protect_128",
		[43] = "Spells\\Reticle_128",
		[44] = "Spells\\Star2A",
		[45] = "Spells\\Star4",
		[46] = "Spells\\Strength_128",
		[47] = "Particles\\STUNWHIRL",
		[48] = "SPELLS\\BloodSplash1",
		[49] = "SPELLS\\DarkSummon",
		[50] = "SPELLS\\EndlessRage",
		[51] = "SPELLS\\Rampage",
		[52] = "SPELLS\\Eye",
		[53] = "SPELLS\\Eyes",
		[54] = "SPELLS\\Zap1b",
	};

	Fonts = {
		--- wow fonts
		[1] = STANDARD_TEXT_FONT, --- "Fonts\\FRIZQT__.TTF"
		[2] = "Fonts\\ARIALN.TTF",
		[3] = "Fonts\\skurri.ttf",
		[4] = "Fonts\\MORPHEUS.ttf",
		--- external fonts (free use or gpl'd, author in font file)
		[5] = "Interface\\Addons\\PowerAuras\\Fonts\\All_Star_Resort.ttf",
		[6] = "Interface\\Addons\\PowerAuras\\Fonts\\Army.ttf",
		[7] = "Interface\\Addons\\PowerAuras\\Fonts\\Army_Condensed.ttf",
		[8] = "Interface\\Addons\\PowerAuras\\Fonts\\Army_Expanded.ttf",
		[9] = "Interface\\Addons\\PowerAuras\\Fonts\\Blazed.ttf",
		[10] = "Interface\\Addons\\PowerAuras\\Fonts\\Blox2.ttf",
		[11] = "Interface\\Addons\\PowerAuras\\Fonts\\CloisterBlack.ttf",
		[12] = "Interface\\Addons\\PowerAuras\\Fonts\\Moonstar.ttf",
		[13] = "Interface\\Addons\\PowerAuras\\Fonts\\Neon.ttf",
		[14] = "Interface\\Addons\\PowerAuras\\Fonts\\Pulse_virgin.ttf",
		[15] = "Interface\\Addons\\PowerAuras\\Fonts\\Punk_s_not_dead.ttf",
		[16] = "Interface\\Addons\\PowerAuras\\Fonts\\whoa!.ttf",
		[17] = "Interface\\Addons\\PowerAuras\\Fonts\\Hexagon.ttf",
		[18] = "Interface\\Addons\\PowerAuras\\Fonts\\Starcraft_Normal.ttf",
	};
	
	TimerTextures = {
		"Original",
		"AccidentalPresidency",
		"Crystal",
		"Digital",
		"Monofonto",
		"OCR",
		"WhiteRabbit",
	};

	-- Colors used in messages
	Colors = {
		["Blue"] = "|cff6666ff",
		["Grey"] = "|cff999999",
		["Green"] = "|cff66cc33",
		["Red"] = "|cffff2020",
		["Yellow"] = "|cffffff40",
		["BGrey"] = "|c00D0D0D0",
		["White"] = "|c00FFFFFF",
		["Orange"] = "|cffff9930",
		["Purple"] = "|cffB0A0ff",
		["Gold"] = "|cffffff00",
	};
	
	SetColours = {
		["PowaTargetButton"]       = {r=1.0, g=0.2, b=0.2},
		["PowaTargetFriendButton"] = {r=0.2, g=1.0, b=0.2},
		["PowaPartyButton"]        = {r=0.2, g=1.0, b=0.2},
		["PowaGroupOrSelfButton"]  = {r=0.2, g=1.0, b=0.2},
		["PowaFocusButton"]        = {r=0.2, g=1.0, b=0.2},
		["PowaRaidButton"]         = {r=0.2, g=1.0, b=0.2},
		["PowaOptunitnButton"]     = {r=0.2, g=1.0, b=0.2},
	};
	
	OptionCheckBoxes = {
		"PowaTargetButton",
		"PowaPartyButton",
		"PowaGroupOrSelfButton",
		"PowaRaidButton",
		"PowaIngoreCaseButton",
		"PowaOwntexButton",
		"PowaInverseButton",
		"PowaFocusButton",
		"PowaOptunitnButton",
		"PowaGroupAnyButton",
		"PowaRoleTankButton",
		"PowaRoleHealerButton",
		"PowaRoleMeleDpsButton",
		"PowaRoleRangeDpsButton",
	};
	
	OptionTernary = {};
							  
	OptionHideables = {
		"PowaGroupAnyButton",
		"PowaBarTooltipCheck",
		"PowaBarThresholdSlider",
		"PowaThresholdInvertButton",
		"PowaBarBuffStacks",
		"PowaDropDownStance",
		"PowaDropDownGTFO",
		"PowaDropDownPowerType",
	};
	
};

PowaAuras.Cataclysm = (select(4,GetBuildInfo()) == 40000) ;

-- Use these spells to detect GCD
if (PowaAuras.Cataclysm) then
	PowaAuras.GCDSpells = {
			PALADIN = 635,       -- Holy Light [OK]
			PRIEST = 21562,      -- Power Word: Fortitude
			SHAMAN = 8017,       -- Rockbiter
			WARRIOR = 772,       -- Rend (only from level 4) [OK]
			DRUID = 5176,        -- Wrath
			MAGE = 7302,         -- Frost Armor
			WARLOCK = 1454,      -- Life Tap (only from level 6)
			ROGUE = 1752,        -- Sinister Strike
			HUNTER = 1978,       -- Serpent Sting (only from level 4)
			DEATHKNIGHT = 45902, -- Blood Strike
		};
else
	PowaAuras.GCDSpells = {
		PALADIN = 635,       -- Holy Light I [OK]
		PRIEST = 1243,       -- Power Word: Fortitude I
		SHAMAN = 8017,       -- Rockbiter I
		WARRIOR = 772,       -- Rend I (only from level 4) [OK]
		DRUID = 5176,        -- Wrath I
		MAGE = 168,          -- Frost Armor I
		WARLOCK = 687,       -- Demon Skin I
		ROGUE = 1752,        -- Sinister Strike I
		HUNTER = 1978,       -- Serpent Sting I (only from level 4)
		DEATHKNIGHT = 45902, -- Blood Strike I
	};
end

PowaAuras.TalentChangeSpells = {
	[PowaAuras.Spells.ACTIVATE_FIRST_TALENT]  = true,
	[PowaAuras.Spells.ACTIVATE_SECOND_TALENT] = true,
	[PowaAuras.Spells.BUFF_FROST_PRESENCE]    = true,
	[PowaAuras.Spells.BUFF_BLOOD_PRESENCE]    = true,
	[PowaAuras.Spells.BUFF_UNHOLY_PRESENCE]   = true,
};

	
PowaAuras.DebuffTypeSpellIds={
	-- Death Knight
	[47481] = PowaAuras.DebuffCatType.Stun,		-- Gnaw (Ghoul)
	[51209] = PowaAuras.DebuffCatType.CC,		-- Hungering Cold
	[47476] = PowaAuras.DebuffCatType.Silence,	-- Strangulate
	[45524] = PowaAuras.DebuffCatType.Snare,	-- Chains of Ice
	[55666] = PowaAuras.DebuffCatType.Snare,	-- Desecration (no duration, lasts as long as you stand in it)
	[58617] = PowaAuras.DebuffCatType.Snare,	-- Glyph of Heart Strike
	[50434] = PowaAuras.DebuffCatType.Snare,	-- Icy Clutch - I
	[50435] = PowaAuras.DebuffCatType.Snare,	-- Icy Clutch - II
	-- Druid
	[5211]  = PowaAuras.DebuffCatType.Stun,		-- Bash (also Shaman Spirit Wolf ability)
	[33786] = PowaAuras.DebuffCatType.CC,		-- Cyclone
	[2637]  = PowaAuras.DebuffCatType.CC,		-- Hibernate (works against Druids in most forms and Shamans using Ghost Wolf)
	[22570] = PowaAuras.DebuffCatType.Stun,		-- Maim
	[9005]  = PowaAuras.DebuffCatType.Stun,		-- Pounce
	[339]   = PowaAuras.DebuffCatType.Root,		-- Entangling Roots
	[19675] = PowaAuras.DebuffCatType.Root,		-- Feral Charge Effect (immobilize with interrupt [spell lockout, not silence])
	[58179] = PowaAuras.DebuffCatType.Snare,	-- Infected Wounds - I
	[58180] = PowaAuras.DebuffCatType.Snare,	-- Infected Wounds - II
	[61391] = PowaAuras.DebuffCatType.Snare,	-- Typhoon
	-- Hunter
	[3355]  = PowaAuras.DebuffCatType.CC,		-- Freezing Trap Effect
	[24394] = PowaAuras.DebuffCatType.Stun,		-- Intimidation
	[1513]  = PowaAuras.DebuffCatType.CC,		-- Scare Beast (works against Druids in most forms and Shamans using Ghost Wolf)
	[19503] = PowaAuras.DebuffCatType.CC,		-- Scatter Shot
	[19386] = PowaAuras.DebuffCatType.CC,		-- Wyvern Sting
	[34490] = PowaAuras.DebuffCatType.Silence,	-- Silencing Shot
	[53359] = PowaAuras.DebuffCatType.Disarm,	-- Chimera Shot - Scorpid
	[19306] = PowaAuras.DebuffCatType.Root,		-- Counterattack
	[19185] = PowaAuras.DebuffCatType.Root,		-- Entrapment
	[35101] = PowaAuras.DebuffCatType.Snare,	-- Concussive Barrage
	[5116]  = PowaAuras.DebuffCatType.Snare,	-- Concussive Shot
	[13810] = PowaAuras.DebuffCatType.Snare,	-- Frost Trap Aura (no duration, lasts as long as you stand in it)
	[61394] = PowaAuras.DebuffCatType.Snare,	-- Glyph of Freezing Trap
	[2974]  = PowaAuras.DebuffCatType.Snare,	-- Wing Clip
	-- Hunter Pets
	[50519] = PowaAuras.DebuffCatType.Stun,		-- Sonic Blast (Bat)
	[50541] = PowaAuras.DebuffCatType.Disarm,	-- Snatch (Bird of Prey)
	[54644] = PowaAuras.DebuffCatType.Snare,	-- Froststorm Breath (Chimera)
	[50245] = PowaAuras.DebuffCatType.Root,		-- Pin (Crab)
	[50271] = PowaAuras.DebuffCatType.Snare,	-- Tendon Rip (Hyena)
	[50518] = PowaAuras.DebuffCatType.Stun,		-- Ravage (Ravager)
	[54706] = PowaAuras.DebuffCatType.Root,		-- Venom Web Spray (Silithid)
	[4167]  = PowaAuras.DebuffCatType.Root,		-- Web (Spider)
	-- Mage
	[44572] = PowaAuras.DebuffCatType.Stun,		-- Deep Freeze
	[31661] = PowaAuras.DebuffCatType.CC,		-- Dragon's Breath
	[12355] = PowaAuras.DebuffCatType.Stun,		-- Impact
	[118]   = PowaAuras.DebuffCatType.CC,		-- Polymorph
	[18469] = PowaAuras.DebuffCatType.Silence,	-- Silenced - Improved Counterspell
	[64346] = PowaAuras.DebuffCatType.Disarm,	-- Fiery Payback
	[33395] = PowaAuras.DebuffCatType.Root,		-- Freeze (Water Elemental)
	[122]   = PowaAuras.DebuffCatType.Root,		-- Frost Nova
	[11071] = PowaAuras.DebuffCatType.Root,		-- Frostbite
	[55080] = PowaAuras.DebuffCatType.Root,		-- Shattered Barrier
	[11113] = PowaAuras.DebuffCatType.Snare,	-- Blast Wave
	[6136]  = PowaAuras.DebuffCatType.Snare,	-- Chilled (generic effect, used by lots of spells [looks weird on Improved Blizzard, might want to comment out])
	[120]   = PowaAuras.DebuffCatType.Snare,	-- Cone of Cold
	[116]   = PowaAuras.DebuffCatType.Snare,	-- Frostbolt
	[47610] = PowaAuras.DebuffCatType.Snare,	-- Frostfire Bolt
	[31589] = PowaAuras.DebuffCatType.Snare,	-- Slow
	-- Paladin
	[853]   = PowaAuras.DebuffCatType.Stun,		-- Hammer of Justice
	[2812]  = PowaAuras.DebuffCatType.Stun,		-- Holy Wrath (works against Warlocks using Metamorphasis and Death Knights using Lichborne)
	[20066] = PowaAuras.DebuffCatType.CC,		-- Repentance
	[20170] = PowaAuras.DebuffCatType.Stun,		-- Stun (Seal of Justice proc)
	[10326] = PowaAuras.DebuffCatType.CC,		-- Turn Evil (works against Warlocks using Metamorphasis and Death Knights using Lichborne)
	[63529] = PowaAuras.DebuffCatType.Silence,	-- Shield of the Templar
	[20184] = PowaAuras.DebuffCatType.Snare,	-- Judgement of Justice (not really a snare, druids might want this though)
	-- Priest
	[605]   = PowaAuras.DebuffCatType.CC,		-- Mind Control
	[64044] = PowaAuras.DebuffCatType.CC,		-- Psychic Horror
	[8122]  = PowaAuras.DebuffCatType.CC,		-- Psychic Scream
	[9484]  = PowaAuras.DebuffCatType.CC,		-- Shackle Undead (works against Death Knights using Lichborne)
	[15487] = PowaAuras.DebuffCatType.Silence,	-- Silence
	--[64058] = Disarm,	-- Psychic Horror (duplicate debuff names not allowed atm, need to figure out how to support this later)
	[15407] = PowaAuras.DebuffCatType.Snare,	-- Mind Flay
	-- Rogue
	[2094]  = PowaAuras.DebuffCatType.CC,		-- Blind
	[1833]  = PowaAuras.DebuffCatType.Stun,		-- Cheap Shot
	[1776]  = PowaAuras.DebuffCatType.CC,		-- Gouge
	[408]   = PowaAuras.DebuffCatType.Stun,		-- Kidney Shot
	[6770]  = PowaAuras.DebuffCatType.CC,		-- Sap
	[1330]  = PowaAuras.DebuffCatType.Silence,	-- Garrote - Silence
	[18425] = PowaAuras.DebuffCatType.Silence,	-- Silenced - Improved Kick
	[51722] = PowaAuras.DebuffCatType.Disarm,	-- Dismantle
	[31125] = PowaAuras.DebuffCatType.Snare,	-- Blade Twisting
	[3409]  = PowaAuras.DebuffCatType.Snare,	-- Crippling Poison
	[26679] = PowaAuras.DebuffCatType.Snare,	-- Deadly Throw
	-- Shaman
	[51880] = PowaAuras.DebuffCatType.Stun,		-- Improved Fire Nova Totem
	[39796] = PowaAuras.DebuffCatType.Stun,		-- Stoneclaw Stun
	[51514] = PowaAuras.DebuffCatType.CC,		-- Hex (although effectively a silence+disarm effect, it is conventionally thought of as a CC, plus you can trinket out of it)
	[64695] = PowaAuras.DebuffCatType.Root,		-- Earthgrab (Storm, Earth and Fire)
	[63685] = PowaAuras.DebuffCatType.Root,		-- Freeze (Frozen Power)
	[3600]  = PowaAuras.DebuffCatType.Snare,	-- Earthbind (5 second duration per pulse, but will keep re-applying the debuff as long as you stand within the pulse radius)
	[8056]  = PowaAuras.DebuffCatType.Snare,	-- Frost Shock
	[8034]  = PowaAuras.DebuffCatType.Snare,	-- Frostbrand Attack
	-- Warlock
	[710]   = PowaAuras.DebuffCatType.CC,		-- Banish (works against Warlocks using Metamorphasis and Druids using Tree Form)
	[6789]  = PowaAuras.DebuffCatType.CC,		-- Death Coil
	[5782]  = PowaAuras.DebuffCatType.CC,		-- Fear
	[5484]  = PowaAuras.DebuffCatType.CC,		-- Howl of Terror
	[6358]  = PowaAuras.DebuffCatType.CC,		-- Seduction (Succubus)
	[30283] = PowaAuras.DebuffCatType.Stun,		-- Shadowfury
	[24259] = PowaAuras.DebuffCatType.Silence,	-- Spell Lock (Felhunter)
	[18118] = PowaAuras.DebuffCatType.Snare,	-- Aftermath
	[18223] = PowaAuras.DebuffCatType.Snare,	-- Curse of Exhaustion
	-- Warrior
	[7922]  = PowaAuras.DebuffCatType.Stun,		-- Charge Stun
	[12809] = PowaAuras.DebuffCatType.Stun,		-- Concussion Blow
	[20253] = PowaAuras.DebuffCatType.Stun,		-- Intercept (also Warlock Felguard ability)
	[5246]  = PowaAuras.DebuffCatType.CC,		-- Intimidating Shout
	[12798] = PowaAuras.DebuffCatType.Stun,		-- Revenge Stun
	[46968] = PowaAuras.DebuffCatType.Stun,		-- Shockwave
	[18498] = PowaAuras.DebuffCatType.Silence,	-- Silenced - Gag Order
	[676]   = PowaAuras.DebuffCatType.Disarm,	-- Disarm
	[58373] = PowaAuras.DebuffCatType.Root,		-- Glyph of Hamstring
	[23694] = PowaAuras.DebuffCatType.Root,		-- Improved Hamstring
	[1715]  = PowaAuras.DebuffCatType.Snare,	-- Hamstring
	[12323] = PowaAuras.DebuffCatType.Snare,	-- Piercing Howl
	-- Other
	[30217] = PowaAuras.DebuffCatType.Stun,		-- Adamantite Grenade
	[30216] = PowaAuras.DebuffCatType.Stun,		-- Fel Iron Bomb
	[20549] = PowaAuras.DebuffCatType.Stun,		-- War Stomp
	[25046] = PowaAuras.DebuffCatType.Silence,	-- Arcane Torrent
	[39965] = PowaAuras.DebuffCatType.Root,		-- Frost Grenade
	[55536] = PowaAuras.DebuffCatType.Root,		-- Frostweave Net
	[13099] = PowaAuras.DebuffCatType.Root,		-- Net-o-Matic
	[29703] = PowaAuras.DebuffCatType.Snare,	-- Dazed
	-- PvE
	[28169] = PowaAuras.DebuffCatType.PvE,		-- Mutating Injection (Grobbulus)
	[28059] = PowaAuras.DebuffCatType.PvE,		-- Positive Charge (Thaddius)
	[28084] = PowaAuras.DebuffCatType.PvE,		-- Negative Charge (Thaddius)
	[27819] = PowaAuras.DebuffCatType.PvE,		-- Detonate Mana (Kel'Thuzad)
	[63024] = PowaAuras.DebuffCatType.PvE,		-- Gravity Bomb (XT-002 Deconstructor)
	[63018] = PowaAuras.DebuffCatType.PvE,		-- Light Bomb (XT-002 Deconstructor)
	[62589] = PowaAuras.DebuffCatType.PvE,		-- Nature's Fury (Freya, via Ancient Conservator)
	[63276] = PowaAuras.DebuffCatType.PvE,		-- Mark of the Faceless (General Vezax)
};

PowaAuras.Text = {};

function PowaAuras:UnitTestDebug(...)
end

function PowaAuras:UnitTestInfo(...)
end

function PowaAuras:Debug(...)
	if (PowaMisc.debug == true) then
		self:Message(...) --OK
	end
	--self:UnitTestDebug(...);
end

function PowaAuras:Message(...)
	args={...};
	if (args==nil or #args==0) then
		return;
	end
	local Message = "";
	for i=1, #args do
		Message = Message..tostring(args[i]);
	end
	DEFAULT_CHAT_FRAME:AddMessage(Message);
end

-- Use this for temp debug messages
function PowaAuras:ShowText(...)
	self:Message(...); -- OK
end

-- Use this for real messages instead of ShowText
function PowaAuras:DisplayText(...)
	self:Message(...);
end

-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- This function will print a Message to the GUI screen (not the chat window) then fade.
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
function PowaAuras:Error( msg, holdtime )
	if (holdtime==nil) then
		holdtime = UIERRORS_HOLD_TIME;
	end
	UIErrorsFrame:AddMessage(msg, 0.75, 0.75, 1.0, 1.0, holdtime);
end


function PowaAuras:ReverseTable(t)
	if (type(t)~="table") then return nil; end
	local newTable = {};
	for k,v in pairs(t) do
		newTable[v] = k;
	end
	return newTable;
end

function PowaAuras:TableEmpty(t)
	if (type(t)~="table") then return nil; end
	for k in pairs(t) do
		return false;
	end
	return true;
end

function PowaAuras:TableSize(t)
	if (type(t)~="table") then return nil; end
	local size = 0;
	for k in pairs(t) do
		size = size + 1;
	end
	return size;
end
function PowaAuras:CopyTable(t, lookup_table, original)
	if (type(t)~="table") then
		return t;
	end
	
	local copy;
	if (original==nil) then
		copy = {};
	else
		copy = original;
	end
	for i,v in pairs(t) do
		if (type(v)~="function") then
			if (type(v)~="table") then
				copy[i] = v;
			else
				lookup_table = lookup_table or {};
				lookup_table[t] = copy;
				if lookup_table[v] then
					copy[i] = lookup_table[v]; -- we already copied this table. reuse the copy.
				else
					copy[i] = self:CopyTable(v, lookup_table); -- not yet copied. copy it.
				end
			end
		end
	end
	return copy
end

function PowaAuras:MergeTables(desTable, sourceTable)
	if (not sourceTable or type(sourceTable)~="table") then
		return;
	end
	if (not desTable or type(desTable)~="table") then
		desTable = sourceTable;
		return;
	end
	
	for i,v in pairs(sourceTable) do
		if (type(v)~="function") then
			if (type(v)~="table") then
				desTable[i] = v;
			else
				if (not desTable[i] or type(desTable[i])~="table") then
					desTable[i] = {};
				end
				self:MergeTables(desTable[i], v);
			end
		end
	end

end

function PowaAuras:InsertText(text, ...)
	args={...};
	if (args==nil or #args==0) then
		return text;
	end
	for k, v in pairs(args) do
		text = string.gsub(text, "$"..k, tostring(v));
	end
	return text;
end

function PowaAuras:MatchString(textToSearch, textToFind, ingoreCase)
	if (textToSearch==nil) then
		return textToFind==nil;
	end
	if (ingoreCase) then
		textToFind = string.upper(textToFind);
		textToSearch = string.upper(textToSearch);
	end
	return string.find(textToSearch, textToFind, 1, true)
end
	
-- PowaAura Classes
-- class.lua
-- Compatible with Lua 5.1 (not 5.0).
function PowaClass(base,ctor)
	local c = {}     -- a new class instance
	if not ctor and type(base) == 'function' then
      ctor = base;
      base = nil;
	elseif type(base) == 'table' then
   -- our new class is a shallow copy of the base class!
      for i,v in pairs(base) do
          c[i] = v;
      end
	  if (type(ctor)=="table") then
		for i,v in pairs(ctor) do
			c[i] = v;
		end
		ctor = nil;
	  end
      c._base = base;
	end
	-- the class will be the metatable for all its objects,
	-- and they will look up their methods in it.
	c.__index = c

	-- expose a ctor which can be called by <classname>(<args>)
	local mt = {}
	mt.__call = function(class_tbl,...)
		local obj = {}
		setmetatable(obj,c)
		if ctor then
			--PowaAuras:ShowText("Call constructor "..tostring(ctor));
			ctor(obj,...)
		end 
		return obj
	end
    
    if ctor then
		c.init = ctor;
    else 
 		if base and base.init then
			c.init = base.init;
			ctor = base.init;
		end
    end
 
	c.is_a = function(self,klass)
      local m = getmetatable(self)
      while m do 
         if m == klass then return true end
         m = m._base
      end
      return false
    end
  setmetatable(c,mt)
  return c
end
