-- FilterEditor.lua: Code to implement the Filter Editor.

if select(6, GetAddOnInfo("PitBull4_" .. (debugstack():match("[o%.][d%.][u%.]les\\(.-)\\") or ""))) ~= "MISSING" then return end

local _G = getfenv(0)
local PitBull4 = _G.PitBull4
local L = PitBull4.L
local PitBull4_Aura = PitBull4:GetModule("Aura")

-- The type of control to use for multiselect options in the Filter Editor.
-- If you're having error 132's with the filter editor commenting out the line
-- below and uncommenting the line below it will avoid them.  This appears to
-- be a bug in Blizzard's code and there's nothing I can really do to fix it.
local MULTISELECT_CONTROL = "Dropdown"
-- local MULTISELECT_CONTROL

local deep_copy = PitBull4.Utils.deep_copy

local CURRENT_FILTER
local CURRENT_FILTER_OPTIONS = {}

--- Sets the filter editor to display options for the filter
-- Useful to filter types that want to alter their options
-- @param filter the name of the filter
-- @param options the table to fill the values into
-- @usage PitBull4_Aura:SetFilterOptions("myfilter", CURRENT_FILTER_OPTIONS)
-- @return nil
function PitBull4_Aura:SetFilterOptions(filter, options)
	local filter_types = PitBull4_Aura.filter_types

	-- Get rid of any old options we had before
	table.wipe(options)

	-- Dropdown for display when
	options.display_when = {
		type = 'select',
		name = L['Display when'],
		desc = L['Set when to include this filter as an option for a layout.'],
		get = function(info)
			return PitBull4_Aura:GetFilterDB(filter).display_when or ""
		end,
		set = function(info, value)
			PitBull4_Aura:GetFilterDB(filter).display_when = value
		end,
		values = {
			[""] = L["Never"],
			["buff"] = L["Buffs"],
			["debuff"] = L["Debuffs"],
			["highlight"] = L["Highlights"],
			["both"] = L["Always"],
		},
		order = 0,
	}

	-- Create the dropdown for the filter type
	options.filter_type = {
		type = 'select',
		name = L['Filter type'],
		desc = L['Set the type of filter.'],
		get = function(info)
			return PitBull4_Aura:GetFilterDB(filter).filter_type
		end,
		set = function(info, value)
			local db = PitBull4_Aura:GetFilterDB(filter)
			db.filter_type = value
			self:SetFilterOptions(filter, options)
			PitBull4_Aura:UpdateAll()
		end,
		values = function(info)
			local t = {}
			for name, filter_type in pairs(filter_types) do
				t[name] = filter_type.display_name
			end
			return t
		end,
		confirmText = L["Are you sure you want to change the filter type of a built in filter?  Doing so may break the default filtering."],
		confirm = function(info)
			local db = PitBull4_Aura:GetFilterDB(filter)
			return db.built_in or false
		end,
		order = 1,
	}
	options.spacer = {
		type = 'header',
		name = '',
		desc = '',
		order = 2,
	}

	-- Save the existing keys
	local t = {}
	for k in pairs(options) do
		t[k] = true
	end

	-- Let the filter type fill the remaining options
	local db = PitBull4_Aura:GetFilterDB(filter)
	filter_types[db.filter_type].config(filter, options)
	for k in pairs(options) do
		if db.disabled then
			options[k].disabled = true
		end
		if not t[k] then
			-- Fix the order for keys added by the filter
			local order = options[k].order
			if order  then
				order = order + 2
				options[k].order = order
			end
		end
	end
end

local function any_layout_uses_filter(filter)
	local layouts = PitBull4.db.profile.layouts
	for layout in pairs(layouts) do
		local db = PitBull4_Aura:GetLayoutDB(layout).layout
		if db.buff.filter == filter or db.debuff.filter == filter then
			return true
		end
	end
	return false
end

local _,player_class = UnitClass('player')
local _,player_race = UnitRace('player')
local function filter_from_map(map)
	local filters = PitBull4_Aura.db.profile.global.filters
	local map_filter = filters[map]
	if not map_filter or map_filter.filter_type ~= 'Map' then return end
	if map_filter.map_type == 'class' then
		return map_filter.map[player_class]
	else
		return map_filter.map[player_race]
	end
