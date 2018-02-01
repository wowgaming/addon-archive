--[[-------------------------------------------------------------------
--  TomTomLite - Copyright 2010 - James N. Whitehead II
-------------------------------------------------------------------]]--

local addonName, addon = ...
local L = addon.L

addon.callbacks = LibStub("CallbackHandler-1.0"):New(addon)
addon.libwindow = LibStub("LibWindow-1.1")

-- Set up some tables to track waypoints
do
    local cache = {}
    addon.waypoints = setmetatable({}, {
        __newindex = function(t, k, v)
            if type(v) == "nil" then
                -- A waypoint is being removed
                local oldwaypoint = rawget(t, k)
                rawset(t, k, nil)
                local map = oldwaypoint[1]
                if map then
                    cache[map] = nil
                end
            else
                -- A waypoint is being added
                rawset(t, k, v)
                local map = v[1]
                if map then
                    cache[map] = nil
                end
            end
        end,
    })
    addon.waypointsByMap = setmetatable({}, {
        __index = function(t, k)
            local cached = cache[k]
            if cached then
                return cached
            end
            -- Look up all the waypoints for a given mapId
            local set = {}
            for idx, waypoint in ipairs(addon.waypoints) do
                if waypoint[1] == k then
                    table.insert(set, waypoint)
                end
            end
            rawset(cache, k, set)
            return set
        end
    })
    addon.sources = {}
end

function addon:Initialize()
    self.db = LibStub("AceDB-3.0"):New("TomTomLiteDB", self.defaults)

    self.arrow = self:CreateCrazyArrow("TomTomLiteArrow")
    self.arrow:SetPoint("CENTER", 0, 0)
    self.arrow:Hide()

    self:RegisterMessage("TOMTOMLITE_WAYPOINT_ADDED")
    self:RegisterMessage("TOMTOMLITE_WAYPOINT_DELETED")
    self:RegisterMessage("TOMTOMLITE_WAYPOINTS_CHANGED")

    -- Events for world map overlays
    self:RegisterEvent("WORLD_MAP_UPDATE")

    -- Set up some constants that can be used in other addons
    self.PRI_ACTIVE = 15
    self.PRI_NORMAL = 0
    self.PRI_ALWAYS = math.huge
end

function addon:CreateCrazyArrow(name, parent)
    parent = parent or UIParent
    local frame = CreateFrame("Button", name, parent)

    frame:SetSize(128, 128)
    frame.arrow = frame:CreateTexture(name .. "Icon", "BACKGROUND")
    frame.arrow:SetAllPoints()
    frame.arrow:SetTexture("Interface\\Addons\\TomTomLite\\images\\BevArrow")

    frame.glow = frame:CreateTexture(name .. "Glow", "OVERLAY")
    frame.glow:SetAllPoints()
    frame.glow:SetTexture("Interface\\Addons\\TomTomLite\\images\\BevArrowGlow")
    frame.glow:SetVertexColor(1.0, 0.8, 0.0)

    frame.title = frame:CreateFontString("OVERLAY", name .. "Title", "GameFontHighlight")
    frame.info = frame:CreateFontString("OVERLAY", name .. "Info", "GameFontHighlight")
    frame.subtitle = frame:CreateFontString("OVERLAY", name .. "Subtitle", "GameFontHighlight")

    frame.title:SetPoint("TOP", frame, "BOTTOM", 0, 0)
    frame.info:SetPoint("TOP", frame.title, "BOTTOM", 0, 0)
    frame.subtitle:SetPoint("TOP", frame.info, "BOTTOM", 0, 0)

    frame:Hide()

    local PI2 = math.pi * 2

    -- Set up the OnUpdate handler
    frame:SetScript("OnUpdate", function(self, elapsed)
        local map, floor, x, y = unpack(self.waypoint)
        local distance, angle = addon:GetVectorFromCurrent(map, floor, x, y)

        -- Bail out if we don't know what to do!
        if not distance or not angle then
            return
        end

        local facing = GetPlayerFacing()
        local faceangle = angle - facing

        local perc = math.abs((math.pi - math.abs(faceangle)) / math.pi)
        local gr,gg,gb = unpack(addon.db.profile.goodcolor)
        local mr,mg,mb = unpack(addon.db.profile.middlecolor)
        local br,bg,bb = unpack(addon.db.profile.badcolor)
        local r,g,b = addon:ColorGradient(perc, br, bg, bb, mr, mg, mb, gr, gg, gb)

        self.arrow:SetVertexColor(r,g,b)
        self.arrow:SetRotation(faceangle)

        -- This code is not quite correct, needs to be 'fixed'

        local lowlimit = 20.0
        local highlimit = 360.0 - lowlimit

        local angle = math.abs(deg(faceangle)) % 360

        if angle <= lowlimit then
            -- Determine what alpha to show
            local perc = angle / lowlimit

            self.glow:Show()
            self.glow:SetRotation(faceangle)
            self.glow:SetAlpha(1.0 - perc)
        elseif angle >= highlimit then
            -- Determine what alpha to show
            local perc = angle / (360 - lowlimit)

            self.glow:Show()
            self.glow:SetRotation(faceangle)
            self.glow:SetAlpha(1.0 - perc)
        else
            self.glow:Hide()
        end

        self.subtitle:SetFormattedText("%.1f yards", distance)
    end)

    self.libwindow.RegisterConfig(frame, self.db.profile.positions)
    self.libwindow.RestorePosition(frame)
    self.libwindow.MakeDraggable(frame)
    self.libwindow.EnableMouseOnAlt(frame)
    self.libwindow.EnableMouseWheelScaling(frame)

    return frame
