QuestHelper_File["manager_achievement.lua"] = "1.4.1"
QuestHelper_Loadtime["manager_achievement.lua"] = GetTime()

local AchievementDB

-- 0 is a monster kill, asset is the monster ID
--X 1 is winning PvP objectives in a thorough manner (holding all bases, controlling all flags)
--X 7 is weapon skill, asset is probably a skill ID of some sort
--X 8 is another achievement, asset is achievement ID
--X 9 is completing quests globally
--X 10 is completing a daily quest every day
--X 11 is completing quests in specific areas
--X 14 is completing daily quests
-- 27 is a quest, asset is quest ID
--X 28 is getting a spell cast on you, asset is a spell ID
--X 29 is casting a spell (often crafting), asset is a spell ID
--X 30 is PvP objectives (flags, assaulting, defending)
--X 31 is PvP kills in battleground PvP locations
--X 32 is winning ranked arena matches in specific locations (asset is probably a location ID)
--X 34 is the Squashling (owning a specific pet?), asset is the spell ID
--X 35 is PvP kills while under the influence of something
--X 36 is acquiring items (soulbound), asset is an item ID
--X 37 is winning arenas
--X 41 is eating or drinking a specific item, asset is item ID
--X 42 is fishing things up, asset is item ID
-- 43 is exploration, asset is a location ID?
--X 45 is purchasing 7 bank slots
--X 46 is exalted rep, asset is presumably some kind of faction ID
--X 47 is 5 reputations to exalted
--X 49 is equipping items, asset is a slot ID (quality is presumably encoded into flags)
--X 52 is killing specific classes of player
--X 53 is kill-a-given-race, asset is race ID?
-- 54 is using emotes on targets, asset ID is likely the emote ID
--X 56 is being a wrecking ball in Alterac Valley
--X 62 is getting gold from quest rewards
--X 67 is looting gold
-- 68 is reading books
-- 70 is killing players in world PvP locations
-- 72 is fishing things from schools or wreckage
--X 73 is killing Mal'Ganis on Heroic. Why? Who can say.
--X 75 is obtaining mounts
-- 109 is fishing, either in general or in specific locations
-- 110 is casting spells on specific targets, asset ID is the spell ID
--X 112 is learning cooking recipes
--X 113 is honorable kills
local achievement_type_blacklist = {}
for _, v in pairs({1, 7, 8, 9, 10, 11, 14, 28, 29, 30, 31, 32, 34, 35, 36, 37, 41, 42, 46, 47, 49, 52, 53, 56, 62, 67, 73, 75, 112, 113}) do
  achievement_type_blacklist[v] = true
end

local achievement_list = {}

--local crittypes = {}
--QuestHelper_ZorbaForgotToRemoveThis = {}

local qhdinfo = false
local qhdinfodump = {}
local function qhadumpy()
  for k, v in pairs(qhdinfodump) do
    local ct = 0
    local some
    for tk, tv in pairs(v) do
      ct = ct + 1
      some = tk
    end
    QuestHelper:TextOut(string.format("%d: %d, %s", k, ct, some))
  end
end

local function registerAchievement(id)
  --if db.achievements[id] then return end
  QuestHelper: Assert(id)
  if id < 0 then return end -- stupid underachiever
  
  local _, title, _, complete = GetAchievementInfo(id)
  --QuestHelper:TextOut(string.format("Registering %d (%s)", id, title))
  local prev = GetPreviousAchievement(id)
  local record = false
  
  --[[
  db.achievements[id] = {
    previous = prev,
    compete = complete,
    name = title,
    criterialist = {}
  }
  local dbi = db.achievements[id]
  ]]
  
  if prev then
    registerAchievement(prev)
  end
    
  local critcount = GetAchievementNumCriteria(id)
  if critcount == 0 then record = true end
  
  for i = 1, critcount do
    local crit_name, crit_type, crit_complete, crit_quantity, crit_reqquantity, _, _, crit_asset, _, crit_id = GetAchievementCriteriaInfo(id, i)
    
    if qhdinfo and not achievement_type_blacklist[crit_type] then
      if not qhdinfodump[crit_type] then qhdinfodump[crit_type] = {} end
      qhdinfodump[crit_type][title .. " --- " .. crit_name] = true
    end
    
    --[[
    table.insert(dbi.criterialist, crit_id)
    ass ert (not db.criteria[crit_id])
    crittypes[crit_type] = (crittypes[crit_type] or 0) + 1]]
    
    if not achievement_type_blacklist[crit_type] then record = true end
    
    --[[
    db.criteria[crit_id] = {
      name = crit_name,
      type = crit_type,
      complete = crit_complete,
      progress = crit_quantity,
      progress_total = crit_reqquantity,
      asset = crit_asset,
    }]]
  end
  
  if record then achievement_list[id] = true end
end

local function createAchievementList()
  for _, catid in pairs(GetCategoryList()) do
    for d = 1, GetCategoryNumAchievements(catid) do
      --if GetAchievementInfo(catid, d) == 2557 then print("loading tffs") end
      --if GetAchievementInfo(catid, d) == 1312 then print("loading otot") end
      
      registerAchievement(GetAchievementInfo(catid, d), db)
        ----[[ assert(AchievementDB.achievements[2557]) ]]
  ----[[ assert(AchievementDB.achievements[1312]) ]] -- what what
    end
  end
