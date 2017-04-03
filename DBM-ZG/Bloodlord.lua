local mod = DBM:NewMod("Bloodlord", "DBM-ZG", 1)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 132 $"):sub(12, -3))

mod:SetCreatureID(11382, 14988)
mod:RegisterCombat("combat")
mod:SetBossHealthInfo(
	11382, L.Bloodlord,
	14988, L.Ohgan
)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED"
)

local warnFrenzy	= mod:NewSpellAnnounce(24318)
local warnGaze		= mod:NewTargetAnnounce(24314)
local warnMortal	= mod:NewTargetAnnounce(16856)
local timerGaze 	= mod:NewTargetTimer(6, 24314)
local timerMortal	= mod:NewTargetTimer(5, 16856)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(24314) then
		warnGaze:Show(args.destName)
		timerGaze:Start(args.destName)
	elseif args:IsSpellID(24318) then
		warnFrenzy:Show(args.destName)
	elseif args:IsSpellID(16856) and self:IsInCombat() and args:IsDestTypePlayer() then
		warnMortal:Show(args.destName)
		timerMortal:Start(args.destName)
	end
end

