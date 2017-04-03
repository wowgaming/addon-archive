--[[--------------------------------------------------------------------
	GridStatusHeals.lua
	GridStatus module for tracking incoming healing spells.
----------------------------------------------------------------------]]

local _, ns = ...
local L = ns.L

local HealComm = LibStub("LibHealComm-4.0", true)
if not HealComm then return end

local GridRoster = Grid:GetModule("GridRoster")

local settings
local playerGUID

local GridStatusHeals = Grid:GetModule("GridStatus"):NewModule("GridStatusHeals")
GridStatusHeals.menuName = L["Heals"]
GridStatusHeals.options = false

GridStatusHeals.defaultDB = {
	debug = false,
	alert_heals = {
		text = L["Incoming heals"],
		enable = true,
		color = { r = 0, g = 1, b = 0, a = 1 },
		priority = 50,
		range = false,
		ignore_self = false,
		heal_filter = {
		  direct = true,
		  channeled = true,
		  hot = true,
        },
		icon = nil,
	},
}

local healsOptions = {
	ignoreSelf = {
		type = "toggle",
		name = L["Ignore Self"],
		desc = L["Ignore heals cast by you."],
		get  = function()
			return GridStatusHeals.db.profile.alert_heals.ignore_self
		end,
		set  = function(v)
			GridStatusHeals.db.profile.alert_heals.ignore_self = v
			GridStatusHeals:UpdateAllHeals()
		end,
	},
	heal_filter = {
        type = "group",
        name = L["Heal filter"],
        desc = L["Show incoming heals for the selected heal types."],
        args = {
            direct = {
                type = "toggle",
                name = L["Direct heals"],
                desc = L["Include direct heals."],
                get  = function()
                    return GridStatusHeals.db.profile.alert_heals.heal_filter.direct
                end,
                set  = function(v)
                    GridStatusHeals.db.profile.alert_heals.heal_filter.direct = v
                    GridStatusHeals:UpdateAllHeals()
                end,
            },
            channeled = {
                type = "toggle",
                name = L["Channeled heals"],
                desc = L["Include channeled heals."],
                get  = function()
                    return GridStatusHeals.db.profile.alert_heals.heal_filter.channeled
                end,
                set  = function(v)
                    GridStatusHeals.db.profile.alert_heals.heal_filter.channeled = v
                    GridStatusHeals:UpdateAllHeals()
                end,
            },
            hot = {
                type = "toggle",
                name = L["HoT heals"],
                desc = L["Include heal over time effects."],
                get  = function()
                    return GridStatusHeals.db.profile.alert_heals.heal_filter.hot
                end,
                set  = function(v)
                    GridStatusHeals.db.profile.alert_heals.heal_filter.hot = v
                    GridStatusHeals:UpdateAllHeals()
                end,
            },
        },
    },
}

function GridStatusHeals:OnInitialize()
	self.super.OnInitialize(self)

	self:RegisterEvent("PLAYER_LOGIN", function() playerGUID = UnitGUID("player") end)

	settings = GridStatusHeals.db.profile.alert_heals
	self:RegisterStatus("alert_heals", L["Incoming heals"], healsOptions, true)
end

function GridStatusHeals:OnStatusEnable(status)
	if status == "alert_heals" then
		-- register events
		self:RegisterEvent("UNIT_HEALTH", "UpdateHealsForUnit")
		self:RegisterEvent("UNIT_MAXHEALTH", "UpdateHealsForUnit")

		-- register callbacks
		HealComm.RegisterCallback(self, "HealComm_HealStarted")
		HealComm.RegisterCallback(self, "HealComm_HealUpdated")
		HealComm.RegisterCallback(self, "HealComm_HealDelayed")
		HealComm.RegisterCallback(self, "HealComm_HealStopped")
		HealComm.RegisterCallback(self, "HealComm_ModifierChanged")
		HealComm.RegisterCallback(self, "HealComm_GUIDDisappeared")

		self:UpdateAllHeals()
	end
end

