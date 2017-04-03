local SML = LibStub("LibSharedMedia-3.0")

IceElement = IceCore_CreateClass()

IceElement.TexturePath = IceHUD.Location .. "\\textures\\"

-- Protected variables --
IceElement.prototype.elementName = nil
IceElement.prototype.parent = nil
IceElement.prototype.frame = nil

IceElement.prototype.defaultColors = {} -- Shared table for all child classes to save some memory
IceElement.prototype.alpha = nil
IceElement.prototype.backroundAlpha = nil

IceElement.prototype.combat = nil
IceElement.prototype.target = nil

IceElement.settings = nil
IceElement.moduleSettings = nil

IceElement.prototype.configColor = "ff8888ff"
IceElement.prototype.scalingEnabled = nil

IceElement.prototype.bIsVisible = true

-- Constructor --
-- IceElements are to be instantiated before IceCore is loaded.
-- Therefore we can wait for IceCore to load and then register our
-- module to the core with another event.
function IceElement.prototype:init(name, skipRegister)
	assert(name, "IceElement must have a name")

	self.elementName = name
	self.alpha = 1
	self.scalingEnabled = false

	-- Some common colors
	self:SetDefaultColor("Text", 1, 1, 1)
	self:SetDefaultColor("undef", 0.7, 0.7, 0.7)

	LibStub("AceEvent-3.0"):Embed(self)
	LibStub("AceTimer-3.0"):Embed(self)

	if skipRegister ~= true then
		IceHUD:Register(self)
	end
end


-- 'Public' methods -----------------------------------------------------------

function IceElement.prototype:ToString()
	return "IceElement('" .. self.elementName .. "')"
end


function IceElement.prototype:GetElementName()
	return self.elementName
end


function IceElement.prototype:Create(parent)
	assert(parent, "IceElement 'parent' can't be nil")

	self.parent = parent
	self:CreateFrame()
	self:Show(false)
end


function IceElement.prototype:SetDatabase(db)
	self.settings = db
	self.moduleSettings = db.modules[self.elementName]
end


function IceElement.prototype:IsEnabled()
	return self.moduleSettings.enabled
end


function IceElement.prototype:Enable(core)
	if (not core) then
		self.moduleSettings.enabled = true
	end

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "InCombat")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "OutCombat")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "CheckCombat")
	self:RegisterEvent("PLAYER_TARGET_CHANGED", "TargetChanged")

	self:Show(true)
end


function IceElement.prototype:Disable(core)
	if (not core) then
		self.moduleSettings.enabled = false
	end
	self:Show(false, true)
	self:UnregisterAllEvents()
end



-- inherting classes should override this and provide
-- make sure they refresh any changes made to them
function IceElement.prototype:Redraw()

end


-- inheriting classes should override this and provide
-- AceOptions table for configuration
function IceElement.prototype:GetOptions()
	local opts = {}

	opts["enabled"] = {
		type = "toggle",
		name = "Enabled",
		desc = "Enable/disable module",
		get = function()
			return self.moduleSettings.enabled
		end,
		set = function(info, value)
			self.moduleSettings.enabled = value
			if (value) then
				self:Enable(true)
			else
				self:Disable()
			end
		end,
		order = 20
	}

	opts["headerVisibility"] = {
		type = 'header',
		name = 'Visibility Settings',
		order = 27
	}

	opts["scale"] =
	{
		type = 'range',
		name = "Scale",
		desc = 'Scale of the element',
		min = 0.2,
		max = 2,
		step = 0.1,
		isPercent = true,
		hidden = not self.scalingEnabled,
		get = function()
			return self.moduleSettings.scale
		end,
		set = function(info, value)
			self.moduleSettings.scale = value
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 27.1
	}

	opts["alwaysFullAlpha"] =
	{
		type = 'toggle',
		name = 'Always show at 100% alpha',
		desc = 'Whether to always show this module at 100% alpha or not',
		width = 'double',
		get = function()
			return self.moduleSettings.alwaysFullAlpha
		end,
		set = function(info, value)
			self.moduleSettings.alwaysFullAlpha = value
			self:Update(self.unit)
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 27.5
	}

	return opts
end



-- inheriting classes should override this and provide
-- default settings to populate db
function IceElement.prototype:GetDefaultSettings()
	local defaults = {}
	defaults["enabled"] = true
	defaults["scale"] = 1
	defaults["alwaysFullAlpha"] = false
	return defaults
end



-- 'Protected' methods --------------------------------------------------------

-- This should be overwritten by inheriting classes
function IceElement.prototype:CreateFrame()
	if not (self.frame) then
		self.frame = CreateFrame("Frame", "IceHUD_"..self.elementName, self.parent)
	end

	self.frame:SetScale(self.moduleSettings.scale)

	self:UpdateAlpha()
end


