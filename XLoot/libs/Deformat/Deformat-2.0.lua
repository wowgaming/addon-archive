--[[
Name: Deformat-2.0
Revision: $Rev: 49 $
Author(s): ckknight (ckknight@gmail.com)
Website: http://ckknight.wowinterface.com/
Documentation: http://wiki.wowace.com/index.php/Deformat-2.0
SVN: http://svn.wowace.com/root/trunk/Deformat/Deformat-2.0
Description: A library to deformat format strings.
Dependencies: AceLibrary
License: LGPL v2.1
]]

local MAJOR_VERSION = "Deformat-2.0"
local MINOR_VERSION = 90000 + tonumber(("$Revision: 49 $"):match("(%d+)"))


if not AceLibrary then error(MAJOR_VERSION .. " requires AceLibrary") end
if not AceLibrary:IsNewVersion(MAJOR_VERSION, MINOR_VERSION) then return end

local Deformat = {}

do
	local sequences = {
		["%d*d"] = "%%-?%%d+",
		["s"] = ".+",
		["[fg]"] = "%%-?%%d+%%.?%%d*",
		["%%%.%d[fg]"] = "%%-?%%d+%%.?%%d*",
		["c"] = ".",
	}
	local curries = {}
	
	local function donothing() end
	
	local select = select
	
	local function concat(left, right, ...)
		if not right then
			return left
		elseif select('#', ...) >= 1 then
			return concat(concat(left, right), ...)
		end
		if not left:find("%%1%$") and not right:find("%%1%$") then
			return left .. right
		elseif not right:find("%%1%$") then
			local i
			for j = 9, 1, -1 do
				if left:find("%%" .. j .. "%$") then
					i = j
					break
				end
			end
			while true do
				local first
				local firstPat
				for x, y in pairs(sequences) do
					local i = right:find("%%" .. x)
					if not first or (i and i < first) then
						first = i
						firstPat = x
					end
				end
				if not first then
					break
				end
				i = i + 1
				right = right:gsub("%%(" .. firstPat .. ")", "%%" .. i .. "$%1")
			end
			return left .. right
		elseif not left:find("%%1%$") then
			local i = 0
			while true do
				local first
				local firstPat
				for x, y in pairs(sequences) do
					local i = left:find("%%" .. x)
					if not first or (i and i < first) then
						first = i
						firstPat = x
					end
				end
				if not first then
					break
				end
				i = i + 1
				left = left:gsub("%%(" .. firstPat .. ")", "%%" .. i .. "$%1")
			end
			return concat(left, right)
		else
			local i
			for j = 9, 1, -1 do
				if left:find("%%" .. j .. "%$") then
					i = j
					break
				end
			end
			local j
			for k = 9, 1, -1 do
				if right:find("%%" .. k .. "%$") then
					j = k
					break
				end
			end
			for k = j, 1, -1 do
				right = right:gsub("%%" .. k .. "%$", "%%" .. k + i .. "%$")
			end
			return left .. right
		end
	end
	
	local function bubble(f, i, a1, ...)
		if not a1 then
			return
		end
		if f[i] then
			return tonumber(a1), bubble(f, i+1, ...)
		else
			return a1, bubble(f, i+1, ...)
		end
	end
	
	local function bubbleNum(f, o, i, ...)
		if i > select('#', ...) then
			return
		end
		if f[i] then
			return tonumber((select(o[i], ...))), bubbleNum(f, o, i+1, ...)
		else
			return (select(o[i], ...)), bubbleNum(f, o, i+1, ...)
		end
	end
	
	local function Curry(...)
		local pattern = concat(...)
		local unpattern = '^' .. pattern:gsub("([%(%)%.%*%+%-%[%]%?%^%$%%])", "%%%1") .. '$'
		local f = {}
		if not pattern:find("%%1%$") then
			local i = 0
			while true do
				local first
				local firstPat
				for x, y in pairs(sequences) do
					local i = unpattern:find("%%%%" .. x)
					if not first or (i and i < first) then
						first = i
						firstPat = x
					end
				end
				if not first then
					break
				end
				unpattern = unpattern:gsub("%%%%" .. firstPat, "(" .. sequences[firstPat] .. ")", 1)
				i = i + 1
				if firstPat == "c" or firstPat == "s" then
					f[i] = false
				else
					f[i] = true
				end
			end
			
			if i == 0 then
				return donothing
			else
				return function(text)
					return bubble(f, 1, text:match(unpattern))
				end
			end
		else
			local o = {}
			local i = 1
			while true do
				local pat
				for x, y in pairs(sequences) do
					if not pat and unpattern:find("%%%%" .. i .. "%%%$" .. x) then
						pat = x
						break
					end
				end
				if not pat then
					break
				end
				unpattern = unpattern:gsub("%%%%" .. i .. "%%%$" .. pat, "(" .. sequences[pat] .. ")", 1)
				if pat == "c" or pat  == "s" then
					f[i] = false
				else
					f[i] = true
				end
				i = i + 1
			end
			i = 1
			pattern:gsub("%%(%d)%$", function(w) o[i] = tonumber(w); i = i + 1; end)
			
			if i == 1 then
				return donothing
			else
				return function(text)
					return bubbleNum(f, o, 1, text:match(unpattern))
				end
			end
		end
	end
	
	function Deformat:Deformat(text, a1, ...)
		self:argCheck(text, 2, "string")
		self:argCheck(a1, 3, "string")
		local pattern = (''):join(a1, ...)
		if curries[pattern] == nil then
			curries[pattern] = Curry(a1, ...)
		end
		return curries[pattern](text)
	end
end

local mt = getmetatable(Deformat) or {}
mt.__call = Deformat.Deformat
setmetatable(Deformat, mt)

AceLibrary:Register(Deformat, MAJOR_VERSION, MINOR_VERSION)
Deformat = nil
