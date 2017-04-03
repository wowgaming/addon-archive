--[[
loottables.en.lua
This file assigns a title to every loot table.  The primary use of this table
is in the search function, as when iterating through the loot tables there is no
inherant title to the loot table, given the origins of the mod as an Atlas plugin.
]]

-- Invoke libraries
local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");
local BabbleBoss = AtlasLoot_GetLocaleLibBabble("LibBabble-Boss-3.0")
local BabbleInventory = AtlasLoot_GetLocaleLibBabble("LibBabble-Inventory-3.0")
local BabbleFaction = AtlasLoot_GetLocaleLibBabble("LibBabble-Faction-3.0")
local BabbleZone = AtlasLoot_GetLocaleLibBabble("LibBabble-Zone-3.0")

-- Using alchemy skill to get localized rank
local JOURNEYMAN = select(2, GetSpellInfo(3101));
local EXPERT = select(2, GetSpellInfo(3464));
local ARTISAN = select(2, GetSpellInfo(11611));
local MASTER = select(2, GetSpellInfo(28596));

local ALCHEMY, APPRENTICE = GetSpellInfo(2259);
local BLACKSMITHING = GetSpellInfo(2018);
local ARMORSMITH = GetSpellInfo(9788);
local WEAPONSMITH = GetSpellInfo(9787);
local AXESMITH = GetSpellInfo(17041);
local HAMMERSMITH = GetSpellInfo(17040);
local SWORDSMITH = GetSpellInfo(17039);
local COOKING = GetSpellInfo(2550);
local ENCHANTING = GetSpellInfo(7411);
local ENGINEERING = GetSpellInfo(4036);
local GNOMISH = GetSpellInfo(20220);
local GOBLIN = GetSpellInfo(20221);
local FIRSTAID = GetSpellInfo(3273);
local FISHING = GetSpellInfo(63275);
local INSCRIPTION = GetSpellInfo(45357);
local JEWELCRAFTING = GetSpellInfo(25229);
local LEATHERWORKING = GetSpellInfo(2108);
local DRAGONSCALE = GetSpellInfo(10656);
local ELEMENTAL = GetSpellInfo(10658);
local TRIBAL = GetSpellInfo(10660);
local MINING = GetSpellInfo(2575);
local TAILORING = GetSpellInfo(3908);
local MOONCLOTH = GetSpellInfo(26798);
local SHADOWEAVE = GetSpellInfo(26801);
local SPELLFIRE = GetSpellInfo(26797);

-- Table of loot titles
if not AtlasLoot_TableNames then
    AtlasLoot_TableNames = {};
end

