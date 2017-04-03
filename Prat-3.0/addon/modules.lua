---------------------------------------------------------------------------------
--
-- Prat - A framework for World of Warcraft chat mods
--
-- Copyright (C) 2006-2008  Prat Development Team
--
-- This program is free software; you can redistribute it and/or
-- modify it under the terms of the GNU General Public License
-- as published by the Free Software Foundation; either version 2
-- of the License, or (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program; if not, write to:
--
-- Free Software Foundation, Inc.,
-- 51 Franklin Street, Fifth Floor,
-- Boston, MA  02110-1301, USA.
--
--
-------------------------------------------------------------------------------
--[[
Name: Prat 3.0 (modules.lua)
Revision: $Revision: 82088 $
Author(s): Sylvaanar (sylvanaar@mindspring.com)
Inspired By: Prat 2.0, Prat, and idChat2 by Industrial
Website: http://files.wowace.com/Prat/
Documentation: http://www.wowace.com/wiki/Prat
Forum: http://www.wowace.com/forums/index.php?topic=6243.0
SVN: http://svn.wowace.com/wowace/trunk/Prat/
Description: The implementation of the module framework
]]

--[[ BEGIN STANDARD HEADER ]]--

-- Imports
local _G = _G
local LibStub = LibStub
local tonumber = tonumber
local tostring = tostring
local pairs, ipairs = pairs, ipairs
local type = type
local Prat = Prat
local pcall = pcall
local setmetatable = setmetatable
local tinsert = tinsert
-- Isolate the environment
setfenv(1, Prat)

--[[ END STANDARD HEADER ]]--

Addon.defaultModuleState = true

--[[

Module system flow:

1) Module code loaded by the client
2) Module first asks if it should  be INSTALLED
3) If no, the module code returns before creating the module
4) If yes, the module is given the name it should register with
5) The module code creates a new module calling NewModule
6) Once the module has been created, we recieve OnModuleCreated, we want to
   remember that this module is installed, so we save that info
7) The module will have its on initalize called after Prat's.  
8) If the module is disabled it will stop at this point
9) If the module is enabled, it will call its OnEnable

That give us the states: EXISTS, INSTALLED, INITIALIZED, ENABLED, 
                                                         DISABLED


]]

local function NOP() end

do
	Modules = {}
	function RequestModuleName(self, name)  --  <== EXISTS
		if type(name) ~= "string" then 
			name = tostring(self)
		end

		CreateModuleControlOption(name)

		-- Duh, this still requires separate loader due to the saved variable
		if Prat.db and Prat.db.profile.modules[name] == 1 then
			Modules[name] = "EXISTS"
		end

		if not Modules[name] then
			Modules[name] = "EXISTS"
			return name
		end
	end
end

