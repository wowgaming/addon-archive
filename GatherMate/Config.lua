local GatherMate = LibStub("AceAddon-3.0"):GetAddon("GatherMate")
local Config = GatherMate:NewModule("Config","AceConsole-3.0","AceEvent-3.0")
local Display = GatherMate:GetModule("Display")
local L = LibStub("AceLocale-3.0"):GetLocale("GatherMate", false)

-- Databroker support
local DataBroker = LibStub:GetLibrary("LibDataBroker-1.1",true)

--[[
	Code here for configuring the mod, and making the minimap button
]]

-- Setup keybinds (these need to be global strings to show up properly in ESC -> Key Bindings)
BINDING_HEADER_GatherMate = "GatherMate"
BINDING_NAME_TOGGLE_GATHERMATE_MINIMAPICONS = L["Keybind to toggle Minimap Icons"]

-- A helper function for keybindings
local KeybindHelper = {}
do
	local t = {}
	function KeybindHelper:MakeKeyBindingTable(...)
		for k in pairs(t) do t[k] = nil end
		for i = 1, select("#", ...) do
			local key = select(i, ...)
			if key ~= "" then
				tinsert(t, key)
			end
		end
		return t
	end
end


local prof_options = {
	["always"]          = L["Always show"],
	["with_profession"] = L["Only with profession"],
	["active"]          = L["Only while tracking"],
	["never"]           = L["Never show"],
}
local prof_options2 = { -- For Gas, which doesn't have tracking as a skill
	["always"]           = L["Always show"],
	["with_profession"]  = L["Only with profession"],
	["never"]            = L["Never show"],
}
local prof_options3 = {
	["always"]          = L["Always show"],
	["active"]          = L["Only while tracking"],
	["never"]           = L["Never show"],
}

local options = {}
local db
local imported = {}
-- setup the options, we need to reference GatherMate for this
options.type = "group"
options.name = "GatherMate"
options.get = function( k ) return db[k.arg] end
options.set = function( k, v ) db[k.arg] = v; Config:UpdateConfig(); end
options.args = {}
options.plugins = {}

