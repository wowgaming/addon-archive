
--[[ BEGIN STANDARD HEADER ]]--

-- Imports
local _G = _G
local LibStub = LibStub
local tostring = tostring
local select = select
local type = type
local getmetatable, setmetatable = getmetatable, setmetatable
local rawget = rawget
local next, pairs, ipairs = next, pairs, ipairs
local SVC_NAMESPACE = SVC_NAMESPACE
local pcall = pcall
local string, table = string, table
local GetTime = GetTime


function SVC_NAMESPACE.PrintSlashCommand(text)
	text = text:trim():match("^(.-);*$")
    
    Prat.Print(">> print(|cffaaaaff" .. text .. "|r)")
    
    text = "print(" .. text .. ")"

	local f, err = loadstring(text)
	if not f then
		Prat.Print("|cffff0000Error:|r", err)
	else
		f()
	end
end

SLASH_PRINT1 = "/print"
SlashCmdList["PRINT"] = function(msg) SVC_NAMESPACE.PrintSlashCommand(msg) end


-- Isolate the environment
setfenv(1, SVC_NAMESPACE)

--[[ END STANDARD HEADER ]]--

TABLE_PRINT_TIMEOUT = 0.2


--[[ from AceConsole-3.0 ]]--
function Print(...)
	local text = "|cffffff78" .. tostring(self or SVC_NAMESPACE) .. ":|r "
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
	(frame or _G.DEFAULT_CHAT_FRAME):AddMessage( text )
end


local function print(text, name, r, g, b, frame, delay)
	if not text or text:len() == 0 then
		text = " "
	end
	if not name then
	else
		text = "|cffffff78" .. tostring(name) .. ":|r " .. text
	end
	local last_color
	for t in text:gmatch("[^\n]+") do
		(frame or _G.DEFAULT_CHAT_FRAME):AddMessage(last_color and "|cff" .. last_color .. t or t, r, g, b, nil, delay or 5)
		if not last_color or t:find("|r") or t:find("|c") then
			last_color = t:match(".*|c[fF][fF](%x%x%x%x%x%x)[^|]-$")
		end
	end
	return text
end

local real_tostring = tostring

local function tostring(t)
	if type(t) == "table" then
		if type(rawget(t, 0)) == "userdata" and type(t.GetObjectType) == "function" then
			return ("<%s:%s>"):format(t:GetObjectType(), t:GetName() or "(anon)")
		end
	end
	return real_tostring(t)
end

local getkeystring

local function isList(t)
	local n = #t
	for k,v in pairs(t) do
		if type(k) ~= "number" then
			return false
		elseif k < 1 or k > n then
			return false
		end
	end
	return true
end

local findGlobal = setmetatable({}, {__index=function(self, t)
	for k,v in pairs(_G) do
		if v == t then
			k = tostring(k)
			self[v] = k
			return k
		end
	end
	self[t] = false
	return false
end})

local recurse = {}
local timeToEnd
local GetTime = GetTime
local type = type

local new, del
do
	local cache = setmetatable({},{__mode='k'})
	function new()
		local t = next(cache)
		if t then
			cache[t] = nil
			return t
		else
			return {}
		end
	end

	function del(t)
		for k in pairs(t) do
			t[k] = nil
		end
		cache[t] = true
		return nil
	end
end

local function ignoreCaseSort(alpha, bravo)
	if not alpha or not bravo then
		return false
	end
	return tostring(alpha):lower() < tostring(bravo):lower()
end

local function specialSort(alpha, bravo)
	if alpha == nil or bravo == nil then
		return false
	end
	local type_alpha, type_bravo = type(alpha), type(bravo)
	if type_alpha ~= type_bravo then
		return type_alpha < type_bravo
	end
	if type_alpha == "string" then
		return alpha:lower() < bravo:lower()
	elseif type_alpha == "number" then
		return alpha < bravo
	elseif type_alpha == "table" then
		return #alpha < #bravo
	elseif type_alpha == "boolean" then
		return not alpha
	else
		return false
	end
end

local function escapeChar(c)
    return ("\\%03d"):format(c:byte())
end



