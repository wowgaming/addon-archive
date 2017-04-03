local parent = SexyMap
local modName = "Buttons"
local mod = SexyMap:NewModule(modName, "AceTimer-3.0", "AceHook-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("SexyMap")
local Shape
local db

local buttons
local allChildren = {}
local ignoreButtons = {MinimapPing = true}

local function concatChildren(t, ...)
	for i = 1, select("#", ...) do
		local v = select(i, ...)
		if not ignoreButtons[v] then
			tinsert(t, v)
		end
	end
end

local lastChildCount = 0
local lastChild = nil
local function getChildren()
	local total = Minimap:GetNumChildren() + MinimapBackdrop:GetNumChildren() + MinimapCluster:GetNumChildren()
	if total == lastChildCount then return allChildren end
	lastChildCount = total
	wipe(allChildren)
	concatChildren(allChildren, Minimap:GetChildren())
	concatChildren(allChildren, MinimapBackdrop:GetChildren())
	concatChildren(allChildren, MinimapCluster:GetChildren())
	return allChildren
end

local captureNewChildren
do
	local childCount, lastChild, stockIndex
	-- Buttons to ignore if they show up in iteration. Usually due to manually parenting them to the minimap.
	local ignoreButtons = {
		MiniMapTrackingButton = true,
		MiniMapWorldMapButton = true,
		TimeManagerClockButton = true,
		MinimapZoomIn = true,
		MinimapZoomOut = true,
		MiniMapVoiceChatFrame = true,
	}	
	function captureNewChildren()
		local children = getChildren()
		if #children == childCount and lastChild == children[#children] then return 0 end
		childCount = #children
		lastChild = children[#children]
		
		local count = 0
		for i = (stockIndex or 1), #children do
			local child = children[i]
			local w, h = child.GetWidth and child:GetWidth() or 0, child.GetHeight and child:GetHeight() or 0
			local sizeOk = w > 25 and w < 100 and h > 25 and h < 100
			if sizeOk and stockIndex and not buttons[child:GetName()] and child.SetAlpha and not ignoreButtons[child:GetName()] and not child.sexyMapIgnore then
				buttons[child:GetName() or ("Button #" .. i)] = {child, custom = true}
				count = count + 1
			end
			if child == MiniMapVoiceChatFrame then
				stockIndex = i
			end
		end
		return count
	end
end

local options = {
	type = "group",
	name = modName,
	childGroups = "tab",
	args = {
		custom = {
			type = "group",
			name = L["Addon Buttons"],
			disabled = function()
				return not db.controlVisibility
			end,
			args = {},
			order = 2
		},
		stock = {
			type = "group",
			disabled = function()
				return not db.controlVisibility
			end,
			name = L["Standard Buttons"],
			args = {},
			order = 1
		},
		-- capture = {
			-- type = "execute",
			-- func = mod.CaptureButtons,
			-- name = L["Capture New Buttons"]
		-- },
		lockDragging = {
			type = "toggle",
			name = L["Lock Button Dragging"],
			width = "full",
			order = 101,
			disabled = function()
				return not db.allowDragging
			end,
			get = function()
				return db.lockDragging
			end,
			set = function(info, v)
				db.lockDragging = v
			end		
		},
		enableDragging = {
			type = "toggle",
			name = L["Let SexyMap handle button dragging"],
			desc = L["Allow SexyMap to assume drag ownership for buttons attached to the minimap. Turn this off if you have another mod that you want to use to position your minimap buttons."],
			width = "full",
			order = 102,
			get = function()
				return db.allowDragging
			end,
			set = function(info, v)
				db.allowDragging = v
				if v then
					mod:MakeMovables()
				else
					mod:ReleaseMovables()
				end
			end
		},
		controlVisibility = {
			type = "toggle",
			name = L["Let SexyMap control button visibility"],
			desc = L["Turn this off if you want another mod to handle which buttons are visible on the minimap."],
			width = "full",
			order = 103,
			get = function()
				return db.controlVisibility
			end,
			set = function(info, v)
				db.controlVisibility = v
				if not v then
					for k, v in pairs(buttons) do
						for _, f in ipairs(v) do
							parent:UnregisterHoverButton(f)
						end
					end
				else
					mod:Update()
				end
			end		
		},		
		dragRadius = {
			type = "range",
			name = L["Drag Radius"],
			min = -30,
			max = 100,
			step = 1,
			bigStep = 1,
			order = 104,
			disabled = function()
				return not db.allowDragging
			end,
			get = function()
				return db.radius
			end,
			set = function(info, v)
				db.radius = v
				parent:DisableFade(1.5)
				mod:UpdateDraggables()
			end
		}
	}
}

local defaults = {
	profile = {
		radius = 2,
		dragPositions = {},
		allowDragging = true,
		controlVisibility = true
	}
}

do
	local translations = {
		calendar 	= L["Calendar"],
		worldmap 	= L["Map Button"],
		tracking 	= L["Tracking Button"],
		zoom 		= L["Zoom Buttons"],
		mapclock 	= L["Clock"],
		close 		= L["Close button"],
		direction	= L["Compass labels"],
		mail		= L["New mail indicator"],
		voice		= L["Voice chat"],
		pvp			= L["Battlegrounds icon"],
		lfg			= L["Dungeon finder icon"],
		difficulty  = L["Dungeon difficulty"]
	}
	
	buttons = {
		calendar	= {"GameTimeFrame", override = function(f, e)
						return CalendarGetNumPendingInvites() > 0
					end, overrideEvents = { "CALENDAR_UPDATE_PENDING_INVITES", "PLAYER_ENTERING_WORLD" }},
		worldmap 	= {"MiniMapWorldMapButton"},
		tracking	= {"MiniMapTrackingButton"},
		zoom		= {"MinimapZoomIn", "MinimapZoomOut"},
		mapclock	= {"TimeManagerClockButton"},
		close	 	= {"MinimapToggleButton"},
		direction	= {"MinimapNorthTag"},
		mail		= {"MiniMapMailFrame", show = function(f)
						return HasNewMail()
					end},
		voice 		= {"MiniMapVoiceChatFrame", show = function(f)
						return IsVoiceChatEnabled() and GetNumVoiceSessions()
					end},
		pvp 		= {"MiniMapBattlefieldFrame", show = function(f)
						return not ( BattlefieldFrame.numQueues == 0 and (not CanHearthAndResurrectFromArea()) )
					end },
		lfg 		= { "MiniMapLFGFrame",
						show = function(f)
							return GetLFGMode()
						end,
						-- override = function(f, e)
							-- local mode = GetLFGMode()
							-- return mode == "queued" or mode == "listed" or mode == "rolecheck"
						-- end,
						-- overrideEvents = { "LFG_UPDATE" }
					  },
		difficulty  = { "MiniMapInstanceDifficulty",
						show = function(f)
							local _, instanceType, difficulty, _, maxPlayers, playerDifficulty, isDynamicInstance = GetInstanceInfo();
							return ( ( instanceType == "party" or instanceType == "raid" ) and not ( difficulty == 1 and maxPlayers == 5 ) )
						end
					  }
	}

	local hideValues = {
		["always"] = L["Always"],
		["never"] = L["Never"],
		["hover"] = L["On hover"]	
	}

	local function hideGet(info, v)		
		local key = info[#info]:gsub(" ", "_")
		return v == (db[key] and db[key].hide or "hover")
	end
	
	local function hideSet(info, v)
		local key = info[#info]:gsub(" ", "_")
		db[key] = db[key] or {}
		db[key].hide = v
		mod:Update()
	end

	function mod:addButtonOptions(k, v)
		local key = k:gsub(" ", "_")
		local p
		if v and v.custom then
			p = options.args.custom.args
		else
			p = options.args.stock.args
		end
		p[key] = p[key] or {
			type = "multiselect",
			name = ("Show %s..."):format(translations[k] or k),
			values = hideValues,
			get = hideGet,
			set = hideSet
		}
	end	
end

function mod:OnInitialize()
	self.db = parent.db:RegisterNamespace(modName, defaults)
	db = self.db.profile
	parent:RegisterModuleOptions(modName, options, modName)
	self:AddMouseWheelZoom()
end

function mod:OnEnable()
	Shape = parent:GetModule("Shapes")
	Shape.RegisterCallback(self, "SexyMap_ShapeChanged")
	
	db = self.db.profile
	local gotLast = false

	self.findClock = self:ScheduleRepeatingTimer("FindClock", 0.5)
	self:Update()

	-- MiniMapWorldMapButton:SetParent(Minimap)
	-- MinimapZoomIn:SetParent(Minimap)
	-- MinimapZoomOut:SetParent(Minimap)
	MiniMapInstanceDifficulty:EnableMouse(true)
	
	-- self:RegisterEvent("CALENDAR_UPDATE_EVENT_LIST_PENDING", "Update")
	-- self:RegisterEvent("UPDATE_PENDING_MAIL", "Update")

	self:FixTrackingAnchoring()
	
	-- Try to capture new buttons periodically
	self:ScheduleRepeatingTimer("MakeMovables", 1)
	self:MakeMovables()
	
	MiniMapInstanceDifficulty:SetFrameLevel(Minimap:GetFrameLevel() + 10)
	
	self:SecureHook("Minimap_OnClick", "ReleaseDrag")
end

function mod:OnDisable()
	self:CancelTimer(self.movableTimer, true)
end

function mod:SexyMap_ShapeChanged()
	parent:DisableFade(1)
	self:UpdateDraggables()
end

function mod:FixTrackingAnchoring()
	if ElkBuffBars and ElkBuffBars.db.profile.hidetrackingframe then
		parent:Print("|cffff0000!! Warning !!!|r Elkano's Buff Bars is set to hide the tracking button. This will hide your tracking texture. Run |cffffcc00/ebb config|r and uncheck |cffffcc00Hide minimap tracking frame|r to fix this.")
	end
	local x, y = MiniMapTracking:GetCenter()
	local mx, my = Minimap:GetCenter()
	local dx, dy = x - mx, y - my
	
	MiniMapTracking.Hide = function() end
	MiniMapTracking:Show()
	
	MiniMapTracking:SetParent(UIParent)
	MiniMapTrackingButton:SetParent(Minimap)
	MiniMapTrackingButton:ClearAllPoints()
	MiniMapTrackingButton:SetPoint("CENTER", Minimap, "CENTER", dx, dy)
	MiniMapTrackingButton:SetFrameStrata("LOW")
	MiniMapTracking:SetParent(MiniMapTrackingButton)
	MiniMapTracking:SetFrameStrata("BACKGROUND")
	MiniMapTracking:ClearAllPoints()
	MiniMapTracking:SetPoint("CENTER")
end

function mod:CaptureButtons()
	local count = captureNewChildren()
	if count > 0 then
		for k, v in pairs(buttons) do
			mod:addButtonOptions(k, v)
		end
		self:Update()
	end
end

function mod:FindClock()
	if _G.TimeManagerClockButton then
		self:CancelTimer(self.findClock, true)
		self.findClock = nil
	end
end

function mod:Update()
	if not db.controlVisibility then return end 
	for k, v in pairs(buttons) do
		local hide = db[k] and db[k].hide or "hover"
		if hide ~= "hover" then
			for _, f in ipairs(v) do
				parent:UnregisterHoverButton(f)
			end
		end
		if hide == "hover" then
			for _, f in ipairs(v) do
				if v.custom and f:IsVisible() or not v.custom then
					parent:RegisterHoverButton(f, v.show)
					if v.override then
						parent:RegisterHoverOverride(f, v.override, unpack(v.overrideEvents))
					end
				end
			end
		elseif hide == "never" then
			for _, f in ipairs(v) do
				f = type(f) == "string" and _G[f] or f
				if f.Hide then
					f:Hide()
				end
			end			
		else
			for _, f in ipairs(v) do
				f = type(f) == "string" and _G[f] or f
				if (v.custom and f:IsVisible() or not v.custom) and type(f) == "table" then
					if type(v.show) == "function" and v.show(f) or type(v.show) ~= "function" then
						if f.SetAlpha and f.Hide then
							f:SetAlpha(1)
							f:Show()
						end
					end
				end
			end
		end				
	end
end

do
	local function wheel(self, dir)
		if dir == -1 and Minimap:GetZoom() > 0 then
			Minimap_ZoomOutClick()
		elseif dir == 1 and Minimap:GetZoom() < Minimap:GetZoomLevels() then
			Minimap_ZoomInClick()
		end
	end
	
	function mod:AddMouseWheelZoom()
		Minimap:EnableMouseWheel()
		Minimap:SetScript("OnMouseWheel", wheel)
	end
end

do
	local moving
	local movables = {}
	local dragFrame = CreateFrame("Frame", nil, UIParent)
	
	local GetCursorPosition = _G.GetCursorPosition
	
	local function getCurrentAngle(f, bx, by)
		local mx, my = Minimap:GetCenter()
		if not mx or not my or not bx or not by then return 0 end
		local h, w = (by - my), (bx - mx)
		local angle = atan(h / w)
		if w < 0 then
			angle = angle + 180
		end
		return angle
	end	
	
	local function setPosition(frame, angle)
		if not angle then
			local x, y = GetCursorPosition()
			x, y = x / Minimap:GetEffectiveScale(), y / Minimap:GetEffectiveScale()
			angle = getCurrentAngle(frame, x, y)
			db.dragPositions[frame:GetName()] = angle
		end		
		
		local radius = (Minimap:GetWidth() / 2) + db.radius
		local bx, by = Shape:GetPosition(angle, radius)
		
		-- local bx = cos(angle) * radius
		-- local by = sin(angle) * radius
		
		frame:ClearAllPoints()
		frame:SetPoint("CENTER", Minimap, "CENTER", bx, by)
	end
	
	local function updatePosition()
		setPosition(moving)
	end
	
	local function start(frame)
		if db.lockDragging then return end
		
		dragFrame:SetScript("OnUpdate", updatePosition)
		parent:DisableFade()
		moving = frame
	end
	
	local function finish(frame)
		moving = nil
		parent:EnableFade()
		dragFrame:SetScript("OnUpdate", nil)
	end
	
	function mod:MakeMovable(frame)
		if not frame then return end
		if frame.sexyMapMovable then return end
		if movables[frame] then return end
		movables[frame] = true
		
		frame:RegisterForDrag("LeftButton")
		self:RawHookScript(frame, "OnDragStart", start)
		self:RawHookScript(frame, "OnDragStop", finish)
		frame.sexyMapMovable = true
	end
	
	function mod:UpdateDraggables()
		if not db.allowDragging then return end
		
		for f, v in pairs(movables) do			
			local x, y = f:GetCenter()
			local angle = db.dragPositions[f:GetName()] or getCurrentAngle(f, x, y)
			if angle then
				setPosition(f, angle)
			end
		end
	end
	
	local lastChildCount = 0
	function mod:MakeMovables()
		self:CaptureButtons()
		
		if not db.allowDragging then return end
		
		local children = getChildren()
		local childCount = #children
		if childCount == lastChildCount then return end
		lastChildCount = childCount
		for i = 1, childCount do
			local child = children[i]
			local w, h = child.GetWidth and child:GetWidth() or 0, child.GetHeight and child:GetHeight() or 0
			local sizeOk = w > 25 and w < 100 and h > 25 and h < 100
			if sizeOk and child:GetName() then
				self:MakeMovable(child)
			end
		end
		self:UpdateDraggables()
	end
	
	function mod:ReleaseMovables()
		for frame, on in pairs(movables) do
			self:UnhookAll(frame)
			frame.sexyMapMovable = nil
			movables[frame] = nil
		end
	end
	
	function mod:ReleaseDrag()
		if moving then
			finish(moving)
		end
	end
end
