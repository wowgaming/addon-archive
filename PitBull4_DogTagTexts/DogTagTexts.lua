if select(6, GetAddOnInfo("PitBull4_" .. (debugstack():match("[o%.][d%.][u%.]les\\(.-)\\") or ""))) ~= "MISSING" then return end

local PitBull4 = _G.PitBull4
if not PitBull4 then
	error("PitBull4_DogTagTexts requires PitBull4")
end

local L = PitBull4.L

local PitBull4_DogTagTexts = PitBull4:NewModule("DogTagTexts")

local LibDogTag
local texts = {}

PitBull4_DogTagTexts:SetModuleType("text_provider")
PitBull4_DogTagTexts:SetName(L["DogTag-3.0 texts"])
PitBull4_DogTagTexts:SetDescription(L["Text provider for LibDogTag-3.0 texts."])
PitBull4_DogTagTexts:SetDefaults({
	elements = {
		['**'] = {
			size = 1,
			attach_to = "root",
			location = "edge_top_left",
			position = 1,
			exists = false,
			code = "",
			enabled = true,
		},
	},
	first = true
},
{
	-- Global defaults
	enabled = false,
})

function PitBull4_DogTagTexts:OnNewLayout(layout)
	local layout_db = self.db.profile.layouts[layout]
	
	if not layout_db.first then
		return
	end
	layout_db.first = false
	
	local texts = layout_db.elements
	for k in pairs(texts) do
		texts[k] = nil
	end
	for name, data in pairs {
		[L["Name"]] = {
			code = "[Name] [(AFK or DND):Angle]",
			attach_to = "HealthBar",
			location = "left"
		},
		[L["Health"]] = {
			code = "[Status or (FractionalHP:Short ' || ' PercentHP:Percent)]",
			attach_to = "HealthBar",
			location = "right",
		},
		[L["Class"]] = {
			code = "[Classification] [Level:DifficultyColor] [(if (IsPlayer or (IsEnemy and not IsPet)) then Class):ClassColor] [DruidForm:Paren] [SmartRace]",
			attach_to = "PowerBar",
			location = "left",
		},
		[L["Power"]] = {
			code = "[if HasMP then FractionalMP]",
			attach_to = "PowerBar",
			location = "right",
		},
		[L["Reputation"]] = {
			code = "[if IsMouseOver then ReputationName else if ReputationName then FractionalReputation ' ' PercentReputation:Percent:Paren]",
			attach_to = "ReputationBar",
			location = "center",
		},
		[L["Cast"]] = {
			code = "[Alpha((-CastStopDuration or 0) + 1) CastStopMessage or (CastName ' ' CastTarget:Paren)]",
			attach_to = "CastBar",
			location = "left",
		},
		[L["Cast time"]] = {
			code = "[if not CastStopDuration then Concatenate(CastIsChanneling ? '-' ! '+', CastDelay:Abs:Round(1):Hide(0)):Red ' ' [CastEndDuration >= 0 ? '%.1f':Format(CastEndDuration)]]",
			attach_to = "CastBar",
			location = "right",
		},
		[L["Experience"]] = {
			code = "[FractionalXP] [PercentXP:Percent:Paren] [Concatenate('R: ', PercentRestXP:Hide(0):Percent)]",
			attach_to = "ExperienceBar",
			location = "center",
		},
		[L["Threat"]] = {
			code = "[PercentThreat:Round(1):Hide(0):Percent]",
			attach_to = "ThreatBar",
			location = "center",
		},
		[L["Druid mana"]] = {
			code = "[if not IsMana then FractionalDruidMP]",
			attach_to = "DruidManaBar",
			location = "right",
		},
		[L["PVPTimer"]] = {
			code = "[PvPDuration:FormatDuration:Red]",
			location = "out_right_top",
		}
	} do
		local text_db = texts[name]
		text_db.exists = true
		for k, v in pairs(data) do
			text_db[k] = v
		end
	end
end

