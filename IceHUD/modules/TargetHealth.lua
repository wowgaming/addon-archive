IceTargetHealth = IceCore_CreateClass(IceUnitBar)

IceTargetHealth.prototype.color = nil
IceTargetHealth.prototype.determineColor = true
IceTargetHealth.prototype.registerEvents = true
IceTargetHealth.prototype.texWidth = 128
IceTargetHealth.prototype.texHeight = 128
IceTargetHealth.prototype.classLeft = 0
IceTargetHealth.prototype.classRight = 0.9375
IceTargetHealth.prototype.classTop = 0
IceTargetHealth.prototype.classBottom = 0.78125
IceTargetHealth.prototype.raidIconWidth = 16
IceTargetHealth.prototype.raidIconHeight = 16
IceTargetHealth.prototype.EliteTexture = IceElement.TexturePath .. "Elite"
IceTargetHealth.prototype.RareEliteTexture = IceElement.TexturePath .. "RareElite"
IceTargetHealth.prototype.RareTexture = IceElement.TexturePath .. "Rare"
IceTargetHealth.prototype.DisplayClickTargetOption = true

IceTargetHealth.prototype.configMode = false

-- Constructor --
function IceTargetHealth.prototype:init(moduleName, unit)
	if not moduleName or not unit then
		IceTargetHealth.super.prototype.init(self, "TargetHealth", "target")
	else
		IceTargetHealth.super.prototype.init(self, moduleName, unit)
	end

	self:SetDefaultColor("TargetHealthHostile", 231, 31, 36)
	self:SetDefaultColor("TargetHealthFriendly", 46, 223, 37)
	self:SetDefaultColor("TargetHealthNeutral", 210, 219, 87)
end


function IceTargetHealth.prototype:GetDefaultSettings()
	local settings = IceTargetHealth.super.prototype.GetDefaultSettings(self)

	settings["side"] = IceCore.Side.Left
	settings["offset"] = 2
	settings["classColor"] = false
	settings["hideBlizz"] = false
	settings["upperText"] = "[PercentHP:Round]"
	settings["lowerText"] = "[(HP:Round \"/\" MaxHP:Round):HPColor:Bracket]"
	settings["raidIconOnTop"] = true
	settings["showRaidIcon"] = true
	settings["raidIconXOffset"] = 12
	settings["raidIconYOffset"] = 0
	settings["raidIconScale"] = 1
	settings["lockIconAlpha"] = false
	settings["abbreviateHealth"] = true
	settings["classIconOffset"] = {x=0, y=0}
	settings["showClassificationIcon"] = false
	settings["classIconOnTop"] = false
	settings["classIconScale"] = 1
	settings["showPvPIcon"] = true
	settings["PvPIconOffset"] = {x=23, y=11}
	settings["PvPIconScale"] = 1.0
	settings["PvPIconOnTop"] = false
	settings["allowMouseInteraction"] = false
	settings["npcHostilityColor"] = false
	settings["showPartyRoleIcon"] = false
	settings["PartyRoleIconOffset"] = {x=33, y=-8}
	settings["PartyRoleIconScale"] = 0.9

	return settings
end


-- OVERRIDE
function IceTargetHealth.prototype:GetOptions()
	local opts = IceTargetHealth.super.prototype.GetOptions(self)

	opts["classColor"] = {
		type = "toggle",
		name = "Class color bar",
		desc = "Use class color as the bar color instead of reaction color\n\n(Note: The 'color bar by health %' setting overrides this)",
		get = function()
			return self.moduleSettings.classColor
		end,
		set = function(info, value)
			self.moduleSettings.classColor = value
			self:Update(self.unit)
		end,
		disabled = function()
			return not self.moduleSettings.enabled or self.moduleSettings.scaleHealthColor
		end,
		order = 41
	}

	opts["npcHostilityColor"] = {
		type = "toggle",
		name = "Color NPC by hostility",
		desc = "If you are using the 'class color bar' setting above, then enabling this will color NPC's by their hostility toward you since NPC class isn't very helpful or applicable information.",
		get = function()
			return self.moduleSettings.npcHostilityColor
		end,
		set = function(info, v)
			self.moduleSettings.npcHostilityColor = v
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled or not self.moduleSettings.classColor or self.moduleSettings.scaleHealthColor
		end,
		order = 41.5
	}

	opts["hideBlizz"] = {
		type = "toggle",
		name = "Hide Blizzard Frame",
		desc = "Hides Blizzard Target frame and disables all events related to it",
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
		order = 42
	}

	opts["allowClickTarget"] = {
		type = 'toggle',
		name = 'Allow click-targeting',
		desc = 'Whether or not to allow click targeting/casting and the target drop-down menu for this bar (Note: does not work properly with HiBar, have to click near the base of the bar)',
		get = function()
			return self.moduleSettings.allowMouseInteraction
		end,
		set = function(info, v)
			self.moduleSettings.allowMouseInteraction = v
			self:CreateBackground(true)
		end,
		disabled = function()
			return not self.moduleSettings.enabled or not self.DisplayClickTargetOption
		end,
		order = 43
	}

	opts["scaleHealthColor"] = {
		type = "toggle",
		name = "Color bar by health %",
		desc = "Colors the health bar from MaxHealthColor to MinHealthColor based on current health %\n\n(Note: This overrides the 'class color bar' setting. Disable this to use class coloring)",
		get = function()
			return self.moduleSettings.scaleHealthColor
		end,
		set = function(info, value)
			self.moduleSettings.scaleHealthColor = value
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 44
	}

