-- Recount's PowerGains (Mana, Rage, Energy, RunicPower) Tracker Module.
-- This can be deleted/renamed (to say TrackerModule_*_off.lua) to remove the mode

local AceLocale = LibStub("AceLocale-3.0")
local L = AceLocale:GetLocale( "Recount" )

local revision = tonumber(string.sub("$Revision: 1079 $", 12, -3))
local Recount = _G.Recount
if Recount.Version < revision then Recount.Version = revision end

local dbCombatants
local srcRetention 
local dstRetention 

local DetailTitles={}
DetailTitles.Gained={
	TopNames = L["Ability"],
	TopCount = "",
	TopAmount = L["Gained"],
	BotNames = L["From"],
	BotMin = "",
	BotAvg = "",
	BotMax = "",
	BotAmount = L["Gained"]
}

DetailTitles.GainedFrom={
	TopNames = L["From"],
	TopCount = "",
	TopAmount = L["Gained"],
	BotNames = L["Ability"],
	BotMin = "",
	BotAvg = "",
	BotMax = "",
	BotAmount = L["Gained"]
}



local POWERTYPE_MANA = 0
local POWERTYPE_RAGE = 1
local POWERTYPE_FOCUS = 2
local POWERTYPE_ENERGY = 3
local POWERTYPE_HAPPINESS = 4;
local POWERTYPE_RUNES = 5;
local POWERTYPE_RUNIC_POWER = 6;

local PowerTypeName = { -- Elsia: Do NOT localize this, it breaks functionality!!! If you need this localized contact me on WowAce or Curse.
	[POWERTYPE_MANA] = "Mana",
	[POWERTYPE_RAGE] = "Rage",
	[POWERTYPE_ENERGY] = "Energy",
	[POWERTYPE_FOCUS] = "Focus",
	[POWERTYPE_HAPPINESS] = "Happiness",
	[POWERTYPE_RUNES] = "Runes",
	[POWERTYPE_RUNIC_POWER] = "Runic Power",	
}

function Recount:SpellEnergize(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, amount, powerType)

	Recount:AddGain(dstName, srcName, spellName, amount, PowerTypeName[powerType], dstGUID, dstFlags, srcGUID, srcFlags, spellId)
end

function Recount:SpellLeech(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, amount, powerType, extraAmount)
	Recount:AddGain(srcName, dstName, spellName, extraAmount, PowerTypeName[powerType], srcGUID, srcFlags, dstGUID, dstFlags, spellId)
end

local DataAmount, DataTable, DataTable2
function Recount:AddGain(source, victim, ability, amount, attribute,srcGUID,srcFlags,dstGUID,dstFlags,spellId)

	if attribute=="Mana" then
		DataAmount="ManaGain"
		DataTable="ManaGained"
		DataTable2="ManaGainedFrom"
	elseif attribute=="Energy" or attribute=="Focus" then -- Elsia: Focus for pet.
		DataAmount="EnergyGain"
		DataTable="EnergyGained"
		DataTable2="EnergyGainedFrom"
	elseif attribute=="Rage" then
		DataAmount="RageGain"
		DataTable="RageGained"
		DataTable2="RageGainedFrom"
	elseif attribute=="Runic Power" then
		DataAmount="RunicPowerGain"
		DataTable="RunicPowerGained"
		DataTable2="RunicPowerGainedFrom"
	else
		return
	end

	-- Name and ID of pet owners
	local sourceowner
	local sourceownerID
	local victimowner
	local victimownerID

	source, sourceowner, sourceownerID = Recount:DetectPet(source, srcGUID, srcFlags)
	victim, victimowner, victimownerID = Recount:DetectPet(victim, dstGUID, dstFlags)

	srcRetention = Recount.srcRetention
	if srcRetention then

	   if not dbCombatants[source] then
	      Recount:AddCombatant(source,sourceowner,srcGUID,srcFlags,sourceownerID)
	   end -- Elsia: Until here is if pets heal anybody.
	   local sourceData=dbCombatants[source]
	   Recount:SetActive(sourceData)

	   Recount:AddAmount(sourceData,DataAmount,amount)
	   Recount:AddTableDataSum(sourceData,DataTable,ability,victim,amount)
	   Recount:AddTableDataSum(sourceData,DataTable2,victim,ability,amount)
	end
end

local DataModes={}

function DataModes:ManaGained(data, num)
	if not data then return 0 end
	if num==1 then
		return (data.Fights[Recount.db.profile.CurDataSet].ManaGain or 0)
	end
	return (data.Fights[Recount.db.profile.CurDataSet].ManaGain or 0), {{data.Fights[Recount.db.profile.CurDataSet].ManaGained,L["'s Mana Gained"],DetailTitles.Gained},{data.Fights[Recount.db.profile.CurDataSet].ManaGainedFrom,L["'s Mana Gained From"],DetailTitles.GainedFrom}}
end

