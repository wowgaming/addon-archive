local CL = LibStub("AceAddon-3.0"):GetAddon("ClassLoot")
local LC = LOCALIZED_CLASS_NAMES_MALE
local BTT = LibStub("LibBabble-TalentTree-3.0"):GetLookupTable()
local L = LibStub("AceLocale-3.0"):GetLocale("ClassLoot", true)

local oneSpec = "%s (%s)"

CL.CC = {
	-- General Constants
	["Slash-Commands"] = { "classloot", "cl" },

	-- Classic Class Keys
	["WarriorTanking"] = oneSpec:format(LC["WARRIOR"], BTT["Protection"]),
	["WarriorDPS"] = oneSpec:format(LC["WARRIOR"], L["DPS"]),
	["Rogue"] = LC["ROGUE"],
	["Hunter"] = LC["HUNTER"],
	["DruidFeral"] = oneSpec:format(LC["DRUID"], BTT["Feral Combat"]),
	["DruidHealing"] = oneSpec:format(LC["DRUID"], BTT["Restoration"]),
	["Mage"] = LC["MAGE"],
	["Priest"] = LC["PRIEST"],
	["Warlock"] = LC["WARLOCK"],
	["PaladinDPS"] = oneSpec:format(LC["PALADIN"], L["DPS"]),
	["PaladinHealing"] = oneSpec:format(LC["PALADIN"], BTT["Holy"]),
	["ShamanDPS"] = oneSpec:format(LC["SHAMAN"], L["DPS"]),
	["ShamanHealing"] = oneSpec:format(LC["SHAMAN"], BTT["Restoration"]),
	
	-- BC Class Keys
	["WarriorProt"] = oneSpec:format(LC["WARRIOR"], BTT["Protection"]),
	["WarriorArms"] = oneSpec:format(LC["WARRIOR"], BTT["Arms"]),
	["WarriorFury"] = oneSpec:format(LC["WARRIOR"], BTT["Fury"]),
	["PaladinHoly"] = oneSpec:format(LC["PALADIN"], BTT["Holy"]),
	["PaladinProt"] = oneSpec:format(LC["PALADIN"], BTT["Protection"]),
	["PaladinRet"] = oneSpec:format(LC["PALADIN"], BTT["Retribution"]),
	["ShamanElemental"] = oneSpec:format(LC["SHAMAN"], BTT["Elemental"]),
	["ShamanEnhance"] = oneSpec:format(LC["SHAMAN"], BTT["Enhancement"]),
	["ShamanResto"] = oneSpec:format(LC["SHAMAN"], BTT["Restoration"]),
	["DruidBalance"] = oneSpec:format(LC["DRUID"], BTT["Balance"]),
	["DruidResto"] = oneSpec:format(LC["DRUID"], BTT["Restoration"]),
	["PriestDPS"] = oneSpec:format(LC["PRIEST"], L["DPS"]),
	["PriestHeal"] = oneSpec:format(LC["PRIEST"], BTT["Holy"]),
	
	--Northrend Class Keys
	["DeathknightTank"] = oneSpec:format(LC["DEATHKNIGHT"], L["Tank"]),
	["DeathknightDPS"] = oneSpec:format(LC["DEATHKNIGHT"], L["DPS"]),
	
	-- Bosses that aren't bosses!
	["Dust Covered Chest"] = "Chess Event",
	["Cache of the Firelord"] = "Majordomo Executus",
	["Four Horsemen Chest"] = "The Four Horsemen",
	["Ashli's Bag"] = "Timed Event",
	["Harkor's Satchel"] = "Timed Event",
	["Kraz's Package"] = "Timed Event",
	["Tanzar's Trunk"] = "Timed Event",
	["Alexstrasza's Gift"] = "Malygos",
	["Cache of Living Stone"] = "Kologarn",
	["Cache of Innovation"] = "Mimiron",
	["Cache of Winter"] = "Hodir",
	["Rare Cache of Winter"] = "Hodir",
	["Cache of Storms"] = "Thorim",
	["Freya's Gift"] = "Freya",
	["Gift of the Observer"] = "Algalon the Observer",
	["Champions' Cache"] = "Faction Champions",
	["Argent Crusade Tribute Chest"] = "Anub'arak",
	["Gunship Armory"] = "Icecrown Gunship Battle",
	["Deathbringer's Cache"] = "Deathbringer Saurfang",
	["Prince Valanar"] = "Blood Prince Council",
}