-- Display Settings config tree
options.args.display = {
 	type = "group",
	name = L["Display Settings"],
	order = 1,
	args = {},
}
options.args.display.args.general = {
	type = "group",
	name = L["General"],
	order = 1,
	args = {
		showGroup = {
			type = "group",
			name = L["Show Databases"],
			guiInline = true,
			order = 1,
			get = function(k) return db.show[k.arg] end,
			set = function(k, v) db.show[k.arg] = v; Config:UpdateConfig(); end,
			args = {
				desc = {
					order = 0,
					type = "description",
					name = L["Selected databases are shown on both the World Map and Minimap."],
				},
				showMinerals = {
					order = 1,
					name = L["Show Mining Nodes"],
					desc = L["Toggle showing mining nodes."],
					type = "select",
					values = prof_options,
					arg = "Mining"
				},
				showHerbs = {
					order = 2,
					name = L["Show Herbalism Nodes"],
					desc = L["Toggle showing herbalism nodes."],
					type = "select",
					values = prof_options,
					arg = "Herb Gathering"
				},
				showFishes = {
					order = 3,
					name = L["Show Fishing Nodes"],
					desc = L["Toggle showing fishing nodes."],
					type = "select",
					values = prof_options,
					arg = "Fishing"
				},
				showGases = {
					order = 4,
					name = L["Show Gas Clouds"],
					desc = L["Toggle showing gas clouds."],
					type = "select",
					values = prof_options2,
					arg = "Extract Gas"
				},
				showTreasure = {
					order = 5,
					name = L["Show Treasure Nodes"],
					desc = L["Toggle showing treasure nodes."],
					type = "select",
					values = prof_options3,
					arg = "Treasure"
				},
			},
		},
		iconGroup = {
			type = "group",
			name = L["Icons"],
			guiInline = true,
			order = 2,
			args = {
				desc = {
					order = 0,
					type = "description",
					name = L["Control various aspects of node icons on both the World Map and Minimap."],
				},
				showMinimapIcons = {
					order = 1,
					name = L["Show Minimap Icons"],
					desc = L["Toggle showing Minimap icons."],
					type = "toggle",
					arg = "showMinimap",
				},
				showWorldMapIcons = {
					order = 2,
					name = L["Show World Map Icons"],
					desc = L["Toggle showing World Map icons."],
					type = "toggle",
					arg = "showWorldMap",
				},
				minimapTooltips = {
					order = 3,
					name = L["Minimap Icon Tooltips"],
					desc = L["Toggle showing Minimap icon tooltips."],
					type = "toggle",
					arg = "minimapTooltips",
					disabled = function() return not db.showMinimap end,
				},
				togglekey = {
					order = 4,
					name = L["Keybind to toggle Minimap Icons"],
					desc = L["Keybind to toggle Minimap Icons"],
					type = "keybinding",
					width = "double",
					get = function(info)
						return table.concat(KeybindHelper:MakeKeyBindingTable(GetBindingKey("TOGGLE_GATHERMATE_MINIMAPICONS")), ", ")
					end,
					set = function(info, key)
						if key == "" then
							local t = KeybindHelper:MakeKeyBindingTable(GetBindingKey("TOGGLE_GATHERMATE_MINIMAPICONS"))
							for i = 1, #t do
								SetBinding(t[i])
							end
						else
							local oldAction = GetBindingAction(key)
							local frame = LibStub("AceConfigDialog-3.0").OpenFrames["GatherMate"]
							if frame then
								if ( oldAction ~= "" and oldAction ~= "TOGGLE_GATHERMATE_MINIMAPICONS" ) then
									frame:SetStatusText(KEY_UNBOUND_ERROR:format(GetBindingText(oldAction, "BINDING_NAME_")))
								else
									frame:SetStatusText(KEY_BOUND)
								end
							end
							SetBinding(key, "TOGGLE_GATHERMATE_MINIMAPICONS")
						end
						SaveBindings(GetCurrentBindingSet())
					end,
				},
				space = {
					order = 5,
					name = "",
					desc = "",
					type = "description",
				},
				iconScale = {
					order = 6,
					name = L["Icon Scale"],
					desc = L["Icon scaling, this lets you enlarge or shrink your icons on both the World Map and Minimap."],
					type = "range",
					min = 0.5, max = 2, step = 0.01,
					arg = "scale",
				},
				iconAlpha = {
					order = 7,
					name = L["Icon Alpha"],
					desc = L["Icon alpha value, this lets you change the transparency of the icons. Only applies on World Map."],
					type = "range",
					min = 0.1, max = 1, step = 0.05,
					arg = "alpha",
				},
				minimapNodeRange = {
					order = 8,
					type = "toggle",
					name = L["Show Nodes on Minimap Border"],
					width = "double",
					desc = L["Shows more Nodes that are currently out of range on the minimap's border."],
					arg = "nodeRange",
				},
				tracking = {
					order = 9,
					name = L["Tracking Circle Color"],
					desc = L["Color of the tracking circle."],
					type = "group",
					guiInline = true,
					get = function(info)
						local t = db.trackColors[info.arg]
						return t.Red, t.Green, t.Blue, t.Alpha
					end,
					set = function(info, r, g, b, a)
						local t = db.trackColors[info.arg]
						t.Red = r
						t.Green = g
						t.Blue = b
						t.Alpha = a
						Config:UpdateConfig()
					end,
					args = {
						trackingColorMine = {
							order = 1,
							name = L["Mineral Veins"],
							desc = L["Color of the tracking circle."],
							type = "color",
							hasAlpha = true,
							arg = "Mining",
						},
						trackingColorHerb = {
							order = 2,
							name = L["Herb Bushes"],
							desc = L["Color of the tracking circle."],
							type = "color",
							hasAlpha = true,
							arg = "Herb Gathering",
						},
						trackingColorFish = {
							order = 3,
							name = L["Fishing"],
							desc = L["Color of the tracking circle."],
							type = "color",
							hasAlpha = true,
							arg = "Fishing",
						},
						trackingColorGas = {
							order = 4,
							name = L["Gas Clouds"],
							desc = L["Color of the tracking circle."],
							type = "color",
							hasAlpha = true,
							arg = "Extract Gas",
						},
						trackingColorTreasure = {
							order = 6,
							name = L["Treasure"],
							desc = L["Color of the tracking circle."],
							type = "color",
							hasAlpha = true,
							arg = "Treasure",							
						},
						space = {
							order = 7,
							name = "",
							desc = "",
							type = "description",
						},
						trackDistance = {
							order = 15,
							name = L["Tracking Distance"],
							desc = L["The distance in yards to a node before it turns into a tracking circle"],
							type = "range",
							min = 50, max = 240, step = 5,
							get = options.get,
							set = options.set,
							arg = "trackDistance",
						},
						trackShow = {
							order = 20,
							name = L["Show Tracking Circle"],
							desc = L["Toggle showing the tracking circle."],
							type = "select",
							get = options.get,
							set = options.set,
							values = prof_options,
							arg = "trackShow",
						},
					},
				},
			},
		},
	},
}

