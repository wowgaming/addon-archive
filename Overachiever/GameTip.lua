
local L = OVERACHIEVER_STRINGS
local OVERACHIEVER_ACHID = OVERACHIEVER_ACHID
local GetStatistic = GetStatistic

local AchievementIcon = "Interface\\AddOns\\Overachiever\\AchShield"
local tooltip_complete = { r = 0.2, g = 0.5, b = 0.2 }
local tooltip_incomplete = { r = 1, g = 0.1, b = 0.1 }

local function isCriteria(achID, name)
  local n, t, complete
  for i=1,GetAchievementNumCriteria(achID) do
    n, t, complete = GetAchievementCriteriaInfo(achID, i)
    if (n == name) then  return true, complete;  end
  end
end

Overachiever.IsCriteria = isCriteria

--[[
local function isCriteria_hidden(achID, name)
  local n, t, complete
  local i = 0
  repeat
    i = i + 1
    n, t, complete = GetAchievementCriteriaInfo(achID, i)
    if (n == name) then  return true, complete;  end
  until (not n)
end
--]]

local lastreminder = 0
local SharedMedia = LibStub:GetLibrary("LibSharedMedia-3.0")

local function PlayReminder()
  if (Overachiever_Settings.SoundAchIncomplete ~= 0 and time() >= lastreminder + 15) then
    local sound = SharedMedia:Fetch("sound", Overachiever_Settings.SoundAchIncomplete)
    if (sound) then
      PlaySoundFile(sound)
      lastreminder = time()
    end
  end
end


Overachiever.RecentReminders = {}  -- Used by Tabs module
local RecentReminders = Overachiever.RecentReminders

function Overachiever.RecentReminders_Check()
  local earliest = time() - 120  -- Allow reminders from up to 2 minutes ago
  for id,t in pairs(RecentReminders) do
    if (t < earliest) then
      RecentReminders[id] = nil
    end
  end
end

function Overachiever.GetDifficulty()
  local inInstance = IsInInstance()
  if (inInstance) then
  -- Returns: <instance type ("pvp"/"arena"/"party"/"raid")>, <Heroic?>, <25-player Raid?>, <Heroic Raid?>
  --   If in a raid, the "Heroic Raid?" return will match the "Heroic?" return. Otherwise, it will be nil (actually
  --   no return). Matching is done in order to simplify handling return values so special logic in determining
  --   which return means what is less likely: If in an instance, the "Heroic Raid?" return will always say whether
  --   you're in a heroic raid and the "Heroic?" return will always say whether you're in a heroic instance (raid or
  --   or otherwise).
    local name, itype, diff = GetInstanceInfo()
    if (itype == "raid") then
      return itype, (diff > 2), (diff == 2 or diff == 4), (diff > 2)
    else
      return itype, (diff > 1), false
    end
  else
  -- Returns: false, <Dungeon set as Heroic?>, <Raid set for 25 players?>, <Raid set as Heroic?>
    local d = GetDungeonDifficulty()
    local r = GetRaidDifficulty()
    return false, (d > 1), (r == 2 or r == 4), (r > 2)
  end
end


-- UNIT TOOLTIP HOOK
----------------------

local CritterAch = {
  LoveCritters = { "CritterTip_loved", L.ACH_LOVECRITTERS_COMPLETE, L.ACH_LOVECRITTERS_INCOMPLETE },
  LoveCritters2 = { "CritterTip_loved", L.ACH_LOVECRITTERS_COMPLETE, L.ACH_LOVECRITTERS_INCOMPLETE },
  PestControl = { "CritterTip_killed", L.KILL_COMPLETE, L.KILL_INCOMPLETE },
};

local function CritterCheck(ach, name)
  local id = OVERACHIEVER_ACHID[ach]
  if (select(4, GetAchievementInfo(id))) then
    CritterAch[ach] = nil;
    return;
  end
  local isCrit, complete = isCriteria(id, name)
  if (isCrit) then
    return id, complete and CritterAch[ach][2] or CritterAch[ach][3], complete
  end
end

