--[[
	Gatherer Addon for World of Warcraft(tm).
	Version: 3.1.14 (<%codename%>)
	Revision: $Id: GatherConvert.lua 776 2008-11-13 03:02:26Z Esamynn $

	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 2
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GPL.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

	Note:
		This AddOn's source code is specifically designed to work with
		World of Warcraft's interpreted AddOn system.
		You have an implicit licence to use this AddOn with these facilities
		since that is it's designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat

	Database conversion/merging code and conversion data tables
--]]
Gatherer_RegisterRevision("$URL: http://svn.norganna.org/gatherer/release/Gatherer/GatherConvert.lua $", "$Rev: 776 $")

local metatable = { __index = getfenv(0) }
setmetatable( Gatherer.Convert, metatable )
setfenv(1, Gatherer.Convert)

local type = type
local ipairs = ipairs
local pairs = pairs
local getglobal = getglobal


local nodeLevel, mappingData, typeConverstionData
local traversalData = {}
local MergeNode

local nodeData = {}
local function extractNodeInformation()
	for index, mapping in ipairs(mappingData) do
		if ( mapping.type == "key" ) then
			nodeData[index] = traversalData[mapping.level].key
		elseif ( mapping.type == "value" ) then
			nodeData[index] = traversalData[mapping.level].data[mapping.key]
		else
			--ERROR
			return
		end
	end
	for index, data in ipairs(nodeData) do
		local typeInfo = typeConverstionData[index]
		local dataType = type(data)
		if ( typeInfo ) then
			if ( type(typeInfo) == "string" ) then
				if ( dataType ~= typeInfo ) then
					data = nil; --Invalid Type, set to nil
				end
			elseif ( type(typeInfo) == "table" ) then
				local conversionInfo = typeInfo[dataType]
				if ( (dataType == "string") and not (typeInfo.caseSensitive) ) then
					data = string.lower(data)
				end
				if ( conversionInfo ) then
					if ( type(conversionInfo) == "table" ) then
						data = conversionInfo[data]
					elseif ( type(conversionInfo) == "function" ) then
						data = conversionInfo(data, nodeData)
					elseif ( type(conversionInfo) == "string" ) then
						data = getglobal(conversionInfo)(data, nodeData)
					end
				else
					data = nil; --Invalid Type, set to nil
				end
			else
				--BAD MERGE DEFINITION!
			end
		else
			data = nil; --no type or conversion information
		end
		nodeData[index] = data
	end
	local result, err = pcall(MergeNode, unpack(nodeData, 1, 10))
	if not ( result ) then
		Gatherer.Util.Debug("MergeNode error", err, "Data: ("..strjoin(", ", tostringall(unpack(nodeData, 1, 10)))..")")
	end
end

local function iterateOnLevel( level )
	if ( level < 1 or level > nodeLevel ) then return level end --Invalid Level!
	
	if ( level == nodeLevel ) then
		extractNodeInformation()
	else
		for key, data in pairs(traversalData[level].data) do
			if ( type(data) == "table" ) then
				local newLevel = level + 1
				traversalData[newLevel].key = key
				traversalData[newLevel].data = data
				iterateOnLevel(newLevel)
			end
		end
	end
end


function ImportDatabase( dataToImport, nodeMergeFunction )
	local dbVer = dataToImport.dbVersion
	local converInfo = ConversionInformation[dbVer]
	if ( converInfo ) then
		nodeLevel = converInfo.nodeLevel
		mappingData = converInfo.mappingData
		typeConverstionData = converInfo.typeConverstionData
		MergeNode = nodeMergeFunction
		for i = 1, nodeLevel do
			if not ( traversalData[i] ) then
				traversalData[i] = {}
			end
		end
		for key, data in pairs(dataToImport) do
			if ( type(data) == "table" ) then
				traversalData[1].data = data
				traversalData[1].key = key
				iterateOnLevel(1)
			end
		end
	end
end

local specialTranslations = {
	-- Un'Goro Soil
	["un'goro soil"] = 157936, -- enUS, enGB
	["humus d'Un'Goro"] = 157936, -- frFR
	["un'Goro erde"] = 157936, --deDE
	["\229\174\137\230\136\136\230\180\155\231\154\132\230\179\165\229\156\159"] = 157936, -- zhCN
	
	-- Power Crystals
	["power crystal"] = "TREASURE_POWERCRYST", -- enUS, enGB
	["cristal de puissance"] = "TREASURE_POWERCRYST", -- frFR
	["machtkristall"] = "TREASURE_POWERCRYST", --deDE
	["\232\131\189\233\135\143\230\176\180\230\153\182"] = "TREASURE_POWERCRYST", -- zhCN
}
local function specialNodeNameTranslations( nodeName )
	for name, nodeId in pairs(specialTranslations) do
		if ( strlower(name) == strlower(nodeName) ) then
			return nodeId
		end
	end
end

