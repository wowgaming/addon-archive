local _G = _G
local PitBull4 = _G.PitBull4

local DEBUG = PitBull4.DEBUG
local expect = PitBull4.expect

local L = PitBull4.L

local CURRENT_LAYOUT = L["Normal"]

--- Return the DB dictionary for the current layout selected in the options frame.
-- Modules should be calling this and manipulating data within it.
-- @param module the module to check
-- @usage local db = PitBull.Options.GetLayoutDB(MyModule); db.some_option = "something"
-- @return the DB dictionary for the current layout
function PitBull4.Options.GetLayoutDB(module)
	if module == false then
		return PitBull4.db.profile.layouts[CURRENT_LAYOUT]
	end
	if DEBUG then
		expect(module, 'typeof', 'string;table')
		if type(module) == "table" then
			expect(module.id, 'inset', PitBull4.modules)
		end
	end
	if type(module) == "string" then
		module = PitBull4:GetModule(module)
	end
	return module:GetLayoutDB(CURRENT_LAYOUT)
end

--- Update frames for the currently selected layout.
-- This should be called by modules after changing an option in the DB.
-- @usage PitBull.Options.UpdateFrames()
function PitBull4.Options.UpdateFrames()
	PitBull4:UpdateForLayout(CURRENT_LAYOUT)
end

--- Refresh layouts for the currently selected layout.
-- This should be called by modules after changing an option in the DB.
-- @usage PitBull.Options.RefreshFrameLayouts()
function PitBull4.Options.RefreshFrameLayouts()
	for header in PitBull4:IterateHeadersForLayout(CURRENT_LAYOUT) do
		header:RefreshLayout(true)
	end
	for frame in PitBull4:IterateFramesForLayout(CURRENT_LAYOUT, true) do
		frame:RefreshLayout()
	end
end

--- Return the name of the current layout.
-- @usage local layout = PitBull4.Options.GetCurrentLayout()
-- @return the name of the current layout
function PitBull4.Options.GetCurrentLayout()
	return CURRENT_LAYOUT
end

--- Set the current layout.
-- @param layout the name of the layout
-- @usage PitBull4.Options.SetCurrentLayout("Normal")
function PitBull4.Options.SetCurrentLayout(layout)
	CURRENT_LAYOUT = layout
end

local layout_functions = {}
PitBull4.Options.layout_functions = layout_functions

--- Set the function to be called that will return a tuple of key-value pairs that will be merged onto the options table for the layout editor.
-- @name Module:SetLayoutOptionsFunction
-- @param func function to call
-- @usage MyModule:SetLayoutOptionsFunction(function(self)
--     return 'someOption', { name = "Some option", } -- etc
-- end)
function PitBull4.defaultModulePrototype:SetLayoutOptionsFunction(func)
	if DEBUG then
		expect(func, 'typeof', 'function')
		expect(layout_functions[self], '==', nil)
	end
	
	layout_functions[self] = func
end

function PitBull4.Options.get_layout_editor_options()
	local function merge_onto(dict, ...)
		for i = 1, select('#', ...), 2 do
			local k, v = select(i, ...)
			if not v.order then
				v.order = 100 + i
			end
			dict[k] = v
		end
	end

	local deep_copy = PitBull4.Utils.deep_copy
	local GetLayoutDB = PitBull4.Options.GetLayoutDB
	local UpdateFrames = PitBull4.Options.UpdateFrames
	
	local layout_options = {
		type = 'group',
		name = L["Layout editor"],
		desc = L["Edit the way your frames look, including the controls on your frames."],
		args = {},
		childGroups = "tab",
	}
	
	layout_options.args.current_layout = {
		name = L["Current layout"],
		desc = L["Change the layout you are currently editing."],
		type = 'select',
		order = 1,
		values = function(info)
			local t = {}
			for name in pairs(PitBull4.db.profile.layouts) do
				t[name] = name
			end
			return t
		end,
		get = function(info)
			return CURRENT_LAYOUT
		end,
		set = function(info, value)
			CURRENT_LAYOUT = value
		end
	}
	
	layout_options.args.new_layout = {
		name = L["New layout"],
		desc = L["Create a new layout. This will copy the data of the currently-selected layout."],
		type = 'input',
		get = function(info) return "" end,
		set = function(info, value)
			PitBull4.db.profile.layouts[value] = deep_copy(PitBull4.db.profile.layouts[CURRENT_LAYOUT])
			for id, module in PitBull4:IterateModules() do
				if module.db and module.db.profile and module.db.profile.layouts and module.db.profile.layouts[CURRENT_LAYOUT] then
					module.db.profile.layouts[value] = deep_copy(module.db.profile.layouts[CURRENT_LAYOUT])
				end
			end
			
			CURRENT_LAYOUT = value
		end,
		validate = function(info, value)
			if value:len() < 3 then
				return L["Must be at least 3 characters long."]
			end
			if rawget(PitBull4.db.profile.layouts, value) then
				return L["Must be unique."]
			end
			return true
		end,
	}
	
	layout_options.args.general = PitBull4.Options.get_layout_editor_general_options()
	PitBull4.Options.get_layout_editor_general_options = nil
	layout_options.args.general.order = 1
	
	layout_options.args.bars = PitBull4.Options.get_layout_editor_bar_options()
	PitBull4.Options.get_layout_editor_bar_options = nil
	layout_options.args.bars.order = 2
	
	layout_options.args.indicators = PitBull4.Options.get_layout_editor_indicator_options()
	PitBull4.Options.get_layout_editor_indicator_options = nil
	layout_options.args.indicators.order = 3
	
	layout_options.args.texts = PitBull4.Options.get_layout_editor_text_options()
	PitBull4.Options.get_layout_editor_text_options = nil
	layout_options.args.texts.order = 4
	
	layout_options.args.faders = PitBull4.Options.get_layout_editor_fader_options()
	PitBull4.Options.get_layout_editor_fader_options = nil
	layout_options.args.faders.order = 5
	
	layout_options.args.modules = PitBull4.Options.get_layout_editor_other_options(layout_options)
	PitBull4.Options.get_layout_editor_module_options = nil
	layout_options.args.modules.order = 7
	
	return layout_options
end
