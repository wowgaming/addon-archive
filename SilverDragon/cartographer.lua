if not Cartographer_Notes then return end

local tablet = AceLibrary("Tablet-2.0")

local core = LibStub("AceAddon-3.0"):GetAddon("SilverDragon")
local module = core:NewModule("Cartographer", "AceEvent-3.0")

local cartdb = {}
local cartdb_populated
function module:OnInitialize()
	Cartographer_Notes:RegisterIcon("Rare", {text = "Rare mob", path = "Interface\\Icons\\INV_Misc_Head_Dragon_01", width=12, height=12})
	Cartographer_Notes:RegisterNotesDatabase("SilverDragon", cartdb, module)
	for zone, mobs in pairs(core.db.global.mobs_byzone) do
		zone = core.mapfile_to_zone[zone]
		if zone then
			for name, mob in pairs(mobs) do
				for _, loc in ipairs(core.db.global.mob_locations[name]) do
					local x, y = core:GetXY(loc)
					Cartographer_Notes:SetNote(zone, x, y, 'Rare', 'SilverDragon', 'title', name)
				end
			end
		end
	end
	--Cartographer_Notes:UnregisterIcon("Rare")
	--Cartographer_Notes:UnregisterNotesDatabase("SilverDragon")
end

function module:OnNoteTooltipRequest(zone, id, data, inMinimap)
	zone = core.zone_to_mapfile[zone]
	local _, level, elite, creature_type, lastseen = core:GetMob(zone, data.title)
	local cat = tablet:AddCategory('text', data.title, 'justify', 'CENTER')
	cat:AddLine('text', ("%s%s %s"):format(level or '??', elite and '+' or '', creature_type or UNKNOWN))
	cat:AddLine('text', "Last seen: "..core:FormatLastSeen(lastseen))
end

function module:OnNoteTooltipLineRequest(zone, id, data, inMinimap)
	zone = core.zone_to_mapfile[zone]
	--if not zone or not core.db.global.mobs_byzone[zone][data.title] then return end
	local _, level, elite, creature_type, lastseen = core:GetMob(zone, data.title)
	return 'text', ("%s: %s%s, %s, %s"):format(data.title, level or '??', elite and '+' or '', creature_type or UNKNOWN, core:FormatLastSeen(lastseen))
end

function module:Seen(callback, zone, name, x, y, dead, new_location)
	if new_location then
		Cartographer_Notes:SetNote(core.mapfile_to_zone[zone], x, y, 'Rare', 'SilverDragon', 'title', name)
	end
end
core.RegisterCallback(module, "Seen")

