
-- CONSTANTS ----------------------------------------------------------------

-- how many width points the center bars take up if at least one exists
local CENTER_WIDTH_POINTS = 10

-- how many pixels wide to assume a text is
local ASSUMED_TEXT_WIDTH = 40

local BAR_MODULE_TYPES = {
	bar = true,
	bar_provider = true,
}

local INDICATOR_MODULE_TYPES = {
	indicator = true,
}

local TEXT_MODULE_TYPES = {
	text_provider = true,
	custom_text = true,
}

local DEFAULT_FONT_SIZE = select(2, ChatFontNormal:GetFont())

-----------------------------------------------------------------------------

-- a cache of element-to-scale
local scale_cache = {}

local _G = _G
local PitBull4 = _G.PitBull4

local DEBUG = PitBull4.DEBUG
local expect = PitBull4.expect

local UnitFrame = PitBull4.UnitFrame

local new, del = PitBull4.new, PitBull4.del

local ipairs_with_del
do
	local function ipairs_with_del__iter(list, current)
		current = current + 1
		
		local value = list[current]
		if value == nil then
			del(list)
			return nil
		end
		
		return current, value
	end
	
	--- Iterate over a list until nil is hit.
	-- @param list a list
	-- @return an iterator which returns index, value
	-- @usage for i, v in ipairs_with_del({"a", "b", "c"}) do
	--     print(i, v)
	-- end
	-- @usage for i, v in ipairs_with_del({"a", "b", "c", nil, "e"}) do
	--     -- same as above, since it stops at i == 4
	--     print(i, v)
	-- end
	function ipairs_with_del(list)
		if DEBUG then
			expect(list, 'typeof', 'table')
		end
		
		return ipairs_with_del__iter, list, 0
	end
end

local modules = PitBull4.modules
--- Return the element-specific layout db for the given id and layout.
-- @param id either a module id or a module id, semicolon, and element id.
-- @param layout the name of the layout
-- @return the element db or nil
-- @usage db = get_element_db("CombatText", "Normal")
-- @usage db = get_element_db("DogTagTexts;Name", "Normal")
local function get_element_db(id, layout)
	if DEBUG then
		expect(id, 'typeof', 'string')
	end
	
	local module_id, element_id
	if id:match(";") then
		module_id, element_id = (";"):split(id, 2)
	else
		module_id = id
	end
	
	if DEBUG then
		expect(module_id, 'inset', modules)
	end
	
	local module = modules[module_id]
	
	local db = module:GetLayoutDB(layout)
	if element_id then
		db = rawget(db.elements, element_id)
	end
	
	if DEBUG then
		expect(db, 'typeof', 'nil;table')
	end
	return db
end

--- A dictionary of element_id to module_type.
local element_id_to_module_type = setmetatable({}, {
	__index = function(self, id)
		if DEBUG then
			expect(id, 'typeof', 'string')
		end
		
		local module_id = id
		if module_id:match(";") then
			module_id = (";"):split(id, 2)
		end
		
		if DEBUG then
			expect(module_id, 'inset', modules)
		end
		
		local module = modules[module_id]
		local module_type = module.module_type
		
		if DEBUG then
			expect(module_type, 'typeof', 'string')
		end
		
		self[id] = module_type
		return module_type
	end,
})

local sort_elements_by_position
do
	local element_id_to_position = {}
	local function sort_elements_by_position__helper(alpha, bravo)
		return element_id_to_position[alpha] < element_id_to_position[bravo]
	end
	
	--- Sort a list of elements by position for the given layout.
	-- @param element_ids a list of element ids
	-- @param layout name of the layout
	-- @usage element_ids = { "HealthBar", "PowerBar" }
	-- sort_elements_by_position(element_ids)
	function sort_elements_by_position(element_ids, layout)
		if DEBUG then
			expect(element_ids, 'typeof', 'table')
			expect(layout, 'typeof', 'string')
		end
		
		for _, element_id in ipairs(element_ids) do
			local db = get_element_db(element_id, layout)
			element_id_to_position[element_id] = db and db.position or 0
		end
		
		table.sort(element_ids, sort_elements_by_position__helper)
		
		wipe(element_id_to_position)
	end
end

