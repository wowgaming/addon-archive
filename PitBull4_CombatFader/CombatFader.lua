if select(6, GetAddOnInfo("PitBull4_" .. (debugstack():match("[o%.][d%.][u%.]les\\(.-)\\") or ""))) ~= "MISSING" then return end

local PitBull4 = _G.PitBull4
if not PitBull4 then
	error("PitBull4_CombatFader requires PitBull4")
end

local L = PitBull4.L

local PitBull4_CombatFader = PitBull4:NewModule("CombatFader", "AceEvent-3.0")

PitBull4_CombatFader:SetModuleType("fader")
PitBull4_CombatFader:SetName(L["Combat fader"])
PitBull4_CombatFader:SetDescription(L["Make the unit frame fade if out of combat."])
PitBull4_CombatFader:SetDefaults({
	enabled = false,
	hurt_opacity = 0.75,
	in_combat_opacity = 1,
	out_of_combat_opacity = 0.25,
	target_opacity = 0.75,
})

local state = 'out_of_combat'

local timerFrame = CreateFrame("Frame")
timerFrame:Hide()

timerFrame:SetScript("OnUpdate", function(self)
	self:Hide()
	
	PitBull4_CombatFader:RecalculateState()
	PitBull4_CombatFader:UpdateAll()
end)

function PitBull4_CombatFader:OnEnable()
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("PLAYER_TARGET_CHANGED")
	self:RegisterEvent("UNIT_HEALTH")
	self:RegisterEvent("UNIT_MANA")
	self:RegisterEvent("UNIT_RAGE")
	self:RegisterEvent("UNIT_ENERGY")
	self:RegisterEvent("UNIT_RUNIC_POWER")
	self:RegisterEvent("UNIT_DISPLAYPOWER")
	
	self:RecalculateState()
	timerFrame:Show()
end

local power_check = {
	MANA = function()
		return UnitMana('player') < UnitManaMax('player')
	end,
	RAGE = function()
		-- this seems counter-intuitive, but if rage > 0, you're up for fighting
		return UnitMana('player') > 0
	end,
	ENERGY = function()
		return UnitMana('player') < UnitManaMax('player')
	end,
	RUNICPOWER = function()
		return UnitMana('player') > 0
	end,
}

function PitBull4_CombatFader:RecalculateState()
	if UnitAffectingCombat('player') then
		state = 'in_combat'
	elseif UnitExists('target') then
		state = 'target'
	elseif UnitHealth('player') < UnitHealthMax('player') then
		state = 'hurt'
	else
		local _, power_token = UnitPowerType('player')
		local func = power_check[power_token]
		if func and func() then
			state = 'hurt'
		else
			state = 'out_of_combat'
		end
	end
end

function PitBull4_CombatFader:PLAYER_REGEN_ENABLED()
	-- this is handled through a timer because PLAYER_TARGET_CHANGED looks funny otherwise
	timerFrame:Show()
end

PitBull4_CombatFader.PLAYER_REGEN_DISABLED = PitBull4_CombatFader.PLAYER_REGEN_ENABLED
PitBull4_CombatFader.PLAYER_TARGET_CHANGED = PitBull4_CombatFader.PLAYER_REGEN_ENABLED

function PitBull4_CombatFader:UNIT_HEALTH(event, unit)
	if unit ~= "player" then
		return
	end
	
	return self:PLAYER_REGEN_ENABLED()
end

PitBull4_CombatFader.UNIT_MANA = PitBull4_CombatFader.UNIT_HEALTH
PitBull4_CombatFader.UNIT_RAGE = PitBull4_CombatFader.UNIT_HEALTH
PitBull4_CombatFader.UNIT_ENERGY = PitBull4_CombatFader.UNIT_HEALTH
PitBull4_CombatFader.UNIT_RUNIC_POWER = PitBull4_CombatFader.UNIT_HEALTH
PitBull4_CombatFader.UNIT_DISPLAYPOWER = PitBull4_CombatFader.UNIT_HEALTH

function PitBull4_CombatFader:GetOpacity(frame)
	local layout_db = self:GetLayoutDB(frame)
	
	return layout_db[state .. "_opacity"]
end

PitBull4_CombatFader:SetLayoutOptionsFunction(function(self)
	return 'hurt', {
		type = 'range',
		name = L["Hurt opacity"],
		desc = L["The opacity to display if the player is missing health or mana."],
		min = 0,
		max = 1,
		isPercent = true,
		get = function(info)
			local db = PitBull4.Options.GetLayoutDB(self)
			
			return db.hurt_opacity
		end,
		set = function(info, value)
			local db = PitBull4.Options.GetLayoutDB(self)
			
			db.hurt_opacity = value
			
			PitBull4.Options.UpdateFrames()
			PitBull4:RecheckAllOpacities()
		end,
		step = 0.01,
		bigStep = 0.05,
	}, 'in_combat', {
		type = 'range',
		name = L["In-combat opacity"],
		desc = L["The opacity to display if the player is in combat."],
		min = 0,
		max = 1,
		isPercent = true,
		get = function(info)
			local db = PitBull4.Options.GetLayoutDB(self)

			return db.in_combat_opacity
		end,
		set = function(info, value)
			local db = PitBull4.Options.GetLayoutDB(self)

			db.in_combat_opacity = value

			PitBull4.Options.UpdateFrames()
			PitBull4:RecheckAllOpacities()
		end,
		step = 0.01,
		bigStep = 0.05,
	}, 'out_of_combat', {
		type = 'range',
		name = L["Out-of-combat opacity"],
		desc = L["The opacity to display if the player is out of combat."],
		min = 0,
		max = 1,
		isPercent = true,
		get = function(info)
			local db = PitBull4.Options.GetLayoutDB(self)

			return db.out_of_combat_opacity
		end,
		set = function(info, value)
			local db = PitBull4.Options.GetLayoutDB(self)

			db.out_of_combat_opacity = value

			PitBull4.Options.UpdateFrames()
			PitBull4:RecheckAllOpacities()
		end,
		step = 0.01,
		bigStep = 0.05,
	}, 'target', {
		type = 'range',
		name = L["Target-selected opacity"],
		desc = L["The opacity to display if the player is selecting a target."],
		min = 0,
		max = 1,
		isPercent = true,
		get = function(info)
			local db = PitBull4.Options.GetLayoutDB(self)

			return db.target_opacity
		end,
		set = function(info, value)
			local db = PitBull4.Options.GetLayoutDB(self)

			db.target_opacity = value

			PitBull4.Options.UpdateFrames()
			PitBull4:RecheckAllOpacities()
		end,
		step = 0.01,
		bigStep = 0.05,
	}
end)