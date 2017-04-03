local _G = _G
local PitBull4 = _G.PitBull4
local L = PitBull4.L

local DEBUG = PitBull4.DEBUG
local expect = PitBull4.expect

local global_functions = {}

--- Set the function to be called that will return a tuple of key-value pairs that will be merged onto the options table for the module options.
-- @name Module:SetGlobalOptionsFunction
-- @param func function to call
-- @usage MyModule:SetGlobalOptionsFunction(function(self)
--     return 'someOption', { name = "Some option", } -- etc
-- end)
function PitBull4.defaultModulePrototype:SetGlobalOptionsFunction(func)
	if DEBUG then
		expect(func, 'typeof', 'function')
		expect(global_functions[self], '==', nil)
	end
	
	global_functions[self] = func
end

function PitBull4.Options.get_module_options()
	local module_options = {
		type = 'group',
		name = L["Modules"],
		desc = L["Modules provide actual functionality for PitBull."],
		args = {},
		childGroups = "tree",
	}
	
	local module_args = {
		enabled = {
			type = 'toggle',
			name = L["Enable"],
			desc = L["Globally enable this module."],
			get = function(info)
				return info.handler:IsEnabled()
			end,
			set = function(info, value)
				if value then
					PitBull4:EnableModule(info.handler)
				else
					PitBull4:DisableModule(info.handler)
				end
			end
		}
	}

	local function merge_onto(dict, ...)
		for i = 1, select('#', ...), 2 do
			local k, v = select(i, ...)
			if not v.order then
				v.order = 100 + i
			end
			dict[k] = v
		end
	end

	function PitBull4.Options.modules_handle_module_load(module)
		local id = module.id

		local opt = {
			type = 'group',
			name = module.name,
			desc = module.description,
			args = {},
			handler = module,
		}
		module_options.args[id] = opt

		for k, v in pairs(module_args) do
			opt.args[k] = v
		end

		if global_functions[module] then
			merge_onto(opt.args, global_functions[module](module))
			global_functions[module] = false
		end
	end
	
	for id, module in PitBull4:IterateModules() do
		PitBull4.Options.modules_handle_module_load(module)
	end
	
	-- and now for disabled modules not yet loaded
	local modules_not_loaded = PitBull4.modules_not_loaded
	
	local function loadable(info)
		local id = info[#info - 1]
		local _,_,_,_,loadable = GetAddOnInfo('PitBull4_'..id)
		return loadable
	end

	local function unloadable(info)
		return not loadable(info)
	end

	local arg_enabled = {
		type = 'toggle',
		name = L["Enable"],
		desc = L["Globally enable this module."],
		get = function(info)
			return false
		end,
		set = function(info, value)
			local id = info[#info - 1]
			PitBull4:LoadAndEnableModule(id)
		end,
		disabled = unloadable,
	}
	
	local no_mem_notice = {
		type = 'description',
		name = L["This module is not loaded and will not take up and memory or processing power until enabled."],
		order = -1,
		hidden = unloadable,
	}

	local unloadable_notice = {
		type = 'description',
		name = function(info)
			local id = info[#info - 1]
			local _,_,_,_,loadable,reason = GetAddOnInfo('PitBull4_'..id)
			if not loadable then
				if reason then
					if reason == "DISABLED" then
						reason = L["Disabled in the Blizzard addon list."]
					else
						reason = _G["ADDON_"..reason]
					end
				end
				if not reason then
					reason = UNKNOWN
				end
				return format(L["This module can not be loaded: %s"],reason)
			end
		end,
		order = -1,
		hidden = loadable,
	}
	
	for id in pairs(modules_not_loaded) do
		if not module_options.args[id] then
			local addon_name = 'PitBull4_' .. id
			local title = GetAddOnMetadata(addon_name, "Title")
			local notes = GetAddOnMetadata(addon_name, "Notes")
		
			local name = title:match("%[(.*)%]")
			if not name then
				name = id
			else
				name = name:gsub("|r", ""):gsub("|c%x%x%x%x%x%x%x%x", "")
			end
		
			local opt = {
				type = 'group',
				name = name,
				desc = notes,
				args = {
					enabled = arg_enabled,
					no_mem_notice = no_mem_notice,
					unloadable_notice = unloadable_notice,
				},
			}

			module_options.args[id] = opt
		end
	end
	
	return module_options
end
