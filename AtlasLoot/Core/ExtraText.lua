local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");
local BabbleBoss = AtlasLoot_GetLocaleLibBabble("LibBabble-Boss-3.0")
local BabbleInventory = AtlasLoot_GetLocaleLibBabble("LibBabble-Inventory-3.0")
local BabbleFaction = AtlasLoot_GetLocaleLibBabble("LibBabble-Faction-3.0")
local BabbleZone = AtlasLoot_GetLocaleLibBabble("LibBabble-Zone-3.0")

-- Colours stored for code readability
local GREY = "|cff999999";
local RED = "|cffff0000";
local WHITE = "|cffFFFFFF";
local GREEN = "|cff1eff00";
local PURPLE = "|cff9F3FFF";
local BLUE = "|cff0070dd";
local ORANGE = "|cffFF8400";
local INDENT = "   ";

AtlasLoot_ExtraText = {
    AhnKahet = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
    AzjolNerub = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
    AuchAuchenaiCrypts = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
    AuchManaTombs = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
    AuchSethekkHalls = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
    AuchShadowLabyrinth = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
    BlackfathomDeeps = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
    BlackrockDepths = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
        GREY..INDENT..AL["Set: The Gladiator"];
    };
    BlackrockSpireLower = {
        "";
        "";
        GREY..INDENT..AL["Trash Mobs"];
        GREY..INDENT..AL["Dungeon 1/2 Sets"];
    };
    BlackrockSpireUpper = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
        GREY..INDENT..AL["Dungeon 1/2 Sets"];
    };
    BlackTempleStart = {
        "";
        GREY..INDENT..AL["BT Patterns/Plans"];
        GREY..INDENT..AL["Trash Mobs"];
    };
    BlackTempleBasement = {
        "";
        GREY..INDENT..AL["BT Patterns/Plans"];
        GREY..INDENT..AL["Trash Mobs"];
    };
    BlackTempleMiddle = {
        "";
        GREY..INDENT..AL["BT Patterns/Plans"];
        GREY..INDENT..AL["Trash Mobs"];
    };
    BlackTempleTop = {
        "";
        GREY..INDENT..AL["BT Patterns/Plans"];
        GREY..INDENT..AL["Trash Mobs"];
    };
    BlackTempleFull = {
        "";
        GREY..INDENT..AL["BT Patterns/Plans"];
        GREY..INDENT..AL["Trash Mobs"];
    };
    BlackwingLair = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
        GREY..INDENT..AL["Tier 1/2 Sets"];
    };
    CFRTheSteamvault = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
        };

    CFRSerpentshrineCavern = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
        };

    CoTOldHillsbrad = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
    CoTBlackMorass = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
    CoTHyjal = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
    CoTOldStratholme = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
    TheDeadmines = {
        "";
        GREY..INDENT..AL["Set: Defias Leather"];
    };
    DireMaulEast = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
        GREY..INDENT..AL["Dire Maul Books"];
    };
    DireMaulNorth = {
        "";
        GREY..INDENT..AL["Tribute Run"];
        GREY..INDENT..AL["Dire Maul Books"];
    };
    DireMaulWest = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
        GREY..INDENT..AL["Dire Maul Books"];
    };
    DrakTharonKeep = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
	FHTheForgeOfSouls = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
	FHPitOfSaron = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
	FHHallsOfReflection = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
    Gnomeregan = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
    Gundrak = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
    HCTheShatteredHalls = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
    IcecrownStart = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
    IcecrownCitadelA = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
    IcecrownCitadelB = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
    IcecrownCitadelC = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
    Karazhan = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
    KarazhanStart = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
    KarazhanEnd = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
    MagistersTerrace = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
    MoltenCore = {
        "";
        GREY..INDENT..AL["Tier 1/2 Sets"];
        GREY..INDENT..AL["Random Boss Loot"];
        GREY..INDENT..AL["Trash Mobs"];
    };
    Naxxramas = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
        GREY..INDENT..AL["Tier 7/8 Sets"];
    };
    RazorfenDowns = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
    RazorfenKraul = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
    TempestKeepMechanar = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
    TempestKeepBotanica = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
    TempestKeepArcatraz = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
    TempestKeepTheEye = {
        "";
        GREY..INDENT..AL["Legendary Items for Kael'thas Fight"];
        GREY..INDENT..AL["Trash Mobs"];
    };
    TheOculus = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
    TheRuinsofAhnQiraj = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
        GREY..INDENT..AL["Class Books"];
        GREY..INDENT..AL["AQ Enchants"];
        GREY..INDENT..AL["AQ20 Class Sets"];
    };
    SMArmory = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
        GREY..INDENT..AL["Set: Chain of the Scarlet Crusade"];
    };
    SMCathedral = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
        GREY..INDENT..AL["Set: Chain of the Scarlet Crusade"];
    };
    SMGraveyard = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
        GREY..INDENT..AL["Set: Chain of the Scarlet Crusade"];
    };
    SMLibrary = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
        GREY..INDENT..AL["Set: Chain of the Scarlet Crusade"];
    };
    Scholomance = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
        GREY..INDENT..AL["Set: Necropile Raiment"];
        GREY..INDENT..AL["Set: Cadaverous Garb"];
        GREY..INDENT..AL["Set: Bloodmail Regalia"];
        GREY..INDENT..AL["Set: Deathbone Guardian"];
    };
    ShadowfangKeep = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
    TheStockade = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
    Stratholme = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
    SunwellPlateau = {
        "";
        GREY..INDENT..AL["SP Patterns/Plans"];
        GREY..INDENT..AL["Trash Mobs"];
    };
    TheSunkenTemple = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
    TheTempleofAhnQiraj = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
        GREY..INDENT..AL["AQ Enchants"];
        GREY..INDENT..AL["AQ40 Class Sets"];
        GREY..INDENT..AL["AQ Opening Quest Chain"];
    };
    TrialOfTheCrusader = {
        "";
        GREY..INDENT..AL["Tribute Run"];
        GREY..INDENT..AL["Trial of the Crusader Patterns/Plans"];
    };
    Uldaman = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
    UlduarHallsofLightning = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
    UlduarA = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
        GREY..INDENT..AL["Ulduar Formula/Patterns/Plans"];
        GREY..INDENT..AL["Tier 7/8 Sets"];
    };
    UlduarB = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
        GREY..INDENT..AL["Ulduar Formula/Patterns/Plans"];
        GREY..INDENT..AL["Tier 7/8 Sets"];
    };
    UlduarC = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
        GREY..INDENT..AL["Ulduar Formula/Patterns/Plans"];
        GREY..INDENT..AL["Tier 7/8 Sets"];
    };
    UlduarD = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
        GREY..INDENT..AL["Ulduar Formula/Patterns/Plans"];
        GREY..INDENT..AL["Tier 7/8 Sets"];
    };
    UlduarE = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
        GREY..INDENT..AL["Ulduar Formula/Patterns/Plans"];
        GREY..INDENT..AL["Tier 7/8 Sets"];
    };
    UlduarHallsofStone = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
    UtgardeKeep = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
    UtgardePinnacle = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
    VioletHold = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
    WailingCaverns = {
        "";
        GREY..INDENT..AL["Set: Embrace of the Viper"];
    };
    ZulAman = {
        "";
        GREY..INDENT..AL["Timed Reward Chest"];
        GREY..INDENT..AL["Trash Mobs"];
        "";
    };
    ZulFarrak = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
    };
    ZulGurub = {
        "";
        GREY..INDENT..AL["Trash Mobs"];
        GREY..INDENT..AL["Random Boss Loot"];
        GREY..INDENT..AL["ZG Class Sets"];
        GREY..INDENT..AL["ZG Enchants"];
    };
    AlteracValleyNorth = {
        "";
        GREEN..AL["Misc. Rewards"];
        GREEN..BabbleInventory["Armor"];
    };
    AlteracValleySouth = {
        "";
        GREEN..AL["Misc. Rewards"];
        GREEN..BabbleInventory["Armor"];
    };
    ArathiBasin = {
        "";
        GREEN..AL["Misc. Rewards"];
        GREEN..AL["Level 40-49 Rewards"];
        GREEN..AL["Level 20-39 Rewards"];
        "";
        GREEN..AL["Arathi Basin Sets"];
    };
    WarsongGulch = {
        "";
        GREEN..AL["Misc. Rewards"];
        GREEN..AL["Accessories"];
        GREEN..AL["Weapons"];
        GREEN..BabbleInventory["Armor"];
    };    
};