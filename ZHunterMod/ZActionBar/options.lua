local directions = {TOP="Up", BOTTOM="Down", LEFT="Left", RIGHT="Right"}
local triggers = {OnRightClick="On Right-Click", OnMouseOver="On Mouseover", AlwaysOn="Always Shown"}

function ZActionBar_AddButtonOptions(bar, id)
	local buttonName = bar.name..id
	local saved = getglobal(bar.savedName)[bar.name]
	local options = bar.options.args[bar.name].args
	options.hotkeys.args["hotkey"..id] = {
		type = "keybinding",
		name = "Button "..id,
		desc = "Set the keybinding for button "..id..".",
		order = id,
		get = function(info)
			local key = GetBindingKey("CLICK " .. buttonName .. ":LeftButton")
			return key
		end,
		set = function(info, v)
			local action = "CLICK " .. buttonName .. ":LeftButton"
			if v == "" then
				v = GetBindingKey(action)
				SetBinding(v)
			else
				SetBinding(v, action)
			end
			SaveBindings(GetCurrentBindingSet());
		end
	}
	options.spells.args["button"..id] = {
		type = "select", style = "dropdown", values = bar.spellList,
		name = "Button "..id, desc = "Set the spell for button "..id..".",
		order = id,
		get = function(info) return saved.spells[id] end,
		set = function(info, v)
			saved.spells[id] = v
			ZActionBar_UpdateBar(bar)
		end
	}
	options.custom.args.count.max = id
	options.custom.args.perRow.max = id
end

local defaults = {
	enabled = true,
	size = 30,
	roundButton = true,
	backgroundColor = {r=0.5, g=0.4, b=0.2},
	count = 99,
	perRow = 99,
	expand = "RIGHT",
	stack = "BOTTOM",
	trigger = "OnMouseOver",
	tooltip = true
}
defaults.x, defaults.y = UIParent:GetCenter()

local function validate(src, dest)
	for i, v in pairs(src) do
		local varType = type(v)
		if varType == "table" then
			if type(dest[i]) ~= "table" then
				dest[i] = {}
			end
			validate(v, dest[i])
		else
			local otherType = type(dest[i])
			if varType ~= otherType then
				if varType ~= "boolean" or otherType ~= "nil" then
					dest[i] = v
				end
			end
		end
	end
end

local function setDefaults(savedName, name)
	local saved = getglobal(savedName)
	if type(saved) ~= "table" then
		saved = {}
		setglobal(savedName, saved)
	end
	if not saved[name] then
		saved[name] = {}
	end
	saved = saved[name]
	validate(defaults, saved)
end

function ZActionBar_SetupOptions(bar)
	setDefaults(bar.savedName, bar.name)
	local saved = getglobal(bar.savedName)[bar.name]
	for i in pairs(defaults) do
		bar[i] = saved[i]
	end
	if bar.setupSpecial then
		bar.special = saved.special
	end
	bar.options.args[bar.name] = {
		type = "group",
		name = bar.name,
		desc = "Action bar setup.",
		args = {
			custom = {
				type = "group",
				name = "Customize",
				desc = "Change the layout of the action bar buttons.",
				order = 1,
				args = {
					size = {
						type = "range", min = 20, max = 50, step = 1,
						name = "Button Size", desc = "Set the size of the spell buttons.",
						order = 1,
						get = function(info) return saved.size end,
						set = function(info, v)
							saved.size = v
							ZActionBar_SetSize(bar, v)
						end
					},
					count = {
						type = "range", min = 0, max = 0, step = 1,
						name = "Number of Buttons", desc = "Set the number of buttons to display at a time.",
						order = 2,
						get = function(info) return saved.count end,
						set = function(info, v)
							saved.count = v
							ZActionBar_SetCount(bar, v)
						end
					},
					roundButton = {
						type = "toggle",
						name = "Round Button", desc = "Set the buttons to display with rounded borders.",
						order = 3,
						get = function(info) return saved.roundButton end,
						set = function(info, v)
							saved.roundButton = v
							ZActionBar_SetRoundButton(bar, v)
						end
					},
					backgroundColor = {
						type = "color", hasAlpha = false,
						name = "Border Color", desc = "Set the border color of the spell buttons.",
						order = 4,
						get = function(info) return saved.backgroundColor.r, saved.backgroundColor.g, saved.backgroundColor.b end,
						set = function(info, r, g, b)
							saved.backgroundColor.r = r
							saved.backgroundColor.g = g
							saved.backgroundColor.b = b
							ZActionBar_SetBackgroundColor(bar, saved.backgroundColor)
						end
					},
					expand = {
						type = "select", style = "dropdown", values = directions,
						name = "Expand Direction", desc = "Set the direction that the buttons will expand.",
						order = 5,
						get = function(info) return saved.expand end,
						set = function(info, v)
							saved.expand = v
							ZActionBar_SetExpand(bar, v)
						end
					},
					stack = {
						type = "select", style = "dropdown", values = directions,
						name = "Stack Direction", desc = "Set how rows will stack on each other.",
						order = 6,
						get = function(info) return saved.stack end,
						set = function(info, v)
							saved.stack = v
							ZActionBar_SetStack(bar, v)
						end
					},
					perRow = {
						type = "range", min = 1, max = 1, step = 1,
						name = "Buttons Per Row", desc = "Set the number of buttons to display on each row.",
						order = 7,
						get = function(info) return saved.perRow end,
						set = function(info, v)
							saved.perRow = v
							ZActionBar_SetPerRow(bar, v)
						end
					},
					trigger = {
						type = "select", style = "dropdown", values = triggers,
						name = "Bar Behavior", desc = "Set the behavior of how the bar is displayed.",
						order = 8,
						get = function(info) return saved.trigger end,
						set = function(info, v)
							saved.trigger = v
							ZActionBar_SetTrigger(bar, v)
						end
					},
					tooltip = {
						type = "toggle",
						name = "Tooltip", desc = "Set the buttons to display a tooltip on mouseover.",
						order = 9,
						get = function(info) return saved.tooltip end,
						set = function(info, v)
							saved.tooltip = v
							ZActionBar_SetTooltip(bar, v)
						end
					}
				}
			},
			hotkeys = {
				type = "group",
				name = "Hotkeys",
				desc = "Set a hotkey for each button.",
				order = 2,
				args = {}
			},
			spells = {
				type = "group",
				name = "Spells",
				desc = "Set the order that spells are displayed.",
				order = 3,
				args = {}
			},
			enabled = {
				type = "toggle",
				name = "Enable Bar",
				desc = "Toggle the display of the action bar.",
				get = function(info) return saved.enabled end,
				set = function(info, v)
					saved.enabled = v
					ZActionBar_ToggleBar(bar, v)
				end
			}
		}
	}
	if bar.setupSpecial then
		bar.options.args[bar.name].args.custom.args.special = {
			type = "toggle",
			name = "Special", desc = "Toggle the use of the first button's special feature.",
			order = 10,
			get = function(info) return saved.special end,
			set = function(info, v)
				saved.special = v
				ZActionBar_SetSpecial(bar, v)
			end
		}
	end
end