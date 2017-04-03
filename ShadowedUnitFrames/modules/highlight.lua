local Highlight = {}
local goldColor, mouseColor = {r = 0.75, g = 0.75, b = 0.35}, {r = 0.75, g = 0.75, b = 0.50}
ShadowUF:RegisterModule(Highlight, "highlight", ShadowUF.L["Highlight"])

-- Might seem odd to hook my code in the core manually, but HookScript is ~40% slower due to it being a secure hook
local function OnEnter(frame)
	if( ShadowUF.db.profile.units[frame.unitType].highlight.mouseover ) then
		frame.highlight.hasMouseover = true
		Highlight:Update(frame)
	end
		
	frame.highlight.OnEnter(frame)
end

local function OnLeave(frame)
	if( ShadowUF.db.profile.units[frame.unitType].highlight.mouseover ) then
		frame.highlight.hasMouseover = nil
		Highlight:Update(frame)
	end
		
	frame.highlight.OnLeave(frame)
end

function Highlight:OnEnable(frame)
	if( not frame.highlight ) then
		frame.highlight = CreateFrame("Frame", nil, frame)
		frame.highlight:SetFrameLevel(frame.topFrameLevel)
		frame.highlight:SetAllPoints(frame)
		frame.highlight:SetSize(1, 1)
		
		frame.highlight.top = frame.highlight:CreateTexture(nil, "OVERLAY")
		frame.highlight.top:SetBlendMode("ADD")
		frame.highlight.top:SetTexture("Interface\\AddOns\\ShadowedUnitFrames\\media\\textures\\highlight")
		frame.highlight.top:SetPoint("TOPLEFT", frame, ShadowUF.db.profile.backdrop.inset, -ShadowUF.db.profile.backdrop.inset)
		frame.highlight.top:SetPoint("TOPRIGHT", frame, -ShadowUF.db.profile.backdrop.inset, ShadowUF.db.profile.backdrop.inset)
		frame.highlight.top:SetHeight(30)
		frame.highlight.top:SetTexCoord(0.3125, 0.625, 0, 0.3125)
		frame.highlight.top:SetHorizTile(false)
		
		frame.highlight.left = frame.highlight:CreateTexture(nil, "OVERLAY")
		frame.highlight.left:SetBlendMode("ADD")
		frame.highlight.left:SetTexture("Interface\\AddOns\\ShadowedUnitFrames\\media\\textures\\highlight")
		frame.highlight.left:SetPoint("TOPLEFT", frame, ShadowUF.db.profile.backdrop.inset, -ShadowUF.db.profile.backdrop.inset)
		frame.highlight.left:SetPoint("BOTTOMLEFT", frame, -ShadowUF.db.profile.backdrop.inset, ShadowUF.db.profile.backdrop.inset)
		frame.highlight.left:SetWidth(30)
		frame.highlight.left:SetTexCoord(0, 0.3125, 0.3125, 0.625)
		frame.highlight.left:SetHorizTile(false)

		frame.highlight.right = frame.highlight:CreateTexture(nil, "OVERLAY")
		frame.highlight.right:SetBlendMode("ADD")
		frame.highlight.right:SetTexture("Interface\\AddOns\\ShadowedUnitFrames\\media\\textures\\highlight")
		frame.highlight.right:SetPoint("TOPRIGHT", frame, -ShadowUF.db.profile.backdrop.inset, -ShadowUF.db.profile.backdrop.inset)
		frame.highlight.right:SetPoint("BOTTOMRIGHT", frame, 0, ShadowUF.db.profile.backdrop.inset)
		frame.highlight.right:SetWidth(30)
		frame.highlight.right:SetTexCoord(0.625, 0.93, 0.3125, 0.625)
		frame.highlight.right:SetHorizTile(false)

		frame.highlight.bottom = frame.highlight:CreateTexture(nil, "OVERLAY")
		frame.highlight.bottom:SetBlendMode("ADD")
		frame.highlight.bottom:SetTexture("Interface\\AddOns\\ShadowedUnitFrames\\media\\textures\\highlight")
		frame.highlight.bottom:SetPoint("BOTTOMLEFT", frame, ShadowUF.db.profile.backdrop.inset, ShadowUF.db.profile.backdrop.inset)
		frame.highlight.bottom:SetPoint("BOTTOMRIGHT", frame, -ShadowUF.db.profile.backdrop.inset, ShadowUF.db.profile.backdrop.inset)
		frame.highlight.bottom:SetHeight(30)
		frame.highlight.bottom:SetTexCoord(0.3125, 0.625, 0.625, 0.93)
		frame.highlight.bottom:SetHorizTile(false)
		frame.highlight:Hide()
	end
	
	frame.highlight.top:SetHeight(ShadowUF.db.profile.units[frame.unitType].highlight.size)
	frame.highlight.bottom:SetHeight(ShadowUF.db.profile.units[frame.unitType].highlight.size)
	frame.highlight.left:SetWidth(ShadowUF.db.profile.units[frame.unitType].highlight.size)
	frame.highlight.right:SetWidth(ShadowUF.db.profile.units[frame.unitType].highlight.size)
	
	
	if( ShadowUF.db.profile.units[frame.unitType].highlight.aggro ) then
		frame:RegisterUnitEvent("UNIT_THREAT_SITUATION_UPDATE", self, "UpdateThreat")
		frame:RegisterUpdateFunc(self, "UpdateThreat")
	end
	
	if( ShadowUF.db.profile.units[frame.unitType].highlight.attention and frame.unitType ~= "target" and frame.unitType ~= "focus" ) then
		frame:RegisterNormalEvent("PLAYER_TARGET_CHANGED", self, "UpdateAttention")
		frame:RegisterNormalEvent("PLAYER_FOCUS_CHANGED", self, "UpdateAttention")
		frame:RegisterUpdateFunc(self, "UpdateAttention")
	end

	if( ShadowUF.db.profile.units[frame.unitType].highlight.debuff ) then
		frame:RegisterNormalEvent("UNIT_AURA", self, "UpdateAura")
		frame:RegisterUpdateFunc(self, "UpdateAura")
	end
	
	if( ShadowUF.db.profile.units[frame.unitType].highlight.mouseover and not frame.highlight.OnEnter ) then
		frame.highlight.OnEnter = frame:GetScript("OnEnter")
		frame.highlight.OnLeave = frame:GetScript("OnLeave")
		
		frame:SetScript("OnEnter", OnEnter)
		frame:SetScript("OnLeave", OnLeave)
	end
