local Config = {}
local AceDialog, AceRegistry, AceGUI, SML, registered, options
local playerClass = select(2, UnitClass("player"))
local modifyUnits, globalConfig = {}, {}
local L = ShadowUF.L

ShadowUF.Config = Config

--[[
	The part that makes configuration a pain when you actually try is it gets unwieldly when you're adding special code to deal with
	showing help for certain cases, swapping tabs etc that makes it work smoothly.
	
	I'm going to have to split it out into separate files for each type to clean everything up but that takes time and I have other things
	I want to get done with first.
]]

local unitCategories = {
	player = {"player", "pet"},
	general = {"target", "targettarget", "targettargettarget", "focus", "focustarget", "pettarget"},
	party = {"party", "partypet", "partytarget"},
	raid = {"raid", "raidpet", "boss", "bosstarget", "maintank", "maintanktarget", "mainassist", "mainassisttarget"},
	arena = {"arena", "arenapet", "arenatarget"}}

local UNIT_DESC = {
	["boss"] = L["Boss units are for only certain fights, such as Blood Princes or the Gunship battle, you will not see them for every boss fight."],
	["mainassist"] = L["Main Assists's are set by the Blizzard Main Assist system or mods that use them such as oRA3."],
	["maintank"] = L["Main Tank's are set by the Blizzard Main Tank system or mods that use them such as oRA3."],
}

local PAGE_DESC = {
	["general"] = L["General configuration to all enabled units."],
	["enableUnits"] = L["Various units can be enabled through this page, such as raid or party targets."],
	["hideBlizzard"] = L["Hiding and showing various aspects of the default UI such as the player buff frames."],
	["units"] = L["Configuration to specific unit frames."],
	["visibility"] = L["Disabling unit modules in various instances."],
	["tags"] = L["Advanced tag management, allows you to add your own custom tags."],
	["filter"] = L["Simple aura filtering by whitelists and blacklists."],
}
local INDICATOR_NAMES = {["happiness"] = L["Happiness"], ["leader"] = L["Leader"], ["lfdRole"] = L["Dungeon role"], ["masterLoot"] = L["Master looter"], ["pvp"] = L["PvP Flag"],["raidTarget"] = L["Raid target"], ["ready"] = L["Ready status"], ["role"] = L["Raid role"], ["status"] = L["Combat status"],}
local AREA_NAMES = {["arena"] = L["Arenas"],["none"] = L["Everywhere else"], ["party"] = L["Party instances"], ["pvp"] = L["Battlegrounds"], ["raid"] = L["Raid instances"],}
local INDICATOR_DESC = {["happiness"] = L["Indicator for your pet's happiness, only applies to Hunters."],
		["leader"] = L["Crown indicator for group leaders."], ["lfdRole"] = L["Role the unit is playing in dungeons formed through the Looking For Dungeon system."],
		["masterLoot"] = L["Bag indicator for master looters."], ["pvp"] = L["PVP flag indicator, Horde for Horde flagged pvpers and Alliance for Alliance flagged pvpers."],
		["raidTarget"] = L["Raid target indicator."], ["ready"] = L["Ready status of group members."],
		["role"] = L["Raid role indicator, adds a shield indicator for main tanks and a sword icon for main assists."], ["status"] = L["Status indicator, shows if the unit is currently in combat. For the plyer it will also show if you are rested."],}
local TAG_GROUPS = {["classification"] = L["Classifications"], ["health"] = L["Health"], ["misc"] = L["Miscellaneous"], ["playerthreat"] = L["Player threat"], ["power"] = L["Power"], ["status"] = L["Status"], ["threat"] = L["Threat"], ["raid"] = L["Raid"],}

local pointPositions = {["BOTTOM"] = L["Bottom"], ["TOP"] = L["Top"], ["LEFT"] = L["Left"], ["RIGHT"] = L["Right"], ["TOPLEFT"] = L["Top Left"], ["TOPRIGHT"] = L["Top Right"], ["BOTTOMLEFT"] = L["Bottom Left"], ["BOTTOMRIGHT"] = L["Bottom Right"], ["CENTER"] = L["Center"]}
local positionList = {["C"] = L["Center"], ["RT"] = L["Right Top"], ["RC"] = L["Right Center"], ["RB"] = L["Right Bottom"], ["LT"] = L["Left Top"], ["LC"] = L["Left Center"], ["LB"] = L["Left Bottom"], ["BL"] = L["Bottom Left"], ["BC"] = L["Bottom Center"], ["BR"] = L["Bottom Right"], ["TR"] = L["Top Right"], ["TC"] = L["Top Center"], ["TL"] = L["Top Left"] }

local unitOrder = {}
for order, unit in pairs(ShadowUF.unitList) do unitOrder[unit] = order end
local fullReload = {["bars"] = true, ["auras"] = true, ["backdrop"] = true, ["font"] = true, ["classColors"] = true, ["powerColors"] = true, ["healthColors"] = true, ["xpColors"] = true, ["omnicc"] = true}
local quickIDMap = {}

