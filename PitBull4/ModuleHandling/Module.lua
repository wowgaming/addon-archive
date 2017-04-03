local _G = _G
local PitBull4 = _G.PitBull4

local DEBUG = PitBull4.DEBUG
local expect = PitBull4.expect

-- dictionary of module type name to module type prototype
local module_types = {}

-- dictionary of module type name to layout defaults
local module_types_to_layout_defaults = {}

-- dictionary of module type name to whether texts should update
local module_types_to_update_texts = {}

-- dictionary of script name to a dictionary of module to callback
local module_script_hooks = {}

-- dictionary of module to layout defaults
local module_to_layout_defaults = {}

-- dictionary of module to global defaults
local module_to_global_defaults = {}

--- Add a new module type.
-- @param name name of the module type
-- @param defaults a dictionary of default values that all modules will have that inherit from this module type
-- @param update_texts if texts on the frame should be updated along with :UpdateLayout
-- @usage MyModule:NewModuleType("mytype", { size = 50, verbosity = "lots" })
function PitBull4:NewModuleType(name, defaults, update_texts)
	if DEBUG then
		expect(name, 'typeof', "string")
		expect(name, 'not_inset', module_types)
		expect(defaults, 'typeof', "table")
		expect(update_texts, 'typeof', 'boolean;nil')
	end
	
	module_types[name] = {}
	module_types_to_layout_defaults[name] = defaults
	module_types_to_update_texts[name] = update_texts or false
	
	return module_types[name]
end

local Module = {}
PitBull4:SetDefaultModulePrototype(Module)

local do_nothing = function() end

--- Iterate through all script hooks for a given script
-- @param script name of the script
-- @usage for module, func in PitBull4:IterateFrameScriptHooks("OnEnter") do
--     -- do stuff here
-- end
-- @return iterator that returns module and function
function PitBull4:IterateFrameScriptHooks(script)
	if DEBUG then
		expect(script, 'typeof', 'string')
		expect(script, 'match', '^On[A-Z][A-Za-z]+$')
	end
	
	if not module_script_hooks[script] then
		return do_nothing
	end
	return next, module_script_hooks[script]
end

--- Run all script hooks for a given script
-- @param script name of the script
-- @param frame current Unit Frame
-- @param ... any arguments to pass in
-- @usage PitBull4:RunFrameScriptHooks(script, ...)
function PitBull4:RunFrameScriptHooks(script, frame, ...)
	if DEBUG then
		expect(script, 'typeof', 'string')
		expect(frame, 'typeof', 'frame')
		expect(frame, 'inset', PitBull4.all_frames)
	end

	for module, func in self:IterateFrameScriptHooks(script) do
		func(frame, ...)
	end
end

