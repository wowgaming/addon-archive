_G.PitBull4_DEBUG = true

local function is_list(t)
	local n = #t
	
	for k in pairs(t) do
		if type(k) ~= "number" or k < 1 or k > n or math.floor(k) ~= k then
			return false
		end
	end
	return true
end

local function simple_pretty_tostring(value)
	if type(value) == "string" then
		return ("%q"):format(value)
	else
		return tostring(value)
	end
end

local function pretty_tostring(value)
	if type(value) ~= "table" then
		return simple_pretty_tostring(value)
	end
	
	local t = {}
	if is_list(value) then
		for _, v in ipairs(value) do
			t[#t+1] = simple_pretty_tostring(v)
		end
	else
		for k, v in pairs(value) do
			t[#t+1] = "[" .. simple_pretty_tostring(k) .. "] = " .. simple_pretty_tostring(v)
		end
	end	
	return "{" .. table.concat(t, ", ") .. "}"
end

local conditions = {}
local function helper(alpha, ...)
	for i = 1, select('#', ...) do
		if alpha == select(i, ...) then
			return true
		end
	end
	return false
end
conditions['inset'] = function(alpha, bravo)
	if type(bravo) == "table" then
		return bravo[alpha] ~= nil
	elseif type(bravo) == "string" then
		return helper(alpha, (";"):split(bravo))
	else
		error(("Bad argument #3 to `expect'. Expected %q or %q, got %q"):format("table", "string", type(bravo)))
	end
end
conditions['typeof'] = function(alpha, bravo)
	local type_alpha = type(alpha)
	if type_alpha == "table" and type(rawget(alpha, 0)) == "userdata" and type(alpha.IsObjectType) == "function" then
		type_alpha = 'frame'
	end
	return conditions['inset'](type_alpha, bravo)
end
conditions['frametype'] = function(alpha, bravo)
	if type(bravo) ~= "string" then
		error(("Bad argument #3 to `expect'. Expected %q, got %q"):format("string", type(bravo)), 3)
	end
	return type(alpha) == "table" and type(rawget(alpha, 0)) == "userdata" and type(alpha.IsObjectType) == "function" and alpha:IsObjectType(bravo)
end
conditions['match'] = function(alpha, bravo)
	if type(alpha) ~= "string" then
		error(("Bad argument #1 to `expect'. Expected %q, got %q"):format("string", type(alpha)), 3)
	end
	if type(bravo) ~= "string" then
		error(("Bad argument #3 to `expect'. Expected %q, got %q"):format("string", type(bravo)), 3)
	end
	return alpha:match(bravo)
end
conditions['=='] = function(alpha, bravo)
	return alpha == bravo
end
conditions['~='] = function(alpha, bravo)
	return alpha ~= bravo
end
conditions['>'] = function(alpha, bravo)
	return type(alpha) == type(bravo) and alpha > bravo
end
conditions['>='] = function(alpha, bravo)
	return type(alpha) == type(bravo) and alpha >= bravo
end
conditions['<'] = function(alpha, bravo)
	return type(alpha) == type(bravo) and alpha < bravo
end
conditions['<='] = function(alpha, bravo)
	return type(alpha) == type(bravo) and alpha <= bravo
end

local t = {}
for k, v in pairs(conditions) do
	t[#t+1] = k
end
for _, k in ipairs(t) do
	conditions["not_" .. k] = function(alpha, bravo)
		return not conditions[k](alpha, bravo)
	end
end

function _G.PitBull4_expect(alpha, condition, bravo)
	if not conditions[condition] then
		error(("Unknown condition %s"):format(pretty_tostring(condition)), 2)
	end
	if not conditions[condition](alpha, bravo) then
		error(("Expectation failed: %s %s %s"):format(pretty_tostring(alpha), condition, pretty_tostring(bravo)), 2)
	end
end