-----------------------
--- WotLK Instances ---
-----------------------

  -- Keys
	AtlasLoot_TableNames["WrathKeys"] = { "Keys", "AtlasLootWotLK" };
  -- Utgarde Keep
	AtlasLoot_TableNames["UtgardeKeepKeleseth"] = { BabbleBoss["Prince Keleseth"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["UtgardeKeepSkarvald"] = { BabbleBoss["Skarvald the Constructor"].." / "..BabbleBoss["Dalronn the Controller"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["UtgardeKeepIngvar"] = { BabbleBoss["Ingvar the Plunderer"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["UtgardeKeepTrash"] = { AL["Trash Mobs"], "AtlasLootWotLK" };
  -- The Nexus
	AtlasLoot_TableNames["TheNexusTelestra"] = { BabbleBoss["Grand Magus Telestra"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TheNexusAnomalus"] = { BabbleBoss["Anomalus"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TheNexusOrmorok"] = { BabbleBoss["Ormorok the Tree-Shaper"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TheNexusKolurgStoutbeardHEROIC"] = { BabbleBoss["Commander Kolurg"].." / "..BabbleBoss["Commander Stoutbeard"].." ("..AL["Heroic"]..")", "AtlasLootWotLK" };
	AtlasLoot_TableNames["TheNexusKeristrasza"] = { BabbleBoss["Keristrasza"], "AtlasLootWotLK" };
  -- Azjol-Nerub
	AtlasLoot_TableNames["AzjolNerubKrikthir"] = { BabbleBoss["Krik'thir the Gatewatcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["AzjolNerubHadronox"] = { BabbleBoss["Hadronox"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["AzjolNerubAnubarak"] = { BabbleBoss["Anub'arak"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["AzjolNerubTrash"] = { AL["Trash Mobs"], "AtlasLootWotLK" };
  -- Ahn'kahet: The Old Kingdom
	AtlasLoot_TableNames["AhnkahetNadox"] = { BabbleBoss["Elder Nadox"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["AhnkahetTaldaram"] = { BabbleBoss["Prince Taldaram"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["AhnkahetAmanitarHEROIC"] = { BabbleBoss["Amanitar"].." ("..AL["Heroic"]..")", "AtlasLootWotLK" };
	AtlasLoot_TableNames["AhnkahetJedoga"] = { BabbleBoss["Jedoga Shadowseeker"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["AhnkahetVolazj"] = { BabbleBoss["Herald Volazj"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["AhnkahetTrash"] = { AL["Trash Mobs"], "AtlasLootWotLK" };
  -- Drak'Tharon Keep
	AtlasLoot_TableNames["DrakTharonKeepTrollgore"] = { BabbleBoss["Trollgore"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["DrakTharonKeepNovos"] = { BabbleBoss["Novos the Summoner"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["DrakTharonKeepKingDred"] = { BabbleBoss["King Dred"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["DrakTharonKeepTharonja"] = { BabbleBoss["The Prophet Tharon'ja"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["DrakTharonKeepTrash"] = { AL["Trash Mobs"], "AtlasLootWotLK" };
  -- The Violet Hold
	AtlasLoot_TableNames["VioletHoldErekem"] = { BabbleBoss["Erekem"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VioletHoldZuramat"] = { BabbleBoss["Zuramat the Obliterator"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VioletHoldXevozz"] = { BabbleBoss["Xevozz"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VioletHoldIchoron"] = { BabbleBoss["Ichoron"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VioletHoldMoragg"] = { BabbleBoss["Moragg"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VioletHoldLavanthor"] = { BabbleBoss["Lavanthor"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VioletHoldCyanigosa"] = { BabbleBoss["Cyanigosa"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VioletHoldTrash"] = { AL["Trash Mobs"], "AtlasLootWotLK" };
  -- Gundrak
	AtlasLoot_TableNames["GundrakSladran"] = { BabbleBoss["Slad'ran"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["GundrakColossus"] = { BabbleBoss["Drakkari Colossus"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["GundrakMoorabi"] = { BabbleBoss["Moorabi"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["GundrakEckHEROIC"] = { BabbleBoss["Eck the Ferocious"].." ("..AL["Heroic"]..")", "AtlasLootWotLK" };
	AtlasLoot_TableNames["GundrakGaldarah"] = { BabbleBoss["Gal'darah"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["GundrakTrash"] = { AL["Trash Mobs"], "AtlasLootWotLK" };
  -- Halls of Stone
	AtlasLoot_TableNames["HallsofStoneMaiden"] = { BabbleBoss["Maiden of Grief"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["HallsofStoneKrystallus"] = { BabbleBoss["Krystallus"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["HallsofStoneTribunal"] = { BabbleBoss["The Tribunal of Ages"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["HallsofStoneSjonnir"] = { BabbleBoss["Sjonnir The Ironshaper"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["HallsofStoneTrash"] = { AL["Trash Mobs"], "AtlasLootWotLK" };
  -- Halls of Lightning
	AtlasLoot_TableNames["HallsofLightningBjarngrim"] = { BabbleBoss["General Bjarngrim"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["HallsofLightningVolkhan"] = { BabbleBoss["Volkhan"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["HallsofLightningIonar"] = { BabbleBoss["Ionar"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["HallsofLightningLoken"] = { BabbleBoss["Loken"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["HallsofLightningTrash"] = { AL["Trash Mobs"], "AtlasLootWotLK" };
  -- Caverns of Time: Old Stratholme
	AtlasLoot_TableNames["CoTStratholmeMeathook"] = { BabbleBoss["Meathook"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["CoTStratholmeSalramm"] = { BabbleBoss["Salramm the Fleshcrafter"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["CoTStratholmeEpoch"] = { BabbleBoss["Chrono-Lord Epoch"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["CoTStratholmeInfiniteCorruptorHEROIC"] = { BabbleBoss["Infinite Corruptor"].." ("..AL["Heroic"]..")", "AtlasLootWotLK" };
	AtlasLoot_TableNames["CoTStratholmeMalGanis"] = { BabbleBoss["Mal'Ganis"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["CoTStratholmeTrash"] = { AL["Trash Mobs"], "AtlasLootWotLK" };
  -- Utgarde Pinnacle
	AtlasLoot_TableNames["UPSkadi"] = { BabbleBoss["Skadi the Ruthless"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["UPYmiron"] = { BabbleBoss["King Ymiron"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["UPSorrowgrave"] = { BabbleBoss["Svala Sorrowgrave"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["UPPalehoof"] = { BabbleBoss["Gortok Palehoof"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["UPTrash"] = { AL["Trash Mobs"], "AtlasLootWotLK" };
  -- The Oculus
	AtlasLoot_TableNames["OcuDrakos"] = { BabbleBoss["Drakos the Interrogator"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["OcuUrom"] = { BabbleBoss["Mage-Lord Urom"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["OcuCloudstrider"] = { BabbleBoss["Varos Cloudstrider"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["OcuEregos"] = { BabbleBoss["Ley-Guardian Eregos"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["OcuTrash"] = { AL["Trash Mobs"], "AtlasLootWotLK" };
  -- Vault of Archavon
	AtlasLoot_TableNames["VaultofArchavonArchavon1"] = { BabbleBoss["Archavon the Stone Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonArchavon2"] = { BabbleBoss["Archavon the Stone Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonArchavon3"] = { BabbleBoss["Archavon the Stone Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonArchavon4"] = { BabbleBoss["Archavon the Stone Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonArchavon5"] = { BabbleBoss["Archavon the Stone Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonArchavon6"] = { BabbleBoss["Archavon the Stone Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonArchavon7"] = { BabbleBoss["Archavon the Stone Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonArchavon125Man"] = { BabbleBoss["Archavon the Stone Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonArchavon225Man"] = { BabbleBoss["Archavon the Stone Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonArchavon325Man"] = { BabbleBoss["Archavon the Stone Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonArchavon425Man"] = { BabbleBoss["Archavon the Stone Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonArchavon525Man"] = { BabbleBoss["Archavon the Stone Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonArchavon625Man"] = { BabbleBoss["Archavon the Stone Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonArchavon725Man"] = { BabbleBoss["Archavon the Stone Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonEmalon1"] = { BabbleBoss["Emalon the Storm Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonEmalon2"] = { BabbleBoss["Emalon the Storm Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonEmalon3"] = { BabbleBoss["Emalon the Storm Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonEmalon4"] = { BabbleBoss["Emalon the Storm Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonEmalon5"] = { BabbleBoss["Emalon the Storm Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonEmalon6"] = { BabbleBoss["Emalon the Storm Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonEmalon7"] = { BabbleBoss["Emalon the Storm Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonEmalon8"] = { BabbleBoss["Emalon the Storm Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonEmalon125Man"] = { BabbleBoss["Emalon the Storm Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonEmalon225Man"] = { BabbleBoss["Emalon the Storm Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonEmalon325Man"] = { BabbleBoss["Emalon the Storm Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonEmalon425Man"] = { BabbleBoss["Emalon the Storm Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonEmalon525Man"] = { BabbleBoss["Emalon the Storm Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonEmalon625Man"] = { BabbleBoss["Emalon the Storm Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonEmalon725Man"] = { BabbleBoss["Emalon the Storm Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonEmalon825Man"] = { BabbleBoss["Emalon the Storm Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonKoralon1_A"] = { BabbleBoss["Koralon the Flame Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonKoralon2_A"] = { BabbleBoss["Koralon the Flame Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonKoralon3_A"] = { BabbleBoss["Koralon the Flame Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonKoralon4_A"] = { BabbleBoss["Koralon the Flame Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonKoralon5_A"] = { BabbleBoss["Koralon the Flame Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonKoralon6_A"] = { BabbleBoss["Koralon the Flame Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonKoralon7_A"] = { BabbleBoss["Koralon the Flame Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonKoralon8_A"] = { BabbleBoss["Koralon the Flame Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonKoralon125Man_A"] = { BabbleBoss["Koralon the Flame Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonKoralon225Man_A"] = { BabbleBoss["Koralon the Flame Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonKoralon325Man_A"] = { BabbleBoss["Koralon the Flame Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonKoralon425Man_A"] = { BabbleBoss["Koralon the Flame Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonKoralon525Man_A"] = { BabbleBoss["Koralon the Flame Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonKoralon625Man_A"] = { BabbleBoss["Koralon the Flame Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonKoralon725Man_A"] = { BabbleBoss["Koralon the Flame Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonKoralon825Man_A"] = { BabbleBoss["Koralon the Flame Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonKoralon1_H"] = { BabbleBoss["Koralon the Flame Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonKoralon2_H"] = { BabbleBoss["Koralon the Flame Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonKoralon3_H"] = { BabbleBoss["Koralon the Flame Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonKoralon4_H"] = { BabbleBoss["Koralon the Flame Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonKoralon5_H"] = { BabbleBoss["Koralon the Flame Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonKoralon6_H"] = { BabbleBoss["Koralon the Flame Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonKoralon7_H"] = { BabbleBoss["Koralon the Flame Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonKoralon8_H"] = { BabbleBoss["Koralon the Flame Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonKoralon125Man_H"] = { BabbleBoss["Koralon the Flame Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonKoralon225Man_H"] = { BabbleBoss["Koralon the Flame Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonKoralon325Man_H"] = { BabbleBoss["Koralon the Flame Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonKoralon425Man_H"] = { BabbleBoss["Koralon the Flame Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonKoralon525Man_H"] = { BabbleBoss["Koralon the Flame Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonKoralon625Man_H"] = { BabbleBoss["Koralon the Flame Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonKoralon725Man_H"] = { BabbleBoss["Koralon the Flame Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonKoralon825Man_H"] = { BabbleBoss["Koralon the Flame Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonToravon1"] = { BabbleBoss["Toravon the Ice Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonToravon2"] = { BabbleBoss["Toravon the Ice Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonToravon3"] = { BabbleBoss["Toravon the Ice Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonToravon4"] = { BabbleBoss["Toravon the Ice Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonToravon5"] = { BabbleBoss["Toravon the Ice Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonToravon6"] = { BabbleBoss["Toravon the Ice Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonToravon7"] = { BabbleBoss["Toravon the Ice Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonToravon8"] = { BabbleBoss["Toravon the Ice Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonToravon125Man"] = { BabbleBoss["Toravon the Ice Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonToravon225Man"] = { BabbleBoss["Toravon the Ice Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonToravon325Man"] = { BabbleBoss["Toravon the Ice Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonToravon425Man"] = { BabbleBoss["Toravon the Ice Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonToravon525Man"] = { BabbleBoss["Toravon the Ice Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonToravon625Man"] = { BabbleBoss["Toravon the Ice Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonToravon725Man"] = { BabbleBoss["Toravon the Ice Watcher"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VaultofArchavonToravon825Man"] = { BabbleBoss["Toravon the Ice Watcher"], "AtlasLootWotLK" };
  -- Naxxramas Level 80
	AtlasLoot_TableNames["Naxx80Patchwerk"] = { BabbleBoss["Patchwerk"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Naxx80Patchwerk25Man"] = { BabbleBoss["Patchwerk"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Naxx80Grobbulus"] = { BabbleBoss["Grobbulus"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Naxx80Grobbulus25Man"] = { BabbleBoss["Grobbulus"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Naxx80Gluth1"] = { BabbleBoss["Gluth"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Naxx80Gluth2"] = { BabbleBoss["Gluth"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Naxx80Gluth125Man"] = { BabbleBoss["Gluth"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Naxx80Gluth225Man"] = { BabbleBoss["Gluth"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Naxx80Thaddius"] = { BabbleBoss["Thaddius"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Naxx80Thaddius25Man"] = { BabbleBoss["Thaddius"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Naxx80AnubRekhan"] = { BabbleBoss["Anub'Rekhan"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Naxx80AnubRekhan25Man"] = { BabbleBoss["Anub'Rekhan"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Naxx80Faerlina"] = { BabbleBoss["Grand Widow Faerlina"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Naxx80Faerlina25Man"] = { BabbleBoss["Grand Widow Faerlina"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Naxx80Maexxna"] = { BabbleBoss["Maexxna"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Naxx80Maexxna25Man"] = { BabbleBoss["Maexxna"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Naxx80Razuvious"] = { BabbleBoss["Instructor Razuvious"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Naxx80Razuvious25Man"] = { BabbleBoss["Instructor Razuvious"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Naxx80Gothik"] = { BabbleBoss["Gothik the Harvester"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Naxx80Gothik25Man"] = { BabbleBoss["Gothik the Harvester"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Naxx80FourHorsemen"] = { BabbleBoss["The Four Horsemen"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Naxx80FourHorsemen25Man"] = { BabbleBoss["The Four Horsemen"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Naxx80Noth"] = { BabbleBoss["Noth the Plaguebringer"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Naxx80Noth25Man"] = { BabbleBoss["Noth the Plaguebringer"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Naxx80Heigan"] = { BabbleBoss["Heigan the Unclean"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Naxx80Heigan25Man"] = { BabbleBoss["Heigan the Unclean"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Naxx80Loatheb"] = { BabbleBoss["Loatheb"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Naxx80Loatheb25Man"] = { BabbleBoss["Loatheb"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Naxx80Sapphiron"] = { BabbleBoss["Sapphiron"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Naxx80Sapphiron25Man"] = { BabbleBoss["Sapphiron"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Naxx80KelThuzad"] = { BabbleBoss["Kel'Thuzad"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Naxx80KelThuzad25Man"] = { BabbleBoss["Kel'Thuzad"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Naxx80Trash"] = { AL["Trash Mobs"].." ("..BabbleZone["Naxxramas"]..")", "AtlasLootWotLK" };
	AtlasLoot_TableNames["Naxx80Trash25Man"] = { AL["Trash Mobs"].." ("..BabbleZone["Naxxramas"]..")", "AtlasLootWotLK" };
  -- Obsidian Sanctum
	AtlasLoot_TableNames["Sartharion"] = { BabbleBoss["Sartharion"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Sartharion25Man"] = { BabbleBoss["Sartharion"], "AtlasLootWotLK" };
  -- The Eye of Eternity
	AtlasLoot_TableNames["Malygos"] = { BabbleBoss["Malygos"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Malygos25Man"] = { BabbleBoss["Malygos"], "AtlasLootWotLK" };
  -- Ulduar
	AtlasLoot_TableNames["UlduarLeviathan"] = { BabbleBoss["Flame Leviathan"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["UlduarLeviathan25Man"] = { BabbleBoss["Flame Leviathan"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["UlduarIgnis"] = { BabbleBoss["Ignis the Furnace Master"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["UlduarIgnis25Man"] = { BabbleBoss["Ignis the Furnace Master"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["UlduarRazorscale"] = { BabbleBoss["Razorscale"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["UlduarRazorscale25Man"] = { BabbleBoss["Razorscale"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["UlduarIronCouncil"] = { BabbleBoss["The Iron Council"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["UlduarIronCouncil25Man"] = { BabbleBoss["The Iron Council"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["UlduarDeconstructor"] = { BabbleBoss["XT-002 Deconstructor"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["UlduarDeconstructor25Man"] = { BabbleBoss["XT-002 Deconstructor"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["UlduarKologarn"] = { BabbleBoss["Kologarn"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["UlduarKologarn25Man"] = { BabbleBoss["Kologarn"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["UlduarAlgalon"] = { BabbleBoss["Algalon the Observer"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["UlduarAlgalon25Man"] = { BabbleBoss["Algalon the Observer"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["UlduarAuriaya"] = { BabbleBoss["Auriaya"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["UlduarAuriaya25Man"] = { BabbleBoss["Auriaya"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["UlduarHodir"] = { BabbleBoss["Hodir"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["UlduarHodir25Man"] = { BabbleBoss["Hodir"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["UlduarThorim"] = { BabbleBoss["Thorim"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["UlduarThorim25Man"] = { BabbleBoss["Thorim"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["UlduarFreya"] = { BabbleBoss["Freya"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["UlduarFreya25Man"] = { BabbleBoss["Freya"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["UlduarMimiron"] = { BabbleBoss["Mimiron"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["UlduarMimiron25Man"] = { BabbleBoss["Mimiron"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["UlduarVezax"] = { BabbleBoss["General Vezax"], "AtlasLootWotLK" };
 	AtlasLoot_TableNames["UlduarVezax25Man"] = { BabbleBoss["General Vezax"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["UlduarYoggSaron"] = { BabbleBoss["Yogg-Saron"], "AtlasLootWotLK" };
 	AtlasLoot_TableNames["UlduarYoggSaron25Man"] = { BabbleBoss["Yogg-Saron"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["UlduarPatterns"] = { AL["Ulduar Formula/Patterns/Plans"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["UlduarTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Ulduar"]..")", "AtlasLootWotLK" };
	AtlasLoot_TableNames["UlduarTrash25Man"] = { AL["Trash Mobs"].." ("..BabbleZone["Ulduar"]..")", "AtlasLootWotLK" };
  -- Trial of the Champion
	AtlasLoot_TableNames["TrialoftheChampionChampions"] = { AL["Faction Champions"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheChampionConfessorPaletress"] = { BabbleBoss["Argent Confessor Paletress"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheChampionEadricthePure"] = { BabbleBoss["Eadric the Pure"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheChampionBlackKnight"] = { BabbleBoss["The Black Knight"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheChampionBlackKnightHEROIC"] = { BabbleBoss["The Black Knight"].." ("..AL["Heroic"]..")", "AtlasLootWotLK" };
  -- Trial of the Crusader
	AtlasLoot_TableNames["TrialoftheCrusaderNorthrendBeasts_A"] = { BabbleBoss["The Beasts of Northrend"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderNorthrendBeasts_H"] = { BabbleBoss["The Beasts of Northrend"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderNorthrendBeasts25Man_A"] = { BabbleBoss["The Beasts of Northrend"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderNorthrendBeasts25Man_H"] = { BabbleBoss["The Beasts of Northrend"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderLordJaraxxus_A"] = { BabbleBoss["Lord Jaraxxus"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderLordJaraxxus_H"] = { BabbleBoss["Lord Jaraxxus"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderLordJaraxxus25Man_A"] = { BabbleBoss["Lord Jaraxxus"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderLordJaraxxus25Man_H"] = { BabbleBoss["Lord Jaraxxus"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderFactionChampions_A"] = { AL["Faction Champions"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderFactionChampions_H"] = { AL["Faction Champions"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderFactionChampions25Man_A"] = { AL["Faction Champions"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderFactionChampions25Man_H"] = { AL["Faction Champions"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderTwinValkyrs_A"] = { BabbleBoss["The Twin Val'kyr"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderTwinValkyrs_H"] = { BabbleBoss["The Twin Val'kyr"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderTwinValkyrs25Man_A"] = { BabbleBoss["The Twin Val'kyr"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderTwinValkyrs25Man_H"] = { BabbleBoss["The Twin Val'kyr"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderAnubarak_A"] = { BabbleBoss["Anub'arak"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderAnubarak_H"] = { BabbleBoss["Anub'arak"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderAnubarak25Man_A"] = { BabbleBoss["Anub'arak"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderAnubarak25Man_H"] = { BabbleBoss["Anub'arak"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderPatterns_A"] = { AL["Trial of the Crusader Patterns/Plans"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderPatterns_H"] = { AL["Trial of the Crusader Patterns/Plans"], "AtlasLootWotLK" };
  -- Trial of the Grand Crusader
	AtlasLoot_TableNames["TrialoftheCrusaderNorthrendBeastsHEROIC_A"] = { BabbleBoss["The Beasts of Northrend"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderNorthrendBeastsHEROIC_H"] = { BabbleBoss["The Beasts of Northrend"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderNorthrendBeasts25ManHEROIC_A"] = { BabbleBoss["The Beasts of Northrend"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderNorthrendBeasts25ManHEROIC_H"] = { BabbleBoss["The Beasts of Northrend"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderLordJaraxxusHEROIC_A"] = { BabbleBoss["Lord Jaraxxus"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderLordJaraxxusHEROIC_H"] = { BabbleBoss["Lord Jaraxxus"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderLordJaraxxus25ManHEROIC_A"] = { BabbleBoss["Lord Jaraxxus"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderLordJaraxxus25ManHEROIC_H"] = { BabbleBoss["Lord Jaraxxus"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderFactionChampionsHEROIC_A"] = { AL["Faction Champions"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderFactionChampionsHEROIC_H"] = { AL["Faction Champions"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderFactionChampions25ManHEROIC_A"] = { AL["Faction Champions"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderFactionChampions25ManHEROIC_H"] = { AL["Faction Champions"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderTwinValkyrsHEROIC_A"] = { BabbleBoss["The Twin Val'kyr"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderTwinValkyrsHEROIC_H"] = { BabbleBoss["The Twin Val'kyr"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderTwinValkyrs25ManHEROIC_A"] = { BabbleBoss["The Twin Val'kyr"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderTwinValkyrs25ManHEROIC_H"] = { BabbleBoss["The Twin Val'kyr"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderAnubarakHEROIC_A"] = { BabbleBoss["Anub'arak"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderAnubarakHEROIC_H"] = { BabbleBoss["Anub'arak"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderAnubarak25ManHEROIC_A"] = { BabbleBoss["Anub'arak"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderAnubarak25ManHEROIC_H"] = { BabbleBoss["Anub'arak"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderTributeHEROIC_A"] = { AL["Tribute Run"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderTributeHEROIC_H"] = { AL["Tribute Run"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderTribute25ManHEROIC_A"] = { AL["Tribute Run"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TrialoftheCrusaderTribute25ManHEROIC_H"] = { AL["Tribute Run"], "AtlasLootWotLK" };
  -- Onyxia (Level 80)
	AtlasLoot_TableNames["Onyxia_1"] = { BabbleBoss["Onyxia"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Onyxia_2"] = { BabbleBoss["Onyxia"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Onyxia_125Man"] = { BabbleBoss["Onyxia"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Onyxia_225Man"] = { BabbleBoss["Onyxia"], "AtlasLootWotLK" };
  -- The Forge of Souls
	AtlasLoot_TableNames["FoSBronjahm"] = { BabbleBoss["Bronjahm"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["FoSDevourer"] = { BabbleBoss["Devourer of Souls"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["FoSDevourerHEROIC"] = { BabbleBoss["Devourer of Souls"], "AtlasLootWotLK" };
  -- Pit of Saron
	AtlasLoot_TableNames["PoSGarfrost"] = { BabbleBoss["Forgemaster Garfrost"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PoSKrickIck"] = { AL["Krick and Ick"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PoSTyrannus"] = { BabbleBoss["Scourgelord Tyrannus"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PoSTyrannusHEROIC"] = { BabbleBoss["Scourgelord Tyrannus"], "AtlasLootWotLK" };
  -- Halls of Reflection
	AtlasLoot_TableNames["HoRFalric"] = { BabbleBoss["Falric"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["HoRMarwyn"] = { BabbleBoss["Marwyn"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["HoRLichKing"] = { BabbleBoss["The Lich King"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["HoRLichKingHEROIC"] = { BabbleBoss["The Lich King"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["FHTrashMobs"] = { AL["Trash Mobs"].." ("..BabbleZone["The Frozen Halls"]..")", "AtlasLootWotLK" };
  -- Icecrown Citadel
	AtlasLoot_TableNames["ICCLordMarrowgar"] = { BabbleBoss["Lord Marrowgar"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCLordMarrowgar25Man"] = { BabbleBoss["Lord Marrowgar"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCLadyDeathwhisper"] = { BabbleBoss["Lady Deathwhisper"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCLadyDeathwhisper25Man"] = { BabbleBoss["Lady Deathwhisper"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCGunshipBattle"] = { BabbleBoss["Icecrown Gunship Battle"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCGunshipBattle25Man"] = { BabbleBoss["Icecrown Gunship Battle"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCSaurfang"] = { BabbleBoss["Deathbringer Saurfang"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCSaurfang25Man"] = { BabbleBoss["Deathbringer Saurfang"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCFestergut"] = { BabbleBoss["Festergut"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCFestergut25Man"] = { BabbleBoss["Festergut"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCRotface"] = { BabbleBoss["Rotface"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCRotface25Man"] = { BabbleBoss["Rotface"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCPutricide"] = { BabbleBoss["Professor Putricide"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCPutricide25Man"] = { BabbleBoss["Professor Putricide"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCCouncil"] = { BabbleBoss["Blood Prince Council"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCCouncil25Man"] = { BabbleBoss["Blood Prince Council"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCLanathel"] = { BabbleBoss["Blood-Queen Lana'thel"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCLanathel25Man"] = { BabbleBoss["Blood-Queen Lana'thel"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCValithria"] = { BabbleBoss["Valithria Dreamwalker"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCValithria25Man"] = { BabbleBoss["Valithria Dreamwalker"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCSindragosa"] = { BabbleBoss["Sindragosa"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCSindragosa25Man"] = { BabbleBoss["Sindragosa"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCLichKing"] = { BabbleBoss["The Lich King"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCLichKing25Man"] = { BabbleBoss["The Lich King"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCTrash25Man"] = { AL["Trash Mobs"].." ("..BabbleZone["Icecrown Citadel"]..")", "AtlasLootWotLK" };
  -- Icecrown Citadel HEROIC
	AtlasLoot_TableNames["ICCLordMarrowgarHEROIC"] = { BabbleBoss["Lord Marrowgar"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCLordMarrowgar25ManHEROIC"] = { BabbleBoss["Lord Marrowgar"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCLadyDeathwhisperHEROIC"] = { BabbleBoss["Lady Deathwhisper"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCLadyDeathwhisper25ManHEROIC"] = { BabbleBoss["Lady Deathwhisper"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCGunshipBattleHEROIC"] = { BabbleBoss["Icecrown Gunship Battle"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCGunshipBattle25ManHEROIC"] = { BabbleBoss["Icecrown Gunship Battle"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCSaurfangHEROIC"] = { BabbleBoss["Deathbringer Saurfang"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCSaurfang25ManHEROIC"] = { BabbleBoss["Deathbringer Saurfang"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCFestergutHEROIC"] = { BabbleBoss["Festergut"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCFestergut25ManHEROIC"] = { BabbleBoss["Festergut"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCRotfaceHEROIC"] = { BabbleBoss["Rotface"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCRotface25ManHEROIC"] = { BabbleBoss["Rotface"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCPutricideHEROIC"] = { BabbleBoss["Professor Putricide"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCPutricide25ManHEROIC"] = { BabbleBoss["Professor Putricide"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCCouncilHEROIC"] = { BabbleBoss["Blood Prince Council"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCCouncil25ManHEROIC"] = { BabbleBoss["Blood Prince Council"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCLanathelHEROIC"] = { BabbleBoss["Blood-Queen Lana'thel"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCLanathel25ManHEROIC"] = { BabbleBoss["Blood-Queen Lana'thel"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCValithriaHEROIC"] = { BabbleBoss["Valithria Dreamwalker"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCValithria25ManHEROIC"] = { BabbleBoss["Valithria Dreamwalker"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCSindragosaHEROIC"] = { BabbleBoss["Sindragosa"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCSindragosa25ManHEROIC"] = { BabbleBoss["Sindragosa"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCLichKingHEROIC"] = { BabbleBoss["The Lich King"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["ICCLichKing25ManHEROIC"] = { BabbleBoss["The Lich King"], "AtlasLootWotLK" };
  -- Ruby Sanctum
  	AtlasLoot_TableNames["Halion"] = { BabbleBoss["Halion"], "AtlasLootWotLK" };
  	AtlasLoot_TableNames["HalionHEROIC"] = { BabbleBoss["Halion"], "AtlasLootWotLK" };
  	AtlasLoot_TableNames["Halion25Man"] = { BabbleBoss["Halion"], "AtlasLootWotLK" };
  	AtlasLoot_TableNames["Halion25ManHEROIC"] = { BabbleBoss["Halion"], "AtlasLootWotLK" };

--------------------
--- BC Instances ---
--------------------

  -- Keys
	AtlasLoot_TableNames["BCKeys"] = { "Keys", "AtlasLootBurningCrusade" };
  -- Auch: Auchenai Crypts
	AtlasLoot_TableNames["AuchCryptsShirrak"] = { BabbleBoss["Shirrak the Dead Watcher"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["AuchCryptsExarch"] = { BabbleBoss["Exarch Maladaar"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["AuchCryptsAvatar"] = { AL["Avatar of the Martyred"], "AtlasLootBurningCrusade" };
  -- Auch: Mana-Tombs
	AtlasLoot_TableNames["AuchManaPandemonius"] = { BabbleBoss["Pandemonius"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["AuchManaTavarok"] = { BabbleBoss["Tavarok"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["AuchManaNexusPrince"] = { BabbleBoss["Nexus-Prince Shaffar"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["AuchManaNexusPrinceHEROIC"] = { BabbleBoss["Nexus-Prince Shaffar"].." ("..AL["Heroic"]..")", "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["AuchManaYor"] = { AL["Yor"].." ("..AL["Heroic"]..")", "AtlasLootBurningCrusade" };
  -- Auch: Sethekk Halls
	AtlasLoot_TableNames["AuchSethekkDarkweaver"] = { BabbleBoss["Darkweaver Syth"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["AuchSethekkRavenGod"] = { BabbleBoss["Anzu"].." ("..AL["Heroic"]..")", "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["AuchSethekkTalonKing"] = { BabbleBoss["Talon King Ikiss"], "AtlasLootBurningCrusade" };
  -- Auch: Shadow Labyrinth
	AtlasLoot_TableNames["AuchShadowHellmaw"] = { BabbleBoss["Ambassador Hellmaw"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["AuchShadowBlackheart"] = { BabbleBoss["Blackheart the Inciter"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["AuchShadowGrandmaster"] = { BabbleBoss["Grandmaster Vorpil"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["AuchShadowMurmur"] = { BabbleBoss["Murmur"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["AuchTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Auchindoun"]..")", "AtlasLootBurningCrusade" };
  -- The Black Temple
	AtlasLoot_TableNames["BTNajentus"] = { BabbleBoss["High Warlord Naj'entus"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["BTSupremus"] = { BabbleBoss["Supremus"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["BTGorefiend"] = { BabbleBoss["Teron Gorefiend"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["BTBloodboil"] = { BabbleBoss["Gurtogg Bloodboil"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["BTAkama"] = { BabbleBoss["Shade of Akama"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["BTEssencofSouls"] = { "Essence of Souls", "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["BTShahraz"] = { BabbleBoss["Mother Shahraz"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["BTCouncil"] = { BabbleBoss["The Illidari Council"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["BTIllidanStormrage"] = { BabbleBoss["Illidan Stormrage"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["BTTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Black Temple"]..")", "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["BTPatterns"] = { "BT Patterns/Plans", "AtlasLootBurningCrusade" };
  -- CFR: Serpentshrine Cavern
	AtlasLoot_TableNames["CFRSerpentHydross"] = { BabbleBoss["Hydross the Unstable"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["CFRSerpentKarathress"] = { BabbleBoss["Fathom-Lord Karathress"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["CFRSerpentMorogrim"] = { BabbleBoss["Morogrim Tidewalker"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["CFRSerpentLeotheras"] = { BabbleBoss["Leotheras the Blind"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["CFRSerpentLurker"] = { BabbleBoss["The Lurker Below"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["CFRSerpentVashj"] = { BabbleBoss["Lady Vashj"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["CFRSerpentTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Serpentshrine Cavern"]..")", "AtlasLootBurningCrusade" };
  -- CFR: Slave Pens
	AtlasLoot_TableNames["CFRSlaveMennu"] = { BabbleBoss["Mennu the Betrayer"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["CFRSlaveRokmar"] = { BabbleBoss["Rokmar the Crackler"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["CFRSlaveQuagmirran"] = { BabbleBoss["Quagmirran"], "AtlasLootBurningCrusade" };
  -- CFR: The Steamvault
	AtlasLoot_TableNames["CFRSteamThespia"] = { BabbleBoss["Hydromancer Thespia"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["CFRSteamSteamrigger"] = { BabbleBoss["Mekgineer Steamrigger"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["CFRSteamWarlord"] = { BabbleBoss["Warlord Kalithresh"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["CFRSteamTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["The Steamvault"]..")", "AtlasLootBurningCrusade" };
  -- CFR: The Underbog
	AtlasLoot_TableNames["CFRUnderHungarfen"] = { BabbleBoss["Hungarfen"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["CFRUnderGhazan"] = { BabbleBoss["Ghaz'an"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["CFRUnderSwamplord"] = { BabbleBoss["Swamplord Musel'ek"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["CFRUnderStalker"] = { BabbleBoss["The Black Stalker"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["CFRUnderStalkerHEROIC"] = { BabbleBoss["The Black Stalker"].." ("..AL["Heroic"]..")", "AtlasLootBurningCrusade" };
  -- CoT: Old Hillsbrad Foothills
	AtlasLoot_TableNames["CoTHillsbradDrake"] = { BabbleBoss["Lieutenant Drake"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["CoTHillsbradSkarloc"] = { BabbleBoss["Captain Skarloc"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["CoTHillsbradHunter"] = { BabbleBoss["Epoch Hunter"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["CoTHillsbradHunterHEROIC"] = { BabbleBoss["Epoch Hunter"].." ("..AL["Heroic"]..")", "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["CoTTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Caverns of Time"]..")", "AtlasLootBurningCrusade" };
  -- CoT: Black Morass
	AtlasLoot_TableNames["CoTMorassDeja"] = { BabbleBoss["Chrono Lord Deja"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["CoTMorassTemporus"] = { BabbleBoss["Temporus"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["CoTMorassAeonus"] = { BabbleBoss["Aeonus"], "AtlasLootBurningCrusade" };
  -- CoT: Hyjal Summit
	AtlasLoot_TableNames["MountHyjalWinterchill"] = { BabbleBoss["Rage Winterchill"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["MountHyjalAnetheron"] = { BabbleBoss["Anetheron"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["MountHyjalKazrogal"] = { BabbleBoss["Kaz'rogal"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["MountHyjalAzgalor"] = { BabbleBoss["Azgalor"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["MountHyjalArchimonde"] = { BabbleBoss["Archimonde"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["MountHyjalTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Hyjal Summit"]..")", "AtlasLootBurningCrusade" };
  -- Gruul's Lair
	AtlasLoot_TableNames["GruulsLairHighKingMaulgar"] = { BabbleBoss["High King Maulgar"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["GruulGruul"] = { BabbleBoss["Gruul the Dragonkiller"], "AtlasLootBurningCrusade" };
  -- HC: Blood Furnace
	AtlasLoot_TableNames["HCFurnaceMaker"] = { BabbleBoss["The Maker"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["HCFurnaceBroggok"] = { BabbleBoss["Broggok"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["HCFurnaceBreaker"] = { BabbleBoss["Keli'dan the Breaker"], "AtlasLootBurningCrusade" };
  -- HC: Magtheridon's Lair
	AtlasLoot_TableNames["HCMagtheridon"] = { BabbleBoss["Magtheridon"], "AtlasLootBurningCrusade" };
  -- HC: Ramparts
	AtlasLoot_TableNames["HCRampWatchkeeper"] = { BabbleBoss["Watchkeeper Gargolmar"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["HCRampOmor"] = { BabbleBoss["Omor the Unscarred"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["HCRampVazruden"] = { BabbleBoss["Vazruden"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["HCRampVazrudenHEROIC"] = { BabbleBoss["Vazruden"].." ("..AL["Heroic"]..")", "AtlasLootBurningCrusade" };
  -- HC: Shattered Halls
	AtlasLoot_TableNames["HCHallsNethekurse"] = { BabbleBoss["Grand Warlock Nethekurse"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["HCHallsPorung"] = { BabbleBoss["Blood Guard Porung"].." ("..AL["Heroic"]..")", "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["HCHallsOmrogg"] = { BabbleBoss["Warbringer O'mrogg"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["HCHallsKargath"] = { BabbleBoss["Warchief Kargath Bladefist"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["HCHallsTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["The Shattered Halls"]..")", "AtlasLootBurningCrusade" };
  -- Karazhan
	AtlasLoot_TableNames["KaraCharredBoneFragment"] = { "Charred Bone Fragment ("..AL["Quest Item"]..")", "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["KaraNamed"] = { "Servant's Quarter Animal Bosses", "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["KaraAttumen"] = { BabbleBoss["Attumen the Huntsman"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["KaraMoroes"] = { BabbleBoss["Moroes"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["KaraKeannaLog"] = { "Keanna's Log ("..AL["Quest Item"]..")", "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["KaraMaiden"] = { BabbleBoss["Maiden of Virtue"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["KaraOperaEvent"] = { "Opera Event", "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["KaraCurator"] = { BabbleBoss["The Curator"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["KaraIllhoof"] = { BabbleBoss["Terestian Illhoof"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["KaraAran"] = { BabbleBoss["Shade of Aran"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["KaraNetherspite"] = { BabbleBoss["Netherspite"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["KaraNightbane"] = { BabbleBoss["Nightbane"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["KaraChess"] = { BabbleBoss["Chess Event"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["KaraPrince"] = { BabbleBoss["Prince Malchezaar"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["KaraTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Karazhan"]..")", "AtlasLootBurningCrusade" };
  -- Sunwell Isle: Magister's Terrace
	AtlasLoot_TableNames["SMTFireheart"] = { BabbleBoss["Selin Fireheart"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["SMTVexallus"] = { BabbleBoss["Vexallus"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["SMTDelrissa"] = { BabbleBoss["Priestess Delrissa"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["SMTKaelthas"] = { BabbleBoss["Kael'thas Sunstrider"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["SMTKaelthasHEROIC"] = { BabbleBoss["Kael'thas Sunstrider"].." ("..AL["Heroic"]..")", "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["SMTTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Magisters' Terrace"]..")", "AtlasLootBurningCrusade" };
  -- Sunwell Isle: Sunwell Plateau
	AtlasLoot_TableNames["SPKalecgos"] = { BabbleBoss["Kalecgos"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["SPBrutallus"] = { BabbleBoss["Brutallus"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["SPFelmyst"] = { BabbleBoss["Felmyst"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["SPEredarTwins"] = { BabbleBoss["The Eredar Twins"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["SPMuru"] = { BabbleBoss["M'uru"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["SPKiljaeden"] = { BabbleBoss["Kil'jaeden"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["SPTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Sunwell Plateau"]..")", "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["SPPatterns"] = { "SP Patterns/Plans", "AtlasLootBurningCrusade" };
  -- TK: The Arcatraz
	AtlasLoot_TableNames["TKArcUnbound"] = { BabbleBoss["Zereketh the Unbound"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["TKArcDalliah"] = { BabbleBoss["Dalliah the Doomsayer"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["TKArcScryer"] = { BabbleBoss["Wrath-Scryer Soccothrates"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["TKArcHarbinger"] = { BabbleBoss["Harbinger Skyriss"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["TKTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Tempest Keep"]..")", "AtlasLootBurningCrusade" };
  -- TK: The Botanica
	AtlasLoot_TableNames["TKBotSarannis"] = { BabbleBoss["Commander Sarannis"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["TKBotFreywinn"] = { BabbleBoss["High Botanist Freywinn"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["TKBotThorngrin"] = { BabbleBoss["Thorngrin the Tender"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["TKBotLaj"] = { BabbleBoss["Laj"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["TKBotSplinter"] = { BabbleBoss["Warp Splinter"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["TKBotSplinterHEROIC"] = { BabbleBoss["Warp Splinter"].." ("..AL["Heroic"]..")", "AtlasLootBurningCrusade" };
  -- TK: The Eye
	AtlasLoot_TableNames["TKEyeAlar"] = { BabbleBoss["Al'ar"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["TKEyeVoidReaver"] = { BabbleBoss["Void Reaver"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["TKEyeSolarian"] = { BabbleBoss["High Astromancer Solarian"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["TKEyeKaelthas"] = { BabbleBoss["Kael'thas Sunstrider"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["TKEyeLegendaries"] = { "Legendary Items for Kael'thas Fight", "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["TKEyeTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["The Eye"]..")", "AtlasLootExpansionItems" };
  -- TK: The Mechanar
	AtlasLoot_TableNames["TKMechCacheoftheLegion"] = { AL["Cache of the Legion"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["TKMechCapacitus"] = { BabbleBoss["Mechano-Lord Capacitus"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["TKMechSepethrea"] = { BabbleBoss["Nethermancer Sepethrea"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["TKMechCalc"] = { BabbleBoss["Pathaleon the Calculator"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["TKMechCalcHEROIC"] = { BabbleBoss["Pathaleon the Calculator"].." ("..AL["Heroic"]..")", "AtlasLootBurningCrusade" };
  -- Zul'Aman
	AtlasLoot_TableNames["ZANalorakk"] = { BabbleBoss["Nalorakk"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["ZAAkilZon"] = { BabbleBoss["Akil'zon"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["ZAJanAlai"] = { BabbleBoss["Jan'alai"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["ZAHalazzi"] = { BabbleBoss["Halazzi"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["ZAMalacrass"] = { BabbleBoss["Hex Lord Malacrass"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["ZAZuljin"] = { BabbleBoss["Zul'jin"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["ZATimedChest"] = { "Timed Reward Chest", "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["ZATrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Zul'Aman"]..")", "AtlasLootBurningCrusade" };

-------------------------
--- Classic Instances ---
-------------------------

  -- Keys
	AtlasLoot_TableNames["OldKeys"] = { "Keys", "AtlasLootOriginalWoW" };
  -- Blackfathom Deeps
	AtlasLoot_TableNames["BlackfathomDeeps1"] = { BabbleZone["Blackfathom Deeps"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["BlackfathomDeeps2"] = { BabbleZone["Blackfathom Deeps"], "AtlasLootOriginalWoW" };
  -- Blackrock Mountain
	AtlasLoot_TableNames["BRMScarshieldQuartermaster"] = { AL["Scarshield Quartermaster"], "AtlasLootOriginalWoW" };
  -- Blackrock Depths
	AtlasLoot_TableNames["BRDPyron"] = { AL["Overmaster Pyron"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["BRDLordRoccor"] = { BabbleBoss["Lord Roccor"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["BRDHighInterrogatorGerstahn"] = { BabbleBoss["High Interrogator Gerstahn"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["BRDArena"] = { "Ring of Law", "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["BRDTheldren"] = { AL["Theldren"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["BRDHoundmaster"] = { BabbleBoss["Houndmaster Grebmar"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["BRDForgewright"] = { "Monument of Franclorn Forgewright", "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["BRDPyromantLoregrain"] = { BabbleBoss["Pyromancer Loregrain"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["BRDTheVault"] = { AL["The Vault"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["BRDWarderStilgiss"] = { BabbleBoss["Warder Stilgiss"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["BRDVerek"] = { BabbleBoss["Verek"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["BRDFineousDarkvire"] = { BabbleBoss["Fineous Darkvire"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["BRDLordIncendius"] = { BabbleBoss["Lord Incendius"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["BRDBaelGar"] = { BabbleBoss["Bael'Gar"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["BRDGeneralAngerforge"] = { BabbleBoss["General Angerforge"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["BRDGolemLordArgelmach"] = { BabbleBoss["Golem Lord Argelmach"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["BRDGuzzler"] = { "The Grim Guzzler", "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["BRDFlamelash"] = { BabbleBoss["Ambassador Flamelash"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["BRDPanzor"] = { BabbleBoss["Panzor the Invincible"].." ("..AL["Rare"]..")", "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["BRDTomb"] = { "Summoner's Tomb", "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["BRDLyceum"] = { AL["Shadowforge Flame Keeper"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["BRDMagmus"] = { BabbleBoss["Magmus"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["BRDPrincess"] = { BabbleBoss["Princess Moira Bronzebeard"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["BRDImperatorDagranThaurissan"] = { BabbleBoss["Emperor Dagran Thaurissan"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["BRDBSPlans"] = { "Blacksmith Plans".." ("..BabbleZone["Blackrock Depths"]..")", "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["BRDTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Blackrock Depths"]..")", "AtlasLootOriginalWoW" };
  -- Lower Blackrock Spire
	AtlasLoot_TableNames["LBRSQuestItems"] = { BabbleZone["Lower Blackrock Spire"].." - "..AL["Quest Item"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["LBRSSpirestoneButcher"] = { BabbleBoss["Spirestone Butcher"].." ("..AL["Rare"]..")", "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["LBRSOmokk"] = { BabbleBoss["Highlord Omokk"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["LBRSSpirestoneLord"] = { BabbleBoss["Spirestone Battle Lord"].." ("..AL["Rare"]..")", "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["LBRSLordMagus"] = { BabbleBoss["Spirestone Lord Magus"].." ("..AL["Rare"]..")", "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["LBRSVosh"] = { BabbleBoss["Shadow Hunter Vosh'gajin"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["LBRSVoone"] = { BabbleBoss["War Master Voone"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["LBRSGrayhoof"] = { BabbleBoss["Mor Grayhoof"].." ("..AL["Summon"]..")", "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["LBRSGrimaxe"] = { BabbleBoss["Bannok Grimaxe"].." ("..AL["Rare"]..")", "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["LBRSSmolderweb"] = { BabbleBoss["Mother Smolderweb"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["LBRSCrystalFang"] = { BabbleBoss["Crystal Fang"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["LBRSDoomhowl"] = { BabbleBoss["Urok Doomhowl"].." ("..AL["Summon"]..")", "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["LBRSZigris"] = { BabbleBoss["Quartermaster Zigris"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["LBRSHalycon"] = { BabbleBoss["Halycon"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["LBRSSlavener"] = { BabbleBoss["Gizrul the Slavener"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["LBRSBashguud"] = { BabbleBoss["Ghok Bashguud"].." ("..AL["Rare"]..")", "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["LBRSWyrmthalak"] = { BabbleBoss["Overlord Wyrmthalak"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["LBRSFelguard"] = { BabbleBoss["Burning Felguard"].." ("..AL["Rare"]..", "..AL["Random"]..")", "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["LBRSTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Lower Blackrock Spire"]..")", "AtlasLootOriginalWoW" };
  -- Upper Blackrock Spire
	AtlasLoot_TableNames["UBRSEmberseer"] = { BabbleBoss["Pyroguard Emberseer"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["UBRSSolakar"] = { BabbleBoss["Solakar Flamewreath"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["UBRSFLAME"] = { AL["Father Flame"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["UBRSQuestItems"] = { AL["Quest Item"].." ("..BabbleZone["Upper Blackrock Spire"]..")", "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["UBRSRunewatcher"] = { BabbleBoss["Jed Runewatcher"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["UBRSAnvilcrack"] = { BabbleBoss["Goraluk Anvilcrack"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["UBRSRend"] = { BabbleBoss["Warchief Rend Blackhand"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["UBRSGyth"] = { BabbleBoss["Gyth"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["UBRSBeast"] = { BabbleBoss["The Beast"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["UBRSValthalak"] = { BabbleBoss["Lord Valthalak"].." ("..AL["Summon"]..")", "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["UBRSDrakkisath"] = { BabbleBoss["General Drakkisath"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["UBRSTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Upper Blackrock Spire"]..")", "AtlasLootOriginalWoW" };
  -- Blackwing Lair
	AtlasLoot_TableNames["BWLRazorgore"] = { BabbleBoss["Razorgore the Untamed"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["BWLVaelastrasz"] = { BabbleBoss["Vaelastrasz the Corrupt"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["BWLLashlayer"] = { BabbleBoss["Broodlord Lashlayer"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["BWLFiremaw"] = { BabbleBoss["Firemaw"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["BWLEbonroc"] = { BabbleBoss["Ebonroc"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["BWLFlamegor"] = { BabbleBoss["Flamegor"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["BWLChromaggus"] = { BabbleBoss["Chromaggus"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["BWLNefarian1"] = { BabbleBoss["Nefarian"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["BWLNefarian2"] = { BabbleBoss["Nefarian"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["BWLTrashMobs"] = { AL["Trash Mobs"].." ("..BabbleZone["Blackwing Lair"]..")", "AtlasLootOriginalWoW" };
  -- The Deadmines
	AtlasLoot_TableNames["TheDeadminesEntrance"] = { BabbleZone["The Deadmines"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["TheDeadmines1"] = { BabbleZone["The Deadmines"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["TheDeadmines2"] = { BabbleZone["The Deadmines"], "AtlasLootOriginalWoW" };
  -- Dire Maul East
	AtlasLoot_TableNames["DMEPusillin"] = { BabbleBoss["Pusillin"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["DMEZevrimThornhoof"] = { BabbleBoss["Zevrim Thornhoof"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["DMEHydro"] = { BabbleBoss["Hydrospawn"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["DMELethtendris"] = { BabbleBoss["Lethtendris"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["DMEPimgib"] = { BabbleBoss["Pimgib"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["DMEAlzzin"] = { BabbleBoss["Alzzin the Wildshaper"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["DMEIsalien"] = { BabbleBoss["Isalien"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["DMETrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Dire Maul (East)"]..")", "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["DMBooks"] = { "Dire Maul Books", "AtlasLootOriginalWoW" };
  -- Dire Maul North
	AtlasLoot_TableNames["DMNGuardMoldar"] = { BabbleBoss["Guard Mol'dar"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["DMNStomperKreeg"] = { BabbleBoss["Stomper Kreeg"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["DMNGuardFengus"] = { BabbleBoss["Guard Fengus"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["DMNThimblejack"] = { AL["Knot Thimblejack"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["DMNGuardSlipkik"] = { BabbleBoss["Guard Slip'kik"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["DMNCaptainKromcrush"] = { BabbleBoss["Captain Kromcrush"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["DMNChoRush"] = { BabbleBoss["Cho'Rush the Observer"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["DMNKingGordok"] = { BabbleBoss["King Gordok"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["DMNTRIBUTERUN"] = { AL["DM North Tribute Chest"], "AtlasLootOriginalWoW" };
  -- Dire Maul West
	AtlasLoot_TableNames["DMWTendrisWarpwood"] = { BabbleBoss["Tendris Warpwood"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["DMWIllyannaRavenoak"] = { BabbleBoss["Illyanna Ravenoak"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["DMWMagisterKalendris"] = { BabbleBoss["Magister Kalendris"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["DMWTsuzee"] = { BabbleBoss["Tsu'zee"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["DMWImmolthar"] = { BabbleBoss["Immol'thar"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["DMWHelnurath"] = { BabbleBoss["Lord Hel'nurath"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["DMWPrinceTortheldrin"] = { BabbleBoss["Prince Tortheldrin"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["DMWShendralarProvisioner"] = { AL["Shen'dralar Provisioner"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["DMWTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Dire Maul (West)"]..")", "AtlasLootOriginalWoW" };
  -- Gnomeregan
	AtlasLoot_TableNames["Gnomeregan1"] = { BabbleZone["Gnomeregan"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["Gnomeregan2"] = { BabbleZone["Gnomeregan"], "AtlasLootOriginalWoW" };
  -- Maraudon
	AtlasLoot_TableNames["Maraudon1"] = { BabbleZone["Maraudon"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["Maraudon2"] = { BabbleZone["Maraudon"], "AtlasLootOriginalWoW" };
  -- Molten Core
	AtlasLoot_TableNames["MCLucifron"] = { BabbleBoss["Lucifron"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["MCMagmadar"] = { BabbleBoss["Magmadar"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["MCGehennas"] = { BabbleBoss["Gehennas"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["MCGarr"] = { BabbleBoss["Garr"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["MCShazzrah"] = { BabbleBoss["Shazzrah"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["MCGeddon"] = { BabbleBoss["Baron Geddon"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["MCGolemagg"] = { BabbleBoss["Golemagg the Incinerator"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["MCSulfuron"] = { BabbleBoss["Sulfuron Harbinger"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["MCMajordomo"] = { BabbleBoss["Majordomo Executus"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["MCRagnaros"] = { BabbleBoss["Ragnaros"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["MCRANDOMBOSSDROPPS"] = { "Random Boss Drops", "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["MCTrashMobs"] = { AL["Trash Mobs"].." ("..BabbleZone["Molten Core"]..")", "AtlasLootOriginalWoW" };
  -- Ragefire Chasm
	AtlasLoot_TableNames["RagefireChasm"] = { BabbleZone["Ragefire Chasm"], "AtlasLootOriginalWoW" };
  -- Razorfen Downs
	AtlasLoot_TableNames["RazorfenDowns1"] = { BabbleZone["Razorfen Downs"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["RazorfenDowns2"] = { BabbleZone["Razorfen Downs"], "AtlasLootOriginalWoW" };
  -- Razorfen Kraul
	AtlasLoot_TableNames["RazorfenKraul1"] = { BabbleZone["Razorfen Kraul"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["RazorfenKraul2"] = { BabbleZone["Razorfen Kraul"], "AtlasLootOriginalWoW" };
  -- The Ruins of Ahn'Qiraj
	AtlasLoot_TableNames["AQ20Kurinnaxx"] = { BabbleBoss["Kurinnaxx"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["AQ20Rajaxx"] = { BabbleBoss["General Rajaxx"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["AQ20Moam"] = { BabbleBoss["Moam"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["AQ20Buru"] = { BabbleBoss["Buru the Gorger"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["AQ20Ayamiss"] = { BabbleBoss["Ayamiss the Hunter"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["AQ20Ossirian"] = { BabbleBoss["Ossirian the Unscarred"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["AQ20Trash"] = { AL["Trash Mobs"].." (AQ20)", "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["AQ20ClassBooks"] = { "AQ Class Books", "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["AQEnchants"] = { "AQ Enchants", "AtlasLootOriginalWoW" };
  -- Scarlet Monestery
	AtlasLoot_TableNames["SMHerod"] = { BabbleZone["Scarlet Monastery"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["SMCathedral"] = { BabbleZone["Cathedral"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["SMGraveyard"] = { BabbleZone["Graveyard"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["SMLibrary"] = { BabbleZone["Library"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["SMTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Scarlet Monastery"]..")", "AtlasLootOriginalWoW" };
  -- Scholomance
	AtlasLoot_TableNames["SCHOLOBloodStewardofKirtonos"] = { BabbleBoss["Blood Steward of Kirtonos"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["SCHOLOKirtonostheHerald"] = { BabbleBoss["Kirtonos the Herald"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["SCHOLOJandiceBarov"] = { BabbleBoss["Jandice Barov"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["SCHOLORattlegore"] = { BabbleBoss["Rattlegore"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["SCHOLODeathKnight"] = { BabbleBoss["Death Knight Darkreaver"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["SCHOLOMarduk"] = { BabbleBoss["Marduk Blackpool"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["SCHOLOVectus"] = { BabbleBoss["Vectus"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["SCHOLORasFrostwhisper"] = { BabbleBoss["Ras Frostwhisper"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["SCHOLOKormok"] = { BabbleBoss["Kormok"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["SCHOLOInstructorMalicia"] = { BabbleBoss["Instructor Malicia"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["SCHOLODoctorTheolenKrastinov"] = { BabbleBoss["Doctor Theolen Krastinov"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["SCHOLOLorekeeperPolkelt"] = { BabbleBoss["Lorekeeper Polkelt"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["SCHOLOTheRavenian"] = { BabbleBoss["The Ravenian"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["SCHOLOLordAlexeiBarov"] = { BabbleBoss["Lord Alexei Barov"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["SCHOLOLadyIlluciaBarov"] = { BabbleBoss["Lady Illucia Barov"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["SCHOLODarkmasterGandling"] = { BabbleBoss["Darkmaster Gandling"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["SCHOLOQuestItems"] = { AL["Quest Item"].." ("..BabbleZone["Scholomance"]..")", "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["SCHOLOTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Scholomance"]..")", "AtlasLootOriginalWoW" };
  -- Shadowfang Keep
	AtlasLoot_TableNames["ShadowfangKeep1"] = { BabbleZone["Shadowfang Keep"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["ShadowfangKeep2"] = { BabbleZone["Shadowfang Keep"], "AtlasLootOriginalWoW" };
  -- The Stockade
	AtlasLoot_TableNames["TheStockade"] = { BabbleZone["The Stockade"], "AtlasLootOriginalWoW" };
  -- Stratholme
	AtlasLoot_TableNames["STRATSkull"] = { BabbleBoss["Skul"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["STRATStratholmeCourier"] = { "Mailbox Keys", "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["STRATFrasSiabi"] = { BabbleBoss["Fras Siabi"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["STRATAtiesh"] = { "Atiesh <Hand of Sargeras>", "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["STRATHearthsingerForresten"] = { BabbleBoss["Hearthsinger Forresten"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["STRATTheUnforgiven"] = { BabbleBoss["The Unforgiven"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["STRATTimmytheCruel"] = { BabbleBoss["Timmy the Cruel"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["STRATMalorsStrongbox"] = { AL["Malor's Strongbox"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["STRATCrimsonHammersmith"] = { BabbleBoss["Crimson Hammersmith"].." ("..AL["Summon"]..")", "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["STRATBSPlansSerenity"] = { "Plans: Serenity", "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["STRATCannonMasterWilley"] = { BabbleBoss["Cannon Master Willey"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["STRATArchivistGalford"] = { BabbleBoss["Archivist Galford"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["STRATBalnazzar"] = { BabbleBoss["Balnazzar"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["STRATSothosJarien"] = { AL["Sothos and Jarien"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["STRATStonespine"] = { BabbleBoss["Stonespine"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["STRATNerubenkan"] = { BabbleBoss["Nerub'enkan"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["STRATBaronessAnastari"] = { BabbleBoss["Baroness Anastari"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["STRATBlackGuardSwordsmith"] = { BabbleBoss["Black Guard Swordsmith"].." ("..AL["Summon"]..")", "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["STRATBSPlansCorruption"] = { "Plans: Corruption", "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["STRATMalekithePallid"] = { BabbleBoss["Maleki the Pallid"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["STRATMagistrateBarthilas"] = { BabbleBoss["Magistrate Barthilas"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["STRATRamsteintheGorger"] = { BabbleBoss["Ramstein the Gorger"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["STRATBaronRivendare"] = { BabbleBoss["Baron Rivendare"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["STRATTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Stratholme"]..")", "AtlasLootOriginalWoW" };
  -- Sunken Temple
	AtlasLoot_TableNames["STSpawnOfHakkar"] = { "Spawn of Hakkar", "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["STTrollMinibosses"] = { "Troll Minibosses", "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["STAtalalarion"] = { BabbleBoss["Atal'alarion"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["STDreamscythe"] = { BabbleBoss["Dreamscythe"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["STWeaver"] = { BabbleBoss["Weaver"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["STAvatarofHakkar"] = { BabbleBoss["Avatar of Hakkar"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["STJammalan"] = { BabbleBoss["Jammal'an the Prophet"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["STOgom"] = { BabbleBoss["Ogom the Wretched"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["STMorphaz"] = { BabbleBoss["Morphaz"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["STHazzas"] = { BabbleBoss["Hazzas"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["STEranikus"] = { BabbleBoss["Shade of Eranikus"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["STTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["The Temple of Atal'Hakkar"]..")", "AtlasLootOriginalWoW" };
  -- Temple of Ahn'Qiraj
	AtlasLoot_TableNames["AQ40Skeram"] = { BabbleBoss["The Prophet Skeram"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["AQ40Vem"] = { BabbleBoss["The Bug Family"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["AQ40Sartura"] = { BabbleBoss["Battleguard Sartura"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["AQ40Fankriss"] = { BabbleBoss["Fankriss the Unyielding"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["AQ40Viscidus"] = { BabbleBoss["Viscidus"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["AQ40Huhuran"] = { BabbleBoss["Princess Huhuran"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["AQ40Emperors"] = { BabbleBoss["The Twin Emperors"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["AQ40Ouro"] = { BabbleBoss["Ouro"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["AQ40CThun"] = { BabbleBoss["C'Thun"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["AQ40Trash1"] = { AL["Trash Mobs"].." (AQ40)", "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["AQ40Trash2"] = { AL["Trash Mobs"].." (AQ40)", "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["AQOpening"] = { "AQ Opening Quest Line", "AtlasLootOriginalWoW" };
  -- Uldaman
	AtlasLoot_TableNames["UldMagreganDeepshadow"] = { AL["Magregan Deepshadow"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["UldTabletofRyuneh"] = { "Tablet of Ryun'eh", "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["UldKromStoutarmChest"] = { AL["Krom Stoutarm's Chest"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["UldGarrettFamilyChest"] = { AL["Garrett Family Chest"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["UldShovelphlange"] = { BabbleBoss["Digmaster Shovelphlange"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["UldRevelosh"] = { BabbleBoss["Revelosh"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["UldBaelog"] = { BabbleBoss["Baelog"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["UldIronaya"] = { BabbleBoss["Ironaya"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["UldObsidianSentinel"] = { BabbleBoss["Obsidian Sentinel"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["UldAncientStoneKeeper"] = { BabbleBoss["Ancient Stone Keeper"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["UldGalgannFirehammer"] = { BabbleBoss["Galgann Firehammer"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["UldTabletofWill"] = { "Tablet of Will", "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["UldShadowforgeCache"] = { "Shadowforge Cache", "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["UldGrimlok"] = { BabbleBoss["Grimlok"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["UldArchaedas"] = { BabbleBoss["Archaedas"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["UldTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Uldaman"]..")", "AtlasLootOriginalWoW" };
  -- Wailing Caverns
	AtlasLoot_TableNames["WailingCaverns1"] = { BabbleZone["Wailing Caverns"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["WailingCaverns2"] = { BabbleZone["Wailing Caverns"], "AtlasLootOriginalWoW" };
  -- Zul'Farrak
	AtlasLoot_TableNames["ZFAntusul"] = { BabbleBoss["Antu'sul"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["ZFThekatheMartyr"] = { BabbleBoss["Theka the Martyr"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["ZFWitchDoctorZumrah"] = { BabbleBoss["Witch Doctor Zum'rah"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["ZFNekrumGutchewer"] = { BabbleBoss["Nekrum Gutchewer"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["ZFSezzziz"] = { BabbleBoss["Shadowpriest Sezz'ziz"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["ZFDustwraith"] = { BabbleBoss["Dustwraith"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["ZFSergeantBly"] = { BabbleBoss["Sergeant Bly"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["ZFSandfury"] = { BabbleBoss["Sandfury Executioner"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["ZFHydromancerVelratha"] = { BabbleBoss["Hydromancer Velratha"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["ZFGahzrilla"] = { BabbleBoss["Gahz'rilla"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["ZFChiefUkorzSandscalp"] = { BabbleBoss["Chief Ukorz Sandscalp"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["ZFZerillis"] = { BabbleBoss["Zerillis"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["ZFTrash"] = { AL["Trash Mobs"].." ("..BabbleZone["Zul'Farrak"]..")", "AtlasLootOriginalWoW" };
  -- Zul'Gurub
	AtlasLoot_TableNames["ZGJeklik"] = { BabbleBoss["High Priestess Jeklik"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["ZGVenoxis"] = { BabbleBoss["High Priest Venoxis"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["ZGMarli"] = { BabbleBoss["High Priestess Mar'li"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["ZGMandokir"] = { BabbleBoss["Bloodlord Mandokir"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["ZGEdgeofMadness"] = { BabbleZone["Zul'Gurub"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["ZGGahzranka"] = { BabbleBoss["Gahz'ranka"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["ZGThekal"] = { BabbleBoss["High Priest Thekal"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["ZGArlokk"] = { BabbleBoss["High Priestess Arlokk"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["ZGJindo"] = { BabbleBoss["Jin'do the Hexxer"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["ZGHakkar"] = { BabbleBoss["Hakkar"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["ZGMuddyChurningWaters"] = { "Muddy Churning Waters", "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["ZGShared"] = { "Shared ZG Priest Drops", "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["ZGTrash1"] = { AL["Trash Mobs"].." ("..BabbleZone["Zul'Gurub"]..")", "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["ZGTrash2"] = { AL["Trash Mobs"].." ("..BabbleZone["Zul'Gurub"]..")", "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["ZGEnchants"] = { "ZG Enchants", "AtlasLootOriginalWoW" };

------------
--- Sets ---
------------

  -- Arena PvP Sets
	AtlasLoot_TableNames["ArenaDruidFeral"] = { LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..AL["Feral"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["ArenaDruidBalance"] = { LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..AL["Balance"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["ArenaDruidRestoration"] = { LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..AL["Restoration"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["ArenaHunter"] = { LOCALIZED_CLASS_NAMES_MALE["HUNTER"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["ArenaMage"] = { LOCALIZED_CLASS_NAMES_MALE["MAGE"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["ArenaPaladinProtection"] = { LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..AL["Protection"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["ArenaPaladinRetribution"] = { LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..AL["Retribution"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["ArenaPaladinHoly"] = { LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..AL["Holy"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["ArenaPriestHoly"] = { LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." - "..AL["Holy"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["ArenaPriestShadow"] = { LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." - "..AL["Shadow"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["ArenaRogue"] = { LOCALIZED_CLASS_NAMES_MALE["ROGUE"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["ArenaShamanEnhancement"] = { LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..AL["Enhancement"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["ArenaShamanElemental"] = { LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..AL["Elemental"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["ArenaShamanRestoration"] = { LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..AL["Restoration"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["ArenaWarlockDemonology"] = { LOCALIZED_CLASS_NAMES_MALE["WARLOCK"].." - "..AL["Demonology"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["ArenaWarlockDestruction"] = { LOCALIZED_CLASS_NAMES_MALE["WARLOCK"].." - "..AL["Destruction"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["ArenaWarrior"] = { LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "AtlasLootBurningCrusade" };
  -- Level 60 PvP Sets
	AtlasLoot_TableNames["PVPDruid"] = { LOCALIZED_CLASS_NAMES_MALE["DRUID"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["PVPHunter"] = { LOCALIZED_CLASS_NAMES_MALE["HUNTER"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["PVPMage"] = { LOCALIZED_CLASS_NAMES_MALE["MAGE"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["PVPPaladin"] = { LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["PVPPriest"] = { LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["PVPRogue"] = { LOCALIZED_CLASS_NAMES_MALE["ROGUE"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["PVPShaman"] = { LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["PVPWarlock"] = { LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["PVPWarrior"] = { LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "AtlasLootOriginalWoW" };
  -- Level 70 PvP Reputation Sets
	AtlasLoot_TableNames["PVP70RepCloth"] = { BabbleInventory["Cloth"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["PVP70RepLeather"] = { BabbleInventory["Leather"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["PVP70RepMail"] = { BabbleInventory["Mail"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["PVP70RepPlate"] = { BabbleInventory["Plate"], "AtlasLootBurningCrusade" };
  -- Level 80 PvP Sets
	AtlasLoot_TableNames["PvP80DeathKnight"] = { LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PvP80DeathKnight2"] = { LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PvP80DruidBalance"] = { LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..AL["Balance"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PvP80DruidBalance2"] = { LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..AL["Balance"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PvP80DruidFeral"] = { LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..AL["Feral"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PvP80DruidFeral2"] = { LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..AL["Feral"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PvP80DruidRestoration"] = { LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..AL["Restoration"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PvP80DruidRestoration2"] = { LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..AL["Restoration"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PvP80Hunter"] = { LOCALIZED_CLASS_NAMES_MALE["HUNTER"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PvP80Hunter2"] = { LOCALIZED_CLASS_NAMES_MALE["HUNTER"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PvP80Mage"] = { LOCALIZED_CLASS_NAMES_MALE["MAGE"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PvP80Mage2"] = { LOCALIZED_CLASS_NAMES_MALE["MAGE"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PvP80PaladinHoly"] = { LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..AL["Holy"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PvP80PaladinHoly2"] = { LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..AL["Holy"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PvP80PaladinRetribution"] = { LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..AL["Retribution"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PvP80PaladinRetribution2"] = { LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..AL["Retribution"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PvP80PriestHoly"] = { LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." - "..AL["Holy"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PvP80PriestHoly2"] = { LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." - "..AL["Holy"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PvP80PriestShadow"] = { LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." - "..AL["Shadow"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PvP80PriestShadow2"] = { LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." - "..AL["Shadow"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PvP80Rogue"] = { LOCALIZED_CLASS_NAMES_MALE["ROGUE"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PvP80Rogue2"] = { LOCALIZED_CLASS_NAMES_MALE["ROGUE"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PvP80ShamanElemental"] = { LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..AL["Elemental"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PvP80ShamanElemental2"] = { LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..AL["Elemental"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PvP80ShamanEnhancement"] = { LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..AL["Enhancement"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PvP80ShamanEnhancement2"] = { LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..AL["Enhancement"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PvP80ShamanRestoration"] = { LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..AL["Restoration"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PvP80ShamanRestoration2"] = { LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..AL["Restoration"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PvP80Warlock"] = { LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PvP80Warlock2"] = { LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PvP80Warrior"] = { LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PvP80Warrior2"] = { LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "AtlasLootWotLK" };
  -- Vanilla WoW Sets
	AtlasLoot_TableNames["VWOWSets1"] = { AL["Classic Sets"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["VWOWSets2"] = { AL["Classic Sets"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["VWOWSets3"] = { AL["Classic Sets"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["VWOWScholo"] = { AL["Scholomance Sets"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["VWOWScourgeInvasion"] = { AL["Scourge Invasion Sets"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["VWOWZulGurub"] = { AL["Zul'Gurub Sets"], "AtlasLootOriginalWoW" };
  -- The Burning Crusade Sets
	AtlasLoot_TableNames["TBCSets"] = { AL["Burning Crusade Sets"], "AtlasLootBurningCrusade" };
  -- Wrath Of The Lich King Sets
	AtlasLoot_TableNames["WOTLKSets"] = { AL["Wrath Of The Lich King Sets"], "AtlasLootWotLK" };
  -- Crafted Sets - Blacksmithing - Mail
	AtlasLoot_TableNames["BlacksmithingMailBloodsoulEmbrace"] = { AL["Bloodsoul Embrace"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["BlacksmithingMailFelIronChain"] = { AL["Fel Iron Chain"], "AtlasLootCrafting" };
  -- Crafted Sets - Blacksmithing - Plate
	AtlasLoot_TableNames["BlacksmithingPlateImperialPlate"] = { AL["Imperial Plate"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["BlacksmithingPlateTheDarksoul"] = { AL["The Darksoul"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["BlacksmithingPlateFelIronPlate"] = { AL["Fel Iron Plate"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["BlacksmithingPlateAdamantiteB"] = { AL["Adamantite Battlegear"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["BlacksmithingPlateFlameG"] = { AL["Flame Guard"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["BlacksmithingPlateEnchantedAdaman"] = { AL["Enchanted Adamantite Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["BlacksmithingPlateKhoriumWard"] = { AL["Khorium Ward"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["BlacksmithingPlateFaithFelsteel"] = { AL["Faith in Felsteel"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["BlacksmithingPlateBurningRage"] = { AL["Burning Rage"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["BlacksmithingPlateOrnateSaroniteBattlegear"] = { AL["Ornate Saronite Battlegear"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["BlacksmithingPlateSavageSaroniteBattlegear"] = { AL["Savage Saronite Battlegear"], "AtlasLootCrafting" };
  -- Crafted Sets - Leatherworking - Leather
	AtlasLoot_TableNames["LeatherworkingLeatherVolcanicArmor"] = { AL["Volcanic Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherworkingLeatherIronfeatherArmor"] = { AL["Ironfeather Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherworkingLeatherStormshroudArmor"] = { AL["Stormshroud Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherworkingLeatherDevilsaurArmor"] = { AL["Devilsaur Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherworkingLeatherBloodTigerH"] = { AL["Blood Tiger Harness"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherworkingLeatherPrimalBatskin"] = { AL["Primal Batskin"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherworkingLeatherWildDraenishA"] = { AL["Wild Draenish Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherworkingLeatherThickDraenicA"] = { AL["Thick Draenic Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherworkingLeatherFelSkin"] = { AL["Fel Skin"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherworkingLeatherSClefthoof"] = { AL["Strength of the Clefthoof"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherworkingLeatherPrimalIntent"] = { AL["Primal Intent"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherworkingLeatherWindhawkArmor"] = { AL["Windhawk Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherworkingLeatherBoreanEmbrace"] = { AL["Borean Embrace"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherworkingLeatherIceborneEmbrace"] = { AL["Iceborne Embrace"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherworkingLeatherEvisceratorBattlegear"] = { AL["Eviscerator's Battlegear"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherworkingLeatherOvercasterBattlegear"] = { AL["Overcaster Battlegear"], "AtlasLootCrafting" };
  -- Crafted Sets - Leatherworking - Mail
	AtlasLoot_TableNames["LeatherworkingMailGreenDragonM"] = { AL["Green Dragon Mail"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherworkingMailBlueDragonM"] = { AL["Blue Dragon Mail"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherworkingMailBlackDragonM"] = { AL["Black Dragon Mail"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherworkingMailScaledDraenicA"] = { AL["Scaled Draenic Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherworkingMailFelscaleArmor"] = { AL["Felscale Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherworkingMailFelstalkerArmor"] = { AL["Felstalker Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherworkingMailNetherFury"] = { AL["Fury of the Nether"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherworkingMailNetherscaleArmor"] = { AL["Netherscale Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherworkingMailNetherstrikeArmor"] = { AL["Netherstrike Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherworkingMailFrostscaleBinding"] = { AL["Frostscale Binding"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherworkingMailNerubianHive"] = { AL["Nerubian Hive"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherworkingMailStormhideBattlegear"] = { AL["Stormhide Battlegear"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherworkingMailSwiftarrowBattlefear"] = { AL["Swiftarrow Battlefear"], "AtlasLootCrafting" };
  -- Crafted Sets - Tailoring
	AtlasLoot_TableNames["TailoringBloodvineG"] = { AL["Bloodvine Garb"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringNeatherVest"] = { AL["Netherweave Vestments"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringImbuedNeather"] = { AL["Imbued Netherweave"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringArcanoVest"] = { AL["Arcanoweave Vestments"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringTheUnyielding"] = { AL["The Unyielding"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringWhitemendWis"] = { AL["Whitemend Wisdom"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringSpellstrikeInfu"] = { AL["Spellstrike Infusion"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringBattlecastG"] = { AL["Battlecast Garb"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringSoulclothEm"] = { AL["Soulcloth Embrace"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringPrimalMoon"] = { AL["Primal Mooncloth"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringShadowEmbrace"] = { AL["Shadow's Embrace"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringSpellfireWrath"] = { AL["Wrath of Spellfire"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringFrostwovenPower"] = { AL["Frostwoven Power"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringDuskweaver"] = { AL["Duskweaver"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringFrostsavageBattlegear"] = { AL["Frostsavage Battlegear"], "AtlasLootCrafting" };
  -- ZG Sets
	AtlasLoot_TableNames["ZGSets1"] = { AL["ZG Class Sets"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["ZGSets2"] = { AL["ZG Class Sets"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["ZGSets3"] = { AL["ZG Class Sets"], "AtlasLootOriginalWoW" };
  -- AQ20 Sets
	AtlasLoot_TableNames["AQ20Sets1"] = { AL["AQ20 Class Sets"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["AQ20Sets2"] = { AL["AQ20 Class Sets"], "AtlasLootOriginalWoW" };
  -- AQ40 Sets
	AtlasLoot_TableNames["AQ40Sets1"] = { AL["AQ40 Class Sets"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["AQ40Sets2"] = { AL["AQ40 Class Sets"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["AQ40Sets3"] = { AL["AQ40 Class Sets"], "AtlasLootOriginalWoW" };
  -- Dungeon Set 1/2
	AtlasLoot_TableNames["T0Druid"] = { LOCALIZED_CLASS_NAMES_MALE["DRUID"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["T0Hunter"] = { LOCALIZED_CLASS_NAMES_MALE["HUNTER"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["T0Mage"] = { LOCALIZED_CLASS_NAMES_MALE["MAGE"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["T0Paladin"] = { LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["T0Priest"] = { LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["T0Rogue"] = { LOCALIZED_CLASS_NAMES_MALE["ROGUE"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["T0Shaman"] = { LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["T0Warlock"] = { LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["T0Warrior"] = { LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "AtlasLootOriginalWoW" };
  -- Dungeon Set 3
	AtlasLoot_TableNames["DS3Cloth"] = { BabbleInventory["Cloth"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["DS3Leather"] = { BabbleInventory["Leather"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["DS3Mail"] = { BabbleInventory["Mail"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["DS3Plate"] = { BabbleInventory["Plate"], "AtlasLootBurningCrusade" };
  -- T1/T2 Sets
	AtlasLoot_TableNames["T1T2Druid"] = { LOCALIZED_CLASS_NAMES_MALE["DRUID"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["T1T2Hunter"] = { LOCALIZED_CLASS_NAMES_MALE["HUNTER"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["T1T2Mage"] = { LOCALIZED_CLASS_NAMES_MALE["MAGE"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["T1T2Paladin"] = { LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["T1T2Priest"] = { LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["T1T2Rogue"] = { LOCALIZED_CLASS_NAMES_MALE["ROGUE"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["T1T2Shaman"] = { LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["T1T2Warlock"] = { LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["T1T2Warrior"] = { LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "AtlasLootOriginalWoW" };
  -- T3 Sets
	AtlasLoot_TableNames["T3Druid"] = { LOCALIZED_CLASS_NAMES_MALE["DRUID"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["T3Hunter"] = { LOCALIZED_CLASS_NAMES_MALE["HUNTER"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["T3Mage"] = { LOCALIZED_CLASS_NAMES_MALE["MAGE"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["T3Paladin"] = { LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["T3Priest"] = { LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["T3Rogue"] = { LOCALIZED_CLASS_NAMES_MALE["ROGUE"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["T3Shaman"] = { LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["T3Warlock"] = { LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["T3Warrior"] = { LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "AtlasLootOriginalWoW" };
  -- T4/T5/T6 Sets
	AtlasLoot_TableNames["T456DruidBalance"] = { LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..AL["Balance"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["T456DruidFeral"] = { LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..AL["Feral"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["T456DruidRestoration"] = { LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..AL["Restoration"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["T456Hunter"] = { LOCALIZED_CLASS_NAMES_MALE["HUNTER"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["T456Mage"] = { LOCALIZED_CLASS_NAMES_MALE["MAGE"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["T456PaladinHoly"] = { LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..AL["Holy"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["T456PaladinProtection"] = { LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..AL["Protection"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["T456PaladinRetribution"] = { LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..AL["Retribution"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["T456PriestHoly"] = { LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." - "..AL["Holy"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["T456PriestShadow"] = { LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." - "..AL["Shadow"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["T456Rogue"] = { LOCALIZED_CLASS_NAMES_MALE["ROGUE"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["T456ShamanElemental"] = { LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..AL["Elemental"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["T456ShamanEnhancement"] = { LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..AL["Enhancement"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["T456ShamanRestoration"] = { LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..AL["Restoration"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["T456Warlock"] = { LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["T456WarriorFury"] = { LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." - "..AL["Fury"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["T456WarriorProtection"] = { LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." - "..AL["Protection"], "AtlasLootBurningCrusade" };
  -- Badge of Justice Rewards
	AtlasLoot_TableNames["HardModeCloth"] = { BabbleInventory["Cloth"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["HardModeLeather"] = { BabbleInventory["Leather"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["HardModeLeather2"] = { BabbleInventory["Leather"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["HardModeMail"] = { BabbleInventory["Mail"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["HardModePlate"] = { BabbleInventory["Plate"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["HardModePlate2"] = { BabbleInventory["Plate"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["HardModeCloaks"] = { BabbleInventory["Back"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["HardModeResist"] = { AL["Fire Resistance Gear"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["HardModeAccessories"] = { AL["Accessories"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["HardModeAccessories2"] = { AL["Accessories"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["HardModeRelic"] = { BabbleInventory["Relic"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["HardModeWeapons"] = { AL["Weapons"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["HardModeArena"] = { AL["PvP Rewards"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["HardModeArena2"] = { AL["PvP Rewards"], "AtlasLootBurningCrusade" };
  -- Heirloom Items
	AtlasLoot_TableNames["Heirloom"] = { AL["Heirloom"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Heirloom2"] = { AL["Heirloom"], "AtlasLootWotLK" };
  -- Emblem of Heroism Rewards
	AtlasLoot_TableNames["EmblemofHeroism"] = { AL["Emblem of Heroism Rewards"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["EmblemofHeroism2"] = { AL["Emblem of Heroism Rewards"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["EmblemofHeroism3"] = { AL["Emblem of Heroism Rewards"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["EmblemofHeroism4"] = { AL["Emblem of Heroism Rewards"], "AtlasLootWotLK" };
  -- Emblem of Valor Rewards
	AtlasLoot_TableNames["EmblemofValor"] = { AL["Emblem of Valor Rewards"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["EmblemofValor2"] = { AL["Emblem of Valor Rewards"], "AtlasLootWotLK" };
  -- Emblem of Conquest Rewards
	AtlasLoot_TableNames["EmblemofConquest1"] = { AL["Emblem of Conquest Rewards"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["EmblemofConquest2"] = { AL["Emblem of Conquest Rewards"], "AtlasLootWotLK" };
  -- Emblem of Triumph Rewards
	AtlasLoot_TableNames["EmblemofTriumph1_A"] = { AL["Emblem of Triumph Rewards"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["EmblemofTriumph1_H"] = { AL["Emblem of Triumph Rewards"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["EmblemofTriumph2"] = { AL["Emblem of Triumph Rewards"], "AtlasLootWotLK" };
  -- Emblem of Frost Rewards
	AtlasLoot_TableNames["EmblemofFrost"] = { AL["Emblem of Frost Rewards"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["EmblemofFrost2"] = { AL["Emblem of Frost Rewards"], "AtlasLootWotLK" };
  -- Naxxramas 10/25 Man Sets
	AtlasLoot_TableNames["NaxxDeathKnightDPS"] = { LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." - "..AL["DPS"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["NaxxDeathKnightTank"] = { LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." - "..AL["Tanking"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["NaxxDruidBalance"] = { LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..AL["Balance"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["NaxxDruidFeral"] = { LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..AL["Feral"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["NaxxDruidRestoration"] = { LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..AL["Restoration"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["NaxxHunter"] = { LOCALIZED_CLASS_NAMES_MALE["HUNTER"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["NaxxMage"] = { LOCALIZED_CLASS_NAMES_MALE["MAGE"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["NaxxPaladinHoly"] = { LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..AL["Holy"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["NaxxPaladinProtection"] = { LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..AL["Protection"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["NaxxPaladinRetribution"] = { LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..AL["Retribution"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["NaxxPriestHoly"] = { LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." - "..AL["Holy"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["NaxxPriestShadow"] = { LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." - "..AL["Shadow"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["NaxxRogue"] = { LOCALIZED_CLASS_NAMES_MALE["ROGUE"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["NaxxShamanElemental"] = { LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..AL["Elemental"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["NaxxShamanEnhancement"] = { LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..AL["Enhancement"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["NaxxShamanRestoration"] = { LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..AL["Restoration"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["NaxxWarlock"] = { LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["NaxxWarriorFury"] = { LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." - "..AL["Fury"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["NaxxWarriorProtection"] = { LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." - "..AL["Protection"], "AtlasLootWotLK" };
  -- Tier 9 Sets (Alliance)
	AtlasLoot_TableNames["T9DeathKnightDPS_A"] = { LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." - "..AL["DPS"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T9DeathKnightTank_A"] = { LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." - "..AL["Tanking"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T9DruidBalance_A"] = { LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..AL["Balance"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T9DruidFeral_A"] = { LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..AL["Feral"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T9DruidRestoration_A"] = { LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..AL["Restoration"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T9Hunter_A"] = { LOCALIZED_CLASS_NAMES_MALE["HUNTER"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T9Mage_A"] = { LOCALIZED_CLASS_NAMES_MALE["MAGE"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T9PaladinHoly_A"] = { LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..AL["Holy"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T9PaladinProtection_A"] = { LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..AL["Protection"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T9PaladinRetribution_A"] = { LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..AL["Retribution"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T9PriestHoly_A"] = { LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." - "..AL["Holy"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T9PriestShadow_A"] = { LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." - "..AL["Shadow"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T9Rogue_A"] = { LOCALIZED_CLASS_NAMES_MALE["ROGUE"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T9ShamanElemental_A"] = { LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..AL["Elemental"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T9ShamanEnhancement_A"] = { LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..AL["Enhancement"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T9ShamanRestoration_A"] = { LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..AL["Restoration"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T9Warlock_A"] = { LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T9WarriorFury_A"] = { LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." - "..AL["Fury"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T9WarriorProtection_A"] = { LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." - "..AL["Protection"], "AtlasLootWotLK" };
  -- Tier 9 Sets (Horde)
	AtlasLoot_TableNames["T9DeathKnightDPS_H"] = { LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." - "..AL["DPS"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T9DeathKnightTank_H"] = { LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." - "..AL["Tanking"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T9DruidBalance_H"] = { LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..AL["Balance"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T9DruidFeral_H"] = { LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..AL["Feral"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T9DruidRestoration_H"] = { LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..AL["Restoration"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T9Hunter_H"] = { LOCALIZED_CLASS_NAMES_MALE["HUNTER"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T9Mage_H"] = { LOCALIZED_CLASS_NAMES_MALE["MAGE"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T9PaladinHoly_H"] = { LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..AL["Holy"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T9PaladinProtection_H"] = { LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..AL["Protection"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T9PaladinRetribution_H"] = { LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..AL["Retribution"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T9PriestHoly_H"] = { LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." - "..AL["Holy"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T9PriestShadow_H"] = { LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." - "..AL["Shadow"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T9Rogue_H"] = { LOCALIZED_CLASS_NAMES_MALE["ROGUE"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T9ShamanElemental_H"] = { LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..AL["Elemental"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T9ShamanEnhancement_H"] = { LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..AL["Enhancement"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T9ShamanRestoration_H"] = { LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..AL["Restoration"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T9Warlock_H"] = { LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T9WarriorFury_H"] = { LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." - "..AL["Fury"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T9WarriorProtection_H"] = { LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." - "..AL["Protection"], "AtlasLootWotLK" };
  -- Tier 10 Sets
	AtlasLoot_TableNames["T10DeathKnightDPS"] = { LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." - "..AL["DPS"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T10DeathKnightTank"] = { LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." - "..AL["Tanking"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T10DruidBalance"] = { LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..AL["Balance"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T10DruidFeral"] = { LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..AL["Feral"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T10DruidRestoration"] = { LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..AL["Restoration"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T10Hunter"] = { LOCALIZED_CLASS_NAMES_MALE["HUNTER"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T10Mage"] = { LOCALIZED_CLASS_NAMES_MALE["MAGE"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T10PaladinHoly"] = { LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..AL["Holy"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T10PaladinProtection"] = { LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..AL["Protection"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T10PaladinRetribution"] = { LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..AL["Retribution"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T10PriestHoly"] = { LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." - "..AL["Holy"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T10PriestShadow"] = { LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." - "..AL["Shadow"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T10Rogue"] = { LOCALIZED_CLASS_NAMES_MALE["ROGUE"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T10ShamanElemental"] = { LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..AL["Elemental"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T10ShamanEnhancement"] = { LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..AL["Enhancement"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T10ShamanRestoration"] = { LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..AL["Restoration"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T10Warlock"] = { LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T10WarriorFury"] = { LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." - "..AL["Fury"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["T10WarriorProtection"] = { LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." - "..AL["Protection"], "AtlasLootWotLK" };

------------------------
--- Misc Collections ---
------------------------

	AtlasLoot_TableNames["CraftedWeapons1"] = { AL["Crafted Epic Weapons"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["CraftedWeapons2"] = { AL["Crafted Epic Weapons"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["CraftedWeapons3"] = { AL["Crafted Epic Weapons"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["Legendaries"] = { AL["Legendary Items"], "AtlasLootWotLK" };
  -- Mounts
	AtlasLoot_TableNames["MountsAlliance1"] = { AL["Alliance Mounts"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["MountsAlliance2"] = { AL["Alliance Mounts"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["MountsAlliance3"] = { AL["Alliance Mounts"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["MountsHorde1"] = { AL["Horde Mounts"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["MountsHorde2"] = { AL["Horde Mounts"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["MountsHorde3"] = { AL["Horde Mounts"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["MountsFaction1"] = { AL["Neutral Faction Mounts"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["MountsPvP1"] = { AL["PvP Mounts"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["MountsRare1"] = { AL["Rare Mounts"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["MountsRare2"] = { AL["Rare Mounts"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["MountsCraftQuestPromotion1"] = { AL["Quest"].." / "..AL["Promotional"].." / "..AL["Crafted Mounts"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["MountsEvent1"] = { AL["World Events"].." - "..AL["Argent Tournament"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["MountsEvent2"] = { AL["World Events"], "AtlasLootWotLK" };
  -- Vanity Pets
	AtlasLoot_TableNames["PetsAccessories1"] = { AL["Vanity Pets"].." - "..AL["Accessories"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PetsEvent1"] = { AL["Vanity Pets"].." - "..AL["World Events"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PetsMerchant1"] = { AL["Vanity Pets"].." - "..AL["Merchant Sold"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PetsMerchant2"] = { AL["Vanity Pets"].." - "..AL["Merchant Sold"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PetsPromotional1"] = { AL["Vanity Pets"].." - "..AL["Promotional"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PetsPetStore1"] = { AL["Vanity Pets"].." - "..AL["Pet Store"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PetsQuestCrafted1"] = { AL["Vanity Pets"].." - "..AL["Quest"].." / "..AL["Crafted"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PetsRare1"] = { AL["Vanity Pets"].." - "..AL["Rare"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PetsRare2"] = { AL["Vanity Pets"].." - "..AL["Rare"], "AtlasLootWotLK" };
  -- Tabards
	AtlasLoot_TableNames["Tabards1"] = { AL["Tabards"].." - "..AL["Original WoW"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Tabards2"] = { AL["Tabards"].." - "..AL["Burning Crusade"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Tabards3"] = { AL["Tabards"].." - "..AL["Wrath of the Lich King"], "AtlasLootWotLK" };
  -- Upper Deck Card Game Items
	AtlasLoot_TableNames["CardGame1"] = { AL["Upper Deck Card Game Items"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["CardGame2"] = { AL["Upper Deck Card Game Items"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["CardGame3"] = { AL["Upper Deck Card Game Items"], "AtlasLootWotLK" };
  -- World Epics
	AtlasLoot_TableNames["WorldEpics1"] = { AL["BoE World Epics"].." - "..AL["Level 30-39"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["WorldEpics2"] = { AL["BoE World Epics"].." - "..AL["Level 40-49"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["WorldEpics3"] = { AL["BoE World Epics"].." - "..AL["Level 50-60"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["WorldEpics4"] = { AL["BoE World Epics"].." - "..AL["Level 70"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["WorldEpicsWrath1"] = { AL["BoE World Epics"].." - "..AL["Level 80"], "AtlasLootWotLK" };


--------------------
--- World Bosses ---
--------------------

  -- Azuregos
	AtlasLoot_TableNames["WorldBossesClassic"] = { BabbleBoss["Azuregos"], "AtlasLootOriginalWoW" };
  -- Kazzak/Doomwalker
	AtlasLoot_TableNames["WorldBossesBC"] = { BabbleBoss["Doom Lord Kazzak"].." / "..BabbleBoss["Doomwalker"], "AtlasLootBurningCrusade" };
  -- Emrald Dragons
	AtlasLoot_TableNames["DEmeriss"] = { BabbleBoss["Emeriss"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["DLethon"] = { BabbleBoss["Lethon"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["DTaerar"] = { BabbleBoss["Taerar"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["DYsondre"] = { BabbleBoss["Ysondre"], "AtlasLootOriginalWoW" };

--------------
--- Events ---
--------------

  -- Argent Tournament
	AtlasLoot_TableNames["ArgentTournament1"] = { AL["Argent Tournament"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["ArgentTournament2"] = { AL["Argent Tournament"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["ArgentTournament3"] = { AL["Argent Tournament"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["ArgentTournament4"] = { AL["Argent Tournament"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["ArgentTournament5"] = { AL["Argent Tournament"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["ArgentTournament6"] = { AL["Argent Tournament"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["ArgentTournament7"] = { AL["Argent Tournament"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["ArgentTournament8"] = { AL["Argent Tournament"], "AtlasLootWorldEvents" };
  -- Abyssal Council
	AtlasLoot_TableNames["Templars"] = { AL["Abyssal Council"].." - "..AL["Templars"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["Dukes"] = { AL["Abyssal Council"].." - "..AL["Dukes"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["HighCouncil"] = { AL["Abyssal Council"].." - "..AL["High Council"], "AtlasLootWorldEvents" };
  -- The Darkmoon Faire
	AtlasLoot_TableNames["Darkmoon1"] = { BabbleFaction["Darkmoon Faire"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["Darkmoon2"] = { BabbleFaction["Darkmoon Faire"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["Darkmoon3"] = { BabbleFaction["Darkmoon Faire"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["Darkmoon4"] = { BabbleFaction["Darkmoon Faire"], "AtlasLootWorldEvents" };
  -- Ethereum Prison
	AtlasLoot_TableNames["ArmbreakerHuffaz"] = { AL["Armbreaker Huffaz"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["FelTinkererZortan"] = { AL["Fel Tinkerer Zortan"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["Forgosh"] = { AL["Forgosh"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["Gulbor"] = { AL["Gul'bor"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["MalevustheMad"] = { AL["Malevus the Mad"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["PorfustheGemGorger"] = { AL["Porfus the Gem Gorger"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["WrathbringerLaztarash"] = { AL["Wrathbringer Laz-tarash"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["BashirStasisChambers"] = { AL["Bash'ir Landing Stasis Chambers"], "AtlasLootWorldEvents" };
  -- Seasonal
  --- Brewfest
	AtlasLoot_TableNames["Brewfest1"] = { AL["Brewfest"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["Brewfest2"] = { AL["Brewfest"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["Brewfest3"] = { AL["Brewfest"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["BrewoftheMonthClub"] = { AL["Brew of the Month Club"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["CorenDirebrew"] = { AL["Coren Direbrew"], "AtlasLootWorldEvents" };
  --- Children's Week
	AtlasLoot_TableNames["ChildrensWeek"] = { AL["Children's Week"], "AtlasLootWorldEvents" };
  --- Day of the Dead
	AtlasLoot_TableNames["DayoftheDead"] = { AL["Day of the Dead"], "AtlasLootWorldEvents" };
  --- Feast of Winter Veil
	AtlasLoot_TableNames["Winterviel1"] = { AL["Feast of Winter Veil"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["Winterviel2"] = { AL["Feast of Winter Veil"], "AtlasLootWorldEvents" };
  --- Hallow's End
	AtlasLoot_TableNames["Halloween1"] = { AL["Hallow's End"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["Halloween2"] = { AL["Hallow's End"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["HeadlessHorseman"] = { AL["Headless Horseman"], "AtlasLootWorldEvents" };
  --- Harvest Festival
	AtlasLoot_TableNames["HarvestFestival"] = { AL["Harvest Festival"], "AtlasLootWorldEvents" };
  --- Love is in the Air
	AtlasLoot_TableNames["Valentineday"] = { AL["Love is in the Air"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["Valentineday2"] = { AL["Love is in the Air"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["Valentineday3"] = { AL["Love is in the Air"], "AtlasLootWorldEvents" };
  --- Lunar Festival
	AtlasLoot_TableNames["LunarFestival1"] = { AL["Lunar Festival"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["LunarFestival2"] = { AL["Lunar Festival"], "AtlasLootWorldEvents" };
  --- Midsummer Fire Festival
	AtlasLoot_TableNames["MidsummerFestival"] = { AL["Midsummer Fire Festival"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["LordAhune"] = { AL["Lord Ahune"], "AtlasLootWorldEvents" };
  --- Noblegarden
	AtlasLoot_TableNames["Noblegarden"] = { AL["Noblegarden"], "AtlasLootWorldEvents" };
  --- Pilgrim's Bounty
	AtlasLoot_TableNames["PilgrimsBounty_A"] = { AL["Pilgrim's Bounty"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["PilgrimsBounty_H"] = { AL["Pilgrim's Bounty"], "AtlasLootWorldEvents" };
  -- Skettis
	AtlasLoot_TableNames["DarkscreecherAkkarai"] = { AL["Darkscreecher Akkarai"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["Karrog"] = { AL["Karrog"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["GezzaraktheHuntress"] = { AL["Gezzarak the Huntress"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["VakkiztheWindrager"] = { AL["Vakkiz the Windrager"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["Terokk"] = { AL["Terokk"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["SkettisTalonpriestIshaal"] = { "Talonpriest Ishaal", "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["SkettisHazziksPackage"] = { "Hazzik's Package", "AtlasLootWorldEvents" };
  -- Other
	AtlasLoot_TableNames["BashirLanding"] = { AL["Bash'ir Landing Skyguard Raid"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["ElementalInvasion"] = { AL["Elemental Invasion"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["FishingExtravaganza"] = { AL["Stranglethorn Fishing Extravaganza"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["GurubashiArena"] = { AL["Gurubashi Arena Booty Run"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["ScourgeInvasionEvent1"] = { AL["Scourge Invasion"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["ScourgeInvasionEvent2"] = { AL["Scourge Invasion"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["ScourgeInvasionEvent3"] = { AL["Scourge Invasion"], "AtlasLootWorldEvents" };
	AtlasLoot_TableNames["Shartuul"] = { AL["Shartuul"], "AtlasLootWorldEvents" };

------------------------
--- Classic Factions ---
------------------------

  -- Misc Factions
	AtlasLoot_TableNames["MiscFactions"] = { AL["Factions - Original WoW"], "AtlasLootOriginalWoW" };
  -- Alterac Valley Factions
	AtlasLoot_TableNames["AlteracFactions"] = { BabbleZone["Alterac Valley"], "AtlasLootOriginalWoW" };
  -- Argent Dawn
	AtlasLoot_TableNames["Argent1"] = { BabbleFaction["Argent Dawn"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["Argent2"] = { BabbleFaction["Argent Dawn"], "AtlasLootOriginalWoW" };
  -- Bloodsail Buccaneers & Hydraxian Waterlords
	AtlasLoot_TableNames["BloodsailHydraxian"] = { AL["Factions - Original WoW"], "AtlasLootOriginalWoW" };
  -- Brood of Nozdormu
	AtlasLoot_TableNames["AQBroodRings"] = { BabbleFaction["Brood of Nozdormu"], "AtlasLootOriginalWoW" };
  -- Cenarion Circle
	AtlasLoot_TableNames["Cenarion1"] = { BabbleFaction["Cenarion Circle"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["Cenarion2"] = { BabbleFaction["Cenarion Circle"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["Cenarion3"] = { BabbleFaction["Cenarion Circle"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["Cenarion4"] = { BabbleFaction["Cenarion Circle"], "AtlasLootOriginalWoW" };
  -- Thorium Brotherhood
	AtlasLoot_TableNames["Thorium1"] = { BabbleFaction["Thorium Brotherhood"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["Thorium2"] = { BabbleFaction["Thorium Brotherhood"], "AtlasLootOriginalWoW" };
  -- Timbermaw Hold
	AtlasLoot_TableNames["Timbermaw"] = { BabbleFaction["Timbermaw Hold"], "AtlasLootOriginalWoW" };
  -- Zandalar Tribe
	AtlasLoot_TableNames["Zandalar1"] = { BabbleFaction["Zandalar Tribe"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["Zandalar2"] = { BabbleFaction["Zandalar Tribe"], "AtlasLootOriginalWoW" };

-------------------
--- BC Factions ---
-------------------

  -- The Aldor
	AtlasLoot_TableNames["Aldor1"] = { BabbleFaction["The Aldor"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["Aldor2"] = { BabbleFaction["The Aldor"], "AtlasLootBurningCrusade" };
  -- Ashtongue Deathsworn
	AtlasLoot_TableNames["Ashtongue1"] = { BabbleFaction["Ashtongue Deathsworn"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["Ashtongue2"] = { BabbleFaction["Ashtongue Deathsworn"], "AtlasLootBurningCrusade" };
  -- Cenarion Expedition
	AtlasLoot_TableNames["CExpedition1"] = { BabbleFaction["Cenarion Expedition"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["CExpedition2"] = { BabbleFaction["Cenarion Expedition"], "AtlasLootBurningCrusade" };
  -- The Consortium
	AtlasLoot_TableNames["Consortium1"] = { BabbleFaction["The Consortium"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["Consortium2"] = { BabbleFaction["The Consortium"], "AtlasLootBurningCrusade" };
  -- Honor Hold
	AtlasLoot_TableNames["HonorHold1"] = { BabbleFaction["Honor Hold"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["HonorHold2"] = { BabbleFaction["Honor Hold"], "AtlasLootBurningCrusade" };
  -- Keepers of Time
	AtlasLoot_TableNames["KeepersofTime1"] = { BabbleFaction["Keepers of Time"], "AtlasLootBurningCrusade" };
  -- Kurenai
	AtlasLoot_TableNames["Kurenai1"] = { BabbleFaction["Kurenai"], "AtlasLootBurningCrusade" };
  -- Lower City
	AtlasLoot_TableNames["LowerCity1"] = { BabbleFaction["Lower City"], "AtlasLootBurningCrusade" };
  -- The Mag'har
	AtlasLoot_TableNames["Maghar1"] = { BabbleFaction["The Mag'har"], "AtlasLootBurningCrusade" };
  -- Netherwing
	AtlasLoot_TableNames["Netherwing1"] = { BabbleFaction["Netherwing"], "AtlasLootBurningCrusade" };
  -- Ogri'la
	AtlasLoot_TableNames["Ogrila1"] = { BabbleFaction["Ogri'la"], "AtlasLootBurningCrusade" };
  -- The Scale of the Sands
	AtlasLoot_TableNames["ScaleSands1"] = { BabbleFaction["The Scale of the Sands"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["ScaleSands2"] = { BabbleFaction["The Scale of the Sands"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["ScaleSands3"] = { BabbleFaction["The Scale of the Sands"], "AtlasLootBurningCrusade" };
  -- The Scryers
	AtlasLoot_TableNames["Scryer1"] = { BabbleFaction["The Scryers"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["Scryer2"] = { BabbleFaction["The Scryers"], "AtlasLootBurningCrusade" };
  -- The Sha'tar
	AtlasLoot_TableNames["Shatar1"] = { BabbleFaction["The Sha'tar"], "AtlasLootBurningCrusade" };
  -- Exalted with Cenarion Expedition, The Sha'tar and The Aldor/Scryers
	AtlasLoot_TableNames["ShattrathFlasks1"] = { "Shattrath Flasks", "AtlasLootBurningCrusade" };
  -- Sha'tari Skyguard
	AtlasLoot_TableNames["Skyguard1"] = { BabbleFaction["Sha'tari Skyguard"], "AtlasLootBurningCrusade" };
  -- Shattered Sun Offensive
	AtlasLoot_TableNames["SunOffensive1"] = { BabbleFaction["Shattered Sun Offensive"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["SunOffensive2"] = { BabbleFaction["Shattered Sun Offensive"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["SunOffensive3"] = { BabbleFaction["Shattered Sun Offensive"], "AtlasLootBurningCrusade" };
  -- Sporeggar
	AtlasLoot_TableNames["Sporeggar1"] = { BabbleFaction["Sporeggar"], "AtlasLootBurningCrusade" };
  -- Thrallmar
	AtlasLoot_TableNames["Thrallmar1"] = { BabbleFaction["Thrallmar"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["Thrallmar2"] = { BabbleFaction["Thrallmar"], "AtlasLootBurningCrusade" };
  -- Tranquillien
	AtlasLoot_TableNames["Tranquillien1"] = { BabbleFaction["Tranquillien"], "AtlasLootBurningCrusade" };
  -- The Violet Eye
	AtlasLoot_TableNames["VioletEye1"] = { BabbleFaction["The Violet Eye"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["VioletEye2"] = { BabbleFaction["The Violet Eye"], "AtlasLootBurningCrusade" };

----------------------
--- WotLK Factions ---
----------------------

  -- Alliance Vanguard
	AtlasLoot_TableNames["AllianceVanguard1"] = { BabbleFaction["Alliance Vanguard"], "AtlasLootWotLK" };
  -- Argent Crusade
	AtlasLoot_TableNames["ArgentCrusade"] = { BabbleFaction["Argent Crusade"], "AtlasLootWotLK" };
  -- Frenzyheart Tribe
	AtlasLoot_TableNames["FrenzyheartTribe"] = { BabbleFaction["Frenzyheart Tribe"], "AtlasLootWotLK" };
  -- The Horde Expedition
	AtlasLoot_TableNames["HordeExpedition1"] = { BabbleFaction["Horde Expedition"], "AtlasLootWotLK" };
  -- Kirin Tor
	AtlasLoot_TableNames["KirinTor"] = { BabbleFaction["Kirin Tor"], "AtlasLootWotLK" };
  -- Knights of the Ebon Blade
	AtlasLoot_TableNames["KnightsoftheEbonBlade"] = { BabbleFaction["Knights of the Ebon Blade"], "AtlasLootWotLK" };
  -- The Kalu'ak
	AtlasLoot_TableNames["TheKaluak"] = { BabbleFaction["The Kalu'ak"], "AtlasLootWotLK" };
  -- The Oracles
	AtlasLoot_TableNames["TheOracles"] = { BabbleFaction["The Oracles"], "AtlasLootWotLK" };
  -- The Sons of Hodir
	AtlasLoot_TableNames["TheSonsofHodir1"] = { BabbleFaction["The Sons of Hodir"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["TheSonsofHodir2"] = { BabbleFaction["The Sons of Hodir"], "AtlasLootWotLK" };
  -- Winterfin Retreat
	AtlasLoot_TableNames["WinterfinRetreat"] = { BabbleFaction["Winterfin Retreat"], "AtlasLootWotLK" };
  --The Wyrmrest Accord
	AtlasLoot_TableNames["TheWyrmrestAccord"] = { BabbleFaction["The Wyrmrest Accord"], "AtlasLootWotLK" };
  --The Ashen Verdict
	AtlasLoot_TableNames["AshenVerdict"] = { BabbleFaction["The Ashen Verdict"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["AshenVerdict2"] = { BabbleFaction["The Ashen Verdict"], "AtlasLootWotLK" };

--------------
--- Trades ---
--------------

  -- Alchemy
	AtlasLoot_TableNames["AlchemyBattleElixir1"] = { ALCHEMY..": "..AL["Battle Elixirs"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["AlchemyBattleElixir2"] = { ALCHEMY..": "..AL["Battle Elixirs"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["AlchemyGuardianElixir1"] = { ALCHEMY..": "..AL["Guardian Elixirs"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["AlchemyPotion1"] = { ALCHEMY..": "..AL["Potions"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["AlchemyPotion2"] = { ALCHEMY..": "..AL["Potions"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["AlchemyPotion3"] = { ALCHEMY..": "..AL["Potions"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["AlchemyTransmute1"] = { ALCHEMY..": "..AL["Transmutes"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["AlchemyTransmute2"] = { ALCHEMY..": "..AL["Transmutes"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["AlchemyFlask1"] = { ALCHEMY..": "..AL["Flasks"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["AlchemyMisc1"] = { ALCHEMY..": "..AL["Miscellaneous"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["AlchemyMisc2"] = { ALCHEMY..": "..AL["Miscellaneous"], "AtlasLootCrafting" };
  -- BlackSmithing
	AtlasLoot_TableNames["SmithingArmorOld1"] = { BLACKSMITHING..": "..BabbleInventory["Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["SmithingArmorOld2"] = { BLACKSMITHING..": "..BabbleInventory["Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["SmithingArmorOld3"] = { BLACKSMITHING..": "..BabbleInventory["Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["SmithingArmorOld4"] = { BLACKSMITHING..": "..BabbleInventory["Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["SmithingArmorOld5"] = { BLACKSMITHING..": "..BabbleInventory["Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["SmithingArmorBC1"] = { BLACKSMITHING..": "..BabbleInventory["Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["SmithingArmorBC2"] = { BLACKSMITHING..": "..BabbleInventory["Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["SmithingArmorBC3"] = { BLACKSMITHING..": "..BabbleInventory["Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["SmithingArmorWrath1"] = { BLACKSMITHING..": "..BabbleInventory["Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["SmithingArmorWrath2"] = { BLACKSMITHING..": "..BabbleInventory["Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["SmithingArmorWrath3"] = { BLACKSMITHING..": "..BabbleInventory["Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["SmithingArmorWrath4"] = { BLACKSMITHING..": "..BabbleInventory["Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["SmithingWeaponOld1"] = { BLACKSMITHING..": "..BabbleInventory["Weapon"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["SmithingWeaponOld2"] = { BLACKSMITHING..": "..BabbleInventory["Weapon"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["SmithingWeaponOld3"] = { BLACKSMITHING..": "..BabbleInventory["Weapon"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["SmithingWeaponBC1"] = { BLACKSMITHING..": "..BabbleInventory["Weapon"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["SmithingWeaponBC2"] = { BLACKSMITHING..": "..BabbleInventory["Weapon"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["SmithingWeaponWrath1"] = { BLACKSMITHING..": "..BabbleInventory["Weapon"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["SmithingEnhancement1"] = { BLACKSMITHING..": "..AL["Item Enhancements"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["SmithingEnhancement2"] = { BLACKSMITHING..": "..AL["Item Enhancements"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["SmithingMisc1"] = { BLACKSMITHING..": "..AL["Miscellaneous"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["Armorsmith1"] = { ARMORSMITH, "AtlasLootCrafting" };
	AtlasLoot_TableNames["Weaponsmith1"] = { WEAPONSMITH, "AtlasLootCrafting" };
	AtlasLoot_TableNames["Axesmith1"] = { AXESMITH, "AtlasLootCrafting" };
	AtlasLoot_TableNames["Hammersmith1"] = { HAMMERSMITH, "AtlasLootCrafting" };
	AtlasLoot_TableNames["Swordsmith1"] = { SWORDSMITH, "AtlasLootCrafting" };
  -- Enchanting
	AtlasLoot_TableNames["EnchantingBoots1"] = { ENCHANTING..": "..AL["Enchant Boots"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["EnchantingBracer1"] = { ENCHANTING..": "..AL["Enchant Bracer"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["EnchantingBracer2"] = { ENCHANTING..": "..AL["Enchant Bracer"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["EnchantingChest1"] = { ENCHANTING..": "..AL["Enchant Chest"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["EnchantingChest2"] = { ENCHANTING..": "..AL["Enchant Chest"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["EnchantingCloak1"] = { ENCHANTING..": "..AL["Enchant Cloak"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["EnchantingCloak2"] = { ENCHANTING..": "..AL["Enchant Cloak"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["EnchantingGloves1"] = { ENCHANTING..": "..AL["Enchant Gloves"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["EnchantingGloves2"] = { ENCHANTING..": "..AL["Enchant Gloves"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["EnchantingRing1"] = { ENCHANTING..": "..AL["Enchant Ring"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["EnchantingShield1"] = { ENCHANTING..": "..AL["Enchant Shield"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["Enchanting2HWeapon1"] = { ENCHANTING..": "..AL["Enchant 2H Weapon"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["EnchantingWeapon1"] = { ENCHANTING..": "..AL["Enchant Weapon"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["EnchantingWeapon2"] = { ENCHANTING..": "..AL["Enchant Weapon"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["EnchantingStaff1"] = { ENCHANTING..": "..BabbleInventory["Staff"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["EnchantingMisc1"] = { ENCHANTING..": "..AL["Miscellaneous"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["EnchantingMisc2"] = { ENCHANTING..": "..AL["Miscellaneous"], "AtlasLootCrafting" };
  -- Engineering
	AtlasLoot_TableNames["EngineeringAmmo1"] = { ENGINEERING..": "..AL["Ammunition"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["EngineeringArmor1"] = { ENGINEERING..": "..BabbleInventory["Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["EngineeringArmor2"] = { ENGINEERING..": "..BabbleInventory["Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["EngineeringArmor3"] = { ENGINEERING..": "..BabbleInventory["Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["EngineeringArmor4"] = { ENGINEERING..": "..BabbleInventory["Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["EngineeringExplosives1"] = { ENGINEERING..": "..AL["Explosives"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["EngineeringExplosives2"] = { ENGINEERING..": "..AL["Explosives"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["EngineeringItemEnhancements1"] = { ENGINEERING..": "..AL["Item Enhancements"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["EngineeringMisc1"] = { ENGINEERING..": "..AL["Miscellaneous"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["EngineeringMisc2"] = { ENGINEERING..": "..AL["Miscellaneous"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["EngineeringMisc3"] = { ENGINEERING..": "..AL["Miscellaneous"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["EngineeringReagents1"] = { ENGINEERING..": "..AL["Reagents"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["EngineeringReagents2"] = { ENGINEERING..": "..AL["Reagents"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["EngineeringWeapon1"] = { ENGINEERING..": "..BabbleInventory["Weapon"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["Gnomish1"] = { GNOMISH, "AtlasLootCrafting" };
	AtlasLoot_TableNames["Goblin1"] = { GOBLIN, "AtlasLootCrafting" };
  -- Inscription
	AtlasLoot_TableNames["Inscription_OffHand1"] = { INSCRIPTION..": "..AL["Off-Hand Items"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["Inscription_Reagents1"] = { INSCRIPTION..": "..AL["Reagents"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["Inscription_Scrolls1"] = { INSCRIPTION..": "..AL["Scrolls"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["Inscription_Scrolls2"] = { INSCRIPTION..": "..AL["Scrolls"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["Inscription_Misc1"] = { INSCRIPTION..": "..AL["Miscellaneous"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["Inscription_DeathKnightMajor1"] = { INSCRIPTION..": "..AL["Major Glyph"].." - "..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["Inscription_DeathKnightMinor1"] = { INSCRIPTION..": "..AL["Minor Glyph"].." - "..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["Inscription_DruidMajor1"] = { INSCRIPTION..": "..AL["Major Glyph"].." - "..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["Inscription_DruidMinor1"] = { INSCRIPTION..": "..AL["Minor Glyph"].." - "..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["Inscription_HunterMajor1"] = { INSCRIPTION..": "..AL["Major Glyph"].." - "..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["Inscription_HunterMinor1"] = { INSCRIPTION..": "..AL["Minor Glyph"].." - "..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["Inscription_MageMajor1"] = { INSCRIPTION..": "..AL["Major Glyph"].." - "..LOCALIZED_CLASS_NAMES_MALE["MAGE"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["Inscription_MageMinor1"] = { INSCRIPTION..": "..AL["Minor Glyph"].." - "..LOCALIZED_CLASS_NAMES_MALE["MAGE"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["Inscription_PaladinMajor1"] = { INSCRIPTION..": "..AL["Major Glyph"].." - "..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["Inscription_PaladinMinor1"] = { INSCRIPTION..": "..AL["Minor Glyph"].." - "..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["Inscription_PriestMajor1"] = { INSCRIPTION..": "..AL["Major Glyph"].." - "..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["Inscription_PriestMinor1"] = { INSCRIPTION..": "..AL["Minor Glyph"].." - "..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["Inscription_RogueMajor1"] = { INSCRIPTION..": "..AL["Major Glyph"].." - "..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["Inscription_RogueMinor1"] = { INSCRIPTION..": "..AL["Minor Glyph"].." - "..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["Inscription_ShamanMajor1"] = { INSCRIPTION..": "..AL["Major Glyph"].." - "..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["Inscription_ShamanMinor1"] = { INSCRIPTION..": "..AL["Minor Glyph"].." - "..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["Inscription_WarlockMajor1"] = { INSCRIPTION..": "..AL["Major Glyph"].." - "..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["Inscription_WarlockMinor1"] = { INSCRIPTION..": "..AL["Minor Glyph"].." - "..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["Inscription_WarriorMajor1"] = { INSCRIPTION..": "..AL["Major Glyph"].." - "..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["Inscription_WarriorMinor1"] = { INSCRIPTION..": "..AL["Minor Glyph"].." - "..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "AtlasLootCrafting" };
  -- Jewelcrafting
	AtlasLoot_TableNames["JewelRed1"] = { JEWELCRAFTING..": "..BabbleInventory["Red"].." "..BabbleInventory["Gem"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["JewelRed2"] = { JEWELCRAFTING..": "..BabbleInventory["Red"].." "..BabbleInventory["Gem"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["JewelBlue1"] = { JEWELCRAFTING..": "..BabbleInventory["Blue"].." "..BabbleInventory["Gem"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["JewelYellow1"] = { JEWELCRAFTING..": "..BabbleInventory["Yellow"].." "..BabbleInventory["Gem"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["JewelYellow2"] = { JEWELCRAFTING..": "..BabbleInventory["Yellow"].." "..BabbleInventory["Gem"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["JewelGreen1"] = { JEWELCRAFTING..": "..BabbleInventory["Green"].." "..BabbleInventory["Gem"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["JewelGreen2"] = { JEWELCRAFTING..": "..BabbleInventory["Green"].." "..BabbleInventory["Gem"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["JewelGreen3"] = { JEWELCRAFTING..": "..BabbleInventory["Green"].." "..BabbleInventory["Gem"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["JewelOrange1"] = { JEWELCRAFTING..": "..BabbleInventory["Orange"].." "..BabbleInventory["Gem"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["JewelOrange2"] = { JEWELCRAFTING..": "..BabbleInventory["Orange"].." "..BabbleInventory["Gem"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["JewelOrange3"] = { JEWELCRAFTING..": "..BabbleInventory["Orange"].." "..BabbleInventory["Gem"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["JewelPurple1"] = { JEWELCRAFTING..": "..BabbleInventory["Purple"].." "..BabbleInventory["Gem"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["JewelPurple2"] = { JEWELCRAFTING..": "..BabbleInventory["Purple"].." "..BabbleInventory["Gem"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["JewelPurple3"] = { JEWELCRAFTING..": "..BabbleInventory["Purple"].." "..BabbleInventory["Gem"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["JewelMeta1"] = { JEWELCRAFTING..": "..BabbleInventory["Meta"].." "..BabbleInventory["Gem"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["JewelMeta2"] = { JEWELCRAFTING..": "..BabbleInventory["Meta"].." "..BabbleInventory["Gem"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["JewelDragonsEye1"] = { JEWELCRAFTING..": "..AL["Dragon's Eye"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["JewelPrismatic1"] = { JEWELCRAFTING..": "..BabbleInventory["Prismatic"].." "..BabbleInventory["Gem"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["JewelTrinket1"] = { JEWELCRAFTING..": "..BabbleInventory["Trinket"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["JewelRing1"] = { JEWELCRAFTING..": "..BabbleInventory["Ring"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["JewelRing2"] = { JEWELCRAFTING..": "..BabbleInventory["Ring"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["JewelRing3"] = { JEWELCRAFTING..": "..BabbleInventory["Ring"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["JewelNeck1"] = { JEWELCRAFTING..": "..BabbleInventory["Neck"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["JewelNeck2"] = { JEWELCRAFTING..": "..BabbleInventory["Neck"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["JewelMisc1"] = { JEWELCRAFTING..": "..AL["Miscellaneous"], "AtlasLootCrafting" };
  -- Leatherworking
	AtlasLoot_TableNames["LeatherLeatherArmorOld1"] = { LEATHERWORKING..": "..AL["Leather Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherLeatherArmorOld2"] = { LEATHERWORKING..": "..AL["Leather Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherLeatherArmorOld3"] = { LEATHERWORKING..": "..AL["Leather Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherLeatherArmorOld4"] = { LEATHERWORKING..": "..AL["Leather Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherLeatherArmorOld5"] = { LEATHERWORKING..": "..AL["Leather Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherLeatherArmorOld6"] = { LEATHERWORKING..": "..AL["Leather Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherLeatherArmorBC1"] = { LEATHERWORKING..": "..AL["Leather Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherLeatherArmorBC2"] = { LEATHERWORKING..": "..AL["Leather Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherLeatherArmorWrath1"] = { LEATHERWORKING..": "..AL["Leather Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherLeatherArmorWrath2"] = { LEATHERWORKING..": "..AL["Leather Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherLeatherArmorWrath3"] = { LEATHERWORKING..": "..AL["Leather Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherMailArmorOld1"] = { LEATHERWORKING..": "..AL["Mail Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherMailArmorOld2"] = { LEATHERWORKING..": "..AL["Mail Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherMailArmorBC1"] = { LEATHERWORKING..": "..AL["Mail Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherMailArmorBC2"] = { LEATHERWORKING..": "..AL["Mail Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherMailArmorWrath1"] = { LEATHERWORKING..": "..AL["Mail Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherMailArmorWrath2"] = { LEATHERWORKING..": "..AL["Mail Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherMailArmorWrath3"] = { LEATHERWORKING..": "..AL["Mail Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherCloaks1"] = { LEATHERWORKING..": "..AL["Cloaks"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherItemEnhancement1"] = { LEATHERWORKING..": "..AL["Item Enhancements"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherItemEnhancement2"] = { LEATHERWORKING..": "..AL["Item Enhancements"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherQuiversPouches1"] = { LEATHERWORKING..": "..AL["Quivers and Ammo Pouches"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherDrumsBagsMisc1"] = { LEATHERWORKING..": "..AL["Drums, Bags and Misc."], "AtlasLootCrafting" };
	AtlasLoot_TableNames["LeatherLeather1"] = { LEATHERWORKING..": "..BabbleInventory["Leather"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["Dragonscale1"] = { DRAGONSCALE, "AtlasLootCrafting" };
	AtlasLoot_TableNames["Elemental1"] = { ELEMENTAL, "AtlasLootCrafting" };
	AtlasLoot_TableNames["Tribal1"] = { TRIBAL, "AtlasLootCrafting" };
  -- Mining
	AtlasLoot_TableNames["Mining1"] = { MINING, "AtlasLootCrafting" };
  -- Tailoring
	AtlasLoot_TableNames["TailoringArmorOld1"] = { TAILORING..": "..AL["Cloth Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringArmorOld2"] = { TAILORING..": "..AL["Cloth Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringArmorOld3"] = { TAILORING..": "..AL["Cloth Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringArmorOld4"] = { TAILORING..": "..AL["Cloth Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringArmorOld5"] = { TAILORING..": "..AL["Cloth Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringArmorOld6"] = { TAILORING..": "..AL["Cloth Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringArmorOld7"] = { TAILORING..": "..AL["Cloth Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringArmorBC1"] = { TAILORING..": "..AL["Cloth Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringArmorBC2"] = { TAILORING..": "..AL["Cloth Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringArmorBC3"] = { TAILORING..": "..AL["Cloth Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringArmorWotLK1"] = { TAILORING..": "..AL["Cloth Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringArmorWotLK2"] = { TAILORING..": "..AL["Cloth Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringArmorWotLK3"] = { TAILORING..": "..AL["Cloth Armor"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringBags1"] = { TAILORING..": "..AL["Bags"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringBags2"] = { TAILORING..": "..AL["Bags"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringMisc1"] = { TAILORING..": "..AL["Miscellaneous"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringMisc2"] = { TAILORING..": "..AL["Miscellaneous"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["TailoringShirts1"] = { TAILORING..": "..AL["Shirts"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["Mooncloth1"] = { MOONCLOTH, "AtlasLootCrafting" };
	AtlasLoot_TableNames["Shadoweave1"] = { SHADOWEAVE, "AtlasLootCrafting" };
	AtlasLoot_TableNames["Spellfire1"] = { SPELLFIRE, "AtlasLootCrafting" };
  -- Cooking
	AtlasLoot_TableNames["Cooking1"] = { COOKING, "AtlasLootCrafting" };
	AtlasLoot_TableNames["Cooking2"] = { COOKING, "AtlasLootCrafting" };
	AtlasLoot_TableNames["Cooking3"] = { COOKING, "AtlasLootCrafting" };
	AtlasLoot_TableNames["Cooking4"] = { COOKING, "AtlasLootCrafting" };
	AtlasLoot_TableNames["Cooking5"] = { COOKING, "AtlasLootCrafting" };
	AtlasLoot_TableNames["Cooking6"] = { COOKING, "AtlasLootCrafting" };
  -- First Aid
	AtlasLoot_TableNames["FirstAid1"] = { FIRSTAID, "AtlasLootCrafting" };
  -- Daily
	AtlasLoot_TableNames["CookingDaily1"] = { AL["Cooking Daily"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["CookingDaily2"] = { AL["Cooking Daily"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["FishingDaily1"] = { AL["Fishing Daily"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["FishingDaily2"] = { AL["Fishing Daily"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["JewelcraftingDaily1"] = { AL["Jewelcrafting Daily"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["JewelcraftingDaily2"] = { AL["Jewelcrafting Daily"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["JewelcraftingDaily3"] = { AL["Jewelcrafting Daily"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["JewelcraftingDaily4"] = { AL["Jewelcrafting Daily"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["JewelcraftingDaily5"] = { AL["Jewelcrafting Daily"], "AtlasLootCrafting" };
	AtlasLoot_TableNames["JewelcraftingDaily6"] = { AL["Jewelcrafting Daily"], "AtlasLootCrafting" };

-----------
--- PvP ---
-----------

  -- Battlegrounds
   -- Alterac Valley
	AtlasLoot_TableNames["AVMisc"] = { BabbleZone["Alterac Valley"].." "..AL["Misc. Rewards"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["AVBlue_A"] = { BabbleZone["Alterac Valley"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["AVBlue_H"] = { BabbleZone["Alterac Valley"], "AtlasLootOriginalWoW" };
   -- Arathi Basin
	AtlasLoot_TableNames["ABMisc_A"] = { BabbleZone["Arathi Basin"].." "..AL["Misc. Rewards"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["AB2039_A"] = { BabbleZone["Arathi Basin"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["AB4049_A"] = { BabbleZone["Arathi Basin"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["ABMisc_H"] = { BabbleZone["Arathi Basin"].." "..AL["Misc. Rewards"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["AB2039_H"] = { BabbleZone["Arathi Basin"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["AB4049_H"] = { BabbleZone["Arathi Basin"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["ABSets1_A"] = { BabbleZone["Arathi Basin"].." "..AL["PvP Armor Sets"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["ABSets2_A"] = { BabbleZone["Arathi Basin"].." "..AL["PvP Armor Sets"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["ABSets1_H"] = { BabbleZone["Arathi Basin"].." "..AL["PvP Armor Sets"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["ABSets2_H"] = { BabbleZone["Arathi Basin"].." "..AL["PvP Armor Sets"], "AtlasLootOriginalWoW" };
   -- Warsong Gulch
	AtlasLoot_TableNames["WSGMisc"] = { BabbleZone["Warsong Gulch"].." "..AL["Misc. Rewards"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["WSGAccessories_A"] = { BabbleZone["Warsong Gulch"].." "..AL["Accessories"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["WSGWeapons_A"] = { BabbleZone["Warsong Gulch"].." "..AL["Weapons"], "AtlasLootOriginalWoW" };  
	AtlasLoot_TableNames["WSGArmor_A"] = { BabbleZone["Warsong Gulch"].." "..BabbleInventory["Armor"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["WSGAccessories_H"] = { BabbleZone["Warsong Gulch"].." "..AL["Accessories"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["WSGWeapons_H"] = { BabbleZone["Warsong Gulch"].." "..AL["Weapons"], "AtlasLootOriginalWoW" };  
	AtlasLoot_TableNames["WSGArmor_H"] = { BabbleZone["Warsong Gulch"].." "..BabbleInventory["Armor"], "AtlasLootOriginalWoW" };  
  -- World PvP
	AtlasLoot_TableNames["Hellfire"] = { BabbleZone["Hellfire Peninsula"]..": "..AL["Hellfire Fortifications"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["Nagrand1"] = { BabbleZone["Nagrand"]..": "..AL["Halaa"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["Nagrand2"] = { BabbleZone["Nagrand"]..": "..AL["Halaa"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["Terokkar"] = { BabbleZone["Terokkar Forest"]..": "..AL["Spirit Towers"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["Zangarmarsh"] = { BabbleZone["Zangarmarsh"]..": "..AL["Twin Spire Ruins"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["LakeWintergrasp1"] = { BabbleZone["Wintergrasp"].." - "..AL["Accessories"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["LakeWintergrasp2"] = { BabbleZone["Wintergrasp"].." - "..BabbleInventory["Cloth"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["LakeWintergrasp3"] = { BabbleZone["Wintergrasp"].." - "..BabbleInventory["Leather"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["LakeWintergrasp4"] = { BabbleZone["Wintergrasp"].." - "..BabbleInventory["Mail"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["LakeWintergrasp5"] = { BabbleZone["Wintergrasp"].." - "..BabbleInventory["Plate"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["LakeWintergrasp6"] = { BabbleZone["Wintergrasp"].." - "..AL["PVP Gems/Enchants/Jewelcrafting Designs"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["LakeWintergrasp7"] = { BabbleZone["Wintergrasp"].." - "..AL["Heirloom"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["VentureBay1"] = { BabbleZone["Grizzly Hills"]..": "..AL["Venture Bay"], "AtlasLootWotLK" };
  -- Misc Other PvP
	AtlasLoot_TableNames["PvP60Accessories1_A"] = { AL["PvP Accessories (Level 60)"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["PvP60Accessories2_A"] = { AL["PvP Accessories (Level 60)"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["PvP60Accessories1_H"] = { AL["PvP Accessories (Level 60)"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["PvP60Accessories2_H"] = { AL["PvP Accessories (Level 60)"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["PvP70Accessories2"] = { AL["PvP Accessories (Level 70)"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["PvP70Accessories1_A"] = { AL["PvP Accessories (Level 70)"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["PvP70Accessories1_H"] = { AL["PvP Accessories (Level 70)"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["PvP70Accessories2"] = { AL["PvP Accessories (Level 70)"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["PvP80Misc"] = { AL["PvP Misc"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PvP70NonSet1"] = { AL["PvP Non-Set Epics"]..": "..BabbleInventory["Cloth"].."/"..BabbleInventory["Leather"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["PvP70NonSet2"] = { AL["PvP Non-Set Epics"]..": "..BabbleInventory["Mail"].."/"..BabbleInventory["Plate"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["PvP80NonSet1"] = { AL["PvP Non-Set Epics"]..": "..AL["Accessories"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PvP80NonSet2"] = { AL["PvP Non-Set Epics"]..": "..AL["Accessories"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PvP80NonSet3"] = { AL["PvP Non-Set Epics"]..": "..BabbleInventory["Cloth"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PvP80NonSet4"] = { AL["PvP Non-Set Epics"]..": "..BabbleInventory["Leather"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PvP80NonSet5"] = { AL["PvP Non-Set Epics"]..": "..BabbleInventory["Mail"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PvP80NonSet6"] = { AL["PvP Non-Set Epics"]..": "..BabbleInventory["Plate"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PVPWeapons_A"] = { AL["PvP Weapons (Level 60)"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["PVPWeapons_H"] = { AL["PvP Weapons (Level 60)"], "AtlasLootOriginalWoW" };
	AtlasLoot_TableNames["PvP80ClassItems1"] = { AL["PvP Class Items"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["PvP80ClassItems2"] = { AL["PvP Class Items"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["WrathfulGladiatorWeapons1"] = { AL["Wrathful Gladiator\'s Weapons"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["WrathfulGladiatorWeapons2"] = { AL["Wrathful Gladiator\'s Weapons"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["WrathfulGladiatorWeapons3"] = { AL["Wrathful Gladiator\'s Weapons"], "AtlasLootWotLK" };
	AtlasLoot_TableNames["Arena4Weapons1"] = { AL["Arena Season 4 Weapons"], "AtlasLootBurningCrusade" };
	AtlasLoot_TableNames["Arena4Weapons2"] = { AL["Arena Season 4 Weapons"], "AtlasLootBurningCrusade" };

-------------
--- Other ---
-------------

  -- Menus, the entry does nothing, but makes the generalised loot table code less complex
	AtlasLoot_TableNames["ARENASET"] = { AL["PvP Armor Sets"]..": "..AL["Level 70"], "Menu" };
	AtlasLoot_TableNames["SETSMISCMENU"] = { AL["Misc Sets"], "Menu" };
	AtlasLoot_TableNames["SETSCLASSIC"] = { AL["Classic Sets"], "Menu" };
	AtlasLoot_TableNames["SETSBURNINGCURSADE"] = { AL["Burning Crusade Sets"], "Menu" };
	AtlasLoot_TableNames["SETSWRATHOFLICHKING"] = { AL["Wrath Of The Lich King Sets"], "Menu" };
	AtlasLoot_TableNames["CRAFTSET1"] = { AL["Crafted Sets"].." : "..BLACKSMITHING, "Menu" };
	AtlasLoot_TableNames["CRAFTSET2"] = { AL["Crafted Sets"].." : "..LEATHERWORKING, "Menu" };
	AtlasLoot_TableNames["CRAFTSET3"] = { AL["Crafted Sets"].." : "..LEATHERWORKING, "Menu" };
	AtlasLoot_TableNames["CRAFTSET4"] = { AL["Crafted Sets"].." : "..TAILORING, "Menu" };
	AtlasLoot_TableNames["T0SET"] = { AL["Dungeon 1/2 Sets"], "Menu" };
	AtlasLoot_TableNames["DS3SET"] = { AL["Dungeon 3 Sets"], "Menu" };
	AtlasLoot_TableNames["T1T2T3SET"] = { AL["Tier 1/2/3 Sets"], "Menu" };
	AtlasLoot_TableNames["T3SET"] = { AL["Tier 3 Sets"], "Menu" };
	AtlasLoot_TableNames["T456SET"] = { AL["Tier 4/5/6 Sets"], "Menu" };
	AtlasLoot_TableNames["T7T8SET"] = { AL["Tier 7/8 Sets"], "Menu" };
	AtlasLoot_TableNames["T9SET"] = { AL["Tier 9 Sets"], "Menu" };
	AtlasLoot_TableNames["T10SET"] = { AL["Tier 10 Sets"], "Menu" };
	AtlasLoot_TableNames["REPMENU_ORIGINALWOW"] = { AL["Factions - Original WoW"], "Menu" };
	AtlasLoot_TableNames["REPMENU_BURNINGCRUSADE"] = { AL["Factions - Burning Crusade"], "Menu" };
	AtlasLoot_TableNames["REPMENU_WOTLK"] = { AL["Factions - Wrath of the Lich King"], "Menu" };
	AtlasLoot_TableNames["REPMENU"] = { AL["Factions"], "Menu" };
	AtlasLoot_TableNames["SETMENU"] = { AL["Collections"], "Menu" };
	AtlasLoot_TableNames["MOUNTMENU"] = { AL["Mounts"], "Menu" };
	AtlasLoot_TableNames["PETMENU"] = { AL["Vanity Pets"], "Menu" };
	AtlasLoot_TableNames["PVPSET"] = { AL["PvP Armor Sets"]..": "..AL["Level 60"], "Menu" };
	AtlasLoot_TableNames["PVPMENU"] = { AL["PvP Rewards"], "Menu" };
	AtlasLoot_TableNames["PVPMENU2"] = { AL["PvP Rewards"], "Menu" };
	AtlasLoot_TableNames["WINTERGRASPMENU"] = { BabbleZone["Wintergrasp"], "Menu" };
	AtlasLoot_TableNames["PVP70RepSET"] = { AL["PvP Reputation Sets"]..": "..AL["Level 70"], "Menu" };
	AtlasLoot_TableNames["PVP80NONSETEPICS"] = { AL["PvP Non-Set Epics"], "Menu" };
	AtlasLoot_TableNames["LEVEL80PVPSETS"] = { AL["PvP Armor Sets"]..": "..AL["Level 80"], "Menu" };
	AtlasLoot_TableNames["70TOKENMENU"] = { AL["Badge of Justice Rewards"], "Menu" };
	AtlasLoot_TableNames["EMBLEMOFHEROISMMENU"] = { AL["Emblem of Heroism Rewards"], "Menu" };
	AtlasLoot_TableNames["EMBLEMOFVALORMENU"] = { AL["Emblem of Valor Rewards"], "Menu" };
	AtlasLoot_TableNames["EMBLEMOFTRIUMPHMENU"] = { AL["Emblem of Triumph Rewards"], "Menu" };
	AtlasLoot_TableNames["EMBLEMOFCONQUESTMENU"] = { AL["Emblem of Conquest Rewards"], "Menu" };
	AtlasLoot_TableNames["EMBLEMOFFROSTMENU"] = { AL["Emblem of Frost Rewards"], "Menu" };
	AtlasLoot_TableNames["WORLDEPICS"] = { AL["BoE World Epics"], "Menu" };
	AtlasLoot_TableNames["WORLDEVENTMENU"] = { AL["World Events"], "Menu" };
	AtlasLoot_TableNames["ABYSSALMENU"] = { AL["Abyssal Council"], "Menu" };
	AtlasLoot_TableNames["ARGENTMENU"] = { AL["Argent Tournament"], "Menu" };
	AtlasLoot_TableNames["DARKMOONMENU"] = { BabbleFaction["Darkmoon Faire"], "Menu" };
	AtlasLoot_TableNames["ETHEREUMMENU"] = { AL["Ethereum Prison"], "Menu" };
	AtlasLoot_TableNames["SKETTISMENU"] = { AL["Skettis"], "Menu" };
	AtlasLoot_TableNames["CRAFTINGMENU"] = { AL["Crafting"], "Menu" };
	AtlasLoot_TableNames["ALCHEMYMENU"] = { ALCHEMY, "Menu" };
	AtlasLoot_TableNames["SMITHINGMENU"] = { BLACKSMITHING, "Menu" };
	AtlasLoot_TableNames["ENCHANTINGMENU"] = { ENCHANTING, "Menu" };
	AtlasLoot_TableNames["ENGINEERINGMENU"] = { ENGINEERING, "Menu" };
	AtlasLoot_TableNames["INSCRIPTIONMENU"] = { INSCRIPTION, "Menu" };
	AtlasLoot_TableNames["JEWELCRAFTINGMENU"] = { JEWELCRAFTING, "Menu" };
	AtlasLoot_TableNames["LEATHERWORKINGMENU"] = { LEATHERWORKING, "Menu" };
	AtlasLoot_TableNames["TAILORINGMENU"] = { TAILORING, "Menu" };
	AtlasLoot_TableNames["COOKINGDAILYMENU"] = { AL["Cooking Daily"], "Menu" };
	AtlasLoot_TableNames["FISHINGDAILYMENU"] = { AL["Fishing Daily"], "Menu" };
	AtlasLoot_TableNames["JEWELCRAFTINGDAILYMENU"] = { AL["Jewelcrafting Daily"], "Menu" };
	AtlasLoot_TableNames["WishList"] = { AL["Wishlist"], "AtlasLootCharDB" };
	AtlasLoot_TableNames["SearchResult"] = { AL["Wishlist"], "AtlasLootCharDB" };
  -- If all else fails!
	AtlasLoot_TableNames["EmptyTable"] = { AL["Select a Loot Table..."], "Menu" };
	AtlasLoot_TableNames["EmptyInstance"] = { "AtlasLoot", "AtlasLootFallback" };
	AtlasLoot_TableNames["AtlasLootFallback"] = { "AtlasLoot", "AtlasLootFallback" };