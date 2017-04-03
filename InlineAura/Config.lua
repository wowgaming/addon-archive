--[[
Copyright (C) 2009 Adirelle

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
--]]

-----------------------------------------------------------------------------
-- Configuration panel
-----------------------------------------------------------------------------
if not InlineAura then return end

local InlineAura = InlineAura
local L, new, del = InlineAura.L, InlineAura.new, InlineAura.del

-- This is used to prevent AceDB to load the default values for a spell
-- when it has been explictly removed by the user. I'd rather use "false",
-- but it seems AceDB has some issue with it.
local REMOVED = '**REMOVED**'

-- Units available to scan depending on aura type
local UNITS_TO_SCAN = {
	buff = {
		player = L['Player'],
		pet = L['Pet'],
		target = L['Friendly target'],
		focus = L['Friendly focus'],
	},
	debuff = {
		target = L['Hostile target'],
		focus = L['Hostile focus'],
	},
}

local SPELL_DEFAULTS = InlineAura.DEFAULT_OPTIONS.profile. spells

-----------------------------------------------------------------------------
-- Default option handler
-----------------------------------------------------------------------------

local handler = {}

function handler:Set(info, ...)
	if info.type == 'color' then
		local color = InlineAura.db.profile[info.arg]
		color[1], color[2], color[3], color[4] = ...
	else
		InlineAura.db.profile[info.arg] = ...
	end
	InlineAura:RequireUpdate(true)
end

function handler:Get(info)
	if info.type == 'color' then
		return unpack(InlineAura.db.profile[info.arg])
	else
		return InlineAura.db.profile[info.arg]
	end
end

local positions = {
	TOPLEFT = L['Top left'],
	TOP = L['Top'],
	TOPRIGHT = L['Top right'],
	LEFT = L['Left'],
	CENTER = L['Center'],
	RIGHT = L['Right'],
	BOTTOMLEFT = L['Bottom left'],
	BOTTOM = L['Bottom'],
	BOTTOMRIGHT = L['Bottom right'],
}
local tmp = {}
function handler:ListTextPositions(info, exclude)
	local exclude2 = InlineAura.bigCountdown or 'CENTER'
	wipe(tmp)
	for pos, label in pairs(positions) do
		if pos ~= exclude and pos ~= exclude2 then
			tmp[pos] = label
		end
	end
	return tmp
end

-----------------------------------------------------------------------------
-- Main options
-----------------------------------------------------------------------------

