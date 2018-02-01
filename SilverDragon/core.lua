local BZR = LibStub("LibBabble-Zone-3.0"):GetReverseLookupTable()
local BCT = LibStub("LibBabble-CreatureType-3.0"):GetUnstrictLookupTable()
local BCTR = LibStub("LibBabble-CreatureType-3.0"):GetReverseLookupTable()

local addon = LibStub("AceAddon-3.0"):NewAddon("SilverDragon", "AceEvent-3.0", "AceTimer-3.0")
SilverDragon = addon
addon.events = LibStub("CallbackHandler-1.0"):New(addon)

local globaldb
function addon:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("SilverDragon2DB", {
		global = {
			mobs_byzone = {
				['*'] = {}, -- zones
			},
			mob_locations = {
				['*'] = {}, -- mob names
			},
			mob_id = {}, -- NPC ids, only available for mobs from wowhead
			mob_type = {},
			mob_level = {},
			mob_elite = {},
			mob_tameable = {},
			mob_count = {
				['*'] = 0,
			},
		},
		profile = {
			scan = 0.5, -- scan interval, 0 for never
			delay = 600, -- number of seconds to wait between recording the same mob
			cache_tameable = true, -- whether to alert for tameable mobs found through cache-scanning
			mouseover = true,
			targets = true,
			nameplates = true,
			cache = true,
			instances = true,
		},
	})
	globaldb = self.db.global
end

function addon:OnEnable()
	self:RegisterEvent("PLAYER_TARGET_CHANGED")
	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
	if self.db.profile.scan > 0 then
		self:ScheduleRepeatingTimer("CheckNearby", self.db.profile.scan)
	end
end

function addon:PLAYER_TARGET_CHANGED()
	if self.db.profile.targets then
		self:ProcessUnit('target', 'target')
	end
end

function addon:UPDATE_MOUSEOVER_UNIT()
	if self.db.profile.mouseover then
		self:ProcessUnit('mouseover', 'mouseover')
	end
end

local lastseen = {}
function addon:ProcessUnit(unit, source)
	if UnitPlayerControlled(unit) then return end -- helps filter out player-pets
	local unittype = UnitClassification(unit)
	if not (unittype == 'rare' or unittype == 'rareelite') or not UnitIsVisible(unit) then return end
	-- from this point on, it's a rare
	local zone, x, y = self:GetPlayerLocation()
	if not zone then return end -- there are only a few places where this will happen
	
	local name = UnitName(unit)
	if lastseen[name] and time() < lastseen[name] + self.db.profile.delay then
		-- we saw it too recently to *record* it, but we'll let the caller know
		self.events:Fire("Seen_Silent", zone, name, x, y, UnitIsDead(unit), false, source or 'target', unit, globaldb.mob_id[name])
		return true
	end

	local level = UnitLevel(unit)
	local creature_type = UnitCreatureType(unit)
	
	local newloc = self:SaveMob(zone, name, x, y, level, unittype=='rareelite', creature_type)

	lastseen[name] = time()
	self.events:Fire("Seen", zone, name, x, y, UnitIsDead(unit), newloc, source or 'target', unit, globaldb.mob_id[name])
	return true
end

function addon:SaveMob(zone, name, x, y, level, elite, creature_type, force, unseen)
	if not (zone and name) then return end
	-- saves a mob's information, returns true if this is the first time a mob has been seen at this location
	if not globaldb.mob_locations[name] then globaldb.mob_locations[name] = {} end

	globaldb.mobs_byzone[zone][name] = unseen and 0 or time()
	globaldb.mob_level[name] = level
	if elite then globaldb.mob_elite[name] = true end
	globaldb.mob_type[name] = BCTR[creature_type]
	globaldb.mob_count[name] = globaldb.mob_count[name] + (unseen and 0 or 1)
	
	if not (x and y and x > 0 and y > 0) then return end

	local newloc = true
	if not force then
		for _, coord in ipairs(globaldb.mob_locations[name]) do
			local loc_x, loc_y = self:GetXY(coord)
			if (math.abs(loc_x - x) < 0.03) and (math.abs(loc_y - y) < 0.03) then
				-- We've seen it close to here before. (within 5% of the zone)
				newloc = false
				break
			end
		end
	end
	if newloc then
		table.insert(globaldb.mob_locations[name], self:GetCoord(x, y))
	end
	return newloc
end

