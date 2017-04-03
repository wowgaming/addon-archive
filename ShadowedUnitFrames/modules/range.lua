local Range = {
	friendly = {["PRIEST"] = GetSpellInfo(2050), ["DRUID"] = GetSpellInfo(48378), ["PALADIN"] = GetSpellInfo(48782), ["SHAMAN"] = GetSpellInfo(49273)},
	hostile = {["PRIEST"] = GetSpellInfo(48127), ["DRUID"] = GetSpellInfo(48461), ["PALADIN"] = GetSpellInfo(62124), ["HUNTER"] = GetSpellInfo(75), ["WARLOCK"] = GetSpellInfo(686), ["SHAMAN"] = GetSpellInfo(529), ["MAGE"] = GetSpellInfo(133), ["DEATHKNIGHT"] = GetSpellInfo(49576)},
	resurrect = {["PALADIN"] = GetSpellInfo(48950), ["PRIEST"] = GetSpellInfo(25435), ["SHAMAN"] = GetSpellInfo(2008), ["DRUID"] = GetSpellInfo(48477)}
}
ShadowUF:RegisterModule(Range, "range", ShadowUF.L["Range indicator"])

local playerClass = select(2, UnitClass("player"))
local friendlySpell, hostileSpell

local function checkRange(self, elapsed)
	self.timeElapsed = self.timeElapsed + elapsed
	if( self.timeElapsed <= 0.50 ) then return end
	self.timeElapsed = 0
	
	-- We set a spell for them in our flags check, use that
	if( self.spell ) then
		self.parent:SetRangeAlpha(IsSpellInRange(self.spell, self.parent.unit) == 1 and ShadowUF.db.profile.units[self.parent.unitType].range.inAlpha or ShadowUF.db.profile.units[self.parent.unitType].range.oorAlpha)
	-- That didn't work, but they are grouped lets try the actual API for this, it's a bit flaky though and not that useful generally
	elseif( self.grouped ) then
		self.parent:SetRangeAlpha(UnitInRange(self.parent.unit, "player") and ShadowUF.db.profile.units[self.parent.unitType].range.inAlpha or ShadowUF.db.profile.units[self.parent.unitType].range.oorAlpha)
	-- Nope, fall back to interaction :(
	elseif( self.isFriendly ) then
		self.parent:SetRangeAlpha(CheckInteractDistance(self.parent.unit, 4) and ShadowUF.db.profile.units[self.parent.unitType].range.inAlpha or ShadowUF.db.profile.units[self.parent.unitType].range.oorAlpha)
	else
		self.parent:SetRangeAlpha(ShadowUF.db.profile.units[self.parent.unitType].range.inAlpha)
	end
end

function Range:ForceUpdate(frame)
	checkRange(frame.range, 1)
end

function Range:OnEnable(frame)
	if( not frame.range ) then
		frame.range = CreateFrame("Frame", nil, frame)
		frame.range:SetScript("OnUpdate", checkRange)
		frame.range.timeElapsed = 0
		frame.range.parent = frame
		frame.range:Hide()
	end
	
	-- I want to say UNIT_FACTION is the function thats called when a unit is MCed, but not 100% sure
	frame:RegisterUnitEvent("UNIT_FACTION", self, "UpdateFlags")
	frame:RegisterNormalEvent("PARTY_MEMBERS_CHANGED", self, "UpdateFlags")
	frame:RegisterNormalEvent("RAID_ROSTER_UPDATE", self, "UpdateFlags")

	frame:RegisterUpdateFunc(self, "UpdateFlags")
	frame:RegisterUpdateFunc(self, "ForceUpdate")
end

function Range:OnLayoutApplied(frame)
	if( frame.visibility.range ) then
		frame.range.hostileSpell = ShadowUF.db.profile.range["hostile" .. playerClass] or self.hostile[playerClass]
		frame.range.friendlySpell = ShadowUF.db.profile.range["friendly" .. playerClass] or self.friendly[playerClass]
	end
end

function Range:OnDisable(frame)
	frame:UnregisterAll(self)
	
	if( frame.range ) then
		frame.range:Hide()
		frame:SetRangeAlpha(1.0)
	end
end

-- I'd rather store the flags here, they rarely change and we can do that based off events, no sense in doing it eveyr 0.50s
function Range:UpdateFlags(frame)
	frame.range.canAttack = UnitCanAttack("player", frame.unit)
	frame.range.isFriendly = UnitIsFriend("player", frame.unit)
	frame.range.grouped = UnitInRaid(frame.unit) or UnitInParty(frame.unit)
	frame.range.spell = UnitIsDead(frame.unit) and self.resurrect[playerClass] or frame.range.canAttack and frame.range.hostileSpell or frame.range.isFriendly and frame.range.friendlySpell or nil
	
	-- No sense in updating range if we have no data
	if( UnitIsGhost(frame.unit) or not UnitIsConnected(frame.unit) or ( not frame.range.spell and not frame.range.grouped and not frame.range.isFriendly ) ) then
		frame:SetRangeAlpha(ShadowUF.db.profile.units[frame.unitType].range.inAlpha)
		frame.range:Hide()
	else
		frame.range:Show()
	end
end


