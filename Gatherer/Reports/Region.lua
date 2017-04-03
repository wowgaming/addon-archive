--[[

	Report for Gatherer

]]

local filterName = "By Region"

function filterFunction(parameter, continent, zone, nodeid, index, x,y, count, harvest, inspect, source, gtype)
	if (continent and zone) then
		local cdata = Gatherer.Util.ZoneNames[continent]
		if (cdata and cdata[zone]) then
			local zoneName = tostring(cdata[0] or "") .. " " .. tostring(cdata[zone] or "")
			if (zoneName:lower():find(parameter:lower(), 1, true)) then return true end
		end
	end
	return false
end

Gatherer.Report.AddButton(filterName, filterFunction)