end

qh_cal = createAchievementList

local achievement_stop_time = 0

local GetAchievementInfo = GetAchievementInfo
local GetAchievementNumCriteria = GetAchievementNumCriteria
local GetAchievementCriteriaInfo = GetAchievementCriteriaInfo

local function retrieveAchievement(id, db)
  QH_Timeslice_Yield()

  local _, _, _, complete = GetAchievementInfo(id)
  --QuestHelper:TextOut(string.format("Registering %d (%s)", id, title))
  
  db.achievements[id] = QuestHelper:CreateTable("collect_achievement achievement")
  db.achievements[id].complete = complete
  
  local dbi = db.achievements[id]
  
  local critcount = GetAchievementNumCriteria(id)
  QuestHelper: Assert(critcount, "critcount nil " .. tostring(id))
  
  --QuestHelper:TextOut(string.format("%d criteria", crit))
  for i = 1, critcount do
    QuestHelper: Assert(not db.criteria[crit_id])
    local _, _, crit_complete, crit_quantity, crit_reqquantity, _, _, _, _, crit_id = GetAchievementCriteriaInfo(id, i)

    db.criteria[crit_id] = QuestHelper:CreateTable("collect_achievement criteria")
    db.criteria[crit_id].complete = crit_complete
    db.criteria[crit_id].progress = crit_quantity
    db.criteria[crit_id].parent = id
  end
end

local function getAchievementDB()
  local db = {}
  db.achievements = {}
  db.criteria = {}
  
  local ct = 0
  for k in pairs(achievement_list) do
    retrieveAchievement(k, db)
    ct = ct + 1
  end
  --QuestHelper: TextOut(tostring(ct))
  
  return db
end


local registered = {}
local prescan = {}

function QH_AchievementManagerRegister(funky) -- I am imagining "funky" being said in the same tone of voice that "spicy" is in Puzzle Pirates
  table.insert(registered, funky)
end
function QH_AchievementManagerRegister_Prescan(funky)
  table.insert(prescan, funky)
end

local updating = false
local updating_continue = false

local function ScanAchievements()
  while updating_continue do
    updating_continue = false
    
    for _, v in ipairs(prescan) do
      v()
    end
    
    local old = AchievementDB
    local new = getAchievementDB()
    
    for _, v in ipairs(registered) do
      v(old, new)
    end
    
    AchievementDB = new
    
    for k, v in pairs(old.achievements) do QuestHelper:ReleaseTable(v) end
    for k, v in pairs(old.criteria) do QuestHelper:ReleaseTable(v) end
  end
  
  updating = false
end

local function OnEvent()
  --print("oe", updating, AchievementDB)
  if not updating and AchievementDB then
    --print("cutea")
    QH_Timeslice_Add(ScanAchievements, "criteria")
    updating = true
  end
  updating_continue = true
end
--qhaach = OnEvent
  
QH_Event("CRITERIA_UPDATE", OnEvent)
QH_Event("ACHIEVEMENT_EARNED", OnEvent)

function QH_AchievementManagerRegister_Poke()
  OnEvent()
end

function QH_AchievementManager_Init()
  createAchievementList()
  
  AchievementDB = getAchievementDB() -- 'coz we're lazy
  ----[[ assert(AchievementDB.achievements[2556]) ]]
  ----[[ assert(AchievementDB.achievements[2557]) ]]
  ----[[ assert(AchievementDB.achievements[1312]) ]] -- what what
  
  for _, v in ipairs(registered) do -- basically initting everything linked to this
    v(AchievementDB, AchievementDB)
  end
end


if QuestHelper_File["manager_achievement.lua"] == "Development Version" then
  -- woop woop woop
  -- runnin' around like a headless chicken
  -- collidin' with walls
  -- fallin' over backwards, waving arms wildly
  -- little bit of drool
  -- you know how it goes
  
  local the_data
  
  local function eatAchievement(id)
    local _, title, _, complete = GetAchievementInfo(id)
    --QuestHelper:TextOut(string.format("Registering %d (%s)", id, title))
    local prev = GetPreviousAchievement(id)
    local record = false
    
    
    if prev then
      registerAchievement(prev)
    end
      
    local critcount = GetAchievementNumCriteria(id)
    
    the_data[id] = {name = title}
    
    for i = 1, critcount do
      local _, crit_type, _, _, _, _, _, crit_asset, _, crit_id = GetAchievementCriteriaInfo(id, i)
      table.insert(the_data[id], {cid = crit_id, type = crit_type, asset = crit_asset})
    end
  end
  
  function dump_the_data_zorba_needs()
    the_data = {}
    QuestHelper_Errors.achievement_cruft = the_data
    
    for _, catid in pairs(GetCategoryList()) do
      for d = 1, GetCategoryNumAchievements(catid) do
        eatAchievement(GetAchievementInfo(catid, d))
      end
    end
  end
  
  function dump_crits(id)
    local critcount = GetAchievementNumCriteria(id)
    print(string.format("%d criteria (%s)", critcount, tostring(achievement_list[id])))
  
    for i = 1, critcount do
      local _, crit_type = GetAchievementCriteriaInfo(id, i)
      print(string.format("%d: %d", i, crit_type))
    end
  end
end
