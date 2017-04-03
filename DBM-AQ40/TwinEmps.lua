local mod	= DBM:NewMod("TwinEmpsAQ", "DBM-AQ40", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 132 $"):sub(12, -3))
mod:SetCreatureID(15276, 15275)
mod:RegisterCombat("combat")
mod:SetBossHealthInfo(
	15276, L.Veklor,
	15275, L.Veknil
)
mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS"
)

local warnTeleportSoon	= mod:NewSoonAnnounce(800, 2)
local warnTeleport		= mod:NewSpellAnnounce(800, 3)
local warnBlizzard		= mod:NewSpellAnnounce(26607, 2)
local warnExplodeBug	= mod:NewSpellAnnounce(804, 2)
local warnMutateBug		= mod:NewSpellAnnounce(802, 2)

local timerTeleport			= mod:NewNextTimer(30, 800)
local timerExplodeBug		= mod:NewCastTimer(3, 804)
local timerExplodeBugNext	= mod:NewNextTimer(8, 804, nil, false)
local timerMutateBug		= mod:NewNextTimer(11, 802, nil, false)

local berserkTimer	=	mod:NewBerserkTimer(900)

function mod:OnCombatStart(delay)
	berserkTimer:Start()
	warnTeleportSoon:Schedule(30-delay)
	timerTeleport:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(26607) and self:IsInCombat() then
		warnBlizzard:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(800) then
		warnTeleport:Show()
		warnTeleportSoon:Schedule(30)
		timerTeleport:Start()
	elseif args:IsSpellID(802) then
		warnMutateBug:Show()
		timerMutateBug:Start()
	elseif args:IsSpellID(804) then
		warnExplodeBug:Show()
		timerExplodeBug:Show()
		timerExplodeBugNext:Start()
	end
end