if not IceHUD.IceCore:ShouldUseDogTags() then
	opts["shortenHealth"] = {
		type = 'toggle',
		name = 'Abbreviate estimated health',
		desc = 'If this is checked, then a health value of 1100 will display as 1.1k, otherwise it shows the number',
		get = function()
			return self.moduleSettings.abbreviateHealth
		end,
		set = function(info, v)
			self.moduleSettings.abbreviateHealth = v
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 40.1
	}
end

	opts["iconSettings"] =
	{
		type = 'group',
		name = '|c' .. self.configColor .. 'Icon Settings|r',
		desc = 'Settings related to icons',
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		args = {
			iconConfigMode = {
				type = "toggle",
				name = "Icon config mode",
				desc = "With this enabled, all icons draw so you can configure their placement\n\nNote: the combat and status icons are actually the same texture so you'll only see combat in config mode (unless you're already resting)",
				get = function()
					return self.configMode
				end,
				set = function(info, v)
					self.configMode = v
					self:CheckPvP()
					self:UpdateRaidTargetIcon()
					self:CheckPartyRole()
					self:Redraw()
				end,
				order = 5
			},

			lockIconAlpha = {
				type = "toggle",
				name = "Lock all icons to 100% alpha",
				desc = "With this enabled, all icons will be 100% visible regardless of the alpha settings for this bar.",
				get = function()
					return self.moduleSettings.lockIconAlpha
				end,
				set = function(info, v)
					self.moduleSettings.lockIconAlpha = v
					self:Redraw()
				end,
				order = 6
			},

			PvPHeader = {
				type = 'header',
				name = 'PvP icon',
				order = 39.9
			},

			PvPIcon = {
				type = "toggle",
				name = "Show PvP icon",
				desc = "Whether or not to show the PvP icon",
				get = function()
					return self.moduleSettings.showPvPIcon
				end,
				set = function(info, value)
					self.moduleSettings.showPvPIcon = value
					self:CheckPvP()
				end,
				disabled = function()
					return not self.moduleSettings.enabled
				end,
				order = 40
			},
			PvPIconOnTop = {
				type = "toggle",
				name = "Draw PVP Icon on top",
				desc = "Whether to draw the PvP icon in front of or behind this bar",
				get = function()
					return self.moduleSettings.PvPIconOnTop
				end,
				set = function(info, value)
					self.moduleSettings.PvPIconOnTop = value
					self:CheckPvP()
				end,
				disabled = function()
					return not self.moduleSettings.enabled or not self.moduleSettings.showPvPIcon
				end,
				order = 40.1
			},
			PvPIconOffsetX = {
				type = "range",
				name = "PvP Icon Horizontal Offset",
				desc = "How much to offset the PvP icon from the bar horizontally",
				min = 0,
				max = 250,
				step = 1,
				get = function()
					return self.moduleSettings.PvPIconOffset['x']
				end,
				set = function(info, v)
					self.moduleSettings.PvPIconOffset['x'] = v
					self:SetTexLoc(self.barFrame.PvPIcon, self.moduleSettings.PvPIconOffset['x'], self.moduleSettings.PvPIconOffset['y'])
				end,
				disabled = function()
					return not self.moduleSettings.enabled or not self.moduleSettings.showPvPIcon
				end,
				order = 41
			},
			PvPIconOffsetY = {
				type = "range",
				name = "PvP Icon Vertical Offset",
				desc = "How much to offset the PvP icon from the bar vertically",
				min = -300,
				max = 50,
				step = 1,
				get = function()
					return self.moduleSettings.PvPIconOffset['y']
				end,
				set = function(info, v)
					self.moduleSettings.PvPIconOffset['y'] = v
					self:SetTexLoc(self.barFrame.PvPIcon, self.moduleSettings.PvPIconOffset['x'], self.moduleSettings.PvPIconOffset['y'])
				end,
				disabled = function()
					return not self.moduleSettings.enabled or not self.moduleSettings.showPvPIcon
				end,
				order = 42
			},
			PvPIconScale = {
				type = "range",
				name = "PvP Icon Scale",
				desc = "How much to scale the PvP icon",
				min = 0.05,
				max = 2,
				step = 0.05,
				get = function()
					return self.moduleSettings.PvPIconScale
				end,
				set = function(info, v)
					self.moduleSettings.PvPIconScale = v
					self:SetTexScale(self.barFrame.PvPIcon, 20, 20, v)
				end,
				disabled = function()
					return not self.moduleSettings.enabled or not self.moduleSettings.showPvPIcon
				end,
				order = 43
			},

			RaidHeader = {
				type = 'header',
				name = 'Raid icon',
				order = 49.9
			},

			showRaidIcon = {
				type = "toggle",
				name = "Show Raid Icon",
				desc = "Whether or not to show the raid icon above this bar",
				get = function()
					return self.moduleSettings.showRaidIcon
				end,
				set = function(info, value)
					self.moduleSettings.showRaidIcon = value
					self:UpdateRaidTargetIcon()
				end,
				disabled = function()
					return not self.moduleSettings.enabled
				end,
				order = 50
			},

			raidIconOnTop = {
				type = "toggle",
				name = "Draw Raid Icon On Top",
				desc = "Whether to draw the raid icon in front of or behind this bar",
				get = function()
					return self.moduleSettings.raidIconOnTop
				end,
				set = function(info, value)
					self.moduleSettings.raidIconOnTop = value
					self:UpdateRaidTargetIcon()
				end,
				disabled = function()
					return not self.moduleSettings.enabled or not self.moduleSettings.showRaidIcon
				end,
				order = 52
			},

			raidIconXOffset = {
				type = "range",
				name = "Raid Icon X Offset",
				desc = "How far to push the raid icon right or left",
				min = -300,
				max = 300,
				step = 1,
				get = function()
					return self.moduleSettings.raidIconXOffset
				end,
				set = function(info, value)
					self.moduleSettings.raidIconXOffset = value
					self:SetRaidIconPlacement()
					self:Redraw()
				end,
				disabled = function()
					return not self.moduleSettings.enabled or not self.moduleSettings.showRaidIcon
				end,
				order = 53
			},

			raidIconYOffset = {
				type = "range",
				name = "Raid Icon Y Offset",
				desc = "How far to push the raid icon up or down",
				min = -300,
				max = 300,
				step = 1,
				get = function()
					return self.moduleSettings.raidIconYOffset
				end,
				set = function(info, value)
					self.moduleSettings.raidIconYOffset = value
					self:SetRaidIconPlacement()
					self:Redraw()
				end,
				disabled = function()
					return not self.moduleSettings.enabled or not self.moduleSettings.showRaidIcon
				end,
				order = 54
			},

			raidIconScale = {
				type = "range",
				name = "Raid Icon Scale",
				desc = "How much to scale the raid icon",
				min = 0.05,
				max = 2,
				step = 0.05,
				get = function()
					return self.moduleSettings.raidIconScale
				end,
				set = function(info, v)
					self.moduleSettings.raidIconScale = v
					self:SetTexScale(self.frame.raidIcon, self.raidIconWidth, self.raidIconHeight, v)
				end,
				disabled = function()
					return not self.moduleSettings.enabled or not self.moduleSettings.showRaidIcon
				end,
				order = 55
			},

			ClassificationHeader = {
				type = 'header',
				name = 'Classification icon',
				order = 59.9
			},

			showClassificationIcon = {
				type = "toggle",
				name = "Show Elite Icon",
				desc = "Whether or not to show the rare/elite icon above this bar",
				get = function()
					return self.moduleSettings.showClassificationIcon
				end,
				set = function(info, value)
					self.moduleSettings.showClassificationIcon = value
					self:Redraw()
				end,
				disabled = function()
					return not self.moduleSettings.enabled
				end,
				order = 60
			},

			classIconOnTop = {
				type = "toggle",
				name = "Draw Elite Icon On Top",
				desc = "Whether to draw the elite icon in front of or behind this bar",
				get = function()
					return self.moduleSettings.classIconOnTop
				end,
				set = function(info, value)
					self.moduleSettings.classIconOnTop = value
					self:Redraw()
				end,
				disabled = function()
					return not self.moduleSettings.enabled or not self.moduleSettings.showClassificationIcon
				end,
				order = 60.1
			},

			classIconXOffset = {
				type = "range",
				name = "Elite Icon X Offset",
				desc = "How far to push the elite icon right or left",
				min = -300,
				max = 300,
				step = 1,
				get = function()
					return self.moduleSettings.classIconOffset['x']
				end,
				set = function(info, value)
					self.moduleSettings.classIconOffset['x'] = value
					self:Redraw()
				end,
				disabled = function()
					return not self.moduleSettings.enabled or not self.moduleSettings.showClassificationIcon
				end,
				order = 61
			},

			classIconYOffset = {
				type = "range",
				name = "Elite Icon Y Offset",
				desc = "How far to push the elite icon up or down",
				min = -300,
				max = 300,
				step = 1,
				get = function()
					return self.moduleSettings.classIconOffset['y']
				end,
				set = function(info, value)
					self.moduleSettings.classIconOffset['y'] = value
					self:Redraw()
				end,
				disabled = function()
					return not self.moduleSettings.enabled or not self.moduleSettings.showClassificationIcon
				end,
				order = 62
			},

			classIconScale = {
				type = "range",
				name = "Elite Icon Scale",
				desc = "How much to scale the elite icon",
				min = 0.05,
				max = 2,
				step = 0.05,
				get = function()
					return self.moduleSettings.classIconScale
				end,
				set = function(info, v)
					self.moduleSettings.classIconScale = v
					self:SetTexScale(self.barFrame.classIcon, self.texWidth, self.texHeight, self.moduleSettings.scale / 3.0 * self.moduleSettings.classIconScale)
				end,
				disabled = function()
					return not self.moduleSettings.enabled or not self.moduleSettings.showClassificationIcon
				end,
				order = 63
			},

			headerPartyRoleIcon = {
				type = 'header',
				name = "Party Role icon",
				order = 65
			},
			PartyRoleIcon = {
				type = "toggle",
				name = "Show Party Role icon",
				desc = "Whether or not to show the Party Role icon",
				get = function()
					return self.moduleSettings.showPartyRoleIcon
				end,
				set = function(info, value)
					self.moduleSettings.showPartyRoleIcon = value
					self:CheckPartyRole()
				end,
				disabled = function()
					return not self.moduleSettings.enabled
				end,
				order = 66
			},
			PartyRoleIconOffsetX = {
				type = "range",
				name = "Party Role Icon Horizontal Offset",
				desc = "How much to offset the Party Role icon from the bar horizontally",
				min = 0,
				max = 250,
				step = 1,
				get = function()
					return self.moduleSettings.PartyRoleIconOffset['x']
				end,
				set = function(info, v)
					self.moduleSettings.PartyRoleIconOffset['x'] = v
					self:SetTexLoc(self.frame.PartyRoleIcon, self.moduleSettings.PartyRoleIconOffset['x'], self.moduleSettings.PartyRoleIconOffset['y'])
				end,
				disabled = function()
					return not self.moduleSettings.enabled or not self.moduleSettings.showPartyRoleIcon
				end,
				order = 67
			},
			PartyRoleIconOffsetY = {
				type = "range",
				name = "Party Role Icon Vertical Offset",
				desc = "How much to offset the Party Role icon from the bar vertically",
				min = -300,
				max = 50,
				step = 1,
				get = function()
					return self.moduleSettings.PartyRoleIconOffset['y']
				end,
				set = function(info, v)
					self.moduleSettings.PartyRoleIconOffset['y'] = v
					self:SetTexLoc(self.frame.PartyRoleIcon, self.moduleSettings.PartyRoleIconOffset['x'], self.moduleSettings.PartyRoleIconOffset['y'])
				end,
				disabled = function()
					return not self.moduleSettings.enabled or not self.moduleSettings.showPartyRoleIcon
				end,
				order = 68
			},
			PartyRoleIconScale = {
				type = "range",
				name = "Party Role Icon Scale",
				desc = "How much to scale the Party Role icon",
				min = 0.05,
				max = 2,
				step = 0.05,
				get = function()
					return self.moduleSettings.PartyRoleIconScale
				end,
				set = function(info, v)
					self.moduleSettings.PartyRoleIconScale = v
					self:SetTexScale(self.frame.PartyRoleIcon, 20, 20, v)
				end,
				disabled = function()
					return not self.moduleSettings.enabled or not self.moduleSettings.showPartyRoleIcon
				end,
				order = 69
			}
		}
	}

	return opts
