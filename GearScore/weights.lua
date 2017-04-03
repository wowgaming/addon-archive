--local AceLocale = LibStub("AceLocale-3.0")
--local L = AceLocale:GetLocale( "GearScore" )

function CalculateCustomWeightScore(ItemLink, Tooltip)
	local ItemName, ItemLink, ItemRarity, ItemLevel, ItemMinLevel, ItemType, ItemSubType, ItemStackCount, ItemEquipLoc, ItemTexture = GetItemInfo(ItemLink)
	local Class = "ShamanCustomWeights"
	local SumOfStats = 0
	local GS_TempBonuses = BonusScanner:ScanItem(ItemLink)
	local TotalDivisor = 0
	for j,w in ipairs(GearScoreClassSpecList[Class]) do
		TotalDivisor = 0
		SumOfStats = 0
		if ( GS_TempBonuses ) then 
			for i,v in pairs(GS_TempBonuses) do
				SumOfStats = SumOfStats + (GearScoreSpecWeights[Class][j][i] or 0 ) * v
				TotalDivisor = TotalDivisor + (GearScoreSpecWeights[Class][j][i] or 0)
			end
			SumOfStats = SumOfStats / GearScoreSpecWeights[Class][j]["Total"]
		end
		local Red, Green, Blue = GearScore_GetQuality(SumOfStats * 12.25 / GS_ItemTypes[ItemEquipLoc]["SlotMOD"])
		Tooltip:AddLine(w.." CustomScore: "..floor(SumOfStats), Red, Blue, Green)
	end
end

function ClassicGearScoreCalculations()
local Name = UnitName("target"); local Class, englishClass = UnitClass("target"); local SumOfStats = 0; local TempGearScore = 0; local BS_Bonuses = {}
for j = 1, 18 do
	if ( j ~= 13 ) and ( j ~= 14 ) and ( j < 15 ) and ( GetInventoryItemLink("target", j) ) then
		local ItemName, ItemLink, ItemRarity, ItemLevel, ItemMinLevel, ItemType, ItemSubType, ItemStackCount, ItemEquipLoc, ItemTexture = GetItemInfo(GetInventoryItemLink("target", j))
		if ( ItemLink ) then
		print("ItemNumber:", j)
			local GS_TempBonuses = BonusScanner:ScanItem(ItemLink)
    		if GS_TempBonuses then
				for i,v in pairs(GS_TempBonuses) do
					GS_TempBonuses[i] = ( GS_TempBonuses[i] * (GearScoreClassStats[i] or 0 ) ) ^ 1.7095
					SumOfStats = SumOfStats + ((GearScoreSpecWeights[Class][3][i] or 0 ) * GS_TempBonuses[i])
					print(i, ((GearScoreSpecWeights[Class][3][i] or 0 ) * GS_TempBonuses[i])) 
				end
				SumOfStats = ((SumOfStats ^ ( 1/1.7095))) * 1.74
			end
		end
	TempGearScore = TempGearScore + SumOfStats		
	end		
end	
	print(TempGearScore)
end


function CalculateClasicItemScore_two(ItemLink, Tooltip, Red, Green, Blue)
	local ItemName, ItemLink, ItemRarity, ItemLevel, ItemMinLevel, ItemType, ItemSubType, ItemStackCount, ItemEquipLoc, ItemTexture = GetItemInfo(ItemLink)
	local Class, englishClass = UnitClass("player")
	local SumOfStats = 0
	local GS_TempBonuses = BonusScanner:ScanItem(ItemLink)
	for j,w in ipairs(GearScoreClassSpecList[Class]) do
	SumOfStats = 0
		if ( GS_TempBonuses ) then 
			for i,v in pairs(GS_TempBonuses) do
				SumOfStats = SumOfStats + ((GearScoreSpecWeights[Class][j][i] or 0 ) * (( v * (GearScoreClassStats[i] or 0 ) ) ^ 1.7095))
			end
			SumOfStats = ((SumOfStats ^ ( 1/1.7095))) * 1.74
		end
		local Red, Green, Blue = GearScore_GetQuality(SumOfStats * 12.25 / GS_ItemTypes[ItemEquipLoc]["SlotMOD"])
		Tooltip:AddLine(w.." SpecScore: "..floor(SumOfStats), Red, Blue, Green)
	end
end

function CalculateClasicItemScore(ItemLink, Tooltip, Red, Green, Blue)
		local Class, englishClass = GS_Settings["CurrentClassMouseoverItem"]; local ShowSpecScores = true
		if not Class then Class, englishClass = UnitClass("player"); Class = englishClass; ShowSpecScores = false; end; --if englishClass then Class = englishClass; end
		local ItemName, ItemLink, ItemRarity, ItemLevel, ItemMinLevel, ItemType, ItemSubType, ItemStackCount, ItemEquipLoc, ItemTexture = GetItemInfo(ItemLink)
		for j,w in ipairs(GearScoreClassSpecList[Class]) do
			if ( GS_Settings["ShowSpecScores"][GearScoreClassSpecList[Class][j]] == 1 ) or ( ShowSpecScores ) then
				local GearScore = Calculate_GearScoreClasicScore(ItemLink, Class, j)
				local Red, Green, Blue = GearScore_GetQuality(GearScore * 11.25 / GS_ItemTypes[ItemEquipLoc]["SlotMOD"])
				Tooltip:AddLine(w.." SpecScore: "..floor(GearScore), Red, Blue, Green)
			end
		end
end

