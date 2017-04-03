local mod	= DBM:NewMod("Ragnaros", "DBM-MC", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 143 $"):sub(12, -3))
mod:SetCreatureID(11502)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"CHAT_MSG_MONSTER_YELL"
)

local warnWrathRag		= mod:NewSpellAnnounce(20566)
--local warnHandRag		= mod:NewSpellAnnounce(19780)--does not show in combat log. need transciptor to get more data on this later
local warnSubmergeSoon	= mod:NewAnnounce("WarnSubmergeSoon", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local warnSubmerge		= mod:NewAnnounce("WarnSubmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local warnEmergeSoon	= mod:NewAnnounce("WarnEmergeSoon", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local warnEmerge		= mod:NewAnnounce("WarnEmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")

local timerWrathRag		= mod:NewNextTimer(30, 20566)
--local timerHandRag		= mod:NewNextTimer(111, 19780)
local timerSubmerge		= mod:NewTimer(180, "TimerSubmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local timerEmerge		= mod:NewTimer(90, "TimerEmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local timerCombatStart	= mod:NewTimer(78, "TimerCombatStart", 2457)

local submerged
function mod:OnCombatStart(delay)
	submerged = false
	timerSubmerge:Start(-delay)
	warnSubmergeSoon:Schedule(170-delay)
	timerWrathRag:Start(27-delay)
end

function mod:emerged()
	timerEmerge:Cancel()
	warnEmerge:Show()
	timerSubmerge:Start()
	warnSubmergeSoon:Schedule(170)
	submerge = false
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(20566) then
		warnWrathRag:Show()
		timerWrathRag:Start()
--	elseif args:IsSpellID(19780) then
--		warnHandRag:Show()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Submerge then
		self:SendSync("Submerge")
	elseif msg ~= L.Submerge and submerged then
		self:SendSync("Emerge")
	elseif msg == L.Pull then
		self:SendSync("RagPulled")
	end
end

function mod:OnSync(msg, arg)
	if msg == "Submerge" and not submerge then
		submerge = true
		warnSubmerge:Show()
		timerEmerge:Start()
		warnEmergeSoon:Schedule(80)
		self:ScheduleMethod(90, "emerged")
	elseif msg == "Emerge" then
		emerged()
	elseif msg == "RagPulled" then
		timerCombatStart:Start()
	end
end