--[[ from AceConsole 2.0 ]]--
local function literal_tostring_prime(t, depth)
	if type(t) == "string" then
		return ("|cff00ff00%q|r"):format((t:gsub("|", "||"))):gsub("[%z\001-\009\011-\031\127-\255]", escapeChar)
	elseif type(t) == "table" then
		if t == _G then
			return "|cffffea00_G|r"
		end
		if type(rawget(t, 0)) == "userdata" and type(t.GetObjectType) == "function" then
			return ("|cffffea00<%s:%s>|r"):format(t:GetObjectType(), t:GetName() or "(anon)")
		end
		if next(t) == nil then
			local mt = getmetatable(t)
			if type(mt) == "table" and type(mt.__raw) == "table" then
				t = mt.__raw
			end
		end
		if recurse[t] then
			local g = findGlobal[t]
			if g then
				return ("|cff9f9f9f<Recursion _G[%q]>|r"):format(g)
			else
				return ("|cff9f9f9f<Recursion %s>|r"):format(real_tostring(t):gsub("|", "||"))
			end
		elseif GetTime() > timeToEnd then
			local g = findGlobal[t]
			if g then
				return ("|cff9f9f9f<Timeout _G[%q]>|r"):format(g)
			else
				return ("|cff9f9f9f<Timeout %s>|r"):format(real_tostring(t):gsub("|", "||"))
			end
		elseif depth >= 2 then
			local g = findGlobal[t]
			if g then
				return ("|cff9f9f9f<_G[%q]>|r"):format(g)
			else
				return ("|cff9f9f9f<%s>|r"):format(real_tostring(t):gsub("|", "||"))
			end
		end
		recurse[t] = true
		if next(t) == nil then
			return "{}"
		elseif next(t, (next(t))) == nil then
			local k, v = next(t)
			if k == 1 then
				return "{ " .. literal_tostring_prime(v, depth+1) .. " }"
			else
				return "{ " .. getkeystring(k, depth+1) .. " = " .. literal_tostring_prime(v, depth+1) .. " }"
			end
		end
		local s
		local g = findGlobal[t]
		if g then
			s = ("{ |cff9f9f9f-- _G[%q]|r\n"):format(g)
		else
			s = "{ |cff9f9f9f-- " .. real_tostring(t):gsub("|", "||") .. "|r\n"
		end
		if isList(t) then
			for i = 1, #t do
				s = s .. ("    "):rep(depth+1) .. literal_tostring_prime(t[i], depth+1) .. (i == #t and "\n" or ",\n")
			end
		else
			local tmp = new()
			for k in pairs(t) do
				tmp[#tmp+1] = k
			end
			table.sort(tmp, specialSort)
			for i,k in ipairs(tmp) do
				tmp[i] = nil
				local v = t[k]
				s = s .. ("    "):rep(depth+1) .. getkeystring(k, depth+1) .. " = " .. literal_tostring_prime(v, depth+1) .. (tmp[i+1] == nil and "\n" or ",\n")
			end
			tmp = del(tmp)
		end
		if g then
			s = s .. ("    "):rep(depth) .. string.format("} |cff9f9f9f-- _G[%q]|r", g)
		else
			s = s .. ("    "):rep(depth) .. "} |cff9f9f9f-- " .. real_tostring(t):gsub("|", "||")
		end
		return s
	end
	if type(t) == "number" then
		return "|cffff7fff" .. real_tostring(t) .. "|r"
	elseif type(t) == "boolean" then
		return "|cffff9100" .. real_tostring(t) .. "|r"
	elseif t == nil then
		return "|cffff7f7f" .. real_tostring(t) .. "|r"
	else
		return "|cffffea00" .. real_tostring(t) .. "|r"
	end
end

function getkeystring(t, depth)
	if type(t) == "string" then
		if t:find("^[%a_][%a%d_]*$") then
			return "|cff7fd5ff" .. t .. "|r"
		end
	end
	return "[" .. literal_tostring_prime(t, depth) .. "]"
end

local get_stringed_args
do
	local function g(value, ...)
		if select('#', ...) == 0 then
			return literal_tostring_prime(value, 1)
		end
		return literal_tostring_prime(value, 1) .. ", " .. g(...)
	end

	local function f(success, ...)
		if not success then
			return
		end
		return g(...)
	end

	function get_stringed_args(func, ...)
		return f(pcall(func, ...))
	end
end     

local function literal_tostring_frame(t)
	local s = ("|cffffea00<%s:%s|r\n"):format(t:GetObjectType(), t:GetName() or "(anon)")
	local __index = getmetatable(t).__index
	local tmp, tmp2, tmp3 = new(), new(), new()
	for k in pairs(t) do
		if k ~= 0 then
			tmp3[k] = true
			tmp2[k] = true
		end
	end
	for k in pairs(__index) do
		tmp2[k] = true
	end
	for k in pairs(tmp2) do
		tmp[#tmp+1] = k
		tmp2[k] = nil
	end
	table.sort(tmp, ignoreCaseSort)
	local first = true
	for i,k in ipairs(tmp) do
		local v = t[k]
		local good = true
		if k == "GetPoint" then
			for i = 1, t:GetNumPoints() do
				if not first then
					s = s .. ",\n"
				else
					first = false
				end
				s = s .. "    " .. getkeystring(k, 1) .. "(" .. literal_tostring_prime(i, 1) .. ") => " .. get_stringed_args(v, t, i)
			end
		elseif type(v) == "function" and type(k) == "string" and (k:find("^Is") or k:find("^Get") or k:find("^Can")) then
			local q = get_stringed_args(v, t)
			if q then
				if not first then
					s = s .. ",\n"
				else
					first = false
				end
				s = s .. "    " .. getkeystring(k, 1) .. "() => " .. q
			end
		elseif type(v) ~= "function" or (type(v) == "function" and type(k) == "string" and tmp3[k]) then
			if not first then
				s = s .. ",\n"
			else
				first = false
			end
			s = s .. "    " .. getkeystring(k, 1) .. " = " .. literal_tostring_prime(v, 1)
		else
			good = false
		end
	end
	tmp, tmp2, tmp3 = del(tmp), del(tmp2), del(tmp3)
	s = s .. "\n|cffffea00>|r"
	return s
end



local function literal_tostring(t, only)
	timeToEnd = GetTime() + TABLE_PRINT_TIMEOUT
	local s
	if only and type(t) == "table" and type(rawget(t, 0)) == "userdata" and type(t.GetObjectType) == "function" then
		s = literal_tostring_frame(t)
	else
		s = literal_tostring_prime(t, 0)
	end
	for k,v in pairs(recurse) do
		recurse[k] = nil
	end
	for k,v in pairs(findGlobal) do
		findGlobal[k] = nil
	end
	return s
end

local function tostring_args(a1, ...)
	if select('#', ...) < 1 then
		return tostring(a1)
	end
	return tostring(a1), tostring_args(...)
end

local function literal_tostring_args(a1, ...)
	if select('#', ...) < 1 then
		return literal_tostring(a1)
	end
	return literal_tostring(a1), literal_tostring_args(...)
end

function CustomPrint(self, r, g, b, frame, delay, connector, a1, ...)
	if connector == true then
		local s
		if select('#', ...) == 0 then
			s = literal_tostring(a1, true)
		else
			s = (", "):join(literal_tostring_args(a1, ...))
		end
		return print(s, self, r, g, b, frame or self.printFrame, delay)
	elseif tostring(a1):find("%%") and select('#', ...) >= 1 then
		local success, text = pcall(string.format, tostring_args(a1, ...))
		if success then
			return print(text, self, r, g, b, frame or self.printFrame, delay)
		end
	end
	return print((connector or " "):join(tostring_args(a1, ...)), self, r, g, b, frame or self.printFrame, delay)
end

function PrintLiteralFrame(self, frame, ...)
    return CustomPrint(self or SVC_NAMESPACE, nil, nil, nil, frame, nil, true, ...)
end

function PrintLiteral(self, ...)
    return CustomPrint(self or SVC_NAMESPACE, nil, nil, nil, nil, nil, true, ...)
end

function _G.print(...) PrintLiteral(SVC_NAMESPACE, ...) end
function _G.fprint(frame, ...) PrintLiteralFrame(SVC_NAMESPACE, frame, ...) end

function AddPrintMethod(_, frame) 
    function frame:print(...) 
        _G.fprint(self, ...)
    end

    frame.dbg = frame.print
end

for i=1, _G.NUM_CHAT_WINDOWS do
    AddPrintMethod(SVC_NAMESPACE, _G["ChatFrame"..i])
end