local options = {
	type = 'group',
	handler = handler,
	set = 'Set',
	get = 'Get',
	args = {
		onlyMyBuffs = {
			name = L['Only my buffs'],
			desc = L['Check to ignore buffs cast by other characters.'],
			type = 'toggle',
			arg = 'onlyMyBuffs',
			order = 10,
		},
		onlyMyDebuffs = {
			name = L['Only my debuffs'],
			desc = L['Check to ignore debuffs cast by other characters.'],
			type = 'toggle',
			arg = 'onlyMyDebuffs',
			order = 20,
		},
		hideCountdown = {
			name = L['No countdown'],
			desc = L['Check to hide the aura countdown.'],
			type = 'toggle',
			arg = 'hideCountdown',
			order = 30,
		},
		hideStack = {
			name = L['No application count'],
			desc = L['Check to hide the aura application count (charges or stacks).'],
			type = 'toggle',
			arg = 'hideStack',
			order = 40,
		},
		preciseCountdown = {
			name = L['Precise countdown'],
			desc = L['Check to have a more accurate countdown display instead of default Blizzard rounding.'],
			type = 'toggle',
			arg = 'preciseCountdown',
			disabled = function(info) return InlineAura.db.profile.hideCountdown end,
			order = 45,
		},
		decimalCountdownThreshold = {
			name = L['Decimal countdown threshold'],
			desc = L['Select the remaining time threshold under which tenths of second are displayed.'],
			type = 'range',
			min = 1,
			max = 10,
			step = 0.5,			
			arg = 'decimalCountdownThreshold',
			disabled = function(info) return InlineAura.db.profile.hideCountdown or not InlineAura.db.profile.preciseCountdown end,
			order = 46,
		},
		colors = {
			name = L['Border highlight colors'],
			desc = L['Select the colors used to highlight the action button. There are selected based on aura type and caster.'],
			type = 'group',
			inline = true,
			order = 50,
			args = {
				buffMine = {
					name = L['My buffs'],
					desc = L['Select the color to use for the buffs you cast.'],
					type = 'color',
					arg = 'colorBuffMine',
					order = 10,
				},
				buffOthers = {
					name = L["Others' buffs"],
					desc = L['Select the color to use for the buffs cast by other characters.'],
					type = 'color',
					arg = 'colorBuffOthers',
					order = 20,
				},
				debuffMine = {
					name = L["My debuffs"],
					desc = L['Select the color to use for the debuffs you cast.'],
					type = 'color',
					arg = 'colorDebuffMine',
					order = 30,
				},
				debuffOthers = {
					name = L["Others' debuffs"],
					desc = L['Select the color to use for the debuffs cast by other characters.'],
					type = 'color',
					arg = 'colorDebuffOthers',
					order = 40,
				},
				alternate = {
					name = L['Alternate color'],
					desc = L['Select the color to use for alternate highlights, typically talent procs.'],
					type = 'color',
					arg = 'colorAlternate',
					hasAlpha = true,
					order = 50,
				},
			},
		},
		text = {
			name = L['Text appearance'],
			type = 'group',
			inline = true,
			order = 60,
			args = {
				smallCountdownExplanation = {
					name = L['Either OmniCC or CooldownCount is loaded so aura countdowns are displayed using small font at the bottom of action buttons.'],
					type = 'description',
					hidden = function() return InlineAura.bigCountdown end,
					order = 5,
				},
				fontName = {
					name = L['Font name'],
					desc = L['Select the font to be used to display both countdown and application count.'],
					type = 'select',
					dialogControl = 'LSM30_Font',
					values = AceGUIWidgetLSMlists.font,
					arg = 'fontName',
					order = 10,
				},
				smallFontSize = {
					name = L['Size of small text'],
					desc = L['The small font is used to display application count (and countdown when cooldown addons are loaded).'],
					type = 'range',
					min = 5,
					max = 30,
					step = 1,
					arg = 'smallFontSize',
					order = 20,
				},
				largeFontSize = {
					name = L['Size of large text'],
					desc = L['The large font is used to display countdowns.'],
					type = 'range',
					min = 5,
					max = 30,
					step = 1,
					arg = 'largeFontSize',
					disabled = function() return not InlineAura.bigCountdown end,
					order = 30,
				},
				colorCountdown = {
					name = L['Countdown text color'],
					type = 'color',
					arg = 'colorCountdown',
					hasAlpha = true,
					order = 40,
					disabled = function() return InlineAura.db.profile.hideCountdown end,
				},
				colorStack = {
					name = L['Application text color'],
					type = 'color',
					arg = 'colorStack',
					hasAlpha = true,
					order = 50,
				},
			},
		},
		layout = {
			name = L['Text Position'],
			type = 'group',
			inline = true,
			order = 70,
			args = {
				_desc = {
					type = 'description',
					name = L['Select where to display countdown and application count in the button. When only one value is displayed, the "single value position" is used instead of the regular one.'],
					order = 10,
				},
				twoTextFirst = {
					name = L['Countdown position'],
					desc = L['Select where to place the countdown text when both values are shown.'],
					type = 'select', 
					arg = 'twoTextFirstPosition',
					values = function(info) return info.handler:ListTextPositions(info, InlineAura.db.profile.twoTextSecondPosition) end,
					disabled = function(info) return InlineAura.db.profile.hideCountdown or InlineAura.db.profile.hideStack end,
					order = 20,
				},
				twoTextSecond = {
					name = L['Application count position'],
					desc = L['Select where to place the application count text when both values are shown.'],
					type = 'select', 
					arg = 'twoTextSecondPosition',
					values = function(info) return info.handler:ListTextPositions(info, InlineAura.db.profile.twoTextFirstPosition) end,
					disabled = function(info) return InlineAura.db.profile.hideCountdown or InlineAura.db.profile.hideStack end,
					order = 30,
				},
				oneText = {
					name = L['Single value position'],
					desc = L['Select where to place a single value.'],
					type = 'select', 
					arg = 'singleTextPosition',
					values = "ListTextPositions",
					disabled = function(info) return InlineAura.db.profile.hideCountdown and InlineAura.db.profile.hideStack end,
					order = 40,
				},
			},
		},
	},
}

-----------------------------------------------------------------------------
-- Spell specific options
-----------------------------------------------------------------------------

local ValidateName

---- Main panel options