local zoneSizeShiftFunctions = {
	["3.0-Shift"] = {
		convertXAxis = (
			function ( data, nodeData )
				local continent = nodeData[3]
				if ( continent == 2 ) then
					local zoneToken = Gatherer.ZoneTokens.GetZoneToken(continent, nodeData[4])
					if ( zoneToken == "EASTERN_PLAGUELANDS" ) then
						data = (data - 0.026372737507017) * 0.96020671188279
					elseif ( zoneToken == "STORMWIND" ) then
						data = (data - -0.25437145166642) * 0.77368159521222
					end
				end
				return data
			end
		),
		convertYAxis = (
			function( data, nodeData )
				local continent = nodeData[3]
				if ( continent == 2 ) then
					local zoneToken = Gatherer.ZoneTokens.GetZoneToken(continent, nodeData[4])
					if ( zoneToken == "EASTERN_PLAGUELANDS" ) then
						data = (data - 0.03712658084068) * 0.96046508864265
					elseif ( zoneToken == "STORMWIND" ) then
						data = (data - -0.31574041623418) * 0.77383347432012
					end
				end
				return data
			end
		),
	}
}

ConversionInformation = {
	--MergeNode argument mapping table for unversioned DB to MergeNode function arguments
	[0] = {
		nodeLevel = 4,
		mappingData = {
			[1] = { type="key", level=3, }, --gatherName
			[2] = { type="value", level=4, key="gtype" }, --gatherType
			[3] = { type="key", level=1, }, --continent
			[4] = { type="key", level=2, }, --zone
			[5] = { type="value", level=4, key="x", }, --x
			[6] = { type="value", level=4, key="y", }, --y
			[7] = { type="value", level=4, key="count", }, --count
		},
		--conversion table for any needed type conversions to the arguments of MergeNode
		--this is also type checking data
		--if there is no data for an arugment, then it is nil'd out
		--values with invalid types are nil'd out
		--conversion specifications can either be a table or a function that maps old values to new ones
		typeConverstionData = {
			[1] = {
				string = (
					function( data )
						for k, v in pairs(Gatherer.Nodes.Names) do
							if ( strlower(k) == strlower(data) ) then
								return v
							end
						end
						return specialNodeNameTranslations(data)
					end
				),
			},
			[2] = {
				caseSensitive = false,
				number = {
					[0] = "OPEN",
					[1] = "HERB",
					[2] = "MINE",
					--all others map to nil
				},
				string = {
					ore = "MINE",
					herb = "HERB",
					treasure = "OPEN",
					--all others map to nil
				},
			},
			[3] = "number",
			[4] = "number",
			[5] = {
				number = function(data, nodeData) return zoneSizeShiftFunctions["3.0-Shift"].convertXAxis(data/100, nodeData) end,
			},
			[6] = {
				number = function(data, nodeData) return zoneSizeShiftFunctions["3.0-Shift"].convertYAxis(data/100, nodeData) end,
			},
			[7] = "number",
		},
	},
	--MergeNode argument mapping table for DB version 1 to MergeNode function arguments
	[1] = {
		nodeLevel = 4,
		mappingData = {
			[1] = { type="key", level=3, }, --gatherName
			[2] = { type="value", level=3, key="gtype" }, --gatherType
			[3] = { type="key", level=1, }, --continent
			[4] = { type="key", level=2, }, --zone
			[5] = { type="value", level=4, key=1, }, --x
			[6] = { type="value", level=4, key=2, }, --y
			[7] = { type="value", level=4, key=3, }, --count
		},
		--conversion table for any needed type conversions to the arguments of MergeNode
		--this is also type checking data
		--if there is no data for an arugment, then it is nil'd out
		--values with invalid types are nil'd out
		--conversion specifications can either be a table or a function that maps old values to new ones
		typeConverstionData = {
			[1] = {
				string = (
					function( data )
						for k, v in pairs(Gatherer.Nodes.Names) do
							if ( strlower(k) == strlower(data) ) then
								return v
							end
						end
						return specialNodeNameTranslations(data)
					end
				),
			},
			[2] = {
				caseSensitive = false,
				string = {
					ore = "MINE",
					herb = "HERB",
					treasure = "OPEN",
					--all others map to nil
				},
			},
			[3] = "number",
			[4] = "number",
			[5] = {
				number = function(data, nodeData) return zoneSizeShiftFunctions["3.0-Shift"].convertXAxis(data/100, nodeData) end,
			},
			[6] = {
				number = function(data, nodeData) return zoneSizeShiftFunctions["3.0-Shift"].convertYAxis(data/100, nodeData) end,
			},
			[7] = "number",
		},
	},
	
	--MergeNode argument mapping table for DB version 2 to MergeNode function arguments
	[2] = {
		nodeLevel = 4,
		mappingData = {
			[1] = { type="key", level=3, }, --gatherName
			[2] = { type="value", level=3, key="gtype" }, --gatherType
			[3] = { type="key", level=1, }, --continent
			[4] = { type="key", level=2, }, --zone
			[5] = { type="value", level=4, key=1, }, --x
			[6] = { type="value", level=4, key=2, }, --y
			[7] = { type="value", level=4, key=3, }, --count
			[8] = { type="value", level=4, key=4, }, --harvested
			[9] = { type="value", level=4, key=5, }, --inspected
			[10] = { type="value", level=4, key=6, }, --source
		},
		typeConverstionData = {
			[1] = {
				string = (
					function( data )
						for k, v in pairs(Gatherer.Nodes.Names) do
							if ( strlower(k) == strlower(data) ) then
								return v
							end
						end
						--stick with the name if we don't have an id for it yet
						return Gatherer.Nodes.ReMappings[data] or data
					end
				),
				number = (
					function( data )
						return Gatherer.Nodes.ReMappings[data] or data
					end
				),
			},
			[2] = "string",
			[3] = "number",
			[4] = "string",
			[5] = { number = zoneSizeShiftFunctions["3.0-Shift"].convertXAxis },
			[6] = { number = zoneSizeShiftFunctions["3.0-Shift"].convertYAxis },
			[7] = "number",
			[8] = "number",
			[9] = "number",
			[10] = "string",
		},
	},
	
	--MergeNode argument mapping table for DB version 3 to MergeNode function arguments
	[3] = {
		nodeLevel = 4,
		mappingData = {
			[1] = { type="key", level=3, }, --gatherName
			[2] = { type="value", level=3, key="gtype" }, --gatherType
			[3] = { type="key", level=1, }, --continent
			[4] = { type="key", level=2, }, --zone
			[5] = { type="value", level=4, key=1, }, --x
			[6] = { type="value", level=4, key=2, }, --y
			[7] = { type="value", level=4, key=3, }, --count
			[8] = { type="value", level=4, key=4, }, --harvested
			[9] = { type="value", level=4, key=5, }, --inspected
			[10] = { type="value", level=4, key=6, }, --source
		},
		typeConverstionData = {
			[1] = {
				string = (
					function( data )
						for k, v in pairs(Gatherer.Nodes.Names) do
							if ( strlower(k) == strlower(data) ) then
								return v
							end
						end
						--stick with the name if we don't have an id for it yet
						return Gatherer.Nodes.ReMappings[data] or data
					end
				),
				number = (
					function( data )
						return Gatherer.Nodes.ReMappings[data] or data
					end
				),
			},
			[2] = "string",
			[3] = "number",
			[4] = "string",
			[5] = "number",
			[6] = "number",
			[7] = "number",
			[8] = "number",
			[9] = "number",
			[10] = "string",
		},
	},
}