-- Setup some storage arrays by db to sort node names and zones alphabetically
local sortedFilter = setmetatable({}, {__index = function(t, k)
	local new = {}
	if k == "zones" then
		for name, zonetable in pairs(GatherMate.zoneData) do
			new[name] = name
		end
	else
		local minHarvestTable = GatherMate.nodeMinHarvest[k]
		for name, id in pairs(GatherMate.nodeIDs[k]) do
			local lvl = minHarvestTable[id]
			if lvl then
				new[name] = "("..lvl..") "..name
			else
				new[name] = name
			end
		end
	end
	rawset(t, k, new)
	return new
end})

-- Setup some helper functions
local ConfigFilterHelper = {}
function ConfigFilterHelper:SelectAll(info)
	local db = db.filter[info.arg]
	local nids = GatherMate.nodeIDs[info.arg]
	for k, v in pairs(nids) do
		db[v] = true
	end
	Config:UpdateConfig()
end
function ConfigFilterHelper:SelectNone(info)
	local db = db.filter[info.arg]
	local nids = GatherMate.nodeIDs[info.arg]
	for k, v in pairs(nids) do
		db[v] = false
	end
	Config:UpdateConfig()
end
function ConfigFilterHelper:SetState(info, k, state)
	db.filter[info.arg][GatherMate.nodeIDs[info.arg][k]] = state
	Config:UpdateConfig()
end
function ConfigFilterHelper:GetState(info, k)
	return db.filter[info.arg][GatherMate.nodeIDs[info.arg][k]]
end

local ImportHelper = {}

function ImportHelper:GetImportStyle(info,k)
	return db["importers"][info.arg].Style
end
function ImportHelper:SetImportStyle(info,k,state)
	db["importers"][info.arg].Style = k
end
function ImportHelper:GetImportDatabase(info,k)
	return db["importers"][info.arg].Databases[k]
end
function ImportHelper:SetImportDatabase(info,k,state)
	db["importers"][info.arg].Databases[k] = state
end
function ImportHelper:GetAutoImport(info, k)
	return db["importers"][info.arg].autoImport
end
function ImportHelper:SetAutoImport(info,state)
	db["importers"][info.arg].autoImport = state
end
function ImportHelper:GetBCOnly(info,k)
	return db["importers"][info.arg].bcOnly
end
function ImportHelper:SetBCOnly(info,state)
	db["importers"][info.arg].bcOnly = state
