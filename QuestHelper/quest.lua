QuestHelper_File["quest.lua"] = "1.4.1"
QuestHelper_Loadtime["quest.lua"] = GetTime()

do return end

local function QuestKnown(self)
  if not self.target and not self.destination then
    if self.o.finish then
      self.target = self.qh:GetObjective("monster", self.o.finish)
    elseif self.fb.finish then 
      self.target = self.qh:GetObjective("monster", self.fb.finish)
    elseif self.o.pos then
      self.destination = self.o.pos
    elseif self.fb.pos then
      self.destination = self.fb.pos
    end
  end
  return (self.target or self.destination) and self:DefaultKnown() and (self.destination or self.target:Known())
end

local function QuestAppendPositions(self, objective, weight, why, restrict)
  why2 = why and why.."\n" or ""

  if self.target then
    self.target:AppendPositions(self, 1, why2..QHFormat("OBJECTIVE_TALK", self.o.finish or self.fb.finish), restrict)
  elseif self.destination then
    for i, p in ipairs(self.destination) do
      if not restrict or not self.qh:Disallowed(p[1]) then
        self:AddLoc(p[1], p[2], p[3], p[4], p[5])
      end
    end
  end
end

QuestHelper.default_objective_quest_param =
 {
  Known = QuestKnown,
  AppendPositions = QuestAppendPositions
 }

for key, value in pairs(QuestHelper.default_objective_param) do
  if not QuestHelper.default_objective_quest_param[key] then
    QuestHelper.default_objective_quest_param[key] = value
  end
end

QuestHelper.default_objective_quest_meta = { __index = QuestHelper.default_objective_quest_param }

function QuestHelper:GetQuest(name, level, hash)
  if not level then
    if QuestHelper_Quests_Local[self.faction] then
      for l, quest_list in ipairs(QuestHelper_Quests_Local[self.faction]) do
        if quest_list[name] then
          level = l
          break
        end
      end
    end
    
    if not level and 
       QuestHelper_StaticData[self.locale] and
       QuestHelper_StaticData[self.locale].quest[self.faction] then
     for l, quest_list in ipairs(QuestHelper_StaticData[self.locale].quest[self.faction]) do
        if quest_list[name] then
          level = l
          break
        end
      end
    end
    
    if not level then
      error("Don't know of a quest named '"..name.."' for your faction.")
    end
    
    self:TextOut("Determined the quest level of '"..name.."' to be "..level..".")
  end
  
  local bracket = self.quest_objects[level]
  
  if not bracket then
    bracket = {}
    self.quest_objects[level] = bracket
  end
  
  local bracket2 = bracket[name]
  
  if not bracket2 then
    bracket2 = {}
    bracket[name] = bracket2
  end
  
  local quest_object = bracket2[hash or -1]
  
  if not quest_object then
    quest_object = self:NewObjectiveObject()
    quest_object.icon_id = 7
    quest_object.icon_bg = 15
    setmetatable(quest_object, QuestHelper.default_objective_quest_meta)
    
    quest_object.cat = "quest"
    quest_object.obj = level.."/"..(hash or "").."/"..name
    
    bracket2[hash or -1] = quest_object
    
    local fbracket = QuestHelper_Quests_Local[self.faction]
    
    if not fbracket then
      fbracket = {}
      QuestHelper_Quests_Local[self.faction] = fbracket
    end
    
    bracket = fbracket[level]
    
    if not bracket then
      bracket = {}
      fbracket[level] = bracket
    end
    
    quest_object.o = bracket[name]
    
    if not quest_object.o then
      if hash then
        quest_object.o = {hash=hash}
        bracket[name] = quest_object.o
      else -- Not going to actually save the quest without a hash.
        quest_object.o = {}
      end
    end
    
    local l = QuestHelper_StaticData[self.locale]
    
    if l then
      fbracket = l.quest[self.faction]
      if fbracket then
        bracket = fbracket[level]
        if bracket then
          quest_object.fb = bracket[name]
        end
      end
    end
    if not quest_object.fb then
      quest_object.fb = {}
    end
    
    if quest_object.o.hash and quest_object.o.hash ~= hash then
      if not quest_object.o.alt then quest_object.o.alt = {} end
      local real_quest_data = quest_object.o.alt[hash]
      if not real_quest_data then
        real_quest_data = {hash=hash}
        quest_object.o.alt[hash] = real_quest_data
      end
      quest_object.o = real_quest_data
    elseif not quest_object.o.hash then
      -- Not setting the hash now, as we might not actually have the correct quest loaded.
      -- When we can verify our data is correct, we'll assign a value.
      quest_object.need_hash = true
    end
    
    if hash and quest_object.fb.hash and quest_object.fb.hash ~= hash then
      quest_object.fb = quest_object.fb.alt and quest_object.fb.alt[hash]
      if not quest_object.fb then
        quest_object.fb = {}
      end
    end
    
    -- TODO: If we have some other source of information (like LightHeaded) add its data to quest_object.fb
    
  end
  
  return quest_object
