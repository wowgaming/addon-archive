--Obviously Thanks to Recount!


if not Recount then return end

local GearScore_Recount = LibStub("AceAddon-3.0"):NewAddon("GearScore_Recount", "AceEvent-3.0", "AceTimer-3.0","AceConsole-3.0")





------------------------------Recount Mode--------------------------------------


function GearScore_Recount:DataModesGearScore(data, num)
	if not data then return 0,0 end
	MyVariable = data
	TempName = data.unit
	local damage, dps = Recount:MergedPetDamageDPS(data,Recount.db.profile.CurDataSet);
	local hps = (data.Fights[Recount.db.profile.CurDataSet].Healing or 0)/((data.Fights[Recount.db.profile.CurDataSet].ActiveTime or 0) + 0);
	hps = (floor(hps*10)/10)
	dps = (floor(dps*10)/10)
	local ttps = ""
	if ( hps > dps ) then 
		tps = hps
		ttps = "HPS - "
	else 
		tps = dps;
		ttps = "DPS - " 
	end
	

	if num==1 then
		if ( GS_Data[GetRealmName()].Players[TempName] ) then return GS_Data[GetRealmName()].Players[TempName].GearScore, (ttps..tostring(tps)); else return 0; end
	end
		if ( GS_Data[GetRealmName()].Players[TempName] ) then return GS_Data[GetRealmName()].Players[TempName].GearScore, (ttps..tostring(tps)); else return 0; end
end



function GearScore_Recount:DataModesPerformanceGearScore(data, num)
	if not data then return 0,0 end
	TempName = data.unit
	local damage, dps = Recount:MergedPetDamageDPS(data,Recount.db.profile.CurDataSet);
--	local hps = (data.Fights[Recount.db.profile.CurDataSet].Healing or 0)/((data.Fights[Recount.db.profile.CurDataSet].ActiveTime or 0) + 0);
--	hps = (floor(hps*10)/10); dps = (floor(dps*10)/10)
	local GearScore = 0
	if ( GS_Data[GetRealmName()].Players[TempName] ) then GearScore = GS_Data[GetRealmName()].Players[TempName].GearScore or 0; end

--	if num==1 then
--			if ( GearScore > 0  ) then return floor(dps * 100 / GearScore), (dps.." DPS / "..GearScore.." GS"); else return 0; end
--	end
			if ( GearScore > 0  ) then return floor(dps * 100 / GearScore), (floor(dps).." DPS / "..GearScore.." GS"); else return 0; end
end

function GearScore_Recount:DataModesHealingDoneGearScore(data, num)
	if not data then return 0,0 end
	local TempName = data.unit; local GearScore = 0
--	local damage, dps = Recount:MergedPetDamageDPS(data,Recount.db.profile.CurDataSet);
	local healing = data.Fights[Recount.db.profile.CurDataSet].Healing or 0
	if ( GS_Data[GetRealmName()].Players[TempName] ) then GearScore = GS_Data[GetRealmName()].Players[TempName].GearScore or 0; end

--	if num==1 then if ( GearScore > 0  ) then return floor(healing / GearScore), (healing.." Healing / "..GearScore.." GS"); else return 0; end; end
	if ( GearScore > 0  ) then return floor(healing / GearScore), (healing.." Healing / "..GearScore.." GS"); else return 0; end
end

function GearScore_Recount:DataModesDamageDoneGearScore(data, num)
	if not data then return 0,0 end
	local TempName = data.unit; local GearScore = 0
	local damage, dps = Recount:MergedPetDamageDPS(data,Recount.db.profile.CurDataSet);

	if ( GS_Data[GetRealmName()].Players[TempName] ) then GearScore = GS_Data[GetRealmName()].Players[TempName].GearScore or 0; end

--	if num==1 then if ( GearScore > 0  ) then return floor(damage / GearScore), (damage.." Damage / "..GearScore.." GS"); else return 0; end; end
	if ( GearScore > 0  ) then return floor(damage / GearScore), (damage.." Damage / "..GearScore.." GS"); else return 0; end
end

function GearScore_Recount:TooltipFuncsGearScore(name,data)
	GameTooltip:ClearLines()
	GameTooltip:AddLine(name)
	local GS_Target = data.unit

	local damage, dps = Recount:MergedPetDamageDPS(data,Recount.db.profile.CurDataSet);
	local hps = (data.Fights[Recount.db.profile.CurDataSet].Healing or 0)/((data.Fights[Recount.db.profile.CurDataSet].ActiveTime or 0) + 0);

	local GS_GearScore = GS_Data[GetRealmName()].Players[GS_Target].GearScore
	if not ( GS_GearScore ) then GS_GearScore = 0; end
	local GS_QualityRed, GS_QualityBlue, GS_QualityGreen, GS_QualityDescription = GearScore_GetQuality(GS_GearScore)
	GameTooltip:AddLine("GearScore: "..GS_GearScore, GS_QualityRed, GS_QualityGreen, GS_QualityBlue)

	if hps > dps then
		GameTooltip:AddLine( "Healing Performance / GearScore: ".. (floor((hps * 100) / GS_GearScore)) )
	else
		GameTooltip:AddLine( "Damage Performance / GearScore: ".. (floor((dps * 100) / GS_GearScore)) )
	end

	if ( GS_Data[GetRealmName()].Players[GS_Target] ) then GearScore_SetDetails(GameTooltip, GS_Target); end
end



--Recount:AddModeTooltip("GearScore",GearScore_Recount.DataModesGearScore,GearScore_Recount.TooltipFuncsGearScore,"GearScore","GearScore", "GearScore", "GearScore")
Recount:AddModeTooltip("Damage / GearScore",GearScore_Recount.DataModesDamageDoneGearScore,GearScore_Recount.TooltipFuncsGearScore,"GearScore","GearScore", "GearScore", "GearScore")
Recount:AddModeTooltip("Healing / GearScore",GearScore_Recount.DataModesHealingDoneGearScore,GearScore_Recount.TooltipFuncsGearScore,"GearScore","GearScore", "GearScore", "GearScore")
Recount:AddModeTooltip("Performance(DPS) / GearScore",GearScore_Recount.DataModesPerformanceGearScore,GearScore_Recount.TooltipFuncsGearScore,"GearScore","GearScore", "GearScore", "GearScore")