end
function ImportHelper:GetExpacOnly(info,k)
	return db["importers"][info.arg].expacOnly
end
function ImportHelper:SetExpacOnly(info,state)
	db["importers"][info.arg].expacOnly = state
end
function ImportHelper:GetExpac(info,k)
	return db["importers"][info.arg].expac
end
function ImportHelper:SetExpac(info,state)
	db["importers"][info.arg].expac = state
end

local commonFiltersDescTable = {
	order = 0,
	type = "description",
	name = L["Filter_Desc"],
}
options.args.display.args.filters = {
	type = "group",
	name = L["Filters"],
	order = 2,
	--childGroups = "tab", -- this makes the filter tree become inline tabs
	handler = ConfigFilterHelper,
	args = {},
}
options.args.display.args.filters.args.herbs = {
	type = "group",
	name = L["Herb filter"],
	desc = L["Select the herb nodes you wish to display."],
	args = {
		desc = commonFiltersDescTable,
		select_all = {
			order = 1,
			name = L["Select All"],
			desc = L["Select all nodes"],
			type = "execute",
			func = "SelectAll",
			arg = "Herb Gathering",
		},
		select_none = {
			order = 2,
			desc = L["Clear node selections"],
			name = L["Select None"],
			type = "execute",
			func = "SelectNone",
			arg = "Herb Gathering",
		},
		herblist = {
			order = 3,
			name = L["Herb Bushes"],
			type = "multiselect",
			values = sortedFilter["Herb Gathering"],
			set = "SetState",
			get = "GetState",
			arg = "Herb Gathering",
		},
	},
}
options.args.display.args.filters.args.mines = {
	type = "group",
	name = L["Mine filter"],
	desc = L["Select the mining nodes you wish to display."],
	args = {
		desc = commonFiltersDescTable,
		select_all = {
			order = 1,
			name = L["Select All"],
			desc = L["Select all nodes"],
			type = "execute",
			func = "SelectAll",
			arg = "Mining",
		},
		select_none = {
			order = 2,
			desc = L["Clear node selections"],
			name = L["Select None"],
			type = "execute",
			func = "SelectNone",
			arg = "Mining",
		},
		minelist = {
			order = 3,
			name = L["Mineral Veins"],
			type = "multiselect",
			values = sortedFilter["Mining"],
			set = "SetState",
			get = "GetState",
			arg = "Mining",
		},
	},
}
options.args.display.args.filters.args.fish = {
	type = "group",
	name = L["Fish filter"],
	args = {
		desc = commonFiltersDescTable,
		select_all = {
			order = 1,
			name = L["Select All"],
			desc = L["Select all nodes"],
			type = "execute",
			func = "SelectAll",
			arg = "Fishing",
		},
		select_none = {
			order = 2,
			desc = L["Clear node selections"],
			name = L["Select None"],
			type = "execute",
			func = "SelectNone",
			arg = "Fishing",
		},
		fishlist = {
			order = 3,
			name = L["Fishes"],
			type = "multiselect",
			desc = L["Select the fish nodes you wish to display."],
			values = sortedFilter["Fishing"],
			set = "SetState",
			get = "GetState",
			arg = "Fishing",
		},
	},
}
options.args.display.args.filters.args.gas = {
	type = "group",
	name = L["Gas filter"],
	args = {
		desc = commonFiltersDescTable,
		select_all = {
			order = 1,
			name = L["Select All"],
			desc = L["Select all nodes"],
			type = "execute",
			func = "SelectAll",
			arg = "Extract Gas",
		},
		select_none = {
			order = 2,
			name = L["Select None"],
			desc = L["Clear node selections"],
			type = "execute",
			func = "SelectNone",
			arg = "Extract Gas",
		},
		gaslist = {
			order = 3,
			name = L["Gas Clouds"],
			desc = L["Select the gas clouds you wish to display."],
			type = "multiselect",
			values = sortedFilter["Extract Gas"],
			set = "SetState",
			get = "GetState",
			arg = "Extract Gas",
		},
	},
}
options.args.display.args.filters.args.treasure = {
	type = "group",
	name = L["Treasure filter"],
	args = {
		desc = commonFiltersDescTable,
		select_all = {
			order = 1,
			name = L["Select All"],
			desc = L["Select all nodes"],
			type = "execute",
			func = "SelectAll",
			arg = "Treasure",
		},
		select_none = {
			order = 2,
			name = L["Select None"],
			desc = L["Clear node selections"],
			type = "execute",
			func = "SelectNone",
			arg = "Treasure",
		},
		gaslist = {
			order = 3,
			name = L["Treasure"],
			desc = L["Select the treasure you wish to display."],
			type = "multiselect",
			values = sortedFilter["Treasure"],
			set = "SetState",
			get = "GetState",
			arg = "Treasure",
		},
	},
}