local spellPanelHandler = {}
local spellSpecificHandler = {}

local spellToAdd

local spellOptions = {
	name = L['Spell specific settings'],
	type = 'group',
	handler = spellPanelHandler,
	args = {
		addInput = {
			name = L['New spell name'],
			desc = L['Enter the name of the spell for which you want to add specific settings. Non-existent spell or item names are rejected.'],
			type = 'input',
			get = function(info) return spellToAdd end,
			set = function(info, value) spellToAdd = ValidateName(value) end,
			validate = function(info, value)			
				return ValidateName(value) and true or L["Unknown spell: %s"]:format(tostring(value))
			end,
			order = 10,
		},
		addButton = {
			name = L['Add spell'],
			desc = L['Click to create specific settings for the spell.'],
			type = 'execute',
			order = 20,
			func = function(info)
				if spellPanelHandler:IsDefined(spellToAdd) then
					spellSpecificHandler:SelectSpell(spellToAdd)
				else
					info.handler:AddSpell(spellToAdd)
				end
				spellToAdd = nil
			end,
		},
		editList = {
			name = L['Spell to edit'],
			desc = L['Select the spell to edit or to remove its specific settings. Spells with specific defaults are written in |cff77ffffcyan|r. Removed spells with specific defaults are written in |cff777777gray|r.'],
			type = 'select',
			get = function(info) return spellSpecificHandler:GetSelectedSpell() end,
			set = function(info, value) spellSpecificHandler:SelectSpell(value) end,
			disabled = 'HasNoSpell',
			values = 'GetSpellList',
			order = 30,
		},
		removeButton = {
			name = L['Remove spell'],
			desc = L['Remove spell specific settings.'],
			type = 'execute',
			func = function(info)
				info.handler:RemoveSpell(spellSpecificHandler:GetSelectedSpell())
			end,
			disabled = function() 
				return not spellPanelHandler:IsDefined(spellSpecificHandler:GetSelectedSpell())
			end,
			confirm = true,
			confirmText = L['Do you really want to remove these aura specific settings ?'],
			order = 40,
		},
		restoreDefaults = {
			name = function()
				return spellPanelHandler:HasDefault(spellSpecificHandler:GetSelectedSpell()) and L['Restore defaults'] or L['Reset settings']
			end,
			desc = function()
				return spellPanelHandler:HasDefault(spellSpecificHandler:GetSelectedSpell()) and L['Restore default settings of the selected spell.'] or L['Reset settings to global defaults.']
			end,
			type = 'execute',
			func = function(info)
				spellPanelHandler:RestoreDefaults(spellSpecificHandler:GetSelectedSpell())
			end,
			order = 45,
		},		
		settings = {
			name = function(info) return spellSpecificHandler:GetSelectedSpellName() end,
			type = 'group',
			hidden = 'IsNoSpellSelected',
			handler = spellSpecificHandler,
			get = 'Get',
			set = 'Set',
			inline = true,
			order = 50,
			args = {
				disable = {
					name = L['Disable'],
					desc = L['Check to totally disable this spell. No border highlight nor text is displayed for disabled spells.'],
					type = 'toggle',
					arg = 'disabled',
					order = 10,
				},
				auraType = {
					name = L['Aura type'],
					desc = L['Select the aura type of this spell. This helps to look up the aura.'],
					type = 'select',
					arg = 'auraType',
					disabled = 'IsSpellDisabled',
					values = {
						buff = L['Buff'],
						debuff = L['Debuff'],
					},
					order = 20,
				},
				unitsToScan = {
					name = L['Units to scan'],
					desc = L['Check which units you want to be scanned for the aura. Auras of the first existing unit are shown, using this order: focus, target, pet and then player.'],
					type = 'multiselect',
					arg = 'unitsToScan',
					disabled = 'IsSpellDisabled',
					values = 'GetUnitList',
					order = 25,
				},
				onlyMine = {
					name = L['Only show mine'],
					desc = L['Check to only show aura you applied. Uncheck to always show aura, even when applied by others. Leave grayed to use default settings.'],
					type = 'toggle',
					arg = 'onlyMine',
					tristate = true,
					disabled = 'IsSpellDisabled',
					order = 30,
				},
				hideCountdown = {
					name = L['No countdown'],
					desc = L['Check to hide the aura duration countdown.'],
					type = 'toggle',
					arg = 'hideCountdown',
					tristate = true,
					disabled = 'IsSpellDisabled',
					order = 35,
				},
				hideStack = {
					name = L['No application count'],
					desc = L['Check to hide the aura application count (charges or stacks).'],
					type = 'toggle',
					arg = 'hideStack',
					tristate = true,
					disabled = 'IsSpellDisabled',
					order = 40,
				},
				alternateColor = {
					name = L['Use alternate color'],
					desc = L['Check to use the alternate color. This is typically used to display talent proc.'],
					type = 'toggle',
					arg = 'alternateColor',
					disabled = 'IsSpellDisabled',
					order = 50,
				},
				aliases = {
					name = L['Auras to look up'],
					desc = L['Enter additional aura names to check. This allows to check for alternative or equivalent auras. Some spells also apply auras that do not have the same name as the spell.'],
					usage = L['Enter one aura name per line. They are spell-checked ; errors will prevents you to validate.'],
					type = 'input',
					arg = 'aliases',
					disabled = 'IsSpellDisabled',
					multiline = true,
					get = 'GetAliases',
					set = 'SetAliases',
					validate = 'ValidateAliases',
					order = 60,
				},
			},
		},
	},
}

