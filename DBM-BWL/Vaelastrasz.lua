local mod	= DBM:NewMod("Vaelastrasz", "DBM-BWL", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 168 $"):sub(12, -3))
mod:SetCreatureID(13020)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED"
)

local warnBreath		= mod:NewCastAnnounce(23461)
local warnAdrenaline	= mod:NewTargetAnnounce(18173)

local timerBreath		= mod:NewCastTimer(2, 23461)
local timerAdrenaline	= mod:NewTargetTimer(20, 18173)

local specWarnAdrenaline	= mod:NewSpecialWarningYou(18173)

function mod:OnCombatStart(delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(23461) then
		warnBreath:Show()
		timerBreath:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(18173) then
		warnAdrenaline:Show(args.destName)
		timerAdrenaline:Start(args.destName)
		if args:IsPlayer() then
			specWarnAdrenaline:Show()
		end
	end
end