QuestHelper_File["collect_merchant.lua"] = "1.4.1"
QuestHelper_Loadtime["collect_merchant.lua"] = GetTime()

-- http://www.penny-arcade.com/comic/2005/01/05/

local debug_output = false
if QuestHelper_File["collect_merchant.lua"] == "Development Version" then debug_output = true end

local QHCM

local IsMonsterGUID
local GetMonsterType
local GetItemType

local function AddChatType(typ)
  local target = UnitGUID("target")
  if not target then return end
  
  if not IsMonsterGUID(target) then return end
  
  target = GetMonsterType(target)
  
  if not QHCM[target] then QHCM[target] = {} end
  QHCM[target]["chat_" .. typ] = (QHCM[target]["chat_" .. typ] or 0) + 1
  return QHCM[target]
end

local function MerchantShow()
  local ct = GetMerchantNumItems()
  for i = 1, ct do if not GetMerchantItemLink(i) then return end end  -- We want to make sure it's cached, otherwise we'll return wonky data. Technically this biases things away from "yes he's a shopkeeper", but honestly, it doesn't matter that much.
  
  targ = AddChatType("shop")
  if not targ then return end -- welllllp
  
  local ct = GetMerchantNumItems()
  --QuestHelper:TextOut(string.format("nitems %d", ct))
  
  for i = 1, ct do
    local itemid = GetMerchantItemLink(i)
    QuestHelper: Assert(itemid)
    itemid = GetItemType(itemid)
    local _, _, price, quant, avail, _, _ = GetMerchantItemInfo(i)
    local dstr = string.format("%d@@%d@@%d@@%d", itemid, quant, avail, price)
    --if debug_output then QuestHelper:TextOut(dstr) end
    targ["shop_" .. dstr] = (targ["shop_" .. dstr] or 0) + 1
  end
end

local function GossipShow()
  AddChatType("talk")
end

local function QuestGreeting()
  AddChatType("quest")
end


function QH_Collect_Merchant_Init(QHCData, API)
   if not QHCData.monster then QHCData.monster = {} end
  QHCM = QHCData.monster
  
  QH_Event("MERCHANT_SHOW", MerchantShow)
  QH_Event("GOSSIP_SHOW", GossipShow)
  QH_Event("QUEST_GREETING", QuestGreeting)
  
  IsMonsterGUID = API.Utility_IsMonsterGUID
  GetMonsterType = API.Utility_GetMonsterType
  GetItemType = API.Utility_GetItemType
  QuestHelper: Assert(IsMonsterGUID)
  QuestHelper: Assert(GetMonsterType)
  QuestHelper: Assert(GetItemType)
end
