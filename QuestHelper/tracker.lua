QuestHelper_File["tracker.lua"] = "1.4.1"
QuestHelper_Loadtime["tracker.lua"] = GetTime()

local debug_output = false
if QuestHelper_File["tracker.lua"] == "Development Version" then debug_output = true end

--[[ NOTES TO SELF

So here's what we want to do.

We want a "refresh notification" where we send it the current route.

If things aren't in the route, we don't care about them . . . unless they're pinned.

So we have "refresh notification" and "pin toggles". In both cases, the objective and only the objective is passed in. Right now there's no concept of priority within the pins.

We're also not bothering with the whole metaobjective tree, we're just going one step up.

So, our algorithm:

Note that "add" means "add iff it hasn't already been added."

Iff we haven't loaded yet, add a loaded message and a gap.

For each pinned objective, add the metaobjective and all objectives in its internal order. Iff we added things, add a gap.

For each route objective, add the metaobjective and all objectives in route order.

Later on we'll add an option for "splitting" metaobjectives, or possibly following the metaobjective tree all the way up.



So, "add" is complicated, due to the two requirements. We have to both add everything, and not add everything *yet*. I think the goal here is to make an Add function for adding a metaobjective that takes a list of objectives to be children, then doublecheck inside the function that we have all objectives.
  
We don't actually want "all objectives" long-term, note, we want only unfinished objectives. I sort of don't like the idea of keeping "finished objectives" around, however. Maybe we should only toss objectives in if they're in the routing system? Then how do I handle unknown objectives? (Simple - you pin them, and point out that we don't know how to do them.)
  
Also, to handle the "moving things around", we need to be a little clever. One line might be either a metaobjective or an objective, but in either case, we need a counter for which case it is. If everything shuffles, and we had two copies of metaobjective, MO1 moves to MO1 and MO2 moves to MO2. Easy.
]]

local tracker = CreateFrame("Frame", "QuestHelperQuestWatchFrame", UIParent)
local minbutton = CreateFrame("Button", "QuestHelperQuestWatchFrameMinimizeButton", UIParent)

QuestHelper.tracker = tracker

local resizing = false
tracker:SetWidth(200)
tracker:SetHeight(100)
tracker:SetFrameStrata("BACKGROUND")
tracker.dw, tracker.dh = 200, 100

local in_tracker = 0

minbutton:SetFrameStrata("LOW")
minbutton:Hide()
minbutton:SetPoint("TOPRIGHT", WatchFrame) -- We default to a different location to make it more likely to display the right item.
minbutton:SetMovable(true)
minbutton:SetUserPlaced(true)
minbutton:SetWidth(24 / 1.6)
minbutton:SetHeight(24)
minbutton:SetFrameLevel(3)
local minbutton_tex = minbutton:CreateTexture()
minbutton_tex:SetAllPoints()
minbutton_tex:SetTexture(.6, .6, .6)
minbutton_tex:SetParent(minbutton)

local sigargh = CreateFrame("Frame", minbutton)
sigargh:SetFrameStrata("LOW")
sigargh:SetFrameLevel(4)

local sigil = sigargh:CreateTexture("BACKGROUND")
sigil:SetHeight(24)
sigil:SetWidth(24)
--sigil:SetPoint("CENTER", 0, 0)
sigil:SetTexture("Interface\\AddOns\\QuestHelper\\sigil")
sigil:SetPoint("CENTER", minbutton_tex, "CENTER")


tracker:SetPoint("CENTER", minbutton)

function minbutton:moved()
  local x, y = self:GetCenter()
  local w, h = UIParent:GetWidth(), UIParent:GetHeight()
  local anchor = (y < h*.45 and "BOTTOM" or y > h*.55 and "TOP" or "")..(x < w*.45 and "LEFT" or x > w*.55 and "RIGHT" or "")
  
  tracker:ClearAllPoints()
  tracker:SetPoint("CENTER", self)
  
  if anchor ~= "" then
    tracker:SetPoint(anchor, self)
  end
end