function Calculate_GearScoreClasicScore(ItemLink, Class, Index)
	local ItemName, ItemLink, ItemRarity, ItemLevel, ItemMinLevel, ItemType, ItemSubType, ItemStackCount, ItemEquipLoc, ItemTexture = GetItemInfo(ItemLink)
	local GS_TempBonuses = BonusScanner:ScanItem(ItemLink)
	if ( ItemEquipLoc == "INVTYPE_TRINKET" ) or ( ItemEquipLoc == "INVTYPE_RELIC" ) or ( ItemEquipLoc == "INVTYPE_SHIELD" ) or ( ItemEquipLoc == "INVTYPE_HOLDABLE" ) then
		local SumOfNegativeStats = 0
		for i,v in pairs(GS_TempBonuses) do
			v = v * ( GearScoreClassStats[i] or 0 )
			SumOfNegativeStats = SumOfNegativeStats + ((v - (v * (GearScoreSpecWeights[Class][Index][i] or 0 )))^ 1.7095)
		end
		local GearScore = ( GearScore_GetItemScore(ItemLink) / 1.74 )
		GearScore = ((( GearScore ^ 1.7095 ) - SumOfNegativeStats )^(1/1.7095)) * 1.74
		return GearScore
	end
	if ( ItemEquipLoc == "INVTYPE_WEAPONMAINHAND" ) or ( ItemEquipLoc == "INVTYPE_WEAPONOFFHAND" ) or ( ItemEquipLoc == "INVTYPE_WEAPON" ) or ( ItemEquipLoc == "INVTYPE_2HWEAPON" ) then
		local SumOfNegativeStats = 0; local Table = {}; local ItemText = ""; local SumOfStats = 0; local HunterScore = 1
		if ( Class == "HUNTER" ) then HunterScore = 0.3164; end
		for i,v in pairs(GS_TempBonuses) do
			v = v * ( GearScoreClassStats[i] or 0 )
			SumOfNegativeStats  = SumOfNegativeStats + ((v - (v * (GearScoreSpecWeights[Class][Index][i] or 0 )))^ 1.7095)
		end
		local GearScore = ( GearScore_GetItemScore(ItemLink) / 1.74 )
		GearScore = ((( GearScore ^ 1.7095 ) - SumOfNegativeStats )^(1/1.7095)) * 1.74
		local found, _, ItemText = string.find(ItemLink, "^|c%x+|H(.+)|h%[.*%]");
		local StartPosition, EndPosition, FirstWord, RestOfString = string.find(ItemText, ":", 7)
		ItemText = "item:33430"..string.sub(ItemText, StartPosition)
		local ItemName, ItemLink, ItemRarity, ItemLevel, ItemMinLevel, ItemType, ItemSubType, ItemStackCount, ItemEquipLoc, ItemTexture = GetItemInfo(ItemText)
		GS_TempBonuses = BonusScanner:ScanItem(ItemLink) 
		if (GS_TempBonuses) then
			for i,v in pairs(GS_TempBonuses) do
			 	SumOfStats = SumOfStats + ((GearScoreSpecWeights[Class][Index][i] or 0 ) * (( v * (GearScoreClassStats[i] or 0 ) ) ^ 1.7095))
		 	end
		end
		GearScore = ((( (GearScore/1.74) ^ 1.7095 ) + SumOfStats )^(1/1.7095)) * 1.74
		if not ( GearScore > 0 ) then GearScore = 0; end
		return GearScore * HunterScore
	end	
	if ( ItemEquipLoc == "INVTYPE_RANGEDRIGHT" ) or ( ItemEquipLoc == "INVTYPE_RANGED" ) then
		local SumOfNegativeStats = 0; local Table = {}; local ItemText = ""; local SumOfStats = 0; local HunterScore = 1
		if ( Class == "HUNTER" ) then HunterScore =  5.3224; end
		for i,v in pairs(GS_TempBonuses) do
			v = v * ( GearScoreClassStats[i] or 0 )
			SumOfNegativeStats  = SumOfNegativeStats + ((v - (v * (GearScoreSpecWeights[Class][Index][i] or 0 )))^ 1.7095)
		end
		local GearScore = ( GearScore_GetItemScore(ItemLink) / 1.74 )
		GearScore = ((( GearScore ^ 1.7095 ) - SumOfNegativeStats )^(1/1.7095)) * 1.74
		local found, _, ItemText = string.find(ItemLink, "^|c%x+|H(.+)|h%[.*%]");
		local StartPosition, EndPosition, FirstWord, RestOfString = string.find(ItemText, ":", 7)
		ItemText = "item:4025"..string.sub(ItemText, StartPosition)
		local ItemName, ItemLink, ItemRarity, ItemLevel, ItemMinLevel, ItemType, ItemSubType, ItemStackCount, ItemEquipLoc, ItemTexture = GetItemInfo(ItemText)
		GS_TempBonuses = BonusScanner:ScanItem(ItemLink) 
		if (GS_TempBonuses) then
			for i,v in pairs(GS_TempBonuses) do
			 	SumOfStats = SumOfStats + ((GearScoreSpecWeights[Class][Index][i] or 0 ) * (( v * (GearScoreClassStats[i] or 0 ) ) ^ 1.7095))
		 	end
		end
		GearScore = ((( (GearScore/1.74) ^ 1.7095 ) + SumOfStats )^(1/1.7095)) * 1.74
		return GearScore * HunterScore
	end		
	if ( ItemEquipLoc ~= "Pie" ) then
		local SumOfStats = 0
		if (GS_TempBonuses) then
			for i,v in pairs(GS_TempBonuses) do
			 	SumOfStats = SumOfStats + ((GearScoreSpecWeights[Class][Index][i] or 0 ) * (( v * (GearScoreClassStats[i] or 0 ) ) ^ 1.7095))
		 	end
			SumOfStats = ((SumOfStats ^ ( 1/1.7095 ))) * 1.74
		end
		return SumOfStats
	end
	return 0
end



















