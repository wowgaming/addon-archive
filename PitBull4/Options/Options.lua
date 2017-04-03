local _G = _G
local PitBull4 = _G.PitBull4
local L = PitBull4.L

local AceConfig = LibStub and LibStub("AceConfig-3.0", true)
if not AceConfig then
	LoadAddOn("Ace3")
	AceConfig = LibStub and LibStub("AceConfig-3.0", true)
	if not LibSimpleOptions then
		message(("PitBull4 requires the library %q and will not work without it."):format("AceConfig-3.0"))
		error(("PitBull4 requires the library %q and will not work without it."):format("AceConfig-3.0"))
	end
end
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

AceConfig:RegisterOptionsTable("PitBull4_Bliz", {
	name = L["PitBull Unit Frames 4.0"],
	handler = PitBull4,
	type = 'group',
	args = {
		config = {
			name = L["Standalone config"],
			desc = L["Open a standlone config window, allowing you to actually configure PitBull Unit Frames 4.0."],
			type = 'execute',
			func = function()
				PitBull4.Options.OpenConfig()
			end
		}
	},
})
AceConfigDialog:AddToBlizOptions("PitBull4_Bliz", "PitBull Unit Frames 4.0")

do
	for i, cmd in ipairs { "/PitBull4", "/PitBull", "/PB4", "/PB", "/PBUF", "/Pit" } do
		_G["SLASH_PITBULLFOUR" .. (i*2 - 1)] = cmd
		_G["SLASH_PITBULLFOUR" .. (i*2)] = cmd:lower()
	end

	_G.hash_SlashCmdList["PITBULLFOUR"] = nil
	_G.SlashCmdList["PITBULLFOUR"] = function()
		return PitBull4.Options.OpenConfig()
	end
end

PitBull4.Options = {}

local options

function PitBull4.Options.HandleModuleLoad(module)
	if not options then
		-- doesn't matter yet, it'll be caught in the real config opening.
		return
	end
	
	PitBull4.Options.modules_handle_module_load(module)
	PitBull4.Options.colors_handle_module_load(module)
	
	PitBull4.Options["layout_editor_" .. module.module_type .. "_handle_module_load"](module)
end

function PitBull4.Options.OpenConfig()
	-- redefine it so that we just open up the pane next time
	function PitBull4.Options.OpenConfig()
		AceConfigDialog:Open("PitBull4")
	end
	
	options = {
		name = L["PitBull"],
		handler = PitBull4,
		type = 'group',
		args = {
		},
	}
	
	local new_order
	do
		local current = 0
		function new_order()
			current = current + 1
			return current
		end
	end
	
	local t = { PitBull4.Options.get_general_options() }
	PitBull4.Options.get_general_options = nil
	
	for i = 1, #t, 2 do
		local k, v = t[i], t[i+1]
		
		options.args[k] = v
		v.order = new_order()
	end
	
	options.args.layout_editor = PitBull4.Options.get_layout_editor_options()
	PitBull4.Options.get_layout_editor_options = nil
	options.args.layout_editor.order = new_order()
	
	options.args.units, options.args.groups = PitBull4.Options.get_unit_options()
	PitBull4.Options.get_unit_options = nil
	options.args.units.order = new_order()
	options.args.groups.order = new_order()
	
	options.args.modules = PitBull4.Options.get_module_options()
	PitBull4.Options.get_module_options = nil
	options.args.modules.order = new_order()
	
	options.args.colors = PitBull4.Options.get_color_options()
	PitBull4.Options.get_color_options = nil
	options.args.colors.order = new_order()
	
	options.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(PitBull4.db)
	options.args.profile.order = new_order()
	local old_disabled = options.args.profile.disabled
	options.args.profile.disabled = function(info)
		return InCombatLockdown() or (old_disabled and old_disabled(info))
	end
	
	AceConfig:RegisterOptionsTable("PitBull4", options)
	AceConfigDialog:SetDefaultSize("PitBull4", 835, 550)
	
	LibStub("AceEvent-3.0").RegisterEvent("PitBull4.Options", "PLAYER_REGEN_ENABLED", function()
		LibStub("AceConfigRegistry-3.0"):NotifyChange("PitBull4")
	end)
	
	LibStub("AceEvent-3.0").RegisterEvent("PitBull4.Options", "PLAYER_REGEN_DISABLED", function()
		LibStub("AceConfigRegistry-3.0"):NotifyChange("PitBull4")
	end)
	
	return PitBull4.Options.OpenConfig()
end
