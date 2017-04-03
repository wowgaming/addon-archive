local GatherMate = LibStub("AceAddon-3.0"):GetAddon("GatherMate")
local Display = GatherMate:NewModule("Display","AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("GatherMate")

-- Current minimap pin set
local minimapPins, minimapPinCount = {}, 0
-- Current worldmap pin set
local worldmapPins = {}
-- cache of zones names by continent and zoned id from WowAPI
local zoneData, continentData, specialZones
-- table for UIDropdownMenu info
local info = {}
-- cache of pins
local pinCache = {}
-- last x,y of the player.
-- total number of pins we have created
local lastX, lastY, lastXY, lastYY, pinCount = 0, 0, 0, 0, 0
-- reference to the pin generating the UIDropDown
local pinClickedOn
-- our current zone
local zone = ""
-- cache of table insert functions
local tinsert, tremove, next, pairs = tinsert, tremove, next, pairs
-- minimap rotation
local rotateMinimap = GetCVar("rotateMinimap") == "1"
-- shape of the minimap
local minimapShape
-- is the minimap indoors or outdoors
local indoors = GetCVar("minimapZoom")+0 == Minimap:GetZoom() and "outdoor" or "indoor"
-- diameter of the minimap
local mapRadius, worldmapWidth, worldmapHeight, minimapWidth, minimapHeight, minimapScale, lastFacing, lastZoom
local minimapStrata, worldmapStrata, minimapFrameLevel, worldmapFrameLevel
-- math function cache
local math_sin, math_cos, abs, max = math.sin, math.cos, math.abs, math.max
local sin, cos
-- API function cache
local GetRealZoneText, GetPlayerMapPosition = GetRealZoneText, GetPlayerMapPosition
local strfind, format = string.find, string.format
local trackingCircle, nodeTextures
local db
local Minimap = Minimap
local WorldMapButton = WorldMapButton
local inInstance
local nodeRange = 2
local forceNextUpdate
local trackShow = {}

local profession_to_skill = {}
local have_prof_skill = {}

local active_tracking
local texture_to_skill = {}

--[[
	recycle a pin
]]
local function recyclePin(pin)
	pin:Hide()
	pin.coords = nil
	pin.nodeType = nil
	pin.zone = nil
	pin.title = nil
	pin.worldmap = false
	pin.nodeID = 0
	pin.keep = nil
	pinCache[pin] = true
end
--[[
	clear a set of pins
]]
local function clearpins(t)
	for k,v in pairs(t) do
		recyclePin(v)
		t[k] = nil
	end
end
--[[
	Delete a pin from the DB, then call update to refresh both minimap and world map
]]
local function deletePin(button,pin)
	GatherMate:RemoveNodeByID(pin.zone, pin.nodeType, pin.coords)
	Display:UpdateWorldMap(true)
	Display:UpdateMiniMap(true)
end
--[[
	Pin OnEnter
]]
local tooltip_template = "|c%02x%02x%02x%02x%s|r"
local function showPin(self)
	if (self.title) then
		local tooltip, pinset
		if self.worldmap then
			-- override default UI to hide the tooltip
			WorldMapBlobFrame:SetScript("OnUpdate", nil)
			tooltip = WorldMapTooltip
			pinset = worldmapPins
		else
			tooltip = GameTooltip
			pinset = minimapPins
		end
		local x, y = self:GetCenter()
		local parentX, parentY = UIParent:GetCenter()
		if ( x > parentX ) then
			tooltip:SetOwner(self, "ANCHOR_LEFT")
		else
			tooltip:SetOwner(self, "ANCHOR_RIGHT")
		end
		
		local t = db.trackColors
		local text = format(tooltip_template, t[self.nodeType].Alpha*255, t[self.nodeType].Red*255, t[self.nodeType].Green*255, t[self.nodeType].Blue*255, self.title)
		local lvl = GatherMate.nodeMinHarvest[self.nodeType][self.nodeID]
		if lvl then
			text = text..format(" (%d)", lvl)
		end
		for id, pin in pairs(pinset) do
			if pin:IsMouseOver() and pin.title and pin ~= self then
				text = text .. "\n" .. format(tooltip_template, t[pin.nodeType].Alpha*255, t[pin.nodeType].Red*255, t[pin.nodeType].Green*255, t[pin.nodeType].Blue*255, pin.title)
				local lvl = GatherMate.nodeMinHarvest[pin.nodeType][pin.nodeID]
				if lvl then
					text = text..format(" (%d)", lvl)
				end
			end
		end
		tooltip:SetText(text)
		tooltip:Show()
	end
end
--[[
	Pin OnLeave
]]
local function hidePin(self)
	if self.worldmap then
		-- restore default UI
		WorldMapBlobFrame:SetScript("OnUpdate", WorldMapBlobFrame_OnUpdate)
		WorldMapTooltip:Hide()
	else
		GameTooltip:Hide()
	end
end
--[[
	Pin click handler
]]
local function pinClick(self, button)
	if button == "RightButton" and self.worldmap then
		pinClickedOn = self
		ToggleDropDownMenu(1, nil, GatherMate_GenericDropDownMenu, self:GetName(), 0, 0)
	elseif self.worldmap == false then
		-- This "simulates" clickthru on the minimap to ping the minimap, by roughknight
		if Minimap:GetObjectType() == "Minimap" then -- This is for SexyMap's HudMap, which reparents to a hud frame that isn't a minimap
			local point, parent, relPoint, x, y = self:GetPoint()
			Minimap:PingLocation(x, y)
		end
	end
end
--[[
	Add pin location to Cartographer_Waypoints
]]
local function addCartWaypoint(button,pin)
	if Cartographer and Cartographer.HasModule and Cartographer:HasModule("Waypoints") and Cartographer:IsModuleActive("Waypoints") then
		local x, y = GatherMate:getXY(pin.coords)
		local cartCoordID = floor(x*10000 + 0.5) + floor(y*10000 + 0.5)*10001
		local BZR = LibStub("LibBabble-Zone-3.0"):GetReverseLookupTable()
		Cartographer_Waypoints:AddRoutesWaypoint(BZR[pin.zone], cartCoordID, pin.title)
	end
end
--[[
	Add pin location to TomTom waypoints
]]
local function addTomTomWaypoint(button,pin)
	if TomTom then
		local c, z = GetCurrentMapContinent(), GetCurrentMapZone()
		local x, y = GatherMate:getXY(pin.coords)
		TomTom:AddZWaypoint(c, z, x*100, y*100, pin.title, nil, true, true)
	end
end
--[[
	Generate a drop down menu for a pin
]]
local function generatePinMenu(self,level)
	if (not level) then return end
	for k in pairs(info) do info[k] = nil end
	if (level == 1) then
		-- Create the title of the menu
		info.isTitle      = 1
		info.text         = L["GatherMate Pin Options"]
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, level)

		-- Generate a menu item for each pin the mouse is on
		info.disabled     = nil
		info.isTitle      = nil
		info.notCheckable = nil
		for id, pin in pairs(worldmapPins) do
			if pin:IsMouseOver() and pin.title then
				info.text = L["Delete"] .. " :" ..pin.title
				info.icon = nodeTextures[pin.nodeType][GatherMate:GetIDForNode(pin.nodeType, pin.title)]
				info.func = deletePin
				info.arg1 = pin
				UIDropDownMenu_AddButton(info, level);
			end
		end

		-- Cartographer_Waypoints menu item
		if Cartographer and Cartographer.HasModule and Cartographer:HasModule("Waypoints") and Cartographer:IsModuleActive("Waypoints") then
			info.text = L["Add this location to Cartographer_Waypoints"]
			info.icon = nil
			info.func = addCartWaypoint
			info.arg1 = pinClickedOn
			UIDropDownMenu_AddButton(info, level)
		end

		if TomTom then
			info.text = L["Add this location to TomTom waypoints"]
			info.icon = nil
			info.func = addTomTomWaypoint
			info.arg1 = pinClickedOn
			UIDropDownMenu_AddButton(info, level)
		end

		-- Close menu item
		info.text         = CLOSE
		info.icon         = nil
		info.func         = function() CloseDropDownMenus() end
		info.arg1         = nil
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, level);
	end
