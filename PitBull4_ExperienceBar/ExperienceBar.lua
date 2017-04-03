if select(6, GetAddOnInfo("PitBull4_" .. (debugstack():match("[o%.][d%.][u%.]les\\(.-)\\") or ""))) ~= "MISSING" then return end

local PitBull4 = _G.PitBull4
if not PitBull4 then
	error("PitBull4_ExperienceBar requires PitBull4")
end

local L = PitBull4.L

local EXAMPLE_VALUE = 0.25

local PitBull4_ExperienceBar = PitBull4:NewModule("ExperienceBar", "AceEvent-3.0")

PitBull4_ExperienceBar:SetModuleType("bar")
PitBull4_ExperienceBar:SetName(L["Experience bar"])
PitBull4_ExperienceBar:SetDescription(L["Show an experience bar."])
PitBull4_ExperienceBar:SetDefaults({
	size = 1,
	position = 4,
})

function PitBull4_ExperienceBar:OnEnable()
	self:RegisterEvent("PLAYER_XP_UPDATE")
	self:RegisterEvent("UPDATE_EXHAUSTION")
	self:RegisterEvent("PLAYER_LEVEL_UP")
end

function PitBull4_ExperienceBar:GetValue(frame)
	local unit = frame.unit
	if unit ~= "player" and unit ~= "pet" then
		return nil
	end
	
	local level = UnitLevel(unit)
	local current, max, rest
	if unit == "player" then
		if level == MAX_PLAYER_LEVEL then
			return nil
		end
		
		current, max = UnitXP("player"), UnitXPMax("player")
		rest = GetXPExhaustion() 
		if rest == nil then
		    rest = 0
		end
		
	else -- pet
		if level == UnitLevel("player") then
			return nil
		end
		
		current, max = GetPetExperience()
		rest = 0
	end
	
	if max == 0 then
		current = 0
		max = 1
	end
	
	return current / max, rest / max
end
function PitBull4_ExperienceBar:GetExampleValue(frame)
	return EXAMPLE_VALUE
end

function PitBull4_ExperienceBar:GetColor(frame, value)
	return 0, 0, 1
end
PitBull4_ExperienceBar.GetExampleColor = PitBull4_ExperienceBar.GetColor

function PitBull4_ExperienceBar:GetExtraColor(frame, value)
	return 1, 0, 1
end
PitBull4_ExperienceBar.GetExampleExtraColor = PitBull4_ExperienceBar.GetExtraColor

function PitBull4_ExperienceBar:PLAYER_XP_UPDATE()
	for frame in PitBull4:IterateFramesForUnitIDs("player", "pet") do
		self:Update(frame)
	end
end

PitBull4_ExperienceBar.UPDATE_EXHAUSTION = PitBull4_ExperienceBar.PLAYER_XP_UPDATE
PitBull4_ExperienceBar.PLAYER_LEVEL_UP = PitBull4_ExperienceBar.PLAYER_XP_UPDATE

PitBull4_ExperienceBar:SetLayoutOptionsFunction(function(self)
	return 'toggle_custom_extra', {
		type = 'toggle',
		name = L["Custom rested"],
		desc = L["Whether to override the rested color and use a custom one."],
		order = -30,
		get = function(info)
			local db = PitBull4.Options.GetLayoutDB(self) 
			return db and not not db.custom_extra
		end,
		set = function(info, value)
			if value then
				PitBull4.Options.GetLayoutDB(self).custom_extra = { 0.31, 0.31, 0.31, 1 }
			else
				PitBull4.Options.GetLayoutDB(self).custom_extra = nil
			end
			
			PitBull4.Options.UpdateFrames()
		end,
	}, 'custom_extra', {
		type = 'color',
		name = L["Custom rested"],
		desc = L["What rested color to override the bar with."],
		order = -29,
		get = function(info)
			return unpack(PitBull4.Options.GetLayoutDB(self).custom_extra)
		end,
		set = function(info, r, g, b, a)
			local color = PitBull4.Options.GetLayoutDB(self).custom_extra
			color[1], color[2], color[3], color[4] = r, g, b, a
			
			PitBull4.Options.UpdateFrames()
		end,
		hidden = function(info)
			local db = PitBull4.Options.GetLayoutDB(self)
			return not db or not db.custom_extra
		end,
	}
end)
