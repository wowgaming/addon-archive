local mod	= DBM:NewMod("Sulfuron", "DBM-MC", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 132 $"):sub(12, -3))
mod:SetCreatureID(12098)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START"
)

local warnInspire		= mod:NewTargetAnnounce(19779)
local warnHandRagnaros	= mod:NewTargetAnnounce(19780)
local warnShadowPain	= mod:NewTargetAnnounce(19776)
local warnHeal			= mod:NewCastAnnounce(19775)--this may be spammy now that spellid is fixed
local warnImmolate		= mod:NewTargetAnnounce(20294)

local timerInspire		= mod:NewBuffActiveTimer(10, 19779)
local timerShadowPain	= mod:NewTargetTimer(18, 19776)
local timerHeal			= mod:NewCastTimer(2, 19775)--this may be spammy now that spellid is fixed
local timerImmolate		= mod:NewTargetTimer(21, 20294)
local timerHandRagnaros	= mod:NewBuffActiveTimer(2, 19780)

local HandofRagTargets = {}

function mod:OnCombatStart(delay)
	table.wipe(HandofRagTargets)
end

function mod:warnHandofRagTargets()
		warnHandRagnaros:Show(table.concat(HandofRagTargets, "<, >"))
		timerHandRagnaros:Start()
		table.wipe(HandofRagTargets)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(19779) then
		warnInspire:Show(args.destName)
		timerInspire:Start(args.destName)
	elseif args:IsSpellID(19780) and args:IsDestTypePlayer() then
		self:UnscheduleMethod("warnHandofRagTargets")
		HandofRagTargets[#HandofRagTargets + 1] = args.destName
		self:ScheduleMethod(0.3, "warnHandofRagTargets")
	elseif args:IsSpellID(19776) then
		warnShadowPain:Show(args.destName)
		timerShadowPain:Start(args.destName)
	elseif args:IsSpellID(20294) then
		warnImmolate:Show(args.destName)
		timerImmolate:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(23952) and self:IsInCombat() then
		timerShadowPain:Cancel(args.destName)
	elseif args:IsSpellID(20294) and self:IsInCombat() then
		timerImmolate:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(19775) then
		warnHeal:Show()
		timerHeal:Start()
	end
end