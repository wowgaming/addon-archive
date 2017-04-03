QuestHelper_File["collect_location.lua"] = "1.4.1"
QuestHelper_Loadtime["collect_location.lua"] = GetTime()

-- little endian two's complement
local function signed(c)
  QuestHelper: Assert(not c or c >= -127 and c < 127)
  if not c then c = -128 end
  if c < 0 then c = c + 256 end
  return strchar(c)
end

local function float(c)
  if c then
    c = math.floor(c * 16777216 + 0.5)  -- 24 bits of fraction baby
    QuestHelper: Assert(c >= -2147483647 and c < 2147483647)
  else
    c = -2147483648
  end
  if c < 0 then c = c + 4294967296 end
  return strchar(bit.band(c, 0xff), bit.band(c, 0xff00) / 256, bit.band(c, 0xff0000) / 65536, bit.band(c, 0xff000000) / 16777216)
end

local function BolusizeLocation(delayed, c, z, x, y)
  -- c and z are *signed* integers that fit within an 8-bit int.
  -- x and y are floating-point values, generally between 0 and 1. We'll dedicate 24 bits to the fractional part, largely because we can.
  -- Overall we're using a weird 11 bytes on this. Meh.
  -- Also, any nil values are being turned into MIN_WHATEVER.
  return signed(delayed and 1 or 0) .. signed(c) .. signed(z) .. float(x) .. float(y)
end

-- This merely provides another API function
function QH_Collect_Location_Init(_, API)
  API.Callback_LocationBolus = BolusizeLocation  -- Yeah. *Bolusize*. You heard me.
  API.Callback_LocationBolusCurrent = function () return BolusizeLocation(API.Callback_Location_Raw()) end  -- This is just a convenience function, really
end
