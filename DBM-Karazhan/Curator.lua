local mod	= DBM:NewMod("Curator", "DBM-Karazhan")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 163 $"):sub(12, -3))
mod:SetCreatureID(15691)
--mod:RegisterCombat("yell", L.DBM_CURA_YELL_PULL)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_MONSTER_YELL"
)

local warnEvoSoon		= mod:NewPreWarnAnnounce(30254, 10, 2)
local warnEvo			= mod:NewSpellAnnounce(30254, 3)
local warnArcaneInfusion= mod:NewSpellAnnounce(30403, 3)

local timerEvo			= mod:NewBuffActiveTimer(20, 30254)
local timerNextEvo		= mod:NewNextTimer(115, 30254)

local berserkTimer		= mod:NewBerserkTimer(720)

mod:AddBoolOption("RangeFrame", true)

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	timerNextEvo:Start(109-delay)
	warnEvoSoon:Schedule(99-delay)
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
	if args:IsSpellID(30403) then
		warnArcaneInfusion:Show()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.DBM_CURA_YELL_OOM then
		warnEvoSoon:Cancel()
		warnEvo:Show()
		timerNextEvo:Start()
		timerEvo:Start()
		warnEvoSoon:Schedule(95)
	end
end

