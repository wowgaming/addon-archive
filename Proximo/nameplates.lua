local Proximo = Proximo

-- Speical thanks to Shadowd and Kergoth for the sample code to find nameplates.
-- Speical thanks to Roartindon for updated nameplate code

local childframes = 0
local prox_list
local inarena

----------------------
--See if its a valied nameplate health bar
local function FindHealthBar( ... )
  for i=1,select( '#', ... ) do
    local healthBar = select( i, ... );
    if( healthBar and not healthBar.ProxHooked and healthBar.GetFrameType and healthBar:GetFrameType() == "StatusBar" and not healthBar:GetName() and healthBar:IsVisible() ) then
        return healthBar
    end
  end
end

----------------------
--Check frame to see if a nameplate we can use
local function CheckFrame(object, value)
  local name = select( 6, object:GetParent():GetRegions() ):GetText();
  if prox_list[name] and value then
    prox_list[name].health = value
  end
end
 
----------------------
--Find any on hooked health bars.
local function UpdateFrames( ... )
  for i=1, select( '#', ... ) do
    local healthBar = FindHealthBar( select( i, ... ):GetChildren() );
    if( healthBar ) then
      Proximo:HookScript(healthBar, "OnValueChanged")
      healthBar.ProxHooked = true
    end
  end
end

----------------------
--Create frame to trigger health bars
function Proximo:CreateUnitUpdate()
  self:ScheduleRepeatingTimer("UnitOnUpdate", 1, self)
  if not prox_list then prox_list = self:GetList() end
  inarena = 1
end

----------------------
--Cancel looking for prox frames. Timer stopped in ZoneCheck.
function Proximo:StopUnitUpdate()
  inarena = nil
end

----------------------
--Look for new health bars
function Proximo:UnitOnUpdate()
  if childframes ~= WorldFrame:GetNumChildren() then
    childframes = WorldFrame:GetNumChildren()
    UpdateFrames( WorldFrame:GetChildren() )
  end
end

----------------------
--When a health bar value changes, get the name and run any hooks
--This catches more bars when they are coming in and and out of view, etc...
function Proximo:OnValueChanged(object, value)
  if object:IsVisible() and inarena then
    CheckFrame(object, value);
  end
end
 