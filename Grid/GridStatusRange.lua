--[[--------------------------------------------------------------------
	GridStatusRange.lua
	GridStatus module for tracking unit range.
	Created by neXter, modified by Pastamancer.
----------------------------------------------------------------------]]--

local _, ns = ...
local L = ns.L

local GridRange = Grid:GetModule("GridRange")
local GridRoster = Grid:GetModule("GridRoster")

local GridStatusRange = Grid:GetModule("GridStatus"):NewModule("GridStatusRange", "AceEvent-2.0")
GridStatusRange.menuName = L["Range"]

-- ranges to check
local ranges = {}
-- table, map range to status name
local ranges_status = {}
-- table, map range to check function
local ranges_check = {}

local function statusForRange(range)
    return ("alert_range_%d"):format(range)
end

GridStatusRange.defaultDB = {
    debug = false,
    frequency = 0.5,
    -- per-status defaults are setup by RegisterStatusForRange
}

GridStatusRange.extraOptions = {
    ["frequency"] = {
		type = 'range',
		name = L["Range check frequency"],
		desc = L["Seconds between range checks"],
		get = function() return GridStatusRange.db.profile.frequency end,
		set = function(v)
				GridStatusRange.db.profile.frequency = v
				GridStatusRange:UpdateFrequency()
			end,
		min = 0.1,
		max = 5,
		step = 0.1,
		isPercent = false,
		order = -1,
    },
}

function GridStatusRange:OnInitialize()
    self.super.OnInitialize(self)
end

function GridStatusRange:EnabledStatusCount()
	local enable_count = 0

	for status, settings in pairs(self.db.profile) do
		if type(settings) == "table" and settings.enable then
			enable_count = enable_count + 1
		end
	end

	return enable_count
end

function GridStatusRange:OnEnable()
    self:Grid_RangesUpdated()
    self:RegisterEvent("Grid_RangesUpdated")
    self:UpdateFrequency()
end

function GridStatusRange:OnDisable()
	self:CancelScheduledEvent("GridStatusRange_RangeCheck")
end

function GridStatusRange:Reset()
	self:OnDisable()
	self:OnEnable()
end