end

--[[
	Setup the dropdown menu
]]
local GatherMate_GenericDropDownMenu = CreateFrame("Frame", "GatherMate_GenericDropDownMenu")
GatherMate_GenericDropDownMenu.displayMode = "MENU"
GatherMate_GenericDropDownMenu.initialize = generatePinMenu
local last_update = 0
local listening = false

local wow40 = select(4,GetBuildInfo()) >= 40000

--[[
	Enable the mod and add our event listeners and timers
]]
local fullInit = false
function Display:OnEnable()
	db = GatherMate.db.profile
	
	trackingCircle = self.trackingCircle
	nodeTextures = GatherMate.nodeTextures
	continentData = GatherMate.continentData
	zoneData = GatherMate.zoneData
	specialZones = GatherMate.specialZones
	-- Recheck cvars after all addons are loaded.
	rotateMinimap = GetCVar("rotateMinimap") == "1"
	if not self.updateFrame then
		GatherMate.Visible = {}
		WorldMapFrame:HookScript("OnHide", function() SetMapToCurrentZone() end)
		self.updateFrame = CreateFrame("Frame")
		self.updateFrame:SetScript("OnUpdate", function(frame, elapsed)
		 	last_update = last_update + elapsed
			if last_update > 2 or forceNextUpdate then
				Display:UpdateMiniMap(true)
				last_update = 0
				forceNextUpdate = false
			else
				Display:UpdateIconPositions()
			end
		end)
	end
	SetMapToCurrentZone()
	self:RegisterMapEvents()
	self:RegisterEvent("WORLD_MAP_UPDATE", "UpdateWorldMap")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "UpdateMaps")
	if not wow40 then
		self:RegisterEvent("SKILL_LINES_CHANGED")
		self:RegisterEvent("MINIMAP_UPDATE_TRACKING")
		self:SKILL_LINES_CHANGED()
		self:MINIMAP_UPDATE_TRACKING()
	end
	self:UpdateVisibility()
	self:UpdateMaps()
	fullInit = true
