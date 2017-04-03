local vertical = {TOP="Top", BOTTOM="Bottom"}
local horizontal = {LEFT="Left", RIGHT="Right"}
local mouseEvents = {OnRightClick="On Right-Click", OnMouseOver="On Mouse Over", Always="Always Shown"}

ZHunterModOptions = {
	type = "group",
	args = {
		autoshot = {
			type = "group",
			name = "Auto Shot Bar",
			desc = "Options to customize the Auto Shot Bar.",
			order = 1,
			args = {
				use = {
					type = "toggle",
					name = "Toggle Use",
					desc = "Toggle the display of the Auto Shot Bar.",
					get = function(info) return ZHunterMod_Saved.ZAutoShot.on end,
					set = function(info, v) ZHunterMod_Saved.ZAutoShot.on = v end
				}
			}
		},
		other = {
			type = "group",
			name = "Other Features",
			desc = "Enable/disable various other features that are available.",
			order = 9,
			args = {
				antidaze = {
					type = "toggle",
					name = "Anti Daze",
					desc = "Toggle the display of the Aspect Bar.",
					get = function(info) return ZHunterMod_Saved["ZAntiDaze"]["on"] end,
					set = function(info, v) ZHunterMod_Saved["ZAntiDaze"]["on"] = v end
				}
			}
		}
	}
}
--/script SetBinding("J", "CLICK ZPet:LeftButton")
--/script local a,b,c=GetBindingAction("CLICK ZPet:LeftButton") Print(a) Print(b) Print(c)
--/script local a,b,c=GetBindingKey("CLICK ZPet:LeftButton") Print(a) Print(b) Print(c)

local function removeBindings(action)

end

do
--[[
	local buttons = {"ZAspect", "ZTrack", "ZTrap", "ZPet"}
	for i = 1, 4 do
		ZHunterModOptions.args[buttons[i].."Binds"] = {
			type = "group",
			name = buttons[i].." Bindings",
			desc = "Set keybindings to " .. buttons[i] .. " buttons.",
			order = 9 + i,
			args = {}
		}
		local tbl = ZHunterModOptions.args[buttons[i].."Binds"]
		for j = 1, 12 do
			local button = buttons[i] .. (j == 1 and "" or j)
			tbl.args["button"..j] = {
				type = "keybinding",
				order = j,
				name = buttons[i] .. " Button " .. j,
				desc = "Set the key binding for " .. buttons[i] .. ".",
				get = function(info)
					local key = GetBindingKey("CLICK " .. button .. ":LeftButton")
					return key
				end,
				set = function(info, v)
					SetBinding(v, "CLICK " .. button .. ":LeftButton")
					SaveBindings(GetCurrentBindingSet());
				end
			}
		end
	end
]]
end

LibStub("AceConfig-3.0"):RegisterOptionsTable("ZHunterMod", ZHunterModOptions)

