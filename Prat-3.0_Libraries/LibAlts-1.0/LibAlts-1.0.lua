--[[
Name: LibAlts-1.0
Revision: 5
Author: Sylvanaar (sylvanaar@mindspring.com)
Description: Shared handling of alt identity between addons.
Dependencies: LibStub
License: 
]]

local MAJOR, MINOR = "LibAlts-1.0", "6"
local lib = LibStub:NewLibrary(MAJOR, MINOR)
if not lib then return end

local _G = getfenv(0)

lib.Alts = lib.Alts or {}

local Alts = lib.Alts

local Mains  -- reverse lookup table

local tinsert = _G.tinsert
local unpack = _G.unpack
local pairs = _G.pairs
local tremove = _G.tremove
local tsort = _G.table.sort

lib.callbacks = lib.callbacks or LibStub("CallbackHandler-1.0"):New(lib)
local callbacks = lib.callbacks

local function generateRevLookups()
	Mains = {}
	for k,v in pairs(Alts) do
		for i,a in ipairs(v) do
			Mains[a] = k
		end
	end
end


--- Register a Main<->Alt relationship 
-- @name :SetAlt 
-- @param main Name of the main character
-- @param alt Name of the alt character 
function lib:SetAlt(main, alt)
	if (not main) or (not alt) then return end
	Mains = nil

	main = main:lower()
	alt = alt:lower()

	Alts[main] = Alts[main] or {}
	for i,v in ipairs(Alts[main]) do
	    if v == alt then
	        return
	    end
	end
	tinsert(Alts[main], alt)

	callbacks:Fire("LibAlts_SetAlt", main, alt)
end

--- Get a list of alts for a given character
-- @name :GetAlt 
-- @param main Name of the main character
-- @return  list list of alts 
function lib:GetAlts(main)
	if not main then return end

	main = main:lower()

	if not Alts[main] or #Alts[main] == 0 then
		return nil
	end

	return unpack(Alts[main])
end

--- Get main for a given alt character
-- @name :IsMain 
-- @param alt Name of the alt character
-- @return string the main character 
function lib:GetMain(alt)
	if not alt then return end

	alt = alt:lower()
	if not Mains then
		generateRevLookups()
	end

	return Mains[alt]
end
local unpackDictionary
do
	local temp = {}
	function unpackDictionary(t)
		for i = 1, #temp do temp[i] = nil end
		for k,v in pairs(t) do
			tinsert(temp, k)
		end
		tsort(temp)
		return unpack(temp)
	end
end
--- Get a list of all main characters
-- @name :GetAllMains
-- @return list of all main characters 
function lib:GetAllMains()
	if not Mains then
		generateRevLookups()
	end

	return unpackDictionary(Alts)
end


--- Test if a character is a main
-- @name :IsMain
-- @param main Name of the character
-- @return boolean is this a main character
function lib:IsMain(main)
	if not main then return end
	return Alts[main:lower()] and true or false
end


--- Test if a character is a alt
-- @name :IsAlt
-- @param alt Name of the character
-- @return boolean is this a alt character
function lib:IsAlt(alt)
	if not alt then return end
	
    if not Mains then
		generateRevLookups()
	end

	return Mains[alt:lower()] and true or false
end

--- Remove an Main Alt relationship and fire a callback for the disassociation.
-- @name :DeleteAlt
-- @param main Name of the Main character
-- @param alt Name of the Alt being removed
function lib:DeleteAlt(main, alt)
	main, alt = main:lower(), alt:lower()
	if not Alts[main] then return end
	Mains = nil
	for i = 1, #Alts[main] do
		if Alts[main][i] == alt then
			tremove(Alts[main], i)
		end
	end
	if #Alts[main] == 0 then
		Alts[main] = nil
	end
	callbacks:Fire("LibAlts_RemoveAlt", main, alt)	--Alt is the one removed
end
