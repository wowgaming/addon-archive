local BS = LibStub("LibBabble-Spell-3.0"):GetLookupTable()

local player = UnitName("player")
function ZAntiDaze(name)
	if not ZHunterMod_Saved["ZAntiDaze"]["on"] then return end
	if name == player then
		CancelUnitBuff("player", BS["Aspect of the Cheetah"])
	end
	CancelUnitBuff("player", BS["Aspect of the Pack"])
end