--- Return a list of element ids that are on a given side for a given layout.
-- @param element_ids a list of element ids
-- @param layout name of the layout
-- @param side the side to filter on, one of "left", "center", or "right"
-- @return a list of element ids
-- @usage element_ids = filter_elements_for_side({ "HealthBar", "PowerBar" }, "Normal", "center")
local function filter_elements_for_side(element_ids, layout, side)
	if DEBUG then
		expect(element_ids, 'typeof', 'table')
		expect(layout, 'typeof', 'string')
		expect(side, 'inset', "left;center;right")
	end
	
	local filtered_element_ids = new()
	for _, element_id in ipairs(element_ids) do
		local db = get_element_db(element_id, layout)
		if db and db.side == side then
			filtered_element_ids[#filtered_element_ids+1] = element_id
		end
	end
	return filtered_element_ids
end

--- Return lists of all element ids that represent bar-like objects.
-- The resultant lists will be sorted by position.
-- @param frame a unit frame
-- @return a list of all element ids
-- @return a list of element ids where side = 'center'
-- @return a list of element ids where side = 'left'
-- @return a list of element ids where side = 'right'
-- @usage bars, center_bars, left_bars, right_bars = get_all_bars(frame)
local function get_all_bars(frame)
	if DEBUG then
		expect(frame, 'inset', PitBull4.all_frames)
	end
	
	local bars = new()
	local layout = frame.layout
	
	for id, module in PitBull4:IterateModulesOfType('bar') do
		if frame[id] then
			bars[#bars+1] = id
		end
	end
	
	for id, module in PitBull4:IterateModulesOfType('indicator') do
		if frame[id] and module:GetLayoutDB(layout).side then
			bars[#bars+1] = id
		end
	end
	
	for id, module in PitBull4:IterateModulesOfType('bar_provider') do
		if frame[id] then
			for name in pairs(frame[id]) do
				bars[#bars+1] = id .. ";" .. name
			end
		end
	end
	
	sort_elements_by_position(bars, layout)
	
	return bars,
		filter_elements_for_side(bars, layout, 'center'),
		filter_elements_for_side(bars, layout, 'left'),
		filter_elements_for_side(bars, layout, 'right')
end

--- Calculate the sizing points for the various bars given.
-- @param layout the name of the layout
-- @param center_bars a list of bar-like elements where side = 'center'
-- @param left_bars a list of bar-like elements where side = 'left'
-- @param right_bars a list of bar-like elements where side = 'right'
-- @return the number of total width points make up the layout (except for the square indicators on the sides) with the given bars
-- @return the number of total height points make up the layout with the given bars
-- @return the number of square indicators are on the left side
-- @return the number of square indicators are on the right side
-- @usage bar_width_points, bar_height_points, left_exempt_width, right_exempt_width = calculate_width_height_points("Normal", {"HealthBar", "PowerBar"}, {"Portrait"}, {})
local function calculate_width_height_points(layout, center_bars, left_bars, right_bars)
	if DEBUG then
		expect(layout, 'typeof', 'string')
		expect(center_bars, 'typeof', 'table')
		expect(left_bars, 'typeof', 'table')
		expect(right_bars, 'typeof', 'table')
	end
	
	local bar_height_points = 0
	local bar_width_points = 0
	local left_exempt_width = 0
	local right_exempt_width = 0
	
	for _, id in ipairs(center_bars) do
		if INDICATOR_MODULE_TYPES[element_id_to_module_type[id]] then
			bar_height_points = bar_height_points + get_element_db(id, layout).bar_size
		else
			bar_height_points = bar_height_points + get_element_db(id, layout).size
		end
	end
	
	if #center_bars > 0 then
		-- the center takes up CENTER_WIDTH_POINTS width points if it exists
		bar_width_points = CENTER_WIDTH_POINTS
	end
	
	for _, id in ipairs(left_bars) do
		if INDICATOR_MODULE_TYPES[element_id_to_module_type[id]] then
			left_exempt_width = left_exempt_width + 1
		else
			bar_width_points = bar_width_points + get_element_db(id, layout).size
		end
	end
	
	for _, id in ipairs(right_bars) do
		if INDICATOR_MODULE_TYPES[element_id_to_module_type[id]] then
			right_exempt_width = right_exempt_width + 1
		else
			bar_width_points = bar_width_points + get_element_db(id, layout).size
		end
	end
	
	return bar_width_points, bar_height_points, left_exempt_width, right_exempt_width
end

local reverse_ipairs
do
	local function reverse_ipairs__iter(t, current)
		current = current - 1
		if current == 0 then
			return
		end
		
		return current, t[current]
	end
	
	--- Iterate backwards over a list.
	-- @param list a list
	-- @return an iterator which returns index, value
	-- @usage for i, v in reverse_ipairs({"a", "b", "c"}) do
	--     -- 3, "c" -- 2, "b", -- 1, "a"
	-- end
	function reverse_ipairs(list)
		if DEBUG then
			expect(list, 'typeof', 'table')
		end
		
		return reverse_ipairs__iter, list, #list + 1
	end
end

--- Position all bar-like objects on the given frame.
-- @param frame a unit frame
-- @usage update_bar_layout(frame)
local function update_bar_layout(frame)
	if DEBUG then
		expect(frame, 'inset', PitBull4.all_frames)
	end
	
	local bars, center_bars, left_bars, right_bars = get_all_bars(frame)
	
	local horizontal_mirror = frame.classification_db.horizontal_mirror
	local vertical_mirror = frame.classification_db.vertical_mirror
	
	if horizontal_mirror then
		left_bars, right_bars = right_bars, left_bars
	end
	
	local frame_width, frame_height = frame:GetWidth(), frame:GetHeight()
	
	local layout = frame.layout
	
	local bar_width_points, bar_height_points, left_exempt_width, right_exempt_width = calculate_width_height_points(layout, center_bars, left_bars, right_bars)
	
	local bar_spacing = frame.layout_db.bar_spacing
	local bar_padding = frame.layout_db.bar_padding
	
	local bar_height = frame_height - bar_padding * 2
	
	local total_height_of_bars = frame_height - bar_spacing * (#center_bars - 1) - bar_padding * 2
	
	local num_vertical_bars = #left_bars + #right_bars
	if #center_bars > 0 then
		-- treat the center bars as a single vertical bar
		num_vertical_bars = num_vertical_bars + 1
	end
	
	-- this is the width of the frame without the square indicators.
	local frame_leftover_width = frame_width - (left_exempt_width + right_exempt_width) * (frame_height + bar_spacing)
	
	local total_width_of_bars = frame_leftover_width - bar_spacing * (num_vertical_bars - 1) - bar_padding * 2
	
	local bar_height_per_point = total_height_of_bars / bar_height_points
	local bar_width_per_point = total_width_of_bars / bar_width_points
	
	-- position all bar-like elements on the left
	local last_x = bar_padding
	for _, id in ipairs(left_bars) do
		local bar = frame[id]
		bar:ClearAllPoints()
		
		local bar_width
		if INDICATOR_MODULE_TYPES[element_id_to_module_type[id]] then
			-- this already has a defined height and width, so we just want to scale it into the right size and position its center
			local bar_scale = bar_height / math.max(bar:GetHeight(), bar:GetWidth())
			bar:SetScale(bar_scale)
			bar_width = bar_height
			bar:SetPoint("CENTER", frame, "LEFT", (last_x + bar_width/2) / bar_scale, 0)
		else
			bar_width = get_element_db(id, layout).size * bar_width_per_point
			bar:SetOrientation("VERTICAL")
			bar:SetPoint("TOPLEFT", frame, "TOPLEFT", last_x, -bar_padding)
			bar:SetPoint("BOTTOMRIGHT", frame, "BOTTOMLEFT", last_x + bar_width, bar_padding)
		end	
		last_x = last_x + bar_width + bar_spacing
	end
	local left = last_x
	
	-- position all bar-like elements on the right
	last_x = -bar_padding
	for _, id in ipairs(right_bars) do
		local bar = frame[id]
		bar:ClearAllPoints()
		
		local bar_width
		if INDICATOR_MODULE_TYPES[element_id_to_module_type[id]] then
			-- this already has a defined height and width, so we just want to scale it into the right size and position its center
			local bar_scale = bar_height / math.max(bar:GetHeight(), bar:GetWidth())
			bar:SetScale(bar_scale)
			bar_width = bar_height
			bar:SetPoint("CENTER", frame, "RIGHT", (last_x - bar_width/2) / bar_scale, 0)
		else
			bar_width = get_element_db(id, layout).size * bar_width_per_point
			bar:SetOrientation("VERTICAL")
			bar:SetPoint("TOPRIGHT", frame, "TOPRIGHT", last_x, -bar_padding)
			bar:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", last_x - bar_width, bar_padding)
		end	
		last_x = last_x - bar_width - bar_spacing
	end
	local right = last_x
	
	-- now position all the center bars between the left and right bars
	local last_y = -bar_padding
	for i, id in (not vertical_mirror and ipairs or reverse_ipairs)(center_bars) do
		local bar = frame[id]
		bar:ClearAllPoints()
		
		local bar_size
		if INDICATOR_MODULE_TYPES[element_id_to_module_type[id]] then
			bar:SetScale(1)
			bar_size = get_element_db(id, layout).bar_size
		else
			bar:SetOrientation("HORIZONTAL")
			bar_size = get_element_db(id, layout).size
		end
		
		bar:SetPoint("TOPLEFT", frame, "TOPLEFT", left, last_y)
		local bar_height = bar_size * bar_height_per_point
		last_y = last_y - bar_height
		bar:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", right, last_y)
		last_y = last_y - bar_spacing
	end
	
	-- set various information on the bars
	for _, id in ipairs(bars) do
		if not INDICATOR_MODULE_TYPES[element_id_to_module_type[id]] then
			local bar = frame[id]
			local bar_layout_db = get_element_db(id, layout)
			local reverse = bar_layout_db.reverse
			if bar_layout_db.side == "center" then
				if horizontal_mirror then
					reverse = not reverse
				end
			else
				if vertical_mirror then
					reverse = not reverse
				end
			end
			bar:SetReverse(reverse)
			bar:SetDeficit(bar_layout_db.deficit)
		end
	end

	bars = del(bars)
	center_bars = del(center_bars)
	left_bars = del(left_bars)
	right_bars = del(right_bars)
end


--- Return lists of all element ids that represent non-bar-like indicators and texts.
-- The resultant list will be sorted by position.
-- @param frame a unit frame
-- @return a list of all element ids
-- @usage elements = get_all_indicators_and_texts(frame)
local function get_all_indicators_and_texts(frame)
	local indicators_and_texts = new()
	local layout = frame.layout
	
	for id, module in PitBull4:IterateModulesOfType('indicator', 'custom_text') do
		if frame[id] and not module:GetLayoutDB(layout).side then
			indicators_and_texts[#indicators_and_texts+1] = id
		end
	end
	
	for id, module in PitBull4:IterateModulesOfType('text_provider') do
		if frame[id] then
			for name in pairs(frame[id]) do
				indicators_and_texts[#indicators_and_texts+1] = id .. ";" .. name
			end
		end
	end
	
	sort_elements_by_position(indicators_and_texts, layout)
	
	return indicators_and_texts
end

--- Return an estimated half-width of elements in a given location on a frame.
-- @param frame a unit frame
-- @param indicators_and_texts a list of element ids to estimate the width of.
-- @return the estimated number of pixels that make up half the width.
-- @usage local width = get_half_width(frame, { "CombatText", "HappinessIcon" })
local function get_half_width(frame, indicators_and_texts)
	local num = 0
	
	local layout = frame.layout
	local layout_db = frame.layout_db
	
	for _, id in ipairs(indicators_and_texts) do
		local element = frame[id]
		local element_db = get_element_db(id, layout)
		local scale = scale_cache[element]
		if element.SetJustifyH then
			-- a text
			num = num + scale * ASSUMED_TEXT_WIDTH * (element_db and element_db.size or 1)
		else
			-- an indicator
			num = num + scale * (element_db and element_db.size or 1) * layout_db.indicator_size * element:GetWidth() / element:GetHeight() * (element.height or 1)
		end
	end
	
	num = num + (#indicators_and_texts - 1) * layout_db.indicator_spacing
	
	return num / 2
end

-- a dictionary of location to function for the initial indicator to be placed on the unit frame.
local position_indicator_on_root = {}
-- a dictionary of location to function for the initial indicator to be placed on a bar on the unit frame.
local position_indicator_on_bar = {}
-- a dictionary of location to function for a non-starting indicator to be placed on the unit frame
local position_next_indicator_on_root = {}
-- a dictionary of location to function for a non-starting indicator to be placed on a bar on the unit frame
local position_next_indicator_on_bar = {}

function position_indicator_on_root:out_top_left(indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("BOTTOMLEFT", self, "TOPLEFT", -self.layout_db.indicator_root_outside_margin / scale, self.layout_db.indicator_root_outside_margin / scale)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("LEFT")
		indicator:SetJustifyV("BOTTOM")
	end
end
function position_indicator_on_root:out_top_right(indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", self.layout_db.indicator_root_outside_margin / scale, self.layout_db.indicator_root_outside_margin / scale)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("RIGHT")
		indicator:SetJustifyV("BOTTOM")
	end
end
function position_indicator_on_root:out_top(indicator, _, _, indicators_and_texts)
	local scale = scale_cache[indicator]
	if #indicators_and_texts == 1 then
		indicator:SetPoint("BOTTOM", self, "TOP", 0, self.layout_db.indicator_root_outside_margin / scale)
	else
		indicator:SetPoint("BOTTOMLEFT", self, "TOP", -get_half_width(self, indicators_and_texts) / scale, self.layout_db.indicator_root_outside_margin / scale)
	end
	if indicator.SetJustifyH then
		indicator:SetJustifyH("CENTER")
		indicator:SetJustifyV("BOTTOM")
	end
end
function position_indicator_on_root:out_bottom_left(indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("TOPLEFT", self, "BOTTOMLEFT", -self.layout_db.indicator_root_outside_margin / scale, -self.layout_db.indicator_root_outside_margin / scale)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("LEFT")
		indicator:SetJustifyV("TOP")
	end
end
function position_indicator_on_root:out_bottom_right(indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("TOPRIGHT", self, "BOTTOMRIGHT", self.layout_db.indicator_root_outside_margin / scale, -self.layout_db.indicator_root_outside_margin / scale)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("RIGHT")
		indicator:SetJustifyV("TOP")
	end
end
function position_indicator_on_root:out_bottom(indicator, _, _, indicators_and_texts)
	local scale = scale_cache[indicator]
	if #indicators_and_texts == 1 then
		indicator:SetPoint("TOP", self, "BOTTOM", 0, -self.layout_db.indicator_root_outside_margin / scale)
	else
		indicator:SetPoint("TOPLEFT", self, "BOTTOM", -get_half_width(self, indicators_and_texts) / scale, -self.layout_db.indicator_root_outside_margin / scale)
	end
	if indicator.SetJustifyH then
		indicator:SetJustifyH("CENTER")
		indicator:SetJustifyV("TOP")
	end
end
function position_indicator_on_root:out_left_top(indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("TOPRIGHT", self, "TOPLEFT", -self.layout_db.indicator_root_outside_margin / scale, self.layout_db.indicator_root_outside_margin / scale)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("RIGHT")
		indicator:SetJustifyV("TOP")
	end
end
function position_indicator_on_root:out_left(indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("RIGHT", self, "LEFT", -self.layout_db.indicator_root_outside_margin / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("RIGHT")
		indicator:SetJustifyV("MIDDLE")
	end
end
function position_indicator_on_root:out_left_bottom(indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("BOTTOMRIGHT", self, "BOTTOMLEFT", -self.layout_db.indicator_root_outside_margin / scale, -self.layout_db.indicator_root_outside_margin / scale)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("RIGHT")
		indicator:SetJustifyV("BOTTOM")
	end
end
function position_indicator_on_root:out_right_top(indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("TOPLEFT", self, "TOPRIGHT", self.layout_db.indicator_root_outside_margin / scale, self.layout_db.indicator_root_outside_margin / scale)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("LEFT")
		indicator:SetJustifyV("TOP")
	end
end
function position_indicator_on_root:out_right(indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("LEFT", self, "RIGHT", self.layout_db.indicator_root_outside_margin / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("LEFT")
		indicator:SetJustifyV("MIDDLE")
	end
end
function position_indicator_on_root:out_right_bottom(indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("BOTTOMLEFT", self, "BOTTOMRIGHT", self.layout_db.indicator_root_outside_margin / scale, -self.layout_db.indicator_root_outside_margin / scale)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("LEFT")
		indicator:SetJustifyV("BOTTOM")
	end
end
function position_indicator_on_root:in_center(indicator, _, _, indicators_and_texts)
	if #indicators_and_texts == 1 then
		indicator:SetPoint("CENTER", self, "CENTER", 0, 0)
	else
		local scale = scale_cache[indicator]
		indicator:SetPoint("LEFT", self, "CENTER", -get_half_width(self, indicators_and_texts) / scale, 0)
	end
	if indicator.SetJustifyH then
		indicator:SetJustifyH("CENTER")
		indicator:SetJustifyV("MIDDLE")
	end
end
function position_indicator_on_root:in_top_left(indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("TOPLEFT", self, "TOPLEFT", self.layout_db.indicator_root_inside_horizontal_padding / scale, -self.layout_db.indicator_root_inside_vertical_padding / scale)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("LEFT")
		indicator:SetJustifyV("TOP")
	end
end
function position_indicator_on_root:in_top(indicator, _, _, indicators_and_texts)
	local scale = scale_cache[indicator]
	if #indicators_and_texts == 1 then
		indicator:SetPoint("TOP", self, "TOP", 0, -self.layout_db.indicator_root_inside_vertical_padding / scale)
	else
		indicator:SetPoint("TOPLEFT", self, "TOP", -get_half_width(self, indicators_and_texts) / scale, -self.layout_db.indicator_root_inside_vertical_padding / scale)
	end
	if indicator.SetJustifyH then
		indicator:SetJustifyH("CENTER")
		indicator:SetJustifyV("TOP")
	end
end
function position_indicator_on_root:in_top_right(indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("TOPRIGHT", self, "TOPRIGHT", -self.layout_db.indicator_root_inside_horizontal_padding / scale, -self.layout_db.indicator_root_inside_vertical_padding / scale)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("RIGHT")
		indicator:SetJustifyV("TOP")
	end
end
function position_indicator_on_root:in_bottom_left(indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", self.layout_db.indicator_root_inside_horizontal_padding / scale, self.layout_db.indicator_root_inside_vertical_padding / scale)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("LEFT")
		indicator:SetJustifyV("BOTTOM")
	end
end
function position_indicator_on_root:in_bottom(indicator, _, _, indicators_and_texts)
	local scale = scale_cache[indicator]
	if #indicators_and_texts == 1 then
		indicator:SetPoint("BOTTOM", self, "BOTTOM", 0, self.layout_db.indicator_root_inside_vertical_padding / scale)
	else
		indicator:SetPoint("BOTTOMLEFT", self, "BOTTOM", -get_half_width(self, indicators_and_texts) / scale, self.layout_db.indicator_root_inside_vertical_padding / scale)
	end
	if indicator.SetJustifyH then
		indicator:SetJustifyH("CENTER")
		indicator:SetJustifyV("BOTTOM")
	end
end
function position_indicator_on_root:in_bottom_right(indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -self.layout_db.indicator_root_inside_horizontal_padding / scale, self.layout_db.indicator_root_inside_vertical_padding / scale)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("RIGHT")
		indicator:SetJustifyV("BOTTOM")
	end
end
function position_indicator_on_root:in_left(indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("LEFT", self, "LEFT", self.layout_db.indicator_root_inside_horizontal_padding / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("LEFT")
		indicator:SetJustifyV("MIDDLE")
	end
end
function position_indicator_on_root:in_right(indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("RIGHT", self, "RIGHT", -self.layout_db.indicator_root_inside_horizontal_padding / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("RIGHT")
		indicator:SetJustifyV("MIDDLE")
	end
end
function position_indicator_on_root:edge_top_left(indicator)
	if indicator.SetJustifyH then
		indicator:SetPoint("LEFT", self, "TOPLEFT", 0, 0)
		indicator:SetJustifyH("CENTER")
		indicator:SetJustifyV("MIDDLE")
	else
		indicator:SetPoint("CENTER", self, "TOPLEFT", 0, 0)
	end
end
function position_indicator_on_root:edge_top(indicator, _, _, indicators_and_texts)
	if #indicators_and_texts == 1 then
		indicator:SetPoint("CENTER", self, "TOP", 0, 0)
	else
		local scale = scale_cache[indicator]
		indicator:SetPoint("LEFT", self, "TOP", -get_half_width(self, indicators_and_texts) / scale, 0)
	end
	if indicator.SetJustifyH then
		indicator:SetJustifyH("CENTER")
		indicator:SetJustifyV("MIDDLE")
	end
end
function position_indicator_on_root:edge_top_right(indicator)
	if indicator.SetJustifyH then
		indicator:SetPoint("RIGHT", self, "TOPRIGHT", 0, 0)
		indicator:SetJustifyH("CENTER")
		indicator:SetJustifyV("MIDDLE")
	else
		indicator:SetPoint("CENTER", self, "TOPRIGHT", 0, 0)
	end
end
function position_indicator_on_root:edge_left(indicator)
	if indicator.SetJustifyH then
		indicator:SetPoint("RIGHT", self, "LEFT", 0, 0)
		indicator:SetJustifyH("CENTER")
		indicator:SetJustifyV("MIDDLE")
	else
		indicator:SetPoint("CENTER", self, "LEFT", 0, 0)
	end
end
function position_indicator_on_root:edge_right(indicator)
	if indicator.SetJustifyH then
		indicator:SetPoint("LEFT", self, "RIGHT", 0, 0)
		indicator:SetJustifyH("CENTER")
		indicator:SetJustifyV("MIDDLE")
	else
		indicator:SetPoint("CENTER", self, "RIGHT", 0, 0)
	end
end
function position_indicator_on_root:edge_bottom_left(indicator)
	if indicator.SetJustifyH then
		indicator:SetPoint("LEFT", self, "BOTTOMLEFT", 0, 0)
		indicator:SetJustifyH("CENTER")
		indicator:SetJustifyV("MIDDLE")
	else
		indicator:SetPoint("CENTER", self, "BOTTOMLEFT", 0, 0)
	end
end
function position_indicator_on_root:edge_bottom(indicator, _, _, indicators_and_texts)
	if #indicators_and_texts == 1 then
		indicator:SetPoint("CENTER", self, "BOTTOM", 0, 0)
	else
		local scale = scale_cache[indicator]
		indicator:SetPoint("LEFT", self, "BOTTOM", -get_half_width(self, indicators_and_texts) / scale, 0)
	end
	if indicator.SetJustifyH then
		indicator:SetJustifyH("CENTER")
		indicator:SetJustifyV("MIDDLE")
	end
end
function position_indicator_on_root:edge_bottom_right(indicator)
	if indicator.SetJustifyH then
		indicator:SetPoint("RIGHT", self, "BOTTOMRIGHT", 0, 0)
		indicator:SetJustifyH("CENTER")
		indicator:SetJustifyV("MIDDLE")
	else
		indicator:SetPoint("CENTER", self, "BOTTOMRIGHT", 0, 0)
	end
end

function position_indicator_on_bar:left(indicator, bar)
	local attach
	if bar.reverse then
		attach = bar.bg
	else
		attach = bar.fg
	end
	if not attach then
		attach = bar
	end
	
	local scale = scale_cache[indicator]
	indicator:SetPoint("LEFT", attach, "LEFT", self.layout_db.indicator_bar_inside_horizontal_padding / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("LEFT")
		indicator:SetJustifyV("MIDDLE")
	end
end
function position_indicator_on_bar:center(indicator, bar, _, indicators_and_texts)
	if #indicators_and_texts == 1 then
		indicator:SetPoint("CENTER", bar, "CENTER", 0, 0)
	else
		local scale = scale_cache[indicator]
		indicator:SetPoint("LEFT", bar, "CENTER", -get_half_width(self, indicators_and_texts) / scale, 0)
	end
	if indicator.SetJustifyH then
		indicator:SetJustifyH("CENTER")
		indicator:SetJustifyV("MIDDLE")
	end
end
function position_indicator_on_bar:right(indicator, bar)
	local attach
	if bar.reverse then
		attach = bar.fg
	else
		attach = bar.bg
	end
	if not attach then
		attach = bar
	end
	
	local scale = scale_cache[indicator]
	indicator:SetPoint("RIGHT", attach, "RIGHT", -self.layout_db.indicator_bar_inside_horizontal_padding / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("RIGHT")
		indicator:SetJustifyV("MIDDLE")
	end
end
function position_indicator_on_bar:top(indicator, bar, _, indicators_and_texts)
	local attach
	if bar.reverse then
		attach = bar.fg
	else
		attach = bar.bg
	end
	if not attach then
		attach = bar
	end
	
	if #indicators_and_texts == 1 then
		indicator:SetPoint("TOP", attach, "TOP", 0, 0)
	else
		local scale = scale_cache[indicator]
		indicator:SetPoint("TOPLEFT", attach, "TOP", -get_half_width(self, indicators_and_texts) / scale, -self.layout_db.indicator_bar_inside_vertical_padding / scale)
	end
	if indicator.SetJustifyH then
		indicator:SetJustifyH("CENTER")
		indicator:SetJustifyV("TOP")
	end
end
function position_indicator_on_bar:bottom(indicator, bar, _, indicators_and_texts)
	local attach
	if bar.reverse then
		attach = bar.bg
	else
		attach = bar.fg
	end
	if not attach then
		attach = bar
	end
	
	if #indicators_and_texts == 1 then
		indicator:SetPoint("BOTTOM", attach, "BOTTOM", 0, 0)
	else
		local scale = scale_cache[indicator]
		indicator:SetPoint("BOTTOMLEFT", attach, "BOTTOM", -get_half_width(self, indicators_and_texts) / scale, self.layout_db.indicator_bar_inside_vertical_padding / scale)
	end
	if indicator.SetJustifyH then
		indicator:SetJustifyH("CENTER")
		indicator:SetJustifyV("BOTTOM")
	end
end
function position_indicator_on_bar:top_left(indicator, bar)
	local scale = scale_cache[indicator]
	indicator:SetPoint("TOPLEFT", bar, "TOPLEFT", self.layout_db.indicator_bar_inside_horizontal_padding / scale, -self.layout_db.indicator_bar_inside_vertical_padding / scale)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("LEFT")
		indicator:SetJustifyV("TOP")
	end
end
function position_indicator_on_bar:top_right(indicator, bar)
	local scale = scale_cache[indicator]
	indicator:SetPoint("TOPRIGHT", bar, "TOPRIGHT", -self.layout_db.indicator_bar_inside_horizontal_padding / scale, -self.layout_db.indicator_bar_inside_vertical_padding / scale)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("RIGHT")
		indicator:SetJustifyV("TOP")
	end
end
function position_indicator_on_bar:bottom_left(indicator, bar)
	local scale = scale_cache[indicator]
	indicator:SetPoint("BOTTOMLEFT", bar, "BOTTOMLEFT", self.layout_db.indicator_bar_inside_horizontal_padding / scale, self.layout_db.indicator_bar_inside_vertical_padding / scale)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("LEFT")
		indicator:SetJustifyV("BOTTOM")
	end
end
function position_indicator_on_bar:bottom_right(indicator, bar)
	local scale = scale_cache[indicator]
	indicator:SetPoint("BOTTOMRIGHT", bar, "BOTTOMRIGHT", -self.layout_db.indicator_bar_inside_horizontal_padding / scale, self.layout_db.indicator_bar_inside_vertical_padding / scale)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("RIGHT")
		indicator:SetJustifyV("BOTTOM")
	end
end
function position_indicator_on_bar:out_right(indicator, bar)
	local scale = scale_cache[indicator]
	indicator:SetPoint("LEFT", bar, "RIGHT", self.layout_db.indicator_bar_outside_margin / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("LEFT")
		indicator:SetJustifyV("MIDDLE")
	end
end
function position_indicator_on_bar:out_left(indicator, bar)
	local scale = scale_cache[indicator]
	indicator:SetPoint("RIGHT", bar, "LEFT", -self.layout_db.indicator_bar_outside_margin / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("RIGHT")
		indicator:SetJustifyV("MIDDLE")
	end
end
function position_indicator_on_bar:out_top(indicator, bar)
	local scale = scale_cache[indicator]
	indicator:SetPoint("BOTTOM", bar, "TOP", 0, self.layout_db.indicator_bar_outside_margin / scale)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("CENTER")
		indicator:SetJustifyV("TOP")
	end
end
function position_indicator_on_bar:out_bottom(indicator, bar)
	local scale = scale_cache[indicator]
	indicator:SetPoint("TOP", bar, "BOTTOM", 0, -self.layout_db.indicator_bar_outside_margin / scale)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("CENTER")
		indicator:SetJustifyV("BOTTOM")
	end
end

function position_next_indicator_on_root:out_top_left(indicator, _, last_indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("BOTTOMLEFT", last_indicator, "BOTTOMRIGHT", self.layout_db.indicator_spacing / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("LEFT")
		indicator:SetJustifyV("BOTTOM")
	end
end
function position_next_indicator_on_root:out_top(indicator, _, last_indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("BOTTOMLEFT", last_indicator, "BOTTOMRIGHT", self.layout_db.indicator_spacing / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("CENTER")
		indicator:SetJustifyV("BOTTOM")
	end
end
function position_next_indicator_on_root:out_bottom_left(indicator, _, last_indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("TOPLEFT", last_indicator, "TOPRIGHT", self.layout_db.indicator_spacing / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("LEFT")
		indicator:SetJustifyV("TOP")
	end
end
function position_next_indicator_on_root:out_bottom(indicator, _, last_indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("TOPLEFT", last_indicator, "TOPRIGHT", self.layout_db.indicator_spacing / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("CENTER")
		indicator:SetJustifyV("TOP")
	end
end
function position_next_indicator_on_root:out_right_top(indicator, _, last_indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("TOPLEFT", last_indicator, "TOPRIGHT", self.layout_db.indicator_spacing / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("LEFT")
		indicator:SetJustifyV("TOP")
	end
end
function position_next_indicator_on_root:out_right(indicator, _, last_indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("LEFT", last_indicator, "RIGHT", self.layout_db.indicator_spacing / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("LEFT")
		indicator:SetJustifyV("MIDDLE")
	end
end
function position_next_indicator_on_root:out_right_bottom(indicator, _, last_indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("BOTTOMLEFT", last_indicator, "BOTTOMRIGHT", self.layout_db.indicator_spacing / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("LEFT")
		indicator:SetJustifyV("BOTTOM")
	end
end
function position_next_indicator_on_root:in_center(indicator, _, last_indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("LEFT", last_indicator, "RIGHT", self.layout_db.indicator_spacing / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("CENTER")
		indicator:SetJustifyV("MIDDLE")
	end
end
function position_next_indicator_on_root:in_top_left(indicator, _, last_indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("TOPLEFT", last_indicator, "TOPRIGHT", self.layout_db.indicator_spacing / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("LEFT")
		indicator:SetJustifyV("TOP")
	end
end
function position_next_indicator_on_root:in_top(indicator, _, last_indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("TOPLEFT", last_indicator, "TOPRIGHT", self.layout_db.indicator_spacing / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("CENTER")
		indicator:SetJustifyV("TOP")
	end
end
function position_next_indicator_on_root:in_bottom_left(indicator, _, last_indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("BOTTOMLEFT", last_indicator, "BOTTOMRIGHT", self.layout_db.indicator_spacing / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("LEFT")
		indicator:SetJustifyV("BOTTOM")
	end
end
function position_next_indicator_on_root:in_bottom(indicator, _, last_indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("BOTTOMLEFT", last_indicator, "BOTTOMRIGHT", self.layout_db.indicator_spacing / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("CENTER")
		indicator:SetJustifyV("BOTTOM")
	end
end
function position_next_indicator_on_root:in_left(indicator, _, last_indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("LEFT", last_indicator, "RIGHT", self.layout_db.indicator_spacing / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("LEFT")
		indicator:SetJustifyV("MIDDLE")
	end
end
function position_next_indicator_on_root:edge_top_left(indicator, _, last_indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("LEFT", last_indicator, "RIGHT", self.layout_db.indicator_spacing / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("CENTER")
		indicator:SetJustifyV("MIDDLE")
	end
end
function position_next_indicator_on_root:edge_top(indicator, _, last_indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("LEFT", last_indicator, "RIGHT", self.layout_db.indicator_spacing / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("CENTER")
		indicator:SetJustifyV("MIDDLE")
	end
end
function position_next_indicator_on_root:edge_left(indicator, _, last_indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("LEFT", last_indicator, "RIGHT", self.layout_db.indicator_spacing / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("CENTER")
		indicator:SetJustifyV("MIDDLE")
	end
end
function position_next_indicator_on_root:edge_bottom_left(indicator, _, last_indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("LEFT", last_indicator, "RIGHT", self.layout_db.indicator_spacing / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("CENTER")
		indicator:SetJustifyV("MIDDLE")
	end
end
function position_next_indicator_on_root:edge_bottom(indicator, _, last_indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("LEFT", last_indicator, "RIGHT", self.layout_db.indicator_spacing / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("CENTER")
		indicator:SetJustifyV("MIDDLE")
	end
end
function position_next_indicator_on_root:out_top_right(indicator, _, last_indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("BOTTOMRIGHT", last_indicator, "BOTTOMLEFT", -self.layout_db.indicator_spacing / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("RIGHT")
		indicator:SetJustifyV("BOTTOM")
	end
end
function position_next_indicator_on_root:out_bottom_right(indicator, _, last_indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("TOPRIGHT", last_indicator, "TOPLEFT", -self.layout_db.indicator_spacing / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("RIGHT")
		indicator:SetJustifyV("TOP")
	end
end
function position_next_indicator_on_root:out_left_top(indicator, _, last_indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("TOPRIGHT", last_indicator, "TOPLEFT", -self.layout_db.indicator_spacing / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("RIGHT")
		indicator:SetJustifyV("TOP")
	end
end
function position_next_indicator_on_root:out_left(indicator, _, last_indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("RIGHT", last_indicator, "LEFT", -self.layout_db.indicator_spacing / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("RIGHT")
		indicator:SetJustifyV("MIDDLE")
	end
end
function position_next_indicator_on_root:out_left_bottom(indicator, _, last_indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("BOTTOMRIGHT", last_indicator, "BOTTOMLEFT", -self.layout_db.indicator_spacing / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("RIGHT")
		indicator:SetJustifyV("BOTTOM")
	end
end
function position_next_indicator_on_root:in_top_right(indicator, _, last_indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("TOPRIGHT", last_indicator, "TOPLEFT", -self.layout_db.indicator_spacing / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("RIGHT")
		indicator:SetJustifyV("TOP")
	end
end
function position_next_indicator_on_root:in_bottom_right(indicator, _, last_indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("BOTTOMRIGHT", last_indicator, "BOTTOMLEFT", -self.layout_db.indicator_spacing / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("RIGHT")
		indicator:SetJustifyV("BOTTOM")
	end
end
function position_next_indicator_on_root:in_right(indicator, _, last_indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("RIGHT", last_indicator, "LEFT", -self.layout_db.indicator_spacing / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("RIGHT")
		indicator:SetJustifyV("MIDDLE")
	end
end
function position_next_indicator_on_root:edge_top_right(indicator, _, last_indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("RIGHT", last_indicator, "LEFT", -self.layout_db.indicator_spacing / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("CENTER")
		indicator:SetJustifyV("MIDDLE")
	end
end
function position_next_indicator_on_root:edge_right(indicator, _, last_indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("RIGHT", last_indicator, "LEFT", -self.layout_db.indicator_spacing / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("CENTER")
		indicator:SetJustifyV("MIDDLE")
	end
end
function position_next_indicator_on_root:edge_bottom_right(indicator, _, last_indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("RIGHT", last_indicator, "LEFT", -self.layout_db.indicator_spacing / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("CENTER")
		indicator:SetJustifyV("MIDDLE")
	end
end

function position_next_indicator_on_bar:left(indicator, bar, last_indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("LEFT", last_indicator, "RIGHT", self.layout_db.indicator_spacing / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("LEFT")
		indicator:SetJustifyV("MIDDLE")
	end
end
function position_next_indicator_on_bar:center(indicator, bar, last_indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("LEFT", last_indicator, "RIGHT", self.layout_db.indicator_spacing / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("CENTER")
		indicator:SetJustifyV("MIDDLE")
	end
end
function position_next_indicator_on_bar:out_right(indicator, bar, last_indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("LEFT", last_indicator, "RIGHT", self.layout_db.indicator_spacing / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("LEFT")
		indicator:SetJustifyV("MIDDLE")
	end
end
function position_next_indicator_on_bar:top_left(indicator, bar, last_indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("TOPLEFT", last_indicator, "TOPRIGHT", self.layout_db.indicator_spacing / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("LEFT")
		indicator:SetJustifyV("TOP")
	end
end
function position_next_indicator_on_bar:top(indicator, bar, last_indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("TOPLEFT", last_indicator, "TOPRIGHT", self.layout_db.indicator_spacing / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("CENTER")
		indicator:SetJustifyV("TOP")
	end
end
function position_next_indicator_on_bar:bottom_left(indicator, bar, last_indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("BOTTOMLEFT", last_indicator, "BOTTOMRIGHT", self.layout_db.indicator_spacing / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("LEFT")
		indicator:SetJustifyV("BOTTOM")
	end
end
function position_next_indicator_on_bar:bottom(indicator, bar, last_indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("BOTTOMLEFT", last_indicator, "BOTTOMRIGHT", self.layout_db.indicator_spacing / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("CENTER")
		indicator:SetJustifyV("BOTTOM")
	end
end
function position_next_indicator_on_bar:right(indicator, bar, last_indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("RIGHT", last_indicator, "LEFT", -self.layout_db.indicator_spacing / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("RIGHT")
		indicator:SetJustifyV("MIDDLE")
	end
end
function position_next_indicator_on_bar:out_left(indicator, bar, last_indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("RIGHT", last_indicator, "LEFT", -self.layout_db.indicator_spacing / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("RIGHT")
		indicator:SetJustifyV("MIDDLE")
	end
end
function position_next_indicator_on_bar:top_right(indicator, bar, last_indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("TOPRIGHT", last_indicator, "TOPLEFT", -self.layout_db.indicator_spacing / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("RIGHT")
		indicator:SetJustifyV("TOP")
	end
end
function position_next_indicator_on_bar:bottom_right(indicator, bar, last_indicator)
	local scale = scale_cache[indicator]
	indicator:SetPoint("BOTTOMRIGHT", last_indicator, "BOTTOMLEFT", -self.layout_db.indicator_spacing / scale, 0)
	if indicator.SetJustifyH then
		indicator:SetJustifyH("RIGHT")
		indicator:SetJustifyV("BOTTOM")
	end
end

--- Position an indicator on the unit frame based on the given arguments.
-- @param frame a unit frame
-- @param indicator_id the id of the indicator to position on the unit frame
-- @param attach_frame what frame we're currently attaching to. This can be the unit frame or a separate bar.
-- @param last_indicator_id the id of the last indicator we placed down, or nil if we haven't placed one down yet.
-- @param location the location we're placing the indicator in relation to attach_frame.
-- @param indicators_and_texts a list of element ids in the same location.
-- @usage position_indicator_or_text(frame, "PvPIcon", frame, nil, "edge_top_left", { "PvPIcon", "CombatIcon" })
local function position_indicator_or_text(frame, indicator_id, attach_frame, last_indicator_id, location, indicators_and_texts)
	local func
	if not last_indicator_id then
		if frame == attach_frame then
			func = position_indicator_on_root[location]
		else
			func = position_indicator_on_bar[location]
		end
	else
		if frame == attach_frame then
			func = position_next_indicator_on_root[location]
		else
			func = position_next_indicator_on_bar[location]
		end
	end
	if func then
		func(frame, frame[indicator_id], attach_frame, frame[last_indicator_id] or frame, indicators_and_texts)
	end
end

--- Position texts to one another so that they don't overlap.
-- Priority-wise, it goes center, then right, then left for what takes precedence.
-- @param frame the unit frame
-- @param attach_frame the attach frame that the texts reside on
-- @param left the element ids of all indicators and texts on the left side
-- @param center the element ids of all indicators and texts in the center
-- @param right the element ids of all indicators and texts in the right side
-- @param inside_width how far inside a left text would be attaching to attach_frame's right side
-- @param spacing the spacing between texts
-- @usage position_overlapping_texts__helper(frame, frame.HealthBar, { "DogTagTexts;Name" }, {}, { "DogTagTexts;Health" }, 3, 2)
local function position_overlapping_texts__helper(frame, attach_frame, left, center, right, inside_width, spacing)
	if center then
		-- clamp left to center
		if left then
			local text = frame[left[#left]]
		 	if text.SetJustifyH then
				text:SetPoint("RIGHT", frame[center[1]], "LEFT", -spacing, 0)
			end
		end
	
		-- clamp right to center
		if right then
			local text = frame[right[#right]]
			if text.SetJustifyH then
				text:SetPoint("LEFT", frame[center[#center]], "RIGHT", spacing, 0)
			end
		end
	elseif left then
		local text = frame[left[#left]]
		if text.SetJustifyH then	
			if right then
				-- clamp left to right
				text:SetPoint("RIGHT", frame[right[#right]], "LEFT", -spacing, 0)
			else
				-- clamp left to attach_frame's right side
				text:SetPoint("RIGHT", attach_frame, "RIGHT", -inside_width, 0)
			end
		end
	end
end

--- Position texts on a given attach frame to not overlap one another.
-- @param frame a unit frame
-- @param attach_frame the frame the texts attach to, or frame for the unit frame itself
-- @param location_to_indicators_and_texts a dictionary of location to indicators and texts
-- @usage position_overlapping_texts(frame, frame.HealthBar, { left = {"DogTagTexts;Name"}, right = {"DogTagTexts;Health"}})
local function position_overlapping_texts(frame, attach_frame, location_to_indicators_and_texts)
	local spacing = frame.layout_db.indicator_spacing
	if frame == attach_frame then
		local padding = frame.layout_db.bar_padding
		position_overlapping_texts__helper(frame,
			attach_frame,
			location_to_indicators_and_texts.in_left,
			location_to_indicators_and_texts.in_center,
			location_to_indicators_and_texts.in_right,
			padding,
			spacing)
		position_overlapping_texts__helper(frame,
			attach_frame,
			location_to_indicators_and_texts.in_bottom_left,
			location_to_indicators_and_texts.in_bottom,
			location_to_indicators_and_texts.in_bottom_right,
			padding,
			spacing)
		position_overlapping_texts__helper(frame,
			attach_frame,
			location_to_indicators_and_texts.in_top_left,
			location_to_indicators_and_texts.in_top,
			location_to_indicators_and_texts.in_top_right,
			padding,
			spacing)
		position_overlapping_texts__helper(frame,
			attach_frame,
			location_to_indicators_and_texts.out_bottom_left,
			location_to_indicators_and_texts.out_bottom,
			location_to_indicators_and_texts.out_bottom_right,
			padding,
			spacing)
		position_overlapping_texts__helper(frame,
			attach_frame,
			location_to_indicators_and_texts.out_top_left,
			location_to_indicators_and_texts.out_top,
			location_to_indicators_and_texts.out_top_right,
			padding,
			spacing)
	else
		local padding = frame.layout_db.indicator_bar_inside_horizontal_padding
		position_overlapping_texts__helper(frame,
			attach_frame,
			location_to_indicators_and_texts.left,
			location_to_indicators_and_texts.center,
			location_to_indicators_and_texts.right,
			padding,
			spacing)
		position_overlapping_texts__helper(frame,
			attach_frame,
			location_to_indicators_and_texts.top_left,
			location_to_indicators_and_texts.top,
			location_to_indicators_and_texts.top_right,
			padding,
			spacing)
		position_overlapping_texts__helper(frame,
			attach_frame,
			location_to_indicators_and_texts.bottom_left,
			location_to_indicators_and_texts.bottom,
			location_to_indicators_and_texts.bottom_right,
			padding,
			spacing)
	end
end

-- a dictionary of location to what the location would be if it were mirrored horizontally
local horizontal_mirrored_location = setmetatable({}, {__index = function(self, key)
	local value = key:gsub("left", "temp"):gsub("right", "left"):gsub("temp", "right")
	self[key] = value
	return value
end})

-- a dictionary of location to what the location would be if it were mirrored vertically
local vertical_mirrored_location = setmetatable({}, {__index = function(self, key)
	local value = key:gsub("bottom", "temp"):gsub("top", "bottom"):gsub("temp", "top")
	self[key] = value
	return value
end})

--- Position all non-bar-like indicators and texts on the given frame.
-- @param frame a unit frame
-- @usage update_indicator_and_text_layout(frame)
local function update_indicator_and_text_layout(frame)
	local attachments = new()
	
	local layout = frame.layout
	
	local horizontal_mirror = frame.classification_db.horizontal_mirror
	local vertical_mirror = frame.classification_db.vertical_mirror
	
	local indicator_size = frame.layout_db.indicator_size
	
	for _, id in ipairs_with_del(get_all_indicators_and_texts(frame)) do
		local element = frame[id]
		local module_id = id
		local element_id = nil
		local module
		local element_db
		if module_id:match(";") then
			module_id, element_id = (";"):split(module_id, 2)
		end
		
		module = PitBull4.modules[module_id]
		element_db = module:GetLayoutDB(layout)
		if element_id then
			element_db = element_db.elements[element_id]
		end
	
		local attach_to = element_db.attach_to
		local attach_frame
		if attach_to == "root" then
			attach_frame = frame
		else
			attach_frame = frame[attach_to]
		end
		
		if attach_frame then
			local location = element_db.location
		
			local flip_positions = false
			if horizontal_mirror then
				local old_location = location
				location = horizontal_mirrored_location[location]
				if old_location == location then
					flip_positions = true
				end
			end
		
			if vertical_mirror then
				location = vertical_mirrored_location[location]
			end
			
			if INDICATOR_MODULE_TYPES[module.module_type] then
				local size = indicator_size * element_db.size
				local unscaled_height = element:GetHeight()
				local height_multiplier = element.height or 1
				local scale = indicator_size / unscaled_height * element_db.size * height_multiplier
				element:SetScale(scale)
				scale_cache[element] = scale
			else
				local _, size = element:GetFont()
				scale_cache[element] = size / DEFAULT_FONT_SIZE
			end
			
			element:ClearAllPoints()
			
			local attachments_attach_frame = attachments[attach_frame]
			if not attachments_attach_frame then
				attachments_attach_frame = new()
				attachments[attach_frame] = attachments_attach_frame
			end
			
			local attachments_attach_frame_location = attachments_attach_frame[location]
			if not attachments_attach_frame_location then
				attachments_attach_frame_location = new()
				attachments_attach_frame[location] = attachments_attach_frame_location
			end
			
			if flip_positions then
				table.insert(attachments_attach_frame_location, 1, id)
			else
				attachments_attach_frame_location[#attachments_attach_frame_location+1] = id
			end
		end
	end
	
	for attach_frame, attachments_attach_frame in pairs(attachments) do
		for location, loc_indicators_and_texts in pairs(attachments_attach_frame) do
			local last = nil
			for _, id in ipairs(loc_indicators_and_texts) do
				position_indicator_or_text(frame, id, attach_frame, last, location, loc_indicators_and_texts)
				last = id
			end
		end
		
		position_overlapping_texts(frame, attach_frame, attachments_attach_frame)
		
		for location, loc_indicators_and_texts in pairs(attachments_attach_frame) do
			attachments_attach_frame[location] = del(loc_indicators_and_texts)
		end
		attachments[attach_frame] = del(attachments_attach_frame)
	end
	attachments = del(attachments)
	wipe(scale_cache)
end

--- Reposition all controls on the Unit Frame
-- @param should_update_texts whether :Update should be called for the frame on text modules
-- @usage frame:UpdateLayout()
function UnitFrame:UpdateLayout(should_update_texts)
	if DEBUG then
		expect(should_update_texts, 'typeof', 'boolean')
	end
	if not self.classification_db or not self.layout_db then
		-- Possibly unused frame made for another profile
		return
	end
	update_bar_layout(self)
	if should_update_texts then
		for module_type in pairs(TEXT_MODULE_TYPES) do
			for _, module in PitBull4:IterateModulesOfType(module_type) do
				module:Update(self, true, true)
			end
		end
	end
	update_indicator_and_text_layout(self)
end