end

function Highlight:OnLayoutApplied(frame)
	if( frame.visibility.highlight ) then
		self:OnDisable(frame)
		self:OnEnable(frame)
	end
end

function Highlight:OnDisable(frame)
	frame:UnregisterAll(self)
	
	frame.highlight.hasDebuff = nil
	frame.highlight.hasThreat = nil
	frame.highlight.hasAttention = nil
	frame.highlight.hasMouseover = nil

	frame.highlight:Hide()
end

function Highlight:Update(frame)
	local color
	if( frame.highlight.hasDebuff ) then
		color = DebuffTypeColor[frame.highlight.hasDebuff]
	elseif( frame.highlight.hasThreat ) then
		color = ShadowUF.db.profile.healthColors.hostile
	elseif( frame.highlight.hasAttention ) then
		color = goldColor
	elseif( frame.highlight.hasMouseover ) then
		color = mouseColor
	end
		
	if( color ) then
		frame.highlight.top:SetVertexColor(color.r, color.g, color.b, ShadowUF.db.profile.units[frame.unitType].highlight.alpha)
		frame.highlight.left:SetVertexColor(color.r, color.g, color.b, ShadowUF.db.profile.units[frame.unitType].highlight.alpha)
		frame.highlight.bottom:SetVertexColor(color.r, color.g, color.b, ShadowUF.db.profile.units[frame.unitType].highlight.alpha)
		frame.highlight.right:SetVertexColor(color.r, color.g, color.b, ShadowUF.db.profile.units[frame.unitType].highlight.alpha)
		frame.highlight:Show()
	else
		frame.highlight:Hide()
	end
end

function Highlight:UpdateThreat(frame)
	frame.highlight.hasThreat = UnitThreatSituation(frame.unit) == 3 or nil
	self:Update(frame)
end

function Highlight:UpdateAttention(frame)
	frame.highlight.hasAttention = UnitIsUnit(frame.unit, "target") or UnitIsUnit(frame.unit, "focus") or nil
	self:Update(frame)
end

function Highlight:UpdateAura(frame)
	-- In theory, we don't need aura scanning because the first debuff returned is always one we can cure... in theory
	frame.highlight.hasDebuff = UnitIsFriend(frame.unit, "player") and select(5, UnitDebuff(frame.unit, 1, "RAID")) or nil
	self:Update(frame)
end
