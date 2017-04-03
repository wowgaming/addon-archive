local mod	= DBM:NewMod("Chromaggus", "DBM-BWL", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 168 $"):sub(12, -3))
mod:SetCreatureID(14020)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"UNIT_HEALTH"
)

local warnBreathSoon	= mod:NewAnnounce("WarnBreathSoon", 1, 23316)
local warnBreath		= mod:NewAnnounce("WarnBreath", 2, 23316)
local warnRed			= mod:NewTargetAnnounce(23155, 2, nil, false)
local warnGreen			= mod:NewTargetAnnounce(23169, 2, nil, false)
local warnBlue			= mod:NewTargetAnnounce(23153, 2, nil, false)
local warnBlack			= mod:NewTargetAnnounce(23154, 2, nil, false)
local warnBronze		= mod:NewTargetAnnounce(23170, 2, nil, false)
local warnEnrage		= mod:NewSpellAnnounce(23128)
local warnPhase2Soon	= mod:NewAnnounce("WarnPhase2Soon")
local warnPhase2		= mod:NewPhaseAnnounce(2)

local specWarnBronze	= mod:NewSpecialWarningYou(23170)

local timerBreath		= mod:NewTimer(2, "TimerBreath")
local timerBreathCD		= mod:NewTimer(60, "TimerBreathCD")
local timerEnrage		= mod:NewBuffActiveTimer(8, 23128)


local prewarn_P2
function mod:OnCombatStart(delay)
	warnBreathSoon:Schedule(25-delay)
	timerBreathCD:Start(30-delay, "Breath 1")
	timerBreathCD:Start(-delay, "Breath 2")
	prewarn_P2 = false;
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(23309, 23313, 23189, 23316) or args:IsSpellID(23312) then
		warnBreathSoon:Cancel()
		warnBreathSoon:Schedule(25)
		warnBreath:Show(args.spellName)
		timerBreath:Start(args.spellName)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(23155) then
		warnRed:Show(args.destName)
	elseif args:IsSpellID(23169) then
		warnGreen:Show(args.destName)
	elseif args:IsSpellID(23153) then
		warnBlue:Show(args.destName)
	elseif args:IsSpellID(23154) then
		warnBlack:Show(args.destName)
	elseif args:IsSpellID(23170) then
		warnBronze:Show(args.destName)
		if args:IsPlayer() then
			specWarnBronze:Show()
		end
	elseif args:IsSpellID(23128) and self:IsInCombat() then
		warnEnrage:Show()
		timerEnrage:Start()
	elseif args:IsSpellID(23537) and self:IsInCombat() then
		warnPhase2:Show()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(23128) then
		timerEnrage:Cancel()
	end
end

function mod:UNIT_HEALTH(uId)
	if UnitHealth(uId) / UnitHealthMax(uId) <= 0.25 and self:GetUnitCreatureId(uId) == 14020 and not prewarn_P2 then
		warnPhase2Soon:Show()
		prewarn_P2 = true
	end
end