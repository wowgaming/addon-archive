local mod	= DBM:NewMod("CThun", "DBM-AQ40", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 132 $"):sub(12, -3))
mod:SetCreatureID(15727)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_SUMMON",
	"CHAT_MSG_MONSTER_EMOTE"
)

local warnEyeTentacle		= mod:NewAnnounce("WarnEyeTentacle", 2)
local warnClawTentacle		= mod:NewAnnounce("WarnClawTentacle", 2)
local warnGiantEyeTentacle	= mod:NewAnnounce("WarnGiantEyeTentacle", 3)
local warnGiantClawTentacle	= mod:NewAnnounce("WarnGiantClawTentacle", 3)
local warnDarkGlare			= mod:NewSpellAnnounce(26029, 4)
local warnDarkGlareSoon		= mod:NewSoonAnnounce(26029, 2)
local warnWeakened			= mod:NewAnnounce("WarnWeakened", 4)
local warnPhase2			= mod:NewPhaseAnnounce(2)

local timerDarkGlareCD		= mod:NewCDTimer(50, 26029)
local timerDarkGlare		= mod:NewBuffActiveTimer(10, 26029)
local timerEyeTentacle		= mod:NewTimer(45, "TimerEyeTentacle")
local timerGiantEyeTentacle	= mod:NewTimer(60, "TimerGiantEyeTentacle")
local timerClawTentacle		= mod:NewTimer(11, "TimerClawTentacle")
local timerGiantClawTentacle = mod:NewTimer(60, "TimerGiantClawTentacle")
local timerWeakened			= mod:NewTimer(45, "TimerWeakened")

mod:AddBoolOption("RangeFrame", true)

local phase2

function mod:OnCombatStart(delay)
	phase2 = false
	timerEyeTentacle:Start(-delay)
	timerClawTentacle:Start(-delay)
	timerDarkGlareCD:Start(-delay)
	self:ScheduleMethod(45, "eyeTentacle")
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(10)
	end
end

function mod:eyeTentacle()
	local timer = 45
	if phase2 then timer = 30 end
	warnEyeTentacle:Show()
	timerEyeTentacle:Start(timer)
	self:ScheduleMethod(timer, "eyeTentacle")
end

function mod:SPEL_SUMMON(args)
	if args:IsSpellID(99999) then	-- add summon Giant Eye ID
		timerGiantClawTentacle:Start(30)
		timerGiantEyeTentacle:Start(60)
	elseif args:IsSpellID(99998) then	-- add summon Giant Claw ID
		timerGiantEyeTentacle:Start(30)
		timerGiantClawTentacle:Start(60)
	end
end

function mod:CHAT_MSG_MONSTER_EMOTE(msg)
	if msg:find(L.Weakened) then
		timerWeakened:Start()
		warnWeakened:Show()
	end
end