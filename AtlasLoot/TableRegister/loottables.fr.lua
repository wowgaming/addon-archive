--[[
loottables.fr.lua --- Traduction FR par KKram & Trasher
This file assigns a title to every loot table.  The primary use of this table
is in the search function, as when iterating through the loot tables there is no
inherant title to the loot table, given the origins of the mod as an Atlas plugin.

]]

--Invoke libraries
local BabbleFaction = AtlasLoot_GetLocaleLibBabble("LibBabble-Faction-3.0")

if (GetLocale() == "frFR") then

-----------------
--- Instances ---
-----------------

  --Keys
    AtlasLoot_TableNames["OldKeys"][1] = "Clés";
    AtlasLoot_TableNames["BCKeys"][1] = "Clés";
  --Blackrock Depths
    AtlasLoot_TableNames["BRDArena"][1] = "L'Arène";
    AtlasLoot_TableNames["BRDForgewright"][1] = "Monument de Franclorn Le Forgebusier";
    AtlasLoot_TableNames["BRDGuzzler"][1] = "Grim Guzzler";
    AtlasLoot_TableNames["BRDTomb"][1] = "Le Tombeau des Sept";
    AtlasLoot_TableNames["BRDBSPlans"][1] = "Plans du forgeron (BRD)";
  --The Black Temple
    AtlasLoot_TableNames["BTEssencofSouls"][1] = "Reliquaire des âmes";
    AtlasLoot_TableNames["BTPatterns"][1] = "Patrons/Plans du Temple Noir"; 
  --Blackwing Lair
    AtlasLoot_TableNames["BWLDraconicForDummies"][1] = "Draconic for Dummies Chapter VII";
  --Dire Maul East
    AtlasLoot_TableNames["DMBooks"][1] = "Livres (DM)";
  --HC: Shattered Halls
    AtlasLoot_TableNames["HCHallsExecutioner"][1] = "Bourreau de la Main brisée";
  --Karazhan
    AtlasLoot_TableNames["KaraCharredBoneFragment"][1] = "Fragment d'os carbonisé (Objet de quête)";
    AtlasLoot_TableNames["KaraNamed"][1] = "Les trois Bêtes";
    AtlasLoot_TableNames["KaraKeannaLog"][1] = "Journal de Keanna (Objet de quête)";
    AtlasLoot_TableNames["KaraOperaEvent"][1] = "Evénement: Opéra";
  --Molten Core
    AtlasLoot_TableNames["MCRANDOMBOSSDROPPS"][1] = "Butin aléatoire";
  --The Ruins of Ahn'Qiraj
    AtlasLoot_TableNames["AQ20Trash"][1] = "Trash Mobs (AQ20)";
    AtlasLoot_TableNames["AQ20ClassBooks"][1] =  "Livres de classe AQ";
    AtlasLoot_TableNames["AQEnchants"][1] = "Enchantements AQ";
  --Stratholme
    AtlasLoot_TableNames["STRATStratholmeCourier"][1] = "Messager de Stratholme";
    AtlasLoot_TableNames["STRATAtiesh"][1] = "Atiesh <Main de Sargeras>"; -- à vérifier
    AtlasLoot_TableNames["STRATBSPlansSerenity"][1] = "Plans: Sérénité";
    AtlasLoot_TableNames["STRATBSPlansCorruption"][1] = "Plans: Corruption";
  --Sunken Temple
    AtlasLoot_TableNames["STSpawnOfHakkar"][1] = "Rejeton d'Hakkar";
    AtlasLoot_TableNames["STTrollMinibosses"][1] = "Miniboss Trolls";
  --Temple of Ahn'Qiraj
    AtlasLoot_TableNames["AQ40Trash1"][1] = "Trash Mobs (AQ40)";
    AtlasLoot_TableNames["AQ40Trash2"][1] = "Trash Mobs (AQ40)";
    AtlasLoot_TableNames["AQOpening"][1] = "Evénement d'ouverture AQ";
  --TK: The Eye
    AtlasLoot_TableNames["TKEyeLegendaries"][1] = "Objets légendaires pour le combat de Kael'thas";
  --Uldaman
    AtlasLoot_TableNames["UldTabletofRyuneh"][1] = "Tablette de Ryun'eh";
    AtlasLoot_TableNames["UldTabletofWill"][1] = "Tablette de volonté";
    AtlasLoot_TableNames["UldShadowforgeCache"][1] = "Cachette d'Ombreforge";
  --Zul'Aman
    AtlasLoot_TableNames["ZATimedChest"][1] = "Coffre du parcours rapide";
  --Zul'Gurub
    AtlasLoot_TableNames["ZGMuddyChurningWaters"][1] = "Eaux troubles";
    AtlasLoot_TableNames["ZGShared"][1] = "Butin Partagé (ZG)";
    AtlasLoot_TableNames["ZGEnchants"][1] = "ZG Enchants";

------------------------
--- Misc Collections ---
------------------------

    AtlasLoot_TableNames["BlizzardCollectables1"][1] = "Blizzard Collections";
    AtlasLoot_TableNames["RareMounts1"][1] = "Montures rares - Original WoW";
    AtlasLoot_TableNames["RareMounts2"][1] = "Montures rares - The Burning Crusade";

--------------
--- Events ---
--------------

  --Abyssal Council
    AtlasLoot_TableNames["Templars"][1] = "Conseil abyssal - Templiers";
    AtlasLoot_TableNames["Dukes"][1] = "Conseil abyssal - Ducs";
    AtlasLoot_TableNames["HighCouncil"][1] = "Conseil abyssal - Haut Conseil";
  --Seasonal
    AtlasLoot_TableNames["LordAhune"][1] = "Lord Ahune";
    AtlasLoot_TableNames["Winterviel2"][1] = "Cadeaux de La fête du Voile d'hiver";
  --Skettis
    AtlasLoot_TableNames["SkettisTalonpriestIshaal"][1] = "Talonpriest Ishaal";
    AtlasLoot_TableNames["SkettisHazziksPackage"][1] = "Hazzik's Package";

--------------------
--- Rep Factions ---
--------------------

  --Argent Dawn
    AtlasLoot_TableNames["Argent1"][1] = BabbleFaction["Argent Dawn"]..": Insigne Main-Aube";
  --Exalted with Cenarion Expedition, The Sha'tar and The Aldor/Scryers
    AtlasLoot_TableNames["ShattrathFlasks1"][1] = "Shattrath Flasks";


end