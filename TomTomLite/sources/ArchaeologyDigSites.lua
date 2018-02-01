local addonName, addon = ...
local L = addon.L

--[[-------------------------------------------------------------------
--  Archaeology Dig Sitemodule for TomTomLite, example reference module
-------------------------------------------------------------------]]--

do
    local desc = L["This source provides waypoints for archaeology dig sites"]
    addon:RegisterSource("archaeodig", L["Archaeology Dig Sites"], desc)
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
eventFrame:RegisterEvent("ARTIFACT_HISTORY_READY")
eventFrame:RegisterEvent("ARTIFACT_COMPLETE")
eventFrame:RegisterEvent("ARTIFACT_DIG_SITE_UPDATED")

-- Creates waypoints for each of the dig sites that can be found
-- on the current continent
local waypoints = {}
local function UpdateDigSites()
    if not addon.db.profile.archaeologyDigSitesSource then
        return
    end

    local omap, ofloor = GetCurrentMapAreaID()

    -- Flip the map to our current zone, then zoom out to the continent
    SetMapToCurrentZone()
    local map, floor = GetCurrentMapAreaID()

    local continent = addon:GetMapContinentMap(map)
    if continent then
        SetMapByID(continent)
    end

    local sites = {}
    for idx = 1, GetNumMapLandmarks() do
        local name, desc, textureIdx, px, py = GetMapLandmarkInfo(idx)
        local zoneName, mapFile, texPctX, texPctY, texX, texY, scrollX, scrollY = UpdateMapHighlight(px, py)

        if textureIdx == 177 then
            local key = string.format("%s:%f:%f:", name, px, py)
            if not waypoints[key] then
                local waypoint = addon:AddWaypoint(continent, nil, px, py, {
                    title = string.format(L["Dig site: %s\n%s"], name, zoneName),
                    priority = 0,
                })
                sites[key] = waypoint
            else
                sites[key] = waypoints[key]
            end
        end
    end

    for key, waypoint in pairs(sites) do
        waypoints[key] = nil
    end

    for key, waypoint in pairs(waypoints) do
        addon:RemoveWaypoint(waypoint)
    end

    waypoints = sites
end

eventFrame:SetScript("OnEvent", function(self, event, ...)
    UpdateDigSites()
end)

local throttle = 2.0
local counter = 0
eventFrame:SetScript("OnUpdate", function(self, elapsed)
    counter = counter + elapsed
    if counter < throttle then
        return
    else
        counter = counter - throttle
    end

    local min = math.huge
    local closest

    for key, waypoint in pairs(waypoints) do
        local distance, angle = addon:GetVectorFromCurrent(unpack(waypoint))
        if distance and distance < min then
            min = distance
            closest = waypoint
        end
    end

    if self.closest == closest then
        -- Nothing changed, return
        return
    end

    for key, waypoint in pairs(waypoints) do
        if waypoint ~= closest then
            waypoint.priority = addon.PRI_NORMAL
        else
            -- Make archaeology waypoints less than 'active' waypoints
            waypoint.priority = addon.PRI_ACTIVE * 0.75
        end
    end

    self.closest = closest

    addon:FireMessage("TOMTOMLITE_WAYPOINTS_CHANGED")
end)
