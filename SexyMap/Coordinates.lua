local parent = SexyMap
local modName = "Coordinates"
local mod = SexyMap:NewModule(modName, "AceTimer-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("SexyMap")
local db

local options = {
	type = "group",
	name = L["Coordinates"],
	childGroups = "tab",
	disabled = function() return not db.enabled end,
	args = {
		enable = {
			type = "toggle",
			name = L["Enable Coordinates"],
			order = 1,
			get = function()
				return db.enabled
			end,
			set = function(info, v)
				db.enabled = v
				if v then
					parent:EnableModule(modName)
				else
					parent:DisableModule(modName)
				end
			end,
			disabled = false,
		},
		lock = {
			type = "toggle",
			name = L["Lock coordinates"],
			order = 2,
			get = function()
				return db.locked
			end,
			set = function(info, v)
				db.locked = v
			end,
			width = "full",
		},
		fontSize = {
			type = "range",
			name = L["Font size"],
			order = 3,
			min = 8,
			max = 30,
			step = 1,
			bigStep = 1,
			get = function()
				return db.fontSize or 12
			end,
			set = function(info, v)
				db.fontSize = v
				mod:Update()
				mod:UpdateCoords()
			end
		},
		fontColor = {
			type = "color",
			name = L["Font color"],
			order = 4,
			hasAlpha = true,
			get = function()
				local c = db.fontColor
				local r, g, b, a = c.r or 0, c.g or 0, c.b or 0, c.a or 1
				return r, g, b, a
			end,
			set = function(info, r, g, b, a)
				local c = db.fontColor
				c.r, c.g, c.b, c.a = r, g, b, a
				mod:Update()
			end
		},
		backgroundColor = {
			type = "color",
			name = L["Backdrop color"],
			order = 5,
			hasAlpha = true,
			get = function()
				local c = db.backgroundColor
				local r, g, b, a = c.r or 0, c.g or 0, c.b or 0, c.a or 1
				return r, g, b, a
			end,
			set = function(info, r, g, b, a)
				local c = db.backgroundColor
				c.r, c.g, c.b, c.a = r, g, b, a
				mod:Update()
			end		
		},
		borderColor = {
			type = "color",
			name = L["Border color"],
			order = 5,
			hasAlpha = true,
			get = function()
				local c = db.borderColor
				local r, g, b, a = c.r or 0, c.g or 0, c.b or 0, c.a or 1
				return r, g, b, a
			end,
			set = function(info, r, g, b, a)
				local c = db.borderColor
				c.r, c.g, c.b, c.a = r, g, b, a
				mod:Update()
			end		
		},
		reset = {
			type = "execute",
			name = L["Reset position"],
			order = 6,
			func = function()
				mod:ResetPosition()
			end,
		},
	}
}

local function start(self)
	if db.locked then return end
	self:StartMoving()
	self.moving = true
end

local function finish(self)
	if not self.moving then return end
	self.moving = nil
	self:StopMovingOrSizing()
	local x, y = self:GetCenter()
	local mx, my = Minimap:GetCenter()
	local dx, dy = mx - x, my - y
	self:ClearAllPoints()
	self:SetPoint("CENTER", Minimap, "CENTER", -dx, -dy)
	db.x = dx
	db.y = dy
end

local defaults = {
	profile = {
		borderColor = {},
		backgroundColor = {},
		locked = false,
		fontColor = {},
		enabled = false
	}
}
local coordFrame, xcoords, ycoords
function mod:OnInitialize()
	self.db = parent.db:RegisterNamespace(modName, defaults)
	db = self.db.profile
	
	coordFrame = CreateFrame("Frame", "SexyMapCoordFrame", Minimap)
	coordFrame:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		insets = {left = 2, top = 2, right = 2, bottom = 2},
		edgeSize = 12,
		tile = true
	})
	xcoords = coordFrame:CreateFontString(nil, nil, "GameFontNormalSmall")
	xcoords:SetPoint("TOPLEFT", coordFrame, "TOPLEFT", 5, 0)
	xcoords:SetPoint("BOTTOMRIGHT")
	xcoords:SetPoint("TOPRIGHT", coordFrame, "TOP")
	xcoords:SetJustifyH("LEFT")

	ycoords = coordFrame:CreateFontString(nil, nil, "GameFontNormalSmall")
	ycoords:SetPoint("TOPLEFT", xcoords, "TOPRIGHT", 4, 0)
	ycoords:SetPoint("BOTTOMLEFT", xcoords, "BOTTOMRIGHT")
	ycoords:SetPoint("TOPRIGHT", coordFrame, "TOPRIGHT", -3, 0)
	ycoords:SetPoint("BOTTOMRIGHT")
	ycoords:SetJustifyH("LEFT")
	
	coordFrame:SetMovable(true)
	coordFrame:EnableMouse()
	coordFrame.sexyMapIgnore = true

	coordFrame:SetScript("OnMouseDown", start)
	coordFrame:SetScript("OnMouseUp", finish)
	
	self:UpdateCoords()
	self:Update()
	parent:RegisterModuleOptions(modName, options, modName)
end

function mod:OnEnable()
	db = self.db.profile
	if not db.enabled then
		parent:DisableModule(modName)
		return
	end
	if db.x then
		coordFrame:ClearAllPoints()
		coordFrame:SetPoint("CENTER", Minimap, "CENTER", -db.x, -db.y)
	else
		coordFrame:SetPoint("CENTER", Minimap, "BOTTOM")
	end
	
	coordFrame:Show()
	self.updateTimer = self:ScheduleRepeatingTimer("UpdateCoords", 0.05)
	-- parent:GetModule("Buttons"):MakeMovable(coordFrame)
end

function mod:OnDisable()
	self:CancelTimer(self.updateTimer, true)
	coordFrame:Hide()
end

function mod:UpdateCoords()
	local x, y = GetPlayerMapPosition("player")
	xcoords:SetText(("%2.1f, "):format(x*100))
	ycoords:SetText(("%2.1f"):format(y*100))
	-- , %2.1f"):format(x*100,y*100))
end

function mod:Update()
	if db.borderColor then
		local c = db.borderColor
		coordFrame:SetBackdropBorderColor(c.r or 0, c.g or 0, c.b or 0, c.a or 1)
	end

	if db.backgroundColor then
		local c = db.backgroundColor
		coordFrame:SetBackdropColor(c.r or 0, c.g or 0, c.b or 0, c.a or 1)
	end

	if db.fontColor then
		local c = db.fontColor
		xcoords:SetTextColor(c.r or 1, c.g or 1, c.b or 1, c.a or 1)
		ycoords:SetTextColor(c.r or 1, c.g or 1, c.b or 1, c.a or 1)
	end
	
	if db.fontSize then
		local f, s, flags = xcoords:GetFont()
		xcoords:SetFont(f, db.fontSize, flags)
		ycoords:SetFont(f, db.fontSize, flags)
	end
	
	local pt = xcoords:GetText()
	xcoords:SetText(("%2.1f,  %2.1f"):format(22.222,22.222))
	coordFrame:SetWidth(xcoords:GetStringWidth() * 1.2)
	coordFrame:SetHeight(xcoords:GetStringHeight() + 10)
	xcoords:SetText(pt)
end

function mod:ResetPosition()
	coordFrame:ClearAllPoints()
	coordFrame:SetPoint("CENTER", Minimap, "BOTTOM")
	db.x, db.y = nil, nil
end