end

function Display:RegisterMapEvents()
	self:RegisterEvent("MINIMAP_ZONE_CHANGED", "MinimapChanged")
	self:RegisterEvent("MINIMAP_UPDATE_ZOOM", "MinimapZoom")
	self:RegisterEvent("CVAR_UPDATE", "ChangedVars")
	self:RegisterMessage("GatherMateConfigChanged","ConfigChanged")
	self:RegisterMessage("GatherMateNodeAdded", "ScheduleUpdate")
	self:RegisterMessage("GatherMateDataImport", "DataUpdate")
	self:RegisterMessage("GatherMateCleanup", "DataUpdate")
	self.updateFrame:Show()
	listening = true
end

function Display:UnregisterMapEvents()
	self:UnregisterEvent("MINIMAP_ZONE_CHANGED")
	self:UnregisterEvent("MINIMAP_UPDATE_ZOOM")
	self:UnregisterEvent("CVAR_UPDATE")
	self:UnregisterMessage("GatherMateConfigChanged")
	self:UnregisterMessage("GatherMateNodeAdded")
	self:UnregisterMessage("GatherMateDataImport")
	self:UnregisterMessage("GatherMateCleanup")
	clearpins(worldmapPins)
	clearpins(minimapPins)
	self.updateFrame:Hide()
	listening = false
end

-- Disable the mod
function Display:OnDisable()
	self:UnregisterMapEvents()
	self:UnregisterEvent("WORLD_MAP_UPDATE")
	self:UnregisterEvent("ZONE_CHANGED_NEW_AREA")
	self:UnregisterEvent("SKILL_LINES_CHANGED")
	self:UnregisterEvent("MINIMAP_UPDATE_TRACKING")
end


function Display:SKILL_LINES_CHANGED()
if not wow40 then
	local skillname, isHeader
	for k,v in pairs(have_prof_skill) do
		have_prof_skill[k] = nil
	end
	
	for i = 1, GetNumSkillLines() do
		skillname, isHeader = GetSkillLineInfo(i)
		if not isHeader and skillname then
			for prof, skill in pairs(profession_to_skill) do
				if strfind(skillname, prof, 1, true) then
					have_prof_skill[skill] = true
				end
			end
		end
	end
end
	self:UpdateVisibility()
	self:UpdateMaps()
end

