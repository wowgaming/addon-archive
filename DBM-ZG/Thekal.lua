local mod = DBM:NewMod("Thekal", "DBM-ZG", 1)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 148 $"):sub(12, -3))

mod:SetCreatureID(14509, 11348, 11347)
mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.YellKill)

mod:SetBossHealthInfo(
	14509, L.Thekal,
	11348, L.Zath,
	11347, L.LorKhan
)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_SUMMON",
	"CHAT_MSG_MONSTER_EMOTE",
	"CHAT_MSG_MONSTER_YELL"
)


local warnSimulKill		= mod:NewAnnounce("WarnSimulKill", 1, 24173)
local warnHeal			= mod:NewCastAnnounce(24208)
local warnBlind			= mod:NewTargetAnnounce(21060)
local warnGouge			= mod:NewTargetAnnounce(12540)
local warnPhase2		= mod:NewPhaseAnnounce(2)
local warnAdds			= mod:NewSpellAnnounce(24183)

local timerSimulKill	= mod:NewTimer(15, "TimerSimulKill", 24173)
local timerHeal			= mod:NewCastTimer(4, 24208)
local timerBlind		= mod:NewTargetTimer(10, 21060)
local timerGouge		= mod:NewTargetTimer(4, 12540)


function mod:SPELL_CAST_START(args)
	if args:IsSpellID(24208) then
		warnHeal:Show()
		timerHeal:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(21060) then     --Blind Daze
		warnBlind:Show(args.destName)
		timerBlind:Start(args.destName)
	elseif args:IsSpellID(12540) and self:IsInCombat() then --Gouge Stun
		warnGouge:Show(args.destName)
		timerGouge:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(21060) then
		timerBlind:Cancel(args.destName)
    elseif args:IsSpellID(12540) then
        timerGouge:Cancel(args.destName)
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(24813) then
		warnAdds:Show()
	end
end

local killTime = 0
function mod:CHAT_MSG_MONSTER_EMOTE(msg)
	if msg == L.PriestDied then		-- Starts timer before ressurection of adds.
		self:SendSync("PriestDied")
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellPhase2 then		-- Bossfight (tank and spank)
		self:SendSync("YellPhase2")
	end
end

function mod:OnSync(msg, arg)
	if msg == "PriestDied" then
		if (GetTime() - killTime) > 20 then
			warnSimulKill:Show()
			timerSimulKill:Start()
			killTime = GetTime()
		end
	elseif msg == "YellPhase2" then
		warnPhase2:Show()
		timerSimulKill:Cancel()
		DBM.BossHealth:Clear()
		DBM.BossHealth:AddBoss(14509, L.Thekal)
	end
end