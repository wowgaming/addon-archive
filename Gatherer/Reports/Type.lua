--[[

	Report for Gatherer

]]

local filterName = "By Type"

function filterFunction(parameter, continent, zone, nodeid, index, x,y, count, harvest, inspect, source, gtype)
	local nodeName = Gatherer.Util.GetNodeName(nodeid)
	if (nodeName and nodeName:lower():find(parameter:lower(), 1, true)) then return true end
	if (not nodeName) then DEFAULT_CHAT_FRAME:AddMessage("Unknown node: "..tostring(nodeid)) end
	return false
end

Gatherer.Report.AddButton(filterName, filterFunction)
