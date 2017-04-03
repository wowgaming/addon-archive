QuestHelper_File["collect_upgrade.lua"] = "1.4.1"
QuestHelper_Loadtime["collect_upgrade.lua"] = GetTime()

function QH_Collector_Upgrade(chunk)
  QuestHelper: Assert(not chunk.compressed)
  
  if chunk.version == 1 then
    -- We basically just want to clobber all our old route data, it's not worth storing - it's all good data, it's just that we don't want to preserve relics of the old location system.
    chunk.traveled = nil
    
    chunk.version = 2
  end
  
  if chunk.version == 2 then
    -- Originally I split the zones based on locale. Later I just split everything based on locale. Discarding old data rather than doing the gymnastics needed to preserve it.
    -- This is turning into a routine. :D
    chunk.zone = nil
    
    chunk.version = 3
  end
  
  if chunk.version == 3 then
    -- Screwed up the item collection code in instances. Obliterate old data, try again.
    if chunk.item then
      for id, dat in pairs(chunk.item) do
        dat.equip_no = nil
        dat.equip_yes = nil
      end
    end
    
    chunk.version = 4
  end
  
  if chunk.version == 4 then
    -- Munged the shops rather badly. Whoopsydaisy.
    if chunk.monster then
      local nv = {}
      for id, dat in pairs(chunk.monster) do
        if type(dat) == "table" then
          nv[id] = dat
        end
      end
      chunk.monster = nv
    end
    
    chunk.version = 5
  end
  
  if chunk.version == 5 then
    -- Horrible things involving objects. Let's preserve what we can.
    if chunk.object then
      local new_obj = {}
      for k, v in pairs(chunk.object) do
        local keep = false
        for tk, _ in pairs(v) do
          if type(tk) == "string" and tk:match("[a-z]+_loot") then
            keep = true
            break
          end
        end
        
        if keep then new_obj[k] = v end
      end
      
      chunk.object = new_obj
    end
    
    chunk.version = 6
  end
  
  if chunk.version == 6 then
    -- I just screwed this up really
    -- Note that a few versions back (I'll have to check which) the standard bolus format changed. Since I can't actually *fix* it, I'm just ignoring it, but there's an implicit format change in there. I'll catch it and deal with it in the processing system.
    chunk.warp = nil
    chunk.routing_dump = nil -- and this shouldn't have been getting dumped anyway
    
    chunk.version = 7
  end
  
  if chunk.version == 7 then
    -- botched the achievement code, fixed the achievement code (maybe?)
    chunk.achievement = nil
    
    chunk.version = 8
  end
end

function QH_Collector_UpgradeAll(Collector)
-- So, I screwed up the compression code, and there's no way to know what version was compressed . . . except that we thankfully didn't change the version number on that change. Any untagged compression will therefore be the version number that this was loaded with.
  for _, v in pairs(Collector) do
    --[[ QuestHelper:Assert(type(v) == "table") ]]
    if not v.version then
      QuestHelper: Assert(QuestHelper_Collector_Version)  -- This is going to fail somehow. I just know it. Seriously, this right here will be proof that, today, the gods hate me.
      v.version = QuestHelper_Collector_Version
    end
    
    if not v.compressed then
      QH_Collector_Upgrade(v)
    end
  end
end
