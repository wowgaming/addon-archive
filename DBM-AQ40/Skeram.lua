local mod	= DBM:NewMod("Skeram", "DBM-AQ40", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 133 $"):sub(12, -3))
mod:SetCreatureID(15263)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON",
	"UNIT_HEALTH"
)

local warnMindControl	= mod:NewTargetAnnounce(785, 3)
local warnTeleport		= mod:NewSpellAnnounce(20449, 3)
local warnSummon		= mod:NewSpellAnnounce(747, 3)
local warnSummonSoon	= mod:NewSoonAnnounce(747, 2)

local timerMindControl	= mod:NewBuffActiveTimer(20, 785)

mod:AddBoolOption("SetIconOnMC", true)

local split1
local split2
local split3
local MCTargets = {}
local MCIcon 	= 8

function mod:OnCombatStart(delay)
	split1 = false
	split2 = false
	split3 = false
	table.wipe(MCTargets)
	MCIcon = 8
end

local function warnMCTargets()
	warnMindControl:Show(table.concat(MCTargets, "<, >"))
	timerMindControl:Start()
	table.wipe(MCTargets)
	MCIcon = 8
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(785) then
		MCTargets[#MCTargets + 1] = args.destName
		self:Unschedule(warnMCTargets)
		if #MCTargets >= 3 then
			warnMCTargets()
		else
			self:Schedule(0.3, warnMCTargets)
		end
		if self.Options.SetIconOnMC then
			self:SetIcon(args.destName, MCIcon, 20)
			MCIcon = MCIcon - 1
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(20449, 4801, 8195) then
		warnTeleport:Show()
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(747) then
		warnSummon:Show()
	end
end

function mod:UNIT_HEALTH(uId)
	if self:GetUnitCreatureId(uId) == 15263 then
		local percent = UnitHealth(uId) / UnitHealthMax(uId) * 100
		if percent <= 81 and percent >= 77 and not split1 then
			warnSummonSoon:Show()
			split1 = true
		elseif percent <= 56 and percent >= 52 and not split2 then
			warnSummonSoon:Show()
			split2 = true
		elseif percent <= 31 and percent >= 27 and not split3 then
			warnSummonSoon:Show()
			split3 = true
		end
	end
end