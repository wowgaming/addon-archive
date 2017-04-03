--[[--------------------------------------------------------------------
	GridStatusReadyCheck.lua
	GridStatus module for reporting ready check responses.
	Created by Greltok.
----------------------------------------------------------------------]]

local _, ns = ...
local L = ns.L

local GridStatusReadyCheck = Grid:GetModule("GridStatus"):NewModule("GridStatusReadyCheck")
GridStatusReadyCheck.menuName = L["Ready Check"]

GridStatusReadyCheck.defaultDB = {
	debug = false,
	ready_check = {
		text = L["Ready Check"],
		enable = true,
		color = { r = 1, g = 1, b = 1, a = 1 },
		priority = 95,
		delay = 5,
		range = false,
		colors = {
			waiting = { r = 1, g = 1, b = 0, a = 1, ignore = true },
			ready = { r = 0, g = 1, b = 0, a = 1, ignore = true },
			not_ready = { r = 1, g = 0, b = 0, a = 1, ignore = true },
			afk = { r = 1, g = 0, b = 0, a = 1, ignore = true }
		},
	},
}

GridStatusReadyCheck.options = false

local readystatus = {
	waiting = {
		text = L["?"],
		icon = READY_CHECK_WAITING_TEXTURE
	},
	ready = {
		text = L["R"],
		icon = READY_CHECK_READY_TEXTURE
	},
	not_ready = {
		text = L["X"],
		icon = READY_CHECK_NOT_READY_TEXTURE
	},
	afk = {
		text = L["AFK"],
		icon = READY_CHECK_AFK_TEXTURE
	},
}

local function getstatuscolor(key)
	local color = GridStatusReadyCheck.db.profile.ready_check.colors[key]
	return color.r, color.g, color.b, color.a
end

local function setstatuscolor(key, r, g, b, a)
	local color = GridStatusReadyCheck.db.profile.ready_check.colors[key]
	color.r = r
	color.g = g
	color.b = b
	color.a = a or 1
	color.ignore = true
end

local readyCheckOptions = {
	["waiting"] = {
		type = "color",
		name = L["Waiting color"],
		desc = L["Color for Waiting."],
		order = 86,
		hasAlpha = true,
		get = function () return getstatuscolor("waiting") end,
		set = function (r, g, b, a) setstatuscolor("waiting", r, g, b, a) end,
	},
	["ready"] = {
		type = "color",
		name = L["Ready color"],
		desc = L["Color for Ready."],
		order = 87,
		hasAlpha = true,
		get = function () return getstatuscolor("ready") end,
		set = function (r, g, b, a) setstatuscolor("ready", r, g, b, a) end,
	},
	["not_ready"] = {
		type = "color",
		name = L["Not Ready color"],
		desc = L["Color for Not Ready."],
		order = 88,
		hasAlpha = true,
		get = function () return getstatuscolor("not_ready") end,
		set = function (r, g, b, a) setstatuscolor("not_ready", r, g, b, a) end,
	},
	["afk"] = {
		type = "color",
		name = L["AFK color"],
		desc = L["Color for AFK."],
		order = 89,
		hasAlpha = true,
		get = function () return getstatuscolor("afk") end,
		set = function (r, g, b, a) setstatuscolor("afk", r, g, b, a) end,
	},
	["delay"] = {
		type = "range",
		name = L["Delay"],
		desc = L["Set the delay until ready check results are cleared."],
		max = 10,
		min = 0,
		step = 1,
		get = function()
			return GridStatusReadyCheck.db.profile.ready_check.delay
		end,
		set = function(v)
			GridStatusReadyCheck.db.profile.ready_check.delay = v
		end,
	},

	["color"] = false,
	["range"] = false,
}

function GridStatusReadyCheck:OnInitialize()
	self.super.OnInitialize(self)
	self:RegisterStatus("ready_check", L["Ready Check"], readyCheckOptions, true)
end

function GridStatusReadyCheck:OnStatusEnable(status)
	if status == "ready_check" then
		self:RegisterEvent("READY_CHECK")
		self:RegisterEvent("READY_CHECK_CONFIRM")
		self:RegisterEvent("READY_CHECK_FINISHED")
		self:RegisterEvent("PARTY_LEADER_CHANGED")
		self:RegisterEvent("RAID_ROSTER_UPDATE")
		self:RegisterEvent("Grid_PartyTransition")
	end