function debug( msg )
	ChatFrame5:AddMessage(msg)
end

-- reference to the Astrolabe mapping library
local Astrolabe = DongleStub(Gatherer.AstrolabeVersion)

function RenumberDatabaseZonesForBCExpansion( database )
	-- check if a re-ordering of the database is needed before zone insertion 
	-- in order to deal with any new zone name translations
	ConvertDBForNewTranslations(database)
	
	for continent, cData in pairs(database) do
		if ( type(continent) == "number" ) then
			local offsets = {}
			local bcZones = Gatherer.ZoneTokens.BCZones[continent]
			local curOffset = 0
			if ( continent <= 0 ) then
				database[continent] = nil
			else
				for zoneIndex, mapName in ipairs(Astrolabe.ContinentList[continent]) do
					if ( bcZones[mapName] ) then
						curOffset = curOffset + 1
						offsets[zoneIndex] = 0
					else
						offsets[zoneIndex] = curOffset
					end
				end
				for i = #offsets, 1, -1  do
					local oldZoneIndex = i - offsets[i]
					cData[i] = cData[oldZoneIndex]
					Gatherer.Util.Debug("shifted old zone "..oldZoneIndex.." to "..i);
					if ( i ~= oldZoneIndex ) then
						cData[oldZoneIndex] = nil
					end
				end
			end
		end
	end
end

--[[
For non-english locales in which map name translations, the zone tables must be 
renumbered for the new zone order, resulting from the new translations, before 
the Burning Crusade zones can be inserted into the old database table.  

The following table and conversion function checks if such a shift in ordering is 
required and then re-orders the database as needed.  
]]

WoW_2_Client_Translations = {
	["frFR"] = { 
		{ 16,1,2,3,4,5,6,7,8,10,11,12,13,14,15,17,18,19,20,21,9 },
		{ 1,12,2,3,4,5,7,8,10,11,6,13,14,15,16,17,18,19,20,21,22,23,24,9,25 },
	},
	["deDE"] = {
		{ 9,1,2,3,4,6,7,10,8,12,13,14,15,16,17,18,19,20,5,11,21 }, 
		{ 1,2,3,4,5,7,8,6,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25 }, 
	},
}

function ConvertDBForNewTranslations( database ) 
	if not ( WoW_2_Client_Translations[GetLocale()] ) then 
		return 
	end 
	 
	for continent, shiftData in pairs(WoW_2_Client_Translations[GetLocale()]) do 
		local cData = database[continent] 
		if ( cData ) then 
			local newContinentData = {} 
			for oldIndex, newIndex in pairs(shiftData) do 
				newContinentData[newIndex] = cData[oldIndex] 
			end 
			database[continent] = newContinentData 
		end 
	end 
end 
