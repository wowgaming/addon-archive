QuestHelper_File["arrow.lua"] = "1.4.1"
QuestHelper_Loadtime["arrow.lua"] = GetTime()

--[[ This entire file is pretty liberally ganked from TomTom (and then modified) under the following license:

-------------------------------------------------------------------------
  Copyright (c) 2006-2007, James N. Whitehead II
  All rights reserved.

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are
  met:

      * Redistributions of source code must retain the above copyright
        notice, this list of conditions and the following disclaimer.
      * Redistributions in binary form must reproduce the above
        copyright notice, this list of conditions and the following
        disclaimer in the documentation and/or other materials provided
        with the distribution.
      * The name or alias of the copyright holder may not be used to endorse 
        or promote products derived from this software without specific prior
        written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
---------------------------------------------------------------------------

Thanks, James! <3   ]]

local function ColorGradient(perc, ...)
	local num = select("#", ...)
	local hexes = type(select(1, ...)) == "string"

	if perc == 1 then
		return select(num-2, ...), select(num-1, ...), select(num, ...)
	end

	num = num / 3

	local segment, relperc = math.modf(perc*(num-1))
	local r1, g1, b1, r2, g2, b2
	r1, g1, b1 = select((segment*3)+1, ...), select((segment*3)+2, ...), select((segment*3)+3, ...)
	r2, g2, b2 = select((segment*3)+4, ...), select((segment*3)+5, ...), select((segment*3)+6, ...)

	if not r2 or not g2 or not b2 then
		return r1, g1, b1
	else
		return r1 + (r2-r1)*relperc,
		g1 + (g2-g1)*relperc,
		b1 + (b2-b1)*relperc
	end
end

local wayframe = CreateFrame("Button", "QHArrowFrame", UIParent)
wayframe:SetPoint("CENTER", -300, 300)
wayframe:EnableMouse(true)
wayframe:SetMovable(true)
wayframe:SetUserPlaced(true)
wayframe:Hide()

wif = wayframe

-- Frame used to control the scaling of the title and friends
local titleframe = CreateFrame("Frame", nil, wayframe)

wayframe.title = titleframe:CreateFontString("OVERLAY", nil, "GameFontNormalSmall")
wayframe.status = titleframe:CreateFontString("OVERLAY", nil, "GameFontNormalSmall")
wayframe.tta = titleframe:CreateFontString("OVERLAY", nil, "GameFontNormalSmall")
wayframe.title:SetPoint("TOP", wayframe, "BOTTOM", 0, 0)
wayframe.status:SetPoint("TOP", wayframe.title, "BOTTOM", 0, 0)
wayframe.tta:SetPoint("TOP", wayframe.status, "BOTTOM", 0, 0)
local default_font_name, default_font_size, default_font_flags = wayframe.title:GetFont()

do
  local r, g, b, a = wayframe.status:GetTextColor()
  r, g, b = r - 0.2, g - 0.2, b - 0.2
  wayframe.status:SetTextColor(r, g, b, a)
end

local OnUpdate

local function OnDragStart(self, button)
	if not QuestHelper_Pref.arrow_locked then  -- TODO TWEAKERY
		self:StartMoving()
	end
end

local function OnDragStop(self, button)
	self:StopMovingOrSizing()
end

QH_Event("ZONE_CHANGED_NEW_AREA", function ()
	if QuestHelper_Pref.arrow and not QuestHelper_Pref.hide then -- TODO TWEAKERY
		wayframe:Show()
    OnUpdate()
	end
end)

QH_Hook(wayframe, "OnDragStart", OnDragStart)
QH_Hook(wayframe, "OnDragStop", OnDragStop)
wayframe:RegisterForDrag("LeftButton")

wayframe.arrow = wayframe:CreateTexture("OVERLAY")
--wayframe.arrow:SetTexture("Interface\\AddOns\\QuestHelper\\arrow_image_down") -- if we don't do this, the image doesn't seem to end up cached. :blizzard:
wayframe.arrow:SetTexture("Interface\\AddOns\\QuestHelper\\arrow_image")
wayframe.arrow:SetAllPoints()

local active_point, arrive_distance, showDownArrow, point_title
active_point = {}

function QH_Arrow_Show()
  wayframe:Show()
end

function QH_Arrow_Reset()
  QuestHelper_Pref.arrow = true
  wayframe:ClearAllPoints()
  wayframe:SetPoint("CENTER", 0, 0)
  QuestHelper_Pref.arrow_locked = false -- they're probably going to want to move it
  QH_Arrow_Show()
end

