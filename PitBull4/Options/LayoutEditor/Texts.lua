local _G = _G
local PitBull4 = _G.PitBull4
local L = PitBull4.L

local CURRENT_CUSTOM_TEXT_MODULE
local CURRENT_TEXT_PROVIDER_MODULE
local CURRENT_TEXT_PROVIDER_ID

--- Return the DB dictionary for the current text for the current layout selected in the options frame.
-- TextProvider modules should be calling this and manipulating data within it.
-- @usage local db = PitBull.Options.GetTextLayoutDB(); db.some_option = "something"
-- @return the DB dictionary for the current text
function PitBull4.Options.GetTextLayoutDB()
	if not CURRENT_TEXT_PROVIDER_MODULE then
		return
	end
	
	return PitBull4.Options.GetLayoutDB(CURRENT_TEXT_PROVIDER_MODULE).elements[CURRENT_TEXT_PROVIDER_ID]
end

function PitBull4.Options.get_layout_editor_text_options()
	local GetLayoutDB = PitBull4.Options.GetLayoutDB
	local GetTextLayoutDB = PitBull4.Options.GetTextLayoutDB
	local UpdateFrames = PitBull4.Options.UpdateFrames
	
	local LibSharedMedia = LibStub("LibSharedMedia-3.0", true)
	LoadAddOn("AceGUI-3.0-SharedMediaWidgets")
	local AceGUI = LibStub("AceGUI-3.0")
	
	local options = {
		name = L["Texts"],
		desc = L["Texts convey information in a non-graphical manner."],
		type = 'group',
		args = {}
	}
	
	local root_locations = PitBull4.Options.root_locations
	local horizontal_bar_locations = PitBull4.Options.horizontal_bar_locations
	local vertical_bar_locations = PitBull4.Options.vertical_bar_locations
	local indicator_locations = PitBull4.Options.indicator_locations
	
	local function disabled()
		if CURRENT_CUSTOM_TEXT_MODULE then
			return not GetLayoutDB(CURRENT_CUSTOM_TEXT_MODULE).enabled
		elseif not CURRENT_TEXT_PROVIDER_MODULE then
			return true 
		end
		return not GetTextLayoutDB().enabled
	end
	
	options.args.current_text = {
		name = L["Current text"],
		desc = L["Change the current text that you are editing."],
		type = 'select',
		order = 1,
		values = function(info)
			local t = {}
			local first, first_module, first_id
			for id, module in PitBull4:IterateModulesOfType("text_provider") do
				local texts_db = GetLayoutDB(module).elements
				for name, text_db in pairs(texts_db) do
					local key = id .. ";" .. name
					t[key] = name
				end
			end
			for id, module in PitBull4:IterateModulesOfType("custom_text") do
				t[id] = module.name
				if not first_module then
					first_module = module
					first_id = nil
				end
			end
			if (not CURRENT_TEXT_PROVIDER_MODULE or not t[CURRENT_TEXT_PROVIDER_MODULE.id .. ";" .. CURRENT_TEXT_PROVIDER_ID]) and (not CURRENT_CUSTOM_TEXT_MODULE or not t[CURRENT_CUSTOM_TEXT_MODULE.id]) then
				if first_id then
					CURRENT_TEXT_PROVIDER_MODULE = first_module
					CURRENT_TEXT_PROVIDER_ID = first_id
					CURRENT_CUSTOM_TEXT_MODULE = nil
				else
					CURRENT_TEXT_PROVIDER_MODULE = nil
					CURRENT_TEXT_PROVIDER_ID = nil
					CURRENT_CUSTOM_TEXT_MODULE = first_module
				end
			end
			return t
		end,
		get = function(info)
			if CURRENT_TEXT_PROVIDER_MODULE then
				return CURRENT_TEXT_PROVIDER_MODULE.id .. ";" .. CURRENT_TEXT_PROVIDER_ID
			elseif CURRENT_CUSTOM_TEXT_MODULE then
				return CURRENT_CUSTOM_TEXT_MODULE.id
			else
				return nil
			end
		end,
		set = function(info, value)
			local module_name, id = (";"):split(value, 2)
			if id then
				for m_id, m in PitBull4:IterateModulesOfType("text_provider") do
					if module_name == m_id then
						CURRENT_TEXT_PROVIDER_MODULE = m
						CURRENT_TEXT_PROVIDER_ID = id
						CURRENT_CUSTOM_TEXT_MODULE = nil
						break
					end
				end
			else
				for m_id, m in PitBull4:IterateModulesOfType("custom_text") do
					if module_name == m_id then
						CURRENT_TEXT_PROVIDER_MODULE = nil
						CURRENT_TEXT_PROVIDER_ID = nil
						CURRENT_CUSTOM_TEXT_MODULE = m
						break
					end
				end
			end
		end,
	}
	
	local function text_name_validate(info, value)
		if value:len() < 3 then
			return L["Must be at least 3 characters long."]
		end
		
		for id, module in PitBull4:IterateModulesOfType("text_provider") do
			local texts_db = GetLayoutDB(module).elements
			
			for name in pairs(texts_db) do
				if value:lower() == name:lower() then
					return L["'%s' is already a text."]:format(value)
				end
			end
		end
		
		for id, module in PitBull4:IterateModulesOfType("text_provider") do
			return true -- found a module
		end
		return L["You have no enabled text providers."]
	end
	
	options.args.new_text = {
		name = L["New text"],
		desc = L["This will make a new text for the layout."],
		type = 'input',
		order = 2,
		get = function(info) return "" end,
		set = function(info, value)
			local module = CURRENT_TEXT_PROVIDER_MODULE
			
			if not module then
				for id, m in PitBull4:IterateModulesOfType("text_provider") do
					module = m
					break
				end
				
				assert(module) -- the validate function should verify that at least one module exists
			end
			
			local texts_db = GetLayoutDB(module).elements
			local db = texts_db[value]
			db.exists = true
			
			CURRENT_CUSTOM_TEXT_MODULE = nil
			CURRENT_TEXT_PROVIDER_MODULE = module
			CURRENT_TEXT_PROVIDER_ID = value
			
			UpdateFrames()
		end,
		validate = text_name_validate,
	}
	
	options.args.font = {
		type = 'select',
		name = L["Default font"],
		desc = L["The font of texts, unless overridden."] .. "\n" .. L["If you want more fonts, you should install the addon 'SharedMedia'."],
		order = 3,
		get = function(info)
			return GetLayoutDB(false).font
		end,
		set = function(info, value)
			GetLayoutDB(false).font = value

			UpdateFrames()
		end,
		values = function(info)
			local t = {}
			for k in pairs(LibSharedMedia:HashTable("font")) do
				t[k] = k
			end
			return t
		end,
		hidden = function(info)
			return not LibSharedMedia
		end,
		dialogControl = AceGUI.WidgetRegistry["LSM30_Font"] and "LSM30_Font" or nil,
	}
	
	options.args.font_size = {
		type = 'range',
		name = L["Default size"],
		desc = L["Default size of the text, acts as a multiplier to all other texts."],
		order = 4,
		get = function(info)
			return GetLayoutDB(false).font_size
		end,
		set = function(info, value)
			GetLayoutDB(false).font_size = value
			
			UpdateFrames()
		end,
		min = 0.5,
		max = 3,
		step = 0.01,
		bigStep = 0.05,
		isPercent = true,
	}
	
	options.args.edit = {
		type = 'group',
		name = L["Edit text"],
		inline = true,
		args = {},
	}
	
	options.args.edit.args.remove = {
		type = 'execute',
		name = L["Remove"],
		desc = L["Remove this text."],
		confirm = true,
		confirmText = L["Are you sure you want to remove this text?"],
		order = 1,
		func = function()
			local texts_db = GetLayoutDB(CURRENT_TEXT_PROVIDER_MODULE).elements
			
			texts_db[CURRENT_TEXT_PROVIDER_ID] = nil
			
			CURRENT_TEXT_PROVIDER_ID = next(texts_db)
			
			if not CURRENT_TEXT_PROVIDER_ID then
				CURRENT_TEXT_PROVIDER_MODULE = nil
				CURRENT_TEXT_PROVIDER_ID = nil
				for id, module in PitBull4:IterateModulesOfType("text_provider") do
					local texts_db = GetLayoutDB(module).elements
					
					CURRENT_TEXT_PROVIDER_ID = next(texts_db)
					if CURRENT_TEXT_PROVIDER_ID then
						CURRENT_TEXT_PROVIDER_MODULE = module
						break
					end
				end
				
				if not CURRENT_TEXT_PROVIDER_ID then
					for id, module in PitBull4:IterateModulesOfType("custom_text") do
						CURRENT_CUSTOM_TEXT_MODULE = module
						break
					end
				end
			end
			
			UpdateFrames()
		end,
		disabled = disabled,
		hidden = function(info)
			return not not CURRENT_CUSTOM_TEXT_MODULE
		end
	}
	
	options.args.edit.args.enabled = {
		type = 'toggle',
		name = L["Enable"],
		desc = L["Enable this text."],
		order = 1,
		get = function(info)
			if CURRENT_CUSTOM_TEXT_MODULE then
				return GetLayoutDB(CURRENT_CUSTOM_TEXT_MODULE).enabled
			end
			if not CURRENT_TEXT_PROVIDER_MODULE then
				return nil 
			end
			return GetTextLayoutDB().enabled
		end,
		set = function(info, value)
			if CURRENT_CUSTOM_TEXT_MODULE then
				GetLayoutDB(CURRENT_CUSTOM_TEXT_MODULE).enabled = value
			else
				GetTextLayoutDB().enabled = value
			end
			
			UpdateFrames()
		end,
	}
	
	options.args.edit.args.name = {
		type = 'input',
		name = L["Name"],
		order = 2,
		desc = function(info)
			return L["Rename the '%s' text."]:format(CURRENT_TEXT_PROVIDER_ID or L["<Unnamed>"])
		end,
		get = function(info)
			return CURRENT_TEXT_PROVIDER_ID or L["<Unnamed>"]
		end,
		set = function(info, value)
			local texts_db = GetLayoutDB(CURRENT_TEXT_PROVIDER_MODULE).elements
			local text_db = texts_db[CURRENT_TEXT_PROVIDER_ID]
			texts_db[CURRENT_TEXT_PROVIDER_ID] = nil
			CURRENT_TEXT_PROVIDER_ID = value
			texts_db[CURRENT_TEXT_PROVIDER_ID] = text_db
			
			UpdateFrames()
		end,
		validate = text_name_validate,
		disabled = disabled,
		hidden = function(info)
			return not not CURRENT_CUSTOM_TEXT_MODULE
		end
	}
	
	options.args.edit.args.provider = {
		type = 'select',
		name = L["Type"],
		desc = L["What text provider is used for this text."],
		order = 3,
		get = function(info)
			return CURRENT_TEXT_PROVIDER_MODULE and CURRENT_TEXT_PROVIDER_MODULE.id
		end,
		set = function(info, value)
			if value == CURRENT_TEXT_PROVIDER_MODULE.id then
				return
			end
			
			local texts_db = GetLayoutDB(CURRENT_TEXT_PROVIDER_MODULE).elements
			
			local old_db = texts_db[CURRENT_TEXT_PROVIDER_ID]
			texts_db[CURRENT_TEXT_PROVIDER_ID] = nil
			
			CURRENT_TEXT_PROVIDER_MODULE = PitBull4:GetModule(value)
			texts_db = GetLayoutDB(CURRENT_TEXT_PROVIDER_MODULE).elements
			
			local new_db = texts_db[CURRENT_TEXT_PROVIDER_ID]
			new_db.size = old_db.size
			new_db.attach_to = old_db.attach_to
			new_db.location = old_db.location
			new_db.position = old_db.position
			new_db.exists = true
			
			UpdateFrames()
		end,
		values = function(info)
			local t = {}
			for id, m in PitBull4:IterateModulesOfType("text_provider") do
				t[id] = m.name
			end
			return t
		end,
		disabled = disabled,
		hidden = function(info)
			return not not CURRENT_CUSTOM_TEXT_MODULE
		end
	}

	local function get_location_list()
		local attach_to
		if CURRENT_CUSTOM_TEXT_MODULE then
			attach_to = GetLayoutDB(CURRENT_CUSTOM_TEXT_MODULE).attach_to
		elseif CURRENT_TEXT_PROVIDER_MODULE then
			attach_to = GetTextLayoutDB().attach_to
		else
			attach_to = "root"
		end
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
	end
	
	options.args.edit.args.attach_to = {
		type = 'select',
		name = L["Attach to"],
		desc = L["Which control to attach to."],
		order = 4,
		get = function(info)
			if CURRENT_CUSTOM_TEXT_MODULE then
				return GetLayoutDB(CURRENT_CUSTOM_TEXT_MODULE).attach_to
			end
			if not CURRENT_TEXT_PROVIDER_MODULE then
				return
			end
			return GetTextLayoutDB().attach_to
		end,
		set = function(info, value)
			local db
			if CURRENT_CUSTOM_TEXT_MODULE then
				db = GetLayoutDB(CURRENT_CUSTOM_TEXT_MODULE)
			else
				db = GetTextLayoutDB()
			end
			db.attach_to = value

			-- If the current location isn't valid with the new attach_to
			-- update it to one that is.
			local locations = get_location_list()
			if not locations[db.location] then
				db.location = next(locations)
			end

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
	}
	
	options.args.edit.args.location = {
		type = 'select',
		name = L["Location"],
		desc = L["Where on the control to place the text."],
		order = 5,
		get = function(info)
			if CURRENT_CUSTOM_TEXT_MODULE then
				return GetLayoutDB(CURRENT_CUSTOM_TEXT_MODULE).location
			end
			if not CURRENT_TEXT_PROVIDER_MODULE then
				return nil
			end
			return GetTextLayoutDB().location
		end,
		set = function(info, value)
			if CURRENT_CUSTOM_TEXT_MODULE then
				GetLayoutDB(CURRENT_CUSTOM_TEXT_MODULE).location = value
			else
				GetTextLayoutDB().location = value
			end
			
			UpdateFrames()
		end,
		values = get_location_list,
		disabled = disabled,
	}
	
	options.args.edit.args.position = {
		type = 'select',
		name = L["Position"],
		desc = L["Where to place the text compared to others in the same location."],
		order = 6,
		values = function(info)
			local db
			if CURRENT_CUSTOM_TEXT_MODULE then
				db = GetLayoutDB(CURRENT_CUSTOM_TEXT_MODULE)
			elseif CURRENT_TEXT_PROVIDER_MODULE then
				db = GetTextLayoutDB()
			else
				return {}
			end
			local attach_to = db.attach_to
			local location = db.location
			local t = {}
			local sort = {}
			for other_id, other_module in PitBull4:IterateModulesOfType("indicator", "custom_text") do
				local other_db = GetLayoutDB(other_id)
				if attach_to == other_db.attach_to and location == other_db.location then
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
			if CURRENT_CUSTOM_TEXT_MODULE then
				return GetLayoutDB(CURRENT_CUSTOM_TEXT_MODULE).position
			elseif CURRENT_TEXT_PROVIDER_MODULE then
				return GetTextLayoutDB().position
			end
		end,
		set = function(info, new_position)
			local db
			local id
			if CURRENT_CUSTOM_TEXT_MODULE then
				id = CURRENT_CUSTOM_TEXT_MODULE.id
				db = GetLayoutDB(CURRENT_CUSTOM_TEXT_MODULE)
			elseif CURRENT_TEXT_PROVIDER_MODULE then
				id = CURRENT_TEXT_PROVIDER_MODULE.id .. ";" .. CURRENT_TEXT_PROVIDER_ID
				db = GetTextLayoutDB()
			end
			
			local id_to_position = {}
			local elements = {}
			
			local old_position = db.position
			
			for other_id, other_module in PitBull4:IterateModulesOfType("indicator", "custom_text", true) do
				id_to_position[other_id] = GetLayoutDB(other_id).position
				elements[#elements+1] = other_id
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
	}
	
	options.args.edit.args.font = {
		type = 'select',
		name = L["Font"],
		desc = L["Which font to use for this text."] .. "\n" .. L["If you want more fonts, you should install the addon 'SharedMedia'."],
		order = 7,
		get = function(info)
			local font
			if CURRENT_CUSTOM_TEXT_MODULE then
				font = GetLayoutDB(CURRENT_CUSTOM_TEXT_MODULE).font
			elseif CURRENT_TEXT_PROVIDER_MODULE then
				font = GetTextLayoutDB().font
			end
			return font or GetLayoutDB(false).font
		end,
		set = function(info, value)
			local default = GetLayoutDB(false).font
			if value == default then
				value = nil
			end
			
			if CURRENT_CUSTOM_TEXT_MODULE then
				GetLayoutDB(CURRENT_CUSTOM_TEXT_MODULE).font = value
			else
				GetTextLayoutDB().font = value
			end
			
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
			return not LibSharedMedia
		end,
		dialogControl = AceGUI.WidgetRegistry["LSM30_Font"] and "LSM30_Font" or nil,
	}
	
	options.args.edit.args.size = {
		type = 'range',
		name = L["Size"],
		desc = L["Size of the text."],
		order = 8,
		get = function(info)
			if CURRENT_CUSTOM_TEXT_MODULE then
				return GetLayoutDB(CURRENT_CUSTOM_TEXT_MODULE).size
			end
			if not CURRENT_TEXT_PROVIDER_MODULE then
				return 1
			end
			return GetTextLayoutDB().size
		end,
		set = function(info, value)
			if CURRENT_CUSTOM_TEXT_MODULE then
				GetLayoutDB(CURRENT_CUSTOM_TEXT_MODULE).size = value
			else
				GetTextLayoutDB().size = value
			end
			
			UpdateFrames()
		end,
		min = 0.5,
		max = 3,
		step = 0.01,
		bigStep = 0.05,
		isPercent = true,
		disabled = disabled,
	}
	
	local layout_functions = PitBull4.Options.layout_functions
	
	function PitBull4.Options.layout_editor_text_provider_handle_module_load(module)
		local id = module.id
		if not layout_functions[module] then
			return
		end
		local t = { layout_functions[module](module) }
		layout_functions[module] = false
		
		for i = 1, #t, 2 do
			local k = t[i]
			local v = t[i+1]
		
			if v then
				if not v.order then
					v.order = i + 100
				end
			
				local old_disabled = v.disabled
				v.disabled = function(info)
					return disabled(info) or (old_disabled and old_disabled(info))
				end
			
				local old_hidden = v.hidden
				v.hidden = function(info)
					return module ~= CURRENT_TEXT_PROVIDER_MODULE or (old_hidden and old_hidden(info))
				end
			end
			
			options.args.edit.args[id .. "-" .. k] = v
		end
	end
	for id, module in PitBull4:IterateModulesOfType("text_provider", true) do
		PitBull4.Options.layout_editor_text_provider_handle_module_load(module)
	end
	
	function PitBull4.Options.layout_editor_custom_text_handle_module_load(module)
		local id = module.id
		if not layout_functions[module] then
			return
		end
		local t = { layout_functions[module](module) }
		layout_functions[module] = false

		local order = 100
		for i = 1, #t, 2 do
			local k = t[i]
			local v = t[i+1]

			order = order + 1

			if v then
				if not v.order then
					v.order = order
				end

				local old_disabled = v.disabled
				v.disabled = function(info)
					return disabled(info) or (old_disabled and old_disabled(info))
				end

				local old_hidden = v.hidden
				v.hidden = function(info)
					return module ~= CURRENT_CUSTOM_TEXT_MODULE or (old_hidden and old_hidden(info))
				end
			end

			options.args.edit.args[id .. "-" .. k] = v
		end
	end
	for id, module in PitBull4:IterateModulesOfType("custom_text", true) do
		PitBull4.Options.layout_editor_custom_text_handle_module_load(module)
	end
	
	return options
end
