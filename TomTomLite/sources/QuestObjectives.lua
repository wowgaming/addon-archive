local addonName, addon = ...
local L = addon.L

--[[-------------------------------------------------------------------
--  Quest objective waypoint source for TomTomLite
--
--  Anytime the quest log or objective POI information changes, the
--  objective tracker is scanned for all objectives and waypoints are
--  created for each of them. The priority of the first waypoint, i.e.
--  the first one in the objectives tracker, is set higher than the
--  rest. This of course can be overridden by the user
-------------------------------------------------------------------]]--

do
    local desc = L["This source provides waypoints for each of the objectives listed in the Blizzard objectives tracker. To add a quest to the tracking list, just shift-click it in your quest log."],
    addon:RegisterSource("questobj", L["Quest Objectives (tracked)"], desc)
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("QUEST_POI_UPDATE")
eventFrame:RegisterEvent("QUEST_LOG_UPDATE")
hooksecurefunc("WatchFrame_Update", function(self)
    addon:OBJECTIVES_CHANGED()
end)

eventFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "QUEST_POI_UPDATE" then
        addon:OBJECTIVES_CHANGED()
    elseif event == "QUEST_LOG_UPDATE" then
        addon:OBJECTIVES_CHANGED()
    end
end)

-- This function scans the current set of objectives, adding and removing
-- waypoints to reflect the current state of the tracker.

local waypoints = {}
function addon:OBJECTIVES_CHANGED()
    local map, floor = GetCurrentMapAreaID()
    floor = floor or 0

    -- Do not set any NEW waypoints if we're on the continent map
    if self:IsContinentMap(map) then
        return
    end

    local cvar = GetCVarBool("questPOI")
    SetCVar("questPOI", 1)

    -- Only do an objective scan if the option is enabled
    if not self.db.profile.questObjectivesSource then
        return
    end

    local newWaypoints = {}
    local changed = false

    -- This function relies on the above CVar being set, and updates the icon
    -- position information so it can be queries via the API
    QuestPOIUpdateIcons()

    -- Scan through every quest that is being tracked, and create a waypoint
    -- for each of the objectives that are being tracked. These waypoints will
    -- be unordered, and will be sorted or ordered by the user/algorithm
    local first
    local watchIndex = 1
    while true do
        local questIndex = GetQuestIndexForWatch(watchIndex)
        if not questIndex then
            break
        end

        local title = GetQuestLogTitle(questIndex)
        local qid = select(9, GetQuestLogTitle(questIndex))
        local completed, x, y, objective = QuestPOIGetIconInfo(qid)

        if x and y then
            -- Try to uniquely identify objective waypoints using qid, x, y along
            -- with map and floor. This may not always work, but its the best we
            -- can do right now. This allows us to ensure we don't double-set a
            -- waypoint.

            if completed then
                title = "Turn in: " .. title
            end

            local key = title .. tostring(qid + (x * 100) * (y * 100) * map * (floor + 1))
            if not first then
                first = key
            end

            if waypoints[key] then
                -- This waypoint already exists, no need to do anything, except
                -- possibly change the priority

                local waypoint = waypoints[key]
                local newpri = key == first and addon.PRI_ACTIVE or addon.PRI_NORMAL
                if waypoint.priority ~= newpri then
                    changed = true
                    waypoint.priority = newpri
                end

                newWaypoints[key] = waypoint
            else
                -- Create the waypoint, setting priority
                local waypoint = self:AddWaypoint(map, floor, x, y, {
                    title = title,
                    priority = key == first and addon.PRI_ACTIVE or addon.PRI_NORMAL,
                })

                newWaypoints[key] = waypoint
            end
        end

        watchIndex = watchIndex + 1
    end

    SetCVar("questPOI", cvar and 1 or 0)

    -- Check to see if there are any waypoints that are in 'waypoints' but
    -- not in 'newWaypoints' so we can remove them. Additionally, we may have
    -- changed a waypoint's priority during the scan, so trigger an update in
    -- that case.

    for k, waypoint in pairs(newWaypoints) do
        waypoints[k] = nil
    end

    for k, waypoint in pairs(waypoints) do
        -- This waypoint is no longer being tracked
        addon:RemoveWaypoint(waypoint)
    end

    -- Swap the arrays
    waypoints = newWaypoints

    if changed then
        addon:FireMessage("TOMTOMLITE_WAYPOINTS_CHANGED")
    end
end