local selectedDatabase, selectedNode, selectedZone = "Extract Gas", 0, nil

-- Cleanup config tree
options.args.cleanup = {
 	type = "group",
	name = L["Database Maintenance"],
	order = 5,
	args = {
		cleanup = {
			order = 20,
			name = L["Cleanup Database"],
			type = "group",
			args = {
				cleanup = {
					order = 10,
					name = L["Cleanup Database"],
					type = "group",
					guiInline = true,
					args = {
						desc = {
							order = 0,
							type = "description",
							name = L["Cleanup_Desc"],
						},
						cleanup = {
							name = L["Cleanup Database"],
							desc = L["Cleanup your database by removing duplicates. This takes a few moments, be patient."],
							type = "execute",
							handler = GatherMate,
							func = "CleanupDB",
							order = 20,
						},
					},
				},
				deleteSelective = {
					order = 20,
					name = L["Delete Specific Nodes"],
					type = "group",
					guiInline = true,
					args = {
						desc = {
							order = 0,
							type = "description",
							name = L["DELETE_SPECIFIC_DESC"],
						},
						selectDB = {
							order = 30,
							name = L["Select Database"],
							desc = L["Select Database"],
							type = "select",
							values = {
								["Fishing"] = L["Fishes"],
								["Treasure"] = L["Treasure"],
								["Herb Gathering"] = L["Herb Bushes"],
								["Mining"] = L["Mineral Veins"],
								["Extract Gas"] = L["Gas Clouds"],
							},
							get = function() return selectedDatabase end,
							set = function(k, v)
								selectedDatabase = v
								selectedNode = 0
							end,
						},
						selectNode = {
							order = 40,
							name = L["Select Node"],
							desc = L["Select Node"],
							type = "select",
							values = function()
								return sortedFilter[selectedDatabase]
							end,
							get = function() return selectedNode end,
							set = function(k, v) selectedNode = v end,
						},
						selectZone = {
							order = 50,
							name = L["Select Zone"],
							desc = L["Select Zone"],
							type = "select",
							values = sortedFilter["zones"],
							get = function() return selectedZone end,
							set = function(k, v) selectedZone = v end,
						},
						delete = {
							order = 60,
							name = L["Delete"],
							desc = L["Delete selected node from selected zone"],
							type = "execute",
							confirm = true,
							confirmText = L["Are you sure you want to delete all of the selected node from the selected zone?"],
							func = function()
								if selectedZone and selectedNode ~= 0 then
									GatherMate:DeleteNodeFromZone(selectedDatabase, GatherMate.nodeIDs[selectedDatabase][selectedNode], selectedZone)
								end
							end,
							disabled = function()
								return selectedNode == 0 or selectedZone == nil
							end,
						},
					},
				},
				delete = {
					order = 30,
					name = L["Delete Entire Database"],
					type = "group",
					guiInline = true,
					func = function(info)
						GatherMate:ClearDB(info.arg)
					end,
					args = {
						desc = {
							order = 0,
							type = "description",
							name = L["DELETE_ENTIRE_DESC"],
						},
						Mine = {
							order = 5,
							name = L["Mineral Veins"],
							desc = L["Delete Entire Database"],
							type = "execute",
							arg = "Mining",
							confirm = true,
							confirmText = L["Are you sure you want to delete all nodes from this database?"],
						},
						Herb = {
							order = 5,
							name = L["Herb Bushes"],
							desc = L["Delete Entire Database"],
							type = "execute",
							arg = "Herb Gathering",
							confirm = true,
							confirmText = L["Are you sure you want to delete all nodes from this database?"],
						},
						Fish = {
							order = 5,
							name = L["Fishes"],
							desc = L["Delete Entire Database"],
							type = "execute",
							arg = "Fishing",
							confirm = true,
							confirmText = L["Are you sure you want to delete all nodes from this database?"],
						},
						Gas = {
							order = 5,
							name = L["Gas Clouds"],
							desc = L["Delete Entire Database"],
							type = "execute",
							arg = "Extract Gas",
							confirm = true,
							confirmText = L["Are you sure you want to delete all nodes from this database?"],
						},
						Treasure = {
							order = 5,
							name = L["Treasure"],
							desc = L["Delete Entire Database"],
							type = "execute",
							arg = "Treasure",					
							confirm = true,
							confirmText = L["Are you sure you want to delete all nodes from this database?"],
						},
					},
				},
			},
		},
		desc = {
			order = 0,
			type = "description",
			name = L["Cleanup_Desc"],
		},
		cleanup_range = {
			order = 10,
			name = L["Cleanup radius"],
			type = "group",
			guiInline = true,
			get = function(info)
				return db.cleanupRange[info.arg]
			end,
			set = function(info, v)
				db.cleanupRange[info.arg] = v
			end,
			args = {
				desc = {
					order = 0,
					type = "description",
					name = L["CLEANUP_RADIUS_DESC"],
				},
				Mine = {
					order = 5,
					name = L["Mineral Veins"],
					desc = L["Cleanup radius"],
					type = "range",
					min = 0, max = 30, step = 1,
					arg = "Mining",
				},
				Herb = {
					order = 5,
					name = L["Herb Bushes"],
					desc = L["Cleanup radius"],
					type = "range",
					min = 0, max = 30, step = 1,
					arg = "Herb Gathering",
				},
				Fish = {
					order = 5,
					name = L["Fishes"],
					desc = L["Cleanup radius"],
					type = "range",
					min = 0, max = 30, step = 1,
					arg = "Fishing",
				},
				Gas = {
					order = 5,
					name = L["Gas Clouds"],
					desc = L["Cleanup radius"],
					type = "range",
					min = 0, max = 100, step = 1,
					arg = "Extract Gas",
				},
				Treasure = {
					order = 5,
					name = L["Treasure"],
					desc = L["Cleanup radius"],
					type = "range",
					min = 0, max = 30, step = 1,
					arg = "Treasure",					
				}
			},
		},
		dblocking = {
			order = 11,
			name = L["Database Locking"],
			type = "group",
			guiInline = true,
			get = function(info)
				return db.dbLocks[info.arg]
			end,
			set = function(info,v)
				db.dbLocks[info.arg] = v
			end,
			args = {
				desc = {
					order = 0,
					type = "description",
					name = L["DATABASE_LOCKING_DESC"],
				},
				Mine = {
					order = 5,
					name = L["Mineral Veins"],
					desc = L["Database locking"],
					type = "toggle",
					arg = "Mining",
				},
				Herb = {
					order = 5,
					name = L["Herb Bushes"],
					desc = L["Database locking"],
					type = "toggle",
					arg = "Herb Gathering",
				},
				Fish = {
					order = 5,
					name = L["Fishes"],
					desc = L["Database locking"],
					type = "toggle",
					arg = "Fishing",
				},
				Gas = {
					order = 5,
					name = L["Gas Clouds"],
					desc = L["Database locking"],
					type = "toggle",
					arg = "Extract Gas",
				},
				Treasure = {
					order = 5,
					name = L["Treasure"],
					desc = L["Database locking"],
					type = "toggle",
					arg = "Treasure",					
				}				
			}
		},
	},
}


