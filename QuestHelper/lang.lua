QuestHelper_File["lang.lua"] = "1.4.1"
QuestHelper_Loadtime["lang.lua"] = GetTime()

-- These tables will be filled in later by their specific files.
QuestHelper_SubstituteFonts = {}
QuestHelper_Translations = {}
QuestHelper_ForcedTranslations = {}
QuestHelper_TranslationFunctions = {}

local empty_table = {}

local trans_table, trans_table_force, trans_func, trans_func_fb

-- Sets the locale used by QuestHelper. It needn't match the game's locale.
function QHFormatSetLocale(loc)
  trans_table_force = QuestHelper_ForcedTranslations[GetLocale()] or empty_table
  trans_table_fb = QuestHelper_Translations["enUS"] or empty_table
  trans_table = QuestHelper_Translations[loc] or trans_table_fb
  trans_func_fb = QuestHelper_TranslationFunctions["enUS"] or empty_table
  trans_func = QuestHelper_TranslationFunctions[loc] or trans_func_fb
end

local sub_array = nil
local function doSub(op, index)
  if op == "" and index == "" then return "%" end
  local i = tonumber(index)
  if i then
    -- Pass the selected argument through a function and insert the result.
    return (trans_func[op] or trans_func_fb[op] or QuestHelper.nop)(sub_array[i] or "") or "[???]"
  end
  return op..index
end

local next_free = 1

local doTranslation = nil

local function doNest(op, text)
  next_free = next_free + 1
  sub_array[next_free] = doTranslation(string.sub(text, 2, -2))
  return string.format("%%%s%d", op, next_free)
end

doTranslation = function(text)
  local old_next_free = next_free
  text = string.gsub(string.gsub(text, "%%(%a*)(%b())", doNest), "%%(%a*)(%d*)", doSub)
  next_free = old_next_free
  return text
end

function QHFormatArray(text, array)
  if not trans_table then
    QHFormatSetLocale(GetLocale())
  end
  
  local old_array = sub_array -- Remember old value, so we can restore it incase this was called recursively.
  sub_array = array
  
  local old_next_free = next_free
  next_free = #array
  
  local trans = trans_table_force[text]  or trans_table[text]
  
  while type(trans) ~= "string" do
    -- The translation doesn't need to be a string, it can be a function which returns a string,
    -- or an array of strings and functions, of which one will be selected randomly.
    if type(trans) == "function" then
      trans = trans(text, array)
    elseif type(trans) == "table" and #trans > 0 then
      trans = trans[math.random(1, #trans)]
    else
      trans = trans_table_fb[text]
      
      while type(trans) ~= "string" do
        if type(trans) == "function" then
          trans = trans(text, array)
        elseif type(trans) == "table" and #trans > 0 then
          trans = trans[math.random(1, #trans)]
        else
          trans = "???"
        end
      end
      
      -- Uncomment this to have missing translations marked in text.
      --trans = string.format("|cffff0000[%s|||r%s|cffff0000]|r", text, trans)
    end
  end
  
  text = doTranslation(trans)
  
  sub_array = old_array
  next_free = old_next_free
  
  return text
end

local arguments = {}

function QHFormat(text, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12)
  -- This isn't a vardiac function, because that would create a table to store the arguments in, and I'm trying to avoid
  -- creating any garbage here, by reusing the same table for the arguments. Although I'll admit that this isn't nearly
  -- as effecient. Or pretty. Or stable. Let the foot shooting begin.
  
  arguments[1] = a1   arguments[2]  =  a2   arguments[3]  =  a3   arguments[4]  =  a4
  arguments[5] = a5   arguments[6]  =  a6   arguments[7]  =  a7   arguments[8]  =  a8
  arguments[9] = a9   arguments[10] = a10   arguments[11] = a11   arguments[12] = a12
  
  return QHFormatArray(text, arguments)
end

-- Translates a string, without any substitutions.
function QHText(text)
  return QHFormatArray(text, empty_table)
end
