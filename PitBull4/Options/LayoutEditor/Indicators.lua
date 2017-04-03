local _G = _G
local PitBull4 = _G.PitBull4
local L = PitBull4.L

local root_locations = {
	out_top_left = ("%s, %s"):format(L["Outside"], L["Above-left"]),
	out_top = ("%s, %s"):format(L["Outside"], L["Above"]),
	out_top_right = ("%s, %s"):format(L["Outside"], L["Above-right"]),
	out_bottom_left = ("%s, %s"):format(L["Outside"], L["Below-left"]),
	out_bottom = ("%s, %s"):format(L["Outside"], L["Below"]),
	out_bottom_right = ("%s, %s"):format(L["Outside"], L["Below-right"]),
	out_left_top = ("%s, %s"):format(L["Outside"], L["Left-top"]),
	out_left = ("%s, %s"):format(L["Outside"], L["Left"]),
	out_left_bottom = ("%s, %s"):format(L["Outside"], L["Left-bottom"]),
	out_right_top = ("%s, %s"):format(L["Outside"], L["Right-top"]),
	out_right = ("%s, %s"):format(L["Outside"], L["Right"]),
	out_right_bottom = ("%s, %s"):format(L["Outside"], L["Right-bottom"]),
	
	in_center = ("%s, %s"):format(L["Inside"], L["Middle"]),
	in_top_left = ("%s, %s"):format(L["Inside"], L["Top-left"]),
	in_top = ("%s, %s"):format(L["Inside"], L["Top"]),
	in_top_right = ("%s, %s"):format(L["Inside"], L["Top-right"]),
	in_bottom_left = ("%s, %s"):format(L["Inside"], L["Bottom-left"]),
	in_bottom = ("%s, %s"):format(L["Inside"], L["Bottom"]),
	in_bottom_right = ("%s, %s"):format(L["Inside"], L["Bottom-right"]),
	in_left = ("%s, %s"):format(L["Inside"], L["Left"]),
	in_right = ("%s, %s"):format(L["Inside"], L["Right"]),
	
	edge_top_left = ("%s, %s"):format(L["Edge"], L["Top-left"]),
	edge_top = ("%s, %s"):format(L["Edge"], L["Top"]),
	edge_top_right = ("%s, %s"):format(L["Edge"], L["Top-right"]),
	edge_left = ("%s, %s"):format(L["Edge"], L["Left"]),
	edge_right = ("%s, %s"):format(L["Edge"], L["Right"]),
	edge_bottom_left = ("%s, %s"):format(L["Edge"], L["Bottom-left"]),
	edge_bottom = ("%s, %s"):format(L["Edge"], L["Bottom"]),
	edge_bottom_right = ("%s, %s"):format(L["Edge"], L["Bottom-right"]),
}
PitBull4.Options.root_locations = root_locations

local horizontal_bar_locations = {
	out_left = ("%s, %s"):format(L["Outside"], L["Left"]),
	left = L["Left"],
	center = L["Middle"],
	right = L["Right"],
	out_right = ("%s, %s"):format(L["Outside"], L["Right"]),
}
PitBull4.Options.horizontal_bar_locations = horizontal_bar_locations

local vertical_bar_locations = {
	out_top = ("%s, %s"):format(L["Outside"], L["Left"]),
	top = L["Top"],
	center = L["Middle"],
	bottom = L["Bottom"],
	out_bottom = ("%s, %s"):format(L["Outside"], L["Bottom"]),
}
PitBull4.Options.vertical_bar_locations = vertical_bar_locations

local indicator_locations = {
	left = L["Left"],
	center = L["Middle"],
	right = L["Right"],
	top = L["Top"],
	bottom = L["Bottom"],
	top_left = L["Top-left"],
	top_right = L["Top-right"],
	bottom_left = L["Bottom-left"],
	bottom_right = L["Bottom-right"],
}
PitBull4.Options.indicator_locations = indicator_locations

