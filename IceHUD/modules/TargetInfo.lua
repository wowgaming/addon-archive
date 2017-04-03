IceTargetInfo = IceCore_CreateClass(IceElement)

local DogTag = nil

local internal = "internal"

local ValidAnchors = { "TOPLEFT", "TOPRIGHT", "BOTTOMLEFT", "BOTTOMRIGHT", "CENTER" }

IceTargetInfo.prototype.unit = "target"

IceTargetInfo.prototype.buffSize = nil
IceTargetInfo.prototype.ownBuffSize = nil
IceTargetInfo.prototype.width = nil

IceTargetInfo.prototype.name = nil
IceTargetInfo.prototype.guild = nil
IceTargetInfo.prototype.realm = nil
IceTargetInfo.prototype.classLocale = nil
IceTargetInfo.prototype.classEnglish = nil
IceTargetInfo.prototype.leader = nil

IceTargetInfo.prototype.targetCombat = nil
IceTargetInfo.prototype.pvp = nil
IceTargetInfo.prototype.level = nil
IceTargetInfo.prototype.classification = nil
IceTargetInfo.prototype.reaction = nil
IceTargetInfo.prototype.tapped = nil

IceTargetInfo.prototype.isPlayer = nil


-- Constructor --
function IceTargetInfo.prototype:init(moduleName, unit)
	self.unit = unit or "target"

	if not moduleName or not unit then
		IceTargetInfo.super.prototype.init(self, "TargetInfo")
	else
		IceTargetInfo.super.prototype.init(self, moduleName)
	end

	self.scalingEnabled = true
end



-- 'Public' methods -----------------------------------------------------------

-- OVERRIDE
function IceTargetInfo.prototype:Enable(core)
	IceTargetInfo.super.prototype.Enable(self, core)

	if IceHUD.IceCore:ShouldUseDogTags() then
		DogTag = LibStub("LibDogTag-3.0", true)
		if DogTag then
			LibStub("LibDogTag-Unit-3.0")
		end
	end

	self:RegisterEvent("UNIT_AURA", "AuraChanged")

	self:RegisterEvent("UNIT_NAME_UPDATE", "TargetName")
	self:RegisterEvent("UNIT_FACTION", "TargetFaction")
	self:RegisterEvent("UNIT_LEVEL", "TargetLevel")

	self:RegisterEvent("UNIT_FLAGS", "TargetFlags")
	self:RegisterEvent("UNIT_DYNAMIC_FLAGS", "TargetFlags")

	self:RegisterEvent("RAID_TARGET_UPDATE", "UpdateRaidTargetIcon")

	RegisterUnitWatch(self.frame)

	if self.moduleSettings.myTagVersion < IceHUD.CurrTagVersion then
		local origDefaults = self:GetDefaultSettings()

		self.moduleSettings.line1tag = origDefaults["line1tag"]
		self.moduleSettings.line2tag = origDefaults["line2tag"]
		self.moduleSettings.line3tag = origDefaults["line3tag"]
		self.moduleSettings.myTagVersion = IceHUD.CurrTagVersion
	end

	if self.moduleSettings.filterBuffs == nil
		and self.moduleSettings.filterDebuffs == nil
		and self.moduleSettings.filter ~= nil then
		self.moduleSettings.filterBuffs = self.moduleSettings.filter
		self.moduleSettings.filterDebuffs = self.moduleSettings.filter
		self.moduleSettings.filter = nil
	end

	self:RegisterFontStrings()
end


-- OVERRIDE
function IceTargetInfo.prototype:Disable(core)
	IceTargetInfo.super.prototype.Disable(self, core)

	UnregisterUnitWatch(self.frame)

	self:UnregisterFontStrings()
end


