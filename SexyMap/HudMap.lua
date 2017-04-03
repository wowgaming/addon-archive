local parent = SexyMap
local modName = "HudMap"
local mod = SexyMap:NewModule(modName, "AceTimer-3.0", "AceEvent-3.0", "AceHook-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("SexyMap")
local db

local updateFrame = CreateFrame("Frame")
local updateRotations

local onShow = function(self)
	self.rotSettings = GetCVar("rotateMinimap")
	SetCVar("rotateMinimap", "1")
	if db.useGatherMate and GatherMate then
		GatherMate:GetModule("Display"):ReparentMinimapPins(HudMapCluster)
		GatherMate:GetModule("Display"):ChangedVars(nil, "ROTATE_MINIMAP", "1")
	end
	
	if db.useQuestHelper and QuestHelper and QuestHelper.SetMinimapObject then
		QuestHelper:SetMinimapObject(HudMapCluster)
	end
	
	if db.useRoutes and Routes and Routes.ReparentMinimap then
		Routes:ReparentMinimap(HudMapCluster)
		Routes:CVAR_UPDATE(nil, "ROTATE_MINIMAP", "1")
	end
	
	if TomTom and TomTom.ReparentMinimap then
		TomTom:ReparentMinimap(HudMapCluster)
		local Astrolabe = DongleStub("Astrolabe-0.4")
		Astrolabe.processingFrame:SetParent(HudMapCluster)
	end
	
	if _G.GetMinimapShape and not mod:IsHooked("GetMinimapShape") then
		mod:Hook("GetMinimapShape")
	end
	
	updateFrame:SetScript("OnUpdate", updateRotations)
	MinimapCluster:Hide()
end

local onHide = function(self, force)
	SetCVar("rotateMinimap", self.rotSettings)
	if (db.useGatherMate or force) and GatherMate then
		GatherMate:GetModule("Display"):ReparentMinimapPins(Minimap)
		GatherMate:GetModule("Display"):ChangedVars(nil, "ROTATE_MINIMAP", self.rotSettings)
	end
	
	if db.useQuestHelper and QuestHelper and QuestHelper.SetMinimapObject then
		QuestHelper:SetMinimapObject(Minimap)
	end
	
	if (db.useRoutes or force) and Routes and Routes.ReparentMinimap then
		Routes:ReparentMinimap(Minimap)
		Routes:CVAR_UPDATE(nil, "ROTATE_MINIMAP", self.rotSettings)
	end
	
	if TomTom and TomTom.ReparentMinimap then
		TomTom:ReparentMinimap(Minimap)
		local Astrolabe = DongleStub("Astrolabe-0.4")
		Astrolabe.processingFrame:SetParent(Minimap)		
	end
	
	if _G.GetMinimapShape and mod:IsHooked("GetMinimapShape") then
		mod:Unhook("GetMinimapShape")
	end
	
	updateFrame:SetScript("OnUpdate", nil)
	MinimapCluster:Show()
end

local options = {
	type = "group",
	name = modName,
	args = {
		desc = {
			type = "description",
			order = 0,
			name = L["Enable a HUD minimap. This is very useful for gathering resources, but for technical reasons, the HUD map and the normal minimap can't be shown at the same time. Showing the HUD map will turn off the normal minimap."]
		},
		enable = {
			type = "toggle",
			name = L["Enable Hudmap"],
			order = 1,
			get = function()
				return HudMapCluster:IsVisible()
			end,
			set = function(info, v)
				mod:Toggle(v)
			end,
		},
		binding = {
			type = "keybinding",
			name = L["Keybinding"],
			order = 2,
			get = function()
				return GetBindingKey("TOGGLESEXYMAPGATHERMAP")
			end,
			set = function(info, v)
				SetBinding(v, "TOGGLESEXYMAPGATHERMAP")
				SaveBindings(GetCurrentBindingSet())
			end
		},
		color = {
			type = "color",
			hasAlpha = true,
			order = 3,
			name = L["HUD Color"],
			get = function()
				local c = db.hudColor
				return c.r or 0, c.g or 1, c.b or 0, c.a or 1
			end,
			set = function(info, r, g, b, a)
				local c = db.hudColor
				c.r, c.g, c.b, c.a = r, g, b, a
				mod:UpdateColors()
			end
		},
		textcolor = {
			type = "color",
			hasAlpha = true,
			name = L["Text Color"],
			order = 4,
			get = function()
				local c = db.textColor
				return c.r or 0, c.g or 1, c.b or 0, c.a or 1
			end,
			set = function(info, r, g, b, a)
				local c = db.textColor
				c.r, c.g, c.b, c.a = r, g, b, a
				mod:UpdateColors()
			end
		},		
		scale = {
			type = "range",
			name = L["Scale"],
			order = 5,
			min = 1.0,
			max = 3.0,
			step = 0.1,
			bigStep = 0.1,
			get = function()
				return db.scale
			end,
			set = function(info, v)
				db.scale = v
				mod:SetScales()
			end
		},
		alpha = {
			type = "range",
			name = L["Opacity"],
			order = 6,
			min = 0,
			max = 1,
			step = 0.01,
			bigStep = 0.01,
			get = function()
				return db.alpha
			end,
			set = function(info, v)
				db.alpha = v
				HudMapCluster:SetAlpha(v)
			end
		},
		gathermatedesc = {
			type = "description",
			name = L["GatherMate is a resource gathering helper mod. Installing it allows you to have resource pins on your HudMap."],
			order = 104
		},
		gathermate = {
			type = "toggle",
			order = 105,
			name = L["Use GatherMate pins"],
			disabled = function()
				return GatherMate == nil
			end,
			get = function()
				return db.useGatherMate
			end,
			set = function(info, v)
				db.useGatherMate = v
				if HudMapCluster:IsVisible() then
					onHide(HudMapCluster, true)
					onShow(HudMapCluster)
				end
			end
		},
		questhelper = {
			type = "toggle",
			order = 106,
			name = L["Use QuestHelper pins"],
			disabled = function()
				return QuestHelper == nil or QuestHelper.SetMinimapObject == nil
			end,
			get = function()
				return db.useQuestHelper
			end,
			set = function(info, v)
				db.useQuestHelper = v
				if HudMapCluster:IsVisible() then
					onHide(HudMapCluster, true)
					onShow(HudMapCluster)
				end
			end			
		},
		routesdesc = {
			type = "description",
			name = L["Routes plots the shortest distance between resource nodes. Install it to show farming routes on your HudMap."],
			order = 109,
		},		
		routes = {
			type = "toggle",
			name = L["Use Routes"],
			order = 110,
			disabled = function()
				return Routes == nil or Routes.ReparentMinimap == nil
			end,
			get = function()
				return db.useRoutes
			end,
			set = function(info, v)
				db.useRoutes = v
				if HudMapCluster:IsVisible() then
					onHide(HudMapCluster, true)
					onShow(HudMapCluster)
				end
			end
		},
	}
}

local directions = {}
local playerDot

local defaults = {
	profile = {
		useGatherMate = true,
		useQuestHelper = true,
		useRoutes = true,
		hudColor = {},
		textColor = {r = 0.5, g = 1, b = 0.5, a = 1},
		scale = 8,
		alpha = 0.7
	}
}

local coloredTextures = {}
local gatherCircle, gatherLine
local indicators = {"N", "NE", "E", "SE", "S", "SW", "W", "NW"}

function mod:OnInitialize()
	self.db = parent.db:RegisterNamespace(modName, defaults)
	db = self.db.profile
	
	-- Upgrade thingie for 3.1
	if not db.setNewScale then
		db.scale = 1.4
		db.setNewScale = true
	end
	
	SexyMapHudMap:SetPoint("CENTER", UIParent, "CENTER")
	HudMapCluster:SetFrameStrata("BACKGROUND")
	HudMapCluster:SetAlpha(db.alpha)
	SexyMapHudMap:SetAlpha(0)
	SexyMapHudMap:EnableMouse(false)
	
	setmetatable(HudMapCluster, { __index = SexyMapHudMap })
	
	gatherCircle = HudMapCluster:CreateTexture()
	gatherCircle:SetTexture([[SPELLS\CIRCLE.BLP]])
	gatherCircle:SetBlendMode("ADD")
	gatherCircle:SetPoint("CENTER")
	local radius = SexyMapHudMap:GetWidth() * 0.45
	gatherCircle:SetWidth(radius)
	gatherCircle:SetHeight(radius)
	gatherCircle.alphaFactor = 0.5
	tinsert(coloredTextures, gatherCircle)
	
	gatherLine = HudMapCluster:CreateTexture("GatherLine")
	gatherLine:SetTexture([[Interface\BUTTONS\WHITE8X8.BLP]])
	gatherLine:SetBlendMode("ADD")
	local nudge = 0.65
	gatherLine:SetPoint("BOTTOM", HudMapCluster, "CENTER", 0, nudge)
	gatherLine:SetWidth(0.2)
	gatherLine:SetHeight((SexyMapHudMap:GetWidth() * 0.214) - nudge)
	tinsert(coloredTextures, gatherLine)
	
	playerDot = HudMapCluster:CreateTexture()
	playerDot:SetTexture([[Interface\GLUES\MODELS\UI_Tauren\gradientCircle.blp]])
	playerDot:SetBlendMode("ADD")
	playerDot:SetPoint("CENTER")
	playerDot.alphaFactor = 2
	tinsert(coloredTextures, playerDot)
	
	local indicators = {"N", "NE", "E", "SE", "S", "SW", "W", "NW"}
	local radius = SexyMapHudMap:GetWidth() * 0.214
	for k, v in ipairs(indicators) do
		local rot = (0.785398163 * (k-1))
		local ind = HudMapCluster:CreateFontString(nil, nil, "GameFontNormalSmall")
		local x, y = math.sin(rot), math.cos(rot)
		ind:SetPoint("CENTER", HudMapCluster, "CENTER", x * radius, y * radius)
		ind:SetText(v)
		ind:SetShadowOffset(0.2,-0.2)
		ind.rad = rot
		ind.radius = radius
		tinsert(directions, ind)
	end	

	HudMapCluster:Hide()	
	HudMapCluster:SetScript("OnShow", onShow)
	HudMapCluster:SetScript("OnHide", onHide)	
	self:HookScript(Minimap, "OnShow", "Minimap_OnShow")
	self:HookScript(MinimapCluster, "OnShow", "Minimap_OnShow")
	
	parent:RegisterModuleOptions(modName, options, modName)
	self:UpdateColors()
	self:SetScales()
	
	HudMapCluster._GetScale = HudMapCluster.GetScale
	HudMapCluster.GetScale = function()
		return 1
	end
end

do
	local target = 1 / 90
	local total = 0
	
	function updateRotations(self, t)
		total = total + t
		if total < target then return end
		while total > target do total = total - target end
		local bearing = GetPlayerFacing()
		for k, v in ipairs(directions) do
			local x, y = math.sin(v.rad + bearing), math.cos(v.rad + bearing)
			v:ClearAllPoints()
			v:SetPoint("CENTER", HudMapCluster, "CENTER", x * v.radius, y * v.radius)
		end
	end
end

function mod:OnEnable()
	db = self.db.profile
	self:RegisterEvent("PLAYER_LOGOUT")
end

function mod:Minimap_OnShow()
	if HudMapCluster:IsVisible() then
		HudMapCluster:Hide()
	end
end

function mod:PLAYER_LOGOUT()
	self:Toggle(false)
end

function mod:Toggle(flag)
	if flag == nil then
		if HudMapCluster:IsVisible() then
			HudMapCluster:Hide()
		else
			HudMapCluster:Show()
			mod:SetScales()
		end
	else
		if flag then
			HudMapCluster:Show()
			mod:SetScales()
		else
			HudMapCluster:Hide()
		end
	end
end

function mod:UpdateColors()
	local c = db.hudColor
	for k, v in ipairs(coloredTextures) do
		v:SetVertexColor(c.r or 0, c.g or 1, c.b or 0, (c.a or 1) * (v.alphaFactor or 1) / HudMapCluster:GetAlpha())
	end
	
	c = db.textColor
	for k, v in ipairs(directions) do
		v:SetTextColor(c.r, c.g, c.b, c.a)
	end
end

function mod:GetMinimapShape()
	return "ROUND"
end

function mod:SetScales()
	SexyMapHudMap:ClearAllPoints()
	SexyMapHudMap:SetPoint("CENTER", UIParent, "CENTER")
	
	HudMapCluster:ClearAllPoints()
	HudMapCluster:SetPoint("CENTER")
	
	local size = UIParent:GetHeight() / db.scale
	SexyMapHudMap:SetWidth(size)
	SexyMapHudMap:SetHeight(size)
	HudMapCluster:SetHeight(size)
	HudMapCluster:SetWidth(size)
	gatherCircle:SetWidth(size * 0.45)
	gatherCircle:SetHeight(size * 0.45)
	gatherLine:SetHeight((SexyMapHudMap:GetWidth() * 0.214) - 0.65)
	
	HudMapCluster:SetScale(db.scale)
	playerDot:SetWidth(15)
	playerDot:SetHeight(15)
	
	for k, v in ipairs(directions) do
		v.radius = SexyMapHudMap:GetWidth() * 0.214
	end
end
