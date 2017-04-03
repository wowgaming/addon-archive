local mod	= DBM:NewMod("Ossirian", "DBM-AQ20", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 171 $"):sub(12, -3))
mod:SetCreatureID(15339)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local WeaknessIcon = 0

local warnSupreme		= mod:NewSpellAnnounce(25176, 4)
local warnCyclone		= mod:NewTargetAnnounce(25189, 4)
local warnSupremeSoon	= mod:NewSoonAnnounce(25176, 3)
local warnVulnerable	= mod:NewAnnounce("WarnVulnerable", 3, WeaknessIcon)

local timerVulnerable	= mod:NewTimer(45, "TimerVulnerable", WeaknessIcon)
local timerCyclone		= mod:NewTargetTimer(10, 25189)

function mod:OnCombatStart(delay)
	--warnSupremeSoon:Schedule(25)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(25176) then
		warnSupreme:Show()
	elseif args:IsSpellID(25189) then
		warnCyclone:Show(args.destName)
		timerCyclone:Start(args.destName)
	elseif args:IsSpellID(25177) then
		WeaknessIcon = 25177
		warnSupremeSoon:Cancel()
		warnSupremeSoon:Schedule(40)
		warnVulnerable:Show(args.spellName)
		timerVulnerable:Show(args.spellName)
	elseif args:IsSpellID(25178) then
		WeaknessIcon = 25178
		warnSupremeSoon:Cancel()
		warnSupremeSoon:Schedule(40)
		warnVulnerable:Show(args.spellName)
		timerVulnerable:Show(args.spellName)
	elseif args:IsSpellID(25180)then
		WeaknessIcon = 25180
		warnSupremeSoon:Cancel()
		warnSupremeSoon:Schedule(40)
		warnVulnerable:Show(args.spellName)
		timerVulnerable:Show(args.spellName)
	elseif args:IsSpellID(25181) then
		WeaknessIcon = 25181
		warnSupremeSoon:Cancel()
		warnSupremeSoon:Schedule(40)
		warnVulnerable:Show(args.spellName)
		timerVulnerable:Show(args.spellName)
	elseif args:IsSpellID(25183) then
		WeaknessIcon = 25183
		warnSupremeSoon:Cancel()
		warnSupremeSoon:Schedule(40)
		warnVulnerable:Show(args.spellName)
		timerVulnerable:Show(args.spellName)
	end	
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(25189) then
		timerCyclone:Cancel(args.destName)
	end	
end
