QuestHelper_File["cartographer_is_terrible.lua"] = "1.4.1"
QuestHelper_Loadtime["cartographer_is_terrible.lua"] = GetTime()

-- http://gunnerkrigg.wikia.com/wiki/Category:Terrible

if Cartographer and Cartographer.SetCurrentInstance and Cartographer_InstanceMaps and Cartographer_InstanceMaps.OnEnable and not Cartographer.TheInstanceBugIsFixedAlready_YouCanStopHackingIt then
  local nop = function () end
  
  function hookitsbrainsout(name)
    local oldfunc = _G[name]
    _G[name] = function(...)
      local temp = WorldMapLevelDropDown_Update
      WorldMapLevelDropDown_Update = nop  -- YOINK
      oldfunc(...)
      WorldMapLevelDropDown_Update = temp -- KNIOY
    end
  end
  
  local oldenable = Cartographer_InstanceMaps.OnEnable
  function Cartographer_InstanceMaps:OnEnable(...)
    oldenable(self, ...)
    
    hookitsbrainsout("SetMapZoom")
    hookitsbrainsout("SetMapToCurrentZone")
  end
  
  -- BEHOLD, MY MADNESS! BEHOLD AND SUFFER
  
  -- BEHOOOOOOLD
end



-- okay okay I guess I'll explain

-- There's a bug in Cartographer where SetMapZoom() or SetMapToCurrentZone(), called in an instance, causes any open menus to instantly close. Questhelper (and in general, anything that uses Astrolabe, and other UI mods as well) call those function every frame if the map is closed. This isn't a performance problem or anything, but it happens to trigger the Cartographer bug.

-- The top two bugs on the Cartographer tracker are both this one, as well as a third bug listed later down. I've talked to both of the possibly-main Cartographer maintainers about fixing it, neither are interested. It's pretty clearly not going to be fixed.

-- So here's a hack. The problem is the WorldMapLevelDropDown_Update call which, after a few nested calls, is eventually called. Why's it there? I dunno. What will removing it break? Not a clue. This cute little hook automatically disables it during the call of the important functions. Will this be a problem for Cartographer? Damned if I know. Will it be *my* problem? No! No it will not.

-- If the Cartographer crew ever fixes it properly, this hook can be disabled by simply doing Cartographer.TheInstanceBugIsFixedAlready_YouCanStopHackingIt = true. And it will go away. Until then, the bug will go away.

-- LOOK HOW MUCH MY PROBLEM THIS ISN'T ANYMORE
