local mod	= DBM:NewMod("Viscidus", "DBM-AQ40", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 132 $"):sub(12, -3))
mod:SetCreatureID(15299)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_MONSTER_EMOTE"
)

local warnFreeze		= mod:NewAnnounce("WarnFreeze", 2)
local warnShatter		= mod:NewAnnounce("WarnShatter", 2)

local timerFrozen		= mod:NewBuffActiveTimer(15, 25937)

function mod:OnCombatStart(delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(26034) then
		warnFreeze:Show(1)
	elseif args:IsSpellID(26036) then
		warnFreeze:Show(2)
	elseif args:IsSpellID(25937) then
		warnFreeze:Show(3)
		timerFrozen:Start()
	end
end

function mod:CHAT_MSG_MONSTER_EMOTE(msg)
	if msg:find(L.Phase4) then
		self:SendSync("Phase", 4)
	elseif msg:find(L.Phase5) then
		self:SendSync("Phase", 5)
	elseif msg:find(L.Phase6) then
		self:SendSync("Phase", 6)
	end
end

function mod:OnSync(msg, arg)
	if msg == "Phase" then
		warnShatter:Show(tonumber(arg))
	end
end