end

function QuestHelper:PurgeItemFromQuest(quest, item_name, item_object)
  if quest.alt then
    for hash, alt_quest in pairs(quest.alt) do
      self:PurgeItemFromQuest(alt_quest, item_name, item_object)
    end
  end
  
  if quest.item then
    local item_data = quest.item[item_name]
    if item_data then
      quest.item[item_name] = nil
      if not next(quest.item, nil) then quest.item = nil end
      
      if item_data.pos then
        for i, pos in ipairs(item_data.pos) do
          self:AppendObjectivePosition(item_object, unpack(pos))
        end
      else
        if item_data.drop then
          for monster, count in pairs(item_data.drop) do
            self:AppendObjectiveDrop(item_object, monster, count)
          end
        end
        
        if item_data.contained then
          for item, count in pairs(item_data.contained) do
            self:AppendItemObjectiveContained(item_object, item, count)
          end
        end
      end
      
      if item_object.bad_pos then
        for i, pos in ipairs(item_object.bad_pos) do
          self:AppendObjectivePosition(item_object, unpack(pos))
        end
        item_object.bad_pos = nil
      elseif item_object.bad_drop then
        for monster, count in pairs(item_object.bad_drop) do
          self:AppendObjectiveDrop(item_object, monster, count)
        end
        item_object.bad_drop = nil
      end
    end
  end
end

function QuestHelper:PurgeQuestItem(item_name, item_object)
  for faction, level_list in pairs(QuestHelper_Quests_Local) do
    for level, quest_list in pairs(level_list) do
      for quest_name, quest in pairs(quest_list) do
        self:PurgeItemFromQuest(quest, item_name, item_object)
      end
    end
  end
end

function QuestHelper:AppendQuestPosition(quest, item_name, i, x, y, w)
  local item_list = quest.o.item
  
  if not item_list then
    item_list = {}
    quest.o.item = item_list
  end
  
  local item = item_list[item_name]
  
  if not item then
    item = {}
    item_list[item_name] = item
  end
  
  local pos = item.pos
  if not pos then
    if item.drop then
      return -- If it's dropped by a monster, don't record the position we got the item at.
    end
    item.pos = self:AppendPosition({}, i, x, y, w)
  else
    self:AppendPosition(pos, i, x, y, w)
  end
end

function QuestHelper:AppendQuestDrop(quest, item_name, monster_name, count)
  local item_list = quest.o.item
  
  if not item_list then
    item_list = {}
    quest.o.item = item_list
  end
  
  local item = item_list[item_name]
  
  if not item then
    item = {}
    item_list[item_name] = item
  end
  
  local drop = item.drop
  
  if drop then
    drop[monster_name] = (drop[monster_name] or 0) + (count or 1)
  else
    item.drop = {[monster_name] = count or 1}
    item.pos = nil -- If we know monsters drop the item, don't record the position we got the item at.
  end
end

