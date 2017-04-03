local mod	= DBM:NewMod("Netherspite", "DBM-Karazhan")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 161 $"):sub(12, -3))
mod:SetCreatureID(15689)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_PERIODIC_DAMAGE",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

local warningPortalSoon		= mod:NewAnnounce("DBM_NS_WARN_PORTAL_SOON", 2, "Interface\\Icons\\Spell_Arcane_PortalIronForge")
local warningBanishSoon		= mod:NewAnnounce("DBM_NS_WARN_BANISH_SOON", 2, "Interface\\Icons\\Spell_Shadow_Cripple")
local warningPortal			= mod:NewAnnounce("warningPortal", 3, "Interface\\Icons\\Spell_Arcane_PortalIronForge")
local warningBanish			= mod:NewAnnounce("warningBanish", 3, "Interface\\Icons\\Spell_Shadow_Cripple")
local warningBreathCast		= mod:NewCastAnnounce(38523, 2)
local warningVoid			= mod:NewSpellAnnounce(37063, 3)

local specWarnVoid			= mod:NewSpecialWarningMove(30533)

local timerPortalPhase		= mod:NewTimer(61.5, "timerPortalPhase", "Interface\\Icons\\Spell_Arcane_PortalIronForge")
local timerBanishPhase		= mod:NewTimer(31, "timerBanishPhase", "Interface\\Icons\\Spell_Shadow_Cripple")
local timerBreathCast		= mod:NewCastTimer(2.5, 38523)

local berserkTimer			= mod:NewBerserkTimer(540)

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	timerPortalPhase:Start(62-delay)
	warningBanishSoon:Schedule(57-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(38523) then
		warningBreathCast:Show()
		timerBreathCast:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(37014, 37063) then
		warningVoid:Show()
	end
end

do 
	local lastVoid = 0
	function mod:SPELL_PERIODIC_DAMAGE(args)
		if args:IsSpellID(30533) and args:IsPlayer() and GetTime() - lastVoid > 2 then
			specWarnVoid:Show()
			lastVoid = GetTime()
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.DBM_NS_EMOTE_PHASE_2 then
		timerPortalPhase:Cancel()
		warningBanish:Show()
		timerBanishPhase:Start()
		warningPortalSoon:Schedule(26)
	elseif msg == L.DBM_NS_EMOTE_PHASE_1 then
		timerBanishPhase:Cancel()
		warningPortal:Show()
		timerPortalPhase:Start()
		warningBanishSoon:Schedule(56.5)
	end
end