end


function IceTargetHealth.prototype:Enable(core)
	IceTargetHealth.super.prototype.Enable(self, core)

	if self.registerEvents then
		self:RegisterEvent("UNIT_HEALTH", "UpdateEvent")
		self:RegisterEvent("UNIT_MAXHEALTH", "UpdateEvent")
		self:RegisterEvent("UNIT_FLAGS", "UpdateEvent")
		self:RegisterEvent("UNIT_FACTION", "UpdateEvent")
		self:RegisterEvent("RAID_TARGET_UPDATE", "UpdateRaidTargetIcon")
		self:RegisterEvent("UPDATE_FACTION", "CheckPvP")
		self:RegisterEvent("PLAYER_FLAGS_CHANGED", "CheckPvP")
		self:RegisterEvent("UNIT_FACTION", "CheckPvP")
		self:RegisterEvent("LFG_PROPOSAL_UPDATE", "CheckPartyRole")
		self:RegisterEvent("LFG_PROPOSAL_FAILED", "CheckPartyRole")
		self:RegisterEvent("LFG_ROLE_UPDATE", "CheckPartyRole")
	end

	if (self.moduleSettings.hideBlizz) then
		self:HideBlizz()
	end

	self:CreateRaidIconFrame()

	self:Update(self.unit)

	RegisterUnitWatch(self.frame)