function QuestHelper:ResetTrackerPosition(cmd)
  minbutton:ClearAllPoints()
  if cmd and string.find(cmd, "center") then
    minbutton:SetPoint("CENTER", nil, "CENTER", 100, 100)
  else
    minbutton:SetPoint("RIGHT", nil, "RIGHT", -20, 230)
  end
  minbutton:moved()
  QuestHelper_Pref.track_minimized = false
  tracker:Show()
  self:TextOut("Quest tracker postion reset.")
end

QH_Event({"DISPLAY_SIZE_CHANGED", "PLAYER_ENTERING_WORLD"}, function () minbutton:moved() end)

QH_Hook(minbutton, "OnClick", function ()
  QuestHelper_Pref.track_minimized = not QuestHelper_Pref.track_minimized
  if QuestHelper_Pref.track_minimized then
    tracker:Hide()
  else
    tracker:Show()
  end
end)

minbutton:RegisterForDrag("LeftButton")

QH_Hook(minbutton, "OnDragStart", function(self)
  if self:IsVisible() then
    self:StartMoving()
    QH_Hook(self, "OnUpdate", self.moved)
  end
end)

QH_Hook(minbutton, "OnDragStop", function(self)
  QH_Hook(self, "OnUpdate", nil)
  self:StopMovingOrSizing()
  self:moved()
end)

local entered_main = false
local entered_tracker = false
local function RefreshColor()
  if entered_main then
    minbutton:SetAlpha(1)
    sigargh:SetAlpha(1)
  elseif entered_tracker then
    minbutton:SetAlpha(.3)
    sigargh:SetAlpha(.3)
  elseif QuestHelper_Pref.track_minimized then
    minbutton:SetAlpha(.3)
    sigargh:SetAlpha(.3)
  else
    minbutton:SetAlpha(0)
    sigargh:SetAlpha(0)
  end
end
local function SetEnteredMain(x)
  entered_main = x
  RefreshColor()
end
local function SetEnteredTracker(x)
  entered_tracker = x
  RefreshColor()
end

QH_Hook(minbutton, "OnEnter", function (self)
  SetEnteredMain(true)
end)

QH_Hook(minbutton, "OnLeave", function (self)
  SetEnteredMain(false)
end)

-- used_items[objective][index]
-- used_count[objective] is incremented as the last valid index
-- so, therefore, used_items[objective][used_count[objective]] is not nil
local used_items = {}
local used_count = {}

-- it's possible for an item to be in neither used_items nor recycled_items, if it's in the process of fading out
local recycled_items = {}

-- These two functions are basically identical. Combine them.
local function itemupdate(item, delta)
  local done = true
  
  local a = item:GetAlpha()
  a = a + delta
  
  if a < 1 then
    item:SetAlpha(a)
    done = false
  else
    item:SetAlpha(1)
  end
  
  local t = item.t + delta
  
  if t < 1 then
    item.t = t
    local it = 1-t
    local sp = math.sqrt(t-t*t)
    item.x, item.y = item.sx*it+item.ex*t+(item.sy-item.ey)*sp, item.sy*it+item.ey*t+(item.ex-item.sx)*sp
    done = false
  else
    item.t = 1
    item.x, item.y = item.ex, item.ey
  end
  
  item:ClearAllPoints()
  item:SetPoint("TOPLEFT", tracker, "TOPLEFT", item.x, -item.y)
  
  if done then
    QH_Hook(item, "OnUpdate", nil)
  end
end

local function itemfadeout(item, delta)
  local a = item:GetAlpha()
  a = a - delta
  
  if a > 0 then
    item:SetAlpha(a)
  else
    item:SetAlpha(1)
    item:Hide()
    QH_Hook(item, "OnUpdate", nil)
    table.insert(recycled_items, item)
    return
  end
  
  local t = item.t + delta
  
  if t < 1 then
    item.t = t
    local it = 1-t
    local sp = math.sqrt(t-t*t)
    item.x, item.y = item.sx*it+item.ex*t+(item.sy-item.ey)*sp, item.sy*it+item.ey*t+(item.ex-item.sx)*sp
  else
    item.t = 1
    item.x, item.y = item.ex, item.ey
  end
  
  item:ClearAllPoints()
  item:SetPoint("TOPLEFT", tracker, "TOPLEFT", item.x, -item.y)
