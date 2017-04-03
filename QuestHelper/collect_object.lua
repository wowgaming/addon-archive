QuestHelper_File["collect_object.lua"] = "1.4.1"
QuestHelper_Loadtime["collect_object.lua"] = GetTime()

local debug_output = false
if QuestHelper_File["collect_object.lua"] == "Development Version" then debug_output = true end

local QHCO

local GetLoc
local Merger
local Patterns

local minetypes = {
  mine = UNIT_SKINNABLE_ROCK,
  herb = UNIT_SKINNABLE_HERB,
  eng = UNIT_SKINNABLE_BOLTS,
  skin = UNIT_SKINNABLE_LEATHER,
}

local function Tooltipy(self)
  -- objects are a bitch since they have no unique ID or any standard way to detect them (that I know of).
  -- So we kind of guess at it.
  if self:GetAnchorType() == "ANCHOR_NONE" then
    if self:GetItem() or self:GetUnit() or self:GetSpell() then return end
    -- rglrglrglrglrglrgl
    
    local skintype = nil
    
    local lines = GameTooltip:NumLines()
    --[[
    if lines == 2 then -- see if we're mine or herb
      for k, v in pairs(minetypes) do
        if _G["GameTooltipTextLeft2"]:GetText() == v then
          skintype = k
        end
      end
      if not skintype then return end -- we are neither!
    elseif lines == 0 then  -- this isn't much of anything, is it
      return
    end]]
    
    if not skintype then
      local cline = 2
      
      -- the painful process of checking to see if it might be a game object
      -- first, look for a "requires" line
      
      if not (_G["GameTooltipTextLeft" .. cline] and _G["GameTooltipTextLeft" .. cline]:IsShown()) then return end
    
      do
        local gt = _G["GameTooltipTextLeft" .. cline]:GetText()
        if string.match(gt, Patterns.LOCKED_WITH_ITEM) or string.match(gt, Patterns.LOCKED_WITH_SPELL) or string.match(gt, Patterns.LOCKED_WITH_SPELL_KNOWN) then cline = cline + 1 end
      end
      
      if not (_G["GameTooltipTextLeft" .. cline] and _G["GameTooltipTextLeft" .. cline]:IsShown()) then return end
      
      local r, g, b, a = _G["GameTooltipTextLeft" .. cline]:GetTextColor()
      r, g, b, a = math.floor(r * 255 + 0.5), math.floor(g * 255 + 0.5), math.floor(b * 255 + 0.5), math.floor(a * 255 + 0.5)
      if not (r == 255 and g == 210 and b == 0 and a == 255) then return end -- not a quest item, which I guess we care about
      cline = cline + 1
      
      if not (_G["GameTooltipTextLeft" .. cline] and _G["GameTooltipTextLeft" .. cline]:IsShown()) then return end
      
      local r, g, b, a = _G["GameTooltipTextLeft" .. cline]:GetTextColor()
      r, g, b, a = math.floor(r * 255 + 0.5), math.floor(g * 255 + 0.5), math.floor(b * 255 + 0.5), math.floor(a * 255 + 0.5)
      if not (r == 255 and g == 255 and b == 255 and a == 255) or not _G["GameTooltipTextLeft" .. cline]:GetText():match("^ - ") then return end -- not a quest item, which I guess we care about
      
      -- alright good enough
    end
    
    local name = _G["GameTooltipTextLeft1"]:GetText()
    
    if string.match(name, Patterns.CORPSE_TOOLTIP) then return end  -- no corpses plzkthx
    
    if debug_output then QuestHelper:TextOut("Parsing " .. name) end
    
    if not QHCO[name] then QHCO[name] = {} end
    local qhci = QHCO[name]
    
    --[[
    for k, _ in pairs(minetypes) do
      if k == skintype then
        qhci[k .. "_yes"] = (qhci[k .. "_yes"] or 0) + 1
      else
        qhci[k .. "_no"] = (qhci[k .. "_no"] or 0) + 1
      end
    end]]
    
    -- We have no unique identifier, so I'm just going to record every position we see. That said, I wonder if it's a good idea to add a cooldown.
    -- Obviously, we also have no possible range data, so, welp.
    Merger.Add(qhci, GetLoc(), true)    
  end
end

function QH_Collect_Object_Init(QHCData, API)
  if not QHCData.object then QHCData.object = {} end
  QHCO = QHCData.object
  
  API.Registrar_TooltipHook(Tooltipy)
  
  Patterns = API.Patterns
  QuestHelper: Assert(Patterns)
  
  API.Patterns_Register("CORPSE_TOOLTIP", "[^%s]+")
  API.Patterns_Register("LOCKED_WITH_ITEM", "[^%s]+")
  API.Patterns_Register("LOCKED_WITH_SPELL", "[^%s]+")
  API.Patterns_Register("LOCKED_WITH_SPELL_KNOWN", "[^%s]+")
  
  GetLoc = API.Callback_LocationBolusCurrent
  QuestHelper: Assert(GetLoc)
  
  Merger = API.Utility_Merger
  QuestHelper: Assert(Merger)
end
