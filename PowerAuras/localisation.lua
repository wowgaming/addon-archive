--if (GetLocale() == "enEN") then

PowaAuras.Anim[0] = "[Invisible]";
PowaAuras.Anim[1] = "Static";
PowaAuras.Anim[2] = "Flashing";
PowaAuras.Anim[3] = "Growing";
PowaAuras.Anim[4] = "Pulse";
PowaAuras.Anim[5] = "Bubble";
PowaAuras.Anim[6] = "Water drop";
PowaAuras.Anim[7] = "Electric";
PowaAuras.Anim[8] = "Shrinking";
PowaAuras.Anim[9] = "Flame";
PowaAuras.Anim[10] = "Orbit";
PowaAuras.Anim[11] = "Spin Clockwise";
PowaAuras.Anim[12] = "Spin Anti-Clockwise";

PowaAuras.BeginAnimDisplay[0] = "[None]";
PowaAuras.BeginAnimDisplay[1] = "Zoom In";
PowaAuras.BeginAnimDisplay[2] = "Zoom Out";
PowaAuras.BeginAnimDisplay[3] = "Fade In";
PowaAuras.BeginAnimDisplay[4] = "Left";
PowaAuras.BeginAnimDisplay[5] = "Top-Left";
PowaAuras.BeginAnimDisplay[6] = "Top";
PowaAuras.BeginAnimDisplay[7] = "Top-Right";
PowaAuras.BeginAnimDisplay[8] = "Right";
PowaAuras.BeginAnimDisplay[9] = "Bottom-Right";
PowaAuras.BeginAnimDisplay[10] = "Bottom";
PowaAuras.BeginAnimDisplay[11] = "Bottom-Left";
PowaAuras.BeginAnimDisplay[12] = "Bounce";

PowaAuras.EndAnimDisplay[0] = "[None]";
PowaAuras.EndAnimDisplay[1] = "Grow";
PowaAuras.EndAnimDisplay[2] = "Shrink";
PowaAuras.EndAnimDisplay[3] = "Fade Out";
PowaAuras.EndAnimDisplay[4] = "Spin";
PowaAuras.EndAnimDisplay[5] = "Spin In";

PowaAuras.Sound[0] = NONE;
PowaAuras.Sound[30] = NONE;