end

--[[function QH_ToggleQuestLog()   -- This seems to be gone in 3.0, so I'm adding it here.
	if (QuestLogFrame:IsShown()) then
		HideUIPanel(QuestLogFrame);
	else
		ShowUIPanel(QuestLogFrame);
	end
end

-- Grim stuff with uberquest, I need a better way to handle this
local function itemclick(item, button)
  if button == "RightButton" then
    local quest = item.quest
    local index = 1
    while true do
      local title = GetQuestLogTitle(index)
      if not title then break end
      
      if title == quest then
        if UberQuest then
          -- UberQuest needs a little extra effort to work properly.
          
          if UberQuest_List:IsShown() and GetQuestLogSelection() == index then
            QH_ToggleQuestLog()
          else
            QuestLog_SetSelection(index)
            
            -- By hiding the list, the replaced ToggleQuestLog function should try to reshow it
            -- and in the process update the frames to reflect the selected quest.
            UberQuest_List:Hide()
            UberQuest_Details:Show()
            QH_ToggleQuestLog()
          end
        else
          -- This code seems to work properly with the builtin questlog, as well as bEQL and DoubleWide.
          
          if QuestLogFrame:IsShown() and GetQuestLogSelection() == index then
            -- If the selected quest is already being shown, hide it.
            QH_ToggleQuestLog()
          else
            -- Otherwise, select it and show it.
            QuestLog_SetSelection(index)
            
            if not QuestLogFrame:IsShown() then
              QH_ToggleQuestLog()
            end
          end
        end
        
        return
      end
      
      index = index + 1
    end
  end
end]]

local function allocateItem()
  local item
  
  item = table.remove(recycled_items)
  if item then return item end
  
  item = CreateFrame("Frame", nil, tracker)
  item.text = item:CreateFontString()
  item.text:SetShadowColor(0, 0, 0, .8)
  item.text:SetShadowOffset(1, -1)
  item.text:SetPoint("TOPLEFT", item)
  return item
end

local specitem_max = 1
local specitem_unused = {}