-- OVERRIDE
function IceTargetInfo.prototype:GetOptions()
	local opts = IceTargetInfo.super.prototype.GetOptions(self)

	opts["targetInfoHeader"] = {
		type = 'header',
		name = 'Look and Feel',
		order = 30.9
	}

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
		order = 31
	}

	opts["fontSize"] = {
		type = 'range',
		name = 'Font Size',
		desc = 'Font Size',
		get = function()
			return self.moduleSettings.fontSize
		end,
		set = function(info, v)
			self.moduleSettings.fontSize = v
			self:Redraw()
		end,
		min = 8,
		max = 20,
		step = 1,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 32
	}

	opts["stackFontSize"] = {
		type = 'range',
		name = 'Stack Font Size',
		desc = 'Stack Font Size',
		get = function()
			return self.moduleSettings.stackFontSize
		end,
		set = function(info, v)
			self.moduleSettings.stackFontSize = v
			self:RedrawBuffs()
		end,
		min = 8,
		max = 20,
		step = 1,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 32
	}

	opts["zoom"] = {
		type = 'range',
		name = 'Buff zoom',
		desc = 'Buff/debuff icon zoom',
		get = function()
			return self.moduleSettings.zoom
		end,
		set = function(info, v)
			self.moduleSettings.zoom = v
			self:RedrawBuffs()
		end,
		min = 0,
		max = 0.2,
		step = 0.01,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		isPercent = true,
		order = 33
	}

	opts["buffHeader"] = {
		type = 'header',
		name = 'Buff/Debuff Settings',
		order = 33.9
	}

	opts["buffSize"] = {
		type = 'range',
		name = 'Buff size',
		desc = 'Buff/debuff icon size',
		get = function()
			return self.moduleSettings.buffSize
		end,
		set = function(info, v)
			self.moduleSettings.buffSize = v
			self:RedrawBuffs()
		end,
		min = 8,
		max = 30,
		step = 1,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 34
	}

	opts["ownBuffSize"] = {
		type = 'range',
		name = 'Own buff size',
		desc = 'Buff/debuff size for buffs/debuffs that were applied by you, the player',
		get = function()
			return self.moduleSettings.ownBuffSize
		end,
		set = function(info, v)
			self.moduleSettings.ownBuffSize = v
			self:RedrawBuffs()
		end,
		min = 8,
		max = 60,
		step = 1,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 35
	}

	opts["showBuffs"] = {
		type = 'toggle',
		name = 'Show buffs',
		desc = 'Toggles whether or not buffs are displayed at all',
		get = function()
			return self.moduleSettings.showBuffs
		end,
		set = function(info, v)
			self.moduleSettings.showBuffs = v
			self:RedrawBuffs()
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 36
	}

	opts["filterBuffs"] = {
		type = 'select',
		name = 'Only show buffs by me',
		desc = 'Will only show buffs that you cast instead of all buffs active',
		get = function(info)
			return IceHUD:GetSelectValue(info, self.moduleSettings.filterBuffs)
		end,
		set = function(info, v)
			self.moduleSettings.filterBuffs = info.option.values[v]
			self:RedrawBuffs()
		end,
		disabled = function()
			return not self.moduleSettings.enabled or not self.moduleSettings.showBuffs
		end,
		values = { "Never", "In Combat", "Always" },
		order = 36.1
	}

	opts["showDebuffs"] = {
		type = 'toggle',
		name = 'Show debuffs',
		desc = 'Toggles whether or not debuffs are displayed at all',
		get = function()
			return self.moduleSettings.showDebuffs
		end,
		set = function(info, v)
			self.moduleSettings.showDebuffs = v
			self:RedrawBuffs()
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 36.2
	}

	opts["filterDebuffs"] = {
		type = 'select',
		name = 'Only show debuffs by me',
		desc = 'Will only show debuffs that you cast instead of all debuffs active',
		get = function(info)
			return IceHUD:GetSelectValue(info, self.moduleSettings.filterDebuffs)
		end,
		set = function(info, v)
			self.moduleSettings.filterDebuffs = info.option.values[v]
			self:RedrawBuffs()
		end,
		disabled = function()
			return not self.moduleSettings.enabled or not self.moduleSettings.showDebuffs
		end,
		values = { "Never", "In Combat", "Always" },
		order = 36.3
	}

	opts["perRow"] = {
		type = 'range',
		name = 'Buffs / row',
		desc = 'How many buffs/debuffs is shown on each row',
		get = function()
			return self.moduleSettings.perRow
		end,
		set = function(info, v)
			self.moduleSettings.perRow = v
			self:RedrawBuffs()
		end,
		min = 0,
		max = 20,
		step = 1,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 37
	}

	opts["buffLocHeader"] = {
		type = 'header',
		name = 'Buff placement settings',
		order = 37.01
	}

	opts["buffGrowDirection"] = {
		type = 'select',
		name = 'Buff grow direction',
		desc = 'Which direction the buffs should grow from the anchor point',
		values = { "Left", "Right" },
		get = function(info)
			return IceHUD:GetSelectValue(info, self.moduleSettings.buffGrowDirection)
		end,
		set = function(info, v)
			self.moduleSettings.buffGrowDirection = info.option.values[v]
			self:CreateBuffFrame()
		end,
		disabled = function()
			return not self.moduleSettings.enabled or not self.moduleSettings.showBuffs
		end,
		order = 37.1
	}

	opts["buffAnchorTo"] = {
		type = 'select',
		name = 'Buff anchor to',
		desc = 'The point on the TargetInfo frame that the buff frame gets connected to',
		values = ValidAnchors,
		get = function(info)
			return IceHUD:GetSelectValue(info, self.moduleSettings.buffAnchorTo)
		end,
		set = function(info, v)
			self.moduleSettings.buffAnchorTo = info.option.values[v]
			self:CreateBuffFrame()
		end,
		disabled = function()
			return not self.moduleSettings.enabled or not self.moduleSettings.showBuffs
		end,
		order = 37.2
	}

	opts["buffXOffset"] = {
		type = 'range',
		name = 'Buff horizontal offset',
		desc = 'How far horizontally the buff frame should be offset from the anchor',
		min = -500,
		max = 500,
		step = 1,
		get = function()
			return self.moduleSettings.buffOffset['x']
		end,
		set = function(info, v)
			self.moduleSettings.buffOffset['x'] = v
			self:CreateBuffFrame()
		end,
		disabled = function()
			return not self.moduleSettings.enabled or not self.moduleSettings.showBuffs
		end,
		order = 37.3
	}

	opts["buffYOffset"] = {
		type = 'range',
		name = 'Buff vertical offset',
		desc = 'How far vertically the buff frame should be offset from the anchor',
		min = -500,
		max = 500,
		step = 1,
		get = function()
			return self.moduleSettings.buffOffset['y']
		end,
		set = function(info, v)
			self.moduleSettings.buffOffset['y'] = v
			self:CreateBuffFrame()
		end,
		disabled = function()
			return not self.moduleSettings.enabled or not self.moduleSettings.showBuffs
		end,
		order = 37.4
	}

	opts["debuffLocHeader"] = {
		type = 'header',
		name = 'Debuff placement settings',
		order = 37.801
	}

	opts["debuffGrowDirection"] = {
		type = 'select',
		name = 'Debuff grow direction',
		desc = 'Which direction the debuffs should grow from the anchor point',
		values = { "Left", "Right" },
		get = function(info)
			return IceHUD:GetSelectValue(info, self.moduleSettings.debuffGrowDirection)
		end,
		set = function(info, v)
			self.moduleSettings.debuffGrowDirection = info.option.values[v]
			self:CreateDebuffFrame()
		end,
		disabled = function()
			return not self.moduleSettings.enabled or not self.moduleSettings.showDebuffs
		end,
		order = 37.81
	}

	opts["debuffAnchorTo"] = {
		type = 'select',
		name = 'Debuff anchor to',
		desc = 'The point on the TargetInfo frame that the debuff frame gets connected to',
		values = ValidAnchors,
		get = function(info)
			return IceHUD:GetSelectValue(info, self.moduleSettings.debuffAnchorTo)
		end,
		set = function(info, v)
			self.moduleSettings.debuffAnchorTo = info.option.values[v]
			self:CreateDebuffFrame()
		end,
		disabled = function()
			return not self.moduleSettings.enabled or not self.moduleSettings.showDebuffs
		end,
		order = 37.82
	}

	opts["debuffXOffset"] = {
		type = 'range',
		name = 'Debuff horizontal offset',
		desc = 'How far horizontally the debuff frame should be offset from the anchor',
		min = -500,
		max = 500,
		step = 1,
		get = function()
			return self.moduleSettings.debuffOffset['x']
		end,
		set = function(info, v)
			self.moduleSettings.debuffOffset['x'] = v
			self:CreateDebuffFrame()
		end,
		disabled = function()
			return not self.moduleSettings.enabled or not self.moduleSettings.showDebuffs
		end,
		order = 37.83
	}

	opts["debuffYOffset"] = {
		type = 'range',
		name = 'Debuff vertical offset',
		desc = 'How far vertically the debuff frame should be offset from the anchor',
		min = -500,
		max = 500,
		step = 1,
		get = function()
			return self.moduleSettings.debuffOffset['y']
		end,
		set = function(info, v)
			self.moduleSettings.debuffOffset['y'] = v
			self:CreateDebuffFrame()
		end,
		disabled = function()
			return not self.moduleSettings.enabled or not self.moduleSettings.showDebuffs
		end,
		order = 37.84
	}

	opts["mouseHeader"] = {
		type = 'header',
		name = 'Mouse settings',
		order = 37.9
	}

	opts["mouseTarget"] = {
		type = 'toggle',
		name = 'Mouseover for target',
		desc = 'Toggle mouseover on/off for target',
		get = function()
			return self.moduleSettings.mouseTarget
		end,
		set = function(info, v)
			self.moduleSettings.mouseTarget = v
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 38
	}

	opts["mouseBuff"] = {
		type = 'toggle',
		name = 'Mouseover for buffs',
		desc = 'Toggle mouseover on/off for buffs/debuffs',
		get = function()
			return self.moduleSettings.mouseBuff
		end,
		set = function(info, v)
			self.moduleSettings.mouseBuff = v
			self:RedrawBuffs()
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 39
	}

	opts["textHeader"] = {
		type = 'header',
		name = 'Text Settings',
		order = 39.01
	}

	opts["line1Tag"] = {
		type = 'input',
		name = 'Line 1 tag',
		desc = 'DogTag-formatted string to use for the top text line (leave blank to revert to old behavior)\n\nType /dogtag for a list of available tags.\n\nRemember to press Accept after filling out this box or it will not save.',
		get = function()
			return self.moduleSettings.line1Tag
		end,
		set = function(info, v)
			v = DogTag:CleanCode(v)
			self.moduleSettings.line1Tag = v
			self:RegisterFontStrings()
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled or DogTag == nil
		end,
		multiline = true,
		order = 39.1
	}

	opts["line2Tag"] = {
		type = 'input',
		name = 'Line 2 tag',
		desc = 'DogTag-formatted string to use for the second text line (leave blank to revert to old behavior)\n\nType /dogtag for a list of available tags.\n\nRemember to press Accept after filling out this box or it will not save.',
		get = function()
			return self.moduleSettings.line2Tag
		end,
		set = function(info, v)
			v = DogTag:CleanCode(v)
			self.moduleSettings.line2Tag = v
			self:RegisterFontStrings()
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled or DogTag == nil
		end,
		multiline = true,
		order = 39.2
	}

	opts["line3Tag"] = {
		type = 'input',
		name = 'Line 3 tag',
		desc = 'DogTag-formatted string to use for the third text line (leave blank to revert to old behavior)\n\nType /dogtag for a list of available tags.\n\nRemember to press Accept after filling out this box or it will not save.',
		get = function()
			return self.moduleSettings.line3Tag
		end,
		set = function(info, v)
			v = DogTag:CleanCode(v)
			self.moduleSettings.line3Tag = v
			self:RegisterFontStrings()
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled or DogTag == nil
		end,
		multiline = true,
		order = 39.3
	}

	opts["line4Tag"] = {
		type = 'input',
		name = 'Line 4 tag',
		desc = 'DogTag-formatted string to use for the bottom text line (leave blank to revert to old behavior)\n\nType /dogtag for a list of available tags.\n\nRemember to press Accept after filling out this box or it will not save.',
		get = function()
			return self.moduleSettings.line4Tag
		end,
		set = function(info, v)
			v = DogTag:CleanCode(v)
			self.moduleSettings.line4Tag = v
			self:RegisterFontStrings()
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled or DogTag == nil
		end,
		multiline = true,
		order = 39.4
	}

	return opts