end

local function code(s)
	s = string.gsub(s, "\\", function(x)
		return string.format("\\%03d", string.byte(x))
	end)
	return (string.gsub(s, "(%.)", function(x)
		return string.format("\\%03d", string.byte(x))
	end))
end

local function get_values_from_filter(name,t)
	if not name then return end
	local filters = PitBull4_Aura.db.profile.global.filters
	local filter = filters[name]
	if not filter or filter.filter_type ~= 'Name' then return end
	name = code(name)
	for k in pairs(filter.name_list) do
		k = code(k)
		t[name..'.'..k] = k
	end
end

local function decode(s)
	return (string.gsub(s, "\\(%d%d%d)", function(d)
		return string.char(d)
	end))
end

local function extract_filter_entry_from_key(key)
	local filter_name,entry = string.match(key,"^([^%.]+)%.(.+)$")
	return decode(filter_name),decode(entry)
end

PitBull4_Aura.OnProfileChanged_funcs[#PitBull4_Aura.OnProfileChanged_funcs+1] = 
function(self)
	-- Recalculate the filter options on a profile change
	if CURRENT_FILTER then
		self:SetFilterOptions(CURRENT_FILTER,CURRENT_FILTER_OPTIONS)
	end
end


-- Generates the options for the filter editor.
function PitBull4_Aura:GetFilterEditor()
	if not CURRENT_FILTER then
		-- No filter so setup a default
		CURRENT_FILTER = '!B'
		self:SetFilterOptions(CURRENT_FILTER,CURRENT_FILTER_OPTIONS)
	end

	return {
		simple = {
			type = 'group',
			name = L['Simple'],
			desc = L['Add or remove auras by name to the default filters easily.'],
			inline = false,
			args = {
				friend_buffs = {
					type = 'multiselect',
					dialogControl = MULTISELECT_CONTROL, 
					name = L['Friend buffs'],
					desc = L['Select buffs to show on your friends.'],
					get = function(info,key)
						local filters = PitBull4_Aura.db.profile.global.filters
						local filter_name,entry = extract_filter_entry_from_key(key)
						return filters[filter_name].name_list[entry]
					end,
					set = function(info,key,value)
						local filters = PitBull4_Aura.db.profile.global.filters
						local filter_name,entry = extract_filter_entry_from_key(key)
						filters[filter_name].name_list[entry] = value
						PitBull4_Aura:UpdateAll()
					end,
					values = function(info)
						local t = {}
						get_values_from_filter(filter_from_map('&A'),t)
						get_values_from_filter(filter_from_map('%A'),t)
						get_values_from_filter(filter_from_map('&B'),t)
						get_values_from_filter(filter_from_map('&C'),t)
						get_values_from_filter(filter_from_map('%B'),t)
						get_values_from_filter('*A',t)
						return t
					end,
					order = 1,
				},
				friend_buffs_add = {
					type = 'input',
					name = L['Add friend buff'],
					desc = L['Add a friend buff to the extra friend buff filter.'],
					get = function(info) return "" end,
					set = function(info, value)
						local name_list = PitBull4_Aura:GetFilterDB('*A').name_list
						name_list[value] = true
						PitBull4_Aura:UpdateAll()
					end,
					validate = function(info, value)
						if value:len() < 3 then
							return L["Must be at least 3 characters long."]
						end
						return true
					end,
					order = 2,
				},
				spacer1 = {
					type = 'header',
					name = '',
					desc = '',
					order = 3,
				},
				friend_debuffs = {
					type = 'multiselect',
					dialogControl = MULTISELECT_CONTROL, 
					name = L['Friend debuffs'],
					desc = L['Select debuffs to show on your friends.'],
					get = function(info,key)
						local filters = PitBull4_Aura.db.profile.global.filters
						local filter_name,entry = extract_filter_entry_from_key(key)
						return filters[filter_name].name_list[entry]
					end,
					set = function(info,key,value)
						local filters = PitBull4_Aura.db.profile.global.filters
						local filter_name,entry = extract_filter_entry_from_key(key)
						filters[filter_name].name_list[entry] = value
					end,
					values = function(info)
						local t = {}
						get_values_from_filter(filter_from_map('&E'),t)
						get_values_from_filter(filter_from_map('%C'),t)
						get_values_from_filter(filter_from_map('&F'),t)
						get_values_from_filter('*B',t)
						return t
					end,
					order = 4,
				},
				friend_debuffs_add = {
					type = 'input',
					name = L['Add friend debuff'],
					desc = L['Add a friend debuff to the extra friend debuff filter.'],
					get = function(info) return "" end,
					set = function(info, value)
						local name_list = PitBull4_Aura:GetFilterDB('*B').name_list
						name_list[value] = true
						PitBull4_Aura:UpdateAll()
					end,
					validate = function(info, value)
						if value:len() < 3 then
							return L["Must be at least 3 characters long."]
						end
						return true
					end,
					order = 5,
				},
				spacer2 = {
					type = 'header',
					name = '',
					desc = '',
					order = 6,
				},
				enemy_debuffs = {
					type = 'multiselect',
					dialogControl = MULTISELECT_CONTROL, 
					name = L['Enemy debuffs'],
					desc = L['Select debuffs to show on your enemies.'],
					get = function(info,key)
						local filters = PitBull4_Aura.db.profile.global.filters
						local filter_name,entry = extract_filter_entry_from_key(key)
						return filters[filter_name].name_list[entry]
					end,
					set = function(info,key,value)
						local filters = PitBull4_Aura.db.profile.global.filters
						local filter_name,entry = extract_filter_entry_from_key(key)
						filters[filter_name].name_list[entry] = value
					end,
					values = function(info)
						local t = {}
						get_values_from_filter(filter_from_map('&G'),t)
						get_values_from_filter(filter_from_map('%D'),t)
						get_values_from_filter('*C',t)
						return t
					end,
					order = 7,
				},
				enemy_debuffs_add = {
					type = 'input',
					name = L['Add enemy debuff'],
					desc = L['Add a enemy debuff to the extra enemy debuff filter.'],
					get = function(info) return "" end,
					set = function(info, value)
						local name_list = PitBull4_Aura:GetFilterDB('*C').name_list
						name_list[value] = true
						PitBull4_Aura:UpdateAll()
					end,
					validate = function(info, value)
						if value:len() < 3 then
							return L["Must be at least 3 characters long."]
						end
						return true
					end,
					order = 8,
				},
				spacer3 = {
					type = 'header',
					name = '',
					desc = '',
					order = 9,
				},
				friend_highlights = {
					type = 'multiselect',
					dialogControl = MULTISELECT_CONTROL, 
					name = L['Extra friend highlights'],
					desc = L['Select extra debuffs to highlight on your friends.'],
					get = function(info,key)
						local filters = PitBull4_Aura.db.profile.global.filters
						local filter_name,entry = extract_filter_entry_from_key(key)
						return filters[filter_name].name_list[entry]
					end,
					set = function(info,key,value)
						local filters = PitBull4_Aura.db.profile.global.filters
						local filter_name,entry = extract_filter_entry_from_key(key)
						filters[filter_name].name_list[entry] = value
					end,
					values = function(info)
						local t = {}
						get_values_from_filter('*D',t)
						return t
					end,
					order = 10,
				},
				friend_highlights_add = {
					type = 'input',
					name = L['Add friend highlight'],
					desc = L['Add a friend debuff to the extra friend debuff highlights.'],
					get = function(info) return "" end,
					set = function(info, value)
						local name_list = PitBull4_Aura:GetFilterDB('*D').name_list
						name_list[value] = true
						PitBull4_Aura:UpdateAll()
					end,
					validate = function(info, value)
						if value:len() < 3 then
							return L["Must be at least 3 characters long."]
						end
						return true
					end,
					order = 11,
				},
				spacer4 = {
					type = 'header',
					name = '',
					desc = '',
					order = 12,
				},
				enemy_highlights = {
					type = 'multiselect',
					dialogControl = MULTISELECT_CONTROL, 
					name = L['Extra enemy highlights'],
					desc = L['Select extra buffs to highlight on your enemies.'],
					get = function(info,key)
						local filters = PitBull4_Aura.db.profile.global.filters
						local filter_name,entry = extract_filter_entry_from_key(key)
						return filters[filter_name].name_list[entry]
					end,
					set = function(info,key,value)
						local filters = PitBull4_Aura.db.profile.global.filters
						local filter_name,entry = extract_filter_entry_from_key(key)
						filters[filter_name].name_list[entry] = value
					end,
					values = function(info)
						local t = {}
						get_values_from_filter('*E',t)
						return t
					end,
					order = 13,
				},
				enemy_highlights_add = {
					type = 'input',
					name = L['Add enemy highlight'],
					desc = L['Add an enemy buff to the extra enemy buff highlights.'],
					get = function(info) return "" end,
					set = function(info, value)
						local name_list = PitBull4_Aura:GetFilterDB('*E').name_list
						name_list[value] = true
						PitBull4_Aura:UpdateAll()
					end,
					validate = function(info, value)
						if value:len() < 3 then
							return L["Must be at least 3 characters long."]
						end
						return true
					end,
					order = 14,
				},
			},
			order = 1,
		},
		advanced = {
			type = 'group',
			name = L['Advanced'],
			desc = L['Configure every detail of the aura filtering.'],
			inline = false,
			args = {
				current_filter = {
					type = 'select',
					name = L['Current filter'],
					desc = L['Change the filter you are currently editing.'],
					get = function(info)
						local filters = self.db.profile.global.filters
						if not rawget(filters,CURRENT_FILTER) then
							CURRENT_FILTER = next(filters)
							self:SetFilterOptions(CURRENT_FILTER,CURRENT_FILTER_OPTIONS)
						end
						return CURRENT_FILTER
					end,
					set = function(info, value)
						CURRENT_FILTER = value
						self:SetFilterOptions(CURRENT_FILTER,CURRENT_FILTER_OPTIONS)
					end,
					values = function(info)
						local t = {}
						local filters = self.db.profile.global.filters
						for k,v in pairs(filters) do
							t[k] = v.display_name or k
						end
						return t
					end,
					width = 'double',
					order = 1,
				},
				spacer = {
					type = 'description',
					name = '',
					desc = '',
					order = 2,
				},
				delete_filter = {
					type = 'execute',
					name = L['Delete'],
					desc = L['Delete current filter.'],
					func = function(info)
						local filters = self.db.profile.global.filters
						filters[CURRENT_FILTER] = nil
						CURRENT_FILTER = next(filters)
						self:SetFilterOptions(CURRENT_FILTER,CURRENT_FILTER_OPTIONS)
					end,
					disabled = function(info)
						local filters = self.db.profile.global.filters
						if filters[CURRENT_FILTER].built_in then return true end
						if any_layout_uses_filter(CURRENT_FILTER) then return true end
						return PitBull4_Aura:AnyFilterReferences(CURRENT_FILTER)
					end,
					order = 3,
				},
				new_filter = {
					type = 'input',
					name = L["New filter"],
					desc = L["Create a new filter.  This will copy the data of the currently-selected filter."],
					get = function(info) return "" end,
					set = function(info, value)
						local filters = self.db.profile.global.filters
						local new_filter = deep_copy(filters[CURRENT_FILTER])
						new_filter.built_in = nil
						new_filter.display_name = nil
						filters[value] = new_filter
						CURRENT_FILTER = value
						self:SetFilterOptions(CURRENT_FILTER,CURRENT_FILTER_OPTIONS)
					end,
					validate = function(info, value)
						if value:len() < 3 then
							return L["Must be at least 3 characters long."]
						end
						if self.db.profile.global.filters[value] then
							return L["Filter of that name already exists."]
						end
						return true
					end,
					order = 4,
				},
				filter = {
					type = 'group',
					name = '',
					desc = '',
					inline = true,
					args = CURRENT_FILTER_OPTIONS,
					order = 5,
				},
			},
			order = 2,
		},
	}
end
