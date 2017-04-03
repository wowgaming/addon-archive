if (GetLocale() == "frFR") then

PowaAuras.Anim[0] = "[Invisible]";
PowaAuras.Anim[1] = "Statique";
PowaAuras.Anim[2] = "Clignotement";
PowaAuras.Anim[3] = "Agrandir";
PowaAuras.Anim[4] = "Pulsation";
PowaAuras.Anim[5] = "Effet bulle";
PowaAuras.Anim[6] = "Goutte d'eau";
PowaAuras.Anim[7] = "Electrique";
PowaAuras.Anim[8] = "R\195\169tr\195\169cir";
PowaAuras.Anim[9] = "Flamme";
PowaAuras.Anim[10] = "Orbite";
PowaAuras.Anim[11] = "Spin Clockwise";
PowaAuras.Anim[12] = "Spin Anti-Clockwise";

PowaAuras.BeginAnimDisplay[0] = "[Aucun]";
PowaAuras.BeginAnimDisplay[1] = "Zoom Avant";
PowaAuras.BeginAnimDisplay[2] = "Zoom Arriere";
PowaAuras.BeginAnimDisplay[3] = "Transparence seule";
PowaAuras.BeginAnimDisplay[4] = "Gauche";
PowaAuras.BeginAnimDisplay[5] = "Haut-Gauche";
PowaAuras.BeginAnimDisplay[6] = "Haut";
PowaAuras.BeginAnimDisplay[7] = "Haut-Droite";
PowaAuras.BeginAnimDisplay[8] = "Droite";
PowaAuras.BeginAnimDisplay[9] = "Bas-Droite";
PowaAuras.BeginAnimDisplay[10] = "Bas";
PowaAuras.BeginAnimDisplay[11] = "Bas-Gauche";
PowaAuras.BeginAnimDisplay[12] = "Bounce";

PowaAuras.EndAnimDisplay[0] = "[Aucun]";
PowaAuras.EndAnimDisplay[1] = "Zoom Avant";
PowaAuras.EndAnimDisplay[2] = "Zoom Arriere";
PowaAuras.EndAnimDisplay[3] = "Transparence seule";
PowaAuras.EndAnimDisplay[4] = "Spin";
PowaAuras.EndAnimDisplay[5] = "Spin In";

PowaAuras.Sound[0] = NONE;
PowaAuras.Sound[30] = NONE;