end

--[[-------------------------------------------------------------------------
--  External API
-------------------------------------------------------------------------]]--

-- Register a new waypoint source for use with TomTomLite. The build-in sources
-- are 'objective' and 'corpse'. These can just be used in the user interface
-- to allow the user to filter/mask different sources and to set priority
-- modifiers.
--
-- Arguments:
--   stype  - A short 'type' string used to identify the source of a waypoint
--   name   - The localized name of the source, for use in the user interface
--   desc   - Localized long description of the source type
--   opt    - A table containing any other options, for future-use

function addon:RegisterSource(stype, name, desc, opt)
    local sources = {
        type = stype,
        name = name,
        desc = desc,
    }

    if opt then
        for k,v in pairs(opt) do
            if sources[k] then
                local err = string.format(L["Source '%s' registered with invalid option '%s'"], name, k)
                error(err)
            else
                sources[k] = v
            end
        end
    end

    table.insert(self.sources, source)
end

-- Add a new waypoint to TomTomLite. This may not cause the waypoint to be
-- immediately displayed, just simply adds it to the collection of waypoints
-- that TomTomLite knows about. In general, a waypoint will be added and then
-- between user options and waypoint priorities one or more may be chosen
-- to be displayed.
--
-- Arguments:
--   map    - The numeric map ID for the given waypoint. These map ids are
--            unique for a given map.
--   floor  - The floor for the given waypoint on the specified map. This
--            argument may be nil, indicating that the 'default' floor should
--            be used, and TomTomLite will attempt to choose a sane default.
--   x      - The x coordinate of the waypoint, specified as a number between 0
--            and 1. If the number specified is greater than 1, it will be
--            divided by 100 before being used by TomTomLite.
--   y      - The y coordinate of the waypoint, following the same format as 'x'
--   opt    - A table containing other options for the specified waypoint.
--            Currently the following options are supported:
--
--      priority - A number indicating the priority of the waypoint.
--                 The default priority is 0 and the greatest should be
--                 100, indicating something that should always be
--                 displayed, for example the Corpse arrow.
--
-- Returns:
--   waypoint   - A table containing the information about the given waypoint and
--                serving as a unique identifier for the waypoint within TomTomLite.

function addon:AddWaypoint(map, floor, x, y, opt)
    assert(type(map) == "number")
    assert(type(floor) == "number" or floor == nil)
    assert(type(x) == "number")
    assert(type(y) == "number")

    if floor == nil then
        floor = addon:GetDefaultFloor(map)
    end

    local waypoint = {map, floor, x, y}
    if type(opt) == "table" then
        for k, v in pairs(opt) do
            if type(k) ~= "number" then
                waypoint[k] = v
            end
        end
    end

    table.insert(self.waypoints, waypoint)
    self:FireMessage("TOMTOMLITE_WAYPOINT_ADDED", waypoint)

    return waypoint
