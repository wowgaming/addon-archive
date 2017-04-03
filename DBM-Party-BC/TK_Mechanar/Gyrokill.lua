local mod	= DBM:NewMod("Gyrokill", "DBM-Party-BC", 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 128 $"):sub(12, -3))
mod:SetCreatureID(19218)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local isDispeller = select(2, UnitClass("player")) == "MAGE"
				 or select(2, UnitClass("player")) == "PRIEST"
				 or select(2, UnitClass("player")) == "SHAMAN"

local warnShadowpower       = mod:NewSpellAnnounce(35322)
local timerShadowpower      = mod:NewBuffActiveTimer(15, 35322)
local specWarnShadowpower   = mod:NewSpecialWarningDispel(35322, isDispeller)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(39193, 35322) and not args:IsDestTypePlayer() and self:IsInCombat() then     --Shadow Power
		warnShadowpower:Show(args.destName)
		timerShadowpower:Start(args.destName)
		specWarnShadowpower:Show(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(39193, 35322) and not args:IsDestTypePlayer() then     --Shadow Power
		timerShadowpower:Cancel(args.destName)
	end
end