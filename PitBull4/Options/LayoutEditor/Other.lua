local _G = _G
local PitBull4 = _G.PitBull4
local L = PitBull4.L

function PitBull4.Options.get_layout_editor_other_options(layout_options)
	local GetLayoutDB = PitBull4.Options.GetLayoutDB
	local UpdateFrames = PitBull4.Options.UpdateFrames
	
	local options = {
		name = L["Other"],
		type = 'group',
		childGroups = "tab",
		args = {}
	}
	
	local layout_functions = PitBull4.Options.layout_functions
	
	function PitBull4.Options.layout_editor_custom_handle_module_load(module)
		local id = module.id
		if not layout_functions[module] then
			return
		end
		local t = { layout_functions[module](module) }
		layout_functions[module] = false
	
		local top_level = (t[1] == true)
		if top_level then
			table.remove(t, 1)
		end
	
		local args = top_level and layout_options.args or options.args
	
		args[id] = {
			type = 'group',
			name = module.name,
			desc = module.description,
			childGroups = 'tab',
			order = 6,
			hidden = function(info)
				return not module:IsEnabled()
			end,
			args = {
				enable = {
					type = 'toggle',
					name = L["Enable"],
					desc = L["Enable this module for this layout."],
					order = 1,
					get = function(info)
						return GetLayoutDB(module).enabled
					end,
					set = function(info, value)
						GetLayoutDB(module).enabled = value

						UpdateFrames()
					end
				},
			},
		}
	
		for i = 1, #t, 2 do
			local k = t[i]
			local v = t[i+1]
	
			if v then
				if not v.order then
					v.order = i + 100
				end
				local v_disabled = v.disabled
				function v.disabled(info)
					return not GetLayoutDB(module).enabled or (v_disabled and v_disabled(info))
				end
			end
		
			args[id].args[k] = v
		end
	end
	for id, module in PitBull4:IterateModulesOfType("custom", true) do
		PitBull4.Options.layout_editor_custom_handle_module_load(module)
	end
	
	return options
end
