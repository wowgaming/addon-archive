--[[
************************************************************************
Config.lua
Ace3 Configuration options for ARL
************************************************************************
File date: 2010-01-14T07:57:24Z
File revision: 2798
Project revision: 2817
Project version: v1.0-r2818
************************************************************************
Please see http://www.wowace.com/addons/arl/ for more information.
************************************************************************
This source code is released under All Rights Reserved.
************************************************************************
]]--

local MODNAME		= "Ackis Recipe List"
local addon		= LibStub("AceAddon-3.0"):GetAddon(MODNAME)

local BFAC		= LibStub("LibBabble-Faction-3.0"):GetLookupTable()
local LC		= LOCALIZED_CLASS_NAMES_MALE
local L			= LibStub("AceLocale-3.0"):GetLocale(MODNAME)

local AceConfig 	= LibStub("AceConfig-3.0")
local AceConfigReg 	= LibStub("AceConfigRegistry-3.0")
local AceConfigDialog 	= LibStub("AceConfigDialog-3.0")

local modularOptions = {}

local function giveProfiles()
	return LibStub("AceDBOptions-3.0"):GetOptionsTable(addon.db)
end

local function ResetGUI()
	addon.db.profile.frameopts.offsetx = 0
	addon.db.profile.frameopts.offsety = 0
	addon.db.profile.frameopts.anchorTo = ""
	addon.db.profile.frameopts.anchorFrom = ""
	addon.db.profile.frameopts.uiscale = 1
	addon.db.profile.frameopts.tooltipscale = .9
	addon.db.profile.frameopts.fontsize = 11
end

local options

local function fullOptions()
	if not options then
		options = {
			type = "group",
			name = MODNAME,
			args = {
				general = {
					order	= 1,
					type	= "group",
					name	= L["Main Options"],
					desc	= L["MAIN_OPTIONS_DESC"],
					args	= {
						header1 = {
							order	= 10,
							type	= "header",
							name	= L["General Options"],
						},
						version = {
							order	= 11,
							type	= "description",
							name	= _G.GAME_VERSION_LABEL .. ": " .. addon.version .. "\n",
						},
						exclusionlist = {
							order	= 14,
							type	= "execute",
							name	= L["View Exclusion List"],
							desc	= L["VIEW_EXCLUSION_LIST_DESC"],
							func	= function(info) addon:ViewExclusionList() end,
						},
						clearexclusionlist = {
							order	= 15,
							type	= "execute",
							name	= L["Clear Exclusion List"],
							desc	= L["CLEAR_EXCLUSION_LIST_DESC"],
							func	= function(info) addon:ClearExclusionList() end,
						},
						resetallfilters = {
							order	= 16,
							type	= "execute",
							name	= L["Reset All Filters"],
							desc	= L["RESET_DESC"],
							func	= function(info) addon.resetFilters() end,
						},
						spacer1 = {
							order	= 19,
							type	= "description",
							name	= "\n",
						},
						header1a = {
							order	= 20,
							type	= "header",
							name	= L["Main Filter Options"],
						},
						mainfilter_desc = {
							order	= 21,
							type	= "description",
							name	= L["MAINFILTER_OPTIONS_DESC"] .. "\n",
						},
						includefiltered = {
							order	= 22,
							type	= "toggle",
							name	= L["Include Filtered"],
							desc	= L["FILTERCOUNT_DESC"],
							get	= function() return addon.db.profile.includefiltered end,
							set	= function() addon.db.profile.includefiltered = not addon.db.profile.includefiltered end,
						},
						includeexcluded = {
							order	= 23,
							type	= "toggle",
							name	= L["Include Excluded"],
							desc	= L["EXCLUDECOUNT_DESC"],
							get	= function() return addon.db.profile.includeexcluded end,
							set	= function() addon.db.profile.includeexcluded = not addon.db.profile.includeexcluded end,
						},
						ignoreexclusionlist = {
							order	= 24,
							type	= "toggle",
							name	= L["Display Exclusions"],
							desc	= L["DISPLAY_EXCLUSION_DESC"],
							get	= function() return addon.db.profile.ignoreexclusionlist end,
							set	= function() addon.db.profile.ignoreexclusionlist = not addon.db.profile.ignoreexclusionlist end,
						},
						spacer2 = {
							order	= 39,
							type	= "description",
							name	= "\n",
						},
						header3 = {
							order	= 40,
							type	= "header",
							name	= L["Sorting Options"],
						},
						sort_desc =	{
							order	= 41,
							type	= "description",
							name	= L["SORTING_OPTIONS_DESC"] .. "\n",
						},
						sorting = {
							order	= 45,
							type	= "select",
							name	= L["Sorting"],
							desc	= L["SORTING_DESC"],
							get	= function()
									  return addon.db.profile.sorting
								  end,
							set	= function(info, name)
									  addon.db.profile.sorting = name
								  end,
							values	= function()
									  return {
										  Name = _G.NAME,
										  SkillAsc = L["Skill (Asc)"],
										  SkillDesc = L["Skill (Desc)"],
										  Acquisition = L["Acquisition"],
										  Location = L["Location"]
									  }
								  end,
						},
					},
				},
			},
		}

		for k,v in pairs(modularOptions) do
			options.args[k] = (type(v) == "function") and v() or v
		end

	end
	return options