end


-- OVERRIDE
function IceTargetInfo.prototype:GetDefaultSettings()
	local defaults =  IceTargetInfo.super.prototype.GetDefaultSettings(self)

	defaults["fontSize"] = 13
	defaults["stackFontSize"] = 11
	defaults["vpos"] = -50
	defaults["hpos"] = 0
	defaults["zoom"] = 0.08
	defaults["buffSize"] = 20
	defaults["ownBuffSize"] = 20
	defaults["buffOffset"] = {x=-10,y=0}
	defaults["buffAnchorTo"] = "TOPLEFT"
	defaults["buffGrowDirection"] = "Left"
	defaults["debuffOffset"] = {x=10,y=0}
	defaults["debuffAnchorTo"] = "TOPRIGHT"
	defaults["debuffGrowDirection"] = "Right"
	defaults["mouseTarget"] = true
	defaults["mouseBuff"] = true
	defaults["filterBuffs"] = "Never"
	defaults["filterDebuffs"] = "Never"
	defaults["perRow"] = 10
	defaults["line1Tag"] = "[Name:HostileColor]"
--	defaults["line2Tag"] = "[Level:DifficultyColor] [[IsPlayer ? Race ! CreatureType]:ClassColor] [[IsPlayer ? Class]:ClassColor] [[~PvP ? \"PvE\" ! \"PvP\"]:HostileColor] [IsLeader ? \"Leader\":Yellow] [InCombat ? \"Combat\":Red] [Classification]"
	defaults["line2Tag"] = "[Level:DifficultyColor] [SmartRace:ClassColor] [SmartClass:ClassColor] [PvPIcon] [IsLeader ? 'Leader':Yellow] [InCombat ? 'Combat':Red] [Classification]"
	defaults["line3Tag"] = "[Guild:Angle]"
	defaults["line4Tag"] = ""
	defaults["myTagVersion"] = 2
	defaults["alwaysFullAlpha"] = true
	defaults["showBuffs"] = true
	defaults["showDebuffs"] = true

	return defaults