-- This is adding a *single item*. This won't be called by the main parsing loop, but it does need some serious hackery. Let's see now
local function addItem(objective, y, meta)
  local obj_key = objective
  if obj_key.cluster then obj_key = obj_key.cluster end
  used_count[obj_key] = (used_count[obj_key] or 0) + 1
  if not used_items[obj_key] then used_items[obj_key] = QuestHelper:CreateTable("additem used_items") end
  local item = used_items[obj_key][used_count[obj_key]]
  
  local x = meta and 4 or 20
  
  if not item then
    used_items[obj_key][used_count[obj_key]] = allocateItem()
    item = used_items[obj_key][used_count[obj_key]]
    
    if meta then
      item.text:SetFont(QuestHelper.font.serif, 12)
      item.text:SetTextColor(.82, .65, 0)
    else
      item.text:SetFont(QuestHelper.font.sans, 12)
      item.text:SetTextColor(.82, .82, .82)
    end
    
    item.obj = objective

    item.sx, item.sy, item.x, item.y, item.ex, item.ey, item.t = x+30, y, x, y, x, y, 0
    QH_Hook(item, "OnUpdate", itemupdate)
    item:SetAlpha(0)
    item:Show()
  end
  
  item.text:SetText(item.obj.tracker_desc or "(no description)")
  
  local w, h = item.text:GetWidth(), item.text:GetHeight()
  item:SetWidth(w)
  item:SetHeight(h)
  
  if objective.tracker_clicked then
    QH_Hook(item, "OnMouseDown", function (self, button) if button == "RightButton" then objective.tracker_clicked() end end)
    item:EnableMouse(true)
  end
  
  if item.ex ~= x or item.ey ~= y then
    item.sx, item.sy, item.ex, item.ey = item.x, item.y, x, y
    item.t = 0
    QH_Hook(item, "OnUpdate", itemupdate)
  end
  
    -- we're just going to recycle this each time
  if item.specitem then
    item.specitem:Hide()
    table.insert(specitem_unused, item.specitem)
    item.specitem = nil
  end
  
  local spacer = 0
  -- hacky - progress only shows up if we're not on a metaobjective. wheee
  if objective.type_quest and objective.type_quest.index and not objective.progress and GetQuestLogSpecialItemInfo(objective.type_quest.index) then
    item.specitem = table.remove(specitem_unused)
    if not item.specitem then
      item.specitem = CreateFrame("BUTTON", "QH_SpecItem_" .. tostring(specitem_max), item, "WatchFrameItemButtonTemplate")
      QuestHelper: Assert(item.specitem)
      
      local rangey = _G["QH_SpecItem_" .. tostring(specitem_max) .. "HotKey"]
      QuestHelper: Assert(rangey)
      local fn, fh, ff = rangey:GetFont()
      rangey:SetFont("Fonts\\ARIALN.TTF", fh, ff)
      rangey:SetText(RANGE_INDICATOR)
      rangey:ClearAllPoints()
      rangey:SetPoint("BOTTOMRIGHT", item.specitem, "BOTTOMRIGHT", 0, 2)
      
      specitem_max = specitem_max + 1
    end
    
    item.specitem:SetScale(0.9)
    item.specitem:ClearAllPoints()
    item.specitem:SetParent(item)
    item.specitem:SetPoint("TOPRIGHT", item, "TOPLEFT", 0, 0)
    
    local _, tex, charges = GetQuestLogSpecialItemInfo(objective.type_quest.index)
    item.specitem:SetID(objective.type_quest.index)
    SetItemButtonTexture(item.specitem, tex)
    item.specitem.rangeTimer = -1 -- This makes the little dot go away. Why does it do that?
    item.specitem.charges = charges
    
    item.specitem:Show()
    
    spacer = h
  end
  
  return w+x+4, y+h, y+h+spacer
end

local function addMetaObjective(metaobj, items, y, depth)
  local seen_texts = QuestHelper:CreateTable("amo_seen_texts")
  
  local x, spacer
  x, y, spacer = addItem(metaobj, y, true)
  for _, v in ipairs(items) do
    if not v.tracker_hide_dupes or not seen_texts[v.tracker_desc] then
      x, y = addItem(v, y, false)
      seen_texts[v.tracker_desc] = true
    end
  end
  return math.max(y, spacer), depth + #items + 1
end

local function removeUnusedItem(item)
  item.t = 0
  item.sx, item.sy, item.dx, item.dy = item.x, item.y, item.x+30, item.y
  QH_Hook(item, "OnMouseDown", nil)
  item:EnableMouse(false)
  QH_Hook(item, "OnUpdate", itemfadeout)
  
  if item.specitem then
    item.specitem:Hide()
    table.insert(specitem_unused, item.specitem)
    item.specitem = nil
  end
end



local loading_vquest = {tracker_desc = QHFormat("QH_LOADING", "0")}
local flightpath_vquest = {tracker_desc = QHFormat("QH_FLIGHTPATH", "0")}
local recalculating_vquest = {tracker_desc = QHFormat("QH_RECALCULATING", "0")}

local recalculating_start = nil


local hidden_vquest1 = { tracker_desc = QHText("QUESTS_HIDDEN_1"), tracker_clicked = QH_Hidden_Menu }
local hidden_vquest2 = { tracker_desc = "    " .. QHText("QUESTS_HIDDEN_2"), tracker_clicked = QH_Hidden_Menu }

local route = {}
local pinned = {}

