QuestHelper_File["director_achievement.lua"] = "1.4.1"
QuestHelper_Loadtime["director_achievement.lua"] = GetTime()

local debug_output = false
if QuestHelper_File["director_achievement.lua"] == "Development Version" then debug_output = true end

local achieveable = {}

local function IsDoable(id)
  if achieveable[id] == nil then
    -- First we just see if we have a DB entry for it
    -- This can be made *much* more efficient.
    if not DB_Ready() then
      print("DB not yet ready, please wait")
      return false
    end
    
    if DB_HasItem("achievement", id) then
      --print(id, "achieveable via db")
      achieveable[id] = true
      return true
    end
    
    local crit = GetAchievementNumCriteria(id)
    
    -- Whenever I write "crit" as a variable name it always slightly worries me.
    
    -- Y'see, several years ago I competed in a programming competition called Topcoder. At the end of a big tournament, if you did well, they flew you to a casino or a hotel and you competed against a bunch of other geeks, with your code posted on monitors. This was uncommonly boring unless you were a geek, but luckily, we were, so it was actually kind of exciting.
    -- So I'm up there competing, and I need a count, so I make a variable called "cont". "count", y'see, is a function, so I can't use that. But then I need another one. I can't go with "cout" because that's actually a global variable in C++, which is what I'm using. And, well, I want to keep the first and last letters preserved, because that way it reminds me it's a count.
    
    -- So I start typing the first thing that comes to mind that fulfills all the requirements.
    
    -- Luckily, I stop myself in time, and write "cnt" instead.
    
    -- Once or twice in QuestHelper I've needed a few variables about criteria. And there's . . . something . . . which is only one letter off from "crit", and is something I should probably not be typing in publicly accessible sourcecode.
  
    -- So now you know. Back to the code.
    
    -- (although let's be honest with the amount of profanity scattered throughout this codebase I'm not quite sure why I care buuuuuuuuuut here we are anyway)
    
    if crit > 0 then
      for i = 1, crit do
        local _, typ, _, _, _, _, _, asset, _, cid = GetAchievementCriteriaInfo(id, i)
        if typ == 0 then
          -- Monster kill. We're good! We can do these.
        elseif typ == 8 then
          -- Achievement chain
          if not IsDoable(asset) then
            achieveable[id] = false
            break
          end
        else
          achieveable[id] = false
          break
        end
      end
      
      if achieveable[id] == nil then
        --print(id, "achieveable via occlusion")
        achieveable[id] = true
      end
    else
      --print(id, "not achieveable due to wizard casting what the fuck")
      achieveable[id] = false
    end
  end
  
  return achieveable[id]
end

local function GetListOfAchievements(category)
  local ct = GetCategoryNumAchievements(category)
  
  local available_achieves = {}
  
  for i = 1, ct do
    local id, _, _, complete = GetAchievementInfo(category, i)
    if not complete and IsDoable(id) then
      table.insert(available_achieves, i)
    end
  end
  
  return available_achieves
end

local function FilterFunction(category)
  local aa = GetListOfAchievements(category)
  
  return #aa, 0, 0
end

local function SetQHVis(button, ach, _, _, complete)
  button.qh_checkbox:Hide()
  if complete or not IsDoable(ach) then
    button.qh_checkbox:Hide()
  else
    button.qh_checkbox:Show()
  end
end

local ABDA_permit
local ABDA
local function ABDA_Replacement(button, category, achievement, selectionID)
  -- hee hee hee
  -- i am sneaky like fish
  -- *sneaky* fish
  -- ^__^
  
  if ABDA_permit and ACHIEVEMENTUI_SELECTEDFILTER == FilterFunction then
    local aa = GetListOfAchievements(category)
    local ach = aa[achievement]
    ABDA(button, category, ach, selectionID)
    SetQHVis(button, GetAchievementInfo(category, ach))
  else
    ABDA(button, category, achievement, selectionID)
    SetQHVis(button, GetAchievementInfo(category, achievement))
  end