end


function IceTargetInfo.prototype:RegisterFontStrings()
	if DogTag ~= nil then
		if self.frame.targetName then
			if self.moduleSettings.line1Tag ~= '' then
				DogTag:AddFontString(self.frame.targetName, self.frame, self.moduleSettings.line1Tag, "Unit", { unit = self.unit })
			else
				DogTag:RemoveFontString(self.frame.targetName)
			end
		end
		if self.frame.targetInfo then
			if self.moduleSettings.line2Tag ~= '' then
				DogTag:AddFontString(self.frame.targetInfo, self.frame, self.moduleSettings.line2Tag, "Unit", { unit = self.unit })
			else
				DogTag:RemoveFontString(self.frame.targetInfo)
			end
		end
		if self.frame.targetGuild then
			if self.moduleSettings.line3Tag ~= '' then
				DogTag:AddFontString(self.frame.targetGuild, self.frame, self.moduleSettings.line3Tag, "Unit", { unit = self.unit })
			else
				DogTag:RemoveFontString(self.frame.targetGuild)
			end
		end
		if self.frame.targetExtra then
			if self.moduleSettings.line4Tag ~= '' then
				DogTag:AddFontString(self.frame.targetExtra, self.frame, self.moduleSettings.line4Tag, "Unit", { unit = self.unit })
			else
				DogTag:RemoveFontString(self.frame.targetExtra)
			end
		end

		self:TargetChanged()
		DogTag:UpdateAllForFrame(self.frame)
	end
end

function IceTargetInfo.prototype:UnregisterFontStrings()
	if DogTag ~= nil then
		DogTag:RemoveFontString(self.frame.targetName)
		DogTag:RemoveFontString(self.frame.targetInfo)
		DogTag:RemoveFontString(self.frame.targetGuild)
		DogTag:RemoveFontString(self.frame.targetExtra)
	end
end


-- OVERRIDE
function IceTargetInfo.prototype:Redraw()
	IceTargetInfo.super.prototype.Redraw(self)

	if (self.moduleSettings.enabled) then
		self:CreateFrame(true)
		self:TargetChanged()
	end
end


function IceTargetInfo.prototype:RedrawBuffs()
	if (self.moduleSettings.enabled) then
		self:CreateBuffFrame(false)
		self:CreateDebuffFrame(false)

		self:TargetChanged()
	end
end



-- 'Protected' methods --------------------------------------------------------

-- OVERRIDE
function IceTargetInfo.prototype:CreateFrame(redraw)
	if not (self.frame) then
		self.frame = CreateFrame("Button", "IceHUD_"..self.elementName, self.parent, "SecureUnitButtonTemplate")
	end

	-- Parnic - yes, 200 is fairly arbitrary. make a best effort for long names to fit
	self.width = math.max(200, self.settings.gap + 50)

	self.frame:SetScale(self.moduleSettings.scale)

	self.frame:SetFrameStrata("BACKGROUND")
	self.frame:SetWidth(self.width)
	self.frame:SetHeight(32)
	self.frame:ClearAllPoints()
	self.frame:SetPoint("TOP", self.parent, "BOTTOM", self.moduleSettings.hpos, self.moduleSettings.vpos)
	self.frame:SetScale(self.moduleSettings.scale)

	if (self.moduleSettings.mouseTarget) then
		self.frame:EnableMouse(true)
		self.frame:RegisterForClicks("AnyUp")
		self.frame:SetScript("OnEnter", function(frame) self:OnEnter(frame) end)
		self.frame:SetScript("OnLeave", function(frame) self:OnLeave(frame) end)
	else
		self.frame:EnableMouse(false)
		self.frame:RegisterForClicks()
		self.frame:SetScript("OnEnter", nil)
		self.frame:SetScript("OnLeave", nil)
	end

	self.frame.unit = self.unit

	-- set up stuff for clicking
	self.frame:SetAttribute("type1", "target")
	self.frame:SetAttribute("type2", "menu")
	self.frame:SetAttribute("unit", self.unit)

	self.frame.menu = function()
		ToggleDropDownMenu(1, nil, TargetFrameDropDown, "cursor")
	end


	-- create a fancy highlight frame for mouse over
	if (not self.frame.highLight) then
		self.frame.highLight = self.frame:CreateTexture(nil, "OVERLAY")
		self.frame.highLight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
		self.frame.highLight:SetBlendMode("ADD")
		self.frame.highLight:SetAllPoints(self.frame)
		self.frame.highLight:SetVertexColor(1, 1, 1, 0.25)
		self.frame.highLight:Hide()
	end


	-- create rest of the frames
	self:CreateTextFrame()
	self:CreateInfoTextFrame()
	self:CreateGuildTextFrame()
	self:CreateExtraTextFrame()

	self:CreateBuffFrame(redraw)
	self:CreateDebuffFrame(redraw)

	self:CreateRaidIconFrame()


	-- set up click casting
	ClickCastFrames = ClickCastFrames or {}
	ClickCastFrames[self.frame] = true
