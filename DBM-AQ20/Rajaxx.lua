local mod	= DBM:NewMod("Rajaxx", "DBM-AQ20", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 171 $"):sub(12, -3))
mod:SetCreatureID(15341)
mod:RegisterCombat("yell", L.Wave1)
mod:SetMinCombatTime(60)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS",
	"CHAT_MSG_MONSTER_YELL"
)

local warnWave		= mod:NewAnnounce("WarnWave", 2)
local warnOrder		= mod:NewTargetAnnounce(25471)
local warnCloud		= mod:NewSpellAnnounce(26550)

local specWarnOrder	= mod:NewSpecialWarningYou(25471)

local timerOrder	= mod:NewTargetTimer(10, 25471)
local timerCloud	= mod:NewBuffActiveTimer(15, 26550)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(25471) then
		warnOrder:Show(args.destName)
		timerOrder:Start(args.destName)
		if args:IsPlayer() then
			specWarnOrder:Show()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(26550) then
		warnCloud:Show()
		timerCloud:Start()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)--some of these yells have line breaks that message match doesn't grab, so will try find.
	if msg == L.Wave1 or msg:find(L.Wave1) then
		self:SendSync("Wave", 1)
	elseif msg == L.Wave3 or msg:find(L.Wave3) then
		self:SendSync("Wave", 3)
	elseif msg == L.Wave4 or msg:find(L.Wave4) then
		self:SendSync("Wave", 4)
	elseif msg == L.Wave5 or msg:find(L.Wave5) then
		self:SendSync("Wave", 5)
	elseif msg == L.Wave6 or msg:find(L.Wave6) then
		self:SendSync("Wave", 6)
	elseif msg == L.Wave7 or msg:find(L.Wave7) then
		self:SendSync("Wave", 7)
	elseif msg == L.Wave8 or msg:find(L.Wave8) then
		self:SendSync("Wave", 8)
	end
end

function mod:OnSync(msg, arg)
	if msg == "Wave" then
		warnWave:Show(arg)
	end
end