do
	local module_defaults = {}
	function SetModuleDefaults(self, module, defaults)
		module_defaults[type(module) == "table" and module.name or module] = defaults
	end

	local module_init = {}
	function SetModuleInit(self, module, init)
		module_init[type(module) == "table" and module.name or module or "null"] = init
	end
	local function GetModuleInit(module)
		return module_init[type(module) == "table" and module.name or module or "null"]
	end
	
	local sectionlist = {
		--display
		["ChannelColorMemory"] = "display",
		["ChannelSticky"] = "display",
		["ChatFrames"] = "display",
		["Fading"] = "display",
		["History"] = "display",
		["Frames"] = "display",
		["Editbox"] = "display",
		["Paragraph"] = "display",
		["Scroll"] = "display",
		["Clear"] = "display",
		["Font"] = "display",
		["Tabs"] = "display",
		["Buttons"] = "display",
		["Original Buttons"] = "display",

		--formatting
		["ChannelNames"] = "formatting",
		["PlayerNames"] = "formatting",
		["ServerNames"] = "formatting",
		["Substitutions"] = "formatting",
		["Timestamps"] = "formatting",
		["UrlCopy"] = "formatting",
		--extras
		["AddonMsgs"] = "extras",
		["EventNames"] = "extras",
		["PopupMessage"] = "extras",
		["Sounds"] = "extras",
		}
	setmetatable(sectionlist, {__index = function(t,k,v)
			return "extras"
			end})

	local function onInit(self)  --  ==> INSTALLED -> INITIALIZED
		local defaults, opts, init
		defaults, module_defaults[self.name] = module_defaults[self.name] or {}
		self.db = Prat.db:RegisterNamespace(self.name, defaults)

		init = GetModuleInit(self)
		if init then 
			init(self) 
			SetModuleInit(self, self, nil)
		end
		opts = GetModuleOptions(self.name)
		if opts then 
			opts.handler = self
			opts.disabled = "IsDisabled"
			Options.args[sectionlist[opts.name]].args[opts.name], opts = opts
			SetModuleOptions(self, self.name, nil)
		end

		local v = Prat.db.profile.modules[self.moduleName]
	    if v == 4 or v == 5 then 
	        self.db.profile.on = (v == 5) and true or false
			Prat.db.profile.modules[self.moduleName] = v-2
		else
			Prat.db.profile.modules[self.moduleName] = self.db.profile.on and 3 or 2
	    end
		self:SetEnabledState(self.db.profile.on)

		Modules[self.name] = "INITALIZED"
	end


	local function onEnable(self)   -- ==> INITIALIZED/DISABLED -> ENABLED
		local pats = GetModulePatterns(self)
		if pats then 
			for _,v in ipairs(pats) do
				RegisterPattern(v, self.name)
			end
		end
		
		self:OnModuleEnable()
		Modules[self.name] = "ENABLED"
	end
	local function onDisable(self)  -- ==>INITIALIZED/ENABLED -> DISABLED
		UnregisterAllPatterns(self.name)
		self:OnModuleDisable()
		Modules[self.name] = "DISABLED"
	end


	local function setValue(self, info, b)
		self.db.profile[info[#info]] = b
		self:OnValueChanged(info, b)
	end
	local function getValue(self, info)
		return self.db.profile[info[#info]]
	end

	local function getSubValue(self, info, val)
		return self.db.profile[info[#info]][val]
	end
	local function setSubValue(self, info, val, b)
		self.db.profile[info[#info]][val] = b
		self:OnSubValueChanged(info, val, b)
	end

	local defclr = { r=1, b=1, g=1, a=1 }
	local function getColorValue(self, info)
		local c = self.db.profile[info[#info]] or defclr
		return c.r, c.g, c.b, c.a
	end	
	local function setColorValue(self, info, r,g,b,a)
		local c = self.db.profile[info[#info]] or defclr
		c.r, c.g, c.b, c.a = r,g,b,a
		self:OnColorValueChanged(info, r,g,b,a)
	end

	local function isDisabled(self)
		return not self:IsEnabled()
	end

	local prototype = {
		OnEnable = onEnable,
		OnDisable = onDisable,
		OnInitialize = onInit,
		OnModuleEnable = NOP,
		OnModuleDisable = NOP,
		OnModuleInit = NOP,
		OnValueChanged = NOP,
		OnSubValueChanged = NOP,
		OnColorValueChanged = NOP,
		GetValue = getValue,
		SetValue = setValue,
		GetSubValue = getSubValue,
		SetSubValue = setSubValue,
		GetColorValue = getColorValue,
		SetColorValue = setColorValue,
		IsDisabled = isDisabled,

		-- Standard fields
		L = {},
		section = "extras",
	}

	function NewModule(self, name, ...)  -- <== INSTALLED (Ace3 does the <== INITIALIZED)
		return Addon:NewModule(name, prototype, ...)
	end

--	local locs, section
--	function NewModuleEx(self, name, locs, section, ...)  -- <== INSTALLED (Ace3 does the <== INITIALIZED)
--		return Addon:NewModule(name, prototype, ...)
--	end

	function Addon:OnModuleCreated(module) -- EXISTS -> INSTALLED
--[===[@debug@
		_G[module.moduleName:lower()] = module  
--@end-debug@]===]
		Modules[module.name], Modules[module.moduleName] = "INSTALLED"
	end
end


--[[ 

For module options, i want to use the single closure style executed from the main chunk of the module,
such as:

SetModuleOptionTable(name, function() return { ... } )

This way the options can be GC'd by from the modules, before the decision is made as
to whether we will actually load the module. they will go into a table here, and either
free'd, given back to the module for it to execute, or possible executed on this end. 

In any case there will only be 1 copy of the closure, and if executed it will create its data
and then it can be freed leaving no code behind. Prat 2.0 used alot of memory solely because of 
its options tables, this tries to avoid that.

]]

do
	local module_options = {}
	function SetModuleOptions(self, module, options)
		module_options[type(module) == "table" and module.name or module or "null"] = options
	end
	
	function GetModuleOptions(module)
		return module_options[type(module) == "table" and module.name or module or "null"]
	end
end

do
	local module_patterns = {}
	function SetModulePatterns(self, module, patterns)
		module_patterns[type(module) == "table" and module.name or module or "null"] = patterns
	end
	
	function GetModulePatterns(module)
		return module_patterns[type(module) == "table" and module.name or module or "null"]
	end
end

do 
	local modules_toload = {}
	local extensions_toload = {}
	function AddModuleToLoad(self, module_closure)
		tinsert(modules_toload, module_closure)
	end
	
	function AddModuleExtension(self, extension_closure)
		tinsert(extensions_toload, extension_closure)
	end

	local function loadNow(self, mod)
		local success, ret = pcall(mod)
		if not success then
			 _G.geterrorhandler()(ret)
		end
	end

	function LoadModules()
		for i=1,#modules_toload,1 do
			local success, ret = pcall(modules_toload[i])
			if not success then
				 _G.geterrorhandler()(ret)
			end
			modules_toload[i] = nil
		end	
		modules_toload = nil

		for i=1,#extensions_toload,1 do
			local success, ret = pcall(extensions_toload[i])
			if not success then
				 _G.geterrorhandler()(ret)
			end
			extensions_toload[i] = nil
		end	
		extensions_toload = nil

		LoadModules = nil
		AddModuleToLoad = loadNow
		AddModuleExtension = loadNow
	end
end
	