local PROVIDED_CODES = function() return {
	[L["Class"]] = {
		[L["Standard"]]            = "[Classification] [Level:DifficultyColor] [(if (IsPlayer or (IsEnemy and not IsPet)) then Class):ClassColor] [DruidForm:Paren] [SmartRace]",
		[L["Player classes only"]] = "[Classification] [Level:DifficultyColor] [(if IsPlayer then Class):ClassColor] [DruidForm:Paren] [SmartRace]",
		[L["Short level and race"]]               = "[(Level (if Classification then '+')):DifficultyColor] [SmartRace]",
		[L["Short"]] = "[(if IsPlayer then Class):ClassColor]",
	},
	[L["Health"]] = {
		[L["Absolute"]]       = "[Status or FractionalHP]",
		[L["Absolute short"]] = "[Status or FractionalHP:Short]",
		[L["Difference"]]     = "[Status or -MissingHP:Hide(0)]",
		[L["Percent"]]        = "[Status or PercentHP:Percent]",
		[L["Mini"]]           = "[HP:VeryShort]",
		[L["Smart"]]          = "[Status or (if IsFriend then MissingHP:Hide(0):Short:Color('ff7f7f') else FractionalHP:Short)]",
		[L["Absolute and percent"]]  = "[Status or (FractionalHP:Short ' || ' PercentHP:Percent)]",
		[L["Informational"]]  = "[Status or (Concatenate((if IsFriend then MissingHP:Hide(0):Short:Color('ff7f7f')), ' || ') FractionalHP:Short ' || ' PercentHP:Percent)]",
	},
	[L["Name"]] = {
		[L["Standard"]]             = "[Name] [(AFK or DND):Angle]",
		[L["Hostility-colored"]]    = "[Name:HostileColor] [(AFK or DND):Angle]",
		[L["Class-colored"]]        = "[Name:ClassColor] [(AFK or DND):Angle]",
		[L["Long"]]                 = "[Level] [Name:ClassColor] [(AFK or DND):Angle]",
		[L["Long w/ Druid form"]]   = "[Level] [Name:ClassColor] [DruidForm:Paren] [(AFK or DND):Angle]",
	},
	[L["Power"]] = {
		[L["Absolute"]]       = "[if HasMP then FractionalMP]",
		[L["Absolute short"]] = "[if HasMP then FractionalMP:Short]",
		[L["Difference"]]     = "[-MissingMP]",
		[L["Percent"]]        = "[PercentMP:Percent]",
		[L["Absolute and percent"]]  = "[if HasMP then FractionalMP] || [PercentMP:Percent]",
		[L["Mini"]]           = "[if HasMP then MP:VeryShort]",
		[L["Smart"]]          = "[MissingMP:Hide(0):Short:Color('7f7fff')]",
	},
	[L["Druid mana"]] = {
		[L["Absolute"]]       = "[if not IsMana then FractionalDruidMP]",
		[L["Absolute short"]] = "[if not IsMana then FractionalDruidMP:Short]",
		[L["Difference"]]     = "[if not IsMana then -MissingDruidMP]",
		[L["Percent"]]        = "[if not IsMana then PercentDruidMP:Percent]",
		[L["Mini"]]           = "[if not IsMana then DruidMP:VeryShort]",
		[L["Smart"]]          = "[if not IsMana then MissingDruidMP:Hide(0):Short:Color('7f7fff')]",
	},
	[L["Threat"]] = {
		[L["Percent"]]            = "[PercentThreat:Round(1):Hide(0):Percent]",
		[L["Raw percent"]]         = "[RawPercentThreat:Round(1):Hide(0):Percent]",
		[L["Colored percent"]]    = "[PercentThreat:Round(1):Hide(0):Percent:ThreatStatusColor(ThreatStatus)]",
		[L["Colored raw percent"]] = "[RawPercentThreat:Round(1):Hide(0):Percent:ThreatStatusColor(ThreatStatus)]",
	},
	[L["Cast"]] = {
		[L["Standard name"]] = "[Alpha((-CastStopDuration or 0) + 1) CastStopMessage or (CastName ' ' CastTarget:Paren)]",
		[L["Standard time"]] = "[if not CastStopDuration then Concatenate(CastIsChanneling ? '-' ! '+', CastDelay:Abs:Round(1):Hide(0)):Red ' ' [CastEndDuration >= 0 ? '%.1f':Format(CastEndDuration)]]",
	},
	[L["Combo points"]] = {
		[L["Standard"]]       = "[Combos:Hide(0)]",
	},
	[L["Experience"]] = {
		[L["Standard"]]       = "[FractionalXP] [PercentXP:Percent:Paren] [Concatenate('R: ', PercentRestXP:Hide(0):Percent)]",
		[L["On mouse-over"]]       = "[if IsMouseOver then FractionalXP ' ' PercentXP:Percent:Paren ' ' Concatenate('R: ', PercentRestXP:Hide(0):Percent)]",
	},
	[L["Reputation"]] = {
		[L["Standard"]]       = "[if IsMouseOver then ReputationName else if ReputationName then FractionalReputation ' ' PercentReputation:Percent:Paren]"
	},
	[L["PVPTimer"]] = {
		[L["Standard"]]       = "[PvPDuration:FormatDuration:Red]"
	},
} end