function Display:MINIMAP_UPDATE_TRACKING()
if not wow40 then
	active_tracking = texture_to_skill[GetTrackingTexture()]
end
	self:UpdateVisibility()
	self:UpdateMaps()
end

function Display:UpdateVisibility()
	for k, v in pairs(GatherMate.db_types) do
		local visible = false
		local state = db.show[v]
		if state == "always" then
			visible = true
		elseif state == "with_profession" then
			visible = have_prof_skill[v]
		elseif state == "active" then
			visible = (active_tracking == v)
		end
		GatherMate.Visible[v] = visible

		-- For tracking circle
		visible = false
		state = db.trackShow
		if state == "always" then
			visible = true
		elseif state == "with_profession" then
			visible = have_prof_skill[v]
		elseif state == "active" then
			visible = (active_tracking == v)
		end
		trackShow[v] = visible
	end
end

function Display:SetSkillTracking(skill, tracking)
	texture_to_skill[tracking] = skill
	if fullInit then self:MINIMAP_UPDATE_TRACKING() end
end

function Display:SetSkillProfession(skill, profession)
	profession_to_skill[profession] = skill
	if fullInit then self:SKILL_LINES_CHANGED() end
end

function Display:ScheduleUpdate()
	forceNextUpdate = true
end

function Display:DataUpdate()
	forceNextUpdate = true
	Display:UpdateWorldMap(true)
end

function Display:ConfigChanged()
	db = GatherMate.db.profile
	self:UpdateVisibility()
	self:UpdateMaps()
	-- TODO filter prefs
end
--[[
	Get a Map pin
]]
function Display:getMapPin()
	local pin = next(pinCache)
	if pin then
		pinCache[pin] = nil -- remove it from the cache
		return pin
	end
	-- create a new pin
	pinCount = pinCount + 1
	pin = CreateFrame("Button", "GatherMatePin"..pinCount, WorldMapButton)
	pin:SetFrameLevel(5)
	pin:EnableMouse(true)
	pin:SetWidth(16)
	pin:SetHeight(16)
	pin:SetPoint("CENTER", WorldMapButton, "CENTER")
	local texture = pin:CreateTexture(nil, "OVERLAY")
	pin.texture = texture
	texture:SetAllPoints(pin)
	texture:SetTexture(trackingCircle)
	texture:SetTexCoord(0, 1, 0, 1)
	pin:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	pin:SetScript("OnEnter", showPin)
	pin:SetScript("OnLeave", hidePin)
	pin:SetScript("OnClick", pinClick)
	pin:Hide()
	return pin
end
--[[
	Add a pin to the world map
]]
function Display:addWorldPin(coord, nodeID, nodeType, zone, index)
	local pin = worldmapPins[index]
	if not pin then
		pin = self:getMapPin()
		local x, y = GatherMate:getXY(coord)
		pin.coords = coord
		pin.title = GatherMate:GetNameForNode(nodeType, nodeID)
		pin.zone = zone
		pin.nodeID = nodeID
		pin.nodeType = nodeType
		pin.worldmap = true
		pin:SetParent(WorldMapButton)
		pin:SetFrameStrata(worldmapStrata)
		pin:SetFrameLevel(worldmapFrameLevel)
		pin:SetHeight(12 * db.scale)
		pin:SetWidth(12 * db.scale)
		pin:SetAlpha(db.alpha)
		pin:EnableMouse(true)
		pin.texture:SetTexture(nodeTextures[nodeType][nodeID])
		pin.texture:SetTexCoord(0, 1, 0, 1)
		pin.texture:SetVertexColor(1, 1, 1, 1)
		pin:Show()
		pin:ClearAllPoints()
		pin:SetPoint("CENTER", WorldMapButton, "TOPLEFT", x *worldmapWidth, -y * worldmapHeight)
		worldmapPins[index] = pin
	end
	return pin
