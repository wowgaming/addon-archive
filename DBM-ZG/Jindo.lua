local mod	= DBM:NewMod("Jindo", "DBM-ZG", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 132 $"):sub(12, -3))
mod:SetCreatureID(11380)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON"
)

local warnDelusion		= mod:NewTargetAnnounce(24306)
local warnHex			= mod:NewTargetAnnounce(17172)
local warnHealingWard	= mod:NewSpellAnnounce(24309)
local warnBrainTotem	= mod:NewSpellAnnounce(24262)
local warnBrainWash		= mod:NewTargetAnnounce(24261)
local warnBanish		= mod:NewTargetAnnounce(24466)

local timerHex			= mod:NewTargetTimer(5, 17172)
local timerDelusion		= mod:NewTargetTimer(20, 24306)

local specWarnDelusion	= mod:NewSpecialWarningYou(24306)

function mod:OnCombatStart(delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(24306) then
		timerDelusion:Start(args.destName)
		warnDelusion:Show(args.destName)
		if args:IsPlayer() then
			specWarnDelusion:Show()
		end
	elseif args:IsSpellID(17172) and self:IsInCombat() then
		timerHex:Start(args.destName)
		warnHex:Show(args.destName)
	elseif args:IsSpellID(24261) then
		warnBrainWash:Show(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(17172) then
		timerHex:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(24466) then
		warnBanish:Show(args.destName)
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(24309) then
		warnHealingWard:Show()
	elseif args:IsSpellID(24262) then
		warnBrainTotem:Show()
	end
end