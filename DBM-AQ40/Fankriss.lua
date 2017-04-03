local mod	= DBM:NewMod("Fankriss", "DBM-AQ40", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 132 $"):sub(12, -3))
mod:SetCreatureID(15510)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_SUMMON"
)

local warnWound		= mod:NewAnnounce("WarnWound", 3)
local warnWorm		= mod:NewSpellAnnounce(25831, 3)

local timerWound	= mod:NewTargetTimer(20, 25646)

local specWarnWound		= mod:NewSpecialWarningStack(25646, nil, 5)

function mod:OnCombatStart(delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(25646) then
		warnWound:Show(args.spellName, args.destName, args.amount or 1)
		timerWound:Show(args.destName)
		if (args.amount or 1) >= 5 then
			specWarnWound:Show()
		end
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(518, 25832, 25831) then
		warnWorm:Show()
	end
end