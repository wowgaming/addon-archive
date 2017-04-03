local _G = _G
local PitBull4 = _G.PitBull4
local L = PitBull4.L

local DEBUG = PitBull4.DEBUG
local expect = PitBull4.expect

local color_functions = {}

--- Set the function to be called that will return a tuple of key-value pairs that will cause an options table show in the colors section.
-- The last return must be a function that resets all colors.
-- @name Module:SetColorOptionsFunction
-- @param func function to call
-- @usage MyModule:SetColorOptionsFunction(function(self)
--     return 'someOption', { name = "Some option", }, -- etc
--     function(info)
--         -- reset all colors
--     end
-- end)
function PitBull4.defaultModulePrototype:SetColorOptionsFunction(func)
	if DEBUG then
		expect(func, 'typeof', 'function')
		expect(color_functions[self], '==', nil)
	end
	
	color_functions[self] = func
end

local function get_class_options()
	local class_options = {
		type = 'group',
		name = CLASS,
		args = {},
	}
	
	local class_translations = {
		WARRIOR = L["Warriors"],
		DRUID = L["Druids"],
		ROGUE = L["Rogues"],
		PRIEST = L["Priests"],
		DEATHKNIGHT = L["Death Knights"],
		SHAMAN = L["Shamans"],
		PALADIN = L["Paladins"],
		MAGE = L["Mages"],
		WARLOCK = L["Warlocks"],
		HUNTER = L["Hunters"],
	}
	
	local option = {
		type = 'color',
		name = function(info)
			local class = info[#info]
			
			return class_translations[class] or class
		end,
		hasAlpha = false,
		get = function(info)
			local class = info[#info]
			
			return unpack(PitBull4.db.profile.colors.class[class])
		end,
		set = function(info, r, g, b)
			local class = info[#info]
			
			local color = PitBull4.db.profile.colors.class[class]
			color[1], color[2], color[3] = r, g, b
			
			for frame in PitBull4:IterateFrames() do
				frame:Update()
			end
		end
	}
	
	for class in pairs(RAID_CLASS_COLORS) do
		class_options.args[class] = option
	end
	
	
	class_options.args.reset_sep = {
		type = 'header',
		name = '',
		order = -2,
	}
	class_options.args.reset = {
		type = 'execute',
		name = L["Reset to defaults"],
		confirm = true,
		confirmText = L["Are you sure you want to reset to defaults?"],
		order = -1,
		func = function(info)
			for class, color in pairs(RAID_CLASS_COLORS) do
				local db_color = PitBull4.db.profile.colors.class[class]
				db_color[1], db_color[2], db_color[3] = color.r, color.g, color.b
			end
			
			for frame in PitBull4:IterateFrames() do
				frame:Update()
			end
		end,
	}
	
	return class_options
end

local function get_power_options()
	local power_options = {
		type = 'group',
		name = L["Power"],
		args = {},
	}
	
	local option = {
		type = 'color',
		name = function(info)
			local power_token = info[#info]
			
			return _G[power_token] or power_token
		end,
		hasAlpha = false,
		get = function(info)
			local power_token = info[#info]
			
			return unpack(PitBull4.db.profile.colors.power[power_token])
		end,
		set = function(info, r, g, b)
			local power_token = info[#info]
			
			local color = PitBull4.db.profile.colors.power[power_token]
			color[1], color[2], color[3] = r, g, b
			
			for frame in PitBull4:IterateFrames() do
				frame:Update()
			end
		end
	}
	
	for power_token in pairs(PitBull4.PowerColors) do
		if type(power_token) == "string" then
			power_options.args[power_token] = option
		end
	end
	
	
	power_options.args.reset_sep = {
		type = 'header',
		name = '',
		order = -2,
	}
	power_options.args.reset = {
		type = 'execute',
		name = L["Reset to defaults"],
		confirm = true,
		confirmText = L["Are you sure you want to reset to defaults?"],
		order = -1,
		func = function(info)
			for power_token, color in pairs(PowerBarColor) do
				if type(power_token) == "string" then
					local db_color = PitBull4.db.profile.colors.power[power_token]
					db_color[1], db_color[2], db_color[3] = color.r, color.g, color.b
				end
			end
			
			for frame in PitBull4:IterateFrames() do
				frame:Update()
			end
		end,
	}
	
	return power_options
end

local function get_reaction_options()
	local reaction_options = {
		type = 'group',
		name = L["Reaction"],
		args = {},
	}
	
	local option = {
		type = 'color',
		name = function(info)
			local reaction = info[#info]
			
			local label = "FACTION_STANDING_LABEL" .. reaction
			return _G[label] or label
		end,
		hasAlpha = false,
		get = function(info)
			local reaction = info[#info]+0
			
			return unpack(PitBull4.db.profile.colors.reaction[reaction])
		end,
		set = function(info, r, g, b)
			local reaction = info[#info]+0
			
			local color = PitBull4.db.profile.colors.reaction[reaction]
			color[1], color[2], color[3] = r, g, b
			
			for frame in PitBull4:IterateFrames() do
				frame:Update()
			end
		end
	}
	
	for reaction in pairs(FACTION_BAR_COLORS) do
		local my_option = {}
		for k, v in pairs(option) do
			my_option[k] = v
		end
		my_option.order = reaction
		reaction_options.args[reaction..""] = my_option
	end
	
	reaction_options.args.civilan = {
		type = 'color',
		name = L["Civilian"],
		get = function(info)
			return unpack(PitBull4.db.profile.colors.reaction.civilian)
		end,
		set = function(info, r, g, b)
			local color = PitBull4.db.profile.colors.reaction.civilian
			color[1], color[2], color[3] = r, g, b
			
			for frame in PitBull4:IterateFrames() do
				frame:Update()
			end
		end
	}
	
	reaction_options.args.reset_sep = {
		type = 'header',
		name = '',
		order = -2,
	}
	reaction_options.args.reset = {
		type = 'execute',
		name = L["Reset to defaults"],
		confirm = true,
		confirmText = L["Are you sure you want to reset to defaults?"],
		order = -1,
		func = function(info)
			for reaction, color in pairs(FACTION_BAR_COLORS) do
				local db_color = PitBull4.db.profile.colors.reaction[reaction]
				db_color[1], db_color[2], db_color[3] = color.r, color.g, color.b
			end
			
			local db_color = PitBull4.db.profile.colors.reaction.civilian
			db_color[1], db_color[2], db_color[3] = 48/255, 113/255, 191/255
			
			for frame in PitBull4:IterateFrames() do
				frame:Update()
			end
		end,
	}
	
	return reaction_options
end

local function get_happiness_options()
	local _,class = UnitClass("player")
	if class ~= "HUNTER" then
		return
	end

	local happiness_options = {
		type = 'group',
		name = L["Pet happiness"],
		args = {},
	}
	
	happiness_options.args.happy = {
		type = 'color',
		name = PET_HAPPINESS3,
		get = function(info)
			return unpack(PitBull4.db.profile.colors.happiness.happy)
		end,
		set = function(info, r, g, b)
			local color = PitBull4.db.profile.colors.happiness.happy
			color[1], color[2], color[3] = r, g, b
			
			for frame in PitBull4:IterateFrames() do
				frame:Update()
			end
		end,
		order = 1,
	}

	happiness_options.args.content = {
		type = 'color',
		name = PET_HAPPINESS2,
		get = function(info)
			return unpack(PitBull4.db.profile.colors.happiness.content)
		end,
		set = function(info, r, g, b)
			local color = PitBull4.db.profile.colors.happiness.content
			color[1], color[2], color[3] = r, g, b
			
			for frame in PitBull4:IterateFrames() do
				frame:Update()
			end
		end,
		order = 2,
	}

	happiness_options.args.unhappy = {
		type = 'color',
		name = PET_HAPPINESS1, 
		get = function(info)
			return unpack(PitBull4.db.profile.colors.happiness.unhappy)
		end,
		set = function(info, r, g, b)
			local color = PitBull4.db.profile.colors.happiness.unhappy
			color[1], color[2], color[3] = r, g, b
			
			for frame in PitBull4:IterateFrames() do
				frame:Update()
			end
		end,
		order = 3,
	}
	
	happiness_options.args.reset_sep = {
		type = 'header',
		name = '',
		order = -2,
	}
	happiness_options.args.reset = {
		type = 'execute',
		name = L["Reset to defaults"],
		confirm = true,
		confirmText = L["Are you sure you want to reset to defaults?"],
		order = -1,
		func = function(info)
			local db_color = PitBull4.db.profile.colors.happiness.happy
			db_color[1], db_color[2], db_color[3] = 0, 1, 0

			db_color = PitBull4.db.profile.colors.happiness.content
			db_color[1], db_color[2], db_color[3] = 1, 1, 0 
			
			db_color = PitBull4.db.profile.colors.happiness.unhappy
			db_color[1], db_color[2], db_color[3] = 1, 0, 0 
			
			for frame in PitBull4:IterateFrames() do
				frame:Update()
			end
		end,
	}
	
	return happiness_options
end


function PitBull4.Options.get_color_options()
	local color_options = {
		type = 'group',
		name = L["Colors"],
		desc = L["Set colors that PitBull uses."],
		args = {},
		childGroups = "tree",
	}
	
	color_options.args.class = get_class_options()
	color_options.args.power = get_power_options()
	color_options.args.reaction = get_reaction_options()
	color_options.args.happiness = get_happiness_options()
	
	function PitBull4.Options.colors_handle_module_load(module)
		if color_functions[module] then
			local id = module.id
			local opt = {
				type = 'group',
				name = module.name,
				desc = module.description,
				args = {},
				handler = module,
				hidden = function(info)
					return not module:IsEnabled()
				end
			}
			color_options.args[id] = opt
		
			local t = { color_functions[module](module) }
		
			local reset_func = table.remove(t)
			if DEBUG then
				expect(reset_func, 'typeof', 'function')
			end
			for i = 1, #t, 2 do
				local k, v = t[i], t[i + 1]
				opt.args[k] = v
				v.order = i
			end
		
		
			opt.args.reset_sep = {
				type = 'header',
				name = '',
				order = -2,
			}
			opt.args.reset = {
				type = 'execute',
				name = L["Reset to defaults"],
				confirm = true,
				confirmText = L["Are you sure you want to reset to defaults?"],
				order = -1,
				func = function(info)
					reset_func(info)
				
					for frame in PitBull4:IterateFrames() do
						module:Update(frame)
					end
				end,
			}
		
			color_functions[module] = false
		end
	end
	
	for id, module in PitBull4:IterateModules() do
		PitBull4.Options.colors_handle_module_load(module)
	end
	
	return color_options
end
