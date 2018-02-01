local addonName, addon = ...
local L = addon.L

--[[-------------------------------------------------------------------
--  Corpse arrow module for TomTomLite, example reference module
-------------------------------------------------------------------]]--

do
    local desc = L["This source provides a waypoint for your corpse, when you happen to die."]
    addon:RegisterSource("corpse", L["Corpse"], desc)
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_ALIVE")
eventFrame:RegisterEvent("PLAYER_DEAD")
eventFrame:RegisterEvent("PLAYER_UNGHOST")
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
eventFrame:Hide()

local waypoint
local map, floor, x, y

local function GetCorpseLocation()
    if not addon.db.profile.corpseSource then
        return
    end

    if map and x and y then
        return map, floor, x, y
    end

    local oldmap, oldfloor = GetCurrentMapAreaID()

    local cont
    -- Scan the all of the continent maps in order to find the corpse arrow
    for i=1, select("#", GetMapContinents()) do
        SetMapZoom(i)
        local cx, cy = GetCorpseMapPosition()
        if cx ~= 0 and cy ~= 0 then
            cont = i
            break
        end
    end

	-- If we found the corpse on a continent, find out which zone it is in
	if cont and cont ~= -1 then
		for i = 1, select("#", GetMapZones(cont)) do
			SetMapZoom(cont, i)
			local cx, cy = GetCorpseMapPosition()
			if cx > 0 and cy > 0 then
                map, floor = GetCurrentMapAreaID()
                x, y = cx, cy
                break
			end
		end
	end

	-- Restore the map to its previous map
    SetMapByID(oldmap, oldfloor)

    if map and x and y then
        return map, floor, x, y
    else
        -- Now handle the case where the corpse is on the current map
        local cx, cy = GetCorpseMapPosition()
        if cx ~= 0 and cy ~= 0 then
            map, floor = oldmap, oldfloor
            x, y = cx, cy
            return map, floor, x, y
        end
    end
end

local function SetCorpseArrow()
    if not waypoint and map and x and y and x > 0 and y > 0 then
        waypoint = addon:AddWaypoint(map, floor, x, y, {
            title = "Your corpse",
            priority = addon.PRI_ALWAYS,
        })
        return waypoint
	end
end

local function StartCorpseSearch()
	if not IsInInstance() then
		eventFrame:Show()
	end
end

local function ClearCorpseArrow()
	if waypoint then
		addon:RemoveWaypoint(waypoint)

        waypoint = nil
        map, floor, x, y = nil, nil, nil, nil
	end
end

local counter, throttle = 0, 0.5
eventFrame:SetScript("OnUpdate", function(self, elapsed)
	counter = counter + elapsed
	if counter < throttle then
		return
	else
		counter = 0
		if addon.db.profile.corpseSource then
			if GetCorpseLocation() then
				if SetCorpseArrow() then
					self:Hide()
				end
			end
		else
			self:Hide()
		end
	end
end)

eventFrame:SetScript("OnEvent", function(self, event, arg1, ...)
	if event == "ADDON_LOADED" and arg1 == addonName then
		self:UnregisterEvent("ADDON_LOADED")
		if UnitIsDeadOrGhost("player") then
			StartCorpseSearch()
		end
	end

	if event == "PLAYER_ALIVE" or event == "PLAYER_ENTERING_WORLD" then
		if UnitIsDeadOrGhost("player") then
			StartCorpseSearch()
		else
			ClearCorpseArrow()
		end
	elseif event == "PLAYER_DEAD" then
		StartCorpseSearch()
	elseif event == "PLAYER_UNGHOST" then
		ClearCorpseArrow()
	end
end)

if IsLoggedIn() then
	eventFrame:GetScript("OnEvent")(eventFrame, "ADDON_LOADED", addonName)
end
