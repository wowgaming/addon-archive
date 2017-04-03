QuestHelper_File["db_get.lua"] = "1.4.1"
QuestHelper_Loadtime["db_get.lua"] = GetTime()

local dev_mode = (QuestHelper_File["db_get.lua"] == "Development Version")

-- yoink
--[[
local QHDB_temp = QHDB
QHDB = nil
local QHDB = QHDB_temp]]
QuestHelper: Assert(dev_mode or #QHDB == 4)

local weak_v = { __mode = 'v' }
local weak_k = { __mode = 'k' }

local cache = {}

local frequencies = setmetatable({}, weak_k)

-- guhhh just want this to work
local freq_group = setmetatable({}, weak_k)
local freq_id = setmetatable({}, weak_k)

local function DBC_Get(group, id)
  if not cache[group] then return end
  return cache[group][id]
end

local function DBC_Put(group, id, item)
  if not cache[group] then cache[group] = setmetatable({}, weak_v) end
  QuestHelper: Assert(not cache[group][id])
  cache[group][id] = item
  
  --DB_how_many_are_used()
end

local function mark(tab, tomark)
  for k, v in pairs(tab) do
    if k ~= "__owner" and type(v) == "table" then
      mark(v, tomark)
    end
  end
  tab.__owner = tomark
end

local function read_adaptint(data, offset)
  local stx = 0
  local acu = 1
  while true do
    local v = strbyte(data, offset)
    QuestHelper: Assert(v, string.format("%d %d", #data, offset))
    stx = stx + acu * math.floor(v / 2)
    offset = offset + 1
    acu = acu * 128
    if mod(v, 2) == 0 then break end
  end
  return stx, offset
end

local function search_index(index, data, item)
  --[[Header format:

    Itemid (0 for endnode)
    Offset
    Length
    Rightlink]]
  
  local cofs = 1
  --[[ assert(index and type(index) == "string") ]]
  --[[ assert(data and type(data) == "string") ]]
  
  while true do
    local idx, ofs, len, rlink
    idx, cofs = read_adaptint(index, cofs)
    if idx == 0 then return end
    ofs, cofs = read_adaptint(index, cofs)
    len, cofs = read_adaptint(index, cofs)
    rlink, cofs = read_adaptint(index, cofs)
    
    if idx == item then
      return strsub(data, ofs, ofs + len)
    end
    
    if idx < item then cofs = cofs + rlink end
  end
end

local initted = false
function DB_Init()
  QuestHelper: Assert(not initted)
  for _, db in ipairs(QHDB) do
    for _, v in pairs(db) do
      --print("db", not not v.__dictionary, not not v.__tokens)
      if v.__dictionary and v.__tokens then
        local redictix = v.__dictionary
        if not redictix:find("\"") then redictix = redictix .. "\"" end
        if not redictix:find(",") then redictix = redictix .. "," end
        if not redictix:find("\\") then redictix = redictix .. "\\" end
        local tokens = loadstring("return {" .. QH_LZW_Decompress_Dicts_Arghhacky(v.__tokens, redictix) .. "}")()
        QuestHelper: Assert(tokens)
        
        local _, _, prep = QH_LZW_Prepare_Arghhacky(v.__dictionary, tokens)
        QuestHelper: Assert(prep)
        
        QuestHelper: Assert(type(prep) == "table")
        
        v.__tokens = prep
      end
    end
  end
  initted = true
  QH_UpdateQuests() -- just in case it's been waiting on us (it has almost certainly been waiting on us)
end

function DB_Ready()
  return initted
end

function DB_HasItem(group, id)
  QuestHelper: Assert(initted)
  
  for _, db in ipairs(QHDB) do
    if db[group] then
      if db[group][id] then
        return true
      end
      
      if type(id) == "number" and id > 0 and db[group].__serialize_index and db[group].__serialize_data and search_index(db[group].__serialize_index, db[group].__serialize_data, id) then
        return true
      end
    end
  end
  
  return false
end

function DB_GetItem(group, id, silent, register)
  QuestHelper: Assert(initted)

  QuestHelper: Assert(group, string.format("%s %s", tostring(group), tostring(id)))
  QuestHelper: Assert(id, string.format("%s %s", tostring(group), tostring(id)))
  local ite = DBC_Get(group, id)
  
  if not ite then
    if type(id) == "string" then QuestHelper: Assert(not id:match("__.*")) end
    
    --QuestHelper:TextOut(string.format("%s %d", group, id))
    
    for _, db in ipairs(QHDB) do
      --print(db, db[group], db[group] and db[group][id], type(group), type(id))
      if db[group] then
        local dat
        if db[group][id] then
          dat = db[group][id]
        end
        
        --print(not dat, type(id), id, not not db[group].__serialize_index, not not db[group].__serialize_index)
        if not dat and type(id) == "number" and id > 0 and db[group].__serialize_index and db[group].__serialize_data then
          dat = search_index(db[group].__serialize_index, db[group].__serialize_data, id)
        end
        
        if dat then
          if not ite then ite = QuestHelper:CreateTable("db") end
          
          local srctab
          
          if type(dat) == "string" then
            QuestHelper: Assert(db[group].__tokens == nil or type(db[group].__tokens) == "table")
            srctab = loadstring("return {" .. (db[group].__prefix or "") .. QH_LZW_Decompress_Dicts_Prepared_Arghhacky(dat, db[group].__dictionary, nil, db[group].__tokens) .. (db[group].__suffix or "") .. "}")()
          elseif type(dat) == "table" then
            srctab = dat
          else
            QuestHelper: Assert()
          end
          
          for k, v in pairs(srctab) do
            QuestHelper: Assert(not ite[k] or k == "used")
            ite[k] = v
          end
        end
      end
    end
    
    if ite then
      --print("marking", group, id, silent, register)
      mark(ite, ite)
      --print("done marking")
      
      DBC_Put(group, id, ite)
      
      freq_group[ite] = group
      freq_id[ite] = id
    else
      if not silent then
        QuestHelper:TextOut(string.format("Tried to get %s/%s, failed", tostring(group), tostring(id)))
      end
    end
  end
  
  if ite then
    frequencies[ite] = (frequencies[ite] or 0) + (register and 1 or 1000000000) -- effectively infinity
  end
  
  return ite
end

local function incinerate(ite, crunchy)
  if dev_mode then return end -- wellllp
  
  if not crunchy[ite] then
    crunchy[ite] = true
    
    for k, v in pairs(ite) do
      if type(k) == "table" then incinerate(k, crunchy) end
      if type(v) == "table" then incinerate(v, crunchy) end
    end
  end
end

function DB_ReleaseItem(ite)
  QuestHelper: Assert(ite)
  frequencies[ite] = frequencies[ite] - 1
  
  if frequencies[ite] == 0 then
    --print("incinerating", freq_group[ite], freq_id[ite])
    cache[freq_group[ite]][freq_id[ite]] = nil
    freq_group[ite] = nil
    freq_id[ite] = nil
    
    local incin = QuestHelper:CreateTable("incinerate")
    incinerate(ite, incin)
    for k, _ in pairs(incin) do
      QuestHelper:ReleaseTable(k)
    end -- burn baby burn
    QuestHelper:ReleaseTable(incin)
  end
end

function DB_ListItems(group)
  local tab = {}
  for _, db in ipairs(QHDB) do
    if db[group] then
      QuestHelper: Assert(not db.__serialize_index and not db.__serialize_data)
      for k, _ in pairs(db[group]) do
        if type(k) ~= "string" or not k:match("__.*") then
          tab[k] = true
        end
      end
    end
  end
  
  local rv = {}
  for k, _ in pairs(tab) do
    table.insert(rv, k)
  end
  
  return rv
end

function DB_how_many_are_used()
  local count = 0
  for k, v in pairs(cache) do
    for k2, v2 in pairs(v) do
      count = count + 1
    end
  end
  print(count)
end

function DB_DumpItems()
  local dt = {}
  for k, v in pairs(freq_group) do
    dt[string.format("%s/%s", freq_group[k], tostring(freq_id[k]))] = true
  end
  return dt
end
