
--[[


WatcherFrame
	- Watches for casts
	- Updates a table
		- CastWatch table:
			- sourcename, sourceguid, timestamp
	- Cast warnings expire when Cast success/fail or after 3 seconds

CreateCastWidget
	- 

UpdateCastWidget
	- compares the unit.info table with the CastWatch table
	- checks for mouseover
	- checks for target
	- displays the warning, or an actual cast bar with TargetOf (not ness. the spell target)

--]]

--print("Cast Warning Loaded")
local function CombatLogWatcher_OnEvent(self, event, ...)

  local timeStamp, combatEvent, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags = select(1, ...)
	--if (combatEvent=="SPELL_CAST_START") then
		print(timeStamp, combatEvent, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags)
		--SPELL_DAMAGE  -- local spellId, spellName, spellSchool = select(9, ...)
		-- Use the following line in game version 3.0 or higher, for previous versions use the line after
		
		-- Trigger Warning for 3 Seconds
		-- 
	--end

end



--local CombatLogWatcher = CreateFrame("Frame")
--CombatLogWatcher:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
--CombatLogWatcher:SetScript("OnEvent", CombatLogWatcher_OnEvent)



-- http://wowprogramming.com/forums/development/158
--[[
GetSpellInfo - http://www.wowwiki.com/API_GetSpellInfo
UnitCastingInfo - http://www.wowwiki.com/API_UnitCastingInfo
UnitChannelInfo - http://www.wowwiki.com/API_UnitChannelInfo (not currently documented, but functionally identical to UnitCastingInfo, only for channeled spells)
--]]

--[[

The Widget:

	- Looks at a table, or uses a function to determine if the plate refers to a 
		unit that is associated with a spell cast.
		
	- Each Widget registers itself with the Watcher frame; The watcher frame will
	trigger a warning, if possible.
	
	- Each Widget will cache the name, and (if possible) the GUID of the unit
	
	- The widget warning handler will compare the widget's ID with the
	warning ID
	
	- if the unit gets a unitid (mouseover or target) during a warning, the cast bar
	is shown
		
	- Upon Mouseover
	
	
	
	
	
--]]


local COMBATLOG_FILTER_MINE = COMBATLOG_FILTER_MINE
local COMBATLOG_FILTER_HOSTILE_UNITS = COMBATLOG_FILTER_HOSTILE_UNITS

function CombatLogEvent(arg1, timestamp, event, sourceGUID,  sourceName, sourceFlags, destGUID, destName, destFlags, spellID, spellName, spellSchool)

      local fromEnemy, toMe
      if sourceFlags and not CombatLog_Object_IsA(sourceFlags, COMBATLOG_OBJECT_NONE) then
         fromEnemy = CombatLog_Object_IsA(destFlags, COMBATLOG_FILTER_HOSTILE_UNITS)
      end
	  
      if destFlags and not CombatLog_Object_IsA(destFlags, COMBATLOG_OBJECT_NONE) then
         toMe = CombatLog_Object_IsA(destFlags, COMBATLOG_FILTER_MINE)
      end
	  
      if event == "SPELL_CAST_START" and fromEnemy and toMe and strlower(spellName) == "fireball" then
         print("ALERT: " .. spellName .. " being cast on you!!")
      end
end
	  
	  
--[[

SPELL_CAST_START

--]]