PowaAuras:MergeTables(PowaAuras.Text, 
{
	welcome = "Tapez /powa pour afficher les options.",

	aucune = "Aucune",
	aucun = "Aucun",
	largeur = "Largeur",
	hauteur = "Hauteur",
	mainHand = "droite",
	offHand = "gauche",
	bothHands = "toutes",

	DebuffType =
	{
		Magic   = "Magie",
		Disease = "Maladie",
		Curse   = "Mal\195\169diction",
		Poison  = "Poison",
	},

	DebuffCatType =
	{
		[PowaAuras.DebuffCatType.CC] = "CC",
		[PowaAuras.DebuffCatType.Silence] = "Silence",
		[PowaAuras.DebuffCatType.Snare] = "Snare",
		[PowaAuras.DebuffCatType.Stun] = "Stun",
		[PowaAuras.DebuffCatType.Root] = "Root",
		[PowaAuras.DebuffCatType.Disarm] = "Disarm",
		[PowaAuras.DebuffCatType.PvE] = "PvE",
	},
	
	AuraType =
	{
		[PowaAuras.BuffTypes.Buff] = "Buff",
		[PowaAuras.BuffTypes.Debuff] = "Debuff",
		[PowaAuras.BuffTypes.AoE] = "Debuff de zone",
		[PowaAuras.BuffTypes.TypeDebuff] = "Type du Debuff",
		[PowaAuras.BuffTypes.Enchant] = "Enchant. d'arme",
		[PowaAuras.BuffTypes.Combo] = "Combos",
		[PowaAuras.BuffTypes.ActionReady] = "Action utilisable",
		[PowaAuras.BuffTypes.Health] = "Health",
		[PowaAuras.BuffTypes.Mana] = "Mana",
		[PowaAuras.BuffTypes.EnergyRagePower] = "Rage/Energy/Runic",
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
	nomEnable = "Activer Power Auras",
	aideEnable = "Active tous les effets de Power Auras",

	nomDebug = "Activer Debug Messages",
	aideDebug = "Shows Debug Messages in the chat",
	ListePlayer = "Page",
	ListeGlobal = "Global",
	aideMove = "D\195\169place l'effet s\195\169l\195\169ctionn\195\169 ici.",
	aideCopy = "Copie l'effet s\195\169l\195\169ctionn\195\169 ici.",
	nomRename = "Renommer",
	aideRename = "Renomme la page d'effet en cours.",
	nomTest = "Tester",
	nomTestAll = "Test All",
	nomHide = "Tout masquer",
	nomEdit = "Editer",
	nomNew = "Nouveau",
	nomDel = "Suppr.",
	nomImport = "Import", --- untranslated
	nomExport = "Export", --- untranslated
	nomImportSet = "Import Set", 
	nomExportSet = "Export Set", 
	aideImport = "Paste the Aura String to the editbox and press \'Accept\'", --- untranslated
	aideExport = "Copy the Aura String from the editbox to share with others.", --- untranslated
	aideImportSet = "Press Ctrl-V to paste the Aura-Set-string and press \'Accept\' this will erase all auras on this page",
	aideExportSet = "Press Ctrl-C to copy all the Auras on this page for sharing.",
	aideDel = "Supprime l'effet s\195\169l\195\169ctionn\195\169 (appuyez sur CTRL pour autoriser la suppression)",
	nomMove = "D\195\169placer",
	nomCopy = "Copier",
	nomPlayerEffects = "Effets du personnage",
	nomGlobalEffects = "Effets\nglobaux",
	aideEffectTooltip = "(Maj-click pour mettre cet effet sur ON ou OFF)",
	aideEffectTooltip2 = "(Ctrl-click to give reason for activation)",
	
	
	aideItems = "Enter full name of Item or [xxx] for Id",
	aideSlots = "Enter name of slot to track: Ammo, Back, Chest, Feet, Finger0, Finger1, Hands, Head, Legs, MainHand, Neck, Ranged, SecondaryHand, Shirt, Shoulder, Tabard, Trinket0, Trinket1, Waist, Wrist",
	aideTracking = "Enter name of Tracking type e.g. fish",


	-- editor
	nomSoundStarting = "Starting Sound:",
	nomSound = "Sound to play",
	nomSound2 = "More sounds to play",
	aideSound = "Plays a sound at the beginning.",
	aideSound2 = "Plays a sound at the beginning.",
	nomCustomSound = "OR soundfile:",
	aideCustomSound = "Enter a soundfile that is in the Sounds folder, BEFORE you started the game. mp3 and wav are supported. example: 'cookie.mp3' ;)",

	nomSoundEnding = "Ending Sound:",
	nomSoundEnd = "Sound to play",
	nomSound2End = "More sounds to play",
	aideSoundEnd = "Plays a sound at the end.",
	aideSound2End = "Plays a sound at the end.",
	nomCustomSoundEnd = "OR soundfile:",
	aideCustomSoundEnd = "Enter a soundfile that is in the Sounds folder, BEFORE you started the game. mp3 and wav are supported. example: 'cookie.mp3' ;)",

	nomTexture = "Texture",
	aideTexture = "La texture \195\160 afficher. Vous pouvez facilement remplacer les textures en changeant les fichier Aura#.tga du dossier de l'AddOn.",

	nomAnim1 = "Animation principale",
	nomAnim2 = "Animation secondaire",
	aideAnim1 = "Anime la texture ou pas, avec diff\195\169rents effets.",
	aideAnim2 = "Cette animation sera affich\195\169e avec moins d'opacit\195\169 que la principale. Attention, afin de ne pas surcharger le tout.",

	nomDeform = "D\195\169formation",
	aideDeform = "Etire la texture vers le haut ou en largeur.",

	aideColor = "Cliquez ici pour changer la couleur de la texture.",
	aideTimerColor = "Click here to change the color of the timer.",
	aideStacksColor = "Click here to change the color of the stacks.",
	aideFont = "Click here to pick Font. Press OK to apply the selection.", --- untranslated
	aideMultiID = "Enter here other Aura IDs to combine checks. Multiple IDs must be separated with '/'. Aura ID can be found as [#] on first line of Aura tooltip.", --- untranslated
	aideTooltipCheck = "Also check the tooltip starts with this text", --- untranslated

	aideBuff = "Entrez ici le nom du buff, ou une partie du nom, qui doit activer/d\195\169sactiver l'effet. Vous pouvez entrer plusieurs noms s'ils sont s\195\169par\195\169 comme il convient (ex: Super Buff/Puissance)",
	aideBuff2 = "Entrez ici le nom du d\195\169buff, ou une partie du nom, qui doit activer/d\195\169sactiver l'effet. Vous pouvez entrer plusieurs noms s'ils sont s\195\169par\195\169 comme il convient (ex: Maladie noire/Peste)",
	aideBuff3 = "Entrez ici le type du d\195\169buff qui doit activer ou d\195\169sactiver l'effet (Poison, Maladie, Mal\195\169diction, Magie ou Aucun). Vous pouvez aussi entrer plusieurs types de d\195\169buffs \195\160 la fois.",
	aideBuff4 = "Entrez ici le nom de l'effet de zone qui activera l'effet (comme une pluie de feu par exemple, g\195\169n\195\169ralement le nom de l'effet est disponible dans le journal de combat)",
	aideBuff5 = "Enter here the temporary enchant which must activate this effect : optionally prepend it with 'main/' or 'off/ to designate mainhand or offhand slot. (ex: main/crippling)", --- untranslated
	aideBuff6 = "Vous pouvez entrez ici le ou les chiffres des points de combos qui activeront l'effet (ex : 1 ou 1/2/3 ou 0/4/5 etc...) ",
	aideBuff7 = "Indiquez ici le nom, ou une partie du nom, d'une des actions dans vos barres. L'effet sera actif si l'action est utilisable.",
	aideBuff8 = "Enter here the name, or a part of the name, of a spell from your spellbook. You can enter a spell id [12345].",
	
	aideSpells = "Enter here the Spell Name that will trigger a spell alert Aura.", --- untranslated
	aideStacks = "Enter here the operator and the amount of stacks, which must activate/deactivate the effect. It works only with an operator! ex: '<5' '>3' '=11' '!5' '>=0' '<=6' '2-8'", -- untranslated

	aideStealableSpells = "Enter here the Stealable Spell Name that will trigger the Aura (use * for any stealable spell).", 
	aidePurgeableSpells = "Enter here the Purgeable Spell Name that will trigger the Aura (use * for any purgeable spell).", 

	aideTotems = "Enter here the Totem Name that will trigger the Aura or a number 1=Fire, 2=Earth, 3=Water, 4=Air (use * for any totem).", 

	aideRunes = "Enter here the Runes that will trigger the Aura B=Blood, F=frost, U=Unholy, D=Death (Death runes will also count as the other types) ex: 'BF' 'BFU' 'DDD'", 

	aideUnitn = "Entrez ici le nom du unit, qui doit activer/d\195\169sactiver l'effet. Works only for raid/partymembers.",
	aideUnitn2 = "Only for raid/group.",

	aideMaxTex = "Defini le maximum de textures disponibles dans l'Editeur d'Effets. Si vous rajoutez des textures en les mettant dans le dossier de l'AddOn (nomm\195\169es de AURA1.tga \195\160 AURA50.tga) c'est ici qu'il faudra le signaler.",
	aideAddEffect = "Ajoute une page d'effet.",
	aideWowTextures = "Cochez cette case pour utiliser les textures internes du jeu plut\195\180t que le dossier de l'addon pour cet effet.",
	aideTextAura = "Check this to type text instead of texture.", -- untranslated
	aideRealaura = "Reale Aura",
	aideCustomTextures = "Cochez cette case pour utiliser les textures pr\195\169sentes dans le sous-dossier 'Custom'. Vous devez connaitre le nom du fichier et indiquer son nom (ex : myTexture.tga)", --- untraslated (needs update to match enGB string)
	aideRandomColor = "Cochez cette case pour que l'effet prenne des couleurs au hasard \195\160 chaque activation.",

	aideTexMode = "Decochez cette case pour utiliser la transparence de la texture. Par defaut, les couleurs sombres seront plus transparentes.",

	nomActivationBy = "Activation par :",

	nomOwnTex = "Use own Texture", -- untranslated
	aideOwnTex = "Use the De/Buff or Ability Texture instead.", -- untranslated
	nomStacks = "Stacks", -- untranslated

	nomUpdateSpeed = "Update speed",
	nomSpeed = "Vitesse d'Anim.",
	nomFPS = "Global Animation FPS",
	nomTimerUpdate = "Timer update speed",
	nomBegin = "Animation de d\195\169part",
	nomEnd = "Animation de fin",
	nomSymetrie = "Sym\195\169trie",
	nomAlpha = "Transparence",
	nomPos = "Position",
	nomTaille = "Taille",

	nomExact = "Exact Name",
	nomThreshold = "Threshold",
	aideThreshInv = "Check this to invert the threshold logic. Unchecked = Low Warning / Checked = High Warning.",
	nomThreshInv = "</>",
	nomStance = "Stance",
	nomGTFO = "Alert Type",

	nomMine = "Cast by me",
	aideMine = "Check this to test only buffs/debuffs cast by the player",
	nomDispellable = "I can dispell",
	aideDispellable = "Check to show only buffs that are dispellable",
	nomCanInterrupt = "Can be Interrupted",
	aideCanInterrupt = "Check to show only for spells that can be Interrupted",

	nomPlayerSpell = "Player Casting",
	aidePlayerSpell = "Check if Player is casting a spell",

	nomCheckTarget = "Cible ennemie",
	nomCheckFriend = "Cible amie",
	nomCheckParty = "Cible partie",
	nomCheckFocus = "Cible focus",
	nomCheckRaid = "Cible raid",
	nomCheckGroupOrSelf = "Raid/Party or self",
	nomCheckGroupAny = "Any", --- untranslated
	nomCheckOptunitn = "Cible unit",

	aideTarget = "Cochez cette case pour v\195\169rifier plut\195\180t les buffs/d\195\169buffs d'une cible ennemie.",
	aideTargetFriend = "Cochez cette case pour v\195\169rifier plut\195\180t les buffs/d\195\169buffs d'une cible amie.",
	aideParty = "Cochez cette case pour v\195\169rifier plut\195\180t les buffs/d\195\169buffs d'une cible partie.",
	aideGroupOrSelf = "Check this to test a party or raid member or self.",
	aideFocus = "Cochez cette case pour v\195\169rifier plut\195\180t les buffs/d\195\169buffs d'une cible focus.",
	aideRaid = "Cochez cette case pour v\195\169rifier plut\195\180t les buffs/d\195\169buffs d'une cible raid.",
	aideGroupAny = "Cochez cette case pour v\195\169rifier plut\195\180t les buffs/d\195\169buffs d'une cible unit de raid ou partie.",	
	aideOptunitn = "Check this to test a special char in raid/group only.",	
	aideExact = "Check this to test the exact name of the buff/debuff.",
	aideStance = "Select which Stance,Aura or Form trigger the event.",
	aideGTFO = "Select which GTFO Alert will trigger the event.",

	aideShowSpinAtBeginning= "At the end of the begin animation show a 360 degree spin",
	nomCheckShowSpinAtBeginning = "Show Spin after begin animation ends",

	nomCheckShowTimer = "Afficher",
	nomTimerDuration = "Chronometre",	
	aideTimerDuration = "Affiche un timer pour simuler la dur\195\169e d'un buff/debuff sur la cible (0 pour d\195\169sactiver)",
	aideShowTimer = "Cochez cette case pour afficher la dur\195\169e de cet effet.",
	aideSelectTimer = "Choisissez quel timer sera pris pour afficher la dur\195\169e",
	aideSelectTimerBuff = "Choisissez quel timer sera pris pour afficher la dur\195\169e (celui-ci est reserv\195\169 aux buffs du joueur)",
	aideSelectTimerDebuff = "Choisissez quel timer sera pris pour afficher la dur\195\169e (celui-ci est reserv\195\169 aux debuffs du joueur)",

	nomCheckShowStacks = "Show",

	nomCheckInverse = "Afficher si inactif",
	aideInverse = "Cochez cette case pour afficher cet effet uniquement quand le buff/d\195\169buff n'est pas actif.",

	nomCheckIgnoreMaj = "Ignorer les majuscules",
	aideIgnoreMaj = "Cochez cette case pour ignorer les majuscules/minuscules du nom des buffs/d\195\169buffs.",

	nomAuraDebug= "Debug",
	aideAuraDebug = "Debug this Aura",

	nomDuration = "Dur\195\169e de l'Anim.",
	aideDuration = "Pass\195\169 ce d\195\169lai, l'animation sera masqu\195\169e (0 pour d\195\169sactiver)",

	nomCentiemes = "Afficher centiemes",
	nomDual = "Afficher 2 dur\195\169es",
	nomHideLeadingZeros = "Hide Leading Zeros",
	nomTransparent = "Use transparent textures",
	nomActivationTime = "Show Time since activation",
	nomUseOwnColor = "Use own color:",
	nomUpdatePing = "Animate on refresh",
	nomRelative = "Relative to Main Aura",
	nomClose = "Fermer",
	nomEffectEditor = "Editeur d'Effet",
	nomAdvOptions = "Options",
	nomMaxTex = "Maximum de textures disponibles",
	nomTabAnim = "Animation",
	nomTabActiv = "Activation",
	nomTabSound = "Sound",
	nomTabTimer = "Timer",
	nomTabStacks = "Stacks",
	nomWowTextures = "Textures WoW",
	nomCustomTextures = "Autres Textures",
	nomTextAura = "Text Aura", --- untranslated
	nomRealaura = "Reale Aura",
	nomRandomColor = "Couleurs al\195\169atoires",
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
	},

	nomTimerInvertAura = "Invert Aura When Time Below",
	aidePowaTimerInvertAuraSlider = "Invert the aura when the duration is less than this limit (0 to deactivate)",
	nomTimerHideAura = "Hide Aura & Timer Until Time Above",
	aidePowaTimerHideAuraSlider = "Hide the aura and timer when the duration is greater than this limit (0 to deactivate)",

	aideTimerRounding = "When checked will round the timer up",
	nomTimerRounding = "Round Timer Up",

	nomIgnoreUseable = "Cooldown Only",
	aideIgnoreUseable = "Ignores if spell is usable (just uses cooldown)",

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
	
	nomReasonItemUsable     = "Item $1 usable",
	nomReasonItemNotUsable  = "Item $1 not usable",
	nomReasonItemNotReady   = "Item $1 Not Ready, on cooldown, timer invert",
	nomReasonItemNotEnabled = "Item $1 not enabled ",
	nomReasonItemNotFound   = "Item $1 not found",
	nomReasonItemOnCooldown = "Item $1 on Cooldown",	
	
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

	nomReasonStatic = "Static Aura",

	nomReasonGTFOAlerts = "GTFO alerts are never always on.",

	ReasonStat = {
		Health     = {MatchReason="$1 Health low",          NoMatchReason="$1 Health not low enough"},
		Mana       = {MatchReason="$1 Mana low",            NoMatchReason="$1 Mana not low enough"},
		RageEnergy = {MatchReason="$1 EnergyRagePower low", NoMatchReason="$1 EnergyRagePower not low enough"},
		Aggro      = {MatchReason="$1 has aggro",           NoMatchReason="$1 does not have aggro"},
		PvP        = {MatchReason="$1 PvP flag set",        NoMatchReason="$1 PvP flag not set"},
	},

});

end