local function run_first()
	run_first = nil
	LibDogTag = LibStub("LibDogTag-3.0", true)
	if not LibDogTag then
		LoadAddOn("LibDogTag-3.0")
		LibDogTag = LibStub("LibDogTag-3.0", true)
		if not LibDogTag then
			error("PitBull4_DogTagTexts requires LibDogTag-3.0 to function.")
		end
	end
	local LibDogTag_Unit = LibStub("LibDogTag-Unit-3.0", true)
	if not LibDogTag_Unit then
		LoadAddOn("LibDogTag-Unit-3.0")
		LibDogTag_Unit = LibStub("LibDogTag-Unit-3.0", true)
		if not LibDogTag_Unit then
			error("PitBull4_DogTagTexts requires LibDogTag-Unit-3.0 to function.")
		end
	end
end

local unit_kwargs = setmetatable({}, {__mode='kv', __index=function(self, unit)
	self[unit] = { unit = unit }
	return self[unit]
end})

-- this will replace the normal :AddFontString
function PitBull4_DogTagTexts:_AddFontString(frame, font_string, name, data)
	local unit = frame.unit
	if frame.force_show and not frame.guid and (name ~= L["Name"] or not unit) then
		LibDogTag:RemoveFontString(font_string)
		texts[font_string] = nil
		font_string:SetFormattedText("[%s]",name)
	elseif texts[font_string] and font_string.unit == unit then
		-- Text is already set.  Don't actually do anything.  Since LibDogTag will
		-- handle all updates.  If a config change happens the config system removes
		-- the texts before rebuilding them.
		return true
	else
		font_string.unit = unit
		LibDogTag:AddFontString(
			font_string,
			frame,
			data.code,
			"Unit",
			unit_kwargs[unit])
		texts[font_string] = true
	end
	return true
end

function PitBull4_DogTagTexts:AddFontString(...)
	if run_first then
		run_first()
	end
	
	self.AddFontString = self._AddFontString
	self._AddFontString = nil
	
	return PitBull4_DogTagTexts:AddFontString(...)
end

function PitBull4_DogTagTexts:RemoveFontString(font_string)
	LibDogTag:RemoveFontString(font_string)
	texts[font_string] = nil
end

-- Handle updating after a config change
local function update()
	local layout = PitBull4.Options.GetCurrentLayout()

	for frame in PitBull4:IterateFramesForLayout(layout) do
		PitBull4_DogTagTexts:ForceTextUpdate(frame)
	end
end

PitBull4_DogTagTexts:SetLayoutOptionsFunction(function(self)
	local values = {}
	local value_key_to_code = {}
	values[""] = L["Custom"]
	value_key_to_code[""] = ""
	for base, codes in pairs(PROVIDED_CODES()) do
		for name, code in pairs(codes) do
			local key = ("%s: %s"):format(base, name)
			values[key] = key
			value_key_to_code[key] = code
		end
	end
	PROVIDED_CODES = nil
	local provided_codes_cleaned = false
	return 'default_codes', {
		type = 'select',
		name = L["Code"],
		desc = L["Some codes provided for you."],
		get = function(info)
			local code = PitBull4.Options.GetTextLayoutDB().code
			if LibDogTag then
				code = LibDogTag:CleanCode(code)
			end
			if not provided_codes_cleaned and LibDogTag then
				provided_codes_cleaned = true
				for k, v in pairs(value_key_to_code) do
					value_key_to_code[k] = LibDogTag:CleanCode(v)
				end
			end
			for k, v in pairs(value_key_to_code) do
				if v == code then
					return k
				end
			end
			return ""
		end,
		set = function(info, value)
			PitBull4.Options.GetTextLayoutDB().code = value_key_to_code[value]
			
			update()	
		end,
		values = values,
		disabled = function(info)
			if run_first then
				run_first()
			end
			return not LibDogTag
		end,
		width = 'double',
	}, 'code', {
		type = 'input',
		name = L["Code"],
		desc = L["Enter a LibDogTag-3.0 code tag. You can type /dog into your chat for help."],
		get = function(info)
			local code = PitBull4.Options.GetTextLayoutDB().code
			
			if run_first then
				run_first()
			end
			
			if LibDogTag then
				code = LibDogTag:CleanCode(code)
			end
			
			return code
		end,
		set = function(info, value)
			PitBull4.Options.GetTextLayoutDB().code = LibDogTag:CleanCode(value)
			
			update()	
		end,
		multiline = true,
		width = 'full',
		disabled = function(info)
			if run_first then
				run_first()
			end
			return not LibDogTag
		end,
	}, 'help', {
		type = 'execute',
		name = L["DogTag help"],
		desc = L["Click to pop up helpful DogTag documentation."],
		func = function()
			if run_first then
				run_first()
			end
			LibDogTag:OpenHelp()
		end,
		disabled = function(info)
			if run_first then
				run_first()
			end
			return not LibDogTag
		end,
	}
end)