do
	local spellList = {}
	function spellPanelHandler:GetSpellList()
		wipe(spellList)
		for name, data in pairs(InlineAura.db.profile.spells) do
			if type(data) == 'table' then
				if self:HasDefault(name) then
					spellList[name] = '|cff77ffff'..name..'|r';
				else
					spellList[name] = name
				end
			elseif data == REMOVED then
				spellList[name] = '|cff777777'..name..'|r';
			end
		end
		return spellList
	end
end

function spellPanelHandler:HasNoSpell()
	return not next(self:GetSpellList())
end

function spellPanelHandler:IsDefined(name)
	return name and type(rawget(InlineAura.db.profile.spells, name)) == "table"
end

function spellPanelHandler:HasDefault(name)
	return name and SPELL_DEFAULTS[name]
end

local function copyDefaults(dst, src, enforceTables)
	for k,v in pairs(src) do
		if type(v) == "table" then
			local dv = dst[k]
			if dv == nil or (type(dv) ~= "table" and enforceTables) then
				dv = {}
				dst[k] = dv
			end
			if type(dv) == 'table' then
				copyDefaults(dv, v, enforceTables)
			end
		else
			dst[k] = v
		end
	end
end

local function createSpellwithDefaults(name)
	local spell = {}
	copyDefaults(spell, SPELL_DEFAULTS['**'], true)
	if SPELL_DEFAULTS[name] then
		copyDefaults(spell, SPELL_DEFAULTS[name], false)
	end
	InlineAura.db.profile.spells[name] = spell
end

function spellPanelHandler:AddSpell(name)
	createSpellwithDefaults(name)
	spellSpecificHandler:SelectSpell(name)
	InlineAura:RequireUpdate(true)
end

function spellPanelHandler:RemoveSpell(name)
	if SPELL_DEFAULTS[name] then
		InlineAura.db.profile.spells[name] = REMOVED
	else
		InlineAura.db.profile.spells[name] = nil
	end
	InlineAura:RequireUpdate(true)
	spellSpecificHandler:ListUpdated()
end

function spellPanelHandler:RestoreDefaults(name)
	createSpellwithDefaults(name)
	InlineAura:RequireUpdate(true)
	spellSpecificHandler:ListUpdated()
end

---- Specific aura options

function spellSpecificHandler:ListUpdated()
	if self.name and type(rawget(InlineAura.db.profile.spells, self.name)) == 'table' then
		return self:SelectSpell(self.name)
	end
	for name, data in pairs(InlineAura.db.profile.spells) do
		if type(data) == 'table' then
			return self:SelectSpell(name)
		end
	end
	self:SelectSpell(nil)
end

function spellSpecificHandler:GetSelectedSpell()
	return self.name
end

function spellSpecificHandler:GetSelectedSpellName()
	return self.name or "???"
end

function spellSpecificHandler:SelectSpell(name)
	local db = name and rawget(InlineAura.db.profile.spells, name)
	if type(db) == 'table' then
		self.name, self.db = name, db
	elseif db == REMOVED then
		self.name, self.db = name, nil
	else
		self.name, self.db = nil, nil
	end
end

function spellSpecificHandler:IsNoSpellSelected()
	return not self.db
end

function spellSpecificHandler:IsSpellDisabled()
	return not self.db or self.db.disabled
