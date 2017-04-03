local name, ns = ...
local mod = LibStub("AceAddon-3.0"):NewAddon(name, "AceEvent-3.0")

local db
local defaults = {
	profile = {
		addons = {
			["*"] = {},
		},
	},
}

function mod:OnInitialize()
	db = LibStub("AceDB-3.0"):New("Bartender4DualspecDB", defaults)
end

local addons = {}
function mod:RegisterAddon(name, present, db)
	addons[name] = {
		isPresent = present,
		db = db,
	}
end

function mod:OnEnable()
	self:MakeOptions()
	self:RegisterEvent("PLAYER_TALENT_UPDATE")
	self:PLAYER_TALENT_UPDATE();
end

function mod:PLAYER_TALENT_UPDATE()
	local current_talents = GetActiveTalentGroup()
	for k,v in pairs(db.profile.addons) do
		if not v.enabled then return end
		local supposed_profile = v[current_talents]
		if not supposed_profile then return end
		local addondb = addons[k].db()
		if addondb:GetCurrentProfile() ~= supposed_profile then
			addondb:SetProfile(supposed_profile)
		end
	end
end


-- options
local options = {
	name = name,
	desc = name,
	type = 'group',
	args = {},
}

local choices_cache = {}

local function getProfileChoices(info)
	local addon = info.arg
	local choices = {}
	for _, v in pairs(addons[addon].db():GetProfiles()) do
		choices[v] = v
	end
	return choices
end

local function getEnabled(info)
	return db.profile.addons[info.arg].enabled
end

local function getDisabled(info)
	return not getEnabled(info)
end

local function setEnabled(info, value)
	db.profile.addons[info.arg].enabled = value
end

local function getPrimary(info)
	return db.profile.addons[info.arg][1]
end

local function setPrimary(info, value)
	db.profile.addons[info.arg][1] = value
end

local function getSecondary(info)
	return db.profile.addons[info.arg][2]
end

local function setSecondary(info, value)
	db.profile.addons[info.arg][2] = value
end

local function makeAddonOption(addon)
	local opt = {
		name = addon,
		desc = addon,
		type = 'group',
		args = {
			enabled = {
				name = "Enabled",
				desc = "Enable dualspec profile changing",
				type = 'toggle',
				get = getEnabled,
				set = setEnabled,
				arg = addon,
			},
			primary = {
				name = "Primary",
				desc = "Profile for Primary Talent spec",
				type = 'select',
				values = getProfileChoices,
				get = getPrimary,
				set = setPrimary,
				disabled = getDisabled,
				arg = addon,
			},
			secondary = {
				name = "Secondary",
				desc = "Profile for Secondary Talent spec",
				type = 'select',
				values = getProfileChoices,
				get = getSecondary,
				set = setSecondary,
				disabled = getDisabled,
				arg = addon,
			},
		},
	}
	options.args[addon] = opt
end

local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

function mod:MakeOptions()
	for k,v in pairs(addons) do
		if v.isPresent() then
			makeAddonOption(k)
		end
	end
	AceConfig:RegisterOptionsTable(name, options)
	AceConfigDialog:AddToBlizOptions(name, name)
end

mod:RegisterAddon(
	"Bartender4",
	function()
		return Bartender4 ~= nil
	end,
	function()
		return Bartender4.db
	end
)

mod:RegisterAddon(
	"PitBull4",
	function()
		return PitBull4 ~= nil
	end,
	function()
		return PitBull4.db
	end
)