local RaceClassAch = {
  FistfulOfLove = { "FistfulOfLove_petals", L.ACH_FISTFULOFLOVE_COMPLETE, L.ACH_FISTFULOFLOVE_INCOMPLETE,
    { "Gnome WARLOCK", "Orc DEATHKNIGHT", "Human DEATHKNIGHT", "NightElf PRIEST", "Orc SHAMAN", "Tauren DRUID",
      "Scourge WARRIOR", "Troll ROGUE", "BloodElf MAGE", "Draenei PALADIN", "Dwarf HUNTER" }
  },
  LetItSnow = { "LetItSnow_flaked", L.ACH_LETITSNOW_COMPLETE, L.ACH_LETITSNOW_INCOMPLETE,
    { "Orc DEATHKNIGHT", "Human WARRIOR", "Tauren SHAMAN", "NightElf DRUID", "Scourge ROGUE", "Troll HUNTER",
      "Gnome MAGE", "Dwarf PALADIN", "BloodElf WARLOCK", "Draenei PRIEST" }
  },
  CheckYourHead = { "CheckYourHead_pumpkin", L.ACH_CHECKYOURHEAD_COMPLETE, L.ACH_CHECKYOURHEAD_INCOMPLETE,
    { "Gnome", "BloodElf", "Draenei", "Dwarf", "Human", "NightElf", "Orc", "Tauren", "Troll", "Scourge" }, true
  },
  TurkeyLurkey = { "TurkeyLurkey_feathered", L.ACH_TURKEYLURKEY_COMPLETE, L.ACH_TURKEYLURKEY_INCOMPLETE,
    { "BloodElf ROGUE", "Dwarf ROGUE", "Gnome ROGUE", "Human ROGUE", "NightElf ROGUE", "Orc ROGUE", "Troll ROGUE",
      "Scourge ROGUE" }
  },
  BunnyMaker = { "BunnyMaker_eared", L.ACH_BUNNYMAKER_COMPLETE, L.ACH_BUNNYMAKER_INCOMPLETE,
    { "BloodElf", "Draenei", "Dwarf", "Gnome", "Human", "NightElf", "Orc", "Tauren", "Troll", "Scourge" }, true,
    function(unit)
      if (UnitSex(unit) == 3) then
        local level = UnitLevel(unit)
        if (level >= 18 or level == -1) then  return true;  end
        -- Assumes that players 10 or more levels higher than you are at least level 18. (Though that's not necessarily
        -- the case, they generally would be.)
      end
    end
  },
};

local function RaceClassCheck(ach, tab, raceclass, race, unit)
  local id = OVERACHIEVER_ACHID[ach]
  if (select(4, GetAchievementInfo(id))) then
    RaceClassAch[ach] = nil;
    return;
  end
  local func = tab[6]
  if (func and not func(unit)) then  return;  end
  local text = tab[5] and race or raceclass
  for i,c in ipairs(tab[4]) do
    if (c == text) then
      local _, _, complete = GetAchievementCriteriaInfo(id, i)
      return id, complete and tab[2] or tab[3], complete
    end
  end
end

function Overachiever.ExamineSetUnit(tooltip)
  tooltip = tooltip or GameTooltip  -- Workaround since another addon is known to break this
  local name, unit = tooltip:GetUnit()
  if (not unit) then  return;  end
  local id, text, complete, needtipshow

  if (UnitIsPlayer(unit)) then
    local _, r, c = UnitRace(unit)
    _, c = UnitClass(unit)
    if (r and c) then
      local raceclass = r.." "..c
      for key,tab in pairs(RaceClassAch) do
        if (Overachiever_Settings[ tab[1] ]) then
          id, text, complete = RaceClassCheck(key, tab, raceclass, r, unit)
          if (text) then
            local r, g, b
            if (complete) then
              r, g, b = tooltip_complete.r, tooltip_complete.g, tooltip_complete.b
            else
              r, g, b = tooltip_incomplete.r, tooltip_incomplete.g, tooltip_incomplete.b
              PlayReminder()
              RecentReminders[id] = time()
            end
            tooltip:AddLine(text, r, g, b)
            tooltip:AddTexture(AchievementIcon)
            needtipshow = true
          end
        end
      end
    end

  elseif (name) then
    if (UnitCreatureType(unit) == L.CRITTER) then
      for key,tab in pairs(CritterAch) do
        if (Overachiever_Settings[ tab[1] ]) then
          id, text, complete = CritterCheck(key, name)
          if (text) then
            local r, g, b
            if (complete) then
              r, g, b = tooltip_complete.r, tooltip_complete.g, tooltip_complete.b
            else
              r, g, b = tooltip_incomplete.r, tooltip_incomplete.g, tooltip_incomplete.b
              PlayReminder()
              RecentReminders[id] = time()
            end
            tooltip:AddLine(text, r, g, b)
            tooltip:AddTexture(AchievementIcon)
            needtipshow = true
          end
        end
      end

    elseif (Overachiever_Settings.CreatureTip_killed and UnitCanAttack("player", unit)) then
      local guid = UnitGUID(unit)
      guid = tonumber( "0x"..strsub(guid, 8, 12) )
      local tab = Overachiever.AchLookup_kill[guid]
      if (tab) then
        local num, numincomplete, potential, _, achcom, c, t = 0, 0
        for i = 1, #tab, 2 do
          id = tab[i]
          _, _, _, achcom = GetAchievementInfo(id)
          if (not achcom) then
            num = num + 1
            _, _, c = GetAchievementCriteriaInfo(id, tab[i+1])
            if (not c) then
              numincomplete = numincomplete + 1
              potential = potential or {}
              potential[id] = i+1
            end
          end
        end

        if (num > 0) then
          if (numincomplete > 0) then
            local instype, heroic, twentyfive = Overachiever.GetDifficulty()
            if (instype) then
              local cat, t
              for id, crit in pairs(potential) do
                cat = GetAchievementCategory(id)
                if ((not heroic and (OVERACHIEVER_CATEGORY_HEROIC[cat] or (OVERACHIEVER_HEROIC_CRITERIA[id] and OVERACHIEVER_HEROIC_CRITERIA[id][crit])))
		    or (not twentyfive and OVERACHIEVER_CATEGORY_25[cat])) then
                  numincomplete = numincomplete - 1
                else
                  t = t or time()
                  RecentReminders[id] = t
                end
              end
            end
          end

          if (numincomplete <= 0) then
            text = L.KILL_COMPLETE
            r, g, b = tooltip_complete.r, tooltip_complete.g, tooltip_complete.b
          else
            text = L.KILL_INCOMPLETE
            r, g, b = tooltip_incomplete.r, tooltip_incomplete.g, tooltip_incomplete.b
            PlayReminder()
          end
          tooltip:AddLine(text, r, g, b)
          tooltip:AddTexture(AchievementIcon)
          needtipshow = true
        end
      end
    end
  end

  if (needtipshow) then  tooltip:Show();  end