local recent_modules = {}
function PitBull4:OnModuleCreated(module)
	local id = module.moduleName
	if DEBUG then
		expect(id, 'typeof', 'string')
		expect(id, 'match', '^[A-Za-z_][A-Za-z0-9_]*$')
	end
	module.id = id
	self[id] = module
	
	recent_modules[#recent_modules+1] = module
end

LibStub("AceEvent-3.0"):RegisterEvent("ADDON_LOADED", function(event, addon)
	if not PitBull4.Options or not PitBull4.Options.HandleModuleLoad then
		return
	end
	while true do
		local module = table.remove(recent_modules, 1)
		if not module then
			break
		end

		-- add the options for the newly loaded module to the option panels
		PitBull4.Options.HandleModuleLoad(module)

		-- tell all the other modules a new module was loaded
		PitBull4:CallMethodOnModules("OnModuleLoaded",module)

		-- Call the newly loaded modules OnNewLayout for every layout
		-- that was loaded before it.
		local seen_layout_dbs = PitBull4.seen_layout_dbs
		local on_new_layout = module["OnNewLayout"]
		if on_new_layout and seen_layout_dbs then
			for layout, layout_db in pairs(PitBull4.db.profile.layouts) do
				if seen_layout_dbs[layout_db] then
					on_new_layout(module, layout)
				end
			end
		end
	end
end)

--- Add a script hook for the unit frames.
-- @name Module:AddFrameScriptHook
-- @param script name of the script
-- @param func function to call or method on the module to call
-- @usage MyModule:AddFrameScriptHook("OnEnter", function(frame)
--     -- do stuff here
-- end)
function Module:AddFrameScriptHook(script, method)
	if DEBUG then
		expect(script, 'typeof', 'string')
		expect(script, 'match', '^On[A-Z][A-Za-z]+$')
		expect(method, 'typeof', 'function;string;nil')
		if module_script_hooks[script] then
			expect(self, 'not_inset', module_script_hooks[script])
		end
	end
	
	if not method then
		method = script
	end
	
	if not module_script_hooks[script] then
		module_script_hooks[script] = {}
	end
	module_script_hooks[script][self] = PitBull4.Utils.ConvertMethodToFunction(self, method)
end

--- Remove a script hook for the unit frames.
-- @name Module:RemoveFrameScriptHook
-- @param script name of the script
-- @usage MyModule:RemoveFrameScriptHook("OnEnter")
function Module:RemoveFrameScriptHook(script)
	if DEBUG then
		expect(script, 'typeof', 'string')
		expect(script, 'match', '^On[A-Z][A-Za-z]+$')
	end

	module_script_hooks[script][self] = nil
end

--- Set the localized name of the module.
-- @param name the localized name of the module, with proper spacing, and in Title Case.
-- @usage MyModule:SetName("My Module")
function Module:SetName(name)
	if DEBUG then
		expect(name, 'typeof', 'string')
	end
	
	self.name = name
end

--- Set the localized description of the module.
-- @param description the localized description of the module, as a full sentence, including a period at the end.
-- @usage MyModule:SetDescription("This does a lot of things.")
function Module:SetDescription(description)
	if DEBUG then
		expect(description, 'typeof', 'string')
	end
	
	self.description = description
end

--- Set the module type of the module.
-- This should be called right after creating the module.
-- @param type one of "custom", "bar", or "indicator"
-- @usage MyModule:SetModuleType("bar")
function Module:SetModuleType(type)
	if DEBUG then
		expect(type, 'typeof', 'string')
		expect(type, 'inset', module_types)
	end
	
	self.module_type = type
	
	for k, v in pairs(module_types[type]) do
		if self[k] == nil then
			self[k] = v
		end
	end
end

-- set the db instance on the module with defaults handled
local function fix_db_for_module(module, layout_defaults, global_defaults)
	if not global_defaults then
		global_defaults = {}
	end
	if global_defaults.enabled == nil then
		global_defaults.enabled = true
	end
	local pb4_db = PitBull4.db
	local db = pb4_db:RegisterNamespace(module.id, {
		profile = {
			layouts = {
				['*'] = layout_defaults,
			},
			global = global_defaults
		}
	})
	module.db = db

	-- AceDB-3.0 is supposed to keep the child profiles linked to the
	-- main db.  However, if a profile change happens while the child namespace
	-- isn't registered then it won't be kept in sync with the main db's
	-- profile.  A good example of this is seen with load on demand modules.
	-- Setup two profiles.  Enable the module in one and then go to the other
	-- and disable it (the order matters).  Once the module has been disabled
	-- reload the UI so you load back into the UI with the profile that doesn't have
	-- the module loaded.  Now select the other profile.  Without the following line
	-- the profile will change but the module will load with the namespace still
	-- set to the old profile.  
	pb4_db.SetProfile(db, pb4_db:GetCurrentProfile())

	if not db.profile.global.enabled then
		module:Disable()
	end
end

-- return the union of two dictionaries
local function merge(alpha, bravo)
	local x = {}
	for k, v in pairs(alpha) do
		x[k] = v
	end
	for k, v in pairs(bravo) do
		x[k] = v
	end
	return x
end

--- Set the module's database defaults.
-- This will cause module.db to be set.
-- @param layout_defaults defaults on a per-layout basis. can be nil.
-- @param global_defaults defaults on a per-profile basis. can be nil.
-- @usage MyModule:SetDefaults({ color = { 1, 0, 0, 1 } })
-- @usage MyModule:SetDefaults({ color = { 1, 0, 0, 1 } }, {})
function Module:SetDefaults(layout_defaults, global_defaults)
	if DEBUG then
		expect(layout_defaults, 'typeof', 'table;nil')
		expect(global_defaults, 'typeof', 'table;nil')
		expect(self.module_type, 'typeof', 'string')
	end
	
	local better_layout_defaults = merge(module_types_to_layout_defaults[self.module_type], layout_defaults or {})
	
	if not PitBull4.db then
		-- full addon not loaded yet
		module_to_layout_defaults[self] = better_layout_defaults
		module_to_global_defaults[self] = global_defaults
	else
		fix_db_for_module(self, better_layout_defaults, global_defaults)
	end
end

--- Get the database table for the given layout relating to the current module.
-- @param layout either the frame currently being worked on or the name of the layout.
-- @usage local color = MyModule:GetLayoutDB(frame).color
-- @return the database table
function Module:GetLayoutDB(layout)
	if DEBUG then
		expect(layout, 'typeof', 'string;table;frame')
		if type(layout) == "table" then
			expect(layout.layout, 'typeof', 'string')
		end
	end
	
	if type(layout) == "table" then
		-- we're dealing with a unit frame that has the layout key on it.
		layout = layout.layout
	end
	
	return self.db.profile.layouts[layout]
end

--- Update the frame for the current module for the given frame and handle any layout changes.
-- @param frame the Unit Frame to update
-- @param return_changed whether to return if the update should change the layout. If this is false, it will call :UpdateLayout() automatically.
-- @param same_guid whether when called from :UpdateGUID, the unit is the same GUID as before.
-- @usage MyModule:Update(frame)
-- @return whether the update requires UpdateLayout to be called if return_changed is specified
function Module:Update(frame, return_changed, same_guid)
	if DEBUG then
		expect(frame, 'typeof', 'frame')
		expect(return_changed, 'typeof', 'nil;boolean')
	end
	
	local changed, should_update_texts
	
	local layout_db = self:GetLayoutDB(frame)
	if not layout_db.enabled or (not frame.guid and not frame.force_show) then
		changed = self:ClearFrame(frame)
	else
		changed = self:UpdateFrame(frame, same_guid)
	end
	
	if return_changed then
		return changed
	end
	if changed then
		frame:UpdateLayout(module_types_to_update_texts[self.module_type])
	end
end

--- Clear the frame for the current module for the given frame and handle any layout changes.
-- @param frame the Unit Frame to clear
-- @param return_changed whether to return if the clear should change the layout. If this is false, it will call :UpdateLayout() automatically.
-- @usage MyModule:Clear(frame)
-- @return whether the clear requires UpdateLayout to be called if return_changed is specified
function Module:Clear(frame, return_changed)
	if DEBUG then
		expect(frame, 'typeof', 'frame')
		expect(return_changed, 'typeof', 'nil;boolean')
	end

	local changed = self:ClearFrame(frame)

	if return_changed then
		return changed
	end
	if changed and frame.classification_db and frame.layout_db then
		frame:UpdateLayout(module_types_to_update_texts[self.module_type])
	end
end

--- Run :Update(frame) on all shown frames with the given UnitID.
-- @param unit the UnitID in question to update
-- @usage MyModule:UpdateForUnitID("player")
function Module:UpdateForUnitID(unit)
	if DEBUG then
		expect(unit, 'typeof', 'string')
	end
	
	for frame in PitBull4:IterateFramesForUnitID(unit) do
		self:Update(frame)
	end
end

--- Run :Update(frame) on all shown frames with the given GUID.
-- @param guid the GUID in question to update
-- @usage MyModule:UpdateForGUID(UnitGUID("player"))
function Module:UpdateForGUID(guid)
	if DEBUG then
		expect(guid, 'typeof', 'string;nil')
	end
	
	if not guid then
		return
	end
	
	for frame in PitBull4:IterateFramesForGUID(guid) do
		self:Update(frame)
	end
end

--- Run :Update(frame) on all shown frames with the given classification.
-- @param classification the classification in question to update
-- @usage MyModule:UpdateForClassification("player")
function Module:UpdateForClassification(classification)
	if DEBUG then
		expect(classification, 'typeof', 'string')
	end
	
	for frame in PitBull4:IterateFramesForClassification(classification) do
		self:Update(frame)
	end
end

--- Run :Update(frame) on all shown frames.
-- @usage MyModule:UpdateAll()
function Module:UpdateAll()
	for frame in PitBull4:IterateFrames() do
		self:Update(frame)
	end
end

--- Run :Update(frame) on all non-wacky shown frames.
-- @usage MyModule:UpdateNonWacky()
function Module:UpdateNonWacky()
	for frame in PitBull4:IterateNonWackyFrames() do
		self:Update(frame)
	end
	for frame in PitBull4:IterateWackyFrames() do
		if frame.best_unit then
			self:Update(frame)
		end
	end
end

local function enabled_iter(modules, id)
	local id, module = next(modules, id)
	if not id then
		-- we're out of modules
		return nil
	end
	if not module:IsEnabled() then
		-- skip disabled modules
		return enabled_iter(modules, id)
	end
	return id, module
end

--- Iterate over all enabled modules
-- @usage for id, module in PitBull4:IterateEnabledModules() do
--     doSomethingWith(module)
-- end
-- @return iterator which returns the id and module
function PitBull4:IterateEnabledModules()
	return enabled_iter, self.modules, nil
end

local new, del = PitBull4.new, PitBull4.del

local function iter(types, id)
	local id, module = next(PitBull4.modules, id)
	if not id then
		-- we're out of modules
		del(types)
		return nil
	end
	
	if not types[module.module_type] then
		-- wrong type, try again
		return iter(types, id)
	end
	
	if not types.also_disabled and not module:IsEnabled() then
		-- skip disabled modules
		return iter(types, id)
	end
	
	return id, module
end

--- Iterate over all modules of a given type.
-- Only enabled modules will be returned unless true is provided as the last argument
-- @param ... a tuple of module types, e.g. "bar", "indicator". If the last argument is true, then iterate over disabled modules also
-- @usage for id, module in PitBull4:IterateModulesOfType("bar") do
--     doSomethingWith(module)
-- end
-- @usage for id, module in PitBull4:IterateModulesOfType("bar", "indicator", true) do
--     doSomethingWith(module)
-- end
-- @return iterator which returns the id and module
function PitBull4:IterateModulesOfType(...)
	local types = new()
	local n = select('#', ...)
	local also_disabled = ((select(n, ...)) == true)
	if also_disabled then
		n = n - 1
	end
	
	for i = 1, n do
		local type = select(i, ...)
		if DEBUG then
			expect(type, 'typeof', 'string')
			expect(type, 'inset', module_types)
		end
		
		types[type] = true
	end
	
	types.also_disabled = also_disabled
	
	return iter, types, nil
end

do
	-- we need to hook OnInitialize so that we can handle the database stuff for modules
	local old_PitBull4_OnInitialize = PitBull4.OnInitialize
	PitBull4.OnInitialize = function(self)
		if old_PitBull4_OnInitialize then
			old_PitBull4_OnInitialize(self)
		end
		
		for module, layout_defaults in pairs(module_to_layout_defaults) do
			fix_db_for_module(module, layout_defaults, module_to_global_defaults[module])
		end
		-- no longer need these
		module_to_layout_defaults = nil
		module_to_global_defaults = nil
	end
end

--- Enable a module properly.
-- Unlike module:Enable(), this tracks it in the DB as well as updates any frames.
-- @param module the module to enable
-- @usage PitBull4:EnableModule(MyModule)
function PitBull4:EnableModule(module)
	if module:IsEnabled() then
		return
	end
	
	module.db.profile.global.enabled = true
	module:Enable()
	
	for frame in self:IterateFrames() do
		frame:Update(true, true)
	end
end

--- Disable a module properly.
-- Unlike module:Disable(), this tracks it in the DB as well as cleans up any frames.
-- @param module the module to disable
-- @usage PitBull4:DisableModule(MyModule)
function PitBull4:DisableModule(module)
	if not module:IsEnabled() then
		return
	end
	
	for frame in self:IterateFrames() do
		module:Clear(frame)
	end
	
	module.db.profile.global.enabled = false
	module:Disable()
	
	for frame in self:IterateFrames() do
		frame:Update(true, true)
	end
end
