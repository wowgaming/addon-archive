-- Layout.lua : Code to size and position the aura frames.

if select(6, GetAddOnInfo("PitBull4_" .. (debugstack():match("[o%.][d%.][u%.]les\\(.-)\\") or ""))) ~= "MISSING" then return end

local _G = getfenv(0)
local PitBull4 = _G.PitBull4
local PitBull4_Aura = PitBull4:GetModule("Aura")

-- Dispatch table to actually have things grow in the right order.
local set_direction_point = {
	left_up = function(ctrl, pnt, frame, anchor, x, y, o_x, o_y)
		ctrl:SetPoint(pnt, frame, anchor, -x + o_x, y + o_y)
	end,
	left_down = function(ctrl, pnt, frame, anchor, x, y, o_x, o_y)
		ctrl:SetPoint(pnt, frame, anchor, -x + o_x, -y + o_y)
	end,
	right_up = function(ctrl, pnt, frame, anchor, x, y, o_x, o_y)
		ctrl:SetPoint(pnt, frame, anchor, x + o_x, y + o_y)
	end,
	right_down = function(ctrl, pnt, frame, anchor, x, y, o_x, o_y)
		ctrl:SetPoint(pnt, frame, anchor, x + o_x, -y + o_y)
	end,
	up_left = function(ctrl, pnt, frame, anchor, x, y, o_x, o_y)
		ctrl:SetPoint(pnt, frame, anchor, -y + o_x, x + o_y)
	end,
	up_right = function(ctrl, pnt, frame, anchor, x, y, o_x, o_y)
		ctrl:SetPoint(pnt, frame, anchor, y + o_x, x + o_y)
	end,
	down_left = function(ctrl, pnt, frame, anchor, x, y, o_x, o_y)
		ctrl:SetPoint(pnt, frame, anchor, -y + o_x, -x + o_y)
	end,
	down_right = function(ctrl, pnt, frame, anchor, x, y, o_x, o_y)
		ctrl:SetPoint(pnt, frame, anchor, y + o_x, -x + o_y)
	end,
}

local get_control_point = {
	TOPLEFT_TOP        = 'BOTTOMLEFT',
	TOPRIGHT_TOP       = 'BOTTOMRIGHT',
	TOPLEFT_LEFT       = 'TOPRIGHT',
	TOPRIGHT_RIGHT     = 'TOPLEFT',
	BOTTOMLEFT_BOTTOM  = 'TOPLEFT',
	BOTTOMRIGHT_BOTTOM = 'TOPRIGHT',
	BOTTOMLEFT_LEFT    = 'BOTTOMRIGHT',
	BOTTOMRIGHT_RIGHT  = 'BOTTOMLEFT',
}

local grow_vert_first = {
	down_right = true,
	down_left  = true,
	up_right   = true,
	up_left    = true,
}

local first_row_behind_anchor = {
	left_down = {
		BOTTOMLEFT = true,
		BOTTOMRIGHT = true,
	},
	right_down = {
		BOTTOMLEFT = true,
		BOTTOMRIGHT = true,
	},
	left_up = {
		TOPLEFT = true,
		TOPRIGHT = true,
	},
	right_up = {
		TOPLEFT = true,
		TOPRIGHT = true,
	},
	up_left = {
		TOPLEFT = true,
		BOTTOMLEFT = true,
	},
	down_left = {
		TOPLEFT = true,
		BOTTOMLEFT = true,
	},
	up_right = {
		TOPRIGHT = true,
		BOTTOMRIGHT = true,
	},
	down_right = {
		TOPRIGHT = true,
		BOTTOMRIGHT = true,
	},
}

