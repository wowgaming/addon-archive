--[[ BEGIN STANDARD HEADER ]]--

-- Imports
local _G = _G
local SVC_NAMESPACE = SVC_NAMESPACE

-- Isolate the environment
setfenv(1, SVC_NAMESPACE)

--[[ END STANDARD HEADER ]]--

FolderLocation = _G.debugstack():match("ns\\(.-)\\")