end
--[[
	Add a new pin to the minimap
]]
function Display:getMiniPin(coord, nodeID, nodeType, zone, index)
	local pin = minimapPins[index]
	if not pin then
		pin = self:getMapPin()
		pin.coords = coord
		pin.title = GatherMate:GetNameForNode(nodeType, nodeID)
		pin.zone = zone
		pin.nodeID = nodeID
		pin.nodeType = nodeType
		pin.worldmap = false
		pin:SetParent(Minimap)
		pin:SetFrameStrata(minimapStrata)
		pin:SetFrameLevel(minimapFrameLevel)
		pin:SetHeight(12 * db.scale / minimapScale)
		pin:SetWidth(12 * db.scale / minimapScale)
		--pin:SetAlpha(db.alpha)
		pin:EnableMouse(db.minimapTooltips)
		pin.isCircle = false
		pin.texture:SetTexture(nodeTextures[nodeType][nodeID])
		pin.texture:SetTexCoord(0, 1, 0, 1)
		pin.texture:SetVertexColor(1, 1, 1, 1)
		pin.x, pin.y = GatherMate:getXY(coord)
		pin.x1, pin.y1 = GatherMate:PointToYards(pin.x,pin.y,zone)
		minimapPins[index] = pin
	end
	return pin
end

function Display:addMiniPin(pin, refresh)
	local xDist, yDist = pin.x1 - lastXY, pin.y1 - lastYY
	-- calculate relative position and distance to the player
	local dist_2 = xDist*xDist + yDist*yDist
	-- if distance <= db.trackDistance, convert to the circle texture
	if (not pin.isCircle or refresh) and trackShow[pin.nodeType] and dist_2 <= db.trackDistance^2 then
		pin.texture:SetTexture(trackingCircle)
		local t = db.trackColors[pin.nodeType]
		pin.texture:SetVertexColor(t.Red, t.Green, t.Blue, t.Alpha)
		pin:SetHeight(10 / minimapScale)
		pin:SetWidth(10 / minimapScale)
		pin.isCircle = true
		pin.texture:SetTexCoord(0, 1, 0, 1)
	-- if distance > 100, set back to the node texture
	elseif (pin.isCircle or refresh) and dist_2 > db.trackDistance^2 then
		pin:SetHeight(12 * db.scale / minimapScale)
		pin:SetWidth(12 * db.scale / minimapScale)
		pin.texture:SetTexture(nodeTextures[pin.nodeType][pin.nodeID])
		pin.texture:SetVertexColor(1, 1, 1, 1)
		pin.texture:SetTexCoord(0, 1, 0, 1)
		pin.isCircle = false
	end
	
	-- support for rotating minimap - transpose coordinates for the circular movement
	if rotateMinimap then
		local dx, dy = xDist, yDist
		xDist = dx*cos - dy*sin
		yDist = dx*sin + dy*cos
	end

	-- place pin on the map
	local diffX, diffY, alpha = 0, 0, 1
	-- adapt delta position to the map radius
	diffX = xDist / mapRadius
	diffY = yDist / mapRadius
	
	-- different minimap shapes
	local isRound = true
	if ( minimapShape and not (xDist == 0 or yDist == 0) ) then
		isRound = (xDist < 0) and 1 or 3
		if ( yDist < 0 ) then
			isRound = minimapShape[isRound]
		else
			isRound = minimapShape[isRound + 1]
		end
	end
	
	-- calculate distance from the center of the map
	local dist
	if isRound then
		dist = (diffX*diffX + diffY*diffY) / 0.9^2
	else
		dist = max(diffX*diffX, diffY*diffY) / 0.9^2
	end
	-- if distance > 1, then adapt node position to slide on the border, and set the node alpha accordingly
	if dist > 1 then
		dist = dist^0.5
		diffX = diffX/dist
		diffY = diffY/dist
		alpha = 2 - dist
		if alpha < 0 then
			pin.keep = nil
		end
	end
	-- finally show and SetPoint the pin
	if db.nodeRange or alpha >= 1 then
		pin:Show()
		pin:ClearAllPoints()
		pin:SetPoint("CENTER", Minimap, "CENTER", diffX * minimapWidth, -diffY * minimapHeight)
		pin:SetAlpha(min(alpha,db.alpha))
	else
		pin:Hide()
	end
end
--[[
	Minimap changed
]]
function Display:MinimapChanged()
	self:UpdateMiniMap(true)
