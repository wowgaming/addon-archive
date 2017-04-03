local RangeCheck = IceCore_CreateClass(IceElement)
RangeCheck.prototype.scheduledEvent = nil

local LibRange = nil
local DogTag = nil

-- Constructor --
function RangeCheck.prototype:init()
	RangeCheck.super.prototype.init(self, "RangeCheck")

	self.scalingEnabled = true

	LibRange = LibStub("LibRangeCheck-2.0", true)
end

function RangeCheck.prototype:Enable(core)
	RangeCheck.super.prototype.Enable(self, core)

	if IceHUD.IceCore:ShouldUseDogTags() then
		DogTag = LibStub("LibDogTag-3.0", true)
		self:RegisterFontStrings()
	else
		self.scheduledEvent = self:ScheduleRepeatingTimer("UpdateRange", 0.1)
	end
end

function RangeCheck.prototype:Disable(core)
	RangeCheck.super.prototype.Disable(self, core)

	if DogTag then
		self:UnregisterFontStrings()
	else
		self:CancelTimer(self.scheduledEvent, true)
	end
end

function RangeCheck.prototype:GetDefaultSettings()
	local defaults =  RangeCheck.super.prototype.GetDefaultSettings(self)

	defaults["rangeString"] = "Range: [HostileColor Range]"
	defaults["vpos"] = 220
	defaults["hpos"] = 0
	defaults["enabled"] = false

	return defaults
end

function RangeCheck.prototype:GetOptions()
	local opts = RangeCheck.super.prototype.GetOptions(self)

	opts["vpos"] = {
		type = "range",
		name = "Vertical Position",
		desc = "Vertical Position",
		get = function()
			return self.moduleSettings.vpos
		end,
		set = function(info, v)
			self.moduleSettings.vpos = v
			self:Redraw()
		end,
		min = -300,
		max = 600,
		step = 1,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 31
	}

	opts["hpos"] = {
		type = "range",
		name = "Horizontal Position",
		desc = "Horizontal Position",
		get = function()
			return self.moduleSettings.hpos
		end,
		set = function(info, v)
			self.moduleSettings.hpos = v
			self:Redraw()
		end,
		min = -500,
		max = 500,
		step = 1,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 32
	}

	opts["rangeString"] = {
		type = 'input',
		name = 'Range string',
		desc = 'DogTag-formatted string to use for the range display (only available if LibDogTag is being used)\n\nType /dogtag for a list of available tags',
		get = function()
			return self.moduleSettings.rangeString
		end,
		set = function(info, v)
			v = DogTag:CleanCode(v)
			self.moduleSettings.rangeString = v
			self:RegisterFontStrings()
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled or not DogTag or not LibRange
		end,
		usage = '',
		order = 33
	}

	return opts
end

function RangeCheck.prototype:Redraw()
	RangeCheck.super.prototype.Redraw(self)

	if (self.moduleSettings.enabled) then
		self:CreateFrame(true)
	end
end

function RangeCheck.prototype:CreateFrame(redraw)
	if not (self.frame) then
		self.frame = CreateFrame("Frame", "IceHUD_"..self.elementName, self.parent)
	end

	self.frame:SetScale(self.moduleSettings.scale)
	self.frame:SetFrameStrata("BACKGROUND")
	self.frame:SetWidth(200)
	self.frame:SetHeight(32)
	self.frame:ClearAllPoints()
	self.frame:SetPoint("TOP", self.parent, "TOP", self.moduleSettings.hpos, self.moduleSettings.vpos)

	self.frame.rangeFontString = self:FontFactory(--[[self.moduleSettings.fontSize+1]] 13, nil, self.frame.rangeFontString)
	self.frame.rangeFontString:SetJustifyH("CENTER")
	self.frame.rangeFontString:SetJustifyV("TOP")
	self.frame.rangeFontString:SetAllPoints(self.frame)
end

function RangeCheck.prototype:RegisterFontStrings()
	if DogTag and LibRange then
		DogTag:AddFontString(self.frame.rangeFontString, self.frame, self.moduleSettings.rangeString, "Unit", { unit = "target" })
		DogTag:UpdateAllForFrame(self.frame)
	end
end

function RangeCheck.prototype:UnregisterFontStrings()
	if DogTag then
		DogTag:RemoveFontString(self.frame.rangeFontString)
	end
end

-- this function is called every 0.1 seconds only if LibDogTag is not being used
function RangeCheck.prototype:UpdateRange()
	if LibRange and UnitExists("target") then
		local min, max = LibRange:getRange("target")
		if min then
			if max then
				self.frame.rangeFontString:SetText("Range: " .. min .. " - " .. max)
			else
				self.frame.rangeFontString:SetText("Range: " .. min .. "+")
			end
		else
			self.frame.rangeFontString:SetText("Unknown")
		end

		self.frame.rangeFontString:SetWidth(0)
	else
		self.frame.rangeFontString:SetText()
	end
end

IceHUD.RangeCheck = RangeCheck:new()