end

local arlmap

local function giveMap()
	local has_tomtom = TomTom and true or false

	if not arlmap then
		arlmap = {
			order	= 1,
			type	= "group",
			name	= L["Map Options"],
			desc	= L["MAP_OPTIONS_DESC"],
			args	= {
				map_desc =	{
					order	= 1,
					type	= "description",
					name	= L["MAP_OPTIONS_DESC"] .. "\n",
				},
				autoscanmap = {
					order	= 2,
					type	= "toggle",
					name	= L["Auto Scan Map"],
					desc	= L["AUTOSCANMAP_DESC"],
					disabled = not has_tomtom,
					get	= function() return addon.db.profile.autoscanmap end,
					set	= function() addon.db.profile.autoscanmap = not addon.db.profile.autoscanmap end,
				},
				worldmap = {
					order	= 3,
					type	= "toggle",
					name	= _G.WORLD_MAP,
					desc	= L["WORLDMAP_DESC"],
					disabled = not has_tomtom,
					get	= function() return addon.db.profile.worldmap end,
					set	= function() addon.db.profile.worldmap = not addon.db.profile.worldmap end,
				},
				minimap = {
					order	= 4,
					type	= "toggle",
					name	= L["Mini Map"],
					desc	= L["MINIMAP_DESC"],
					disabled = not has_tomtom,
					get	= function() return addon.db.profile.minimap end,
					set	= function() addon.db.profile.minimap = not addon.db.profile.minimap end,
				},
				maptrainer = {
					order	= 5,
					type	= "toggle",
					name	= L["Trainer"],
					desc	= L["MAP_TRAINER_DESC"],
					disabled = not has_tomtom,
					get	= function() return addon.db.profile.maptrainer end,
					set	= function() addon.db.profile.maptrainer = not addon.db.profile.maptrainer end,
				},
				mapvendor = {
					order	= 6,
					type	= "toggle",
					name	= L["Vendor"],
					desc	= L["MAP_VENDOR_DESC"],
					disabled = not has_tomtom,
					get	= function() return addon.db.profile.mapvendor end,
					set	= function() addon.db.profile.mapvendor = not addon.db.profile.mapvendor end,
				},
				mapmob = {
					order	= 7,
					type	= "toggle",
					name	= L["Monster"],
					desc	= L["MAP_MONSTER_DESC"],
					disabled = not has_tomtom,
					get	= function() return addon.db.profile.mapmob end,
					set	= function() addon.db.profile.mapmob = not addon.db.profile.mapmob end,
				},
				mapquest = {
					order	= 8,
					type	= "toggle",
					name	= L["Quest"],
					desc	= L["MAP_QUEST_DESC"],
					disabled = not has_tomtom,
					get	= function() return addon.db.profile.mapquest end,
					set	= function() addon.db.profile.mapquest = not addon.db.profile.mapquest end,
				},
				clearmap = {
					order	= 20,
					type	= "execute",
					name	= L["Clear Waypoints"],
					disabled = not has_tomtom,
					desc	= L["CLEAR_WAYPOINTS_DESC"],
					func	= function() addon:ClearMap() end,
				},
			},
		}
	end

	return arlmap
