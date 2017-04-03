local Totems = IceCore_CreateClass(IceElement)

-- the below block is copied from TotemFrame.lua
local FIRE_TOTEM_SLOT = 1;
local EARTH_TOTEM_SLOT = 2;
local WATER_TOTEM_SLOT = 3;
local AIR_TOTEM_SLOT = 4;

local MAX_TOTEMS = 4;

local TOTEM_PRIORITIES =
{
	AIR_TOTEM_SLOT,
	WATER_TOTEM_SLOT,
	EARTH_TOTEM_SLOT,
	FIRE_TOTEM_SLOT
};

-- setup the names to be more easily readable
Totems.prototype.totemNames = {
	[FIRE_TOTEM_SLOT] = "Fire",
	[EARTH_TOTEM_SLOT] = "Earth",
	[WATER_TOTEM_SLOT] = "Water",
	[AIR_TOTEM_SLOT] = "Air",
}

Totems.prototype.totemSize = 25
Totems.prototype.numTotems = MAX_TOTEMS

-- Constructor --
function Totems.prototype:init()
	Totems.super.prototype.init(self, "Totems")
--[[
	self:SetDefaultColor("Totems"..self.totemNames[FIRE_TOTEM_SLOT], 0, 0, 0)
	self:SetDefaultColor("Totems"..self.totemNames[EARTH_TOTEM_SLOT], 0, 0, 0)
	self:SetDefaultColor("Totems"..self.totemNames[WATER_TOTEM_SLOT], 0, 255, 255)
	self:SetDefaultColor("Totems"..self.totemNames[AIR_TOTEM_SLOT], 204, 26, 255)--]]
	self.scalingEnabled = true
end
-- 'Public' methods -----------------------------------------------------------


-- OVERRIDE
function Totems.prototype:GetOptions()
	local opts = Totems.super.prototype.GetOptions(self)

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
		max = 300,
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
		order = 31
	}
--[[
	opts["hideBlizz"] = {
		type = "toggle",
		name = "Hide Blizzard Frame",
		desc = "Hides Blizzard Rune frame and disables all events related to it",
		get = function()
			return self.moduleSettings.hideBlizz
		end,
		set = function(info, value)
			self.moduleSettings.hideBlizz = value
			if (value) then
				self:HideBlizz()
			else
				self:ShowBlizz()
			end
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 32
	}
--]]
	opts["displayMode"] = {
		type = 'select',
		name = 'Totem orientation',
		desc = 'Whether the totems should draw side-by-side or on top of one another',
		get = function(info)
			return IceHUD:GetSelectValue(info, self.moduleSettings.displayMode)
		end,
		set = function(info, v)
			self.moduleSettings.displayMode = info.option.values[v]
			self:Redraw()
		end,
		values = { "Horizontal", "Vertical" },
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 35
	}
--[[
	opts["cooldownMode"] = {
		type = 'select',
		name = 'Totem cooldown mode',
		desc = 'Choose whether the totems use a cooldown-style wipe or simply an alpha fade to show availability.',
		get = function(info)
			return IceHUD:GetSelectValue(info, self.moduleSettings.cooldownMode)
		end,
		set = function(info, v)
			self.moduleSettings.cooldownMode = info.option.values[v]
			self:Redraw()
		end,
		values = { "Cooldown" }, -- "Alpha" not supported?
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 36
	}
]]--
	opts["totemGap"] = {
		type = 'range',
		name = 'Totem gap',
		desc = 'Spacing between each totem (only works for graphical mode)',
		min = 0,
		max = 100,
		step = 1,
		get = function()
			return self.moduleSettings.totemGap
		end,
		set = function(info, v)
			self.moduleSettings.totemGap = v
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 34.1
	}

	return opts
end

