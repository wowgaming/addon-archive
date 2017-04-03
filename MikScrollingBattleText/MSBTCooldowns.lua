-------------------------------------------------------------------------------
-- Title: Mik's Scrolling Battle Text Cooldowns
-- Author: Mikord
-------------------------------------------------------------------------------

-- Create module and set its name.
local module = {}
local moduleName = "Cooldowns"
MikSBT[moduleName] = module


-------------------------------------------------------------------------------
-- Imports.
-------------------------------------------------------------------------------

-- Local references to various modules for faster access.
local MSBTProfiles = MikSBT.Profiles
local MSBTTriggers = MikSBT.Triggers

-- Local references to various functions for faster access.
local string_gsub = string.gsub
local string_find = string.find
local string_format = string.format
local GetSpellCooldown = GetSpellCooldown
local EraseTable = MikSBT.EraseTable
local GetSkillName = MikSBT.GetSkillName
local DisplayEvent = MikSBT.Animations.DisplayEvent
local HandleCooldowns = MSBTTriggers.HandleCooldowns


-------------------------------------------------------------------------------
-- Constants.
-------------------------------------------------------------------------------

-- The minimum and maximum amount of time to delay between checking cooldowns.
local MIN_COOLDOWN_UPDATE_DELAY = 0.1
local MAX_COOLDOWN_UPDATE_DELAY = 5

-- Spell names.
local SPELL_COLD_SNAP		= GetSkillName(11958)
local SPELL_MIND_FREEZE		= GetSkillName(47528)
local SPELL_PREPARATION		= GetSkillName(14185)
local SPELL_READINESS		= GetSkillName(23989)

-- Death knight rune cooldown.
local RUNE_COOLDOWN = 10


-------------------------------------------------------------------------------
-- Private variables.
-------------------------------------------------------------------------------

-- Enable state.
local isEnabled

-- Dynamically created frame for receiving events.
local eventFrame

-- Player's class.
local playerClass

-- Cooldown information.
local activeCooldowns = {}
local delayedCooldowns = {}
local resetAbilities = {}
local runeCooldownAbilities = {}
local cooldownSpellName

-- Used for timing between updates.
local updateDelay = MIN_COOLDOWN_UPDATE_DELAY
local lastUpdate = 0


-------------------------------------------------------------------------------
-- Event handlers.
-------------------------------------------------------------------------------

-- ****************************************************************************
-- Called when the player successfully casts a spell.
-- ****************************************************************************
local function OnSpellCast(spellName)
 -- Ignore the cast if the spell name is excluded.
 if (MSBTProfiles.currentProfile.cooldownExclusions[spellName]) then return end

 -- An ability that resets cooldowns was cast.
 if (resetAbilities[spellName]) then
  -- Remove active cooldowns that the game is now reporting inactive.
  for spellName, originalDuration in pairs(activeCooldowns) do
   local startTime, duration = GetSpellCooldown(spellName)
   if (duration <= 1.5 and originalDuration > 1.5) then activeCooldowns[spellName] = nil end

   -- Force an update.
   updateDelay = MIN_COOLDOWN_UPDATE_DELAY
  end
 end

 -- Set the cooldown spell name to be checked on the next cooldown update event. 
 cooldownSpellName = spellName
end


-- ****************************************************************************
-- Called when a spell cooldown is started.
-- ****************************************************************************
local function OnSpellUpdateCooldown()
 -- Start delayed cooldowns once they have been used.
 for spellName in pairs(delayedCooldowns) do
  -- Check if the spell is enabled yet.
  local _, duration, enabled = GetSpellCooldown(spellName)
  if (enabled == 1) then
   -- Add the spell to the active cooldowns list if the cooldown is longer than the cooldown threshold.
   if (duration >= MSBTProfiles.currentProfile.cooldownThreshold) then
    activeCooldowns[spellName] = duration

    -- Force an update.
    updateDelay = MIN_COOLDOWN_UPDATE_DELAY

    -- Check if the event frame is not visible and make it visible so the OnUpdate events start firing.
    -- This is done to keep the number of OnUpdate events down to a minimum for better performance.
    if (not eventFrame:IsVisible()) then eventFrame:Show() end
   end

   -- Remove the spell from the delayed cooldowns list.
   delayedCooldowns[spellName] = nil
  end
 end

 -- Add the last successful spell to the active cooldowns if necessary.
 if (cooldownSpellName) then
  -- Append empty rank syntax to spell names with parentheses in them to avoid confusing Blizzard's API.
  if string_find(cooldownSpellName, "%(.+%)$") then cooldownSpellName = cooldownSpellName .. "()" end
   
  -- Make sure the spell cooldown is enabled.
  local _, duration, enabled = GetSpellCooldown(cooldownSpellName)
  if (enabled == 1) then
   -- XXX This is a hack to compensate for Blizzard's API reporting incorrect cooldown information for death knights.
   -- XXX Ignore cooldowns that are the same duration as a rune cooldown except for the abilities that truly have the same cooldown.
   if (playerClass == "DEATHKNIGHT" and duration == RUNE_COOLDOWN and not runeCooldownAbilities[cooldownSpellName]) then duration = -1 end

   -- Add the spell to the active cooldowns list if the cooldown is longer than the cooldown threshold.
   if (duration >= MSBTProfiles.currentProfile.cooldownThreshold) then
    activeCooldowns[cooldownSpellName] = duration

    -- Force an update.
    updateDelay = MIN_COOLDOWN_UPDATE_DELAY
  
    -- Check if the event frame is not visible and make it visible so the OnUpdate events start firing.
    -- This is done to keep the number of OnUpdate events down to a minimum for better performance.
    if (not eventFrame:IsVisible()) then eventFrame:Show() end
   end

  -- Spell cooldown is NOT enabled so add it to the delayed cooldowns list.
  else
   delayedCooldowns[cooldownSpellName] = true
  end

  cooldownSpellName = nil  
 end -- cooldownSpellName?
