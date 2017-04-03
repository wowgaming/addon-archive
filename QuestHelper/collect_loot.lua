QuestHelper_File["collect_loot.lua"] = "1.4.1"
QuestHelper_Loadtime["collect_loot.lua"] = GetTime()

local debug_output = false
if QuestHelper_File["collect_loot.lua"] == "Development Version" then debug_output = true end

local QHC

local GetMonsterUID
local GetMonsterType

local GetItemType

local GetLoc

local Patterns

local members = {}
local members_count = 0
local members_refs = {} -- "raid6" and the like

local function MembersUpdate()
  -- We want to keep track of exactly who is in a group with this player, so we can watch for combat messages involving them, so we can see who's been tapped, so we can record the right deaths, so we can know who the player should be able to loot.
  -- I hate my life.
  -- >:(
  
  local alone = false
  
  --QuestHelper:TextOut("MU start")
  members = {} -- we burn a table every time this updates, but whatever
  members_count = 0
  if GetNumRaidMembers() > 0 then
    -- we is in a raid
    for i = 1, 40 do
      local ite = string.format("raid%d", i)
      local gud = UnitGUID(ite)
      if gud then
        members[gud] = true
        table.insert(members_refs, ite)
        --QuestHelper:TextOut(string.format("raid member %s added", UnitName(ite)))
      end
    end
  elseif GetNumPartyMembers() > 0 then
    -- we is in a party
    for i = 1, 4 do
      local ite = string.format("party%d", i)
      local gud = UnitGUID(ite)
      if gud then
        members[gud] = true
        table.insert(members_refs, ite)
        --QuestHelper:TextOut(string.format("party member %s added", UnitName(ite)))
      end
    end
    members[UnitGUID("player")] = true
    table.insert(members_refs, "player")
    --QuestHelper:TextOut(string.format("player %s added", UnitName("player"))) 
  else
    -- we is alone ;.;
    if UnitGUID("player") then members[UnitGUID("player")] = true end -- it's possible that we haven't logged in entirely yet
    table.insert(members_refs, "player")
    --QuestHelper:TextOut(string.format("player %s added as %s", UnitName("player"), tostring(UnitGUID("player"))))
    alone = true
  end
  
  if GetLootMethod() == "master" and not alone then members = {} members_refs = {} end -- We're not going to bother trying to deal with master loot right now - it's just too different and I just don't care enough.
  
  for _, _ in pairs(members) do members_count = members_count + 1 end -- lulz
end

local MS_TAPPED_US = 1
local MS_TAPPED_US_TRIVIAL = 2
local MS_TAPPED_OTHER = 3
local MS_TAPPED_LOOTABLE = 4
local MS_TAPPED_LOOTABLE_TRIVIAL = 5
local MS_TAPPED_LOOTED = 6

local last_cleanup = GetTime()

local monsterstate = {}
local monsterrefresh = {}
local monstertimeout = {}

-- This all does something quite horrible.
-- Some monsters don't become lootable when they're killed and didn't drop anything. We need to record this so we can get real numbers for them. 
-- Unfortunately, we can't just record when "something" is killed. We have to record when "our group" killed it, so we know that there *was* a chance of looting it.
-- As such, we need to check for monster deaths that the player may never have actually targeted. It gets, to put it mildly, grim, and unfortunately we'll never be able to solve it entirely.
-- Worse, we need to *not* record item drops for things that we never actually "saw" but that were lootable anyway, because if we do, we bias the results towards positive (i.e. if we AOE ten monsters down, and two of them drop, and we loot those, that's 2/2 if we record the drops, and 0/0 if we don't, while what we really want is 2/10. 0/0 is at least "not wrong".)
-- On top of this, we want to avoid looting "discarded items", but unfortunately there's no real good way to determine this. Welp.
local last_scan = 0
-- Here's a little bottleneck - we're going to try to only do one scan per second. Fingers crossed.

local function CombatLogEvent(_, event, sourceguid, _, _, destguid, _, _, _, spellname)
  -- There's many things that are handled here.
  -- First, if there's any damage messages coming either to or from a party member, we check to see if that monster is tapped by us. If it's tapped, we cache the value for 15 seconds, expiring entirely in 30.
  -- Second, there's the Death message. If it's tapped by us, increases the kill count by 1/partymembers and changes its state to lootable.
  if event ~= "UNIT_DIED" then
    if last_scan > GetTime() then return end -- welp
    
    -- Something has been attacked by something, maybe.
    if not string.find(event, "_DAMAGE$") then return end -- We only care about something punching something else.
    
    local target, source
    if members[sourceguid] then
      source = sourceguid
      target = destguid
    elseif members[destguid] then
      source = targetguid
      target = sourceguid
    end -- If one of the items is in our party, the other is our target.
    
    if not target then return end   -- If we don't have a target, then nobody is in our party, and we don't care.
    
    if monsterrefresh[target] and monsterrefresh[target] > GetTime() then return end -- we already have fresh data, so we're good
    
    -- Now comes the tricky part. We can't just look at the target because we're not allowed to target by GUID. So we iterate through all the party/raid members and hope *someone* has it targeted. Luckily, we can stop once we find someone who does.
    local targ
    for _, v in pairs(members_refs) do
      targ = v .. "target"   if UnitGUID(targ) == target then break end
      targ = nil
    end
    last_scan = GetTime() + 1
    
    if not targ then
      --monsterrefresh[target] = GetTime() + 5
      --monstertimeout[target] = GetTime() + 5
      return
    end -- Well, nobody seems to be targeting it. That's . . . odd, and annoying. We were thinking of tossing on a 5-second timeout. But we didn't, because we decided the global one-second lockout might help. So we'll do that for now.
    
    -- Okay. So we know who's targeting it. Now, let's see who has it tapped, if anyone.
    if not UnitIsTapped(targ) then
      -- Great. Nobody is. That is just *great*. Look how exuberant I feel at this moment. You know what? 5-second timeout.
      monsterstate[target] = nil
      monsterrefresh[target] = GetTime() + 5
      monstertimeout[target] = GetTime() + 5
      --if debug_output then QuestHelper:TextOut(string.format("Monster ignorified")) end
    else
      -- We know someone is, so we're going to set up our caching . . .
      monsterrefresh[target] = GetTime() + 15
      monstertimeout[target] = GetTime() + 30
      monsterstate[target] = (UnitIsTappedByPlayer(targ)) and (not UnitIsTrivial(targ) and MS_TAPPED_US or MS_TAPPED_US_TRIVIAL) or MS_TAPPED_OTHER -- and figure out if it's us. Or if it's trivial. We somewhat-ignore it if it's trivial, since it's much less likely to be looted and that could throw off our numbers
      --if debug_output then QuestHelper:TextOut(string.format("Monster %s set to %d, %s, %s", target, monsterstate[target], tostring(UnitIsTappedByPlayer(targ)), tostring(UnitIsTrivial(targ)))) end
    end
    
    -- DONE
  else
    -- It's dead. Hooray!
    
    if monsterstate[destguid] and monstertimeout[destguid] > GetTime() and (monsterstate[destguid] == MS_TAPPED_US or monsterstate[destguid] == MS_TAPPED_US_TRIVIAL) and members_count > 0 then -- yaaay
      local type = GetMonsterType(destguid)
      if not QHC.monster[type] then QHC.monster[type] = {} end
      if monsterstate[destguid] == MS_TAPPED_US then
        QHC.monster[type].kills = (QHC.monster[type].kills or 0) + 1 / members_count  -- Hopefully, most people loot their kills. Divide by members_count 'cause there's a 1/members chance that we get to loot. We'll flag the loot count some other way if it was a trivial monster.
      end
      
      monsterstate[destguid] = (monsterstate[destguid] == MS_TAPPED_US and MS_TAPPED_LOOTABLE or MS_TAPPED_LOOTABLE_TRIVIAL)
      monsterrefresh[destguid] = GetTime() + 600
      monstertimeout[destguid] = GetTime() + 600
      --QuestHelper:TextOut(string.format("Tapped monster %s slain, set to lootable", destguid))
    else
      monsterstate[destguid] = nil
      monsterrefresh[destguid] = nil
      monstertimeout[destguid] = nil
      --QuestHelper:TextOut(string.format("Untapped monster %s slain, cleared", destguid))
    end
  end
end

local skintypes = {}

skintypes[UNIT_SKINNABLE_ROCK] = "mine"
skintypes[UNIT_SKINNABLE_HERB] = "herb"
skintypes[UNIT_SKINNABLE_BOLTS] = "eng"
skintypes[UNIT_SKINNABLE_LEATHER] = "skin"

local function SkinnableflagsTooltipy(self, ...)
  --QuestHelper:TextOut("tooltipy")
  if UnitExists("mouseover") and UnitIsVisible("mouseover") and not UnitIsPlayer("mouseover") and not UnitPlayerControlled("mouseover") and UnitIsDead("mouseover") then
    local guid = UnitGUID("mouseover")
    --QuestHelper:TextOut("critar")
    if not monsterstate[guid] or monsterstate[guid] ~= MS_TAPPED_LOOTED or monsterrefresh[guid] > GetTime() then return end
    --QuestHelper:TextOut("runin")
    
    local cid = GetMonsterType(guid)
    
    local skintype = nil
    
    local lines = GameTooltip:NumLines()
    for i = 3, lines do
      --QuestHelper:TextOut(_G["GameTooltipTextLeft" .. tostring(i)]:GetText())
      local skeen = skintypes[_G["GameTooltipTextLeft" .. tostring(i)]:GetText()]
      if skeen then QuestHelper: Assert(not skintype) skintype = skeen end
    end
    
    if not QHC.monster[cid] then QHC.monster[cid] = {} end
    local qhci = QHC.monster[cid]
    
    for _, v in pairs(skintypes) do
      if v == skintype then
        --QuestHelper:TextOut(v .. "_yes")
        qhci[v .. "_yes"] = (qhci[v .. "_yes"] or 0) + 1
      else
        --QuestHelper:TextOut(v .. "_no")
        qhci[v .. "_no"] = (qhci[v .. "_no"] or 0) + 1
      end
    end
  end
end

-- Logic behind this module:
-- Watch for the spell to be sent
-- Watch for it to start
-- Check out the combat log and see what GUID we get
-- If the GUID is null, we're targeting an object, otherwise, we're targeting a critter
-- Wait for spell to succeed
-- If anything doesn't synch up, or the spell is interrupted, nil out all these items.
-- We've got a little special case for pickpocketing, because people often use macros, so we detect that case specifically.

local PP_PHASE_IDLE
local PP_PHASE_SENT
local PP_PHASE_COMPLETE

local pickpocket_phase = PP_PHASE_IDLE
local pickpocket_target
local pickpocket_otarget_guid
local pickpocket_timestamp

local pickpocket_name = GetSpellInfo(921)   -- this is the pickpocket spell ID

local function pp_reset()
  pickpocket_target, pickpocket_otarget_guid, pickpocket_timestamp, pickpocket_phase = nil, nil, nil, PP_PHASE_IDLE
end
pp_reset()

local function PPSent(player, spell, _, target)
  if player ~= "player" then return end
  if spell ~= pickpocket_name then return end
  if UnitName("target") ~= target then return end -- DENY
  
  pickpocket_timestamp, pickpocket_target, pickpocket_otarget_guid, pickpocket_phase = GetTime(), target, UnitGUID("target"), PP_PHASE_SENT
end

local function PPSucceed(player, spell, rank)
  if player ~= "player" then return end
  if spell ~= pickpocket_name then return end
  
  if pickpocket_phase ~= PP_PHASE_SENT and (not pickpocket_otarget_guid or last_timestamp + 1 < GetTime()) then
    pp_reset()
    return
  end
  
  pickpocket_timestamp, pickpocket_phase = GetTime(), PP_PHASE_COMPLETE
end


-- This segment deals with openable containers

local touched_itemid
local touched_timestamp

local function ItemLock(bag, slot)
  if not bag or not slot then return end -- probably changing equipment
  
  local _, _, locked = GetContainerItemInfo(bag, slot)
  --QuestHelper:TextOut(string.format("trying lock %s", tostring(locked)))
  if locked then
    touched_itemid = GetItemType(GetContainerItemLink(bag, slot))
    --[[QuestHelper:TextOut(string.format("trying lock %s", tostring(touched_itemid)))
    QuestHelper:TextOut(string.format("trying lock %s", tostring(type(touched_itemid))))
    QuestHelper:TextOut(string.format("trying lock %s", tostring(QHC.item[touched_itemid].open_yes)))
    QuestHelper:TextOut(string.format("trying lock %s", tostring(QHC.item[touched_itemid].open_no)))]]
    touched_timestamp = GetTime()
    if not QHC.item[touched_itemid] or (QHC.item[touched_itemid].open_yes or 0) <= (QHC.item[touched_itemid].open_no or 0) then
      touched_itemid = nil
      touched_timestamp = nil
    end
  else
    touched_itemid = nil
    touched_timestamp = nil
  end
end


-- Here's the segment for longer spells. There aren't any instant spells we currently care about, besides pickpocketing. This will probably change eventually (arrows in the DK starting zone?)

local LAST_PHASE_IDLE = 0
local LAST_PHASE_SENT = 1
local LAST_PHASE_START = 2
local LAST_PHASE_COMBATLOG = 3
local LAST_PHASE_COMPLETE = 4

local last_phase = LAST_PHASE_IDLE
local last_spell
local last_rank
local last_target
local last_target_guid
local last_otarget
local last_otarget_guid
local last_timestamp
local last_succeed = false
local last_succeed_trade = GetTime()

local gathereffects = {}

gathereffects[GetSpellInfo(51306)] = {token = "eng", noclog = true}
gathereffects[GetSpellInfo(32606)] = {token = "mine"}
gathereffects[GetSpellInfo(2366)] = {token = "herb"}
gathereffects[GetSpellInfo(8613)] = {token = "skin"}
gathereffects[GetSpellInfo(21248)] = {token = "open", noclog = true}
gathereffects[GetSpellInfo(30427)] = {token = "extract", noclog = true} -- not a loot window, so it won't really work, but hey
gathereffects[GetSpellInfo(13262)] = {token = "de", noclog = true, ignore = true}
gathereffects[GetSpellInfo(31252)] = {token = "prospect", noclog = true, ignore = true}
gathereffects[GetSpellInfo(51005)] = {token = "mill", noclog = true, ignore = true}


local function normalize_spell(spell)
  for k in pairs(gathereffects) do
    if spell:find(k) then return k end
  end
  return spell
end


local function last_reset()
  last_timestamp, last_spell, last_rank, last_target, last_target_guid, last_otarget, last_otarget_guid, last_succeed, last_phase = nil, nil, nil, nil, nil, nil, false, LAST_PHASE_IDLE
end
last_reset()

-- This all doesn't work with instant spells. Luckily, I don't care about instant spells (yet).
local function SpellSent(player, spell, rank, target)
  if player ~= "player" then return end
  spell = normalize_spell(spell)
  
  last_timestamp, last_spell, last_rank, last_target, last_target_guid, last_otarget, last_otarget_guid, last_succeed, last_phase = GetTime(), spell, rank, target, nil, UnitName("target"), UnitGUID("target"), false, LAST_PHASE_SENT
  
  if last_otarget and last_otarget ~= last_target then last_reset() return end
  
  --QuestHelper:TextOut(string.format("ss %s", spell))
end

local function SpellStart(player, spell, rank)
  if player ~= "player" then return end
  spell = normalize_spell(spell)
  
  if spell ~= last_spell or rank ~= last_rank or last_target_guid or last_phase ~= LAST_PHASE_SENT or last_timestamp + 1 < GetTime() then
    last_reset()
  else
    --QuestHelper:TextOut(string.format("sst %s", spell))
    last_timestamp, last_phase = GetTime(), LAST_PHASE_START
  end
end

local function SpellCombatLog(_, event, sourceguid, _, _, destguid, _, _, _, spellname)
  if event ~= "SPELL_CAST_START" then return end
  
  if sourceguid ~= UnitGUID("player") then return end
  spellname = normalize_spell(spellname)
  
  --QuestHelper:TextOut(string.format("cle_ss enter %s %s %s %s", tostring(spellname ~= last_spell), tostring(not last_target), tostring(not not last_target_guid), tostring(last_timestamp + 1 < GetTime())))
  
  if spellname ~= last_spell or not last_target or last_target_guid or last_timestamp + 1 < GetTime() then
    last_reset()
    return
  end
  
  --QuestHelper:TextOut("cle_ss enter")
  
  if last_phase ~= LAST_PHASE_START  then
    last_reset()
    return
  end
  
  --QuestHelper:TextOut(string.format("cesst %s", spellname))
  last_timestamp, last_target_guid, last_phase = GetTime(), destguid, LAST_PHASE_COMBATLOG
  
  if last_target_guid == "0x0000000000000000" then last_target_guid = nil end
  if last_target_guid and last_target_guid ~= last_otarget_guid then last_reset() return end
end

local function SpellSucceed(player, spell, rank)
  if player ~= "player" then return end
  spell = normalize_spell(spell)
  
  if gathereffects[spell] then last_succeed_trade = GetTime() end
  
  --QuestHelper:TextOut(string.format("sscu enter %s %s %s %s %s", tostring(last_spell), tostring(last_target), tostring(last_rank), tostring(spell), tostring(rank)))
  
  if not last_spell or not last_target or last_spell ~= spell or last_rank ~= rank then
    last_reset()
    return
  end
  
  --QuestHelper:TextOut("sscu enter")
  
  if gathereffects[spell] and gathereffects[spell].noclog then
    if last_phase ~= LAST_PHASE_START or last_timestamp + 10 < GetTime() then
      last_reset()
      return
    end
  else
    if last_phase ~= LAST_PHASE_COMBATLOG or last_timestamp + 10 < GetTime() then
      last_reset()
      return
    end
  end
  
  --QuestHelper:TextOut(string.format("sscu %s, %d, %s, %s", spell, last_phase, tostring(last_phase == LAST_PHASE_SENT), tostring((last_phase == LAST_PHASE_SENT) and LAST_PHASE_SHORT_SUCCEEDED)))
  last_timestamp, last_succeed, last_phase = GetTime(), true, LAST_PHASE_COMPLETE
  --QuestHelper:TextOut(string.format("last_phase %d", last_phase))
  
  --[[if last_phase == LAST_PHASE_COMPLETE then
    QuestHelper:TextOut(string.format("spell succeeded, casting %s %s on %s/%s", last_spell, last_rank, tostring(last_target), tostring(last_target_guid)))
  end]]
end

local function SpellInterrupt(player, spell, rank)
  if player ~= "player" then return end
  
  -- I don't care what they were casting, they're certainly not doing it now
  --QuestHelper:TextOut(string.format("si %s", spell))
  last_reset()
end

local function LootOpened()

  local targetguid = UnitGUID("target")

  -- We're cleaning up the monster charts here, on the theory that if someone is looting, they're okay with a tiny lag spike.
  if last_cleanup + 300 < GetTime() then
    local cleanup = {}
    for k, v in pairs(monstertimeout) do
      if v < GetTime() then table.insert(cleanup, k) end
    end
    
    for _, v in pairs(cleanup) do
      monsterstate[v] = nil
      monsterrefresh[v] = nil
      monstertimeout[v] = nil
    end
  end

  -- First off, we try to figure out where the hell these items came from.
  
  local spot = nil
  local prefix = nil
  
  if IsFishingLoot() then
    -- yaaaaay
    --if debug_output then QuestHelper:TextOut("Fishing loot") end
    local loc = GetLoc()
    if not QHC.fishing[loc] then QHC.fishing[loc] = {} end
    spot = QHC.fishing[loc]
    prefix = "fish"
    
  elseif pickpocket_phase == PP_PHASE_COMPLETE and pickpocket_timestamp and pickpocket_timestamp + 1 > GetTime() and targetguid == pickpocket_otarget_guid then
    --if debug_output then QuestHelper:TextOut(string.format("Pickpocketing from %s/%s", pickpocket_target, UnitName("target"), targetguid)) end
    local mid = GetMonsterType(targetguid)
    if not QHC.monster[mid] then QHC.monster[mid] = {} end
    spot = QHC.monster[mid]
    prefix = "rob"
    
  elseif last_phase == LAST_PHASE_COMPLETE and gathereffects[last_spell] and last_timestamp + 1 > GetTime() then
    local beef = string.format("%s/%s %s/%s", tostring(last_target), tostring(last_target_guid), tostring(last_otarget), tostring(last_otarget_guid))
    
    if gathereffects[last_spell].ignore then return end
    
    prefix = gathereffects[last_spell].token
    
    -- this one is sort of grim actually
    -- If we have an last_otarget_guid, it's the right one, and it's a monster
    -- If we don't, use last_target, and it's an object
    -- This is probably going to be buggy. Welp.
    if last_otarget_guid then
      if debug_output then QuestHelper:TextOut(string.format("%s from monster %s", gathereffects[last_spell].token, beef)) end
      local mid = GetMonsterType(last_otarget_guid)
      if not QHC.monster[mid] then QHC.monster[mid] = {} end
      spot = QHC.monster[mid]
    else
      if debug_output then QuestHelper:TextOut(string.format("%s from object %s", gathereffects[last_spell].token, beef)) end
      if not QHC.object[last_target] then QHC.object[last_target] = {} end
      spot = QHC.object[last_target]
    end
    
  elseif touched_timestamp and touched_timestamp + 1 > GetTime() then
    -- Opening a container, possibly
    --if debug_output then QuestHelper:TextOut(string.format("Opening container %d", touched_itemid)) end
    if not QHC.item[touched_itemid] then QHC.item[touched_itemid] = {} end
    spot = QHC.item[touched_itemid]
    prefix = "open"
    
  elseif targetguid and (monsterstate[targetguid] == MS_TAPPED_LOOTABLE or monsterstate[targetguid] == MS_TAPPED_LOOTABLE_TRIVIAL) and monstertimeout[targetguid] > GetTime() and (not pickpocket_timestamp or pickpocket_timestamp + 5 < GetTime()) and (not last_timestamp or last_timestamp + 5 < GetTime()) and (last_succeed_trade + 5 < GetTime()) then -- haha holy shit
    -- Monster is lootable, so we loot the monster. Should we check to see if it's dead first? Probably.
    --if debug_output then QuestHelper:TextOut(string.format("%s from %s/%s", (monsterstate[targetguid] == MS_TAPPED_LOOTABLE and "Monsterloot" or "Trivial monsterloot"), UnitName("target"), targetguid)) end

    local mid = GetMonsterType(targetguid)
    if not QHC.monster[mid] then QHC.monster[mid] = {} end
    spot = QHC.monster[mid]
    if monsterstate[targetguid] == MS_TAPPED_LOOTABLE then
      prefix = "loot"
    elseif monsterstate[targetguid] == MS_TAPPED_LOOTABLE_TRIVIAL then
      prefix = "loot_trivial" -- might be a better way to do this, but we'll see
    end
    
    monsterstate[targetguid] = MS_TAPPED_LOOTED
    monstertimeout[targetguid] = GetTime() + 300
    monsterrefresh[targetguid] = GetTime() + 2
  else
    --if debug_output then QuestHelper:TextOut("Who knows") end  -- ugh
    local loc = GetLoc()
    if not QHC.worldloot[loc] then QHC.worldloot[loc] = {} end
    spot = QHC.worldloot[loc]
    prefix = "loot"
    
  end
  
  
  
  local items = {}
  items.gold = 0
  for i = 1, GetNumLootItems() do
    _, name, quant, _ = GetLootSlotInfo(i)
    link = GetLootSlotLink(i)
    if quant == 0 then
      -- moneys
      local _, _, amount = string.find(name, Patterns.GOLD_AMOUNT)
      if amount then items.gold = items.gold + tonumber(amount) * 10000 end
      
      local _, _, amount = string.find(name, Patterns.SILVER_AMOUNT)
      if amount then items.gold = items.gold + tonumber(amount) * 100 end
      
      local _, _, amount = string.find(name, Patterns.COPPER_AMOUNT)
      if amount then items.gold = items.gold + tonumber(amount) * 1 end
    else
      local itype = GetItemType(link)
      items[itype] = (items[itype] or 0) + quant
    end
  end
  
  spot[prefix .. "_count"] = (spot[prefix .. "_count"] or 0) + 1
  if not spot[prefix .. "_loot"] then spot[prefix .. "_loot"] = {} end
  local pt = spot[prefix .. "_loot"]
  for k, v in pairs(items) do
    if v > 0 then pt[k] = (pt[k] or 0) + v end
  end
end

function QH_Collect_Loot_Init(QHCData, API)
  QHC = QHCData
  
  if not QHC.monster then QHC.monster = {} end
  if not QHC.worldloot then QHC.worldloot = {} end
  if not QHC.fishing then QHC.fishing = {} end
  if not QHC.item then QHC.item = {} end
  
  QH_Event("PLAYER_ENTERING_WORLD", MembersUpdate)
  QH_Event("RAID_ROSTER_UPDATE", MembersUpdate)
  QH_Event("PARTY_MEMBERS_CHANGED", MembersUpdate)
  QH_Event("COMBAT_LOG_EVENT_UNFILTERED", CombatLogEvent)

  QH_Event("UPDATE_MOUSEOVER_UNIT", SkinnableflagsTooltipy)
  
  QH_Event("UNIT_SPELLCAST_SENT", PPSent)
  QH_Event("UNIT_SPELLCAST_SUCCEEDED", PPSucceed)
  
  QH_Event("ITEM_LOCK_CHANGED", ItemLock)
  
  QH_Event("UNIT_SPELLCAST_SENT", SpellSent)
  QH_Event("UNIT_SPELLCAST_START", SpellStart)
  QH_Event("COMBAT_LOG_EVENT_UNFILTERED", SpellCombatLog)
  QH_Event("UNIT_SPELLCAST_SUCCEEDED", SpellSucceed)
  QH_Event("UNIT_SPELLCAST_INTERRUPTED", SpellInterrupt)
  
  QH_Event("LOOT_OPENED", LootOpened)
  
  MembersUpdate() -- to get self, probably won't work but hey
  
  GetMonsterUID = API.Utility_GetMonsterUID
  GetMonsterType = API.Utility_GetMonsterType
  GetItemType = API.Utility_GetItemType
  QuestHelper: Assert(GetMonsterUID)
  QuestHelper: Assert(GetMonsterType)
  QuestHelper: Assert(GetItemType)
  
  Patterns = API.Patterns
  API.Patterns_RegisterNumber("GOLD_AMOUNT")
  API.Patterns_RegisterNumber("SILVER_AMOUNT")
  API.Patterns_RegisterNumber("COPPER_AMOUNT")
  
  GetLoc = API.Callback_LocationBolusCurrent
  QuestHelper: Assert(GetLoc)
  
  -- What I want to know is whether it was tagged by me or my group when dead
  -- Check target-of-each-groupmember? Once we see him tapped once, and by us, it's probably sufficient.
  -- Notes:
  --[[
  
  COMBAT_LOG_EVENT_UNFILTERED arg2 UNIT_DIED, PLAYER_TARGET_CHANGED, LOOT_OPENED, (LOOT_CLOSED, [LOOT_SLOT_CLEARED, ITEM_PUSH, CHAT_MSG_LOOT]), PLAYER_TARGET_CHANGED, SPELLCAST_SENT, SPELLCAST_START, SUCCEEDED/INTERRUPTED, STOP, LOOT_OPENED (etc)
  
  ITEM_PUSH can happen after LOOT_CLOSED, but it still happens.
  Between LOOT_OPENED and LOOT_CLOSED, the lootable target is still targeted. Unsure what happens when looting items. LOOT_CLOSED triggers first if we target someone else.
  ITEM_PUSH happens, then CHAT_MSG_LOOT. CHAT_MSG_LOOT includes quite a lot of potentially useful arguments.
  PLAYER_TARGET_CHANGED before either looting or skinning.
  SPELLCAST_SENT, SPELLCAST_START, SUCCEEDED/INTERRUPTED, STOP in that order. Arg4 on SENT seems to be the target's name. Arg4 on the others appears to be a unique identifier.
  When started, we target the right thing. After that, we don't seem to. Check the combat log.
  
  ]]
end