end


-- WORLD OBJECT TOOLTIP HOOK
------------------------------

local WorldObjAch = {
  WellRead = { "WellReadTip_read", L.ACH_WELLREAD_COMPLETE, L.ACH_WELLREAD_INCOMPLETE },
  HigherLearning = { "WellReadTip_read", L.ACH_WELLREAD_COMPLETE, L.ACH_WELLREAD_INCOMPLETE },
  Scavenger = { "AnglerTip_fished", L.ACH_ANGLER_COMPLETE, L.ACH_ANGLER_INCOMPLETE, true },
  OutlandAngler = { "AnglerTip_fished", L.ACH_ANGLER_COMPLETE, L.ACH_ANGLER_INCOMPLETE, true },
  NorthrendAngler = { "AnglerTip_fished", L.ACH_ANGLER_COMPLETE, L.ACH_ANGLER_INCOMPLETE, true },
};

local function WorldObjCheck(ach, text)
  local id = OVERACHIEVER_ACHID[ach]
  if (select(4, GetAchievementInfo(id))) then
    WorldObjAch[ach] = nil;
    return;
  end
  local isCrit, complete = isCriteria(id, text)
  if (isCrit) then
    return id, complete and WorldObjAch[ach][2] or WorldObjAch[ach][3], complete, WorldObjAch[ach][4]
  end
end

function Overachiever.ExamineOneLiner(tooltip)
-- Unfortunately, we couldn't find a "GameTooltip:SetWorldObject" or similar type of thing, so we have to check for
-- these sorts of tooltips in a less direct way.
  tooltip = tooltip or GameTooltip  -- Workaround since another addon is known to break this
  if (tooltip:NumLines() == 1) then
    local n = tooltip:GetName()
    if (_G[n.."TextRight1"]:GetText()) then  return;  end
    local tiptext = _G[n.."TextLeft1"]:GetText()
    local id, text, complete, angler
    for key,tab in pairs(WorldObjAch) do
      if (Overachiever_Settings[ tab[1] ]) then
        id, text, complete, angler = WorldObjCheck(key, tiptext)
        if (text) then  break;  end
      end
    end
    if (text) then
      local r, g, b
      if (complete) then
        r, g, b = tooltip_complete.r, tooltip_complete.g, tooltip_complete.b
      else
        r, g, b = tooltip_incomplete.r, tooltip_incomplete.g, tooltip_incomplete.b
        RecentReminders[id] = time()
        if (not angler or not Overachiever_Settings.SoundAchIncomplete_AnglerCheckPole or
            not IsEquippedItemType("Fishing Poles")) then
          PlayReminder()
        end
      end
      tooltip:AddLine(text, r, g, b)
      tooltip:AddTexture(AchievementIcon)
      tooltip:Show()
    end
  end
end


-- ITEM TOOLTIP HOOK
-----------------------