function QH_Arrow_SetScale(scale)
  if scale then
    QuestHelper_Pref.arrow_arrowsize = scale
  else
    scale = QuestHelper_Pref.arrow_arrowsize
  end
  
  if not showDownArrow then
    wayframe:SetHeight(42 * scale)
    wayframe:SetWidth(56 * scale)
  else
    scale = scale * 0.8
    wayframe:SetHeight(70 * scale)
    wayframe:SetWidth(53 * scale)
  end
end

function QH_Arrow_SetTextScale(scale)
  if scale then
    QuestHelper_Pref.arrow_textsize = scale
  else
    scale = QuestHelper_Pref.arrow_textsize
  end
  
  wayframe.title:SetFont(default_font_name, default_font_size * scale, default_font_flags)
  wayframe.status:SetFont(default_font_name, default_font_size * scale, default_font_flags)
  wayframe.tta:SetFont(default_font_name, default_font_size * scale, default_font_flags)
end

local function wpupdate(c, z, x, y, desc)
  if c then
    QuestHelper: Assert(z)
    QuestHelper: Assert(x)
    QuestHelper: Assert(y)
  else
    QuestHelper: Assert(not z)
    QuestHelper: Assert(not x)
    QuestHelper: Assert(not y)
  end
  active_point.c, active_point.z, active_point.x, active_point.y = c, z, x, y
  wayframe.title:SetText(desc)
  wayframe:Show()
  OnUpdate()
end

QuestHelper:AddWaypointCallback(wpupdate)

local status = wayframe.status
local tta = wayframe.tta
local arrow = wayframe.arrow
local last_distance = 0
local tta_throttle = 0
local speed = 0
local speed_count = 0

OnUpdate = function()
  local self = wayframe
  QuestHelper: Assert(self)
  
	if not active_point.c or QuestHelper.collect_rc ~= active_point.c or QuestHelper.collect_delayed or QuestHelper.InBrokenInstance or not QuestHelper_Pref.arrow then
		self:Hide()
		return
	end
  
  self:Show()

  local dist, dx, dy = QuestHelper.Astrolabe:ComputeDistance(QuestHelper.collect_rc, QuestHelper.collect_rz, QuestHelper.collect_rx, QuestHelper.collect_ry, active_point.c, active_point.z, active_point.x, active_point.y)
  
  local text = ""
  
  if dist then
    -- I had support for miles and kilometers, but decided that distances were rarely large
    -- enough to warrent it.
    if QuestHelper_Pref.metric then
      text = QHFormat("DISTANCE_METRES", math.floor(0.5+dist*0.9144))
    else
      text = QHFormat("DISTANCE_YARDS", math.floor(0.5 + dist))
    end
  end
  
  status:SetText(text)

	-- Showing the arrival arrow?
	if dist and dist <= 10 then
		if not showDownArrow then
			showDownArrow = true
      QH_Arrow_SetScale()
			arrow:SetTexture("Interface\\AddOns\\QuestHelper\\arrow_image_down")
			arrow:SetVertexColor(0, 1, 0)
		end

		local cell = math.floor(mod(GetTime() * 20, 55)) -- 20 fps seems to be around the right number

		local column = cell % 9
		local row = floor(cell / 9)

		local xstart = (column * 53) / 512
		local ystart = (row * 70) / 512
		local xend = ((column + 1) * 53) / 512
		local yend = ((row + 1) * 70) / 512
		arrow:SetTexCoord(xstart,xend,ystart,yend)
	else
		if showDownArrow then
			showDownArrow = false
      QH_Arrow_SetScale()
			arrow:SetTexture("Interface\\AddOns\\QuestHelper\\arrow_image")
			showDownArrow = false
		end

		local angle = atan2(-dx, -dy) / 360 * (math.pi * 2) -- degrees. seriously what
    --if angle < 0 then angle = angle + math.pi * 2 end
		local player = GetPlayerFacing()
		angle = angle - player

		local perc = math.abs((math.pi - math.abs(angle)) / math.pi)
    if perc > 1 then perc = 2 - perc end -- siiigh

		local gr,gg,gb = 0, 1, 0
		local mr,mg,mb = 1, 1, 0
		local br,bg,bb = 1, 0, 0
		local r,g,b = ColorGradient(perc, br, bg, bb, mr, mg, mb, gr, gg, gb)		
		arrow:SetVertexColor(r,g,b)


		local cell = floor(angle / (math.pi * 2) * 108 + 0.5) % 108
		local column = cell % 9
		local row = floor(cell / 9)

		local xstart = (column * 56) / 512
		local ystart = (row * 42) / 512
		local xend = ((column + 1) * 56) / 512
		local yend = ((row + 1) * 42) / 512
		arrow:SetTexCoord(xstart,xend,ystart,yend)
	end

	-- Calculate the TTA every second  (%01d:%02d)

  --[[
  if elapsed then
    tta_throttle = tta_throttle + elapsed

    if tta_throttle >= 1.0 then
      -- Calculate the speed in yards per sec at which we're moving
      local current_speed = (last_distance - dist) / tta_throttle

      if last_distance == 0 then
        current_speed = 0
      end

      if speed_count < 2 then
        speed = (speed + current_speed) / 2
        speed_count = speed_count + 1
      else
        speed_count = 0
        speed = current_speed
      end

      if speed > 0 then
        local eta = math.abs(dist / speed)
        tta:SetFormattedText("%01d:%02d", eta / 60, eta % 60) 
      else
        tta:SetText("")
      end
      
      last_distance = dist
      tta_throttle = 0
    end
  end
  ]]