-- OVERRIDE
function Totems.prototype:GetDefaultSettings()
	local defaults =  Totems.super.prototype.GetDefaultSettings(self)

	defaults["vpos"] = 0
	defaults["hpos"] = 10
	defaults["totemFontSize"] = 20
	defaults["totemMode"] = "Graphical"
	defaults["usesDogTagStrings"] = false
	defaults["hideBlizz"] = true
	defaults["alwaysFullAlpha"] = false
	defaults["displayMode"] = "Horizontal"
	defaults["cooldownMode"] = "Cooldown"
	defaults["totemGap"] = 0

	return defaults
end

-- OVERRIDE
function Totems.prototype:Redraw()
	Totems.super.prototype.Redraw(self)

	self:CreateFrame()
end

-- OVERRIDE
function Totems.prototype:Enable(core)
	Totems.super.prototype.Enable(self, core)

	self:RegisterEvent("PLAYER_TOTEM_UPDATE", "UpdateTotem");
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "ResetTotemAvailability");

	if self.moduleSettings.hideBlizz then
		self:HideBlizz()
	end
end

function Totems.prototype:Disable(core)
	Totems.super.prototype.Disable(self, core)

	if self.moduleSettings.hideBlizz then
		self:ShowBlizz()
	end
end

function Totems.prototype:ResetTotemAvailability()
	for i=1, self.numTotems do
		self:UpdateTotem(nil, totem)
	end
end

function Totems.prototype:UpdateTotem(event, totem, ...)
	if not totem or tonumber(totem) ~= totem or totem < 1 or totem > self.numTotems then
		return
	end
	local thisTotemName = self.totemNames[TOTEM_PRIORITIES[totem]]
	local haveTotem, name, startTime, duration, icon = GetTotemInfo(totem);
	if duration > 0 then
		self.frame.graphical[totem].totem:SetTexture(icon)
		self.frame.graphical[totem].cd:SetCooldown(startTime, duration)
		self.frame.graphical[totem].cd:Show()
		self.frame.graphical[totem]:Show()
	else
		self.frame.graphical[totem].cd:Hide()
		self.frame.graphical[totem]:Hide()
	end
end

-- 'Protected' methods --------------------------------------------------------

-- OVERRIDE
function Totems.prototype:CreateFrame()
	Totems.super.prototype.CreateFrame(self)

	self.frame:SetFrameStrata("BACKGROUND")
	self.frame:SetWidth(self.totemSize*self.numTotems)
	self.frame:SetHeight(1)
	self.frame:ClearAllPoints()
	self.frame:SetPoint("TOP", self.parent, "BOTTOM", self.moduleSettings.hpos, self.moduleSettings.vpos)

	self:CreateTotemFrame()
end

function Totems.prototype:CreateTotemFrame()
	self.frame.numeric = self:FontFactory(self.moduleSettings.totemFontSize, nil, self.frame.numeric)

	self.frame.numeric:SetWidth(50)
	self.frame.numeric:SetJustifyH("CENTER")

	self.frame.numeric:SetPoint("TOP", self.frame, "TOP", 0, 0)
	self.frame.numeric:Hide()

	if (not self.frame.graphical) then
		self.frame.graphical = {}
	end

	local totemType
	for i=1, self.numTotems do
		slot = TOTEM_PRIORITIES[i]
		self:CreateTotem(slot,  self.totemNames[slot])
	end
end

function Totems.prototype:GetAlphaAdd()
	return 0.15
end

function Totems.prototype:ShowBlizz()
	TotemFrame:Show()
	TotemFrame:GetScript("OnLoad")(TotemFrame)
end


function Totems.prototype:HideBlizz()
	TotemFrame:Hide()
	TotemFrame:UnregisterAllEvents()
end

