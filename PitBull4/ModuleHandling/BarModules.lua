-- This file provides the template for the bar and bar_provider modules.

local _G = _G
local PitBull4 = _G.PitBull4

local DEBUG = PitBull4.DEBUG
local expect = PitBull4.expect
local new, del = PitBull4.new, PitBull4.del

--
-- Shared code between bar and bar_provider modules.
--

local LibSharedMedia = LibStub("LibSharedMedia-3.0", true)
if not LibSharedMedia then
	LoadAddOn("LibSharedMedia-3.0")
	LibSharedMedia = LibStub("LibSharedMedia-3.0", true)
end

local HOSTILE_REACTION = 2
local NEUTRAL_REACTION = 4
local FRIENDLY_REACTION = 5

local _,player_class = UnitClass("player")
local player_is_hunter = player_class == "HUNTER"
local happiness_map = {
	"unhappy",
	"content",
	"happy",
}

--- Call the :GetValue function on the bar module regarding the given frame.
-- @param self the module
-- @param frame the frame to get the value of
-- @param bar_db the layout db for the specific bar (only passed for bar provider modules)
-- @usage local value, extra = call_value_function(MyModule, someFrame)
-- @return nil or a number within [0, 1]
-- @return nil or a number within (0, 1 - value]
local function call_value_function(self, frame, bar_db)
	if not self.GetValue then
		return nil, nil
	end
	local value, extra, icon
	-- The extra frame.unit test here is a workaround for ticket 475.  It's not the
	-- real fix.  The unit should never end up unset when the guid is set.  However,
	-- this will stop users from seeing this failure in our state management while
	-- not causing any real problems.
	if frame.guid and frame.unit then
		value, extra, icon = self:GetValue(frame, bar_db)
	end
	
	if not value and frame.force_show and self.GetExampleValue then
		value, extra, icon = self:GetExampleValue(frame, bar_db)
	end
	if not value then
		return nil, nil, nil
	end
	if value < 0 or value ~= value then -- NaN
		value = 0
	elseif value > 1 then
		value = 1
	end
	if not extra or extra <= 0 or extra ~= extra then -- NaN
		return value, nil, icon
	end
	
	local max = 1 - value
	if extra > max then
		extra = max
	end
	
	return value, extra, icon
end