-- GatherMateData Import config tree
options.args.importing = {
 	type = "group",
	name = L["Import Data"],
	order = 10,
	args = {},
}
ImportHelper.db_options = {
	["Merge"] = L["Merge"],
	["Overwrite"] = L["Overwrite"]
}
ImportHelper.db_tables = {
	["Herbs"] = L["Herbalism"],
	["Mines"] = L["Mining"],
	["Gases"] = L["Gas Clouds"],
	["Fish"] = L["Fishing"],
	["Treasure"] = L["Treasure"],
}
ImportHelper.expac_data = {
	["TBC"] = L["The Burning Crusades"],
	["WRATH"] = L["Wrath of the Lich King"],
}
imported["GatherMate_Data"] = false
options.args.importing.args.GatherMateData = {
 	type = "group",
	name = "GatherMateData", -- addon name to import from, don't localize
	handler = ImportHelper,
	disabled = function()
		local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo("GatherMate_Data")
		-- disable if the addon is not enabled, or
		-- disable if there is a reason why it can't be loaded ("MISSING" or "DISABLED")
		return not enabled or (reason ~= nil)
	end,
	args = {
		desc = {
			order = 0,
			type = "description",
			name = L["Importing_Desc"],
		},
		loadType = {
			order = 1,
			name = L["Import Style"],
			desc = L["Merge will add GatherMateData to your database. Overwrite will replace your database with the data in GatherMateData"],
			type = "select",
			values = ImportHelper.db_options,
			set = "SetImportStyle",
			get = "GetImportStyle",
			arg = "GatherMate_Data",
		},
		loadDatabase = {
			order = 2,
			name = L["Databases to Import"],
			desc = L["Databases you wish to import"],
			type = "multiselect",
			values = ImportHelper.db_tables,
			set = "SetImportDatabase",
			get = "GetImportDatabase",
			arg = "GatherMate_Data",
		},
		stylebox = {
			order = 4,
			type = "group",
			name = L["Import Options"],
			inline = true,
			args = {
				loadExpacToggle = {
					order = 4,
					name = L["Expansion Data Only"],
					type = "toggle",
					get = "GetExpacOnly",
					set = "SetExpacOnly",
					arg = "GatherMate_Data"
				},
				loadExpansion = {
					order = 4,
					name = L["Expansion"],
					desc = L["Only import selected expansion data from WoWDB"],
					type = "select",
					get  = "GetExpac",
					set  = "SetExpac",
					values = ImportHelper.expac_data,
					arg  = "GatherMate_Data",
				},				
				loadAuto = {
					order = 5,
					name = L["Auto Import"],
					desc = L["Automatically import when ever you update your data module, your current import choice will be used."],
					type = "toggle",
					get = "GetAutoImport",
					set = "SetAutoImport",
					arg = "GatherMate_Data",
				},
			}
		},
		loadData = {
			order = 8,
			name = L["Import GatherMateData"],
			desc = L["Load GatherMateData and import the data to your database."],
			type = "execute",
			func = function() 
				local loaded, reason = LoadAddOn("GatherMate_Data")
				local GatherMateData = LibStub("AceAddon-3.0"):GetAddon("GatherMate_Data")
				if loaded then
					local dataVersion = tonumber(GetAddOnMetadata("GatherMate_Data", "X-Generated-Version"):match("%d+"))
					local filter = nil
					if db.importers["GatherMate_Data"].expacOnly then
						filter = db.importers["GatherMate_Data"].expac
					end
					GatherMateData:PerformMerge(db.importers["GatherMate_Data"].Databases,db.importers["GatherMate_Data"].Style,filter)
					GatherMateData:CleanupImportData()
					Config:Print(L["GatherMateData has been imported."])
					Config:SendMessage("GatherMateConfigChanged")
					db["importers"]["GatherMate_Data"]["lastImport"] = dataVersion
					imported["GatherMate_Data"] = true
				else
					Config:Print(L["Failed to load GatherMateData due to "]..reason)
				end
			end,
			disabled = function()
				local cm = 0
				if db["importers"]["GatherMate_Data"].Databases["Mines"] then cm = 1 end
				if db["importers"]["GatherMate_Data"].Databases["Herbs"] then cm = 1 end
				if db["importers"]["GatherMate_Data"].Databases["Gases"] then cm = 1 end
				if db["importers"]["GatherMate_Data"].Databases["Fish"] then cm = 1 end
				if db["importers"]["GatherMate_Data"].Databases["Treasure"] then cm = 1 end
				return imported["GatherMate_Data"] or (cm == 0 and not imported["GatherMate_Data"])
			end,
		}
	},
}

