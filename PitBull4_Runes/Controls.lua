if select(6, GetAddOnInfo("PitBull4_" .. (debugstack():match("[o%.][d%.][u%.]les\\(.-)\\") or ""))) ~= "MISSING" then return end

if select(2, UnitClass("player")) ~= "DEATHKNIGHT" then
	return
end

-- CONSTANTS ----------------------------------------------------------------

local RUNETYPE_BLOOD = 1
local RUNETYPE_UNHOLY = 2
local RUNETYPE_FROST = 3
local RUNETYPE_DEATH = 4

local RUNE_MAPPING = _G.runeMapping or {
	[RUNETYPE_BLOOD] = "BLOOD",
	[RUNETYPE_UNHOLY] = "UNHOLY",
	[RUNETYPE_FROST] = "FROST",
	[RUNETYPE_DEATH] = "DEATH",
}

local module_path = _G.debugstack():match("[d%.][d%.][O%.]ns\\(.-)\\[A-Za-z0-9]-%.lua")

local ICON_TEXTURES = {
	[RUNETYPE_BLOOD] = [[Interface\AddOns\]] .. module_path .. [[\Blood]],
	[RUNETYPE_UNHOLY] = [[Interface\AddOns\]] .. module_path .. [[\Unholy]],
	[RUNETYPE_FROST] = [[Interface\AddOns\]] .. module_path .. [[\Frost]],
	[RUNETYPE_DEATH] = [[Interface\AddOns\]] .. module_path .. [[\Death]],
}

local RUNE_COLORS = {
	[RUNETYPE_BLOOD] = { 1, 0, 0 },
	[RUNETYPE_UNHOLY] = { 0, 0.5, 0 },
	[RUNETYPE_FROST] = { 0, 1, 1 },
	[RUNETYPE_DEATH] = { 0.8, 0.1, 1 },
}

local STANDARD_SIZE = 15

local SHINE_TIME = 1
local SHINE_HALF_TIME = SHINE_TIME / 2
local INVERSE_SHINE_HALF_TIME = 1 / SHINE_HALF_TIME

local SHINE_TEXTURE = [[Interface\AddOns\]] .. module_path .. [[\Shine]]

local UNREADY_ALPHA = 0.6
local READY_ALPHA = 1

-----------------------------------------------------------------------------

local Rune = {}
local Rune_scripts = {}

function Rune:UpdateTexture()
	local rune_type = GetRuneType(self.id)
	if self.rune_type == rune_type then
		return
	end
	
	local old_rune_type = self.rune_type
	self.rune_type = rune_type
	self:SetNormalTexture(ICON_TEXTURES[rune_type])
	if old_rune_type then
		self:Shine()
	end
end

function Rune:UpdateCooldown()
	local start, duration, ready = GetRuneCooldown(self.id)
	
	local cooldown = self.cooldown
	if ready or not start then
		if cooldown:IsShown() then
			cooldown:Hide()
			self:Shine()
		end
		self:GetNormalTexture():SetAlpha(READY_ALPHA)
	else
		cooldown:Show()
		cooldown:SetCooldown(start, duration)
		self:GetNormalTexture():SetAlpha(UNREADY_ALPHA)
	end
end

local function Rune_OnUpdate(self, elapsed)
	local shine_time = self.shine_time + elapsed
	
	if shine_time > SHINE_TIME then
		self:SetScript("OnUpdate", nil)
		self.shine_time = nil
		self.shine = self.shine:Delete()
		return
	end
	self.shine_time = shine_time
	
	if shine_time < SHINE_HALF_TIME then
		self.shine:SetAlpha(shine_time * INVERSE_SHINE_HALF_TIME)
	else
		self.shine:SetAlpha((SHINE_TIME - shine_time) * INVERSE_SHINE_HALF_TIME)
	end
end

function Rune:Shine()
	local shine = self.shine
	if not shine then
		shine = PitBull4.Controls.MakeTexture(self, "OVERLAY")
		self.shine = shine
		shine:SetTexture(SHINE_TEXTURE)
		shine:SetBlendMode("ADD")
		shine:SetAlpha(0)
		shine:SetAllPoints(self)
		if self.rune_type then
			shine:SetVertexColor(unpack(RUNE_COLORS[self.rune_type]))
		else
			shine:SetVertexColor(1, 1, 1)
		end
		self:SetScript("OnUpdate", Rune_OnUpdate)
	end
	self.shine_time = 0
end

function Rune_scripts:OnEnter()
	if not self.rune_type then
		return
	end
	
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetText(_G["COMBAT_TEXT_RUNE_" .. RUNE_MAPPING[self.rune_type]])
	GameTooltip:Show()
end

function Rune_scripts:OnLeave()
	GameTooltip:Hide()
end

PitBull4.Controls.MakeNewControlType("Rune", "Button", function(control)
	-- onCreate
	
	for k, v in pairs(Rune) do
		control[k] = v
	end
	for k, v in pairs(Rune_scripts) do
		control:SetScript(k, v)
	end
	
	local cooldown = PitBull4.Controls.MakeCooldown(control)
	control.cooldown = cooldown
	cooldown:SetAllPoints(control)
end, function(control, id)
	-- onRetrieve
	
	control.id = id
	control.cooldown:Hide()
	control:SetWidth(STANDARD_SIZE)
	control:SetHeight(STANDARD_SIZE)
end, function(control)
	-- onDelete
	
	control.id = nil
	control.rune_type = nil
	control.shine_time = nil
	
	control.cooldown:Hide()
	control:SetNormalTexture(nil)
	if control.shine then
		control.shine = control.shine:Delete()
	end
	control:SetScript("OnUpdate", nil)
end)