function Totems.prototype:TargetChanged()
	Totems.super.prototype.TargetChanged(self)
	-- sort of a hack fix...if "ooc" alpha is set to 0, then the runes frame is all jacked up when the user spawns in
	-- need to re-run CreateFrame in order to setup the frame properly. not sure why :(
	self:Redraw()
end

function Totems.prototype:InCombat()
	Totems.super.prototype.InCombat(self)
	self:Redraw()
end

function Totems.prototype:OutCombat()
	Totems.super.prototype.OutCombat(self)
	self:Redraw()
end

function Totems.prototype:CheckCombat()
	Totems.super.prototype.CheckCombat(self)
	self:Redraw()
end

function Totems.prototype:CreateTotem(i, name)
	-- whiskey tango foxtrot?! apparently arenas can cause this? I can't test out the real cause myself, so putting in a stopgap for now
	if not name then
		return
	end
	local haveTotem, name, startTime, duration, icon = GetTotemInfo(i)
	local bWasNewFrame = false
	if (not self.frame.graphical[i]) then
		self.frame.graphical[i] = CreateFrame("Frame", nil, self.frame)
		self.frame.graphical[i].totem = self.frame.graphical[i]:CreateTexture(nil, "LOW")
		self.frame.graphical[i].cd = CreateFrame("Cooldown", nil, self.frame.graphical[i], "CooldownFrameTemplate")
		self.frame.graphical[i].shine = self.frame.graphical[i]:CreateTexture(nil, "OVERLAY")

		self.frame.graphical[i].totem:SetTexture(icon)
		self.frame.graphical[i].totem:SetAllPoints(self.frame.graphical[i])
		bWasNewFrame = true
	end

	self.frame.graphical[i]:SetFrameStrata("BACKGROUND")
	self.frame.graphical[i]:SetWidth(self.totemSize)
	self.frame.graphical[i]:SetHeight(self.totemSize)

	if self.moduleSettings.displayMode == "Horizontal" then
		self.frame.graphical[i]:SetPoint("TOPLEFT", (i-1) * (self.totemSize-(MAX_TOTEMS - 1)) + (i-1) + ((i-1) * self.moduleSettings.totemGap), 0)
	else
		self.frame.graphical[i]:SetPoint("TOPLEFT", 0, -1 * ((i-1) * (self.totemSize-(MAX_TOTEMS - 1)) + (i-1) + ((i-1) * self.moduleSettings.totemGap)))
	end



	self.frame.graphical[i].cd:SetFrameStrata("BACKGROUND")
	self.frame.graphical[i].cd:SetFrameLevel(self.frame.graphical[i]:GetFrameLevel()+1)
	self.frame.graphical[i].cd:ClearAllPoints()
	self.frame.graphical[i].cd:SetAllPoints(self.frame.graphical[i])
	if duration > 0 then
		self.frame.graphical[i].cd:SetCooldown(startTime, duration)
		self.frame.graphical[i].cd:Show()
		self.frame.graphical[i]:Show()
	end

	self.frame.graphical[i].shine:SetTexture("Interface\\ComboFrame\\ComboPoint")
	self.frame.graphical[i].shine:SetBlendMode("ADD")
	self.frame.graphical[i].shine:SetTexCoord(0.5625, 1, 0, 1)
	self.frame.graphical[i].shine:ClearAllPoints()
	self.frame.graphical[i].shine:SetPoint("CENTER", self.frame.graphical[i], "CENTER")
	self.frame.graphical[i].shine:SetWidth(self.totemSize + 25)
	self.frame.graphical[i].shine:SetHeight(self.totemSize + 10)
	self.frame.graphical[i].shine:Hide()

	self.frame.graphical[i]:EnableMouse(true)
	self.frame.graphical[i].slot = i;
	self.frame.graphical[i]:SetScript("OnEnter", function(button) GameTooltip:SetOwner(button); GameTooltip:SetTotem(button.slot) end)
	self.frame.graphical[i]:SetScript("OnLeave", function() GameTooltip:Hide() end)
	-- it looks like HookScript will continue to add handlers every time instead of replacing them like SetScript
	if (bWasNewFrame) then
		self.frame.graphical[i]:HookScript("OnMouseUp", function (self, mouseButton)
			if ( mouseButton == "RightButton" ) then
				DestroyTotem(self.slot);
			end
		end)
	end

end

-- Load us up
local _, unitClass = UnitClass("player")
if (unitClass == "SHAMAN") then
	IceHUD.Totems = Totems:new()
end
