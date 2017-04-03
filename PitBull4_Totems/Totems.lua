if select(6, GetAddOnInfo("PitBull4_" .. (debugstack():match("[o%.][d%.][u%.]les\\(.-)\\") or ""))) ~= "MISSING" then return end

if select(2, UnitClass('player')) ~= "SHAMAN" then
	-- don't load if player is not a shaman.
	return
end

local _G = _G
local PitBull4 = _G.PitBull4
if not PitBull4 then
	error("PitBull4_Totems requires PitBull4")
end

local DEBUG = PitBull4.DEBUG

-- CONSTANTS ----------------------------------------------------------------
local MAX_TOTEMS = MAX_TOTEMS or 4 -- comes from blizzard's totem frame lua
local FIRE_TOTEM_SLOT  = FIRE_TOTEM_SLOT  or 1
local EARTH_TOTEM_SLOT = EARTH_TOTEM_SLOT or 2
local WATER_TOTEM_SLOT = WATER_TOTEM_SLOT or 3
local AIR_TOTEM_SLOT   = AIR_TOTEM_SLOT   or 4

local TOTEM_SIZE = 50 -- fixed value used for internal frame creation, change the final size ingame only!

local UPDATE_FREQUENCY = 0.25 -- delay this many second between timer updates

local CONFIG_MODE_ICON = [[Interface\Icons\Spell_Fire_TotemOfWrath]]
local BORDER_PATH  = [[Interface\AddOns\]] .. debugstack():match("[d%.][d%.][O%.]ns\\(.-)\\[A-Za-z]-%.lua") .. [[\border]]
local DEFAULT_SOUND_NAME = 'Drop'
local DEFAULT_SOUND_PATH =  [[Sound\interface\DropOnGround.wav]]

local COLOR_DEFAULTS = {
	main_background = {0, 0, 0, 0.5},
	timer_text = {0, 1, 0, 1},
	totem_border = {0, 0, 0, 0.5},
	slot1 = {1,0,0,1},
	slot2 = {0,1,0,1},
	slot3 = {0,1,1,1},
	slot4 = {0,0,1,1},
}

local LAYOUT_DEFAULTS = {
	attach_to = "root",
	location = "out_top_left",
	position = 1,
	size = 2, -- default to a 200% scaling, the 100% seems way too tiny.
	tlo1 = true, -- dummy for optiontests
	totem_spacing = 0,
	totem_direction = "h",
	timer_spiral = true,
	suppress_occ = true,
	timer_text = true,
	timer_text_side = "bottominside",
	line_break = MAX_TOTEMS,
	hide_inactive = false,
	bar_size = 1, -- needs to exist for "show as bar" option, unused for now
}

local ORDER_DEFAULTS = {}
for i = 1, MAX_TOTEMS do -- usually 4 but this is dynamic incase blizzard adds a new totem-element in the future
	ORDER_DEFAULTS[i] = i
end

local GLOBAL_DEFAULTS = {
	totem_tooltips = true,
	order = ORDER_DEFAULTS, -- this is the order _by_slot_ not by position!
	expiry_pulse = true,
	expiry_pulse_time = 5,
	recast_enabled = false,
	death_sound = false,
	colors = COLOR_DEFAULTS,
	totem_borders_per_element = true,
	text_color_per_element = false,
}

-- inject sounds for each slot (non-fixed amount)
for i = 1, MAX_TOTEMS do
	GLOBAL_DEFAULTS['sound_slot'..tostring(i)] = DEFAULT_SOUND_NAME
end


local GetTime = _G.GetTime
local floor = _G.math.floor
local ceil = _G.math.ceil
local max = _G.math.max
local min = _G.math.min
local tostring = _G.tostring
local type = _G.type
local GetTotemTimeLeft = _G.GetTotemTimeLeft
local GetTotemInfo = _G.GetTotemInfo
-----------------------------------------------------------------------------



local PitBull4_Totems = PitBull4:NewModule("Totems", "AceEvent-3.0", "AceTimer-3.0")
local self = PitBull4_Totems

if DEBUG then
	PBTDBG = PitBull4_Totems
end

-- Load LibSharedMedia
local LSM = LibStub("LibSharedMedia-3.0", true)
if not LSM then
	LoadAddOn("LibSharedMedia-3.0")
	LSM = LibStub("LibSharedMedia-3.0", true)
end

-- Register our default sound. (comes with the wow engine)
if LSM then LSM:Register('sound',DEFAULT_SOUND_NAME,DEFAULT_SOUND_PATH) end

LoadAddOn("AceGUI-3.0-SharedMediaWidgets")
local AceGUI = LibStub("AceGUI-3.0")

-- Fetch localization
local L = PitBull4.L

-- Register some metadata of ours with PB4
PitBull4_Totems:SetModuleType('indicator')
PitBull4_Totems:SetName(L["Totems"])
PitBull4_Totems:SetDescription(L["Show which Totems are dropped and the time left until they expire."])
PitBull4_Totems.show_font_option = true
PitBull4_Totems.show_font_size_option = true
PitBull4_Totems.can_set_side_to_center = false -- Intentionally deactivated until I find out how to scale the resulting pseudo-bar

local dbg
if DEBUG then
	function dbg(...)
		print(string.format(...))
	end
else
	function dbg() end
end

local function get_verbose_slot_name(slot)
	if slot == FIRE_TOTEM_SLOT then
		return L["Fire"]
	elseif slot == EARTH_TOTEM_SLOT then
		return L["Earth"]
	elseif slot == WATER_TOTEM_SLOT then
		return L["Water"]
	elseif slot == AIR_TOTEM_SLOT then
		return L["Air"]
	else
		return L["Unknown Slot "]..tostring(slot)
	end
end

