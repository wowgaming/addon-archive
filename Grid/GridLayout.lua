--[[--------------------------------------------------------------------
	GridLayout.lua
----------------------------------------------------------------------]]

local _, ns = ...
local L = ns.L

local AceOO = AceLibrary("AceOO-2.0")
local media = LibStub("LibSharedMedia-3.0", true)
local GridRoster = Grid:GetModule("GridRoster")

local GridLayout = Grid:NewModule("GridLayout")

--{{{ ConfigMode support

local config_mode
CONFIGMODE_CALLBACKS = CONFIGMODE_CALLBACKS or {}
CONFIGMODE_CALLBACKS["Grid"] = function(action)
	if action == "ON" then
		config_mode = true
	elseif action == "OFF" then
		config_mode = nil
	end
	GridLayout:UpdateTabVisibility()
end

--}}}

--{{{ Frame config function for secure headers

function GridLayout_InitialConfigFunction(frame)
	Grid:GetModule("GridFrame").InitialConfigFunction(frame)
end

--}}}

--{{{ Class for group headers

local GridLayoutHeaderClass = AceOO.Class()
local NUM_HEADERS = 0

function GridLayoutHeaderClass.prototype:init(isPetGroup)
	GridLayoutHeaderClass.super.prototype.init(self)
	self:CreateFrames(isPetGroup)
	self:Reset()
	self:SetOrientation()
end

function GridLayoutHeaderClass.prototype:Reset()
	self.frame:Hide()

	self.frame:SetAttribute("showPlayer", true)
	self.frame:SetAttribute("showSolo", true)
	self.frame:SetAttribute("showParty", true)
	self.frame:SetAttribute("showRaid", true)

	self.frame:SetAttribute("nameList", nil)
	self.frame:SetAttribute("groupFilter", nil)
	self.frame:SetAttribute("strictFiltering", nil)
	self.frame:SetAttribute("sortMethod", "NAME")
	self.frame:SetAttribute("sortDir", nil)
	self.frame:SetAttribute("groupBy", nil)
	self.frame:SetAttribute("groupingOrder", nil)
	self.frame:SetAttribute("maxColumns", nil)
	self.frame:SetAttribute("unitsPerColumn", nil)
	self.frame:SetAttribute("startingIndex", nil)
	self.frame:SetAttribute("columnSpacing", nil)
	self.frame:SetAttribute("columnAnchorPoint", nil)

	self.frame:UnregisterEvent("UNIT_NAME_UPDATE")
end

function GridLayoutHeaderClass.prototype:CreateFrames(isPetGroup)
	NUM_HEADERS = NUM_HEADERS + 1
	local template = isPetGroup and "SecureGroupPetHeaderTemplate" or "SecureGroupHeaderTemplate"

	self.frame = CreateFrame("Frame", "GridLayoutHeader"..NUM_HEADERS, GridLayoutFrame, template)
	self.frame:SetAttribute("template", "SecureUnitButtonTemplate")
	self.frame.initialConfigFunction = GridLayout_InitialConfigFunction
end

function GridLayoutHeaderClass.prototype:GetFrameAttribute(name)
	return self.frame:GetAttribute(name)
end

function GridLayoutHeaderClass.prototype:SetFrameAttribute(name, value)
	return self.frame:SetAttribute(name, value)
end

function GridLayoutHeaderClass.prototype:GetFrameWidth()
	return self.frame:GetWidth()
end

function GridLayoutHeaderClass.prototype:GetFrameHeight()
	return self.frame:GetHeight()
end

function GridLayoutHeaderClass.prototype:IsFrameVisible()
	return self.frame:IsVisible()
end

-- nil or false for vertical
function GridLayoutHeaderClass.prototype:SetOrientation(horizontal)
	local layoutSettings = GridLayout.db.profile
	local groupAnchor = layoutSettings.groupAnchor
	local padding = layoutSettings.Padding

	local xOffset, yOffset, point

	if horizontal then
		if groupAnchor == "TOPLEFT" or groupAnchor == "BOTTOMLEFT" then
			xOffset = padding
			yOffset = 0
			point = "LEFT"
		else
			xOffset = 0-padding
			yOffset = 0
			point = "RIGHT"
		end
	else
		if groupAnchor == "TOPLEFT" or groupAnchor == "TOPRIGHT" then
			xOffset = 0
			yOffset = 0-padding
			point = "TOP"
		else
			xOffset = 0
			yOffset = padding
			point = "BOTTOM"
		end
	end

	self.frame:SetAttribute("xOffset", xOffset)
	self.frame:SetAttribute("yOffset", yOffset)
	self.frame:SetAttribute("point", point)
end

-- return the number of visible units belonging to the GroupHeader
function GridLayoutHeaderClass.prototype:GetVisibleUnitCount()
	local count = 0
	while self.frame:GetAttribute("child"..count) do
		count = count + 1
	end
	return count
end

--}}}

