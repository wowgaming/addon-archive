local mod	= DBM:NewMod("Moam", "DBM-AQ20", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 132 $"):sub(12, -3))
mod:SetCreatureID(15340)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS"
)

local warnStoneformSoon	= mod:NewSoonAnnounce(25685, 2)
local warnStoneform		= mod:NewSpellAnnounce(25685, 3)

local timerStoneform	= mod:NewNextTimer(90, 25685)
local timerStoneformDur	= mod:NewBuffActiveTimer(90, 25685)

function mod:OnCombatStart(delay)
	timerStoneform:Start(-delay)
	warnStoneformSoon:Schedule(80)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(25685) then
		timerStoneformDur:Start()
		warnStoneform:Show()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(25685) then
		timerStoneform:Start()
		warnStoneformSoon:Schedule(80)
	end
end