end

-- Removes a waypoint entirely from TomTomLite.
--
-- Arguments:
--   waypoint   - The unique waypoint table that was returned by 'AddWaypoint'

function addon:RemoveWaypoint(waypoint)
    for idx, entry in ipairs(self.waypoints) do
        if entry == waypoint then
            table.remove(self.waypoints, idx)
            break
        end
    end

    self:FireMessage("TOMTOMLITE_WAYPOINT_DELETED", waypoint)
end

--[[-------------------------------------------------------------------------
--  Private implementation
-------------------------------------------------------------------------]]--
function addon:TOMTOMLITE_WAYPOINT_ADDED(msg, waypoint, ...)
    self:FireMessage("TOMTOMLITE_WAYPOINTS_CHANGED")
    --self:Printf("Waypoint '%s' added at %.2f, %.2f", waypoint.title, waypoint[3], waypoint[4])
end

function addon:TOMTOMLITE_WAYPOINT_DELETED(msg, waypoint, ...)
    self:FireMessage("TOMTOMLITE_WAYPOINTS_CHANGED")
    --self:Printf("Waypoint '%s' REMOVED at %.2f, %.2f", waypoint.title, waypoint[3], waypoint[4])
end

function addon:TOMTOMLITE_WAYPOINTS_CHANGED(msg, ...)
    self:UpdateArrow()
end

function addon:UpdateArrow()
    -- This naive sort function will sort all waypoints so the highest
    -- priority waypoint is first. This is the waypoint that will be
    -- displayed on the arrow.

    table.sort(self.waypoints, function(a, b)
        local apri = a.priority or 0
        local bpri = b.priority or 0
        return bpri < apri
    end)

    local highest = self.waypoints[1]
    if highest then
        local zone, floor, x, y = unpack(highest)
        local lzone = self:GetMapDisplayName(zone)

        self.arrow.waypoint = highest
        self.arrow.title:SetText(highest.title or L["Unknown waypoint"])
        self.arrow.info:SetFormattedText("%.2f, %.2f - %s", x * 100, y * 100, lzone)
        self.arrow:Show()
    else
        self.arrow.waypoint = nil
        self.arrow:Hide()
    end
end

--[[-------------------------------------------------------------------------
--  World map support, displaying waypoint overlays
-------------------------------------------------------------------------]]--

-- Create an overlay that we can use to parent our world map icons
addon.overlay = CreateFrame("Frame", addonName .. "MapOverlay", WorldMapButton)
addon.overlay:SetAllPoints()
addon.overlay:Show()

-- Metatable that stores world map icons indexed by number, in array form
local worldmapIcons = setmetatable({}, {
    __index = function(t, k)
        local name = addonName .. "MapIcon" .. tostring(k)
        local button = CreateFrame("Button", name, addon.overlay)
        button:SetSize(64, 64)
        button:SetHitRectInsets(12, 12, 5, 2)

        button.icon = button:CreateTexture("BACKGROUND")
        button.icon:SetTexture("Interface\\AddOns\\TomTomLite\\images\\MapPointer")
        button.icon:SetVertexColor(0.3, 1.0, 0.3)
        button.icon:SetAllPoints()
        button.glow = button:CreateTexture("BACKGROUND")
        button.glow:SetTexture("Interface\\AddOns\\TomTomLite\\images\\MapPointerGlow")
        button.glow:SetAllPoints()
        button.glow:Hide()
        button.number = button:CreateTexture("OVERLAY", name .. "Number")
        button.number:SetSize(50, 50)
        button.number:SetTexture("Interface\\WorldMap\\UI-QuestPoi-NumberIcons")
        button.number:SetPoint("CENTER", button, "CENTER", 0, 8)
        button.number:SetDrawLayer("OVERLAY", 7)

        rawset(t, k, button)
        return button
    end,
})