end

local AFAU
local function AFAU_Replacement(...)
  ABDA_permit = true
  AFAU(...)
  ABDA_permit = false
end

local TrackedAchievements = {}
local MetaAchievements = {}
local Update_Objectives

local function MarkAchieveable(id, setto)
  TrackedAchievements[id] = setto
  
  local crit = GetAchievementNumCriteria(id)
  for i = 1, crit do
    local _, typ, _, _, _, _, _, asset, _, cid = GetAchievementCriteriaInfo(id, i)
    if typ == 8 then
      MetaAchievements[id] = true
      MarkAchieveable(asset, setto)
    end
  end
end

local check_onshow

function QH_COC_GIX(id)
  MarkAchieveable(id, true)
  Update_Objectives()
end

local function check_onclick(self)
  if self:GetChecked() then
    MarkAchieveable(self:GetParent().id, true)
  else
    MarkAchieveable(self:GetParent().id, nil)
  end
  Update_Objectives()
  
  for i = 1, #AchievementFrameAchievements.buttons do
    check_onshow(AchievementFrameAchievements.buttons[i].qh_checkbox)
  end
end

local function check_onenter(self)
  GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
  GameTooltip:SetText(QHText("ACHIEVEMENT_CHECKBOX"))
end
local function check_onleave(self)
  GameTooltip:Hide()
end
function check_onshow(self)
  self:SetChecked(TrackedAchievements[self:GetParent().id])
end

local AAFOC = AchievementAlertFrame_OnClick
function AAF_onclick(self)
	if not self.id then return end

	local _, _, _, complete = GetAchievementInfo(self.id);
	if complete and ACHIEVEMENTUI_SELECTEDFILTER == FilterFunction then -- yipyipyipyipyipyipyip
		AchievementFrame_SetFilter(ACHIEVEMENT_FILTER_ALL) -- uh-huh, uh-huh
  end
  
  AAFOC(self)
end
AchievementAlertFrame_OnClick = AAF_onclick

QH_Event("ADDON_LOADED", function (addonid)
  if addonid == "Blizzard_AchievementUI" then
    -- yyyyyyoink
    table.insert(AchievementFrameFilters, {text="QuestHelpable", func=FilterFunction})
    
    ABDA = AchievementButton_DisplayAchievement
    AchievementButton_DisplayAchievement = ABDA_Replacement
    
    AFAU = AchievementFrameAchievements_Update
    AchievementFrameAchievements_Update = AFAU_Replacement
    AchievementFrameAchievementsContainer.update = AFAU_Replacement
    ACHIEVEMENT_FUNCTIONS.updateFunc = AFAU_Replacement
    
    for i = 1, #AchievementFrameAchievements.buttons do
      local framix = CreateFrame("CheckButton", "qh_arglbargl_" .. i, AchievementFrameAchievements.buttons[i], "AchievementCheckButtonTemplate")
      framix:SetPoint("BOTTOMRIGHT", AchievementFrameAchievements.buttons[i], "BOTTOMRIGHT", -22, 7.5)
      framix:SetScript("OnEnter", check_onenter)
      framix:SetScript("OnLeave", check_onleave)
      
      framix:SetScript("OnShow", check_onshow)
      framix:SetScript("OnClick", check_onclick)
      
      _G["qh_arglbargl_" .. i .. "Text"]:Hide() -- no
      
      local sigil = framix:CreateTexture("BACKGROUND")
      sigil:SetHeight(24)
      sigil:SetWidth(24)
      sigil:SetTexture("Interface\\AddOns\\QuestHelper\\sigil")
      sigil:SetPoint("RIGHT", framix, "LEFT", -1, 0)
      sigil:SetVertexColor(0.6, 0.6, 0.6)
      
      AchievementFrameAchievements.buttons[i].qh_checkbox = framix
    end
  end
end)


