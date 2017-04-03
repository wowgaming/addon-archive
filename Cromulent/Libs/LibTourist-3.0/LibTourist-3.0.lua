--[[
Name: LibTourist-3.0
Revision: $Rev: 98 $
Author(s): ckknight (ckknight@gmail.com), Arrowmaster
Website: http://ckknight.wowinterface.com/
Documentation: http://www.wowace.com/addons/libtourist-3-0/
SVN: svn://svn.wowace.com/wow/libtourist-3-0/mainline/trunk
Description: A library to provide information about zones and instances.
Dependencies: LibBabble-Zone-3.0
License: MIT

Note:
Some WOTLK data is unconfirmed / incomplete
]]

local MAJOR_VERSION = "LibTourist-3.0"
local MINOR_VERSION = 90000 + tonumber(("$Revision: 98 $"):match("(%d+)"))

if not LibStub then error(MAJOR_VERSION .. " requires LibStub") end
if not LibStub("LibBabble-Zone-3.0") then error(MAJOR_VERSION .. " requires LibBabble-Zone-3.0.") end

local Tourist, oldLib = LibStub:NewLibrary(MAJOR_VERSION, MINOR_VERSION)
if not Tourist then
	return
end
if oldLib then
	oldLib = {}
	for k, v in pairs(Tourist) do
		Tourist[k] = nil
		oldLib[k] = v
	end
end

local BZ = LibStub("LibBabble-Zone-3.0"):GetLookupTable()
local BZR = LibStub("LibBabble-Zone-3.0"):GetReverseLookupTable()

local playerLevel = 1
local _,race = UnitRace("player")
local isHorde = (race == "Orc" or race == "Troll" or race == "Tauren" or race == "Scourge" or race == "BloodElf")
local isWestern = GetLocale() == "enUS" or GetLocale() == "deDE" or GetLocale() == "frFR" or GetLocale() == "esES"

local Kalimdor, Eastern_Kingdoms, Outland, Northrend = GetMapContinents()
if not Outland then
	Outland = "Outland"
end
if not Northrend then
	Northrend = "Northrend"
end
local Azeroth = BZ["Azeroth"]

local X_Y_ZEPPELIN = "%s/%s Zeppelin"
local X_Y_BOAT = "%s/%s Boat"
local X_Y_PORTAL = "%s/%s Portal"

if GetLocale() == "zhCN" then
	X_Y_ZEPPELIN = "%s/%s 飞艇"
	X_Y_BOAT = "%s/%s 船"
	X_Y_PORTAL = "%s/%s 传送门"
elseif GetLocale() == "zhTW" then
	X_Y_ZEPPELIN = "%s/%s 飛艇"
	X_Y_BOAT = "%s/%s 船"
	X_Y_PORTAL = "%s/%s 傳送門"
elseif GetLocale() == "frFR" then
	X_Y_ZEPPELIN = "Zeppelin %s/%s"
	X_Y_BOAT = "Bateau %s/%s"
	X_Y_PORTAL = "Portail %s/%s"
elseif GetLocale() == "koKR" then
	X_Y_ZEPPELIN = "%s/%s 비행선"
	X_Y_BOAT = "%s/%s 배"
	X_Y_PORTAL = "%s/%s 차원문"
end

local recZones = {}
local recInstances = {}
local lows = setmetatable({}, {__index = function() return 0 end})
local highs = setmetatable({}, getmetatable(lows))
local continents = {}
local instances = {}
local paths = {}
local types = {}
local groupSizes = {}
local groupAltSizes = {}
local factions = {}
local yardWidths = {}
local yardHeights = {}
local yardXOffsets = {}
local yardYOffsets = {}
local fishing = {}
local cost = {}
local textures = {}
local textures_rev = {}
local complexes = {}
local entrancePortals_zone = {}
local entrancePortals_x = {}
local entrancePortals_y = {}

local function PLAYER_LEVEL_UP(self, level)
	playerLevel = level or UnitLevel("player")
	for k in pairs(recZones) do
		recZones[k] = nil
	end
	for k in pairs(recInstances) do
		recInstances[k] = nil
	end
	for k in pairs(cost) do
		cost[k] = nil
	end
	for zone in pairs(lows) do
		if not self:IsHostile(zone) then
			local low, high = self:GetLevel(zone)
			if types[zone] == "Zone" or types[zone] == "PvP Zone" and low and high then
				if low <= playerLevel and playerLevel <= high then
					recZones[zone] = true
				end
			elseif types[zone] == "Battleground" and low and high then
				local playerLevel = playerLevel
				if zone == BZ["Alterac Valley"] then
					playerLevel = playerLevel - 1
				end
				if playerLevel >= low and (playerLevel == MAX_PLAYER_LEVEL or math.fmod(playerLevel, 10) >= 6) then
					recInstances[zone] = true
				end
			elseif types[zone] == "Instance" and low and high then
				if low <= playerLevel and playerLevel <= high then
					recInstances[zone] = true
				end
			end
		end
	end
end

-- minimum fishing skill to fish these zones
function Tourist:GetFishingLevel(zone)
	return fishing[zone]
end

function Tourist:GetLevel(zone)
	if types[zone] == "Battleground" then
		if zone == BZ["Strand of the Ancients"] or ((zone == BZ["Eye of the Storm"] or zone == BZ["Alterac Valley"]) and playerLevel >= 71) then
			return 71, 80
		elseif zone == BZ["Eye of the Storm"] or (zone == BZ["Alterac Valley"] and playerLevel >= 61) then
			return 61, 70
		elseif zone == BZ["Alterac Valley"] then
			return 51, 60
		elseif playerLevel >= MAX_PLAYER_LEVEL then
			return MAX_PLAYER_LEVEL, MAX_PLAYER_LEVEL
		elseif playerLevel >= 70 then
			return 70, 79
		elseif playerLevel >= 60 then
			return 60, 69
		elseif playerLevel >= 50 then
			return 50, 59
		elseif playerLevel >= 40 then
			return 40, 49
		elseif playerLevel >= 30 then
			return 30, 39
		elseif playerLevel >= 20 or zone == BZ["Arathi Basin"] then
			return 20, 29
		else
			return 10, 19
		end
	end
	return lows[zone], highs[zone]
end

function Tourist:GetLevelColor(zone)
	if types[zone] == "Battleground" then
		if (playerLevel < 71 and zone == BZ["Strand of the Ancients"]) or (playerLevel < 61 and zone == BZ["Eye of the Storm"]) or (playerLevel < 51 and zone == BZ["Alterac Valley"]) or (playerLevel < 20 and zone == BZ["Arathi Basin"]) or (playerLevel < 10 and zone == BZ["Warsong Gulch"]) then
			return 1, 0, 0
		end
		local playerLevel = playerLevel
		if zone == BZ["Alterac Valley"] or zone == BZ["Eye of the Storm"] or zone == BZ["Strand of the Ancients"] then
			playerLevel = playerLevel - 1
		end
		if playerLevel == MAX_PLAYER_LEVEL then
			return 1, 1, 0
		end
		playerLevel = math.fmod(playerLevel, 10)
		if playerLevel <= 5 then
			return 1, playerLevel / 10, 0
		elseif playerLevel <= 7 then
			return 1, (playerLevel - 3) / 4, 0
		else
			return (9 - playerLevel) / 2, 1, 0
		end
	end
	local low, high = lows[zone], highs[zone]

	if low <= 0 and high <= 0 then
		-- City
		return 1, 1, 1
	elseif playerLevel == low and playerLevel == high then
		return 1, 1, 0
	elseif playerLevel <= low - 3 then
		return 1, 0, 0
	elseif playerLevel <= low then
		return 1, (playerLevel - low - 3) / -6, 0
	elseif playerLevel <= (low + high) / 2 then
		return 1, (playerLevel - low) / (high - low) + 0.5, 0
	elseif playerLevel <= high then
		return 2 * (playerLevel - high) / (low - high), 1, 0
	elseif playerLevel <= high + 3 then
		local num = (playerLevel - high) / 6
		return num, 1 - num, num
	else
		return 0.5, 0.5, 0.5
	end
end

function Tourist:GetFactionColor(zone)
	if factions[zone] == (isHorde and "Alliance" or "Horde") then
		return 1, 0, 0
	elseif factions[zone] == (isHorde and "Horde" or "Alliance") then
		return 0, 1, 0
	else
		return 1, 1, 0
	end
end

function Tourist:GetZoneYardSize(zone)
	return yardWidths[zone], yardHeights[zone]
end

local ekXOffset = 15525.32200715066
local ekYOffset = 672.3934326738229

local kalXOffset = -8310.762035321373
local kalYOffset = 1815.149000954498

function Tourist:GetYardDistance(zone1, x1, y1, zone2, x2, y2)
	local zone1_yardXOffset = yardXOffsets[zone1]
	if not zone1_yardXOffset then
		return nil
	end
	local zone2_yardXOffset = yardXOffsets[zone2]
	if not zone2_yardXOffset then
		return nil
	end
	local zone1_yardYOffset = yardYOffsets[zone1]
	local zone2_yardYOffset = yardYOffsets[zone2]

	local zone1_continent = continents[zone1]
	local zone2_continent = continents[zone2]
	if (zone1_continent == Outland) ~= (zone2_continent == Outland) then
		return nil
	end

	local zone1_yardWidth = yardWidths[zone1]
	local zone1_yardHeight = yardHeights[zone1]
	local zone2_yardWidth = yardWidths[zone2]
	local zone2_yardHeight = yardHeights[zone2]

	local x1_yard = zone1_yardWidth*x1
	local y1_yard = zone1_yardHeight*y1
	local x2_yard = zone2_yardWidth*x2
	local y2_yard = zone2_yardHeight*y2

	if zone1 ~= zone2 then
		x1_yard = x1_yard + zone1_yardXOffset
		y1_yard = y1_yard + zone1_yardYOffset

		x2_yard = x2_yard + zone2_yardXOffset
		y2_yard = y2_yard + zone2_yardYOffset

		if zone1_continent ~= zone2_continent then
			if zone1_continent == Kalimdor then
				x1_yard = x1_yard + kalXOffset
				y1_yard = y1_yard + kalYOffset
			elseif zone1_continent == Eastern_Kingdoms then
				x1_yard = x1_yard + ekXOffset
				y1_yard = y1_yard + ekYOffset
			end

			if zone2_continent == Kalimdor then
				x2_yard = x2_yard + kalXOffset
				y2_yard = y2_yard + kalYOffset
			elseif zone2_continent == Eastern_Kingdoms then
				x2_yard = x2_yard + ekXOffset
				y2_yard = y2_yard + ekYOffset
			end
		end
	end

	local x_diff = x1_yard - x2_yard
	local y_diff = y1_yard - y2_yard
	local dist_2 = x_diff*x_diff + y_diff*y_diff
	return dist_2^0.5
end

function Tourist:TransposeZoneCoordinate(x, y, zone1, zone2)
	if zone1 == zone2 then
		return x, y
	end

	local zone1_yardXOffset = yardXOffsets[zone1]
	if not zone1_yardXOffset then
		return nil
	end
	local zone2_yardXOffset = yardXOffsets[zone2]
	if not zone2_yardXOffset then
		return nil
	end
	local zone1_yardYOffset = yardYOffsets[zone1]
	local zone2_yardYOffset = yardYOffsets[zone2]

	local zone1_continent = continents[zone1]
	local zone2_continent = continents[zone2]
	if (zone1_continent == Outland) ~= (zone2_continent == Outland) then
		return nil
	end

	local zone1_yardWidth = yardWidths[zone1]
	local zone1_yardHeight = yardHeights[zone1]
	local zone2_yardWidth = yardWidths[zone2]
	local zone2_yardHeight = yardHeights[zone2]

	local x_yard = zone1_yardWidth*x
	local y_yard = zone1_yardHeight*y

	x_yard = x_yard + zone1_yardXOffset
	y_yard = y_yard + zone1_yardYOffset

	if zone1_continent ~= zone2_continent then
		if zone1_continent == Kalimdor then
			x_yard = x_yard + kalXOffset
			y_yard = y_yard + kalYOffset
		elseif zone1_continent == Eastern_Kingdoms then
			x_yard = x_yard + ekXOffset
			y_yard = y_yard + ekYOffset
		end

		if zone2_continent == Kalimdor then
			x_yard = x_yard - kalXOffset
			y_yard = y_yard - kalYOffset
		elseif zone2_continent == Eastern_Kingdoms then
			x_yard = x_yard - ekXOffset
			y_yard = y_yard - ekYOffset
		end
	end

	x_yard = x_yard - zone2_yardXOffset
	y_yard = y_yard - zone2_yardYOffset

	x = x_yard / zone2_yardWidth
	y = y_yard / zone2_yardHeight

	return x, y
end