function DataModes:EnergyGained(data, num)
	if not data then return 0 end
	if num==1 then
		return (data.Fights[Recount.db.profile.CurDataSet].EnergyGain or 0)
	end
	return (data.Fights[Recount.db.profile.CurDataSet].EnergyGain or 0), {{data.Fights[Recount.db.profile.CurDataSet].EnergyGained,L["'s Energy Gained"],DetailTitles.Gained},{data.Fights[Recount.db.profile.CurDataSet].EnergyGainedFrom,L["'s Energy Gained From"],DetailTitles.GainedFrom}}
end

function DataModes:RageGained(data, num)
	if not data then return 0 end
	if num==1 then
		return (data.Fights[Recount.db.profile.CurDataSet].RageGain or 0)
	end
	return (data.Fights[Recount.db.profile.CurDataSet].RageGain or 0), {{data.Fights[Recount.db.profile.CurDataSet].RageGained,L["'s Rage Gained"],DetailTitles.Gained},{data.Fights[Recount.db.profile.CurDataSet].RageGainedFrom,L["'s Rage Gained From"],DetailTitles.GainedFrom}}
end

function DataModes:RunicPowerGained(data, num)
	if not data then return 0 end
	if num==1 then
		return (data.Fights[Recount.db.profile.CurDataSet].RunicPowerGain or 0)
	end
	return (data.Fights[Recount.db.profile.CurDataSet].RunicPowerGain or 0), {{data.Fights[Recount.db.profile.CurDataSet].RunicPowerGained,L["'s RunicPower Gained"],DetailTitles.Gained},{data.Fights[Recount.db.profile.CurDataSet].RunicPowerGainedFrom,L["'s RunicPower Gained From"],DetailTitles.GainedFrom}}
end

local TooltipFuncs={}

function TooltipFuncs:ManaGained(name,data)
	local SortedData,total
	GameTooltip:ClearLines()
	GameTooltip:AddLine(name)
	Recount:AddSortedTooltipData(L["Top 3"].." "..L["Mana Abilities"],data and data.Fights[Recount.db.profile.CurDataSet] and data.Fights[Recount.db.profile.CurDataSet].ManaGained,3)
	Recount:AddSortedTooltipData(L["Top 3"].." "..L["Mana Sources"],data and data.Fights[Recount.db.profile.CurDataSet] and data.Fights[Recount.db.profile.CurDataSet].ManaGainedFrom,3)
	GameTooltip:AddLine("<"..L["Click for more Details"]..">",0,0.9,0)
end

function TooltipFuncs:EnergyGained(name,data)
	local SortedData,total
	GameTooltip:ClearLines()
	GameTooltip:AddLine(name)
	Recount:AddSortedTooltipData(L["Top 3"].." "..L["Energy Abilities"],data and data.Fights[Recount.db.profile.CurDataSet] and data.Fights[Recount.db.profile.CurDataSet].EnergyGained,3)
	Recount:AddSortedTooltipData(L["Top 3"].." "..L["Energy Sources"],data and data.Fights[Recount.db.profile.CurDataSet] and data.Fights[Recount.db.profile.CurDataSet].EnergyGainedFrom,3)
	GameTooltip:AddLine("<"..L["Click for more Details"]..">",0,0.9,0)
end

function TooltipFuncs:RageGained(name,data)
	local SortedData,total
	GameTooltip:ClearLines()
	GameTooltip:AddLine(name)
	Recount:AddSortedTooltipData(L["Top 3"].." "..L["Rage Abilities"],data and data.Fights[Recount.db.profile.CurDataSet] and data.Fights[Recount.db.profile.CurDataSet].RageGained,3)
	Recount:AddSortedTooltipData(L["Top 3"].." "..L["Rage Sources"],data and data.Fights[Recount.db.profile.CurDataSet] and data.Fights[Recount.db.profile.CurDataSet].RageGainedFrom,3)
	GameTooltip:AddLine("<"..L["Click for more Details"]..">",0,0.9,0)

end

function TooltipFuncs:RunicPowerGained(name,data)
	local SortedData,total
	GameTooltip:ClearLines()
	GameTooltip:AddLine(name)
	Recount:AddSortedTooltipData(L["Top 3"].." "..L["RunicPower Abilities"],data and data.Fights[Recount.db.profile.CurDataSet] and data.Fights[Recount.db.profile.CurDataSet].RunicPowerGained,3)
	Recount:AddSortedTooltipData(L["Top 3"].." "..L["RunicPower Sources"],data and data.Fights[Recount.db.profile.CurDataSet] and data.Fights[Recount.db.profile.CurDataSet].RunicPowerGainedFrom,3)
	GameTooltip:AddLine("<"..L["Click for more Details"]..">",0,0.9,0)

end

Recount:AddModeTooltip(L["Mana Gained"],DataModes.ManaGained,TooltipFuncs.ManaGained)
Recount:AddModeTooltip(L["Energy Gained"],DataModes.EnergyGained,TooltipFuncs.EnergyGained)
Recount:AddModeTooltip(L["Rage Gained"],DataModes.RageGained,TooltipFuncs.RageGained)
Recount:AddModeTooltip(L["Runic Power Gained"],DataModes.RunicPowerGained,TooltipFuncs.RunicPowerGained)

local oldlocalizer = Recount.LocalizeCombatants
function Recount.LocalizeCombatants()
	dbCombatants = Recount.db2.combatants
	oldlocalizer()
end

