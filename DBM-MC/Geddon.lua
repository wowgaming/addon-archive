local mod	= DBM:NewMod("Geddon", "DBM-MC", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 132 $"):sub(12, -3))
mod:SetCreatureID(12056)
mod:SetUsedIcons(8)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS"
)

local warnInferno		= mod:NewSpellAnnounce(19695)
local warnIgnite		= mod:NewSpellAnnounce(19659)
local warnBomb			= mod:NewTargetAnnounce(20475)
local warnArmageddon	= mod:NewSpellAnnounce(20478)

local timerInferno		= mod:NewCastTimer(8, 19695)
local timerBomb			= mod:NewTargetTimer(8, 20475)
local timerIgnite		= mod:NewBuffActiveTimer(300, 19659)
local timerArmageddon	= mod:NewCastTimer(8, 20478)

local specWarnBomb		= mod:NewSpecialWarningYou(20475)

mod:AddBoolOption("SetIconOnBombTarget", true)

function mod:OnCombatStart(delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(20475) then
		timerBomb:Start(args.destName)
		warnBomb:Show(args.destName)
		if self.Options.SetIconOnBombTarget then
			self:SetIcon(args.destName, 8, 8)
		end
		if args:IsPlayer() then
			specWarnBomb:Show()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(19695) then
		warnInferno:Show()
		timerInferno:Start()
	elseif args:IsSpellID(19659) then
		warnIgnite:Show()
		timerIgnite:Start()
	elseif args:IsSpellID(20478) then
		warnArmageddon:Show()
		timerArmageddon:Start()
	end
end

