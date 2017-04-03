local mod	= DBM:NewMod("Hakkar", "DBM-ZG", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 132 $"):sub(12, -3))
mod:SetCreatureID(14834)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS"
)

local warnSiphonSoon	= mod:NewSoonAnnounce(24324)
local warnInsanity		= mod:NewTargetAnnounce(24327)
local warnBlood			= mod:NewTargetAnnounce(24328)

local timerSiphon		= mod:NewNextTimer(90, 24324)
local timerInsanity		= mod:NewTargetTimer(10, 24327)
local timerInsanityCD	= mod:NewCDTimer(20, 24327)
local timerBlood		= mod:NewTargetTimer(10, 24328)

local specWarnBlood		= mod:NewSpecialWarningYou(24328)

local enrageTimer		= mod:NewBerserkTimer(585)

function mod:OnCombatStart(delay)
	enrageTimer:Start(-delay)
	warnSiphonSoon:Schedule(80-delay)
	timerSiphon:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(24327) then
		warnInsanity:Show(args.destName)
		timerInsanity:Start(args.destName)
		timerInsanityCD:Start()
	elseif args:IsSpellID(24328) then
		warnBlood:Show(args.destName)
		timerBlood:Start(args.destName)
		if args:IsPlayer() then
			specWarnBlood:Show()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(24324) then
		warnSiphonSoon:Cancel()
		warnSiphonSoon:Schedule(80)
		timerSiphon:Start()
	end
end
		