local first_col_behind_anchor = {
	left_down = {
		TOPLEFT = true,
		BOTTOMLEFT = true,
	},
	right_down = {
		TOPRIGHT = true,
		BOTTOMRIGHT = true,
	},
	left_up = {
		TOPLEFT = true,
		BOTTOMLEFT = true,
	},
	right_up = {
		TOPRIGHT = true,
		BOTTOMRIGHT = true,
	},
	up_left = {
		TOPRIGHT = true,
		TOPLEFT = true,
	},
	down_left = {
		BOTTOMRIGHT = true,
		BOTTOMLEFT = true,
	},
	up_right = {
		TOPRIGHT = true,
		TOPLEFT = true,
	},
	down_right = {
		BOTTOMRIGHT = true,
		BOTTOMLEFT = true,
	},
}

-- Lookup tables to allow frames that are configured to mirror horizontally
-- or vertically to position Auras with these configurations.
local horizontal_mirrored_growth = setmetatable({}, {__index = function(self, key)
  local value = key:gsub("left", "temp"):gsub("right", "left"):gsub("temp", "right")
  self[key] = value
  return value
end})

local vertical_mirrored_growth = setmetatable({}, {__index = function(self, key)
  local value = key:gsub("down", "temp"):gsub("up", "down"):gsub("temp", "up")
  self[key] = value
  return value
end})

local horizontal_mirrored_point = setmetatable({}, {__index = function(self, key)
  local value = key:gsub("LEFT", "temp"):gsub("RIGHT", "LEFT"):gsub("temp", "RIGHT")
  self[key] = value
  return value
end})

local vertical_mirrored_point = setmetatable({}, {__index = function(self, key)
  local value = key:gsub("BOTTOM", "temp"):gsub("TOP", "BOTTOM"):gsub("temp", "TOP")
  self[key] = value
  return value
end})


