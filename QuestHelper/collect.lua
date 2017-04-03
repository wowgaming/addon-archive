QuestHelper_File["collect.lua"] = "1.4.1"
QuestHelper_Loadtime["collect.lua"] = GetTime()

local debug_output = false
if QuestHelper_File["collect.lua"] == "Development Version" then debug_output = true end

local QuestHelper_Collector_Version_Current = 8

QuestHelper_Collector = {}
QuestHelper_Collector_Version = QuestHelper_Collector_Version_Current

local OnUpdateRegistrar = {}
local TooltipRegistrar = {}

local function OnUpdateHookRegistrar(func)
  QuestHelper: Assert(func)
  table.insert(OnUpdateRegistrar, func)
end

local suppress = false

 -- real tooltips don't use this function
local SetTextScript = GameTooltip.SetText
GameTooltip.SetText = function (...)
  suppress = true
  SetTextScript(...)
  suppress = false
end

local function CollectTooltippery(self)
  if not self then self = GameTooltip end
  
  for k, v in pairs(TooltipRegistrar) do
    v(self)
  end
  
  -- anything past here is not my fault
end

local ottsu = GameTooltip:GetScript("OnTooltipSetUnit")
QH_Hook(GameTooltip, "OnTooltipSetUnit", function (self, ...)
  CollectTooltippery(self)
  if ottsu then return QH_Hook_NotMyFault(ottsu, self, ...) end
end, "collection OnTooltipSetUnit")

local ottsi = GameTooltip:GetScript("OnTooltipSetItem")
QH_Hook(GameTooltip, "OnTooltipSetItem", function (self, ...)
  CollectTooltippery(self)
  if ottsi then return QH_Hook_NotMyFault(ottsi, self, ...) end
end, "collection OnTooltipSetItem")

local ottsh = GameTooltip:GetScript("OnShow")
QH_Hook(GameTooltip, "OnShow", function (self, ...)
  CollectTooltippery(self)
  if ottsh then return QH_Hook_NotMyFault(ottsh, self, ...) end
end, "collection OnShow")


local function TooltipHookRegistrar(func)
  QuestHelper: Assert(func)
  table.insert(TooltipRegistrar, func)
end

local API = {
  Registrar_OnUpdateHook = OnUpdateHookRegistrar,
  Registrar_TooltipHook = TooltipHookRegistrar,
  Callback_Location_Raw = function () return QuestHelper:Location_RawRetrieve() end,
  Callback_Location_Absolute = function () return QuestHelper:Location_AbsoluteRetrieve() end,
}

-- We do these early, because some things that aren't in collect may rely on these. Yes I realize that avoiding this was one of my main goals in the separate collect system, shut up go away I hate you (in all seriousness: crunch mode + lazy = some nasty bits.)
-- TODO: Make a common collect/mainmodule system, then rely on that better.
QH_Collect_Util_Init(nil, API)  -- Some may actually add their own functions to the API, and should go first. There's no real formalized order, I just know which depend on others, and it's heavily asserted so it will break if it goes in the wrong order.
QH_Collect_Merger_Init(nil, API)
QH_Collect_Bitstream_Init(nil, API)
QH_Collect_Location_Init(nil, API)
QH_Collect_Patterns_Init(nil, API)
QH_Collect_Notifier_Init(nil, API)
QH_Collect_Spec_Init(nil, API)
QH_Collect_LZW_Init(nil, API)

local CompressCollection

