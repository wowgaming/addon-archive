
--[[ BEGIN STANDARD HEADER ]]--

-- Imports
local _G = _G
local SVC_NAMESPACE = SVC_NAMESPACE

-- Isolate the environment
setfenv(1, SVC_NAMESPACE)

--[[ END STANDARD HEADER ]]--


function GetMemoryUse(name)
	_G.UpdateAddOnMemoryUsage()
	local mem = _G.GetAddOnMemoryUsage(name)
	local text2
	if mem > 1024 then
		text2 = ("|cff80ffff%.2f|r MB"):format(mem / 1024)
	else
		text2 = ("|cff80ffff%.0f|r KB"):format(mem)
	end
	
	return text2
end

local location = _G.debugstack():match("ns\\(.-)\\")

function MemoryUse()
	return GetMemoryUse(location)
end



