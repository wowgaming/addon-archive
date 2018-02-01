local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes", true)
if not HandyNotes then return end

local Astrolabe = DongleStub("Astrolabe-0.4")

local core = LibStub("AceAddon-3.0"):GetAddon("SilverDragon")
local module = core:NewModule("HandyNotes", "AceEvent-3.0")

local db
local icon = "Interface\\Icons\\INV_Misc_Head_Dragon_01"

local nodes = {}

local handler = {}
do
	local function iter(t, prestate)
		if not t then return nil end
		local state, value = next(t, prestate)
		while state do
			if value then
				return state, nil, icon, db.icon_scale, db.icon_alpha
			end
			state, value = next(t, state)
		end
		return nil, nil, nil, nil, nil
	end
	function handler:GetNodes(mapFile)
		return iter, nodes[mapFile], nil
	end
end

function handler:OnEnter(mapFile, coord)
	local tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip
	if self:GetCenter() > UIParent:GetCenter() then -- compare X coordinate
		tooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		tooltip:SetOwner(self, "ANCHOR_RIGHT")
	end
	local name, _, level, elite, creature_type, lastseen = core:GetMobByCoord(mapFile, coord)
	tooltip:AddLine(name)
	tooltip:AddDoubleLine(("%s%s"):format(level or '??', elite and '+' or ''), creature_type or UNKNOWN)
	tooltip:AddDoubleLine("Last seen", core:FormatLastSeen(lastseen))
	tooltip:Show()
end

function handler:OnLeave(mapFile, coord)
	if self:GetParent() == WorldMapButton then
		WorldMapTooltip:Hide()
	else
		GameTooltip:Hide()
	end
end

local clicked_zone, clicked_coord
local info = {}

local function deletePin(button, mapFile, coord)
	local name = core:GetMobByCoord(mapFile, coord)
	core:DeleteMob(mapFile, name)
	module:SendMessage("HandyNotes_NotifyUpdate", "SilverDragon")
end

local function createWaypoint(button, mapFile, coord)
	local c, z = HandyNotes:GetCZ(mapFile)
	local x, y = HandyNotes:getXY(coord)
	local name = core:GetMobByCoord(mapFile, coord)
	if TomTom then
		local persistent, minimap, world
		if temporary then
			persistent = true
			minimap = false
			world = false
		end
		TomTom:AddZWaypoint(c, z, x*100, y*100, name, persistent, minimap, world)
	elseif Cartographer_Waypoints then
		Cartographer_Waypoints:AddWaypoint(NotePoint:new(HandyNotes:GetCZToZone(c, z), x, y, name))
	end
end

local function generateMenu(button, level)
	if (not level) then return end
	table.wipe(info)
	if (level == 1) then
		-- Create the title of the menu
		info.isTitle      = 1
		info.text         = "HandyNotes - SilverDragon"
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, level)

		if TomTom or Cartographer_Waypoints then
			-- Waypoint menu item
			info.disabled     = nil
			info.isTitle      = nil
			info.notCheckable = nil
			info.text = "Create waypoint"
			info.icon = nil
			info.func = createWaypoint
			info.arg1 = clicked_zone
			info.arg2 = clicked_coord
			UIDropDownMenu_AddButton(info, level);
		end

		-- Delete menu item
		info.disabled     = nil
		info.isTitle      = nil
		info.notCheckable = nil
		info.text = "Delete rare"
		info.icon = icon
		info.func = deletePin
		info.arg1 = clicked_zone
		info.arg2 = clicked_coord
		UIDropDownMenu_AddButton(info, level);

		-- Close menu item
		info.text         = "Close"
		info.icon         = nil
		info.func         = function() CloseDropDownMenus() end
		info.arg1         = nil
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, level);
	end
end

local dropdown = CreateFrame("Frame")
dropdown.displayMode = "MENU"
dropdown.initialize = generateMenu
function handler:OnClick(button, down, mapFile, coord)
	if button == "RightButton" and not down then
		clicked_zone = mapFile
		clicked_coord = coord
		ToggleDropDownMenu(1, nil, dropdown, self, 0, 0)
	end
end

function module:OnInitialize()
	self.db = core.db:RegisterNamespace("HandyNotes", {
		profile = {
			icon_scale = 1.0,
			icon_alpha = 1.0,
		},
	})
	db = self.db.profile
	HandyNotes:RegisterPluginDB("SilverDragon", handler, {
		type = "group",
		name = "SilverDragon",
		desc = "Where the rares are",
		get = function(info) return db[info.arg] end,
		set = function(info, v)
			db[info.arg] = v
			module:SendMessage("HandyNotes_NotifyUpdate", "SilverDragon")
		end,
		args = {
			desc = {
				name = "These settings control the look and feel of the icon.",
				type = "description",
				order = 0,
			},
			icon_scale = {
				type = "range",
				name = "Icon Scale",
				desc = "The scale of the icons",
				min = 0.25, max = 2, step = 0.01,
				arg = "icon_scale",
				order = 10,
			},
			icon_alpha = {
				type = "range",
				name = "Icon Alpha",
				desc = "The alpha transparency of the icons",
				min = 0, max = 1, step = 0.01,
				arg = "icon_alpha",
				order = 20,
			},
		},
	})
	self:UpdateNodes()
end

function module:Seen(callback, zone, name, x, y, dead, new_location)
	if not nodes[zone] then return end
	if new_location then
		local coord = core:GetCoord(x, y)
		if coord then
			nodes[zone][coord] = name
			self:SendMessage("HandyNotes_NotifyUpdate", "SilverDragon")
		end
	end
end
core.RegisterCallback(module, "Seen")

function module:UpdateNodes()
	for _, mapFile in pairs(core.zone_to_mapfile) do
		nodes[mapFile] = {}
	end
	for zone, mobs in pairs(core.db.global.mobs_byzone) do
		if nodes[zone] then
			for name in pairs(mobs) do
				for _, loc in ipairs(core.db.global.mob_locations[name]) do
					nodes[zone][loc] = name
				end
			end
		end
	end
	self:SendMessage("HandyNotes_NotifyUpdate", "SilverDragon")
end

core.RegisterCallback(module, "Import", "UpdateNodes")
core.RegisterCallback(module, "DeleteAll", "UpdateNodes")