end


function IceTargetHealth.prototype:Disable(core)
	IceTargetHealth.super.prototype.Disable(self, core)

	UnregisterUnitWatch(self.frame)

	if self.moduleSettings.hideBlizz then
		self:ShowBlizz()
	end
end


function IceTargetHealth.prototype:CreateBackground(redraw)
	IceTargetHealth.super.prototype.CreateBackground(self)

	self:EnableClickTargeting(self.moduleSettings.allowMouseInteraction)
	if self.frame.button then
		self.frame.button:ClearAllPoints()
		-- Parnic - kinda hacky, but in order to fit this region to multiple types of bars, we need to do this...
		--          would be nice to define this somewhere in data, but for now...here we are
		if self:GetMyBarTexture() == "HiBar" then
			self.frame.button:SetPoint("TOPRIGHT", self.frame, "TOPRIGHT", 0, 0)
			self.frame.button:SetPoint("BOTTOMLEFT", self.frame, "BOTTOMRIGHT", -1 * self.frame:GetWidth(), 0)
		elseif self:GetMyBarTexture() == "ArcHUD" then
			if self.moduleSettings.side == IceCore.Side.Left then
				self.frame.button:SetPoint("TOPLEFT", self.frame, "TOPLEFT")
				self.frame.button:SetPoint("BOTTOMRIGHT", self.frame, "BOTTOMLEFT", self.frame:GetWidth() / 3, 0)
			else
				self.frame.button:SetPoint("TOPRIGHT", self.frame, "TOPRIGHT")
				self.frame.button:SetPoint("BOTTOMLEFT", self.frame, "BOTTOMRIGHT", -1 * self.frame:GetWidth() / 3, 0)
			end
		else
			if self.moduleSettings.side == IceCore.Side.Left then
				self.frame.button:SetPoint("TOPRIGHT", self.frame, "TOPRIGHT", -6, 0)
				self.frame.button:SetPoint("BOTTOMLEFT", self.frame, "BOTTOMRIGHT", -1 * self.frame:GetWidth() / 3, 0)
			else
				self.frame.button:SetPoint("TOPLEFT", self.frame, "TOPLEFT", 6, 0)
				self.frame.button:SetPoint("BOTTOMRIGHT", self.frame, "BOTTOMRIGHT", -1 * self.frame:GetWidth() / 1.5, 0)
			end
		end

		self.frame.button.menu = function()
			ToggleDropDownMenu(1, nil, TargetFrameDropDown, "cursor");
		end
	end