options.args.faq_group = {
	type = "group",
	name = L["FAQ"],
	desc = L["Frequently Asked Questions"],
	order = -1,
	args = {
		header = {
			type = "header",
			name = L["Frequently Asked Questions"],
			order = 0,
		},
		desc = {
			type = "description",
			name = L["FAQ_TEXT"],
			order = 1,
		},
	},
}


--[[
	Initialize the Config System
]]

function Config:OnInitialize()
	db = GatherMate.db.profile
	options.plugins["profiles"] = { profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(GatherMate.db) }
	self.options = options
	self.importHelper = ImportHelper
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("GatherMate", options)
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("GatherMate", "GatherMate")
	self:RegisterChatCommand("gathermate", function() LibStub("AceConfigDialog-3.0"):Open("GatherMate") end )
	self:RegisterMessage("GatherMateConfigChanged")
	if DataBroker then
		local launcher = DataBroker:NewDataObject("GatherMate", {
		    type = "launcher",
		    icon = "Interface\\AddOns\\GatherMate\\Artwork\\Icon.tga",
		    OnClick = function(clickedframe, button) LibStub("AceConfigDialog-3.0"):Open("GatherMate") end,
		})
	end
end

function Config:OnEnable()
	self:CheckAutoImport()	
end

function Config:UpdateConfig()
	self:SendMessage("GatherMateConfigChanged")
