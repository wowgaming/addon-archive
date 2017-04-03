QuestHelper_File["pattern.lua"] = "1.4.1"
QuestHelper_Loadtime["pattern.lua"] = GetTime()

-- The following junk is for building functions to parse strings for various locales.

local varindex, varswap = 0, {}

local function replacePattern(p)
  varindex = varindex + 1
  local b, e, i = string.find(p, "(%d-)%$")
  
  if i then
    -- String contains an index.
    p = string.sub(p, 1, b-1)..string.sub(p, e+1)
    i = tonumber(i)
  else
    -- String doesn't contains an index, assume its index is the position we found it in.
    i = varindex
  end
  
  varswap[i] = varindex
  
  if p == "d" then return "(%d+)" end
  if p == "s" then return "(.-)" end
  
  -- Only know about strings and integers. Other types are broken.
  --[[ assert(false, "Unknown pattern: %"..p) ]]
end

-- Used to cache results, so we don't produce multiple functions for the same string.
local known_patterns = {}

function QuestHelper:convertPattern(pattern)
  local result = known_patterns[pattern]
  
  if result then
    return result
  end
  
  while(table.remove(varswap)) do end
  
  varindex = 0
  
  local pat = string.format("^%s$", string.gsub(pattern, "%%(.-[%%%a])", replacePattern))
  
  if varindex == 0 then
    -- The string doesn't contain any variables.
    result = self.nop
  else
    local func =  "local function parse(input)\n"
    local linear = true
    
    for i = 1,varindex do
      if varswap[i] ~= i then
        linear = false
        break
      end
    end
    
    if linear then
      -- All the arguments are in order, we can just return them.
      func = func .. string.format("return select(3, string.find(input, %q))", pat)
    else
      -- The order has been changed, use temporary variables.
      for i = 1,varindex do
        func = func ..(i==1 and "local " or ", ")..("n"..i)
      end
      
      func = func .. string.format(" = select(3, string.find(input, %q))\n", pat)
      
      for i = 1,varindex do
        func = func ..(i==1 and "return " or ", ")..(varswap[i] and ("n"..varswap[i]) or "nil")
      end
    end
    
    func = func .. "\nend\nreturn parse\n"
    
    result = loadstring(func)()
  end
  
  known_patterns[pattern] = result
  return result
end