-- This is actually called surprisingly often.
function QH_Tracker_Rescan()
  used_count = QuestHelper:CreateTable("tracker rescan used_count")
  
  local mo_done = QuestHelper:CreateTable("tracker rescan mo_done")
  local obj_done = QuestHelper:CreateTable("tracker rescan obj_done")
  
  local y, depth = 0, 0
  
  do
    local had_pinned = false
  
    local objs = QuestHelper:CreateTable("tracker objs")
    for k, v in pairs(pinned) do
      if not objs[k.why] then objs[k.why] = QuestHelper:CreateTable("tracker objs sub") end
      if not k.ignore and not k.tracker_hidden then table.insert(objs[k.why], k) end
      obj_done[k.cluster] = true 
    end
    
    local sort_objs = QuestHelper:CreateTable("tracker sobjs")
    for k, v in pairs(objs) do
      v.cluster = k
      v.trackkey = k
      table.insert(sort_objs, v)
    end
    
    table.sort(sort_objs, function (a, b) return tostring(a.trackkey) < tostring(b.trackkey) end)
    
    for _, v in ipairs(sort_objs) do
      y, depth = addMetaObjective(v.cluster, v, y, depth)
      had_pinned = true
      QuestHelper:ReleaseTable(v)
    end
    QuestHelper:ReleaseTable(sort_objs)
    QuestHelper:ReleaseTable(objs)
    
    if had_pinned then y = y + 10 end
  end
  
  if QuestHelper.loading_main then
    loading_vquest.tracker_desc = QHFormat("QH_LOADING", string.format("%d", QuestHelper.loading_main:GetPercentage() * 100))
    local x, ty = addItem(loading_vquest, y)
    y = ty + 10
  end
  if QuestHelper.flightpathing then
    flightpath_vquest.tracker_desc = QHFormat("QH_FLIGHTPATH", string.format("%d", QuestHelper.flightpathing:GetPercentage() * 100))
    local x, ty = addItem(flightpath_vquest, y)
    y = ty + 10
  end
  if not QuestHelper.loading_main and not QuestHelper.flightpathing and QuestHelper.route_change_progress then
    if recalculating_start then
      if recalculating_start + 5 < GetTime() then
        recalculating_vquest.tracker_desc = QHFormat("QH_RECALCULATING", string.format("%d", QuestHelper.route_change_progress:GetPercentage() * 100))
        local x, ty = addItem(recalculating_vquest, y)
        y = ty + 10
      end
    else
      recalculating_start = GetTime()
    end
  else
    recalculating_start = nil
  end
  
  local metalookup = QuestHelper:CreateTable("tracker rescan metalookup")
  for k, v in ipairs(route) do
    if not v.ignore then
      if not metalookup[v.why] then metalookup[v.why] = QuestHelper:CreateTable("tracker rescan metalookup item") end
      if not v.tracker_hidden then table.insert(metalookup[v.why], v) end
    end
  end
  
  do
    local current_mo
    local current_mo_cluster
    for k, v in ipairs(route) do
      if depth > QuestHelper_Pref.track_size and not debug_output then break end
      if not v.ignore and not v.why.tracker_hidden and not obj_done[v.cluster] then
        if current_mo and v.why ~= current_mo and (v.why.tracker_split or not mo_done[v.why]) then
          y, depth = addMetaObjective(current_mo, current_mo_cluster, y, depth)
          QuestHelper:ReleaseTable(current_mo_cluster)
          current_mo, current_mo_cluster = nil, nil
        end
        
        if not v.why.tracker_split then
          if not mo_done[v.why] then
            y, depth = addMetaObjective(v.why, metalookup[v.why], y, depth)
            mo_done[v.why] = true
          end
        else
          if not current_mo then
            current_mo = v.why
            current_mo_cluster = QuestHelper:CreateTable("tracker current cluster")
          end
          if not v.tracker_hidden then table.insert(current_mo_cluster, v) end
        end
        
        obj_done[v] = true
      end
    end
    if current_mo and not (depth > QuestHelper_Pref.track_size and not debug_output) then
      y, depth = addMetaObjective(current_mo, current_mo_cluster, y, depth)
    end
    if current_mo_cluster then
      QuestHelper:ReleaseTable(current_mo_cluster)
    end
  end
  
  -- now we check to see if we need a hidden display
  if (debug_output or depth < QuestHelper_Pref.track_size) and not QuestHelper.loading_main and not QuestHelper_Pref.filter_done and not QuestHelper_Pref.filter_zone and not QuestHelper_Pref.filter_watched then
    local show = false
    
    QH_Route_TraverseClusters(
      function (clust)
        if not show then
          QH_Route_IgnoredReasons_Cluster(clust, function (reason)
            show = true
          end)
          
          for _, v in ipairs(clust) do
            QH_Route_IgnoredReasons_Node(v, function (reason)
              show = true
            end)
          end
        end
      end
    )
    
    if show then
      y = y + 10
      _, y = addItem(hidden_vquest1, y)
      _, y = addItem(hidden_vquest2, y)
    end
  end
  
  
  -- any manipulations of the tracker should be done by now, everything after this is bookkeeping

  for k, v in pairs(used_items) do
    if not used_count[k] or used_count[k] < #v then
      local ttp = QuestHelper:CreateTable("used_items ttp")
      for m = 1, (used_count[k] or 0) do
        table.insert(ttp, v[m])
      end
      for m = (used_count[k] or 0) + 1, #v do
        removeUnusedItem(v[m])
      end
      
      if used_items[k] then
        QuestHelper:ReleaseTable(used_items[k])
      end
      
      if #ttp > 0 then
        used_items[k] = ttp
      else
        used_items[k] = nil
        QuestHelper:ReleaseTable(ttp)
      end
    end
  end
  
  QuestHelper:ReleaseTable(mo_done)
  QuestHelper:ReleaseTable(obj_done)
  for k, v in pairs(metalookup) do
    QuestHelper:ReleaseTable(v)
  end
  QuestHelper:ReleaseTable(metalookup)
  
  QuestHelper:ReleaseTable(used_count)
  used_count = nil
  
  if y ~= tracker.dh then
    tracker.t = 0
    tracker.sh = tracker:GetHeight()
    tracker.dh = y
    tracker.sw = tracker.dw
    resizing = true
  end