--{{{ GridLayout
--{{{  Initialization

--{{{  AceDB defaults

GridLayout.defaultDB = {
	debug = false,

	layouts = {
		solo = L["By Group 5"],
		party = L["By Group 5"],
		arena = L["By Group 5"],
		heroic_raid = L["By Group 25"],
		raid = L["By Group 10"],
		bg = L["By Group 40"],
	},

	horizontal = false,
	clamp = true,
	FrameLock = false,

	Padding = 1,
	Spacing = 10,
	ScaleSize = 1.0,
	borderTexture = "Blizzard Tooltip",
	BorderR = .5,
	BorderG = .5,
	BorderB = .5,
	BorderA = 1,
	BackgroundR = .1,
	BackgroundG = .1,
	BackgroundB = .1,
	BackgroundA = .65,

	anchor = "TOPLEFT",
	groupAnchor = "TOPLEFT",
	hideTab = false,

	PosX = 500,
	PosY = -400,
}

--}}}
--{{{  AceOptions table

local ORDER_LAYOUT = 20
local ORDER_DISPLAY = 30

GridLayout.options = {
	type = "group",
	name = L["Layout"],
	desc = L["Options for GridLayout."],
	disabled = InCombatLockdown,
	args = {
		-- layouts for SOLO, PARTY, RAID, BG, ARENA
		["sololayout"] = {
			type = "text",
			name = L["Solo Layout"],
			desc = L["Select which layout to use when not in a party."],
			order = ORDER_LAYOUT + 1,
			get = function ()
					return GridLayout.db.profile.layouts.solo
				end,
			set = function (v)
					GridLayout.db.profile.layouts.solo = v
					GridLayout:ReloadLayout()
				end,
			validate = {},
		},
		["partylayout"] = {
			type = "text",
			name = L["Party Layout"],
			desc = L["Select which layout to use when in a party."],
			order = ORDER_LAYOUT + 2,
			get = function ()
					return GridLayout.db.profile.layouts.party
				end,
			set = function (v)
					GridLayout.db.profile.layouts.party = v
					GridLayout:ReloadLayout()
				end,
			validate = {},
		},
		["heroic_raidlayout"] = {
			type = "text",
			name = L["25 Player Raid Layout"],
			desc = L["Select which layout to use when in a 25 player raid."],
			order = ORDER_LAYOUT + 3,
			get = function ()
					return GridLayout.db.profile.layouts.heroic_raid
				end,
			set = function (v)
					GridLayout.db.profile.layouts.heroic_raid = v
					GridLayout:ReloadLayout()
				end,
			validate = {},
		},
		["raidlayout"] = {
			type = "text",
			name = L["10 Player Raid Layout"],
			desc = L["Select which layout to use when in a 10 player raid."],
			order = ORDER_LAYOUT + 3,
			get = function ()
					return GridLayout.db.profile.layouts.raid
				end,
			set = function (v)
					GridLayout.db.profile.layouts.raid = v
					GridLayout:ReloadLayout()
				end,
			validate = {},
		},
		["bglayout"] = {
			type = "text",
			name = L["Battleground Layout"],
			desc = L["Select which layout to use when in a battleground."],
			order = ORDER_LAYOUT + 4,
			get = function ()
					return GridLayout.db.profile.layouts.bg
				end,
			set = function (v)
					GridLayout.db.profile.layouts.bg = v
					GridLayout:ReloadLayout()
				end,
			validate = {},
		},
		["arenalayout"] = {
			type = "text",
			name = L["Arena Layout"],
			desc = L["Select which layout to use when in an arena."],
			order = ORDER_LAYOUT + 5,
			get = function ()
					return GridLayout.db.profile.layouts.arena
				end,
			set = function (v)
					GridLayout.db.profile.layouts.arena = v
					GridLayout:ReloadLayout()
				end,
			validate = {},
		},
		["horizontal"] = {
			type = "toggle",
			name = L["Horizontal groups"],
			desc = L["Switch between horzontal/vertical groups."],
			order = ORDER_LAYOUT + 6,
			get = function ()
					return GridLayout.db.profile.horizontal
				end,
			set = function (v)
					GridLayout.db.profile.horizontal = v
					GridLayout:ReloadLayout()
				end,
		},
		["clamp"] = {
			type = "toggle",
			name = L["Clamped to screen"],
			desc = L["Toggle whether to permit movement out of screen."],
			order = ORDER_LAYOUT + 7,
			get = function ()
					return GridLayout.db.profile.clamp
				end,
			set = function (v)
					GridLayout.db.profile.clamp = v
					GridLayout:SetClamp()
				end,
		},
		["lock"] = {
			type = "toggle",
			name = L["Frame lock"],
			desc = L["Locks/unlocks the grid for movement."],
			order = ORDER_LAYOUT + 8,
			get = function() return GridLayout.db.profile.FrameLock end,
			set = function(v)
					GridLayout.db.profile.FrameLock = v
					GridLayout:UpdateTabVisibility()
				end,
		},

		["DisplayHeader"] = {
			type = "header",
			order = ORDER_DISPLAY,
		},
		["padding"] = {
			type = "range",
			name = L["Padding"],
			desc = L["Adjust frame padding."],
			order = ORDER_DISPLAY + 1,
			max = 20,
			min = 0,
			step = 1,
			get = function ()
					return GridLayout.db.profile.Padding
				end,
			set = function (v)
					GridLayout.db.profile.Padding = v
					GridLayout:ReloadLayout()
				end,
		},
		["spacing"] = {
			type = "range",
			name = L["Spacing"],
			desc = L["Adjust frame spacing."],
			order = ORDER_DISPLAY + 2,
			max = 25,
			min = 0,
			step = 1,
			get = function ()
					return GridLayout.db.profile.Spacing
				end,
			set = function (v)
					GridLayout.db.profile.Spacing = v
					GridLayout:ReloadLayout()
				end,
		},
		["scale"] = {
			type = "range",
			name = L["Scale"],
			desc = L["Adjust Grid scale."],
			order = ORDER_DISPLAY + 3,
			min = 0.5,
			max = 2.0,
			step = 0.05,
			isPercent = true,
			get = function ()
					return GridLayout.db.profile.ScaleSize
				end,
			set = function (v)
					GridLayout.db.profile.ScaleSize = v
					GridLayout:Scale()
				end,
		},
		["border"] = {
			type = "color",
			name = L["Border"],
			desc = L["Adjust border color and alpha."],
			order = ORDER_DISPLAY + 4,
			get = function ()
					local settings = GridLayout.db.profile
					return settings.BorderR, settings.BorderG, settings.BorderB, settings.BorderA
				end,
			set = function (r, g, b, a)
					local settings = GridLayout.db.profile
					settings.BorderR, settings.BorderG, settings.BorderB, settings.BorderA = r, g, b, a
					GridLayout:UpdateColor()
				end,
			hasAlpha = true
		},
		["background"] = {
			type = "color",
			name = L["Background"],
			desc = L["Adjust background color and alpha."],
			order = ORDER_DISPLAY + 5,
			get = function ()
					local settings = GridLayout.db.profile
					return settings.BackgroundR, settings.BackgroundG, settings.BackgroundB, settings.BackgroundA
				end,
			set = function (r, g, b, a)
					local settings = GridLayout.db.profile
					settings.BackgroundR, settings.BackgroundG, settings.BackgroundB, settings.BackgroundA = r, g, b, a
					GridLayout:UpdateColor()
				end,
			hasAlpha = true
		},
		["advanced"] = {
			type = "group",
			name = L["Advanced"],
			desc = L["Advanced options."],
			order = -1,
			args = {
				["hidetab"] = {
					type = "toggle",
					name = L["Hide tab"],
					desc = L["Do not show the tab when Grid is unlocked."],
					get = function () return GridLayout.db.profile.hideTab end,
					set = function (v)
							GridLayout.db.profile.hideTab = v
							GridLayout:UpdateTabVisibility()
						end,
				},
				["layoutanchor"] = {
					type = "text",
					name = L["Layout Anchor"],
					desc = L["Sets where Grid is anchored relative to the screen."],
					order = 1,
					get = function () return GridLayout.db.profile.anchor end,
					set = function (v)
							GridLayout.db.profile.anchor = v
							GridLayout:SavePosition()
							GridLayout:RestorePosition()
						end,
					validate={["CENTER"] = L["Center"], ["TOP"] = L["Top"], ["BOTTOM"] = L["Bottom"], ["LEFT"] = L["Left"], ["RIGHT"] = L["Right"], ["TOPLEFT"] = L["Top Left"], ["TOPRIGHT"] = L["Top Right"], ["BOTTOMLEFT"] = L["Bottom Left"], ["BOTTOMRIGHT"] = L["Bottom Right"] },
				},
				["groupanchor"] = {
					type = "text",
					name = L["Group Anchor"],
					desc = L["Sets where groups are anchored relative to the layout frame."],
					order = 2,
					get = function () return GridLayout.db.profile.groupAnchor end,
					set = function (v)
							GridLayout.db.profile.groupAnchor = v
							GridLayout:ReloadLayout()
						end,
					validate={["TOPLEFT"] = L["Top Left"], ["TOPRIGHT"] = L["Top Right"], ["BOTTOMLEFT"] = L["Bottom Left"], ["BOTTOMRIGHT"] = L["Bottom Right"] },
				},
				["reset"] = {
					type = "execute",
					name = L["Reset Position"],
					desc = L["Resets the layout frame's position and anchor."],
					order = -1,
					func = function () GridLayout:ResetPosition() end,
				},
			},
		},
	},
}

local media_borders
if media then
	media_borders = media:List(media.MediaType.BORDER)
	local border_options = {
		type = "text",
		name = L["Border Texture"],
		desc = L["Choose the layout border texture."],
		validate = media_borders,
		get = function ()
				return GridLayout.db.profile.borderTexture
			end,
		set = function (v)
				GridLayout.db.profile.borderTexture = v
				GridLayout:UpdateColor()
			end,
	}

	GridLayout.options.args.advanced.args["border"] = border_options
end

--}}}
--}}}

GridLayout.layoutSettings = {}
GridLayout.layoutHeaderClass = GridLayoutHeaderClass

function GridLayout:OnInitialize()
	self.super.OnInitialize(self)
	self.layoutGroups = {}
	self.layoutPetGroups = {}
end

function GridLayout:OnEnable()
	self:Debug("OnEnable")
	if not self.frame then
		self:CreateFrames()
	end

	self:UpdateTabVisibility()

	self.forceRaid = true
	self:ScheduleEvent(self.CombatFix, 1, self)

	self:LoadLayout(self.db.profile.layout or self.db.profile.layouts["heroic_raid"])
	-- position and scale frame
	self:RestorePosition()
	self:Scale()

	self:RegisterEvent("Grid_ReloadLayout", "PartyTypeChanged")
	self:RegisterEvent("Grid_PartyTransition", "PartyTypeChanged")

	self:RegisterBucketEvent("Grid_UpdateLayoutSize", 0.2, "PartyMembersChanged")
	self:RegisterEvent("Grid_RosterUpdated", "PartyMembersChanged")

	self:RegisterEvent("Grid_EnteringCombat", "EnteringOrLeavingCombat")
	self:RegisterEvent("Grid_LeavingCombat", "EnteringOrLeavingCombat")

	self.super.OnEnable(self)
end

function GridLayout:OnDisable()
	self.frame:Hide()
	self.super.OnDisable(self)
end

function GridLayout:Reset()
	self.super.Reset(self)

	self:ReloadLayout()
	-- position and scale frame
	self:RestorePosition()
	self:Scale()
	self:UpdateTabVisibility()
end

--{{{ Event handlers

local reloadLayoutQueued
local updateSizeQueued
function GridLayout:EnteringOrLeavingCombat()
	if reloadLayoutQueued then return self:PartyTypeChanged() end
	if updateSizeQueued then return self:PartyMembersChanged() end
end

function GridLayout:CombatFix()
	self:Debug("CombatFix")
	self.forceRaid = false
	return self:ReloadLayout()
end

function GridLayout:PartyMembersChanged()
	self:Debug("PartyMembersChanged")
	if InCombatLockdown() then
		updateSizeQueued = true
	else
		self:UpdateSize()
		updateSizeQueued = false
	end
end

function GridLayout:PartyTypeChanged()
	self:Debug("PartyTypeChanged")

	if InCombatLockdown() then
		reloadLayoutQueued = true
	else
		self:ReloadLayout()
		reloadLayoutQueued = false
		updateSizeQueued = false
	end
end

--}}}

function GridLayout:StartMoveFrame()
	if config_mode or not self.db.profile.FrameLock then
		self.frame:StartMoving()
		self.frame.isMoving = true
	end
end

function GridLayout:StopMoveFrame()
	if self.frame.isMoving then
		self.frame:StopMovingOrSizing()
		self:SavePosition()
		self.frame.isMoving = false
		if not InCombatLockdown() then
			self:RestorePosition()
		end
	end
end

function GridLayout:UpdateTabVisibility()
	local settings = self.db.profile

	if not InCombatLockdown() then
		if not settings.hideTab or (not config_mode and settings.FrameLock) then
			self.frame:EnableMouse(false)
		else
			self.frame:EnableMouse(true)
		end
	end

	if settings.hideTab or (not config_mode and settings.FrameLock) then
		self.frame.tab:Hide()
	else
		self.frame.tab:Show()
	end
end

local function GridLayout_OnMouseDown(frame, button)
	if button == "LeftButton" and IsAltKeyDown() then
		GridLayout.db.profile.hideTab = true
		GridLayout:UpdateTabVisibility()
	end
	if button == "LeftButton" and not IsModifierKeyDown() then
		GridLayout:StartMoveFrame()
	end
end

local function GridLayout_OnMouseUp(frame)
	GridLayout:StopMoveFrame()
end

local function GridLayout_OnEnter(frame)
	local tip = GameTooltip
	tip:SetOwner(frame, "ANCHOR_LEFT")
	tip:SetText(L["Drag this tab to move Grid."])
	tip:AddLine(L["Lock Grid to hide this tab."])
	tip:AddLine(L["Alt-Click to permanantly hide this tab."])
	tip:Show()
end

local function GridLayout_OnLeave(frame)
	local tip = GameTooltip
	tip:Hide()
end

function GridLayout:CreateFrames()
	-- create main frame to hold all our gui elements
	local f = CreateFrame("Frame", "GridLayoutFrame", UIParent)
	f:SetMovable(true)
	f:SetClampedToScreen(self.db.profile.clamp)
	f:SetPoint("CENTER", UIParent, "CENTER")
	f:SetScript("OnMouseDown", GridLayout_OnMouseDown)
	f:SetScript("OnMouseUp", GridLayout_OnMouseUp)
	f:SetScript("OnHide", GridLayout_OnMouseUp)
	f:SetFrameStrata("MEDIUM")

	-- create background
	f:SetFrameLevel(0)
	f:SetBackdrop({
				bgFile = "Interface\\ChatFrame\\ChatFrameBackground", tile = true, tileSize = 16,
				edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16,
				insets = {left = 4, right = 4, top = 4, bottom = 4},
			})

	-- create bg texture
	f.texture = f:CreateTexture(nil, "BORDER")
	f.texture:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	f.texture:SetPoint("TOPLEFT", f, "TOPLEFT", 4, -4)
	f.texture:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -4, 4)
	f.texture:SetBlendMode("ADD")
	f.texture:SetGradientAlpha("VERTICAL", .1, .1, .1, 0, .2, .2, .2, 0.5)

	local tab_width = 33
	local tab_side_width = 16
	local tab_middle_width = tab_width - tab_side_width * 2
	local tab_height = 18
	local tab_alpha = 0.9

	-- create drag handle
	f.tab = CreateFrame("Frame", "GridLayoutFrameTab", f)
	f.tab:SetWidth(tab_width)
	f.tab:SetHeight(tab_height)
	f.tab:EnableMouse(true)
	f.tab:RegisterForDrag("LeftButton")
	f.tab:SetPoint("BOTTOMLEFT", f, "TOPLEFT", 1, -4)
	f.tab:SetScript("OnMouseDown", GridLayout_OnMouseDown)
	f.tab:SetScript("OnMouseUp", GridLayout_OnMouseUp)
	f.tab:SetScript("OnEnter", GridLayout_OnEnter)
	f.tab:SetScript("OnLeave", GridLayout_OnLeave)
	f.tab:Hide()

	-- Handle/Tab Background
	f.tabBgLeft = f.tab:CreateTexture("GridLayoutFrameTabBgLeft",
									"BACKGROUND")
	f.tabBgLeft:SetTexture("Interface\\ChatFrame\\ChatFrameTab")
	f.tabBgLeft:SetTexCoord(0, 0.25, 0, 1)
	f.tabBgLeft:SetAlpha(tab_alpha)
	f.tabBgLeft:SetWidth(tab_side_width)
	f.tabBgLeft:SetHeight(tab_height + 5)
	f.tabBgLeft:SetPoint("BOTTOMLEFT", f.tab, "BOTTOMLEFT", 0, 0)

	f.tabBgMiddle = f.tab:CreateTexture("GridLayoutFrameTabBgMiddle",
										"BACKGROUND")
	f.tabBgMiddle:SetTexture("Interface\\ChatFrame\\ChatFrameTab")
	f.tabBgMiddle:SetTexCoord(0.25, 0.75, 0, 1)
	f.tabBgMiddle:SetAlpha(tab_alpha)
	f.tabBgMiddle:SetWidth(tab_middle_width)
	f.tabBgMiddle:SetHeight(tab_height + 5)
	f.tabBgMiddle:SetPoint("LEFT", f.tabBgLeft, "RIGHT", 0, 0)

	f.tabBgRight = f.tab:CreateTexture("GridLayoutFrameTabBgRight",
									"BACKGROUND")
	f.tabBgRight:SetTexture("Interface\\ChatFrame\\ChatFrameTab")
	f.tabBgRight:SetTexCoord(0.75, 1, 0, 1)
	f.tabBgRight:SetAlpha(tab_alpha)
	f.tabBgRight:SetWidth(tab_side_width)
	f.tabBgRight:SetHeight(tab_height + 5)
	f.tabBgRight:SetPoint("LEFT", f.tabBgMiddle, "RIGHT", 0, 0)

	-- Tab Label
	f.tabText = f.tab:CreateFontString("GridLayoutFrameTabText",
									"BACKGROUND", "GameFontNormalSmall")
	f.tabText:SetText("Grid")
	f.tabText:SetPoint("TOP", f.tab, "TOP", 0, -5)

	self.frame = f
end

local function getRelativePoint(point, horizontal)
	if point == "TOPLEFT" then
		if horizontal then
			return "BOTTOMLEFT", 1, -1
		else
			return "TOPRIGHT", 1, -1
		end
	elseif point == "TOPRIGHT" then
		if horizontal then
			return "BOTTOMRIGHT", -1, -1
		else
			return "TOPLEFT", -1, -1
		end
	elseif point == "BOTTOMLEFT" then
		if horizontal then
			return  "TOPLEFT", 1, 1
		else
			return "BOTTOMRIGHT", 1, 1
		end
	elseif point == "BOTTOMRIGHT" then
		if horizontal then
			return "TOPRIGHT", -1, 1
		else
			return "BOTTOMLEFT", -1, 1
		end
	end
end

local previousGroup
function GridLayout:PlaceGroup(layoutGroup, groupNumber)
	local frame = layoutGroup.frame

	local settings = self.db.profile
	local horizontal = settings.horizontal
	local padding = settings.Padding
	local spacing = settings.Spacing
	local groupAnchor = settings.groupAnchor

	local relPoint, xMult, yMult = getRelativePoint(groupAnchor, horizontal)

	if groupNumber == 1 then
		frame:ClearAllPoints()
		frame:SetParent(self.frame)
		frame:SetPoint(groupAnchor, self.frame, groupAnchor, spacing * xMult, spacing * yMult)
	else
		if horizontal then
			xMult = 0
		else
			yMult = 0
		end

		frame:ClearAllPoints()
		frame:SetPoint(groupAnchor, previousGroup.frame, relPoint, padding * xMult, padding * yMult)
	end

	self:Debug("Placing group", groupNumber, layoutGroup.frame:GetName(), groupAnchor, previousGroup and previousGroup.frame:GetName(), relPoint)

	previousGroup = layoutGroup
end

function GridLayout:AddLayout(layoutName, layout)
	self.layoutSettings[layoutName] = layout
	for _, party_type in ipairs(GridRoster.party_states) do
		local options = self.options.args[party_type .. "layout"]
		--if options then
		table.insert(self.options.args[party_type .. "layout"].validate, layoutName)
		--end
	end
end

function GridLayout:SetClamp()
	self.frame:SetClampedToScreen(self.db.profile.clamp)
end

function GridLayout:ReloadLayout()
	local party_type = GridRoster:GetPartyState()
	self:LoadLayout(self.db.profile.layouts[party_type])
end

local function getColumnAnchorPoint(point, horizontal)
	if not horizontal then
		if point == "TOPLEFT" or point == "BOTTOMLEFT" then
			return "LEFT"
		elseif point == "TOPRIGHT" or point == "BOTTOMRIGHT" then
			return "RIGHT"
		end
	else
		if point == "TOPLEFT" or point == "TOPRIGHT" then
			return "TOP"
		elseif point == "BOTTOMLEFT" or point == "BOTTOMRIGHT" then
			return "BOTTOM"
		end
	end
	return point
end

function GridLayout:LoadLayout(layoutName)
	self.db.profile.layout = layoutName
	if InCombatLockdown() then
		reloadLayoutQueued = true
		return
	end
	local p = self.db.profile
	local horizontal = p.horizontal
	local layout = self.layoutSettings[layoutName]

	self:Debug("LoadLayout", layoutName)

	-- layout not ready yet
	if type(layout) ~= "table" or not next(layout) then
		self:Debug("No groups found in layout")
		self:UpdateDisplay()
		return
	end

	local groupsNeeded, groupsAvailable, petGroupsNeeded, petGroupsAvailable =
		0, #self.layoutGroups, 0, #self.layoutPetGroups

	for _, l in ipairs(layout) do
		if l.isPetGroup then
			petGroupsNeeded = petGroupsNeeded + 1
		else
			groupsNeeded = groupsNeeded + 1
		end
	end

	-- create groups as needed
	while groupsNeeded > groupsAvailable do
		table.insert(self.layoutGroups, self.layoutHeaderClass:new(false))
		groupsAvailable = groupsAvailable + 1
	end
	while petGroupsNeeded > petGroupsAvailable do
		table.insert(self.layoutPetGroups, self.layoutHeaderClass:new(true))
		petGroupsAvailable = petGroupsAvailable + 1
	end

	-- hide unused groups
	for i = groupsNeeded + 1, groupsAvailable, 1 do
		self.layoutGroups[i]:Reset()
	end
	for i = petGroupsNeeded + 1, petGroupsAvailable, 1 do
		self.layoutPetGroups[i]:Reset()
	end

	local defaults = layout.defaults
	local iGroup, iPetGroup = 1, 1
	-- configure groups
	for i, l in ipairs(layout) do
		local layoutGroup
		if l.isPetGroup then
			layoutGroup = self.layoutPetGroups[iPetGroup]
			iPetGroup = iPetGroup + 1
		else
			layoutGroup = self.layoutGroups[iGroup]
			iGroup = iGroup + 1
		end

		layoutGroup:Reset()

		-- apply defaults
		if defaults then
			for attr, value in pairs(defaults) do
				if attr == "unitsPerColumn" then
					layoutGroup:SetFrameAttribute("unitsPerColumn", value)
					layoutGroup:SetFrameAttribute("columnSpacing", p.Padding)
					layoutGroup:SetFrameAttribute("columnAnchorPoint", getColumnAnchorPoint(p.groupAnchor, p.horizontal))
				else
					layoutGroup:SetFrameAttribute(attr, value)
				end
			end
		end

		-- apply settings
		for attr, value in pairs(l) do
			if attr == "unitsPerColumn" then
				layoutGroup:SetFrameAttribute("unitsPerColumn", value)
				layoutGroup:SetFrameAttribute("columnSpacing", p.Padding)
				layoutGroup:SetFrameAttribute("columnAnchorPoint",  getColumnAnchorPoint(p.groupAnchor, p.horizontal))
			elseif attr ~= "isPetGroup" then
				layoutGroup:SetFrameAttribute(attr, value)
			end
		end

		-- place groups
		layoutGroup:SetOrientation(horizontal)
		self:PlaceGroup(layoutGroup, i)
		layoutGroup.frame:Show()
	end

	self:UpdateDisplay()
end

function GridLayout:UpdateDisplay()
	self:UpdateColor()
	self:UpdateVisibility()
	self:UpdateSize()
end

function GridLayout:UpdateVisibility()
	local party_type = GridRoster:GetPartyState()
	if self.db.profile.layouts[party_type] == L["None"] then
		self.frame:Hide()
	else
		self.frame:Show()
	end
end

function GridLayout:UpdateSize()
	local p = self.db.profile
	local layoutGroup
	local groupCount, curWidth, curHeight, maxWidth, maxHeight
	local x, y

	groupCount, curWidth, curHeight, maxWidth, maxHeight = -1, 0, 0, 0, 0

	local Padding, Spacing = p.Padding, p.Spacing * 2

	for _, layoutGroup in ipairs(self.layoutGroups) do
		if layoutGroup:IsFrameVisible() then
			groupCount = groupCount + 1
			local width, height = layoutGroup:GetFrameWidth(), layoutGroup:GetFrameHeight()
			curWidth = curWidth + width + Padding
			curHeight = curHeight + height + Padding
			if maxWidth < width then maxWidth = width end
			if maxHeight < height then maxHeight = height end
		end
	end

	for _, layoutGroup in ipairs(self.layoutPetGroups) do
		if layoutGroup:IsFrameVisible() then
			groupCount = groupCount + 1
			local width, height = layoutGroup:GetFrameWidth(), layoutGroup:GetFrameHeight()
			curWidth = curWidth + width + Padding
			curHeight = curHeight + height + Padding
			if maxWidth < width then maxWidth = width end
			if maxHeight < height then maxHeight = height end
		end
	end

	if p.horizontal then
		x = maxWidth + Spacing
		y = curHeight + Spacing
	else
		x = curWidth + Spacing
		y = maxHeight + Spacing
	end

	self.frame:SetWidth(x)
	self.frame:SetHeight(y)
end

local function findVisibleUnitFrame(f)
	if f:IsVisible() and f:GetAttribute("unit") then
		return f
	end

	for i = 1, select('#', f:GetChildren()) do
		local child = select(i, f:GetChildren())
		local good = findVisibleUnitFrame(child)

		if good then
			return good
		end
	end
end

function GridLayout:FakeSize(width, height)
	local p = self.db.profile
	local f = findVisibleUnitFrame(self.frame)

	if not f then
		self:Debug("No suitable frame found.")
		return
	else
		self:Debug(("Using %s"):format(f:GetName()))
	end

	local frameWidth = f:GetWidth()
	local frameHeight = f:GetHeight()

	local x = frameWidth * width + (width - 1) * p.Padding + p.Spacing * 2
	local y = frameHeight * height + (height - 1) * p.Padding + p.Spacing * 2

	self.frame:SetWidth(x)
	self.frame:SetHeight(y)
end

function GridLayout:UpdateColor()
	local settings = self.db.profile

	if media then
		local texture = media:Fetch(media.MediaType.BORDER, settings.borderTexture)
		local backdrop = self.frame:GetBackdrop()
		backdrop.edgeFile = texture
		self.frame:SetBackdrop(backdrop)
	end

	self.frame:SetBackdropBorderColor(settings.BorderR, settings.BorderG, settings.BorderB, settings.BorderA)
	self.frame:SetBackdropColor(settings.BackgroundR, settings.BackgroundG, settings.BackgroundB, settings.BackgroundA)
	self.frame.texture:SetGradientAlpha("VERTICAL", .1, .1, .1, 0,
					.2, .2, .2, settings.BackgroundA/2 )
end


function GridLayout:SavePosition()
	local f = self.frame
	local s = f:GetEffectiveScale()
	local uiScale = UIParent:GetEffectiveScale()
	local anchor = self.db.profile.anchor

	local x, y, relativePoint

	relativePoint = anchor

	if f:GetLeft() == nil then
		self:Debug("WTF, GetLeft is nil")
		return
	end

	if anchor == "CENTER" then
		x = (f:GetLeft() + f:GetWidth() / 2) * s - UIParent:GetWidth() / 2 * uiScale
		y = (f:GetTop() - f:GetHeight() / 2) * s - UIParent:GetHeight() / 2 * uiScale
	elseif anchor == "TOP" then
		x = (f:GetLeft() + f:GetWidth() / 2) * s - UIParent:GetWidth() / 2 * uiScale
		y = f:GetTop() * s - UIParent:GetHeight() * uiScale
	elseif anchor == "LEFT" then
		x = f:GetLeft() * s
		y = (f:GetTop() - f:GetHeight() / 2) * s - UIParent:GetHeight() / 2 * uiScale
	elseif anchor == "RIGHT" then
		x = f:GetRight() * s - UIParent:GetWidth() * uiScale
		y = (f:GetTop() - f:GetHeight() / 2) * s - UIParent:GetHeight() / 2 * uiScale
	elseif anchor == "BOTTOM" then
		x = (f:GetLeft() + f:GetWidth() / 2) * s - UIParent:GetWidth() / 2 * uiScale
		y = f:GetBottom() * s
	elseif anchor == "TOPLEFT" then
		x = f:GetLeft() * s
		y = f:GetTop() * s - UIParent:GetHeight() * uiScale
	elseif anchor == "TOPRIGHT" then
		x = f:GetRight() * s - UIParent:GetWidth() * uiScale
		y = f:GetTop() * s - UIParent:GetHeight() * uiScale
	elseif anchor == "BOTTOMLEFT" then
		x = f:GetLeft() * s
		y = f:GetBottom() * s
	elseif anchor == "BOTTOMRIGHT" then
		x = f:GetRight() * s - UIParent:GetWidth() * uiScale
		y = f:GetBottom() * s
	end

	if x and y and s then
		self.db.profile.PosX = x
		self.db.profile.PosY = y
		--self.db.profile.anchor = point
		self.db.profile.anchorRel = relativePoint
		self:Debug("Saved Position", anchor, x, y)
	end
end

function GridLayout:ResetPosition()
	local uiScale = UIParent:GetEffectiveScale()

	self.db.profile.PosX = UIParent:GetWidth() / 2 * uiScale
	self.db.profile.PosY = - UIParent:GetHeight() / 2 * uiScale
	self.db.profile.anchor = "TOPLEFT"

	self:RestorePosition()
	self:SavePosition()
end

function GridLayout:RestorePosition()
	local f = self.frame
	local s = f:GetEffectiveScale()
	local x = self.db.profile.PosX
	local y = self.db.profile.PosY
	local point = self.db.profile.anchor

	x, y = x/s, y/s
	f:ClearAllPoints()
	f:SetPoint(point, UIParent, point, x, y)

	self:Debug("Restored Position", point, x, y)
end

function GridLayout:Scale()
	self:SavePosition()
	self.frame:SetScale(self.db.profile.ScaleSize)
	self:RestorePosition()
end

--}}}