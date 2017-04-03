local mod	= DBM:NewMod("Venoxis", "DBM-ZG", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 132 $"):sub(12, -3))
mod:SetCreatureID(14507)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"UNIT_HEALTH"
)

local warnSerpent	= mod:NewTargetAnnounce(23865)
local warnCloud		= mod:NewSpellAnnounce(23861)
local warnRenew		= mod:NewTargetAnnounce(23895)
local warnFire		= mod:NewTargetAnnounce(23860)
local prewarnPhase2	= mod:NewAnnounce("warnPhase2Soon")

local timerCloud	= mod:NewBuffActiveTimer(10, 23861)
local timerRenew	= mod:NewTargetTimer(15, 23895)
local timerFire		= mod:NewTargetTimer(8, 23860)

mod:AddBoolOption("RangeFrame", true)

local prewarn_Phase2

function mod:OnCombatStart(delay)
	prewarn_Phase2 = false
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(10)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(23895) then
		warnRenew:Show(args.destName)
		timerRenew:Start(args.destName)
	elseif args:IsSpellID(23860) then
		warnFire:Show(args.destName)
		timerFire:Start(args.destName)
	elseif args:IsSpellID(23865) then
		warnSerpent:Show(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(23895) then
		timerRenew:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(23861) then
		warnCloud:Show()
		timerCloud:Start()
	end
end

function mod:UNIT_HEALTH(uId)
	if not prewarn_Phase2 and self:GetUnitCreatureId(uId) == 14507 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.53 then
		prewarn_Phase2 = true
		prewarnPhase2:Show()	
	end
end