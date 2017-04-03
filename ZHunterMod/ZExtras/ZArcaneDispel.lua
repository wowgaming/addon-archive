local failure = "|cffff2020Failed|r to dispel %s's |cff20ff20%s|r!"
local desiredSpells = {}
local channels = {"yell", "raidWarning", "raid", "party", "channel"}

function ZArcaneDispelParse(spells)
	if not spells then return end
	for i in pairs(desiredSpells) do
		desiredSpells[i] = nil
	end
	for i, v in pairs({strsplit("\n", spells)}) do
		desiredSpells[v] = true
	end
end

function ZArcaneDispel(destName, extraSpellName, failed)
	-- Grab a local copy of the options
	local tbl = ZHunterMod_Saved["ZArcaneDispel"]
	-- Setup and broadcast the message
	if not failed then
		local message = tbl.format or ">$spell< dispelled from $player"
		local newmessage
		newmessage = message:gsub("$player", destName)
		newmessage = newmessage:gsub("$spell", extraSpellName)
		local channelNum = tbl.channelNum
		for i, v in ipairs(channels) do
			if tbl[v] or (tbl[v] == nil and desiredSpells[extraSpellName]) then
				ZHunter[v](newmessage, channelNum)
			end
		end
		if tbl.print or (tbl.print == nil and desiredSpells[extraSpellName]) then
			newmessage = message:gsub("$player", destName)
			newmessage = newmessage:gsub("$spell", "|cFF20FF20"..extraSpellName.."|r")
			ZHunter.print(newmessage)
		end
	elseif tbl.print or (tbl.print == nil and desiredSpells[extraSpellName]) then
		ZHunter.print(failure:format(destName, extraSpellName))
	end
end

ZHunterModOptions.args.arcanedispel = {
	type = "group",
	name = "Tranq Dispel",
	desc = "Options to customize the Dispel message from Tranquilizing Shot.",
	order = 7,
	args = {
		description = {
			type = "description",
			name = "Use the gray check to only broadcast when the spell is from the list below.",
			order = 1
		},
		format = {
			type = "input",
			name = "Message",
			desc = "Change the format of the broadcast message. Use '$spell' and '$player' to print which spell was dispelled and from which player.",
			order = 2,
			get = function(info) return ZHunterMod_Saved["ZArcaneDispel"]["format"] end,
			set = function(info, v) ZHunterMod_Saved["ZArcaneDispel"]["format"] = v end
		},
		condition = {
			type = "input",
			name = "Spells To Show",
			desc = "List the spells that you want to broadcast when they are dispelled (case sensitive).",
			multiline = true,
			order = 20,
			get = function(info) return ZHunterMod_Saved["ZArcaneDispel"]["condition"] end,
			set = function(info, v)
				ZHunterMod_Saved["ZArcaneDispel"]["condition"] = v
				ZArcaneDispelParse(v)
			end
		}
	}
}

ZHunterModOptions_SetBroadcastOptions("ZArcaneDispel", ZHunterModOptions.args.arcanedispel.args)