function QH_Collector_Init()
  QH_Collector_UpgradeAll(QuestHelper_Collector)
  
  for _, v in pairs(QuestHelper_Collector) do
    if not v.modified then v.modified = time() - 7 * 24 * 60 * 60 end  -- eugh. Yeah, we set it to be a week ago. It's pretty grim.
  end
  
  QuestHelper_Collector_Version = QuestHelper_Collector_Version_Current
  
  local sig = string.format("%s on %s/%s/%d", GetAddOnMetadata("QuestHelper", "Version"), GetBuildInfo(), GetLocale(), QuestHelper:PlayerFaction())
  local sig_altfaction = string.format("%s on %s/%s/%d", GetAddOnMetadata("QuestHelper", "Version"), GetBuildInfo(), GetLocale(), (QuestHelper:PlayerFaction() == 1) and 2 or 1)
  if not QuestHelper_Collector[sig] or QuestHelper_Collector[sig].compressed then QuestHelper_Collector[sig] = {version = QuestHelper_Collector_Version} end -- fuckin' bullshit, man
  local QHCData = QuestHelper_Collector[sig]
  QuestHelper: Assert(not QHCData.compressed)
  QuestHelper: Assert(QHCData.version == QuestHelper_Collector_Version_Current)
  QHCData.modified = time()
  
  QH_Collect_Achievement_Init(QHCData, API)
  QH_Collect_Traveled_Init(QHCData, API)
  QH_Collect_Zone_Init(QHCData, API)
  QH_Collect_Monster_Init(QHCData, API)
  QH_Collect_Item_Init(QHCData, API)
  QH_Collect_Object_Init(QHCData, API)
  QH_Collect_Flight_Init(QHCData, API)
  QH_Collect_Quest_Init(QHCData, API)
  QH_Collect_Warp_Init(QHCData, API)
  
  QH_Collect_Loot_Init(QHCData, API)
  QH_Collect_Equip_Init(QHCData, API)
  QH_Collect_Merchant_Init(QHCData, API)
  
  if not QHCData.realms then QHCData.realms = {} end
  QHCData.realms[GetRealmName()] = (QHCData.realms[GetRealmName()] or 0) + 1 -- I'm not entirely sure why I'm counting
  
  if false then  -- this will be disabled in most public releases, or set to a very rare probabalistic thing
    if not QHCData.routing_dump then QHCData.routing_dump = {} end
    local nt = {}
    table.insert(QHCData.routing_dump, nt)
    QH_Collect_Routing_Dump = nt
  end
  
  do  -- Clean some stuff up!
    local obliterate = {}
    for k, v in pairs(QuestHelper_Collector) do
      if not v.modified or v.modified + 30 * 24 * 60 * 60 < GetTime() then
        table.insert(obliterate, k)
      end
    end
    
    for _, v in ipairs(obliterate) do
      QuestHelper_Collector[v] = nil
    end
  end
  
  -- So, why do we delay it?
  -- It's simple. People are gonna update to this version, and then they're going to look at the memory usage. Then they will panic because omg this version uses so much more memory, I bet that will somehow hurt my framerates in a way which is not adequately explained!
  -- So instead, we just wait half an hour before compressing. Compression will still get done, and I won't have to deal with panicked comments about how bloated QH has gotten.
  -- addendum: yeah naturally I'm getting all sorts of panicked comments about how bloated qh has gotten, sigh
  API.Utility_Notifier(GetTime() + (debug_output and 0 or (30 * 60)), function() CompressCollection(QHCData, QuestHelper_Collector[sig_altfaction], API.Utility_Merger, API.Utility_LZW.Compress) end)
end

QH_OnUpdate(function ()
  local tstart = GetTime()
  for _, v in pairs(OnUpdateRegistrar) do
    v()
  end
  QH_Timeslice_Increment(GetTime() - tstart, "collect_update")
end)



--- I've tossed the compression stuff down here just 'cause I don't feel like making an entire file for it (even though I probably should.)

local noncompressible = {
  modified = true,
  version = true,
}

local squarify

local seritem

local serializers = {
  ["nil"] = function(item, add)
    add("nil")
  end,
  ["number"] = function(item, add)
    add(tostring(item))
  end,
  ["string"] = function(item, add)
    add(string.format("%q", item))
  end,
  ["boolean"] = function(item, add)
    add(item and "true" or "false")
  end,
  ["table"] = function(item, add)
    add("{")
    local first = true
    for k, v in pairs(item) do
      if not first then add(",") end
      first = false
      add("[")
      seritem(k, add)
      add("]=")      
      seritem(v, add)
    end
    add("}")
  end,
}

seritem = function(item, add)
  QH_Timeslice_Yield()
  serializers[type(item)](item, add)
end

local function DoCompress(item, merger, comp)
  if debug_output then QuestHelper: TextOut("Item condensing") end
  local ts = GetTime()
  
  local target = {}
  for k, v in pairs(item) do
    if not noncompressible[k] then
      target[k] = v
    end
  end
  
  local mg = {}
  seritem(target, function(dat) merger.Add(mg, dat) end)
  
  local tg = merger.Finish(mg)
  if debug_output then QuestHelper: TextOut(string.format("Item condensed to %d bytes, %f taken so far", #tg, GetTime() - ts)) end
  mg = nil
  
  local cmp = {}
  local cmptot = 0
  
  local doublecheck = ""
  for chunk = 1, #tg, 1048576 do
    local fragment = tg:sub(chunk, chunk + 1048575)
    doublecheck = doublecheck .. fragment
    local ite = comp(fragment, 256, 8)
    cmptot = cmptot + #ite
    table.insert(cmp, ite)
  end
  QuestHelper: Assert(doublecheck == tg)
  
  if #cmp == 1 then cmp = cmp[1] end
  
  for k, v in pairs(target) do
    if not noncompressible[k] then
      item[k] = nil
    end
  end
  item.compressed = cmp
  
  if debug_output then QuestHelper: TextOut(string.format("Item compressed to %d bytes in %d shards (previously %d), %f taken", cmptot, type(cmp) == "table" and #cmp or 1, #tg, GetTime() - ts)) end
end

CompressCollection = function(active, active2, merger, comp)
  for _, v in pairs(QuestHelper_Collector) do
    if v ~= active and v ~= active2 and not v.compressed then
      QH_Timeslice_Add(function ()
        DoCompress(v, merger, comp)
        CompressCollection(active, active2, merger, comp)
      end, "compress")
      break
    end
  end
end
