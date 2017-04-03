if select(6, GetAddOnInfo("PitBull4_" .. (debugstack():match("[o%.][d%.][u%.]les\\(.-)\\") or ""))) ~= "MISSING" then return end

local PitBull4 = _G.PitBull4
if not PitBull4 then
  error("PitBull4_Aggro requires PitBull4")
end
local L = PitBull4.L

local LibBanzai

local PitBull4_Aggro = PitBull4:NewModule("Aggro", "AceEvent-3.0", "AceHook-3.0")
PitBull4_Aggro:SetModuleType("custom")
PitBull4_Aggro:SetName(L["Aggro"])
PitBull4_Aggro:SetDescription(L["Add aggro coloring to the unit frame."])
PitBull4_Aggro:SetDefaults({
	kind = "HealthBar",
},{aggro_color = {1, 0, 0, 1}})

local PitBull4_HealthBar
local PitBull4_Border
local PitBull4_Background

local function callback(aggro, name, unit)
	for frame in PitBull4:IterateFramesForGUID(UnitGUID(unit)) do
		local db = PitBull4_Aggro:GetLayoutDB(frame)
		if db.enabled then
			if db.kind == "HealthBar" then
				if PitBull4_HealthBar and PitBull4_HealthBar:IsEnabled() then
					PitBull4_HealthBar:UpdateFrame(frame)
				end
			elseif db.kind == "Border" then
				if PitBull4_Border and PitBull4_Border:IsEnabled() then
					PitBull4_Border:UpdateFrame(frame)
				end
			elseif db.kind == "Background" then
				if PitBull4_Background and PitBull4_Background:IsEnabled() then
					PitBull4_Background:UpdateFrame(frame)
				end
			end
		end
	end
end

local function set_hooks()
	if not PitBull4_HealthBar then
		PitBull4_HealthBar = PitBull4:GetModule("HealthBar", true)
		if PitBull4_HealthBar then
			PitBull4_Aggro:RawHook(PitBull4_HealthBar, "GetColor", "HealthBar_GetColor")
		end
	end

	if not PitBull4_Border then
		PitBull4_Border = PitBull4:GetModule("Border", true)
		if PitBull4_Border then
			PitBull4_Aggro:RawHook(PitBull4_Border, "GetTextureAndColor", "Border_GetTextureAndColor")
		end
	end

	if not PitBull4_Background then
		PitBull4_Background = PitBull4:GetModule("Background", true)
		if PitBull4_Background then
			PitBull4_Aggro:RawHook(PitBull4_Background, "GetColor", "Background_GetColor")
		end
	end
end

function PitBull4_Aggro:OnModuleLoaded(module)
	if not self.db.profile.global.enabled then return end
	local id = module.id
	if id == "HealthBar" or id == "Border" or id == "Background" then
		set_hooks()
	end
end

function PitBull4_Aggro:OnEnable()
	if not LibBanzai then
		LoadAddOn("LibBanzai-2.0")
		LibBanzai = LibStub("LibBanzai-2.0", true)
	end
	if not LibBanzai then
		error(L["PitBull4_Aggro requires the library LibBanzai-2.0 to be available."])
	end

	LibBanzai:RegisterCallback(callback)

	set_hooks()
end

function PitBull4_Aggro:OnDisable()
	LibBanzai:UnregisterCallback(callback)
end

function PitBull4_Aggro:HealthBar_GetColor(module, frame, value)
	local unit = frame.unit
	local db = self:GetLayoutDB(frame)
	if unit and db.enabled and db.kind == "HealthBar" and UnitIsFriend("player", unit) and LibBanzai and LibBanzai:GetUnitAggroByUnitId(unit) then
		local aggro_color = self.db.profile.global.aggro_color
		return aggro_color[1], aggro_color[2], aggro_color[3], nil, true
	end
	
	return self.hooks[module].GetColor(module, frame, value)
end

function PitBull4_Aggro:Border_GetTextureAndColor(module, frame)
	local unit = frame.unit
	local db = self:GetLayoutDB(frame)

	local texture, r, g, b, a
	if module:GetLayoutDB(frame).enabled then
		-- Only call GetTextureAndColor if the Border is enabled for the layout already.
		-- This allows the border to enable for the aggro display and then disable back
		-- to the normal settings
		texture, r, g, b, a = self.hooks[module].GetTextureAndColor(module, frame)
	end
	
	if unit and db.enabled and db.kind == "Border" and UnitIsFriend("player", unit) and LibBanzai:GetUnitAggroByUnitId(unit) then
		r, g, b, a = unpack(self.db.profile.global.aggro_color)
		if not texture or texture == "None" then
			texture = "Blizzard Tooltip"
		end
	end
	
	return texture, r, g, b, a
end

function PitBull4_Aggro:Background_GetColor(module, frame)
	local unit = frame.unit
	local db = self:GetLayoutDB(frame)

	local r, g, b, a
	if module:GetLayoutDB(frame).enabled then
		-- Only call GetColor if the Background is enabled for the layout already.
		-- This allows the background to enable for the aggro display and then disable back
		-- to the normal settings
		r, g, b, a = self.hooks[module].GetColor(module, frame)
	end
	
	if unit and db.enabled and db.kind == "Background" and UnitIsFriend("player", unit) and LibBanzai:GetUnitAggroByUnitId(unit) then
		local a2
		r, g, b, a2 = unpack(self.db.profile.global.aggro_color)
		if a then
			a = a * a2
		else
			a = a2
		end
	end
	
	return r, g, b, a
end

PitBull4_Aggro:SetLayoutOptionsFunction(function(self)
	local function is_kind_allowed(kind)
		if kind == "HealthBar" then
			return PitBull4_HealthBar and PitBull4_HealthBar:IsEnabled() and PitBull4.Options.GetLayoutDB(PitBull4_HealthBar.id).enabled
		elseif kind == "Border" then
			return PitBull4_Border and PitBull4_Border:IsEnabled()
		elseif kind == "Background" then
			return PitBull4_Background and PitBull4_Background:IsEnabled()
		elseif kind == "" then
			return true
		else
			return false
		end
	end

	return 'kind', {
		type = 'select',
		name = L["Display"],
		desc = L["How to display the aggro indication."],
		get = function(info)
			local kind = PitBull4.Options.GetLayoutDB(self).kind
			if not is_kind_allowed(kind) then
				return ""
			end
			return kind
		end,
		set = function(info, value)
			PitBull4.Options.GetLayoutDB(self).kind = value
			
			PitBull4.Options.UpdateFrames()
		end,
		values = function(info)
			local t = {}
			t[""] = L["None"]
			if is_kind_allowed("HealthBar") then 
				t.HealthBar = L["Health bar"]
			end
			if is_kind_allowed("Border") then 
				t.Border = L["Border"]
			end
			if is_kind_allowed("Background") then 
				t.Background = L["Background"]
			end
			return t
		end
	}
end)

PitBull4_Aggro:SetColorOptionsFunction(function(self)
	return 'aggro_color', {
		type = 'color',
		name = L['Aggro'],
		desc = L['Sets which color to use on the health bar of units that have aggro.'],
		get = function(info)
			return unpack(self.db.profile.global.aggro_color)
		end,
		set = function(info, r, g, b, a)
			self.db.profile.global.aggro_color = {r, g, b, a}
			self:UpdateAll()
		end,
	},
	function(info)
		self.db.profile.global.aggro_color = {1, 0, 0, 1}
	end
end)
