local SLOT_COORD_BASE = { 0, 0.130859375, 0.392578125, 0.5234375, 0.26171875, 0.654296875 }

local function Glyph_StartAnimation(self)
	local sparkle = self.sparkle
	local enabled, _, spell = GetGlyphSocketInfo(self.id, self:GetParent().group)
	if enabled and spell then
		sparkle:Show()
		sparkle.anim:Play()
	else
		sparkle:Hide()
		sparkle.anim:Stop()
	end
end

local function Glyph_StopAnimation(self)
	local sparkle = self.sparkle
	sparkle:Hide()
	sparkle.anim:Stop()
end

local function Glyph_OnEnter (self)
	local id, group = self.id, self:GetParent().group
	if GetGlyphSocketInfo(id, group) then
		self.highlight:Show()
	end
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetGlyph(id, group)
	GameTooltip:Show()
	self.hasCursor = true
end

local function Glyph_OnLeave (self)
	self.highlight:Hide()
	if GameTooltip:IsOwned(self) then
		GameTooltip:Hide()
	end
	self.hasCursor = nil
end

local function Glyph_Update(self)
	local id, group = self.id, self:GetParent().group
	local enabled, type, spell, icon = GetGlyphSocketInfo(id, group)

	self.highlight:Hide()
	if not enabled then
		self.setting:SetTexture"Interface\\Spellbook\\UI-GlyphFrame-Locked"
		self.setting:SetTexCoord(.1, .9, .1, .9)
		self.background:Hide()
		self.glyph:Hide()
		self.ring:Hide()
		self.shine:Hide()
	else
		self.setting:SetTexture"Interface\\Spellbook\\UI-GlyphFrame"
		self.shine:Show()
		self.background:Show()
		self.ring:Show()

		if type == 2 then -- minor
			self.setting:SetSize(86, 86)
			self.setting:SetTexCoord(0.765625, 0.927734375, 0.15625, 0.31640625)

			self.highlight:SetSize(86, 86)
			self.highlight:SetTexCoord(0.765625, 0.927734375, 0.15625, 0.31640625)

			self.background:SetSize(64, 64)

			self.glyph:SetVertexColor(0, 0.25, 1)

			self.ring:SetSize(62, 62)
			self.ring:SetPoint("CENTER", self, 0, 1)
			self.ring:SetTexCoord(0.787109375, 0.908203125, 0.033203125, 0.154296875)

			self.shine:SetTexCoord(0.9609375, 1, 0.921875, 0.9609375)
		else
			self.setting:SetSize(108, 108)
			self.setting:SetTexCoord(0.740234375, 0.953125, 0.484375, 0.697265625)

			self.highlight:SetSize(108, 108)
			self.highlight:SetTexCoord(0.740234375, 0.953125, 0.484375, 0.697265625)

			self.background:SetSize(70, 70)

			self.glyph:SetVertexColor(1, 0.25, 0)

			self.ring:SetSize(82, 82)
			self.ring:SetPoint("CENTER", self, 0, -1)
			self.ring:SetTexCoord(0.767578125, 0.92578125, 0.32421875, 0.482421875)

			self.shine:SetTexCoord(0.9609375, 1, 0.9609375, 1)
		end
		if not spell then
			self.glyph:Hide()
			self.background:SetTexCoord(0.78125, 0.91015625, 0.69921875, 0.828125)
			if not GlyphMatchesSocket(id) then
				self.background:SetAlpha(1)
			end
		else
			self.glyph:Show()
			self.glyph:SetTexture(icon or "Interface\\Spellbook\\UI-Glyph-Rune1")
			local left = SLOT_COORD_BASE[id]
			self.background:SetTexCoord(left, left + 0.12890625, 0.87109375, 1)
			self.background:SetAlpha(1)
		end
	end

	self.elapsed = 0
	self.tintElapsed = 0
	self:StartAnimation()

	if GameTooltip:IsOwned(self) then
		Glyph_OnEnter(self)
	end
end

local ChatEdit_GetActiveWindow = ChatEdit_GetActiveWindow
if not ChatEdit_GetActiveWindow then
	ChatEdit_GetActiveWindow = function() return ChatFrameEditBox:IsVisible() end
end