function GridStatusHeals:OnStatusDisable(status)
	if status == "alert_heals" then
		self:UnregisterEvent("UNIT_HEALTH")
		self:UnregisterEvent("UNIT_MAXHEALTH")

		HealComm.UnregisterCallback(self, "HealComm_HealStarted")
		HealComm.UnregisterCallback(self, "HealComm_HealUpdated")
		HealComm.UnregisterCallback(self, "HealComm_HealDelayed")
		HealComm.UnregisterCallback(self, "HealComm_HealStopped")
		HealComm.UnregisterCallback(self, "HealComm_ModifierChanged")
		HealComm.UnregisterCallback(self, "HealComm_GUIDDisappeared")

		self.core:SendStatusLostAllUnits("alert_heals")
	end
end

function GridStatusHeals:HealComm_HealStarted(event, casterGUID, spellID, healType, endTime, ...)
	self:UpdateIncomingHeals(casterGUID, healType, ...)
end

function GridStatusHeals:HealComm_HealUpdated(event, casterGUID, spellID, healType, endTime, ...)
	self:UpdateIncomingHeals(casterGUID, healType, ...)
end

function GridStatusHeals:HealComm_HealDelayed(event, casterGUID, spellID, healType, endTime, ...)
	self:UpdateIncomingHeals(casterGUID, healType, ...)
end

function GridStatusHeals:HealComm_HealStopped(event, casterGUID, spellID, healType, endTime, ...)
	self:UpdateIncomingHeals(casterGUID, healType, ...)
end

function GridStatusHeals:HealComm_ModifierChanged(event, guid)
	self:UpdateIncomingHeals(nil, nil, guid)
end

function GridStatusHeals:HealComm_GUIDDisappeared(event, guid)
	self:UpdateIncomingHeals(nil, nil, guid)
end

function GridStatusHeals:UpdateHealsForUnit(unitid)
	self:UpdateIncomingHeals(nil, nil, UnitGUID(unitid))
end

function GridStatusHeals:Reset()
	settings = GridStatusHeals.db.profile.alert_heals
	self.super.Reset(self)
	self:UpdateAllHeals()
end

function GridStatusHeals:UpdateAllHeals()
	for guid in GridRoster:IterateRoster() do
		self:UpdateIncomingHeals(nil, nil, guid)
	end
end

function GridStatusHeals:UpdateIncomingHeals(casterGUID, healType, ...)
	if settings.ignore_self and casterGUID == playerGUID then return end

	local heal_filter = settings.heal_filter
	local heal_mask = bit.bor(heal_filter.direct and HealComm.DIRECT_HEALS or 0,
		heal_filter.channeled and HealComm.CHANNEL_HEALS or 0,
		heal_filter.hot and HealComm.HOT_HEALS or 0,
		heal_filter.hot and HealComm.BOMB_HEALS or 0)
	if healType and bit.band(healType, heal_mask) == 0 then return end

	--iterate through targets of heal and update them
	for i = 1, select("#", ...) do
		local guid = select(i, ...)
		local unitid = GridRoster:GetUnitidByGUID(guid)
		if unitid then
			local incoming
			if not settings.ignore_self then
				incoming = HealComm:GetHealAmount(guid, heal_mask, GetTime() + 4)
			else
				incoming = HealComm:GetOthersHealAmount(guid, heal_mask, GetTime() + 4)
			end
			if incoming and incoming > 0 and not UnitIsDeadOrGhost(unitid) then
				local effectiveIncoming = incoming * HealComm:GetHealModifier(guid)
				self:SendIncomingHealsStatus(guid, effectiveIncoming, UnitHealth(unitid) + effectiveIncoming, UnitHealthMax(unitid))
			else
				self.core:SendStatusLost(guid, "alert_heals")
			end
		end
	end
end

function GridStatusHeals:SendIncomingHealsStatus(guid, incoming, estimatedHealth, maxHealth)
	-- add heal modifier to incoming value caused by buffs and debuffs
	-- local modifier = UnitHealModifierGet(unitName)
	-- local effectiveIncoming = modifier * incoming

	local incomingText
	if incoming > 999 then
		incomingText = ("+%.1fk"):format(incoming / 1000)
	else
		incomingText = ("+%d"):format(incoming)
	end
	self.core:SendStatusGained(guid, "alert_heals", settings.priority, (settings.range and 40), settings.color, incomingText, estimatedHealth, maxHealth, settings.icon)
end
