local mod = DBM:NewMod("Dalliah", "DBM-Party-BC", 15)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 147 $"):sub(12, -3))

mod:SetCreatureID(20885)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warnHeal			= mod:NewSpellAnnounce(39013)
local warnWhirlwind		= mod:NewSpellAnnounce(36175)
local warnGift			= mod:NewTargetAnnounce(39009)
local timerGift			= mod:NewTargetTimer(10, 39009)

local specwarnWhirlwind	= mod:NewSpecialWarningRun(36175, mod:IsMelee())

local soundWhirlwind	= mod:NewSound(36175, nil, mod:IsMelee())

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(39013, 36144) then
		warnHeal:Show()
	elseif args:IsSpellID(36175, 36142) then
		warnWhirlwind:Show()
		specwarnWhirlwind:Show()
		soundWhirlwind:Play()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(39009, 36173) then
		warnGift:Show(args.destName)
		timerGift:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(39009, 36173) then
		timerGift:Cancel(args.destName)
	end
end