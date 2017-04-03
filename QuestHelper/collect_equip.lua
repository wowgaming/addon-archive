QuestHelper_File["collect_equip.lua"] = "1.4.1"
QuestHelper_Loadtime["collect_equip.lua"] = GetTime()

local debug_output = false
if QuestHelper_File["collect_equip.lua"] == "Development Version" then debug_output = true end

local GetItemType
local Notifier
local GetSpecBolus
local Patterns

local QHCI

-- why does this need to exist
local invloc_lookup_proto = {
  INVTYPE_HEAD = {"HeadSlot"},
  INVTYPE_NECK = {"NeckSlot"},
  INVTYPE_SHOULDER = {"ShoulderSlot"},
  INVTYPE_CHEST = {"ChestSlot"},
  INVTYPE_ROBE = {"ChestSlot"},
  INVTYPE_WAIST = {"WaistSlot"},
  INVTYPE_LEGS = {"LegsSlot"},
  INVTYPE_FEET = {"FeetSlot"},
  INVTYPE_WRIST = {"WristSlot"},
  INVTYPE_HAND = {"HandsSlot"},
  INVTYPE_FINGER = {"Finger0Slot", "Finger1Slot"},
  INVTYPE_TRINKET = {"Trinket0Slot", "Trinket1Slot"},
  INVTYPE_CLOAK = {"BackSlot"},
  INVTYPE_WEAPON = {"MainHandSlot", "SecondaryHandSlot"},
  INVTYPE_SHIELD = {"SecondaryHandSlot"},
  INVTYPE_2HWEAPON = {"MainHandSlot"},
  INVTYPE_WEAPONMAINHAND = {"MainHandSlot"},
  INVTYPE_WEAPONOFFHAND = {"SecondaryHandSlot"},
  INVTYPE_HOLDABLE = {"RangedSlot"},
  INVTYPE_RANGED = {"RangedSlot"},
  INVTYPE_THROWN = {"RangedSlot"},
  INVTYPE_RANGEDRIGHT = {"RangedSlot"},
  INVTYPE_RELIC = {"RangedSlot"},
}

local invloc_lookup = {}

for k, v in pairs(invloc_lookup_proto) do
  local temp = {}
  for _, tv in pairs(v) do
    table.insert(temp, (GetInventorySlotInfo(tv)))
  end
  invloc_lookup[k] = temp
end

local function Recheck(item, location, competing)
  local replaced = nil
  local confused = false
  
  for i, v in pairs(invloc_lookup[location]) do
    if competing[i] then
      local ilink = GetInventoryItemLink("player", v)
      if ilink then
        local itype = GetItemType(ilink)
        local eqtext = nil
        if itype == item then
          replaced = competing[i]
        elseif itype == competing[i] then
        else
          confused = true
        end
      end
    end
  end
  
  if confused then
    if debug_output then QuestHelper:TextOut(string.format("Confused about %s", GetItemInfo(item))) end
    return
  end
  
  if not QHCI[item] then QHCI[item] = {} end
  if replaced then
    if debug_output then QuestHelper:TextOut(string.format("Equipped %s over %s", GetItemInfo(item), GetItemInfo(replaced))) end
    QHCI[item].equip_yes = (QHCI[item].equip_yes or "") .. string.format("I%di%s", replaced, GetSpecBolus())
  else
    for _, v in pairs(competing) do
      if debug_output then QuestHelper:TextOut(string.format("Did not equip %s over %s", GetItemInfo(item), GetItemInfo(v))) end
      QHCI[item].equip_no = (QHCI[item].equip_no or "") .. string.format("I%di%s", v, GetSpecBolus())
    end
  end
end

local function Looted(message)
  item = string.match(message, Patterns.LOOT_ITEM_PUSHED_SELF)
  if not item then item = string.match(message, Patterns.LOOT_ITEM_SELF) end
  if not item then return end
  
  local item = GetItemType(message, true)
  
  local name, _, quality, ilvl, min, itype, isubtype, _, equiploc, _ = GetItemInfo(item)

  if name and IsEquippableItem(item) and min <= UnitLevel("player") and invloc_lookup[equiploc] then   -- The level comparison may be redundant
    local competing = {}
    local nonempty = false
    for i, v in pairs(invloc_lookup[equiploc]) do
      local litem = GetInventoryItemLink("player", v)
      if litem then litem = GetItemType(litem) end
      if litem and litem ~= item then competing[i] = litem  nonempty = true end
    end
    
    if not nonempty then return end -- congratulations you are better than nothing, we do not care
    
    Notifier(GetTime() + 5 * 60, function () Recheck(item, equiploc, competing) end)
  end
end

function QH_Collect_Equip_Init(QHCData, API)
  if not QHCData.item then QHCData.item = {} end
  QHCI = QHCData.item
  
  Patterns = API.Patterns
  QuestHelper: Assert(Patterns)
  
  API.Patterns_Register("LOOT_ITEM_PUSHED_SELF", "|c.*|r")
  API.Patterns_Register("LOOT_ITEM_SELF", "|c.*|r")
  
  QH_Event("CHAT_MSG_LOOT", Looted)
  
  GetItemType = API.Utility_GetItemType
  Notifier = API.Utility_Notifier
  GetSpecBolus = API.Utility_GetSpecBolus
  QuestHelper: Assert(GetItemType)
  QuestHelper: Assert(Notifier)
  QuestHelper: Assert(GetSpecBolus)
end
