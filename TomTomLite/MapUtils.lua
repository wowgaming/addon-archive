local addonName, addon = ...
local L = addon.L

--local astrolabe = DongleStub("Astrolabe-1.0")
local mapdata = LibStub("LibMapData-1.0")

local PI2 = math.pi * 2

-- This file is an API abstraction over the mapping system in World of
-- Warcraft, however it does not aim to be a complete abstraction. Instead, we
-- merely provide those functions that are relevant to TomTom, and try to
-- provide a way for the necessary data to be obtained without care for how it
-- is obtained.

local function getDirection(xd, yd)
    if not xd or not yd then
        return nil
    end

    local angle = math.atan2(xd, -yd)
    if angle > 0 then
        angle = PI2 - angle
    else
        angle = -angle
    end

    return angle
end

-- Calculates the distance (in yards) and angle (in radians) between two points
-- on the map. This may be two points within the same map file, or two points
-- on different maps. In the case that the points are on different maps and
-- there's no 'distance' that quite makes sense, this function will simply
-- return nil

function addon:GetVector(sm, sf, sx, sy, dm, df, dx, dy)
    if sm == dm and sf == df then
        -- The waypoints are on the same map, so calculate directly using map data

        if mapdata then
            local dist, xd, yd = mapdata:Distance(sm, sf, sx, sy, dx, dy)
            local angle = getDirection(xd, yd)
            if dist and angle then
                return dist, angle
            end
        elseif astrolabe then
            local dist, xd, yd = astrolabe:ComputeDistance(sm, sf, sx, sy, dm, df, dx, dy)
            local angle = getDirection(xd, yd)
            if dist and angle then
                return dist, angle
            end
        else
            error("No map data available for 'GetVector'")
        end
    else
        -- The waypoints are on different maps

        if mapdata then
            local dist, xd, yd = mapdata:DistanceWithinContinent(sm, sf, sx, sy, dm, df, dx, dy)
            local angle = getDirection(xd, yd)
            if dist and angle then
                return dist, angle
            end
        elseif astrolabe then
            local dist, xd, yd = astrolabe:ComputeDistance(sm, sf, sx, sy, dm, df, dx, dy)
            local angle = GetDistance(xd, yd)
            if dist and angle then
                return dist, angle
            end
        else
            error("No map data available for 'GetVector'")
        end
    end
end

-- Returns the player's current map, floor and position. This information isn't
-- directly available if the world map is open and the player has navigated to
-- another map.

function addon:GetPlayerPosition()
    -- Attempt to get the player's position on the current map
    local x, y = GetPlayerMapPosition("player")
    if x and y and x > 0 and y > 0 then
        local map, floor = GetCurrentMapAreaID()
        floor = floor or self:GetDefaultFloor(map)
        return map, floor, x, y
    end

    -- At this point, we were unable to get the position information
    if WorldMapFrame:IsVisible() then
        -- The map is open and we cannot change the map being displayed
        return
    end

    -- Flip the map to the current zone and get the position. We do not change
    -- the map zoom back at the end of this function to avoid getting into any
    -- nasty race conditions, it's bad enough that we need to set it currently.
    SetMapToCurrentZone()
    local x, y = GetPlayerMapPosition("player")

    if x <= 0 and y <= 0 then
        -- Coordinate information not available for wherever the player is
        return
    end

    -- Fetch the map and floor and return the information that we have
    local map, floor = GetCurrentMapAreaID()
    floor = floor or self:GetDefaultFloor(map)
    return map, floor, x, y
end

-- Get the distance (in yards) and angle (in radians) from the player's current
-- position to a position on the map.

function addon:GetVectorFromCurrent(map, floor, x, y)
    local cmap, cfloor, cx, cy = self:GetPlayerPosition()

    if cmap and cx and cy and map and x and y then
        return self:GetVector(cmap, cfloor, cx, cy, map, floor, x, y)
    end
end

-- This function returns the display name for a given map. If the name is not
-- available, then "Unknown map: %d" is displayed
function addon:GetMapDisplayName(map)
    if mapdata then
        local name = mapdata:MapLocalize(map)
        return name or string.format("Unknown map: %d", map)
    elseif astrolabe then
        return string.format("Unknown map: %d", map)
    end
end

-- This data is hardcoded, and should be able to be automatically obtained
local continents = {
    -- Map for cosmic (both ways)
    [WORLDMAP_COSMIC_ID] = -1,   -- Cosmic map (-1)

    -- Map from mapId to continentIndex
    [13] = 1,                    -- Kalimdor (1)
    [14] = 2,                    -- Eastern Kingdoms (2)
    [466] = 3,                   -- Outland (3)
    [485] = 4,                   -- Northrend (4)
    [751] = 5,                   -- Maelstrom (5)

    -- Map from continentIndex to mapId
    [1] = 13,                    -- Kalimdor (13)
    [2] = 14,                    -- Eastern Kingdoms (14)
    [3] = 466,                   -- Outland (466)
    [4] = 485,                   -- Northrend (485)
    [5] = 751,                   -- Maelstrom (751)
}

-- Returns if a given map file is a continent map
function addon:IsContinentMap(map)
    return not not continents[map]
end

-- Returns the continent map that 'owns' a given map. This does NOT return the
-- continent index, but rather the continent map file.
function addon:GetMapContinentMap(map)
    if mapdata then
        local cindex = mapdata:GetContinentFromMap(map)
        local cmap = continents[cindex]
        return cmap
    elseif astrolabe then
    end
end

function addon:GetNumMapFloors(map)
    if mapdata then
        local floors = mapdata:MapFloors(map) == 0 and 0 or 1
        return floors
    elseif astrolabe then
        local floors = astrolabe:GetNumFloors(map) == 0 and 0 or 1
        return floors
    end
end

function addon:GetDefaultFloor(map)
    local floors = self:GetNumMapFloors(map)
    return floors == 0 and 0 or 1
end