local function layout_auras(frame, db, is_buff)
	local list, cfg
	if is_buff then
		list = frame.aura_buffs
		cfg = db.layout.buff
	else
		list = frame.aura_debuffs
		cfg = db.layout.debuff
	end
	if not list then return end
	local class_db = frame.classification_db

	-- Grab our config vars to avoid repeated table lookups
	local offset_x, offset_y = cfg.offset_x, cfg.offset_y
	local other_size = cfg.size
	local my_size = cfg.my_size
	local anchor = cfg.anchor
	local side = cfg.side
	local growth = cfg.growth
	local width, width_type = cfg.width, cfg.width_type
	local row_spacing, col_spacing = cfg.row_spacing, cfg.col_spacing
	local new_row_size = cfg.new_row_size
	local sorted = cfg.sort

	-- Deal with mirror options
	if class_db then
		if class_db.horizontal_mirror then
			anchor = horizontal_mirrored_point[anchor]
			side = horizontal_mirrored_point[side]
			growth = horizontal_mirrored_growth[growth]
			offset_x = -offset_x
		end
		if class_db.vertical_mirror then
			anchor = vertical_mirrored_point[anchor]
			side = vertical_mirrored_point[side]
			growth = vertical_mirrored_growth[growth]
			offset_y = -offset_y
		end
	end

	-- Find the anchor point on the control
	local point = get_control_point[anchor..'_'..side]

	-- Our current position to place the control
	local x, y = 0, 0

	-- Current height of the row
	local row = 0
	-- Previous width/height on this row
	local prev_width
	local prev_height

	-- Variables for tracking sub-rows.  Subrows let
	-- smaller icons stack up next to larger icons
	-- for a normal fit.
	local sub_row_origin_x -- the x position we started at
	local sub_row_origin_y -- the y position we started at
	local origin_row_end -- the y position we can't grow past

	-- Determine when to increase the y position
	local use_new_row_height = first_row_behind_anchor[growth][point]

	-- Determine if the anchor requires us to offset the row start
	local use_alt_row_start = first_col_behind_anchor[growth][point]

	-- Offset from the zero point that we use to allow differing
	-- sized auras to align
	local row_start = 0

	-- Get function to set the point for the auras
	local set_point = set_direction_point[growth]

	-- Convert the percent based width to a fixed width
	if width_type == 'percent' then
		local side_width
		if grow_vert_first[growth] then
			side_width = frame:GetHeight()
		else
			side_width = frame:GetWidth()
		end
		width = side_width * cfg.width_percent
		width_type = 'fixed'
	end

	-- Swap row and col spacing if we're growing up or down first.
	if grow_vert_first[growth] then
		row_spacing, col_spacing = col_spacing, row_spacing
	end

	-- Size to fit
	if cfg.size_to_fit then
		local my_rowcount = math.floor(width/(my_size + col_spacing))
		local other_rowcount = math.floor(width/(other_size + col_spacing))
		my_size = my_size * width/((my_size + col_spacing) * my_rowcount)
		other_size = other_size * width/((other_size + col_spacing) * other_rowcount)
	end

	-- Allow reversal of the load order
	local start_list, end_list, step
	if cfg.reverse then
		start_list = #list
		end_list = 1
		step = -1
	else
		start_list = 1
		end_list = #list
		step = 1
	end

	for i = start_list, end_list, step do
		local control = list[i]
		local display = true

		local size = control.is_mine and my_size or other_size

		-- Calculate the width and height of this aura
		local new_width = size + col_spacing
		local new_height = size + row_spacing

		-- Calculate if we need to go to start a new row
		-- row_start + width - x is the room left
		-- new_width is how much room we need
		-- We don't test for less than because they are
		-- floats and there is likely to be a certain amount
		-- of error when we do arithemtic on a float
		if (row_start + width - x - new_width) < -.0000001 then
			if x ~= row_start then
				-- Jump to the next column
				if use_new_row_height then
					y = y + new_height
				else
					y = y + row
				end
				x = sub_row_origin_x or row_start
				row = new_height
			else
				-- We were already on the first
				-- aura of the row.  So don't display
				-- anything for this aura.
				display = false
			end
		end

		-- Handle size changes
		if prev_width and new_width ~= prev_width then
			-- configured to start a new row on size change
			if new_row_size and x ~= row_start then
				-- Not already at the start of a row so start a new one
			  if use_new_row_height then
				  y = y + new_height
			  else
				  y = y + row
			  end
			  row = new_height
				if use_alt_row_start then
					row_start = row_start + (new_width - prev_width)
				end
				x = row_start
			else
				-- Handle making the auras align properly when
				-- a size change happens and the anchor would
				-- normally leave a gap.
				if use_alt_row_start then
					local offset = new_width - prev_width
					row_start = row_start + offset
					x = x + offset
				end

				-- When moving from a shorter aura to a taller one sometimes we
				-- need to shift the y up to leave room when the anchors are ahead
				-- of the auras.
				if new_height > prev_height and use_new_row_height and x~= row_start then
					y = y + (new_height - prev_height)
				end

				-- Start sub row processing
				if sorted and x ~= row_start then
					if row < new_height then
						row = new_height
					end
					sub_row_origin_x = x
					sub_row_origin_y = y
					if use_new_row_height then
						origin_row_end = y
						y = y - (row - new_height)
					else
						origin_row_end = row + y
					end
					row = new_height
				end
			end
		end


		if origin_row_end then
			-- Subrow Processing - Look for the end
			local sub_row_end
			if use_new_row_height then
				sub_row_end = y
			else
				sub_row_end = y + new_height
			end
			if origin_row_end - sub_row_end < -.0000001 then
				-- Subrow no longer fits so resume normal layout
				x = row_start
				if use_new_row_height then
					y = origin_row_end + new_height
				else
					y = origin_row_end
				end
				sub_row_origin_x = nil
				sub_row_origin_y = nil
				origin_row_end = nil
			end
		end

		if display then
			control:SetWidth(size)
			control:SetHeight(size)

			control:ClearAllPoints()
			set_point(control, point, frame, anchor, x, y, offset_x, offset_y)

			control:Show()

			-- spacing for the next aura
			x = x + new_width

			-- Save the last width
			prev_width = new_width
			prev_height = new_height

			-- Set the row height
			if row < new_height then
				row = new_height
			end
		else
			control:Hide()
		end
	end
end

function PitBull4_Aura:LayoutAuras(frame)
	local db = self:GetLayoutDB(frame)

	layout_auras(frame, db, true)
	layout_auras(frame, db, false)
end
