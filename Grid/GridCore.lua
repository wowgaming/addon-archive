--[[--------------------------------------------------------------------
	GridCore.lua
----------------------------------------------------------------------]]

local _, ns = ...

if not ns.L then ns.L = { } end
local L = setmetatable(ns.L, {
	__index = function(t, k)
		t[k] = k
		return k
	end
})

local waterfall = AceLibrary:HasInstance("Waterfall-1.0") and AceLibrary("Waterfall-1.0")

--{{{  Initialization

local Grid = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "AceDebug-2.0", "AceModuleCore-2.0", "AceConsole-2.0")
Grid:SetModuleMixins("AceDebug-2.0", "AceEvent-2.0", "AceModuleCore-2.0")
Grid:RegisterDB("GridDB")
Grid.debugFrame = ChatFrame1

_G.Grid = Grid
Grid.L = L

--{{{ AceOptions table

Grid.options = {
	type = "group",
	handler = Grid,
	args = {
		["DebugHeader"] = {
			type = "header",
			order = 104,
		},
		["debug"] = {
			type = "group",
			name = L["Debugging"],
			desc = L["Module debugging menu."],
			order = 105,
			args = {},
		},
	},
}

if waterfall then
	Grid.options.args["config"] = {
		type = "execute",
		name = L["Configure"],
		desc = L["Configure Grid"],
		guiHidden = true,
		func = function()
				waterfall:Open("Grid")
		end,
	}

	waterfall:Register("Grid", "aceOptions", Grid.options, "title", "Grid Configuration")
end

--}}}
--{{{ AceDB defaults

Grid.defaults = {
	debug = false,
	minimap = { },
}

--}}}
--}}}
--{{{  Module prototype

Grid.modulePrototype.core = Grid

function Grid.modulePrototype:OnInitialize()
	if not self.db then
		self.core:RegisterDefaults(self.name, "profile", self.defaultDB or {})
		self.db = self.core:AcquireDBNamespace(self.name)
	end
	self.debugFrame = Grid.debugFrame
	self.debugging = self.db.profile.debug
	self:Debug("OnInitialize")
	self.core:AddModuleDebugMenu(self)
	self:RegisterModules()
	self:RegisterEvent("ADDON_LOADED")
end

function Grid.modulePrototype:OnEnable()
	self:RegisterEvent("ADDON_LOADED")
	self:EnableModules()
end

function Grid.modulePrototype:OnDisable()
	self:DisableModules()
end

function Grid.modulePrototype:Reset()
	self.debugging = self.db.profile.debug
	self:Debug("Reset")
	self:ResetModules()
end

function Grid.modulePrototype:RegisterModules()
	for name,module in self:IterateModules() do
		self:RegisterModule(name, module)
	end
end

function Grid.modulePrototype:RegisterModule(name, module)
	self:Debug("Registering "..name)

	if not module.db then
		self.core:RegisterDefaults(name, "profile", module.defaultDB or {})
		module.db = self.core:AcquireDBNamespace(name)
	end

	if module.extraOptions and not module.options then
		module.options = {
			type = "group",
			name = module.menuName or module.name,
			desc = string.format(L["Options for %s."], module.name),
			args = {},
		}
		for name, option in pairs(module.extraOptions) do
			module.options.args[name] = option
		end
	end

	if module.options then
		self.options.args[name] = module.options
	end

	self.core:AddModuleDebugMenu(module)
end

function Grid.modulePrototype:EnableModules()
	for name,module in self:IterateModules() do
		self:ToggleModuleActive(module, true)
	end
end

function Grid.modulePrototype:DisableModules()
	for name,module in self:IterateModules() do
		self:ToggleModuleActive(module, false)
	end
end

function Grid.modulePrototype:ResetModules()
    for name,module in self:IterateModules() do
	self:Debug("Resetting " .. name)
	module.db = self.core:AcquireDBNamespace(name)
	module:Reset()
    end
end

function Grid.modulePrototype:ADDON_LOADED(addon)
	local name = GetAddOnMetadata(addon, "X-".. self.name .. "Module")
	if not name then return end

	local module = (Grid:GetModule(self.name):HasModule(name) and Grid:GetModule(self.name):GetModule(name)) or _G[name]
	if not module or not module.name then return end

	module.external = true

	self:RegisterModule(module.name, module)
end

--}}}

local activeTalentGroup