function PitBull4.Options.get_layout_editor_indicator_options()
	local GetLayoutDB = PitBull4.Options.GetLayoutDB
	local UpdateFrames = PitBull4.Options.UpdateFrames
	
	local LibSharedMedia = LibStub("LibSharedMedia-3.0", true)
	LoadAddOn("AceGUI-3.0-SharedMediaWidgets")
	local AceGUI = LibStub("AceGUI-3.0")
	
	local options = {
		name = L["Indicators"],
		desc = L["Indicators are icons or other graphical displays that convey a specific, usually temporary, status."],
		type = 'group',
		childGroups = "tab",
		args = {}
	}
	
	options.args.general = {
		type = 'group',
		name = L["General"],
		desc = L["Options that apply to all indicators."],
		order = 1,
		args = {},
	}
	
	local general_args = options.args.general.args
	
	general_args.spacing = {
		type = 'range',
		name = L["Spacing"],
		desc = L["Spacing between adjacent indicators."],
		min = 1,
		max = 20,
		step = 1,
		order = 1,
		get = function(info)
			return GetLayoutDB(false).indicator_spacing
		end,
		set = function(info, value)
			GetLayoutDB(false).indicator_spacing = value
			
			UpdateFrames()
		end,
	}
	
	general_args.size = {
		type = 'range',
		name = L["Size"],
		desc = L["Unscaled size of indicators."],
		min = 5,
		max = 50,
		step = 1,
		bigStep = 5,
		order = 2,
		get = function(info)
			return GetLayoutDB(false).indicator_size
		end,
		set = function(info, value)
			GetLayoutDB(false).indicator_size = value
			
			UpdateFrames()
		end,
	}
	
	general_args.bar = {
		type = 'group',
		name = L["Bar relation"],
		inline = true,
		order = 3,
		args = {}
	}
	
	general_args.bar.args.inside_horizontal_padding = {
		type = 'range',
		name = L["Inside horizontal padding"],
		desc = L["How far in pixels that indicators are horizontally placed inside bars."],
		min = 0,
		max = 20,
		step = 1,
		order = 1,
		get = function(info)
			return GetLayoutDB(false).indicator_bar_inside_horizontal_padding
		end,
		set = function(info, value)
			GetLayoutDB(false).indicator_bar_inside_horizontal_padding = value
			
			UpdateFrames()
		end,
	}
	
	general_args.bar.args.inside_vertical_padding = {
		type = 'range',
		name = L["Inside vertical padding"],
		desc = L["How far in pixels that indicators are vertically placed inside bars."],
		min = 0,
		max = 20,
		step = 1,
		order = 2,
		get = function(info)
			return GetLayoutDB(false).indicator_bar_inside_vertical_padding
		end,
		set = function(info, value)
			GetLayoutDB(false).indicator_bar_inside_vertical_padding = value
			
			UpdateFrames()
		end,
		hidden = true,
	}
	
	general_args.bar.args.outside_margin = {
		type = 'range',
		name = L["Outside margin"],
		desc = L["How far in pixels that indicators are placed outside of bars."],
		min = 0,
		max = 20,
		step = 1,
		order = 3,
		get = function(info)
			return GetLayoutDB(false).indicator_bar_outside_margin
		end,
		set = function(info, value)
			GetLayoutDB(false).indicator_bar_outside_margin = value
			
			UpdateFrames()
		end,
	}
	
	general_args.root = {
		type = 'group',
		name = L["Frame relation"],
		inline = true,
		order = 4,
		args = {}
	}
	
	general_args.root.args.root_inside_horizontal_padding = {
		type = 'range',
		name = L["Inside horizontal padding"],
		desc = L["How far in pixels that indicators are horizontally placed inside the unit frame."],
		min = 0,
		max = 20,
		step = 1,
		order = 1,
		get = function(info)
			return GetLayoutDB(false).indicator_root_inside_horizontal_padding
		end,
		set = function(info, value)
			GetLayoutDB(false).indicator_root_inside_horizontal_padding = value
			
			UpdateFrames()
		end,
	}
	
	general_args.root.args.root_inside_vertical_padding = {
		type = 'range',
		name = L["Inside vertical padding"],
		desc = L["How far in pixels that indicators are vertically placed inside the unit frame."],
		min = 0,
		max = 20,
		step = 1,
		order = 2,
		get = function(info)
			return GetLayoutDB(false).indicator_root_inside_vertical_padding
		end,
		set = function(info, value)
			GetLayoutDB(false).indicator_root_inside_vertical_padding = value
			
			UpdateFrames()
		end,
	}
	
	general_args.root.args.root_outside_margin = {
		type = 'range',
		name = L["Outside margin"],
		desc = L["How far in pixels that indicators are placed outside the unit frame."],
		min = 0,
		max = 20,
		step = 1,
		order = 3,
		get = function(info)
			return GetLayoutDB(false).indicator_root_outside_margin
		end,
		set = function(info, value)
			GetLayoutDB(false).indicator_root_outside_margin = value
			
			UpdateFrames()
		end,
	}
	
	local indicator_args = {}
	
	indicator_args.enable = {
		type = 'toggle',
		name = L["Enable"],
		desc = L["Enable this indicator."],
		order = 1,
		get = function(info)
			return GetLayoutDB(info[#info-1]).enabled
		end,
		set = function(info, value)
			GetLayoutDB(info[#info-1]).enabled = value
			
			UpdateFrames()
		end
	}
	
	local function disabled(info)
		return not GetLayoutDB(info[#info-1]).enabled
	end
	
	indicator_args.act_as_bar = {
		type = 'toggle',
		name = L["Position as bar"],
		desc = L["Whether to position as a bar rather than a floating indicator."],
		order = 1.5,
		get = function(info)
			return not not GetLayoutDB(info[#info-1]).side
		end,
		set = function(info, value)
			GetLayoutDB(info[#info-1]).side = value and "left" or false
			
			UpdateFrames()
		end,
		disabled = disabled,
	}
	
	local side_values = {
		left = L["Left"],
		right = L["Right"],
	}
	
	local side_values_with_center = {
		left = L["Left"],
		center = L["Center"],
		right = L["Right"],
	}
	
	indicator_args.side = {
		type = 'select',
		name = L["Side"],
		desc = L["Which side of the unit frame to place the indicator on."],
		order = 2,
		values = function(info)
			if PitBull4.modules[info[#info-1]].can_set_side_to_center then
				return side_values_with_center
			else
				return side_values
			end
		end,
		get = function(info)
			return GetLayoutDB(info[#info-1]).side
		end,
		set = function(info, value)
			GetLayoutDB(info[#info-1]).side = value
			
			UpdateFrames()
		end,
		disabled = disabled,
		hidden = function(info)
			return not GetLayoutDB(info[#info-1]).side
		end,
	}
	
	indicator_args.bar_size = {
		type = 'range',
		name = L["Height"],
		desc = L["How tall the indicator should be in relation to other bars."],
		order = 5,
		get = function(info)
			return GetLayoutDB(info[#info-1]).bar_size
		end,
		set = function(info, value)
			GetLayoutDB(info[#info-1]).bar_size = value

			UpdateFrames()
		end,
		min = 1,
		max = 12,
		step = 1,
		disabled = disabled,
		hidden = function(info)
			return GetLayoutDB(info[#info-1]).side ~= "center"
		end,
	}
	
	indicator_args.attach_to = {
		type = 'select',
		name = L["Attach to"],
		desc = L["Which control to attach to."],
		order = 2,
		get = function(info)
			return GetLayoutDB(info[#info-1]).attach_to
		end,
		set = function(info, value)
			GetLayoutDB(info[#info-1]).attach_to = value
			
			UpdateFrames()
		end,
		values = function(info)
			local t = {}
			
			t["root"] = L["Unit frame"]
			
			for id, module in PitBull4:IterateModulesOfType("bar", "indicator") do
				local db = GetLayoutDB(module)
				if db.enabled and db.side then
					t[id] = module.name
				end
			end
			
			for id, module in PitBull4:IterateModulesOfType("bar_provider") do
				local db = GetLayoutDB(module)
				if db.enabled then
					for name in pairs(db.elements) do
						t[id .. ";" .. name] = ("%s: %s"):format(module.name, name)
					end
				end
			end
			
			return t
		end,
		disabled = disabled,
		hidden = function(info)
			return GetLayoutDB(info[#info-1]).side
		end,
	}
	
	indicator_args.location = {
		type = 'select',
		name = L["Location"],
		desc = L["Where on the control to place the indicator."],
		order = 3,
		get = function(info)
			return GetLayoutDB(info[#info-1]).location
		end,
		set = function(info, value)
			GetLayoutDB(info[#info-1]).location = value
			
			UpdateFrames()
		end,
		values = function(info)
			local attach_to = GetLayoutDB(info[#info-1]).attach_to
			if attach_to == "root" then
				return root_locations
			else
				local element_id
				attach_to, element_id = (";"):split(attach_to, 2)
				local module = PitBull4.modules[attach_to]
				if module then
					if module.module_type == "indicator" then
						return indicator_locations
					end
					
					local db = GetLayoutDB(module)
					if element_id then
						db = rawget(db.elements, element_id)
					end
					local side = db and db.side
					if not side or side == "center" then
						return horizontal_bar_locations
					else
						return vertical_bar_locations
					end
				end
				return horizontal_bar_locations
			end
		end,
		disabled = disabled,
		hidden = function(info)
			return GetLayoutDB(info[#info-1]).side
		end,
	}
	
	indicator_args.bar_position = {
		type = 'select',
		name = L["Position"],
		desc = L["Where to place the indicator in relation to other indicators on the frame."],
		order = 4,
		values = function(info)
			local db = GetLayoutDB(info[#info-1])
			local side = db.side
			local t = {}
			local sort = {}
			for other_id, other_module in PitBull4:IterateModulesOfType("bar", "indicator") do
				local other_db = GetLayoutDB(other_id)
				if side == other_db.side and other_db.enabled then
					local position = other_db.position
					while t[position] do
						position = position + 1e-5
						other_db.position = position
					end
					t[position] = other_module.name
					sort[#sort+1] = position
				end
			end
			for other_id, other_module in PitBull4:IterateModulesOfType("bar_provider") do
				local other_db = GetLayoutDB(other_id)
				if other_db.enabled then
					for name, bar_db in pairs(other_db.elements) do
						if side == bar_db.side then
							local position = bar_db.position
							while t[position] do
								position = position + 1e-5
								bar_db.position = position
							end
							t[position] = ("%s: %s"):format(other_module.name, name)
							sort[#sort+1] = position
						end
					end
				end
			end
			table.sort(sort)
			local sort_reverse = {}
			for k, v in pairs(sort) do
				sort_reverse[v] = k
			end
			for position, name in pairs(t) do
				t[position] = ("%d. %s"):format(sort_reverse[position], name)
			end
			return t
		end,
		get = function(info)
			return GetLayoutDB(info[#info-1]).position
		end,
		set = function(info, new_position)
			local id = info[#info-1]
			local db = GetLayoutDB(id)
			
			local id_to_position = {}
			local bars = {}
			
			local old_position = db.position
			
			for other_id, other_module in PitBull4:IterateModulesOfType("bar", "indicator", true) do
				local other_db = GetLayoutDB(other_id)
				if other_db.side then
					id_to_position[other_id] = other_db.position
					bars[#bars+1] = other_id
				end
			end
			
			for other_id, other_module in PitBull4:IterateModulesOfType("bar_provider", true) do
				for name, bar_db in pairs(GetLayoutDB(other_id).elements) do
					local joined_id = other_id .. ";" .. name
					id_to_position[joined_id] = bar_db.position
					bars[#bars+1] = joined_id
				end
			end
			
			for bar_id, other_position in pairs(id_to_position) do
				if bar_id == id then
					id_to_position[bar_id] = new_position
				elseif other_position >= old_position and other_position <= new_position then
					id_to_position[bar_id] = other_position - 1
				elseif other_position <= old_position and other_position >= new_position then
					id_to_position[bar_id] = other_position + 1
				end
			end
			
			table.sort(bars, function(alpha, bravo)
				return id_to_position[alpha] < id_to_position[bravo]
			end)
			
			for position, bar_id in ipairs(bars) do
				if bar_id:match(";") then
					local module_id, name = (";"):split(bar_id, 2)
					local bar_db = rawget(GetLayoutDB(module_id).elements, name)
					if bar_db then
						bar_db.position = position
					end
				else
					GetLayoutDB(bar_id).position = position
				end
			end
			
			UpdateFrames()
		end,
		disabled = disabled,
		hidden = function(info)
			return not GetLayoutDB(info[#info-1]).side
		end,
	}
	
	indicator_args.position = {
		type = 'select',
		name = L["Position"],
		desc = L["Where to place the indicator compared to others in the same location."],
		order = 4,
		values = function(info)
			local db = GetLayoutDB(info[#info-1])
			local attach_to = db.attach_to
			local location = db.location
			local t = {}
			local sort = {}
			for other_id, other_module in PitBull4:IterateModulesOfType("indicator", "custom_text") do
				local other_db = GetLayoutDB(other_id)
				if attach_to == other_db.attach_to and location == other_db.location and not other_db.side then
					local position = other_db.position
					while t[position] do
						position = position + 1e-5
						other_db.position = position
					end
					t[position] = other_module.name
					sort[#sort+1] = position
				end
			end
			for other_id, other_module in PitBull4:IterateModulesOfType("text_provider") do
				for element_id, element_db in pairs(GetLayoutDB(other_id).elements) do
					if attach_to == element_db.attach_to and location == element_db.location then
						local position = element_db.position
						while t[position] do
							position = position + 1e-5
							element_db.position = position
						end
						t[position] = element_id
						sort[#sort+1] = position
					end
				end
			end
			table.sort(sort)
			local sort_reverse = {}
			for k, v in pairs(sort) do
				sort_reverse[v] = k
			end
			for position, name in pairs(t) do
				t[position] = ("%d. %s"):format(sort_reverse[position], name)
			end
			return t
		end,
		get = function(info)
			return GetLayoutDB(info[#info-1]).position
		end,
		set = function(info, new_position)
			local id = info[#info-1]
			local db = GetLayoutDB(id)
			
			local id_to_position = {}
			local elements = {}
			
			local old_position = db.position
			
			for other_id, other_module in PitBull4:IterateModulesOfType("indicator", "custom_text", true) do
				local other_db = GetLayoutDB(other_id)
				if not other_db.side then
					id_to_position[other_id] = GetLayoutDB(other_id).position
					elements[#elements+1] = other_id
				end
			end
			
			for other_id, other_module in PitBull4:IterateModulesOfType("text_provider", true) do
				for element_id, element_db in pairs(GetLayoutDB(other_id).elements) do
					local joined_id = other_id .. ";" .. element_id
					id_to_position[joined_id] = element_db.position
					elements[#elements+1] = joined_id
				end
			end
			
			for element_id, other_position in pairs(id_to_position) do
				if element_id == id then
					id_to_position[element_id] = new_position
				elseif other_position >= old_position and other_position <= new_position then
					id_to_position[element_id] = other_position - 1
				elseif other_position <= old_position and other_position >= new_position then
					id_to_position[element_id] = other_position + 1
				end
			end
			
			table.sort(elements, function(alpha, bravo)
				return id_to_position[alpha] < id_to_position[bravo]
			end)
			
			for position, element_id in ipairs(elements) do
				if element_id:match(";") then
					local module_id, name = (";"):split(element_id, 2)
					local element_db = rawget(GetLayoutDB(module_id).elements, name)
					if element_db then
						element_db.position = position
					end
				else
					GetLayoutDB(element_id).position = position
				end
			end
			
			UpdateFrames()
		end,
		disabled = disabled,
		hidden = function(info)
			return GetLayoutDB(info[#info-1]).side
		end,
	}
	
	indicator_args.size = {
		type = 'range',
		name = L["Size"],
		desc = L["Size of the indicator."],
		order = 5,
		get = function(info)
			return GetLayoutDB(info[#info-1]).size
		end,
		set = function(info, value)
			GetLayoutDB(info[#info-1]).size = value
			
			UpdateFrames()
		end,
		min = 0.5,
		max = 4,
		step = 0.01,
		bigStep = 0.05,
		isPercent = true,
		disabled = disabled,
		hidden = function(info)
			return GetLayoutDB(info[#info-1]).side
		end,
	}
	
	indicator_args.text_font = {
		type = 'select',
		name = L["Font"],
		desc = L["Which font to use for this indicator."] .. "\n" .. L["If you want more fonts, you should install the addon 'SharedMedia'."],
		order = 6,
		get = function(info)
			return GetLayoutDB(info[#info-1]).text_font or GetLayoutDB(false).font
		end,
		set = function(info, value)
			local default = GetLayoutDB(false).font
			if value == default then
				value = nil
			end
			
			GetLayoutDB(info[#info-1]).text_font = value
			
			UpdateFrames()
		end,
		values = function(info)
			local t = {}
			local default = GetLayoutDB(false).font
			for k in pairs(LibSharedMedia:HashTable("font")) do
				if k == default then
					t[k] = ("%s (Default)"):format(k)
				else
					t[k] = k
				end
			end
			return t
		end,
		disabled = disabled,
		hidden = function(info)
			local module = PitBull4.modules[info[#info-1]]
			return not module.show_font_option or not LibSharedMedia
		end,
		dialogControl = AceGUI.WidgetRegistry["LSM30_Font"] and "LSM30_Font" or nil,
	}
	
	indicator_args.text_size = {
		type = 'range',
		name = L["Font size"],
		desc = L["Font size to use on this indicator."],
		order = 7,
		get = function(info)
			return GetLayoutDB(info[#info-1]).text_size
		end,
		set = function(info, value)
			GetLayoutDB(info[#info-1]).text_size = value
			
			UpdateFrames()
		end,
		min = 0.5,
		max = 3,
		step = 0.01,
		bigStep = 0.05,
		isPercent = true,
		disabled = disabled,
		hidden = function(info)
			local module = PitBull4.modules[info[#info-1]]
			return not module.show_font_size_option
		end,
	}
	
	local layout_functions = PitBull4.Options.layout_functions
	
	function PitBull4.Options.layout_editor_indicator_handle_module_load(module)
		local id = module.id
		local args = {}
		for k, v in pairs(indicator_args) do
			args[k] = v
		end
		if layout_functions[module] then
			local data = { layout_functions[module](module) }
			for i = 1, #data, 2 do
				local k, v = data[i], data[i+1]

				if v then
					if not v.order then
						v.order = 100 + i
					end

					local v_disabled = v.disabled
					function v.disabled(info)
						return disabled(info) or (v_disabled and v_disabled(info))
					end
				end
				args[k] = v
			end
			layout_functions[module] = false
		end

		options.args[id] = {
			name = module.name,
			desc = module.description,
			type = 'group',
			args = args,
			hidden = function(info)
				return not module:IsEnabled()
			end,
		}
	end
	for id, module in PitBull4:IterateModulesOfType("indicator", true) do
		PitBull4.Options.layout_editor_indicator_handle_module_load(module)
	end
	
	return options
end
