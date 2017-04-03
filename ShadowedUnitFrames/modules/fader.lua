local Fader = {}
ShadowUF:RegisterModule(Fader, "fader", ShadowUF.L["Combat fader"])

local function faderUpdate(self, elapsed)
	self.timeElapsed = self.timeElapsed + elapsed
	if( self.timeElapsed >= self.fadeTime ) then
		self.parent:SetAlpha(self.alphaEnd)
		self:Hide()
		
		if( self.fadeType == "in" ) then
			self.parent:DisableRangeAlpha(false)
		end
		return
	end
	
	if( self.fadeType == "in" ) then
		self.parent:SetAlpha((self.timeElapsed / self.fadeTime) * (self.alphaEnd - self.alphaStart) + self.alphaStart)
	else
		self.parent:SetAlpha(((self.fadeTime - self.timeElapsed) / self.fadeTime) * (self.alphaStart - self.alphaEnd) + self.alphaEnd)
	end
end

local function startFading(self, type, alpha, speedyFade)
	if( self.fader.fadeType == type ) then return end
	if( type == "out" ) then
		self:DisableRangeAlpha(true)
	end
	
	self.fader.fadeTime = speedyFade and 0.15 or type == "in" and 0.25 or type == "out" and 0.75
	self.fader.fadeType = type
	self.fader.timeElapsed = 0
	self.fader.alphaEnd = alpha
	self.fader.alphaStart = self:GetAlpha()
	self.fader:Show()
end

function Fader:OnEnable(frame)
	if( not frame.fader ) then
		frame.fader = CreateFrame("Frame", nil, frame)
		frame.fader.timeElapsed = 0
		frame.fader.parent = frame
		frame.fader:SetScript("OnUpdate", faderUpdate)
		frame.fader:Hide()
	end
		
	frame:RegisterNormalEvent("PLAYER_REGEN_ENABLED", self, "Update")
	frame:RegisterNormalEvent("PLAYER_REGEN_DISABLED", self, "Update")
	frame:RegisterUpdateFunc(self, "Update")
	
	if( InCombatLockdown() ) then
		Fader:PLAYER_REGEN_DISABLED(frame, "PLAYER_REGEN_DISABLED")
	else
		Fader:PLAYER_REGEN_ENABLED(frame, "PLAYER_REGEN_ENABLED")
	end
end

function Fader:OnLayoutApplied(frame)
	if( frame.visibility.fader ) then
		frame.fader.fadeType = nil
		frame:DisableRangeAlpha(false)
	end
end

function Fader:OnDisable(frame)
	frame:UnregisterAll(self)
	frame:SetAlpha(1.0)

	if( frame.fader ) then
		frame.fader.fadeType = nil
		frame.fader:Hide()
	end
end

-- While we're in combat, we don't care about the other events so we might as well unregister them
function Fader:PLAYER_REGEN_ENABLED(frame, event)
	self:Update(frame, event)
	frame:RegisterNormalEvent("PLAYER_TARGET_CHANGED", self, "Update")
	frame:RegisterNormalEvent("UNIT_SPELLCAST_CHANNEL_START", self, "CastStart")
	frame:RegisterNormalEvent("UNIT_SPELLCAST_CHANNEL_STOP", self, "CastStop")
	frame:RegisterNormalEvent("UNIT_SPELLCAST_START", self, "CastStart")
	frame:RegisterNormalEvent("UNIT_SPELLCAST_STOP", self, "CastStop")
	frame:RegisterUnitEvent("UNIT_HEALTH", self, "Update")
	frame:RegisterUnitEvent("UNIT_MANA", self, "Update")
	frame:RegisterUnitEvent("UNIT_MAXHEALTH", self, "Update")
	frame:RegisterUnitEvent("UNIT_MAXMANA", self, "Update")	
end

function Fader:PLAYER_REGEN_DISABLED(frame, event)
	self:Update(frame, event)
	frame:UnregisterEvent("PLAYER_TARGET_CHANGED")
	frame:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_START")
	frame:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_STOP")
	frame:UnregisterEvent("UNIT_SPELLCAST_START")
	frame:UnregisterEvent("UNIT_SPELLCAST_STOP")
	frame:UnregisterEvent("UNIT_HEALTH")
	frame:UnregisterEvent("UNIT_MANA")
	frame:UnregisterEvent("UNIT_MAXHEALTH")
	frame:UnregisterEvent("UNIT_MAXMANA")
end


local activeCastID
function Fader:CastStart(frame, event, unit, spellName, spellRank, id)
	if( unit ~= "player" or activeCastID == id ) then return end
	activeCastID = id
	
	frame.fader.playerCasting = true
	self:Update(frame)
end

function Fader:CastStop(frame, event, unit, spellName, spellRank, id)
	if( unit ~= "player" or activeCastID ~= id ) then return end
	activeCastID = nil
	
	frame.fader.playerCasting = nil
	self:Update(frame)
end


function Fader:Update(frame, event)
	-- In combat, fade back in
	if( InCombatLockdown() or event == "PLAYER_REGEN_DISABLED" ) then
		startFading(frame, "in", ShadowUF.db.profile.units[frame.unitType].fader.combatAlpha)
	-- Player is casting, fade in
	elseif( frame.fader.playerCasting ) then
		startFading(frame, "in", ShadowUF.db.profile.units[frame.unitType].fader.combatAlpha, true)
	-- Ether mana or energy is not at 100%, fade in
	elseif( ( UnitPowerType(frame.unit) == 0 or UnitPowerType(frame.unit) == 3 ) and UnitPower(frame.unit) ~= UnitPowerMax(frame.unit) ) then
		startFading(frame, "in", ShadowUF.db.profile.units[frame.unitType].fader.combatAlpha)
	-- Health is not at max, fade in
	elseif( UnitHealth(frame.unit) ~= UnitHealthMax(frame.unit) ) then
		startFading(frame, "in", ShadowUF.db.profile.units[frame.unitType].fader.combatAlpha)
	-- Targetting somebody, fade in
	elseif( frame.unitType == "player" and UnitExists("target") ) then
		startFading(frame, "in", ShadowUF.db.profile.units[frame.unitType].fader.combatAlpha)
	-- Nothing else? Fade out!
	else
		startFading(frame, "out", ShadowUF.db.profile.units[frame.unitType].fader.inactiveAlpha)
	end
end