end
--[[
	Minimap zoom changed
]]
function Display:MinimapZoom()
	local zoom = Minimap:GetZoom()
	if GetCVar("minimapZoom") == GetCVar("minimapInsideZoom") then
		Minimap:SetZoom(zoom < 2 and zoom + 1 or zoom - 1)
	end
	indoors = GetCVar("minimapZoom")+0 == Minimap:GetZoom() and "outdoor" or "indoor"
	Minimap:SetZoom(zoom)
	self:UpdateMiniMap()
end
--[[
	Minimap rotation changed
]]
function Display:ChangedVars(event,cvar,value)
	if cvar == "ROTATE_MINIMAP" then
		rotateMinimap = value == "1"
	end
	forceNextUpdate = true
end

function Display:UpdateMaps()
	inInstance = IsInInstance()
	if inInstance and listening then
		self:UnregisterMapEvents()
		return
	elseif not inInstance and not listening then
		self:RegisterMapEvents()
	end
	clearpins(minimapPins)
	if not WorldMapFrame:IsShown() then
		SetMapToCurrentZone()
	end
	self:UpdateMiniMap(true)
	self:UpdateWorldMap(true)
end

function Display:UpdateIconPositions()
	if not db.showMinimap or not Minimap:IsVisible() or inInstance or not zone then return end
	
	-- get the current map  zoom
	local zoom = Minimap:GetZoom()
	local diffZoom = zoom ~= lastZoom
	-- if the map zoom changed, run a full update sweep
	if diffZoom then
		self:UpdateMiniMap()
		return
	end
	
	-- we have no active minimap pins, just return early
	if minimapPinCount == 0 then return end
	
	-- get current player position
	local x, y = GetPlayerMapPosition("player")
	-- if position is 0, the player changed the worldmap to another zone, just keep the old values
	if (x == 0 or y == 0 or GetCurrentMapZone() == 0) and not specialZones[zone] then
		x, y = lastX, lastY
	end
	
	-- for rotating minimap support
	local facing
	if rotateMinimap then
		if GetPlayerFacing then
			facing = GetPlayerFacing()
		else
			facing = -MiniMapCompassRing:GetFacing()
		end
	else
		facing = lastFacing
	end
	
	local refresh
	
	local newScale = Minimap:GetScale()
	if minimapScale ~= newScale then
		minimapScale = newScale
		refresh = true
	end
	
	-- if the player moved, or changed the facing (rotating map) - update nodes
	if x ~= lastX or y ~= lastY or facing ~= lastFacing or refresh then
		-- update radius of the map
		mapRadius = self.minimapSize[indoors][zoom] / 2
		
		-- we calculate the distance to the node in yards
		local _x, _y =  GatherMate:PointToYards(x, y, zone)
		-- update upvalues for icon placement
		lastX, lastY = x, y
		lastXY, lastYY = _x, _y
		lastFacing = facing
		
		if rotateMinimap then
			sin = math_sin(facing)
			cos = math_cos(facing)
		end
		
		-- iterate all nodes and check if they are still in range of our minimap display, or even still existing
		for k,v in pairs(minimapPins) do
			-- update the position of the node
			self:addMiniPin(v, refresh)
		end
	end
end

