local MAJOR_VERSION = "LibDogTag-Unit-3.0"
local MINOR_VERSION = 90000 + tonumber(("$Revision: 161 $"):match("%d+")) or 0

if MINOR_VERSION > _G.DogTag_Unit_MINOR_VERSION then
	_G.DogTag_Unit_MINOR_VERSION = MINOR_VERSION
end

DogTag_Unit_funcs[#DogTag_Unit_funcs+1] = function(DogTag_Unit, DogTag)

local L = DogTag_Unit.L

DogTag:AddTag("Unit", "Reputation", {
	code = function(faction)
		if not faction then
			local _, _, min, _, value = GetWatchedFactionInfo()
			return value - min
		else
			for i = 1, GetNumFactions() do
				local name, _, _, min, _, value = GetFactionInfo(i)
				if faction == n then
					return value - min
				end
			end
		end
	end,
	arg = {
		'faction', 'string;undef', "@undef"
	},
	ret = "number;nil",
	events = "UNIT_FACTION#player;UPDATE_FACTION",
	doc = L["Return the current reputation of the watched faction or specified"],
	example = ('[Reputation] => "1234"; [Reputation(%s)] => "2345"'):format(L["Exodar"]),
	category = L["Reputation"]
})

DogTag:AddTag("Unit", "MaxReputation", {
	code = function(faction)
		if not faction then
			local _, _, min, max = GetWatchedFactionInfo()
			return max - min
		else
			for i = 1, GetNumFactions() do
				local name, _, _, min, max = GetFactionInfo(i)
				if faction == n then
					return max - min
				end
			end
		end
	end,
	arg = {
		'faction', 'string;undef', "@undef"
	},
	ret = "number;nil",
	events = "UNIT_FACTION#player;UPDATE_FACTION",
	doc = L["Return the maximum reputation of the watched faction or specified"],
	example = ('[MaxReputation] => "12000"; [MaxReputation(%s)] => "21000"'):format(L["Exodar"]),
	category = L["Reputation"]
})

DogTag:AddTag("Unit", "FractionalReputation", {
	alias = [=[Concatenate(Reputation(faction=faction), "/", MaxReputation(faction=faction))]=],
	arg = {
		'faction', 'string;undef', "@undef"
	},
	doc = L["Return the current and maximum reputation of the currently watched faction or argument"],
	example = ('[FractionalReputation] => "1234/12000"; [FractionalReputation(%s)] => "2345/21000"'):format(L["Exodar"], L["Exodar"], L["Exodar"]),
	category = L["Reputation"]
})

DogTag:AddTag("Unit", "PercentReputation", {
	alias = [=[(Reputation(faction=faction)/MaxReputation(faction=faction)*100):Round(1)]=],
	arg = {
		'faction', 'string;undef', "@undef"
	},
	doc = L["Return the percentage reputation of the currently watched faction or argument"],
	example = ('[PercentReputation] => "10.3"; [PercentReputation:Percent] => "10.3%%"; [PercentReputation(%s)] => "11.2"; [PercentReputation(%s):Percent] => "11.2%%"'):format(L["Exodar"], L["Exodar"]),
	category = L["Reputation"]
})

DogTag:AddTag("Unit", "MissingReputation", {
	alias = [=[MaxReputation(faction=faction) - Reputation(faction=faction)]=],
	arg = {
		'faction', 'string;undef', "@undef"
	},
	doc = L["Return the missing reputation of the currently watched faction or argument"],
	example = ('[MissingReputation] => "10766"; [MissingReputation(%s)] => "18655"'):format(L["Exodar"]),
	category = L["Reputation"]
})

DogTag:AddTag("Unit", "ReputationName", {
	code = function()
		return GetWatchedFactionInfo()
	end,
	ret = "string;nil",
	events = "UNIT_FACTION#player;UPDATE_FACTION",
	doc = L["Return the name of the currently watched faction"],
	example = ('[ReputationName] => %q'):format(L["Exodar"]),
	category = L["Reputation"]
})

DogTag:AddTag("Unit", "ReputationReaction", {
	code = function(faction)
		if not faction then
			local _, reaction = GetWatchedFactionInfo()
			return _G["FACTION_STANDING_LABEL" .. reaction]
		else
			for i = 1, GetNumFactions() do
				local name, _, reaction = GetFactionInfo(i)
				if faction == name then
					return _G["FACTION_STANDING_LABEL" .. reaction]
				end
			end
		end
	end,
	arg = {
		'faction', 'string;undef', "@undef",
	},
	ret = "string;nil",
	events = "UNIT_FACTION#player;UPDATE_FACTION",
	doc = L["Return your current reputation rank with the watched faction or argument"],
	example = ('[ReputationReaction] => %q; [ReputationReaction(%s)] => %q'):format(_G.FACTION_STANDING_LABEL5, "Exodar", _G.FACTION_STANDING_LABEL6),
	category = L["Reputation"]
})

DogTag:AddTag("Unit", "ReputationColor", {
	code = function(value, faction)
		local _, name, reaction
		if not faction then
			name, reaction = GetWatchedFactionInfo()
		else
			for i = 1, GetNumFactions() do
				local n
				n, _, reaction = GetFactionInfo(i)
				if faction == n then
					name = n
					break
				end
			end
		end
		if name then
			local color = FACTION_BAR_COLORS[reaction]
			if value then
				return ("|cff%02x%02x%02x%s|r"):format(color.r * 255, color.g * 255, color.b * 255, value)
			else
				return ("|cff%02x%02x%02x"):format(color.r * 255, color.g * 255, color.b * 255)
			end
		else
			return value
		end
	end,
	arg = {
		'value', 'string;undef', '@undef',
		'faction', 'string;undef', "@undef",
	},
	ret = "string;nil",
	events = "UNIT_FACTION#player;UPDATE_FACTION",
	doc = L["Return the color or wrap value with the color associated with either the currently watched faction or the given argument"],
	example = ('["Hello":ReputationColor] => "|cff7f0000Hello|r"; ["Hello":ReputationColor(%s)] => "|cff007f00Hello|r"; [ReputationColor(faction=%s) "Hello")] => "|cff007f00Hello"'):format(L["Exodar"], L["Exodar"]),
	category = L["Reputation"]
})

end
