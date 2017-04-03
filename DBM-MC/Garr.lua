local mod	= DBM:NewMod("Garr", "DBM-MC", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 132 $"):sub(12, -3))
mod:SetCreatureID(12057)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warnImmolate	= mod:NewTargetAnnounce(15732)
local timerImmolate	= mod:NewTargetTimer(21, 15732)

function mod:OnCombatStart(delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(15732) and self:IsInCombat() then
		warnImmolate:Show(args.destName)
		timerImmolate:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(15732) then
		timerImmolate:Cancel(args.destName)
	end
end