end

local datamine

local function giveDatamine()
	if not datamine then
		datamine = {
			order	= 1,
			type	= "group",
			name	= L["Datamine Options"],
			desc	= L["DATAMINE_OPTIONS_DESC"],
			args = {
				datamine_desc =	{
					order	= 1,
					type	= "description",
					name	= L["DATAMINE_OPTIONS_DESC"] .. "\n",
				},
				datamine_warn =	{
					order	= 2,
					type	= "description",
					name	= L["DATAMINE_WARNING_DESC"] .. "\n",
				},
				generatelinks = {
					width	= "double",
					order	= 10,
					type	= "execute",
					name	= L["Generate Tradeskill Links"],
					desc	= L["GENERATE_LINKS_DESC"],
					func	= function() addon:GenerateLinks() end,
				},
				scantrainerskills = {
					width	= "double",
					order	= 20,
					type	= "execute",
					name	= L["Compare Trainer Skills"],
					desc	= L["COMPARE_TRAINER_SKILL_DESC"],
					func	= function() addon:ScanSkillLevelData() end,
				},
				scantraineracquire = {
					width	= "double",
					order	= 30,
					type	= "execute",
					name	= L["Compare Trainer Acquire"],
					desc	= L["COMPARE_TRAINER_ACQUIRE_DESC"],
					func	= function() addon:ScanTrainerData() end,
				},
				null = {
					order	= 31,
					type	= "description",
					name	= "",
				},
				scanentiredatabase = {
					order	= 40,
					type	= "execute",
					name	= L["Scan Entire Database"],
					desc	= L["SCAN_ENTIRE_DB_DESC"],
					func	= function() addon:TooltipScanDatabase() end,
				},
				scanvendor = {
					order	= 50,
					type	= "execute",
					name	= L["Scan Vendor"],
					desc	= L["SCAN_VENDOR_DESC"],
					func	= function() addon:ScanVendor() end,
				},
				null1 = {
					order	= 51,
					type	= "description",
					name	= "",
				},
				scanprofessiontooltip = {
					order	= 60,
					type	= "input",
					name	= L["Scan A Profession"],
					desc	= L["SCAN_PROF_DB_DESC"],
					get	= false,
					set	= function(info, v) addon:ScanProfession(v) end,
				},
				scanspellid = {
					order = 70,
					type = "input",
					name = L["Scan A Spell ID"],
					desc = L["SCAN_SPELL_ID_DESC"],
					get = false,
					set = function(info, v) addon:TooltipScanRecipe(tonumber(v),false,false) end,
				},
				null2 = {
					order	= 80,
					type	= "description",
					name	= "",
				},
				scantrainers = {
					width	= "full",
					order	= 90,
					type	= "toggle",
					name	= L["Auto Scan Trainers"],
					desc	= L["AUTOSCAN_TRAINERS_DESC"],
					get	= function() return addon.db.profile.scantrainers end,
					set	= function()
							  if (addon.db.profile.scantrainers) then
								  addon:UnregisterEvent("TRAINER_SHOW")
							  else
								  addon:RegisterEvent("TRAINER_SHOW")
							  end
							  addon.db.profile.scantrainers = not addon.db.profile.scantrainers
						  end,
				},
				scanvendors = {
					width	= "full",
					order	= 100,
					type	= "toggle",
					name	= L["Auto Scan Vendors"],
					desc	= L["AUTOSCAN_VENDORS_DESC"],
					get	= function() return addon.db.profile.scanvendors end,
					set	= function()
							  if addon.db.profile.scanvendors then
								  addon:UnregisterEvent("MERCHANT_SHOW")
							  else
								  addon:RegisterEvent("MERCHANT_SHOW")
							  end
							  addon.db.profile.scanvendors = not addon.db.profile.scanvendors
						  end,
				},
				autoloaddb = {
					width	= "full",
					order	= 110,
					type	= "toggle",
					name	= L["Auto Load Recipe Database"],
					desc	= L["AUTOLOAD_DB_DESC"],
					get		= function() return addon.db.profile.autoloaddb end,
					set		= function() addon.db.profile.autoloaddb = not addon.db.profile.autoloaddb end,
				},
			},
		}
	end
	return datamine