-- Returns num_locs, level, is_elite, creature_type, last_seen, times_seen, mob_id, is_tameable
function addon:GetMob(zone, name)
	if not (zone and name and globaldb.mobs_byzone[zone][name]) then
		return 0, 0, false, UNKNOWN, nil, 0, nil, nil
	end
	return #globaldb.mob_locations[name], globaldb.mob_level[name], globaldb.mob_elite[name], BCT[globaldb.mob_type[name]], globaldb.mobs_byzone[zone][name], globaldb.mob_count[name], globaldb.mob_id[name], globaldb.mob_tameable[name]
end

-- Returns name, addon:GetMob(zone, name)
function addon:GetMobByCoord(zone, coord)
	if not globaldb.mobs_byzone[zone] then return end
	for name in pairs(globaldb.mobs_byzone[zone]) do
		for _, mob_coord in ipairs(globaldb.mob_locations[name]) do
			if coord == mob_coord then
				return name, self:GetMob(zone, name)
			end
		end
	end
end

function addon:DeleteMob(zone, name)
	if not (zone and name) then return end
	if not globaldb.mobs_byzone[zone] then return end
	globaldb.mobs_byzone[zone][name] = nil
	globaldb.mob_level[name] = nil
	globaldb.mob_elite[name] = nil
	globaldb.mob_type[name] = nil
	globaldb.mob_count[name] = nil
	globaldb.mob_locations[name] = nil
end

function addon:DeleteAllMobs()
	local n = 0
	for zone,mobs in pairs(globaldb.mobs_byzone) do for name, info in pairs(mobs) do
		self:DeleteMob(zone, name)
		n = n + 1
	end end
	DEFAULT_CHAT_FRAME:AddMessage("SilverDragon: Removed "..n.." rare mobs from database.")
	self.events:Fire("DeleteAll", n)
end

-- Scanning:

function addon:CheckNearby()
	local zone = self:GetPlayerLocation()
	if not zone then return end
	if (not self.db.profile.instances) and IsInInstance() then return end
	
	if self.db.profile.targets then
		addon:ScanTargets(zone)
	end
	if self.db.profile.nameplates then
		addon:ScanNameplates(zone)
	end
	if self.db.profile.cache then
		addon:ScanCache(zone)
	end
end

local units_to_scan = {'targettarget', 'party1target', 'party2target', 'party3target', 'party4target', 'party5target'}
function addon:ScanTargets()
	for _, unit in ipairs(units_to_scan) do
		self:ProcessUnit(unit, 'grouptarget')
	end
end

local nameplates = {}
local function process_possible_nameplate(frame)
	-- This was mostly copied from "Nameplates - Nameplate Modifications" by Biozera.
	-- Nameplates are unnamed children of WorldFrame.
	-- So: drop it if it's not the right type, has a name, or we already know about it.
	if frame:GetObjectType() ~= "Frame" or frame:GetName() or nameplates[frame] then
		return
	end
	local name, level, bar, icon, border, glow
	for i=1,frame:GetNumRegions(),1 do
		local region = select(i, frame:GetRegions())
		if region then
			local oType = region:GetObjectType()
			if oType == "FontString" then
				local point, _, relativePoint = region:GetPoint()
				if point == "BOTTOM" and relativePoint == "CENTER" then
					name = region
				elseif point == "CENTER" and relativePoint == "BOTTOMRIGHT" then
					level = region
				end
			elseif oType == "Texture" then
				local path = region:GetTexture()
				if path == "Interface\\TargetingFrame\\UI-RaidTargetingIcons" then
					icon = region
				elseif path == "Interface\\Tooltips\\Nameplate-Border" then
					border = region
				elseif path == "Interface\\Tooltips\\Nameplate-Glow" then
					glow = region
				end
			end
		end
	end
	for i=1,frame:GetNumChildren(),1 do
		local childFrame = select(i, frame:GetChildren())
		if childFrame:GetObjectType() == "StatusBar" then
			bar = childFrame
		end
	end
	if name and level and bar and border and glow then -- We have a nameplate!
		nameplates[frame] = {name = name, level = level, bar = bar, border = border, glow = glow}
		return true
	end
end

local num_worldchildren
function addon:ScanNameplates(zone)
	if GetCVar("nameplateShowEnemies") ~= "1" then
		return
	end
	if num_worldchildren ~= WorldFrame:GetNumChildren() then
		num_worldchildren = WorldFrame:GetNumChildren()
		for i=1, num_worldchildren, 1 do
			process_possible_nameplate(select(i, WorldFrame:GetChildren()))
		end
	end
	
	local zone_mobs = globaldb.mobs_byzone[zone]
	if not zone_mobs then return end
	for nameplate, regions in pairs(nameplates) do
		local name = regions.name:GetText()
		if nameplate:IsVisible() and zone_mobs[name] and (not lastseen[name] or (lastseen[name] < (time() - self.db.profile.delay))) then
			local x, y = GetPlayerMapPosition('player')
			self.events:Fire("Seen", zone, name, x, y, false, false, "nameplate", false, globaldb.mob_id[name])
			lastseen[name] = time()
			break -- it's pretty unlikely there'll be two rares on screen at once
		end
	end