--- Call the :GetColor function on the status bar module regarding the given frame.
--- Call the color function which the current status bar module has registered regarding the given frame.
-- @param self the module
-- @param frame the frame to get the color of
-- @param bar_db the layout db for the specific bar (only passed for bar provider modules)
-- @param value the value as returned by call_value_function
-- @param extra the extra value as returned by call_value_function
-- @param icon the icon path as returned by call_value_function
-- @usage local r, g, b, a = call_color_function(MyModule, someFrame)
-- @return red value within [0, 1]
-- @return green value within [0, 1]
-- @return blue value within [0, 1]
-- @return alpha value within [0, 1]
local function call_color_function(self, frame, bar_db, value, extra, icon)
	local bar_provider = true 
	if not bar_db then
		bar_provider = false
		bar_db = self:GetLayoutDB(frame)
	end
	local custom_color = bar_db.custom_color
	
	if not self.GetColor then
		if custom_color then
			return custom_color[1], custom_color[2], custom_color[3], bar_db.alpha 
		else
			return 0.7, 0.7, 0.7, bar_db.alpha 
		end
	end
	local r, g, b, a, override
	if frame.guid then
		if bar_provider then
			r, g, b, a, override = self:GetColor(frame, bar_db, value, extra, icon)
		else
			r, g, b, a, override = self:GetColor(frame, value, extra, icon)
		end
	end
	if not override then
		local unit = frame.unit
		if custom_color then
			if a then
				a = a * bar_db.alpha
			else
				a = bar_db.alpha
			end
			if a and a < 0 then
				a = 0
			elseif a and a > 1 then
				a = 1
			end
			return custom_color[1], custom_color[2], custom_color[3], a
		elseif unit then
			local happiness
			if player_is_hunter and bar_db.color_by_happiness and UnitIsUnit(unit, "pet") then
				-- If we're configured to color the bar by happiness then capture the pet happiness
				-- value and save it for later.  It's split like this so that in case the pet doesn't
				-- have a hapiness value for some reason then it falls through to the normal NPC code.
				happiness = GetPetHappiness()
			end

			if UnitIsPlayer(unit) then
				if bar_db.color_by_class and (bar_db.color_pvp_by_class or UnitIsFriend("player", unit)) then
					local _, class = UnitClass(unit)
					local t = PitBull4.ClassColors[class]
					if t then
						r, g, b = t[1], t[2], t[3]
					end
				elseif bar_db.hostility_color then
					if UnitCanAttack(unit, "player") then
						-- they can attack me
						if UnitCanAttack("player", unit) then
							-- and I can attack them
							r, g, b = unpack(PitBull4.ReactionColors[HOSTILE_REACTION])
						else
							-- but I can't attack them
							r, g, b = unpack(PitBull4.ReactionColors.civilian)
						end
					elseif UnitCanAttack("player", unit) then
						-- they can't attack me, but I can attack them
						r, g, b = unpack(PitBull4.ReactionColors[NEUTRAL_REACTION])
					elseif UnitIsFriend("player", unit) then
						-- on my team
						r, g, b = unpack(PitBull4.ReactionColors[FRIENDLY_REACTION])
					else
						-- either enemy or friend, no violence
						r, g, b = unpack(PitBull4.ReactionColors.civilian)
					end
				end
			elseif happiness then
				-- Since we have a pet happiness we must be configured to color by that
				r, g, b = unpack(PitBull4.HappinessColors[happiness_map[happiness]])
			elseif bar_db.hostility_color_npcs then
				local reaction = UnitReaction(unit, "player")
				if reaction then
					if reaction >= 5 then
						r, g, b = unpack(PitBull4.ReactionColors[FRIENDLY_REACTION])
					elseif reaction == 4 then
						r, g, b = unpack(PitBull4.ReactionColors[NEUTRAL_REACTION])
					else
						r, g, b = unpack(PitBull4.ReactionColors[HOSTILE_REACTION])
					end
				else
					if UnitIsFriend("player", unit) then
						r, g, b = unpack(PitBull4.ReactionColors[FRIENDLY_REACTION])
					elseif UnitIsEnemy("player", unit) then
						r, g, b = unpack(PitBull4.ReactionColors[HOSTILE_REACTION])
					end
				end
			end
		end
	end
	if (not r or not g or not b) and frame.force_show and self.GetExampleColor then
		if bar_provider then
			r, g, b, a = self:GetExampleColor(frame, bar_db, value, extra, icon)
		else
			r, g, b, a = self:GetExampleColor(frame, value, extra, icon)
		end
	end
	if a then
		a = a * bar_db.alpha
	else
		a = bar_db.alpha
	end
	if a and a < 0 then
		a = 0
	elseif a and a > 1 then
		a = 1
	end
	if not r or not g or not b then
		return 0.7, 0.7, 0.7, a
	end
	return r, g, b, a
end

--- Call the :GetBackgroundColor function on the status bar module regarding the given frame.
--- Call the color function which the current status bar module has registered regarding the given frame.
-- @param self the module
-- @param frame the frame to get the background color of
-- @param bar_db the layout db for the specific bar (only passed for bar_provider modules)
-- @param value the value as returned by call_value_function
-- @param extra the extra value as returned by call_value_function
-- @param icon the icon path as returned by call_value_function
-- @usage local r, g, b, a = call_background_color_function(MyModule, someFrame)
-- @return red value within [0, 1]
-- @return green value within [0, 1]
-- @return blue value within [0, 1]
-- @return alpha value within [0, 1] or nil
local function call_background_color_function(self, frame, bar_db, value, extra, icon)
	local bar_provider = true
	if not bar_db then
		bar_provider = false
		bar_db = self:GetLayoutDB(frame)
	end
	local custom_background = bar_db.custom_background
	
	if not self.GetBackgroundColor then
		if custom_background then
			return custom_background[1], custom_background[2], custom_background[3], bar_db.background_alpha
		else
			return nil, nil, nil, bar_db.background_alpha 
		end
	end
	local r, g, b, a, override
	if frame.guid then
		if bar_provider then
			r, g, b, a, override = self:GetBackgroundColor(frame, value, extra, icon)
		else
			r, g, b, a, override = self:GetBackgroundColor(frame, bar_db, value, extra, icon)
		end
	end
	if not override and custom_background then
		if a then
			a = a * bar_db.background_alpha
		else
			a = bar_db.background_alpha
		end
		if a and a < 0 then
			a = 0
		elseif a and a > 1 then
			a = 1
		end
		return custom_background[1], custom_background[2], custom_background[3], a
	end
	if (not r or not g or not b) and frame.force_show and self.GetExampleBackgroundColor then
		if bar_provider then
			r, g, b, a = self:GetExampleBackgroundColor(frame, bar_db, value, extra, icon)
		else
			r, g, b, a = self:GetExampleBackgroundColor(frame, value, extra, icon)
		end
	end
	if a then
		a = a * bar_db.background_alpha
	else
		a = bar_db.background_alpha
	end
	if a and a < 0 then
		a = 0
	elseif a and a > 1 then
		a = 1
	end
	if not r or not g or not b then
		return nil, nil, nil, a 
	end
	return r, g, b, a
end


--- Call the :GetExtraColor function on the status bar module regarding the given frame.
--- Call the color function which the current status bar module has registered regarding the given frame.
-- @param self the module
-- @param frame the frame to get the color of
-- @param bar_db the layout db for the specific bar (only passed for bar_provider modules)
-- @param value the value as returned by call_value_function
-- @param extra the extra value as returned by call_value_function
-- @param icon the icon path as returned by call_value_function
-- @usage local r, g, b, a = call_extra_color_function(MyModule, someFrame)
-- @return red value within [0, 1]
-- @return green value within [0, 1]
-- @return blue value within [0, 1]
-- @return alpha value within [0, 1] or nil
local function call_extra_color_function(self, frame, bar_db, value, extra, icon)
	local bar_provider = true
	if not bar_db then
		bar_provider = false
		bar_db = self:GetLayoutDB(frame)
	end
	local custom_color = bar_db.custom_color
	local custom_extra = bar_db.custom_extra
	
	if not self.GetExtraColor then
		if custom_extra then
			return custom_extra[1], custom_extra[2], custom_extra[3], nil 
		elseif custom_color then
			local r, g, b = custom_color[1], custom_color[2], custom_color[3] 
			return (1 + 2*r) / 3, (1 + 2*g) / 3, (1 + 2*b) / 3, nil 
		else
			return 0.5, 0.5, 0.5, nil
		end
	end

	local r, g, b, a, override
	if frame.guid then
		if bar_provider then
			r, g, b, a, override = self:GetExtraColor(frame, value, extra)
		else
			r, g, b, a, override = self:GetExtraColor(frame, bar_db, value, extra)
		end
	end
	if not override then
		if a then
			a = a * bar_db.alpha
			if a < 0 then
				a = 0
			elseif a > 1 then
				a = 1
			end
		end
		if custom_extra then
			return custom_extra[1], custom_extra[2], custom_extra[3], a
		elseif custom_color then
			local r, g, b = custom_color[1], custom_color[2], custom_color[3] 
			return (1 + 2*r) / 3, (1 + 2*g) / 3, (1 + 2*b) / 3, a
		end
	end
	if (not r or not g or not b) and frame.force_show and self.GetExampleExtraColor then
		r, g, b, a = self:GetExampleExtraColor(frame, value, extra)
	end
	if a then
		a = a * bar_db.alpha
		if a < 0 then
			a = 0
		elseif a > 1 then
			a = 1
		end
	end
	if not r or not g or not b then
		return 0.5, 0.5, 0.5, a
	end
	return r, g, b, a
end

--
-- bar module implementation
--

local BarModule = PitBull4:NewModuleType("bar", {
	size = 2,
	reverse = false,
	deficit = false,
	alpha = 1,
	background_alpha = 1,
	position = 1,
	side = 'center',
	enabled = true,
	custom_color = nil,
	custom_background = nil,
	custom_extra = nil,
	icon_on_left = true,
	color_by_class = false,
	color_pvp_by_class = false,
	hostility_color = false,
	hostility_color_npcs = false,
	color_by_happiness = false,
}, true)

--- Handle the frame being hidden
-- @param frame the Unit Frame hidden.
-- @usage MyModule:OnHide(frame)
function BarModule:OnHide(frame)
	if DEBUG then
		expect(frame, 'typeof', 'frame')
	end

	local id = self.id
	local control = frame[id]
	if control then
		control:Hide()
	end
end

--- Clear the status bar for the current module if it exists.
-- @param frame the Unit Frame to clear
-- @usage local update_layout = MyModule:ClearFrame(frame)
-- @return whether the update requires :UpdateLayout to be called
function BarModule:ClearFrame(frame)
	if DEBUG then
		expect(frame, 'typeof', 'frame')
	end
	
	local id = self.id
	local control = frame[id]
	if not control then
		return false
	end
	
	frame[id] = control:Delete()
	return true
end

--- Update the status bar for the current module
-- @param frame the Unit Frame to update
-- @usage local update_layout = MyModule:UpdateStatusBar(frame)
-- @return whether the update requires :UpdateLayout to be called
function BarModule:UpdateFrame(frame)
	if DEBUG then
		expect(frame, 'typeof', 'frame')
	end
	
	local value, extra, icon = call_value_function(self, frame)
	if not value then
		return self:ClearFrame(frame)
	end
	
	local id = self.id
	local control = frame[id]
	local made_control = not control
	if made_control then
		control = PitBull4.Controls.MakeBetterStatusBar(frame)
		frame[id] = control
	end
	
	control:SetTexture(self:GetTexture(frame))
	
	control:SetValue(value)
	local r, g, b, a = call_color_function(self, frame, nil, value, extra or 0, icon)
	control:SetColor(r, g, b)
	control:SetNormalAlpha(a)

	r, g, b, a = call_background_color_function(self, frame, nil, value, extra or 0, icon)
	control:SetBackgroundColor(r, g, b)
	control:SetBackgroundAlpha(a)

	if extra then
		control:SetExtraValue(extra)
		
		local r, g, b, a = call_extra_color_function(self, frame, nil, value, extra, icon)
		control:SetExtraColor(r, g, b)
		control:SetExtraAlpha(a)
	else
		control:SetExtraValue(0)
	end
	
	control:SetIcon(icon)
	control:SetIconPosition(self:GetLayoutDB(frame).icon_on_left)
	control:Show()
	
	return made_control
end

--- Return the texture path to use for the given frame.
-- @param frame the unit frame
-- @return the texture path
-- @usage local texture = MyModule:GetTexture(some_frame)
-- some_frame.MyModule:SetTexture(texture)
function BarModule:GetTexture(frame)
	local layout_db = self:GetLayoutDB(frame)
	local texture
	if LibSharedMedia then
		texture = LibSharedMedia:Fetch("statusbar", layout_db.texture or frame.layout_db.bar_texture or "Blizzard")
	end
	return texture or [[Interface\TargetingFrame\UI-StatusBar]]
end

--- Handle a new media key being added to SharedMedia
-- @param event the event from LibSharedMedia
-- @param mediatype the type of the media being added (e.g. "font", "statusbar")
-- @param key the name of the new media
function BarModule:LibSharedMedia_Registered(event, mediatype, key)
	if mediatype == "statusbar" then
		self:UpdateAll()
	end
end

--
-- bar_provider module implementation
--

local BarProviderModule = PitBull4:NewModuleType("bar_provider", {
	enabled = true,
	elements = {
		['**'] = {
			size = 2,
			reverse = false,
			deficit = false,
			alpha = 1,
			background_alpha = 1,
			position = 10,
			side = 'center',
			custom_color = nil,
			custom_background = nil,
			custom_extra = nil,
			icon_on_left = true,
			color_by_class = false,
			color_pvp_by_class = false,
			hostility_color = false,
			hostility_color_npcs = false,
			color_by_happiness = false,
			exists = false,
		}
	}
}, true)

--- Handle the frame being hidden
-- @param frame the Unit Frame hidden.
-- @usage MyModule:OnHide(frame)
function BarProviderModule:OnHide(frame)
	if DEBUG then
		expect(frame, 'typeof', 'frame')
	end

	local id = self.id
	local bars = frame[id]
	if not bars then
		return
	end

	for name, bar in pairs(bars) do
		bar:Hide()
	end
end

--- Clear the status bar for the current module if it exists.
-- @param frame the Unit Frame to clear
-- @usage local update_layout = MyModule:ClearFrame(frame)
-- @return whether the update requires :UpdateLayout to be called
function BarProviderModule:ClearFrame(frame)
	if DEBUG then
		expect(frame, 'typeof', 'frame')
	end
	
	local id = self.id
	local bars = frame[id]
	if not bars then
		return false
	end
	
	for name, bar in pairs(bars) do
		bar.db = nil
		bar:Delete()
		frame[id .. ";" .. name] = nil
	end
	frame[id] = del(bars)
	
	return true
end

--- Update the status bar for the current module
-- @param frame the Unit Frame to update
-- @usage local update_layout = MyModule:UpdateStatusBar(frame)
-- @return whether the update requires :UpdateLayout to be called
function BarProviderModule:UpdateFrame(frame)
	if DEBUG then
		expect(frame, 'typeof', 'frame')
	end
	
	local layout_db = self:GetLayoutDB(frame)
	if not next(layout_db.elements) then
		return self:ClearFrame(frame)
	end
	
	local bars = frame[self.id]
	if not bars then
		bars = new()
		frame[self.id] = bars
	end
	
	local changed = false
	
	-- get rid of any bars not in the db
	for name, bar in pairs(bars) do
		if not rawget(layout_db.elements, name) then
			bar.db = nil
			bars[name] = bar:Delete()
			frame[self.id .. ";" .. name] = nil
			changed = true
		end
	end
	
	-- create or update bars
	for name, bar_db in pairs(layout_db.elements) do
		local bar = bars[name]
		
		local value, extra, icon = call_value_function(self, frame, bar_db)
		if not value then
			if bar then
				bar.db = nil
				bars[name] = bar:Delete()
				frame[self.id .. ";" .. name] = nil
				changed = true
			end
		else
			if not bar then
				bar = PitBull4.Controls.MakeBetterStatusBar(frame)
				bars[name] = bar
				frame[self.id .. ";" .. name] = bar
				bar.db = bar_db
				changed = true
			end
			
			local texture
			if LibSharedMedia then
				texture = LibSharedMedia:Fetch("statusbar", bar_db.texture or frame.layout_db.bar_texture or "Blizzard")
			end
			bar:SetTexture(texture or [[Interface\TargetingFrame\UI-StatusBar]])
			bar:SetValue(value)
			
			local r, g, b, a = call_color_function(self, frame, bar_db, value, extra or 0, icon)
			bar:SetColor(r, g, b)
			bar:SetAlpha(a)
	
			r, g, b, a = call_background_color_function(self, frame, bar_db, value, extra or 0, icon)
			bar:SetBackgroundColor(r, g, b)
			bar:SetBackgroundAlpha(a)
			
			if extra then
				bar:SetExtraValue(extra)

				local r, g, b, a = call_extra_color_function(self, frame, bar_db, value, extra, icon)
				bar:SetExtraColor(r, g, b)
				bar:SetExtraAlpha(a)
			else
				bar:SetExtraValue(0)
			end

			bar:SetIcon(icon)
			bar:SetIconPosition(bar_db.icon_on_left)

			bar:Show()
		end
	end
	
	if next(bars) == nil then
		frame[self.id] = del(bars)
		bars = nil
	end
	
	return changed
end

-- Same code as BarModule
BarProviderModule.LibSharedMedia_Registered = BarModule.LibSharedMedia_Registered