--------------------------------------------------------------------------------
-- this function is borrowed from Got Wood which got it from neronix. 
function PitBull4_Totems:SecondsToTimeAbbrev(time)
	local m, s
	if( time < 0 ) then
		text = ""
	elseif( time < 3600 ) then
		m = floor(time / 60)
		s = time % 60
		if (m==0) then 
			text = ("0:%02d"):format(s)
		else
			text = ("%01d:%02d"):format(m, s)
		end
	end
	return text
end

--------------------------------------------------------------
--------------------------------------------------------------
--------------------------------------------------------------
-- Configuration Proxyfunctions
--    lowercase g, l and c refer to Global, Layout and Color Options
--    Note that Layout options require handing a frame, as layout options are individual per frame
-------------------------------
---- General Purpose Proxies
local function global_option_get(key)
	if type(key) == 'table' then
		return PitBull4_Totems.db.profile.global[key[#key]]
	else
		return PitBull4_Totems.db.profile.global[key]
	end
end
local function gOptSet(key, value)
	if type(key) == 'table' then
		PitBull4_Totems.db.profile.global[key[#key]] = value
	else
		PitBull4_Totems.db.profile.global[key] = value
	end
	PitBull4.Options.UpdateFrames()
end
local function color_option_get(key, default_r, default_g, default_b, default_a)
	local ret = nil
	if type(key) == 'table' then
		ret = PitBull4_Totems.db.profile.global.colors[key[#key]]
		
	else
		ret = PitBull4_Totems.db.profile.global.colors[key]
	end
	if not ret and default_r then
		return default_r, default_g, default_b, default_a
	end
	return unpack(ret)
end
local function color_option_set(key, r, g, b, a)
	if type(key) == 'table' then
		PitBull4_Totems.db.profile.global.colors[key[#key]] = {r, g, b, a} 
	else
		PitBull4_Totems.db.profile.global.colors[key] = {r, g, b, a} 
	end
	PitBull4.Options.UpdateFrames()
end

local function layout_option_get(frame, key)
	if type(key) == 'table' then
		return PitBull4_Totems:GetLayoutDB(frame)[key[#key]]
	else
		return PitBull4_Totems:GetLayoutDB(frame)[key]
	end
end
local function layout_option_set(frame, key, value)
	if type(key) == 'table' then
		PitBull4_Totems:GetLayoutDB(frame)[key[#key]]  = value
	else
		PitBull4_Totems:GetLayoutDB(frame)[key] = value
	end
	PitBull4.Options.UpdateFrames()
end


-------------------------------
---- Totem Order Proxies

local function get_order(slot)
	return global_option_get('order')[slot]
end

local function get_order_as_string(info)
	local slot = info.arg
	return tostring(get_order(slot))
end

local function get_slot_from_order(pos)
	for k,v in ipairs(global_option_get('order')) do
		if v == pos then
			return k
		end
	end
	dbg("ERROR: get_slot_from_order failed to find slot for pos "..tostring(pos))
	return nil -- this shouldn't ever happen
end

local function list_order(info)
	local slot = info.arg
	if not slot then
		local slot = -1
	end
	local choices = {}
	for i = 1, MAX_TOTEMS do
		choices[tostring(i)] = L["Position %i (Currently: %s)"]:format(i, get_verbose_slot_name(get_slot_from_order(i)))
	end
	return choices
end

local function set_order(info, new_order_position_string) -- global option
	local slot = info.arg
	local new_order_position = tonumber(new_order_position_string)
	for i = 1, MAX_TOTEMS do
		if not (i == slot) then
			if self.db.profile.global.order[i] == new_order_position then
				-- switch the position with the element that had it earlier
				self.db.profile.global.order[i] = get_order(slot)
				self.db.profile.global.order[slot] = new_order_position
				break
			end
		end
	end
	PitBull4.Options.UpdateFrames()
	return true
end

--------------------------------------------------------------
--------------------------------------------------------------
--------------------------------------------------------------
-- Totem Logic

-- Wrapper function to simulate totems most accurately when configmode is enabled.
local function MyGetTotemTimeLeft(slot, frame)
	if not frame.force_show then return GetTotemTimeLeft(slot) end
	
	-- Config mode is on, simulate some time.
	return 10*slot
end
-- Wrapper function to simulate totems most accurately when configmode is enabled.
local function MyGetTotemInfo(slot, frame)
	if not frame.force_show then return GetTotemInfo(slot) end
	
	-- Config mode on, simulate some fake totem info
	local fakeLeft = MyGetTotemTimeLeft(slot, frame)
	return true,
		"Fake Totem",
		ceil(GetTime()),
		119,
		CONFIG_MODE_ICON
end

function PitBull4_Totems:OneOrMoreDown()
	for i = 1, MAX_TOTEMS do
		if ( self.totem_is_down[i] == true ) then
			return true
		end
	end
	-- none is down
	return false
end

function PitBull4_Totems:StartTimer()
	if not self.timer_handle then
		self.timer_handle = self:ScheduleRepeatingTimer(function() PitBull4_Totems:UpdateAllTimes() end, 0.25)
	end
end

function PitBull4_Totems:StopTimer()
	if self.timer_handle then
		self:CancelTimer(self.timer_handle)
		self.timer_handle = nil
	end
end

function PitBull4_Totems:StartPulse(frame) -- starts a continuous pulse
	frame.pulse_stop_after_this = false
	frame.pulse_start = true
	frame.last_updated = 0
	if frame:GetScript("OnUpdate") == nil then
		frame:SetScript("OnUpdate", self.button_scripts.OnUpdate)
	end
end

function PitBull4_Totems:StartPulseOnce(frame) -- starts a single pulse
	frame.pulse_stop_after_this = true
	frame.pulse_start = true
	frame.last_updated = 0
	if frame:GetScript("OnUpdate") == nil then
		frame:SetScript("OnUpdate", self.button_scripts.OnUpdate)
	end
end

function PitBull4_Totems:StopPulse(frame)
	frame.pulse_stop_after_this = false
	frame.pulse_start = false
	frame.pulse_active = false
	if frame.pulse.icon:IsVisible() then
		frame.pulse.icon:Hide()
	end
	frame.last_updated = 0
	if frame:GetScript("OnUpdate") ~= nil then
		frame:SetScript("OnUpdate", nil)
	end
end


function PitBull4_Totems:UpdateAllTimes()
	for frame in PitBull4:IterateFrames() do
		local unit = frame.unit
		if unit and UnitIsUnit(unit,"player") and frame.Totems and frame.Totems.elements then
			
			local elements = frame.Totems.elements
			
			local nowTime = floor(GetTime())
			for slot=1, MAX_TOTEMS do
				if (not elements) or (not elements[slot]) or (not elements[slot].frame) then return end
				
				local timeleft = MyGetTotemTimeLeft(slot,frame)
				local _, _, _, _, icon = MyGetTotemInfo(slot, frame)
				
				if timeleft > 0 then
					-- need to update shown time
					if ( layout_option_get(frame,'timer_text') ) then
						elements[slot].text:SetText(self:SecondsToTimeAbbrev(timeleft))
					else
						elements[slot].text:SetText("")
					end
					
					-- check if we need to update the shown icon
					if icon ~= elements[slot].frame.totem_icon then
						--dbg("Timer is fixing icon in slot %s", tostring(slot))
						elements[slot].frame:SetNormalTexture(icon)
						elements[slot].frame.totem_icon = icon
						--elements[slot].frame:SetAlpha(1)
						elements[slot].frame:Show()
					end
					
					-- Hide the cooldown frame if it's shown and the user changed preference
					if ( not layout_option_get(frame,'timer_spiral') and elements[slot].spiral:IsShown() ) then
						elements[slot].spiral:Hide()
					end
					
					if global_option_get('expiry_pulse') and (timeleft < global_option_get('expiry_pulse_time')) and (timeleft > 0) then
						self:StartPulse(elements[slot].frame)
					else
						self:StopPulse(elements[slot].frame)
					end
				else
					-- Totem expired
					
					self:StopPulse(elements[slot].frame)
					elements[slot].frame:SetAlpha(0.5)
					if layout_option_get(frame,'hide_inactive') then
						elements[slot].frame:Hide()
					end
					elements[slot].text:SetText("")
					elements[slot].spiral:Hide()
				end
			end
		end
	end
end

function PitBull4_Totems:SpiralUpdate(frame,slot,start,left)
	if not frame.Totems then return end
	local tspiral = frame.Totems.elements[slot].spiral
	local startTime = start or select(3, MyGetTotemInfo(slot,frame))
	local timeLeft = left or MyGetTotemTimeLeft(slot,frame)
	
	tspiral:SetCooldown(startTime, timeLeft)
	if self.totem_is_down[slot] == true and layout_option_get(frame,'timer_spiral') then
		tspiral:Show()
	else
		tspiral:Hide()
	end
end


function PitBull4_Totems:ActivateTotem(slot)
	for frame in PitBull4:IterateFrames() do
		local unit = frame.unit
		if unit and UnitIsUnit(unit,"player") and self:GetLayoutDB(frame).enabled and frame.Totems then
			
			local haveTotem, name, startTime, duration, icon = MyGetTotemInfo(slot, frame)
			-- queried seperately because GetTotemInfo apprears to give less reliable results (wtf?!)
			local timeleft = MyGetTotemTimeLeft(slot, frame)
			
			if ( name == "" ) then
				--dbg("WARNING: Can't activate a nondropped totem")
				return
			end
			
			self.totem_is_down[slot] = true
			
			local tframe = frame.Totems.elements[slot].frame
			local ttext = frame.Totems.elements[slot].text
			
			tframe:SetNormalTexture(icon)
			tframe.totem_icon = icon
			tframe:SetAlpha(1)
			tframe:Show()
			tframe.force_show = frame.force_show -- set configmode as a property of the frame, so the buttonscripts know about it
			
			self:StopPulse(tframe)
			
			tframe.border:Show()
			if ( layout_option_get(frame,'timer_text') ) then
				ttext:SetText(self:SecondsToTimeAbbrev(timeleft))
			end
			self:SpiralUpdate(frame, slot, startTime, timeLeft)
			
			self:StartTimer()
		end
	end
end

function PitBull4_Totems:DeactivateTotem(slot)
	for frame in PitBull4:IterateFrames() do
		local unit = frame.unit
		if unit and UnitIsUnit(unit,"player") and self:GetLayoutDB(frame).enabled and frame.Totems then
			
			local haveTotem, name, startTime, duration, icon = MyGetTotemInfo(slot, frame)
			
			if ( name ~= "" ) then
				--dbg("WARNING: Can't deactivate a dropped totem")
				return
			end
			
			self.totem_is_down[slot] = false
			
			local tframe = frame.Totems.elements[slot].frame
			local ttext = frame.Totems.elements[slot].text
			local tspiral = frame.Totems.elements[slot].spiral
			
			-- cleanup timer event if no totems are down
			if not self:OneOrMoreDown() then
				self:StopTimer()
			end
			tspiral:Hide()
			
			self:StopPulse(tframe)
			
			tframe:SetAlpha(0.5)
			tframe.totem_icon = nil
			if layout_option_get(frame,'hide_inactive') then
				tframe:Hide()
			end
			ttext:SetText("")
		end
	end
end

--------------------------------------------------------------
--------------------------------------------------------------
--------------------------------------------------------------
-- Frame functions


function PitBull4_Totems:ResizeMainFrame(frame)
	if not frame.Totems then
		return
	end
	local tSpacing = layout_option_get(frame,'totem_spacing')
	local lbreak = layout_option_get(frame,'line_break')
	local nlines = ceil(MAX_TOTEMS / lbreak)
	local ttf = frame.Totems
	local width = nil
	local height = nil
	if (layout_option_get(frame,'totem_direction') == "h") then
		width = (lbreak*TOTEM_SIZE)+((lbreak-1)*tSpacing)
		height = (nlines*TOTEM_SIZE)+((nlines-1)*tSpacing)
		ttf.height = nlines + ((nlines-1)*(tSpacing/TOTEM_SIZE))
	else
		width = (nlines*TOTEM_SIZE)+((nlines-1)*tSpacing) 
		height = (lbreak*TOTEM_SIZE)+((lbreak-1)*tSpacing)
		ttf.height = lbreak + ((lbreak-1)*(tSpacing/TOTEM_SIZE))
	end
	ttf:SetWidth(width)
	ttf:SetHeight(height)
end

function PitBull4_Totems:RealignTotems(frame)
	local lbreak = layout_option_get(frame,'line_break') or MAX_TOTEMS
	local tspacing = layout_option_get(frame,'totem_spacing') or 0

	if frame.Totems then
		local elements = frame.Totems.elements
		for i = 1, MAX_TOTEMS do
			local o = get_slot_from_order(i)
			
			
			if (not o) then
				return
			end
			
			if i==1 then
				elements[o].frame:ClearAllPoints()
				elements[o].frame:SetPoint("TOPLEFT", frame.Totems, "TOPLEFT", 0, 0)
			else
				elements[o].frame:ClearAllPoints()
				-- Attach the button to the previous one
				if (layout_option_get(frame,'totem_direction') == "h") then
					-- grow horizontally
					if ((i - 1) % lbreak == 0) then
						-- Reached a line_break
						local o3 = get_slot_from_order(i-lbreak)
						elements[o].frame:SetPoint("TOPLEFT", elements[o3].frame, "BOTTOMLEFT", 0, 0-tspacing)
					else
						local o2 = get_slot_from_order(i-1)
						elements[o].frame:SetPoint("TOPLEFT", elements[o2].frame, "TOPRIGHT", tspacing, 0)
					end
				else
					--grow vertically
					if ((i - 1) % lbreak == 0) then
						local o3 = get_slot_from_order(i-lbreak)
						elements[o].frame:SetPoint("TOPLEFT", elements[o3].frame, "TOPRIGHT", tspacing, 0)
					else
						local o2 = get_slot_from_order(i-1)
						elements[o].frame:SetPoint("TOPLEFT", elements[o2].frame, "BOTTOMLEFT", 0, 0-tspacing)
					end
				end
			end
		end
		self:RealignTimerTexts(frame)
	end
end

local function TimerTextAlignmentLogic(frame, parent, side, offsetX, offsetY) 
	if ((not frame) or (not parent)) then
		return
	end
	
	local offX = offsetX or 0
	local offY = offsetY or 0
	frame:ClearAllPoints()
	if side == "topinside" then
		frame:SetPoint("TOP", parent, "TOP", offX, offY)
	elseif side == "topoutside" then
		frame:SetPoint("BOTTOM", parent, "TOP", offX, offY)
	elseif side == "bottominside" then
		frame:SetPoint("BOTTOM", parent, "BOTTOM", offX, offY)
	elseif side == "bottomoutside" then
		frame:SetPoint("TOP", parent, "BOTTOM", offX, offY)
	elseif side == "leftoutside" then
		frame:SetPoint("RIGHT", parent, "LEFT", offX, offY)
	elseif side == "rightoutside" then
		frame:SetPoint("LEFT", parent, "RIGHT", offX, offY)
	elseif side == "middle" then
		frame:SetPoint("CENTER", parent, "CENTER", offX, offY)
	else
		return
	end
	
end

function PitBull4_Totems:RealignTimerTexts(frame)
	if not frame or not frame.Totems then return end

	local elements = frame.Totems.elements
	for i = 1, MAX_TOTEMS do
		if (elements[i].text) then
			TimerTextAlignmentLogic(elements[i].text, elements[i].textFrame, layout_option_get(frame, 'timer_text_side'), 0, 0)
			local font, fontsize = self:GetFont(frame)
			elements[i].text:SetFont(font, fontsize, "OUTLINE")

			if global_option_get('text_color_per_element') then
				elements[i].text:SetTextColor(color_option_get('slot'..tostring(i), 1,1,1,1))
			else
				elements[i].text:SetTextColor(color_option_get('timer_text'))
			end
			
		end
	end
end

function PitBull4_Totems:UpdateIconColor(frame)
	if frame.Totems and frame.Totems.elements then
		local elements = frame.Totems.elements
		for i = 1, MAX_TOTEMS do
			if elements[i].frame and elements[i].frame.border then
				elements[i].frame.border:Hide()
				if global_option_get('totem_borders_per_element') then
					elements[i].frame.border:SetVertexColor(color_option_get('slot'..tostring(i), 1,1,1,1))
				else
					elements[i].frame.border:SetVertexColor(color_option_get('totem_border'))
				end
				elements[i].frame.border:Show()
			end
		end
	end
end

PitBull4_Totems.button_scripts = {}

function PitBull4_Totems.button_scripts:OnClick(mousebutton)
	if (mousebutton == "RightButton" and self.slot and not self.force_show) then
		DestroyTotem( self.slot )
	end
end

function PitBull4_Totems.button_scripts:OnEnter()
	if self.force_show then return end
	if ( self.slot and self.totem_tooltips ) then
		-- setting the tooltip
		GameTooltip_SetDefaultAnchor(GameTooltip, self)
		GameTooltip:SetTotem(self.slot)
	end
end

function PitBull4_Totems.button_scripts:OnLeave()
	if self.force_show then return end
	if ( self.totem_tooltips ) then
		-- hiding the tooltip
		GameTooltip:Hide()
	end
end

-- inline credits: Parts of the following function were heavily inspired by the addon CooldownButtons by Dodge (permission given)
function PitBull4_Totems.button_scripts:OnUpdate(elapsed)
	if not self:IsVisible() then 
		return -- nothing to do when we aren't visible
	end
	
	if self.last_update > elapsed then
		self.last_update = self.last_update - elapsed
		return
	else
		self.last_update = 0.75
	end

	-- start a pulse if it isn't active yet, if it is, do the animation as normal
	if self.pulse_start then
		self.pulse.icon:Hide()
		self.last_update = 0
		if not self.pulse_active then
			-- Pulse isn't active yet so we start it
			local icon = self.texture
			if self:IsVisible() then
				local pulse = self.pulse
				if pulse then
					pulse.scale = 1
					pulse.icon:SetTexture(self.totem_icon)
					self.pulse_active = true
					--dbg("DEBUG: Starting pulse on slot %i, elapsed is: %s", self.slot, tostring(elapsed))
				end
			end
		else
			-- Pulse is already active, do the animation...
			local pulse = self.pulse
			if pulse.scale >= 2 then
				pulse.dec = 1
			elseif pulse.scale <= 1 then
				pulse.dec = nil
			end
			pulse.scale = max(min(pulse.scale + (pulse.dec and -1 or 1) * pulse.scale * (elapsed/0.5), 2), 1)
			
			
			if self.pulse_stop_after_this and pulse.scale <= 1 then
				-- Pulse animation is to be stopped now.
				pulse.icon:Hide()
				pulse.dec = nil
				self.pulse_active = false
				self.pulse_start = false
				self.pulse_stop_after_this = false

				if self.hide_inactive then
					self:Hide()
				end
				
				--dbg("DEBUG: Stopping pulse on slot %i", self.slot)
			else
				-- Applying the new scaling (animation frame)
				--dbg("DEBUG: Showing with scale %s", tostring(pulse.scale))
				pulse.icon:Show()
				pulse.icon:SetHeight(pulse:GetHeight() * pulse.scale)
				pulse.icon:SetWidth(pulse:GetWidth() * pulse.scale)
			end
		end
		
	end
end




function PitBull4_Totems:PLAYER_TOTEM_UPDATE(event, slot)
	local sSlot = tostring(slot)

	for frame in PitBull4:IterateFrames() do
		local unit = frame.unit
		if unit and UnitIsUnit(unit,"player") and self:GetLayoutDB(frame).enabled and frame.Totems then
			local haveTotem, name, startTime, duration, icon = MyGetTotemInfo(slot,frame)
			if ( haveTotem and name ~= "") then
				-- New totem created
				self:ActivateTotem(slot)
			elseif ( haveTotem ) then
				-- Totem just got removed or killed.
				self:DeactivateTotem(slot)
				
				-- Sound functions
				if global_option_get('death_sound') and not (event == nil) then
					local soundpath = DEFAULT_SOUND_PATH 
					if LSM then
						soundpath = LSM:Fetch('sound', global_option_get('sound_slot'..tostring(slot)))
					end
					--dbg('Playing Death sound for slot %s: %s', tostring(slot), tostring(soundpath))
					PlaySoundFile(soundpath)
				end
			end
		end
	end
end

function PitBull4_Totems:ForceSilentTotemUpdate()
	for i = 1, MAX_TOTEMS do
		self:PLAYER_TOTEM_UPDATE(nil, i) -- we intentionally send a nil event (to avoid sounds)
	end
end

function PitBull4_Totems:PLAYER_ENTERING_WORLD(...)
	-- we simulate totem events whenever a player zones to make sure totems left back in the instance hide properly.
	self:ForceSilentTotemUpdate()
end

function PitBull4_Totems:BuildFrames(frame)
	if not frame then return end -- not enough legit parameters
	if frame.Totems then return end -- Can't create the frames when they already exist..

	local font, fontsize = self:GetFont(frame)
	local tSpacing = layout_option_get(frame,'totem_spacing')
	
	-- Main frame
	
	frame.Totems = PitBull4.Controls.MakeFrame(frame)
	local ttf = frame.Totems

	if (layout_option_get(frame,'totem_direction') == "h") then
		ttf:SetWidth((MAX_TOTEMS*TOTEM_SIZE)+((MAX_TOTEMS-1)*tSpacing))
		ttf:SetHeight(TOTEM_SIZE)
	else
		ttf:SetWidth(TOTEM_SIZE)
		ttf:SetHeight((MAX_TOTEMS*TOTEM_SIZE)+((MAX_TOTEMS-1)*tSpacing))
	end
	ttf:Show()
	
	-- Main background
	if not ttf.background then
		ttf.background = PitBull4.Controls.MakeTexture(ttf, "BACKGROUND")
	end
	local bg = ttf.background
	bg:SetTexture(color_option_get('main_background'))
	bg:SetAllPoints(ttf)
	
	-- Now create the main timer frames for each totem element
	local elements = {}
	for i = 1, MAX_TOTEMS do
		-------------------------------
		-- Main totem slot frame
		elements[i] = {}
		if not elements[i].frame then
			elements[i].frame = PitBull4.Controls.MakeButton(ttf)
		end
		local frm = elements[i].frame
		
		frm:SetWidth(TOTEM_SIZE)
		frm:SetHeight(TOTEM_SIZE)
		frm:SetFrameLevel(frame:GetFrameLevel() + 3)
		frm:Hide()
		frm.slot = i
		frm.hide_inactive = layout_option_get(frame,'hide_inactive')
		
		if frm.totem_icon then -- we're already supposed to show something!
			frm:SetNormalTexture(frm.totem_icon)
			frm:SetAlpha(1)
			frm:Show()
		else
			frm:SetNormalTexture(CONFIG_MODE_ICON)
		end
		
		-------------------------------
		-- totem slot border frame
		if not frm.border then
			frm.border = PitBull4.Controls.MakeTexture(frm, "OVERLAY")
		end
		local border = frm.border
		border:SetAlpha(1)
		border:ClearAllPoints()
		border:SetAllPoints(frm)
		border:SetTexture(BORDER_PATH)
		border:Show()
		
		----------------------------
		-- Spiral cooldown frame
		if not elements[i].spiral then
			elements[i].spiral = PitBull4.Controls.MakeCooldown(frm)
		end
		local spiral = elements[i].spiral
		spiral:SetReverse(true)
		spiral:SetAllPoints(frm)
		if ( layout_option_get(frame,'suppress_occ') ) then
			-- user wishes to suppress omnicc on his timer spiral, requires recent (post-2.4) omnicc version!
			if OMNICC_VERSION and OMNICC_VERSION < 210 then
				spiral.noomnicc = true
			else
				spiral.noCooldownCount = true
			end
		end
		
		--------------------
		-- Text frame
		if not elements[i].textFrame then
			elements[i].textFrame = PitBull4.Controls.MakeFrame(frame)
		end
		local textFrame = elements[i].textFrame
		textFrame:SetScale(max(0.01,frm:GetScale()))
		textFrame:SetAllPoints(frm)
		textFrame:SetFrameLevel(spiral:GetFrameLevel() + 7)
		
		if not elements[i].text then
			elements[i].text = PitBull4.Controls.MakeFontString(textFrame, "OVERLAY")
		end
		local text = elements[i].text
		text:ClearAllPoints()
		text:SetPoint("BOTTOM", textFrame, "BOTTOM", 0, 0)
		text:SetWidth(TOTEM_SIZE)
		text:SetHeight(TOTEM_SIZE/3)
		text:SetFont(font, fontsize, "OUTLINE")
		text:SetShadowColor(0,0,0,1)
		text:SetShadowOffset(0.8, -0.8)
		text:SetTextColor(color_option_get('timer_text'))
		text:Show()
		
		--------------------
		-- Pulse frame
		if not frm.pulse then
			frm.pulse = PitBull4.Controls.MakeFrame(frm)
		end
		local pulse = frm.pulse
		pulse:SetAllPoints(frm)
		pulse:SetToplevel(true)
		if not pulse.icon then
			pulse.icon = PitBull4.Controls.MakeTexture(frm, "OVERLAY")
		end
		pulse.icon:SetPoint("CENTER")
		pulse.icon:SetBlendMode("ADD")
		pulse.icon:SetVertexColor(0.5,0.5,0.5,0.7)
		pulse.icon:SetHeight(frm:GetHeight())
		pulse.icon:SetWidth(frm:GetWidth())
		pulse.icon:Hide()
		frm.pulse_active = false
		frm.pulse_start = false
		
		
		-----------------
		-- Click handling
		-- click handling for destroying single totems
		frm:RegisterForClicks("RightButtonUp")
		frm:SetScript("OnClick", self.button_scripts.OnClick)
		-- tooltip handling
		frm:SetScript("OnEnter", self.button_scripts.OnEnter)
		frm:SetScript("OnLeave", self.button_scripts.OnLeave)
		frm.last_update = 1
		frm:SetScript("OnUpdate", self.button_scripts.OnUpdate)
	end
	
	ttf.elements = elements
	
end

function PitBull4_Totems:ApplyLayoutSettings(frame)
	if not frame or not frame.Totems then return end

	self:RealignTotems(frame)
	
	local elements = frame.Totems.elements

	for i = 1, MAX_TOTEMS do
		elements[i].frame.hide_inactive = layout_option_get(frame,'hide_inactive')
		
		elements[i].frame.totem_tooltips = global_option_get('totem_tooltips')
		
		self:SpiralUpdate(frame, i, nil, nil)
	end
	
	
	self:ResizeMainFrame(frame)
	
	-- Background color of the main frame
	frame.Totems.background:SetTexture(color_option_get('main_background'))
	
	-- Bordercolor of the buttons
	self:UpdateIconColor(frame)

	-- Update timer_text settings
	self:RealignTimerTexts(frame)
end

function PitBull4_Totems:UpdateFrame(frame)
	local unit = frame.unit
	if not unit or not UnitIsUnit(unit,"player") then -- we only work for the player unit itself
		return self:ClearFrame(frame)
	end
	if frame.is_wacky then
		-- Disable for wacky frames, because something... wacky is going on with their updates.
		return self:ClearFrame(frame)
	end
	
	if (layout_option_get(frame,'enabled') ~= true) and frame.Totems then
		return self:ClearFrame(frame)
	end
	
	if frame.Totems then
		-- Workaround for Worldmap hiding elements the moment it's shown. 
		-- Basically, if frame.Totems exists, it has no reason to be hidden ever...
		if not frame.Totems:IsShown() then
			frame.Totems:Show()
		end
		
		-- make sure the timer is still running (it gets deactivated if the frame is gone for a moment)
		self:StartTimer()
		
		-- Now rebuild most of the layout since some setting might have changed.
		self:ApplyLayoutSettings(frame)
		self:ForceSilentTotemUpdate()
		return false -- our frame exists already, nothing more to do...
	else
		self:BuildFrames(frame)
		self:ApplyLayoutSettings(frame)
		self:ForceSilentTotemUpdate()
		return true
	end
end



function PitBull4_Totems:ClearFrame(frame)
	if not frame.Totems then
		return false
	end
	
	--self:StopTimer() 
	-- we're not stopping the timer anymore because we're not the only possible frame active
	
	--cleanup the element frames
	for i = 1, MAX_TOTEMS do
		local element = frame.Totems.elements[i]
		
		if element.pulse and element.pulse.icon then
			element.pulse.icon = element.pulse.icon:Delete()
		end
		if element.pulse then
			element.pulse = element.pulse:Delete()
		end
		if element.text then
			element.text = element.text:Delete()
		end
		if element.textFrame then
			element.textFrame = element.textFrame:Delete()
		end
		if element.spiral then
			element.spiral = element.spiral:Delete()
		end
		if element.border then
			element.border = element.border:Delete()
		end
		if element.frame then
			element.frame = element.frame:Delete()
		end
	end
	
	frame.Totems.background = frame.Totems.background:Delete()
	frame.Totems = frame.Totems:Delete()
	
	return true
end

function PitBull4_Totems:OnEnable()
	self:RegisterEvent("PLAYER_TOTEM_UPDATE")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
end

function PitBull4_Totems:OnInitialize()
	-- Initialize Timer variables
	self.totem_is_down = {}
	for i = 1,MAX_TOTEMS do
		self.totem_is_down[i] = false
	end
	
	self.timer_handle = nil	-- used for storing the reference to the ace3 timer
end


PitBull4_Totems:SetDefaults(LAYOUT_DEFAULTS, GLOBAL_DEFAULTS)

PitBull4_Totems:SetLayoutOptionsFunction(function(self)
	local function get(info)
		local id = info[#info]
		return PitBull4.Options.GetLayoutDB(self)[id]
	end
	local function set(info, value)
		local id = info[#info]
		PitBull4.Options.GetLayoutDB(self)[id] = value
		PitBull4.Options.UpdateFrames()
	end
	local function disabled(info)
		return not PitBull4.Options.GetLayoutDB(self).enabled
	end


	return 'totem_spacing', {
		type = 'range',
		name = L["Totem Spacing"],
		desc = L["Sets the size of the gap between the totem icons."],
		min = 0,
		max = 100,
		step = 1,
		get = get,
		set = set,
		disabled = disabled,
		order = 12,
	},
	'totem_direction', {
		type = 'select',
		name = L["Totem Direction"],
		desc = L["Choose wether to grow horizontally or vertically."],
		get = get,
		set = set,
		values = {
			["h"] = L["Horizontal"],
			["v"] = L["Vertical"]
		},
		style = "radio",
		disabled = disabled,
		order = 13,
	},
	'line_break', {
		type = 'range',
		name = L["Totems per line"],
		desc = L["How many totems to draw per line."],
		min = 1,
		max = MAX_TOTEMS,
		step = 1,
		get = get,
		set = set,
		disabled = disabled,
		order = 14,
	},
	'hide_inactive', {
		type = 'toggle',
		name = L["Hide inactive"],
		desc = L["Hides inactive totem icons completely."],
		get = get,
		set = set,
		disabled = disabled,
		order = 15,
	},
	'group_timer_spiral', {
		type = 'group',
		name = L["Spiral Timer"],
		desc = L["Options relating to the spiral display timer."],
		inline = true,
		order = 18,
		disabled = disabled,
		args = {
			timer_spiral = {
				type = 'toggle',
				name = L["Enabled"],
				desc = L["Shows the pie-like cooldown spiral on the icons."],
				get = get,
				set = set,
				disabled = disabled,
				order = 1,
			},
			suppress_occ = {
				type = 'toggle',
				name = L["Suppress Cooldown Counts"],
				desc = L["Tries to suppress CooldownCount-like addons on the spiral timer. (Requires UI reload to change the setting!)"],
				get = get,
				set = set,
				width = 'full',
				disabled = function() return not get({'timer_spiral'}) or disabled() end,
				order = 2,
			},
		},
	},
	'group_timer_text', {
		type = 'group',
		name = L["Text Timer"],
		desc = L["Options relating to the text display timer."],
		inline = true,
		order = 19,
		disabled = disabled,
		args = {
			timer_text = {
				type = 'toggle',
				name = L["Enabled"],
				desc = L["Shows the remaining time in as text."],
				get = get,
				set = set,
				order = 1,
				disabled = disabled,
			},
			timer_text_side = {
				type = 'select',
				name = L["Location"],
				desc = L["What location to position the timer text at."],
				values = {
					topinside = L["Top, Inside"],
					topoutside = L["Top, Outside"],
					bottominside = L["Bottom, Inside"],
					bottomoutside = L["Bottom, Outside"],
					leftoutside = L["Left, Outside"],
					rightoutside = L["Right, Outside"],
					middle = L["Middle"],
				},
				get = get,
				set = set,
				disabled = function() return not get({'timer_text'}) or disabled()  end,
				order = 3,
			},
		}
	},
	'global_notice_header', {
		type = 'header',
		name = L["Did you know?"],
		order = 30,
	},
	'global_notice_description', {
		type = 'description',
		name = L["There are more options for this module in the Modules -> Totems section."],
		order = 31,
	},
	'header_player_only', {
		type = 'header',
		name = L["Note"],
		order = 33,
	},
	'description_player_only', {
		type = 'description',
		name = L["Totems only show for the Player. On all other units the frame will not be there, even when enabled in the layout of the frame."],
		order = 34,
	}
end)

local function get_order_option_group()
	local oo = {}
	oo['order_description'] = {
		type = 'description',
		name = L["Define your preferred order in which the lements will be displayed. The numbers describe positions from left to right."],
		order = 1,
	}
	for i = 1, MAX_TOTEMS do
		local verbose_name = get_verbose_slot_name(i)
		local slot = { 
			type = 'select',
			style = 'dropdown',
			width = 'double',
			name = verbose_name,
			desc = verbose_name,
			values = list_order,
			get = get_order_as_string,
			set = set_order,
			arg = i,
			order = 10+i,
			--disabled = getHide,
		}
		oo["slot"..tostring(i)] = slot
	end
	return oo
end

local function get_elements_color_group()
	local function get(info)
		return color_option_get(info, 1,1,1,1 )
	end
	local function set(info, ...)
		color_option_set(info, ...)
	end
	
	local oo = {}
	
	oo['colordesc'] = {
		type = 'description',
		name = L["These color definitions will be used by per-element settings that need seperate color info per element."],
		order = 1,
	}
	
	for i = 1, MAX_TOTEMS do
		local verbose_name = get_verbose_slot_name(i)
		local slot = { 
			type = 'color',
			name = verbose_name,
			desc = verbose_name,
			hasAlpha = true,
			get = get,
			set = set,
			arg = i,
			order = 10+i,
			--disabled = getHide,
		}
		oo['slot'..tostring(i)] = slot
	end
	return oo
end

local function get_sound_option_group()
	local so = {}
	so['death_sound'] = {
		type = 'toggle',
		width = 'full',
		name = L["Totemsounds"],
		desc = L["This plays a sound file when a totem expires or gets destroyed. Individual sounds can be set per element."],
		get = global_option_get,
		set = gOptSet,
		order = 1,
	}
	if LSM then
		for i = 1, MAX_TOTEMS do
			local verbose_name = get_verbose_slot_name(i)
			local slot = { 
				name = verbose_name,
				desc = verbose_name,
				type = 'select',
				width = 'double',
				values = AceGUIWidgetLSMlists.sound,
				get = function(info)
					return global_option_get(info) or DEFAULT_SOUND_NAME
				end,
				set = gOptSet,
				arg = i,
				disabled = function() return not global_option_get('death_sound') end,
				order = 10 + i,
				dialogControl = AceGUI.WidgetRegistry["LSM30_Sound"] and "LSM30_Sound" or nil,
			}
			so["sound_slot"..tostring(i)] = slot
		end
	else
		so['no_libsharedmedia_sound_header'] = { 
			type = 'header',
			name = L["No LibSharedMedia detected"],
			order = 2,
		}
		so['no_libsharedmedia_sound_description'] = {
			type = 'description',
			name = L["You do not appear to have any addon installed that uses LibSharedMedia. If you want to select which sounds are used it is recommended that you install at least the 'SharedMedia' addon. (Don't install the 'LibSharedMedia' library yourself.)"],
			order = 3,
		}
	end
	return so
end

PitBull4_Totems:SetGlobalOptionsFunction(function(self)
	return 'layout_notice_header', {
		type = 'header',
		name = L["Did you know?"],
		order = 128,
		width = 'full',
	},
	'layout_notice_description', {
		type = 'description',
		name = L["There are more options for this module in the Layout editor -> Indicators -> Totems section."],
		order = 129,
		width = 'full',
	},
	'totem_tooltips', {
		type = 'toggle',
		width = 'full',
		name = L["Totem Tooltips"],
		desc = L["Enables tooltips when hovering over the icons."],
		get = global_option_get,
		set = gOptSet,
		order = 110,
	},
	'group_pulse', {
		type = 'group',
		name = L["Pulsing"],
		desc = L["Options related to the pulsing visualisation."],
		order = 111,
		inline = true,
		args = {
			expiry_pulse = {
				type = 'toggle',
				width = 'full',
				name = L["Expiry pulse"],
				desc = L["Causes the icon to pulse in the last few seconds of its lifetime."],
				get = global_option_get,
				set = gOptSet,
				order = 10,
			},
			expiry_pulse_time = {
				type = 'range',
				width = 'double',
				name = L["Expiry time"],
				desc = L["Pulse for this many seconds before the totem runs out."],
				min = 0.5,
				max = 60,
				step = 0.5,
				get = global_option_get,
				set = gOptSet,
				order = 11,
				disabled = function() return not global_option_get('expiry_pulse') end
			},
		},
	},

	'group_totem_order', {
		type = 'group',
		name = L["Order"],
		desc = L["The order in which the elements appear."],
		order = 113,
		inline = true,
		args = get_order_option_group(),
	},
	'group_totem_sound', {
		type = 'group',
		name = L["Sounds"],
		desc = L["Options relating to sound effects on totem events."],
		order = 114,
		inline = true,
		args = get_sound_option_group(),
	} 
end)

PitBull4_Totems:SetColorOptionsFunction(function(self)
	local function get(info)
		local id = info[#info]
		return unpack(self.db.profile.global.colors[id])
	end
	local function set(info, r, g, b, a)
		local id = info[#info]
		self.db.profile.global.colors[id] = {r, g, b, a} 
		self:UpdateAll()
	end
	return 'color_group_frames', {
		type = 'group',
		name = L["Backgrounds"],
		inline = true,
		args = {
			main_background = { -- color option
				type = 'color',
				name = L["Main Background"],
				desc = L["Sets the color and transparency of the background of the timers."],
				hasAlpha = true,
				get = get,
				set = set,
				width = 'full',
				order = 1
			},
		}
	},
	'color_group_icon_border', {
		type = 'group',
		name = L["Borders"],
		inline = true,
		args = {
			totem_border = { -- color option
				type = 'color',
				name = L["Icon"],
				desc = L["Sets the color of the individual iconborders."],
				hasAlpha = true,
				get = get,
				set = set,
				order = 1,
				disabled = function() return global_option_get('totem_borders_per_element') end
			},
			totem_borders_per_element = { -- global option
				type = 'toggle',
				name = L["Color Icon by Element"],
				get = global_option_get,
				set = gOptSet,
				order = 2,
			},
		}
	},
	'color_group_timer_text', {
		type = 'group',
		name = L["Text Timer"],
		inline = true,
		args = {
			timer_text = { -- color option
				type = 'color',
				name = L["Text"],
				desc = L["Color of the timer text."],
				hasAlpha = true,
				get = get,
				set = set,
				order = 1,
				disabled = function() return global_option_get('text_color_per_element') end,
			},
			text_color_per_element = { --global option
				type = 'toggle',
				name = L["Color Text by Element"],
				get = global_option_get,
				set = gOptSet,
				order = 2,
			},
		}
	}, 
	'color_group_elements', {
		type = 'group',
		name = L["Elements"],
		inline = true,
		args = get_elements_color_group(), 
	}, function(info)
		local db = self.db.profile.global.colors
		for setting,value in pairs(COLOR_DEFAULTS) do
			if type(value) == "table" then
				for i = 1, #value do
					db[setting][i] = value[i]
				end
			else
				db[setting] = value
			end
		end
		gOptSet('totem_borders_per_element', true)
		gOptSet('text_color_per_element', false)
		-- update frames...
		self:UpdateAll()
	end
end)

