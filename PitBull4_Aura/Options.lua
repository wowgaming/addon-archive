-- Options.lua : Options config

if select(6, GetAddOnInfo("PitBull4_" .. (debugstack():match("[o%.][d%.][u%.]les\\(.-)\\") or ""))) ~= "MISSING" then return end

local _G = getfenv(0)
local PitBull4 = _G.PitBull4
local PitBull4_Aura= PitBull4:GetModule("Aura")
local L = PitBull4.L
local can_dispel = PitBull4_Aura.can_dispel
local friend_buffs = PitBull4_Aura.friend_buffs
local friend_debuffs = PitBull4_Aura.friend_debuffs
local self_buffs = PitBull4_Aura.self_buffs
local self_debuffs = PitBull4_Aura.self_debuffs
local pet_buffs = PitBull4_Aura.pet_buffs
local enemy_debuffs = PitBull4_Aura.enemy_debuffs
local extra_buffs = PitBull4_Aura.extra_buffs

local color_defaults = {
	caster = {
		my = {0, 1, 0, 1},
		other = {1, 0, 0, 1},
	},
	type = {
		Poison = {0, 1, 0, 1},
		Magic = {0, 0, 1, 1},
		Disease = {.55, .15, 0, 1},
		Curse = {5, 0, 5, 1},
		Enrage = {1, .55, 0, 1},
		["nil"] = {1, 0, 0, 1},
	},
}