function GearScoreClassScan(Name)

	GS_WeightsTips = {}
	PlayersSumBonuses = {}; local TotalStats = 0; local SumStats = 0; local FinalTable = {}; local SumTotalStats = 0; local TitanGrip = 0; local MissingEnchantTable = {}; 
	local MissingGemCount = 0; GS_MissingGemWeightsTips = nil; local TenStatCount = 0;
	local MetaGemMissing, RedGemMissing, BlueGemMissing, YellowGemMissing = 0,0,0,0
	if ( GS_Data[GetRealmName()].Players[Name] ) or LookAtCurrentTarget then
		if UnitName("target") == Name then
			for i = 1, 18 do
				local ItemSubStringTable = {}
			   	if ( i ~= 4 ) and ( GetInventoryItemLink("target", i) ) then
					local ItemName, ItemLink, ItemRarity, ItemLevel, ItemMinLevel, ItemType, ItemSubType, ItemStackCount, ItemEquipLoc, ItemTexture = GetItemInfo(GetInventoryItemLink("target", i))
					if ( ItemLink ) then
					
						MetaGemMissing, RedGemMissing, BlueGemMissing, YellowGemMissing = BonusScanner:GetEmptySockets(ItemLink)
						MissingGemCount = MissingGemCount + MetaGemMissing + RedGemMissing + BlueGemMissing + YellowGemMissing	
							
						if ( MetaGemMissing > 0 ) or ( BlueGemMissing > 0 ) or ( YellowGemMissing > 0 ) or ( RedGemMissing > 0 )then 
							if not GS_MissingGemWeightsTips then GS_MissingGemWeightsTips = {}; end
							GS_MissingGemWeightsTips[1] = {[1] = "Missing "..MissingGemCount.." gems.", [2] = " "}
							table.insert(GS_MissingGemWeightsTips, {[1] = "|cffffffff     "..string.sub(ItemEquipLoc, 9), [2]  = "|cffff0000-"..( MetaGemMissing + RedGemMissing + BlueGemMissing + YellowGemMissing ).."%" })
						end
						local found, _, ItemSubString = string.find(ItemLink, "^|c%x+|H(.+)|h%[.*%]");

						if string.find(ItemSubString, ":3879:") then TenStatCount = TenStatCount + 1; end
						if string.find(ItemSubString, ":3832:") then TenStatCount = TenStatCount + 1; end

						for v in string.gmatch(ItemSubString, "[^:]+") do tinsert(ItemSubStringTable, v); end
						ItemSubString = ItemSubStringTable[2]..":"..ItemSubStringTable[3], ItemSubStringTable[2]
						local StringStart, StringEnd = string.find(ItemSubString, ":") 
						ItemSubString = string.sub(ItemSubString, StringStart + 1)
			
						if ( ItemSubString == "0" ) and ( GS_ItemTypes[ItemEquipLoc]["Enchantable"] )then
							 table.insert(MissingEnchantTable, ItemEquipLoc)
						end
						local GS_TempBonuses = BonusScanner:ScanItem(ItemLink)
    					if GS_TempBonuses then
							for i,v in pairs(GS_TempBonuses) do
								if ( PlayersSumBonuses[i] ) then PlayersSumBonuses[i] = PlayersSumBonuses[i] + v else PlayersSumBonuses[i] = v; end
							end
						end
					end
				end
			end
		else
			for i = 1, 18 do
			   	if ( i ~= 4 ) and ( GS_Data[GetRealmName()].Players[Name].Equip[i] ) then
			        local SubLink = GS_Data[GetRealmName()].Players[Name].Equip[i]
		        	SubLink = (string.sub(SubLink, 1, (string.find(SubLink, ":")) - 1))
					local ItemName, ItemLink, ItemRarity, ItemLevel, ItemMinLevel, ItemType, ItemSubType, ItemStackCount, ItemEquipLoc, ItemTexture = GetItemInfo("item:"..SubLink)
					if ( ItemLink ) then
						local GS_TempBonuses = BonusScanner:ScanItem(ItemLink)
    					if GS_TempBonuses then
							for i,v in pairs(GS_TempBonuses) do
								if ( PlayersSumBonuses[i] ) then PlayersSumBonuses[i] = PlayersSumBonuses[i] + v else PlayersSumBonuses[i] = v; end
							end
						end
					end
				end
			end
		end
		
		--if ( UnitName("target") or " " ) == Name then end 		
 		local SumTotalStats = 0
		----------------------------
		GS_DatabaseFrame.tooltip = nil
		local tooltip = LibQTip:Acquire("GearScoreTooltip", 2, "RIGHT", "LEFT")
		tooltip:SetCallback("OnMouseUp", GearScore_DatabaseOnClick)
		GS_DatabaseFrame.tooltip = tooltip
		tooltip:SetPoint("TOPLEFT", GS_DisplayFrame, 30, -180)
		tooltip:SetPoint("TOPRIGHT", GS_DisplayFrame, -370, -180)
 	   	tooltip:SetFrameStrata("DIALOG")
		tooltip:SetAlpha(100)
		tooltip:SetScale(1)
 		-------------------------------
		for i,v in pairs(PlayersSumBonuses) do
			if PlayersSumBonuses[i] == 0 then PlayersSumBonuses[i] = nil; end
			if PlayersSumBonuses and not ( string.find(i, "DPS") ) then tooltip:AddLine("+"..PlayersSumBonuses[i], i); end
			if GearScoreClassStats[i] then PlayersSumBonuses[i] = PlayersSumBonuses[i] * GearScoreClassStats[i]; else PlayersSumBonuses[i] = nil; end
			if ( PlayersSumBonuses[i] ) then SumTotalStats = SumTotalStats + PlayersSumBonuses[i];end
		end
		tooltip:UpdateScrolling(180)
		tooltip:SetHeight(180)
		if not GS_ExPFrame:IsVisible() then tooltip:Show(); end
		

		
		
		GS_CalculateSpecScore_two(Name, GS_EnglishClasses[GS_Data[GetRealmName()].Players[Name].Class], PlayersSumBonuses, 0, SumTotalStats, MissingEnchantTable, MissingGemCount, TenStatCount);
		GS_CalculateSpecScore(Name, GS_EnglishClasses[GS_Data[GetRealmName()].Players[Name].Class], PlayersSumBonuses, 0, SumTotalStats);
		GS_MissingEnchantWeightsTips = nil
		
		if ( #MissingEnchantTable ) > 0 then 
			if not GS_MissingEnchantWeightsTips then GS_MissingEnchantWeightsTips = {}; end
			table.insert(GS_MissingEnchantWeightsTips, {[1] = " ", [2]  = " "}); 
			table.insert(GS_MissingEnchantWeightsTips, {[1] = "Missing "..#MissingEnchantTable.." enchantments:", [2]  = ""})
			for i,v in ipairs(MissingEnchantTable) do
				table.insert(GS_MissingEnchantWeightsTips, {[1] = "|cffffffff     "..string.sub(v, 9), [2]  = "|cffff0000"..( floor((-2 * ( GS_ItemTypes[v]["SlotMOD"] )) * 100) / 100 ).."%" });
			end
		end
	end
end


function GS_UpdateStatTip(PlayersSumBonuses)

end

function GS_CalculateSpecScore(Name, Class)
	local GearScore = 0
	for j,w in ipairs(GearScoreClassSpecList[Class]) do
		GearScore = 0
		for i = 1, 18 do 
			if ( GetInventoryItemLink("target", i) ) then
				local ItemName, ItemLink, ItemRarity, ItemLevel, ItemMinLevel, ItemType, ItemSubType, ItemStackCount, ItemEquipLoc, ItemTexture = GetItemInfo(GetInventoryItemLink("target", i))
				GearScore = GearScore + (Calculate_GearScoreClasicScore(ItemLink, Class, j) or 0 )
			end
		end
	GearScore = floor(GearScore)
	local OriginalGearScore = GS_Data[GetRealmName()].Players[Name].GearScore or GearScore
	if ( GS_Data[GetRealmName()].Players[Name] ) then local OriginalGearScore = GS_Data[GetRealmName()].Players[Name].GearScore; else local OriginalGearScore = 0; end
	local Percent = _G["GS_SpecBar"..j]:GetValue()
	local Red, Green, Blue = GearScore_GetQuality(GearScore)
	_G["GS_SpecBar"..j.."PercentText"]:SetText("|cff"..string.format("%02x%02x%02x", Red * 255, Blue * 255, Green * 255)..floor(OriginalGearScore * Percent / 100).." |r(".._G["GS_SpecBar"..j]:GetValue().."%)")
	_G["GS_SpecBar"..j.."GearSpecText"]:SetText(GearScoreClassSpecList[Class][j])

	end
end


function GS_CalculateSpecScore_two(Name, Class, OriginalBonuses, SpecSlot, TotalStats, MissingEnchantTable, MissingGemCount, TenStatCount)

	local SumStats = 0; --local ClassSpecWeights = nil; local GearScoreSubWeights = nil
	local SpecBonuses = OriginalBonuses; 




	local HitCap = 0
	 GS_SpecialWeightsTips = {}
	for i = 1, 4 do
if GearScoreSpecWeights[Class][i] then
    GS_WeightsTips[i] = {}; SpecSlot = i; SumStats = 0; 
    SpecBonuses = OriginalBonuses;
    
    --Method for Removing Extra +Ten Stat Gems/Enchants
		--local TotalTenStatCountReduction = ""; 
		for j,w in pairs( {"STA", "STR", "INT", "AGI", "SPI"} ) do
			if ( SpecBonuses[w] ) and not ( GearScoreSpecWeights[Class][i][w] )then 
				SpecBonuses[w] = SpecBonuses[w] - ( 10 * TenStatCount); 
				--TotalStats = TotalStats - ( 10 * TenStatCount);
				SumStats = SumStats + ( 11 * TenStatCount ); 
				if ( SpecBonuses[w] <= 0 ) then SpecBonuses[w] = nil; end
			end		
		end
	-----
    
    
	
	for j,w in pairs(SpecBonuses) do
    	if ( GearScoreSpecWeights[Class][i][j] ) then
    	    SumStats = SumStats + SpecBonuses[j] * ( GearScoreSpecWeights[Class][i][j] )
            table.insert(GS_WeightsTips[i], { [1] = GearScoreClassStatsTranslation[j] or j, [2] = ((1 * SpecBonuses[j] * ( GearScoreSpecWeights[Class][i][j] ))/TotalStats) } )
		else
			table.insert(GS_WeightsTips[i], { [1] = GearScoreClassStatsTranslation[j] or j, [2] = ((-1 * SpecBonuses[j])/TotalStats) } )
		end
	end
--	if ( Class ~= "DRUID" ) and ( GearScoreSpecWeights[Class][i]["DEFENSECAP"] ) then
--		if ( SpecBonuses["DEFENSE"] ) then
--		    if ( (SpecBonuses["DEFENSE"] / 4.92) < 140  ) then 
--		    	local CurrentDefense = (( SpecBonuses["DEFENSE"] / 4.92 ) + ((SpecBonuses["RESILIENCE"] or 0) * 0.3048780487804878048780487804878))
--		    	local PercentReduction = ((140 - ( CurrentDefense )) / 140) * 0.25
--		    	SumStats = SumStats - ( TotalStats * PercentReduction ) 
--		    	table.insert(GS_WeightsTips[i], { [1] = "UNDER DEFENSE CAP", [2] = -1 * PercentReduction } )
--		    end
--		else
--		    SumStats = SumStats * 0.75
--		    table.insert(GS_WeightsTips[i], { [1] = "UNDER DEFENSE CAP", [2] = -0.25 } )
--		end
--	end
--	if ( GearScoreSpecWeights[Class][i]["ABSOLUTEMINHIT"] ) then
--		if ( SpecBonuses["TOHIT"] ) then
--		    if ( SpecBonuses["TOHIT"]  < GearScoreSpecWeights[Class][i]["ABSOLUTEMINHIT"] ) then 
--				local PercentReduction = ((GearScoreSpecWeights[Class][i]["ABSOLUTEMINHIT"] - SpecBonuses["TOHIT"]) / GearScoreSpecWeights[Class][i]["CAPRATIO"]) / 100
--		    	SumStats = SumStats - ( PercentReduction * TotalStats )
--		    	table.insert(GS_WeightsTips[i], { [1] = "UNDER HIT CAP", [2] = -1 * PercentReduction } )
--		    end
--		else
--				local PercentReduction = ((GearScoreSpecWeights[Class][i]["ABSOLUTEMINHIT"]) / GearScoreSpecWeights[Class][i]["CAPRATIO"]) / 100
--		    	SumStats = SumStats - ( PercentReduction * TotalStats )
--		    	table.insert(GS_WeightsTips[i], { [1] = "UNDER HIT CAP", [2] = -1 * PercentReduction } )
--		end
--	end
if ( Class == "DEATHKNIGHT" ) or ( Class == "WARRIOR" ) or ( Class == "Rogue" ) or ( Class == "Shaman" ) then
 --Force Tanks to not use Duel Weilding,
	if ( GS_Data[GetRealmName()]["Players"][Name]["Equip"][17] ~= "0:0" ) and ( GearScoreSpecWeights[Class][i]["DUEL"] == 0 ) then
		local ItemName, ItemLink, ItemRarity, ItemLevel, ItemMinLevel, ItemType, ItemSubType, ItemStackCount, ItemEquipLoc, ItemTexture = GetItemInfo("item:"..GS_Data[GetRealmName()]["Players"][Name]["Equip"][17])
    	if ItemEquipLoc ~= "INVTYPE_SHIELD" then
    		SumStats = SumStats - GearScore_GetItemScore(ItemLink);
    		 table.insert(GS_WeightsTips[i], { [1] = "DUAL WEILDING", [2] = ((-1 * GearScore_GetItemScore(ItemLink))/TotalStats) } )
    	end
	end
	if ( GearScoreSpecWeights[Class][i]["DUEL"] == 1 ) and ( GS_Data[GetRealmName()]["Players"][Name]["Equip"][17] == "0:0" ) then
	    --print("
        local ItemName, ItemLink, ItemRarity, ItemLevel, ItemMinLevel, ItemType, ItemSubType, ItemStackCount, ItemEquipLoc, ItemTexture = GetItemInfo("item:"..GS_Data[GetRealmName()]["Players"][Name]["Equip"][16])
    	SumStats = SumStats - ( 0.5 * GearScore_GetItemScore(ItemLink))
    	table.insert(GS_WeightsTips[i], { [1] = "NOT DUAL WEILDING", [2] = ((-1 * ( 0.5 * GearScore_GetItemScore(ItemLink)))/TotalStats) } )
    	--print("RemovingStats for not wearing DuelWeild")
	end
end

if ( Class == "WARRIOR" ) and ( SuperTotallyFakeVariable2 ) then
 --Forces Fury Warriors to Dual Weild and Arms / Tanks not to.
	if ( GS_Data[GetRealmName()]["Players"][Name]["Equip"][17] ~= "0:0" ) and ( GearScoreSpecWeights[Class][i]["DUEL"] == 0 ) then
		local ItemName, ItemLink, ItemRarity, ItemLevel, ItemMinLevel, ItemType, ItemSubType, ItemStackCount, ItemEquipLoc, ItemTexture = GetItemInfo("item:"..GS_Data[GetRealmName()]["Players"][Name]["Equip"][17])
    	SumStats = SumStats - GearScore_GetItemScore(ItemLink);
    	table.insert(GS_WeightsTips[i], { [1] = "DUAL WEIlDING", [2] = ((-1 * GearScore_GetItemScore(ItemLink))/TotalStats) } )
	end
	if ( GearScoreSpecWeights[Class][i]["DUEL"] == 1 ) and ( GS_Data[GetRealmName()]["Players"][Name]["Equip"][17] == "0:0" ) then
	    --print("
        local ItemName, ItemLink, ItemRarity, ItemLevel, ItemMinLevel, ItemType, ItemSubType, ItemStackCount, ItemEquipLoc, ItemTexture = GetItemInfo("item:"..GS_Data[GetRealmName()]["Players"][Name]["Equip"][16])
    	SumStats = SumStats - ( 0.5 * GearScore_GetItemScore(ItemLink))
    	table.insert(GS_WeightsTips[i], { [1] = "NOT DUAL WEILDING", [2] = ((-1 * ( 0.5 * GearScore_GetItemScore(ItemLink)))/TotalStats) } )
    	--print("RemovingStats for not wearing DuelWeild")
	end
end

	if ( #MissingEnchantTable ) > 0 then 
		for i,v in ipairs(MissingEnchantTable) do
			SumStats = SumStats - ( GS_ItemTypes[v]["SlotMOD"] * 0.02 * TotalStats)
		end
	end
	
	if MissingGemCount > 0 then
		SumStats = SumStats - (MissingGemCount * 0.01 * TotalStats)
	end
	
	if SumStats <= 0 then SumStats = 0; end
	if SumStats == (1/0) then SumStats = 0; end
	local Percent = SumStats/TotalStats
	
	------------------------------------------
	
	local ClassGearScore = floor( ( ( GS_Data[GetRealmName()].Players[Name].GearScore ) * ( Percent )  ) + 0.5 )
	_G["GS_SpecBar"..SpecSlot]:SetValue(floor((Percent + 0.005) * 100 )); _G["GS_SpecBar"..SpecSlot]:Show()
	local Red, Green, Blue = GearScore_GetQuality(ClassGearScore)
	_G["GS_SpecBar"..SpecSlot.."PercentText"]:SetText("|cff"..string.format("%02x%02x%02x", Red * 255, Blue * 255, Green * 255)..ClassGearScore.." |r("..floor((Percent + 0.005) * 100 ).."%)")
	_G["GS_SpecBar"..SpecSlot.."GearSpecText"]:SetText(GearScoreClassSpecList[Class][SpecSlot])

	if ( GearScoreSpecWeights[Class][i]["HITCAP"] ) then
			GS_SpecialWeightsTips[i] =  GearScoreSpecWeights[Class][i]["HITCAP"] 
			local indexname = "|CFFF0F0FF"..Name.."'s Hit Rating (From Gear):"
			GS_SpecialWeightsTips[i][2] =  { [indexname] = "|CFFFFFFFF"..((floor(((SpecBonuses["TOHIT"] or 0 ) / GearScoreSpecWeights[Class][i]["CAPRATIO"])* 100)) / 100 ).."%" }
	end

	if ( GearScoreSpecWeights[Class][i]["DEFENSECAP"] ) then
			GS_SpecialWeightsTips[i] =  GearScoreSpecWeights[Class][i]["DEFENSECAP"] 
			if ( GS_SpecialWeightsTips[i][3]["Resilience (Stat)"] ) then GS_SpecialWeightsTips[i][3]["Resilience (Stat)"] = "+"..floor( ( (SpecBonuses["RESILIENCE"] or 0) / 82 ) * 25 ); end
			local indexname = "|CFFF0F0FF"..Name.."'s Defense Skill (From Gear):"
			GS_SpecialWeightsTips[i][2] =  { [indexname] = "|CFFFFFFFF +"..( 0 + floor(((SpecBonuses["DEFENSE"] or 0 ) / 4.92 ) or 0) ) }		
	end

else
 _G["GS_SpecBar"..i]:Hide()
end
	
end


end

GearScoreClassSpecList = {
	["SHAMAN"] = {[1] = "Elemental",[2] = "Enhancement",[3] = "Restoration",},
	["ShamanCustomWeights"] = {[1] = "Elemental",[2] = "Enhancement",[3] = "Restoration",},
	["MAGE"] = {[1] = "Arcane",[3] = "Frost",[2] = "Fire",},
	["ROGUE"] = {[1] = "Combat",[2] = "Assassination",[3] = "Subtlety",},
	["HUNTER"] = {[1] = "Marksmanship",[2] = "Beast Mastery",[3] = "Survival",},
	["DRUID"] = {[1] = "Balance",[2] = "Feral (DPS)",[3] = "Feral (Tank)",[4] = "Restoration",},
	["WARLOCK"] = {[1] = "Affliction",[2] = "Demonology",[3] = "Destruction",},
	["WARRIOR"] = {[1] = "Arms",[2] = "Fury",[3] = "Protection",},
	["DEATHKNIGHT"] = {[1] = "Blood (DPS)",[2] = "Unholy (DPS)",[3] = "Frost (DPS)",[4] = "Tanking",},
	["PRIEST"] = {[1] = "Discipline",[2] = "Holy",[3] = "Shadow",},
	["PALADIN"] = {[1] = "Holy",[2] = "Protection",[3] = "Retribution",},
}

GearScoreSpecWeights = {
	["PALADIN"] = {
		[1] = {--Holy
			["HASTE"] = 1,
			["SPELLPOW"] = 1,
			["CRIT"] = 1,
			["INT"] = 1,
			["ATTACKPOWER"] = 0,
			["BLOCKVALUE"] = 1,
			["MANAREG"] = 1,
			["SPI"] = 1,
			["STA"] = 1,
		},
		[2] = {--Protection
			["DEFENSE"] = 1,
			["DEFENSECAP"] = { [1] = { ["Minimum Bonus Defense Skill"] = "+140" }, [3] = { ["Resilience (Stat)"] = "XXX" } },
			["STR"] = 1,
			["AGI"] = 1,
			["BLOCK"] = 1,
			["DODGE"] = 1,
			["STA"] = 1,
			["PARRY"] = 1,
			["EXPERTISE"] = 1,
			["BLOCKVALUE"] = 1,
			["TOHIT"] = 1,
			["ATTACKPOWER"] = 1,
			["CRIT"] = 1,
			["SPELLPOW"] = 1,
			["STA"] = 1,
			["SPI"] = 1
		},
		[3] = {
			["STR"] = 1,
			["SPI"] = 1,
			["CRIT"] = 1,
			["ARMORPEN"] = 1,
			["AGI"] = 1,
			["TOHIT"] = 1,
			["EXPERTISE"] = 1,
			["HASTE"] = 1,
			["ATTACKPOWER"] = 1,
			["SPELLPOW"] = 1,
			["TOHITMIN"] = 263,
			["HITCAP"] = {[1] = { ["Minimum Hit Rating"] = "8.00%" }, [3] = { ["Draenei's Heroic Presence (Racial)"] = "+1.00%" } },
			["ABSOLUTEMINHIT"] = 229.53,
			["CAPRATIO"] = 32.79,
			["STA"] = 1,
		},
	},
	["DRUID"] = {
		[1] = {--Balance
			["TOHIT"] = 1,
			["SPELLPOW"] = 1,
			["HASTE"] = 1,
			["CRIT"] = 1,
			["SPI"] = 1,
			["MANAREG"] = 1,
			["INT"] = 1,
			["ATTACKPOWER"] = 0,
			["HITCAP"] = {[1] = { ["Required Hit Rating"] = "17.00%" }, [3] = { ["Balance of Power (Talent)"] = "+4.00%" }, [4] = { ["Improved Faerie Fire (Talent + Spell)"] = "+3.00%" }, [5] = { ["Draenei's Heroic Presence (Racial)"] = "+1.00%" } },
			["ABSOLUTEMINHIT"] = 236.07,
			["CAPRATIO"] = 26.23,
			["OVERHITCAP"] = 1,
			["STA"] = 1,
		},
		[2] = {--Feral (DPS)
			["STR"] = 1,
			["AGI"] = 1,
			["EXPERTISE"] = 1,
			["TOHIT"] = 1,
			["CRIT"] = 1,
			["ATTACKPOWER"] = 1,
			["ARMORPEN"] = 1,
			["HASTE"] = 1,
			["SPELLPOW"] = 0,
			["HITCAP"] = {[1] = { ["Minimum Hit Rating"] = "8.00%" }, [3] = { ["Draenei's Heroic Presence (Racial)"] = "+1.00%" } },
			["ABSOLUTEMINHIT"] = 229.53,
			["CAPRATIO"] = 32.79,
			["OVERHITCAP"] = 0,
			["STA"] = 1,
		},
		[3] = {--Feral (Tank)
			["STR"] = 1,
			["AGI"] = 1,
			["EXPERTISE"] = 1,
			["TOHIT"] = 1,
			["CRIT"] = 1,
			["ATTACKPOWER"] = 1,
			["DODGE"] = 1,
			["DEFENSECAP"] = { [1] = { ["Minimum Bonus Defense Skill"] = "+140" }, [3] = { ["Resilience (Stat)"] = "XXX" }, [4] = { ["Survival of the Fittest (Talent)"] = "+150" } },	
			["DEFENSE"] = 1,
			["ARMORPEN"] = 1,
			["HASTE"] = 1,
			["SPELLPOW"] = 0,
			["STA"] = 1,
		},
		[4] = {--Restoration
			["SPELLPOW"] = 1,
			["HASTE"] = 1,
			["CRIT"] = 1,
			["SPI"] = 1,
			["MANAREG"] = 1,
			["INT"] = 1,
			["ATTACKPOWER"] = 0,
			["STA"] = 1,
		},
	},
	["DEATHKNIGHT"] = {
		[1] = {--Blood
			["TOHIT"] = 1,
			["SPELLPOW"] = 0,
			["HASTE"] = 1,
			["ATTACKPOWER"] = 1,
			["ARMORPEN"] = 1,
			["CRIT"] = 1,
			["EXPERTISE"] = 1,
			["STR"] = 1,
			["HITCAP"] = {[1] = { ["Minimum Hit Rating"] = "8.00%" }, [3] = { ["Draenei's Heroic Presence (Racial)"] = "+1.00%" } },
			["ABSOLUTEMINHIT"] = 229.53,
			["CAPRATIO"] = 32.79,
			["DUEL"] = 0,
			["AGI"] = 1,
			["OVERHITCAP"] = 1,
			["STA"] = 1,
		},
		[2] = {--Unholy
			["TOHIT"] = 1,
			["SPELLPOW"] = 0,
			["HASTE"] = 1,
			["ATTACKPOWER"] = 1,
			["ARMORPEN"] = 1,
			["CRIT"] = 1,
			["EXPERTISE"] = 1,
			["STR"] = 1,
			["HITCAP"] = {[1] = { ["Minimum Hit Rating"] = "8.00%" }, [3] = { ["Draenei's Heroic Presence (Racial)"] = "+1.00%" } },
			["ABSOLUTEMINHIT"] = 229.53,
			["CAPRATIO"] = 32.79,
			["DUEL"] = 0,
			["AGI"] = 1,
			["OVERHITCAP"] = 1,
			["STA"] = 1,
		},
		[3] = {--Frost (DPS)
			["TOHIT"] = 1,
			["SPELLPOW"] = 0,
			["HASTE"] = 1,
			["ATTACKPOWER"] = 1,
			["ARMORPEN"] = 1,
			["CRIT"] = 1,
			["EXPERTISE"] = 1,
			["STR"] = 1,
			["HITCAP"] = {[1] = { ["Minimum Hit Rating"] = "8.00%" }, [3] = { ["Nerves of Cold Steel (Talent)"] = "+3.00%" },  [4] = { ["Draenei's Heroic Presence (Racial)"] = "+1.00%" } },
			["ABSOLUTEMINHIT"] = 131.16,
			["CAPRATIO"] = 32.79,
			["DUEL"] = 1,
			["AGI"] = 1,
			["OVERHITCAP"] = 0,
			["STA"] = 1,
		},
		[4] = {--Tanking
			["PARRY"] = 1,
			["TOHIT"] = 1,
			["STR"] = 1,
			["HASTE"] = 1,
			["DEFENSE"] = 1,
			["EXPERTISE"] = 1,
			["DODGE"] = 1,
			["AGI"] = 1,
			["STA"] = 1,
			["CRIT"] = 1,
			["ATTACKPOWER"] = 1,
			["ARMORPEN"] = 1,
			["DEFENSECAP"] = { [1] = { ["Minimum Bonus Defense Skill"] = "+140" }, [3] = { ["Resilience (Stat)"] = "XXX" } },
			--["DEFENSECAP"] = 540,
			--["DUEL"] = 0,
			["STA"] = 1,
			--["OVERHITCAP"] = 1,
   		},
	},
	["WARRIOR"] = {
		[1] = {--Arms (DPS)
			["EXPERTISE"] = 1,
			["ATTACKPOWER"] = 1,
			["ARMORPEN"] = 1,
			["STR"] = 1,
			["TOHIT"] = 1,
			["CRIT"] = 1,
			["AGI"] = 1,
			["HASTE"] = 1,
			["SPELLPOW"] = 0,
			["BLOCK"] = 0,
			["STA"] = 1,
			["DUEL"] = 0,
			["HITCAP"] = {[1] = { ["Minimum Hit Rating"] = "8.00%" }, [3] = { ["Draenei's Heroic Presence (Racial)"] = "+1.00%" } },
			["ABSOLUTEMINHIT"] = 229.53,
			["CAPRATIO"] = 32.79,
		},
		[2] = {--Fury(DPS)
			["EXPERTISE"] = 1,
			["ATTACKPOWER"] = 1,
			["ARMORPEN"] = 1,
			["STR"] = 1,
			["TOHIT"] = 1,
			["STA"] = 1,
			["CRIT"] = 1,
			["AGI"] = 1,
			["HASTE"] = 1,
			["DUEL"] = 1,
			["SPELLPOW"] = 0,
			["BLOCK"] = 0,
			["HITCAP"] = {[1] = { ["Minimum Hit Rating"] = "8.00%" }, [3] = { ["Precision (Talent)"] = "+3%" }, [4] = { ["Draenei's Heroic Presence (Racial)"] = "+1.00%" } },
			["ABSOLUTEMINHIT"] = 131.16,
			["CAPRATIO"] = 32.79,
		},
		[3] = {--Protection (Tank)
		    ["DEFENSE"] = 1,
		    ["DODGE"] = 1,
		    ["EXPERTISE"] = 1,
		    ["AGI"] = 1,
		    ["PARRY"] = 1,
		    ["BLOCK"] = 1,
		    ["DUEL"] = 0,
		    ["STR"] = 1,
		    ["TOHIT"] = 1,
		    ["CRIT"] = 1,
		    ["ARMORPEN"] = 1,
			["STA"] = 1,
		    ["ATTACKPOWER"] = 1,
		    ["HASTE"] = 1,
		    ["SPELLPOW"] = 0,
		    ["BLOCKVALUE"] = 1,
		    ["DEFENSECAP"] = { [1] = { ["Minimum Bonus Defense Skill"] = "+140" }, [3] = { ["Resilience (Stat)"] = "XXX" } },
			["OVERHITCAP"] = 0.5,
		},
	},
	["PRIEST"] = {
        [1] = {--Discipline
			["SPELLPOW"] = 1,
			["HASTE"] = 1,
			["CRIT"] =1,
			["INT"] = 1,
			["SPI"] = 1,
			["STA"] = 1,
			["MANAREG"] = 1,
			["ATTACKPOWER"] = 0,
		},
        [2] = {--Holy
			["SPELLPOW"] = 1,
			["HASTE"] = 1,
			["CRIT"] =1,
			["INT"] = 1,
			["STA"] = 1,
			["SPI"] = 1,
			["MANAREG"] = 1,
			["ATTACKPOWER"] = 0,
		},
        [3] = {--Shadow
			["TOHIT"] = 1,
			["TOHITMIN"] = 446,
			["HITMODS"] = {[1] = { ["Index"] = 6, ["Tab"] = 3, ["Amount"] = 26.23}, [2] = { ["Index"] = 22, ["Tab"] = 3, ["Amount"] = 26.23 }, },			
			["SPELLPOW"] = 1,
			["HASTE"] = 1,
			["CRIT"] =1,
			["INT"] = 1,
			["SPI"] = 1,
			["STA"] = 1,
			["MANAREG"] = 1,
			["ATTACKPOWER"] = 0,
			["HITCAP"] = {[1] = { ["Required Hit Rating"] = "17.00%" }, [3] = { ["Shadow Focus (Talent)"] = "+3.00%" }, [4] = { ["Misery (Talent)"] = "+3.00%" }, [5] = { ["Draenei's Heroic Presence (Racial)"] = "+1.00%" } },
			["ABSOLUTEMINHIT"] = 262.3,
			["CAPRATIO"] = 26.23,			
			["OVERHITCAP"] = 1,
		},
	},
	["WARLOCK"] = {
		[1] = {--Affliction
			["TOHIT"] = 1,
			["SPELLPOW"] = 1,
			["HASTE"] = 1,
			["CRIT"] =1,
			["INT"] = 1,
			["STA"] = 1,
			["SPI"] = 1,
			["MANAREG"] = 0,
			["ATTACKPOWER"] = 0,
			["HITCAP"] = {[1] = { ["Required Hit Rating"] = "17.00%" }, [3] = { ["Suppresion (Talent)"] = "+3.00%" }, [4] = { ["Faerie Fire / Misery (Debuff)"] = "+3.00%" }, [5] = { ["Draenei's Heroic Presence (Racial)"] = "+1.00%" } },
			["ABSOLUTEMINHIT"] = 262.3,
			["CAPRATIO"] = 26.23,			
			["OVERHITCAP"] = 1,
		},
		[2] = {--Demonology
			["TOHIT"] = 1,
			["SPELLPOW"] = 1,
			["HASTE"] = 1,
			["STA"] = 1,
			["CRIT"] =1,
			["INT"] = 1,
			["SPI"] = 1,
			["MANAREG"] = 0,
			["ATTACKPOWER"] = 0,
			["HITCAP"] = {[1]= { ["Required Hit Rating"] = "17.00%" }, [3] = { ["Suppresion (Talent)"] = "+3.00%" }, [4] = { ["Faerie Fire / Misery (Debuff)"] = "+3.00%" }, [5] = { ["Draenei's Heroic Presence (Racial)"] = "+1.00%" } },
			["ABSOLUTEMINHIT"] = 340.99,
			["CAPRATIO"] = 26.23,			
			["OVERHITCAP"] = 1,
		},
		[3] = {--Destruction
			["TOHIT"] = 1,
			["SPELLPOW"] = 1,
			["HASTE"] = 1,
			["CRIT"] =1,
			["STA"] = 1,
			["INT"] = 1,
			["SPI"] = 1,
			["MANAREG"] = 0,
			["ATTACKPOWER"] = 0,
			["HITCAP"] = {[1] = { ["Required Hit Rating"] = "17.00%" }, [3] = { ["Suppresion (Talent)"] = "+3.00%" }, [4] = { ["Faerie Fire / Misery (Debuff)"] = "+3.00%" }, [5] = { ["Draenei's Heroic Presence (Racial)"] = "+1.00%" } },
			["ABSOLUTEMINHIT"] = 340.99,
			["CAPRATIO"] = 26.23,
		},
	},
	["ROGUE"] = {
		[1] = {--DPS Combat
			["SPELLPOW"] = 0,
			["ATTACKPOWER"] = 1,
			["STA"] = 1,
			["STR"] = 1,
			["ARMORPEN"] = 1,
			["CRIT"] = 1,
			["TOHIT"] = 1,
			["DUEL"] = 1,
			["HASTE"] = 1,
			["EXPERTISE"] = 1,
			["AGI"] = 1,
			["HITCAP"] = {[1] = { ["Minimum Hit Rating"] = "8.00%" }, [3] = { ["Precision (Talent)"] = "+5.00%" }, [4] = { ["Draenei's Heroic Presence (Racial)"] = "+1.00%" } },
			["ABSOLUTEMINHIT"] = 65.58,
			["CAPRATIO"] = 32.79,

		},
		[2] = {--DPS Assassination
			["SPELLPOW"] = 0,
			["ATTACKPOWER"] = 1,
			["STA"] = 1,
			["STR"] = 1,
			["ARMORPEN"] = 1,
			["CRIT"] = 1,
			["TOHIT"] = 1,
			["DUEL"] = 1,
			["HASTE"] = 1,
			["EXPERTISE"] = 1,
			["AGI"] = 1,
			["HITCAP"] = {[1] = { ["Minimum Hit Rating"] = "8.00%" }, [3] = { ["Precision (Talent)"] = "+5.00%" }, [4] = { ["Draenei's Heroic Presence (Racial)"] = "+1.00%" } },
			["ABSOLUTEMINHIT"] = 65.58,
			["CAPRATIO"] = 32.79,
		},
		[3] = {--Subtlety
			["SPELLPOW"] = 0,
			["ATTACKPOWER"] = 1,
			["STR"] = 1,
			["ARMORPEN"] = 1,
			["STA"] = 1,
			["CRIT"] = 1,
			["DUEL"] = 1,
			["TOHIT"] = 1,
			["HASTE"] = 1,
			["EXPERTISE"] = 1,
			["AGI"] = 1,
			["HITCAP"] = {[1] = { ["Minimum Hit Rating"] = "8.00%" }, [3] = { ["Precision (Talent)"] = "+5.00%" }, [4] = { ["Draenei's Heroic Presence (Racial)"] = "+1.00%" } },
			["ABSOLUTEMINHIT"] = 65.58,
			["CAPRATIO"] = 32.79,
		},
	},
	["HUNTER"] = {
		[1] = {--DPS Combat
			["SPELLPOW"] = 0,
			["ATTACKPOWER"] = 1,
			["STR"] = 1,
			["ARMORPEN"] = 1,
			["STA"] = 1,
			["CRIT"] = 1,
			["TOHIT"] = 1,
			["HASTE"] = 1,
			["EXPERTISE"] = 1,
			["AGI"] = 1,
			["RANGEDCRIT"] = 1,
			["INT"] = 1,
			["HITCAP"] = {[1] = { ["Minimum Hit Rating"] = "8.00%" }, [3] = { ["Focused Aim (Talent)"] = "+3.00%" }, [4] = { ["Draenei's Heroic Presence (Racial)"] = "+1.00%" } },
			["ABSOLUTEMINHIT"] = 131.16,
			["CAPRATIO"] = 32.79,
		},
		[2] = {--DPS Assassination
			["SPELLPOW"] = 0,
			["ATTACKPOWER"] = 1,
			["STR"] = 1,
			["ARMORPEN"] = 1,
			["CRIT"] = 1,
			["TOHIT"] = 1,
			["INT"] = 1,
			["RANGEDCRIT"] = 1,
			["HASTE"] = 1,
			["STA"] = 1,
			["EXPERTISE"] = 1,
			["AGI"] = 1,
			["HITCAP"] = {[1] = { ["Minimum Hit Rating"] = "8.00%" }, [3] = { ["Focused Aim (Talent)"] = "+3.00%" }, [4] = { ["Draenei's Heroic Presence (Racial)"] = "+1.00%" } },
			["ABSOLUTEMINHIT"] = 131.16,
			["CAPRATIO"] = 32.79,
		},
		[3] = {--Subtlety
			["SPELLPOW"] = 0,
			["ATTACKPOWER"] = 1,
			["INT"] = 1,
			["STR"] = 1,
			["ARMORPEN"] = 1,
			["CRIT"] = 1,
			["TOHIT"] = 1,
			["RANGEDCRIT"] = 1,
			["HASTE"] = 1,
			["STA"] = 1,
			["EXPERTISE"] = 1,
			["AGI"] = 1,
			["HITCAP"] = {[1] = { ["Minimum Hit Rating"] = "8.00%" }, [3] = { ["Focused Aim (Talent)"] = "+3.00%" }, [4] = { ["Draenei's Heroic Presence (Racial)"] = "+1.00%" } },
			["ABSOLUTEMINHIT"] = 131.16,
			["CAPRATIO"] = 32.79,
		},
	},
	["MAGE"] = {
		[1] = {--DPS Arcane
			["TOHIT"] = 1,
			["TOHITMIN"] = 446,
			["HITMODS"] = {[1] = { ["Index"] = 2, ["Tab"] = 1, ["Amount"] = 26.23}, [2] = { ["Index"] = 6, ["Tab"] = 3, ["Amount"] = 26.23 }, },
			["OVERHITCAP"] = 1,			
			["SPELLPOW"] = 1,
			["HASTE"] = 1,
			["CRIT"] =1,
			["STA"] = 1,
			["INT"] = 1,
			["SPI"] = 1,
			--["STA"] = 1,
			--["MANAREG"] = 0,
			["SPI"] = 1,
			["HITCAP"] = {[1] = { ["Required Hit Rating"] = "17.00%" }, [3] = { ["Arcane Focus (Talent)"] = "+3.00%" }, [4] = { ["Precision (Talent)"] = "+3.00%" },  [5] = { ["Faerie Fire / Misery (Debuff)"] = "+3.00%" }, [6] = { ["Draenei's Heroic Presence (Racial)"] = "+1.00%" } },
			["ABSOLUTEMINHIT"] = 183.61,
			["CAPRATIO"] = 26.23,
		},
		[2] = {--DPS  Fire
			["TOHIT"] = 1,
			["TOHITMIN"] = 446,
			["HITMODS"] = {[1] = { ["Index"] = 2, ["Tab"] = 1, ["Amount"] = 26.23}, [2] = { ["Index"] = 6, ["Tab"] = 3, ["Amount"] = 26.23 }, },
			["OVERHITCAP"] = 1,				
			["SPELLPOW"] = 1,
			["HASTE"] = 1,
			["CRIT"] =1,
			["INT"] = 1,
			["STA"] = 1,
			["SPI"] = 1,
			--["STA"] = 1,
			--["MANAREG"] = 0,
			["SPI"] = 1,
			["HITCAP"] = {[1] = { ["Required Hit Rating"] = "17.00%" }, [3] = { ["Faerie Fire / Misery (Debuff)"] = "+3.00%" }, [4] = { ["Draenei's Heroic Presence (Racial)"] = "+1.00%" } },
			["ABSOLUTEMINHIT"] = 367.22,
			["CAPRATIO"] = 26.23,
		},
		[3] = {--DPS Frost
			["TOHIT"] = 1,
			["TOHITMIN"] = 446,
			["HITMODS"] = {[1] = { ["Index"] = 2, ["Tab"] = 1, ["Amount"] = 26.23}, [2] = { ["Index"] = 6, ["Tab"] = 3, ["Amount"] = 26.23 }, },
			["OVERHITCAP"] = 1,				
			["SPELLPOW"] = 1,
			["HASTE"] = 1,
			["STA"] = 1,
			["CRIT"] =1,
			["INT"] = 1,
			["SPI"] = 1,
			--["STA"] = 1,
			--["MANAREG"] = 0,
			["SPI"] = 1,
			["HITCAP"] = {[1] = { ["Required Hit Rating"] = "17.00%" }, [3] = { ["Precision (Talent)"] = "+3.00%" }, [4] = { ["Faerie Fire / Misery (Debuff)"] = "+3.00%" }, [5] = { ["Draenei's Heroic Presence (Racial)"] = "+1.00%" } },
			["ABSOLUTEMINHIT"] = 262.3,
			["CAPRATIO"] = 26.23,
		},
	},
	["ShamanCustomWeights"] = {
		[1] = {--Elemental
			["SPELLPOW"] = 0.60,
			["HASTE"] = 0.56,
			["CRIT"] = 0.40,
			["INT"] = 0.11,
			["Total"] = 2.67,			
			["TOHIT"] = 1,
		},
		[2] = {--Enhancement
			["TOHIT"] = 1,
			["EXPERTISE"] = 0.84,
			["AGI"] = 0.55,
			["INT"] = 0.55,
			["CRIT"] = 0.55,
			["HASTE"] = 0.42,
			["STR"] = 0.35,
			["DUEL"] = 1,
			["SPELLPOW"] = 0.29,
			["ATTACKPOWER"] = 0.32,
			["Total"] = 5.13,
			--["SPELLPOW"] = 0.25,
			["ARMORPEN"] = 0.26,
		},
        [3] = {--Restoration
            ["MANAREG"] = 1,
			["SPELLPOW"] = 0.77,
			["HASTE"] = 0.35,
			["CRIT"] = 0.62,
			["INT"] = 0.85,
			["Total"] = 3.59,
		},
	},

	["SHAMAN"] = {
		[1] = {--Elemental
			["TOHIT"] = 1,
			["TOHITMIN"] = 446,
			["HITMODS"] = {[1] = { ["Index"] = 14, ["Tab"] = 1, ["Amount"] = 26.23}, },
			["SPELLPOW"] = 1,
			["STA"] = 1,
			["HASTE"] = 1,
			["CRIT"] =1,
			["INT"] = 1,
			["BLOCK"] = 1,
			["HITCAP"] = {[1] = { ["Required Hit Rating"] = "17.00%" }, [3] = { ["Elemental Precision (Talent)"] = "+3.00%" }, [4] = { ["Faerie Fire / Misery (Debuff)"] = "+3.00%" }, [5] = { ["Draenei's Heroic Presence (Racial)"] = "+1.00%" } },
			["ABSOLUTEMINHIT"] = 262.3,
			["CAPRATIO"] = 26.23,
			["BLOCKVALUE"] = 1,
			["OVERHITCAP"] = 1,
		},
		[2] = {--Enhancement
			["TOHIT"] = 1,
			["EXPERTISE"] = 1,
			["INT"] = 1,
			["CRIT"] = 1,
			["AGI"] = 1,
			["STA"] = 1,
			["HASTE"] = 1,
			["STR"] = 1,
			["DUEL"] = 1,
			["ATTACKPOWER"] = 1,
			["ARMORPEN"] = 1,
			["BLOCK"] = 0,
			["HITCAP"] = {[1] = { ["Minimum Hit Rating"] = "8.00%" }, [3] = { ["Dual Wield Specialization (Talent)"] = "+6.00%" }, [4] = { ["Draenei's Heroic Presence (Racial)"] = "+1.00%" } },
			["ABSOLUTEMINHIT"] = 32.79,
			["CAPRATIO"] = 32.79,
		},
        [3] = {--Restoration
            ["MANAREG"] = 1,
			["SPELLPOW"] = 1,
			["HASTE"] = 1,
			["CRIT"] = 1,
			["INT"] = 1,
			["STA"] = 1,
			["BLOCK"] = 1,
			["BLOCKVALUE"] = 1,
		},
	},
}

GearScoreClassStats = {
	["STR"] = 1,["AGI"] = 1,["STA"] = 2/3,["INT"] = 1,["SPI"] = 1,["BLOCK"] = 1,["BLOCKVALUE"] = 0.65,["DODGE"] = 1,["PARRY"] = 1,
	["RESILIENCE"] = 1,["ARMORPEN"] = 1,["EXPERTISE"] = 1,["DEFENSE"] = 1,["ATTACKPOWER"] = 0.5,["RANGEDATTACKPOWER"] = 0.5,["CRIT"] = 1,
	["RANGEDCRIT"] = 1,["TOHIT"] = 1,["RANGEDHIT"] = 1,["HASTE"] = 1,["ARCANERES"] = 0,["FROSTRES"] = 0,["FIRERES"] = 0,["SHADOWRES"] = 0,	
	["SPELLPEN"] = 0.80,["SPELLPOW"] = 6/7,["MANAREG"] = 2,
}

GearScoreClassStatsTranslation = {
	["STR"] = "Strength",["AGI"] = "Agility",["STA"] = "Stamina",["INT"] = "Intellect",["SPI"] = "Spirit",["ARMOR"] = "Armor",
	["BLOCK"] = "Block Rating",["BLOCKVALUE"] = "Sheild Block",["DODGE"] = "Dodge Rating",["PARRY"] = "Parry Rating",["RESILIENCE"] = "Resilience",
	["ARMORPEN"] = "Armor Penetration",["EXPERTISE"] = "Expertise",["DEFENSE"] = "Defense Rating",["ATTACKPOWER"] = "Attack Power",
	["RANGEDATTACKPOWER"] = "Ranged Attack Power",["CRIT"] = "Critical strike rating",["RANGEDCRIT"] = "Ranged critical strike rating",
	["TOHIT"] = "Hit rating",["RANGEDHIT"] = "Ranged hit rating",["HASTE"] = "Haste rating",["SPELLPEN"] = "Spell Penetration",["SPELLPOW"] = "Spell Power",
	["MANAREG"] = "Mana per 5",
}
LibQTip = LibStub("LibQTipClick-1.1")