end

function GridStatusReadyCheck:OnStatusDisable(status)
	if status == "ready_check" then
		self:UnregisterEvent("READY_CHECK")
		self:UnregisterEvent("READY_CHECK_CONFIRM")
		self:UnregisterEvent("READY_CHECK_FINISHED")
		self:UnregisterEvent("PARTY_LEADER_CHANGED")
		self:UnregisterEvent("RAID_ROSTER_UPDATE")
		self:UnregisterEvent("Grid_PartyTransition")

		self:CancelScheduledEvent("GridStatusReadyCheck_Clear")

		self:ClearStatus()
	end
end

function GridStatusReadyCheck:Reset()
	self.super.Reset(self)
	self:CancelScheduledEvent("GridStatusReadyCheck_Clear")
	self:ClearStatus()
end

function GridStatusReadyCheck:GainStatus(guid, key, settings)
	local status = readystatus[key]
	self.core:SendStatusGained(guid, "ready_check",
		settings.priority,
		nil,
		settings.colors[key],
		status.text,
		nil,
		nil,
		status.icon)
end

function GridStatusReadyCheck:READY_CHECK(originator)
	local settings = self.db.profile.ready_check
	if settings.enable and (self.raidAssist or IsPartyLeader()) then
		local GridRoster = Grid:GetModule("GridRoster")
		self:CancelScheduledEvent("GridStatusReadyCheck_Clear")
		self.readyChecking = true
		local originatorguid = GridRoster:GetGUIDByFullName(originator)
		for guid in GridRoster:IterateRoster() do
			if not GridRoster:GetOwnerUnitidByGUID(guid) then
				if guid ~= originatorguid then
					self:GainStatus(guid, "waiting", settings)
				else
					self:GainStatus(guid, "ready", settings)
				end
			end
		end
	end
end

function GridStatusReadyCheck:READY_CHECK_CONFIRM(unit, confirm)
	local settings = self.db.profile.ready_check
	if settings.enable and self.readyChecking then
		local guid = UnitGUID(unit)
		if confirm then
			self:GainStatus(guid, "ready", settings)
		else
			self:GainStatus(guid, "not_ready", settings)
		end
	end
end

function GridStatusReadyCheck:READY_CHECK_FINISHED()
	local settings = self.db.profile.ready_check
	if settings.enable then
		local afk = {}
		for guid, status, statusTbl in self.core:CachedStatusIterator("ready_check") do
			if statusTbl.texture == READY_CHECK_WAITING_TEXTURE then
			   afk[guid] = true
			end
		end
		for guid in pairs(afk) do
			self:GainStatus(guid, "afk", settings)
		end
		self:ScheduleEvent("GridStatusReadyCheck_Clear", self.ClearStatus, settings.delay or 0, self)
	end
end

function GridStatusReadyCheck:PARTY_LEADER_CHANGED()
	-- If you change party leader, you may not receive the READY_CHECK_FINISHED event.
	self:CheckClearStatus()
end

function GridStatusReadyCheck:RAID_ROSTER_UPDATE()
	-- If you lose raid assist, you may not receive the READY_CHECK_FINISHED event.
	if GetNumRaidMembers() > 0 then
		local newAssist = IsRaidLeader() or IsRaidOfficer()
		if self.readyChecking and newAssist ~= self.raidAssist then
			self:ScheduleEvent("GridStatusReadyCheck_Clear", self.ClearStatus, 0, self)
		end
		self.raidAssist = newAssist
	else
		self.raidAssist = nil
	end
end

function GridStatusReadyCheck:Grid_PartyTransition(current_state, old_state)
	-- If you leave the group, you may not receive the READY_CHECK_FINISHED event.
	self:CheckClearStatus()
end

function GridStatusReadyCheck:CheckClearStatus()
	-- Unfortunately, GetReadyCheckTimeLeft() only returns integral values.
	if self.readyChecking and GetReadyCheckTimeLeft() == 0 then
		self:ScheduleEvent("GridStatusReadyCheck_Clear", self.ClearStatus, 0, self)
	end
end

function GridStatusReadyCheck:ClearStatus()
	self.readyChecking = nil
	self.core:SendStatusLostAllUnits("ready_check")
end