function Grid:OnInitialize()
	self:RegisterDefaults("profile", Grid.defaults)
	self:RegisterChatCommand("/grid", self.options)

	local function NoDualSpec()
		return GetNumTalentGroups() == 1
	end

	self.options.args.profile.args.choose.order = 1
	self.options.args.profile.args.other.order = 2
	self.options.args.profile.args.copy.order = 3
	self.options.args.profile.args.delete.order = 4
	self.options.args.profile.args.reset.order = 5

	self.options.args.profile.args.spacer = {
		type = "header",
		order = 6,
		disabled = true,
		hidden = NoDualSpec,
	}
	self.options.args.profile.args.dualEnabled = {
		name = L["Enable dual profile"],
		desc = L["Automatically swap profiles when switching talent specs."],
		type = "toggle",
		order = 7,
		get = function() return self.db.char.enabled end,
		set = function(enabled)
			if enabled and not self.db.char.talentGroup then
				self.db.char.talentGroup = activeTalentGroup
				self.db.char.profile = self:GetProfile()
				self.db.char.enabled = true
			else
				self.db.char.enabled = enabled
				self:CheckDualSpecState()
			end
		end,
		hidden = NoDualSpec,
	}
	self.options.args.profile.args.dualProfile = {
		name = L["Dual profile"],
		desc = L["Select the profile to swap with the current profile when switching talent specs."],
		type = "text",
		order = 8,
		get = function() return self.db.char.profile or self:GetProfile() end,
		set = function(value) self.db.char.profile = value end,
		validate = self["acedb-profile-list"],
		hidden = NoDualSpec,
		disabled = function() return not self.db.char.enabled end,
	}

	-- we need to save debugging state over sessions :(
	self.debugging = self.db.profile.debug

	self:AddModuleDebugMenu(self)

	self:RegisterModules()

	self:RegisterEvent("ADDON_LOADED")
end

function Grid:OnEnable()
	self:RegisterEvent("ADDON_LOADED")

	self:EnableModules()

	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")

	self:TriggerEvent("Grid_Enabled")

	activeTalentGroup = GetActiveTalentGroup()
	self:CheckDualSpecState()
	self:RegisterEvent("PLAYER_TALENT_UPDATE")
end

StaticPopupDialogs["GRID_DISABLED"] = {
	text = L["Grid is disabled: use '/grid standby' to enable."],
	button1 = "Okay",
	timeout = 0,
	whileDead = 1,
}

function Grid:OnDisable()
	self:Debug("OnDisable")
	StaticPopup_Show("GRID_DISABLED")
	self:Print(L["Grid is disabled: use '/grid standby' to enable."])
	self:TriggerEvent("Grid_Disabled")
	self:DisableModules()
end

function Grid:OnProfileEnable()
	self.debugging = self.db.profile.debug
	self:Debug("Loaded profile", "(", self:GetProfile(), ")")
	self:ResetModules()
end

function Grid:RegisterModules()
	for name,module in self:IterateModules() do
		self:RegisterModule(name, module)
	end
end

function Grid:RegisterModule(name, module)
	self:Debug("Registering "..name)

	if not module.db then
		self:RegisterDefaults(name, "profile", module.defaultDB or {})
		module.db = self:AcquireDBNamespace(name)
	end

	if module.options then
		self.options.args[name] = module.options
	end

	self:AddModuleDebugMenu(module)
end

function Grid:AddModuleDebugMenu(module)
	local debugMenu = Grid.options.args.debug

	debugMenu.args[module.name] = {
		type = "toggle",
		name = module.name,
		desc = string.format(L["Toggle debugging for %s."], module.name),
		get = function()
			return module.db.profile.debug
		end,
		set = function(v)
			module.db.profile.debug = v
			module.debugging = v
		end,
	}

end

function Grid:EnableModules()
	for name,module in self:IterateModules() do
		self:ToggleModuleActive(module, true)
	end
end

function Grid:DisableModules()
	for name,module in self:IterateModules() do
		self:ToggleModuleActive(module, false)
	end
end

function Grid:ResetModules()
	for name, module in self:IterateModules() do
		self:Debug("Resetting " .. name)
		module.db = self:AcquireDBNamespace(name)
		module:Reset()
	end
end

function Grid:CheckDualSpecState()
	if self.db.char.enabled and self.db.char.talentGroup ~= activeTalentGroup then
		local currentProfile = self:GetProfile()
		local newProfile = self.db.char.profile
		self.db.char.talentGroup = activeTalentGroup
		if newProfile ~= currentProfile then
			self:SetProfile(newProfile)
			self.db.char.profile = currentProfile
		end
	end
end

--{{{ Event handlers

function Grid:PLAYER_ENTERING_WORLD()
	-- this is needed for zoning while in combat
	self:PLAYER_REGEN_ENABLED()
end

function Grid:PLAYER_REGEN_DISABLED()
	self:Debug("Entering combat")
	self:TriggerEvent("Grid_EnteringCombat")
	Grid.inCombat = true
end

function Grid:PLAYER_REGEN_ENABLED()
	Grid.inCombat = InCombatLockdown() == 1
	if not Grid.inCombat then
		self:Debug("Leaving combat")
		self:TriggerEvent("Grid_LeavingCombat")
	end
end

function Grid:PLAYER_TALENT_UPDATE()
	local newTalentGroup = GetActiveTalentGroup()
	if activeTalentGroup ~= newTalentGroup then
		activeTalentGroup = newTalentGroup
		self:CheckDualSpecState()
	end
end

function Grid:ADDON_LOADED(addon)
	local name = GetAddOnMetadata(addon, "X-".. self.name .. "Module")
	if not name then return end

	local module = getglobal(name)
	if not module or not module.name then return end

	module.external = true

	self:RegisterModule(module.name, module)
end

--}}}