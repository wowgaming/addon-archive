if select(6, GetAddOnInfo("PitBull4_" .. (debugstack():match("[o%.][d%.][u%.]les\\(.-)\\") or ""))) ~= "MISSING" then return end

local PitBull4 = _G.PitBull4
if not PitBull4 then
	error("PitBull4_PowerBar requires PitBull4")
end

local EXAMPLE_VALUE = 0.6

local L = PitBull4.L

local PitBull4_PowerBar = PitBull4:NewModule("PowerBar", "AceEvent-3.0", "AceHook-3.0", "AceTimer-3.0")
local last_player_power
local last_pet_power

PitBull4_PowerBar:SetModuleType("bar")
PitBull4_PowerBar:SetName(L["Power bar"])
PitBull4_PowerBar:SetDescription(L["Show a mana, rage, energy, or runic power bar."])
PitBull4_PowerBar:SetDefaults({
	position = 2,
	hide_no_mana = false,
	hide_no_power = false,
})

local guids_to_update = {}
local predicted_power = true

local timerFrame = CreateFrame("Frame")
timerFrame:Hide()

local PLAYER_GUID
function PitBull4_PowerBar:OnEnable()
	PLAYER_GUID = UnitGUID("player")

	self:RegisterEvent("UNIT_MANA")
	self:RegisterEvent("UNIT_MAXMANA", "UNIT_MANA")
	self:RegisterEvent("UNIT_RAGE", "UNIT_MANA")
	self:RegisterEvent("UNIT_MAXRAGE", "UNIT_MANA")
	self:RegisterEvent("UNIT_FOCUS", "UNIT_MANA")
	self:RegisterEvent("UNIT_MAXFOCUS", "UNIT_MANA")
	self:RegisterEvent("UNIT_ENERGY", "UNIT_MANA")
	self:RegisterEvent("UNIT_MAXENERGY", "UNIT_MANA")
	self:RegisterEvent("UNIT_RUNIC_POWER", "UNIT_MANA")
	self:RegisterEvent("UNIT_MAXRUNIC_POWER", "UNIT_MANA")
	self:RegisterEvent("UNIT_DISPLAYPOWER", "UNIT_MANA")

	self:SecureHook("SetCVar")
	self:SetCVar()

	timerFrame:Show()
end

function PitBull4_PowerBar:OnDisable()
	timerFrame:Hide()
end

timerFrame:SetScript("OnUpdate", function()
	if predicted_power and UnitPower("player") ~= last_player_power then
		for frame in PitBull4:IterateFramesForGUID(PLAYER_GUID) do
			if not frame.is_wacky then
				PitBull4_PowerBar:Update(frame)
			end
		end
		guids_to_update[PLAYER_GUID] = nil
	end
	if predicted_power and UnitPower("pet") ~= last_pet_power then
		local pet_guid = UnitGUID("pet")
		if pet_guid then
			for frame in PitBull4:IterateFramesForGUID(pet_guid) do
				if not frame.is_wacky then
					PitBull4_PowerBar:Update(frame)
				end
			end
			guids_to_update[pet_guid] = nil
		end
	end
	if next(guids_to_update) then
		for frame in PitBull4:IterateFrames() do
			if guids_to_update[frame.guid] then
				PitBull4_PowerBar:Update(frame)
			end
		end
		wipe(guids_to_update)
	end
end)

local function get_power_and_cache(unit)
	local power = UnitPower(unit)
	if unit == "player" then
		last_player_power = power
	elseif unit == "pet" then
		last_pet_power = power
	end
	return power
end

function PitBull4_PowerBar:GetValue(frame)	
	local unit = frame.unit
	local layout_db = self:GetLayoutDB(frame)

	if layout_db.hide_no_mana and UnitPowerType(unit) ~= 0 then
		return nil
	elseif layout_db.hide_no_power and UnitPowerMax(unit) <= 0 then
		return nil
	end

	return get_power_and_cache(unit) / UnitPowerMax(unit)
end

function PitBull4_PowerBar:GetExampleValue(frame)
	return EXAMPLE_VALUE
end

function PitBull4_PowerBar:GetColor(frame, value)
	local db = self:GetLayoutDB(frame)
	
	local _, power_token = UnitPowerType(frame.unit)
	if not power_token then
		power_token = "MANA"
	end
	local color = PitBull4.PowerColors[power_token]
	
	if color then
		return color[1], color[2], color[3]
	end
end
function PitBull4_PowerBar:GetExampleColor(frame)
	return unpack(PitBull4.PowerColors.MANA)
end

function PitBull4_PowerBar:UNIT_MANA(event, unit)
	guids_to_update[UnitGUID(unit)] = true
end

function PitBull4_PowerBar:SetCVar()
	predicted_power = GetCVarBool("predictedPower")
end

PitBull4_PowerBar:SetLayoutOptionsFunction(function(self)
	return 'hide_no_mana', {
		name = L['Hide non-mana'],
		desc = L["Hides the power bar if the unit's current power is not mana."],
		type = 'toggle',
		get = function(info)
			return PitBull4.Options.GetLayoutDB(self).hide_no_mana
		end,
		set = function(info, value)
			PitBull4.Options.GetLayoutDB(self).hide_no_mana = value

			PitBull4.Options.UpdateFrames()
		end,
	}, 'hide_no_power', {
		name = L['Hide non-power'],
		desc = L['Hides the power bar if the unit has no power.'],
		type = 'toggle',
		get = function(info)
			return PitBull4.Options.GetLayoutDB(self).hide_no_power
		end,
		set = function(info, value)
			PitBull4.Options.GetLayoutDB(self).hide_no_power = value

			PitBull4.Options.UpdateFrames()
		end,
	}
end)
