local BS = LibStub("LibBabble-Spell-3.0"):GetLookupTable()
local BCT = LibStub("LibBabble-CreatureType-3.0"):GetLookupTable()

local creatureTypes = {
	[BCT["Beast"]] = BS["Track Beasts"],
	[BCT["Demon"]] = BS["Track Demons"],
	[BCT["Dragonkin"]] = BS["Track Dragonkin"],
	[BCT["Elemental"]] = BS["Track Elementals"],
	[BCT["Giant"]] = BS["Track Giants"],
	[BCT["Humanoid"]] = BS["Track Humanoids"],
	[BCT["Undead"]] = BS["Track Undead"]
}
local trackingIds = {}

local function getTrackingTypes()
	local count = GetNumTrackingTypes()
	for i = 1, count do
		local name, texture, active, category = GetTrackingInfo(i)
		if category == "spell" then
			trackingIds[name] = i
		end
	end
end

local frame = CreateFrame("frame")
frame:RegisterEvent("SPELLS_CHANGED")
frame:SetScript("OnEvent", function()
	getTrackingTypes()
end)
getTrackingTypes()

SLASH_ZTrackTarget1 = "/ztracktarget"
SLASH_ZTrackTarget2 = "/tracktarget"
SlashCmdList["ZTrackTarget"] = function()
	if UnitCanAttack("player", "target") then
		local creatureType = UnitCreatureType("target")
		local trackingType = creatureTypes[creatureType]
		local trackingId = trackingIds[trackingType]
		local name, texture, active, category = GetTrackingInfo(trackingId)
		if active ~= 1 then
			SetTracking(trackingId)
		end
	end
end