end

function QH_Tracker_UpdateRoute(new_route)
  route = new_route
  QH_Tracker_Rescan()
end

function QH_Tracker_Pin(metaobjective, suppress)
  if not pinned[metaobjective] then
    pinned[metaobjective] = true
    
    if not suppress then
      QH_Tracker_Rescan()
    end
  end
end

function QH_Tracker_Unpin(metaobjective, suppress)
  if pinned[metaobjective] then
    pinned[metaobjective] = nil -- nil, not false, so it'll be garbage-collected appropriately
    
    if not suppress then
      QH_Tracker_Rescan()
    end
  end
end

function QH_Tracker_SetPin(metaobjective, flag, suppress)
  if flag then
    QH_Tracker_Pin(metaobjective, suppress)
  else
    QH_Tracker_Unpin(metaobjective, suppress)
  end
end


local check_delay = 4

-- This function does the grunt work of cursor positioning and rescaling. It does not actually reorganize items.
function tracker:update(delta)
  if not delta then
    -- This is called without a value when the questlog is updated.
    -- We'll make sure we update the display on the next update.
    check_delay = 1e99
    return
  end
  
  if resizing then
    local t = self.t+delta
    
    if t > 1 then
      self:SetWidth(self.dw)
      self:SetHeight(self.dh)
      resizing = false
    else
      self.t = t
      local it = 1-t
      self:SetWidth(self.sw*it+self.dw*t)
      self:SetHeight(self.sh*it+self.dh*t)
    end
  end
  
  -- Manually checking if the mouse is in the frame, because if I used on OnEnter, i'd have to enable mouse input,
  -- and if I did that, it would prevent the player from using the mouse to change the view if they clicked inside
  -- the tracker.
  local x, y = GetCursorPosition()
  local s = 1/self:GetEffectiveScale()
  x, y = x*s, y*s

  QuestHelper: Assert(x)
  QuestHelper: Assert(y)
  --[[  QuestHelper: Assert(self:GetLeft())
  QuestHelper: Assert(self:GetBottom())
  QuestHelper: Assert(self:GetRight())
  QuestHelper: Assert(self:GetTop())]]
  
  -- Sometimes it just doesn't know its own coordinates. Not sure why. Maybe this will fix it.
  local inside = (self:GetLeft() and (x >= self:GetLeft() and y >= self:GetBottom() and x < self:GetRight() and y < self:GetTop()))
  if inside ~= was_inside then
    was_inside = inside
    if inside then
      SetEnteredTracker(true)
    else
      SetEnteredTracker(false)
    end
  end
  
  check_delay = check_delay + delta
  if check_delay > 1 then
    check_delay = 0
    
    QH_Tracker_Rescan()
  end
