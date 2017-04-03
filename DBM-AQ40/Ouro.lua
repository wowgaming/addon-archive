local mod	= DBM:NewMod("Ouro", "DBM-AQ40", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 132 $"):sub(12, -3))
mod:SetCreatureID(15517)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON",
	"UNIT_HEALTH"
)

local warnSubmerge		= mod:NewAnnounce("WarnSubmerge", 3)
local warnSubmergeSoon	= mod:NewAnnounce("WarnSubmergeSoon", 2)
local warnEmerge		= mod:NewAnnounce("WarnEmerge", 3)
local warnEmergeSoon	= mod:NewAnnounce("WarnEmergeSoon", 2)
local warnSweepSoon		= mod:NewSoonAnnounce(26103, 2)
local warnBlastSoon		= mod:NewSoonAnnounce(26102, 2)
local warnEnrage		= mod:NewSpellAnnounce(26615, 3)
local warnEnrageSoon	= mod:NewSoonAnnounce(26615, 2)

local timerSubmerge		= mod:NewTimer(180, "TimerSubmerge")
local timerEmerge		= mod:NewTimer(30, "TimerEmerge")
local timerSweepCD		= mod:NewCDTimer(21, 26103)
local timerBlast		= mod:NewCastTimer(2, 26102)
local timerBlastCD		= mod:NewCDTimer(23, 26102)

local summonSpam
local prewarn_enrage
local enraged
function mod:OnCombatStart(delay)
	timerSubmerge:Start(-delay)
	warnSubmergeSoon:Schedule(170)
	prewarn_enrage = false
	enraged = false
end

function mod:Submerge()
	warnEmerge:Show()
	warnSubmergeSoon:Schedule(170)
	timerSubmerge:Start()
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(26615) then
		enraged = true
		warnEnrage:Show()
		warnSubmergeSoon:Cancel()
		timerSubmerge:Cancel()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(26102) then
		timerBlastCD:Start()
		timerBlast:Start()
		warnBlastSoon:Schedule(18)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(26103) then
		timerSweepCD:Start()
		warnSweepSoon:Schedule(16)
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(26058) and GetTime() - summonSpam >= 3 and not enraged then
		summonSpam = GetTime()
		warnSubmergeSoon:Cancel()
		warnSubmerge:Show()
		timerEmerge:Start()
		self:ScheduleMethod(30, "Submerge")
	end
end

function mod:UNIT_HEALTH(uId)
	if UnitHealth(uId) / UnitHealthMax(uId) <= 0.23 and self:GetUnitCreatureId(uId) == 15517 and not prewarn_enrage then
		prewarn_enrage = true
		warnEnrageSoon:Show()
	end
end