
local L = TourGuide.Locale

local zonei, zonec, zonenames = {}, {}, {}
for ci,c in pairs{GetMapContinents()} do
	zonenames[ci] = {GetMapZones(ci)}
	for zi,z in pairs(zonenames[ci]) do
		zonei[z], zonec[z] = zi, ci
	end
end


local cache = {}
local function MapPoint(zone, x, y, desc, c, z)
	TourGuide:DebugF(1, "Mapping %q - %s (%.2f, %.2f)", desc, zone or z, x, y)
	local zi, zc = z or zone and zonei[zone], c or zone and zonec[zone]
	if not zi then
		if zone then TourGuide:PrintF(L["Cannot find zone %q, using current zone."], zone)
		else TourGuide:Print(L["No zone provided, using current zone."]) end

		zi, zc = GetCurrentMapZone(), GetCurrentMapContinent()
	end
	zone = zone or zonenames[zc][zi]

	if TomTom then table.insert(cache, TomTom:AddZWaypoint(zc, zi, x, y, desc, false))
	elseif Cartographer_Waypoints then
		local pt = NotePoint:new(zone, x/100, y/100, desc)
		Cartographer_Waypoints:AddWaypoint(pt)
		table.insert(cache, pt.WaypointID)
	end
	
	SendAddonMessage("TGuideWP", string.join(" ", zc, zi, x, y, desc), "PARTY")
end


local elapsed, taction, tquest, tzone, tnote, tqid, tlogi
local f = CreateFrame("Frame")
f:Hide()
f:SetScript("OnShow", function() elapsed = 0 end)
f:SetScript("OnUpdate", function(self, elap)
	elapsed = elapsed + elap
	if elapsed < 1 then return end
	self:Hide()
	TourGuide:ParseAndMapCoords(taction, tquest, tzone, tnote, tqid, tlogi)
end)
local temp = {}
function TourGuide:ParseAndMapCoords(action, quest, zone, note, qid, logi)
	taction, tquest, tzone, tnote, tqid, tlogi = action, quest, zone, note, qid, logi
	if TomTom and TomTom.RemoveWaypoint then
		while cache[1] do TomTom:RemoveWaypoint(table.remove(cache)) end
	elseif Cartographer_Waypoints then
		while cache[1] do Cartographer_Waypoints:CancelWaypoint(table.remove(cache)) end
	end

	if logi and (action == "COMPLETE" or action == "TURNIN") then
		QuestMapUpdateAllQuests()
		QuestPOIUpdateIcons()
		local _, x, y, obj = QuestPOIGetIconInfo(qid)
		if x and y then table.insert(temp, y*100) table.insert(temp, x*100)
		else return f:Show() end
	end
	if not temp[1] and (action == "ACCEPT" or action == "TURNIN") and LightHeaded then self:MapLightHeadedNPC(qid, action, quest) end
	if not temp[1] and note and self.db.char.mapnotecoords then for x,y in note:gmatch(L.COORD_MATCH) do table.insert(temp, tonumber(y)); table.insert(temp, tonumber(x)) end end
	while temp[1] do MapPoint(zone, table.remove(temp), table.remove(temp), "[TG] "..quest) end
end


function TourGuide:MapLightHeadedNPC(qid, action, quest)
	if not self.db.char.mapquestgivers then return end

	local npcid, npcname, stype
	if action == "ACCEPT" then _, _, _, _, stype, npcname, npcid = LightHeaded:GetQuestInfo(qid)
	else _, _, _, _, _, _, _, stype, npcname, npcid = LightHeaded:GetQuestInfo(qid) end
	self:Debug(1, "LightHeaded lookup", action, qid, stype, npcname, npcid)
	if stype ~= "npc" then return end

	local data = LightHeaded:LoadNPCData(tonumber(npcid))
	if not data then return end
	for zid,x,y in data:gmatch("([^,]+),([^,]+),([^:]+):") do MapPoint(nil, tonumber(x), tonumber(y), "[TG] "..quest.." ("..npcname..")", LightHeaded:WZIDToCZ(tonumber(zid))) end
	return true
end