end


function IceTargetHealth.prototype:EnableClickTargeting(bEnable)
	if bEnable then
		if not self.frame.button then
			self.frame.button = CreateFrame("Button", "IceHUD_TargetClickFrame", self.frame, "SecureUnitButtonTemplate")
		end

		self.frame.button:EnableMouse(true)
		self.frame.button:RegisterForClicks("AnyUp")
		self.frame.button:SetAttribute("type1", "target")
		self.frame.button:SetAttribute("type2", "menu")
		self.frame.button:SetAttribute("unit", self.unit)

		-- set up click casting
		ClickCastFrames = ClickCastFrames or {}
		ClickCastFrames[self.frame.button] = true

-- Parnic - debug code for showing the clickable region on this bar
--		self.frame.button:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",
--						edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
--						tile = false,
--						insets = { left = 0, right = 0, top = 0, bottom = 0 }});
--		self.frame.button:SetBackdropColor(0,0,0,1);
	else
		if self.frame.button then
			self.frame.button:EnableMouse(false)
			self.frame.button:RegisterForClicks()

			self.frame.button = nil
		end
	end
end


function IceTargetHealth.prototype:UpdateEvent(event, unit)
	self:Update(unit)
end

function IceTargetHealth.prototype:Update(unit)
	IceTargetHealth.super.prototype.Update(self)

	if (unit and (unit ~= self.unit)) then
		return
	end

	if unit and not (UnitExists(unit)) then