end


function IceTargetInfo.prototype:CreateTextFrame()
	self.frame.targetName = self:FontFactory(self.moduleSettings.fontSize+1, nil, self.frame.targetName)

	self.frame.targetName:SetJustifyH("CENTER")
	self.frame.targetName:SetJustifyV("TOP")

	self.frame.targetName:SetPoint("TOP", self.frame, "TOP")
end


function IceTargetInfo.prototype:CreateInfoTextFrame()
	self.frame.targetInfo = self:FontFactory(self.moduleSettings.fontSize, nil, self.frame.targetInfo)

--	self.frame.targetInfo:SetWidth(self.width)
	self.frame.targetInfo:SetHeight(14)
	self.frame.targetInfo:SetJustifyH("CENTER")
	self.frame.targetInfo:SetJustifyV("TOP")

	self.frame.targetInfo:SetPoint("TOP", self.frame, "TOP", 0, -16)
	self.frame.targetInfo:Show()
end


function IceTargetInfo.prototype:CreateGuildTextFrame()
	self.frame.targetGuild = self:FontFactory(self.moduleSettings.fontSize, nil, self.frame.targetGuild)

--	self.frame.targetInfo:SetWidth(self.width)
	self.frame.targetGuild:SetHeight(14)
	self.frame.targetGuild:SetJustifyH("CENTER")
	self.frame.targetGuild:SetJustifyV("TOP")

	self.frame.targetGuild:SetPoint("TOP", self.frame, "BOTTOM", 0, 0)
	self.frame.targetGuild:Show()
end


function IceTargetInfo.prototype:CreateExtraTextFrame()
	self.frame.targetExtra = self:FontFactory(self.moduleSettings.fontSize, nil, self.frame.targetExtra)

	self.frame.targetExtra:SetHeight(14)
	self.frame.targetExtra:SetJustifyH("CENTER")
	self.frame.targetExtra:SetJustifyV("TOP")

	self.frame.targetExtra:SetPoint("TOP", self.frame, "BOTTOM", 0, -16)
	self.frame.targetExtra:Show()
end


function IceTargetInfo.prototype:CreateRaidIconFrame()
	if (not self.frame.raidIcon) then
		self.frame.raidIcon = CreateFrame("Frame", nil, self.frame)
	end

	if (not self.frame.raidIcon.icon) then
		self.frame.raidIcon.icon = self.frame.raidIcon:CreateTexture(nil, "BACKGROUND")
		self.frame.raidIcon.icon:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
	end

	self.frame.raidIcon:SetPoint("BOTTOM", self.frame, "TOP", 0, 1)
	self.frame.raidIcon:SetWidth(16)
	self.frame.raidIcon:SetHeight(16)

	self.frame.raidIcon.icon:SetAllPoints(self.frame.raidIcon)
	SetRaidTargetIconTexture(self.frame.raidIcon.icon, 0)
	self.frame.raidIcon:Hide()
end


function IceTargetInfo.prototype:CreateBuffFrame(redraw)
	if (not self.frame.buffFrame) then
		self.frame.buffFrame = CreateFrame("Frame", nil, self.frame)

		self.frame.buffFrame:SetFrameStrata("BACKGROUND")
		self.frame.buffFrame:SetWidth(1)
		self.frame.buffFrame:SetHeight(1)

		self.frame.buffFrame:Show()

		self.frame.buffFrame.buffs = {}
	end

	self.frame.buffFrame:ClearAllPoints()
	self.frame.buffFrame:SetPoint("TOPRIGHT", self.frame, self.moduleSettings.buffAnchorTo, self.moduleSettings.buffOffset['x'], self.moduleSettings.buffOffset['y'])

	if (not redraw) then
		local direction = self.moduleSettings.buffGrowDirection == "Left" and -1 or 1
		self.frame.buffFrame.buffs = self:CreateIconFrames(self.frame.buffFrame, direction, self.frame.buffFrame.buffs, "buff")
	end

	if self.moduleSettings.showBuffs then
		self.frame.buffFrame:Show()
	else
		self.frame.buffFrame:Hide()
	end
end


function IceTargetInfo.prototype:CreateDebuffFrame(redraw)
	if (not self.frame.debuffFrame) then
		self.frame.debuffFrame = CreateFrame("Frame", nil, self.frame)

		self.frame.debuffFrame:SetFrameStrata("BACKGROUND")
		self.frame.debuffFrame:SetWidth(1)
		self.frame.debuffFrame:SetHeight(1)

		self.frame.debuffFrame:Show()

		self.frame.debuffFrame.buffs = {}
	end

	self.frame.debuffFrame:ClearAllPoints()
	self.frame.debuffFrame:SetPoint("TOPLEFT", self.frame, self.moduleSettings.debuffAnchorTo, self.moduleSettings.debuffOffset['x'], self.moduleSettings.debuffOffset['y'])

	if (not redraw) then
		local direction = self.moduleSettings.debuffGrowDirection == "Left" and -1 or 1
		self.frame.debuffFrame.buffs = self:CreateIconFrames(self.frame.debuffFrame, direction, self.frame.debuffFrame.buffs, "debuff")
	end

	if self.moduleSettings.showDebuffs then
		self.frame.debuffFrame:Show()
	else
		self.frame.debuffFrame:Hide()
	end
