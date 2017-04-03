local mod	= DBM:NewMod("EdgeOfMadness", "DBM-ZG", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 132 $"):sub(12, -3))
mod:SetCreatureID(15083)
mod:RegisterCombat("combat")
mod:SetBossHealthInfo(
	15083, L.Hazzarah,
	15084, L.Renataki,
	15085, L.Wushoolay,
	15082, L.Grilek
)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_SUMMON"
)

local warnIllusions	= mod:NewSpellAnnounce(24728)
local warnSleep		= mod:NewSpellAnnounce(24664)
local warnChainBurn	= mod:NewSpellAnnounce(24684)
local warnFrenzy	= mod:NewSpellAnnounce(8269)
local warnVanish	= mod:NewSpellAnnounce(24699)
local warnCloud		= mod:NewSpellAnnounce(24683)

local timerSleep	= mod:NewBuffActiveTimer(6, 24664)
local timerCloud	= mod:NewBuffActiveTimer(15, 24683)

local spamSleep = 0
function mod:OnCombatStart(delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(24684) then
		warnChainBurn:Show()
	elseif args:IsSpellID(24699) then
		warnVanish:Show()
	elseif args:IsSpellID(24699) then
		warnCloud:Show()
		timerCloud:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(24664) and GetTime() - spamSleep > 5 then
		warnSleep:Show()
		timerSleep:Start()
	elseif args:IsSpellID(8269) and self:IsInCombat() then
		warnFrenzy:Show()
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(24684) then
		warnIllusions:Show()
	elseif args:IsSpellID(24699) then
		warnCloud:Show()
		timerCloud:Start()
	end
end