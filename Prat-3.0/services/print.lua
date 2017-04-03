
--[[ BEGIN STANDARD HEADER ]]--

-- Imports
local _G = _G
local LibStub = LibStub
local tostring = tostring
local select = select
local type = type

local SVC_NAMESPACE = SVC_NAMESPACE

-- Isolate the environment
setfenv(1, SVC_NAMESPACE)

--[[ END STANDARD HEADER ]]--


--[[ from AceConsole-3.0 ]]--
function Print(...)
	local text = ""
	local first = 1

	local frame = select(first, ...)
	if frame == SVC_NAMESPACE then
		first = first + 1
		frame = select(first, ...)
	end

	if not ( type(frame) == "table" and frame.AddMessage ) then	-- Is first argument something with an .AddMessage member?
		frame=nil
	else
		first = first + 1
	end
	
	for i=first, select("#", ...) do
		text = text .. tostring( select( i, ...) ) .." "
	end
	(frame or _G.DEFAULT_CHAT_FRAME):AddMessage( tostring(SVC_NAMESPACE)..": "..text )
end

if not PrintLiteral then
	function PrintLiteral()
	end
end

if not AddPrintMethod then
    function AddPrintMethod(frame) 
        function frame:print(...) 
            Print(self, ...) 
        end
        function frame:dbg() 
        end
    end

    for i=1, _G.NUM_CHAT_WINDOWS do
        AddPrintMethod(_G["ChatFrame"..i])
    end
end
