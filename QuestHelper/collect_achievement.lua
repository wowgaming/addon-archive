QuestHelper_File["collect_achievement.lua"] = "1.4.1"
QuestHelper_Loadtime["collect_achievement.lua"] = GetTime()

local QHCA

local GetLoc
local Merger

local cloc

local function ScanAchievements(oldADB, newADB)
  --QuestHelper:TextOut("scanach")
  local changes = 0
  for k, v in pairs(newADB.achievements) do
    if v.complete ~= oldADB.achievements[k].complete then
      changes = changes + 1
    end
  end
  for k, v in pairs(newADB.criteria) do
    if v.complete and not oldADB.criteria[k].complete then
      changes = changes + 1
    end
  end
  
  if changes < 10 then -- if someone gets 10 criteria at once, well, I guess that's just what happens
    for k, v in pairs(newADB.achievements) do
      if v.complete ~= oldADB.achievements[k].complete then
        QuestHelper: Assert(v.complete and not oldADB.achievements[k].complete)
        if not QHCA[k] then QHCA[k] = {} end
        QHCA[k].achieved = (QHCA[k].achieved or "") .. cloc
        
        --QuestHelper:TextOut(string.format("Achievement complete, %s", select(2, GetAchievementInfo(k))))
      end
    end
    
    for k, v in pairs(newADB.criteria) do
      if v.complete and not oldADB.criteria[k].complete then  -- Note that it's possible for objectives to be "uncompleted" when it's things like "do a bunch of shit in one run of this battleground" (see: isle of conquest)
        --QuestHelper:TextOut(string.format("Criteria complete, %d", k))
        --QuestHelper:TextOut(string.format("Criteria complete, %s", select(1, GetAchievementCriteriaInfo(k))))
        if not QHCA[v.parent] then QHCA[v.parent] = {} end
        QHCA[v.parent][k] = (QHCA[v.parent][k] or "") .. cloc
      elseif v.progress > oldADB.criteria[k].progress then
        --QuestHelper:TextOut(string.format("Criteria progress, %d", k))
        --QuestHelper:TextOut(string.format("Criteria progress, %s", select(1, GetAchievementCriteriaInfo(k))))
      end
    end
  end
end

function SetCloc()
  cloc = GetLoc() -- yoink
end

function QH_Collect_Achievement_Init(QHCData, API)
  if not QHCData.achievement then QHCData.achievement = {} end
  QHCA = QHCData.achievement
  
  GetLoc = API.Callback_LocationBolusCurrent
  QuestHelper: Assert(GetLoc)
  
  Merger = API.Utility_Merger
  QuestHelper: Assert(Merger)
  
  QH_AchievementManagerRegister(ScanAchievements)
  QH_AchievementManagerRegister_Prescan(SetCloc)
  
  QH_AchievementManager_Init()
end