local function horribledupe(from)
  if not from then return nil end
  
  local rv = {}
  for k, v in pairs(from) do
    if k == "__owner" then
    elseif type(v) == "table" then
      rv[k] = horribledupe(v)
    else
      rv[k] = v
    end
  end
  return rv
end

local achievement_list = setmetatable({}, {__mode="k"})
function GetAchievementMetaObjective(achievement)
  if achievement_list[achievement] then return achievement_list[achievement] end
  
  local db = DB_GetItem("achievement", achievement, true)
  
  local ite = {}
  ite.desc = select(2, GetAchievementInfo(achievement))
  ite.tracker_desc = ite.desc
  ite.tracker_split = true
  
  local itlist = {}
  if db and db.achieved then
    table.insert(itlist, {cid = "achieved", chunk = db.achieved})
  else
    local crit = GetAchievementNumCriteria(achievement)
    
    for i = 1, crit do
      local name, typ, _, _, _, _, _, asset, _, cid = GetAchievementCriteriaInfo(achievement, i)
      
      --[[ assert(cid) ]]
      
      local chunk
      local split
      if typ == 0 then
        chunk = DB_GetItem("monster", asset)
        split = true
      else
        --[[ assert(db) ]]
        chunk = db[cid]
      end
      
      if split then
        local soldupe = horribledupe(chunk.solid)
        for i = 1, #chunk.loc do
          table.insert(itlist, {cid = cid, solid = soldupe, loc = chunk.loc[i], name = name})
        end
      else
        table.insert(itlist, {cid = cid, chunk = chunk, name = name})
      end
    end
  end
  
  for _, data in pairs(itlist) do
    local ttx = {}
    
    if data.chunk then
      ttx.solid = horribledupe(data.chunk.solid)
      if data.chunk.loc then for _, v in ipairs(data.chunk.loc) do
        table.insert(ttx, {loc = {x = v.x, y = v.y, c = QuestHelper_ParentLookup[v.p], p = v.p}})
      end end
    end
    
    if data.loc then
      ttx.solid = data.solid
      table.insert(ttx, {loc = {x = data.loc.x, y = data.loc.y, c = QuestHelper_ParentLookup[data.loc.p], p = data.loc.p}})
    end
    
    if #ttx == 0 then
      table.insert(ttx, {loc = {x = 5000, y = 5000, c = 0, p = 2}, icon_id = 7, type_quest_unknown = true})  -- this is Ashenvale, for no particularly good reason
      ttx.type_achievement_unknown = true
    end
    
    for _, v in ipairs(ttx) do
      v.map_desc = {ite.desc, data.name}
      v.tracker_desc = data.name or ite.desc
      v.tracker_hide_dupes = true
      v.hidden_desc = data.name and string.format("%s: %s", ite.desc, data.name) or ite.desc
      v.arrow_desc = v.hidden_desc
      if not data.name then v.tracker_hidden = true end
      v.cluster = ttx
      v.why = ite
      v.icon_id = 17
    end
    
    if not ite[data.cid] then
      ite[data.cid] = {}
    end
    
    table.insert(ite[data.cid], ttx)
  end
  
  achievement_list[achievement] = ite
  
  return achievement_list[achievement]
end

local function achievement_is_unified(ach)
  return GetAchievementMetaObjective(ach).achieved
end


local current_aches = {}
local next_aches = {}

local ach_locational = {}

local function AchUpdateStart()
  next_aches = {}
end
local function AchUpdateAdd(ach, crit)
  if not next_aches[ach] then next_aches[ach] = {} end
  next_aches[ach][crit] = true  
