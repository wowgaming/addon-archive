local mod	= DBM:NewMod("Flamegor", "DBM-BWL", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 168 $"):sub(12, -3))
mod:SetCreatureID(11981)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS"
)

local warnWingBuffet	= mod:NewCastAnnounce(23339)
local warnShadowFlame	= mod:NewCastAnnounce(22539)
local warnEnrage		= mod:NewSpellAnnounce(23342)

local timerWingBuffet	= mod:NewNextTimer(31, 23339)
local timerShadowFlame	= mod:NewCastTimer(2, 22539)
local timerEnrageNext 	= mod:NewNextTimer(10, 23342)

function mod:OnCombatStart(delay)
	timerWingBuffet:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(23339) and self:IsInCombat() then
		warnWingBuffet:Show()
		timerWingBuffet:Start()
	elseif args:IsSpellID(22539) and self:IsInCombat() then
		timerShadowFlame:Start()
		warnShadowFlame:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(23342) then
		warnEnrage:Show()
		timerEnrageNext:Start()
	end
end