local addonName, addon = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local templates = addon.templates


local splash = CreateFrame("MessageFrame", nil, UIParent)
splash:SetMovable(true)
splash:RegisterForDrag("LeftButton")
splash:SetSize(512, 96)
splash:SetScript("OnMouseUp", function(self, button)
	if button == "RightButton" then
		if self.profile.enabled then
			addon.RegisterCallback(splash, "NewRecord")
		end
		self:SetFrameStrata("MEDIUM")
		self:EnableMouse(false)
		self:SetFading(true)
		self:Clear()
	end
end)
splash:SetScript("OnDragStart", splash.StartMoving)
splash:SetScript("OnDragStop", function(self)
	self:StopMovingOrSizing()
	local pos = self.profile.pos
	pos.point, pos.x, pos.y = select(3, self:GetPoint())
end)


do	-- create the options frame
	local config = templates:CreateConfigFrame(L["Splash frame"], addonName, true)

	local options = {}
	splash.options = options

	local checkButtons = {
		{
			text = L["Enabled"],
			tooltipText = L["Shows the new record on the middle of the screen."],
			setting = "enabled",
			func = function(self)
				if self:GetChecked() then
					if not splash:IsMouseEnabled() then
						addon.RegisterCallback(splash, "NewRecord")
					end
				else
					addon.UnregisterCallback(splash, "NewRecord")
				end
			end,
		},
		{
			text = L["Show old record"],
			tooltipText = L["Display previous record along with \"New record\" messages."],
			setting = "oldRecord",
		},
		{
			text = L["Use combat text splash"],
			tooltipText = L["Enable to use scrolling combat text for \"New record\" messages instead of the default splash frame."],
			setting = "sct",
		},
	}

	options.checkButtons = checkButtons

	for i, v in ipairs(checkButtons) do
		local btn = templates:CreateCheckButton(config, v)
		if i == 1 then
			btn:SetPoint("TOPLEFT", config.title, "BOTTOMLEFT", -2, -16)
		else
			btn:SetPoint("TOP", checkButtons[i - 1], "BOTTOM", 0, -8)
		end
		btn.module = splash
		checkButtons[i] = btn
	end

	options.colorButtons = {}

	-- splash frame spell name color
	local spellColor = templates:CreateColorButton(config)
	spellColor:SetPoint("TOP", checkButtons[#checkButtons], "BOTTOM", 0, -13)
	spellColor:SetText(L["Spell color"])
	spellColor.tooltipText = L["Sets the color for the spell text in the splash frame."]
	spellColor.setting = "spell"
	options.colorButtons[1] = spellColor

	-- splash frame amount color
	local amountColor = templates:CreateColorButton(config)
	amountColor:SetPoint("TOP", spellColor, "BOTTOM", 0, -18)
	amountColor:SetText(L["Amount color"])
	amountColor.tooltipText = L["Sets the color for the amount text in the splash frame."]
	amountColor.setting = "amount"
	options.colorButtons[2] = amountColor

	local sliders = {
		{
			text = L["Scale"],
			tooltipText = L["Sets the scale of the splash frame."],
			minValue = 0.5,
			maxValue = 1,
			valueStep = 0.05,
			minText = "50%",
			maxText = "100%",
			func = function(self)
				local value = self:GetValue()
				self.value:SetFormattedText("%.0f%%", value * 100)
				local os = splash:GetScale()
				splash:SetScale(value)
				local point, relativeTo, relativePoint, xOff, yOff = splash:GetPoint()
				splash:SetPoint(point, relativeTo, relativePoint, (xOff*os/value), (yOff*os/value))
				splash.profile.scale = value
			end,
		},
		{
			text = L["Duration"],
			tooltipText = L["Sets the time (in seconds) the splash frame is visible before fading out."],
			minValue = 0,
			maxValue = 5,
			valueStep = 0.5,
			func = function(self)
				local value = self:GetValue()
				self.value:SetText(value)
				splash:SetTimeVisible(value)
				splash.profile.duration = value
			end,
		},
	}

	options.sliders = sliders

	for i, v in ipairs(sliders) do
		local slider = templates:CreateSlider(config, v)
		if i == 1 then
			slider:SetPoint("TOPLEFT", amountColor, "BOTTOMLEFT", 4, -24)
		else
			slider:SetPoint("TOP", sliders[i - 1], "BOTTOM", 0, -32)
		end
		sliders[i] = slider
	end

	local moveSplash = templates:CreateButton(config)
	moveSplash:SetPoint("TOP", sliders[2], "BOTTOM", 0, -24)
	moveSplash:SetSize(148, 22)
	moveSplash:SetText(L["Move splash screen"])
	moveSplash:SetScript("OnClick", function()
		-- don't want to be interrupted by new records
		addon.UnregisterCallback(splash, "NewRecord")
		splash:SetFrameStrata("DIALOG")
		splash:EnableMouse(true)
		splash:SetFading(false)
		splash:Clear()
		local colors = splash.profile.colors
		splash:AddMessage(L["Critline splash frame unlocked"], colors.spell)
		splash:AddMessage(L["Drag to move"], colors.amount)
		splash:AddMessage(L["Right-click to lock"], colors.amount)
	end)
	options.button = moveSplash
	
	local menu = {
		onClick = function(self)
			self.owner:SetSelectedValue(self.value)
			local font = splash.profile.font
			font.name = self.value
			splash:SetFont(format("Fonts\\%s.ttf", font.name), font.size, font.flags)
		end,
		{
			text = "Arial Narrow",
			value = "ARIALN",
		},
		{
			text = "Friz Quadrata",
			value = "FRIZQT__",
		},
		{
			text = "Morpheus",
			value = "MORPHEUS",
		},
		{
			text = "Skurri",
			value = "skurri",
		},
	}
	
	local font = templates:CreateDropDownMenu("CritlineSplashFont", config, menu)
	font:SetFrameWidth(120)
	font:SetPoint("TOPLEFT", config.title, "BOTTOM", 0, -28)
	font.label:SetText(L["Font"])
	options.font = font
	
	local menu = {
		onClick = function(self)
			self.owner:SetSelectedValue(self.value)
			local font = splash.profile.font
			font.flags = self.value
			splash:SetFont(format("Fonts\\%s.ttf", font.name), font.size, font.flags)
		end,
		{
			text = L["None"],
			value = "",
		},
		{
			text = L["Normal"],
			value = "OUTLINE",
		},
		{
			text = L["Thick"],
			value = "THICKOUTLINE",
		},
	}
	
	local fontFlags = templates:CreateDropDownMenu("CritlineSplashFontFlags", config, menu)
	fontFlags:SetFrameWidth(120)
	fontFlags:SetPoint("TOP", font, "BOTTOM", 0, -16)
	fontFlags.label:SetText(L["Font outline"])
	options.fontFlags = fontFlags
	
	local fontSize = templates:CreateSlider(config, {
		text = L["Font size"],
		tooltipText = L["Sets the font size of the splash frame."],
		minValue = 8,
		maxValue = 30,
		valueStep = 1,
		func = function(self)
			local value = self:GetValue()
			self.value:SetText(value)
			local font = splash.profile.font
			font.size = value
			splash:SetFont(format("Fonts\\%s.ttf", font.name), font.size, font.flags)
		end,
	})
	fontSize:SetPoint("TOP", fontFlags, "BOTTOM", 0, -24)
	options.fontSize = fontSize
end


local defaults = {
	profile = {
		enabled = true,
		oldRecord = false,
		sct = false,
		scale = 1,
		duration = 2,
		font = {
			name = "skurri",
			size = 30,
			flags = "OUTLINE",
		},
		colors = {
			spell = {r = 1, g = 1, b = 0},
			amount = {r = 1, g = 1, b = 1},
		},
		pos = {
			point = "CENTER"
		},
	}
}

function splash:AddonLoaded()
	self.db = addon.db:RegisterNamespace("splash", defaults)
	addon.RegisterCallback(self, "SettingsLoaded", "LoadSettings")
end

addon.RegisterCallback(splash, "AddonLoaded")


function splash:LoadSettings()
	self.profile = self.db.profile
	local options = self.options
	
	for _, btn in ipairs(options.checkButtons) do
		btn:LoadSetting()
	end
	
	local colors = self.profile.colors
	for _, btn in ipairs(options.colorButtons) do
		local color = colors[btn.setting]
		btn.swatch:SetVertexColor(color.r, color.g, color.b)
		btn.color = color
	end
	
	local font = self.profile.font
	self:SetFont(format("Fonts\\%s.ttf", font.name), font.size, font.flags)
	
	options.font:SetSelectedValue(font.name)
	options.fontFlags:SetSelectedValue(font.flags)
	options.fontSize:SetValue(font.size)
	
	local pos = self.profile.pos
	self:ClearAllPoints()
	self:SetPoint(pos.point, pos.x, pos.y)
	
	local sliders = options.sliders
	sliders[1]:SetValue(self.profile.scale)
	sliders[2]:SetValue(self.profile.duration)
end


local addMessage = splash.AddMessage

function splash:AddMessage(msg, color, ...)
	addMessage(self, msg, color.r, color.g, color.b, ...)
end


local red1 = {r = 1, g = 0, b = 0}
local red255 = {r = 255, g = 0, b = 0}

function splash:NewRecord(event, spell, amount, crit, oldAmount)
	spell = format(L["New %s record!"], spell)
	if splash.profile.oldRecord and oldAmount > 0 then
		amount = format("%d (%d)", amount, oldAmount)
	end
	
	local colors = splash.profile.colors
	local spellColor = colors.spell
	local amountColor = colors.amount
	
	if splash.profile.sct then
		-- check if any custom SCT addon is loaded and use it accordingly
		if MikSBT then
			if crit then
				MikSBT.DisplayMessage(L["Critical!"], nil, true, 255, 0, 0)
			end
			MikSBT.DisplayMessage(spell, nil, true, spellColor.r * 255, spellColor.g * 255, spellColor.b * 255)
			MikSBT.DisplayMessage(amount, nil, true, amountColor.r * 255, amountColor.g * 255, amountColor.b * 255)
		elseif SCT then
			if crit then
				SCT:DisplayMessage(L["Critical!"], red255)
			end
			SCT:DisplayMessage(spell, spellColor)
			SCT:DisplayMessage(amount, amountColor)
		elseif Parrot then
			local Parrot = Parrot:GetModule("Display")
			Parrot:ShowMessage(amount, nil, true, amountColor.r, amountColor.g, amountColor.b)
			Parrot:ShowMessage(spell, nil, true, spellColor.r, spellColor.g, spellColor.b)
			if crit then
				Parrot:ShowMessage(L["Critical!"], nil, true, 1, 0, 0)
			end
		elseif SHOW_COMBAT_TEXT == "1" then
			CombatText_AddMessage(amount, CombatText_StandardScroll, amountColor.r, amountColor.g, amountColor.b)
			CombatText_AddMessage(spell, CombatText_StandardScroll, spellColor.r, spellColor.g, spellColor.b)
			if crit then
				CombatText_AddMessage(L["Critical!"], CombatText_StandardScroll, 1, 0, 0)
			end
		end
	else
		self:Clear()
		if crit then
			self:AddMessage(L["Critical!"], red1)
		end
		self:AddMessage(spell, spellColor)
		self:AddMessage(amount, amountColor)
	end
end