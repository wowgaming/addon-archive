local mod	= DBM:NewMod("Moroes", "DBM-Karazhan")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 164 $"):sub(12, -3))
mod:SetCreatureID(15687)
mod:RegisterCombat("yell", L.DBM_MOROES_YELL_START)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warningVanishSoon	= mod:NewSoonAnnounce(29448, 2)
local warningVanish		= mod:NewSpellAnnounce(29448, 3)
local warningGarrote	= mod:NewTargetAnnounce(37066, 4)
--local warnVanishFaded	= mod:NewAnnounce("DBM_MOROES_VANISH_FADED", 2)

local timerVanishCD		= mod:NewCDTimer(35, 29448)

local lastVanish = 0

function mod:OnCombatStart(delay)
	timerVanishCD:Start(-delay)
	warningVanishSoon:Schedule(30-delay)
	lastVanish = 0
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(29448) then
		warningVanish:Show()
		lastVanish = GetTime()
	elseif args:IsSpellID(37066) then
		warningGarrote:Show(args.destName)
		if (GetTime() - lastVanish) < 20 then--firing this event here instead, since he does garrote as soon as he comes out of vanish.
			timerVanishCD:Start()
			warningVanishSoon:Schedule(30)
		end
	end
end
--this function does not work, probably didn't in original mod either since this actually doesn't fire in combat log
--[[function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(29448) then
		warnVanishFaded:Show()
		if (GetTime() - lastVanish) < 20 then
			timerVanishCD:Start(36.5)
			warningVanishSoon:Schedule(31.5)
		end
	end
end--]]