end

function Config:GatherMateConfigChanged()
	db = GatherMate.db.profile
end

function Config:CheckAutoImport()
	for k,v in pairs(db.importers) do
		local verline = GetAddOnMetadata(k, "X-Generated-Version")
		if verline and v["autoImport"] then 
			local dataVersion = tonumber(verline:match("%d+"))
			if dataVersion and dataVersion > v["lastImport"] then
				local loaded, reason = LoadAddOn(k)
				local addon = LibStub("AceAddon-3.0"):GetAddon(k)
				if loaded then
					local filter = nil
					if v.expacOnly then
						filter = v.expac
					end
					addon:PerformMerge(v.Databases,v.Style,filter)
					addon:CleanupImportData()
					imported[k] = true
					Config:SendMessage("GatherMateConfigChanged")
					v["lastImport"] = dataVersion
					Config:Print(L["Auto import complete for addon "]..k)
				end
			end
		end
	end
end

-- Allows an external import module to insert their aceopttable into the Importing tree
-- returns a reference to the saved variables state for the addon
function Config:RegisterImportModule(moduleName, optionsTable)
	options.args.importing.args[moduleName] = optionsTable
	return db.importers[moduleName]
end
-- Allows an external module to insert their aceopttable
function Config:RegisterModule(moduleName, optionsTable)
	options.args[moduleName] = optionsTable
end