--		self:Show(false)
		return
	else
--		self:Show(true)
	end

	self:UpdateRaidTargetIcon()

	local classification = UnitClassification(self.unit);
	if not self.moduleSettings.showClassificationIcon then
		self:DestroyTexFrame(self.barFrame.classIcon)
	else
		if not self.barFrame.classIcon then
			self.barFrame.classIcon = self:CreateTexCoord(self.barFrame.classIcon, self.EliteTexture, self.texWidth, self.texHeight,
						self.moduleSettings.scale / 3.0 * self.moduleSettings.classIconScale, self.classLeft, self.classRight, self.classTop, self.classBottom)
		end

		if self.moduleSettings.classIconOnTop then
			self.barFrame.classIcon:SetDrawLayer("OVERLAY")
		else
			self.barFrame.classIcon:SetDrawLayer("BACKGROUND")
		end

		self:SetTexLoc(self.barFrame.classIcon, self.moduleSettings.classIconOffset['x'], self.moduleSettings.classIconOffset['y'])
		self.barFrame.classIcon:Show()
		self.barFrame.classIcon:SetAlpha(self.alpha == 0 and 0 or math.min(1, self.alpha + 0.2))

		if self.configMode or IceHUD.IceCore:IsInConfigMode() or classification == "worldboss" or classification == "elite" then
			self.barFrame.classIcon:SetTexture(self.EliteTexture)
		elseif classification == "rareelite" then
			self.barFrame.classIcon:SetTexture(self.RareEliteTexture)
		elseif classification == "rare" then
			self.barFrame.classIcon:SetTexture(self.RareTexture)
		else
			self:DestroyTexFrame(self.barFrame.classIcon)
			self.barFrame.classIcon:Hide()
		end
	end

	if self.determineColor then
		self.color = "TargetHealthFriendly" -- friendly > 4

		local reaction = UnitReaction("target", "player")
		if (reaction and (reaction == 4)) then
			self.color = "TargetHealthNeutral"
		elseif (reaction and (reaction < 4)) then
			self.color = "TargetHealthHostile"
		end

		if (self.moduleSettings.classColor) and (not self.moduleSettings.npcHostilityColor or UnitPlayerControlled("target")) then
			self.color = self.unitClass
		end

		if (self.moduleSettings.scaleHealthColor) then
			self.color = "ScaledHealthColor"
		end

		if (self.tapped) then
			self.color = "Tapped"
		end
	end

	self:UpdateBar(self.healthPercentage, self.color)

	if not IceHUD.IceCore:ShouldUseDogTags() then
		self:SetBottomText1(math.floor(self.healthPercentage * 100))

		if self.moduleSettings.abbreviateHealth then
			self.health = self:Round(self.health)
			self.maxHealth = self:Round(self.maxHealth)
		end

		if (self.maxHealth ~= 100) then
			self:SetBottomText2(self:GetFormattedText(self.health, self.maxHealth), self.color)
		else
			self:SetBottomText2()
		end
	end

	self:CheckPvP()
	self:CheckPartyRole()
	self:SetIconAlpha()
end


function IceTargetHealth.prototype:CreateTexCoord(texframe, icon, width, height, scale, left, right, top, bottom)
	if not texframe then
		texframe = self.barFrame:CreateTexture(nil, "BACKGROUND")
	end

	texframe:SetTexture(icon)
	if left and right and top and bottom then
		texframe:SetTexCoord(left, right, top, bottom)
	end
	self:SetTexScale(texframe, width, height, scale or 1)

	return texframe
end


function IceTargetHealth.prototype:SetTexLoc(texframe, xpos, ypos, anchorFrom, anchorTo)
	texframe:Show()
	texframe:ClearAllPoints()
	texframe:SetPoint(anchorFrom or "TOPLEFT", self.frame, anchorTo or "TOPLEFT", xpos or 0, ypos or 0)
end


function IceTargetHealth.prototype:SetTexScale(texframe, width, height, scale)
	texframe:SetWidth(width * scale)
	texframe:SetHeight(height * scale)
end


function IceTargetHealth.prototype:DestroyTexFrame(texframe)
	if not texframe then
		return nil
	end

	texframe:SetTexture(nil)
	texframe:Hide()
	texframe:ClearAllPoints()

	return texframe
