if select(6, GetAddOnInfo("PitBull4_" .. (debugstack():match("[o%.][d%.][u%.]les\\(.-)\\") or ""))) ~= "MISSING" then return end

local PitBull4 = _G.PitBull4
if not PitBull4 then
	error("PitBull4_HostilityFader requires PitBull4")
end

local L = PitBull4.L

local PitBull4_HostilityFader = PitBull4:NewModule("HostilityFader","AceEvent-3.0")

PitBull4_HostilityFader:SetModuleType("fader")
PitBull4_HostilityFader:SetName(L["Hostility fader"])
PitBull4_HostilityFader:SetDescription(L["Make the unit frame fade depending on the units hostility."])
PitBull4_HostilityFader:SetDefaults({
	enabled = false,
	hostile_opacity = 0.6,
	friendly_opacity = 1,
})

function PitBull4_HostilityFader:OnEnable()
	self:RegisterEvent("UNIT_FACTION")
end

function PitBull4_HostilityFader:UNIT_FACTION(event, unit)
	self:UpdateForUnitID(unit)	
end

function PitBull4_HostilityFader:GetOpacity(frame)
	local unit = frame.unit
	if not unit then return end

	local layout_db = self:GetLayoutDB(frame)

	if UnitIsEnemy("player", unit) then
		return layout_db.hostile_opacity
	else
		return layout_db.friendly_opacity
	end
end

PitBull4_HostilityFader:SetLayoutOptionsFunction(function(self)
	return 'friendly_opacity', {
		type = 'range',
		name = L["Friendly opacity"],
		desc = L["The opacity to display if the unit is friendly."],
		min = 0,
		max = 1,
		isPercent = true,
		get = function(info)
			local db = PitBull4.Options.GetLayoutDB(self)

			return db.friendly_opacity
		end,
		set = function(info, value)
			local db = PitBull4.Options.GetLayoutDB(self)

			db.friendly_opacity = value

			PitBull4.Options.UpdateFrames()
			PitBull4:RecheckAllOpacities()
		end,
		step = 0.01,
		bigStep = 0.05,
	}, 'hostile_opacity', {
		type = 'range',
		name = L["Hostile opacity"],
		desc = L["The opacity to display if the unit is hostile."],
		min = 0,
		max = 1,
		isPercent = true,
		get = function(info)
			local db = PitBull4.Options.GetLayoutDB(self)

			return db.hostile_opacity
		end,
		set = function(info, value)
			local db = PitBull4.Options.GetLayoutDB(self)

			db.hostile_opacity = value

			PitBull4.Options.UpdateFrames()
			PitBull4:RecheckAllOpacities()
		end,
		step = 0.01,
		bigStep = 0.05,
	}
end)
