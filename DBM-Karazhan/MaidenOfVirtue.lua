local mod	= DBM:NewMod("Maiden", "DBM-Karazhan")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 164 $"):sub(12, -3))
mod:SetCreatureID(16457)
--mod:RegisterCombat("yell", L.DBM_MOV_YELL_PULL)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warningRepentanceSoon	= mod:NewSoonAnnounce(29511, 2)
local warningRepentance		= mod:NewSpellAnnounce(29511, 3)
local warningHolyFire		= mod:NewTargetAnnounce(29522, 3)

local timerRepentance		= mod:NewBuffActiveTimer(12.6, 29511)
local timerRepentanceCD		= mod:NewCDTimer(33, 29511)
local timerHolyFire			= mod:NewTargetTimer(12, 29522)

mod:AddBoolOption("RangeFrame", true)

function mod:OnCombatStart(delay)
	timerRepentanceCD:Start(45-delay)
	warningRepentanceSoon:Schedule(40-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(10)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(29511) then
		warningRepentanceSoon:Cancel()
		warningRepentance:Show()
		timerRepentance:Start()
		timerRepentanceCD:Start()
		warningRepentanceSoon:Schedule(28)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(29522) then
		warningHolyFire:Show(args.destName)
		timerHolyFire:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(29522) then
		timerHolyFire:Cancel(args.destName)
	end
end