end


function IceTargetInfo.prototype:CreateIconFrames(parent, direction, buffs, type)
	local lastX = 0
	local lastBuffSize = 0

	for i = 1, IceCore.BuffLimit do
		if (not buffs[i]) then
			buffs[i] = CreateFrame("Frame", nil, parent)
			buffs[i].icon = CreateFrame("Frame", nil, buffs[i])
			buffs[i].cd = CreateFrame("Cooldown", nil, buffs[i], "CooldownFrameTemplate")
		end

		buffs[i]:SetFrameStrata("BACKGROUND")
		if buffs[i].fromPlayer then
			buffs[i]:SetWidth(self.moduleSettings.ownBuffSize)
			buffs[i]:SetHeight(self.moduleSettings.ownBuffSize)
		else
			buffs[i]:SetWidth(self.moduleSettings.buffSize)
			buffs[i]:SetHeight(self.moduleSettings.buffSize)
		end

		buffs[i].icon:SetFrameStrata("BACKGROUND")
		if buffs[i].fromPlayer then
			buffs[i].icon:SetWidth(self.moduleSettings.ownBuffSize-2)
			buffs[i].icon:SetHeight(self.moduleSettings.ownBuffSize-2)
		else
			buffs[i].icon:SetWidth(self.moduleSettings.buffSize-2)
			buffs[i].icon:SetHeight(self.moduleSettings.buffSize-2)
		end

		buffs[i].cd:SetFrameStrata("BACKGROUND")
		buffs[i].cd:SetFrameLevel(buffs[i].icon:GetFrameLevel()+1)
		buffs[i].cd:SetReverse(true)
		buffs[i].cd:ClearAllPoints()
		buffs[i].cd:SetAllPoints(buffs[i])


		local buffSize = self.moduleSettings.buffSize
		if buffs[i].fromPlayer then
			buffSize = self.moduleSettings.ownBuffSize
		end

		local pos = i % self.moduleSettings.perRow
		if pos == 1 or self.moduleSettings.perRow == 1 then
			lastX = 0
			lastBuffSize = 0
		end

		local x = lastX + lastBuffSize
		lastX = x
		lastBuffSize = (buffSize * direction)
		local y = math.floor((i-1) / self.moduleSettings.perRow) * math.max(self.moduleSettings.buffSize, self.moduleSettings.ownBuffSize) * -1

		buffs[i]:ClearAllPoints()
		if direction < 0 then
			buffs[i]:SetPoint("TOPRIGHT", x, y)
		else
			buffs[i]:SetPoint("TOPLEFT", x, y)
		end


		buffs[i].icon:ClearAllPoints()
		buffs[i].icon:SetPoint("CENTER", 0, 0)

--		buffs[i]:Show()
--		buffs[i].icon:Show()

		if (not buffs[i].texture) then
			buffs[i].texture = buffs[i]:CreateTexture()
			buffs[i].texture:ClearAllPoints()
			buffs[i].texture:SetAllPoints(buffs[i])

			buffs[i].icon.texture = buffs[i].icon:CreateTexture()
			buffs[i].icon.texture:SetTexture(nil)

			buffs[i].icon.texture:ClearAllPoints()
			buffs[i].icon.texture:SetAllPoints(buffs[i].icon)
		end

		buffs[i].icon.stack = self:FontFactory(self.moduleSettings.stackFontSize, buffs[i].icon, buffs[i].icon.stack,
			"OUTLINE")

		buffs[i].icon.stack:ClearAllPoints()
		buffs[i].icon.stack:SetPoint("BOTTOMRIGHT" , buffs[i].icon, "BOTTOMRIGHT", 3, -1)


		buffs[i].id = i
		if (self.moduleSettings.mouseBuff) then
			buffs[i]:EnableMouse(true)
			buffs[i]:SetScript("OnEnter", function(this, ...) self:BuffOnEnter(this, buffs[i].type or type) end)
			buffs[i]:SetScript("OnLeave", function() GameTooltip:Hide() end)
		else
			buffs[i]:EnableMouse(false)
			buffs[i]:SetScript("OnEnter", nil)
			buffs[i]:SetScript("OnLeave", nil)
		end
	end

	return buffs
end

function IceTargetInfo.prototype:SetBuffSize(buff)
end