PitBull4_Aura:SetDefaults({
	-- Layout defaults
	enabled_buffs = true,
	enabled_debuffs = true,
	enabled_weapons = true,
	buff_size = 16,
	debuff_size = 16,
	--  TODO: max_buffs and max_debuffs are set low
	--  by default since this is for all frames
	--  until we have pre-defined layouts for frames.
	max_buffs = 6,
	max_debuffs = 6,
	zoom_aura = false,
	click_through = false,
	cooldown = {
		my_buffs = true,
		my_debuffs = true,
		other_buffs = true,
		other_debuffs = true,
		weapon_buffs = true,
	},
	cooldown_text = {
		my_buffs = false,
		my_debuffs = false,
		other_buffs = false,
		other_debuffs = false,
		weapon_buffs = false,
	},
	borders = {
		my_buffs = {
			friend = {
				enabled = true,
				color_type = 'caster',
			},
			enemy = {
				enabled = true,
				color_type = 'type',
			},
		},
		my_debuffs = {
			friend = {
				enabled = true,
				color_type = 'type',
			},
			enemy = {
				enabled = true,
				color_type = 'caster',
			},
		},
		other_buffs = {
			friend = {
				enabled = true,
				color_type = 'caster',
			},
			enemy = {
				enabled = true,
				color_type = 'type',
			},
		},
		other_debuffs = {
			friend = {
				enabled = true,
				color_type = 'type',
			},
			enemy = {
				enabled = true,
				color_type = 'caster',
			},
		},
		weapon_buffs = {
			enabled = true,
			color_type = 'weapon',
		},
	},
	highlight = true,
	highlight_filters = {
		'!H','!I','!J'
	},
	highlight_filters_color_by_type = {
		true, false, false
	},
	highlight_filters_custom_color = {
		{ 1, 1, 1, 1},
		{ 1, 0, 0, 1},
		{ 1, 0, 0, 1},
	},
	highlight_style = "border",
	layout = {
		buff = {
			size = 16,
			my_size = 16,
			size_to_fit = true,
			anchor = "BOTTOMLEFT",
			side = "BOTTOM",
			offset_x = 0,
			offset_y = 0,
			width_type = "percent",
			width = 100,
			width_percent = 0.50,
			growth = "right_down",
			sort = true,
			reverse = false,
			row_spacing = 0,
			col_spacing = 0,
			new_row_size = false,
			filter = "",
			frame_level = 2,
		},
		debuff = {
			size = 16,
			my_size = 16,
			size_to_fit = true,
			anchor = "BOTTOMRIGHT",
			side = "BOTTOM",
			offset_x = 0,
			offset_y = 0,
			width_type = "percent",
			width = 100,
			width_percent = 0.50,
			growth = "left_down",
			sort = true,
			reverse = false,
			col_spacing = 0,
			row_spacing = 0,
			new_row_size = false,
			filter = "",
			frame_level = 2,
		},
	},
	texts = {
		my_buffs = {
			count = {
				font = nil,
				size = 0.8,
				color = { 1, 1, 1, 1 },
				anchor = "BOTTOMRIGHT",
				offset_x = 0,
				offset_y = 0,
			},
			cooldown_text = {
				font = nil,
				size = 0.8,
				color = { 1, 1, 1, 1 },
				anchor = "TOP",
				offset_x = 0,
				offset_y = 0,
			}
		},
		my_debuffs = {
			count = {
				font = nil,
				size = 0.8,
				color = { 1, 1, 1, 1 },
				anchor = "BOTTOMRIGHT",
				offset_x = 0,
				offset_y = 0,
			},
			cooldown_text = {
				font = nil,
				size = 0.8,
				color = { 1, 1, 1, 1 },
				color_by_time = false,
				anchor = "TOP",
				offset_x = 0,
				offset_y = 0,
			}
		},
		other_buffs = {
			count = {
				font = nil,
				size = 0.8,
				color = { 1, 1, 1, 1 },
				anchor = "BOTTOMRIGHT",
				offset_x = 0,
				offset_y = 0,
			},
			cooldown_text = {
				font = nil,
				size = 0.8,
				color = { 1, 1, 1, 1 },
				color_by_time = false,
				anchor = "TOP",
				offset_x = 0,
				offset_y = 0,
			}
		},
		other_debuffs = {
			count = {
				font = nil,
				size = 0.8,
				color = { 1, 1, 1, 1 },
				anchor = "BOTTOMRIGHT",
				offset_x = 0,
				offset_y = 0,
			},
			cooldown_text = {
				font = nil,
				size = 0.8,
				color = { 1, 1, 1, 1 },
				color_by_time = false,
				anchor = "TOP",
				offset_x = 0,
				offset_y = 0,
			}
		},
		weapon_buffs = {
			count = {
				font = nil,
				size = 0.8,
				color = { 1, 1, 1, 1 },
				anchor = "BOTTOMRIGHT",
				offset_x = 0,
				offset_y = 0,
			},
			cooldown_text = {
				font = nil,
				size = 0.8,
				color = { 1, 1, 1, 1 },
				color_by_time = false,
				anchor = "TOP",
				offset_x = 0,
				offset_y = 0,
			}
		},
	},
},
{
	-- Global defaults
	colors = color_defaults,
	guess_weapon_enchant_icon = true,
	filters = {
		-- default filters are indexed by two character codes.
		-- The first character follows the following format:
		-- ! Master Filters
		-- # Intermediate Filters
		-- % Race map filters
		-- & Class map filters
		-- + DeathKnight
		-- , Druid
		-- - Hunter
		-- . Mage
		-- / Paladin
		-- 0 Priest
		-- 1 Rogue
		-- 2 Shaman
		-- 3 Warlock
		-- 4 Warrior
		-- 5 Human
		-- 6 Dwarf
		-- 7 Night Elf
		-- 8 Gnome
		-- 9 Draenei
		-- : Orc
		-- ; Undead
		-- < Taruen
		-- = Troll
		-- > Blood Elf
		-- @ Simple filters
		--
		-- The 2nd character places it within the proper order
		-- under those major categories.  That said the follow
		-- are generally true
		-- 0 self buffs
		-- 1 pet buffs
		-- 2 friend buffs
		-- 3 can dispel
		-- 4 self buffs
		-- 5 friend debuffs
		-- 6 enemy debuffs
		--
		-- This is necessary to get the sort order proper for the
		-- drop down boxes while using a value that is not localized
		['@I'] = {
			display_name = L['True'],
			filter_type = 'True',
			disabled = true,
			built_in = true,
		},
		['@J'] = {
			display_name = L['False'],
			filter_type = 'False',
			disabled = true,
			built_in = true,
		},
		['@A'] = {
			display_name = L['Buff'],
			filter_type = 'Buff',
			buff = true,
			disabled = true,
			built_in = true,
		},
		['@B'] = {
			display_name = L['Debuff'],
			filter_type = 'Buff',
			buff = false,
			disabled = true,
			built_in = true,
		},
		['@C'] = {
			display_name = L['Weapon enchant'],
			filter_type = 'Weapon Enchant',
			weapon = true,
			disabled = true,
			built_in = true,
		},
		['@D'] = {
			display_name = L['Friend'],
			filter_type = 'Unit',
			unit_operator = 'friend',
			disabled = true,
			built_in = true,
		},
		['@E'] = {
			display_name = L['Enemy'],
			filter_type = 'Unit',
			unit_operator = 'enemy',
			disabled = true,
			built_in = true,
		},
		['@F'] = {
			display_name = L['Pet'],
			filter_type = 'Unit',
			unit_operator = '==',
			unit = 'pet',
			disabled = true,
			built_in = true,
		},
		['@G'] = {
			display_name = L['Player'],
			filter_type = 'Unit',
			unit_operator = '==',
			unit = 'player',
			disabled = true,
			built_in = true,
		},
		['@H'] = {
			display_name = L['Mine'],
			filter_type = 'Mine',
			mine = true,
			disabled = true,
			built_in = true,
		},
		['@K'] = {
			display_name = L['Dispellable'],
			filter_type = 'Aura Type',
			whitelist = true,
			aura_type_list = {
				Curse = true,
				Poison = true,
				Magic = true,
				Enrage = true,
				Disease = true,
			},
			built_in = true,
		},
		['@L'] = {
			display_name = L['Cast by my vehicle'],
			filter_type = 'Caster',
			unit_operator = '==',
			unit = 'vehicle',
			disabled = true,
			built_in = true,
		},
		[',3'] = {
			display_name = L['Druid can dispel'],
			filter_type = 'Aura Type',
			whitelist = true,
			aura_type_list = can_dispel['DRUID'],
			built_in = true,
		},
		['-3'] = {
			display_name = L['Hunter can dispel'],
			filter_type = 'Aura Type',
			whitelist = true,
			aura_type_list = can_dispel['HUNTER'],
			built_in = true,
		},
		['.3'] = {
			display_name = L['Mage can dispel'],
			filter_type = 'Aura Type',
			whitelist = true,
			aura_type_list = can_dispel['MAGE'],
			built_in = true,
		},
		['/3'] = {
			display_name = L['Paladin can dispel'],
			filter_type = 'Aura Type',
			whitelist = true,
			aura_type_list = can_dispel['PALADIN'],
			built_in = true,
		},
		['03'] = {
			display_name = L['Priest can dispel'],
			filter_type = 'Aura Type',
			whitelist = true,
			aura_type_list = can_dispel['PRIEST'],
			built_in = true,
		},
		['13'] = {
			display_name = L['Rogue can dispel'],
			filter_type = 'Aura Type',
			whitelist = true,
			aura_type_list = can_dispel['ROGUE'],
			built_in = true,
		},
		['23'] = {
			display_name = L['Shaman can dispel'],
			filter_type = 'Aura Type',
			whitelist = true,
			aura_type_list = can_dispel['SHAMAN'],
			built_in = true,
		},
		['33'] = {
			display_name = L['Warlock can dispel'],
			filter_type = 'Aura Type',
			whitelist = true,
			aura_type_list = can_dispel['WARLOCK'],
			built_in = true,
		},
		['43'] = {
			display_name = L['Warrior can dispel'],
			filter_type = 'Aura Type',
			whitelist = true,
			aura_type_list = can_dispel['WARRIOR'],
			built_in = true,
		},
		['+0'] = {
			display_name = L['Death Knight self buffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = self_buffs.DEATHKNIGHT,
			built_in = true,
		},
		[',0'] = {
			display_name = L['Druid self buffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = self_buffs.DRUID,
			built_in = true,
		},
		['-0'] = {
			display_name = L['Hunter self buffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = self_buffs.HUNTER,
			built_in = true,
		},
		['.0'] = {
			display_name = L['Mage self buffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = self_buffs.MAGE,
			built_in = true,
		},
		['/0'] = {
			display_name = L['Paladin self buffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = self_buffs.PALADIN,
			built_in = true,
		},
		['00'] = {
			display_name = L['Priest self buffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = self_buffs.PRIEST,
			built_in = true,
		},
		['10'] = {
			display_name = L['Rogue self buffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = self_buffs.ROGUE,
			built_in = true,
		},
		['20'] = {
			display_name = L['Shaman self buffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = self_buffs.SHAMAN,
			built_in = true,
		},
		['30'] = {
			display_name = L['Warlock self buffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = self_buffs.WARLOCK,
			built_in = true,
		},
		['40'] = {
			display_name = L['Warrior self buffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = self_buffs.WARRIOR,
			built_in = true,
		},
		['+1'] = {
			display_name = L['Death Knight pet buffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = pet_buffs.DEATHKNIGHT,
			built_in = true,
		},
		['-1'] = {
			display_name = L['Hunter pet buffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = pet_buffs.HUNTER,
			built_in = true,
		},
		['31'] = {
			display_name = L['Warlock pet buffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = pet_buffs.WARLOCK,
			built_in = true,
		},
		['+2'] = {
			display_name = L['Death Knight friend buffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = friend_buffs.DEATHKNIGHT,
			built_in = true,
		},
		[',2'] = {
			display_name = L['Druid friend buffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = friend_buffs.DRUID,
			built_in = true,
		},
		['-2'] = {
			display_name = L['Hunter friend buffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = friend_buffs.HUNTER,
			built_in = true,
		},
		['.2'] = {
			display_name = L['Mage friend buffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = friend_buffs.MAGE,
			built_in = true,
		},
		['/2'] = {
			display_name = L['Paladin friend buffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = friend_buffs.PALADIN,
			built_in = true,
		},
		['02'] = {
			display_name = L['Priest friend buffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = friend_buffs.PRIEST,
			built_in = true,
		},
		['12'] = {
			display_name = L['Rogue friend buffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = friend_buffs.ROGUE,
			built_in = true,
		},
		['22'] = {
			display_name = L['Shaman friend buffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = friend_buffs.SHAMAN,
			built_in = true,
		},
		['32'] = {
			display_name = L['Warlock friend buffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = friend_buffs.WARLOCK,
			built_in = true,
		},
		['42'] = {
			display_name = L['Warrior friend buffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = friend_buffs.WARRIOR,
			built_in = true,
		},
		['+6'] = {
			display_name = L['Death Knight enemy debuffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = enemy_debuffs.DEATHKNIGHT,
			built_in = true,
		},
		[',6'] = {
			display_name = L['Druid enemy debuffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = enemy_debuffs.DRUID,
			built_in = true,
		},
		['-6'] = {
			display_name = L['Hunter enemy debuffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = enemy_debuffs.HUNTER,
			built_in = true,
		},
		['.6'] = {
			display_name = L['Mage enemey debuffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = enemy_debuffs.MAGE,
			built_in = true,
		},
		['/6'] = {
			display_name = L['Paladin enemy debuffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = enemy_debuffs.PALADIN,
			built_in = true,
		},
		['06'] = {
			display_name = L['Priest enemy debuffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = enemy_debuffs.PRIEST,
			built_in = true,
		},
		['16'] = {
			display_name = L['Rogue enemy debuffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = enemy_debuffs.ROGUE,
			built_in = true,
		},
		['26'] = {
			display_name = L['Shaman enemy debuffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = enemy_debuffs.SHAMAN,
			built_in = true,
		},
		['36'] = {
			display_name = L['Warlock enemy debuffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = enemy_debuffs.WARLOCK,
			built_in = true,
		},
		['46'] = {
			display_name = L['Warrior enemy debuffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = enemy_debuffs.WARRIOR,
			built_in = true,
		},
		['/5'] = {
			display_name = L['Paladin friend debuffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = friend_debuffs.PALADIN,
			built_in = true,
		},
		['05'] = {
			display_name = L['Priest friend debuffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = friend_debuffs.PRIEST,
			built_in = true,
		},
		['25'] = {
			display_name = L['Shaman friend debuffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = friend_debuffs.SHAMAN,
			built_in = true,
		},
		['60'] = {
			display_name = L['Dwarf self buffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = self_buffs.Dwarf,
			built_in = true,
		},
		['70'] = {
			display_name = L['Night Elf self buffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = self_buffs.NightElf,
			built_in = true,
		},
		[':0'] = {
			display_name = L['Orc self buffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = self_buffs.Orc,
			built_in = true,
		},
		[';0'] = {
			display_name = L['Undead self buffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = self_buffs.Scourge,
			built_in = true,
		},
		['=0'] = {
			display_name = L['Troll self buffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = self_buffs.Troll,
			built_in = true,
		},
		['>0'] = {
			display_name = L['Blood Elf self buffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = self_buffs.BloodElf,
			built_in = true,
		},
		['52'] = {
			display_name = L['Human friend buffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = friend_buffs.Human,
			built_in = true,
		},
		['62'] = {
			display_name = L['Dwarf friend buffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = friend_buffs.Dwarf,
			built_in = true,
		},
		['72'] = {
			display_name = L['Night Elf friend buffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = friend_buffs.NightElf,
			built_in = true,
		},
		['82'] = {
			display_name = L['Gnome friend buffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = friend_buffs.Gnome,
			built_in = true,
		},
		['92'] = {
			display_name = L['Draenei friend buffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = friend_buffs.Draenei,
			built_in = true,
		},
		[':2'] = {
			display_name = L['Orc friend buffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = friend_buffs.Orc,
			built_in = true,
		},
		[';2'] = {
			display_name = L['Undead friend buffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = friend_buffs.Scourge,
			built_in = true,
		},
		['<2'] = {
			display_name = L['Tauren friend buffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = friend_buffs.Tauren,
			built_in = true,
		},
		['=2'] = {
			display_name = L['Troll friend buffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = friend_buffs.Troll,
			built_in = true,
		},
		['>2'] = {
			display_name = L['Blood Elf friend buffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = friend_buffs.BloodElf,
			built_in = true,
		},
		['<6'] = {
			display_name = L['Taruen enemy debuffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = enemy_debuffs.Tauren,
			built_in = true,
		},
		['>6'] = {
			display_name = L['Blood Elf enemy debuffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = enemy_debuffs.BloodElf,
			built_in = true,
		},
		[':4'] = {
			display_name = L['Orc self debuffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = self_debuffs.Orc,
			built_in = true,
		},
		['.4'] = {
			display_name = L['Mage self debuffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = self_debuffs.MAGE,
			built_in = true,
		},
		['04'] = {
			display_name = L['Priest self debuffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = self_debuffs.PRIEST,
			built_in = true,
		},
		['44'] = {
			display_name = L['Warrior self debuffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = self_debuffs.WARRIOR,
			built_in = true,
		},
		['&D'] = {
			display_name = L['My class can dispel'],
			filter_type = 'Map',
			map_type = 'class',
			map = {
				['DEATHKNIGHT'] = '@J',
				['DRUID'] = ',3',
				['HUNTER'] = '-3',
				['MAGE'] = '.3',
				['PALADIN'] = '/3',
				['PRIEST'] = '03',
				['ROGUE'] = '13',
				['SHAMAN'] = '23',
				['WARLOCK'] = '33',
				['WARRIOR'] = '43',
			},
			built_in = true,
		},
		['&A'] = {
			display_name = L['My class self buffs'],
			filter_type = 'Map',
			map_type = 'class',
			map = {
				['DEATHKNIGHT'] = '+0',
				['DRUID'] = ',0',
				['HUNTER'] = '-0',
				['MAGE'] = '.0',
				['PALADIN'] = '/0',
				['PRIEST'] = '00',
				['ROGUE'] = '10',
				['SHAMAN'] = '20',
				['WARLOCK'] = '30',
				['WARRIOR'] = '40',
			},
			built_in = true,
		},
		['&B'] = {
			display_name = L['My class pet buffs'],
			filter_type = 'Map',
			map_type = 'class',
			map = {
				['DEATHKNIGHT'] = '+1',
				['DRUID'] = '@J',
				['HUNTER'] = '-1',
				['MAGE'] = '@J',
				['PALADIN'] = '@J',
				['PRIEST'] = '@J',
				['ROGUE'] = '@J',
				['SHAMAN'] = '@J',
				['WARLOCK'] = '31',
				['WARRIOR'] = '@J',
			},
			built_in = true,
		},
		['&C'] = {
			display_name = L['My class friend buffs'],
			filter_type = 'Map',
			map_type = 'class',
			map = {
				['DEATHKNIGHT'] = '+2',
				['DRUID'] = ',2',
				['HUNTER'] = '-2',
				['MAGE'] = '.2',
				['PALADIN'] = '/2',
				['PRIEST'] = '02',
				['ROGUE'] = '12',
				['SHAMAN'] = '22',
				['WARLOCK'] = '32',
				['WARRIOR'] = '42',
			},
			built_in = true,
		},
		['&G'] = {
			display_name = L['My class enemy debuffs'],
			filter_type = 'Map',
			map_type = 'class',
			map = {
				['DEATHKNIGHT'] = '+6',
				['DRUID'] = ',6',
				['HUNTER'] = '-6',
				['MAGE'] = '.6',
				['PALADIN'] = '/6',
				['PRIEST'] = '06',
				['ROGUE'] = '16',
				['SHAMAN'] = '26',
				['WARLOCK'] = '36',
				['WARRIOR'] = '46',
			},
			built_in = true,
		},
		['&F'] = {
			display_name = L['My class friend debuffs'],
			filter_type = 'Map',
			map_type = 'class',
			map = {
				['DEATHKNIGHT'] = '@J',
				['DRUID'] = '@J',
				['HUNTER'] = '@J',
				['MAGE'] = '@J',
				['PALADIN'] = '/5',
				['PRIEST'] = '05',
				['ROGUE'] = '@J',
				['SHAMAN'] = '25',
				['WARLOCK'] = '@J',
				['WARRIOR'] = '@J',
			},
			built_in = true,
		},
		['&E'] = {
			display_name = L['My class self debuffs'],
			filter_type = 'Map',
			map_type == 'class',
			map = {
				['DEATHKNIGHT'] = '@J',
				['DRUID'] = '@J',
				['HUNTER'] = '@J',
				['MAGE'] = '.4',
				['PALADIN'] = '@J',
				['PRIEST'] = '04',
				['ROGUE'] = '@J',
				['SHAMAN'] = '@J',
				['WARLOCK'] = '@J',
				['WARRIOR'] = '44',

			},
			built_in = true,
		},
		['%A'] = {
			display_name = L['My race self buffs'],
			filter_type = 'Map',
			map_type = 'race',
			map = {
				['Human'] = '@J',
				['Dwarf'] = '60',
				['NightElf'] = '70',
				['Gnome'] = '@J',
				['Draenei'] = '@J',
				['Orc'] = ':0',
				['Scourge'] = ';0',
				['Tauren'] = '@J',
				['Troll'] = '=0',
				['BloodElf'] = '>0',
			},
			built_in = true,
		},
		['%B'] = {
			display_name = L['My race friend buffs'],
			filter_type = 'Map',
			map_type = 'race',
			map = {
				['Human'] = '52',
				['Dwarf'] = '62',
				['NightElf'] = '72',
				['Gnome'] = '82',
				['Draenei'] = '92',
				['Orc'] = ':2',
				['Scourge'] = ';2',
				['Tauren'] = '<2',
				['Troll'] = '=2',
				['BloodElf'] = '>2',
			},
			built_in = true,
		},
		['%D'] = {
			display_name = L['My race enemy debuffs'],
			filter_type = 'Map',
			map_type = 'race',
			map = {
				['Human'] = '@J',
				['Dwarf'] = '@J',
				['NightElf'] = '@J',
				['Gnome'] = '@J',
				['Draenei'] = '@J',
				['Orc'] = '@J',
				['Scourge'] = '@J',
				['Tauren'] = '<6',
				['Troll'] = '@J',
				['BloodElf'] = '>6',
			},
			built_in = true,
		},
		['%C'] = {
			display_name = L['My race self debuffs'],
			filter_type = 'Map',
			map_type = 'race',
			map = {
				['Human'] = '@J',
				['Dwarf'] = '@J',
				['NightElf'] = '@J',
				['Gnome'] = '@J',
				['Draenei'] = '@J',
				['Orc'] = ':4',
				['Scourge'] = '@J',
				['Tauren'] = '@J',
				['Troll'] = '@J',
				['BloodElf'] = '@J',
			},
			built_in = true,
		},
		['*A'] = {
			display_name = L['Extra buffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = extra_buffs,
			built_in = true,
		},
		['*B'] = {
			display_name = L['Extra friend debuffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = {},
			built_in = true,
		},
		['*C'] = {
			display_name = L['Extra enemy debuffs'],
			filter_type = 'Name',
			whitelist = true,
			name_list = {},
			built_in = true,
		},
		['*D'] = {
			display_name = L['Extra friend highlights'],
			filter_type = 'Name',
			whitelist = true,
			name_list = {},
			built_in = true,
		},
		['*E'] = {
			display_name = L['Extra enemy highlights'],
			filter_type = 'Name',
			whitelist = true,
			name_list = {},
			built_in = true,
		},
		['#A'] = {
			display_name = L['All self buffs'],
			filter_type = 'Meta',
			filters = {'&A','%A','@C'},
			operators = {'|','|'},
			built_in = true,
		},
		['#C'] = {
			display_name = L['All self debuffs'],
			filter_type = 'Meta',
			filters = {'&E','%C'},
			operators = {'|'},
			built_in = true,
		},
		['#B'] = {
			display_name = L['All friend buffs'],
			filter_type = 'Meta',
			filters =  {'&C','%B','*A'},
			operators = {'|','|'},
			built_in = true,
		},
		['#D'] = {
			display_name = L['All friend debuffs'],
			filter_type = 'Meta',
			filters = {'&F','&D','*B'},
			operators = {'|','|'},
			built_in = true,
		},
		['#E'] = {
			display_name = L['All enemy debuffs'],
			filter_type = 'Meta',
			filters = {'&G','%D','*C'},
			operators = {'|','|'},
			built_in = true,
		},
		['#F'] = {
			display_name = L['Dispellable or extra friend'],
			filter_type = 'Meta',
			filters = {'@K','*D'},
			operators = {'|'},
			built_in = true,
		},
		['#G'] = {
			display_name = L['Dispellable by me or extra friend'],
			filter_type = 'Meta',
			filters = {'&D','*D'},
			operators = {'|'},
			built_in = true,
		},
		['!B'] = {
			display_name = L['Default buffs'],
			filter_type = 'Meta',
			filters = {'@G','#A','@F','&B','@D','#B','@E','@L'},
			operators = {'&','|','&','|','&','|','|'},
			built_in = true,
			display_when = "buff",
		},
		['!C'] = {
			display_name = L['Default buffs, mine'],
			filter_type = 'Meta',
			filters = {'@H','!B','@E'},
			operators = {'&','|'},
			built_in = true,
			display_when = "buff",
		},
		['!D'] = {
			display_name = L['Default debuffs'],
			filter_type = 'Meta',
			filters = {'@G','#C','@D','#D','#E','@L'},
			operators = {'&','|','&','|','|'},
			built_in = true,
			display_when = "debuff",
		},
		['!E'] = {
			display_name = L['Default debuffs, mine'],
			filter_type = 'Meta',
			filters = {'@H','!D','&D'},
			operators = {'&','|'},
			built_in = true,
			display_when = "debuff",
		},
		['!F'] = {
			display_name = L['Highlight: all friend debuffs'],
			filter_type = 'Meta',
			filters = {'@D','@B'},
			operators = {'&'},
			built_in = true,
			display_when = "highlight",
		},
		['!G'] = {
			display_name = L['Highlight: dispellable debuffs'],
			filter_type = 'Meta',
			filters = {'!F','@K'},
			operators = {'&'},
			built_in = true,
			display_when = "highlight",
		},
		['!H'] = {
			display_name = L['Highlight: dispellable by me debuffs'],
			filter_type = 'Meta',
			filters = {'!F','&D'},
			operators = {'&'},
			built_in = true,
			display_when = "highlight",
		},
		['!I'] = {
			display_name = L['Highlight: Enemy buffs'],
			filter_type = 'Meta',
			filters = {'@E','@A','*E'},
			operators = {'&','&'},
			built_in = true,
			display_when = "highlight",
		},
		['!J'] = {
			display_name = L['Highlight: Friend debuffs'],
			filter_type = 'Meta',
			filters = {'!F','*D'},
			operators = {'&'},
			built_in = true,
			display_when = "highlight",
		},
	},
})

-- tables of options for the selection options

local anchor_values = {
	TOPLEFT_TOP        = L['Top-left on top'],
	TOPRIGHT_TOP       = L['Top-right on top'],
	TOPLEFT_LEFT       = L['Top-left on left'],
	TOPRIGHT_RIGHT     = L['Top-right on right'],
	BOTTOMLEFT_BOTTOM  = L['Bottom-left on bottom'],
	BOTTOMRIGHT_BOTTOM = L['Bottom-right on bottom'],
	BOTTOMLEFT_LEFT    = L['Bottom-left on left'],
	BOTTOMRIGHT_RIGHT  = L['Bottom-right on right'],
}

local growth_values = {
	left_up    = L["Left then up"],
	left_down  = L["Left then down"],
	right_up   = L["Right then up"],
	right_down = L["Right then down"],
	up_left    = L["Up then left"],
	up_right   = L["Up then right"],
	down_left  = L["Down then left"],
	down_right = L["Down then right"],
}

local width_type_values = {
	percent = L['Percentage of side'],
	fixed   = L['Fixed size'],
}

local show_when_values = {
	my_buffs = L['My own buffs'],
	my_debuffs = L['My own debuffs'],
	other_buffs = L["Others' buffs"],
	other_debuffs = L["Others' debuffs"],
	weapon_buffs = L["Weapon enchants"],
}

-- table to decide if the width option is actuually
-- representing width or height
local is_height = {
	down_right = true,
	down_left  = true,
	up_right   = true,
	up_left    = true,
}

PitBull4_Aura:SetColorOptionsFunction(function(self)
	local function get(info)
		local group = info[#info - 1]
		local id = info[#info]
		return unpack(self.db.profile.global.colors[group][id])
	end
	local function set(info, r, g, b, a)
		local group = info[#info - 1]
		local id = info[#info]
		self.db.profile.global.colors[group][id] = {r, g, b, a}
		self:UpdateAll()
	end
	return 'caster', {
		type = 'group',
		name = L['Caster'],
		inline = true,
		args = {
			my = {
				type = 'color',
				name = L['Self'],
				desc = L['Color for own buffs.'],
				get = get,
				set = set,
				order = 0,
			},
			other = {
				type = 'color',
				name = L['Others'],
				desc = L["Color for others' buffs."],
				get = get,
				set = set,
				order = 1,
			},
		},
	},
	'type', {
		type = 'group',
		name = L['Dispel type'],
		inline = true,
		args = {
			Poison = {
				type = 'color',
				name = L['Poison'],
				desc = L["Color for poison."],
				get = get,
				set = set,
				order = 0,
			},
			Magic = {
				type = 'color',
				name = L['Magic'],
				desc = L["Color for magic."],
				get = get,
				set = set,
				order = 1,
			},
			Disease = {
				type = 'color',
				name = L['Disease'],
				desc = L["Color for disease."],
				get = get,
				set = set,
				order = 2,
			},
			Curse = {
				type = 'color',
				name = L['Curse'],
				desc = L["Color for curse."],
				get = get,
				set = set,
				order = 3,
			},
			Enrage = {
				type = 'color',
				name = L['Enrage'],
				desc = L["Color for enrage."],
				get = get,
				set = set,
				order = 4,
			},
			["nil"] = {
				type = 'color',
				name = L['Other'],
				desc = L["Color for other auras without a type."],
				get = get,
				set = set,
				order = 5,
			},
		},
	}, function(info)
		-- reset_default_colors
		local db = self.db.profile.global.colors
		for group,group_table in pairs(color_defaults) do
			for color,color_value in pairs(group_table) do
				if type(color_value) == "table" then
					for i = 1, #color_value do
						db[group][color][i] = color_value[i]
					end
				else
					db[group][color] = color_value
				end
			end
		end
	end
end)


PitBull4_Aura:SetGlobalOptionsFunction(function(self)
	return 'guess_weapon_enchant_icon', {
		type = 'toggle',
		name = L['Use spell icon'],
		desc = L['Use the spell icon for the weapon enchant rather than the icon for the weapon.'],
		get = function(info)
			return self.db.profile.global.guess_weapon_enchant_icon
		end,
		set = function(info, value)
			self.db.profile.global.guess_weapon_enchant_icon = value
			self:UpdateWeaponEnchants(true)
		end,
	}, 'filter_editor', {
		type = 'group',
		childGroups = 'tab',
		name = L['Aura filter editor'],
		desc = L['Configure the filters for the aura modules.'],
		args = PitBull4_Aura:GetFilterEditor(),
	}
end)

local HIGHLIGHT_FILTER_OPTIONS = {}
local function copy(data)
	local t = {}
	for k, v in pairs(data) do
		if type(v) == table then
			t[k] = copy(v)
		else
			t[k] = v
		end
	end
	return t
end

PitBull4_Aura.OnProfileChanged_funcs[#PitBull4_Aura.OnProfileChanged_funcs+1] = 
function(self)
	-- Recalculate the filter options on a profile change
	self.SetHighlightOptions(self, HIGHLIGHT_FILTER_OPTIONS)
end

function PitBull4_Aura.SetHighlightOptions(self, options)
	local filter_option = {
		type = 'select',
		name = L['Filter'],
		desc = L['Select a filter to use for highlighting auras.'],
		get = function(info)
			local pos = tonumber(string.match(info[#info],"_(%d+)"))
			return PitBull4.Options.GetLayoutDB(self).highlight_filters[pos] or ""
		end,
		set = function(info, value)
			local db = PitBull4.Options.GetLayoutDB(self)
			local filters = db.highlight_filters
			local pos = tonumber(string.match(info[#info],"_(%d+)"))
			if value == "" then
				table.remove(filters,pos)
				table.remove(db.highlight_filters_color_by_type,pos)
				table.remove(db.highlight_filters_custom_color,pos)
			else
				filters[pos] = value
				if db.highlight_filters_color_by_type[pos] == nil then
					db.highlight_filters_color_by_type[pos] = true
				end
				if not db.highlight_filters_custom_color[pos] then
					db.highlight_filters_custom_color[pos] = {1, 1, 1, 1}
				end
			end
			PitBull4_Aura.SetHighlightOptions(self, options)
			PitBull4_Aura:UpdateAll()
		end,
		values = function(info)
			local t = {}
			local filters = PitBull4_Aura.db.profile.global.filters
			t[""] = L["None"]
			for k,v in pairs(filters) do
				local display_when = v.display_when
				if display_when == "both" or display_when == "highlight" then
					t[k] = v.display_name or k
				end
			end
			return t
		end,
		disabled = function(info)
			local db = PitBull4.Options.GetLayoutDB(self)
			return not db.enabled or not db.highlight
		end,
		width = 'double',
	}
	local spacer = {
		type = 'description',
		name = '',
		desc = '',
	}
	local color_type_option = {
		type = 'toggle',
		name = L['Color by type'],
		desc = L['Use the auras type to select the color of the highlight.'],
		get = function(info)
			local pos = tonumber(string.match(info[#info],"_(%d+)"))
			local color_by_type = PitBull4.Options.GetLayoutDB(self).highlight_filters_color_by_type[pos]
			if color_by_type == nil then
				color_by_type = true
			end
			return color_by_type
		end,
		set = function(info, value)
			local pos = tonumber(string.match(info[#info],"_(%d+)"))
			local db = PitBull4.Options.GetLayoutDB(self)
			db.highlight_filters_color_by_type[pos] = value
			PitBull4_Aura:UpdateAll()
		end,
		disabled = function(info)
			local pos = tonumber(string.match(info[#info],"_(%d+)"))
			local db = PitBull4.Options.GetLayoutDB(self)
			local highlight_filters = db.highlight_filters
			return not db.highlight or not highlight_filters[pos] or highlight_filters[pos] == ""
		end,
	}
	local custom_color_option = {
		type = 'color',
		name = L['Custom color'],
		desc = L['Set the custom color for the highlight if not coloring by type.'],
		get = function(info)
			local pos = tonumber(string.match(info[#info],"_(%d+)"))
			local color = PitBull4.Options.GetLayoutDB(self).highlight_filters_custom_color[pos]
			if not color then
				color = { 1, 1, 1, 1}
			end
			return unpack(color)
		end,
		set = function(info, r, g, b, a)
			local pos = tonumber(string.match(info[#info],"_(%d+)"))
			local db = PitBull4.Options.GetLayoutDB(self)
			db.highlight_filters_custom_color[pos] = {r, g, b, a}
			PitBull4_Aura:UpdateAll()
		end,
		disabled = function(info)
			local pos = tonumber(string.match(info[#info],"_(%d+)"))
			local db = PitBull4.Options.GetLayoutDB(self)
			local highlight_filters = db.highlight_filters
			return not db.highlight or db.highlight_filters_color_by_type[pos] or not highlight_filters[pos] or highlight_filters[pos] == ""
		end,
	}
	local header = {
		type = 'header',
		name = '',
		desc = '',
	}

	-- Make sure this table is empty so we can remove entries
	wipe(options)
	
	local order = 1
	local db = PitBull4.Options.GetLayoutDB(self)
	local filters = db.highlight_filters
	if not filters then
		filters = {}
		db.highlight_filters = filters
	end
	db.highlight_filters_color_by_type = db.highlight_filters_color_by_type or {}
	db.highlight_filters_custom_color = db.highlight_filters_custom_color or {}

	options.enable = {
		type = 'toggle',
		name = L['Enable'],
		desc = L['Enable aura highlighting for this layout.'],
		get = function(info)
			return PitBull4.Options.GetLayoutDB(self).highlight
		end,
		set = function(info, value)
			PitBull4.Options.GetLayoutDB(self).highlight = value
			PitBull4_Aura:UpdateAll()
		end,
		disabled = function(info)
			return not PitBull4.Options.GetLayoutDB(self).enabled
		end,
		order = order,
	}
	order = order + 1

	options.style = {
		type = 'select',
		name = L['Style'],
		desc = L['Select the style of the highlight for this layout.'],
		get = function(info)
			return PitBull4.Options.GetLayoutDB(self).highlight_style
		end,
		set = function(info, value)
			PitBull4.Options.GetLayoutDB(self).highlight_style = value
			PitBull4_Aura:UpdateAll()
		end,
		values = {
			border = L["Border"],
			thinborder = L["Thin Border"],
			normal = L["Normal"],
		},
		disabled = function(info)
			local db = PitBull4.Options.GetLayoutDB(self)
			return not db.enabled or not db.highlight
		end,
		order = order,
	}
	order = order + 1

	options.spacer = {
		type = 'header',
		name = '',
		desc = '',
		order = order,
	}
	order = order + 1

	local max = #filters+1
	for i = 1, max do
		local slot = 'filter_'..i
		options[slot] = copy(filter_option)
		options[slot].order = order
		order = order + 1
		slot = 'spacer_'..i
		options[slot] = copy(spacer)
		options[slot].order = order
		order = order + 1
		slot = 'color_type_'..i
		options[slot] = copy(color_type_option)
		options[slot].order = order
		order = order + 1
		slot = 'custom_color_'..i
		options[slot] = copy(custom_color_option)
		options[slot].order = order
		order = order + 1
		if i ~= max then
			slot = 'header_'..i
			options[slot] = copy(header)
			options[slot].order = order
			order = order + 1
		end
	end
end

local CURRENT_TEXT
local CURRENT_BORDER
PitBull4_Aura:SetLayoutOptionsFunction(function(self)

	-- Functions for use in the options
	local function get(info)
		local id = info[#info]
		return PitBull4.Options.GetLayoutDB(self)[id]
	end
	local function set(info, value)
		local id = info[#info]
		PitBull4.Options.GetLayoutDB(self)[id] = value
		PitBull4.Options.UpdateFrames()
	end
	local function get_multi(info, key)
		local id = info[#info]
		return PitBull4.Options.GetLayoutDB(self)[id][key]
	end
	local function set_multi(info, key, value)
		local id = info[#info]
		PitBull4.Options.GetLayoutDB(self)[id][key] = value
		PitBull4.Options.UpdateFrames()
	end
	local function get_layout(info)
		local id = info[#info]
		local group = info[#info - 1]
		return PitBull4.Options.GetLayoutDB(self).layout[group][id]
	end
	local function set_layout(info, value)
		local id = info[#info]
		local group = info[#info - 1]
		PitBull4.Options.GetLayoutDB(self).layout[group][id] = value
		PitBull4.Options.UpdateFrames()
	end
	local function get_layout_filter(info)
		local id = info[#info]
		return PitBull4.Options.GetLayoutDB(self).layout[id].filter
	end
	local function set_layout_filter(info, value)
		local id = info[#info]
		PitBull4.Options.GetLayoutDB(self).layout[id].filter = value
		PitBull4.Options.UpdateFrames()
	end
	local function get_layout_filter_values(info)
		local t = {}
		local filters = PitBull4_Aura.db.profile.global.filters
		t[""] = L["None"]
		for k,v in pairs(filters) do
			local display_when = v.display_when
			local group = info[#info]
			if display_when == "both" or display_when == group then
				t[k] = v.display_name or k
			end
		end
		return t
	end
	local function get_layout_anchor(info)
		local group = info[#info - 1]
		local db = PitBull4.Options.GetLayoutDB(self).layout[group]
		return db.anchor .. "_" .. db.side
	end
	local function set_layout_anchor(info, value)
		local group = info[#info - 1]
		local db = PitBull4.Options.GetLayoutDB(self).layout[group]
		db.anchor, db.side = string.match(value, "(.*)_(.*)")
		PitBull4.Options.UpdateFrames()
	end
	local function is_aura_disabled(info)
		return not PitBull4.Options.GetLayoutDB(self).enabled
	end

	-- Layout configuration.  It's used for both buffs and debuffs
	local layout = {
		type = 'group',
		name = function(info)
			local group = info[#info]
			if group == 'buff' then
				return L['Buff layout']
			else
				return L['Debuff layout']
			end
		end,
		args = {
			size = {
				type = 'range',
				name = L['Icon size'],
				desc = L['Set size of the aura icons.'],
				get = get_layout,
				set = set_layout,
				disabled = is_aura_disabled,
				min = 4,
				max = 48,
				step = 1,
				order = 0,
			},
			my_size = {
				type = 'range',
				name = L['Icon size for my auras'],
				desc = L['Set size of icons of auras cast by me.'],
				get = get_layout,
				set = set_layout,
				disabled = is_aura_disabled,
				min = 4,
				max = 48,
				step = 1,
				order = 1,
			},
			size_to_fit = {
				type = 'toggle',
				name = L['Size to fit'],
				desc = L['Size auras to use up as much of the space available as possible.'],
				get = get_layout,
				set = set_layout,
				disabled = is_aura_disabled,
				order = 2,
			},
			break_1 = {
				type = 'header',
				name = '',
				order = 10,
			},
			anchor = {
				-- Anchor option actually sets 2 values, we do the split here so we don't have to do it in a more time sensitive place
				type = 'select',
				name = L['Start at'],
				desc = L['Set the corner and side to start auras from.'],
				get = get_layout_anchor,
				set = set_layout_anchor,
				disabled = is_aura_disabled,
				values = anchor_values,
				order = 11,
			},
			growth = {
				type = 'select',
				name = L['Growth direction'],
				desc = L['Direction that the auras will grow.'],
				get = get_layout,
				set = set_layout,
				disabled = is_aura_disabled,
				values = growth_values,
				order = 12,
			},
			break_2 = {
				type = 'header',
				name = '',
				order = 20,
			},
			offset_x = {
				type = 'range',
				name = L['Horizontal offset'],
				desc = L['Number of pixels to offset the auras from the start point horizontally.'],
				get = get_layout,
				set = set_layout,
				disabled = is_aura_disabled,
				min = -200,
				max = 200,
				step = 1,
				bigStep = 5,
				order = 21,
			},
			offset_y = {
				type = 'range',
				name = L['Vertical offset'],
				desc = L['Number of pixels to offset the auras from the start point vertically.'],
				get = get_layout,
				set = set_layout,
				disabled = is_aura_disabled,
				min = -200,
				max = 200,
				step = 1,
				bigStep = 5,
				order = 22,
			},
			break_3 = {
				type = 'header',
				name = '',
				order = 30,
			},
			sort = {
				type = 'toggle',
				name = L['Sort'],
				desc = L['Sort auras by type and alphabetically, preferring your own auras first.'],
				get = get_layout,
				set = set_layout,
				disabled = is_aura_disabled,
				order = 31,
			},
			reverse = {
				type = 'toggle',
				name = L['Reverse'],
				desc = L['Reverse order in which auras are displayed.'],
				get = get_layout,
				set = set_layout,
				disabled = is_aura_disabled,
				order = 32,
			},
			break_4 = {
				type = 'header',
				name = '',
				order = 40,
			},
			width_type = {
				type = 'select',
				name = function(info)
					local group = info[#info - 1]
					local db = PitBull4.Options.GetLayoutDB(self).layout[group]
					if is_height[db.growth] then
						return L['Height type']
					else
						return L['Width type']
					end
				end,
				desc = function(info)
					local group = info[#info - 1]
					local db = PitBull4.Options.GetLayoutDB(self).layout[group]
					if is_height[db.growth] then
						return L['Select how to configure the height setting.']
					else
						return L['Select how to configure the width setting.']
					end
				end,
				get = get_layout,
				set = set_layout,
				disabled = is_aura_disabled,
				values = width_type_values,
				order = 41,
			},
			width = {
				type = 'range',
				name = function(info)
					local group = info[#info - 1]
					local db = PitBull4.Options.GetLayoutDB(self).layout[group]
					if is_height[db.growth] then
						return L['Height']
					else
						return L['Width']
					end
				end,
				desc = function(info)
					local group = info[#info - 1]
					local db = PitBull4.Options.GetLayoutDB(self).layout[group]
					if is_height[db.growth] then
						return L['Set how tall the auras will be allowed to grow in pixels.']
					else
						return L['Set how wide the auras will be allowed to grow in pixels.']
					end
				end,
				get = get_layout,
				set = set_layout,
				disabled = is_aura_disabled,
				hidden = function(info)
					local group = info[#info - 1]
					return PitBull4.Options.GetLayoutDB(self).layout[group].width_type ~= "fixed"
				end,
				min = 20,
				max = 400,
				step = 1,
				bigStep = 5,
				order = 42,
			},
			width_percent = {
				type = 'range',
				name = function(info)
					local group = info[#info - 1]
					local db = PitBull4.Options.GetLayoutDB(self).layout[group]
					if is_height[db.growth] then
						return L['Height']
					else
						return L['Width']
					end
				end,
				desc = function(info)
					local group = info[#info - 1]
					local db = PitBull4.Options.GetLayoutDB(self).layout[group]
					if is_height[db.growth] then
						return L['Set how tall the auras will be allowed to grow as a percentage of the height of the frame they are attached to.']
					else
						return L['Set how wide the auras will be allowed to grow as a percentage of the width of the frame they are attached to.']
					end
				end,
				get = get_layout,
				set = set_layout,
				disabled = is_aura_disabled,
				hidden = function(info)
					local group = info[#info - 1]
					return PitBull4.Options.GetLayoutDB(self).layout[group].width_type ~= "percent"
				end,
				min = 0.01,
				max = 1.0,
				step = 0.01,
				isPercent = true,
				order = 42,
			},
			break_5 = {
				type = 'header',
				name = '',
				order = 50,
			},
			row_spacing = {
				type = 'range',
				name = L['Row spacing'],
				desc = L['Set the number of pixels between each row of auras.'],
				get = get_layout,
				set = set_layout,
				disabled = is_aura_disabled,
				min = 0,
				max = 10,
				step = 1,
				order = 51,
			},
			col_spacing = {
				type = 'range',
				name = L['Column spacing'],
				desc = L['Set the number of pixels between each column of auras.'],
				get = get_layout,
				set = set_layout,
				disabled = is_aura_disabled,
				min = 0,
				max = 10,
				step = 1,
				order = 52,
			},
			new_row_size = {
				type = 'toggle',
				name = function(info)
					local group = info[#info - 1]
					local db = PitBull4.Options.GetLayoutDB(self).layout[group]
					if is_height[db.growth] then
						return L['New column on resize']
					else
						return L['New row on resize']
					end
				end,
				desc = function(info)
					local group = info[#info - 1]
					local db = PitBull4.Options.GetLayoutDB(self).layout[group]
					if is_height[db.growth] then
						return L['Start a new column whenever the size of the aura changes.']
					else
						return L['Start a new row whenever the size of the aura changes.']
					end
				end,
				get = get_layout,
				set = set_layout,
				order = 53,
			},
			break_5 = {
				type = 'header',
				name = '',
				order = 54,
			},
			frame_level = {
				type = 'range',
				name = L['Frame level'],
				desc = L['Set how many frame levels auras are above the frame.'],
				get = get_layout,
				set = set_layout,
				disabled = is_aura_disabled,
				min = 1,
				max = 10,
				step = 1,
				order = 55,
			},
		},
	}

	PitBull4_Aura.SetHighlightOptions(self,HIGHLIGHT_FILTER_OPTIONS)

	if not CURRENT_TEXT then
		CURRENT_TEXT = "my_buffs.cooldown_text"
	end
	if not CURRENT_BORDER then
		CURRENT_BORDER = "my_buffs.friend"
	end
	local LibSharedMedia = LibStub("LibSharedMedia-3.0", true)
	LoadAddOn("AceGUI-3.0-SharedMediaWidgets")
	local AceGUI = LibStub("AceGUI-3.0")

	local function split_text()
		return string.match(CURRENT_TEXT,"([^%.]*)%.(.*)")
	end

	local function GetTextDB()
		local db = PitBull4.Options.GetLayoutDB(self)
		local rule,text = split_text()
		return db.texts[rule][text]
	end

	local function disable_text(info)
		local rule,text = split_text()
		if text == "count" then
			return false
		end
		return not PitBull4.Options.GetLayoutDB(self)[text][rule]
	end

	local function get_text(info)
		local id = info[#info]
		return GetTextDB()[id]
	end
	
	local function set_text(info, value)
		local id = info[#info]
		GetTextDB()[id] = value

		PitBull4.Options.UpdateFrames()
	end

	local function split_border()
		local rule, relationship = string.match(CURRENT_BORDER,"([^$.]*)%.(.*)")
		if not rule then
			return CURRENT_BORDER
		else
			return rule, relationship
		end
	end

	local function GetBorderDB()
		local db = PitBull4.Options.GetLayoutDB(self)
		local rule,relationship = split_border()
		if relationship then
			return db.borders[rule][relationship]
		else
			return db.borders[rule]
		end
	end

	local function get_border(info)
		local id = info[#info]
		return GetBorderDB()[id]
	end

	local function set_border(info, value)
		local id = info[#info]
		GetBorderDB()[id] = value

		PitBull4.Options.UpdateFrames()
	end

	return 	true, 'display', {
		type = 'group',
		name = L['Display'],
		args = {
			enabled_buffs = {
				type = 'toggle',
				name = L['Buffs'],
				desc = L['Enable display of buffs.'],
				get = get,
				set = set,
				disabled = is_aura_disabled,
				order = 0,
			},
			enabled_weapons = {
				type = 'toggle',
				name = L['Weapon enchants'],
				desc = L['Enable display of temporary weapon enchants.'],
				get = function(info)
					local db = PitBull4.Options.GetLayoutDB(self)
					return db.enabled_buffs and db.enabled_weapons
				end,
				set = set,
				disabled = function(info)
					return is_aura_disabled(info) or not PitBull4.Options.GetLayoutDB(self).enabled_buffs
				end,
				order = 1,
			},
			enabled_debuffs = {
				type = 'toggle',
				name = L['Debuffs'],
				desc = L['Enable display of debuffs.'],
				get = get,
				set = set,
				disabled = is_aura_disabled,
				order = 2,
			},
			max = {
				type = 'group',
				name = L['Limit number of displayed auras.'],
				inline = true,
				order = 3,
				args = {
					max_buffs = {
						type = 'range',
						name = L['Buffs'],
						desc = L['Set the maximum number of buffs to display.'],
						get = get,
						set = set,
						disabled = is_aura_disabled,
						min = 1,
						max = 80,
						step = 1,
						order = 0,
					},
					max_debuffs = {
						type = 'range',
						name = L['Debuffs'],
						desc = L['Set the maximum number of debuffs to display.'],
						get = get,
						set = set,
						disabled = is_aura_disabled,
						min = 1,
						max = 80,
						step = 1,
						order = 1,
					},
				},
			},
			cooldown = {
				type = 'multiselect',
				name = L['Time remaining spiral'],
				desc = L['Set when the time remaining spiral shows.'],
				values = show_when_values,
				get = get_multi,
				set = set_multi,
				disabled = is_aura_disabled,
				order = 5,
			},
			zoom_aura = {
				type = 'toggle',
				name = L['Zoom icon'],
				desc = L['Zoom in on aura icons slightly.'],
				get = get,
				set = set,
				disabled = is_aura_disabled,
				order = 6,
			},
			click_through = {
				type = 'toggle',
				name = L['Click-through'],
				desc = L['Disable capturing clicks on aura icons allowing the clicks to fall through to the window underneath the aura.'],
				get = get,
				set = set,
				disabled = is_aura_disabled,
				order = 7,
			},
		},
	},
	'buff', layout,
	'debuff', layout,
	'texts', {
		type = 'group',
		name = L['Texts'],
		desc = L['Configure the text displayed on auras.'],
		args = {
			current_text = {
				type = 'select',
				name = L['Current text'],
				desc = L['Choose the text to configure.'],
				get = function(info)
					return CURRENT_TEXT
				end,
				set = function(info, value)
					CURRENT_TEXT = value
				end,
				values = {
					['my_buffs.count'] = L['My own buffs count'],
					['my_buffs.cooldown_text'] = L['My own buffs time remaining'],
					['my_debuffs.count'] = L['My own debuffs count'],
					['my_debuffs.cooldown_text'] = L['My own debuffs time remaining'],
					['other_buffs.count'] = L["Others' buffs count"],
					['other_buffs.cooldown_text'] = L["Others' buffs time remaining"],
					['other_debuffs.count'] = L["Others' debuffs count"],
					['other_debuffs.cooldown_text'] = L["Others' debuffs time remaining"],
					['weapon_buffs.count'] = L['Weapon enchants count'],
					['weapon_buffs.cooldown_text'] = L['Weapon enchants time remaining'],
				},
				width = 'double',
				order = 1,
			},
			div = {
				type = 'header',
				name = '',
				desc = '',
				order = 2,
			},
			enabled = {
				type = 'toggle',
				name = L['Enabled'],
				desc = L['Enable this text.'],
				get = function(info)
					local rule,text = split_text()
					return PitBull4.Options.GetLayoutDB(self)[text][rule]
				end,
				set = function(info,value)
					local rule,text = split_text()
					PitBull4.Options.GetLayoutDB(self)[text][rule] = value
					PitBull4.Options.UpdateFrames()
				end,
				hidden = function(info)
					local _,text = split_text()
					return text == "count"
				end,
				order = 3,
			},
			font = {
				type = 'select',
				name = L['Font'],
				desc = L["Which font to use for this text."] .. "\n" .. L["If you want more fonts, you should install the addon 'SharedMedia'."],
				get = function(info)
					local font = GetTextDB().font
					return font or PitBull4.Options.GetLayoutDB(false).font
				end,
				set = function(info, value)
					local default = PitBull4.Options.GetLayoutDB(false).font
					if value == default then
						value = nil
					end

					GetTextDB().font = value

					PitBull4.Options.UpdateFrames()
				end,
				values = function(info)
					local t = {}
					local default = PitBull4.Options.GetLayoutDB(false).font
					for k in pairs(LibSharedMedia:HashTable("font")) do
						if k == default then
							t[k] = ("%s (Default)"):format(k)
						else
							t[k] = k
						end
					end
					return t
				end,
				hidden = function(info)
					return not LibSharedMedia
				end,
				disabled = disable_text,
				dialogControl = AceGUI.WidgetRegistry["LSM30_Font"] and "LSM30_Font" or nil,
				order = 4,
			},
			size = {
				type = 'range',
				name = L["Size"],
				desc = L["Size of the text."],
				get = get_text, 
				set = set_text,
				min = 0.3,
				max = 3,
				step = 0.01,
				bigStep = 0.05,
				isPercent = true,
				disabled = disable_text,
				order = 5,
			},
			anchor = {
				type = 'select',
				name = L['Anchor'],
				desc = L['Set the anchor point on the inside of the aura.'],
				get = get_text,
				set = set_text,
				values = {
					['TOP'] = L['Top'],
					['BOTTOM'] = L['Bottom'],
					['LEFT'] = L['Left'],
					['RIGHT'] = L['Right'],
					['TOPLEFT'] = L['Top-left'],
					['TOPRIGHT'] = L['Top-right'],
					['BOTTOMLEFT'] = L['Bottom-left'],
					['BOTTOMRIGHT'] = L['Bottom-right'],
					['CENTER'] = L['Center'],
				},
				disabled = disable_text,
				order = 6,
			},
			offset_x = {
				type = 'range',
				name = L['Horizontal offset'],
				desc = L['Number of pixels to offset the text from the anchor point horizontally.'],
				get = get_text,
				set = set_text,
				min = -50,
				max = 50,
				step = 1,
				bigStep = 5,
				disabled = disable_text,
				order = 7,
			},
			offset_y = {
				type = 'range',
				name = L['Vertical offset'],
				desc = L['Number of pixels to offset the text from the anchor point vertically.'],
				get = get_text,
				set = set_text,
				min = -50,
				max = 50,
				step = 1,
				bigStep = 5,
				disabled = disable_text,
				order = 8,
			},
			color = {
				type = 'color',
				name = L['Color'],
				desc = L['Set the color of the text.'],
				hasAlpha = true,
				get = function(info)
					return unpack(GetTextDB().color)
				end,
				set = function(info, r, g, b, a)
					local color = GetTextDB().color
					color[1], color[2], color[3], color[4] = r, g, b, a
					PitBull4.Options.UpdateFrames()
				end,
				disabled = function(info)
					return GetTextDB().color_by_time
				end,
				disabled = disable_text,
				order = 9,
			},
			color_by_time = {
				type = 'toggle',
				name = L['Color by time'],
				desc = L['Color the text by the time remaining on the aura.'],
				get = get_text,
				set = set_text,
				hidden = function(info)
					local _,text = split_text()
					return text == "count"
				end,
				disabled = disable_text,
				order = 10,
			},
		},
	},
	'borders', {
		type = 'group',
		name = L['Borders'],
		desc = L['Configure the borders that are applied around the auras.'],
		args = {
			current_text = {
				type = 'select',
				name = L['Current border'],
				desc = L['Choose the border to configure.'],
				get = function(info)
					return CURRENT_BORDER
				end,
				set = function(info, value)
					CURRENT_BORDER = value
				end,
				values = {
					['my_buffs.friend'] = L['My own buffs on friendly units'],
					['my_buffs.enemy'] = L['My own buffs on enemy units'],
					['my_debuffs.friend'] = L['My own debuffs on friendly units'],
					['my_debuffs.enemy'] = L['My own debuffs on enemy units'],
					['other_buffs.friend'] = L["Others' buffs on friendly units"],
					['other_buffs.enemy'] = L["Others' buffs on enemy"],
					['other_debuffs.friend'] = L["Others' debuffs on friendly units"],
					['other_debuffs.enemy'] = L["Others' debuffs on enemy units"],
					['weapon_buffs'] = L['Weapon enchants'],
				},
				width = 'double',
				order = 1,
			},
			div = {
				type = 'header',
				name = '',
				desc = '',
				order = 2,
			},
			enabled = {
				type = 'toggle',
				name = L['Enabled'],
				desc = L['Enable this border.'],
				get = get_border,
				set = set_border,
				order = 3,
			},
			color_type = {
				type = 'select',
				name = L['Color by'],
				desc = L['Choose how to color this border.'],
				get = get_border,
				set = function(info, value)
					local border_db = GetBorderDB()
					border_db.color_type = value
					if value == "custom" then
						border_db.custom_color = { 0.75, 0.75, 0.75 }
					else
						border_db.custom_color = nil
					end

					PitBull4.Options.UpdateFrames()
				end,
				values = function(info)
					local t = {}
					if CURRENT_BORDER == "weapon_buffs" then
						t.weapon = L['Weapon quality']
					else
						t.caster = L['Caster']
						t.type = L['Dispel type']
					end
					t.custom = L['Custom color']
					return t
				end,
				order = 4,
			},
			custom_color = {
				type = 'color',
				name = L['Custom color'],
				desc = L['Set the color of the border.'],
				get = function(info)
					return unpack(GetBorderDB().custom_color)
				end,
				set = function(info, r, g, b, a)
					local color = GetBorderDB().custom_color
					color[1], color[2], color[3], color[4] = r, g, b, a
					PitBull4.Options.UpdateFrames()
				end,
				hidden = function(info)
					return GetBorderDB().color_type ~= "custom"
				end,
				order = 5,
			},
		},
	},
	'filters', {
		type = 'group',
		name = L['Filters'],
		desc = L['Select the filters to be used to limit the auras that are displayed.'],
		args = {
			buff = {
				type = 'select',
				name = L['Buff'],
				desc = L['Set the aura filter to filter the buff auras.'],
				get = get_layout_filter,
				set = set_layout_filter,
				values = get_layout_filter_values,
				disabled = is_aura_disabled,
				width = 'double',
				order = 1,
			},
			debuff = {
				type = 'select',
				name = L['Debuff'],
				desc = L['Set the aura filter to filter the debuff auras.'],
				get = get_layout_filter,
				set = set_layout_filter,
				values = get_layout_filter_values,
				disabled = is_aura_disabled,
				width = 'double',
				order = 2,
			},
		},
	},
	'highlights', {
		type = 'group',
		name = L['Highlights'],
		desc = L['Configure what auras trigger a highlight.'],
		args = HIGHLIGHT_FILTER_OPTIONS,
	}
end)