-- Helper functions
local function getPageDescription(info)
	return PAGE_DESC[info[#(info)]]
end

local function getFrameName(unit)
	if( unit == "raidpet" or unit == "raid" or unit == "party" or unit == "maintank" or unit == "mainassist" or unit == "boss" or unit == "arena" ) then
		return string.format("#SUFHeader%s", unit)
	end
	
	return string.format("#SUFUnit%s", unit)
end

local anchorList = {}
local function getAnchorParents(info)
	local unit = info[2]
	for k in pairs(anchorList) do anchorList[k] = nil end
	
	if( ShadowUF.Units.childUnits[unit] ) then
		anchorList["$parent"] = string.format(L["%s member"], L.units[ShadowUF.Units.childUnits[unit]])
		return anchorList
	end
	
	anchorList["UIParent"] = L["Screen"]
	
	-- Don't let a frame anchor to a frame thats anchored to it already (Stop infinite loops-o-doom)
	local currentName = getFrameName(unit)
	for _, unitID in pairs(ShadowUF.unitList) do
		if( unitID ~= unit and ShadowUF.db.profile.positions[unitID] and ShadowUF.db.profile.positions[unitID].anchorTo ~= currentName ) then
			anchorList[getFrameName(unitID)] = string.format(L["%s frames"], L.units[unitID] or unitID)
		end
	end
	
	return anchorList
end

local function selectDialogGroup(group, key)
	AceDialog.Status.ShadowedUF.children[group].status.groups.selected = key
	AceRegistry:NotifyChange("ShadowedUF")
end

local function selectTabGroup(group, subGroup, key)
	AceDialog.Status.ShadowedUF.children[group].status.groups.selected = subGroup
	AceDialog.Status.ShadowedUF.children[group].children[subGroup].status.groups.selected = key
	AceRegistry:NotifyChange("ShadowedUF")
end
							
local function hideAdvancedOption(info)
	return not ShadowUF.db.profile.advanced
end

local function hideBasicOption(info)
	return ShadowUF.db.profile.advanced
end

local function isUnitDisabled(info)
	local unit = info[#(info)]
	local enabled = ShadowUF.db.profile.units[unit].enabled
	for _, visibility in pairs(ShadowUF.db.profile.visibility) do
		if( visibility[unit] ) then
			enabled = visibility[unit]
			break
		end
	end
	
	return not enabled
end

local function mergeTables(parent, child)
	for key, value in pairs(child) do
		if( type(parent[key]) == "table" ) then
			parent[key] = mergeTables(parent[key], value)
		elseif( type(value) == "table" ) then
			parent[key] = CopyTable(value)
		elseif( parent[key] == nil ) then
			parent[key] = value
		end
	end
	
	return parent
end

local function getName(info)
	local key = info[#(info)]
	if( ShadowUF.modules[key] and ShadowUF.modules[key].moduleName ) then
		return ShadowUF.modules[key].moduleName
	end
	
	return LOCALIZED_CLASS_NAMES_MALE[key] or INDICATOR_NAMES[key] or L.units[key] or TAG_GROUPS[key] or L[key]
end

local function getUnitOrder(info)
	return unitOrder[info[#(info)]]
end

local function isModifiersSet(info)
	if( info[2] ~= "global" ) then return false end
	for k in pairs(modifyUnits) do return false end
	return true
end

-- These are for setting simple options like bars.texture = "Default" or locked = true
local function set(info, value)
	local cat, key = string.split(".", info.arg)
	if( key == "$key" ) then key = info[#(info)] end
	
	if( not key ) then
		ShadowUF.db.profile[cat] = value
	else
		ShadowUF.db.profile[cat][key] = value
	end
	
	if( cat and fullReload[cat] ) then
		ShadowUF.Layout:CheckMedia()
		ShadowUF.Layout:Reload()
	end
end

local function get(info)
	local cat, key = string.split(".", info.arg)
	if( key == "$key" ) then key = info[#(info)] end
	if( not key ) then
		return ShadowUF.db.profile[cat]
	else
		return ShadowUF.db.profile[cat][key]
	end
end

local function setColor(info, r, g, b, a)
	local color = get(info)
	color.r, color.g, color.b, color.a = r, g, b, a
	set(info, color)
end

local function getColor(info)
	local color = get(info)
	return color.r, color.g, color.b, color.a
end

-- These are for setting complex options like units.player.auras.buffs.enabled = true or units.player.portrait.enabled = true
local function setVariable(unit, moduleKey, moduleSubKey, key, value)
	local configTable = unit == "global" and globalConfig or ShadowUF.db.profile.units[unit]
		
	-- For setting options like units.player.auras.buffs.enabled = true
	if( moduleKey and moduleSubKey and configTable[moduleKey][moduleSubKey] ) then
		configTable[moduleKey][moduleSubKey][key] = value
		ShadowUF.Layout:Reload(unit)
	-- For setting options like units.player.portrait.enabled = true
	elseif( moduleKey and not moduleSubKey and configTable[moduleKey] ) then
		configTable[moduleKey][key] = value
		ShadowUF.Layout:Reload(unit)
	-- For setting options like units.player.height = 50
	elseif( not moduleKey and not moduleSubKey ) then
		configTable[key] = value
		ShadowUF.Layout:Reload(unit)
	end
end

local function specialRestricted(unit, moduleKey, moduleSubKey, key)
	if( ShadowUF.fakeUnits[unit] and ( key == "colorAggro" or key == "aggro" or moduleKey == "incHeal" or moduleKey == "castBar" ) ) then
		return true
	elseif( moduleKey == "healthBar" and unit == "player" and key == "reaction" ) then
		return true
	end
end

local function setUnit(info, value)
	local unit = info[2]
	-- auras, buffs, enabled / text, 1, text / portrait, enabled
	local moduleKey, moduleSubKey, key = string.split(".", info.arg)
	if( not moduleSubKey ) then key = moduleKey moduleKey = nil end
	if( moduleSubKey and not key ) then key = moduleSubKey moduleSubKey = nil end
	if( moduleSubKey == "$parent" ) then moduleSubKey = info[#(info) - 1] end
	if( moduleKey == "$parent" ) then moduleKey = info[#(info) - 1] end
	if( tonumber(moduleSubKey) ) then moduleSubKey = tonumber(moduleSubKey) end
				
	if( unit == "global" ) then
		for unit in pairs(modifyUnits) do
			if( not specialRestricted(unit, moduleKey, moduleSubKey, key) ) then
				setVariable(unit, moduleKey, moduleSubKey, key, value)
			end
		end
		
		setVariable("global", moduleKey, moduleSubKey, key, value)
	else
		setVariable(unit, moduleKey, moduleSubKey, key, value)
	end
end

local function getVariable(unit, moduleKey, moduleSubKey, key)
	local configTbl = unit == "global" and globalConfig or ShadowUF.db.profile.units[unit]
	if( moduleKey and moduleSubKey ) then
		return configTbl[moduleKey][moduleSubKey] and configTbl[moduleKey][moduleSubKey][key]
	elseif( moduleKey and not moduleSubKey ) then
		return configTbl[moduleKey] and configTbl[moduleKey][key]
	end

	return configTbl[key]
end

local function getUnit(info)
	local moduleKey, moduleSubKey, key = string.split(".", info.arg)
	if( not moduleSubKey ) then key = moduleKey moduleKey = nil end
	if( moduleSubKey and not key ) then key = moduleSubKey moduleSubKey = nil end
	if( moduleSubKey == "$parent" ) then moduleSubKey = info[#(info) - 1] end
	if( moduleKey == "$parent" ) then moduleKey = info[#(info) - 1] end
	if( tonumber(moduleSubKey) ) then moduleSubKey = tonumber(moduleSubKey) end
	
	return getVariable(info[2], moduleKey, moduleSubKey, key)
end

-- Tag functions
local function getTagName(info)
	local tag = info[#(info)]
	if( ShadowUF.db.profile.tags[tag] and ShadowUF.db.profile.tags[tag].name ) then
		return ShadowUF.db.profile.tags[tag].name
	end
	
	return ShadowUF.Tags.defaultNames[tag] or tag
end

local function getTagHelp(info)
	local tag = info[#(info)]
	return ShadowUF.Tags.defaultHelp[tag] or ShadowUF.db.profile.tags[tag] and ShadowUF.db.profile.tags[tag].help
end

-- Module functions
local function hideRestrictedOption(info)
	local unit = type(info.arg) == "number" and info[#(info) - info.arg] or info[2]
	local key = info[#(info)]
	if( ShadowUF.modules[key] and ShadowUF.modules[key].moduleClass and ShadowUF.modules[key].moduleClass ~= playerClass ) then
		return true
	elseif( key == "incHeal" and not ShadowUF.modules.incHeal ) then
		return true
	-- Non-standard units do not support color by aggro or incoming heal
	elseif( key == "colorAggro" or key == "incHeal" or key == "aggro" ) then
		return string.match(unit, "%w+target" )
	-- Fall back for indicators, no variable table so it shouldn't be shown
	elseif( info[#(info) - 1] == "indicators" ) then
		if( ( unit == "global" and not globalConfig.indicators[key] ) or ( unit ~= "global" and not ShadowUF.db.profile.units[unit].indicators[key] ) ) then
			return true
		end
	-- Fall back, no variable table so it shouldn't be shown
	elseif( ( unit == "global" and not globalConfig[key] ) or ( unit ~= "global" and not ShadowUF.db.profile.units[unit][key] ) ) then
		return true
	end
	
	return false
end

local function getModuleOrder(info)
	local key = info[#(info)]
	return key == "healthBar" and 1 or key == "powerBar" and 2 or key == "castBar" and 3 or 4
end

-- Expose these for modules
Config.getAnchorParents = getAnchorParents
Config.hideAdvancedOption = hideAdvancedOption
Config.isUnitDisabled = isUnitDisabled
Config.selectDialogGroup = selectDialogGroup
Config.selectTabGroup = selectTabGroup
Config.getName = getName
Config.getUnitOrder = getUnitOrder
Config.isModifiersSet = isModifiersSet
Config.set = set
Config.get = get
Config.setUnit = setUnit
Config.setVariable = setVariable
Config.getUnit = getUnit
Config.getVariable = getVariable
Config.hideRestrictedOption = hideRestrictedOption
Config.hideBasicOption = hideBasicOption


--------------------
-- GENERAL CONFIGURATION
---------------------
local function loadGeneralOptions()
	SML = SML or LibStub:GetLibrary("LibSharedMedia-3.0")
	
	local MediaList = {}
	local function getMediaData(info)
		local mediaType = info[#(info)]

		MediaList[mediaType] = MediaList[mediaType] or {}

		for k in pairs(MediaList[mediaType]) do	MediaList[mediaType][k] = nil end
		for _, name in pairs(SML:List(mediaType)) do
			MediaList[mediaType][name] = name
		end
		
		return MediaList[mediaType]
	end
	

	local barModules = {}
	for	key, module in pairs(ShadowUF.modules) do
		if( module.moduleHasBar ) then
			barModules["$" .. key] = module.moduleName
		end
	end
	
	local addTextParent = {
		order = 4,
		type = "group",
		inline = true,
		name = function(info) return barModules[info[#(info)]] or string.sub(info[#(info)], 2) end,
		hidden = function(info)
			for _, text in pairs(ShadowUF.db.profile.units.player.text) do
				if( text.anchorTo == info[#(info)] ) then
					return false
				end
			end
			
			return true
		end,
		args = {},
	}
	
	local addTextLabel = {
		order = function(info) return tonumber(string.match(info[#(info)], "(%d+)")) end,
		type = "description",
		width = "",
		fontSize = "medium",
		hidden = function(info)
			local id = tonumber(string.match(info[#(info)], "(%d+)"))
			if( not getVariable("player", "text", nil, id) ) then return true end
			return getVariable("player", "text", id, "anchorTo") ~= info[#(info) - 1]
		end,
		name = function(info)
			return getVariable("player", "text", tonumber(string.match(info[#(info)], "(%d+)")), "name")
		end,
	}

	local addTextSep = {
		order = function(info) return tonumber(string.match(info[#(info)], "(%d+)")) + 0.75 end,
		type = "description",
		width = "full",
		hidden = function(info)
			local id = tonumber(string.match(info[#(info)], "(%d+)"))
			if( not getVariable("player", "text", nil, id) ) then return true end
			return getVariable("player", "text", id, "anchorTo") ~= info[#(info) - 1]
		end,
		name = "",
	}
	
	local addText = {
		order = function(info) return info[#(info)] + 0.5 end,
		type = "execute",
		width = "half",
		name = L["Delete"],
		hidden = function(info)
			local id = tonumber(info[#(info)])
			if( not getVariable("player", "text", nil, id) ) then return true end
			return getVariable("player", "text", id, "anchorTo") ~= info[#(info) - 1]
		end,
		disabled = function(info) return tonumber(info[#(info)]) <= 6 end,
		confirmText = L["Are you sure you want to delete this text? All settings for it will be deleted."],
		confirm = true,
		func = function(info)
			local id = tonumber(info[#(info)])
			for _, unit in pairs(ShadowUF.unitList) do
				table.remove(ShadowUF.db.profile.units[unit].text, id)
			end
			
			addTextParent.args[info[#(info)]] = nil
			ShadowUF.Layout:Reload()
		end,
	}

	local function validateSpell(info, spell)
		if( spell and spell ~= "" and not GetSpellInfo(spell) ) then
			return string.format(L["Invalid spell \"%s\" entered."], spell or "")
		end
		
		return true
	end
	
	local function setRange(info, spell)
		ShadowUF.db.profile.range[info[#(info)] .. playerClass] = spell and spell ~= "" and spell or nil
		ShadowUF.Layout:Reload()
	end
	
	local function getRange(info, spell)
		local spell = ShadowUF.db.profile.range[info[#(info)] .. playerClass]
		return spell and spell ~= "" and spell or ShadowUF.modules.range[info[#(info)]][playerClass]
	end
								
	local textData = {}
	
	local function writeTable(tbl)
		local data = ""
		for key, value in pairs(tbl) do
			local valueType = type(value)
			
			-- Wrap the key in brackets if it's a number
			if( type(key) == "number" ) then
				key = string.format("[%s]", key)
			-- Wrap the string with quotes if it has a space in it
			elseif( string.match(key, "[%p%s%c]") ) then
				key = string.format("['%s']", string.gsub(key, "'", "\\'"))
			end
			
			-- foo = {bar = 5}
			if( valueType == "table" ) then
				data = string.format("%s%s=%s;", data, key, writeTable(value))
			-- foo = true / foo = 5
			elseif( valueType == "number" or valueType == "boolean" ) then
				data = string.format("%s%s=%s;", data, key, tostring(value))
			-- foo = "bar"
			else
				data = string.format("%s%s='%s';", data, key, string.gsub(tostring(value), "'", "\\'"))
			end
		end
		
		return "{" .. data .. "}"
	end
		
	local layoutData = {positions = true, visibility = true, modules = false}
	local layoutManager = {
		type = "group",
		order = 7,
		name = L["Layout manager"],
		childGroups = "tab",
		hidden = hideAdvancedOption,
		args = {
			import = {
				order = 1,
				type = "group",
				name = L["Import"],
				hidden = false,
				args = {
					help = {
						order = 1,
						type = "group",
						inline = true,
						name = function(info) return layoutData.error and L["Error"] or L["Help"] end,
						args = {
							help = {
								order = 1,
								type = "description",
								name = function(info)
									if( ShadowUF.db:GetCurrentProfile() == "Import Backup" ) then
										return L["Your active layout is the profile used for import backup, this cannot be overwritten by an import. Change your profiles to something else and try again."]
									end
								
									return layoutData.error or L["You can import another Shadowed Unit Frame users configuration by entering the export code they gave you below. This will backup your old layout to \"Import Backup\".|n|nIt will take 30-60 seconds for it to load your layout when you paste it in, please by patient."]
								end
							},
						},
					},
					positions = {
						order = 2,
						type = "toggle",
						name = L["Import unit frame positions"],
						set = function(info, value) layoutData[info[#(info)]] = value end,
						get = function(info) return layoutData[info[#(info)]] end,
						width = "double",
					},
					visibility = {
						order = 3,
						type = "toggle",
						name = L["Import visibility settings"],
						set = function(info, value) layoutData[info[#(info)]] = value end,
						get = function(info) return layoutData[info[#(info)]] end,
						width = "double",
					},
					modules = {
						order = 4,
						type = "toggle",
						name = L["Import non-standard module settings"],
						desc = L["Will not import settings of modules that are not included with Shadowed Unit Frames by default."],
						set = function(info, value) layoutData[info[#(info)]] = value end,
						get = function(info) return layoutData[info[#(info)]] end,
						width = "double",
					},
					import = {
						order = 5,
						type = "input",
						name = L["Code"],
						multiline = true,
						width = "full",
						get = false,
						disabled = function() return ShadowUF.db:GetCurrentProfile() == "Import Backup" end,
						set = function(info, import)
							local layout, err = loadstring(string.format([[return %s]], import))
							if( err ) then
								layoutData.error = string.format(L["Failed to import layout, error:|n|n%s"], err)
								return
							end
							
							layout = layout()
							
							-- Strip position settings
							if( not layoutData.positions ) then
								layout.positions = nil
							end
							
							-- Strip visibility settings
							if( not layoutData.visibility ) then
								layout.visibility = nil
							end
							
							-- Strip any units we don't have included by default
							for unit in pairs(layout.units) do
								if( not ShadowUF.defaults.profile.units[unit] ) then
									layout.units[unit] = nil
								end
							end
							
							-- Strip module settings that aren't with SUF by default
							if( not layoutData.modules ) then
								local validModules = {["healthBar"] = true, ["powerBar"] = true, ["portrait"] = true, ["range"] = true, ["text"] = true, ["indicators"] = true, ["auras"] = true, ["incHeal"] = true, ["castBar"] = true, ["combatText"] = true, ["highlight"] = true, ["runeBar"] = true, ["totemBar"] = true, ["xpBar"] = true, ["fader"] = true, ["comboPoints"] = true}
								for _, unitData in pairs(layout.units) do
									for key, data in pairs(unitData) do
										if( type(data) == "table" and not validModules[key] and ShadowUF.modules[key] ) then
											unitData[key] = nil
										end
									end
								end
							end
							
							-- Check if we need move over the visibility and positions info
							layout.positions = layout.positions or CopyTable(ShadowUF.db.profile.positions)
							layout.visibility = layout.visibility or CopyTable(ShadowUF.db.profile.positions)

							-- Now backup the profile
							local currentLayout = ShadowUF.db:GetCurrentProfile()
							ShadowUF.layoutImporting = true
							ShadowUF.db:SetProfile("Import Backup")
							ShadowUF.db:CopyProfile(currentLayout)
							ShadowUF.db:SetProfile(currentLayout)
							ShadowUF.db:ResetProfile()
							ShadowUF.layoutImporting = nil
														
							-- Overwrite everything we did import
							ShadowUF:LoadDefaultLayout()
							for key, data in pairs(layout) do
								if( type(data) == "table" ) then
									ShadowUF.db.profile[key] = CopyTable(data)
								else
									ShadowUF.db.profile[key] = data
								end
							end
							
							ShadowUF:ProfilesChanged()
						end,
					},
				},
			},
			export = {
				order = 2,
				type = "group",
				name = L["Export"],
				hidden = false,
				args = {
					help = {
						order = 1,
						type = "group",
						inline = true,
						name = L["Help"],
						args = {
							help = {
								order = 1,
								type = "description",
								name = L["After you hit export, you can give the below code to other Shadowed Unit Frames users and they will get your exact layout."],
							},
						},
					},
					doExport = {
						order = 2,
						type = "execute",
						name = L["Export"],
						func = function(info)
							layoutData.export = writeTable(ShadowUF.db.profile)
						end,
					},
					export = {
						order = 3,
						type = "input",
						name = L["Code"],
						multiline = true,
						width = "full",
						set = false,
						get = function(info) return layoutData[info[#(info)]] end,
					},
				},
			},
		},
	}
	
	options.args.general = {
		type = "group",
		childGroups = "tab",
		name = L["General"],
		args = {
			general = {
				type = "group",
				order = 1,
				name = L["General"],
				set = set,
				get = get,
				args = {
					general = {
						order = 1,
						type = "group",
						inline = true,
						name = L["General"],
						args = {
							locked = {
								order = 1,
								type = "toggle",
								name = L["Lock frames"],
								desc = L["Enables configuration mode, letting you move and giving you example frames to setup."],
								set = function(info, value)
									set(info, value)
									ShadowUF.modules.movers:Update()
								end,
								arg = "locked",
							},
							sep = {
								order = 1.5,
								type = "description",
								name = "",
								width = "full",
								hidden = hideAdvancedOption,
							},
							advanced = {
								order = 2,
								type = "toggle",
								name = L["Advanced"],
								desc = L["Enabling advanced settings will give you access to more configuration options. This is meant for people who want to tweak every single thing, and should not be enabled by default as it increases the options."],
								arg = "advanced",
							},
							omnicc = {
								order = 2.5,
								type = "toggle",
								name = L["Disable OmniCC"],
								desc = L["Disables showing OmniCC timers in all Shadowed Unit Frame auras."],
								arg = "omnicc",
								hidden = hideAdvancedOption,
							},
							hideCombat = {
								order = 3,
								type = "toggle",
								name = L["Hide tooltips in combat"],
								desc = L["Prevents unit tooltips from showing while in combat."],
								arg = "tooltipCombat",
							},
							auraBorder = {
								order = 5,
								type = "select",
								name = L["Aura border style"],
								desc = L["Style of borders to show for all auras."],
								values = {["dark"] = L["Dark"], ["light"] = L["Light"], ["blizzard"] = L["Blizzard"], [""] = L["None"]},
								arg = "auras.borderType",
							},
							statusbar = {
								order = 6,
								type = "select",
								name = L["Bar texture"],
								dialogControl = "LSM30_Statusbar",
								values = getMediaData,
								arg = "bars.texture",
							},
							spacing = {
								order = 7,
								type = "range",
								name = L["Bar spacing"],
								desc = L["How much spacing should be provided between all of the bars inside a unit frame, negative values move them farther apart, positive values bring them closer together. 0 for no spacing."],
								min = -10, max = 10, step = 0.05, softMin = -5, softMax = 5,
								arg = "bars.spacing",
								hidden = hideAdvancedOption,
							},
						},
					},
					backdrop = {
						order = 2,
						type = "group",
						inline = true,
						name = L["Background/border"],
						args = {
							backgroundColor = {
								order = 1,
								type = "color",
								name = L["Background color"],
								hasAlpha = true,
								set = setColor,
								get = getColor,
								arg = "backdrop.backgroundColor",
							},
							borderColor = {
								order = 2,
								type = "color",
								name = L["Border color"],
								hasAlpha = true,
								set = setColor,
								get = getColor,
								arg = "backdrop.borderColor",
							},
							sep = {
								order = 3,
								type = "description",
								name = "",
								width = "full",
							},
							background = {
								order = 4,
								type = "select",
								name = L["Background"],
								dialogControl = "LSM30_Background",
								values = getMediaData,
								arg = "backdrop.backgroundTexture",
							},
							border = {
								order = 5,
								type = "select",
								name = L["Border"],
								dialogControl = "LSM30_Border",
								values = getMediaData,
								arg = "backdrop.borderTexture",
							},
							inset = {
								order = 5.5,
								type = "range",
								name = L["Inset"],
								desc = L["How far the background should be from the unit frame border."],
								min = -10, max = 10, step = 1,
								hidden = hideAdvancedOption,
								arg = "backdrop.inset",
							},
							sep2 = {
								order = 6,
								type = "description",
								name = "",
								width = "full",
								hidden = hideAdvancedOption,
							},
							edgeSize = {
								order = 7,
								type = "range",
								name = L["Edge size"],
								desc = L["How large the edges should be."],
								hidden = hideAdvancedOption,
								min = 0, max = 20, step = 1,
								arg = "backdrop.edgeSize",
							},
							tileSize = {
								order = 8,
								type = "range",
								name = L["Tile size"],
								desc = L["How large the background should tile"],
								hidden = hideAdvancedOption,
								min = 0, max = 20, step = 1,
								arg = "backdrop.tileSize",
							},
							clip = {
								order = 9,
								type = "range",
								name = L["Clip"],
								desc = L["How close the frame should clip with the border."],
								hidden = hideAdvancedOption,
								min = 0, max = 20, step = 1,
								arg = "backdrop.clip",
							},
						},
					},
					font = {
						order = 3,
						type = "group",
						inline = true,
						name = L["Font"],
						args = {
							font = {
								order = 1,
								type = "select",
								name = L["Font"],
								dialogControl = "LSM30_Font",
								values = getMediaData,
								arg = "font.name",
							},
							size = {
								order = 2,
								type = "range",
								name = L["Size"],
								min = 1, max = 50, step = 1, softMin = 1, softMax = 20,
								arg = "font.size",
							},
							outline = {
								order = 3,
								type = "select",
								name = L["Outline"],
								values = {["OUTLINE"] = L["Thin outline"], ["THICKOUTLINE"] = L["Thick outline"], [""] = L["None"]},
								arg = "font.extra",
								hidden = hideAdvancedOption,
							},
						},
					},
					bar = {
						order = 4,
						type = "group",
						inline = true,
						name = L["Bars"],
						hidden = hideAdvancedOption,
						args = {
							override = {
								order = 0,
								type = "toggle",
								name = L["Override color"],
								desc = L["Forces a static color to be used for the background of all bars"],
								set = function(info, value)
									if( value and not ShadowUF.db.profile.bars.backgroundColor ) then
										ShadowUF.db.profile.bars.backgroundColor = {r = 0, g = 0, b = 0}
									elseif( not value ) then
										ShadowUF.db.profile.bars.backgroundColor = nil
									end
									
									ShadowUF.Layout:Reload()
								end,
								get = function(info)
									return ShadowUF.db.profile.bars.backgroundColor and true or false
								end,
							},
							color = {
								order = 1,
								type = "color",
								name = L["Background color"],
								desc = L["This will override all background colorings for bars including custom set ones."],
								set = setColor,
								get = function(info)
									if( not ShadowUF.db.profile.bars.backgroundColor ) then
										return {r = 0, g = 0, b = 0}
									end
									
									return getColor(info)
								end,
								disabled = function(info) return not ShadowUF.db.profile.bars.backgroundColor end,
								arg = "bars.backgroundColor",
							},
							sep = { order = 2, type = "description", name = "", width = "full"},
							barAlpha = {
								order = 3,
								type = "range",
								name = L["Bar alpha"],
								desc = L["Alpha to use for bar."],
								arg = "bars.alpha",
								min = 0, max = 1, step = 0.05,
								isPercent = true
							},
							backgroundAlpha = {
								order = 4,
								type = "range",
								name = L["Background alpha"],
								desc = L["Alpha to use for bar backgrounds."],
								arg = "bars.backgroundAlpha",
								min = 0, max = 1, step = 0.05,
								isPercent = true
							},
						},
					},
					range = {
						order = 5,
						type = "group",
						inline = true,
						name = L["Range spells"],
						args = {
							friendly = {
								order = 0,
								type = "input",
								name = L["Friendly spell"],
								desc = L["Name of a friendly spell to check range on friendlies.|n|nThis is automatically set for your current class only."],
								validate = validateSpell,
								set = setRange,
								get = getRange,
							},
							hostile = {
								order = 1,
								type = "input",
								name = L["Hostile spell"],
								desc = L["Name of a hostile spell to check range on enemies.|n|nThis is automatically set for your current class only."],
								validate = validateSpell,
								set = setRange,
								get = getRange,
							},
						},
					},
				},
			},
			color = {
				order = 2,
				type = "group",
				name = L["Colors"],
				args = {
					health = {
						order = 1,
						type = "group",
						inline = true,
						name = L["Health"],
						set = setColor,
						get = getColor,
						args = {
							green = {
								order = 1,
								type = "color",
								name = L["High health"],
								desc = L["Health bar color used as the transitional color for 100% -> 50% on players, as well as when your pet is happy."],
								arg = "healthColors.green",
							},
							yellow = {
								order = 2,
								type = "color",
								name = L["Half health"],
								desc = L["Health bar color used as the transitional color for 100% -> 0% on players, as well as when your pet is mildly unhappy."],
								arg = "healthColors.yellow",
							},
							red = {
								order = 3,
								type = "color",
								name = L["Low health"],
								desc = L["Health bar color used as the transitional color for 50% -> 0% on players, as well as when your pet is very unhappy."],
								arg = "healthColors.red",
							},
							friendly = {
								order = 4,
								type = "color",
								name = L["Friendly"],
								desc = L["Health bar color for friendly units."],
								arg = "healthColors.friendly",
							},
							neutral = {
								order = 5,
								type = "color",
								name = L["Neutral"],
								desc = L["Health bar color for neutral units."],
								arg = "healthColors.neutral",
							},
							hostile = {
								order = 6,
								type = "color",
								name = L["Hostile"],
								desc = L["Health bar color for hostile units."],
								arg = "healthColors.hostile",
							},
							static = {
								order = 7,
								type = "color",
								name = L["Static"],
								desc = L["Color to use for health bars that are set to be colored by a static color."],
								arg = "healthColors.static",
							},
							inc = {
								order = 8,
								type = "color",
								name = L["Incoming heal"],
								desc = L["Health bar color to use to show how much healing someone is about to receive."],
								arg = "healthColors.inc",
							},
							enemyUnattack = {
								order = 9,
								type = "color",
								name = L["Unattackable hostile"],
								desc = L["Health bar color to use for hostile units who you cannot attack, used for reaction coloring."],
								hidden = hideAdvancedOption,
								arg = "healthColors.enemyUnattack",
							},
						},
					},
					power = {
						order = 2,
						type = "group",
						inline = true,
						name = L["Power"],
						set = setColor,
						get = getColor,
						args = {
							MANA = {
								order = 0,
								type = "color",
								name = L["Mana"],
								hasAlpha = true,
								width = "half",
								arg = "powerColors.MANA",
							},
							RAGE = {
								order = 1,
								type = "color",
								name = L["Rage"],
								hasAlpha = true,
								width = "half",
								arg = "powerColors.RAGE",
							},
							FOCUS = {
								order = 2,
								type = "color",
								name = L["Focus"],
								hasAlpha = true,
								arg = "powerColors.FOCUS",
								width = "half",
							},
							ENERGY = {
								order = 3,
								type = "color",
								name = L["Energy"],
								hasAlpha = true,
								arg = "powerColors.ENERGY",
								width = "half",
							},
							HAPPINESS = {
								order = 5,
								type = "color",
								name = L["Happiness"],
								hasAlpha = true,
								arg = "powerColors.HAPPINESS",
							},
							RUNIC_POWER = {
								order = 6,
								type = "color",
								name = L["Runic Power"],
								hasAlpha = true,
								arg = "powerColors.RUNIC_POWER",
							},
							AMMOSLOT = {
								order = 7,
								type = "color",
								name = L["Ammo"],
								hasAlpha = true,
								arg = "powerColors.AMMOSLOT",
								hidden = hideAdvancedOption,
							},
							FUEL = {
								order = 8,
								type = "color",
								name = L["Fuel"],
								hasAlpha = true,
								arg = "powerColors.FUEL",
								hidden = hideAdvancedOption,
							},
						},
					},
					cast = {
						order = 3,
						type = "group",
						inline = true,
						name = L["Cast"],
						set = setColor,
						get = getColor,
						args = {
							cast = {
								order = 0,
								type = "color",
								name = L["Casting"],
								desc = L["Color used when an unit is casting a spell."],
								arg = "castColors.cast",
							},
							channel = {
								order = 1,
								type = "color",
								name = L["Channelling"],
								desc = L["Color used when a cast is a channel."],
								arg = "castColors.channel",
							},
							sep = {
								order = 2,
								type = "description",
								name = "",
								hidden = hideAdvancedOption,
								width = "full",
							},
							finished = {
								order = 3,
								type = "color",
								name = L["Finished cast"],
								desc = L["Color used when a cast is successfully finished."],
								hidden = hideAdvancedOption,
								arg = "castColors.finished",
							},
							interrupted = {
								order = 4,
								type = "color",
								name = L["Cast interrupted"],
								desc = L["Color used when a cast is interrupted either by the caster themselves or by another unit."],
								hidden = hideAdvancedOption,
								arg = "castColors.interrupted",
							},
							uninterruptible = {
								order = 5,
								type = "color",
								name = L["Cast uninterruptible"],
								desc = L["Color used when a cast cannot be interrupted, this is only used for PvE mobs."],
								arg = "castColors.uninterruptible",
							},
						},
					},
					classColors = {
						order = 4,
						type = "group",
						inline = true,
						name = L["Classes"],
						set = setColor,
						get = getColor,
						args = {}
					},
				},
			},
			profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(ShadowUF.db, true),
			text = {
				type = "group",
				order = 6,
				name = L["Text management"],
				hidden = false,
				args = {
					help = {
						order = 0,
						type = "group",
						inline = true,
						name = L["Help"],
						args = {
							help = {
								order = 0,
								type = "description",
								name = L["You can add additional text with tags enabled using this configuration, note that any additional text added (or removed) effects all units, removing text will reset their settings as well.|n|nKeep in mind, you cannot delete the default text included with the units."],
							},
						},
					},
					add = {
						order = 1,
						name = L["Add new text"],
						inline = true,
						type = "group",
						set = function(info, value) textData[info[#(info)] ] = value end,
						get = function(info, value) return textData[info[#(info)] ] end,
						args = {
							name = {
								order = 0,
								type = "input",
								name = L["Text name"],
								desc = L["Text name that you can use to identify this text from others when configuring."],
							},
							parent = {
								order = 1,
								type = "select",
								name = L["Text parent"],
								desc = L["Where inside the frame the text should be anchored to."],
								values = barModules,
							},
							add = {
								order = 2,
								type = "execute",
								name = L["Add"],
								disabled = function() return not textData.name or textData.name == "" or not textData.parent end,
								func = function(info)
									-- Verify we entered a good name
									textData.name = string.trim(textData.name)
									textData.name = textData.name ~= "" and textData.name or nil
									
									-- Add the new entry
									for _, unit in pairs(ShadowUF.unitList) do
										table.insert(ShadowUF.db.profile.units[unit].text, {enabled = true, name = textData.name or "??", text = "", anchorTo = textData.parent, x = 0, y = 0, anchorPoint = "C", size = 0, width = 0.50})
									end
									
									-- Add it to the GUI
									local id = tostring(#(ShadowUF.db.profile.units.player.text))
									addTextParent.args[id .. ":label"] = addTextLabel
									addTextParent.args[id] = addText
									addTextParent.args[id .. ":sep"] = addTextSep
									options.args.general.args.text.args[textData.parent] = options.args.general.args.text.args[textData.parent] or addTextParent
									
									local parent = string.sub(textData.parent, 2)
									Config.tagWizard[parent] = Config.tagWizard[parent] or Config.parentTable
									Config.tagWizard[parent].args[id] = Config.tagTextTable
									Config.tagWizard[parent].args[id .. ":adv"] = Config.advanceTextTable
									
									quickIDMap[id .. ":adv"] = #(ShadowUF.db.profile.units.player.text)
									
									-- Reset
									textData.name = nil
									textData.parent = nil
									
								end,
							},
						},
					},
				},
			},
			layout = layoutManager,
		},
	}
	
	-- Load text
	for id, text in pairs(ShadowUF.db.profile.units.player.text) do
		addTextParent.args[id .. ":label"] = addTextLabel
		addTextParent.args[tostring(id)] = addText
		addTextParent.args[id .. ":sep"] = addTextSep
		options.args.general.args.text.args[text.anchorTo] = addTextParent
	end
	
	
	Config.classTable = {
		order = 0,
		type = "color",
		name = getName,
		hasAlpha = true,
		width = "half",
		arg = "classColors.$key",
	}
	
	for classToken in pairs(RAID_CLASS_COLORS) do
		options.args.general.args.color.args.classColors.args[classToken] = Config.classTable
	end
	
	options.args.general.args.color.args.classColors.args.PET = Config.classTable
	options.args.general.args.color.args.classColors.args.VEHICLE = Config.classTable
	
	options.args.general.args.profile.order = 4
end

---------------------
-- HIDE BLIZZARD FRAMES CONFIGURATION
---------------------
local function loadHideOptions()
	Config.hideTable = {
		order = function(info) return info[#(info)] == "buffs" and 1 or 2 end,
		type = "toggle",
		name = function(info)
			local key = info[#(info)]
			return L.units[key] and string.format(L["Hide %s frames"], string.lower(L.units[key])) or string.format(L["Hide %s"], key == "cast" and L["player cast bar"] or key == "runes" and L["rune bar"] or key == "buffs" and L["buff frames"])
		end,
		set = function(info, value)
			set(info, value)
			if( value ) then ShadowUF:HideBlizzardFrames() end
		end,
		hidden = false,
		get = get,
		arg = "hidden.$key",
	}
	
	options.args.hideBlizzard = {
		type = "group",
		name = L["Hide Blizzard"],
		desc = getPageDescription,
		args = {
			help = {
				order = 0,
				type = "group",
				name = L["Help"],
				inline = true,
				args = {
					description = {
						type = "description",
						name = L["You will need to do a /console reloadui before a hidden frame becomes visible again.|nPlayer and other unit frames are automatically hidden depending on if you enable the unit in Shadowed Unit Frames."],
						width = "full",
					},
				},
			},
			hide = {
				order = 1,
				type = "group",
				name = L["Frames"],
				inline = true,
				args = {
					buffs = Config.hideTable,
					cast = Config.hideTable,
					runes = Config.hideTable,
					party = Config.hideTable,
					player = Config.hideTable,
					pet = Config.hideTable,
					target = Config.hideTable,
					focus = Config.hideTable,
					boss = Config.hideTable,
					arena = Config.hideTable,
				},
			},
		}
	}
end

---------------------
-- UNIT CONFIGURATION
---------------------
local function loadUnitOptions()
	-- This makes sure  we don't end up with any messed up positioning due to two different anchors being used
	local function fixPositions(info)
		local unit = info[2]
		local key = info[#(info)]
		
		if( key == "point" or key == "relativePoint" ) then
			ShadowUF.db.profile.positions[unit].anchorPoint = ""
			ShadowUF.db.profile.positions[unit].movedAnchor = nil
		elseif( key == "anchorPoint" ) then
			ShadowUF.db.profile.positions[unit].point = ""
			ShadowUF.db.profile.positions[unit].relativePoint = ""
		end
		
		-- Reset offset if it was a manually positioned frame, and it got anchored
		-- Why 100/-100 you ask? Because anything else requires some sort of logic applied to it
		-- and this means the frames won't directly overlap too which is a nice bonus
		if( key == "anchorTo" ) then
			ShadowUF.db.profile.positions[unit].x = 100
			ShadowUF.db.profile.positions[unit].y = -100
		end
	end
		
	-- Hide raid option in party config
	local function hideRaidOrAdvancedOption(info)
		if( info[2] == "party" and ShadowUF.db.profile.advanced ) then return false end
		
		return info[2] ~= "raid" and info[2] ~= "raidpet" and info[2] ~= "maintank" and info[2] ~= "mainassist"
	end
	
	local function hideRaidOption(info)
		return info[2] ~= "raid" and info[2] ~= "raidpet" and info[2] ~= "maintank" and info[2] ~= "mainassist"
	end
	
	local function hideSplitOrRaidOption(info)
		if( info[2] == "raid" and ShadowUF.db.profile.units.raid.frameSplit ) then
			return true
		end
		
		return hideRaidOption(info) 
	end

	-- Not every option should be changed via global settings
	local function hideSpecialOptions(info)
		local unit = info[2]
		if( unit == "global" or unit == "partypet" ) then
			return true
		end
		
		return hideAdvancedOption(info)
	end
	
	local function checkNumber(info, value)
		return tonumber(value)
	end
	
	local function setPosition(info, value)
		ShadowUF.db.profile.positions[info[2]][info[#(info)]] = value
		fixPositions(info)
		
		if( info[2] == "raid" or info[2] == "raidpet" or info[2] == "maintank" or info[2] == "mainassist" or info[2] == "party" or info[2] == "boss" or info[2] == "arena" ) then
			ShadowUF.Units:ReloadHeader(info[2])
		else
			ShadowUF.Layout:Reload(info[2])
		end
	end
	
	local function getPosition(info)
		return ShadowUF.db.profile.positions[info[2]][info[#(info)]]
	end

	local function setNumber(info, value)
		local unit = info[2]
		local key = info[#(info)]
		local id = unit .. key
		
		-- Apply effective scaling if it's anchored to UIParent
		if( ShadowUF.db.profile.positions[unit].anchorTo == "UIParent" ) then
			value = value * (ShadowUF.db.profile.units[unit].scale * UIParent:GetScale())
		end
		
		setPosition(info, tonumber(value))
	end
	
	local function getString(info)
		local unit = info[2]
		local key = info[#(info)]
		local id = unit .. key
		local coord = getPosition(info)
		
		-- If the frame is created and it's anchored to UIParent, will return the number modified by scale
		if( ShadowUF.db.profile.positions[unit].anchorTo == "UIParent" ) then
			coord = coord / (ShadowUF.db.profile.units[unit].scale * UIParent:GetScale())
		end
				
		-- OCD, most definitely.
		-- Pain to check coord == math.floor(coord) because floats are handled oddly with frames and return 0.99999999999435
		return string.gsub(string.format("%.2f", coord), "%.00$", "")
	end
	
	
	-- TAG WIZARD
	local tagWizard = {}
	Config.tagWizard = tagWizard
	do
		-- Load tag list
		Config.advanceTextTable = {
			order = 1,
			name = function(info) return getVariable(info[2], "text", quickIDMap[info[#(info)]], "name")  end,
			type = "group",
			inline = true,
			hidden = function(info)
				if( not getVariable(info[2], "text", nil, quickIDMap[info[#(info)]]) ) then return true end
				return string.sub(getVariable(info[2], "text", quickIDMap[info[#(info)]], "anchorTo"), 2) ~= info[#(info) - 1]
			end,
			set = function(info, value)
				info.arg = string.format("text.%s.%s", quickIDMap[info[#(info) - 1]], info[#(info)])
				setUnit(info, value)
			end,
			get = function(info)
				info.arg = string.format("text.%s.%s", quickIDMap[info[#(info) - 1]], info[#(info)])
				return getUnit(info)
			end,
			args = {
				anchorPoint = {
					order = 1,
					type = "select",
					name = L["Anchor point"],
					values = {["LC"] = L["Left Center"], ["RT"] = L["Right Top"], ["RB"] = L["Right Bottom"], ["LT"] = L["Left Top"], ["LB"] = L["Left Bottom"], ["RC"] = L["Right Center"],["TRI"] = L["Inside Top Right"], ["TLI"] = L["Inside Top Left"], ["CLI"] = L["Inside Center Left"], ["C"] = L["Inside Center"], ["CRI"] = L["Inside Center Right"], ["TR"] = L["Top Right"], ["TL"] = L["Top Left"], ["BR"] = L["Bottom Right"], ["BL"] = L["Bottom Left"]},
					hidden = hideAdvancedOption,
				},
				sep = {
					order = 2,
					type = "description",
					name = "",
					width = "full",
					hidden = hideAdvancedOption,
				},
				width = {
					order = 3,
					name = L["Width weight"],
					desc = L["How much weight this should use when figuring out the total text width."],
					type = "range",
					min = 0, max = 10, step = 0.1,
					hidden = false,
				},
				size = {
					order = 4,
					name = L["Size"],
					desc = L["Let's you modify the base font size to either make it larger or smaller."],
					type = "range",
					min = -20, max = 20, step = 1, softMin = -5, softMax = 5,
					hidden = false,
				},
				x = {
					order = 5,
					type = "range",
					name = L["X Offset"],
					min = -1000, max = 1000, step = 1, softMin = -100, softMax = 100,
					hidden = false,
				},
				y = {
					order = 6,
					type = "range",
					name = L["Y Offset"],
					min = -1000, max = 1000, step = 1, softMin = -100, softMax = 100,
					hidden = false,
				},
			},
		}
		
		Config.parentTable = {
			order = 0,
			type = "group",
			hidden = false,
			name = function(info) return getName(info) or string.sub(info[#(info)], 1) end,
			hidden = function(info) return not getVariable(info[2], info[#(info)], nil, "enabled") end,
			args = {}
		}
		
		local function hideBlacklistedTag(info)
			local unit = info[2]
			local tag = info[#(info)]
			
			if( unit == "global" ) then
				for unit in pairs(modifyUnits) do
					if( ShadowUF.Tags.unitRestrictions[tag] == unit ) then
						return false
					end
				end
			end
			
			if( ShadowUF.Tags.unitRestrictions[tag] and ShadowUF.Tags.unitRestrictions[tag] ~= unit ) then
				return true
			end

			return false
		end
		
		local function hideBlacklistedGroup(info)
			local unit = info[2]
			local tagGroup = info[#(info)]
			if( unit ~= "global" ) then
				if( ShadowUF.Tags.unitBlacklist[tagGroup] and string.match(unit, ShadowUF.Tags.unitBlacklist[tagGroup]) ) then
					return true
				end
			else
				-- If the only units that are in the global configuration have the tag filtered, then don't bother showing it
				for unit in pairs(modifyUnits) do
					if( not ShadowUF.Tags.unitBlacklist[tagGroup] or not string.match(unit, ShadowUF.Tags.unitBlacklist[tagGroup]) ) then
						return false
					end
				end
			end
			
			return false
		end
		
		local savedTagTexts = {}
		local function selectTag(info, value)
			local unit = info[2]
			local id = tonumber(info[#(info) - 2])
			local tag = info[#(info)]
			local text = getVariable(unit, "text", id, "text")
			local savedText

			if( value ) then
				if( unit == "global" ) then
					table.wipe(savedTagTexts)
					
					-- Set special tag texts based on the unit, so targettarget won't get a tag that will cause errors
					local tagGroup = ShadowUF.Tags.defaultCategories[tag]
					for unit in pairs(modifyUnits) do
						savedTagTexts[unit] = getVariable(unit, "text", id, "text")
						if( not ShadowUF.Tags.unitBlacklist[tagGroup] or not string.match(unit, ShadowUF.Tags.unitBlacklist[tagGroup]) ) then
							if( not ShadowUF.Tags.unitRestrictions[tag] or ShadowUF.Tags.unitRestrictions[tag] == unit ) then
								if( text == "" ) then
									savedTagTexts[unit] = string.format("[%s]", tag)
								else
									savedTagTexts[unit] = string.format("%s[( )%s]", savedTagTexts[unit], tag)
								end
								
								savedTagTexts.global = savedTagTexts[unit]
							end
						end
					end
				else
					if( text == "" ) then
						text = string.format("[%s]", tag)
					else
						text = string.format("%s[( )%s]", text, tag)
					end
				end
			-- Removing a tag from global config, need to make sure we can do it
			-- Hack, clean up later
			elseif( unit == "global" ) then
				table.wipe(savedTagTexts)
				for unit in pairs(modifyUnits) do
					if( not ShadowUF.Tags.unitBlacklist[tagGroup] or not string.match(unit, ShadowUF.Tags.unitBlacklist[tagGroup]) ) then
						if( not ShadowUF.Tags.unitRestrictions[tag] or ShadowUF.Tags.unitRestrictions[tag] == unit ) then
							local text = getVariable(unit, "text", id, "text")
							for matchedTag in string.gmatch(text, "%[(.-)%]") do
								local safeTag = "[" .. matchedTag .. "]"
								if( string.match(safeTag, "%[" .. tag .. "%]") or string.match(safeTag, "%)" .. tag .. "%]") or string.match(safeTag, "%[" .. tag .. "%(") or string.match(safeTag, "%)" .. tag .. "%(") ) then
									text = string.gsub(text, "%[" .. string.gsub(string.gsub(matchedTag, "%)", "%%)"), "%(", "%%(") .. "%]", "")
									text = string.gsub(text, "  ", "")
									text = string.trim(text)
									break
								end
							end
							
							savedTagTexts[unit] = text
							savedTagTexts.global = text
						end
					end
				end
				
			-- Removing a tag from a single unit, super easy :<
			else
				-- Ugly, but it works
				for matchedTag in string.gmatch(text, "%[(.-)%]") do
					local safeTag = "[" .. matchedTag .. "]"
					if( string.match(safeTag, "%[" .. tag .. "%]") or string.match(safeTag, "%)" .. tag .. "%]") or string.match(safeTag, "%[" .. tag .. "%(") or string.match(safeTag, "%)" .. tag .. "%(") ) then
						text = string.gsub(text, "%[" .. string.gsub(string.gsub(matchedTag, "%)", "%%)"), "%(", "%%(") .. "%]", "")
						text = string.gsub(text, "  ", "")
						text = string.trim(text)
						break
					end
				end
			end
			
			if( unit == "global" ) then
				for unit in pairs(modifyUnits) do
					if( savedTagTexts[unit] ) then
						setVariable(unit, "text", id, "text", savedTagTexts[unit])
					end
				end

				setVariable("global", "text", id, "text", savedTagTexts.global)
			else
				setVariable(unit, "text", id, "text", text)
			end
		end
		
		local function getTag(info)
			local text = getVariable(info[2], "text", tonumber(info[#(info) - 2]), "text")
			local tag = info[#(info)]
			
			-- FUN WITH PATTERN MATCHING
			if( string.match(text, "%[" .. tag .. "%]") or string.match(text, "%)" .. tag .. "%]") or string.match(text, "%[" .. tag .. "%(") or string.match(text, "%)" .. tag .. "%(") ) then
				return true
			end
			
			return false
		end
		
		Config.tagTextTable = {
			type = "group",
			name = function(info) return getVariable(info[2], "text", nil, tonumber(info[#(info)])) and getVariable(info[2], "text", tonumber(info[#(info)]), "name") or "" end,
			hidden = function(info)
				if( not getVariable(info[2], "text", nil, tonumber(info[#(info)])) ) then return true end
				return string.sub(getVariable(info[2], "text", tonumber(info[#(info)]), "anchorTo"), 2) ~= info[#(info) - 1] end,
			set = false,
			get = false,
			args = {
				text = {
					order = 0,
					type = "input",
					name = L["Text"],
					width = "full",
					hidden = false,
					set = function(info, value) setUnit(info, string.gsub(value, "||", "|")) end,
					get = function(info) return string.gsub(getUnit(info), "|", "||") end,
					arg = "text.$parent.text",
				},
			},
		}
		
		
		local function getCategoryOrder(info)
			return info[#(info)] == "health" and 1 or info[#(info)] == "power" and 2 or info[#(info)] == "misc" and 3 or 4
		end
		
		for _, cat in pairs(ShadowUF.Tags.defaultCategories) do
			Config.tagTextTable.args[cat] = Config.tagTextTable.args[cat] or {
				order = getCategoryOrder,
				type = "group",
				inline = true,
				name = getName,
				hidden = hideBlacklistedGroup,
				set = selectTag,
				get = getTag,
				args = {},
			}			
		end

		Config.tagTable = {
			order = 0,
			type = "toggle",
			hidden = hideBlacklistedTag,
			name = getTagName, 
			desc = getTagHelp,
		}
				
		local tagList = {}
		for tag in pairs(ShadowUF.Tags.defaultTags) do
			local category = ShadowUF.Tags.defaultCategories[tag] or "misc"
			Config.tagTextTable.args[category].args[tag] = Config.tagTable
		end
			
		for tag, data in pairs(ShadowUF.db.profile.tags) do
			local category = data.category or "misc"
			Config.tagTextTable.args[category].args[tag] = Config.tagTable
		end
		
		local parentList = {}
		for id, text in pairs(ShadowUF.db.profile.units.player.text) do
			parentList[text.anchorTo] = parentList[text.anchorTo] or {}
			parentList[text.anchorTo][id] = text
		end
		
		local nagityNagNagTable = {
			order = 0,
			type = "group",
			name = L["Help"],
			inline = true,
			hidden = false,
			args = {
				help = {
					order = 0,
					type = "description",
					name = L["Selecting a tag text from the left panel to change tags. Truncating width, sizing, and offsets can be done in the current panel."],
				},
			},
		}
	
		for parent, list in pairs(parentList) do
			parent = string.sub(parent, 2)
			tagWizard[parent] = Config.parentTable
			Config.parentTable.args.help = nagityNagNagTable
			
			for id in pairs(list) do
				tagWizard[parent].args[tostring(id)] = Config.tagTextTable
				tagWizard[parent].args[tostring(id) .. ":adv"] = Config.advanceTextTable
				
				quickIDMap[tostring(id) .. ":adv"] = id
			end
		end
	end
		
	local function disableAnchoredTo(info)
		local auras = getVariable(info[2], "auras", nil, info[#(info) - 1])
		
		return auras.anchorOn or not auras.enabled
	end
	
	local function disableSameAnchor(info)
		local buffs = getVariable(info[2], "auras", nil, "buffs")
		local debuffs = getVariable(info[2], "auras", nil, "debuffs")
		local anchor = buffs.enabled and buffs.prioritize and "buffs" or "debuffs"
		
		if( not getVariable(info[2], "auras", info[#(info) - 1], "enabled") ) then
			return true
		end
		
		if( ( info[#(info)] == "x" or info[#(info)] == "y" ) and ( info[#(info) - 1] == "buffs" and buffs.anchorOn or info[#(info) - 1] == "debuffs" and debuffs.anchorOn ) ) then
			return true
		end
		
		if( anchor == info[#(info) - 1] or buffs.anchorOn or debuffs.anchorOn ) then
			return false
		end	
		
		return buffs.anchorPoint == debuffs.anchorPoint
	end
	
	local defaultAuraList = {["BL"] = L["Bottom"], ["TL"] = L["Top"], ["LT"] = L["Left"], ["RT"] = L["Right"]}
	local advancedAuraList = {["BL"] = L["Bottom Left"], ["BR"] = L["Bottom Right"], ["TL"] = L["Top Left"], ["TR"] = L["Top Right"], ["RT"] = L["Right Top"], ["RB"] = L["Right Bottom"], ["LT"] = L["Left Top"], ["LB"] = L["Left Bottom"]}
	local function getAuraAnchors()
		return ShadowUF.db.profile.advanced and advancedAuraList or defaultAuraList
	end
	
	Config.auraTable = {
		type = "group",
		inline = true,
		hidden = false,
		name = function(info) return info[#(info)] == "buffs" and L["Buffs"] or L["Debuffs"] end,
		order = function(info) return info[#(info)] == "buffs" and 1 or 2 end,
		disabled = function(info) return not getVariable(info[2], "auras", info[#(info) - 1], "enabled") end,
		args = {
			enabled = {
				order = 1,
				type = "toggle",
				name = function(info) if( info[#(info) - 1] == "buffs" ) then return L["Enable buffs"] end return L["Enable debuffs"] end,
				disabled = false,
				arg = "auras.$parent.enabled",
			},
			anchorOn = {
				order = 2,
				type = "toggle",
				name = function(info) return info[#(info) - 1] == "buffs" and L["Anchor to debuffs"] or L["Anchor to buffs"] end,
				desc = L["Allows you to anchor the aura group to another, you can then choose where it will be anchored using the position.|n|nUse this if you want to duplicate the default ui style where buffs and debuffs are separate groups."],
				set = function(info, value)
					setVariable(info[2], "auras", info[#(info) - 1] == "buffs" and "debuffs" or "buffs", "anchorOn", false)
					setUnit(info, value)
				end,
				arg = "auras.$parent.anchorOn",
			},
			prioritize = {
				order = 2.25,
				type = "toggle",
				name = L["Prioritize buffs"],
				desc = L["Show buffs before debuffs when sharing the same anchor point."],
				hidden = function(info) return info[#(info) - 1] == "debuffs" end,
				disabled = function(info) 
					if( not getVariable(info[2], "auras", info[#(info) - 1], "enabled") ) then return true end
					
					local buffs = getVariable(info[2], "auras", nil, "buffs")
					local debuffs = getVariable(info[2], "auras", nil, "debuffs")
					
					return buffs.anchorOn or debuffs.anchorOn or buffs.anchorPoint ~= debuffs.anchorPoint
				end,
				arg = "auras.$parent.prioritize",
			},
			sep2 = {
				order = 6,
				type = "description",
				name = "",
				width = "full",
			},
			player = {
				order = 7,
				type = "toggle",
				name = L["Show your auras only"],
				desc = L["Filter out any auras that you did not cast yourself."],
				arg = "auras.$parent.player",
			},
			raid = {
				order = 8,
				type = "toggle",
				name = function(info) return info[#(info) - 1] == "buffs" and L["Show castable on other auras only"] or L["Show curable only"] end,
				desc = function(info) return info[#(info) - 1] == "buffs" and L["Filter out any auras that you cannot cast on another player, or yourself."] or L["Filter out any aura that you cannot cure."] end,
				width = "double",
				arg = "auras.$parent.raid",
			},
			sep3 = {
				order = 9,
				type = "description",
				name = "",
				width = "full",
			},
			selfTimers = {
				order = 9.5,
				type = "toggle",
				name = L["Timers for self auras only"],
				desc = L["Hides the cooldown ring for any auras that you did not cast."],
				hidden = hideAdvancedOption,
				arg = "auras.$parent.selfTimers",
			},
			enlargeSelf = {
				order = 10,
				type = "toggle",
				name = L["Enlarge your auras"],
				desc = L["If you casted the aura, then the buff icon will be increased in size to make it more visible."],
				arg = "auras.$parent.enlargeSelf",
			},
			selfScale = {
				order = 11,
				type = "range",
				name = L["Self aura size"],
				desc = L["Scale for auras that you casted, any number above 100% is bigger tahn default, any number below 100% is smaller than default."],
				min = 1, max = 3, step = 0.10,
				isPercent = true,
				disabled = function(info) return not getVariable(info[2], "auras", info[#(info) - 1], "enlargeSelf") end,
				hidden = hideAdvancedOption,
				arg = "auras.$parent.selfScale",
			},
			selfTimersDouble = {
				order = 11,
				type = "toggle",
				name = L["Timers for self auras only"],
				desc = L["Hides the cooldown ring for any auras that you did not cast."],
				hidden = hideBasicOption,
				arg = "auras.$parent.selfTimers",
				width = "double",
			},
			sep4 = {
				order = 12,
				type = "description",
				name = "",
				width = "full",
			},
			perRow = {
				order = 13,
				type = "range",
				name = function(info)
					local anchorPoint = getVariable(info[2], "auras", info[#(info) - 1], "anchorPoint")
					if( ShadowUF.Layout:GetColumnGrowth(anchorPoint) == "LEFT" or ShadowUF.Layout:GetColumnGrowth(anchorPoint) == "RIGHT" ) then
						return L["Per column"]
					end
					
					return L["Per row"]
				end,
				desc = L["How many auras to show in a single row."],
				min = 1, max = 100, step = 1, softMin = 1, softMax = 50,
				disabled = disableSameAnchor,
				arg = "auras.$parent.perRow",
			},
			maxRows = {
				order = 14,
				type = "range",
				name = L["Max rows"],
				desc = L["How many rows total should be used, rows will be however long the per row value is set at."],
				min = 1, max = 10, step = 1, softMin = 1, softMax = 5,
				disabled = disableSameAnchor,
				hidden = function(info)
					local anchorPoint = getVariable(info[2], "auras", info[#(info) - 1], "anchorPoint")
					if( ShadowUF.Layout:GetColumnGrowth(anchorPoint) == "LEFT" or ShadowUF.Layout:GetColumnGrowth(anchorPoint) == "RIGHT" ) then
						return true
					end
					
					return false
				end,
				arg = "auras.$parent.maxRows",
			},
			maxColumns = {
				order = 14,
				type = "range",
				name = L["Max columns"],
				desc = L["How many auras per a column for example, entering two her will create two rows that are filled up to whatever per row is set as."],
				min = 1, max = 100, step = 1, softMin = 1, softMax = 50,
				hidden = function(info)
					local anchorPoint = getVariable(info[2], "auras", info[#(info) - 1], "anchorPoint")
					if( ShadowUF.Layout:GetColumnGrowth(anchorPoint) == "LEFT" or ShadowUF.Layout:GetColumnGrowth(anchorPoint) == "RIGHT" ) then
						return false
					end
					
					return true
				end,
				disabled = disableSameAnchor,
				arg = "auras.$parent.maxRows",
			},
			size = {
				order = 15,
				type = "range",
				name = L["Size"],
				min = 1, max = 30, step = 1,
				arg = "auras.$parent.size",
			},
			sep5 = {
				order = 16,
				type = "description",
				name = "",
				width = "full",
			},
			anchorPoint = {
				order = 17,
				type = "select",
				name = L["Position"],
				desc = L["How you want this aura to be anchored to the unit frame."],
				values = getAuraAnchors,
				disabled = disableAnchoredTo,
				arg = "auras.$parent.anchorPoint",
			},
			x = {
				order = 18,
				type = "range",
				name = L["X Offset"],
				min = -1000, max = 1000, step = 1, softMin = -100, softMax = 100,
				disabled = disableSameAnchor,
				hidden = hideAdvancedOption,
				arg = "auras.$parent.x",
			},
			y = {
				order = 19,
				type = "range",
				name = L["Y Offset"],
				min = -1000, max = 1000, step = 1, softMin = -100, softMax = 100,
				disabled = disableSameAnchor,
				hidden = hideAdvancedOption,
				arg = "auras.$parent.y",
			},
		},
	}
	
	local function hideBarOption(info)
		local module = info[#(info) - 1]
		if( ShadowUF.modules[module].moduleHasBar or getVariable(info[2], module, nil, "isBar") ) then
			return false
		end
		
		return true
	end
	
	local function disableIfCastName(info)
		return not getVariable(info[2], "castBar", "name", "enabled")
	end
	
	
	Config.barTable = {
		order = getModuleOrder,
		name = getName,
		type = "group",
		inline = true,
		hidden = function(info) return hideRestrictedOption(info) or not getVariable(info[2], info[#(info)], nil, "enabled") end,
		args = {
			enableBar = {
				order = 1,
				type = "toggle",
				name = L["Show as bar"],
				desc = L["Turns this widget into a bar that can be resized and ordered just like health and power bars."],
				hidden = function(info) return ShadowUF.modules[info[#(info) - 1]].moduleHasBar end,
				arg = "$parent.isBar",
				width = "full",
			},
			background = {
				order = 1.5,
				type = "toggle",
				name = L["Show background"],
				desc = L["Show a background behind the bars with the same texture/color but faded out."],
				hidden = hideBarOption,
				arg = "$parent.background",
			},
			sep2 = {order = 1.75, type = "description", name = "", hidden = function(info)
				local moduleKey = info[#(info) - 1]
				return ( moduleKey ~= "healthBar" and moduleKey ~= "powerBar" and moduleKey ~= "druidBar" ) or not ShadowUF.db.profile.advanced
			end},
			invert = {
				order = 2,
				type = "toggle",
				name = L["Invert colors"],
				desc = L["Flips coloring so the bar color is shown as the background color and the background as the bar"],
				hidden = function(info) return ( info[#(info) - 1] ~= "healthBar"  and info[#(info) - 1] ~= "powerBar" and info[#(info) - 1] ~= "druidBar" ) or not ShadowUF.db.profile.advanced end,
				arg = "$parent.invert",
			},
			order = {
				order = 4,
				type = "range",
				name = L["Order"],
				min = 0, max = 100, step = 5,
				hidden = hideBarOption,
				arg = "$parent.order",
			},
			height = {
				order = 5,
				type = "range",
				name = L["Height"],
				desc = L["How much of the frames total height this bar should get, this is a weighted value, the higher it is the more it gets."],
				min = 0, max = 10, step = 0.1,
				hidden = hideBarOption,
				arg = "$parent.height",
			},
		},
	}
	
	Config.indicatorTable = {
		order = 0,
		name = function(info)
			if( info[#(info)] == "status" and info[2] == "player" ) then
				return L["Combat/resting status"]
			end
			
			return getName(info)
		end,
		desc = function(info) return INDICATOR_DESC[info[#(info)]] end,
		type = "group",
		hidden = hideRestrictedOption,
		args = {
			enabled = {
				order = 0,
				type = "toggle",
				name = L["Enable indicator"],
				hidden = false,
				arg = "indicators.$parent.enabled",
			},
			sep1 = {
				order = 1,
				type = "description",
				name = "",
				width = "full",
				hidden = function() return not ShadowUF.db.profile.advanced end,
			},
			anchorPoint = {
				order = 2,
				type = "select",
				name = L["Anchor point"],
				values = positionList,
				hidden = false,
				arg = "indicators.$parent.anchorPoint",
			},
			size = {
				order = 4,
				type = "range",
				name = L["Size"],
				min = 1, max = 40, step = 1,
				hidden = hideAdvancedOption,
				arg = "indicators.$parent.size",
			},
			x = {
				order = 5,
				type = "range",
				name = L["X Offset"],
				min = -100, max = 100, step = 1, softMin = -50, softMax = 50,
				hidden = false,
				arg = "indicators.$parent.x",
			},
			y = {
				order = 6,
				type = "range",
				name = L["Y Offset"],
				min = -100, max = 100, step = 1, softMin = -50, softMax = 50,
				hidden = false,
				arg = "indicators.$parent.y",
			},
		},
	}
	
	Config.unitTable = {
		type = "group",
		childGroups = "tab",
		order = getUnitOrder,
		name = getName,
		hidden = isUnitDisabled,
		args = {
			general = {
				order = 1,
				name = L["General"],
				type = "group",
				hidden = isModifiersSet,
				set = setUnit,
				get = getUnit,
				args = {
					vehicle = {
						order = 1,
						type = "group",
						inline = true,
						name = L["Vehicles"],
						hidden = function(info) return info[2] ~= "player" and info[2] ~= "party" or not ShadowUF.db.profile.advanced end,
						args = {
							disable = {
								order = 0,
								type = "toggle",
								name = L["Disable vehicle swap"],
								desc = L["Disables the unit frame from turning into a vehicle when the player enters one."],
								set = function(info, value)
									setUnit(info, value)
									local unit = info[2]
									if( unit == "player" ) then
										if( ShadowUF.Units.unitFrames.pet ) then
											ShadowUF.Units.unitFrames.pet:SetAttribute("disableVehicleSwap", ShadowUF.db.profile.units[unit].disableVehicle)
										end
										
										if( ShadowUF.Units.unitFrames.player ) then
											ShadowUF.Units:CheckVehicleStatus(ShadowUF.Units.unitFrames.player)
										end
									elseif( unit == "party" ) then
										for frame in pairs(ShadowUF.Units.unitFrames) do
											if( frame.unitType == "partypet" ) then
												frame:SetAttribute("disableVehicleSwap", ShadowUF.db.profile.units[unit].disableVehicle)
											elseif( frame.unitType == "party" ) then
												ShadowUF.Units:CheckVehicleStatus(frame)
											end
										end
									end
								end,
								arg = "disableVehicle",
							},
						},
					},
					portrait = {
						order = 2,
						type = "group",
						inline = true,
						hidden = false,
						name = L["Portrait"],
						args = {
							portrait = {
								order = 0,
								type = "toggle",
								name = string.format(L["Enable %s"], L["Portrait"]),
								arg = "portrait.enabled",
							},
							portraitType = {
								order = 1,
								type = "select",
								name = L["Portrait type"],
								values = {["class"] = L["Class icon"], ["2D"] = L["2D"], ["3D"] = L["3D"]},
								arg = "portrait.type",
							},
							alignment = {
								order = 2,
								type = "select",
								name = L["Position"],
								values = {["LEFT"] = L["Left"], ["RIGHT"] = L["Right"]},
								arg = "portrait.alignment",
							},
						},
					},
					fader = {
						order = 3,
						type = "group",
						inline = true,
						name = L["Combat fader"],
						hidden = hideRestrictedOption,
						args = {
							fader = {
								order = 0,
								type = "toggle",
								name = string.format(L["Enable %s"], L["Combat fader"]),
								desc = L["Combat fader will fade out all your frames while they are inactive and fade them back in once you are in combat or active."],
								hidden = false,
								arg = "fader.enabled",
							},
							combatAlpha = {
								order = 1,
								type = "range",
								name = L["Combat alpha"],
								desc = L["Frame alpha while this unit is in combat."],
								min = 0, max = 1.0, step = 0.1,
								arg = "fader.combatAlpha",
								hidden = false,
								isPercent = true,
							},
							inactiveAlpha = {
								order = 2,
								type = "range",
								name = L["Inactive alpha"],
								desc = L["Frame alpha when you are out of combat while having no target and 100% mana or energy."],
								min = 0, max = 1.0, step = 0.1,
								arg = "fader.inactiveAlpha",
								hidden = false,
								isPercent = true,
							},
						}
					},
					range = {
						order = 3,
						type = "group",
						inline = true,
						name = L["Range indicator"],
						hidden = hideRestrictedOption,
						args = {
							fader = {
								order = 0,
								type = "toggle",
								name = string.format(L["Enable %s"], L["Range indicator"]),
								desc = L["Fades out the unit frames of people who are not within range of you."],
								arg = "range.enabled",
								hidden = false,
							},
							inAlpha = {
								order = 1,
								type = "range",
								name = L["In range alpha"],
								desc = L["Frame alpha while this unit is in combat."],
								min = 0, max = 1.0, step = 0.05,
								arg = "range.inAlpha",
								hidden = false,
								isPercent = true,
							},
							oorAlpha = {
								order = 2,
								type = "range",
								name = L["Out of range alpha"],
								min = 0, max = 1.0, step = 0.05,
								arg = "range.oorAlpha",
								hidden = false,
								isPercent = true,
							},
						}
					},
					highlight = {
						order = 3.5,
						type = "group",
						inline = true,
						name = L["Border highlighting"],
						hidden = hideRestrictedOption,
						args = {
							mouseover = {
								order = 3,
								type = "toggle",
								name = L["On mouseover"],
								desc = L["Highlight units when you mouse over them."],
								arg = "highlight.mouseover",
								hidden = false,
							},
							attention = {
								order = 4,
								type = "toggle",
								name = L["For target/focus"],
								desc = L["Highlight units that you are targeting or have focused."],
								arg = "highlight.attention",
								hidden = function(info) return info[2] == "target" or info[2] == "focus" end,
							},
							aggro = {
								order = 5,
								type = "toggle",
								name = L["On aggro"],
								desc = L["Highlight units that have aggro on any mob."],
								arg = "highlight.aggro",
								hidden = function(info) return info[2] == "arena" or info[2] == "arenapet" or ShadowUF.fakeUnits[info[2]] end,
							},
							debuff = {
								order = 6,
								type = "toggle",
								name = L["On curable debuff"],
								desc = L["Highlight units that are debuffed with something you can cure."],
								arg = "highlight.debuff",
								hidden = function(info) return string.match(info[2], "^arena") or string.match(info[2], "^boss") end,
							},
							alpha = {
								order = 7,
								type = "range",
								name = L["Border alpha"],
								min = 0, max = 1, step = 0.05,
								isPercent = true,
								hidden = false,
								arg = "highlight.alpha",
							},
							size = {
								order = 8,
								type = "range",
								name = L["Border thickness"],
								min = 0, max = 50, step = 1,
								arg = "highlight.size",
								hidden = false,
							},
						},
					},
					-- This might need some help text indicating why the options disappeared, will see.
					barComboPoints = {
						order = 4,
						type = "group",
						inline = true,
						name = L["Combo points"],
						hidden = function(info) return not getVariable(info[2], "comboPoints", nil, "isBar") or not getVariable(info[2], nil, nil, "comboPoints") end,
						args = {
							enabled = {
								order = 1,
								type = "toggle",
								name = string.format(L["Enable %s"], L["Combo points"]),
								hidden = false,
								arg = "comboPoints.enabled",
							},
							growth = {
								order = 2,
								type = "select",
								name = L["Growth"],
								values = {["LEFT"] = L["Left"], ["RIGHT"] = L["Right"]},
								hidden = false,
								arg = "comboPoints.growth",
							},
						},
					},
					comboPoints = {
						order = 4,
						type = "group",
						inline = true,
						name = L["Combo points"],
						hidden = function(info) if( info[2] == "global" or getVariable(info[2], "comboPoints", nil, "isBar") ) then return true end return hideRestrictedOption(info) end,
						args = {
							enabled = {
								order = 0,
								type = "toggle",
								name = string.format(L["Enable %s"], L["Combo points"]),
								hidden = false,
								arg = "comboPoints.enabled",
							},
							sep1 = {
								order = 1,
								type = "description",
								name = "",
								width = "full",
								hidden = hideAdvancedOption,
							},
							growth = {
								order = 2,
								type = "select",
								name = L["Growth"],
								values = {["UP"] = L["Up"], ["LEFT"] = L["Left"], ["RIGHT"] = L["Right"], ["DOWN"] = L["Down"]},
								hidden = false,
								arg = "comboPoints.growth",
							},
							size = {
								order = 2,
								type = "range",
								name = L["Size"],
								min = 0, max = 50, step = 1, softMin = 0, softMax = 20,
								hidden = hideAdvancedOption,
								arg = "comboPoints.size",
							},
							spacing = {
								order = 3,
								type = "range",
								name = L["Spacing"],
								min = -20, max = 20, step = 1, softMin = -10, softMax = 10,
								hidden = hideAdvancedOption,
								arg = "comboPoints.spacing",
							},
							sep2 = {
								order = 4,
								type = "description",
								name = "",
								width = "full",
								hidden = hideAdvancedOption,
							},
							anchorPoint = {
								order = 5,
								type = "select",
								name = L["Anchor point"],
								values = positionList,
								hidden = false,
								arg = "comboPoints.anchorPoint",
							},
							x = {
								order = 6,
								type = "range",
								name = L["X Offset"],
								min = -20, max = 20, step = 1,
								hidden = false,
								arg = "comboPoints.x",
							},
							y = {
								order = 7,
								type = "range",
								name = L["Y Offset"],
								min = -20, max = 20, step = 1,
								hidden = false,
								arg = "comboPoints.y",
							},
						},
					},
					combatText = {
						order = 5,
						type = "group",
						inline = true,
						name = L["Combat text"],
						hidden = hideRestrictedOption,
						args = {
							combatText = {
								order = 0,
								type = "toggle",
								name = string.format(L["Enable %s"], L["Combat text"]),
								desc = L["Shows combat feedback, last healing the unit received, last hit did it miss, resist, dodged and so on."],
								arg = "combatText.enabled",
								hidden = false,
							},
							sep = {
								order = 1,
								type = "description",
								name = "",
								width = "full",
								hidden = hideAdvancedOption,
							},
							anchorPoint = {
								order = 3,
								type = "select",
								name = L["Anchor point"],
								values = positionList,
								arg = "combatText.anchorPoint",
								hidden = hideAdvancedOption,
							},
							x = {
								order = 4,
								type = "range",
								name = L["X Offset"],
								min = -50, max = 50, step = 1,
								arg = "combatText.x",
								hidden = hideAdvancedOption,
							},
							y = {
								order = 5,
								type = "range",
								name = L["Y Offset"],
								min = -50, max = 50, step = 1,
								arg = "combatText.y",
								hidden = hideAdvancedOption,
							},
						},
					},
				},
			},
			attributes = {
				order = 1.5,
				type = "group",
				name = function(info) return L.units[info[#(info) - 1]] end,
				hidden = function(info)
					local unit = info[#(info) - 1]
					return unit ~= "raid" and unit ~= "raidpet" and unit ~= "party" and unit ~= "mainassist" and unit ~= "maintank" and unit ~= "boss" and unit ~= "arena"
				end,
				set = function(info, value)
					setUnit(info, value)

					ShadowUF.Units:ReloadHeader(info[2])
					ShadowUF.modules.movers:Update()
				end,
				get = getUnit,
				args = {
					show = {
						order = 0.5,
						type = "group",
						inline = true,
						name = L["Visibility"],
						hidden = function(info) return info[2] ~= "party" and info[2] ~= "raid" end,
						args = {
							showPlayer = {
								order = 0,
								type = "toggle",
								name = L["Show player in party"],
								desc = L["The player frame will not be hidden regardless, you will have to manually disable it either entirely or per zone type."],
								hidden = function(info) return info[2] ~= "party" end,
								arg = "showPlayer",
							},
							hideSemiRaid = {
								order = 1,
								type = "toggle",
								name = L["Hide in 6-man raid"],
								desc = L["Party frames are hidden while in a raid group with more than 5 people inside."],
								hidden = function(info) return info[2] ~= "party" end,
								set = function(info, value)
									if( value ) then
										setVariable(info[2], nil, nil, "hideAnyRaid", false)
									end

									setVariable(info[2], nil, nil, "hideSemiRaid", value)
									ShadowUF.Units:ReloadHeader(info[#(info) - 3])
								end,
								arg = "hideSemiRaid",
							},
							hideRaid = {
								order = 2,
								type = "toggle",
								name = L["Hide in any raid"],
								desc = L["Party frames are hidden while in any sort of raid no matter how many people."],
								hidden = function(info) return info[2] ~= "party" end,
								set = function(info, value)
									if( value ) then
										setVariable(info[2], nil, nil, "hideSemiRaid", false)
									end

									setVariable(info[2], nil, nil, "hideAnyRaid", value)
									ShadowUF.Units:ReloadHeader(info[#(info) - 3])
								end,
								arg = "hideAnyRaid",
							},
							separateFrames = {
								order = 3,
								type = "toggle",
								name = L["Separate raid frames"],
								desc = L["Splits raid frames into individual frames for each raid group instead of one single frame.|nNOTE! You cannot drag each group frame individualy, but how they grow is set through the column and row growth options."],
								hidden = function(info) return info[2] ~= "raid" end,	
								arg = "frameSplit",
							},
							showInRaid = {
								order = 4,
								type = "toggle",
								name = L["Show party as raid"],
								hidden = hideRaidOption,
								set = function(info, value)
									setUnit(info, value)
									
									ShadowUF.Units:ReloadHeader("party")
									ShadowUF.Units:ReloadHeader("raid")
									ShadowUF.modules.movers:Update()
								end,
								arg = "showParty",
							},
						},
					},
					general = {
						order = 1,
						type = "group",
						inline = true,
						name = L["General"],
						hidden = false,
						args = {
							offset = {
								order = 2,
								type = "range",
								name = L["Row offset"],
								desc = L["Spacing between each row"],
								min = -10, max = 100, step = 1,
								arg = "offset",
							},
							attribPoint = {
								order = 3,
								type = "select",
								name = L["Row growth"],
								desc = L["How the rows should grow when new group members are added."],
								values = {["TOP"] = L["Down"], ["BOTTOM"] = L["Up"], ["LEFT"] = L["Right"], ["RIGHT"] = L["Left"]},
								arg = "attribPoint",
								set = function(info, value)
									-- If you set the frames to grow left, the columns have to grow down or up as well
									local attribAnchorPoint = getVariable(info[2], nil, nil, "attribAnchorPoint")
									if( ( value == "LEFT" or value == "RIGHT" ) and attribAnchorPoint ~= "BOTTOM" and attribAnchorPoint ~= "TOP" ) then
										ShadowUF.db.profile.units[info[2]].attribAnchorPoint = "BOTTOM"
									elseif( ( value == "TOP" or value == "BOTTOM" ) and attribAnchorPoint ~= "LEFT" and attribAnchorPoint ~= "RIGHT" ) then
										ShadowUF.db.profile.units[info[2]].attribAnchorPoint = "RIGHT"
									end
									
									setUnit(info, value)

									local position = ShadowUF.db.profile.positions[info[2]]
									if( position.top and position.bottom ) then
										local point = ShadowUF.db.profile.units[info[2]].attribAnchorPoint == "RIGHT" and "RIGHT" or "LEFT"
										position.point = (ShadowUF.db.profile.units[info[2]].attribPoint == "BOTTOM" and "BOTTOM" or "TOP") .. point
										position.y = ShadowUF.db.profile.units[info[2]].attribPoint == "BOTTOM" and position.bottom or position.top
									end

									ShadowUF.Units:ReloadHeader(info[2])
									ShadowUF.modules.movers:Update()
								end,
							},
							sep2 = { 
								order = 4,
								type = "description",
								name = "",
								width = "full",
								hidden = false,
							},
							columnSpacing = {
								order = 5,
								type = "range",
								name = L["Column spacing"],
								min = -30, max = 100, step = 1,
								hidden = hideRaidOrAdvancedOption,
								arg = "columnSpacing",
							},
							attribAnchorPoint = {
								order = 6,
								type = "select",
								name = L["Column growth"],
								desc = L["How the frames should grow when a new column is added."],
								values = function(info)
									local attribPoint = getVariable(info[2], nil, nil, "attribPoint")
									if( attribPoint == "LEFT" or attribPoint == "RIGHT" ) then
										return {["TOP"] = L["Down"], ["BOTTOM"] = L["Up"]}
									end
									
									return {["LEFT"] = L["Right"], ["RIGHT"] = L["Left"]}
								end,
								hidden = hideRaidOrAdvancedOption,
								set = function(info, value)
									-- If you set the frames to grow left, the columns have to grow down or up as well
									local attribPoint = getVariable(info[2], nil, nil, "attribPoint")
									if( ( value == "LEFT" or value == "RIGHT" ) and attribPoint ~= "BOTTOM" and attribPoint ~= "TOP" ) then
										ShadowUF.db.profile.units[info[2]].attribPoint = "BOTTOM"
									end
								
									setUnit(info, value)

									ShadowUF.Units:ReloadHeader(info[2])
									ShadowUF.modules.movers:Update()
								end,
								arg = "attribAnchorPoint",
							},
							sep3 = { 
								order = 7,
								type = "description",
								name = "",
								width = "full",
								hidden = false,
							},
							maxColumns = {
								order = 8,
								type = "range",
								name = L["Max columns"],
								min = 1, max = 20, step = 1,
								arg = "maxColumns",
								hidden = function(info) return info[2] == "boss" or info[2] == "arena" or hideSplitOrRaidOption(info) end,
							},
							unitsPerColumn = {
								order = 8,
								type = "range",
								name = L["Units per column"],
								min = 1, max = 40, step = 1,
								arg = "unitsPerColumn",
								hidden = function(info) return info[2] == "boss" or info[2] == "arena" or hideSplitOrRaidOption(info) end,
							},
							partyPerColumn = {
								order = 9,
								type = "range",
								name = L["Units per column"],
								min = 1, max = 5, step = 1,
								arg = "unitsPerColumn",
								hidden = function(info) return info[2] ~= "party" or not ShadowUF.db.profile.advanced end,
							},
							groupsPerRow = {
								order = 8,
								type = "range",
								name = L["Groups per row"],
								desc = L["How many groups should be shown per row."],
								min = 1, max = 8, step = 1,
								arg = "groupsPerRow",
								hidden = function(info) return info[2] ~= "raid" or not ShadowUF.db.profile.units.raid.frameSplit end,
							},
							groupSpacing = {
								order = 9,
								type = "range",
								name = L["Group row spacing"],
								desc = L["How much spacing should be between each new row of groups."],
								min = -50, max = 50, step = 1,
								arg = "groupSpacing",
								hidden = function(info) return info[2] ~= "raid" or not ShadowUF.db.profile.units.raid.frameSplit end,
							},
						},
					},
					sort = {
						order = 2,
						type = "group",
						inline = true,
						name = L["Sorting"],
						hidden = function(info) return info[2] == "boss" or info[2] == "arena" or ( info[2] ~= "raid" and not ShadowUF.db.profile.advanced ) end,
						args = {
							sortMethod = {
								order = 2,
								type = "select",
								name = L["Sort method"],
								values = {["INDEX"] = L["Index"], ["NAME"] = L["Name"]},
								arg = "sortMethod",
								hidden = false,
							},
							sortOrder = {
								order = 2,
								type = "select",
								name = L["Sort order"],
								values = {["ASC"] = L["Ascending"], ["DESC"] = L["Descending"]},
								arg = "sortOrder",
								hidden = false,
							},
						},
					},
					raid = {
						order = 3,
						type = "group",
						inline = true,
						name = L["Groups"],
						hidden = hideRaidOption,
						args = {
							groupBy = {
								order = 4,
								type = "select",
								name = L["Group by"],
								values = {["GROUP"] = L["Group number"], ["CLASS"] = L["Class"]},
								arg = "groupBy",
								hidden = hideSplitOrRaidOption,
							},
							sortMethod = {
								order = 5,
								type = "select",
								name = L["Sort method"],
								values = {["INDEX"] = L["Index"], ["NAME"] = L["Name"]},
								arg = "sortMethod",
								hidden = false,
							},
							sortOrder = {
								order = 6,
								type = "select",
								name = L["Sort order"],
								values = {["ASC"] = L["Ascending"], ["DESC"] = L["Descending"]},
								arg = "sortOrder",
								hidden = false,
							},
							selectedGroups = {
								order = 7,
								type = "multiselect",
								name = L["Groups to show"],
								values = {string.format(L["Group %d"], 1), string.format(L["Group %d"], 2), string.format(L["Group %d"], 3), string.format(L["Group %d"], 4), string.format(L["Group %d"], 5), string.format(L["Group %d"], 6), string.format(L["Group %d"], 7), string.format(L["Group %d"], 8)},
								set = function(info, key, value)
									local tbl = getVariable(info[2], nil, nil, "filters")
									tbl[key] = value
									
									setVariable(info[2], "filters", nil, tbl)
									ShadowUF.Units:ReloadHeader(info[2])
									ShadowUF.modules.movers:Update()
								end,
								get = function(info, key)
									return getVariable(info[2], nil, nil, "filters")[key]
								end,
								hidden = function(info) return info[2] ~= "raid" and info[2] ~= "raidpet" end,
							},
						},
					},
				},
			},
			frame = {
				order = 2,
				name = L["Frame"],
				type = "group",
				hidden = isModifiersSet,
				set = setUnit,
				get = getUnit,
				args = {
					size = {
						order = 0,
						type = "group",
						inline = true,
						name = L["Size"],
						hidden = false,
						set = function(info, value)
							setUnit(info, value)
							ShadowUF.modules.movers:Update()
						end,
						args = {
							scale = {
								order = 0,
								type = "range",
								name = L["Scale"],
								min = 0.50, max = 1.50, step = 0.01,
								isPercent = true,
								arg = "scale",
							},
							height = {
								order = 1,
								type = "range",
								name = L["Height"],
								min = 0, max = 100, step = 1,
								arg = "height",
							},
							width = {
								order = 2,
								type = "range",
								name = L["Width"],
								min = 0, max = 300, step = 1,
								arg = "width",
							},
						},
					},
					anchor = {
						order = 1,
						type = "group",
						inline = true,
						hidden = function(info) return info[2] == "global" end,
						name = L["Anchor to another frame"],
						set = setPosition,
						get = getPosition,
						args = {
							anchorPoint = {
								order = 0.50,
								type = "select",
								name = L["Anchor point"],
								values = positionList,
								hidden = false,
								get = function(info)
									local position = ShadowUF.db.profile.positions[info[2]]
									if( ShadowUF.db.profile.advanced ) then
										return position[info[#(info)]]
									end
									
									
									return position.movedAnchor or position[info[#(info)]]
								end,
							},
							anchorTo = {
								order = 1,
								type = "select",
								name = L["Anchor to"],
								values = getAnchorParents,
								hidden = false,
							},
							sep = {
								order = 2,
								type = "description",
								name = "",
								width = "full",
								hidden = false,
							},
							x = {
								order = 3,
								type = "input",
								name = L["X Offset"],
								validate = checkNumber,
								set = setNumber,
								get = getString,
								hidden = false,
							},
							y = {
								order = 4,
								type = "input",
								name = L["Y Offset"],
								validate = checkNumber,
								set = setNumber,
								get = getString,
								hidden = false,
							},
						},
					},
					orHeader = {
						order = 1.5,
						type = "header",
						name = L["Or you can set a position manually"],
						hidden = function(info) if( info[2] == "global" or hideAdvancedOption() ) then return true else return false end end,
					},
					position = {
						order = 2,
						type = "group",
						hidden = function(info) if( info[2] == "global" or hideAdvancedOption() ) then return true else return false end end,
						inline = true,
						name = L["Manual position"],
						set = setPosition,
						get = getPosition,
						args = {
							point = {
								order = 0,
								type = "select",
								name = L["Point"],
								values = pointPositions,
								hidden = false,
							},
							anchorTo = {
								order = 0.50,
								type = "select",
								name = L["Anchor to"],
								values = getAnchorParents,
								hidden = false,
							},
							relativePoint = {
								order = 1,
								type = "select",
								name = L["Relative point"],
								values = pointPositions,
								hidden = false,
							},
							sep = {
								order = 2,
								type = "description",
								name = "",
								width = "full",
								hidden = false,
							},
							x = {
								order = 3,
								type = "input",
								name = L["X Offset"],
								validate = checkNumber,
								set = setNumber,
								get = getString,
								hidden = false,
							},
							y = {
								order = 4,
								type = "input",
								name = L["Y Offset"],
								validate = checkNumber,
								set = setNumber,
								get = getString,
								hidden = false,
							},
						},
					},
				},
			},
			bars = {
				order = 3,
				name = L["Bars"],
				type = "group",
				hidden = isModifiersSet,
				set = setUnit,
				get = getUnit,
				args = {
					bar = {
						order = 1,
						type = "group",
						inline = true,
						name = L["General"],
						hidden = false,
						args = {
							runeBar = {
								order = 1,
								type = "toggle",
								name = string.format(L["Enable %s"], L["Rune bar"]),
								desc = L["Adds rune bars and timers before runes refresh to the player frame."],
								hidden = hideRestrictedOption,
								arg = "runeBar.enabled",
							},
							totemBar = {
								order = 1.5,
								type = "toggle",
								name = string.format(L["Enable %s"], ShadowUF.modules.totemBar.moduleName),
								desc = function(info)
									return select(2, UnitClass("player")) == "SHAMAN" and L["Adds totem bars with timers before they expire to the player frame."] or L["Adds a bar indicating how much time is left on your ghoul timer, only used if you do not have a permanent ghoul."]
								end,
								hidden = hideRestrictedOption,
								arg = "totemBar.enabled",
							},
							druidBar = {
								order = 1,
								type = "toggle",
								name = string.format(L["Enable %s"], L["Druid mana bar"]),
								desc = L["Adds another mana bar to the player frame when you are in Bear or Cat form showing you how much mana you have."],
								hidden = hideRestrictedOption,
								arg = "druidBar.enabled",
							},
							xpBar = {
								order = 2,
								type = "toggle",
								name = string.format(L["Enable %s"], L["XP/Rep bar"]),
								desc = L["This bar will automatically hide when you are at the level cap, or you do not have any reputations tracked."],
								hidden = hideRestrictedOption,
								arg = "xpBar.enabled",
							},
							sep = {
								order = 3,
								type = "description",
								name = "",
								hidden = function(info) return playerClass ~= "DRUID" and playerClass ~= "SHAMAN" and playerClass ~= "DEATHKNIGHT" and info[2] ~= "player" end,
							},
							powerBar = {
								order = 4,
								type = "toggle",
								name = string.format(L["Enable %s"], L["Power bar"]),
								arg = "powerBar.enabled",
							},
							predictPower = {
								order = 5,
								type = "toggle",
								name = L["Enable quick power"],
								desc = L["Turns fast updating of the power bar on giving you more up to date power information than normal."],
								arg = "powerBar.predicted",
							},
						},
					},
					healthBar = {
						order = 2,
						type = "group",
						inline = true,
						name = L["Health bar"],
						hidden = false,
						args = {
							enabled = {
								order = 1,
								type = "toggle",
								name = string.format(L["Enable %s"], L["Health bar"]),
								arg = "healthBar.enabled",
							},
							predictedHealth = {
								order = 3,
								type = "toggle",
								name = L["Enable quick health"],
								desc = L["Turns on fast updating of health bars giving you more up to date health info."],
								arg = "healthBar.predicted",
							},
							sep = {
								order = 3.5,
								type = "description",
								name = "",
							},
							healthColor = {
								order = 4,
								type = "select",
								name = L["Color health by"],
								desc = L["Primary means of coloring the health bar, color on aggro and color by reaction will override this if necessary."],
								values = {["class"] = L["Class"], ["static"] = L["Static"], ["percent"] = L["Health percent"]},
								arg = "healthBar.colorType",
							},
							reactionPet = {
								order = 5,
								type = "toggle",
								name = L["Color by happiness"],
								desc = L["Colors the health bar by how happy your pet is."],
								arg = "healthBar.reactionType",
								set = function(info, value) setVariable(info[2], "healthBar", nil, "reactionType", value and "happiness" or "none") end,
								get = function(info) return getVariable(info[2], "healthBar", nil, "reactionType") == "happiness" and true or false end,
								hidden = function(info) return info[2] ~= "pet" end,
							},
							reaction = {
								order = 5,
								type = "select",
								name = L["Color by reaction on"],
								desc = L["When to color the health bar by the units reaction, overriding the color health by option."],
								arg = "healthBar.reactionType",
								values = {["none"] = L["Never (Disabled)"], ["player"] = L["Players only"], ["npc"] = L["NPCs only"], ["both"] = L["Both"]},
								hidden = function(info) return info[2] == "player" or info[2] == "pet" end,
							},
							colorAggro = {
								order = 6,
								type = "toggle",
								name = L["Color on aggro"],
								desc = L["Changes the health bar to the set hostile color (Red by default) when the unit takes aggro."],
								arg = "healthBar.colorAggro",
								hidden = hideRestrictedOption,
							},
						},
					},
					incHeal = {
						order = 3,
						type = "group",
						inline = true,
						name = L["Incoming heals"],
						hidden = hideRestrictedOption,
						disabled = function(info) return not getVariable(info[2], "healthBar", nil, "enabled") end,
						args = {
							enabled = {
								order = 1,
								type = "toggle",
								name = string.format(L["Enable %s"], L["Incoming heals"]),
								desc = L["Adds a bar inside the health bar indicating how much healing someone is estimated to be receiving."],
								arg = "incHeal.enabled",
								hidden = false,
							},
							cap = {
								order = 2,
								type = "range",
								name = L["Outside bar limit"],
								desc = L["Percentage value of how far outside the unit frame the incoming heal bar can go. 130% means it will go 30% outside the frame, 100% means it will not go outside."],
								min = 1, max = 1.50, step = 0.05, isPercent = true,
								arg = "incHeal.cap",
								hidden = false,
							},
						},
					},
					emptyBar = {
						order = 4,
						type = "group",
						inline = true,
						name = L["Empty bar"],
						hidden = false,
						args = {
							enabled = {
								order = 1,
								type = "toggle",
								name = string.format(L["Enable %s"], L["Empty bar"]),
								desc = L["Adds an empty bar that you can put text into as a way of uncluttering other bars."],
								arg = "emptyBar.enabled",
								width = "full",
							},
							reaction = {
								order = 2,
								type = "select",
								name = L["Color by reaction on"],
								desc = L["When to color the empty bar by reaction, overriding the default color by option."],
								arg = "emptyBar.reactionType",
								values = {["none"] = L["Never (Disabled)"], ["player"] = L["Players only"], ["npc"] = L["NPCs only"], ["both"] = L["Both"]},
							},
							colorType = {
								order = 3,
								type = "toggle",
								name = L["Color by class"],
								desc = L["Players will be colored by class, "],
								arg = "emptyBar.class",
							},
							overrideColor = {
								order = 4,
								type = "color",
								name = L["Background color"],
								disabled = function(info)
									local emptyBar = getVariable(info[2], nil, nil, "emptyBar") 
									return emptyBar.class and emptyBar.reaciton
								end,
								set = function(info, r, g, b)
									local color = getUnit(info) or {}
									color.r = r
									color.g = g
									color.b = b
									
									setUnit(info, color)
								end,
								get = function(info)
									local color = getUnit(info)
									if( not color ) then
										return 0, 0, 0
									end
									
									return color.r, color.g, color.b

								end,
								arg = "emptyBar.backgroundColor",
							},
						},
					},
					castBar = {
						order = 5,
						type = "group",
						inline = true,
						name = L["Cast bar"],
						hidden = hideRestrictedOption,
						args = {
							enabled = {
								order = 1,
								type = "toggle",
								name = string.format(L["Enable %s"], L["Cast bar"]),
								desc = function(info) return ShadowUF.fakeUnits[info[2]] and string.format(L["Due to the nature of fake units, cast bars for %s are not super efficient and can take at most 0.10 seconds to notice a change in cast."], L.units[info[2]] or info[2]) end,
								hidden = false,
								arg = "castBar.enabled",
							},
							autoHide = {
								order = 2,
								type = "toggle",
								name = L["Hide bar when empty"],
								desc = L["Hides the cast bar if there is no cast active."],
								hidden = false,
								arg = "castBar.autoHide",
							},
							castIcon = {
								order = 2.5,
								type = "select",
								name = L["Cast icon"],
								arg = "castBar.icon",
								values = {["LEFT"] = L["Left"], ["RIGHT"] = L["Right"], ["HIDE"] = L["Disabled"]},
								hidden = false,
							},
							castName = {
								order = 3,
								type = "header",
								name = L["Cast name"],
								hidden = hideAdvancedOption,
							},
							nameEnabled = {
								order = 4,
								type = "toggle",
								name = L["Show cast name"],
								arg = "castBar.name.enabled",
								hidden = hideAdvancedOption,
							},
							rankEnabled = {
								order = 4.5,
								type = "toggle",
								name = L["Show cast rank"],
								arg = "castBar.name.rank",
								hidden = hideAdvancedOption,
								disabled = disableIfCastName,
							},
							nameAnchor = {
								order = 5,
								type = "select",
								name = L["Anchor point"],
								desc = L["Where to anchor the cast name text."],
								values = {["CLI"] = L["Inside Center Left"], ["CRI"] = L["Inside Center Right"]},
								hidden = hideAdvancedOption,
								arg = "castBar.name.anchorPoint",
							},
							nameSep = {
								order = 6,
								type = "description",
								name = "",
								width = "full",
								hidden = hideAdvancedOption,
							},
							nameSize = {
								order = 7,
								type = "range",
								name = L["Size"],
								desc = L["Let's you modify the base font size to either make it larger or smaller."],
								type = "range",
								min = -10, max = 10, step = 1, softMin = -5, softMax = 5,
								hidden = hideAdvancedOption,
								arg = "castBar.name.size",
							},
							nameX = {
								order = 8,
								type = "range",
								name = L["X Offset"],
								min = -20, max = 20, step = 1,
								hidden = hideAdvancedOption,
								arg = "castBar.name.x",
							},
							nameY = {
								order = 9,
								type = "range",
								name = L["Y Offset"],
								min = -20, max = 20, step = 1,
								hidden = hideAdvancedOption,
								arg = "castBar.name.y",
							},
							castTime = {
								order = 10,
								type = "header",
								name = L["Cast time"],
								hidden = hideAdvancedOption,
							},
							timeEnabled = {
								order = 11,
								type = "toggle",
								name = L["Show cast time"],
								arg = "castBar.time.enabled",
								hidden = hideAdvancedOption,
							},
							timeAnchor = {
								order = 12,
								type = "select",
								name = L["Anchor point"],
								desc = L["Where to anchor the cast time text."],
								values = {["CLI"] = L["Inside Center Left"], ["CRI"] = L["Inside Center Right"]},
								hidden = hideAdvancedOption,
								arg = "castBar.time.anchorPoint",
							},
							timeSep = {
								order = 13,
								type = "description",
								name = "",
								width = "full",
								hidden = hideAdvancedOption,
							},
							timeSize = {
								order = 14,
								type = "range",
								name = L["Size"],
								desc = L["Let's you modify the base font size to either make it larger or smaller."],
								type = "range",
								min = -10, max = 10, step = 1, softMin = -5, softMax = 5,
								hidden = hideAdvancedOption,
								arg = "castBar.time.size",
							},
							timeX = {
								order = 15,
								type = "range",
								name = L["X Offset"],
								min = -20, max = 20, step = 1,
								hidden = hideAdvancedOption,
								arg = "castBar.time.x",
							},
							timeY = {
								order = 16,
								type = "range",
								name = L["Y Offset"],
								min = -20, max = 20, step = 1,
								hidden = hideAdvancedOption,
								arg = "castBar.time.y",
							},
						},
					},
				},
			},
			widgetSize = {
				order = 4,
				name = L["Widget size"],
				type = "group",
				hidden = isModifiersSet,
				set = setUnit,
				get = getUnit,
				args = {
					help = {
						order = 0,
						type = "group",
						name = L["Help"],
						inline = true,
						hidden = false,
						args = {
							help = {
								order = 0,
								type = "description",
								name = L["Bars with an order higher or lower than the full size options will use the entire unit frame width.|n|nBar orders between those two numbers are shown next to the portrait."],
							},
						},
					},
					portrait = {
						order = 0.5,
						type = "group",
						name = L["Portrait"],
						inline = true,
						hidden = false,
						args = {
							enableBar = {
								order = 1,
								type = "toggle",
								name = L["Show as bar"],
								desc = L["Changes this widget into a bar, you will be able to change the height and ordering like you can change health and power bars."],
								arg = "$parent.isBar",
							},
							sep = {
								order = 1.5,
								type = "description",
								name = "",
								width = "full",
								hidden = function(info) return getVariable(info[2], "portrait", nil, "isBar") end,
							},
							width = {
								order = 2,
								type = "range",
								name = L["Width percent"],
								desc = L["Percentage of width the portrait should use."],
								min = 0, max = 1.0, step = 0.01, isPercent = true,
								hidden = function(info) return getVariable(info[2], "portrait", nil, "isBar") end,
								arg = "$parent.width",
							},
							before = {
								order = 3,
								type = "range",
								name = L["Full size before"],
								min = 0, max = 100, step = 5,
								hidden = function(info) return getVariable(info[2], "portrait", nil, "isBar") end,
								arg = "$parent.fullBefore",
							},
							after = {
								order = 4,
								type = "range",
								name = L["Full size after"],
								min = 0, max = 100, step = 5,
								hidden = function(info) return getVariable(info[2], "portrait", nil, "isBar") end,
								arg = "$parent.fullAfter",
							},
							order = {
								order = 3,
								type = "range",
								name = L["Order"],
								min = 0, max = 100, step = 5,
								hidden = hideBarOption,
								arg = "portrait.order",
							},
							height = {
								order = 4,
								type = "range",
								name = L["Height"],
								desc = L["How much of the frames total height this bar should get, this is a weighted value, the higher it is the more it gets."],
								min = 0, max = 10, step = 0.1,
								hidden = hideBarOption,
								arg = "portrait.height",
							},
						},
					},
				},
			},
			auras = {
				order = 5,
				name = L["Auras"],
				type = "group",
				hidden = isModifiersSet,
				set = setUnit,
				get = getUnit,
				args = {
					temp = {
						order = 0,
						type = "group",
						inline = true,
						name = L["Temporary enchants"],
						hidden = function(info) return info[2] ~= "player" end,
						args = {
							temporary = {
								order = 0,
								type = "toggle",
								name = L["Enable temporary enchants"],
								desc = L["Adds temporary enchants to the buffs for the player."],
								disabled = function(info) return not getVariable(info[2], "auras", "buffs", "enabled") end,
								arg = "auras.buffs.temporary",
								width = "double",
							},
						},
					},
					buffs = Config.auraTable,
					debuffs = Config.auraTable,
				},
			},
			indicators = {
				order = 5.5,
				type = "group",
				name = L["Indicators"],
				hidden = isModifiersSet,
				childGroups = "tree",
				set = setUnit,
				get = getUnit,
				args = {
				},
			},
			tag = {
				order = 7,
				name = L["Text/Tags"],
				type = "group",
				hidden = isModifiersSet,
				childGroups = "tree",
				args = tagWizard,
			},
		},
	}
	
	for _, indicator in pairs(ShadowUF.modules.indicators.list) do
		Config.unitTable.args.indicators.args[indicator] = Config.indicatorTable
	end
	
	options.args.enableUnits = {
		type = "group",
		name = L["Enabled units"],
		desc = getPageDescription,
		args = {
			help = {
				order = 1,
				type = "group",
				inline = true,
				name = L["Help"],
				hidden = hideBasicOption,
				args = {
					help = {
						order = 0,
						type = "description",
						name = L["The check boxes below will allow you to enable or disable units."],
					},
				},
			},
			enabled = {
				order = 2,
				type = "group",
				inline = true,
				name = L["Enable units"],
				args = {},
			},
		},
	}
	
	options.args.units = {
		type = "group",
		name = L["Unit configuration"],
		desc = getPageDescription,
		args = {
			help = {
				order = 1,
				type = "group",
				inline = true,
				name = L["Help"],
				args = {
					help = {
						order = 0,
						type = "description",
						name = L["Wondering what all of the tabs for the unit configuration mean? Here's some information:|n|n|cfffed000General:|r Portrait, range checker, combat fader, border highlighting|n|cfffed000Frame:|r Unit positioning and frame anchoring|n|cfffed000Bars:|r Health, power, empty and cast bar, and combo point configuration|n|cfffed000Widget size:|r All bar and portrait sizing and ordering options|n|cfffed000Auras:|r All aura configuration for enabling/disabling/enlarging self/etc|n|cfffed000Indicators:|r All indicator configuration|n|cfffed000Text/Tags:|r Tag management as well as text positioning and width settings.|n|n|n*** Frequently looked for options ***|n|n|cfffed000Raid frames by group|r - Unit configuration -> Raid -> Raid -> Separate raid frames|n|cfffed000Class coloring:|r Bars -> Color health by|n|cfffed000Timers on auras:|r You need OmniCC for that|n|cfffed000Showing/Hiding default buff frames:|r Hide Blizzard -> Hide buff frames|n|cfffed000Percentage HP/MP text:|r Tags/Text tab, use the [percenthp] or [percentpp] tags|n|cfffed000Hiding party based on raid|r - Unit configuration -> Party -> Party -> Hide in 6-man raid/Hide in any raid"],
						fontSize = "medium",
					},
				},
			},
			global = {
				type = "group",
				childGroups = "tab",
				order = 0,
				name = L["Global"],
				args = {
					units = {
						order = 0,
						type = "group",
						name = L["Units"],
						set = function(info, value)
							local unit = info[#(info)]
							if( IsShiftKeyDown() ) then
								for _, unit in pairs(ShadowUF.unitList) do
									if( ShadowUF.db.profile.units[unit].enabled ) then
										modifyUnits[unit] = value and true or nil
										
										if( value ) then
											globalConfig = mergeTables(globalConfig, ShadowUF.db.profile.units[unit])
										end
									end
								end
							else
								modifyUnits[unit] = value and true or nil

								if( value ) then
									globalConfig = mergeTables(globalConfig, ShadowUF.db.profile.units[unit])
								end
							end
							
							-- Check if we have nothing else selected, if so wipe it
							local hasUnit
							for k in pairs(modifyUnits) do hasUnit = true break end
							if( not hasUnit ) then
								globalConfig = {}
							end
							
							AceRegistry:NotifyChange("ShadowedUF")
						end,
						get = function(info) return modifyUnits[info[#(info)]] end,
						args = {
							help = {
								order = 0,
								type = "group",
								name = L["Help"],
								inline = true,
								args = {
									help = {
										order = 0,
										type = "description",
										name = L["Select the units that you want to modify, any settings changed will change every unit you selected. If you want to anchor or change raid/party unit specific settings you will need to do that through their options.|n|nShift click a unit to select all/unselect all."],
									},
								},
							},
							units = {
								order = 1,
								type = "group",
								name = L["Units"],
								inline = true,
								args = {},
							},
						},
					},
				},
			},
		},
	}
	
	-- Load modules into the unit table
	for key, module in pairs(ShadowUF.modules) do
		local canHaveBar = module.moduleHasBar
		for _, data in pairs(ShadowUF.defaults.profile.units) do
			if( data[key] and data[key].isBar ~= nil ) then
				canHaveBar = true
			end
		end
		
		if( canHaveBar ) then
			Config.unitTable.args.widgetSize.args[key] = Config.barTable
		end
	end

	-- Load global unit
	for k, v in pairs(Config.unitTable.args) do
		options.args.units.args.global.args[k] = v
	end

	-- Load all of the per unit settings
	local perUnitList = {
		order = getUnitOrder,
		type = "toggle",
		name = getName,
		hidden = isUnitDisabled,
		desc = function(info)
			return string.format(L["Adds %s to the list of units to be modified when you change values in this tab."], L.units[info[#(info)]])
		end,
	}
	
	-- Enabled units list
	local unitCatOrder = {}
	local enabledUnits = {
		order = function(info) return unitCatOrder[info[#(info)]] + getUnitOrder(info) end,
		type = "toggle",
		name = getName,
		set = function(info, value)
			local unit = info[#(info)]
			for child, parent in pairs(ShadowUF.Units.childUnits) do
				if( unit == parent and not value ) then
					ShadowUF.db.profile.units[child].enabled = false
				end
			end
			
			ShadowUF.modules.movers:Update()
			ShadowUF.db.profile.units[unit].enabled = value
			ShadowUF:LoadUnits()

			-- Update party frame visibility
			if( unit == "raid" and ShadowUF.Units.headerFrames.party ) then
				ShadowUF.Units:SetHeaderAttributes(ShadowUF.Units.headerFrames.party, "party")
			end
			
			ShadowUF.modules.movers:Update()
		end,
		get = function(info)
			return ShadowUF.db.profile.units[info[#(info)]].enabled
		end,
		desc = function(info)
			local unit = info[#(info)]
			local unitDesc = UNIT_DESC[unit] or ""
			
			if( ShadowUF.db.profile.units[unit].enabled and ShadowUF.Units.childUnits[unit] ) then
				if( unitDesc ~= "" ) then unitDesc = unitDesc .. "\n\n" end
				return unitDesc .. string.format(L["This unit depends on another to work, disabling %s will disable %s."], L.units[ShadowUF.Units.childUnits[unit]], L.units[unit])
			elseif( not ShadowUF.db.profile.units[unit].enabled ) then 
				for child, parent in pairs(ShadowUF.Units.childUnits) do
					if( parent == unit ) then
						if( unitDesc ~= "" ) then unitDesc = unitDesc .. "\n\n" end
						return unitDesc .. L["This unit has child units that depend on it, you need to enable this unit before you can enable its children."]
					end
				end
			end
			
			return unitDesc ~= "" and unitDesc
		end,
		disabled = function(info)
			local unit = info[#(info)]
			if( ShadowUF.Units.childUnits[unit] ) then
				return not ShadowUF.db.profile.units[ShadowUF.Units.childUnits[unit]].enabled	
			end
			
			return false
		end,
	}
	
	local unitCategory = {
		order = function(info)
			local cat = info[#(info)]
			return cat == "playercat" and 50 or cat == "generalcat" and 100 or cat == "partycat" and 200 or cat == "raidcat" and 300 or 400
		end,
		type = "header",
		name = function(info)
			local cat = info[#(info)]
			return cat == "playercat" and L["Player"] or cat == "generalcat" and L["General"] or cat == "raidcat" and L["Raid"] or cat == "partycat" and L["Party"] or cat == "arenacat" and L["Arena"]
		end,
		width = "full",
	}
	
	for cat, list in pairs(unitCategories) do
		options.args.enableUnits.args.enabled.args[cat .. "cat"] = unitCategory

		for _, unit in pairs(list) do
			unitCatOrder[unit] = cat == "player" and 50 or cat == "general" and 100 or cat == "party" and 200 or cat == "raid" and 300 or 400
		end
	end

	for order, unit in pairs(ShadowUF.unitList) do
		options.args.enableUnits.args.enabled.args[unit] = enabledUnits
		options.args.units.args.global.args.units.args.units.args[unit] = perUnitList
		options.args.units.args[unit] = Config.unitTable
		
		unitCatOrder[unit] = unitCatOrder[unit] or 100
	end
end

---------------------
-- FILTER CONFIGURATION
---------------------
local function loadFilterOptions()
	local hasWhitelist, hasBlacklist, rebuildFilters
	local filterMap, spellMap = {}, {}

	local manageFiltersTable = {
		order = function(info) return info[#(info)] == "whitelists" and 1 or 2 end,
		type = "group",
		name = function(info) return info[#(info)] == "whitelists" and L["Whitelists"] or L["Blacklists"] end,
		args = {
		},
	}
	
	local function reloadUnitAuras()
		for _, frame in pairs(ShadowUF.Units.unitFrames) do
			if( UnitExists(frame.unit) and frame.visibility.auras ) then
				ShadowUF.modules.auras:UpdateFilter(frame)
				frame:FullUpdate()
			end
		end
	end
	
	local function setFilterType(info, value)
		local filter = filterMap[info[#(info) - 2]]
		local filterType = info[#(info) - 3]
		
		ShadowUF.db.profile.filters[filterType][filter][info[#(info)]] = value
		reloadUnitAuras()
	end
	
	local function getFilterType(info)
		local filter = filterMap[info[#(info) - 2]]
		local filterType = info[#(info) - 3]
		
		return ShadowUF.db.profile.filters[filterType][filter][info[#(info)]]
	end
	
	--- Container widget for the filter listing
	local filterEditTable = {
		order = 0,
		type = "group",
		name = function(info) return filterMap[info[#(info)]] end,
		hidden = function(info) return not ShadowUF.db.profile.filters[info[#(info) - 1]][filterMap[info[#(info)]]] end,
		args = {
			general = {
				order = 0,
				type = "group",
				name = function(info) return filterMap[info[#(info) - 1]] end,
				hidden = false,
				inline = true,
				args = {
					add = {
						order = 0,
						type = "input",
						name = L["Aura name"],
						--dialogControl = "Aura_EditBox",
						hidden = false,
						set = function(info, value)
							local filterType = info[#(info) - 3]
							local filter = filterMap[info[#(info) - 2]]

							ShadowUF.db.profile.filters[filterType][filter][value] = true

							reloadUnitAuras()
							rebuildFilters()
						end,
					},
					delete = {
						order = 1,
						type = "execute",
						name = L["Delete filter"],
						hidden = false,
						confirmText = L["Are you sure you want to delete this filter?"],
						confirm = true,
						func = function(info, value)
							local filterType = info[#(info) - 3]
							local filter = filterMap[info[#(info) - 2]]
							
							ShadowUF.db.profile.filters[filterType][filter] = nil
							
							-- Delete anything that used this filter too
							local filterList = filterType == "whitelist" and ShadowUF.db.profile.filters.zonewhite or filterType == "blacklist" and ShadowUF.db.profile.filters.zoneblack
							for id, filterUsed in pairs(filterList) do
								if( filterUsed == filter ) then
									filterList[id] = nil
								end
							end
							
							reloadUnitAuras()
							rebuildFilters()
						end,
					},
				},
			},
			filters = {
				order = 2,
				type = "group",
				inline = true,
				hidden = false,
				name = L["Aura types to filter"],
				args = {
					buffs = {
						order = 4,
						type = "toggle",
						name = L["Buffs"],
						desc = L["When this filter is active, apply the filter to buffs."],
						set = setFilterType,
						get = getFilterType,
					},
					debuffs = {
						order = 5,
						type = "toggle",
						name = L["Debuffs"],
						desc = L["When this filter is active, apply the filter to debuffs."],
						set = setFilterType,
						get = getFilterType,
					},
				},
			},
			spells = {
				order = 3,
				type = "group",
				inline = true,
				name = L["Auras"],
				hidden = false,
				args = {
				
				},
			},
		},
	}
	
	-- Spell list for manage aura filters
	local spellLabel = {
		order = function(info) return tonumber(string.match(info[#(info)], "(%d+)")) end,
		type = "description",
		-- Odd I know, AceConfigDialog-3.0 expands descriptions to full width if width is nil
		-- on the other hand we can't set width to "normal" so tricking it
		width = "", 
		fontSize = "medium",
		name = function(info) return spellMap[info[#(info)]] end,
	}
	
	local spellRow = {
		order = function(info) return tonumber(string.match(info[#(info)], "(%d+)")) + 0.5 end,
		type = "execute",
		name = L["Delete"],
		width = "half",
		func = function(info)
			local spell = spellMap[info[#(info)]]
			local filter = filterMap[info[#(info) - 2]]
			local filterType = info[#(info) - 3]
			
			ShadowUF.db.profile.filters[filterType][filter][spell] = nil
			rebuildFilters()
		end
	}

	local noSpells = {
		order = 0,
		type = "description",
		name = L["This filter has no auras in it, you will have to add some using the dialog above."],
	}

	-- The filter [View] widgets for manage aura filters
	local filterLabel = {
		order = function(info) return tonumber(string.match(info[#(info)], "(%d+)")) end,
		type = "description",
		width = "", -- Odd I know, AceConfigDialog-3.0 expands descriptions to full width if width is nil
		fontSize = "medium",
		name = function(info) return filterMap[info[#(info)]] end,
	}
	
	local filterRow = {
		order = function(info) return tonumber(string.match(info[#(info)], "(%d+)")) + 0.5 end,
		type = "execute",
		name = L["View"],
		width = "half",
		func = function(info)
			local filterType = info[#(info) - 2]
			
			AceDialog.Status.ShadowedUF.children.filter.children.filters.status.groups.groups[filterType] = true
			selectTabGroup("filter", "filters", filterType .. "\001" .. string.match(info[#(info)], "(%d+)"))
		end
	}
		
	local noFilters = {
		order = 0,
		type = "description",
		name = L["You do not have any filters of this type added yet, you will have to create one in the management panel before this page is useful."],
	}

	-- Container table for a filter zone
	local globalSettings = {}
	local zoneList = {"none", "pvp", "arena", "party", "raid"}
	local filterTable = {
		order = function(info) return info[#(info)] == "global" and 1 or info[#(info)] == "none" and 2 or 3 end,
		type = "group",
		inline = true,
		hidden = function() return not hasWhitelist and not hasBlacklist end,
		name = function(info) return AREA_NAMES[info[#(info)]] or L["Global"] end,
		set = function(info, value)
			local filter = filterMap[info[#(info)]]
			local zone = info[#(info) - 1]
			local unit = info[#(info) - 2]
			local filterKey = ShadowUF.db.profile.filters.whitelists[filter] and "zonewhite" or "zoneblack"
			
			for _, zoneConfig in pairs(zoneList) do
				if( zone == "global" or zoneConfig == zone ) then
					if( unit == "global" ) then
						globalSettings[zoneConfig .. filterKey] = value and filter or false
						
						for _, unit in pairs(ShadowUF.unitList) do
							ShadowUF.db.profile.filters[filterKey][zoneConfig .. unit] = value and filter or nil
						end
					else
						ShadowUF.db.profile.filters[filterKey][zoneConfig .. unit] = value and filter or nil
					end
				end
			end
			
			if( zone == "global" ) then
				globalSettings[zone .. unit .. filterKey] = value and filter or false
			end
			
			reloadUnitAuras()
		end,
		get = function(info)
			local filter = filterMap[info[#(info)]]
			local zone = info[#(info) - 1]
			local unit = info[#(info) - 2]
			
			if( unit == "global" or zone == "global" ) then 
				local id = zone == "global" and zone .. unit or zone
				local filterKey = ShadowUF.db.profile.filters.whitelists[filter] and "zonewhite" or "zoneblack"
				
				if( info[#(info)] == "nofilter" ) then
					return globalSettings[id .. "zonewhite"] == false and globalSettings[id .. "zoneblack"] == false
				end

				return globalSettings[id .. filterKey] == filter
			end
			
			if( info[#(info)] == "nofilter" ) then
				return not ShadowUF.db.profile.filters.zonewhite[zone .. unit] and not ShadowUF.db.profile.filters.zoneblack[zone .. unit]
			end
			
			return ShadowUF.db.profile.filters.zonewhite[zone .. unit] == filter or ShadowUF.db.profile.filters.zoneblack[zone .. unit] == filter
		end,
		args = {
			nofilter = {
				order = 0,
				type = "toggle",
				name = L["Don't use a filter"],
				hidden = false,
				set = function(info, value)
					local filter = filterMap[info[#(info)]]
					local zone = info[#(info) - 1]
					local unit = info[#(info) - 2]
				
					for _, zoneConfig in pairs(zoneList) do
						if( zone == "global" or zoneConfig == zone ) then
							if( unit == "global" ) then
								globalSettings[zoneConfig .. "zonewhite"] = false
								globalSettings[zoneConfig .. "zoneblack"] = false
								
								for _, unit in pairs(ShadowUF.unitList) do
									ShadowUF.db.profile.filters.zonewhite[zoneConfig .. unit] = nil
									ShadowUF.db.profile.filters.zoneblack[zoneConfig .. unit] = nil
								end
							else
								ShadowUF.db.profile.filters.zonewhite[zoneConfig .. unit] = nil
								ShadowUF.db.profile.filters.zoneblack[zoneConfig .. unit] = nil
							end
						end
					end

					if( zone == "global" ) then
						globalSettings[zone .. unit .. "zonewhite"] = false
						globalSettings[zone .. unit .. "zoneblack"] = false
					end

					reloadUnitAuras()
				end,
			},
			white = {
				order = 1,
				type = "header",
				name = "|cffffffff" .. L["Whitelists"] .. "|r",
				hidden = function(info) return not hasWhitelist end
			},
			black = {
				order = 3,
				type = "header",
				name = L["Blacklists"], -- In theory I would make this black, but as black doesn't work with a black background I'll skip that
				hidden = function(info) return not hasBlacklist end
			},
		},
	}
	
	-- Toggle used for set filter zones to enable filters
	local filterToggle = {
		order = function(info) return ShadowUF.db.profile.filters.whitelists[filterMap[info[#(info)]]] and 2 or 4 end,
		type = "toggle",
		name = function(info) return filterMap[info[#(info)]] end,
		desc = function(info)
			local filter = filterMap[info[#(info)]]
			filter = ShadowUF.db.profile.filters.whitelists[filter] or ShadowUF.db.profile.filters.blacklists[filter]
			if( filter.buffs and filter.debuffs ) then
				return L["Filtering both buffs and debuffs"]
			elseif( filter.buffs ) then
				return L["Filtering buffs only"]
			elseif( filter.debuffs ) then
				return L["Filtering debuffs only"]
			end
			
			return L["This filter has no aura types set to filter out."]
		end,
	}
	
	-- Load existing filters in
	-- This needs to be cleaned up later
	local filterID, spellID = 0, 0
	local function buildList(type)
		local manageFiltersTable = {
			order = type == "whitelists" and 1 or 2,
			type = "group",
			name = type == "whitelists" and L["Whitelists"] or L["Blacklists"],
			args = {
				groups = {
					order = 0,
					type = "group",
					inline = true,
					name = function(info) return info[#(info) - 1] == "whitelists" and L["Whitelist filters"] or L["Blacklist filters"] end,
					args = {
					},
				},
			},
		}
		
		local hasFilters
		for name, spells in pairs(ShadowUF.db.profile.filters[type]) do
			hasFilters = true
			filterID = filterID + 1
			filterMap[tostring(filterID)] = name
			filterMap[filterID .. "label"] = name
			filterMap[filterID .. "row"] = name
			
			manageFiltersTable.args[tostring(filterID)] = CopyTable(filterEditTable)
			manageFiltersTable.args.groups.args[filterID .. "label"] = filterLabel
			manageFiltersTable.args.groups.args[filterID .. "row"] = filterRow
			filterTable.args[tostring(filterID)] = filterToggle
			
			local hasSpells
			for spellName in pairs(spells) do
				if( spellName ~= "buffs" and spellName ~= "debuffs" ) then
					hasSpells = true
					spellID = spellID + 1
					spellMap[tostring(spellID)] = spellName
					spellMap[spellID .. "label"] = spellName
					
					manageFiltersTable.args[tostring(filterID)].args.spells.args[spellID .. "label"] = spellLabel
					manageFiltersTable.args[tostring(filterID)].args.spells.args[tostring(spellID)] = spellRow
				end
			end
			
			if( not hasSpells ) then
				manageFiltersTable.args[tostring(filterID)].args.spells.args.noSpells = noSpells
			end
		end
		
		if( not hasFilters ) then
			if( type == "whitelists" ) then hasWhitelist = nil else hasBlacklist = nil end
			manageFiltersTable.args.groups.args.noFilters = noFilters
		end
		
		return manageFiltersTable
	end
	
	rebuildFilters = function()
		for id in pairs(filterMap) do filterTable.args[id] = nil end
	
		spellID = 0
		filterID = 0
		hasBlacklist = true
		hasWhitelist = true
	
		table.wipe(filterMap)
		table.wipe(spellMap)
		
		options.args.filter.args.filters.args.whitelists = buildList("whitelists")
		options.args.filter.args.filters.args.blacklists = buildList("blacklists")
	end
		
	local unitFilterSelection = {
		order = function(info) return info[#(info)] == "global" and 1 or (getUnitOrder(info) + 1) end,
		type = "group",
		name = function(info) return info[#(info)] == "global" and L["Global"] or getName(info) end,
		disabled = function(info)
			if( info[#(info)] == "global" ) then
				return false
			end
			
			return not hasWhitelist and not hasBlacklist
		end,
		args = {
			help = {
				order = 0,
				type = "group",
				inline = true,
				name = L["Help"],
				hidden = function() return hasWhitelist or hasBlacklist end,
				args = {
					help = {
						type = "description",
						name = L["You will need to create an aura filter before you can set which unit to enable aura filtering on."],
						width = "full",
					}
				},
			},
			header = {
				order = 0,
				type = "header",
				name = function(info) return (info[#(info) - 1] == "global" and L["Global"] or L.units[info[#(info) - 1]]) end,
				hidden = function() return not hasWhitelist and not hasBlacklist end,
			},
			global = filterTable,
			none = filterTable,
			pvp = filterTable,
			arena = filterTable,
			party = filterTable,
			raid = filterTable,
		}
	}
	
	local addFilter = {type = "whitelists"}
	
	options.args.filter = {
		type = "group",
		name = L["Aura filters"],
		childGroups = "tab",
		desc = getPageDescription,
		args = {
			groups = {
				order = 1,
				type = "group",
				name = L["Set filter zones"],
				args = {
					help = {
						order = 0,
						type = "group",
						inline = true,
						name = L["Help"],
						args = {
							help = {
								type = "description",
								name = L["You can set what unit frame should use what filter group and in what zone type here, if you want to change what auras goes into what group then see the \"Manage aura groups\" option."],
								width = "full",
							}
						},
					},
				}
			},
			filters = {
				order = 2,
				type = "group",
				name = L["Manage aura filters"],
				childGroups = "tree",
				args = {
					manage = {
						order = 1,
						type = "group",
						name = L["Management"],
						args = {
							help = {
								order = 0,
								type = "group",
								inline = true,
								name = L["Help"],
								args = {
									help = {
										type = "description",
										name = L["Whitelists will hide any aura not in the filter group.|nBlacklists will hide auras that are in the filter group."],
										width = "full",
									}
								},
							},
							error = {
								order = 1,
								type = "group",
								inline = true,
								hidden = function() return not addFilter.error end,
								name = L["Error"],
								args = {
									error = {
										order = 0,
										type = "description",
										name = function() return addFilter.error end,
										width = "full",
									},
								},
							},
							add = {
								order = 2,
								type = "group",
								inline = true,
								name = L["New filter"],
								get = function(info) return addFilter[info[#(info)]] end,
								args = {
									name = {
										order = 0,
										type = "input",
										name = L["Name"],
										set = function(info, value)
											addFilter[info[#(info)]] = string.trim(value) ~= "" and value or nil
											addFilter.error = nil
										end,
										get = function(info) return addFilter.errorName or addFilter.name end,
										validate = function(info, value)
											local name = string.lower(string.trim(value))
											for filter in pairs(ShadowUF.db.profile.filters.whitelists) do
												if( string.lower(filter) == name ) then
													addFilter.error = string.format(L["The whitelist \"%s\" already exists."], value)
													addFilter.errorName = value
													AceRegistry:NotifyChange("ShadowedUF")
													return ""
												end
											end

											for filter in pairs(ShadowUF.db.profile.filters.blacklists) do
												if( string.lower(filter) == name ) then
													addFilter.error = string.format(L["The blacklist \"%s\" already exists."], value)
													addFilter.errorName = value
													AceRegistry:NotifyChange("ShadowedUF")
													return ""
												end
											end
											
											addFilter.error = nil
											addFilter.errorName = nil
											return true
										end,
									},
									type = {
										order = 1,
										type = "select",
										name = L["Filter type"],
										set = function(info, value) addFilter[info[#(info)]] = value end,
										values = {["whitelists"] = L["Whitelist"], ["blacklists"] = L["Blacklist"]},
									},
									add = {
										order = 2,
										type = "execute",
										name = L["Create"],
										disabled = function(info) return not addFilter.name end,
										func = function(info)
											ShadowUF.db.profile.filters[addFilter.type][addFilter.name] = {buffs = true, debuffs = true}
											rebuildFilters()
											
											local id
											for key, value in pairs(filterMap) do
												if( value == addFilter.name ) then
													id = key
													break
												end
											end
											
											AceDialog.Status.ShadowedUF.children.filter.children.filters.status.groups.groups[addFilter.type] = true
											selectTabGroup("filter", "filters", addFilter.type .. "\001" .. id)
											
											table.wipe(addFilter)
											addFilter.type = "whitelists"
										end,
									},
								},
							},
						},
					},
				},
			},
		},
	}


	options.args.filter.args.groups.args.global = unitFilterSelection
	for _, unit in pairs(ShadowUF.unitList) do
		options.args.filter.args.groups.args[unit] = unitFilterSelection
	end

	rebuildFilters()
end

---------------------
-- TAG CONFIGURATION
---------------------
local function loadTagOptions()
	local tagData = {search = ""}
	local function set(info, value, key)
		local key = key or info[#(info)]
		if( ShadowUF.Tags.defaultHelp[tagData.name] ) then
			return
		end
		
		-- Reset loaded function + reload tags
		if( key == "funct" ) then
			ShadowUF.tagFunc[tagData.name] = nil
			ShadowUF.Tags:Reload()
		elseif( key == "category" ) then
			local cat = ShadowUF.db.profile.tags[tagData.name][key]
			if( cat and cat ~= value ) then
				Config.tagTextTable.args[cat].args[tagData.name] = nil
				Config.tagTextTable.args[value].args[tagData.name] = Config.tagTable
			end
		end

		ShadowUF.db.profile.tags[tagData.name][key] = value
	end
	
	local function stripCode(text)
		if( not text ) then
			return ""
		end
		
		return string.gsub(string.gsub(text, "|", "||"), "\t", "")
	end
	
	local function get(info, key)
		local key = key or info[#(info)]
		
		if( key == "help" and ShadowUF.Tags.defaultHelp[tagData.name] ) then
			return ShadowUF.Tags.defaultHelp[tagData.name] or ""
		elseif( key == "events" and ShadowUF.Tags.defaultEvents[tagData.name] ) then
			return ShadowUF.Tags.defaultEvents[tagData.name] or ""
		elseif( key == "frequency" and ShadowUF.Tags.defaultFrequents[tagData.name] ) then
			return ShadowUF.Tags.defaultFrequents[tagData.name] or ""
		elseif( key == "category" and ShadowUF.Tags.defaultCategories[tagData.name] ) then
			return ShadowUF.Tags.defaultCategories[tagData.name] or ""
		elseif( key == "name" and ShadowUF.Tags.defaultNames[tagData.name] ) then
			return ShadowUF.Tags.defaultNames[tagData.name] or ""
		elseif( key == "funct" and ShadowUF.Tags.defaultTags[tagData.name] ) then
			return ShadowUF.Tags.defaultTags[tagData.name] or ""
		end
				
		return ShadowUF.db.profile.tags[tagData.name] and ShadowUF.db.profile.tags[tagData.name][key] or ""
	end
		
	local function isSearchHidden(info)
		return tagData.search ~= "" and not string.match(info[#(info)], tagData.search) or false
	end
	
	local function editTag(info)
		tagData.name = info[#(info)]
		
		if( ShadowUF.Tags.defaultHelp[tagData.name] ) then
			tagData.error = L["You cannot edit this tag because it is one of the default ones included in this mod. This function is here to provide an example for your own custom tags."]
		end
		
		selectDialogGroup("tags", "edit")
	end
				
	-- Create all of the tag editor options, if it's a default tag will show it after any custom ones
	local tagTable = {
		type = "execute",
		order = function(info) return ShadowUF.Tags.defaultTags[info[#(info)]] and 100 or 1 end,
		name = getTagName,
		desc = getTagHelp,
		hidden = isSearchHidden,
		func = editTag,
	}
	
	local tagCategories = {}
	local function getTagCategories(info)
		for k in pairs(tagCategories) do tagCategories[k] = nil end
		
		for _, cat in pairs(ShadowUF.Tags.defaultCategories) do
			tagCategories[cat] = TAG_GROUPS[cat]
		end
		
		return tagCategories
	end
	
	-- Tag configuration
	options.args.tags = {
		type = "group",
		childGroups = "tab",
		name = L["Add tags"],
		desc = getPageDescription,
		hidden = hideAdvancedOption,
		args = {
			general = {
				order = 0,
				type = "group",
				name = L["Tag list"],
				args = {
					help = {
						order = 0,
						type = "group",
						inline = true,
						name = L["Help"],
						hidden = function() return ShadowUF.db.profile.advanced end,
						args = {
							description = {
								order = 0,
								type = "description",
								name = L["You can add new custom tags through this page, if you're looking to change what tags are used in text look under the Text tab for an Units configuration."],
							},
						},
					},
					search = {
						order = 1,
						type = "group",
						inline = true,
						name = L["Search"],
						args = {
							search = {
								order = 1,
								type = "input",
								name = L["Search tags"],
								set = function(info, text) tagData.search = text end,
								get = function(info) return tagData.search end,
							},
						},
					},
					list = {
						order = 2,
						type = "group",
						inline = true,
						name = L["Tags"],
						args = {},
					},
				},
			},
			add = {
				order = 1,
				type = "group",
				name = L["Add new tag"],
				args = {
					help = {
						order = 0,
						type = "group",
						inline = true,
						name = L["Help"],
						args = {
							help = {
								order = 0,
								type = "description",
								name = L["You can find more information on creating your own custom tags in the \"Help\" tab above."],
							},
						},
					},
					add = {
						order = 1,
						type = "group",
						inline = true,
						name = L["Add new tag"],
						args = {
							error = {
								order = 0,
								type = "description",
								name = function() return tagData.addError or "" end,
								hidden = function() return not tagData.addError end,
							},
							errorHeader = {
								order = 0.50,
								type = "header",
								name = "",
								hidden = function() return not tagData.addError end,
							},
							tag = {
								order = 1,
								type = "input",
								name = L["Tag name"],
								desc = L["Tag that you will use to access this code, do not wrap it in brackets or parenthesis it's automatically done. For example, you would enter \"foobar\" and then access it with [foobar]."],
								validate = function(info, text)
									if( text == "" ) then
										tagData.addError = L["You must enter a tag name."]
									elseif( string.match(text, "[%[%]%(%)]") ) then
										tagData.addError = string.format(L["You cannot name a tag \"%s\", tag names should contain no brackets or parenthesis."], text)
									elseif( ShadowUF.tagFunc[text] ) then
										tagData.addError = string.format(L["The tag \"%s\" already exists."], text)
									else
										tagData.addError = nil
									end
									
									AceRegistry:NotifyChange("ShadowedUF")
									return tagData.addError and "" or true
								end,
								set = function(info, tag)
									tagData.name = tag
									tagData.error = nil
									tagData.addError = nil
									
									ShadowUF.db.profile.tags[tag] = {func = "function(unit, unitOwner)\n\nend", category = "misc"}
									options.args.tags.args.general.args.list.args[tag] = tagTable
									Config.tagTextTable.args.misc.args[tag] = Config.tagTable
									
									selectDialogGroup("tags", "edit")
								end,
							},
						},
					},
				},
			},
			edit = {
				order = 2,
				type = "group",
				name = L["Edit tag"],
				hidden = function() return not tagData.name end,
				args = {
					help = {
						order = 0,
						type = "group",
						inline = true,
						name = L["Help"],
						args = {
							help = {
								order = 0,
								type = "description",
								name = L["You can find more information on creating your own custom tags in the \"Help\" tab above.|nSUF will attempt to automatically detect what events your tag will need, so you do not generally need to fill out the events field."],
							},
						},
					},
					tag = {
						order = 1,
						type = "group",
						inline = true,
						name = function() return string.format(L["Editing %s"], tagData.name or "") end,
						args = {
							error = {
								order = 0,
								type = "description",
								name = function() return tagData.error or "" end,
								hidden = function() return not tagData.error end,
							},
							errorHeader = {
								order = 1,
								type = "header",
								name = "",
								hidden = function() return not tagData.error end,
							},
							discovery = {
								order = 1,
								type = "toggle",
								name = L["Disable event discovery"],
								desc = L["This will disable the automatic detection of what events this tag will need, you should leave this unchecked unless you know what you are doing."],
								set = function(info, value) tagData.discovery = value end,
								get = function() return tagData.discovery end,
								width = "full",
							},
							frequencyEnable = {
								order = 1.10,
								type = "toggle",
								name = L["Enable frequent updates"],
								desc = L["Flags the tag for frequent updating, it will update the tag on a timer regardless of any events firing."],
								set = function(info, value) 
									tagData.frequency = value and 5 or nil
									set(info, tagData.frequency, "frequency")
								end,
								get = function(info) return get(info, "frequency") ~= "" and true or false end,
								width = "full",
							},
							frequency = {
								order = 1.20,
								type = "input",
								name = L["Update interval"],
								desc = L["How many seconds between updates.|n[WARNING] By setting the frequency to 0 it will update every single frame redraw, if you want to disable frequent updating uncheck it don't set this to 0."],
								disabled = function(info) return get(info) == "" end,
								validate = function(info, value)
									value = tonumber(value)
									if( not value ) then
										tagData.error = L["Invalid interval entered, must be a number."]
									elseif( value < 0 ) then
										tagData.error = L["You must enter a number that is 0 or higher, negative numbers are not allowed."]
									else
										tagData.error = nil
									end
									
									if( tagData.error ) then
										AceRegistry:NotifyChange("ShadowedUF")
										return ""
									end
									
									return true
								end,
								set = function(info, value)
									tagData.frequency = tonumber(value)
									tagData.frequency = tagData.frequency < 0 and 0 or tagData.frequency
									
									set(info, tagData.frequency)
								end,
								get = function(info) return tostring(get(info) or "") end,
								width = "half",
							},
							name = {
								order = 2,
								type = "input",
								name = L["Tag name"],
								set = set,
								get = get,
							},
							category = {
								order = 2.5,
								type = "select",
								name = L["Category"],
								values = getTagCategories,
								set = set,
								get = get,
							},

							sep = {
								order = 2.75,
								type = "description",
								name = "",
								width = "full",
							},
							events = {
								order = 3,
								type = "input",
								name = L["Events"],
								desc = L["Events that should be used to trigger an update of this tag. Separate each event with a single space."],
								width = "full",
								validate = function(info, text)
									if( ShadowUF.Tags.defaultTags[tagData.name] ) then
										return true
									end

									if( text == "" or string.match(text, "[^_%a%s]") ) then
										tagData.error = L["You have to set the events to fire, you can only enter letters and underscores, \"FOO_BAR\" for example is valid, \"APPLE_5_ORANGE\" is not because it contains a number."]
										tagData.eventError = text
										AceRegistry:NotifyChange("ShadowedUF")
										return ""
									end
									
									tagData.eventError = text
									tagData.error = nil
									return true			
								end,
								set = set,
								get = function(info)
									if( tagData.eventError ) then
										return tagData.eventError
									end
									
									return get(info)
								end,
							},
							func = {
								order = 4,
								type = "input",
								multiline = true,
								name = L["Code"],
								desc = L["Your code must be wrapped in a function, for example, if you were to make a tag to return the units name you would do:|n|nfunction(unit, unitOwner)|nreturn UnitName(unitOwner)|nend"],
								width = "full",
								validate = function(info, text)
									if( ShadowUF.Tags.defaultTags[tagData.name] ) then
										return true
									end
									
									local funct, msg = loadstring("return " .. text)
									if( not string.match(text, "function") ) then
										tagData.error = L["You must wrap your code in a function."]
										tagData.funcError = text
									elseif( not funct and msg ) then
										tagData.error = string.format(L["Failed to save tag, error:|n %s"], msg)
										tagData.funcError = text
									else
										tagData.error = nil
										tagData.funcError = nil
									end
									
									AceRegistry:NotifyChange("ShadowedUF")
									return tagData.error and "" or true
								end,
								set = function(info, value)
									value = string.gsub(value, "||", "|")
									set(info, value)
									
									-- Try and automatically identify the events this tag is going to want to use
									if( not tagData.discovery ) then
										tagData.eventError = nil
										ShadowUF.db.profile.tags[tagData.name].events = ShadowUF.Tags:IdentifyEvents(value) or ""
									end
									
									ShadowUF.Tags:Reload(tagData.name)
								end,
								get = function(info)
									if( tagData.funcError ) then
										return stripCode(tagData.funcError)
									end
									return stripCode(ShadowUF.Tags.defaultTags[tagData.name] or ( ShadowUF.db.profile.tags[tagData.name] and ShadowUF.db.profile.tags[tagData.name].func))
								end,
							},
							delete = {
								order = 5,
								type = "execute",
								name = L["Delete"],
								hidden = function() return ShadowUF.Tags.defaultTags[tagData.name] end,
								confirm = true,
								confirmText = L["Are you sure you want to delete this tag?"],
								func = function(info)
									local category = ShadowUF.db.profile.tags[tagData.name].category
									if( category ) then
										Config.tagTextTable.args[category].args[tagData.name] = nil
									end
									
									options.args.tags.args.general.args.list.args[tagData.name] = nil
									
									ShadowUF.db.profile.tags[tagData.name] = nil
									ShadowUF.tagFunc[tagData.name] = nil
									ShadowUF.Tags:Reload(tagData.name)

									tagData.name = nil
									tagData.error = nil
									selectDialogGroup("tags", "general")
								end,
							},
						},
					},
				},
			},
			help = {
				order = 3,
				type = "group",
				name = L["Help"],
				args = {
					general = {
						order = 0,
						type = "group",
						name = L["General"],
						inline = true,
						args = {
							general = {
								order = 0,
								type = "description",
								name = L["See the documentation below for information and examples on creating tags, if you just want basic Lua or WoW API information then see the Programming in Lua and WoW Programming links."],
							},
						},
					},
					documentation = {
						order = 1,
						type = "group",
						name = L["Documentation"],
						inline = true,
						args = {
							doc = {
								order = 0,
								type = "input",
								name = L["Documentation"],
								set = false,
								get = function() return "http://wiki.github.com/Shadowed/ShadowedUnitFrames/tag-documentation" end,
								width = "full",
							},
						},
					},
					resources = {
						order = 2,
						type = "group",
						inline = true,
						name = L["Resources"],
						args = {
							lua = {
								order = 0,
								type = "input",
								name = L["Programming in Lua"],
								desc = L["This is a good guide on how to get started with programming in Lua, while you do not need to read the entire thing it is a helpful for understanding the basics of Lua syntax and API's."],
								set = false,
								get = function() return "http://www.lua.org/pil/" end,
								width = "full",
							},
							wow = {
								order = 1,
								type = "input",
								name = L["WoW Programming"],
								desc = L["WoW Programming is a good resource for finding out what difference API's do and how to call them."],
								set = false,
								get = function() return "http://wowprogramming.com/docs" end,
								width = "full",
							},
						},
					},
				},
			},
		},
	}
	
	-- Load the initial tag list
	for tag in pairs(ShadowUF.Tags.defaultTags) do
		options.args.tags.args.general.args.list.args[tag] = tagTable
	end
	
	for tag, data in pairs(ShadowUF.db.profile.tags) do
		options.args.tags.args.general.args.list.args[tag] = tagTable
	end
end

---------------------
-- VISIBILITY OPTIONS
---------------------
local function loadVisibilityOptions()
	-- As zone units are only enabled in a certain zone... it's pointless to provide visibility options for them
	local unitBlacklist = {}
	for unit in pairs(ShadowUF.Units.zoneUnits) do unitBlacklist[unit] = true end
	for unit, parent in pairs(ShadowUF.Units.childUnits) do
		if( ShadowUF.Units.zoneUnits[parent] ) then
			unitBlacklist[unit] = true
		end
	end
		
	local globalVisibility = {}
	local function set(info, value)
		local key = info[#(info)]
		local unit = info[#(info) - 1]
		local area = info[#(info) - 2]
		
		if( key == "enabled" ) then
			key = ""
		end
		
		if( value == nil ) then
			value = false
		elseif( value == false ) then
			value = nil
		end
		
		for _, configUnit in pairs(ShadowUF.unitList) do
			if( ( configUnit == unit or unit == "global" ) and not unitBlacklist[configUnit] ) then
				ShadowUF.db.profile.visibility[area][configUnit .. key] = value
			end
		end
		
		-- Annoying yes, but only way that works
		ShadowUF.Units:CheckPlayerZone(true)
		
		if( unit == "global" ) then
			globalVisibility[area .. key] = value
		end
	end
	
	local function get(info)
		local key = info[#(info)]
		local unit = info[#(info) - 1]
		local area = info[#(info) - 2]

		if( key == "enabled" ) then
			key = ""
		end

		if( unit == "global" ) then
			if( globalVisibility[area .. key] == false ) then
				return nil
			elseif( globalVisibility[area .. key] == nil ) then
				return false
			end
			
			return globalVisibility[area .. key]
		elseif( ShadowUF.db.profile.visibility[area][unit .. key] == false ) then
			return nil
		elseif( ShadowUF.db.profile.visibility[area][unit .. key] == nil ) then
			return false
		end
			
		return ShadowUF.db.profile.visibility[area][unit .. key]
	end
	
	local function getHelp(info)
		local unit = info[#(info) - 1]
		local area  = info[#(info) - 2]
		local key = info[#(info)]
		if( key == "enabled" ) then
			key = ""
		end
		
		local current
		if( unit == "global" ) then
			current = globalVisibility[area .. key]
		else
			current = ShadowUF.db.profile.visibility[area][unit .. key]
		end
		
		if( current == false ) then
			return string.format(L["Disabled in %s"], AREA_NAMES[area])
		elseif( current == true ) then
			return string.format(L["Enabled in %s"], AREA_NAMES[area])
		end

		return L["Using unit settings"]
	end
	
	local areaTable = {
		type = "group",
		order = function(info) return info[#(info)] == "none" and 2 or 1 end,
		childGroups = "tree",
		name = function(info)
			return AREA_NAMES[info[#(info)]]
		end,
		get = get,
		set = set,
		args = {},
	}
	
	Config.visibilityTable = {
		type = "group",
		order = function(info) return info[#(info)] == "global" and 1 or (getUnitOrder(info) + 1) end,
		name = function(info) return info[#(info)] == "global" and L["Global"] or getName(info) end,
		args = {
			help = {
				order = 0,
				type = "group",
				name = L["Help"],
				inline = true,
				hidden = hideBasicOption,
				args = {
					help = {
						order = 0,
						type = "description",
						name = function(info)
							return string.format(L["Disabling a module on this page disables it while inside %s. Do not disable a module here if you do not want this to happen!."], string.lower(AREA_NAMES[info[2]]))
						end,
					},		
				}, 	
			},
			enabled = {
				order = 0.25,
				type = "toggle",
				name = function(info)
					local unit = info[#(info) - 1]
					if( unit == "global" ) then return "" end
					return string.format(L["%s frames"], L.units[unit])
				end,
				hidden = function(info) return info[#(info) - 1] == "global" end,
				desc = getHelp,
				tristate = true,
				width = "double",
			},
			sep = {
				order = 0.5,
				type = "description",
				name = "",
				width = "full",
				hidden = function(info) return info[#(info) - 1] == "global" end,
			},
		}
	}
	
	local moduleTable = {
		order = 1,
		type = "toggle",
		name = getName,
		desc = getHelp,
		tristate = true,
		hidden = function(info)
			if( info[#(info) - 1] == "global" ) then return false end
			return hideRestrictedOption(info)
		end,
		arg = 1,
	}
		
	for key, module in pairs(ShadowUF.modules) do
		if( module.moduleName ) then
			Config.visibilityTable.args[key] = moduleTable
		end
	end
	
	areaTable.args.global = Config.visibilityTable
	for _, unit in pairs(ShadowUF.unitList) do
		if( not unitBlacklist[unit] ) then
			areaTable.args[unit] = Config.visibilityTable
		end
	end
	
	options.args.visibility = {
		type = "group",
		childGroups = "tab",
		name = L["Zone configuration"],
		desc = getPageDescription,
		args = {
			start = {
				order = 0,
				type = "group",
				name = L["Help"],
				inline = true,
				hidden = hideBasicOption,
				args = {
					help = {
						order = 0,
						type = "description",
						name = L["Gold checkmark - Enabled in this zone / Grey checkmark - Disabled in this zone / No checkmark - Use the default unit settings"],
					},
				},
			},
			pvp = areaTable,
			arena = areaTable,
			party = areaTable,
			raid = areaTable,
		},
	}
end

local function loadOptions()
	options = {
		type = "group",
		name = "Shadowed UF",
		args = {}
	}

	loadGeneralOptions()
	loadUnitOptions()
	loadHideOptions()
	loadTagOptions()
	loadFilterOptions()
	loadVisibilityOptions()	
	
	-- Ordering
	options.args.general.order = 1
	options.args.enableUnits.order = 2
	options.args.units.order = 3
	options.args.filter.order = 4
	options.args.hideBlizzard.order = 5
	options.args.visibility.order = 6
	options.args.tags.order = 7
	
	-- So modules can access it easier/debug
	Config.options = options
	
	-- Options finished loading, fire callback for any non-default modules that want to be included
	ShadowUF:FireModuleEvent("OnConfigurationLoad")
end

function Config:Open()
	AceDialog = AceDialog or LibStub("AceConfigDialog-3.0")
	AceRegistry = AceRegistry or LibStub("AceConfigRegistry-3.0")
	
	if( not registered ) then
		loadOptions()
		
		LibStub("AceConfig-3.0"):RegisterOptionsTable("ShadowedUF", options)
		AceDialog:SetDefaultSize("ShadowedUF", 835, 525)
		registered = true
	end
	
	AceDialog:Open("ShadowedUF")
end