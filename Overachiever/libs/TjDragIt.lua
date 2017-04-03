
--
--  TjDragIt.lua
--    by Tuhljin
--
--  A quick way to make given frames draggable by the player.
--
--  TjDragIt.EnableDragging( myFrame[, child1[, child2[, ... childN]]] )
--    myFrame
--      The frame to be made draggable.
--    child1, child2, ... childN
--      A number of other frames that, when the player tries to drag them, should cause myFrame to move. If any
--      are nil or false, no error occurs: That argument is simply passed over.
--
--  TjDragIt.EnableIndirectDragging( myFrame[, child1[, child2[, ... childN]]] )
--    As EnableDragging except that it does not set myFrame to be dragged directly, instead relying on the specified
--    child frames to move it. Passes over nil or false child arguments, as the EnableDragging function does.
--
--  TjDragIt.SetDragButton( myFrame[, button1 [, button2, [, ... buttonN]]] )
--    myFrame
--      A frame which has been or will be used as the myFrame argument of EnableDragging or EnableIndirectDragging.
--    button1 - buttonN
--      Each of these should be a string indicating a mouse button to use for dragging (e.g. "LeftButton").
--    	SetDragButton calls aren't additive; each time it is called, the previous settings are replaced by the new
--	ones. A call where all button arguments are omitted would result in TjDragIt responding to no buttons for
--	this frame. If SetDragButton has not been called for a frame, TjDragIt will use the left mouse button.
--
--  TjDragIt.EnablePositionSaving( myFrame, saveTable[, loadNow[, loadOnShow]] )
--    myFrame
--      A frame which has been or will be used as the myFrame argument of EnableDragging or EnableIndirectDragging.
--    saveTable
--      A table which TjDragIt will use to save the position of the frame when it has been dragged.
--    loadNow
--      If this evaluates to true, the frame will be moved to the position indicated by saveTable at this time.
--    loadOnShow
--      If this evaluates to true, the frame will be moved to the position indicated by saveTable whenever it is
--      shown. Useful for frames that would otherwise be automatically placed elsewhere when they are shown.
--
--  TjDragIt.LoadPosition( frame[, saveTable] )
--    Moves the frame to a saved position. If the frame is one registered with EnablePositionSaving, then, normally,
--    you will not need to call this function directly, as passing the right arguments to EnablePositionSaving will
--    cause the frame to be moved automatically under typical circumstances.
--    frame
--      Any frame (including those not registered with TjDragIt).
--    saveTable
--      A table or nil. If nil, then the frame must have a save table registered with TjDragIt through the
--      TjDragIt.EnablePositionSaving method. If a table, it should contain the following keys (as might be obtained
--      through a frame:GetPoint() call): point, relativeTo, relativePoint, x, y. If any of these keys aren't there,
--      the frame's current position will be saved using the given table.
--
--  If you don't want parts of myFrame to be able to move off the screen, use myFrame:SetClampedToScreen(true).
--
--  Other functions:
--
--  TjDragIt.DisableDragging( myFrame[, child1[, child2[, ... childN]]] )
--  TjDragIt.DisablePositionSaving( myFrame )
--


local THIS_VERSION = 0.9