end
local function AchUpdateEnd()
  --print("aue")
  for k, v in pairs(current_aches) do
    for c in pairs(v) do
      if not next_aches[k] or not next_aches[k][c] then
        local meta = GetAchievementMetaObjective(k)
        
        for i = 1, #meta[c] do
          QH_Route_ClusterRemove(meta[c][i])
          
          for _, nod in ipairs(meta[c][i]) do
            ach_locational[nod.loc] = nil
          end
        end
      end
    end
  end
  
  for k, v in pairs(next_aches) do
    for c in pairs(v) do
      local kacey = nil
      if not current_aches[k] or not current_aches[k][c] then
        local meta = GetAchievementMetaObjective(k)
        
        for i = 1, #meta[c] do
          QH_Route_ClusterAdd(meta[c][i])
          
          for _, nod in ipairs(meta[c][i]) do
            if not ach_locational[nod.loc] then
              if not kacey then
                kacey = QuestHelper:CreateTable("ach_locational")
                kacey.k = k
                kacey.c = c
              end
              --print(nod.loc.p, nod.loc.x, nod.loc.y)
              ach_locational[nod.loc] = kacey
            end
          end
        end
      end
    end
  end
  
  current_aches = next_aches  -- yaaaaaaaay
end

function qh_critupd()
  --print("critup")
  
  local c, z, x, y = QuestHelper.routing_c, QuestHelper.routing_z, QuestHelper.routing_ax, QuestHelper.routing_ay
  --print(c, z, x, y)
  if not c or not z or not x or not y then return end
  
  local p = QuestHelper_IndexLookup[c][z]
  --print(p)
  if not p then return end
  
  local closest_dist = 1000000000000
  local closest_item = nil
  for k, v in pairs(ach_locational) do
    if k.p == p then
      local dx, dy = x - k.x, y - k.y
      dx, dy = dx * dx, dy * dy
      local dd = dx + dy
      if dd < closest_dist then
        closest_dist = dd
        closest_item = v
      end
    end
  end
  
  --print(closest_item)
  if not closest_item then return end -- bort bort bort
  local k, c = closest_item.k, closest_item.c
  --print(k, c)
  if not (type(k) == "number" and type(c) == "number") then return end
  
  local _, _, crit_complete = GetAchievementCriteriaInfo(c)
  --print(crit_complete)
  if not crit_complete then return end -- welp
  
  --print("desplicing", k, c)
  --[[ assert(current_aches[k][c]) ]]
  -- hey we found it gee jay
  current_aches[k][c] = nil
  local meta = GetAchievementMetaObjective(k)
  
  for i = 1, #meta[c] do
    QH_Route_ClusterRemove(meta[c][i])
    for _, nod in ipairs(meta[c][i]) do
      ach_locational[nod.loc] = nil
    end
  end
end
QH_Event("CRITERIA_UPDATE", qh_critupd)



local db
function Update_Objectives(_, new)
  if not new then new = db end  -- sometimes we're just told to update thanks to a change in checkmarks, and this is the easiest way to keep a DB around
  db = new
  --print("uobj", new)
  if not new then QH_AchievementManagerRegister_Poke() return end
  
  AchUpdateStart()
  
  local oblit = {}
  for k in pairs(TrackedAchievements) do
    --print("updating achievement", k)
    
    if not MetaAchievements[k] then
      local achid = new.achievements[k]
      if not achid then print(k) end
      
      if achid.complete then
        oblit[k] = true
      else
        if achievement_is_unified(k) then
          AchUpdateAdd(k, "achieved")
        else
          local critcount = GetAchievementNumCriteria(k)
          for i = 1, critcount do
            local _, _, _, _, _, _, _, _, _, crit = GetAchievementCriteriaInfo(k, i)
            
            if not new.criteria[crit].complete then
              AchUpdateAdd(k, crit)
            end
          end
        end
      end
    end
  end
  
  for k in pairs(oblit) do
    TrackedAchievements[k] = nil
  end
  
  AchUpdateEnd()
end

QH_AchievementManagerRegister(Update_Objectives)
QH_AchievementManagerRegister_Poke()
