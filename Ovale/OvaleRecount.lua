local Recount = Recount
local RL 
if Recount then
	RL = LibStub("AceLocale-3.0"):GetLocale("Recount")
end

local function DataModes(self,data, num)
	if not data then return 0, 0 end
	local fight = data.Fights[Recount.db.profile.CurDataSet]
	local score
	if fight and fight.Ovale and fight.OvaleMax then
		score = fight.Ovale*1000/fight.OvaleMax
	else
		score = 0
	end
	if num == 1 then
		return score
	end
	return score, nil
end

local function TooltipFuncs(self,name,data)
	local SortedData,total
	GameTooltip:ClearLines()
	GameTooltip:AddLine(name)
	-- Recount:AddSortedTooltipData(RL["Top 3"].." Ovale",data and data.Fights[Recount.db.profile.CurDataSet] and data.Fights[Recount.db.profile.CurDataSet].Ovale,3)
	-- GameTooltip:AddLine("<"..RL["Click for more Details"]..">",0,0.9,0)
end

if Recount then
	Recount:AddModeTooltip("Ovale",DataModes,TooltipFuncs,nil,nil,nil,nil)
end