end

function spellSpecificHandler:Set(info, ...)
	if info.type == 'color' then
		local color = self.db[info.arg]
		color[1], color[2], color[3], color[4] = ...
	elseif info.type == 'multiselect' then
		local key, value = ...
		value = value and true or false
		if type(self.db[info.arg]) ~= 'table' then
			self.db[info.arg] = { key = value }
		else
			self.db[info.arg][key] = value
		end
	else
		self.db[info.arg] = ...
	end
	InlineAura:RequireUpdate(true)
end

function spellSpecificHandler:Get(info, key)
	if info.type == 'color' then
		return unpack(self.db[info.arg])
	elseif info.type == 'multiselect' then
		return type(self.db[info.arg]) == "table" and self.db[info.arg][key]
	else
		return self.db[info.arg]
	end
end

function spellSpecificHandler:GetAliases(info)
	local aliases = self.db.aliases
	return type(aliases) == 'table' and table.concat(aliases, "\n") or nil
end

function spellSpecificHandler:SetAliases(info, value)
	local aliases = self.db.aliases
	if aliases then
		wipe(aliases)
	else
		aliases = new()
	end
	for name in tostring(value):gmatch("[^\n]+") do
		name = name:trim()
		if name ~= "" then
			table.insert(aliases, ValidateName(name))
		end
	end
	if #aliases > 0 then
		self.db.aliases = aliases
	else
		del(aliases)
		self.db.aliases = nil
	end
	InlineAura:RequireUpdate(true)
end

function spellSpecificHandler:ValidateAliases(info, value)
	for name in tostring(value):gmatch("[^\n]+") do
		name = name:trim()
		if name ~= "" and not ValidateName(name) then
			return L["Unknown spell: %s"]:format(name)
		end
	end
	return true
end

function spellSpecificHandler:GetUnitList(info)
	return UNITS_TO_SCAN[self.db.auraType or 'debuff']
end

-----------------------------------------------------------------------------
-- Spell name validation
-----------------------------------------------------------------------------

do
	local GetSpellInfo, GetItemInfo = GetSpellInfo, GetItemInfo
	local validNames = setmetatable({}, {
		__mode = 'kv',
		__index = function(self, key)
			local rawId = tonumber(string.match(tostring(key), '^#(%d+)$'))
			local result = false
			if rawId then
				if GetSpellInfo(rawId) then
					result = '#'..rawId
				end
			else
				result = GetSpellInfo(key) or GetItemInfo(key)
				if not result then
					local id = rawget(self, '__id') or 0
					while id < 70000 do -- Arbitrary high spell id
						local name = GetSpellInfo(id)
						id = id + 1
						if name then
							if name:lower() == key:lower() then
								result = name
								break
							else
								self[name] = name
							end
						end
					end
					self.__id = id
				end
			end
			self[key] = result
			return result
		end
	})

	function ValidateName(name)
		return type(name) == "string" and validNames[name]
	end
end

-----------------------------------------------------------------------------
-- Setup
-----------------------------------------------------------------------------

local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

-- Register main options
AceConfig:RegisterOptionsTable('InlineAura-main', options)

-- Register spell specific options
AceConfig:RegisterOptionsTable('InlineAura-spells', spellOptions)

-- Register profile options
local dbOptions = LibStub('AceDBOptions-3.0'):GetOptionsTable(InlineAura.db)
LibStub('LibDualSpec-1.0'):EnhanceOptions(dbOptions, InlineAura.db)
AceConfig:RegisterOptionsTable('InlineAura-profiles', dbOptions)

-- Create Blizzard AddOn option frames
local mainTitle = L['Inline Aura']
local mainPanel = AceConfigDialog:AddToBlizOptions('InlineAura-main', mainTitle)
AceConfigDialog:AddToBlizOptions('InlineAura-spells', L['Spell specific settings'], mainTitle)
AceConfigDialog:AddToBlizOptions('InlineAura-profiles', L['Profiles'], mainTitle)

-- Update selected spell on database change
InlineAura.db.RegisterCallback(spellSpecificHandler, 'OnProfileChanged', 'ListUpdated')
InlineAura.db.RegisterCallback(spellSpecificHandler, 'OnProfileCopied', 'ListUpdated')
InlineAura.db.RegisterCallback(spellSpecificHandler, 'OnProfileReset', 'ListUpdated')
spellSpecificHandler:ListUpdated()