if (not TjDragIt or TjDragIt.Version < THIS_VERSION) then
  TjDragIt = TjDragIt or {}
  local TjDragIt = TjDragIt
  TjDragIt.Version = THIS_VERSION

  TjDragIt.parents = TjDragIt.parents or {}
  TjDragIt.saveTabs = TjDragIt.saveTabs or {}
  TjDragIt.buttons = TjDragIt.buttons or {}
  local parents, saveTabs, buttons = TjDragIt.parents, TjDragIt.saveTabs, TjDragIt.buttons

  local hookedMouse, hookedOnShow = TjDragIt.hookedMouse, TjDragIt.hookedOnShow

  local function savePosition(frame, tab)
    local obj
    tab.point, obj, tab.relativePoint, tab.x, tab.y = frame:GetPoint()
    tab.relativeTo = obj and obj:GetName() or "UIParent"
  end

  local function loadPosition_OnShow(frame)
    local tab = saveTabs[frame]
    if (tab) then  TjDragIt.LoadPosition(frame, tab);  end
  end

  local function MouseDown(frame, button)
    frame = parents[frame] or frame
    if ( frame:IsMovable() and ((not buttons[frame] and button == "LeftButton") or
         (buttons[frame] and buttons[frame][button])) ) then
      frame:StartMoving()
    end
  end

  local function MouseUp(frame, button)
    frame = parents[frame] or frame
    if ((not buttons[frame] and button == "LeftButton") or (buttons[frame] and buttons[frame][button])) then
      frame:StopMovingOrSizing()
      local tab = saveTabs[frame]
      if (tab) then  savePosition(frame, tab)  end
    end
  end

  local function sethook(frame, script, handler)
    local prev = frame:GetScript(script)
    if (prev) then
      frame:HookScript(script, handler)
    else
      frame:SetScript(script, handler)
    end
  end

  function TjDragIt.LoadPosition(frame, tab)
    if (not tab) then
      tab = saveTabs[frame]
    end
    assert( type(tab) == "table", "Position table not found: Needs to be given as 2nd argument or specified through TjDragIt.EnablePositionSaving()." )
    local point, obj, relativePoint, x, y = tab.point, _G[tab.relativeTo], tab.relativePoint, tab.x, tab.y
    if (point and obj and relativePoint and x and y) then
      frame:ClearAllPoints()
      frame:SetPoint(point, obj, relativePoint, x, y)
    else
      savePosition(frame, tab)
    end
  end

  function TjDragIt.EnableIndirectDragging(frame, ...)
    if (not hookedMouse) then
       hookedMouse = {}
       TjDragIt.hookedMouse = hookedMouse
    end
    frame:SetMovable(true)
    local child
    for i=1,select("#", ...) do
      child = select(i, ...)
      if (child) then
        child:SetMovable(true)
        child:SetClampedToScreen(false)
        child:EnableMouse(true)
        if (not hookedMouse[child]) then
          sethook(child, "OnMouseDown", MouseDown)
          sethook(child, "OnMouseUp", MouseUp)
          hookedMouse[child] = true
        end
        parents[child] = frame
      end
    end
  end

  function TjDragIt.EnableDragging(frame, ...)
    TjDragIt.EnableIndirectDragging(frame, ...)
    frame:EnableMouse(true)
    if (not hookedMouse[frame]) then
      sethook(frame, "OnMouseDown", MouseDown)
      sethook(frame, "OnMouseUp", MouseUp)
      hookedMouse[frame] = true
    end
  end

  function TjDragIt.DisableDragging(frame, ...)
    frame:SetMovable(false)
    local child
    for i=1,select("#", ...) do
      child = select(i, ...)
      if (child) then  child:SetMovable(false);  end
    end
  end

  function TjDragIt.EnablePositionSaving(frame, saveTable, loadNow, loadOnShow)
    assert( type(saveTable) == "table", "Invalid argument #2: Expected table." )
    saveTabs[frame] = saveTable
    if (loadNow) then
      TjDragIt.LoadPosition(frame, saveTable)
    else
      savePosition(frame, saveTable)
    end
    if (loadOnShow and (not hookedOnShow or not hookedOnShow[frame])) then
      sethook(frame, "OnShow", loadPosition_OnShow)
      if (not hookedOnShow) then
         hookedOnShow = {}
         TjDragIt.hookedOnShow = hookedOnShow
      end
      hookedOnShow[frame] = true
    end
  end

  function TjDragIt.DisablePositionSaving(frame)
    saveTabs[frame] = nil
  end

  function TjDragIt.SetDragButton(frame, ...)
    local tab = buttons[frame]
    if (tab) then
      wipe(tab)
    else
      buttons[frame] = {}
      tab = buttons[frame]
    end
    local btn
    for i=1,select("#", ...) do
      btn = select(i, ...)
      if (type(btn) == "string") then  tab[btn] = true;  end
    end
  end

end
