QuestHelper_File["collect_lzw.lua"] = "1.4.1"
QuestHelper_Loadtime["collect_lzw.lua"] = GetTime()

local Merger
local Bitstream

local function cleanup(tab)
  for _, v in pairs(tab) do
    QuestHelper:ReleaseTable(v)
  end
  QuestHelper:ReleaseTable(tab)
end

local function QH_LZW_Decompress(input, tokens, outbits, inputstatic)
  local d = QuestHelper:CreateTable("lzw")
  local i
  for i = 0, tokens-1 do
    d[i] = QuestHelper:CreateTable("lzw")
    d[i][0] = string.char(i)
  end
  
  local dsize = tokens + 1  -- we use the "tokens" value as an EOF marker
  
  if inputstatic then
    local used = QuestHelper:CreateTable("lzw")
    for _, v in ipairs(inputstatic) do
      for i = #v, 2, -1 do
        local subi = v:sub(1, i)
        if not used[subi] then
          used[subi] = true
          
          d[bit.mod(dsize, tokens)][math.floor(dsize / tokens)] = subi
          dsize = dsize + 1
        else
          break
        end
      end
    end
    QuestHelper:ReleaseTable(used)
  end
  
  local bits = 1
  local nextbits = 2
  
  while nextbits < dsize do bits = bits + 1; nextbits = nextbits * 2 end
  
  local i = Bitstream.Input(input, outbits)
  local rv = {}
  
  local idlect = 0
  
  local tok = i:depend(bits)
  if tok == tokens then cleanup(d) return "" end -- Okay. There's nothing. We get it.
  
  Merger.Add(rv, d[bit.mod(tok, tokens)][math.floor(tok / tokens)])
  local w = d[bit.mod(tok, tokens)][math.floor(tok / tokens)]
  while true do
    if idlect == 25 then
      QH_Timeslice_Yield()
      idlect = 0
    else
      idlect = idlect + 1
    end
    
    dsize = dsize + 1 -- We haven't actually added the next element yet. However, we could in theory include it in the stream, so we need to adjust the number of bits properly.
    if dsize > nextbits then
      bits = bits + 1
      nextbits = nextbits * 2
    end
    
    tok = i:depend(bits)
    if tok == tokens then break end -- we're done!
    
    local entry
    if d[bit.mod(tok, tokens)][math.floor(tok / tokens)] then
      entry = d[bit.mod(tok, tokens)][math.floor(tok / tokens)]
    elseif tok == dsize - 1 then
      entry = w .. w:sub(1, 1)
    else
      QuestHelper: Assert(false, "faaaail")
    end
    Merger.Add(rv, entry)
    
    d[bit.mod(dsize - 1, tokens)][math.floor((dsize - 1) / tokens)] = w .. entry:sub(1, 1) -- Naturally, we're writing to one *less* than dsize, since we already incremented.
    
    w = entry
  end
  
  cleanup(d)
  
  return Merger.Finish(rv)
end

local function QH_LZW_Compress(input, tokens, outbits, inputstatic)
  -- shared init code
  local d = {}
  local i
  for i = 0, tokens-1 do
    d[string.char(i)] = {[""] = i}
  end
  
  local dsize = tokens + 1  -- we use the "tokens" value as an EOF marker
  
  if inputstatic then
    for _, v in ipairs(inputstatic) do
      local da = d[v:sub(1, 1)]
      for i = #v, 2, -1 do
        local b = v:sub(2, i)
        if not da[b] then
          da[b] = dsize
          dsize = dsize + 1
        else
          break
        end
      end
    end
  end
  
  local bits = 1
  local nextbits = 2
  
  while nextbits < dsize do bits = bits + 1; nextbits = nextbits * 2 end
  
  local r = Bitstream.Output(outbits)
  
  local idlect = 0
  
  local w = ""
  for ci = 1, #input do
    if idlect == 100 then
      QH_Timeslice_Yield()
      idlect = 0
    else
      idlect = idlect + 1
    end
    
    local c = input:sub(ci, ci)
    local wcp = w .. c
    if d[wcp:sub(1, 1)][wcp:sub(2)] then
      w = wcp
    else
      r:append(d[w:sub(1, 1)][w:sub(2)], bits)
      d[wcp:sub(1, 1)][wcp:sub(2)] = dsize
      dsize = dsize + 1
      if dsize > nextbits then
        bits = bits + 1
        nextbits = nextbits * 2
      end
      w = c
    end
  end
  
  if w ~= "" then
    r:append(d[w:sub(1, 1)][w:sub(2)], bits)
  
    dsize = dsize + 1   -- Our decompressor doesn't realize we're ending here, so it will have added a table entry for that last token. Sigh.
    if dsize > nextbits then
      bits = bits + 1
      nextbits = nextbits * 2
    end
  end
  
  r:append(tokens, bits)
  
  local rst = r:finish()
  QuestHelper: Assert(QH_LZW_Decompress(rst, tokens, outbits, inputstatic) == input) -- yay
  
  return rst
end

local function mdict(inputdict)
  local idc = QuestHelper:CreateTable("lzw mdict")
  for i = 1, #inputdict do if math.fmod(i, 100) == 0 then QH_Timeslice_Yield() end idc[inputdict:sub(i, i)] = strchar(i - 1) end
  return idc
end

local function dictize(idcl, stt)
  local im = QuestHelper:CreateTable("lzw dictize")
  for i = 1, #stt do
    local subl = idcl[stt:sub(i, i)]
    QuestHelper: Assert(subl)
    Merger.Add(im, subl)
  end
  local result = Merger.Finish(im)
  QuestHelper:ReleaseTable(im)
  return result
end