end

local already_cached = {}
local first_cachescan = true
local cache_tooltip = CreateFrame("GameTooltip", "SDCacheTooltip")
cache_tooltip:AddFontStrings(
    cache_tooltip:CreateFontString("$parentTextLeft1", nil, "GameTooltipText"),
	cache_tooltip:CreateFontString("$parentTextRight1", nil, "GameTooltipText")
)

local function is_cached(id)
	-- this doesn't work with just clearlines and the setowner outside of this, and I'm not sure why
	cache_tooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
	cache_tooltip:SetHyperlink(("unit:0xF53000%04X000000"):format(id))
	return cache_tooltip:IsShown()
end
addon.is_cached = is_cached

addon.already_cached = already_cached

function addon:ScanCache(zone)
	if first_cachescan then
		for mob, id in pairs(globaldb.mob_id) do
			if is_cached(id) then
				already_cached[id] = true
			end
		end
		first_cachescan = false
		return
	end
	
	local zone_mobs = globaldb.mobs_byzone[zone]
	if not zone_mobs then return end
	for mob, lastseen in pairs(zone_mobs) do
		local id = globaldb.mob_id[mob]
		if id and (not globaldb.mob_tameable[mob] or self.db.profile.cache_tameable) and not already_cached[id] and is_cached(id) then
			already_cached[id] = true
			self.events:Fire("Seen", zone, mob, x, y, false, false, "cache", false, id)
		end
	end
	first_cachescan = false
end
addon.RegisterCallback(addon, "Import", function()
	if first_cachescan then
		table.wipe(already_cached)
		first_cachescan = true
	end
end)

-- Utility:

function addon:FormatLastSeen(t)
	t = tonumber(t)
	if not t or t == 0 then return 'Never' end
	local currentTime = time()
	local minutes = math.ceil((currentTime - t) / 60)
	if minutes > 59 then
		local hours = math.ceil((currentTime - t) / 3600)
		if hours > 23 then
			return math.ceil((currentTime - t) / 86400).." day(s)"
		else
			return hours.." hour(s)"
		end
	else
		return minutes.." minute(s)"
	end
end

local continent_list = { GetMapContinents() }
local zone_to_mapfile = {}
local mapfile_to_zone = {}
for C in pairs(continent_list) do
	local zones = { GetMapZones(C) }
	continent_list[C] = zones
	for Z, Zname in ipairs(zones) do
		SetMapZoom(C, Z)
		zones[Z] = GetMapInfo()
		zone_to_mapfile[Zname] = zones[Z]
		mapfile_to_zone[zones[Z]] = Zname
	end
end
addon.continent_list = continent_list
addon.zone_to_mapfile = zone_to_mapfile
addon.mapfile_to_zone = mapfile_to_zone

function addon:GetPlayerLocation()
	-- returns mapFile (e.g. "Stormwind"), x, y
	if IsInInstance() then
		return BZR[GetRealZoneText()], 0, 0
	end
	local x, y = GetPlayerMapPosition('player')
	local C, Z = GetCurrentMapContinent(), GetCurrentMapZone()
	if x <= 0 and y <= 0 then
		if WorldMapFrame:IsVisible() then
			return
		end
		SetMapToCurrentZone()
		x, y = GetPlayerMapPosition('player')
		if x <= 0 and y <= 0 then
			SetMapZoom(GetCurrentMapContinent())
			x, y = GetPlayerMapPosition('player')
			if x <= 0 and y <= 0 then
				-- this is confusing; we're probably in an instance, but
				-- IsInInstance() returned false above.
				return BZR[GetRealZoneText()], 0, 0
			end
		end
		local C2, Z2 = GetCurrentMapContinent(), GetCurrentMapZone()
		if C2 ~= C or Z2 ~= Z then
			SetMapZoom(C, Z)
		end
		C, Z = C2, Z2
	end
	if not (continent_list[C] and continent_list[C][Z]) then
		return
	end
	return continent_list[C][Z], x, y
end

function addon:GetCoord(x, y)
	return floor(x * 10000 + 0.5) * 10000 + floor(y * 10000 + 0.5)
end

function addon:GetXY(coord)
	return floor(coord / 10000) / 10000, (coord % 10000) / 10000
end

