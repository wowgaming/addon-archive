local EveryQuest = LibStub("AceAddon-3.0"):GetAddon("EveryQuest")
local addon = EveryQuest
local L = LibStub("AceLocale-3.0"):GetLocale("EveryQuest")
local db, dbpc
local options, moduleOptions = nil, {}
local sortcommon = {
	Weight = {
		type = 'range',
		name = L["Weight"],
		min = -10,
		max = 10,
		step = 1,
		order = 3,
	},
	Dir = {
		type = 'select',
		name = L["Direction"],
		style = "dropdown",
		values = { -- A hack to sort them in the menu
			L["Ascending"],
			L["Descending"],
		},
		order = 4,
	},
}
local function getOptions()
	
	if not options then
		options = { 
			type='group',
			name = L["EveryQuest"],
			get = function(info) return db[ info[#info] ] end,
			set = function(info, value) db[ info[#info] ] = value end,
			args = {
				General = {
					order = 1,
					type = "group",
					name = L["General Settings"],
					desc = L["General Settings"],
					args = {
						intro = {
							order = 1,
							type = "description",
							name = L["EQ_DESC"],
						},
						track = {
							order = 2,
							type = 'toggle',
							name = L["Track Zone"],
							desc = L["Track zone changes and update the EveryQuest list for that zone"],
							disabled = function() return db.savezone end,
						},
						savezone = {
							order = 3,
							type = 'toggle',
							name = L["Save Zone"],
							desc = L["Saves which zone you where last looking at to load upon login"],
							disabled = function() return db.track end,
						},
						locallist = {
							order = 4,
							type = 'toggle',
							name = L["Localized Quest List"],
							desc = L["Note: Stores localized quest titles in the global database"],
							set = function(info, value) db[ info[#info] ] = value EveryQuest:UpdateFrame() end,
						},
						locallist_help = {
							order = 5,
							type = "description",
							name = L["EQ_LOCALLIST"],
						},
						header = {
							order = 6,
							type = 'header',
							name = L["Other"],
						},
						debug = {
							order = 7,
							type = 'toggle',
							name = L["Show Debugging Messages"],
							desc = L["Show Debugging Messages - *WARNING* Spams your default chat frame"],
							--set = function(newval) db.profile.debug = not db.profile.debug end,
							--get = function() return db.profile.debug end,
							width = "double",
						},
						--[[upgrade = {
							order = 6,
							type = 'execute',
							name = L["Upgrade DB"],
							desc = L["Upgrade the Database from the old format"],
							func = function()
								StaticPopup_Show ("EVERYQUEST_UPGRADEDB")
							end,
							disabled = function()
								local disabled
								if dbpc.QuestHistory == nil then disabled = true else disabled = false end
								if EveryQuestDBPC ~= nil then
									for profilename,profile in pairs(EveryQuestDBPC) do 
										addon:Debug(tostring(profilename) .. " - " .. tostring(profile))
										if profile.QuestHistory ~= nil and not profile.upgraded then
											disabled = false
										else
											disabled = true
										end
									end
								end
								return disabled
							end,
							order = -2,
						},]]
						purgeold = {
							order = 8,
							type = 'execute',
							name = L["Purge Old data"],
							desc = L["Purge Old database data, generally used after running upgrade"],
							func = function()
								StaticPopup_Show ("EVERYQUEST_PURGEOLD")
							end,
							order = -2,
						}
					},
				},
				Filters = {
					order = 2,
					type = "group",
					name = L["Filters"],
					get = function(info) return dbpc.filters[ info[#info] ] end,
					set = function(info, value) dbpc.filters[ info[#info] ] = value EveryQuest:UpdateFrame() end,
					args = {
						intro = {
							order = 1,
							type = "description",
							name = L["Configure filtering options for the quest list. These settings are character specific."],
						},
						UseableFilters = {
							get = function(info) return dbpc.enabledfilters[ info[#info] ] end,
							set = function(info, value) dbpc.enabledfilters[ info[#info] ] = value EveryQuest:UpdateFrame() end,
							type = "group",
							order = 2,
							guiInline = true,
							name = L["Enable Filtering"],
							args = {
								Faction = {
									type = 'toggle',
									name = L["Faction Filter"],
								},
								Level = {
									type = 'toggle',
									name = L["Level Filter"],
								},
								Type = {
									type = 'toggle',
									name = L["Type Filter"],
								},
								Status = {
									type = 'toggle',
									name = L["Status Filter"],
								},
							},
						},
						Faction = {
							type = "group",
							order = 2,
							guiInline = true,
							disabled = function() return not dbpc.enabledfilters.Faction end,
							name = L["Show quests for specific faction"],
							desc = L["Show quests for specific faction"],
							args = {
								Alliance = {
									type = 'toggle',
									name = L["Alliance"],
									desc = L["Shows Alliance Quests"],
								},
								Horde = {
									type = 'toggle',
									name = L["Horde"],
									desc = L["Shows Horde Quests"],
								},
								SideBoth = {
									type = 'toggle',
									name = L["Both Factions"],
									desc = L["Shows quests that are available to both factions"],
								},
								SideNone = {
									type = 'toggle',
									name = L["No Side/No Data"],
									desc = L["Shows quests that don't have a side or don't have data for a specific side"],
								},
							},
						},
						Status = {
							type = "group",
							order = 3,
							guiInline = true,
							disabled = function() return not dbpc.enabledfilters.Status end,
							name = L["Control the display of specific quest statuses"],
							desc = L["Control the display of specific quest statuses"],
							args = {
								TurnedIn = {
									order = 1,
									type = 'toggle',
									name = addon:Colorize(EQ_TextColors["s2"].hex, L["Turned In Quests"]),
									desc = L["Shows quests turned back into NPCs"],
									width = "double",
								},
								Completed = {
									order = 2,
									type = 'toggle',
									name = addon:Colorize(EQ_TextColors["s1"].hex, L["Completed Quests"]),
									desc = L["Shows completed quests still in your questlog"],
									width = "double",
								},
								InProgress = {
									order = 3,
									type = 'toggle',
									name = addon:Colorize(EQ_TextColors["s0"].hex, L["Quests In Progress"]),
									desc = L["Shows quests that you are on but not completed"],
									width = "double",
								},
								FailedAbandoned = {
									order = 4,
									type = 'toggle',
									name = addon:Colorize(EQ_TextColors["s-1"].hex, L["Failed or Abandoned Quests"]),
									desc = L["Shows quests that you have failed or abandoned"],
									width = "double",
								},
								Unknown = {
									order = 5,
									type = 'toggle',
									name = addon:Colorize(EQ_TextColors["unknown"].hex, L["Unknown Status"]),
									desc = L["Shows quests you haven't seen before"],
									width = "double",
								},
								Ignored = {
									order = 6,
									type = 'toggle',
									name = addon:Colorize(EQ_TextColors["ignored"].hex, L["Ignored Quests"]),
									desc = L["Shows quests you've ignored"],
									width = "double",
								},
								example = {
									order = 7,
									type = "description",
									name = L["Example for Ignored quest: Some quests are still in Wowhead's database but are not attainable ingame anymore. Ignore them to hide them from the list."],
									width = "double",
								},
							},
						},
						Level = {
							type = "group",
							order = 4,
							guiInline = true,
							disabled = function() return not dbpc.enabledfilters.Level end,
							name = L["Filter Quests by Level"],
							args = {
								MinLevel = {
									order = 1,
									type = 'range',
									name = L["Minimum Level"],
									set = function(info, value) dbpc.filters[ info[#info] ] = value options.args.Filters.args.Level.args.MaxLevel.min = value EveryQuest:UpdateFrame() end,
									min = 0,
									max = 80,
									step = 1,
									width = "double",
								},
								MaxLevel = {
									order = 2,
									type = 'range',
									name = L["Maximum Level"],
									set = function(info, value) dbpc.filters[ info[#info] ] = value options.args.Filters.args.Level.args.MinLevel.max = value EveryQuest:UpdateFrame() end,
									min = 0,
									max = 80,
									step = 1,
									width = "double",
								},
							},
						},
						Type = {
							type = "group",
							order = 4,
							guiInline = true,
							disabled = function() return not dbpc.enabledfilters.Type end,
							name = L["Filter Quests by Type"],
							args = {
								NormalQuest = {
									order = 1,
									type = 'toggle',
									name = L["Normal Quests"],
									desc = L["Shows normal Blizzard soloable quests"],
								},
								GroupQuest = {
									order = 2,
									type = 'toggle',
									name = L["Group Quests"],
									desc = L["Shows 'group suggested' quests"],
								},
								DailyQuest = {
									order = 3,
									type = 'toggle',
									name = L["Daily Quests"],
									desc = L["Shows daily quests"],
								},
								WeeklyQuest = {
									order = 4,
									type = 'toggle',
									name = L["Weekly Quests"],
									desc = L["Shows weekly quests"],
								},
								DungeonQuest = {
									order = 5,
									type = 'toggle',
									name = L["Dungeon Quests"],
									desc = L["Shows dungeon quests"],
								},
								HeroicQuest = {
									order = 6,
									type = 'toggle',
									name = L["Heroic Quests"],
									desc = L["Shows heroic quests"],
								},
								RaidQuest = {
									order = 7,
									type = 'toggle',
									name = L["Raid Quests"],
									desc = L["Shows 'raid suggested' quests"],
								},
								PvpQuest = {
									order = 8,
									type = 'toggle',
									name = L["PvP Quests"],
									desc = L["Shows PVP quests"],
								},
							},
						},
					},
				},
				Sort = {
					order = 2,
					type = "group",
					name = L["List Order"],
					args = {
						intro = {
							order = 1,
							type = "description",
							name = L["Customize how your quest list is sorted.  Higher Weight moves the items to the top of the list, lower weight goes to the bottom.  Sort order Ascending: A-Z 0-9, Descending: Z-A, 9-0."],
						},
						--[[UseableSorters = {
							get = function(info) return dbpc.enabledsort[ info[#info] ] end,
							set = function(info, value) dbpc.enabledsort[ info[#info] ] = value EveryQuest:UpdateSortList() EveryQuest:UpdateFrame() end,
							type = "group",
							order = 2,
							guiInline = true,
							name = L["Enable Order Rules"],
							args = {
								n = {
									type = 'toggle',
									name = L["Order By Name"],
								},
								l = {
									type = 'toggle',
									name = L["Order By Level"],
								},
								t = {
									type = 'toggle',
									name = L["Order By Type"],
								},
								d = {
									type = 'toggle',
									name = L["Order By Is Daily"],
								},
								w = {
									type = 'toggle',
									name = L["Order By Is Weekly"],
								},
							},
						},]]
						w = {
							type = "group",
							order = 3,
							guiInline = true,
							--disabled = function() return not dbpc.enabledsort.w end,
							name = L["Order by Weekly"],
							get = function(info) return dbpc.sort["w"][ info[#info] ] end,
							set = function(info, value) dbpc.sort["w"][ info[#info] ] = value EveryQuest:UpdateSortList() EveryQuest:UpdateFrame() end,
							args = sortcommon,
						},
						d = {
							type = "group",
							order = 4,
							guiInline = true,
							--disabled = function() return not dbpc.enabledsort.d end,
							name = L["Order by Daily"],
							get = function(info) return dbpc.sort["d"][ info[#info] ] end,
							set = function(info, value) dbpc.sort["d"][ info[#info] ] = value EveryQuest:UpdateSortList() EveryQuest:UpdateFrame() end,
							args = sortcommon,
						},
						t = {
							type = "group",
							order = 5,
							guiInline = true,
							--disabled = function() return not dbpc.enabledsort.t end,
							name = L["Order by Type"],
							get = function(info) return dbpc.sort["t"][ info[#info] ] end,
							set = function(info, value) dbpc.sort["t"][ info[#info] ] = value EveryQuest:UpdateSortList() EveryQuest:UpdateFrame() end,
							args = sortcommon,
						},
						l = {
							type = "group",
							order = 6,
							guiInline = true,
							--disabled = function() return not dbpc.enabledsort.l end,
							name = L["Order by Level"],
							get = function(info) return dbpc.sort["l"][ info[#info] ] end,
							set = function(info, value) dbpc.sort["l"][ info[#info] ] = value EveryQuest:UpdateSortList() EveryQuest:UpdateFrame() end,
							args = sortcommon,
						},
						n = {
							type = "group",
							order = 7,
							guiInline = true,
							--disabled = function() return not dbpc.enabledsort.n end,
							name = L["Order by Name"],
							get = function(info) return dbpc.sort["n"][ info[#info] ] end,
							set = function(info, value) dbpc.sort["n"][ info[#info] ] = value EveryQuest:UpdateSortList() EveryQuest:UpdateFrame() end,
							args = sortcommon,
						},
					},
				},
			},
		}
		for k,v in pairs(moduleOptions) do
			options.args[k] = (type(v) == "function") and v() or v
		end
	end
	
	return options
end

local function optFunc() 
	-- open the profiles tab before, so the menu expands
	InterfaceOptionsFrame_OpenToCategory(addon.optionsFrames.Profiles)
	InterfaceOptionsFrame_OpenToCategory(addon.optionsFrames.EveryQuest)
end

function addon:SetupOptions()
	InterfaceOptionsFrame:SetFrameStrata("DIALOG") 
	
	self.optionsFrames = {}
	--self.optionsFrames = {}
	--LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("EveryQuest", options)
	--local ACD3 = LibStub("AceConfigDialog-3.0")
	--self.optionsFrames.EveryQuest = ACD3:AddToBlizOptions("EveryQuest", "EveryQuest", nil, "General")
	
	-- setup options table Mapster
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("EveryQuest", getOptions)
	self.optionsFrames.EveryQuest = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("EveryQuest", L["EveryQuest"], nil, "General")
	self.optionsFrames.Filters = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("EveryQuest", L["Filters"], "EveryQuest", "Filters")
	self.optionsFrames.Sort = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("EveryQuest", L["List Order"], "EveryQuest", "Sort")
	--self:RegisterModuleOptions("Profiles", LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db), "Profiles")
	
	LibStub("AceConsole-3.0"):RegisterChatCommand( "everyquest", function() addon:Toggle() end)
	
	db = EveryQuest.db.profile
	dbpc = EveryQuest.dbpc.profile
end

function addon:RegisterModuleOptions(name, optionTbl, displayName)
	moduleOptions[name] = optionTbl
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("EveryQuest: "..name, getOptions)
	self.optionsFrames[name] = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("EveryQuest", displayName, "EveryQuest", name)
end

--- EOF ---