--[[
Copyright (c) 2009, Hendrik "Nevcairiel" Leppkes < h.leppkes@gmail.com >
All rights reserved.
]]

local Mapster = LibStub("AceAddon-3.0"):GetAddon("Mapster")
local L = LibStub("AceLocale-3.0"):GetLocale("Mapster")

local optGetter, optSetter
do
	function optGetter(info)
		local key = info[#info]
		if key:sub(0,5) == "mini_" then
			return Mapster.db.profile.mini[key:sub(6)]
		else
			return Mapster.db.profile[key]
		end
	end

	function optSetter(info, value)
		local key = info[#info]
		if key:sub(0,5) == "mini_" then
			Mapster.db.profile.mini[key:sub(6)] = value
		else
			Mapster.db.profile[key] = value
		end
		Mapster:Refresh()
	end
end

local options, moduleOptions = nil, {}
local function getOptions()
	if not options then
		options = {
			type = "group",
			name = "Mapster",
			args = {
				general = {
					order = 1,
					type = "group",
					name = "General Settings",
					get = optGetter,
					set = optSetter,
					args = {
						intro = {
							order = 1,
							type = "description",
							name = L["Mapster allows you to control various aspects of your World Map. You can change the style of the map, control the plugins that extend the map with new functionality, and configure different profiles for every of your characters."],
						},
						alphadesc = {
							order = 2,
							type = "description",
							name = L["You can change the transparency of the world map to allow you to continue seeing the world environment while your map is open for navigation."],
						},
						alpha = {
							order = 3,
							name = L["Alpha"],
							desc = L["The transparency of the big map."],
							type = "range",
							min = 0, max = 1, bigStep = 0.01,
							isPercent = true,
						},
						mini_alpha = {
							order = 4,
							name = L["Minimized Alpha"],
							desc = L["The transparency of the minimized map."],
							type = "range",
							min = 0, max = 1, bigStep = 0.01,
							isPercent = true,
						},
						scaledesc = {
							order = 5,
							type = "description",
							name = L["Change the scale of the world map if you do not want the whole screen filled while the map is open."],
						},
						scale = {
							order = 6,
							name = L["Scale"],
							desc = L["Scale of the big map."],
							type = "range",
							min = 0.1, max = 2, bigStep = 0.01,
							isPercent = true,
						},
						mini_scale = {
							order = 7,
							name = L["Minimized Scale"],
							desc = L["Scale of the minimized map."],
							type = "range",
							min = 0.1, max = 2, bigStep = 0.01,
							isPercent = true,
						},
						nl = {
							order = 10,
							type = "description",
							name = "",
						},
						arrowScale = {
							order = 11,
							name = L["PlayerArrow Scale"],
							desc = L["Adjust the size of the Player Arrow on the Map for better visibility."],
							type = "range",
							min = 0.5, max = 2, bigStep = 0.01,
							isPercent = true,
						},
						poiScale = {
							order = 12,
							type = "range",
							name = L["POI Scale"],
							desc = L["Scale of the POI Icons on the Map."],
							min = 0.1, max = 2, bigStep = 0.01,
							isPercent = true,
						},
						nl2 = {
							order = 20,
							type = "description",
							name = "",
						},
						hideMapButton = {
							order = 21,
							type = "toggle",
							name = L["Hide Map Button"],
						},
						nl3 = {
							order = 30,
							type = "description",
							name = "",
						},
						hideBorder = {
							order = 31,
							type = "toggle",
							name = L["Hide Border"],
							desc = L["Hide the borders of the big map."],
							disabled = true,
						},
						mini_hideBorder = {
							order = 32,
							type = "toggle",
							name = L["(Mini) Hide Border"],
							desc = L["Hide the borders of the minimized map."],
						},
						disableMouse = {
							order = 33,
							type = "toggle",
							name = L["Disable Mouse"],
							desc = L["Disable the mouse interactivity of the main map, eg. to change zones."],
						},
						mini_disableMouse = {
							order = 34,
							type = "toggle",
							name = L["(Mini) Disable Mouse"],
							desc = L["Disable the mouse interactivity of the main map when in minimized mode, eg. to change zones."],
						},
					},
				},
			},
		}
		for k,v in pairs(moduleOptions) do
			options.args[k] = (type(v) == "function") and v() or v
		end
	end
	
	return options
end

local function optFunc() 
	-- open the profiles tab before, so the menu expands
	InterfaceOptionsFrame_OpenToCategory(Mapster.optionsFrames.Profiles)
	InterfaceOptionsFrame_OpenToCategory(Mapster.optionsFrames.Mapster)
	InterfaceOptionsFrame:Raise()
end

function Mapster:SetupOptions()
	self.optionsFrames = {}

	-- setup options table
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("Mapster", getOptions)
	self.optionsFrames.Mapster = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Mapster", nil, nil, "general")

	self:RegisterModuleOptions("Profiles", LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db), "Profiles")

	LibStub("AceConsole-3.0"):RegisterChatCommand( "mapster", optFunc)
end

function Mapster:RegisterModuleOptions(name, optionTbl, displayName)
	moduleOptions[name] = optionTbl
	self.optionsFrames[name] = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Mapster", displayName, "Mapster", name)
end

function Mapster:SetupMapButton()
	-- create button on the worldmap to toggle the options
	self.optionsButton = CreateFrame("Button", "MapsterOptionsButton", WorldMapFrame, "UIPanelButtonTemplate")
	self.optionsButton:SetWidth(95)
	self.optionsButton:SetHeight(18)
	self.optionsButton:SetText("Mapster")
	self.optionsButton:ClearAllPoints()
	self.optionsButton:SetPoint("TOPRIGHT", WorldMapPositioningGuide, "TOPRIGHT", -43, -2)

	if self.db.profile.hideMapButton then
		self.optionsButton:Hide()
	else
		self.optionsButton:Show()
	end

	self.optionsButton:SetScript("OnClick", optFunc)
end
