local mod	= DBM:NewMod("Oz", "DBM-Karazhan")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 163 $"):sub(12, -3))
mod:SetCreatureID(18168)
mod:RegisterCombat("yell", L.DBM_OZ_YELL_DOROTHEE)
mod:SetMinCombatTime(25)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"CHAT_MSG_MONSTER_YELL"
)

local WarnRoar		= mod:NewAnnounce("DBM_OZ_WARN_ROAR", 2, nil, nil, false)
local WarnStrawman	= mod:NewAnnounce("DBM_OZ_WARN_STRAWMAN", 2, nil, nil, false)
local WarnTinhead	= mod:NewAnnounce("DBM_OZ_WARN_TINHEAD", 2, nil, nil, false)
local WarnTido		= mod:NewAnnounce("DBM_OZ_WARN_TITO", 2, nil, nil, false)
local WarnCrone		= mod:NewAnnounce("DBM_OZ_WARN_CRONE", 2, nil, nil, false)

local timerRoar		= mod:NewTimer(14.5, "DBM_OZ_WARN_ROAR", "Interface\\Icons\\Ability_Druid_ChallangingRoar", nil, false)
local timerStrawman	= mod:NewTimer(24, "DBM_OZ_WARN_STRAWMAN", "Interface\\Icons\\INV_Helmet_34", nil, false)
local timerTinhead	= mod:NewTimer(33, "DBM_OZ_WARN_TINHEAD", "Interface\\Icons\\INV_Helmet_02", nil, false)
local timerTito		= mod:NewTimer(47.5, "DBM_OZ_WARN_TITO", "Interface\\Icons\\Ability_Mount_WhiteDireWolf", nil, false)

mod:AddBoolOption("AnnounceBosses", true, "announce")
mod:AddBoolOption("ShowBossTimers", true, "timer")
mod:AddBoolOption("DBM_OZ_OPTION_1")

function mod:OnCombatStart(delay)
	if self.Options.ShowBossTimers then
		timerRoar:Start(-delay)
		timerStrawman:Start(-delay)
		timerTinhead:Start(-delay)
		timerTito:Start(-delay)
	end
end

function mod:OnCombatEnd()
	if self.Options.DBM_OZ_OPTION_1 then
		DBM.RangeCheck:Hide()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.DBM_OZ_YELL_ROAR then
		if self.Options.AnnounceBosses then
			WarnRoar:Show()
		end
	elseif msg == L.DBM_OZ_YELL_STRAWMAN then
		if self.Options.AnnounceBosses then
			WarnStrawman:Show()
		end
	elseif msg == L.DBM_OZ_YELL_TINHEAD then
		if self.Options.AnnounceBosses then
			WarnTinhead:Show()
		end
	elseif msg == L.DBM_OZ_YELL_CRONE then
		if self.Options.AnnounceBosses then
			WarnCrone:Show()
		end
		if self.Options.DBM_OZ_OPTION_1 then
			DBM.RangeCheck:Show(10)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(31014) then
		if self.Options.AnnounceBosses then
			WarnTido:Schedule(1)
		end
	end
end