local function QH_LZW_Prepare(inputdict, inputstatic)
  QuestHelper: Assert(inputdict and inputstatic)
  
  local idc = mdict(inputdict)
  
  local inpstat = {}
  local ct = 0
  for _, v in ipairs(inputstatic) do
    ct = ct + 1
    if ct == 10 then QH_Timeslice_Yield() ct = 0 end
    table.insert(inpstat, dictize(idc, v))
  end
  
  return idc, #inputdict, inpstat
end

local function QH_LZW_Compress_Dicts_Prepared(input, idprepped, idpreppedsize, outputdict, isprepped)
  input = dictize(idprepped, input)
  
  local bits, dsize = 1, 2
  if not outputdict then bits = 8 else while dsize < #outputdict do bits = bits + 1 ; dsize = dsize * 2 end end
  QuestHelper: Assert(not outputdict or #outputdict == dsize)
  
  local comp = QH_LZW_Compress(input, idpreppedsize, bits, isprepped)
  
  if outputdict then
    local origcomp = comp
    local im = {}
    for i = 1, #origcomp do Merger.Add(im, outputdict:sub(strbyte(origcomp:sub(i, i)) + 1)) end
    comp = Merger.Finish(im)
  end
  
  return comp
end

local function QH_LZW_Compress_Dicts(input, inputdict, outputdict, inputstatic)
  local inproc = input
  local inpstat = inputstatic
  if inputdict then
    local idc = mdict(inputdict)
    
    inproc = dictize(idc, input)
    
    if inputstatic then
      inpstat = {}
      for _, v in ipairs(inputstatic) do
        table.insert(inpstat, dictize(idc, v))
      end
    end
    
    QuestHelper:ReleaseTable(idc)
  end
  
  local bits, dsize = 1, 2
  if not outputdict then bits = 8 else while dsize < #outputdict do bits = bits + 1 ; dsize = dsize * 2 end end
  QuestHelper: Assert(not outputdict or #outputdict == dsize)
  
  local comp = QH_LZW_Compress(inproc, inputdict and #inputdict or 256, bits, inpstat)
  
  if outputdict then
    local origcomp = comp
    local im = {}
    for i = 1, #origcomp do Merger.Add(im, outputdict:sub(strbyte(origcomp:sub(i, i)) + 1)) end
    comp = Merger.Finish(im)
  end
  
  return comp
end

local function QH_LZW_Decompress_Dicts_Prepared(compressed, inputdict, outputdict, ispreppred) -- this is kind of backwards - we assume that "outputdict" is the dictionary that "compressed" is encoded in
  QuestHelper: Assert(not outputdict)
  QuestHelper: Assert(inputdict)
  
  local decomp = QH_LZW_Decompress(compressed, #inputdict, 8, ispreppred)
  
  local ov = {}
  for i = 1, #decomp do
    Merger.Add(ov, inputdict:sub(decomp:byte(i) + 1, decomp:byte(i) + 1))
  end
  return Merger.Finish(ov)
end

local function QH_LZW_Decompress_Dicts(compressed, inputdict, outputdict, inputstatic) -- this is kind of backwards - we assume that "outputdict" is the dictionary that "compressed" is encoded in
  QuestHelper: Assert(not outputdict)
  QuestHelper: Assert(inputdict)
  
  local inpstat = inputstatic
  if inputdict and inputstatic then
    local idc = mdict(inputdict)
  
    inpstat = {}
    for _, v in ipairs(inputstatic) do
      table.insert(inpstat, dictize(idc, v))
    end
    
    QuestHelper:ReleaseTable(idc)
  end
  
  local decomp = QH_LZW_Decompress(compressed, #inputdict, 8, inpstat)
  
  local ov = {}
  for i = 1, #decomp do
    Merger.Add(ov, inputdict:sub(decomp:byte(i) + 1, decomp:byte(i) + 1))
  end
  return Merger.Finish(ov)
end

QH_LZW_Prepare_Arghhacky = QH_LZW_Prepare -- need to rig up a better mechanism for this really
QH_LZW_Decompress_Dicts_Arghhacky = QH_LZW_Decompress_Dicts -- need to rig up a better mechanism for this really
QH_LZW_Decompress_Dicts_Prepared_Arghhacky = QH_LZW_Decompress_Dicts_Prepared -- need to rig up a better mechanism for this really

function QH_Collect_LZW_Init(_, API)
  Merger = API.Utility_Merger
  QuestHelper: Assert(Merger)
  
  Bitstream = API.Utility_Bitstream
  QuestHelper: Assert(Bitstream)
  
  API.Utility_LZW = {Compress = QH_LZW_Compress, Decompress = QH_LZW_Decompress, Compress_Dicts = QH_LZW_Compress_Dicts, Decompress_Dicts = QH_LZW_Decompress_Dicts, Prepare = QH_LZW_Prepare, Compress_Dicts_Prepared = QH_LZW_Compress_Dicts_Prepared, Decompress_Dicts_Prepared = QH_LZW_Decompress_Dicts_Prepared}
end

-- old debug code :)
  
--[[  
print("hello")

QH_LZW_Compress("TOBEORNOTTOBEORTOBEORNOT", 256, 8)
]]

--[[
QuestHelper:TextOut("lulz")

local inq = "ABABABABA"
local alpha = 253
local bits = 7

str = QH_LZW_Compress(inq, alpha, bits)
tvr = ""
for i = 1, #str do
  tvr = tvr .. string.format("%d ", strbyte(str, i))
end
QuestHelper:TextOut(tvr)

ret = QH_LZW_Decompress(str, alpha, bits)
QuestHelper:TextOut(ret)

QuestHelper: Assert(inq == ret)
]]