function IceTargetInfo.prototype:UpdateBuffs()
	local zoom = self.moduleSettings.zoom
	local filterBuffs = false
	local filterDebuffs = false

	if (self.moduleSettings.filterBuffs == "Always") then
		filterBuffs = true
	elseif (self.moduleSettings.filterBuffs == "In Combat") then
		if (UnitAffectingCombat("player")) then
			filterBuffs = true
		end
	end

	if (self.moduleSettings.filterDebuffs == "Always") then
		filterDebuffs = true
	elseif (self.moduleSettings.filterDebuffs == "In Combat") then
		if (UnitAffectingCombat("player")) then
			filterDebuffs = true
		end
	end

	local hostile = UnitCanAttack("player", self.unit)


	if self.moduleSettings.showBuffs then
		for i = 1, IceCore.BuffLimit do
			local buffName, buffRank, buffTexture, buffApplications, buffType, buffDuration, buffTimeLeft, isFromMe, unitCaster;
			if IceHUD.WowVer >= 30000 then
				buffName, buffRank, buffTexture, buffApplications, buffType, buffDuration, buffTimeLeft, unitCaster
					= UnitAura(self.unit, i, "HELPFUL" .. (filterBuffs and "|PLAYER" or "")) --UnitBuff(self.unit, i, filterBuffs and not hostile)

				isFromMe = (unitCaster == "player")
			else
				buffName, buffRank, buffTexture, buffApplications, buffDuration, buffTimeLeft
					= UnitBuff(self.unit, i, filterBuffs and not hostile)

				isFromMe = buffDuration and buffTimeLeft
			end

			if (buffTexture) then
				self:SetUpBuff(i, buffTexture, buffDuration, buffTimeLeft, isFromMe, buffApplications)
			else
				self.frame.buffFrame.buffs[i]:Hide()
			end
		end
	end

	local direction = self.moduleSettings.buffGrowDirection == "Left" and -1 or 1
	self.frame.buffFrame.buffs = self:CreateIconFrames(self.frame.buffFrame, direction, self.frame.buffFrame.buffs, "buff")

	if self.moduleSettings.showDebuffs then
		for i = 1, IceCore.BuffLimit do
			local buffName, buffRank, buffTexture, buffApplications, debuffDispelType,
				debuffDuration, debuffTimeLeft, unitCaster = UnitAura(self.unit, i, "HARMFUL" .. (filterDebuffs and "|PLAYER" or "")) --UnitDebuff(self.unit, i, filterDebuffs and not hostile)

			local isFromMe = (unitCaster == "player")

			if (buffTexture and (not hostile or not filterDebuffs or (filterDebuffs and debuffDuration))) then

				local color = debuffDispelType and DebuffTypeColor[debuffDispelType] or DebuffTypeColor["none"]
				local alpha = buffTexture and 1 or 0
				self.frame.debuffFrame.buffs[i].texture:SetTexture(1, 1, 1, alpha)
				self.frame.debuffFrame.buffs[i].texture:SetVertexColor(color.r, color.g, color.b)

				-- cooldown frame
				if (debuffDuration and debuffDuration > 0 and
					debuffTimeLeft and debuffTimeLeft > 0) then
					local start
					if IceHUD.WowVer >= 30000 then
						-- in wotlk, the "bufftimeleft" parameter is actually the ending time for the buff
						start = debuffTimeLeft - debuffDuration
					else
						start = GetTime() - debuffDuration + debuffTimeLeft
					end
					self.frame.debuffFrame.buffs[i].cd:SetCooldown(start, debuffDuration)
					self.frame.debuffFrame.buffs[i].cd:Show()
				else
					self.frame.debuffFrame.buffs[i].cd:Hide()
				end

				self.frame.debuffFrame.buffs[i].fromPlayer = isFromMe

				self.frame.debuffFrame.buffs[i].icon.texture:SetTexture(buffTexture)
				self.frame.debuffFrame.buffs[i].icon.texture:SetTexCoord(zoom, 1-zoom, zoom, 1-zoom)

				if (buffApplications and (buffApplications > 1)) then
					self.frame.debuffFrame.buffs[i].icon.stack:SetText(buffApplications)
				else
					self.frame.debuffFrame.buffs[i].icon.stack:SetText(nil)
				end


				self.frame.debuffFrame.buffs[i]:Show()
			else
				self.frame.debuffFrame.buffs[i]:Hide()
			end
		end
	end

	local direction = self.moduleSettings.debuffGrowDirection == "Left" and -1 or 1
	self.frame.debuffFrame.buffs = self:CreateIconFrames(self.frame.debuffFrame, direction, self.frame.debuffFrame.buffs, "debuff")
end


function IceTargetInfo.prototype:SetUpBuff(i, buffTexture, buffDuration, buffTimeLeft, isFromMe, buffApplications, buffType)
	local zoom = self.moduleSettings.zoom

	self.frame.buffFrame.buffs[i].type = buffType
	self.frame.buffFrame.buffs[i].icon.texture:SetTexture(buffTexture)
	self.frame.buffFrame.buffs[i].icon.texture:SetTexCoord(zoom, 1-zoom, zoom, 1-zoom)

	local alpha = buffTexture and 0.5 or 0
	self.frame.buffFrame.buffs[i].texture:SetTexture(0, 0, 0, alpha)

	-- cooldown frame
	if (buffDuration and buffDuration > 0 and
		buffTimeLeft and buffTimeLeft > 0) then
		local start = buffTimeLeft - buffDuration
		self.frame.buffFrame.buffs[i].cd:SetCooldown(start, buffDuration)
		self.frame.buffFrame.buffs[i].cd:Show()
	else
		self.frame.buffFrame.buffs[i].cd:Hide()
	end

	self.frame.buffFrame.buffs[i].fromPlayer = isFromMe

	if (buffApplications and (buffApplications > 1)) then
		self.frame.buffFrame.buffs[i].icon.stack:SetText(buffApplications)
	else
		self.frame.buffFrame.buffs[i].icon.stack:SetText(nil)
	end

	self.frame.buffFrame.buffs[i]:Show()
end



function IceTargetInfo.prototype:AuraChanged(event, unit)
	if (unit == self.unit) then
		self:UpdateBuffs()
	end
end


function IceTargetInfo.prototype:UpdateRaidTargetIcon()
	if not (UnitExists(self.unit)) then
		self.frame.raidIcon:Hide()
		return
	end

	local index = GetRaidTargetIndex(self.unit);

	if (index and (index > 0)) then
		SetRaidTargetIconTexture(self.frame.raidIcon.icon, index)
		self.frame.raidIcon:Show()
	else
		self.frame.raidIcon:Hide()
	end
end


