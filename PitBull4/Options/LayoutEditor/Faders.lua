local _G = _G
local PitBull4 = _G.PitBull4
local L = PitBull4.L

function PitBull4.Options.get_layout_editor_fader_options()
	local GetLayoutDB = PitBull4.Options.GetLayoutDB
	local UpdateFrames = PitBull4.Options.UpdateFrames
	
	local options = {
		name = L["Faders"],
		desc = L["Faders cause the unit frame to become more or less opaque on certain conditions."],
		type = 'group',
		args = {}
	}
	
	options.args.min_opacity = {
		type = 'range',
		name = L["Minimum opacity"],
		desc = L["The minimum opacity that a shown frame can be."],
		order = 1,
		min = 0,
		max = 1,
		isPercent = true,
		get = function(info)
			return GetLayoutDB(false).opacity_min
		end,
		set = function(info, value)
			local db = GetLayoutDB(false)
			if value > db.opacity_max then
				value = db.opacity_max
			end
			db.opacity_min = value
			
			UpdateFrames()
			PitBull4:RecheckAllOpacities()
		end,
		step = 0.01,
		bigStep = 0.05,
	}
	
	options.args.max_opacity = {
		type = 'range',
		name = L["Maximum opacity"],
		desc = L["The maximum opacity that a shown frame can be."],
		order = 2,
		min = 0,
		max = 1,
		isPercent = true,
		get = function(info)
			return GetLayoutDB(false).opacity_max
		end,
		set = function(info, value)
			local db = GetLayoutDB(false)
			if value < db.opacity_min then
				value = db.opacity_min
			end
			db.opacity_max = value
			
			UpdateFrames()
			PitBull4:RecheckAllOpacities()
		end,
		step = 0.01,
		bigStep = 0.05,
	}

	options.args.smooth_opacity = {
		type = 'toggle',
		name = L["Smooth opacity change"],
		desc = L["Change the opacity over time smoothly."],
		order = 3,
		get = function(info)
			return GetLayoutDB(false).opacity_smooth
		end,
		set = function(info, value)
			GetLayoutDB(false).opacity_smooth = value
			UpdateFrames()
			PitBull4:RecheckAllOpacities()
		end,
	}
	
	local layout_functions = PitBull4.Options.layout_functions
	
	function PitBull4.Options.layout_editor_fader_handle_module_load(module)
		local id = module.id
		options.args[id] = {
			type = 'group',
			inline = true,
			name = module.name,
			desc = module.description,
			args = {
				enable = {
					type = 'toggle',
					name = L["Enable"],
					desc = L["Enable this fader."],
					get = function(info)
						return GetLayoutDB(module).enabled
					end,
					set = function(info, value)
						GetLayoutDB(module).enabled = value
						
						UpdateFrames()
						PitBull4:RecheckAllOpacities()
					end,
				},
			},
			hidden = function(info)
				return not module:IsEnabled()
			end
		}
		
		local args = options.args[id].args
		
		if layout_functions[module] then
			local t = { layout_functions[module](module) }
			layout_functions[module] = false

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
				
				args[k] = v
			end
		end
	end
	for id, module in PitBull4:IterateModulesOfType("fader", true) do
		PitBull4.Options.layout_editor_fader_handle_module_load(module)
	end
	
	return options
end
