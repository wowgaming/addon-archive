local BS = LibStub("LibBabble-Spell-3.0"):GetLookupTable()

local band = bit.band
local raider = bit.bor(
	0x00000001, -- COMBATLOG_OBJECT_AFFILIATION_MINE
	0x00000002, -- COMBATLOG_OBJECT_AFFILIATION_PARTY
	0x00000004, -- COMBATLOG_OBJECT_AFFILIATION_RAID
	0x00000010, -- COMBATLOG_OBJECT_REACTION_FRIENDLY
	0x00000100, -- COMBATLOG_OBJECT_CONTROL_PLAYER
	0x00000200, -- COMBATLOG_OBJECT_CONTROL_NPC
	0x00000400, -- COMBATLOG_OBJECT_TYPE_PLAYER
	0x00001000, -- COMBATLOG_OBJECT_TYPE_PET
	0x00002000, -- COMBATLOG_OBJECT_TYPE_GUARDIAN
	0x00004000) -- COMBATLOG_OBJECT_TYPE_OBJECT
local groupmate = bit.bor(
	0x00000001, -- COMBATLOG_OBJECT_AFFILIATION_MINE
	0x00000002, -- COMBATLOG_OBJECT_AFFILIATION_PARTY
	0x00000010, -- COMBATLOG_OBJECT_REACTION_FRIENDLY
	0x00000100, -- COMBATLOG_OBJECT_CONTROL_PLAYER
	0x00000200, -- COMBATLOG_OBJECT_CONTROL_NPC
	0x00000400, -- COMBATLOG_OBJECT_TYPE_PLAYER
	0x00001000, -- COMBATLOG_OBJECT_TYPE_PET
	0x00002000, -- COMBATLOG_OBJECT_TYPE_GUARDIAN
	0x00004000) -- COMBATLOG_OBJECT_TYPE_OBJECT
local mine = bit.bor(
	0x00000001, -- COMBATLOG_OBJECT_AFFILIATION_MINE
	0x00000010, -- COMBATLOG_OBJECT_REACTION_FRIENDLY
	0x00000100, -- COMBATLOG_OBJECT_CONTROL_PLAYER
	0x00000400, -- COMBATLOG_OBJECT_TYPE_PLAYER
	0x00004000) -- COMBATLOG_OBJECT_TYPE_OBJECT
local player = UnitName("player")

local function UnitIsA(unitFlags, flagType)
--	for k, flagType in pairs({...}) do
		if (band(band(unitFlags, flagType), 0x0000000F) > 0 and	-- COMBATLOG_OBJECT_AFFILIATION_MASK
		band(band(unitFlags, flagType), 0x000000F0) > 0 and	-- COMBATLOG_OBJECT_REACTION_MASK
		band(band(unitFlags, flagType), 0x00000300) > 0 and	-- COMBATLOG_OBJECT_CONTROL_MASK
		band(band(unitFlags, flagType), 0x0000FC00) > 0)	-- COMBATLOG_OBJECT_TYPE_MASK
		or band(band(unitFlags, flagType), 0xFFFF0000) > 0 then	-- COMBATLOG_OBJECT_SPECIAL_MASK
			return true
		end
--	end
	return false
end

local frame = CreateFrame("frame")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:SetScript("OnEvent", function(self, frameEvent, timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, ...)
	if event == "SPELL_AURA_APPLIED" or event == "SPELL_AURA_APPLIED_DOSE" then
		local spellName, spellSchool, auraType, amount = select(2, ...)
		if UnitIsA(destFlags, groupmate) then
			if auraType == "DEBUFF" then
				if spellName == BS["Dazed"] then
					ZAntiDaze(destName)
				end
			end
		end
	elseif event == "SPELL_DISPEL" then
		local spellName, spellSchool, extraSpellId, extraSpellName, _, auraType = select(2, ...)
		if sourceName == player and spellName == BS["Tranquilizing Shot"] and auraType == "BUFF" then
			if ZArcaneDispel then
				ZArcaneDispel(destName, extraSpellName)
			end
		end
	elseif event == "SPELL_DISPEL_FAILED" then
		local spellName, spellSchool, extraSpellId, extraSpellName = select(2, ...)
		if sourceName == player and spellName == BS["Tranquilizing Shot"] then
			if ZArcaneDispel then
				ZArcaneDispel(destName, extraSpellName, 1)
			end
		end
	elseif event == "SPELL_MISSED" then
		local spellName, spellSchool, missType = select(2, ...)
		if spellName == BS["Freezing Trap Effect"] and UnitIsA(sourceFlags, mine) then
			if ZFreezeFail then
				ZFreezeFail(destName, missType)
			end
		end
	end
end)