function ZHunterModOptions_SetSpellOptions(name, tbl, spells)
	tbl.enable = {
		type = "toggle",
		name = "Enable", desc = "Enable or disable the button's use.",
		order = 1,
		get = function(info) return ZHunterMod_Saved[name].enabled end,
		set = function(info, v)
			ZHunterMod_Saved[name].enabled = v
			local frame = getglobal(name)
			if v then
				frame:SetCount(ZHunterMod_Saved[name].count)
				frame:Show()
			else
				frame:SetCount(0)
				frame:Hide()
			end
		end
	}
	tbl.size = {
		type = "range", min = 20, max = 50, step = 1,
		name = "Button Size", desc = "Changes the size of the spell buttons.",
		order = 2,
		get = function(info) return ZHunterMod_Saved[name].size end,
		set = function(info, v)
			ZHunterMod_Saved[name].size = v
			getglobal(name):SetSize(v)
		end
	}
	tbl.roundButton = {
		type = "toggle",
		name = "Round Button", desc = "Set the button border to be round.",
		order = 3,
		get = function(info) return ZHunterMod_Saved[name].roundButton end,
		set = function(info, v)
			ZHunterMod_Saved[name].roundButton = v
			getglobal(name):SetRoundButton(v)
		end
	}
	tbl.bgColor = {
		type = "color", hasAlpha = false,
		name = "Border Color", desc = "Set the color of the border.",
		order = 4,
		get = function(info) return ZHunterMod_Saved[name].bgColor.r, ZHunterMod_Saved[name].bgColor.g, ZHunterMod_Saved[name].bgColor.b end,
		set = function(info, r, g, b)
			ZHunterMod_Saved[name].bgColor.r = r
			ZHunterMod_Saved[name].bgColor.g = g
			ZHunterMod_Saved[name].bgColor.b = b
			getglobal(name):SetBackgroundColor(ZHunterMod_Saved[name].bgColor)
		end
	}
	tbl.count = {
		type = "range", min = 0, max = #spells + 1, step = 1,
		name = "Number of Buttons", desc = "Set the number of buttons to show on the bar.",
		order = 5,
		get = function(info) return ZHunterMod_Saved[name].count end,
		set = function(info, v)
			ZHunterMod_Saved[name].count = v
			getglobal(name):SetCount(v)
		end
	}
	tbl.perRow = {
		type = "range", min = 1, max = #spells + 1, step = 1,
		name = "Buttons Per Row", desc = "Set the number of rows on which to display the bar.",
		order = 6,
		get = function(info) return ZHunterMod_Saved[name].perRow end,
		set = function(info, v)
			ZHunterMod_Saved[name].perRow = v
			getglobal(name):SetPerRow(v)
		end
	}
	tbl.horizontal = {
		type = "select", style = "dropdown", values = horizontal,
		name = "Column Direction", desc = "Set whether columns expand to the left or right of eachother..",
		order = 7,
		get = function(info) return ZHunterMod_Saved[name].horizontal end,
		set = function(info, v)
			ZHunterMod_Saved[name].horizontal = v
			getglobal(name):SetHorizontal(v)
		end
	}
	tbl.vertical = {
		type = "select", style = "dropdown", values = vertical,
		name = "Row Direction", desc = "Set whether the rows will stack on the top or bottom of eachother.",
		order = 8,
		get = function(info) return ZHunterMod_Saved[name].vertical end,
		set = function(info, v)
			ZHunterMod_Saved[name].vertical = v
			getglobal(name):SetVertical(v)
		end
	}
	tbl.expandType = {
		type = "select", style = "dropdown", values = mouseEvents,
		name = "Expand Type", desc = "Set the event to make the bar expand.",
		order = 9,
		get = function(info) return ZHunterMod_Saved[name].expandType end,
		set = function(info, v)
			ZHunterMod_Saved[name].expandType = v
			getglobal(name):SetExpandType(v)
		end
	}
	for i = 1, #spells do
		tbl["button"..i] = {
			type = "select", style = "dropdown", values = spells,
			name = "Button "..i, desc = "Select which spell to use for this button.",
			order = 25 + i,
			get = function(info) return ZHunterMod_Saved[name].order[i] end,
			set = function(info, v)
				ZHunterMod_Saved[name].order[i] = v
				getglobal(name):UpdateSpells()
			end
		}
	end
end

function ZHunterModOptions_SetBroadcastOptions(name, tbl)
	tbl.print = {
		type = "toggle", tristate = true,
		name = "Print", desc = "Prints the message to your default chat frame.",
		order = 10,
		get = function(info) return ZHunterMod_Saved[name].print end,
		set = function(info, v) ZHunterMod_Saved[name].print = v end
	}
	tbl.yell = {
		type = "toggle", tristate = true,
		name = "Yell", desc = "Broadcasts the message through yells.",
		order = 11,
		get = function(info) return ZHunterMod_Saved[name].yell end,
		set = function(info, v) ZHunterMod_Saved[name].yell = v end
	}
	tbl.party = {
		type = "toggle", tristate = true,
		name = "Party", desc = "Broadcasts the message through party chat.",
		order = 12,
		get = function(info) return ZHunterMod_Saved[name].party end,
		set = function(info, v) ZHunterMod_Saved[name].party = v end
	}
	tbl.raid = {
		type = "toggle", tristate = true,
		name = "Raid", desc = "Broadcasts the message through raid chat.",
		order = 13,
		get = function(info) return ZHunterMod_Saved[name].raid end,
		set = function(info, v) ZHunterMod_Saved[name].raid = v end
	}
	tbl.raidWarning = {
		type = "toggle", tristate = true,
		name = "Raid Warning", desc = "Broadcasts the message through raid warnings.",
		order = 14,
		get = function(info) return ZHunterMod_Saved[name].raidWarning end,
		set = function(info, v) ZHunterMod_Saved[name].raidWarning = v end
	}
	tbl.channel = {
		type = "toggle", tristate = true,
		name = "Channel", desc = "Broadcasts the message through a custom channel.",
		order = 15,
		get = function(info) return ZHunterMod_Saved[name].channel end,
		set = function(info, v) ZHunterMod_Saved[name].channel = v end
	}
	tbl.channelNum = {
		type = "range", min = 1, max = 10, step = 1,
		name = "Channel Number", desc = "Set the channel number through which to broadcast the message.",
		order = 16,
		get = function(info) return ZHunterMod_Saved[name].channelNum end,
		set = function(info, v) ZHunterMod_Saved[name].channelNum = v end
	}
end