end

QH_Hook(wayframe, "OnUpdate", OnUpdate)


local function spacer()
  local htex = QuestHelper:CreateIconTexture(item, 10)
  htex:SetVertexColor(1, 1, 1, 0)
  return htex
end

function QH_Arrow_PopulateMenu(menu)
  local hide = QuestHelper:CreateMenuItem(menu, QuestHelper_Pref.arrow and QHText("QH_BUTTON_HIDE") or QHText("QH_BUTTON_SHOW"))
  hide:SetFunction(function () QuestHelper:ToggleArrow() end)
  --hide:AddTexture(spacer(), true)
  --hide:AddTexture(spacer(), false)
  
  local lock = QuestHelper:CreateMenuItem(menu, "Lock")
  local ltex = QuestHelper:CreateIconTexture(item, 10)
  lock:SetFunction(function () QuestHelper_Pref.arrow_locked = not QuestHelper_Pref.arrow_locked end)
  lock:AddTexture(ltex, true)
  lock:AddTexture(spacer(), false)
  ltex:SetVertexColor(1, 1, 1, QuestHelper_Pref.arrow_locked and 1 or 0)
  
  local scale = QuestHelper:CreateMenuItem(menu, "Arrow Scale")
  local scale_menu = QuestHelper:CreateMenu()
  scale:SetSubmenu(scale_menu)
  scale:AddTexture(spacer(), true)
  for i = 5, 15 do
    local it = QuestHelper:CreateMenuItem(scale_menu, string.format("%d%%", i * 10))
    local ix = i
    it:SetFunction(function () QH_Arrow_SetScale(ix / 10) end)
    local icon = QuestHelper:CreateIconTexture(item, 10)
    if QuestHelper_Pref.arrow_arrowsize == ix / 10 then
      icon:SetVertexColor(1, 1, 1, 1)
    else
      icon:SetVertexColor(1, 1, 1, 0)
    end
    it:AddTexture(icon)
  end
  
  local tscale = QuestHelper:CreateMenuItem(menu, "Text Scale")
  local tscale_menu = QuestHelper:CreateMenu()
  tscale:SetSubmenu(tscale_menu)
  tscale:AddTexture(spacer(), true)
  for i = 5, 15 do
    local it = QuestHelper:CreateMenuItem(tscale_menu, string.format("%d%%", i * 10))
    local ix = i
    it:SetFunction(function () QH_Arrow_SetTextScale(ix / 10) end)
    local icon = QuestHelper:CreateIconTexture(item, 10)
    if QuestHelper_Pref.arrow_textsize == ix / 10 then
      icon:SetVertexColor(1, 1, 1, 1)
    else
      icon:SetVertexColor(1, 1, 1, 0)
    end
    it:AddTexture(icon)
  end
  
  local reset = QuestHelper:CreateMenuItem(menu, QHText("SETTINGS_MENU_ARROW_RESET"))
  reset:SetFunction(function () QH_Arrow_Reset() end)
end

local function WayFrame_OnClick(self, button)
  local menu = QuestHelper:CreateMenu()
  QuestHelper:CreateMenuTitle(menu, QHText("SETTINGS_ARROWLINK_ARROW"))
  
  QH_Arrow_PopulateMenu(menu)
  
  local submenu = QuestHelper:CreateMenu()
  item = QuestHelper:CreateMenuItem(menu, "Objective")
  item:SetSubmenu(submenu)
  QH_Append_NextObjective(submenu)
  
  menu:ShowAtCursor()
end

wayframe:RegisterForClicks("RightButtonUp")
wayframe:SetScript("OnClick", WayFrame_OnClick)

QH_OnUpdate(OnUpdate)