end


function IceTargetHealth.prototype:CreateFrame()
	IceTargetHealth.super.prototype.CreateFrame(self)

	-- for showing/hiding the frame based on unit visibility
	self.frame:SetAttribute("unit", self.unit)
end



function IceTargetHealth.prototype:CreateRaidIconFrame()
	if (not self.frame.raidIcon) then
		self.frame.raidIcon = CreateFrame("Frame", nil, self.frame)
	end

	if (not self.frame.raidIcon.icon) then
		self.frame.raidIcon.icon = self.frame.raidIcon:CreateTexture(nil, "BACKGROUND")
		self.frame.raidIcon.icon:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
	end

	self:SetRaidIconPlacement()
	self:SetTexScale(self.frame.raidIcon, self.raidIconWidth, self.raidIconHeight, self.moduleSettings.raidIconScale)

	self.frame.raidIcon.icon:SetAllPoints(self.frame.raidIcon)
	SetRaidTargetIconTexture(self.frame.raidIcon.icon, 0)
	self.frame.raidIcon:Hide()
end

function IceTargetHealth.prototype:SetRaidIconPlacement()
	self.frame.raidIcon:ClearAllPoints()
	self.frame.raidIcon:SetPoint("BOTTOM", self.frame, "TOPLEFT", self.moduleSettings.raidIconXOffset, self.moduleSettings.raidIconYOffset)
end


function IceTargetHealth.prototype:UpdateRaidTargetIcon()
	if self.moduleSettings.raidIconOnTop then
		self.frame.raidIcon:SetFrameStrata("MEDIUM")
	else
		self.frame.raidIcon:SetFrameStrata("LOW")
	end

	if not self.moduleSettings.showRaidIcon or (not UnitExists(self.unit) and (not self.configMode and not IceHUD.IceCore:IsInConfigMode())) then
		self.frame.raidIcon:Hide()
		return
	end

	local index = (IceHUD.IceCore:IsInConfigMode() or self.configMode) and 1 or GetRaidTargetIndex(self.unit);

	if (index and (index > 0)) then
		SetRaidTargetIconTexture(self.frame.raidIcon.icon, index)
		self.frame.raidIcon:Show()
	else
		self.frame.raidIcon:Hide()
	end

	if self.frame.raidIcon then
		self.frame.raidIcon:SetAlpha(self.moduleSettings.lockIconAlpha and 1 or self.alpha)
	end
end


function IceTargetHealth.prototype:Round(health)
	if (health > 1000000) then
		return IceHUD:MathRound(health/1000000, 1) .. "M"
	end
	if (health > 1000) then
		return IceHUD:MathRound(health/1000, 1) .. "k"
	end
	return health
end


function IceTargetHealth.prototype:CheckPvP()
	local pvpMode = nil
	local minx, maxx, miny, maxy

	if self.configMode or UnitIsPVPFreeForAll(self.unit) then
		pvpMode = "FFA"

		minx, maxx, miny, maxy = 0.05, 0.605, 0.015, 0.57
	elseif UnitIsPVP(self.unit) then
		pvpMode = UnitFactionGroup(self.unit)

		if pvpMode == "Alliance" then
			minx, maxx, miny, maxy = 0.07, 0.58, 0.06, 0.57
		else
			minx, maxx, miny, maxy = 0.08, 0.58, 0.045, 0.545
		end
	end

	if pvpMode then
		if self.configMode or self.moduleSettings.showPvPIcon then
			self.barFrame.PvPIcon = self:CreateTexCoord(self.barFrame.PvPIcon, "Interface\\TargetingFrame\\UI-PVP-"..pvpMode, 20, 20,
						self.moduleSettings.PvPIconScale, minx, maxx, miny, maxy)
			self:SetTexLoc(self.barFrame.PvPIcon, self.moduleSettings.PvPIconOffset['x'], self.moduleSettings.PvPIconOffset['y'])

			if self.moduleSettings.PvPIconOnTop then
				self.barFrame.PvPIcon:SetDrawLayer("OVERLAY")
			else
				self.barFrame.PvPIcon:SetDrawLayer("BACKGROUND")
			end
		elseif self.barFrame.PvPIcon and self.barFrame.PvPIcon:IsVisible() then
			self.barFrame.PvPIcon = self:DestroyTexFrame(self.barFrame.PvPIcon)
		end
	else
		if self.barFrame.PvPIcon and self.barFrame.PvPIcon:IsVisible() then
			self.barFrame.PvPIcon = self:DestroyTexFrame(self.barFrame.PvPIcon)
		end
	end
end

