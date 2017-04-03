--[[
Name: PeriodicTable-3.1
Revision: $Rev: 6 $
Author: Nymbia (nymbia@gmail.com)
Many thanks to Tekkub for writing PeriodicTable 1 and 2, and for permission to use the name PeriodicTable!
Website: http://www.wowace.com/wiki/PeriodicTable-3.1
Documentation: http://www.wowace.com/wiki/PeriodicTable-3.1/API
SVN: http://svn.wowace.com/wowace/trunk/PeriodicTable-3.1/PeriodicTable-3.1/
Description: Library of compressed itemid sets.
Dependencies: AceLibrary
License: LGPL v2.1
Copyright (C) 2007 Nymbia

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
]]

local PT3, oldminor = LibStub:NewLibrary("LibPeriodicTable-3.1", tonumber(("$Revision: 6 $"):match("(%d+)")) + 90000)
if not PT3 then
	return
end

-- local references to oft-used global functions.
local type = type
local rawget = rawget
local tonumber = tonumber
local pairs = pairs
local ipairs = ipairs
local next = next
local assert = assert
local table_concat = table.concat

local iternum, iterpos, cache, sets, embedversions
---------------------------------------------
--       Internal / Local Functions        --
---------------------------------------------
local getItemID, makeNonPresentMultiSet, shredCache, setiter, multisetiter

function getItemID(item)
	-- accepts either an item string ie "item:12345:0:0:0:2342:123324:12:1", hyperlink, or an itemid.
	-- returns a number'ified itemid.
	return tonumber(item) or tonumber(item:match("item:(%d+)")) or (-1 * ((item:match("enchant:(%d+)") or item:match("spell:(%d+)")) or 0))
end