function addon:WORLD_MAP_UPDATE()
    -- Display any waypoints overlaid on the world map. Specifically, if
    -- the map zoom is set to a continent or cosmic map, then display all
    -- waypoints, otherwise display only the waypoints for the currently
    -- displayed zone. If there are waypoints on a floor other than the
    -- one the player is currently on, they will be displayed as well, and
    -- will be distinguishable from waypoints on the current floor.

    -- If the map isn't shown, do nothing
    if not addon.overlay:IsVisible() then
        return
    end

    -- Check the options to see what should be displayed
    if not self.db.profile.showMapIconsZone then
        return
    end

    local map, floor = GetCurrentMapAreaID()
    local waypoints = addon.waypointsByMap[map]

    for idx = 1, math.max(#waypoints, #worldmapIcons), 1 do
        local icon = worldmapIcons[idx]
        local waypoint = waypoints[idx]

        if waypoint then
            local width, height = addon.overlay:GetSize()

            icon:ClearAllPoints()

            local x = waypoint[3] * width
            local y = waypoint[4] * height

            -- Set the number to be displayed
            local buttonIndex = idx - 1
            local yOffset = 0.5 + math.floor(buttonIndex / QUEST_POI_ICONS_PER_ROW) * QUEST_POI_ICON_SIZE;
            local xOffset = mod(buttonIndex, QUEST_POI_ICONS_PER_ROW) * QUEST_POI_ICON_SIZE
            icon.number:SetTexCoord(xOffset, xOffset + QUEST_POI_ICON_SIZE, yOffset, yOffset + QUEST_POI_ICON_SIZE)

            -- Nudge position so arrow appears centered on POI
            icon:SetPoint("BOTTOM", addon.overlay, "TOPLEFT", x + 1, -y - 5)

            if (floor or 0) == waypoint[2] then
                icon:SetAlpha(1.0)
            else
                icon:SetAlpha(0.6)
            end

            icon:Show()
        else
            icon:Hide()
        end
    end
end

--[[-------------------------------------------------------------------------
--  Slash command registration
-------------------------------------------------------------------------]]--

SLASH_TOMTOMLITE1 = "/ttl"
SLASH_TOMTOMLITE2 = "/tomtomlite"
SLASH_TOMTOMLITE3 = "/tt"

local wrongseparator = "(%d)" .. (tonumber("1.1") and "," or ".") .. "(%d)"
local rightseparator =   "%1" .. (tonumber("1.1") and "." or ",") .. "%2"

SlashCmdList["TOMTOMLITE"] = function(msg, editbox)
    -- Attempt to fix any pairs of coordinates in any form so they work. This
    -- should correctly handle cases where the user uses a number format that
    -- is different than their current locale, i.e. someone using 34,45 when
    -- their numeric locale expects 34.45 (for the number 35 and 45 hundreths).
    -- Additionally, if the two numbers are separaed by a comma, i.e.
    -- 45.34, 54.13 then this comma will be removed.
    --
    -- Thanks to Phanx for working out the best way to do this
    local msgfix = msg:gsub("(%d)[%.,] (%d)", "%1 %2"):gsub(wrongseparator, rightseparator)

    local tokens = {}
    for token in msgfix:gmatch("%S+") do
        table.insert(tokens, token)
    end

    local verb = tokens[1] and tokens[1]:lower()

    if verb == "set" then
        if not tonumber(tokens[2]) then
            -- A zone has been specified as the first argument so find the boundary
            local zoneEnd = 2
            for idx, token in ipairs(tokens) do
                if tonumber(token) then
                    zoneEnd = idx - 1
                    break
                end
            end

            local zone = table.concat(tokens, " ", 2, zoneEnd)
            local x, y, desc = unpack(tokens, zoneEnd + 1)

            -- The description may be multiple tokens as well
            if desc then
                desc = table.concat(tokens, " ", zoneEnd + 3)
            end

            -- TODO: Try to find a match for the zone/map name
        else
            self:Printf(L["Usage for /ttl:"])
            self:Printf(L["  * set [zone] <x> <y> [desc] - sets a waypoint"])
        end
	end
end