end

local documentation

local function giveDocs()
	if not documentation then
		documentation = {
			order = 1,
			type = "group",
			name = L["ARL Documentation"],
			desc = L["ARL_DOC_DESC"],
			args = {
				header1 = {
					order	= 1,
					type	= "header",
					name	= L["ARL Documentation"],
				},
				desc1 = {
					order	= 2,
					type	= "description",
					name	= L["ARL_DOC_DESC"],
				},
				header2 = {
					order	= 3,
					type	= "header",
					name	= L["Using Filters"],
				},
				desc2 = {
					order	= 4,
					type	= "description",
					name	= L["USING_FILTERS_DESC"],
				},
				header3 = {
					order	= 5,
					type	= "header",
					name	= L["Common Issues"],
				},
				desc3 = {
					order	= 6,
					type	= "description",
					name	= L["COMMON_ISSUES_DESC"],
				},
				header4 = {
					order	= 7,
					type	= "header",
					name	= L["Reporting Bugs"],
				},
				desc4 = {
					order	= 8,
					type	= "description",
					name	= L["REPORTING_BUGS_DESC"],
				},
				header5 = {
					order	= 9,
					type	= "header",
					name	= L["Exclusion Issues"],
				},
				desc5 = {
					order	= 10,
					type	= "description",
					name	= L["EXCLUSION_ISSUES_DESC"],
				},
				header6 = {
					order	= 11,
					type	= "header",
					name	= L["Map Issues"],
				},
				desc6 = {
					order	= 12,
					type	= "description",
					name	= L["MAP_ISSUES_DESC"],
				},
				header7 = {
					order	= 13,
					type	= "header",
					name	= L["Game Commands"],
				},
				desc7 = {
					order	= 14,
					type	= "description",
					name	= L["GAME_COMMANDS_DESC"],
				},
			},
		}
	end
	return documentation
end

local displayoptions