function IceElement.prototype:UpdateAlpha()
	if self.moduleSettings.alwaysFullAlpha then
		self.alpha = 1
		self.frame:SetAlpha(1)
		return
	end

	self.alpha = self.settings.alphaooc
	if (self.combat) then
		self.alpha = self.settings.alphaic
		self.backgroundAlpha = self.settings.alphaicbg
	elseif (self.target) then
		self.alpha = self.settings.alphaTarget
		self.backgroundAlpha = self.settings.alphaTargetbg
	elseif (self:UseTargetAlpha(scale)) then
		self.alpha = self.settings.alphaNotFull
		self.backgroundAlpha = self.settings.alphaNotFullbg
	else
		self.alpha = self.settings.alphaooc
		self.backgroundAlpha = self.settings.alphaoocbg
	end

	if self.alpha ~= 0 then
		self.alpha = math.min(1, self.alpha + self:GetAlphaAdd())
	end

	self.frame:SetAlpha(self.alpha)
end

-- use this to add some value to alpha every time. if you always want an element to be slightly brighter than the actual alpha for visibility
function IceElement.prototype:GetAlphaAdd()
	return 0
end


function IceElement.prototype:GetColors()
	return self.settings.colors
end


function IceElement.prototype:GetColor(color, alpha)
	if not (color) then
		return 1, 1, 1, 1
	end

	if not (alpha) then
		alpha = self.alpha
	end

	if not (self.settings.colors[color]) then
		local r, g, b = self:GetClassColor(color)
		return r, g, b, alpha
	end

	return self.settings.colors[color].r, self.settings.colors[color].g, self.settings.colors[color].b, alpha
end


function IceElement.prototype:GetHexColor(color, alpha)
	local r, g, b, a = self:GetColor(color)
	return string.format("%02x%02x%02x%02x", a * 255, r * 255, g * 255, b * 255)
end


function IceElement.prototype:SetColor(color, red, green, blue)
	if (red > 1) then
		red = red / 255
	end
	if (green > 1) then
		green = green / 255
	end
	if (blue > 1) then
		blue = blue / 255
	end
	self.settings.colors[color] = {r = red, g = green, b = blue}
end


function IceElement.prototype:SetDefaultColor(color, red, green, blue)
	if (red > 1) then
		red = red / 255
	end
	if (green > 1) then
		green = green / 255
	end
	if (blue > 1) then
		blue = blue / 255
	end

	self.defaultColors[color] = {r = red, g = green, b = blue}
end


function IceElement.prototype:GetClassColor(class)
	if type(class) == "table" then
		local r,g,b = class
		if r and g and b then
			return r, g, b
		else
			return CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS["WARRIOR"] or RAID_CLASS_COLORS["WARRIOR"]
		end
	elseif type(class) == "function" then
		return
	end

	class = class:upper()
	if CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] then
		return CUSTOM_CLASS_COLORS[class].r, CUSTOM_CLASS_COLORS[class].g, CUSTOM_CLASS_COLORS[class].b
	elseif RAID_CLASS_COLORS and RAID_CLASS_COLORS[class] then
		return RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b
	else
		-- crazy talk...who the crap wouldn't have a blizzard-defined global defined?
		return 1,1,1
	end
end


function IceElement.prototype:ConvertToHex(color)
	return string.format("ff%02x%02x%02x", color.r*255, color.g*255, color.b*255)
end


function IceElement.prototype:FontFactory(size, frame, font, flags)
	if not (frame) then
		frame = self.frame
	end

	local fontString = nil
	if not (font) then
		fontString = frame:CreateFontString()
	else
		fontString = font
	end

	fontString:SetFont(SML:Fetch('font', self.settings.fontFamily), size, flags)
	if not (flags) then
		fontString:SetShadowColor(0, 0, 0, 1)
		fontString:SetShadowOffset(1, -1)
	end

	return fontString
end


function IceElement.prototype:UseTargetAlpha(scale)
	return false
end


function IceElement.prototype:Update()
	self:UpdateAlpha()
end


function IceElement.prototype:IsVisible()
	return self.bIsVisible
end

function IceElement.prototype:Show(bShouldShow)
	if self.bIsVisible == bShouldShow then
		return
	end

	self.bIsVisible = bShouldShow

	if not bShouldShow then
		self.frame:Hide()
	else
		self.frame:Show()
	end
end


-- Combat event handlers ------------------------------------------------------

function IceElement.prototype:InCombat()
	self.combat = true
	self:Update(self.unit)
end


function IceElement.prototype:OutCombat()
	self.combat = false
	self:Update(self.unit)
end


function IceElement.prototype:CheckCombat()
	self.combat = UnitAffectingCombat("player")
	self.target = UnitExists("target")
	self:Update(self.unit)
end


function IceElement.prototype:TargetChanged()
	self.target = UnitExists("target")
	self:Update(self.unit)
end



-- Inherited classes should just instantiate themselves and let
-- superclass to handle registration to the core
-- IceInheritedClass:new()
