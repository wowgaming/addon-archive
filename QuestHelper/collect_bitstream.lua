QuestHelper_File["collect_bitstream.lua"] = "1.4.1"
QuestHelper_Loadtime["collect_bitstream.lua"] = GetTime()

local Merger

local function Output(outbits)
  return {
    r = {},
    cbits = 0,
    cval = 0,
    
    append = function (self, value, bits)
      self.cbits = self.cbits + bits
      self.cval = bit.lshift(self.cval, bits)
      self.cval = self.cval + value
      while self.cbits >= outbits do
        Merger.Add(self.r, strchar(bit.rshift(self.cval, self.cbits - outbits)))
        self.cbits = self.cbits - outbits
        self.cval = bit.band(self.cval, bit.lshift(1, self.cbits) - 1)
      end
    end,
    finish = function (self)
      if self.cbits > 0 then self:append(0, outbits - self.cbits) end
      return Merger.Finish(self.r)
    end,
  }
end

local function Input(indata, outbits)
  return {
    cbits = 0,
    cval = 0,
    coffset = 1,
    
    depend = function (self, bits)
      while self.cbits < bits do
        self.cbits = self.cbits + outbits
        self.cval = bit.lshift(self.cval, outbits) + strbyte(indata, self.coffset)
        self.coffset = self.coffset + 1
      end
      local rv = bit.rshift(self.cval, self.cbits - bits)
      self.cbits = self.cbits - bits;
      self.cval = bit.band(self.cval, bit.lshift(1, self.cbits) - 1)
      return rv
    end,
  }
end

function QH_Collect_Bitstream_Init(_, API)
  Merger = API.Utility_Merger
  QuestHelper: Assert(Merger)
  
  API.Utility_Bitstream = {Input = Input, Output = Output}
end