local zonesToIterate = setmetatable({}, {__index = function(self, key)
	local t = {}
	self[key] = t
	for k,v in pairs(continents) do
		if v == key and v ~= k and yardXOffsets[k] then
			t[#t+1] = k
		end
	end
	return t
end})

local kal_yardWidth
local kal_yardHeight
local ek_yardWidth
local ek_yardHeight

function Tourist:GetBestZoneCoordinate(x, y, zone)
	if not kal_yardWidth then
		kal_yardWidth = yardWidths[Kalimdor]
		kal_yardHeight = yardHeights[Kalimdor]
		ek_yardWidth = yardWidths[Eastern_Kingdoms]
		ek_yardHeight = yardHeights[Eastern_Kingdoms]
	end

	local zone_yardXOffset = yardXOffsets[zone]
	if not zone_yardXOffset then
		return x, y, zone
	end
	local zone_yardYOffset = yardYOffsets[zone]

	local zone_yardWidth = yardWidths[zone]
	local zone_yardHeight = yardHeights[zone]

	local x_yard = zone_yardWidth*x
	local y_yard = zone_yardHeight*y

	x_yard = x_yard + zone_yardXOffset
	y_yard = y_yard + zone_yardYOffset

	local zone_continent = continents[zone]
	local azeroth = false
	if zone_continent == Kalimdor then
		if x_yard < 0 or y_yard < 0 or x_yard > kal_yardWidth or y_yard > kal_yardHeight then
			x_yard = x_yard + kalXOffset
			y_yard = y_yard + kalYOffset
			azeroth = true
		end
	elseif zone_continent == Eastern_Kingdoms then
		if x_yard < 0 or y_yard < 0 or x_yard > ek_yardWidth or y_yard > ek_yardHeight then
			x_yard = x_yard + ekXOffset
			y_yard = y_yard + ekYOffset
			azeroth = true
		end
	end
	if azeroth then
		local kal, ek = zone_continent ~= Kalimdor, zone_continent ~= Eastern_Kingdoms
		if kal and (x_yard < kalXOffset or y_yard < kalYOffset or x_yard > kalXOffset + kal_yardWidth or y_yard > kalYOffset + kal_yardWidth) then
			kal = false
		end
		if ek and (x_yard < ekXOffset or y_yard < ekYOffset or x_yard > ekXOffset + ek_yardWidth or y_yard > ekYOffset + ek_yardWidth) then
			ek = false
		end
		if kal then
			x_yard = x_yard - kalXOffset
			y_yard = y_yard - kalYOffset
			zone_continent = Kalimdor
		elseif ek then
			x_yard = x_yard - ekXOffset
			y_yard = y_yard - ekYOffset
			zone_continent = Eastern_Kingdoms
		else
			return x_yard / yardWidths[Azeroth], y_yard / yardHeights[Azeroth], Azeroth
		end
	end

	local best_zone, best_x, best_y, best_value

	for _,z in ipairs(zonesToIterate[zone_continent]) do
		local z_yardXOffset = yardXOffsets[z]
		local z_yardYOffset = yardYOffsets[z]
		local z_yardWidth = yardWidths[z]
		local z_yardHeight = yardHeights[z]

		local x_yd = x_yard - z_yardXOffset
		local y_yd = y_yard - z_yardYOffset

		if x_yd >= 0 and y_yd >= 0 and x_yd <= z_yardWidth and y_yd <= z_yardHeight then
			if types[z] == "City" then
				return x_yd/z_yardWidth, y_yd/z_yardHeight, z
			end
			local x_tmp = x_yd - z_yardWidth / 2
			local y_tmp = y_yd - z_yardHeight / 2
			local value = x_tmp*x_tmp + y_tmp*y_tmp
			if not best_value or value < best_value then
				best_zone = z
				best_value = value
				best_x = x_yd/z_yardWidth
				best_y = y_yd/z_yardHeight
			end
		end
	end
	if not best_zone then
		return x_yard / yardWidths[zone_continent], y_yard / yardHeights[zone_continent], zone_continent
	end
	return best_x, best_y, best_zone
end

local function retNil() return nil end
local function retOne(object, state)
	if state == object then
		return nil
	else
		return object
	end
end

local function retNormal(t, position)
	return (next(t, position))
end

local function mysort(a,b)
	if not lows[a] then
		return false
	elseif not lows[b] then
		return true
	else
		local aval, bval = groupSizes[a], groupSizes[b]
		if aval ~= bval then
			return aval < bval
		end
		aval, bval = lows[a], lows[b]
		if aval ~= bval then
			return aval < bval
		end
		aval, bval = highs[a], highs[b]
		if aval ~= bval then
			return aval < bval
		end
		return a < b
	end
end
local t = {}
local function myiter(t)
	local n = t.n
	n = n + 1
	local v = t[n]
	if v then
		t[n] = nil
		t.n = n
		return v
	else
		t.n = nil
	end
end
function Tourist:IterateZoneInstances(zone)
	local inst = instances[zone]

	if not inst then
		return retNil
	elseif type(inst) == "table" then
		for k in pairs(t) do
			t[k] = nil
		end
		for k in pairs(inst) do
			t[#t+1] = k
		end
		table.sort(t, mysort)
		t.n = 0
		return myiter, t, nil
	else
		return retOne, inst, nil
	end
end

function Tourist:GetInstanceZone(instance)
	for k, v in pairs(instances) do
		if v then
			if type(v) == "string" then
				if v == instance then
					return k
				end
			else -- table
				for l in pairs(v) do
					if l == instance then
						return k
					end
				end
			end
		end
	end
end

function Tourist:DoesZoneHaveInstances(zone)
	return not not instances[zone]
end

local zonesInstances
local function initZonesInstances()
	if not zonesInstances then
		zonesInstances = {}
		for zone, v in pairs(lows) do
			if types[zone] ~= "Transport" then
				zonesInstances[zone] = true
			end
		end
	end
	initZonesInstances = nil
end

function Tourist:IterateZonesAndInstances()
	if initZonesInstances then
		initZonesInstances()
	end
	return retNormal, zonesInstances, nil
end

local function zoneIter(_, position)
	local k = next(zonesInstances, position)
	while k ~= nil and (types[k] == "Instance" or types[k] == "Battleground") do
		k = next(zonesInstances, k)
	end
	return k
end
function Tourist:IterateZones()
	if initZonesInstances then
		initZonesInstances()
	end
	return zoneIter, nil, nil
end

local function instanceIter(_, position)
	local k = next(zonesInstances, position)
	while k ~= nil and (types[k] ~= "Instance" and types[k] ~= "Battleground") do
		k = next(zonesInstances, k)
	end
	return k
end
function Tourist:IterateInstances()
	if initZonesInstances then
		initZonesInstances()
	end
	return instanceIter, nil, nil
end

local function bgIter(_, position)
	local k = next(zonesInstances, position)
	while k ~= nil and types[k] ~= "Battleground" do
		k = next(zonesInstances, k)
	end
	return k
end
function Tourist:IterateBattlegrounds()
	if initZonesInstances then
		initZonesInstances()
	end
	return bgIter, nil, nil
end

local function pvpIter(_, position)
	local k = next(zonesInstances, position)
	while k ~= nil and types[k] ~= "PvP Zone" do
		k = next(zonesInstances, k)
	end
	return k
end
function Tourist:IteratePvPZones()
	if initZonesInstances then
		initZonesInstances()
	end
	return pvpIter, nil, nil
end

local function allianceIter(_, position)
	local k = next(zonesInstances, position)
	while k ~= nil and factions[k] ~= "Alliance" do
		k = next(zonesInstances, k)
	end
	return k
end
function Tourist:IterateAlliance()
	if initZonesInstances then
		initZonesInstances()
	end
	return allianceIter, nil, nil
end

local function hordeIter(_, position)
	local k = next(zonesInstances, position)
	while k ~= nil and factions[k] ~= "Horde" do
		k = next(zonesInstances, k)
	end
	return k
end
function Tourist:IterateHorde()
	if initZonesInstances then
		initZonesInstances()
	end
	return hordeIter, nil, nil
end

if isHorde then
	Tourist.IterateFriendly = Tourist.IterateHorde
	Tourist.IterateHostile = Tourist.IterateAlliance
else
	Tourist.IterateFriendly = Tourist.IterateAlliance
	Tourist.IterateHostile = Tourist.IterateHorde
end

local function contestedIter(_, position)
	local k = next(zonesInstances, position)
	while k ~= nil and factions[k] do
		k = next(zonesInstances, k)
	end
	return k
end
function Tourist:IterateContested()
	if initZonesInstances then
		initZonesInstances()
	end
	return contestedIter, nil, nil
end

local function kalimdorIter(_, position)
	local k = next(zonesInstances, position)
	while k ~= nil and continents[k] ~= Kalimdor do
		k = next(zonesInstances, k)
	end
	return k
end
function Tourist:IterateKalimdor()
	if initZonesInstances then
		initZonesInstances()
	end
	return kalimdorIter, nil, nil
end

local function easternKingdomsIter(_, position)
	local k = next(zonesInstances, position)
	while k ~= nil and continents[k] ~= Eastern_Kingdoms do
		k = next(zonesInstances, k)
	end
	return k
end
function Tourist:IterateEasternKingdoms()
	if initZonesInstances then
		initZonesInstances()
	end
	return easternKingdomsIter, nil, nil
end

local function outlandIter(_, position)
	local k = next(zonesInstances, position)
	while k ~= nil and continents[k] ~= Outland do
		k = next(zonesInstances, k)
	end
	return k
end
function Tourist:IterateOutland()
	if initZonesInstances then
		initZonesInstances()
	end
	return outlandIter, nil, nil
end

local function northrendIter(_, position)
	local k = next(zonesInstances, position)
	while k ~= nil and continents[k] ~= Northrend do
		k = next(zonesInstances, k)
	end
	return k
end
function Tourist:IterateNorthrend()
	if initZonesInstances then
		initZonesInstances()
	end
	return northrendIter, nil, nil
end

function Tourist:IterateRecommendedZones()
	return retNormal, recZones, nil
end

function Tourist:IterateRecommendedInstances()
	return retNormal, recInstances, nil
end

function Tourist:HasRecommendedInstances()
	return next(recInstances) ~= nil
end

function Tourist:IsInstance(zone)
	local t = types[zone]
	return t == "Instance" or t == "Battleground"
end

function Tourist:IsZone(zone)
	local t = types[zone]
	return t ~= "Instance" and t ~= "Battleground" and t ~= "Transport"
end

function Tourist:GetComplex(zone)
	return complexes[zone]
end

function Tourist:IsZoneOrInstance(zone)
	local t = types[zone]
	return t and t ~= "Transport"
end

function Tourist:IsBattleground(zone)
	local t = types[zone]
	return t == "Battleground"
end

function Tourist:IsArena(zone)
	local t = types[zone]
	return t == "Arena"
end

function Tourist:IsPvPZone(zone)
	local t = types[zone]
	return t == "PvP Zone"
end

function Tourist:IsCity(zone)
	local t = types[zone]
	return t == "City"
end

function Tourist:IsAlliance(zone)
	return factions[zone] == "Alliance"
end

function Tourist:IsHorde(zone)
	return factions[zone] == "Horde"
end

if isHorde then
	Tourist.IsFriendly = Tourist.IsHorde
	Tourist.IsHostile = Tourist.IsAlliance
else
	Tourist.IsFriendly = Tourist.IsAlliance
	Tourist.IsHostile = Tourist.IsHorde
end

function Tourist:IsContested(zone)
	return not factions[zone]
end

function Tourist:GetContinent(zone)
	return continents[zone] or UNKNOWN
end

function Tourist:IsInKalimdor(zone)
	return continents[zone] == Kalimdor
end

function Tourist:IsInEasternKingdoms(zone)
	return continents[zone] == Eastern_Kingdoms
end

function Tourist:IsInOutland(zone)
	return continents[zone] == Outland
end

function Tourist:IsInNorthrend(zone)
	return continents[zone] == Northrend
end

function Tourist:GetInstanceGroupSize(instance)
	return groupSizes[instance] or 0
end

function Tourist:GetInstanceAltGroupSize(instance)
	return groupAltSizes[instance] or 0
end

function Tourist:GetTexture(zone)
	return textures[zone]
end

function Tourist:GetZoneFromTexture(texture)
	if not texture then
		return BZ["Azeroth"]
	end
	return textures_rev[texture]
end

function Tourist:GetEnglishZoneFromTexture(texture)
	if not texture then
		return "Azeroth"
	end
	local zone = textures_rev[texture]
	if zone then
		return BZR[zone]
	end
	return nil
end

function Tourist:GetEntrancePortalLocation(instance)
	return entrancePortals_zone[instance], entrancePortals_x[instance], entrancePortals_y[instance]
end

local inf = 1/0
local stack = setmetatable({}, {__mode='k'})
local function iterator(S)
	local position = S['#'] - 1
	S['#'] = position
	local x = S[position]
	if not x then
		for k in pairs(S) do
			S[k] = nil
		end
		stack[S] = true
		return nil
	end
	return x
end

setmetatable(cost, {
	__index = function(self, vertex)
		local price = 1

		if lows[vertex] > playerLevel then
			price = price * (1 + math.ceil((lows[vertex] - playerLevel) / 6))
		end

		if factions[vertex] == (isHorde and "Horde" or "Alliance") then
			price = price / 2
		elseif factions[vertex] == (isHorde and "Alliance" or "Horde") then
			if types[vertex] == "City" then
				price = price * 10
			else
				price = price * 3
			end
		end

		if types[x] == "Transport" then
			price = price * 2
		end

		self[vertex] = price
		return price
	end
})

function Tourist:IteratePath(alpha, bravo)
	if paths[alpha] == nil or paths[bravo] == nil then
		return retNil
	end

	local d = next(stack) or {}
	stack[d] = nil
	local Q = next(stack) or {}
	stack[Q] = nil
	local S = next(stack) or {}
	stack[S] = nil
	local pi = next(stack) or {}
	stack[pi] = nil

	for vertex, v in pairs(paths) do
		d[vertex] = inf
		Q[vertex] = v
	end
	d[alpha] = 0

	while next(Q) do
		local u
		local min = inf
		for z in pairs(Q) do
			local value = d[z]
			if value < min then
				min = value
				u = z
			end
		end
		if min == inf then
			return retNil
		end
		Q[u] = nil
		if u == bravo then
			break
		end

		local adj = paths[u]
		if type(adj) == "table" then
			local d_u = d[u]
			for v in pairs(adj) do
				local c = d_u + cost[v]
				if d[v] > c then
					d[v] = c
					pi[v] = u
				end
			end
		elseif adj ~= false then
			local c = d[u] + cost[adj]
			if d[adj] > c then
				d[adj] = c
				pi[adj] = u
			end
		end
	end

	local i = 1
	local last = bravo
	while last do
		S[i] = last
		i = i + 1
		last = pi[last]
	end

	for k in pairs(pi) do
		pi[k] = nil
	end
	for k in pairs(Q) do
		Q[k] = nil
	end
	for k in pairs(d) do
		d[k] = nil
	end
	stack[pi] = true
	stack[Q] = true
	stack[d] = true

	S['#'] = i

	return iterator, S
end

local function retWithOffset(t, key)
	while true do
		key = next(t, key)
		if not key then
			return nil
		end
		if yardYOffsets[key] then
			return key
		end
	end
end

function Tourist:IterateBorderZones(zone, zonesOnly)
	local path = paths[zone]
	if not path then
		return retNil
	elseif type(path) == "table" then
		return zonesOnly and retWithOffset or retNormal, path
	else
		if zonesOnly and not yardYOffsets[path] then
			return retNil
		end
		return retOne, path
	end
end

do
	Tourist.frame = oldLib and oldLib.frame or CreateFrame("Frame", MAJOR_VERSION .. "Frame", UIParent)
	Tourist.frame:UnregisterAllEvents()
	Tourist.frame:RegisterEvent("PLAYER_LEVEL_UP")
	Tourist.frame:RegisterEvent("PLAYER_ENTERING_WORLD")
	Tourist.frame:SetScript("OnEvent", function(frame, event, ...)
		PLAYER_LEVEL_UP(Tourist, ...)
	end)

	local BOOTYBAY_RATCHET_BOAT = string.format(X_Y_BOAT, BZ["Booty Bay"], BZ["Ratchet"])
	local MENETHIL_THERAMORE_BOAT = string.format(X_Y_BOAT, BZ["Menethil Harbor"], BZ["Theramore Isle"])
	local MENETHIL_HOWLINGFJORD_BOAT = string.format(X_Y_BOAT, BZ["Menethil Harbor"], BZ["Howling Fjord"])
	local AUBERDINE_DARNASSUS_BOAT = string.format(X_Y_BOAT, BZ["Auberdine"], BZ["Darnassus"])
	local AUBERDINE_AZUREMYST_BOAT = string.format(X_Y_BOAT, BZ["Auberdine"], BZ["Azuremyst Isle"])
	local STORMWIND_AUBERDINE_BOAT = string.format(X_Y_BOAT, BZ["Stormwind City"], BZ["Auberdine"])
	local STORMWIND_BOREANTUNDRA_BOAT = string.format(X_Y_BOAT, BZ["Stormwind City"], BZ["Borean Tundra"])
	local ORGRIMMAR_BOREANTUNDRA_ZEPPELIN = string.format(X_Y_ZEPPELIN, BZ["Orgrimmar"], BZ["Borean Tundra"])
	local UNDERCITY_HOWLINGFJORD_ZEPPELIN = string.format(X_Y_ZEPPELIN, BZ["Undercity"], BZ["Howling Fjord"])
	local ORGRIMMAR_UNDERCITY_ZEPPELIN = string.format(X_Y_ZEPPELIN, BZ["Orgrimmar"], BZ["Undercity"])
	local ORGRIMMAR_GROMGOL_ZEPPELIN = string.format(X_Y_ZEPPELIN, BZ["Orgrimmar"], BZ["Grom'gol Base Camp"])
	local UNDERCITY_GROMGOL_ZEPPELIN = string.format(X_Y_ZEPPELIN, BZ["Undercity"], BZ["Grom'gol Base Camp"])
	local SHATTRATH_IRONFORGE_PORTAL = string.format(X_Y_PORTAL, BZ["Shattrath City"], BZ["Ironforge"])
	local SHATTRATH_STORMWIND_PORTAL = string.format(X_Y_PORTAL, BZ["Shattrath City"], BZ["Stormwind City"])
	local SHATTRATH_DARNASSUS_PORTAL = string.format(X_Y_PORTAL, BZ["Shattrath City"], BZ["Darnassus"])
	local SHATTRATH_ORGRIMMAR_PORTAL = string.format(X_Y_PORTAL, BZ["Shattrath City"], BZ["Orgrimmar"])
	local SHATTRATH_THUNDERBLUFF_PORTAL = string.format(X_Y_PORTAL, BZ["Shattrath City"], BZ["Thunder Bluff"])
	local SHATTRATH_UNDERCITY_PORTAL = string.format(X_Y_PORTAL, BZ["Shattrath City"], BZ["Undercity"])
	local SHATTRATH_EXODAR_PORTAL = string.format(X_Y_PORTAL, BZ["Shattrath City"], BZ["The Exodar"])
	local SHATTRATH_SILVERMOON_PORTAL = string.format(X_Y_PORTAL, BZ["Shattrath City"], BZ["Silvermoon City"])
	local SHATTRATH_QUELDANAS_PORTAL = string.format(X_Y_PORTAL, BZ["Shattrath City"], BZ["Isle of Quel'Danas"])
	local SHATTRATH_COT_PORTAL = string.format(X_Y_PORTAL, BZ["Shattrath City"], BZ["Caverns of Time"])
	local MOAKI_UNUPE_BOAT = string.format(X_Y_BOAT, BZ["Dragonblight"], BZ["Borean Tundra"]) -- TODO localize these to the village names
	local MOAKI_KAMAGUA_BOAT = string.format(X_Y_BOAT, BZ["Dragonblight"], BZ["Howling Fjord"]) -- TODO localize these to the village names
	local DALARAN_IRONFORGE_PORTAL = string.format(X_Y_PORTAL, BZ["Dalaran"], BZ["Ironforge"])
	local DALARAN_STORMWIND_PORTAL = string.format(X_Y_PORTAL, BZ["Dalaran"], BZ["Stormwind City"])
	local DALARAN_DARNASSUS_PORTAL = string.format(X_Y_PORTAL, BZ["Dalaran"], BZ["Darnassus"])
	local DALARAN_ORGRIMMAR_PORTAL = string.format(X_Y_PORTAL, BZ["Dalaran"], BZ["Orgrimmar"])
	local DALARAN_THUNDERBLUFF_PORTAL = string.format(X_Y_PORTAL, BZ["Dalaran"], BZ["Thunder Bluff"])
	local DALARAN_UNDERCITY_PORTAL = string.format(X_Y_PORTAL, BZ["Dalaran"], BZ["Undercity"])
	local DALARAN_EXODAR_PORTAL = string.format(X_Y_PORTAL, BZ["Dalaran"], BZ["The Exodar"])
	local DALARAN_SILVERMOON_PORTAL = string.format(X_Y_PORTAL, BZ["Dalaran"], BZ["Silvermoon City"])
	local DALARAN_SHATTRATH_PORTAL = string.format(X_Y_PORTAL, BZ["Dalaran"], BZ["Shattrath City"])
	local DALARAN_COT_PORTAL = string.format(X_Y_PORTAL, BZ["Dalaran"], BZ["Caverns of Time"])

	local zones = {}

	zones[BZ["Eastern Kingdoms"]] = {
		type = "Continent",
		yards = 47714.278579261,
		x_offset = 0,
		y_offset = 0,
		continent = Eastern_Kingdoms,
	}

	zones[BZ["Kalimdor"]] = {
		type = "Continent",
		yards = 36800.210572494,
		x_offset = 0,
		y_offset = 0,
		continent = Kalimdor,
	}

	zones[BZ["Outland"]] = {
		type = "Continent",
		yards = 17463.5328406368,
		x_offset = 0,
		y_offset = 0,
		continent = Outland,
	}

	zones[BZ["Northrend"]] = {
		type = "Continent",
		yards = 17751.3962441049,
		x_offset = 0,
		y_offset = 0,
		continent = Northrend,
	}

	zones[BZ["Azeroth"]] = {
		type = "Continent",
		yards = 44531.82907938571,
		x_offset = 0,
		y_offset = 0,
	}

	zones[STORMWIND_AUBERDINE_BOAT] = {
		paths = {
			[BZ["Stormwind City"]] = true,
			[BZ["Darkshore"]] = true,
		},
		faction = "Alliance",
		type = "Transport",
	}

	zones[STORMWIND_BOREANTUNDRA_BOAT] = {
		paths = {
			[BZ["Stormwind City"]] = true,
			[BZ["Borean Tundra"]] = true,
		},
		faction = "Alliance",
		type = "Transport",
	}

	zones[ORGRIMMAR_BOREANTUNDRA_ZEPPELIN] = {
		paths = {
			[BZ["Durotar"]] = true,
			[BZ["Borean Tundra"]] = true,
		},
		faction = "Horde",
		type = "Transport",
	}

	zones[UNDERCITY_HOWLINGFJORD_ZEPPELIN] = {
		paths = {
			[BZ["Tirisfal Glades"]] = true,
			[BZ["Howling Fjord"]] = true,
		},
		faction = "Horde",
		type = "Transport",
	}

	zones[AUBERDINE_AZUREMYST_BOAT] = {
		paths = {
			[BZ["Darkshore"]] = true,
			[BZ["Azuremyst Isle"]] = true,
		},
		faction = "Alliance",
		type = "Transport",
	}

	zones[AUBERDINE_DARNASSUS_BOAT] = {
		paths = {
			[BZ["Darkshore"]] = true,
			[BZ["Darnassus"]] = true,
		},
		faction = "Alliance",
		type = "Transport",
	}

	zones[BOOTYBAY_RATCHET_BOAT] = {
		paths = {
			[BZ["Stranglethorn Vale"]] = true,
			[BZ["The Barrens"]] = true,
		},
		type = "Transport",
	}

	zones[MENETHIL_HOWLINGFJORD_BOAT] = {
		paths = {
			[BZ["Wetlands"]] = true,
			[BZ["Howling Fjord"]] = true,
		},
		faction = "Alliance",
		type = "Transport",
	}

	zones[MENETHIL_THERAMORE_BOAT] = {
		paths = {
			[BZ["Wetlands"]] = true,
			[BZ["Dustwallow Marsh"]] = true,
		},
		faction = "Alliance",
		type = "Transport",
	}

	zones[ORGRIMMAR_GROMGOL_ZEPPELIN] = {
		paths = {
			[BZ["Durotar"]] = true,
			[BZ["Stranglethorn Vale"]] = true,
		},
		faction = "Horde",
		type = "Transport",
	}

	zones[ORGRIMMAR_UNDERCITY_ZEPPELIN] = {
		paths = {
			[BZ["Durotar"]] = true,
			[BZ["Tirisfal Glades"]] = true,
		},
		faction = "Horde",
		type = "Transport",
	}

	zones[SHATTRATH_DARNASSUS_PORTAL] = {
		paths = BZ["Darnassus"],
		type = "Transport",
	}

	zones[SHATTRATH_EXODAR_PORTAL] = {
		paths = BZ["The Exodar"],
		type = "Transport",
	}

	zones[SHATTRATH_IRONFORGE_PORTAL] = {
		paths = BZ["Ironforge"],
		type = "Transport",
	}

	zones[SHATTRATH_ORGRIMMAR_PORTAL] = {
		paths = BZ["Orgrimmar"],
		type = "Transport",
	}

	zones[SHATTRATH_SILVERMOON_PORTAL] = {
		paths = BZ["Silvermoon City"],
		type = "Transport",
	}

	zones[SHATTRATH_STORMWIND_PORTAL] = {
		paths = BZ["Stormwind City"],
		type = "Transport",
	}

	zones[SHATTRATH_THUNDERBLUFF_PORTAL] = {
		paths = BZ["Thunder Bluff"],
		type = "Transport",
	}

	zones[SHATTRATH_UNDERCITY_PORTAL] = {
		paths = BZ["Undercity"],
		type = "Transport",
	}

	zones[SHATTRATH_QUELDANAS_PORTAL] = {
		paths = BZ["Isle of Quel'Danas"],
		type = "Transport",
	}

	zones[SHATTRATH_COT_PORTAL] = {
		paths = BZ["Caverns of Time"],
		type = "Transport",
	}

	zones[MOAKI_UNUPE_BOAT] = {
		paths = {
			[BZ["Dragonblight"]] = true,
			[BZ["Borean Tundra"]] = true,
		},
		type = "Transport",
	}

	zones[MOAKI_KAMAGUA_BOAT] = {
		paths = {
			[BZ["Dragonblight"]] = true,
			[BZ["Howling Fjord"]] = true,
		},
		type = "Transport",
	}

	zones[BZ["The Dark Portal"]] = {
		paths = {
			[BZ["Blasted Lands"]] = true,
			[BZ["Hellfire Peninsula"]] = true,
		},
		type = "Transport",
	}

	zones[UNDERCITY_GROMGOL_ZEPPELIN] = {
		paths = {
			[BZ["Stranglethorn Vale"]] = true,
			[BZ["Tirisfal Glades"]] = true,
		},
		faction = "Horde",
		type = "Transport",
	}

	zones[DALARAN_IRONFORGE_PORTAL] = {
		paths = BZ["Ironforge"],
		type = "Transport",
	}

	zones[DALARAN_STORMWIND_PORTAL] = {
		paths = BZ["Stormwind City"],
		type = "Transport",
	}

	zones[DALARAN_DARNASSUS_PORTAL] = {
		paths = BZ["Darnassus"],
		type = "Transport",
	}

	zones[DALARAN_ORGRIMMAR_PORTAL] = {
		paths = BZ["Orgrimmar"],
		type = "Transport",
	}

	zones[DALARAN_THUNDERBLUFF_PORTAL] = {
		paths = BZ["Thunder Bluff"],
		type = "Transport",
	}

	zones[DALARAN_UNDERCITY_PORTAL] = {
		paths = BZ["Undercity"],
		type = "Transport",
	}

	zones[DALARAN_EXODAR_PORTAL] = {
		paths = BZ["The Exodar"],
		type = "Transport",
	}

	zones[DALARAN_SILVERMOON_PORTAL] = {
		paths = BZ["Silvermoon City"],
		type = "Transport",
	}

	zones[DALARAN_SHATTRATH_PORTAL] = {
		paths = BZ["Shattrath City"],
		type = "Transport",
	}

	zones[DALARAN_COT_PORTAL] = {
		paths = BZ["Caverns of Time"],
		type = "Transport",
	}

	zones[BZ["Alterac Valley"]] = {
		continent = Eastern_Kingdoms,
		paths = BZ["Alterac Mountains"],
		groupSize = 40,
		type = "Battleground",
		texture = "AlteracValley",
	}

	zones[BZ["Arathi Basin"]] = {
		continent = Eastern_Kingdoms,
		paths = BZ["Arathi Highlands"],
		groupSize = 15,
		type = "Battleground",
		texture = "ArathiBasin",
		fishing_min = 0, -- can't fish here
	}

	zones[BZ["Warsong Gulch"]] = {
		continent = Kalimdor,
		paths = isHorde and BZ["The Barrens"] or BZ["Ashenvale"],
		groupSize = 10,
		type = "Battleground",
		texture = "WarsongGulch",
	}

	zones[BZ["Deeprun Tram"]] = {
		continent = Eastern_Kingdoms,
		paths = {
			[BZ["Stormwind City"]] = true,
			[BZ["Ironforge"]] = true,
		},
		faction = "Alliance",
	}

	zones[BZ["Ironforge"]] = {
		continent = Eastern_Kingdoms,
		instances = BZ["Gnomeregan"],
		paths = {
			[BZ["Dun Morogh"]] = true,
			[BZ["Deeprun Tram"]] = true,
		},
		faction = "Alliance",
		type = "City",
		fishing_min = 1,
	}

	zones[BZ["Silvermoon City"]] = {
		continent = Eastern_Kingdoms,
		paths = {
			[BZ["Eversong Woods"]] = true,
			[BZ["Undercity"]] = true,
		},
		faction = "Horde",
		type = "City",
		fishing_min = 1,
	}

	zones[BZ["Stormwind City"]] = {
		continent = Eastern_Kingdoms,
		instances = BZ["The Stockade"],
		paths = {
			[BZ["Deeprun Tram"]] = true,
			[BZ["The Stockade"]] = true,
			[BZ["Elwynn Forest"]] = true,
			[STORMWIND_AUBERDINE_BOAT] = true,
			[STORMWIND_BOREANTUNDRA_BOAT] = true,
		},
		faction = "Alliance",
		type = "City",
		fishing_min = 1,
	}

	zones[BZ["Undercity"]] = {
		continent = Eastern_Kingdoms,
		paths = {
			[BZ["Silvermoon City"]] = true,
			[BZ["Tirisfal Glades"]] = true,
		},
		faction = "Horde",
		type = "City",
		fishing_min = 1,
	}

	zones[BZ["Dun Morogh"]] = {
		low = 1,
		high = 10,
		continent = Eastern_Kingdoms,
		instances = BZ["Gnomeregan"],
		paths = {
			[BZ["Wetlands"]] = true,
			[BZ["Gnomeregan"]] = true,
			[BZ["Ironforge"]] = true,
			[BZ["Loch Modan"]] = true,
		},
		faction = "Alliance",
		fishing_min = 1,
	}

	zones[BZ["Elwynn Forest"]] = {
		low = 1,
		high = 10,
		continent = Eastern_Kingdoms,
		instances = BZ["The Stockade"],
		paths = {
			[BZ["Westfall"]] = true,
			[BZ["Redridge Mountains"]] = true,
			[BZ["Stormwind City"]] = true,
			[BZ["Duskwood"]] = true,
		},
		faction = "Alliance",
		fishing_min = 1,
	}

	zones[BZ["Eversong Woods"]] = {
		low = 1,
		high = 10,
		continent = Eastern_Kingdoms,
		paths = {
			[BZ["Silvermoon City"]] = true,
			[BZ["Ghostlands"]] = true,
		},
		faction = "Horde",
		fishing_min = 20,
	}

	zones[BZ["Tirisfal Glades"]] = {
		low = 1,
		high = 10,
		continent = Eastern_Kingdoms,
		instances = {
			[BZ["Armory"]] = true,
			[BZ["Library"]] = true,
			[BZ["Graveyard"]] = true,
			[BZ["Cathedral"]] = true,
		},
		paths = {
			[BZ["Western Plaguelands"]] = true,
			[BZ["Undercity"]] = true,
			[BZ["Scarlet Monastery"]] = true,
			[UNDERCITY_GROMGOL_ZEPPELIN] = true,
			[ORGRIMMAR_UNDERCITY_ZEPPELIN] = true,
			[UNDERCITY_HOWLINGFJORD_ZEPPELIN] = true,
			[BZ["Silverpine Forest"]] = true,
		},
		faction = "Horde",
		fishing_min = 1,
	}

	zones[BZ["Amani Pass"]] = {
		continent = Eastern_Kingdoms,
	}

	zones[BZ["Ghostlands"]] = {
		low = 10,
		high = 20,
		continent = Eastern_Kingdoms,
		instances = BZ["Zul'Aman"],
		paths = {
			[BZ["Eastern Plaguelands"]] = true,
			[BZ["Zul'Aman"]] = true,
			[BZ["Eversong Woods"]] = true,
		},
		faction = "Horde",
		fishing_min = 20,
	}

	zones[BZ["Loch Modan"]] = {
		low = 10,
		high = 20,
		continent = Eastern_Kingdoms,
		paths = {
			[BZ["Wetlands"]] = true,
			[BZ["Badlands"]] = true,
			[BZ["Dun Morogh"]] = true,
			[BZ["Searing Gorge"]] = not isHorde and true or nil,
		},
		faction = "Alliance",
		fishing_min = 20,
	}

	zones[BZ["Silverpine Forest"]] = {
		low = 10,
		high = 20,
		continent = Eastern_Kingdoms,
		instances = BZ["Shadowfang Keep"],
		paths = {
			[BZ["Tirisfal Glades"]] = true,
			[BZ["Hillsbrad Foothills"]] = true,
			[BZ["Shadowfang Keep"]] = true,
		},
		faction = "Horde",
		fishing_min = 20,
	}

	zones[BZ["Westfall"]] = {
		low = 10,
		high = 20,
		continent = Eastern_Kingdoms,
		instances = BZ["The Deadmines"],
		paths = {
			[BZ["Duskwood"]] = true,
			[BZ["Elwynn Forest"]] = true,
			[BZ["The Deadmines"]] = true,
		},
		faction = "Alliance",
		fishing_min = 55,
	}

	zones[BZ["Redridge Mountains"]] = {
		low = 15,
		high = 25,
		continent = Eastern_Kingdoms,
		paths = {
			[BZ["Burning Steppes"]] = true,
			[BZ["Elwynn Forest"]] = true,
			[BZ["Duskwood"]] = true,
		},
		fishing_min = 55,
	}

	zones[BZ["Duskwood"]] = {
		low = 18,
		high = 30,
		continent = Eastern_Kingdoms,
		paths = {
			[BZ["Redridge Mountains"]] = true,
			[BZ["Stranglethorn Vale"]] = true,
			[BZ["Westfall"]] = true,
			[BZ["Deadwind Pass"]] = true,
			[BZ["Elwynn Forest"]] = true,
		},
		fishing_min = 55,
	}

	zones[BZ["Hillsbrad Foothills"]] = {
		low = 20,
		high = 30,
		continent = Eastern_Kingdoms,
		paths = {
			[BZ["Alterac Mountains"]] = true,
			[BZ["The Hinterlands"]] = true,
			[BZ["Arathi Highlands"]] = true,
			[BZ["Silverpine Forest"]] = true,
		},
		fishing_min = 55,
	}

	zones[BZ["Wetlands"]] = {
		low = 20,
		high = 30,
		continent = Eastern_Kingdoms,
		paths = {
			[BZ["Arathi Highlands"]] = true,
			[MENETHIL_THERAMORE_BOAT] = true,
			[MENETHIL_HOWLINGFJORD_BOAT] = true,
			[BZ["Dun Morogh"]] = true,
			[BZ["Loch Modan"]] = true,
		},
		fishing_min = 55,
	}

	zones[BZ["Alterac Mountains"]] = {
		low = 30,
		high = 40,
		continent = Eastern_Kingdoms,
		instances = BZ["Alterac Valley"],
		paths = {
			[BZ["Western Plaguelands"]] = true,
			[BZ["Alterac Valley"]] = true,
			[BZ["Hillsbrad Foothills"]] = true,
		},
		fishing_min = 130,
	}

	zones[BZ["Arathi Highlands"]] = {
		low = 30,
		high = 40,
		continent = Eastern_Kingdoms,
		instances = BZ["Arathi Basin"],
		paths = {
			[BZ["Wetlands"]] = true,
			[BZ["Hillsbrad Foothills"]] = true,
			[BZ["Arathi Basin"]] = true,
		},
		fishing_min = 130,
	}

	zones[BZ["Stranglethorn Vale"]] = {
		low = 30,
		high = 45,
		continent = Eastern_Kingdoms,
		instances = BZ["Zul'Gurub"],
		paths = {
			[BZ["Zul'Gurub"]] = true,
			[BOOTYBAY_RATCHET_BOAT] = true,
			[BZ["Duskwood"]] = true,
			[ORGRIMMAR_GROMGOL_ZEPPELIN] = true,
			[UNDERCITY_GROMGOL_ZEPPELIN] = true,
		},
		fishing_min = 130,
	}

	zones[BZ["Badlands"]] = {
		low = 35,
		high = 45,
		continent = Eastern_Kingdoms,
		instances = BZ["Uldaman"],
		paths = {
			[BZ["Uldaman"]] = true,
			[BZ["Searing Gorge"]] = true,
			[BZ["Loch Modan"]] = true,
		},
	}

	zones[BZ["Swamp of Sorrows"]] = {
		low = 35,
		high = 45,
		continent = Eastern_Kingdoms,
		instances = BZ["The Temple of Atal'Hakkar"],
		paths = {
			[BZ["Blasted Lands"]] = true,
			[BZ["Deadwind Pass"]] = true,
			[BZ["The Temple of Atal'Hakkar"]] = true,
		},
		fishing_min = 130,
	}

	zones[BZ["The Hinterlands"]] = {
		low = 45,
		high = 50,
		continent = Eastern_Kingdoms,
		paths = {
			[BZ["Hillsbrad Foothills"]] = true,
			[BZ["Western Plaguelands"]] = true,
		},
		fishing_min = 205,
	}

	zones[BZ["Searing Gorge"]] = {
		low = 43,
		high = 50,
		continent = Eastern_Kingdoms,
		instances = {
			[BZ["Blackrock Depths"]] = true,
			[BZ["Blackwing Lair"]] = true,
			[BZ["Molten Core"]] = true,
			[BZ["Blackrock Spire"]] = true,
		},
		paths = {
			[BZ["Blackrock Mountain"]] = true,
			[BZ["Badlands"]] = true,
			[BZ["Loch Modan"]] = not isHorde and true or nil,
		},
	}

	zones[BZ["Blackrock Mountain"]] = {
		low = 42,
		high = 54,
		continent = Eastern_Kingdoms,
		instances = {
			[BZ["Blackrock Depths"]] = true,
			[BZ["Blackwing Lair"]] = true,
			[BZ["Molten Core"]] = true,
			[BZ["Blackrock Spire"]] = true,
		},
		paths = {
			[BZ["Burning Steppes"]] = true,
			[BZ["Blackwing Lair"]] = true,
			[BZ["Molten Core"]] = true,
			[BZ["Blackrock Depths"]] = true,
			[BZ["Searing Gorge"]] = true,
			[BZ["Blackrock Spire"]] = true,
		},
	}

	zones[BZ["Deadwind Pass"]] = {
		low = 55,
		high = 60,
		continent = Eastern_Kingdoms,
		instances = BZ["Karazhan"],
		paths = {
			[BZ["Duskwood"]] = true,
			[BZ["Swamp of Sorrows"]] = true,
			[BZ["Karazhan"]] = true,
		},
		fishing_min = 330,
	}

	zones[BZ["Blasted Lands"]] = {
		low = 45,
		high = 55,
		continent = Eastern_Kingdoms,
		paths = {
			[BZ["The Dark Portal"]] = true,
			[BZ["Swamp of Sorrows"]] = true,
		},
	}

	zones[BZ["Burning Steppes"]] = {
		low = 50,
		high = 58,
		continent = Eastern_Kingdoms,
		instances = {
			[BZ["Blackrock Depths"]] = true,
			[BZ["Blackwing Lair"]] = true,
			[BZ["Molten Core"]] = true,
			[BZ["Blackrock Spire"]] = true,
		},
		paths = {
			[BZ["Blackrock Mountain"]] = true,
			[BZ["Redridge Mountains"]] = true,
		},
		fishing_min = 330,
	}

	zones[BZ["Western Plaguelands"]] = {
		low = 51,
		high = 58,
		continent = Eastern_Kingdoms,
		instances = BZ["Scholomance"],
		paths = {
			[BZ["The Hinterlands"]] = true,
			[BZ["Eastern Plaguelands"]] = true,
			[BZ["Tirisfal Glades"]] = true,
			[BZ["Scholomance"]] = true,
			[BZ["Alterac Mountains"]] = true,
		},
		fishing_min = 205,
	}

	zones[BZ["Eastern Plaguelands"]] = {
		low = 53,
		high = 60,
		continent = Eastern_Kingdoms,
		instances = BZ["Stratholme"],
		paths = {
			[BZ["Western Plaguelands"]] = true,
			[BZ["Stratholme"]] = true,
			[BZ["Ghostlands"]] = true,
		},
		type = "PvP Zone",
		fishing_min = 330,
	}

	zones[BZ["The Deadmines"]] = {
		low = 16,
		high = 24,
		continent = Eastern_Kingdoms,
		paths = BZ["Westfall"],
		groupSize = 5,
		faction = "Alliance",
		type = "Instance",
		fishing_min = 20,
		entrancePortal = { BZ["Westfall"], 42.6, 72.2 },
	}

	zones[BZ["Shadowfang Keep"]] = {
		low = 17,
		high = 25,
		continent = Eastern_Kingdoms,
		paths = BZ["Silverpine Forest"],
		groupSize = 5,
		faction = "Horde",
		type = "Instance",
		entrancePortal = { BZ["Silverpine Forest"], 44.80, 67.83 },
	}

	zones[BZ["The Stockade"]] = {
		low = 21,
		high = 29,
		continent = Eastern_Kingdoms,
		paths = BZ["Stormwind City"],
		groupSize = 5,
		faction = "Alliance",
		type = "Instance",
		entrancePortal = { BZ["Stormwind City"], 40.6, 55.8 },
	}

	zones[BZ["Gnomeregan"]] = {
		low = 24,
		high = 40,
		continent = Eastern_Kingdoms,
		paths = BZ["Dun Morogh"],
		groupSize = 5,
		faction = "Alliance",
		type = "Instance",
		entrancePortal = { BZ["Dun Morogh"], 24, 38.9 },
	}

	zones[BZ["Scarlet Monastery"]] = {
		low = 28,
		high = 44,
		continent = Eastern_Kingdoms,
		instances = {
			[BZ["Armory"]] = true,
			[BZ["Library"]] = true,
			[BZ["Graveyard"]] = true,
			[BZ["Cathedral"]] = true,
		},
		paths = {
			[BZ["Tirisfal Glades"]] = true,
			[BZ["Armory"]] = true,
			[BZ["Library"]] = true,
			[BZ["Graveyard"]] = true,
			[BZ["Cathedral"]] = true,
		},
		faction = "Horde",
		entrancePortal = { BZ["Tirisfal Glades"], 84.4, 32.9 },
	}

	zones[BZ["Graveyard"]] = {
		low = 28,
		high = 44,
		continent = Eastern_Kingdoms,
		paths = BZ["Scarlet Monastery"],
		groupSize = 5,
		type = "Instance",
		complex = BZ["Scarlet Monastery"],
		entrancePortal = { BZ["Tirisfal Glades"], 84.88, 30.63 },
	}

	zones[BZ["Library"]] = {
		low = 28,
		high = 44,
		continent = Eastern_Kingdoms,
		paths = BZ["Scarlet Monastery"],
		groupSize = 5,
		type = "Instance",
		complex = BZ["Scarlet Monastery"],
		entrancePortal = { BZ["Tirisfal Glades"], 85.30, 32.17 },
	}

	zones[BZ["Armory"]] = {
		low = 28,
		high = 44,
		continent = Eastern_Kingdoms,
		paths = BZ["Scarlet Monastery"],
		groupSize = 5,
		type = "Instance",
		complex = BZ["Scarlet Monastery"],
		entrancePortal = { BZ["Tirisfal Glades"], 85.63, 31.62 },
	}

	zones[BZ["Cathedral"]] = {
		low = 28,
		high = 44,
		continent = Eastern_Kingdoms,
		paths = BZ["Scarlet Monastery"],
		groupSize = 5,
		type = "Instance",
		complex = BZ["Scarlet Monastery"],
		entrancePortal = { BZ["Tirisfal Glades"], 85.35, 30.57 },
	}

	zones[BZ["Uldaman"]] = {
		low = 36,
		high = 44,
		continent = Eastern_Kingdoms,
		paths = BZ["Badlands"],
		groupSize = 5,
		type = "Instance",
		entrancePortal = { BZ["Badlands"], 42.4, 18.6 },
	}

	zones[BZ["The Temple of Atal'Hakkar"]] = {
		low = 45,
		high = 54,
		continent = Eastern_Kingdoms,
		paths = BZ["Swamp of Sorrows"],
		groupSize = 5,
		type = "Instance",
		fishing_min = 205,
		entrancePortal = { BZ["Swamp of Sorrows"], 70, 54 },
	}

	zones[BZ["Blackrock Depths"]] = {
		low = 48,
		high = 60,
		continent = Eastern_Kingdoms,
		paths = {
			[BZ["Molten Core"]] = true,
			[BZ["Blackrock Mountain"]] = true,
		},
		groupSize = 5,
		type = "Instance",
		entrancePortal = { BZ["Searing Gorge"], 35.4, 84.4 },
	}

	zones[BZ["Blackrock Spire"]] = {
		low = 53,
		high = 61,
		continent = Eastern_Kingdoms,
		paths = {
			[BZ["Blackrock Mountain"]] = true,
			[BZ["Blackwing Lair"]] = true,
		},
		groupSize = 10,
		type = "Instance",
		entrancePortal = { BZ["Burning Steppes"], 29.7, 37.5 },
	}

	zones[BZ["Scholomance"]] = {
		low = 56,
		high = 61,
		continent = Eastern_Kingdoms,
		paths = BZ["Western Plaguelands"],
		groupSize = 5,
		type = "Instance",
		fishing_min = 330,
		entrancePortal = { BZ["Western Plaguelands"], 69.4, 72.8 },
	}

	zones[BZ["Stratholme"]] = {
		low = 56,
		high = 61,
		continent = Eastern_Kingdoms,
		paths = BZ["Eastern Plaguelands"],
		groupSize = 5,
		type = "Instance",
		fishing_min = 330,
		entrancePortal = { BZ["Eastern Plaguelands"], 30.8, 14.4 },
	}

	zones[BZ["Blackwing Lair"]] = {
		low = 60,
		high = 62,
		continent = Eastern_Kingdoms,
		paths = BZ["Blackrock Mountain"],
		groupSize = 40,
		type = "Instance",
		entrancePortal = { BZ["Burning Steppes"], 29.7, 37.5 },
	}

	zones[BZ["Molten Core"]] = {
		low = 60,
		high = 62,
		continent = Eastern_Kingdoms,
		paths = BZ["Blackrock Mountain"],
		groupSize = 40,
		type = "Instance",
		entrancePortal = { BZ["Searing Gorge"], 35.4, 84.4 },
	}

	zones[BZ["Zul'Gurub"]] = {
		low = 60,
		high = 62,
		continent = Eastern_Kingdoms,
		paths = BZ["Stranglethorn Vale"],
		groupSize = 20,
		type = "Instance",
		fishing_min = 330,
		entrancePortal = { BZ["Stranglethorn Vale"], 52.2, 17.1 },
	}

	zones[BZ["Karazhan"]] = {
		low = 70,
		high = 72,
		continent = Eastern_Kingdoms,
		paths = BZ["Deadwind Pass"],
		groupSize = 10,
		type = "Instance",
		entrancePortal = { BZ["Deadwind Pass"], 40.9, 73.2 },
	}

	zones[BZ["Zul'Aman"]] = {
		low = 70,
		high = 72,
		continent = Eastern_Kingdoms,
		paths = BZ["Ghostlands"],
		groupSize = 10,
		type = "Instance",
		entrancePortal = { BZ["Ghostlands"], 77.7, 63.2 },
	}

	zones[BZ["Darnassus"]] = {
		continent = Kalimdor,
		paths = {
			[BZ["Teldrassil"]] = true,
			[AUBERDINE_DARNASSUS_BOAT] = true,
		},
		faction = "Alliance",
		type = "City",
		fishing_min = 1,
	}

	zones[BZ["Hyjal"]] = {
		continent = Kalimdor,
	}

	zones[BZ["Moonglade"]] = {
		continent = Kalimdor,
		paths = {
			[BZ["Felwood"]] = true,
			[BZ["Winterspring"]] = true,
		},
		fishing_min = 205,
	}

	zones[BZ["Orgrimmar"]] = {
		continent = Kalimdor,
		instances = BZ["Ragefire Chasm"],
		paths = {
			[BZ["Durotar"]] = true,
			[BZ["Ragefire Chasm"]] = true,
		},
		faction = "Horde",
		type = "City",
		fishing_min = 1,
	}

	zones[BZ["The Exodar"]] = {
		continent = Kalimdor,
		paths = BZ["Azuremyst Isle"],
		faction = "Alliance",
		type = "City",
		fishing_min = 1,
	}

	zones[BZ["Thunder Bluff"]] = {
		continent = Kalimdor,
		paths = BZ["Mulgore"],
		faction = "Horde",
		type = "City",
		fishing_min = 1,
	}

	zones[BZ["Azuremyst Isle"]] = {
		low = 1,
		high = 10,
		continent = Kalimdor,
		paths = {
			[BZ["The Exodar"]] = true,
			[BZ["Bloodmyst Isle"]] = true,
			[AUBERDINE_AZUREMYST_BOAT] = true,
		},
		faction = "Alliance",
		fishing_min = 20,
	}

	zones[BZ["Durotar"]] = {
		low = 1,
		high = 10,
		continent = Kalimdor,
		instances = BZ["Ragefire Chasm"],
		paths = {
			[ORGRIMMAR_UNDERCITY_ZEPPELIN] = true,
			[ORGRIMMAR_GROMGOL_ZEPPELIN] = true,
			[ORGRIMMAR_BOREANTUNDRA_ZEPPELIN] = true,
			[BZ["The Barrens"]] = true,
			[BZ["Orgrimmar"]] = true,
		},
		faction = "Horde",
		fishing_min = 1,
	}

	zones[BZ["Mulgore"]] = {
		low = 1,
		high = 10,
		continent = Kalimdor,
		paths = {
			[BZ["Thunder Bluff"]] = true,
			[BZ["The Barrens"]] = true,
		},
		faction = "Horde",
		fishing_min = 1,
	}

	zones[BZ["Teldrassil"]] = {
		low = 1,
		high = 10,
		continent = Kalimdor,
		paths = BZ["Darnassus"],
		faction = "Alliance",
		fishing_min = 1,
	}

	zones[BZ["Bloodmyst Isle"]] = {
		low = 10,
		high = 20,
		continent = Kalimdor,
		paths = BZ["Azuremyst Isle"],
		faction = "Alliance",
		fishing_min = 1,
	}

	zones[BZ["Darkshore"]] = {
		low = 10,
		high = 20,
		continent = Kalimdor,
		paths = {
			[AUBERDINE_DARNASSUS_BOAT] = true,
			[AUBERDINE_AZUREMYST_BOAT] = true,
			[STORMWIND_AUBERDINE_BOAT] = true,
			[BZ["Ashenvale"]] = true,
		},
		faction = "Alliance",
		fishing_min = 20,
	}

	zones[BZ["The Barrens"]] = {
		low = 10,
		high = 25,
		continent = Kalimdor,
		instances = {
			[BZ["Razorfen Kraul"]] = true,
			[BZ["Wailing Caverns"]] = true,
			[BZ["Razorfen Downs"]] = true,
			[BZ["Warsong Gulch"]] = isHorde and true or nil,
		},
		paths = {
			[BZ["Thousand Needles"]] = true,
			[BZ["Razorfen Kraul"]] = true,
			[BZ["Ashenvale"]] = true,
			[BZ["Durotar"]] = true,
			[BZ["Wailing Caverns"]] = true,
			[BOOTYBAY_RATCHET_BOAT] = true,
			[BZ["Dustwallow Marsh"]] = true,
			[BZ["Razorfen Downs"]] = true,
			[BZ["Stonetalon Mountains"]] = true,
			[BZ["Mulgore"]] = true,
			[BZ["Warsong Gulch"]] = isHorde and true or nil,
		},
		faction = "Horde",
		fishing_min = 20,
	}

	zones[BZ["Stonetalon Mountains"]] = {
		low = 15,
		high = 27,
		continent = Kalimdor,
		paths = {
			[BZ["Desolace"]] = true,
			[BZ["The Barrens"]] = true,
			[BZ["Ashenvale"]] = true,
		},
		fishing_min = 55,
	}

	zones[BZ["Ashenvale"]] = {
		low = 18,
		high = 30,
		continent = Kalimdor,
		instances = {
			[BZ["Blackfathom Deeps"]] = true,
			[BZ["Warsong Gulch"]] = not isHorde and true or nil,
		},
		paths = {
			[BZ["Azshara"]] = true,
			[BZ["The Barrens"]] = true,
			[BZ["Blackfathom Deeps"]] = true,
			[BZ["Warsong Gulch"]] = not isHorde and true or nil,
			[BZ["Felwood"]] = true,
			[BZ["Darkshore"]] = true,
			[BZ["Stonetalon Mountains"]] = true,
		},
		fishing_min = 55,
	}

	zones[BZ["Thousand Needles"]] = {
		low = 25,
		high = 35,
		continent = Kalimdor,
		paths = {
			[BZ["Feralas"]] = true,
			[BZ["The Barrens"]] = true,
			[BZ["Tanaris"]] = true,
		},
		fishing_min = 130,
	}

	zones[BZ["Desolace"]] = {
		low = 30,
		high = 40,
		continent = Kalimdor,
		instances = BZ["Maraudon"],
		paths = {
			[BZ["Feralas"]] = true,
			[BZ["Stonetalon Mountains"]] = true,
			[BZ["Maraudon"]] = true,
		},
		fishing_min = 130,
	}

	zones[BZ["Dustwallow Marsh"]] = {
		low = 35,
		high = 45,
		continent = Kalimdor,
		instances = BZ["Onyxia's Lair"],
		paths = {
			[BZ["Onyxia's Lair"]] = true,
			[BZ["The Barrens"]] = true,
			[MENETHIL_THERAMORE_BOAT] = true,
		},
		fishing_min = 130,
	}

	zones[BZ["Feralas"]] = {
		low = 40,
		high = 50,
		continent = Kalimdor,
		instances = BZ["Dire Maul"],
		paths = {
			[BZ["Thousand Needles"]] = true,
			[BZ["Desolace"]] = true,
			[BZ["Dire Maul"]] = true,
		},
		fishing_min = 205,
	}

	zones[BZ["Tanaris"]] = {
		low = 40,
		high = 50,
		continent = Kalimdor,
		instances = {
			[BZ["Zul'Farrak"]] = true,
			[BZ["Old Hillsbrad Foothills"]] = true,
			[BZ["The Black Morass"]] = true,
			[BZ["Hyjal Summit"]] = true,
			[BZ["The Culling of Stratholme"]] = true,
		},
		paths = {
			[BZ["Thousand Needles"]] = true,
			[BZ["Un'Goro Crater"]] = true,
			[BZ["Zul'Farrak"]] = true,
			[BZ["Caverns of Time"]] = true,
		},
		fishing_min = 205,
	}

	zones[BZ["Azshara"]] = {
		low = 45,
		high = 55,
		continent = Kalimdor,
		paths = BZ["Ashenvale"],
		fishing_min = 205,
	}

	zones[BZ["Felwood"]] = {
		low = 48,
		high = 55,
		continent = Kalimdor,
		paths = {
			[BZ["Winterspring"]] = true,
			[BZ["Moonglade"]] = true,
			[BZ["Ashenvale"]] = true,
		},
		fishing_min = 205,
	}

	zones[BZ["Un'Goro Crater"]] = {
		low = 48,
		high = 55,
		continent = Kalimdor,
		paths = {
			[BZ["Silithus"]] = true,
			[BZ["Tanaris"]] = true,
		},
		fishing_min = 205,
	}

	zones[BZ["Silithus"]] = {
		low = 55,
		high = 60,
		continent = Kalimdor,
		instances = {
			[BZ["Ahn'Qiraj"]] = true,
			[BZ["Ruins of Ahn'Qiraj"]] = true,
		},
		paths = {
			[BZ["Ruins of Ahn'Qiraj"]] = true,
			[BZ["Un'Goro Crater"]] = true,
			[BZ["Ahn'Qiraj"]] = true,
		},
		type = "PvP Zone",
		fishing_min = 330,
	}

	zones[BZ["Winterspring"]] = {
		low = 53,
		high = 60,
		continent = Kalimdor,
		paths = {
			[BZ["Felwood"]] = true,
			[BZ["Moonglade"]] = true,
		},
		fishing_min = 330,
	}

	zones[BZ["Ragefire Chasm"]] = {
		low = 13,
		high = 20,
		continent = Kalimdor,
		paths = BZ["Orgrimmar"],
		groupSize = 5,
		faction = "Horde",
		type = "Instance",
		entrancePortal = { BZ["Orgrimmar"], 52.8, 49 },
	}

	zones[BZ["Wailing Caverns"]] = {
		low = 16,
		high = 24,
		continent = Kalimdor,
		paths = BZ["The Barrens"],
		groupSize = 5,
		faction = "Horde",
		type = "Instance",
		fishing_min = 20,
		entrancePortal = { BZ["The Barrens"], 52.40, 55.20 },
	}

	zones[BZ["Blackfathom Deeps"]] = {
		low = 20,
		high = 28,
		continent = Kalimdor,
		paths = BZ["Ashenvale"],
		groupSize = 5,
		type = "Instance",
		fishing_min = 20,
		entrancePortal = { BZ["Ashenvale"], 14.6, 15.3 },
	}

	zones[BZ["Razorfen Kraul"]] = {
		low = 23,
		high = 31,
		continent = Kalimdor,
		paths = BZ["The Barrens"],
		groupSize = 5,
		type = "Instance",
		entrancePortal = { BZ["The Barrens"], 40.6, 89.6 },
	}

	zones[BZ["Razorfen Downs"]] = {
		low = 33,
		high = 41,
		continent = Kalimdor,
		paths = BZ["The Barrens"],
		groupSize = 5,
		type = "Instance",
		entrancePortal = { BZ["The Barrens"], 47, 88.1 },
	}

	zones[BZ["Zul'Farrak"]] = {
		low = 42,
		high = 50,
		continent = Kalimdor,
		paths = BZ["Tanaris"],
		groupSize = 5,
		type = "Instance",
		entrancePortal = { BZ["Tanaris"], 36, 11.7 },
	}

	zones[BZ["Maraudon"]] = {
		low = 40,
		high = 52,
		continent = Kalimdor,
		paths = BZ["Desolace"],
		groupSize = 5,
		type = "Instance",
		fishing_min = 205,
		entrancePortal = { BZ["Desolace"], 29, 62.4 },
	}

	zones[BZ["Dire Maul"]] = {
		low = 54,
		high = 61,
		continent = Kalimdor,
		paths = BZ["Feralas"],
		groupSize = 5,
		type = "Instance",
		entrancePortal = { BZ["Feralas"], 58.5, 44.1 },
	}

	zones[BZ["Onyxia's Lair"]] = {
		low = 80,
		high = 80,
		continent = Kalimdor,
		paths = BZ["Dustwallow Marsh"],
		groupSize = 10,
		altGroupSize = 25,
		type = "Instance",
		entrancePortal = { BZ["Dustwallow Marsh"], 52, 76 },
	}

	zones[BZ["Ahn'Qiraj"]] = {
		low = 60,
		high = 62,
		continent = Kalimdor,
		paths = BZ["Silithus"],
		groupSize = 40,
		type = "Instance",
		entrancePortal = { BZ["Silithus"], 29.3, 94 },
	}

	zones[BZ["Ruins of Ahn'Qiraj"]] = {
		low = 60,
		high = 62,
		continent = Kalimdor,
		paths = BZ["Silithus"],
		groupSize = 20,
		type = "Instance",
		entrancePortal = { BZ["Silithus"], 29.3, 94 },
	}

	zones[BZ["Caverns of Time"]] = {
		continent = Kalimdor,
		instances = {
			[BZ["Old Hillsbrad Foothills"]] = true,
			[BZ["The Black Morass"]] = true,
			[BZ["Hyjal Summit"]] = true,
			[BZ["The Culling of Stratholme"]] = true,
		},
		paths = {
			[BZ["Tanaris"]] = true,
			[BZ["Old Hillsbrad Foothills"]] = true,
			[BZ["The Black Morass"]] = true,
			[BZ["Hyjal Summit"]] = true,
			[BZ["The Culling of Stratholme"]] = true,
		},
		entrancePortal = { BZ["Tanaris"], 66.2, 49.3 },
	}

	zones[BZ["Old Hillsbrad Foothills"]] = {
		low = 66,
		high = 68,
		continent = Kalimdor,
		paths = BZ["Caverns of Time"],
		groupSize = 5,
		type = "Instance",
		complex = BZ["Caverns of Time"],
		entrancePortal = { BZ["Tanaris"], 66.2, 49.3 },
	}

	zones[BZ["The Black Morass"]] = {
		low = 69,
		high = 72,
		continent = Kalimdor,
		paths = BZ["Caverns of Time"],
		groupSize = 5,
		type = "Instance",
		complex = BZ["Caverns of Time"],
		entrancePortal = { BZ["Tanaris"], 66.2, 49.3 },
	}

	zones[BZ["The Culling of Stratholme"]] = {
		low = 80,
		high = 80,
		continent = Kalimdor,
		paths = BZ["Caverns of Time"],
		groupSize = 5,
		type = "Instance",
		complex = BZ["Caverns of Time"],
		entrancePortal = { BZ["Tanaris"], 66.2, 49.3 },
	}

	zones[BZ["Hyjal Summit"]] = {
		low = 70,
		high = 72,
		continent = Kalimdor,
		paths = BZ["Caverns of Time"],
		groupSize = 25,
		type = "Instance",
		complex = BZ["Caverns of Time"],
		entrancePortal = { BZ["Tanaris"], 66.2, 49.3 },
	}

	zones[BZ["Shattrath City"]] = {
		continent = Outland,
		paths = {
			[SHATTRATH_THUNDERBLUFF_PORTAL] = true,
			[SHATTRATH_STORMWIND_PORTAL] = true,
			[SHATTRATH_UNDERCITY_PORTAL] = true,
			[BZ["Terokkar Forest"]] = true,
			[SHATTRATH_SILVERMOON_PORTAL] = true,
			[SHATTRATH_EXODAR_PORTAL] = true,
			[SHATTRATH_DARNASSUS_PORTAL] = true,
			[SHATTRATH_ORGRIMMAR_PORTAL] = true,
			[SHATTRATH_IRONFORGE_PORTAL] = true,
			[BZ["Nagrand"]] = true,
			[SHATTRATH_QUELDANAS_PORTAL] = true,
			--[SHATTRATH_COT_PORTAL] = true,
		},
		type = "City",
	}

	zones[BZ["Hellfire Citadel"]] = {
		continent = Outland,
		instances = {
			[BZ["The Blood Furnace"]] = true,
			[BZ["Hellfire Ramparts"]] = true,
			[BZ["Magtheridon's Lair"]] = true,
			[BZ["The Shattered Halls"]] = true,
		},
		paths = {
			[BZ["Hellfire Peninsula"]] = true,
			[BZ["The Blood Furnace"]] = true,
			[BZ["Hellfire Ramparts"]] = true,
			[BZ["Magtheridon's Lair"]] = true,
			[BZ["The Shattered Halls"]] = true,
		},
		entrancePortal = { BZ["Hellfire Peninsula"], 46.8, 54.9 },
	}

	zones[BZ["Hellfire Peninsula"]] = {
		low = 58,
		high = 63,
		continent = Outland,
		instances = {
			[BZ["The Blood Furnace"]] = true,
			[BZ["Hellfire Ramparts"]] = true,
			[BZ["Magtheridon's Lair"]] = true,
			[BZ["The Shattered Halls"]] = true,
		},
		paths = {
			[BZ["Zangarmarsh"]] = true,
			[BZ["The Dark Portal"]] = true,
			[BZ["Terokkar Forest"]] = true,
			[BZ["Hellfire Citadel"]] = true,
		},
		type = "PvP Zone",
		fishing_min = 280,
	}

	zones[BZ["Coilfang Reservoir"]] = {
		continent = Outland,
		instances = {
			[BZ["The Underbog"]] = true,
			[BZ["Serpentshrine Cavern"]] = true,
			[BZ["The Steamvault"]] = true,
			[BZ["The Slave Pens"]] = true,
		},
		paths = {
			[BZ["Zangarmarsh"]] = true,
			[BZ["The Underbog"]] = true,
			[BZ["Serpentshrine Cavern"]] = true,
			[BZ["The Steamvault"]] = true,
			[BZ["The Slave Pens"]] = true,
		},
		entrancePortal = { BZ["Zangarmarsh"], 50.2, 40.8 },
	}

	zones[BZ["Zangarmarsh"]] = {
		low = 60,
		high = 64,
		continent = Outland,
		instances = {
			[BZ["The Underbog"]] = true,
			[BZ["Serpentshrine Cavern"]] = true,
			[BZ["The Steamvault"]] = true,
			[BZ["The Slave Pens"]] = true,
		},
		paths = {
			[BZ["Coilfang Reservoir"]] = true,
			[BZ["Blade's Edge Mountains"]] = true,
			[BZ["Terokkar Forest"]] = true,
			[BZ["Nagrand"]] = true,
			[BZ["Hellfire Peninsula"]] = true,
		},
		type = "PvP Zone",
		fishing_min = 305,
	}

	zones[BZ["Ring of Observance"]] = {
		continent = Outland,
		instances = {
			[BZ["Mana-Tombs"]] = true,
			[BZ["Sethekk Halls"]] = true,
			[BZ["Shadow Labyrinth"]] = true,
			[BZ["Auchenai Crypts"]] = true,
		},
		paths = {
			[BZ["Terokkar Forest"]] = true,
			[BZ["Mana-Tombs"]] = true,
			[BZ["Sethekk Halls"]] = true,
			[BZ["Shadow Labyrinth"]] = true,
			[BZ["Auchenai Crypts"]] = true,
		},
		entrancePortal = { BZ["Terokkar Forest"], 39.6, 65.5 },
	}

	zones[BZ["Terokkar Forest"]] = {
		low = 62,
		high = 65,
		continent = Outland,
		instances = {
			[BZ["Mana-Tombs"]] = true,
			[BZ["Sethekk Halls"]] = true,
			[BZ["Shadow Labyrinth"]] = true,
			[BZ["Auchenai Crypts"]] = true,
		},
		paths = {
			[BZ["Ring of Observance"]] = true,
			[BZ["Shadowmoon Valley"]] = true,
			[BZ["Zangarmarsh"]] = true,
			[BZ["Shattrath City"]] = true,
			[BZ["Hellfire Peninsula"]] = true,
			[BZ["Nagrand"]] = true,
		},
		type = "PvP Zone",
		fishing_min = 355,
	}

	zones[BZ["Nagrand"]] = {
		low = 64,
		high = 67,
		continent = Outland,
		paths = {
			[BZ["Zangarmarsh"]] = true,
			[BZ["Shattrath City"]] = true,
			[BZ["Terokkar Forest"]] = true,
		},
		type = "PvP Zone",
		fishing_min = 380,
	}

	zones[BZ["Blade's Edge Mountains"]] = {
		low = 65,
		high = 68,
		continent = Outland,
		instances = BZ["Gruul's Lair"],
		paths = {
			[BZ["Netherstorm"]] = true,
			[BZ["Zangarmarsh"]] = true,
			[BZ["Gruul's Lair"]] = true,
		},
	}

	zones[BZ["Tempest Keep"]] = {
		continent = Outland,
		instances = {
			[BZ["The Mechanar"]] = true,
			[BZ["The Eye"]] = true,
			[BZ["The Botanica"]] = true,
			[BZ["The Arcatraz"]] = true,
		},
		paths = {
			[BZ["Netherstorm"]] = true,
			[BZ["The Mechanar"]] = true,
			[BZ["The Eye"]] = true,
			[BZ["The Botanica"]] = true,
			[BZ["The Arcatraz"]] = true,
		},
		entrancePortal = { BZ["Netherstorm"], 76.5, 65.1 },
	}

	zones[BZ["Netherstorm"]] = {
		low = 67,
		high = 70,
		continent = Outland,
		instances = {
			[BZ["The Mechanar"]] = true,
			[BZ["The Botanica"]] = true,
			[BZ["The Arcatraz"]] = true,
			[BZ["The Eye"]] = true,
		},
		paths = {
			[BZ["Tempest Keep"]] = true,
			[BZ["Blade's Edge Mountains"]] = true,
		},
		fishing_min = 380,
	}

	zones[BZ["Shadowmoon Valley"]] = {
		low = 67,
		high = 70,
		continent = Outland,
		instances = BZ["Black Temple"],
		paths = {
			[BZ["Terokkar Forest"]] = true,
			[BZ["Black Temple"]] = true,
		},
		fishing_min = 280,
	}

	zones[BZ["Black Temple"]] = {
		low = 70,
		high = 72,
		continent = Outland,
		paths = BZ["Shadowmoon Valley"],
		groupSize = 25,
		type = "Instance",
		entrancePortal = { BZ["Shadowmoon Valley"], 77.7, 43.7 },
	}

	zones[BZ["Auchenai Crypts"]] = {
		low = 65,
		high = 67,
		continent = Outland,
		paths = BZ["Ring of Observance"],
		groupSize = 5,
		type = "Instance",
		complex = BZ["Auchindoun"],
		entrancePortal = { BZ["Terokkar Forest"], 39.6, 65.5 },
	}

	zones[BZ["Shadow Labyrinth"]] = {
		low = 70,
		high = 72,
		continent = Outland,
		paths = BZ["Ring of Observance"],
		groupSize = 5,
		type = "Instance",
		complex = BZ["Auchindoun"],
		entrancePortal = { BZ["Terokkar Forest"], 39.6, 65.5 },
	}

	zones[BZ["Sethekk Halls"]] = {
		low = 67,
		high = 69,
		continent = Outland,
		paths = BZ["Ring of Observance"],
		groupSize = 5,
		type = "Instance",
		complex = BZ["Auchindoun"],
		entrancePortal = { BZ["Terokkar Forest"], 39.6, 65.5 },
	}

	zones[BZ["Mana-Tombs"]] = {
		low = 64,
		high = 66,
		continent = Outland,
		paths = BZ["Ring of Observance"],
		groupSize = 5,
		type = "Instance",
		complex = BZ["Auchindoun"],
		entrancePortal = { BZ["Terokkar Forest"], 39.6, 65.5 },
	}

	zones[BZ["Hellfire Ramparts"]] = {
		low = 60,
		high = 62,
		continent = Outland,
		paths = BZ["Hellfire Citadel"],
		groupSize = 5,
		type = "Instance",
		complex = BZ["Hellfire Citadel"],
		entrancePortal = { BZ["Hellfire Peninsula"], 46.8, 54.9 },
	}

	zones[BZ["The Blood Furnace"]] = {
		low = 61,
		high = 63,
		continent = Outland,
		paths = BZ["Hellfire Citadel"],
		groupSize = 5,
		type = "Instance",
		complex = BZ["Hellfire Citadel"],
		entrancePortal = { BZ["Hellfire Peninsula"], 46.8, 54.9 },
	}

	zones[BZ["The Shattered Halls"]] = {
		low = 70,
		high = 72,
		continent = Outland,
		paths = BZ["Hellfire Citadel"],
		groupSize = 5,
		type = "Instance",
		complex = BZ["Hellfire Citadel"],
		entrancePortal = { BZ["Hellfire Peninsula"], 46.8, 54.9 },
	}

	zones[BZ["Magtheridon's Lair"]] = {
		low = 70,
		high = 72,
		continent = Outland,
		paths = BZ["Hellfire Citadel"],
		groupSize = 25,
		type = "Instance",
		complex = BZ["Hellfire Citadel"],
		entrancePortal = { BZ["Hellfire Peninsula"], 46.8, 54.9 },
	}

	zones[BZ["The Slave Pens"]] = {
		low = 62,
		high = 64,
		continent = Outland,
		paths = BZ["Coilfang Reservoir"],
		groupSize = 5,
		type = "Instance",
		complex = BZ["Coilfang Reservoir"],
		entrancePortal = { BZ["Zangarmarsh"], 50.2, 40.8 },
	}

	zones[BZ["The Underbog"]] = {
		low = 63,
		high = 65,
		continent = Outland,
		paths = BZ["Coilfang Reservoir"],
		groupSize = 5,
		type = "Instance",
		complex = BZ["Coilfang Reservoir"],
		entrancePortal = { BZ["Zangarmarsh"], 50.2, 40.8 },
	}

	zones[BZ["The Steamvault"]] = {
		low = 70,
		high = 72,
		continent = Outland,
		paths = BZ["Coilfang Reservoir"],
		groupSize = 5,
		type = "Instance",
		complex = BZ["Coilfang Reservoir"],
		entrancePortal = { BZ["Zangarmarsh"], 50.2, 40.8 },
	}

	zones[BZ["Serpentshrine Cavern"]] = {
		low = 70,
		high = 72,
		continent = Outland,
		paths = BZ["Coilfang Reservoir"],
		groupSize = 25,
		type = "Instance",
		complex = BZ["Coilfang Reservoir"],
		entrancePortal = { BZ["Zangarmarsh"], 50.2, 40.8 },
	}

	zones[BZ["Gruul's Lair"]] = {
		low = 70,
		high = 72,
		continent = Outland,
		paths = BZ["Blade's Edge Mountains"],
		groupSize = 25,
		type = "Instance",
		entrancePortal = { BZ["Blade's Edge Mountains"], 68, 24 },
	}

	zones[BZ["The Mechanar"]] = {
		low = 69,
		high = 72,
		continent = Outland,
		paths = BZ["Tempest Keep"],
		groupSize = 5,
		type = "Instance",
		complex = BZ["Tempest Keep"],
		entrancePortal = { BZ["Netherstorm"], 76.5, 65.1 },
	}

	zones[BZ["The Botanica"]] = {
		low = 70,
		high = 72,
		continent = Outland,
		paths = BZ["Tempest Keep"],
		groupSize = 5,
		type = "Instance",
		complex = BZ["Tempest Keep"],
		entrancePortal = { BZ["Netherstorm"], 76.5, 65.1 },
	}

	zones[BZ["The Arcatraz"]] = {
		low = 70,
		high = 72,
		continent = Outland,
		paths = BZ["Tempest Keep"],
		groupSize = 5,
		type = "Instance",
		complex = BZ["Tempest Keep"],
		entrancePortal = { BZ["Netherstorm"], 76.5, 65.1 },
	}

	zones[BZ["The Eye"]] = {
		low = 70,
		high = 72,
		continent = Outland,
		paths = BZ["Tempest Keep"],
		groupSize = 25,
		type = "Instance",
		complex = BZ["Tempest Keep"],
		entrancePortal = { BZ["Netherstorm"], 76.5, 65.1 },
	}

	zones[BZ["Eye of the Storm"]] = {
		low = 61,
		high = 70,
		continent = Outland,
		groupSize = 25,
		type = "Battleground",
		texture = "NetherstormArena",
	}

	-- arenas
	zones[BZ["Blade's Edge Arena"]] = {
		low = 70,
		high = 70,
		continent = Outland,
		type = "Arena",
	}

	zones[BZ["Nagrand Arena"]] = {
		low = 70,
		high = 70,
		continent = Outland,
		type = "Arena",
	}

	zones[BZ["Ruins of Lordaeron"]] = {
		low = 70,
		high = 70,
		continent = Kalimdor,
		type = "Arena",
	}

	-- 2.4 zones
	zones[BZ["Isle of Quel'Danas"]] = {
		continent = Eastern_Kingdoms,
		low = 70,
		high = 70,
		paths = {
			[BZ["Magisters' Terrace"]] = true,
			[BZ["Sunwell Plateau"]] = true,
		},
		instances = {
			[BZ["Magisters' Terrace"]] = true,
			[BZ["Sunwell Plateau"]] = true,
		},
		fishing_min = 355,
	}

	zones[BZ["Magisters' Terrace"]] = {
		low = 70,
		high = 72,
		continent = Eastern_Kingdoms,
		paths = BZ["Isle of Quel'Danas"],
		groupSize = 5,
		type = "Instance",
		entrancePortal = { BZ["Isle of Quel'Danas"], 61.3, 30.9 },
	}

	zones[BZ["Sunwell Plateau"]] = {
		low = 70,
		high = 72,
		continent = Eastern_Kingdoms,
		paths = BZ["Isle of Quel'Danas"],
		groupSize = 25,
		type = "Instance",
		entrancePortal = { BZ["Isle of Quel'Danas"], 44.3, 45.7 },
	}

	-- WOTLK Zones

	zones[BZ["Dalaran"]] = {
		continent = Northrend,
		paths = {
			[BZ["Crystalsong Forest"]] = true,
			[BZ["The Violet Hold"]] = true,
			[DALARAN_IRONFORGE_PORTAL] = true,
			[DALARAN_STORMWIND_PORTAL] = true,
			[DALARAN_DARNASSUS_PORTAL] = true,
			[DALARAN_ORGRIMMAR_PORTAL] = true,
			[DALARAN_THUNDERBLUFF_PORTAL] = true,
			[DALARAN_UNDERCITY_PORTAL] = true,
			[DALARAN_EXODAR_PORTAL] = true,
			[DALARAN_SILVERMOON_PORTAL] = true,
			[DALARAN_SHATTRATH_PORTAL] = true,
			[DALARAN_COT_PORTAL] = true,
		},
		instances = BZ["The Violet Hold"],
		type = "City",
		texture = "Dalaran",
		fishing_min = 430,
	}

	zones[BZ["Plaguelands: The Scarlet Enclave"]] = {
		low = 55,
		high = 58,
		continent = Eastern_Kingdoms,
		yards = 3162.5,
		x_offset = 0,
		y_offset = 0,
		texture = "ScarletEnclave",
	}

	zones[BZ["Borean Tundra"]] = {
		low = 68,
		high = 72,
		continent = Northrend,
		paths = {
			[BZ["Coldarra"]] = true,
			[BZ["Dragonblight"]] = true,
			[BZ["Sholazar Basin"]] = true,
			[STORMWIND_BOREANTUNDRA_BOAT] = true,
			[ORGRIMMAR_BOREANTUNDRA_ZEPPELIN] = true,
			[MOAKI_UNUPE_BOAT] = true,
		},
		instances = {
			[BZ["The Nexus"]] = true,
			[BZ["The Oculus"]] = true,
			[BZ["The Eye of Eternity"]] = true,
		},
		fishing_min = 380,
	}

	zones[BZ["Coldarra"]] = {
		continent = Northrend,
		paths = {
			[BZ["Borean Tundra"]] = true,
			[BZ["The Nexus"]] = true,
			[BZ["The Oculus"]] = true,
			[BZ["The Eye of Eternity"]] = true,
		},
		instances = {
			[BZ["The Nexus"]] = true,
			[BZ["The Oculus"]] = true,
			[BZ["The Eye of Eternity"]] = true,
		},
	}

	zones[BZ["Howling Fjord"]] = {
		low = 68,
		high = 72,
		continent = Northrend,
		paths = {
			[BZ["Grizzly Hills"]] = true,
			[MENETHIL_HOWLINGFJORD_BOAT] = true,
			[UNDERCITY_HOWLINGFJORD_ZEPPELIN] = true,
			[MOAKI_KAMAGUA_BOAT] = true,
			[BZ["Utgarde Keep"]] = true,
			[BZ["Utgarde Pinnacle"]] = true,
		},
		instances = {
			[BZ["Utgarde Keep"]] = true,
			[BZ["Utgarde Pinnacle"]] = true,
		},
		fishing_min = 380,
	}

	zones[BZ["Dragonblight"]] = {
		low = 71,
		high = 74,
		continent = Northrend,
		paths = {
			[BZ["Borean Tundra"]] = true,
			[BZ["Grizzly Hills"]] = true,
			[BZ["Zul'Drak"]] = true,
			[BZ["Crystalsong Forest"]] = true,
			[MOAKI_UNUPE_BOAT] = true,
			[MOAKI_KAMAGUA_BOAT] = true,
			[BZ["Azjol-Nerub"]] = true,
			[BZ["Ahn'kahet: The Old Kingdom"]] = true,
			[BZ["Naxxramas"]] = true,
			[BZ["The Obsidian Sanctum"]] = true,
		},
		instances = {
			[BZ["Azjol-Nerub"]] = true,
			[BZ["Ahn'kahet: The Old Kingdom"]] = true,
			[BZ["Naxxramas"]] = true,
			[BZ["The Obsidian Sanctum"]] = true,
		},
		fishing_min = 430,
	}

	zones[BZ["Grizzly Hills"]] = {
		low = 73,
		high = 75,
		continent = Northrend,
		paths = {
			[BZ["Howling Fjord"]] = true,
			[BZ["Dragonblight"]] = true,
			[BZ["Zul'Drak"]] = true,
			[BZ["Drak'Tharon Keep"]] = true,
		},
		instances = BZ["Drak'Tharon Keep"],
		fishing_min = 380,
	}

	zones[BZ["Zul'Drak"]] = {
		low = 74,
		high = 77,
		continent = Northrend,
		paths = {
			[BZ["Dragonblight"]] = true,
			[BZ["Grizzly Hills"]] = true,
			[BZ["Crystalsong Forest"]] = true,
			[BZ["Gundrak"]] = true,
			[BZ["Drak'Tharon Keep"]] = true,
		},
		instances = {
			[BZ["Gundrak"]] = true,
			[BZ["Drak'Tharon Keep"]] = true,
		},
		fishing_min = 380,
	}

	zones[BZ["Sholazar Basin"]] = {
		low = 76,
		high = 78,
		continent = Northrend,
		paths = BZ["Borean Tundra"],
		fishing_min = 430,
	}

	zones[BZ["Crystalsong Forest"]] = {
		low = 77,
		high = 80,
		continent = Northrend,
		paths = {
			--[BZ["Dalaran"]] = true,
			[BZ["Dragonblight"]] = true,
			[BZ["Zul'Drak"]] = true,
			[BZ["The Storm Peaks"]] = true,
		},
		fishing_min = 405,
	}

	zones[BZ["The Storm Peaks"]] = {
		low = 77,
		high = 80,
		continent = Northrend,
		paths = {
			[BZ["Crystalsong Forest"]] = true,
			[BZ["Halls of Stone"]] = true,
			[BZ["Halls of Lightning"]] = true,
			[BZ["Ulduar"]] = true,
		},
		instances = {
			[BZ["Halls of Stone"]] = true,
			[BZ["Halls of Lightning"]] = true,
			[BZ["Ulduar"]] = true,
		},
		fishing_min = 455,
	}

	zones[BZ["Icecrown"]] = {
		low = 77,
		high = 80,
		continent = Northrend,
		paths = {
			[BZ["Trial of the Champion"]] = true,
			[BZ["Trial of the Crusader"]] = true,
			[BZ["The Forge of Souls"]] = true,
			[BZ["Pit of Saron"]] = true,
			[BZ["Halls of Reflection"]] = true,
			[BZ["Icecrown Citadel"]] = true,
		},
		instances = {
			[BZ["Trial of the Champion"]] = true,
			[BZ["Trial of the Crusader"]] = true,
			[BZ["The Forge of Souls"]] = true,
			[BZ["Pit of Saron"]] = true,
			[BZ["Halls of Reflection"]] = true,
			[BZ["Icecrown Citadel"]] = true,
		},
		fishing_min = 455,
	}

	zones[BZ["Hrothgar's Landing"]] = { -- TODO
		continent = Northrend,
	}

	zones[BZ["Wintergrasp"]] = {
		low = 77,
		high = 80,
		continent = Northrend,
		paths = BZ["Vault of Archavon"],
		instances = BZ["Vault of Archavon"],
		type = "PvP Zone",
		fishing_min = 430,
	}

	-- WOTLK Dungeons
	zones[BZ["Utgarde Keep"]] = {
		low = 70,
		high = 72,
		continent = Northrend,
		paths = BZ["Howling Fjord"],
		groupSize = 5,
		type = "Instance",
		entrancePortal = { BZ["Howling Fjord"], 57.30, 46.84 },
	}

	zones[BZ["Utgarde Pinnacle"]] = {
		low = 80,
		high = 80,
		continent = Northrend,
		paths = BZ["Howling Fjord"],
		groupSize = 5,
		type = "Instance",
		entrancePortal = { BZ["Howling Fjord"], 57.25, 46.60 },
	}

	zones[BZ["The Nexus"]] = {
		low = 71,
		high = 73,
		continent = Northrend,
		paths = BZ["Coldarra"],
		groupSize = 5,
		type = "Instance",
		entrancePortal = { BZ["Borean Tundra"], 27.50, 26.03 },
	}

	zones[BZ["The Oculus"]] = {
		low = 80,
		high = 80,
		continent = Northrend,
		paths = BZ["Coldarra"],
		groupSize = 5,
		type = "Instance",
		entrancePortal = { BZ["Borean Tundra"], 27.52, 26.67 },
	}

	zones[BZ["The Eye of Eternity"]] = {
		low = 80,
		high = 80,
		continent = Northrend,
		paths = BZ["Coldarra"],
		groupSize = 10,
		altGroupSize = 25,
		type = "Instance",
		entrancePortal = { BZ["Borean Tundra"], 27.54, 26.68 },
	}

	zones[BZ["Azjol-Nerub"]] = {
		low = 72,
		high = 74,
		continent = Northrend,
		paths = BZ["Dragonblight"],
		groupSize = 5,
		type = "Instance",
		entrancePortal = { BZ["Dragonblight"], 26.01, 50.83 },
	}

	zones[BZ["Ahn'kahet: The Old Kingdom"]] = {
		low = 73,
		high = 75,
		continent = Northrend,
		paths = BZ["Dragonblight"],
		groupSize = 5,
		type = "Instance",
		entrancePortal = { BZ["Dragonblight"], 28.49, 51.73 },
	}

	zones[BZ["Naxxramas"]] = {
		low = 80,
		high = 80,
		continent = Northrend,
		paths = BZ["Dragonblight"],
		groupSize = 10,
		altGroupSize = 25,
		type = "Instance",
		entrancePortal = { BZ["Dragonblight"], 87.30, 51.00 },
	}

	zones[BZ["The Obsidian Sanctum"]] = {
		low = 80,
		high = 80,
		continent = Northrend,
		paths = BZ["Dragonblight"],
		groupSize = 10,
		altGroupSize = 25,
		type = "Instance",
		entrancePortal = { BZ["Dragonblight"], 60.00, 57.00 },
	}

	zones[BZ["Drak'Tharon Keep"]] = {
		low = 74,
		high = 76,
		continent = Northrend,
		paths = {
			[BZ["Grizzly Hills"]] = true,
			[BZ["Zul'Drak"]] = true,
		},
		groupSize = 5,
		type = "Instance",
		entrancePortal = { BZ["Zul'Drak"], 28.53, 86.93 },
	}

	zones[BZ["Gundrak"]] = {
		low = 76,
		high = 78,
		continent = Northrend,
		paths = BZ["Zul'Drak"],
		groupSize = 5,
		type = "Instance",
		entrancePortal = { BZ["Zul'Drak"], 76.14, 21.00 },
	}

	zones[BZ["Halls of Stone"]] = {
		low = 77,
		high = 79,
		continent = Northrend,
		paths = BZ["The Storm Peaks"],
		groupSize = 5,
		type = "Instance",
		entrancePortal = { BZ["The Storm Peaks"], 39.52, 26.91 },
	}

	zones[BZ["Halls of Lightning"]] = {
		low = 80,
		high = 80,
		continent = Northrend,
		paths = BZ["The Storm Peaks"],
		groupSize = 5,
		type = "Instance",
		entrancePortal = { BZ["The Storm Peaks"], 45.38, 21.37 },
	}

	zones[BZ["Ulduar"]] = {
		low = 80,
		high = 80,
		continent = Northrend,
		paths = BZ["The Storm Peaks"],
		groupSize = 10,
		altGroupSize = 25,
		type = "Instance",
		entrancePortal = { BZ["The Storm Peaks"], 41.56, 17.76 },
		fishing_min = 550,
	}

	zones[BZ["The Violet Hold"]] = {
		low = 75,
		high = 77,
		continent = Northrend,
		paths = BZ["Dalaran"],
		groupSize = 5,
		type = "Instance",
		entrancePortal = { BZ["Dalaran"], 66.78, 68.19 },
	}

	zones[BZ["Trial of the Champion"]] = {
		low = 80,
		high = 80,
		continent = Northrend,
		paths = BZ["Icecrown"],
		groupSize = 5,
		type = "Instance",
		entrancePortal = { BZ["Icecrown"], 74.18, 20.45 },
	}

	zones[BZ["Trial of the Crusader"]] = {
		low = 80,
		high = 80,
		continent = Northrend,
		paths = BZ["Icecrown"],
		groupSize = 10,
		altGroupSize = 25,
		type = "Instance",
		entrancePortal = { BZ["Icecrown"], 75.07, 21.80 },
	}

	zones[BZ["The Forge of Souls"]] = {
		low = 80,
		high = 80,
		continent = Northrend,
		paths = BZ["Icecrown"],
		groupSize = 5,
		type = "Instance",
		entrancePortal = { BZ["Icecrown"], 52.60, 89.35 },
	}

	zones[BZ["Pit of Saron"]] = {
		low = 80,
		high = 80,
		continent = Northrend,
		paths = BZ["Icecrown"],
		groupSize = 5,
		type = "Instance",
		entrancePortal = { BZ["Icecrown"], 52.60, 89.35 },
	}

	zones[BZ["Halls of Reflection"]] = {
		low = 80,
		high = 80,
		continent = Northrend,
		paths = BZ["Icecrown"],
		groupSize = 5,
		type = "Instance",
		entrancePortal = { BZ["Icecrown"], 52.60, 89.35 },
	}

	zones[BZ["Icecrown Citadel"]] = {
		low = 80,
		high = 80,
		continent = Northrend,
		paths = BZ["Icecrown"],
		groupSize = 10,
		altGroupSize = 25,
		type = "Instance",
		entrancePortal = { BZ["Icecrown"], 53.86, 87.27 },
	}

	zones[BZ["Vault of Archavon"]] = {
		low = 80,
		high = 80,
		continent = Northrend,
		paths = BZ["Wintergrasp"],
		groupSize = 10,
		altGroupSize = 25,
		type = "Instance",
		--entrancePortal = { BZ["Wintergrasp"], 58, 45 }, -- TODO
	}

	zones[BZ["The Ruby Sanctum"]] = {
		low = 80,
		high = 80,
		continent = Northrend,
		paths = BZ["Dragonblight"],
		groupSize = 10,
		altGroupSize = 25,
		type = "Instance",
		entrancePortal = { BZ["Dragonblight"], 61.00, 53.00 },
	}


	zones[BZ["The Frozen Sea"]] = {
		continent = Northrend,
		fishing_min = 480,
	}

	zones[BZ["Strand of the Ancients"]] = {
		low = 71,
		high = 80,
		continent = Northrend,
		groupSize = 25,
		type = "Battleground",
		texture = "StrandoftheAncients",
	}

	zones[BZ["Dalaran Arena"]] = {
		low = 80,
		high = 80,
		continent = Northrend,
		type = "Arena",
	}

	local continentNames = { GetMapContinents() }
	local doneZones = {}
	for continentID, continentName in ipairs(continentNames) do
		SetMapZoom(continentID)
		if zones[continentName] then
			zones[continentName].texture = GetMapInfo()
		end
		local zoneNames = { GetMapZones(continentID) }
		local continentYards = zones[continentName].yards
		for _ = 1, #zoneNames do
			local x, y
			local name, fileName, texPctX, texPctY, texX, texY, scrollX, scrollY
			local finish = GetTime() + 0.1
			repeat
				if finish < GetTime() then
					name = nil
					break
				end
				x, y = math.random(), math.random()
				name, fileName, texPctX, texPctY, texX, texY, scrollX, scrollY = UpdateMapHighlight(x, y)
			until name and not doneZones[name]
			if name == nil then
				break
			end
			doneZones[name] = true

			if fileName == "EversongWoods" or fileName == "Ghostlands" or fileName == "Sunwell" or fileName == "SilvermoonCity" then
				scrollX = scrollX - 0.00168
				scrollY = scrollY + 0.01
			end

			if zones[name] then
				zones[name].yards = texX * continentYards
				zones[name].x_offset = scrollX * continentYards
				zones[name].y_offset = scrollY * continentYards * 2/3
				zones[name].texture = fileName
			end
		end
	end
	SetMapToCurrentZone()

	for k,v in pairs(zones) do
		lows[k] = v.low or 0
		highs[k] = v.high or 0
		continents[k] = v.continent or UNKNOWN
		instances[k] = v.instances
		paths[k] = v.paths or false
		types[k] = v.type or "Zone"
		groupSizes[k] = v.groupSize
		groupAltSizes[k] = v.altGroupSize
		factions[k] = v.faction
		yardWidths[k] = v.yards
		yardHeights[k] = v.yards and v.yards * 2/3 or nil
		yardXOffsets[k] = v.x_offset
		yardYOffsets[k] = v.y_offset
		fishing[k] = v.fishing_min
		textures[k] = v.texture
		complexes[k] = v.complex
		if v.texture then
			textures_rev[v.texture] = k
		end
		if v.entrancePortal then
			entrancePortals_zone[k] = v.entrancePortal[1]
			entrancePortals_x[k] = v.entrancePortal[2]
			entrancePortals_y[k] = v.entrancePortal[3]
		end
	end
	zones = nil

	PLAYER_LEVEL_UP(Tourist)
end
