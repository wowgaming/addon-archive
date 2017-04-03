-- nearby check yes/no? slowdown may be an isue if someone leaves the mod enabled and always replace node
local GatherMateData = LibStub("AceAddon-3.0"):NewAddon("GatherMate_Data")
local GatherMate = LibStub("AceAddon-3.0"):GetAddon("GatherMate")

local bcZones = {
	[15] = true,
	[18] = true,
	[21] = true,
	[22] = true,
	[40] = true,
	[47] = true,
	[56] = true,
	[58] = true,
	[61] = true,
}
local wrathZones = {
	[66] = true,
	[67] = true,
	[68] = true,
	[69] = true,
	[70] = true,
	[71] = true,
	[72] = true,
	[73] = true,
	[74] = true,
	[75] = true,
	[76] = true,
	[77] = true,
	[78] = true,
	[79] = true,
	[80] = true,
}

function GatherMateData:PerformMerge(dbs,style, zoneFilter)
	local filter = nil
	if zoneFilter and type(zoneFilter) == "string" then
		if zoneFilter == "TBC" then
			filter = bcZones
		elseif zoneFilter == "WRATH" then
			filter = wrathZones
		end
	elseif zoneFilter then
		filter = bcZones
	end
	if dbs["Mines"]    then self:MergeMines(style ~= "Merge",filter) end
	if dbs["Herbs"]    then self:MergeHerbs(style ~= "Merge",filter) end
	if dbs["Gases"]    then self:MergeGases(style ~= "Merge",filter) end
	if dbs["Fish"]     then self:MergeFish(style ~= "Merge",filter) end
	if dbs["Treasure"] then self:MergeTreasure(style ~= "Merge",filter) end
	self:CleanupImportData()
	GatherMate:SendMessage("GatherMateDataImport")
	--GatherMate:CleanupDB()
end
-- Insert mining data
function GatherMateData:MergeMines(clear,zoneFilter)
	if clear then GatherMate:ClearDB("Mining") end
	for zoneID, node_table in pairs(GatherMateDataMineDB) do
		if zoneFilter and zoneFilter[zoneID] or not zoneFilter then
			for coord, nodeID in pairs(node_table) do
				GatherMate:InjectNode(zoneID,coord,"Mining", nodeID)
			end
		end
	end
end

-- herbs
function GatherMateData:MergeHerbs(clear,zoneFilter)
	if clear then GatherMate:ClearDB("Herb Gathering") end
	for zoneID, node_table in pairs(GatherMateDataHerbDB) do
		if zoneFilter and zoneFilter[zoneID] or not zoneFilter then
			for coord, nodeID in pairs(node_table) do
				GatherMate:InjectNode(zoneID,coord,"Herb Gathering", nodeID)
			end
		end
	end
end

-- gases
function GatherMateData:MergeGases(clear,zoneFilter)
	if clear then GatherMate:ClearDB("Extract Gas") end
	for zoneID, node_table in pairs(GatherMateDataGasDB) do
		if zoneFilter and zoneFilter[zoneID] or not zoneFilter then
			for coord, nodeID in pairs(node_table) do
				GatherMate:InjectNode(zoneID,coord,"Extract Gas", nodeID)
			end
		end
	end
end

-- fish
function GatherMateData:MergeFish(clear,zoneFilter)
	if clear then GatherMate:ClearDB("Fishing") end
	for zoneID, node_table in pairs(GatherMateDataFishDB) do
		if zoneFilter and zoneFilter[zoneID] or not zoneFilter then
			for coord, nodeID in pairs(node_table) do
				GatherMate:InjectNode(zoneID,coord,"Fishing", nodeID)
			end
		end
	end
end
function GatherMateData:MergeTreasure(clear,zoneFilter)
	if clear then GatherMate:ClearDB("Treasure") end
	for zoneID, node_table in pairs(GatherMateDataTreasureDB) do
		if zoneFilter and zoneFilter[zoneID] or not zoneFilter then
			for coord, nodeID in pairs(node_table) do
				GatherMate:InjectNode(zoneID,coord,"Treasure", nodeID)
			end
		end
	end
end


function GatherMateData:CleanupImportData()
	GatherMateDataHerbDB = nil
	GatherMateDataMineDB = nil
	GatherMateDataGasDB = nil
	GatherMateDataFishDB = nil
	GatherMateDataTreasureDB = nil
end