end


-- ****************************************************************************
-- Called when the OnUpdate event occurs.
-- ****************************************************************************
local function OnUpdate(this, elapsed)
 -- Increment the amount of time passed since the last update.
 lastUpdate = lastUpdate + elapsed

 -- Check if it's time for an update.
 if (lastUpdate >= updateDelay) then
  -- Reset the update delay to the max value.
  updateDelay = MAX_COOLDOWN_UPDATE_DELAY

  -- Loop through all of the active cooldowns.
  local currentTime = GetTime()
  for spellName in pairs(activeCooldowns) do
   -- Ensure the cooldown is still valid.
   local startTime, duration = GetSpellCooldown(spellName)
   if (startTime ~= nil) then
    -- Calculate the remaining cooldown.
    local cooldownRemaining = startTime + duration - currentTime

    -- Cooldown completed.
    if (cooldownRemaining <= 0) then
     local texture = GetSpellTexture(spellName)
     HandleCooldowns(spellName, texture)

     local eventSettings = MSBTProfiles.currentProfile.events.NOTIFICATION_COOLDOWN
     if (eventSettings and not eventSettings.disabled) then
      local message = eventSettings.message
      message = string_gsub(message, "%%e", string_format("|cffff0000%s|r", string_gsub(spellName, "%(.+%)%(%)$", "")))
      DisplayEvent(eventSettings, message, texture)
     end

     -- Remove the cooldown from the active cooldowns list.
     activeCooldowns[spellName] = nil

    -- Cooldown NOT completed.
    else
     if (cooldownRemaining < updateDelay) then updateDelay = cooldownRemaining end
    end

   -- Cooldown is no longer valid.
   else
    activeCooldowns[spellName] = nil
   end
  end

  -- Ensure the update delay isn't less than the min value.
  if (updateDelay < MIN_COOLDOWN_UPDATE_DELAY) then updateDelay = MIN_COOLDOWN_UPDATE_DELAY end

  -- Hide the event frame if there are no active cooldowns so the OnUpdate events stop firing.
  -- This is done to keep the number of OnUpdate events down to a minimum for better performance.
  if (not next(activeCooldowns)) then eventFrame:Hide() end

  -- Reset the time since last update.
  lastUpdate = 0
 end
end


-- ****************************************************************************
-- Called when the events the module registered for occur.
-- ****************************************************************************
local function OnEvent(this, event, arg1, arg2)
 -- Successful spell casts.
 if (event == "UNIT_SPELLCAST_SUCCEEDED") then
  if (arg1 == "player") then OnSpellCast(arg2) end
  
 -- Cooldown updates.  
 elseif (event == "SPELL_UPDATE_COOLDOWN") then
  OnSpellUpdateCooldown()
 end
end


-- ****************************************************************************
-- Enables the module.
-- ****************************************************************************
local function Enable()
 if (isEnabled) then return end
 eventFrame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
 eventFrame:RegisterEvent("SPELL_UPDATE_COOLDOWN")
 isEnabled = true
end


-- ****************************************************************************
-- Disables the module.
-- ****************************************************************************
local function Disable()
 -- Stop receiving updates.
 if (not isEnabled) then return end
 eventFrame:Hide()
 eventFrame:UnregisterAllEvents()

 -- Clear the active and delayed cooldowns.
 EraseTable(activeCooldowns)
 EraseTable(delayedCooldowns)

 isEnabled = nil
end


-- ****************************************************************************
-- Enables or disables the module depending on active options.
-- ****************************************************************************
local function UpdateEnableState()
 -- Toggle the enable state depending on whether notifications are active or
 -- there are skill cooldown triggers.
 if (not MSBTProfiles.currentProfile.events.NOTIFICATION_COOLDOWN.disabled or
     MSBTTriggers.categorizedTriggers["SKILL_COOLDOWN"]) then
  Enable()
 else
  Disable()
 end
end


-------------------------------------------------------------------------------
-- Initialization.
-------------------------------------------------------------------------------

-- Create a frame to receive events.
eventFrame = CreateFrame("Frame")
eventFrame:Hide()
eventFrame:SetScript("OnEvent", OnEvent)
eventFrame:SetScript("OnUpdate", OnUpdate)

-- Get the player's class.
_, playerClass = UnitClass("player")

-- Specify the abilities that reset cooldowns.
resetAbilities[SPELL_COLD_SNAP] = true
resetAbilities[SPELL_PREPARATION] = true
resetAbilities[SPELL_READINESS] = true
 
-- Set the death knight abilities that are the same as the rune cooldown.
runeCooldownAbilities[SPELL_MIND_FREEZE] = true




-------------------------------------------------------------------------------
-- Module interface.
-------------------------------------------------------------------------------

-- Protected Functions.
module.Enable				= Enable
module.Disable				= Disable
module.UpdateEnableState	= UpdateEnableState