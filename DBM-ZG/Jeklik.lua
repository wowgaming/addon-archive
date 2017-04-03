local mod	= DBM:NewMod("Jeklik", "DBM-ZG", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 132 $"):sub(12, -3))
mod:SetCreatureID(14517)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warnSonicBurst	= mod:NewSpellAnnounce(23918)
local warnScreech		= mod:NewSpellAnnounce(6605)
local warnPain			= mod:NewTargetAnnounce(23952)
local warnHeal			= mod:NewCastAnnounce(23954, 4)

local timerSonicBurst	= mod:NewBuffActiveTimer(6, 23918)
local timerScreech		= mod:NewBuffActiveTimer(4, 6605)
local timerPain			= mod:NewTargetTimer(18, 23952)
local timerHeal			= mod:NewCastTimer(4, 23954)
local timerHealCD		= mod:NewNextTimer(20, 23954)

function mod:OnCombatStart(delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(23954) then
		timerHeal:Start()
		timerHealCD:Start()
		warnHeal:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(23918) then
		timerSonicBurst:Start()
		warnSonicBurst:Show()
	elseif args:IsSpellID(6605) and self:IsInCombat() then
		timerScreech:Start()
		warnScreech:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(23952) then
		timerPain:Start(args.destName)
		warnPain:Show(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(23952) then
		timerPain:Cancel(args.destName)
	end
end