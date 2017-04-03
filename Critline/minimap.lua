local addonName, addon = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local templates = addon.templates


local function onUpdate(self)
	local xpos, ypos = GetCursorPosition()
	local xmin, ymin = Minimap:GetLeft(), Minimap:GetBottom()
	
	xpos = xmin - xpos / Minimap:GetEffectiveScale() + 70
	ypos = ypos / Minimap:GetEffectiveScale() - ymin - 70
	
	self.profile.pos = atan2(ypos, xpos)
	self:Move()
end


local minimap = CreateFrame("Button", nil, Minimap)
minimap:SetToplevel(true)
minimap:SetMovable(true)
minimap:RegisterForClicks("LeftButtonUp", "RightButtonUp")
minimap:RegisterForDrag("LeftButton")
minimap:SetPoint("TOPLEFT", -15, 0)
minimap:SetSize(32, 32)
minimap:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
minimap:Hide()
minimap:SetScript("OnClick", function(self, button)
	local display = addon.display
	if button == "LeftButton" and display then
		if display:IsShown() then
			display:Hide()
		else
			display:Show()
		end
	elseif button == "RightButton" then
		addon:OpenConfig()
	end
end)
minimap:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	GameTooltip:AddLine("Critline")
	if addon.display then
		GameTooltip:AddLine(L["Left-click to toggle summary frame"], HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
	end
	GameTooltip:AddLine(L["Right-click to open options"], HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
	if not self.profile.locked then
		GameTooltip:AddLine(L["Drag to move"], HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
	end
	GameTooltip:Show()
end)
minimap:SetScript("OnLeave", GameTooltip_Hide)
minimap:SetScript("OnDragStart", function(self) self:SetScript("OnUpdate", onUpdate) end)
minimap:SetScript("OnDragStop", function(self) self:SetScript("OnUpdate", nil) end)
minimap:SetScript("OnHide", function(self) self:SetScript("OnUpdate", nil) end)

local icon = minimap:CreateTexture(nil, "BORDER")
icon:SetTexture(addon.icons.dmg)
icon:SetSize(20, 20)
icon:SetPoint("TOPLEFT", 6, -6)

local border = minimap:CreateTexture(nil, "OVERLAY")
border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
border:SetSize(54, 54)
border:SetPoint("TOPLEFT")


local config = templates:CreateConfigFrame(L["Minimap button"], addonName, true)

local options = {
	{
		text = L["Show"],
		tooltipText = L["Show minimap button."],
		setting = "show",
		func = function(self)
			if self:GetChecked() then
				minimap:Show()
			else
				minimap:Hide()
			end
		end,
	},
	{
		text = L["Locked"],
		tooltipText = L["Lock minimap button."],
		setting = "locked",
		func = function(self)
			minimap:RegisterForDrag(not self:GetChecked() and "LeftButton")
		end,
	},
}

for i, v in ipairs(options) do
	local btn = templates:CreateCheckButton(config, v)
	if i == 1 then
		btn:SetPoint("TOPLEFT", config.title, "BOTTOMLEFT", -2, -16)
	else
		btn:SetPoint("TOP", options[i - 1], "BOTTOM", 0, -8)
	end
	btn.module = minimap
	options[i] = btn
end


local defaults = {
	profile = {
		show = true,
		locked = false,
		pos = 0,
	}
}

function minimap:AddonLoaded()
	self.db = addon.db:RegisterNamespace("minimap", defaults)
	addon.RegisterCallback(self, "SettingsLoaded", "LoadSettings")
end

addon.RegisterCallback(minimap, "AddonLoaded")


function minimap:LoadSettings()
	self.profile = self.db.profile
	
	for _, btn in ipairs(options) do
		btn:LoadSetting()
	end
	
	self:Move()
end


function minimap:Move()
	local angle = self.profile.pos
	self:SetPoint("TOPLEFT", (52 - 80 * cos(angle)), (80 * sin(angle) - 52))
end