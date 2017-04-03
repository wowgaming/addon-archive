--[[
Name: Prat 3.0 (classgenderfix.lua)
Revision: $Revision: 79217 $
Author(s): Sylvaanar (sylvanaar@mindspring.com)
Inspired By: Prat 2.0, Prat, and idChat2 by Industrial
Website: http://files.wowace.com/Prat/
Documentation: http://www.wowace.com/wiki/Prat
Forum: http://www.wowace.com/forums/index.php?topic=6243.0
SVN: http://svn.wowace.com/wowace/trunk/Prat/
Description: Fixes class data lookups against babble 3.0
]]

--[[ BEGIN STANDARD HEADER ]]--

-- Imports
local _G = _G
local LibStub = LibStub
local setmetatable = setmetatable

-- Isolate the environment
setfenv(1, SVC_NAMESPACE)

--[[ END STANDARD HEADER ]]--



--@non-debug@
local BR
--@non-end-debug@

BR = setmetatable({}, {
	 __index = function(t, k)
		_G.EnableAddOn("LibBabble-Class-3.0")
		_G.LoadAddOn("LibBabble-Class-3.0")
		setmetatable(t, { __index = LibStub("LibBabble-Class-3.0"):GetReverseLookupTable() } )
		return t[k]
end })

function GetGenderNeutralClass(ns, class)
	class = class or ns
	return class and (BR[class] or class):upper()
end

-- /print Prat.GetGenderNeutralClass("Shaman")