end

QH_Hook(tracker, "OnUpdate", tracker.update)

-- Some hooks to update the tracker when quests are added or removed. These should be moved into the quest director.
--[[
local orig_AddQuestWatch, orig_RemoveQuestWatch = AddQuestWatch, RemoveQuestWatch

function AddQuestWatch(...)
  tracker:update()
  return orig_AddQuestWatch(...)
end

function RemoveQuestWatch(...)
  tracker:update()
  return orig_RemoveQuestWatch(...)
end]]

-------------------------------------------------------------------------------------------------
-- This batch of stuff is to make sure the original tracker (and any modifications) stay hidden

local orig_TrackerBackdropOnShow   -- bEQL (and perhaps other mods) add a backdrop to the tracker
local TrackerBackdropFound = false

local function TrackerBackdropOnShow(self, ...)
  if QuestHelper_Pref.track and not QuestHelper_Pref.hide then
    TrackerBackdropFound:Hide()
  end

  if orig_TrackerBackdropOnShow then
    return orig_TrackerBackdropOnShow(self, ...)
  end
end

function tracker:HideDefaultTracker()
  -- The easy part: hide the original tracker
  WatchFrame_RemoveObjectiveHandler(WatchFrame_DisplayTrackedQuests)
  WatchFrame_ClearDisplay()
  WatchFrame_Update()
  
  -- The harder part: hide all those little buttons
  do
    local index = 1
    while true do
      local orig = _G["WatchFrameItem" .. tostring(index)]
      if orig then orig:Hide() else break end
      index = index + 1
    end
  end

  -- The harder part: check if a known backdrop is present (but we don't already know about it).
  -- If it is, make sure it's hidden, and hook its OnShow to make sure it stays that way.
  -- Unfortunately, I can't figure out a good time to check for this once, so we'll just have
  -- to keep checking.  Hopefully, this won't happen too often.
  if not TrackerBackdropFound then
    if QuestWatchFrameBackdrop then
      -- Found bEQL's QuestWatchFrameBackdrop...
      TrackerBackdropFound = QuestWatchFrameBackdrop
    end

    if TrackerBackdropFound then
      -- OK, we found something - so hide it, and make sure it doesn't rear its ugly head again
      TrackerBackdropFound:Hide()

      orig_TrackerBackdropOnShow = TrackerBackdropFound:GetScript("OnShow")
      QH_Hook(TrackerBackdropFound, "OnShow", TrackerBackdropOnShow)
    end
  end
end

function tracker:ShowDefaultTracker()
  -- I like how there's code explicitly to allow us to do this without checking if it's already added
  WatchFrame_AddObjectiveHandler(WatchFrame_DisplayTrackedQuests)
  -- Make sure the default tracker is up to date on what what's being watched and what isn't.
  WatchFrame_Update()
  
  if TrackerBackdropFound then
    TrackerBackdropFound:Show()
  end
end

function QuestHelper:ShowTracker()
  tracker:HideDefaultTracker()
  minbutton:Show()
  
  RefreshColor()
  if not QuestHelper_Pref.track_minimized then
    tracker:Show()
  end
end

function QuestHelper:HideTracker()
  tracker:ShowDefaultTracker()
  tracker:Hide()
  minbutton:Hide()
end