local FoodCriteria, DrinkCriteria = {}, {}
local numDrinksConsumed, numFoodConsumed

--local lastitemTime, lastitemLink = 0

function Overachiever.BuildItemLookupTab()
  numDrinksConsumed = GetStatistic(OVERACHIEVER_ACHID.Stat_ConsumeDrinks)
  numFoodConsumed = GetStatistic(OVERACHIEVER_ACHID.Stat_ConsumeFood)

-- Build lookup tables (since examining the criteria each time is time-consuming)
  local foodID, drinkID = OVERACHIEVER_ACHID.TastesLikeChicken, OVERACHIEVER_ACHID.HappyHour
  
--[[  -- Tables are always built now because Blizzard's API doesn't track what is consumed. To be reliable,
      -- Overachiever needs to "see" what is consumed so from now on we'll always use the tracking table.
      -- (Variable ItemLookupTabBuilt is no longer used.)
  if ( ItemLookupTabBuilt or not Overachiever_Settings.Item_consumed or
       (not Overachiever_Settings.Item_consumed_whencomplete and select(4, GetAchievementInfo(foodID)) and
       select(4, GetAchievementInfo(drinkID))) ) then
  -- OLD: If the tables are built, or we don't add this info to tooltips, or we don't add this info to tooltips if
  -- the achievement is complete AND both achievements are complete, then do nothing.
    return;
  end
--]]

  Overachiever_CharVars_Consumed = Overachiever_CharVars_Consumed or {}
  Overachiever_CharVars_Consumed.Food = Overachiever_CharVars_Consumed.Food or {}
  Overachiever_CharVars_Consumed.Drink = Overachiever_CharVars_Consumed.Drink or {}
  local ConsumedFood, ConsumedDrink = Overachiever_CharVars_Consumed.Food, Overachiever_CharVars_Consumed.Drink

  local i, _, asset = 1
  _, _, _, _, _, _, _, asset = GetAchievementCriteriaInfo(foodID, i)
  while (asset) do -- while loop used because these are "hidden" criteria: GetAchievementNumCriteria returns only 1.
    FoodCriteria[asset] = ConsumedFood[asset] or 0
    i = i + 1
    _, _, _, _, _, _, _, asset = GetAchievementCriteriaInfo(foodID, i)
  end

  i = 1
  _, _, _, _, _, _, _, asset = GetAchievementCriteriaInfo(drinkID, i)
  while (asset) do
    DrinkCriteria[asset] = ConsumedDrink[asset] or 0
    i = i + 1
    _, _, _, _, _, _, _, asset = GetAchievementCriteriaInfo(drinkID, i)
  end
end

local LBI = LibStub:GetLibrary("LibBabble-Inventory-3.0"):GetLookupTable()

local ConsumeItemAch = {
  TastesLikeChicken = { "Item_consumed", L.ACH_CONSUME_COMPLETE, L.ACH_CONSUME_INCOMPLETE, L.ACH_CONSUME_INCOMPLETE_EXTRA, FoodCriteria },
  HappyHour = { "Item_consumed", L.ACH_CONSUME_COMPLETE, L.ACH_CONSUME_INCOMPLETE, L.ACH_CONSUME_INCOMPLETE_EXTRA, DrinkCriteria },
};

local function ItemConsumedCheck(ach, itemID)
  local id = OVERACHIEVER_ACHID[ach]
  ach = ConsumeItemAch[ach]
  local achcomplete = select(4, GetAchievementInfo(id))
  if (achcomplete and not Overachiever_Settings[ ach[1].."_whencomplete" ]) then
    return;
  end
  local isCrit = ach[5][itemID]
  if (isCrit) then
    local complete = isCrit == true
    return id, complete and ach[2] or achcomplete and ach[4] or ach[3], complete, achcomplete
  end
end