function IceTargetInfo.prototype:TargetChanged()
	IceTargetInfo.super.prototype.TargetChanged(self)

	if (not UnitExists(self.unit)) then
		--self.frame:Hide()
		--self.frame.target:Hide()

		self.frame.targetName:SetText()
		self.frame.targetInfo:SetText()
		self.frame.targetGuild:SetText()
		self.frame.targetExtra:SetText()

		self:UpdateBuffs()
		self:UpdateRaidTargetIcon()
		return
	end


	-- pass "internal" as a paramater so event handler code doesn't execute
	-- Update() unnecassarily

	self:TargetName(nil, internal)

	self:TargetLevel(nil, internal)
	self:TargetReaction(nil, internal)
	self:TargetFaction(nil, internal)
	self:TargetFlags(nil, internal)

	self:UpdateBuffs()
	self:UpdateRaidTargetIcon()

	self:Update(self.unit)
end


function IceTargetInfo.prototype:TargetName(event, unit)
	if (unit == self.unit or unit == internal) then
		self.name, self.realm = UnitName(self.unit)
		self.classLocale, self.classEnglish = UnitClass(self.unit)
		self.isPlayer = UnitIsPlayer(self.unit)


		local classification = UnitClassification(self.unit) or ""
		if (string.find(classification, "boss")) then
			self.classification = " |cffcc1111Boss|r"
		elseif(string.find(classification, "rare")) then
			self.classification = " |cffcc11ccRare|r"
		else
			self.classification = ""
		end


		local guildName, guildRankName, guildRankIndex = GetGuildInfo(self.unit);
		self.guild = guildName and "<" .. guildName .. ">" or ""


		if (self.classLocale and self.isPlayer) then
			self.classLocale = "|c" .. self:GetHexColor(self.classEnglish) ..  self.classLocale .. "|r"
		else
			self.classLocale = UnitCreatureType(self.unit)
		end


		self.leader = UnitIsPartyLeader(self.unit) and " |cffcccc11Leader|r" or ""
		self:Update(unit)
	end
end


function IceTargetInfo.prototype:TargetLevel(event, unit)
	if (unit == self.unit or unit == internal) then
		self.level = UnitLevel(self.unit)

		local colorFunc = GetQuestDifficultyColor or GetDifficultyColor
		local color = colorFunc((self.level > 0) and self.level or 100)

		if (self.level > 0) then
			if (UnitClassification(self.unit) == "elite") then
				self.level = self.level .. "+"
			end
		else
			self.level = "??"
		end

		self.level = "|c" .. self:ConvertToHex(color) .. self.level .. "|r"

		self:Update(unit)
	end
end


function IceTargetInfo.prototype:TargetReaction(unit)
	if (unit == self.unit or unit == internal) then
		self.reaction = UnitReaction(self.unit, "player")

		-- if we don't get reaction, unit is out of range - has to be friendly
		-- to be targettable (party/raid)
		if (not self.reaction) then
			self.reaction = 5
		end
		self:Update(unit)
	end
end


-- PVP status
function IceTargetInfo.prototype:TargetFaction(event, unit)
	if (unit == self.unit or unit == internal) then
		if (self.isPlayer) then
			if (UnitIsPVP(self.unit)) then
				local color = "ff10ff10" -- friendly
				if (UnitFactionGroup(self.unit) ~= UnitFactionGroup("player")) then
					color = "ffff1010" -- hostile
				end
				self.pvp = " |c" .. color .. "PvP|r"
			else
				self.pvp = " |cff1010ffPvE|r"
			end
		else
			self.pvp = ""
		end

		self:TargetReaction(unit)
		self:Update(unit)
	end
end


function IceTargetInfo.prototype:TargetFlags(event, unit)
	if (unit == self.unit or unit == internal) then
		self.tapped = UnitIsTapped(self.unit) and (not UnitIsTappedByPlayer(self.unit))
		self.targetCombat = UnitAffectingCombat(self.unit) and " |cffee4030Combat|r" or ""
		self:UpdateBuffs()
		self:Update(unit)
	end
end


function IceTargetInfo.prototype:Update(unit)
	if (unit ~= self.unit) then
		return
	end

	if DogTag == nil then
		self.frame.targetName:SetText(self.name or '')
		self.frame.targetName:SetVertexColor(UnitSelectionColor(self.unit))

		local line2 = string.format("%s %s%s%s%s%s",
			self.level or '', self.classLocale or '', self.pvp or '', self.leader or '', self.classification or '', self.targetCombat or '')
		self.frame.targetInfo:SetText(line2)

		local realm = self.realm and " " .. self.realm or ""
		local line3 = string.format("%s%s", self.guild or '', realm)
		self.frame.targetGuild:SetText(line3)
	end

	-- Parnic - i have no idea why i have to force UpdateFontString here...but
	--          if i just do AllForFrame or AllForUnit, then selecting a unit after
	--          having nothing selected refuses to update the frames...*sigh*
	if DogTag ~= nil then
		DogTag:UpdateFontString(self.frame.targetName)
		DogTag:UpdateFontString(self.frame.targetInfo)
		DogTag:UpdateFontString(self.frame.targetGuild)
		DogTag:UpdateFontString(self.frame.targetExtra)
	end

	self:UpdateAlpha()
end


function IceTargetInfo.prototype:OnEnter(frame)
	UnitFrame_OnEnter(frame)
	self.frame.highLight:Show()
end


function IceTargetInfo.prototype:OnLeave(frame)
	UnitFrame_OnLeave(frame)
	self.frame.highLight:Hide()
end


function IceTargetInfo.prototype:BuffOnEnter(this, type)
	if (not self:IsVisible()) then
		return
	end

	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT")
	if (type == "buff") then
		GameTooltip:SetUnitBuff(self.unit, this.id)
	elseif (type == "mh" or type == "oh") then
		GameTooltip:SetInventoryItem("player", type == "mh" and GetInventorySlotInfo("MainHandSlot") or GetInventorySlotInfo("SecondaryHandSlot"))
	else
		GameTooltip:SetUnitDebuff(self.unit, this.id)
	end
end


-- Load us up
IceHUD.TargetInfo = IceTargetInfo:new()