function GridStatusRange:EnableRange(range)
	if not ranges_status[range] then
		ranges[#ranges + 1] = range
		table.sort(ranges)

		ranges_status[range] = statusForRange(range)
		ranges_check[range] = GridRange:GetRangeCheck(range)

		self:UpdateFrequency()
	end
end

function GridStatusRange:DisableRange(range)
	for k,v in ipairs(ranges) do
		if v == range then
			table.remove(ranges, k)
			break
		end
	end

	local status = ranges_status[range]
	ranges_status[range] = nil
	ranges_check[range] = nil

	self:UpdateFrequency()

	if not status then
		return
	end

	self.core:SendStatusLostAllUnits(status)
end

function GridStatusRange:Grid_RangesUpdated()
	ranges = {}
	ranges_status = {}
	ranges_check = {}

	for r in GridRange:AvailableRangeIterator() do
		self:RegisterStatusForRange(r)
	end
end

function GridStatusRange:RegisterStatusForRange(range)
    local status_name = statusForRange(range)
    local status_desc = L["More than %d yards away"]:format(range)

    local settings = self.db.profile[status_name]

    -- create default settings if none exist
    if not settings then
		local enabled = true

		if range == 10 or range == 100 then
			enabled = false
		elseif range < 40 and GridRange:GetRangeCheck(40) then
			enabled = false
		end

		settings = {
			["text"] = L["%d yards"]:format(range),
			["desc"] = status_desc,
			["enable"] = enabled,
			["priority"] = 80 + floor((range + 2) * .1),
			["range"] = false,
			["color"] = {
				r = (range % 100) / 100,
				g = ((range * 2) % 100) / 100,
				b = ((range * 3) % 100) / 100,
				a = 1 - (range % 51) / 55,
			},
		}

		self.db.profile[status_name] = settings
    end

    if not self.core:IsStatusRegistered(status_name) then
		-- don't register 28 yards if we have a 30 yard check
		-- this prevents melee settings from conflicting with
		-- ranged/healer settings in the same profile
		if range == 28 and GridRange:GetRangeCheck(30) then
			return
		end
		-- ditto for 38 yards if we have a 40 yard check
		if range == 38 and GridRange:GetRangeCheck(40) then
			return
		end

		-- override some of the default options
		local options = {
			["range"] = false,
			["enable"] = {
				type = "toggle",
				name = L["Enable"],
				desc = string.format(L["Enable %s"], status_desc),
				order = 112,
				get = function ()
						return GridStatusRange.db.profile[status_name].enable
					end,
				set = function (v)
						GridStatusRange.db.profile[status_name].enable = v
						if v then
							GridStatusRange:EnableRange(range)
						else
							GridStatusRange:DisableRange(range)
						end
					end,
			},
			["text"] = {
				type = "text",
				name = L["Text"],
				desc = L["Text to display on text indicators"],
				order = 113,
				usage = L["<range>"],
				get = function ()
						return GridStatusRange.db.profile[status_name].text
					end,
				set = function (v)
						GridStatusRange.db.profile[status_name].text = v
					end,
			},
		}

		self:RegisterStatus(status_name, status_desc, options, false, range)
    end

    if settings.enable then
		self:EnableRange(range)
    else
		self:DisableRange(range)
    end
end

-- this is used if only one range is enabled
function GridStatusRange:SimpleRangeCheck()
	local range = ranges[1]
	local check = ranges_check[range]
	local status_name = ranges_status[range]
	local settings = self.db.profile[status_name]

	for guid, unitid in GridRoster:IterateRoster() do
		local unit_range

		if check(unitid) then
			unit_range = range
		else
			if (UnitIsDead(unitid) or not UnitCanAssist("player", unitid)) then
				unit_range = GridRange:GetUnitRange(unitid)
			end
			if not unit_range then
				unit_range = 100000
			end
		end

		if unit_range > range then
			self.core:SendStatusGained(guid, status_name,
				settings.priority, false,
				settings.color,
				settings.text)
		else
			self.core:SendStatusLost(guid, status_name)
		end
	end
end

-- this is used if multiple ranges are enabled
function GridStatusRange:RangeCheck()
	for guid, unitid in GridRoster:IterateRoster() do
		local unit_range

		for _, range in ipairs(ranges) do
			if ranges_check[range](unitid) then
				unit_range = range
				break
			end
		end

		if not unit_range and (UnitIsDead(unitid) or not UnitCanAssist("player", unitid)) then
			unit_range = GridRange:GetUnitRange(unitid)
		end

		if not unit_range then
			unit_range = 100000
		end

		for range, status_name in pairs(ranges_status) do
			local settings = self.db.profile[status_name]

			if unit_range > range then
				self.core:SendStatusGained(guid, status_name,
					settings.priority, false,
					settings.color,
					settings.text)
			else
				self.core:SendStatusLost(guid, status_name)
			end
		end
	end
end

function GridStatusRange:UpdateFrequency()
    self:CancelScheduledEvent("GridStatusRange_RangeCheck")

	local num_ranges = #ranges

    -- don't schedule the event if we don't have any ranges to check
	if num_ranges == 0 then
		self:Debug("No ranges enabled")
		return
	elseif num_ranges == 1 then
		self:Debug("Using SimpleRangeCheck")
		self:ScheduleRepeatingEvent("GridStatusRange_RangeCheck",
			self.SimpleRangeCheck,
			self.db.profile.frequency, self)
	else
		self:Debug("Using RangeCheck")
		self:ScheduleRepeatingEvent("GridStatusRange_RangeCheck",
			self.RangeCheck,
			self.db.profile.frequency, self)
	end
end