function Overachiever.ExamineItem(tooltip)
  tooltip = tooltip or this or GameTooltip  -- Workaround in case another addon breaks this
  local name, link = tooltip:GetItem() -- Issue: This doesn't reliably get the item we want?
  if (not link) then  return;  end
  -- Could check IsUsableItem(link) to see if it's something in your inventory..
  local itemMinLevel, itemType, subtype = select(5, GetItemInfo(link))
  if ((itemType == LBI["Consumable"] and (subtype == LBI["Food & Drink"] or subtype == LBI["Consumable"])) or
      (itemType == LBI["Trade Goods"] and subtype == LBI["Meat"])) then
    local _, _, itemID  = strfind(link, "item:(%d+)")
    itemID = tonumber(itemID)
    local id, text, complete, achcomplete
    for key,tab in pairs(ConsumeItemAch) do
      if (Overachiever_Settings[ tab[1] ]) then
        id, text, complete, achcomplete = ItemConsumedCheck(key, itemID)
        if (text) then  break;  end
      end
    end
    if (text) then
      local r, g, b
      if (complete) then
        r, g, b = tooltip_complete.r, tooltip_complete.g, tooltip_complete.b
      else
        r, g, b = tooltip_incomplete.r, tooltip_incomplete.g, tooltip_incomplete.b
        if (not achcomplete and tooltip == GameTooltip and itemMinLevel <= UnitLevel("player")) then
          -- Extra checks needed since the previous item sometimes shows up on the tooltip?
          PlayReminder()
          RecentReminders[id] = time()
        end
      end
      tooltip:AddLine(text, r, g, b)
      tooltip:AddTexture(AchievementIcon)
      tooltip:Show()
    end
  end
end

local function BagUpdate(...)
  local oldF, oldD = numFoodConsumed, numDrinksConsumed
  numFoodConsumed = GetStatistic(OVERACHIEVER_ACHID.Stat_ConsumeFood)
  numDrinksConsumed = GetStatistic(OVERACHIEVER_ACHID.Stat_ConsumeDrinks)

  local changeF, changeD = oldF < numFoodConsumed, oldD < numDrinksConsumed
  if (changeF or changeD) then
    local itemID, old, new
    for i=1,select("#", ...),3 do
      itemID, old, new = select(i, ...)
      --if (old > new) then
      if (changeF and FoodCriteria[itemID]) then
        --local _, link = GetItemInfo(itemID)
        --print("You ate:",link)
        FoodCriteria[itemID] = true
        Overachiever_CharVars_Consumed.Food[itemID] = true
      end
      if (changeD and DrinkCriteria[itemID]) then
        --local _, link = GetItemInfo(itemID)
        --print("You drank:",link)
        DrinkCriteria[itemID] = true
        Overachiever_CharVars_Consumed.Drink[itemID] = true
      end
      --end
    end
  end
end

TjBagWatch.RegisterFunc(BagUpdate, true)


-- Register some Blizzard sounds
-----------------------------------

if (SharedMedia) then
  local soundtab = {
  ["Sound\\Doodad\\BellTollAlliance.wav"] = L.SOUND_BELL_ALLIANCE,
  ["Sound\\Doodad\\BellTollHorde.wav"] = L.SOUND_BELL_HORDE,
  ["Sound\\Doodad\\BellTollNightElf.wav"] = L.SOUND_BELL_NIGHTELF,
  ["Sound\\Doodad\\BellTollTribal.wav"] = L.SOUND_DRUMHIT,
  ["Sound\\Doodad\\BoatDockedWarning.wav"] = L.SOUND_BELL_BOATARRIVED,
  ["Sound\\Doodad\\G_GongTroll01.wav"] = L.SOUND_GONG_TROLL,
  ["Sound\\Spells\\ShaysBell.wav"] = L.SOUND_BELL_MELLOW,

  ["Sound\\Spells\\PVPEnterQueue.wav"] = L.SOUND_ENTERQUEUE,
  ["Sound\\Spells\\bind2_Impact_Base.wav"] = L.SOUND_HEARTHBIND,
  ["Sound\\Doodad\\KharazahnBellToll.wav"] = L.SOUND_BELL_KARA,

  ["Sound\\Interface\\AuctionWindowOpen.wav"] = L.SOUND_DING_AUCTION,
  ["Sound\\Interface\\AuctionWindowClose.wav"] = L.SOUND_BELL_AUCTION,
  ["Sound\\Interface\\AlarmClockWarning1.wav"] = L.SOUND_ALARM1,
  ["Sound\\Interface\\AlarmClockWarning2.wav"] = L.SOUND_ALARM2,
  ["Sound\\Interface\\AlarmClockWarning3.wav"] = L.SOUND_ALARM3,
  ["Sound\\Interface\\MapPing.wav"] = L.SOUND_MAP_PING,

  ["Sound\\Spells\\SimonGame_Visual_GameTick.wav"] = L.SOUND_SIMON_DING,
  ["Sound\\Spells\\SimonGame_Visual_LevelStart.wav"] = L.SOUND_SIMON_STARTGAME,
  ["Sound\\Spells\\SimonGame_Visual_GameStart.wav"] = L.SOUND_SIMON_STARTLEVEL,

  ["Sound\\Spells\\YarrrrImpact.wav"] = L.SOUND_YAR,
  }
  for data,name in pairs(soundtab) do
    SharedMedia:Register("sound", "Blizzard: "..name, data)
  end
  soundtab = nil
end
