-------------------------------------------------------------------
--                          Total RP 2
--            A roleplay addon for World of Warcraft
-- Created by Sylvain "Telkostrasz" Cossement (up to version 1.017)
--   Licence : CC BY-NC-SA (http://creativecommons.org/licenses/)
-------------------------------------------------------------------


-------------------------------------------------------------------------------
-- [ Variables Systeme de l'add-on ] -- 
-------------------------------------------------------------------------------

TRP2_addonname = "Total RP 2";
BINDING_HEADER_TRP2 = TRP2_addonname;
TRP2_version = "1022";
TRP2_Joueur = UnitName("player");
TRP2_Royaume = GetRealmName();
TRP2_locRace,TRP2_enRace = UnitRace("player");
TRP2_locClass,TRP2_enClass = UnitClass("player");
TRP2_PlayerSex = UnitSex("player");
TRP2_bAlreadyTell = false;
TRP2_bAlreadyTellRSP = false;
TRP2_PrecisionPlanque = 250;
TRP2_UPDATEDOCUSENSI = 1.5;

TRP2_DesBarres = "-----------------------------------";

TRP2_ONGLETTEXTURE = {
	["Registre"] = "Interface\\ICONS\\INV_Misc_Book_02";
	["Journal"] = "Interface\\ICONS\\INV_Misc_Book_09";
	["Pets"] = "Interface\\ICONS\\INV_Box_PetCarrier_01";
	
	["Creation"] = "Interface\\ICONS\\INV_Misc_EngGizmos_swissArmy";
	["Options"] = "Interface\\ICONS\\INV_Misc_Wrench_02";
	
	["General"] = "Interface\\ICONS\\INV_Misc_GroupLooking";
	["Physique"] = "Interface\\ICONS\\Ability_Warrior_StrengthOfArms";
	["Psycho"] = "Interface\\ICONS\\Spell_Arcane_MindMastery";
	["Histoire"] = "Interface\\ICONS\\INV_Misc_Book_09";
	["Actu"] = "Interface\\ICONS\\INV_Misc_Note_03";
	["Caracteristiques"] = "Interface\\ICONS\\Spell_Holy_ImprovedResistanceAuras";
	
	["Quetes"] = "Interface\\ICONS\\Achievement_Quests_Completed_01";
	
	["Liste"] = "Interface\\ICONS\\INV_Misc_Note_05";
	["Consulte"] = "Interface\\ICONS\\Ability_Warrior_Revenge";
	["Edite"] = "Interface\\ICONS\\INV_Inscription_TradeSkill01";
};

TRP2_relation_texture = {"Interface\\ICONS\\Ability_DualWield",
					"Interface\\ICONS\\Achievement_Reputation_01",
					"Interface\\ICONS\\Achievement_Reputation_05",
					"Interface\\ICONS\\Achievement_Reputation_08",
					"Interface\\ICONS\\Achievement_Reputation_06",
					"Interface\\ICONS\\INV_ValentinesCandy",
					"Interface\\ICONS\\Achievement_Reputation_07"};
					
TRP2_relation_color = {"|cffff0000","|cffaaaaff","|cff00ffff","|cffffff00","|cff00ff00","|cffff7fff","|cffff7f00"};
TRP2_relation_color_RGB = {{0.3,0.3,0.3},{1,0,0},{0.5,0.5,1},{1,1,1},{0,1,0},{1,0.5,1},{1,0.5,0}};

TRP2_ItemQuality = {"|cff9d9d9d","|cffffffff","|cff1eff00","|cff0070dd","|cffa335ee","|cffff8000"};

TRP2_Auras_Color = {"{r}","{w}","{v}"};
TRP2_Auras_Color_RGB = {{1,0,0},{1,1,1},{0,1,0}};
TRP2_COLORREQUESTTAB = {};

TRP2_preTabDiscu = {
	["CHAT_MSG_SAY"] = "",
	["CHAT_MSG_YELL"] = "",
	["CHAT_MSG_PARTY"] = "|Hchannel:group|h[Groupe]|h",
	["CHAT_MSG_RAID"] = "|Hchannel:raid|h[Raid]|h",
	["CHAT_MSG_GUILD"] = "|Hchannel:guilde|h[Guilde]|h",
	["CHAT_MSG_OFFICER"] = "|Hchannel:officer|h[Officier]|h",
	["CHAT_MSG_RAID_LEADER"] = "|Hchannel:raid|h[Chef de Raid]|h",
	["CHAT_MSG_WHISPER"] = "",
	["CHAT_MSG_WHISPER_INFORM"] = "À ",
	["CHAT_MSG_TEXT_EMOTE"] = "",
	["CHAT_MSG_PARTY_LEADER"] = "|Hchannel:group|h[Chef de Groupe]|h",
}

TRP2_postTabDiscu = {
	["CHAT_MSG_SAY"] = "|r] dit : ",
	["CHAT_MSG_YELL"] = "|r] crie : ",
	["CHAT_MSG_PARTY"] = "|r] : ",
	["CHAT_MSG_RAID"] = "|r] : ",
	["CHAT_MSG_GUILD"] = "|r] : ",
	["CHAT_MSG_OFFICER"] = "|r] : ",
	["CHAT_MSG_RAID_LEADER"] = "|r] : ",
	["CHAT_MSG_WHISPER"] = "|r] chuchote : ",
	["CHAT_MSG_WHISPER_INFORM"] = "|r] : ",
	["CHAT_MSG_TEXT_EMOTE"] = "",
	["CHAT_MSG_PARTY_LEADER"] = "|r] : ",
}

TRP2_classes_color = {
	["HUNTER"] = "|cffabd473",
	["WARLOCK"] = "|cff9482c9",
	["PRIEST"] = "|cffffddff",
	["PALADIN"] = "|cfff58cba",
	["MAGE"] = "|cff69ccf0",
	["ROGUE"] = "|cfffff569 ",
	["DRUID"] = "|cffff7d0a",
	["SHAMAN"] = "|cff2459ff",
	["WARRIOR"] = "|cffc79c6e",
	["DEATHKNIGHT"] = "|cffc41f3b",
	["MONK"] = "|cff96ff00",
}

TRP2_textureRace = {
	Human = {
		Male = "Achievement_Character_Human_Male",
		Female = "Achievement_Character_Human_Female",
	},
	Gnome = {
		Male = "Achievement_Character_Gnome_Male",
		Female = "Achievement_Character_Gnome_Female",
	},
	Scourge = {
		Male = "Achievement_Character_Undead_Male",
		Female = "Achievement_Character_Undead_Female",
	},
	NightElf = {
		Male = "Achievement_Character_Nightelf_Male",
		Female = "Achievement_Character_Nightelf_Female",
	},
	Dwarf = {
		Male = "Achievement_Character_Dwarf_Male",
		Female = "Achievement_Character_Dwarf_Female",
	},
	Draenei = {
		Male = "Achievement_Character_Draenei_Male",
		Female = "Achievement_Character_Draenei_Female",
	},
	Orc = {
		Male = "Achievement_Character_Orc_Male",
		Female = "Achievement_Character_Orc_Female",
	},
	BloodElf = {
		Male = "Achievement_Character_Bloodelf_Male",
		Female = "Achievement_Character_Bloodelf_Female",
	},
	Troll = {
		Male = "Achievement_Character_Troll_Male",
		Female = "Achievement_Character_Troll_Female",
	},
	Tauren = {
		Male = "Achievement_Character_Tauren_Male",
		Female = "Achievement_Character_Tauren_Female",
	},
	Worgen = {
		Male = "Ability_Racial_TwoForms",
		Female = "Ability_Racial_Viciousness",
	},
	Goblin = {
		Male = "Ability_Racial_RocketJump",
		Female = "Ability_Racial_RocketJump",
	},
	Pandaren = {
      Male = "Achievement_Guild_ClassyPanda",
      Female =  "Achievement_Character_Pandaren_Female",
    },
};
	
TRP2_textureSex = {
	"Neutre",
	"Male",
	"Female",
};

TRP2_QuestActionIconeTab = {
	"Ability_Warrior_Revenge",
	"Ability_Warrior_RallyingCry",
	"INV_Misc_Ear_Human_01",
	"INV_Gauntlets_41"
};

TRP2_QuestEtapeIconeTab = {
	"Achievement_BG_win_AB_X_Times",
	"Achievement_BG_killingblow_startingrock",
	"Achievement_BG_winWSG_3-0"
};

TRP2_ENTETE = "|TInterface\\AddOns\\totalRP2\\Images\\TRPlogo.tga:75:175|t\n \n";

TRP2_Saved_ChatFrame_OnEvent = nil;
TRP2_SavedFCF_OpenNewWindow = nil;
TRP2_SavedSendChatMessage = nil;

TRP2_DernierePhrase = nil;

-- TABLEAUX DE SYNCHRONISATION
TRP2_SynchronisedTab_InfoBase = {};
TRP2_SynchronisedTab_Actu = {};
TRP2_SynchronisedTab_Physique = {};
TRP2_SynchronisedTab_Psycho = {};
TRP2_SynchronisedTab_Histoire = {};
TRP2_SynchronisedTab_Caract = {};
TRP2_SynchronisedTab_InfoMinion = {};
TRP2_SynchronisedTab_InfoMount = {};
TRP2_SynchronisedTab_InfoPet = {};
-- TABLEAU DE SYNCHRONIZATION
TRP2_SynchronisedTab = {};
-- TABLEAUX DES CONNECTEs
TRP2_ConnectedUser = {};
-- TABLEAUX DE MAP
TRP2_PlayersPosition = {};
-- TABLEAUX DE LISTES 
TRP2_RegistreListeTab = {};
TRP2_JournalListeTab = {};
TRP2_GeneralListTab = {};
TRP2_SoundListTab = {};
TRP2_SoundFavListTab = {};
TRP2_PetsListeTab = {};
-- TABLEAUX LISTES CREATIONS 
TRP2_CreaListTabObjet = {};
TRP2_CreaListTabAura = {};
TRP2_CreaListTabLang = {};
TRP2_CreaListTabDocument = {};
TRP2_CreaListTabDocu = {};
TRP2_CreaListTabEvent = {};
-- TABLEAUX LISTES
TRP2_QuestsLogList = {};
TRP2_PlanqueList = {};
TRP2_PanneauList = {};

-- HOOKING
TRP2_Saved_ChatFrameEvent = nil;

TRP2_ReservedChar = '\1';
TRP2_IDSIZE = 18;

TRP2_compagnonPrefixe = {
	"Serviteur d",
	"Familier d",
	"Compagnon d",
	"Gardien d",
	"Mascotte d",
	"'s Pet",
	"'s Guardian",
	"'s Minion",
	"'s Companion",
	"Compañero de",
	"Esbirro de",
	"Guardián de",
	"Begleiter von",
	"Gefährte von",
	"Diener von",
	"Wächter von"
};

TRP2_IconeFaction = {
	["Alliance"] = "|TInterface\\BattlefieldFrame\\Battleground-Alliance:35:35|t",
	["Horde"] = "|TInterface\\BattlefieldFrame\\Battleground-Horde:35:35|t",
}

TRP2_IconeXP = {
	["1"] = "|TInterface\\ICONS\\INV_Misc_Toy_01:",
	["2"] = "|TInterface\\ICONS\\INV_Misc_Map_01:",
	["3"] = "|TInterface\\ICONS\\Achievement_BG_tophealer_EOS:",
}

function TRP2_GetZoneIcon(zoneNum)
	if TRP2_ZoneIcons[tostring(zoneNum)] then
		return TRP2_ZoneIcons[tostring(zoneNum)];
	end
	return "Temp";
end

TRP2_ZoneIcons = {
	["4"] = "Achievement_Zone_Durotar", -- Durotar
	["9"] = "Achievement_Zone_Mulgore_01", -- Mulgore
	["11"] = "Achievement_Zone_Barrens_01", -- Barrens
	["13"] = "Achievement_Zone_Kalimdor_01", -- Kalimdor
	["14"] = "Achievement_Zone_EasternKingdoms_01", -- Azeroth
	["15"] = "Achievement_Zone_AlteracMountains_01", -- Alterac
	["16"] = "Achievement_Zone_ArathiHighlands_01", -- Arathi
	["17"] = "Achievement_Zone_Badlands_01", -- Badlands
	["19"] = "Achievement_Zone_BlastedLands_01", -- BlastedLands
	["20"] = "Achievement_Zone_TirisfalGlades_01", -- Tirisfal
	["21"] = "Achievement_Zone_Silverpine_01", -- Silverpine
	["22"] = "Achievement_Zone_WesternPlaguelands_01", -- WesternPlaguelands
	["23"] = "Achievement_Zone_EasternPlaguelands", -- EasternPlaguelands
	["24"] = "Achievement_Zone_HillsbradFoothills", -- Hilsbrad
	["26"] = "Achievement_Zone_Hinterlands_01", -- Hinterlands
	["27"] = "Achievement_Zone_DunMorogh", -- DunMorogh
	["28"] = "Achievement_Zone_SearingGorge_01", -- SearingGorge
	["29"] = "Achievement_Zone_BurningSteppes_01", -- BurningSteppes
	["30"] = "Achievement_Zone_ElwynnForest", -- Elwynn
	["32"] = "Achievement_Zone_DeadwindPass", -- DeadwindPass
	["34"] = "Achievement_Zone_Duskwood", -- Duskwood
	["35"] = "Achievement_Zone_LochModan", -- LochModan
	["36"] = "Achievement_Zone_RedridgeMountains", -- Redridge
	["37"] = "Achievement_Zone_Sholazar_02", -- Stranglethorn
	["38"] = "Achievement_Zone_SwampSorrows_01", -- SwampOfSorrows
	["39"] = "Achievement_Zone_WestFall_01", -- Westfall
	["40"] = "Achievement_Zone_Wetlands_01", -- Wetlands
	["41"] = "Achievement_Zone_Darnassus", -- Teldrassil
	["42"] = "Achievement_Zone_Darkshore_01", -- Darkshore
	["43"] = "Achievement_Zone_Ashenvale_01", -- Ashenvale
	["61"] = "Achievement_Zone_ThousandNeedles_01", -- ThousandNeedles
	["81"] = "Achievement_Zone_Stonetalon_01", -- StonetalonMountains
	["101"] = "Achievement_Zone_Desolace", -- Desolace
	["121"] = "Achievement_Zone_Feralas", -- Feralas
	["141"] = "Achievement_Zone_DustwallowMarsh", -- Dustwallow
	["161"] = "Achievement_Zone_Tanaris_01", -- Tanaris
	["181"] = "Achievement_Zone_Azshara_01", -- Aszhara
	["182"] = "Achievement_Zone_Felwood", -- Felwood
	["201"] = "Achievement_Zone_UnGoroCrater_01", -- UngoroCrater
	["241"] = "SPELL_ARCANE_TELEPORTMOONGLADE", -- Moonglade
	["261"] = "Achievement_Zone_Silithus_01", -- Silithus
	["281"] = "Achievement_Zone_Winterspring", -- Winterspring
	["301"] = "PVPCurrency-Conquest-Alliance", -- Stormwind
	["321"] = "PVPCurrency-Conquest-Horde", -- Ogrimmar
	["341"] = "Achievement_Zone_Ironforge", -- Ironforge
	["362"] = "Spell_Arcane_TeleportThunderBluff", -- ThunderBluff
	["381"] = "Achievement_Zone_Darnassus", -- Darnassis
	["382"] = "Spell_Arcane_TeleportUnderCity", -- Undercity
	["401"] = "Achievement_Zone_AlteracMountains_01", -- AlteracValley
	["443"] = "Spell_Misc_WarsongFocus", -- WarsongGulch
	["461"] = "Achievement_Zone_ArathiHighlands_01", -- ArathiBasin
	["462"] = "Achievement_Zone_EversongWoods", -- EversongWoods
	["463"] = "Achievement_Zone_Ghostlands", -- Ghostlands
	["464"] = "Achievement_Zone_AzuremystIsle_01", -- AzuremystIsle
	["465"] = "Achievement_Zone_HellfirePeninsula_01", -- Hellfire
	["466"] = "Achievement_Zone_Outland_01", -- Outland
	["467"] = "Achievement_Zone_Zangarmarsh", -- Zangarmarsh
	["471"] = "Spell_Arcane_TeleportExodar", -- TheExodar
	["473"] = "Achievement_Zone_Shadowmoon", -- ShadowmoonValley
	["475"] = "Achievement_Zone_BladesEdgeMtns_01", -- BladesEdgeMountains
	["476"] = "Achievement_Zone_BloodmystIsle_01", -- BloodmystIsle
	["477"] = "Achievement_Zone_Nagrand_01", -- Nagrand
	["478"] = "Achievement_Zone_Terrokar", -- TerokkarForest
	["479"] = "Achievement_Zone_Netherstorm_01", -- Netherstorm
	["480"] = "Spell_Arcane_TeleportSilvermoon", -- SilvermoonCity
	["481"] = "Spell_Arcane_TeleportShattrath", -- ShattrathCity
	["482"] = "Achievement_Zone_Netherstorm_01", -- NetherstormArena
	["485"] = "Achievement_Zone_Northrend_01", -- Northrend
	["486"] = "Achievement_Zone_BoreanTundra_02", -- BoreanTundra
	["488"] = "Achievement_Zone_DragonBlight_02", -- Dragonblight
	["490"] = "Achievement_Zone_GrizzlyHills_01", -- GrizzlyHills
	["491"] = "Achievement_Zone_HowlingFjord_03", -- HowlingFjord
	["492"] = "Achievement_Zone_IceCrown_03", -- IcecrownGlacier
	["493"] = "Achievement_Zone_Sholazar_01", -- SholazarBasin
	["495"] = "Achievement_Zone_StormPeaks_01", -- TheStormPeaks
	["496"] = "Achievement_Zone_ZulDrak_01", -- ZulDrak
	["499"] = "INV_Offhand_Sunwell_D_01", -- Sunwell
	["501"] = "INV_EssenceOfWintergrasp", -- LakeWintergrasp
	["502"] = "INV_Misc_Token_ScarletCrusade", -- ScarletEnclave
	["504"] = "INV_Offhand_Dalaran_D_01", -- Dalaran
	["510"] = "Achievement_Zone_CrystalSong_04", -- CrystalsongForest
	["512"] = "INV_Misc_TabardPVP_02", -- StrandoftheAncients
	["520"] = "Achievement_Dungeon_Nexus70_25man", -- TheNexus
	["521"] = "Achievement_Dungeon_CoTStratholme_Normal", -- CoTStratholme
	["522"] = "Achievement_Dungeon_AzjolLowercity_Normal", -- Ahnkahet
	["523"] = "Achievement_Dungeon_UtgardeKeep", -- UtgardeKeep
	["524"] = "Achievement_Dungeon_UtgardeKeep", -- UtgardePinnacle
	["525"] = "Spell_Lightning_LightningBolt01", -- HallsofLightning
	["526"] = "Achievement_Dungeon_UlduarRaid_Misc_02", -- Ulduar77
	["527"] = "Achievement_Dungeon_NexusRaid_10man", -- TheEyeofEternity
	["528"] = "Achievement_Dungeon_Nexus70_25man", -- Nexus80
	["529"] = "Achievement_Dungeon_UlduarRaid_Misc_02", -- Ulduar
	["530"] = "Achievement_Dungeon_Gundrak_25man", -- Gundrak
	["531"] = "Ability_Mount_Drake_Twilight", -- TheObsidianSanctum
	["532"] = "Achievement_Dungeon_UlduarRaid_Misc_03", -- VaultofArchavon
	["533"] = "Achievement_Dungeon_AzjolLowercity_10man", -- AzjolNerub
	["534"] = "Achievement_Dungeon_Drak'Tharon_10man", -- DrakTharonKeep
	["535"] = "Achievement_Dungeon_Naxxramas_Normal", -- Naxxramas
	["536"] = "Achievement_Dungeon_TheVioletHold_Normal", -- VioletHold
	["540"] = "Spell_Misc_HellifrePVPCombatMorale", -- IsleofConquest
	["541"] = "Achievement_Zone_BoreanTundra_01", -- HrothgarsLanding
	["542"] = "INV_Misc_Token_ArgentDawn3", -- TheArgentColiseum
	["606"] = "Achievement_Zone_Mount Hyjal", -- RubySanctum
	["609"] = "inv_misc_rubysanctum1", -- RubySanctum
	["626"] = "Achievement_Win_TwinPeaks", -- TwinPeaks
	["680"] = "Spell_Fire_SelfDestruct", -- RagefireChasm
	["686"] = "INV_Misc_Head_Troll_02", -- ZulFarrak
	["687"] = "Achievement_Boss_Hakkar", -- TheTempleOfAtalHakkar
	["688"] = "Achievement_Boss_Bazil_Akumai", -- BlackfathomDeeps
	["690"] = "INV_Stone_WeightStone_06", -- Prison
	["691"] = "Inv_Misc_Tournaments_Symbol_Gnome", -- Gnomeregan
	["692"] = "Achievement_Dungeon_UlduarRaid_Titan_01", -- Uldaman
	["696"] = "Ability_Warlock_MoltenCore", -- MoltenCore
	["699"] = "Achievement_Reputation_Ogre", -- DireMaul
	["704"] = "Achievement_Zone_Blackrock_01", -- BlackrockDepths
	["717"] = "Achievement_Dungeon_AzjolLowercity_Heroic", -- RuinsofAhnQiraj
	["718"] = "Achievement_Dungeon_BlackwingDescent_RAID_Onyxia", -- OnyxiasLair
	["720"] = "Achievement_Zone_Uldum", -- Uldum
	["721"] = "Achievement_Zone_Blackrock_01", -- BlackrockSpire
	["736"] = "Achievement_Battleground_BattleForGilneas", -- BattleForGilneas
	["747"] = "Achievement_Dungeon_LostCity of Tolvir", -- LostCityOfTheTolvir
	["749"] = "Achievement_Boss_Mutanus_the_Devourer", -- WailingCaverns
	["750"] = "Achievement_Boss_PrincessTheradras", -- Maraudon
	["752"] = "Spell_Misc_HellifrePVPHonorHoldFavor", -- BardinHold
	["753"] = "Achievement_Dungeon_BlackrockCaverns", -- BlackrockCaverns
	["754"] = "Achievement_Dungeon_BlackwingDescent_RAID_Atramedes", -- BlackwingDescent
	["755"] = "Achievement_Dungeon_BlackwingDescent_RAID_Onyxia", -- BlackwingLair
	["756"] = "Achievement_Boss_EdwinVancleef", -- TheDeadmines
	["757"] = "Achievement_Dungeon_GrimBatol", -- GrimBatol
	["758"] = "Ability_Druid_TwilightsWrath", -- BastionOfTwilight
	["759"] = "Achievement_Dungeon_Halls of Origination", -- HallsOfOrigination
	["760"] = "Achievement_Boss_CharlgaRazorflank", -- RazorfenDowns
	["761"] = "Achievement_Boss_CharlgaRazorflank", -- RazorfenKraul
	["762"] = "INV_Misc_Token_ScarletCrusade", -- ScarletMonastery
	["763"] = "Achievement_Dungeon_PlagueWing", -- Scholomance
	["764"] = "Achievement_Win_Gilneas", -- ShadowfangKeep
	["765"] = "Achievement_Dungeon_CoTStratholme", -- Stratholme
	["766"] = "Achievement_Dungeon_AzjolLowercity_Heroic", -- AhnQiraj
	["767"] = "Achievement_Dungeon_Throne of the Tides", -- ThroneOfTheTides
	["768"] = "Achievement_Dungeon_Deepholm", -- the stone core
	["769"] = "Achievement_Dungeon_Skywall", -- TheVortexPinnacle
	["773"] = "Achievement_Dungeon_Skywall" -- Throne Four wind
}

TRP2_PetFamilyTab = {
	["Ver"] = "Ability_Hunter_Pet_Worm",
	["Loup"] = "Ability_Hunter_Pet_Wolf",
	["Tortue"] = "Ability_Hunter_Pet_Turtle",
	["Rhinocéros"] = "Ability_Hunter_Pet_Rhino",
	["Diablotin"] = "Spell_Shadow_SummonImp",
	["Marcheur du Vide"] = "Spell_Shadow_SummonVoidWalker",
	["Scorpide"] = "Ability_Hunter_Pet_Scorpid",
	["Oiseau de proie"] = "Ability_Hunter_Pet_Owl",
	["Goule"] = "Spell_Shadow_RaiseDead",
	["Crabe"] = "Ability_Hunter_Pet_Crab",
	["Ours"] = "Ability_Hunter_Pet_Bear",
	["Sanglier"] = "Ability_Hunter_Pet_Boar",
	["Chasseur corrompu"] = "Spell_Shadow_SummonFelhunter",
	["Araignée"] = "Ability_Hunter_Pet_Spider",
	["Félin"] = "Ability_Hunter_Pet_Cat",
	["Gorille"] = "Ability_Hunter_Pet_Gorilla",
	["Gangregarde"] = "Spell_Shadow_SummonFelGuard",
	["Haut-trotteur"] = "Ability_Hunter_Pet_TallStrider",
	["Ravageur"] = "Ability_Hunter_Pet_Ravager",
	["Phalène"] = "Ability_Hunter_Pet_Moth",
	["Succube"] = "Spell_Shadow_SummonSuccubus",
	["Esprit de bête"] = "Spell_Nature_SpiritWolf",
	["Chien du Magma"] = "Ability_Hunter_Pet_CoreHound",
	["Guêpe"] = "Ability_Hunter_Pet_Wasp",
	["Garde funeste"] = "Spell_Fire_FelPyroblast",
	["Faucon-dragon"] = "Ability_Hunter_Pet_DragonHawk",
	["Serpent des vents"] = "Ability_Hunter_Pet_WindSerpent",
	["Diablosaure"] = "Ability_Hunter_Pet_Devilsaur",
	["Crocilisque"] = "Ability_Hunter_Pet_Crocolisk",
	["Hyène"] = "Ability_Hunter_Pet_Hyena",
	["Traqueur dim."] = "Ability_Hunter_Pet_WarpStalker",
	["Elémentaire d'eau"] = "Spell_Frost_SummonWaterElemental_2",
	["Silithide"] = "Ability_Hunter_Pet_Silithid",
	["Serpent"] = "Ability_Hunter_SerpentSwiftness",
	["Chauve-souris"] = "Ability_Hunter_Pet_Bat",
	["Chimère"] = "Ability_Hunter_Pet_Chimera",
	["Renard"] = "inv_misc_foxkit",
	["Chien"] = "Ability_Mount_BlackDireWolf",
	["Singe"] = "Ability_Hunter_AspectOfTheMonkey",
	
	["Worm"] = "Ability_Hunter_Pet_Ver",
	["Wolf"] = "Ability_Hunter_Pet_Wolf",
	["Turtle"] = "Ability_Hunter_Pet_Turtle",
	["Rhino"] = "Ability_Hunter_Pet_Rhino",
	["Imp"] = "Spell_Shadow_SummonImp",
	["Voidwalker"] = "Spell_Shadow_SummonVoidWalker",
	["Scorpid"] = "Ability_Hunter_Pet_Scorpid",
	["Bird of Prey"] = "Ability_Hunter_Pet_Owl",
	["Raptor"] = "Ability_Hunter_Pet_Raptor",
	["Ghoul"] = "Spell_Shadow_RaiseDead",
	["Crab"] = "Ability_Hunter_Pet_Crab",
	["Bear"] = "Ability_Hunter_Pet_Bear",
	["Boar"] = "Ability_Hunter_Pet_Boar",
	["Felhunter"] = "Spell_Shadow_SummonFelhunter",
	["Spider"] = "Ability_Hunter_Pet_Spider",
	["Cat"] = "Ability_Hunter_Pet_Cat",
	["Gorilla"] = "Ability_Hunter_Pet_Gorilla",
	["Felguard"] = "Spell_Shadow_SummonFelGuard",
	["Tallstrider"] = "Ability_Hunter_Pet_TallStrider",
	["Ravager"] = "Ability_Hunter_Pet_Ravager",
	["Moth"] = "Ability_Hunter_Pet_Moth",
	["Succubus"] = "Spell_Shadow_SummonSuccubus",
	["Spirit Beast"] = "Spell_Nature_SpiritWolf",
	["Core Hound"] = "Ability_Hunter_Pet_CoreHound",
	["Wasp"] = "Ability_Hunter_Pet_Wasp",
	["Doomguard"] = "Spell_Fire_FelPyroblast",
	["Dragonhawk"] = "Ability_Hunter_Pet_DragonHawk",
	["Wind Serpent"] = "Ability_Hunter_Pet_WindSerpent",
	["Devilsaur"] = "Ability_Hunter_Pet_Devilsaur",
	["Crocolisk"] = "Ability_Hunter_Pet_Crocolisk",
	["Hyena"] = "Ability_Hunter_Pet_Hyena",
	["Warp Stalker"] = "Ability_Hunter_Pet_WarpStalker",
	["Silithid"] = "Ability_Hunter_Pet_Silithid",
	["Serpent"] = "Ability_Hunter_SerpentSwiftness",
	["Bat"] = "Ability_Hunter_Pet_Bat",
	["Chimaera"] = "Ability_Hunter_Pet_Chimera",
	["Water Elemental"] = "Spell_Frost_SummonWaterElemental_2",
	["Fox"] = "inv_misc_foxkit",
	["Dog"] = "Ability_Mount_BlackDireWolf",
	["Monkey"] = "Ability_Hunter_AspectOfTheMonkey",
	
	["Carrion Bird"] = "Spell_Shadow_CarrionSwarm",
	["Remote Control"] = "INV_Gizmo_02",
	["Sporebat"] = "Ability_Hunter_Pet_Sporebat",
	["Nether Ray"] = "Ability_Hunter_Pet_NetherRay",
}

TRP2_FoodIconTable = {
	["Viande"] = "INV_Misc_Food_Meat_Raw_04";
	["Poisson"] = "INV_Misc_Fish_09";
	["Fruit"] = "INV_Misc_Food_57";
	["Champignon"] = "INV_Mushroom_12";
	["Pain"] = "INV_MISC_FOOD_11";
	["Fromage"] = "INV_Misc_Food_07";
	["Meat"] = "INV_Misc_Food_Meat_Raw_04";
	["Fish"] = "INV_Misc_Fish_09";
	["Fruit"] = "INV_Misc_Food_57";
	["Fungus"] = "INV_Mushroom_12";
	["Bread"] = "INV_MISC_FOOD_11";
	["Cheese"] = "INV_Misc_Food_07";
};

TRP2_EFFETCHATTAB = {
	"SAY","EMOTE","YELL","GUILD","PARTY","PARTY_LEADER","RAID","RAID_LEADER","RAID_WARNING","BATTLEGROUND","BATTLEGROUND_LEADER"
}

TRP2_DIALBASETAB = {
	["Draenei"] = "Commun,Common,Lengua común,Gemeinsprache,Draeneï,Draenei";
	["Human"] = "Commun,Common,Lengua común,Gemeinsprache";
	["Gnome"] = "Commun,Common,Lengua común,Gemeinsprache,Gnome,Gnomish,Gnomótico,Gnomisch";
	["Dwarf"] = "Commun,Common,Lengua común,Gemeinsprache,Nain,Dwarvish,Enánico,Zwergisch";
	["NightElf"] = "Commun,Common,Lengua común,Gemeinsprache,Darnassien,Darnassian,Darnassiano,Darnassisch",
	["Worgen"] = "Commun,Common,Lengua común,Gemeinsprache",
	["Orc"] = "Orc,Orco,Orcish,Orcisch",
	["Scourge"] = "Orc,Orco,,Orcisch,Réprouvé,Orcish,Forsaken,Renegado,Gossensprache",
	["BloodElf"] = "Orc,Orco,Orcish,Orcisch,Thalassien,Thalassian,Thalassiano,Thalassisch",
	["Troll"] = "Orc,Orco,Orcish,Orcisch,Troll,Trol",
	["Tauren"] = "Orc,Orco,Orcish,Orcisch,Taurahe",
	["Goblin"] = "Orc,Orco,Orcish,Orcisch,Gobelin,Goblin",
	["Pandaren"] = "Commun,Common,Lengua común,Gemeinsprache,Orc,Orco,Orcish,Orcisch,Pandaren,Pandarisch";
};

TRP2_OriginelLang = {
	["Commun"] = true,
	--["Pandaren"] = true,
	--["Pandarisch"] = true,
	["Common"] = true,
	["Orc"] = true,
	["Orcish"] = true,
	["Lengua común"] = true,
	["Orco"] = true,
	["Gemeinsprache"] = true,
	["Orcisch"] = true,
}
