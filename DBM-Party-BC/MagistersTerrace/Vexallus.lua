local mod = DBM:NewMod("Vexallus", "DBM-Party-BC", 16)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 147 $"):sub(12, -3))

mod:SetCreatureID(24744)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

local WarnEnergy		= mod:NewAnnounce("WarnEnergy", 3, 44335)

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Discharge then
        WarnEnergy:Show()
	end
end