local mod	= DBM:NewMod("Kurinnaxx", "DBM-AQ20", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 167 $"):sub(12, -3))
mod:SetCreatureID(15348)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE"
)

local warnWound		= mod:NewAnnounce("WarnWound", 3)
local warnSandTrap	= mod:NewTargetAnnounce(25656, 4)

local specWarnWound	= mod:NewSpecialWarningStack(25646, nil, 5)

local timerWound	= mod:NewTargetTimer(15, 25646)
local timerSandTrap	= mod:NewTargetTimer(20, 25656)

function mod:OnCombatStart(delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(25646) then
		if (args.amount or 1) >= 5 and args:IsPlayer() then
			specWarnWound:Show(args.amount)
		end
		warnWound:Show(args.spellName, args.destName, args.amount or 1)
		timerWound:Start(args.destName)
	elseif args:IsSpellID(25656) then
		warnSandTrap:Show(args.destName)
		timerSandTrap:Start(args.destName)
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED