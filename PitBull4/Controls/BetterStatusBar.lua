local DEBUG = PitBull4.DEBUG
local expect = PitBull4.expect

-- everything in here will be added to the controls verbatim
local BetterStatusBar = {
	value = 1,
	extraValue = 0,
	orientation = "HORIZONTAL",
	reverse = false,
	deficit = false,
	bgR = false,
	bgG = false,
	bgB = false,
	bgA = false,
	extraR = false,
	extraG = false,
	extraB = false,
	extraA = false,
	icon_path = nil,
	icon_position = true,
}
-- every script in here will be added to the control through :SetScript
local BetterStatusBar_scripts = {}

local EPSILON = 1e-5 -- small positive number close to 0.

local function fix_icon_size(self)
	local icon = self.icon
	if not icon then
		return
	end
	
	local size = self.orientation == "VERTICAL" and self:GetWidth() or self:GetHeight()
	icon:SetWidth(size)
	icon:SetHeight(size)
end

local function OnUpdate(self)
	self:SetScript("OnUpdate", nil)
	self:SetValue(self.value)
	fix_icon_size(self)
end

-- clamp value between [min, max]
local function clamp(value, min, max)
	if value < min then
		return min
	end
	if value > max then
		return max
	end
	return value
end

local SetValue_orientation = {}
-- helper function for setting texcoords on the vertical orientation
local function set_vertical_coord(bar, reverse, alpha, bravo)
	if reverse then
		alpha, bravo = bravo, alpha
	end
	
	bar:SetTexCoord(bravo, 0, alpha, 0, bravo, 1, alpha, 1)
end
-- set the proper heights for the vertical orientation based on the values provided
function SetValue_orientation:VERTICAL(value, extraValue)
	local height = self:GetHeight()
	if height == 0 then
		self:SetScript("OnUpdate", OnUpdate)
		return
	end
	if self.icon then
		height = height - self:GetWidth()
	end
	self.fg:SetHeight(height * value)
	self.extra:SetHeight(height * extraValue)
	
	set_vertical_coord(self.fg, self.reverse, 0, value)
	set_vertical_coord(self.extra, self.reverse, value, value+extraValue)
	set_vertical_coord(self.bg, self.reverse, value+extraValue, 1)
end
-- helper function for setting texcoords on the horizontal orientation
local function set_horizontal_coord(bar, reverse, alpha, bravo)
	if reverse then
		alpha, bravo = bravo, alpha
	end
	
	bar:SetTexCoord(alpha, 0, alpha, 1, bravo, 0, bravo, 1)
end
-- set the proper heights for the horizontal orientation based on the values provided
function SetValue_orientation:HORIZONTAL(value, extraValue)
	local width = self:GetWidth()
	if width == 0 then
		self:SetScript("OnUpdate", OnUpdate)
		return
	end
	if self.icon then
		width = width - self:GetHeight()
	end
	self.fg:SetWidth(width * value)
	self.extra:SetWidth(width * extraValue)
	
	set_horizontal_coord(self.fg, self.reverse, 0, value)
	set_horizontal_coord(self.extra, self.reverse, value, value+extraValue)
	set_horizontal_coord(self.bg, self.reverse, value+extraValue, 1)
end

--- Set the current value
-- @param value value between [0, 1]
-- @usage bar:SetValue(0.5)
function BetterStatusBar:SetValue(value)
	if DEBUG then
		expect(value, 'typeof', 'number')
	end
	
	if value < 0 then
		value = 0
	elseif value > 1 then
		value = 1
	end
	
	self.value = value
	if self.deficit then
		value = 1 - value
	end
	value = clamp(value, EPSILON, 1)
	local extraValue = clamp(self.extraValue, EPSILON, 1 - value)
	SetValue_orientation[self.orientation](self, value, extraValue)
end
--- Return the current value
-- @return the value between [0, 1]
-- @usage assert(bar:GetValue() == 0.5)
function BetterStatusBar:GetValue()
	return self.value
end

--- Set the extra value of a status bar
-- This is useful if you have a base value and an auxillary value,
-- such as experience and rested experience.
-- @param extraValue
-- @usage bar:SetExtraValue(0.25)
function BetterStatusBar:SetExtraValue(extraValue)
	if DEBUG then
		expect(extraValue, 'typeof', 'number')
	end
	
	if extraValue < 0 then
		extraValue = 0
	end
	
	self.extraValue = extraValue
	self:SetValue(self.value)
end
--- Return the extra value
-- @return the extra value
-- @usage assert(bar:GetExtraValue() == 0.25)
function BetterStatusBar:GetExtraValue()
	return self.extraValue
end

-- set the position of the bar
-- all the sides are fixed, e.g. vertical bar has its left and right sides unmoving.
-- the moving points are the ones pointing along the path of motion, e.g. vertical is top and bottom
local function set_bar_points(self, side_point_a, side_point_b, moving_point_a, moving_point_b)
	if self.reverse then
		moving_point_a, moving_point_b = moving_point_b, moving_point_a
	end
	
	if self.icon and self.icon_position then
		-- icon is fixed to the edge
		self.icon:SetPoint(side_point_a)
		self.icon:SetPoint(side_point_b)
		self.icon:SetPoint(moving_point_a)
		
		-- fg attaches to the icon
		self.fg:SetPoint(moving_point_a, self.icon, moving_point_b)
	else
		-- fg is fixed to the edge
		self.fg:SetPoint(moving_point_a)
	end
	self.fg:SetPoint(side_point_a)
	self.fg:SetPoint(side_point_b)
	
	-- extra moves with and is attached to the fg.
	self.extra:SetPoint(side_point_a)
	self.extra:SetPoint(side_point_b)
	self.extra:SetPoint(moving_point_a, self.fg, moving_point_b)
	
	if self.icon and not self.icon_position then
		-- bg attaches to the icon
		self.bg:SetPoint(moving_point_b, self.icon, moving_point_a)
		
		-- icon then fills up the rest of the space
		self.icon:SetPoint(side_point_a)
		self.icon:SetPoint(side_point_b)
		self.icon:SetPoint(moving_point_b)
	else
		-- bg merely fills up the rest of the space
		self.bg:SetPoint(moving_point_b)
	end	
	self.bg:SetPoint(moving_point_a, self.extra, moving_point_b)
	self.bg:SetPoint(side_point_a)
	self.bg:SetPoint(side_point_b)
end

local fix_orientation_helper = {}
-- reset the points of the bar to their original state for vertical orientation
function fix_orientation_helper:VERTICAL()
	self.fg:SetHeight(EPSILON)
	self.extra:SetHeight(EPSILON)
	
	set_bar_points(self, "LEFT", "RIGHT", "BOTTOM", "TOP")
end
-- reset the points of the bar to their original state for horizontal orientation
function fix_orientation_helper:HORIZONTAL()
	self.fg:SetWidth(EPSILON)
	self.extra:SetWidth(EPSILON)
	
	set_bar_points(self, "BOTTOM", "TOP", "LEFT", "RIGHT")
end

-- readjust where all the texture are positioned, in case any settings have changed
local function fix_orientation(self)
	self.fg:ClearAllPoints()
	self.extra:ClearAllPoints()
	self.bg:ClearAllPoints()
	self.fg:SetWidth(0)
	self.fg:SetHeight(0)
	self.extra:SetWidth(0)
	self.extra:SetHeight(0)
	if self.icon then
		self.icon:ClearAllPoints()
		fix_icon_size(self)
	end
	fix_orientation_helper[self.orientation](self)
	self:SetValue(self.value)
end

--- Set the orientation of the bar
-- @param orientation "HORIZONTAL" or "VERTICAL"
-- @usage bar:SetOrientation("VERTICAL")
function BetterStatusBar:SetOrientation(orientation)
	if DEBUG then
		expect(orientation, 'inset', 'HORIZONTAL;VERTICAL')
	end
	
	if self.orientation == orientation then
		return
	end
	self.orientation = orientation
	
	fix_orientation(self)
end
--- Get the current orientation of the bar
-- @usage assert(bar:GetOrientation() == "VERTICAL")
-- @return "HORIZONTAL" or "VERTICAL"
function BetterStatusBar:GetOrientation()
	return self.orientation
end

--- Set whether the bar is reversed
-- Reversal means the bar goes right-to-left instead of left-to-right
-- @param reverse whether the bar is reversed
-- @usage bar:SetReverse(true)
function BetterStatusBar:SetReverse(reverse)
	if DEBUG then
		expect(reverse, 'typeof', 'boolean')
	end
	
	reverse = not not reverse
	if self.reverse == reverse then
		return
	end
	self.reverse = reverse
	
	fix_orientation(self)
end
--- Get whether the bar is currently reversed
-- @usage assert(bar:GetReverse() == true)
-- @return whether the bar is reversed
function BetterStatusBar:GetReverse()
	return self.reverse
end

--- Set whether the bar is showing its deficit
-- Showing deficit means that if the value is set to 25%, it'd show 75%
-- @param deficit whether the bar shows its deficit
-- @usage bar:SetDeficit(true)
function BetterStatusBar:SetDeficit(deficit)
	if DEBUG then
		expect(deficit, 'typeof', 'boolean')
	end
	
	deficit = not not deficit
	if self.deficit == deficit then
		return
	end
	self.deficit = deficit
	
	self:SetValue(self.value)
end
--- Get whether the bar is showing its deficit
-- @usage assert(bar:GetDeficit() == true)
-- @return whether the bar is showing its deficit
function BetterStatusBar:GetDeficit()
	return self.deficit
end

--- Set the texture that the bar is currently using
-- @param texture the path to the texture
-- @usage bar:SetTexture([[Interface\TargetingFrame\UI-StatusBar]])
function BetterStatusBar:SetTexture(texture)
	if DEBUG then
		expect(texture, 'typeof', 'string')
	end
	
	self.fg:SetTexture(texture)
	self.extra:SetTexture(texture)
	self.bg:SetTexture(texture)
end
--- Get the texture that the bar is using
-- @usage assert(bar:GetTexture() == [[Interface\TargetingFrame\UI-StatusBar]])
-- @return the path to the texture
function BetterStatusBar:GetTexture()
	return self.fg:GetTexture()
end
BetterStatusBar.GetStatusBarTexture = BetterStatusBar.GetTexture

-- if extra color is not set, it'll take on this variance of the normal color
local function normal_to_extra_color(r, g, b)
	return (r + 0.25)/1.5, (g + 0.25)/1.5, (b + 0.25)/1.5
end

-- if bg color is not set, it'll take on this variance of the normal color
local function normal_to_bg_color(r, g, b)
	return (r + 0.2)/3, (g + 0.2)/3, (b + 0.2)/3
end

-- get what the extra color should be
local function get_extra_color(self)
	if self.extraR then
		return self.extraR, self.extraG, self.extraB
	end
	
	local r, g, b = self.fg:GetVertexColor()
	return normal_to_extra_color(r, g, b)
end

-- get what the bg color should be
local function get_bg_color(self)
	if self.bgR then
		return self.bgR, self.bgG, self.bgB
	end
	
	local r, g, b = self.fg:GetVertexColor()
	return normal_to_bg_color(r, g, b)
end

--- Set the color of the bar
-- If the background color or the extra color is not set,
-- they will take on a similar color to what is specified here
-- @param r the red value [0, 1]
-- @param g the green value [0, 1]
-- @param b the blue value [0, 1]
-- @usage bar:SetColor(1, 0.82, 0)
function BetterStatusBar:SetColor(r, g, b)
	if DEBUG then
		expect(r, 'typeof', 'number')
		expect(r, '>=', 0)
		expect(r, '<=', 1)
		expect(g, 'typeof', 'number')
		expect(g, '>=', 0)
		expect(g, '<=', 1)
		expect(b, 'typeof', 'number')
		expect(b, '>=', 0)
		expect(b, '<=', 1)
	end
	
	self.fg:SetVertexColor(r, g, b)
	self.extra:SetVertexColor(get_extra_color(self))
	self.bg:SetVertexColor(get_bg_color(self))
end

--- Get the color of the bar
-- @usage local r, g, b = bar:GetColor()
-- @return the red value [0, 1]
-- @return the green value [0, 1]
-- @return the blue value [0, 1]
function BetterStatusBar:GetColor()
	local r, g, b = self.fg:GetVertexColor()
	return r, g, b
end
BetterStatusBar.GetStatusBarColor = BetterStatusBar.GetColor

--- Set the alpha value of the bar
-- If the background or extra alpha is not set,
-- they will be the same as the alpha specified here
-- @param a the alpha value [0, 1]
-- @usage bar:SetNormalAlpha(0.7)
function BetterStatusBar:SetNormalAlpha(a)
	if DEBUG then
		expect(a, 'typeof', 'number')
		expect(a, '>=', 0)
		expect(a, '<=', 1)
	end
	
	self.fg:SetAlpha(a)
	if not self.extraA then
		self.extra:SetAlpha(a)
	end
	if not self.bgA then
		self.bg:SetAlpha(a)
	end
end
--- Get the alpha value of the bar
-- @usage local alpha = bar:GetNormalAlpha()
-- @return the alpha value [0, 1]
function BetterStatusBar:GetNormalAlpha()
	return self.fg:GetAlpha()
end

--- Set the background color of the bar
-- If you don't specify the colors, then it will come up with a good color
-- based on the normal color
-- @param br the red value [0, 1] or nil
-- @param bg the green value [0, 1] or nil
-- @param bb the blue value [0, 1] or nil
-- @usage bar:SetBackgroundColor(0.5, 0.41, 0)
-- @usage bar:SetBackgroundColor()
function BetterStatusBar:SetBackgroundColor(br, bg, bb)
	if DEBUG then
		expect(br, 'typeof', 'number;nil')
		if type(br) == "number" then
			expect(br, '>=', 0)
			expect(br, '<=', 1)
			expect(bg, 'typeof', 'number')
			expect(bg, '>=', 0)
			expect(bg, '<=', 1)
			expect(bb, 'typeof', 'number')
			expect(bb, '>=', 0)
			expect(bb, '<=', 1)
		else
			expect(bg, 'typeof', 'nil')
			expect(bb, 'typeof', 'nil')
		end
	end
	
	self.bgR, self.bgG, self.bgB = br or false, bg or false, bb or false
	self.bg:SetVertexColor(get_bg_color(self))
end

--- Get the background color of the bar
-- @usage local r, g, b = bar:GetBackgroundColor()
-- @return the red value [0, 1]
-- @return the green value [0, 1]
-- @return the blue value [0, 1]
function BetterStatusBar:GetBackgroundColor()
	local r, g, b = self.bg:GetVertexColor()
	return r, g, b
end

--- Set the alpha value of the bar's background
-- If you do not specify the alpha, it will be the same as the bar's normal
-- alpha
-- @param a the alpha value [0, 1] or nil
-- @usage bar:SetBackgroundAlpha(0.7)
-- @usage bar:SetBackgroundAlpha()
function BetterStatusBar:SetBackgroundAlpha(a)
	if DEBUG then
		expect(a, 'typeof', 'number;nil')
		if a then
			expect(a, '>=', 0)
			expect(a, '<=', 1)
		end
	end
	
	self.bgA = a or false
	if not a then
		a = self.fg:GetAlpha()
	end
	self.bg:SetAlpha(a)
end

--- Get the alpha value of the bar's background
-- @usage local alpha = bar:GetBackgroundAlpha()
-- @return the alpha value [0, 1]
function BetterStatusBar:GetBackgroundAlpha()
	return self.bgA or self.fg:GetAlpha()
end

--- Set the extra color of the bar
-- If you don't specify the colors, then it will come up with a good color
-- based on the normal color
-- @param er the red value [0, 1] or nil
-- @param eg the green value [0, 1] or nil
-- @param eb the blue value [0, 1] or nil
-- @usage bar:SetExtraColor(0.8, 0.6, 0)
-- @usage bar:SetExtraColor()
function BetterStatusBar:SetExtraColor(er, eg, eb)
	if DEBUG then
		expect(er, 'typeof', 'number;nil')
		if type(er) == "number" then
			expect(er, '>=', 0)
			expect(er, '<=', 1)
			expect(eg, 'typeof', 'number')
			expect(eg, '>=', 0)
			expect(eg, '<=', 1)
			expect(eb, 'typeof', 'number')
			expect(eb, '>=', 0)
			expect(eb, '<=', 1)
		else
			expect(eg, 'typeof', 'nil')
			expect(eb, 'typeof', 'nil')
		end
	end

	self.extraR, self.extraG, self.extraB = er or false, eg or false, eb or false
	self.extra:SetVertexColor(get_extra_color(self))
end

--- Get the extra color of the bar
-- @usage local r, g, b = bar:GetExtraColor()
-- @return the red value [0, 1]
-- @return the green value [0, 1]
-- @return the blue value [0, 1]
function BetterStatusBar:GetExtraColor()
	local r, g, b = self.extra:GetVertexColor()
	return r, g, b
end

--- Set the alpha value of the bar's extra portion
-- If you do not specify the alpha, it will be the same as the bar's normal
-- alpha
-- @param a the alpha value [0, 1] or nil
-- @usage bar:SetExtraAlpha(0.7)
-- @usage bar:SetExtraAlpha()
function BetterStatusBar:SetExtraAlpha(a)
	if DEBUG then
		expect(a, 'typeof', 'number;nil')
		if a then
			expect(a, '>=', 0)
			expect(a, '<=', 1)
		end
	end
	
	self.extraA = a or false
	if not a then
		a = self.fg:GetAlpha()
	end
	self.extra:SetAlpha(a)
end

--- Get the alpha value of the bar's extra portion
-- @usage local alpha = bar:SetExtraAlpha()
-- @return the alpha value [0, 1]
function BetterStatusBar:GetExtraAlpha()
	return self.extraA or self.fg:GetAlpha()
end

--- Return the minimum and maximum values of the bar
-- Since this can't be changed, it will always return 0, 1
-- @usage local min, max = bar:GetMinMaxValues()
-- @return the minimum value: 0
-- @return the maximum value: 1
function BetterStatusBar:GetMinMaxValues()
	return 0, 1
end

-- when the size changes, make sure to readjust the sizes of the inner textures
function BetterStatusBar_scripts:OnSizeChanged()
	self:SetValue(self.value)
	fix_icon_size(self)
end

--- Return the icon's texture path of the bar
-- @usage local icon = bar:GetIcon()
-- @return the texture path or nil
function BetterStatusBar:GetIcon()
	return self.icon_path
end

--- Set the icon's texture path of the bar, or remove it.
-- @param path the texture path or nil
-- @usage bar:SetIcon([[Interface\Icons\Ability_Parry]])
-- @usage bar:SetIcon(nil)
function BetterStatusBar:SetIcon(path)
	if DEBUG then
		expect(path, 'typeof', 'string;nil')
	end
	
	local old_icon_path = self.icon_path
	if old_icon_path == path then
		return
	end
	
	self.icon_path = path
	if path then
		if not self.icon then
			self.icon = PitBull4.Controls.MakeTexture(self, "ARTWORK")
			self.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
			fix_orientation(self)
		end
		self.icon:SetTexture(path)
	else
		if self.icon then
			self.icon = self.icon:Delete()
			fix_orientation(self)
		end
	end
end

--- Return whether the icon is on the left or bottom.
-- If the bar is reversed, then the icon will be on the right or top instead.
-- @usage local left = bar:GetIconPosition()
-- @return true if the icon is on left or top, otherwise, false.
function BetterStatusBar:GetIconPosition()
	return self.icon_position
end

--- Set whether the icon is on the left or bottom.
-- If the bar is reversed, then the icon will be on the right or top instead.
-- @param value a boolean
-- @usage bar:SetIconPosition(true)
-- @usage bar:SetIconPosition(false)
function BetterStatusBar:SetIconPosition(value)
	if DEBUG then
		expect(value, 'typeof', 'boolean')
	end
	
	if value == self.icon_position then
		return
	end
	
	self.icon_position = value
	fix_orientation(self)
end

--- Make a better status bar than what Blizzard provides
-- @class function
-- @name PitBull4.Controls.MakeBetterStatusBar
-- @param parent frame the status bar is parented to
-- @usage local bar = PitBull4.Controls.MakeBetterStatusBar(someFrame)
-- @return a BetterStatusBar object
PitBull4.Controls.MakeNewControlType("BetterStatusBar", "Button", function(control)
	-- onCreate
	control:EnableMouse(false)
	
	local control_fg = PitBull4.Controls.MakeTexture(control, "BACKGROUND")
	control.fg = control_fg
	control_fg:SetPoint("LEFT")
	control_fg:SetPoint("TOP")
	control_fg:SetPoint("BOTTOM")
	
	local control_extra = PitBull4.Controls.MakeTexture(control, "BACKGROUND")
	control.extra = control_extra
	control_extra:SetPoint("LEFT", control_fg, "RIGHT")
	control_extra:SetPoint("TOP")
	control_extra:SetPoint("BOTTOM")
	
	local control_bg = PitBull4.Controls.MakeTexture(control, "BACKGROUND")
	control.bg = control_bg
	control_bg:SetPoint("LEFT", control_extra, "RIGHT")
	control_bg:SetPoint("RIGHT")
	control_bg:SetPoint("TOP")
	control_bg:SetPoint("BOTTOM")
	
	for k,v in pairs(BetterStatusBar) do
		control[k] = v
	end
	for k,v in pairs(BetterStatusBar_scripts) do
		control:SetScript(k, v)
	end
end, function(control)
	-- onRetrieve
	fix_orientation(control)
	control:SetColor(1, 1, 1)
	control:SetNormalAlpha(1)
	control:SetIcon(nil)
	control:SetIconPosition(true)
end, function(control)
	-- onDelete
	control:SetScript("OnUpdate", nil)
end)
