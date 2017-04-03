
--[[ BEGIN STANDARD HEADER ]]--

-- Imports
local _G = _G
local SVC_NAMESPACE = SVC_NAMESPACE

-- Isolate the environment
setfenv(1, SVC_NAMESPACE)

--[[ END STANDARD HEADER ]]--

if ChunkSizes then
CNTR = CNTR or 1
	local function MemoryUse(name)
		_G.UpdateAddOnMemoryUsage()
		return _G.GetAddOnMemoryUsage(name)
	end
	
	local location = _G.debugstack():match("ns\\(.-)\\")
	
	ChunkSizes[CNTR] = MemoryUse(location) or "?"
CNTR = CNTR + 1
end

if CheckPoints then
    local location = _G.debugstack():match("ns\\(.-)\\")
    CheckPoints[#CheckPoints+1] = ("%s: %d sec"):format(location or "?", time())
end


if not PrintChunkInfo then 
    function PrintChunkInfo()
    	if ChunkSizes then
    		local last = 0
    		for i, v in ipairs(ChunkSizes) do
    			Print("Chunk #"..tostring(i)..":"..("|cff80ffff%.0f|r KB"):format(v-last))
    			last = v
    		end
    		Print("Total Size: "..("|cff80ffff%.0f|r KB"):format(ChunkSizes[#ChunkSizes]))
    		ChunkSizes = nil
    	end
    end
end