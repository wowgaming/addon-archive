local BCT = LibStub("LibBabble-CreatureType-3.0"):GetUnstrictLookupTable()

local core = LibStub("AceAddon-3.0"):GetAddon("SilverDragon")
local module = core:NewModule("ClickTarget", "AceEvent-3.0")

function module:OnInitialize()
	self.db = core.db:RegisterNamespace("ClickTarget", {
		profile = {
			show = true,
			model = true,
			camera = 0,
			sources = {
				target = false,
				grouptarget = true,
				cache = true,
				mouseover = true,
				nameplate = true,
			},
		},
	})
	core.RegisterCallback(self, "Seen")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterEvent("MODIFIER_STATE_CHANGED")

	local config = core:GetModule("Config", true)
	if config then
		local function toggle(name, desc, order)
			return {type = "toggle", name = name, desc = desc, order=order,}
		end
		config.options.plugins.clicktarget = {
			clicktarget = {
				type = "group",
				name = "ClickTarget",
				get = function(info) return self.db.profile[info[#info]] end,
				set = function(info, v) self.db.profile[info[#info]] = v; self:ShowModel() end,
				args = {
					about = {
						type = "description",
						name = "Once you've found a rare, it can be nice to actually target it. So this pops up a frame that targets the rare when you click on it. It can show a 3d model of that rare, but only if we already know the ID of the rare (though a data import), or if it was found by being targetted. Nameplates are right out.",
						order = 0,
					},
					show = toggle("Show", "Show the click-target frame.", 10),
					model = toggle("Model", "Show a 3d model of the rare, if possible.", 20),
					sources = {
						type="multiselect",
						name = "Rare Sources",
						desc = "Which ways of finding a rare should cause this frame to appear?",
						get = function(info, key) return self.db.profile.sources[key] end,
						set = function(info, key, v) self.db.profile.sources[key] = v end,
						values = {
							target = "Targets",
							grouptarget = "Group targets",
							mouseover = "Mouseover",
							nameplate = "Nameplates",
							cache = "Unit cache",
						},
					},
					camera = {
						type = "select",
						name = "Model style",
						desc = "How to display the model",
						values = {
							[0] = "Portrait",
							[1] = "Full body",
						},
					},
				},
			},
		}
	end
end

local current = {}
function module:ShowFrame()
	local zone, name, unit = current.zone, current.name, current.unit
	if not (zone and name) then return end

	local num_locations, level, elite, creature_type, lastseen, count, id, tameable = core:GetMob(zone, name)
	local popup = self.popup
	popup:SetAttribute("macrotext", "/cleartarget\n/targetexact "..name)
	popup:Enable()
	popup:Show()

	self:ShowModel()

	popup:SetText(name)
	popup.details:SetText(("%s%s %s"):format(level or '??', elite and '+' or '', creature_type and BCT[creature_type] or ''))

	local model = popup.model
end

function module:ShowModel()
	local popup = self.popup
	local model, title, details = popup.model, popup.title, popup.details

	model:ClearAllPoints()
	if self.db.profile.model and self.db.profile.camera == 0 then
		-- portrait
		model:SetHeight(popup:GetHeight() - 20)
		model:SetWidth(popup:GetHeight() - 20)
		model:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -2)
		model:SetPoint("BOTTOMLEFT", popup, "BOTTOMLEFT", 6, 6)
		details:SetPoint("TOPLEFT", model, "TOPRIGHT", 2, -2)
	else
		-- full-body or hidden-model (works for both because the model is totally out of
		-- the way for the full-body case.)
		model:SetHeight(popup:GetHeight() * 3)
		model:SetWidth(popup:GetWidth())
		model:SetPoint("BOTTOMLEFT", popup, "TOPLEFT", 0, -4)
		details:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -2)
	end
	if self.db.profile.model then
		model:Show()
		model:ClearModel()
		local id, unit = current.id, current.unit
		if id or unit then
			if id then
				model:SetCreature(id)
			else
				model:SetUnit(unit)
			end
			model:SetCamera(self.db.profile.camera)
			if self.db.profile.camera == 1 then
				model:SetModelScale(0.7)
			end
		else
			-- This is, indeed, an exact copy of the settings used in PitBull
			-- That's fine, since I wrote those settings myself. :D
			model:SetModelScale(4.25)
			model:SetPosition(0, 0, -1.5)
			model:SetModel([[Interface\Buttons\talktomequestionmark.mdx]])
		end
	else
		model:Hide()
	end

end

function module:Seen(callback, zone, name, x, y, dead, newloc, source, unit, id)
	if not self.db.profile.sources[source] then return end
	current.zone = zone
	current.name = name
	current.id = id
	current.unit = unit
	if InCombatLockdown() then
		current.pending = true
	else
		self:ShowFrame()
	end
	current.unit = nil -- can't be trusted to remain the same
end

function module:PLAYER_REGEN_ENABLED()
	if current.pending then
		current.pending = nil
		self:ShowFrame()
	end
end

function module:MODIFIER_STATE_CHANGED(event, modifier, state)
	if modifier:sub(2) == "ALT" then
		self:ToggleDrag(state == 1)
	end
end

function module:ToggleDrag(state)
	local dragger = self.popup.drag
	dragger:ClearAllPoints()
	if state then
		dragger:SetAllPoints()
	else
		dragger:SetPoint("TOP", UIParent, "TOP", math.huge)
	end
end

-- And set up the frame
local popup = CreateFrame("Button", "SilverDragonPopupButton", nil, "SecureActionButtonTemplate")
module.popup = popup

popup:SetWidth(190)
popup:SetHeight(70)
popup:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -260, 270)
popup:SetMovable(true)
popup:SetUserPlaced(true)
popup:SetClampedToScreen(true)
popup:SetFrameStrata("FULLSCREEN_DIALOG")
popup:SetNormalTexture("Interface\\AchievementFrame\\UI-Achievement-Parchment-Horizontal")

local back = popup:GetNormalTexture()
back:SetDrawLayer("BACKGROUND")
back:ClearAllPoints()
back:SetPoint("BOTTOMLEFT", 3, 3)
back:SetPoint("TOPRIGHT", -3, -3)
back:SetTexCoord(0, 1, 0, 0.25)

-- Just a note:
-- The anchors in this next section are incomplete. The frame isn't finished until
-- module.ShowModel is called.
local title = popup:CreateFontString(nil, "OVERLAY", "GameFontHighlightMedium");
popup.title = title
title:SetPoint("TOPLEFT", popup, "TOPLEFT", 6, -6)
title:SetPoint("RIGHT", popup, "RIGHT", -4, 0)
popup:SetFontString(title)

local model = CreateFrame("PlayerModel", nil, popup)
popup.model = model

local details = popup:CreateFontString(nil, "OVERLAY", "GameFontBlackTiny")
popup.details = details
details:SetPoint("RIGHT", title)

local subtitle = popup:CreateFontString(nil, "OVERLAY", "GameFontBlackTiny")
popup.subtitle = subtitle
subtitle:SetPoint("TOPLEFT", details, "BOTTOMLEFT", 0, -4)
subtitle:SetPoint("RIGHT", details)
subtitle:SetText("Click to Target")

-- Border
popup:SetBackdrop({
	tile = true, edgeSize = 16,
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
})
popup:SetBackdropBorderColor( 0.7, 0.15, 0.05 )

-- Drag frame
popup.drag = popup:CreateTitleRegion()

-- Close button
local close = CreateFrame("Button", nil, popup, "UIPanelCloseButton,SecureHandlerClickTemplate")
popup.close = close
close:SetPoint("TOPLEFT", popup, "TOPRIGHT", -5, 0)
close:SetWidth(26)
close:SetHeight(26)
close:SetHitRectInsets(8, 8, 8, 8)
close:SetAttribute("_onclick", [[
	local button = self:GetParent()
	button:Disable()
	button:Hide()
]])

-- Flash frame
local glow = CreateFrame("Frame", "$parentGlow", popup)
popup.glow = glow
glow:SetPoint("CENTER")
glow:SetWidth(400 / 300 * popup:GetWidth())
glow:SetHeight(171 / 88 * popup:GetHeight())
local texture = glow:CreateTexture(nil, "OVERLAY")
texture:SetAllPoints()
texture:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Alert-glow")
texture:SetBlendMode("ADD")
texture:SetTexCoord(0, 0.78125, 0, 0.66796875)

popup:SetAttribute("type", "macro")

local on_enter = function() popup:SetBackdropBorderColor(1, 1, 0.15) end
local on_leave = function() popup:SetBackdropBorderColor(0.7, 0.15, 0.05) end
local on_show = function()
	UIFrameFadeRemoveFrame(popup.glow)
	UIFrameFlashRemoveFrame(popup.glow)
	UIFrameFlash(popup.glow, 0.1, 0.7, 0.8)
	
	local model = popup.model
	model:ClearModel()
	model:SetPosition(0, 0, 0)
	model:SetFacing(0)
end

popup:SetScript("OnEnter", on_enter)
popup:SetScript("OnLeave", on_leave)
popup:SetScript("OnShow", on_show)

-- a few setup things:
popup:Hide()
on_leave() -- border colors
module:ToggleDrag(false)