local function Glyph_OnClick(self, button)
	local id, group = self.id, self:GetParent().group

	if IsModifiedClick("CHATLINK") and ChatEdit_GetActiveWindow() then
		local link = GetGlyphLink(id, group)
		if link then ChatEdit_InsertLink(link) end
	else
		if group ~= GetActiveTalentGroup() then return end
		if button == "RightButton" then
			if IsShiftKeyDown() then
				local _, _, spell = GetGlyphSocketInfo(id)
				if spell then
					StaticPopup_Show("CONFIRM_REMOVE_GLYPH", GetSpellInfo(spell)).data = id
				end
			end
		elseif self.glyph:IsShown() and GlyphMatchesSocket(id) then
			StaticPopup_Show("CONFIRM_GLYPH_PLACEMENT").data = id
		else
			PlaceGlyphInSocket(id)
		end
	end
end

local function Glyph_OnUpdate(self, elapsed)
	local id, group = self.id, self:GetParent().group
	local enabled, _, spell = GetGlyphSocketInfo(id, group)

	spell = enabled and spell
	enabled = enabled and GlyphMatchesSocket(id)

	local alpha = .6
	if spell or self.elapsed > 0 then
		elapsed = self.elapsed + elapsed
		if elapsed >= 6 then
			elapsed = 0
		elseif elapsed <= 2 then
			alpha = .6 + .2 * elapsed
		elseif elapsed < 4 then
			alpha = 1
		elseif elapsed >= 4 then
			alpha = 1.8 - .2 * elapsed
		end
		self.elapsed = elapsed
	end
	self.setting:SetAlpha(alpha)

	if not spell and enabled then
		local tintElapsed = self.tintElapsed + elapsed

		local left = SLOT_COORD_BASE[id]
		self.background:SetTexCoord(left, left + 0.12890625, 0.87109375, 1)

		self.highlight:Show()

		local alpha = 1
		if elapsed >= 1.4 then
			tintElapsed = 0
		elseif elapsed <= .6 then
			alpha = 1 - elapsed
		elseif elapsed >= .8 then
			alpha = elapsed - .4;
		end

		self.background:SetAlpha(alpha)
		if self.hasCursor then
			self.highlight:SetAlpha(.4 * alpha)
		else
			self.highlight:SetAlpha(.4)
		end
		self.tintElapsed = tintElapsed
	elseif not spell then
		self.background:SetTexCoord(0.78125, 0.91015625, 0.69921875, 0.828125)
		self.background:SetAlpha(1)
		self.highlight:SetAlpha(.4)
	end

	if self.hasCursor and SpellIsTargeting() then
		SetCursor(enabled and "CAST_CURSOR" or "CAST_ERROR_CURSOR")
	end
end

function Talented_MakeGlyph(parent, id)
	local glyph = CreateFrame("Button", nil, parent)
	glyph.id = id

	-- GlyphTemplate
	glyph:SetSize(72, 72)

	local setting = glyph:CreateTexture(nil, "BACKGROUND")
	setting:SetTexture"Interface\\Spellbook\\UI-GlyphFrame"
	setting:SetPoint"CENTER"
	glyph.setting = setting

	local highlight = glyph:CreateTexture(nil, "BORDER")
	highlight:SetTexture"Interface\\Spellbook\\UI-GlyphFrame"
	highlight:SetPoint"CENTER"
	highlight:SetVertexColor(1, 1, 1, .25)
	glyph.highlight = highlight

	local background = glyph:CreateTexture(nil, "BORDER")
	background:SetTexture"Interface\\Spellbook\\UI-GlyphFrame"
	background:SetPoint"CENTER"
	glyph.background = background

	local texture = glyph:CreateTexture(nil, "ARTWORK")
	texture:SetSize(53, 53)
	texture:SetPoint"CENTER"
	glyph.glyph = texture

	local ring = glyph:CreateTexture(nil, "OVERLAY")
	ring:SetTexture"Interface\\Spellbook\\UI-GlyphFrame"
	glyph.ring = ring

	local shine = glyph:CreateTexture(nil, "OVERLAY")
	shine:SetTexture"Interface\\Spellbook\\UI-GlyphFrame"
	shine:SetSize(16, 16)
	shine:SetPoint("CENTER", -9, 12)
	glyph.shine = shine

	glyph.Update = Glyph_Update
	glyph.StartAnimation = Glyph_StartAnimation
	glyph.StopAnimation = Glyph_StopAnimation
	glyph:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	glyph:SetScript("OnClick", Glyph_OnClick)
	glyph:SetScript("OnEnter", Glyph_OnEnter)
	glyph:SetScript("OnLeave", Glyph_OnLeave)
	glyph:SetScript("OnUpdate", Glyph_OnUpdate)

	return glyph
end
