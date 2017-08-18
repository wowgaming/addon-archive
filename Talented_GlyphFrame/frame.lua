local L = LibStub("AceLocale-3.0"):GetLocale("Talented")

local Talented_MakeGlyph = Talented_MakeGlyph
_G.Talented_MakeGlyph = nil

local GLYPH_POSITIONS = {
	{ "CENTER",      -15,  140, -13, 17,   0,  83 },
	{ "CENTER",      -14, -113, -13, 17,   0, -83 },
	{ "TOPLEFT",      28, -133, -13, 17, -72,  43 },
	{ "BOTTOMRIGHT", -66,  178, -13, 18,  74, -45 },
	{ "TOPRIGHT",    -56, -133, -13, 17,  72,  43 },
	{ "BOTTOMLEFT",   40,  178, -13, 18, -74, -45 },
}

local SPARKLE_DIMENSIONS = { 7, 10, 13 }
local SPARKLE_DURATIONS = { 1.25, 3, 5.4 }
local function Sparkle_Update(self)
	local sparkle = self:GetRegionParent()
	local index = math.random(#SPARKLE_DIMENSIONS)
	local size = SPARKLE_DIMENSIONS[index]
	sparkle:SetSize(size, size)
	self:SetDuration(SPARKLE_DURATIONS[index])
end

local function MakeSparkleAnimation(parent, x, y, dx, dy)
	local sparkle = parent:CreateTexture(nil, "ARTWORK")
	sparkle:SetTexture"Interface\\ItemSocketingFrame\\UI-ItemSockets"
	sparkle:SetPoint("CENTER", x, y)
	sparkle:SetTexCoord(0.3984375, 0.4453125, 0.40234375, 0.44921875)
	sparkle:SetBlendMode"ADD"
	local animGroup = sparkle:CreateAnimationGroup()
	local translation = animGroup:CreateAnimation"Translation"
	animGroup:SetLooping"REPEAT"
	animGroup.translation = translation
	translation:SetStartDelay(0)
	translation:SetEndDelay(0)
	translation:SetSmoothing"IN_OUT"
	translation:SetOrder(1)
	translation:SetMaxFramerate(30)
	translation:SetOffset(dx, dy)
	translation:SetScript("OnFinished", Sparkle_Update)
	Sparkle_Update(translation)
	sparkle.anim = animGroup
	return sparkle
end

local Talented = Talented
local frame = CreateFrame("Frame", "TalentedGlyphs", UIParent)

frame:Hide()
frame:SetFrameStrata("DIALOG")
frame:SetSize(384, 512)
frame:EnableMouse(true)
frame:SetToplevel(true)
frame:SetHitRectInsets(0, 30, 0, 70)

local t = frame:CreateTexture(nil, "BORDER")
t:SetTexture"Interface\\Spellbook\\UI-GlyphFrame"
t:SetSize(352, 441)
t:SetPoint"TOPLEFT"
t:SetTexCoord(0, 0.6875, 0, 0.861328125)
frame.background = t

local p = frame:CreateTexture(nil, "BACKGROUND")
p:SetSize(64, 64)
p:SetPoint("TOPLEFT", 5, -4)
frame.portrait = p

local fs = frame:CreateFontString(nil, "ARTWORK")
fs:SetFontObject(GameFontNormal)
fs:SetText(GLYPHS)
fs:SetPoint("TOP", 0, -17)
frame.title = fs

local glow = frame:CreateTexture(nil, "OVERLAY")
glow:Hide()
glow:SetTexture"Interface\\Spellbook\\UI-GlyphFrame-Glow"
glow:SetBlendMode"ADD"
glow:SetSize(352, 441)
glow:SetPoint("TOPLEFT", -9, -38)
glow:SetTexCoord(0, 0.6875, 0, 0.861328125)
frame.glow = glow

local animGroup = glow:CreateAnimationGroup()
local alpha = animGroup:CreateAnimation"Alpha"
alpha:SetChange(1)
alpha:SetDuration(0.1)
alpha:SetOrder(1)
alpha = animGroup:CreateAnimation"Alpha"
alpha:SetChange(-1)
alpha:SetDuration(1.5)
alpha:SetOrder(2)
glow.anim = animGroup

local function GlowAnimation_Hide(self)
	self:GetParent():Hide()
end

animGroup:SetScript("OnStop", GlowAnimation_Hide)
animGroup:SetScript("OnFinished", GlowAnimation_Hide)

frame:RegisterEvent"GLYPH_ADDED"
frame:RegisterEvent"GLYPH_REMOVED"
frame:RegisterEvent"GLYPH_UPDATED"
frame:RegisterEvent"USE_GLYPH"
frame:RegisterEvent"PLAYER_LEVEL_UP"
frame:RegisterEvent"UNIT_PORTRAIT_UPDATE"
frame:RegisterEvent"ACTIVE_TALENT_GROUP_CHANGED"

frame:SetScript("OnEvent", function (self, event, ...)
	if event == "GLYPH_ADDED" or event == "GLYPH_UPDATED" or event == "GLYPH_REMOVED" then
		if not self:IsShown() then return end
		local id = ...
		self.glyphs[id]:Update()
		local _, type = GetGlyphSocketInfo(id, self.group)
		if event == "GLYPH_REMOVED" then
			PlaySound(type == 2 and "Glyph_MinorDestroy" or "Glyph_MajorDestroy")
		else
			PlaySound(type == 2 and "Glyph_MinorCreate" or "Glyph_MajorCreate")
			self:Glow()
		end
		self:UpdateGroup()
	elseif event == "UNIT_PORTRAIT_UPDATE" and (...) == "player" then
		SetPortraitTexture(self.portrait, "player")
	elseif event == "ACTIVE_TALENT_GROUP_CHANGED" then
		local policy = Talented.db.profile.glyph_on_talent_swap
		if policy == "swap" then
			self.group = 3 - self.group
			self:Update()
		elseif policy == "active" then
			self.group = GetActiveTalentGroup()
			self:Update()
		end
	else
		self:Update()
	end
end)

frame:SetScript("OnEnter", function (self)
	if SpellIsTargeting() then SetCursor"CAST_ERROR_CURSOR" end
end)

frame:SetScript("OnLeave", function (self)
	SetCursor(nil)
end)

frame:SetScript("OnShow", function (self)
	PlaySound"igSpellBookOpen"
	self:StartAnimations()
	local b = Talented.base
	if b and b.bglyphs then
		b.bglyphs:SetButtonState("PUSHED", 1)
	end
	SetPortraitTexture(self.portrait, "player")
end)

frame:SetScript("OnUpdate", function (self)
	-- FIXME: remove this when Blizzard fixes their animation initialisation
	self:SetScript("OnUpdate", nil)
	self:StopAnimations()
	self:StartAnimations()
	self:Glow()
	self.glow.anim:Stop()
end)

frame:SetScript("OnHide", function (self)
	self:StopAnimations()
	local b = Talented.base
	if b and b.bglyphs then
		b.bglyphs:SetButtonState"NORMAL"
	end
end)


function frame:Update()
	if self.group > GetNumTalentGroups() then
		self.group = GetActiveTalentGroup()
	end
	for _, glyph in ipairs(self.glyphs) do
		glyph:Update()
	end
	self:UpdateGroup()
end

function frame:UpdateGroup()
	local cb, alt = self.checkbox, GetNumTalentGroups() > 1
	if alt then
		local talentGroup = GetActiveTalentGroup()
		self.title:SetText(talentGroup == 1 and TALENT_SPEC_PRIMARY_GLYPH or TALENT_SPEC_SECONDARY_GLYPH)
		cb:Show()
		local checked = (self.group ~= talentGroup)
		cb:SetChecked(checked)
		SetDesaturation(self.background, checked)
	else
		cb:Hide()
	end
end

local function GlyphFrame_StartAnimations(self)
	for _, glyph in ipairs(self.glyphs) do
		glyph:StartAnimation()
	end
end

local function GlyphFrame_StopAnimations(self)
	for _, glyph in ipairs(self.glyphs) do
		glyph:StopAnimation()
	end
end

frame.OnMouseDown = GlyphFrame_StopAnimations
frame.OnMouseUp = GlyphFrame_StartAnimations
frame.StartAnimations = GlyphFrame_StartAnimations
frame.StopAnimations = GlyphFrame_StopAnimations

function frame:Glow()
	local glow = self.glow
	glow:SetAlpha(0)
	glow:Show()
	glow.anim:Play()
end

frame.glyphs = {}
frame.group = GetActiveTalentGroup()

for id, position in ipairs(GLYPH_POSITIONS) do
	local glyph = Talented_MakeGlyph(frame, id)
	glyph.sparkle = MakeSparkleAnimation(frame, unpack(position, 4))
	glyph:SetPoint(unpack(position, 1, 3))
	frame.glyphs[id] = glyph
end

frame:SetFrameLevel(5)

local close = Talented:CreateCloseButton(frame)
frame.close = close
close:ClearAllPoints()
close:SetPoint("TOPRIGHT", -28, -9)

local cb = CreateFrame("Checkbutton", nil, frame)
frame.checkbox = cb

local makeTexture = function (path, blend)
	local t = cb:CreateTexture()
	t:SetTexture(path)
	t:SetAllPoints(cb)
	if blend then
		t:SetBlendMode(blend)
	end
	return t
end

cb:SetSize(20, 20)

local fs = cb:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
cb.label = fs
fs:SetJustifyH("LEFT")
fs:SetSize(400, 20)
fs:SetPoint("LEFT", cb, "RIGHT", 1, 1)
cb:SetNormalTexture(makeTexture("Interface\\Buttons\\UI-CheckBox-Up"))
cb:SetPushedTexture(makeTexture("Interface\\Buttons\\UI-CheckBox-Down"))
cb:SetDisabledTexture(makeTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled"))
cb:SetCheckedTexture(makeTexture("Interface\\Buttons\\UI-CheckBox-Check"))
cb:SetHighlightTexture(makeTexture("Interface\\Buttons\\UI-CheckBox-Highlight", "ADD"))
cb:SetScript("OnClick", function (self)
	local talentGroup = GetActiveTalentGroup()
	if self:GetChecked() then
		talentGroup = 3 - talentGroup
	end
	local gframe = self:GetParent()
	gframe.group = talentGroup
	gframe:Update()
end)
cb.label:SetText(L["View glyphs of alternate Spec"])
cb:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 18, 82)
cb:SetFrameLevel(frame:GetFrameLevel()+2)

Talented:LoadFramePosition(frame)
Talented:SetFrameLock(frame)

UISpecialFrames[#UISpecialFrames + 1] = "TalentedGlyphs"