do
	local tables = setmetatable({},{__mode = 'k'})
	function makeNonPresentMultiSet(parentname)
		-- makes an implied multiset, ie if you define only the set "a.b.c", 
		-- a request to "a.b" will come through here for a.b to be built.
		-- an expensive function because it needs to iterate all active sets,
		-- moreso for invalid sets.
		
		-- store some temp tables with weak keys to reduce garbage churn
		local temp = next(tables)
		if temp then
			tables[temp] = nil
		else
			temp = {}
		end
		-- Escape characters that will screw up the name matching.
		local escapedparentname = parentname:gsub("([%.%(%)%%%+%-%*%?%[%]%^%$])", "%%%1")
		-- Check all the sets to see if they start with this name.
		for k in pairs(sets) do
			if k:match("^"..escapedparentname.."%.") then
				temp[#temp+1] = k
			end
		end
		if #temp == 0 then
			sets[parentname] = false
		else
			sets[parentname] = "m,"..table_concat(temp, ',')
		end
		-- clear the temp table then feed it back into the recycler
		for k in pairs(temp) do
			temp[k] = nil
		end
		tables[temp] = true
	end
end

function shredCache(setname)
	-- If there's a cache for this set, delete it, since we just added a new copy.
	if rawget(cache, setname) then
		cache[setname] = nil
	end
	local parentname = setname:match("^(.+)%.[^%.]+$")
	if parentname then
		-- Recurse and do the same for the parent set if we find one.
		shredCache(parentname)
	end
end

function setiter(t)
	local k,v
	if iterpos then
		-- We already have a position that we're at in the iteration, grab the next value up.
		k,v = next(t,iterpos)
	else
		-- We havent yet touched this set, grab the first value.
		k,v = next(t)
	end
	if k == "set" then
		k,v = next(t, k)
	end
	if k then
		iterpos = k
		return k,v,t.set
	end
end

function multisetiter(t)
	local k,v
	if iterpos then
		-- We already have a position that we're at in the iteration, grab the next value up.
		k,v = next(t[iternum],iterpos)
	else
		-- We havent yet touched this set, grab the first value.
		k,v = next(t[iternum])
	end
	if k == "set" then
		k,v = next(t[iternum], k)
	end
	if k then
		-- There's an entry here, no need to move on to the next table yet.
		iterpos = k
		return k,v,t[iternum].set
	else
		-- No entry, time to check for a new table.
		iternum = iternum + 1
		if not t[iternum] then
			return
		end
		k,v = next(t[iternum])
		if k == "set" then
			k,v = next(t[iternum],k)
		end
		iterpos = k
		return k,v,t[iternum].set
	end
end

do
	-- Handle the initial scan of LoD data modules, storing in this local table so the sets metatable can find em
	local lodmodules = {}
	for i = 1, GetNumAddOns() do
		local metadata = GetAddOnMetadata(i, "X-PeriodicTable-3.1-Module")
		if metadata then
			local name, _, _, enabled = GetAddOnInfo(i)
			if enabled then
				lodmodules[metadata] = name
			end
		end
	end

	PT3.sets = setmetatable(PT3.sets or {}, {
		__index = function(self, key)
			local base = key:match("^([^%.]+)%.") or key
			if lodmodules[base] then
				LoadAddOn(lodmodules[base])
				lodmodules[base] = nil -- don't try to load again
				-- still may need to generate multiset or something like that, so re-call the metamethod if need be
				return self[key]
			end
			makeNonPresentMultiSet(key) -- this will store it as empty if this is an invalid set.
			return self[key]
		end
	})
end
PT3.embedversions = PT3.embedversions or {}

sets = PT3.sets
embedversions = PT3.embedversions

cache = setmetatable({}, {
	__mode = 'v', -- weaken this table's values.
	__index = function(self, key)
		-- Get the setstring in question.  This call does most of the hairy stuff
		-- like putting together implied but absent multisets and finding child sets
		local setstring = sets[key]
		if not setstring then
			return
		end
		if setstring:sub(1,2) == "m," then
			-- This table is a list of references to the members of this set.
			self[key] = {}
			local working = self[key]
			for childset in setstring:sub(3):gmatch("([^,]+)") do
				if childset ~= key then -- infinite loops is bad
					local pointer = cache[childset]
					if pointer then
						local _, firstv = next(pointer)
						if type(firstv) == "table" then
							-- This is a multiset, copy its references
							for _,v in ipairs(pointer) do
								working[#working+1] = v
							end
						elseif firstv then
							-- This is not a multiset, just stick a reference in.
							working[#working+1] = pointer
						end
					end
				end
			end
			return working
		else
			-- normal ol' set.  Well, maybe not, but close enough.
			self[key] = {}
			local working = self[key]
			for itemstring in setstring:gmatch("([^,]+)") do
				-- for each item (comma seperated)..
				-- ...check to see if we have a value set (ie "14543:1121")
				local id, value = itemstring:match("^([^:]+):(.+)$")
				-- if we don't, (ie "14421,12312"), then set the value to true.
				id, value = tonumber(id) or tonumber(itemstring), value or true
				assert(id, 'malformed set? '..key)
				working[id] = value
			end
			-- stick the set name in there so that we can find out which set an item originally came from.
			working.set = key
			return working
		end
	end
})
---------------------------------------------
--                  API                    --
---------------------------------------------
-- These three are pretty simple.  Note that non-present chunks will be generated by the metamethods.
function PT3:GetSetTable(set)
	assert(type(set) == "string", "Invalid arg1: set must be a string")
	return cache[set]
end

function PT3:GetSetString(set)
	assert(type(set) == "string", "Invalid arg1: set must be a string")
	return sets[set]
end

function PT3:IsSetMulti(set)
	assert(type(set) == "string", "Invalid arg1: set must be a string")
	-- Check if this set's a multiset by checking if its table contains tables instead of strings/booleans
	local pointer = cache[set]
	if not pointer then
		return
	end
	local _, firstv = next(pointer)
	if type(firstv) == "table" then
		return true
	else
		return false
	end
end

function PT3:IterateSet(set)
	-- most of the work here is handled by the local functions above.
	--!! this could maybe use some improvement...
	local t = cache[set]
	assert(t, "Invalid set: "..set)
	if self:IsSetMulti(set) then
		iternum, iterpos = 1, nil
		return multisetiter, t
	else
		iterpos = nil
		return setiter, t
	end
end

-- Check if the item's contained in this set or any of it's child sets.  If it is, return the value
-- (which is true for items with no value set) and the set where the item is contained in data.
function PT3:ItemInSet(item, set)
	assert(type(item) == "number" or type(item) == "string", "Invalid arg1: item must be a number or item link")
	assert(type(set) == "string", "Invalid arg2: set must be a string")
	-- Type the passed item out to an itemid.
	item = getItemID(item)
	assert(item ~= 0,"Invalid arg1: invalid item.")
	local pointer = cache[set]
	if not pointer then
		return
	end
	local _, firstv = next(pointer)
	if type(firstv) == "table" then
		-- The requested set is a multiset, iterate its children.  Return the first matching item.
		for _,v in ipairs(pointer) do
			if v[item] then
				return v[item], v.set
			end
		end
	elseif pointer[item] then
		-- Not a multiset, just return the value and set name.
		return pointer[item], pointer.set
	end
end

function PT3:AddData(arg1, arg2, arg3)
	assert(type(arg1) == "string", "Invalid arg1: name must be a string")
	assert(type(arg2) == "string" or type(arg2) == "table", "Invalid arg2: must be set contents string or table, or revision string")
	assert((arg3 and type(arg3) == "table") or not arg3, "Invalid arg3: must be a table")
	if not arg3 and type(arg2) == "string" then
		-- Just a string.
		local replacing
		if rawget(sets, arg1) then
			replacing = true
		end
		sets[arg1] = arg2
		-- Clear the cache of this set's data if it exists, avoiding invoking the metamethod.
		-- No sense generating data if we're just gonna nuke it anyway ;)
		if replacing then
			shredCache(arg1)
		end
	else
		-- Table of sets passed.
		if arg3 then
			-- Woot, version numbers and everything.
			assert(type(arg2) == "string", "Invalid arg2: must be revision string")
			local version = tonumber(arg2:match("(%d+)"))
			if embedversions[arg1] and embedversions[arg1] >= version then
				-- The loaded version is newer than this one.
				return
			end
			embedversions[arg1] = version
			for k,v in pairs(arg3) do
				-- Looks good, throw 'em in there one by one
				self:AddData(k,v)
			end
		else
			-- Boo, no version numbers.  Just overwrite all these sets.
			for k,v in pairs(arg2) do
				self:AddData(k,v)
			end
		end
	end
end

function PT3:ItemSearch(item)
	assert(type(item) == "number" or type(item) == "string", "Invalid arg1: item must be a number or item link")
	item = tonumber(item) or tonumber(item:match("item:(%d+)"))
	if item == 0 then
		self:error("Invalid arg1: invalid item.")
	end
	local matches = {}
	for k,v in pairs(self.sets) do
		local _, set = self:ItemInSet(item, k)
		if set then
			local have
			for _,v in ipairs(matches) do
				if v == set then
					have = true
				end
			end
			if not have then
				table.insert(matches, set)
			end
		end
	end
	if #matches > 0 then
		return matches
	end
end

-- ie, LibStub('PeriodicTable-3.1')('InstanceLoot') == LibStub('LibPeriodicTable-3.1'):GetSetTable('InstanceLoot')
setmetatable(PT3, { __call = PT3.GetSetTable })