--[[
	Update the minimap
	we only care about nodes 1000 yards away
]]
function Display:UpdateMiniMap(force)
	if not db.showMinimap or not Minimap:IsVisible() or inInstance then return end
	
	-- update our zone info
	zone = GetRealZoneText()
	if not zone or zone == "" or not rawget(zoneData, zone) then 
		zone = nil
		return 
	end
	
	-- get current player position
	local x, y = GetPlayerMapPosition("player")
	-- if position is 0, the player changed the worldmap to another zone, just keep the old values
	if (x == 0 or y == 0 or GetCurrentMapZone() == 0) and not specialZones[zone] then
		x, y = lastX, lastY
	end
	
	-- get data from the API for calculations
	local zoom = Minimap:GetZoom()
	local diffZoom = zoom ~= lastZoom
	
	-- for rotating minimap support
	local facing
	if rotateMinimap then
		if GetPlayerFacing then
			facing = GetPlayerFacing()
		else
			facing = -MiniMapCompassRing:GetFacing()
		end
	else
		facing = lastFacing
	end
	
	local newScale = Minimap:GetScale()
	if minimapScale ~= newScale then
		minimapScale = newScale
		force = true
	end
	
	
	-- if the player moved, the zoom changed, or changed the facing (rotating map) - update nodes
	if x ~= lastX or y ~= lastY or diffZoom or facing ~= lastFacing or force then
		-- set upvalues to new settings
		minimapShape = GetMinimapShape and self.minimapShapes[GetMinimapShape() or "ROUND"]
		mapRadius = self.minimapSize[indoors][zoom] / 2
		minimapWidth = Minimap:GetWidth() / 2
		minimapHeight = Minimap:GetHeight() / 2
		minimapStrata = Minimap:GetFrameStrata()
		minimapFrameLevel = Minimap:GetFrameLevel() + 5

		-- calculate distance in yards
		local _x, _y =  GatherMate:PointToYards(x, y, zone)
		
		-- update upvalues for icon placement
		lastX, lastY = x, y
		lastZoom = zoom
		lastFacing = facing
		lastXY, lastYY = _x, _y
		
		if rotateMinimap then
			sin = math_sin(facing)
			cos = math_cos(facing)
		end
		
		-- iterate the node databases and add the nodes
		for i,db_type in pairs(GatherMate.db_types) do
			if GatherMate.Visible[db_type] then
				for coord, nodeID in GatherMate:FindNearbyNode(zone, x, y, db_type, mapRadius*nodeRange) do
					local pin = self:getMiniPin(coord, nodeID, db_type, zone, (i * 1e9) + coord)
					pin.keep = true
					self:addMiniPin(pin, force)
				end
			end
		end
		
		minimapPinCount = 0
		for k,v in pairs(minimapPins) do
			if not v.keep then
				recyclePin(v)
				minimapPins[k] = nil
			else
				minimapPinCount = minimapPinCount + 1
				v.keep = nil
			end
		end
	end
end

--[[
	Refresh the worldmap
	we check profile preferences for what to display
]]
local lastDrawnWorldMap
local rememberForce = false
local lastScale, lastAlphaPref
function Display:UpdateWorldMap(force)
	if force then rememberForce = true end
	if not WorldMapFrame:IsVisible() then return end
	if not db.showWorldMap then clearpins(worldmapPins) return end

	local zname = continentData[GetCurrentMapContinent()][GetCurrentMapZone()]
	if not zname then clearpins(worldmapPins) return end -- player is not viewing a zone map of a continent

	if not rememberForce and lastDrawnWorldMap == zname then return end -- already drawn last time, and not forced

	if lastDrawnWorldMap ~= zname then
		clearpins(worldmapPins) -- viewing different zone, so clear all the pins, else don't clear and just do pin deltas
	end
	worldmapWidth = WorldMapButton:GetWidth()
	worldmapHeight = WorldMapButton:GetHeight()
	worldmapStrata = WorldMapButton:GetFrameStrata()
	worldmapFrameLevel = WorldMapButton:GetFrameLevel() + 5
	
	for i,db_type in pairs(GatherMate.db_types) do
		if GatherMate.Visible[db_type] then
			for coord, nodeID in GatherMate:GetNodesForZone(zname, db_type) do
				self:addWorldPin(coord, nodeID, db_type, zname, (i * 1e9) + coord).keep = true
			end
		end
	end
	
	for index, pin in pairs(worldmapPins) do
		if pin.keep then
			pin.keep = nil
		else
			recyclePin(pin)
			worldmapPins[index] = nil
		end
	end
	if lastScale ~= db.scale or lastAlphaPref ~= db.alpha then
		local scale, alpha = db.scale, db.alpha
		for index, pin in pairs(worldmapPins) do
			pin:SetHeight(12 * scale)
			pin:SetWidth(12 * scale)
			pin:SetAlpha(alpha)
		end
		lastScale, lastAlphaPref = scale, alpha
	end
	lastDrawnWorldMap = zname -- record last drawn zone name
	rememberForce = false
end

--[[
	This function is for external addons to call to reparent all existing
	minimap icons to a new minimap frame.
]]
function Display:ReparentMinimapPins(parent)
	Minimap = parent
	GameTooltip:SetFrameLevel(parent:GetFrameLevel()+2) -- Because Chinchilla_Expander_Minimap is on TOOLTIP strata too
	for k, v in pairs(minimapPins) do
		v:SetParent(parent)
	end
	self:UpdateIconPositions()
end
