local mod = DBM:NewMod("Murmur", "DBM-Party-BC", 10)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 128 $"):sub(12, -3))
mod:SetCreatureID(18708)
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START"
)

local warnBoom          = mod:NewCastAnnounce(33923)
local warnTouch         = mod:NewTargetAnnounce(33711)
local timerBoomCast     = mod:NewCastTimer(5, 33923)
local timerTouch        = mod:NewTargetTimer(14, 33711)
local specWarnTouch		= mod:NewSpecialWarningMove(33711)

local soundBoom = mod:NewSound(33923)
mod:AddBoolOption("SetIconOnTouchTarget", true)

function mod:SPELL_CAST_START(args)
	if args.spellId == 33923 or args.spellId == 38796 then
		warnBoom:Show()
		timerBoomCast:Start()
		soundBoom:Play()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 33711 then
		warnTouch:Show(args.destName)
		timerTouch:Start(args.destName)
		if self.Options.SetIconOnTouchTarget then
			self:SetIcon(args.destName, 8, 14)
		end
		if args:IsPlayer() then
            specWarnTouch:Show()
        end
	end
end