function IceTargetHealth.prototype:SetIconAlpha()
	if self.barFrame.PvPIcon then
		self.barFrame.PvPIcon:SetAlpha(self.moduleSettings.lockIconAlpha and 1 or self.alpha)
	end
	if self.frame.PartyRoleIcon then
		self.frame.PartyRoleIcon:SetAlpha(self.moduleSettings.lockIconAlpha and 1 or self.alpha)
	end
end



function IceTargetHealth.prototype:ShowBlizz()
	TargetFrame:Show()
	TargetFrame:GetScript("OnLoad")(TargetFrame)

	ComboFrame:Show()
	ComboFrame:GetScript("OnLoad")(ComboFrame)
end


function IceTargetHealth.prototype:HideBlizz()
	TargetFrame:Hide()
	TargetFrame:UnregisterAllEvents()

	ComboFrame:Hide()
	ComboFrame:UnregisterAllEvents()
end

function IceTargetHealth.prototype:UpdateBar(scale, color, alpha)
	IceTargetHealth.super.prototype.UpdateBar(self, scale, color, alpha)
--[[ seems to be causing taint. oh well
	if self.frame.button then
		if self.alpha == 0 then
			self.frame.button:Hide()
		else
			self.frame.button:Show()
		end
	end
]]
end

function IceTargetHealth.prototype:CheckPartyRole()
	local IsLFGParty
	local mode, submode

	mode, submode= GetLFGMode()
	IsLFGParty = (mode ~= nil and mode ~= "abandonedInDungeon" and mode ~= "queued")

	if self.configMode or IsLFGParty then
		if self.configMode or self.moduleSettings.showPartyRoleIcon then
			local isTank, isHeal, isDPS
			local proposalExists, typeID, id, name
			local texture, role, hasResponded, totalEncounters, completedEncounters, numMembers, isleader
			proposalExists, typeID, id, name, texture, role, hasResponded, totalEncounters, completedEncounters, numMembers, isleader = GetLFGProposal()

			local p = self.unit
			if IceHUD.WowVer < 40000 then
				isTank, isHeal, isDPS = UnitGroupRolesAssigned(p)
			else
				local grpRole = UnitGroupRolesAssigned(p)
				isTank = (grpRole == "TANK")
				isHeal = (grpRole == "HEALER")
				isDPS = (grpRole == "DAMAGER")
			end

			if proposalExists == true then
			      isTank = (role == "TANK")
			      isHeal = (role == "HEALER")
			      isDPS = (role == "DAMAGER")
			end

			if proposalExists == nil then
				hasResponded = false
				proposalExists = false
			end

			if hasResponded == false then
				if proposalExists == true then
					isTank = (role == "TANK")
					isHeal = (role == "HEALER")
					isDPS = (role == "DAMAGER")
				end
			else
				isTank = not hasResponded
				isHeal = not hasResponded
				isDPS = not hasResponded
			end

			if isTank then
				self.frame.PartyRoleIcon = self:CreateTexCoord(self.frame.PartyRoleIcon, "Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES", 20, 20, self.moduleSettings.PartyRoleIconScale, 0/64, 19/64, 22/64, 41/64)
			elseif isHeal then
				self.frame.PartyRoleIcon = self:CreateTexCoord(self.frame.PartyRoleIcon, "Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES", 20, 20, self.moduleSettings.PartyRoleIconScale, 20/64, 39/64, 1/64, 20/64)
			elseif isDPS then
				self.frame.PartyRoleIcon = self:CreateTexCoord(self.frame.PartyRoleIcon, "Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES", 20, 20, self.moduleSettings.PartyRoleIconScale, 20/64, 39/64, 22/64, 41/64)
			elseif self.configMode then
				self.frame.PartyRoleIcon = self:CreateTexCoord(self.frame.PartyRoleIcon, "Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES", 20, 20, self.moduleSettings.PartyRoleIconScale, 0/64, 19/64, 1/64, 20/64)
			else
				self.frame.PartyRoleIcon = self:DestroyTexFrame(self.frame.PartyRoleIcon)
			end
			self:SetTexLoc(self.frame.PartyRoleIcon, self.moduleSettings.PartyRoleIconOffset['x'], self.moduleSettings.PartyRoleIconOffset['y'])
			self:SetIconAlpha()
		elseif not self.configMode and not self.moduleSettings.showPartyRoleIcon then
			self.frame.PartyRoleIcon = self:DestroyTexFrame(self.frame.PartyRoleIcon)
		end
	else
		self.frame.PartyRoleIcon = self:DestroyTexFrame(self.frame.PartyRoleIcon)
	end
end

-- Load us up
IceHUD.TargetHealth = IceTargetHealth:new()