local function giveDisplay()
	if not displayoptions then
		displayoptions = {
			order = 1,
			type = "group",
			name = L["Display Options"],
			desc = L["DISPLAY_OPTIONS_DESC"],
			args = {
				display_desc =	{
					order	= 1,
					type	= "description",
					name	= L["MAP_OPTIONS_DESC"] .. "\n",
				},
				scanbuttonlocation = {
					order	= 2,
					type	= "select",
					name	= L["Scan Button Position"],
					desc	= L["SCANBUTTONPOSITION_DESC"],
					get	= function() return addon.db.profile.scanbuttonlocation end,
					set	= function(info,name) addon.db.profile.scanbuttonlocation = name end,
					values	= function() return {TR = L["Top Right"], TL = L["Top Left"], BR = L["Bottom Right"], BL = L["Bottom Left"]} end,
				},
				uiscale = {
					order	= 3,
					type	= "range",
					name	= _G.UI_SCALE,
					desc	= L["UI_SCALE_DESC"],
					min	= .5,
					max	= 1.5,
					step	= .05,
					bigStep = .05,
					get	= function() return addon.db.profile.frameopts.uiscale end,
					set	= function(info, v)
							  addon.db.profile.frameopts.uiscale = v
							  addon.Frame:SetScale(v)
						  end,
				},
				fontsize = {
					order	= 4,
					type	= "range",
					name	= _G.FONT_SIZE,
					desc	= L["FONT_SIZE_DESC"],
					min		= 6,
					max		= 20,
					step	= 1,
					bigStep = 1,
					get	= function() return addon.db.profile.frameopts.fontsize end,
					set	= function(info, v) addon.db.profile.frameopts.fontsize = v end,
				},
				closegui = {
					width	= "full",
					order	= 5,
					type	= "toggle",
					name	= L["Close GUI"],
					desc	= L["CLOSEGUI_DESC"],
					get	= function() return addon.db.profile.closeguionskillclose end,
					set	= function() addon.db.profile.closeguionskillclose = not addon.db.profile.closeguionskillclose end,
				},
				hidepopup = {
					width	= "full",
					order	= 6,
					type	= "toggle",
					name	= L["Hide Pop-Up"],
					desc	= L["HIDEPOPUP_DESC"],
					get	= function() return addon.db.profile.hidepopup end,
					set	= function() addon.db.profile.hidepopup = not addon.db.profile.hidepopup end,
				},
				resetguiwindow = {
					width	= "double",
					order	= 7,
					type	= "execute",
					name	= L["Reset Window Position"],
					desc	= L["RESET_WINDOW_DESC"],
					func	= function(info) ResetGUI() end,
				},
				spacer1 = {
					order	= 10,
					type	= "description",
					name	= "\n",
				},
				tooltip_header = {
					order	= 11,
					type	= "header",
					name	= L["Tooltip Options"],
				},
				tooltip_desc =	{
					order	= 12,
					type	= "description",
					name	= L["TOOLTIP_OPTIONS_DESC"] .. "\n",
				},
				tooltipscale = {
					order	= 20,
					type	= "range",
					name	= L["Tooltip Scale"],
					desc	= L["TOOLTIP_SCALE_DESC"],
					min	= .5,
					max	= 1.5,
					step	= .05,
					bigStep = .05,
					get	= function()
							  return addon.db.profile.frameopts.tooltipscale
						  end,
					set	= function(info, v)
							  addon.db.profile.frameopts.tooltipscale = v
						  end,
				},
				acquiretooltiplocation = {
					order	= 21,
					type	= "select",
					name	= L["Tooltip (Acquire) Position"],
					desc	= L["ACQUIRETOOLTIPPOSITION_DESC"],
					get	= function()
							  return addon.db.profile.acquiretooltiplocation
						  end,
					set	= function(info, name)
							  addon.db.profile.acquiretooltiplocation = name
						  end,
					values	= function()
							  return {
								  Right = L["Right"],
								  Left = L["Left"],
								  Top = L["Top"],
								  Bottom = L["Bottom"],
								  Off = _G.OFF,
								  Mouse = _G.MOUSE_LABEL
							  }
						  end,
				},
				spelltooltiplocation = {
					order	= 22,
					type	= "select",
					name	= L["Tooltip (Recipe) Position"],
					desc	= L["SPELLTOOLTIPPOSITION_DESC"],
					get	= function()
							  return addon.db.profile.spelltooltiplocation
						  end,
					set	= function(info,name)
							  addon.db.profile.spelltooltiplocation = name
						  end,
					values	= function()
							  return { 
								  Right = L["Right"],
								  Left = L["Left"],
								  Top = L["Top"],
								  Bottom = L["Bottom"],
								  Off = _G.OFF
							  }
						  end,
				},
			},
		}
	end
	return displayoptions
end

function addon:SetupOptions()
	AceConfigReg:RegisterOptionsTable(MODNAME, fullOptions)
	self.optionsFrame = AceConfigDialog:AddToBlizOptions(MODNAME, nil, nil, "general")

	-- Register the module options
	self:RegisterModuleOptions("Profiles", giveProfiles(), L["Profile Options"])
	self:RegisterModuleOptions("Datamining", giveDatamine(), L["Datamine Options"])
	self:RegisterModuleOptions("Display", giveDisplay(), L["Display Options"])
	self:RegisterModuleOptions("Map", giveMap(), L["Map Options"])
	self:RegisterModuleOptions("Documentation", giveDocs(), L["ARL Documentation"])
	
	-- Add in the about panel to the Bliz options (not apart of the ace3 config)
	if LibStub:GetLibrary("LibAboutPanel", true) then
		self.optionsFrame["About"] = LibStub:GetLibrary("LibAboutPanel").new(MODNAME, MODNAME)
	else
		self:Print("Lib AboutPanel not loaded.")
	end	
end

-- Description: Function which extends our options table in a modular way
-- Expected result: add a new modular options table to the modularOptions upvalue as well as the Blizzard config
-- Input:
--		name			: index of the options table in our main options table
--		optionsTable	: the sub-table to insert
--		displayName	: the name to display in the config interface for this set of options
-- Output: None.

function addon:RegisterModuleOptions(name, optionsTable, displayName)
	modularOptions[name] = optionsTable
	self.optionsFrame[name] = AceConfigDialog:AddToBlizOptions(MODNAME, displayName, MODNAME, name)
end
