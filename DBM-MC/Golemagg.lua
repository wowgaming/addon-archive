local mod	= DBM:NewMod("Golemagg", "DBM-MC", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 132 $"):sub(12, -3))
mod:SetCreatureID(11988)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"UNIT_HEALTH"
)

local warnTrust		= mod:NewSpellAnnounce(20553)
local warnP2Soon	= mod:NewAnnounce("WarnP2Soon")
local warnP2		= mod:NewPhaseAnnounce(2)

local prewarn_p2
function mod:OnCombatStart(delay)
	prewarn_p2 = false
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(20553) then
		warnTrust:Show()
	end
end

function mod:UNIT_HEALTH(uId)
	if UnitHealth(uId) / UnitHealthMax(uId) <= 0.25 and self:GetUnitCreatureId(uId) == 11099 and not prewarn_P2 then
		warnP2Soon:Show()
		prewarn_P2 = true
	end
end