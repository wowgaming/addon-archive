local mod	= DBM:NewMod("Omor", "DBM-Party-BC", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 128 $"):sub(12, -3))
mod:SetCreatureID(17308)
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warnBane      = mod:NewTargetAnnounce(37566)
local timerBane     = mod:NewTargetTimer(15, 37566)
local specwarnBane  = mod:NewSpecialWarningYou(37566)

mod:AddBoolOption("SetIconOnBaneTarget", true)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 37566 then
		warnBane:Show(args.destName)
		timerBane:Start(args.destName)
		if self.Options.SetIconOnBaneTarget then
			self:SetIcon(args.destName, 8, 15)
		end
		if args:IsPlayer() then
            specwarnBane:Show()
        end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 37566 then
		timerBane:Cancel(args.destName)
	end
end