PowaAuras:MergeTables(PowaAuras.Text, 
{
	welcome = "Type /powa to view the options.",

	aucune = "None",
	aucun = "None",
	largeur = "Width",
	hauteur = "Height",
	mainHand = "main",
	offHand = "off",
	bothHands = "both",

	Unknown	 = "unknown",

	DebuffType =
	{
		Magic   = "Magic",
		Disease = "Disease",
		Curse   = "Curse",
		Poison  = "Poison",
	},

	DebuffCatType =
	{
		[PowaAuras.DebuffCatType.CC]      = "CC",
		[PowaAuras.DebuffCatType.Silence] = "Silence",
		[PowaAuras.DebuffCatType.Snare]   = "Snare",
		[PowaAuras.DebuffCatType.Stun]    = "Stun",
		[PowaAuras.DebuffCatType.Root]    = "Root",
		[PowaAuras.DebuffCatType.Disarm]  = "Disarm",
		[PowaAuras.DebuffCatType.PvE]     = "PvE",
	},
	
	Role =
	{
		RoleTank     = "Tank",
		RoleHealer   = "Healer",
		RoleMeleDps  = "Melee DPS",
		RoleRangeDps = "Ranged DPS",
	},
	
	nomReasonRole =
	{
		RoleTank     = "Is a Tank",
		RoleHealer   = "Is a Healer",
		RoleMeleDps  = "Is a Melee DPS",
		RoleRangeDps = "Is a Ranged DPS",
	},

	nomReasonNotRole =
	{
		RoleTank     = "Not a Tank",
		RoleHealer   = "Not a Healer",
		RoleMeleDps  = "Not a Melee DPS",
		RoleRangeDps = "Not a Ranged DPS",
	},
	
	AuraType =
	{
		[PowaAuras.BuffTypes.Buff] = "Buff",
		[PowaAuras.BuffTypes.Debuff] = "Debuff",
		[PowaAuras.BuffTypes.AoE] = "AOE Debuff",
		[PowaAuras.BuffTypes.TypeDebuff] = "Debuff type",
		[PowaAuras.BuffTypes.Enchant] = "Weapon Enchant",
		[PowaAuras.BuffTypes.Combo] = "Combo Points",
		[PowaAuras.BuffTypes.ActionReady] = "Action Usable",
		[PowaAuras.BuffTypes.Health] = "Health",
		[PowaAuras.BuffTypes.Mana] = "Mana",
		[PowaAuras.BuffTypes.EnergyRagePower] = "Rage/Energy/Power",
		[PowaAuras.BuffTypes.Aggro] = "Aggro",
		[PowaAuras.BuffTypes.PvP] = "PvP",
		[PowaAuras.BuffTypes.Stance] = "Stance",
		[PowaAuras.BuffTypes.SpellAlert] = "Spell Alert", 
		[PowaAuras.BuffTypes.OwnSpell] = "My Spell Cooldown", 
		[PowaAuras.BuffTypes.StealableSpell] = "Stealable Spell",
		[PowaAuras.BuffTypes.PurgeableSpell] = "Purgeable Spell",
		[PowaAuras.BuffTypes.Static] = "Static Aura",
		[PowaAuras.BuffTypes.Totems] = "Totems",
		[PowaAuras.BuffTypes.Pet] = "Pet",
		[PowaAuras.BuffTypes.Runes] = "Runes",
		[PowaAuras.BuffTypes.Slots] = "Equipment Slots",
		[PowaAuras.BuffTypes.Items] = "Named Items",
		[PowaAuras.BuffTypes.Tracking] = "Tracking",
		[PowaAuras.BuffTypes.GTFO] = "GTFO Alert",
	},
	
	PowerType =
	{
		[PowaAuras.PowerTypes.Any] = "Default",
		[PowaAuras.PowerTypes.Rage] = "Rage",
		[PowaAuras.PowerTypes.Focus] = "Focus",
		[PowaAuras.PowerTypes.Energy] = "Energy",
		[PowaAuras.PowerTypes.Happiness] = "Happiness",
		[PowaAuras.PowerTypes.RunicPower] = "Runic Power",
		[PowaAuras.PowerTypes.HolyPower] = "Holy Power",
	},
	
	Relative = 
	{
		NONE        = "Free", 
		TOPLEFT     = "Top-Left", 
		TOP         = "Top", 
		TOPRIGHT    = "Top-Right", 
		RIGHT       = "Right", 
		BOTTOMRIGHT = "BottomRight", 
		BOTTOM      = "Bottom", 
		BOTTOMLEFT  = "Bottom-Left", 
		LEFT        = "Left", 
		CENTER      = "Center",
	},
	
	Slots =
	{
		Ammo = "Ammo",
		Back = "Back",
		Chest = "Chest",
		Feet = "Feet",
		Finger0 = "Finger1",
		Finger1 = "Finger2",
		Hands = "Hands",
		Head = "Head",
		Legs = "Legs",
		MainHand = "MainHand",
		Neck = "Neck",
		Ranged = "Ranged",
		SecondaryHand = "OffHand",
		Shirt = "Shirt",
		Shoulder = "Shoulder",
		Tabard = "Tabard",
		Trinket0 = "Trinket1",
		Trinket1 = "Trinket2",
		Waist = "Waist",
		Wrist = "Wrist",	
	},

	-- Main
	nomEnable = "Activate Power Auras",
	aideEnable = "Enable all Power Auras effects",

	nomDebug = "Activate Debug Messages",
	aideDebug = "Enable Debug Messages",
	ListePlayer = "Page",
	ListeGlobal = "Global",
	aideMove = "Move the effect here.",
	aideCopy = "Copy the effect here.",
	nomRename = "Rename",
	aideRename = "Rename the selected effect's page.",
	nomTest = "Test",
	nomTestAll = "Test All",
	nomHide = "Hide all",
	nomEdit = "Edit",
	nomNew = "New",
	nomDel = "Delete",
	nomImport = "Import", 
	nomExport = "Export", 
	nomImportSet = "Import Set", 
	nomExportSet = "Export Set", 
	aideImport = "Press Ctrl-V to paste the Aura-string and press \'Accept\'",
	aideExport = "Press Ctrl-C to copy the Aura-string for sharing.",
	aideImportSet = "Press Ctrl-V to paste the Aura-Set-string and press \'Accept\' this will erase all auras on this page",
	aideExportSet = "Press Ctrl-C to copy all the Auras on this page for sharing.",
	aideDel = "Remove the selected effect (Hold CTRL to allow this button to work)",
	nomMove = "Move",
	nomCopy = "Copy",
	nomPlayerEffects = "Character effects",
	nomGlobalEffects = "Global\neffects",
	aideEffectTooltip = "(Shift-click to toggle effect ON or OFF)",
	aideEffectTooltip2 = "(Ctrl-click to give reason for activation)",

	aideItems = "Enter full name of Item or [xxx] for Id",
	aideTracking = "Enter name of Tracking type e.g. fish",

	-- editor
	aideCustomText = "Enter text to display (%t=target name, %f=focus name, %v=display value, %u=unit name, %str=str, agl=agl, %sta=sta, %int=int, %sp1=spi, %sp=spell power, %ap=attack power, %df=defence)",

	nomSoundStarting = "Starting Sound:",
	nomSound = "Sound to play",
	nomSound2 = "More sounds to play",
	aideSound = "Plays a sound at the beginning.",
	aideSound2 = "Plays a sound at the beginning.",
	nomCustomSound = "OR soundfile:",
	aideCustomSound = "Enter a soundfile that is in the Sounds folder, BEFORE you started the game. mp3 and wav are supported. example: 'cookie.mp3'\nOr\nEnter the full path to play any WoW sound e.g. Sound\\Events\\GuldanCheers.wav",

	nomSoundEnding = "Ending Sound:",
	nomSoundEnd = "Sound to play",
	nomSound2End = "More sounds to play",
	aideSoundEnd = "Plays a sound at the end.",
	aideSound2End = "Plays a sound at the end.",
	nomCustomSoundEnd = "OR soundfile:",
	aideCustomSoundEnd = "Enter a soundfile that is in the Sounds folder, BEFORE you started the game. mp3 and wav are supported. example: 'cookie.mp3'\nOr\nEnter the full path to play any WoW sound e.g. Sound\\Events\\GuldanCheers.wav",
	nomTexture = "Texture",
	aideTexture = "The texture to be shown. You can easily replace textures by changing the files Aura#.tga in the Addon's directory.",

	nomAnim1 = "Main Animation",
	nomAnim2 = "Secondary Animation",
	aideAnim1 = "Animate the texture or not, with various effects.",
	aideAnim2 = "This animation will be shown with less opacity than the main animaton. Attention, to not overload the screen.",

	nomDeform = "Deformation",
	aideDeform = "Stretch the texture in height or in width.",

	aideColor = "Click here to change the color of the texture.",
	aideTimerColor = "Click here to change the color of the timer.",
	aideStacksColor = "Click here to change the color of the stacks.",
	aideFont = "Click here to pick Font. Press OK to apply the selection.",
	aideMultiID = "Enter here other Aura IDs to combine checks. Multiple IDs must be separated with '/'. Aura ID can be found as [#] on first line of Aura tooltip.", 
	aideTooltipCheck = "Also check the tooltip contains this text",

	aideBuff = "Enter here the name of the buff, or a part of the name, which must activate/deactivate the effect. You can enter several names (ex: Super Buff/Power)",
	aideBuff2 = "Enter here the name of the debuff, or a part of the name, which must activate/deactivate the effect. You can enter several names (ex: Dark Disease/Plague)",
	aideBuff3 = "Enter here the type of the debuff which must activate or deactivate the effect (Poison, Disease, Curse, Magic, CC, Silence, Stun, Snare, Root or None). You can enter several types (ex: Disease/Poison)",
	aideBuff4 = "Enter here the name of area of effect that must trigger this effect (like a rain of fire for example, the name of this AOE can be found in the combat log)",
	aideBuff5 = "Enter here the temporary enchant which must activate this effect : optionally prepend it with 'main/' or 'off/ to designate mainhand or offhand slot. (ex: main/crippling)",
	aideBuff6 = "Enter here the number of combo points that must activate this effect (ex : 1 or 1/2/3 or 0/4/5 etc...) ",
	aideBuff7 = "Enter here the name, or a part of the name, of an action in your action bars. The effect will be active when this action is usable.",
	aideBuff8 = "Enter here the name, or a part of the name, of a spell from your spellbook. You can enter a spell id [12345].",
	
	aideSpells = "Enter here the Spell Name that will trigger a spell alert Aura.",
	aideStacks = "Enter here the operator and the amount of stacks, required activate/deactivate the effect. Operator is required ex: '<5' '>3' '=11' '!5' '>=0' '<=6' '2-8'",

	aideStealableSpells = "Enter here the Stealable Spell Name that will trigger the Aura (use * for any stealable spell).", 
	aidePurgeableSpells = "Enter here the Purgeable Spell Name that will trigger the Aura (use * for any purgeable spell).", 

	aideTotems = "Enter here the Totem Name that will trigger the Aura or a number 1=Fire, 2=Earth, 3=Water, 4=Air (use * for any totem).", 

	aideRunes = "Enter here the Runes that will trigger the Aura B/b=Blood, F/f=frost, U/u=Unholy, D/d=Death (Death runes will count as the other types if you use uppercase or the ignorecase flag is set) ex: 'BF' 'BfU' 'DDD'", 

	aideUnitn = "Enter here the name of the unit, which must activate/deactivate the effect. You can enter only names, if they are in your raid or group.",
	aideUnitn2 = "Only for raid/group.",

	aideMaxTex = "Define the maximum number of textures available on the Effect Editor. If you add textures on the Mod directory (with the names AURA1.tga to AURA50.tga), you must indicate the correct number here.",
	aideWowTextures = "Check this to use the texture of WoW instead of textures in the Power Auras directory for this effect.",
	aideTextAura = "Check this to type text instead of texture.",
	aideRealaura = "Real Aura",
	aideCustomTextures = "Check this to use textures in the 'Custom' subdirectory. Put the name of the texture below (ex: myTexture.tga). You can also use a Spell Name (ex: Feign Death) or SpellID (ex: 5384).",
	aideRandomColor = "Check this to tell this effect to use random color each time it will be activated.",

	aideTexMode = "Uncheck this to use the texture opacity. By default, the darkest colors will be more transparent.",

	nomActivationBy = "Activation by :",

	nomOwnTex = "Use own Texture",
	aideOwnTex = "Use the De/Buff or Ability Texture instead.",
	nomStacks = "Stacks",

	nomUpdateSpeed = "Update speed",
	nomSpeed = "Animation speed",
	nomFPS = "Global Animation FPS",
	nomTimerUpdate = "Timer update speed",
	nomBegin = "Begin Animation",
	nomEnd = "End Animation",
	nomSymetrie = "Symmetry",
	nomAlpha = "Opacity",
	nomPos = "Position",
	nomTaille = "Size",

	nomExact = "Exact Name",
	nomThreshold = "Threshold",
	aideThreshInv = "Check this to invert the threshold logic. Unchecked = Low Warning / Checked = High Warning.",
	nomThreshInv = "</>",
	nomStance = "Stance",
	nomGTFO = "Alert Type",
	nomPowerType = "Power Type:",

	nomMine = "Cast by me",
	aideMine = "Check this to test only buffs/debuffs cast by the player",
	nomDispellable = "I can dispell",
	aideDispellable = "Check to show only buffs that are dispellable",
	nomCanInterrupt = "Can be Interrupted",
	aideCanInterrupt = "Check to show only for spells that can be Interrupted",
	nomOnMe = "Cast On Me",
	aideOnMe = "Only show if being Cast On Me",

	nomPlayerSpell = "Player Casting",
	aidePlayerSpell = "Check if Player is casting a spell",

	nomCheckTarget = "Enemy Target",
	nomCheckFriend = "Friendly Target",
	nomCheckParty = "Partymember",
	nomCheckFocus = "Focus",
	nomCheckRaid = "Raidmember",
	nomCheckGroupOrSelf = "Raid/Party or self",
	nomCheckGroupAny = "Any", 
	nomCheckOptunitn = "Unitname",

	aideTarget = "Check this to test an enemy target only.",
	aideTargetFriend = "Check this to test a friendly target only.",
	aideParty = "Check this to test a party member only.",
	aideGroupOrSelf = "Check this to test a party or raid member or self.",
	aideFocus = "Check this to test the focus only.",
	aideRaid = "Check this to test a raid member only.",
	aideGroupAny = "Check this to test buff on 'Any' party/raid member. Unchecked: Test that 'All' are buffed.",
	aideOptunitn = "Check this to test a special char in raid/group only.",	
	aideExact = "Check this to test the exact name of the buff/debuff/action.",
	aideStance = "Select which Stance,Aura or Form trigger the event.",
	aideGTFO = "Select which GTFO Alert will trigger the event.",
	aidePowerType = "Select which type of resource to track",

	aideShowSpinAtBeginning= "At the end of the begin animation show a 360 degree spin",
	nomCheckShowSpinAtBeginning = "Show Spin after begin animation ends",

	nomCheckShowTimer = "Show",
	nomTimerDuration = "Duration",
	aideTimerDuration = "Show a timer to simulate buff/debuff duration on the target (0 to deactivate)",
	aideShowTimer = "Check this to show the timer of this effect.",
	aideSelectTimer = "Select which timer will show the duration",
	aideSelectTimerBuff = "Select which timer will show the duration (this one is reserved for player's buffs)",
	aideSelectTimerDebuff = "Select which timer will show the duration (this one is reserved for player's debuffs)",

	nomCheckShowStacks = "Show",
	aideShowStacks = "Activate this to show the stacks for this effect.",

	nomCheckInverse = "Invert",
	aideInverse = "Invert the logic to show this effect only when buff/debuff is not active.",	

	nomCheckIgnoreMaj = "Ignore case",	
	aideIgnoreMaj = "Check this to ignore upper/lowercase of buff/debuff names.",

	nomAuraDebug= "Debug",
	aideAuraDebug = "Debug this Aura",

	nomDuration = "Anim. duration",
	aideDuration = "After this time, this effect will disapear (0 to deactivate)",

	nomOldAnimations = "Old Animations";
	aideOldAnimations = "Use Old Animations";
	
	nomCentiemes = "Show hundredth",
	nomDual = "Show two timers",
	nomHideLeadingZeros = "Hide Leading Zeros",
	nomTransparent = "Use transparent textures",
	nomActivationTime = "Show Time since activation",
	nomUseOwnColor = "Use own color:",
	nomUpdatePing = "Animate on refresh",
	nomRelative = "Relative to Main Aura",
	nomClose = "Close",
	nomEffectEditor = "Effect Editor",
	nomAdvOptions = "Options",
	nomMaxTex = "Maximum of textures available",
	nomTabAnim = "Animation",
	nomTabActiv = "Activation",
	nomTabSound = "Sound",
	nomTabTimer = "Timer",
	nomTabStacks = "Stacks",
	nomWowTextures = "WoW Textures",
	nomCustomTextures = "Custom Textures",
	nomTextAura = "Text Aura",
	nomRealaura = "Real Aura",
	nomRandomColor = "Random Colors",
	nomTexMode = "Glow",

	nomTalentGroup1 = "Spec 1",
	aideTalentGroup1 = "Show this effect only when you are in your primary talent spec.",
	nomTalentGroup2 = "Spec 2",
	aideTalentGroup2 = "Show this effect only when you are in your secondary talent spec.",

	nomReset = "Reset Editor Positions",	
	nomPowaShowAuraBrowser = "Show Aura Browser",
	
	nomDefaultTimerTexture = "Default Timer Texture",
	nomTimerTexture = "Timer Texture",
	nomDefaultStacksTexture = "Default Stacks Texture",
	nomStacksTexture = "Stacks Texture",
	
	Enabled = "Enabled",
	Default = "Default",

	Ternary = {
		combat = "In Combat",
		inRaid = "In Raid",
		inParty = "In Party",
		isResting = "Resting",
		ismounted = "Mounted",
		inVehicle = "In Vehicle",
		isAlive= "Alive",
		PvP= "PvP flag set",
		Instance5Man= "5-Man",
		Instance5ManHeroic= "5-Man Hc",
		Instance10Man= "10-Man",
		Instance10ManHeroic= "10-Man Hc",
		Instance25Man= "25-Man",
		Instance25ManHeroic= "25-Man Hc",
		InstanceBg= "Battleground",
		InstanceArena= "Arena",
	},

	nomWhatever = "Ignored",
	aideTernary = "Sets how the status effects how this aura is shown.",
	TernaryYes = {
		combat = "Only When In Combat",
		inRaid = "Only When In Raid",
		inParty = "Only When In Party",
		isResting = "Only When Resting",
		ismounted = "Only When Mounted",
		inVehicle = "Only When In Vehicle",
		isAlive= "Only When Alive",
		PvP= "Only when PvP flag set",
		Instance5Man= "Only when in a 5-Man Normal instance",
		Instance5ManHeroic= "Only when in a 5-Man Heroic instance",
		Instance10Man= "Only when in a 10-Man Normal instance",
		Instance10ManHeroic= "Only when in a 10-Man Heroic instance",
		Instance25Man= "Only when in a 25-Man Normal instance",
		Instance25ManHeroic= "Only when in a 25-Man Heroic instance",
		InstanceBg= "Only when in a Battleground",
		InstanceArena= "Only when in an Arena instance",
		RoleTank     = "Only when a Tank",
		RoleHealer   = "Only when a Healer",
		RoleMeleDps  = "Only when a Melee DPS",
		RoleRangeDps = "Only when a Ranged DPS",
	},
	TernaryNo = {
		combat = "Only When Not in Combat",
		inRaid = "Only When Not in Raid",
		inParty = "Only When Not in Party",
		isResting = "Only When Not Resting",
		ismounted = "Only When Not Mounted",
		inVehicle = "Only When Not in Vehicle",
		isAlive= "Only When Dead",
		PvP= "Only when PvP flag Not set",
		Instance5Man= "Only when Not in a 5-Man Normal instance",
		Instance5ManHeroic= "Only when Not in a 5-Man Heroic instance",
		Instance10Man= "Only when Not in a 10-Man Normal instance",
		Instance10ManHeroic= "Only when Not in a 10-Man Heroic instance",
		Instance25Man= "Only when Not in a 25-Man Normal instance",
		Instance25ManHeroic= "Only when Not in a 25-Man Heroic instance",
		InstanceBg= "Only when Not in a Battleground",
		InstanceArena= "Only when Not in an Arena instance",
		RoleTank     = "Only when Not a Tank",
		RoleHealer   = "Only when Not a Healer",
		RoleMeleDps  = "Only when Not a Melee DPS",
		RoleRangeDps = "Only when Not a Ranged DPS",
	},
	TernaryAide = {
		combat = "Effect modified by Combat status.",
		inRaid = "Effect modified by Raid status.",
		inParty = "Effect modified by Party status.",
		isResting = "Effect modified by Resting status.",
		ismounted = "Effect modified by Mounted status.",
		inVehicle = "Effect modified by Vehicle status.",
		isAlive= "Effect modified by Alive status.",
		PvP= "Effect modified by PvP flag",
		Instance5Man= "Effect modified by being in a 5-Man Normal instance",
		Instance5ManHeroic= "Effect modified by being in a 5-Man Heroic instance",
		Instance10Man= "Effect modified by being in a 10-Man Normal instance",
		Instance10ManHeroic= "Effect modified by being in a 10-Man Heroic instance",
		Instance25Man= "Effect modified by being in a 25-Man Normal instance",
		Instance25ManHeroic= "Effect modified by being in a 25-Man Heroic instance",
		InstanceBg= "Effect modified by being in a Battleground",
		InstanceArena= "Effect modified by being in an Arena instance",
		RoleTank     = "Effect modified by being a Tank",
		RoleHealer   = "Effect modified by being a Healer",
		RoleMeleDps  = "Effect modified by being a Melee DPS",
		RoleRangeDps = "Effect modified by being a Ranged DPS",
	},

	nomTimerInvertAura = "Invert Aura When Time Below",
	aidePowaTimerInvertAuraSlider = "Invert the aura when the duration is less than this limit (0 to deactivate)",
	nomTimerHideAura = "Hide Aura & Timer Until Time Above",
	aidePowaTimerHideAuraSlider = "Hide the aura and timer when the duration is greater than this limit (0 to deactivate)",

	aideTimerRounding = "When checked will round the timer up",
	nomTimerRounding = "Round Timer Up",
	
	aideAllowInspections = "Allow Power Auras to Inspect players to determine roles, turning this off will sacrifice accuracy for speed",
	nomAllowInspections = "Allow Inspections",

	nomIgnoreUseable = "Cooldown Only",
	aideIgnoreUseable = "Ignores if spell is usable (just uses cooldown)",

	nomIgnoreItemUseable = "Equipped Only",
	aideIgnoreItemUseable = "Ignores if item is usable (just if equipped)",
	
	nomCarried = "Only if in bags",
	aideCarried = "Ignores if item is usable (just if in a bag)",

	-- Diagnostic reason text, these have substitutions (using $1, $2 etc) to allow for different sententance constructions
	nomReasonShouldShow = "Should show because $1",
	nomReasonWontShow   = "Won't show because $1",
	
	nomReasonMulti = "All multiples match $1", --$1=Multiple match ID list
	
	nomReasonDisabled = "Power Auras Disabled",
	nomReasonGlobalCooldown = "Ignore Global Cooldown",
	
	nomReasonBuffPresent = "$1 has $2 $3", --$1=Target $2=BuffType, $3=BuffName (e.g. "Unit4 has Debuff Misery")
	nomReasonBuffMissing = "$1 doesn't have $2 $3", --$1=Target $2=BuffType, $3=BuffName (e.g. "Unit4 doesn't have Debuff Misery")
	nomReasonBuffFoundButIncomplete = "$2 $3 found for $1 but\n$4", --$1=Target $2=BuffType, $3=BuffName, $4=IncompleteReason (e.g. "Debuff Sunder Armor found for Target but\nStacks<=2")
	
	nomReasonOneInGroupHasBuff     = "$1 has $2 $3",            --$1=GroupId   $2=BuffType, $3=BuffName (e.g. "Raid23 has Buff Blessing of Kings")
	nomReasonNotAllInGroupHaveBuff = "Not all in $1 have $2 $3", --$1=GroupType $2=BuffType, $3=BuffName (e.g. "Not all in Raid have Buff Blessing of Kings")
	nomReasonAllInGroupHaveBuff    = "All in $1 have $2 $3",     --$1=GroupType $2=BuffType, $3=BuffName (e.g. "All in Raid have Buff Blessing of Kings")
	nomReasonNoOneInGroupHasBuff   = "No one in $1 has $2 $3",  --$1=GroupType $2=BuffType, $3=BuffName (e.g. "No one in Raid has Buff Blessing of Kings")

	nomReasonBuffPresentTimerInvert = "Buff present, timer invert",
	nomReasonBuffPresentNotMine     = "Not cast by me",
	nomReasonBuffFound               = "Buff present",
	nomReasonStacksMismatch         = "Stacks = $1 expecting $2", --$1=Actual Stack count, $2=Expected Stack logic match (e.g. ">=0")

	nomReasonAuraMissing = "Aura missing",
	nomReasonAuraOff     = "Aura off",
	nomReasonAuraBad     = "Aura bad",
	
	nomReasonNotForTalentSpec = "Aura not active for this talent spec",
	
	nomReasonPlayerDead     = "Player is DEAD",
	nomReasonPlayerAlive    = "Player is Alive",
	nomReasonNoTarget       = "No Target",
	nomReasonTargetPlayer   = "Target is you",
	nomReasonTargetDead     = "Target is Dead",
	nomReasonTargetAlive    = "Target is Alive",
	nomReasonTargetFriendly = "Target is Friendly",
	nomReasonTargetNotFriendly = "Target not Friendly",
	
	nomReasonNotInCombat = "Not in combat",
	nomReasonInCombat = "In combat",
	
	nomReasonInParty = "In Party",
	nomReasonInRaid = "In Raid",
	nomReasonNotInParty = "Not in Party",
	nomReasonNotInRaid = "Not in Raid",
	nomReasonNotInGroup = "Not in Party/Raid",
	nomReasonNoFocus = "No focus",	
	nomReasonNoCustomUnit = "Can't find custom unit not in party, raid or with pet unit=$1",
	nomReasonPvPFlagNotSet = "PvP flag not set",
	nomReasonPvPFlagSet = "PvP flag set",
	
	nomReasonNotMounted = "Not Mounted",
	nomReasonMounted = "Mounted",		
	nomReasonNotInVehicle = "Not In Vehicle",
	nomReasonInVehicle = "In Vehicle",		
	nomReasonNotResting = "Not Resting",
	nomReasonResting = "Resting",		
	nomReasonStateOK = "State OK",
	
	nomReasonNotIn5ManInstance = "Not in 5-Man Instance",
	nomReasonIn5ManInstance = "In 5-Man Instance",		
	nomReasonNotIn5ManHeroicInstance = "Not in 5-Man Heroic Instance",
	nomReasonIn5ManHeroicInstance = "In 5-Man Heroic Instance",		
	
	nomReasonNotIn10ManInstance = "Not in 10-Man Instance",
	nomReasonIn10ManInstance = "In 10-Man Instance",		
	nomReasonNotIn10ManHeroicInstance = "Not in 10-Man Heroic Instance",
	nomReasonIn10ManHeroicInstance = "In 10-Man Heroic Instance",		
	
	nomReasonNotIn25ManInstance = "Not in 25-Man Instance",
	nomReasonIn25ManInstance = "In 25-Man Instance",		
	nomReasonNotIn25ManHeroicInstance = "Not in 25-Man Heroic Instance",
	nomReasonIn25ManHeroicInstance = "In 25-Man Heroic Instance",		
	
	nomReasonNotInBgInstance = "Not in Battleground Instance",
	nomReasonInBgInstance = "In Battleground Instance",		
	nomReasonNotInArenaInstance = "Not in Arena Instance",
	nomReasonInArenaInstance = "In Arena Instance",

	nomReasonInverted        = "$1 (inverted)", -- $1 is the reason, but the inverted flag is set so the logic is reversed
	
	nomReasonSpellUsable     = "Spell $1 usable",
	nomReasonSpellNotUsable  = "Spell $1 not usable",
	nomReasonSpellNotReady   = "Spell $1 Not Ready, on cooldown, timer invert",
	nomReasonSpellNotEnabled = "Spell $1 not enabled ",
	nomReasonSpellNotFound   = "Spell $1 not found",
	nomReasonSpellOnCooldown = "Spell $1 on Cooldown",
	
	nomReasonCastingOnMe	 = "$1 is casting $2 on me", --$1=CasterName $2=SpellName (e.g. "Rotface is casting Slime Spray on me")
	nomReasonNotCastingOnMe	 = "No matching spell being cast on me",
	
	nomReasonItemUsable     = "Item $1 usable",
	nomReasonItemNotUsable  = "Item $1 not usable",
	nomReasonItemNotReady   = "Item $1 Not Ready, on cooldown, timer invert",
	nomReasonItemNotEnabled = "Item $1 not enabled ",
	nomReasonItemNotFound   = "Item $1 not found",
	nomReasonItemOnCooldown = "Item $1 on Cooldown",
	
	nomReasonItemEquipped    = "Item $1 equipped",
	nomReasonItemNotEquipped = "Item $1 not equipped",
						
	nomReasonItemInBags      = "Item $1 in bags",
	nomReasonItemNotInBags   = "Item $1 not in bags",
	nomReasonItemNotOnPlayer = "Item $1 not carried",

	nomReasonSlotUsable     = "$1 Slot usable",
	nomReasonSlotNotUsable  = "$1 Slot not usable",
	nomReasonSlotNotReady   = "$1 Slot Not Ready, on cooldown, timer invert",
	nomReasonSlotNotEnabled = "$1 Slot has no cooldown effect",
	nomReasonSlotNotFound   = "$1 Slot not found",
	nomReasonSlotOnCooldown = "$1 Slot on Cooldown",
	nomReasonSlotNone       = "$1 Slot is empty",
	
	nomReasonStealablePresent = "$1 has Stealable spell $2", --$1=Target $2=SpellName (e.g. "Focus has Stealable spell Blessing of Wisdom")
	nomReasonNoStealablePresent = "Nobody has Stealable spell $1", --$1=SpellName (e.g. "Nobody has Stealable spell Blessing of Wisdom")
	nomReasonRaidTargetStealablePresent = "Raid$1Target has has Stealable spell $2", --$1=RaidId $2=SpellName (e.g. "Raid21Target has Stealable spell Blessing of Wisdom")
	nomReasonPartyTargetStealablePresent = "Party$1Target has has Stealable spell $2", --$1=PartyId $2=SpellName (e.g. "Party4Target has Stealable spell Blessing of Wisdom")
	
	nomReasonPurgeablePresent = "$1 has Purgeable spell $2", --$1=Target $2=SpellName (e.g. "Focus has Purgeable spell Blessing of Wisdom")
	nomReasonNoPurgeablePresent = "Nobody has Purgeable spell $1", --$1=SpellName (e.g. "Nobody has Purgeable spell Blessing of Wisdom")
	nomReasonRaidTargetPurgeablePresent = "Raid$1Target has has Purgeable spell $2", --$1=RaidId $2=SpellName (e.g. "Raid21Target has Purgeable spell Blessing of Wisdom")
	nomReasonPartyTargetPurgeablePresent = "Party$1Target has has Purgeable spell $2", --$1=PartyId $2=SpellName (e.g. "Party4Target has Purgeable spell Blessing of Wisdom")

	nomReasonAoETrigger = "AoE $1 triggered", -- $1=AoE spell name
	nomReasonAoENoTrigger = "AoE no trigger for $1", -- $1=AoE spell match
	
	nomReasonEnchantMainInvert = "Main Hand $1 enchant found, timer invert", -- $1=Enchant match
	nomReasonEnchantMain = "Main Hand $1 enchant found", -- $1=Enchant match
	nomReasonEnchantOffInvert = "Off Hand $1 enchant found, timer invert"; -- $1=Enchant match
	nomReasonEnchantOff = "Off Hand $1 enchant found", -- $1=Enchant match
	nomReasonNoEnchant = "No enchant found on weapons for $1", -- $1=Enchant match

	nomReasonNoUseCombo = "You do not use combo points",
	nomReasonComboMatch = "Combo points $1 match $2",-- $1=Combo Points, $2=Combo Match
	nomReasonNoComboMatch = "Combo points $1 no match with $2",-- $1=Combo Points, $2=Combo Match

	nomReasonActionNotFound = "not found on Action Bar",
	nomReasonActionReady = "Action Ready",
	nomReasonActionNotReadyInvert = "Action Not Ready (on cooldown), timer invert",
	nomReasonActionNotReady = "Action Not Ready (on cooldown)",
	nomReasonActionlNotEnabled = "Action not enabled",
	nomReasonActionNotUsable = "Action not usable",

	nomReasonYouAreCasting = "You are casting $1", -- $1=Casting match
	nomReasonYouAreNotCasting = "You are not casting $1", -- $1=Casting match
	nomReasonTargetCasting = "Target casting $1", -- $1=Casting match
	nomReasonFocusCasting = "Focus casting $1", -- $1=Casting match
	nomReasonRaidTargetCasting = "Raid$1Target casting $2", --$1=RaidId $2=Casting match
	nomReasonPartyTargetCasting = "Party$1Target casting $2", --$1=PartyId $2=Casting match
	nomReasonNoCasting = "Nobody's target casting $1", -- $1=Casting match
	
	nomReasonStance = "Current Stance $1, matches $2", -- $1=Current Stance, $2=Match Stance
	nomReasonNoStance = "Current Stance $1, does not match $2", -- $1=Current Stance, $2=Match Stance
	
	nomReasonRunesNotReady = "Runes not Ready",
	nomReasonRunesReady = "Runes Ready",
	
	nomReasonPetExists= "Player has Pet",
	nomReasonPetMissing = "Player Pet Missing",
	
	nomReasonTrackingMissing = "Tracking not set to $1",
	nomTrackingSet = "Tracking set to $1",

	nomNotInInstance = "Not in correct instance",

	nomReasonStatic = "Static Aura",
	
	nomReasonUnknownName = "Unit name unknown",
	nomReasonRoleUnknown = "Role unknown",
	nomReasonRoleNoMatch = "No matching Role",

	nomReasonGTFOAlerts = "GTFO alerts are never always on.",

	ReasonStat = {
		Health     = {MatchReason="$1 Health low",          NoMatchReason="$1 Health not low enough"},
		Mana       = {MatchReason="$1 Mana low",            NoMatchReason="$1 Mana not low enough"},
		Power      = {MatchReason="$1 Power low", 			NoMatchReason="$1 Power not low enough", NilReason = "$1 has wrong Power Type"},
		Aggro      = {MatchReason="$1 has aggro",           NoMatchReason="$1 does not have aggro"},
		PvP        = {MatchReason="$1 PvP flag set",        NoMatchReason="$1 PvP flag not set"},
		SpellAlert = {MatchReason="$1 casting $2",        	NoMatchReason="$1 not casting $2"},
	},

});

--end
