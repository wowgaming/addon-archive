local mod	= DBM:NewMod("Majordomo", "DBM-MC", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 132 $"):sub(12, -3))
mod:SetCreatureID(12018)
mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.Kill)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS"
)

local isMelee = select(2, UnitClass("player")) == "ROGUE"
	     or select(2, UnitClass("player")) == "WARRIOR"
	     or select(2, UnitClass("player")) == "DEATHKNIGHT"

local warnMagicReflect	= mod:NewSpellAnnounce(20619)
local warnDamageShield	= mod:NewSpellAnnounce(21075)
local warnTeleport		= mod:NewTargetAnnounce(20534)

local specWarnMagicReflect		= mod:NewSpecialWarningSpell(20619, not isMelee)

local timerMagicReflect	= mod:NewBuffActiveTimer(10, 20619)
local timerDamageShield	= mod:NewBuffActiveTimer(10, 21075)

function mod:OnCombatStart(delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(20619) then
		warnMagicReflect:Show()
		specWarnMagicReflect:Show()
		timerMagicReflect:Start()
	elseif args:IsSpellID(21075) then
		warnDamageShield:Show()
		timerDamageShield:Start()
	elseif args:IsSpellID(20534) then
		warnTeleport:Show(args.destName)
	end
end