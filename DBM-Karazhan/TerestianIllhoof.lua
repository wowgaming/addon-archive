local mod	= DBM:NewMod("TerestianIllhoof", "DBM-Karazhan")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 163 $"):sub(12, -3))
mod:SetCreatureID(15688)

mod:SetBossHealthInfo(
	15688, L.name,
	17229, L.Kilrek
)

--mod:RegisterCombat("yell", L.DBM_TI_YELL_PULL)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"UNIT_DIED"
)

local warningWeakened	= mod:NewTargetAnnounce(30065, 2)
local warningImpSoon	= mod:NewSoonAnnounce(30066, 2)
local warningImp		= mod:NewSpellAnnounce(30066, 3)
local warningSacSoon	= mod:NewSoonAnnounce(30115, 3)
local warningSacrifice	= mod:NewTargetAnnounce(30115, 4)

local specWarnSacrifice	= mod:NewSpecialWarningYou(30115)

local timerWeakened		= mod:NewBuffActiveTimer(31, 30065)
local timerSacrifice	= mod:NewTargetTimer(30, 30115)
local timerSacrificeCD	= mod:NewNextTimer(43, 30115)

local berserkTimer		= mod:NewBerserkTimer(600)

mod:AddBoolOption("HealthFrame", true)

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(30115) then
		DBM.BossHealth:AddBoss(17248, L.DChains)
		warningSacrifice:Show(args.destName)
		timerSacrifice:Start(args.destName)
		timerSacrificeCD:Start()
		warningSacSoon:Cancel()
		warningSacSoon:Schedule(38)
		if args:IsPlayer() then
			specWarnSacrifice:Show()
		end
	elseif args:IsSpellID(30065) then
		warningWeakened:Show(args.destName)
		timerWeakened:Start()
		warningImpSoon:Schedule(26)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(30115) then
		timerSacrifice:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(30066) then
		warningImpSoon:Cancel()
		warningImp:Show()
		DBM.BossHealth:AddBoss(17229, L.Kilrek)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 17229 then--Kil'rek
		DBM.BossHealth:RemoveBoss(cid)
	elseif cid == 17248 then--Demon Chains
		DBM.BossHealth:RemoveBoss(cid)
	end
end
